-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/RogueFightJudgeHandler.lua

module("logic.extensions.roguelike.flow.component.handler.RogueFightJudgeHandler", package.seeall)

local M = class("RogueFightJudgeHandler", IRogueJudgeHandler)
local PATTERN = RoguelikeConst.DICE_PATTERN

function M:getExtraResult()
	local result
	local bigSuccess = 0
	local bigFail = 0
	local trigger, params = RogueMgr.instance:getRogueFlow().model:getConditionEffect("BigSuccessAddition")
	local addition = 0

	if trigger then
		addition = tonumber(params)
	end

	addition = addition + RoguelikeModel.instance:getBigSuccessAdd()

	if math.random(1, 1000) < bigSuccess + addition then
		result = RoguelikeConst.ROGUE_EXTRA_TYPE.BIG_SUCCESS

		self._mgr.flow.model:setExtraResult(result)

		return result
	end

	if bigFail > math.random(1, 1000) then
		result = RoguelikeConst.ROGUE_EXTRA_TYPE.BIG_FAIL

		self._mgr.flow.model:setExtraResult(result)

		return result
	end

	return result
end

function M:getPlayerMatchDiceId()
	local index = #self._mgr._curRoundMatchPlayerDice
	local diceId = self._mgr._curRoundMatchPlayerDice[index]

	table.remove(self._mgr._curRoundMatchPlayerDice, index)

	return diceId
end

function M:judgeDice()
	self._isJudged = true

	local monsterProp = self._mgr.flow.model:getCurMonster().monsterProp
	local roleProp = self._mgr.flow.model:getCurRoleMo()
	local extraResult = self._mgr.flow.model:getExtraResult()
	local judgeModel = self._mgr.flow.judgeModel
	local isMonsterAttack = judgeModel:getMonsterActionIsTakeDamage()

	if extraResult == RoguelikeConst.ROGUE_EXTRA_TYPE.BIG_SUCCESS then
		for idx2, dice2 in ipairs(self._mgr._curRoundCombatDice) do
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_MATCH_DICE, 0, dice2:getId(), RoguelikeConst.DICE_MATCH_TYPE.DICE_WALL)
		end

		self._mgr._curRoundCombatDice = {}

		self._mgr.flow.model:setExtraResult(nil)
		self:saveJudgeArchive(true)
		monsterProp:reduceHp(10)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_MONSTER_HP_ANI, monsterProp:getId(), 1)

		if monsterProp:getHp() <= 0 then
			self._mgr.flow.model:setRoundFinish(true)
			self._mgr.flow.model:setJudgeResult(true)
			self:execSuccessEffect(monsterProp)
		end

		RogueMgr.instance:getModel():getCurRoleSpine():play(RoguelikeConst.ROGUE_MONSTER_ANI.SKILL, false, true)
	elseif extraResult == RoguelikeConst.ROGUE_EXTRA_TYPE.BIG_FAIL then
		local dice = RogueDiceMo.New(RoguelikeConst.ROGUE_DICE_TYPE.COMBAT)
		local index = dice:getRandomUpIndex()

		dice:setUpIndex(self._mgr:getCombatDiceFeatures())
		table.insert(self._mgr._curRoundCombatDice, dice)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ADD_EXTRA_COMBAT_DICE, dice, #self._mgr._curRoundCombatDice)
		self._mgr.flow.model:setExtraResult(nil)
	end

	local curRoundMatchCount = 0

	self._mgr._curRoundMatchCombatDice = {}
	self._mgr._curRoundMatchPlayerDice = {}
	self._mgr._curRoundPatternBroadcasts = {}

	function matchDice()
		for idx, dice1 in ipairs(self._mgr._curRoundPlayerDice) do
			local specialPatterns = dice1:getSpecialPatterns()

			if #specialPatterns > 0 then
				local result, isBreak = self:matchSpecialPattern(specialPatterns, idx)

				curRoundMatchCount = curRoundMatchCount + result

				if result > 0 or isBreak then
					return true
				end
			end

			if dice1:getIsNormal() or dice1:getUpPatternType() == RoguelikeConst.DICE_PATTERN.NORMAL then
				curRoundMatchCount = curRoundMatchCount + dice1:getPatternLevel()

				table.insert(self._mgr._curRoundMatchPlayerDice, dice1:getId())
				table.remove(self._mgr._curRoundPlayerDice, idx)

				return true
			end
		end

		return false
	end

	local matchTime = 0

	while matchDice() and matchTime < 30 do
		matchTime = matchTime + 1
	end

	for k, v in pairs(self._mgr._curRoundPatternBroadcasts) do
		local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Extra_Face_Effect")
		local msg = string.format(format, string.format(RoguelikeConfig.getBroadCast("Role_Throw_Extra_Pattern"), RogueMgr.instance:getModel():getCurRoleMo():getName() .. "[head" .. RogueMgr.instance:getModel():getCurRoleMo():getModelId() .. "|32]"), string.format(v.content, v.count))

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)
	end

	local actionCo = judgeModel:getRoleSelectActionCo()
	local roleIndex = RogueMgr.instance:getModel():getCurRoleIndex()
	local actionCardBase = RoguelikeModel.instance:getCardAttrBase(actionCo.attr, roleIndex)
	local actionBase = actionCo.base + actionCardBase
	local actionCardRate = RoguelikeModel.instance:getCardAttrRate(actionCo.attr, roleIndex) / 10

	curRoundMatchCount = curRoundMatchCount + judgeModel:execCardEntries(RoguelikeConst.CARD_ENTRY_EFFECT_TIME.DICE_RESULT, self)

	local matchCountOrigin = curRoundMatchCount

	curRoundMatchCount = curRoundMatchCount * (1 + actionCardRate)

	local cd = actionCo.cd < 0 and actionCo.cd * -1 - matchCountOrigin or actionCo.cd

	cd = math.max(cd, 0)

	if cd ~= 0 then
		RoguelikeAgent.instance:sendSetCardCdRequest(roleProp:getRoleId(), judgeModel:getRoleSelectActionIndex(), cd + 1)
	end

	local clientPrograms = judgeModel:getCurRoleActionClientProgram(actionCo.id)

	for k, v in pairs(clientPrograms) do
		local handler = RogueMgr.instance:getRogueFlow().judgeMgr:getRoleActionHandler(v)

		if handler then
			handler:execAction(self, matchCountOrigin, curRoundMatchCount, actionBase)
		end
	end

	if judgeModel:execCardEntries(RoguelikeConst.CARD_ENTRY_EFFECT_TIME.AFTER_ACTION, self) > 0 then
		for k, v in pairs(clientPrograms) do
			local handler = RogueMgr.instance:getRogueFlow().judgeMgr:getRoleActionHandler(v)

			if handler then
				handler:execAction(self, matchCountOrigin, curRoundMatchCount, actionBase)
			end
		end
	end

	judgeModel:execCardEntries(RoguelikeConst.CARD_ENTRY_EFFECT_TIME.JUDGE_RESULT, self)

	if monsterProp:getHp() <= 0 then
		RoguelikeAgent.instance:sendEndRoundRequest()
		self._mgr.flow.model:setRoundFinish(true)
		self._mgr.flow.model:setJudgeResult(true)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_MONSTER_COMBAT_END)

		local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Monster_Death")
		local msg = string.format(format, monsterProp:getName())

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)
		self:execSuccessEffect(monsterProp)

		return false
	end

	if self._mgr.flow.model:checkIsLastOne() then
		RogueMgr.instance:getRogueFlow().judgeMgr:setNeedNewFeature(true)

		local effectHp

		if RogueMgr.instance:getIsClientMode() then
			self:execAttack(monsterProp, monsterProp:getAttackType())
		else
			local attackValue = #self._mgr._curRoundCombatDice

			RogueBroadcastModel.instance:addMoByMonsterAttack(monsterProp:getId())

			if isMonsterAttack then
				local attack = RogueMgr.instance:getRogueFlow().judgeModel:getMonsterAttack()

				attackValue = attack - RogueMgr.instance:getRogueFlow().judgeModel:getRoleDiceWall()

				if attackValue > 0 then
					self._mgr.flow.stateMgr:setEnemyAttack(attackValue, RogueMgr.instance:getRogueFlow().judgeModel:getRoleDiceWall())
					self._mgr.flow.stateMgr:setEnemyAttackCallback(function()
						local effectIds = RogueMgr.instance:getRogueFlow().judgeMgr:getCombatActionEffectId()

						if effectIds ~= nil and effectIds ~= 0 and #effectIds > 0 then
							for k, v in pairs(effectIds) do
								local effectCo = RoguelikeConfig.instance:getEffectById(v)

								if effectCo.clientProgram ~= "" and RogueBuffClsUtil.getHandlerCls(effectCo.clientProgram) then
									local buffMo = RogueBuffMo.New(effectCo, {})

									if buffMo:getBuffHandler() ~= nil then
										if string.find(effectCo.params, "#") then
											local effectId = string.split(effectCo.params, "#")

											effectId = RoguelikeConfig.instance:getConstEffect(effectId[1])

											buffMo:getBuffHandler():onEffectTrigger(attackValue, effectId)
										else
											local effectId = RoguelikeConfig.instance:getConstEffect(effectCo.params)

											buffMo:getBuffHandler():onEffectTrigger(attackValue, effectId)
										end

										buffMo = nil
									end
								end
							end

							RoguelikeController.instance:execEffectIds(effectIds)

							effectHp = self:getEffectHp(effectIds)
						end

						local format, isTitle = RoguelikeConfig.getBroadCast("Monster_Attack_Count"), false
						local msg = string.format(format, " [" .. monsterProp:getHeadIcon() .. "|32] ", attackValue)

						GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)
					end)
				else
					local format, isTitle = RoguelikeConfig.getBroadCast("Monster_Attack_Be_Defense"), false
					local msg = string.format(format, " [" .. monsterProp:getHeadIcon() .. "|32]")

					GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)
				end
			end
		end

		self._mgr.flow.model:setInAttack(true)

		local count = 0

		for k, v in pairs(self._mgr._curRoundCombatDice) do
			if v:getDiceType() == 1 then
				count = count + 1
			end
		end

		if #self._mgr._curRoundCombatDice > 0 then
			count = effectHp ~= nil and effectHp or count

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_MONSTER_TAKE_DAMAGE, count)
		end

		self._mgr._curRoundCombatDice = {}

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_END)

		if monsterProp:getHp() <= 0 then
			self._mgr.flow.model:setRoundFinish(true)
			self._mgr.flow.model:setJudgeResult(true)
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_MONSTER_COMBAT_END)

			local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Monster_Death")
			local msg = string.format(format, monsterProp:getName())

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)
			self:execSuccessEffect(monsterProp)

			return false
		end

		RoguelikeAgent.instance:sendEndRoundRequest()
		self._mgr.flow.stateMgr:addRoundIndex()
	end

	return true
end

function M:getEffectHp(effectIds)
	local totalHp = 0
	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()
	local roleCount = 0

	for i = 1, #allRoles do
		if not allRoles[i].roleProp:getIsDeath() then
			roleCount = roleCount + 1
		end
	end

	for k, v in pairs(effectIds) do
		local effectCo = RoguelikeConfig.instance:getEffectById(v)

		if effectCo and effectCo.program == "AddAttribute" then
			local all = string.find(effectCo.params, "ALL")
			local strList = string.split(effectCo.params, "#")
			local attrIndex = tonumber(strList[2])

			if attrIndex == 6 then
				if all then
					totalHp = totalHp + math.abs(tonumber(strList[3])) * roleCount
				else
					totalHp = totalHp + math.abs(tonumber(strList[3]))
				end
			elseif attrIndex == 8 then
				-- block empty
			end
		end
	end

	return totalHp
end

function M:skipJudge(isWin, callback)
	if isWin then
		local monsterProp = self._mgr.flow.model:getCurMonster().monsterProp

		self:execSuccessEffect(monsterProp, callback)
	end
end

function M:execSuccessEffect(monsterProp, callback)
	if not RogueMgr.instance:getIsClientMode() then
		local effectIds = monsterProp:getSuccessEffectId()

		RogueMgr.instance:getRogueFlow().model:setInSettlement(true)
	elseif callback ~= nil then
		callback()
	end
end

function M:execAttack(monsterProp, attackType)
	return
end

function M:saveJudgeArchive(isJudged, isIgnoreQuick)
	if RogueMgr.instance:getIsClientMode() or not self._mgr.flow.model:getCurMonster() then
		return
	end

	if isJudged then
		RogueMgr.instance:getStateMgr():syncExtraPatterns()
	end

	local type = self._mgr.flow.model:getCurEventType()
	local roomId = RoguelikeModel.instance:getCurRoomId()
	local monsterProp = self._mgr.flow.model:getCurMonster().monsterProp
	local enemyId = monsterProp:getId()
	local eventId = RogueMgr.instance:getModel():getCurEventId()
	local enemyOuterHp = monsterProp:getHp()
	local combatDices = self._mgr._curRoundCombatDice
	local hadAttack, params = RogueMgr.instance:getRogueFlow().judgeModel:getMonsterActionIsTakeDamage()
	local damage = hadAttack and RogueMgr.instance:getRogueFlow().judgeModel:getMonsterAttackDamage(params, true) or 0
	local enemyInnerHp = damage
	local round = self._mgr.flow.stateMgr:getRoundIndex()
	local heroId = self._mgr.flow.model:getCurRoleMo():getRoleId()
	local monsterDiceFaceNO = RoguelikeExtension_pb.FaceNO()
	local pattern = self._mgr:getCombatDiceFeatures()

	if RoguelikeUtil.instance:convertCAttrType2SType(pattern) ~= nil then
		monsterDiceFaceNO.face = RoguelikeUtil.instance:convertCAttrType2SType(pattern)
		monsterDiceFaceNO.num = #combatDices
	end

	local enemyFace = monsterDiceFaceNO
	local selectedAttr = pattern
	local roleDices = self._mgr._curRoundPlayerDice
	local curDiceRoleId = self._mgr:getCurDiceRoleId()
	local selfFaces = curDiceRoleId == heroId and roleDices or {}
	local featureDiceIndex = RogueMgr.instance:getRogueFlow().judgeMgr:getFeatureIndex()
	local featureDicePatterns = RogueMgr.instance:getRogueFlow().judgeMgr:getFeaturePatterns()
	local totalFaces = RogueMgr.instance:getStateMgr():getTotalExtraFaces()
	local tmpExtraFaces = RogueMgr.instance:getStateMgr():getTmpExtraFaces()
	local clientRoundFaces = RogueMgr.instance:getStateMgr():getClientRoundFaces()
	local clientFaces = RogueMgr.instance:getStateMgr():getClientFaces()
	local archiveNO = RoguelikeAgent.instance:generateArchive(type, roomId, enemyId, enemyOuterHp, enemyInnerHp, round, heroId, enemyFace, selectedAttr, selfFaces, isJudged, eventId, featureDiceIndex, featureDicePatterns, totalFaces, tmpExtraFaces, clientRoundFaces, clientFaces)

	RoguelikeAgent.instance:sendJudgeArchiveRequest(archiveNO, isIgnoreQuick)
end

return M

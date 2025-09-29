-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/handler/IRogueJudgeHandler.lua

module("logic.extensions.roguelike.flow.component.handler.IRogueJudgeHandler", package.seeall)

local M = class("IRogueJudgeHandler")
local PATTERN = RoguelikeConst.DICE_PATTERN

function M:ctor(mgr)
	self._mgr = mgr
end

function M:getExtraResult()
	return nil
end

function M:saveJudgeArchive(isJudged)
	return
end

function M:judgeDice()
	return
end

function M:skipJudge(isWin, callback)
	return
end

function M:execClientEffects(effectIds, count, roleId)
	if effectIds ~= nil and effectIds ~= 0 and #effectIds > 0 then
		for k, v in pairs(effectIds) do
			local effectCo = RoguelikeConfig.instance:getEffectById(v)

			if effectCo.clientProgram ~= "" and RogueBuffClsUtil.getHandlerCls(effectCo.clientProgram) then
				local buffMo = RogueBuffMo.New(effectCo, {})

				if buffMo:getBuffHandler() ~= nil then
					if string.find(effectCo.params, "#") then
						local effectId = string.split(effectCo.params, "#")

						effectId = RoguelikeConfig.instance:getConstEffect(effectId[1])

						buffMo:getBuffHandler():onEffectTrigger(count, effectId)
					else
						local effectId = RoguelikeConfig.instance:getConstEffect(effectCo.params)

						buffMo:getBuffHandler():onEffectTrigger(count, effectId)
					end

					buffMo = nil
				end
			end
		end

		RoguelikeController.instance:execEffectIds(effectIds, nil, roleId, count)
	end
end

function M:getLevelPattern(pattern, level)
	if level == 1 then
		return pattern
	end

	if pattern == PATTERN.NORMAL then
		return PATTERN.NORMAL_2 + level - 2
	end

	return PATTERN.NORMAL
end

function M:checkDicesContainPattern(dices, pattern)
	for k, v in pairs(dices) do
		local patterns = v:getPatterns()

		if TableUtil.contains(patterns, pattern) and v:getUpPattern() == pattern then
			return true, k
		end
	end

	return false
end

function M:addPatterBroadcast(pattern, content, count)
	self._mgr._curRoundPatternBroadcasts[pattern] = self._mgr._curRoundPatternBroadcasts[pattern] or {}
	self._mgr._curRoundPatternBroadcasts[pattern].content = content

	local curCount = self._mgr._curRoundPatternBroadcasts[pattern].count or 0

	self._mgr._curRoundPatternBroadcasts[pattern].count = curCount + count
end

function M:matchSpecialPattern(pattern, curDiceIdx, ignoreCheck)
	print("匹配特殊图案", #pattern)

	local dice1 = self._mgr._curRoundPlayerDice[curDiceIdx]

	if not dice1 then
		return 1
	end

	local hadMatch, matchIndex = self:checkDicesContainPattern(self._mgr._curRoundPlayerDice, PATTERN.CURSE)

	if hadMatch and not ignoreCheck then
		return self:matchSpecialPattern({
			PATTERN.CURSE
		}, matchIndex, true)
	end

	local hadMatch2, matchIndex2 = self:checkDicesContainPattern(self._mgr._curRoundPlayerDice, PATTERN.BLESSING)

	if hadMatch2 and not ignoreCheck then
		return self:matchSpecialPattern({
			PATTERN.BLESSING
		}, matchIndex2, true)
	end

	local roleProp = self._mgr.flow.model:getCurRoleMo()
	local isSilverCamp = RoguelikeModel.instance:getCampId() == GameEnum.CampEnum.SilverDawnAssociation
	local isStarCamp = roleProp:getCampId() == GameEnum.CampEnum.StarrySkyChurch

	if dice1:getSpecialType() == RoguelikeConst.SPECIAL_DICE_TYPE.BLACK then
		table.remove(self._mgr._curRoundPlayerDice, curDiceIdx)

		return 1
	end

	local isClientModel = RogueMgr.instance:getIsClientMode()

	if TableUtil.contains(pattern, PATTERN.BLESSING) and dice1:getUpPatternType() == PATTERN.BLESSING then
		local hadMatch1, matchIndex1 = self:checkDicesContainPattern(self._mgr._curRoundPlayerDice, PATTERN.CURSE)

		if hadMatch1 then
			print("祝福面诅咒面抵消")

			if matchIndex1 < curDiceIdx then
				table.remove(self._mgr._curRoundPlayerDice, curDiceIdx)
				table.remove(self._mgr._curRoundPlayerDice, matchIndex1)
			else
				table.remove(self._mgr._curRoundPlayerDice, matchIndex1)
				table.remove(self._mgr._curRoundPlayerDice, curDiceIdx)
			end

			return 1, true
		end

		for idx2, dice2 in ipairs(self._mgr._curRoundCombatDice) do
			print("祝福面消除 匹配到", dice1:getId(), dice2:getId())
			table.insert(self._mgr._curRoundMatchPlayerDice, dice1:getId())
			table.insert(self._mgr._curRoundMatchCombatDice, dice2:getId())
		end

		self._mgr._curRoundCombatDice = {}

		table.remove(self._mgr._curRoundPlayerDice, curDiceIdx)

		return 1
	elseif TableUtil.contains(pattern, PATTERN.CURSE) and dice1:getUpPatternType() == PATTERN.CURSE then
		local hadMatch1, matchIndex1 = self:checkDicesContainPattern(self._mgr._curRoundPlayerDice, PATTERN.BLESSING)

		if hadMatch1 then
			print("祝福面诅咒面抵消")

			if matchIndex1 < curDiceIdx then
				table.remove(self._mgr._curRoundPlayerDice, curDiceIdx)
				table.remove(self._mgr._curRoundPlayerDice, matchIndex1)
			else
				table.remove(self._mgr._curRoundPlayerDice, matchIndex1)
				table.remove(self._mgr._curRoundPlayerDice, curDiceIdx)
			end

			return 1, true
		end

		print("诅咒面 直接失败")
		table.remove(self._mgr._curRoundPlayerDice, curDiceIdx)

		self._mgr._curRoundPlayerDice = {}

		return 1
	elseif dice1:getUpPatternType() == PATTERN.BLEEDING then
		if not isClientModel then
			if isSilverCamp and (roleProp:getCampId() == GameEnum.CampEnum.SilverDawnAssociation or isStarCamp) and roleProp:getSan() < 0 then
				-- block empty
			else
				local effectId = dice1:getUpPatternEffect()

				self:addPatterBroadcast(dice1:getUpPatternType(), RoguelikeConfig.getBroadCast("Bleeding_Eff"), dice1:getUpPatternMatchDiceCount())
				self:execEffect(effectId)
			end
		else
			local randIndex = math.random(1, #self._mgr._curRoundPlayerDice)

			roleProp = self._mgr.flow.model:getRoleMoByIndex(randIndex)

			roleProp:reduceHp(2)
			print("流血面扣血", roleProp:getRoleId())
		end

		table.remove(self._mgr._curRoundPlayerDice, curDiceIdx)

		return 0, true
	elseif dice1:getUpPatternType() == PATTERN.TRANCE then
		if not isClientModel then
			if isSilverCamp and (roleProp:getCampId() == GameEnum.CampEnum.SilverDawnAssociation or isStarCamp) and roleProp:getSan() < 0 then
				-- block empty
			else
				local effectId = dice1:getUpPatternEffect()

				self:addPatterBroadcast(dice1:getUpPatternType(), RoguelikeConfig.getBroadCast("Trance_Eff"), dice1:getUpPatternMatchDiceCount())
				self:execEffect(effectId)
			end
		else
			local randIndex = math.random(1, #self._mgr._curRoundPlayerDice)

			roleProp = self._mgr.flow.model:getRoleMoByIndex(randIndex)

			roleProp:reduceSan(1)
			print("恍惚面扣SAN", roleProp:getRoleId())
		end

		table.remove(self._mgr._curRoundPlayerDice, curDiceIdx)

		return 0, true
	elseif dice1:getUpPatternType() == PATTERN.CRITICAL_STRIKE then
		print("暴击面生效")
		table.remove(self._mgr._curRoundPlayerDice, curDiceIdx)

		if RoguelikeModel.instance:getCampId() == GameEnum.CampEnum.OAD and (isStarCamp or roleProp:getCampId() == GameEnum.CampEnum.OAD) then
			return self:matchCombatDiceCount(3, dice1)
		end

		local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Extra_Face_Effect")
		local msg = string.format(format, RoguelikeConfig.getBroadCast("Strike_Eff"), RoguelikeConfig.getBroadCast("Strike_Eff_Desc"))

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)

		return self:matchCombatDiceCount(2, dice1)
	elseif dice1:getUpPatternType() == PATTERN.SACRIFICE then
		if not isClientModel then
			if isSilverCamp and (roleProp:getCampId() == GameEnum.CampEnum.SilverDawnAssociation or isStarCamp) and roleProp:getSan() < 0 then
				-- block empty
			else
				local effectId = dice1:getUpPatternEffect()

				self:addPatterBroadcast(dice1:getUpPatternType(), RoguelikeConfig.getBroadCast("Sacrifice_Eff"), dice1:getUpPatternMatchDiceCount())
				self:execEffect(effectId)
			end
		else
			local randIndex = math.random(1, #self._mgr._curRoundPlayerDice)

			roleProp = self._mgr.flow.model:getRoleMoByIndex(randIndex)

			roleProp:reduceHp(2)
			print("献祭面扣血", roleProp:getRoleId())
		end

		table.remove(self._mgr._curRoundPlayerDice, curDiceIdx)

		return self:matchCombatDiceCount(dice1:getUpPatternMatchDiceCount(), dice1)
	elseif dice1:getUpPatternType() == PATTERN.REDUCE_WISDOM then
		if not isClientModel then
			if isSilverCamp and (roleProp:getCampId() == GameEnum.CampEnum.SilverDawnAssociation or isStarCamp) and roleProp:getSan() < 0 then
				-- block empty
			else
				local effectId = dice1:getUpPatternEffect()

				self:addPatterBroadcast(dice1:getUpPatternType(), RoguelikeConfig.getBroadCast("Wisdom_Eff"), dice1:getUpPatternMatchDiceCount())
				self:execEffect(effectId)
			end
		else
			local randIndex = math.random(1, #self._mgr._curRoundPlayerDice)

			roleProp = self._mgr.flow.model:getRoleMoByIndex(randIndex)

			roleProp:reduceSan(1)
			print("蚀智面扣SAN", roleProp:getRoleId())
		end

		table.remove(self._mgr._curRoundPlayerDice, curDiceIdx)

		return self:matchCombatDiceCount(dice1:getUpPatternMatchDiceCount(), dice1)
	elseif dice1:getUpPatternType() == PATTERN.FATHER then
		self:execEffect(10001020)
		table.remove(self._mgr._curRoundPlayerDice, curDiceIdx)

		return self:matchCombatDiceCount(4, dice1)
	elseif dice1:getUpPatternType() == PATTERN.DAUGHTER then
		table.remove(self._mgr._curRoundPlayerDice, curDiceIdx)

		return self:matchCombatDiceCount(2, dice1)
	elseif dice1:getUpPatternType() == PATTERN.COUNTER then
		if roleProp:getCampId() ~= GameEnum.CampEnum.BrotherhoodOfTruth then
			table.remove(self._mgr._curRoundPlayerDice, curDiceIdx)

			return 1
		end

		local combatCount = #self._mgr._curRoundCombatDice
		local count = combatCount > 0 and 2 or 1

		count = combatCount == 1 and 1 or count

		table.remove(self._mgr._curRoundPlayerDice, curDiceIdx)

		return self:matchCombatDiceCount(count, dice1)
	elseif dice1:getUpPatternType() == PATTERN.DEIFY then
		if roleProp:getCampId() ~= GameEnum.CampEnum.TreeOfEden and roleProp:getCampId() ~= GameEnum.CampEnum.StarrySkyChurch then
			table.remove(self._mgr._curRoundPlayerDice, curDiceIdx)

			return 1
		end

		local deifyCount = RogueMgr.instance:getStateMgr():getAddDeifyCount()
		local allCounts = {
			1,
			2,
			3,
			4,
			5,
			5
		}
		local count = allCounts[deifyCount + 1] or allCounts[#allCounts]

		RogueMgr.instance:getStateMgr():addDeifyCount()
		table.remove(self._mgr._curRoundPlayerDice, curDiceIdx)

		return self:matchCombatDiceCount(count, dice1)
	elseif dice1:getUpPatternType() == PATTERN.NORMAL then
		table.remove(self._mgr._curRoundPlayerDice, curDiceIdx)

		return self:matchCombatDiceCount(dice1:getUpPatternMatchDiceCount(), dice1)
	end

	return 0
end

function M:getEffectDesc(effectId)
	local effectCo = RoguelikeConfig.instance:getEffectById(effectId)

	if effectCo then
		return StringUtil.replaceAllGraphicText2(effectCo.description)
	end

	return "找不到效果" .. effectId
end

function M:execEffect(effectId)
	local effectCo = RoguelikeConfig.instance:getEffectById(effectId)
	local selectable = string.find(effectCo.params, "SELECTABLE") or effectCo.program == "SelectedHeroToRiseAttribute"
	local roleId = 0

	if selectable then
		local roleProp = self._mgr.flow.model:getCurRoleMo()

		roleId = roleProp:getRoleId()
	end

	RoguelikeAgent.instance:sendTakeEffectRequest({
		effectId
	}, roleId, -1)
end

function M:matchCombatDiceCount(count, dice1)
	local combatCount = #self._mgr._curRoundCombatDice
	local judgeModel = self._mgr.flow.judgeModel
	local monsterProp = self._mgr.flow.model:getCurMonster() and self._mgr.flow.model:getCurMonster().monsterProp or nil
	local isDiceWall = judgeModel:getRoleActionIsDiceWall()
	local isAttack = judgeModel:getRoleActionIsTakeDamage()

	if combatCount <= count then
		local reduceHpCount = count - combatCount

		if isAttack then
			for k, dice2 in pairs(self._mgr._curRoundCombatDice) do
				table.insert(self._mgr._curRoundMatchCombatDice, dice2:getId())
			end

			table.insert(self._mgr._curRoundMatchPlayerDice, dice1:getId())

			return count
		elseif isDiceWall then
			return count
		end
	elseif count < combatCount then
		if isAttack then
			for i = combatCount, combatCount - count + 1, -1 do
				local dice2 = self._mgr._curRoundCombatDice[i]

				table.insert(self._mgr._curRoundMatchCombatDice, dice2:getId())
			end

			table.insert(self._mgr._curRoundMatchPlayerDice, dice1:getId())
		elseif isDiceWall then
			-- block empty
		end

		return count
	end

	return count
end

function M:getRandomTableIndex(total, count)
	local sequence = {}
	local randSequence = {}

	total = total or count

	for i = 1, total do
		table.insert(sequence, i)
	end

	local endIndex = #sequence

	total = endIndex < total and endIndex or total

	function swap(idx1, idx2)
		local temp = sequence[idx1]

		sequence[idx1] = sequence[idx2]
		sequence[idx2] = temp
	end

	for i = 1, count do
		local temp = math.random(1, endIndex)

		table.insert(randSequence, sequence[temp])
		swap(temp, endIndex)

		endIndex = endIndex - 1
	end

	return randSequence
end

function M:checkCanMatch(upPattern, otherDices)
	for i = 1, #otherDices do
		local patterns = otherDices[i]:getPatterns()

		for j = 1, #patterns do
			if patterns[j] == upPattern then
				return true, i
			end
		end
	end

	return false
end

return M

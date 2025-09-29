-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/WorkRogueJudgeDice.lua

module("logic.extensions.roguelike.flow.work.WorkRogueJudgeDice", package.seeall)

local M = class("WorkRogueJudgeDice", WorkBase)
local DiceRotateMap = {
	Vector3.New(0, 90, 90),
	Vector3.New(270, 90, 90),
	Vector3.New(180, 90, 90),
	Vector3.New(90, 90, 90),
	Vector3.New(0, 0, 0),
	(Vector3.New(0, 0, 180))
}

function M:ctor(isFight)
	M.super.ctor(self)

	self._matchList = {}
	self._isFight = isFight
	self._isExit = false
end

function M:onEnter(context)
	self:setEvent(true)

	self._hadMatchPlayerDice = false

	RogueMgr.instance:getRogueFlow().judgeMgr:saveJudgeArchive(false)
	RogueMgr.instance:getRogueFlow().shieldMgr:setCurAttackType(0)

	local judgeMgr = RogueMgr.instance:getRogueFlow().judgeMgr

	self._combatDices = judgeMgr:getCurRoundCombatDice()
	self._playerDices = judgeMgr:getCurRoundPlayerDice()
	self._dicePos = RogueMgr.instance:getRogueFlow().model:getPlayerDicePos()
	self._monsterPos = RogueMgr.instance:getMapMgr():getMapRolePos()
	self._isMatchedCombatDices = {}

	local result = judgeMgr:judgeDice()

	if not RogueMgr.instance:getNeedShowDice() then
		self:onDone(WorkResult.Succeed)
		RogueMgr.instance:getRogueFlow().stateMgr:execAttackCallback()
		self:saveJudgeArchive()

		return
	end

	if #self._matchList == 0 then
		self:checkIsFinish()
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_MONSTER_HP_ANI)
	else
		self:showMatchDiceAni()
	end
end

function M:checkIsFinish()
	local inAttack = RogueMgr.instance:getRogueFlow().model:getInAttack()

	if inAttack then
		self:checkShowAni()
	else
		self:normalEnd()
	end
end

function M:normalEnd()
	self:saveJudgeArchive()
	self:showRecoveryDiceAni()

	if RogueMgr.instance:getRogueFlow().judgeModel:getRoleDiceWall() == 0 then
		RogueMgr.instance:getRogueFlow().shieldMgr:showDestroyRoleShieldAni()
	end
end

function M:playRoleBeAttackAni(count, diceWall)
	if count <= 0 then
		return
	end

	RogueMgr.instance:getRogueFlow().shieldMgr:setCurAttackType(1)

	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()
	local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr
	local exeMap = {}
	local curCount = 0
	local calcMap = self:caleCount(exeMap, allRoles, curCount, count)
	local rolePos = RoguelikeController.instance:getRolePos()
	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE
	local attackDices = {}

	for i = 1, count + diceWall do
		local inst = diceMgr:getDiceObj(diceMgr:getMonsterAttackDiceIndex())
		local line = math.modf(i / 3)
		local offset = math.fmod(i, 3)

		if offset == 0 and line > 0 then
			line = line - 1
		end

		offset = offset == 0 and 3 or offset

		local y = (0.5 + line) * RoguelikeConst.DICE_SCALE + rolePos.y
		local z = (-(count / 2) + i) * RoguelikeConst.DICE_SCALE + rolePos.z + kMapItemSize * 1
		local pos = Vector3.New(rolePos.x + kMapItemSize * 4, y + 2, z)

		inst.transform.localPosition = Vector3.New(pos.x, pos.y + 4, pos.z)

		inst.transform:DOMove(pos, 0.5):SetEase(DG.Tweening.Ease.OutBack)
		inst.transform:DOLocalRotate(Vector3.zero, 0.4)
		goutil.setActive(inst, true)
		table.insert(attackDices, inst)
	end

	settimer(0.5, function()
		if self._isExit then
			return
		end

		local hitTime = 0.7
		local index = 1

		for k, v in pairs(calcMap) do
			local roleMo = RogueMgr.instance:getModel():getRoleMoByRoleId(k)

			if roleMo then
				for i = 1, v do
					local diceTrans = attackDices[index].transform
					local midPos = roleMo.transform._transform.position
					local hitpos = Vector3.New(midPos.x, midPos.y + 1.5, midPos.z)
					local dis = Vector3.Distance(hitpos, diceTrans.position)

					diceTrans:DOMove(hitpos, hitTime):SetEase(DG.Tweening.Ease.InQuint):OnComplete(function()
						self:showCameraShake()
					end, self)

					index = index + 1
				end

				settimer(hitTime - 0.1, function()
					roleMo.meshModel:play(RoguelikeConst.ROGUE_ROLE_ANI.HIT, false, true)
					roleMo.material:showOutlineColor("#BF0000")
					settimer(0.7, function()
						if not roleMo.roleProp:getIsDeath() then
							roleMo.meshModel:play(RoguelikeConst.ROGUE_ROLE_ANI.IDLE, true, true)
						end
					end, self, false)
				end, self, false)
			end
		end

		for i = index, #attackDices do
			local diceTrans = attackDices[i].transform
			local k = index - i + 1
			local line = math.modf(k / 5)
			local offset = math.fmod(k, 5)

			if offset == 0 and line > 0 then
				line = line - 1
			end

			offset = offset == 0 and 5 or offset

			local y = (0.5 + line) * RoguelikeConst.DICE_SCALE
			local hitpos = Vector3.New(rolePos.x + kMapItemSize * 1.5, y, (-2 + offset) * RoguelikeConst.DICE_SCALE + rolePos.z + kMapItemSize * 1)

			diceTrans:DOMove(hitpos, hitTime):SetEase(DG.Tweening.Ease.InQuint):OnComplete(function()
				self:showCameraShake()
			end, self)

			index = index + 1
		end

		settimer(hitTime, function()
			RogueMgr.instance:getRogueFlow().stateMgr:execAttackCallback()
			CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_paotuan_battle_diceattack1)
		end, self, false)
		settimer(hitTime + 0.5, function()
			for k, v in pairs(attackDices) do
				diceMgr:recoveryDiceObj(v)
			end

			self:normalEnd()
		end, self, false)
	end, self, false)
end

function M:caleCount(exeMap, allRoles, curCount, count)
	if curCount < count then
		for i = 1, #allRoles do
			local prop = allRoles[i].roleProp

			if not prop:getIsDeath() and curCount < count then
				exeMap[prop:getRoleId()] = exeMap[prop:getRoleId()] or 0
				exeMap[prop:getRoleId()] = exeMap[prop:getRoleId()] + 1
				curCount = curCount + 1
			end
		end

		if curCount < count then
			return self:caleCount(exeMap, allRoles, curCount, count)
		else
			return exeMap
		end
	end
end

function M:checkShowAni()
	RogueMgr.instance:getRogueFlow().shieldMgr:setCurAttackType(-1)

	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()

	if eventType == RoguelikeConst.ROGUE_EVENT_TYPE.SINGLE_EVENT then
		self:normalEnd()
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.MULTI_EVENT then
		self:normalEnd()
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.ENCOUNTER_EVENT then
		self:normalEnd()
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT then
		local count, diceWall = RogueMgr.instance:getRogueFlow().stateMgr:getEnemyAttack()

		if count > 0 then
			RogueMgr.instance:getRogueFlow().diceMgr:getDiceInst(function(inst)
				self:playRoleBeAttackAni(count, diceWall)
			end)

			return
		else
			RogueMgr.instance:getRogueFlow().stateMgr:execAttackCallback()
		end

		local combatDice = RogueMgr.instance:getRogueFlow().judgeMgr:getCurRoundCombatDice() or {}

		if #combatDice == 0 and false then
			local prop = RogueMgr.instance:getModel():getCurMonster().monsterProp
			local aniTime = prop:getAniTime()

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_MONSTER_ANI, RoguelikeConst.ROGUE_MONSTER_ANI.ATTACK, aniTime[1] / 1000)
			settimer(aniTime[5] / 1000, self.playRoleHitAniDelay, self, false)
			settimer(aniTime[1] / 1000 + 0.01, self.onHitAniEnd, self, false)
		else
			settimer(0.5, self.normalEnd, self, false)
		end
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.RECTIFY_EVENT then
		self:normalEnd()
	end
end

function M:showRoleOnHitAnimation(diceTrans, roleIndex, se)
	if se then
		se:Kill()

		se = nil
	end

	local roleMo = RogueMgr.instance:getModel():getAllRoleMos()[roleIndex]
	local mapMgr = RogueMgr.instance:getMapMgr()
	local pos = mapMgr:getMapRolePos()
	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE
	local midPos = Vector3.New(pos.x + kMapItemSize, 0, pos.z + 1 * kMapItemSize)
	local hitpos = Vector3.New(midPos.x, midPos.y + 1.5, midPos.z)
	local dis = Vector3.Distance(hitpos, diceTrans.position)
	local hitTime = dis / 20 * 0.3

	diceTrans:DOMove(hitpos, hitTime):SetEase(DG.Tweening.Ease.InQuint):OnComplete(function()
		self:playRoleHitAniDelay()
		self:showCameraShake()
		self:hitAfter(dice, nil, true)
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_paotuan_battle_diceattack1)
	end, self)
end

function M:showOneHitAnimation(dice1, dice2, pos, se, callback)
	if se then
		se:Kill()

		se = nil
	end

	if dice2 then
		pos = dice2:getGo().transform.position
	end

	local diceTrans = dice1:getGo().transform
	local hitpos = Vector3.New(pos.x - 0.2, pos.y, pos.z)
	local dis = Vector3.Distance(hitpos, diceTrans.position)
	local hitTime = dis / 20 * 0.1

	diceTrans:DOMove(hitpos, hitTime):SetEase(DG.Tweening.Ease.InQuint):OnComplete(function()
		self:showCameraShake()
		self:hitAfter(dice1, dice2)
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_paotuan_battle_diceattack1)

		if callback then
			callback()
		end
	end, self)
end

function M:hitAfter(dice1, dice2, isRight)
	if dice2 then
		local rigidbody = dice2:getGo():GetComponent("Rigidbody")

		rigidbody.isKinematic = true

		local diceTrans = rigidbody.gameObject.transform
		local oldPos = diceTrans.position
		local floatPos = Vector3.New(oldPos.x + 30, oldPos.y, oldPos.z)

		diceTrans:DOMove(floatPos, 0.2):SetEase(DG.Tweening.Ease.Linear)
	end

	if dice1 then
		local trigger = Astral.CollisionLuaComponentContainer.Add(dice1:getGo(), RogueDiceCompTrigger)

		if trigger then
			trigger:showColliderEffect(true)
			trigger:reset()
		end

		local flip = isRight == true and -1 or 1
		local rigidbody1 = dice1:getGo():GetComponent("Rigidbody")

		rigidbody1.isKinematic = false
		rigidbody1.useGravity = true

		local gForce = rigidbody1.gameObject:GetComponent("ConstantForce")

		if gForce then
			gForce.force = Vector3.New(0, -30, 0)
			gForce.enabled = true

			settimer(0.4, function()
				gForce.force = Vector3.New(0, -2, 0)
			end, self, false)
		end

		local vector3 = Vector3.New(math.random(-3 * flip, -2 * flip), 3.6, math.random(-2 * flip, 2 * flip))

		rigidbody1:AddForce(vector3, UnityEngine.ForceMode.Impulse)
	end
end

function M:showMatchDiceHit()
	local matchNum = #self._matchList
	local realHitNum = 0
	local intervalTime = 3
	local judgeModel = RogueMgr.instance:getRogueFlow().judgeModel
	local isDiceWall = judgeModel:getRoleActionIsDiceWall()
	local isAttack = judgeModel:getRoleActionIsTakeDamage()
	local isReduceDiceWall = judgeModel:getRoleActionIsReduceDiceWall()

	if not self._isFight then
		isDiceWall = false
		isAttack = true
	end

	if matchNum > 0 then
		for i = 1, matchNum do
			local playerDiceId = self._matchList[i].playerId
			local combatDiceId = self._matchList[i].combatId
			local matchType = self._matchList[i].matchType
			local playerDice = self:getDice(playerDiceId)
			local combatDice = self:getDice(combatDiceId)

			if playerDice then
				local se = self._rotateAnis[playerDiceId]
				local position

				if not combatDice then
					local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE

					position = Vector3.New(self._monsterPos.x + 5 * kMapItemSize, 0, self._monsterPos.z + 1.25 * kMapItemSize)
				end

				realHitNum = realHitNum + 1

				settimer(realHitNum / intervalTime, function()
					self:showOneHitAnimation(playerDice, combatDice, position, se, function()
						self:showAfterDiceFlyAni(matchType)
					end)

					if not combatDice and (not playerDice:getIsUpSpecial() or true) then
						self:playHitAniDelay()
					else
						self._isMatchedCombatDices[combatDice:getId()] = true
					end

					if se then
						se:Kill()

						se = nil
					end

					local go = playerDice:getGo()

					if go then
						local diceTrans = go.transform

						diceTrans:DOScale(Vector3.New(0, 0, 0), 1):SetEase(DG.Tweening.Ease.InOutQuint)
					end
				end, self, false)
			elseif combatDice then
				settimer(0.6, function()
					self:hitAfter(playerDice, combatDice)
				end, self, false)
			end
		end

		settimer(realHitNum + 1 / intervalTime, self.onMoveFinish, self, false)
	end
end

function M:showAfterDiceFlyAni(matchType)
	matchType = matchType or RoguelikeConst.DICE_MATCH_TYPE.DICE_WALL

	if matchType == RoguelikeConst.DICE_MATCH_TYPE.DICE_WALL then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_COMBAT_DICE_COUNT, 1)
	elseif matchType == RoguelikeConst.DICE_MATCH_TYPE.MONSTER then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_MONSTER_HP_ANI, 1)
	end
end

function M:showMatchDiceAni()
	local matchNum = #self._matchList

	if matchNum > 0 then
		self._rotateAnis = {}

		if not self._wallCollider then
			local collider = RogueMgr.instance:getRogueFlow().mapMgr:getJudgeColliderGo()

			self._wallCollider = goutil.findChild(collider, "right2"):GetComponent("BoxCollider")
		end

		self._wallCollider.enabled = false

		for i = 1, matchNum do
			local playerDiceId = self._matchList[i].playerId
			local playerDice = self:getDice(playerDiceId)

			if playerDice then
				local diceGo = playerDice:getGo()
				local rigidbody = diceGo:GetComponent("Rigidbody")

				rigidbody.isKinematic = true

				local trigger = Astral.CollisionLuaComponentContainer.Add(diceGo, RogueDiceCompTrigger)

				if trigger then
					trigger:enableTail(true)
					trigger:showSelectEffect()
				end

				local diceTrans = diceGo.transform
				local oldPos = diceTrans.position
				local floatPos = Vector3.New(oldPos.x, oldPos.y + 3.5, oldPos.z)
				local se = diceTrans:DOLocalRotate(Vector3.New(math.random(0, 360), math.random(0, 360), math.random(0, 360)), 1):SetLoops(-1, DG.Tweening.LoopType.Incremental):SetEase(DG.Tweening.Ease.Linear)

				diceTrans:DOMove(floatPos, 1):SetEase(DG.Tweening.Ease.InOutQuint)
				CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_paotuan_battle_diceshow)

				if self._rotateAnis[playerDiceId] ~= nil then
					self._rotateAnis[playerDiceId]:Kill()
				end

				self._rotateAnis[playerDiceId] = se
			end
		end

		self._originFov = VirtualCameraMgr.instance:getFieldOfView()

		settimer(0.5, self.showMatchDiceHit, self, false)
	else
		self:checkIsFinish()
	end
end

function M:onMoveFinish()
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_COMBAT_DICE_COUNT)
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_MONSTER_HP_ANI)
	table.clear(self._matchList)

	for k, v in pairs(self._rotateAnis) do
		v:Kill()
	end

	table.clear(self._rotateAnis)

	local inAttack = RogueMgr.instance:getRogueFlow().model:getInAttack()

	if not self._hadMatchPlayerDice or inAttack then
		self:onAniEnd()

		return
	end

	self:showRecoveryDiceAni()

	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()

	self._eventType = eventType

	if eventType == RoguelikeConst.ROGUE_EVENT_TYPE.SINGLE_EVENT then
		self:onAniEnd()
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.MULTI_EVENT then
		self:onAniEnd()
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.ENCOUNTER_EVENT then
		self:onAniEnd()
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT then
		local roleProp = RogueMgr.instance:getModel():getCurRoleMo()
		local roleCo = RoguelikeConfig.instance:getRoguelikeRoleById(roleProp:getRoleId())
		local attackTime = 1
		local attackedTime = 1
		local combatDice = RogueMgr.instance:getRogueFlow().judgeMgr:getCurRoundCombatDice() or {}

		if #combatDice == 0 and false then
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_ROLE_ANI, RoguelikeConst.ROGUE_ROLE_ANI.ATTACK, attackTime)
			settimer(attackedTime, self.playHitAniDelay, self, false)
			settimer(attackTime + 0.01, self.onAniEnd, self, false)
		else
			self:onAniEnd()
		end

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_MONSTER_HP)
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.RECTIFY_EVENT then
		self:onAniEnd()
	end
end

function M:playHitAniDelay()
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_MONSTER_ANI, RoguelikeConst.ROGUE_MONSTER_ANI.HIT, 0.6)
end

function M:onAniEnd()
	self:checkIsFinish()
end

function M:playRoleHitAniDelay()
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_ROLE_ANI, RoguelikeConst.ROGUE_ROLE_ANI.HIT, 0.65)
end

function M:onHitAniEnd()
	self:normalEnd()
end

function M:saveJudgeArchive()
	RogueMgr.instance:getRogueFlow().judgeMgr:saveJudgeArchive(true)
end

function M:getDice(diceId)
	for k, v in pairs(self._combatDices) do
		if v:getId() == diceId then
			return v
		end
	end

	for k, v in pairs(self._playerDices) do
		if v:getId() == diceId then
			return v
		end
	end

	return nil
end

function M:showRecoveryDiceAni()
	self:_clearAni()

	self._recycleAni = {}

	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()
	local inAttack = RogueMgr.instance:getRogueFlow().model:getInAttack()

	if RogueMgr.instance:getRogueFlow().model:getRoundFinish() or eventType == RoguelikeConst.ROGUE_EVENT_TYPE.ENCOUNTER_EVENT or inAttack then
		for _, v in pairs(self._combatDices) do
			local go = v:getGo()

			if go then
				local diceTrans = go.transform
				local se = diceTrans:DOLocalRotate(Vector3.New(50, 50, 50), 0.1):SetLoops(-1, DG.Tweening.LoopType.Incremental):SetEase(DG.Tweening.Ease.Linear)

				table.insert(self._recycleAni, se)
				diceTrans:DOScale(Vector3.New(0, 0, 0), 0.8):SetEase(DG.Tweening.Ease.InOutQuint)

				local trigger = Astral.CollisionLuaComponentContainer.Add(go, RogueDiceCompTrigger)

				if trigger then
					trigger:reset()
				end
			end
		end

		local judgeMgr = RogueMgr.instance:getRogueFlow().judgeMgr

		judgeMgr:clearCurRoundCombatDice()
	end

	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_paotuan_battle_diceleave)

	for _, v in pairs(self._playerDices) do
		local go = v:getGo()
		local trigger = Astral.CollisionLuaComponentContainer.Add(go, RogueDiceCompTrigger)

		if trigger then
			trigger:reset()
		end

		if go then
			local diceTrans = go.transform
			local se = diceTrans:DOLocalRotate(Vector3.New(50, 50, 50), 0.1):SetLoops(-1, DG.Tweening.LoopType.Incremental):SetEase(DG.Tweening.Ease.Linear)

			table.insert(self._recycleAni, se)
			diceTrans:DOScale(Vector3.New(0, 0, 0), 1):SetEase(DG.Tweening.Ease.InOutQuint)
		end
	end

	settimer(1, self.setSelfDone, self, false)
end

function M:setSelfDone()
	self:_onCleanDice()

	if not RogueMgr.instance:getRogueFlow() then
		return
	end

	self:onDone(WorkResult.Succeed)
end

function M:recoveryDice()
	self:_clearAni()

	local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr
	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()
	local inAttack = RogueMgr.instance:getRogueFlow().model:getInAttack()

	if RogueMgr.instance:getRogueFlow().model:getRoundFinish() or eventType == RoguelikeConst.ROGUE_EVENT_TYPE.ENCOUNTER_EVENT or inAttack then
		for k, v in pairs(self._combatDices) do
			diceMgr:recoveryDiceObj(v:getGo())
		end
	end

	for k, v in pairs(self._playerDices) do
		diceMgr:recoveryDiceObj(v:getGo())
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_MATCH_DICE, self._onMatchDice, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_MATCH_DICE_PATTERN, self._onMatchDice, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_ADD_EXTRA_COMBAT_DICE, self._onAddCombatDice, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_CLEAN_DICE, self._onCleanDice, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_MATCH_DICE, self._onMatchDice, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_MATCH_DICE_PATTERN, self._onMatchDice, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_ADD_EXTRA_COMBAT_DICE, self._onAddCombatDice, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_CLEAN_DICE, self._onCleanDice, self)
	end
end

function M:_onMatchDice(sender, playerDiceId, combatDiceId, matchType)
	table.insert(self._matchList, {
		playerId = playerDiceId,
		combatId = combatDiceId,
		matchType = matchType
	})
	print("匹配骰子", playerDiceId, combatDiceId)

	if playerDiceId ~= nil then
		self._hadMatchPlayerDice = true
	end
end

function M:_onCleanDice()
	self:recoveryDice()
end

function M:_clearAni()
	if self._recycleAni then
		for _, v in ipairs(self._recycleAni) do
			v:Kill()

			v = nil
		end

		self._recycleAni = nil
	end
end

function M:_onAddCombatDice(sender, dice, count)
	if not RogueMgr.instance:getNeedShowDice() then
		return
	end
end

function M:showCameraShake()
	local lifeTime = 0.1
	local magnitude = 1
	local shakeModeValue = 4

	VirtualCameraMgr.instance:shake(lifeTime, magnitude, shakeModeValue, 0.1, 0.1)

	local virtualCamera = VirtualCameraMgr.instance:getActiveCamera()
	local originRotate = virtualCamera:getRotation()

	virtualCamera:doRotation(originRotate.x, -0.4, 0, 0.3)
	settimer(0.1, function()
		virtualCamera:doRotation(originRotate.x, 0.4, 0, 0.3)
		settimer(0.1, function()
			virtualCamera:doRotation(originRotate.x, 0, 0, 0.3)
		end, self, false)
	end, self, false)
end

function M:changeCameraFov(target)
	local time = 0.8
	local originFov = VirtualCameraMgr.instance:getFieldOfView()

	TweenUtil.tweenNumber(function(handle, value, isFinish)
		if isFinish then
			-- block empty
		else
			VirtualCameraMgr.instance:setFieldOfView(value)
		end
	end, self, originFov, target, time)
end

function M:onExit(isInterrupt)
	self:_clearAni()
	self:setEvent(false)

	self._isExit = true

	RogueMgr.instance:getRogueFlow().model:setInAttack(false)
	RogueMgr.instance:getRogueFlow().stateMgr:setEnemyAttack(0)
	RogueMgr.instance:getRogueFlow().shieldMgr:setCurAttackType(-1)
	self:_clearAni()
	removetimer(self.setSelfDone, self)
	removetimer(self.playHitAniDelay, self)
	removetimer(self.onAniEnd, self)
	removetimer(self.showMatchDiceHit, self)
	removetimer(self.onMoveFinish, self)
	removetimer(self.playRoleHitAniDelay, self)
	removetimer(self.normalEnd, self)
end

function M:onDestroy()
	M.super.onDestroy(self)
end

return M

-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/WorkRogueRoleRoll.lua

module("logic.extensions.roguelike.flow.work.WorkRogueRoleRoll", package.seeall)

local M = class("WorkRogueRoleRoll", WorkRogueRollBase)
local ThrowForceMinX = 3
local ThrowForceMaxX = 6
local GravityExtra = Vector3.New(0, -20, 0)
local kDragFactor = 40
local kRoleActionIds = {
	1001,
	1002,
	1003,
	1004,
	1005,
	1006
}
local kPatternTailFlyTime = 0.3

function M:ctor(isFight)
	M.super.ctor(self)

	self._isFight = isFight
end

function M:createRoleDice()
	local roleDices = RogueMgr.instance:getRogueFlow().judgeMgr:createRoleDice()

	self._dices = roleDices
end

function M:onEnter(context)
	self._dicePos = RogueMgr.instance:getRogueFlow().model:getPlayerDicePos()

	local index = RogueMgr.instance:getModel():getCurRoleIndex()
	local roleProp = RogueMgr.instance:getModel():getCurRoleMo()

	kRoleActionIds = roleProp:getCardIds()

	if not RogueMgr.instance:getNeedShowDice() then
		local idx = math.random(1, 6)

		RogueMgr.instance:getRogueFlow().judgeModel:setRoleSelectAction(kRoleActionIds[idx], idx)
		self:createRoleDice()

		local resultMsg = ""
		local playerDices = RogueMgr.instance:getRogueFlow().judgeMgr:getCurRoundPlayerDice()

		for k, v in pairs(playerDices) do
			local pattern = RoguelikeUtil.instance:convertCAttrType2SType(v:getUpPattern())

			if v:getSpecialType() ~= RoguelikeConst.SPECIAL_DICE_TYPE.BLACK then
				local patternResult = ""
				local patternText = pattern and patternResult .. RoguelikeConst.AttrType2GraphicText[pattern] or ""

				if patternText ~= "" then
					resultMsg = resultMsg .. " " .. patternText
				end
			end
		end

		if self._isFight then
			local actionCo = RoguelikeConfig.instance:getRoleActionById(kRoleActionIds[idx])
			local msg1 = string.format("%s选择了行动%s", RogueMgr.instance:getModel():getCurRoleMo():getName() .. "[head" .. RogueMgr.instance:getModel():getCurRoleMo():getModelId() .. "|32]", actionCo.name)

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg1)
		end

		if resultMsg == "" then
			local format = RoguelikeConfig.getBroadCast("Role_Throw_Empty")
			local msg = string.format(format, RogueMgr.instance:getModel():getCurRoleMo():getName() .. "[head" .. RogueMgr.instance:getModel():getCurRoleMo():getModelId() .. "|32]")

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
		else
			local format = RoguelikeConfig.getBroadCast("Broadcast_Role_Roll_Result")
			local msg = string.format(format, RogueMgr.instance:getModel():getCurRoleMo():getName() .. "[head" .. RogueMgr.instance:getModel():getCurRoleMo():getModelId() .. "|32]", resultMsg)

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
		end

		self:onDone(WorkResult.Succeed)

		return
	end

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_NEXT_ROLE_PREPARE, index)

	if self._isFight then
		settimer(1, self.delayShowJudgeSelect, self, false)
	else
		self:createRoleDice()
		RogueMgr.instance:getRogueFlow().diceMgr:getDiceInst(function(inst)
			self:onGetDiceRes(inst)
		end)
	end

	self._checkStopCount = 0

	self:setEvent(true)
end

function M:delayShowJudgeSelect()
	if RoguelikeController.instance:getIsAllDeath() then
		local msg = lang("tip_r_role_die_quit")

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
		self:onDone(WorkResult.Fail)

		return
	end

	if ViewMgr.instance:isOpen(ViewName.RogueMonsterJudge) then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_JUDGE_ROLE_SELECT, kRoleActionIds or {}, function(idx)
			local actionId = kRoleActionIds[idx]

			RogueMgr.instance:getRogueFlow().judgeModel:setRoleSelectAction(actionId, idx)
			RogueMgr.instance:getRogueFlow().stateMgr:setJudgeCardUse(actionId)
			self:createRoleDice()
			RogueMgr.instance:getRogueFlow().diceMgr:getDiceInst(function(inst)
				self:showCardTails(actionId)
				settimer(1, function()
					self:onGetDiceRes(inst)
				end, self, false)
			end)
		end)
	else
		local idx = math.random(1, 6)

		RogueMgr.instance:getRogueFlow().judgeModel:setRoleSelectAction(kRoleActionIds[idx], idx)
		self:createRoleDice()
		RogueMgr.instance:getRogueFlow().diceMgr:getDiceInst(function(inst)
			self:onGetDiceRes(inst)
		end)
	end
end

function M:showCardTails(actionId)
	if not self._isFight then
		return
	end

	local actionCo = RoguelikeConfig.instance:getRoleActionById(actionId)
	local rolePos = RoguelikeController.instance:getRolePos()
	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE
	local monsterPos = RogueMgr.instance:getModel():getCurMonster().transform:getPosition()
	local yOffset = Vector3.New(0, 0.5, 0)

	for k, v in pairs(actionCo.tailTarget or {}) do
		if v == 1 then
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_CREATE_DICE_TAIL, v)
		end

		if v == 2 then
			local roleMos = RogueMgr.instance:getModel():getAllRoleMos()

			for k1, v1 in pairs(roleMos) do
				GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_CREATE_DICE_TAIL, v, v1.transform:getPosition() + yOffset)
				settimer(0.7, function()
					v1.material:showOutlineColor("#FFE162")
				end, self, false)
			end
		end

		if v == 3 then
			local pos = Vector3.New(rolePos.x + kMapItemSize * 1.5, rolePos.y + 2, rolePos.z + kMapItemSize * 1)

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_CREATE_DICE_TAIL, v, pos)
		end

		if v == 4 then
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_CREATE_DICE_TAIL, v, monsterPos + yOffset)
		end

		if v == 5 then
			local pos = Vector3.New(rolePos.x + kMapItemSize * 4, rolePos.y, rolePos.z + kMapItemSize * 1)

			GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_CREATE_DICE_TAIL, v, pos)
		end

		if v == 6 then
			local roleMos = RogueMgr.instance:getModel():getAllRoleMos()
			local findTarget = false
			local index = RogueMgr.instance:getModel():getCurRoleIndex()

			for k1, v1 in pairs(roleMos) do
				if index < k1 and not v1.roleProp:getIsDeath() then
					GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_CREATE_DICE_TAIL, v, v1.transform:getPosition() + yOffset)
					settimer(0.7, function()
						v1.material:showOutlineColor("#FFE162")
					end, self, false)

					return
				end
			end

			for k1, v1 in pairs(roleMos) do
				if index ~= k1 and not v1.roleProp:getIsDeath() then
					GlobalDispatcher:dispatchEvent(EventType.ROGUE_SHOW_CREATE_DICE_TAIL, v, v1.transform:getPosition() + yOffset)

					return
				end
			end
		end
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_DICE_THROW, self._onDiceThrow, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_DICE_DRAG, self._onDiceDrag, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_DICE_THROW, self._onDiceThrow, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_DICE_DRAG, self._onDiceDrag, self)
	end
end

function M:_onDiceDrag(sender, originPos, endPos, delta)
	if not self._isInitDice or self._inThrowDice then
		return
	end

	local offsetX = (endPos.x - (self._lastDragPos and self._lastDragPos.x or originPos.x)) / 35

	self._lastDragPos = endPos

	for k, v in pairs(self._diceRigidbodys or {}) do
		if not goutil.isNil(v.body) then
			local go = v.body.gameObject

			if not self._stopFloat then
				local item = Astral.LuaComponentContainer.Add(go, RogueDiceCompFloat)

				item:stopFloat()
			end

			local pos = go.transform.position

			pos.x = pos.x + offsetX

			local originOffset = pos.x - self._rolePos.x

			if self._inThrowDice then
				return
			end

			if originOffset > 4.5 or originOffset < 0.5 then
				self:_onDiceThrow(sender, originPos, endPos, delta)

				return
			end

			go.transform.position = pos
		end
	end

	if not self._stopFloat then
		self._stopFloat = true
	end
end

function M:_onDiceThrow(sender, originPos, endPos, delta)
	if RogueMgr.instance:getIsAutoThrowDice() or not self._isInitDice or self._inThrowDice then
		return
	end

	RogueCameraUtil.instance:playThrowDiceCamera(function()
		self:stopDiceFloat()
		RogueMgr.instance:getRogueFlow().stateMgr:saveLastExtraFaceInfo()

		originPos = Vector3.New(originPos.x, 0, originPos.y)
		endPos = Vector3.New(endPos.x, 0, endPos.y)

		local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr

		for k, v in ipairs(self._dices) do
			if v:getSpecialType() == RoguelikeConst.SPECIAL_DICE_TYPE.BLACK then
				local isMatch = false

				for k1, v1 in pairs(self._diceRigidbodys or {}) do
					if v1.body and v1.body.gameObject and v1.body.gameObject == v:getGo() and not isMatch then
						isMatch = true

						table.remove(self._diceRigidbodys, k1)
						RogueMgr.instance:getRogueFlow().diceMgr:recoveryDiceObj(v:getGo())
						GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, RoguelikeConfig.getBroadCast("Remove_Black_Dice"))
					end
				end
			end
		end

		local format = RoguelikeConfig.getBroadCast("Broadcast_Role_Roll")
		local curRoleMo = RogueMgr.instance:getModel():getCurRoleMo()
		local msg = string.format(format, curRoleMo:getName() .. "[head" .. curRoleMo:getModelId() .. "|32]")

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
		GlobalDispatcher:dispatchEvent(EventType.SWIPE_FINISH_EVENT)

		local throwForce = M:_calThrowForce(originPos, endPos, delta)

		for k, v in pairs(self._diceRigidbodys or {}) do
			local rigidbody = v.body

			if not rigidbody or goutil.isNil(rigidbody) or not rigidbody.isKinematic then
				printWarn("骰子被移除")

				return
			end

			rigidbody.isKinematic = false

			rigidbody:AddForce(throwForce, UnityEngine.ForceMode.Impulse)

			local gForce = rigidbody.gameObject:GetComponent("ConstantForce")

			if gForce then
				gForce.force = GravityExtra
				gForce.enabled = true

				settimer(0.4, function()
					gForce.force = Vector3.New(0, -4, 0)
				end, self, false)
			end

			if not self._wallCollider then
				local collider = RogueMgr.instance:getRogueFlow().mapMgr:getJudgeColliderGo()

				self._wallCollider = goutil.findChild(collider, "right2"):GetComponent("BoxCollider")
			end

			self._wallCollider.enabled = true

			local item = Astral.LuaComponentContainer.Add(rigidbody.gameObject, RogueDiceCompFloat)

			item:stopAction()
		end

		RogueMgr.instance:getModel():getCurRoleSpine():play(RoguelikeConst.ROGUE_ROLE_ANI.ATTACK, false, true)
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_paotuan_chess_skill)
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_paotuan_battle_dicethrow)
		settimer(0.1, self.checkDiceStop, self, true)
		settimer(3, self._checkDiceUnStop, self, true)

		self._stopDiceIndex = 0
		self._inThrowDice = true
	end)
end

function M:_checkDiceUnStop()
	self._checkStopCount = self._checkStopCount + 1

	if not (self._checkStopCount > 3) then
		-- block empty
	end

	do
		local tempDicePatterns = RogueMgr.instance:getTempDicePatterns()
		local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr

		for k = #self._diceRigidbodys, 1, -1 do
			local v = self._diceRigidbodys[k]

			v.body.isKinematic = true
			v.body.useGravity = false

			local upIndex = self:getDiceUpIndex(v.body)

			v.dice:setUpIndex(upIndex)

			self._stopDiceIndex = self._stopDiceIndex + 1

			local stopIndex = self._stopDiceIndex

			if tempDicePatterns[stopIndex] ~= nil and v.dice:getUpPattern() ~= tempDicePatterns[stopIndex] then
				v.dice:setUpPattern(tempDicePatterns[stopIndex])

				local child = goutil.findChild(v.body.gameObject, diceMgr:getDiceFaceName(upIndex))

				diceMgr:setDicePattern(child, tempDicePatterns[stopIndex])
				goutil.setActive(child.gameObject, v.dice:getUpPattern() ~= RoguelikeConst.DICE_PATTERN.WHITE)
			end

			self._diceRotates[v.flyIndex] = self.DiceRotateMap[upIndex]

			table.remove(self._diceRigidbodys, k)

			local gForce = v.body.gameObject:GetComponent("ConstantForce")

			if gForce then
				gForce.enabled = false
			end

			self:onOneDiceStop(v.dice, v.dice:getUpPattern())
		end

		return
	end

	for k, v in ipairs(self._diceRigidbodys) do
		if not self:checkDiceIsUp(v.body.gameObject.transform) then
			v.body:AddForce(Vector3.up, UnityEngine.ForceMode.Impulse)
		end
	end
end

function M:onGetDiceRes(asset)
	local rolePos = RoguelikeController.instance:getRolePos()

	if self._dices then
		local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr

		for k, v in ipairs(self._dices) do
			local diceIdx = diceMgr:getRoleDiceIndex()
			local diceIndex = k % #diceIdx + 1
			local inst = diceMgr:getDiceObj(diceMgr:getDiceIndex(v))
			local pos = Vector3.New(rolePos.x, rolePos.y, rolePos.z)

			inst.transform.position = pos

			for i = 1, 6 do
				local pattern = v:getPatternByIndex(i)
				local child = goutil.findChild(inst, diceMgr:getDiceFaceName(i))

				diceMgr:setDicePattern(child, pattern)
				goutil.setActive(child.gameObject, v:getPatternByIndex(i) ~= RoguelikeConst.DICE_PATTERN.WHITE)
			end

			local rigidbody = inst:GetComponent("Rigidbody")

			rigidbody.isKinematic = true

			table.insert(self._diceRigidbodys, {
				body = rigidbody,
				index = v:getUpIndex(),
				dice = v,
				flyIndex = k
			})
			goutil.setActive(inst, true)

			local scale = RoguelikeConst.DICE_SCALE

			Astral.TransformUtil.SetLocalScale(inst.transform, scale, scale, scale)
			v:setGo(inst)

			local trigger = Astral.CollisionLuaComponentContainer.Add(inst, RogueDiceCompTrigger)

			if trigger then
				trigger:enableTail(false)
			end

			table.insert(self._diceGos, inst)
			table.insert(self._diceRotates, self.DiceRotateMap[v:getUpIndex()])

			local gForce = inst:GetComponent("ConstantForce")

			if gForce then
				gForce.enabled = false
			end
		end

		local judgeArchive = RoguelikeModel.instance:getJudgeArchive()
		local roleId = RogueMgr.instance:getRogueFlow().model:getCurRoleMo():getRoleId()

		if RogueMgr.instance:getIsAutoThrowDice() or judgeArchive ~= nil and judgeArchive.isJudged == false and roleId == judgeArchive.heroId * 2 then
			for k, v in pairs(self._diceGos) do
				local rotate = self._diceRotates[k]

				Astral.TransformUtil.SetLocalRotation(v.transform, rotate.x, rotate.y, rotate.z)
			end

			self:flyToPos()

			return
		end

		self:flyToOrigin()
	end
end

function M:flyToOrigin()
	local rolePos = RoguelikeController.instance:getRolePos()

	self._rolePos = RogueMgr.instance:getMapMgr():getRealMapRolePos()

	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE
	local flyTailPos = {}

	for k, v in pairs(self._diceGos) do
		local line = math.modf(k / 3)
		local offset = math.fmod(k, 3)

		if offset == 0 and line > 0 then
			line = line - 1
		end

		offset = offset == 0 and 3 or offset

		local y = (0.5 + line) * RoguelikeConst.DICE_SCALE + rolePos.y
		local z = (-(#self._diceGos / 2) + k) % 5 * RoguelikeConst.DICE_SCALE + rolePos.z + kMapItemSize * 1
		local pos = Vector3.New(rolePos.x + kMapItemSize * 1.5, y + 2, z)

		v.transform.localPosition = Vector3.New(pos.x, pos.y + 4, pos.z)

		v.transform:DOMove(pos, 0.5):OnComplete(self.onMoveFinish, self):SetEase(DG.Tweening.Ease.OutBack)
		v.transform:DOLocalRotate(Vector3.zero, 0.4)

		local diceMo = self._dices[k]
		local patternCount = diceMo:getSpecialPatternCount()

		for i = 1, patternCount do
			table.insert(flyTailPos, {
				pos = pos,
				dice = diceMo
			})
		end
	end

	self:diceFloat()
end

function M:diceFloat()
	for k, v in pairs(self._diceGos) do
		local item = Astral.LuaComponentContainer.Add(v, RogueDiceCompFloat)
		local rotation = Vector3.New(math.random(1, 359), math.random(1, 359), math.random(1, 359))
		local minY = math.random(10, 20) / 10
		local maxY = minY + math.random(10, 20) / 10

		item:setRandomFloat(rotation, minY, maxY)
	end

	settimer(0.1, self.delayInitDice, self, false)
	settimer(1, self._resetScale, self, false)

	if not self._isFight then
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_BEGIN_DICE_THROW)
	end
end

function M:delayInitDice()
	self._isInitDice = true

	if self._isFight then
		local originPos = Vector3.New(0, 0, 0)
		local endPos = Vector3.New(40, 0, 0)
		local delta = Vector3.New(25, 0, 0)

		self:_onDiceThrow(nil, originPos, endPos, delta)
	end
end

function M:_resetScale()
	if not self._diceGos or self._isFight then
		return
	end

	for k, v in pairs(self._diceGos) do
		if not goutil.isNil(v) and v.transform.localScale.x <= 0 and v.transform.localScale.y <= 0 and v.transform.localScale.z <= 0 then
			local scale = RoguelikeConst.DICE_SCALE

			Astral.TransformUtil.SetLocalScale(v.transform, scale, scale, scale)
		end
	end
end

function M:stopDiceFloat()
	for k, v in pairs(self._diceGos) do
		if not goutil.isNil(v) then
			local item = Astral.LuaComponentContainer.Add(v, RogueDiceCompFloat)

			item:stopAction()
		end
	end
end

function M:onOneDiceStop(dice, pattern)
	if dice == nil or pattern == RoguelikeConst.DICE_PATTERN.WHITE then
		return
	end
end

function M:checkDiceStop()
	M.super.checkDiceStop(self)

	if self._diceRigidbodys and #self._diceRigidbodys == 0 then
		for k, v in ipairs(self._dices) do
			local trigger = Astral.CollisionLuaComponentContainer.Add(v:getGo(), RogueDiceCompTrigger)

			if trigger then
				trigger:enableTail(false)

				if v:getUpPatternType() ~= RoguelikeConst.DICE_PATTERN.WHITE then
					trigger:showFaceEffect(v:getUpPatternType())
				end
			end
		end

		if RoguelikeConst.IsGuildMode() then
			RogueMgr.instance:setTempDicePatterns("")
		end
	end
end

function M:onDiceStop()
	local resultMsg = ""
	local playerDices = RogueMgr.instance:getRogueFlow().judgeMgr:getCurRoundPlayerDice()

	for k, v in pairs(playerDices) do
		local pattern = RoguelikeUtil.instance:convertCAttrType2SType(v:getUpPattern())

		if v:getSpecialType() ~= RoguelikeConst.SPECIAL_DICE_TYPE.BLACK then
			local patternResult = ""
			local patternText = pattern and patternResult .. RoguelikeConst.AttrType2GraphicText[pattern] or ""

			if patternText ~= "" then
				resultMsg = resultMsg .. " " .. patternText
			end
		end
	end

	if self._isFight then
		local actionCo = RoguelikeConfig.instance:getRoleActionById(RogueMgr.instance:getRogueFlow().judgeModel:getRoleSelectAction())
		local msg1 = string.format(RoguelikeConfig.getBroadCast("Role_Select_Action"), RogueMgr.instance:getModel():getCurRoleMo():getName() .. "[head" .. RogueMgr.instance:getModel():getCurRoleMo():getModelId() .. "|32]", actionCo.name)

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg1)
		RogueBroadcastModel.instance:addMoByDiceResult(playerDices, RogueMgr.instance:getModel():getCurRoleMo():getRoleId(), actionCo)
	end

	if resultMsg == "" then
		local format = RoguelikeConfig.getBroadCast("Role_Throw_Empty")
		local msg = string.format(format, RogueMgr.instance:getModel():getCurRoleMo():getName() .. "[head" .. RogueMgr.instance:getModel():getCurRoleMo():getModelId() .. "|32]")

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
	else
		local format = RoguelikeConfig.getBroadCast("Broadcast_Role_Roll_Result")
		local msg = string.format(format, RogueMgr.instance:getModel():getCurRoleMo():getName() .. "[head" .. RogueMgr.instance:getModel():getCurRoleMo():getModelId() .. "|32]", resultMsg)

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
	end
end

function M:flyToPos()
	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()

	if eventType ~= RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT then
		M.super.flyToPos(self)
	else
		self:onDone(WorkResult.Succeed)
	end
end

function M:getStopOffset()
	return Vector3.New(-4, 0, 0)
end

function M:_calThrowForce(originPos, endPos, delta)
	delta = Vector2.New(math.min(delta.x, 100), math.min(delta.y, 100))
	delta.x = math.max(delta.x, -20)

	local forward = Vector3.New(delta.x, 0, delta.y)
	local xRate = forward.x / 10
	local xForce = xRate
	local zForce = math.random(-1, 1)

	return Vector3.New(xForce, math.random(18, 25) / 10, zForce)
end

function M:onExit()
	self._isInitDice = false
	self._inThrowDice = false
	self._stopDiceIndex = 0

	removetimer(self.diceFloat, self)
	removetimer(self.delayInitDice, self)
	removetimer(self._resetScale, self)
	removetimer(self.delayShowJudgeSelect, self)
	removetimer(self._checkDiceUnStop, self)
	self:stopDiceFloat()
	M.super.onExit(self)
	self:setEvent(false)
end

return M

-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/WorkRogueEventRoll.lua

module("logic.extensions.roguelike.flow.work.WorkRogueEventRoll", package.seeall)

local M = class("WorkRogueEventRoll", WorkRogueRollBase)

function M:onEnter(context)
	if #RogueMgr.instance:getRogueFlow().judgeMgr:getCurRoundCombatDice() ~= 0 then
		self:onDone(WorkResult.Succeed)

		return
	end

	local combatDices, hideCount = RogueMgr.instance:getRogueFlow().judgeMgr:createEventDice()

	if hideCount then
		for i = 1, hideCount do
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_HIDE_COMBAT_DICE)
			RogueMgr.instance:getRogueFlow().judgeMgr:removeCurRoundCombatDice()
		end
	end

	for k, v in pairs(combatDices) do
		print("ROGUE", "事件骰子图案", v:getUpPattern())
	end

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_CREATE_COMBAT_DICE, combatDices)

	if not RogueMgr.instance:getNeedShowDice() then
		local map = RoguelikeConst.PROP_LANG_MAP[RogueMgr.instance:getModel():getEventProp()]
		local msg = string.format(RoguelikeConfig.getBroadCast("Event_Diff_Desc"), map.name, #combatDices)

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
		self:onDone(WorkResult.Succeed)

		return
	end

	self._dicePos = RogueMgr.instance:getRogueFlow().model:getPlayerDicePos()
	self._dices = combatDices

	RogueMgr.instance:getRogueFlow().diceMgr:getDiceInst(function(inst)
		self:onGetDiceRes(inst)
	end)
	self:onDone(WorkResult.Succeed)
end

function M:onGetDiceRes(asset)
	if self._dices then
		local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr

		for k, v in ipairs(self._dices) do
			local inst = diceMgr:getDiceObj(diceMgr:getDiceIndex(v))
			local pos = Vector3.New(self._dicePos.x + (k - #self._dices / 2) * 1.5, self._dicePos.y + 10, self._dicePos.z)

			inst.transform.position = pos

			for i = 1, 6 do
				local child = goutil.findChild(inst, diceMgr:getDiceFaceName(i))

				diceMgr:setDicePattern(child, v:getUpPattern())
				goutil.setActive(child.gameObject, v:getPatternByIndex(i) ~= RoguelikeConst.DICE_PATTERN.WHITE)
			end

			local rigidbody = inst:GetComponent("Rigidbody")

			rigidbody.isKinematic = true
			rigidbody.useGravity = false

			goutil.setActive(inst, true)

			local scale = RoguelikeConst.DICE_SCALE

			Astral.TransformUtil.SetLocalScale(inst.transform, scale, scale, scale)
			v:setGo(inst)
			table.insert(self._diceGos, inst)
			table.insert(self._diceRotates, self.DiceRotateMap[v:getUpIndex()])
		end

		self:flyToPos()
	end
end

function M:flyToPos()
	local rolePos = RoguelikeController.instance:getRolePos()
	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE

	self._diceIndex = 0

	local k = 0

	for i = #self._diceGos, 1, -1 do
		k = k + 1

		local v = self._diceGos[i]
		local line = math.modf(k / 5)
		local offset = math.fmod(k, 5)

		if offset == 0 and line > 0 then
			line = line - 1
		end

		offset = offset == 0 and 5 or offset

		local y = (0.5 + line) * RoguelikeConst.DICE_SCALE
		local pos = Vector3.New(rolePos.x + kMapItemSize * 4, y, (-2 + offset) * RoguelikeConst.DICE_SCALE + rolePos.z + kMapItemSize * 1.5)

		v.transform.localPosition = Vector3.New(pos.x, pos.y + 30, pos.z)

		v.transform:DOMove(pos, 0.5):OnComplete(self.onMoveFinish, self):SetDelay(0.4):SetEase(DG.Tweening.Ease.InQuint)
		v.transform:DOLocalRotate(self._diceRotates[k], 0.02)
	end
end

function M:getStopOffset()
	return Vector3.New(4, 0, 0)
end

return M

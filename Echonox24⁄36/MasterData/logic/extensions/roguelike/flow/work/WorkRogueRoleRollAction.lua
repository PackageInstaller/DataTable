-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/WorkRogueRoleRollAction.lua

module("logic.extensions.roguelike.flow.work.WorkRogueRoleRollAction", package.seeall)

local M = class("WorkRogueRoleRollAction", WorkBase)

function M:ctor()
	M.super.ctor(self)

	self._diceRigidbodys = {}
	self._diceGos = {}
	self._diceRotates = {}
	self._dices = nil
	self._flyCount = -1
	self._stopDiceIndex = 0
end

function M:onEnter(context)
	if not RogueMgr.instance:getNeedShowDice() then
		self:onDone(WorkResult.Succeed)

		return
	end

	local allDices, newDices = RogueMgr.instance:getRogueFlow().judgeMgr:createRoleDiceWall()

	self._allDiceCount = #allDices
	self._diceCount = #newDices
	self._allDices = allDices
	self._newDices = newDices

	if #newDices > 0 then
		local msg = string.format(RoguelikeConfig.getBroadCast("Role_Round_Wall_Count"), #newDices)

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
	end

	if self._diceCount == 0 then
		self:onDone(WorkResult.Succeed)

		return
	else
		RogueMgr.instance:getRogueFlow().diceMgr:getDiceInst(function(inst)
			self:onGetDiceRes(inst)
		end)
	end
end

function M:onGetDiceRes(asset)
	RogueMgr.instance:getRogueFlow().shieldMgr:createRoleShield()

	local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr
	local rolePos = RoguelikeController.instance:getRolePos()
	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE

	for k = 1, self._diceCount do
		local inst = diceMgr:getDiceObj(diceMgr:getRoleWallDiceIndex())
		local pos = Vector3.New(rolePos.x + 0.5, 0, rolePos.z + kMapItemSize * 2.5)

		inst.transform.position = pos

		for i = 1, 6 do
			local child = goutil.findChild(inst, diceMgr:getDiceFaceName(i))

			diceMgr:setDicePattern(child, RoguelikeConst.DICE_PATTERN.WHITE)
			goutil.setActive(child.gameObject, false)
		end

		local rigidbody = inst:GetComponent("Rigidbody")

		rigidbody.isKinematic = true
		rigidbody.useGravity = false

		goutil.setActive(inst, false)
		self._newDices[k]:setGo(inst)

		local scale = RoguelikeConst.DICE_SCALE

		Astral.TransformUtil.SetLocalScale(inst.transform, scale, scale, scale)
		table.insert(self._diceGos, inst)
		table.insert(self._diceRotates, Vector3.New(0, 0, 0))
	end

	self:flyToPos()
end

function M:flyToPos()
	self._diceIndex = 0

	local rolePos = RoguelikeController.instance:getRolePos()
	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE
	local k = self._allDiceCount - self._diceCount

	for i = 1, #self._diceGos do
		k = k + 1

		local v = self._diceGos[i]
		local line = math.modf(k / 5)
		local offset = math.fmod(k, 5)

		if offset == 0 and line > 0 then
			line = line - 1
		end

		offset = offset == 0 and 5 or offset

		local y = (0.5 + line) * RoguelikeConst.DICE_SCALE
		local pos = Vector3.New(rolePos.x + kMapItemSize * 1.5, y, (-2 + offset) * RoguelikeConst.DICE_SCALE + rolePos.z + kMapItemSize * 1)

		v.transform.localPosition = Vector3.New(pos.x, pos.y + 10, pos.z)

		v.transform:DOMove(pos, 0.5):OnComplete(self.onMoveFinish, self):SetDelay(0.4 + i * 0.04):SetEase(DG.Tweening.Ease.InQuint)
		v.transform:DOLocalRotate(self._diceRotates[1], 0.02)
	end
end

function M:onMoveFinish()
	if not self._diceGos then
		return
	end

	self._diceIndex = self._diceIndex + 1

	local curCount = self._allDiceCount - self._diceCount + self._diceIndex

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_REFRESH_ROLE_DICE_WALL, curCount)

	if self._diceIndex == #self._diceGos or self._diceIndex == self._flyCount then
		self:onDone(WorkResult.Succeed)
	end
end

return M

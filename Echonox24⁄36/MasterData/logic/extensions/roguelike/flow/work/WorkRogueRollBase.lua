-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/WorkRogueRollBase.lua

module("logic.extensions.roguelike.flow.work.WorkRogueRollBase", package.seeall)

local M = class("WorkRogueRollBase", WorkBase)
local DiceMap = {
	3,
	4,
	1,
	2,
	6,
	5
}
local DiceRotateMap = {
	Vector3.New(0, 90, 90),
	Vector3.New(270, 90, 90),
	Vector3.New(180, 90, 90),
	Vector3.New(90, 90, 90),
	Vector3.New(0, 0, 0),
	(Vector3.New(0, 0, 180))
}

function M:ctor()
	M.super.ctor(self)

	self.DiceRotateMap = DiceRotateMap
	self.DiceMap = DiceMap
	self._diceRigidbodys = {}
	self._diceGos = {}
	self._diceRotates = {}
	self._dices = nil
	self._flyCount = -1
	self._stopDiceIndex = 0
end

function M:onGetDiceRes(asset)
	if self._dices then
		local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr

		for k, v in ipairs(self._dices) do
			local inst = diceMgr:getDiceObj()
			local pos = Vector3.New(self._dicePos.x + k * 0.5, self._dicePos.y + 10, self._dicePos.z)

			inst.transform.position = pos

			for i = 1, 6 do
				local child = goutil.findChild(inst, diceMgr:getDiceFaceName(i))

				diceMgr:setDicePattern(child, v:getPatternByIndex(i))
				goutil.setActive(child.gameObject, v:getPatternByIndex(i) ~= RoguelikeConst.DICE_PATTERN.WHITE)
			end

			goutil.setActive(inst, true)

			local rigidbody = inst:GetComponent("Rigidbody")

			table.insert(self._diceRigidbodys, {
				body = rigidbody,
				index = v:getUpIndex(),
				dice = v,
				flyIndex = k
			})
			rigidbody:AddExplosionForce(200, inst.transform.position - Vector3.New(0, 0.5, 0), 20, -2, UnityEngine.ForceMode.Impulse)
			rigidbody:AddTorque(UnityEngine.Random.onUnitSphere * 100, UnityEngine.ForceMode.Impulse)
			v:setGo(inst)
			table.insert(self._diceGos, inst)
			table.insert(self._diceRotates, DiceRotateMap[v:getUpIndex()])
		end
	end

	settimer(0.1, self.checkDiceStop, self, true)
end

function M:checkDiceIsUp(tra)
	local average = 0.1
	local a = average > math.abs(Vector3.Dot(tra.forward, Vector3.up))
	local b = average > math.abs(Vector3.Dot(tra.up, Vector3.up))
	local c = average > math.abs(Vector3.Dot(tra.right, Vector3.up))
	local results = {
		a,
		b,
		c
	}
	local count = 0

	for k, v in pairs(results) do
		if v == true then
			count = count + 1
		end
	end

	return count >= 2
end

function M:checkDiceStop()
	self._diceRigidbodys = self._diceRigidbodys or {}

	local tempDicePatterns = RogueMgr.instance:getTempDicePatterns()
	local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr

	for k, v in ipairs(self._diceRigidbodys) do
		if v.body.velocity.sqrMagnitude < 0.1 and self:checkDiceIsUp(v.body.gameObject.transform) then
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

			self._diceRotates[v.flyIndex] = DiceRotateMap[upIndex]

			table.remove(self._diceRigidbodys, k)

			local gForce = v.body.gameObject:GetComponent("ConstantForce")

			if gForce then
				gForce.enabled = false
			end

			self:onOneDiceStop(v.dice, v.dice:getUpPattern())

			return
		end
	end

	if #self._diceRigidbodys == 0 then
		self:onDiceStop()
		removetimer(self.checkDiceStop, self)
		self:onDone(WorkResult.Succeed)
	end
end

function M:onOneDiceStop(dice, pattern)
	return
end

function M:onDiceStop()
	return
end

function M:getDiceUpIndex(dice)
	local tra = dice.transform:Find("face")
	local maxY = 0
	local index = 1

	for i = 0, tra.childCount - 1 do
		local tempY = tra:GetChild(i).position.y

		if maxY < tempY or maxY == 0 then
			maxY = tempY
			index = i + 1
		end
	end

	return index
end

function M:flyToPos()
	self._diceIndex = 0
	self._dicePos = RogueMgr.instance:getRogueFlow().model:getPlayerDicePos()

	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE

	for k, v in pairs(self._diceGos) do
		local line = math.modf(k / 3)
		local offset = math.fmod(k, 3)

		if offset == 0 and line > 0 then
			line = line - 1
		end

		offset = offset == 0 and 3 or offset

		local y = 0.5 + line
		local pos = Vector3.New(self._dicePos.x + kMapItemSize * 3, y, -1 + offset + self._dicePos.z + kMapItemSize * 2.5)

		v.transform:DOMove(pos, 0.5):OnComplete(self.onMoveFinish, self)
		v.transform:DOLocalRotate(Vector3.zero, 0.5)
	end
end

function M:getStopOffset()
	return Vector3.zero
end

function M:onMoveFinish()
	if self._diceIndex == nil then
		return
	end

	if self._diceGos == nil then
		self:onDone(WorkResult.Succeed)

		return
	end

	self._diceIndex = self._diceIndex + 1

	if self._diceIndex == #self._diceGos or self._diceIndex == self._flyCount then
		self:onDone(WorkResult.Succeed)
	end
end

function M:onExit(isInterrupt)
	removetimer(self.checkDiceStop, self)

	self._diceRigidbodys = nil
	self._diceGos = nil
	self._diceRotates = nil
	self._dices = nil
end

return M

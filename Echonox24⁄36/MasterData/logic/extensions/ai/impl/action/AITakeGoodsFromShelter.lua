-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AITakeGoodsFromShelter.lua

module("logic.extensions.ai.impl.action.AITakeGoodsFromShelter", package.seeall)

local M = class("AITakeGoodsFromShelter", AINode)
local AnimationState = HouseEnum.AnimationState
local WorkType = HouseEnum.WorkType
local kOffsetX2Goods = 0
local kOffsetY2Goods = -0.24
local kOffsetZ2Goods = -0.25
local kMoveOffsetY = 4
local vec3Temp = Vector3.New()

function M:ctor(context)
	M.super.ctor(self, context)
	self:_resetData()
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)
end

function M:onStart()
	M.super.onStart(self)
	self:_resetData()

	local success = self:_setTargetPos()

	if not success then
		return self:onEnd(AIConst.AIStatus.FAILD)
	end

	local unit = self:getContext():getUnit()

	if unit.followRobot:getTransportGoods() then
		self:_setTargetPos(true)

		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end

	local roomId = unit.navMesh:getCurZoneId()
	local roomMgr = SceneMgr.instance:getCurScene().roomMgr

	self._roomUnit = roomMgr:getUnitById(roomId)

	local succeed = self:_takeGoods()

	if not succeed then
		return self:onEnd(AIConst.AIStatus.FAILD)
	end

	self:_setTargetPos(true)

	return self
end

function M:_setTargetPos(setPos)
	local returnGoodsRoomId = HouseSceneUtil.getReturnGoodsRoomId(WorkType.Shelter)
	local navMO = HouseNavigationModel.instance:getMOByZoneId(returnGoodsRoomId)
	local goodsPos = navMO:getReturnGoodsPos()

	if not goodsPos then
		return false
	end

	if setPos then
		vec3Temp:Set(goodsPos.x - 1, goodsPos.y - 1, goodsPos.z - 0.5)
		self:getContext():setTargetPos(vec3Temp, returnGoodsRoomId)
		self:getContext():setUseRandomPos(false)
	end

	return true
end

function M:_takeGoods()
	local unit = self:getContext():getUnit()

	self._goodsUnit = self._roomUnit.goodsMgr:createGoods()

	if self._goodsUnit then
		unit.followRobot:setTransportGoods(self._goodsUnit)
		self._roomUnit.goodsMgr:removeGoods(self._goodsUnit)

		local goodsPos = self._roomUnit.goodsMgr:getGoodsCreatePos()
		local luaTable = {}

		luaTable.direction = HouseEnum.UnitDirection.Forward
		luaTable.flyActionName = AnimationState.Idle
		luaTable.unitPos = {
			x = goodsPos.x,
			y = goodsPos.y,
			z = goodsPos.z
		}
		luaTable.angle = self._roomUnit.model:getRoomAngle()
		luaTable.baseOffset = {
			x = kOffsetX2Goods,
			y = kOffsetY2Goods,
			z = kOffsetZ2Goods
		}
		luaTable.moveOffset = {
			z = 0,
			x = 0,
			y = kMoveOffsetY
		}
		luaTable.flyTime = 2
		luaTable.flyFinCallback = self._startCatchGoods
		luaTable.flyFinTarget = self
		self._robotUnit = unit.followRobot:flyNewRobot(luaTable)

		return true
	end

	return false
end

function M:_startCatchGoods(robotUnit)
	robotUnit.meshModel:play(AnimationState.Catch, false)

	self._catchTime = Time.time + robotUnit.meshModel:getAnimationEffectFrameTime(AnimationState.Catch, 1)
	self._catchCompleteTime = Time.time + robotUnit.meshModel:getAnimationDuration(AnimationState.Catch)
end

function M:_onRobotCatchGoods()
	local goodsGO = self._goodsUnit:getInst()

	self._robotUnit.mountBinder:bindGameObject(MeshModelMount.RightHand, goodsGO)
	Astral.TransformUtil.SetLocalPos(goodsGO.transform, -0.13, -0.48, -0.2)
	Astral.TransformUtil.SetLocalRotation(goodsGO.transform, 4.91, 80.44, 1.7)
	Astral.TransformUtil.SetPos(self._goodsUnit.go.transform, 99999, 99999, 0)
end

function M:_onRobotCompleteCatch()
	local unit = self:getContext():getUnit()

	vec3Temp:Set(0, 0, 0)

	local modelGO = self._robotUnit.meshModel:getInst()

	modelGO.transform:DOLocalMove(vec3Temp, 0.5)
	self._robotUnit.meshModel:play(AnimationState.Idle2, true)
	self._robotUnit.navMeshMover:setIdleName(AnimationState.Idle2)
	self._robotUnit.navMeshMover:setWalkName(AnimationState.Walk2)
	self._robotUnit.navMesh:setNavMeshAgentStatus(true)
	self._robotUnit.navMeshMover:setStopChangeAngle(false)
	unit.followRobot:switchFollow(true)
end

function M:handleEnd()
	return
end

function M:onUpdate()
	if self._catchTime > 0 and Time.time > self._catchTime then
		self._catchTime = -1

		self:_onRobotCatchGoods()
	end

	if self._catchCompleteTime > 0 and Time.time > self._catchCompleteTime then
		self._catchCompleteTime = -1

		self:_onRobotCompleteCatch()

		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end

	return self
end

function M:onReset()
	if self._catchTime > 0 then
		self:_onRobotCatchGoods()
	end

	if self._catchCompleteTime > 0 then
		self:_onRobotCompleteCatch()
	end

	M.super.onReset(self)
	self:_resetData()
end

function M:onReuse(context)
	M.super.onReuse(self, context)
end

function M:onRecycle()
	M.super.onRecycle(self)
	self:_resetData()
end

function M:onDestroy()
	M.super.onDestroy(self)
	self:_resetData()
end

function M:_resetData()
	self._roomUnit = nil
	self._goodsUnit = nil
	self._robotUnit = nil
	self._catchTime = -1
	self._catchCompleteTime = -1
end

return M

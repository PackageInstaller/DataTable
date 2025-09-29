-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AIReturnGoodsToTrading.lua

module("logic.extensions.ai.impl.action.AIReturnGoodsToTrading", package.seeall)

local M = class("AIReturnGoodsToTrading", AINode)
local AnimationState = HouseEnum.AnimationState
local kOffsetX2Goods = 0
local kOffsetY2Goods = -0.24
local kOffsetZ2Goods = -0.25
local kMoveOffsetY = 4
local vec3Temp = Vector3.New()

function M:ctor(context)
	M.super.ctor(self, context)

	self._putdownTime = -1
	self._putdownCompleteTime = -1
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)
end

function M:onStart()
	M.super.onStart(self)

	local unit = self:getContext():getUnit()

	if not unit.followRobot:getTransportGoods() then
		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end

	local roomId = unit.navMesh:getCurZoneId()
	local roomMgr = SceneMgr.instance:getCurScene().roomMgr

	self._roomUnit = roomMgr:getUnitById(roomId)

	if not self._roomUnit then
		printWarn("获取不到小屋unit，小屋id：", roomId)

		return self:onEnd(AIConst.AIStatus.FAILD)
	end

	if not unit.followRobot:getFollowUnit() then
		return self:onEnd(AIConst.AIStatus.FAILD)
	end

	self:_returnGoods()

	return self
end

function M:_returnGoods()
	local unit = self:getContext():getUnit()
	local robotUnit = unit.followRobot:getFollowUnit()
	local goodsPos = self._roomUnit.goodsMgr:getGoodsReturnPos()

	unit.followRobot:switchFollow(false)
	robotUnit.navMesh:setNavMeshAgentStatus(false)

	local goodsUnit = unit.followRobot:getTransportGoods()

	goodsUnit:setUnitAngle(self._roomUnit.model:getRoomAngle())
	Astral.TransformUtil.SetPos(goodsUnit.go.transform, goodsPos.x, goodsPos.y, goodsPos.z)

	local robotPosX, robotPosY, robotPosZ = goodsUnit.mountRoot:getRelativeWorldPosByLocalPos(kOffsetX2Goods, kOffsetY2Goods, kOffsetZ2Goods)

	vec3Temp:Set(robotPosX, robotPosY, robotPosZ)

	local sequence = DG.Tweening.DOTween.Sequence()

	sequence:Append(robotUnit.go.transform:DOMove(vec3Temp, 1, false))
	sequence:AppendCallback(self._startPutdownGoods, self)
	sequence:SetTarget(robotUnit.go)
end

function M:_startPutdownGoods()
	local unit = self:getContext():getUnit()
	local robotUnit = unit.followRobot:getFollowUnit()

	robotUnit.navMeshMover:setStopChangeAngle(true)
	robotUnit.navMeshMover:setDirection(HouseEnum.UnitDirection.Forward)
	robotUnit.meshModel:play(AnimationState.PutDown, false)

	self._putdownTime = Time.time + robotUnit.meshModel:getAnimationEffectFrameTime(AnimationState.PutDown, 1)
	self._putdownCompleteTime = Time.time + robotUnit.meshModel:getAnimationDuration(AnimationState.PutDown)
end

function M:_onPutDownGoods()
	local unit = self:getContext():getUnit()
	local goodsUnit = unit.followRobot:getTransportGoods()
	local goodsGO = goodsUnit:getInst()

	goutil.addChildToParent(goodsGO, goodsUnit.go)
	Astral.TransformUtil.SetLocalPos(goodsGO.transform, 0, 0, 0)
	Astral.TransformUtil.SetLocalRotation(goodsGO.transform, 0, 0, 0)
end

function M:_onPutDownGoodsComplete()
	local unit = self:getContext():getUnit()
	local robotUnit = unit.followRobot:getFollowUnit()
	local flyTime = 2

	robotUnit.meshModel:play(AnimationState.Idle, true)
	robotUnit.navMeshMover:resetActionName()
	DG.Tweening.DOTween.Kill(robotUnit.go)
	robotUnit.material:doScreenDoorAlpha(1, 0, flyTime)

	local modelGO = robotUnit.meshModel:getInst()
	local sequence = DG.Tweening.DOTween.Sequence()

	sequence:Append(modelGO.transform:DOLocalMoveY(kOffsetY2Goods + kMoveOffsetY, flyTime, false))
	sequence:AppendCallback(self._destroyAll, self)
	sequence:SetTarget(robotUnit.go)
end

function M:_destroyAll()
	local unit = self:getContext():getUnit()

	unit.followRobot:destroyRobot()
	unit.followRobot:removeTransportGoods()
end

function M:handleEnd()
	return
end

function M:onUpdate()
	if self._putdownTime > 0 and Time.time > self._putdownTime then
		self._putdownTime = -1

		self:_onPutDownGoods()
	end

	if self._putdownCompleteTime > 0 and Time.time > self._putdownCompleteTime then
		self._putdownCompleteTime = -1

		self:_onPutDownGoodsComplete()

		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end

	return self
end

function M:onReset()
	if self._putdownTime > 0 then
		self:_onPutDownGoods()
	end

	if self._putdownCompleteTime > 0 then
		self:_onPutDownGoodsComplete()
	end

	M.super.onReset(self)

	self._putdownTime = -1
	self._putdownCompleteTime = -1
end

function M:onReuse(context)
	M.super.onReuse(self, context)
end

function M:onRecycle()
	self:_removeListener()
	M.super.onRecycle(self)

	self._roomUnit = nil
	self._putdownTime = -1
	self._putdownCompleteTime = -1
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._roomUnit = nil
	self._putdownTime = nil
	self._putdownCompleteTime = nil
end

function M:_removeListener()
	local unit = self:getContext():getUnit()
	local robotUnit = unit.followRobot:getFollowUnit()

	if robotUnit then
		DG.Tweening.DOTween.Kill(robotUnit.go)
	end
end

return M

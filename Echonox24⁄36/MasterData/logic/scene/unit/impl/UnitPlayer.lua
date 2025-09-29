-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/impl/UnitPlayer.lua

module("logic.scene.unit.impl.UnitPlayer", package.seeall)

local M = class("UnitPlayer", ReusableUnitBase)
local kLowFrameCount = 10

function M:ctor(componetContainer)
	M.super.ctor(self, componetContainer)

	self.heroId = false
	self._targetFrameCount = 1
	self._currFrameCount = 1
end

function M:reset()
	M.super.reset(self)

	self.heroId = false
	self._targetFrameCount = 1
	self._currFrameCount = 1
end

function M:getTag()
	return UnitTag.Player
end

function M:getLayer()
	return SceneLayer.Unit_Value
end

function M:_initComponents()
	self:_addComponent("ai", UnitCompAI)
	self:_addComponent("performCtrl", UnitCompPerformCtrl)
	self:_addComponent("mountRoot", UnitCompMountRoot)
	self:_addComponent("meshModel", HouseUnitCompMeshModel)
	self:_addComponent("navMesh", UnitCompNavMesh)
	self:_addComponent("navMeshMover", UnitCompNavMeshMover)
	self:_addComponent("uiFollow", UnitCompUIFollow)
	self:_addComponent("bubble", UnitCompBubble)
	self:_addComponent("model", UnitCompPlayerModel)
	self:_addComponent("scheduleModel", UnitCompScheduleModel)
	self:_addComponent("behaviorMgr", UnitCompBehaviorMgr)
	self:_addComponent("gravity", UnitCompGravity)
	self:_addComponent("namebar", UnitCompNameBar)
	self:_addComponent("workTool", UnitCompWorkTool)
	self:_addComponent("followRobot", UnitCompFollowRobot)
	self:_addComponent("collider", UnitCompCollider)
	self:_addComponent("progressBar", UnitCompProgressBar)
	self:_addComponent("material", UnitCompModelMaterial)
	self:_addComponent("mountBinder", UnitCompModelMountBinder)
	self:_addComponent("pajama", UnitCompPajama)
	self:_addComponent("modeCtrl", HouseUnitCompModeCtrl)
end

function M:OnDestroy()
	M.super.OnDestroy(self)
end

function M:Update()
	if self._currFrameCount >= self._targetFrameCount then
		self._currFrameCount = 1

		self:_updateComp()
	else
		self._currFrameCount = self._currFrameCount + 1
	end
end

function M:_updateComp()
	self.ai:update()
	self.navMeshMover:update()
	self.gravity:update()
	self.followRobot:update()
	self.modeCtrl:update()
	self.navMesh:update()
end

function M:setLowMode(isLow)
	if isLow then
		self.meshModel:setVisible(false)

		self._targetFrameCount = kLowFrameCount
	else
		self.meshModel:setVisible(true)

		self._targetFrameCount = 1
	end
end

return M

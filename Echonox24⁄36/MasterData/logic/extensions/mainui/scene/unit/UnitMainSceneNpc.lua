-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/unit/UnitMainSceneNpc.lua

module("logic.extensions.mainui.scene.unit.UnitMainSceneNpc", package.seeall)

local M = class("UnitMainSceneNpc", ReusableUnitBase)

function M:ctor(componetContainer)
	M.super.ctor(self, componetContainer)

	self.heroId = false
	self._skinId = false
end

function M:reset()
	M.super.reset(self)
end

function M:getId()
	return self.id
end

function M:setHeroId(heroId)
	self.heroId = heroId
end

function M:getHeroId()
	return self.heroId
end

function M:setSkinId(skinId)
	self._skinId = skinId
end

function M:getSkinId()
	return self._skinId
end

function M:setElementId(elementId)
	self._elementId = elementId
end

function M:getElementId()
	return self._elementId
end

function M:setPointId(pointId)
	self._pointId = pointId
end

function M:getPointId()
	return self._pointId
end

function M:isAdjutant()
	return false
end

function M:setModelId(modelId)
	self._modelId = modelId
end

function M:getModelId()
	return self._modelId
end

function M:getModelData()
	local modelId = self:getModelId()
	local modelData = ModelConfig.instance:getModelData(modelId)

	return modelData
end

function M:getTag()
	return UnitTag.Npc
end

function M:getLayer()
	return SceneLayer.Unit_Value
end

function M:getTargetSceneType()
	return SceneType.Room
end

function M:checkInScene()
	local scene = SceneMgr.instance:getCurScene()
	local sceneTyp = scene and scene:getSceneType() or nil

	return sceneTyp == SceneType.Room
end

function M:_initComponents()
	self:_addComponent("meshModel", UnitCompMainSceneMeshModel)
	self:_addComponent("animClip", UnitCompMainSceneAnimClip)
	self:_addComponent("animCtrl", UnitCompMainSceneAnimCtrl)
	self:_addComponent("animSeqCtrl", UnitCompMainSceneSeqAnimCtrl)
	self:_addComponent("hideNode", UnitCompMainSceneHideNode)
	self:_addComponent("autoHideByFullView", UnitCompHeroAutoHideByFullView)
end

function M:OnDestroy()
	M.super.OnDestroy(self)
end

return M

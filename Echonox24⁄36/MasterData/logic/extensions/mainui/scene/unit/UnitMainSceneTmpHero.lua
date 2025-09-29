-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/unit/UnitMainSceneTmpHero.lua

module("logic.extensions.mainui.scene.unit.UnitMainSceneTmpHero", package.seeall)

local M = class("UnitMainSceneTmpHero", ReusableUnitBase)

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

function M:checkInScene()
	return true
end

function M:getTag()
	return "Tmp"
end

function M:getLayer()
	return SceneLayer.Unit_Value
end

function M:_initComponents()
	self:_addComponent("meshModel", UnitCompMainSceneMeshModel)
	self:_addComponent("animClip", UnitCompMainSceneAnimClip)
	self:_addComponent("animCtrl", UnitCompMainSceneAnimCtrl)
end

function M:OnDestroy()
	M.super.OnDestroy(self)
end

return M

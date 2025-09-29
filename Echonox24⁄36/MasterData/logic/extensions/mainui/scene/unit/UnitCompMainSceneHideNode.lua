-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/unit/UnitCompMainSceneHideNode.lua

module("logic.extensions.mainui.scene.unit.UnitCompMainSceneHideNode", package.seeall)

local M = class("UnitCompMainSceneHideNode", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)
end

function M:onInit()
	self:onReset()
	self:setEvent(true)
end

function M:onDestroy()
	self:onReset()
	self:setEvent(false)
end

function M:isDestroyed()
	if self._unit then
		return self._unit:isDestroyed()
	end

	return true
end

function M:onReset()
	self:setEvent(false)
	self:clear()
end

function M:onReuse()
	self:setEvent(true)
end

function M:clear()
	self._hideNodeMap = {}
end

function M:setEvent(add)
	if add then
		self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._handleOnMeshModelLoaded, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._handleOnMeshModelLoaded, self)
	end
end

function M:_handleOnMeshModelLoaded()
	self:clear()

	local pointId = self._unit:getPointId()
	local heroId = self._unit:getHeroId()
	local modelId = self._unit:getModelId()

	self._hideNodeMap = {}

	local cfg

	if pointId == MainPerformEnum.ElementPointAdjutant then
		cfg = MainPerformConfig.instance:getLandLadyRConfig(modelId)
	else
		cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformHeroR, modelId)
	end

	if cfg then
		for _, valStr in pairs(cfg.hideNode or {}) do
			self._hideNodeMap[valStr] = 1
		end
	end

	self:setHideNodeVisible(false)
end

function M:setHideNodeVisible(visible)
	if self._hideNodeMap and TableUtil.getLen(self._hideNodeMap) > 0 then
		local go = self._unit.meshModel:getInst()

		for i = 0, go.transform.childCount - 1 do
			local childGo = go.transform:GetChild(i).gameObject
			local _name = childGo.name

			if self._hideNodeMap[_name] then
				goutil.setActive(childGo, visible)
			end
		end
	end
end

return M

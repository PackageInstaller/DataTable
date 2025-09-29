-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/unit/UnitCompHeroAirtightTimeShowNode.lua

module("logic.common.unit.UnitCompHeroAirtightTimeShowNode", package.seeall)

local M = class("UnitCompHeroAirtightTimeShowNode")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._airtightShowNodeMap = {}
end

function M:Awake()
	return
end

function M:OnDestroy()
	self:setEvent(false)
	self:clear()
end

function M:clear()
	self._modelGo = nil
	self._airtightShowNodeMap = {}
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
		GlobalDispatcher:addEventListener(EventType.ON_ARITIGHT_STATE_PREVIEW, self._handleAirtightStatePreview, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
		GlobalDispatcher:removeEventListener(EventType.ON_ARITIGHT_STATE_PREVIEW, self._handleAirtightStatePreview, self)
	end
end

function M:setInfo(modelGo, modelId, useAdjutantData)
	self:clear()

	if not modelGo then
		return
	end

	self._modelGo = modelGo.gameObject

	local cfg

	if useAdjutantData then
		cfg = MainPerformConfig.instance:getLandLadyRConfig(modelId)
	else
		cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformHeroR, modelId)
	end

	if cfg then
		for _, valStr in pairs(cfg.airtightShowNode or {}) do
			self._airtightShowNodeMap[valStr] = 1
		end
	end

	self:_updateAirtightTimeState()
	self:setEvent(true)
end

function M:_handleAirtightStatePreview(_, isInAirtight)
	self:_updateAirtightTimeState()
end

function M:_handleAritightStateChange(e, isInAirtightTime, airtightEndTS)
	self:_updateAirtightTimeState()
end

function M:_updateAirtightTimeState()
	local show = AirtightRoomController.instance:getIsInAirtightTime(nil, nil, nil, false)

	self:setNodeVisible(show)
end

function M:setNodeVisible(visible)
	if self._airtightShowNodeMap and TableUtil.getLen(self._airtightShowNodeMap) > 0 then
		local go = self._modelGo

		if not go or goutil.isNil(go) then
			return
		end

		for i = 0, go.transform.childCount - 1 do
			local childGo = go.transform:GetChild(i).gameObject
			local _name = childGo.name

			if self._airtightShowNodeMap[_name] then
				local skinnedMesh = childGo:GetComponent(typeof(UnityEngine.SkinnedMeshRenderer))

				skinnedMesh.enabled = visible
			end
		end
	end
end

return M

-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/TimeTextItem.lua

module("logic.extensions.playerinfo.view.info.TimeTextItem", package.seeall)

local M = class("TimeTextItem")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
end

function M:Awake()
	self._txtDesc = goutil.findChildTextComponent(self._compContainer, "txtTime")
	self._canvasGroup = goutil.addComponentOnce(self._compContainer, ComponentType.CanvasGroup)
end

function M:getData()
	return self._data
end

function M:setCellData(data, index, showData)
	self._curIndex = index
	self._data = data
	self._txtDesc.text = showData
end

function M:setAlpha(alpha)
	self._canvasGroup.alpha = alpha
end

function M:getContentObj()
	return self._txtDesc.gameObject
end

function M:OnDestroy()
	self._compContainer = nil
	self._txtDesc = nil
	self._canvasGroup = nil
end

return M

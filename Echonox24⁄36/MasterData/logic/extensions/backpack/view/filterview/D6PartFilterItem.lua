-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/filterview/D6PartFilterItem.lua

module("logic.extensions.backpack.view.filterview.D6PartFilterItem", package.seeall)

local M = class("D6PartFilterItem")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:Awake()
	self._normalGo = goutil.findChild(self.mainGO, "normal")
	self._selectGo = goutil.findChild(self.mainGO, "select")
	self._btn = Astral.ButtonAdapter.Get(self.mainGO)

	self._btn:AddClickListener(self._onClick, self)
end

function M:OnDestroy()
	self.mainGO = nil

	self._btn:RemoveClickListener()
end

function M:_onClick()
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_D6_TAB_CLICK, self._data, self._isSelect)
end

function M:setData(data)
	self._data = data
end

function M:setSelect(isSelect)
	self._isSelect = isSelect

	goutil.setActive(self._normalGo, not isSelect)
	goutil.setActive(self._selectGo, isSelect)
end

return M

-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/recycle/BackpackRecycleViewQuickSelectItem.lua

module("logic.extensions.backpack.view.recycle.BackpackRecycleViewQuickSelectItem", package.seeall)

local M = class("BackpackRecycleViewQuickSelectItem")

function M:ctor(compContainer)
	self.mainGo = compContainer.gameObject
end

function M:Awake()
	self._goSelect = goutil.findChild(self.mainGo, "select")
	self._txtName = goutil.findChildTextComponent(self.mainGo, "normal/Text")
	self._btn = Astral.ButtonAdapter.Get(self.mainGo)

	self._btn:AddClickListener(self._clickBtn, self)
end

function M:OnDestroy()
	self._btn:RemoveClickListener()
end

function M:_clickBtn()
	self._isSelect = not self._isSelect

	goutil.setActive(self._goSelect, self._isSelect)
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_RECYCLE_QUICK_CLICK_EVENT, self._selectType, self._isSelect)
end

function M:setData(seletType, name)
	self._selectType = seletType
	self._txtName.text = name
end

function M:setStatus(isSelect)
	self._isSelect = isSelect

	goutil.setActive(self._goSelect, isSelect)
end

return M

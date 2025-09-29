-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/hotgoods/StoreHotListViewCFItem.lua

module("logic.extensions.store.view.hotgoods.StoreHotListViewCFItem", package.seeall)

local M = class("StoreHotListViewCFItem", StoreHotListViewItem1)

function M:Awake()
	self._goItem1 = goutil.findChild(self._go, "cell1")
	self._goItem2 = goutil.findChild(self._go, "cell2")
	self._item1 = Astral.LuaComponentContainer.Add(self._goItem1, StoreHotListViewCFCell)
	self._item2 = Astral.LuaComponentContainer.Add(self._goItem2, StoreHotListViewCFCell)
end

return M

-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echocardpack/view/EchoCardPackViewItem.lua

module("logic.extensions.echocardpack.view.EchoCardPackViewItem", package.seeall)

local M = class("EchoCardPackViewItem")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
end

function M:Awake()
	self._goItem = goutil.findChild(self._go, "backpack_item")
	self._goUp = goutil.findChild(self._go, "upSign")
	self._itemCell = Astral.LuaComponentContainer.Add(self._goItem, StoreItemCell)
end

function M:updateData(info)
	self._itemCell:updateData(info.itemData)
	goutil.setActive(self._goUp, info.isUp)
end

return M

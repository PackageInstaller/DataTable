-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/view/RoomBackpackDrawingDetailView.lua

module("logic.extensions.housebackpack.view.RoomBackpackDrawingDetailView", package.seeall)

local M = class("RoomBackpackDrawingDetailView", RoomBackpackItemDetailView)

function M:refreshView()
	M.super.refreshView(self)

	local itemData = self._itemData

	IconLoader.setSprite(self._imgIconShadow, IconType.ItemIcon, itemData:getIcon())
	IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, itemData:getIcon())

	local hasItem = itemData:getCount() > 0

	goutil.setActive(self._btnUsing.gameObject, hasItem)
	goutil.setActive(self._btnNotGain.gameObject, not hasItem)
end

function M:_onClickUsingBtn()
	local uid = self._itemData:getUuid()

	if checknumber(uid) > 0 then
		HouseFacade.instance:productFurnitureByPaperId(self._itemData:getItemId())
	else
		FloatWordMgr.instance:show(lang("tip_product_furniture_lang_1"))
	end
end

return M

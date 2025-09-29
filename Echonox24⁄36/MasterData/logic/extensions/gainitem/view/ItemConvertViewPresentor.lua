-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gainitem/view/ItemConvertViewPresentor.lua

module("logic.extensions.gainitem.view.ItemConvertViewPresentor", package.seeall)

local M = class("ItemConvertViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Gainitem_gain_item,
		ResName.Common_Backpack_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ItemConvertView.New())

	return views
end

function M:onClickOutside()
	if ToolTipsController.instance:getInCloseTipsTime() then
		return
	end

	ItemConvertController.instance:clearCache()
	ViewMgr.instance:close(ViewName.ItemConvert)

	if ViewMgr.instance:isOpen(ViewName.GainItemView) then
		ViewMgr.instance:close(ViewName.GainItemView)
	end
end

return M

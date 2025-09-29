-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gainitem/view/GainItemViewPresentor.lua

module("logic.extensions.gainitem.view.GainItemViewPresentor", package.seeall)

local M = class("GainItemViewPresentor", ViewPresentor)

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

	table.insert(views, GainItemView.New())

	self._timelineGadget = GainItemTimelineView.New()

	table.insert(views, self._timelineGadget)

	return views
end

function M:onClickOutside()
	if ToolTipsController.instance:getInCloseTipsTime() then
		return
	end

	if ItemConvertController.instance:hasCache() then
		ItemConvertController.instance:popCacheItemMoList()
	else
		self._timelineGadget:onClickEvent()
	end
end

return M

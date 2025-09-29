-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/ChangeMaskViewPresentor.lua

module("logic.extensions.playerinfo.view.info.ChangeMaskViewPresentor", package.seeall)

local M = class("ChangeMaskViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Playerinfo_mask_view,
		ResName.Playerinfo_mask_item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ChangeMaskView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M

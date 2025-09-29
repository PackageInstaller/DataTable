-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/GainMaskViewPresentor.lua

module("logic.extensions.playerinfo.view.info.GainMaskViewPresentor", package.seeall)

local M = class("GainMaskViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Unlock_mask_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, GainMaskView.New())

	return views
end

return M

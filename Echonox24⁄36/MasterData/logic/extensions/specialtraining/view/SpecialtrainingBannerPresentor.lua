-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/specialtraining/view/SpecialtrainingBannerPresentor.lua

module("logic.extensions.specialtraining.view.SpecialtrainingBannerPresentor", package.seeall)

local M = class("SpecialtrainingBannerPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Specialtraining_Banner
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, SpecialtrainingBanner.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M

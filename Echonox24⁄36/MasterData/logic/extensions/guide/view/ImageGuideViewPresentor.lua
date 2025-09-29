-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/ImageGuideViewPresentor.lua

module("logic.extensions.guide.view.ImageGuideViewPresentor", package.seeall)

local M = class("ImageguidecellViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Guide_imageguideview_copy
	}
end

function M:attachToWhichRoot()
	return ViewRootType.Top
end

function M:buildViews()
	local views = {}

	table.insert(views, ImageGuideView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M

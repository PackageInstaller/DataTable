-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pushgiftpackage/view/PushGiftPackageTipsViewPresentor.lua

module("logic.extensions.pushgiftpackage.view.PushGiftPackageTipsViewPresentor", package.seeall)

local M = class("PushGiftPackageTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Push_push_gift_package_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, PushGiftPackageTipsView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M

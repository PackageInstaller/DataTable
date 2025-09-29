-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthSignin/view/MonthSigninViewPresentor.lua

module("logic.extensions.monthSignin.view.MonthSigninViewPresentor", package.seeall)

local M = class("MonthSigninViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Month_Signin
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, MonthSigninView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

function M:getBlurView()
	return self._views[2]
end

return M

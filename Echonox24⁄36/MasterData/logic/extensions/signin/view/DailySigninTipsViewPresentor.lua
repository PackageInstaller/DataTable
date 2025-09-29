-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signin/view/DailySigninTipsViewPresentor.lua

module("logic.extensions.signin.view.DailySigninTipsViewPresentor", package.seeall)

local M = class("DailySigninTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Daily_signin_daily_signin_panel1,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Wekfare)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, DailySigninTipsView.New())

	return views
end

return M

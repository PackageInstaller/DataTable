-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signin/view/SevenSigninTipsViewPresentor.lua

module("logic.extensions.signin.view.SevenSigninTipsViewPresentor", package.seeall)

local M = class("SevenSigninTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.SignIn_Tips_SignInSeven,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Wekfare)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, SevenSigninTipsView.New())
	table.insert(views, BlurBgView.New(nil, 2, 4))

	return views
end

function M:onClickOutside()
	return
end

return M

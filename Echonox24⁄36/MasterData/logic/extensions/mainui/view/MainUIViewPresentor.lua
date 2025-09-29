-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainUIViewPresentor.lua

module("logic.extensions.mainui.view.MainUIViewPresentor", package.seeall)

local M = class("MainUIViewPresentor", ViewPresentor)

M.PickerUrl = BattleResourceName.UIScenePicker

function M:dependWhatResources()
	return {
		ResName.MainUI_MainUI_View,
		M.PickerUrl,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_LoadingMain),
		IconLoader.getSpriteAtlasUrl(IconType.Skinlib),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Room),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_MainView)
	}
end

function M:attachToWhichRoot()
	return ViewRootType.Hud
end

function M:buildViews()
	local views = {
		MainUIView.New(),
		PlayerInfoView.New(),
		MainUIDialogueView.New(),
		ChatMsgTipsView.New(),
		MainUIActBannerView.New(),
		MainUITargetChaseView.New(),
		MainUISeasonView.New(),
		MainUIMailView.New()
	}

	return views
end

return M

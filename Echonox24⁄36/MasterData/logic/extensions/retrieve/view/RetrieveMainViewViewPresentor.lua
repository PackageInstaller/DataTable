-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveMainViewViewPresentor.lua

module("logic.extensions.retrieve.view.RetrieveMainViewViewPresentor", package.seeall)

local M = class("RetrieveMainViewViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.RetrieveMainView,
		BattleResourceName.UIScenePicker,
		CommonResPath.Url_Currency_Item,
		ResName.Common_Backpack_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_RetrieveMainView)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RetrieveMainViewView.New())
	table.insert(views, RetrievePrayView.New())
	table.insert(views, MoneyView.New())

	return views
end

return M

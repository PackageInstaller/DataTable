-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveTenCardShowViewViewPresentor.lua

module("logic.extensions.retrieve.view.RetrieveTenCardShowViewViewPresentor", package.seeall)

local M = class("RetrieveTenCardShowViewViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.RetrieveTenCardShowViewView,
		ResName.RetrieveCardSceneItem,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RetrieveTenCardShowViewView.New())
	table.insert(views, MoneyView.New())

	return views
end

return M

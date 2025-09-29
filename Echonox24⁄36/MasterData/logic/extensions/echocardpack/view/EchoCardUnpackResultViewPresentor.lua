-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echocardpack/view/EchoCardUnpackResultViewPresentor.lua

module("logic.extensions.echocardpack.view.EchoCardUnpackResultViewPresentor", package.seeall)

local M = class("EchoCardUnpackResultViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.EchoCardUnpackResultView,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem_Com)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, EchoCardUnpackResultView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.DefaultHideType))

	return views
end

return M

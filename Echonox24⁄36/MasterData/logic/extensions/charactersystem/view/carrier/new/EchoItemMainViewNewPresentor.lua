-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/new/EchoItemMainViewNewPresentor.lua

module("logic.extensions.charactersystem.view.carrier.new.EchoItemMainViewNewPresentor", package.seeall)

local M = class("EchoItemMainViewNewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Carryitem_new_echo_view_copy,
		ResName.Common_Backpack_Item,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem_Com)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, EchoItemMainViewNew.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.DefaultHideType))
	table.insert(views, TitleView.New():blockOrgBtn(true, true, false))

	return views
end

function M:captureBg(camCode, layerMask)
	return
end

return M

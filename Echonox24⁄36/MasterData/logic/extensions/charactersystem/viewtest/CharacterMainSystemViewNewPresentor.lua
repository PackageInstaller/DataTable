-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/viewtest/CharacterMainSystemViewNewPresentor.lua

module("logic.extensions.charactersystem.viewtest.CharacterMainSystemViewNewPresentor", package.seeall)

local M = class("CharacterMainSystemViewNewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Charactersystem_character_system_main_view_copy,
		ResName.CharacterSystem_SubView_Detail,
		ResName.CharacterSystem_Authority_Node,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Backpack),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem_Com),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem_Detail),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem_Authority),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Language)
	}
end

function M:buildViews()
	local views = {}

	self._mainSystemView = CharacterMainSystemViewNew.New()
	self._blurBgView = CaptureSceneView.New()

	self._blurBgView:setNoWorkOnEnter(true)
	table.insert(views, self._mainSystemView)
	table.insert(views, self._blurBgView)
	table.insert(views, TitleView.New():blockOrgBtn(true, true, true))

	return views
end

function M:getMainSystemView()
	return self._mainSystemView
end

function M:getBlurBgView()
	return self._blurBgView
end

return M

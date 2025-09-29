-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/alienation/HandbookEchoDetailViewPresentor.lua

module("logic.extensions.playerinfo.view.handbook.alienation.HandbookEchoDetailViewPresentor", package.seeall)

local M = class("HandbookEchoDetailViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Handbook_handbook_alienation_carry_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HandbookEchoDetailView.New())

	return views
end

return M

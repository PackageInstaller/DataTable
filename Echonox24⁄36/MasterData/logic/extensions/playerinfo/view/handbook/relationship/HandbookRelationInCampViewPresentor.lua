-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/relationship/HandbookRelationInCampViewPresentor.lua

module("logic.extensions.playerinfo.view.handbook.relationship.HandbookRelationInCampViewPresentor", package.seeall)

local M = class("HandbookRelationInCampViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Handbook_handbook_relationship_hero_view,
		ResName.Handbook_handbook_relationship_hero_item,
		ResName.Handbook_handbook_relationship_team
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HandbookRelationInCampView.New())

	return views
end

return M

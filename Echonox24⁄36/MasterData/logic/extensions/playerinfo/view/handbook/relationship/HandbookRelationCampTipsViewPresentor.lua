-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/relationship/HandbookRelationCampTipsViewPresentor.lua

module("logic.extensions.playerinfo.view.handbook.relationship.HandbookRelationCampTipsViewPresentor", package.seeall)

local M = class("HandbookRelationCampTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Handbook_handbook_relationship_camp_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HandbookRelationCampTipsView.New())

	return views
end

return M

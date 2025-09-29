-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/relationship/heroinfo/HandbookHeroIntelligenceViewPresentor.lua

module("logic.extensions.playerinfo.view.handbook.relationship.heroinfo.HandbookHeroIntelligenceViewPresentor", package.seeall)

local M = class("HandbookHeroIntelligenceViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Intelligence_character_intelligence_view_copy,
		ResName.Intelligence_cloth_item,
		CommonResPath.Url_Currency_Item,
		ResName.Intelligence_background_item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HandbookHeroIntelligenceView.New())

	return views
end

function M:onClickOutside()
	ViewMgr.instance:close(ViewName.HandbookHeroIntelligenceView)
end

return M

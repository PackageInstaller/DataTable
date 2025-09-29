-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/intelligence/CharacterIntelligenceViewViewPresentor.lua

module("logic.extensions.charactersystem.view.intelligence.CharacterIntelligenceViewViewPresentor", package.seeall)

local M = class("CharacterIntelligenceViewViewPresentor", ViewPresentor)

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

	table.insert(views, CharacterIntelligenceView.New())

	return views
end

function M:onClickOutside()
	ViewMgr.instance:close(ViewName.CharacterIntelligenceViewViewPresentor)
end

return M

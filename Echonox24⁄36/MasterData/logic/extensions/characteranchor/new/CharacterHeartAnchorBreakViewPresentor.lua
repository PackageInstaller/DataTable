-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characteranchor/new/CharacterHeartAnchorBreakViewPresentor.lua

module("logic.extensions.characteranchor.new.CharacterHeartAnchorBreakViewPresentor", package.seeall)

local M = class("CharacterHeartAnchorBreakViewPresentor", ViewPresentor)

BlackFadePresentorWrapper.extend(M)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.CharacterSystem_heart_anchor_view,
		ResName.CharacterSystem_heart_anchor_course_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem_HeartAnchor)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterHeartAnchorBreakView.New())

	return views
end

return M

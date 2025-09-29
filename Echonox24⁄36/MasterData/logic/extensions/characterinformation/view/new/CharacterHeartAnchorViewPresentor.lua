-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/new/CharacterHeartAnchorViewPresentor.lua

module("logic.extensions.characterinformation.view.new.CharacterHeartAnchorViewPresentor", package.seeall)

local M = class("CharacterHeartAnchorViewPresentor", ViewPresentor)

BlackFadePresentorWrapper.extend(M)

function M:dependWhatResources()
	return {
		ResName.CharacterSystem_heart_anchor_view,
		ResName.CharacterSystem_heart_anchor_course_view,
		ResName.CharacterSystem_heart_anchor_impression_view,
		ResName.Common_Top_Toast_Reward_Notice,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem_HeartAnchor)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterHeartAnchorView.New())

	return views
end

return M

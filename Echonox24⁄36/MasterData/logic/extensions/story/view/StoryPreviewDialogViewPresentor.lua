-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryPreviewDialogViewPresentor.lua

module("logic.extensions.story.view.StoryPreviewDialogViewPresentor", package.seeall)

local M = class("StoryPreviewDialogViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Story_story_preview_dialog
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, StoryPreviewDialogView.New())

	return views
end

return M

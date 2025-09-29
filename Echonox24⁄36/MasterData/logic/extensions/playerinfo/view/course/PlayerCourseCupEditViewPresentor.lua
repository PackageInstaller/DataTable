-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/PlayerCourseCupEditViewPresentor.lua

module("logic.extensions.playerinfo.view.course.PlayerCourseCupEditViewPresentor", package.seeall)

local M = class("PlayerCourseCupEditViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Course_show_syndrome_change_tips,
		ResName.Course_player_course_card_item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, PlayerCourseCupEditView.New())

	return views
end

return M

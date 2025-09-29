-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/PlayerCourseDiaryViewPresentor.lua

module("logic.extensions.playerinfo.view.course.PlayerCourseDiaryViewPresentor", package.seeall)

local M = class("PlayerCourseDiaryViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Course_player_course_trailing_panel
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, PlayerCourseDiaryView.New())
	table.insert(views, TitleView.New())

	return views
end

return M

-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/PlayerCourseHeroEditViewPresentor.lua

module("logic.extensions.playerinfo.view.course.PlayerCourseHeroEditViewPresentor", package.seeall)

local M = class("PlayerCourseHeroEditViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Course_show_role_change_tips,
		ResName.Course_player_course_hero_item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Room)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, PlayerCourseHeroEditView.New())

	return views
end

return M

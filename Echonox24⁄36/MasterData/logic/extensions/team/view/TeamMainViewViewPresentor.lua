-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/team/view/TeamMainViewViewPresentor.lua

module("logic.extensions.team.view.TeamMainViewViewPresentor", package.seeall)

local M = class("TeamMainViewViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Team_team_main_view,
		ViewlibResPath.SkillItem1,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Team),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Battle),
		ResName.Textures_s510_plane_zy_bai_d,
		ResName.Textures_s510_plane_zy_nuo_d,
		ResName.Textures_s510_plane_zy_oad_d,
		ResName.Textures_s510_plane_zy_xing_d,
		ResName.Textures_s510_plane_zy_ya_d,
		ResName.Textures_s510_plane_zy_zhenli_d,
		ResName.Textures_s510_plane_zy_shui_d
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, TeamMainViewView.New())

	return views
end

return M

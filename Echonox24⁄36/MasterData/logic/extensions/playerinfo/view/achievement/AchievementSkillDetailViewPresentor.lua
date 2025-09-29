-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/achievement/AchievementSkillDetailViewPresentor.lua

module("logic.extensions.playerinfo.view.achievement.AchievementSkillDetailViewPresentor", package.seeall)

local M = class("AchievementSkillDetailViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Playerinfo_achievement_skill_detail,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AchievementSkillDetailView.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.OnlyDiamondShowType))
	table.insert(views, TitleView.New())

	return views
end

return M

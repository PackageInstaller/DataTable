-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/BirthdayEditTipsViewPresentor.lua

module("logic.extensions.playerinfo.view.info.BirthdayEditTipsViewPresentor", package.seeall)

local M = class("BirthdayEditTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Playerinfo_birth_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, BirthdayEditTipsView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M

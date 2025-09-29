-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/viewtest/CharacterCareerIntroductionViewPresentor.lua

module("logic.extensions.charactersystem.viewtest.CharacterCareerIntroductionViewPresentor", package.seeall)

local M = class("CharacterCareerIntroductionViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Career_Introduction_Tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterCareerIntroductionView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M

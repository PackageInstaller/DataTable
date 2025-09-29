-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/view/ScenePickerViewPresentor.lua

module("logic.scene.view.ScenePickerViewPresentor", package.seeall)

local M = class("ScenePickerViewPresentor", ViewPresentor)

M.MainUrl = BattleResourceName.UIScenePicker

function M:dependWhatResources()
	return {
		self.MainUrl
	}
end

function M:attachToWhichRoot()
	return ViewRootType.Hud
end

function M:buildViews()
	local views = {}

	table.insert(views, ScenePickerView.New())

	return views
end

return M

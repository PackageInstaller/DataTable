-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/MasterTrainingTask/view/MasterTrainingTaskViewPresentor.lua

module("logic.extensions.MasterTrainingTask.view.MasterTrainingTaskViewPresentor", package.seeall)

local M = class("MasterTrainingTaskViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Training_supervisor_training_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, MasterTrainingTaskView.New())

	return views
end

return M

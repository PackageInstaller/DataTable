-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/view/TaskMainViewViewPresentor.lua

module("logic.extensions.task.view.TaskMainViewViewPresentor", package.seeall)

local M = class("TaskMainViewViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Task_task_main_view_copy,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Task)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, TaskView.New())
	table.insert(views, TitleView.New())
	table.insert(views, MoneyView.New())

	return views
end

return M

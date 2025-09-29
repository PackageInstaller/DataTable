-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/task/RogueTaskViewPresentor.lua

module("logic.extensions.roguelike.view.explore.task.RogueTaskViewPresentor", package.seeall)

local M = class("RogueTaskViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupother_rungroup_task_main_view,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Task)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueTaskView.New())
	table.insert(views, TitleView.New(CommEnum.ManualKey.RogueTask))
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.MallRoguelikeShowType))

	return views
end

return M

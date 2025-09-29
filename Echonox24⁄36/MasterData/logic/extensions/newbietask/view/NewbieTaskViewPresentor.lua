-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbietask/view/NewbieTaskViewPresentor.lua

module("logic.extensions.newbietask.view.NewbieTaskViewPresentor", package.seeall)

local M = class("NewbieTaskViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Newhand_task_newhand_task_view,
		IconLoader.getSpriteAtlasUrl(IconType.Skinlib),
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_CharacterSystem_Com)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, NewbieTaskView.New())
	table.insert(views, TitleView.New())

	return views
end

return M

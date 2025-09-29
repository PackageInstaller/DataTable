-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/PlayerCourseRoguelikeView.lua

module("logic.extensions.playerinfo.view.course.PlayerCourseRoguelikeView", package.seeall)

local M = class("PlayerCourseRoguelikeView", ViewComponent)

function M:ctor()
	return
end

function M:buildUI()
	local scrollGO = self:getGo("player_course_rungroup_panel_395821548")

	self._gridScroll = LoopGridViewHelper.New(scrollGO)

	self._gridScroll:InitGridView(0, self._updateGrid, self)
end

function M:destroyUI()
	self._gridScroll:Dispose()

	self._gridScroll = nil
end

function M:onEnter()
	self._listData = PlayerCourseModel.instance:getDisplayData(GameEnum.DisplayTypeEnum.Roguelike):getRoguelikeList()

	self._gridScroll:SetListItemCount(#self._listData, true)
	self._gridScroll:RefreshAllShownItem()
end

function M:onExit()
	self._listData = nil

	self._gridScroll:ClearCells()
end

function M:_updateGrid(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._gridScroll:NewListViewItem("player_course_roguelike_item")
	local component = Astral.LuaComponentContainer.Add(item.gameObject, CourseRoguelikeItem)
	local data = self._listData[curIndex]

	component:setData(data)

	return item
end

return M

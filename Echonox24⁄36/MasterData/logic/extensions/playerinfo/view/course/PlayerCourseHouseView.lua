-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/PlayerCourseHouseView.lua

module("logic.extensions.playerinfo.view.course.PlayerCourseHouseView", package.seeall)

local M = class("PlayerCourseHouseView", ViewComponent)

function M:ctor()
	return
end

function M:buildUI()
	self._btnEdit = self:getBtn("player_course_base_panel_-1188753036")
	self._gridScroll = LoopGridViewHelper.New(self:getGo("player_course_base_panel_-2130536228"))

	self._gridScroll:InitGridView(0, self._updateGrid, self)
end

function M:destroyUI()
	self._gridScroll:Dispose()

	self._gridScroll = nil
	self._btnEdit = nil
end

function M:bindEvents()
	self._btnEdit:AddClickListener(self._onClickEdit, self)
	GlobalDispatcher:addEventListener(EventType.COURSE_SHOW_REFRESH_VIEW, self.onShowContentChanged, self)
end

function M:unbindEvents()
	self._btnEdit:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.COURSE_SHOW_REFRESH_VIEW, self.onShowContentChanged, self)
end

function M:onEnter()
	self._listData = PlayerCourseModel.instance:getDisplayData(GameEnum.DisplayTypeEnum.HouseLiveRoom):getDisplayHouse()

	self._gridScroll:SetListItemCount(5, true)
	self._gridScroll:RefreshAllShownItem()
	goutil.setActive(self._btnEdit.gameObject, PlayerCourseModel.instance:editPermission())
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

	local item = self._gridScroll:NewListViewItem("player_course_house_item")
	local component = Astral.LuaComponentContainer.Add(item.gameObject, CourseHouseItem)

	component:setData(self._listData[curIndex])

	return item
end

function M:onShowContentChanged(_, type)
	if type == GameEnum.DisplayTypeEnum.HouseLiveRoom then
		self:onEnter()
	end
end

function M:_onClickEdit()
	ViewMgr.instance:open(ViewName.PlayerCourseHouseEditView)
end

return M

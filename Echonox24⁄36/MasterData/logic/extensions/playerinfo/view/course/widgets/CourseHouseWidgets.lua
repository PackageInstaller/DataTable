-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/widgets/CourseHouseWidgets.lua

module("logic.extensions.playerinfo.view.course.widgets.CourseHouseWidgets", package.seeall)

local M = class("CourseHouseWidgets", PlayerCourseWidgets)

function M:ctor(view)
	self._view = view
	self._editType = GameEnum.DisplayTypeEnum.HouseLiveRoom
end

function M:buildUI()
	local view = self._view

	self._txtCount = view:getText("player_course_panel_380101016")
	self._txtAtmosphere = view:getText("player_course_panel_1265053403")
	self._btnMore = view:getBtn("player_course_panel_204182540")

	local go = view:getGo("player_course_panel_1932993086")

	return M.super.buildEditUI(self, go)
end

function M:onInit()
	M.super.init(self)

	if not self._locked then
		self._txtCount.text = self._data:getHouseCount()
		self._txtAtmosphere.text = self._data:getHouseAtmosphere()
	end
end

function M:bindEvents()
	self._btnMore:AddClickListener(self._onClickMore, self)
end

function M:unbindEvents()
	self._btnMore:RemoveClickListener()
end

function M:setIsInEdit(isInEdit)
	M.super.setIsInEdit(self, isInEdit)
end

function M:_onClickMore()
	ViewMgr.instance:open(ViewName.PlayerCourseHouseView)
end

function M:destroyUI()
	M.super.destroyUI(self)

	self._txtCount = nil
	self._txtAtmosphere = nil
	self._btnMore = nil
end

return M

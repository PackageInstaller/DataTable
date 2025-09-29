-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/widgets/CourseCupWidgets.lua

module("logic.extensions.playerinfo.view.course.widgets.CourseCupWidgets", package.seeall)

local M = class("CourseCupWidgets", PlayerCourseWidgets)

function M:ctor(view)
	self._view = view
	self._editType = GameEnum.DisplayTypeEnum.Cup
end

function M:buildUI()
	local view = self._view
	local cupRoot = view:getGo("player_course_panel_611283289")

	self._cupItems = {}

	for i = 1, 5 do
		local go = goutil.findChild(cupRoot, string.format("player_course_card_item%s", i))
		local item = Astral.LuaComponentContainer.Add(go, CourseCupItem)

		item:AddClickListener(self.onClickCup, self)
		item:AddEditClickListener(self.onClickCupEdit, self)

		self._cupItems[i] = item
	end

	local go = view:getGo("player_course_panel_1239124103")

	return M.super.buildEditUI(self, go)
end

function M:onInit()
	M.super.init(self)
	self:setCupUI()
end

function M:bindEvents()
	GlobalDispatcher:addEventListener(EventType.COURSE_SHOW_REFRESH_VIEW, self.onShowContentChanged, self)
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.COURSE_SHOW_REFRESH_VIEW, self.onShowContentChanged, self)
end

function M:setCupUI()
	local items = self._cupItems
	local cupInfo = self._data:getDisplayCup()
	local showCount = #cupInfo

	for i = 1, showCount do
		items[i]:setCup(cupInfo[i])
	end

	for i = showCount + 1, 5 do
		items[i]:showCup(false)
	end
end

function M:setIsInEdit(isInEdit)
	M.super.setIsInEdit(self, isInEdit)

	for i = 1, 5 do
		self._cupItems[i]:showEdit(isInEdit)
	end
end

function M:onShowContentChanged(_, type)
	if type == self._editType then
		self:setCupUI()
	end
end

function M:onClickCup(id)
	local cupInfo = self._data:getDisplayCup()
	local cupList = {}
	local index = 0

	for i, v in ipairs(cupInfo) do
		table.insert(cupList, v.mo)

		if id == v.mo:getId() then
			index = i
		end
	end

	ViewMgr.instance:open(ViewName.MonumentLookOver, {
		index = index,
		list = cupList
	})
end

function M:onClickCupEdit()
	ViewMgr.instance:open(ViewName.PlayerCourseCupEditView)
end

function M:destroyUI()
	M.super.destroyUI(self)

	self._cupItems = nil
end

return M

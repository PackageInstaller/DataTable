-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/widgets/PlayerCourseWidgets.lua

module("logic.extensions.playerinfo.view.course.widgets.PlayerCourseWidgets", package.seeall)

local M = class("PlayerCourseWidgets")

function M:ctor()
	return
end

function M:buildEditUI(go)
	self._normalGo = goutil.findChild(go, "normal")
	self._hideGo = goutil.findChild(go, "hide")
	self._lockGo = goutil.findChild(go, "lock")
	self._editGo = goutil.findChild(go, "editDrop")
	self._editDropdown = self._editGo:GetComponent(UIComponentType.DropdownApapter)

	return self
end

function M:init()
	self:initData()
	self:initUI()
end

function M:initData()
	self._visitType = PlayerCourseModel.instance:getVisitType()
	self._userId = PlayerCourseModel.instance:getCourseUserId()
	self._locked = PlayerCourseModel.instance:isLock(self._editType)
	self._data = PlayerCourseModel.instance:getDisplayData(self._editType)
end

function M:onClear()
	self._locked = false
	self._visitType = false
	self._userId = false
	self._data = nil
end

function M:destroyUI()
	self._normalGo = nil
	self._hideGo = nil
	self._lockGo = nil
	self._editGo = nil
	self._editDropdown = nil
end

function M:initUI()
	self:setIsInEdit(false)

	if self._locked then
		goutil.setActive(self._lockGo, true)
		goutil.setActive(self._normalGo, false)
		goutil.setActive(self._hideGo, false)
	else
		goutil.setActive(self._lockGo, false)

		local limit = PlayerCourseModel.instance:getEditInfo(self._editType)
		local notCanSee = self._visitType ~= PlayerCourseConst.VisitorType.Self and limit < self._visitType

		goutil.setActive(self._hideGo, notCanSee)
		goutil.setActive(self._normalGo, not notCanSee)
	end
end

function M:setIsInEdit(isInEdit)
	goutil.setActive(self._editGo, isInEdit)

	if isInEdit then
		local result = PlayerCourseModel.instance:getEditInfo(self._editType)
		local viewIndex = PlayerCourseConst.Edit2View[result]

		if viewIndex ~= self._editDropdown.dropdown.value then
			self._editDropdown.dropdown.value = viewIndex
		end
	end
end

function M:getEditValue()
	local index = self._editDropdown.dropdown.value
	local value = PlayerCourseConst.View2Edit[index]

	return value
end

function M:getEditType()
	return self._editType
end

return M

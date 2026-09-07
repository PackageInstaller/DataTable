local TaskEmptyListPage = class("TaskEmptyListPage", import("..base.BaseSubView"))

function TaskEmptyListPage:getUIName()
	return "TaskEmptyListUI"
end

function TaskEmptyListPage:OnLoaded()
	self._tf:SetSiblingIndex(1)
	setText(findTF(self._tf, "Text"), i18n("list_empty_tip_taskscene"))

	return
end

function TaskEmptyListPage:OnInit()
	self.isShowUI = false

	return
end

function TaskEmptyListPage:ShowOrHide(arg_4_1)
	if self.isShowUI == arg_4_1 then
		return
	end

	if arg_4_1 then
		self:Show()
	else
		self:Hide()
	end

	self.isShowUI = arg_4_1

	return
end

return TaskEmptyListPage

local BaseEmptyListPage = class("BaseEmptyListPage", import("..base.BaseSubView"))

function BaseEmptyListPage:getUIName()
	return "TaskEmptyListUI"
end

function BaseEmptyListPage:OnLoaded()
	self._tf:SetSiblingIndex(1)

	return
end

function BaseEmptyListPage:OnInit()
	self.isShowUI = false

	return
end

function BaseEmptyListPage:SetEmptyText(arg_4_1)
	setText(findTF(self._tf, "Text"), arg_4_1)

	return
end

function BaseEmptyListPage:SetPosY(arg_5_1)
	setAnchoredPosition(self._tf, arg_5_1)

	return
end

function BaseEmptyListPage:ShowOrHide(arg_6_1)
	if self.isShowUI == arg_6_1 then
		return
	end

	if arg_6_1 then
		self:Show()
	else
		self:Hide()
	end

	self.isShowUI = arg_6_1

	return
end

return BaseEmptyListPage

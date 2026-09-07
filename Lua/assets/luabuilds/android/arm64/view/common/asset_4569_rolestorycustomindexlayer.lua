local RoleStoryCustomIndexLayer = class("RoleStoryCustomIndexLayer", import("..common.CustomIndexLayer"))

function RoleStoryCustomIndexLayer:getUIName()
	return "RoleStoryCustomIndexUI"
end

function RoleStoryCustomIndexLayer:init()
	RoleStoryCustomIndexLayer.super.init(self)
	setText(self._tf:Find("index_panel/Text"), i18n("memory_filter_title_1"))
	setText(self._tf:Find("index_panel/Text/Text"), i18n("memory_filter_title_2"))

	return
end

function RoleStoryCustomIndexLayer:InitGroup()
	self.onInit = true
	self.contextData.indexDatas = self.contextData.indexDatas or {}
	self.dropdownDic = {}
	self.updateList = {}
	self.simpleDropdownDic = {}

	for iter_3_0, iter_3_1 in pairs(self.contextData.groupList) do
		if iter_3_1.dropdown then
			self:InitDropdown(iter_3_1)
		else
			self:InitCustoms(iter_3_1)
		end
	end

	for iter_3_2, iter_3_3 in ipairs(self.updateList) do
		iter_3_3()
	end

	return
end

return RoleStoryCustomIndexLayer

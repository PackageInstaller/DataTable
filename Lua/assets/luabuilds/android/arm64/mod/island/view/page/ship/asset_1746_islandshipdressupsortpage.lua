local IslandShipDressUpSortPage = class("IslandShipDressUpSortPage", import("view.base.BaseSubView"))

function IslandShipDressUpSortPage:getUIName()
	return "IslandDressUpSortUI"
end

function IslandShipDressUpSortPage:OnLoaded()
	self.sortUIItemList = UIItemList.New(self._tf:Find("frame"), self._tf:Find("frame/tpl"))

	return
end

function IslandShipDressUpSortPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function IslandShipDressUpSortPage:Show(arg_5_1, arg_5_2)
	IslandShipDressUpSortPage.super.Show(self)

	self.indexData = arg_5_1
	self.callback = arg_5_2

	self:InitList()

	return
end

function IslandShipDressUpSortPage:InitList()
	self.sortUIItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			local var_7_0 = IslandShipDressUpPageNew.SORT_LIST[arg_7_1 + 1]

			setText(arg_7_2:Find("Text"), setColorStr(IslandShipDressUpPageNew.Sort2CN(IslandShipDressUpPageNew.SORT_LIST[arg_7_1 + 1]), self.indexData.sortKey == IslandShipDressUpPageNew.SORT_LIST[arg_7_1 + 1] and "#393a3c" or "#7c7e81"))
			onButton(self, arg_7_2, function()
				if self.callback then
					self.callback(var_7_0)
				end

				self:Hide()

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.sortUIItemList:align(#IslandShipDressUpPageNew.SORT_LIST)

	return
end

function IslandShipDressUpSortPage:Hide()
	IslandShipDressUpSortPage.super.Hide(self)

	self.callback = nil

	return
end

function IslandShipDressUpSortPage:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return IslandShipDressUpSortPage

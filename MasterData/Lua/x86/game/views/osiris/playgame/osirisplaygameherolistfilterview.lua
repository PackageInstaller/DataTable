local OsirisPlayGameHeroListFilterView = class("OsirisPlayGameHeroListFilterView", (import("game.views.newHero.NewHeroListFilterView")))

function OsirisPlayGameHeroListFilterView:AddUIListeners()
	self:AddBtnListener(self.sortBtn_, nil, function()
		self:SortListByOrder(self.orderController_:GetSelectedState() == "asc" and "desc" or "asc")
	end)
	self:AddToggleListener(self.sortTypeDropdown_, function(arg_3_0)
		self:RefreshDropDownOptions()
		self:SortListByType(arg_3_0)
	end)
	self:AddBtnListener(self.allBtn_, nil, function()
		JumpTools.OpenPageByJump("commonFilterView", {
			filterGroup = Filter_Root_Define.Osiris_Hero_Filter_List
		})
	end)
end

function OsirisPlayGameHeroListFilterView:RefreshSort(arg_5_1)
	if not self.available_ then
		return
	end

	self.displayHeroDataList_ = HeroTools.GetHeroShowData(self.heroDataList_, arg_5_1, Filter_Root_Define.Osiris_Hero_Filter_List.filter_id)

	self:UpdateList()
	self:RenderFilterBtn()
end

function OsirisPlayGameHeroListFilterView:RenderFilterBtn()
	if self.filterColorController_ then
		if CommonFilterData:AtLeastOneChoose(Filter_Root_Define.Osiris_Hero_Filter_List.filter_id) then
			self.filterColorController_:SetSelectedState("orange")
		else
			self.filterColorController_:SetSelectedState("normal")
		end
	end
end

return OsirisPlayGameHeroListFilterView

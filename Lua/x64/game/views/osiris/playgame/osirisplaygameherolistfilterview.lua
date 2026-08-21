local var_0_0 = import("game.views.newHero.NewHeroListFilterView")
local var_0_1 = class("OsirisPlayGameHeroListFilterView", var_0_0)

function var_0_1.AddUIListeners(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.sortBtn_, nil, function()
		local var_2_0 = arg_1_0.orderController_:GetSelectedState() == "asc" and "desc" or "asc"

		arg_1_0:SortListByOrder(var_2_0)
	end)
	arg_1_0:AddToggleListener(arg_1_0.sortTypeDropdown_, function(arg_3_0)
		arg_1_0:RefreshDropDownOptions()
		arg_1_0:SortListByType(arg_3_0)
	end)
	arg_1_0:AddBtnListener(arg_1_0.allBtn_, nil, function()
		JumpTools.OpenPageByJump("commonFilterView", {
			filterGroup = Filter_Root_Define.Osiris_Hero_Filter_List
		})
	end)
end

function var_0_1.RefreshSort(arg_5_0, arg_5_1)
	if not arg_5_0.available_ then
		return
	end

	arg_5_0.displayHeroDataList_ = HeroTools.GetHeroShowData(arg_5_0.heroDataList_, arg_5_1, Filter_Root_Define.Osiris_Hero_Filter_List.filter_id)

	arg_5_0:UpdateList()
	arg_5_0:RenderFilterBtn()
end

function var_0_1.RenderFilterBtn(arg_6_0)
	if arg_6_0.filterColorController_ then
		if CommonFilterData:AtLeastOneChoose(Filter_Root_Define.Osiris_Hero_Filter_List.filter_id) then
			arg_6_0.filterColorController_:SetSelectedState("orange")
		else
			arg_6_0.filterColorController_:SetSelectedState("normal")
		end
	end
end

return var_0_1

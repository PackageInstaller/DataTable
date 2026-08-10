local var_0_0 = class("EquipRecView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Equip/NewEquipRecommendUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.items_ = {}
	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uiListGo_, EquipRecGroupItem)
end

function var_0_0.indexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, arg_5_0.equipRecIdList_[arg_5_1], arg_5_0.heroId_)
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0.list_:SetPageChangeHandler(handler(arg_6_0, arg_6_0.OnPageChange))
	arg_6_0:AddBtnListener(arg_6_0.prevBtn_, nil, function()
		arg_6_0.list_:SwitchToPage(arg_6_0.pageIndex_ - 1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.nextBtn_, nil, function()
		arg_6_0.list_:SwitchToPage(arg_6_0.pageIndex_ + 1)
	end)
end

function var_0_0.RemoveUIListeners(arg_9_0)
	arg_9_0.list_:SetPageChangeHandler(nil)
end

function var_0_0.OnPageChange(arg_10_0, arg_10_1)
	arg_10_0.pageIndex_ = arg_10_1
	arg_10_0.params_.pageIndex = arg_10_1

	SetActive(arg_10_0.prevBtn_.gameObject, arg_10_1 > 1)
	SetActive(arg_10_0.nextBtn_.gameObject, arg_10_1 < 3)

	if arg_10_0.params_.onPageChange then
		arg_10_0.params_.onPageChange(arg_10_1)
	end
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.heroId_ = arg_11_0.params_.hid
	arg_11_0.cfg = EquipRecommendCfg[arg_11_0.heroId_]
	arg_11_0.equipRecIdList_ = {
		arg_11_0.cfg.equip_list1,
		arg_11_0.cfg.equip_list2,
		arg_11_0.cfg.equip_list3
	}

	if arg_11_0.params_.pageIndex ~= nil and arg_11_0.params_.pageIndex > 0 then
		arg_11_0.list_:StartScroll(3, arg_11_0.params_.pageIndex, true, false)
		arg_11_0.list_:SwitchToPage(arg_11_0.params_.pageIndex)
	else
		arg_11_0.list_:StartScroll(3, 1, true, false)
		arg_11_0.list_:SwitchToPage(1)
	end
end

function var_0_0.OnAddProposal(arg_12_0)
	ShowTips("SUCCESS_SAVE_EQUIP_PROPOSAL")
end

function var_0_0.OnMainHomeViewTop(arg_13_0)
	arg_13_0.params_.pageIndex = nil
end

function var_0_0.OnTop(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_14_0.params_.index = 1

		arg_14_0:Back()

		arg_14_0.scrollPos_ = nil
	end)
end

function var_0_0.OnExit(arg_16_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:RemoveUIListeners()
	arg_17_0:RemoveAllListeners()

	if arg_17_0.items_ then
		for iter_17_0, iter_17_1 in ipairs(arg_17_0.items_) do
			iter_17_1:Dispose()
		end

		arg_17_0.items_ = nil
	end

	if arg_17_0.list_ then
		arg_17_0.list_:Dispose()

		arg_17_0.list_ = nil
	end

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0

local var_0_0 = class("AbyssBossDetailView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Abyss/AbyssBoss"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uiListGo_, AbyssBossDetailItemView)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, arg_6_0.bossIdList_[arg_6_1])
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0.uiList_:SetPageChangeHandler(handler(arg_7_0, arg_7_0.OnPageChange))
	arg_7_0:AddBtnListener(arg_7_0.leftBtn_, nil, function()
		if arg_7_0.pageIndex_ > 1 then
			arg_7_0.pageIndex_ = arg_7_0.pageIndex_ - 1

			arg_7_0.uiList_:SwitchToPage(arg_7_0.pageIndex_)
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.rightBtn_, nil, function()
		if arg_7_0.pageIndex_ < arg_7_0.maxLv_ then
			arg_7_0.pageIndex_ = arg_7_0.pageIndex_ + 1

			arg_7_0.uiList_:SwitchToPage(arg_7_0.pageIndex_)
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.OnPageChange(arg_11_0, arg_11_1)
	arg_11_0.pageIndex_ = arg_11_1

	arg_11_0:RefreshBtn()
end

function var_0_0.RefreshBtn(arg_12_0)
	SetActive(arg_12_0.leftBtn_.gameObject, arg_12_0.pageIndex_ > 1)
	SetActive(arg_12_0.rightBtn_.gameObject, arg_12_0.pageIndex_ < #arg_12_0.bossIdList_)
end

function var_0_0.AddEventListeners(arg_13_0)
	return
end

function var_0_0.OnTop(arg_14_0)
	arg_14_0:UpdateBar()
end

function var_0_0.OnBehind(arg_15_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_16_0)
	arg_16_0:ShowDefaultBar()
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0:AddEventListeners()

	arg_17_0.pageIndex_ = 1
	arg_17_0.bossIdList_ = arg_17_0.params_.bossIdList

	arg_17_0.uiList_:StartScroll(#arg_17_0.bossIdList_)
	arg_17_0:RefreshBtn()
end

function var_0_0.OnExit(arg_18_0)
	arg_18_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.OnMainHomeViewTop(arg_19_0)
	return
end

function var_0_0.OnAbyssRefresh(arg_20_0)
	JumpTools.OpenPageByJump("/abyssMain", {
		refresh = true
	})
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.uiList_ then
		arg_21_0.uiList_:Dispose()

		arg_21_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0

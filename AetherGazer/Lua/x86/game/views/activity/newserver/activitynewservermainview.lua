local var_0_0 = class("ActivityNewServerMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/NewServer/NewServerMenuUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.pageClass = {
		NewServerSignPage,
		NewServerTaskPage,
		NewServerCapsuleToysPage,
		NewServerBPTaskPage,
		NewServerSupplyPage
	}
	arg_4_0.pages_ = {}
	arg_4_0.selectIndex_ = -1
	arg_4_0.clickItemHandler_ = handler(arg_4_0, arg_4_0.SwitchPage)
	arg_4_0.switchItemList_ = {}

	local var_4_0 = arg_4_0.switchPanelTrans_.childCount

	for iter_4_0 = 1, var_4_0 do
		local var_4_1 = arg_4_0.switchPanelTrans_:GetChild(iter_4_0 - 1).gameObject

		arg_4_0.switchItemList_[iter_4_0] = ActivityNewServerSwitchItem.New(var_4_1, iter_4_0)

		arg_4_0.switchItemList_[iter_4_0]:SetClickCallBack(arg_4_0.clickItemHandler_)
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:RegistEventListener(SHOP_LIST_UPDATE, function(arg_6_0)
		arg_5_0:ShopRefresh()
	end)
	arg_5_0:RegistEventListener(SHOP_REFRESH_ALL_SHOP, function(arg_7_0)
		if arg_5_0.curPage_ then
			arg_5_0.curPage_:SetData(arg_5_0.activityID_)
		end
	end)
	arg_5_0:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_8_0, arg_8_1)
		arg_5_0:ShopRefresh()
	end)
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0.curPage_:UpdateBar()
end

function var_0_0.OnEnter(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_10_0.activityID_ = ActivityConst.ACTIVITY_NEW_SERVER

	if arg_10_0.params_.selectIndex then
		arg_10_0.params_.selectIndex = nil
		arg_10_0.params_.Inited = true
	elseif arg_10_0.params_.isBack == true then
		local var_10_0 = arg_10_0.params_.lastIndex

		arg_10_0.selectIndex_ = -1

		arg_10_0:SwitchPage(var_10_0)
	elseif not arg_10_0.params_.Inited then
		arg_10_0.params_.Inited = true
		arg_10_0.selectIndex_ = -1

		arg_10_0:SwitchPage(1)
	end

	arg_10_0:BindRedPoint()
	arg_10_0:RefreshTime()

	arg_10_0.timer_ = Timer.New(function()
		arg_10_0:RefreshTime()
	end, 1, -1)

	arg_10_0.timer_:Start()
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()

	arg_12_0.params_.lastIndex = arg_12_0.selectIndex_

	arg_12_0:RemoveAllEventListener()
	arg_12_0:UnbindRedPoint()

	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end

	if arg_12_0.curPage_ and arg_12_0.curPage_.OnExit then
		arg_12_0.curPage_:OnExit()
		arg_12_0.curPage_:SetActive(false)
	end
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.params_.Inited = nil

	if arg_13_0.curPage_ then
		arg_13_0.curPage_:SetActive(false)

		arg_13_0.curPage_ = nil
	end

	for iter_13_0, iter_13_1 in pairs(arg_13_0.pages_) do
		iter_13_1:Dispose()
	end

	arg_13_0.pages_ = nil

	for iter_13_2, iter_13_3 in ipairs(arg_13_0.switchItemList_) do
		iter_13_3:Dispose()
	end

	arg_13_0.switchItemList_ = nil

	var_0_0.super.Dispose(arg_13_0)
end

function var_0_0.SwitchPage(arg_14_0, arg_14_1)
	if arg_14_1 == arg_14_0.selectIndex_ then
		return
	end

	arg_14_0.selectIndex_ = arg_14_1

	arg_14_0:RefreshSelect()

	if arg_14_0.curPage_ then
		arg_14_0.curPage_:OnExit()
		arg_14_0.curPage_:SetActive(false)
	end

	if not arg_14_0.pages_[arg_14_1] then
		arg_14_0.pages_[arg_14_1] = arg_14_0.pageClass[arg_14_1].New(arg_14_0.contentTrans_)
	end

	arg_14_0.curPage_ = arg_14_0.pages_[arg_14_1]

	arg_14_0.curPage_:SetActive(true)
	arg_14_0.curPage_:OnEnter()

	if arg_14_0.params_.isBack == true then
		if arg_14_0.curPage_.SetIsBack then
			arg_14_0.curPage_:SetIsBack(arg_14_0.params_.isBack)
		end

		arg_14_0.params_.isBack = false
	end

	arg_14_0.curPage_:SetData(arg_14_0.activityID_)
	arg_14_0.curPage_:UpdateBar()
end

function var_0_0.RefreshSelect(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.switchItemList_) do
		iter_15_1:RefreshSelect(arg_15_0.selectIndex_)
	end
end

function var_0_0.RefreshTime(arg_16_0)
	arg_16_0.remainTimeText_.text = string.format(GetTips("LEFT_TIME"), ActivityTools.GetActivityLostTimeStrWith2Unit(arg_16_0.activityID_))

	if arg_16_0.curPage_ and arg_16_0.curPage_.RefreshTime then
		arg_16_0.curPage_:RefreshTime()
	end
end

function var_0_0.OnTaskListChange(arg_17_0)
	if arg_17_0.curPage_ and arg_17_0.curPage_.OnTaskListChange then
		arg_17_0.curPage_:OnTaskListChange()
	end
end

function var_0_0.ShopRefresh(arg_18_0)
	if arg_18_0.curPage_ and arg_18_0.curPage_.RefreshList then
		arg_18_0.curPage_:RefreshList(true)
	end
end

function var_0_0.OnNewServerSign(arg_19_0, arg_19_1)
	if arg_19_0.curPage_ and arg_19_0.curPage_.OnNewServerSign then
		arg_19_0.curPage_:OnNewServerSign(arg_19_1)
	end
end

function var_0_0.OnShopBuyResult(arg_20_0)
	arg_20_0:ShopRefresh()
end

function var_0_0.BindRedPoint(arg_21_0)
	manager.redPoint:bindUIandKey(arg_21_0.switchItemList_[1].transform_, RedPointConst.ACTIVITY_NEW_SERVER_SIGN)
	manager.redPoint:bindUIandKey(arg_21_0.switchItemList_[2].transform_, RedPointConst.ACTIVITY_NEW_SERVER_TASK)
	manager.redPoint:bindUIandKey(arg_21_0.switchItemList_[4].transform_, RedPointConst.ACTIVITY_NEW_SERVER_BP)
	manager.redPoint:bindUIandKey(arg_21_0.switchItemList_[5].transform_, RedPointConst.ACTIVITY_NEW_SERVER_SUPPLY_FREE)
end

function var_0_0.UnbindRedPoint(arg_22_0)
	manager.redPoint:unbindUIandKey(arg_22_0.switchItemList_[1].transform_, RedPointConst.ACTIVITY_NEW_SERVER_SIGN)
	manager.redPoint:unbindUIandKey(arg_22_0.switchItemList_[2].transform_, RedPointConst.ACTIVITY_NEW_SERVER_TASK)
	manager.redPoint:unbindUIandKey(arg_22_0.switchItemList_[4].transform_, RedPointConst.ACTIVITY_NEW_SERVER_BP)
	manager.redPoint:unbindUIandKey(arg_22_0.switchItemList_[5].transform_, RedPointConst.ACTIVITY_NEW_SERVER_SUPPLY_FREE)
end

return var_0_0

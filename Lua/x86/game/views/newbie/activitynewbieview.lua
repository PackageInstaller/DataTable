local var_0_0 = class("ActivityNewbieView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activitynewbie/ActivityNewbieUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.pageClass_ = {
		ActivityNewbieSignView,
		ActivityNewbieTaskView,
		ActivityNewbieUpgradeView,
		ActivityNewbieDailyView,
		ActivityNoobFirstRechargeView,
		NoobMonthlyCardRechargeView,
		ActivityNoobBpRechargeView
	}

	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.tree_ = LuaTree.New(arg_4_0.uiTreeGo_)

	arg_4_0.tree_:SetSelectedHandler(handler(arg_4_0, arg_4_0.OnGroupSelect), handler(arg_4_0, arg_4_0.OnItemSelect))

	arg_4_0.pages_ = {}
	arg_4_0.selectIndex_ = -1
	arg_4_0.selectItemIndex_ = -1
	arg_4_0.rechargeGroupGoList_ = {}
	arg_4_0.rechargeGroupGoList_[1] = arg_4_0.tree_:GetGroupGameObjectById(5)
	arg_4_0.rechargeGroupGoList_[2] = arg_4_0.tree_:GetGroupGameObjectById(6)
	arg_4_0.rechargeGroupGoList_[3] = arg_4_0.tree_:GetGroupGameObjectById(7)
end

function var_0_0.OnEnter(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_5_0:RefreshRecharge()

	if arg_5_0.params_.selectIndex then
		arg_5_0.tree_:SelectGroup(arg_5_0.params_.selectIndex)

		arg_5_0.params_.selectIndex = nil
		arg_5_0.params_.Inited = true
	elseif arg_5_0.params_.isBack == true then
		local var_5_0 = arg_5_0.params_.lastIndex
		local var_5_1 = arg_5_0.params_.lastItemIndex

		arg_5_0.selectIndex_ = -1
		arg_5_0.selectItemIndex_ = -1

		if var_5_1 > 0 then
			arg_5_0.tree_:SelectItem(var_5_0, var_5_1)
		else
			arg_5_0.tree_:SelectGroup(var_5_0)
		end
	elseif not arg_5_0.params_.Inited then
		arg_5_0.params_.Inited = true
		arg_5_0.selectIndex_ = -1
		arg_5_0.selectItemIndex_ = -1

		arg_5_0.tree_:SelectGroup(1)
	end

	manager.redPoint:bindUIandKey(arg_5_0.tree_:GetGroupRedPointContainerById(1), RedPointConst.NEWBIE_SIGN)
	manager.redPoint:bindUIandKey(arg_5_0.tree_:GetGroupRedPointContainerById(2), RedPointConst.NEWBIE_TASK)
	manager.redPoint:bindUIandKey(arg_5_0.tree_:GetGroupRedPointContainerById(3), RedPointConst.NEWBIE_UPGRADE)
	manager.redPoint:bindUIandKey(arg_5_0.tree_:GetGroupRedPointContainerById(4), RedPointConst.NEWBIE_DAILY_TASK)
	manager.redPoint:bindUIandKey(arg_5_0.tree_:GetGroupRedPointContainerById(5), RedPointConst.NOOB_FIRST_RECHARGE)
	manager.redPoint:bindUIandKey(arg_5_0.tree_:GetItemRedPointContainerById(5, 1), RedPointConst.NOOB_FIRST_RECHARGE_1)
	manager.redPoint:bindUIandKey(arg_5_0.tree_:GetItemRedPointContainerById(5, 2), RedPointConst.NOOB_FIRST_RECHARGE_2)
	manager.redPoint:bindUIandKey(arg_5_0.tree_:GetGroupRedPointContainerById(6), RedPointConst.NOOB_MONTHLY_RECHARGE)
	manager.redPoint:bindUIandKey(arg_5_0.tree_:GetGroupRedPointContainerById(7), RedPointConst.NOOB_BP_RECHARGE)
end

function var_0_0.OnExit(arg_6_0)
	manager.windowBar:HideBar()

	if arg_6_0.curPage_ then
		arg_6_0.curPage_:SetActive(false)
	end

	arg_6_0.params_.lastIndex = arg_6_0.selectIndex_
	arg_6_0.params_.lastItemIndex = arg_6_0.selectItemIndex_

	arg_6_0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(arg_6_0.tree_:GetGroupRedPointContainerById(1), RedPointConst.NEWBIE_SIGN)
	manager.redPoint:unbindUIandKey(arg_6_0.tree_:GetGroupRedPointContainerById(2), RedPointConst.NEWBIE_TASK)
	manager.redPoint:unbindUIandKey(arg_6_0.tree_:GetGroupRedPointContainerById(3), RedPointConst.NEWBIE_UPGRADE)
	manager.redPoint:unbindUIandKey(arg_6_0.tree_:GetGroupRedPointContainerById(4), RedPointConst.NEWBIE_DAILY_TASK)
	manager.redPoint:unbindUIandKey(arg_6_0.tree_:GetGroupRedPointContainerById(5), RedPointConst.NOOB_FIRST_RECHARGE)
	manager.redPoint:unbindUIandKey(arg_6_0.tree_:GetItemRedPointContainerById(5, 1), RedPointConst.NOOB_FIRST_RECHARGE_1)
	manager.redPoint:unbindUIandKey(arg_6_0.tree_:GetItemRedPointContainerById(5, 2), RedPointConst.NOOB_FIRST_RECHARGE_2)
	manager.redPoint:unbindUIandKey(arg_6_0.tree_:GetGroupRedPointContainerById(6), RedPointConst.NOOB_MONTHLY_RECHARGE)
	manager.redPoint:unbindUIandKey(arg_6_0.tree_:GetGroupRedPointContainerById(7), RedPointConst.NOOB_BP_RECHARGE)
end

function var_0_0.OnGroupSelect(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_1 == arg_7_0.selectIndex_ then
		return
	end

	arg_7_0:SetSelectPage(arg_7_1)
end

function var_0_0.OnItemSelect(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_0.selectItemIndex_ == arg_8_1 then
		return
	end

	arg_8_0.selectItemIndex_ = arg_8_1

	arg_8_0.curPage_:SetData(arg_8_1)
end

function var_0_0.SetSelectPage(arg_9_0, arg_9_1)
	arg_9_0.selectIndex_ = arg_9_1
	arg_9_0.selectItemIndex_ = -1

	if arg_9_0.curPage_ then
		arg_9_0.curPage_:SetActive(false)
	end

	if not arg_9_0.pages_[arg_9_1] then
		arg_9_0.pages_[arg_9_1] = arg_9_0.pageClass_[arg_9_1].New(arg_9_0.contentTrans_, 2)
	end

	arg_9_0.curPage_ = arg_9_0.pages_[arg_9_1]

	arg_9_0.curPage_:SetActive(true)

	if arg_9_0.params_.isBack == true and arg_9_0.curPage_.SetIsBack then
		arg_9_0.curPage_:SetIsBack(arg_9_0.params_.isBack)

		arg_9_0.params_.isBack = false
	end

	arg_9_0.curPage_:SetData()
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.params_.Inited = nil

	if arg_10_0.curPage_ then
		arg_10_0.curPage_:SetActive(false)

		arg_10_0.curPage_ = nil
	end

	arg_10_0.tree_:Dispose()

	for iter_10_0, iter_10_1 in pairs(arg_10_0.pages_) do
		iter_10_1:Dispose()
	end

	arg_10_0.pages_ = nil
	arg_10_0.rechargeGroupGoList_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.RefreshRecharge(arg_11_0)
	for iter_11_0 = 1, 3 do
		SetActive(arg_11_0.rechargeGroupGoList_[iter_11_0], ActivityNewbieTools.GetRechargeIsOpen(iter_11_0))
	end

	local var_11_0 = ActivityNewbieTools.GetFirstRechargeStatus()

	if var_11_0 and var_11_0.firstGearStatus == 2 then
		arg_11_0.tree_:GetData().groupDatas[4].defaultIndex = 1
	end
end

return var_0_0

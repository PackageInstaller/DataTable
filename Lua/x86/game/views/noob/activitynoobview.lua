local var_0_0 = class("ActivityNoobView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activitynewbie/ActivityNewbieUI_new"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.pageClass_ = {
		ActivityNoobSignView,
		ActivityNoobTaskView,
		ActivityNoobUpgradeView,
		ActivityNoobDailyView,
		ActivityNoobFirstRechargeView,
		NoobMonthlyCardRechargeView,
		ActivityNoobBpRechargeView
	}

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.tree_ = LuaTree.New(arg_4_0.uiTreeGo_)

	arg_4_0.tree_:SetSelectedHandler(handler(arg_4_0, arg_4_0.OnGroupSelect), handler(arg_4_0, arg_4_0.OnItemSelect))

	arg_4_0.pages_ = {}
	arg_4_0.selectIndex_ = -1
	arg_4_0.selectItemIndex_ = -1
	arg_4_0.signCompleteGoList_ = {}

	for iter_4_0 = 1, 2 do
		local var_4_0 = arg_4_0.tree_:GetItemGameObjectById(1, iter_4_0)

		arg_4_0.signCompleteGoList_[iter_4_0] = var_4_0.transform:Find("get").gameObject
	end

	arg_4_0.rechargeGroupGoList_ = {}
	arg_4_0.rechargeGroupGoList_[1] = arg_4_0.tree_:GetGroupGameObjectById(5)
	arg_4_0.rechargeGroupGoList_[2] = arg_4_0.tree_:GetGroupGameObjectById(6)
	arg_4_0.rechargeGroupGoList_[3] = arg_4_0.tree_:GetGroupGameObjectById(7)
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.OnTop(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_7_0, arg_7_1)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_7_0:RefreshSignGroup()
	arg_7_0:RefreshRecharge()

	if arg_7_0.params_.selectIndex then
		arg_7_0.tree_:SelectGroup(arg_7_0.params_.selectIndex)

		arg_7_0.params_.selectIndex = nil
		arg_7_0.params_.Inited = true
	elseif arg_7_1.isBack == true then
		local var_7_0 = arg_7_0.params_.lastIndex
		local var_7_1 = arg_7_0.params_.lastItemIndex

		arg_7_0.selectIndex_ = -1
		arg_7_0.selectItemIndex_ = -1

		if var_7_1 > 0 then
			arg_7_0.tree_:SelectItem(var_7_0, var_7_1)
		else
			arg_7_0.tree_:SelectGroup(var_7_0)
		end
	elseif not arg_7_0.params_.Inited then
		arg_7_0.params_.Inited = true
		arg_7_0.selectIndex_ = -1
		arg_7_0.selectItemIndex_ = -1

		arg_7_0.tree_:SelectGroup(arg_7_0.defaultGroupIndex_)
	end

	manager.redPoint:bindUIandKey(arg_7_0.tree_:GetGroupRedPointContainerById(1), RedPointConst.NEWBIE_SIGN)
	manager.redPoint:bindUIandKey(arg_7_0.tree_:GetItemRedPointContainerById(1, 1), RedPointConst.NEWBIE_SIGN .. "_1")
	manager.redPoint:bindUIandKey(arg_7_0.tree_:GetItemRedPointContainerById(1, 2), RedPointConst.NEWBIE_SIGN .. "_2")
	manager.redPoint:bindUIandKey(arg_7_0.tree_:GetGroupRedPointContainerById(2), RedPointConst.NEWBIE_TASK)
	manager.redPoint:bindUIandKey(arg_7_0.tree_:GetGroupRedPointContainerById(3), RedPointConst.NEWBIE_UPGRADE)
	manager.redPoint:bindUIandKey(arg_7_0.tree_:GetGroupRedPointContainerById(4), RedPointConst.NEWBIE_DAILY_TASK)
	manager.redPoint:bindUIandKey(arg_7_0.tree_:GetGroupRedPointContainerById(5), RedPointConst.NOOB_FIRST_RECHARGE)
	manager.redPoint:bindUIandKey(arg_7_0.tree_:GetItemRedPointContainerById(5, 1), RedPointConst.NOOB_FIRST_RECHARGE_1)
	manager.redPoint:bindUIandKey(arg_7_0.tree_:GetItemRedPointContainerById(5, 2), RedPointConst.NOOB_FIRST_RECHARGE_2)
	manager.redPoint:bindUIandKey(arg_7_0.tree_:GetGroupRedPointContainerById(6), RedPointConst.NOOB_MONTHLY_RECHARGE)
	manager.redPoint:bindUIandKey(arg_7_0.tree_:GetGroupRedPointContainerById(7), RedPointConst.NOOB_BP_RECHARGE)
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()

	if arg_8_0.curPage_ then
		arg_8_0.curPage_:SetActive(false)
	end

	arg_8_0.params_.lastIndex = arg_8_0.selectIndex_
	arg_8_0.params_.lastItemIndex = arg_8_0.selectItemIndex_

	arg_8_0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(arg_8_0.tree_:GetGroupRedPointContainerById(1), RedPointConst.NEWBIE_SIGN)
	manager.redPoint:unbindUIandKey(arg_8_0.tree_:GetItemRedPointContainerById(1, 1), RedPointConst.NEWBIE_SIGN .. "_1")
	manager.redPoint:unbindUIandKey(arg_8_0.tree_:GetItemRedPointContainerById(1, 2), RedPointConst.NEWBIE_SIGN .. "_2")
	manager.redPoint:unbindUIandKey(arg_8_0.tree_:GetGroupRedPointContainerById(2), RedPointConst.NEWBIE_TASK)
	manager.redPoint:unbindUIandKey(arg_8_0.tree_:GetGroupRedPointContainerById(3), RedPointConst.NEWBIE_UPGRADE)
	manager.redPoint:unbindUIandKey(arg_8_0.tree_:GetGroupRedPointContainerById(4), RedPointConst.NEWBIE_DAILY_TASK)
	manager.redPoint:unbindUIandKey(arg_8_0.tree_:GetGroupRedPointContainerById(5), RedPointConst.NOOB_FIRST_RECHARGE)
	manager.redPoint:unbindUIandKey(arg_8_0.tree_:GetItemRedPointContainerById(5, 1), RedPointConst.NOOB_FIRST_RECHARGE_1)
	manager.redPoint:unbindUIandKey(arg_8_0.tree_:GetItemRedPointContainerById(5, 2), RedPointConst.NOOB_FIRST_RECHARGE_2)
	manager.redPoint:unbindUIandKey(arg_8_0.tree_:GetGroupRedPointContainerById(6), RedPointConst.NOOB_MONTHLY_RECHARGE)
	manager.redPoint:unbindUIandKey(arg_8_0.tree_:GetGroupRedPointContainerById(7), RedPointConst.NOOB_BP_RECHARGE)
end

function var_0_0.OnGroupSelect(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_1 == arg_9_0.selectIndex_ then
		return
	end

	arg_9_0:SetSelectPage(arg_9_1)
end

function var_0_0.OnItemSelect(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_0.selectItemIndex_ == arg_10_1 then
		return
	end

	arg_10_0.selectItemIndex_ = arg_10_1

	arg_10_0.curPage_:SetData(arg_10_1)
end

function var_0_0.SetSelectPage(arg_11_0, arg_11_1)
	arg_11_0.selectIndex_ = arg_11_1
	arg_11_0.selectItemIndex_ = -1

	if arg_11_0.curPage_ then
		arg_11_0.curPage_:SetActive(false)
	end

	if not arg_11_0.pages_[arg_11_1] then
		arg_11_0.pages_[arg_11_1] = arg_11_0.pageClass_[arg_11_1].New(arg_11_0.contentTrans_, 0)
	end

	arg_11_0.curPage_ = arg_11_0.pages_[arg_11_1]

	arg_11_0.curPage_:SetActive(true)

	if arg_11_0.params_.isBack == true and arg_11_0.curPage_.SetIsBack then
		arg_11_0.curPage_:SetIsBack(arg_11_0.params_.isBack)

		arg_11_0.params_.isBack = false
	end

	arg_11_0.curPage_:SetData()
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.params_.Inited = nil

	if arg_12_0.curPage_ then
		arg_12_0.curPage_:SetActive(false)

		arg_12_0.curPage_ = nil
	end

	arg_12_0.tree_:Dispose()

	for iter_12_0, iter_12_1 in pairs(arg_12_0.pages_) do
		iter_12_1:Dispose()
	end

	arg_12_0.pages_ = nil
	arg_12_0.rechargeGroupGoList_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.OnNoobSign(arg_13_0)
	arg_13_0:RefreshSignGroup()
end

function var_0_0.RefreshSignGroup(arg_14_0)
	local var_14_0 = ActivityNoobData:GetSignDay()
	local var_14_1 = math.floor(var_14_0 / 7)

	var_14_1 = var_14_1 <= 1 and var_14_1 or 1
	arg_14_0.tree_:GetData().groupDatas[0].defaultIndex = var_14_1

	for iter_14_0 = 1, #arg_14_0.signCompleteGoList_ do
		SetActive(arg_14_0.signCompleteGoList_[iter_14_0], var_14_0 >= iter_14_0 * 7)
	end

	arg_14_0.defaultGroupIndex_ = var_14_0 >= 14 and 2 or 1
end

function var_0_0.RefreshRecharge(arg_15_0)
	for iter_15_0 = 1, 3 do
		SetActive(arg_15_0.rechargeGroupGoList_[iter_15_0], ActivityNewbieTools.GetRechargeIsOpen(iter_15_0))
	end

	local var_15_0 = ActivityNoobData:GetFirstRechargeStatus()

	if var_15_0 and var_15_0.firstGearStatus == 2 then
		arg_15_0.tree_:GetData().groupDatas[4].defaultIndex = 1
	end
end

return var_0_0

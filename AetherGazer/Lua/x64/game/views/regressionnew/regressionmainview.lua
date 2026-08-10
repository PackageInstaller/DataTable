local var_0_0 = class("RegressionGiftPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ReturnThree/RT3rd_MainViewUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.pageClass = {
		{
			RegressionSignView,
			RegressionTaskView,
			RegressionTaskView,
			RegressionTaskView,
			RegressionTaskView
		},
		{
			RegressionDrawView,
			RegressionDiscountView,
			RegressionResRetrieveView,
			RegressionShopGiftView
		}
	}
	arg_3_0.selectPageID = -1

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.tree = LuaTree.New(arg_4_0.m_uitree)

	arg_4_0.tree:SetSelectedHandler(handler(arg_4_0, arg_4_0.OnGroupSelect), handler(arg_4_0, arg_4_0.OnItemSelect))

	arg_4_0.pages = {}
	arg_4_0.selectPageIndex = -1
	arg_4_0.isHideDrawToggle = false
	arg_4_0.onSubmitTaskHandle_ = handler(arg_4_0, arg_4_0.OnTaskSubmitResponse)
end

function var_0_0.OnGroupSelect(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0:SetSelectPage(arg_5_1, nil)
end

function var_0_0.OnItemSelect(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_0.selectPageID == arg_6_2 then
		return
	end

	arg_6_0.selectPageID = arg_6_2

	local var_6_0 = arg_6_0.pageClass[arg_6_0.selectPageIndex][arg_6_1]

	if arg_6_0.curPage then
		arg_6_0.curPage:SetActive(false)
	end

	if not arg_6_0.pages[var_6_0] then
		arg_6_0.pages[var_6_0] = var_6_0.New(arg_6_0.m_content)
	end

	arg_6_0.curPage = arg_6_0.pages[var_6_0]

	arg_6_0.curPage:SetData(arg_6_2)
	arg_6_0:OnTop()
	arg_6_0.curPage:SetActive(true)
end

function var_0_0.SetSelectPage(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == arg_7_0.selectPageIndex then
		return
	end

	arg_7_0.selectPageID = -1
	arg_7_0.selectPageIndex = arg_7_1
end

function var_0_0.OnRegressionSign(arg_8_0)
	if arg_8_0.curPage and arg_8_0.curPage.OnRegressionSign then
		arg_8_0.curPage:OnRegressionSign(true)
	end
end

function var_0_0.OnShopBuyResult(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_0.curPage and arg_9_0.curPage.OnRegressionShopUpdate then
		RegressionActionNew.CheckShopRedPoint()
		arg_9_0.curPage:OnRegressionShopUpdate()
	end
end

function var_0_0.OnRegressionFindRes(arg_10_0)
	if arg_10_0.curPage and arg_10_0.curPage.OnRegressionFindRes then
		arg_10_0.curPage:OnRegressionFindRes()
	end
end

function var_0_0.OnTaskListChange(arg_11_0)
	if arg_11_0.curPage and arg_11_0.curPage.OnTaskListChange then
		arg_11_0.curPage:OnTaskListChange()
	end
end

function var_0_0.OnTaskSubmitResponse(arg_12_0)
	if arg_12_0.curPage and arg_12_0.curPage.OnTaskSubmitResponse then
		arg_12_0.curPage:OnTaskSubmitResponse()
	end
end

function var_0_0.RefreshTime(arg_13_0)
	local var_13_0 = RegressionDataNew:GetRegressionEndTime()

	if var_13_0 - manager.time:GetServerTime() <= 0 then
		gameContext:Go("/home", nil, nil, true)
		ShowTips("TIME_OVER")

		return
	end

	arg_13_0.countDownTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(var_13_0))

	if arg_13_0.curPage and arg_13_0.curPage.RefreshTime then
		arg_13_0.curPage:RefreshTime(var_13_0)
	end
end

function var_0_0.AddUIListener(arg_14_0)
	return
end

function var_0_0.OnTop(arg_15_0)
	if arg_15_0.curPage and arg_15_0.curPage.UpdateBar then
		arg_15_0.curPage:UpdateBar()
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function var_0_0.UpdateDrawToggleShow(arg_16_0)
	if arg_16_0.isHideDrawToggle then
		return
	end

	local var_16_0 = arg_16_0.tree:GetItemGameObjectById(2, 1)

	if var_16_0 and not RegressionDataNew:CheckIsOpenRuturnPool() then
		var_16_0.transform:SetAsLastSibling()

		arg_16_0.isHideDrawToggle = true
	end
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0:OnTaskListChange()
	arg_17_0:EnterSelecet()
	arg_17_0:UpdateDrawToggleShow()

	if arg_17_0.timer then
		arg_17_0.timer:Stop()

		arg_17_0.timer = nil
	end

	arg_17_0:RefreshTime()

	arg_17_0.timer = Timer.New(function()
		arg_17_0:RefreshTime()
	end, 1, -1)

	arg_17_0.timer:Start()
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_17_0.onSubmitTaskHandle_)
	arg_17_0:BindRedKey()
end

function var_0_0.BindRedKey(arg_19_0)
	manager.redPoint:bindUIandKey(arg_19_0.tree:GetGroupRedPointContainerById(1), RedPointConst.NEW_REGRESSION_TASK)
	manager.redPoint:bindUIandKey(arg_19_0.tree:GetGroupRedPointContainerById(2), RedPointConst.NEW_REGRESSION_PRIVILEGE)
	manager.redPoint:bindUIandKey(arg_19_0.tree:GetItemRedPointContainerById(1, 1), RedPointConst.NEW_REGRESSION_SIGN)
	manager.redPoint:bindUIandKey(arg_19_0.tree:GetItemRedPointContainerById(1, 211), string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_TOGGLE, TaskConst.TASK_TYPE.REGRESSION_CURRENT_ACT))
	manager.redPoint:bindUIandKey(arg_19_0.tree:GetItemRedPointContainerById(1, 207), string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_TOGGLE, TaskConst.TASK_TYPE.REGRESSION_DRAW))
	manager.redPoint:bindUIandKey(arg_19_0.tree:GetItemRedPointContainerById(1, 209), string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_TOGGLE, TaskConst.TASK_TYPE.REGRESSION_TILI))

	if arg_19_0.isHideDrawToggle then
		manager.redPoint:bindUIandKey(arg_19_0.tree:GetItemRedPointContainerById(2, 1), RedPointConst.NEW_REGRESSION_GIFT_NET_TAG)
		manager.redPoint:bindUIandKey(arg_19_0.tree:GetItemRedPointContainerById(2, 2), RedPointConst.NEW_REGRESSION_RES_FIND)
		manager.redPoint:bindUIandKey(arg_19_0.tree:GetItemRedPointContainerById(2, 3), RedPointConst.NEW_REGRESSION_SHOP)
		manager.redPoint:bindUIandKey(arg_19_0.tree:GetItemRedPointContainerById(2, 4), RedPointConst.NEW_REGRESSION_DRAW_NEW_TAG)
	else
		manager.redPoint:bindUIandKey(arg_19_0.tree:GetItemRedPointContainerById(2, 1), RedPointConst.NEW_REGRESSION_DRAW_NEW_TAG)
		manager.redPoint:bindUIandKey(arg_19_0.tree:GetItemRedPointContainerById(2, 2), RedPointConst.NEW_REGRESSION_GIFT_NET_TAG)
		manager.redPoint:bindUIandKey(arg_19_0.tree:GetItemRedPointContainerById(2, 3), RedPointConst.NEW_REGRESSION_RES_FIND)
		manager.redPoint:bindUIandKey(arg_19_0.tree:GetItemRedPointContainerById(2, 4), RedPointConst.NEW_REGRESSION_SHOP)
	end
end

function var_0_0.UnBindRedKey(arg_20_0)
	manager.redPoint:unbindUIandKey(arg_20_0.tree:GetGroupRedPointContainerById(1), RedPointConst.NEW_REGRESSION_TASK)
	manager.redPoint:unbindUIandKey(arg_20_0.tree:GetGroupRedPointContainerById(2), RedPointConst.NEW_REGRESSION_PRIVILEGE)
	manager.redPoint:unbindUIandKey(arg_20_0.tree:GetItemRedPointContainerById(1, 1), RedPointConst.NEW_REGRESSION_SIGN)
	manager.redPoint:unbindUIandKey(arg_20_0.tree:GetItemRedPointContainerById(1, 211), string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_TOGGLE, TaskConst.TASK_TYPE.REGRESSION_CURRENT_ACT))
	manager.redPoint:unbindUIandKey(arg_20_0.tree:GetItemRedPointContainerById(1, 207), string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_TOGGLE, TaskConst.TASK_TYPE.REGRESSION_DRAW))
	manager.redPoint:unbindUIandKey(arg_20_0.tree:GetItemRedPointContainerById(1, 209), string.format("%s_%s", RedPointConst.NEW_REGRESSION_TASK_TOGGLE, TaskConst.TASK_TYPE.REGRESSION_TILI))

	if arg_20_0.isHideDrawToggle then
		manager.redPoint:unbindUIandKey(arg_20_0.tree:GetItemRedPointContainerById(2, 1), RedPointConst.NEW_REGRESSION_GIFT_NET_TAG)
		manager.redPoint:unbindUIandKey(arg_20_0.tree:GetItemRedPointContainerById(2, 2), RedPointConst.NEW_REGRESSION_RES_FIND)
		manager.redPoint:unbindUIandKey(arg_20_0.tree:GetItemRedPointContainerById(2, 3), RedPointConst.NEW_REGRESSION_SHOP)
		manager.redPoint:unbindUIandKey(arg_20_0.tree:GetItemRedPointContainerById(2, 4), RedPointConst.NEW_REGRESSION_DRAW_NEW_TAG)
	else
		manager.redPoint:unbindUIandKey(arg_20_0.tree:GetItemRedPointContainerById(2, 1), RedPointConst.NEW_REGRESSION_DRAW_NEW_TAG)
		manager.redPoint:unbindUIandKey(arg_20_0.tree:GetItemRedPointContainerById(2, 2), RedPointConst.NEW_REGRESSION_GIFT_NET_TAG)
		manager.redPoint:unbindUIandKey(arg_20_0.tree:GetItemRedPointContainerById(2, 3), RedPointConst.NEW_REGRESSION_RES_FIND)
		manager.redPoint:unbindUIandKey(arg_20_0.tree:GetItemRedPointContainerById(2, 4), RedPointConst.NEW_REGRESSION_SHOP)
	end
end

function var_0_0.EnterSelecet(arg_21_0)
	if arg_21_0.params_.selectPageIndex then
		arg_21_0.tree:SelectGroup(arg_21_0.params_.selectPageIndex)

		arg_21_0.params_.selectPageIndex = nil
		arg_21_0.params_.Inited = true
	elseif not arg_21_0.params_.Inited then
		arg_21_0.params_.Inited = true

		arg_21_0.tree:SelectGroup(1)
	elseif arg_21_0.curPage then
		if arg_21_0.curPage.Refresh then
			arg_21_0.curPage:Refresh()
		end
	elseif arg_21_0.params_.disposePageIndex and arg_21_0.params_.disposePageID then
		arg_21_0.tree:SelectItem(arg_21_0.params_.disposePageIndex, arg_21_0.params_.disposePageID)
	end
end

function var_0_0.OnExit(arg_22_0)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_22_0.onSubmitTaskHandle_)
	manager.windowBar:HideBar()

	arg_22_0.selectPageIndex = -1

	arg_22_0:RemoveAllEventListener()

	if arg_22_0.timer then
		arg_22_0.timer:Stop()

		arg_22_0.timer = nil
	end

	if arg_22_0.curPage and arg_22_0.curPage.GetSelectParams then
		arg_22_0.params_.disposePageIndex, arg_22_0.params_.disposePageID = arg_22_0.curPage:GetSelectParams()
	end

	for iter_22_0, iter_22_1 in pairs(arg_22_0.pages) do
		if iter_22_1 and iter_22_1.OnExit then
			iter_22_1:OnExit()
		end
	end

	arg_22_0:UnBindRedKey()
end

function var_0_0.Dispose(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.pages) do
		if iter_23_1 then
			iter_23_1:Dispose()
		end
	end

	arg_23_0.params_.Inited = false

	arg_23_0.tree:Dispose()
	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0

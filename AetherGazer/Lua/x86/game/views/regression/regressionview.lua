local var_0_0 = class("RegressionView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/ReturnUI/RegressionUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.pageClass = {
		RegressionSignPage,
		RegressionTaskPage,
		RegressionShopPage,
		RegressionNewPage
	}

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.tree = LuaTree.New(arg_4_0.m_uitree)

	arg_4_0.tree:SetSelectedHandler(handler(arg_4_0, arg_4_0.OnGroupSelect), handler(arg_4_0, arg_4_0.OnItemSelect))

	arg_4_0.pages = {}
	arg_4_0.selectIndex = -1
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:RegistEventListener(SHOP_LIST_UPDATE, function(arg_6_0)
		arg_5_0:ShopRefresh()
	end)
	arg_5_0:RegistEventListener(SHOP_REFRESH_ALL_SHOP, function(arg_7_0)
		if arg_5_0.curPage then
			arg_5_0.curPage:SetData()
		end
	end)
	arg_5_0:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_8_0, arg_8_1)
		arg_5_0:ShopRefresh()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_questionBtn, nil, function()
		JumpTools.OpenPageByJump("survey", {
			type = OperationConst.SURVEY_TYPE.REGRESSION
		})
	end)
end

function var_0_0.OnTop(arg_10_0)
	if arg_10_0.selectIndex == 3 and arg_10_0.curPage and arg_10_0.curPage.UpdateBarByShopId then
		arg_10_0.curPage:UpdateBarByShopId()

		return
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if arg_11_0.params_.selectIndex then
		arg_11_0.tree:SelectGroup(arg_11_0.params_.selectIndex)

		arg_11_0.params_.selectIndex = nil
		arg_11_0.params_.Inited = true
	elseif not arg_11_0.params_.Inited then
		arg_11_0.params_.Inited = true

		arg_11_0.tree:SelectGroup(1)
	elseif arg_11_0.curPage and arg_11_0.curPage.Refresh then
		arg_11_0.curPage:Refresh()
	end

	local var_11_0 = OperationData:GetOperationOpenList()

	manager.redPoint:bindUIandKey(arg_11_0.tree:GetGroupRedPointContainerById(1), RedPointConst.REGRESSION_SIGN)
	manager.redPoint:bindUIandKey(arg_11_0.tree:GetGroupRedPointContainerById(2), RedPointConst.REGRESSION_TASK)
	manager.redPoint:bindUIandKey(arg_11_0.tree:GetItemRedPointContainerById(2, 201), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY))
	manager.redPoint:bindUIandKey(arg_11_0.tree:GetItemRedPointContainerById(2, 202), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK))
	manager.redPoint:bindUIandKey(arg_11_0.tree:GetItemRedPointContainerById(2, 203), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE))
	manager.redPoint:bindUIandKey(arg_11_0.m_questionBtn.transform, RedPointConst.REGRESSION_SURVEY)
	arg_11_0:RefreshTime()

	arg_11_0.timer = Timer.New(function()
		arg_11_0:RefreshTime()
	end, 1, -1)

	arg_11_0.timer:Start()
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()

	arg_13_0.selectIndex = -1

	arg_13_0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(arg_13_0.tree:GetGroupRedPointContainerById(1), RedPointConst.REGRESSION_SIGN)
	manager.redPoint:unbindUIandKey(arg_13_0.tree:GetGroupRedPointContainerById(2), RedPointConst.REGRESSION_TASK)
	manager.redPoint:unbindUIandKey(arg_13_0.tree:GetItemRedPointContainerById(2, 201), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY))
	manager.redPoint:unbindUIandKey(arg_13_0.tree:GetItemRedPointContainerById(2, 202), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK))
	manager.redPoint:unbindUIandKey(arg_13_0.tree:GetItemRedPointContainerById(2, 203), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE))
	manager.redPoint:unbindUIandKey(arg_13_0.m_questionBtn.transform, RedPointConst.REGRESSION_SURVEY)

	if arg_13_0.timer then
		arg_13_0.timer:Stop()

		arg_13_0.timer = nil
	end
end

function var_0_0.OnGroupSelect(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	arg_14_0:SetSelectPage(arg_14_1, nil)
end

function var_0_0.OnItemSelect(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	arg_15_0.curPage:SetData(arg_15_2)
end

function var_0_0.SetSelectPage(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == arg_16_0.selectIndex then
		return
	end

	arg_16_0.selectIndex = arg_16_1

	if arg_16_0.curPage then
		arg_16_0.curPage:SetActive(false)
	end

	if not arg_16_0.pages[arg_16_1] then
		arg_16_0.pages[arg_16_1] = arg_16_0.pageClass[arg_16_1].New(arg_16_0.m_content)
	end

	arg_16_0.curPage = arg_16_0.pages[arg_16_1]

	arg_16_0.curPage:SetData(arg_16_2)
	arg_16_0.curPage:SetActive(true)

	if arg_16_1 ~= 3 then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function var_0_0.RefreshTime(arg_17_0)
	local var_17_0 = 86400 * GameSetting.return_duration_time.value[1]
	local var_17_1 = RegressionData:GetRegressionLoginTime()

	arg_17_0.m_timerLab.text = manager.time:GetLostTimeStrWith2Unit(var_17_1 + var_17_0)

	if arg_17_0.curPage and arg_17_0.curPage.RefreshTime then
		arg_17_0.curPage:RefreshTime()
	end
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.params_.Inited = nil

	if arg_18_0.curPage then
		arg_18_0.curPage:SetActive(false)

		arg_18_0.curPage = nil
	end

	arg_18_0.tree:Dispose()

	for iter_18_0, iter_18_1 in pairs(arg_18_0.pages) do
		iter_18_1:Dispose()
	end

	arg_18_0.pages = {}

	var_0_0.super.Dispose(arg_18_0)
end

function var_0_0.OnTaskListChange(arg_19_0)
	if arg_19_0.curPage and arg_19_0.curPage.OnTaskListChange then
		arg_19_0.curPage:OnTaskListChange()
	end
end

function var_0_0.ShopRefresh(arg_20_0)
	if arg_20_0.curPage and arg_20_0.curPage.RefreshList then
		arg_20_0.curPage:RefreshList(true)
	end
end

function var_0_0.OnRegressionSign(arg_21_0)
	if arg_21_0.curPage and arg_21_0.curPage.OnRegressionSign then
		arg_21_0.curPage:OnRegressionSign(true)
	end
end

function var_0_0.OnShopBuyResult(arg_22_0)
	arg_22_0:ShopRefresh()
end

return var_0_0

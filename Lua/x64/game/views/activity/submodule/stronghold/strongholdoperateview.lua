local var_0_0 = class("StrongholdOperateView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/Operate/StrongholdOperateUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.pageController = ControllerUtil.GetController(arg_3_0.transform_, "page")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.pages = {}
	arg_4_0.classList = {
		StrongholdOperateTaskPage,
		StrongholdOperateSkillPage,
		StrongholdOperateIncreasePage,
		StrongholdOperateRewardPage
	}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_taskBtn, function()
		arg_5_0:SelectPage(1)
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_skillBtn, function()
		arg_5_0:SelectPage(2)
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_increaseBtn, function()
		arg_5_0:SelectPage(3)
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_rewardBtn, function()
		arg_5_0:SelectPage(4)
	end)
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.activity_id = arg_11_0.params_.activity_id

	if arg_11_0.params_.selectIndex then
		arg_11_0:SelectPage(arg_11_0.params_.selectIndex)
	else
		arg_11_0:SelectPage(1)
	end

	manager.redPoint:bindUIandKey(arg_11_0.m_taskBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_TASK, arg_11_0.activity_id))
	manager.redPoint:bindUIandKey(arg_11_0.m_increaseBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_INCREASE, arg_11_0.activity_id))
	manager.redPoint:bindUIandKey(arg_11_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_REWARD, arg_11_0.activity_id))
	arg_11_0:RegistEventListener(CURRENCY_UPDATE, handler(arg_11_0, arg_11_0.OnCurrencyChange))
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()

	if arg_12_0.curPage then
		arg_12_0.curPage:SetActive(false)

		arg_12_0.curPage = nil
	end

	arg_12_0.curIndex = nil

	manager.redPoint:unbindUIandKey(arg_12_0.m_taskBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_TASK, arg_12_0.activity_id))
	manager.redPoint:unbindUIandKey(arg_12_0.m_increaseBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_INCREASE, arg_12_0.activity_id))
	manager.redPoint:unbindUIandKey(arg_12_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRONGHOLD_REWARD, arg_12_0.activity_id))
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.SelectPage(arg_13_0, arg_13_1)
	if arg_13_1 == arg_13_0.curIndex then
		return
	end

	arg_13_0.curIndex = arg_13_1

	arg_13_0.pageController:SetSelectedIndex(arg_13_1 - 1)

	if arg_13_0.curPage then
		arg_13_0.curPage:SetActive(false)
	end

	if not arg_13_0.pages[arg_13_1] then
		arg_13_0.pages[arg_13_1] = arg_13_0.classList[arg_13_1].New(arg_13_0, arg_13_0.m_content)
	end

	arg_13_0.curPage = arg_13_0.pages[arg_13_1]

	arg_13_0.curPage:Refresh(arg_13_0.activity_id)
	arg_13_0.curPage:SetActive(true)
end

function var_0_0.Dispose(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.pages) do
		iter_14_1:Dispose()
	end

	arg_14_0.pages = {}

	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.OnStrongholdUpgradeIncrease(arg_15_0)
	if arg_15_0.curPage and arg_15_0.curPage.OnStrongholdUpgradeIncrease then
		arg_15_0.curPage:OnStrongholdUpgradeIncrease()
	end
end

function var_0_0.OnStrongholdUpdateReward(arg_16_0)
	if arg_16_0.curPage and arg_16_0.curPage.OnStrongholdUpdateReward then
		arg_16_0.curPage:OnStrongholdUpdateReward()
	end
end

function var_0_0.OnTaskListChange(arg_17_0)
	if arg_17_0.curPage and arg_17_0.curPage.OnTaskListChange then
		arg_17_0.curPage:OnTaskListChange()
	end
end

function var_0_0.OnCurrencyChange(arg_18_0)
	if arg_18_0.curPage and arg_18_0.curPage.OnCurrencyChange then
		arg_18_0.curPage:OnCurrencyChange()
	end
end

return var_0_0

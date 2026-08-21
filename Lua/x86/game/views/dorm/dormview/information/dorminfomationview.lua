local var_0_0 = class("DormInfomationView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormPanelOverviewUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.BuildContext(arg_4_0)
	arg_4_0.page = DormInfoOverviewPage.New(arg_4_0.overviewObj_)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:BuildContext()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.oneKeyBtn_, nil, function()
		DormAction:GiftFoodToHero(nil, nil, 1, function(arg_8_0, arg_8_1, arg_8_2)
			manager.notify:Invoke(BACKHOME_CATEEN_FEED_SUCCESS)
		end, function()
			ShowTips(GetTips("DORM_FEED_MAX"))
		end)
	end)
	arg_6_0:AddBtnListener(arg_6_0.autoPlaceBtn_, nil, function()
		BackHomeTools:OnceDeploy()
	end)
	arg_6_0:AddBtnListener(arg_6_0.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormAdviceView")
	end)
end

function var_0_0.RefreshBar(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		manager.ui:ShowBackground(false)
		arg_12_0:Back()
	end)
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			isPrefab = true,
			pages = {
				"Widget/BackHouseUI/Dorm/DormInfoPanelDescription_01"
			}
		}
	})
end

function var_0_0.OnEnter(arg_14_0)
	manager.ui:ShowBackground(true)
	arg_14_0.page:Show()
end

function var_0_0.Back(arg_15_0)
	manager.ui:ShowBackground(false)
	var_0_0.super.Back(arg_15_0)
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:RemoveAllEventListener()
	arg_16_0.page:Hide()
end

function var_0_0.OnTop(arg_17_0)
	arg_17_0:RefreshBar()
	arg_17_0.page:Render()
end

function var_0_0.OnBehind(arg_18_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0.page:Dispose()

	arg_19_0.page = nil

	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0

local var_0_0 = class("BilliardGameMainUI", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_SummerPub/BilliardGame/BilliardGame_MainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:OnInit()
end

function var_0_0.BuildContext(arg_4_0)
	arg_4_0.questModule_ = BilliardGameQuestModule.New(arg_4_0.questObj_)
	arg_4_0.heroInfoModule_ = BilliardGameHeroInfoModule.New(arg_4_0.heroInfoModuleObj_)
end

function var_0_0.OnInit(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:BuildContext()
	BilliardGameTools.BindBilliardGameUI(arg_5_0.turnBasedObj_)
	arg_5_0:AddEventListner()

	arg_5_0.heroInfoController_ = arg_5_0.mainControllerEx_:GetController("heroInfo")
end

function var_0_0.AddEventListner(arg_6_0)
	arg_6_0:RegistEventListener(BilliardGameEvent.BILLIARD_UPDATE_VIEW, function()
		arg_6_0:UpdateView()
	end)
	arg_6_0:RegistEventListener(BilliardGameEvent.BILLIARD_HERO_INFO, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		arg_6_0:ShowHeroInfo(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	end)
	arg_6_0:RegistEventListener(BilliardGameEvent.BILLIARD_CONDITION_FINISH, function(arg_9_0)
		arg_6_0.questModule_:Finish(arg_9_0)
	end)
	arg_6_0:AddBtnListener(arg_6_0.descBtn_, nil, function()
		arg_6_0:OnDescClick()
	end)
	arg_6_0:AddBtnListener(arg_6_0.heroInfoMaskBtn_, nil, function()
		arg_6_0:ShowHeroInfo(false)
	end)
end

function var_0_0.OnDescClick(arg_12_0)
	JumpTools.OpenPageByJump("billiardGameIlluView", {
		stageId = BilliardGameMgr:GetStageId()
	})
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:Refresh()
end

function var_0_0.OnTop(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			prefabPath = "Widget/System/Activity_SummerPub/MainPub/Activity_SummerPub_TipsPopUI",
			content = GetTips("BILLIARD_GAME_BACK"),
			OkCallback = function()
				local var_16_0 = BilliardGameLuaBridge.GetExchangeData()

				SendBilliardMessage(var_16_0)
				LuaExchangeHelper.GoToMain(CustomLoadingConst.BilliardGame_Loading)
			end
		})
	end)
end

function var_0_0.OnBehind(arg_17_0)
	manager.windowBar:HideBar()
end

function var_0_0.Refresh(arg_18_0)
	local var_18_0 = BilliardGameMgr:GetStageId()

	arg_18_0.questModule_:Refresh(var_18_0)
end

function var_0_0.UpdateView(arg_19_0)
	arg_19_0.questModule_:OnDataChange()
end

function var_0_0.ShowHeroInfo(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	if not arg_20_1 then
		arg_20_0.heroInfoController_:SetSelectedState("hide")

		return
	end

	arg_20_0.heroInfoController_:SetSelectedState("showIndex" .. arg_20_2)
	arg_20_0.heroInfoModule_:Refresh(arg_20_3, arg_20_4, arg_20_5)
end

function var_0_0.OnExit(arg_21_0)
	return
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0.questModule_:Dispose()
	arg_22_0.heroInfoModule_:Dispose()
	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0

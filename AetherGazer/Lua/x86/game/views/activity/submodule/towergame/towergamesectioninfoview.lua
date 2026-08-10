local var_0_0 = class("TowerGameSectionInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Stage/ChapterSectionInfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.sectionImage_.immediate = true

	SetActive(arg_4_0.rewardPanel_, false)
	SetActive(arg_4_0.multiplePanel_, false)
	SetActive(arg_4_0.resourcePanel_, false)
	SetActive(arg_4_0.stageTitleGo_, false)

	arg_4_0.levelid_ = 0
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.battleBtn_, nil, function()
		if ActivityData:GetActivityIsOpen(arg_5_0.levelid_) then
			local var_6_0 = BattleMardukeTowerGameTemplate.New(arg_5_0.stageid_, arg_5_0.levelid_)

			BattleController.GetInstance():LaunchBattle(var_6_0)
		else
			ShowTips(GetTips("TIME_OVER"))
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	if arg_7_0.levelid_ ~= arg_7_0.params_.levelid then
		arg_7_0.levelid_ = arg_7_0.params_.levelid
		arg_7_0.stageid_ = TowerGameCfg[arg_7_0.levelid_].stage_id

		arg_7_0:RefreshUI()
	end
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		manager.notify:CallUpdateFunc(TOWERGAME_BACK)
		JumpTools.Back()
	end)
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = BattleTowerGameCfg[arg_10_0.stageid_]

	arg_10_0.sectionName_.text = GetI18NText(var_10_0.name)
	arg_10_0.sectionImage_.spriteSync = string.format("%s%s", SpritePathCfg.Stage.path, var_10_0.background_1)
	arg_10_0.tipsText_.text = GetI18NText(var_10_0.tips)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.tipsTextContentTrans_)
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
end

return var_0_0

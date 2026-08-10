local var_0_0 = class("MythicCampAddPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Mythic/MythicGodUpUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		arg_5_0:Back()
	end)

	arg_5_0.heroController_ = ControllerUtil.GetController(arg_5_0.heroGo_.transform, "name")
	arg_5_0.fightController_ = ControllerUtil.GetController(arg_5_0.fightingGo_.transform, "name")
end

function var_0_0.GetRaceEffect(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = 0
	local var_7_2 = false
	local var_7_3 = ReserveParams.New(ReserveConst.RESERVE_TYPE.MYTHIC_FINAL, ReserveConst.MYTHIC_CONT_ID.FINAL_MULTI, arg_7_0.teamID_)
	local var_7_4 = ReserveTools.GetHeroList(var_7_3)

	for iter_7_0, iter_7_1 in pairs(var_7_4) do
		if iter_7_1 ~= 0 then
			local var_7_5 = HeroCfg[iter_7_1].race

			var_7_0[var_7_5] = (var_7_0[var_7_5] or 0) + 1

			if var_7_0[var_7_5] == 2 then
				var_7_1 = var_7_5
			elseif var_7_0[var_7_5] == 3 then
				var_7_2 = true
			end
		end
	end

	return var_7_1, var_7_2, var_7_0[var_7_1] or 1
end

function var_0_0.RefreshRace(arg_8_0)
	local var_8_0, var_8_1, var_8_2 = arg_8_0:GetRaceEffect()

	arg_8_0.heroController_:SetSelectedState(var_8_0 ~= 0 and "on" or "off")
	arg_8_0.fightController_:SetSelectedState(var_8_1 and "on" or "off")

	if var_8_0 ~= 0 then
		local var_8_3 = RaceEffectCfg[var_8_0]

		arg_8_0.text1Text_.text = GetI18NText(var_8_3.desc)
	else
		arg_8_0.text1Text_.text = GetTips("NO_CORRECTOR_BUFF")
	end

	if var_8_1 then
		local var_8_4 = RaceEffectCfg[var_8_0]

		arg_8_0.text2Text_.text = GetI18NText(var_8_4.battle_desc)
	else
		arg_8_0.text2Text_.text = GetTips("NO_BATTLE_BUFF")
	end
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.teamID_ = arg_9_0.params_.teamID

	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	arg_9_0:RefreshRace()
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0

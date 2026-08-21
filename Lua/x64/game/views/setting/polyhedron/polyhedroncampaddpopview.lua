local var_0_0 = class("PolyhedronCampAddPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/PolyhedronBattle/PolyhedronCampAddPopUI"
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

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.heroList = arg_7_0.params_.heroIdList

	local var_7_0, var_7_1, var_7_2 = PolyhedronTools.GetRaceEffect(arg_7_0.heroList)

	arg_7_0.heroController_:SetSelectedState(var_7_0 ~= 0 and "on" or "off")
	arg_7_0.fightController_:SetSelectedState(var_7_1 and "on" or "off")

	if var_7_0 ~= 0 then
		local var_7_3 = RaceEffectCfg[var_7_0]

		arg_7_0.text1Text_.text = GetI18NText(var_7_3.desc)
	else
		arg_7_0.text1Text_.text = GetTips("NO_CORRECTOR_BUFF")
	end

	if var_7_1 then
		local var_7_4 = RaceEffectCfg[var_7_0]

		arg_7_0.text2Text_.text = GetI18NText(var_7_4.battle_desc)
	else
		arg_7_0.text2Text_.text = GetTips("NO_BATTLE_BUFF")
	end
end

return var_0_0

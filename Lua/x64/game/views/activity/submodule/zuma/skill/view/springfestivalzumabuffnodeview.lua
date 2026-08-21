local var_0_0 = class("SpringFestivalZumaBuffNodeView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.parent_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.showBuffInfoController = arg_3_0.controller_:GetController("showBuffInfo")
	arg_3_0.buffIndexController = arg_3_0.controller_:GetController("buffIndex")
	arg_3_0.showBuffItemController = arg_3_0.controller_:GetController("showBuffItem")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.buffItemBtn_, nil, function()
		if arg_4_0.isGameStart == false then
			return
		end

		arg_4_0:showBuffInfoNode(true)
	end)
	arg_4_0:AddBtnListener(arg_4_0.clickAreaBtn_, nil, function()
		arg_4_0:showBuffInfoNode(false)

		if not arg_4_0.isPlayStartEffect then
			arg_4_0.parent_:PlayStartEffect()

			arg_4_0.isPlayStartEffect = true
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.isPlayStartEffect = false

	arg_7_0:SetGameStartState(false)
	arg_7_0:RefreshUI()
end

function var_0_0.SetGameStartState(arg_8_0, arg_8_1)
	arg_8_0.isGameStart = arg_8_1
end

function var_0_0.GetIsShowBuffNode(arg_9_0)
	return arg_9_0.randomIndex > 0
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = ZumaData:GetEndlessMapRandIndex()

	arg_10_0.randomIndex = var_10_0

	if var_10_0 <= 0 then
		arg_10_0.showBuffItemController:SetSelectedState("false")
		arg_10_0:showBuffInfoNode(false)

		return
	end

	local var_10_1 = 2503
	local var_10_2 = ActivityZumaEffectCfg[var_10_1].effect_value[var_10_0]

	arg_10_0.buffIndexController:SetSelectedIndex(var_10_0 - 1)

	local var_10_3 = -1
	local var_10_4 = ZumaData:GetRandomTalentList()

	for iter_10_0, iter_10_1 in pairs(var_10_4) do
		local var_10_5 = ActivityZumaTalentCfg[iter_10_1]

		if #var_10_5.effect_list > 0 and var_10_5.effect_list[1] == var_10_2 then
			var_10_3 = iter_10_1
		end
	end

	if var_10_3 > 0 then
		arg_10_0:showBuffInfoNode(true)

		local var_10_6 = ActivityZumaTalentCfg[var_10_3]

		arg_10_0.nameText_.text = GetI18NText(var_10_6.name)
		arg_10_0.infoText_.text = GetI18NText(var_10_6.desc)

		arg_10_0.showBuffItemController:SetSelectedState("true")
	end
end

function var_0_0.showBuffInfoNode(arg_11_0, arg_11_1)
	arg_11_0.showBuffInfoController:SetSelectedState(arg_11_1 and "true" or "false")

	if not arg_11_1 then
		ZumaLuaBridge.ReStartZumaGame()
	else
		ZumaLuaBridge.PauseZumaGame()
	end
end

function var_0_0.OnExit(arg_12_0)
	return
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0

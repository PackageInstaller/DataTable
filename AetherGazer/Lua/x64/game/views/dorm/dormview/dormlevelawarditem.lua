local var_0_0 = class("DormLevelAwardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.selController = ControllerUtil.GetController(arg_2_0.transform_, "selectItem")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.index = arg_4_2
	arg_4_0.levelText.text = string.format(GetTips("DORM_LEVEL_TIPS"), arg_4_2)
	arg_4_0.rewardItemList_ = {}

	local var_4_0 = ""

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_1 = BackHomeDormLevelRewardCfg[iter_4_1].reward

		if BackHomeDormLevelRewardCfg[iter_4_1].type == 3 then
			table.insert(arg_4_0.rewardItemList_, var_4_1)
		elseif BackHomeDormLevelRewardCfg[iter_4_1].type == 1 then
			local var_4_2 = var_4_1[1]
			local var_4_3 = GetI18NText(PublicAttrCfg[var_4_2].name)

			var_4_0 = var_4_0 .. string.format(GetTips("DORM_LEVEL_AWARD_ATTRIB"), var_4_3, var_4_1[2]) .. "\n"
		elseif BackHomeDormLevelRewardCfg[iter_4_1].type == 2 then
			local var_4_4 = GetI18NText(HeroVoiceCfg[var_4_1[1]].title)

			var_4_0 = var_4_0 .. string.format(GetTips("DORM_LEVEL_AWARD_VOICE"), var_4_4) .. "\n"
		end
	end

	local var_4_5 = 3600 / GameSetting.dorm_fatigue_time.value[1]
	local var_4_6 = GameSetting.dorm_fatigue_increase.value[arg_4_2][2] / 100 * var_4_5
	local var_4_7 = string.format(GetTips("DORM_FATIGUE_BASE_INFO"), var_4_6)

	arg_4_0.decText.text = var_4_0 .. var_4_7

	if arg_4_0.index == arg_4_3 then
		arg_4_0.selController:SetSelectedState("select")
	else
		arg_4_0.selController:SetSelectedState("normal")
	end
end

function var_0_0.Dispose(arg_5_0)
	if arg_5_0.itemList then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.itemList) do
			iter_5_1:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0

local var_0_0 = class("SpringFestivalZumaEndlessStageInfoView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.difficultType = arg_1_2
	arg_1_0.difficultCfgList = ZumaData:GetZumaCfgData()[arg_1_2]

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.rateController = arg_2_0.controllerexcollection_:GetController("rate")
	arg_2_0.selectController = arg_2_0.controllerexcollection_:GetController("select")

	arg_2_0:AddBtnListener(arg_2_0.stageBtn_, nil, function()
		manager.notify:CallUpdateFunc(ZUMA_SELECT_CHAPTER)
	end)
	arg_2_0:AddBtnListener(arg_2_0.checkBtn_, nil, function()
		JumpTools.OpenPageByJump("springFestivalZumaEndlessEffectPopView")
	end)

	local var_2_0 = ZumaData:GetEndlessTalentList()

	arg_2_0.rangeTalentScoreList = {}

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		local var_2_1 = arg_2_0[string.format("progressValueTxt%s_", iter_2_0)]

		if var_2_1 then
			var_2_1.text = ActivityZumaTalentCfg[iter_2_1].need
		end

		table.insert(arg_2_0.rangeTalentScoreList, ActivityZumaTalentCfg[iter_2_1].need)
	end
end

function var_0_0.ChangeSelectState(arg_5_0, arg_5_1)
	arg_5_0.selectController:SetSelectedState(arg_5_1 and "on" or "off")
end

local var_0_1 = {
	0,
	0.13,
	0.33,
	0.58,
	1
}

function var_0_0.RefreshStageUI(arg_6_0)
	local var_6_0 = arg_6_0:GetLevelCfg()

	arg_6_0.nameText_.text = var_6_0.name

	local var_6_1 = ZumaData:GetEndlessScore() or 0

	arg_6_0.scoreText_.text = var_6_1

	local var_6_2 = #arg_6_0.rangeTalentScoreList + 1

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.rangeTalentScoreList) do
		if var_6_1 < iter_6_1 then
			var_6_2 = iter_6_0

			break
		end
	end

	local var_6_3 = arg_6_0.rangeTalentScoreList[var_6_2] or nil

	if var_6_3 == nil then
		arg_6_0.progressImg_.fillAmount = 1
	else
		local var_6_4 = (var_6_1 - arg_6_0.rangeTalentScoreList[var_6_2 - 1]) / (var_6_3 - arg_6_0.rangeTalentScoreList[var_6_2 - 1])

		arg_6_0.progressImg_.fillAmount = var_0_1[var_6_2 - 1] + var_6_4 * (var_0_1[var_6_2] - var_0_1[var_6_2 - 1])
	end

	arg_6_0.rateController:SetSelectedIndex(var_6_2 - 2)
end

function var_0_0.SetRedState(arg_7_0, arg_7_1)
	return
end

function var_0_0.DefalutSelect(arg_8_0)
	return
end

function var_0_0.GetAllScore(arg_9_0)
	return ZumaData:GetZumaStageScore(arg_9_0:GetLevelCfg().id) or 0
end

function var_0_0.GetLevelCfg(arg_10_0)
	return arg_10_0.difficultCfgList[1]
end

function var_0_0.GetDifficultCfgList(arg_11_0)
	return {}
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0

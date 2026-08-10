local var_0_0 = class("IntelligenceView", ReduxView)

function var_0_0.SetActive(arg_1_0, arg_1_1)
	if arg_1_0.gameObject_ then
		SetActive(arg_1_0.gameObject_, arg_1_1)
	end
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.hander_ = arg_2_1
	arg_2_0.transform_ = arg_2_2.transform
	arg_2_0.gameObject_ = arg_2_2
	arg_2_0.info_ = arg_2_3[1]

	arg_2_0:Init()
end

function var_0_0.RefreshData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.data_ = arg_3_1
	arg_3_0.info_ = arg_3_2

	arg_3_0:RefreshUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.missions_ = {}

	for iter_4_0 = 1, 3 do
		arg_4_0.missions_[iter_4_0] = {
			go = arg_4_0[string.format("mission%dGo_", iter_4_0)],
			on = arg_4_0[string.format("mission%dOnGo_", iter_4_0)],
			off = arg_4_0[string.format("mission%dOffGo_", iter_4_0)],
			name = arg_4_0[string.format("mission%dNameText_", iter_4_0)],
			progress = arg_4_0[string.format("mission%dNumText_", iter_4_0)],
			progressGo = arg_4_0[string.format("mission%dNumText_", iter_4_0)].gameObject
		}
	end
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.Init(arg_6_0)
	arg_6_0:InitUI()
	arg_6_0:AddUIListener()
	arg_6_0:OnEnter()
end

function var_0_0.UpdateAllMission(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1

	for iter_7_0 = 1, 3 do
		if var_7_0 and var_7_0[iter_7_0] then
			local var_7_1 = ThreeStarConditionCfg[var_7_0[iter_7_0].id]

			arg_7_0.missions_[iter_7_0].name.text = BattleInstance.GetStarMissionText(var_7_0[iter_7_0].id, var_7_0[iter_7_0].xData, var_7_0[iter_7_0].yData)

			local var_7_2 = BattleStageData:GetStageData()[arg_7_0.info_.section]
			local var_7_3 = false

			if var_7_2 and var_7_2.stars and var_7_2.stars[iter_7_0] == 1 then
				var_7_3 = true
			end

			SetActive(arg_7_0.missions_[iter_7_0].on, var_7_0[iter_7_0].isComplete or var_7_3)
			SetActive(arg_7_0.missions_[iter_7_0].off, not var_7_0[iter_7_0].isComplete and not var_7_3)

			if var_7_3 then
				arg_7_0.missions_[iter_7_0].progress.text = "-/-"
			else
				arg_7_0.missions_[iter_7_0].progress.text = string.format("%d/%d", var_7_0[iter_7_0].current, var_7_0[iter_7_0].total)
			end

			SetActive(arg_7_0.missions_[iter_7_0].go, true)
		else
			SetActive(arg_7_0.missions_[iter_7_0].go, false)
		end
	end
end

function var_0_0.SetLevelTitle(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:GetStageId()
	local var_8_1 = arg_8_1:GetType()
	local var_8_2, var_8_3 = BattleStageTools.GetChapterSectionIndex(var_8_1, var_8_0)

	if var_8_2 ~= "" then
		arg_8_0.titleText_.text = string.format("%s-%s", GetI18NText(var_8_2), GetI18NText(var_8_3))
	else
		arg_8_0.titleText_.text = ""
	end

	arg_8_0.nameText_.text = BattleStageTools.GetStageName(var_8_1, var_8_0)
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:SetLevelTitle(arg_9_0.info_.stageData)
	arg_9_0:UpdateAllMission(arg_9_0.info_.starMissionData)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:RefreshUI()
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.info_ = nil
	arg_12_0.hander_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0

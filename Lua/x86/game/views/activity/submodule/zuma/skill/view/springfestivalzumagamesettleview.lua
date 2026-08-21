local var_0_0 = class("SpringFestivalZumaGameSettleView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/SandPlay_3_11_ZumaResultPopup"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnTop(arg_3_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.stateController = arg_5_0.controllerexcollection_:GetController("state")
	arg_5_0.diffcultController = arg_5_0.controllerexcollection_:GetController("diffcult")
	arg_5_0.conditionList = {}

	for iter_5_0 = 1, 3 do
		arg_5_0.conditionList[iter_5_0] = ZumaConditionItem.New(arg_5_0[string.format("condition%sGo_", iter_5_0)])
	end

	arg_5_0.rewardIcon_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.confirmbtnBtn_, nil, function()
		DestroyLua()
		LaunchQWorld(true)
	end)
	arg_6_0:AddBtnListener(arg_6_0.reChallengeBtn_, nil, function()
		ZumaAction.ReChallengeZumaGame()
		arg_6_0:Back()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:RefreshUI()
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = arg_11_0.params_.isWin or false
	local var_11_1 = ZumaData:GetZumaGameId()

	if ActivityZumaLevelCfg[var_11_1].difficult == ZumaConst.ZUMA_DIFFICULT.ENDLESS then
		var_11_0 = true
	end

	local var_11_2 = var_11_0 and "win" or "lose"

	arg_11_0.stateController:SetSelectedState(var_11_2)
	arg_11_0:RefreshInfo()

	if var_11_0 then
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter", "")
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_bingo", "")
	else
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_fail", "")
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_error", "")
	end

	arg_11_0:SendSDK(var_11_0)
	arg_11_0:SendProto(var_11_0)
end

function var_0_0.SendProto(arg_12_0, arg_12_1)
	local var_12_0 = ZumaData:GetZumaScore()
	local var_12_1 = ZumaData:GetZumaGameId()
	local var_12_2 = ActivityZumaLevelCfg[var_12_1]
	local var_12_3 = ZumaToLuaBridge.GetZumaGamePlayTime()

	ZumaAction.QueryZumaCompelet(var_12_2.main_activity_id, var_12_1, arg_12_1 and 1 or 2, var_12_0, var_12_3)
end

function var_0_0.SendSDK(arg_13_0, arg_13_1)
	local var_13_0 = ZumaData:GetZumaGameId()
	local var_13_1 = ActivityZumaLevelCfg[var_13_0]
	local var_13_2 = {}

	for iter_13_0, iter_13_1 in pairs(ZumaData:GetTalentList()) do
		if iter_13_1 then
			table.insert(var_13_2, iter_13_0)
		end
	end

	table.sort(var_13_2)

	local var_13_3, var_13_4 = ZumaData:GetRecordPointData()
	local var_13_5 = {}
	local var_13_6 = ZumaData:GetZumaSkillID()

	if var_13_6 > 0 then
		var_13_5 = string.format("[%s,%s]", var_13_6, var_13_4)
	end

	local var_13_7 = ""

	for iter_13_2, iter_13_3 in pairs(var_13_3) do
		local var_13_8 = iter_13_3[1]
		local var_13_9 = iter_13_3[2]

		if not score then
			local var_13_10 = iter_13_2 - 1
			local var_13_11 = var_13_3[var_13_10] and var_13_3[var_13_10][2] or 0

			var_13_9 = var_13_10 > 0 and ZumaData:GetZumaScore() - var_13_11 or ZumaData:GetZumaScore()
		end

		if iter_13_2 == 1 then
			var_13_7 = string.format("[%s,%s]", var_13_8, var_13_9)
		else
			var_13_7 = string.format("%s,[%s,%s]", var_13_7, var_13_8, var_13_9)
		end
	end

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = var_13_1.main_activity_id,
		stage_id = var_13_1.id,
		result = arg_13_1 and 1 or 2,
		use_seconds = ZumaToLuaBridge.GetZumaGamePlayTime(),
		score = ZumaData:GetZumaScore(),
		activity_talent_list = var_13_2,
		skill_list = var_13_5,
		total_score = ZumaData:GetEndlessScore(),
		sequence_id = #var_13_3,
		other_data = var_13_7
	})
end

function var_0_0.RefreshInfo(arg_14_0)
	local var_14_0 = ZumaData:GetZumaScore()
	local var_14_1 = ZumaData:GetZumaGameId()
	local var_14_2 = ActivityZumaLevelCfg[var_14_1]
	local var_14_3 = var_14_2.activity_point_reward
	local var_14_4, var_14_5 = ZumaData:GetZumaFinishPointList(var_14_0, var_14_3)
	local var_14_6 = #var_14_4
	local var_14_7 = ZumaData:GetZumaStageScore(var_14_1)
	local var_14_8, var_14_9 = ZumaData:GetZumaFinishPointList(var_14_7 or 0, var_14_3)
	local var_14_10 = math.max(var_14_5 - var_14_9, 0)

	arg_14_0:UpdateTaskList(var_14_2.activity_point_reward, var_14_0 or 0)

	arg_14_0.scoreTxt_.text = var_14_0

	local var_14_11 = 0

	if var_14_7 == nil then
		var_14_11 = var_14_2.first_reward + var_14_10
	else
		var_14_11 = var_14_2.repeat_reward + var_14_10
	end

	arg_14_0.rewardNumsTxt_.text = var_14_11

	if var_14_2.difficult == ZumaConst.ZUMA_DIFFICULT.ENDLESS then
		arg_14_0.diffcultController:SetSelectedState("endless")
	else
		arg_14_0.diffcultController:SetSelectedState("normal")
	end
end

function var_0_0.UpdateTaskList(arg_15_0, arg_15_1, arg_15_2)
	for iter_15_0, iter_15_1 in pairs(arg_15_1) do
		arg_15_0.conditionList[iter_15_0]:RefreshConditionState(iter_15_1, arg_15_2)
	end
end

function var_0_0.Dispose(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.conditionList) do
		iter_16_1:Dispose()
	end

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0

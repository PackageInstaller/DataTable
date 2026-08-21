local var_0_0 = class("SimBusinessChooseStageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_RewardStagePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListener()

	arg_4_0.clientList = LuaList.New(handler(arg_4_0, arg_4_0.indexClientItem), arg_4_0.clientUilistGo_, SimBusinessGuestInfoItem)
	arg_4_0.awardList = LuaList.New(handler(arg_4_0, arg_4_0.indexAwardItem), arg_4_0.awardUilistGo_, CommonItemView)
	arg_4_0.leftBtnController = arg_4_0.btnlControllerexcollection_:GetController("click")
	arg_4_0.rightBtnController = arg_4_0.btnrControllerexcollection_:GetController("click")
	arg_4_0.recordBtnController = arg_4_0.controller:GetController("record")
	arg_4_0.clientShowController = arg_4_0.controller:GetController("clientShow")
	arg_4_0.stageTypeController = arg_4_0.controller:GetController("stageType")
	arg_4_0.specialStateController = arg_4_0.specialController:GetController("state")
	arg_4_0.clientInfoPage = SimBusinessClientPage.New(arg_4_0.clientGo)
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.backBtn, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.startBtn, nil, function()
		SimBusinessGame.GetInstance():UpdatePreviewPath(function(arg_9_0)
			if arg_9_0 then
				arg_6_0:Back()
				SimBusinessGame.GetInstance():StartGame()
			else
				ShowTips("SIM_BUSINESS_NO_VALID_PATH")
			end
		end)
	end)
	arg_6_0:AddBtnListener(arg_6_0.reStartBtn, nil, function()
		local var_10_0 = SimBusinessGame.GetInstance()

		var_10_0:UpdatePreviewPath(function(arg_11_0)
			if arg_11_0 then
				arg_6_0:Back()
				var_10_0:ResetStage(var_10_0.stage)
				var_10_0:StartGame()
			else
				ShowTips("SIM_BUSINESS_NO_VALID_PATH")
			end
		end)
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnlBtn_, nil, function()
		local var_12_0 = arg_6_0:GetStageIndex()

		if var_12_0 <= 1 then
			return
		end

		arg_6_0.stageID = SimBusinessStageCfg.all[var_12_0 - 1]

		arg_6_0:RefreshView()
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnrBtn_, nil, function()
		local var_13_0 = arg_6_0:GetStageIndex()

		if var_13_0 >= #SimBusinessStageCfg.get_id_list_by_type[SimBusinessConst.LevelType.DAILY] then
			return
		end

		arg_6_0.stageID = SimBusinessStageCfg.all[var_13_0 + 1]

		arg_6_0:RefreshView()
	end)
	arg_6_0:AddBtnListener(arg_6_0.showBackBtn_, nil, function()
		if arg_6_0.clientShowController:GetSelectedState() == "show" then
			arg_6_0.clientShowController:SetSelectedState("null")

			arg_6_0.selectID = nil

			arg_6_0.clientList:Refresh()
		end
	end)
end

function var_0_0.OnTop(arg_15_0)
	arg_15_0.stageID = arg_15_0.params_.stageID or arg_15_0.stageID

	arg_15_0:RefreshView()
end

function var_0_0.OnExit(arg_16_0)
	if arg_16_0.stageType == SimBusinessConst.LevelType.DAILY then
		arg_16_0.stageID = SimBusinessTools.GetDefaultEnterDailyLevel()

		if arg_16_0.stageID then
			SimBusinessBridge.EnterLevel(arg_16_0.stageID)
		else
			DormMinigame.Exit()
		end
	end
end

function var_0_0.RefreshView(arg_17_0)
	arg_17_0.stageID = arg_17_0.stageID or SimBusinessStageCfg.all[1]
	arg_17_0.stageType = SimBusinessStageCfg[arg_17_0.stageID].type

	arg_17_0:RefreshStageState()
	arg_17_0:RefreshClientList()
	arg_17_0:RefreshAwardList()
end

function var_0_0.RefreshStageState(arg_18_0)
	if arg_18_0.stageType == SimBusinessConst.LevelType.DAILY then
		arg_18_0.stageTypeController:SetSelectedState("normal")
		arg_18_0:RefreshNormalStageInfo()
	elseif arg_18_0.stageType == SimBusinessConst.LevelType.CHALLENGE then
		arg_18_0.stageTypeController:SetSelectedState("special")
		arg_18_0:RefreshSpecialStageInfo()
	end
end

function var_0_0.RefreshNormalStageInfo(arg_19_0)
	local var_19_0 = arg_19_0:GetStageIndex()

	arg_19_0.stageIndex.text = var_19_0

	if arg_19_0.stageID == SimBusinessStageCfg.all[1] then
		arg_19_0.leftBtnController:SetSelectedState("no")
	else
		arg_19_0.leftBtnController:SetSelectedState("yes")
	end

	local var_19_1 = SimBusinessStageCfg.get_id_list_by_type[SimBusinessConst.LevelType.DAILY]

	if arg_19_0.stageID == var_19_1[#var_19_1] then
		arg_19_0.rightBtnController:SetSelectedState("no")
	else
		arg_19_0.rightBtnController:SetSelectedState("yes")
	end

	local var_19_2, var_19_3 = SimBusinessTools.GetStageState(arg_19_0.stageID)

	if var_19_2 == "lock" then
		arg_19_0.recordBtnController:SetSelectedState("lock")

		arg_19_0.lockTips.text = GetTips(var_19_3)

		return
	end

	local var_19_4 = SimBusinessData.level[arg_19_0.stageID]

	if var_19_4 then
		if var_19_4.clear then
			if SimBusinessTools.IsChallengeLevel(arg_19_0.stageID) then
				arg_19_0.recordBtnController:SetSelectedState("clear")
			else
				arg_19_0.recordBtnController:SetSelectedState("clearDaily")
			end
		else
			arg_19_0.recordBtnController:SetSelectedState("inProgress")
		end
	else
		arg_19_0.recordBtnController:SetSelectedState("notStartYet")
	end
end

function var_0_0.RefreshSpecialStageInfo(arg_20_0)
	arg_20_0.specialname.text = SimBusinessStageCfg[arg_20_0.stageID].name
	arg_20_0.speialIcon.sprite = SimBusinessTools.GetStageIcon(arg_20_0.stageID)

	local var_20_0, var_20_1 = SimBusinessTools.GetStageState(arg_20_0.stageID)

	if var_20_0 ~= "lock" then
		if var_20_1 then
			arg_20_0.specialStateController:SetSelectedState("record")

			arg_20_0.specialRecord.text = var_20_1
		else
			arg_20_0.specialStateController:SetSelectedState("null")
		end
	end
end

function var_0_0.RefreshClientList(arg_21_0)
	if arg_21_0.stageID then
		arg_21_0.clientInfoList = {}

		for iter_21_0, iter_21_1 in ipairs(SimBusinessStageCfg[arg_21_0.stageID].wave) do
			local var_21_0 = {
				id = iter_21_1[1],
				remain = iter_21_1[2],
				max = iter_21_1[2]
			}

			table.insert(arg_21_0.clientInfoList, var_21_0)
		end

		arg_21_0.clientList:StartScroll(#arg_21_0.clientInfoList)
	end
end

function var_0_0.indexClientItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.clientInfoList[arg_22_1]

	arg_22_2:RefreshData(var_22_0, arg_22_1, arg_22_0.selectID == var_22_0.id, true)
	arg_22_2:RegisterClickFunc(handler(arg_22_0, arg_22_0.clickClientFunc))
end

function var_0_0.clickClientFunc(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.index

	arg_23_0.selectID = arg_23_1.guestID

	arg_23_0.clientList:Refresh()
	arg_23_0.clientShowController:SetSelectedState("show")
	arg_23_0.clientInfoPage:RefreshView(arg_23_0.clientInfoList[var_23_0].id, arg_23_0.clientInfoList[var_23_0].max)
end

function var_0_0.RefreshAwardList(arg_24_0)
	if arg_24_0.stageID then
		arg_24_0.awardInfoList = nullable(SimBusinessData.level[arg_24_0.stageID], "clear") and {} or SimBusinessStageCfg[arg_24_0.stageID].reward_list

		arg_24_0.awardList:StartScroll(#arg_24_0.awardInfoList)
	end
end

function var_0_0.indexAwardItem(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = rewardToPopableItemTemplate(formatReward(arg_25_0.awardInfoList[arg_25_1]))

	arg_25_2:SetData(var_25_0)
end

function var_0_0.GetStageIndex(arg_26_0)
	if arg_26_0.stageID then
		for iter_26_0, iter_26_1 in ipairs(SimBusinessStageCfg.get_id_list_by_type[arg_26_0.stageType]) do
			if iter_26_1 == arg_26_0.stageID then
				return iter_26_0
			end
		end
	end
end

function var_0_0.Dispose(arg_27_0)
	arg_27_0.clientList:Dispose()
	arg_27_0.awardList:Dispose()
	arg_27_0.clientInfoPage:Dispose()
	var_0_0.super.Dispose(arg_27_0)
end

return var_0_0

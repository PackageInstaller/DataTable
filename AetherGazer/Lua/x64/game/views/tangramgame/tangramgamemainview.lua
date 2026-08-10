local var_0_0 = class("TangramGameMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_Tangram/TangramStageSelectUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()

	arg_3_0.chapterController = arg_3_0.chapterCom:GetController("mapbg")
	arg_3_0.chapterBtnController = arg_3_0.chapterBtnCom:GetController("btnnum")
	arg_3_0.chapterBtnStateController = arg_3_0.chapterBtnCom:GetController("Status")
	arg_3_0.decodeFinController = arg_3_0.decodeCom:GetController("clear")
	arg_3_0.decodemapController = arg_3_0.decodeCom:GetController("map")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListener()

	arg_4_0.stageItemList = {
		TangramGameChapterStageView.New(arg_4_0.tangrammap1Go_, ActivityTangramGameChapterCfg.all[1]),
		(TangramGameChapterStageView.New(arg_4_0.tangrammap2Go_, ActivityTangramGameChapterCfg.all[2]))
	}
	arg_4_0.chapterName1.text = ActivityTangramGameChapterCfg[ActivityTangramGameChapterCfg.all[1]].name
	arg_4_0.chapterName2.text = ActivityTangramGameChapterCfg[ActivityTangramGameChapterCfg.all[2]].name
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.taskBtn, nil, function()
		JumpTools.OpenPageByJump("/summerChessBoardTask", {
			taskActivityID = ActivityConst.SUMMER_CHESS_BOARD_PLUZZE_TASK
		})
	end)

	for iter_5_0 = 1, 2 do
		arg_5_0:AddBtnListener(arg_5_0["chapter" .. iter_5_0 .. "btn"], nil, function()
			if arg_5_0.chapterIndex ~= iter_5_0 then
				arg_5_0.chapterIndex = iter_5_0

				local var_7_0 = ActivityTangramGameChapterCfg.all[arg_5_0.chapterIndex]

				arg_5_0.chapterID = var_7_0
				arg_5_0.chapterCfg = ActivityTangramGameChapterCfg[arg_5_0.chapterID]

				local var_7_1, var_7_2 = TangramGameTools:CheckChapterIsOpen(var_7_0)

				if not var_7_1 then
					ShowTips(var_7_2)

					return
				end

				arg_5_0:RefreshChapterView()
			end
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.decodeBtn, nil, function()
		local var_8_0 = arg_5_0.chapterCfg.inference_stage_list[1]

		if TangramGameData:CheckStageIsClear(var_8_0) then
			JumpTools.OpenPageByJump("/tangramGameShowView", {
				stageID = var_8_0
			})
		else
			JumpTools.OpenPageByJump("/tangramGameDecodeView", {
				chapterID = arg_5_0.chapterID
			})

			if manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_FULL_CLUE, arg_5_0.chapterID)) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_FULL_CLUE, arg_5_0.chapterID), 0)
			end
		end
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.activityID = TangramGameData:GetCurRunGameActivityID()

	if arg_9_0.params_.isGoto then
		arg_9_0.chapterID = arg_9_0.params_.chapterID
		arg_9_0.params_.isGoto = false
	else
		arg_9_0.chapterID = arg_9_0.chapterID or arg_9_0.params_.chapterID or ActivityTangramGameChapterCfg.all[1]
	end

	arg_9_0.chapterCfg = ActivityTangramGameChapterCfg[arg_9_0.chapterID]

	for iter_9_0, iter_9_1 in ipairs(ActivityTangramGameChapterCfg.all) do
		if iter_9_1 == arg_9_0.chapterID then
			arg_9_0.chapterIndex = iter_9_0
		end
	end

	if arg_9_0.activityID and arg_9_0.chapterID then
		arg_9_0:RefreshChapterBtnState()
	end

	arg_9_0:RefreshRedPonit()
	arg_9_0:RefreshChapterView()

	if arg_9_0.params_.stageID and arg_9_0.params_.playAni then
		arg_9_0.stageItemList[arg_9_0.chapterIndex]:PlayNewChipAni(arg_9_0.params_.stageID)
	end

	arg_9_0.params_ = nil
end

function var_0_0.RefreshRedPonit(arg_10_0)
	local var_10_0 = ActivityConst.SUMMER_CHESS_BOARD_PLUZZE_TASK

	manager.redPoint:bindUIandKey(arg_10_0.taskBtn.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, var_10_0))

	for iter_10_0 = 1, 2 do
		local var_10_1 = arg_10_0["chapter" .. iter_10_0 .. "btn"]
		local var_10_2 = ActivityTangramGameChapterCfg.all[iter_10_0]

		manager.redPoint:bindUIandKey(var_10_1.transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_CHAPTER, var_10_2))
	end
end

function var_0_0.UnBindRedPoint(arg_11_0)
	local var_11_0 = ActivityConst.SUMMER_CHESS_BOARD_PLUZZE_TASK

	manager.redPoint:unbindUIandKey(arg_11_0.taskBtn.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, var_11_0))

	for iter_11_0 = 1, 2 do
		local var_11_1 = arg_11_0["chapter" .. iter_11_0 .. "btn"]
		local var_11_2 = ActivityTangramGameChapterCfg.all[iter_11_0]

		manager.redPoint:unbindUIandKey(var_11_1.transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_CHAPTER, var_11_2))
	end
end

function var_0_0.OnTop(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_TANGRAM_GAME_DESCRIBE")
end

function var_0_0.RefreshChapterBtnState(arg_13_0)
	local var_13_0 = ActivityTangramGameChapterCfg.all[2]

	if TangramGameTools:CheckChapterIsOpen(var_13_0) then
		arg_13_0.chapterBtnController:SetSelectedState("02")

		if not getData(string.format("summer_tangram_%d", arg_13_0.activityID), "hadEntered") then
			arg_13_0.chapterIndex = 2

			saveData(string.format("summer_tangram_%d", arg_13_0.activityID), "hadEntered", true)
		end
	else
		arg_13_0.chapterBtnController:SetSelectedState("01")
	end
end

function var_0_0.RefreshChapterView(arg_14_0)
	if arg_14_0.chapterIndex == 1 then
		arg_14_0.chapterBtnStateController:SetSelectedState("left")
		arg_14_0.decodemapController:SetSelectedState("map1")
		arg_14_0.chapterController:SetSelectedState("map1")
	elseif arg_14_0.chapterIndex == 2 then
		arg_14_0.chapterBtnStateController:SetSelectedState("right")
		arg_14_0.decodemapController:SetSelectedState("map2")
		arg_14_0.chapterController:SetSelectedState("map2")
	end

	arg_14_0.chapterID = ActivityTangramGameChapterCfg.all[arg_14_0.chapterIndex]

	arg_14_0:RefreshChapterBaseInfo()
	arg_14_0:RefreshInferenceBtnState()
	arg_14_0:RefreshChapterStageView()
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_STAGE, tostring(arg_14_0.chapterID)), 0)

	arg_14_0.textdescribeText_.text = ActivityTangramGameChapterCfg[arg_14_0.chapterID].chapter_desc
end

function var_0_0.RefreshChapterStageView(arg_15_0)
	if arg_15_0.oldIndex then
		arg_15_0.stageItemList[arg_15_0.oldIndex]:OnExit()
	end

	arg_15_0.stageItemList[arg_15_0.chapterIndex]:OnTop()

	arg_15_0.oldIndex = arg_15_0.chapterIndex
end

function var_0_0.RefreshChapterBaseInfo(arg_16_0)
	local var_16_0 = ActivityData:GetActivityData(arg_16_0.activityID)

	arg_16_0.timeDesc.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(var_16_0.stopTime, true))
end

function var_0_0.RefreshInferenceBtnState(arg_17_0)
	local var_17_0, var_17_1, var_17_2 = TangramGameData:GetChapterFinProcess(arg_17_0.chapterID)
	local var_17_3, var_17_4 = TangramGameData:GetChapterFinTotalProcess(arg_17_0.chapterID)

	arg_17_0.sliderImg_.fillAmount = var_17_1 / var_17_2

	if var_17_4 then
		arg_17_0.decodeFinController:SetSelectedState("state1")
	elseif var_17_1 == var_17_2 then
		arg_17_0.decodeFinController:SetSelectedState("state2")
	else
		arg_17_0.decodeFinController:SetSelectedState("state0")
	end

	arg_17_0:RefreshDecodeChapterIsFin()
end

function var_0_0.RefreshDecodeChapterIsFin(arg_18_0)
	local var_18_0 = string.format("%s_%s", RedPointConst.ACTIVITY_3_5_TANGRAM_GAME_FULL_CLUE, arg_18_0.chapterID)

	if manager.redPoint:getTipBoolean(var_18_0) then
		manager.redPoint:SetRedPointIndependent(arg_18_0.decodeBtn.transform, true)
	else
		manager.redPoint:SetRedPointIndependent(arg_18_0.decodeBtn.transform, false)
	end
end

function var_0_0.StartTimer(arg_19_0)
	arg_19_0:DisposeTimer()

	arg_19_0.timer = Timer.New(function()
		arg_19_0:RefreshChapterBaseInfo()
	end, 1, -1)

	arg_19_0.timer:Start()
end

function var_0_0.DisposeTimer(arg_21_0)
	if arg_21_0.timer then
		arg_21_0.timer:Stop()

		arg_21_0.timer = nil
	end
end

function var_0_0.OnExit(arg_22_0)
	manager.windowBar:HideBar()
	arg_22_0:DisposeTimer()
	arg_22_0:UnBindRedPoint()
	arg_22_0:RemoveAllEventListener()
	AnimatorTools.Stop()

	arg_22_0.params_ = nil
end

function var_0_0.Dispose(arg_23_0)
	if arg_23_0.stageItemList then
		for iter_23_0, iter_23_1 in pairs(arg_23_0.stageItemList) do
			iter_23_1:Dispose()
		end
	end

	arg_23_0:DisposeTimer()
	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0

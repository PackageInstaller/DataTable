local var_0_0 = class("SummerPubStageView", ReduxView)
local var_0_1 = 3

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_SummerPub/MainPub/Activity_SummerPub_StageUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollMoveView1_ = ScrollMoveView.New(arg_4_0, arg_4_0.stageContent1_)
	arg_4_0.scrollMoveView2_ = ScrollMoveView.New(arg_4_0, arg_4_0.stageContent2_)
	arg_4_0.scrollMoveView3_ = ScrollMoveView.New(arg_4_0, arg_4_0.stageContent3_)
	arg_4_0.selectLevelItemHandler_ = handler(arg_4_0, arg_4_0.OnSelectLevelItem)
	arg_4_0.stageItemList_ = {}
	arg_4_0.curSelectStageIndex_ = 0

	local var_4_0 = arg_4_0.stageLine_.transform.rect.width
	local var_4_1 = arg_4_0.stageLine_.transform.rect.height

	for iter_4_0 = 1, var_0_1 do
		local var_4_2 = SummerPubLevelCfg.get_id_list_by_area[iter_4_0]

		arg_4_0.stageItemList_[iter_4_0] = {}

		for iter_4_1 = 1, #var_4_2 do
			local var_4_3 = var_4_2[iter_4_1]
			local var_4_4 = SummerPubLevelCfg[var_4_3]

			if var_4_4.prev_id == 0 or SummerPubData:GetClearNumByStageID(var_4_4.prev_id, SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0 then
				if iter_4_1 < #var_4_2 and SummerPubData:GetClearNumByStageID(var_4_3, SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0 then
					local var_4_5 = var_4_2[iter_4_1 + 1]
					local var_4_6 = SummerPubLevelCfg[var_4_5]
					local var_4_7 = Object.Instantiate(arg_4_0.stageLine_, arg_4_0["content" .. iter_4_0 .. "_"].transform)
					local var_4_8 = Vector3.New((var_4_6.position[1] + var_4_4.position[1]) / 2, (var_4_6.position[2] + var_4_4.position[2]) / 2, 0)

					var_4_7.transform.anchoredPosition = var_4_8

					if iter_4_1 % 2 == 1 then
						var_4_7.transform.localEulerAngles = Vector3.New(180, 0, 0)
					else
						var_4_7.transform.localEulerAngles = Vector3.New(180, 180, 0)
					end

					local var_4_9 = math.abs(var_4_6.position[1] - var_4_4.position[1]) / var_4_0
					local var_4_10 = math.abs(var_4_6.position[2] - var_4_4.position[2]) / var_4_1

					var_4_7.transform.localScale = Vector3.New(var_4_9, var_4_10, 1)

					SetActive(var_4_7, true)
				end

				local var_4_11

				if var_4_4.type == SummerPubConst.STAGE_TYPE.BALL then
					var_4_11 = Object.Instantiate(arg_4_0.ballStageItem_, arg_4_0["content" .. iter_4_0 .. "_"].transform)
				else
					var_4_11 = Object.Instantiate(arg_4_0.battleStageItem_, arg_4_0["content" .. iter_4_0 .. "_"].transform)
				end

				SetActive(var_4_11, true)

				local var_4_12 = Vector3.New(var_4_4.position[1], var_4_4.position[2], 0)

				var_4_11.transform.anchoredPosition = var_4_12
				arg_4_0.stageItemList_[iter_4_0][iter_4_1] = SummerPubStageItem.New(var_4_11, var_4_4.id, iter_4_1, arg_4_0.selectLevelItemHandler_)
			end
		end
	end

	arg_4_0.areaList_ = {}
	arg_4_0.selectAreaHandler_ = handler(arg_4_0, arg_4_0.UpdateAreaView)

	for iter_4_2 = 1, var_0_1 do
		arg_4_0.areaList_[iter_4_2] = SummerPubAreaItem.New(arg_4_0["areaBtn" .. iter_4_2 .. "_"], iter_4_2, arg_4_0.selectAreaHandler_)
	end

	arg_4_0.unlockStageController_ = arg_4_0.mainControllerEx_:GetController("UnlockStage")
	arg_4_0.selectStageController_ = arg_4_0.mainControllerEx_:GetController("SelectStage")
	arg_4_0.taskLevelObj_ = ActivityTaskLevelCommonItem.New(arg_4_0.taskLevelGo_, ActivityConst.ACTIVITY_NYA_SUMMER_PUB)
	arg_4_0.illuController_ = arg_4_0.mainControllerEx_:GetController("IlluCodex")
	arg_4_0.guoChangController_ = arg_4_0.mainControllerEx_:GetController("CutScenes")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.collectBtn_, nil, function()
		JumpTools.OpenPopUp("billiardGameIlluView")
	end)
end

function var_0_0.IsOpenSectionInfo(arg_7_0)
	return arg_7_0:IsOpenRoute("summerPubStageSectionView")
end

function var_0_0.TryToCloseSectionView(arg_8_0)
	if arg_8_0.curSelectStageIndex_ ~= 0 then
		arg_8_0.stageItemList_[arg_8_0.curAreaIndex_][arg_8_0.curSelectStageIndex_]:SetSelect(false)
	end

	arg_8_0.curSelectStageIndex_ = 0

	if arg_8_0:IsOpenSectionInfo() then
		JumpTools.Back()
	end
end

function var_0_0.OnTop(arg_9_0)
	local var_9_0 = 0

	if arg_9_0.curSelectStageIndex_ ~= 0 then
		var_9_0 = SummerPubLevelCfg.get_id_list_by_area[arg_9_0.curAreaIndex_][arg_9_0.curSelectStageIndex_]
	else
		var_9_0 = SummerPubData:GetStageAreaIndex()
	end

	arg_9_0:ScrollList(var_9_0)
	arg_9_0:TryToCloseSectionView()

	if SummerPubData:GetClearNumByStageID(SummerPubConst.SECOND_LEVEL_ID) > 0 then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
		manager.windowBar:RegistBackCallBack(function()
			JumpTools.OpenPageByJump("/summerPubEnterView")
		end)
	end
end

function var_0_0.OnEnter(arg_11_0)
	local var_11_0 = SummerPubData:GetStageAreaIndex()
	local var_11_1 = SummerPubLevelCfg[var_11_0]
	local var_11_2 = arg_11_0.params_.index or var_11_1.area

	arg_11_0:UpdateAreaView(var_11_2)
	arg_11_0.taskLevelObj_:Refresh({
		type = 2
	})
	arg_11_0:UpdateIlluBtn()
	arg_11_0:RefreshRedPoint()
	arg_11_0:ScrollList(var_11_0)
end

function var_0_0.RefreshRedPoint(arg_12_0)
	for iter_12_0 = 1, var_0_1 do
		manager.redPoint:bindUIandKey(arg_12_0.areaList_[iter_12_0].transform_, RedPointConst.SUMMER_PUB_STAGE_AREA .. iter_12_0)

		for iter_12_1, iter_12_2 in ipairs(arg_12_0.stageItemList_[iter_12_0]) do
			local var_12_0 = iter_12_2.levelID_

			manager.redPoint:bindUIandKey(iter_12_2.transform_, RedPointConst.SUMMER_PUB_STAGE_ITEM .. var_12_0)
		end
	end

	local var_12_1 = RedPointConst.SUMMER_PUB_RESIDENT_TASK .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB

	manager.redPoint:bindUIandKey(arg_12_0.taskLevelObj_.transform_, var_12_1)
	manager.redPoint:bindUIandKey(arg_12_0.collectBtn_.transform, RedPointConst.SUMMER_PUB_ILLUSTRATION)
end

function var_0_0.UpdateAreaView(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:TryToCloseSectionView()
	arg_13_0.guoChangController_:SetSelectedState("false")

	if arg_13_2 and arg_13_0.curAreaIndex_ ~= arg_13_1 then
		arg_13_0.guoChangController_:SetSelectedState("true")
	end

	arg_13_0.curAreaIndex_ = arg_13_1

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.stageItemList_[arg_13_0.curAreaIndex_]) do
		iter_13_1:RefreshUI()
	end

	if arg_13_2 then
		arg_13_0.Timer_ = Timer.New(function()
			arg_13_0:StopTimer()
			arg_13_0:OnEnterOver()
		end, 0.5, 1)

		arg_13_0.Timer_:Start()

		local var_13_0 = SummerPubLevelCfg.get_id_list_by_area[arg_13_1]

		arg_13_0:ScrollList(var_13_0[1])
	end
end

function var_0_0.OnEnterOver(arg_15_0)
	for iter_15_0 = 1, var_0_1 do
		if iter_15_0 == arg_15_0.curAreaIndex_ then
			SetActive(arg_15_0["stageContent" .. iter_15_0 .. "_"], true)
			arg_15_0.areaList_[iter_15_0]:SetSelect(true)
			arg_15_0.selectStageController_:SetSelectedState("state" .. iter_15_0)
		else
			SetActive(arg_15_0["stageContent" .. iter_15_0 .. "_"], false)
			arg_15_0.areaList_[iter_15_0]:SetSelect(false)
		end
	end
end

function var_0_0.UpdateIlluBtn(arg_16_0)
	local var_16_0 = "off"

	for iter_16_0, iter_16_1 in pairs(SummerPubData:GetIlluInfo()) do
		var_16_0 = "on"

		break
	end

	arg_16_0.illuController_:SetSelectedState(var_16_0)
end

function var_0_0.SelectStageItem(arg_17_0, arg_17_1)
	if arg_17_0.curSelectStageIndex_ ~= 0 then
		arg_17_0.stageItemList_[arg_17_0.curAreaIndex_][arg_17_0.curSelectStageIndex_]:SetSelect(false)
	end

	arg_17_0.stageItemList_[arg_17_0.curAreaIndex_][arg_17_1]:SetSelect(true)

	arg_17_0.curSelectStageIndex_ = arg_17_1
end

function var_0_0.OnSelectLevelItem(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 ~= arg_18_0.curSelectStageIndex_ then
		arg_18_0:SelectStageItem(arg_18_1)
		arg_18_0:ScrollList(arg_18_2)
	end
end

function var_0_0.StopTimer(arg_19_0)
	if arg_19_0.timer_ then
		arg_19_0.timer_:Stop()

		arg_19_0.timer_ = nil
	end
end

function var_0_0.OnExit(arg_20_0)
	arg_20_0:StopTimer()
	manager.windowBar:HideBar()
	arg_20_0.scrollMoveView1_:OnExit()
	arg_20_0.scrollMoveView2_:OnExit()
	arg_20_0.scrollMoveView3_:OnExit()

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.areaList_) do
		manager.redPoint:unbindUIandKey(iter_20_1.transform_, RedPointConst.SUMMER_PUB_STAGE_AREA .. iter_20_0)

		for iter_20_2, iter_20_3 in ipairs(arg_20_0.stageItemList_[iter_20_0]) do
			local var_20_0 = iter_20_3.levelID_

			manager.redPoint:unbindUIandKey(iter_20_3.transform_, RedPointConst.SUMMER_PUB_STAGE_ITEM .. var_20_0)
		end
	end

	local var_20_1 = RedPointConst.SUMMER_PUB_RESIDENT_TASK .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB

	manager.redPoint:unbindUIandKey(arg_20_0.taskLevelObj_.transform_, var_20_1)
	manager.redPoint:unbindUIandKey(arg_20_0.collectBtn_.transform, RedPointConst.SUMMER_PUB_ILLUSTRATION)
end

function var_0_0.ScrollList(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:GetScrollPos(arg_21_1)
	local var_21_1 = arg_21_0:GetScrollWidth()

	arg_21_0["scrollMoveView" .. arg_21_0.curAreaIndex_ .. "_"]:RefreshUI(var_21_0, var_21_1)
end

function var_0_0.GetScrollPos(arg_22_0, arg_22_1)
	return SummerPubLevelCfg[arg_22_1].position[1]
end

function var_0_0.GetScrollWidth(arg_23_0)
	local var_23_0 = arg_23_0.stageItemList_[arg_23_0.curAreaIndex_][1].cfg_.position[1]
	local var_23_1 = #arg_23_0.stageItemList_[arg_23_0.curAreaIndex_]

	return arg_23_0.stageItemList_[arg_23_0.curAreaIndex_][var_23_1].cfg_.position[1] - var_23_0
end

function var_0_0.Dispose(arg_24_0)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0.stageItemList_) do
		for iter_24_2, iter_24_3 in ipairs(iter_24_1) do
			iter_24_3:Dispose()
		end
	end

	for iter_24_4, iter_24_5 in ipairs(arg_24_0.areaList_) do
		manager.redPoint:unbindUIandKey(iter_24_5.transform_, RedPointConst.SUMMER_PUB_STAGE_AREA .. iter_24_4)
		iter_24_5:Dispose()
	end

	arg_24_0.taskLevelObj_:Dispose()
	arg_24_0.scrollMoveView1_:Dispose()

	arg_24_0.scrollMoveView1_ = nil

	arg_24_0.scrollMoveView2_:Dispose()

	arg_24_0.scrollMoveView2_ = nil

	arg_24_0.scrollMoveView3_:Dispose()

	arg_24_0.scrollMoveView3_ = nil

	var_0_0.super.Dispose(arg_24_0)
end

return var_0_0

local var_0_0 = class("AbyssMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Abyss/AbyssMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.stageController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "stage")
	arg_5_0.unlockController_ = ControllerUtil.GetController(arg_5_0.challengeGo_.transform, "unlock")
	arg_5_0.levelNumController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "levelNum")
	arg_5_0.resetGrayedController_ = ControllerUtil.GetController(arg_5_0.resetBtn_.transform, "grayed")

	local var_5_0 = {
		arg_5_0.levelGo1_,
		arg_5_0.levelGo2_,
		arg_5_0.levelGo3_,
		arg_5_0.levelGo4_,
		arg_5_0.levelGo5_
	}

	arg_5_0.levelItems_ = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_1 = AbyssLevelItemView.New(iter_5_1)

		table.insert(arg_5_0.levelItems_, var_5_1)
	end

	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uiListGo_, AbyssListItemView)
	arg_5_0.levelView_ = AbyssLevelView.New(arg_5_0.bossGo_)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, arg_6_0.layerCfgIdList_[arg_6_1], handler(arg_6_0, arg_6_0.OnItemClick))

	local var_6_0 = AbyssCfg[arg_6_0.layerCfgIdList_[arg_6_1]].level

	arg_6_2:SetSelect(var_6_0 == arg_6_0.curLayer_)
end

function var_0_0.OnItemClick(arg_7_0, arg_7_1)
	if arg_7_0:SelectLayer(arg_7_1) then
		arg_7_0:ReplayLayerTimeline()
	end
end

function var_0_0.ReplayLayerTimeline(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.levelItems_) do
		iter_8_1.playableDirector_.time = 0.75
	end
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.bonusBtn_, nil, function()
		JumpTools.OpenPageByJump("abyssReward", {})
	end)
	arg_9_0:AddBtnListener(arg_9_0.rankBtn_, nil, function()
		JumpTools.OpenPageByJump("/abyssRank", {})
	end)
	arg_9_0:AddBtnListener(arg_9_0.resetBtn_, nil, function()
		if AbyssData:GetLayerResetTime() <= 0 then
			ShowTips("ABYSS_LAYER_RESET_CLICK_TIP")

			return
		end

		local var_12_0 = AbyssData:GetCurrentLayer()

		if AbyssData:HaveUpperLevelChallenging(arg_9_0.curLayer_) then
			local var_12_1 = var_12_0

			if AbyssData:GetLayerStatus(var_12_0) == 1 then
				var_12_1 = var_12_0 - 1
			end

			ShowTips(string.format(GetTips("ABYSS_LAYER_CHALLENGING_RESET_TIP"), var_12_1))

			return
		end

		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("ABYSS_LAYER_RESET_TIP"),
			SecondTip = GetTips("ABYSS_LAYER_RESET_TIMES"),
			SecondValue = AbyssData:GetLayerResetTime() .. "/" .. AbyssData:GetLayerResetLimit(),
			OkCallback = function(arg_13_0)
				if arg_13_0 ~= AbyssData:GetActivityId() then
					ShowTips("ERROR_ACTIVITY_NOT_OPEN")

					return
				end

				AbyssAction.ResetLayer(arg_9_0.curLayer_)
			end,
			CancelCallback = function()
				return
			end,
			Param = AbyssData:GetActivityId()
		})
	end)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.levelItems_) do
		arg_9_0:AddBtnListener(iter_9_1.gameObject_:GetComponent(typeof(Button)), nil, function()
			arg_9_0:SelectStage(iter_9_0)
		end)
	end
end

function var_0_0.SelectLayer(arg_16_0, arg_16_1)
	if arg_16_0.curLayer_ == arg_16_1 then
		return false
	end

	arg_16_0.curLayer_ = arg_16_1

	saveData("abyss", "layer", arg_16_1)
	saveData("abyss", "refreshTime", AbyssData:GetRefreshTimestamp())

	arg_16_0.curLevelCfg_ = AbyssData:GetAbyssCfg(arg_16_0.curLayer_)

	arg_16_0.uiList_:Refresh()
	arg_16_0:UpdateLayerView()

	return true
end

function var_0_0.CancelSelectLevel(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.levelItems_) do
		iter_17_1:SetSelect(false)
	end
end

function var_0_0.SelectStage(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.levelItems_) do
		iter_18_1:SetSelect(iter_18_0 == arg_18_1)
	end

	arg_18_0:SwitchToStage("detail", arg_18_0.curLayer_, arg_18_1)
end

function var_0_0.UpdateLayerView(arg_19_0)
	arg_19_0.levelNumController_:SetSelectedState(tostring(#arg_19_0.curLevelCfg_.stage_list))

	for iter_19_0 = 1, #arg_19_0.curLevelCfg_.stage_list do
		arg_19_0.levelItems_[iter_19_0]:SetData(arg_19_0.curLevelCfg_, iter_19_0)
	end

	arg_19_0.currentFloorLabel_.text = arg_19_0.curLevelCfg_.level

	if AbyssData:GetLayerStatus(arg_19_0.curLayer_) == 0 then
		arg_19_0.unlockController_:SetSelectedState("false")
	else
		arg_19_0.unlockController_:SetSelectedState("true")
	end

	local var_19_0 = AbyssData:IsLayerChallenging(arg_19_0.curLayer_)

	SetActive(arg_19_0.resetBtn_.gameObject, var_19_0)

	if AbyssData:GetLayerResetTime() <= 0 then
		arg_19_0.resetGrayedController_:SetSelectedState("true")
	else
		arg_19_0.resetGrayedController_:SetSelectedState("false")
	end
end

function var_0_0.AddEventListeners(arg_20_0)
	arg_20_0:RegistEventListener(ABYSS_STAGE_RESET_TIME_UPDATE, function(arg_21_0, arg_21_1)
		if arg_21_0 == arg_20_0.curLayer_ then
			arg_20_0.uiList_:Refresh()
			arg_20_0:UpdateLayerView()
		end
	end)
	arg_20_0:RegistEventListener(ABYSS_LAYER_RESET_TIME_UPDATE, function(arg_22_0)
		if arg_22_0 == arg_20_0.curLayer_ then
			ShowTips("ABYSS_RESET_LAYER_FINISH_TIP")
			arg_20_0.uiList_:Refresh()
			arg_20_0:UpdateLayerView()
		end
	end)
end

function var_0_0.OnAbyssUpdate(arg_23_0)
	arg_23_0:OnItemClick(arg_23_0:GetInitLayer())
end

function var_0_0.OnTop(arg_24_0)
	arg_24_0:UpdateBar()

	if AbyssData:GetActivityId() ~= arg_24_0.enterActivityId_ and arg_24_0.curLayer_ ~= nil then
		if arg_24_0.stageController_:GetSelectedState() == "detail" then
			arg_24_0:CancelSelectLevel()
			arg_24_0:SwitchToStage("list", arg_24_0.curLayer_, arg_24_0.curStageIndex_)
		end

		arg_24_0.enterActivityId_ = AbyssData:GetActivityId()

		arg_24_0.uiList_:Refresh()
		arg_24_0:UpdateLayerView()
	else
		arg_24_0:UpdateLayerView()
	end
end

function var_0_0.OnBehind(arg_25_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_26_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ABYSS_DESC")
	manager.windowBar:RegistBackCallBack(function()
		if arg_26_0.stageController_:GetSelectedState() == "detail" then
			arg_26_0:CancelSelectLevel()
			arg_26_0:SwitchToStage("list", arg_26_0.curLayer_, arg_26_0.curStageIndex_)
		else
			JumpTools.Back()
		end
	end)
	manager.windowBar:RegistHomeCallBack(function()
		arg_26_0:CancelSelectLevel()
		gameContext:Go("/home", nil, nil, true)
	end)
end

function var_0_0.SwitchToStage(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	arg_29_4 = arg_29_4 or false

	if arg_29_0.stageController_:GetSelectedState() ~= arg_29_1 then
		arg_29_0:PlaySound()
	end

	arg_29_0.stageController_:SetSelectedState(arg_29_1, arg_29_4)

	if arg_29_0.curStageIndex_ == arg_29_3 and arg_29_2 == arg_29_0.curStageOfLayer_ then
		return
	end

	arg_29_0.curStageIndex_ = arg_29_3
	arg_29_0.curStageOfLayer_ = arg_29_2

	if arg_29_0.stageController_:GetSelectedState() == "detail" and arg_29_1 == "detail" then
		arg_29_0.levelView_.animator_:Play("AbyssLevelItemUI_right_cx", -1, 0)
	end

	arg_29_0.levelView_:SetData(arg_29_0.curLayer_, arg_29_0.curStageIndex_)
end

function var_0_0.PlaySound(arg_30_0)
	manager.audio:PlayEffect("ui_system", "Challenge_whoosh", "")
end

function var_0_0.InitData(arg_31_0)
	arg_31_0.enterActivityId_ = AbyssData:GetActivityId()
	arg_31_0.layerCfgIdList_ = {}

	local var_31_0 = AbyssData:GetCurrentIdList()

	for iter_31_0 = #var_31_0, 1, -1 do
		table.insert(arg_31_0.layerCfgIdList_, var_31_0[iter_31_0])
	end
end

function var_0_0.OnEnter(arg_32_0)
	arg_32_0:InitData()
	arg_32_0:AddEventListeners()
	AbyssAction.ClickChallengeRedPoint()

	if arg_32_0.levelView_ then
		arg_32_0.levelView_:OnEnter()
	end

	for iter_32_0, iter_32_1 in ipairs(arg_32_0.levelItems_) do
		iter_32_1:OnEnter()
	end

	arg_32_0.uiList_:StartScroll(#arg_32_0.layerCfgIdList_)
	arg_32_0:SelectLayer(arg_32_0:GetInitLayer())
	arg_32_0:SwitchToStage("list", arg_32_0.curLayer_, 1, true)
	manager.redPoint:bindUIandKey(arg_32_0.rewardNoticeContainer_, RedPointConst.ABYSS_REWARD, {
		x = 0,
		y = 0
	})
	arg_32_0:StartTimer()
	arg_32_0:UpdateTimer()

	if AbyssData:NeedTipBack() then
		ShowTips(string.format(GetTips("ABYSS_BACK_TIP"), AbyssData:GetFirstLockLayer()))
		AbyssAction.ReadBackFlag()
	end

	if PlayerData:GetUnclaimed(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.ABYSS) ~= nil then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("UNCLAIMED_BONUS_MAIL_TIP"),
			OkCallback = function()
				PlayerAction.ReadUnclaimedMessage(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.ABYSS)
			end
		})
	end
end

function var_0_0.OnExit(arg_34_0)
	arg_34_0:CancelSelectLevel()

	arg_34_0.keepLayer_ = arg_34_0.curLayer_

	manager.redPoint:unbindUIandKey(arg_34_0.rewardNoticeContainer_, RedPointConst.ABYSS_REWARD)
	arg_34_0:StopTimer()
	arg_34_0:RemoveAllEventListener()

	if arg_34_0.levelView_ then
		arg_34_0.levelView_:OnExit()
	end

	for iter_34_0, iter_34_1 in ipairs(arg_34_0.levelItems_) do
		iter_34_1:OnExit()
	end

	manager.windowBar:HideBar()
end

function var_0_0.GetInitLayer(arg_35_0)
	local var_35_0 = getData("abyss", "layer") or AbyssData:GetCurrentLayer()

	if arg_35_0.params_.refresh then
		var_35_0 = AbyssData:GetCurrentLayer()
	end

	if (getData("abyss", "refreshTime") or 0) > manager.time:GetServerTime() then
		return var_35_0
	end

	return AbyssData:GetCurrentLayer()
end

function var_0_0.StartTimer(arg_36_0)
	if arg_36_0.timer_ == nil then
		arg_36_0.timer_ = Timer.New(function()
			arg_36_0:UpdateTimer()
		end, 1, -1)
	end

	arg_36_0.timer_:Start()
end

function var_0_0.StopTimer(arg_38_0)
	if arg_38_0.timer_ then
		arg_38_0.timer_:Stop()

		arg_38_0.timer_ = nil
	end
end

function var_0_0.UpdateTimer(arg_39_0)
	arg_39_0.lastDayLabel_.text = manager.time:GetLostTimeStr(AbyssData:GetRefreshTimestamp(), nil, true)
end

function var_0_0.OnAbyssRefresh(arg_40_0)
	if arg_40_0:IsTop() then
		arg_40_0.uiList_:Refresh()
		arg_40_0:SelectLayer(AbyssData:GetCurrentLayer())

		if arg_40_0.stageController_:GetSelectedState() == "detail" then
			arg_40_0:CancelSelectLevel()
			arg_40_0:SwitchToStage("list", arg_40_0.curLayer_, arg_40_0.curStageIndex_)
		end
	end
end

function var_0_0.OnMainHomeViewTop(arg_41_0)
	arg_41_0.keepLayer_ = nil
end

function var_0_0.Dispose(arg_42_0)
	manager.windowBar:HideBar()
	arg_42_0:StopTimer()

	if arg_42_0.levelItems_ then
		for iter_42_0, iter_42_1 in pairs(arg_42_0.levelItems_) do
			iter_42_1:Dispose()
		end

		arg_42_0.levelItems_ = nil
	end

	if arg_42_0.uiList_ then
		arg_42_0.uiList_:Dispose()

		arg_42_0.uiList_ = nil
	end

	if arg_42_0.levelView_ then
		arg_42_0.levelView_:Dispose()

		arg_42_0.levelView_ = nil
	end

	var_0_0.super.Dispose(arg_42_0)
end

return var_0_0

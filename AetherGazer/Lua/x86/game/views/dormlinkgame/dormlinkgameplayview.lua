local var_0_0 = class("DormLinkGamePlayView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_LinkGame/Alone_LGPlay"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

local var_0_1 = class("DormLinkGamePlayView.BuffItem", BaseView)

function var_0_1.Ctor(arg_4_0, arg_4_1)
	arg_4_0.gameObject_ = arg_4_1
	arg_4_0.transform_ = arg_4_1.transform

	arg_4_0:BindCfgUI()
	arg_4_0:SetVisible(false)
end

function var_0_1.SetData(arg_5_0, arg_5_1)
	arg_5_0.info = arg_5_1

	arg_5_0:Refresh()
end

function var_0_1.Refresh(arg_6_0)
	local var_6_0 = Time.time - arg_6_0.info.start
	local var_6_1 = arg_6_0.info.duration - var_6_0

	arg_6_0.progress_.value = var_6_1 / arg_6_0.info.duration
	arg_6_0.timeText_.text = string.format("%d", var_6_1)

	if var_6_1 <= 0 then
		arg_6_0:SetVisible(false)
	end
end

function var_0_1.SetVisible(arg_7_0, arg_7_1)
	arg_7_0.visible = arg_7_1

	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.Init(arg_8_0)
	arg_8_0:InitUI()
	arg_8_0:AddUIListener()
end

function var_0_0.InitUI(arg_9_0)
	arg_9_0:BindCfgUI()

	arg_9_0.itemScroll = LuaList.New(handler(arg_9_0, arg_9_0.indexSkillItemList), arg_9_0.itemList_, DormLinkGameSkillItem)
	arg_9_0.passTableStateController = ControllerUtil.GetController(arg_9_0.statusGo_.transform, "status")
	arg_9_0.countDowmController = ControllerUtil.GetController(arg_9_0.countdownGo_.transform, "state")
	arg_9_0.batterController = ControllerUtil.GetController(arg_9_0.transform_, "batter")
	arg_9_0.useItemController = ControllerUtil.GetController(arg_9_0.transform_, "useItem")
	arg_9_0.showCountController = ControllerUtil.GetController(arg_9_0.transform_, "showCount")
	arg_9_0.startCountController = ControllerUtil.GetController(arg_9_0.transform_, "start")
	arg_9_0.diffController = ControllerUtil.GetController(arg_9_0.startgame1Go_.transform, "mode")
	arg_9_0.maskController = ControllerUtil.GetController(arg_9_0.transform_, "mask")
	arg_9_0.reduceController = ControllerUtil.GetController(arg_9_0.transform_, "reducePoint")
	arg_9_0.listController = ControllerUtil.GetController(arg_9_0.transform_, "listShow")
	arg_9_0.numAnimaton = arg_9_0.numGo_:GetComponent("Animation")
	arg_9_0.comboAnimaton = arg_9_0.comboGo_:GetComponent("Animation")
	arg_9_0.extendAnimaton = arg_9_0.extendNumGo_:GetComponent("Animation")
	arg_9_0.ignoreConnectionBuff = var_0_1.New(arg_9_0.buffIgnoreConnection_)
	arg_9_0.buffItems = {}

	table.insert(arg_9_0.buffItems, arg_9_0.ignoreConnectionBuff)
end

function var_0_0.AddUIListener(arg_10_0)
	arg_10_0:AddBtnListenerScale(arg_10_0.startbtnBtn_, nil, function()
		arg_10_0:StartGame()
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.levelID = DormLinkGameData:GetCurLevelID()
	arg_12_0.canInteractFlag = false

	arg_12_0.maskController:SetSelectedState("false")
	arg_12_0:RegisterEvents()
	arg_12_0:RefreshStartView()
	arg_12_0:RefreshCustomerBubble()
	arg_12_0:ResetView()
end

function var_0_0.OnTop(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("ACTIVITY_LINKGAME_STOP_TIPS"),
			OkCallback = function()
				arg_13_0:DisposeTimer()
				DormLinkGameData:StopGame(DormLinkGameConst.StopGameType.fail)
			end
		})
	end)
	manager.windowBar:SetGameHelpKey(DormLinkGameTools.GetGameHelpKey())
end

function var_0_0.OnBehind(arg_16_0)
	manager.windowBar:HideBar()
end

function var_0_0.RegisterEvents(arg_17_0)
	arg_17_0:RegistEventListener(DORM_LINK_START_PLAY, function()
		arg_17_0.countDowmController:SetSelectedState("start")

		arg_17_0.canInteractFlag = true
	end)
	arg_17_0:RegistEventListener(DORM_LINK_END_GAME, function(arg_19_0, arg_19_1)
		arg_17_0:DisposeTimer()

		if arg_17_0.bubbleList then
			for iter_19_0, iter_19_1 in pairs(arg_17_0.bubbleList) do
				iter_19_1:SetActive(false)
			end
		end

		if arg_19_0 == DormLinkGameConst.StopGameType.success then
			DormLinkGameTools:PlaySpecialVoice(DormLinkGameConst.SpecialVoiceType.SuccssfulLevel)
			JumpTools.OpenPageByJump("/dormLinkGameSuccessView", {
				data = arg_19_1
			})
		elseif arg_19_0 == DormLinkGameConst.StopGameType.fail then
			DormLinkGameTools:PlaySpecialVoice(DormLinkGameConst.SpecialVoiceType.FaileLevel)
			JumpTools.OpenPageByJump("/dormLinkGameFailView")
		end
	end)
	arg_17_0:RegistEventListener(DORM_LINK_REFRESH_GAME_TIME, function(arg_20_0)
		arg_17_0:RefreshLastTime(arg_20_0)
	end)
	arg_17_0:RegistEventListener(LIANLIANKAN_ITEM_MATCH, function(arg_21_0)
		DormLinkGameData:EliminateMaterial(arg_21_0)
	end)
	arg_17_0:RegistEventListener(DORM_LINK_REFRESH_BATTER_NUM, function()
		arg_17_0:RefreshBatterNum()
		arg_17_0:RefreshExtendPoint()
	end)
	arg_17_0:RegistEventListener(DORM_LINK_REFRESH_CUSTOMER_BUBBLE, function(arg_23_0, arg_23_1)
		if arg_17_0.bubbleList and arg_17_0.bubbleList[arg_23_0] then
			arg_17_0.bubbleList[arg_23_0]:RefreshBubbleInfo(arg_23_1)
		end
	end)
	arg_17_0:RegistEventListener(LIANLIANKAN_ITEM_OVERFLOW, function(arg_24_0)
		DormLinkGameData:DrainMaterial(arg_24_0)
	end)
	arg_17_0:RegistEventListener(LIANLIANKAN_GAME_CLEAR, function()
		DormLinkGameData:StopGame(DormLinkGameConst.StopGameType.success)
	end)
	arg_17_0:RegistEventListener(DORM_LINK_REFRESH_DRAIN_MATERIAL, function(arg_26_0)
		arg_17_0:RefreshExtendPoint()
		arg_17_0:RefreshDrainPoint(arg_26_0)
	end)
	arg_17_0:RegistEventListener(DORM_LINK_REFRESH_EXTEND_ADDITION, function()
		arg_17_0:RefreshExtendAddition()
	end)
	arg_17_0:RegistEventListener(DORM_LINK_REFRESH_MATERIAL_TIME, function(arg_28_0)
		arg_17_0:RefreshMaterialTime(arg_28_0)
	end)
	arg_17_0:RegistEventListener(DORM_LINK_REFRESH_CUSTOMER_SATIETY, function(arg_29_0)
		arg_17_0.bubbleList[arg_29_0]:RefreshSatiety()
	end)
	arg_17_0:RegistEventListener(DORM_LINK_REFRESH_BUFF_IGNORE_CONNECTION, function()
		local var_30_0 = DormLinkGameData:GetGameBuffIgnoreConnectCheck()

		arg_17_0.ignoreConnectionBuff:SetData(var_30_0)
		arg_17_0.ignoreConnectionBuff:SetVisible(true)
	end)
end

local function var_0_2(arg_31_0)
	return nullable(ActivityCfg, ActivityLinkGameCfg[arg_31_0].activity_id, "remark")
end

function var_0_0.RefreshRunView(arg_32_0)
	if arg_32_0.bubbleList then
		for iter_32_0, iter_32_1 in pairs(arg_32_0.bubbleList) do
			iter_32_1:SetActive(true)
			iter_32_1:RefreshTransPosition()
			iter_32_1:RefreshBubbleInfo()
			iter_32_1:RefreshSatiety()
		end
	end

	arg_32_0.levelText_.text = var_0_2(arg_32_0.levelID)

	arg_32_0:RefreshLastTime()
	arg_32_0:RefreshExtendPoint()
	arg_32_0:RefreshExtendAddition()
	arg_32_0:RefreshBatterNum()
	arg_32_0:RefreshMaterialTime()
	arg_32_0:RefreshSkillItemList(false)
end

function var_0_0.RefreshStartView(arg_33_0)
	arg_33_0.startCountController:SetSelectedState("true")
	arg_33_0.reduceController:SetSelectedState("false")

	arg_33_0.startTitleText.text = var_0_2(arg_33_0.levelID)

	local var_33_0 = ActivityLinkGameCfg[arg_33_0.levelID].time_limit

	arg_33_0.startTimeText.text = string.format(GetTips("ACTIVITY_LINKGAME_TIME"), tostring(var_33_0))

	local var_33_1 = DormLinkGameData:GetSceneData().difficultyLevel

	if var_33_1 == 1 then
		arg_33_0.diffController:SetSelectedState("eazy")
	elseif var_33_1 == 2 then
		arg_33_0.diffController:SetSelectedState("hard")
	elseif var_33_1 == 9 then
		arg_33_0.diffController:SetSelectedState("SP")
	end

	arg_33_0:RefreshSkillItemList(true)
end

function var_0_0.RefreshLastTime(arg_34_0, arg_34_1)
	arg_34_1 = arg_34_1 or DormLinkGameData:GetSceneData().limitTime
	arg_34_0.lastTimeText_.text = GetTipsF("ACTIVITY_LINKGAME_REST_TIME", arg_34_1)
end

function var_0_0.RefreshSkillItemList(arg_35_0, arg_35_1)
	arg_35_0.skillItemState = arg_35_1

	if ActivityLinkGameCfg[arg_35_0.levelID].property_limit == 1 then
		arg_35_0.listController:SetSelectedState("true")

		arg_35_0.skillItemList = ActivityLinkGameGoodsCfg.all

		arg_35_0.itemScroll:StartScroll(#arg_35_0.skillItemList)
	else
		arg_35_0.listController:SetSelectedState("false")
	end
end

function var_0_0.indexSkillItemList(arg_36_0, arg_36_1, arg_36_2)
	arg_36_2:RefreshUI(arg_36_0.skillItemList[arg_36_1], arg_36_0.skillItemState)
	arg_36_2:UseItem(function(arg_37_0)
		if arg_36_0.canInteractFlag then
			if ActivityLinkGameGoodsCfg[arg_37_0].coin_num <= DormLinkGameData:GetCurCnaUseTokenNum() then
				DormLinkGameTools:UseSkillItem(arg_37_0)
				arg_36_0:ShowUseItemTips(arg_37_0)
				arg_36_0.itemScroll:Refresh()
			else
				ShowTips(GetTips("ACTIVITY_LINKGAME_COIN_NOT_ENOUGH"))
			end
		end
	end)
end

function var_0_0.RefreshMaterialTime(arg_38_0, arg_38_1)
	if arg_38_1 then
		arg_38_0.countdownText_.text = string.format(GetTips("ACTIVITY_LINKGAME_CELL_PUSH"), arg_38_1)
	else
		arg_38_1 = DormLinkGameData:GetGameCacheInfo().generateInterval
		arg_38_0.countdownText_.text = string.format(GetTips("ACTIVITY_LINKGAME_CELL_PUSH"), GameSetting.linkgame_count_down.value[1] + arg_38_1)
	end
end

function var_0_0.RefreshExtendPoint(arg_39_0)
	if not arg_39_0.extendNum then
		local var_39_0 = 0
	end

	local var_39_1 = DormLinkGameData:GetGameCacheInfo()

	arg_39_0.extendNum = var_39_1.extendPoint - var_39_1.drainPoint
	arg_39_0.extendNumText_.text = var_39_1.extendPoint - var_39_1.drainPoint
end

function var_0_0.RefreshDrainPoint(arg_40_0, arg_40_1)
	arg_40_0.reduceController:SetSelectedState("true")
	arg_40_0.extendAnimaton:Play()

	arg_40_0.reduceNum.text = -1 * arg_40_1

	if not arg_40_0.reduceTimer then
		local var_40_0 = GameSetting.linkgame_score_tips_time.value[1]

		arg_40_0.reduceTimer = Timer.New(function()
			arg_40_0.reduceController:SetSelectedState("false")
		end, var_40_0, 1)
	else
		arg_40_0.reduceTimer:Reset()
	end

	arg_40_0.reduceTimer:Start()
end

function var_0_0.RefreshExtendAddition(arg_42_0)
	arg_42_0.extendAdditionText_.text = string.format("+%d", DormLinkGameData:GetExtendAddition()) .. "%"
end

function var_0_0.RefreshBatterNum(arg_43_0)
	if DormLinkGameData:GetBatterNum() > 0 then
		arg_43_0.batterController:SetSelectedState("true")

		arg_43_0.BatterNum.text = string.format(GetTips("ACTIVITY_LINKGAME_HIT"), DormLinkGameData:GetBatterNum())

		arg_43_0.comboAnimaton:Play()
	else
		arg_43_0.batterController:SetSelectedState("false")
	end
end

function var_0_0.RefreshCustomerBubble(arg_44_0)
	if not arg_44_0.bubbleList then
		arg_44_0.bubbleList = {}

		local var_44_0 = DormLinkGameData:GetCustomerList()

		for iter_44_0, iter_44_1 in pairs(var_44_0) do
			arg_44_0.bubbleList[iter_44_0] = DormLinkGameBubbleItem.New(arg_44_0.bubbleGo_, iter_44_0, arg_44_0.transform_)

			arg_44_0.bubbleList[iter_44_0]:RefreshBubbleInfo()
		end
	end
end

function var_0_0.RefreshBuffItems(arg_45_0, arg_45_1)
	for iter_45_0, iter_45_1 in ipairs(arg_45_0.buffItems) do
		if iter_45_1.visible then
			iter_45_1:Refresh()
		end
	end
end

function var_0_0.ShowUseItemTips(arg_46_0, arg_46_1)
	local var_46_0 = ActivityLinkGameGoodsCfg[arg_46_1]

	if var_46_0 then
		arg_46_0.useItemController:SetSelectedState("true")

		local var_46_1 = var_46_0.name
		local var_46_2 = var_46_0.coin_num
		local var_46_3 = DormLinkGameData:GetMainActivityID()
		local var_46_4 = DormLinkGameTools:GetCurrencyID(var_46_3)

		arg_46_0.revokeIcon.sprite = ItemTools.getItemSprite(var_46_4)
		arg_46_0.revokeText.text = string.format(GetTips("ACTIVITY_LINKGAME_COST_TIPS"), var_46_2, var_46_1)

		if arg_46_0.itemShowTimer then
			arg_46_0.itemShowTimer:Stop()

			arg_46_0.itemShowTimer = nil
		end

		local var_46_5 = GameSetting.linkgame_tips_time.value[1]

		arg_46_0.itemShowTimer = Timer.New(function()
			arg_46_0.useItemController:SetSelectedState("false")
		end, var_46_5, 1)

		arg_46_0.itemShowTimer:Start()
	end
end

function var_0_0.StartGame(arg_48_0)
	manager.notify:Invoke(LIANLIANKAN_GAME_START)
	arg_48_0.startCountController:SetSelectedState("false")
	arg_48_0:RefreshRunView()
	arg_48_0:StartCountDownShow()
	arg_48_0:StartBuffDisplayUpdate()
end

function var_0_0.StartCountDownShow(arg_49_0)
	arg_49_0.showCountController:SetSelectedState("true")
	arg_49_0.numAnimaton:Play()
	arg_49_0.countDowmController:SetSelectedState("num")

	if not arg_49_0.countTimer then
		arg_49_0.countDownTime = GameSetting.linkgame_start_time.value[1]
		arg_49_0.countDownText.text = arg_49_0.countDownTime
		arg_49_0.countTimer = Timer.New(function()
			arg_49_0.countDownTime = arg_49_0.countDownTime - 1

			if arg_49_0.countDownTime > 0 then
				arg_49_0.countDownText.text = arg_49_0.countDownTime

				arg_49_0.numAnimaton:Play()
			else
				arg_49_0.countDowmController:SetSelectedState("start")
				arg_49_0:StartCountDownTextShow()
			end
		end, 1, -1)
	else
		arg_49_0.countTimer:Reset()
	end

	arg_49_0.countTimer:Start()
	arg_49_0.maskController:SetSelectedState("true")
end

function var_0_0.StopBuffDisplayUpdate(arg_51_0)
	if arg_51_0.updateBuffFrameTimer then
		arg_51_0.updateBuffFrameTimer:Stop()

		arg_51_0.updateBuffFrameTimer = nil
	end
end

function var_0_0.StartBuffDisplayUpdate(arg_52_0)
	arg_52_0:StopBuffDisplayUpdate()

	arg_52_0.updateBuffFrameTimer = FrameTimer.New(function()
		local var_53_0 = Time.deltaTime

		arg_52_0:RefreshBuffItems(var_53_0)
	end, 1, -1)

	arg_52_0.updateBuffFrameTimer:Start()
end

function var_0_0.DisposeTimer(arg_54_0)
	if arg_54_0.countTimer then
		arg_54_0.countTimer:Stop()

		arg_54_0.countTimer = nil
	end

	if arg_54_0.textCountTimer then
		arg_54_0.textCountTimer:Stop()

		arg_54_0.textCountTimer = nil
	end

	if arg_54_0.updateBuffFrameTimer then
		arg_54_0.updateBuffFrameTimer:Stop()

		arg_54_0.updateBuffFrameTimer = nil
	end
end

function var_0_0.ResetView(arg_55_0)
	arg_55_0.showCountController:SetSelectedState("false")
	arg_55_0.batterController:SetSelectedState("false")
	arg_55_0.useItemController:SetSelectedState("false")
	arg_55_0.reduceController:SetSelectedState("false")
end

function var_0_0.StartCountDownTextShow(arg_56_0)
	if arg_56_0.countTimer then
		arg_56_0.countTimer:Stop()
	end

	if not arg_56_0.textCountTimer then
		arg_56_0.textCountDownTime = GameSetting.linkgame_word_disappear_time.value[1] / 100
		arg_56_0.textCountTimer = Timer.New(function()
			arg_56_0.showCountController:SetSelectedState("false")
			arg_56_0.maskController:SetSelectedState("false")
			DormLinkGameData:PlayerStartGame()
		end, arg_56_0.textCountDownTime, 1)
	else
		arg_56_0.textCountTimer:Reset()
	end

	arg_56_0.textCountTimer:Start()
end

function var_0_0.OnExit(arg_58_0)
	arg_58_0:RemoveAllEventListener()
	arg_58_0:DisposeTimer()
end

function var_0_0.Dispose(arg_59_0)
	if arg_59_0.itemScroll then
		arg_59_0.itemScroll:Dispose()

		arg_59_0.itemScroll = nil
	end

	if arg_59_0.bubbleList then
		for iter_59_0, iter_59_1 in pairs(arg_59_0.bubbleList) do
			iter_59_1:Dispose()
		end
	end

	if arg_59_0.buffItems then
		for iter_59_2, iter_59_3 in ipairs(arg_59_0.buffItems) do
			iter_59_3:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_59_0)
end

return var_0_0

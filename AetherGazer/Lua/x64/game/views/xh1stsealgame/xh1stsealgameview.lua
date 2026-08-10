local var_0_0 = class("XH1stSealGameView", ReduxView)

function var_0_0.GetItemIndex(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_1 == 1 and arg_1_2 == 1 then
		return 2
	end

	if arg_1_1 == 1 and arg_1_2 == 2 then
		return 3
	end

	if arg_1_1 == 1 and arg_1_2 == 3 then
		return 4
	end

	if arg_1_1 == 2 and arg_1_2 == 1 then
		return 9
	end

	if arg_1_1 == 2 and arg_1_2 == 2 then
		return 1
	end

	if arg_1_1 == 2 and arg_1_2 == 3 then
		return 5
	end

	if arg_1_1 == 3 and arg_1_2 == 1 then
		return 8
	end

	if arg_1_1 == 3 and arg_1_2 == 2 then
		return 7
	end

	if arg_1_1 == 3 and arg_1_2 == 3 then
		return 6
	end

	return 1
end

function var_0_0.UIName(arg_2_0)
	return "UI/VersionUI/XuHeng1stUI/XH1stSealUI/XH1stSealGameUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_4_0)
	return
end

function var_0_0.Init(arg_5_0)
	arg_5_0:InitUI()
	arg_5_0:AddUIListener()
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()

	arg_6_0.dialogController_ = ControllerUtil.GetController(arg_6_0.gameObject_.transform, "dialog")
	arg_6_0.resetController_ = ControllerUtil.GetController(arg_6_0.resetBtn_.transform, "name")
	arg_6_0.playingController_ = ControllerUtil.GetController(arg_6_0.gameObject_.transform, "playing")
	arg_6_0.faceController_ = ControllerUtil.GetController(arg_6_0.gameObject_.transform, "face")
	arg_6_0.itemControllers_ = {
		ControllerUtil.GetController(arg_6_0.itemBtn1_.transform, "babelItem"),
		ControllerUtil.GetController(arg_6_0.itemBtn2_.transform, "babelItem"),
		ControllerUtil.GetController(arg_6_0.itemBtn3_.transform, "babelItem"),
		ControllerUtil.GetController(arg_6_0.itemBtn4_.transform, "babelItem"),
		ControllerUtil.GetController(arg_6_0.itemBtn5_.transform, "babelItem")
	}
	arg_6_0.sealItemGos_ = {
		arg_6_0.rewarditmei0Go_,
		arg_6_0.rewarditmei1Go_,
		arg_6_0.rewarditmei2Go_,
		arg_6_0.rewarditmei3Go_,
		arg_6_0.rewarditmei4Go_,
		arg_6_0.rewarditmei5Go_,
		arg_6_0.rewarditmei6Go_,
		arg_6_0.rewarditmei7Go_,
		arg_6_0.rewarditmei8Go_
	}
	arg_6_0.sealItems_ = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.sealItemGos_) do
		local var_6_0 = XH1stSealSealItemView.New(iter_6_1)

		var_6_0:SetItemClick(handler(arg_6_0, arg_6_0.OnItemClick))
		table.insert(arg_6_0.sealItems_, var_6_0)
	end

	arg_6_0.rewardItemGos_ = {
		arg_6_0.rewarditme0Go_,
		arg_6_0.rewarditme1Go_,
		arg_6_0.rewarditme2Go_,
		arg_6_0.rewarditme3Go_,
		arg_6_0.rewarditme4Go_,
		arg_6_0.rewarditme5Go_,
		arg_6_0.rewarditme6Go_,
		arg_6_0.rewarditme7Go_
	}
	arg_6_0.rewardItems_ = {}

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.rewardItemGos_) do
		local var_6_1 = XH1stSealRewardItemView.New(iter_6_3)

		var_6_1:SetItemClick(handler(arg_6_0, arg_6_0.OnItemClick))
		table.insert(arg_6_0.rewardItems_, var_6_1)
	end
end

function var_0_0.OnItemClick(arg_7_0, arg_7_1)
	if arg_7_0.playing_ then
		return
	end

	if arg_7_0.cding_ then
		return
	end

	arg_7_0.cding_ = true

	if arg_7_0.cdTimer_ then
		arg_7_0.cdTimer_:Stop()

		arg_7_0.cdTimer_ = nil
	end

	arg_7_0.cdTimer_ = TimeTools.StartAfterSeconds(0.3, function()
		arg_7_0.cding_ = false

		if arg_7_0.cdTimer_ then
			arg_7_0.cdTimer_:Stop()

			arg_7_0.cdTimer_ = nil
		end
	end, {})

	CustomLog.Log(debug.traceback(string.format("click item")))
	ShowPopItem(POP_ITEM, {
		arg_7_1.id,
		arg_7_1.number
	})
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.roleBtn_, nil, function()
		if arg_9_0.playing_ then
			return
		end

		arg_9_0:PlayDialog("click")
	end)
	arg_9_0:AddBtnListener(arg_9_0.sealBtn_, nil, function()
		if arg_9_0.playing_ then
			return
		end

		if arg_9_0.cding_ then
			return
		end

		local var_11_0 = ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].cost_item
		local var_11_1 = ItemCfg[var_11_0[1]]

		if ItemTools.getItemNum(var_11_0[1]) < var_11_0[2] then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), tostring(ItemTools.getItemName(var_11_1.id))))

			return
		end

		if XH1stSealData:IsTicketFinish(arg_9_0.currentTicketId_) then
			ShowTips("XH1ST_SEAL_TICKET_FINISH_TIP")

			return
		end

		arg_9_0:SetPlaying(true)
		CustomLog.Log(debug.traceback(string.format("start seal")))
		XH1stSealAction.RequestSeal(ActivityConst.ACTIVITY_2_0_SEAL, arg_9_0.currentTicketId_ or 1)
	end)
	arg_9_0:AddBtnListener(arg_9_0.resetBtn_, nil, function()
		if arg_9_0.playing_ then
			return
		end

		local var_12_0 = false
		local var_12_1 = ActivitySealTicketCfg.get_id_list_by_ticket_id[arg_9_0.currentTicketId_]

		for iter_12_0, iter_12_1 in ipairs(var_12_1) do
			local var_12_2 = ActivitySealTicketCfg[iter_12_1]

			if var_12_2.is_main_reward == 1 and XH1stSealData:HaveGotReward(arg_9_0.currentTicketId_, var_12_2.row, var_12_2.column) then
				var_12_0 = true

				break
			end
		end

		if not var_12_0 then
			ShowTips("XH1ST_SEAL_NOT_MAIN_REWARD_TIP")

			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("RESET_INFINITY"),
			OkCallback = function()
				XH1stSealAction.ResetSeal(ActivityConst.ACTIVITY_2_0_SEAL, arg_9_0.currentTicketId_)
			end
		})
	end)

	for iter_9_0 = 1, 5 do
		arg_9_0:AddBtnListener(arg_9_0["itemBtn" .. iter_9_0 .. "_"], nil, function()
			if arg_9_0.playing_ then
				return
			end

			arg_9_0:SelectTicket(iter_9_0)
		end)
	end
end

function var_0_0.AddEventListeners(arg_15_0)
	arg_15_0:RegistEventListener(XH1ST_SEAL_UPDATE, function()
		arg_15_0:SelectTicket(arg_15_0.currentTicketId_)
	end)
end

function var_0_0.OnTop(arg_17_0)
	arg_17_0:UpdateBar()
end

function var_0_0.OnBehind(arg_18_0)
	manager.windowBar:HideBar()
end

function var_0_0.SelectTicket(arg_19_0, arg_19_1)
	if not XH1stSealData:IsUnLock(arg_19_1) then
		ShowTips(string.format(GetTips("XH1ST_SEAL_NOT_UNLOCK_TIP"), tostring(arg_19_1 - 1)))

		return
	end

	arg_19_0.currentTicketId_ = arg_19_1

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.itemControllers_) do
		if XH1stSealData:IsUnLock(iter_19_0) then
			iter_19_1:SetSelectedState(arg_19_1 == iter_19_0 and "select" or "normal")
		else
			iter_19_1:SetSelectedState("lock")
		end
	end

	arg_19_0.ticketIdList_ = ActivitySealTicketCfg.get_id_list_by_ticket_id[arg_19_1]

	arg_19_0:UpdateView()
	arg_19_0:StopAnimators()
end

function var_0_0.StopAnimators(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0.sealItems_) do
		iter_20_1:StopAnimators()
	end
end

function var_0_0.UpdateBar(arg_21_0)
	local var_21_0 = ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].cost_item

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		var_21_0[1]
	})
	manager.windowBar:SetBarCanAdd(var_21_0[1], true)
	manager.windowBar:SetGameHelpKey("XH1ST_SEAL_DESC")
end

function var_0_0.OnEnter(arg_22_0)
	arg_22_0:AddEventListeners()
	arg_22_0:SelectTicket(XH1stSealData:GetCurrentTicket())
	arg_22_0:UpdateTimer()
	arg_22_0:PlayDialog("enter")
end

function var_0_0.OnExit(arg_23_0)
	arg_23_0.cding_ = false

	if arg_23_0.cdTimer_ then
		arg_23_0.cdTimer_:Stop()

		arg_23_0.cdTimer_ = nil
	end

	arg_23_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	arg_23_0:StartTimer()
	arg_23_0:StopTimer()
	arg_23_0:StopDialogTimer()
	manager.audio:Stop("effect")
end

function var_0_0.StartTimer(arg_24_0)
	if arg_24_0.timer_ == nil then
		arg_24_0.timer_ = Timer.New(function()
			arg_24_0:UpdateTimer()
		end, 1, -1)
	end

	arg_24_0.timer_:Start()
end

function var_0_0.StopTimer(arg_26_0)
	if arg_26_0.timer_ then
		arg_26_0.timer_:Stop()

		arg_26_0.timer_ = nil
	end
end

function var_0_0.UpdateTimer(arg_27_0)
	local var_27_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_2_0_SEAL).stopTime

	arg_27_0.lastTimeLabel_.text = manager.time:GetLostTimeStr2(var_27_0)
end

function var_0_0.UpdateView(arg_28_0)
	arg_28_0.rewardItems_[1]:SetData(1, arg_28_0.ticketIdList_[5])
	arg_28_0.rewardItems_[2]:SetData(2, arg_28_0.ticketIdList_[4])
	arg_28_0.rewardItems_[3]:SetData(3, arg_28_0.ticketIdList_[3])
	arg_28_0.rewardItems_[4]:SetData(4, arg_28_0.ticketIdList_[2])
	arg_28_0.rewardItems_[5]:SetData(5, arg_28_0.ticketIdList_[1])
	arg_28_0.rewardItems_[6]:SetData(6, arg_28_0.ticketIdList_[6])
	arg_28_0.rewardItems_[7]:SetData(7, arg_28_0.ticketIdList_[10])
	arg_28_0.rewardItems_[8]:SetData(8, arg_28_0.ticketIdList_[14])
	arg_28_0.sealItems_[1]:SetData(1, arg_28_0.ticketIdList_[12])
	arg_28_0.sealItems_[2]:SetData(2, arg_28_0.ticketIdList_[7])
	arg_28_0.sealItems_[3]:SetData(3, arg_28_0.ticketIdList_[8])
	arg_28_0.sealItems_[4]:SetData(4, arg_28_0.ticketIdList_[9])
	arg_28_0.sealItems_[5]:SetData(5, arg_28_0.ticketIdList_[13])
	arg_28_0.sealItems_[6]:SetData(6, arg_28_0.ticketIdList_[17])
	arg_28_0.sealItems_[7]:SetData(7, arg_28_0.ticketIdList_[16])
	arg_28_0.sealItems_[8]:SetData(8, arg_28_0.ticketIdList_[15])
	arg_28_0.sealItems_[9]:SetData(9, arg_28_0.ticketIdList_[11])

	local var_28_0 = ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].cost_item

	arg_28_0.costIcon_.sprite = ItemTools.getItemLittleSprite(var_28_0[1])

	local var_28_1 = ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].ticket_list

	if arg_28_0.currentTicketId_ == var_28_1[#var_28_1] then
		SetActive(arg_28_0.resetBtn_.gameObject, true)

		local var_28_2 = false
		local var_28_3 = ActivitySealTicketCfg.get_id_list_by_ticket_id[arg_28_0.currentTicketId_]

		for iter_28_0, iter_28_1 in ipairs(var_28_3) do
			local var_28_4 = ActivitySealTicketCfg[iter_28_1]

			if var_28_4.is_main_reward == 1 and XH1stSealData:HaveGotReward(arg_28_0.currentTicketId_, var_28_4.row, var_28_4.column) then
				var_28_2 = true

				break
			end
		end

		if not var_28_2 then
			arg_28_0.resetController_:SetSelectedState("nouse")
		else
			arg_28_0.resetController_:SetSelectedState("use")
		end
	else
		SetActive(arg_28_0.resetBtn_.gameObject, false)
	end

	if XH1stSealData:IsTicketFinish(arg_28_0.currentTicketId_) then
		SetActive(arg_28_0.sealBtn_.gameObject, false)
	else
		SetActive(arg_28_0.sealBtn_.gameObject, true)
	end
end

function var_0_0.OnMainHomeViewTop(arg_29_0)
	return
end

function var_0_0.OnSealResult(arg_30_0, arg_30_1, arg_30_2)
	if isSuccess(arg_30_1.result) then
		arg_30_0:PlaySealEffect(arg_30_1.coordinate.row, arg_30_1.coordinate.column, function()
			arg_30_0:ShowResult(arg_30_1, arg_30_2)
		end)
	else
		arg_30_0:SetPlaying(false)
	end
end

function var_0_0.PlaySealEffect(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = arg_32_0:GetItemIndex(arg_32_1, arg_32_2)
	local var_32_1 = arg_32_0.sealItems_[var_32_0].sealAnimator_

	manager.audio:PlayEffect("minigame_activity_2_0", "minigame_activity_2_0_stamp_stamp", "")
	arg_32_0:PlayAnimator(var_32_1, "sealAnimator", arg_32_3)
end

function var_0_0.PlayLinkEffect(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0:PlayNext(arg_33_1, 1, arg_33_2)
end

function var_0_0.PlayNext(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = arg_34_1[arg_34_2]

	arg_34_0:PlayOneCoordinateLine(var_34_0, function()
		arg_34_2 = arg_34_2 + 1

		if arg_34_2 <= #arg_34_1 then
			arg_34_0:PlayNext(arg_34_1, arg_34_2, arg_34_3)
		else
			arg_34_3()
		end
	end)
end

function var_0_0.PlayOneCoordinateLine(arg_36_0, arg_36_1, arg_36_2)
	manager.audio:PlayEffect("minigame_activity_2_0", "minigame_activity_2_0_stamp_lianxian", "")

	local var_36_0 = 0
	local var_36_1 = #arg_36_1

	for iter_36_0, iter_36_1 in ipairs(arg_36_1) do
		local var_36_2 = XH1stSealData:DecodeCoordinateNumber(iter_36_1)
		local var_36_3 = arg_36_0:GetItemIndex(var_36_2[1], var_36_2[2])
		local var_36_4 = arg_36_0.sealItems_[var_36_3].linkAnimator_

		arg_36_0:PlayAnimator(var_36_4, "linkAnimator", function()
			var_36_0 = var_36_0 + 1

			if var_36_0 >= var_36_1 then
				arg_36_2()
			end
		end)
	end
end

function var_0_0.ShowResult(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0, var_38_1, var_38_2 = XH1stSealData:OnSealSuccess(arg_38_2.ticket_id, arg_38_1.coordinate.row, arg_38_1.coordinate.column)
	local var_38_3 = #arg_38_1.special_reward_list > 0
	local var_38_4 = ActivitySealTicketCfg.get_id_list_by_ticket_id[arg_38_2.ticket_id]

	for iter_38_0, iter_38_1 in ipairs(var_38_4) do
		local var_38_5 = ActivitySealTicketCfg[iter_38_1]

		if var_38_5.row == arg_38_1.coordinate.row and var_38_5.column == arg_38_1.coordinate.column then
			arg_38_0:UpdateView()
			getReward2(arg_38_1.normal_reward_list, nil, function()
				if #arg_38_1.special_reward_list > 0 then
					arg_38_0:PlayLinkEffect(var_38_2, function()
						getReward2(arg_38_1.special_reward_list)
						arg_38_0:SetPlaying(false)
					end)
				else
					arg_38_0:SetPlaying(false)
				end
			end)

			break
		end
	end

	if var_38_3 then
		if var_38_1 then
			arg_38_0:PlayDialog("reward2")
		else
			arg_38_0:PlayDialog("reward1")
		end
	else
		arg_38_0:PlayDialog("seal")
	end
end

function var_0_0.PlayDialog(arg_41_0, arg_41_1)
	arg_41_0:StopDialogTimer()

	local var_41_0 = ActivitySealDialogCfg.get_id_list_by_action[arg_41_1][1]
	local var_41_1 = ActivitySealDialogCfg[var_41_0]

	arg_41_0.dialogController_:SetSelectedState(arg_41_1)

	local var_41_2 = math.random(1, #var_41_1.sheetName)
	local var_41_3

	if var_41_1.face and var_41_1.face[var_41_2] then
		var_41_3 = var_41_1.face[var_41_2]
	end

	CustomLog.Log(debug.traceback(string.format("face = %s", tostring(var_41_3))))
	arg_41_0.faceController_:SetSelectedState(var_41_3)

	local var_41_4 = var_41_1.sheetName[var_41_2]
	local var_41_5 = var_41_1.cueName[var_41_2]
	local var_41_6 = var_41_1.awbName[var_41_2]
	local var_41_7 = var_41_1.word[var_41_2]

	arg_41_0.talkLabel_.text = var_41_7

	if var_41_4 ~= "" then
		manager.audio:PlayEffect(var_41_4, var_41_5, var_41_6)

		local var_41_8 = manager.audio:GetVoiceLength(var_41_4, var_41_5, var_41_6)

		arg_41_0.talkBubbleTimer_ = TimeTools.StartAfterSeconds(var_41_8 / 1000, function()
			arg_41_0:StopDialogTimer()
		end, {})
	end
end

function var_0_0.StopDialogTimer(arg_43_0)
	arg_43_0.dialogController_:SetSelectedState("normal")
	CustomLog.Log(debug.traceback(string.format("ResetNormal")))
	arg_43_0.faceController_:SetSelectedState("normal")

	if arg_43_0.talkBubbleTimer_ ~= nil then
		arg_43_0.talkBubbleTimer_:Stop()

		arg_43_0.talkBubbleTimer_ = nil
	end
end

function var_0_0.PlayAnimator(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	arg_44_1.speed = 1

	arg_44_1:Play(arg_44_2, -1, 0)
	arg_44_1:Update(0)

	local var_44_0 = arg_44_1:GetCurrentAnimatorStateInfo(0)

	TimeTools.StartAfterSeconds(var_44_0.length, function()
		arg_44_3()
	end, {})
end

function var_0_0.SetPlaying(arg_46_0, arg_46_1)
	arg_46_0.playing_ = arg_46_1

	arg_46_0.playingController_:SetSelectedState(arg_46_1 and "true" or "false")
end

function var_0_0.Dispose(arg_47_0)
	arg_47_0:SetPlaying(false)

	if arg_47_0.sealItems_ then
		for iter_47_0, iter_47_1 in pairs(arg_47_0.sealItems_) do
			iter_47_1:Dispose()
		end

		arg_47_0.sealItems_ = nil
	end

	if arg_47_0.rewardItems_ then
		for iter_47_2, iter_47_3 in pairs(arg_47_0.rewardItems_) do
			iter_47_3:Dispose()
		end

		arg_47_0.rewardItems_ = nil
	end

	var_0_0.super.Dispose(arg_47_0)
end

return var_0_0

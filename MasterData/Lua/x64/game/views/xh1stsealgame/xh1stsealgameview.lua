local XH1stSealGameView = class("XH1stSealGameView", ReduxView)

function XH1stSealGameView:GetItemIndex(arg_1_1, arg_1_2)
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

function XH1stSealGameView:UIName()
	return "UI/VersionUI/XuHeng1stUI/XH1stSealUI/XH1stSealGameUI"
end

function XH1stSealGameView:UIParent()
	return manager.ui.uiMain.transform
end

function XH1stSealGameView:OnCtor()
	return
end

function XH1stSealGameView:Init()
	self:InitUI()
	self:AddUIListener()
end

function XH1stSealGameView:InitUI()
	self:BindCfgUI()

	self.dialogController_ = ControllerUtil.GetController(self.gameObject_.transform, "dialog")
	self.resetController_ = ControllerUtil.GetController(self.resetBtn_.transform, "name")
	self.playingController_ = ControllerUtil.GetController(self.gameObject_.transform, "playing")
	self.faceController_ = ControllerUtil.GetController(self.gameObject_.transform, "face")
	self.itemControllers_ = {
		ControllerUtil.GetController(self.itemBtn1_.transform, "babelItem"),
		ControllerUtil.GetController(self.itemBtn2_.transform, "babelItem"),
		ControllerUtil.GetController(self.itemBtn3_.transform, "babelItem"),
		ControllerUtil.GetController(self.itemBtn4_.transform, "babelItem"),
		ControllerUtil.GetController(self.itemBtn5_.transform, "babelItem")
	}
	self.sealItemGos_ = {
		self.rewarditmei0Go_,
		self.rewarditmei1Go_,
		self.rewarditmei2Go_,
		self.rewarditmei3Go_,
		self.rewarditmei4Go_,
		self.rewarditmei5Go_,
		self.rewarditmei6Go_,
		self.rewarditmei7Go_,
		self.rewarditmei8Go_
	}
	self.sealItems_ = {}

	for iter_6_0, iter_6_1 in ipairs(self.sealItemGos_) do
		local var_6_0 = XH1stSealSealItemView.New(iter_6_1)

		var_6_0:SetItemClick(handler(self, self.OnItemClick))
		table.insert(self.sealItems_, var_6_0)
	end

	self.rewardItemGos_ = {
		self.rewarditme0Go_,
		self.rewarditme1Go_,
		self.rewarditme2Go_,
		self.rewarditme3Go_,
		self.rewarditme4Go_,
		self.rewarditme5Go_,
		self.rewarditme6Go_,
		self.rewarditme7Go_
	}
	self.rewardItems_ = {}

	for iter_6_2, iter_6_3 in ipairs(self.rewardItemGos_) do
		local var_6_1 = XH1stSealRewardItemView.New(iter_6_3)

		var_6_1:SetItemClick(handler(self, self.OnItemClick))
		table.insert(self.rewardItems_, var_6_1)
	end
end

function XH1stSealGameView:OnItemClick(arg_7_1)
	if self.playing_ then
		return
	end

	if self.cding_ then
		return
	end

	self.cding_ = true

	if self.cdTimer_ then
		self.cdTimer_:Stop()

		self.cdTimer_ = nil
	end

	self.cdTimer_ = TimeTools.StartAfterSeconds(0.3, function()
		self.cding_ = false

		if self.cdTimer_ then
			self.cdTimer_:Stop()

			self.cdTimer_ = nil
		end
	end, {})

	CustomLog.Log(debug.traceback(string.format("click item")))
	ShowPopItem(POP_ITEM, {
		arg_7_1.id,
		arg_7_1.number
	})
end

function XH1stSealGameView:AddUIListener()
	self:AddBtnListener(self.roleBtn_, nil, function()
		if self.playing_ then
			return
		end

		self:PlayDialog("click")
	end)
	self:AddBtnListener(self.sealBtn_, nil, function()
		if self.playing_ then
			return
		end

		if self.cding_ then
			return
		end

		if ItemTools.getItemNum(ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].cost_item[1]) < ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].cost_item[2] then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), tostring(ItemTools.getItemName(ItemCfg[ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].cost_item[1]].id))))

			return
		end

		if XH1stSealData:IsTicketFinish(self.currentTicketId_) then
			ShowTips("XH1ST_SEAL_TICKET_FINISH_TIP")

			return
		end

		self:SetPlaying(true)
		CustomLog.Log(debug.traceback(string.format("start seal")))
		XH1stSealAction.RequestSeal(ActivityConst.ACTIVITY_2_0_SEAL, self.currentTicketId_ or 1)
	end)
	self:AddBtnListener(self.resetBtn_, nil, function()
		if self.playing_ then
			return
		end

		local var_12_0 = false

		for iter_12_0, iter_12_1 in ipairs(ActivitySealTicketCfg.get_id_list_by_ticket_id[self.currentTicketId_]) do
			if ActivitySealTicketCfg[iter_12_1].is_main_reward == 1 and XH1stSealData:HaveGotReward(self.currentTicketId_, ActivitySealTicketCfg[iter_12_1].row, ActivitySealTicketCfg[iter_12_1].column) then
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
				XH1stSealAction.ResetSeal(ActivityConst.ACTIVITY_2_0_SEAL, self.currentTicketId_)
			end
		})
	end)

	for iter_9_0 = 1, 5 do
		self:AddBtnListener(self["itemBtn" .. iter_9_0 .. "_"], nil, function()
			if self.playing_ then
				return
			end

			self:SelectTicket(iter_9_0)
		end)
	end
end

function XH1stSealGameView:AddEventListeners()
	self:RegistEventListener(XH1ST_SEAL_UPDATE, function()
		self:SelectTicket(self.currentTicketId_)
	end)
end

function XH1stSealGameView:OnTop()
	self:UpdateBar()
end

function XH1stSealGameView:OnBehind()
	manager.windowBar:HideBar()
end

function XH1stSealGameView:SelectTicket(arg_19_1)
	if not XH1stSealData:IsUnLock(arg_19_1) then
		ShowTips(string.format(GetTips("XH1ST_SEAL_NOT_UNLOCK_TIP"), tostring(arg_19_1 - 1)))

		return
	end

	self.currentTicketId_ = arg_19_1

	for iter_19_0, iter_19_1 in ipairs(self.itemControllers_) do
		if XH1stSealData:IsUnLock(iter_19_0) then
			iter_19_1:SetSelectedState(arg_19_1 == iter_19_0 and "select" or "normal")
		else
			iter_19_1:SetSelectedState("lock")
		end
	end

	self.ticketIdList_ = ActivitySealTicketCfg.get_id_list_by_ticket_id[arg_19_1]

	self:UpdateView()
	self:StopAnimators()
end

function XH1stSealGameView:StopAnimators()
	for iter_20_0, iter_20_1 in ipairs(self.sealItems_) do
		iter_20_1:StopAnimators()
	end
end

function XH1stSealGameView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].cost_item[1]
	})
	manager.windowBar:SetBarCanAdd(ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].cost_item[1], true)
	manager.windowBar:SetGameHelpKey("XH1ST_SEAL_DESC")
end

function XH1stSealGameView:OnEnter()
	self:AddEventListeners()
	self:SelectTicket(XH1stSealData:GetCurrentTicket())
	self:UpdateTimer()
	self:PlayDialog("enter")
end

function XH1stSealGameView:OnExit()
	self.cding_ = false

	if self.cdTimer_ then
		self.cdTimer_:Stop()

		self.cdTimer_ = nil
	end

	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
	self:StartTimer()
	self:StopTimer()
	self:StopDialogTimer()
	manager.audio:Stop("effect")
end

function XH1stSealGameView:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateTimer()
		end, 1, -1)
	end

	self.timer_:Start()
end

function XH1stSealGameView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function XH1stSealGameView:UpdateTimer()
	self.lastTimeLabel_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(ActivityConst.ACTIVITY_2_0_SEAL).stopTime)
end

function XH1stSealGameView:UpdateView()
	self.rewardItems_[1]:SetData(1, self.ticketIdList_[5])
	self.rewardItems_[2]:SetData(2, self.ticketIdList_[4])
	self.rewardItems_[3]:SetData(3, self.ticketIdList_[3])
	self.rewardItems_[4]:SetData(4, self.ticketIdList_[2])
	self.rewardItems_[5]:SetData(5, self.ticketIdList_[1])
	self.rewardItems_[6]:SetData(6, self.ticketIdList_[6])
	self.rewardItems_[7]:SetData(7, self.ticketIdList_[10])
	self.rewardItems_[8]:SetData(8, self.ticketIdList_[14])
	self.sealItems_[1]:SetData(1, self.ticketIdList_[12])
	self.sealItems_[2]:SetData(2, self.ticketIdList_[7])
	self.sealItems_[3]:SetData(3, self.ticketIdList_[8])
	self.sealItems_[4]:SetData(4, self.ticketIdList_[9])
	self.sealItems_[5]:SetData(5, self.ticketIdList_[13])
	self.sealItems_[6]:SetData(6, self.ticketIdList_[17])
	self.sealItems_[7]:SetData(7, self.ticketIdList_[16])
	self.sealItems_[8]:SetData(8, self.ticketIdList_[15])
	self.sealItems_[9]:SetData(9, self.ticketIdList_[11])

	self.costIcon_.sprite = ItemTools.getItemLittleSprite(ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].cost_item[1])

	if self.currentTicketId_ == ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].ticket_list[#ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].ticket_list] then
		SetActive(self.resetBtn_.gameObject, true)

		local var_28_0 = false

		for iter_28_0, iter_28_1 in ipairs(ActivitySealTicketCfg.get_id_list_by_ticket_id[self.currentTicketId_]) do
			if ActivitySealTicketCfg[iter_28_1].is_main_reward == 1 and XH1stSealData:HaveGotReward(self.currentTicketId_, ActivitySealTicketCfg[iter_28_1].row, ActivitySealTicketCfg[iter_28_1].column) then
				var_28_0 = true

				break
			end
		end

		if not var_28_0 then
			self.resetController_:SetSelectedState("nouse")
		else
			self.resetController_:SetSelectedState("use")
		end
	else
		SetActive(self.resetBtn_.gameObject, false)
	end

	if XH1stSealData:IsTicketFinish(self.currentTicketId_) then
		SetActive(self.sealBtn_.gameObject, false)
	else
		SetActive(self.sealBtn_.gameObject, true)
	end
end

function XH1stSealGameView:OnMainHomeViewTop()
	return
end

function XH1stSealGameView:OnSealResult(arg_30_1, arg_30_2)
	if isSuccess(arg_30_1.result) then
		self:PlaySealEffect(arg_30_1.coordinate.row, arg_30_1.coordinate.column, function()
			self:ShowResult(arg_30_1, arg_30_2)
		end)
	else
		self:SetPlaying(false)
	end
end

function XH1stSealGameView:PlaySealEffect(arg_32_1, arg_32_2, arg_32_3)
	manager.audio:PlayEffect("minigame_activity_2_0", "minigame_activity_2_0_stamp_stamp", "")
	self:PlayAnimator(self.sealItems_[self:GetItemIndex(arg_32_1, arg_32_2)].sealAnimator_, "sealAnimator", arg_32_3)
end

function XH1stSealGameView:PlayLinkEffect(arg_33_1, arg_33_2)
	self:PlayNext(arg_33_1, 1, arg_33_2)
end

function XH1stSealGameView:PlayNext(arg_34_1, arg_34_2, arg_34_3)
	self:PlayOneCoordinateLine(arg_34_1[arg_34_2], function()
		arg_34_2 = arg_34_2 + 1

		if arg_34_2 <= #arg_34_1 then
			self:PlayNext(arg_34_1, arg_34_2, arg_34_3)
		else
			arg_34_3()
		end
	end)
end

function XH1stSealGameView:PlayOneCoordinateLine(arg_36_1, arg_36_2)
	manager.audio:PlayEffect("minigame_activity_2_0", "minigame_activity_2_0_stamp_lianxian", "")

	local var_36_0 = 0
	local var_36_1 = #arg_36_1

	for iter_36_0, iter_36_1 in ipairs(arg_36_1) do
		local var_36_2 = XH1stSealData:DecodeCoordinateNumber(iter_36_1)

		self:PlayAnimator(self.sealItems_[self:GetItemIndex(var_36_2[1], var_36_2[2])].linkAnimator_, "linkAnimator", function()
			var_36_0 = var_36_0 + 1

			if var_36_0 >= var_36_1 then
				arg_36_2()
			end
		end)
	end
end

function XH1stSealGameView:ShowResult(arg_38_1, arg_38_2)
	local var_38_0, var_38_1, var_38_2 = XH1stSealData:OnSealSuccess(arg_38_2.ticket_id, arg_38_1.coordinate.row, arg_38_1.coordinate.column)
	local var_38_3 = #arg_38_1.special_reward_list > 0

	for iter_38_0, iter_38_1 in ipairs(ActivitySealTicketCfg.get_id_list_by_ticket_id[arg_38_2.ticket_id]) do
		if ActivitySealTicketCfg[iter_38_1].row == arg_38_1.coordinate.row and ActivitySealTicketCfg[iter_38_1].column == arg_38_1.coordinate.column then
			self:UpdateView()
			getReward2(arg_38_1.normal_reward_list, nil, function()
				if #arg_38_1.special_reward_list > 0 then
					self:PlayLinkEffect(var_38_2, function()
						getReward2(arg_38_1.special_reward_list)
						self:SetPlaying(false)
					end)
				else
					self:SetPlaying(false)
				end
			end)

			break
		end
	end

	if var_38_3 then
		if var_38_1 then
			self:PlayDialog("reward2")
		else
			self:PlayDialog("reward1")
		end
	else
		self:PlayDialog("seal")
	end
end

function XH1stSealGameView:PlayDialog(arg_41_1)
	self:StopDialogTimer()
	self.dialogController_:SetSelectedState(arg_41_1)

	local var_41_0 = math.random(1, #ActivitySealDialogCfg[ActivitySealDialogCfg.get_id_list_by_action[arg_41_1][1]].sheetName)
	local var_41_1

	if ActivitySealDialogCfg[ActivitySealDialogCfg.get_id_list_by_action[arg_41_1][1]].face and ActivitySealDialogCfg[ActivitySealDialogCfg.get_id_list_by_action[arg_41_1][1]].face[var_41_0] then
		var_41_1 = ActivitySealDialogCfg[ActivitySealDialogCfg.get_id_list_by_action[arg_41_1][1]].face[var_41_0]
	end

	CustomLog.Log(debug.traceback(string.format("face = %s", tostring(var_41_1))))
	self.faceController_:SetSelectedState(var_41_1)

	self.talkLabel_.text = ActivitySealDialogCfg[ActivitySealDialogCfg.get_id_list_by_action[arg_41_1][1]].word[var_41_0]

	if ActivitySealDialogCfg[ActivitySealDialogCfg.get_id_list_by_action[arg_41_1][1]].sheetName[var_41_0] ~= "" then
		manager.audio:PlayEffect(ActivitySealDialogCfg[ActivitySealDialogCfg.get_id_list_by_action[arg_41_1][1]].sheetName[var_41_0], ActivitySealDialogCfg[ActivitySealDialogCfg.get_id_list_by_action[arg_41_1][1]].cueName[var_41_0], ActivitySealDialogCfg[ActivitySealDialogCfg.get_id_list_by_action[arg_41_1][1]].awbName[var_41_0])

		self.talkBubbleTimer_ = TimeTools.StartAfterSeconds(manager.audio:GetVoiceLength(ActivitySealDialogCfg[ActivitySealDialogCfg.get_id_list_by_action[arg_41_1][1]].sheetName[var_41_0], ActivitySealDialogCfg[ActivitySealDialogCfg.get_id_list_by_action[arg_41_1][1]].cueName[var_41_0], ActivitySealDialogCfg[ActivitySealDialogCfg.get_id_list_by_action[arg_41_1][1]].awbName[var_41_0]) / 1000, function()
			self:StopDialogTimer()
		end, {})
	end
end

function XH1stSealGameView:StopDialogTimer()
	self.dialogController_:SetSelectedState("normal")
	CustomLog.Log(debug.traceback(string.format("ResetNormal")))
	self.faceController_:SetSelectedState("normal")

	if self.talkBubbleTimer_ ~= nil then
		self.talkBubbleTimer_:Stop()

		self.talkBubbleTimer_ = nil
	end
end

function XH1stSealGameView:PlayAnimator(arg_44_1, arg_44_2, arg_44_3)
	arg_44_1.speed = 1

	arg_44_1:Play(arg_44_2, -1, 0)
	arg_44_1:Update(0)
	TimeTools.StartAfterSeconds(arg_44_1:GetCurrentAnimatorStateInfo(0).length, function()
		arg_44_3()
	end, {})
end

function XH1stSealGameView:SetPlaying(arg_46_1)
	self.playing_ = arg_46_1

	self.playingController_:SetSelectedState(arg_46_1 and "true" or "false")
end

function XH1stSealGameView:Dispose()
	self:SetPlaying(false)

	if self.sealItems_ then
		for iter_47_0, iter_47_1 in pairs(self.sealItems_) do
			iter_47_1:Dispose()
		end

		self.sealItems_ = nil
	end

	if self.rewardItems_ then
		for iter_47_2, iter_47_3 in pairs(self.rewardItems_) do
			iter_47_3:Dispose()
		end

		self.rewardItems_ = nil
	end

	XH1stSealGameView.super.Dispose(self)
end

return XH1stSealGameView

local DormLinkGamePlayView = class("DormLinkGamePlayView", ReduxView)

function DormLinkGamePlayView:UIName()
	return "Widget/Version/Alone_LinkGame/Alone_LGPlay"
end

function DormLinkGamePlayView:UIParent()
	return manager.ui.uiMain.transform
end

function DormLinkGamePlayView:OnCtor()
	return
end

local var_0_1 = class("DormLinkGamePlayView.BuffItem", BaseView)

function var_0_1:Ctor(arg_4_1)
	self.gameObject_ = arg_4_1
	self.transform_ = arg_4_1.transform

	self:BindCfgUI()
	self:SetVisible(false)
end

function var_0_1:SetData(arg_5_1)
	self.info = arg_5_1

	self:Refresh()
end

function var_0_1:Refresh()
	self.progress_.value = (self.info.duration - (Time.time - self.info.start)) / self.info.duration
	self.timeText_.text = string.format("%d", self.info.duration - (Time.time - self.info.start))

	if self.info.duration - (Time.time - self.info.start) <= 0 then
		self:SetVisible(false)
	end
end

function var_0_1:SetVisible(arg_7_1)
	self.visible = arg_7_1

	SetActive(self.gameObject_, arg_7_1)
end

function DormLinkGamePlayView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormLinkGamePlayView:InitUI()
	self:BindCfgUI()

	self.itemScroll = LuaList.New(handler(self, self.indexSkillItemList), self.itemList_, DormLinkGameSkillItem)
	self.passTableStateController = ControllerUtil.GetController(self.statusGo_.transform, "status")
	self.countDowmController = ControllerUtil.GetController(self.countdownGo_.transform, "state")
	self.batterController = ControllerUtil.GetController(self.transform_, "batter")
	self.useItemController = ControllerUtil.GetController(self.transform_, "useItem")
	self.showCountController = ControllerUtil.GetController(self.transform_, "showCount")
	self.startCountController = ControllerUtil.GetController(self.transform_, "start")
	self.diffController = ControllerUtil.GetController(self.startgame1Go_.transform, "mode")
	self.maskController = ControllerUtil.GetController(self.transform_, "mask")
	self.reduceController = ControllerUtil.GetController(self.transform_, "reducePoint")
	self.listController = ControllerUtil.GetController(self.transform_, "listShow")
	self.numAnimaton = self.numGo_:GetComponent("Animation")
	self.comboAnimaton = self.comboGo_:GetComponent("Animation")
	self.extendAnimaton = self.extendNumGo_:GetComponent("Animation")
	self.ignoreConnectionBuff = var_0_1.New(self.buffIgnoreConnection_)
	self.buffItems = {}

	table.insert(self.buffItems, self.ignoreConnectionBuff)
end

function DormLinkGamePlayView:AddUIListener()
	self:AddBtnListenerScale(self.startbtnBtn_, nil, function()
		self:StartGame()
	end)
end

function DormLinkGamePlayView:OnEnter()
	self.levelID = DormLinkGameData:GetCurLevelID()
	self.canInteractFlag = false

	self.maskController:SetSelectedState("false")
	self:RegisterEvents()
	self:RefreshStartView()
	self:RefreshCustomerBubble()
	self:ResetView()
end

function DormLinkGamePlayView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("ACTIVITY_LINKGAME_STOP_TIPS"),
			OkCallback = function()
				self:DisposeTimer()
				DormLinkGameData:StopGame(DormLinkGameConst.StopGameType.fail)
			end
		})
	end)
	manager.windowBar:SetGameHelpKey(DormLinkGameTools.GetGameHelpKey())
end

function DormLinkGamePlayView:OnBehind()
	manager.windowBar:HideBar()
end

function DormLinkGamePlayView:RegisterEvents()
	self:RegistEventListener(DORM_LINK_START_PLAY, function()
		self.countDowmController:SetSelectedState("start")

		self.canInteractFlag = true
	end)
	self:RegistEventListener(DORM_LINK_END_GAME, function(arg_19_0, arg_19_1)
		self:DisposeTimer()

		if self.bubbleList then
			for iter_19_0, iter_19_1 in pairs(self.bubbleList) do
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
	self:RegistEventListener(DORM_LINK_REFRESH_GAME_TIME, function(arg_20_0)
		self:RefreshLastTime(arg_20_0)
	end)
	self:RegistEventListener(LIANLIANKAN_ITEM_MATCH, function(arg_21_0)
		DormLinkGameData:EliminateMaterial(arg_21_0)
	end)
	self:RegistEventListener(DORM_LINK_REFRESH_BATTER_NUM, function()
		self:RefreshBatterNum()
		self:RefreshExtendPoint()
	end)
	self:RegistEventListener(DORM_LINK_REFRESH_CUSTOMER_BUBBLE, function(arg_23_0, arg_23_1)
		if self.bubbleList and self.bubbleList[arg_23_0] then
			self.bubbleList[arg_23_0]:RefreshBubbleInfo(arg_23_1)
		end
	end)
	self:RegistEventListener(LIANLIANKAN_ITEM_OVERFLOW, function(arg_24_0)
		DormLinkGameData:DrainMaterial(arg_24_0)
	end)
	self:RegistEventListener(LIANLIANKAN_GAME_CLEAR, function()
		DormLinkGameData:StopGame(DormLinkGameConst.StopGameType.success)
	end)
	self:RegistEventListener(DORM_LINK_REFRESH_DRAIN_MATERIAL, function(arg_26_0)
		self:RefreshExtendPoint()
		self:RefreshDrainPoint(arg_26_0)
	end)
	self:RegistEventListener(DORM_LINK_REFRESH_EXTEND_ADDITION, function()
		self:RefreshExtendAddition()
	end)
	self:RegistEventListener(DORM_LINK_REFRESH_MATERIAL_TIME, function(arg_28_0)
		self:RefreshMaterialTime(arg_28_0)
	end)
	self:RegistEventListener(DORM_LINK_REFRESH_CUSTOMER_SATIETY, function(arg_29_0)
		self.bubbleList[arg_29_0]:RefreshSatiety()
	end)
	self:RegistEventListener(DORM_LINK_REFRESH_BUFF_IGNORE_CONNECTION, function()
		self.ignoreConnectionBuff:SetData((DormLinkGameData:GetGameBuffIgnoreConnectCheck()))
		self.ignoreConnectionBuff:SetVisible(true)
	end)
end

local function var_0_2(arg_31_0)
	return nullable(ActivityCfg, ActivityLinkGameCfg[arg_31_0].activity_id, "remark")
end

function DormLinkGamePlayView:RefreshRunView()
	if self.bubbleList then
		for iter_32_0, iter_32_1 in pairs(self.bubbleList) do
			iter_32_1:SetActive(true)
			iter_32_1:RefreshTransPosition()
			iter_32_1:RefreshBubbleInfo()
			iter_32_1:RefreshSatiety()
		end
	end

	self.levelText_.text = var_0_2(self.levelID)

	self:RefreshLastTime()
	self:RefreshExtendPoint()
	self:RefreshExtendAddition()
	self:RefreshBatterNum()
	self:RefreshMaterialTime()
	self:RefreshSkillItemList(false)
end

function DormLinkGamePlayView:RefreshStartView()
	self.startCountController:SetSelectedState("true")
	self.reduceController:SetSelectedState("false")

	self.startTitleText.text = var_0_2(self.levelID)
	self.startTimeText.text = string.format(GetTips("ACTIVITY_LINKGAME_TIME"), tostring(ActivityLinkGameCfg[self.levelID].time_limit))

	local var_33_0 = DormLinkGameData:GetSceneData().difficultyLevel

	if var_33_0 == 1 then
		self.diffController:SetSelectedState("eazy")
	elseif var_33_0 == 2 then
		self.diffController:SetSelectedState("hard")
	elseif var_33_0 == 9 then
		self.diffController:SetSelectedState("SP")
	end

	self:RefreshSkillItemList(true)
end

function DormLinkGamePlayView:RefreshLastTime(arg_34_1)
	arg_34_1 = arg_34_1 or DormLinkGameData:GetSceneData().limitTime
	self.lastTimeText_.text = GetTipsF("ACTIVITY_LINKGAME_REST_TIME", arg_34_1)
end

function DormLinkGamePlayView:RefreshSkillItemList(arg_35_1)
	self.skillItemState = arg_35_1

	if ActivityLinkGameCfg[self.levelID].property_limit == 1 then
		self.listController:SetSelectedState("true")

		self.skillItemList = ActivityLinkGameGoodsCfg.all

		self.itemScroll:StartScroll(#self.skillItemList)
	else
		self.listController:SetSelectedState("false")
	end
end

function DormLinkGamePlayView:indexSkillItemList(arg_36_1, arg_36_2)
	arg_36_2:RefreshUI(self.skillItemList[arg_36_1], self.skillItemState)
	arg_36_2:UseItem(function(arg_37_0)
		if self.canInteractFlag then
			if ActivityLinkGameGoodsCfg[arg_37_0].coin_num <= DormLinkGameData:GetCurCnaUseTokenNum() then
				DormLinkGameTools:UseSkillItem(arg_37_0)
				self:ShowUseItemTips(arg_37_0)
				self.itemScroll:Refresh()
			else
				ShowTips(GetTips("ACTIVITY_LINKGAME_COIN_NOT_ENOUGH"))
			end
		end
	end)
end

function DormLinkGamePlayView:RefreshMaterialTime(arg_38_1)
	if arg_38_1 then
		self.countdownText_.text = string.format(GetTips("ACTIVITY_LINKGAME_CELL_PUSH"), arg_38_1)
	else
		arg_38_1 = DormLinkGameData:GetGameCacheInfo().generateInterval
		self.countdownText_.text = string.format(GetTips("ACTIVITY_LINKGAME_CELL_PUSH"), GameSetting.linkgame_count_down.value[1] + arg_38_1)
	end
end

function DormLinkGamePlayView:RefreshExtendPoint()
	if not self.extendNum then
		-- block empty
	end

	local var_39_1 = DormLinkGameData:GetGameCacheInfo()

	self.extendNum = var_39_1.extendPoint - var_39_1.drainPoint
	self.extendNumText_.text = var_39_1.extendPoint - var_39_1.drainPoint
end

function DormLinkGamePlayView:RefreshDrainPoint(arg_40_1)
	self.reduceController:SetSelectedState("true")
	self.extendAnimaton:Play()

	self.reduceNum.text = -1 * arg_40_1

	if not self.reduceTimer then
		self.reduceTimer = Timer.New(function()
			self.reduceController:SetSelectedState("false")
		end, GameSetting.linkgame_score_tips_time.value[1], 1)
	else
		self.reduceTimer:Reset()
	end

	self.reduceTimer:Start()
end

function DormLinkGamePlayView:RefreshExtendAddition()
	self.extendAdditionText_.text = string.format("+%d", DormLinkGameData:GetExtendAddition()) .. "%"
end

function DormLinkGamePlayView:RefreshBatterNum()
	if DormLinkGameData:GetBatterNum() > 0 then
		self.batterController:SetSelectedState("true")

		self.BatterNum.text = string.format(GetTips("ACTIVITY_LINKGAME_HIT"), DormLinkGameData:GetBatterNum())

		self.comboAnimaton:Play()
	else
		self.batterController:SetSelectedState("false")
	end
end

function DormLinkGamePlayView:RefreshCustomerBubble()
	if not self.bubbleList then
		self.bubbleList = {}

		for iter_44_0, iter_44_1 in pairs((DormLinkGameData:GetCustomerList())) do
			self.bubbleList[iter_44_0] = DormLinkGameBubbleItem.New(self.bubbleGo_, iter_44_0, self.transform_)

			self.bubbleList[iter_44_0]:RefreshBubbleInfo()
		end
	end
end

function DormLinkGamePlayView:RefreshBuffItems(arg_45_1)
	for iter_45_0, iter_45_1 in ipairs(self.buffItems) do
		if iter_45_1.visible then
			iter_45_1:Refresh()
		end
	end
end

function DormLinkGamePlayView:ShowUseItemTips(arg_46_1)
	if ActivityLinkGameGoodsCfg[arg_46_1] then
		self.useItemController:SetSelectedState("true")

		self.revokeIcon.sprite = ItemTools.getItemSprite((DormLinkGameTools:GetCurrencyID((DormLinkGameData:GetMainActivityID()))))
		self.revokeText.text = string.format(GetTips("ACTIVITY_LINKGAME_COST_TIPS"), ActivityLinkGameGoodsCfg[arg_46_1].coin_num, ActivityLinkGameGoodsCfg[arg_46_1].name)

		if self.itemShowTimer then
			self.itemShowTimer:Stop()

			self.itemShowTimer = nil
		end

		self.itemShowTimer = Timer.New(function()
			self.useItemController:SetSelectedState("false")
		end, GameSetting.linkgame_tips_time.value[1], 1)

		self.itemShowTimer:Start()
	end
end

function DormLinkGamePlayView:StartGame()
	manager.notify:Invoke(LIANLIANKAN_GAME_START)
	self.startCountController:SetSelectedState("false")
	self:RefreshRunView()
	self:StartCountDownShow()
	self:StartBuffDisplayUpdate()
end

function DormLinkGamePlayView:StartCountDownShow()
	self.showCountController:SetSelectedState("true")
	self.numAnimaton:Play()
	self.countDowmController:SetSelectedState("num")

	if not self.countTimer then
		self.countDownTime = GameSetting.linkgame_start_time.value[1]
		self.countDownText.text = self.countDownTime
		self.countTimer = Timer.New(function()
			self.countDownTime = self.countDownTime - 1

			if self.countDownTime > 0 then
				self.countDownText.text = self.countDownTime

				self.numAnimaton:Play()
			else
				self.countDowmController:SetSelectedState("start")
				self:StartCountDownTextShow()
			end
		end, 1, -1)
	else
		self.countTimer:Reset()
	end

	self.countTimer:Start()
	self.maskController:SetSelectedState("true")
end

function DormLinkGamePlayView:StopBuffDisplayUpdate()
	if self.updateBuffFrameTimer then
		self.updateBuffFrameTimer:Stop()

		self.updateBuffFrameTimer = nil
	end
end

function DormLinkGamePlayView:StartBuffDisplayUpdate()
	self:StopBuffDisplayUpdate()

	self.updateBuffFrameTimer = FrameTimer.New(function()
		self:RefreshBuffItems(Time.deltaTime)
	end, 1, -1)

	self.updateBuffFrameTimer:Start()
end

function DormLinkGamePlayView:DisposeTimer()
	if self.countTimer then
		self.countTimer:Stop()

		self.countTimer = nil
	end

	if self.textCountTimer then
		self.textCountTimer:Stop()

		self.textCountTimer = nil
	end

	if self.updateBuffFrameTimer then
		self.updateBuffFrameTimer:Stop()

		self.updateBuffFrameTimer = nil
	end
end

function DormLinkGamePlayView:ResetView()
	self.showCountController:SetSelectedState("false")
	self.batterController:SetSelectedState("false")
	self.useItemController:SetSelectedState("false")
	self.reduceController:SetSelectedState("false")
end

function DormLinkGamePlayView:StartCountDownTextShow()
	if self.countTimer then
		self.countTimer:Stop()
	end

	if not self.textCountTimer then
		self.textCountDownTime = GameSetting.linkgame_word_disappear_time.value[1] / 100
		self.textCountTimer = Timer.New(function()
			self.showCountController:SetSelectedState("false")
			self.maskController:SetSelectedState("false")
			DormLinkGameData:PlayerStartGame()
		end, self.textCountDownTime, 1)
	else
		self.textCountTimer:Reset()
	end

	self.textCountTimer:Start()
end

function DormLinkGamePlayView:OnExit()
	self:RemoveAllEventListener()
	self:DisposeTimer()
end

function DormLinkGamePlayView:Dispose()
	if self.itemScroll then
		self.itemScroll:Dispose()

		self.itemScroll = nil
	end

	if self.bubbleList then
		for iter_59_0, iter_59_1 in pairs(self.bubbleList) do
			iter_59_1:Dispose()
		end
	end

	if self.buffItems then
		for iter_59_2, iter_59_3 in ipairs(self.buffItems) do
			iter_59_3:Dispose()
		end
	end

	DormLinkGamePlayView.super.Dispose(self)
end

return DormLinkGamePlayView

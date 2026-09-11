local SpringPreheatEditLetterView = class("SpringPreheatEditLetterView", ReduxView)

function SpringPreheatEditLetterView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreePopUI1"
end

function SpringPreheatEditLetterView:UIParent()
	return manager.ui.uiMain.transform
end

function SpringPreheatEditLetterView:OnCtor()
	self.stickerNum_ = 2
	self.stickerBtn_ = {}
	self.stickerImg_ = {}
	self.stickerFrameImg_ = {}
	self.stickerInfo_ = {}
	self.stickerController_ = {}
end

function SpringPreheatEditLetterView:Init()
	self:BindCfgUI()

	for iter_4_0 = 1, self.stickerNum_ do
		self.stickerInfo_[iter_4_0] = self:CreateEmptyStickerInfo()

		local var_4_0 = self[string.format("stickerBtn_%d", iter_4_0)]

		self.stickerBtn_[iter_4_0] = var_4_0
		self.stickerController_[iter_4_0] = ControllerUtil.GetController(var_4_0.transform, "state")
		self.stickerImg_[iter_4_0] = self[string.format("stickerImg_%d", iter_4_0)]
		self.stickerFrameImg_[iter_4_0] = self[string.format("stickerFrameImg_%d", iter_4_0)]
	end

	self:AddListeners()

	self.letterList_ = LuaList.New(handler(self, self.IndexTextItem), self.letterUiListGo_, SpringPreheatLetterTextItem)
	self.playerInfo_ = self:GetLocalPlayerInfo()
	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")

	self.stateController_:SetSelectedState("writing")
end

function SpringPreheatEditLetterView:CreateEmptyStickerInfo()
	return {
		stickerID = 0,
		size = 1
	}
end

function SpringPreheatEditLetterView:GetLocalPlayerInfo()
	local var_6_0 = PlayerData:GetPlayerInfo()

	return {
		user_id = var_6_0.userID,
		nick = var_6_0.nick,
		icon = var_6_0.portrait,
		icon_frame = var_6_0.icon_frame
	}
end

function SpringPreheatEditLetterView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(handler(self, self.OnClickBackBtn))
	self:RefreshUI()
end

function SpringPreheatEditLetterView:OnExit()
	manager.windowBar:HideBar()
	AnimatorTools.Stop()
end

function SpringPreheatEditLetterView:Dispose()
	self.letterList_:Dispose()
	SpringPreheatEditLetterView.super.Dispose(self)
end

function SpringPreheatEditLetterView:AddListeners()
	for iter_10_0 = 1, self.stickerNum_ do
		if self.stickerBtn_[iter_10_0] then
			self:AddBtnListener(self.stickerBtn_[iter_10_0], nil, function()
				self:SelectSticker(iter_10_0)
			end)
		end
	end

	self:AddBtnListener(self.sendBtn_, nil, function()
		self:TrySendBlessingLetter()
	end)
	self:AddBtnListener(self.resetBtn_, nil, function()
		self:ResetLetter()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		return
	end)
	self:RegistEventListener(NEW_DAY, handler(self, self.OnNewDay))
end

function SpringPreheatEditLetterView:IndexTextItem(arg_15_1, arg_15_2)
	local var_15_0

	if self.selectingImg_ then
		var_15_0 = self.selectingImg_.sprite or nil

		local var_15_1

		if self.selectedImg_ then
			var_15_1 = self.selectedImg_.sprite or nil
		end
	end

	arg_15_2:SetData(arg_15_1, var_15_0, var_15_1)
end

function SpringPreheatEditLetterView:RefreshUI(arg_16_1)
	self.letterDateText_.text = manager.time:STimeDescS(manager.time:GetServerTime(), "!%Y/%m/%d")
	self.tipsText_.text = GetTips("SPRING_PREHEAT_TITLE_TIPS")
	self.resetText_.text = GetTips("SPRING_PREHEAT_RESET")

	self:RefreshPlayerUI()

	for iter_16_0 = 1, self.stickerNum_ do
		self:RefreshStickerUI(iter_16_0)
	end

	if not arg_16_1 then
		self.letterList_:StartScroll(#SpringPreheatData:GetPlayerLetter().option_button_list)
	end
end

function SpringPreheatEditLetterView:RefreshPlayerUI()
	self.playerNameText_.text = self.playerInfo_.nick
	self.playerIcon_.sprite = ItemTools.getItemSprite(self.playerInfo_.icon)

	self.playerIcon_:SetNativeSize()
end

function SpringPreheatEditLetterView:SelectSticker(arg_18_1)
	if self.isAniPlaying_ or self.isStaying_ then
		return
	end

	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(self.stickerInfo_) do
		if iter_18_1.stickerID ~= 0 then
			table.insert(var_18_0, iter_18_1.stickerID)
		end
	end

	JumpTools.OpenPageByJump("springPreheatLetterSelect", {
		isStickerMode = true,
		usedList = var_18_0,
		info = self.stickerInfo_[arg_18_1],
		index = arg_18_1,
		onChangeSticker = handler(self, self.OnChangeSticker)
	})
end

function SpringPreheatEditLetterView:OnChangeSticker(arg_19_1, arg_19_2, arg_19_3)
	for iter_19_0, iter_19_1 in ipairs(self.stickerInfo_) do
		if iter_19_1.stickerID == arg_19_2 then
			self.stickerInfo_[iter_19_0] = self:CreateEmptyStickerInfo()
		end
	end

	self.stickerInfo_[arg_19_1] = {
		stickerID = arg_19_2,
		size = arg_19_3
	}

	for iter_19_2 = 1, self.stickerNum_ do
		self:RefreshStickerUI(iter_19_2)
	end
end

function SpringPreheatEditLetterView:RefreshStickerUI(arg_20_1)
	local var_20_0 = self.stickerInfo_[arg_20_1]

	self.stickerController_[arg_20_1]:SetSelectedState(self.stickerInfo_[arg_20_1].stickerID > 0 and "active" or "add")

	if var_20_0.stickerID > 0 and self.stickerImg_[arg_20_1] then
		self.stickerImg_[arg_20_1].sprite = ItemTools.getItemSprite(var_20_0.stickerID, {
			size = var_20_0.size
		})
	end
end

function SpringPreheatEditLetterView:TrySendBlessingLetter()
	local var_21_0 = {}

	for iter_21_0 = 1, self.stickerNum_ do
		table.insert(var_21_0, self.stickerInfo_[iter_21_0].stickerID)
	end

	local var_21_1 = {}
	local var_21_2 = SpringPreheatData:GetPlayerLetter()

	for iter_21_1, iter_21_2 in pairs(self.letterList_:GetItemList()) do
		local var_21_3 = iter_21_2:GetLetterInfo()

		for iter_21_3 = 1, #var_21_3 do
			if SpringPreheatData:IsEnableOption(var_21_2.id, iter_21_1, iter_21_3) then
				if var_21_3[iter_21_3] == 0 then
					ShowTips("SPRING_PREHEAT_WORD_NOT_SELECT")

					return
				end

				table.insert(var_21_1, (table.indexof(SpringPreheatData:GetLetterOptionList(var_21_2.id, iter_21_1, iter_21_3), var_21_3[iter_21_3])))
			end
		end
	end

	SpringPreheatAction:SendBlessingLetter(self.playerInfo_.user_id, var_21_1, var_21_0, function()
		self:PlayEffect(handler(self, self.OnFinishSendBlessingLetter))
	end)
end

function SpringPreheatEditLetterView:PlayEffect(arg_23_1)
	self:SwitchSendingMode(true)

	self.isStaying_ = true

	Timer.New(function()
		if self.sendLetterAni_ then
			manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_preheat_sent", "")

			self.isAniPlaying_ = true

			self.sendLetterAni_:Play("PopUI1_send", -1, 0)
			self.sendLetterAni_:Update(0)
			AnimatorTools.PlayAnimationWithCallback(self.sendLetterAni_, "PopUI1_send", function()
				self.isAniPlaying_ = false

				arg_23_1()
			end)
		else
			arg_23_1()
		end

		self.isStaying_ = false
	end, GameSetting.spring_preheat_2_8_watingtime.value[1], 0):Start()
end

function SpringPreheatEditLetterView:OnFinishSendBlessingLetter()
	if self.params_.onFinishSendLetter then
		self.params_.onFinishSendLetter()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:Back()

	if GameSetting.spring_preheat_2_8_story.value[2] and not manager.story:IsStoryPlayed(GameSetting.spring_preheat_2_8_story.value[2]) then
		manager.story:StartStoryById(GameSetting.spring_preheat_2_8_story.value[2], function(arg_27_0)
			JumpTools.OpenPageByJump("/springPreheatBlank/springPreheatPray", {})
		end)

		return
	end

	JumpTools.OpenPageByJump("/springPreheatBlank/springPreheatPray", {})
end

function SpringPreheatEditLetterView:ResetLetter()
	for iter_28_0, iter_28_1 in pairs(self.letterList_:GetItemList()) do
		iter_28_1:ResetLetterInfo()
	end

	for iter_28_2 = 1, #self.stickerInfo_ do
		self.stickerInfo_[iter_28_2] = self:CreateEmptyStickerInfo()
	end

	self:RefreshUI(true)
	self.sendLetterAni_:Play("btn", -1, 0)
end

function SpringPreheatEditLetterView:SwitchSendingMode(arg_29_1)
	self.stateController_:SetSelectedState(arg_29_1 and "preview" or "writing")

	self.stickerFrameImg_[1].enabled = not arg_29_1
	self.stickerFrameImg_[2].enabled = not arg_29_1

	SetActive(self.stickerAddGo_1, not arg_29_1)
	SetActive(self.stickerAddGo_2, not arg_29_1)

	for iter_29_0, iter_29_1 in pairs(self.letterList_:GetItemList()) do
		iter_29_1:SetSendingMode(arg_29_1)
		iter_29_1:RefreshUI()
	end

	if arg_29_1 then
		manager.windowBar:HideBar()
	end
end

function SpringPreheatEditLetterView:OnNewDay()
	self:SwitchSendingMode(false)
	self:ResetLetter()
end

function SpringPreheatEditLetterView:OnClickBackBtn()
	if self.isAniPlaying_ or self.isStaying_ then
		return
	end

	JumpTools.Back()
	JumpTools.Back()
end

function SpringPreheatEditLetterView:GetActivityID()
	return self.params_.activityId
end

return SpringPreheatEditLetterView

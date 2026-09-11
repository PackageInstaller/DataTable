local HodurSelectModule = class("HodurSelectModule", ReduxView)

function HodurSelectModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddUIListener()
end

function HodurSelectModule:InitUI()
	self:BindCfgUI()

	self.eventController_ = self.mainControllerEx_:GetController("Eventcontent")
	self.bossController_ = self.mainControllerEx_:GetController("BOSS")
	self.eventItemList_ = {}

	for iter_2_0 = 1, 2 do
		self.eventItemList_[iter_2_0] = HodurSelectEventItem.New(self["eventItemGo_" .. iter_2_0])
	end

	self.bossItemList_ = {}

	for iter_2_1 = 1, 6 do
		self.bossItemList_[iter_2_1] = HodurSelectBossItem.New(self["bossItemGo_" .. iter_2_1])
	end

	self.selectEventID_ = nil
end

function HodurSelectModule:AddUIListener()
	self:AddBtnListener(self.chooseBtn_, nil, function()
		if self.type_ == HodurConst.INFO_VIEW_TYPE.STAGE then
			self:OnClickStageBtn()
		else
			self:OnClickEventBtn()
		end
	end)
end

function HodurSelectModule:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.type_ = arg_5_1
	self.cfgID_ = arg_5_2
	self.chapterID_ = arg_5_3

	if self.type_ == HodurConst.INFO_VIEW_TYPE.STAGE then
		self.selectEventID_ = nil

		self:RefreshStageUI()
	else
		self:RefreshEventUI()
	end

	self:EndChooseEvent()
end

function HodurSelectModule:RefreshStageUI()
	self.eventController_:SetSelectedState("off")
	self.bossController_:SetSelectedState("BOSS")

	if BattleHodurStageCfg[self.cfgID_] then
		self.titleText_.text = BattleHodurStageCfg[self.cfgID_].name
		self.descText_.text = BattleHodurStageCfg[self.cfgID_].tips
	end

	if HodurTools.GetStagePass(self.cfgID_, self.chapterID_) then
		SetActive(self.btnGo_, false)
	else
		SetActive(self.btnGo_, true)
	end

	self.btnText_.text = GetTips("MATRIX_PREPARE_START_CHALLENGE")
	self.bossImg_.sprite = getSpriteWithoutAtlas(HodurConst.BOSS_IMG_PATH .. ActivityHodurCfg[self.cfgID_].boss_img) or nil

	for iter_6_0 = 1, 6 do
		self.bossItemList_[iter_6_0]:SetData(ActivityHodurCfg[self.cfgID_].boss_id, iter_6_0)
	end

	self.bossScroll_.verticalNormalizedPosition = 1
end

function HodurSelectModule:RefreshEventUI()
	self.eventController_:SetSelectedState("on")
	self.bossController_:SetSelectedState("monster")

	if ActivityHodurEventCfg[self.cfgID_] then
		self.titleText_.text = ActivityHodurEventCfg[self.cfgID_].event_title
		self.descText_.text = ActivityHodurEventCfg[self.cfgID_].event_desc
	end

	local var_7_0 = HodurTools.GetEventComplete(self.cfgID_, self.chapterID_)

	for iter_7_0 = 1, 2 do
		self.eventItemList_[iter_7_0]:SetData(ActivityHodurEventCfg[self.cfgID_].event_option[iter_7_0], self.cfgID_, self.chapterID_)
		self.eventItemList_[iter_7_0]:SetClickHandler(function(arg_8_0)
			if not HodurTools.GetEventComplete(self.cfgID_, self.chapterID_) then
				self:SelectEvent(arg_8_0)
			end
		end)

		if var_7_0 then
			self.eventItemList_[iter_7_0]:SetComplete(true)
		else
			self.eventItemList_[iter_7_0]:SetComplete(false)
		end
	end

	self:SelectEvent(nil)

	self.btnText_.text = GetTips("HODUR_SELECT")

	self:RefreshEveneBtn()
	FrameTimer.New(function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.eventContentTrs_)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.eventContentTrs_)
	end, 1, 1).Start(nil)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.eventContentTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.eventContentTrs_)
end

function HodurSelectModule:RefreshEveneBtn()
	if HodurTools.GetEventComplete(self.cfgID_, self.chapterID_) or self.selectEventID_ == nil then
		SetActive(self.btnGo_, false)
	else
		SetActive(self.btnGo_, true)
	end
end

function HodurSelectModule:SelectEvent(arg_11_1)
	self.selectEventID_ = arg_11_1

	for iter_11_0 = 1, 2 do
		local var_11_0 = self.eventItemList_[iter_11_0].optionID_ == arg_11_1

		if iter_11_0 == 1 then
			LayoutRebuilder.ForceRebuildLayoutImmediate(self.eventItemGo_1.transform)
		end

		self.eventItemList_[iter_11_0]:SetSelected(var_11_0)
	end

	self:RefreshEveneBtn()
end

function HodurSelectModule:OnClickStageBtn()
	HodurTools.GoBattle(self.cfgID_, ActivityConst.ACTIVITY_HODUR_MAIN, self.chapterID_)
end

function HodurSelectModule:OnClickEventBtn()
	if self.selectEventID_ == nil then
		return
	else
		for iter_13_0 = 1, 2 do
			if iter_13_0 == 2 and self.eventItemList_[iter_13_0].optionID_ == self.selectEventID_ then
				self:StartChooseEvent()

				return
			end
		end

		HodurAction.SelectEvent(self.chapterID_, self.selectEventID_, 1)
	end
end

function HodurSelectModule:Show(arg_14_1)
	SetActive(self.gameObject_, arg_14_1)
end

function HodurSelectModule:StartChooseEvent()
	if not self.timer_ then
		self.blankTrans_.sizeDelta = Vector2(580, 194)

		self.eventItemList_[1]:Show(false)

		self.showData_ = 194
		self.timer_ = Timer.New(function()
			if self.showData_ > 0 then
				self:UpdateShowData()
			else
				self:EndChooseEvent()
				HodurAction.SelectEvent(self.chapterID_, self.selectEventID_, 2)
			end
		end, 0.033, -1)

		self.timer_:Start()
	end
end

function HodurSelectModule:UpdateShowData()
	self.showData_ = self.showData_ - 38.8

	if self.blankTrans_.sizeDelta.y > 0 then
		self.blankTrans_.sizeDelta = Vector2(580, math.max(self.blankTrans_.sizeDelta.y - 38.8, 0))

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.eventContentTrs_)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.eventContentTrs_)
	end
end

function HodurSelectModule:EndChooseEvent()
	self.blankTrans_.sizeDelta = Vector2(580, 0)
	self.showData_ = 0

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function HodurSelectModule:Dispose()
	for iter_19_0 = 1, 2 do
		if self.eventItemList_[iter_19_0] then
			self.eventItemList_[iter_19_0]:Dispose()

			self.eventItemList_[iter_19_0] = nil
		end
	end

	for iter_19_1 = 1, 6 do
		if self.bossItemList_[iter_19_1] then
			self.bossItemList_[iter_19_1]:Dispose()

			self.bossItemList_[iter_19_1] = nil
		end
	end

	HodurSelectModule.super.Dispose(self)
end

return HodurSelectModule

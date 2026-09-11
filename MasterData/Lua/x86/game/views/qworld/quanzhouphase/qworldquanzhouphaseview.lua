local QWorldQuanzhouPhaseView = class("QWorldQuanzhouPhaseView", import("game.extend.ReduxView"))
local var_0_1 = {
	6.5,
	6.2,
	4
}

function QWorldQuanzhouPhaseView:UIName()
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_Com/QuanZhou_InterludeUI"
end

function QWorldQuanzhouPhaseView:Ctor()
	self.gameObject_ = Object.Instantiate(Asset.Load(self:UIName()), manager.ui.uiMessage.transform)
	self.transform_ = self.gameObject_.transform

	self:AdaptScreen()
	self:Hide()
	self:InitUI()
end

function QWorldQuanzhouPhaseView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.timeLineList_ = {}

	for iter_3_0 = 1, 3 do
		self.timeLineList_[iter_3_0] = self["timeLine_" .. iter_3_0]
	end

	self.timeLineController_ = self.transCon_:GetController("timeLine")
end

function QWorldQuanzhouPhaseView:AddUIListener()
	self:AddBtnListener(self.btnClose_, nil, function()
		if self.canClick_ then
			QWorldQuanzhouNotify:Hide()
			QWorldQuestGraph:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_RECEIVE_EVENT, QWorldQuestConst.LISTENING_EVENT["EVENT_QUANZHOU_PHASE_CLOSE_" .. QWorldData:GetNowPhaseId() - 1])
		end
	end)
end

function QWorldQuanzhouPhaseView:SetData()
	self.nowPhase_ = QWorldData:GetNowPhaseId() - 1
	self.nowPhaseCfg_ = QuanzhouPhaseCfg[self.nowPhase_]
	self.nextPhaseCfg_ = QuanzhouPhaseCfg[self.nowPhaseCfg_.nextphase]
end

function QWorldQuanzhouPhaseView:Show()
	self.gameObject_:SetActive(true)
	self.transform_:SetAsLastSibling()
	self:RefreshUI()
	self:AddTipsTimer()
end

function QWorldQuanzhouPhaseView:RefreshUI()
	self.timeLineController_:SetSelectedState(self.nowPhase_)

	local var_8_0 = self.timeLineList_[self.nowPhase_]

	if self.nextPhaseCfg_ then
		self.titleText_.text = self.nowPhaseCfg_.name
		self.nowTitleImg_.sprite = pureGetSpriteWithoutAtlas(self.nowPhaseCfg_.icon)
		self.nextTitleImg_.sprite = pureGetSpriteWithoutAtlas(self.nextPhaseCfg_.icon)

		TimelineTools.PlayTimelineWithCallback(self.timeLineList_[self.nowPhase_], self.timeLineList_[self.nowPhase_].playableAsset, function()
			var_8_0.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.Hold
			var_8_0.time = var_8_0.duration

			var_8_0:Evaluate()

			self.timelineComplete_ = true
		end)
	else
		self.timelineComplete_ = true
	end

	self:CheckTitleAnim()
end

function QWorldQuanzhouPhaseView:AddTipsTimer()
	local var_10_0 = self.nextPhaseCfg_.show_time
	local var_10_1 = #self.nextPhaseCfg_.tips_desc

	self.tipsComplete_ = false
	self.startTimer_ = Timer.New(function()
		local var_11_0 = 1

		self.tipsTimer_ = Timer.New(function()
			if var_11_0 <= var_10_1 then
				self.tipIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/SandPlay/MiniIcon/" .. self.nextPhaseCfg_.tips_icon[var_11_0])
				self.tipsText_.text = self.nextPhaseCfg_.tips_desc[var_11_0]
				var_11_0 = var_11_0 + 1

				self.tipsAnim_:Play("UI_nd1_cx_01", -1, 0)
				self.tipsAnim_:Update(0)
			else
				self.tipsTimer_:Stop()

				self.tipsTimer_ = nil
				self.tipsComplete_ = true
			end
		end, var_10_0, -1)

		self.tipsTimer_:Start()
		self.startTimer_:Stop()

		self.startTimer_ = nil
	end, self.nextPhaseCfg_.start_time, 1)

	self.startTimer_:Start()

	self.endTimer_ = Timer.New(function()
		if self.timelineComplete_ and self.tipsComplete_ then
			AnimatorTools.PlayAnimatorWithCallback(self.lastAnim_, "UI_text_cx", function()
				self.canClick_ = true

				self.endTimer_:Stop()

				self.endTimer_ = nil
			end)
		end
	end, 0.33, -1)

	self.endTimer_:Start()
end

function QWorldQuanzhouPhaseView:CheckTitleAnim()
	if self.timer_ ~= nil then
		self.timer_:Stop()
	end

	self.timer_ = Timer.New(function()
		self:ChangeTitle()
	end, var_0_1[self.nowPhase_], 1)

	self.timer_:Start()
end

function QWorldQuanzhouPhaseView:ChangeTitle()
	if self.nextPhaseCfg_ then
		self.titleText_.text = self.nextPhaseCfg_.name
	end
end

function QWorldQuanzhouPhaseView:Hide()
	if self.gameObject_ then
		self.canClick_ = false
		self.timelineComplete_ = false
		self.tipsComplete_ = false

		SetActive(self.gameObject_, false)

		if self.timer_ ~= nil then
			self.timer_:Stop()

			self.timer_ = nil
		end

		if self.startTimer_ ~= nil then
			self.startTimer_:Stop()

			self.startTimer_ = nil
		end

		if self.tipsTimer_ ~= nil then
			self.tipsTimer_:Stop()

			self.tipsTimer_ = nil
		end

		if self.endTimer_ ~= nil then
			self.endTimer_:Stop()

			self.endTimer_ = nil
		end
	end
end

function QWorldQuanzhouPhaseView:Dispose()
	self:Hide()
	GameObject.Destroy(self.gameObject_)
	Asset.Unload(self:UIName())
	QWorldQuanzhouPhaseView.super.Dispose(self)
end

return QWorldQuanzhouPhaseView

local RecallSystemRecallView = class("RecallSystemRecallView", (import("game.views.recall.pages.RecallPageBase")))

function RecallSystemRecallView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RecallSystemRecallView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.indexItem), self.listGo_, RecallSystemRecallItem)
	self.sendCDStateController_ = self.mainControllerEx_:GetController("shareCD")
end

function RecallSystemRecallView:indexItem(arg_3_1, arg_3_2)
	arg_3_2:SetData(ActivityRecallData:GetDataByPara("recallReward")[arg_3_1], arg_3_1)
end

function RecallSystemRecallView:AddUIListener()
	self:AddBtnListener(self.CopyBtn_, nil, function()
		ActivityRecallAction.RequireRecallShareCode((ActivityRecallData:GetDataByPara("recallActivityID")))
		ShowTips("COPY_SUCCESS")
	end)
	self:AddBtnListener(self.recallInfoBtn_, nil, function()
		ActivityRecallAction.RequireRecallInfo((ActivityRecallData:GetDataByPara("recallActivityID")))
	end)
	self:AddBtnListener(self.shareBtn_, nil, function()
		local var_7_0 = ActivityRecallData:GetDataByPara("recallActivityID")

		if not ActivityData:GetActivityIsOpen(var_7_0) then
			ShowTips("TIME_OVER")

			return
		end

		if manager.time:GetServerTime() - ActivityRecallData:GetLastShareTimestamp() < GameSetting.recall_share_colddown.value[1] then
			ShowTips("SEND_MESSAGE_FREQUENTLY")

			return
		end

		if ChatData:IsMuted() then
			JumpTools.OpenPageByJump("chatMuted")

			return
		end

		ActivityRecallAction.RequireRecallShareCode(var_7_0)
		ActivityRecallAction.RecallShare(ActivityRecallData:GetDataByPara("recallCode"), function(arg_8_0)
			if isSuccess(arg_8_0.result) then
				ActivityRecallData:SetLastShareTimestamp()
				ChatAction.RequireRecallInfo()
				self:UpdateSendTimeCD()
				ShowTips("RECALLED_SHARE")
			else
				ShowTips(arg_8_0.result)
			end
		end)
	end)
end

function RecallSystemRecallView:OnRecallRewardUpdate()
	self:UpdateView()
end

function RecallSystemRecallView:OnTop()
	return
end

function RecallSystemRecallView:UpdateView()
	self.list_:StartScroll(#ActivityRecallData:GetDataByPara("recallReward"))

	self.recallCodeTxt_.text = ActivityRecallData:GetDataByPara("recallCode")
	self.activityTimeTxt_.text = ActivityRecallData:GetDataByPara("recallTime")
end

function RecallSystemRecallView:OnEnter()
	self:UpdateView()

	self.sendTipsCD_ = self.sendTipsCD_ or 0

	self:UpdateSendTimeCD()

	if not self.sendTipsTimer_ then
		self.sendTipsTimer_ = Timer.New(function()
			if self.sendTipsCD_ > 0 then
				self.sendTipsText_.text = self.sendTipsCD_ .. GetTips("SECOND")
				self.sendTipsCD_ = self.sendTipsCD_ - 1
			else
				self.sendCDStateController_:SetSelectedState("false")
			end
		end, 1, -1)

		self.sendTipsTimer_:Start()
	end
end

function RecallSystemRecallView:UpdateSendTimeCD()
	local var_14_0 = ActivityRecallData:GetLastShareTimestamp()

	if manager.time:GetServerTime() - var_14_0 < GameSetting.recall_share_colddown.value[1] then
		self.sendTipsCD_ = GameSetting.recall_share_colddown.value[1] - manager.time:GetServerTime() + var_14_0
		self.sendTipsText_.text = self.sendTipsCD_ .. GetTips("SECOND")

		self.sendCDStateController_:SetSelectedState("true")
	else
		self.sendTipsCD_ = 0

		self.sendCDStateController_:SetSelectedState("false")
	end
end

function RecallSystemRecallView:OnExit()
	if self.sendTipsTimer_ then
		self.sendTipsTimer_:Stop()

		self.sendTipsTimer_ = nil
	end
end

function RecallSystemRecallView:Hide()
	RecallSystemRecallView.super.Hide(self)
end

function RecallSystemRecallView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	RecallSystemRecallView.super.Dispose(self)
end

return RecallSystemRecallView

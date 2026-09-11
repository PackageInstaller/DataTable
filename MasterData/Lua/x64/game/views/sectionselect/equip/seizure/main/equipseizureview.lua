local EquipSeizureView = class("EquipSeizureView", ReduxView)

function EquipSeizureView:UIName()
	return "Widget/System/Equip_Seizure/EquipSeizureUI"
end

function EquipSeizureView:UIParent()
	return manager.ui.uiMain.transform
end

function EquipSeizureView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.affixItemList_ = {}
	self.updateHandler_ = handler(self, self.RefreshUI)
end

function EquipSeizureView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("EQUIP_SEIZURE_INFO")
	manager.redPoint:bindUIandKey(self.pointBtn_.transform, RedPointConst.EQUIP_SEIZURE_REWARD)
	manager.notify:RegistListener(EQUIP_SEIZURE_UPDATE, self.updateHandler_)
	self:RefreshUI()
	EquipSeizureAction.OpenWindow()
end

function EquipSeizureView:OnExit()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.notify:RemoveListener(EQUIP_SEIZURE_UPDATE, self.updateHandler_)
	manager.redPoint:unbindUIandKey(self.pointBtn_.transform, RedPointConst.EQUIP_SEIZURE_REWARD)
	self:StopTimer()
	self:StopRefreshTimer()
end

function EquipSeizureView:Dispose()
	EquipSeizureView.super.Dispose(self)

	self.updateHandler_ = nil

	for iter_6_0 = #self.affixItemList_, 1, -1 do
		self.affixItemList_[iter_6_0]:Dispose()

		self.affixItemList_[iter_6_0] = nil
	end

	self.affixItemList_ = nil
end

function EquipSeizureView:AddListeners()
	self:AddBtnListener(self.pointBtn_, nil, function()
		JumpTools.OpenPageByJump("equipSeizureReward", {})
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		self:Go("/sectionSelectHero", {
			section = EquipSeizureData:GetStageID(),
			sectionType = BattleConst.STAGE_TYPE_NEW.EQUIP_SEIZURE
		})
	end)
end

function EquipSeizureView:RefreshUI()
	self.pointText_.text = EquipSeizureData:GetTodayMaxScore()
	self.rateText_.text = string.format("x%s", EquipSeizureData:GetChallengeRate())

	local var_10_0 = EquipSeizureData:GetAffixIDList()

	for iter_10_0 = #self.affixItemList_, #var_10_0 + 1, -1 do
		self.affixItemList_[iter_10_0]:Dispose()

		self.affixItemList_[iter_10_0] = nil
	end

	for iter_10_1 = 1, #var_10_0 do
		self.affixItemList_[iter_10_1] = self.affixItemList_[iter_10_1] or EquipSeizureAffixItem.New(self.affixItem_, self.affixParent_)

		self.affixItemList_[iter_10_1]:SetData(var_10_0[iter_10_1])
	end

	self:AddTimer()
	self:AddRefreshTimer()
	self:CheckMail()
end

function EquipSeizureView:CheckMail()
	if PlayerData:GetUnclaimed(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.EQUIP_SEIZURE) ~= nil then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("UNCLAIMED_BONUS_MAIL_TIP"),
			OkCallback = function()
				PlayerAction.ReadUnclaimedMessage(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.EQUIP_SEIZURE)
			end
		})
	end
end

function EquipSeizureView:AddTimer()
	self:StopTimer()

	self.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr2(EquipSeizureData:GetAffixRefreshTimestamp(), nil, true))
	self.timer_ = Timer.New(function()
		self.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr2(EquipSeizureData:GetAffixRefreshTimestamp(), nil, true))
	end, 1, -1)

	self.timer_:Start()
end

function EquipSeizureView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function EquipSeizureView:AddRefreshTimer()
	self:StopRefreshTimer()

	self.refreshText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr2(EquipSeizureData:NextRefreshTimestamp(), nil, true))
	self.refreshTimer_ = Timer.New(function()
		self.refreshText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr2(EquipSeizureData:NextRefreshTimestamp(), nil, true))
	end, 1, -1)

	self.refreshTimer_:Start()
end

function EquipSeizureView:StopRefreshTimer()
	if self.refreshTimer_ then
		self.refreshTimer_:Stop()

		self.refreshTimer_ = nil
	end
end

return EquipSeizureView

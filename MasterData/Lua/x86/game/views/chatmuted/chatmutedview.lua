local ChatMutedView = class("ChatMutedView", ReduxView)

function ChatMutedView:UIName()
	return "Widget/Common/Pop/LineReportTipsUI"
end

function ChatMutedView:UIParent()
	return manager.ui.uiPop.transform
end

function ChatMutedView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function ChatMutedView:OnEnter()
	local var_4_0 = ChatData:GetMutedData()

	self.textContent_.text = var_4_0.i18nInfo[SettingData:GetCurrentLanguage()] or var_4_0.mutedContent
	self.textTime_.text = GetTips("MUTE_TIME_TEXT") .. manager.time:DescCTime(var_4_0.mutedTimestamp, (GetTips("MUTE_TIME_FORMAT")))
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= var_4_0.mutedTimestamp then
			self:Back()

			return
		end
	end, 1, -1)

	self.timer_:Start()
	ChatData:SetShowMutedTips(true)
end

function ChatMutedView:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ChatMutedView:Dispose()
	ChatMutedView.super.Dispose(self)
end

function ChatMutedView:AddListeners()
	self:AddBtnListener(self.buttonClose_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.buttonSure_, nil, function()
		self:Back()
	end)
end

return ChatMutedView

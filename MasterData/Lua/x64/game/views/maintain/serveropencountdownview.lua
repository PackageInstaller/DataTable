local ServerOpenCountdownView = class("ServerOpenCountdownView", ReduxView)

function ServerOpenCountdownView:UIName()
	return "UI/PopUp/ServerUI"
end

function ServerOpenCountdownView:UIParent()
	return manager.ui.uiMain.transform
end

function ServerOpenCountdownView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ServerOpenCountdownView:InitUI()
	self:BindCfgUI()
end

function ServerOpenCountdownView:AddUIListener()
	self:AddBtnListener(self.cancelBtn_, nil, function()
		OperationAction.OpenOperationUrl("FORUM_URL", {
			gameAppId = _G.ChannelLoginInfo.channelAppId,
			token = _G.ChannelLoginInfo.channelToken
		})
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 8,
			direction_channel = 3
		})
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		OperationAction.OpenNormalUrl("https://open.ys4fun.com/web-api/pass/linkrouter/qqun")
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function ServerOpenCountdownView:OnEnter()
	self.now_ = self.params_.now
	self.currentServerTime_ = manager.time:GetServerTime()
	self.passedSeconds_ = 0
	self.timer_ = self.timer_ or Timer.New(function()
		self:UpdateTime()
	end, 0.2, -1)

	self.timer_:Start()
	self:UpdateTime()

	if tostring(_G.CHANNEL_MASTER_ID) == "1" or GameToSDK.PLATFORM_ID == 1 then
		SetActive(self.okBtn_.gameObject, true)
		SetActive(self.cancelBtn_.gameObject, true)
	else
		SetActive(self.okBtn_.gameObject, false)
		SetActive(self.cancelBtn_.gameObject, false)
	end
end

function ServerOpenCountdownView:UpdateTime()
	self.passedSeconds_ = manager.time:GetServerTime() - self.currentServerTime_
	self.contentText_.text = self.params_.content

	local var_11_1 = ""
	local var_11_2 = math.floor((self.params_.countdown - (self.params_.now + self.passedSeconds_)) / 86400)
	local var_11_3 = math.floor((self.params_.countdown - (self.params_.now + self.passedSeconds_)) / 3600) - var_11_2 * 24
	local var_11_4 = math.floor((self.params_.countdown - (self.params_.now + self.passedSeconds_)) / 60) - var_11_2 * 24 * 60 - var_11_3 * 60

	if self.params_.countdown - (self.params_.now + self.passedSeconds_) >= 86400 then
		var_11_1 = TipsCfg[TipsCfg.get_id_list_by_define.SERVER_OPEN_COUNTDOWN_1].desc
		var_11_1 = string.format(TipsCfg[TipsCfg.get_id_list_by_define.SERVER_OPEN_COUNTDOWN_1].desc, var_11_2, var_11_3, var_11_4)
	elseif self.params_.countdown - (self.params_.now + self.passedSeconds_) >= 3600 then
		var_11_1 = TipsCfg[TipsCfg.get_id_list_by_define.SERVER_OPEN_COUNTDOWN_2].desc
		var_11_1 = string.format(TipsCfg[TipsCfg.get_id_list_by_define.SERVER_OPEN_COUNTDOWN_2].desc, var_11_3, var_11_4)
	elseif self.params_.countdown - (self.params_.now + self.passedSeconds_) >= 600 then
		var_11_1 = TipsCfg[TipsCfg.get_id_list_by_define.SERVER_OPEN_COUNTDOWN_3].desc
		var_11_1 = string.format(TipsCfg[TipsCfg.get_id_list_by_define.SERVER_OPEN_COUNTDOWN_3].desc, var_11_4)
	elseif self.params_.countdown - (self.params_.now + self.passedSeconds_) > 0 then
		var_11_1 = TipsCfg[TipsCfg.get_id_list_by_define.SERVER_OPEN_COUNTDOWN_4].desc
	else
		self:Back()
	end

	self.countdownText_.text = var_11_1
end

function ServerOpenCountdownView:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ServerOpenCountdownView:Dispose()
	ServerOpenCountdownView.super.Dispose(self)
end

return ServerOpenCountdownView

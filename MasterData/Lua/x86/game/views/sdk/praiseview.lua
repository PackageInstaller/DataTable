local FollowGiftView = class("FollowGiftView", ReduxView)

function FollowGiftView:UIName()
	return "UI/PraiseUI/PraiseUI"
end

function FollowGiftView:UIParent()
	return manager.ui.uiPop.transform
end

function FollowGiftView:Init()
	self:InitUI()
	self:AddUIListener()
end

function FollowGiftView:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.catController = ControllerUtil.GetController(self.m_cat, "state")
end

function FollowGiftView:AddUIListener()
	self:AddBtnListener(self.m_encourage, nil, function()
		if self.backTimer then
			return
		end

		self:OnEncourage()
		self:Back()

		local var_6_0 = _G.deviceInfo and tostring(_G.deviceInfo.subId) or nil

		SDKTools.SendMessageToSDK("comment", {
			comment = 1,
			sub_id = var_6_0,
			comment_source = SurveyData:GetSourceId()
		})
	end)
	self:AddBtnListener(self.m_gossiping, nil, function()
		if self.backTimer then
			return
		end

		self.stateController:SetSelectedIndex(1)
		self.catController:SetSelectedIndex(1)

		local var_7_0 = _G.deviceInfo and tostring(_G.deviceInfo.subId) or nil

		SDKTools.SendMessageToSDK("comment", {
			comment = 2,
			sub_id = var_7_0,
			comment_source = SurveyData:GetSourceId()
		})
	end)
	self:AddBtnListener(self.m_nextTime, nil, function()
		if self.backTimer then
			return
		end

		self.backTimer = Timer.New(function()
			self.backTimer = nil

			self:Back()
		end, 1, 1)

		self.backTimer:Start()
		self.catController:SetSelectedIndex(2)

		local var_8_0 = _G.deviceInfo and tostring(_G.deviceInfo.subId) or nil

		SDKTools.SendMessageToSDK("comment", {
			comment = 3,
			sub_id = var_8_0,
			comment_source = SurveyData:GetSourceId()
		})
		SurveyAction.Praise(1)
	end)
	self:AddBtnListener(self.m_consider, nil, function()
		if self.backTimer then
			return
		end

		self.stateController:SetSelectedIndex(0)
		self.catController:SetSelectedIndex(3)
	end)
	self:AddBtnListener(self.m_gossipingSure, nil, function()
		if self.backTimer then
			return
		end

		self:OnGossiping()
		self:Back()
	end)
end

function FollowGiftView:OnEncourage()
	GameToSDK.SendMessage("{\"messageType\" : \"MarketComments\"}")
	SurveyAction.Praise(2)
end

function FollowGiftView:OnGossiping()
	if _G.CHANNEL_MASTER_ID == 0 then
		OperationAction.OpenOperationUrl("OFFICIAL_SUGGEST_URL", {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId,
			gameAppId = _G.ChannelLoginInfo.channelAppId,
			token = _G.ChannelLoginInfo.channelToken
		})
	elseif _G.CHANNEL_MASTER_ID == 1 then
		OperationAction.OpenOperationUrl("OFFICIAL_SUGGEST_URL", {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId,
			gameAppId = _G.ChannelLoginInfo.channelAppId,
			token = _G.ChannelLoginInfo.channelToken
		})
	else
		OperationAction.OpenOperationUrl("CHANNEL_SUGGEST_URL")
	end

	SurveyAction.Praise(3)
end

function FollowGiftView:OnEnter()
	self.stateController:SetSelectedIndex(0)
	self.catController:SetSelectedIndex(0)
	SurveyData:SetPraise(false)
	SetActive(self.m_gossiping.gameObject, not SDKTools.GetIsOverSea())
end

function FollowGiftView:OnExit()
	if self.backTimer then
		self.backTimer:Stop()

		self.backTimer = nil
	end
end

return FollowGiftView

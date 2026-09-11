local OperationView = class("OperationView", ReduxView)

function OperationView:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function OperationView:Init()
	self:InitUI()
	self:AddUIListener()
end

function OperationView:InitUI()
	self:BindCfgUI()
end

function OperationView:AddUIListener()
	self:AddBtnListenerScale(self.btn_uccnBtn_, nil, function()
		OperationAction.OpenOperationUrl("OFFICIAL_URL")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 1,
			direction_channel = 4
		})
	end)
	self:AddBtnListenerScale(self.btn_psqBtn_, nil, function()
		SurveyAction.SetSurveyRedPointData()
		JumpTools.OpenPageByJump("survey", {
			type = OperationConst.SURVEY_TYPE.NORMAL
		})
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 4,
			direction_channel = 4
		})
	end)
	self:AddBtnListenerScale(self.btn_mycenterBtn_, nil, function()
		NeedGameUserInfo()
		GameToSDK.GoUserCenter()
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 2,
			direction_channel = 4
		})
	end)
	self:AddBtnListenerScale(self.btn_attentionBtn_, nil, function()
		self.handler_:SetFollowGiftRedPointData()
		self:Go("/followGift")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 5,
			direction_channel = 4
		})
	end)
	self:AddBtnListenerScale(self.btn_suggestBtn_, nil, function()
		NeedGameUserInfo()
		SendMessageToSDK("{\"messageType\" : \"StartCustomerService\"}")
		manager.redPoint:setTip(RedPointConst.CUSTOMER_SERVICE_UNREAD, 0)
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 3,
			direction_channel = 4
		})
	end)
	self:AddBtnListenerScale(self.btn_cdkBtn_, nil, function()
		JumpTools.OpenPageByJump("GiftPopUp")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 7,
			direction_channel = 4
		})
	end)
	self:AddBtnListenerScale(self.btn_forumBtn_, nil, function()
		OperationAction.OpenOperationUrl("FORUM_URL", {
			gameAppId = _G.ChannelLoginInfo.channelAppId,
			token = _G.ChannelLoginInfo.channelToken
		})
		RedPointAction.HandleRedPoint(RED_POINT_ID.FORUM)
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 8,
			direction_channel = 4
		})
		manager.redPoint:setTip(RedPointConst.FORUM, 0)
		manager.redPoint:setTip(RedPointConst.FORUM_UNREAD, 0)
	end)
	self:AddBtnListenerScale(self.btn_queryBtn_, nil, function()
		OperationAction.OpenOperationUrl("INQUERY_URL", {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId
		})
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 6,
			direction_channel = 4
		})
	end)
	self:AddBtnListenerScale(self.btn_guideBtn_, nil, function()
		OperationAction.OpenOperationUrl("GUIDE_URL", {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId
		})
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 9,
			direction_channel = 4
		})
	end)
	self:AddBtnListenerScale(self.btn_activityBtn_, nil, function()
		OperationAction.OpenOperationUrl("ACTIVITY_URL", {
			userID = PlayerData:GetPlayerInfo().userID,
			signuserID = PlayerData:GetPlayerInfo().signUserId
		})
		RedPointAction.HandleRedPoint(RED_POINT_ID.ACTIVITY)
		manager.redPoint:setTip(RedPointConst.OPERATION_ACTIVITY, 0)
	end)
	self:AddBtnListenerScale(self.btn_shopBtn_, nil, function()
		OperationAction.OpenOperationUrl("SHOPPING_URL", {})
		RedPointAction.HandleRedPoint(RED_POINT_ID.SHOP_TAOBAO)
		manager.redPoint:setTip(RedPointConst.SHOP_TAOBAO, 0)
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 10,
			direction_channel = 4
		})
	end)
end

function OperationView:OnEnter()
	self:RefreshUI()
	self:UpdataOperationViewRedPoint()
	manager.redPoint:bindUIandKey(self.btn_suggestGo_.transform, RedPointConst.CUSTOMER_SERVICE_UNREAD)
end

function OperationView:UpdataOperationViewRedPoint()
	local var_17_0 = OperationData:GetOperationOpenList()

	if RedPointData:GetRedPointOpen(RED_POINT_ID.ACTIVITY) and table.keyof(var_17_0, OperationConst.ACTIVITY) ~= nil then
		manager.redPoint:setTip(RedPointConst.OPERATION_ACTIVITY, 1)
	else
		manager.redPoint:setTip(RedPointConst.OPERATION_ACTIVITY, 0)
	end

	if RedPointData:GetRedPointOpen(RED_POINT_ID.FORUM) and table.keyof(var_17_0, OperationConst.FORUM) ~= nil then
		manager.redPoint:setTip(RedPointConst.FORUM, 1)
	else
		manager.redPoint:setTip(RedPointConst.FORUM, 0)
	end

	if RedPointData:GetRedPointOpen(RED_POINT_ID.SHOP_TAOBAO) and table.keyof(var_17_0, OperationConst.SHOP_TAOBAO) ~= nil then
		manager.redPoint:setTip(RedPointConst.SHOP_TAOBAO, 1)
	else
		manager.redPoint:setTip(RedPointConst.SHOP_TAOBAO, 0)
	end
end

function OperationView:OnExit()
	manager.redPoint:unbindUIandKey(self.btn_suggestGo_.transform, RedPointConst.CUSTOMER_SERVICE_UNREAD)
end

function OperationView:RefreshUI()
	local var_19_0 = OperationData:GetOperationOpenList()

	SetActive(self.btn_uccnGo_, table.keyof(var_19_0, OperationConst.OFFICIAL_WEBSITE) ~= nil)
	SetActive(self.btn_psqGo_, table.keyof(var_19_0, OperationConst.QUESTIONNAIRE) ~= nil)
	SetActive(self.btn_mycenterGo_, table.keyof(var_19_0, OperationConst.USER_CENTER) ~= nil)
	SetActive(self.btn_attentionGo_, table.keyof(var_19_0, OperationConst.ATTENTION) ~= nil)
	SetActive(self.btn_suggestGo_, table.keyof(var_19_0, OperationConst.SUGGEST) ~= nil)
	SetActive(self.btn_cdkGo_, table.keyof(var_19_0, OperationConst.CD_KEY) ~= nil)
	SetActive(self.btn_forumGo_, table.keyof(var_19_0, OperationConst.FORUM) ~= nil)
	SetActive(self.btn_queryGo_, table.keyof(var_19_0, OperationConst.INQUERY) ~= nil)
	SetActive(self.btn_guideGo_, table.keyof(var_19_0, OperationConst.GUIDE) ~= nil)
	SetActive(self.btn_activityGo_, table.keyof(var_19_0, OperationConst.ACTIVITY) ~= nil)
	SetActive(self.btn_shopGo_, table.keyof(var_19_0, OperationConst.SHOP_TAOBAO) ~= nil)
end

function OperationView:Dispose()
	self:RemoveAllListeners()
	OperationView.super.Dispose(self)
end

return OperationView

local var_0_0 = class("OperationView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListenerScale(arg_4_0.btn_uccnBtn_, nil, function()
		OperationAction.OpenOperationUrl("OFFICIAL_URL")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 1,
			direction_channel = 4
		})
	end)
	arg_4_0:AddBtnListenerScale(arg_4_0.btn_psqBtn_, nil, function()
		SurveyAction.SetSurveyRedPointData()
		JumpTools.OpenPageByJump("survey", {
			type = OperationConst.SURVEY_TYPE.NORMAL
		})
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 4,
			direction_channel = 4
		})
	end)
	arg_4_0:AddBtnListenerScale(arg_4_0.btn_mycenterBtn_, nil, function()
		NeedGameUserInfo()
		GameToSDK.GoUserCenter()
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 2,
			direction_channel = 4
		})
	end)
	arg_4_0:AddBtnListenerScale(arg_4_0.btn_attentionBtn_, nil, function()
		arg_4_0.handler_:SetFollowGiftRedPointData()
		arg_4_0:Go("/followGift")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 5,
			direction_channel = 4
		})
	end)
	arg_4_0:AddBtnListenerScale(arg_4_0.btn_suggestBtn_, nil, function()
		NeedGameUserInfo()
		SendMessageToSDK("{\"messageType\" : \"StartCustomerService\"}")
		manager.redPoint:setTip(RedPointConst.CUSTOMER_SERVICE_UNREAD, 0)
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 3,
			direction_channel = 4
		})
	end)
	arg_4_0:AddBtnListenerScale(arg_4_0.btn_cdkBtn_, nil, function()
		JumpTools.OpenPageByJump("GiftPopUp")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 7,
			direction_channel = 4
		})
	end)
	arg_4_0:AddBtnListenerScale(arg_4_0.btn_forumBtn_, nil, function()
		local var_11_0 = {
			gameAppId = _G.ChannelLoginInfo.channelAppId,
			token = _G.ChannelLoginInfo.channelToken
		}

		OperationAction.OpenOperationUrl("FORUM_URL", var_11_0)
		RedPointAction.HandleRedPoint(RED_POINT_ID.FORUM)
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 8,
			direction_channel = 4
		})
		manager.redPoint:setTip(RedPointConst.FORUM, 0)
		manager.redPoint:setTip(RedPointConst.FORUM_UNREAD, 0)
	end)
	arg_4_0:AddBtnListenerScale(arg_4_0.btn_queryBtn_, nil, function()
		local var_12_0 = {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId
		}

		OperationAction.OpenOperationUrl("INQUERY_URL", var_12_0)
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 6,
			direction_channel = 4
		})
	end)
	arg_4_0:AddBtnListenerScale(arg_4_0.btn_guideBtn_, nil, function()
		local var_13_0 = {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId
		}

		OperationAction.OpenOperationUrl("GUIDE_URL", var_13_0)
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 9,
			direction_channel = 4
		})
	end)
	arg_4_0:AddBtnListenerScale(arg_4_0.btn_activityBtn_, nil, function()
		local var_14_0 = {
			userID = PlayerData:GetPlayerInfo().userID,
			signuserID = PlayerData:GetPlayerInfo().signUserId
		}

		OperationAction.OpenOperationUrl("ACTIVITY_URL", var_14_0)
		RedPointAction.HandleRedPoint(RED_POINT_ID.ACTIVITY)
		manager.redPoint:setTip(RedPointConst.OPERATION_ACTIVITY, 0)
	end)
	arg_4_0:AddBtnListenerScale(arg_4_0.btn_shopBtn_, nil, function()
		local var_15_0 = {}

		OperationAction.OpenOperationUrl("SHOPPING_URL", var_15_0)
		RedPointAction.HandleRedPoint(RED_POINT_ID.SHOP_TAOBAO)
		manager.redPoint:setTip(RedPointConst.SHOP_TAOBAO, 0)
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 10,
			direction_channel = 4
		})
	end)
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0:RefreshUI()
	arg_16_0:UpdataOperationViewRedPoint()
	manager.redPoint:bindUIandKey(arg_16_0.btn_suggestGo_.transform, RedPointConst.CUSTOMER_SERVICE_UNREAD)
end

function var_0_0.UpdataOperationViewRedPoint(arg_17_0)
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

function var_0_0.OnExit(arg_18_0)
	manager.redPoint:unbindUIandKey(arg_18_0.btn_suggestGo_.transform, RedPointConst.CUSTOMER_SERVICE_UNREAD)
end

function var_0_0.RefreshUI(arg_19_0)
	local var_19_0 = OperationData:GetOperationOpenList()

	SetActive(arg_19_0.btn_uccnGo_, table.keyof(var_19_0, OperationConst.OFFICIAL_WEBSITE) ~= nil)
	SetActive(arg_19_0.btn_psqGo_, table.keyof(var_19_0, OperationConst.QUESTIONNAIRE) ~= nil)
	SetActive(arg_19_0.btn_mycenterGo_, table.keyof(var_19_0, OperationConst.USER_CENTER) ~= nil)
	SetActive(arg_19_0.btn_attentionGo_, table.keyof(var_19_0, OperationConst.ATTENTION) ~= nil)
	SetActive(arg_19_0.btn_suggestGo_, table.keyof(var_19_0, OperationConst.SUGGEST) ~= nil)
	SetActive(arg_19_0.btn_cdkGo_, table.keyof(var_19_0, OperationConst.CD_KEY) ~= nil)
	SetActive(arg_19_0.btn_forumGo_, table.keyof(var_19_0, OperationConst.FORUM) ~= nil)
	SetActive(arg_19_0.btn_queryGo_, table.keyof(var_19_0, OperationConst.INQUERY) ~= nil)
	SetActive(arg_19_0.btn_guideGo_, table.keyof(var_19_0, OperationConst.GUIDE) ~= nil)
	SetActive(arg_19_0.btn_activityGo_, table.keyof(var_19_0, OperationConst.ACTIVITY) ~= nil)
	SetActive(arg_19_0.btn_shopGo_, table.keyof(var_19_0, OperationConst.SHOP_TAOBAO) ~= nil)
end

function var_0_0.Dispose(arg_20_0)
	arg_20_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0

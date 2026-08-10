local var_0_0 = class("FollowGiftView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/PraiseUI/PraiseUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stateController = ControllerUtil.GetController(arg_4_0.transform_, "state")
	arg_4_0.catController = ControllerUtil.GetController(arg_4_0.m_cat, "state")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_encourage, nil, function()
		if arg_5_0.backTimer then
			return
		end

		arg_5_0:OnEncourage()
		arg_5_0:Back()

		local var_6_0 = _G.deviceInfo and tostring(_G.deviceInfo.subId) or nil

		SDKTools.SendMessageToSDK("comment", {
			comment = 1,
			sub_id = var_6_0,
			comment_source = SurveyData:GetSourceId()
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_gossiping, nil, function()
		if arg_5_0.backTimer then
			return
		end

		arg_5_0.stateController:SetSelectedIndex(1)
		arg_5_0.catController:SetSelectedIndex(1)

		local var_7_0 = _G.deviceInfo and tostring(_G.deviceInfo.subId) or nil

		SDKTools.SendMessageToSDK("comment", {
			comment = 2,
			sub_id = var_7_0,
			comment_source = SurveyData:GetSourceId()
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_nextTime, nil, function()
		if arg_5_0.backTimer then
			return
		end

		arg_5_0.backTimer = Timer.New(function()
			arg_5_0.backTimer = nil

			arg_5_0:Back()
		end, 1, 1)

		arg_5_0.backTimer:Start()
		arg_5_0.catController:SetSelectedIndex(2)

		local var_8_0 = _G.deviceInfo and tostring(_G.deviceInfo.subId) or nil

		SDKTools.SendMessageToSDK("comment", {
			comment = 3,
			sub_id = var_8_0,
			comment_source = SurveyData:GetSourceId()
		})
		SurveyAction.Praise(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_consider, nil, function()
		if arg_5_0.backTimer then
			return
		end

		arg_5_0.stateController:SetSelectedIndex(0)
		arg_5_0.catController:SetSelectedIndex(3)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_gossipingSure, nil, function()
		if arg_5_0.backTimer then
			return
		end

		arg_5_0:OnGossiping()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEncourage(arg_12_0)
	GameToSDK.SendMessage("{\"messageType\" : \"MarketComments\"}")
	SurveyAction.Praise(2)
end

function var_0_0.OnGossiping(arg_13_0)
	if _G.CHANNEL_MASTER_ID == 0 then
		local var_13_0 = {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId,
			gameAppId = _G.ChannelLoginInfo.channelAppId,
			token = _G.ChannelLoginInfo.channelToken
		}

		OperationAction.OpenOperationUrl("OFFICIAL_SUGGEST_URL", var_13_0)
	elseif _G.CHANNEL_MASTER_ID == 1 then
		local var_13_1 = {
			userId = PlayerData:GetPlayerInfo().userID,
			signUserId = PlayerData:GetPlayerInfo().signUserId,
			gameAppId = _G.ChannelLoginInfo.channelAppId,
			token = _G.ChannelLoginInfo.channelToken
		}

		OperationAction.OpenOperationUrl("OFFICIAL_SUGGEST_URL", var_13_1)
	else
		OperationAction.OpenOperationUrl("CHANNEL_SUGGEST_URL")
	end

	SurveyAction.Praise(3)
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.stateController:SetSelectedIndex(0)
	arg_14_0.catController:SetSelectedIndex(0)
	SurveyData:SetPraise(false)
	SetActive(arg_14_0.m_gossiping.gameObject, not SDKTools.GetIsOverSea())
end

function var_0_0.OnExit(arg_15_0)
	if arg_15_0.backTimer then
		arg_15_0.backTimer:Stop()

		arg_15_0.backTimer = nil
	end
end

return var_0_0

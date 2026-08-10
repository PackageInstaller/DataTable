local var_0_0 = class("FollowGiftView", ReduxView)
local var_0_1 = ""
local var_0_2 = ""
local var_0_3 = ""
local var_0_4 = ""

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Medium/WelfareUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.weChatList_ = LuaList.New(handler(arg_4_0, arg_4_0.RefreshWeChatReward), arg_4_0.wechatlistTrs_, CommonItemView)
	arg_4_0.weiboList_ = LuaList.New(handler(arg_4_0, arg_4_0.RefreshWeiboReward), arg_4_0.weibolistTrs_, CommonItemView)
	arg_4_0.bilibiliList_ = LuaList.New(handler(arg_4_0, arg_4_0.RefreshBilibiliReward), arg_4_0.bilibiliTrs_, CommonItemView)
	arg_4_0.twitterList_ = LuaList.New(handler(arg_4_0, arg_4_0.RefreshTwitterReward), arg_4_0.twitterTrs_, CommonItemView)
	arg_4_0.facebookList_ = LuaList.New(handler(arg_4_0, arg_4_0.RefreshFacebookReward), arg_4_0.facebookTrs_, CommonItemView)
	arg_4_0.discordList_ = LuaList.New(handler(arg_4_0, arg_4_0.RefreshDiscordReward), arg_4_0.discordTrs_, CommonItemView)
	arg_4_0.youtubeList_ = LuaList.New(handler(arg_4_0, arg_4_0.RefreshYoutubeReward), arg_4_0.youtubeTrs_, CommonItemView)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.wechatBtn_, nil, function()
		arg_5_0:Go("followPop")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 51,
			direction_channel = 4
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.weiboBtn_, nil, function()
		local var_7_0 = SDKTools.ToJsonFormat({
			messageType = "GetPlatformData",
			platform = OperationConst.PLATFORM.WEIBO
		})

		GameToSDK.SendMessage(var_7_0)
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 52,
			direction_channel = 4
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.bilibiliBtn_, nil, function()
		if OperationAction.GetOperationUrl("FOLLOW_BILIBILI") then
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.BILIBILI)
		else
			ShowTips("ERROR_NO_TEMPLATE")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.twitterBtn_, nil, function()
		local var_9_0 = OperationAction.GetOperationUrl("FOLLOW_TWITTER")

		if var_9_0 then
			OperationAction.OpenNormalUrl(var_9_0)
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.TWITTER)
		else
			ShowTips("ERROR_NO_TEMPLATE")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.facebookBtn_, nil, function()
		local var_10_0 = OperationAction.GetOperationUrl("FOLLOW_FACEBOOK")

		var_0_1 = OperationAction.GetOperationUrl("Facebook_PageId") or ""

		if var_10_0 then
			arg_5_0:SendMessageToFollow(1, var_0_2, var_10_0, var_0_1, var_0_3, var_0_4)
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.FACEBOOK)
		else
			ShowTips("ERROR_NO_TEMPLATE")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.discordBtn_, nil, function()
		local var_11_0 = OperationAction.GetOperationUrl("FOLLOW_DISCORD")

		var_0_2 = OperationAction.GetOperationUrl("Discord_AuthUrl") or ""
		var_0_3 = OperationAction.GetOperationUrl("DISCORDCLIENTID") or ""
		var_0_4 = OperationAction.GetOperationUrl("DISCORDCLIENTSECRET") or ""

		if var_11_0 then
			arg_5_0:SendMessageToFollow(0, var_0_2, var_11_0, var_0_1, var_0_3, var_0_4)
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.DISCORD)
		else
			ShowTips("ERROR_NO_TEMPLATE")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.youtubeBtn_, nil, function()
		local var_12_0 = OperationAction.GetOperationUrl("FOLLOW_YOUTUBE")

		if var_12_0 then
			arg_5_0:SendMessageToFollow(2, var_0_2, var_12_0, var_0_1, var_0_3, var_0_4)
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.YOUTUBE)
		else
			ShowTips("ERROR_NO_TEMPLATE")
		end
	end)
end

function var_0_0.SendMessageToFollow(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6)
	SendMessageToSDK(string.format("{\"messageType\" : \"SocialMediaFollow\",\"type\" : \"%d\",\"authUrl\" : \"%s\",\"invitationUrl\" : \"%s\",\"pageId\" : \"%s\",\"discordClientId\" : \"%s\",\"discordClientSecret\" : \"%s\"}", arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6))
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0:ShowDefaultBar()
	SetActive(arg_14_0.weiboGo_, OperationData:IsFollowOpen(OperationConst.PLATFORM.WEIBO))
	SetActive(arg_14_0.wechatGo_, OperationData:IsFollowOpen(OperationConst.PLATFORM.WECHAT))
	SetActive(arg_14_0.bilibiliGo_, OperationData:IsFollowOpen(OperationConst.PLATFORM.BILIBILI))
	SetActive(arg_14_0.twitterGo_, OperationData:IsFollowOpen(OperationConst.PLATFORM.TWITTER))
	SetActive(arg_14_0.facebookGo_, OperationData:IsFollowOpen(OperationConst.PLATFORM.FACEBOOK))
	SetActive(arg_14_0.discordGo_, OperationData:IsFollowOpen(OperationConst.PLATFORM.DISCORD))
	SetActive(arg_14_0.youtubeGo_, OperationData:IsFollowOpen(OperationConst.PLATFORM.YOUTUBE))
	arg_14_0.weChatList_:StartScroll(#GameSetting.wechat_follow_reward.value)
	arg_14_0.weiboList_:StartScroll(#GameSetting.weibo_follow_reward.value)
	arg_14_0.bilibiliList_:StartScroll(#GameSetting.bilibili_follow_reward.value)
	arg_14_0.twitterList_:StartScroll(#GameSetting.twitter_follow_reward.value)
	arg_14_0.facebookList_:StartScroll(#GameSetting.facebook_follow_reward.value)
	arg_14_0.discordList_:StartScroll(#GameSetting.discord_follow_reward.value)
	arg_14_0.youtubeList_:StartScroll(#GameSetting.youtube_follow_reward.value)
	arg_14_0:RegistEventListener(GET_PLATFORM_DATA_CALLBACK, function(arg_15_0)
		if arg_15_0.code == 0 then
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.WEIBO)
		elseif arg_15_0.code == 2 then
			-- block empty
		else
			ShowTips(arg_15_0.message or "")
		end
	end)
	arg_14_0:RegistEventListener(SOCAIL_DISCORD_CANCEL, function(arg_16_0)
		if arg_16_0.code == 0 then
			ShowTips("ERROR_DISCORD_SUBSCRIB_FAILED")
		end
	end)
end

function var_0_0.RefreshWeChatReward(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = GameSetting.wechat_follow_reward.value[arg_17_1]
	local var_17_1 = clone(ItemTemplateData)

	var_17_1.id = var_17_0[1]
	var_17_1.number = var_17_0[2]

	function var_17_1.clickFun(arg_18_0)
		ShowPopItem(POP_ITEM, {
			arg_18_0.id,
			arg_18_0.number
		})
	end

	arg_17_2:SetData(var_17_1)
end

function var_0_0.RefreshWeiboReward(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = GameSetting.weibo_follow_reward.value[arg_19_1]
	local var_19_1 = clone(ItemTemplateData)

	var_19_1.id = var_19_0[1]
	var_19_1.number = var_19_0[2]

	function var_19_1.clickFun(arg_20_0)
		ShowPopItem(POP_ITEM, {
			arg_20_0.id,
			arg_20_0.number
		})
	end

	arg_19_2:SetData(var_19_1)
end

function var_0_0.RefreshBilibiliReward(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = GameSetting.bilibili_follow_reward.value[arg_21_1]
	local var_21_1 = clone(ItemTemplateData)

	var_21_1.id = var_21_0[1]
	var_21_1.number = var_21_0[2]

	function var_21_1.clickFun(arg_22_0)
		ShowPopItem(POP_ITEM, {
			arg_22_0.id,
			arg_22_0.number
		})
	end

	arg_21_2:SetData(var_21_1)
end

function var_0_0.RefreshTwitterReward(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = GameSetting.twitter_follow_reward.value[arg_23_1]
	local var_23_1 = clone(ItemTemplateData)

	var_23_1.id = var_23_0[1]
	var_23_1.number = var_23_0[2]

	function var_23_1.clickFun(arg_24_0)
		ShowPopItem(POP_ITEM, {
			arg_24_0.id,
			arg_24_0.number
		})
	end

	arg_23_2:SetData(var_23_1)
end

function var_0_0.RefreshFacebookReward(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = GameSetting.facebook_follow_reward.value[arg_25_1]
	local var_25_1 = clone(ItemTemplateData)

	var_25_1.id = var_25_0[1]
	var_25_1.number = var_25_0[2]

	function var_25_1.clickFun(arg_26_0)
		ShowPopItem(POP_ITEM, {
			arg_26_0.id,
			arg_26_0.number
		})
	end

	arg_25_2:SetData(var_25_1)
end

function var_0_0.RefreshDiscordReward(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = GameSetting.discord_follow_reward.value[arg_27_1]
	local var_27_1 = clone(ItemTemplateData)

	var_27_1.id = var_27_0[1]
	var_27_1.number = var_27_0[2]

	function var_27_1.clickFun(arg_28_0)
		ShowPopItem(POP_ITEM, {
			arg_28_0.id,
			arg_28_0.number
		})
	end

	arg_27_2:SetData(var_27_1)
end

function var_0_0.RefreshYoutubeReward(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = GameSetting.youtube_follow_reward.value[arg_29_1]
	local var_29_1 = clone(ItemTemplateData)

	var_29_1.id = var_29_0[1]
	var_29_1.number = var_29_0[2]

	function var_29_1.clickFun(arg_30_0)
		ShowPopItem(POP_ITEM, {
			arg_30_0.id,
			arg_30_0.number
		})
	end

	arg_29_2:SetData(var_29_1)
end

function var_0_0.OnExit(arg_31_0)
	arg_31_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_32_0)
	arg_32_0.weChatList_:Dispose()
	arg_32_0.weiboList_:Dispose()
	arg_32_0.bilibiliList_:Dispose()
	arg_32_0.twitterList_:Dispose()
	arg_32_0.facebookList_:Dispose()
	arg_32_0.discordList_:Dispose()
	arg_32_0.youtubeList_:Dispose()
	var_0_0.super.Dispose(arg_32_0)
end

return var_0_0

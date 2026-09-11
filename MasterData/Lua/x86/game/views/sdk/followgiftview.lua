local FollowGiftView = class("FollowGiftView", ReduxView)
local var_0_1 = ""
local var_0_2 = ""
local var_0_3 = ""
local var_0_4 = ""

function FollowGiftView:UIName()
	return "Widget/System/Medium/WelfareUI"
end

function FollowGiftView:UIParent()
	return manager.ui.uiMain.transform
end

function FollowGiftView:Init()
	self:InitUI()
	self:AddUIListener()
end

function FollowGiftView:InitUI()
	self:BindCfgUI()

	self.weChatList_ = LuaList.New(handler(self, self.RefreshWeChatReward), self.wechatlistTrs_, CommonItemView)
	self.weiboList_ = LuaList.New(handler(self, self.RefreshWeiboReward), self.weibolistTrs_, CommonItemView)
	self.bilibiliList_ = LuaList.New(handler(self, self.RefreshBilibiliReward), self.bilibiliTrs_, CommonItemView)
	self.twitterList_ = LuaList.New(handler(self, self.RefreshTwitterReward), self.twitterTrs_, CommonItemView)
	self.facebookList_ = LuaList.New(handler(self, self.RefreshFacebookReward), self.facebookTrs_, CommonItemView)
	self.discordList_ = LuaList.New(handler(self, self.RefreshDiscordReward), self.discordTrs_, CommonItemView)
	self.youtubeList_ = LuaList.New(handler(self, self.RefreshYoutubeReward), self.youtubeTrs_, CommonItemView)
end

function FollowGiftView:AddUIListener()
	self:AddBtnListener(self.wechatBtn_, nil, function()
		self:Go("followPop")
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 51,
			direction_channel = 4
		})
	end)
	self:AddBtnListener(self.weiboBtn_, nil, function()
		GameToSDK.SendMessage((SDKTools.ToJsonFormat({
			messageType = "GetPlatformData",
			platform = OperationConst.PLATFORM.WEIBO
		})))
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 52,
			direction_channel = 4
		})
	end)
	self:AddBtnListener(self.bilibiliBtn_, nil, function()
		if OperationAction.GetOperationUrl("FOLLOW_BILIBILI") then
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.BILIBILI)
		else
			ShowTips("ERROR_NO_TEMPLATE")
		end
	end)
	self:AddBtnListener(self.twitterBtn_, nil, function()
		local var_9_0 = OperationAction.GetOperationUrl("FOLLOW_TWITTER")

		if var_9_0 then
			OperationAction.OpenNormalUrl(var_9_0)
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.TWITTER)
		else
			ShowTips("ERROR_NO_TEMPLATE")
		end
	end)
	self:AddBtnListener(self.facebookBtn_, nil, function()
		local var_10_0 = OperationAction.GetOperationUrl("FOLLOW_FACEBOOK")

		var_0_1 = OperationAction.GetOperationUrl("Facebook_PageId") or ""

		if var_10_0 then
			self:SendMessageToFollow(1, var_0_2, var_10_0, var_0_1, var_0_3, var_0_4)
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.FACEBOOK)
		else
			ShowTips("ERROR_NO_TEMPLATE")
		end
	end)
	self:AddBtnListener(self.discordBtn_, nil, function()
		local var_11_0 = OperationAction.GetOperationUrl("FOLLOW_DISCORD")

		var_0_2 = OperationAction.GetOperationUrl("Discord_AuthUrl") or ""
		var_0_3 = OperationAction.GetOperationUrl("DISCORDCLIENTID") or ""
		var_0_4 = OperationAction.GetOperationUrl("DISCORDCLIENTSECRET") or ""

		if var_11_0 then
			self:SendMessageToFollow(0, var_0_2, var_11_0, var_0_1, var_0_3, var_0_4)
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.DISCORD)
		else
			ShowTips("ERROR_NO_TEMPLATE")
		end
	end)
	self:AddBtnListener(self.youtubeBtn_, nil, function()
		local var_12_0 = OperationAction.GetOperationUrl("FOLLOW_YOUTUBE")

		if var_12_0 then
			self:SendMessageToFollow(2, var_0_2, var_12_0, var_0_1, var_0_3, var_0_4)
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.YOUTUBE)
		else
			ShowTips("ERROR_NO_TEMPLATE")
		end
	end)
end

function FollowGiftView:SendMessageToFollow(arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6)
	SendMessageToSDK(string.format("{\"messageType\" : \"SocialMediaFollow\",\"type\" : \"%d\",\"authUrl\" : \"%s\",\"invitationUrl\" : \"%s\",\"pageId\" : \"%s\",\"discordClientId\" : \"%s\",\"discordClientSecret\" : \"%s\"}", arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6))
end

function FollowGiftView:OnEnter()
	self:ShowDefaultBar()
	SetActive(self.weiboGo_, OperationData:IsFollowOpen(OperationConst.PLATFORM.WEIBO))
	SetActive(self.wechatGo_, OperationData:IsFollowOpen(OperationConst.PLATFORM.WECHAT))
	SetActive(self.bilibiliGo_, OperationData:IsFollowOpen(OperationConst.PLATFORM.BILIBILI))
	SetActive(self.twitterGo_, OperationData:IsFollowOpen(OperationConst.PLATFORM.TWITTER))
	SetActive(self.facebookGo_, OperationData:IsFollowOpen(OperationConst.PLATFORM.FACEBOOK))
	SetActive(self.discordGo_, OperationData:IsFollowOpen(OperationConst.PLATFORM.DISCORD))
	SetActive(self.youtubeGo_, OperationData:IsFollowOpen(OperationConst.PLATFORM.YOUTUBE))
	self.weChatList_:StartScroll(#GameSetting.wechat_follow_reward.value)
	self.weiboList_:StartScroll(#GameSetting.weibo_follow_reward.value)
	self.bilibiliList_:StartScroll(#GameSetting.bilibili_follow_reward.value)
	self.twitterList_:StartScroll(#GameSetting.twitter_follow_reward.value)
	self.facebookList_:StartScroll(#GameSetting.facebook_follow_reward.value)
	self.discordList_:StartScroll(#GameSetting.discord_follow_reward.value)
	self.youtubeList_:StartScroll(#GameSetting.youtube_follow_reward.value)
	self:RegistEventListener(GET_PLATFORM_DATA_CALLBACK, function(arg_15_0)
		if arg_15_0.code == 0 then
			SurveyAction.FollowPlatform(OperationConst.PLATFORM.WEIBO)
		elseif arg_15_0.code == 2 then
			-- block empty
		else
			ShowTips((not arg_15_0.message or nil) and "")
		end
	end)
	self:RegistEventListener(SOCAIL_DISCORD_CANCEL, function(arg_16_0)
		if arg_16_0.code == 0 then
			ShowTips("ERROR_DISCORD_SUBSCRIB_FAILED")
		end
	end)
end

function FollowGiftView:RefreshWeChatReward(arg_17_1, arg_17_2)
	local var_17_0 = clone(ItemTemplateData)

	var_17_0.id = GameSetting.wechat_follow_reward.value[arg_17_1][1]
	var_17_0.number = GameSetting.wechat_follow_reward.value[arg_17_1][2]

	function var_17_0:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	arg_17_2:SetData(var_17_0)
end

function FollowGiftView:RefreshWeiboReward(arg_19_1, arg_19_2)
	local var_19_0 = clone(ItemTemplateData)

	var_19_0.id = GameSetting.weibo_follow_reward.value[arg_19_1][1]
	var_19_0.number = GameSetting.weibo_follow_reward.value[arg_19_1][2]

	function var_19_0:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	arg_19_2:SetData(var_19_0)
end

function FollowGiftView:RefreshBilibiliReward(arg_21_1, arg_21_2)
	local var_21_0 = clone(ItemTemplateData)

	var_21_0.id = GameSetting.bilibili_follow_reward.value[arg_21_1][1]
	var_21_0.number = GameSetting.bilibili_follow_reward.value[arg_21_1][2]

	function var_21_0:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	arg_21_2:SetData(var_21_0)
end

function FollowGiftView:RefreshTwitterReward(arg_23_1, arg_23_2)
	local var_23_0 = clone(ItemTemplateData)

	var_23_0.id = GameSetting.twitter_follow_reward.value[arg_23_1][1]
	var_23_0.number = GameSetting.twitter_follow_reward.value[arg_23_1][2]

	function var_23_0:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	arg_23_2:SetData(var_23_0)
end

function FollowGiftView:RefreshFacebookReward(arg_25_1, arg_25_2)
	local var_25_0 = clone(ItemTemplateData)

	var_25_0.id = GameSetting.facebook_follow_reward.value[arg_25_1][1]
	var_25_0.number = GameSetting.facebook_follow_reward.value[arg_25_1][2]

	function var_25_0:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	arg_25_2:SetData(var_25_0)
end

function FollowGiftView:RefreshDiscordReward(arg_27_1, arg_27_2)
	local var_27_0 = clone(ItemTemplateData)

	var_27_0.id = GameSetting.discord_follow_reward.value[arg_27_1][1]
	var_27_0.number = GameSetting.discord_follow_reward.value[arg_27_1][2]

	function var_27_0:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	arg_27_2:SetData(var_27_0)
end

function FollowGiftView:RefreshYoutubeReward(arg_29_1, arg_29_2)
	local var_29_0 = clone(ItemTemplateData)

	var_29_0.id = GameSetting.youtube_follow_reward.value[arg_29_1][1]
	var_29_0.number = GameSetting.youtube_follow_reward.value[arg_29_1][2]

	function var_29_0:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	arg_29_2:SetData(var_29_0)
end

function FollowGiftView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function FollowGiftView:Dispose()
	self.weChatList_:Dispose()
	self.weiboList_:Dispose()
	self.bilibiliList_:Dispose()
	self.twitterList_:Dispose()
	self.facebookList_:Dispose()
	self.discordList_:Dispose()
	self.youtubeList_:Dispose()
	FollowGiftView.super.Dispose(self)
end

return FollowGiftView

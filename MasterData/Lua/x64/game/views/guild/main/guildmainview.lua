local GuildMainView = class("GuildMainView", ReduxView)

function GuildMainView:UIName()
	return "Widget/System/Club/ClubHomeUI"
end

function GuildMainView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildMainView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.chatTextExtension_ = self.textChat_:GetComponent(typeof(TextExtension))
	self.controller_ = self.clubInfo:GetController("edit")
	self.noticeController_ = self.clubInfo:GetController("noticeEmpty")
end

function GuildMainView:OnEnter()
	if GuildData:GetGuildInfo().id == nil then
		self:Go("/home")

		return
	end

	CommunityAction:RefreshCurrencyA()
	self:RefreshGuildUI()
	self:RegisterEvents()
	self:ShowImpeachTips()
	self:BindUIRedPoint()
end

function GuildMainView:RegisterEvents()
	self:RegistEventListener(GUILD_SWITCH_HEAD_ICON, handler(self, self.SwitchHeadIcon))
	self:RegistEventListener(GUILD_RENAME, handler(self, self.GuildRename))
	self:RegistEventListener(GUILD_NOTICE, handler(self, self.RefreshGuildNotice))
	self:RegistEventListener(GUILD_SWITCH_ICON_SERVER, handler(self, self.GuildSwitchIconServer))
	self:RegistEventListener(CHAT_GUILD_NEW_MESSAGE, handler(self, self.NewMessage))
	self:RegistEventListener(GUILD_REFRESH_MEMBER, handler(self, self.RefreshMember))
	self:RegistEventListener(GUILD_SHARE, handler(self, self.RefreshShareBtn))
	self:RegistEventListener(CHAT_GUILD_RESET, handler(self, self.RefreshMessage))
end

function GuildMainView:OnTop()
	if GuildData:GetGuildInfo().id == nil then
		self:Go("/home")

		return
	end

	self:RefreshWindowBar()
	manager.windowBar:RegistBackCallBack(function()
		self:Back(2)
	end)
end

function GuildMainView:BindUIRedPoint()
	manager.redPoint:bindUIandKey(self.buttonManager_.transform, RedPointConst.GUILD_MANAGER)
	manager.redPoint:bindUIandKey(self.buttonTask_.transform, RedPointConst.CLUB_TASK)
	manager.redPoint:bindUIandKey(self.buttonWelfare_.transform, RedPointConst.CLUB_WELFARE)
	manager.redPoint:bindUIandKey(self.noticeContainer_, RedPointConst.GUILD_BOSS, {
		x = 0,
		y = 0
	})
end

function GuildMainView:UnBindUIRedPoint()
	manager.redPoint:unbindUIandKey(self.buttonManager_.transform, RedPointConst.GUILD_MANAGER)
	manager.redPoint:unbindUIandKey(self.buttonTask_.transform, RedPointConst.CLUB_TASK)
	manager.redPoint:unbindUIandKey(self.buttonWelfare_.transform, RedPointConst.CLUB_WELFARE)
	manager.redPoint:unbindUIandKey(self.noticeContainer_, RedPointConst.GUILD_BOSS)
end

function GuildMainView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
	self:UnBindUIRedPoint()
	self:StopTimer()
	self:StopShareTimer()
end

function GuildMainView:Dispose()
	GuildMainView.super.Dispose(self)
end

function GuildMainView:AddListeners()
	self:AddBtnListener(self.btnCopy_, nil, function()
		UnityEngine.GUIUtility.systemCopyBuffer = GuildData:GetGuildInfo().id

		ShowTips("COPY_SUCCESS")
	end)
	self:AddBtnListener(self.buttonName_, nil, function()
		JumpTools.OpenPageByJump("guildRename")
	end)
	self:AddBtnListener(self.buttonNotice_, nil, function()
		JumpTools.OpenPageByJump("guildChangeNotice")
	end)
	self:AddBtnListener(self.buttonLogo_, nil, function()
		local var_16_0 = GuildData:GetGuildInfo()

		if var_16_0.post >= GuildConst.GUILD_POST.DEPUTY then
			return
		end

		JumpTools.OpenPageByJump("guildHeadIconSelect", {
			selectID = var_16_0.icon
		})
	end)
	self:AddBtnListener(self.buttonManager_, nil, function()
		GuildAction.RequiredGuildMemberList(function(arg_18_0)
			self:Go("/guildManager")
		end)
	end)
	self:AddBtnListener(self.buttonShop_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.GUIDE_SHOP
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.buttonTask_, nil, function()
		JumpTools.OpenPageByJump("/communityTask")
	end)
	self:AddBtnListener(self.buttonWelfare_, nil, function()
		JumpTools.OpenPageByJump("communityWelfare")
	end)
	self:AddBtnListener(self.buttonChat_, nil, function()
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_GUILD
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	self:AddBtnListener(self.btnLevel_, nil, function()
		self.textLimitExp_.text = string.format("%s/%s", GuildData:GetGuildInfo().curWeekExp, GuildData:GetMaxWeekExp())

		self:AddTimer()
	end)
	self:AddBtnListener(self.bossBtn_, nil, function()
		if not GuildData:GetBossData().initedFromServer then
			ShowTips("GUILD_BOSS_CD_TIP")

			return
		end

		JumpTools.OpenPageByJump("/guildBossMain", {
			isEnter = 1
		}, ViewConst.SYSTEM_ID.GUILD_BOSS)
	end)
	self:AddBtnListener(self.guildShareBtn_, nil, function()
		local var_25_0 = GuildData:GetShareTimestamp()

		if var_25_0 > manager.time:GetServerTime() then
			ShowTips(string.format(GetTips("CLUB_SHARE_CD_TIPS"), manager.time:GetLostTimeStr(var_25_0)))
		else
			JumpTools.OpenPageByJump("guildShareInfo")
		end
	end)
	self:AddBtnListener(self.spBtn_, nil, function()
		ActivityTools.JumpBackToActivityMainViewByActivityID((GuildActivitySPData:GetCurMainActivityID()))
	end)
end

function GuildMainView:RefreshWindowBar()
	local var_27_1 = GameSetting.club_info_describe.value

	manager.windowBar:SwitchBar(GuildData:GetGuildInfo().post <= GuildConst.GUILD_POST.DEPUTY and (#var_27_1 > 0 and {
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	} or {
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	}) or #var_27_1 > 0 and {
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	} or {
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
	})

	if #var_27_1 > 0 then
		manager.windowBar:SetGameHelpKey({
			view = "gameHelpPro",
			type = "jump",
			params = {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = var_27_1
			}
		})
	end

	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A, true)
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B, true)
end

function GuildMainView:RefreshGuildUI()
	local var_28_0 = GuildData:GetGuildInfo()

	self:GuildRename(var_28_0.name)

	self.textID_.text = string.format("ID:%s", var_28_0.id)
	self.textCaptain_.text = GetI18NText(var_28_0.captain)

	self:RefreshGuildNotice(var_28_0.notice)
	self:GuildSwitchIconServer(var_28_0.icon)
	self:RefreshGuildExp()
	self:RefreshMember()
	self:RefreshMessage()
	self:RefreshSpActivityState()
	TimeTools.StartAfterSeconds(0.1, function()
		self:UpdateTimer()
	end, {})
end

function GuildMainView:RefreshSpActivityState()
	local var_30_0, var_30_1 = GuildActivitySPTools.CheckGuildActivitySPIsOpen()

	if var_30_0 then
		self.activitySpID = var_30_1

		SetActive(self.spBtn_.gameObject, true)

		self.spbtnImg_.sprite = getSpriteViaConfig("ActivityClubSPEnterIcon", var_30_1)

		local var_30_2 = GuildActivitySpTools.GetCurOpenActivityStateInfo()

		if var_30_2.activityName ~= "" then
			self.activityName.text = GetTips(var_30_2.activityName)
		end
	else
		self.activitySpID = nil

		SetActive(self.spBtn_.gameObject, false)
	end
end

function GuildMainView:ShowImpeachTips()
	local var_31_0 = GuildData:GetGuildInfo()

	if var_31_0.post == GuildConst.GUILD_POST.CAPTAIN and var_31_0.impeachTime - manager.time:GetServerTime() > 0 and not GuildData:GetImpeachFlag() then
		JumpTools.OpenPageByJump("guildImpeachTips")
	end
end

function GuildMainView:RefreshMessage()
	ChatGuildData:InitCacheGuildContent()
	self:NewMessage()
end

function GuildMainView:UpdateTimer()
	local var_33_0, var_33_1 = GuildData:GetLastTime()

	self.lastTimeLabel_.text = manager.time:GetLostTimeStrWith2Unit(var_33_1)

	if self.statusName_ ~= var_33_0 then
		if var_33_0 == "prepose" then
			self.stageLabel_.text = GetTips("CLUB_BOSS_PREPOSE_TIP")
			self.lastTimeText_.text = GetTips("GONGHUIBOSS_LIEXIZHENGZHAO")
			self.bossBtnImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/ClubUI/Boss_btn_002")
		else
			self.stageLabel_.text = GetTips("CLUB_BOSS_CHALLENGE_TIP")
			self.lastTimeText_.text = GetTips("GONGHUIBOSS_LIEXIKAIFANG")
			self.bossBtnImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/ClubUI/Boss_btn_001")
		end

		self.statusName_ = var_33_0
	end

	local var_33_2 = manager.time:GetServerTime()

	if self.activitySpID then
		local var_33_3, var_33_4 = GuildActivitySPTools.CheckActivityCurState(self.activitySpID)

		if var_33_3 == "start" then
			local var_33_5, var_33_6, var_33_7 = GuildActivitySPTools.GetCurActivityTimeStage(var_33_4)

			if var_33_5 == 2 then
				self.spLastTimeLabel_.text = manager.time:GetLostTimeStrWith2Unit(var_33_6)
				self.spStageLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP2"))
			elseif var_33_5 == 1 then
				self.spLastTimeLabel_.text = manager.time:GetLostTimeStrWith2Unit(var_33_7)
				self.spStageLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP1"))
			end
		end

		if var_33_3 == "register" then
			self.spLastTimeLabel_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(var_33_4).stopTime)
			self.spStageLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP0"))
		end
	end
end

function GuildMainView:SwitchHeadIcon(arg_34_1)
	GuildAction.GuildSwitchIcon(arg_34_1, function(arg_35_0)
		if isSuccess(arg_35_0.result) then
			ShowTips("CLUB_CHANGED_ICON_SUCCESS")
		else
			ShowTips(arg_35_0.result)
		end
	end)
end

function GuildMainView:GuildRename(arg_36_1)
	self.textName_.text = GetI18NText(arg_36_1)
end

function GuildMainView:RefreshGuildNotice(arg_37_1)
	if arg_37_1 and #arg_37_1 > 0 then
		self.noticeController_:SetSelectedState("full")
	else
		self.noticeController_:SetSelectedState("empty")
	end

	self.textNotice_.text = GetI18NText(arg_37_1)
end

function GuildMainView:GuildSwitchIconServer(arg_38_1)
	self.imageIcon_.sprite = getSpriteViaConfig("ClubHeadIcon", ClubHeadIconCfg[arg_38_1].icon_bg)
end

function GuildMainView:NewMessage()
	local var_39_0 = ChatGuildData:GetCacheContent()
	local var_39_1 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)
	local var_39_2

	if #var_39_0 > 0 then
		for iter_39_0 = #var_39_0, 1, -1 do
			var_39_2 = var_39_0[iter_39_0]

			if var_39_0[iter_39_0].id and not table.keyof(var_39_1, var_39_2.id) then
				if var_39_2.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
					local var_39_3 = string.format("[%s]", ChatStickerCfg[tonumber(var_39_2.content)].name)

					break
				end

				var_39_3 = var_39_2.content

				break
			end
		end

		if var_39_2.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
			var_39_3 = string.format("[%s]", GetI18NText(ChatStickerCfg[tonumber(var_39_2.content)].name))
		end

		self.chatTextExtension_:SetText(string.format("%s:%s", var_39_2.nick, nil))
	else
		self.textChat_.text = ""
	end
end

function GuildMainView:RefreshGuildExp()
	local var_40_0 = GuildData:GetGuildInfo()
	local var_40_1 = var_40_0.level
	local var_40_2 = var_40_0.exp

	for iter_40_0 = var_40_0.level - 1, 1, -1 do
		var_40_2 = var_40_2 - ClubLevelCfg[iter_40_0].club_level_exp
	end

	if var_40_1 >= GameSetting.club_max_level.value[1] then
		self.textExp_.text = "-/-"
		self.imageProcess_.value = 1
	else
		self.textExp_.text = string.format("%s/%s", var_40_2, ClubLevelCfg[var_40_1].club_level_exp)
		self.imageProcess_.value = var_40_2 / ClubLevelCfg[var_40_1].club_level_exp
	end

	self.textLevel_.text = string.format(GetTips("CLUB_LEVEL"), var_40_1)
end

function GuildMainView:RefreshMember()
	local var_41_0 = GuildData:GetGuildInfo()

	self.textMember_.text = string.format("%s/%s", var_41_0.memberCnt, ClubLevelCfg[var_41_0.level].user_num_max)

	if var_41_0.post == GuildConst.GUILD_POST.CAPTAIN then
		self.controller_:SetSelectedState("CAPTAIN")

		self.mangerText.text = GetTips("CLUB_BOSS_MANAGER")
	elseif var_41_0.post == GuildConst.GUILD_POST.DEPUTY then
		self.controller_:SetSelectedState("DEPUTY")

		self.mangerText.text = GetTips("CLUB_BOSS_MANAGER")
	else
		self.controller_:SetSelectedState("MEMBER")

		self.mangerText.text = GetTips("CLUB_BOSS_MEMBER")
	end

	self:RefreshShareBtn()
	self:RefreshWindowBar()
end

function GuildMainView:AddTimer()
	self:StopTimer()
	SetActive(self.goLevelTips_, true)

	self.timer_ = Timer.New(function()
		self:StopTimer()
	end, 3, 1)

	self.timer_:Start()
end

function GuildMainView:StopTimer()
	SetActive(self.goLevelTips_, false)

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function GuildMainView:AddShareTimer()
	self:StopShareTimer()

	local var_45_0 = GuildData:GetGuildInfo()
	local var_45_1 = GuildData:GetShareTimestamp()

	if var_45_1 < manager.time:GetServerTime() then
		self:RefreshShareBtn()

		return
	end

	local var_45_2 = manager.time:GetServerTime() - var_45_1

	self.timeText_.text = manager.time:GetLostTimeStr(var_45_1)
	self.shareTimer_ = Timer.New(function()
		self.timeText_.text = manager.time:GetLostTimeStr(var_45_1)

		if manager.time:GetServerTime() - var_45_1 >= 0 then
			self:StopShareTimer()
			self:RefreshShareBtn()

			return
		end
	end, 1, -1)

	self.shareTimer_:Start()
end

function GuildMainView:StopShareTimer()
	if self.shareTimer_ then
		self.shareTimer_:Stop()

		self.shareTimer_ = nil
	end
end

function GuildMainView:RefreshShareBtn()
	if table.keyof(GameSetting.club_share_member_list.value, GuildData:GetGuildInfo().post) then
		SetActive(self.guildShareGo_, true)
	else
		SetActive(self.guildShareGo_, false)

		return
	end

	if GuildData:GetShareTimestamp() <= manager.time:GetServerTime() then
		SetActive(self.timeGo_, false)

		self.guildShareBtn_.interactable = true
	else
		SetActive(self.timeGo_, true)

		self.guildShareBtn_.interactable = false

		self:AddShareTimer()
	end
end

return GuildMainView

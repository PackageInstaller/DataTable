local var_0_0 = class("GuildMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Club/ClubHomeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.chatTextExtension_ = arg_3_0.textChat_:GetComponent(typeof(TextExtension))
	arg_3_0.controller_ = arg_3_0.clubInfo:GetController("edit")
	arg_3_0.noticeController_ = arg_3_0.clubInfo:GetController("noticeEmpty")
end

function var_0_0.OnEnter(arg_4_0)
	if GuildData:GetGuildInfo().id == nil then
		arg_4_0:Go("/home")

		return
	end

	CommunityAction:RefreshCurrencyA()
	arg_4_0:RefreshGuildUI()
	arg_4_0:RegisterEvents()
	arg_4_0:ShowImpeachTips()
	arg_4_0:BindUIRedPoint()
end

function var_0_0.RegisterEvents(arg_5_0)
	arg_5_0:RegistEventListener(GUILD_SWITCH_HEAD_ICON, handler(arg_5_0, arg_5_0.SwitchHeadIcon))
	arg_5_0:RegistEventListener(GUILD_RENAME, handler(arg_5_0, arg_5_0.GuildRename))
	arg_5_0:RegistEventListener(GUILD_NOTICE, handler(arg_5_0, arg_5_0.RefreshGuildNotice))
	arg_5_0:RegistEventListener(GUILD_SWITCH_ICON_SERVER, handler(arg_5_0, arg_5_0.GuildSwitchIconServer))
	arg_5_0:RegistEventListener(CHAT_GUILD_NEW_MESSAGE, handler(arg_5_0, arg_5_0.NewMessage))
	arg_5_0:RegistEventListener(GUILD_REFRESH_MEMBER, handler(arg_5_0, arg_5_0.RefreshMember))
	arg_5_0:RegistEventListener(GUILD_SHARE, handler(arg_5_0, arg_5_0.RefreshShareBtn))
	arg_5_0:RegistEventListener(CHAT_GUILD_RESET, handler(arg_5_0, arg_5_0.RefreshMessage))
end

function var_0_0.OnTop(arg_6_0)
	if GuildData:GetGuildInfo().id == nil then
		arg_6_0:Go("/home")

		return
	end

	arg_6_0:RefreshWindowBar()
	manager.windowBar:RegistBackCallBack(function()
		arg_6_0:Back(2)
	end)
end

function var_0_0.BindUIRedPoint(arg_8_0)
	manager.redPoint:bindUIandKey(arg_8_0.buttonManager_.transform, RedPointConst.GUILD_MANAGER)
	manager.redPoint:bindUIandKey(arg_8_0.buttonTask_.transform, RedPointConst.CLUB_TASK)
	manager.redPoint:bindUIandKey(arg_8_0.buttonWelfare_.transform, RedPointConst.CLUB_WELFARE)
	manager.redPoint:bindUIandKey(arg_8_0.noticeContainer_, RedPointConst.GUILD_BOSS, {
		x = 0,
		y = 0
	})
end

function var_0_0.UnBindUIRedPoint(arg_9_0)
	manager.redPoint:unbindUIandKey(arg_9_0.buttonManager_.transform, RedPointConst.GUILD_MANAGER)
	manager.redPoint:unbindUIandKey(arg_9_0.buttonTask_.transform, RedPointConst.CLUB_TASK)
	manager.redPoint:unbindUIandKey(arg_9_0.buttonWelfare_.transform, RedPointConst.CLUB_WELFARE)
	manager.redPoint:unbindUIandKey(arg_9_0.noticeContainer_, RedPointConst.GUILD_BOSS)
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()
	arg_10_0:RemoveAllEventListener()
	arg_10_0:UnBindUIRedPoint()
	arg_10_0:StopTimer()
	arg_10_0:StopShareTimer()
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.AddListeners(arg_12_0)
	arg_12_0:AddBtnListener(arg_12_0.btnCopy_, nil, function()
		local var_13_0 = GuildData:GetGuildInfo()

		UnityEngine.GUIUtility.systemCopyBuffer = var_13_0.id

		ShowTips("COPY_SUCCESS")
	end)
	arg_12_0:AddBtnListener(arg_12_0.buttonName_, nil, function()
		JumpTools.OpenPageByJump("guildRename")
	end)
	arg_12_0:AddBtnListener(arg_12_0.buttonNotice_, nil, function()
		JumpTools.OpenPageByJump("guildChangeNotice")
	end)
	arg_12_0:AddBtnListener(arg_12_0.buttonLogo_, nil, function()
		local var_16_0 = GuildData:GetGuildInfo()

		if var_16_0.post >= GuildConst.GUILD_POST.DEPUTY then
			return
		end

		JumpTools.OpenPageByJump("guildHeadIconSelect", {
			selectID = var_16_0.icon
		})
	end)
	arg_12_0:AddBtnListener(arg_12_0.buttonManager_, nil, function()
		GuildAction.RequiredGuildMemberList(function(arg_18_0)
			arg_12_0:Go("/guildManager")
		end)
	end)
	arg_12_0:AddBtnListener(arg_12_0.buttonShop_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.GUIDE_SHOP
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_12_0:AddBtnListener(arg_12_0.buttonTask_, nil, function()
		JumpTools.OpenPageByJump("/communityTask")
	end)
	arg_12_0:AddBtnListener(arg_12_0.buttonWelfare_, nil, function()
		JumpTools.OpenPageByJump("communityWelfare")
	end)
	arg_12_0:AddBtnListener(arg_12_0.buttonChat_, nil, function()
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_GUILD
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	arg_12_0:AddBtnListener(arg_12_0.btnLevel_, nil, function()
		local var_23_0 = GuildData:GetGuildInfo()

		arg_12_0.textLimitExp_.text = string.format("%s/%s", var_23_0.curWeekExp, GuildData:GetMaxWeekExp())

		arg_12_0:AddTimer()
	end)
	arg_12_0:AddBtnListener(arg_12_0.bossBtn_, nil, function()
		if not GuildData:GetBossData().initedFromServer then
			ShowTips("GUILD_BOSS_CD_TIP")

			return
		end

		JumpTools.OpenPageByJump("/guildBossMain", {
			isEnter = 1
		}, ViewConst.SYSTEM_ID.GUILD_BOSS)
	end)
	arg_12_0:AddBtnListener(arg_12_0.guildShareBtn_, nil, function()
		local var_25_0 = GuildData:GetShareTimestamp()

		if var_25_0 > manager.time:GetServerTime() then
			ShowTips(string.format(GetTips("CLUB_SHARE_CD_TIPS"), manager.time:GetLostTimeStr(var_25_0)))
		else
			JumpTools.OpenPageByJump("guildShareInfo")
		end
	end)
	arg_12_0:AddBtnListener(arg_12_0.spBtn_, nil, function()
		local var_26_0 = GuildActivitySPData:GetCurMainActivityID()

		ActivityTools.JumpBackToActivityMainViewByActivityID(var_26_0)
	end)
end

function var_0_0.RefreshWindowBar(arg_27_0)
	local var_27_0 = {}
	local var_27_1 = GameSetting.club_info_describe.value

	if GuildData:GetGuildInfo().post <= GuildConst.GUILD_POST.DEPUTY then
		if #var_27_1 > 0 then
			var_27_0 = {
				BACK_BAR,
				HOME_BAR,
				INFO_BAR,
				CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A,
				CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
			}
		else
			var_27_0 = {
				BACK_BAR,
				HOME_BAR,
				CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A,
				CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
			}
		end
	elseif #var_27_1 > 0 then
		var_27_0 = {
			BACK_BAR,
			HOME_BAR,
			INFO_BAR,
			CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
		}
	else
		var_27_0 = {
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_CLUB_COIN_B
		}
	end

	manager.windowBar:SwitchBar(var_27_0)

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

function var_0_0.RefreshGuildUI(arg_28_0)
	local var_28_0 = GuildData:GetGuildInfo()

	arg_28_0:GuildRename(var_28_0.name)

	arg_28_0.textID_.text = string.format("ID:%s", var_28_0.id)
	arg_28_0.textCaptain_.text = GetI18NText(var_28_0.captain)

	arg_28_0:RefreshGuildNotice(var_28_0.notice)
	arg_28_0:GuildSwitchIconServer(var_28_0.icon)
	arg_28_0:RefreshGuildExp()
	arg_28_0:RefreshMember()
	arg_28_0:RefreshMessage()
	arg_28_0:RefreshSpActivityState()
	TimeTools.StartAfterSeconds(0.1, function()
		arg_28_0:UpdateTimer()
	end, {})
end

function var_0_0.RefreshSpActivityState(arg_30_0)
	local var_30_0, var_30_1 = GuildActivitySPTools.CheckGuildActivitySPIsOpen()

	if var_30_0 then
		arg_30_0.activitySpID = var_30_1

		SetActive(arg_30_0.spBtn_.gameObject, true)

		arg_30_0.spbtnImg_.sprite = getSpriteViaConfig("ActivityClubSPEnterIcon", var_30_1)

		local var_30_2 = GuildActivitySpTools.GetCurOpenActivityStateInfo()

		if var_30_2.activityName ~= "" then
			arg_30_0.activityName.text = GetTips(var_30_2.activityName)
		end
	else
		arg_30_0.activitySpID = nil

		SetActive(arg_30_0.spBtn_.gameObject, false)
	end
end

function var_0_0.ShowImpeachTips(arg_31_0)
	local var_31_0 = GuildData:GetGuildInfo()

	if var_31_0.post == GuildConst.GUILD_POST.CAPTAIN and var_31_0.impeachTime - manager.time:GetServerTime() > 0 and not GuildData:GetImpeachFlag() then
		JumpTools.OpenPageByJump("guildImpeachTips")
	end
end

function var_0_0.RefreshMessage(arg_32_0)
	ChatGuildData:InitCacheGuildContent()
	arg_32_0:NewMessage()
end

function var_0_0.UpdateTimer(arg_33_0)
	local var_33_0, var_33_1 = GuildData:GetLastTime()

	arg_33_0.lastTimeLabel_.text = manager.time:GetLostTimeStrWith2Unit(var_33_1)

	if arg_33_0.statusName_ ~= var_33_0 then
		if var_33_0 == "prepose" then
			arg_33_0.stageLabel_.text = GetTips("CLUB_BOSS_PREPOSE_TIP")
			arg_33_0.lastTimeText_.text = GetTips("GONGHUIBOSS_LIEXIZHENGZHAO")
			arg_33_0.bossBtnImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/ClubUI/Boss_btn_002")
		else
			arg_33_0.stageLabel_.text = GetTips("CLUB_BOSS_CHALLENGE_TIP")
			arg_33_0.lastTimeText_.text = GetTips("GONGHUIBOSS_LIEXIKAIFANG")
			arg_33_0.bossBtnImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/ClubUI/Boss_btn_001")
		end

		arg_33_0.statusName_ = var_33_0
	end

	local var_33_2 = manager.time:GetServerTime()

	if arg_33_0.activitySpID then
		local var_33_3, var_33_4 = GuildActivitySPTools.CheckActivityCurState(arg_33_0.activitySpID)

		if var_33_3 == "start" then
			local var_33_5, var_33_6, var_33_7 = GuildActivitySPTools.GetCurActivityTimeStage(var_33_4)

			if var_33_5 == 2 then
				arg_33_0.spLastTimeLabel_.text = manager.time:GetLostTimeStrWith2Unit(var_33_6)
				arg_33_0.spStageLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP2"))
			elseif var_33_5 == 1 then
				arg_33_0.spLastTimeLabel_.text = manager.time:GetLostTimeStrWith2Unit(var_33_7)
				arg_33_0.spStageLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP1"))
			end
		end

		if var_33_3 == "register" then
			local var_33_8 = ActivityData:GetActivityData(var_33_4).stopTime

			arg_33_0.spLastTimeLabel_.text = manager.time:GetLostTimeStrWith2Unit(var_33_8)
			arg_33_0.spStageLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP0"))
		end
	end
end

function var_0_0.SwitchHeadIcon(arg_34_0, arg_34_1)
	GuildAction.GuildSwitchIcon(arg_34_1, function(arg_35_0)
		if isSuccess(arg_35_0.result) then
			ShowTips("CLUB_CHANGED_ICON_SUCCESS")
		else
			ShowTips(arg_35_0.result)
		end
	end)
end

function var_0_0.GuildRename(arg_36_0, arg_36_1)
	arg_36_0.textName_.text = GetI18NText(arg_36_1)
end

function var_0_0.RefreshGuildNotice(arg_37_0, arg_37_1)
	if arg_37_1 and #arg_37_1 > 0 then
		arg_37_0.noticeController_:SetSelectedState("full")
	else
		arg_37_0.noticeController_:SetSelectedState("empty")
	end

	arg_37_0.textNotice_.text = GetI18NText(arg_37_1)
end

function var_0_0.GuildSwitchIconServer(arg_38_0, arg_38_1)
	local var_38_0 = ClubHeadIconCfg[arg_38_1]

	arg_38_0.imageIcon_.sprite = getSpriteViaConfig("ClubHeadIcon", var_38_0.icon_bg)
end

function var_0_0.NewMessage(arg_39_0)
	local var_39_0 = ChatGuildData:GetCacheContent()
	local var_39_1 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)
	local var_39_2
	local var_39_3

	if #var_39_0 > 0 then
		for iter_39_0 = #var_39_0, 1, -1 do
			var_39_2 = var_39_0[iter_39_0]

			if var_39_2.id and not table.keyof(var_39_1, var_39_2.id) then
				if var_39_2.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
					var_39_3 = string.format("[%s]", ChatStickerCfg[tonumber(var_39_2.content)].name)

					break
				end

				var_39_3 = var_39_2.content

				break
			end
		end

		if var_39_2.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
			var_39_3 = string.format("[%s]", GetI18NText(ChatStickerCfg[tonumber(var_39_2.content)].name))
		end

		arg_39_0.chatTextExtension_:SetText(string.format("%s:%s", var_39_2.nick, var_39_3))
	else
		arg_39_0.textChat_.text = ""
	end
end

function var_0_0.RefreshGuildExp(arg_40_0)
	local var_40_0 = GuildData:GetGuildInfo()
	local var_40_1 = var_40_0.level
	local var_40_2 = var_40_0.exp

	for iter_40_0 = var_40_1 - 1, 1, -1 do
		var_40_2 = var_40_2 - ClubLevelCfg[iter_40_0].club_level_exp
	end

	local var_40_3 = ClubLevelCfg[var_40_1].club_level_exp

	if var_40_1 >= GameSetting.club_max_level.value[1] then
		arg_40_0.textExp_.text = "-/-"
		arg_40_0.imageProcess_.value = 1
	else
		arg_40_0.textExp_.text = string.format("%s/%s", var_40_2, var_40_3)
		arg_40_0.imageProcess_.value = var_40_2 / var_40_3
	end

	arg_40_0.textLevel_.text = string.format(GetTips("CLUB_LEVEL"), var_40_1)
end

function var_0_0.RefreshMember(arg_41_0)
	local var_41_0 = GuildData:GetGuildInfo()

	arg_41_0.textMember_.text = string.format("%s/%s", var_41_0.memberCnt, ClubLevelCfg[var_41_0.level].user_num_max)

	if var_41_0.post == GuildConst.GUILD_POST.CAPTAIN then
		arg_41_0.controller_:SetSelectedState("CAPTAIN")

		arg_41_0.mangerText.text = GetTips("CLUB_BOSS_MANAGER")
	elseif var_41_0.post == GuildConst.GUILD_POST.DEPUTY then
		arg_41_0.controller_:SetSelectedState("DEPUTY")

		arg_41_0.mangerText.text = GetTips("CLUB_BOSS_MANAGER")
	else
		arg_41_0.controller_:SetSelectedState("MEMBER")

		arg_41_0.mangerText.text = GetTips("CLUB_BOSS_MEMBER")
	end

	arg_41_0:RefreshShareBtn()
	arg_41_0:RefreshWindowBar()
end

function var_0_0.AddTimer(arg_42_0)
	arg_42_0:StopTimer()
	SetActive(arg_42_0.goLevelTips_, true)

	arg_42_0.timer_ = Timer.New(function()
		arg_42_0:StopTimer()
	end, 3, 1)

	arg_42_0.timer_:Start()
end

function var_0_0.StopTimer(arg_44_0)
	SetActive(arg_44_0.goLevelTips_, false)

	if arg_44_0.timer_ then
		arg_44_0.timer_:Stop()

		arg_44_0.timer_ = nil
	end
end

function var_0_0.AddShareTimer(arg_45_0)
	arg_45_0:StopShareTimer()

	local var_45_0 = GuildData:GetGuildInfo()
	local var_45_1 = GuildData:GetShareTimestamp()

	if var_45_1 < manager.time:GetServerTime() then
		arg_45_0:RefreshShareBtn()

		return
	end

	local var_45_2 = manager.time:GetServerTime() - var_45_1

	arg_45_0.timeText_.text = manager.time:GetLostTimeStr(var_45_1)
	arg_45_0.shareTimer_ = Timer.New(function()
		local var_46_0 = manager.time:GetServerTime() - var_45_1

		arg_45_0.timeText_.text = manager.time:GetLostTimeStr(var_45_1)

		if var_46_0 >= 0 then
			arg_45_0:StopShareTimer()
			arg_45_0:RefreshShareBtn()

			return
		end
	end, 1, -1)

	arg_45_0.shareTimer_:Start()
end

function var_0_0.StopShareTimer(arg_47_0)
	if arg_47_0.shareTimer_ then
		arg_47_0.shareTimer_:Stop()

		arg_47_0.shareTimer_ = nil
	end
end

function var_0_0.RefreshShareBtn(arg_48_0)
	local var_48_0 = GuildData:GetGuildInfo()

	if table.keyof(GameSetting.club_share_member_list.value, var_48_0.post) then
		SetActive(arg_48_0.guildShareGo_, true)
	else
		SetActive(arg_48_0.guildShareGo_, false)

		return
	end

	if GuildData:GetShareTimestamp() <= manager.time:GetServerTime() then
		SetActive(arg_48_0.timeGo_, false)

		arg_48_0.guildShareBtn_.interactable = true
	else
		SetActive(arg_48_0.timeGo_, true)

		arg_48_0.guildShareBtn_.interactable = false

		arg_48_0:AddShareTimer()
	end
end

return var_0_0

local var_0_0 = {}

manager.net:Bind(10999, function(arg_1_0)
	ReconnectLogic.ReconnectError(arg_1_0.reason)
end)
manager.net:Bind(10051, function(arg_2_0)
	if arg_2_0.timestamp and arg_2_0.verify_timestamp then
		manager.time:SetServerTime(arg_2_0.timestamp, arg_2_0.verify_timestamp)
	end
end)
manager.net:Bind(10501, function(arg_3_0)
	var_0_0.OnRequestNewDayData(arg_3_0)
end)
manager.net:Bind(10503, function(arg_4_0)
	var_0_0.SyncSeverTime(arg_4_0)
end)
manager.net:Bind(12019, function(arg_5_0)
	var_0_0.OnClientModuleSwitch(arg_5_0)
end)
manager.net:Bind(12023, function(arg_6_0)
	PlayerData:SetUnclaimedListFromServer(arg_6_0)
end)
manager.net:Bind(32051, function(arg_7_0)
	PlayerData:InItReceivedSkinGift(arg_7_0)
	var_0_0.RefreshSkinGiftRedPoint()
end)
manager.net:Bind(32201, function(arg_8_0)
	PlayerData:AddLikeInfo(arg_8_0.info)
end)
manager.net:Bind(32203, function(arg_9_0)
	PlayerData:InitOverdueCardBgList(arg_9_0.information_background_list)
end)
manager.net:Bind(32205, function(arg_10_0)
	PlayerData:InitOverdueTagList(arg_10_0.tags_list)
end)
manager.notify:RegistListener(ZERO_REFRESH, function()
	PlayerData:ResetSendLikeList()
end)

function var_0_0.RequestNewDayData()
	manager.net:SendWithLoadingNew(10500, {}, 10501, var_0_0.OnRequestNewDayData)
end

function var_0_0:OnRequestNewDayData(arg_13_1)
	var_0_0.SyncSeverTime(self)

	if isSuccess(self.result) then
		manager.notify:Invoke(NEW_DAY)
	end
end

function var_0_0:SyncSeverTime()
	manager.time:SetServerTime(self.timestamp, self.verify_timestamp)
	_G.gameTimer:SetNextDayFreshTime(self.next_refresh_time)
	_G.gameTimer:SetNextWeekFreshTime(self.next_weekly_refresh_time)
	_G.gameTimer:SetNextMonthFreshTime(self.next_monthly_refresh_time)
end

manager.net:Bind(23009, function(arg_15_0)
	var_0_0.PlayInfoInit(arg_15_0)
end)
manager.net:Bind(23015, function(arg_16_0)
	var_0_0.SetPlayerIP(arg_16_0)
end)
manager.net:Bind(12001, function(arg_17_0)
	var_0_0.StoryInit(arg_17_0.story_list)
end)
manager.net:Bind(12033, function(arg_18_0)
	var_0_0.PlayerBrithdayInit(arg_18_0)
end)
manager.net:Bind(12009, function(arg_19_0)
	var_0_0.PlayerOriginalLevel(arg_19_0)
end)
manager.net:Bind(32009, function(arg_20_0)
	var_0_0.PlayerCardInit(arg_20_0)
end)
manager.net:Bind(32007, function(arg_21_0)
	var_0_0.InitOverdueFrameList(arg_21_0)
end)
manager.net:Bind(32063, function(arg_22_0)
	var_0_0.InitOverduePortraitList(arg_22_0)
end)
manager.net:Bind(32067, function(arg_23_0)
	var_0_0.InitOverdueChatBubbleList(arg_23_0)
end)
manager.net:Bind(12099, function(arg_24_0)
	HideInfoData:InitHideData(arg_24_0)
	ComboSkillTools.InitComboList()
end)
manager.net:Bind(32211, function(arg_25_0)
	PlayerData:UnlockTag(arg_25_0.info.id)
end)
manager.net:Bind(81001, function(arg_26_0)
	PlayerData:InitPlayerStoryTrigger(arg_26_0)
end)

function var_0_0.ChangeNickname(arg_27_0, arg_27_1)
	manager.net:SendWithLoadingNew(23012, {
		nick = arg_27_0
	}, 23013, function(arg_28_0)
		if isSuccess(arg_28_0.result) then
			PlayerData:PlayerNicknameChange(arg_27_0)
			PlayerData:UpdateNameChangeInfo(arg_28_0)
			manager.notify:CallUpdateFunc(CHANGE_NAME, {
				nick = arg_27_0
			})
		else
			ShowTips(arg_28_0.result)
		end
	end)
end

function var_0_0.ChangeSign(arg_29_0, arg_29_1)
	var_0_0.isEnter = arg_29_1

	manager.net:SendWithLoadingNew(32012, {
		sign = arg_29_0
	}, 32013, var_0_0.OnChangeSign)
end

function var_0_0:OnChangeSign(arg_30_1)
	if isSuccess(self.result) then
		PlayerData:PlayerSignChange(arg_30_1.sign)
		manager.notify:CallUpdateFunc(CHANGE_SIGN, self, arg_30_1, var_0_0.isEnter)
	else
		ShowTips(self.result)
	end
end

function var_0_0.ChangeHeros(arg_31_0)
	manager.net:SendWithLoadingNew(32014, {
		heroes = arg_31_0
	}, 32015, var_0_0.OnChangeHeros)
end

function var_0_0:OnChangeHeros(arg_32_1)
	if isSuccess(self.result) then
		PlayerData:ChangeHeros(arg_32_1.heroes)
	else
		ShowTips(self.result)
	end
end

function var_0_0.ChangePosterGirl(arg_33_0)
	HomeSceneSettingAction.CheckMatchPosterGirl(arg_33_0)
	manager.net:SendWithLoadingNew(32016, {
		poster_girl = arg_33_0
	}, 32017, var_0_0.OnChangePosterGirl)
end

function var_0_0:OnChangePosterGirl(arg_34_1)
	if isSuccess(self.result) then
		PlayerData:PlayerPosterGirlChange(arg_34_1.poster_girl)

		local var_34_0 = CustomCenterTools.AutoChangeSceneByTime((CustomCenterTools.PickSkinMatchedScene((PlayerData:GetCacheHeroSkinID(arg_34_1.poster_girl)))))

		if var_34_0 and HomeSceneSettingData:GetCurScene() ~= var_34_0 and HomeSceneSettingAction.CheckPosterSceneCanUse(var_34_0) then
			HomeSceneSettingAction.SetHomeScene(var_34_0)
		end

		manager.notify:CallUpdateFunc(CHANGE_POSTER_GIRL, self, arg_34_1)
		manager.notify:Invoke(CHANGE_POSTER_GIRL)
	else
		ShowTips(self.result)
	end
end

function var_0_0.ChangePosterGirlWithCallback(arg_35_0, arg_35_1)
	manager.net:SendWithLoadingNew(32016, {
		poster_girl = arg_35_0
	}, 32017, function(arg_36_0)
		if isSuccess(arg_36_0.result) then
			PlayerData:PlayerPosterGirlChange(arg_35_0)
			manager.notify:Invoke(CHANGE_POSTER_GIRL)

			if arg_35_1 then
				arg_35_1()
			end
		else
			ShowTips(arg_36_0.result)
		end
	end)
end

function var_0_0.TouchPosterGirl()
	manager.net:SendWithLoadingNew(32054, {}, 32055, function(arg_38_0)
		if not isSuccess(arg_38_0.result) then
			ShowTips(arg_38_0.result)
		end
	end)
end

function var_0_0.ChangeStoryList(arg_39_0, arg_39_1)
	local var_39_0 = {
		story_id = arg_39_0
	}

	if PlayerData:GetStoryList()[arg_39_0] then
		PlayerData:StoryModify(arg_39_0)
		IllustratedAction.ModifyPlot(arg_39_0)

		if arg_39_1 then
			arg_39_1({
				result = 1
			}, var_39_0)
		end
	else
		var_0_0.OnChangeStoryListCallBack = arg_39_1

		manager.net:SendWithLoadingNew(12002, var_39_0, 12003, var_0_0.OnChangeStoryList)
	end
end

function var_0_0.OnChangeStoryList(arg_40_0, arg_40_1)
	PlayerData:StoryModify(arg_40_1.story_id)
	IllustratedAction.ModifyPlot(arg_40_1.story_id)

	if var_0_0.OnChangeStoryListCallBack then
		var_0_0.OnChangeStoryListCallBack(arg_40_0, arg_40_1)

		var_0_0.OnChangeStoryListCallBack = nil
	end
end

function var_0_0.ChangePortrait(arg_41_0)
	manager.net:SendWithLoadingNew(32032, {
		icon_id = arg_41_0
	}, 32033, var_0_0.OnChangePortrait)
end

function var_0_0:OnChangePortrait(arg_42_1)
	if isSuccess(self.result) then
		PlayerData:ChangePortrait(arg_42_1.icon_id)
		manager.notify:CallUpdateFunc(CHANGE_PORTRAIT)
	else
		ShowTips(self.result)
	end
end

function var_0_0.ChangePlayerBirthday(arg_43_0, arg_43_1)
	manager.net:SendWithLoadingNew(12030, {
		month = arg_43_0,
		day = arg_43_1
	}, 12031, var_0_0.OnChangeBirthday)
end

function var_0_0:OnChangeBirthday(arg_44_1)
	if isSuccess(self.result) then
		PlayerData:SetPlayerBirthday(arg_44_1)
		manager.notify:CallUpdateFunc(CHANGE_BIRTHDAY)
	else
		ShowTips(self.result)
	end
end

function var_0_0.ChangeFrameIcon(arg_45_0)
	manager.net:SendWithLoadingNew(32034, {
		iconframe_id = arg_45_0
	}, 32035, var_0_0.OnChangeFrameIcon)
end

function var_0_0:OnChangeFrameIcon(arg_46_1)
	if isSuccess(self.result) then
		PlayerData:ChangeFrameIcon(arg_46_1.iconframe_id)
		manager.notify:CallUpdateFunc(CHANGE_FRAME)
	else
		ShowTips(self.result)
	end
end

function var_0_0:SyncStickerPageUpdateToServer(arg_47_1)
	local var_47_0 = {}

	for iter_47_0, iter_47_1 in pairs(arg_47_1) do
		if self[iter_47_0] then
			local var_47_1 = {
				page_id = iter_47_0,
				foreground = self[iter_47_0].foreground,
				sticker_display_info = {}
			}

			for iter_47_2, iter_47_3 in ipairs(self[iter_47_0].hierarchy) do
				table.insert(var_47_1.sticker_display_info, {
					sticker_id = iter_47_3,
					location_x = self[iter_47_0].sticker[iter_47_3].positionX,
					location_y = self[iter_47_0].sticker[iter_47_3].positionY,
					scale = self[iter_47_0].sticker[iter_47_3].scale,
					layer = iter_47_2,
					rotate = self[iter_47_0].sticker[iter_47_3].rotation
				})
			end

			table.insert(var_47_0, var_47_1)
		end
	end

	if #var_47_0 == 0 then
		return
	end

	PlayerData:SetStickerEditData(self)
	manager.net:Push(32038, {
		sticker_show_info = var_47_0
	})
end

function var_0_0.SyncStickerShowToServer(arg_48_0)
	manager.net:SendWithLoadingNew(32056, {
		page_id = arg_48_0
	}, 32057, function(arg_49_0, arg_49_1)
		if isSuccess(arg_49_0.result) then
			PlayerData:ChangeStickerShow(arg_48_0)
		else
			ShowTips(arg_49_0.result)
		end
	end)
end

function var_0_0.RequestToRewardStickerSuit(arg_50_0)
	manager.net:SendWithLoadingNew(32058, {
		reward_id_list = {
			arg_50_0
		}
	}, 32059, function(arg_51_0, arg_51_1)
		if isSuccess(arg_51_0.result) then
			PlayerData:AddStickerSuitReward(arg_50_0)

			local var_51_0 = mergeReward2(arg_51_0.reward_list or {})

			if #var_51_0 > 0 then
				getReward2(var_51_0)
			end
		else
			ShowTips(arg_51_0.result)
		end
	end)
end

function var_0_0.ReceiveSkinGift(arg_52_0)
	manager.net:SendWithLoadingNew(32052, {
		skin_id = arg_52_0
	}, 32053, var_0_0.OnReceiveSkinGift)
end

function var_0_0:OnReceiveSkinGift(arg_53_1)
	if isSuccess(self.result) then
		PlayerData:ReceiveSkinGift(arg_53_1.skin_id)
		manager.redPoint:setTip(RedPointConst.SKIN_GIFT .. "_" .. arg_53_1.skin_id, 0)
		getReward(formatRewardCfgList(SkinCfg[arg_53_1.skin_id].gift))
		manager.notify:Invoke(GET_SKIN_GIFT)
	else
		ShowTips(self.result)
	end
end

function var_0_0.RefreshSkinGiftRedPoint()
	for iter_54_0, iter_54_1 in ipairs(SkinCfg.all) do
		if #SkinCfg[iter_54_1].gift > 0 and HeroTools.IsSkinUnlock(iter_54_1) then
			if HeroData:GetHeroList()[SkinCfg[iter_54_1].hero].unlock > 0 and PlayerData:IsNotReceived(iter_54_1) then
				manager.redPoint:setTip(RedPointConst.SKIN_GIFT .. "_" .. iter_54_1, 1)
			else
				manager.redPoint:setTip(RedPointConst.SKIN_GIFT .. "_" .. iter_54_1, 0)
			end
		else
			manager.redPoint:setTip(RedPointConst.SKIN_GIFT .. "_" .. iter_54_1, 0)
		end
	end
end

function var_0_0.PlayInfoInit(arg_55_0)
	PlayerData:PlayInfoInit(arg_55_0)
end

function var_0_0:PlayerBrithdayInit()
	PlayerData:SetPlayerBirthday({
		month = self.month,
		day = self.day
	})
end

function var_0_0.SetPlayerIP(arg_57_0)
	PlayerData:SetPlayerIP(arg_57_0)
end

function var_0_0.UserBaseInfoInit(arg_58_0)
	PlayerData:UserBaseInfoInit(arg_58_0)
end

function var_0_0.UserLoginTimestampInit(arg_59_0)
	PlayerData:UserLoginTimestampInit(arg_59_0)
end

function var_0_0.LevelUpFinish(arg_60_0)
	PlayerData:LevelUpFinish(arg_60_0)
end

function var_0_0.ChangeLevel(arg_61_0, arg_61_1)
	PlayerData:ChangeLevel({
		fromLevel = arg_61_0,
		toLevel = arg_61_1
	})
	ActivityNewbieAction.PlayerUpgradeRedPoint()
	BattleStageAction.UpdateSubPlotRedPoint()
	BattleStageAction.UpdateActivityRedPoint()
	EquipSeizureAction.InitRedPointEveryDay()
	BattleEquipAction.UpdateRedPoint()
	DailyNewRedPoint:InitNewTagData()
end

function var_0_0.EXPChange(arg_62_0)
	PlayerData:EXPChange(arg_62_0)
end

function var_0_0.ModifyHeroNick(arg_63_0)
	PlayerData:ModifyHeroNick(arg_63_0)
end

function var_0_0.PlayerOriginalLevel(arg_64_0)
	PlayerData:PlayerOriginalLevel(arg_64_0)
end

function var_0_0.StoryModify(arg_65_0)
	PlayerData:StoryModify(arg_65_0)
end

function var_0_0.StoryInit(arg_66_0)
	PlayerData:StoryInit(arg_66_0)
end

function var_0_0.PlayerShowHeroChange(arg_67_0)
	PlayerData:PlayerShowHeroChange(arg_67_0)
end

function var_0_0:PlayerCardInit()
	PlayerData:PlayerCardInit(self)

	for iter_68_0, iter_68_1 in ipairs((PlayerData:GetStickerList())) do
		if not getData("PlayerCustomStickerTriggered", "StickerItem_" .. iter_68_1) then
			manager.redPoint:setTip(RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. iter_68_1, 1)
		end
	end

	for iter_68_2, iter_68_3 in ipairs((PlayerData:GetStickerBgList())) do
		if not getData("PlayerCustomStickerTriggered", "StickerItem_" .. iter_68_3) then
			manager.redPoint:setTip(RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. iter_68_3, 1)
		end
	end

	for iter_68_4, iter_68_5 in ipairs((PlayerData:GetStickerFgList())) do
		if not getData("PlayerCustomStickerTriggered", "StickerItem_" .. iter_68_5) then
			manager.redPoint:setTip(RedPointConst.CUSTOM_STICKER_ITEM .. "_" .. iter_68_5, 1)
		end
	end

	for iter_68_6, iter_68_7 in ipairs(StickerSuitCfg.all) do
		if PlayerData:CheckStickerSuitReward(iter_68_7) then
			manager.redPoint:setTip(RedPointConst.CUSTOM_STICKER_SUIT_REWARD .. "_" .. iter_68_7, 0)
		else
			local var_68_0 = true

			for iter_68_8, iter_68_9 in ipairs(StickerSuitCfg[iter_68_7].content) do
				if ProfileDecorateItemCfg[iter_68_9].item_type == 4 then
					var_68_0 = PlayerData:GetStickerBg(iter_68_9).lock
				elseif ProfileDecorateItemCfg[iter_68_9].item_type == 5 then
					var_68_0 = PlayerData:GetSticker(iter_68_9).lock
				elseif ProfileDecorateItemCfg[iter_68_9].item_type == 6 then
					var_68_0 = PlayerData:GetStickerFg(iter_68_9).lock
				end

				if var_68_0 then
					manager.redPoint:setTip(RedPointConst.CUSTOM_STICKER_SUIT_REWARD .. "_" .. iter_68_7, 0)

					break
				end
			end

			if not var_68_0 then
				manager.redPoint:setTip(RedPointConst.CUSTOM_STICKER_SUIT_REWARD .. "_" .. iter_68_7, 1)
			end
		end
	end

	local var_68_1 = {
		random_model = 0,
		random_list = {}
	}
	local var_68_2 = {
		show_hero_dressing_scene = false,
		random_model = 0,
		routine_hero_dressing_scene = false,
		random_list = {}
	}

	for iter_68_10, iter_68_11 in ipairs(self.random_info) do
		if iter_68_11.random_type == 2 then
			var_68_1 = iter_68_11
		elseif iter_68_11.random_type == 1 then
			var_68_2 = iter_68_11
		end
	end

	HomeSceneSettingData:InitData(self.poster_background_list, self.poster_background_id, var_68_1)
	PlayerData:SetRandomHeroData(var_68_2)
end

function var_0_0:InitOverdueFrameList()
	PlayerData:InitOverdueFrameList(self.icon_frame_list or {})
end

function var_0_0:InitOverduePortraitList()
	PlayerData:InitOverduePortraitList(self.icon_list or {})
end

function var_0_0:InitOverdueChatBubbleList()
	PlayerData:InitOverdueChatBubbleList(self.chat_bubble_list or {})
end

function var_0_0.PlayerProtraitChange(arg_72_0)
	PlayerData:PlayerProtraitChange(arg_72_0)
end

function var_0_0.UnlockSticker(arg_73_0)
	PlayerData:UnlockSticker(arg_73_0)
end

function var_0_0.UnlockStickerBg(arg_74_0)
	PlayerData:UnlockStickerBg(arg_74_0)
end

function var_0_0.UnlockStickerFg(arg_75_0)
	PlayerData:UnlockStickerFg(arg_75_0)
end

function var_0_0.UnlockPortrait(arg_76_0, arg_76_1)
	PlayerData:UnlockPortrait(arg_76_0, arg_76_1)
end

function var_0_0.UnlockFrame(arg_77_0)
	PlayerData:UnlockFrame(arg_77_0)
end

function var_0_0.LockFrame(arg_78_0, arg_78_1)
	PlayerData:LockFrame(arg_78_1)
end

function var_0_0.OnClientModuleSwitch(arg_79_0)
	PlayerData:InitModuleSwitchData(arg_79_0)
end

function var_0_0.AwakeName(arg_80_0, arg_80_1)
	manager.net:SendWithLoadingNew(23012, {
		nick = arg_80_0
	}, 23013, function(arg_81_0)
		if isSuccess(arg_81_0.result) then
			PlayerData:PlayerNicknameChange(arg_80_0)
			PlayerData:UpdateNameChangeInfo(arg_81_0)
			arg_80_1()
		else
			ShowTips(arg_81_0.result)
		end
	end)
end

function var_0_0.DealOverdueFrame()
	manager.net:SendWithLoadingNew(32040, {}, 32041, var_0_0.OnDealOverdueFrame)
end

function var_0_0:OnDealOverdueFrame(arg_83_1)
	if isSuccess(self.result) then
		-- block empty
	else
		ShowTips(self.result)
	end
end

function var_0_0.DealOverduePortrait()
	manager.net:SendWithLoadingNew(32060, {
		nothing = 0
	}, 32061, var_0_0.OnDealOverduePortraitBack)
end

function var_0_0:OnDealOverduePortraitBack(arg_85_1)
	if isSuccess(self.result) then
		-- block empty
	else
		ShowTips(self.result)
	end
end

function var_0_0.DealOverdueChatBubble()
	manager.net:SendWithLoadingNew(32064, {
		nothing = 0
	}, 32065, var_0_0.OnDealOverdueChatBubbleBack)
end

function var_0_0:OnDealOverdueChatBubbleBack(arg_87_1)
	if isSuccess(self.result) then
		-- block empty
	else
		ShowTips(self.result)
	end
end

function var_0_0.DealOverdueCardBgList()
	manager.net:SendWithLoadingNew(32206, {
		nothing = 0
	}, 32207, var_0_0.OnDealOverdueCardBgList)
end

function var_0_0:OnDealOverdueCardBgList(arg_89_1)
	if isSuccess(self.result) then
		-- block empty
	else
		ShowTips(self.result)
	end
end

function var_0_0.DealOverdueTagList()
	manager.net:SendWithLoadingNew(32208, {
		nothing = 1
	}, 32209, var_0_0.OnDealOverdueTagList)
end

function var_0_0:OnDealOverdueTagList(arg_91_1)
	if isSuccess(self.result) then
		-- block empty
	else
		ShowTips(self.result)
	end
end

function var_0_0.ReadUnclaimedMessage(arg_92_0)
	manager.net:SendWithLoadingNew(12024, {
		id = arg_92_0
	}, 12025, var_0_0.OnReadUnclaimedMessageCallback)
end

function var_0_0:OnReadUnclaimedMessageCallback(arg_93_1)
	if isSuccess(self.result) then
		PlayerData:ReadUnclaimed(arg_93_1.id)
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.CheckRecommendEquip(arg_94_0, arg_94_1)
	manager.net:SendWithLoadingNew(32042, {
		role_id = arg_94_0
	}, 32043, function(arg_95_0)
		if isSuccess(arg_95_0.result) then
			if arg_94_1 then
				arg_94_1()
			end
		else
			ShowTips(GetTips(arg_95_0.result))
		end
	end)
end

function var_0_0.CheckHeroVoice(arg_96_0, arg_96_1)
	manager.net:SendWithLoadingNew(32044, {
		role_id = arg_96_0
	}, 32045, function(arg_97_0)
		if isSuccess(arg_97_0.result) then
			if arg_96_1 then
				arg_96_1()
			end
		else
			ShowTips(GetTips(arg_97_0.result))
		end
	end)
end

function var_0_0.ChangeCardBg(arg_98_0)
	manager.net:SendWithLoadingNew(32114, {
		id = arg_98_0
	}, 32115, var_0_0.OnChangeCardBg)
end

function var_0_0:OnChangeCardBg(arg_99_1)
	if isSuccess(self.result) then
		PlayerData:SetCardBg(arg_99_1.id)
		manager.notify:CallUpdateFunc(CHANGE_CARD_BG, arg_99_1.id)
	else
		ShowTips(self.result)
	end
end

function var_0_0.ChangTagList(arg_100_0)
	local var_100_0 = {}
	local var_100_1 = manager.time:GetServerTime()

	for iter_100_0, iter_100_1 in ipairs(arg_100_0) do
		local var_100_2 = PlayerData:GetTagInfo(iter_100_1)

		if var_100_2.lasted_time == 0 or var_100_1 < var_100_2.lasted_time then
			table.insert(var_100_0, iter_100_1)
		end
	end

	manager.net:SendWithLoadingNew(32116, {
		tags = var_100_0
	}, 32117, var_0_0.OnChangTagList)
end

function var_0_0:OnChangTagList(arg_101_1)
	if isSuccess(self.result) then
		PlayerData:SetUsingTagList(arg_101_1.tags)
		manager.notify:CallUpdateFunc(CHANGE_TAG_LIST)
	else
		ShowTips(self.result)
	end
end

var_0_0.SendLikeSrc = {
	MidAutumnActivity = 5,
	MultiPlayerGameRoom = 1,
	MultiPlayerGameResult = 2,
	AddFriend = 0,
	DormInfo = 4,
	PlayerInfo = 3,
	Activity = 6,
	IdolDanceGame = 7
}

function var_0_0.SendLike(arg_102_0, arg_102_1, arg_102_2)
	manager.net:SendWithLoadingNew(32118, {
		uid = arg_102_0,
		source = arg_102_1,
		activity_id = arg_102_2 or 0
	}, 32119, var_0_0.OnSendLike)
end

function var_0_0:OnSendLike(arg_103_1)
	if isSuccess(self.result) then
		ForeignInfoData:OnSendLike()
		PlayerData:OnSendLike(arg_103_1.uid)
		manager.notify:CallUpdateFunc(SEND_LIKE)
	else
		ShowTips(self.result)
	end
end

function var_0_0.ChangeChatBubble(arg_104_0, arg_104_1)
	manager.net:SendWithLoadingNew(32120, {
		chat_bubble = arg_104_0
	}, 32121, function(arg_105_0)
		if isSuccess(arg_105_0.result) then
			PlayerData:SetCurChatBubbleID(arg_104_0)
			arg_104_1()
		else
			ShowTips(arg_105_0.result)
		end
	end)
end

function var_0_0.InitChatBubbleRedPoint()
	for iter_106_0, iter_106_1 in ipairs(PlayerData:GetUnlockChatBubbleIDList()) do
		if iter_106_1 ~= GameSetting.profile_chat_bubble_default.value[1] then
			RedPointData:GetIsRedPointOpen(RedPointConst.CHAT_BUBBLE_RANGE + iter_106_1)
		end
	end
end

function var_0_0.UseStoryTrigger(arg_107_0, arg_107_1, arg_107_2, arg_107_3)
	manager.net:Push(81002, {
		trigger_id = arg_107_0,
		trigger_story = arg_107_1,
		trigger_text = arg_107_2,
		trigger_select = arg_107_3
	})
	PlayerData:AddPlayerStoryTrigger(arg_107_0)
end

function var_0_0.UploadRandomSceneGirlSetting(arg_108_0, arg_108_1, arg_108_2)
	local var_108_0 = {
		random_info_list = {}
	}

	if arg_108_0 then
		table.insert(var_108_0.random_info_list, arg_108_0)
	end

	if arg_108_1 then
		table.insert(var_108_0.random_info_list, arg_108_1)
	end

	for iter_108_0, iter_108_1 in ipairs(var_108_0.random_info_list) do
		iter_108_1.show_hero_dressing_scene = iter_108_1.show_hero_dressing_scene and 1 or 0
		iter_108_1.routine_hero_dressing_scene = iter_108_1.routine_hero_dressing_scene and 1 or 0
	end

	manager.net:SendWithLoadingNew(32122, var_108_0, 32123, arg_108_2)
end

function var_0_0.SetIsRandomHero(arg_109_0, arg_109_1)
	manager.net:SendWithLoadingNew(32124, {
		type = 1,
		model = PlayerTools.MakeRandomModeData(arg_109_0, PlayerData:GetRandomHeroMode())
	}, 32125, function(arg_110_0)
		if isSuccess(arg_110_0.result) then
			PlayerData:SetIsRandomHero(arg_109_0)
			arg_109_1()
		else
			ShowTips(arg_110_0.result)
		end
	end)
end

function var_0_0.SetRandomHeroMode(arg_111_0, arg_111_1)
	manager.net:SendWithLoadingNew(32124, {
		type = 1,
		model = PlayerTools.MakeRandomModeData(PlayerData:IsRandomHero(), arg_111_0)
	}, 32125, function(arg_112_0)
		if isSuccess(arg_112_0.result) then
			PlayerData:SetRandomHeroMode(arg_111_0)
			arg_111_1()
			manager.notify:Invoke(CUSTOM_CENTER_SWITCH_RANDOM_MODE)
		else
			ShowTips(arg_112_0.result)
		end
	end)
end

function var_0_0.SetRandomHeroList(arg_113_0, arg_113_1)
	manager.net:SendWithLoadingNew(32130, {
		type = 1,
		random_list = arg_113_0
	}, 32131, function(arg_114_0)
		if isSuccess(arg_114_0.result) then
			PlayerData:SetRandomHeroList(arg_113_0)
			arg_113_1()
		else
			ShowTips(arg_114_0.result)
		end
	end)
end

function var_0_0.SetIsRandomHeroUseDlcScene(arg_115_0, arg_115_1)
	manager.net:SendWithLoadingNew(32126, {
		type = 1,
		show_hero_dressing_scene = arg_115_0
	}, 32127, function(arg_116_0)
		if isSuccess(arg_116_0.result) then
			PlayerData:SetIsRandomHeroUseDlcScene(arg_115_0)
			HomeSceneSettingData:SetIsUseDlcScene(arg_115_0)
			arg_115_1()
		else
			ShowTips(arg_116_0.result)
		end
	end)
end

function var_0_0.SetIsRandomHeroShowEachDebutAnim(arg_117_0, arg_117_1)
	manager.net:SendWithLoadingNew(32128, {
		type = 1,
		routine_hero_dressing_scene = arg_117_0 and 1 or 0
	}, 32129, function(arg_118_0)
		if isSuccess(arg_118_0.result) then
			PlayerData:SetIsRandomHeroShowEachDebutAnim(arg_117_0)
			arg_117_1()
		else
			ShowTips(arg_118_0.result)
		end
	end)
end

function var_0_0.SaveHeroSkinIDAndSceneID(arg_119_0, arg_119_1)
	manager.net:Push(32132, {
		hero_id = arg_119_0,
		background_id = arg_119_1
	})
end

function var_0_0:SetPureModeSetting(arg_120_1)
	manager.net:SendWithLoadingNew(32068, {
		info = {
			pattern_id = self.randomModeIndex,
			pattern_scope = self.randomModeRangeIndex,
			switch_frequency = self.randomTimeIndex,
			entry_time = self.pureModeTimeIndex
		}
	}, 32069, function(arg_121_0, arg_121_1)
		if isSuccess(arg_121_0.result) then
			PlayerData:SetPureModeData(arg_121_1.info)
			manager.notify:Invoke(PURE_MODE_SETTING)
			manager.notify:Invoke(PURE_MODE_TIME_SET)

			if arg_120_1 then
				arg_120_1()
			end
		else
			ShowTips(arg_121_0.result)
		end
	end)
end

function var_0_0.SetPureModeComponent(arg_122_0, arg_122_1)
	local var_122_0 = {}

	for iter_122_0, iter_122_1 in ipairs(arg_122_0 or {}) do
		table.insert(var_122_0, {
			module_id = iter_122_0,
			module_location_x = iter_122_1.positionX,
			module_location_y = iter_122_1.positionY,
			module_size = iter_122_1.scale
		})
	end

	manager.net:SendWithLoadingNew(32070, {
		module = var_122_0
	}, 32071, function(arg_123_0, arg_123_1)
		if isSuccess(arg_123_0.result) then
			PlayerData:SetPureModeComponentData(arg_123_1.module)
			manager.notify:Invoke(PURE_MODE_EDITOR, false, true)
			ShowTips("PURE_MODE_SAVE_SUCCESS")

			if arg_122_1 then
				arg_122_1()
			end
		else
			ShowTips(arg_123_0.result)
		end
	end)
end

return var_0_0

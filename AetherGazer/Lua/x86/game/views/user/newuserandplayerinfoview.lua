local var_0_0 = class("NewUserAndPlayerInfoView", ReduxView)
local var_0_1 = 1
local var_0_2 = 860

function var_0_0.UIName(arg_1_0)
	return "Widget/System/UserInfor/UserInfoUInew"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.bgImg_.immediate = true

	local var_4_0 = GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV or not SDKTools.GetIsOverSea() and _G.CHANNEL_MASTER_ID ~= 1

	SetActive(arg_4_0.userCenterBtn_.gameObject, not var_4_0)
	SetActive(arg_4_0.logoutBtn_.gameObject, var_4_0)
	SetActive(arg_4_0.logoffBtn_.gameObject, var_4_0)

	arg_4_0.curTagList_ = {}
	arg_4_0.tagItem_ = {}
	arg_4_0.tagContentFitter_ = arg_4_0.tagScrollPanel_:GetComponent("ContentSizeFitter")
	arg_4_0.tagCon_ = ControllerUtil.GetController(arg_4_0.transform_, "tag")
	arg_4_0.likeCon_ = ControllerUtil.GetController(arg_4_0.transform_, "like")
	arg_4_0.dormCon_ = ControllerUtil.GetController(arg_4_0.transform_, "dorm")
	arg_4_0.guildCon_ = ControllerUtil.GetController(arg_4_0.transform_, "guild")
	arg_4_0.onlineCon_ = ControllerUtil.GetController(arg_4_0.transform_, "online")
	arg_4_0.newFriendCon_ = ControllerUtil.GetController(arg_4_0.transform_, "newFriend")
	arg_4_0.friendStateCon_ = ControllerUtil.GetController(arg_4_0.transform_, "friendState")
	arg_4_0.stateCon_ = ControllerUtil.GetController(arg_4_0.transform_, "state")
	arg_4_0.systemCon_ = ControllerUtil.GetController(arg_4_0.transform_, "system")
	arg_4_0.signCon_ = arg_4_0.transform_:GetComponent("ControllerExCollection"):GetController("sign")
	arg_4_0.cardBgCon_ = arg_4_0.transform_:GetComponent("ControllerExCollection"):GetController("bgType")
	arg_4_0.tagSelectPanel_ = TagView.New(arg_4_0.tagSelectPanelGo_)

	arg_4_0.tagSelectPanel_:RegisterClickFunction(handler(arg_4_0, arg_4_0.TagSelectCallback))

	arg_4_0.headPortrait = CommonHeadPortrait.New(arg_4_0.portraitObj_)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.nameBtn_, nil, function()
		if table.keyof(arg_5_0.operationInfo_, OperationConst.CHANGE_NICK) ~= nil then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		JumpTools.OpenPageByJump("changeName")
	end)
	arg_5_0:AddBtnListener(arg_5_0.changeNameBtn_, nil, function()
		if table.keyof(arg_5_0.operationInfo_, OperationConst.CHANGE_NICK) ~= nil then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		JumpTools.OpenPageByJump("changeName")
	end)
	arg_5_0:AddBtnListener(arg_5_0.signBtn_, nil, function()
		arg_5_0.signInput_.text = arg_5_0.sign_

		SetActive(arg_5_0.signInput_.gameObject, true)
		arg_5_0.signInput_:ActivateInputField()
		SetActive(arg_5_0.signTxt_.gameObject, false)
	end)
	arg_5_0.signInput_.onEndEdit:AddListener(function()
		if table.keyof(arg_5_0.operationInfo_, OperationConst.CHANGE_SIGN) ~= nil then
			ShowTips("ERROR_FUNCTION_STOP")
			SetActive(arg_5_0.signInput_.gameObject, false)
			SetActive(arg_5_0.signTxt_.gameObject, true)

			return
		end

		local var_9_0 = arg_5_0.signInput_.text

		if var_9_0 ~= nil and var_9_0 ~= "" and arg_5_0.sign_ == var_9_0 then
			SetActive(arg_5_0.signInput_.gameObject, false)
			SetActive(arg_5_0.signTxt_.gameObject, true)

			return
		end

		local var_9_1, var_9_2 = textLimit(var_9_0, GameSetting.personal_signature_max.value[1])
		local var_9_3 = var_9_1

		if not var_9_2 then
			ShowTips("PERSONAL_SIGNATURE_MAX")
			SetActive(arg_5_0.signInput_.gameObject, false)
			SetActive(arg_5_0.signTxt_.gameObject, true)

			return
		end

		WordVerifyBySDK(var_9_3, function(arg_10_0)
			local var_10_0 = PlayerData:GetPlayerInfo()

			if not arg_10_0 then
				ShowTips("SENSITIVE_WORD")
				arg_5_0:RefreshSign(var_10_0.sign)
				SetActive(arg_5_0.signInput_.gameObject, false)
				SetActive(arg_5_0.signTxt_.gameObject, true)

				return
			end

			if var_10_0.sign == var_9_3 then
				SetActive(arg_5_0.signInput_.gameObject, false)
				SetActive(arg_5_0.signTxt_.gameObject, true)

				return
			end

			local var_10_1 = false

			if var_9_3:find("\n") then
				var_9_3 = string.gsub(var_9_3, "\n", "")
				var_10_1 = true
			end

			PlayerAction.ChangeSign(var_9_3, var_10_1)
		end, JUDGE_MESSAGE_TYPE.PLAYER_SIGN)
	end)
	arg_5_0:AddBtnListener(arg_5_0.logoutBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("TIP_EXIT_GAME"),
			OkCallback = function()
				OperationRecorder.Record("account_change", "account_change_confirm")
				BulletinData.OnLogout()
				manager.rollTips:OnLogout()
				GameToSDK.Logout()
			end,
			CancelCallback = function()
				OperationRecorder.Record("account_change", "account_change_cancel")
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.userCenterBtn_, nil, function()
		NeedGameUserInfo()
		GameToSDK.GoUserCenter()
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 2,
			direction_channel = 4
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.logoffBtn_, nil, function()
		GameToSDK.LogOff()
	end)
	arg_5_0:AddBtnListener(arg_5_0.servantbtnBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("userinfo_spirit")
		JumpTools.OpenPageByJump("/illuServantManual")
	end)
	arg_5_0:AddBtnListener(arg_5_0.illustratedAchievementBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("userinfo_achievement")

		if manager.windowBar:GetWhereTag() ~= nil then
			return
		end

		JumpTools.GoToSystem("/achievementManager", nil, ViewConst.SYSTEM_ID.ACHIEVEMENT)
	end)
	arg_5_0.headPortrait:RegisteClickCallback(function()
		if arg_5_0.isForeign_ then
			return
		end

		OperationRecorder.RecordButtonTouch("userinfo_headportrait")
		JumpTools.OpenPageByJump("HeadIconChange", {
			isEnter = true
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.brithdayBtn_, nil, function()
		JumpTools.OpenPageByJump("BirthdayView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.tagBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("userinfo_usertag")
		arg_5_0:ShowTagView()
	end)
	arg_5_0:AddBtnListener(arg_5_0.hideTagBtn_, nil, function()
		arg_5_0:HideTagView()
		PlayerAction.ChangTagList(arg_5_0.curTagList_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.likeBtn_, nil, function()
		if not arg_5_0.isForeign_ then
			JumpTools.OpenPageByJump("likeInfoPop", {
				index = 1
			})
		else
			if table.indexof(arg_5_0.todaySendLike_, arg_5_0.userID_) or #arg_5_0.todaySendLike_ >= GameSetting.profile_like_limitation.value[1] then
				ShowTips("PROFILE_LIKE_REPEAT_PROMPT")

				return
			end

			PlayerAction.SendLike(arg_5_0.userID_, PlayerAction.SendLikeSrc.PlayerInfo)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.copyBtn_, nil, function()
		UnityEngine.GUIUtility.systemCopyBuffer = arg_5_0.userID_

		ShowTips("COPY_SUCCESS")
	end)
	arg_5_0:AddBtnListener(arg_5_0.illustratedStickerBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("userinfo_sticker")

		if arg_5_0.isForeign_ then
			JumpTools.OpenPageByJump("/customStickerMain", {
				foreign = arg_5_0.stickerList_
			})
		else
			JumpTools.OpenPageByJump("/customStickerMain")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.illustratedHeroBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("userinfo_hero")

		local var_25_0

		if not arg_5_0.isForeign_ then
			var_25_0 = var_0_0.GetUserHeroShowDataList
		end

		JumpTools.OpenPageByJump("showHeroPop", {
			userID = arg_5_0.userID_,
			isForeign = arg_5_0.isForeign_,
			heroList = arg_5_0.heroList_,
			heroListGetter = var_25_0
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.dormBtn_, nil, function()
		if manager.windowBar:GetWhereTag() ~= nil then
			return
		end

		if not arg_5_0.isForeign_ then
			if arg_5_0.dormID_ == 0 then
				local var_26_0 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM)

				ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.DORM, var_26_0))
			else
				local var_26_1 = GameDisplayCfg.dorm_begin_story.value[1]

				if var_26_1 and not manager.story:IsStoryPlayed(var_26_1) then
					manager.story:StartStoryById(var_26_1, function(arg_27_0)
						JumpTools.OpenPageByJump("/dormChooseRoomView")
					end)
				elseif BackHomeCfg[arg_5_0.dormID_].type == DormConst.BACKHOME_TYPE.PublicDorm then
					BackHomeTools:GotoBackHomeRoom(DormConst.PUBLIC_DORM_ID)
				else
					BackHomeTools:GotoBackHomeRoom(arg_5_0.dormID_)
				end
			end
		else
			if not arg_5_0.dormID_ or arg_5_0.dormID_ == 0 then
				ShowTips("PLAYER_DORM_LOCK")

				return
			end

			DormVisitTools:SetIsOtherSystem(true)
			DormVisitTools:SetBackFunc(function()
				OpenPageUntilLoaded("/playerinfo", {
					isForeign = arg_5_0.isForeign_
				})
			end)
			SDKTools.SendMessageToSDK("backhome_dorm_visit_jump", {
				backhome_source = 1
			})
			DormAction:OtherSystemAskSingleFurTemplateExhibit(arg_5_0.userID_)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.guildBtn_, nil, function()
		if JumpTools.IsSystemOperationStoped(ViewConst.SYSTEM_ID.GUILD) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		local var_29_0 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.GUILD)

		if not arg_5_0.isForeign_ and var_29_0 then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.GUILD, var_29_0))

			return
		end

		if GuildData.IsGuildValid(arg_5_0.guildID_) then
			ForeignInfoAction:SearchGuildInfo(arg_5_0.guildID_, 1)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.buttonAdd_, nil, function()
		if arg_5_0.newFriendCon_:GetSelectedState() == "1" then
			ShowTips("PROFILE_FRIENDS_APPLYING")

			return
		end

		FriendsAction:TryToRequestToFriend(arg_5_0.userID_, FriendConst.ADD_FRIEND_SOURCE.PLAYER_INFO)
		arg_5_0.newFriendCon_:SetSelectedState(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.buttonTalk_, nil, function()
		if not FriendsData:GetFreshFlag() then
			FriendsAction:TryToRefreshFriendsView(1, function()
				ChatFriendData:AddCacheFriend(arg_5_0.userID_)
				JumpTools.OpenPageByJump("chat", {
					ignoreBG = true,
					chatToggleID = ChatConst.CHAT_CHANNEL_FRIEND,
					friendID = arg_5_0.userID_
				}, ViewConst.SYSTEM_ID.CHAT)
			end)

			return
		end

		ChatFriendData:AddCacheFriend(arg_5_0.userID_)
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_FRIEND,
			friendID = arg_5_0.userID_
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	arg_5_0:AddBtnListener(arg_5_0.buttonDeleteFriend_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("FRIEND_DELETE_QUEST"), arg_5_0.nick_),
			OkCallback = function()
				FriendsAction:TryToDelectFromMyFriendsList(arg_5_0.userID_)
				arg_5_0:Back()
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.buttonMore_, nil, function()
		if arg_5_0.isPop_ then
			arg_5_0.isPop_ = false

			arg_5_0:HidePop()

			return
		end

		SetActive(arg_5_0.goPop_, true)
		arg_5_0:AddClickTimer()

		arg_5_0.isPop_ = true
	end)
	arg_5_0:AddBtnListener(arg_5_0.buttonReport_, nil, function()
		JumpTools.OpenPageByJump("chatReport", {
			reportType = ChatConst.CHAT_REPORT_TYPE.USER,
			reportData = {
				nick = arg_5_0.nick_,
				userID = arg_5_0.userID_
			}
		}, ViewConst.SYSTEM_ID.CHAT_REPORT)
	end)
	arg_5_0:AddBtnListener(arg_5_0.buttonBlackList_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("FRIEND_MOVE_TO_BLACLIST_QUEST"), arg_5_0.nick_),
			OkCallback = function()
				FriendsAction:TryToAddToBlacklist(arg_5_0.userID_)
				arg_5_0:Back()
			end
		})
	end)
end

local function var_0_3()
	local var_39_0 = ForeignInfoData:GetCurForeignDetailInfo()
	local var_39_1 = var_39_0.post_background_id

	if HomeSceneSettingCfg[var_39_1].limit_display == 0 then
		local var_39_2 = CustomCenterTools.GetMatchSkinByScene(var_39_1)

		if var_39_2 and var_39_2 ~= var_39_0.postGril then
			print("好友dlc场景和角色不匹配! 替换为默认场景")

			local var_39_3 = GameSetting.home_sence_default.value

			var_39_1 = var_39_3[#var_39_3]
		end
	end

	if var_39_1 == 0 then
		var_39_1 = GameSetting.home_sence_default.value[2]
	end

	return var_39_1
end

function var_0_0.ReserveCameraEnter(arg_40_0)
	if arg_40_0.params_.maskScene then
		return
	end

	local var_40_0

	if arg_40_0.params_.isForeign then
		var_40_0 = var_0_3()
	else
		var_40_0 = HomeSceneSettingData:GetCurScene()
	end

	local var_40_1 = manager.loadScene:GetHomeShouldLoadSceneName(var_40_0)

	manager.loadScene:SetSceneActive(var_40_1, true)
end

function var_0_0.OnEnter(arg_41_0)
	arg_41_0.isForeign_ = arg_41_0.params_.isForeign

	SetActive(arg_41_0.likeAddGo_, false)
	arg_41_0:HideTagView()
	arg_41_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_42_0)
	if not arg_42_0.isForeign_ then
		arg_42_0.stateCon_:SetSelectedState("user")
		arg_42_0.signCon_:SetSelectedIndex(1)
		arg_42_0:BindRedPoint()

		arg_42_0.operationInfo_ = OperationData:GetOperationOpenList()

		arg_42_0:RefreshUserData()
		arg_42_0:RefreshExpInfo(arg_42_0.lv_, arg_42_0.exp_)
	else
		arg_42_0.stateCon_:SetSelectedState("player")
		arg_42_0:HidePop()
		arg_42_0:RefreshPlayerData()
		arg_42_0:RefreshFriendState()
		arg_42_0:RefreshOnlineState()

		local var_42_0 = FriendsData:IsFriend(arg_42_0.userID_)

		arg_42_0.signCon_:SetSelectedIndex(var_42_0 and 1 or 0)
	end

	arg_42_0:RefreshSystem()
	arg_42_0:RefreshBtn()
	arg_42_0:RefreshIP(arg_42_0.ip_)
	arg_42_0:RefreshID(arg_42_0.userID_)
	arg_42_0:RefreshName(arg_42_0.nick_)
	SetActive(arg_42_0.signInput_.gameObject, false)
	SetActive(arg_42_0.signTxt_.gameObject, true)
	arg_42_0:RefreshSign(arg_42_0.sign_)
	arg_42_0:RefreshLvInfo(arg_42_0.lv_)
	arg_42_0:RefreshHead(arg_42_0.headIconID_)
	arg_42_0:RefreshFrame(arg_42_0.iconFrameID_)
	arg_42_0:RefreshGuild(arg_42_0.guildID_, arg_42_0.guildName_, arg_42_0.guildIcon_)
	arg_42_0:RefreshBirthday()
	arg_42_0:RefreshTag(arg_42_0.tagList_)
	arg_42_0:RefreshCardBg(arg_42_0.cardBg_)
	arg_42_0:RefreshDorm(arg_42_0.dormID_, arg_42_0.dormName_)
	arg_42_0:RefreshAchievement()
	arg_42_0:RefreshLike(arg_42_0.likeCnt_)

	if not arg_42_0.params_.maskScene then
		arg_42_0:RefreshGirl(arg_42_0.postGirl_)
		arg_42_0:RefreshScene()
	end

	arg_42_0:RefreshBgImage()
end

function var_0_0.GetUserHeroShowDataList()
	local var_43_0 = PlayerData:GetHeroShowList()
	local var_43_1 = {}

	for iter_43_0, iter_43_1 in ipairs(var_43_0) do
		local var_43_2 = HeroData:GetHeroData(iter_43_1)
		local var_43_3 = {
			hero_id = iter_43_1,
			star = var_43_2.star,
			level = var_43_2.level,
			using_skin = var_43_2.using_skin
		}

		var_43_3.oath = nil
		var_43_1[iter_43_0] = var_43_3
	end

	return var_43_1
end

function var_0_0.GetForeignPlayerShowHeroDataList()
	local var_44_0 = ForeignInfoData:GetCurForeignDetailInfo()
	local var_44_1 = var_44_0.hero_list
	local var_44_2 = var_44_0.hero_oath_display
	local var_44_3 = {}

	for iter_44_0, iter_44_1 in ipairs(var_44_1) do
		local var_44_4 = {
			hero_id = iter_44_1.hero_id,
			star = iter_44_1.star
		}

		var_44_4.level = 0
		var_44_4.using_skin = iter_44_1.using_skin
		var_44_4.oath = nullable(var_44_2, iter_44_1.hero_id, "oath")
		var_44_3[iter_44_0] = var_44_4
	end

	return var_44_3
end

function var_0_0.RefreshUserData(arg_45_0)
	local var_45_0 = PlayerData:GetPlayerInfo()

	arg_45_0.ip_ = var_45_0.ip
	arg_45_0.nick_ = var_45_0.nick
	arg_45_0.sign_ = var_45_0.sign
	arg_45_0.lv_ = var_45_0.userLevel
	arg_45_0.userID_ = var_45_0.userID
	arg_45_0.exp_ = var_45_0.remain_exp
	arg_45_0.headIconID_ = var_45_0.portrait
	arg_45_0.iconFrameID_ = var_45_0.icon_frame
	arg_45_0.birthdayMonth_ = var_45_0.birthday_month
	arg_45_0.birthdayDay_ = var_45_0.birthday_day
	arg_45_0.likeCnt_ = var_45_0.likes
	arg_45_0.cardBg_ = var_45_0.card_bg_id
	arg_45_0.tagList_ = PlayerData:GetUsingTagListInfo()

	local var_45_1 = var_45_0.poster_girl

	arg_45_0.postGirl_ = HeroTools.HeroUsingSkinInfo(var_45_1).id

	local var_45_2 = GuildData:GetGuildInfo()

	if var_45_2 and var_45_2.id and var_45_2.name then
		arg_45_0.guildID_ = var_45_2.id
		arg_45_0.guildName_ = var_45_2.name
		arg_45_0.guildIcon_ = var_45_2.icon
	else
		arg_45_0.guildID_ = GuildData.INVALID_GUILD
		arg_45_0.guildName_ = ""
		arg_45_0.guildIcon_ = 0
	end

	arg_45_0.dormID_ = 0
	arg_45_0.dormName_ = ""

	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		local var_45_3 = DormVisitTools:GetCurTemplateExhibit()

		arg_45_0.dormID_ = var_45_3 == 0 and DormConst.PUBLIC_DORM_ID or var_45_3

		if BackHomeCfg[arg_45_0.dormID_].type == DormConst.BACKHOME_TYPE.PublicDorm then
			arg_45_0.dormName_ = GetTips("DORM_LOBBY_NAME")
		else
			local var_45_4 = DormitoryData:GetDormSceneData(arg_45_0.dormID_).archiveIDList[1]
			local var_45_5 = HeroRecordCfg.get_id_list_by_hero_id[var_45_4][1]

			if var_45_5 then
				local var_45_6 = GetI18NText(HeroRecordCfg[var_45_5].name)

				if var_45_6 then
					arg_45_0.dormName_ = string.format(GetTips("DORM_HERO_ROOM_NAME"), var_45_6)
				end
			end
		end
	end

	arg_45_0.heroList_ = var_0_0.GetUserHeroShowDataList()
	arg_45_0.stickerList_ = var_45_0.sticker_show_info
	arg_45_0.stickerBg_ = var_45_0.sticker_background
	arg_45_0.heroNum_ = HeroTools.GetFilteredHeroNum(HeroTools.FilterHeroFunc.ObtainedNotHide)
	arg_45_0.heroAll_ = HeroTools.GetFilteredHeroNum(HeroTools.FilterHeroFunc.AllNotHide)
	arg_45_0.weaponServantAll_ = 0
	arg_45_0.weaponServantNum_ = table.length(IllustratedData:GetServantInfo())

	for iter_45_0, iter_45_1 in ipairs(WeaponServantCfg.all) do
		local var_45_7 = IllustratedData:GetServantInfo()[iter_45_1]

		if not ServantTools.GetIsHide(iter_45_1) and (var_45_7 or WeaponServantCfg[iter_45_1].display_type ~= 1) then
			arg_45_0.weaponServantAll_ = arg_45_0.weaponServantAll_ + 1
		end
	end

	arg_45_0.stickerAll_ = #PlayerData:GetStickerList(true) + #PlayerData:GetStickerBgList(true) + #PlayerData:GetStickerFgList(true)
	arg_45_0.stickerNum_ = #PlayerData:GetStickerList() + #PlayerData:GetStickerBgList() + #PlayerData:GetStickerFgList()
	arg_45_0.achieveAll_ = AchievementData:GetAchievementTotalCnt()
	arg_45_0.achieveNum_ = AchievementData:GetFinishAchievementCnt()
end

function var_0_0.RefreshPlayerData(arg_46_0)
	local var_46_0 = ForeignInfoData:GetCurForeignDetailInfo()

	arg_46_0.ip_ = var_46_0.ip
	arg_46_0.nick_ = var_46_0.nick
	arg_46_0.sign_ = var_46_0.sign
	arg_46_0.lv_ = var_46_0.level
	arg_46_0.userID_ = var_46_0.user_id
	arg_46_0.headIconID_ = var_46_0.icon
	arg_46_0.iconFrameID_ = var_46_0.icon_frame
	arg_46_0.isOnline_ = var_46_0.is_online
	arg_46_0.likeCnt_ = var_46_0.likes
	arg_46_0.cardBg_ = var_46_0.card_bg_id
	arg_46_0.tagList_ = var_46_0.used_tag_list
	arg_46_0.postGirl_ = var_46_0.postGril
	arg_46_0.hero_oath_display = var_46_0.hero_oath_display
	arg_46_0.guildID_ = var_46_0.guildID
	arg_46_0.guildName_ = var_46_0.guildName
	arg_46_0.guildIcon_ = var_46_0.guildIcon
	arg_46_0.dormID_ = var_46_0.backhome_architecture_id
	arg_46_0.dormName_ = ""

	if arg_46_0.dormID_ ~= 0 then
		if BackHomeCfg[arg_46_0.dormID_].type == DormConst.BACKHOME_TYPE.PublicDorm then
			arg_46_0.dormName_ = GetTips("DORM_LOBBY_NAME")
		else
			local var_46_1 = var_46_0.hero_id_list
			local var_46_2 = HeroRecordCfg.get_id_list_by_hero_id[var_46_1[1]][1]

			arg_46_0.dormName_ = string.format(GetTips("DORM_HERO_ROOM_NAME"), GetI18NText(HeroRecordCfg[var_46_2].name))
		end
	end

	arg_46_0.heroList_ = var_0_0.GetForeignPlayerShowHeroDataList()
	arg_46_0.stickerList_ = var_46_0.sticker_show_info
	arg_46_0.stickerBg_ = var_46_0.sticker_background

	local var_46_3 = var_46_0.hero_static_info

	arg_46_0.heroNum_ = var_46_3.not_hide_num
	arg_46_0.heroAll_ = HeroTools.GetFilteredHeroNum(HeroTools.FilterHeroFunc.All)
	arg_46_0.heroAll_ = arg_46_0.heroAll_ - var_46_3.cfg_hide_num

	local var_46_4 = var_46_0.weapon_servant_static_info

	arg_46_0.weaponServantNum_ = var_46_4.not_hide_num
	arg_46_0.weaponServantAll_ = #WeaponServantCfg.all - var_46_4.cfg_hide_num

	local var_46_5 = var_46_0.sticker_static_info
	local var_46_6 = var_46_0.sticker_background_static_info
	local var_46_7 = var_46_0.sticker_foreground_static_info

	arg_46_0.stickerNum_ = var_46_5.not_hide_num + var_46_6.not_hide_num + var_46_7.not_hide_num

	local var_46_8 = var_46_5.cfg_hide_num + var_46_6.cfg_hide_num + var_46_6.cfg_hide_num

	arg_46_0.stickerAll_ = #ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.STICKER] + #ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.STICKER_BG] + #ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.STICKER_FG]
	arg_46_0.stickerAll_ = arg_46_0.stickerAll_ - var_46_8

	local var_46_9 = var_46_0.achievement_static_info

	arg_46_0.achieveNum_ = var_46_9.not_hide_num
	arg_46_0.achieveAll_ = #AchievementCfg.all
	arg_46_0.achieveAll_ = arg_46_0.achieveAll_ - var_46_9.cfg_hide_num
	arg_46_0.todaySendLike_ = PlayerData:GetTodaySendLikeList() or {}
end

function var_0_0.RefreshSystem(arg_47_0)
	arg_47_0.systemCon_:SetSelectedState(manager.windowBar:GetWhereTag() == nil and "on" or "off")
end

function var_0_0.RefreshBtn(arg_48_0)
	arg_48_0.signBtn_.interactable = not arg_48_0.isForeign_
	arg_48_0.nameBtn_.interactable = not arg_48_0.isForeign_
	arg_48_0.changeNameBtn_.interactable = not arg_48_0.isForeign_
	arg_48_0.servantbtnBtn_.interactable = not arg_48_0.isForeign_
	arg_48_0.illustratedAchievementBtn_.interactable = not arg_48_0.isForeign_
end

function var_0_0.RefreshExpInfo(arg_49_0, arg_49_1, arg_49_2)
	if LvTools.GetIsMaxLv(arg_49_1, "user") then
		arg_49_0.expTxt_.text = "-/-"
		arg_49_0.progressTrs_.value = 1
	else
		local var_49_0 = GameLevelSetting[arg_49_1].user_level_exp

		arg_49_0.expTxt_.text = string.format("%d/%d", arg_49_2, var_49_0)
		arg_49_0.progressTrs_.value = arg_49_2 / var_49_0
	end
end

function var_0_0.RefreshFriendState(arg_50_0)
	local var_50_0 = FriendsData:GetInfoByID(arg_50_0.userID_)

	if var_50_0 then
		local var_50_1 = var_50_0.relationship

		if var_50_1 == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
			arg_50_0.friendStateCon_:SetSelectedState("myFriend")
		elseif var_50_1 == FriendsConst.FRIEND_TYPE.NEW_FRIENDS or var_50_1 == FriendsConst.FRIEND_TYPE.SEARCH then
			arg_50_0.friendStateCon_:SetSelectedState("newFriend")
			arg_50_0.newFriendCon_:SetSelectedState(var_50_0.isDeal and 1 or 0)
		elseif var_50_1 == FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS then
			arg_50_0.friendStateCon_:SetSelectedState("request")
			arg_50_0.newFriendCon_:SetSelectedState(1)
		end
	else
		arg_50_0.friendStateCon_:SetSelectedState("newFriend")
		arg_50_0.newFriendCon_:SetSelectedState(FriendsData:IsInRequest(arg_50_0.userID_) and 1 or 0)
	end
end

function var_0_0.RefreshOnlineState(arg_51_0)
	arg_51_0.onlineCon_:SetSelectedState(arg_51_0.isOnline_ == 1 and "on" or "off")
end

function var_0_0.RefreshIP(arg_52_0, arg_52_1)
	SetActive(arg_52_0.ipGo_, GameToSDK.CURRENT_SERVER == AreaConst.CHINA)

	arg_52_0.ipTxt_.text = arg_52_1

	if arg_52_0.ipGo_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_0.ipGo_.transform)
	end
end

function var_0_0.RefreshID(arg_53_0, arg_53_1)
	arg_53_0.uid_.text = arg_53_1
end

function var_0_0.RefreshName(arg_54_0, arg_54_1)
	if not OperationData:IsOperationOpen(OperationConst.MANUAL_WORD_VERIFY) then
		local var_54_0, var_54_1 = wordVerify(arg_54_1, {
			isReplace = true
		})

		arg_54_0.name_.text = var_54_1
	else
		arg_54_0.name_.text = arg_54_1
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_0.namePanel_)
end

function var_0_0.RefreshSign(arg_55_0, arg_55_1)
	arg_55_1 = string.gsub(arg_55_1, "\n", "")

	if not OperationData:IsOperationOpen(OperationConst.MANUAL_WORD_VERIFY) then
		local var_55_0, var_55_1 = wordVerify(arg_55_1, {
			isReplace = true
		})

		arg_55_0.signTxt_.text = var_55_1 == "" and GetTips("PROFILE_PERSONAL_PROFILE_DEFAULT") or var_55_1
	else
		arg_55_0.signTxt_.text = arg_55_1 == "" and GetTips("PROFILE_PERSONAL_PROFILE_DEFAULT") or arg_55_1
	end
end

function var_0_0.RefreshHead(arg_56_0, arg_56_1)
	arg_56_0.headPortrait:RenderHead(arg_56_1)
end

function var_0_0.RefreshFrame(arg_57_0, arg_57_1)
	arg_57_0.headPortrait:RenderFrame(arg_57_1)
end

function var_0_0.RefreshLvInfo(arg_58_0, arg_58_1)
	arg_58_0.lvTxt_.text = arg_58_1
end

function var_0_0.RefreshGuild(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
	if arg_59_1 == 0 or arg_59_1 == "0" then
		arg_59_0.guildCon_:SetSelectedState("false")
	else
		arg_59_0.guildTxt_.text = arg_59_2

		local var_59_0 = ClubHeadIconCfg[arg_59_3]

		if var_59_0 then
			arg_59_0.guildIconImg_.sprite = getSpriteViaConfig("ClubHeadIcon", var_59_0.icon_bg)
		end

		arg_59_0.guildCon_:SetSelectedState("true")
	end
end

function var_0_0.RefreshBirthday(arg_60_0)
	SetActive(arg_60_0.birthdayPanelGo_, not arg_60_0.isForeign_)

	if arg_60_0.birthdayDay_ == 0 then
		SetActive(arg_60_0.brithdayBtn_.gameObject, not arg_60_0.isForeign_)
		SetActive(arg_60_0.brithdayTxt_.gameObject, false)
	else
		SetActive(arg_60_0.brithdayBtn_.gameObject, false)
		SetActive(arg_60_0.brithdayTxt_.gameObject, true)

		arg_60_0.brithdayTxt_.text = string.format(GetTips("OTHER_BIRTHDAY"), arg_60_0.birthdayMonth_, arg_60_0.birthdayDay_)
	end
end

function var_0_0.RefreshDorm(arg_61_0, arg_61_1, arg_61_2)
	if arg_61_1 == 0 then
		arg_61_0.dormCon_:SetSelectedState("false")
	else
		arg_61_0.dormText_.text = arg_61_2

		arg_61_0.dormCon_:SetSelectedState("true")
	end
end

function var_0_0.RefreshTag(arg_62_0, arg_62_1)
	arg_62_0.curTagList_ = arg_62_1

	arg_62_0.tagCon_:SetSelectedState(#arg_62_1 > 0 and "off" or "on")
	arg_62_0:StopTagScroll()

	for iter_62_0, iter_62_1 in ipairs(arg_62_1) do
		if not arg_62_0.tagItem_[iter_62_0] then
			local var_62_0 = Object.Instantiate(arg_62_0.tagTemplate_, arg_62_0.tagContent_)

			arg_62_0.tagItem_[iter_62_0] = NewUserAndPlayerInfoTagItem.New(var_62_0)
		end

		arg_62_0.tagItem_[iter_62_0]:SetData(iter_62_1)
	end

	for iter_62_2 = #arg_62_1 + 1, #arg_62_0.tagItem_ do
		arg_62_0.tagItem_[iter_62_2]:Show(false)
	end

	local var_62_1 = var_0_2

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_0.tagPanel_)

	if var_62_1 >= arg_62_0.tagContent_.transform.rect.width then
		arg_62_0.tagContentFitter_.horizontalFit = ContentSizeFitter.FitMode.PreferredSize

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_0.tagScrollPanel_)
	else
		arg_62_0.tagContentFitter_.horizontalFit = ContentSizeFitter.FitMode.Unconstrained
		arg_62_0.tagScrollPanel_.sizeDelta = Vector2(var_62_1, arg_62_0.tagScrollPanel_.sizeDelta.y)
		arg_62_0.tagContent_.anchoredPosition = Vector3.New(0, arg_62_0.tagContent_.anchoredPosition.y, 0)

		if arg_62_0.isTagShow_ then
			return
		end

		arg_62_0.tagScrollTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function()
			if arg_62_0.tagContent_.anchoredPosition.x <= -1 * arg_62_0.tagContent_.transform.rect.width then
				arg_62_0.tagContent_.anchoredPosition = Vector3.New(var_62_1, arg_62_0.tagContent_.anchoredPosition.y, 0)
			end

			arg_62_0.tagContent_.anchoredPosition = Vector3.New(arg_62_0.tagContent_.anchoredPosition.x - var_0_1, arg_62_0.tagContent_.anchoredPosition.y, 0)
		end, -1, true)
	end
end

function var_0_0.RefreshCardBg(arg_64_0, arg_64_1)
	local var_64_0 = ProfileDecorateItemCfg[arg_64_1]
	local var_64_1 = var_64_0.resource

	arg_64_0.cardBgCon_:SetSelectedState("image")

	if var_64_0.type == 1 then
		arg_64_0.cardBgIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/UserInfor/" .. var_64_1)
	elseif var_64_0.type == 2 then
		arg_64_0.cardBgCon_:SetSelectedState("prefab")

		local var_64_2 = Asset.Load("Widget/System/PlayerProfileBg/PPBCode_" .. var_64_1)

		if var_64_2 then
			local var_64_3 = Object.Instantiate(var_64_2, arg_64_0.cardBgPrefabRoot_)

			if var_64_3 then
				var_64_3.transform:SetParent(arg_64_0.cardBgPrefabRoot_)

				var_64_3.transform.localScale = Vector3.New(1, 1, 1)
				var_64_3.transform.localPosition = Vector3.New(0, 0, 0)

				var_64_3:SetActive(true)
			end
		end
	elseif var_64_0.type == 3 then
		-- block empty
	end
end

function var_0_0.RefreshAchievement(arg_65_0)
	arg_65_0.heroTxt_.text = arg_65_0.heroNum_ .. "/" .. arg_65_0.heroAll_

	if arg_65_0.heroNum_ == arg_65_0.heroAll_ then
		arg_65_0.heroPre_.text = "100%"
	else
		arg_65_0.heroPre_.text = math.floor(arg_65_0.heroNum_ * 100 / arg_65_0.heroAll_) .. "%"
	end

	arg_65_0.stickerTxt_.text = arg_65_0.stickerNum_ .. "/" .. arg_65_0.stickerAll_

	if arg_65_0.stickerNum_ == arg_65_0.stickerAll_ then
		arg_65_0.stickerPre_.text = "100%"
	else
		arg_65_0.stickerPre_.text = math.floor(arg_65_0.stickerNum_ * 100 / arg_65_0.stickerAll_) .. "%"
	end

	arg_65_0.weaponServantTxt_.text = arg_65_0.weaponServantNum_ .. "/" .. arg_65_0.weaponServantAll_

	if arg_65_0.weaponServantNum_ == arg_65_0.weaponServantAll_ then
		arg_65_0.weaponServantPre_.text = "100%"
	else
		arg_65_0.weaponServantPre_.text = math.floor(arg_65_0.weaponServantNum_ * 100 / arg_65_0.weaponServantAll_) .. "%"
	end

	arg_65_0.achieveTxt_.text = arg_65_0.achieveNum_ .. "/" .. arg_65_0.achieveAll_

	if arg_65_0.achieveNum_ == arg_65_0.achieveAll_ then
		arg_65_0.achievePre_.text = "100%"
	else
		arg_65_0.achievePre_.text = math.floor(arg_65_0.achieveNum_ * 100 / arg_65_0.achieveAll_) .. "%"
	end
end

function var_0_0.RefreshLike(arg_66_0, arg_66_1)
	if arg_66_1 >= 10000 then
		arg_66_0.like_.text = string.format("%.1f", arg_66_1 / 1000) .. "K"
	else
		arg_66_0.like_.text = arg_66_1
	end

	if not arg_66_0.isForeign_ then
		arg_66_0.likeCon_:SetSelectedState("on")
	else
		arg_66_0.likeCon_:SetSelectedState(table.indexof(arg_66_0.todaySendLike_, arg_66_0.userID_) and "off" or "on")
	end
end

function var_0_0.RefreshGirl(arg_67_0, arg_67_1)
	if arg_67_0.isForeign_ then
		if arg_67_1 == 0 then
			arg_67_1 = 1084
		end

		local var_67_0 = SkinCfg[arg_67_1].hero

		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.playerInfo_other, {
			isForeign = true,
			heroID = var_67_0,
			skinID = arg_67_1,
			oath = nullable(arg_67_0.hero_oath_display, var_67_0, "oath")
		})
	else
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.playerInfo)
	end
end

function var_0_0.RefreshScene(arg_68_0)
	if not arg_68_0.isForeign_ then
		local var_68_0 = HomeSceneSettingData:GetCurScene()
		local var_68_1 = manager.loadScene:GetTimeSceneID(var_68_0)

		if CameraCfg["t0_playerInfo_" .. var_68_1] and PosterGirlConst.PosterGirlTag.t0 == manager.posterGirl:GetTag() then
			manager.ui:SetMainCamera("t0_playerInfo_" .. var_68_1)
		elseif CameraCfg["playerInfo_" .. var_68_1] then
			manager.ui:SetMainCamera("playerInfo_" .. var_68_1)
		else
			manager.ui:SetMainCamera("playerInfo", false, false)
		end
	else
		local var_68_2 = var_0_3()

		manager.loadScene:SetSceneDisableAutoChange(true)

		local var_68_3 = manager.loadScene:GetHomeShouldLoadSceneName(var_68_2, true)

		manager.loadScene:SetSceneDisableAutoChange(false)

		local var_68_4 = "UI/Common/BackgroundQuad"

		arg_68_0:DestoryBackGround()

		arg_68_0.backGround_ = manager.resourcePool:Get(var_68_4, ASSET_TYPE.SCENE)
		arg_68_0.backGroundTrs_ = arg_68_0.backGround_.transform

		local var_68_5 = GameSetting.profile_other_players_coordinate.value

		arg_68_0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

		arg_68_0.backGroundTrs_.localPosition = Vector3(var_68_5[1], var_68_5[2], var_68_5[3])
		arg_68_0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
		arg_68_0.backGroundTrs_.localScale = Vector3(11, 11, 1)
		arg_68_0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureConfig/BackgroundQuad/" .. var_68_3)

		manager.ui:SetMainCamera("playerInfo", false, true)
	end
end

function var_0_0.TagSelectCallback(arg_69_0, arg_69_1)
	arg_69_0:RefreshTag(arg_69_1)
end

function var_0_0.HidePop(arg_70_0)
	SetActive(arg_70_0.goPop_, false)
end

function var_0_0.ShowTagView(arg_71_0)
	arg_71_0.isTagShow_ = true

	arg_71_0.tagSelectPanel_:Show(true)
	arg_71_0.tagSelectPanel_:RefreshUI()
	SetActive(arg_71_0.hideTagBtn_.gameObject, true)
	arg_71_0:RefreshTag(arg_71_0.curTagList_)
end

function var_0_0.HideTagView(arg_72_0)
	if arg_72_0.isTagShow_ then
		PlayerData:DealOverdueTagList()
		PlayerData:ClearTagRed()
	end

	arg_72_0.isTagShow_ = false

	arg_72_0.tagSelectPanel_:Show(false)
	SetActive(arg_72_0.hideTagBtn_.gameObject, false)
end

function var_0_0.AddClickTimer(arg_73_0)
	arg_73_0:StopTimer()

	arg_73_0.buttonUp_ = 0
	arg_73_0.clickTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function()
		if Input.GetMouseButtonUp(0) then
			arg_73_0.buttonUp_ = arg_73_0.buttonUp_ + 1

			if arg_73_0.buttonUp_ >= 2 then
				arg_73_0:HidePop()
				FuncTimerManager.inst:RemoveFuncTimer(arg_73_0.clickTimer_)

				arg_73_0.clickTimer_ = nil
			end
		end
	end, -1, true)
end

function var_0_0.StopTimer(arg_75_0)
	if arg_75_0.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(arg_75_0.clickTimer_)

		arg_75_0.clickTimer_ = nil
	end
end

function var_0_0.StopTagScroll(arg_76_0)
	if arg_76_0.tagScrollTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(arg_76_0.tagScrollTimer_)

		arg_76_0.tagScrollTimer_ = nil
	end
end

function var_0_0.BindRedPoint(arg_77_0)
	manager.redPoint:bindUIandKey(arg_77_0.brithdayBtn_.transform, RedPointConst.BRITHDAY)
	manager.redPoint:bindUIandKey(arg_77_0.stickerRedPanel_, RedPointConst.CUSTOM_STICKER_ROOT)
	manager.redPoint:bindUIandKey(arg_77_0.portraitObj_.transform, RedPointConst.USER_CUSTOM)
	manager.redPoint:bindUIandKey(arg_77_0.tagBtn_.transform, RedPointConst.TAG)
end

function var_0_0.UnbindRedPoint(arg_78_0)
	manager.redPoint:unbindUIandKey(arg_78_0.brithdayBtn_.transform, RedPointConst.BRITHDAY)
	manager.redPoint:unbindUIandKey(arg_78_0.stickerRedPanel_, RedPointConst.CUSTOM_STICKER_ROOT)
	manager.redPoint:unbindUIandKey(arg_78_0.portraitObj_.transform, RedPointConst.USER_CUSTOM)
	manager.redPoint:unbindUIandKey(arg_78_0.tagBtn_.transform, RedPointConst.TAG)
end

function var_0_0.OnTop(arg_79_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back(nil, {
			userID = arg_79_0.userID_
		})
	end)
end

function var_0_0.OnChangeNickname(arg_81_0, arg_81_1)
	arg_81_0:RefreshName(arg_81_1.nick)
end

function var_0_0.OnChangeSign(arg_82_0, arg_82_1, arg_82_2, arg_82_3)
	SetActive(arg_82_0.signInput_.gameObject, false)
	SetActive(arg_82_0.signTxt_.gameObject, true)

	arg_82_0.sign_ = arg_82_2.sign

	arg_82_0:RefreshSign(arg_82_2.sign)

	if arg_82_3 then
		ShowTips("NOT_SUPPORTED_LINE_FEED")
	else
		ShowTips("SUCCESS_CHANGE_SIGNATURE")
	end
end

function var_0_0.OnChangePortrait(arg_83_0)
	local var_83_0 = PlayerData:GetPlayerInfo()

	arg_83_0:RefreshHead(var_83_0.portrait)
end

function var_0_0.OnChangeFrame(arg_84_0)
	local var_84_0 = PlayerData:GetPlayerInfo()

	arg_84_0:RefreshFrame(var_84_0.icon_frame)
end

function var_0_0.OnChangeBirthday(arg_85_0)
	arg_85_0.birthdayMonth_, arg_85_0.birthdayDay_ = PlayerData:GetPlayerBrithday()

	arg_85_0:RefreshBirthday()
end

function var_0_0.OnChangeCardBg(arg_86_0, arg_86_1)
	local var_86_0 = PlayerData:GetPlayerInfo()

	arg_86_0:RefreshCardBg(arg_86_1)
end

function var_0_0.OnChangTagList(arg_87_0)
	arg_87_0.tagList_ = PlayerData:GetUsingTagListInfo()

	arg_87_0:RefreshTag(arg_87_0.tagList_)
end

function var_0_0.OnGetLike(arg_88_0)
	arg_88_0.likeCnt_ = PlayerData:GetPlayerInfo().likes

	arg_88_0:RefreshLike(arg_88_0.likeCnt_)
end

function var_0_0.OnSendLike(arg_89_0)
	arg_89_0.todaySendLike_ = PlayerData:GetTodaySendLikeList() or {}

	SetActive(arg_89_0.likeAddGo_, true)

	arg_89_0.likeCnt_ = arg_89_0.likeCnt_ + 1

	arg_89_0:RefreshLike(arg_89_0.likeCnt_)
end

function var_0_0.OnFriendsDelect(arg_90_0, arg_90_1)
	if arg_90_1 == arg_90_0.userID_ then
		arg_90_0:Back()
	end
end

function var_0_0.OnCheckForeignInfo(arg_91_0, arg_91_1)
	arg_91_0.params_.isForeign = arg_91_1.isForeign
	arg_91_0.isForeign_ = arg_91_1.isForeign

	arg_91_0:OnEnter()
end

function var_0_0.DestoryBackGround(arg_92_0)
	if arg_92_0.backGround_ then
		manager.resourcePool:DestroyOrReturn(arg_92_0.backGround_, ASSET_TYPE.SCENE)

		arg_92_0.backGround_ = nil
	end
end

function var_0_0.RefreshBgImage(arg_93_0)
	local var_93_0 = manager.windowBar:GetWhereTag()

	if var_93_0 == "canteen" or var_93_0 == "dorm" or var_93_0 == "danceGame" or var_93_0 == "minigame" then
		SetActive(arg_93_0.bgImg_.gameObject, true)

		local var_93_1

		if arg_93_0.isForeign_ then
			var_93_1 = ForeignInfoData:GetCurForeignDetailInfo().post_background_id
		else
			var_93_1 = HomeSceneSettingData:GetCurScene()
		end

		manager.loadScene:SetSceneDisableAutoChange(true)

		local var_93_2 = manager.loadScene:GetHomeShouldLoadSceneName(var_93_1, arg_93_0.isForeign_)

		manager.loadScene:SetSceneDisableAutoChange(false)

		arg_93_0.bgImg_.spriteSync = "TextureConfig/BackgroundQuad/" .. var_93_2
	else
		SetActive(arg_93_0.bgImg_.gameObject, false)
	end
end

function var_0_0.OnExit(arg_94_0)
	arg_94_0:StopTagScroll()
	arg_94_0:StopTimer()
	manager.windowBar:HideBar()
	arg_94_0.tagSelectPanel_:OnExit()
	manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.null)

	for iter_94_0, iter_94_1 in ipairs(arg_94_0.tagItem_) do
		iter_94_1:OnExit()
	end

	arg_94_0:DestoryBackGround()
	manager.ui:ResetMainCamera()

	arg_94_0.stickerList_ = {}

	arg_94_0:UnbindRedPoint()
	arg_94_0:HidePop()
end

function var_0_0.Dispose(arg_95_0)
	arg_95_0.signInput_.onEndEdit:RemoveAllListeners()
	arg_95_0.tagSelectPanel_:Dispose()

	for iter_95_0, iter_95_1 in ipairs(arg_95_0.tagItem_) do
		iter_95_1:Dispose()
	end

	arg_95_0.headPortrait:Dispose()

	arg_95_0.headPortrait = nil

	arg_95_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_95_0)
end

return var_0_0

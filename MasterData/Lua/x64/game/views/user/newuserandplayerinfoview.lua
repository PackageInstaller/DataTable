local NewUserAndPlayerInfoView = class("NewUserAndPlayerInfoView", ReduxView)
local var_0_1 = 1
local var_0_2 = 860

function NewUserAndPlayerInfoView:UIName()
	return "Widget/System/UserInfor/UserInfoUInew"
end

function NewUserAndPlayerInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function NewUserAndPlayerInfoView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function NewUserAndPlayerInfoView:InitUI()
	self:BindCfgUI()

	self.bgImg_.immediate = true

	local var_4_0 = GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV or not SDKTools.GetIsOverSea() and _G.CHANNEL_MASTER_ID ~= 1

	SetActive(self.userCenterBtn_.gameObject, not var_4_0)
	SetActive(self.logoutBtn_.gameObject, var_4_0)
	SetActive(self.logoffBtn_.gameObject, var_4_0)

	self.curTagList_ = {}
	self.tagItem_ = {}
	self.tagContentFitter_ = self.tagScrollPanel_:GetComponent("ContentSizeFitter")
	self.tagCon_ = ControllerUtil.GetController(self.transform_, "tag")
	self.likeCon_ = ControllerUtil.GetController(self.transform_, "like")
	self.dormCon_ = ControllerUtil.GetController(self.transform_, "dorm")
	self.guildCon_ = ControllerUtil.GetController(self.transform_, "guild")
	self.onlineCon_ = ControllerUtil.GetController(self.transform_, "online")
	self.newFriendCon_ = ControllerUtil.GetController(self.transform_, "newFriend")
	self.friendStateCon_ = ControllerUtil.GetController(self.transform_, "friendState")
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
	self.systemCon_ = ControllerUtil.GetController(self.transform_, "system")
	self.signCon_ = self.transform_:GetComponent("ControllerExCollection"):GetController("sign")
	self.cardBgCon_ = self.transform_:GetComponent("ControllerExCollection"):GetController("bgType")
	self.tagSelectPanel_ = TagView.New(self.tagSelectPanelGo_)

	self.tagSelectPanel_:RegisterClickFunction(handler(self, self.TagSelectCallback))

	self.headPortrait = CommonHeadPortrait.New(self.portraitObj_)
end

function NewUserAndPlayerInfoView:AddUIListeners()
	self:AddBtnListener(self.nameBtn_, nil, function()
		if table.keyof(self.operationInfo_, OperationConst.CHANGE_NICK) ~= nil then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		JumpTools.OpenPageByJump("changeName")
	end)
	self:AddBtnListener(self.changeNameBtn_, nil, function()
		if table.keyof(self.operationInfo_, OperationConst.CHANGE_NICK) ~= nil then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		JumpTools.OpenPageByJump("changeName")
	end)
	self:AddBtnListener(self.signBtn_, nil, function()
		self.signInput_.text = self.sign_

		SetActive(self.signInput_.gameObject, true)
		self.signInput_:ActivateInputField()
		SetActive(self.signTxt_.gameObject, false)
	end)
	self.signInput_.onEndEdit:AddListener(function()
		if table.keyof(self.operationInfo_, OperationConst.CHANGE_SIGN) ~= nil then
			ShowTips("ERROR_FUNCTION_STOP")
			SetActive(self.signInput_.gameObject, false)
			SetActive(self.signTxt_.gameObject, true)

			return
		end

		local var_9_0 = self.signInput_.text

		if self.signInput_.text ~= nil and var_9_0 ~= "" and self.sign_ == var_9_0 then
			SetActive(self.signInput_.gameObject, false)
			SetActive(self.signTxt_.gameObject, true)

			return
		end

		local var_9_1, var_9_2 = textLimit(var_9_0, GameSetting.personal_signature_max.value[1])
		local var_9_3 = var_9_1

		if not var_9_2 then
			ShowTips("PERSONAL_SIGNATURE_MAX")
			SetActive(self.signInput_.gameObject, false)
			SetActive(self.signTxt_.gameObject, true)

			return
		end

		WordVerifyBySDK(var_9_1, function(arg_10_0)
			local var_10_0 = PlayerData:GetPlayerInfo()

			if not arg_10_0 then
				ShowTips("SENSITIVE_WORD")
				self:RefreshSign(var_10_0.sign)
				SetActive(self.signInput_.gameObject, false)
				SetActive(self.signTxt_.gameObject, true)

				return
			end

			if var_10_0.sign == var_9_3 then
				SetActive(self.signInput_.gameObject, false)
				SetActive(self.signTxt_.gameObject, true)

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
	self:AddBtnListener(self.logoutBtn_, nil, function()
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
	self:AddBtnListener(self.userCenterBtn_, nil, function()
		NeedGameUserInfo()
		GameToSDK.GoUserCenter()
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 2,
			direction_channel = 4
		})
	end)
	self:AddBtnListener(self.logoffBtn_, nil, function()
		GameToSDK.LogOff()
	end)
	self:AddBtnListener(self.servantbtnBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("userinfo_spirit")
		JumpTools.OpenPageByJump("/illuServantManual")
	end)
	self:AddBtnListener(self.illustratedAchievementBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("userinfo_achievement")

		if manager.windowBar:GetWhereTag() ~= nil then
			return
		end

		JumpTools.GoToSystem("/achievementManager", nil, ViewConst.SYSTEM_ID.ACHIEVEMENT)
	end)
	self.headPortrait:RegisteClickCallback(function()
		if self.isForeign_ then
			return
		end

		OperationRecorder.RecordButtonTouch("userinfo_headportrait")
		JumpTools.OpenPageByJump("HeadIconChange", {
			isEnter = true
		})
	end)
	self:AddBtnListener(self.brithdayBtn_, nil, function()
		JumpTools.OpenPageByJump("BirthdayView")
	end)
	self:AddBtnListener(self.tagBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("userinfo_usertag")
		self:ShowTagView()
	end)
	self:AddBtnListener(self.hideTagBtn_, nil, function()
		self:HideTagView()
		PlayerAction.ChangTagList(self.curTagList_)
	end)
	self:AddBtnListener(self.likeBtn_, nil, function()
		if not self.isForeign_ then
			JumpTools.OpenPageByJump("likeInfoPop", {
				index = 1
			})
		else
			if table.indexof(self.todaySendLike_, self.userID_) or #self.todaySendLike_ >= GameSetting.profile_like_limitation.value[1] then
				ShowTips("PROFILE_LIKE_REPEAT_PROMPT")

				return
			end

			PlayerAction.SendLike(self.userID_, PlayerAction.SendLikeSrc.PlayerInfo)
		end
	end)
	self:AddBtnListener(self.copyBtn_, nil, function()
		UnityEngine.GUIUtility.systemCopyBuffer = self.userID_

		ShowTips("COPY_SUCCESS")
	end)
	self:AddBtnListener(self.illustratedStickerBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("userinfo_sticker")

		if self.isForeign_ then
			JumpTools.OpenPageByJump("/customStickerMain", {
				foreign = self.stickerList_
			})
		else
			JumpTools.OpenPageByJump("/customStickerMain")
		end
	end)
	self:AddBtnListener(self.illustratedHeroBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("userinfo_hero")
		JumpTools.OpenPageByJump("showHeroPop", {
			userID = self.userID_,
			isForeign = self.isForeign_,
			heroList = self.heroList_,
			heroListGetter = (not self.isForeign_ or nil) and NewUserAndPlayerInfoView.GetUserHeroShowDataList
		})
	end)
	self:AddBtnListener(self.dormBtn_, nil, function()
		if manager.windowBar:GetWhereTag() ~= nil then
			return
		end

		if not self.isForeign_ then
			if self.dormID_ == 0 then
				ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.DORM, (JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM))))
			else
				local var_26_0 = GameDisplayCfg.dorm_begin_story.value[1]

				if GameDisplayCfg.dorm_begin_story.value[1] and not manager.story:IsStoryPlayed(var_26_0) then
					manager.story:StartStoryById(var_26_0, function(arg_27_0)
						JumpTools.OpenPageByJump("/dormChooseRoomView")
					end)
				elseif BackHomeCfg[self.dormID_].type == DormConst.BACKHOME_TYPE.PublicDorm then
					BackHomeTools:GotoBackHomeRoom(DormConst.PUBLIC_DORM_ID)
				else
					BackHomeTools:GotoBackHomeRoom(self.dormID_)
				end
			end
		else
			if not self.dormID_ or self.dormID_ == 0 then
				ShowTips("PLAYER_DORM_LOCK")

				return
			end

			DormVisitTools:SetIsOtherSystem(true)
			DormVisitTools:SetBackFunc(function()
				OpenPageUntilLoaded("/playerinfo", {
					isForeign = self.isForeign_
				})
			end)
			SDKTools.SendMessageToSDK("backhome_dorm_visit_jump", {
				backhome_source = 1
			})
			DormAction:OtherSystemAskSingleFurTemplateExhibit(self.userID_)
		end
	end)
	self:AddBtnListener(self.guildBtn_, nil, function()
		if JumpTools.IsSystemOperationStoped(ViewConst.SYSTEM_ID.GUILD) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		local var_29_0 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.GUILD)

		if not self.isForeign_ and var_29_0 then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.GUILD, var_29_0))

			return
		end

		if GuildData.IsGuildValid(self.guildID_) then
			ForeignInfoAction:SearchGuildInfo(self.guildID_, 1)
		end
	end)
	self:AddBtnListener(self.buttonAdd_, nil, function()
		if self.newFriendCon_:GetSelectedState() == "1" then
			ShowTips("PROFILE_FRIENDS_APPLYING")

			return
		end

		FriendsAction:TryToRequestToFriend(self.userID_, FriendConst.ADD_FRIEND_SOURCE.PLAYER_INFO)
		self.newFriendCon_:SetSelectedState(1)
	end)
	self:AddBtnListener(self.buttonTalk_, nil, function()
		if not FriendsData:GetFreshFlag() then
			FriendsAction:TryToRefreshFriendsView(1, function()
				ChatFriendData:AddCacheFriend(self.userID_)
				JumpTools.OpenPageByJump("chat", {
					ignoreBG = true,
					chatToggleID = ChatConst.CHAT_CHANNEL_FRIEND,
					friendID = self.userID_
				}, ViewConst.SYSTEM_ID.CHAT)
			end)

			return
		end

		ChatFriendData:AddCacheFriend(self.userID_)
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_FRIEND,
			friendID = self.userID_
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	self:AddBtnListener(self.buttonDeleteFriend_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("FRIEND_DELETE_QUEST"), self.nick_),
			OkCallback = function()
				FriendsAction:TryToDelectFromMyFriendsList(self.userID_)
				self:Back()
			end
		})
	end)
	self:AddBtnListener(self.buttonMore_, nil, function()
		if self.isPop_ then
			self.isPop_ = false

			self:HidePop()

			return
		end

		SetActive(self.goPop_, true)
		self:AddClickTimer()

		self.isPop_ = true
	end)
	self:AddBtnListener(self.buttonReport_, nil, function()
		JumpTools.OpenPageByJump("chatReport", {
			reportType = ChatConst.CHAT_REPORT_TYPE.USER,
			reportData = {
				nick = self.nick_,
				userID = self.userID_
			}
		}, ViewConst.SYSTEM_ID.CHAT_REPORT)
	end)
	self:AddBtnListener(self.buttonBlackList_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("FRIEND_MOVE_TO_BLACLIST_QUEST"), self.nick_),
			OkCallback = function()
				FriendsAction:TryToAddToBlacklist(self.userID_)
				self:Back()
			end
		})
	end)
end

local function var_0_3()
	local var_39_0 = ForeignInfoData:GetCurForeignDetailInfo()
	local var_39_1 = var_39_0.post_background_id

	if HomeSceneSettingCfg[var_39_0.post_background_id].limit_display == 0 then
		local var_39_2 = CustomCenterTools.GetMatchSkinByScene(var_39_1)

		if var_39_2 and var_39_2 ~= var_39_0.postGril then
			print("好友dlc场景和角色不匹配! 替换为默认场景")

			var_39_1 = GameSetting.home_sence_default.value[#GameSetting.home_sence_default.value]
		end
	end

	if var_39_1 == 0 then
		var_39_1 = GameSetting.home_sence_default.value[2]
	end

	return var_39_1
end

function NewUserAndPlayerInfoView:ReserveCameraEnter()
	if self.params_.maskScene then
		return
	end

	manager.loadScene:SetSceneActive(manager.loadScene:GetHomeShouldLoadSceneName(self.params_.isForeign and var_0_3() or HomeSceneSettingData:GetCurScene()), true)
end

function NewUserAndPlayerInfoView:OnEnter()
	self.isForeign_ = self.params_.isForeign

	SetActive(self.likeAddGo_, false)
	self:HideTagView()
	self:RefreshUI()
end

function NewUserAndPlayerInfoView:RefreshUI()
	if not self.isForeign_ then
		self.stateCon_:SetSelectedState("user")
		self.signCon_:SetSelectedIndex(1)
		self:BindRedPoint()

		self.operationInfo_ = OperationData:GetOperationOpenList()

		self:RefreshUserData()
		self:RefreshExpInfo(self.lv_, self.exp_)
	else
		self.stateCon_:SetSelectedState("player")
		self:HidePop()
		self:RefreshPlayerData()
		self:RefreshFriendState()
		self:RefreshOnlineState()
		self.signCon_:SetSelectedIndex(FriendsData:IsFriend(self.userID_) and 1 or 0)
	end

	self:RefreshSystem()
	self:RefreshBtn()
	self:RefreshIP(self.ip_)
	self:RefreshID(self.userID_)
	self:RefreshName(self.nick_)
	SetActive(self.signInput_.gameObject, false)
	SetActive(self.signTxt_.gameObject, true)
	self:RefreshSign(self.sign_)
	self:RefreshLvInfo(self.lv_)
	self:RefreshHead(self.headIconID_)
	self:RefreshFrame(self.iconFrameID_)
	self:RefreshGuild(self.guildID_, self.guildName_, self.guildIcon_)
	self:RefreshBirthday()
	self:RefreshTag(self.tagList_)
	self:RefreshCardBg(self.cardBg_)
	self:RefreshDorm(self.dormID_, self.dormName_)
	self:RefreshAchievement()
	self:RefreshLike(self.likeCnt_)

	if not self.params_.maskScene then
		self:RefreshGirl(self.postGirl_)
		self:RefreshScene()
	end

	self:RefreshBgImage()
end

function NewUserAndPlayerInfoView.GetUserHeroShowDataList()
	local var_43_0 = {}

	for iter_43_0, iter_43_1 in ipairs((PlayerData:GetHeroShowList())) do
		local var_43_1 = HeroData:GetHeroData(iter_43_1)
		local var_43_2 = {
			hero_id = iter_43_1,
			star = var_43_1.star,
			level = var_43_1.level,
			using_skin = var_43_1.using_skin
		}

		var_43_2.oath = nil
		var_43_0[iter_43_0] = var_43_2
	end

	return var_43_0
end

function NewUserAndPlayerInfoView.GetForeignPlayerShowHeroDataList()
	local var_44_0 = ForeignInfoData:GetCurForeignDetailInfo()
	local var_44_1 = {}

	for iter_44_0, iter_44_1 in ipairs(var_44_0.hero_list) do
		local var_44_2 = {
			hero_id = iter_44_1.hero_id,
			star = iter_44_1.star
		}

		var_44_2.level = 0
		var_44_2.using_skin = iter_44_1.using_skin
		var_44_2.oath = nullable(var_44_0.hero_oath_display, iter_44_1.hero_id, "oath")
		var_44_1[iter_44_0] = var_44_2
	end

	return var_44_1
end

function NewUserAndPlayerInfoView:RefreshUserData()
	local var_45_0 = PlayerData:GetPlayerInfo()

	self.ip_ = var_45_0.ip
	self.nick_ = var_45_0.nick
	self.sign_ = var_45_0.sign
	self.lv_ = var_45_0.userLevel
	self.userID_ = var_45_0.userID
	self.exp_ = var_45_0.remain_exp
	self.headIconID_ = var_45_0.portrait
	self.iconFrameID_ = var_45_0.icon_frame
	self.birthdayMonth_ = var_45_0.birthday_month
	self.birthdayDay_ = var_45_0.birthday_day
	self.likeCnt_ = var_45_0.likes
	self.cardBg_ = var_45_0.card_bg_id
	self.tagList_ = PlayerData:GetUsingTagListInfo()
	self.postGirl_ = HeroTools.HeroUsingSkinInfo(var_45_0.poster_girl).id

	local var_45_1 = GuildData:GetGuildInfo()

	if var_45_1 and var_45_1.id and var_45_1.name then
		self.guildID_ = var_45_1.id
		self.guildName_ = var_45_1.name
		self.guildIcon_ = var_45_1.icon
	else
		self.guildID_ = GuildData.INVALID_GUILD
		self.guildName_ = ""
		self.guildIcon_ = 0
	end

	self.dormID_ = 0
	self.dormName_ = ""

	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		local var_45_2 = DormVisitTools:GetCurTemplateExhibit()

		if var_45_2 == 0 then
			self.dormID_ = DormConst.PUBLIC_DORM_ID or var_45_2
		end

		if BackHomeCfg[self.dormID_].type == DormConst.BACKHOME_TYPE.PublicDorm then
			self.dormName_ = GetTips("DORM_LOBBY_NAME")
		else
			local var_45_3 = HeroRecordCfg.get_id_list_by_hero_id[DormitoryData:GetDormSceneData(self.dormID_).archiveIDList[1]][1]

			if var_45_3 then
				local var_45_4 = GetI18NText(HeroRecordCfg[var_45_3].name)

				if var_45_4 then
					self.dormName_ = string.format(GetTips("DORM_HERO_ROOM_NAME"), var_45_4)
				end
			end
		end
	end

	self.heroList_ = NewUserAndPlayerInfoView.GetUserHeroShowDataList()
	self.stickerList_ = var_45_0.sticker_show_info
	self.stickerBg_ = var_45_0.sticker_background
	self.heroNum_ = HeroTools.GetFilteredHeroNum(HeroTools.FilterHeroFunc.ObtainedNotHide)
	self.heroAll_ = HeroTools.GetFilteredHeroNum(HeroTools.FilterHeroFunc.AllNotHide)
	self.weaponServantAll_ = 0
	self.weaponServantNum_ = table.length(IllustratedData:GetServantInfo())

	for iter_45_0, iter_45_1 in ipairs(WeaponServantCfg.all) do
		if not ServantTools.GetIsHide(iter_45_1) and (IllustratedData:GetServantInfo()[iter_45_1] or WeaponServantCfg[iter_45_1].display_type ~= 1) then
			self.weaponServantAll_ = self.weaponServantAll_ + 1
		end
	end

	self.stickerAll_ = #PlayerData:GetStickerList(true) + #PlayerData:GetStickerBgList(true) + #PlayerData:GetStickerFgList(true)
	self.stickerNum_ = #PlayerData:GetStickerList() + #PlayerData:GetStickerBgList() + #PlayerData:GetStickerFgList()
	self.achieveAll_ = AchievementData:GetAchievementTotalCnt()
	self.achieveNum_ = AchievementData:GetFinishAchievementCnt()
end

function NewUserAndPlayerInfoView:RefreshPlayerData()
	local var_46_0 = ForeignInfoData:GetCurForeignDetailInfo()

	self.ip_ = var_46_0.ip
	self.nick_ = var_46_0.nick
	self.sign_ = var_46_0.sign
	self.lv_ = var_46_0.level
	self.userID_ = var_46_0.user_id
	self.headIconID_ = var_46_0.icon
	self.iconFrameID_ = var_46_0.icon_frame
	self.isOnline_ = var_46_0.is_online
	self.likeCnt_ = var_46_0.likes
	self.cardBg_ = var_46_0.card_bg_id
	self.tagList_ = var_46_0.used_tag_list
	self.postGirl_ = var_46_0.postGril
	self.hero_oath_display = var_46_0.hero_oath_display
	self.guildID_ = var_46_0.guildID
	self.guildName_ = var_46_0.guildName
	self.guildIcon_ = var_46_0.guildIcon
	self.dormID_ = var_46_0.backhome_architecture_id
	self.dormName_ = ""

	if self.dormID_ ~= 0 then
		self.dormName_ = BackHomeCfg[self.dormID_].type == DormConst.BACKHOME_TYPE.PublicDorm and GetTips("DORM_LOBBY_NAME") or string.format(GetTips("DORM_HERO_ROOM_NAME"), GetI18NText(HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[var_46_0.hero_id_list[1]][1]].name))
	end

	self.heroList_ = NewUserAndPlayerInfoView.GetForeignPlayerShowHeroDataList()
	self.stickerList_ = var_46_0.sticker_show_info
	self.stickerBg_ = var_46_0.sticker_background
	self.heroNum_ = var_46_0.hero_static_info.not_hide_num
	self.heroAll_ = HeroTools.GetFilteredHeroNum(HeroTools.FilterHeroFunc.All)
	self.heroAll_ = self.heroAll_ - var_46_0.hero_static_info.cfg_hide_num
	self.weaponServantNum_ = var_46_0.weapon_servant_static_info.not_hide_num
	self.weaponServantAll_ = #WeaponServantCfg.all - var_46_0.weapon_servant_static_info.cfg_hide_num
	self.stickerNum_ = var_46_0.sticker_static_info.not_hide_num + var_46_0.sticker_background_static_info.not_hide_num + var_46_0.sticker_foreground_static_info.not_hide_num
	self.stickerAll_ = #ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.STICKER] + #ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.STICKER_BG] + #ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.STICKER_FG]
	self.stickerAll_ = self.stickerAll_ - (var_46_0.sticker_static_info.cfg_hide_num + var_46_0.sticker_background_static_info.cfg_hide_num + var_46_0.sticker_background_static_info.cfg_hide_num)
	self.achieveNum_ = var_46_0.achievement_static_info.not_hide_num
	self.achieveAll_ = #AchievementCfg.all
	self.achieveAll_ = self.achieveAll_ - var_46_0.achievement_static_info.cfg_hide_num
	self.todaySendLike_ = PlayerData:GetTodaySendLikeList() or {}
end

function NewUserAndPlayerInfoView:RefreshSystem()
	self.systemCon_:SetSelectedState(manager.windowBar:GetWhereTag() == nil and "on" or "off")
end

function NewUserAndPlayerInfoView:RefreshBtn()
	self.signBtn_.interactable = not self.isForeign_
	self.nameBtn_.interactable = not self.isForeign_
	self.changeNameBtn_.interactable = not self.isForeign_
	self.servantbtnBtn_.interactable = not self.isForeign_
	self.illustratedAchievementBtn_.interactable = not self.isForeign_
end

function NewUserAndPlayerInfoView:RefreshExpInfo(arg_49_1, arg_49_2)
	if LvTools.GetIsMaxLv(arg_49_1, "user") then
		self.expTxt_.text = "-/-"
		self.progressTrs_.value = 1
	else
		local var_49_0 = GameLevelSetting[arg_49_1].user_level_exp

		self.expTxt_.text = string.format("%d/%d", arg_49_2, GameLevelSetting[arg_49_1].user_level_exp)
		self.progressTrs_.value = arg_49_2 / var_49_0
	end
end

function NewUserAndPlayerInfoView:RefreshFriendState()
	local var_50_0 = FriendsData:GetInfoByID(self.userID_)

	if var_50_0 then
		if var_50_0.relationship == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
			self.friendStateCon_:SetSelectedState("myFriend")
		elseif var_50_0.relationship == FriendsConst.FRIEND_TYPE.NEW_FRIENDS or var_50_0.relationship == FriendsConst.FRIEND_TYPE.SEARCH then
			self.friendStateCon_:SetSelectedState("newFriend")
			self.newFriendCon_:SetSelectedState(var_50_0.isDeal and 1 or 0)
		elseif var_50_0.relationship == FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS then
			self.friendStateCon_:SetSelectedState("request")
			self.newFriendCon_:SetSelectedState(1)
		end
	else
		self.friendStateCon_:SetSelectedState("newFriend")
		self.newFriendCon_:SetSelectedState(FriendsData:IsInRequest(self.userID_) and 1 or 0)
	end
end

function NewUserAndPlayerInfoView:RefreshOnlineState()
	self.onlineCon_:SetSelectedState(self.isOnline_ == 1 and "on" or "off")
end

function NewUserAndPlayerInfoView:RefreshIP(arg_52_1)
	SetActive(self.ipGo_, GameToSDK.CURRENT_SERVER == AreaConst.CHINA)

	self.ipTxt_.text = arg_52_1

	if self.ipGo_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ipGo_.transform)
	end
end

function NewUserAndPlayerInfoView:RefreshID(arg_53_1)
	self.uid_.text = arg_53_1
end

function NewUserAndPlayerInfoView:RefreshName(arg_54_1)
	if not OperationData:IsOperationOpen(OperationConst.MANUAL_WORD_VERIFY) then
		local var_54_0, var_54_1 = wordVerify(arg_54_1, {
			isReplace = true
		})

		self.name_.text = var_54_1
	else
		self.name_.text = arg_54_1
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.namePanel_)
end

function NewUserAndPlayerInfoView:RefreshSign(arg_55_1)
	arg_55_1 = string.gsub(arg_55_1, "\n", "")

	if not OperationData:IsOperationOpen(OperationConst.MANUAL_WORD_VERIFY) then
		local var_55_0, var_55_1 = wordVerify(arg_55_1, {
			isReplace = true
		})

		self.signTxt_.text = var_55_1 == "" and GetTips("PROFILE_PERSONAL_PROFILE_DEFAULT") or var_55_1
	else
		self.signTxt_.text = arg_55_1 == "" and GetTips("PROFILE_PERSONAL_PROFILE_DEFAULT") or arg_55_1
	end
end

function NewUserAndPlayerInfoView:RefreshHead(arg_56_1)
	self.headPortrait:RenderHead(arg_56_1)
end

function NewUserAndPlayerInfoView:RefreshFrame(arg_57_1)
	self.headPortrait:RenderFrame(arg_57_1)
end

function NewUserAndPlayerInfoView:RefreshLvInfo(arg_58_1)
	self.lvTxt_.text = arg_58_1
end

function NewUserAndPlayerInfoView:RefreshGuild(arg_59_1, arg_59_2, arg_59_3)
	if arg_59_1 == 0 or arg_59_1 == "0" then
		self.guildCon_:SetSelectedState("false")
	else
		self.guildTxt_.text = arg_59_2

		if ClubHeadIconCfg[arg_59_3] then
			self.guildIconImg_.sprite = getSpriteViaConfig("ClubHeadIcon", ClubHeadIconCfg[arg_59_3].icon_bg)
		end

		self.guildCon_:SetSelectedState("true")
	end
end

function NewUserAndPlayerInfoView:RefreshBirthday()
	SetActive(self.birthdayPanelGo_, not self.isForeign_)

	if self.birthdayDay_ == 0 then
		SetActive(self.brithdayBtn_.gameObject, not self.isForeign_)
		SetActive(self.brithdayTxt_.gameObject, false)
	else
		SetActive(self.brithdayBtn_.gameObject, false)
		SetActive(self.brithdayTxt_.gameObject, true)

		self.brithdayTxt_.text = string.format(GetTips("OTHER_BIRTHDAY"), self.birthdayMonth_, self.birthdayDay_)
	end
end

function NewUserAndPlayerInfoView:RefreshDorm(arg_61_1, arg_61_2)
	if arg_61_1 == 0 then
		self.dormCon_:SetSelectedState("false")
	else
		self.dormText_.text = arg_61_2

		self.dormCon_:SetSelectedState("true")
	end
end

function NewUserAndPlayerInfoView:RefreshTag(arg_62_1)
	self.curTagList_ = arg_62_1

	self.tagCon_:SetSelectedState(#arg_62_1 > 0 and "off" or "on")
	self:StopTagScroll()

	for iter_62_0, iter_62_1 in ipairs(arg_62_1) do
		self.tagItem_[iter_62_0] = self.tagItem_[iter_62_0] or NewUserAndPlayerInfoTagItem.New((Object.Instantiate(self.tagTemplate_, self.tagContent_)))

		self.tagItem_[iter_62_0]:SetData(iter_62_1)
	end

	for iter_62_2 = #arg_62_1 + 1, #self.tagItem_ do
		self.tagItem_[iter_62_2]:Show(false)
	end

	local var_62_0 = var_0_2

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.tagPanel_)

	if var_0_2 >= self.tagContent_.transform.rect.width then
		self.tagContentFitter_.horizontalFit = ContentSizeFitter.FitMode.PreferredSize

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.tagScrollPanel_)
	else
		self.tagContentFitter_.horizontalFit = ContentSizeFitter.FitMode.Unconstrained
		self.tagScrollPanel_.sizeDelta = Vector2(var_0_2, self.tagScrollPanel_.sizeDelta.y)
		self.tagContent_.anchoredPosition = Vector3.New(0, self.tagContent_.anchoredPosition.y, 0)

		if self.isTagShow_ then
			return
		end

		self.tagScrollTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function()
			if self.tagContent_.anchoredPosition.x <= -1 * self.tagContent_.transform.rect.width then
				self.tagContent_.anchoredPosition = Vector3.New(var_62_0, self.tagContent_.anchoredPosition.y, 0)
			end

			self.tagContent_.anchoredPosition = Vector3.New(self.tagContent_.anchoredPosition.x - var_0_1, self.tagContent_.anchoredPosition.y, 0)
		end, -1, true)
	end
end

function NewUserAndPlayerInfoView:RefreshCardBg(arg_64_1)
	self.cardBgCon_:SetSelectedState("image")

	if ProfileDecorateItemCfg[arg_64_1].type == 1 then
		self.cardBgIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/UserInfor/" .. ProfileDecorateItemCfg[arg_64_1].resource)
	elseif ProfileDecorateItemCfg[arg_64_1].type == 2 then
		self.cardBgCon_:SetSelectedState("prefab")

		local var_64_0 = Asset.Load("Widget/System/PlayerProfileBg/PPBCode_" .. ProfileDecorateItemCfg[arg_64_1].resource)

		if var_64_0 then
			local var_64_1 = Object.Instantiate(var_64_0, self.cardBgPrefabRoot_)

			if var_64_1 then
				var_64_1.transform:SetParent(self.cardBgPrefabRoot_)

				var_64_1.transform.localScale = Vector3.New(1, 1, 1)
				var_64_1.transform.localPosition = Vector3.New(0, 0, 0)

				var_64_1:SetActive(true)
			end
		end
	elseif ProfileDecorateItemCfg[arg_64_1].type == 3 then
		-- block empty
	end
end

function NewUserAndPlayerInfoView:RefreshAchievement()
	self.heroTxt_.text = self.heroNum_ .. "/" .. self.heroAll_
	self.heroPre_.text = self.heroNum_ == self.heroAll_ and "100%" or math.floor(self.heroNum_ * 100 / self.heroAll_) .. "%"
	self.stickerTxt_.text = self.stickerNum_ .. "/" .. self.stickerAll_
	self.stickerPre_.text = self.stickerNum_ == self.stickerAll_ and "100%" or math.floor(self.stickerNum_ * 100 / self.stickerAll_) .. "%"
	self.weaponServantTxt_.text = self.weaponServantNum_ .. "/" .. self.weaponServantAll_
	self.weaponServantPre_.text = self.weaponServantNum_ == self.weaponServantAll_ and "100%" or math.floor(self.weaponServantNum_ * 100 / self.weaponServantAll_) .. "%"
	self.achieveTxt_.text = self.achieveNum_ .. "/" .. self.achieveAll_
	self.achievePre_.text = self.achieveNum_ == self.achieveAll_ and "100%" or math.floor(self.achieveNum_ * 100 / self.achieveAll_) .. "%"
end

function NewUserAndPlayerInfoView:RefreshLike(arg_66_1)
	self.like_.text = arg_66_1 >= 10000 and string.format("%.1f", arg_66_1 / 1000) .. "K" or arg_66_1

	if not self.isForeign_ then
		self.likeCon_:SetSelectedState("on")
	else
		self.likeCon_:SetSelectedState(table.indexof(self.todaySendLike_, self.userID_) and "off" or "on")
	end
end

function NewUserAndPlayerInfoView:RefreshGirl(arg_67_1)
	if self.isForeign_ then
		local var_67_0

		if arg_67_1 == 0 then
			arg_67_1 = 1084
			var_67_0 = {
				isForeign = true,
				heroID = SkinCfg[arg_67_1].hero,
				skinID = arg_67_1
			}
		end

		var_67_0.oath = nullable(self.hero_oath_display, SkinCfg[arg_67_1].hero, "oath")

		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.playerInfo_other, var_67_0)
	else
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.playerInfo)
	end
end

function NewUserAndPlayerInfoView:RefreshScene()
	if not self.isForeign_ then
		local var_68_0 = manager.loadScene:GetTimeSceneID((HomeSceneSettingData:GetCurScene()))

		if CameraCfg["t0_playerInfo_" .. var_68_0] and PosterGirlConst.PosterGirlTag.t0 == manager.posterGirl:GetTag() then
			manager.ui:SetMainCamera("t0_playerInfo_" .. var_68_0)
		elseif CameraCfg["playerInfo_" .. var_68_0] then
			manager.ui:SetMainCamera("playerInfo_" .. var_68_0)
		else
			manager.ui:SetMainCamera("playerInfo", false, false)
		end
	else
		local var_68_1 = var_0_3()

		manager.loadScene:SetSceneDisableAutoChange(true)
		manager.loadScene:SetSceneDisableAutoChange(false)
		self:DestoryBackGround()

		self.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
		self.backGroundTrs_ = self.backGround_.transform

		self.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

		self.backGroundTrs_.localPosition = Vector3(GameSetting.profile_other_players_coordinate.value[1], GameSetting.profile_other_players_coordinate.value[2], GameSetting.profile_other_players_coordinate.value[3])
		self.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
		self.backGroundTrs_.localScale = Vector3(11, 11, 1)
		self.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureConfig/BackgroundQuad/" .. manager.loadScene:GetHomeShouldLoadSceneName(var_68_1, true))

		manager.ui:SetMainCamera("playerInfo", false, true)
	end
end

function NewUserAndPlayerInfoView:TagSelectCallback(arg_69_1)
	self:RefreshTag(arg_69_1)
end

function NewUserAndPlayerInfoView:HidePop()
	SetActive(self.goPop_, false)
end

function NewUserAndPlayerInfoView:ShowTagView()
	self.isTagShow_ = true

	self.tagSelectPanel_:Show(true)
	self.tagSelectPanel_:RefreshUI()
	SetActive(self.hideTagBtn_.gameObject, true)
	self:RefreshTag(self.curTagList_)
end

function NewUserAndPlayerInfoView:HideTagView()
	if self.isTagShow_ then
		PlayerData:DealOverdueTagList()
		PlayerData:ClearTagRed()
	end

	self.isTagShow_ = false

	self.tagSelectPanel_:Show(false)
	SetActive(self.hideTagBtn_.gameObject, false)
end

function NewUserAndPlayerInfoView:AddClickTimer()
	self:StopTimer()

	self.buttonUp_ = 0
	self.clickTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function()
		if Input.GetMouseButtonUp(0) then
			self.buttonUp_ = self.buttonUp_ + 1

			if self.buttonUp_ >= 2 then
				self:HidePop()
				FuncTimerManager.inst:RemoveFuncTimer(self.clickTimer_)

				self.clickTimer_ = nil
			end
		end
	end, -1, true)
end

function NewUserAndPlayerInfoView:StopTimer()
	if self.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(self.clickTimer_)

		self.clickTimer_ = nil
	end
end

function NewUserAndPlayerInfoView:StopTagScroll()
	if self.tagScrollTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(self.tagScrollTimer_)

		self.tagScrollTimer_ = nil
	end
end

function NewUserAndPlayerInfoView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.brithdayBtn_.transform, RedPointConst.BRITHDAY)
	manager.redPoint:bindUIandKey(self.stickerRedPanel_, RedPointConst.CUSTOM_STICKER_ROOT)
	manager.redPoint:bindUIandKey(self.portraitObj_.transform, RedPointConst.USER_CUSTOM)
	manager.redPoint:bindUIandKey(self.tagBtn_.transform, RedPointConst.TAG)
end

function NewUserAndPlayerInfoView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.brithdayBtn_.transform, RedPointConst.BRITHDAY)
	manager.redPoint:unbindUIandKey(self.stickerRedPanel_, RedPointConst.CUSTOM_STICKER_ROOT)
	manager.redPoint:unbindUIandKey(self.portraitObj_.transform, RedPointConst.USER_CUSTOM)
	manager.redPoint:unbindUIandKey(self.tagBtn_.transform, RedPointConst.TAG)
end

function NewUserAndPlayerInfoView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back(nil, {
			userID = self.userID_
		})
	end)
end

function NewUserAndPlayerInfoView:OnChangeNickname(arg_81_1)
	self:RefreshName(arg_81_1.nick)
end

function NewUserAndPlayerInfoView:OnChangeSign(arg_82_1, arg_82_2, arg_82_3)
	SetActive(self.signInput_.gameObject, false)
	SetActive(self.signTxt_.gameObject, true)

	self.sign_ = arg_82_2.sign

	self:RefreshSign(arg_82_2.sign)

	if arg_82_3 then
		ShowTips("NOT_SUPPORTED_LINE_FEED")
	else
		ShowTips("SUCCESS_CHANGE_SIGNATURE")
	end
end

function NewUserAndPlayerInfoView:OnChangePortrait()
	self:RefreshHead(PlayerData:GetPlayerInfo().portrait)
end

function NewUserAndPlayerInfoView:OnChangeFrame()
	self:RefreshFrame(PlayerData:GetPlayerInfo().icon_frame)
end

function NewUserAndPlayerInfoView:OnChangeBirthday()
	self.birthdayMonth_, self.birthdayDay_ = PlayerData:GetPlayerBrithday()

	self:RefreshBirthday()
end

function NewUserAndPlayerInfoView:OnChangeCardBg(arg_86_1)
	local var_86_0 = PlayerData:GetPlayerInfo()

	self:RefreshCardBg(arg_86_1)
end

function NewUserAndPlayerInfoView:OnChangTagList()
	self.tagList_ = PlayerData:GetUsingTagListInfo()

	self:RefreshTag(self.tagList_)
end

function NewUserAndPlayerInfoView:OnGetLike()
	self.likeCnt_ = PlayerData:GetPlayerInfo().likes

	self:RefreshLike(self.likeCnt_)
end

function NewUserAndPlayerInfoView:OnSendLike()
	self.todaySendLike_ = PlayerData:GetTodaySendLikeList() or {}

	SetActive(self.likeAddGo_, true)

	self.likeCnt_ = self.likeCnt_ + 1

	self:RefreshLike(self.likeCnt_)
end

function NewUserAndPlayerInfoView:OnFriendsDelect(arg_90_1)
	if arg_90_1 == self.userID_ then
		self:Back()
	end
end

function NewUserAndPlayerInfoView:OnCheckForeignInfo(arg_91_1)
	self.params_.isForeign = arg_91_1.isForeign
	self.isForeign_ = arg_91_1.isForeign

	self:OnEnter()
end

function NewUserAndPlayerInfoView:DestoryBackGround()
	if self.backGround_ then
		manager.resourcePool:DestroyOrReturn(self.backGround_, ASSET_TYPE.SCENE)

		self.backGround_ = nil
	end
end

function NewUserAndPlayerInfoView:RefreshBgImage()
	local var_93_0 = manager.windowBar:GetWhereTag()

	if var_93_0 == "canteen" or var_93_0 == "dorm" or var_93_0 == "danceGame" or var_93_0 == "minigame" then
		SetActive(self.bgImg_.gameObject, true)

		local var_93_1 = self.isForeign_ and ForeignInfoData:GetCurForeignDetailInfo().post_background_id or HomeSceneSettingData:GetCurScene()

		manager.loadScene:SetSceneDisableAutoChange(true)
		manager.loadScene:SetSceneDisableAutoChange(false)

		self.bgImg_.spriteSync = "TextureConfig/BackgroundQuad/" .. manager.loadScene:GetHomeShouldLoadSceneName(var_93_1, self.isForeign_)
	else
		SetActive(self.bgImg_.gameObject, false)
	end
end

function NewUserAndPlayerInfoView:OnExit()
	self:StopTagScroll()
	self:StopTimer()
	manager.windowBar:HideBar()
	self.tagSelectPanel_:OnExit()
	manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.null)

	for iter_94_0, iter_94_1 in ipairs(self.tagItem_) do
		iter_94_1:OnExit()
	end

	self:DestoryBackGround()
	manager.ui:ResetMainCamera()

	self.stickerList_ = {}

	self:UnbindRedPoint()
	self:HidePop()
end

function NewUserAndPlayerInfoView:Dispose()
	self.signInput_.onEndEdit:RemoveAllListeners()
	self.tagSelectPanel_:Dispose()

	for iter_95_0, iter_95_1 in ipairs(self.tagItem_) do
		iter_95_1:Dispose()
	end

	self.headPortrait:Dispose()

	self.headPortrait = nil

	self:RemoveAllListeners()
	NewUserAndPlayerInfoView.super.Dispose(self)
end

return NewUserAndPlayerInfoView

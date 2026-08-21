local var_0_0 = class("NewUserInfoPreviewView", ReduxView)
local var_0_1 = 1
local var_0_2 = 860

function var_0_0.UIName(arg_1_0)
	return "UI/Main/PlayercardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.commonPortrait_ = CommonHeadPortrait.New(arg_4_0.headItem_)

	local var_4_0 = GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV or not SDKTools.GetIsOverSea() and _G.CHANNEL_MASTER_ID ~= 1

	SetActive(arg_4_0.userCenterBtn_.gameObject, not var_4_0)
	SetActive(arg_4_0.logoutBtn_.gameObject, var_4_0)

	arg_4_0.tagItem_ = {}
	arg_4_0.tagContentFitter_ = arg_4_0.tagScrollPanel_:GetComponent("ContentSizeFitter")
	arg_4_0.tagCon_ = ControllerUtil.GetController(arg_4_0.transform_, "tag")
	arg_4_0.dormCon_ = ControllerUtil.GetController(arg_4_0.transform_, "dorm")
	arg_4_0.guildCon_ = ControllerUtil.GetController(arg_4_0.transform_, "guild")
	arg_4_0.cardBgCon_ = arg_4_0.transform_:GetComponent("ControllerExCollection"):GetController("bgType")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0:RefreshUserData()
	arg_8_0:RefreshExpInfo(arg_8_0.lv_, arg_8_0.exp_)
	arg_8_0:RefreshIP(arg_8_0.ip_)
	arg_8_0:RefreshID(arg_8_0.userID_)
	arg_8_0:RefreshName(arg_8_0.nick_)
	SetActive(arg_8_0.signInput_.gameObject, false)
	SetActive(arg_8_0.signTxt_.gameObject, true)
	arg_8_0:RefreshSign(arg_8_0.sign_)
	arg_8_0:RefreshLvInfo(arg_8_0.lv_)
	arg_8_0:RefreshHead(arg_8_0.headIconID_)
	arg_8_0:RefreshFrame(arg_8_0.iconFrameID_)
	arg_8_0:RefreshGuild(arg_8_0.guildID_, arg_8_0.guildName_)
	arg_8_0:RefreshBirthday()
	arg_8_0:RefreshTag(arg_8_0.tagList_)
	arg_8_0:RefreshCardBg(arg_8_0.cardBg_)
	arg_8_0:RefreshDorm(arg_8_0.dormID_, arg_8_0.dormName_)
	arg_8_0:RefreshAchievement()
	arg_8_0:RefreshLike(arg_8_0.likeCnt_)
end

function var_0_0.RefreshUserData(arg_9_0)
	local var_9_0 = PlayerData:GetPlayerInfo()

	arg_9_0.ip_ = var_9_0.ip
	arg_9_0.nick_ = var_9_0.nick
	arg_9_0.sign_ = var_9_0.sign
	arg_9_0.lv_ = var_9_0.userLevel
	arg_9_0.userID_ = var_9_0.userID
	arg_9_0.exp_ = var_9_0.remain_exp
	arg_9_0.headIconID_ = var_9_0.portrait
	arg_9_0.iconFrameID_ = var_9_0.icon_frame
	arg_9_0.birthdayMonth_ = var_9_0.birthday_month
	arg_9_0.birthdayDay_ = var_9_0.birthday_day
	arg_9_0.likeCnt_ = var_9_0.likes
	arg_9_0.cardBg_ = arg_9_0.params_.previewID
	arg_9_0.tagList_ = PlayerData:GetUsingTagListInfo()

	local var_9_1 = GuildData:GetGuildInfo()

	if var_9_1 and var_9_1.id and var_9_1.name then
		arg_9_0.guildID_ = var_9_1.id
		arg_9_0.guildName_ = var_9_1.name
	else
		arg_9_0.guildID_ = 0
		arg_9_0.guildName_ = ""
	end

	arg_9_0.dormID_ = 0
	arg_9_0.dormName_ = ""

	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		local var_9_2 = DormVisitTools:GetCurTemplateExhibit()

		arg_9_0.dormID_ = var_9_2 == 0 and DormConst.PUBLIC_DORM_ID or var_9_2

		if BackHomeCfg[arg_9_0.dormID_].type == DormConst.BACKHOME_TYPE.PublicDorm then
			arg_9_0.dormName_ = GetTips("DORM_LOBBY_NAME")
		else
			local var_9_3 = DormitoryData:GetDormSceneData(arg_9_0.dormID_).archiveIDList[1]
			local var_9_4 = HeroRecordCfg.get_id_list_by_hero_id[var_9_3][1]

			if var_9_4 then
				local var_9_5 = HeroRecordCfg[var_9_4].name

				if var_9_5 then
					arg_9_0.dormName_ = string.format(GetTips("DORM_HERO_ROOM_NAME"), var_9_5)
				end
			end
		end
	end

	arg_9_0.heroNum_ = HeroTools.GetFilteredHeroNum(HeroTools.FilterHeroFunc.ObtainedNotHide)
	arg_9_0.heroAll_ = HeroTools.GetFilteredHeroNum(HeroTools.FilterHeroFunc.AllNotHide)
	arg_9_0.weaponServantAll_ = 0
	arg_9_0.weaponServantNum_ = table.length(IllustratedData:GetServantInfo())

	for iter_9_0, iter_9_1 in ipairs(WeaponServantCfg.all) do
		local var_9_6 = IllustratedData:GetServantInfo()[iter_9_1]

		if not ServantTools.GetIsHide(iter_9_1) and (var_9_6 or WeaponServantCfg[iter_9_1].display_type ~= 1) then
			arg_9_0.weaponServantAll_ = arg_9_0.weaponServantAll_ + 1
		end
	end

	arg_9_0.stickerAll_ = #PlayerData:GetStickerList(true) + #PlayerData:GetStickerBgList(true) + #PlayerData:GetStickerFgList(true)
	arg_9_0.stickerNum_ = #PlayerData:GetStickerList() + #PlayerData:GetStickerBgList() + #PlayerData:GetStickerFgList()
	arg_9_0.achieveAll_ = AchievementData:GetAchievementTotalCnt()
	arg_9_0.achieveNum_ = AchievementData:GetFinishAchievementCnt()
end

function var_0_0.RefreshExpInfo(arg_10_0, arg_10_1, arg_10_2)
	if LvTools.GetIsMaxLv(arg_10_1, "user") then
		arg_10_0.expTxt_.text = "-/-"
		arg_10_0.progressTrs_.value = 1
	else
		local var_10_0 = GameLevelSetting[arg_10_1].user_level_exp

		arg_10_0.expTxt_.text = string.format("%d/%d", arg_10_2, var_10_0)
		arg_10_0.progressTrs_.value = arg_10_2 / var_10_0
	end
end

function var_0_0.RefreshIP(arg_11_0, arg_11_1)
	SetActive(arg_11_0.ipGo_, GameToSDK.CURRENT_SERVER == AreaConst.CHINA)

	arg_11_0.ipTxt_.text = arg_11_1

	if arg_11_0.ipGo_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.ipGo_.transform)
	end
end

function var_0_0.RefreshID(arg_12_0, arg_12_1)
	arg_12_0.uid_.text = arg_12_1
end

function var_0_0.RefreshName(arg_13_0, arg_13_1)
	if not OperationData:IsOperationOpen(OperationConst.MANUAL_WORD_VERIFY) then
		local var_13_0, var_13_1 = wordVerify(arg_13_1, {
			isReplace = true
		})

		arg_13_0.name_.text = var_13_1
	else
		arg_13_0.name_.text = arg_13_1
	end
end

function var_0_0.RefreshSign(arg_14_0, arg_14_1)
	if not OperationData:IsOperationOpen(OperationConst.MANUAL_WORD_VERIFY) then
		local var_14_0, var_14_1 = wordVerify(arg_14_1, {
			isReplace = true
		})

		arg_14_0.signTxt_.text = var_14_1 == "" and GetTips("PROFILE_PERSONAL_PROFILE_DEFAULT") or var_14_1
	else
		arg_14_0.signTxt_.text = arg_14_1 == "" and GetTips("PROFILE_PERSONAL_PROFILE_DEFAULT") or arg_14_1
	end
end

function var_0_0.RefreshHead(arg_15_0, arg_15_1)
	arg_15_0.commonPortrait_:RenderHead(arg_15_1)
end

function var_0_0.RefreshFrame(arg_16_0, arg_16_1)
	arg_16_0.commonPortrait_:RenderFrame(arg_16_1)
end

function var_0_0.RefreshLvInfo(arg_17_0, arg_17_1)
	arg_17_0.lvTxt_.text = arg_17_1
end

function var_0_0.RefreshGuild(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 == 0 then
		arg_18_0.guildCon_:SetSelectedState("false")
	else
		arg_18_0.guildTxt_.text = arg_18_2

		arg_18_0.guildCon_:SetSelectedState("true")
	end
end

function var_0_0.RefreshBirthday(arg_19_0)
	if arg_19_0.birthdayDay_ == 0 then
		arg_19_0.brithdayTxt_.text = GetTips("UNSET_BIRTHDAY")
	else
		arg_19_0.brithdayTxt_.text = string.format(GetTips("OTHER_BIRTHDAY"), arg_19_0.birthdayMonth_, arg_19_0.birthdayDay_)
	end
end

function var_0_0.RefreshDorm(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 == 0 then
		arg_20_0.dormCon_:SetSelectedState("false")
	else
		arg_20_0.dormText_.text = arg_20_2

		arg_20_0.dormCon_:SetSelectedState("true")
	end
end

function var_0_0.RefreshTag(arg_21_0, arg_21_1)
	arg_21_0.tagCon_:SetSelectedState(#arg_21_1 > 0 and "off" or "on")
	arg_21_0:StopTagScroll()

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		if not arg_21_0.tagItem_[iter_21_0] then
			local var_21_0 = Object.Instantiate(arg_21_0.tagTemplate_, arg_21_0.tagContent_)

			arg_21_0.tagItem_[iter_21_0] = NewUserAndPlayerInfoTagItem.New(var_21_0)
		end

		arg_21_0.tagItem_[iter_21_0]:SetData(iter_21_1)
	end

	for iter_21_2 = #arg_21_1 + 1, #arg_21_0.tagItem_ do
		arg_21_0.tagItem_[iter_21_2]:Show(false)
	end

	local var_21_1 = var_0_2

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_0.tagPanel_)

	if var_21_1 >= arg_21_0.tagContent_.transform.rect.width then
		arg_21_0.tagContentFitter_.horizontalFit = ContentSizeFitter.FitMode.PreferredSize

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_0.tagScrollPanel_)
	else
		arg_21_0.tagContentFitter_.horizontalFit = ContentSizeFitter.FitMode.Unconstrained
		arg_21_0.tagScrollPanel_.sizeDelta = Vector2(var_21_1, arg_21_0.tagScrollPanel_.sizeDelta.y)
		arg_21_0.tagContent_.anchoredPosition = Vector3.New(0, arg_21_0.tagContent_.anchoredPosition.y, 0)
		arg_21_0.tagScrollTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function()
			if arg_21_0.tagContent_.anchoredPosition.x <= -1 * arg_21_0.tagContent_.transform.rect.width then
				arg_21_0.tagContent_.anchoredPosition = Vector3.New(var_21_1, arg_21_0.tagContent_.anchoredPosition.y, 0)
			end

			arg_21_0.tagContent_.anchoredPosition = Vector3.New(arg_21_0.tagContent_.anchoredPosition.x - var_0_1, arg_21_0.tagContent_.anchoredPosition.y, 0)
		end, -1, true)
	end
end

function var_0_0.RefreshCardBg(arg_23_0, arg_23_1)
	local var_23_0 = ProfileDecorateItemCfg[arg_23_1]
	local var_23_1 = var_23_0.resource

	arg_23_0.cardBgCon_:SetSelectedState("image")

	if var_23_0.type == 1 then
		arg_23_0.cardBgIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/UserInfor/" .. var_23_1)
	elseif var_23_0.type == 2 then
		arg_23_0.cardBgCon_:SetSelectedState("prefab")

		local var_23_2 = Asset.Load("Widget/System/PlayerProfileBg/PPBCode_" .. var_23_1)

		if var_23_2 then
			local var_23_3 = Object.Instantiate(var_23_2, arg_23_0.cardBgPrefabRoot_)

			if var_23_3 then
				var_23_3.transform:SetParent(arg_23_0.cardBgPrefabRoot_)

				var_23_3.transform.localScale = Vector3.New(1, 1, 1)
				var_23_3.transform.localPosition = Vector3.New(0, 0, 0)

				var_23_3:SetActive(true)
			end
		end
	elseif var_23_0.type == 3 then
		-- block empty
	end

	arg_23_0.cardName_.text = "<" .. ItemTools.getItemName(arg_23_1) .. ">"
end

function var_0_0.RefreshAchievement(arg_24_0)
	arg_24_0.heroTxt_.text = arg_24_0.heroNum_ .. "/" .. arg_24_0.heroAll_

	if arg_24_0.heroNum_ == arg_24_0.heroAll_ then
		arg_24_0.heroPre_.text = "100%"
	else
		arg_24_0.heroPre_.text = math.floor(arg_24_0.heroNum_ * 100 / arg_24_0.heroAll_) .. "%"
	end

	arg_24_0.stickerTxt_.text = arg_24_0.stickerNum_ .. "/" .. arg_24_0.stickerAll_

	if arg_24_0.stickerNum_ == arg_24_0.stickerAll_ then
		arg_24_0.stickerPre_.text = "100%"
	else
		arg_24_0.stickerPre_.text = math.floor(arg_24_0.stickerNum_ * 100 / arg_24_0.stickerAll_) .. "%"
	end

	arg_24_0.weaponServantTxt_.text = arg_24_0.weaponServantNum_ .. "/" .. arg_24_0.weaponServantAll_

	if arg_24_0.weaponServantNum_ == arg_24_0.weaponServantAll_ then
		arg_24_0.weaponServantPre_.text = "100%"
	else
		arg_24_0.weaponServantPre_.text = math.floor(arg_24_0.weaponServantNum_ * 100 / arg_24_0.weaponServantAll_) .. "%"
	end

	arg_24_0.achieveTxt_.text = arg_24_0.achieveNum_ .. "/" .. arg_24_0.achieveAll_

	if arg_24_0.achieveNum_ == arg_24_0.achieveAll_ then
		arg_24_0.achievePre_.text = "100%"
	else
		arg_24_0.achievePre_.text = math.floor(arg_24_0.achieveNum_ * 100 / arg_24_0.achieveAll_) .. "%"
	end
end

function var_0_0.RefreshLike(arg_25_0, arg_25_1)
	if arg_25_1 > 10000 then
		arg_25_0.like_.text = string.format("%.1f%%", arg_25_1 / 1000) .. "K"
	else
		arg_25_0.like_.text = arg_25_1
	end
end

function var_0_0.StopTagScroll(arg_26_0)
	if arg_26_0.tagScrollTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(arg_26_0.tagScrollTimer_)

		arg_26_0.tagScrollTimer_ = nil
	end
end

function var_0_0.OnTop(arg_27_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_28_0)
	arg_28_0:StopTagScroll()

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.tagItem_) do
		iter_28_1:OnExit()
	end
end

function var_0_0.Dispose(arg_29_0)
	arg_29_0.commonPortrait_:Dispose()
	arg_29_0:RemoveAllListeners()

	for iter_29_0, iter_29_1 in ipairs(arg_29_0.tagItem_) do
		iter_29_1:Dispose()
	end

	var_0_0.super.Dispose(arg_29_0)
end

return var_0_0

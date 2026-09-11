local NewUserInfoPreviewView = class("NewUserInfoPreviewView", ReduxView)
local var_0_1 = 1
local var_0_2 = 860

function NewUserInfoPreviewView:UIName()
	return "UI/Main/PlayercardUI"
end

function NewUserInfoPreviewView:UIParent()
	return manager.ui.uiPop.transform
end

function NewUserInfoPreviewView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function NewUserInfoPreviewView:InitUI()
	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	local var_4_0 = GameToSDK.CURRENT_SDK_ID == SDK_PLATFORM.DEV or not SDKTools.GetIsOverSea() and _G.CHANNEL_MASTER_ID ~= 1

	SetActive(self.userCenterBtn_.gameObject, not var_4_0)
	SetActive(self.logoutBtn_.gameObject, var_4_0)

	self.tagItem_ = {}
	self.tagContentFitter_ = self.tagScrollPanel_:GetComponent("ContentSizeFitter")
	self.tagCon_ = ControllerUtil.GetController(self.transform_, "tag")
	self.dormCon_ = ControllerUtil.GetController(self.transform_, "dorm")
	self.guildCon_ = ControllerUtil.GetController(self.transform_, "guild")
	self.cardBgCon_ = self.transform_:GetComponent("ControllerExCollection"):GetController("bgType")
end

function NewUserInfoPreviewView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function NewUserInfoPreviewView:OnEnter()
	self:RefreshUI()
end

function NewUserInfoPreviewView:RefreshUI()
	self:RefreshUserData()
	self:RefreshExpInfo(self.lv_, self.exp_)
	self:RefreshIP(self.ip_)
	self:RefreshID(self.userID_)
	self:RefreshName(self.nick_)
	SetActive(self.signInput_.gameObject, false)
	SetActive(self.signTxt_.gameObject, true)
	self:RefreshSign(self.sign_)
	self:RefreshLvInfo(self.lv_)
	self:RefreshHead(self.headIconID_)
	self:RefreshFrame(self.iconFrameID_)
	self:RefreshGuild(self.guildID_, self.guildName_)
	self:RefreshBirthday()
	self:RefreshTag(self.tagList_)
	self:RefreshCardBg(self.cardBg_)
	self:RefreshDorm(self.dormID_, self.dormName_)
	self:RefreshAchievement()
	self:RefreshLike(self.likeCnt_)
end

function NewUserInfoPreviewView:RefreshUserData()
	local var_9_0 = PlayerData:GetPlayerInfo()

	self.ip_ = var_9_0.ip
	self.nick_ = var_9_0.nick
	self.sign_ = var_9_0.sign
	self.lv_ = var_9_0.userLevel
	self.userID_ = var_9_0.userID
	self.exp_ = var_9_0.remain_exp
	self.headIconID_ = var_9_0.portrait
	self.iconFrameID_ = var_9_0.icon_frame
	self.birthdayMonth_ = var_9_0.birthday_month
	self.birthdayDay_ = var_9_0.birthday_day
	self.likeCnt_ = var_9_0.likes
	self.cardBg_ = self.params_.previewID
	self.tagList_ = PlayerData:GetUsingTagListInfo()

	local var_9_1 = GuildData:GetGuildInfo()

	if var_9_1 and var_9_1.id and var_9_1.name then
		self.guildID_ = var_9_1.id
		self.guildName_ = var_9_1.name
	else
		self.guildID_ = 0
		self.guildName_ = ""
	end

	self.dormID_ = 0
	self.dormName_ = ""

	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		local var_9_2 = DormVisitTools:GetCurTemplateExhibit()

		if var_9_2 == 0 then
			self.dormID_ = DormConst.PUBLIC_DORM_ID or var_9_2
		end

		if BackHomeCfg[self.dormID_].type == DormConst.BACKHOME_TYPE.PublicDorm then
			self.dormName_ = GetTips("DORM_LOBBY_NAME")
		elseif HeroRecordCfg.get_id_list_by_hero_id[DormitoryData:GetDormSceneData(self.dormID_).archiveIDList[1]][1] then
			if HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[DormitoryData:GetDormSceneData(self.dormID_).archiveIDList[1]][1]].name then
				self.dormName_ = string.format(GetTips("DORM_HERO_ROOM_NAME"), HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[DormitoryData:GetDormSceneData(self.dormID_).archiveIDList[1]][1]].name)
			end
		end
	end

	self.heroNum_ = HeroTools.GetFilteredHeroNum(HeroTools.FilterHeroFunc.ObtainedNotHide)
	self.heroAll_ = HeroTools.GetFilteredHeroNum(HeroTools.FilterHeroFunc.AllNotHide)
	self.weaponServantAll_ = 0
	self.weaponServantNum_ = table.length(IllustratedData:GetServantInfo())

	for iter_9_0, iter_9_1 in ipairs(WeaponServantCfg.all) do
		if not ServantTools.GetIsHide(iter_9_1) and (IllustratedData:GetServantInfo()[iter_9_1] or WeaponServantCfg[iter_9_1].display_type ~= 1) then
			self.weaponServantAll_ = self.weaponServantAll_ + 1
		end
	end

	self.stickerAll_ = #PlayerData:GetStickerList(true) + #PlayerData:GetStickerBgList(true) + #PlayerData:GetStickerFgList(true)
	self.stickerNum_ = #PlayerData:GetStickerList() + #PlayerData:GetStickerBgList() + #PlayerData:GetStickerFgList()
	self.achieveAll_ = AchievementData:GetAchievementTotalCnt()
	self.achieveNum_ = AchievementData:GetFinishAchievementCnt()
end

function NewUserInfoPreviewView:RefreshExpInfo(arg_10_1, arg_10_2)
	if LvTools.GetIsMaxLv(arg_10_1, "user") then
		self.expTxt_.text = "-/-"
		self.progressTrs_.value = 1
	else
		local var_10_0 = GameLevelSetting[arg_10_1].user_level_exp

		self.expTxt_.text = string.format("%d/%d", arg_10_2, GameLevelSetting[arg_10_1].user_level_exp)
		self.progressTrs_.value = arg_10_2 / var_10_0
	end
end

function NewUserInfoPreviewView:RefreshIP(arg_11_1)
	SetActive(self.ipGo_, GameToSDK.CURRENT_SERVER == AreaConst.CHINA)

	self.ipTxt_.text = arg_11_1

	if self.ipGo_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ipGo_.transform)
	end
end

function NewUserInfoPreviewView:RefreshID(arg_12_1)
	self.uid_.text = arg_12_1
end

function NewUserInfoPreviewView:RefreshName(arg_13_1)
	if not OperationData:IsOperationOpen(OperationConst.MANUAL_WORD_VERIFY) then
		local var_13_0, var_13_1 = wordVerify(arg_13_1, {
			isReplace = true
		})

		self.name_.text = var_13_1
	else
		self.name_.text = arg_13_1
	end
end

function NewUserInfoPreviewView:RefreshSign(arg_14_1)
	if not OperationData:IsOperationOpen(OperationConst.MANUAL_WORD_VERIFY) then
		local var_14_0, var_14_1 = wordVerify(arg_14_1, {
			isReplace = true
		})

		self.signTxt_.text = var_14_1 == "" and GetTips("PROFILE_PERSONAL_PROFILE_DEFAULT") or var_14_1
	else
		self.signTxt_.text = arg_14_1 == "" and GetTips("PROFILE_PERSONAL_PROFILE_DEFAULT") or arg_14_1
	end
end

function NewUserInfoPreviewView:RefreshHead(arg_15_1)
	self.commonPortrait_:RenderHead(arg_15_1)
end

function NewUserInfoPreviewView:RefreshFrame(arg_16_1)
	self.commonPortrait_:RenderFrame(arg_16_1)
end

function NewUserInfoPreviewView:RefreshLvInfo(arg_17_1)
	self.lvTxt_.text = arg_17_1
end

function NewUserInfoPreviewView:RefreshGuild(arg_18_1, arg_18_2)
	if arg_18_1 == 0 then
		self.guildCon_:SetSelectedState("false")
	else
		self.guildTxt_.text = arg_18_2

		self.guildCon_:SetSelectedState("true")
	end
end

function NewUserInfoPreviewView:RefreshBirthday()
	self.brithdayTxt_.text = self.birthdayDay_ == 0 and GetTips("UNSET_BIRTHDAY") or string.format(GetTips("OTHER_BIRTHDAY"), self.birthdayMonth_, self.birthdayDay_)
end

function NewUserInfoPreviewView:RefreshDorm(arg_20_1, arg_20_2)
	if arg_20_1 == 0 then
		self.dormCon_:SetSelectedState("false")
	else
		self.dormText_.text = arg_20_2

		self.dormCon_:SetSelectedState("true")
	end
end

function NewUserInfoPreviewView:RefreshTag(arg_21_1)
	self.tagCon_:SetSelectedState(#arg_21_1 > 0 and "off" or "on")
	self:StopTagScroll()

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		self.tagItem_[iter_21_0] = self.tagItem_[iter_21_0] or NewUserAndPlayerInfoTagItem.New((Object.Instantiate(self.tagTemplate_, self.tagContent_)))

		self.tagItem_[iter_21_0]:SetData(iter_21_1)
	end

	for iter_21_2 = #arg_21_1 + 1, #self.tagItem_ do
		self.tagItem_[iter_21_2]:Show(false)
	end

	local var_21_0 = var_0_2

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.tagPanel_)

	if var_0_2 >= self.tagContent_.transform.rect.width then
		self.tagContentFitter_.horizontalFit = ContentSizeFitter.FitMode.PreferredSize

		LayoutRebuilder.ForceRebuildLayoutImmediate(self.tagScrollPanel_)
	else
		self.tagContentFitter_.horizontalFit = ContentSizeFitter.FitMode.Unconstrained
		self.tagScrollPanel_.sizeDelta = Vector2(var_0_2, self.tagScrollPanel_.sizeDelta.y)
		self.tagContent_.anchoredPosition = Vector3.New(0, self.tagContent_.anchoredPosition.y, 0)
		self.tagScrollTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function()
			if self.tagContent_.anchoredPosition.x <= -1 * self.tagContent_.transform.rect.width then
				self.tagContent_.anchoredPosition = Vector3.New(var_21_0, self.tagContent_.anchoredPosition.y, 0)
			end

			self.tagContent_.anchoredPosition = Vector3.New(self.tagContent_.anchoredPosition.x - var_0_1, self.tagContent_.anchoredPosition.y, 0)
		end, -1, true)
	end
end

function NewUserInfoPreviewView:RefreshCardBg(arg_23_1)
	self.cardBgCon_:SetSelectedState("image")

	if ProfileDecorateItemCfg[arg_23_1].type == 1 then
		self.cardBgIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/UserInfor/" .. ProfileDecorateItemCfg[arg_23_1].resource)
	elseif ProfileDecorateItemCfg[arg_23_1].type == 2 then
		self.cardBgCon_:SetSelectedState("prefab")

		local var_23_0 = Asset.Load("Widget/System/PlayerProfileBg/PPBCode_" .. ProfileDecorateItemCfg[arg_23_1].resource)

		if var_23_0 then
			local var_23_1 = Object.Instantiate(var_23_0, self.cardBgPrefabRoot_)

			if var_23_1 then
				var_23_1.transform:SetParent(self.cardBgPrefabRoot_)

				var_23_1.transform.localScale = Vector3.New(1, 1, 1)
				var_23_1.transform.localPosition = Vector3.New(0, 0, 0)

				var_23_1:SetActive(true)
			end
		end
	elseif ProfileDecorateItemCfg[arg_23_1].type == 3 then
		-- block empty
	end

	self.cardName_.text = "<" .. ItemTools.getItemName(arg_23_1) .. ">"
end

function NewUserInfoPreviewView:RefreshAchievement()
	self.heroTxt_.text = self.heroNum_ .. "/" .. self.heroAll_
	self.heroPre_.text = self.heroNum_ == self.heroAll_ and "100%" or math.floor(self.heroNum_ * 100 / self.heroAll_) .. "%"
	self.stickerTxt_.text = self.stickerNum_ .. "/" .. self.stickerAll_
	self.stickerPre_.text = self.stickerNum_ == self.stickerAll_ and "100%" or math.floor(self.stickerNum_ * 100 / self.stickerAll_) .. "%"
	self.weaponServantTxt_.text = self.weaponServantNum_ .. "/" .. self.weaponServantAll_
	self.weaponServantPre_.text = self.weaponServantNum_ == self.weaponServantAll_ and "100%" or math.floor(self.weaponServantNum_ * 100 / self.weaponServantAll_) .. "%"
	self.achieveTxt_.text = self.achieveNum_ .. "/" .. self.achieveAll_
	self.achievePre_.text = self.achieveNum_ == self.achieveAll_ and "100%" or math.floor(self.achieveNum_ * 100 / self.achieveAll_) .. "%"
end

function NewUserInfoPreviewView:RefreshLike(arg_25_1)
	self.like_.text = arg_25_1 > 10000 and string.format("%.1f%%", arg_25_1 / 1000) .. "K" or arg_25_1
end

function NewUserInfoPreviewView:StopTagScroll()
	if self.tagScrollTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(self.tagScrollTimer_)

		self.tagScrollTimer_ = nil
	end
end

function NewUserInfoPreviewView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function NewUserInfoPreviewView:OnExit()
	self:StopTagScroll()

	for iter_28_0, iter_28_1 in ipairs(self.tagItem_) do
		iter_28_1:OnExit()
	end
end

function NewUserInfoPreviewView:Dispose()
	self.commonPortrait_:Dispose()
	self:RemoveAllListeners()

	for iter_29_0, iter_29_1 in ipairs(self.tagItem_) do
		iter_29_1:Dispose()
	end

	NewUserInfoPreviewView.super.Dispose(self)
end

return NewUserInfoPreviewView

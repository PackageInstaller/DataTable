local HeroFileGiftPage = class("HeroFileGiftPage", ReduxView)
local var_0_1

local function var_0_2()
	if not var_0_1 then
		var_0_1 = 0

		for iter_1_0 = 1, HeroConst.HERO_LOVE_LV_MAX do
			var_0_1 = var_0_1 + GameLevelSetting[iter_1_0].hero_love_exp
		end
	end

	return var_0_1
end

local function var_0_3(arg_2_0, arg_2_1)
	if arg_2_1 == HeroRecordCfg[arg_2_0].gift_like_id1[1] then
		return GameSetting.gift_value.value[1]
	end

	return GameSetting.gift_value.value[2]
end

local function var_0_4(arg_3_0, arg_3_1)
	local var_3_0, var_3_1, var_3_2 = ArchiveData:GetTrustLevel(arg_3_0)
	local var_3_3 = 1

	if HeroTrustMoodCfg[var_3_2] then
		var_3_3 = HeroTrustMoodCfg[var_3_2].trust_exp_rate / 1000
	end

	local var_3_4 = ItemCfg[arg_3_1]

	if ItemCfg[arg_3_1].sub_type == 1 then
		return math.floor(GameSetting.hero_trust_favor_gift_add_exp.value[1] * var_3_3)
	elseif var_3_4.sub_type == 2 then
		return math.floor(var_3_4.param[1] * var_3_3)
	else
		return 0
	end
end

function HeroFileGiftPage:OnCtor(arg_4_1, arg_4_2)
	self.gameObject_ = arg_4_1
	self.transform_ = arg_4_1.transform
	self.previewLvCB_ = arg_4_2

	self:Init()
end

function HeroFileGiftPage:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroFileGiftPage:InitUI()
	self:BindCfgUI()

	self.curHeroID_ = 0
	self.curRecordID_ = 0
	self.curHeroLikeID_ = {}
	self.giftList_ = {}
	self.curGiftIndex_ = 0
	self.taskList_ = {}
	self.voiceCoolDown_ = false
	self.likePanelStateController_ = self.giftControllerEx_:GetController("likePanelState")
	self.likeStateController_ = self.giftControllerEx_:GetController("likeState")
	self.moodStateController_ = self.giftControllerEx_:GetController("moodIconState")
	self.giftLuaUIList_ = LuaList.New(handler(self, self.IndexGiftItem), self.giftUilist_, CommonItemView)
	self.trustLvUpTaskLuaUIList_ = LuaList.New(handler(self, self.IndexTaskItem), self.trustLvTaskUilist_, HeroFileGiftTrustLvUpTaskItem)
	self.contentSizeFitter_ = self.detailTrs_:GetComponent("ContentSizeFitter")
end

function HeroFileGiftPage:AddUIListener()
	self.giftNumSlr_.onValueChanged:AddListener(function(arg_8_0)
		if arg_8_0 < 1 then
			self.giftNumSlr_.value = 1
			arg_8_0 = 1
		end

		self.giftNumText_.text = GetTips("HERO_LOVE_SELECT_NUM") .. arg_8_0

		self:RefreshExpProcess((ArchiveData:GetTrustLevel(self.curHeroID_) > 0 and var_0_4(self.curHeroID_, self.giftList_[self.curGiftIndex_].id) or var_0_3(self.curRecordID_, self.giftList_[self.curGiftIndex_].id)) * arg_8_0)

		self.giftReduceBtn_.interactable = arg_8_0 > 1
		self.giftAddBtn_.interactable = arg_8_0 < self.giftNumSlr_.maxValue
	end)
	self:AddBtnListener(self.giftReduceBtn_, nil, function()
		local var_9_0 = ItemTools.getItemNum(self.giftList_[self.curGiftIndex_].id)

		if self.giftNumSlr_.value > 1 then
			self.giftNumSlr_.value = self.giftNumSlr_.value - 1
		end
	end)
	self:AddBtnListener(self.giftAddBtn_, nil, function()
		local var_10_0 = ItemTools.getItemNum(self.giftList_[self.curGiftIndex_].id)

		if self.giftNumSlr_.value < self.giftNumSlr_.maxValue then
			self.giftNumSlr_.value = self.giftNumSlr_.value + 1
		end
	end)
	self:AddBtnListener(self.presentBtn_, nil, function()
		local var_11_0 = ArchiveData:GetTrustLevel(self.curHeroID_)

		if var_11_0 > 0 then
			local var_11_1 = self.giftNumSlr_.value

			if self.giftNumSlr_.value == 0 then
				var_11_1 = 1
			end

			Debug.Log("角色的交心等级是" .. var_11_0)
			Debug.Log("要送的礼物id和数量是" .. self.giftList_[self.curGiftIndex_].id .. " " .. var_11_1)
			ArchiveAction.QuerySendTrustItem(self.curHeroID_, {
				{
					id = self.giftList_[self.curGiftIndex_].id,
					num = var_11_1
				}
			})
		else
			local var_11_2 = self.giftList_[self.curGiftIndex_].id
			local var_11_3 = self.giftNumSlr_.value

			if self.giftNumSlr_.value == 0 then
				var_11_3 = 1
			end

			local var_11_4 = var_11_3 * var_0_3(self.curRecordID_, var_11_2)
			local var_11_5 = ArchiveData:GetArchive(self.curRecordID_).exp

			if var_11_5 + var_11_4 > var_0_2() then
				var_11_4 = var_0_2() - var_11_5
			end

			HeroAction.SendGift(self.curRecordID_, {
				{
					id = var_11_2,
					num = var_11_3
				}
			}, var_11_4)
		end
	end)
	self:AddBtnListener(self.breakBtn_, nil, function()
		ArchiveAction.QueryUnlockTrust(self.curHeroID_)
	end)
	self:AddBtnListener(self.trustLvBtn_, nil, function()
		for iter_13_0, iter_13_1 in ipairs(self.taskList_) do
			if not IsConditionAchieved(iter_13_1, {
				heroId = self.curHeroID_
			}) then
				ShowTips("HERO_TRUST_UP_LV_LOCK")

				return
			end
		end

		ArchiveAction.QueryUpgradeTrustLevel(self.curHeroID_)
	end)
	self:AddBtnListener(self.changeGiftBtn_, nil, function()
		gameContext:Go("/heroTrustGiftDisplace")
	end)
	self:AddBtnListener(self.changeEmptyBtn_, nil, function()
		gameContext:Go("/heroTrustGiftDisplace")
	end)
	self:AddBtnListener(self.moodTipsBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("HERO_TRUST_MOOD_DESC")
		})
	end)
	self:AddBtnListener(self.m_listenBtn, nil, function()
		JumpTools.GoToSystem("/newHeroDetailArchive", {
			id = self.curRecordID_
		})
	end)
end

function HeroFileGiftPage:IndexGiftItem(arg_18_1, arg_18_2)
	local var_18_0 = clone(ItemTemplateData)

	var_18_0.id = self.giftList_[arg_18_1].id
	var_18_0.number = self.giftList_[arg_18_1].num
	var_18_0.selectStyle = arg_18_1 == self.curGiftIndex_
	var_18_0.favouriteFlag = table.indexof(self.curHeroLikeID_, var_18_0.id) ~= false

	function var_18_0.clickFun()
		if arg_18_1 == self.curGiftIndex_ then
			return
		end

		if self.curGiftIndex_ ~= 0 then
			local var_19_0 = self.giftLuaUIList_:GetItemList()[self.curGiftIndex_]

			if var_19_0 then
				var_19_0:RefreshSelectState(false)
			end
		end

		arg_18_2:RefreshSelectState(true)

		self.curGiftIndex_ = arg_18_1

		self:RefreshGiftInfo()
	end

	arg_18_2:SetData(var_18_0)
end

function HeroFileGiftPage:IndexTaskItem(arg_20_1, arg_20_2)
	arg_20_2:SetData(self.taskList_[arg_20_1], self.curHeroID_)
end

function HeroFileGiftPage:Show(arg_21_1, arg_21_2)
	self.curHeroID_ = arg_21_2
	self.curRecordID_ = arg_21_1
	self.curHeroLikeID_ = HeroRecordCfg[arg_21_1].gift_like_id1

	self:UpdateGiftData()
	self:RefreshExpProcess()
	self:UpdatePageState()
	SetActive(self.gameObject_, true)
end

function HeroFileGiftPage:Hide()
	self:StopVoice()

	if self.contentSizeTimer_ then
		self.contentSizeTimer_:Stop()

		self.contentSizeTimer_ = nil
	end

	SetActive(self.gameObject_, false)
end

function HeroFileGiftPage:UpdateGiftData()
	self.giftList_ = {}

	local var_23_0, var_23_1 = ArchiveData:GetTrustLevel(self.curHeroID_)
	local var_23_2 = 1

	for iter_23_0 = 1, #self.curHeroLikeID_ do
		local var_23_3 = ItemTools.getItemNum(self.curHeroLikeID_[iter_23_0])

		if var_23_3 > 0 then
			self.giftList_[var_23_2] = {
				id = self.curHeroLikeID_[iter_23_0],
				num = var_23_3
			}
			var_23_2 = var_23_2 + 1
		end
	end

	if var_23_0 > 0 then
		for iter_23_1, iter_23_2 in ipairs((HeroTrustLevelCfg[var_23_0] or nil) and (HeroTrustLevelCfg[var_23_0].gift_list or {})) do
			local var_23_4 = ItemTools.getItemNum(iter_23_2)

			if var_23_4 > 0 and not table.indexof(self.curHeroLikeID_, iter_23_2) then
				self.giftList_[var_23_2] = {
					id = iter_23_2,
					num = var_23_4
				}
				var_23_2 = var_23_2 + 1
			end
		end
	else
		for iter_23_3, iter_23_4 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.ARCHIVE_GIFT]) do
			if ItemCfg[iter_23_4] and ItemCfg[iter_23_4].sub_type == 1 then
				local var_23_5 = ItemTools.getItemNum(iter_23_4)

				if var_23_5 > 0 and not table.indexof(self.curHeroLikeID_, iter_23_4) then
					self.giftList_[var_23_2] = {
						id = iter_23_4,
						num = var_23_5
					}
					var_23_2 = var_23_2 + 1
				end
			end
		end
	end
end

function HeroFileGiftPage:UpdatePageState()
	local var_24_0, var_24_1, var_24_2 = ArchiveData:GetTrustLevel(self.curHeroID_)

	if var_24_0 > 0 then
		self.likeStateController_:SetSelectedState("trust")

		if HeroTrustMoodCfg[var_24_2] then
			self.moodTitleText_.text = HeroTrustMoodCfg[var_24_2].name
			self.moodBuffText_.text = HeroTrustMoodCfg[var_24_2].desc

			self.moodStateController_:SetSelectedState(var_24_2)
		end
	else
		self.likeStateController_:SetSelectedState("like")
	end

	if var_24_0 > 0 then
		if var_24_0 >= HeroConst.HERO_TRUST_LV_MAX then
			self.likePanelStateController_:SetSelectedState("max")

			self.impressionText_.text = HeroCfg[self.curHeroID_].impression
		elseif var_24_1 >= HeroTrustLevelCfg[var_24_0].exp then
			self.likePanelStateController_:SetSelectedState("levelup")
			self.likeStateController_:SetSelectedState("like")

			self.trustPriorText_.text = ArchiveTools.GetTrustLvDes(var_24_0)
			self.trustNextText_.text = ArchiveTools.GetTrustLvDes(var_24_0 + 1)
			self.taskList_ = HeroTrustCfg[HeroTrustCfg.get_id_list_by_hero_id[self.curHeroID_][var_24_0]].condition_list

			self.trustLvUpTaskLuaUIList_:StartScroll(#self.taskList_)

			if HeroTrustCfg[HeroTrustCfg.get_id_list_by_hero_id[self.curHeroID_][var_24_0]].reward_item_list[1] then
				self.trustLvTipsText_.text = GetTipsF("HERO_TRUST_UP_LV_REWARD", ArchiveTools.GetTrustLvDes(var_24_0 + 1))
				self.trustLvRewardText_.text = ItemTools.getItemName(HeroTrustCfg[HeroTrustCfg.get_id_list_by_hero_id[self.curHeroID_][var_24_0]].reward_item_list[1][1]) .. " X" .. HeroTrustCfg[HeroTrustCfg.get_id_list_by_hero_id[self.curHeroID_][var_24_0]].reward_item_list[1][2]
				self.trustLvRewardImg_.sprite = ItemTools.getItemSprite(HeroTrustCfg[HeroTrustCfg.get_id_list_by_hero_id[self.curHeroID_][var_24_0]].reward_item_list[1][1])
			end
		elseif #self.giftList_ > 0 then
			self.likePanelStateController_:SetSelectedState("gift")

			self.curGiftIndex_ = 1

			self.giftLuaUIList_:StartScroll(#self.giftList_)
			self:RefreshGiftInfo()
		else
			self.likePanelStateController_:SetSelectedState("empty")
		end
	elseif HeroRelationNetCfg.get_id_list_by_hero_id[self.curHeroID_] then
		if ArchiveData:GetArchive(self.curRecordID_).exp >= var_0_2() then
			if HeroTools.GetHeroIsUnlock(self.curHeroID_) then
				self.likePanelStateController_:SetSelectedState("canbreak")
			else
				self.likePanelStateController_:SetSelectedState("notbreak")

				self.notbreakTipText_.text = GetTipsF("HERO_TRUST_BREAK_HERO_LOCK", string.format("%s·%s", GetI18NText(HeroCfg[self.curHeroID_].name), GetI18NText(HeroCfg[self.curHeroID_].suffix)))
			end
		elseif #self.giftList_ > 0 then
			self.likePanelStateController_:SetSelectedState("gift")

			self.curGiftIndex_ = 1

			self.giftLuaUIList_:StartScroll(#self.giftList_)
			self:RefreshGiftInfo()
		else
			self.likePanelStateController_:SetSelectedState("empty")
		end
	elseif ArchiveData:GetArchive(self.curRecordID_).exp >= var_0_2() then
		self.likePanelStateController_:SetSelectedState("max")
	elseif #self.giftList_ > 0 then
		self.likePanelStateController_:SetSelectedState("gift")

		self.curGiftIndex_ = 1

		self.giftLuaUIList_:StartScroll(#self.giftList_)
		self:RefreshGiftInfo()
	else
		self.likePanelStateController_:SetSelectedState("empty")
	end
end

function HeroFileGiftPage:RefreshGiftInfo()
	local var_25_0, var_25_1 = ArchiveData:GetTrustLevel(self.curHeroID_)
	local var_25_2 = self.giftList_[self.curGiftIndex_].id
	local var_25_3 = var_25_0 > 0 and var_0_4(self.curHeroID_, var_25_2) or var_0_3(self.curRecordID_, var_25_2)

	self.giftNameText_.text = ItemTools.getItemName(self.giftList_[self.curGiftIndex_].id)
	self.giftDescText_.text = ItemTools.getItemDesc(var_25_2)
	self.giftPointText_.text = (var_25_0 > 0 and GetTips("HERO_LOVE_TRUST") or GetTips("TIP_FAVOR")) .. "+" .. var_25_3

	self.detailTrs_:SetAnchoredPositionY(0)

	self.contentSizeFitter_.verticalFit = ContentSizeFitter.FitMode.Unconstrained
	self.contentSizeTimer_ = Timer.New(function()
		self.contentSizeFitter_.verticalFit = ContentSizeFitter.FitMode.PreferredSize

		if self.contentSizeTimer_ then
			self.contentSizeTimer_:Stop()

			self.contentSizeTimer_ = nil
		end
	end, 0.2, 1)

	self.contentSizeTimer_:Start()

	self.giftNumSlr_.minValue = 0
	self.giftNumSlr_.maxValue = var_25_0 > 0 and math.min(self.giftList_[self.curGiftIndex_].num, math.ceil((HeroTrustLevelCfg[var_25_0].exp - var_25_1) / var_25_3)) or math.min(self.giftList_[self.curGiftIndex_].num, math.ceil((var_0_2() - ArchiveData:GetArchive(self.curRecordID_).exp) / var_25_3))

	if self.giftNumSlr_.value == 1 then
		self.giftNumText_.text = GetTips("HERO_LOVE_SELECT_NUM") .. 1

		self:RefreshExpProcess(var_25_3)

		self.giftReduceBtn_.interactable = false
		self.giftAddBtn_.interactable = self.giftNumSlr_.maxValue > 1
	else
		self.giftNumSlr_.value = 1
	end
end

function HeroFileGiftPage:RefreshExpProcess(arg_27_1)
	local var_27_0, var_27_1 = ArchiveData:GetTrustLevel(self.curHeroID_)

	if var_27_0 > 0 then
		if arg_27_1 and arg_27_1 > 0 then
			if HeroTrustLevelCfg[var_27_0].exp < var_27_1 + arg_27_1 then
				arg_27_1 = HeroTrustLevelCfg[var_27_0].exp - var_27_1
			end

			self.currlevelText_.text = var_27_1 + arg_27_1 .. "/" .. HeroTrustLevelCfg[var_27_0].exp
			self.addlevelText_.text = "+" .. arg_27_1
			self.processbarImg_.fillAmount = var_27_1 / HeroTrustLevelCfg[var_27_0].exp
			self.processaddImg_.fillAmount = (var_27_1 + arg_27_1) / HeroTrustLevelCfg[var_27_0].exp
		elseif var_27_0 == HeroConst.HERO_TRUST_LV_MAX then
			self.currlevelText_.text = HeroTrustLevelCfg[var_27_0 - 1].exp .. "/" .. HeroTrustLevelCfg[var_27_0 - 1].exp
			self.addlevelText_.text = "[MAX]"
			self.processbarImg_.fillAmount = 1
			self.processaddImg_.fillAmount = 0
		else
			self.currlevelText_.text = var_27_1 .. "/" .. HeroTrustLevelCfg[var_27_0].exp
			self.addlevelText_.text = ""
			self.processbarImg_.fillAmount = var_27_1 / HeroTrustLevelCfg[var_27_0].exp
			self.processaddImg_.fillAmount = 0
		end
	else
		local var_27_2 = ArchiveData:GetArchive(self.curRecordID_).exp
		local var_27_3, var_27_4 = LvTools.LoveExpToLevel(var_27_2)

		if arg_27_1 and arg_27_1 > 0 then
			if var_27_2 + arg_27_1 >= var_0_2() then
				arg_27_1 = var_0_2() - var_27_2
			end

			local var_27_5, var_27_6 = LvTools.LoveExpToLevel(var_27_2 + arg_27_1)

			if var_27_5 == HeroConst.HERO_LOVE_LV_MAX then
				self.currlevelText_.text = GameLevelSetting[var_27_5 - 1].hero_love_exp .. "/" .. GameLevelSetting[var_27_5 - 1].hero_love_exp
				self.addlevelText_.text = "+" .. arg_27_1

				if var_27_3 < var_27_5 - 1 then
					self.processbarImg_.fillAmount = 0
					self.processaddImg_.fillAmount = 1
				else
					self.processbarImg_.fillAmount = var_27_4 / GameLevelSetting[var_27_3].hero_love_exp
					self.processaddImg_.fillAmount = 1
				end
			else
				self.currlevelText_.text = var_27_6 .. "/" .. GameLevelSetting[var_27_5].hero_love_exp
				self.addlevelText_.text = "+" .. arg_27_1

				if var_27_3 < var_27_5 then
					self.processbarImg_.fillAmount = 0
					self.processaddImg_.fillAmount = var_27_6 / GameLevelSetting[var_27_5].hero_love_exp
				else
					self.processbarImg_.fillAmount = var_27_4 / GameLevelSetting[var_27_3].hero_love_exp
					self.processaddImg_.fillAmount = var_27_6 / GameLevelSetting[var_27_5].hero_love_exp
				end
			end

			self.previewLvCB_(var_27_5)
		elseif var_27_3 == HeroConst.HERO_LOVE_LV_MAX then
			self.currlevelText_.text = GameLevelSetting[var_27_3 - 1].hero_love_exp .. "/" .. GameLevelSetting[var_27_3 - 1].hero_love_exp
			self.addlevelText_.text = "[MAX]"
			self.processbarImg_.fillAmount = 1
			self.processaddImg_.fillAmount = 0
		else
			self.currlevelText_.text = var_27_4 .. "/" .. GameLevelSetting[var_27_3].hero_love_exp
			self.addlevelText_.text = ""
			self.processbarImg_.fillAmount = var_27_4 / GameLevelSetting[var_27_3].hero_love_exp
			self.processaddImg_.fillAmount = 0
		end
	end
end

local function var_0_5(arg_28_0)
	if arg_28_0 and arg_28_0 ~= 0 then
		for iter_28_0, iter_28_1 in ipairs(HeroVoiceCfg.get_id_list_by_file.emotion) do
			if HeroVoiceCfg[iter_28_1].use_skin_id == arg_28_0 then
				return HeroVoiceCfg[iter_28_1]
			end
		end
	end
end

function HeroFileGiftPage:PlayVoice()
	if self.voiceCoolDown_ then
		return
	end

	self.voiceCoolDown_ = true

	local var_29_0 = HeroVoiceCfg.get_id_list_by_file.emotion[1]

	SDKTools.SendMessageToSDK("hero_sound", {
		hero_id = self.curHeroID_,
		sound_id = HeroVoiceCfg.get_id_list_by_file.emotion[1]
	})
	self:StopVoice()

	self.delayPlayTimer_ = Timer.New(function()
		if manager.audio:IsStoppedOfVoice() then
			self.delayPlayTimer_:Stop()

			self.delayPlayTimer_ = nil

			local var_30_0 = self.curHeroID_
			local var_30_1 = var_0_5((nullable(HeroData:GetHeroData(self.curHeroID_), "using_skin")))

			if var_30_1 then
				var_30_0 = var_30_1.use_skin_id
			end

			HeroTools.PlayVoice(var_30_0, HeroVoiceCfg[var_29_0].file, HeroVoiceCfg[var_29_0].type)

			self.timer_ = TimeTools.StartAfterSeconds(math.max(HeroTools.GetTalkLength(var_30_0, HeroVoiceCfg[var_29_0].file, HeroVoiceCfg[var_29_0].type), 0.017) / 1000, function()
				self:StopVoice()
			end, {})
		end
	end, 0.033, -1)

	self.delayPlayTimer_:Start()
end

function HeroFileGiftPage:StopVoice()
	if self.delayPlayTimer_ then
		self.delayPlayTimer_:Stop()

		self.delayPlayTimer_ = nil
	end

	manager.audio:StopVoiceImmediate()

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
		self.voiceCoolDown_ = false
	end
end

function HeroFileGiftPage:OnHeroTrustUpdate()
	self:UpdateGiftData()
	self:RefreshExpProcess()

	local var_33_0, var_33_1, var_33_2 = ArchiveData:GetTrustLevel(self.curHeroID_)

	Debug.Log("角色的交心等级是和经验是" .. var_33_0 .. " " .. var_33_1)
	self:PlayVoice()

	if var_33_0 >= HeroConst.HERO_TRUST_LV_MAX then
		ShowTips("HERO_LOVE_LEVEL_MAX")
	else
		ShowTips("HERO_LOVE_EXP_UP")
	end

	if var_33_0 > 0 then
		self.likeStateController_:SetSelectedState("trust")

		if HeroTrustMoodCfg[var_33_2] then
			self.moodTitleText_.text = HeroTrustMoodCfg[var_33_2].name
			self.moodBuffText_.text = HeroTrustMoodCfg[var_33_2].desc

			self.moodStateController_:SetSelectedState(var_33_2)
		end
	else
		self.likeStateController_:SetSelectedState("like")
	end

	if var_33_0 >= HeroConst.HERO_TRUST_LV_MAX then
		self.likePanelStateController_:SetSelectedState("max")

		self.impressionText_.text = HeroCfg[self.curHeroID_].impression
	elseif var_33_1 >= HeroTrustLevelCfg[var_33_0].exp then
		self.likePanelStateController_:SetSelectedState("levelup")
		self.likeStateController_:SetSelectedState("like")

		self.trustPriorText_.text = ArchiveTools.GetTrustLvDes(var_33_0)
		self.trustNextText_.text = ArchiveTools.GetTrustLvDes(var_33_0 + 1)
		self.taskList_ = HeroTrustCfg[HeroTrustCfg.get_id_list_by_hero_id[self.curHeroID_][var_33_0]].condition_list

		self.trustLvUpTaskLuaUIList_:StartScroll(#self.taskList_)

		if HeroTrustCfg[HeroTrustCfg.get_id_list_by_hero_id[self.curHeroID_][var_33_0]].reward_item_list[1] then
			self.trustLvTipsText_.text = GetTipsF("HERO_TRUST_UP_LV_REWARD", ArchiveTools.GetTrustLvDes(var_33_0 + 1))
			self.trustLvRewardText_.text = ItemTools.getItemName(HeroTrustCfg[HeroTrustCfg.get_id_list_by_hero_id[self.curHeroID_][var_33_0]].reward_item_list[1][1]) .. " X" .. HeroTrustCfg[HeroTrustCfg.get_id_list_by_hero_id[self.curHeroID_][var_33_0]].reward_item_list[1][2]
			self.trustLvRewardImg_.sprite = ItemTools.getItemSprite(HeroTrustCfg[HeroTrustCfg.get_id_list_by_hero_id[self.curHeroID_][var_33_0]].reward_item_list[1][1])
		end
	elseif #self.giftList_ > 0 then
		self.likePanelStateController_:SetSelectedState("gift")

		if self.curGiftIndex_ > #self.giftList_ then
			self.curGiftIndex_ = #self.giftList_
		elseif self.curGiftIndex_ < 1 then
			self.curGiftIndex_ = 1
		end

		self.giftLuaUIList_:StartScroll(#self.giftList_)
		self:RefreshGiftInfo()
	else
		self.likePanelStateController_:SetSelectedState("empty")
	end
end

function HeroFileGiftPage:OnSendGift()
	self:UpdateGiftData()
	self:RefreshExpProcess()
	self:PlayVoice()

	if ArchiveData:GetArchive(self.curRecordID_).exp >= var_0_2() then
		ShowTips("HERO_LOVE_LEVEL_MAX")
	else
		ShowTips("HERO_LOVE_EXP_UP")
	end

	if HeroRelationNetCfg.get_id_list_by_hero_id[self.curHeroID_] then
		if ArchiveData:GetArchive(self.curRecordID_).exp >= var_0_2() then
			if HeroTools.GetHeroIsUnlock(self.curHeroID_) then
				self.likePanelStateController_:SetSelectedState("canbreak")
			else
				self.likePanelStateController_:SetSelectedState("notbreak")

				self.notbreakTipText_.text = GetTipsF("HERO_TRUST_BREAK_HERO_LOCK", string.format("%s·%s", GetI18NText(HeroCfg[self.curHeroID_].name), GetI18NText(HeroCfg[self.curHeroID_].suffix)))
			end
		elseif #self.giftList_ > 0 then
			self.likePanelStateController_:SetSelectedState("gift")

			if self.curGiftIndex_ > #self.giftList_ then
				self.curGiftIndex_ = #self.giftList_
			elseif self.curGiftIndex_ < 1 then
				self.curGiftIndex_ = 1
			end

			self.giftLuaUIList_:StartScroll(#self.giftList_)
			self:RefreshGiftInfo()
		else
			self.likePanelStateController_:SetSelectedState("empty")
		end
	elseif ArchiveData:GetArchive(self.curRecordID_).exp >= var_0_2() then
		self.likePanelStateController_:SetSelectedState("max")
	elseif #self.giftList_ > 0 then
		self.likePanelStateController_:SetSelectedState("gift")

		if self.curGiftIndex_ > #self.giftList_ then
			self.curGiftIndex_ = #self.giftList_
		elseif self.curGiftIndex_ < 1 then
			self.curGiftIndex_ = 1
		end

		self.giftLuaUIList_:StartScroll(#self.giftList_)
		self:RefreshGiftInfo()
	else
		self.likePanelStateController_:SetSelectedState("empty")
	end
end

function HeroFileGiftPage:OnHeroModify()
	local var_35_0, var_35_1, var_35_2 = ArchiveData:GetTrustLevel(self.curHeroID_)

	if HeroTrustMoodCfg[var_35_2] then
		self.moodTitleText_.text = HeroTrustMoodCfg[var_35_2].name
		self.moodBuffText_.text = HeroTrustMoodCfg[var_35_2].desc

		self.moodStateController_:SetSelectedState(var_35_2)
	end
end

function HeroFileGiftPage:Dispose()
	self.giftLuaUIList_:Dispose()
	self.trustLvUpTaskLuaUIList_:Dispose()
	HeroFileGiftPage.super.Dispose(self)
end

return HeroFileGiftPage

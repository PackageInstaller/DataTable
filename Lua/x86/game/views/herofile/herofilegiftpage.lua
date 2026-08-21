local var_0_0 = class("HeroFileGiftPage", ReduxView)
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
	local var_2_0 = HeroRecordCfg[arg_2_0].gift_like_id1[1]
	local var_2_1 = GameSetting.gift_value.value

	if arg_2_1 == var_2_0 then
		return var_2_1[1]
	end

	return var_2_1[2]
end

local function var_0_4(arg_3_0, arg_3_1)
	local var_3_0, var_3_1, var_3_2 = ArchiveData:GetTrustLevel(arg_3_0)
	local var_3_3 = 1

	if HeroTrustMoodCfg[var_3_2] then
		var_3_3 = HeroTrustMoodCfg[var_3_2].trust_exp_rate / 1000
	end

	local var_3_4 = ItemCfg[arg_3_1]

	if var_3_4.sub_type == 1 then
		return math.floor(GameSetting.hero_trust_favor_gift_add_exp.value[1] * var_3_3)
	elseif var_3_4.sub_type == 2 then
		return math.floor(var_3_4.param[1] * var_3_3)
	else
		return 0
	end
end

function var_0_0.OnCtor(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.gameObject_ = arg_4_1
	arg_4_0.transform_ = arg_4_1.transform
	arg_4_0.previewLvCB_ = arg_4_2

	arg_4_0:Init()
end

function var_0_0.Init(arg_5_0)
	arg_5_0:InitUI()
	arg_5_0:AddUIListener()
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()

	arg_6_0.curHeroID_ = 0
	arg_6_0.curRecordID_ = 0
	arg_6_0.curHeroLikeID_ = {}
	arg_6_0.giftList_ = {}
	arg_6_0.curGiftIndex_ = 0
	arg_6_0.taskList_ = {}
	arg_6_0.voiceCoolDown_ = false
	arg_6_0.likePanelStateController_ = arg_6_0.giftControllerEx_:GetController("likePanelState")
	arg_6_0.likeStateController_ = arg_6_0.giftControllerEx_:GetController("likeState")
	arg_6_0.moodStateController_ = arg_6_0.giftControllerEx_:GetController("moodIconState")
	arg_6_0.giftLuaUIList_ = LuaList.New(handler(arg_6_0, arg_6_0.IndexGiftItem), arg_6_0.giftUilist_, CommonItemView)
	arg_6_0.trustLvUpTaskLuaUIList_ = LuaList.New(handler(arg_6_0, arg_6_0.IndexTaskItem), arg_6_0.trustLvTaskUilist_, HeroFileGiftTrustLvUpTaskItem)
	arg_6_0.contentSizeFitter_ = arg_6_0.detailTrs_:GetComponent("ContentSizeFitter")
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0.giftNumSlr_.onValueChanged:AddListener(function(arg_8_0)
		if arg_8_0 < 1 then
			arg_7_0.giftNumSlr_.value = 1
			arg_8_0 = 1
		end

		arg_7_0.giftNumText_.text = GetTips("HERO_LOVE_SELECT_NUM") .. arg_8_0

		local var_8_0 = ArchiveData:GetTrustLevel(arg_7_0.curHeroID_)
		local var_8_1 = arg_7_0.giftList_[arg_7_0.curGiftIndex_].id
		local var_8_2 = var_8_0 > 0 and var_0_4(arg_7_0.curHeroID_, var_8_1) or var_0_3(arg_7_0.curRecordID_, var_8_1)

		arg_7_0:RefreshExpProcess(var_8_2 * arg_8_0)

		arg_7_0.giftReduceBtn_.interactable = arg_8_0 > 1
		arg_7_0.giftAddBtn_.interactable = arg_8_0 < arg_7_0.giftNumSlr_.maxValue
	end)
	arg_7_0:AddBtnListener(arg_7_0.giftReduceBtn_, nil, function()
		local var_9_0 = ItemTools.getItemNum(arg_7_0.giftList_[arg_7_0.curGiftIndex_].id)

		if arg_7_0.giftNumSlr_.value > 1 then
			arg_7_0.giftNumSlr_.value = arg_7_0.giftNumSlr_.value - 1
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.giftAddBtn_, nil, function()
		local var_10_0 = ItemTools.getItemNum(arg_7_0.giftList_[arg_7_0.curGiftIndex_].id)

		if arg_7_0.giftNumSlr_.value < arg_7_0.giftNumSlr_.maxValue then
			arg_7_0.giftNumSlr_.value = arg_7_0.giftNumSlr_.value + 1
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.presentBtn_, nil, function()
		local var_11_0 = ArchiveData:GetTrustLevel(arg_7_0.curHeroID_)

		if var_11_0 > 0 then
			local var_11_1 = arg_7_0.giftList_[arg_7_0.curGiftIndex_].id
			local var_11_2 = arg_7_0.giftNumSlr_.value

			if var_11_2 == 0 then
				var_11_2 = 1
			end

			Debug.Log("角色的交心等级是" .. var_11_0)
			Debug.Log("要送的礼物id和数量是" .. var_11_1 .. " " .. var_11_2)
			ArchiveAction.QuerySendTrustItem(arg_7_0.curHeroID_, {
				{
					id = var_11_1,
					num = var_11_2
				}
			})
		else
			local var_11_3 = arg_7_0.giftList_[arg_7_0.curGiftIndex_].id
			local var_11_4 = arg_7_0.giftNumSlr_.value

			if var_11_4 == 0 then
				var_11_4 = 1
			end

			local var_11_5 = var_11_4 * var_0_3(arg_7_0.curRecordID_, var_11_3)
			local var_11_6 = ArchiveData:GetArchive(arg_7_0.curRecordID_).exp

			if var_11_6 + var_11_5 > var_0_2() then
				var_11_5 = var_0_2() - var_11_6
			end

			HeroAction.SendGift(arg_7_0.curRecordID_, {
				{
					id = var_11_3,
					num = var_11_4
				}
			}, var_11_5)
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.breakBtn_, nil, function()
		ArchiveAction.QueryUnlockTrust(arg_7_0.curHeroID_)
	end)
	arg_7_0:AddBtnListener(arg_7_0.trustLvBtn_, nil, function()
		for iter_13_0, iter_13_1 in ipairs(arg_7_0.taskList_) do
			if not IsConditionAchieved(iter_13_1, {
				heroId = arg_7_0.curHeroID_
			}) then
				ShowTips("HERO_TRUST_UP_LV_LOCK")

				return
			end
		end

		ArchiveAction.QueryUpgradeTrustLevel(arg_7_0.curHeroID_)
	end)
	arg_7_0:AddBtnListener(arg_7_0.changeGiftBtn_, nil, function()
		gameContext:Go("/heroTrustGiftDisplace")
	end)
	arg_7_0:AddBtnListener(arg_7_0.changeEmptyBtn_, nil, function()
		gameContext:Go("/heroTrustGiftDisplace")
	end)
	arg_7_0:AddBtnListener(arg_7_0.moodTipsBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("HERO_TRUST_MOOD_DESC")
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.m_listenBtn, nil, function()
		JumpTools.GoToSystem("/newHeroDetailArchive", {
			id = arg_7_0.curRecordID_
		})
	end)
end

function var_0_0.IndexGiftItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = clone(ItemTemplateData)

	var_18_0.id = arg_18_0.giftList_[arg_18_1].id
	var_18_0.number = arg_18_0.giftList_[arg_18_1].num
	var_18_0.selectStyle = arg_18_1 == arg_18_0.curGiftIndex_
	var_18_0.favouriteFlag = table.indexof(arg_18_0.curHeroLikeID_, var_18_0.id) ~= false

	function var_18_0.clickFun()
		if arg_18_1 == arg_18_0.curGiftIndex_ then
			return
		end

		if arg_18_0.curGiftIndex_ ~= 0 then
			local var_19_0 = arg_18_0.giftLuaUIList_:GetItemList()[arg_18_0.curGiftIndex_]

			if var_19_0 then
				var_19_0:RefreshSelectState(false)
			end
		end

		arg_18_2:RefreshSelectState(true)

		arg_18_0.curGiftIndex_ = arg_18_1

		arg_18_0:RefreshGiftInfo()
	end

	arg_18_2:SetData(var_18_0)
end

function var_0_0.IndexTaskItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.taskList_[arg_20_1]

	arg_20_2:SetData(var_20_0, arg_20_0.curHeroID_)
end

function var_0_0.Show(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.curHeroID_ = arg_21_2
	arg_21_0.curRecordID_ = arg_21_1
	arg_21_0.curHeroLikeID_ = HeroRecordCfg[arg_21_1].gift_like_id1

	arg_21_0:UpdateGiftData()
	arg_21_0:RefreshExpProcess()
	arg_21_0:UpdatePageState()
	SetActive(arg_21_0.gameObject_, true)
end

function var_0_0.Hide(arg_22_0)
	arg_22_0:StopVoice()

	if arg_22_0.contentSizeTimer_ then
		arg_22_0.contentSizeTimer_:Stop()

		arg_22_0.contentSizeTimer_ = nil
	end

	SetActive(arg_22_0.gameObject_, false)
end

function var_0_0.UpdateGiftData(arg_23_0)
	arg_23_0.giftList_ = {}

	local var_23_0, var_23_1 = ArchiveData:GetTrustLevel(arg_23_0.curHeroID_)
	local var_23_2 = 1

	for iter_23_0 = 1, #arg_23_0.curHeroLikeID_ do
		local var_23_3 = arg_23_0.curHeroLikeID_[iter_23_0]
		local var_23_4 = ItemTools.getItemNum(var_23_3)

		if var_23_4 > 0 then
			arg_23_0.giftList_[var_23_2] = {
				id = var_23_3,
				num = var_23_4
			}
			var_23_2 = var_23_2 + 1
		end
	end

	if var_23_0 > 0 then
		local var_23_5 = HeroTrustLevelCfg[var_23_0]
		local var_23_6 = var_23_5 and var_23_5.gift_list or {}

		for iter_23_1, iter_23_2 in ipairs(var_23_6) do
			local var_23_7 = ItemTools.getItemNum(iter_23_2)

			if var_23_7 > 0 and not table.indexof(arg_23_0.curHeroLikeID_, iter_23_2) then
				arg_23_0.giftList_[var_23_2] = {
					id = iter_23_2,
					num = var_23_7
				}
				var_23_2 = var_23_2 + 1
			end
		end
	else
		local var_23_8 = ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.ARCHIVE_GIFT]

		for iter_23_3, iter_23_4 in ipairs(var_23_8) do
			if ItemCfg[iter_23_4] and ItemCfg[iter_23_4].sub_type == 1 then
				local var_23_9 = ItemTools.getItemNum(iter_23_4)

				if var_23_9 > 0 and not table.indexof(arg_23_0.curHeroLikeID_, iter_23_4) then
					arg_23_0.giftList_[var_23_2] = {
						id = iter_23_4,
						num = var_23_9
					}
					var_23_2 = var_23_2 + 1
				end
			end
		end
	end
end

function var_0_0.UpdatePageState(arg_24_0)
	local var_24_0, var_24_1, var_24_2 = ArchiveData:GetTrustLevel(arg_24_0.curHeroID_)

	if var_24_0 > 0 then
		arg_24_0.likeStateController_:SetSelectedState("trust")

		local var_24_3 = HeroTrustMoodCfg[var_24_2]

		if var_24_3 then
			arg_24_0.moodTitleText_.text = var_24_3.name
			arg_24_0.moodBuffText_.text = var_24_3.desc

			arg_24_0.moodStateController_:SetSelectedState(var_24_2)
		end
	else
		arg_24_0.likeStateController_:SetSelectedState("like")
	end

	if var_24_0 > 0 then
		if var_24_0 >= HeroConst.HERO_TRUST_LV_MAX then
			arg_24_0.likePanelStateController_:SetSelectedState("max")

			arg_24_0.impressionText_.text = HeroCfg[arg_24_0.curHeroID_].impression
		elseif var_24_1 >= HeroTrustLevelCfg[var_24_0].exp then
			arg_24_0.likePanelStateController_:SetSelectedState("levelup")
			arg_24_0.likeStateController_:SetSelectedState("like")

			arg_24_0.trustPriorText_.text = ArchiveTools.GetTrustLvDes(var_24_0)
			arg_24_0.trustNextText_.text = ArchiveTools.GetTrustLvDes(var_24_0 + 1)

			local var_24_4 = HeroTrustCfg.get_id_list_by_hero_id[arg_24_0.curHeroID_][var_24_0]
			local var_24_5 = HeroTrustCfg[var_24_4]

			arg_24_0.taskList_ = var_24_5.condition_list

			arg_24_0.trustLvUpTaskLuaUIList_:StartScroll(#arg_24_0.taskList_)

			local var_24_6 = var_24_5.reward_item_list[1]

			if var_24_6 then
				local var_24_7 = var_24_6[1]
				local var_24_8 = var_24_6[2]

				arg_24_0.trustLvTipsText_.text = GetTipsF("HERO_TRUST_UP_LV_REWARD", ArchiveTools.GetTrustLvDes(var_24_0 + 1))
				arg_24_0.trustLvRewardText_.text = ItemTools.getItemName(var_24_7) .. " X" .. var_24_8
				arg_24_0.trustLvRewardImg_.sprite = ItemTools.getItemSprite(var_24_7)
			end
		elseif #arg_24_0.giftList_ > 0 then
			arg_24_0.likePanelStateController_:SetSelectedState("gift")

			arg_24_0.curGiftIndex_ = 1

			arg_24_0.giftLuaUIList_:StartScroll(#arg_24_0.giftList_)
			arg_24_0:RefreshGiftInfo()
		else
			arg_24_0.likePanelStateController_:SetSelectedState("empty")
		end
	elseif HeroRelationNetCfg.get_id_list_by_hero_id[arg_24_0.curHeroID_] then
		if ArchiveData:GetArchive(arg_24_0.curRecordID_).exp >= var_0_2() then
			if HeroTools.GetHeroIsUnlock(arg_24_0.curHeroID_) then
				arg_24_0.likePanelStateController_:SetSelectedState("canbreak")
			else
				arg_24_0.likePanelStateController_:SetSelectedState("notbreak")

				local var_24_9 = HeroCfg[arg_24_0.curHeroID_]

				arg_24_0.notbreakTipText_.text = GetTipsF("HERO_TRUST_BREAK_HERO_LOCK", string.format("%s·%s", GetI18NText(var_24_9.name), GetI18NText(var_24_9.suffix)))
			end
		elseif #arg_24_0.giftList_ > 0 then
			arg_24_0.likePanelStateController_:SetSelectedState("gift")

			arg_24_0.curGiftIndex_ = 1

			arg_24_0.giftLuaUIList_:StartScroll(#arg_24_0.giftList_)
			arg_24_0:RefreshGiftInfo()
		else
			arg_24_0.likePanelStateController_:SetSelectedState("empty")
		end
	elseif ArchiveData:GetArchive(arg_24_0.curRecordID_).exp >= var_0_2() then
		arg_24_0.likePanelStateController_:SetSelectedState("max")
	elseif #arg_24_0.giftList_ > 0 then
		arg_24_0.likePanelStateController_:SetSelectedState("gift")

		arg_24_0.curGiftIndex_ = 1

		arg_24_0.giftLuaUIList_:StartScroll(#arg_24_0.giftList_)
		arg_24_0:RefreshGiftInfo()
	else
		arg_24_0.likePanelStateController_:SetSelectedState("empty")
	end
end

function var_0_0.RefreshGiftInfo(arg_25_0)
	local var_25_0, var_25_1 = ArchiveData:GetTrustLevel(arg_25_0.curHeroID_)
	local var_25_2 = arg_25_0.giftList_[arg_25_0.curGiftIndex_].id
	local var_25_3 = var_25_0 > 0 and var_0_4(arg_25_0.curHeroID_, var_25_2) or var_0_3(arg_25_0.curRecordID_, var_25_2)

	arg_25_0.giftNameText_.text = ItemTools.getItemName(var_25_2)
	arg_25_0.giftDescText_.text = ItemTools.getItemDesc(var_25_2)
	arg_25_0.giftPointText_.text = (var_25_0 > 0 and GetTips("HERO_LOVE_TRUST") or GetTips("TIP_FAVOR")) .. "+" .. var_25_3

	arg_25_0.detailTrs_:SetAnchoredPositionY(0)

	arg_25_0.contentSizeFitter_.verticalFit = ContentSizeFitter.FitMode.Unconstrained
	arg_25_0.contentSizeTimer_ = Timer.New(function()
		arg_25_0.contentSizeFitter_.verticalFit = ContentSizeFitter.FitMode.PreferredSize

		if arg_25_0.contentSizeTimer_ then
			arg_25_0.contentSizeTimer_:Stop()

			arg_25_0.contentSizeTimer_ = nil
		end
	end, 0.2, 1)

	arg_25_0.contentSizeTimer_:Start()

	arg_25_0.giftNumSlr_.minValue = 0

	if var_25_0 > 0 then
		local var_25_4 = HeroTrustLevelCfg[var_25_0].exp
		local var_25_5 = math.min(arg_25_0.giftList_[arg_25_0.curGiftIndex_].num, math.ceil((var_25_4 - var_25_1) / var_25_3))

		arg_25_0.giftNumSlr_.maxValue = var_25_5
	else
		local var_25_6 = ArchiveData:GetArchive(arg_25_0.curRecordID_).exp
		local var_25_7 = math.min(arg_25_0.giftList_[arg_25_0.curGiftIndex_].num, math.ceil((var_0_2() - var_25_6) / var_25_3))

		arg_25_0.giftNumSlr_.maxValue = var_25_7
	end

	if arg_25_0.giftNumSlr_.value == 1 then
		arg_25_0.giftNumText_.text = GetTips("HERO_LOVE_SELECT_NUM") .. 1

		arg_25_0:RefreshExpProcess(var_25_3)

		arg_25_0.giftReduceBtn_.interactable = false
		arg_25_0.giftAddBtn_.interactable = arg_25_0.giftNumSlr_.maxValue > 1
	else
		arg_25_0.giftNumSlr_.value = 1
	end
end

function var_0_0.RefreshExpProcess(arg_27_0, arg_27_1)
	local var_27_0, var_27_1 = ArchiveData:GetTrustLevel(arg_27_0.curHeroID_)

	if var_27_0 > 0 then
		local var_27_2 = HeroTrustLevelCfg[var_27_0].exp

		if arg_27_1 and arg_27_1 > 0 then
			if var_27_2 < var_27_1 + arg_27_1 then
				arg_27_1 = var_27_2 - var_27_1
			end

			arg_27_0.currlevelText_.text = var_27_1 + arg_27_1 .. "/" .. var_27_2
			arg_27_0.addlevelText_.text = "+" .. arg_27_1
			arg_27_0.processbarImg_.fillAmount = var_27_1 / var_27_2
			arg_27_0.processaddImg_.fillAmount = (var_27_1 + arg_27_1) / var_27_2
		elseif var_27_0 == HeroConst.HERO_TRUST_LV_MAX then
			arg_27_0.currlevelText_.text = HeroTrustLevelCfg[var_27_0 - 1].exp .. "/" .. HeroTrustLevelCfg[var_27_0 - 1].exp
			arg_27_0.addlevelText_.text = "[MAX]"
			arg_27_0.processbarImg_.fillAmount = 1
			arg_27_0.processaddImg_.fillAmount = 0
		else
			arg_27_0.currlevelText_.text = var_27_1 .. "/" .. var_27_2
			arg_27_0.addlevelText_.text = ""
			arg_27_0.processbarImg_.fillAmount = var_27_1 / var_27_2
			arg_27_0.processaddImg_.fillAmount = 0
		end
	else
		local var_27_3 = ArchiveData:GetArchive(arg_27_0.curRecordID_).exp
		local var_27_4, var_27_5 = LvTools.LoveExpToLevel(var_27_3)
		local var_27_6 = GameLevelSetting[var_27_4].hero_love_exp

		if arg_27_1 and arg_27_1 > 0 then
			if var_27_3 + arg_27_1 >= var_0_2() then
				arg_27_1 = var_0_2() - var_27_3
			end

			local var_27_7, var_27_8 = LvTools.LoveExpToLevel(var_27_3 + arg_27_1)
			local var_27_9 = GameLevelSetting[var_27_7].hero_love_exp

			if var_27_7 == HeroConst.HERO_LOVE_LV_MAX then
				arg_27_0.currlevelText_.text = GameLevelSetting[var_27_7 - 1].hero_love_exp .. "/" .. GameLevelSetting[var_27_7 - 1].hero_love_exp
				arg_27_0.addlevelText_.text = "+" .. arg_27_1

				if var_27_4 < var_27_7 - 1 then
					arg_27_0.processbarImg_.fillAmount = 0
					arg_27_0.processaddImg_.fillAmount = 1
				else
					arg_27_0.processbarImg_.fillAmount = var_27_5 / var_27_6
					arg_27_0.processaddImg_.fillAmount = 1
				end
			else
				arg_27_0.currlevelText_.text = var_27_8 .. "/" .. var_27_9
				arg_27_0.addlevelText_.text = "+" .. arg_27_1

				if var_27_4 < var_27_7 then
					arg_27_0.processbarImg_.fillAmount = 0
					arg_27_0.processaddImg_.fillAmount = var_27_8 / var_27_9
				else
					arg_27_0.processbarImg_.fillAmount = var_27_5 / var_27_6
					arg_27_0.processaddImg_.fillAmount = var_27_8 / var_27_9
				end
			end

			arg_27_0.previewLvCB_(var_27_7)
		elseif var_27_4 == HeroConst.HERO_LOVE_LV_MAX then
			arg_27_0.currlevelText_.text = GameLevelSetting[var_27_4 - 1].hero_love_exp .. "/" .. GameLevelSetting[var_27_4 - 1].hero_love_exp
			arg_27_0.addlevelText_.text = "[MAX]"
			arg_27_0.processbarImg_.fillAmount = 1
			arg_27_0.processaddImg_.fillAmount = 0
		else
			arg_27_0.currlevelText_.text = var_27_5 .. "/" .. var_27_6
			arg_27_0.addlevelText_.text = ""
			arg_27_0.processbarImg_.fillAmount = var_27_5 / var_27_6
			arg_27_0.processaddImg_.fillAmount = 0
		end
	end
end

local function var_0_5(arg_28_0)
	if arg_28_0 and arg_28_0 ~= 0 then
		for iter_28_0, iter_28_1 in ipairs(HeroVoiceCfg.get_id_list_by_file.emotion) do
			local var_28_0 = HeroVoiceCfg[iter_28_1]

			if var_28_0.use_skin_id == arg_28_0 then
				return var_28_0
			end
		end
	end
end

function var_0_0.PlayVoice(arg_29_0)
	if arg_29_0.voiceCoolDown_ then
		return
	end

	arg_29_0.voiceCoolDown_ = true

	local var_29_0 = HeroVoiceCfg.get_id_list_by_file.emotion[1]

	SDKTools.SendMessageToSDK("hero_sound", {
		hero_id = arg_29_0.curHeroID_,
		sound_id = var_29_0
	})
	arg_29_0:StopVoice()

	arg_29_0.delayPlayTimer_ = Timer.New(function()
		if manager.audio:IsStoppedOfVoice() then
			arg_29_0.delayPlayTimer_:Stop()

			arg_29_0.delayPlayTimer_ = nil

			local var_30_0 = arg_29_0.curHeroID_
			local var_30_1 = HeroData:GetHeroData(var_30_0)
			local var_30_2 = nullable(var_30_1, "using_skin")
			local var_30_3 = var_0_5(var_30_2)

			if var_30_3 then
				var_30_0 = var_30_3.use_skin_id
			end

			HeroTools.PlayVoice(var_30_0, HeroVoiceCfg[var_29_0].file, HeroVoiceCfg[var_29_0].type)

			local var_30_4 = HeroTools.GetTalkLength(var_30_0, HeroVoiceCfg[var_29_0].file, HeroVoiceCfg[var_29_0].type)
			local var_30_5 = math.max(var_30_4, 0.017)

			arg_29_0.timer_ = TimeTools.StartAfterSeconds(var_30_5 / 1000, function()
				arg_29_0:StopVoice()
			end, {})
		end
	end, 0.033, -1)

	arg_29_0.delayPlayTimer_:Start()
end

function var_0_0.StopVoice(arg_32_0)
	if arg_32_0.delayPlayTimer_ then
		arg_32_0.delayPlayTimer_:Stop()

		arg_32_0.delayPlayTimer_ = nil
	end

	manager.audio:StopVoiceImmediate()

	if arg_32_0.timer_ then
		arg_32_0.timer_:Stop()

		arg_32_0.timer_ = nil
		arg_32_0.voiceCoolDown_ = false
	end
end

function var_0_0.OnHeroTrustUpdate(arg_33_0)
	arg_33_0:UpdateGiftData()
	arg_33_0:RefreshExpProcess()

	local var_33_0, var_33_1, var_33_2 = ArchiveData:GetTrustLevel(arg_33_0.curHeroID_)

	Debug.Log("角色的交心等级是和经验是" .. var_33_0 .. " " .. var_33_1)
	arg_33_0:PlayVoice()

	if var_33_0 >= HeroConst.HERO_TRUST_LV_MAX then
		ShowTips("HERO_LOVE_LEVEL_MAX")
	else
		ShowTips("HERO_LOVE_EXP_UP")
	end

	if var_33_0 > 0 then
		arg_33_0.likeStateController_:SetSelectedState("trust")

		local var_33_3 = HeroTrustMoodCfg[var_33_2]

		if var_33_3 then
			arg_33_0.moodTitleText_.text = var_33_3.name
			arg_33_0.moodBuffText_.text = var_33_3.desc

			arg_33_0.moodStateController_:SetSelectedState(var_33_2)
		end
	else
		arg_33_0.likeStateController_:SetSelectedState("like")
	end

	if var_33_0 >= HeroConst.HERO_TRUST_LV_MAX then
		arg_33_0.likePanelStateController_:SetSelectedState("max")

		arg_33_0.impressionText_.text = HeroCfg[arg_33_0.curHeroID_].impression
	elseif var_33_1 >= HeroTrustLevelCfg[var_33_0].exp then
		arg_33_0.likePanelStateController_:SetSelectedState("levelup")
		arg_33_0.likeStateController_:SetSelectedState("like")

		arg_33_0.trustPriorText_.text = ArchiveTools.GetTrustLvDes(var_33_0)
		arg_33_0.trustNextText_.text = ArchiveTools.GetTrustLvDes(var_33_0 + 1)

		local var_33_4 = HeroTrustCfg.get_id_list_by_hero_id[arg_33_0.curHeroID_][var_33_0]
		local var_33_5 = HeroTrustCfg[var_33_4]

		arg_33_0.taskList_ = var_33_5.condition_list

		arg_33_0.trustLvUpTaskLuaUIList_:StartScroll(#arg_33_0.taskList_)

		local var_33_6 = var_33_5.reward_item_list[1]

		if var_33_6 then
			local var_33_7 = var_33_6[1]
			local var_33_8 = var_33_6[2]

			arg_33_0.trustLvTipsText_.text = GetTipsF("HERO_TRUST_UP_LV_REWARD", ArchiveTools.GetTrustLvDes(var_33_0 + 1))
			arg_33_0.trustLvRewardText_.text = ItemTools.getItemName(var_33_7) .. " X" .. var_33_8
			arg_33_0.trustLvRewardImg_.sprite = ItemTools.getItemSprite(var_33_7)
		end
	elseif #arg_33_0.giftList_ > 0 then
		arg_33_0.likePanelStateController_:SetSelectedState("gift")

		if arg_33_0.curGiftIndex_ > #arg_33_0.giftList_ then
			arg_33_0.curGiftIndex_ = #arg_33_0.giftList_
		elseif arg_33_0.curGiftIndex_ < 1 then
			arg_33_0.curGiftIndex_ = 1
		end

		arg_33_0.giftLuaUIList_:StartScroll(#arg_33_0.giftList_)
		arg_33_0:RefreshGiftInfo()
	else
		arg_33_0.likePanelStateController_:SetSelectedState("empty")
	end
end

function var_0_0.OnSendGift(arg_34_0)
	arg_34_0:UpdateGiftData()
	arg_34_0:RefreshExpProcess()
	arg_34_0:PlayVoice()

	if ArchiveData:GetArchive(arg_34_0.curRecordID_).exp >= var_0_2() then
		ShowTips("HERO_LOVE_LEVEL_MAX")
	else
		ShowTips("HERO_LOVE_EXP_UP")
	end

	if HeroRelationNetCfg.get_id_list_by_hero_id[arg_34_0.curHeroID_] then
		if ArchiveData:GetArchive(arg_34_0.curRecordID_).exp >= var_0_2() then
			if HeroTools.GetHeroIsUnlock(arg_34_0.curHeroID_) then
				arg_34_0.likePanelStateController_:SetSelectedState("canbreak")
			else
				arg_34_0.likePanelStateController_:SetSelectedState("notbreak")

				local var_34_0 = HeroCfg[arg_34_0.curHeroID_]

				arg_34_0.notbreakTipText_.text = GetTipsF("HERO_TRUST_BREAK_HERO_LOCK", string.format("%s·%s", GetI18NText(var_34_0.name), GetI18NText(var_34_0.suffix)))
			end
		elseif #arg_34_0.giftList_ > 0 then
			arg_34_0.likePanelStateController_:SetSelectedState("gift")

			if arg_34_0.curGiftIndex_ > #arg_34_0.giftList_ then
				arg_34_0.curGiftIndex_ = #arg_34_0.giftList_
			elseif arg_34_0.curGiftIndex_ < 1 then
				arg_34_0.curGiftIndex_ = 1
			end

			arg_34_0.giftLuaUIList_:StartScroll(#arg_34_0.giftList_)
			arg_34_0:RefreshGiftInfo()
		else
			arg_34_0.likePanelStateController_:SetSelectedState("empty")
		end
	elseif ArchiveData:GetArchive(arg_34_0.curRecordID_).exp >= var_0_2() then
		arg_34_0.likePanelStateController_:SetSelectedState("max")
	elseif #arg_34_0.giftList_ > 0 then
		arg_34_0.likePanelStateController_:SetSelectedState("gift")

		if arg_34_0.curGiftIndex_ > #arg_34_0.giftList_ then
			arg_34_0.curGiftIndex_ = #arg_34_0.giftList_
		elseif arg_34_0.curGiftIndex_ < 1 then
			arg_34_0.curGiftIndex_ = 1
		end

		arg_34_0.giftLuaUIList_:StartScroll(#arg_34_0.giftList_)
		arg_34_0:RefreshGiftInfo()
	else
		arg_34_0.likePanelStateController_:SetSelectedState("empty")
	end
end

function var_0_0.OnHeroModify(arg_35_0)
	local var_35_0, var_35_1, var_35_2 = ArchiveData:GetTrustLevel(arg_35_0.curHeroID_)
	local var_35_3 = HeroTrustMoodCfg[var_35_2]

	if var_35_3 then
		arg_35_0.moodTitleText_.text = var_35_3.name
		arg_35_0.moodBuffText_.text = var_35_3.desc

		arg_35_0.moodStateController_:SetSelectedState(var_35_2)
	end
end

function var_0_0.Dispose(arg_36_0)
	arg_36_0.giftLuaUIList_:Dispose()
	arg_36_0.trustLvUpTaskLuaUIList_:Dispose()
	var_0_0.super.Dispose(arg_36_0)
end

return var_0_0

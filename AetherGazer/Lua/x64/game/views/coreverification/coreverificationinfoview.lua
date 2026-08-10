local var_0_0 = class("CoreVerificationInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/CoreVerificationInfo"
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

	arg_4_0.bossModel_ = {}
	arg_4_0.loadIndexList_ = {}
	arg_4_0.bossAnimatorList_ = {}
	arg_4_0.cacheRootMotionList_ = {}
	arg_4_0.animatorTimer_ = {}
	arg_4_0.suffixList = {}
	arg_4_0.suffixIndex = {}
	arg_4_0.affixGoList_ = {
		arg_4_0.affix1Go_,
		arg_4_0.affix2Go_,
		arg_4_0.affix3Go_
	}
	arg_4_0.affixImgList_ = {
		arg_4_0.affix1Img_,
		arg_4_0.affix2Img_,
		arg_4_0.affix3Img_
	}
	arg_4_0.affixTextList_ = {
		arg_4_0.affix1Text_,
		arg_4_0.affix2Text_,
		arg_4_0.affix3Text_
	}
	arg_4_0.tabList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexTabItem), arg_4_0.tabUilist_, CoreVerificationInfoTabItem)
	arg_4_0.sufffixList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexSuffixItem), arg_4_0.suffixuilistGo_, CoreVerificationInfoSuffIxItem)
	arg_4_0.heroHeadItem_ = {}

	for iter_4_0 = 1, 6 do
		arg_4_0.heroHeadItem_[iter_4_0] = CoreVerificationRoleIcon.New(arg_4_0["hero" .. iter_4_0 .. "Go_"])
	end

	arg_4_0.passController_ = arg_4_0.mainControllerEx_:GetController("passState")
	arg_4_0.SelectSuffixController_ = arg_4_0.mainControllerEx_:GetController("isSelectSuffix")
	arg_4_0.flushedController_ = arg_4_0.mainControllerEx_:GetController("flushed")
	arg_4_0.updateInfoHandler = handler(arg_4_0, arg_4_0.UpdateCoreVerification)
end

function var_0_0.IndexTabItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.bossType_, arg_5_1, arg_5_0.curTab_, function()
		local var_6_0 = CoreVerificationData:GetInfoCfgByTypeAndDiff(arg_5_0.bossType_, arg_5_1)
		local var_6_1 = CoreVerificationData:GetStageInfoByTypeAndDiff(arg_5_0.bossType_, arg_5_1 - 1)
		local var_6_2 = PlayerData:GetPlayerInfo().userLevel
		local var_6_3 = CoreVerificationData:IsOpenChallgeByType(1)
		local var_6_4 = CoreVerificationData:IsOpenChallgeByType(2)

		if CoreVerificationData:IsChallengeType(var_6_0.id) and (not var_6_3 or not var_6_4) then
			ShowTips(GetTips("CORE_VERIFICATION_TAB_DES_3"))

			return
		end

		if var_6_2 < var_6_0.unlock_level then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_6_0.unlock_level))

			return
		end

		if arg_5_1 > 1 and not var_6_1 then
			ShowTips(string.format(GetTips("SOLO_HEART_DEMON_LOCK"), var_6_0.unlock_level))

			return
		end

		local var_6_5 = arg_5_0.tabList_:GetItemByIndex(arg_5_0.curTab_)

		if var_6_5 then
			var_6_5:Select(false)
		end

		arg_5_2:Select(true)

		arg_5_0.curTab_ = arg_5_1

		arg_5_0:UpdateView()
	end)
end

function var_0_0.IndexSuffixItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.suffixList[arg_7_1]
	local var_7_1 = arg_7_0.suffixIndex[arg_7_1]

	arg_7_2:SetData(var_7_0, var_7_1, arg_7_1, function(arg_8_0, arg_8_1)
		arg_7_0.suffixIndex[arg_8_0] = arg_8_1

		arg_7_0:UpdateSuffixScore()
	end)
end

function var_0_0.AddUIListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.battleBtn_, nil, function()
		if CoreVerificationData:IsChallengeType(arg_9_0.infoID_) then
			if arg_9_0.IsOnSelectSuffix then
				CoreVerificationAction.SelectSuffix(arg_9_0.infoID_, arg_9_0:GetSelectSuffixList())
				CoreVerificationTool.GotoFightSelect(arg_9_0.curStageID_, arg_9_0.infoID_, arg_9_0.bossType_)

				return
			end

			arg_9_0.IsOnSelectSuffix = true

			arg_9_0.SelectSuffixController_:SetSelectedState("true")
			manager.ui:SetUISeparateRender(true)
			arg_9_0:ShowSuffix(arg_9_0.infoID_)
		else
			CoreVerificationTool.GotoFightSelect(arg_9_0.curStageID_, arg_9_0.infoID_, arg_9_0.bossType_)
		end
	end)
	arg_9_0:AddBtnListener(arg_9_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationReward", {})
	end)
	arg_9_0:AddBtnListener(arg_9_0.shopBtn_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.CORE_VERIFICATION
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_9_0:AddBtnListener(arg_9_0.btn_flushedBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("CORE_VERIFICATION_RESETTIPS1"),
			OkCallback = function()
				CoreVerificationAction.ResetChallenge(0)
			end
		})
	end)
end

function var_0_0.UpdateCoreVerification(arg_15_0)
	CoreVerificationAction.UpdateChallengeRedPoints()
	arg_15_0:UpdateView()
end

function var_0_0.OnEnter(arg_16_0)
	manager.notify:RegistListener(CORE_VERIFICATION_CYCLE_UPDATE, arg_16_0.updateInfoHandler)

	arg_16_0.gameObject_.layer = 5

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("CORE_VERIFICATION_DES")
	manager.ui:SetMainCamera("bossChallenge")
	manager.windowBar:RegistBackCallBack(function()
		arg_16_0:Back()
	end)

	arg_16_0.exitView_ = false
	arg_16_0.bossType_ = arg_16_0.params_.bossType
	arg_16_0.curTab_ = CoreVerificationData:GetMaxUnlockByBossType(arg_16_0.bossType_)

	arg_16_0:UpdateView()

	local var_16_0 = CoreVerificationData:GetDiffListByBossType(arg_16_0.bossType_)

	arg_16_0.tabList_:StartScroll(#var_16_0)
	arg_16_0.tabList_:ScrollToIndex(arg_16_0.curTab_)

	local var_16_1 = CoreVerificationData:GetBossUICfgByBossType(arg_16_0.bossType_)

	arg_16_0.nameText_.text = GetI18NText(var_16_1.main_name)

	local var_16_2 = CoreVerificationData:GetRecommendByBossType(arg_16_0.bossType_)

	if var_16_2[1] then
		SetActive(arg_16_0.recommend1Img_.gameObject, true)

		arg_16_0.recommend1Img_.sprite = HeroTools.GetSkillAttributeIcon(var_16_2[1])
	else
		SetActive(arg_16_0.recommend1Img_.gameObject, false)
	end

	if var_16_2[2] then
		SetActive(arg_16_0.recommend2Img_.gameObject, true)

		arg_16_0.recommend2Img_.sprite = HeroTools.GetSkillAttributeIcon(var_16_2[2])
	else
		SetActive(arg_16_0.recommend2Img_.gameObject, false)
	end

	if table.isEmpty(var_16_2) then
		SetActive(arg_16_0.recommend1Img_.gameObject, true)

		arg_16_0.recommend1Img_.sprite = HeroTools.GetSkillAttributeIcon()
	end

	manager.redPoint:bindUIandKey(arg_16_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_NORMAL_REWARD)
	arg_16_0:LoadModel()
	arg_16_0:LoadBackScene()
	arg_16_0:OnSelfAdapt()
end

function var_0_0.OnSelfAdapt(arg_18_0)
	local var_18_0 = arg_18_0.left_2Trs_.sizeDelta

	arg_18_0.left_2Trs_.anchoredPosition = Vector3(var_0_0.VIEW_ADAPT_DISTANCE, 0, 0)
	arg_18_0.left_2Trs_.sizeDelta = Vector2.New(var_18_0.x - var_0_0.VIEW_ADAPT_DISTANCE * 2, var_18_0.y)
end

function var_0_0.GetSelectSuffixList(arg_19_0)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs(arg_19_0.suffixList) do
		local var_19_1 = arg_19_0.sufffixList_:GetItemByIndex(iter_19_0)

		if var_19_1.nowID then
			table.insert(var_19_0, var_19_1.nowID)
		end
	end

	return var_19_0
end

function var_0_0.ShowChanllengeView(arg_20_0, arg_20_1)
	arg_20_0.gameObject_.layer = 18
	arg_20_0.maskImg_.enabled = true

	arg_20_0.SelectSuffixController_:SetSelectedState(arg_20_1 and "true" or "false")

	arg_20_0.IsOnSelectSuffix = arg_20_1

	manager.ui:SetUISeparateRender(arg_20_1)
end

function var_0_0.Back(arg_21_0)
	manager.ui:SetUISeparateRender(false)

	if arg_21_0.IsOnSelectSuffix then
		arg_21_0.SelectSuffixController_:SetSelectedState("false")

		arg_21_0.IsOnSelectSuffix = false
	else
		arg_21_0.super:Back()
	end
end

function var_0_0.ShowSuffix(arg_22_0, arg_22_1)
	arg_22_0.sufffixList_:StartScroll(#arg_22_0.suffixList)
	arg_22_0:UpdateSuffixScore()

	local var_22_0 = CoreVerificationData:GetMaxScoreHeroInfo(arg_22_0.bossType_)

	arg_22_0.historyText_.text = var_22_0.score
end

function var_0_0.UpdateSuffixScore(arg_23_0)
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in pairs(arg_23_0.suffixList) do
		local var_23_1 = iter_23_1[arg_23_0.suffixIndex[iter_23_0]]
		local var_23_2 = ActivityAffixPoolCfg[var_23_1]

		var_23_0 = var_23_0 + (var_23_2 and var_23_2.point or 0)
	end

	arg_23_0.suffixText_.text = var_23_0
end

function var_0_0.OnExit(arg_24_0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()

	arg_24_0.exitView_ = true

	manager.redPoint:unbindUIandKey(arg_24_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_NORMAL_REWARD)
	manager.notify:RemoveListener(CORE_VERIFICATION_CYCLE_UPDATE, arg_24_0.updateInfoHandler)
	arg_24_0:UnloadModel()
	arg_24_0:UnloadBackScene()
end

function var_0_0.UpdateView(arg_25_0)
	local var_25_0 = CoreVerificationData:GetAffixByTypeAndDiff(arg_25_0.bossType_, arg_25_0.curTab_)
	local var_25_1 = getMosterAffix(var_25_0) or getHeroAffixs(var_25_0)

	for iter_25_0 = 1, 3 do
		if var_25_1[iter_25_0] then
			SetActive(arg_25_0.affixGoList_[iter_25_0], true)

			arg_25_0.affixImgList_[iter_25_0].sprite = getAffixSprite(var_25_1[iter_25_0])
			arg_25_0.affixTextList_[iter_25_0].text = GetI18NText(getAffixDesc(var_25_1[iter_25_0]))
		else
			SetActive(arg_25_0.affixGoList_[iter_25_0], false)
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_0.affixRoot_)

	local var_25_2 = CoreVerificationData:GetInfoCfgByTypeAndDiff(arg_25_0.bossType_, arg_25_0.curTab_)

	arg_25_0.curStageID_ = var_25_2.stage_id
	arg_25_0.infoID_ = var_25_2.id
	arg_25_0.suffixList = CoreVerificationData:GetSuffixList(var_25_2.id)
	arg_25_0.suffixIndex = CoreVerificationData:GetRecordSuffixIndexList(var_25_2.id)
	arg_25_0.lockHero_ = CoreVerificationData:GetLockHeroByBossType(arg_25_0.bossType_)

	local var_25_3 = CoreVerificationData:GetStageInfoByTypeAndDiff(arg_25_0.bossType_, arg_25_0.curTab_)

	if var_25_3 and var_25_3.passState then
		arg_25_0.passController_:SetSelectedState("complete")

		arg_25_0.timeText_.text = manager.time:DescCdTime2(var_25_3.passTime)

		for iter_25_1 = 1, 6 do
			arg_25_0.heroHeadItem_[iter_25_1]:SetData(arg_25_0.lockHero_[iter_25_1])
		end
	elseif var_25_3 then
		arg_25_0.passController_:SetSelectedState("empty")
	elseif arg_25_0.curTab_ == 1 or CoreVerificationData:GetStageInfoByTypeAndDiff(arg_25_0.bossType_, arg_25_0.curTab_ - 1) then
		arg_25_0.passController_:SetSelectedState("empty")
	else
		arg_25_0.passController_:SetSelectedState("lock")
	end

	arg_25_0.flushedController_:SetSelectedIndex(CoreVerificationData:GetCanReset() and 1 or 0)
end

function var_0_0.Dispose(arg_26_0)
	arg_26_0.gameObject_.layer = 5

	for iter_26_0 = 1, 6 do
		if arg_26_0.heroHeadItem_[iter_26_0] then
			arg_26_0.heroHeadItem_[iter_26_0]:Dispose()

			arg_26_0.heroHeadItem_[iter_26_0] = nil
		end
	end

	if arg_26_0.tabList_ then
		arg_26_0.tabList_:Dispose()

		arg_26_0.tabList_ = nil
	end

	if arg_26_0.sufffixList_ then
		arg_26_0.sufffixList_:Dispose()

		arg_26_0.sufffixList_ = nil
	end

	var_0_0.super.Dispose(arg_26_0)
end

function var_0_0.LoadModel(arg_27_0)
	arg_27_0:UnloadModel()

	local var_27_0 = CoreVerificationData:GetBossUICfgByBossType(arg_27_0.bossType_)

	for iter_27_0, iter_27_1 in pairs(var_27_0.boss_id_list) do
		arg_27_0.loadIndexList_[iter_27_0] = manager.resourcePool:AsyncLoad("Char/" .. MonsterCfg[iter_27_1].model_name, ASSET_TYPE.TPOSE, function(arg_28_0)
			if arg_27_0.exitView_ then
				manager.resourcePool:DestroyOrReturn(arg_28_0, ASSET_TYPE.TPOSE)

				return
			end

			local var_28_0 = var_27_0.model_pos[iter_27_0]
			local var_28_1 = var_27_0.model_rot[iter_27_0]
			local var_28_2 = var_27_0.model_scale[iter_27_0]

			arg_27_0.bossModel_[iter_27_0] = arg_28_0
			arg_27_0.bossModel_[iter_27_0].transform.localPosition = Vector3(var_28_0[1], var_28_0[2], var_28_0[3])
			arg_27_0.bossModel_[iter_27_0].transform.localEulerAngles = Vector3(var_28_1[1], var_28_1[2], var_28_1[3])
			arg_27_0.bossModel_[iter_27_0].transform.localScale = Vector3(var_28_2[1], var_28_2[2], var_28_2[3])
			arg_27_0.bossAnimatorList_[iter_27_0] = arg_27_0.bossModel_[iter_27_0]:GetComponent(typeof(Animator))

			arg_27_0:PlayAppearAnimation(iter_27_0, function()
				arg_27_0.bossAnimatorList_[iter_27_0]:CrossFadeInFixedTime("stand", 0.01)
			end)
		end)
	end
end

function var_0_0.UnloadModel(arg_30_0)
	for iter_30_0, iter_30_1 in pairs(arg_30_0.bossModel_) do
		arg_30_0.bossAnimatorList_[iter_30_0].applyRootMotion = arg_30_0.cacheRootMotionList_[iter_30_0]

		manager.resourcePool:DestroyOrReturn(iter_30_1, ASSET_TYPE.TPOSE)
	end

	arg_30_0.bossModel_ = {}
	arg_30_0.bossAnimatorList_ = {}

	for iter_30_2, iter_30_3 in pairs(arg_30_0.loadIndexList_) do
		manager.resourcePool:StopAsyncQuest(iter_30_3)
	end

	arg_30_0.loadIndexList_ = {}

	arg_30_0:StopAllAnimatorTimer()
end

function var_0_0.PlayAppearAnimation(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = CoreVerificationData:GetBossUICfgByBossType(arg_31_0.bossType_)
	local var_31_1 = arg_31_0.bossAnimatorList_[arg_31_1]

	arg_31_0.cacheRootMotionList_[arg_31_1] = arg_31_0.bossAnimatorList_[arg_31_1].applyRootMotion
	arg_31_0.bossAnimatorList_[arg_31_1].applyRootMotion = false

	if type(var_31_0.appear_ani) == "table" and var_31_0.appear_ani[arg_31_1] ~= "" then
		arg_31_0.bossAnimatorList_[arg_31_1]:Play(var_31_0.appear_ani[arg_31_1])

		local var_31_2

		var_31_2 = FrameTimer.New(function()
			if var_31_1:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
				var_31_2:Stop()
				table.removebyvalue(arg_31_0.animatorTimer_, var_31_2)

				var_31_2 = nil

				arg_31_2()
			end
		end, 1, -1)

		table.insert(arg_31_0.animatorTimer_, var_31_2)
		var_31_2:Start()
	else
		arg_31_2()
	end
end

function var_0_0.StopAllAnimatorTimer(arg_33_0)
	for iter_33_0 = #arg_33_0.animatorTimer_, 1, -1 do
		arg_33_0.animatorTimer_[iter_33_0]:Stop()

		arg_33_0.animatorTimer_[iter_33_0] = nil
	end
end

function var_0_0.LoadBackScene(arg_34_0)
	local var_34_0 = "UI/Common/BackgroundQuad"

	arg_34_0.backGround_ = manager.resourcePool:Get(var_34_0, ASSET_TYPE.SCENE)
	arg_34_0.backGroundTrs_ = arg_34_0.backGround_.transform

	arg_34_0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	local var_34_1 = GameDisplayCfg.boss_background_pos.value

	arg_34_0.backGroundTrs_.localPosition = Vector3(var_34_1[1], var_34_1[2], var_34_1[3])
	arg_34_0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)

	local var_34_2 = GameDisplayCfg.boss_background_pos.scale

	arg_34_0.backGroundTrs_.localScale = Vector3(2, 2, 2)
	arg_34_0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureBg/Core_Verification/bg2")
end

function var_0_0.UnloadBackScene(arg_35_0)
	if arg_35_0.backGround_ then
		manager.resourcePool:DestroyOrReturn(arg_35_0.backGround_, ASSET_TYPE.SCENE)

		arg_35_0.backGround_ = nil
	end
end

function var_0_0.OnTop(arg_36_0)
	return
end

function var_0_0.OnBehind(arg_37_0)
	arg_37_0.gameObject_.layer = 5
	arg_37_0.maskImg_.enabled = false
end

return var_0_0

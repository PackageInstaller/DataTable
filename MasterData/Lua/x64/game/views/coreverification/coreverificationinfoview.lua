local CoreVerificationInfoView = class("CoreVerificationInfoView", ReduxView)

function CoreVerificationInfoView:UIName()
	return "Widget/System/Core_verification_new/CoreVerificationInfo"
end

function CoreVerificationInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function CoreVerificationInfoView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CoreVerificationInfoView:InitUI()
	self:BindCfgUI()

	self.bossModel_ = {}
	self.loadIndexList_ = {}
	self.bossAnimatorList_ = {}
	self.cacheRootMotionList_ = {}
	self.animatorTimer_ = {}
	self.suffixList = {}
	self.suffixIndex = {}
	self.affixGoList_ = {
		self.affix1Go_,
		self.affix2Go_,
		self.affix3Go_
	}
	self.affixImgList_ = {
		self.affix1Img_,
		self.affix2Img_,
		self.affix3Img_
	}
	self.affixTextList_ = {
		self.affix1Text_,
		self.affix2Text_,
		self.affix3Text_
	}
	self.tabList_ = LuaList.New(handler(self, self.IndexTabItem), self.tabUilist_, CoreVerificationInfoTabItem)
	self.sufffixList_ = LuaList.New(handler(self, self.IndexSuffixItem), self.suffixuilistGo_, CoreVerificationInfoSuffIxItem)
	self.heroHeadItem_ = {}

	for iter_4_0 = 1, 6 do
		self.heroHeadItem_[iter_4_0] = CoreVerificationRoleIcon.New(self["hero" .. iter_4_0 .. "Go_"])
	end

	self.passController_ = self.mainControllerEx_:GetController("passState")
	self.SelectSuffixController_ = self.mainControllerEx_:GetController("isSelectSuffix")
	self.flushedController_ = self.mainControllerEx_:GetController("flushed")
	self.updateInfoHandler = handler(self, self.UpdateCoreVerification)
end

function CoreVerificationInfoView:IndexTabItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.bossType_, arg_5_1, self.curTab_, function()
		local var_6_0 = CoreVerificationData:GetInfoCfgByTypeAndDiff(self.bossType_, arg_5_1)

		if CoreVerificationData:IsChallengeType(var_6_0.id) and (not CoreVerificationData:IsOpenChallgeByType(1) or not CoreVerificationData:IsOpenChallgeByType(2)) then
			ShowTips(GetTips("CORE_VERIFICATION_TAB_DES_3"))

			return
		end

		if PlayerData:GetPlayerInfo().userLevel < var_6_0.unlock_level then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_6_0.unlock_level))

			return
		end

		if arg_5_1 > 1 and not CoreVerificationData:GetStageInfoByTypeAndDiff(self.bossType_, arg_5_1 - 1) then
			ShowTips(string.format(GetTips("SOLO_HEART_DEMON_LOCK"), var_6_0.unlock_level))

			return
		end

		local var_6_1 = self.tabList_:GetItemByIndex(self.curTab_)

		if var_6_1 then
			var_6_1:Select(false)
		end

		arg_5_2:Select(true)

		self.curTab_ = arg_5_1

		self:UpdateView()
	end)
end

function CoreVerificationInfoView:IndexSuffixItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(self.suffixList[arg_7_1], self.suffixIndex[arg_7_1], arg_7_1, function(arg_8_0, arg_8_1)
		self.suffixIndex[arg_8_0] = arg_8_1

		self:UpdateSuffixScore()
	end)
end

function CoreVerificationInfoView:AddUIListeners()
	self:AddBtnListener(self.battleBtn_, nil, function()
		if CoreVerificationData:IsChallengeType(self.infoID_) then
			if self.IsOnSelectSuffix then
				CoreVerificationAction.SelectSuffix(self.infoID_, self:GetSelectSuffixList())
				CoreVerificationTool.GotoFightSelect(self.curStageID_, self.infoID_, self.bossType_)

				return
			end

			self.IsOnSelectSuffix = true

			self.SelectSuffixController_:SetSelectedState("true")
			manager.ui:SetUISeparateRender(true)
			self:ShowSuffix(self.infoID_)
		else
			CoreVerificationTool.GotoFightSelect(self.curStageID_, self.infoID_, self.bossType_)
		end
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationReward", {})
	end)
	self:AddBtnListener(self.shopBtn_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.CORE_VERIFICATION
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.btn_flushedBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("CORE_VERIFICATION_RESETTIPS1"),
			OkCallback = function()
				CoreVerificationAction.ResetChallenge(0)
			end
		})
	end)
end

function CoreVerificationInfoView:UpdateCoreVerification()
	CoreVerificationAction.UpdateChallengeRedPoints()
	self:UpdateView()
end

function CoreVerificationInfoView:OnEnter()
	manager.notify:RegistListener(CORE_VERIFICATION_CYCLE_UPDATE, self.updateInfoHandler)

	self.gameObject_.layer = 5

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("CORE_VERIFICATION_DES")
	manager.ui:SetMainCamera("bossChallenge")
	manager.windowBar:RegistBackCallBack(function()
		self:Back()
	end)

	self.exitView_ = false
	self.bossType_ = self.params_.bossType
	self.curTab_ = CoreVerificationData:GetMaxUnlockByBossType(self.bossType_)

	self:UpdateView()
	self.tabList_:StartScroll(#CoreVerificationData:GetDiffListByBossType(self.bossType_))
	self.tabList_:ScrollToIndex(self.curTab_)

	self.nameText_.text = GetI18NText(CoreVerificationData:GetBossUICfgByBossType(self.bossType_).main_name)

	local var_16_0 = CoreVerificationData:GetRecommendByBossType(self.bossType_)

	if var_16_0[1] then
		SetActive(self.recommend1Img_.gameObject, true)

		self.recommend1Img_.sprite = HeroTools.GetSkillAttributeIcon(var_16_0[1])
	else
		SetActive(self.recommend1Img_.gameObject, false)
	end

	if var_16_0[2] then
		SetActive(self.recommend2Img_.gameObject, true)

		self.recommend2Img_.sprite = HeroTools.GetSkillAttributeIcon(var_16_0[2])
	else
		SetActive(self.recommend2Img_.gameObject, false)
	end

	if table.isEmpty(var_16_0) then
		SetActive(self.recommend1Img_.gameObject, true)

		self.recommend1Img_.sprite = HeroTools.GetSkillAttributeIcon()
	end

	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_NORMAL_REWARD)
	self:LoadModel()
	self:LoadBackScene()
	self:OnSelfAdapt()
end

function CoreVerificationInfoView:OnSelfAdapt()
	self.left_2Trs_.anchoredPosition = Vector3(CoreVerificationInfoView.VIEW_ADAPT_DISTANCE, 0, 0)
	self.left_2Trs_.sizeDelta = Vector2.New(self.left_2Trs_.sizeDelta.x - CoreVerificationInfoView.VIEW_ADAPT_DISTANCE * 2, self.left_2Trs_.sizeDelta.y)
end

function CoreVerificationInfoView:GetSelectSuffixList()
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs(self.suffixList) do
		local var_19_1 = self.sufffixList_:GetItemByIndex(iter_19_0)

		if var_19_1.nowID then
			table.insert(var_19_0, var_19_1.nowID)
		end
	end

	return var_19_0
end

function CoreVerificationInfoView:ShowChanllengeView(arg_20_1)
	self.gameObject_.layer = 18
	self.maskImg_.enabled = true

	self.SelectSuffixController_:SetSelectedState(arg_20_1 and "true" or "false")

	self.IsOnSelectSuffix = arg_20_1

	manager.ui:SetUISeparateRender(arg_20_1)
end

function CoreVerificationInfoView:Back()
	manager.ui:SetUISeparateRender(false)

	if self.IsOnSelectSuffix then
		self.SelectSuffixController_:SetSelectedState("false")

		self.IsOnSelectSuffix = false
	else
		self.super:Back()
	end
end

function CoreVerificationInfoView:ShowSuffix(arg_22_1)
	self.sufffixList_:StartScroll(#self.suffixList)
	self:UpdateSuffixScore()

	self.historyText_.text = CoreVerificationData:GetMaxScoreHeroInfo(self.bossType_).score
end

function CoreVerificationInfoView:UpdateSuffixScore()
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in pairs(self.suffixList) do
		var_23_0 = var_23_0 + ((ActivityAffixPoolCfg[iter_23_1[self.suffixIndex[iter_23_0]]] or nil) and (ActivityAffixPoolCfg[iter_23_1[self.suffixIndex[iter_23_0]]].point or 0))
	end

	self.suffixText_.text = var_23_0
end

function CoreVerificationInfoView:OnExit()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()

	self.exitView_ = true

	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_NORMAL_REWARD)
	manager.notify:RemoveListener(CORE_VERIFICATION_CYCLE_UPDATE, self.updateInfoHandler)
	self:UnloadModel()
	self:UnloadBackScene()
end

function CoreVerificationInfoView:UpdateView()
	local var_25_0 = CoreVerificationData:GetAffixByTypeAndDiff(self.bossType_, self.curTab_)
	local var_25_1 = getMosterAffix(var_25_0) or getHeroAffixs(var_25_0)

	for iter_25_0 = 1, 3 do
		if var_25_1[iter_25_0] then
			SetActive(self.affixGoList_[iter_25_0], true)

			self.affixImgList_[iter_25_0].sprite = getAffixSprite(var_25_1[iter_25_0])
			self.affixTextList_[iter_25_0].text = GetI18NText(getAffixDesc(var_25_1[iter_25_0]))
		else
			SetActive(self.affixGoList_[iter_25_0], false)
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.affixRoot_)

	local var_25_2 = CoreVerificationData:GetInfoCfgByTypeAndDiff(self.bossType_, self.curTab_)

	self.curStageID_ = var_25_2.stage_id
	self.infoID_ = var_25_2.id
	self.suffixList = CoreVerificationData:GetSuffixList(var_25_2.id)
	self.suffixIndex = CoreVerificationData:GetRecordSuffixIndexList(var_25_2.id)
	self.lockHero_ = CoreVerificationData:GetLockHeroByBossType(self.bossType_)

	local var_25_3 = CoreVerificationData:GetStageInfoByTypeAndDiff(self.bossType_, self.curTab_)

	if var_25_3 and var_25_3.passState then
		self.passController_:SetSelectedState("complete")

		self.timeText_.text = manager.time:DescCdTime2(var_25_3.passTime)

		for iter_25_1 = 1, 6 do
			self.heroHeadItem_[iter_25_1]:SetData(self.lockHero_[iter_25_1])
		end
	elseif var_25_3 then
		self.passController_:SetSelectedState("empty")
	elseif self.curTab_ == 1 or CoreVerificationData:GetStageInfoByTypeAndDiff(self.bossType_, self.curTab_ - 1) then
		self.passController_:SetSelectedState("empty")
	else
		self.passController_:SetSelectedState("lock")
	end

	self.flushedController_:SetSelectedIndex(CoreVerificationData:GetCanReset() and 1 or 0)
end

function CoreVerificationInfoView:Dispose()
	self.gameObject_.layer = 5

	for iter_26_0 = 1, 6 do
		if self.heroHeadItem_[iter_26_0] then
			self.heroHeadItem_[iter_26_0]:Dispose()

			self.heroHeadItem_[iter_26_0] = nil
		end
	end

	if self.tabList_ then
		self.tabList_:Dispose()

		self.tabList_ = nil
	end

	if self.sufffixList_ then
		self.sufffixList_:Dispose()

		self.sufffixList_ = nil
	end

	CoreVerificationInfoView.super.Dispose(self)
end

function CoreVerificationInfoView:LoadModel()
	self:UnloadModel()

	local var_27_0 = CoreVerificationData:GetBossUICfgByBossType(self.bossType_)

	for iter_27_0, iter_27_1 in pairs(var_27_0.boss_id_list) do
		self.loadIndexList_[iter_27_0] = manager.resourcePool:AsyncLoad("Char/" .. MonsterCfg[iter_27_1].model_name, ASSET_TYPE.TPOSE, function(arg_28_0)
			if self.exitView_ then
				manager.resourcePool:DestroyOrReturn(arg_28_0, ASSET_TYPE.TPOSE)

				return
			end

			local var_28_0 = var_27_0.model_pos[iter_27_0]

			self.bossModel_[iter_27_0] = arg_28_0
			self.bossModel_[iter_27_0].transform.localPosition = Vector3(var_28_0[1], var_28_0[2], var_28_0[3])
			self.bossModel_[iter_27_0].transform.localEulerAngles = Vector3(var_27_0.model_rot[iter_27_0][1], var_27_0.model_rot[iter_27_0][2], var_27_0.model_rot[iter_27_0][3])
			self.bossModel_[iter_27_0].transform.localScale = Vector3(var_27_0.model_scale[iter_27_0][1], var_27_0.model_scale[iter_27_0][2], var_27_0.model_scale[iter_27_0][3])
			self.bossAnimatorList_[iter_27_0] = self.bossModel_[iter_27_0]:GetComponent(typeof(Animator))

			self:PlayAppearAnimation(iter_27_0, function()
				self.bossAnimatorList_[iter_27_0]:CrossFadeInFixedTime("stand", 0.01)
			end)
		end)
	end
end

function CoreVerificationInfoView:UnloadModel()
	for iter_30_0, iter_30_1 in pairs(self.bossModel_) do
		self.bossAnimatorList_[iter_30_0].applyRootMotion = self.cacheRootMotionList_[iter_30_0]

		manager.resourcePool:DestroyOrReturn(iter_30_1, ASSET_TYPE.TPOSE)
	end

	self.bossModel_ = {}
	self.bossAnimatorList_ = {}

	for iter_30_2, iter_30_3 in pairs(self.loadIndexList_) do
		manager.resourcePool:StopAsyncQuest(iter_30_3)
	end

	self.loadIndexList_ = {}

	self:StopAllAnimatorTimer()
end

function CoreVerificationInfoView:PlayAppearAnimation(arg_31_1, arg_31_2)
	local var_31_0 = CoreVerificationData:GetBossUICfgByBossType(self.bossType_)
	local var_31_1 = self.bossAnimatorList_[arg_31_1]

	self.cacheRootMotionList_[arg_31_1] = self.bossAnimatorList_[arg_31_1].applyRootMotion
	self.bossAnimatorList_[arg_31_1].applyRootMotion = false

	if type(var_31_0.appear_ani) == "table" and var_31_0.appear_ani[arg_31_1] ~= "" then
		self.bossAnimatorList_[arg_31_1]:Play(var_31_0.appear_ani[arg_31_1])

		local var_31_2

		var_31_2 = FrameTimer.New(function()
			if var_31_1:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
				var_31_2:Stop()
				table.removebyvalue(self.animatorTimer_, var_31_2)

				var_31_2 = nil

				arg_31_2()
			end
		end, 1, -1)

		table.insert(self.animatorTimer_, nil)
		var_31_2:Start()
	else
		arg_31_2()
	end
end

function CoreVerificationInfoView:StopAllAnimatorTimer()
	for iter_33_0 = #self.animatorTimer_, 1, -1 do
		self.animatorTimer_[iter_33_0]:Stop()

		self.animatorTimer_[iter_33_0] = nil
	end
end

function CoreVerificationInfoView:LoadBackScene()
	self.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	self.backGroundTrs_ = self.backGround_.transform

	self.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	self.backGroundTrs_.localPosition = Vector3(GameDisplayCfg.boss_background_pos.value[1], GameDisplayCfg.boss_background_pos.value[2], GameDisplayCfg.boss_background_pos.value[3])
	self.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	self.backGroundTrs_.localScale = Vector3(2, 2, 2)
	self.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureBg/Core_Verification/bg2")
end

function CoreVerificationInfoView:UnloadBackScene()
	if self.backGround_ then
		manager.resourcePool:DestroyOrReturn(self.backGround_, ASSET_TYPE.SCENE)

		self.backGround_ = nil
	end
end

function CoreVerificationInfoView:OnTop()
	return
end

function CoreVerificationInfoView:OnBehind()
	self.gameObject_.layer = 5
	self.maskImg_.enabled = false
end

return CoreVerificationInfoView

local BattleResultBaseView = class("BattleResultBaseView", ReduxView)

function BattleResultBaseView:UIName()
	return "UI/BattleResult/BattleSettlementUI"
end

function BattleResultBaseView:UIParent()
	return manager.ui.uiMain.transform
end

function BattleResultBaseView:ChangeCameraToEmpty()
	manager.ui.mainCamera.transform.localPosition = Vector3(0, -180, 0)
	manager.ui.mainCamera.transform.localEulerAngles = Vector3(0, 180, 0)
end

function BattleResultBaseView:Init()
	self:InitUI()
	self:AddListener()
end

function BattleResultBaseView:OnEnter()
	self.tweens_ = {}
	self.stageData = self.params_.stageData
	self.stageId = self.stageData:GetStageId()
	self.stageType = self.stageData:GetType()
	self.heroExp_ = {}

	BattleInstance.hideBattlePanel()
	self:CaculateReward()
	self:RefreshUI()
	self:CheckBattleError()
end

function BattleResultBaseView:OnExit()
	return
end

function BattleResultBaseView:Dispose()
	self:RemoveTween()
	self:RemoveTweens()

	for iter_7_0, iter_7_1 in ipairs(self.rewardItems_) do
		iter_7_1:Dispose()
	end

	self.rewardItems_ = nil

	for iter_7_2, iter_7_3 in ipairs(self.rewardItemGos_) do
		Object.Destroy(iter_7_3)
	end

	self.rewardItemGos_ = nil
	self.heroLv_ = nil
	self.heroGo_ = nil
	self.heroImg_ = nil
	self.missionGo_ = nil
	self.missionAchieve_ = nil
	self.heroAddExp = nil
	self.missionNoAchieve_ = nil
	self.heroProgress_ = nil
	self.missionText_ = nil
	self.rewardList_ = nil
	self.addExp_ = nil
	self.stareText_ = nil
	self.lvText_ = nil
	self.bg_screen_ = nil
	self.rewardListTrs_ = nil
	self.mask_ = nil
	self.playerLv_ = nil
	self.btnBack_ = nil
	self.btnBattleCount_ = nil
	self.missionTipGo_ = nil
	self.progress_ = nil

	BattleResultBaseView.super.Dispose(self)
end

function BattleResultBaseView:InitUI()
	self:BindCfgUI()

	self.itemPrefeb = self.itemPrefeb or Asset.Load("UI/Common/CommonItem")
	self.noInfoGos_ = {}
	self.missionGo_ = {}
	self.missionNoAchieve_ = {}
	self.missionAchieve_ = {}
	self.missionText_ = {}

	for iter_8_0 = 1, 3 do
		self.noInfoGos_[iter_8_0] = self["noInfo" .. iter_8_0]
		self.missionGo_[iter_8_0] = self["mission" .. iter_8_0]
		self.missionNoAchieve_[iter_8_0] = self["noachieve" .. iter_8_0]
		self.missionAchieve_[iter_8_0] = self["achieve" .. iter_8_0]
		self.missionText_[iter_8_0] = self["missionText" .. iter_8_0]
	end

	self.heroGo_ = {}
	self.heroLv_ = {}
	self.heroImg_ = {}
	self.heroAddExp = {}
	self.heroProgress_ = {}

	for iter_8_1 = 1, 3 do
		self.heroGo_[iter_8_1] = self["hero" .. iter_8_1]
		self.heroLv_[iter_8_1] = self["heroLvText" .. iter_8_1]
		self.heroImg_[iter_8_1] = self["heroMaskIcon" .. iter_8_1]
		self.heroAddExp[iter_8_1] = self["heroAddExp" .. iter_8_1]
		self.heroProgress_[iter_8_1] = self["heroExpProgress" .. iter_8_1]
	end

	self.rewardItems_ = {}
	self.rewardItemGos_ = {}

	LeanTween.alphaCanvas(self.mask_, 0, 0.1)
end

function BattleResultBaseView:AddListener()
	self:AddBtnListener(self.btnBack_, nil, function()
		self:CloseFunc()
	end)
	self:AddBtnListener(self.btnClose_, nil, function()
		self:CloseFunc()
	end)
	self:AddBtnListener(self.buttonMask_, nil, function()
		self:EndAnimator()
	end)
	self:AddBtnListener(self.btnOnceMore_, nil, function()
		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) < self.stageData:GetCost() * self.stageData:GetMultiple() then
			if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
				JumpTools.OpenPopUp("currencyBuyFatigue", {}, ViewConst.SYSTEM_ID.BUY_FATIGUE)
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
			end
		else
			BattleInstance.OnceMoreBattle(self.stageData)
		end
	end)
	self:AddBtnListener(self.btnBattleCount_, nil, function()
		self:GoToBattleStatistics()
	end)
end

function BattleResultBaseView:RemoveListener()
	self.btnBack_.onClick:RemoveAllListeners()
	self.btnBattleCount_.onClick:RemoveAllListeners()
end

function BattleResultBaseView:RefreshUI()
	self:SetLevelTitle()
	self:RefreshRewardItemS()
	self:RefreshMyExpS()
	self:RefreshHeroS()
	self:RefreshMissionS()
	self:RefreshCommonUI()
	self:RefreshBattleTime()
end

function BattleResultBaseView:SetLevelTitle()
	local var_17_0, var_17_1 = BattleStageTools.GetChapterSectionIndex(self.stageType, self.stageId)

	self.stareText_.text = var_17_0 ~= "" and string.format("%s-%s", GetI18NText(var_17_0), GetI18NText(var_17_1)) or ""
	self.lvText_.text = GetI18NText(BattleStageTools.GetStageName(self.stageType, self.stageId))

	self:RefreshTitleImmediate()
end

function BattleResultBaseView:RefreshRewardItemS()
	for iter_18_0, iter_18_1 in ipairs(self.rewardItems_) do
		iter_18_1:Show(false)
	end

	local var_18_0 = {}

	if self.params_.rewardList then
		for iter_18_2, iter_18_3 in pairs(self.params_.rewardList) do
			table.insert(var_18_0, iter_18_3)
		end

		var_18_0 = formatRewardCfgList(var_18_0)
		var_18_0 = mergeReward(var_18_0)
		var_18_0 = sortReward(var_18_0)
	end

	for iter_18_4 = 1, #var_18_0 do
		if not self.rewardItems_[iter_18_4] then
			local var_18_1 = Object.Instantiate(self.itemPrefeb, self.rewardList_)

			self.rewardItems_[iter_18_4] = CommonItem.New(var_18_1)

			self.rewardItems_[iter_18_4]:RegistCallBack(function(arg_19_0)
				ShowPopItem(POP_OTHER_ITEM, {
					arg_19_0.id,
					arg_19_0.number
				})
			end)

			self.rewardItemGos_[iter_18_4] = var_18_1

			self.rewardItems_[iter_18_4]:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
			self.rewardItems_[iter_18_4]:SetBottomTextColor(Color.white)
			self.rewardItems_[iter_18_4]:Show(true)
		else
			self.rewardItems_[iter_18_4]:Show(true)
		end

		local var_18_2 = var_18_0[iter_18_4]

		if ItemCfg[var_18_0[iter_18_4].id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[var_18_2.id].type then
			var_18_2.race = EquipCfg[var_18_2.id] and EquipCfg[var_18_2.id].race
		end

		self.rewardItems_[iter_18_4]:RefreshData(rewardToItemTemplate(var_18_2))
	end
end

function BattleResultBaseView:RefreshHeroS()
	local var_20_0, var_20_1 = self.stageData:GetHeroTeam()
	local var_20_2 = self.stageData:GetSystemHeroTeam()

	if var_20_0[2] == 0 then
		table.remove(var_20_0, 2)
		table.remove(var_20_1, 2)
		table.insert(var_20_0, 0)
		table.insert(var_20_1, 0)
	end

	local var_20_3 = self.params_.battleResult.heroDataCollect

	for iter_20_0 = 1, 3 do
		if not var_20_0[iter_20_0] or var_20_0[iter_20_0] == 0 then
			SetActive(self.heroGo_[iter_20_0], false)
		else
			SetActive(self.heroGo_[iter_20_0], true)

			local var_20_4 = self.stageData:GetHeroDataByPos(iter_20_0)

			if self.heroImg_[iter_20_0] ~= nil then
				self.heroImg_[iter_20_0].sprite = getSpriteViaConfig("HeroIcon", SkinCfg[var_20_4.using_skin].picture_id)
			end

			if var_20_3[iter_20_0] and self:NeedAddExp() then
				self.heroAddExp[iter_20_0].text = ""

				self:RemoveTweenAt(iter_20_0)

				self.heroExp_[iter_20_0] = var_20_3[iter_20_0].newLv + var_20_3[iter_20_0].newPersent
				self.tweens_[iter_20_0] = LeanTween.value(self.heroProgress_[iter_20_0].gameObject, var_20_3[iter_20_0].oldLv + var_20_3[iter_20_0].oldPersent, var_20_3[iter_20_0].newLv + var_20_3[iter_20_0].newPersent, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					self:UpdateHeroData(iter_20_0, arg_21_0)
				end)):setOnComplete(LuaHelper.VoidAction(function()
					self:RemoveTweenAt(iter_20_0)
				end))
			else
				self.heroAddExp[iter_20_0].text = ""
				self.heroLv_[iter_20_0].text = var_20_4.level
				self.heroProgress_[iter_20_0].value = 1
			end
		end
	end
end

function BattleResultBaseView:RefreshMyExpS()
	local var_23_0 = self.stageData:GetAddUserExp() * self.stageData:GetMultiple()
	local var_23_1 = self.stageData:GetActivityID()
	local var_23_2 = ActivityData:GetActivityData(var_23_1)

	if var_23_1 ~= 0 and (not var_23_2 or not var_23_2:IsActivitying()) or not self:NeedAddExp() then
		var_23_0 = 0
	end

	local var_23_3 = math.min(var_23_0, LvTools.GetMaxTotalExp("user_level_exp") - self.params_.battleResult.oldPlayerEXPInfo.total_exp)

	if var_23_3 < 0 then
		var_23_3 = 0
	end

	local var_23_4, var_23_5 = LvTools.CheckExp(self.params_.battleResult.oldPlayerEXPInfo.userLevel, self.params_.battleResult.oldPlayerEXPInfo.remain_exp + var_23_3, "user_level_exp")

	if self.params_.battleResult.oldPlayerEXPInfo.userLevel > 30 and var_23_4 - self.params_.battleResult.oldPlayerEXPInfo.userLevel > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(self.params_.battleResult.oldPlayerEXPInfo.remain_exp), tostring(var_23_3), tostring(self.params_.battleResult.oldPlayerEXPInfo.userLevel), tostring(var_23_4)))
	end

	self.newPlayerExp_ = var_23_3
	self.addExp_.text = string.format("+%d", var_23_3)

	local var_23_6 = math.floor(self.params_.battleResult.oldPlayerEXPInfo.remain_exp / GameLevelSetting[self.params_.battleResult.oldPlayerEXPInfo.userLevel].user_level_exp * 1000) / 1000
	local var_23_7 = math.floor(var_23_5 / GameLevelSetting[var_23_4].user_level_exp * 1000) / 1000

	var_23_6 = var_23_6 > 0.99 and 0.99 or var_23_6
	var_23_7 = var_23_7 > 0.99 and 0.99 or var_23_7

	self:RemoveTween()

	self.userExp_ = var_23_4 + var_23_7

	if var_23_0 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	local var_23_8 = -1

	self.tween_ = LeanTween.value(self.progress_.gameObject, self.params_.battleResult.oldPlayerEXPInfo.userLevel + var_23_6, var_23_4 + var_23_7, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
		local var_24_0 = math.modf(arg_24_0)

		if var_23_8 == -1 then
			var_23_8 = var_24_0
		end

		if var_24_0 ~= var_23_8 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			var_23_8 = var_24_0
		end

		self:UpdateUserData(arg_24_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		self:CheckLevelUp()

		self.mask_.blocksRaycasts = false

		self:RemoveTween()
	end))
end

function BattleResultBaseView:UpdateUserData(arg_26_1)
	local var_26_0, var_26_1 = math.modf(arg_26_1)

	self.playerLv_.text = string.format("%d", var_26_0)
	self.progress_.value = LvTools.GetIsMaxLv(var_26_0, "user") and 1 or var_26_1
end

function BattleResultBaseView:UpdateHeroData(arg_27_1, arg_27_2)
	local var_27_0, var_27_1 = math.modf(arg_27_2)

	self.heroLv_[arg_27_1].text = string.format("%d", var_27_0)
	self.heroProgress_[arg_27_1].value = LvTools.GetIsMaxLv(var_27_0, "hero") and 1 or var_27_1
end

function BattleResultBaseView:EndAnimator()
	self:RemoveTween()
	self:RemoveTweens()
	manager.audio:StopEffect()

	if self.stageData:GetAddUserExp() > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add_skip", "")
	end

	self:UpdateUserData(self.userExp_)
	self:CheckLevelUp()

	for iter_28_0, iter_28_1 in ipairs(self.heroExp_) do
		self:UpdateHeroData(iter_28_0, iter_28_1)
	end

	self.mask_.blocksRaycasts = false
end

function BattleResultBaseView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

function BattleResultBaseView:RemoveTweenAt(arg_30_1)
	if self.tweens_[arg_30_1] then
		self.tweens_[arg_30_1]:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tweens_[arg_30_1].id)
	end
end

function BattleResultBaseView:RemoveTweens()
	if self.tweens_ then
		for iter_31_0, iter_31_1 in pairs(self.tweens_) do
			self:RemoveTweenAt(iter_31_0)
		end

		self.tweens_ = nil
	end
end

function BattleResultBaseView:RefreshMissionS()
	SetActive(self.missionTipGo_, true)

	local var_32_0 = self.params_.starMissionData
	local var_32_1 = {}

	for iter_32_0 = 1, 3 do
		if var_32_0 ~= nil and var_32_0[iter_32_0] ~= nil then
			SetActive(self.noInfoGos_[iter_32_0], false)
			SetActive(self.missionGo_[iter_32_0], true)

			self.missionText_[iter_32_0].text = GetI18NText(BattleInstance.GetStarMissionText(var_32_0[iter_32_0].id, var_32_0[iter_32_0].xData, var_32_0[iter_32_0].yData))

			local var_32_3

			if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == self.stageType then
				var_32_3 = BattleStageData:GetStageData()[self.stageId]
			elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == self.stageType then
				var_32_3 = BattleBossChallengeNormalData:GetStarList(self.stageId)
			end

			local var_32_4 = var_32_0[iter_32_0].isComplete or not not (var_32_3 and var_32_3.stars and var_32_3.stars[iter_32_0] == 1)

			SetActive(self.missionNoAchieve_[iter_32_0], not var_32_4)
			SetActive(self.missionAchieve_[iter_32_0], var_32_4)

			self.missionText_[iter_32_0].color = var_32_4 and Color.New(0.9102, 0.9351, 0.9408, 1) or Color.New(0.6768, 0.6853, 0.6882, 1)
			var_32_1[iter_32_0] = var_32_4 and 1 or 0
		else
			SetActive(self.missionGo_[iter_32_0], false)
			SetActive(self.noInfoGos_[iter_32_0], true)
		end
	end

	BattleInstance.RecordThreeStar(self.stageType, self.stageId, var_32_1)
end

function BattleResultBaseView:RefreshCommonUI()
	SetActive(self.btnBattleCount_.gameObject, BattleStageTools.GetStageCfg(self.stageType, self.stageId).tag ~= BattleConst.BATTLE_TAG.STORY)
	self:RefreshBottomBtn()
end

function BattleResultBaseView:RefreshBottomBtn()
	local var_34_0, var_34_1 = self:NeedOnceMore()

	self.onceMoreLab_.text = var_34_1 and GetI18NText(var_34_1) or GetTips("CHALLENGE_ONCE_MORE")

	SetActive(self.onceMoreGo_, var_34_0)
	SetActive(self.closeBtnGo_, var_34_0)
	SetActive(self.closePanel_, not var_34_0)
end

function BattleResultBaseView:RefreshBattleTime()
	local var_35_0 = BattleStageTools.GetStageCfg(self.stageType, self.stageId)

	SetActive(self.battleTimeGo_, var_35_0.tag ~= BattleConst.BATTLE_TAG.STORY)

	if var_35_0.tag == BattleConst.BATTLE_TAG.STORY then
		return
	end

	self.battleTimeText_.text = self:GetBattleTime()
end

function BattleResultBaseView:RefreshTitleImmediate()
	if self.gameObject_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.titleTransform_)
	end
end

function BattleResultBaseView:OnWinStoryEnd()
	self:RefreshTitleImmediate()
end

function BattleResultBaseView:GetBattleTime()
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function BattleResultBaseView:CheckLevelUp()
	local var_39_0 = self:GetLevelUpInfoList()

	if #var_39_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_39_0
		})
	end
end

function BattleResultBaseView:GetLevelUpInfoList()
	return PlayerData:GetlevelUpInfos()
end

function BattleResultBaseView:NeedAddExp()
	return true
end

function BattleResultBaseView:GetRewardData()
	local var_42_0 = {}

	for iter_42_0, iter_42_1 in ipairs(self.params_.rewardList) do
		table.insert(var_42_0, iter_42_1)
	end

	return var_42_0
end

function BattleResultBaseView:CaculateReward()
	self.rewardHeroExp_ = 0

	local var_43_0 = 0

	if self.params_.rewardList then
		for iter_43_0, iter_43_1 in ipairs(self.params_.rewardList) do
			if ItemCfg[iter_43_1[1]].type == ItemConst.ITEM_TYPE.CURRENCY and iter_43_1[1] == CurrencyConst.CURRENCY_TYPE_HERO_EXP then
				var_43_0 = iter_43_0
			end
		end
	end

	if var_43_0 ~= 0 then
		self.rewardHeroExp_ = self.params_.rewardList[var_43_0][2]

		table.remove(self.params_.rewardList, var_43_0)
	end
end

function BattleResultBaseView:OnTop()
	SetActive(self.gameObject_, true)

	self.toStat_ = false
end

function BattleResultBaseView:OnBehind()
	if self.toStat_ then
		SetActive(self.gameObject_, false)
	end
end

function BattleResultBaseView:GoToBattleStatistics()
	self.toStat_ = true

	JumpTools.OpenPageByJump("battleStatistics", {
		stageData = self.params_.stageData,
		battleTime = self:GetBattleTime()
	})
end

function BattleResultBaseView:ShowVitalityBox(arg_47_1)
	if needShowVitalityFullBox() then
		showVitalitySendMail(arg_47_1)
	else
		arg_47_1()
	end
end

function BattleResultBaseView:ShowEquipBox(arg_48_1)
	if needShowBagFullBox() then
		showEquipSendMail(arg_48_1)
	else
		arg_48_1()
	end
end

function BattleResultBaseView:CloseFunc()
	OperationRecorder.Record(self.class.__cname, "closeCombat")
	self:ShowVitalityBox(function()
		self:ShowEquipBox(function()
			BattleInstance.QuitBattle(self.params_.stageData)
		end)
	end)
end

function BattleResultBaseView:NeedOnceMore()
	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == self.params_.stageData:GetType() then
		local var_52_0 = self.params_.stageData:GetStageId()
		local var_52_1 = ChapterCfg[getChapterIDByStageID(var_52_0)].section_id_list

		if var_52_1[(table.indexof(var_52_1, var_52_0) or 0) + 1] ~= nil then
			return true, GetTips("CHALLENGE_NEXT_LEVEL")
		end
	end

	return false
end

function BattleResultBaseView:CheckBattleError()
	if self.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				self:CloseFunc()
			end
		})
	end
end

return BattleResultBaseView

local NewBattleSettlementView = class("NewBattleSettlementView", ReduxView)

function NewBattleSettlementView:UIName()
	return "Widget/System/BattleResult/Common/BattleResultWinUI"
end

function NewBattleSettlementView:UIParent()
	return manager.ui.uiMain.transform
end

function NewBattleSettlementView:Init()
	self.hasSnapshot_ = GetBattleResultSnapShot()

	self:InitUI()

	self.btnController = self.btnController_:GetController("btn")
	self.adaptComp = self:FindCom("AdaptImage", nil, self.commonMaskBg_.transform)

	self:AddListener()
end

function NewBattleSettlementView:OnEnter()
	self.stageData = self.params_.stageData
	self.stageId = self.stageData:GetStageId()
	self.stageType = self.stageData:GetType()
	self.isMultiple = self.params_.multiple ~= nil

	BattleInstance.hideBattlePanel()
	self:RenderMaskBg()
	self:CaculateReward()
	self:RenderView()
	self:PostRenderView()
end

function NewBattleSettlementView:OnExit()
	return
end

function NewBattleSettlementView:Dispose()
	self:RemoveExpTween()

	for iter_6_0 = 1, 3 do
		self.heroModule[iter_6_0]:Dispose()
	end

	if self.missionView then
		self.missionView:Dispose()
	end

	self.spriteRef = nil

	NewBattleSettlementView.super.Dispose(self)
end

function NewBattleSettlementView:InitUI()
	self:BindCfgUI()

	self.heroModule = {
		BattleSettlementHeroHeadModule.New(self.heroHead1Obj_),
		BattleSettlementHeroHeadModule.New(self.heroHead2Obj_),
		(BattleSettlementHeroHeadModule.New(self.heroHead3Obj_))
	}
end

function NewBattleSettlementView:AddListener()
	self:AddBtnListener(self.confirmBtn_, nil, function()
		self:CloseFunc()
	end)
	self:AddBtnListener(self.statisticsBtn_, nil, function()
		self:GoToBattleStatistics()
	end)
	self:OnAddListner()
end

local function var_0_1(arg_11_0, arg_11_1)
	if arg_11_0 and not isNil(arg_11_0) then
		SetActive(arg_11_0.gameObject, arg_11_1)
	end
end

function NewBattleSettlementView:OnAddListner()
	self:AddBtnListener(self.nextStageBtn_, nil, function()
		self:OnceMoreFunc()
	end)
end

function NewBattleSettlementView:RenderView()
	self:RenderTitleView()
	self:RefreshMyExpS()
	self:RefreshHeroS()
	self:RenderCommonUI()
	self:RefreshBattleTime()
	self:RefreshBottomBtn()
	self:ShowContent()
end

function NewBattleSettlementView:RenderTitleView()
	local var_15_0, var_15_1 = BattleStageTools.GetChapterSectionIndex(self.stageType, self.stageId)
	local var_15_2 = GetI18NText(BattleStageTools.GetStageName(self.stageType, self.stageId)) or ""
	local var_15_3 = ""

	var_15_3 = var_15_0 ~= "" and "" .. var_15_2 or "" .. var_15_2

	if var_15_3 and var_15_3 ~= "" then
		SetActive(self.titleObj_, true)

		self.titleTxt_.text = var_15_3
	else
		SetActive(self.titleObj_, false)
	end
end

function NewBattleSettlementView:RenderCommonUI()
	SetActive(self.statisticsBtn_.gameObject, BattleStageTools.GetStageCfg(self.stageType, self.stageId).tag ~= BattleConst.BATTLE_TAG.STORY)
end

function NewBattleSettlementView:RefreshBattleTime()
	local var_17_0 = BattleStageTools.GetStageCfg(self.stageType, self.stageId)

	SetActive(self.battleTimeText_.gameObject, var_17_0.tag ~= BattleConst.BATTLE_TAG.STORY)

	if var_17_0.tag == BattleConst.BATTLE_TAG.STORY then
		return
	end

	local var_17_1 = self.battleTimeText_
	local var_17_2 = {
		GetTips("BATTLE_TOTAL_TIME"),
		": "
	}

	var_17_2[3] = self:GetBattleTime() or "00"
	var_17_1.text = table.concat(var_17_2)
end

function NewBattleSettlementView:RefreshHeroS()
	local var_18_0, var_18_1 = self.stageData:GetHeroTeam()
	local var_18_2 = self.stageData:GetSystemHeroTeam()

	if var_18_0[2] == 0 then
		table.remove(var_18_0, 2)
		table.remove(var_18_1, 2)
		table.insert(var_18_0, 0)
		table.insert(var_18_1, 0)
	end

	local var_18_3 = self.params_.battleResult.heroDataCollect

	for iter_18_0 = 1, 3 do
		if not var_18_0[iter_18_0] or var_18_0[iter_18_0] == 0 then
			self.heroModule[iter_18_0]:SetHeroData(nil)
			self.heroModule[iter_18_0]:ShowCaptain(false)
		else
			self.heroModule[iter_18_0]:ShowCaptain(iter_18_0 == 1)

			local var_18_4 = self.stageData:GetHeroDataByPos(iter_18_0)
			local var_18_5 = {
				id = var_18_4.id,
				using_skin = var_18_4.using_skin
			}

			var_18_5.star = var_18_4.star or 0

			self.heroModule[iter_18_0]:SetHeroData(var_18_5)

			if var_18_3[iter_18_0] and self:NeedAddExp() then
				self.heroModule[iter_18_0]:PlayLevelUpTween(var_18_3[iter_18_0].oldLv, var_18_3[iter_18_0].newLv, var_18_3[iter_18_0].oldPersent, var_18_3[iter_18_0].newPersent, 2)
			else
				self.heroModule[iter_18_0]:ShowLevel(var_18_4.level, 1)
			end
		end
	end
end

function NewBattleSettlementView:RefreshMyExpS()
	local var_19_0 = self.stageData:GetAddUserExp() * self.stageData:GetMultiple()
	local var_19_1 = self.stageData:GetActivityID()
	local var_19_2 = self.params_.battleResult.oldPlayerEXPInfo.userLevel
	local var_19_3 = self.params_.battleResult.oldPlayerEXPInfo.remain_exp
	local var_19_4 = ActivityData:GetActivityData(var_19_1)

	if var_19_1 ~= 0 and (not var_19_4 or not var_19_4:IsActivitying()) or not self:NeedAddExp() then
		var_19_0 = 0
	end

	local var_19_5 = math.min(var_19_0, LvTools.GetMaxTotalExp("user_level_exp") - self.params_.battleResult.oldPlayerEXPInfo.total_exp)

	if var_19_5 < 0 then
		var_19_5 = 0
	end

	local var_19_6, var_19_7 = LvTools.CheckExp(var_19_2, var_19_3 + var_19_5, "user_level_exp")

	if var_19_2 > 30 and var_19_6 - var_19_2 > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(var_19_3), tostring(var_19_5), tostring(var_19_2), tostring(var_19_6)))
	end

	self.expTxt_.text = string.format("EXP+%d", var_19_5)
	self.lvNumTxt_.text = LvTools.GetIsMaxLv(var_19_6, "user") and "--/--" or table.concat({
		var_19_7,
		"/",
		GameLevelSetting[var_19_6].user_level_exp
	})

	local var_19_8 = math.floor(var_19_3 / GameLevelSetting[var_19_2].user_level_exp * 1000) / 1000
	local var_19_9 = math.floor(var_19_7 / GameLevelSetting[var_19_6].user_level_exp * 1000) / 1000

	var_19_8 = var_19_8 > 0.99 and 0.99 or var_19_8
	var_19_9 = var_19_9 > 0.99 and 0.99 or var_19_9

	if var_19_0 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	if var_19_2 == var_19_6 and math.abs(var_19_8 - var_19_9) < 0.0001 then
		var_0_1(self.maskBtn_, false)
		self:SetExpWithoutTween(var_19_6, var_19_9)
	else
		self:StartExpTween(var_19_2, var_19_6, var_19_8, var_19_9)
	end
end

function NewBattleSettlementView:RenderUserData(arg_20_1)
	local var_20_0, var_20_1 = math.modf(arg_20_1)

	self.levelTxt_.text = string.format("%d", var_20_0)
	self.expSlider_.value = LvTools.GetIsMaxLv(var_20_0, "user") and 1 or var_20_1
end

function NewBattleSettlementView:RefreshBottomBtn()
	local var_21_0, var_21_1 = self:NeedOnceMore()

	self.confirmBtnTxt_.text = var_21_1 and GetI18NText(var_21_1) or GetTips("CHALLENGE_ONCE_MORE")

	SetActive(self.nextStageBtn_.gameObject, var_21_0)

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == self.params_.stageData:GetType() then
		SetActive(self.costImage_.gameObject, false)
	end
end

function NewBattleSettlementView:RenderMaskBg()
	if not self.hasSnapshot_ then
		self.commonMaskBg_.sprite = pureGetSpriteWithoutAtlas("TextureBg/BattleResult/battleResult_bg_common")

		self.adaptComp:AdaptImg()
		SetActive(self.commonMaskBg_.gameObject, true)
		SetActive(self.maskBg_.gameObject, false)
	else
		self.maskBg_.texture = self.hasSnapshot_

		SetActive(self.commonMaskBg_.gameObject, false)
		SetActive(self.maskBg_.gameObject, true)
	end
end

function NewBattleSettlementView:RemoveExpTween()
	if self.expTween_ then
		self.expTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.gameObject_)

		self.expTween_ = nil
	end
end

function NewBattleSettlementView:StartExpTween(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	self:RemoveExpTween()
	var_0_1(self.maskBtn_, true)

	local var_24_0 = -1

	self.tween_ = LeanTween.value(self.expSlider_.gameObject, arg_24_1 + arg_24_3, arg_24_2 + arg_24_4, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
		local var_25_0 = math.modf(arg_25_0)

		if var_24_0 == -1 then
			var_24_0 = var_25_0
		end

		if var_25_0 ~= var_24_0 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			var_24_0 = var_25_0
		end

		self:RenderUserData(arg_25_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		self:CheckLevelUp()
		var_0_1(self.maskBtn_, false)
		self:RemoveExpTween()
	end))
end

function NewBattleSettlementView:SetExpWithoutTween(arg_27_1, arg_27_2)
	self:RenderUserData(arg_27_1 + arg_27_2)
end

function NewBattleSettlementView:ShowContent()
	self:onRenderMissionContent()
end

function NewBattleSettlementView:onRenderMissionContent()
	self.missionView = self.missionView or BattleSettlementMissionModule.New(self.contentContainer_)

	self.missionView:RenderView(self.stageType, self.stageId, self.params_.starMissionData)
	self.missionView:RenderRewards(self.params_.rewardList)
end

function NewBattleSettlementView:GetPlayerInfo()
	return PlayerData:GetPlayerInfo()
end

function NewBattleSettlementView:GetBattleTime()
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function NewBattleSettlementView:CheckLevelUp()
	local var_32_0 = self:GetLevelUpInfoList()

	if #var_32_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_32_0
		})
	end
end

function NewBattleSettlementView:GetLevelUpInfoList()
	return PlayerData:GetlevelUpInfos()
end

function NewBattleSettlementView:NeedAddExp()
	return true
end

function NewBattleSettlementView:GetRewardData()
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs(self.params_.rewardList) do
		table.insert(var_35_0, iter_35_1)
	end

	return var_35_0
end

function NewBattleSettlementView:CheckIsMultipleReward()
	if not self.params_.rewardList then
		return false
	end

	if #self.params_.rewardList == 0 then
		return false
	end

	if self.params_.rewardList[1] and self.params_.rewardList[1].id then
		return false
	end

	return true
end

function NewBattleSettlementView:CaculateReward()
	if self.isMultiple or self:CheckIsMultipleReward() then
		return
	end

	self.rewardHeroExp_ = 0

	local var_37_0 = 0

	if self.params_.rewardList then
		for iter_37_0, iter_37_1 in ipairs(self.params_.rewardList) do
			if ItemCfg[iter_37_1[1]].type == ItemConst.ITEM_TYPE.CURRENCY and iter_37_1[1] == CurrencyConst.CURRENCY_TYPE_HERO_EXP then
				var_37_0 = iter_37_0
			end
		end
	end

	if var_37_0 ~= 0 then
		self.rewardHeroExp_ = self.params_.rewardList[var_37_0][2]

		table.remove(self.params_.rewardList, var_37_0)
	end
end

function NewBattleSettlementView:OnTop()
	SetActive(self.gameObject_, true)

	self.toStat_ = false
end

function NewBattleSettlementView:OnBehind()
	if self.toStat_ then
		SetActive(self.gameObject_, false)
	end
end

function NewBattleSettlementView:GoToBattleStatistics()
	self.toStat_ = true

	JumpTools.OpenPageByJump("battleStatistics", {
		stageData = self.params_.stageData,
		battleTime = self:GetBattleTime(),
		hasSnapshot_ = self.hasSnapshot_
	})
end

function NewBattleSettlementView:ShowVitalityBox(arg_41_1)
	if needShowVitalityFullBox() then
		showVitalitySendMail(arg_41_1)
	else
		arg_41_1()
	end
end

function NewBattleSettlementView:ShowEquipBox(arg_42_1)
	if needShowBagFullBox() then
		showEquipSendMail(arg_42_1)
	else
		arg_42_1()
	end
end

function NewBattleSettlementView:CloseFunc()
	OperationRecorder.Record(self.class.__cname, "closeCombat")
	self:ShowVitalityBox(function()
		self:ShowEquipBox(function()
			BattleInstance.QuitBattle(self.params_.stageData)
		end)
	end)
end

function NewBattleSettlementView:NeedOnceMore()
	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == self.params_.stageData:GetType() then
		local var_46_0 = self.params_.stageData:GetStageId()
		local var_46_1 = ChapterCfg[getChapterIDByStageID(var_46_0)].section_id_list

		if var_46_1[(table.indexof(var_46_1, var_46_0) or 0) + 1] ~= nil then
			return true, GetTips("CHALLENGE_NEXT_LEVEL")
		end
	end

	return false
end

function NewBattleSettlementView:PostRenderView()
	if self.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				self:CloseFunc()
			end
		})
	elseif self.params_.battleResult.errorCode == BattleConst.ERROR_CODE_ACTIVITY_REFRESH then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_REFRESH_TIPS"),
			OkCallback = function()
				self:CloseFunc()
			end
		})
	end
end

function NewBattleSettlementView:OnceMoreFunc()
	local var_50_2 = self.stageData:GetCost()
	local var_50_3 = self.stageData:GetMultiple()
	local var_50_4 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
	local var_50_5 = CurrencyConst.CURRENCY_TYPE_VITALITY

	if self.stageType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE then
		local var_50_6 = ActivityPt2Cfg[self.stageData:GetDest()]

		var_50_2 = var_50_6.cost[1][2]
		var_50_5 = var_50_6.cost[1][1]
		var_50_4 = ItemTools.getItemNum(var_50_6.cost[1][1])
	elseif self.stageType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL then
		local var_50_7 = ActivityPtRouletteStageCfg[self.stageData:GetDest()]

		var_50_2 = var_50_7.cost[2]
		var_50_5 = var_50_7.cost[1]
		var_50_4 = ItemTools.getItemNum(var_50_7.cost[1])
	end

	if var_50_4 < var_50_2 * var_50_3 then
		if var_50_5 ~= CurrencyConst.CURRENCY_TYPE_VITALITY then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(var_50_5)))
		elseif CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
			JumpTools.OpenPopUp("currencyBuyFatigue", {}, ViewConst.SYSTEM_ID.BUY_FATIGUE)
		else
			ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
		end
	else
		BattleInstance.OnceMoreBattle(self.stageData)
		LuaForCursor.SwitchCursor(false)
	end
end

return NewBattleSettlementView

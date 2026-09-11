local CoreVerificationDoubleChallengeResultViewMode3 = class("CoreVerificationDoubleChallengeResultViewMode3", ReduxView)

function CoreVerificationDoubleChallengeResultViewMode3:UIName()
	return "Widget/System/Core_verification_new/Mode3/Core_verification_ResultUI03"
end

function CoreVerificationDoubleChallengeResultViewMode3:UIParent()
	return manager.ui.uiMain.transform
end

function CoreVerificationDoubleChallengeResultViewMode3:Init()
	self:InitUI()
	self:AddListener()
end

function CoreVerificationDoubleChallengeResultViewMode3:OnEnter()
	self.stageData = self.params_.stageData
	self.stageId = self.stageData:GetStageId()
	self.stageType = self.stageData:GetType()
	self.isMultiple = self.params_.multiple ~= nil

	BattleInstance.hideBattlePanel()
	self:RenderView()
end

function CoreVerificationDoubleChallengeResultViewMode3:OnExit()
	CoreVerificationDoubleChallengeResultViewMode3.super.OnExit(self)
end

function CoreVerificationDoubleChallengeResultViewMode3:Dispose()
	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()

		self.scrollHelper_ = nil
	end

	self:RemoveExpTween()

	for iter_6_0 = 1, 3 do
		self.heroModule[iter_6_0]:Dispose()
	end

	CoreVerificationDoubleChallengeResultViewMode3.super.Dispose(self)
end

function CoreVerificationDoubleChallengeResultViewMode3:InitUI()
	self:BindCfgUI()

	self.heroModule = {
		BattleSettlementHeroHeadModule.New(self.heroHead1Obj_),
		BattleSettlementHeroHeadModule.New(self.heroHead2Obj_),
		(BattleSettlementHeroHeadModule.New(self.heroHead3Obj_))
	}
end

function CoreVerificationDoubleChallengeResultViewMode3:AddListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:CloseFunc()
	end)
	self:AddBtnListener(self.statisticsBtn_, nil, function()
		self:GoToBattleStatistics()
	end)
end

function CoreVerificationDoubleChallengeResultViewMode3:RenderView()
	self:RefreshMyExpS()
	self:RefreshHeroS()
	self:RenderCommonUI()
	self:RefreshBattleTime()
	self:RefreshChallegeUI()
end

function CoreVerificationDoubleChallengeResultViewMode3:RefreshChallegeUI()
	self.playerNameText_.text = self.params_.stageData.serverTeamPlayer.nick

	local var_12_0 = CoreVerificationChallengeMode3Data:GetChallengeStage().recently_challenge_value

	if not CoreVerificationChallengeMode3Data:GetChallengeStage().recently_challenge_value then
		self.curScoreText_.text = 0
	end

	self.scoreText_.text = CoreVerificationChallengeMode3Data:GetMaxPoint()
	self.stageNameText_.text = GetI18NText(CoreVerificationClMode3Cfg[self.stageId].stage_name)
	self.affixIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/Core_verification_new/Emblem/", (CoreVerificationChallengeTools.GetMaxIllustrated())))
end

function CoreVerificationDoubleChallengeResultViewMode3:RenderCommonUI()
	SetActive(self.statisticsBtn_.gameObject, BattleStageTools.GetStageCfg(self.stageType, self.stageId).tag ~= BattleConst.BATTLE_TAG.STORY)
end

function CoreVerificationDoubleChallengeResultViewMode3:RefreshBattleTime()
	local var_14_0 = BattleStageTools.GetStageCfg(self.stageType, self.stageId)

	SetActive(self.battleTimeText_.gameObject, var_14_0.tag ~= BattleConst.BATTLE_TAG.STORY)

	if var_14_0.tag == BattleConst.BATTLE_TAG.STORY then
		return
	end

	local var_14_1 = self.battleTimeText_
	local var_14_2 = {
		GetTips("BATTLE_TOTAL_TIME"),
		": "
	}

	var_14_2[3] = self:GetBattleTime() or "00"
	var_14_1.text = table.concat(var_14_2)
end

function CoreVerificationDoubleChallengeResultViewMode3:RefreshHeroS()
	local var_15_0, var_15_1 = self.stageData:GetHeroTeam()
	local var_15_2 = self.stageData:GetSystemHeroTeam()

	if var_15_0[2] == 0 then
		table.remove(var_15_0, 2)
		table.remove(var_15_1, 2)
		table.insert(var_15_0, 0)
		table.insert(var_15_1, 0)
	end

	local var_15_3 = self.params_.battleResult.heroDataCollect

	for iter_15_0 = 1, 3 do
		if not var_15_0[iter_15_0] or var_15_0[iter_15_0] == 0 then
			self.heroModule[iter_15_0]:SetHeroData(nil)
			self.heroModule[iter_15_0]:ShowCaptain(false)
		else
			self.heroModule[iter_15_0]:ShowCaptain(iter_15_0 == 1)

			local var_15_4 = self.stageData:GetHeroDataByPos(iter_15_0)
			local var_15_5 = {
				id = var_15_4.id,
				using_skin = var_15_4.using_skin
			}

			var_15_5.star = var_15_4.star or 0

			self.heroModule[iter_15_0]:SetHeroData(var_15_5)

			if var_15_3[iter_15_0] and self:NeedAddExp() then
				self.heroModule[iter_15_0]:PlayLevelUpTween(var_15_3[iter_15_0].oldLv, var_15_3[iter_15_0].newLv, var_15_3[iter_15_0].oldPersent, var_15_3[iter_15_0].newPersent, 2)
			else
				self.heroModule[iter_15_0]:ShowLevel(var_15_4.level, 1)
			end
		end
	end
end

function CoreVerificationDoubleChallengeResultViewMode3:RefreshMyExpS()
	local var_16_0 = self.stageData:GetAddUserExp() * self.stageData:GetMultiple()
	local var_16_1 = self.stageData:GetActivityID()
	local var_16_2 = self.params_.battleResult.oldPlayerEXPInfo.userLevel
	local var_16_3 = self.params_.battleResult.oldPlayerEXPInfo.remain_exp
	local var_16_4 = ActivityData:GetActivityData(var_16_1)

	if var_16_1 ~= 0 and (not var_16_4 or not var_16_4:IsActivitying()) or not self:NeedAddExp() then
		var_16_0 = 0
	end

	local var_16_5 = math.min(var_16_0, LvTools.GetMaxTotalExp("user_level_exp") - self.params_.battleResult.oldPlayerEXPInfo.total_exp)

	if var_16_5 < 0 then
		var_16_5 = 0
	end

	local var_16_6, var_16_7 = LvTools.CheckExp(var_16_2, var_16_3 + var_16_5, "user_level_exp")

	if var_16_2 > 30 and var_16_6 - var_16_2 > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(var_16_3), tostring(var_16_5), tostring(var_16_2), tostring(var_16_6)))
	end

	self.expTxt_.text = string.format("EXP+%d", var_16_5)
	self.lvNumTxt_.text = LvTools.GetIsMaxLv(var_16_6, "user") and "--/--" or table.concat({
		var_16_7,
		"/",
		GameLevelSetting[var_16_6].user_level_exp
	})

	local var_16_8 = math.floor(var_16_3 / GameLevelSetting[var_16_2].user_level_exp * 1000) / 1000
	local var_16_9 = math.floor(var_16_7 / GameLevelSetting[var_16_6].user_level_exp * 1000) / 1000

	var_16_8 = var_16_8 > 0.99 and 0.99 or var_16_8
	var_16_9 = var_16_9 > 0.99 and 0.99 or var_16_9

	if var_16_0 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	if var_16_2 == var_16_6 and math.abs(var_16_8 - var_16_9) < 0.0001 then
		self:SetExpWithoutTween(var_16_6, var_16_9)
	else
		self:StartExpTween(var_16_2, var_16_6, var_16_8, var_16_9)
	end
end

function CoreVerificationDoubleChallengeResultViewMode3:RenderUserData(arg_17_1)
	local var_17_0, var_17_1 = math.modf(arg_17_1)

	self.levelTxt_.text = string.format("%d", var_17_0)
	self.expSlider_.value = LvTools.GetIsMaxLv(var_17_0, "user") and 1 or var_17_1
end

function CoreVerificationDoubleChallengeResultViewMode3:RemoveExpTween()
	if self.expTween_ then
		self.expTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.gameObject_)

		self.expTween_ = nil
	end
end

function CoreVerificationDoubleChallengeResultViewMode3:StartExpTween(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	self:RemoveExpTween()

	local var_19_0 = -1

	self.tween_ = LeanTween.value(self.expSlider_.gameObject, arg_19_1 + arg_19_3, arg_19_2 + arg_19_4, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
		local var_20_0 = math.modf(arg_20_0)

		if var_19_0 == -1 then
			var_19_0 = var_20_0
		end

		if var_20_0 ~= var_19_0 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			var_19_0 = var_20_0
		end

		self:RenderUserData(arg_20_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		self:CheckLevelUp()
		self:RemoveExpTween()
	end))
end

function CoreVerificationDoubleChallengeResultViewMode3:SetExpWithoutTween(arg_22_1, arg_22_2)
	self:RenderUserData(arg_22_1 + arg_22_2)
end

function CoreVerificationDoubleChallengeResultViewMode3:GetPlayerInfo()
	return PlayerData:GetPlayerInfo()
end

function CoreVerificationDoubleChallengeResultViewMode3:GetBattleTime()
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function CoreVerificationDoubleChallengeResultViewMode3:CheckLevelUp()
	local var_25_0 = self:GetLevelUpInfoList()

	if #var_25_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_25_0
		})
	end
end

function CoreVerificationDoubleChallengeResultViewMode3:GetLevelUpInfoList()
	return PlayerData:GetlevelUpInfos()
end

function CoreVerificationDoubleChallengeResultViewMode3:NeedAddExp()
	return true
end

function CoreVerificationDoubleChallengeResultViewMode3:GetRewardData()
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(self.params_.rewardList) do
		table.insert(var_28_0, iter_28_1)
	end

	return var_28_0
end

function CoreVerificationDoubleChallengeResultViewMode3:OnTop()
	SetActive(self.gameObject_, true)

	self.toStat_ = false
end

function CoreVerificationDoubleChallengeResultViewMode3:OnBehind()
	if self.toStat_ then
		SetActive(self.gameObject_, false)
	end
end

function CoreVerificationDoubleChallengeResultViewMode3:GoToBattleStatistics()
	self.toStat_ = true

	JumpTools.OpenPageByJump("battleStatistics", {
		stageData = self.params_.stageData,
		battleTime = self:GetBattleTime(),
		hasSnapshot_ = self.hasSnapshot_
	})
end

function CoreVerificationDoubleChallengeResultViewMode3:ShowVitalityBox(arg_32_1)
	if needShowVitalityFullBox() then
		showVitalitySendMail(arg_32_1)
	else
		arg_32_1()
	end
end

function CoreVerificationDoubleChallengeResultViewMode3:ShowEquipBox(arg_33_1)
	if needShowBagFullBox() then
		showEquipSendMail(arg_33_1)
	else
		arg_33_1()
	end
end

function CoreVerificationDoubleChallengeResultViewMode3:CloseFunc()
	OperationRecorder.Record(self.class.__cname, "closeCombat")
	self:ShowVitalityBox(function()
		self:ShowEquipBox(function()
			BattleInstance.QuitBattle(self.params_.stageData)
		end)
	end)
end

return CoreVerificationDoubleChallengeResultViewMode3

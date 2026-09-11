local CoreVerificationDoubleChallengeResultView = class("CoreVerificationDoubleChallengeResultView", ReduxView)

function CoreVerificationDoubleChallengeResultView:UIName()
	return "Widget/System/Core_verification_new/Core_verification_ResultUI"
end

function CoreVerificationDoubleChallengeResultView:UIParent()
	return manager.ui.uiMain.transform
end

function CoreVerificationDoubleChallengeResultView:Init()
	self:InitUI()
	self:AddListener()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.uiList_, CoreVerificationChallengeAffixItemItem)
end

function CoreVerificationDoubleChallengeResultView:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:RefreshUI(self.buff_list[arg_4_1])
end

function CoreVerificationDoubleChallengeResultView:OnEnter()
	self.stageData = self.params_.stageData
	self.stageId = self.stageData:GetStageId()
	self.stageType = self.stageData:GetType()
	self.isMultiple = self.params_.multiple ~= nil

	BattleInstance.hideBattlePanel()
	self:RenderView()
end

function CoreVerificationDoubleChallengeResultView:OnExit()
	CoreVerificationDoubleChallengeResultView.super.OnExit(self)
end

function CoreVerificationDoubleChallengeResultView:Dispose()
	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()

		self.scrollHelper_ = nil
	end

	self:RemoveExpTween()

	for iter_7_0 = 1, 3 do
		self.heroModule[iter_7_0]:Dispose()
	end

	CoreVerificationDoubleChallengeResultView.super.Dispose(self)
end

function CoreVerificationDoubleChallengeResultView:InitUI()
	self:BindCfgUI()

	self.heroModule = {
		BattleSettlementHeroHeadModule.New(self.heroHead1Obj_),
		BattleSettlementHeroHeadModule.New(self.heroHead2Obj_),
		(BattleSettlementHeroHeadModule.New(self.heroHead3Obj_))
	}
end

function CoreVerificationDoubleChallengeResultView:AddListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:CloseFunc()
	end)
	self:AddBtnListener(self.statisticsBtn_, nil, function()
		self:GoToBattleStatistics()
	end)
end

function CoreVerificationDoubleChallengeResultView:RenderView()
	self:RefreshMyExpS()
	self:RefreshHeroS()
	self:RenderCommonUI()
	self:RefreshBattleTime()
	self:RefreshChallegeUI()
end

function CoreVerificationDoubleChallengeResultView:IndexItem(arg_13_1, arg_13_2)
	arg_13_2:RefreshUI(self.buff_list[arg_13_1])
end

function CoreVerificationDoubleChallengeResultView:RefreshChallegeUI()
	local var_14_0 = CoreVerificationChallengeData:GetChallengeStage()

	self.buff_list = CoreVerificationChallengeData:GetSelectAffixs()
	self.playerNameText_.text = self.params_.stageData.serverTeamPlayer.nick
	self.curScoreText_.text = var_14_0.recently_challenge_value or 0
	self.efficiencyScoreText_.text = CoreVerificationChallengeData:GetEfficiencyNum()
	self.scoreText_.text = var_14_0.max_challenge_value or 0
	self.stageNameText_.text = GetI18NText(CoreVerificationClMode1Cfg[self.stageId].stage_name)

	self.scrollHelper_:StartScroll(#self.buff_list)

	self.affixIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/Core_verification_new/Emblem/", (CoreVerificationChallengeTools.GetMaxIllustrated())))
end

function CoreVerificationDoubleChallengeResultView:RenderCommonUI()
	SetActive(self.statisticsBtn_.gameObject, BattleStageTools.GetStageCfg(self.stageType, self.stageId).tag ~= BattleConst.BATTLE_TAG.STORY)
end

function CoreVerificationDoubleChallengeResultView:RefreshBattleTime()
	local var_16_0 = BattleStageTools.GetStageCfg(self.stageType, self.stageId)

	SetActive(self.battleTimeText_.gameObject, var_16_0.tag ~= BattleConst.BATTLE_TAG.STORY)

	if var_16_0.tag == BattleConst.BATTLE_TAG.STORY then
		return
	end

	local var_16_1 = self.battleTimeText_
	local var_16_2 = {
		GetTips("BATTLE_TOTAL_TIME"),
		": "
	}

	var_16_2[3] = self:GetBattleTime() or "00"
	var_16_1.text = table.concat(var_16_2)
end

function CoreVerificationDoubleChallengeResultView:RefreshHeroS()
	local var_17_0, var_17_1 = self.stageData:GetHeroTeam()
	local var_17_2 = self.stageData:GetSystemHeroTeam()

	if var_17_0[2] == 0 then
		table.remove(var_17_0, 2)
		table.remove(var_17_1, 2)
		table.insert(var_17_0, 0)
		table.insert(var_17_1, 0)
	end

	local var_17_3 = self.params_.battleResult.heroDataCollect

	for iter_17_0 = 1, 3 do
		if not var_17_0[iter_17_0] or var_17_0[iter_17_0] == 0 then
			self.heroModule[iter_17_0]:SetHeroData(nil)
			self.heroModule[iter_17_0]:ShowCaptain(false)
		else
			self.heroModule[iter_17_0]:ShowCaptain(iter_17_0 == 1)

			local var_17_4 = self.stageData:GetHeroDataByPos(iter_17_0)
			local var_17_5 = {
				id = var_17_4.id,
				using_skin = var_17_4.using_skin
			}

			var_17_5.star = var_17_4.star or 0

			self.heroModule[iter_17_0]:SetHeroData(var_17_5)

			if var_17_3[iter_17_0] and self:NeedAddExp() then
				self.heroModule[iter_17_0]:PlayLevelUpTween(var_17_3[iter_17_0].oldLv, var_17_3[iter_17_0].newLv, var_17_3[iter_17_0].oldPersent, var_17_3[iter_17_0].newPersent, 2)
			else
				self.heroModule[iter_17_0]:ShowLevel(var_17_4.level, 1)
			end
		end
	end
end

function CoreVerificationDoubleChallengeResultView:RefreshMyExpS()
	local var_18_0 = self.stageData:GetAddUserExp() * self.stageData:GetMultiple()
	local var_18_1 = self.stageData:GetActivityID()
	local var_18_2 = self.params_.battleResult.oldPlayerEXPInfo.userLevel
	local var_18_3 = self.params_.battleResult.oldPlayerEXPInfo.remain_exp
	local var_18_4 = ActivityData:GetActivityData(var_18_1)

	if var_18_1 ~= 0 and (not var_18_4 or not var_18_4:IsActivitying()) or not self:NeedAddExp() then
		var_18_0 = 0
	end

	local var_18_5 = math.min(var_18_0, LvTools.GetMaxTotalExp("user_level_exp") - self.params_.battleResult.oldPlayerEXPInfo.total_exp)

	if var_18_5 < 0 then
		var_18_5 = 0
	end

	local var_18_6, var_18_7 = LvTools.CheckExp(var_18_2, var_18_3 + var_18_5, "user_level_exp")

	if var_18_2 > 30 and var_18_6 - var_18_2 > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(var_18_3), tostring(var_18_5), tostring(var_18_2), tostring(var_18_6)))
	end

	self.expTxt_.text = string.format("EXP+%d", var_18_5)
	self.lvNumTxt_.text = LvTools.GetIsMaxLv(var_18_6, "user") and "--/--" or table.concat({
		var_18_7,
		"/",
		GameLevelSetting[var_18_6].user_level_exp
	})

	local var_18_8 = math.floor(var_18_3 / GameLevelSetting[var_18_2].user_level_exp * 1000) / 1000
	local var_18_9 = math.floor(var_18_7 / GameLevelSetting[var_18_6].user_level_exp * 1000) / 1000

	var_18_8 = var_18_8 > 0.99 and 0.99 or var_18_8
	var_18_9 = var_18_9 > 0.99 and 0.99 or var_18_9

	if var_18_0 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	if var_18_2 == var_18_6 and math.abs(var_18_8 - var_18_9) < 0.0001 then
		self:SetExpWithoutTween(var_18_6, var_18_9)
	else
		self:StartExpTween(var_18_2, var_18_6, var_18_8, var_18_9)
	end
end

function CoreVerificationDoubleChallengeResultView:RenderUserData(arg_19_1)
	local var_19_0, var_19_1 = math.modf(arg_19_1)

	self.levelTxt_.text = string.format("%d", var_19_0)
	self.expSlider_.value = LvTools.GetIsMaxLv(var_19_0, "user") and 1 or var_19_1
end

function CoreVerificationDoubleChallengeResultView:RemoveExpTween()
	if self.expTween_ then
		self.expTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.gameObject_)

		self.expTween_ = nil
	end
end

function CoreVerificationDoubleChallengeResultView:StartExpTween(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	self:RemoveExpTween()

	local var_21_0 = -1

	self.tween_ = LeanTween.value(self.expSlider_.gameObject, arg_21_1 + arg_21_3, arg_21_2 + arg_21_4, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
		local var_22_0 = math.modf(arg_22_0)

		if var_21_0 == -1 then
			var_21_0 = var_22_0
		end

		if var_22_0 ~= var_21_0 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			var_21_0 = var_22_0
		end

		self:RenderUserData(arg_22_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		self:CheckLevelUp()
		self:RemoveExpTween()
	end))
end

function CoreVerificationDoubleChallengeResultView:SetExpWithoutTween(arg_24_1, arg_24_2)
	self:RenderUserData(arg_24_1 + arg_24_2)
end

function CoreVerificationDoubleChallengeResultView:GetPlayerInfo()
	return PlayerData:GetPlayerInfo()
end

function CoreVerificationDoubleChallengeResultView:GetBattleTime()
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function CoreVerificationDoubleChallengeResultView:CheckLevelUp()
	local var_27_0 = self:GetLevelUpInfoList()

	if #var_27_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_27_0
		})
	end
end

function CoreVerificationDoubleChallengeResultView:GetLevelUpInfoList()
	return PlayerData:GetlevelUpInfos()
end

function CoreVerificationDoubleChallengeResultView:NeedAddExp()
	return true
end

function CoreVerificationDoubleChallengeResultView:GetRewardData()
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(self.params_.rewardList) do
		table.insert(var_30_0, iter_30_1)
	end

	return var_30_0
end

function CoreVerificationDoubleChallengeResultView:OnTop()
	SetActive(self.gameObject_, true)

	self.toStat_ = false
end

function CoreVerificationDoubleChallengeResultView:OnBehind()
	if self.toStat_ then
		SetActive(self.gameObject_, false)
	end
end

function CoreVerificationDoubleChallengeResultView:GoToBattleStatistics()
	self.toStat_ = true

	JumpTools.OpenPageByJump("battleStatistics", {
		stageData = self.params_.stageData,
		battleTime = self:GetBattleTime(),
		hasSnapshot_ = self.hasSnapshot_
	})
end

function CoreVerificationDoubleChallengeResultView:ShowVitalityBox(arg_34_1)
	if needShowVitalityFullBox() then
		showVitalitySendMail(arg_34_1)
	else
		arg_34_1()
	end
end

function CoreVerificationDoubleChallengeResultView:ShowEquipBox(arg_35_1)
	if needShowBagFullBox() then
		showEquipSendMail(arg_35_1)
	else
		arg_35_1()
	end
end

function CoreVerificationDoubleChallengeResultView:CloseFunc()
	OperationRecorder.Record(self.class.__cname, "closeCombat")
	self:ShowVitalityBox(function()
		self:ShowEquipBox(function()
			BattleInstance.QuitBattle(self.params_.stageData)
		end)
	end)
end

return CoreVerificationDoubleChallengeResultView

local BossAdvanceTargetView = class("BossAdvanceTargetView", ReduxView)

function BossAdvanceTargetView:UIName()
	return "Widget/System/Challenge_Boss/BossCombatUI"
end

function BossAdvanceTargetView:UIParent()
	return manager.ui.uiMain.transform
end

function BossAdvanceTargetView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.hardList_ = LuaList.New(handler(self, self.RefreshMultipleItem), self.hardUIList_, BossAdvanceTargetMultiple)
	self.affixList_ = LuaList.New(handler(self, self.RefreshAffixItem), self.affixUIList_, BossAdvanceTargetCondition)
	self.chooseConditionHandler_ = handler(self, self.ChooseCondition)
	self.challengeUpdateHandler_ = handler(self, self.UpdateBossChallenge)
end

function BossAdvanceTargetView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistHomeCallBack(function()
		self:SaveTargerData(function()
			self:Go("/home")
		end)
	end)
	manager.windowBar:RegistBackCallBack(function()
		self:SaveTargerData(function()
			self:Back()
		end)
	end)
	BossTools.CheckTimeout()

	self.bossIndex_ = self.params_.bossIndex

	self:RefreshData()
	self:RefreshUI()
	self.hardList_:StartScroll(#BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].difficult_point, 1)
	self.affixList_:StartScroll(#self.cfg_.time_pool + #self.cfg_.affix_pool, 1)
	manager.notify:RegistListener(BOSS_CHALLENGE_CHOOSE_CONDITION, self.chooseConditionHandler_)
	manager.notify:RegistListener(BOSS_CHALLENGE_CHOOSE_MULTIPLE, self.chooseConditionHandler_)
	manager.notify:RegistListener(BOSS_CHALLENGE_BACK_ENTRACE, self.challengeUpdateHandler_)
end

function BossAdvanceTargetView:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(BOSS_CHALLENGE_CHOOSE_CONDITION, self.chooseConditionHandler_)
	manager.notify:RemoveListener(BOSS_CHALLENGE_CHOOSE_MULTIPLE, self.chooseConditionHandler_)
	manager.notify:RemoveListener(BOSS_CHALLENGE_BACK_ENTRACE, self.challengeUpdateHandler_)
end

function BossAdvanceTargetView:Dispose()
	BossAdvanceTargetView.super.Dispose(self)

	self.challengeUpdateHandler_ = nil
	self.chooseConditionHandler_ = nil

	if self.hardList_ then
		self.hardList_:Dispose()

		self.hardList_ = nil
	end

	if self.affixList_ then
		self.affixList_:Dispose()

		self.affixList_ = nil
	end
end

function BossAdvanceTargetView:AddListeners()
	self:AddBtnListener(self.battleBtn_, nil, function()
		self:SaveTargerData(function(arg_13_0)
			if isSuccess(arg_13_0.result) then
				self:Go("/sectionSelectHero", {
					section = BossChallengeAdvancePoolCfg[self.poolID_].stage_id,
					bossIndex = self.bossIndex_,
					sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE,
					reserveParams = ReserveParams.New(nil, BossTools.GetContID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE, self.bossIndex_), nil, {
						stageType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE,
						stageID = BossChallengeAdvancePoolCfg[self.poolID_].stage_id,
						bossIndex = self.params_.bossIndex
					})
				})
			end
		end)
	end)
end

function BossAdvanceTargetView:RefreshData()
	local var_14_0 = BattleBossChallengeAdvanceData:GetBossList()[self.bossIndex_]

	self.bossID_ = var_14_0.templateID
	self.poolID_ = var_14_0.id
	self.cfg_ = BossChallengeAdvancePoolCfg[self.poolID_]
end

function BossAdvanceTargetView:RefreshUI()
	self.bossImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.BossLittlePaint.path, BossChallengeUICfg[self.bossID_].icon))
	self.bossAffixText_.text = getAffixDesc(BossChallengeUICfg[self.bossID_].custom_affix)

	self:ChooseCondition()
end

function BossAdvanceTargetView:UpdateBossChallenge()
	BattleBossChallengeAction.BossChallengeBackEntrace()
end

function BossAdvanceTargetView:RefreshMultipleItem(arg_17_1, arg_17_2)
	arg_17_2:SetData(self.bossIndex_, arg_17_1)
end

function BossAdvanceTargetView:RefreshAffixItem(arg_18_1, arg_18_2)
	local var_18_0
	local var_18_1

	if arg_18_1 <= #self.cfg_.time_pool then
		var_18_0 = BossConst.TYPE_STAGE
		var_18_1 = self.cfg_.time_pool[arg_18_1]
	else
		var_18_0 = BossConst.TYPE_AFFIX
		var_18_1 = self.cfg_.affix_pool[arg_18_1 - #self.cfg_.time_pool]
	end

	arg_18_2:SetData(self.bossIndex_, var_18_0, var_18_1)
end

function BossAdvanceTargetView:ChooseCondition()
	self.pointText_.text = BattleBossChallengeAdvanceData:GetPointValue(self.bossIndex_)

	local var_19_0 = BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].monster_value[BattleBossChallengeAdvanceData:GetBossList()[self.bossIndex_].multipleIndex]

	self.bossAttackText_.text = string.format("+%s%%", var_19_0[1] / 10 - 100)
	self.bossHpText_.text = string.format("+%s%%", var_19_0[3] / 10 - 100)
end

function BossAdvanceTargetView:SaveTargerData(arg_20_1)
	local var_20_0 = BattleBossChallengeAdvanceData:GetBossList()[self.bossIndex_]
	local var_20_1 = var_20_0.multipleIndex
	local var_20_2 = clone(var_20_0.condition)

	BattleBossChallengeAction.ModifySelectAffix(var_20_0.id, var_20_0.multipleIndex, var_20_0.condition[BossConst.TYPE_STAGE], var_20_0.condition[BossConst.TYPE_AFFIX], function(arg_21_0)
		if isSuccess(arg_21_0.result) then
			BattleBossChallengeAdvanceData:SetBossTarget(self.bossIndex_, var_20_1, var_20_2)
		else
			ShowTips(arg_21_0.result)
		end

		arg_20_1(arg_21_0)
	end)
end

return BossAdvanceTargetView

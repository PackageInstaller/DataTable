local BattleBossChallengeView = class("BattleBossChallengeView", (import("game.views.stage.bossChallenge.BattleBossInfoBaseView")))

function BattleBossChallengeView:UIName()
	return "Widget/System/Challenge_Boss/BossInformationUI"
end

function BattleBossChallengeView:Init()
	BattleBossChallengeView.super.Init(self)

	self.difficultItemList_ = {}
	self.targetItemList_ = {}
	self.affixItemList_ = {}
	self.hideInfoHandler_ = handler(self, self.HideInfo)
	self.switchDifficultHandler_ = handler(self, self.SwitchDifficult)
	self.controller_ = ControllerUtil.GetController(self.startBattleBtn_.transform, "name")
end

function BattleBossChallengeView:OnEnterExtend()
	manager.windowBar:SetGameHelpKey("BOSS_CHALLENGE_DESC")

	self.bossIndex_ = self.params_.bossIndex or BattleBossChallengeData:GetCacheSelectBossIndex()

	BattleBossChallengeData:SaveCacheSelectBossIndex(self.bossIndex_)
	manager.notify:RegistListener(BOSS_CHALLENGE_SWITCH_DIFFICULT, self.switchDifficultHandler_)
	manager.redPoint:bindUIandKey(self.transformStar_, RedPointConst.BOSS_CHALLENGE_NORMAL)
	manager.notify:RegistListener(CLICK_AFFIX, self.hideInfoHandler_)
end

function BattleBossChallengeView:OnExit()
	BattleBossChallengeView.super.OnExit(self)
	manager.notify:RemoveListener(BOSS_CHALLENGE_SWITCH_DIFFICULT, self.switchDifficultHandler_)
	manager.notify:RemoveListener(CLICK_AFFIX, self.hideInfoHandler_)
	manager.redPoint:unbindUIandKey(self.transformStar_, RedPointConst.BOSS_CHALLENGE_NORMAL)
end

function BattleBossChallengeView:OnUpdate()
	BattleBossChallengeView.super.OnUpdate(self)
	self:RefreshResetBtn()
	self:RefreshStar()
end

function BattleBossChallengeView:Dispose()
	BattleBossChallengeView.super.Dispose(self)

	self.switchDifficultHandler_ = nil

	for iter_6_0, iter_6_1 in pairs(self.affixItemList_) do
		iter_6_1:Dispose()
	end

	self.affixItemList_ = nil

	for iter_6_2, iter_6_3 in ipairs(self.difficultItemList_) do
		iter_6_3:Dispose()
	end

	self.difficultItemList_ = nil

	for iter_6_4, iter_6_5 in ipairs(self.targetItemList_) do
		iter_6_5:Dispose()
	end

	self.targetItemList_ = nil
end

function BattleBossChallengeView:AddListeners()
	self:AddBtnListener(self.startBattleBtn_, nil, function()
		if self.isLock_ then
			ShowTips("NEED_UNLOCK_FRONT_DIFFICULT")

			return
		end

		BattleBossChallengeNormalData:SetSelectDifficult(self.bossIndex_, self.difficult_)
		self:Go("/sectionSelectHero", {
			section = self.curStageID_,
			bossIndex = self.bossIndex_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE,
			reserveParams = ReserveParams.New(ReserveConst.RESERVE_TYPE.BOSS_CHALLENGE, BossTools.GetContID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE, self.bossIndex_), nil, {
				stageType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE,
				stageID = self.curStageID_,
				bossIndex = self.bossIndex_
			})
		})
	end)
	self:AddBtnListener(self.buttonExchange_, nil, function()
		JumpTools.OpenPageByJump("bossStarExchange")
	end)
	self:AddBtnListener(self.resetBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("BOSS_CHALLENGE_NORMAL_RESET"),
			OkCallback = function()
				BattleBossChallengeAction.ResetNormalModeBoss(self.bossIndex_, function(arg_12_0)
					if isSuccess(arg_12_0.result) then
						self:RefreshData()
						self:RefreshUI()
					else
						ShowTips(arg_12_0.result)
					end
				end)
			end
		})
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		manager.notify:Invoke(CLICK_AFFIX)
		SetActive(self.bgBtn_.gameObject, false)

		self.heroLockScroll_.normalizedPosition = Vector2(0, 1)
	end)
end

function BattleBossChallengeView:RefreshData()
	self.templateID_ = StageGroupCfg[BattleBossChallengeNormalData:GetBossList()[self.bossIndex_]].boss_id
	self.difficult_ = BattleBossChallengeNormalData:GetSelectDifficult(self.bossIndex_)
	self.curStageID_ = self:GetStageID()
	self.lockHeroGroup_ = BattleBossChallengeNormalData:GetLockHero()
	self.isLock_ = self.difficult_ > BattleBossChallengeNormalData:GetFinishIndex(self.bossIndex_)
end

function BattleBossChallengeView:GetBossID()
	return
end

function BattleBossChallengeView:RefreshUI()
	BattleBossChallengeView.super.RefreshUI(self)
	self:RefreshStar()
	self:RefreshDifficultItem()
	self:RefreshTargetItem()
	self:RefreshAffix()
	self:RefreshResetBtn()
	self:RefreshStartBtn()
end

function BattleBossChallengeView:GetAffix()
	if type(BattleBossStageCfg[self.curStageID_].affix_type) ~= "table" then
		return {}
	end

	return getMosterAffix(BattleBossStageCfg[self.curStageID_].affix_type)
end

function BattleBossChallengeView:GetStageID()
	return BattleBossChallengeNormalData:GetStageList(self.bossIndex_, self.difficult_)
end

function BattleBossChallengeView:HideInfo()
	SetActive(self.bgBtn_.gameObject, true)
end

function BattleBossChallengeView:SwitchDifficult(arg_20_1)
	self.difficult_ = arg_20_1
	self.curStageID_ = self:GetStageID()
	self.isLock_ = self.difficult_ > BattleBossChallengeNormalData:GetFinishIndex(self.bossIndex_)

	self:RefreshTargetItem()
	self:RefreshAffix()

	for iter_20_0, iter_20_1 in ipairs(self.difficultItemList_) do
		iter_20_1:SwitchDifficult(arg_20_1)
	end

	self:RefreshStartBtn()
end

function BattleBossChallengeView:RefreshAffix()
	local var_21_0 = self:GetAffix()

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if self.affixItemList_[iter_21_0] then
			self.affixItemList_[iter_21_0]:SetData(iter_21_1)
		else
			self.affixItemList_[iter_21_0] = AffixItemView.New(self.affixItem_, self.affixPanel_, iter_21_1)
		end
	end

	for iter_21_2 = #self.affixItemList_, #var_21_0 + 1, -1 do
		self.affixItemList_[iter_21_2]:Show(false)
	end
end

function BattleBossChallengeView:RefreshStar()
	local var_22_0 = BattleBossChallengeNormalData:GetBossChallengeCfg()
	local var_22_1 = var_22_0.reward[#var_22_0.reward][1]
	local var_22_2 = BattleBossChallengeNormalData:GetReceiveStarList()

	for iter_22_0 = 1, #var_22_0.reward do
		if not table.keyof(var_22_2, var_22_0.reward[iter_22_0][1]) then
			var_22_1 = var_22_0.reward[iter_22_0][1]

			break
		end
	end

	self.textCurStar_.text = StageTools.CalcBossChallengeStar()
	self.textTotalStar_.text = string.format("/%s", var_22_1)
end

function BattleBossChallengeView:RefreshDifficultItem()
	local var_23_0 = BattleBossChallengeNormalData:GetSelectDifficult(self.bossIndex_)

	for iter_23_0 = 1, BattleBossChallengeNormalData:GetBossChallengeCfg().level_amount do
		if self.difficultItemList_[iter_23_0] == nil then
			self.difficultItemList_[iter_23_0] = BattleBossChallengeDifficultItem.New(self.goDifficultItem_, self.goDifficultParent_, self.goLight_, self.goLightParent_, iter_23_0)
		end

		self.difficultItemList_[iter_23_0]:SetData(self.bossIndex_)
		self.difficultItemList_[iter_23_0]:SwitchDifficult(var_23_0)
	end
end

function BattleBossChallengeView:RefreshTargetItem()
	local var_24_0 = BattleBossChallengeNormalData:GetStarList(self.curStageID_)

	for iter_24_0 = 1, 3 do
		if self.targetItemList_[iter_24_0] == nil then
			self.targetItemList_[iter_24_0] = BattleBossTargetItem.New(self[string.format("goTargetItem%s_", iter_24_0)], iter_24_0)
		end

		self.targetItemList_[iter_24_0]:Refresh(var_24_0[iter_24_0] == 1, BattleBossStageCfg[self.curStageID_].three_star_need[iter_24_0])
	end
end

function BattleBossChallengeView:RefreshResetBtn()
	if table.length(BattleBossChallengeNormalData:GetReceiveStarList()) > 0 then
		SetActive(self.resetGo_, false)

		return
	end

	if table.length(BattleBossChallengeNormalData:GetLockHero()[self.bossIndex_]) > 0 then
		SetActive(self.resetGo_, true)
	else
		SetActive(self.resetGo_, false)
	end
end

function BattleBossChallengeView:RefreshStartBtn()
	if self.isLock_ then
		self.controller_:SetSelectedState("false")
	else
		self.controller_:SetSelectedState("true")
	end
end

return BattleBossChallengeView

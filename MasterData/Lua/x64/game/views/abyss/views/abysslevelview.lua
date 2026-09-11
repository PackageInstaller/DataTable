local AbyssLevelView = class("AbyssLevelView", ReduxView)

function AbyssLevelView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AbyssLevelView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AbyssLevelView:InitUI()
	self:BindCfgUI()

	self.isBossController_ = ControllerUtil.GetController(self.gameObject_.transform, "isBoss")
	self.difficultyController_ = ControllerUtil.GetController(self.gameObject_.transform, "difficulty")
	self.resetGrayedController_ = ControllerUtil.GetController(self.resetBtn_.transform, "grayed")
	self.completeController_ = ControllerUtil.GetController(self.gameObject_.transform, "complete")
	self.lockList_ = LuaList.New(handler(self, self.IndexLockItem), self.lockListGo_, AbyssHeroItemView)
	self.abandonList_ = LuaList.New(handler(self, self.IndexAbandonItem), self.abandonListGo_, AbyssHeroItemView)
	self.monsterList_ = LuaList.New(handler(self, self.IndexMonsterItem), self.monsterListGo_, AbyssMonsterItemView)
end

function AbyssLevelView:IndexLockItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, self.lockedHeroList_[arg_4_1])
end

function AbyssLevelView:IndexAbandonItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, self.abandonHeroList_[arg_5_1])
end

function AbyssLevelView:IndexMonsterItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.monsterIdList_[arg_6_1])
	arg_6_2:RegisterClickListener(handler(self, self.OnMonsterClick))
end

function AbyssLevelView:OnMonsterClick()
	JumpTools.OpenPageByJump("abyssBossDetail", {
		bossIdList = self.monsterIdList_
	})
end

function AbyssLevelView:AddUIListener()
	self:AddBtnListener(self.bossHeadBtn_, nil, function()
		JumpTools.OpenPageByJump("abyssBossDetail", {
			bossIdList = self.monsterIdList_
		})
	end)
	self:AddBtnListener(self.challengeBtn_, nil, function()
		gameContext:Go("/sectionSelectHero", {
			section = self.stageCfg_[2],
			sectionType = BattleConst.STAGE_TYPE_NEW.ABYSS,
			layer = self.layer_,
			stageIndex = self.stageIndex_,
			curActivityID = AbyssData:GetActivityId(),
			activityID = self.stageCfg_[2],
			reserveParams = ReserveParams.New(ReserveConst.RESERVE_TYPE.ABYSS, self.stageCfg_[2], self:GetTeamIndex(), {
				stageType = BattleConst.STAGE_TYPE_NEW.ABYSS,
				stageID = self.stageCfg_[2],
				layer = self.layer_
			})
		})
	end)
	self:AddBtnListener(self.resetBtn_, nil, function()
		if AbyssData:GetStageResetTime() <= 0 then
			ShowTips("ABYSS_STAGE_RESET_CLICK_TIP")

			return
		end

		local var_11_0 = AbyssData:GetCurrentLayer()

		if AbyssData:HaveUpperLevelChallenging(self.layer_) then
			ShowTips(string.format(GetTips("ABYSS_STAGE_CHALLENGING_RESET_TIP"), (AbyssData:GetLayerStatus(var_11_0) == 1 or nil) and var_11_0 - 1))

			return
		end

		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("ABYSS_STAGE_RESET_TIP"),
			SecondTip = GetTips("ABYSS_STAGE_RESET_TIMES"),
			SecondValue = AbyssData:GetStageResetTime() .. "/" .. AbyssData:GetStageResetLimit(),
			OkCallback = function(arg_12_0)
				if arg_12_0 ~= AbyssData:GetActivityId() then
					ShowTips("ERROR_ACTIVITY_NOT_OPEN")

					return
				end

				AbyssAction.ResetStage(self.layer_, self.stageIndex_, self.battleAbyssCfg_.id)
			end,
			CancelCallback = function()
				return
			end,
			Param = AbyssData:GetActivityId()
		})
	end)
end

function AbyssLevelView:AddEventListeners()
	self:RegistEventListener(ABYSS_LAYER_RESET_TIME_UPDATE, function(arg_15_0)
		if arg_15_0 == self.layer_ then
			self:UpdateView()
		end
	end)
	self:RegistEventListener(ABYSS_STAGE_RESET_TIME_UPDATE, function(arg_16_0, arg_16_1)
		if arg_16_0 == self.layer_ and arg_16_1 == self.stageCfg_[2] then
			ShowTips("ABYSS_RESET_STAGE_FINISH_TIP")
			self:UpdateView()
		end
	end)
end

function AbyssLevelView:SetData(arg_17_1, arg_17_2)
	self.layer_ = arg_17_1
	self.stageIndex_ = arg_17_2
	self.abyssCfg_ = AbyssData:GetAbyssCfg(arg_17_1)
	self.stageCfg_ = self.abyssCfg_.stage_list[self.stageIndex_]
	self.stageId_ = self.stageCfg_[2]
	self.battleAbyssCfg_ = BattleAbyssCfg[self.stageCfg_[2]]
	self.monsterIdList_ = self.abyssCfg_.stage_target[self.stageIndex_]

	self:UpdateView()
end

function AbyssLevelView:UpdateView()
	if self.stageCfg_[1] == 3 then
		self.abandonHeroList_ = AbyssTools.GetStageBanHeroList(self.layer_, self.stageIndex_)
	end

	self.monsterList_:StartScroll(#self.monsterIdList_)
	self.difficultyController_:SetSelectedState(tostring(self.stageCfg_[1]))

	self.descLabel_.text = GetI18NText(self.battleAbyssCfg_.tips)

	if self.stageCfg_[1] == 3 then
		self.bossImage_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. AbyssUICfg[self.monsterIdList_[1]].enemy_id)

		if AbyssUICfg[self.monsterIdList_[1]] ~= nil then
			if AbyssUICfg[self.monsterIdList_[1]].icon_pos ~= nil and AbyssUICfg[self.monsterIdList_[1]].icon_pos ~= "" and #AbyssUICfg[self.monsterIdList_[1]].icon_pos > 0 then
				self.bossImage_.transform.anchoredPosition = Vector3(AbyssUICfg[self.monsterIdList_[1]].icon_pos[1], AbyssUICfg[self.monsterIdList_[1]].icon_pos[2], AbyssUICfg[self.monsterIdList_[1]].icon_pos[3])
			end

			if AbyssUICfg[self.monsterIdList_[1]].icon_scale ~= nil and AbyssUICfg[self.monsterIdList_[1]].icon_scale ~= "" and #AbyssUICfg[self.monsterIdList_[1]].icon_scale > 0 then
				self.bossImage_.transform.localScale = Vector3(AbyssUICfg[self.monsterIdList_[1]].icon_scale[1], AbyssUICfg[self.monsterIdList_[1]].icon_scale[2], AbyssUICfg[self.monsterIdList_[1]].icon_scale[3])
			end

			if AbyssUICfg[self.monsterIdList_[1]].icon_rot ~= nil and AbyssUICfg[self.monsterIdList_[1]].icon_rot ~= "" and #AbyssUICfg[self.monsterIdList_[1]].icon_rot > 0 then
				self.bossImage_.transform.localEulerAngles = Vector3(AbyssUICfg[self.monsterIdList_[1]].icon_rot[1], AbyssUICfg[self.monsterIdList_[1]].icon_rot[2], AbyssUICfg[self.monsterIdList_[1]].icon_rot[3])
			end
		end

		self.isBossController_:SetSelectedState("true")
	else
		self.isBossController_:SetSelectedState("false")
	end

	if AbyssData:IsLayerUnlock(self.layer_) then
		self.stageData_ = AbyssData:GetStageData(self.abyssCfg_.level, self.stageIndex_)
		self.lockedHeroList_ = AbyssTools.GetStageLockHeroList(self.abyssCfg_.level, self.stageIndex_)

		if self.stageData_.is_completed then
			self.completeController_:SetSelectedState("true")

			self.scoreLabel_.text = AbyssData:GetStageScore(self.abyssCfg_.level, self.stageIndex_)
		elseif self.stageCfg_[1] == 3 then
			if #self.abandonHeroList_ > 0 then
				self.completeController_:SetSelectedState("challenging")
			else
				self.completeController_:SetSelectedState("false")
			end
		else
			self.completeController_:SetSelectedState("false")
		end

		if self.stageCfg_[1] == 3 then
			self.abandonList_:StartScroll(#self.abandonHeroList_)

			local var_18_0 = AbyssData:GetStageData(self.layer_, self.stageIndex_)
			local var_18_1 = AbyssData:ConvertPhaseBossHpToTotal(self.stageId_, var_18_0.phase, var_18_0.boss_hp_rate) / AbyssData:GetBossTotalHp(self.stageId_)

			self.hpPercentLabel_.text = math.ceil(100 * var_18_1)
			self.bossHpSlider_.value = var_18_1
		else
			self.isBossController_:SetSelectedState("false")
		end

		self.lockList_:StartScroll(#self.lockedHeroList_)
	else
		self.abandonList_:StartScroll(0)

		if self.stageCfg_[1] == 3 then
			self.hpPercentLabel_.text = math.ceil(100)
			self.bossHpSlider_.value = 1
		end

		self.completeController_:SetSelectedState("not_open")
	end

	if AbyssData:GetStageResetTime() <= 0 then
		self.resetGrayedController_:SetSelectedState("true")
	else
		self.resetGrayedController_:SetSelectedState("false")
	end
end

function AbyssLevelView:OnEnter()
	self:AddEventListeners()
end

function AbyssLevelView:OnExit()
	self:RemoveAllEventListener()
end

function AbyssLevelView:OnMainHomeViewTop()
	return
end

function AbyssLevelView:Dispose()
	self.data_ = nil

	if self.lockList_ then
		self.lockList_:Dispose()

		self.lockList_ = nil
	end

	if self.abandonList_ then
		self.abandonList_:Dispose()

		self.abandonList_ = nil
	end

	if self.monsterList_ then
		self.monsterList_:Dispose()

		self.monsterList_ = nil
	end

	AbyssLevelView.super.Dispose(self)
end

function AbyssLevelView:GetTeamIndex()
	return AbyssTools.GetTeamIndex(self.layer_, self.stageIndex_)
end

return AbyssLevelView

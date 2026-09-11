local BossChallengeModeItem = class("BossChallengeModeItem", ReduxView)

function BossChallengeModeItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "chooseItem")
	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")
	self.chooseHandler_ = handler(self, self.ChooseMode)

	manager.notify:RegistListener(CHALLENGE_CHOOSE_MODE, self.chooseHandler_)
end

function BossChallengeModeItem:Dispose()
	BossChallengeModeItem.super.Dispose(self)
	manager.notify:RemoveListener(CHALLENGE_CHOOSE_MODE, self.chooseHandler_)

	self.chooseHandler_ = nil
end

function BossChallengeModeItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if table.keyof(BattleBossChallengeData:GetOpenModeList(), BossChallengeAdvanceCfg.all[self.index_]) == nil then
			if BossChallengeAdvanceCfg[BossChallengeAdvanceCfg.all[self.index_ - 1]].type == 1 then
				ShowTips(string.format(GetTips("BOSS_CHALLENGE_UNLOCK_TIPS"), GetI18NText(BossChallengeAdvanceCfg[BossChallengeAdvanceCfg.all[self.index_ - 1]].name2), BossChallengeAdvanceCfg[BossChallengeAdvanceCfg.all[self.index_]].open_condition))
			else
				ShowTips(string.format(GetTips("BOSS_CHALLENGE_ADVANCE_UNLOCK_TIPS"), GetI18NText(BossChallengeAdvanceCfg[BossChallengeAdvanceCfg.all[self.index_ - 1]].name2), BossChallengeAdvanceCfg[BossChallengeAdvanceCfg.all[self.index_]].open_condition))
			end

			return
		end

		manager.notify:Invoke(CHALLENGE_CHOOSE_MODE, self.index_)
	end)
end

function BossChallengeModeItem:ChooseMode(arg_5_1)
	if self.index_ == arg_5_1 then
		self.selectController_:SetSelectedState("on")
	else
		self.selectController_:SetSelectedState("off")
	end
end

function BossChallengeModeItem:SetData(arg_6_1, arg_6_2)
	self.index_ = arg_6_1

	local var_6_0 = BossChallengeAdvanceCfg.all[arg_6_1]
	local var_6_1 = BossChallengeAdvanceCfg[BossChallengeAdvanceCfg.all[arg_6_1]]

	self.modeText_.text = GetI18NText(BossChallengeAdvanceCfg[BossChallengeAdvanceCfg.all[arg_6_1]].name)

	if var_6_1.type == 2 then
		self.difficultText_.text = ""
		self.romaImage_.sprite = getSprite("Atlas/Tower", string.format("bg_n%s", (table.keyof(BossChallengeAdvanceCfg.get_id_list_by_type[2], var_6_0))))
	else
		self.difficultText_.text = GetI18NText(var_6_1.name2)
	end

	SetActive(self.romaGo_, var_6_1.type == 2)
	SetSpriteWithoutAtlasAsync(self.bgImage_, SpritePathCfg.ChapterPaint.path .. var_6_1.bg)

	if table.keyof(BattleBossChallengeData:GetOpenModeList(), var_6_0) then
		self.lockController_:SetSelectedState("false")
	else
		self.lockController_:SetSelectedState("true")
	end

	self:ChooseMode(arg_6_2)
end

return BossChallengeModeItem

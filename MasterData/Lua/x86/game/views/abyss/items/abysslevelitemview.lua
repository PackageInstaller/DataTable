local AbyssLevelItemView = class("AbyssLevelItemView", ReduxView)

function AbyssLevelItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AbyssLevelItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AbyssLevelItemView:InitUI()
	self:BindCfgUI()

	self.difficultyController_ = ControllerUtil.GetController(self.gameObject_.transform, "difficulty")
	self.unlockController_ = ControllerUtil.GetController(self.gameObject_.transform, "unlock")
	self.bossStatusController_ = ControllerUtil.GetController(self.winGo_.transform, "Challengestatus")
	self.challengeStatusController_ = ControllerUtil.GetController(self.winGo_.transform, "Challengestatus1")
	self.selectController_ = ControllerUtil.GetController(self.winGo_.transform, "select")
	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.lockListGo_, AbyssHeroItemView)
	self.abandonUIList_ = LuaList.New(handler(self, self.indexAbandonItem), self.abandonListGo_, AbyssHeroItemView)
end

function AbyssLevelItemView:indexItem(arg_4_1, arg_4_2)
	local var_4_0 = AbyssData:GetStageData(self.cfg_.level, self.index_)

	arg_4_2:SetData(arg_4_1, self.lockHeroIDList_[arg_4_1])
end

function AbyssLevelItemView:indexAbandonItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, self.abandonIdList_[arg_5_1])
end

function AbyssLevelItemView:AddUIListener()
	return
end

function AbyssLevelItemView:AddEventListeners()
	self:RegistEventListener(ABYSS_STAGE_RESET_TIME_UPDATE, function(arg_8_0, arg_8_1)
		if self.cfg_ == nil then
			return
		end

		if arg_8_0 == self.cfg_.level and arg_8_1 == self.stageId_ then
			self:UpdateView()
		end
	end)
end

function AbyssLevelItemView:SetData(arg_9_1, arg_9_2)
	self.cfg_ = arg_9_1
	self.index_ = arg_9_2
	self.stageCfg_ = self.cfg_.stage_list[arg_9_2]
	self.stageType_ = self.stageCfg_[1]
	self.stageId_ = self.stageCfg_[2]
	self.score_ = self.stageCfg_[3]

	self:UpdateView()
end

function AbyssLevelItemView:UpdateView()
	self.difficultyController_:SetSelectedState(tostring(self.stageCfg_[1]))

	if AbyssData:IsLayerUnlock(self.cfg_.level) then
		self.unlockController_:SetSelectedState("true")

		self.scoreLabel_.text = AbyssData:GetStageScore(self.cfg_.level, self.index_)

		if AbyssData:GetStageData(self.cfg_.level, self.index_).is_completed then
			self.challengeStatusController_:SetSelectedState("lock")

			if self.index_ == 3 then
				CustomLog.Log(debug.traceback(string.format("3")))
			end

			self.lockHeroIDList_ = AbyssTools.GetStageLockHeroList(self.cfg_.level, self.index_)

			self.uiList_:StartScroll(#self.lockHeroIDList_)
		else
			self.challengeStatusController_:SetSelectedState("no")
		end

		if self.stageType_ == 3 then
			local var_10_0 = AbyssData:GetStageData(self.cfg_.level, self.index_)
			local var_10_1 = AbyssData:ConvertPhaseBossHpToTotal(self.stageId_, var_10_0.phase, var_10_0.boss_hp_rate) / AbyssData:GetBossTotalHp(self.stageId_)

			self.hpPercentLabel_.text = math.ceil(100 * var_10_1)
			self.bossHpSlider_.value = var_10_1
			self.abandonIdList_ = AbyssTools.GetStageBanHeroList(self.cfg_.level, self.index_)

			if #self.abandonIdList_ > 0 then
				self.abandonUIList_:StartScroll(#self.abandonIdList_)
				self.bossStatusController_:SetSelectedState("boss")
			else
				self.bossStatusController_:SetSelectedState("boss_1")
			end
		else
			self.bossStatusController_:SetSelectedState("normal")
		end
	else
		self.unlockController_:SetSelectedState("false")
	end
end

function AbyssLevelItemView:OnEnter()
	self:AddEventListeners()
end

function AbyssLevelItemView:OnExit()
	self:RemoveAllEventListener()
end

function AbyssLevelItemView:OnMainHomeViewTop()
	return
end

function AbyssLevelItemView:SetSelect(arg_14_1)
	if arg_14_1 then
		self.selectController_:SetSelectedState("select_1")
	else
		self.selectController_:SetSelectedState("normal")
	end
end

function AbyssLevelItemView:Dispose()
	self.data_ = nil

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	if self.abandonUIList_ then
		self.abandonUIList_:Dispose()

		self.abandonUIList_ = nil
	end

	AbyssLevelItemView.super.Dispose(self)
end

return AbyssLevelItemView

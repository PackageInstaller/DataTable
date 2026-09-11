local AshSectionBaseView = class("AshSectionBaseView", ReduxView)

function AshSectionBaseView:UIName()
	return "Widget/System/Activity_EkChuah/EkChuah_Com/EkChuah_StageBaseUI"
end

function AshSectionBaseView:UIParent()
	return manager.ui.uiMain.transform
end

function AshSectionBaseView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function AshSectionBaseView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.RefreshRewardItem), self.consumeList_, CommonItemView)
	self.dropController_ = self.controller_:GetController("hideDropPanel")
	self.conditionController_ = self.controller_:GetController("hideStageDesc")
	self.lockController_ = self.controller_:GetController("startBtnLock")
	self.scoreController_ = self.controller_:GetController("hideStageScore")
end

function AshSectionBaseView:AddUIListeners()
	self:AddBtnListener(self.startGameBtn_, nil, function()
		self:StartGame()
	end)
end

function AshSectionBaseView:RefreshRewardItem(arg_7_1, arg_7_2)
	local var_7_0

	if self.rewardList_[arg_7_1] then
		var_7_0 = rewardToItemTemplate(self.rewardList_[arg_7_1])
		var_7_0.number = self.rewardList_[arg_7_1].num

		function var_7_0.clickFun(arg_8_0)
			ShowPopItem(POP_ITEM, arg_8_0)
		end
	end

	arg_7_2:SetData(var_7_0)
end

function AshSectionBaseView:StartGame()
	JumpTools.OpenPageByJump("/ashPrepareView", {
		stageId = AshShootStageCfg[self.level].stage_id,
		levelId = self.level
	})
end

function AshSectionBaseView:OnUpdate()
	if self.level == self.params_.level then
		return
	end

	self.level = self.params_.level
	self.stageId = AshShootStageCfg[self.level].stage_id

	self:RenderUI()
end

function AshSectionBaseView:OnEnter()
	self.level = self.params_.level
	self.stageId = AshShootStageCfg[self.level].stage_id
	self.dropLibID_ = BattleAshShootStageCfg[AshShootStageCfg[self.level].stage_id].drop_lib_id

	self:RenderUI()
	self:RefreshReward()
end

function AshSectionBaseView:RenderUI()
	self.stageName_.text = BattleAshShootStageCfg[AshShootStageCfg[self.level].stage_id].name
	self.stageBg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, BattleAshShootStageCfg[AshShootStageCfg[self.level].stage_id].background_1))
	self.conditionTxt_.text = AshShootStageCfg[self.level].victory_goal_desc
	self.lockText_.text = GetTips("ASH_STAGE_UNLOCK_TIPS")

	if AshSystemData:IsStagePass(self.level) then
		self.scoreText_.text = tostring(AshSystemData:GetStagePoint(self.level))

		self.dropController_:SetSelectedIndex(1)
	else
		self.scoreText_.text = "-- --"

		self.dropController_:SetSelectedIndex(0)
	end

	local var_12_0 = AshSystemData:FindPreSection(self.level)

	if not var_12_0 or var_12_0 and AshSystemData:IsStagePass(var_12_0) then
		self.lockController_:SetSelectedIndex(0)
	else
		self.lockController_:SetSelectedIndex(1)
	end

	local var_12_1 = 0

	for iter_12_0, iter_12_1 in ipairs(AshShootStageCfg.all) do
		if AshShootStageCfg[iter_12_1].stage_group == 4 then
			var_12_1 = AshShootStageCfg[iter_12_1].stage_id

			break
		end
	end

	if self.stageId ~= var_12_1 then
		self.conditionController_:SetSelectedIndex(0)
	else
		self.conditionController_:SetSelectedIndex(1)
	end
end

function AshSectionBaseView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()

		if self.params_.backFunc then
			self.params_.backFunc()
		end
	end)
end

function AshSectionBaseView:OnBehind()
	manager.windowBar:HideBar()
end

function AshSectionBaseView:OnExit()
	return
end

function AshSectionBaseView:RefreshReward()
	self.rewardList_ = getRewardFromDropCfg(self.dropLibID_, true)

	self.uiList_:StartScroll(#self.rewardList_)
end

function AshSectionBaseView:Dispose()
	self.uiList_:Dispose()

	self.uiList_ = nil

	AshSectionBaseView.super.Dispose(self)
end

return AshSectionBaseView

local TetrisGameSkillView = class("TetrisGameSkillView", ReduxView)

function TetrisGameSkillView:UIName()
	return "Widget/Version/Alone_TetrisGameUI/TetrisGamechapterUI"
end

function TetrisGameSkillView:UIParent()
	return manager.ui.uiMain.transform
end

function TetrisGameSkillView:OnCtor()
	return
end

function TetrisGameSkillView:Init()
	self:InitUI()
	self:AddUIListener()

	self.skillScroll = LuaList.New(handler(self, self.indexskillItem), self.skillListGo_, TetrisGameSkillItem)
	self.skillCountShowController = self.controller_:GetController("skillCountShow")
end

function TetrisGameSkillView:InitUI()
	self:BindCfgUI()
end

function TetrisGameSkillView:OnEnter()
	if self.params_.isORD then
		self.isORD = self.params_.isORD
		self.params_.isORD = nil
	end

	self.activityID = TetrisGameData:GetCurActivityID()

	TetrisGameAction:SaveNewSkill()
	self:RefreshBar()
	self:RefreshSkillList()
	self:RefreshViewInfo()

	self.texttittleText_.text = ActivityTetrisGameChapterCfg[1].name

	RankAction.QueryActivityRank(TetrisGameData:GetCurRankActivityID(), nil, function()
		self:RefreshViewInfo()
	end)
	self:BindRedPoint()
end

function TetrisGameSkillView:BindRedPoint()
	for iter_8_0, iter_8_1 in ipairs(ActivityTetrisGameChapterCfg.all) do
		if ActivityTetrisGameChapterCfg[iter_8_1].type == TetrisGameConst.stageType.normal then
			manager.redPoint:bindUIandKey(self.goBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_CHAPTER, iter_8_1))
		end
	end
end

function TetrisGameSkillView:UnbindRedPoint()
	for iter_9_0, iter_9_1 in ipairs(ActivityTetrisGameChapterCfg.all) do
		if ActivityTetrisGameChapterCfg[iter_9_1].type == TetrisGameConst.stageType.normal then
			manager.redPoint:unbindUIandKey(self.goBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_CHAPTER, iter_9_1))
		end
	end
end

function TetrisGameSkillView:OnTop()
	self:RefreshBar()
end

function TetrisGameSkillView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	if GameSetting.tetris_game_describe1 then
		local var_11_0 = GameSetting.tetris_game_describe1.value or {}
	end

	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_11_0
		})
	end)
	manager.windowBar:RegistBackCallBack(function()
		if self.isORD then
			JumpTools.OpenPageByJump("/tetrisGameMainView")
		else
			self:Back()
		end
	end)
end

function TetrisGameSkillView:OnExit()
	TetrisGameAction:UpdataNewSkill()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
	self:UnbindRedPoint()
end

function TetrisGameSkillView:GetCanUseSkillCount()
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in ipairs(self.skillList) do
		if TetrisGameTools:CheckSkillIsUnlock(iter_15_1) then
			var_15_0 = var_15_0 + 1
		end
	end

	return var_15_0
end

function TetrisGameSkillView:CheckIsNumLimit()
	local var_16_0 = true

	if GameSetting.tetris_game_skill_max.value[1] <= self:GetCanUseSkillCount() and #TetrisGameData:GetSkillList() < GameSetting.tetris_game_skill_max.value[1] then
		ShowTips("TETRIS_GAME_SKILL_NUM_TIPS")

		var_16_0 = false
	end

	return var_16_0
end

function TetrisGameSkillView:AddUIListener()
	self:AddBtnListener(self.startBtn_, nil, function()
		if not self:CheckIsNumLimit() then
			return
		end

		local var_18_0 = TetrisGameTools:GetEndLessStageIDByActivityID(self.activityID)

		if var_18_0 then
			TetrisGameTools:EnterStage(var_18_0)
		end
	end)
	self:AddBtnListener(self.btnrankBtn_, nil, function()
		JumpTools.OpenPageByJump("/tetrisGameRankView", {
			rankActivityID = TetrisGameData:GetCurRankActivityID()
		})
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		for iter_20_0, iter_20_1 in pairs((TetrisGameData:GetStageInfoList())) do
			local var_20_0 = TetrisGameTools:GetStageState(iter_20_0)

			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_STAGE, iter_20_0), 0)
		end

		JumpTools.OpenPageByJump("/tetrisGameChooseStageView", {
			isORD = true,
			chapterID = ActivityTetrisGameChapterCfg[ActivityTetrisGameChapterCfg.get_id_list_by_activityID[self.activityID][1] + 2].chapterID
		})
	end)
end

function TetrisGameSkillView:RegisterEvents()
	return
end

function TetrisGameSkillView:OnSkillUpdate()
	self.skillScroll:Refresh()
	self:RefreshViewInfo()
end

function TetrisGameSkillView:Dispose()
	if self.skillScroll then
		self.skillScroll:Dispose()

		self.skillScroll = nil
	end

	TetrisGameSkillView.super.Dispose(self)
end

function TetrisGameSkillView:GetTargetMoveIndex()
	local var_24_0 = -1

	for iter_24_0 = 1, #self.skillList do
		if manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_NEW_SKILL, self.skillList[iter_24_0])) then
			var_24_0 = iter_24_0

			break
		end
	end

	if var_24_0 < 0 then
		for iter_24_1 = 1, #self.skillList do
			if TetrisGameTools:CheckSkillInList(self.skillList[iter_24_1]) then
				var_24_0 = iter_24_1

				break
			end
		end
	end

	return var_24_0
end

function TetrisGameSkillView:RefreshSkillList()
	self.skillList = ActivityTetrisGameStageCfg[TetrisGameTools:GetEndLessStageIDByActivityID(self.activityID)].skill_list

	local var_25_0 = self:GetTargetMoveIndex()

	if var_25_0 > 0 then
		self.skillScroll:StartScroll(#self.skillList, var_25_0)
	else
		self.skillScroll:StartScroll(#self.skillList)
	end

	if TetrisGameConst.ultimateID and ActivityTetrisGameSkillCfg[TetrisGameConst.ultimateID] then
		self.ultimateNameTxt_.text = ActivityTetrisGameSkillCfg[TetrisGameConst.ultimateID].name
		self.ultimateDescTxt_.text = ActivityTetrisGameSkillCfg[TetrisGameConst.ultimateID].desc
		self.ultimateIcon_.sprite = TetrisGameTools:GetSkillIcon(TetrisGameConst.ultimateID)
	end
end

function TetrisGameSkillView:indexskillItem(arg_26_1, arg_26_2)
	arg_26_2:RefreshUI(self.skillList[arg_26_1])
end

function TetrisGameSkillView:RefreshViewInfo()
	local var_27_0 = self:GetCanUseSkillCount()

	if var_27_0 > 0 then
		self.skillCountShowController:SetSelectedState("show")
	else
		self.skillCountShowController:SetSelectedState("hide")
	end

	self.skillNum.text = string.format("%s/%s", tostring(#TetrisGameData:GetSkillList() or 0), (math.min(GameSetting.tetris_game_skill_max.value[1], var_27_0)))

	local var_27_1 = RankData:GetActivityRank(TetrisGameData:GetCurRankActivityID())
	local var_27_3

	if var_27_1 then
		local var_27_4

		var_27_4, var_27_3 = var_27_1:GetCurRankDes()
	else
		var_27_3 = GetTips("MATRIX_RANK_NO_INFO")
	end

	self.rankScore.text = var_27_3
end

return TetrisGameSkillView

local TetrisGameMainView = class("TetrisGameMainView", ReduxView)

function TetrisGameMainView:UIName()
	return "Widget/Version/Alone_TetrisGameUI/TetrisGameMainUI"
end

function TetrisGameMainView:UIParent()
	return manager.ui.uiMain.transform
end

function TetrisGameMainView:OnCtor()
	return
end

function TetrisGameMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function TetrisGameMainView:InitUI()
	self:BindCfgUI()

	self.lockController = self.chapterController:GetController("lock")
	self.endlessLockController = self.endlessController_:GetController("lock")
end

function TetrisGameMainView:OnEnter()
	self.activityID = TetrisGameData:GetCurActivityID()

	manager.redPoint:bindUIandKey(self.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, TetrisGameData:GetCurTaskActivityID()))
	manager.redPoint:bindUIandKey(self.specialBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_CHAPTER, TetrisGameTools:GetEndLessStageIDByActivityID(TetrisGameData:GetCurActivityID())))
	self:RefreshBar()
end

function TetrisGameMainView:OnTop()
	self:RefreshBar()
	self:RefreshChapterState()
end

function TetrisGameMainView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	if GameSetting.tetris_game_describe1 then
		local var_8_0 = GameSetting.tetris_game_describe1.value or {}
	end

	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_8_0
		})
	end)
end

function TetrisGameMainView:OnExit()
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, TetrisGameData:GetCurTaskActivityID()))
	manager.redPoint:unbindUIandKey(self.specialBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_CHAPTER, TetrisGameTools:GetEndLessStageIDByActivityID(TetrisGameData:GetCurActivityID())))
	self:RemoveAllEventListener()
end

function TetrisGameMainView:AddUIListener()
	self:AddBtnListener(self.rankBtn_, nil, function()
		if self.activityID then
			JumpTools.OpenPageByJump("/tetrisGameRankView", {
				rankActivityID = TetrisGameData:GetCurRankActivityID()
			})
		end
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		if self.activityID then
			JumpTools.OpenPageByJump("tetrisGameTaskView", {
				activityID = TetrisGameData:GetCurTaskActivityID()
			})
		end
	end)
	self:AddBtnListener(self.specialBtn_, nil, function()
		local var_14_0, var_14_1 = TetrisGameTools:CheckChapterIsOpen((TetrisGameTools:GetEndLessStageIDByActivityID(self.activityID)))

		if not var_14_0 then
			ShowTips(GetI18NText(var_14_1))

			return
		end

		JumpTools.OpenPageByJump("/tetrisGameSkillView", {
			isORD = false
		})
	end)
	self:AddBtnListener(self.chapter1Btn_, nil, function()
		local var_15_0 = TetrisGameTools:GetSimpleChapterIDListByActivityID(self.activityID)[1]
		local var_15_1, var_15_2 = TetrisGameTools:CheckChapterIsOpen(var_15_0)

		if not var_15_1 then
			ShowTips(GetI18NText(var_15_2))

			return
		end

		JumpTools.OpenPageByJump("/tetrisGameChooseStageView", {
			chapterID = var_15_0
		})
	end)
	self:AddBtnListener(self.chapter2Btn_, nil, function()
		local var_16_0 = TetrisGameTools:GetSimpleChapterIDListByActivityID(self.activityID)[2]
		local var_16_1, var_16_2 = TetrisGameTools:CheckChapterIsOpen(var_16_0)

		if not var_16_1 then
			ShowTips(GetI18NText(var_16_2))

			return
		end

		JumpTools.OpenPageByJump("/tetrisGameChooseStageView", {
			chapterID = var_16_0
		})
	end)
end

function TetrisGameMainView:Dispose()
	TetrisGameMainView.super.Dispose(self)
end

function TetrisGameMainView:RefreshChapterState()
	if self.activityID then
		local var_18_0 = TetrisGameData:GetSpecialStageInfo()

		if var_18_0 then
			self.specialScore.text = var_18_0.topScore > 0 and var_18_0.topScore or GetTips("NO_RECORD")
		end

		local var_18_1 = TetrisGameTools:GetSimpleChapterIDListByActivityID(self.activityID)
		local var_18_2 = TetrisGameTools:GetEndLessStageIDByActivityID(self.activityID)

		if #var_18_1 > 0 then
			self.chapter1Name_.text = ActivityTetrisGameChapterCfg[var_18_1[1]].name
			self.chapter2Name_.text = ActivityTetrisGameChapterCfg[var_18_1[2]].name

			local var_18_3, var_18_4 = TetrisGameTools:CheckChapterIsOpen(var_18_1[2])

			if not var_18_3 then
				self.lockController:SetSelectedState("state1")

				self.lockDesc.text = GetI18NText(var_18_4)
			else
				self.lockController:SetSelectedState("state0")
			end

			local var_18_5, var_18_6 = TetrisGameTools:CheckChapterIsOpen(var_18_2)

			self.chapter3Name_.text = ActivityTetrisGameChapterCfg[var_18_2].name

			if not var_18_5 then
				self.endlessLockController:SetSelectedState("state1")

				self.endlessLockDesc_.text = GetI18NText(var_18_6)
			else
				self.endlessLockController:SetSelectedState("state0")
			end
		end

		self:UpdataRedPoint()
	end
end

function TetrisGameMainView:UpdataRedPoint()
	local var_19_0 = TetrisGameTools:GetSimpleChapterIDListByActivityID(self.activityID)

	if #var_19_0 > 0 then
		for iter_19_0, iter_19_1 in ipairs(var_19_0) do
			if manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_CHAPTER, iter_19_1)) then
				manager.redPoint:SetRedPointIndependent(self["chapter" .. iter_19_0 .. "Btn_"].transform, true)
			else
				manager.redPoint:SetRedPointIndependent(self["chapter" .. iter_19_0 .. "Btn_"].transform, false)
			end
		end
	end
end

return TetrisGameMainView

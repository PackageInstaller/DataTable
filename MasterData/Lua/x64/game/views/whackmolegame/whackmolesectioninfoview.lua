local WhackMoleSectionInfoView = class("WhackMoleSectionInfoView", ReduxView)

function WhackMoleSectionInfoView:UIName()
	return "Widget/System/Summer2024/Summer2024_WhackMoleUI/SUWhackMoleInfoUI"
end

function WhackMoleSectionInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function WhackMoleSectionInfoView:Init()
	self:InitUI()
	self:AddListeners()
end

function WhackMoleSectionInfoView:InitUI()
	self:BindCfgUI()

	self.itemList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, MoleItem)
	self.lockController_ = self.lockCon_:GetController("lock")
	self.scoreController_ = self.controllerEx_:GetController("score")
	self.stageTypeController_ = self.controllerEx_:GetController("stageType")
end

function WhackMoleSectionInfoView:AddListeners()
	self:AddBtnListener(self.battleBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(self.activityID_) then
			return
		end

		self:OnClickBtn()
	end)
end

function WhackMoleSectionInfoView:OnEnter()
	self:RefreshData()
	self:RefreshUI()
end

function WhackMoleSectionInfoView:OnExit()
	self.whackMoleID_ = nil
end

function WhackMoleSectionInfoView:OnUpdate()
	if self.whackMoleID_ == self.params_.whackMoleID then
		return
	end

	self:RefreshData()
	self:RefreshUI()
end

function WhackMoleSectionInfoView:RefreshData()
	self.activityID_ = self.params_.activityID
	self.whackMoleID_ = self.params_.whackMoleID
	self.stageID_ = ActivityWhackMoleCfg[self.whackMoleID_].stage_id
	self.stageCfg_ = BattleWhackMoleStageCfg[self.stageID_]
	self.moleIDList_ = ActivityWhackMoleCfg[self.whackMoleID_].mole_list
end

function WhackMoleSectionInfoView:RefreshUI()
	self:RefreshStageInfo()
	self:RefreshLock()
	self:RefreshScore()
	self.itemList_:StartScroll(#self.moleIDList_)
end

function WhackMoleSectionInfoView:RefreshStageInfo()
	self.sectionName_.text = GetI18NText(self.stageCfg_.name)
	self.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, self.stageCfg_.background_1))

	if ActivityWhackMoleCfg[self.whackMoleID_].type == WhackMoleConst.STAGE_TYPE.INFINITY then
		self.stageDescText_.text = BattleWhackMoleStageCfg[ActivityWhackMoleCfg[self.whackMoleID_].stage_id].tips

		self.stageTypeController_:SetSelectedState("infinity")
	else
		self.targetScoreText_.text = ActivityWhackMoleCfg[self.whackMoleID_].target_point
		self.limitTimeText_.text = ActivityWhackMoleCfg[self.whackMoleID_].limit_time .. GetTips("SECOND")

		self.stageTypeController_:SetSelectedState("normal")
	end
end

function WhackMoleSectionInfoView:RefreshLock()
	local var_13_0 = WhackMoleTools.GetStageIsLock(self.whackMoleID_)

	self.lockController_:SetSelectedState(tostring(var_13_0))

	if var_13_0 then
		self.lockTipsText_.text = GetTips("ACTIVITY_ZUMA_OPEN_FRONT")
	end
end

function WhackMoleSectionInfoView:RefreshScore()
	if WhackMoleData:GetStageScore(self.whackMoleID_) <= 0 then
		self.scoreController_:SetSelectedState("off")
	else
		self.scoreController_:SetSelectedState("on")

		self.maxScoreText_.text = WhackMoleData:GetStageScore(self.whackMoleID_)
	end
end

function WhackMoleSectionInfoView:IndexItem(arg_15_1, arg_15_2)
	arg_15_2:SetData(arg_15_1, self.moleIDList_[arg_15_1])
	arg_15_2:RegisterClick(function(arg_16_0)
		JumpTools.OpenPageByJump("whackMoleDesc", {
			idList = self.moleIDList_,
			index = arg_16_0
		})
	end)
end

function WhackMoleSectionInfoView:OnClickBtn()
	WhackMoleAction.LaunchBattle(self.whackMoleID_)
end

function WhackMoleSectionInfoView:Dispose()
	WhackMoleSectionInfoView.super.Dispose(self)
	self.itemList_:Dispose()

	self.itemList_ = nil
end

return WhackMoleSectionInfoView

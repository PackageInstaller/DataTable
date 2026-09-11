local CatchDuckSelectionInfoView = class("CatchDuckSelectionInfoView", ReduxView)

function CatchDuckSelectionInfoView:UIName()
	return "Widget/System/Summer2024/Summer2024_Duck/SUDuckInfoUI"
end

function CatchDuckSelectionInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function CatchDuckSelectionInfoView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CatchDuckSelectionInfoView:InitUI()
	self:BindCfgUI()

	self.duckList_ = LuaList.New(handler(self, self.indexItem), self.duckListGo_, DuckItem)
	self.lockController_ = self.lockCon_:GetController("lock")
	self.maxController_ = self.controllerEx_:GetController("Recordhigh")
	self.descController_ = self.controllerEx_:GetController("mode")
end

function CatchDuckSelectionInfoView:AddUIListeners()
	self:AddBtnListener(self.btnBattle_, nil, function()
		CatchDuckData:SetEnterIndex(self.params_.index)
		BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_CATCH_DUCK, self.stageData_.stage_id)))
	end)
end

function CatchDuckSelectionInfoView:OnEnter()
	self.stageData_ = self.params_.stageData

	self:RefreshData()
	self:RefreshUI()
end

function CatchDuckSelectionInfoView:OnUpdate()
	self.stageData_ = self.params_.stageData

	self:RefreshData()
	self:RefreshUI()
end

function CatchDuckSelectionInfoView:RefreshData()
	self.stageCfg_ = BattleCatchDuckStageCfg[self.stageData_.stage_id]
	self.targetScore_ = self.stageData_.target_score
	self.limitTime_ = self.stageData_.limit_time
	self.duckType_ = self.stageData_.duck_type
end

function CatchDuckSelectionInfoView:RefreshUI()
	self.sectionName_.text = GetI18NText(self.stageCfg_.name)
	self.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, self.stageCfg_.background_1))
	self.targetScoreText_.text = string.format(GetTips("DUCK_NUM"), self.targetScore_)
	self.limitTimeText_.text = manager.time:DescCDTime(self.limitTime_)

	if self.stageData_.score then
		self.maxController_:SetSelectedState("recordHigh")

		self.maxScoreText_.text = self.stageData_.isEndless and string.format(GetTips("DUCK_NUM"), self.stageData_.score) or manager.time:DescCDTime(self.stageData_.seconds)
	else
		self.maxController_:SetSelectedState("empty")
	end

	self.descController_:SetSelectedState(self.stageData_.isEndless and "endless" or "general")

	self.descText_.text = self.stageCfg_.tips

	self.lockController_:SetSelectedState(tostring(self.stageData_.isLock))
	self.duckList_:StartScroll(#self.duckType_)
end

function CatchDuckSelectionInfoView:indexItem(arg_11_1, arg_11_2)
	arg_11_2:RefreshData(arg_11_1, self.duckType_[arg_11_1], true)
	arg_11_2:RegisterClick(function(arg_12_0)
		JumpTools.OpenPageByJump("catchDuckInfoPop", {
			duckList = self.duckType_,
			index = arg_12_0
		})
	end)
end

function CatchDuckSelectionInfoView:Dispose()
	CatchDuckSelectionInfoView.super.Dispose(self)
	self.duckList_:Dispose()
end

return CatchDuckSelectionInfoView

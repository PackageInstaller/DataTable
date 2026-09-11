local ChapterPlot19MapLocationStageItem = class("ChapterPlot19MapLocationStageItem", ReduxView)

function ChapterPlot19MapLocationStageItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.stageTypeController_ = self.controllerEx_:GetController("type")
	self.clearController_ = self.controllerEx_:GetController("clear")
end

function ChapterPlot19MapLocationStageItem:SetData(arg_2_1, arg_2_2)
	self.chapterID_ = arg_2_1
	self.stageInfo_ = arg_2_2

	self:RefreshUI()
end

function ChapterPlot19MapLocationStageItem:RefreshUI()
	if self.stageInfo_.stageType == BattleConst.PLOT_19_STAGE_TYPE.EVENT then
		local var_3_0 = self.stageInfo_.id

		self.nameText_.text = StageArchiveCfg[self.stageInfo_.id].name

		self.stageTypeController_:SetSelectedState("event")
		self.clearController_:SetSelectedState(tostring(BattleStageData:HasReadLocationEvent(var_3_0) ~= nil))

		if ChapterTools.IsUnlockEvent(var_3_0) then
			self:Show(true)
		else
			self:Show(false)
		end
	else
		local var_3_1 = self.stageInfo_.id

		self.nameText_.text = BattleStageTools.GetStageCfg(ChapterCfg[self.chapterID_].type, self.stageInfo_.id).name

		if self.stageInfo_.stageType == BattleConst.PLOT_19_STAGE_TYPE.MAIN_STORY then
			self.stageTypeController_:SetSelectedState("main")
		else
			self.stageTypeController_:SetSelectedState("side")
		end

		local var_3_2 = BattleStageData:GetStageData()[var_3_1]
		local var_3_3 = false

		if var_3_2 then
			self:Show(true)

			if var_3_2.clear_times > 0 then
				var_3_3 = true
			end
		else
			self:Show(false)
		end

		self.clearController_:SetSelectedState(tostring(var_3_3))
	end
end

function ChapterPlot19MapLocationStageItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.stageInfo_.stageType == BattleConst.PLOT_19_STAGE_TYPE.EVENT then
			BattleStageAction.UpdateLocationEvent(self.stageInfo_.id)
			JumpTools.OpenPageByJump("gameHelpLong", {
				title = StageArchiveCfg[self.stageInfo_.id].name,
				content = formatText(StageArchiveCfg[self.stageInfo_.id].desc)
			})
		else
			self:Go("chapter19SectionInfo", {
				section = self.stageInfo_.id,
				sectionType = ChapterCfg[self.chapterID_].type
			})
		end
	end)
end

function ChapterPlot19MapLocationStageItem:Show(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)

	if arg_6_1 then
		self.transform_:SetAsLastSibling()
	end
end

function ChapterPlot19MapLocationStageItem:Dispose()
	ChapterPlot19MapLocationStageItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return ChapterPlot19MapLocationStageItem

local SummerStageBaseItem = class("SummerStageBaseItem", ReduxView)

function SummerStageBaseItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:InitUI()
end

function SummerStageBaseItem:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.controllerTransform_, "name")
	self.clearController_ = ControllerUtil.GetController(self.controllerTransform_, "getn")
end

function SummerStageBaseItem:Dispose()
	SummerStageBaseItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function SummerStageBaseItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		self:OnClick()
	end)
end

function SummerStageBaseItem:SetData(arg_6_1, arg_6_2)
	self.stageID_ = arg_6_1
	self.chapterID_ = arg_6_2

	self:RefreshLockData(arg_6_1, arg_6_2)
	self:RefreshData()
	self:RefreshUI()
end

function SummerStageBaseItem:RefreshLockData(arg_7_1, arg_7_2)
	self.isLock_ = false

	for iter_7_0, iter_7_1 in pairs(GameSetting.activity_plot_unlock.value) do
		if iter_7_1[1][1] == arg_7_2 and iter_7_1[1][2] == arg_7_1 then
			for iter_7_2, iter_7_3 in ipairs(iter_7_1[2]) do
				self.isLock_ = ChessTools.GetChapterProgress(iter_7_3) < 100

				if self.isLock_ then
					self.preStageID_ = iter_7_3

					return
				end
			end

			return
		end
	end
end

function SummerStageBaseItem:IsOpenSectionInfo()
	return self:IsOpenRoute("storyStageInfoActivity")
end

function SummerStageBaseItem:GetPosition()
	return (BattleActivityStoryStageCfg[self.stageID_] or nil) and (BattleActivityStoryStageCfg[self.stageID_].position or {
		0,
		0
	})
end

function SummerStageBaseItem:RefreshData()
	local var_10_0 = StoryStageActivityData:GetStageData(self.chapterID_)[self.stageID_]

	self.clearTimes_ = var_10_0 and var_10_0.clear_times or 0
end

function SummerStageBaseItem:OnClick()
	if self.isLock_ then
		ShowTips("ACTIVITY_FINISH_ALL_SUMMER_CHESS")
	else
		StoryStageActivityData:SaveHistoryStage(self.chapterID_, self.stageID_)
		self:Go("storyStageInfoActivity", {
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY,
			section = self.stageID_,
			chapterID = self.chapterID_
		})
	end
end

function SummerStageBaseItem:RefreshUI()
	local var_12_0 = self:GetPosition()

	self.transform_.localPosition = Vector3(var_12_0[1], var_12_0[2], 0)

	self:RefreshText()

	if self.isLock_ then
		self.controller_:SetSelectedState("off")
	else
		self.controller_:SetSelectedState("on")
	end

	if self.clearTimes_ > 0 then
		self.clearController_:SetSelectedState("get")
	else
		self.clearController_:SetSelectedState("nor")
	end

	self:Show(true)
end

function SummerStageBaseItem:GetLocalPosition()
	return self.transform_.localPosition
end

function SummerStageBaseItem:SelectorItem(arg_14_1)
	if self.stageID_ == arg_14_1 and self:IsOpenSectionInfo() then
		self.controller_:SetSelectedState("selected")
	elseif self.isLock_ then
		self.controller_:SetSelectedState("off")
	else
		self.controller_:SetSelectedState("on")
	end
end

function SummerStageBaseItem:Show(arg_15_1)
	SetActive(self.gameObject_, arg_15_1)
end

function SummerStageBaseItem:RefreshText()
	return
end

return SummerStageBaseItem

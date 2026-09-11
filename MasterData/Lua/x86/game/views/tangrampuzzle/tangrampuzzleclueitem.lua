local PuzzleNewCheckPoint = class("PuzzleNewCheckPoint", ReduxView)

function PuzzleNewCheckPoint:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:Init()
end

function PuzzleNewCheckPoint:Init()
	self:InitUI()
	self:AddUIListener()
end

function PuzzleNewCheckPoint:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.tipsController_ = ControllerUtil.GetController(self.transform_, "tips")
end

function PuzzleNewCheckPoint:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if not self.unlock_ then
			return
		end

		if TangramPuzzleData:GetCurClueDic(self.activityID_)[self.id_] == true then
			if TangramPuzzleData:GetSelecteClue(self.activityID_, self.id_) == true then
				TangramPuzzleData:SetSelecteClue(self.activityID_, self.id_, false)
				self.tipsController_:SetSelectedState("off")
				self.statusController_:SetSelectedState("on")
			else
				TangramPuzzleData:SetSelecteClue(self.activityID_, self.id_, true)
				self.tipsController_:SetSelectedState("on")
				self.statusController_:SetSelectedState("normal")
				self.animator_:Play("puzzleClueTemplate", -1, 0)
				self.animator_:Update(0)
			end
		else
			TangramPuzzleAction.Operation(self.activityID_, TangramPuzzleAction.OPERATION_TYPE.CLUE, {
				clueID = self.id_
			}, function()
				self.statusController_:SetSelectedState("normal")
				TangramPuzzleData:SetSelecteClue(self.activityID_, self.id_, true)
				self.tipsController_:SetSelectedState("on")
				self.animator_:Play("puzzleClueTemplate", -1, 0)
				self.animator_:Update(0)
			end)
		end
	end)
end

function PuzzleNewCheckPoint:SetActive(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)

	if arg_7_1 == false and self.descRebuildTimer_ then
		self.descRebuildTimer_:Stop()

		self.descRebuildTimer_ = nil
	end
end

function PuzzleNewCheckPoint:Dispose()
	self.gameObject_ = nil
	self.transform_ = nil

	PuzzleNewCheckPoint.super.Dispose(self)
end

function PuzzleNewCheckPoint:SetData(arg_9_1, arg_9_2)
	self.activityID_ = arg_9_1
	self.id_ = arg_9_2
	self.regionType_ = PuzzleNewClueCfg[self.id_].area_type

	self:RefreshUI()
end

function PuzzleNewCheckPoint:RefreshUI()
	self.descText_.text = PuzzleNewClueCfg[self.id_].clue_desc

	self:RefreshStatus()
end

function PuzzleNewCheckPoint:RefreshStatus()
	self.unlock_ = TangramPuzzleTools.CheckRegionAllRightByType(self.activityID_, self.regionType_)

	SetActive(self.gameObject_, self.unlock_ == true)

	if self.unlock_ == true then
		if TangramPuzzleData:GetCurClueDic(self.activityID_)[self.id_] == true then
			self.statusController_:SetSelectedState("off")
			self.statusController_:SetSelectedState("on")

			if TangramPuzzleData:GetSelecteClue(self.activityID_, self.id_) == true then
				self.tipsController_:SetSelectedState("on")
				self.statusController_:SetSelectedState("normal")
				self:RebuildDescLayout()
				self.animator_:Play("puzzleClueTemplate", -1, 99999)
			else
				self.tipsController_:SetSelectedState("off")
			end
		else
			self.statusController_:SetSelectedState("off")
			self.tipsController_:SetSelectedState("off")
		end
	end
end

function PuzzleNewCheckPoint:SetTipsController(arg_12_1)
	if self.unlock_ == true and self.tipsController_:GetSelectedState() == "on" then
		self.tipsController_:SetSelectedState(arg_12_1 == true and "on" or "off")
		self.statusController_:SetSelectedState(arg_12_1 == true and "normal" or "on")
		TangramPuzzleData:SetSelecteClue(self.activityID_, self.id_, arg_12_1)
		self:RebuildDescLayout()
	end
end

function PuzzleNewCheckPoint:RebuildDescLayout()
	if self.descRebuildTimer_ then
		self.descRebuildTimer_:Stop()

		self.descRebuildTimer_ = nil
	end

	self.descRebuildTimer_ = Timer.New(function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.descText_.transform)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.descContentTrans_)

		if self.descRebuildTimer_ then
			self.descRebuildTimer_:Stop()

			self.descRebuildTimer_ = nil
		end
	end, 0.1, 1)

	self.descRebuildTimer_:Start()
end

return PuzzleNewCheckPoint

local PuzzleNewCheckPoint = class("PuzzleNewCheckPoint", ReduxView)

function PuzzleNewCheckPoint:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.statusConst_ = {
		RECEIVED = 2,
		FINISH = 1,
		UNFINISH = 0
	}

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
end

function PuzzleNewCheckPoint:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if PuzzleNewData:GetCurCheckList(self.activityID_)[self.id_] == true and PuzzleNewData:GetSelecteCheckPoint(self.activityID_, self.id_) then
			PuzzleNewData:SetSelecteCheckPoint(self.activityID_, self.id_, false)
			AnimatorTools.PlayAnimatorWithCallback(self.animator_, "puzzleClueTemplate_close", function()
				self:RefreshStatus()
			end)

			return
		end

		PuzzleNewAction.Operation(self.activityID_, PuzzleNewAction.OPERATION_TYPE.CHECK, function()
			PuzzleNewData:SetSelecteCheckPoint(self.activityID_, self.id_, true)
			self:RefreshStatus()
			self.animator_:Play("puzzleClueTemplate", -1, 0)
			self.animator_:Update(0)

			if self.clickCallback_ then
				self.clickCallback_(self.id_)
			end
		end, self.id_)
	end)
end

function PuzzleNewCheckPoint:SetActive(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)

	if arg_8_1 == false and self.descRebuildTimer_ then
		self.descRebuildTimer_:Stop()

		self.descRebuildTimer_ = nil
	end
end

function PuzzleNewCheckPoint:Dispose()
	self.clickCallback_ = nil
	self.gameObject_ = nil
	self.transform_ = nil

	if self.descRebuildTimer_ then
		self.descRebuildTimer_:Stop()

		self.descRebuildTimer_ = nil
	end

	PuzzleNewCheckPoint.super.Dispose(self)
end

function PuzzleNewCheckPoint:SetData(arg_10_1, arg_10_2)
	self.activityID_ = arg_10_1
	self.id_ = arg_10_2
	self.descText_.text = PuzzleNewClueCfg[self.id_].clue_desc

	self:RebuildDescLayout()
	self:RefreshStatus()
end

function PuzzleNewCheckPoint:RefreshStatus()
	if PuzzleNewData:GetCurCheckList(self.activityID_)[self.id_] == true then
		if PuzzleNewData:GetSelecteCheckPoint(self.activityID_, self.id_) then
			self.statusController_:SetSelectedState("finish")
			self.animator_:Play("puzzleClueTemplate", -1, 99999)
		else
			self.statusController_:SetSelectedState("tips")
		end
	elseif PuzzleNewData:GetCheckTipsList(self.activityID_)[self.id_] == true then
		self.statusController_:SetSelectedState("tips")
	else
		self.statusController_:SetSelectedState("none")
	end
end

function PuzzleNewCheckPoint:RegistClickCallback(arg_12_1)
	self.clickCallback_ = arg_12_1
end

function PuzzleNewCheckPoint:RebuildDescLayout()
	if self.descRebuildTimer_ then
		self.descRebuildTimer_:Stop()

		self.descRebuildTimer_ = nil
	end

	self.descRebuildTimer_ = FrameTimer.New(function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.descContentTrans_)

		if self.descRebuildTimer_ then
			self.descRebuildTimer_:Stop()

			self.descRebuildTimer_ = nil
		end
	end, 1, 1)

	self.descRebuildTimer_:Start()
end

return PuzzleNewCheckPoint

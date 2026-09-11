local SummerChessBoardExploreBtnView = class("SummerChessBoardExploreBtnView", ReduxView)

function SummerChessBoardExploreBtnView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.updateActivityHandler_ = handler(self, self.RefreshUI)
end

function SummerChessBoardExploreBtnView:OnEnter()
	manager.notify:RegistListener(ACTIVITY_UPDATE, self.updateActivityHandler_)
	self:RefreshUI()
end

function SummerChessBoardExploreBtnView:OnExit()
	manager.notify:RemoveListener(ACTIVITY_UPDATE, self.updateActivityHandler_)
end

function SummerChessBoardExploreBtnView:Dispose()
	self.updateActivityHandler_ = nil

	SummerChessBoardExploreBtnView.super.Dispose(self)
end

function SummerChessBoardExploreBtnView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if AssignmentCfg[self.taskID_] == nil then
			return
		end

		JumpTools.JumpToPage(AssignmentCfg[self.taskID_].source)
	end)
end

function SummerChessBoardExploreBtnView:RefreshUI()
	local var_7_0 = SummerChessBoardTools.GetSummerChesssBoardTaskExploreID()

	if var_7_0 == 0 then
		SetActive(self.gameObject_, false)

		return
	end

	SetActive(self.gameObject_, true)

	self.taskID_ = var_7_0
	self.titleText_.text = AssignmentCfg[var_7_0].name
	self.descText_.text = AssignmentCfg[var_7_0].desc
end

return SummerChessBoardExploreBtnView

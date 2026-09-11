local SummerChessBoardTaskBtnView = class("SummerChessBoardTaskBtnView", ReduxView)

function SummerChessBoardTaskBtnView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.completeController_ = self.controllerEx_:GetController("complete")
end

function SummerChessBoardTaskBtnView:OnEnter()
	manager.redPoint:bindUIandKey(self.transform_, (string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_TASK_TREE, ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS].activity_theme)))
	self:RefreshUI()
end

function SummerChessBoardTaskBtnView:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_, (string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_TASK_TREE, ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS].activity_theme)))
end

function SummerChessBoardTaskBtnView:Dispose()
	SummerChessBoardTaskBtnView.super.Dispose(self)
end

function SummerChessBoardTaskBtnView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.OpenPageByJump("/summerChessBoardTask", {})
	end)
end

function SummerChessBoardTaskBtnView:RefreshUI()
	self.phaseText_.text = string.format(GetTips("CULTIVATE_HERO_REWARD"), SummerChessBoardTools.GetTaskRewardPhase())

	local var_7_0 = ItemTools.getItemNum(SummerChessBoardTools.GetPointItemID())
	local var_7_1 = SummerChessBoardTools.GetNextPhasePointValue()

	SetActive(self.gameObject_, var_7_1 ~= 0)

	self.exploreNumText_.text = var_7_0
	self.nextNumText_.text = var_7_1

	self.completeController_:SetSelectedState(tostring(var_7_1 <= var_7_0))

	self.slider_.value = var_7_0 / var_7_1
end

return SummerChessBoardTaskBtnView

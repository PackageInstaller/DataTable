local SummerChessBoardLevelTaskItem = class("SummerChessBoardLevelTaskItem", ReduxView)

function SummerChessBoardLevelTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SummerChessBoardLevelTaskItem:Init()
	self:InitUI()
end

function SummerChessBoardLevelTaskItem:InitUI()
	self:BindCfgUI()

	self.tipsController = self.tipsControllerEx_:GetController("showState")
end

function SummerChessBoardLevelTaskItem:SetData(arg_4_1)
	self.titleText_.text = AssignmentCfg[arg_4_1].desc
	self.nameText_.text = AssignmentCfg[arg_4_1].name

	if AssignmentCfg[arg_4_1].need > TaskData2:GetTask(arg_4_1).progress then
		self.tipsController:SetSelectedState("normal")
	else
		self.tipsController:SetSelectedState("finish")
	end
end

function SummerChessBoardLevelTaskItem:Dispose()
	SummerChessBoardLevelTaskItem.super.Dispose(self)
end

return SummerChessBoardLevelTaskItem

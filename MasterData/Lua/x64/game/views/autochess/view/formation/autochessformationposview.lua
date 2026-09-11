local AutoChessFormationPosView = class("AutoChessFormationPosView", ReduxView)

function AutoChessFormationPosView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AutoChessFormationPosView:Init()
	self:BindCfgUI()

	self.statusController_ = self.controllerEx_:GetController("status")
	self.enterController_ = self.controllerEx_:GetController("enter")
end

function AutoChessFormationPosView:GetChessContainerTrans()
	return self.chessContainerTrans_
end

function AutoChessFormationPosView:SetStatus(arg_4_1)
	self.statusController_:SetSelectedState(arg_4_1)
end

function AutoChessFormationPosView:SetEnter(arg_5_1)
	self.enterController_:SetSelectedState(arg_5_1 and "enter" or "exit")
end

return AutoChessFormationPosView

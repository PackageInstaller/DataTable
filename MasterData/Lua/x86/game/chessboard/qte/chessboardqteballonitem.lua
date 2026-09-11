local ChessBoardQTEBallonItem = class("ChessBoardQTEBallonItem", ReduxView)

function ChessBoardQTEBallonItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index = arg_1_2

	self:Init()
end

function ChessBoardQTEBallonItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBoardQTEBallonItem:InitUI()
	self:BindCfgUI()

	self.numText_.text = " "
end

function ChessBoardQTEBallonItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickCallback then
			self:clickCallback()
		end
	end)
end

function ChessBoardQTEBallonItem:SetBtnClick(arg_6_1)
	self.clickCallback = arg_6_1
end

function ChessBoardQTEBallonItem:ClickEffect()
	self.ani_:Play("ui_bubbIe_blow", 0, 0)
	manager.audio:PlayEffect("minigame_activity_3_4", "minigame_activity_3_4_chess_qte02", "")
end

function ChessBoardQTEBallonItem:SetPos(arg_8_1)
	self.transform_.localPosition = arg_8_1
end

function ChessBoardQTEBallonItem:Dispose()
	self.super.Dispose(self)
end

return ChessBoardQTEBallonItem

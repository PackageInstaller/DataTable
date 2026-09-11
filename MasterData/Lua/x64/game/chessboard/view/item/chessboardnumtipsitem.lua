local ChessBoardNumTipsItem = class("ChessBoardNumTipsItem", ReduxView)

function ChessBoardNumTipsItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ChessBoardNumTipsItem:Init()
	self:InitUI()
end

function ChessBoardNumTipsItem:InitUI()
	self:BindCfgUI()

	self.stateController = self.controller_:GetController("state")
end

function ChessBoardNumTipsItem:RefreshUI(arg_4_1)
	SetActive(self.gameObject_, true)

	self.goodText_.text = string.format("+%s", arg_4_1)
	self.badText_.text = arg_4_1

	self.stateController:SetSelectedState(arg_4_1 > 0 and "up" or "down")

	if arg_4_1 > 0 then
		manager.audio:PlayEffect("minigame_activity_3_3", "minigame_activity_3_3_chess_gridui_getcoin", "")
	else
		manager.audio:PlayEffect("minigame_activity_3_3", "minigame_activity_3_3_chess_gridui_losecoin", "")
	end

	self:AddTimer()
end

function ChessBoardNumTipsItem:DelTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function ChessBoardNumTipsItem:AddTimer()
	self:DelTimer()

	self.timer = Timer.New(function()
		SetActive(self.gameObject_, false)
	end, 1.5)

	self.timer:Start()
end

function ChessBoardNumTipsItem:Dispose()
	self:DelTimer()
	self.super.Dispose(self)
end

return ChessBoardNumTipsItem

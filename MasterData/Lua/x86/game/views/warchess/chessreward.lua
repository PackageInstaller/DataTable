local WarChessReward = class("WarChessReward", ReduxView)

function WarChessReward:UIName()
	return "UI/WarChess/WarChessReward"
end

function WarChessReward:UIParent()
	return manager.ui.uiPop.transform
end

function WarChessReward:Init()
	self:InitUI()
	self:AddUIListener()
end

function WarChessReward:InitUI()
	self:BindCfgUI()
end

function WarChessReward:AddUIListener()
	return
end

function WarChessReward:OnEnter()
	return
end

function WarChessReward:OnExit()
	return
end

function WarChessReward:Dispose()
	WarChessReward.super.Dispose(self)
end

return WarChessReward

local GameMobileOperationView = class("GameMobileOperationView", ReduxView)

function GameMobileOperationView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GameMobileOperationView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GameMobileOperationView:InitUI()
	self:BindCfgUI()
end

function GameMobileOperationView:AddUIListener()
	self:AddBtnListener(self.battleSetBtn_, nil, function()
		self:Go("battleUIAdjust", {})
	end)
end

function GameMobileOperationView:AddEventListeners()
	return
end

function GameMobileOperationView:OnEnter()
	self:AddEventListeners()
end

function GameMobileOperationView:SaveData()
	return
end

function GameMobileOperationView:CheckDataChange()
	return false
end

function GameMobileOperationView:RecoverTmpData()
	return
end

function GameMobileOperationView:OnExit()
	self:RemoveAllEventListener()
end

function GameMobileOperationView:Dispose()
	GameMobileOperationView.super.Dispose(self)
end

function GameMobileOperationView:UpdatePageData()
	return
end

return GameMobileOperationView

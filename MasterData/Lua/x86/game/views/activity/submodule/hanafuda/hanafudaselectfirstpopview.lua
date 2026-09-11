local HanafudaSelectFirstPopView = class("HanafudaSelectFirstPopView", ReduxView)

function HanafudaSelectFirstPopView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaPopUI"
end

function HanafudaSelectFirstPopView:UIParent()
	return manager.ui.uiPop.transform
end

function HanafudaSelectFirstPopView:Init()
	self:InitUI()
	self:AddUIListener()

	self.typeController_ = ControllerUtil.GetController(self.transform_, "type")
end

function HanafudaSelectFirstPopView:InitUI()
	self:BindCfgUI()
end

function HanafudaSelectFirstPopView:AddUIListener()
	self:AddBtnListener(self.enemyFirstBtn_, nil, function()
		if self.type_ == 1 then
			HanafudaData:StartGame(HanafudaData.GAME_STATE.COMPUTER_TURN)
			self:Back()
		elseif self.type_ == 2 then
			HanafudaData:SetComputerDiffculty(1)
			manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_enemy", "")
			self:Back()
		end
	end)
	self:AddBtnListener(self.playerFirstBtn_, nil, function()
		if self.type_ == 1 then
			HanafudaData:StartGame(HanafudaData.GAME_STATE.PLAYER_TURN)
			self:Back()
		elseif self.type_ == 2 then
			HanafudaData:SetComputerDiffculty(2)
			self:Back()
		end
	end)
end

function HanafudaSelectFirstPopView:OnEnter()
	self.callback = self.params_.callback
	self.type_ = self.params_.type

	self.typeController_:SetSelectedState(self.type_)
end

function HanafudaSelectFirstPopView:OnExit()
	self.callback()
end

function HanafudaSelectFirstPopView:Dispose()
	HanafudaSelectFirstPopView.super.Dispose(self)
end

return HanafudaSelectFirstPopView

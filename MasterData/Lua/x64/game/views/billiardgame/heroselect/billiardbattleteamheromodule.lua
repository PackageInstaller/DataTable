local BilliardBattleTeamHeroModule = class("BilliardBattleTeamHeroModule", ReduxView)

function BilliardBattleTeamHeroModule:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.context = arg_1_2
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.slotId = arg_1_3

	self:Init()
end

function BilliardBattleTeamHeroModule:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.statusController = self.controller_:GetController("status")
	self.exchangeController = self.controller_:GetController("exchange")
end

function BilliardBattleTeamHeroModule:AddUIListener()
	self:AddBtnListener(self.exchangeBtn_, nil, function()
		return
	end)
	self:AddBtnListener(self.clickBtn_, nil, function()
		self:OnMaskClick()
	end)

	self.onAddHandle = handler(self, self.OnAddHeroHandle)

	manager.notify:RegistListener(BilliardGameEvent.BILLIARD_POP_VIEW_ADD_HERO, self.onAddHandle)

	self.onRemoveHandle = handler(self, self.OnRemoveHeroHandle)

	manager.notify:RegistListener(BilliardGameEvent.BILLIARD_POP_VIEW_REMOVE_HERO, self.onRemoveHandle)

	self.onExchangeHeroChangeHandle = handler(self, self.OnExchangeHeroChangeHandle)

	manager.notify:RegistListener(BilliardGameEvent.BILLIARD_POP_VIEW_EXCHANGE_HERO, self.onExchangeHeroChangeHandle)
end

function BilliardBattleTeamHeroModule:OnMaskClick()
	if self.context:IsInExchange() then
		self.context:ExchangeSlot(self.slotId)
	else
		local var_6_0 = self.context:GetSlotHero(self.slotId)

		if var_6_0 then
			self.context:SelectHero(var_6_0)
		end
	end
end

function BilliardBattleTeamHeroModule:OnAddHeroHandle()
	self:OnRender()
end

function BilliardBattleTeamHeroModule:OnRemoveHeroHandle()
	self:OnRender()
end

function BilliardBattleTeamHeroModule:OnExchangeHeroChangeHandle()
	self:OnRender()
end

function BilliardBattleTeamHeroModule:OnRender()
	local var_10_0 = self.context:GetSlotHero(self.slotId)

	if var_10_0 then
		self.heroImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. SummerPubHeroCfg[var_10_0].profile_icon_ball)

		self.statusController:SetSelectedState("on")
	else
		self.statusController:SetSelectedState("add")
	end

	self:UpdateExchangeStatus()
end

function BilliardBattleTeamHeroModule:UpdateExchangeStatus()
	if self.context:GetExchangeHeroId() then
		self.exchangeController:SetSelectedState("on")
	else
		self.exchangeController:SetSelectedState("off")
	end
end

function BilliardBattleTeamHeroModule:Dispose()
	manager.notify:RemoveListener(BilliardGameEvent.BILLIARD_POP_VIEW_ADD_HERO, self.onAddHandle)
	manager.notify:RemoveListener(BilliardGameEvent.BILLIARD_POP_VIEW_REMOVE_HERO, self.onRemoveHandle)
	manager.notify:RemoveListener(BilliardGameEvent.BILLIARD_POP_VIEW_EXCHANGE_HERO, self.onExchangeHeroChangeHandle)
	BilliardBattleTeamHeroModule.super.Dispose(self)
end

return BilliardBattleTeamHeroModule

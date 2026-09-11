local BilliardBattleHeroPopModule = class("BilliardBattleHeroPopModule", ReduxView)

function BilliardBattleHeroPopModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function BilliardBattleHeroPopModule:Init()
	self.heroId = -1
	self.context = nil
	self.isInSelected = false

	self:BindCfgUI()
	self:AddUIListener()

	self.statusController = self.controller_:GetController("status")
	self.praiseController = self.controller_:GetController("praise")
	self.selectController = self.controller_:GetController("select")
	self.grayController = self.controller_:GetController("gray")
	self.morphologyController = self.controller_:GetController("morphology")

	self:UpdateSelectedStatus()
end

function BilliardBattleHeroPopModule:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if not self.context:IsHeroInSlot(self.heroId) and self.context:SlotIsFull() then
			self.context.waitExchangeId = self.heroId

			manager.notify:Invoke(BilliardGameEvent.BILLIARD_POP_VIEW_EXCHANGE_HERO)
		else
			self.context.waitExchangeId = nil

			if self.context:IsHeroInSlot(self.heroId) then
				self.context:RemoveHero(self.heroId)
			else
				self.context:AddHeroToSlot(self.heroId)
			end
		end

		self.context:SelectHero(self.heroId)
	end)

	self.onAddHandle = handler(self, self.OnAddHeroHandle)

	manager.notify:RegistListener(BilliardGameEvent.BILLIARD_POP_VIEW_ADD_HERO, self.onAddHandle)

	self.onRemoveHandle = handler(self, self.OnRemoveHeroHandle)

	manager.notify:RegistListener(BilliardGameEvent.BILLIARD_POP_VIEW_REMOVE_HERO, self.onRemoveHandle)

	self.onSelectHeroChangeHandle = handler(self, self.OnSelectHeroChange)

	manager.notify:RegistListener(BilliardGameEvent.BILLIARD_POP_VIEW_SELECT_HERO, self.onSelectHeroChangeHandle)

	self.onExchangeHeroChangeHandle = handler(self, self.OnExchangeHeroChangeHandle)

	manager.notify:RegistListener(BilliardGameEvent.BILLIARD_POP_VIEW_EXCHANGE_HERO, self.onExchangeHeroChangeHandle)
end

function BilliardBattleHeroPopModule:OnAddHeroHandle(arg_5_1)
	if self.heroId == arg_5_1 then
		self:RefreshUI()
	end
end

function BilliardBattleHeroPopModule:OnRemoveHeroHandle(arg_6_1)
	if self.heroId == arg_6_1 then
		self:RefreshUI()
	end
end

function BilliardBattleHeroPopModule:OnSelectHeroChange(arg_7_1)
	self.isInSelected = self.context:IsHeroInSelected(self.heroId)

	self:UpdateSelectedStatus()
end

function BilliardBattleHeroPopModule:OnExchangeHeroChangeHandle()
	self:UpdateExchangeStatus()
end

function BilliardBattleHeroPopModule:OnRenderHero(arg_9_1, arg_9_2)
	self.heroId = arg_9_1
	self.context = arg_9_2

	self:RefreshUI()
end

function BilliardBattleHeroPopModule:RefreshUI()
	if self.context:IsHeroInSlot(self.heroId) then
		self.statusController:SetSelectedState("Deploy")
	else
		self.statusController:SetSelectedState("normal")
	end

	if self.showTimer then
		self.showTimer:Stop()

		self.showTimer = nil
	end

	self.unlockEff_:SetActive(false)

	self.showTimer = Timer.New(function()
		if not getData("BilliardGame", "BilliardGame_Hero_Unlock" .. self.heroId) then
			self.unlockEff_:SetActive(true)
			saveData("BilliardGame", "BilliardGame_Hero_Unlock" .. self.heroId, true)
		end
	end, 0.5, 1)

	self.showTimer:Start()

	self.isInSelected = self.context:IsHeroInSelected(self.heroId)

	self:UpdateSelectedStatus()
	self:UpdateExchangeStatus()
	self:UpdateRecommend()

	self.heroIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. SummerPubHeroCfg[self.heroId].profile_icon_ball)

	if SummerPubHeroCfg[self.heroId].pinball_hero_type == 3 then
		self.morphologyController:SetSelectedState("auxiliary")
	else
		self.morphologyController:SetSelectedState("attack")
	end
end

function BilliardBattleHeroPopModule:UpdateRecommend()
	local var_12_0 = false

	for iter_12_0, iter_12_1 in ipairs(BilliardStageCfg[self.context.curStage].recommend_hero) do
		if iter_12_1 == self.heroId then
			var_12_0 = true

			break
		end
	end

	if var_12_0 then
		self.praiseController:SetSelectedState("on")
	else
		self.praiseController:SetSelectedState("off")
	end
end

function BilliardBattleHeroPopModule:UpdateSelectedStatus()
	if self.isInSelected then
		self.selectController:SetSelectedState("on")
	else
		self.selectController:SetSelectedState("off")
	end
end

function BilliardBattleHeroPopModule:UpdateExchangeStatus()
	local var_14_0 = self.context:GetExchangeHeroId()

	if var_14_0 == nil then
		self.grayController:SetSelectedState("off")
	elseif var_14_0 == self.heroId then
		self.grayController:SetSelectedState("off")
	end
end

function BilliardBattleHeroPopModule:Dispose()
	if self.showTimer then
		self.showTimer:Stop()

		self.showTimer = nil
	end

	manager.notify:RemoveListener(BilliardGameEvent.BILLIARD_POP_VIEW_ADD_HERO, self.onAddHandle)
	manager.notify:RemoveListener(BilliardGameEvent.BILLIARD_POP_VIEW_REMOVE_HERO, self.onRemoveHandle)
	manager.notify:RemoveListener(BilliardGameEvent.BILLIARD_POP_VIEW_SELECT_HERO, self.onSelectHeroChangeHandle)
	manager.notify:RemoveListener(BilliardGameEvent.BILLIARD_POP_VIEW_EXCHANGE_HERO, self.onExchangeHeroChangeHandle)
	BilliardBattleHeroPopModule.super.Dispose(self)
end

return BilliardBattleHeroPopModule

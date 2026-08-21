local var_0_0 = class("BilliardBattleTeamHeroModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.context = arg_1_2
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.slotId = arg_1_3

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.statusController = arg_2_0.controller_:GetController("status")
	arg_2_0.exchangeController = arg_2_0.controller_:GetController("exchange")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.exchangeBtn_, nil, function()
		return
	end)
	arg_3_0:AddBtnListener(arg_3_0.clickBtn_, nil, function()
		arg_3_0:OnMaskClick()
	end)

	arg_3_0.onAddHandle = handler(arg_3_0, arg_3_0.OnAddHeroHandle)

	manager.notify:RegistListener(BilliardGameEvent.BILLIARD_POP_VIEW_ADD_HERO, arg_3_0.onAddHandle)

	arg_3_0.onRemoveHandle = handler(arg_3_0, arg_3_0.OnRemoveHeroHandle)

	manager.notify:RegistListener(BilliardGameEvent.BILLIARD_POP_VIEW_REMOVE_HERO, arg_3_0.onRemoveHandle)

	arg_3_0.onExchangeHeroChangeHandle = handler(arg_3_0, arg_3_0.OnExchangeHeroChangeHandle)

	manager.notify:RegistListener(BilliardGameEvent.BILLIARD_POP_VIEW_EXCHANGE_HERO, arg_3_0.onExchangeHeroChangeHandle)
end

function var_0_0.OnMaskClick(arg_6_0)
	if arg_6_0.context:IsInExchange() then
		arg_6_0.context:ExchangeSlot(arg_6_0.slotId)
	else
		local var_6_0 = arg_6_0.context:GetSlotHero(arg_6_0.slotId)

		if var_6_0 then
			arg_6_0.context:SelectHero(var_6_0)
		end
	end
end

function var_0_0.OnAddHeroHandle(arg_7_0)
	arg_7_0:OnRender()
end

function var_0_0.OnRemoveHeroHandle(arg_8_0)
	arg_8_0:OnRender()
end

function var_0_0.OnExchangeHeroChangeHandle(arg_9_0)
	arg_9_0:OnRender()
end

function var_0_0.OnRender(arg_10_0)
	local var_10_0 = arg_10_0.context:GetSlotHero(arg_10_0.slotId)

	if var_10_0 then
		local var_10_1 = SummerPubHeroCfg[var_10_0]

		arg_10_0.heroImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. var_10_1.profile_icon_ball)

		arg_10_0.statusController:SetSelectedState("on")
	else
		arg_10_0.statusController:SetSelectedState("add")
	end

	arg_10_0:UpdateExchangeStatus()
end

function var_0_0.UpdateExchangeStatus(arg_11_0)
	if arg_11_0.context:GetExchangeHeroId() then
		arg_11_0.exchangeController:SetSelectedState("on")
	else
		arg_11_0.exchangeController:SetSelectedState("off")
	end
end

function var_0_0.Dispose(arg_12_0)
	manager.notify:RemoveListener(BilliardGameEvent.BILLIARD_POP_VIEW_ADD_HERO, arg_12_0.onAddHandle)
	manager.notify:RemoveListener(BilliardGameEvent.BILLIARD_POP_VIEW_REMOVE_HERO, arg_12_0.onRemoveHandle)
	manager.notify:RemoveListener(BilliardGameEvent.BILLIARD_POP_VIEW_EXCHANGE_HERO, arg_12_0.onExchangeHeroChangeHandle)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0

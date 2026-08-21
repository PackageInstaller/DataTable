local var_0_0 = class("BilliardBattleHeroPopModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.heroId = -1
	arg_2_0.context = nil
	arg_2_0.isInSelected = false

	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.statusController = arg_2_0.controller_:GetController("status")
	arg_2_0.praiseController = arg_2_0.controller_:GetController("praise")
	arg_2_0.selectController = arg_2_0.controller_:GetController("select")
	arg_2_0.grayController = arg_2_0.controller_:GetController("gray")
	arg_2_0.morphologyController = arg_2_0.controller_:GetController("morphology")

	arg_2_0:UpdateSelectedStatus()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		local var_4_0 = false

		if not arg_3_0.context:IsHeroInSlot(arg_3_0.heroId) and arg_3_0.context:SlotIsFull() then
			local var_4_1 = true

			arg_3_0.context.waitExchangeId = arg_3_0.heroId

			manager.notify:Invoke(BilliardGameEvent.BILLIARD_POP_VIEW_EXCHANGE_HERO)
		else
			arg_3_0.context.waitExchangeId = nil

			if arg_3_0.context:IsHeroInSlot(arg_3_0.heroId) then
				arg_3_0.context:RemoveHero(arg_3_0.heroId)
			else
				arg_3_0.context:AddHeroToSlot(arg_3_0.heroId)
			end
		end

		arg_3_0.context:SelectHero(arg_3_0.heroId)
	end)

	arg_3_0.onAddHandle = handler(arg_3_0, arg_3_0.OnAddHeroHandle)

	manager.notify:RegistListener(BilliardGameEvent.BILLIARD_POP_VIEW_ADD_HERO, arg_3_0.onAddHandle)

	arg_3_0.onRemoveHandle = handler(arg_3_0, arg_3_0.OnRemoveHeroHandle)

	manager.notify:RegistListener(BilliardGameEvent.BILLIARD_POP_VIEW_REMOVE_HERO, arg_3_0.onRemoveHandle)

	arg_3_0.onSelectHeroChangeHandle = handler(arg_3_0, arg_3_0.OnSelectHeroChange)

	manager.notify:RegistListener(BilliardGameEvent.BILLIARD_POP_VIEW_SELECT_HERO, arg_3_0.onSelectHeroChangeHandle)

	arg_3_0.onExchangeHeroChangeHandle = handler(arg_3_0, arg_3_0.OnExchangeHeroChangeHandle)

	manager.notify:RegistListener(BilliardGameEvent.BILLIARD_POP_VIEW_EXCHANGE_HERO, arg_3_0.onExchangeHeroChangeHandle)
end

function var_0_0.OnAddHeroHandle(arg_5_0, arg_5_1)
	if arg_5_0.heroId == arg_5_1 then
		arg_5_0:RefreshUI()
	end
end

function var_0_0.OnRemoveHeroHandle(arg_6_0, arg_6_1)
	if arg_6_0.heroId == arg_6_1 then
		arg_6_0:RefreshUI()
	end
end

function var_0_0.OnSelectHeroChange(arg_7_0, arg_7_1)
	arg_7_0.isInSelected = arg_7_0.context:IsHeroInSelected(arg_7_0.heroId)

	arg_7_0:UpdateSelectedStatus()
end

function var_0_0.OnExchangeHeroChangeHandle(arg_8_0)
	arg_8_0:UpdateExchangeStatus()
end

function var_0_0.OnRenderHero(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.heroId = arg_9_1
	arg_9_0.context = arg_9_2

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	if arg_10_0.context:IsHeroInSlot(arg_10_0.heroId) then
		arg_10_0.statusController:SetSelectedState("Deploy")
	else
		arg_10_0.statusController:SetSelectedState("normal")
	end

	if arg_10_0.showTimer then
		arg_10_0.showTimer:Stop()

		arg_10_0.showTimer = nil
	end

	arg_10_0.unlockEff_:SetActive(false)

	arg_10_0.showTimer = Timer.New(function()
		if not getData("BilliardGame", "BilliardGame_Hero_Unlock" .. arg_10_0.heroId) then
			arg_10_0.unlockEff_:SetActive(true)
			saveData("BilliardGame", "BilliardGame_Hero_Unlock" .. arg_10_0.heroId, true)
		end
	end, 0.5, 1)

	arg_10_0.showTimer:Start()

	arg_10_0.isInSelected = arg_10_0.context:IsHeroInSelected(arg_10_0.heroId)

	arg_10_0:UpdateSelectedStatus()
	arg_10_0:UpdateExchangeStatus()
	arg_10_0:UpdateRecommend()

	local var_10_0 = SummerPubHeroCfg[arg_10_0.heroId]

	arg_10_0.heroIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. var_10_0.profile_icon_ball)

	if var_10_0.pinball_hero_type == 3 then
		arg_10_0.morphologyController:SetSelectedState("auxiliary")
	else
		arg_10_0.morphologyController:SetSelectedState("attack")
	end
end

function var_0_0.UpdateRecommend(arg_12_0)
	local var_12_0 = BilliardStageCfg[arg_12_0.context.curStage].recommend_hero
	local var_12_1 = false

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if iter_12_1 == arg_12_0.heroId then
			var_12_1 = true

			break
		end
	end

	if var_12_1 then
		arg_12_0.praiseController:SetSelectedState("on")
	else
		arg_12_0.praiseController:SetSelectedState("off")
	end
end

function var_0_0.UpdateSelectedStatus(arg_13_0)
	if arg_13_0.isInSelected then
		arg_13_0.selectController:SetSelectedState("on")
	else
		arg_13_0.selectController:SetSelectedState("off")
	end
end

function var_0_0.UpdateExchangeStatus(arg_14_0)
	local var_14_0 = arg_14_0.context:GetExchangeHeroId()

	if var_14_0 == nil then
		arg_14_0.grayController:SetSelectedState("off")
	elseif var_14_0 == arg_14_0.heroId then
		arg_14_0.grayController:SetSelectedState("off")
	end
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.showTimer then
		arg_15_0.showTimer:Stop()

		arg_15_0.showTimer = nil
	end

	manager.notify:RemoveListener(BilliardGameEvent.BILLIARD_POP_VIEW_ADD_HERO, arg_15_0.onAddHandle)
	manager.notify:RemoveListener(BilliardGameEvent.BILLIARD_POP_VIEW_REMOVE_HERO, arg_15_0.onRemoveHandle)
	manager.notify:RemoveListener(BilliardGameEvent.BILLIARD_POP_VIEW_SELECT_HERO, arg_15_0.onSelectHeroChangeHandle)
	manager.notify:RemoveListener(BilliardGameEvent.BILLIARD_POP_VIEW_EXCHANGE_HERO, arg_15_0.onExchangeHeroChangeHandle)
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0

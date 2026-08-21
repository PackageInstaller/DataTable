local var_0_0 = class("IslandCheaterTavernPlayerUnit", import(".IslandSceneUnit"))
local var_0_1 = {
	Question = 1
}

function var_0_0.OnAttach(arg_1_0, arg_1_1)
	var_0_0.super.OnAttach(arg_1_0, arg_1_1)

	arg_1_0.characterHandleController = arg_1_0._go:GetComponent(typeof(CharacterHandleController))

	arg_1_0.characterHandleController:AddStateEnterFunc(function(arg_2_0, arg_2_1)
		arg_1_0:StateEnterHandle(arg_2_0, arg_2_1)

		return
	end)
	arg_1_0.characterHandleController:AddStateExitFunc(function(arg_3_0, arg_3_1)
		arg_1_0:StateExitHandle(arg_3_0, arg_3_1)

		return
	end)
	arg_1_0.characterHandleController:AddStateUpdateFunc(function(arg_4_0, arg_4_1)
		arg_1_0:StateUpdateHandle(arg_4_0, arg_4_1)

		return
	end)

	arg_1_0.objTfList = {}
	arg_1_0._tf = arg_1_0._go.transform
	arg_1_0.animator = arg_1_0._tf:GetChild(0):GetComponent(typeof(Animator))
	arg_1_0.shipDressHelper = IslandShipDressHelperMiniGameNew.New()

	arg_1_0.shipDressHelper:SetShipId(0, PlayRoomTools.GetGameViewID(getProxy(IslandProxy):GetIsland():GetCheaterTavernAgency():GetPlayerData(arg_1_0.id).player_info.user_view).dress_list)

	local var_1_0 = getProxy(PlayerProxy)

	if arg_1_0.id == var_1_0:getRawData().id then
		pg.ViewUtils.SetLayer(arg_1_0._tf, Layer.UIHidden)
	else
		pg.ViewUtils.SetLayer(arg_1_0._tf, Layer.Default)
	end

	arg_1_0.shipDressHelper:OnRoleLoaded(arg_1_0._tf, nil, function(arg_5_0)
		if var_0 then
			pg.ViewUtils.SetLayer(arg_5_0.transform, Layer.UIHidden)
		end

		return
	end)

	arg_1_0.playInAnimationTimer = Timer.New(function()
		local var_6_0 = (math.random() - 0.5) * 0.5

		for iter_6_0 = 1, arg_1_0.animator.layerCount do
			arg_1_0.animator:Play("sit_idle", iter_6_0 - 1, var_6_0)
		end

		return
	end, 2, 1)

	arg_1_0.playInAnimationTimer:Start()

	return
end

function var_0_0.StateEnterHandle(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == var_0_1.Question then
		arg_7_0.effectLoaded = false
		arg_7_0.effectUnloaded = false
		arg_7_0.showEffectTime = IslandCheaterTavernConst.quesAnimionshowEffectFrame / IslandCheaterTavernConst.quesAnimionTotalFrame
		arg_7_0.unShowEffectTime = IslandCheaterTavernConst.quesAnimionUnshowEffectFrame / IslandCheaterTavernConst.quesAnimionTotalFrame
	end

	return
end

function var_0_0.StateUpdateHandle(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == var_0_1.Question then
		local var_8_0 = arg_8_0.animator:GetCurrentAnimatorStateInfo(0).normalizedTime % 1

		if not arg_8_0.effectLoaded and var_8_0 >= arg_8_0.showEffectTime then
			arg_8_0.effectLoaded = true

			arg_8_0:LoadEffect(arg_8_2)
		end

		if not arg_8_0.effectUnloaded and var_8_0 >= arg_8_0.unShowEffectTime then
			arg_8_0.effectUnloaded = true

			arg_8_0:UnLoadEffect(arg_8_2)
		end
	end

	return
end

function var_0_0.StateExitHandle(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == var_0_1.Question then
		arg_9_0.effectUnloaded = true

		arg_9_0:UnLoadEffect(arg_9_2)
	end

	return
end

function var_0_0.LoadEffect(arg_10_0, arg_10_1)
	if arg_10_0.objTfList[arg_10_1] then
		setActive(arg_10_0.objTfList[arg_10_1], true)
		setParent(arg_10_0.objTfList[arg_10_1], arg_10_0._tf)

		return
	end

	arg_10_0.objTfList[arg_10_1] = Object.Instantiate((LoadAny(pg.island_unit_item[arg_10_1].model, nil))).transform

	setParent(arg_10_0.objTfList[arg_10_1], arg_10_0._tf)

	return
end

function var_0_0.UnLoadEffect(arg_11_0, arg_11_1)
	if arg_11_0.objTfList[arg_11_1] then
		setActive(arg_11_0.objTfList[arg_11_1], false)
	end

	return
end

function var_0_0.DestroyInteractiveTools(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.objTfList) do
		Object.Destroy(iter_12_1.gameObject)
	end

	arg_12_0.objTfList = {}

	return
end

function var_0_0.OnPlayerQuestion(arg_13_0, arg_13_1)
	if arg_13_1 then
		pg.ViewUtils.SetLayer(arg_13_0._tf, Layer.Default)

		if arg_13_0.questTimer then
			arg_13_0.questTimer:Stop()
		end

		arg_13_0.questTimer = Timer.New(function()
			pg.ViewUtils.SetLayer(arg_13_0._tf, Layer.UIHidden)

			return
		end, IslandCheaterTavernConst.qusanimationTime, 1)

		arg_13_0.questTimer:Start()
	end

	for iter_13_0 = 1, arg_13_0.animator.layerCount do
		arg_13_0.animator:CrossFadeInFixedTime("question", 0, iter_13_0 - 1)
	end

	return
end

function var_0_0.OnPlayWinAnimation(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 then
		pg.ViewUtils.SetLayer(arg_15_0._tf, Layer.Default)
		CheatTavernCameraMgr.instance:ActiveVirtualCamera("winseat0" .. arg_15_2)

		if arg_15_0.winTimer then
			arg_15_0.winTimer:Stop()
		end

		arg_15_0.winTimer = Timer.New(function()
			pg.ViewUtils.SetLayer(arg_15_0._tf, Layer.UIHidden)
			CheatTavernCameraMgr.instance:ActiveVirtualCamera("lookSeet0" .. arg_15_2)

			return
		end, IslandCheaterTavernConst.winAnimationTime, 1)

		arg_15_0.winTimer:Start()
	end

	for iter_15_0 = 1, arg_15_0.animator.layerCount do
		arg_15_0.animator:CrossFadeInFixedTime("win01", 0, iter_15_0 - 1)
	end

	return
end

function var_0_0.OnPlayerOut(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == getProxy(PlayerProxy):getRawData().id then
		pg.ViewUtils.SetLayer(arg_17_0._tf, Layer.Default)
		CheatTavernCameraMgr.instance:ActiveVirtualCamera("failoutSeet0" .. arg_17_2)

		if arg_17_0.outTimer then
			arg_17_0.outTimer:Stop()
		end

		arg_17_0.outTimer = Timer.New(function()
			CheatTavernCameraMgr.instance:ActiveVirtualCamera("lookSeet0" .. arg_17_2)

			return
		end, 3, 1)

		arg_17_0.outTimer:Start()
	end

	for iter_17_0 = 1, arg_17_0.animator.layerCount do
		arg_17_0.animator:CrossFadeInFixedTime("fallout", 0, iter_17_0 - 1)
	end

	return
end

function var_0_0.OnDetach(arg_19_0)
	arg_19_0.shipDressHelper:Destroy()

	if arg_19_0.outTimer then
		arg_19_0.outTimer:Stop()
	end

	if arg_19_0.questTimer then
		arg_19_0.questTimer:Stop()
	end

	if arg_19_0.playInAnimationTimer then
		arg_19_0.playInAnimationTimer:Stop()
	end

	if arg_19_0.winTimer then
		arg_19_0.winTimer:Stop()
	end

	arg_19_0:DestroyInteractiveTools()

	return
end

return var_0_0

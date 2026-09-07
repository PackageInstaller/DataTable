local IslandCheaterTavernPlayerUnit = class("IslandCheaterTavernPlayerUnit", import(".IslandSceneUnit"))
local var_0_1 = {
	Question = 1
}

function IslandCheaterTavernPlayerUnit:OnAttach(arg_1_1)
	IslandCheaterTavernPlayerUnit.super.OnAttach(self, arg_1_1)

	self.characterHandleController = self._go:GetComponent(typeof(CharacterHandleController))

	self.characterHandleController:AddStateEnterFunc(function(arg_2_0, arg_2_1)
		self:StateEnterHandle(arg_2_0, arg_2_1)

		return
	end)
	self.characterHandleController:AddStateExitFunc(function(arg_3_0, arg_3_1)
		self:StateExitHandle(arg_3_0, arg_3_1)

		return
	end)
	self.characterHandleController:AddStateUpdateFunc(function(arg_4_0, arg_4_1)
		self:StateUpdateHandle(arg_4_0, arg_4_1)

		return
	end)

	self.objTfList = {}
	self._tf = self._go.transform
	self.animator = self._tf:GetChild(0):GetComponent(typeof(Animator))
	self.shipDressHelper = IslandShipDressHelperMiniGameNew.New()

	self.shipDressHelper:SetShipId(0, PlayRoomTools.GetGameViewID(getProxy(IslandProxy):GetIsland():GetCheaterTavernAgency():GetPlayerData(self.id).player_info.user_view).dress_list)

	local var_1_0 = self.id == getProxy(PlayerProxy):getRawData().id

	if var_1_0 then
		pg.ViewUtils.SetLayer(self._tf, Layer.UIHidden)
	else
		pg.ViewUtils.SetLayer(self._tf, Layer.Default)
	end

	self.shipDressHelper:OnRoleLoaded(self._tf, nil, function(arg_5_0)
		if var_1_0 then
			pg.ViewUtils.SetLayer(arg_5_0.transform, Layer.UIHidden)
		end

		return
	end)

	self.playInAnimationTimer = Timer.New(function()
		local var_6_0 = (math.random() - 0.5) * 0.5

		for iter_6_0 = 1, self.animator.layerCount do
			self.animator:Play("sit_idle", iter_6_0 - 1, var_6_0)
		end

		return
	end, 2, 1)

	self.playInAnimationTimer:Start()

	return
end

function IslandCheaterTavernPlayerUnit:StateEnterHandle(arg_7_1, arg_7_2)
	if arg_7_1 == var_0_1.Question then
		self.effectLoaded = false
		self.effectUnloaded = false
		self.showEffectTime = IslandCheaterTavernConst.quesAnimionshowEffectFrame / IslandCheaterTavernConst.quesAnimionTotalFrame
		self.unShowEffectTime = IslandCheaterTavernConst.quesAnimionUnshowEffectFrame / IslandCheaterTavernConst.quesAnimionTotalFrame
	end

	return
end

function IslandCheaterTavernPlayerUnit:StateUpdateHandle(arg_8_1, arg_8_2)
	if arg_8_1 == var_0_1.Question then
		local var_8_0 = self.animator:GetCurrentAnimatorStateInfo(0).normalizedTime % 1

		if not self.effectLoaded and var_8_0 >= self.showEffectTime then
			self.effectLoaded = true

			self:LoadEffect(arg_8_2)
		end

		if not self.effectUnloaded and var_8_0 >= self.unShowEffectTime then
			self.effectUnloaded = true

			self:UnLoadEffect(arg_8_2)
		end
	end

	return
end

function IslandCheaterTavernPlayerUnit:StateExitHandle(arg_9_1, arg_9_2)
	if arg_9_1 == var_0_1.Question then
		self.effectUnloaded = true

		self:UnLoadEffect(arg_9_2)
	end

	return
end

function IslandCheaterTavernPlayerUnit:LoadEffect(arg_10_1)
	if self.objTfList[arg_10_1] then
		setActive(self.objTfList[arg_10_1], true)
		setParent(self.objTfList[arg_10_1], self._tf)

		return
	end

	self.objTfList[arg_10_1] = Object.Instantiate((LoadAny(pg.island_unit_item[arg_10_1].model, nil))).transform

	setParent(self.objTfList[arg_10_1], self._tf)

	return
end

function IslandCheaterTavernPlayerUnit:UnLoadEffect(arg_11_1)
	if self.objTfList[arg_11_1] then
		setActive(self.objTfList[arg_11_1], false)
	end

	return
end

function IslandCheaterTavernPlayerUnit:DestroyInteractiveTools()
	for iter_12_0, iter_12_1 in pairs(self.objTfList) do
		Object.Destroy(iter_12_1.gameObject)
	end

	self.objTfList = {}

	return
end

function IslandCheaterTavernPlayerUnit:OnPlayerQuestion(arg_13_1)
	if arg_13_1 then
		pg.ViewUtils.SetLayer(self._tf, Layer.Default)

		if self.questTimer then
			self.questTimer:Stop()
		end

		self.questTimer = Timer.New(function()
			pg.ViewUtils.SetLayer(self._tf, Layer.UIHidden)

			return
		end, IslandCheaterTavernConst.qusanimationTime, 1)

		self.questTimer:Start()
	end

	for iter_13_0 = 1, self.animator.layerCount do
		self.animator:CrossFadeInFixedTime("question", 0, iter_13_0 - 1)
	end

	return
end

function IslandCheaterTavernPlayerUnit:OnPlayWinAnimation(arg_15_1, arg_15_2)
	if arg_15_1 then
		pg.ViewUtils.SetLayer(self._tf, Layer.Default)
		CheatTavernCameraMgr.instance:ActiveVirtualCamera("winseat0" .. arg_15_2)

		if self.winTimer then
			self.winTimer:Stop()
		end

		self.winTimer = Timer.New(function()
			pg.ViewUtils.SetLayer(self._tf, Layer.UIHidden)
			CheatTavernCameraMgr.instance:ActiveVirtualCamera("lookSeet0" .. arg_15_2)

			return
		end, IslandCheaterTavernConst.winAnimationTime, 1)

		self.winTimer:Start()
	end

	for iter_15_0 = 1, self.animator.layerCount do
		self.animator:CrossFadeInFixedTime("win01", 0, iter_15_0 - 1)
	end

	return
end

function IslandCheaterTavernPlayerUnit:OnPlayerOut(arg_17_1, arg_17_2)
	if arg_17_1 == getProxy(PlayerProxy):getRawData().id then
		pg.ViewUtils.SetLayer(self._tf, Layer.Default)
		CheatTavernCameraMgr.instance:ActiveVirtualCamera("failoutSeet0" .. arg_17_2)

		if self.outTimer then
			self.outTimer:Stop()
		end

		self.outTimer = Timer.New(function()
			CheatTavernCameraMgr.instance:ActiveVirtualCamera("lookSeet0" .. arg_17_2)

			return
		end, 3, 1)

		self.outTimer:Start()
	end

	for iter_17_0 = 1, self.animator.layerCount do
		self.animator:CrossFadeInFixedTime("fallout", 0, iter_17_0 - 1)
	end

	return
end

function IslandCheaterTavernPlayerUnit:OnDetach()
	self.shipDressHelper:Destroy()

	if self.outTimer then
		self.outTimer:Stop()
	end

	if self.questTimer then
		self.questTimer:Stop()
	end

	if self.playInAnimationTimer then
		self.playInAnimationTimer:Stop()
	end

	if self.winTimer then
		self.winTimer:Stop()
	end

	self:DestroyInteractiveTools()

	return
end

return IslandCheaterTavernPlayerUnit

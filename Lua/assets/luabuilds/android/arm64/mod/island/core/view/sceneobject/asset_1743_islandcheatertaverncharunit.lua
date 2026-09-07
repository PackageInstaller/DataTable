local IslandCheaterTavernCharUnit = class("IslandCheaterTavernCharUnit", import(".IslandSceneUnit"))

function IslandCheaterTavernCharUnit:OnAttach(arg_1_1)
	IslandCheaterTavernCharUnit.super.OnAttach(self, arg_1_1)

	self.tf = tf(arg_1_1)
	self.seatId = self.data.index
	self.animator = self.tf:GetChild(0):GetComponent(typeof(UnityEngine.Animator))

	self:InitDisplayState()

	return
end

function IslandCheaterTavernCharUnit:OnPlayerOut(arg_2_1)
	if arg_2_1 then
		pg.ViewUtils.SetLayer(self.tf, Layer.Default)
	end

	self.animator:CrossFadeInFixedTime("fallout", 0, 0)
	setActive(self.effectGo, true)

	return
end

function IslandCheaterTavernCharUnit:OnPlayerQuestion()
	if self.questTimer then
		self.questTimer:Stop()
	end

	pg.ViewUtils.SetLayer(self.tf, Layer.Default)

	self.questTimer = Timer.New(function()
		pg.ViewUtils.SetLayer(self.tf, Layer.UIHidden)

		return
	end, IslandCheaterTavernConst.qusanimationTime, 1)

	self.questTimer:Start()

	return
end

function IslandCheaterTavernCharUnit:OnPlayWinAnimation()
	if self.winTimer then
		self.winTimer:Stop()
	end

	pg.ViewUtils.SetLayer(self.tf, Layer.Default)

	self.winTimer = Timer.New(function()
		pg.ViewUtils.SetLayer(self.tf, Layer.UIHidden)

		return
	end, IslandCheaterTavernConst.winAnimationTime, 1)

	self.winTimer:Start()

	return
end

function IslandCheaterTavernCharUnit:InitDisplayState()
	local var_7_0 = getProxy(IslandProxy):GetIsland():GetCheaterTavernAgency()

	if not var_7_0:IsConnecting() then
		return
	end

	if IsNil(self.tf) then
		return
	end

	local var_7_1 = var_7_0:GetMainPlayer()

	if var_7_1 then
		if self.seatId == var_7_1.seat then
			pg.ViewUtils.SetLayer(self.tf, Layer.UIHidden)
		else
			pg.ViewUtils.SetLayer(self.tf, Layer.Default)
		end
	end

	return
end

function IslandCheaterTavernCharUnit:OnDetach()
	if self.questTimer then
		self.questTimer:Stop()
	end

	if self.winTimer then
		self.winTimer:Stop()
	end

	if self.effectGo then
		setActive(self.effectGo, false)
	end

	return
end

function IslandCheaterTavernCharUnit:SetEffect(arg_9_1)
	self.effectGo = arg_9_1

	return
end

return IslandCheaterTavernCharUnit

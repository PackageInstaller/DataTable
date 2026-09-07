local IslandCancelAnimationOpView = class("IslandCancelAnimationOpView", import(".IslandBaseHudView"))

function IslandCancelAnimationOpView:GetUIName()
	return "IslandTopHeadHudUI"
end

function IslandCancelAnimationOpView:GetUIParent(arg_2_1)
	return self:GetView().layer2OpContianer
end

function IslandCancelAnimationOpView:GetHeadOffset()
	return Vector3(0, 1.8, 0)
end

function IslandCancelAnimationOpView:OnInit(arg_4_1)
	self.cancelAnimationOpTpl = self._tf:Find("tpls/IslandCancelAnimationOpTpl")
	self.cancelAnimationOpTpls = {}

	IslandCancelAnimationOpView.super.OnInit(self, arg_4_1)

	return
end

function IslandCancelAnimationOpView:ShowCancelableAnimationOp(arg_5_1)
	local var_5_0 = self:GenUnitData(arg_5_1.id, arg_5_1.unitType)
	local var_5_1 = self:GetUnitHudRoot(var_5_0):Find("aniamtionOpContainer")
	local var_5_2 = self.cancelAnimationOpTpls[var_5_0.key] or Object.Instantiate(self.cancelAnimationOpTpl, var_5_1)

	setParent(var_5_2, var_5_1)
	setActive(var_5_2, true)

	self.cancelAnimationOpTpls[var_5_0.key] = var_5_2

	onButton(self, var_5_2, function()
		self:NotifiyCore(ISLAND_EVT.CANCEL_COUPLE_ACTION)

		return
	end, SFX_PANEL)

	return
end

function IslandCancelAnimationOpView:HideCancelableAnimationOp(arg_7_1)
	local var_7_0 = self.cancelAnimationOpTpls[self:GenUnitData(arg_7_1.id, arg_7_1.unitType).key]

	if not var_7_0 then
		return
	end

	setActive(var_7_0, false)

	return
end

function IslandCancelAnimationOpView:OnDispose()
	IslandCancelAnimationOpView.super.OnDispose(self)

	for iter_8_0, iter_8_1 in pairs(self.cancelAnimationOpTpls) do
		Object.Destroy(iter_8_1)
	end

	self.cancelAnimationOpTpls = nil

	return
end

return IslandCancelAnimationOpView

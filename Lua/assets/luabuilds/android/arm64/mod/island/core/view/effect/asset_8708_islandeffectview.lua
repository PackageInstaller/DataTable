local IslandEffectView = class("IslandEffectView", import("..IslandBaseHudView"))
local var_0_1 = {
	(import(".IslandRecEnergyEffect"))
}

function IslandEffectView:GetUIName()
	return "IslandEffectUI"
end

function IslandEffectView:OnInit(arg_2_1)
	IslandEffectView.super.OnInit(self, arg_2_1)

	self.effects = {}

	for iter_2_0, iter_2_1 in ipairs(var_0_1) do
		local var_2_0 = iter_2_1.New(self._tf)

		self.effects[var_2_0:GetType()] = var_2_0
	end

	return
end

function IslandEffectView:Play(arg_3_1, arg_3_2, arg_3_3)
	if self.effects[arg_3_3] then
		self.effects[arg_3_3]:Play(arg_3_1, arg_3_2)
	end

	return
end

function IslandEffectView:OnLateUpdate()
	IslandEffectView.super.OnLateUpdate(self)

	for iter_4_0, iter_4_1 in pairs(self.effects) do
		iter_4_1:Update()
	end

	return
end

function IslandEffectView:OnDispose()
	for iter_5_0, iter_5_1 in pairs(self.effects or {}) do
		iter_5_1:Dispose()
	end

	self.effects = nil

	IslandEffectView.super.OnDispose(self)

	return
end

return IslandEffectView

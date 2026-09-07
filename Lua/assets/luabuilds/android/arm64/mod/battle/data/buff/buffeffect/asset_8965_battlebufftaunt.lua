ys = ys or {}

local var_0_0 = ys.Battle.BattleAttr
local BattleBuffTaunt = class("BattleBuffTaunt", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffTaunt = BattleBuffTaunt
BattleBuffTaunt.__name = "BattleBuffTaunt"

function BattleBuffTaunt:Ctor(arg_1_1)
	BattleBuffTaunt.super.Ctor(self, arg_1_1)

	self._tauntActive = false

	return
end

function BattleBuffTaunt:SetArgs(arg_2_1, arg_2_2)
	self._guardTargetFilter = self._tempData.arg_list.guardTarget
	self._handleCloak = arg_2_1:GetCloak() ~= nil

	return
end

function BattleBuffTaunt:onTrigger(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0

	if not self._handleCloak then
		do return end

		var_3_0 = true
	end

	for iter_3_0, iter_3_1 in ipairs((self:getTargetList(arg_3_1, self._guardTargetFilter, self._tempData.arg_list))) do
		var_3_0 = var_3_0 and var_0_0.IsCloak(iter_3_1)
	end

	if not var_3_0 and not self._tauntActive then
		self:forceToExpose(arg_3_1)
	elseif var_3_0 and self._tauntActive then
		self:releaseExpose(arg_3_1)
	end

	return
end

function BattleBuffTaunt:onRemove(arg_4_1, arg_4_2, arg_4_3)
	self:releaseExpose(arg_4_1)

	return
end

function BattleBuffTaunt:forceToExpose(arg_5_1)
	if not self._handleCloak then
		return
	end

	self._tauntActive = true

	local var_5_0 = arg_5_1:GetCloak()

	var_5_0:ForceToMax()
	var_5_0:UpdateTauntExpose(true)

	return
end

function BattleBuffTaunt:releaseExpose(arg_6_1)
	if not self._handleCloak then
		return
	end

	self._tauntActive = false

	arg_6_1:GetCloak():UpdateTauntExpose(false)

	return
end

return

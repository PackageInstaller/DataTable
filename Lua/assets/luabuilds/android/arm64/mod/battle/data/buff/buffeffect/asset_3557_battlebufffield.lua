ys = ys or {}

local var_0_0 = ys
local BattleBuffField = class("BattleBuffField", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffField = BattleBuffField
BattleBuffField.__name = "BattleBuffField"

local var_0_2 = ys.Battle.BattleConst

function BattleBuffField:Ctor(arg_1_1)
	BattleBuffField.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffField:SetArgs(arg_2_1, arg_2_2)
	self._level = arg_2_2:GetLv()
	self._caster = arg_2_2:GetCaster()
	self._auraBuffID = self._tempData.arg_list.buff_id
	self._target = self._tempData.arg_list.target
	self._check_target = self._tempData.arg_list.check_target or "TargetNull"
	self._isUpdateAura = self._tempData.arg_list.FAura

	local var_2_0 = true
	local var_2_1 = type(self._target)

	if var_2_1 == "string" and self._target == "TargetAllHarm" or var_2_1 == "table" and table.contains(self._target, "TargetAllHarm") or var_2_1 == "string" and self._target == "TargetAllFoe" or var_2_1 == "table" and table.contains(self._target, "TargetAllFoe") then
		var_2_0 = false
	end

	local function var_2_2(arg_3_0)
		for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
			if iter_3_1.Active then
				for iter_3_2, iter_3_3 in ipairs((self:getTargetList(arg_2_1, self._target, self._tempData.arg_list))) do
					if iter_3_3:GetUniqueID() == iter_3_1.UID then
						iter_3_3:AddBuff((var_0_0.Battle.BattleBuffUnit.New(self._auraBuffID, self._level, self._caster)))

						break
					end
				end
			end
		end

		return
	end

	local function var_2_3(arg_4_0)
		if arg_4_0.Active then
			for iter_4_0, iter_4_1 in ipairs((self:getTargetList(arg_2_1, self._target, self._tempData.arg_list))) do
				if iter_4_1:GetUniqueID() == arg_4_0.UID then
					iter_4_1:RemoveBuff(self._auraBuffID)

					break
				end
			end
		end

		return
	end

	local var_2_4 = self._isUpdateAura and var_2_3 or nil
	local var_2_5 = not not self._isUpdateAura
	local var_2_6 = var_0_0.Battle.BattleDataProxy.GetInstance()
	local var_2_7, var_2_8, var_2_9, var_2_10 = var_2_6:GetFieldBound()

	self._aura = var_2_6:SpawnLastingCubeArea(var_0_2.AOEField.SURFACE, arg_2_1:GetIFF(), Vector3((var_2_9 + var_2_10) * 0.5, 0, (var_2_7 + var_2_8) * 0.5), math.abs(var_2_10 - var_2_9), math.abs(var_2_7 - var_2_8), 0, var_2_2, var_2_3, var_2_0, nil, var_2_4, var_2_5)

	return
end

function BattleBuffField:Clear()
	self._aura:SetActiveFlag(false)

	self._aura = nil

	BattleBuffField.super.Clear(self)

	return
end

return

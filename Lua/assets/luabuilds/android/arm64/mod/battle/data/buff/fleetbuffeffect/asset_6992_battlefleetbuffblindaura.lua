ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst

ys.Battle.BattleFleetBuffBlindAura = class("BattleFleetBuffBlindAura", ys.Battle.BattleFleetBuffEffect)
ys.Battle.BattleFleetBuffBlindAura.__name = "BattleFleetBuffBlindAura"

local var_0_2 = ys.Battle.BattleFleetBuffBlindAura

function ys.Battle.BattleFleetBuffBlindAura.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleFleetBuffBlindAura:SetArgs(arg_2_1, arg_2_2)
	local var_2_0 = self._tempData.arg_list.target

	self._aura = var_0_0.Battle.BattleDataProxy.GetInstance():SpawnLastingCubeArea(var_0_1.AOEField.SURFACE, arg_2_1:GetIFF(), Vector3(-55, 0, 55), 180, 70, 0, function(arg_3_0)
		local var_3_0 = self:getTargetList(arg_2_1, var_2_0, self._tempData.arg_list)

		for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
			if iter_3_1.Active then
				for iter_3_2, iter_3_3 in ipairs(var_3_0) do
					if iter_3_3:GetUniqueID() == iter_3_1.UID then
						iter_3_3:SetBlindInvisible(true)

						break
					end
				end
			end
		end

		return
	end, function(arg_4_0)
		if arg_4_0.Active then
			for iter_4_0, iter_4_1 in ipairs((self:getTargetList(arg_2_1, var_2_0, self._tempData.arg_list))) do
				if iter_4_1:GetUniqueID() == arg_4_0.UID then
					iter_4_1:SetBlindInvisible(false)

					break
				end
			end
		end

		return
	end, false)

	return
end

function ys.Battle.BattleFleetBuffBlindAura:Clear()
	self._aura:SetActiveFlag(false)

	self._aura = nil

	var_0_2.super.Clear(self)

	return
end

return

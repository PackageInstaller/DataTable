ys = ys or {}

local var_0_0 = ys
local BattleBuffBlindedHorizon = class("BattleBuffBlindedHorizon", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffBlindedHorizon = BattleBuffBlindedHorizon
BattleBuffBlindedHorizon.__name = "BattleBuffBlindedHorizon"

local var_0_2 = ys.Battle.BattleConst

function BattleBuffBlindedHorizon:Ctor(arg_1_1)
	BattleBuffBlindedHorizon.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffBlindedHorizon:SetArgs(arg_2_1, arg_2_2)
	self._horizonRange = self._tempData.arg_list.range

	local var_2_0 = arg_2_1:GetUniqueID()

	self._aura = var_0_0.Battle.BattleDataProxy.GetInstance():SpawnLastingColumnArea(var_0_2.AOEField.SURFACE, arg_2_1:GetIFF(), arg_2_1:GetPosition(), self._horizonRange, 0, function(arg_3_0)
		for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
			if iter_3_1.Active then
				for iter_3_2, iter_3_3 in ipairs((self:getTargetList(arg_2_1, {
					"TargetAllHarm"
				}))) do
					if iter_3_3:GetUniqueID() == iter_3_1.UID then
						iter_3_3:AppendExposed(var_2_0)

						break
					end
				end
			end
		end

		return
	end, function(arg_4_0)
		if arg_4_0.Active then
			for iter_4_0, iter_4_1 in ipairs((self:getTargetList(arg_2_1, {
				"TargetAllHarm"
			}))) do
				if iter_4_1:GetUniqueID() == arg_4_0.UID then
					iter_4_1:RemoveExposed(var_2_0)

					break
				end
			end
		end

		return
	end, false, nil, function(arg_5_0)
		if arg_5_0.Active then
			for iter_5_0, iter_5_1 in ipairs((self:getTargetList(arg_2_1, {
				"TargetAllHarm"
			}))) do
				if iter_5_1:GetUniqueID() == arg_5_0.UID then
					iter_5_1:RemoveExposed(var_2_0)

					break
				end
			end
		end

		return
	end, true)

	local var_2_1 = var_0_0.Battle.BattleAOEMobilizedComponent.New(self._aura)

	var_2_1:SetReferenceUnit(arg_2_1)
	var_2_1:ConfigData(var_2_1.FOLLOW)

	return
end

function BattleBuffBlindedHorizon:onAttach(arg_6_1, arg_6_2)
	var_0_0.Battle.BattleAttr.FlashByBuff(arg_6_1, "blindedHorizon", self._horizonRange)

	local var_6_0 = arg_6_1:GetFleetVO()

	if var_6_0 then
		var_6_0:UpdateHorizon()
	end

	return
end

function BattleBuffBlindedHorizon:onRemove(arg_7_1, arg_7_2)
	var_0_0.Battle.BattleAttr.FlashByBuff(arg_7_1, "blindedHorizon", 0)

	return
end

function BattleBuffBlindedHorizon:Clear()
	self._aura:SetActiveFlag(false)

	self._aura = nil

	BattleBuffBlindedHorizon.super.Clear(self)

	return
end

return

ys = ys or {}

local var_0_0 = ys
local BattleBuffAura = class("BattleBuffAura", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffAura = BattleBuffAura
BattleBuffAura.__name = "BattleBuffAura"

local var_0_2 = ys.Battle.BattleConst

function BattleBuffAura:Ctor(arg_1_1)
	BattleBuffAura.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffAura:SetArgs(arg_2_1, arg_2_2)
	self._buffLevel = arg_2_2:GetLv()
	self._auraRange = self._tempData.arg_list.cld_data.box.range
	self._buffID = self._tempData.arg_list.buff_id
	self._friendly = self._tempData.arg_list.friendly_fire or false

	local var_2_0, var_2_1, var_2_2 = self:getAreaCldFunc(arg_2_1)

	self._aura = var_0_0.Battle.BattleDataProxy.GetInstance():SpawnLastingColumnArea(var_0_2.AOEField.SURFACE, arg_2_1:GetIFF(), arg_2_1:GetPosition(), self._auraRange, 0, var_2_0, var_2_1, self._friendly, nil, var_2_2, false)
	self._angle = self._tempData.arg_list.cld_data.angle

	if self._angle then
		self._aura:SetSectorAngle(self._angle, arg_2_1:GetDirection())
	end

	local var_2_3 = var_0_0.Battle.BattleAOEMobilizedComponent.New(self._aura)

	var_2_3:SetReferenceUnit(arg_2_1)
	var_2_3:ConfigData(var_2_3.FOLLOW)

	return
end

function BattleBuffAura:getAreaCldFunc(arg_3_1)
	return function(arg_4_0)
		local var_4_0 = self:getTargetList(arg_3_1, {
			"TargetEntityUnit"
		})

		for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
			if iter_4_1.Active then
				for iter_4_2, iter_4_3 in ipairs(var_4_0) do
					if iter_4_3:GetUniqueID() == iter_4_1.UID then
						iter_4_3:AddBuff(var_0_0.Battle.BattleBuffUnit.New(self._buffID, self._buffLevel, self._caster), true)

						break
					end
				end
			end
		end

		return
	end, function(arg_5_0)
		if arg_5_0.Active then
			for iter_5_0, iter_5_1 in ipairs((self:getTargetList(arg_3_1, {
				"TargetEntityUnit"
			}))) do
				if iter_5_1:GetUniqueID() == arg_5_0.UID then
					iter_5_1:RemoveBuff(self._buffID, true)

					break
				end
			end
		end

		return
	end, function(arg_6_0)
		if arg_6_0.Active then
			for iter_6_0, iter_6_1 in ipairs((self:getTargetList(arg_3_1, {
				"TargetEntityUnit"
			}))) do
				if iter_6_1:GetUniqueID() == arg_6_0.UID then
					iter_6_1:RemoveBuff(self._buffID, true)

					break
				end
			end
		end

		return
	end
end

function BattleBuffAura:Clear()
	self._aura:SetActiveFlag(false)

	self._aura = nil

	BattleBuffAura.super.Clear(self)

	return
end

return

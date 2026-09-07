ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local BattleSkillProjectArea = class("BattleSkillProjectArea", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillProjectArea = BattleSkillProjectArea
BattleSkillProjectArea.__name = "BattleSkillProjectArea"

function BattleSkillProjectArea:Ctor(arg_1_1)
	BattleSkillProjectArea.super.Ctor(self, arg_1_1, lv)

	self._posX = self._tempData.arg_list.offset_x
	self._posZ = self._tempData.arg_list.offset_z
	self._width = self._tempData.arg_list.width
	self._height = self._tempData.arg_list.height
	self._lifeTime = self._tempData.arg_list.life_time
	self._fx = self._tempData.arg_list.effect
	self._expendDuration = self._tempData.arg_list.expend_duration
	self._widthSpeed = self._tempData.arg_list.width_expend_speed
	self._heightSpeed = self._tempData.arg_list.height_expend_speed
	self._buffID = self._tempData.arg_list.cld_buff_id

	return
end

function BattleSkillProjectArea:DoDataEffect(arg_2_1)
	self:doSpawnAOE(arg_2_1)

	return
end

function BattleSkillProjectArea:DoDataEffectWithoutTarget(arg_3_1)
	self:doSpawnAOE(arg_3_1)

	return
end

function BattleSkillProjectArea:doSpawnAOE(arg_4_1)
	local var_4_0 = var_0_0.Battle.BattleDataProxy.GetInstance()
	local var_4_1 = arg_4_1:GetPosition()

	if self._expendDuration > 0 then
		local var_4_2 = var_0_0.Battle.BattleAOEScaleableComponent.New((var_4_0:SpawnLastingCubeArea(var_0_1.AOEField.SURFACE, arg_4_1:GetIFF(), Vector3(var_4_1.x + self._posX, 0, var_4_1.z + self._posZ), self._width, self._height, self._lifeTime, function(arg_5_0)
			for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
				if iter_5_1.Active then
					var_4_0:GetUnitList()[iter_5_1.UID]:AddBuff(var_0_0.Battle.BattleBuffUnit.New(self._buffID), true)
				end
			end

			return
		end, function(arg_6_0)
			if arg_6_0.Active then
				var_4_0:GetUnitList()[arg_6_0.UID]:RemoveBuff(self._buffID, true)
			end

			return
		end, true, self._fx, nil)))

		var_4_2:SetReferenceUnit(arg_4_1)
		var_4_2:ConfigData(var_4_2.EXPEND, {
			expendDuration = self._expendDuration,
			widthSpeed = self._widthSpeed,
			heightSpeed = self._heightSpeed
		})
	end

	return
end

return

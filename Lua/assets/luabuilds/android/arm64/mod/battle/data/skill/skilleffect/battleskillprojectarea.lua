ys = ys or {}

local var_0_0 = ys.Battle.BattleConst
local var_0_3 = class("BattleSkillProjectArea", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillProjectArea = var_0_3
var_0_3.__name = "BattleSkillProjectArea"

function var_0_3.Ctor(arg_1_0, arg_1_1)
	var_0_3.super.Ctor(arg_1_0, arg_1_1, lv)

	arg_1_0._posX = arg_1_0._tempData.arg_list.offset_x
	arg_1_0._posZ = arg_1_0._tempData.arg_list.offset_z
	arg_1_0._width = arg_1_0._tempData.arg_list.width
	arg_1_0._height = arg_1_0._tempData.arg_list.height
	arg_1_0._lifeTime = arg_1_0._tempData.arg_list.life_time
	arg_1_0._fx = arg_1_0._tempData.arg_list.effect
	arg_1_0._expendDuration = arg_1_0._tempData.arg_list.expend_duration
	arg_1_0._widthSpeed = arg_1_0._tempData.arg_list.width_expend_speed
	arg_1_0._heightSpeed = arg_1_0._tempData.arg_list.height_expend_speed
	arg_1_0._buffID = arg_1_0._tempData.arg_list.cld_buff_id

	return
end

function var_0_3.DoDataEffect(arg_2_0, arg_2_1)
	arg_2_0:doSpawnAOE(arg_2_1)

	return
end

function var_0_3.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:doSpawnAOE(arg_3_1)

	return
end

function var_0_3.doSpawnAOE(arg_4_0, arg_4_1)
	local var_4_0 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_4_1 = arg_4_1:GetPosition()

	if arg_4_0._expendDuration > 0 then
		local var_4_2 = var_0.Battle.BattleAOEScaleableComponent.New((var_0.Battle.BattleDataProxy.GetInstance():SpawnLastingCubeArea(var_0_0.AOEField.SURFACE, arg_4_1:GetIFF(), Vector3(var_4_1.x + arg_4_0._posX, 0, var_4_1.z + arg_4_0._posZ), arg_4_0._width, arg_4_0._height, arg_4_0._lifeTime, function(arg_5_0)
			for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
				if iter_5_1.Active then
					var_4_0:GetUnitList()[iter_5_1.UID]:AddBuff(var_0.Battle.BattleBuffUnit.New(arg_4_0._buffID), true)
				end
			end

			return
		end, function(arg_6_0)
			if arg_6_0.Active then
				var_4_0:GetUnitList()[arg_6_0.UID]:RemoveBuff(arg_4_0._buffID, true)
			end

			return
		end, true, arg_4_0._fx, nil)))

		var_4_2:SetReferenceUnit(arg_4_1)
		var_4_2:ConfigData(var_4_2.EXPEND, {
			expendDuration = arg_4_0._expendDuration,
			widthSpeed = arg_4_0._widthSpeed,
			heightSpeed = arg_4_0._heightSpeed
		})
	end

	return
end

return

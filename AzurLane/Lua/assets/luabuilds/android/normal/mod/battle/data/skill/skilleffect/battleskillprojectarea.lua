ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConfig
local var_0_3 = var_0.Battle.BattleEvent

class = var_0_10004

local var_0_4 = var_0_10004("BattleSkillProjectArea", var_0.Battle.BattleSkillEffect)

var_0.Battle.BattleSkillProjectArea = var_0_4
var_0_4.__name = "BattleSkillProjectArea"

function var_0_4.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = var_0_4.super.Ctor
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_1

	lv = var_1_10005

	var_1_0(var_1_1, var_1_2, var_1_10005)

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

function var_0_4.DoDataEffect(arg_2_0, arg_2_1)
	arg_2_0:doSpawnAOE(arg_2_1)

	return
end

function var_0_4.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:doSpawnAOE(arg_3_1)

	return
end

function var_0_4.doSpawnAOE(arg_4_0, arg_4_1)
	local var_4_0 = var_0.Battle.BattleDataProxy.GetInstance()

	local function var_4_1(arg_5_0)
		ipairs = var_2_10001

		for iter_5_0, iter_5_1 in var_2_10001(arg_5_0) do
			if iter_5_1.Active then
				local var_5_0 = var_4_0
				local var_5_1 = var_6.GetUnitList(var_5_0)[iter_5_1.UID]
				local var_5_2 = var_0.Battle.BattleBuffUnit.New(arg_4_0._buffID)

				var_5_1:AddBuff(var_5_2, true)
			end
		end

		return
	end

	local function var_4_2(arg_6_0)
		if arg_6_0.Active then
			local var_6_0 = var_4_0
			local var_6_1 = var_1.GetUnitList(var_6_0)[arg_6_0.UID]

			var_1.RemoveBuff(var_6_1, arg_4_0._buffID, true)
		end

		return
	end

	local var_4_3 = arg_4_1
	local var_4_4 = arg_4_1.GetPosition(var_4_3)

	Vector3 = var_4_3

	local var_4_5 = var_4_3(var_4_4.x + arg_4_0._posX, 0, var_4_4.z + arg_4_0._posZ)
	local var_4_6 = var_4_0:SpawnLastingCubeArea(var_0_1.AOEField.SURFACE, arg_4_1:GetIFF(), var_4_5, arg_4_0._width, arg_4_0._height, arg_4_0._lifeTime, var_4_1, var_4_2, true, arg_4_0._fx, nil)

	if arg_4_0._expendDuration > 0 then
		local var_4_7 = var_0.Battle.BattleAOEScaleableComponent.New(var_4_6)

		var_8.SetReferenceUnit(var_4_7, arg_4_1)

		local var_4_8 = {
			expendDuration = arg_4_0._expendDuration,
			widthSpeed = arg_4_0._widthSpeed,
			heightSpeed = arg_4_0._heightSpeed
		}

		var_8:ConfigData(var_8.EXPEND, var_4_8)
	end

	return
end

return

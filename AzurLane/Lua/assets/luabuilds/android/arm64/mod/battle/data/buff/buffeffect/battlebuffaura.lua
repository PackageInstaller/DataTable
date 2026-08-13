ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffAura", var_0.Battle.BattleBuffEffect)

var_0.Battle.BattleBuffAura = var_0_1
var_0_1.__name = "BattleBuffAura"

local var_0_2 = var_0.Battle.BattleConst
local var_0_3 = var_0.Battle.BattleConfig

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._buffLevel = arg_2_2:GetLv()
	arg_2_0._auraRange = arg_2_0._tempData.arg_list.cld_data.box.range
	arg_2_0._buffID = var_3.buff_id

	local var_2_0

	if not var_3.friendly_fire then
		var_2_0 = false
	end

	arg_2_0._friendly = var_2_0

	local var_2_1, var_2_2, var_2_3 = arg_2_0:getAreaCldFunc(arg_2_1)
	local var_2_4 = var_0.Battle.BattleDataProxy.GetInstance()

	arg_2_0._aura = var_7.SpawnLastingColumnArea(var_2_4, var_0_2.AOEField.SURFACE, arg_2_1:GetIFF(), arg_2_1:GetPosition(), arg_2_0._auraRange, 0, var_2_1, var_2_2, arg_2_0._friendly, nil, var_2_3, false)
	arg_2_0._angle = var_3.cld_data.angle

	if arg_2_0._angle then
		local var_2_5 = arg_2_0._aura

		var_8.SetSectorAngle(var_2_5, arg_2_0._angle, arg_2_1:GetDirection())
	end

	local var_2_6 = var_0.Battle.BattleAOEMobilizedComponent.New(arg_2_0._aura)

	var_8.SetReferenceUnit(var_2_6, arg_2_1)
	var_8:ConfigData(var_8.FOLLOW)

	return
end

function var_0_1.getAreaCldFunc(arg_3_0, arg_3_1)
	local function var_3_0(arg_4_0)
		local var_4_0 = arg_3_0
		local var_4_1 = var_1.getTargetList(var_4_0, arg_3_1, {
			"TargetEntityUnit"
		})

		ipairs = var_2_10002

		for iter_4_0, iter_4_1 in var_2_10002(arg_4_0) do
			if iter_4_1.Active then
				ipairs = var_7

				for iter_4_2, iter_4_3 in var_7(var_4_1) do
					if iter_4_3:GetUniqueID() == iter_4_1.UID then
						local var_4_2 = var_0.Battle.BattleBuffUnit.New(arg_3_0._buffID, arg_3_0._buffLevel, arg_3_0._caster)

						iter_4_3:AddBuff(var_4_2, true)

						break
					end
				end
			end
		end

		return
	end

	local function var_3_1(arg_5_0)
		if arg_5_0.Active then
			local var_5_0 = arg_3_0
			local var_5_1 = var_1.getTargetList(var_5_0, arg_3_1, {
				"TargetEntityUnit"
			})

			ipairs = var_2_10002

			for iter_5_0, iter_5_1 in var_2_10002(var_5_1) do
				if iter_5_1:GetUniqueID() == arg_5_0.UID then
					iter_5_1:RemoveBuff(arg_3_0._buffID, true)

					break
				end
			end
		end

		return
	end

	local function var_3_2(arg_6_0)
		if arg_6_0.Active then
			local var_6_0 = arg_3_0
			local var_6_1 = var_1.getTargetList(var_6_0, arg_3_1, {
				"TargetEntityUnit"
			})

			ipairs = var_2_10002

			for iter_6_0, iter_6_1 in var_2_10002(var_6_1) do
				if iter_6_1:GetUniqueID() == arg_6_0.UID then
					iter_6_1:RemoveBuff(arg_3_0._buffID, true)

					break
				end
			end
		end

		return
	end

	return var_3_0, var_3_1, var_3_2
end

function var_0_1.Clear(arg_7_0)
	local var_7_0 = arg_7_0._aura

	var_1.SetActiveFlag(var_7_0, false)

	arg_7_0._aura = nil

	var_0_1.super.Clear(arg_7_0)

	return
end

return

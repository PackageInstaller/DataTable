ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleEffectBulletUnit", var_0.Battle.BattleBulletUnit)

var_0.Battle.BattleEffectBulletUnit = var_0_1
var_0_1.__name = "BattleEffectBulletUnit"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_1.Update(arg_2_0, arg_2_1)
	var_0_1.super.Update(arg_2_0, arg_2_1)

	if arg_2_0._flare then
		local var_2_0 = arg_2_0._flare
		local var_2_1 = var_2.SetPosition

		pg = var_5

		local var_2_2 = var_5.Tool.FilterY
		local var_2_3 = arg_2_0:GetPosition()

		var_2_1(var_2_0, var_2_2(var_7.Clone(var_2_3)))
	end

	return
end

function var_0_1.IsFlare(arg_3_0)
	return arg_3_0:GetTemplate().attach_buff[1].flare
end

function var_0_1.OutRange(arg_4_0)
	var_0_1.super.OutRange(arg_4_0)

	if arg_4_0._flare then
		local var_4_0 = arg_4_0._flare

		var_1.SetActiveFlag(var_4_0, false)

		arg_4_0._flare = nil
	end

	return
end

function var_0_1.spawnArea(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:GetTemplate().hit_type
	local var_5_1 = var_2.attach_buff[1].buff_id
	local var_5_2

	if not var_4.buff_level then
		var_5_2 = 1
	end

	local function var_5_3(arg_6_0)
		ipairs = var_2_10001

		for iter_6_0, iter_6_1 in var_2_10001(arg_6_0) do
			if iter_6_1.Active then
				local var_6_0 = arg_5_0._battleProxy
				local var_6_1 = var_6.GetUnitList(var_6_0)[iter_6_1.UID]
				local var_6_2 = var_0.Battle.BattleBuffUnit.New(var_5_1, var_5_2)

				var_6_1:AddBuff(var_6_2, true)
			end
		end

		return
	end

	local function var_5_4(arg_7_0)
		if arg_7_0.Active then
			local var_7_0 = arg_5_0._battleProxy
			local var_7_1 = var_1.GetUnitList(var_7_0)[arg_7_0.UID]

			var_1.RemoveBuff(var_7_1, var_5_1, true)
		end

		return
	end

	local var_5_5 = var_5_0.time
	local var_5_6 = time
	local var_5_7

	if var_2.extra_param.ellipse_range then
		local var_5_8 = arg_5_0._battleProxy
		local var_5_9 = var_10.SpawnLastingEllipseArea
		local var_5_10 = arg_5_0
		local var_5_11 = arg_5_0.GetEffectField(var_5_10)
		local var_5_12 = arg_5_0:GetIFF()

		pg = var_5_10

		local var_5_13 = var_5_10.Tool.FilterY
		local var_5_14 = arg_5_0:GetPosition()
		local var_5_15 = var_5_13(var_17.Clone(var_5_14))
		local var_5_16 = var_5_0.range
		local var_5_17 = var_2.extra_param.ellipse_range

		time = var_1_10018
		var_5_7 = var_5_9(var_5_8, var_5_11, var_5_12, var_5_15, var_5_16, var_5_17, var_1_10018, var_5_3, var_5_4, var_4.friendly, var_4.effect_id)
	else
		local var_5_18 = arg_5_0._battleProxy
		local var_5_19 = var_10.SpawnLastingColumnArea
		local var_5_20 = arg_5_0
		local var_5_21 = arg_5_0.GetEffectField(var_5_20)
		local var_5_22 = arg_5_0:GetIFF()

		pg = var_5_20

		local var_5_23 = var_5_20.Tool.FilterY
		local var_5_24 = arg_5_0:GetPosition()
		local var_5_25 = var_5_23(var_17.Clone(var_5_24))
		local var_5_26 = var_5_0.range

		time = var_17
		var_5_7 = var_5_19(var_5_18, var_5_21, var_5_22, var_5_25, var_5_26, var_17, var_5_3, var_5_4, var_4.friendly, var_4.effect_id)
	end

	if arg_5_1 then
		arg_5_0._flare = var_5_7
	end

	var_5_7:SetSource(var_5_7.SOURCE_BULLET_9)

	return var_5_7
end

function var_0_1.GetExplodePostion(arg_8_0)
	return arg_8_0._explodePos
end

function var_0_1.SetExplodePosition(arg_9_0, arg_9_1)
	arg_9_0._explodePos = arg_9_1

	return
end

return

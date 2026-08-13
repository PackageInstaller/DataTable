ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffAuraSquare", var_0.Battle.BattleBuffAura)

var_0.Battle.BattleBuffAuraSquare = var_0_1
var_0_1.__name = "BattleBuffAuraSquare"

local var_0_2 = var_0.Battle.BattleConst
local var_0_3 = var_0.Battle.BattleConfig

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_2_1, var_2_2, var_2_3, var_2_4 = var_3.GetTotalBounds(var_2_0)
	local var_2_5 = var_2_4 - var_2_3
	local var_2_6 = var_2_2 + (var_2_1 - var_2_2) * 0.5
	local var_2_7 = var_2_3 + var_2_5 * 0.5

	arg_2_0._unit = arg_2_1
	arg_2_0._buffLevel = arg_2_2:GetLv()

	local var_2_8

	if not arg_2_0._tempData.arg_list.cld_data.box.width then
		var_2_8 = var_2_5
	end

	arg_2_0._arraWidth = var_2_8

	local var_2_9

	if not var_12.cld_data.box.height then
		var_2_9 = var_9
	end

	arg_2_0._auraHeight = var_2_9
	arg_2_0._buffID = var_12.buff_id

	local var_2_10

	if not var_12.friendly_fire then
		var_2_10 = false
	end

	arg_2_0._friendly = var_2_10

	local var_2_11

	if not var_12.cld_data.box.front_offset then
		var_2_11 = 0
	end

	arg_2_0._frontOffset = var_2_11

	local var_2_12, var_2_13, var_2_14 = arg_2_0:getAreaCldFunc(arg_2_1)
	local var_2_15 = arg_2_1:GetIFF()

	arg_2_0._aura = var_3:SpawnLastingCubeArea(var_0_2.AOEField.SURFACE, var_2_15, arg_2_1:GetPosition(), arg_2_0._arraWidth, arg_2_0._auraHeight, 0, var_2_12, var_2_13, arg_2_0._friendly, nil, var_2_14, false)

	local var_2_16 = var_0.Battle.BattleAOEScaleableComponent.New(arg_2_0._aura)

	var_17.SetReferenceUnit(var_2_16, arg_2_1)

	local var_2_17 = var_2_15 == var_0_3.FRIENDLY_CODE and var_2_3 or var_2_4
	local var_2_18 = {
		upperBound = var_2_1,
		lowerBound = var_2_2,
		rearBound = var_2_17,
		frontOffset = arg_2_0._frontOffset
	}

	var_17:ConfigData(var_17.FILL, var_2_18)

	local function var_2_19(arg_3_0)
		local var_3_0 = arg_2_0._aura
		local var_3_1 = var_1.GetPosition(var_3_0)
		local var_3_2 = arg_2_0._aura
		local var_3_3 = var_2.GetWidth(var_3_2)
		local var_3_4 = arg_2_0._aura
		local var_3_5 = var_3.GetHeight(var_3_4)

		return var_3_1, var_3_3, var_3_5
	end

	arg_2_0._effectIndex = "BattleBuffAuraSquare" .. arg_2_0._buffID

	local var_2_20 = {
		index = arg_2_0._effectIndex,
		effect = var_12.effect,
		fillFunc = var_2_19
	}

	arg_2_1:DispatchEvent(var_0.Event.New(var_0.Battle.BattleUnitEvent.ADD_EFFECT, var_2_20))

	return
end

function var_0_1.Clear(arg_4_0)
	local var_4_0 = arg_4_0._unit

	var_1.DispatchEvent(var_4_0, var_0.Event.New(var_0.Battle.BattleUnitEvent.CANCEL_EFFECT, {
		index = arg_4_0._effectIndex
	}))
	var_0_1.super.Clear(arg_4_0)

	return
end

return

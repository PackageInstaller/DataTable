ys = ys or {}

local var_0_0 = ys
local var_0_1 = class("BattleBuffAuraSquare", ys.Battle.BattleBuffAura)

ys.Battle.BattleBuffAuraSquare = var_0_1
var_0_1.__name = "BattleBuffAuraSquare"

local var_0_2 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleConfig

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0_0.Battle.BattleDataProxy.GetInstance()
	local var_2_1, var_2_2, var_2_3, var_2_4 = var_2_0:GetTotalBounds()

	arg_2_0._unit = arg_2_1
	arg_2_0._buffLevel = arg_2_2:GetLv()

	local var_2_7 = arg_2_0._tempData.arg_list

	arg_2_0._arraWidth = arg_2_0._tempData.arg_list.cld_data.box.width or var_2_4 - var_2_3
	arg_2_0._auraHeight = var_2_7.cld_data.box.height or var_2_1 - var_2_2
	arg_2_0._buffID = var_2_7.buff_id
	arg_2_0._friendly = var_2_7.friendly_fire or false
	arg_2_0._frontOffset = var_2_7.cld_data.box.front_offset or 0

	local var_2_8, var_2_9, var_2_10 = arg_2_0:getAreaCldFunc(arg_2_1)
	local var_2_11 = arg_2_1:GetIFF()

	arg_2_0._aura = var_2_0:SpawnLastingCubeArea(var_0_2.AOEField.SURFACE, var_2_11, arg_2_1:GetPosition(), arg_2_0._arraWidth, arg_2_0._auraHeight, 0, var_2_8, var_2_9, arg_2_0._friendly, nil, var_2_10, false)

	local var_2_12 = var_0_0.Battle.BattleAOEScaleableComponent.New(arg_2_0._aura)

	var_2_12:SetReferenceUnit(arg_2_1)
	var_2_12:ConfigData(var_2_12.FILL, {
		upperBound = var_2_1,
		lowerBound = var_2_2,
		rearBound = var_2_11 == var_0_3.FRIENDLY_CODE and var_2_3 or var_2_4,
		frontOffset = arg_2_0._frontOffset
	})

	arg_2_0._effectIndex = "BattleBuffAuraSquare" .. arg_2_0._buffID

	arg_2_1:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.ADD_EFFECT, {
		index = arg_2_0._effectIndex,
		effect = var_2_7.effect,
		fillFunc = function(arg_3_0)
			return arg_2_0._aura:GetPosition(), arg_2_0._aura:GetWidth(), (arg_2_0._aura:GetHeight())
		end
	}))

	return
end

function var_0_1.Clear(arg_4_0)
	arg_4_0._unit:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CANCEL_EFFECT, {
		index = arg_4_0._effectIndex
	}))
	var_0_1.super.Clear(arg_4_0)

	return
end

return

ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleBuffEvent
local var_0_2 = var_0.Battle.BattleUnitEvent
local var_0_3 = var_0.Battle.BattleResourceManager
local var_0_4 = var_0.Battle.BattleDataFunction
local var_0_5 = var_0.Battle

class = var_0_10006
var_0_5.BattleEffectComponent = var_0_10006("BattleEffectComponent")

local var_0_6 = var_0.Battle.BattleEffectComponent

var_0_6.__name = "BattleEffectComponent"

function var_0_6.Ctor(arg_1_0, arg_1_1)
	var_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0._owner = arg_1_1
	arg_1_0._blinkIDList = {}
	arg_1_0._buffLastEffects = {}
	arg_1_0._currentLastFXID = nil
	arg_1_0._effectIndex = 0
	arg_1_0._effectList = {}

	return
end

function var_0_6.SwitchOwner(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._owner = arg_2_1
	pairs = var_1_10003

	for iter_2_0, iter_2_1 in var_1_10003(arg_2_0._blinkIDList) do
		if arg_2_2[iter_2_1] then
			arg_2_0._blinkIDList[iter_2_0] = arg_2_2[iter_2_1]
		end
	end

	return
end

function var_0_6.ClearEffect(arg_3_0)
	pairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(arg_3_0._blinkIDList) do
		local var_3_0 = arg_3_0._owner

		var_6.RemoveBlink(var_3_0, iter_3_1)
	end

	arg_3_0._blinkIDList = {}

	return
end

function var_0_6.Dispose(arg_4_0)
	pairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0._blinkIDList) do
		local var_4_0 = arg_4_0._owner

		var_6.RemoveBlink(var_4_0, iter_4_1)
	end

	arg_4_0._effectList = nil
	arg_4_0._buffLastEffects = nil

	var_0.EventListener.DetachEventListener(arg_4_0)

	return
end

function var_0_6.GetFXPool(arg_5_0)
	return var_0.Battle.BattleFXPool.GetInstance()
end

function var_0_6.SetUnitDataEvent(arg_6_0, arg_6_1)
	arg_6_1:RegisterEventListener(arg_6_0, var_0_1.BUFF_CAST, arg_6_0.onBuffCast)
	arg_6_1:RegisterEventListener(arg_6_0, var_0_1.BUFF_ATTACH, arg_6_0.onBuffAdd)
	arg_6_1:RegisterEventListener(arg_6_0, var_0_1.BUFF_STACK, arg_6_0.onBuffStack)
	arg_6_1:RegisterEventListener(arg_6_0, var_0_1.BUFF_REMOVE, arg_6_0.onBuffRemove)
	arg_6_1:RegisterEventListener(arg_6_0, var_0_2.ADD_EFFECT, arg_6_0.onAddEffect)
	arg_6_1:RegisterEventListener(arg_6_0, var_0_2.CANCEL_EFFECT, arg_6_0.onCancelEffect)
	arg_6_1:RegisterEventListener(arg_6_0, var_0_2.DEACTIVE_EFFECT, arg_6_0.onDeactiveEffect)

	return
end

function var_0_6.RemoveUnitEvent(arg_7_0, arg_7_1)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_1.BUFF_ATTACH)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_1.BUFF_CAST)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_1.BUFF_STACK)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_1.BUFF_REMOVE)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_2.ADD_EFFECT)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_2.CANCEL_EFFECT)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_2.DEACTIVE_EFFECT)

	return
end

function var_0_6.Update(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._owner
	local var_8_1 = var_2.GetUnitData(var_8_0)

	arg_8_0._dir = var_2.GetDirection(var_8_1)
	pairs = var_2

	for iter_8_0, iter_8_1 in var_2(arg_8_0._effectList) do
		iter_8_1.currentTime = arg_8_1 - iter_8_1.startTime

		arg_8_0:updateEffect(iter_8_1)
	end

	return
end

function var_0_6.onAddEffect(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.Data

	arg_9_0:addEffect(var_9_0)

	return
end

function var_0_6.onCancelEffect(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.Data

	arg_10_0:cancelEffect(var_10_0)

	return
end

function var_0_6.onDeactiveEffect(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.Data

	arg_11_0:deactiveEffect(var_11_0)

	return
end

function var_0_6.onBuffAdd(arg_12_0, arg_12_1)
	arg_12_0:DoWhenAddBuff(arg_12_1)

	return
end

function var_0_6.onBuffCast(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.Data.buff_id

	arg_13_0:addBlink(var_13_0)

	return
end

function var_0_6.DoWhenAddBuff(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.Data.buff_id
	local var_14_1 = arg_14_1.Data.buff_level

	arg_14_0:addInitFX(var_14_0)
	arg_14_0:addLastFX(var_14_0)
	arg_14_0:updateLastFXStackText(var_14_0)

	return
end

function var_0_6.onBuffStack(arg_15_0, arg_15_1)
	arg_15_0:DoWhenStackBuff(arg_15_1)

	return
end

function var_0_6.DoWhenStackBuff(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.Data.buff_id

	arg_16_0:addInitFX(var_16_0)

	local var_16_1 = arg_16_1.Data.stack_count

	if var_0.Battle.BattleDataFunction.GetBuffTemplate(var_16_0).last_effect_stack_list and arg_16_0:checkLastFXID(var_16_0, var_16_1) ~= arg_16_0._currentLastFXID then
		arg_16_0:switchLastFX(var_16_0, var_16_1)
	end

	if var_4.last_effect ~= "" and var_4.last_effect_stack then
		if #arg_16_0._buffLastEffects[var_16_0] < var_16_1 then
			arg_16_0:addLastFX(var_16_0)
		elseif var_16_1 < var_5 then
			local var_16_2 = var_5 - var_16_1

			while var_16_2 > 0 do
				arg_16_0:removeLastFX(var_16_0)

				var_16_2 = var_16_2 - 1
			end
		end
	end

	arg_16_0:updateLastFXStackText(var_16_0)

	return
end

function var_0_6.onBuffRemove(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.Data.buff_id

	if arg_17_0._buffLastEffects[var_17_0] then
		local var_17_1 = #arg_17_0._buffLastEffects[var_17_0]

		while var_17_1 > 0 do
			arg_17_0:removeLastFX(var_17_0)

			var_17_1 = var_17_1 - 1
		end
	end

	if arg_17_0._blinkIDList[var_17_0] then
		local var_17_2 = arg_17_0._owner

		var_4.RemoveBlink(var_17_2, var_3)

		arg_17_0._blinkIDList[var_17_0] = nil
	end

	return
end

function var_0_6.addInitFX(arg_18_0, arg_18_1)
	if var_0.Battle.BattleDataFunction.GetBuffTemplate(arg_18_1).init_effect and var_2.init_effect ~= "" then
		local var_18_0 = var_2.init_effect

		if var_2.skin_adapt then
			local var_18_1 = var_0_4.SkinAdaptFXID
			local var_18_2 = var_18_0
			local var_18_3 = arg_18_0._owner
			local var_18_4 = var_6.GetUnitData(var_18_3)

			var_18_0 = var_18_1(var_18_2, var_6.GetSkinID(var_18_4))
		end

		local var_18_5 = arg_18_0._owner

		var_4.AddFX(var_18_5, var_18_0)
	end

	return
end

function var_0_6.removeLastFX(arg_19_0, arg_19_1)
	if arg_19_0._buffLastEffects[arg_19_1] ~= nil and #var_2 > 0 then
		table = var_3

		local var_19_0 = var_3.remove(var_2)
		local var_19_1 = arg_19_0._owner

		var_4.RemoveFX(var_19_1, var_19_0)
	end

	return
end

function var_0_6.switchLastFX(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = var_0.Battle.BattleDataFunction.GetBuffTemplate(arg_20_1)
	local var_20_1 = arg_20_0:checkLastFXID(arg_20_1, arg_20_2)

	if arg_20_0._currentLastFXID then
		arg_20_0:removeLastFX(arg_20_1)
	end

	if var_20_1 then
		local var_20_2 = arg_20_0:generateLastFX(var_20_0, var_20_1)
		local var_20_3

		if not arg_20_0._buffLastEffects[arg_20_1] then
			var_20_3 = {}
		end

		table = var_7

		var_7.insert(var_20_3, var_20_2)

		arg_20_0._buffLastEffects[arg_20_1] = var_20_3
	end

	return
end

function var_0_6.checkLastFXID(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = var_0.Battle.BattleDataFunction.GetBuffTemplate(arg_21_1)
	local var_21_1

	pairs = var_1_10005

	for iter_21_0, iter_21_1 in var_1_10005(var_21_0.last_effect_stack_list) do
		if iter_21_0 <= arg_21_2 then
			var_21_1 = iter_21_1
		end
	end

	return var_21_1
end

function var_0_6.addLastFX(arg_22_0, arg_22_1)
	if var_0.Battle.BattleDataFunction.GetBuffTemplate(arg_22_1).last_effect ~= nil and var_2.last_effect ~= "" then
		local var_22_0 = arg_22_0:generateLastFX(var_2, var_2.last_effect)
		local var_22_1

		if not arg_22_0._buffLastEffects[arg_22_1] then
			var_22_1 = {}
		end

		table = var_5

		var_5.insert(var_22_1, var_22_0)

		arg_22_0._buffLastEffects[arg_22_1] = var_22_1
	end

	return
end

function var_0_6.updateLastFXStackText(arg_23_0, arg_23_1)
	local var_23_0 = var_0.Battle.BattleDataFunction.GetBuffTemplate(arg_23_1).last_effect_stack_text

	type = var_1_10004

	if var_1_10004(var_23_0) ~= "table" then
		return
	end

	local var_23_1 = var_23_0.node

	type = var_5

	if var_5(var_23_1) ~= "string" or var_23_1 == "" then
		return
	end

	local var_23_2 = arg_23_0._owner
	local var_23_3 = var_5.GetUnitData(var_23_2)

	if not var_5.GetBuff(var_23_3, arg_23_1) then
		return
	end

	local var_23_4

	if not var_5:GetStack() then
		var_23_4 = 1
	end

	local var_23_5 = "X" .. var_23_4

	if not arg_23_0._buffLastEffects[arg_23_1] then
		return
	end

	ipairs = var_1_10009

	for iter_23_0, iter_23_1 in var_1_10009(var_8) do
		if iter_23_1 then
			local var_23_6 = iter_23_1.transform

			if var_14.Find(var_23_6, var_23_1) then
				setText = var_23_6

				var_23_6(var_14, var_23_5)
			end
		end
	end

	return
end

function var_0_6.generateLastFX(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0._currentLastFXID = arg_24_2

	local var_24_0 = arg_24_0._owner
	local var_24_1 = var_3.AddFX(var_24_0, arg_24_2)

	if arg_24_1.last_effect_cld_scale or arg_24_1.last_effect_cld_angle then
		local var_24_2

		buffLv = var_5

		local var_24_3

		if not arg_24_1[var_5] then
			var_24_3 = arg_24_1.effect_list
		end

		ipairs = var_1_10006

		for iter_24_0, iter_24_1 in var_1_10006(var_24_3) do
			if iter_24_1.arg_list.cld_data then
				var_24_2 = iter_24_1

				break
			end
		end

		if var_24_2 then
			if arg_24_1.last_effect_cld_scale then
				local var_24_4 = var_24_2.arg_list.cld_data.box
				local var_24_5 = var_24_1.transform.localScale

				if var_24_4.range then
					var_24_5.x = var_24_5.x * var_24_4.range
					var_24_5.y = var_24_5.y * var_24_4.range
					var_24_5.z = var_24_5.z * var_24_4.range
				else
					var_24_5.x = var_24_5.x * var_24_4[1]
					var_24_5.y = var_24_5.y * var_24_4[2]
					var_24_5.z = var_24_5.z * var_24_4[3]
				end

				var_24_1.transform.localScale = var_24_5
			end

			if arg_24_1.last_effect_cld_angle then
				local var_24_6 = var_24_2.arg_list.cld_data.angle
				local var_24_7 = var_24_1.transform
				local var_24_8 = var_7.Find(var_24_7, "scale/sector")
				local var_24_9 = var_7.GetComponent

				typeof = var_9
				Renderer = iter_24_1

				local var_24_10 = var_24_9(var_24_8, var_9(iter_24_1)).material
				local var_24_11 = (360 - var_24_6) * 0.5 - 5

				var_24_10:SetInt("_AngleControl", var_24_11)
			end

			if arg_24_1.last_effect_bound_bone then
				local var_24_12 = arg_24_0._owner

				if var_6.GetBoneList(var_24_12)[arg_24_1.last_effect_bound_bone] then
					var_24_1.transform.localPosition = var_6[1]
				end
			end
		end
	end

	var_24_1:SetActive(true)

	return var_24_1
end

function var_0_6.addBlink(arg_25_0, arg_25_1)
	if var_0.Battle.BattleDataFunction.GetBuffTemplate(arg_25_1).blink then
		local var_25_0 = var_2.blink
		local var_25_1 = arg_25_0._owner
		local var_25_2 = var_4.AddBlink(var_25_1, var_25_0[1], var_25_0[2], var_25_0[3], var_25_0[4], var_25_0[5])

		arg_25_0._blinkIDList[arg_25_1] = var_25_2
	end

	return
end

function var_0_6.addEffect(arg_26_0, arg_26_1)
	local var_26_0

	if not arg_26_1.index then
		var_26_0 = arg_26_0:getIndex()
	end

	if arg_26_0._effectList[var_26_0] then
		local var_26_1 = var_3.effect_tf.localScale
		local var_26_2 = var_3.effect_go

		var_5.SetActive(var_26_2, true)

		var_3.effect_tf.localScale = var_26_1
	else
		local var_26_3 = arg_26_0._owner

		if not var_4.AddFX(var_26_3, arg_26_1.effect) then
			return
		end

		local var_26_4 = {
			currentTime = 0,
			effect_go = var_4,
			effect_tf = var_4.transform,
			posFun = arg_26_1.posFun,
			rotationFun = arg_26_1.rotationFun
		}

		pg = var_6

		local var_26_5 = var_6.TimeMgr.GetInstance()

		var_26_4.startTime = var_6.GetCombatTime(var_26_5)
		var_26_4.fillFunc = arg_26_1.fillFunc

		local var_26_6 = var_26_4

		arg_26_0._effectList[var_26_0] = var_26_6

		arg_26_0:updateEffect(var_26_6)

		pg = var_5

		local var_26_7 = var_5.EffectMgr.GetInstance()

		var_5.PlayBattleEffect(var_26_7, var_4, var_4.transform.localPosition, false, function(arg_27_0)
			local var_27_0 = arg_26_0._owner

			var_1.RemoveFX(var_27_0, var_0)

			arg_26_0._effectList[var_26_0] = nil

			return
		end)
	end

	return
end

function var_0_6.cancelEffect(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1.index

	if arg_28_0._effectList[var_28_0] then
		local var_28_1 = arg_28_0._owner

		var_4.RemoveFX(var_28_1, var_3.effect_go)

		arg_28_0._effectList[var_28_0] = nil
	end

	return
end

function var_0_6.deactiveEffect(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1.index

	if arg_29_0._effectList[var_29_0] then
		local var_29_1 = var_3.effect_go

		var_4.SetActive(var_29_1, false)
	end

	return
end

function var_0_6.getIndex(arg_30_0)
	arg_30_0._effectIndex = arg_30_0._effectIndex + 1

	return arg_30_0._effectIndex
end

function var_0_6.updateEffect(arg_31_0, arg_31_1)
	if arg_31_1.posFun then
		local var_31_0 = arg_31_1.posFun(arg_31_1.currentTime)

		arg_31_1.effect_tf.localPosition = var_31_0
	end

	if arg_31_1.rotationFun then
		local var_31_1 = arg_31_1.rotationFun(arg_31_1.currentTime)

		if arg_31_0._dir == var_0.Battle.BattleConst.UnitDir.LEFT then
			var_31_1.y = var_31_1.y - 180
		end

		arg_31_1.effect_tf.localEulerAngles = var_31_1
	end

	if arg_31_1.fillFunc then
		local var_31_3

		if not arg_31_0._characterScaleX then
			local var_31_2 = arg_31_0._owner

			var_31_3 = var_2.GetTf(var_31_2).localScale.x
		end

		arg_31_0._characterScaleX = var_31_3

		local var_31_5

		if not arg_31_0._characterScaleZ then
			local var_31_4 = arg_31_0._owner

			var_31_5 = var_2.GetTf(var_31_4).localScale.z
		end

		arg_31_0._characterScaleZ = var_31_5

		local var_31_6, var_31_7, var_31_8 = arg_31_1.fillFunc()

		arg_31_1.effect_tf.position = var_31_6

		local var_31_9 = arg_31_1.effect_tf

		Vector3 = var_1_10006
		var_31_9.localScale = var_1_10006(var_31_7 / arg_31_0._characterScaleX, 0, var_31_8 / arg_31_0._characterScaleZ)
	end

	return
end

return

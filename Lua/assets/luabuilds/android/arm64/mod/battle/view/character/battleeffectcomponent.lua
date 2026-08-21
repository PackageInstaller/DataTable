ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleBuffEvent
local var_0_2 = ys.Battle.BattleUnitEvent
local var_0_4 = ys.Battle.BattleDataFunction

ys.Battle.BattleEffectComponent = class("BattleEffectComponent")
ys.Battle.BattleEffectComponent.__name = "BattleEffectComponent"

function ys.Battle.BattleEffectComponent.Ctor(arg_1_0, arg_1_1)
	var_0_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0._owner = arg_1_1
	arg_1_0._blinkIDList = {}
	arg_1_0._buffLastEffects = {}
	arg_1_0._currentLastFXID = nil
	arg_1_0._effectIndex = 0
	arg_1_0._effectList = {}

	return
end

function ys.Battle.BattleEffectComponent.SwitchOwner(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._owner = arg_2_1

	for iter_2_0, iter_2_1 in pairs(arg_2_0._blinkIDList) do
		if arg_2_2[iter_2_1] then
			arg_2_0._blinkIDList[iter_2_0] = arg_2_2[iter_2_1]
		end
	end

	return
end

function ys.Battle.BattleEffectComponent.ClearEffect(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0._blinkIDList) do
		arg_3_0._owner:RemoveBlink(iter_3_1)
	end

	arg_3_0._blinkIDList = {}

	return
end

function ys.Battle.BattleEffectComponent.Dispose(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0._blinkIDList) do
		arg_4_0._owner:RemoveBlink(iter_4_1)
	end

	arg_4_0._effectList = nil
	arg_4_0._buffLastEffects = nil

	var_0_0.EventListener.DetachEventListener(arg_4_0)

	return
end

function ys.Battle.BattleEffectComponent.GetFXPool(arg_5_0)
	return var_0_0.Battle.BattleFXPool.GetInstance()
end

function ys.Battle.BattleEffectComponent.SetUnitDataEvent(arg_6_0, arg_6_1)
	arg_6_1:RegisterEventListener(arg_6_0, var_0_1.BUFF_CAST, arg_6_0.onBuffCast)
	arg_6_1:RegisterEventListener(arg_6_0, var_0_1.BUFF_ATTACH, arg_6_0.onBuffAdd)
	arg_6_1:RegisterEventListener(arg_6_0, var_0_1.BUFF_STACK, arg_6_0.onBuffStack)
	arg_6_1:RegisterEventListener(arg_6_0, var_0_1.BUFF_REMOVE, arg_6_0.onBuffRemove)
	arg_6_1:RegisterEventListener(arg_6_0, var_0_2.ADD_EFFECT, arg_6_0.onAddEffect)
	arg_6_1:RegisterEventListener(arg_6_0, var_0_2.CANCEL_EFFECT, arg_6_0.onCancelEffect)
	arg_6_1:RegisterEventListener(arg_6_0, var_0_2.DEACTIVE_EFFECT, arg_6_0.onDeactiveEffect)

	return
end

function ys.Battle.BattleEffectComponent.RemoveUnitEvent(arg_7_0, arg_7_1)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_1.BUFF_ATTACH)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_1.BUFF_CAST)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_1.BUFF_STACK)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_1.BUFF_REMOVE)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_2.ADD_EFFECT)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_2.CANCEL_EFFECT)
	arg_7_1:UnregisterEventListener(arg_7_0, var_0_2.DEACTIVE_EFFECT)

	return
end

function ys.Battle.BattleEffectComponent.Update(arg_8_0, arg_8_1)
	arg_8_0._dir = arg_8_0._owner:GetUnitData():GetDirection()

	for iter_8_0, iter_8_1 in pairs(arg_8_0._effectList) do
		iter_8_1.currentTime = arg_8_1 - iter_8_1.startTime

		arg_8_0:updateEffect(iter_8_1)
	end

	return
end

function ys.Battle.BattleEffectComponent.onAddEffect(arg_9_0, arg_9_1)
	arg_9_0:addEffect(arg_9_1.Data)

	return
end

function ys.Battle.BattleEffectComponent.onCancelEffect(arg_10_0, arg_10_1)
	arg_10_0:cancelEffect(arg_10_1.Data)

	return
end

function ys.Battle.BattleEffectComponent.onDeactiveEffect(arg_11_0, arg_11_1)
	arg_11_0:deactiveEffect(arg_11_1.Data)

	return
end

function ys.Battle.BattleEffectComponent.onBuffAdd(arg_12_0, arg_12_1)
	arg_12_0:DoWhenAddBuff(arg_12_1)

	return
end

function ys.Battle.BattleEffectComponent.onBuffCast(arg_13_0, arg_13_1)
	arg_13_0:addBlink(arg_13_1.Data.buff_id)

	return
end

function ys.Battle.BattleEffectComponent.DoWhenAddBuff(arg_14_0, arg_14_1)
	arg_14_0:addInitFX(arg_14_1.Data.buff_id)
	arg_14_0:addLastFX(arg_14_1.Data.buff_id)
	arg_14_0:updateLastFXStackText(arg_14_1.Data.buff_id)

	return
end

function ys.Battle.BattleEffectComponent.onBuffStack(arg_15_0, arg_15_1)
	arg_15_0:DoWhenStackBuff(arg_15_1)

	return
end

function ys.Battle.BattleEffectComponent.DoWhenStackBuff(arg_16_0, arg_16_1)
	arg_16_0:addInitFX(arg_16_1.Data.buff_id)

	local var_16_0 = var_0_0.Battle.BattleDataFunction.GetBuffTemplate(arg_16_1.Data.buff_id)

	if var_16_0.last_effect_stack_list and arg_16_0:checkLastFXID(arg_16_1.Data.buff_id, arg_16_1.Data.stack_count) ~= arg_16_0._currentLastFXID then
		arg_16_0:switchLastFX(arg_16_1.Data.buff_id, arg_16_1.Data.stack_count)
	end

	if var_16_0.last_effect ~= "" and var_16_0.last_effect_stack then
		if #arg_16_0._buffLastEffects[arg_16_1.Data.buff_id] < arg_16_1.Data.stack_count then
			arg_16_0:addLastFX(arg_16_1.Data.buff_id)
		elseif arg_16_1.Data.stack_count < #arg_16_0._buffLastEffects[arg_16_1.Data.buff_id] then
			while #arg_16_0._buffLastEffects[arg_16_1.Data.buff_id] - arg_16_1.Data.stack_count > 0 do
				arg_16_0:removeLastFX(arg_16_1.Data.buff_id)
			end
		end
	end

	arg_16_0:updateLastFXStackText(arg_16_1.Data.buff_id)

	return
end

function ys.Battle.BattleEffectComponent.onBuffRemove(arg_17_0, arg_17_1)
	if arg_17_0._buffLastEffects[arg_17_1.Data.buff_id] then
		local var_17_0 = #arg_17_0._buffLastEffects[arg_17_1.Data.buff_id]

		while var_17_0 > 0 do
			arg_17_0:removeLastFX(arg_17_1.Data.buff_id)

			var_17_0 = var_17_0 - 1
		end
	end

	local var_17_1 = arg_17_0._blinkIDList[arg_17_1.Data.buff_id]

	if arg_17_0._blinkIDList[arg_17_1.Data.buff_id] then
		arg_17_0._owner:RemoveBlink(var_17_1)

		arg_17_0._blinkIDList[arg_17_1.Data.buff_id] = nil
	end

	return
end

function ys.Battle.BattleEffectComponent.addInitFX(arg_18_0, arg_18_1)
	local var_18_0 = var_0_0.Battle.BattleDataFunction.GetBuffTemplate(arg_18_1)

	if var_18_0.init_effect and var_18_0.init_effect ~= "" then
		local var_18_1 = var_18_0.init_effect

		if var_18_0.skin_adapt then
			var_18_1 = var_0_4.SkinAdaptFXID(var_18_1, arg_18_0._owner:GetUnitData():GetSkinID())
		end

		arg_18_0._owner:AddFX(var_18_1)
	end

	return
end

function ys.Battle.BattleEffectComponent.removeLastFX(arg_19_0, arg_19_1)
	if arg_19_0._buffLastEffects[arg_19_1] ~= nil and #arg_19_0._buffLastEffects[arg_19_1] > 0 then
		arg_19_0._owner:RemoveFX((table.remove(arg_19_0._buffLastEffects[arg_19_1])))
	end

	return
end

function ys.Battle.BattleEffectComponent.switchLastFX(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0:checkLastFXID(arg_20_1, arg_20_2)

	if arg_20_0._currentLastFXID then
		arg_20_0:removeLastFX(arg_20_1)
	end

	if var_20_0 then
		local var_20_1 = arg_20_0._buffLastEffects[arg_20_1] or {}

		table.insert(var_20_1, (arg_20_0:generateLastFX(var_0_0.Battle.BattleDataFunction.GetBuffTemplate(arg_20_1), var_20_0)))

		arg_20_0._buffLastEffects[arg_20_1] = var_20_1
	end

	return
end

function ys.Battle.BattleEffectComponent.checkLastFXID(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0

	for iter_21_0, iter_21_1 in pairs(var_0_0.Battle.BattleDataFunction.GetBuffTemplate(arg_21_1).last_effect_stack_list) do
		if iter_21_0 <= arg_21_2 then
			var_21_0 = iter_21_1
		end
	end

	return var_21_0
end

function ys.Battle.BattleEffectComponent.addLastFX(arg_22_0, arg_22_1)
	local var_22_0 = var_0_0.Battle.BattleDataFunction.GetBuffTemplate(arg_22_1)

	if var_22_0.last_effect ~= nil and var_22_0.last_effect ~= "" then
		local var_22_1 = arg_22_0._buffLastEffects[arg_22_1] or {}

		table.insert(var_22_1, (arg_22_0:generateLastFX(var_22_0, var_22_0.last_effect)))

		arg_22_0._buffLastEffects[arg_22_1] = var_22_1
	end

	return
end

function ys.Battle.BattleEffectComponent.updateLastFXStackText(arg_23_0, arg_23_1)
	local var_23_0 = var_0_0.Battle.BattleDataFunction.GetBuffTemplate(arg_23_1).last_effect_stack_text

	if type(var_23_0) ~= "table" then
		return
	end

	local var_23_1 = var_23_0.node

	if type(var_23_0.node) ~= "string" or var_23_1 == "" then
		return
	end

	local var_23_2 = arg_23_0._owner:GetUnitData():GetBuff(arg_23_1)

	if not var_23_2 then
		return
	end

	local var_23_3 = var_23_2:GetStack() or 1
	local var_23_4 = "X" .. var_23_3

	if not arg_23_0._buffLastEffects[arg_23_1] then
		return
	end

	for iter_23_0, iter_23_1 in ipairs(arg_23_0._buffLastEffects[arg_23_1]) do
		if iter_23_1 then
			local var_23_5 = iter_23_1.transform:Find(var_23_1)

			if var_23_5 then
				setText(var_23_5, var_23_4)
			end
		end
	end

	return
end

function ys.Battle.BattleEffectComponent.generateLastFX(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0._currentLastFXID = arg_24_2

	local var_24_0 = arg_24_0._owner:AddFX(arg_24_2)

	if arg_24_1.last_effect_cld_scale or arg_24_1.last_effect_cld_angle then
		local var_24_1
		local var_24_2 = arg_24_1[buffLv] or arg_24_1.effect_list

		for iter_24_0, iter_24_1 in ipairs(var_24_2) do
			if iter_24_1.arg_list.cld_data then
				var_24_1 = iter_24_1

				break
			end
		end

		if var_24_1 then
			if arg_24_1.last_effect_cld_scale then
				local var_24_3 = var_24_0.transform.localScale

				if var_24_1.arg_list.cld_data.box.range then
					var_24_3.x = var_24_3.x * var_24_1.arg_list.cld_data.box.range
					var_24_3.y = var_24_3.y * var_24_1.arg_list.cld_data.box.range
					var_24_3.z = var_24_3.z * var_24_1.arg_list.cld_data.box.range
				else
					var_24_3.x = var_24_3.x * var_24_1.arg_list.cld_data.box[1]
					var_24_3.y = var_24_3.y * var_24_1.arg_list.cld_data.box[2]
					var_24_3.z = var_24_3.z * var_24_1.arg_list.cld_data.box[3]
				end

				var_24_0.transform.localScale = var_24_3
			end

			if arg_24_1.last_effect_cld_angle then
				var_24_0.transform:Find("scale/sector"):GetComponent(typeof(Renderer)).material:SetInt("_AngleControl", (360 - var_24_1.arg_list.cld_data.angle) * 0.5 - 5)
			end

			if arg_24_1.last_effect_bound_bone then
				local var_24_4 = arg_24_0._owner:GetBoneList()[arg_24_1.last_effect_bound_bone]

				if var_24_4 then
					var_24_0.transform.localPosition = var_24_4[1]
				end
			end
		end
	end

	var_24_0:SetActive(true)

	return var_24_0
end

function ys.Battle.BattleEffectComponent.addBlink(arg_25_0, arg_25_1)
	local var_25_0 = var_0_0.Battle.BattleDataFunction.GetBuffTemplate(arg_25_1)

	if var_25_0.blink then
		arg_25_0._blinkIDList[arg_25_1] = arg_25_0._owner:AddBlink(var_25_0.blink[1], var_25_0.blink[2], var_25_0.blink[3], var_25_0.blink[4], var_25_0.blink[5])
	end

	return
end

function ys.Battle.BattleEffectComponent.addEffect(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1.index or arg_26_0:getIndex()
	local var_26_1 = arg_26_0._effectList[var_26_0]

	if arg_26_0._effectList[var_26_0] then
		var_26_1.effect_go:SetActive(true)

		var_26_1.effect_tf.localScale = var_26_1.effect_tf.localScale
	else
		local var_26_2 = arg_26_0._owner:AddFX(arg_26_1.effect)

		if not var_26_2 then
			return
		end

		local var_26_3 = {
			currentTime = 0,
			effect_go = var_26_2,
			effect_tf = var_26_2.transform,
			posFun = arg_26_1.posFun,
			rotationFun = arg_26_1.rotationFun
		}

		var_26_3.startTime = pg.TimeMgr.GetInstance():GetCombatTime()
		var_26_3.fillFunc = arg_26_1.fillFunc
		arg_26_0._effectList[var_26_0] = var_26_3

		arg_26_0:updateEffect(var_26_3)
		pg.EffectMgr.GetInstance():PlayBattleEffect(var_26_2, var_26_2.transform.localPosition, false, function(arg_27_0)
			arg_26_0._owner:RemoveFX(var_26_2)

			arg_26_0._effectList[var_26_0] = nil

			return
		end)
	end

	return
end

function ys.Battle.BattleEffectComponent.cancelEffect(arg_28_0, arg_28_1)
	if arg_28_0._effectList[arg_28_1.index] then
		arg_28_0._owner:RemoveFX(arg_28_0._effectList[arg_28_1.index].effect_go)

		arg_28_0._effectList[arg_28_1.index] = nil
	end

	return
end

function ys.Battle.BattleEffectComponent.deactiveEffect(arg_29_0, arg_29_1)
	if arg_29_0._effectList[arg_29_1.index] then
		arg_29_0._effectList[arg_29_1.index].effect_go:SetActive(false)
	end

	return
end

function ys.Battle.BattleEffectComponent.getIndex(arg_30_0)
	arg_30_0._effectIndex = arg_30_0._effectIndex + 1

	return arg_30_0._effectIndex
end

function ys.Battle.BattleEffectComponent.updateEffect(arg_31_0, arg_31_1)
	if arg_31_1.posFun then
		arg_31_1.effect_tf.localPosition = arg_31_1.posFun(arg_31_1.currentTime)
	end

	if arg_31_1.rotationFun then
		local var_31_0 = arg_31_1.rotationFun(arg_31_1.currentTime)

		if arg_31_0._dir == var_0_0.Battle.BattleConst.UnitDir.LEFT then
			var_31_0.y = var_31_0.y - 180
		end

		arg_31_1.effect_tf.localEulerAngles = var_31_0
	end

	if arg_31_1.fillFunc then
		arg_31_0._characterScaleX = arg_31_0._characterScaleX or arg_31_0._owner:GetTf().localScale.x
		arg_31_0._characterScaleZ = arg_31_0._characterScaleZ or arg_31_0._owner:GetTf().localScale.z

		local var_31_1, var_31_2, var_31_3 = arg_31_1.fillFunc()

		arg_31_1.effect_tf.position = var_31_1
		arg_31_1.effect_tf.localScale = Vector3(var_31_2 / arg_31_0._characterScaleX, 0, var_31_3 / arg_31_0._characterScaleZ)
	end

	return
end

return

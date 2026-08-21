ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleSkillUnit = class("BattleSkillUnit")
ys.Battle.BattleSkillUnit.__name = "BattleSkillUnit"

function ys.Battle.BattleSkillUnit.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._id = arg_1_1
	arg_1_0._level = arg_1_2
	arg_1_0._tempData = var_0_0.Battle.BattleDataFunction.GetSkillTemplate(arg_1_1, arg_1_2)
	arg_1_0._cd = arg_1_0._tempData.cd
	arg_1_0._effectList = {}
	arg_1_0._lastEffectTarget = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._tempData.effect_list) do
		arg_1_0._effectList[iter_1_0] = var_0_0.Battle[iter_1_1.type].New(iter_1_1, arg_1_2)
	end

	arg_1_0._dataProxy = var_0_0.Battle.BattleDataProxy.GetInstance()

	return
end

function ys.Battle.BattleSkillUnit.GenerateSpell(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = var_0_0.Battle.BattleSkillUnit.New(arg_2_0, arg_2_1)

	var_2_0._attachData = arg_2_3

	return var_2_0
end

function ys.Battle.BattleSkillUnit.GetSkillEffectList(arg_3_0)
	return arg_3_0._effectList
end

function ys.Battle.BattleSkillUnit.Cast(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._tempData.focus_duration then
		var_0_0.Battle.BattleState.GetInstance():GetUIMediator():ShowSkillPainting(arg_4_1, arg_4_0._tempData)
	end

	if arg_4_0._tempData.painting == 1 then
		if arg_4_2 then
			arg_4_1:DispatchSkillFloat(arg_4_2:getSkills()[1]:getConfig("name"), arg_4_2:getPainting())
		else
			arg_4_1:DispatchSkillFloat(arg_4_0._tempData.name)
		end
	elseif type(arg_4_0._tempData.painting) == "string" then
		arg_4_1:DispatchSkillFloat(arg_4_0._tempData.name, nil, arg_4_0._tempData.painting)
	end

	local var_4_0 = type(arg_4_0._tempData.castCV)

	if var_4_0 == "string" then
		arg_4_1:DispatchVoice(arg_4_0._tempData.castCV)
	elseif var_4_0 == "table" then
		local var_4_1, var_4_2, var_4_3 = ShipWordHelper.GetWordAndCV(arg_4_0._tempData.castCV.skinID, arg_4_0._tempData.castCV.key)

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_4_2)
	end

	local var_4_4 = arg_4_0._attachData

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._effectList) do
		local var_4_5 = iter_4_1:GetTarget(arg_4_1, arg_4_0)

		arg_4_0._lastEffectTarget = var_4_5

		iter_4_1:SetCommander(arg_4_2)
		iter_4_1:Effect(arg_4_1, var_4_5, var_4_4)
	end

	if arg_4_0._tempData.aniEffect and arg_4_0._tempData.aniEffect ~= "" then
		arg_4_1:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.ADD_EFFECT, {
			effect = arg_4_0._tempData.aniEffect.effect,
			time = arg_4_0._tempData.aniEffect.time,
			offset = arg_4_0._tempData.aniEffect.offset,
			posFun = arg_4_0._tempData.aniEffect.posFun
		}))
	end

	return
end

function ys.Battle.BattleSkillUnit.SetTarget(arg_5_0, arg_5_1)
	arg_5_0._lastEffectTarget = arg_5_1

	return
end

function ys.Battle.BattleSkillUnit.Interrupt(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._effectList) do
		iter_6_1:Interrupt()
	end

	return
end

function ys.Battle.BattleSkillUnit.Clear(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._effectList) do
		iter_7_1:Clear()
	end

	return
end

function ys.Battle.BattleSkillUnit.GetDamageSum(arg_8_0)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._effectList) do
		var_8_0 = iter_8_1:GetDamageSum() + var_8_0
	end

	return var_8_0
end

function ys.Battle.BattleSkillUnit.IsFireSkill(arg_9_0, arg_9_1)
	local var_9_0 = false

	for iter_9_0, iter_9_1 in ipairs(var_0_0.Battle.BattleDataFunction.GetSkillTemplate(arg_9_0, arg_9_1).effect_list) do
		if iter_9_1.type == var_0_0.Battle.BattleSkillFire.__name or iter_9_1.type == var_0_0.Battle.BattleSkillFireSupport.__name then
			var_9_0 = true

			break
		end
	end

	return var_9_0
end

return

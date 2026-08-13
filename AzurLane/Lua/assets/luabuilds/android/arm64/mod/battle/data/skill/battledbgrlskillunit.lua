ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleVariable
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleSkillUnit = var_0_10004("BattleSkillUnit")
var_0.Battle.BattleSkillUnit.__name = "BattleSkillUnit"

local var_0_4 = var_0.Battle.BattleSkillUnit

function var_0_4.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._id = arg_1_1
	arg_1_0._level = arg_1_2
	arg_1_0._tempData = var_0.Battle.BattleDataFunction.GetSkillTemplate(arg_1_1, arg_1_2)
	arg_1_0._cd = arg_1_0._tempData.cd
	arg_1_0._effectList = {}
	arg_1_0._lastEffectTarget = {}
	ipairs = var_3

	for iter_1_0, iter_1_1 in var_3(arg_1_0._tempData.effect_list) do
		local var_1_0 = iter_1_1.type

		arg_1_0._effectList[iter_1_0] = var_0.Battle[var_1_0].New(iter_1_1, arg_1_2)
	end

	arg_1_0._dataProxy = var_0.Battle.BattleDataProxy.GetInstance()

	return
end

function var_0_4.GenerateSpell(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = var_0.Battle.BattleSkillUnit.New(arg_2_0, arg_2_1)

	var_2_0._attachData = arg_2_3

	return var_2_0
end

function var_0_4.GetSkillEffectList(arg_3_0)
	return arg_3_0._effectList
end

function var_0_4.Cast(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = var_0.Battle.BattleState.GetInstance()
	local var_4_1 = var_3.GetUIMediator(var_4_0)

	if arg_4_0._tempData.focus_duration then
		var_4_1:ShowSkillPainting(arg_4_1, arg_4_0._tempData)
	end

	local var_4_3

	if arg_4_0._tempData.painting == 1 then
		if arg_4_2 then
			local var_4_2 = arg_4_1

			var_4_3 = arg_4_1.DispatchSkillFloat

			local var_4_4 = arg_4_2:getSkills()[1]

			var_4_3(var_4_2, var_8.getConfig(var_4_4, "name"), arg_4_2:getPainting())
		else
			arg_4_1:DispatchSkillFloat(arg_4_0._tempData.name)
		end
	else
		type = var_4_3

		if var_4_3(arg_4_0._tempData.painting) == "string" then
			arg_4_1:DispatchSkillFloat(arg_4_0._tempData.name, nil, arg_4_0._tempData.painting)
		end
	end

	type = var_4_3

	local var_4_6

	if var_4_3(arg_4_0._tempData.castCV) == "string" then
		arg_4_1:DispatchVoice(arg_4_0._tempData.castCV)
	elseif var_5 == "table" then
		ShipWordHelper = var_4_0

		local var_4_5, var_4_7

		var_4_5, var_4_6, var_4_7 = var_4_0.GetWordAndCV(arg_4_0._tempData.castCV.skinID, arg_4_0._tempData.castCV.key)
		pg = var_9

		local var_4_8 = var_9.CriMgr.GetInstance()

		var_9.PlaySoundEffect_V3(var_4_8, var_4_6)
	end

	local var_4_9 = arg_4_0._attachData

	ipairs = var_4_6

	for iter_4_0, iter_4_1 in var_4_6(arg_4_0._effectList) do
		arg_4_0._lastEffectTarget = iter_4_1:GetTarget(arg_4_1, arg_4_0)

		iter_4_1:SetCommander(arg_4_2)
		iter_4_1:Effect(arg_4_1, var_12, var_4_9)
	end

	if arg_4_0._tempData.aniEffect and var_7 ~= "" then
		local var_4_10 = {
			effect = var_7.effect,
			time = var_7.time,
			offset = var_7.offset,
			posFun = var_7.posFun
		}

		arg_4_1:DispatchEvent(var_0.Event.New(var_0.Battle.BattleUnitEvent.ADD_EFFECT, var_4_10))
	end

	return
end

function var_0_4.SetTarget(arg_5_0, arg_5_1)
	arg_5_0._lastEffectTarget = arg_5_1

	return
end

function var_0_4.Interrupt(arg_6_0)
	ipairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0._effectList) do
		iter_6_1:Interrupt()
	end

	return
end

function var_0_4.Clear(arg_7_0)
	ipairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0._effectList) do
		iter_7_1:Clear()
	end

	return
end

function var_0_4.GetDamageSum(arg_8_0)
	local var_8_0 = 0

	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0._effectList) do
		var_8_0 = iter_8_1:GetDamageSum() + var_8_0
	end

	return var_8_0
end

function var_0_4.IsFireSkill(arg_9_0, arg_9_1)
	local var_9_0 = false
	local var_9_1 = var_0.Battle.BattleDataFunction.GetSkillTemplate(arg_9_0, arg_9_1)

	ipairs = var_1_10004

	for iter_9_0, iter_9_1 in var_1_10004(var_9_1.effect_list) do
		if iter_9_1.type == var_0.Battle.BattleSkillFire.__name or iter_9_1.type == var_0.Battle.BattleSkillFireSupport.__name then
			var_9_0 = true

			break
		end
	end

	return var_9_0
end

return

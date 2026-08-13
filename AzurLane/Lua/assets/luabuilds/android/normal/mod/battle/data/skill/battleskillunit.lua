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

	arg_1_0._finaleEffectCount = 0
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

	if arg_4_0._tempData.focus_duration then
		arg_4_1:DispatchCutIn(arg_4_0._tempData)
	end

	local var_4_2

	if arg_4_0._tempData.painting == 1 then
		if arg_4_2 then
			local var_4_1 = arg_4_1

			var_4_2 = arg_4_1.DispatchSkillFloat

			local var_4_3 = arg_4_2:getSkills()[1]

			var_1_10006 = var_1_10006.getConfig(var_4_3, "name")
			var_1_10008 = arg_4_2

			var_4_2(var_4_1, var_1_10006, arg_4_2.getPainting(var_1_10008))
		else
			arg_4_1:DispatchSkillFloat(arg_4_0._tempData.name)
		end
	else
		type = var_4_2

		if var_4_2(arg_4_0._tempData.painting) == "string" then
			arg_4_1:DispatchSkillFloat(arg_4_0._tempData.name, nil, arg_4_0._tempData.painting)
		end
	end

	type = var_4_2

	if var_4_2(arg_4_0._tempData.castCV) == "string" then
		var_1_10006 = arg_4_1

		arg_4_1.DispatchVoice(var_1_10006, arg_4_0._tempData.castCV)
	elseif var_4 == "table" then
		ShipWordHelper = var_5

		local var_4_4, var_4_5

		var_4_4, var_1_10006, var_4_5 = var_5.GetWordAndCV(arg_4_0._tempData.castCV.skinID, arg_4_0._tempData.castCV.key)
		pg = var_1_10008

		local var_4_6 = var_1_10008.CriMgr.GetInstance()

		var_8.PlaySoundEffect_V3(var_4_6, var_1_10006)
	end

	if arg_4_0._tempData.sfx then
		var_0.Battle.PlayBattleSFX(arg_4_0._tempData.sfx)
	end

	local var_4_7 = arg_4_0._attachData

	ipairs = var_1_10006

	for iter_4_0, iter_4_1 in var_1_10006(arg_4_0._effectList) do
		arg_4_0._lastEffectTarget = iter_4_1:GetTarget(arg_4_1, arg_4_0)

		iter_4_1:SetCommander(arg_4_2)

		if iter_4_1:IsFinaleEffect() then
			arg_4_0._finaleEffectCount = arg_4_0._finaleEffectCount + 1

			local function var_4_8()
				local var_5_0 = arg_4_0

				var_0.callbackCount(var_5_0, arg_4_1)

				return
			end

			iter_4_1:SetFinaleCallback(var_4_8)
		end

		iter_4_1:Effect(arg_4_1, var_11, var_4_7)
	end

	if arg_4_0._tempData.aniEffect and var_6 ~= "" then
		local var_4_9 = {
			effect = var_6.effect,
			time = var_6.time,
			offset = var_6.offset,
			posFun = var_6.posFun
		}

		arg_4_1:DispatchEvent(var_0.Event.New(var_0.Battle.BattleUnitEvent.ADD_EFFECT, var_4_9))
	end

	if arg_4_0._tempData.action then
		arg_4_1:StateChange(var_0.Battle.UnitState.STATE_SKILL_START)
	end

	return
end

function var_0_4.SetTarget(arg_6_0, arg_6_1)
	arg_6_0._lastEffectTarget = arg_6_1

	return
end

function var_0_4.Interrupt(arg_7_0)
	ipairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0._effectList) do
		iter_7_1:Interrupt()
	end

	return
end

function var_0_4.Clear(arg_8_0)
	ipairs = var_1_10001

	for iter_8_0, iter_8_1 in var_1_10001(arg_8_0._effectList) do
		iter_8_1:Clear()
	end

	return
end

function var_0_4.callbackCount(arg_9_0, arg_9_1)
	arg_9_0._finaleEffectCount = arg_9_0._finaleEffectCount - 1

	if arg_9_0._finaleEffectCount == 0 and arg_9_0._tempData.action then
		arg_9_1:StateChange(var_0.Battle.UnitState.STATE_SKILL_END)
	end

	return
end

function var_0_4.GetDamageSum(arg_10_0)
	local var_10_0 = 0

	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0._effectList) do
		var_10_0 = iter_10_1:GetDamageSum() + var_10_0
	end

	return var_10_0
end

function var_0_4.IsFireSkill(arg_11_0, arg_11_1)
	local var_11_0 = false
	local var_11_1 = var_0.Battle.BattleDataFunction.GetSkillTemplate(arg_11_0, arg_11_1)

	ipairs = var_4

	for iter_11_0, iter_11_1 in var_4(var_11_1.effect_list) do
		if iter_11_1.type == var_0.Battle.BattleSkillFire.__name or iter_11_1.type == var_0.Battle.BattleSkillFireSupport.__name then
			var_11_0 = true

			break
		end
	end

	return var_11_0
end

return

ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleFormulas
local var_0_2 = var_0.Battle.BattleUnitEvent
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleCardPuzzleSkillEffect = var_0_10004("BattleCardPuzzleSkillEffect")
var_0.Battle.BattleCardPuzzleSkillEffect.__name = "BattleCardPuzzleSkillEffect"

local var_0_4 = var_0.Battle.BattleCardPuzzleSkillEffect

function var_0_4.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tempData = arg_1_1
	arg_1_0._type = arg_1_0._tempData.type
	arg_1_0._targetChoise = arg_1_0._tempData.target_choise

	local var_1_0

	if not arg_1_0._tempData.arg_list.delay then
		var_1_0 = 0
	end

	arg_1_0._delay = var_1_0
	arg_1_0._timerList = {}
	arg_1_0._timerIndex = 0

	return
end

function var_0_4.Execute(arg_2_0, arg_2_1)
	arg_2_0._caster = var_0.Battle.BattleTargetChoise.TargetFleetIndex(nil, {
		fleetPos = arg_2_0._tempData.caster
	})[1]

	if arg_2_0._delay > 0 then
		local var_2_0

		arg_2_0._timerIndex = arg_2_0._timerIndex + 1

		local function var_2_1()
			if arg_2_0._caster then
				local var_3_0 = arg_2_0._caster

				if var_0.IsAlive(var_3_0) then
					local var_3_1 = arg_2_0

					var_0.SkillEffectHandler(var_3_1)
				end
			end

			pg = var_0

			local var_3_2 = var_0.TimeMgr.GetInstance()

			var_0.RemoveBattleTimer(var_3_2, var_2_0)

			arg_2_0._timerList[var_0] = nil

			return
		end

		pg = var_1_10006

		local var_2_2 = var_1_10006.TimeMgr.GetInstance()

		var_2_0 = var_6.AddBattleTimer(var_2_2, "BattleSkill", -1, arg_2_0._delay, var_2_1, true)
		arg_2_0._timerList[var_4] = var_2_0
	else
		arg_2_0:SkillEffectHandler()
	end

	return
end

function var_0_4.SkillEffectHandler(arg_4_0, arg_4_1)
	return
end

function var_0_4.AniEffect(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2:GetPosition()
	local var_5_1 = arg_5_1:GetPosition()

	if arg_5_0._casterAniEffect and arg_5_0._casterAniEffect ~= "" then
		local var_5_2 = arg_5_0._casterAniEffect
		local var_5_3

		if var_5_2.posFun then
			function var_5_3(arg_6_0)
				return var_5_2.posFun(var_5_1, var_5_0, arg_6_0)
			end
		end

		local var_5_4 = {
			effect = var_5_2.effect,
			offset = var_5_2.offset,
			posFun = var_5_3
		}

		arg_5_1:DispatchEvent(var_0.Event.New(var_0_2.ADD_EFFECT, var_5_4))
	end

	if arg_5_0._targetAniEffect and arg_5_0._targetAniEffect ~= "" then
		local var_5_5 = arg_5_0._targetAniEffect
		local var_5_6

		if var_5_5.posFun then
			function var_5_6(arg_7_0)
				return var_5_5.posFun(var_5_1, var_5_0, arg_7_0)
			end
		end

		local var_5_7 = {
			effect = var_5_5.effect,
			offset = var_5_5.offset,
			posFun = var_5_6
		}

		arg_5_2:DispatchEvent(var_0.Event.New(var_0_2.ADD_EFFECT, var_5_7))
	end

	return
end

function var_0_4.GetTarget(arg_8_0)
	if not arg_8_0._targetChoise then
		return {}
	end

	local var_8_0

	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0._targetChoise) do
		var_8_0 = var_0.Battle.BattleTargetChoise[iter_8_1](arg_8_0._caster, arg_8_0._tempData.arg_list, var_8_0)
	end

	return var_8_0
end

function var_0_4.GetCardPuzzleComponent(arg_9_0)
	local var_9_0 = arg_9_0._card

	return var_1.GetClient(var_9_0)
end

function var_0_4.GetFleetVO(arg_10_0)
	local var_10_0 = arg_10_0:GetCardPuzzleComponent()

	return var_1.GetFleetVO(var_10_0)
end

function var_0_4.ConfigCard(arg_11_0, arg_11_1)
	arg_11_0._card = arg_11_1

	return
end

function var_0_4.SetQueue(arg_12_0, arg_12_1)
	arg_12_0._queue = arg_12_1

	return
end

function var_0_4.Finale(arg_13_0)
	local var_13_0 = arg_13_0._queue

	var_1.EffectFinale(var_13_0, arg_13_0)

	return
end

function var_0_4.HoldForInput(arg_14_0)
	return false
end

function var_0_4.MoveCardAfterCast(arg_15_0)
	return var_0.Battle.BattleFleetCardPuzzleComponent.CARD_PILE_INDEX_DISCARD
end

function var_0_4.Interrupt(arg_16_0)
	return
end

function var_0_4.Clear(arg_17_0)
	pairs = var_1_10001

	for iter_17_0, iter_17_1 in var_1_10001(arg_17_0._timerList) do
		pg = var_1_10006

		local var_17_0 = var_1_10006.TimeMgr.GetInstance()

		var_1_10006.RemoveBattleTimer(var_17_0, iter_17_1)

		var_1_10006 = arg_17_0._timerList
		var_1_10006[iter_17_0] = nil
	end

	arg_17_0._commander = nil

	return
end

return

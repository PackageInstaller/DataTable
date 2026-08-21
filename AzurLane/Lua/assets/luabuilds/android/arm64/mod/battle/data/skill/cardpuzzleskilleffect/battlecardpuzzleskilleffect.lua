ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleUnitEvent

ys.Battle.BattleCardPuzzleSkillEffect = class("BattleCardPuzzleSkillEffect")
ys.Battle.BattleCardPuzzleSkillEffect.__name = "BattleCardPuzzleSkillEffect"

function ys.Battle.BattleCardPuzzleSkillEffect.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tempData = arg_1_1
	arg_1_0._type = arg_1_0._tempData.type
	arg_1_0._targetChoise = arg_1_0._tempData.target_choise
	arg_1_0._delay = arg_1_0._tempData.arg_list.delay or 0
	arg_1_0._timerList = {}
	arg_1_0._timerIndex = 0

	return
end

function ys.Battle.BattleCardPuzzleSkillEffect.Execute(arg_2_0, arg_2_1)
	arg_2_0._caster = var_0_0.Battle.BattleTargetChoise.TargetFleetIndex(nil, {
		fleetPos = arg_2_0._tempData.caster
	})[1]

	if arg_2_0._delay > 0 then
		local var_2_0
		local var_2_1 = arg_2_0._timerIndex + 1

		arg_2_0._timerIndex = arg_2_0._timerIndex + 1
		arg_2_0._timerList[arg_2_0._timerIndex + 1] = pg.TimeMgr.GetInstance():AddBattleTimer("BattleSkill", -1, arg_2_0._delay, function()
			if arg_2_0._caster and arg_2_0._caster:IsAlive() then
				arg_2_0:SkillEffectHandler()
			end

			pg.TimeMgr.GetInstance():RemoveBattleTimer(var_2_0)

			arg_2_0._timerList[var_2_1] = nil

			return
		end, true)
	else
		arg_2_0:SkillEffectHandler()
	end

	return
end

function ys.Battle.BattleCardPuzzleSkillEffect.SkillEffectHandler(arg_4_0, arg_4_1)
	return
end

function ys.Battle.BattleCardPuzzleSkillEffect.AniEffect(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2:GetPosition()
	local var_5_1 = arg_5_1:GetPosition()

	if arg_5_0._casterAniEffect and arg_5_0._casterAniEffect ~= "" then
		local var_5_2 = arg_5_0._casterAniEffect
		local var_5_3

		if arg_5_0._casterAniEffect.posFun then
			function var_5_3(arg_6_0)
				return var_5_2.posFun(var_5_1, var_5_0, arg_6_0)
			end
		end

		arg_5_1:DispatchEvent(var_0_0.Event.New(var_0_2.ADD_EFFECT, {
			effect = arg_5_0._casterAniEffect.effect,
			offset = arg_5_0._casterAniEffect.offset,
			posFun = var_5_3
		}))
	end

	if arg_5_0._targetAniEffect and arg_5_0._targetAniEffect ~= "" then
		local var_5_4 = arg_5_0._targetAniEffect
		local var_5_5

		if arg_5_0._targetAniEffect.posFun then
			function var_5_5(arg_7_0)
				return var_5_4.posFun(var_5_1, var_5_0, arg_7_0)
			end
		end

		arg_5_2:DispatchEvent(var_0_0.Event.New(var_0_2.ADD_EFFECT, {
			effect = arg_5_0._targetAniEffect.effect,
			offset = arg_5_0._targetAniEffect.offset,
			posFun = var_5_5
		}))
	end

	return
end

function ys.Battle.BattleCardPuzzleSkillEffect.GetTarget(arg_8_0)
	if not arg_8_0._targetChoise then
		return {}
	end

	local var_8_0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._targetChoise) do
		var_8_0 = var_0_0.Battle.BattleTargetChoise[iter_8_1](arg_8_0._caster, arg_8_0._tempData.arg_list, var_8_0)
	end

	return var_8_0
end

function ys.Battle.BattleCardPuzzleSkillEffect.GetCardPuzzleComponent(arg_9_0)
	return arg_9_0._card:GetClient()
end

function ys.Battle.BattleCardPuzzleSkillEffect.GetFleetVO(arg_10_0)
	return arg_10_0:GetCardPuzzleComponent():GetFleetVO()
end

function ys.Battle.BattleCardPuzzleSkillEffect.ConfigCard(arg_11_0, arg_11_1)
	arg_11_0._card = arg_11_1

	return
end

function ys.Battle.BattleCardPuzzleSkillEffect.SetQueue(arg_12_0, arg_12_1)
	arg_12_0._queue = arg_12_1

	return
end

function ys.Battle.BattleCardPuzzleSkillEffect.Finale(arg_13_0)
	arg_13_0._queue:EffectFinale(arg_13_0)

	return
end

function ys.Battle.BattleCardPuzzleSkillEffect.HoldForInput(arg_14_0)
	return false
end

function ys.Battle.BattleCardPuzzleSkillEffect.MoveCardAfterCast(arg_15_0)
	return var_0_0.Battle.BattleFleetCardPuzzleComponent.CARD_PILE_INDEX_DISCARD
end

function ys.Battle.BattleCardPuzzleSkillEffect.Interrupt(arg_16_0)
	return
end

function ys.Battle.BattleCardPuzzleSkillEffect.Clear(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0._timerList) do
		pg.TimeMgr.GetInstance():RemoveBattleTimer(iter_17_1)

		arg_17_0._timerList[iter_17_0] = nil
	end

	arg_17_0._commander = nil

	return
end

return

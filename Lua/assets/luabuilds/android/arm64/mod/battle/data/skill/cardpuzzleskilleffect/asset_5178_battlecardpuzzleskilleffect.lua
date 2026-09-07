ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleUnitEvent

ys.Battle.BattleCardPuzzleSkillEffect = class("BattleCardPuzzleSkillEffect")
ys.Battle.BattleCardPuzzleSkillEffect.__name = "BattleCardPuzzleSkillEffect"

function ys.Battle.BattleCardPuzzleSkillEffect:Ctor(arg_1_1)
	self._tempData = arg_1_1
	self._type = self._tempData.type
	self._targetChoise = self._tempData.target_choise
	self._delay = self._tempData.arg_list.delay or 0
	self._timerList = {}
	self._timerIndex = 0

	return
end

function ys.Battle.BattleCardPuzzleSkillEffect:Execute(arg_2_1)
	self._caster = var_0_0.Battle.BattleTargetChoise.TargetFleetIndex(nil, {
		fleetPos = self._tempData.caster
	})[1]

	if self._delay > 0 then
		local var_2_0
		local var_2_1 = self._timerIndex + 1

		self._timerIndex = self._timerIndex + 1
		var_2_0 = pg.TimeMgr.GetInstance():AddBattleTimer("BattleSkill", -1, self._delay, function()
			if self._caster and self._caster:IsAlive() then
				self:SkillEffectHandler()
			end

			pg.TimeMgr.GetInstance():RemoveBattleTimer(var_2_0)

			self._timerList[var_2_1] = nil

			return
		end, true)
		self._timerList[self._timerIndex + 1] = var_2_0
	else
		self:SkillEffectHandler()
	end

	return
end

function ys.Battle.BattleCardPuzzleSkillEffect.SkillEffectHandler(arg_4_0, arg_4_1)
	return
end

function ys.Battle.BattleCardPuzzleSkillEffect:AniEffect(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2:GetPosition()
	local var_5_1 = arg_5_1:GetPosition()

	if self._casterAniEffect and self._casterAniEffect ~= "" then
		local var_5_2 = self._casterAniEffect

		arg_5_1:DispatchEvent(var_0_0.Event.New(var_0_2.ADD_EFFECT, {
			effect = self._casterAniEffect.effect,
			offset = self._casterAniEffect.offset,
			posFun = (self._casterAniEffect.posFun or nil) and function(arg_6_0)
				return var_5_2.posFun(var_5_1, var_5_0, arg_6_0)
			end
		}))
	end

	if self._targetAniEffect and self._targetAniEffect ~= "" then
		local var_5_4 = self._targetAniEffect

		arg_5_2:DispatchEvent(var_0_0.Event.New(var_0_2.ADD_EFFECT, {
			effect = self._targetAniEffect.effect,
			offset = self._targetAniEffect.offset,
			posFun = (self._targetAniEffect.posFun or nil) and function(arg_7_0)
				return var_5_4.posFun(var_5_1, var_5_0, arg_7_0)
			end
		}))
	end

	return
end

function ys.Battle.BattleCardPuzzleSkillEffect:GetTarget()
	if not self._targetChoise then
		return {}
	end

	local var_8_0

	for iter_8_0, iter_8_1 in ipairs(self._targetChoise) do
		var_8_0 = var_0_0.Battle.BattleTargetChoise[iter_8_1](self._caster, self._tempData.arg_list, var_8_0)
	end

	return var_8_0
end

function ys.Battle.BattleCardPuzzleSkillEffect:GetCardPuzzleComponent()
	return self._card:GetClient()
end

function ys.Battle.BattleCardPuzzleSkillEffect:GetFleetVO()
	return self:GetCardPuzzleComponent():GetFleetVO()
end

function ys.Battle.BattleCardPuzzleSkillEffect.ConfigCard(arg_11_0, arg_11_1)
	arg_11_0._card = arg_11_1

	return
end

function ys.Battle.BattleCardPuzzleSkillEffect.SetQueue(arg_12_0, arg_12_1)
	arg_12_0._queue = arg_12_1

	return
end

function ys.Battle.BattleCardPuzzleSkillEffect:Finale()
	self._queue:EffectFinale(self)

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

function ys.Battle.BattleCardPuzzleSkillEffect:Clear()
	for iter_17_0, iter_17_1 in pairs(self._timerList) do
		pg.TimeMgr.GetInstance():RemoveBattleTimer(iter_17_1)

		self._timerList[iter_17_0] = nil
	end

	self._commander = nil

	return
end

return

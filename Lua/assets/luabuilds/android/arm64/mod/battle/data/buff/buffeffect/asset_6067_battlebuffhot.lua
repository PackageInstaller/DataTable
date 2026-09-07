ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffHOT = class("BattleBuffHOT", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffHOT.__name = "BattleBuffHOT"

function ys.Battle.BattleBuffHOT.Ctor(arg_1_0, arg_1_1)
	var_0_0.Battle.BattleBuffHOT.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffHOT:SetArgs(arg_2_1, arg_2_2)
	self._number = self._tempData.arg_list.number or 0
	self._numberBase = self._number
	self._time = self._tempData.arg_list.time or 0
	self._nextEffectTime = pg.TimeMgr.GetInstance():GetCombatTime() + self._time
	self._maxHPRatio = self._tempData.arg_list.maxHPRatio or 0
	self._currentHPRatio = self._tempData.arg_list.currentHPRatio or 0
	self._incorruptible = self._tempData.arg_list.incorrupt

	return
end

function ys.Battle.BattleBuffHOT.onStack(arg_3_0, arg_3_1, arg_3_2)
	return
end

function ys.Battle.BattleBuffHOT:onUpdate(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3.timeStamp >= self._nextEffectTime then
		arg_4_1:UpdateHP(self:CalcNumber(arg_4_1, arg_4_2), {
			isMiss = false,
			isCri = false,
			isHeal = true,
			incorrupt = self._incorruptible
		})

		if arg_4_1:IsAlive() then
			self._nextEffectTime = self._nextEffectTime + self._time
		end
	end

	return
end

function ys.Battle.BattleBuffHOT:onRemove(arg_5_1, arg_5_2)
	arg_5_1:UpdateHP(self:CalcNumber(arg_5_1, arg_5_2), {
		isMiss = false,
		isCri = false,
		isHeal = true,
		incorrupt = self._incorruptible
	})

	return
end

function ys.Battle.BattleBuffHOT:CalcNumber(arg_6_1, arg_6_2)
	local var_6_0, var_6_1 = arg_6_1:GetHP()

	return (math.floor(math.max(0, var_6_0 * self._currentHPRatio + var_6_1 * self._maxHPRatio + self._number) * arg_6_2._stack * arg_6_1:GetAttrByName("healingRate")))
end

return

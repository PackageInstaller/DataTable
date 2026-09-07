ys = ys or {}
ys.Battle.BattleCardPuzzleFleetBuffEffect = class("BattleCardPuzzleFleetBuffEffect")
ys.Battle.BattleCardPuzzleFleetBuffEffect.__name = "BattleCardPuzzleFleetBuffEffect"

local var_0_1 = ys.Battle.BattleFleetBuffEffect

ys.Battle.BattleFleetBuffEffect.FX_TYPE_NOR = 0
ys.Battle.BattleFleetBuffEffect.FX_TYPE_MOD_ATTR = 1

function ys.Battle.BattleFleetBuffEffect:Ctor(arg_1_1)
	self._tempData = Clone(arg_1_1)
	self._type = self._tempData.type

	self:SetActive()

	return
end

function ys.Battle.BattleFleetBuffEffect.GetEffectType(arg_2_0)
	return var_0_1.FX_TYPE_NOR
end

function ys.Battle.BattleFleetBuffEffect.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._cardPuzzleComponent = arg_3_1
	arg_3_0._fleetBuff = arg_3_2

	return
end

function ys.Battle.BattleFleetBuffEffect:Trigger(arg_4_1, arg_4_2)
	self[arg_4_1](self, arg_4_2)

	return
end

function ys.Battle.BattleFleetBuffEffect:onAttach()
	self:onTrigger()

	return
end

function ys.Battle.BattleFleetBuffEffect:onRemove()
	self:onTrigger()

	return
end

function ys.Battle.BattleFleetBuffEffect:onUpdate(arg_7_1)
	if self._tempData.arg_list.INR then
		if not self._lastTimeStamp or self._tempData.arg_list.INR < arg_7_1 - self._lastTimeStamp then
			self:onTrigger()

			self._lastTimeStamp = arg_7_1
		end
	else
		self:onTrigger()
	end

	return
end

function ys.Battle.BattleFleetBuffEffect:onPlus()
	self:onTrigger()

	return
end

function ys.Battle.BattleFleetBuffEffect:onDeduct()
	self:onTrigger()

	return
end

function ys.Battle.BattleFleetBuffEffect:onStartGame()
	self:onTrigger()

	return
end

function ys.Battle.BattleFleetBuffEffect:IsActive()
	return self._isActive
end

function ys.Battle.BattleFleetBuffEffect.SetActive(arg_12_0)
	arg_12_0._isActive = true

	return
end

function ys.Battle.BattleFleetBuffEffect.NotActive(arg_13_0)
	arg_13_0._isActive = false

	return
end

function ys.Battle.BattleFleetBuffEffect.Clear(arg_14_0)
	return
end

function ys.Battle.BattleFleetBuffEffect.Dispose(arg_15_0)
	return
end

return

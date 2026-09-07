ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffDeath = class("BattleBuffDeath", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffDeath.__name = "BattleBuffDeath"

local var_0_1 = ys.Battle.BattleBuffDeath

function ys.Battle.BattleBuffDeath.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffDeath:SetArgs(arg_2_1, arg_2_2)
	if self._tempData.arg_list.time then
		self._time = self._tempData.arg_list.time + pg.TimeMgr.GetInstance():GetCombatTime()
	end

	self._maxX = self._tempData.arg_list.maxX
	self._minX = self._tempData.arg_list.minX
	self._maxY = self._tempData.arg_list.maxY
	self._minY = self._tempData.arg_list.minY
	self._countType = self._tempData.arg_list.countType
	self._instantkill = self._tempData.arg_list.instant_kill

	return
end

function ys.Battle.BattleBuffDeath:onAttach(arg_3_1, arg_3_2, arg_3_3)
	if self._instantkill then
		self:DoDead(arg_3_1)
	end

	return
end

function ys.Battle.BattleBuffDeath:onUpdate(arg_4_1, arg_4_2, arg_4_3)
	if self._time and arg_4_3.timeStamp > self._time then
		arg_4_1:SetDeathReason(var_0_0.Battle.BattleConst.UnitDeathReason.DESTRUCT)
		self:DoDead(arg_4_1)
	else
		local var_4_0 = arg_4_1:GetPosition()

		if self._maxX and var_4_0.x >= self._maxX then
			arg_4_1:SetDeathReason(var_0_0.Battle.BattleConst.UnitDeathReason.LEAVE)
			self:DoDead(arg_4_1)
		elseif self._minX and var_4_0.x <= self._minX then
			arg_4_1:SetDeathReason(var_0_0.Battle.BattleConst.UnitDeathReason.LEAVE)
			self:DoDead(arg_4_1)
		elseif self._maxY and var_4_0.z >= self._maxY then
			arg_4_1:SetDeathReason(var_0_0.Battle.BattleConst.UnitDeathReason.LEAVE)
			self:DoDead(arg_4_1)
		elseif self._minY and var_4_0.z <= self._minY then
			arg_4_1:SetDeathReason(var_0_0.Battle.BattleConst.UnitDeathReason.LEAVE)
			self:DoDead(arg_4_1)
		end
	end

	return
end

function ys.Battle.BattleBuffDeath:onBattleBuffCount(arg_5_1, arg_5_2, arg_5_3)
	if arg_5_3.countType == self._countType then
		self:DoDead(arg_5_1)
	end

	return
end

function ys.Battle.BattleBuffDeath.DoDead(arg_6_0, arg_6_1)
	arg_6_1:SetCurrentHP(0)
	arg_6_1:DeadAction()

	return
end

return

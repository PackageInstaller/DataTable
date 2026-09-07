ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleDataFunction
local var_0_2 = ys.Battle.BattleFormulas
local BattleBuffAddBuff = class("BattleBuffAddBuff", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffAddBuff = BattleBuffAddBuff
BattleBuffAddBuff.__name = "BattleBuffAddBuff"

function BattleBuffAddBuff:Ctor(arg_1_1)
	var_0_0.Battle.BattleBuffAddBuff.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffAddBuff:SetArgs(arg_2_1, arg_2_2)
	self._buff_id = self._tempData.arg_list.buff_id
	self._level = self._tempData.arg_list.buff_level or arg_2_2:GetLv()
	self._target = self._tempData.arg_list.target or "TargetSelf"
	self._time = self._tempData.arg_list.time or 0
	self._rant = self._tempData.arg_list.rant or 10000
	self._nextEffectTime = pg.TimeMgr.GetInstance():GetCombatTime() + self._time
	self._check_target = self._tempData.arg_list.check_target
	self._minTargetNumber = self._tempData.arg_list.minTargetNumber or 0
	self._maxTargetNumber = self._tempData.arg_list.maxTargetNumber or 10000
	self._isBuffStackByCheckTarget = self._tempData.arg_list.isBuffStackByCheckTarget
	self._countType = self._tempData.arg_list.countType
	self._weaponType = self._tempData.arg_list.weaponType
	self._repeatCount = self._tempData.arg_list.repeat_count or 1
	self._attrConsumeRepeat = self._tempData.arg_list.fleetAttrConsume

	return
end

function BattleBuffAddBuff:onUpdate(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3.timeStamp >= self._nextEffectTime then
		self:AddBuff(arg_3_1, arg_3_3, arg_3_2)

		self._nextEffectTime = arg_3_3.timeStamp + self._time
	end

	return
end

function BattleBuffAddBuff:onBulletHit(arg_4_1, arg_4_2, arg_4_3)
	if not self:equipIndexRequire(arg_4_3.equipIndex) then
		return
	end

	local var_4_0 = arg_4_3.target

	if (not self._weaponType or arg_4_3.weaponType == self._weaponType) and var_4_0:IsAlive() then
		self:attachBuff(self._buff_id, self._level, var_4_0, arg_4_2)
	end

	return
end

function BattleBuffAddBuff:onBulletCreate(arg_5_1, arg_5_2, arg_5_3)
	if not self:equipIndexRequire(arg_5_3.equipIndex) then
		do return end

		local var_5_0 = self._buff_id
		local var_5_1 = self._level
	end

	arg_5_3._bullet:SetBuffFun(self._tempData.arg_list.bulletTrigger, function(arg_6_0, arg_6_1)
		self:attachBuff(var_5_0, var_5_1, arg_6_0, arg_5_2)

		return
	end)

	return
end

function BattleBuffAddBuff:onTrigger(arg_7_1, arg_7_2, arg_7_3)
	BattleBuffAddBuff.super.onTrigger(self, arg_7_1, arg_7_2, arg_7_3)
	self:AddBuff(arg_7_1, arg_7_3, arg_7_2)

	return
end

function BattleBuffAddBuff:AddBuff(arg_8_1, arg_8_2, arg_8_3)
	if not self:commanderRequire(arg_8_1, self._tempData.arg_list) then
		return
	end

	if not self:ammoRequire(arg_8_1) then
		return
	end

	if self._check_target then
		local var_8_0 = #self:getTargetList(arg_8_1, self._check_target, self._tempData.arg_list, arg_8_2)

		if var_8_0 >= self._minTargetNumber and var_8_0 <= self._maxTargetNumber then
			for iter_8_0, iter_8_1 in ipairs((self:getTargetList(arg_8_1, self._target, self._tempData.arg_list, arg_8_2))) do
				if self._isBuffStackByCheckTarget then
					iter_8_1:SetBuffStack(self._buff_id, self._level, var_8_0)
				else
					self:attachBuff(self._buff_id, self._level, iter_8_1, arg_8_3)
				end
			end
		end
	else
		for iter_8_2, iter_8_3 in ipairs((self:getTargetList(arg_8_1, self._target, self._tempData.arg_list, arg_8_2))) do
			self:attachBuff(self._buff_id, self._level, iter_8_3, arg_8_3)
		end
	end

	return
end

function BattleBuffAddBuff:attachBuff(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = var_0_1.GetBuffTemplate(arg_9_1).effect_list
	local var_9_1

	if #var_9_0 == 1 and var_9_0[1].type == "BattleBuffDOT" then
		if var_0_2.CaclulateDOTPlace(self._rant, var_9_0[1], self._caster, arg_9_3) then
			var_9_1 = var_0_0.Battle.BattleBuffUnit.New(arg_9_1, nil, self._caster)

			var_9_1:SetOrb(self._caster, 1)
		end
	elseif var_0_2.IsHappen(self._rant) then
		var_9_1 = var_0_0.Battle.BattleBuffUnit.New(arg_9_1, arg_9_2, self._caster)
	end

	if var_9_1 then
		var_9_1:SetCommander(self._commander)

		local var_9_2 = self._attrConsumeRepeat and self:fleetAttrRepeatConsume(self._attrConsumeRepeat) or self:repeatCountParse(self._repeatCount)

		if var_9_2 == -1 then
			var_9_2 = arg_9_4:GetStack()
		end

		for iter_9_0 = 1, var_9_2 do
			arg_9_3:AddBuff(var_9_1)
		end
	end

	return
end

function BattleBuffAddBuff:Dispose()
	var_0_0.Battle.BattleBuffAddBuff.super:Dispose()
	pg.TimeMgr.GetInstance():RemoveBattleTimer(self._timer)

	self._timer = nil

	return
end

return

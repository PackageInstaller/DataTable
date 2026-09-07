ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleFormulas
local var_0_2 = ys.Battle.BattleUnitEvent

ys.Battle.BattleSkillEffect = class("BattleSkillEffect")
ys.Battle.BattleSkillEffect.__name = "BattleSkillEffect"

function ys.Battle.BattleSkillEffect:Ctor(arg_1_1, arg_1_2)
	self._tempData = arg_1_1
	self._type = self._tempData.type
	self._targetChoise = self._tempData.target_choise or "TargetNull"
	self._casterAniEffect = self._tempData.casterAniEffect
	self._targetAniEffect = self._tempData.targetAniEffect
	self._delay = self._tempData.arg_list.delay or 0
	self._lastEffectTarget = {}
	self._timerList = {}
	self._timerIndex = 0
	self._level = arg_1_2

	return
end

function ys.Battle.BattleSkillEffect.SetCommander(arg_2_0, arg_2_1)
	arg_2_0._commander = arg_2_1

	return
end

function ys.Battle.BattleSkillEffect:Effect(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 and #arg_3_2 > 0 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
			self:AniEffect(arg_3_1, iter_3_1)
			self:DataEffect(arg_3_1, iter_3_1, arg_3_3)
		end
	else
		self:DataEffectWithoutTarget(arg_3_1, arg_3_3)
	end

	return
end

function ys.Battle.BattleSkillEffect.IsFinaleEffect(arg_4_0)
	return false
end

function ys.Battle.BattleSkillEffect.SetFinaleCallback(arg_5_0, arg_5_1)
	arg_5_0._finaleCallback = arg_5_1

	return
end

function ys.Battle.BattleSkillEffect:AniEffect(arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2:GetPosition()
	local var_6_1 = arg_6_1:GetPosition()

	if self._casterAniEffect and self._casterAniEffect ~= "" then
		local var_6_2 = self._casterAniEffect

		arg_6_1:DispatchEvent(var_0_0.Event.New(var_0_2.ADD_EFFECT, {
			effect = self._casterAniEffect.effect,
			offset = self._casterAniEffect.offset,
			posFun = (self._casterAniEffect.posFun or nil) and function(arg_7_0)
				return var_6_2.posFun(var_6_1, var_6_0, arg_7_0)
			end
		}))
	end

	if self._targetAniEffect and self._targetAniEffect ~= "" then
		local var_6_4 = self._targetAniEffect

		arg_6_2:DispatchEvent(var_0_0.Event.New(var_0_2.ADD_EFFECT, {
			effect = self._targetAniEffect.effect,
			offset = self._targetAniEffect.offset,
			posFun = (self._targetAniEffect.posFun or nil) and function(arg_8_0)
				return var_6_4.posFun(var_6_1, var_6_0, arg_8_0)
			end
		}))
	end

	return
end

function ys.Battle.BattleSkillEffect:DataEffect(arg_9_1, arg_9_2, arg_9_3)
	if self._delay > 0 then
		local var_9_0
		local var_9_1 = self._timerIndex + 1

		self._timerIndex = self._timerIndex + 1
		var_9_0 = pg.TimeMgr.GetInstance():AddBattleTimer("BattleSkill", -1, self._delay, function()
			if arg_9_1 and arg_9_1:IsAlive() then
				self:DoDataEffect(arg_9_1, arg_9_2, arg_9_3)
			end

			pg.TimeMgr.GetInstance():RemoveBattleTimer(var_9_0)

			self._timerList[var_9_1] = nil

			return
		end, true)
		self._timerList[self._timerIndex + 1] = var_9_0
	else
		self:DoDataEffect(arg_9_1, arg_9_2, arg_9_3)
	end

	return
end

function ys.Battle.BattleSkillEffect.DoDataEffect(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	return
end

function ys.Battle.BattleSkillEffect:DataEffectWithoutTarget(arg_12_1, arg_12_2)
	if self._delay > 0 then
		local var_12_0
		local var_12_1 = self._timerIndex + 1

		self._timerIndex = self._timerIndex + 1
		var_12_0 = pg.TimeMgr.GetInstance():AddBattleTimer("BattleSkill", -1, self._delay, function()
			if arg_12_1 and arg_12_1:IsAlive() then
				self:DoDataEffectWithoutTarget(arg_12_1, arg_12_2)
			end

			pg.TimeMgr.GetInstance():RemoveBattleTimer(var_12_0)

			self._timerList[var_12_1] = nil

			return
		end, true)
		self._timerList[self._timerIndex + 1] = var_12_0
	else
		self:DoDataEffectWithoutTarget(arg_12_1, arg_12_2)
	end

	return
end

function ys.Battle.BattleSkillEffect.DoDataEffectWithoutTarget(arg_14_0, arg_14_1, arg_14_2)
	return
end

function ys.Battle.BattleSkillEffect:GetTarget(arg_15_1, arg_15_2)
	if type(self._targetChoise) == "string" then
		if self._targetChoise == "TargetSameToLastEffect" then
			return arg_15_2._lastEffectTarget
		else
			return var_0_0.Battle.BattleTargetChoise[self._targetChoise](arg_15_1, self._tempData.arg_list)
		end
	elseif type(self._targetChoise) == "table" then
		local var_15_0

		for iter_15_0, iter_15_1 in ipairs(self._targetChoise) do
			var_15_0 = var_0_0.Battle.BattleTargetChoise[iter_15_1](arg_15_1, self._tempData.arg_list, var_15_0)
		end

		return var_15_0
	end

	return
end

function ys.Battle.BattleSkillEffect.Interrupt(arg_16_0)
	return
end

function ys.Battle.BattleSkillEffect:Clear()
	for iter_17_0, iter_17_1 in pairs(self._timerList) do
		pg.TimeMgr.GetInstance():RemoveBattleTimer(iter_17_1)

		self._timerList[iter_17_0] = nil
	end

	self._commander = nil

	return
end

function ys.Battle.BattleSkillEffect:calcCorrdinate(arg_18_1, arg_18_2)
	local var_18_0

	if self.absoulteCorrdinate then
		var_18_0 = Vector3(self.absoulteCorrdinate.x, 0, self.absoulteCorrdinate.z)
	elseif self.absoulteRandom then
		var_18_0 = var_0_1.RandomPos(self.absoulteRandom)
	elseif self.casterRelativeCorrdinate then
		local var_18_1 = arg_18_1:GetIFF()
		local var_18_2 = arg_18_1:GetPosition()

		var_18_0 = Vector3(var_18_1 * self.casterRelativeCorrdinate.hrz + var_18_2.x, 0, var_18_1 * self.casterRelativeCorrdinate.vrt + var_18_2.z)
	elseif self.casterRelativeRandom then
		local var_18_3 = arg_18_1:GetIFF()
		local var_18_4 = arg_18_1:GetPosition()

		var_18_0 = var_0_1.RandomPos({
			X1 = var_18_3 * self.casterRelativeRandom.front + var_18_4.x,
			X2 = var_18_3 * self.casterRelativeRandom.rear + var_18_4.x,
			Z1 = self.casterRelativeRandom.upper + var_18_4.z,
			Z2 = self.casterRelativeRandom.lower + var_18_4.z
		})
	elseif self.targetRelativeCorrdinate then
		if arg_18_2 then
			local var_18_5 = arg_18_2:GetIFF()
			local var_18_6 = arg_18_2:GetPosition()

			var_18_0 = Vector3(var_18_5 * self.targetRelativeCorrdinate.hrz + var_18_6.x, 0, var_18_5 * self.targetRelativeCorrdinate.vrt + var_18_6.z)
		end
	elseif self.targetRelativeRandom and arg_18_2 then
		local var_18_7 = arg_18_2:GetIFF()
		local var_18_8 = arg_18_2:GetPosition()

		var_18_0 = var_0_1.RandomPos({
			X1 = var_18_7 * self.targetRelativeRandom.front + var_18_8.x,
			X2 = var_18_7 * self.targetRelativeRandom.rear + var_18_8.x,
			Z1 = self.targetRelativeRandom.upper + var_18_8.z,
			Z2 = self.targetRelativeRandom.lower + var_18_8.z
		})
	end

	return var_18_0
end

function ys.Battle.BattleSkillEffect.GetDamageSum(arg_19_0)
	return 0
end

return

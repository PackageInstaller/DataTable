ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleWaveInfo = class("BattleWaveInfo")
ys.Battle.BattleWaveInfo.__name = "BattleWaveInfo"

local var_0_2 = ys.Battle.BattleWaveInfo

ys.Battle.BattleWaveInfo.LOGIC_AND = 0
ys.Battle.BattleWaveInfo.LGOIC_OR = 1
ys.Battle.BattleWaveInfo.STATE_DEACTIVE = "STATE_DEACTIVE"
ys.Battle.BattleWaveInfo.STATE_ACTIVE = "STATE_ACTIVE"
ys.Battle.BattleWaveInfo.STATE_PASS = "STATE_PASS"
ys.Battle.BattleWaveInfo.STATE_FAIL = "STATE_FAIL"

function ys.Battle.BattleWaveInfo.Ctor(arg_1_0)
	var_0_0.EventDispatcher.AttachEventDispatcher(arg_1_0)

	arg_1_0._preWaves = {}
	arg_1_0._postWaves = {}
	arg_1_0._branchWaves = {}

	return
end

function ys.Battle.BattleWaveInfo:IsReady()
	return self:IsPreWavesFinished()
end

function ys.Battle.BattleWaveInfo:IsFlagsPass()
	if not self._blockFlags or not next(self._blockFlags) then
		return true
	end

	local var_3_0 = var_0_0.Battle.BattleDataProxy.GetInstance():GetWaveFlags()

	if not var_3_0 or not next(var_3_0) then
		return false
	end

	for iter_3_0, iter_3_1 in ipairs(self._blockFlags) do
		if not table.contains(var_3_0, iter_3_1) then
			return false
		end
	end

	return true
end

function ys.Battle.BattleWaveInfo:IsPreWavesFinished()
	local var_4_1

	if #self._preWaves == 0 then
		var_4_1 = true
	elseif self._logicType == var_0_2.LOGIC_AND then
		var_4_1 = true

		for iter_4_0, iter_4_1 in ipairs(self._preWaves) do
			if not iter_4_1:IsFinish() then
				var_4_1 = false

				break
			end
		end
	elseif self._logicType == var_0_2.LGOIC_OR then
		var_4_1 = false

		for iter_4_2, iter_4_3 in ipairs(self._preWaves) do
			if iter_4_3:IsFinish() then
				var_4_1 = true

				break
			end
		end
	end

	return var_4_1
end

function ys.Battle.BattleWaveInfo:IsFinish()
	return self:GetState() == var_0_2.STATE_PASS or self:GetState() == var_0_2.STATE_FAIL
end

function ys.Battle.BattleWaveInfo:DoBranch()
	for iter_6_0, iter_6_1 in ipairs(self._branchWaves) do
		local var_6_0 = self._branchWaveIDs[iter_6_1:GetIndex()]

		if var_6_0 and iter_6_1:GetState() == var_0_2.STATE_PASS or not var_6_0 and iter_6_1:GetState() == var_0_2.STATE_FAIL then
			-- block empty
		else
			self:doFail()

			return
		end
	end

	if not self:IsFlagsPass() then
		self:doFail()

		return
	end

	self:DoWave()

	return
end

function ys.Battle.BattleWaveInfo.DoWave(arg_7_0)
	arg_7_0._state = var_0_2.STATE_ACTIVE

	return
end

function ys.Battle.BattleWaveInfo.AddMonster(arg_8_0)
	return
end

function ys.Battle.BattleWaveInfo.RemoveMonster(arg_9_0)
	return
end

function ys.Battle.BattleWaveInfo.SetWaveData(arg_10_0, arg_10_1)
	arg_10_0._index = arg_10_1.waveIndex
	arg_10_0._isKeyWave = arg_10_1.key
	arg_10_0._logicType = arg_10_1.conditionType or var_0_2.LOGIC_AND
	arg_10_0._param = arg_10_1.triggerParams or {}
	arg_10_0._preWaveIDs = arg_10_1.preWaves or {}
	arg_10_0._branchWaveIDs = arg_10_1.conditionWaves or {}
	arg_10_0._blockFlags = arg_10_1.blockFlags
	arg_10_0._type = arg_10_1.triggerType
	arg_10_0._state = var_0_2.STATE_DEACTIVE

	return
end

function ys.Battle.BattleWaveInfo.SetCallback(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._spawnFunc = arg_11_1
	arg_11_0._airFunc = arg_11_2

	return
end

function ys.Battle.BattleWaveInfo:AppendBranchWave(arg_12_1)
	self._branchWaves[#self._branchWaves + 1] = arg_12_1

	return
end

function ys.Battle.BattleWaveInfo:AppendPreWave(arg_13_1)
	self._preWaves[#self._preWaves + 1] = arg_13_1

	return
end

function ys.Battle.BattleWaveInfo:AppendPostWave(arg_14_1)
	self._postWaves[#self._postWaves + 1] = arg_14_1

	return
end

function ys.Battle.BattleWaveInfo:IsKeyWave()
	return self._isKeyWave
end

function ys.Battle.BattleWaveInfo:GetPostWaves()
	return self._postWaves
end

function ys.Battle.BattleWaveInfo:GetIndex()
	return self._index
end

function ys.Battle.BattleWaveInfo:GetType()
	return self._type
end

function ys.Battle.BattleWaveInfo:GetState()
	return self._state
end

function ys.Battle.BattleWaveInfo:GetPreWaveIDs()
	return self._preWaveIDs
end

function ys.Battle.BattleWaveInfo:GetBranchWaveIDs()
	return self._branchWaveIDs
end

function ys.Battle.BattleWaveInfo.Dispose(arg_22_0)
	var_0_0.EventDispatcher.DetachEventDispatcher(arg_22_0)

	return
end

function ys.Battle.BattleWaveInfo:doPass()
	if not self:IsFinish() then
		self._state = var_0_2.STATE_PASS

		self:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleEvent.WAVE_FINISH, {}))
	end

	return
end

function ys.Battle.BattleWaveInfo:doFail()
	if not self:IsFinish() then
		self._state = var_0_2.STATE_FAIL

		self:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleEvent.WAVE_FINISH, {}))
	end

	return
end

return

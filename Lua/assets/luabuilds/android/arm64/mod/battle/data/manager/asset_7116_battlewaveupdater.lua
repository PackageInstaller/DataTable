ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst.WaveTriggerType
local BattleWaveUpdater = class("BattleWaveUpdater")

ys.Battle.BattleWaveUpdater = BattleWaveUpdater
BattleWaveUpdater.__name = "BattleWaveUpdater"
BattleWaveUpdater.PREWAVES_CONDITION_AND = 0
BattleWaveUpdater.PREWAVES_CONDITION_OR = 1

function BattleWaveUpdater:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_0.EventListener.AttachEventListener(self)

	self._spawnFunc = arg_1_1
	self._airFighterFunc = arg_1_2
	self._clearFunc = arg_1_3
	self._spawnAreaFunc = arg_1_4

	self:Init()

	return
end

function BattleWaveUpdater:Init()
	self._monsterList = {}
	self._spawnList = {}
	self._airFighter = {}
	self._waveInfos = {}
	self._timerList = {}
	self._waveUnitAliveList = {}
	self._keyList = {}
	self._waveInfoList = {}

	return
end

function BattleWaveUpdater:SetWavesData(arg_3_1)
	self._waveTmpData = arg_3_1

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.waves) do
		local var_3_0

		if iter_3_1.triggerType == var_0_1.NORMAL then
			var_3_0 = var_0_0.Battle.BattleSpawnWave.New()

			var_3_0:SetCallback(self._spawnFunc, self._airFighterFunc)
		elseif iter_3_1.triggerType == var_0_1.TIMER then
			var_3_0 = var_0_0.Battle.BattleDelayWave.New()
		elseif iter_3_1.triggerType == var_0_1.RANGE then
			var_3_0 = var_0_0.Battle.BattleRangeWave.New()

			var_3_0:SetCallback(self._spawnAreaFunc)
		elseif iter_3_1.triggerType == var_0_1.STORY then
			var_3_0 = var_0_0.Battle.BattleStoryWave.New()
		elseif iter_3_1.triggerType == var_0_1.AID then
			var_3_0 = var_0_0.Battle.BattleAidWave.New()
		elseif iter_3_1.triggerType == var_0_1.BGM then
			var_3_0 = var_0_0.Battle.BattleSwitchBGMWave.New()
		elseif iter_3_1.triggerType == var_0_1.GUIDE then
			var_3_0 = var_0_0.Battle.BattleGuideWave.New()
		elseif iter_3_1.triggerType == var_0_1.CAMERA then
			var_3_0 = var_0_0.Battle.BattleCameraWave.New()
		elseif iter_3_1.triggerType == var_0_1.CLEAR then
			var_3_0 = var_0_0.Battle.BattleClearWave.New()
		elseif iter_3_1.triggerType == var_0_1.JAMMING then
			var_3_0 = var_0_0.Battle.BattleJammingWave.New()
		elseif iter_3_1.triggerType == var_0_1.ENVIRONMENT then
			var_3_0 = var_0_0.Battle.BattleEnvironmentWave.New()
		elseif iter_3_1.triggerType == var_0_1.LABEL then
			var_3_0 = var_0_0.Battle.BattleLabelWave.New()
		elseif iter_3_1.triggerType == var_0_1.CARD_PUZZLE then
			var_3_0 = var_0_0.Battle.BattleCardPuzzleWave.New()
		end

		var_3_0:SetWaveData(iter_3_1)
		var_3_0:RegisterEventListener(self, var_0_0.Battle.BattleEvent.WAVE_FINISH, self.onWaveFinish)

		self._waveInfoList[var_3_0:GetIndex()] = var_3_0

		if var_3_0:IsKeyWave() then
			self._keyList[#self._keyList + 1] = var_3_0
		end
	end

	for iter_3_2, iter_3_3 in pairs(self._waveInfoList) do
		for iter_3_4, iter_3_5 in ipairs(iter_3_3:GetPreWaveIDs()) do
			if self._waveInfoList[iter_3_5] then
				iter_3_3:AppendPreWave(self._waveInfoList[iter_3_5])
				self._waveInfoList[iter_3_5]:AppendPostWave(iter_3_3)
			end
		end

		for iter_3_6, iter_3_7 in pairs(iter_3_3:GetBranchWaveIDs()) do
			if self._waveInfoList[iter_3_6] then
				iter_3_3:AppendBranchWave(self._waveInfoList[iter_3_6])
			end
		end
	end

	return
end

function BattleWaveUpdater:Start()
	self._active = true

	for iter_4_0, iter_4_1 in pairs(self._waveInfoList) do
		if iter_4_1:IsReady() then
			iter_4_1:DoBranch()
		end
	end

	return
end

function BattleWaveUpdater:AddMonster(arg_5_1)
	for iter_5_0, iter_5_1 in pairs(self._waveInfoList) do
		iter_5_1:AddMonster(arg_5_1)
	end

	return
end

function BattleWaveUpdater:RemoveMonster(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(self._waveInfoList) do
		iter_6_1:RemoveMonster(arg_6_1)
	end

	return
end

function BattleWaveUpdater:onWaveFinish(arg_7_1)
	if not self._active then
		return
	end

	if self:CheckAllKeyWave() then
		self._active = false

		self._clearFunc()
	end

	for iter_7_0, iter_7_1 in ipairs((arg_7_1.Dispatcher:GetPostWaves())) do
		if iter_7_1:IsReady() and iter_7_1:GetState() == iter_7_1.STATE_DEACTIVE then
			iter_7_1:DoBranch()
		end
	end

	return
end

function BattleWaveUpdater:GetAllBossWave()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(self._waveInfoList) do
		if iter_8_1:GetType() == var_0_1.NORMAL and iter_8_1:IsBossWave() then
			table.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0
end

function BattleWaveUpdater:CheckAllKeyWave()
	for iter_9_0, iter_9_1 in ipairs(self._keyList) do
		if not iter_9_1:IsFinish() then
			return false
		end
	end

	return true
end

function BattleWaveUpdater:Clear()
	for iter_10_0, iter_10_1 in pairs(self._timerList) do
		self:RemoveTimer(iter_10_0)
	end

	for iter_10_2, iter_10_3 in pairs(self._waveInfoList) do
		iter_10_3:UnregisterEventListener(self, var_0_0.Battle.BattleEvent.WAVE_FINISH)
		iter_10_3:Dispose()
	end

	self._waveInfoList = nil
	self._keyList = nil

	self:Init()
	var_0_0.EventListener.DetachEventListener(self)

	return
end

function BattleWaveUpdater:GetUnfinishedWaveCount()
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in pairs(self._waveInfoList) do
		if not iter_11_1:IsFinish() then
			var_11_0 = var_11_0 + 1
		end
	end

	return var_11_0
end

return

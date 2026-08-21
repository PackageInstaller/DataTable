ys = ys or {}

local var_0_0 = ys.Battle.BattleConst.WaveTriggerType
local var_0_1 = class("BattleWaveUpdater")

ys.Battle.BattleWaveUpdater = var_0_1
var_0_1.__name = "BattleWaveUpdater"
var_0_1.PREWAVES_CONDITION_AND = 0
var_0_1.PREWAVES_CONDITION_OR = 1

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0._spawnFunc = arg_1_1
	arg_1_0._airFighterFunc = arg_1_2
	arg_1_0._clearFunc = arg_1_3
	arg_1_0._spawnAreaFunc = arg_1_4

	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	arg_2_0._monsterList = {}
	arg_2_0._spawnList = {}
	arg_2_0._airFighter = {}
	arg_2_0._waveInfos = {}
	arg_2_0._timerList = {}
	arg_2_0._waveUnitAliveList = {}
	arg_2_0._keyList = {}
	arg_2_0._waveInfoList = {}

	return
end

function var_0_1.SetWavesData(arg_3_0, arg_3_1)
	arg_3_0._waveTmpData = arg_3_1

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.waves) do
		local var_3_0

		if iter_3_1.triggerType == var_0_0.NORMAL then
			var_3_0 = var_0.Battle.BattleSpawnWave.New()

			var_3_0:SetCallback(arg_3_0._spawnFunc, arg_3_0._airFighterFunc)
		elseif iter_3_1.triggerType == var_0_0.TIMER then
			var_3_0 = var_0.Battle.BattleDelayWave.New()
		elseif iter_3_1.triggerType == var_0_0.RANGE then
			var_3_0 = var_0.Battle.BattleRangeWave.New()

			var_3_0:SetCallback(arg_3_0._spawnAreaFunc)
		elseif iter_3_1.triggerType == var_0_0.STORY then
			var_3_0 = var_0.Battle.BattleStoryWave.New()
		elseif iter_3_1.triggerType == var_0_0.AID then
			var_3_0 = var_0.Battle.BattleAidWave.New()
		elseif iter_3_1.triggerType == var_0_0.BGM then
			var_3_0 = var_0.Battle.BattleSwitchBGMWave.New()
		elseif iter_3_1.triggerType == var_0_0.GUIDE then
			var_3_0 = var_0.Battle.BattleGuideWave.New()
		elseif iter_3_1.triggerType == var_0_0.CAMERA then
			var_3_0 = var_0.Battle.BattleCameraWave.New()
		elseif iter_3_1.triggerType == var_0_0.CLEAR then
			var_3_0 = var_0.Battle.BattleClearWave.New()
		elseif iter_3_1.triggerType == var_0_0.JAMMING then
			var_3_0 = var_0.Battle.BattleJammingWave.New()
		elseif iter_3_1.triggerType == var_0_0.ENVIRONMENT then
			var_3_0 = var_0.Battle.BattleEnvironmentWave.New()
		elseif iter_3_1.triggerType == var_0_0.LABEL then
			var_3_0 = var_0.Battle.BattleLabelWave.New()
		elseif iter_3_1.triggerType == var_0_0.CARD_PUZZLE then
			var_3_0 = var_0.Battle.BattleCardPuzzleWave.New()
		end

		var_3_0:SetWaveData(iter_3_1)
		var_3_0:RegisterEventListener(arg_3_0, var_0.Battle.BattleEvent.WAVE_FINISH, arg_3_0.onWaveFinish)

		arg_3_0._waveInfoList[var_3_0:GetIndex()] = var_3_0

		if var_3_0:IsKeyWave() then
			arg_3_0._keyList[#arg_3_0._keyList + 1] = var_3_0
		end
	end

	for iter_3_2, iter_3_3 in pairs(arg_3_0._waveInfoList) do
		for iter_3_4, iter_3_5 in ipairs(iter_3_3:GetPreWaveIDs()) do
			if arg_3_0._waveInfoList[iter_3_5] then
				iter_3_3:AppendPreWave(arg_3_0._waveInfoList[iter_3_5])
				arg_3_0._waveInfoList[iter_3_5]:AppendPostWave(iter_3_3)
			end
		end

		for iter_3_6, iter_3_7 in pairs(iter_3_3:GetBranchWaveIDs()) do
			if arg_3_0._waveInfoList[iter_3_6] then
				iter_3_3:AppendBranchWave(arg_3_0._waveInfoList[iter_3_6])
			end
		end
	end

	return
end

function var_0_1.Start(arg_4_0)
	arg_4_0._active = true

	for iter_4_0, iter_4_1 in pairs(arg_4_0._waveInfoList) do
		if iter_4_1:IsReady() then
			iter_4_1:DoBranch()
		end
	end

	return
end

function var_0_1.AddMonster(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._waveInfoList) do
		iter_5_1:AddMonster(arg_5_1)
	end

	return
end

function var_0_1.RemoveMonster(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._waveInfoList) do
		iter_6_1:RemoveMonster(arg_6_1)
	end

	return
end

function var_0_1.onWaveFinish(arg_7_0, arg_7_1)
	if not arg_7_0._active then
		return
	end

	if arg_7_0:CheckAllKeyWave() then
		arg_7_0._active = false

		arg_7_0._clearFunc()
	end

	for iter_7_0, iter_7_1 in ipairs((arg_7_1.Dispatcher:GetPostWaves())) do
		if iter_7_1:IsReady() and iter_7_1:GetState() == iter_7_1.STATE_DEACTIVE then
			iter_7_1:DoBranch()
		end
	end

	return
end

function var_0_1.GetAllBossWave(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._waveInfoList) do
		if iter_8_1:GetType() == var_0_0.NORMAL and iter_8_1:IsBossWave() then
			table.insert({}, iter_8_1)
		end
	end

	return {}
end

function var_0_1.CheckAllKeyWave(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._keyList) do
		if not iter_9_1:IsFinish() then
			return false
		end
	end

	return true
end

function var_0_1.Clear(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._timerList) do
		arg_10_0:RemoveTimer(iter_10_0)
	end

	for iter_10_2, iter_10_3 in pairs(arg_10_0._waveInfoList) do
		iter_10_3:UnregisterEventListener(arg_10_0, var_0.Battle.BattleEvent.WAVE_FINISH)
		iter_10_3:Dispose()
	end

	arg_10_0._waveInfoList = nil
	arg_10_0._keyList = nil

	arg_10_0:Init()
	var_0.EventListener.DetachEventListener(arg_10_0)

	return
end

function var_0_1.GetUnfinishedWaveCount(arg_11_0)
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in pairs(arg_11_0._waveInfoList) do
		if not iter_11_1:IsFinish() then
			var_11_0 = var_11_0 + 1
		end
	end

	return var_11_0
end

return

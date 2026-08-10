local var_0_0 = {}
local var_0_1 = require("cjson")
local var_0_2 = "SummerRace.BattleSnapshot"
local var_0_3 = "SummerRace.BattleSettlement"
local var_0_4 = "SummerRace.StageResolved"
local var_0_5 = "SummerRace.SpecialDefeat"
local var_0_6 = "SummerRace.SpecialDefeatFinished"
local var_0_7 = "SummerRace.DamageText"
local var_0_8 = "SummerRace.PlayerLabelPose"
local var_0_9 = "SummerRace.TimeoutResult"
local var_0_10 = "SummerRace.BattleResultBanner"
local var_0_11 = "idle"
local var_0_12 = "entering"
local var_0_13 = "entered"
local var_0_14 = "leaving"

local function var_0_15()
	if SummerRaceAction == nil then
		error("[SummerRaceBridge] SummerRaceAction global is not initialized")
	end

	return SummerRaceAction
end

local function var_0_16(arg_2_0)
	local var_2_0, var_2_1 = pcall(var_0_1.decode, arg_2_0)

	if not var_2_0 or type(var_2_1) ~= "table" then
		error("[SummerRaceBridge] invalid payload: " .. tostring(arg_2_0))
	end

	return var_2_1
end

local function var_0_17(arg_3_0)
	if gameContext and gameContext.SetSystemLayer then
		pcall(function()
			gameContext:SetSystemLayer(arg_3_0)
		end)
	end
end

local function var_0_18(arg_5_0, arg_5_1)
	if arg_5_0 == var_0_2 then
		var_0_15().RecordRuntimeSnapshot(var_0_16(arg_5_1))

		return
	end

	if arg_5_0 == var_0_4 then
		local var_5_0 = var_0_16(arg_5_1)

		var_0_15().RecordStageResolved(var_5_0.stageId, var_5_0.mode)

		return
	end

	if arg_5_0 == var_0_3 then
		var_0_15().RecordSettlement(var_0_16(arg_5_1))
		var_0_15().OpenSettlementResult()

		return
	end

	if arg_5_0 == var_0_5 then
		var_0_15().OnSpecialDefeatTriggered(var_0_16(arg_5_1))

		return
	end

	if arg_5_0 == var_0_6 then
		var_0_15().OnSpecialDefeatFinished(var_0_16(arg_5_1))

		return
	end

	if arg_5_0 == SummerRaceConst.BRIDGE_EVENT.ENEMY_DEFEAT_BEFORE_FX then
		var_0_15().OnEnemyDefeatBeforeFxTriggered(var_0_16(arg_5_1))

		return
	end

	if arg_5_0 == var_0_9 then
		var_0_15().OnTimeoutResult(var_0_16(arg_5_1))

		return
	end

	if arg_5_0 == var_0_10 then
		var_0_15().OnBattleResultBanner(var_0_16(arg_5_1))

		return
	end

	if arg_5_0 == var_0_7 then
		var_0_15().RecordDamageText(var_0_16(arg_5_1))

		return
	end

	if arg_5_0 == var_0_8 then
		var_0_15().RecordPlayerLabelPose(var_0_16(arg_5_1))
	end
end

function var_0_0.GetState(arg_6_0)
	return arg_6_0.state_ or var_0_11
end

function var_0_0.SetState(arg_7_0, arg_7_1)
	arg_7_0.state_ = arg_7_1
end

function var_0_0.EnterPlay(arg_8_0, arg_8_1)
	return var_0_15().LaunchBattle(arg_8_1)
end

function var_0_0.LeavePlay(arg_9_0, arg_9_1)
	local var_9_0 = SummerRaceLuaBridge

	if var_9_0 == nil or var_9_0.ExitScene == nil then
		return false
	end

	local var_9_1 = arg_9_0:GetState()

	if var_9_1 == var_0_12 or var_9_1 == var_0_14 then
		return false
	end

	arg_9_0:SetState(var_0_14)

	local var_9_2 = var_9_0.ExitScene(LuaHelper.VoidAction(function()
		arg_9_0:SetState(var_0_11)

		if type(arg_9_1) == "function" then
			arg_9_1()
		end
	end))

	if var_9_2 ~= true then
		arg_9_0:SetState(var_9_1)
	end

	return var_9_2 == true
end

function var_0_0.OnSceneReady()
	if manager and manager.uiInit then
		manager.uiInit()
	end

	var_0_17("battle")
	var_0_0:SetState(var_0_13)

	return var_0_15().OpenBattleView({
		source = "sceneReady"
	})
end

function var_0_0.OnSceneExit(arg_12_0)
	var_0_0:SetState(var_0_11)

	if manager and manager.ui and manager.ui.ResetMainCamera then
		manager.ui:ResetMainCamera()
	end

	if arg_12_0 ~= true then
		var_0_17("home")
	end
end

function var_0_0.OnBattleSnapshot(arg_13_0)
	var_0_18(var_0_2, arg_13_0)
end

function var_0_0.OnBattleSettlement(arg_14_0)
	var_0_18(var_0_3, arg_14_0)
end

function var_0_0.OnStageResolved(arg_15_0)
	var_0_18(var_0_4, arg_15_0)
end

function var_0_0.OnSpecialDefeatTriggered(arg_16_0)
	var_0_18(var_0_5, arg_16_0)
end

function var_0_0.OnSpecialDefeatFinished(arg_17_0)
	var_0_18(var_0_6, arg_17_0)
end

function var_0_0.OnEnemyDefeatBeforeFxTriggered(arg_18_0)
	var_0_18(SummerRaceConst.BRIDGE_EVENT.ENEMY_DEFEAT_BEFORE_FX, arg_18_0)
end

function var_0_0.OnTimeoutResult(arg_19_0)
	var_0_18(var_0_9, arg_19_0)
end

function var_0_0.OnBattleResultBanner(arg_20_0)
	var_0_18(var_0_10, arg_20_0)
end

function var_0_0.OnDamageText(arg_21_0)
	var_0_18(var_0_7, arg_21_0)
end

function var_0_0.OnPlayerLabelPose(arg_22_0)
	var_0_18(var_0_8, arg_22_0)
end

return var_0_0

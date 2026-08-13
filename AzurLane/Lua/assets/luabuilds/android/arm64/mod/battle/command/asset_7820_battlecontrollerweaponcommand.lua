ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleEvent
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleControllerWeaponCommand = var_0_10003("BattleControllerWeaponCommand", var_0.MVC.Command)
var_0.Battle.BattleControllerWeaponCommand.__name = "BattleControllerWeaponCommand"

local var_0_3 = var_0.Battle.BattleControllerWeaponCommand

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.Initialize(arg_2_0)
	var_0_3.super.Initialize(arg_2_0)

	local var_2_0 = arg_2_0._state

	arg_2_0._dataProxy = var_1.GetProxyByName(var_2_0, var_0.Battle.BattleDataProxy.__name)

	arg_2_0:InitBattleEvent()

	arg_2_0._focusBlockCast = false

	return
end

function var_0_3.ActiveBot(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0._manualWeaponAutoBot

	var_3.SetActive(var_3_0, arg_3_1, arg_3_2)

	local var_3_1 = arg_3_0._joyStickAutoBot

	var_3.SetActive(var_3_1, arg_3_1)

	return
end

function var_0_3.TryAutoSub(arg_4_0)
	local var_4_0 = arg_4_0:GetState()
	local var_4_1 = var_1.GetBattleType(var_4_0)

	if var_0.Battle.BattleState.IsAutoSubActive(var_4_1) then
		local var_4_2 = arg_4_0._dataProxy
		local var_4_3 = var_2.GetFleetByIFF(var_4_2, var_0.Battle.BattleConfig.FRIENDLY_CODE)._submarineVO

		if var_3.GetUseable(var_4_3) and var_3:GetCount() > 0 then
			local var_4_4 = arg_4_0._dataProxy

			var_4.SubmarineStrike(var_4_4, var_0.Battle.BattleConfig.FRIENDLY_CODE)
			var_3:Cast()
		end
	end

	return
end

function var_0_3.GetWeaponBot(arg_5_0)
	return arg_5_0._manualWeaponAutoBot
end

function var_0_3.GetBotActiveDuration(arg_6_0)
	local var_6_0 = arg_6_0._manualWeaponAutoBot

	return var_1.GetTotalActiveDuration(var_6_0)
end

function var_0_3.GetStickBot(arg_7_0)
	return arg_7_0._joyStickAutoBot
end

function var_0_3.InitBattleEvent(arg_8_0)
	local var_8_0 = arg_8_0._dataProxy

	var_1.RegisterEventListener(var_8_0, arg_8_0, var_0_1.COMMON_DATA_INIT_FINISH, arg_8_0.onUnitInitFinish)

	local var_8_1 = arg_8_0._dataProxy

	var_1.RegisterEventListener(var_8_1, arg_8_0, var_0_1.JAMMING, arg_8_0.onJamming)

	return
end

function var_0_3.Update(arg_9_0, arg_9_1)
	if arg_9_0._jammingFlag then
		return
	end

	if not arg_9_0._focusBlockCast then
		local var_9_0 = arg_9_0._manualWeaponAutoBot

		var_2.Update(var_9_0)
	end

	pairs = var_2

	for iter_9_0, iter_9_1 in var_2(arg_9_0._fleetList) do
		iter_9_1:UpdateManualWeaponVO(arg_9_1)
	end

	return
end

function var_0_3.onJamming(arg_10_0, arg_10_1)
	arg_10_0._jammingFlag = arg_10_1.Data.jammingFlag

	return
end

function var_0_3.onUnitInitFinish(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._dataProxy

	arg_11_0._fleetList = var_2.GetFleetList(var_11_0)

	local var_11_1 = arg_11_0._dataProxy
	local var_11_2 = var_2.GetFleetByIFF(var_11_1, var_0.Battle.BattleConfig.FRIENDLY_CODE)

	var_2.RegisterEventListener(var_11_2, arg_11_0, var_0_1.REFRESH_FLEET_FORMATION, arg_11_0.onFleetFormationUpdate)
	var_2:RegisterEventListener(arg_11_0, var_0_1.OVERRIDE_AUTO_BOT, arg_11_0.onOverrideAutoBot)

	arg_11_0._manualWeaponAutoBot = var_0.Battle.BattleManualWeaponAutoBot.New(var_2)
	arg_11_0._joyStickAutoBot = var_0.Battle.BattleJoyStickAutoBot.New(arg_11_0._dataProxy, var_2)

	local var_11_3 = arg_11_0._dataProxy
	local var_11_4 = var_3.GetInitData(var_11_3).battleType

	SYSTEM_SCENARIO_SUB_STRIKE = var_11_1

	if var_11_4 == var_11_1 then
		local var_11_5 = arg_11_0._joyStickAutoBot

		var_3.SwitchStrategy(var_11_5, arg_11_0._joyStickAutoBot.IDLE)
	else
		local var_11_6 = arg_11_0._joyStickAutoBot

		var_3.SwitchStrategy(var_11_6, arg_11_0._joyStickAutoBot.RANDOM)
	end

	local var_11_7 = var_0.Battle.BattleCameraUtil.GetInstance()

	var_3.RegisterEventListener(var_11_7, arg_11_0, var_0_1.CAMERA_FOCUS, arg_11_0.onCameraFocus)

	return
end

function var_0_3.onFleetFormationUpdate(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._joyStickAutoBot

	var_2.FleetFormationUpdate(var_12_0)

	return
end

function var_0_3.onOverrideAutoBot(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._joyStickAutoBot

	var_2.SwitchStrategy(var_13_0, var_0.Battle.BattleJoyStickAutoBot.AUTO_PILOT)

	return
end

function var_0_3.onCameraFocus(arg_14_0, arg_14_1)
	if arg_14_1.Data.unit ~= nil then
		arg_14_0._focusBlockCast = true
	else
		local var_14_0 = var_2.duration + var_2.extraBulletTime

		LeanTween = var_4

		local var_14_1 = var_4.delayedCall
		local var_14_2 = var_14_0

		System = var_1_10007

		var_14_1(var_14_2, var_1_10007.Action(function()
			arg_14_0._focusBlockCast = false

			return
		end))
	end

	return
end

function var_0_3.Dispose(arg_16_0)
	local var_16_0 = arg_16_0._dataProxy
	local var_16_1 = var_1.GetFleetByIFF(var_16_0, var_0.Battle.BattleConfig.FRIENDLY_CODE)

	var_1.UnregisterEventListener(var_16_1, arg_16_0, var_0_1.REFRESH_FLEET_FORMATION)
	var_1:UnregisterEventListener(arg_16_0, var_0_1.OVERRIDE_AUTO_BOT)

	local var_16_2 = arg_16_0._dataProxy

	var_2.UnregisterEventListener(var_16_2, arg_16_0, var_0_1.COMMON_DATA_INIT_FINISH)

	local var_16_3 = var_0.Battle.BattleCameraUtil.GetInstance()

	var_2.UnregisterEventListener(var_16_3, arg_16_0, var_0_1.CAMERA_FOCUS)

	local var_16_4 = arg_16_0._joyStickAutoBot

	var_2.Dispose(var_16_4)

	arg_16_0._joyStickAutoBot = nil

	local var_16_5 = arg_16_0._manualWeaponAutoBot

	var_2.Dispose(var_16_5)

	arg_16_0._manualWeaponAutoBot = nil

	var_0_3.super.Dispose(arg_16_0)

	return
end

return

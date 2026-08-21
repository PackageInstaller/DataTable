ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleEvent

ys.Battle.BattleControllerWeaponCommand = class("BattleControllerWeaponCommand", ys.MVC.Command)
ys.Battle.BattleControllerWeaponCommand.__name = "BattleControllerWeaponCommand"

local var_0_2 = ys.Battle.BattleControllerWeaponCommand

function ys.Battle.BattleControllerWeaponCommand.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleControllerWeaponCommand.Initialize(arg_2_0)
	var_0_2.super.Initialize(arg_2_0)

	arg_2_0._dataProxy = arg_2_0._state:GetProxyByName(var_0_0.Battle.BattleDataProxy.__name)

	arg_2_0:InitBattleEvent()

	arg_2_0._focusBlockCast = false

	return
end

function ys.Battle.BattleControllerWeaponCommand.ActiveBot(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._manualWeaponAutoBot:SetActive(arg_3_1, arg_3_2)
	arg_3_0._joyStickAutoBot:SetActive(arg_3_1)

	return
end

function ys.Battle.BattleControllerWeaponCommand.TryAutoSub(arg_4_0)
	if var_0_0.Battle.BattleState.IsAutoSubActive((arg_4_0:GetState():GetBattleType())) then
		local var_4_0 = arg_4_0._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)._submarineVO

		if var_4_0:GetUseable() and var_4_0:GetCount() > 0 then
			arg_4_0._dataProxy:SubmarineStrike(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)
			var_4_0:Cast()
		end
	end

	return
end

function ys.Battle.BattleControllerWeaponCommand.GetWeaponBot(arg_5_0)
	return arg_5_0._manualWeaponAutoBot
end

function ys.Battle.BattleControllerWeaponCommand.GetBotActiveDuration(arg_6_0)
	return arg_6_0._manualWeaponAutoBot:GetTotalActiveDuration()
end

function ys.Battle.BattleControllerWeaponCommand.GetStickBot(arg_7_0)
	return arg_7_0._joyStickAutoBot
end

function ys.Battle.BattleControllerWeaponCommand.InitBattleEvent(arg_8_0)
	arg_8_0._dataProxy:RegisterEventListener(arg_8_0, var_0_1.COMMON_DATA_INIT_FINISH, arg_8_0.onUnitInitFinish)
	arg_8_0._dataProxy:RegisterEventListener(arg_8_0, var_0_1.JAMMING, arg_8_0.onJamming)

	return
end

function ys.Battle.BattleControllerWeaponCommand.Update(arg_9_0, arg_9_1)
	if arg_9_0._jammingFlag then
		return
	end

	if not arg_9_0._focusBlockCast then
		arg_9_0._manualWeaponAutoBot:Update()
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_0._fleetList) do
		iter_9_1:UpdateManualWeaponVO(arg_9_1)
	end

	return
end

function ys.Battle.BattleControllerWeaponCommand.onJamming(arg_10_0, arg_10_1)
	arg_10_0._jammingFlag = arg_10_1.Data.jammingFlag

	return
end

function ys.Battle.BattleControllerWeaponCommand.onUnitInitFinish(arg_11_0, arg_11_1)
	arg_11_0._fleetList = arg_11_0._dataProxy:GetFleetList()

	local var_11_0 = arg_11_0._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)

	var_11_0:RegisterEventListener(arg_11_0, var_0_1.REFRESH_FLEET_FORMATION, arg_11_0.onFleetFormationUpdate)
	var_11_0:RegisterEventListener(arg_11_0, var_0_1.OVERRIDE_AUTO_BOT, arg_11_0.onOverrideAutoBot)

	arg_11_0._manualWeaponAutoBot = var_0_0.Battle.BattleManualWeaponAutoBot.New(var_11_0)
	arg_11_0._joyStickAutoBot = var_0_0.Battle.BattleJoyStickAutoBot.New(arg_11_0._dataProxy, var_11_0)

	if arg_11_0._dataProxy:GetInitData().battleType == SYSTEM_SCENARIO_SUB_STRIKE then
		arg_11_0._joyStickAutoBot:SwitchStrategy(arg_11_0._joyStickAutoBot.IDLE)
	else
		arg_11_0._joyStickAutoBot:SwitchStrategy(arg_11_0._joyStickAutoBot.RANDOM)
	end

	var_0_0.Battle.BattleCameraUtil.GetInstance():RegisterEventListener(arg_11_0, var_0_1.CAMERA_FOCUS, arg_11_0.onCameraFocus)

	return
end

function ys.Battle.BattleControllerWeaponCommand.onFleetFormationUpdate(arg_12_0, arg_12_1)
	arg_12_0._joyStickAutoBot:FleetFormationUpdate()

	return
end

function ys.Battle.BattleControllerWeaponCommand.onOverrideAutoBot(arg_13_0, arg_13_1)
	arg_13_0._joyStickAutoBot:SwitchStrategy(var_0_0.Battle.BattleJoyStickAutoBot.AUTO_PILOT)

	return
end

function ys.Battle.BattleControllerWeaponCommand.onCameraFocus(arg_14_0, arg_14_1)
	if arg_14_1.Data.unit ~= nil then
		arg_14_0._focusBlockCast = true
	else
		LeanTween.delayedCall(arg_14_1.Data.duration + arg_14_1.Data.extraBulletTime, System.Action(function()
			arg_14_0._focusBlockCast = false

			return
		end))
	end

	return
end

function ys.Battle.BattleControllerWeaponCommand.Dispose(arg_16_0)
	local var_16_0 = arg_16_0._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)

	var_16_0:UnregisterEventListener(arg_16_0, var_0_1.REFRESH_FLEET_FORMATION)
	var_16_0:UnregisterEventListener(arg_16_0, var_0_1.OVERRIDE_AUTO_BOT)
	arg_16_0._dataProxy:UnregisterEventListener(arg_16_0, var_0_1.COMMON_DATA_INIT_FINISH)
	var_0_0.Battle.BattleCameraUtil.GetInstance():UnregisterEventListener(arg_16_0, var_0_1.CAMERA_FOCUS)
	arg_16_0._joyStickAutoBot:Dispose()

	arg_16_0._joyStickAutoBot = nil

	arg_16_0._manualWeaponAutoBot:Dispose()

	arg_16_0._manualWeaponAutoBot = nil

	var_0_2.super.Dispose(arg_16_0)

	return
end

return

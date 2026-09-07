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

function ys.Battle.BattleControllerWeaponCommand:Initialize()
	var_0_2.super.Initialize(self)

	self._dataProxy = self._state:GetProxyByName(var_0_0.Battle.BattleDataProxy.__name)

	self:InitBattleEvent()

	self._focusBlockCast = false

	return
end

function ys.Battle.BattleControllerWeaponCommand:ActiveBot(arg_3_1, arg_3_2)
	self._manualWeaponAutoBot:SetActive(arg_3_1, arg_3_2)
	self._joyStickAutoBot:SetActive(arg_3_1)

	return
end

function ys.Battle.BattleControllerWeaponCommand:TryAutoSub()
	if var_0_0.Battle.BattleState.IsAutoSubActive((self:GetState():GetBattleType())) then
		local var_4_0 = self._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)._submarineVO

		if var_4_0:GetUseable() and var_4_0:GetCount() > 0 then
			self._dataProxy:SubmarineStrike(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)
			var_4_0:Cast()
		end
	end

	return
end

function ys.Battle.BattleControllerWeaponCommand:GetWeaponBot()
	return self._manualWeaponAutoBot
end

function ys.Battle.BattleControllerWeaponCommand:GetBotActiveDuration()
	return self._manualWeaponAutoBot:GetTotalActiveDuration()
end

function ys.Battle.BattleControllerWeaponCommand:GetStickBot()
	return self._joyStickAutoBot
end

function ys.Battle.BattleControllerWeaponCommand:InitBattleEvent()
	self._dataProxy:RegisterEventListener(self, var_0_1.COMMON_DATA_INIT_FINISH, self.onUnitInitFinish)
	self._dataProxy:RegisterEventListener(self, var_0_1.JAMMING, self.onJamming)

	return
end

function ys.Battle.BattleControllerWeaponCommand:Update(arg_9_1)
	if self._jammingFlag then
		return
	end

	if not self._focusBlockCast then
		self._manualWeaponAutoBot:Update()
	end

	for iter_9_0, iter_9_1 in pairs(self._fleetList) do
		iter_9_1:UpdateManualWeaponVO(arg_9_1)
	end

	return
end

function ys.Battle.BattleControllerWeaponCommand.onJamming(arg_10_0, arg_10_1)
	arg_10_0._jammingFlag = arg_10_1.Data.jammingFlag

	return
end

function ys.Battle.BattleControllerWeaponCommand:onUnitInitFinish(arg_11_1)
	self._fleetList = self._dataProxy:GetFleetList()

	local var_11_0 = self._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)

	var_11_0:RegisterEventListener(self, var_0_1.REFRESH_FLEET_FORMATION, self.onFleetFormationUpdate)
	var_11_0:RegisterEventListener(self, var_0_1.OVERRIDE_AUTO_BOT, self.onOverrideAutoBot)

	self._manualWeaponAutoBot = var_0_0.Battle.BattleManualWeaponAutoBot.New(var_11_0)
	self._joyStickAutoBot = var_0_0.Battle.BattleJoyStickAutoBot.New(self._dataProxy, var_11_0)

	if self._dataProxy:GetInitData().battleType == SYSTEM_SCENARIO_SUB_STRIKE then
		self._joyStickAutoBot:SwitchStrategy(self._joyStickAutoBot.IDLE)
	else
		self._joyStickAutoBot:SwitchStrategy(self._joyStickAutoBot.RANDOM)
	end

	var_0_0.Battle.BattleCameraUtil.GetInstance():RegisterEventListener(self, var_0_1.CAMERA_FOCUS, self.onCameraFocus)

	return
end

function ys.Battle.BattleControllerWeaponCommand:onFleetFormationUpdate(arg_12_1)
	self._joyStickAutoBot:FleetFormationUpdate()

	return
end

function ys.Battle.BattleControllerWeaponCommand:onOverrideAutoBot(arg_13_1)
	self._joyStickAutoBot:SwitchStrategy(var_0_0.Battle.BattleJoyStickAutoBot.AUTO_PILOT)

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

function ys.Battle.BattleControllerWeaponCommand:Dispose()
	local var_16_0 = self._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)

	var_16_0:UnregisterEventListener(self, var_0_1.REFRESH_FLEET_FORMATION)
	var_16_0:UnregisterEventListener(self, var_0_1.OVERRIDE_AUTO_BOT)
	self._dataProxy:UnregisterEventListener(self, var_0_1.COMMON_DATA_INIT_FINISH)
	var_0_0.Battle.BattleCameraUtil.GetInstance():UnregisterEventListener(self, var_0_1.CAMERA_FOCUS)
	self._joyStickAutoBot:Dispose()

	self._joyStickAutoBot = nil

	self._manualWeaponAutoBot:Dispose()

	self._manualWeaponAutoBot = nil

	var_0_2.super.Dispose(self)

	return
end

return

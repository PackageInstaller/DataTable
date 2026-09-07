ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleUnitEvent
local var_0_2 = ys.Battle.BattleEvent
local BattleSimulationCommand = class("BattleSimulationCommand", ys.MVC.Command)

ys.Battle.BattleSimulationCommand = BattleSimulationCommand
BattleSimulationCommand.__name = "BattleSimulationCommand"

function BattleSimulationCommand:Ctor()
	BattleSimulationCommand.super.Ctor(self)

	return
end

function BattleSimulationCommand:ConfigBattleData(arg_2_1)
	self._battleInitData = arg_2_1

	return
end

function BattleSimulationCommand:Initialize()
	self:Init()
	BattleSimulationCommand.super.Initialize(self)

	self._dataProxy = self._state:GetProxyByName(var_0_0.Battle.BattleDataProxy.__name)
	self._uiMediator = self._state:GetMediatorByName(var_0_0.Battle.BattleUIMediator.__name)

	self:InitProtocol()
	self:AddEvent()

	return
end

function BattleSimulationCommand:DoPrologue()
	self._dataProxy:InitUserShipsData(self._battleInitData.RivalMainUnitList, self._battleInitData.RivalVanguardUnitList, var_0_0.Battle.BattleConfig.FOE_CODE, {})
	self._userFleet:SnapShot()
	self._rivalFleet:SnapShot()

	self._rivalWeaponBot = var_0_0.Battle.BattleManualWeaponAutoBot.New(self._rivalFleet)
	self._rivalJoyStickBot = var_0_0.Battle.BattleJoyStickAutoBot.New(self._dataProxy, self._rivalFleet)
	self._buffView = self._uiMediator:InitSimulationBuffCounting()

	self._uiMediator:OpeningEffect(function()
		self._state:ChangeState(var_0_0.Battle.BattleState.BATTLE_STATE_FIGHT)
		self._uiMediator:ShowAutoBtn()
		self._rivalWeaponBot:SetActive(true, false)
		self._rivalJoyStickBot:SetActive(true)
		self._uiMediator:ShowTimer()
		self._uiMediator:ShowSimulationView()

		return
	end)
	self._userFleet:FleetWarcry()
	self._dataProxy:InitAllFleetUnitsWeaponCD()
	self._dataProxy:TirggerBattleStartBuffs()

	for iter_4_0, iter_4_1 in ipairs((self._userFleet:GetUnitList())) do
		iter_4_1:AddBuff((var_0_0.Battle.BattleBuffUnit.New(var_0_0.Battle.BattleConfig.SIMULATION_BALANCE_BUFF)))
	end

	local var_4_0 = #self._rivalFleet:GetScoutList()

	if var_4_0 == 0 then
		self:rivalMainUnitPhase()
	elseif var_4_0 > 0 then
		self._rivalDisadvatage = false

		for iter_4_2, iter_4_3 in ipairs((self._rivalFleet:GetMainList())) do
			iter_4_3:AddBuff((var_0_0.Battle.BattleBuffUnit.New(var_0_0.Battle.BattleConfig.SIMULATION_ADVANTAGE_BUFF)))
		end
	end

	self:startBuffCount()
	self._dataProxy:RivalInit(self._rivalFleet:GetUnitList())

	return
end

function BattleSimulationCommand:Update()
	self._rivalWeaponBot:Update()

	return
end

function BattleSimulationCommand:Init()
	self._unitDataList = {}

	return
end

function BattleSimulationCommand:Clear()
	for iter_8_0, iter_8_1 in pairs(self._unitDataList) do
		self:UnregisterUnitEvent(iter_8_1)

		self._unitDataList[iter_8_0] = nil
	end

	return
end

function BattleSimulationCommand:Reinitialize()
	self._state:Deactive()
	self:Clear()
	self:Init()

	return
end

function BattleSimulationCommand:Dispose()
	self:Clear()
	self:RemoveEvent()
	BattleSimulationCommand.super.Dispose(self)

	return
end

function BattleSimulationCommand:onInitBattle()
	self._weaponCommand = self._state:GetCommandByName(var_0_0.Battle.BattleControllerWeaponCommand.__name)
	self._userFleet = self._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)
	self._rivalFleet = self._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FOE_CODE)

	return
end

function BattleSimulationCommand:InitProtocol()
	return
end

function BattleSimulationCommand:AddEvent()
	self._dataProxy:RegisterEventListener(self, var_0_2.ADD_UNIT, self.onAddUnit)
	self._dataProxy:RegisterEventListener(self, var_0_2.REMOVE_UNIT, self.onRemoveUnit)
	self._dataProxy:RegisterEventListener(self, var_0_2.STAGE_DATA_INIT_FINISH, self.onInitBattle)
	self._dataProxy:RegisterEventListener(self, var_0_2.SHUT_DOWN_PLAYER, self.onPlayerShutDown)
	self._dataProxy:RegisterEventListener(self, var_0_2.UPDATE_COUNT_DOWN, self.onUpdateCountDown)

	return
end

function BattleSimulationCommand:RemoveEvent()
	self._dataProxy:UnregisterEventListener(self, var_0_2.ADD_UNIT)
	self._dataProxy:UnregisterEventListener(self, var_0_2.REMOVE_UNIT)
	self._dataProxy:UnregisterEventListener(self, var_0_2.STAGE_DATA_INIT_FINISH)
	self._dataProxy:UnregisterEventListener(self, var_0_2.SHUT_DOWN_PLAYER)
	self._dataProxy:UnregisterEventListener(self, var_0_2.UPDATE_COUNT_DOWN)

	return
end

function BattleSimulationCommand:onAddUnit(arg_15_1)
	self:RegisterUnitEvent(arg_15_1.Data.unit)

	self._unitDataList[arg_15_1.Data.unit:GetUniqueID()] = arg_15_1.Data.unit

	return
end

function BattleSimulationCommand:RegisterUnitEvent(arg_16_1)
	arg_16_1:RegisterEventListener(self, var_0_1.DYING, self.onUnitDying)
	arg_16_1:RegisterEventListener(self, var_0_1.UPDATE_HP, self.onUpdateUnitHP)

	if arg_16_1:GetUnitType() == var_0_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_16_1:RegisterEventListener(self, var_0_1.SHUT_DOWN_PLAYER, self.onShutDownPlayer)
	end

	return
end

function BattleSimulationCommand:UnregisterUnitEvent(arg_17_1)
	arg_17_1:UnregisterEventListener(self, var_0_1.DYING)
	arg_17_1:UnregisterEventListener(self, var_0_1.UPDATE_HP)

	if arg_17_1:GetUnitType() == var_0_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_17_1:UnregisterEventListener(self, var_0_1.SHUT_DOWN_PLAYER)
	end

	return
end

function BattleSimulationCommand:onRemoveUnit(arg_18_1)
	if self._unitDataList[arg_18_1.Data.UID] == nil then
		return
	end

	self:UnregisterUnitEvent(self._unitDataList[arg_18_1.Data.UID])

	self._unitDataList[arg_18_1.Data.UID] = nil

	return
end

function BattleSimulationCommand:onPlayerShutDown(arg_19_1)
	if self._state:GetState() ~= self._state.BATTLE_STATE_FIGHT then
		return
	end

	if self._failReason == nil then
		var_0_0.Battle.BattleState.GenerateVertifyData(1)

		local var_19_0, var_19_1 = var_0_0.Battle.BattleState.Vertify()

		if not var_19_0 then
			self._failReason = 4 + var_19_1
		end
	end

	if #self._rivalFleet:GetUnitList() == 0 then
		self._dataProxy:CalcSimulationScoreAtEnd(self._userFleet, self._rivalFleet)

		if self._failReason then
			pg.m02:sendNotification(GAME.CHEATER_MARK, {
				reason = self._failReason
			})

			return
		end

		self._failReason = nil

		self._dataProxy:TriggerFinishBattle()
		self._state:BattleEnd()
	end

	if arg_19_1.Data.unit == self._userFleet:GetFlagShip() then
		self._dataProxy:TriggerFinishBattle()
		self._dataProxy:CalcSimulationScoreAtEnd(self._userFleet, self._rivalFleet)
		self._state:BattleEnd()

		return
	end

	if #self._userFleet:GetScoutList() == 0 then
		self._dataProxy:TriggerFinishBattle()
		self._dataProxy:CalcSimulationScoreAtEnd(self._userFleet, self._rivalFleet)
		self._state:BattleEnd()
	end

	if #self._rivalFleet:GetScoutList() == 0 and not self._rivalDisadvatage then
		self:rivalMainUnitPhase()
	end

	return
end

function BattleSimulationCommand:rivalMainUnitPhase()
	self:startBuffCount()

	self._rivalDisadvatage = true

	self._rivalJoyStickBot:SetActive(false)
	self._rivalFleet:FreeMainUnit(var_0_0.Battle.BattleConfig.SIMULATION_FREE_BUFF)

	for iter_20_0, iter_20_1 in ipairs((self._rivalFleet:GetMainList())) do
		for iter_20_2, iter_20_3 in ipairs(var_0_0.Battle.BattleConfig.SIMULATION_ADVANTAGE_CANCEL_LIST) do
			iter_20_1:RemoveBuff(iter_20_3)
		end

		iter_20_1:AddBuff((var_0_0.Battle.BattleBuffUnit.New(var_0_0.Battle.BattleConfig.SIMULATION_DISADVANTAGE_BUFF)))
	end

	return
end

function BattleSimulationCommand:onUpdateCountDown(arg_21_1)
	local var_21_0 = self._dataProxy:GetCountDown()

	if self._buffStartTime then
		if var_0_0.Battle.BattleConfig.SIMULATION_RIVAL_RAGE_TOTAL_COUNT - (self._buffStartTime - var_21_0) <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("simulation_enhancing"))

			self._buffStartTime = nil

			self._buffView:SetEnhancedText()
		else
			self._buffView:SetCountDownText(var_0_0.Battle.BattleConfig.SIMULATION_RIVAL_RAGE_TOTAL_COUNT - (self._buffStartTime - var_21_0))
		end
	end

	if var_21_0 <= 0 then
		local var_21_1, var_21_2 = self._userFleet:GetDamageRatioResult()
		local var_21_3, var_21_4 = self._rivalFleet:GetDamageRatioResult()

		self._dataProxy:TriggerFinishBattle()
		self._dataProxy:CalcSimulationScoreAtTimesUp(var_21_1, var_21_3, var_21_2, var_21_4, self._rivalFleet)
		self._state:BattleEnd()
	end

	return
end

function BattleSimulationCommand:onUpdateUnitHP(arg_22_1)
	local var_22_0 = arg_22_1.Dispatcher:GetFleetVO()

	if var_22_0 then
		var_22_0:UpdateFleetDamage(arg_22_1.Data.validDHP)
	end

	return
end

function BattleSimulationCommand:onUnitDying(arg_23_1)
	self._dataProxy:CalcBattleScoreWhenDead(arg_23_1.Dispatcher)
	self._dataProxy:KillUnit((arg_23_1.Dispatcher:GetUniqueID()))

	return
end

function BattleSimulationCommand:onShutDownPlayer(arg_24_1)
	arg_24_1.Dispatcher:GetFleetVO():UpdateFleetOverDamage(arg_24_1.Dispatcher)
	self._dataProxy:ShutdownPlayerUnit((arg_24_1.Dispatcher:GetUniqueID()))

	return
end

function BattleSimulationCommand:startBuffCount()
	self._buffStartTime = self._dataProxy:GetCountDown()

	return
end

return

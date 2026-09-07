ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleUnitEvent
local var_0_2 = ys.Battle.BattleEvent
local BattleDuelArenaCommand = class("BattleDuelArenaCommand", ys.MVC.Command)

ys.Battle.BattleDuelArenaCommand = BattleDuelArenaCommand
BattleDuelArenaCommand.__name = "BattleDuelArenaCommand"

function BattleDuelArenaCommand:Ctor()
	BattleDuelArenaCommand.super.Ctor(self)

	return
end

function BattleDuelArenaCommand:Initialize()
	self:Init()
	BattleDuelArenaCommand.super.Initialize(self)

	self._dataProxy = self._state:GetProxyByName(var_0_0.Battle.BattleDataProxy.__name)
	self._uiMediator = self._state:GetMediatorByName(var_0_0.Battle.BattleUIMediator.__name)

	self:InitProtocol()
	self:AddEvent()

	return
end

function BattleDuelArenaCommand:DoPrologue()
	local var_3_0 = self._dataProxy:GetInitData()

	self._dataProxy:InitUserShipsData(var_3_0.RivalMainUnitList, var_3_0.RivalVanguardUnitList, var_0_0.Battle.BattleConfig.FOE_CODE, {})
	self._userFleet:SnapShot()
	self._rivalFleet:SnapShot()

	self._rivalWeaponBot = var_0_0.Battle.BattleManualWeaponAutoBot.New(self._rivalFleet)
	self._rivalJoyStickBot = var_0_0.Battle.BattleJoyStickAutoBot.New(self._dataProxy, self._rivalFleet)

	self._rivalJoyStickBot:SwitchStrategy(self._rivalJoyStickBot.RANDOM)

	local var_3_1 = self._uiMediator:InitDuelRateBar()
	local var_3_2 = getProxy(PlayerProxy):getData()

	var_3_1:SetFleetVO(self._userFleet, {
		name = var_3_2.name,
		level = var_3_2.level
	})

	local var_3_3 = self._dataProxy:GetInitData().RivalVO

	var_3_1:SetFleetVO(self._rivalFleet, {
		name = var_3_3.name,
		level = var_3_3.level
	})
	self._dataProxy:AutoStatistics(1)
	self._uiMediator:OpeningEffect(function()
		self._state:ChangeState(var_0_0.Battle.BattleState.BATTLE_STATE_FIGHT)
		self._weaponCommand:ActiveBot(true, false)
		self._rivalWeaponBot:SetActive(true, false)
		self._rivalJoyStickBot:SetActive(true)
		self._uiMediator:InitCameraGestureSlider()
		self._uiMediator:ShowTimer()
		self._uiMediator:ShowDuelBar()
		self._uiMediator:EnableJoystick(false)
		self._uiMediator:EnableWeaponButton(false)

		return
	end)

	for iter_3_0, iter_3_1 in pairs((self._dataProxy:GetFleetList())) do
		iter_3_1:FleetWarcry()

		for iter_3_2, iter_3_3 in ipairs((iter_3_1:GetUnitList())) do
			for iter_3_4, iter_3_5 in ipairs((var_0_0.Battle.BattleDataFunction.GetArenaBuffByShipType(iter_3_3:GetTemplate().type))) do
				iter_3_3:AddBuff((var_0_0.Battle.BattleBuffUnit.New(iter_3_5)))
			end
		end
	end

	self._uiMediator:EnableWeaponButton(false)
	self._dataProxy:InitAllFleetUnitsWeaponCD()
	self._dataProxy:TirggerBattleStartBuffs()

	for iter_3_6, iter_3_7 in ipairs((self._userFleet:GetUnitList())) do
		iter_3_7:AddBuff((var_0_0.Battle.BattleBuffUnit.New(var_0_0.Battle.BattleConfig.DULE_BALANCE_BUFF)))
	end

	return
end

function BattleDuelArenaCommand:Update()
	self._rivalWeaponBot:Update()

	return
end

function BattleDuelArenaCommand:Init()
	self._unitDataList = {}

	return
end

function BattleDuelArenaCommand:Clear()
	for iter_7_0, iter_7_1 in pairs(self._unitDataList) do
		self:UnregisterUnitEvent(iter_7_1)

		self._unitDataList[iter_7_0] = nil
	end

	return
end

function BattleDuelArenaCommand:Reinitialize()
	self._state:Deactive()
	self:Clear()
	self:Init()

	return
end

function BattleDuelArenaCommand:Dispose()
	self:Clear()
	self:RemoveEvent()
	BattleDuelArenaCommand.super.Dispose(self)

	return
end

function BattleDuelArenaCommand:onInitBattle()
	self._weaponCommand = self._state:GetCommandByName(var_0_0.Battle.BattleControllerWeaponCommand.__name)
	self._userFleet = self._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)
	self._rivalFleet = self._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FOE_CODE)

	return
end

function BattleDuelArenaCommand:InitProtocol()
	return
end

function BattleDuelArenaCommand:AddEvent()
	self._dataProxy:RegisterEventListener(self, var_0_2.ADD_UNIT, self.onAddUnit)
	self._dataProxy:RegisterEventListener(self, var_0_2.REMOVE_UNIT, self.onRemoveUnit)
	self._dataProxy:RegisterEventListener(self, var_0_2.STAGE_DATA_INIT_FINISH, self.onInitBattle)
	self._dataProxy:RegisterEventListener(self, var_0_2.SHUT_DOWN_PLAYER, self.onPlayerShutDown)
	self._dataProxy:RegisterEventListener(self, var_0_2.UPDATE_COUNT_DOWN, self.onUpdateCountDown)

	return
end

function BattleDuelArenaCommand:RemoveEvent()
	self._dataProxy:UnregisterEventListener(self, var_0_2.ADD_UNIT)
	self._dataProxy:UnregisterEventListener(self, var_0_2.REMOVE_UNIT)
	self._dataProxy:UnregisterEventListener(self, var_0_2.STAGE_DATA_INIT_FINISH)
	self._dataProxy:UnregisterEventListener(self, var_0_2.SHUT_DOWN_PLAYER)
	self._dataProxy:UnregisterEventListener(self, var_0_2.UPDATE_COUNT_DOWN)

	return
end

function BattleDuelArenaCommand:onAddUnit(arg_14_1)
	self:RegisterUnitEvent(arg_14_1.Data.unit)

	self._unitDataList[arg_14_1.Data.unit:GetUniqueID()] = arg_14_1.Data.unit

	return
end

function BattleDuelArenaCommand:RegisterUnitEvent(arg_15_1)
	arg_15_1:RegisterEventListener(self, var_0_1.DYING, self.onUnitDying)
	arg_15_1:RegisterEventListener(self, var_0_1.UPDATE_HP, self.onUpdateUnitHP)

	if arg_15_1:GetUnitType() == var_0_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_15_1:RegisterEventListener(self, var_0_1.SHUT_DOWN_PLAYER, self.onShutDownPlayer)
	end

	return
end

function BattleDuelArenaCommand:UnregisterUnitEvent(arg_16_1)
	arg_16_1:UnregisterEventListener(self, var_0_1.DYING)
	arg_16_1:UnregisterEventListener(self, var_0_1.UPDATE_HP)

	if arg_16_1:GetUnitType() == var_0_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_16_1:UnregisterEventListener(self, var_0_1.SHUT_DOWN_PLAYER)
	end

	return
end

function BattleDuelArenaCommand:onRemoveUnit(arg_17_1)
	if self._unitDataList[arg_17_1.Data.UID] == nil then
		return
	end

	self:UnregisterUnitEvent(self._unitDataList[arg_17_1.Data.UID])

	self._unitDataList[arg_17_1.Data.UID] = nil

	return
end

function BattleDuelArenaCommand:onPlayerShutDown(arg_18_1)
	if self._state:GetState() ~= self._state.BATTLE_STATE_FIGHT then
		return
	end

	if self._failReason == nil then
		var_0_0.Battle.BattleState.GenerateVertifyData(1)

		local var_18_0, var_18_1 = var_0_0.Battle.BattleState.Vertify()

		if not var_18_0 then
			self._failReason = 4 + var_18_1
		end
	end

	if #self._userFleet:GetUnitList() == 0 or #self._rivalFleet:GetUnitList() == 0 then
		self._dataProxy:CalcDuelScoreAtEnd(self._userFleet, self._rivalFleet)

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

	local var_18_2 = #self._userFleet:GetScoutList()
	local var_18_3 = #self._rivalFleet:GetScoutList()

	if var_18_2 == 0 and var_18_3 ~= 0 then
		self._dataProxy:ShiftFleetBound(self._rivalFleet, var_0_0.Battle.BattleConfig.FRIENDLY_CODE)
		self._rivalJoyStickBot:UpdateFleetArea()
		self._rivalJoyStickBot:SwitchStrategy(var_0_0.Battle.BattleJoyStickAutoBot.COUNTER_MAIN)
	end

	if var_18_3 == 0 and var_18_2 ~= 0 then
		self._dataProxy:ShiftFleetBound(self._userFleet, var_0_0.Battle.BattleConfig.FOE_CODE)
		self._weaponCommand:GetStickBot():UpdateFleetArea()
		self._weaponCommand:GetStickBot():SwitchStrategy(var_0_0.Battle.BattleJoyStickAutoBot.COUNTER_MAIN)
	end

	if not arg_18_1.Data.unit:IsMainFleetUnit() and var_18_2 == 0 and var_18_3 == 0 then
		for iter_18_0, iter_18_1 in ipairs((self._userFleet:GetMainList())) do
			iter_18_1:AddBuff((var_0_0.Battle.BattleBuffUnit.New(var_0_0.Battle.BattleConfig.DUEL_MAIN_RAGE_BUFF)))
		end

		for iter_18_2, iter_18_3 in ipairs((self._rivalFleet:GetMainList())) do
			iter_18_3:AddBuff((var_0_0.Battle.BattleBuffUnit.New(var_0_0.Battle.BattleConfig.DUEL_MAIN_RAGE_BUFF)))
		end

		pg.TipsMgr.GetInstance():ShowTips(i18n("battle_duel_main_rage"))
	end

	return
end

function BattleDuelArenaCommand:onUpdateCountDown(arg_19_1)
	if self._dataProxy:GetCountDown() <= 0 then
		local var_19_0, var_19_1 = self._userFleet:GetDamageRatioResult()
		local var_19_2, var_19_3 = self._rivalFleet:GetDamageRatioResult()

		self._dataProxy:TriggerFinishBattle()
		self._dataProxy:CalcDuelScoreAtTimesUp(var_19_0, var_19_2, var_19_1, var_19_3)
		self._state:BattleEnd()
	end

	return
end

function BattleDuelArenaCommand:onUpdateUnitHP(arg_20_1)
	local var_20_0 = arg_20_1.Dispatcher:GetFleetVO()

	if var_20_0 then
		var_20_0:UpdateFleetDamage(arg_20_1.Data.validDHP)
	end

	return
end

function BattleDuelArenaCommand:onUnitDying(arg_21_1)
	if arg_21_1.Dispatcher:GetUnitType() ~= var_0_0.Battle.BattleConst.UnitType.MINION_UNIT then
		self._dataProxy:CalcBattleScoreWhenDead(arg_21_1.Dispatcher)
	end

	self._dataProxy:KillUnit((arg_21_1.Dispatcher:GetUniqueID()))

	return
end

function BattleDuelArenaCommand:onShutDownPlayer(arg_22_1)
	arg_22_1.Dispatcher:GetFleetVO():UpdateFleetOverDamage(arg_22_1.Dispatcher)
	self._dataProxy:ShutdownPlayerUnit((arg_22_1.Dispatcher:GetUniqueID()))

	return
end

return

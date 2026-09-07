ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleUnitEvent
local var_0_2 = ys.Battle.BattleEvent
local BattleDebugCommand = class("BattleDebugCommand", ys.MVC.Command)

ys.Battle.BattleDebugCommand = BattleDebugCommand
BattleDebugCommand.__name = "BattleDebugCommand"

function BattleDebugCommand:Ctor()
	BattleDebugCommand.super.Ctor(self)

	return
end

function BattleDebugCommand:Initialize()
	self:Init()
	BattleDebugCommand.super.Initialize(self)

	self._dataProxy = self._state:GetProxyByName(var_0_0.Battle.BattleDataProxy.__name)
	self._uiMediator = self._state:GetMediatorByName(var_0_0.Battle.BattleUIMediator.__name)

	self:AddEvent()

	return
end

function BattleDebugCommand:DoPrologue()
	(function()
		self._uiMediator:OpeningEffect(function()
			self._uiMediator:ShowAutoBtn()
			self._uiMediator:ShowTimer()
			self._state:ChangeState(var_0_0.Battle.BattleState.BATTLE_STATE_FIGHT)

			return
		end, SYSTEM_DEBUG)
		self._dataProxy:InitAllFleetUnitsWeaponCD()
		self._dataProxy:TirggerBattleStartBuffs()

		return
	end)()

	return
end

function BattleDebugCommand:Init()
	self._unitDataList = {}

	return
end

function BattleDebugCommand:Clear()
	for iter_7_0, iter_7_1 in pairs(self._unitDataList) do
		self:UnregisterUnitEvent(iter_7_1)

		self._unitDataList[iter_7_0] = nil
	end

	return
end

function BattleDebugCommand:Reinitialize()
	self._state:Deactive()
	self:Clear()
	self:Init()

	return
end

function BattleDebugCommand:Dispose()
	var_0_0.Battle.BattleDataProxy.Update = var_0_0.Battle.BattleDebugConsole.ProxyUpdateNormal
	var_0_0.Battle.BattleDataProxy.UpdateAutoComponent = var_0_0.Battle.BattleDebugConsole.ProxyUpdateAutoComponentNormal

	self:Clear()
	self:RemoveEvent()
	BattleDebugCommand.super.Dispose(self)

	return
end

function BattleDebugCommand:AddEvent()
	self._dataProxy:RegisterEventListener(self, var_0_2.STAGE_DATA_INIT_FINISH, self.onInitBattle)
	self._dataProxy:RegisterEventListener(self, var_0_2.ADD_UNIT, self.onAddUnit)
	self._dataProxy:RegisterEventListener(self, var_0_2.REMOVE_UNIT, self.onRemoveUnit)
	self._dataProxy:RegisterEventListener(self, var_0_2.SHUT_DOWN_PLAYER, self.onPlayerShutDown)

	return
end

function BattleDebugCommand:RemoveEvent()
	self._dataProxy:UnregisterEventListener(self, var_0_2.STAGE_DATA_INIT_FINISH)
	self._dataProxy:UnregisterEventListener(self, var_0_2.ADD_UNIT)
	self._dataProxy:UnregisterEventListener(self, var_0_2.REMOVE_UNIT)
	self._dataProxy:UnregisterEventListener(self, var_0_2.SHUT_DOWN_PLAYER)

	return
end

function BattleDebugCommand:onInitBattle()
	self._userFleet = self._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)

	return
end

function BattleDebugCommand:onAddUnit(arg_13_1)
	self:RegisterUnitEvent(arg_13_1.Data.unit)

	self._unitDataList[arg_13_1.Data.unit:GetUniqueID()] = arg_13_1.Data.unit

	if arg_13_1.Data.type ~= var_0_0.Battle.BattleConst.UnitType.ENEMY_UNIT and arg_13_1.Data.type ~= var_0_0.Battle.BattleConst.UnitType.BOSS_UNIT and arg_13_1.Data.type ~= var_0_0.Battle.BattleConst.UnitType.MINION_UNIT and arg_13_1.Data.type ~= var_0_0.Battle.BattleConst.UnitType.NPC_UNIT and arg_13_1.Data.type == var_0_0.Battle.BattleConst.UnitType.BOSS_UNIT then
		-- block empty
	end

	return
end

function BattleDebugCommand:RegisterUnitEvent(arg_14_1)
	arg_14_1:RegisterEventListener(self, var_0_1.WILL_DIE, self.onWillDie)
	arg_14_1:RegisterEventListener(self, var_0_1.DYING, self.onUnitDying)

	if arg_14_1:GetUnitType() == var_0_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_14_1:RegisterEventListener(self, var_0_1.SHUT_DOWN_PLAYER, self.onShutDownPlayer)
	end

	return
end

function BattleDebugCommand:UnregisterUnitEvent(arg_15_1)
	arg_15_1:UnregisterEventListener(self, var_0_1.WILL_DIE)
	arg_15_1:UnregisterEventListener(self, var_0_1.DYING)

	if arg_15_1:GetUnitType() == var_0_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_15_1:UnregisterEventListener(self, var_0_1.SHUT_DOWN_PLAYER)
	end

	return
end

function BattleDebugCommand:onRemoveUnit(arg_16_1)
	if self._unitDataList[arg_16_1.Data.UID] == nil then
		return
	end

	self:UnregisterUnitEvent(self._unitDataList[arg_16_1.Data.UID])

	self._unitDataList[arg_16_1.Data.UID] = nil

	return
end

function BattleDebugCommand:onPlayerShutDown(arg_17_1)
	if arg_17_1.Data.unit == self._userFleet:GetMainList() == 0 then
		self._dataProxy:KillAllAirStrike()
		self._dataProxy:KillAllEnemy()
		self._dataProxy:CLSBullet(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)
		self._dataProxy:CLSBullet(var_0_0.Battle.BattleConfig.FOE_CODE)

		for iter_17_0, iter_17_1 in ipairs(self._dataProxy:GetInitData().MainUnitList) do
			self._dataProxy:SpawnMain(iter_17_1, var_0_0.Battle.BattleConfig.FRIENDLY_CODE)
		end
	end

	if #self._userFleet:GetScoutList() == 0 then
		self._dataProxy:KillAllAirStrike()
		self._dataProxy:KillAllEnemy()
		self._dataProxy:CLSBullet(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)
		self._dataProxy:CLSBullet(var_0_0.Battle.BattleConfig.FOE_CODE)

		for iter_17_2, iter_17_3 in ipairs(self._dataProxy:GetInitData().VanguardUnitList) do
			self._dataProxy:SpawnVanguard(iter_17_3, var_0_0.Battle.BattleConfig.FRIENDLY_CODE)
		end
	end

	return
end

function BattleDebugCommand:onUnitDying(arg_18_1)
	self._dataProxy:KillUnit((arg_18_1.Dispatcher:GetUniqueID()))

	return
end

function BattleDebugCommand:onWillDie(arg_19_1)
	self._dataProxy:CalcBattleScoreWhenDead(arg_19_1.Dispatcher)

	if arg_19_1.Dispatcher:IsBoss() and not self._dataProxy:IsThereBoss() then
		self._dataProxy:KillAllEnemy()
	end

	return
end

function BattleDebugCommand:onShutDownPlayer(arg_20_1)
	self._dataProxy:ShutdownPlayerUnit((arg_20_1.Dispatcher:GetUniqueID()))

	return
end

return

ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleUnitEvent
local var_0_2 = ys.Battle.BattleEvent
local BattleCardPuzzleCommand = class("BattleCardPuzzleCommand", ys.MVC.Command)

ys.Battle.BattleCardPuzzleCommand = BattleCardPuzzleCommand
BattleCardPuzzleCommand.__name = "BattleCardPuzzleCommand"

function BattleCardPuzzleCommand:Ctor()
	BattleCardPuzzleCommand.super.Ctor(self)

	return
end

function BattleCardPuzzleCommand:Initialize()
	self:Init()
	BattleCardPuzzleCommand.super.Initialize(self)

	self._dataProxy = self._state:GetProxyByName(var_0_0.Battle.BattleDataProxy.__name)
	self._uiMediator = self._state:GetMediatorByName(var_0_0.Battle.BattleUIMediator.__name)

	self:AddEvent()

	return
end

function BattleCardPuzzleCommand:DoPrologue()
	pg.UIMgr.GetInstance():Marching()
	self._uiMediator:SeaSurfaceShift(45, 0, nil, function()
		self._uiMediator:OpeningEffect(function()
			self._dataProxy:SetupCalculateDamage(var_0_0.Battle.BattleCardPuzzleFormulas.CreateContextCalculateDamage)
			self._state:ChangeState(var_0_0.Battle.BattleState.BATTLE_STATE_FIGHT)
			self._waveUpdater:Start()

			return
		end, SYSTEM_CARDPUZZLE)
		self._dataProxy:InitAllFleetUnitsWeaponCD()
		self._dataProxy:TirggerBattleStartBuffs()
		self._dataProxy:StartCardPuzzle()

		self._joystickBot = var_0_0.Battle.CardPuzzleJoyStickAutoBot.New(self._dataProxy, (self._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)))

		self._joystickBot:SetActive(true)
		self._state:EnableJoystick(false)

		return
	end)

	return
end

function BattleCardPuzzleCommand:Init()
	self._unitDataList = {}

	self:initWaveModule()

	return
end

function BattleCardPuzzleCommand:initWaveModule()
	self._waveUpdater = var_0_0.Battle.BattleWaveUpdater.New(function(arg_8_0, arg_8_1, arg_8_2)
		self._dataProxy:SpawnMonster(arg_8_0, arg_8_1, arg_8_2, var_0_0.Battle.BattleConfig.FOE_CODE)

		return
	end, function(arg_9_0)
		self._dataProxy:SpawnAirFighter(arg_9_0)

		return
	end, function()
		if self._vertifyFail then
			pg.m02:sendNotification(GAME.CHEATER_MARK, {
				reason = self._vertifyFail
			})

			return
		end

		self:CalcStatistic()
		self._state:BattleEnd()

		return
	end, function(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
		self._dataProxy:SpawnCubeArea(var_0_0.Battle.BattleConst.AOEField.SURFACE, -1, arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)

		return
	end)

	return
end

function BattleCardPuzzleCommand:Clear()
	for iter_12_0, iter_12_1 in pairs(self._unitDataList) do
		self:UnregisterUnitEvent(iter_12_1)

		self._unitDataList[iter_12_0] = nil
	end

	self._waveUpdater:Clear()

	return
end

function BattleCardPuzzleCommand:Reinitialize()
	self._state:Deactive()
	self:Clear()
	self:Init()

	return
end

function BattleCardPuzzleCommand:Dispose()
	var_0_0.Battle.BattleDataProxy.Update = var_0_0.Battle.BattleDebugConsole.ProxyUpdateNormal
	var_0_0.Battle.BattleDataProxy.UpdateAutoComponent = var_0_0.Battle.BattleDebugConsole.ProxyUpdateAutoComponentNormal

	self._joystickBot:Dispose()
	self:Clear()
	self:RemoveEvent()
	BattleCardPuzzleCommand.super.Dispose(self)

	return
end

function BattleCardPuzzleCommand:AddEvent()
	self._dataProxy:RegisterEventListener(self, var_0_2.STAGE_DATA_INIT_FINISH, self.onInitBattle)
	self._dataProxy:RegisterEventListener(self, var_0_2.ADD_UNIT, self.onAddUnit)
	self._dataProxy:RegisterEventListener(self, var_0_2.REMOVE_UNIT, self.onRemoveUnit)
	self._dataProxy:RegisterEventListener(self, var_0_2.SHUT_DOWN_PLAYER, self.onPlayerShutDown)

	return
end

function BattleCardPuzzleCommand:RemoveEvent()
	self._dataProxy:UnregisterEventListener(self, var_0_2.STAGE_DATA_INIT_FINISH)
	self._dataProxy:UnregisterEventListener(self, var_0_2.ADD_UNIT)
	self._dataProxy:UnregisterEventListener(self, var_0_2.REMOVE_UNIT)
	self._dataProxy:UnregisterEventListener(self, var_0_2.SHUT_DOWN_PLAYER)

	return
end

function BattleCardPuzzleCommand:onInitBattle()
	self._userFleet = self._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)

	self._waveUpdater:SetWavesData(self._dataProxy:GetStageInfo())

	return
end

function BattleCardPuzzleCommand:onAddUnit(arg_18_1)
	self:RegisterUnitEvent(arg_18_1.Data.unit)

	self._unitDataList[arg_18_1.Data.unit:GetUniqueID()] = arg_18_1.Data.unit

	if arg_18_1.Data.type == var_0_0.Battle.BattleConst.UnitType.ENEMY_UNIT or arg_18_1.Data.type == var_0_0.Battle.BattleConst.UnitType.BOSS_UNIT then
		self._waveUpdater:AddMonster(arg_18_1.Data.unit)
	end

	return
end

function BattleCardPuzzleCommand:RegisterUnitEvent(arg_19_1)
	arg_19_1:RegisterEventListener(self, var_0_1.WILL_DIE, self.onWillDie)
	arg_19_1:RegisterEventListener(self, var_0_1.DYING, self.onUnitDying)

	if arg_19_1:GetUnitType() == var_0_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_19_1:RegisterEventListener(self, var_0_1.SHUT_DOWN_PLAYER, self.onShutDownPlayer)
	end

	return
end

function BattleCardPuzzleCommand:UnregisterUnitEvent(arg_20_1)
	arg_20_1:UnregisterEventListener(self, var_0_1.WILL_DIE)
	arg_20_1:UnregisterEventListener(self, var_0_1.DYING)

	if arg_20_1:GetUnitType() == var_0_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_20_1:UnregisterEventListener(self, var_0_1.SHUT_DOWN_PLAYER)
	end

	return
end

function BattleCardPuzzleCommand:onRemoveUnit(arg_21_1)
	self._waveUpdater:RemoveMonster(arg_21_1.Data.UID)

	if self._unitDataList[arg_21_1.Data.UID] == nil then
		return
	end

	self:UnregisterUnitEvent(self._unitDataList[arg_21_1.Data.UID])

	self._unitDataList[arg_21_1.Data.UID] = nil

	return
end

function BattleCardPuzzleCommand:onPlayerShutDown(arg_22_1)
	self:CalcStatistic()
	self._state:BattleEnd()

	return
end

function BattleCardPuzzleCommand:onUnitDying(arg_23_1)
	self._dataProxy:KillUnit((arg_23_1.Dispatcher:GetUniqueID()))

	return
end

function BattleCardPuzzleCommand:onWillDie(arg_24_1)
	self._dataProxy:CalcBattleScoreWhenDead(arg_24_1.Dispatcher)

	if arg_24_1.Dispatcher:IsBoss() and not self._dataProxy:IsThereBoss() then
		self._dataProxy:KillAllEnemy()
	end

	return
end

function BattleCardPuzzleCommand:onShutDownPlayer(arg_25_1)
	self._dataProxy:ShutdownPlayerUnit((arg_25_1.Dispatcher:GetUniqueID()))

	return
end

function BattleCardPuzzleCommand:CalcStatistic()
	self._dataProxy:CalcCardPuzzleScoreAtEnd(self._userFleet)

	return
end

return

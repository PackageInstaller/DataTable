ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleUnitEvent
local var_0_2 = ys.Battle.BattleEvent
local BattleSingleDungeonCommand = class("BattleSingleDungeonCommand", ys.MVC.Command)

ys.Battle.BattleSingleDungeonCommand = BattleSingleDungeonCommand
BattleSingleDungeonCommand.__name = "BattleSingleDungeonCommand"

function BattleSingleDungeonCommand:Ctor()
	BattleSingleDungeonCommand.super.Ctor(self)

	return
end

function BattleSingleDungeonCommand:Initialize()
	BattleSingleDungeonCommand.super.Initialize(self)

	self._dataProxy = self._state:GetProxyByName(var_0_0.Battle.BattleDataProxy.__name)
	self._uiMediator = self._state:GetUIMediator()

	self:Init()
	self:InitProtocol()
	self:AddEvent()

	self._count = 0

	return
end

function BattleSingleDungeonCommand:DoPrologue()
	pg.UIMgr.GetInstance():Marching()
	self._uiMediator:SeaSurfaceShift(45, 0, nil, function()
		self._uiMediator:OpeningEffect(function()
			self._uiMediator:ShowAutoBtn()
			self._uiMediator:ShowTimer()
			self._state:GetCommandByName(var_0_0.Battle.BattleControllerWeaponCommand.__name):TryAutoSub()
			self._state:ChangeState(var_0_0.Battle.BattleState.BATTLE_STATE_FIGHT)
			self._waveUpdater:Start()

			if self._dataProxy:GetInitData().hideAllButtons then
				self._dataProxy:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleEvent.HIDE_INTERACTABLE_BUTTONS, {
					isActive = false
				}))
			end

			return
		end)
		self._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FRIENDLY_CODE):FleetWarcry()
		self._dataProxy:InitAllFleetUnitsWeaponCD()
		self._dataProxy:TirggerBattleStartBuffs()
		self._dataProxy:ChapterSupportBarrage(var_0_0.Battle.BattleConfig.FRIENDLY_CODE, var_0_0.Battle.BattleConfig.SubSupportDelay)

		return
	end)

	return
end

function BattleSingleDungeonCommand:Init()
	self._unitDataList = {}

	self:initWaveModule()

	return
end

function BattleSingleDungeonCommand:Clear()
	for iter_7_0, iter_7_1 in pairs(self._unitDataList) do
		self:UnregisterUnitEvent(iter_7_1)

		self._unitDataList[iter_7_0] = nil
	end

	self._waveUpdater:Clear()

	return
end

function BattleSingleDungeonCommand:Reinitialize()
	self._state:Deactive()
	self:Clear()
	self:Init()

	return
end

function BattleSingleDungeonCommand:Dispose()
	self:Clear()
	self:RemoveEvent()
	BattleSingleDungeonCommand.super.Dispose(self)

	return
end

function BattleSingleDungeonCommand:SetVertifyFail(arg_10_1)
	self._vertifyFail = self._vertifyFail or arg_10_1

	return
end

function BattleSingleDungeonCommand:onInitBattle()
	self._userFleet = self._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)

	self._waveUpdater:SetWavesData(self._dataProxy:GetStageInfo())

	return
end

function BattleSingleDungeonCommand:initWaveModule()
	self._waveUpdater = var_0_0.Battle.BattleWaveUpdater.New(function(arg_13_0, arg_13_1, arg_13_2)
		self._dataProxy:SpawnMonster(arg_13_0, arg_13_1, arg_13_2, var_0_0.Battle.BattleConfig.FOE_CODE)

		return
	end, function(arg_14_0)
		self._dataProxy:SpawnAirFighter(arg_14_0)

		return
	end, function()
		if self._vertifyFail then
			pg.m02:sendNotification(GAME.CHEATER_MARK, {
				reason = self._vertifyFail
			})

			return
		end

		self._dataProxy:TriggerFinishBattle()
		self:CalcStatistic()
		self._state:BattleEnd()

		return
	end, function(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
		self._dataProxy:SpawnCubeArea(var_0_0.Battle.BattleConst.AOEField.SURFACE, -1, arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)

		return
	end)

	return
end

function BattleSingleDungeonCommand:InitProtocol()
	return
end

function BattleSingleDungeonCommand:AddEvent()
	self._dataProxy:RegisterEventListener(self, var_0_2.ADD_UNIT, self.onAddUnit)
	self._dataProxy:RegisterEventListener(self, var_0_2.REMOVE_UNIT, self.onRemoveUnit)
	self._dataProxy:RegisterEventListener(self, var_0_2.STAGE_DATA_INIT_FINISH, self.onInitBattle)
	self._dataProxy:RegisterEventListener(self, var_0_2.SHUT_DOWN_PLAYER, self.onPlayerShutDown)
	self._dataProxy:RegisterEventListener(self, var_0_2.UPDATE_COUNT_DOWN, self.onUpdateCountDown)

	return
end

function BattleSingleDungeonCommand:RemoveEvent()
	self._dataProxy:UnregisterEventListener(self, var_0_2.ADD_UNIT)
	self._dataProxy:UnregisterEventListener(self, var_0_2.REMOVE_UNIT)
	self._dataProxy:UnregisterEventListener(self, var_0_2.STAGE_DATA_INIT_FINISH)
	self._dataProxy:UnregisterEventListener(self, var_0_2.SHUT_DOWN_PLAYER)
	self._dataProxy:UnregisterEventListener(self, var_0_2.UPDATE_COUNT_DOWN)

	return
end

function BattleSingleDungeonCommand:onAddUnit(arg_20_1)
	self:RegisterUnitEvent(arg_20_1.Data.unit)

	self._unitDataList[arg_20_1.Data.unit:GetUniqueID()] = arg_20_1.Data.unit

	if arg_20_1.Data.type == var_0_0.Battle.BattleConst.UnitType.ENEMY_UNIT or arg_20_1.Data.type == var_0_0.Battle.BattleConst.UnitType.BOSS_UNIT then
		self._waveUpdater:AddMonster(arg_20_1.Data.unit)
	end

	return
end

function BattleSingleDungeonCommand:RegisterUnitEvent(arg_21_1)
	local var_21_0 = arg_21_1:GetUnitType()

	if var_21_0 ~= var_0_0.Battle.BattleConst.UnitType.MINION_UNIT then
		arg_21_1:RegisterEventListener(self, var_0_1.WILL_DIE, self.onWillDie)
	end

	arg_21_1:RegisterEventListener(self, var_0_1.DYING, self.onUnitDying)

	if var_21_0 == var_0_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_21_1:RegisterEventListener(self, var_0_1.SHUT_DOWN_PLAYER, self.onShutDownPlayer)
	end

	return
end

function BattleSingleDungeonCommand:UnregisterUnitEvent(arg_22_1)
	arg_22_1:UnregisterEventListener(self, var_0_1.WILL_DIE)
	arg_22_1:UnregisterEventListener(self, var_0_1.DYING)

	if arg_22_1:GetUnitType() == var_0_0.Battle.BattleConst.UnitType.PLAYER_UNIT then
		arg_22_1:UnregisterEventListener(self, var_0_1.SHUT_DOWN_PLAYER)
	end

	return
end

function BattleSingleDungeonCommand:onRemoveUnit(arg_23_1)
	self._waveUpdater:RemoveMonster(arg_23_1.Data.UID)

	if self._unitDataList[arg_23_1.Data.UID] == nil then
		return
	end

	self:UnregisterUnitEvent(self._unitDataList[arg_23_1.Data.UID])

	self._unitDataList[arg_23_1.Data.UID] = nil

	return
end

function BattleSingleDungeonCommand:onPlayerShutDown(arg_24_1)
	if self._state:GetState() ~= self._state.BATTLE_STATE_FIGHT then
		return
	end

	if arg_24_1.Data.unit == self._userFleet:GetFlagShip() and self._dataProxy:GetInitData().battleType ~= SYSTEM_PROLOGUE and self._dataProxy:GetInitData().battleType ~= SYSTEM_PERFORM then
		self._dataProxy:TriggerFinishBattle()
		self:CalcStatistic()
		self._state:BattleEnd()

		return
	end

	if #self._userFleet:GetScoutList() == 0 then
		self._dataProxy:TriggerFinishBattle()
		self:CalcStatistic()
		self._state:BattleEnd()
	end

	return
end

function BattleSingleDungeonCommand:onUpdateCountDown(arg_25_1)
	if self._dataProxy:GetCountDown() <= 0 then
		self._dataProxy:EnemyEscape()
		self:CalcStatistic()
		self._state:BattleTimeUp()
	end

	return
end

function BattleSingleDungeonCommand:onUnitDying(arg_26_1)
	self._dataProxy:KillUnit((arg_26_1.Dispatcher:GetUniqueID()))

	return
end

function BattleSingleDungeonCommand:onWillDie(arg_27_1)
	local var_27_0 = arg_27_1.Dispatcher:GetDeathReason()

	if var_27_0 == var_0_0.Battle.BattleConst.UnitDeathReason.LEAVE then
		if arg_27_1.Dispatcher:GetIFF() == var_0_0.Battle.BattleConfig.FRIENDLY_CODE then
			self._dataProxy:CalcBPWhenPlayerLeave(arg_27_1.Dispatcher)
		end
	elseif var_27_0 == var_0_0.Battle.BattleConst.UnitDeathReason.DESTRUCT then
		self._dataProxy:CalcBattleScoreWhenDead(arg_27_1.Dispatcher)

		if arg_27_1.Dispatcher:IsBoss() then
			self._dataProxy:AddScoreWhenBossDestruct()
		end
	else
		self._dataProxy:CalcBattleScoreWhenDead(arg_27_1.Dispatcher)
	end

	if arg_27_1.Dispatcher:IsBoss() and not self._dataProxy:IsThereBoss() then
		self._dataProxy:KillAllEnemy()
	end

	return
end

function BattleSingleDungeonCommand:onShutDownPlayer(arg_28_1)
	self._dataProxy:ShutdownPlayerUnit((arg_28_1.Dispatcher:GetUniqueID()))

	return
end

function BattleSingleDungeonCommand:GetMaxRestHPRateBossRate()
	for iter_29_0, iter_29_1 in ipairs((self._waveUpdater:GetAllBossWave())) do
		if iter_29_1:GetState() == iter_29_1.STATE_DEACTIVE then
			return 10000
		end
	end

	local var_29_0 = 0

	for iter_29_2, iter_29_3 in pairs(self._dataProxy:GetUnitList()) do
		if iter_29_3:IsBoss() and iter_29_3:IsAlive() then
			var_29_0 = math.max(var_29_0, iter_29_3:GetHPRate())
		end
	end

	return var_29_0 * 16
end

function BattleSingleDungeonCommand:CalcStatistic()
	self._dataProxy:CalcSingleDungeonScoreAtEnd(self._userFleet)
	self._dataProxy:CalcMaxRestHPRateBossRate((self:GetMaxRestHPRateBossRate()))

	return
end

return

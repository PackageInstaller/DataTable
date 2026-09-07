ys = ys or {}

local var_0_0 = ys
local BattleWorldBossCommand = class("BattleWorldBossCommand", ys.Battle.BattleSingleDungeonCommand)

ys.Battle.BattleWorldBossCommand = BattleWorldBossCommand
BattleWorldBossCommand.__name = "BattleWorldBossCommand"

function BattleWorldBossCommand:Ctor()
	BattleWorldBossCommand.super.Ctor(self)

	return
end

function BattleWorldBossCommand:initWaveModule()
	self._waveUpdater = var_0_0.Battle.BattleWaveUpdater.New(function(arg_3_0, arg_3_1, arg_3_2)
		self._dataProxy:SpawnMonster(arg_3_0, arg_3_1, arg_3_2, var_0_0.Battle.BattleConfig.FOE_CODE)

		return
	end, function(arg_4_0)
		self._dataProxy:SpawnAirFighter(arg_4_0)

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
		self:calcDamageData()
		self._state:BattleEnd()

		return
	end, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		self._dataProxy:SpawnCubeArea(var_0_0.Battle.BattleConst.AOEField.SURFACE, -1, arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)

		return
	end)

	return
end

function BattleWorldBossCommand:onInitBattle()
	BattleWorldBossCommand.super.onInitBattle(self)

	local var_7_0 = self._dataProxy:GetInitData()

	self._specificEnemyList = var_0_0.Battle.BattleDataFunction.GetSpecificWorldJointEnemyList(var_7_0.ActID, var_7_0.bossConfigId, var_7_0.bossLevel)

	return
end

function BattleWorldBossCommand:onAddUnit(arg_8_1)
	BattleWorldBossCommand.super.onAddUnit(self, arg_8_1)

	if table.contains(self._specificEnemyList, arg_8_1.Data.unit:GetTemplateID()) then
		self._dataProxy:InitSpecificEnemyStatistics(arg_8_1.Data.unit)
	end

	return
end

function BattleWorldBossCommand:onPlayerShutDown(arg_9_1)
	if self._state:GetState() ~= self._state.BATTLE_STATE_FIGHT then
		return
	end

	if arg_9_1.Data.unit == self._userFleet:GetFlagShip() and self._dataProxy:GetInitData().battleType ~= SYSTEM_PROLOGUE and self._dataProxy:GetInitData().battleType ~= SYSTEM_PERFORM then
		self._dataProxy:TriggerFinishBattle()
		self:CalcStatistic()
		self:calcDamageData()
		self._state:BattleEnd()

		return
	end

	if #self._userFleet:GetScoutList() == 0 then
		self._dataProxy:TriggerFinishBattle()
		self:CalcStatistic()
		self:calcDamageData()
		self._state:BattleEnd()
	end

	return
end

function BattleWorldBossCommand:onUpdateCountDown(arg_10_1)
	if self._dataProxy:GetCountDown() <= 0 then
		self._dataProxy:EnemyEscape()
		self:CalcStatistic()
		self:calcDamageData()
		self._state:BattleTimeUp()
	end

	return
end

function BattleWorldBossCommand:calcDamageData()
	local var_11_0 = self._dataProxy:GetInitData()

	self._dataProxy:CalcWorldBossDamageInfo(var_11_0.ActID, var_11_0.bossConfigId, var_11_0.bossLevel)

	return
end

return

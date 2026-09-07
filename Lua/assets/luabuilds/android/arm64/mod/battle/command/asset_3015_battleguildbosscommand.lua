ys = ys or {}

local var_0_0 = ys
local BattleGuildBossCommand = class("BattleGuildBossCommand", ys.Battle.BattleSingleDungeonCommand)

ys.Battle.BattleGuildBossCommand = BattleGuildBossCommand
BattleGuildBossCommand.__name = "BattleGuildBossCommand"

function BattleGuildBossCommand:Ctor()
	BattleGuildBossCommand.super.Ctor(self)

	return
end

function BattleGuildBossCommand:initWaveModule()
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

function BattleGuildBossCommand:onInitBattle()
	BattleGuildBossCommand.super.onInitBattle(self)

	local var_7_0 = self._dataProxy:GetInitData()

	self._specificEnemyList = var_0_0.Battle.BattleDataFunction.GetSpecificGuildBossEnemyList(var_7_0.ActID, var_7_0.StageTmpId)

	return
end

function BattleGuildBossCommand:onAddUnit(arg_8_1)
	BattleGuildBossCommand.super.onAddUnit(self, arg_8_1)

	if table.contains(self._specificEnemyList, arg_8_1.Data.unit:GetTemplateID()) then
		self._dataProxy:InitSpecificEnemyStatistics(arg_8_1.Data.unit)
	end

	return
end

function BattleGuildBossCommand:onPlayerShutDown(arg_9_1)
	if self._state:GetState() ~= self._state.BATTLE_STATE_FIGHT then
		return
	end

	if arg_9_1.Data.unit == self._userFleet:GetFlagShip() and self._dataProxy:GetInitData().battleType ~= SYSTEM_PROLOGUE and self._dataProxy:GetInitData().battleType ~= SYSTEM_PERFORM then
		self:CalcStatistic()
		self:calcDamageData()
		self._state:BattleEnd()

		return
	end

	if #self._userFleet:GetScoutList() == 0 then
		self:CalcStatistic()
		self:calcDamageData()
		self._state:BattleEnd()
	end

	return
end

function BattleGuildBossCommand:onUpdateCountDown(arg_10_1)
	if self._dataProxy:GetCountDown() <= 0 then
		self._dataProxy:EnemyEscape()
		self:CalcStatistic()
		self:calcDamageData()
		self._state:BattleTimeUp()
	end

	return
end

function BattleGuildBossCommand:calcDamageData()
	self._dataProxy:CalcGuildBossEnemyInfo(self._dataProxy:GetInitData().ActID)

	return
end

return

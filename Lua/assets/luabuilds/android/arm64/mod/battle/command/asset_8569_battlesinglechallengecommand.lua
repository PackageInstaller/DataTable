ys = ys or {}

local var_0_0 = ys
local BattleSingleChallengeCommand = class("BattleSingleChallengeCommand", ys.Battle.BattleSingleDungeonCommand)

ys.Battle.BattleSingleChallengeCommand = BattleSingleChallengeCommand
BattleSingleChallengeCommand.__name = "BattleSingleChallengeCommand"

function BattleSingleChallengeCommand:Ctor()
	BattleSingleChallengeCommand.super.Ctor(self)

	self._challengeConst = var_0_0.Battle.BattleConfig.CHALLENGE_ENHANCE

	return
end

function BattleSingleChallengeCommand:onInitBattle()
	BattleSingleChallengeCommand.super.onInitBattle(self)

	self._enhancemntP = math.max(self._dataProxy:GetInitData().ChallengeInfo:getRound() - self._challengeConst.K, 0)
	self._enhancemntPPercent = self._enhancemntP * 0.01

	self._dataProxy:SetDungeonLevel(self._dataProxy:GetDungeonLevel() + self._challengeConst.A * self._enhancemntP)

	self._enahanceDURAttr = self._challengeConst.X1 * self._enhancemntPPercent
	self._enahanceATKAttr = self._challengeConst.X2 * self._enhancemntPPercent
	self._enahanceEVDAttr = self._challengeConst.Y1 * self._enhancemntP
	self._enahanceLUKAttr = self._challengeConst.Y2 * self._enhancemntP

	return
end

function BattleSingleChallengeCommand:initWaveModule()
	self._waveUpdater = var_0_0.Battle.BattleWaveUpdater.New(function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = self._dataProxy:SpawnMonster(arg_4_0, arg_4_1, arg_4_2, var_0_0.Battle.BattleConfig.FOE_CODE, function(arg_5_0)
			self:monsterEnhance(arg_5_0)

			return
		end)

		return
	end, function(arg_6_0)
		self._dataProxy:SpawnAirFighter(arg_6_0)

		return
	end, function()
		if self._vertifyFail then
			pg.m02:sendNotification(GAME.CHEATER_MARK, {
				reason = self._vertifyFail
			})

			return
		end

		self._dataProxy:TriggerFinishBattle()
		self._dataProxy:CalcChallengeScore(true)
		self._state:BattleEnd()

		return
	end, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		self._dataProxy:SpawnCubeArea(var_0_0.Battle.BattleConst.AOEField.SURFACE, -1, arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)

		return
	end)

	return
end

function BattleSingleChallengeCommand:DoPrologue()
	pg.UIMgr.GetInstance():Marching()
	self._uiMediator:SeaSurfaceShift(45, 0, nil, function()
		self._uiMediator:OpeningEffect(function()
			local var_11_0 = getProxy(PlayerProxy)

			self._uiMediator:ShowAutoBtn()
			self._state:ChangeState(var_0_0.Battle.BattleState.BATTLE_STATE_FIGHT)
			self._uiMediator:ShowTimer()
			self._state:GetCommandByName(var_0_0.Battle.BattleControllerWeaponCommand.__name):TryAutoSub()
			self._waveUpdater:Start()

			return
		end)
		self._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FRIENDLY_CODE):FleetWarcry()
		self._dataProxy:InitAllFleetUnitsWeaponCD()
		self._dataProxy:TirggerBattleStartBuffs()

		self._challengeStartTime = pg.TimeMgr.GetInstance():GetCombatTime()

		return
	end)

	return
end

function BattleSingleChallengeCommand:onPlayerShutDown(arg_12_1)
	if self._state:GetState() ~= self._state.BATTLE_STATE_FIGHT then
		return
	end

	if arg_12_1.Data.unit == self._userFleet:GetFlagShip() then
		self._dataProxy:TriggerFinishBattle()
		self._dataProxy:CalcChallengeScore(false)
		self._state:BattleEnd()

		return
	end

	if #self._userFleet:GetScoutList() == 0 then
		self._dataProxy:TriggerFinishBattle()
		self._dataProxy:CalcChallengeScore(false)
		self._state:BattleEnd()
	end

	return
end

function BattleSingleChallengeCommand:onUpdateCountDown(arg_13_1)
	if self._dataProxy:GetCountDown() <= 0 then
		self._dataProxy:TriggerFinishBattle()
		self._dataProxy:CalcChallengeScore(false)
		self._state:BattleEnd()
	end

	return
end

function BattleSingleChallengeCommand:monsterEnhance(arg_14_1)
	var_0_0.Battle.BattleAttr.FlashByBuff(arg_14_1, "maxHP", self._enahanceDURAttr)
	var_0_0.Battle.BattleAttr.FlashByBuff(arg_14_1, "cannonPower", self._enahanceATKAttr)
	var_0_0.Battle.BattleAttr.FlashByBuff(arg_14_1, "torpedoPower", self._enahanceATKAttr)
	var_0_0.Battle.BattleAttr.FlashByBuff(arg_14_1, "airPower", self._enahanceATKAttr)
	var_0_0.Battle.BattleAttr.FlashByBuff(arg_14_1, "dodgeRate", self._enahanceEVDAttr)
	var_0_0.Battle.BattleAttr.FlashByBuff(arg_14_1, "luck", self._enahanceLUKAttr)

	return
end

return

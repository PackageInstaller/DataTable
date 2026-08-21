ys = ys or {}

local var_0_3 = class("BattleSingleChallengeCommand", ys.Battle.BattleSingleDungeonCommand)

ys.Battle.BattleSingleChallengeCommand = var_0_3
var_0_3.__name = "BattleSingleChallengeCommand"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	arg_1_0._challengeConst = var_0.Battle.BattleConfig.CHALLENGE_ENHANCE

	return
end

function var_0_3.onInitBattle(arg_2_0)
	var_0_3.super.onInitBattle(arg_2_0)

	arg_2_0._enhancemntP = math.max(arg_2_0._dataProxy:GetInitData().ChallengeInfo:getRound() - arg_2_0._challengeConst.K, 0)
	arg_2_0._enhancemntPPercent = arg_2_0._enhancemntP * 0.01

	arg_2_0._dataProxy:SetDungeonLevel(arg_2_0._dataProxy:GetDungeonLevel() + arg_2_0._challengeConst.A * arg_2_0._enhancemntP)

	arg_2_0._enahanceDURAttr = arg_2_0._challengeConst.X1 * arg_2_0._enhancemntPPercent
	arg_2_0._enahanceATKAttr = arg_2_0._challengeConst.X2 * arg_2_0._enhancemntPPercent
	arg_2_0._enahanceEVDAttr = arg_2_0._challengeConst.Y1 * arg_2_0._enhancemntP
	arg_2_0._enahanceLUKAttr = arg_2_0._challengeConst.Y2 * arg_2_0._enhancemntP

	return
end

function var_0_3.initWaveModule(arg_3_0)
	arg_3_0._waveUpdater = var_0.Battle.BattleWaveUpdater.New(function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_3_0._dataProxy:SpawnMonster(arg_4_0, arg_4_1, arg_4_2, var_0.Battle.BattleConfig.FOE_CODE, function(arg_5_0)
			arg_3_0:monsterEnhance(arg_5_0)

			return
		end)

		return
	end, function(arg_6_0)
		arg_3_0._dataProxy:SpawnAirFighter(arg_6_0)

		return
	end, function()
		if arg_3_0._vertifyFail then
			pg.m02:sendNotification(GAME.CHEATER_MARK, {
				reason = arg_3_0._vertifyFail
			})

			return
		end

		arg_3_0._dataProxy:TriggerFinishBattle()
		arg_3_0._dataProxy:CalcChallengeScore(true)
		arg_3_0._state:BattleEnd()

		return
	end, function(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		arg_3_0._dataProxy:SpawnCubeArea(var_0.Battle.BattleConst.AOEField.SURFACE, -1, arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)

		return
	end)

	return
end

function var_0_3.DoPrologue(arg_9_0)
	pg.UIMgr.GetInstance():Marching()
	arg_9_0._uiMediator:SeaSurfaceShift(45, 0, nil, function()
		arg_9_0._uiMediator:OpeningEffect(function()
			local var_11_0 = getProxy(PlayerProxy)

			arg_9_0._uiMediator:ShowAutoBtn()
			arg_9_0._state:ChangeState(var_0.Battle.BattleState.BATTLE_STATE_FIGHT)
			arg_9_0._uiMediator:ShowTimer()
			arg_9_0._state:GetCommandByName(var_0.Battle.BattleControllerWeaponCommand.__name):TryAutoSub()
			arg_9_0._waveUpdater:Start()

			return
		end)
		arg_9_0._dataProxy:GetFleetByIFF(var_0.Battle.BattleConfig.FRIENDLY_CODE):FleetWarcry()
		arg_9_0._dataProxy:InitAllFleetUnitsWeaponCD()
		arg_9_0._dataProxy:TirggerBattleStartBuffs()

		arg_9_0._challengeStartTime = pg.TimeMgr.GetInstance():GetCombatTime()

		return
	end)

	return
end

function var_0_3.onPlayerShutDown(arg_12_0, arg_12_1)
	if arg_12_0._state:GetState() ~= arg_12_0._state.BATTLE_STATE_FIGHT then
		return
	end

	if arg_12_1.Data.unit == arg_12_0._userFleet:GetFlagShip() then
		arg_12_0._dataProxy:TriggerFinishBattle()
		arg_12_0._dataProxy:CalcChallengeScore(false)
		arg_12_0._state:BattleEnd()

		return
	end

	if #arg_12_0._userFleet:GetScoutList() == 0 then
		arg_12_0._dataProxy:TriggerFinishBattle()
		arg_12_0._dataProxy:CalcChallengeScore(false)
		arg_12_0._state:BattleEnd()
	end

	return
end

function var_0_3.onUpdateCountDown(arg_13_0, arg_13_1)
	if arg_13_0._dataProxy:GetCountDown() <= 0 then
		arg_13_0._dataProxy:TriggerFinishBattle()
		arg_13_0._dataProxy:CalcChallengeScore(false)
		arg_13_0._state:BattleEnd()
	end

	return
end

function var_0_3.monsterEnhance(arg_14_0, arg_14_1)
	var_0.Battle.BattleAttr.FlashByBuff(arg_14_1, "maxHP", arg_14_0._enahanceDURAttr)
	var_0.Battle.BattleAttr.FlashByBuff(arg_14_1, "cannonPower", arg_14_0._enahanceATKAttr)
	var_0.Battle.BattleAttr.FlashByBuff(arg_14_1, "torpedoPower", arg_14_0._enahanceATKAttr)
	var_0.Battle.BattleAttr.FlashByBuff(arg_14_1, "airPower", arg_14_0._enahanceATKAttr)
	var_0.Battle.BattleAttr.FlashByBuff(arg_14_1, "dodgeRate", arg_14_0._enahanceEVDAttr)
	var_0.Battle.BattleAttr.FlashByBuff(arg_14_1, "luck", arg_14_0._enahanceLUKAttr)

	return
end

return

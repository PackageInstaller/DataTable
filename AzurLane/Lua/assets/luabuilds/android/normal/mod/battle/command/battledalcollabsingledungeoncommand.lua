ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleEvent

class = var_0_10003

local var_0_3 = var_0_10003("BattleDALCollabSingleDungeonCommand", var_0.Battle.BattleSingleDungeonCommand)

var_0.Battle.BattleDALCollabSingleDungeonCommand = var_0_3
var_0_3.__name = "BattleDALCollabSingleDungeonCommand"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.DoPrologue(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.Marching(var_2_0)

	local function var_2_1()
		local var_3_0 = arg_2_0._uiMediator

		var_0.OpeningEffect(var_3_0, function()
			local var_4_0 = arg_2_0._uiMediator

			var_0.ShowAutoBtn(var_4_0)

			local var_4_1 = arg_2_0._uiMediator

			var_0.ShowTimer(var_4_1)

			local var_4_2 = arg_2_0._state
			local var_4_3 = var_0.GetCommandByName(var_4_2, var_0.Battle.BattleControllerWeaponCommand.__name)

			var_0.TryAutoSub(var_4_3)

			local var_4_4 = arg_2_0._state

			var_1.ChangeState(var_4_4, var_0.Battle.BattleState.BATTLE_STATE_FIGHT)

			local var_4_5 = arg_2_0._waveUpdater

			var_1.Start(var_4_5)

			local var_4_6 = arg_2_0._dataProxy

			if var_1.GetInitData(var_4_6).hideAllButtons then
				local var_4_7 = arg_2_0._dataProxy

				var_1.DispatchEvent(var_4_7, var_0.Event.New(var_0.Battle.BattleEvent.HIDE_INTERACTABLE_BUTTONS, {
					isActive = false
				}))
			end

			return
		end)

		local var_3_1 = arg_2_0._dataProxy
		local var_3_2 = var_0.GetFleetByIFF(var_3_1, var_0.Battle.BattleConfig.FRIENDLY_CODE)

		var_0.FleetWarcry(var_3_2)

		local var_3_3 = arg_2_0._dataProxy

		var_1.InitAllFleetUnitsWeaponCD(var_3_3)

		local var_3_4 = arg_2_0._dataProxy

		var_1.TirggerBattleStartBuffs(var_3_4)

		pg = var_1

		local var_3_5 = var_1.TimeMgr.GetInstance()

		var_1.RemoveBattleTimer(var_3_5, arg_2_0._shiftTimer)

		arg_2_0._shiftTimer = nil

		return
	end

	local function var_2_2()
		local var_5_0 = arg_2_0._dataProxy
		local var_5_1 = var_0.GetInitData(var_5_0).DALAidBuffIDs
		local var_5_2

		ipairs = var_2_10002

		for iter_5_0, iter_5_1 in var_2_10002(var_5_1) do
			var_5_2 = var_0.Battle.BattleBuffUnit.New(iter_5_1, 1)
		end

		if var_5_2 then
			local var_5_3 = arg_2_0._dataProxy
			local var_5_4 = var_2.GetFleetList(var_5_3)

			pairs = var_5_3

			for iter_5_2, iter_5_3 in var_5_3(var_5_4) do
				local var_5_5 = iter_5_3:GetUnitList()
				local var_5_6 = iter_5_3:GetMainList()[1]

				ipairs = var_2_10011

				for iter_5_4, iter_5_5 in var_2_10011(var_5_5) do
					if iter_5_5 == var_5_6 then
						iter_5_5:AddBuff(var_5_2)
						iter_5_5:TriggerBuff(var_0.Battle.BattleConst.BuffEffectType.ON_DAL_COLLAB_FLAG_SHIP)
					end
				end
			end

			local var_5_7 = arg_2_0

			pg = var_4

			local var_5_8 = var_4.TimeMgr.GetInstance()

			var_5_7._shiftTimer = var_4.AddBattleTimer(var_5_8, "", -1, 2, var_2_1, true)
		else
			var_2_1()
		end

		return
	end

	local var_2_3 = arg_2_0._uiMediator

	var_3.SeaSurfaceShift(var_2_3, 45, 0, nil, var_2_2)

	return
end

return

ys = ys or {}

local var_0_2 = class("BattleDALCollabSingleDungeonCommand", ys.Battle.BattleSingleDungeonCommand)

ys.Battle.BattleDALCollabSingleDungeonCommand = var_0_2
var_0_2.__name = "BattleDALCollabSingleDungeonCommand"

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.DoPrologue(arg_2_0)
	pg.UIMgr.GetInstance():Marching()

	local function var_2_0()
		arg_2_0._uiMediator:OpeningEffect(function()
			arg_2_0._uiMediator:ShowAutoBtn()
			arg_2_0._uiMediator:ShowTimer()
			arg_2_0._state:GetCommandByName(var_0.Battle.BattleControllerWeaponCommand.__name):TryAutoSub()
			arg_2_0._state:ChangeState(var_0.Battle.BattleState.BATTLE_STATE_FIGHT)
			arg_2_0._waveUpdater:Start()

			if arg_2_0._dataProxy:GetInitData().hideAllButtons then
				arg_2_0._dataProxy:DispatchEvent(var_0.Event.New(var_0.Battle.BattleEvent.HIDE_INTERACTABLE_BUTTONS, {
					isActive = false
				}))
			end

			return
		end)
		arg_2_0._dataProxy:GetFleetByIFF(var_0.Battle.BattleConfig.FRIENDLY_CODE):FleetWarcry()
		arg_2_0._dataProxy:InitAllFleetUnitsWeaponCD()
		arg_2_0._dataProxy:TirggerBattleStartBuffs()
		pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_2_0._shiftTimer)

		arg_2_0._shiftTimer = nil

		return
	end

	arg_2_0._uiMediator:SeaSurfaceShift(45, 0, nil, function()
		local var_5_0

		for iter_5_0, iter_5_1 in ipairs(arg_2_0._dataProxy:GetInitData().DALAidBuffIDs) do
			var_5_0 = var_0.Battle.BattleBuffUnit.New(iter_5_1, 1)
		end

		if var_5_0 then
			for iter_5_2, iter_5_3 in pairs((arg_2_0._dataProxy:GetFleetList())) do
				local var_5_1 = iter_5_3:GetMainList()[1]

				for iter_5_4, iter_5_5 in ipairs((iter_5_3:GetUnitList())) do
					if iter_5_5 == var_5_1 then
						iter_5_5:AddBuff(var_5_0)
						iter_5_5:TriggerBuff(var_0.Battle.BattleConst.BuffEffectType.ON_DAL_COLLAB_FLAG_SHIP)
					end
				end
			end

			arg_2_0._shiftTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", -1, 2, var_2_0, true)
		else
			var_2_0()
		end

		return
	end)

	return
end

return

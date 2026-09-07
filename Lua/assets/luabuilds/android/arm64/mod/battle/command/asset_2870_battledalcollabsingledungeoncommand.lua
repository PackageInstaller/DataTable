ys = ys or {}

local var_0_0 = ys
local BattleDALCollabSingleDungeonCommand = class("BattleDALCollabSingleDungeonCommand", ys.Battle.BattleSingleDungeonCommand)

ys.Battle.BattleDALCollabSingleDungeonCommand = BattleDALCollabSingleDungeonCommand
BattleDALCollabSingleDungeonCommand.__name = "BattleDALCollabSingleDungeonCommand"

function BattleDALCollabSingleDungeonCommand:Ctor()
	BattleDALCollabSingleDungeonCommand.super.Ctor(self)

	return
end

function BattleDALCollabSingleDungeonCommand:DoPrologue()
	pg.UIMgr.GetInstance():Marching()

	local function var_2_0()
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
		pg.TimeMgr.GetInstance():RemoveBattleTimer(self._shiftTimer)

		self._shiftTimer = nil

		return
	end

	self._uiMediator:SeaSurfaceShift(45, 0, nil, function()
		local var_5_0

		for iter_5_0, iter_5_1 in ipairs(self._dataProxy:GetInitData().DALAidBuffIDs) do
			var_5_0 = var_0_0.Battle.BattleBuffUnit.New(iter_5_1, 1)
		end

		if var_5_0 then
			for iter_5_2, iter_5_3 in pairs((self._dataProxy:GetFleetList())) do
				local var_5_1 = iter_5_3:GetMainList()[1]

				for iter_5_4, iter_5_5 in ipairs((iter_5_3:GetUnitList())) do
					if iter_5_5 == var_5_1 then
						iter_5_5:AddBuff(var_5_0)
						iter_5_5:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_DAL_COLLAB_FLAG_SHIP)
					end
				end
			end

			self._shiftTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", -1, 2, var_2_0, true)
		else
			var_2_0()
		end

		return
	end)

	return
end

return

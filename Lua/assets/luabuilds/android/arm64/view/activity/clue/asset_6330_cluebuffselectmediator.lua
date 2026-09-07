local ClueBuffSelectMediator = class("ClueBuffSelectMediator", import("view.base.ContextMediator"))

ClueBuffSelectMediator.ON_FLEET_SELECT = "ClueBuffSelectMediator.ON_FLEET_SELECT"

function ClueBuffSelectMediator:register()
	self:bind(ClueBuffSelectMediator.ON_FLEET_SELECT, function(arg_2_0, arg_2_1)
		self.viewComponent:ShowNormalFleet(arg_2_1)

		return
	end)
	self.viewComponent:SetStageID(self.contextData.clueSingleEnemyID)

	local var_1_0 = PlayerPrefs.GetString(self.viewComponent.PLYAER_PREF_KEY .. self.contextData.clueSingleEnemyID)
	local var_1_1 = {}

	if not var_1_0 or var_1_0 == "" then
		var_1_1 = nil
	else
		for iter_1_0 in string.gmatch(var_1_0, "[^|]+") do
			table.insert(var_1_1, tonumber(iter_1_0))
		end
	end

	self.viewComponent:SetPreSelectedBuff(self.contextData.preSelectedBuffList or self.contextData.selectedBuffList or var_1_1 or {})
	BossSingleBattleFleetSelectMediatorComponent.AttachFleetSelect(self, ActivityConst.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE, SYSTEM_BOSS_SINGLE_VARIABLE, Fleet.MEGA_SUBMARINE_FLEET_OFFSET)

	return
end

function ClueBuffSelectMediator:listNotificationInterests()
	return {
		GAME.COMMANDER_ACTIVITY_FORMATION_OP_DONE
	}
end

function ClueBuffSelectMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.COMMANDER_ACTIVITY_FORMATION_OP_DONE then
		local var_4_1 = arg_4_1:getBody()
		local var_4_2 = getProxy(FleetProxy):getActivityFleets()[var_4_1.actId]

		self.contextData.actFleets = var_4_2

		self.viewComponent:updateEditPanel()
		self.viewComponent:updateCommanderFleet(var_4_2[var_4_1.fleetId])
	end

	return
end

return ClueBuffSelectMediator

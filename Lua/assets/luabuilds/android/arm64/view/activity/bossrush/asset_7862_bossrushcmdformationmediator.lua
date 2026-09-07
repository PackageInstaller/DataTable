local BossRushCMDFormationMediator = class("BossRushCMDFormationMediator", import("view.base.ContextMediator"))

function BossRushCMDFormationMediator:register()
	self.viewComponent:updateFleet(self.contextData.fleet)
	self.viewComponent:setCommanderPrefabs((getProxy(CommanderProxy):getPrefabFleet()))
	self.viewComponent:setCallback(self.contextData.callback)

	return
end

function BossRushCMDFormationMediator:listNotificationInterests()
	return {
		CommanderProxy.PREFAB_FLEET_UPDATE,
		GAME.COMMANDER_ACTIVITY_FORMATION_OP_DONE
	}
end

function BossRushCMDFormationMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	if var_3_0 == nil then
		-- block empty
	elseif var_3_0 == CommanderProxy.PREFAB_FLEET_UPDATE then
		self.viewComponent:setCommanderPrefabs((getProxy(CommanderProxy):getPrefabFleet()))
	elseif var_3_0 == GAME.COMMANDER_ACTIVITY_FORMATION_OP_DONE then
		self.viewComponent:updateRecordFleet()
		self.viewComponent:updateDesc()
		self.viewComponent:updateRecordPanel()
	end

	return
end

function BossRushCMDFormationMediator:remove()
	return
end

return BossRushCMDFormationMediator

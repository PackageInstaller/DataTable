local WorldBossInformationMediator = class("WorldBossInformationMediator", import("..base.ContextMediator"))

WorldBossInformationMediator.RETREAT_FLEET = "WorldBossInformationMediator:RETREAT_FLEET"
WorldBossInformationMediator.OnOpenSublayer = "WorldBossInformationMediator:OpenSublayer"

function WorldBossInformationMediator:register()
	self:bind(WorldBossInformationMediator.RETREAT_FLEET, function()
		self:sendNotification(GAME.WORLD_RETREAT_FLEET)

		return
	end)
	self:bind(WorldBossInformationMediator.OnOpenSublayer, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		self:addSubLayers(arg_3_1, arg_3_2, arg_3_3)

		return
	end)
	self.viewComponent:setPlayerInfo(getProxy(PlayerProxy):getRawData())

	return
end

function WorldBossInformationMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		GAME.WORLD_MAP_OP_DONE,
		GAME.BEGIN_STAGE_DONE
	}
end

function WorldBossInformationMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()

	if var_5_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayerInfo(getProxy(PlayerProxy):getRawData())
	elseif var_5_0 == GAME.WORLD_MAP_OP_DONE then
		-- block empty
	elseif var_5_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, (arg_5_1:getBody()))
	end

	return
end

return WorldBossInformationMediator

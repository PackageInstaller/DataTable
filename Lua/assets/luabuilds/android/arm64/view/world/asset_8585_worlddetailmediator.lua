local WorldDetailMediator = class("WorldDetailMediator", import("..base.ContextMediator"))

WorldDetailMediator.OnShipInfo = "WorldDetailMediator:OnShipInfo"
WorldDetailMediator.OnCmdSkill = "WorldDetailMediator.OnCmdSkill"

function WorldDetailMediator:register()
	self:bind(WorldDetailMediator.OnShipInfo, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = WorldConst.FetchWorldShip(arg_2_1)

		self.contextData.fleetId = var_2_0.fleetId
		self.contextData.toggle = arg_2_2

		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = var_2_0.id,
			shipVOs = nowWorld():GetFleet(var_2_0.fleetId):GetShipVOs(true)
		})

		return
	end)
	self:bind(WorldDetailMediator.OnCmdSkill, function(arg_3_0, arg_3_1)
		self:addSubLayers(Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = CommanderSkillLayer,
			data = {
				isWorld = true,
				skill = arg_3_1
			}
		}))

		return
	end)
	self.viewComponent:setPlayerInfo(getProxy(PlayerProxy):getRawData())
	self.viewComponent:setFleets(nowWorld():GetFleets())

	return
end

function WorldDetailMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED
	}
end

function WorldDetailMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getBody()

	if arg_5_1:getName() == PlayerProxy.UPDATED then
		self.viewComponent:setPlayerInfo(getProxy(PlayerProxy):getRawData())
	end

	return
end

return WorldDetailMediator

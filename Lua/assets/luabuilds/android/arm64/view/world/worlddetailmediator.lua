local var_0_0 = class("WorldDetailMediator", import("..base.ContextMediator"))

var_0_0.OnShipInfo = "WorldDetailMediator:OnShipInfo"
var_0_0.OnCmdSkill = "WorldDetailMediator.OnCmdSkill"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.OnShipInfo, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = WorldConst.FetchWorldShip(arg_2_1)

		arg_1_0.contextData.fleetId = var_2_0.fleetId
		arg_1_0.contextData.toggle = arg_2_2

		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = var_2_0.id,
			shipVOs = nowWorld():GetFleet(var_2_0.fleetId):GetShipVOs(true)
		})

		return
	end)
	arg_1_0:bind(var_0_0.OnCmdSkill, function(arg_3_0, arg_3_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = CommanderSkillLayer,
			data = {
				isWorld = true,
				skill = arg_3_1
			}
		}))

		return
	end)
	arg_1_0.viewComponent:setPlayerInfo(getProxy(PlayerProxy):getRawData())
	arg_1_0.viewComponent:setFleets(nowWorld():GetFleets())

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		PlayerProxy.UPDATED
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getBody()

	if arg_5_1:getName() == PlayerProxy.UPDATED then
		arg_5_0.viewComponent:setPlayerInfo(getProxy(PlayerProxy):getRawData())
	end

	return
end

return var_0_0

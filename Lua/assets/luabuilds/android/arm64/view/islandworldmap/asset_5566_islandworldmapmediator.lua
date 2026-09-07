local IslandWorldMapMediator = class("IslandWorldMapMediator", import("view.base.ContextMediator"))

IslandWorldMapMediator.GO_ISLAND = "IslandWorldMapMediator:GO_ISLAND"

function IslandWorldMapMediator:register()
	self:bindEvent()

	return
end

function IslandWorldMapMediator:bindEvent()
	self:bind(IslandWorldMapMediator.GO_ISLAND, function(arg_3_0, arg_3_1, arg_3_2)
		pg.m02:sendNotification(ISLAND_EVT.SWITCH_SCENE, {
			mapId = arg_3_1
		})

		return
	end)

	return
end

function IslandWorldMapMediator:listNotificationInterests()
	return {}
end

function IslandWorldMapMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getBody()

	if arg_5_1:getName() == GAME.BEGIN_STAGE_DONE then
		-- block empty
	end

	return
end

return IslandWorldMapMediator

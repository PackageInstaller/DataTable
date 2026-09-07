local WorldMediaCollectionEntranceMediator = class("WorldMediaCollectionEntranceMediator", import("view.base.ContextMediator"))

WorldMediaCollectionEntranceMediator.OPEN_RECALL = "WorldMediaCollectionEntranceMediator:OPEN_RECALL"
WorldMediaCollectionEntranceMediator.OPEN_NEWRECALL = "WorldMediaCollectionEntranceMediator:OPEN_NEWRECALL"
WorldMediaCollectionEntranceMediator.OPEN_CRYPTOLALIA = "WorldMediaCollectionEntranceMediator:OPEN_CRYPTOLALIA"
WorldMediaCollectionEntranceMediator.OPEN_ARCHIVE = "WorldMediaCollectionEntranceMediator:OPEN_ARCHIVE"
WorldMediaCollectionEntranceMediator.OPEN_RECORD = "WorldMediaCollectionEntranceMediator:OPEN_RECORD"
WorldMediaCollectionEntranceMediator.OPEN_ALBUM = "WorldMediaCollectionEntranceMediator:OPEN_ALBUM"

function WorldMediaCollectionEntranceMediator:register()
	self:bind(WorldMediaCollectionEntranceMediator.OPEN_CRYPTOLALIA, function(arg_2_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.CRYPTOLALIA)

		return
	end)
	self:bind(WorldMediaCollectionEntranceMediator.OPEN_RECALL, function(arg_3_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.WORLD_COLLECTION, {
			page = WorldMediaCollectionScene.PAGE_MEMORTY
		})

		return
	end)
	self:bind(WorldMediaCollectionEntranceMediator.OPEN_NEWRECALL, function(arg_4_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.WORLD_COLLECTION, {
			page = WorldMediaCollectionScene.PAGE_SHIP
		})

		return
	end)
	self:bind(WorldMediaCollectionEntranceMediator.OPEN_ARCHIVE, function(arg_5_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.WORLD_COLLECTION, {
			page = WorldMediaCollectionScene.PAGE_RECORD
		})

		return
	end)
	self:bind(WorldMediaCollectionEntranceMediator.OPEN_RECORD, function(arg_6_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.WORLD_COLLECTION, {
			page = WorldMediaCollectionScene.PAGE_FILE
		})

		return
	end)
	self:bind(WorldMediaCollectionEntranceMediator.OPEN_ALBUM, function(arg_7_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.WORLD_COLLECTION, {
			page = WorldMediaCollectionScene.PAGE_ALBUM
		})

		return
	end)

	return
end

function WorldMediaCollectionEntranceMediator:listNotificationInterests()
	return {}
end

function WorldMediaCollectionEntranceMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	return
end

return WorldMediaCollectionEntranceMediator

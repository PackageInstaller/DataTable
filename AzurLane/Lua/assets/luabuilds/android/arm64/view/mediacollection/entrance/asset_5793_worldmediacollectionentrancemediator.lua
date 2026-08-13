class = var_0_10000

local var_0_0 = "WorldMediaCollectionEntranceMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.OPEN_RECALL = "WorldMediaCollectionEntranceMediator:OPEN_RECALL"
var_0_1.OPEN_NEWRECALL = "WorldMediaCollectionEntranceMediator:OPEN_NEWRECALL"
var_0_1.OPEN_CRYPTOLALIA = "WorldMediaCollectionEntranceMediator:OPEN_CRYPTOLALIA"
var_0_1.OPEN_ARCHIVE = "WorldMediaCollectionEntranceMediator:OPEN_ARCHIVE"
var_0_1.OPEN_RECORD = "WorldMediaCollectionEntranceMediator:OPEN_RECORD"
var_0_1.OPEN_ALBUM = "WorldMediaCollectionEntranceMediator:OPEN_ALBUM"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OPEN_CRYPTOLALIA, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_2_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_2_1(var_2_0, var_2_2, var_2_10005.CRYPTOLALIA)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_RECALL, function(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_3_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		local var_3_3 = var_2_10005.WORLD_COLLECTION
		local var_3_4 = {}

		WorldMediaCollectionScene = var_2_10007
		var_3_4.page = var_2_10007.PAGE_MEMORTY

		var_3_1(var_3_0, var_3_2, var_3_3, var_3_4)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_NEWRECALL, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_4_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		local var_4_3 = var_2_10005.WORLD_COLLECTION
		local var_4_4 = {}

		WorldMediaCollectionScene = var_2_10007
		var_4_4.page = var_2_10007.PAGE_SHIP

		var_4_1(var_4_0, var_4_2, var_4_3, var_4_4)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_ARCHIVE, function(arg_5_0)
		local var_5_0 = arg_1_0
		local var_5_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_5_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		local var_5_3 = var_2_10005.WORLD_COLLECTION
		local var_5_4 = {}

		WorldMediaCollectionScene = var_2_10007
		var_5_4.page = var_2_10007.PAGE_RECORD

		var_5_1(var_5_0, var_5_2, var_5_3, var_5_4)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_RECORD, function(arg_6_0)
		local var_6_0 = arg_1_0
		local var_6_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_6_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		local var_6_3 = var_2_10005.WORLD_COLLECTION
		local var_6_4 = {}

		WorldMediaCollectionScene = var_2_10007
		var_6_4.page = var_2_10007.PAGE_FILE

		var_6_1(var_6_0, var_6_2, var_6_3, var_6_4)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_ALBUM, function(arg_7_0)
		local var_7_0 = arg_1_0
		local var_7_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_7_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		local var_7_3 = var_2_10005.WORLD_COLLECTION
		local var_7_4 = {}

		WorldMediaCollectionScene = var_2_10007
		var_7_4.page = var_2_10007.PAGE_ALBUM

		var_7_1(var_7_0, var_7_2, var_7_3, var_7_4)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	return {}
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	return
end

return var_0_1

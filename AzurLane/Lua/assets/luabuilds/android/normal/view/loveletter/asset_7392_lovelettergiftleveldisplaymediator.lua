class = var_0_10000

local var_0_0 = "LoveLetterGiftLevelDisplayMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_GO_COLLECTION = "LoveLetterGiftLevelDisplayMediator.ON_GO_COLLECTION"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_GO_COLLECTION, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10003

		local var_2_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_2_3 = var_2_10004.WORLD_COLLECTION
		local var_2_4 = {}

		WorldMediaCollectionScene = var_2_10006
		var_2_4.page = var_2_10006.PAGE_ALBUM
		WorldMediaCollectionAlbumGroupLayer = var_6
		var_2_4.albumType = var_6.ALBUM_TYPE_LOVE_LETTER

		var_2_1(var_2_0, var_2_2, var_2_3, var_2_4)

		return
	end)

	local var_1_0 = arg_1_0.viewComponent

	var_1.SetLoveLetter(var_1_0, arg_1_0.contextData.groupId)

	return
end

function var_0_1.initNotificationHandleDic(arg_3_0)
	arg_3_0.handleDic = {}

	return
end

return var_0_1

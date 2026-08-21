local var_0_0 = class("LoveLetterGiftLevelDisplayMediator", import("view.base.ContextMediator"))

var_0_0.ON_GO_COLLECTION = "LoveLetterGiftLevelDisplayMediator.ON_GO_COLLECTION"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_GO_COLLECTION, function(arg_2_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.WORLD_COLLECTION, {
			page = WorldMediaCollectionScene.PAGE_ALBUM,
			albumType = WorldMediaCollectionAlbumGroupLayer.ALBUM_TYPE_LOVE_LETTER
		})

		return
	end)
	arg_1_0.viewComponent:SetLoveLetter(arg_1_0.contextData.groupId)

	return
end

function var_0_0.initNotificationHandleDic(arg_3_0)
	arg_3_0.handleDic = {}

	return
end

return var_0_0

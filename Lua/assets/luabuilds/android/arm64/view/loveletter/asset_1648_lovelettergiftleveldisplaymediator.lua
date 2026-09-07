local LoveLetterGiftLevelDisplayMediator = class("LoveLetterGiftLevelDisplayMediator", import("view.base.ContextMediator"))

LoveLetterGiftLevelDisplayMediator.ON_GO_COLLECTION = "LoveLetterGiftLevelDisplayMediator.ON_GO_COLLECTION"

function LoveLetterGiftLevelDisplayMediator:register()
	self:bind(LoveLetterGiftLevelDisplayMediator.ON_GO_COLLECTION, function(arg_2_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.WORLD_COLLECTION, {
			page = WorldMediaCollectionScene.PAGE_ALBUM,
			albumType = WorldMediaCollectionAlbumGroupLayer.ALBUM_TYPE_LOVE_LETTER
		})

		return
	end)
	self.viewComponent:SetLoveLetter(self.contextData.groupId)

	return
end

function LoveLetterGiftLevelDisplayMediator:initNotificationHandleDic()
	self.handleDic = {}

	return
end

return LoveLetterGiftLevelDisplayMediator

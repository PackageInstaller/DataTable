local LoveLetterGiftCollectMediator = class("LoveLetterGiftCollectMediator", import("view.base.ContextMediator"))

LoveLetterGiftCollectMediator.ON_RECORD_GIFT = "LoveLetterGiftCollectMediator.ON_RECORD_GIFT"

function LoveLetterGiftCollectMediator:register()
	self:bind(LoveLetterGiftCollectMediator.ON_RECORD_GIFT, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.REALIZE_LOVE_LETTER_GIFT, {
			list = arg_2_1
		})

		return
	end)

	return
end

function LoveLetterGiftCollectMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.REALIZE_LOVE_LETTER_GIFT_DONE] = function(arg_4_0, arg_4_1)
			arg_4_0.viewComponent:closeView()

			return
		end
	}

	return
end

return LoveLetterGiftCollectMediator

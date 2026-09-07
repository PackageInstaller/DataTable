local LoveLetterDisplayMediator = class("LoveLetterDisplayMediator", import("view.base.ContextMediator"))

LoveLetterDisplayMediator.ON_UNLOCK_LETTER = "LoveLetterDisplayMediator.ON_UNLOCK_LETTER"

function LoveLetterDisplayMediator:register()
	self:bind(LoveLetterDisplayMediator.ON_UNLOCK_LETTER, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.UNLOCK_LOVE_LETTER, {
			id = arg_2_1
		})

		return
	end)
	self.viewComponent:SetLoveLetter(self.contextData.groupId)

	return
end

function LoveLetterDisplayMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.UNLOCK_LOVE_LETTER_DONE] = function(arg_4_0, arg_4_1)
			arg_4_0.viewComponent:DoOpenLetter()

			return
		end
	}

	return
end

return LoveLetterDisplayMediator

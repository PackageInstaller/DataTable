local LoveLetterSelectCharConfirmMediator = class("LoveLetterSelectCharConfirmMediator", import("view.base.ContextMediator"))

LoveLetterSelectCharConfirmMediator.SELECT_CHAR = "LoveLetterSelectCharConfirmMediator.SELECT_CHAR"

function LoveLetterSelectCharConfirmMediator:register()
	self:bind(LoveLetterSelectCharConfirmMediator.SELECT_CHAR, function(arg_2_0, arg_2_1)
		if self.contextData.isRepair then
			self:sendNotification(GAME.USE_ITEM, {
				count = 1,
				id = self.contextData.itemVO.id,
				arg = {
					arg_2_1
				}
			})
		else
			self:sendNotification(GAME.ACTIVITY_OPERATION, {
				cmd = 1,
				activity_id = self.contextData.actId,
				arg1 = arg_2_1
			})
		end

		return
	end)
	self.viewComponent:SetLoveLetter(self.contextData.groupId)
	self.viewComponent:SetActivity(self.contextData.actId)

	return
end

function LoveLetterSelectCharConfirmMediator:initNotificationHandleDic()
	self.handleDic = {
		[ActivityProxy.ACTIVITY_OPERATION_DONE] = function(arg_4_0, arg_4_1)
			if arg_4_1:getBody() == arg_4_0.contextData.actId then
				arg_4_0.viewComponent:closeView()
			end

			return
		end,
		[GAME.USE_ITEM_DONE] = function(arg_5_0, arg_5_1)
			pg.TipsMgr.GetInstance():ShowTips(i18n("loveletter2018_ui_tips"))
			arg_5_0.viewComponent:closeView()

			return
		end
	}

	return
end

return LoveLetterSelectCharConfirmMediator

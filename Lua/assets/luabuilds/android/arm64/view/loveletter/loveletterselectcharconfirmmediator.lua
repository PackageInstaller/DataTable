local var_0_0 = class("LoveLetterSelectCharConfirmMediator", import("view.base.ContextMediator"))

var_0_0.SELECT_CHAR = "LoveLetterSelectCharConfirmMediator.SELECT_CHAR"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.SELECT_CHAR, function(arg_2_0, arg_2_1)
		if arg_1_0.contextData.isRepair then
			arg_1_0:sendNotification(GAME.USE_ITEM, {
				count = 1,
				id = arg_1_0.contextData.itemVO.id,
				arg = {
					arg_2_1
				}
			})
		else
			arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, {
				cmd = 1,
				activity_id = arg_1_0.contextData.actId,
				arg1 = arg_2_1
			})
		end

		return
	end)
	arg_1_0.viewComponent:SetLoveLetter(arg_1_0.contextData.groupId)
	arg_1_0.viewComponent:SetActivity(arg_1_0.contextData.actId)

	return
end

function var_0_0.initNotificationHandleDic(arg_3_0)
	arg_3_0.handleDic = {
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

return var_0_0

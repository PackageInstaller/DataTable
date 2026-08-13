class = var_0_10000

local var_0_0 = "LoveLetterSelectCharConfirmMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.SELECT_CHAR = "LoveLetterSelectCharConfirmMediator.SELECT_CHAR"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.SELECT_CHAR, function(arg_2_0, arg_2_1)
		if arg_1_0.contextData.isRepair then
			local var_2_0 = arg_1_0
			local var_2_1 = var_2.sendNotification

			GAME = var_2_10005

			var_2_1(var_2_0, var_2_10005.USE_ITEM, {
				count = 1,
				id = arg_1_0.contextData.itemVO.id,
				arg = {
					arg_2_1
				}
			})
		else
			local var_2_2 = arg_1_0
			local var_2_3 = var_2.sendNotification

			GAME = var_2_10005

			var_2_3(var_2_2, var_2_10005.ACTIVITY_OPERATION, {
				cmd = 1,
				activity_id = arg_1_0.contextData.actId,
				arg1 = arg_2_1
			})
		end

		return
	end)

	local var_1_0 = arg_1_0.viewComponent

	var_1.SetLoveLetter(var_1_0, arg_1_0.contextData.groupId)

	local var_1_1 = arg_1_0.viewComponent

	var_1.SetActivity(var_1_1, arg_1_0.contextData.actId)

	return
end

function var_0_1.initNotificationHandleDic(arg_3_0)
	local var_3_0 = {}

	ActivityProxy = var_1_10002
	var_3_0[var_1_10002.ACTIVITY_OPERATION_DONE] = function(arg_4_0, arg_4_1)
		if arg_4_1:getBody() == arg_4_0.contextData.actId then
			local var_4_0 = arg_4_0.viewComponent

			var_3.closeView(var_4_0)
		end

		return
	end
	GAME = var_2
	var_3_0[var_2.USE_ITEM_DONE] = function(arg_5_0, arg_5_1)
		pg = var_2_10002

		local var_5_0 = var_2_10002.TipsMgr.GetInstance()
		local var_5_1 = var_2.ShowTips

		i18n = var_2_10005

		var_5_1(var_5_0, var_2_10005("loveletter2018_ui_tips"))

		local var_5_2 = arg_5_0.viewComponent

		var_2.closeView(var_5_2)

		return
	end
	arg_3_0.handleDic = var_3_0

	return
end

return var_0_1

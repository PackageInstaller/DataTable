class = var_0_10000

local var_0_0 = "ExtraProtoResultCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	if arg_1_1:getBody().result == 14 then
		getProxy = var_1_0
		WorldProxy = var_1_10005
		var_1_0 = var_1_0(var_1_10005)
		var_1_0.isProtoLock = true
		pg = var_1_0

		local var_1_1 = var_1_0.TipsMgr.GetInstance()

		var_1_0 = var_1_0.ShowTips
		i18n = var_1_10006

		var_1_0(var_1_1, var_1_10006("world_close"))

		getProxy = var_1_0
		ContextProxy = var_1_1
		var_1_10006 = var_1_0(var_1_1)

		local var_1_2 = var_1_0.getCurrentContext(var_1_10006)

		if var_4.retriveLastChild(var_1_2) and var_5 ~= var_4 then
			local var_1_3 = arg_1_0

			var_1_10006 = arg_1_0.sendNotification
			GAME = var_1_10009

			var_1_10006(var_1_3, var_1_10009.REMOVE_LAYERS, {
				context = var_5
			})
		end

		local var_1_4 = arg_1_0

		var_1_10006 = arg_1_0.sendNotification
		GAME = var_1_10009

		local var_1_5 = var_1_10009.GO_SCENE

		SCENE = var_1_10010

		var_1_10006(var_1_4, var_1_5, var_1_10010.MAINUI)
	else
		pg = var_1_0

		local var_1_6 = var_1_0.TipsMgr.GetInstance()
		local var_1_7 = var_3.ShowTips

		errorTip = var_1_10006

		var_1_7(var_1_6, var_1_10006("", var_2.result))
	end

	return
end

return var_0_1

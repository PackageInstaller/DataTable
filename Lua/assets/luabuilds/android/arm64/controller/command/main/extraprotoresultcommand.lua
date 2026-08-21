local var_0_0 = class("ExtraProtoResultCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if var_1_0.result == 14 then
		getProxy(WorldProxy).isProtoLock = true

		pg.TipsMgr.GetInstance():ShowTips(i18n("world_close"))

		local var_1_1 = getProxy(ContextProxy):getCurrentContext()
		local var_1_2 = var_1_1:retriveLastChild()

		if var_1_2 and var_1_2 ~= var_1_1 then
			arg_1_0:sendNotification(GAME.REMOVE_LAYERS, {
				context = var_1_2
			})
		end

		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.MAINUI)
	else
		pg.TipsMgr.GetInstance():ShowTips(errorTip("", var_1_0.result))
	end

	return
end

return var_0_0

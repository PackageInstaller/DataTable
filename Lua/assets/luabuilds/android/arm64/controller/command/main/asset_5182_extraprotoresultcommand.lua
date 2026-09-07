local ExtraProtoResultCommand = class("ExtraProtoResultCommand", pm.SimpleCommand)

function ExtraProtoResultCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if var_1_0.result == 14 then
		getProxy(WorldProxy).isProtoLock = true

		pg.TipsMgr.GetInstance():ShowTips(i18n("world_close"))

		local var_1_1 = getProxy(ContextProxy):getCurrentContext()
		local var_1_2 = var_1_1:retriveLastChild()

		if var_1_2 and var_1_2 ~= var_1_1 then
			self:sendNotification(GAME.REMOVE_LAYERS, {
				context = var_1_2
			})
		end

		self:sendNotification(GAME.GO_SCENE, SCENE.MAINUI)
	else
		pg.TipsMgr.GetInstance():ShowTips(errorTip("", var_1_0.result))
	end

	return
end

return ExtraProtoResultCommand

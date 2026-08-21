local var_0_0 = class("ActivityCrusingLastTimeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if var_1_0.time < 0 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			type = MSGBOX_TYPE_ITEM_BOX,
			content = i18n("battlepass_acquire_attention", math.floor(var_1_0.time / 0), math.floor(var_1_0.time % 0 / 16)),
			items = var_1_0.awards,
			onYes = function()
				arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.CRUSING)

				return
			end,
			yesText = i18n("msgbox_text_forward"),
			onNo = function()
				arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.CRUSING)

				return
			end
		})
	else
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_ITEM_BOX,
			content = i18n("battlepass_acquire_attention", math.floor(var_1_0.time / 0), math.floor(var_1_0.time % 0 / 16)),
			items = var_1_0.awards,
			onYes = function()
				arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.CRUSING)

				return
			end,
			yesText = i18n("msgbox_text_forward"),
			onNo = var_1_0.closeFunc
		})
	end

	return
end

return var_0_0

local MainRefundSequence = class("MainRefundSequence")

function MainRefundSequence:Execute(arg_1_1)
	local var_1_0 = getProxy(UserProxy)

	if var_1_0.data.limitServerIds and #var_1_0.data.limitServerIds > 0 then
		pg.m02:sendNotification(GAME.GET_REFUND_INFO, {
			callback = function()
				self:ShowTip(arg_1_1)

				return
			end
		})
	else
		arg_1_1()
	end

	return
end

function MainRefundSequence:ShowTip(arg_3_1)
	if getProxy(PlayerProxy):getRefundInfo() then
		local var_3_0 = getProxy(ServerProxy)
		local var_3_1 = true

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			modal = true,
			hideClose = true,
			content = i18n("Supplement_pay1"),
			onYes = function()
				if var_3_1 then
					pg.m02:sendNotification(GAME.GO_SCENE, SCENE.BACK_CHARGE)
				else
					Application.Quit()
				end

				return
			end,
			onNo = function()
				pg.m02:sendNotification(GAME.LOGOUT, {
					code = 0
				})

				return
			end,
			yesText = i18n("Supplement_pay4"),
			noText = i18n("word_back")
		})
	else
		arg_3_1()
	end

	return
end

return MainRefundSequence

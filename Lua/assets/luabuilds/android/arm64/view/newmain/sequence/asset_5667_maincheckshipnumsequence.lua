local MainCheckShipNumSequence = class("MainCheckShipNumSequence")

function MainCheckShipNumSequence:Execute(arg_1_1)
	pg.m02:sendNotification(GAME.GET_SHIP_CNT, {
		callback = function(arg_2_0)
			if self:Check(arg_2_0) then
				arg_1_1()
			end

			return
		end
	})

	return
end

function MainCheckShipNumSequence:Check(arg_3_1)
	local var_3_0 = getProxy(BayProxy):getRawShipCount()
	local var_3_1 = arg_3_1 <= var_3_0

	if arg_3_1 > var_3_0 then
		originalPrint(arg_3_1, var_3_0)
		self:ShowTip()
	end

	return var_3_1
end

function MainCheckShipNumSequence:ShowTip()
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		modal = true,
		hideNo = true,
		hideClose = true,
		content = i18n("dockyard_data_loss_detected"),
		onYes = function()
			pg.m02:sendNotification(GAME.LOGOUT, {
				code = 0
			})

			return
		end
	})

	return
end

return MainCheckShipNumSequence

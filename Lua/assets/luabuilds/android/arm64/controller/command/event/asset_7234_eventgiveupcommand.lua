local EventGiveUpCommand = class("EventGiveUpCommand", pm.SimpleCommand)

function EventGiveUpCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	if getProxy(EventProxy):getEventInfo(var_1_0):IsActivityType() then
		self:sendNotification(GAME.ACT_COLLECTION_EVENT_OP, {
			arg2 = 0,
			cmd = ActivityConst.COLLETION_EVENT_OP_GIVE_UP,
			arg1 = var_1_0,
			arg_list = {}
		})
	else
		pg.ConnectionMgr.GetInstance():Send(13007, {
			id = var_1_0
		}, 13008, function(arg_2_0)
			if arg_2_0.result == 0 then
				EventGiveUpCommand.OnCancel(var_1_0)
			else
				pg.TipsMgr.GetInstance():ShowTips(errorTip("event_giveup_fail", arg_2_0.result))
			end

			return
		end)
	end

	return
end

function EventGiveUpCommand:OnCancel()
	pg.TipsMgr.GetInstance():ShowTips(i18n("event_giveup_success"))

	local var_3_0 = getProxy(EventProxy)
	local var_3_1 = var_3_0:getEventInfo(self)

	var_3_1.finishTime = 0
	var_3_1.shipIds = {}

	var_3_0:updateInfoList({
		var_3_1
	})

	return
end

return EventGiveUpCommand

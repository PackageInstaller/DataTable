local EventStartCommand = class("EventStartCommand", pm.SimpleCommand)

function EventStartCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().event
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.shipIds
	local var_1_3 = getProxy(EventProxy)
	local var_1_4 = var_1_0:IsActivityType()

	if not var_1_4 and not var_1_3:CanStartEvent() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("event_fleet_busy"))

		return
	end

	local var_1_5, var_1_6 = var_1_3:CanJoinEvent(var_1_0)

	if not var_1_5 then
		if var_1_6 then
			pg.TipsMgr.GetInstance():ShowTips(var_1_6)
		end

		return
	end

	local function var_1_7()
		if var_1_4 then
			self:sendNotification(GAME.ACT_COLLECTION_EVENT_OP, {
				arg2 = 0,
				cmd = ActivityConst.COLLETION_EVENT_OP_JOIN,
				arg1 = var_1_1,
				arg_list = var_1_2,
				event = var_1_0
			})
		else
			pg.ConnectionMgr.GetInstance():Send(13003, {
				id = var_1_1,
				ship_id_list = var_1_2
			}, 13004, function(arg_3_0)
				if arg_3_0.result == 0 then
					EventStartCommand.OnStart(var_1_0)
				else
					pg.TipsMgr.GetInstance():ShowTips(errorTip("event_start_fail", arg_3_0.result))
				end

				return
			end)
		end

		return
	end

	local var_1_8 = var_1_0:getOilConsume()

	if var_1_8 > 0 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("event_oil_consume", var_1_8),
			onYes = var_1_7
		})
	else
		var_1_7()
	end

	return
end

function EventStartCommand:OnStart()
	pg.TipsMgr.GetInstance():ShowTips(i18n("event_start_success"))

	local var_4_0 = getProxy(PlayerProxy)
	local var_4_1 = var_4_0:getData()

	var_4_1:consume({
		oil = self:getOilConsume()
	})
	var_4_0:updatePlayer(var_4_1)

	self.finishTime = pg.TimeMgr.GetInstance():GetServerTime() + self.template.collect_time

	getProxy(EventProxy):updateInfoList({
		self
	})

	return
end

return EventStartCommand

local var_0_0 = class("BuildShipBluePrintCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_2 = getProxy(TechnologyProxy)
	local var_1_3 = var_1_2:getBluePrintById(var_1_0.id)
	local var_1_4, var_1_5 = var_1_2:getBluePrintById(var_1_0.id):isFinishPrevTask()

	if not var_1_5 then
		pg.TipsMgr.GetInstance():ShowTips("without finish pre task")

		return
	end

	local var_1_6 = var_1_2:getColdTime()
	local var_1_7 = pg.TimeMgr.GetInstance():GetServerTime()

	if var_1_7 < var_1_6 then
		local var_1_8 = var_1_6 - var_1_7

		var_1_8 = var_1_6 - var_1_7 < 0 and 0 or var_1_8

		local var_1_9 = math.floor(var_1_8 / 0)
		local var_1_10

		if var_1_9 > 0 then
			var_1_10 = i18n("time_remaining_tip") .. var_1_9 .. i18n("word_date")
		else
			local var_1_11 = math.floor(var_1_8 / 16)

			if var_1_11 > 0 then
				var_1_10 = i18n("time_remaining_tip") .. var_1_11 .. i18n("word_hour")
			else
				local var_1_12 = math.floor(var_1_8 / 60)

				var_1_10 = var_1_12 > 0 and i18n("time_remaining_tip") .. var_1_12 .. i18n("word_minute") or i18n("time_remaining_tip") .. var_1_8 .. i18n("word_second")
			end
		end

		pg.TipsMgr.GetInstance():ShowTips(i18n("blueprint_cannot_build_tip", var_1_10))

		return
	end

	local var_1_13 = {}

	if var_1_2:getBuildingBluePrint() then
		table.insert(var_1_13, function(arg_2_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("cannot_build_multiple_printblue", var_0:getShipVO():getConfig("name"), var_1_3:getShipVO():getConfig("name")),
				onYes = function()
					arg_1_0:sendNotification(GAME.STOP_BLUEPRINT, {
						id = var_0.id,
						callback = arg_2_0
					})

					return
				end
			})

			return
		end)
	else
		table.insert(var_1_13, function(arg_4_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("blueprint_build_time_tip"),
				onYes = arg_4_0
			})

			return
		end)
	end

	seriesAsync(var_1_13, function()
		pg.ConnectionMgr.GetInstance():Send(63200, {
			blueprint_id = var_0
		}, 63201, function(arg_6_0)
			if arg_6_0.result == 0 then
				var_1_2:updateColdTime()
				var_1_3:start(arg_6_0.time)
				var_1_2:updateBluePrint(var_1_3)
				arg_1_0:sendNotification(GAME.BUILD_SHIP_BLUEPRINT_DONE)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("printblue_build_erro") .. arg_6_0.result)
			end

			return
		end)

		return
	end)

	return
end

return var_0_0

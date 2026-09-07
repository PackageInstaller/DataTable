local ActivityLinerOPCommand = class("ActivityLinerOPCommand", pm.SimpleCommand)

function ActivityLinerOPCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = getProxy(ActivityProxy)
	local var_1_3 = var_1_2:getActivityById(var_1_0.activity_id)

	if not var_1_3 or var_1_3:isEnd() then
		return
	end

	local var_1_4 = var_1_0.drop

	if var_1_0.drop then
		local var_1_5 = getProxy(PlayerProxy):getData()

		if var_1_4.type == DROP_TYPE_RESOURCE and var_1_4.id == 1 and var_1_5:GoldMax(var_1_4.count) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title"))

			return
		end

		if var_1_4.type == DROP_TYPE_RESOURCE and var_1_4.id == 2 and var_1_5:OilMax(var_1_4.count) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("oil_max_tip_title"))

			return
		end

		if var_1_4.type == DROP_TYPE_ITEM then
			local var_1_6 = Item.getConfigData(var_1_4.id)

			if var_1_6.type == Item.EXP_BOOK_TYPE then
				if getProxy(BagProxy):getItemCountById(var_1_4.id) + var_1_4.count > var_1_6.max_num then
					pg.TipsMgr.GetInstance():ShowTips(i18n("expbook_max_tip_title"))

					return
				end
			end
		end
	end

	local var_1_7 = {
		activity_id = var_1_0.activity_id
	}

	var_1_7.cmd = var_1_0.cmd or 0
	var_1_7.arg1 = var_1_0.arg1 or 0
	var_1_7.arg2 = var_1_0.arg2 or 0
	var_1_7.arg_list = {}

	pg.ConnectionMgr.GetInstance():Send(11202, var_1_7, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_1 = PlayerConst.addTranDrop(arg_2_0.award_list)

			if var_1_0.cmd == 1 then
				switch(var_1_3:GetCurTime():GetType(), {
					[LinerTime.TYPE.TARGET] = function()
						return
					end,
					[LinerTime.TYPE.EXPLORE] = function()
						var_1_3:AddExploredRoom(var_1_0.arg1)

						return
					end,
					[LinerTime.TYPE.EVENT] = function()
						var_1_3:AddEvent(var_1_0.arg1, var_1_0.arg2)

						return
					end,
					[LinerTime.TYPE.STORY] = function()
						return
					end
				})

				if var_1_3:CheckTimeFinish() then
					var_1_3:UpdateTimeIdx()
					var_1_3:UpdateRoomIdx(true)
				end

				if var_1_3:CheckRoomFinish() then
					var_1_3:UpdateRoomIdx(false)
				end
			elseif var_1_0.cmd == 2 then
				var_1_3:AddTimeAwardFlag(var_1_0.arg1)
			elseif var_1_0.cmd == 3 then
				var_1_3:AddRoomAwardFlag(var_1_0.arg1)
			elseif var_1_0.cmd == 4 then
				var_1_3:AddEventAwardFlag(var_1_0.arg1, var_1_0.arg2)
			end

			var_1_2:updateActivity(var_1_3)

			if var_1_1 then
				var_1_1()
			end

			self:sendNotification(GAME.ACTIVITY_LINER_OP_DONE, {
				awards = var_2_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return ActivityLinerOPCommand

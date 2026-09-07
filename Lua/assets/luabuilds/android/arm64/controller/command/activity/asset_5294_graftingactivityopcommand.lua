local GraftingActivityOpCommand = class("GraftingActivityOpCommand", pm.SimpleCommand)

function GraftingActivityOpCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = getProxy(ActivityProxy)
	local var_1_3 = var_1_2:getActivityById(var_1_0.id)

	if not var_1_3 or var_1_3:isEnd() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

		return
	end

	local var_1_4 = var_1_3:getConfig("config_id")
	local var_1_5 = var_1_2:getActivityById(var_1_4)

	if var_1_5 and not var_1_5:isEnd() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_not_start"))

		return
	end

	local var_1_6 = pg.activity_template[var_1_4].type
	local var_1_7 = {
		activity_id = var_1_0.id
	}

	var_1_7.cmd = var_1_0.cmd or 0
	var_1_7.arg1 = var_1_0.arg1 or 0
	var_1_7.arg2 = var_1_0.arg2 or 0
	var_1_7.arg_list = {}

	pg.ConnectionMgr.GetInstance():Send(11202, var_1_7, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0

			if self:IsBuildShipType(var_1_6) then
				self:UpdateActivityForBuildShip(var_1_1)

				var_2_0 = {
					linkActType = var_1_6
				}
			end

			var_2_0.awards = PlayerConst.addTranDrop(arg_2_0.award_list)

			self:sendNotification(GAME.GRAFTING_ACT_OP_DONE, var_2_0)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

function GraftingActivityOpCommand:IsBuildShipType(arg_3_1)
	return arg_3_1 == ActivityConst.ACTIVITY_TYPE_BUILDSHIP_1 or arg_3_1 == ActivityConst.ACTIVITY_TYPE_BUILD or arg_3_1 == ActivityConst.ACTIVITY_TYPE_NEWSERVER_BUILD
end

function GraftingActivityOpCommand:UpdateActivityForBuildShip(arg_4_1)
	local var_4_0 = getProxy(ActivityProxy)
	local var_4_1 = var_4_0:getActivityById(arg_4_1)

	var_4_1.data2 = var_4_1.data2 + 1

	var_4_0:updateActivity(var_4_1)

	return
end

return GraftingActivityOpCommand

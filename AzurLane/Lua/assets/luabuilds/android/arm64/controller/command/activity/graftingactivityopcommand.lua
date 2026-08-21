local var_0_0 = class("GraftingActivityOpCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
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

	;({
		activity_id = var_1_0.id
	}).cmd = var_1_0.cmd or 0
	;({
		activity_id = var_1_0.id
	}).arg1 = var_1_0.arg1 or 0
	;({
		activity_id = var_1_0.id
	}).arg2 = var_1_0.arg2 or 0
	;({
		activity_id = var_1_0.id
	}).arg_list = {}

	pg.ConnectionMgr.GetInstance():Send(11202, {
		activity_id = var_1_0.id
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			if arg_1_0:IsBuildShipType(var_1_6) then
				arg_1_0:UpdateActivityForBuildShip(var_1_1)
			end

			;({
				linkActType = var_1_6
			}).awards = PlayerConst.addTranDrop(arg_2_0.award_list)

			arg_1_0:sendNotification(GAME.GRAFTING_ACT_OP_DONE, {
				linkActType = var_1_6
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

function var_0_0.IsBuildShipType(arg_3_0, arg_3_1)
	return arg_3_1 == ActivityConst.ACTIVITY_TYPE_BUILDSHIP_1 or arg_3_1 == ActivityConst.ACTIVITY_TYPE_BUILD or arg_3_1 == ActivityConst.ACTIVITY_TYPE_NEWSERVER_BUILD
end

function var_0_0.UpdateActivityForBuildShip(arg_4_0, arg_4_1)
	local var_4_0 = getProxy(ActivityProxy)
	local var_4_1 = var_4_0:getActivityById(arg_4_1)

	var_4_1.data2 = var_4_1.data2 + 1

	var_4_0:updateActivity(var_4_1)

	return
end

return var_0_0

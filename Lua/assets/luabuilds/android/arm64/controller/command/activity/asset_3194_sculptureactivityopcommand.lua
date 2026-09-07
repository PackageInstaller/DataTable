local SculptureActivityOpCommand = class("SculptureActivityOpCommand", pm.SimpleCommand)

function SculptureActivityOpCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.state
	local var_1_3 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SCULPTURE)

	if not var_1_3 or var_1_3:isEnd() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

		return
	end

	local var_1_4 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)

	if not var_1_4 or var_1_4:isEnd() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

		return
	end

	if not var_1_3:CanEnterState(var_1_0.id, var_1_0.state) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_error"))

		return
	end

	if var_1_0.state == SculptureActivity.STATE_UNLOCK then
		local var_1_5, var_1_6 = var_1_3:_GetComsume(var_1_0.id)

		if var_1_6 > var_1_4:getVitemNumber(var_1_5) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("gift_act_tips", pg.activity_workbench_item[var_1_5].name))

			return
		end
	end

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 1,
		activity_id = var_1_3.id,
		arg1 = var_1_0.id,
		arg2 = var_1_0.state,
		arg_list = {},
		arg_list2 = {},
		kvargs1 = {}
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_2 == SculptureActivity.STATE_UNLOCK then
				local var_2_0, var_2_1 = var_1_3:_GetComsume(var_1_1)
				local var_2_2 = var_1_4:getVitemNumber(var_2_0)

				var_1_4:addVitemNumber(var_2_0, 0 - var_2_1)
				getProxy(ActivityProxy):updateActivity(var_1_4)
			end

			var_1_3:UpdateState(var_1_1, var_1_2)
			getProxy(ActivityProxy):updateActivity(var_1_3)
			self:sendNotification(GAME.SCULPTURE_ACT_OP_DONE, {
				state = var_1_2,
				activity = var_1_3,
				id = var_1_1,
				awards = PlayerConst.addTranDrop(arg_2_0.award_list)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return SculptureActivityOpCommand

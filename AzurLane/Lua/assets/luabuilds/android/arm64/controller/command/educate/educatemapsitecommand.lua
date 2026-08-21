local var_0_0 = class("EducateMapSiteCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_2

	if var_1_0 then
		::label_1_0::

		local var_1_1 = var_1_0.callback

		var_1_2 = var_1_0.optionVO.id
	end

	local var_1_3 = var_1_0.optionVO:GetCost()
	local var_1_4 = getProxy(EducateProxy):GetCharData()
	local var_1_5 = {}

	if #var_1_3 > 0 then
		for iter_1_0, iter_1_1 in ipairs(var_1_3) do
			assert(iter_1_1[1] == EducateConst.DROP_TYPE_RES, "child_site_option的cost只支持资源类型，请检查id:" .. var_1_2)

			if var_1_4[EducateChar.RES_ID_2_NAME[iter_1_1[2]]] < iter_1_1[3] then
				pg.TipsMgr.GetInstance():ShowTips(i18n("child_no_resource"))

				return
			end

			table.insert(var_1_5, {
				id = iter_1_1[2],
				num = iter_1_1[3]
			})
		end
	end

	pg.ConnectionMgr.GetInstance():Send(27004, {
		siteid = var_1_0.siteId,
		optionid = var_1_2
	}, 27005, function(arg_2_0)
		if arg_2_0.result == 0 then
			EducateHelper.UpdateDropsData(arg_2_0.drops)
			EducateHelper.UpdateDropsData(arg_2_0.event_drops)
			getProxy(EducateProxy):ReduceResForCosts(var_1_5)
			var_0:ReduceCnt()
			getProxy(EducateProxy):UpdateOptionData(var_0)
			arg_1_0:sendNotification(GAME.EDUCATE_MAP_SITE_DONE, {
				optionId = var_1_2,
				drops = arg_2_0.drops,
				eventDrops = arg_2_0.event_drops,
				events = arg_2_0.events,
				branchId = arg_2_0.branch_id
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("educate map site error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0

class = var_0_10000

local var_0_0 = "EducateMapSiteCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	var_1_0 = arg_1_1:getBody() and var_2.callback

	local var_1_1 = var_2.optionVO.id
	local var_1_2 = var_4:GetCost()

	getProxy = var_1_10007
	EducateProxy = var_1_10009

	local var_1_3 = var_1_10007(var_1_10009)
	local var_1_4 = var_7.GetCharData(var_1_3)
	local var_1_5 = {}

	if #var_1_2 > 0 then
		ipairs = var_9

		for iter_1_0, iter_1_1 in var_9(var_1_2) do
			assert = var_1_10014

			local var_1_6 = iter_1_1[1]

			EducateConst = var_1_10017

			var_1_10014(var_1_6 == var_1_10017.DROP_TYPE_RES, "child_site_option的cost只支持资源类型，请检查id:" .. var_1_1)

			EducateChar = var_1_10014

			if var_1_4[var_1_10014.RES_ID_2_NAME[iter_1_1[2]]] < iter_1_1[3] then
				pg = var_1_10014

				local var_1_7 = var_1_10014.TipsMgr.GetInstance()

				var_1_10014 = var_1_10014.ShowTips
				i18n = var_1_10017

				var_1_10014(var_1_7, var_1_10017("child_no_resource"))

				return
			end

			table = var_1_10014

			var_1_10014.insert(var_1_5, {
				id = iter_1_1[2],
				num = iter_1_1[3]
			})
		end
	end

	pg = var_9

	local var_1_8 = var_9.ConnectionMgr.GetInstance()

	var_9.Send(var_1_8, 27004, {
		siteid = var_2.siteId,
		optionid = var_1_1
	}, 27005, function(arg_2_0)
		local var_2_4

		if arg_2_0.result == 0 then
			EducateHelper = var_2_4

			var_2_4.UpdateDropsData(arg_2_0.drops)

			EducateHelper = var_2_4

			var_2_4.UpdateDropsData(arg_2_0.event_drops)

			getProxy = var_2_4
			EducateProxy = var_3

			local var_2_0 = var_2_4(var_3)

			var_2_4.ReduceResForCosts(var_2_0, var_1_5)

			local var_2_1 = var_0

			var_2_4.ReduceCnt(var_2_1)

			getProxy = var_2_4
			EducateProxy = var_2_1

			local var_2_2 = var_2_4(var_2_1)

			var_2_4.UpdateOptionData(var_2_2, var_0)

			local var_2_3 = arg_1_0

			var_2_4 = var_2_4.sendNotification
			GAME = var_2_10004

			var_2_4(var_2_3, var_2_10004.EDUCATE_MAP_SITE_DONE, {
				optionId = var_1_1,
				drops = arg_2_0.drops,
				eventDrops = arg_2_0.event_drops,
				events = arg_2_0.events,
				branchId = arg_2_0.branch_id
			})
		else
			pg = var_2_4

			local var_2_5 = var_2_4.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_6(var_2_5, var_2_10004("educate map site error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1

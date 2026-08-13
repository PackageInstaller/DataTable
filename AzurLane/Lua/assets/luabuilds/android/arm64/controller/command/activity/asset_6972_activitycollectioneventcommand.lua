class = var_0_10000

local var_0_0 = "ActivityCollectionEventCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().event
	local var_1_1 = var_2.arg1
	local var_1_2 = var_2.onConfirm
	local var_1_3 = var_2.callBack

	getProxy = var_1_10007
	EventProxy = var_1_10009

	local var_1_4 = var_1_10007(var_1_10009)

	getProxy = var_1_10008
	ActivityProxy = var_1_10010

	local var_1_5 = var_1_10008(var_1_10010)
	local var_1_6 = var_8.getActivityByType

	ActivityConst = var_1_10012

	if not var_1_6(var_1_5, var_1_10012.ACTIVITY_TYPE_COLLECTION_EVENT) or var_9:isEnd() then
		pg = var_1_10010

		local var_1_7 = var_1_10010.TipsMgr.GetInstance()

		var_1_10010 = var_1_10010.ShowTips
		i18n = var_1_10013

		var_1_10010(var_1_7, var_1_10013("common_activity_end"))

		return
	end

	pg = var_1_10010

	local var_1_8 = var_1_10010.ConnectionMgr.GetInstance()

	var_10.Send(var_1_8, 11202, {
		activity_id = var_9.id,
		cmd = var_2.cmd,
		arg1 = var_2.arg1,
		arg2 = var_2.arg2,
		arg_list = var_2.arg_list
	}, 11203, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = var_0.cmd
			ActivityConst = var_2_10002

			if var_2_0 == var_2_10002.COLLETION_EVENT_OP_JOIN then
				EventStartCommand = var_2_0

				var_2_0.OnStart(var_1_0)

				if var_1_3 then
					var_1_3()
				end

				if var_1_2 then
					var_1_2()
				end
			else
				var_2_0 = var_0.cmd
				ActivityConst = var_2

				if var_2_0 == var_2.COLLETION_EVENT_OP_SUBMIT then
					table = var_2_0

					var_2_0.insert(var_0.data1_list, var_1_1)

					local var_2_1 = var_0

					var_2_0.updateActivity(var_2_1, var_0)

					EventFinishCommand = var_2_0

					var_2_0.OnFinish(var_1_1, {
						exp = arg_2_0.number[1],
						drop_list = arg_2_0.award_list,
						new_collection = {},
						is_cri = arg_2_0.number[2]
					}, var_1_2)

					getProxy = var_2_0
					EventProxy = var_3

					local var_2_2 = var_2_0(var_3)

					var_2_0.CheckAddActivityEvent(var_2_2)

					if var_1_3 then
						var_1_3()
					end
				else
					var_2_0 = var_0.cmd
					ActivityConst = var_2

					if var_2_0 == var_2.COLLETION_EVENT_OP_GIVE_UP then
						EventGiveUpCommand = var_2_0

						var_2_0.OnCancel(var_1_1)

						getProxy = var_2_0
						EventProxy = var_3

						local var_2_3 = var_2_0(var_3)

						var_2_0.CheckAddActivityEvent(var_2_3)

						if var_1_3 then
							var_1_3()
						end

						if var_1_2 then
							var_1_2()
						end
					end
				end
			end
		else
			pg = var_2_0

			local var_2_4 = var_2_0.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_5(var_2_4, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1

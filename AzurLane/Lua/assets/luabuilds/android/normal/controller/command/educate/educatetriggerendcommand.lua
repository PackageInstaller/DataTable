class = var_0_10000

local var_0_0 = "EducateTriggerEndCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	var_1_0 = arg_1_1:getBody() and var_2.callback

	local var_1_1 = var_2.ids
	local var_1_2 = var_2.selId

	pg = var_1_10006

	local var_1_3 = var_1_10006.child_ending[var_1_2].performance

	pg = var_1_10007

	local var_1_4 = var_1_10007.ConnectionMgr.GetInstance()

	var_7.Send(var_1_4, 27008, {
		ending_id = var_1_2,
		qualified_id = var_1_1
	}, 27009, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			getProxy = var_2_2
			EducateProxy = var_2_10002

			local var_2_0 = var_2_2(var_2_10002)

			var_2_2.AddEnding(var_2_0, var_1_2, var_1_1)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10003

			var_2_2(var_2_1, var_2_10003.EDUCATE_TRIGGER_END_DONE)

			pg = var_2_2

			local var_2_3 = var_2_2.PerformMgr.GetInstance()

			var_2_2.PlayGroup(var_2_3, var_1_3, function()
				pg = var_3_10000

				local var_3_0 = var_3_10000.PerformMgr.GetInstance()
				local var_3_1 = var_0.PlayOne

				EducateConst = var_3_10002

				var_3_1(var_3_0, var_3_10002.AFTER_END_PERFORM, function()
					getProxy = var_4_10000
					EducateProxy = var_4_10001

					local var_4_0 = var_4_10000(var_4_10001)

					var_0.CheckGuide(var_4_0, "EducateScene", true)

					return
				end)

				return
			end)
		else
			pg = var_2_2

			local var_2_4 = var_2_2.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_5(var_2_4, var_2_10003("educate trigger end error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1

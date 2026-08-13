class = var_0_10000

local var_0_0 = "UpdateCustomFleetCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().chapterId

	getProxy = var_1_10004
	BayProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.getRawData(var_1_1)

	getProxy = var_1_1
	ChapterProxy = var_1_10007

	local var_1_3 = var_1_1(var_1_10007)
	local var_1_4 = var_6.getChapterById(var_1_3, var_1_0)

	Chapter = var_1_3

	local var_1_5 = var_1_3.PackEliteFleetInfo(var_1_4.eliteFleetList)

	pg = var_9

	local var_1_6 = var_9.ConnectionMgr.GetInstance()

	var_9.Send(var_1_6, 13107, {
		id = var_1_0,
		fleet = var_1_5
	}, 13108, function(arg_2_0)
		if arg_2_0.result == 0 then
			-- block empty
		else
			pg = var_1

			local var_2_0 = var_1.TipsMgr.GetInstance()
			local var_2_1 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_1(var_2_0, var_2_10003("update_custom_fleet", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1

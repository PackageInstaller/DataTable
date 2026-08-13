class = var_0_10000

local var_0_0 = "UpdateCustomFleetCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).chapterId

	getProxy = var_1_0
	BayProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.getRawData(var_1_2)

	getProxy = var_1_10006
	ChapterProxy = var_1_10008

	local var_1_4 = var_1_10006(var_1_10008)
	local var_1_5 = var_6.getChapterById(var_1_4, var_1_1)

	Chapter = var_1_10008

	local var_1_6 = var_1_10008.PackEliteFleetInfo(var_1_5.eliteFleetList)

	pg = var_1_4

	local var_1_7 = var_1_4.ConnectionMgr.GetInstance()

	var_9.Send(var_1_7, 13107, {
		id = var_1_1,
		fleet = var_1_6
	}, 13108, function(arg_2_0)
		if arg_2_0.result == 0 then
			-- block empty
		else
			pg = var_1

			local var_2_0 = var_1.TipsMgr.GetInstance()
			local var_2_1 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_1(var_2_0, var_2_10004("update_custom_fleet", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1

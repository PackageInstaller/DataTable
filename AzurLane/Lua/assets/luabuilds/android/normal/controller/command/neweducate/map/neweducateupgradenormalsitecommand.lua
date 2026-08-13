class = var_0_10000

local var_0_0 = "NewEducateUpgradeNormalSiteCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody() and var_2.callback
	local var_1_1 = var_2.id
	local var_1_2 = var_2.normalId

	getProxy = var_1_10006
	NewEducateProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)
	local var_1_4 = var_6.GetCurChar(var_1_3)
	local var_1_5 = var_6.GetFSM(var_1_4)
	local var_1_7

	if var_6.CheckPriorityStystem(var_1_5) then
		pg = var_1_7

		local var_1_6 = var_1_7.TipsMgr.GetInstance()

		var_1_7 = var_1_7.ShowTips
		i18n = var_1_10008

		var_1_7(var_1_6, var_1_10008("child2_priority_tip"))

		return
	end

	pg = var_1_7

	local var_1_8 = var_1_7.ConnectionMgr.GetInstance()

	var_6.Send(var_1_8, 29070, {
		id = var_1_1,
		work_id = var_1_2
	}, 29071, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			pg = var_2_0
			var_2_0 = var_2_0.child2_site_normal[var_1_2]
			pg = var_2

			local var_2_1 = var_2.child2_site_normal.get_id_list_by_character[var_1_1]

			underscore = var_3

			local var_2_2 = var_3.detect(var_2_1, function(arg_3_0)
				pg = var_3_10001

				return var_3_10001.child2_site_normal[arg_3_0].type == var_2_0.type and var_1.site_lv == var_2_0.site_lv + 1
			end)

			getProxy = var_4
			NewEducateProxy = var_5

			local var_2_3 = var_4(var_5)
			local var_2_4 = var_4.GetCurChar(var_2_3)

			var_4.UpdateNormalType2Id(var_2_4, var_2_0.type, var_2_2)

			existCall = var_4

			var_4(var_1_0)
		else
			pg = var_2_0

			local var_2_5 = var_2_0.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_5, "NewEducate_UpgradeNormalSite: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1

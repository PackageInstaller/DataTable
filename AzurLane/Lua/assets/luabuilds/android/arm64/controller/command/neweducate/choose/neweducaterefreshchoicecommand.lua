class = var_0_10000

local var_0_0 = "NewEducateRefreshChoiceCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.idx

	getProxy = var_1_10005
	NewEducateProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)
	local var_1_3 = var_5.GetCurChar(var_1_2)
	local var_1_4 = var_5.GetResByType

	NewEducateChar = var_1_10009

	local var_1_6

	if var_1_4(var_1_3, var_1_10009.RES_TYPE.REFRESH_CHOICE) <= 0 then
		pg = var_1_6

		local var_1_5 = var_1_6.TipsMgr.GetInstance()

		var_1_6 = var_1_6.ShowTips
		i18n = var_1_10010

		var_1_6(var_1_5, var_1_10010("common_no_resource"))

		return
	end

	pg = var_1_6

	local var_1_7 = var_1_6.ConnectionMgr.GetInstance()

	var_7.Send(var_1_7, 29105, {
		id = var_1_0,
		index = var_1_1
	}, 29106, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			NewEducateProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)
			local var_2_1 = var_1.GetCurChar(var_2_0)
			local var_2_2 = var_1.GetFSM(var_2_1)
			local var_2_3 = var_1.GetPriorityState(var_2_2)

			var_2.UpdataData(var_2_3, arg_2_0.cache)

			getProxy = var_3
			NewEducateProxy = var_2_3

			local var_2_4 = var_3(var_2_3)
			local var_2_5 = var_3.Cost
			local var_2_6 = {
				number = 1
			}

			NewEducateConst = var_2_10007
			var_2_6.type = var_2_10007.DROP_TYPE.RES

			local var_2_7 = var_0
			local var_2_8 = var_7.GetResIdByType

			NewEducateChar = var_2_10010
			var_2_6.id = var_2_8(var_2_7, var_2_10010.RES_TYPE.REFRESH_CHOICE)

			var_2_5(var_2_4, var_2_6)

			local var_2_9 = arg_1_0
			local var_2_10 = var_3.sendNotification

			GAME = var_2_6

			var_2_10(var_2_9, var_2_6.NEW_EDUCATE_REFRESH_CHOICE_DONE, {
				idx = var_1_1,
				newId = var_2:GetChoices()[var_1_1]
			})
		else
			pg = var_1

			local var_2_11 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_11, "NewEducate_RefreshChoice_Error: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1

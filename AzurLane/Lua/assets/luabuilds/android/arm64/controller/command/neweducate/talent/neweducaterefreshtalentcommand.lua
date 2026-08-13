class = var_0_10000

local var_0_0 = "NewEducateRefreshTalentCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.talentId
	local var_1_2 = var_2.idx

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 29021, {
		id = var_1_0,
		talent = var_1_1
	}, 29022, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			NewEducateProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)
			local var_2_1 = var_1.GetCurChar(var_2_0)
			local var_2_2 = var_1.GetFSM(var_2_1)
			local var_2_3 = var_1.GetState

			NewEducateFSM = var_2_10005

			local var_2_4 = var_2_3(var_2_2, var_2_10005.SYSTEM.TALENT)

			var_2.OnRefreshTalent(var_2_4, var_1_1, arg_2_0.talent)

			local var_2_5 = arg_1_0
			local var_2_6 = var_3.sendNotification

			GAME = var_6

			var_2_6(var_2_5, var_6.NEW_EDUCATE_REFRESH_TALENT_DONE, {
				idx = var_1_2,
				newId = arg_2_0.talent
			})
		else
			pg = var_1

			local var_2_7 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_7, "NewEducate_RefreshTalent: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1

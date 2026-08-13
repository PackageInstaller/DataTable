class = var_0_10000

local var_0_0 = "NewEducateMapNormalCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.normalId

	getProxy = var_1_10005
	NewEducateProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.GetCurChar(var_1_2)
	local var_1_4 = var_5.GetFSM(var_1_3)
	local var_1_6

	if var_5.CheckPriorityStystem(var_1_4) then
		pg = var_1_6

		local var_1_5 = var_1_6.TipsMgr.GetInstance()

		var_1_6 = var_1_6.ShowTips
		i18n = var_1_10007

		var_1_6(var_1_5, var_1_10007("child2_priority_tip"))

		return
	end

	pg = var_1_6

	local var_1_7 = var_1_6.ConnectionMgr.GetInstance()

	var_5.Send(var_1_7, 29062, {
		id = var_1_0,
		work_id = var_1_1
	}, 29063, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			NewEducateProxy = var_2_10002
			var_2_0 = var_2_0(var_2_10002)
			pg = var_2_10002

			local var_2_1 = var_2_10002.child2_site_normal[var_1_1].cost
			local var_2_2 = var_2_0
			local var_2_3 = var_2_0.Cost

			NewEducateHelper = var_2_10005

			var_2_3(var_2_2, var_2_10005.Config2Drop(var_2_1))

			local var_2_4 = var_2_0:GetCurChar()

			var_3.AddNormalRecord(var_2_4, var_1_1)

			local var_2_5 = var_3:GetFSM()

			var_4.SetCurNode(var_2_5, arg_2_0.first_node)

			local var_2_6 = var_4
			local var_2_7 = var_4.SetSystemNo

			NewEducateFSM = var_7

			var_2_7(var_2_6, var_7.SYSTEM.MAP)

			local var_2_8 = var_4
			local var_2_9 = var_4.GetState

			NewEducateFSM = var_7

			local var_2_10 = var_2_9(var_2_8, var_7.SYSTEM.MAP)
			local var_2_11 = var_5.SetSiteState
			local var_2_12 = {}

			NewEducateConst = var_2_10009
			var_2_12.key = var_2_10009.SITE_STATE_TYPE.NORMAL
			var_2_12.value = var_1_1

			var_2_11(var_2_10, var_2_12)

			NewEducateDropHelper = var_2_11

			local var_2_13 = var_2_11.HandleDrops(arg_2_0.drop)
			local var_2_14 = arg_1_0
			local var_2_15 = var_7.sendNotification

			GAME = var_9

			var_2_15(var_2_14, var_9.NEW_EDUCATE_MAP_NORMAL_DONE, {
				drops = var_2_13,
				node = arg_2_0.first_node
			})

			pg = var_2_15

			local var_2_16 = var_2_15.m02
			local var_2_17 = var_7.sendNotification

			GAME = var_9

			local var_2_18 = var_9.NEW_EDUCATE_TRACK

			NewEducateTrackCommand = var_10

			var_2_17(var_2_16, var_2_18, var_10.BuildDataSite(var_3.id, var_3:GetGameCnt(), var_3:GetRoundData().round, 1, var_1_1))
		else
			pg = var_2_0

			local var_2_19 = var_2_0.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_19, "NewEducate_MapNormal: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1

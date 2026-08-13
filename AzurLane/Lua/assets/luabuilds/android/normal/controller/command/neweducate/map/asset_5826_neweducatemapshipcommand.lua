class = var_0_10000

local var_0_0 = "NewEducateMapShipCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.shipId

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

	var_5.Send(var_1_7, 29068, {
		id = var_1_0,
		character = var_1_1
	}, 29069, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			NewEducateProxy = var_2_10002
			var_2_0 = var_2_0(var_2_10002)
			pg = var_2_10002

			local var_2_1 = var_2_10002.child2_site_character[var_1_1]
			local var_2_2 = var_2_0
			local var_2_3 = var_2_0.Cost

			NewEducateHelper = var_2_10005

			var_2_3(var_2_2, var_2_10005.Config2Drop(var_2_1.cost))

			pg = var_2_3

			local var_2_4 = var_2_3.child2_site_character.get_id_list_by_group[var_2_1.group]

			underscore = var_4

			if var_4.detect(var_2_4, function(arg_3_0)
				pg = var_3_10001

				return var_3_10001.child2_site_character[arg_3_0].level == var_2_1.level + 1
			end) then
				local var_2_5 = var_2_0:GetCurChar()

				var_5.UpdateShipId(var_2_5, var_1_1, var_4)
			end

			local var_2_6 = var_2_0:GetCurChar()
			local var_2_7 = var_5.GetFSM(var_2_6)

			var_6.SetCurNode(var_2_7, arg_2_0.first_node)

			local var_2_8 = var_6
			local var_2_9 = var_6.SetSystemNo

			NewEducateFSM = var_9

			var_2_9(var_2_8, var_9.SYSTEM.MAP)

			local var_2_10 = var_6
			local var_2_11 = var_6.GetState

			NewEducateFSM = var_9

			local var_2_12 = var_2_11(var_2_10, var_9.SYSTEM.MAP)
			local var_2_13 = var_7.SetSiteState
			local var_2_14 = {}

			NewEducateConst = var_2_10011
			var_2_14.key = var_2_10011.SITE_STATE_TYPE.SHIP
			var_2_14.value = var_1_1

			var_2_13(var_2_12, var_2_14)

			if var_4 then
				var_7:AddSelectedShip(var_4)
			end

			NewEducateDropHelper = var_2_13

			local var_2_15 = var_2_13.HandleDrops(arg_2_0.drop)
			local var_2_16 = arg_1_0
			local var_2_17 = var_9.sendNotification

			GAME = var_11

			var_2_17(var_2_16, var_11.NEW_EDUCATE_MAP_SHIP_DONE, {
				drops = var_2_15,
				node = arg_2_0.first_node
			})

			pg = var_2_17

			local var_2_18 = var_2_17.m02
			local var_2_19 = var_9.sendNotification

			GAME = var_11

			local var_2_20 = var_11.NEW_EDUCATE_TRACK

			NewEducateTrackCommand = var_12

			var_2_19(var_2_18, var_2_20, var_12.BuildDataSite(var_5.id, var_5:GetGameCnt(), var_5:GetRoundData().round, 3, var_1_1))
		else
			pg = var_2_0

			local var_2_21 = var_2_0.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_21, "NewEducate_MapShip: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1

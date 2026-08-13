class = var_0_10000

local var_0_0 = "IslandSelectgiftCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().pos
	local var_1_1 = var_2.islandId

	getProxy = var_1_10005
	IslandProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	if not (var_5.GetIsland(var_1_2).id == var_1_1) then
		getProxy = var_1_10007
		IslandProxy = var_1_10008

		local var_1_3 = var_1_10007(var_1_10008)
		local var_1_4 = var_1_10007.GetSharedIsland(var_1_3)
		local var_1_5 = var_1_10007.GetSignInAgency(var_1_4)
		local var_1_6 = var_1_10007.IsFetched

		getProxy = var_1_10010
		PlayerProxy = var_1_10011

		local var_1_7 = var_1_10010(var_1_10011)

		if var_1_6(var_1_5, var_10.getRawData(var_1_7).id) then
			pg = var_8

			local var_1_8 = var_8.TipsMgr.GetInstance()
			local var_1_9 = var_8.ShowTips

			i18n = var_10

			var_1_9(var_1_8, var_10("island_get_git_tip"))

			return
		end

		if var_1_10007:IsMaxFetchCnt() then
			pg = var_8

			local var_1_10 = var_8.TipsMgr.GetInstance()
			local var_1_11 = var_8.ShowTips

			i18n = var_10

			var_1_11(var_1_10, var_10("island_get_git_cnt_tip"))

			return
		end
	end

	pg = var_1_10007

	local var_1_12 = var_1_10007.ConnectionMgr.GetInstance()

	var_7.Send(var_1_12, 21310, {
		island_id = var_1_1,
		pos = var_1_0
	}, 21311, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			IslandDropHelper = var_2_0
			var_2_0 = var_2_0.AddItems(arg_2_0)
			var_2_10003 = var_0

			local var_2_1 = var_2.GetSignInAgency(var_2_10003)

			if var_0 then
				var_2_1:SetFetchCnt()
			else
				var_2_1:SetOtherFetchCnt()
			end

			local var_2_2 = arg_1_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = var_2_10005

			var_2_10003(var_2_2, var_2_10005.ISLAND_SELECT_GIFT_DONE, {
				dropData = var_2_0
			})

			pg = var_2_10003

			local var_2_3 = var_2_10003.GameTrackerMgr.GetInstance()

			var_2_10003 = var_2_10003.Record
			GameTrackerBuilder = var_5

			var_2_10003(var_2_3, var_5.BuildIslandGetGift(var_1_1))
		else
			pg = var_2_0

			local var_2_4 = var_2_0.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_5(var_2_4, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1

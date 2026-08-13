class = var_0_10000

local var_0_0 = "IslandSelectgiftCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().pos
	local var_1_1 = var_2.islandId

	getProxy = var_1_10005
	IslandProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	if not (var_5.GetIsland(var_1_2).id == var_1_1) then
		getProxy = var_1_2
		IslandProxy = var_1_10009

		local var_1_3 = var_1_2(var_1_10009)
		local var_1_4 = var_1_2.GetSharedIsland(var_1_3)
		local var_1_5 = var_1_2.GetSignInAgency(var_1_4)
		local var_1_6 = var_1_2.IsFetched

		getProxy = var_1_10011
		PlayerProxy = var_1_10013

		local var_1_7 = var_1_10011(var_1_10013)

		if var_1_6(var_1_5, var_11.getRawData(var_1_7).id) then
			pg = var_8

			local var_1_8 = var_8.TipsMgr.GetInstance()
			local var_1_9 = var_8.ShowTips

			i18n = var_11

			var_1_9(var_1_8, var_11("island_get_git_tip"))

			return
		end

		if var_1_2:IsMaxFetchCnt() then
			pg = var_8

			local var_1_10 = var_8.TipsMgr.GetInstance()
			local var_1_11 = var_8.ShowTips

			i18n = var_11

			var_1_11(var_1_10, var_11("island_get_git_cnt_tip"))

			return
		end
	end

	pg = var_1_2

	local var_1_12 = var_1_2.ConnectionMgr.GetInstance()

	var_7.Send(var_1_12, 21310, {
		island_id = var_1_1,
		pos = var_1_0
	}, 21311, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			IslandDropHelper = var_2_0
			var_2_0 = var_2_0.AddItems(arg_2_0)
			var_2_10004 = var_0

			local var_2_1 = var_2.GetSignInAgency(var_2_10004)

			if var_0 then
				var_2_1:SetFetchCnt()
			else
				var_2_1:SetOtherFetchCnt()
			end

			local var_2_2 = arg_1_0
			local var_2_3 = var_3.sendNotification

			GAME = var_2_10006

			var_2_3(var_2_2, var_2_10006.ISLAND_SELECT_GIFT_DONE, {
				dropData = var_2_0
			})

			pg = var_2_3

			local var_2_4 = var_2_3.GameTrackerMgr.GetInstance()
			local var_2_5 = var_3.Record

			GameTrackerBuilder = var_6

			var_2_5(var_2_4, var_6.BuildIslandGetGift(var_1_1))
		else
			pg = var_2_0

			local var_2_6 = var_2_0.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_7(var_2_6, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1

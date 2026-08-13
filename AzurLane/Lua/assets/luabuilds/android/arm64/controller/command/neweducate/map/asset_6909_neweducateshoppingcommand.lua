class = var_0_10000

local var_0_0 = "NewEducateShoppingCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.goodId
	local var_1_2 = var_2.num
	local var_1_3 = var_2.isUpgradeEntry
	local var_1_4 = var_2.callback

	getProxy = var_1_10008
	NewEducateProxy = var_1_10010

	local var_1_5 = var_1_10008(var_1_10010)
	local var_1_6 = var_8.GetCurChar(var_1_5)
	local var_1_7 = var_8.GetFSM(var_1_6)
	local var_1_8

	if var_8.CheckPriorityStystem(var_1_7) then
		pg = var_1_8
		var_1_7 = var_1_8.TipsMgr.GetInstance()
		var_1_8 = var_1_8.ShowTips
		i18n = var_1_10011

		var_1_8(var_1_7, var_1_10011("child2_priority_tip"))

		return
	end

	getProxy = var_1_8
	NewEducateProxy = var_1_7

	local var_1_9 = var_1_8(var_1_7)
	local var_1_10 = var_8.GetCurChar(var_1_9)

	NewEducateGoods = var_1_7

	local var_1_11 = var_1_7.New(var_1_1)
	local var_1_12 = var_1_10:GetGoodsDiscountInfos()

	var_12.number = var_1_11:GetCostWithBenefit(var_1_12).number * var_1_2

	local var_1_14

	if not var_1_10:IsMatch(var_12) then
		pg = var_1_14

		local var_1_13 = var_1_14.TipsMgr.GetInstance()

		var_1_14 = var_1_14.ShowTips
		i18n = var_16

		var_1_14(var_1_13, var_16("common_no_resource"))

		return
	end

	pg = var_1_14

	local var_1_15 = var_1_14.ConnectionMgr.GetInstance()

	var_13.Send(var_1_15, 29066, {
		id = var_1_0,
		shop = var_1_1,
		num = var_1_2
	}, 29067, function(arg_2_0)
		local var_2_3

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_3.Cost(var_2_0, var_0)

			local var_2_1 = var_1_10
			local var_2_2 = var_2_3.GetFSM(var_2_1)

			var_2_3 = var_2_3.GetState
			NewEducateFSM = var_4

			local var_2_4 = var_2_3(var_2_2, var_4.SYSTEM.MAP)

			var_2_3.AddBuyCnt(var_2_4, var_1_1, var_1_2)

			NewEducateDropHelper = var_2

			local var_2_5 = var_2.HandleDrops(arg_2_0.drop)
			local var_2_6 = arg_1_0
			local var_2_7 = var_3.sendNotification

			GAME = var_6

			var_2_7(var_2_6, var_6.NEW_EDUCATE_SHOPPING_DONE, {
				drops = var_2_5,
				isUpgradeEntry = var_1_3
			})

			pg = var_2_7

			local var_2_8 = var_2_7.m02
			local var_2_9 = var_3.sendNotification

			GAME = var_6

			local var_2_10 = var_6.NEW_EDUCATE_TRACK

			NewEducateTrackCommand = var_7

			local var_2_11 = var_7.BuildDataSite
			local var_2_12 = var_1_10.id
			local var_2_13 = var_1_10
			local var_2_14 = var_10.GetGameCnt(var_2_13)
			local var_2_15 = var_1_10

			var_2_9(var_2_8, var_2_10, var_2_11(var_2_12, var_2_14, var_11.GetRoundData(var_2_15).round, 4, var_1_1))

			existCall = var_2_9

			var_2_9(var_1_4, var_2_5)
		else
			pg = var_2_3

			local var_2_16 = var_2_3.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_16, "NewEducate_Shopping: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1

class = var_0_10000

local var_0_0 = "NewEducateMapState"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NewEducateStateBase"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.charId = arg_1_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.SetSiteState
	local var_1_2

	if not arg_1_2.state then
		var_1_2 = {}
	end

	var_1_1(var_1_0, var_1_2)

	local var_1_3

	if not arg_1_2.events then
		var_1_3 = {}
	end

	arg_1_0.events = var_1_3

	local var_1_4 = {}

	ipairs = var_1_10004

	local var_1_5

	if not arg_1_2.buys then
		var_1_5 = {}
	end

	for iter_1_0, iter_1_1 in var_1_10004(var_1_5) do
		var_1_4[iter_1_1.key] = iter_1_1.value
	end

	local var_1_6

	if not arg_1_2.shops then
		var_1_6 = {}
	end

	arg_1_0.goods = {}
	ipairs = var_5

	for iter_1_2, iter_1_3 in var_5(var_1_6) do
		local var_1_7 = arg_1_0.goods

		NewEducateGoods = var_1_10011
		var_1_10011 = var_1_10011.New

		local var_1_8 = iter_1_3
		local var_1_9

		if not var_1_4[iter_1_3] then
			var_1_9 = 0
		end

		var_1_7[iter_1_3] = var_1_10011(var_1_8, var_1_9)
	end

	local var_1_10

	if not arg_1_2.character_this_round then
		var_1_10 = {}
	end

	arg_1_0.selectedShip = var_1_10

	local var_1_11

	if not arg_1_2.refresh_count then
		var_1_11 = 0
	end

	arg_1_0.refreshShopCnt = var_1_11

	return
end

function var_0_1.SetSiteState(arg_2_0, arg_2_1)
	if not arg_2_1.key or arg_2_1.key == 0 then
		arg_2_0.curSiteId = 0
	end

	local var_2_0 = 0

	getProxy = var_1_10003
	NewEducateProxy = var_1_10005

	local var_2_1 = var_1_10003(var_1_10005)
	local var_2_2 = var_3.GetChar(var_2_1, arg_2_0.charId)
	local var_2_3 = arg_2_1.key

	NewEducateConst = var_2_1

	if var_2_3 == var_2_1.SITE_STATE_TYPE.EVENT then
		local var_2_4 = var_2_2
		local var_2_5 = var_2_2.GetSiteId

		NewEducateConst = var_1_10007
		arg_2_0.curSiteId = var_2_5(var_2_4, var_1_10007.SITE_TYPE.EVENT, arg_2_1.value)
	else
		local var_2_6 = arg_2_1.key

		NewEducateConst = var_5

		local var_2_8

		if var_2_6 == var_5.SITE_STATE_TYPE.NORMAL then
			pg = var_2_6

			local var_2_7 = var_2_6.child2_site_normal[arg_2_1.value].type

			NewEducateHelper = var_2_8
			var_2_8 = var_2_8.NormalType2SiteType(var_2_7)
			arg_2_0.curSiteId = var_2_2:GetSiteId(var_2_8)
		else
			local var_2_9 = arg_2_1.key

			NewEducateConst = var_2_8

			if var_2_9 == var_2_8.SITE_STATE_TYPE.SHIP then
				local var_2_10 = var_2_2
				local var_2_11 = var_2_2.GetSiteId

				NewEducateConst = var_1_10007
				arg_2_0.curSiteId = var_2_11(var_2_10, var_1_10007.SITE_TYPE.SHIP, arg_2_1.value)
			else
				local var_2_12 = arg_2_1.key

				NewEducateConst = var_5

				if var_2_12 == var_5.SITE_STATE_TYPE.SHOP then
					local var_2_13 = var_2_2
					local var_2_14 = var_2_2.GetSiteId

					NewEducateConst = var_1_10007
					arg_2_0.curSiteId = var_2_14(var_2_13, var_1_10007.SITE_TYPE.SHOP)
				end
			end
		end
	end

	return
end

function var_0_1.GetCurSiteId(arg_3_0)
	return arg_3_0.curSiteId
end

function var_0_1.GetEvents(arg_4_0)
	return arg_4_0.events
end

function var_0_1.FinishEvent(arg_5_0, arg_5_1)
	table = var_1_10002

	var_1_10002.removebyvalue(arg_5_0.events, arg_5_1)

	return
end

function var_0_1.GetGoodList(arg_6_0)
	local var_6_0 = {}

	pairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.goods) do
		table = var_1_10007

		var_1_10007.insert(var_6_0, iter_6_1)
	end

	return var_6_0
end

function var_0_1.AddBuyCnt(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.goods[arg_7_1]

	var_3.AddBuyCnt(var_7_0, arg_7_2)

	return
end

function var_0_1.AddSelectedShip(arg_8_0, arg_8_1)
	table = var_1_10002

	var_1_10002.insert(arg_8_0.selectedShip, arg_8_1)

	return
end

function var_0_1.IsSelectedShip(arg_9_0, arg_9_1)
	table = var_1_10002

	return var_1_10002.contains(arg_9_0.selectedShip, arg_9_1)
end

function var_0_1.IsSpecial(arg_10_0)
	underscore = var_1_10001

	return var_1_10001.any(arg_10_0.events, function(arg_11_0)
		assert = var_2_10001
		pg = var_2_10003

		var_2_10001(var_2_10003.child2_site_event_group[arg_11_0], "child2_site_event_group不存在id" .. arg_11_0)

		pg = var_2_10001

		return #var_2_10001.child2_site_event_group[arg_11_0].performance > 0
	end)
end

function var_0_1.GetRefreshShopCnt(arg_12_0)
	return arg_12_0.refreshShopCnt
end

function var_0_1.OnRefreshShopDone(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 then
		arg_13_0.refreshShopCnt = arg_13_0.refreshShopCnt + 1
	end

	arg_13_0.goods = {}
	ipairs = var_3

	for iter_13_0, iter_13_1 in var_3(arg_13_1) do
		local var_13_0 = arg_13_0.goods

		NewEducateGoods = var_1_10009
		var_13_0[iter_13_1] = var_1_10009.New(iter_13_1)
	end

	return
end

function var_0_1.IsFinish(arg_14_0)
	return true
end

function var_0_1.Reset(arg_15_0)
	arg_15_0.events = {}
	arg_15_0.goods = {}
	arg_15_0.selectedShip = {}
	arg_15_0.refreshShopCnt = 0

	return
end

return var_0_1

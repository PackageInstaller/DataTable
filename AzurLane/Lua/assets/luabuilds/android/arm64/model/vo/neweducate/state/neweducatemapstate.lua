local var_0_0 = class("NewEducateMapState", import(".NewEducateStateBase"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.charId = arg_1_1

	local var_1_0 = arg_1_2.state or {}

	arg_1_0:SetSiteState(var_1_0)

	arg_1_0.events = arg_1_2.events or {}

	local var_1_1 = arg_1_2.buys or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		({})[iter_1_1.key] = iter_1_1.value
	end

	local var_1_2 = arg_1_2.shops or {}

	arg_1_0.goods = {}

	for iter_1_2, iter_1_3 in ipairs(var_1_2) do
		local var_1_4 = ({})[iter_1_3]

		if not ({})[iter_1_3] then
			var_1_4 = 0
		end

		arg_1_0.goods[iter_1_3] = NewEducateGoods.New(iter_1_3, var_1_4)
	end

	arg_1_0.selectedShip = arg_1_2.character_this_round or {}
	arg_1_0.refreshShopCnt = arg_1_2.refresh_count or 0

	return
end

function var_0_0.SetSiteState(arg_2_0, arg_2_1)
	if not arg_2_1.key or arg_2_1.key == 0 then
		arg_2_0.curSiteId = 0
	end

	local var_2_1 = getProxy(NewEducateProxy):GetChar(arg_2_0.charId)

	if arg_2_1.key == NewEducateConst.SITE_STATE_TYPE.EVENT then
		arg_2_0.curSiteId = var_2_1:GetSiteId(NewEducateConst.SITE_TYPE.EVENT, arg_2_1.value)
	elseif arg_2_1.key == NewEducateConst.SITE_STATE_TYPE.NORMAL then
		arg_2_0.curSiteId = var_2_1:GetSiteId((NewEducateHelper.NormalType2SiteType(pg.child2_site_normal[arg_2_1.value].type)))
	elseif arg_2_1.key == NewEducateConst.SITE_STATE_TYPE.SHIP then
		arg_2_0.curSiteId = var_2_1:GetSiteId(NewEducateConst.SITE_TYPE.SHIP, arg_2_1.value)
	elseif arg_2_1.key == NewEducateConst.SITE_STATE_TYPE.SHOP then
		arg_2_0.curSiteId = var_2_1:GetSiteId(NewEducateConst.SITE_TYPE.SHOP)
	end

	return
end

function var_0_0.GetCurSiteId(arg_3_0)
	return arg_3_0.curSiteId
end

function var_0_0.GetEvents(arg_4_0)
	return arg_4_0.events
end

function var_0_0.FinishEvent(arg_5_0, arg_5_1)
	table.removebyvalue(arg_5_0.events, arg_5_1)

	return
end

function var_0_0.GetGoodList(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.goods) do
		table.insert({}, iter_6_1)
	end

	return {}
end

function var_0_0.AddBuyCnt(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.goods[arg_7_1]:AddBuyCnt(arg_7_2)

	return
end

function var_0_0.AddSelectedShip(arg_8_0, arg_8_1)
	table.insert(arg_8_0.selectedShip, arg_8_1)

	return
end

function var_0_0.IsSelectedShip(arg_9_0, arg_9_1)
	return table.contains(arg_9_0.selectedShip, arg_9_1)
end

function var_0_0.IsSpecial(arg_10_0)
	return underscore.any(arg_10_0.events, function(arg_11_0)
		assert(pg.child2_site_event_group[arg_11_0], "child2_site_event_group不存在id" .. arg_11_0)

		return #pg.child2_site_event_group[arg_11_0].performance > 0
	end)
end

function var_0_0.GetRefreshShopCnt(arg_12_0)
	return arg_12_0.refreshShopCnt
end

function var_0_0.OnRefreshShopDone(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 then
		arg_13_0.refreshShopCnt = arg_13_0.refreshShopCnt + 1
	end

	arg_13_0.goods = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		arg_13_0.goods[iter_13_1] = NewEducateGoods.New(iter_13_1)
	end

	return
end

function var_0_0.IsFinish(arg_14_0)
	return true
end

function var_0_0.Reset(arg_15_0)
	arg_15_0.events = {}
	arg_15_0.goods = {}
	arg_15_0.selectedShip = {}
	arg_15_0.refreshShopCnt = 0

	return
end

return var_0_0

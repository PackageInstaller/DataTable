local NewEducateMapState = class("NewEducateMapState", import(".NewEducateStateBase"))

function NewEducateMapState:Ctor(arg_1_1, arg_1_2)
	self.charId = arg_1_1

	self:SetSiteState(arg_1_2.state or {})

	self.events = arg_1_2.events or {}

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_2.buys or {}) do
		var_1_0[iter_1_1.key] = iter_1_1.value
	end

	self.goods = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_2.shops or {}) do
		self.goods[iter_1_3] = NewEducateGoods.New(iter_1_3, var_1_0[iter_1_3] or 0)
	end

	self.selectedShip = arg_1_2.character_this_round or {}
	self.refreshShopCnt = arg_1_2.refresh_count or 0

	return
end

function NewEducateMapState:SetSiteState(arg_2_1)
	if not arg_2_1.key or arg_2_1.key == 0 then
		self.curSiteId = 0
	end

	local var_2_1 = getProxy(NewEducateProxy):GetChar(self.charId)

	if arg_2_1.key == NewEducateConst.SITE_STATE_TYPE.EVENT then
		self.curSiteId = var_2_1:GetSiteId(NewEducateConst.SITE_TYPE.EVENT, arg_2_1.value)
	elseif arg_2_1.key == NewEducateConst.SITE_STATE_TYPE.NORMAL then
		self.curSiteId = var_2_1:GetSiteId((NewEducateHelper.NormalType2SiteType(pg.child2_site_normal[arg_2_1.value].type)))
	elseif arg_2_1.key == NewEducateConst.SITE_STATE_TYPE.SHIP then
		self.curSiteId = var_2_1:GetSiteId(NewEducateConst.SITE_TYPE.SHIP, arg_2_1.value)
	elseif arg_2_1.key == NewEducateConst.SITE_STATE_TYPE.SHOP then
		self.curSiteId = var_2_1:GetSiteId(NewEducateConst.SITE_TYPE.SHOP)
	end

	return
end

function NewEducateMapState:GetCurSiteId()
	return self.curSiteId
end

function NewEducateMapState:GetEvents()
	return self.events
end

function NewEducateMapState:FinishEvent(arg_5_1)
	table.removebyvalue(self.events, arg_5_1)

	return
end

function NewEducateMapState:GetGoodList()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(self.goods) do
		table.insert(var_6_0, iter_6_1)
	end

	return var_6_0
end

function NewEducateMapState:AddBuyCnt(arg_7_1, arg_7_2)
	self.goods[arg_7_1]:AddBuyCnt(arg_7_2)

	return
end

function NewEducateMapState:AddSelectedShip(arg_8_1)
	table.insert(self.selectedShip, arg_8_1)

	return
end

function NewEducateMapState:IsSelectedShip(arg_9_1)
	return table.contains(self.selectedShip, arg_9_1)
end

function NewEducateMapState:IsSpecial()
	return underscore.any(self.events, function(arg_11_0)
		assert(pg.child2_site_event_group[arg_11_0], "child2_site_event_group不存在id" .. arg_11_0)

		return #pg.child2_site_event_group[arg_11_0].performance > 0
	end)
end

function NewEducateMapState:GetRefreshShopCnt()
	return self.refreshShopCnt
end

function NewEducateMapState:OnRefreshShopDone(arg_13_1, arg_13_2)
	if arg_13_2 then
		self.refreshShopCnt = self.refreshShopCnt + 1
	end

	self.goods = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		self.goods[iter_13_1] = NewEducateGoods.New(iter_13_1)
	end

	return
end

function NewEducateMapState:IsFinish()
	return true
end

function NewEducateMapState:Reset()
	self.events = {}
	self.goods = {}
	self.selectedShip = {}
	self.refreshShopCnt = 0

	return
end

return NewEducateMapState

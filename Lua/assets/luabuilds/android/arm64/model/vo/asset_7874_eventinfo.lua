local EventInfo = class("EventInfo", import(".BaseVO"))

EventInfo.StateExpire = -1
EventInfo.StateNone = 0
EventInfo.StateActive = 1
EventInfo.StateFinish = 2

function EventInfo:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.template = pg.collection_template[self.id]

	assert(self.template, "pg.collection_template>>>" .. self.id)

	self.finishTime = arg_1_1.finish_time or 0
	self.overTime = arg_1_1.over_time or 0
	self.shipIds = underscore.to_array(arg_1_1.ship_id_list) or {}
	self.activityId = arg_1_1.activity_id or 0

	if self:IsActivityType() and self.overTime == 0 then
		self.overTime = GetZeroTime()
	end

	return
end

function EventInfo:IsActivityType()
	return self.activityId > 0
end

function EventInfo:GetState()
	if self.finishTime == 0 then
		if self.overTime ~= 0 then
			if pg.TimeMgr.GetInstance():GetServerTime() < self.overTime then
				do return EventInfo.StateNone end

				goto label_3_0
			end
		end

		return EventInfo.StateExpire
	elseif self.finishTime < pg.TimeMgr.GetInstance():GetServerTime() then
		return EventInfo.StateFinish
	else
		return EventInfo.StateActive
	end

	::label_3_0::

	return
end

function EventInfo:IsStarting()
	return self:GetState() ~= EventInfo.StateNone
end

function EventInfo:SetActivityId(arg_5_1)
	self.activityId = arg_5_1

	return
end

function EventInfo:BelongActivity(arg_6_1)
	return self.activityId > 0 and self.activityId == arg_6_1
end

function EventInfo:setShipIds(arg_7_1)
	self.valid = false
	self.shipIds = underscore.to_array(arg_7_1)

	return
end

function EventInfo:getShipList()
	self:checkValid()

	return getProxy(BayProxy):getShipList(self.shipIds)
end

function EventInfo:checkValid()
	if self.valid then
		return
	end

	self.valid = true

	local var_9_0 = getProxy(BayProxy)

	self.shipIds = underscore.filter(self.shipIds, function(arg_10_0)
		return tobool(var_9_0:RawGetShipById(arg_10_0))
	end)

	return
end

function EventInfo:reachNum()
	self:checkValid()

	return self.template.ship_num <= #self.shipIds
end

function EventInfo:reachLevel()
	local var_12_0 = self:getShipList()

	return #var_12_0 > 0 and underscore.any(var_12_0, function(arg_13_0)
		return arg_13_0.level >= self.template.ship_lv
	end)
end

function EventInfo:reachTypes()
	local var_14_0 = self:getShipList()

	if table.getCount(var_14_0) == 0 then
		return false
	end

	local var_14_1 = true

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if not table.contains(self.template.ship_type, (iter_14_1:getShipType())) then
			var_14_1 = false

			break
		end
	end

	return var_14_1
end

function EventInfo:getOilConsume()
	return self.template.oil or 0
end

function EventInfo:getTypesStr()
	local var_16_0 = pg.ship_data_by_type
	local var_16_1 = false

	if #self.template.ship_type == #pg.ship_data_by_type.all then
		var_16_1 = true

		for iter_16_0, iter_16_1 in pairs(var_16_0.all) do
			if not table.contains(self.template.ship_type, iter_16_1) then
				var_16_1 = false

				break
			end
		end
	end

	if var_16_1 then
		return i18n("event_type_unlimit")
	else
		local var_16_2 = ""

		for iter_16_2, iter_16_3 in ipairs(ShipType.FilterOverQuZhuType(self.template.ship_type)) do
			var_16_2 = var_16_2 .. var_16_0[iter_16_3].type_name .. (iter_16_2 == #self.template.ship_type and "" or "、")
		end

		return i18n("event_condition_ship_type", var_16_2)
	end

	return
end

local var_0_1 = "EVENTINFO_FORMATION_KEY_"

function EventInfo:ExistPrevFormation()
	return PlayerPrefs.HasKey(var_0_1 .. getProxy(PlayerProxy):getRawData().id)
end

function EventInfo:GetPrevFormation()
	return _.map(string.split(PlayerPrefs.GetString(var_0_1 .. getProxy(PlayerProxy):getRawData().id), "#"), function(arg_19_0)
		return tonumber(arg_19_0)
	end)
end

function EventInfo:SavePrevFormation()
	self:checkValid()

	if not self:CanRecordPrevFormation() then
		return
	end

	PlayerPrefs.SetString(var_0_1 .. getProxy(PlayerProxy):getRawData().id, (table.concat(self.shipIds, "#")))
	PlayerPrefs.Save()

	return
end

function EventInfo:CanRecordPrevFormation()
	return self.template.oil >= 800
end

function EventInfo:GetCountDownTime()
	local var_22_0 = not self:IsActivityType() and self:GetState() == EventInfo.StateNone and self.overTime > 0 and self.overTime - pg.TimeMgr.GetInstance():GetServerTime() or false

	return (false or nil) and true
end

return EventInfo

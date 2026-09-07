local CollectionEventActivity = class("CollectionEventActivity", import(".Activity"))

function CollectionEventActivity:Ctor(arg_1_1)
	CollectionEventActivity.super.Ctor(self, arg_1_1)

	self.collections = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.collection_list) do
		local var_1_0 = EventInfo.New(iter_1_1)

		var_1_0:SetActivityId(self.id)
		table.insert(self.collections, var_1_0)
	end

	return
end

function CollectionEventActivity:getDayIndex()
	local var_2_0 = pg.TimeMgr.GetInstance()

	return var_2_0:DiffDay(self.data1, (var_2_0:GetServerTime())) + 1
end

function CollectionEventActivity:GetCollectionList()
	local var_3_0 = self:getConfig("config_data")
	local var_3_1 = self:getDayIndex()

	self.collections = underscore.filter(self.collections, function(arg_4_0)
		if table.contains(self:getData1List(), arg_4_0.id) then
			return false
		end

		if table.indexof(var_3_0, arg_4_0.id) < var_3_1 and arg_4_0:GetState() < EventInfo.StateActive then
			return false
		end

		return true
	end)

	if #self.collections == 0 and var_3_0[var_3_1] and not table.contains(self:getData1List(), var_3_0[var_3_1]) then
		table.insert(self.collections, (EventInfo.New({
			finish_time = 0,
			over_time = 0,
			id = var_3_0[var_3_1],
			ship_id_list = {},
			activity_id = self.id
		})))
	end

	return self.collections
end

return CollectionEventActivity

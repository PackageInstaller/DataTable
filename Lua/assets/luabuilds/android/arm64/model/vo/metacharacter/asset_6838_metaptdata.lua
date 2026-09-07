local MetaPTData = class("MetaPTData")

function MetaPTData:Ctor(arg_1_1)
	self.groupID = arg_1_1.group_id

	local var_1_0 = pg.ship_strengthen_meta[arg_1_1.group_id]

	assert(pg.ship_strengthen_meta[arg_1_1.group_id] ~= nil, "Null MetaShip Strengthen Data, ID:" .. arg_1_1.group_id)

	self.targets = var_1_0.target
	self.dropList = var_1_0.award_display
	self.resId = var_1_0.itemid
	self.count = 0
	self.level = 0
	self.curLevel = self.level + 1

	return
end

function MetaPTData:initFromServerData(arg_2_1)
	self.count = arg_2_1.pt or 0

	if #arg_2_1.fetch_list > 0 then
		local var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_1.fetch_list) do
			table.insert(var_2_0, iter_2_1)
		end

		table.sort(var_2_0)

		for iter_2_2, iter_2_3 in ipairs(var_2_0) do
			if iter_2_3 == self.targets[iter_2_2] then
				self.level = iter_2_2
			else
				break
			end
		end
	end

	self.curLevel = math.min(self.level + 1, #self.targets)

	return
end

function MetaPTData:update(arg_3_1)
	self.count = arg_3_1.pt or self.count
	self.level = arg_3_1.level or self.level
	self.curLevel = self.level + 1

	return
end

function MetaPTData:updateLevel(arg_4_1)
	self.level = arg_4_1
	self.curLevel = math.min(self.level + 1, #self.targets)

	return
end

function MetaPTData:addPT(arg_5_1)
	self.count = self.count + arg_5_1

	return
end

function MetaPTData:GetResProgress()
	return self.count, self.targets[self.curLevel], self.count / self.targets[self.curLevel]
end

function MetaPTData:GetLevelProgress()
	return self.curLevel, #self.targets, self.curLevel / #self.targets
end

function MetaPTData:CanGetAward()
	local var_8_0, var_8_1, var_8_2 = self:GetResProgress()

	return self:CanGetNextAward() and var_8_2 >= 1
end

function MetaPTData:CanGetNextAward()
	return self.level < #self.targets
end

function MetaPTData:GetTotalResRequire()
	return self.targets[#self.targets]
end

function MetaPTData:IsMaxPt()
	return self.count >= self:GetTotalResRequire()
end

return MetaPTData

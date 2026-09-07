local SyncUnitInteract = class("SyncUnitInteract")

function SyncUnitInteract:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1
	self.type = arg_1_2
	self.owners = {}
	self.status = -1

	return
end

function SyncUnitInteract:UpdateInfo(arg_2_1)
	self:UpdateOwner(arg_2_1.slots)

	self.status = arg_2_1.status

	return
end

function SyncUnitInteract:SetStatus(arg_3_1)
	self.status = arg_3_1

	return
end

function SyncUnitInteract:GetStatus()
	return self.status
end

function SyncUnitInteract:InitOwner(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		self.owners[iter_5_1.slot_id] = iter_5_1.owner_id
	end

	return
end

function SyncUnitInteract:OwnerCount()
	return table.getCount(self.owners)
end

function SyncUnitInteract:UpdateOwner(arg_7_1)
	local var_7_0 = #arg_7_1 > self:OwnerCount()
	local var_7_1
	local var_7_2

	if var_7_0 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
			if not self.owners[iter_7_1.slot_id] then
				self.owners[iter_7_1.slot_id] = iter_7_1.owner_id
				var_7_1 = iter_7_1.owner_id
				var_7_2 = iter_7_1.slot_id

				break
			end
		end
	else
		local var_7_3 = {}

		for iter_7_2, iter_7_3 in ipairs(arg_7_1) do
			var_7_3[iter_7_3.slot_id] = iter_7_3.owner_id
		end

		for iter_7_4, iter_7_5 in pairs(self.owners) do
			if not var_7_3[iter_7_4] then
				var_7_1 = iter_7_5
				var_7_2 = iter_7_4
				self.owners[iter_7_4] = nil

				break
			end
		end
	end

	return var_7_0, var_7_1, var_7_2
end

function SyncUnitInteract:RemoveOwner(arg_8_1)
	for iter_8_0, iter_8_1 in pairs(self.owners) do
		if iter_8_1 == arg_8_1 then
			self.owners[iter_8_0] = nil
		end
	end

	return
end

return SyncUnitInteract

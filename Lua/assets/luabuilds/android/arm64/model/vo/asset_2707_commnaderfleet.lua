local CommnaderFleet = class("CommnaderFleet", import(".BaseVO"))

CommnaderFleet.RENAME_CODE_TIME = 60

function CommnaderFleet:Ctor(arg_1_1)
	self:Update(arg_1_1)

	return
end

function CommnaderFleet:Update(arg_2_1)
	self.id = arg_2_1.id
	self.name = arg_2_1.name or i18n("commander_prefab_name", self.id)
	self.commanders = arg_2_1.commanders or {}
	self.renameTime = 0

	return
end

function CommnaderFleet:canRename()
	if CommnaderFleet.RENAME_CODE_TIME - (pg.TimeMgr.GetInstance():GetServerTime() - self.renameTime) <= 0 then
		return true
	end

	local var_3_1 = i18n("commander_prefab_rename_time", CommnaderFleet.RENAME_CODE_TIME - (pg.TimeMgr.GetInstance():GetServerTime() - self.renameTime))
end

function CommnaderFleet:updateCommander(arg_4_1, arg_4_2)
	self.commanders[arg_4_1] = arg_4_2

	return
end

function CommnaderFleet:getName()
	return self.name
end

function CommnaderFleet:updateName(arg_6_1)
	self.name = arg_6_1
	self.renameTime = pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function CommnaderFleet:getCommanderByPos(arg_7_1)
	return self.commanders[arg_7_1]
end

function CommnaderFleet:getCommander()
	return self.commanders
end

function CommnaderFleet:updateCommanders(arg_9_1)
	self.commanders = arg_9_1

	return
end

function CommnaderFleet:contains(arg_10_1)
	for iter_10_0, iter_10_1 in pairs(self.commanders) do
		if iter_10_1.id == arg_10_1 then
			return true
		end
	end

	return false
end

function CommnaderFleet:getCommanderIds()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(self.commanders) do
		table.insert(var_11_0, iter_11_1.id)
	end

	return var_11_0
end

function CommnaderFleet:removeCommander(arg_12_1)
	for iter_12_0, iter_12_1 in pairs(self.commanders) do
		if iter_12_1.id == arg_12_1 then
			self.commanders[iter_12_0] = nil
		end
	end

	return
end

function CommnaderFleet:isEmpty()
	return table.getCount(self.commanders) == 0
end

function CommnaderFleet:isSame(arg_14_1)
	local var_14_0 = self.commanders[1]
	local var_14_1 = arg_14_1[1]
	local var_14_2 = self.commanders[2]
	local var_14_3 = arg_14_1[2]

	return (self.commanders[1] == nil and var_14_1 == nil or var_14_0 and var_14_1 and var_14_0.id == var_14_1.id) and (self.commanders[2] == nil and var_14_3 == nil or var_14_2 and var_14_3 and var_14_2.id == var_14_3.id)
end

function CommnaderFleet:isSameId(arg_15_1)
	local var_15_0 = self.commanders[1]
	local var_15_1 = arg_15_1[1]
	local var_15_2 = self.commanders[2]
	local var_15_3 = arg_15_1[2]

	return (self.commanders[1] == nil and var_15_1 == nil or var_15_0 and var_15_1 and var_15_0.id == var_15_1) and (self.commanders[2] == nil and var_15_3 == nil or var_15_2 and var_15_3 and var_15_2.id == var_15_3)
end

return CommnaderFleet

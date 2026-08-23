local var_0_0 = g.core.model.User
local HomeInfoRemindOthersData = class("HomeInfoRemindOthersData")

function HomeInfoRemindOthersData:ctor()
	self:initData()
end

function HomeInfoRemindOthersData:initData()
	self._othersData = {}
end

function HomeInfoRemindOthersData:updateCurInfoRemindData(arg_3_1)
	self._othersData = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if g.core.common.ModuleUnlock:isModuleUnlock(iter_3_1.function_id) then
			local var_3_0 = 0

			if iter_3_1.id == 1 + 3000 then
				var_3_0 = var_0_0.guildData:getRedPointData().apply_num or 0
			elseif iter_3_1.id == 3000 + 2 then
				var_3_0 = #var_0_0.bioData:getInvitedInfo()
			elseif iter_3_1.id == 3000 + 3 then
				var_3_0 = var_0_0.resourceData:getVit()
			elseif iter_3_1.id == 3000 + 4 then
				local var_3_1, var_3_2, var_3_3 = var_0_0.itemsData:getBagList()

				var_3_0 = var_3_3
			elseif iter_3_1.id == 3000 + 5 then
				var_3_0 = var_0_0.hlTrainData:getCanLevelUpRoomNum()
			elseif iter_3_1.id == 3000 + 6 then
				var_3_0 = table.nums((var_0_0.friendData:getRequestList()))
			elseif iter_3_1.id == 3000 + 7 then
				var_3_0 = var_0_0.handBookData:getCanActiveBookNum()
			elseif iter_3_1.id == 3000 + 8 and var_0_0.warriorsOfFateData:checkWarriors() then
				var_3_0 = 1
			end

			local var_3_4 = self:_judgeState(iter_3_1, var_3_0)

			if var_3_4 then
				table.insert(self._othersData, var_3_4)
			end
		end
	end

	return self._othersData
end

function HomeInfoRemindOthersData:_judgeState(arg_4_1, arg_4_2)
	local var_4_0 = {
		cfgInfo = arg_4_1
	}

	var_4_0.state = 0

	if arg_4_2 >= arg_4_1.unseal then
		var_4_0.cfgInfo = arg_4_1
		var_4_0.num = arg_4_2
		var_4_0.showLight = 0

		if arg_4_2 >= arg_4_1.times then
			var_4_0.showLight = 1
		end

		return var_4_0
	end

	return nil
end

return HomeInfoRemindOthersData

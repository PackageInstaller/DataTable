local ActivityMedalGroup = class("ActivityMedalGroup", import("model.vo.BaseVO"))

ActivityMedalGroup.STATE_EXPIRE = -1
ActivityMedalGroup.STATE_CLOSE = 0
ActivityMedalGroup.STATE_ACTIVE = 1

function ActivityMedalGroup:bindConfigTable()
	return pg.activity_medal_group
end

function ActivityMedalGroup:GetConfigID()
	return self.configId
end

function ActivityMedalGroup:Ctor(arg_3_1)
	self.configId = arg_3_1
	self.medalList = {}

	for iter_3_0, iter_3_1 in ipairs((self:GetMedalIds())) do
		self.medalList[iter_3_1] = {
			id = iter_3_1
		}
	end

	return
end

function ActivityMedalGroup:GetMedalIds()
	return pg.activity_medal_template.get_id_list_by_group[self.configId]
end

function ActivityMedalGroup:IsMedalGroupCollectionGrey()
	player = getProxy(PlayerProxy):getData()

	return not player:getActivityMedalGroup()[self]
end

function ActivityMedalGroup:GetMedalGroupStateByID()
	if pg.activity_medal_group[self].is_out_of_print == 1 then
		return ActivityMedalGroup.STATE_EXPIRE
	elseif pg.activity_medal_group[self].is_out_of_print == 0 then
		local var_6_0 = false

		for iter_6_0, iter_6_1 in ipairs(pg.activity_medal_group[self].activity_link) do
			local var_6_1 = getProxy(ActivityProxy):getActivityById(iter_6_1[2])

			if var_6_1 and not var_6_1:isEnd() then
				var_6_0 = true

				break
			end
		end

		if var_6_0 then
			return ActivityMedalGroup.STATE_ACTIVE
		else
			return ActivityMedalGroup.STATE_CLOSE
		end
	end

	return
end

function ActivityMedalGroup:GetMedalGroupState()
	local var_7_0 = self:getConfig("is_out_of_print")

	if var_7_0 == 1 then
		return ActivityMedalGroup.STATE_EXPIRE
	elseif var_7_0 == 0 then
		if self:GetMedalGroupActivityConfig() then
			return ActivityMedalGroup.STATE_ACTIVE
		else
			return ActivityMedalGroup.STATE_CLOSE
		end
	end

	return
end

function ActivityMedalGroup:GetMedalGroupActivityConfig()
	for iter_8_0, iter_8_1 in ipairs(self:getConfig("activity_link")) do
		local var_8_0 = getProxy(ActivityProxy):getActivityById(iter_8_1[2])

		if var_8_0 and not var_8_0:isEnd() then
			return iter_8_1
		end
	end

	return
end

function ActivityMedalGroup:GetMedalList()
	return self.medalList
end

function ActivityMedalGroup:UpdateMedal(arg_10_1, arg_10_2)
	self.medalList[arg_10_1].timeStamp = arg_10_2

	return
end

function ActivityMedalGroup:GetAll()
	return underscore.all(self:GetMedalIds(), function(arg_12_0)
		return self:OwnMedel(arg_12_0)
	end)
end

function ActivityMedalGroup:OwnMedel(arg_13_1)
	return self.medalList[arg_13_1] and self.medalList[arg_13_1].timeStamp and self.medalList[arg_13_1].timeStamp ~= 0
end

function ActivityMedalGroup:GetGroupIDByMedalID()
	return pg.activity_medal_group[self].group
end

function ActivityMedalGroup:showTip()
	local var_15_0

	if pg.activity_medal_group[self] then
		var_15_0 = pg.activity_medal_group[self].activity_link or {}
	end

	local var_15_1

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_2 = getProxy(ActivityProxy):getActivityById(iter_15_1[2])

		if var_15_2 and not var_15_2:isEnd() then
			var_15_1 = iter_15_1[3]

			break
		end
	end

	if not var_15_1 then
		return false
	end

	local var_15_3 = getProxy(TaskProxy)
	local var_15_4 = 0
	local var_15_5 = 0

	for iter_15_2, iter_15_3 in ipairs(var_15_1) do
		local var_15_7 = var_15_3:getTaskById(iter_15_3) or var_15_3:getFinishTaskById(iter_15_3)

		if var_15_7 then
			local var_15_8 = var_15_7:getTaskStatus()

			if var_15_8 == 1 then
				var_15_5 = var_15_5 + 1
				var_15_4 = var_15_4 + 1
			elseif var_15_8 == 2 then
				var_15_4 = var_15_4 + 1
			end
		end
	end

	return var_15_5 > 0
end

return ActivityMedalGroup

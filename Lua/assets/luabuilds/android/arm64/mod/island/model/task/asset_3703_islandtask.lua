local IslandTask = class("IslandTask", import("model.vo.BaseVO"))

function IslandTask:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.acceptTime = arg_1_1.timestamp or 0

	self:InitEndTime()
	self:UpdateTargetData(arg_1_1.process_list)

	return
end

function IslandTask:bindConfigTable()
	return pg.island_task
end

function IslandTask:GetAcceptTime()
	return self.acceptTime
end

function IslandTask:InitEndTime()
	local var_4_0 = self:getConfig("unlock_time")

	self.endTime = var_4_0 == "always" and 0 or pg.TimeMgr.GetInstance():parseTimeFromConfig(var_4_0[2])

	return
end

function IslandTask:SetEndTime(arg_5_1)
	self.endTime = arg_5_1

	return
end

function IslandTask:UpdateTargetData(arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		var_6_0[iter_6_1.target_id] = iter_6_1
	end

	self.targetList = {}

	for iter_6_2, iter_6_3 in ipairs(self:getConfig("target_id")) do
		table.insert(self.targetList, IslandTaskTarget.New(var_6_0[iter_6_3] or {
			target_id = iter_6_3
		}))
	end

	return
end

function IslandTask:GetTargetList()
	return self.targetList
end

function IslandTask:GetTargetById(arg_8_1)
	return underscore.detect(self.targetList, function(arg_9_0)
		return arg_9_0.id == arg_8_1
	end)
end

function IslandTask:GetRecycleItemInfos()
	local var_10_0 = {}

	underscore.each(self.targetList, function(arg_11_0)
		if arg_11_0:GetType() == IslandTaskTargetType.RECYCLE then
			table.insert(var_10_0, Drop.New({
				type = DROP_TYPE_ISLAND_ITEM,
				id = arg_11_0:GetTargetId(),
				count = arg_11_0:GetTargetNum()
			}))
		end

		return
	end)

	return var_10_0
end

function IslandTask:ExistTargetType(arg_12_1)
	return underscore.any(self.targetList, function(arg_13_0)
		return arg_13_0:GetType() == arg_12_1
	end)
end

function IslandTask:GetTargetIdByTypeAndParam(arg_14_1, arg_14_2)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(self.targetList) do
		if iter_14_1:CheckTypeAndTargetId(arg_14_1, arg_14_2) and not table.contains(var_14_0, iter_14_1.id) then
			table.insert(var_14_0, iter_14_1.id)
		end
	end

	return var_14_0
end

function IslandTask:GetRemainTimeStr()
	local var_15_0 = self.endTime - pg.TimeMgr.GetInstance():GetServerTime()

	return i18n("island_task_lefttime", math.floor(var_15_0 / 0), (math.floor(var_15_0 % 0 / 16)))
end

function IslandTask:IsFinish()
	return underscore.all(self.targetList, function(arg_17_0)
		return arg_17_0:IsFinish()
	end)
end

function IslandTask:IsSubmitOnUI()
	return self:getConfig("complete_type") == 3
end

function IslandTask:GetSubmitObjectId()
	return self:getConfig("complete_data")
end

function IslandTask:IsSubmitImmediately()
	return self:getConfig("complete_type") == 2 and self:GetSubmitObjectId() == 0
end

function IslandTask:CheckSubmitOnApproach(arg_21_1)
	return self:GetSubmitObjectId() == arg_21_1 and self:getConfig("complete_type") == 2
end

function IslandTask:GetFinishedDesc()
	return self:getConfig("complete_tips")
end

function IslandTask:InTime()
	if self.endTime == 0 then
		return true
	end

	return pg.TimeMgr.GetInstance():GetServerTime() < self.endTime
end

function IslandTask:GetType()
	return self:getConfig("type")
end

function IslandTask:GetShowType()
	return IslandTaskType.Type2ShowType[self:getConfig("type")]
end

function IslandTask:GetName()
	return self:getConfig("name")
end

function IslandTask:GetDesc()
	return self:getConfig("task_desc")
end

function IslandTask:IsSeries()
	return self:getConfig("series") ~= ""
end

function IslandTask:GetSeriesTitle()
	return self:getConfig("series") .. " " .. self:getConfig("series_name")
end

function IslandTask:GetAddedStory()
	return self:getConfig("rec_perform")
end

function IslandTask:GetSubmitStory()
	return self:getConfig("com_perform")
end

function IslandTask:GetTraceParam()
	for iter_32_0, iter_32_1 in ipairs(self.targetList) do
		if not iter_32_1:IsFinish() then
			return iter_32_1:GetTrackParma(), iter_32_0
		end
	end

	return self:GetSubmitObjectId() ~= 0 and self:GetSubmitObjectId() or ""
end

function IslandTask:GetAwards()
	local var_33_0 = self:getConfig("reward_show")
	local var_33_1 = {}

	if type(var_33_0) == "table" then
		var_33_1 = underscore.map(var_33_0, function(arg_34_0)
			return Drop.Create(arg_34_0)
		end)
	end

	if self:GetExpAward() then
		table.insert(var_33_1, self:GetExpAward())
	end

	return var_33_1
end

function IslandTask:GetExp()
	return self:getConfig("reward_exp")
end

function IslandTask:GetExpAward()
	if self:GetExp() ~= 0 then
		return {
			id = 2,
			type = DROP_TYPE_ISLAND_ITEM,
			count = self:GetExp()
		}
	end

	return nil
end

function IslandTask:GetAwardsStatic()
	local var_37_0 = {}

	if type(pg.island_task[self].reward_show) == "table" then
		var_37_0 = underscore.map(pg.island_task[self].reward_show, function(arg_38_0)
			return Drop.Create(arg_38_0)
		end)
	end

	if pg.island_task[self].reward_exp ~= 0 then
		table.insert(var_37_0, {
			id = 2,
			type = DROP_TYPE_ISLAND_ITEM,
			count = pg.island_task[self].reward_exp
		})
	end

	return var_37_0
end

function IslandTask:GetSubmitPlayInfo()
	if pg.island_task[self].com_perform == "" or #pg.island_task[self].com_perform == 0 then
		return nil
	end

	return pg.island_task[self].com_perform[1], pg.island_task[self].com_perform[2]
end

function IslandTask:BuildFakeTask()
	return IslandTask.New({
		id = self,
		process_list = _.map(pg.island_task[self].target_id, function(arg_41_0)
			return {
				target_id = arg_41_0,
				target_count = pg.island_task_target[arg_41_0].target_num
			}
		end)
	})
end

return IslandTask

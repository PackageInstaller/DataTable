local StageProxy = class("StageProxy", import(".NetProxy"))

StageProxy.STAGE_ADDED = "stage added"
StageProxy.STAGE_UPDATED = "stage updated"
StageProxy.RANDOM_STAGE_DELETE = "random stage deleted"
StageProxy.RANDOM_STAGE_ADDED = "stage added"

function StageProxy:register()
	self:on(13001, function(arg_2_0)
		self.data.satges = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.expedition_list) do
			local var_2_0 = Stage.New(iter_2_1)

			var_2_0:display("loaded")

			self.data.satges[var_2_0.id] = var_2_0
		end

		return
	end)
	self:on(13100, function(arg_3_0)
		self.data.randomexpeditions = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_0.random_expedition_list) do
			local var_3_0 = Stage.New(iter_3_1)

			var_3_0:display("loaded")

			if not self.data.randomexpeditions[var_3_0.id] then
				print("随机关卡添加" .. var_3_0.id)
				self:addRandomStage(var_3_0)
			else
				self.data.randomexpeditions[var_3_0.id] = var_3_0
			end
		end

		return
	end)
	self:listenerRandomStage()

	return
end

function StageProxy:remove()
	pg.TimeMgr.GetInstance():RemoveTimer(self.timerId)

	self.timerId = nil

	return
end

function StageProxy:addStage(arg_5_1)
	assert(isa(arg_5_1, Stage), "should be an instance of Stage")
	assert(self.data.satges[arg_5_1.id] == nil, "ship already exist, use updateStage() instead")

	self.data.satges[arg_5_1.id] = arg_5_1:clone()

	self.data.satges[arg_5_1.id]:display("added")
	self.facade:sendNotification(StageProxy.STAGE_ADDED, arg_5_1:clone())

	return
end

function StageProxy:getStageById(arg_6_1)
	if self.data.satges[arg_6_1] ~= nil then
		return self.data.satges[arg_6_1]:clone()
	end

	return
end

function StageProxy:updateStage(arg_7_1)
	assert(isa(arg_7_1, Stage), "should be an instance of Stage")

	self.data.satges[arg_7_1.id] = arg_7_1:clone()

	self.data.satges[arg_7_1.id]:display("updated")
	self.facade:sendNotification(StageProxy.STAGE_UPDATED, arg_7_1:clone())

	return
end

function StageProxy:getRandomStages()
	return Clone(self.data.randomexpeditions) or {}
end

function StageProxy:addRandomStage(arg_9_1)
	assert(isa(arg_9_1, Stage), "should be an instance of Stage")
	assert(self.data.randomexpeditions[arg_9_1.id] == nil, "ship already exist, use updateStage() instead")

	self.data.randomexpeditions[arg_9_1.id] = arg_9_1

	self.facade:sendNotification(StageProxy.RANDOM_STAGE_ADDED, arg_9_1:clone())

	return
end

function StageProxy:listenerRandomStage()
	self.timerId = pg.TimeMgr.GetInstance():AddTimer("listenerRandomStage", 0, 1, function()
		if self.data.randomexpeditions and table.getCount(self.data.randomexpeditions) > 0 then
			local var_11_0 = pg.TimeMgr.GetInstance():GetServerTime()

			for iter_11_0, iter_11_1 in pairs(self.data.randomexpeditions) do
				if iter_11_1.out_time == var_11_0 then
					self:removeRandomStageById(iter_11_1.id)
				end
			end
		end

		return
	end)

	return
end

function StageProxy:removeRandomStageById(arg_12_1)
	assert(self.data.randomexpeditions[arg_12_1], "不存在随机卡关" .. arg_12_1)

	self.data.randomexpeditions[arg_12_1] = nil

	self.facade:sendNotification(StageProxy.RANDOM_STAGE_DELETE, arg_12_1)

	return
end

return StageProxy

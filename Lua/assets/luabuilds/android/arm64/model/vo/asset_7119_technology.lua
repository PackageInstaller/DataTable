local Technology = class("Technology", import(".BaseVO"))

function Technology:bindConfigTable()
	return pg.technology_data_template
end

function Technology:Ctor(arg_2_1)
	self.id = arg_2_1.id
	self.configId = self.id
	self.poolId = arg_2_1.pool_id
	self.time = arg_2_1.time
	self.isQueue = arg_2_1.queue

	return
end

function Technology:start(arg_3_1)
	self.time = arg_3_1

	return
end

function Technology:isActivate()
	return self.time > 0
end

function Technology:isCompleted()
	return self:isFinish() and self:finishCondition()
end

function Technology:isStarting()
	if not self:isActivate() then
		return false
	end

	return pg.TimeMgr.GetInstance():GetServerTime() < self.time
end

function Technology:isWaiting()
	if not self:isActivate() then
		return false
	end

	return pg.TimeMgr.GetInstance():GetServerTime() < self.time - self:getConfig("time")
end

function Technology:isDoing()
	if not self:isActivate() then
		return false
	end

	local var_8_0 = pg.TimeMgr.GetInstance():GetServerTime()

	return var_8_0 >= self.time - self:getConfig("time") and var_8_0 < self.time
end

function Technology:isFinish()
	if not self:isActivate() then
		return false
	end

	return pg.TimeMgr.GetInstance():GetServerTime() >= self.time
end

function Technology:finishCondition()
	if self.isQueue then
		return true
	end

	local var_10_0 = self:getConfig("condition")

	return var_10_0 == 0 or getProxy(TaskProxy):getTaskVO(var_10_0):isFinish()
end

function Technology:hasResToStart()
	local var_11_0 = getProxy(PlayerProxy):getData()
	local var_11_1 = getProxy(BagProxy)

	for iter_11_0, iter_11_1 in ipairs((self:getConfig("consume"))) do
		if iter_11_1[1] == DROP_TYPE_RESOURCE and var_11_0:getResById(iter_11_1[2]) < iter_11_1[3] then
			local var_11_3 = i18n("common_no_resource")

			return
		elseif iter_11_1[1] == DROP_TYPE_ITEM and var_11_1:getItemCountById(iter_11_1[2]) < iter_11_1[3] then
			local var_11_5 = i18n("common_no_item_1")

			return
		end
	end

	return true
end

function Technology:reset()
	self.time = 0

	return
end

return Technology

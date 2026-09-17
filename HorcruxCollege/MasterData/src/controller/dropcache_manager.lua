CACHE_FULL_CAPACITY = 24
MAX_POP_SP = 6

local playermodel = require("model.playermodel")
local network = require("network.network")
local item_manager = require("controller.item_manager")
local item_data = require("data.item_data")
local audio_manager = require("controller.audio_manager")
local time_check_manager = require("controller.time_check_manager")
local var_0_6 = {}

var_0_6.sync_scheduler = nil
var_0_6.sync_timer = 0
var_0_6.poplist = 0
var_0_6.havestlist = 0

local var_0_7 = 360

function var_0_6.init(arg_1_0)
	arg_1_0.poplist = 0
	arg_1_0.havestlist = 0
end

function var_0_6:getDropCachePercent()
	return self:getDropCacheNum() / CACHE_FULL_CAPACITY * 100
end

function var_0_6:getDropCacheNum()
	return #playermodel.dropcache - self.havestlist
end

function var_0_6.getDropCacheNumStr(arg_4_0)
	local var_4_0 = 0

	for iter_4_0, iter_4_1 in pairs(playermodel.dropcache) do
		var_4_0 = var_4_0 + iter_4_1.itemcount

		if var_4_0 > 99 then
			var_4_0 = "99+"

			break
		end
	end

	return tostring(var_4_0)
end

function var_0_6:isDropCacheFull()
	return self:getDropCacheNum() >= CACHE_FULL_CAPACITY
end

function var_0_6:isDropCacheEmpty()
	return self:getDropCacheNum() < 10
end

local function var_0_8(arg_7_0, arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0) do
		var_7_0[iter_7_1.itemid] = iter_7_1.itemcount
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_1) do
		if var_7_0[iter_7_3.itemid] ~= iter_7_3.itemcount then
			return iter_7_3.itemid
		end
	end
end

function var_0_6:updateItemCache(arg_8_1, arg_8_2)
	playermodel.dropcache = arg_8_1 or {}
	playermodel.dropcacheweight.weight = 0

	for iter_8_0, iter_8_1 in ipairs(playermodel.dropcache) do
		playermodel.dropcacheweight.weight = playermodel.dropcacheweight.weight + iter_8_1.itemcount * (item_data[iter_8_1.itemid].bagweight or 0)
	end

	self:resetCacheTime(arg_8_2)

	local var_8_1 = cc.EventCustom:new("syncDropCache")

	var_8_1.item = var_0_8(playermodel.dropcache, arg_8_1 or {})

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_8_1)
end

function var_0_6.insertItemCache(arg_9_0, arg_9_1)
	if item_manager:can_stack(item_data[arg_9_1.itemid].bag_item_type) then
		local var_9_0 = false

		for iter_9_0, iter_9_1 in ipairs(playermodel.dropcache) do
			if iter_9_1.itemid == arg_9_1.itemid then
				iter_9_1.itemcount = iter_9_1.itemcount + arg_9_1.itemcount
				var_9_0 = true

				break
			end
		end

		if not var_9_0 then
			table.insert(playermodel.dropcache, arg_9_1)
		end
	else
		table.insert(playermodel.dropcache, arg_9_1)
	end

	playermodel.dropcacheweight.weight = playermodel.dropcacheweight.weight + arg_9_1.itemcount * (item_data[arg_9_1.itemid].bagweight or 0)

	local var_9_1 = cc.EventCustom:new("syncDropCache")

	var_9_1.item = arg_9_1.itemid

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_9_1)
end

function var_0_6:resetCacheTime(arg_10_1)
	if self.sync_scheduler then
		time_check_manager:removeUpdatePool(self.sync_scheduler)

		self.sync_scheduler = nil
	end

	self.sync_timer = arg_10_1
	self.sync_scheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(arg_10_1, function(arg_11_0)
		self:syncDropCacheTime(arg_11_0)

		if arg_11_0 <= 0 then
			time_check_manager:removeUpdatePool(self.sync_scheduler)

			self.sync_scheduler = nil
		end
	end)))
end

function var_0_6:syncDropCacheTime(arg_12_1)
	self.sync_timer = arg_12_1

	if self.sync_timer < 0 then
		self.sync_timer = 0
	end

	cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("syncDropCacheTime")))
end

function var_0_6:getCacheValidPopNum()
	local var_13_0 = self:getDropCacheNum() - self.poplist

	return var_13_0 < MAX_POP_SP - self.poplist and var_13_0 or MAX_POP_SP - self.poplist
end

function var_0_6:canCachePop()
	return self:getCacheValidPopNum() > 0
end

function var_0_6:dequenceCacheSP()
	self.poplist = self.poplist + 1

	return playermodel.dropcache[self.poplist + self.havestlist]
end

function var_0_6:isLock()
	return self.sync_lock
end

function var_0_6.harvestCache(arg_17_0, arg_17_1)
	network:rpc("harvest_dropcache", nil, function(arg_18_0)
		if arg_18_0.result == 1 then
			for iter_18_0, iter_18_1 in pairs(arg_18_0.items) do
				item_manager:setItemByServerItem(iter_18_1)
			end

			playermodel.dropcache = arg_18_0.cacheitems
			playermodel.dropcacheweight.weight = tonumber(arg_18_0.weight)

			if #arg_18_0.cacheitems > 0 then
				-- block empty
			end
		end

		if arg_17_1 then
			arg_17_1(arg_18_0.result, arg_18_0.items, arg_18_0.cacheitems)
		end
	end)
end

function var_0_6:getTimePercent()
	return (var_0_7 - self.sync_timer) / var_0_7 * 100
end

function var_0_6:getNextHarvestTime()
	return self.sync_timer
end

return var_0_6

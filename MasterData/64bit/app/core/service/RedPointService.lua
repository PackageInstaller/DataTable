local RedPointService = class("RedPointService")
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.model.User.redPointRefreshCache

function RedPointService:ctor()
	self._compMap = {}
	self._eventKeyCompMap = {}
	self.unRefreshEvent = {}

	self:_addEventListeners()
end

function RedPointService:_addEventListeners()
	var_0_2:addEventListener(var_0_1.EVENT_REFRESH_RED_POINT, self._onReceiveEvent, self)
	var_0_2:addEventListener(var_0_1.EVENT_CROSS_DAY_NOTIFY, self._onRedCacheCrossDayRefresh, self)
end

function RedPointService:_onReceiveEvent(arg_3_1, arg_3_2)
	if arg_3_1 == var_0_1.EVENT_REFRESH_RED_POINT then
		local var_3_0 = self:_findRedPointComp(arg_3_2.redPointComp)

		if var_3_0 then
			var_3_0:refresh(arg_3_2.customData)
		end
	elseif self._eventKeyCompMap[arg_3_1] then
		for iter_3_0 in pairs(self._eventKeyCompMap[arg_3_1]) do
			iter_3_0:refresh(iter_3_0:getCustomData())
		end
	end
end

function RedPointService:_onRedCacheCrossDayRefresh()
	var_0_3:refreshAllRedCache()
end

function RedPointService:_onNetRefreshEvent(arg_5_1)
	var_0_3:addRedPointCache(arg_5_1)

	if not self.unRefreshEvent[arg_5_1] then
		self:_onReceiveEvent(arg_5_1)
	end
end

function RedPointService:reset()
	for iter_6_0 in pairs(self._compMap) do
		iter_6_0:release()
	end

	self._compMap = {}
	self._eventKeyCompMap = {}
end

function RedPointService:addRedPointComp(arg_7_1)
	if self:isRedPointAdded(arg_7_1) then
		return
	end

	arg_7_1:retain()

	self._compMap[arg_7_1] = true

	self:addRedPointEventsListener(arg_7_1)
end

function RedPointService:rmvRedPointComp(arg_8_1)
	if not self:isRedPointAdded(arg_8_1) then
		return
	end

	self:rmvRedPointEventsListener(arg_8_1)
	arg_8_1:release()

	self._compMap[arg_8_1] = nil
end

function RedPointService:isRedPointAdded(arg_9_1)
	return self._compMap[arg_9_1]
end

function RedPointService:addRedPointEventsListener(arg_10_1)
	local var_10_0 = arg_10_1:getEventMap()

	if not var_10_0 then
		return
	end

	for iter_10_0 in pairs(var_10_0) do
		if self._eventKeyCompMap[iter_10_0] then
			self._eventKeyCompMap[iter_10_0][arg_10_1] = true
		else
			self._eventKeyCompMap[iter_10_0] = {
				[arg_10_1] = true
			}

			if not self.unRefreshEvent[iter_10_0] then
				var_0_2:addEventListener(iter_10_0, self._onNetRefreshEvent, self)
			else
				self.unRefreshEvent[iter_10_0] = false
			end
		end
	end
end

function RedPointService:rmvRedPointEventsListener(arg_11_1)
	for iter_11_0, iter_11_1 in pairs((table.keys(self._eventKeyCompMap))) do
		if self._eventKeyCompMap[iter_11_1] and self._eventKeyCompMap[iter_11_1][arg_11_1] then
			self._eventKeyCompMap[iter_11_1][arg_11_1] = nil

			if not next(self._eventKeyCompMap[iter_11_1]) then
				self._eventKeyCompMap[iter_11_1] = nil
				self.unRefreshEvent[iter_11_1] = true
			end
		end
	end
end

function RedPointService:_findRedPointComp(arg_12_1)
	if not arg_12_1 then
		return
	elseif tolua.isnull(arg_12_1) then
		return
	elseif arg_12_1.isRedPointComp then
		return arg_12_1
	else
		local var_12_0 = arg_12_1:getChild("redPointComp")

		if var_12_0 and var_12_0.isRedPointComp then
			return var_12_0
		else
			return self:_findRedPointCompWithDadList((arg_12_1:getChildren()))
		end
	end
end

function RedPointService:_findRedPointCompWithDadList(arg_13_1)
	if not arg_13_1 or #arg_13_1 < 1 then
		return
	end

	for iter_13_0, iter_13_1 in pairs(arg_13_1) do
		if iter_13_1.isRedPointComp then
			return iter_13_1
		end
	end

	local var_13_0 = {}

	for iter_13_2, iter_13_3 in pairs(arg_13_1) do
		for iter_13_4 = 0, iter_13_3:numChildren() - 1 do
			table.insert(var_13_0, iter_13_3:getChildAt(iter_13_4))
		end
	end

	return self:_findRedPointCompWithDadList(var_13_0)
end

return RedPointService

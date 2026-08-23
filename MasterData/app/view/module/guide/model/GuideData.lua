local var_0_0 = g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS
local GuideData = class("GuideData")

function GuideData:ctor()
	self:initData()
end

function GuideData:initData()
	self._savedData = {}
	self._wushFail = false

	self:_initFunctionGuideCfg()
end

function GuideData:_initFunctionGuideCfg()
	self._tickTypeGuideMap = {}
	self._tickTargetWeakGuideMap = {}

	for iter_3_0 = 1, g.core.config.function_guide_info.getLength() do
		local var_3_0 = {}
		local var_3_1 = g.core.config.function_guide_info.indexOf(iter_3_0)

		var_3_0.cfg = var_3_1
		var_3_0.ticked = false
		var_3_0.finished = false
		self._tickTypeGuideMap[var_3_1.id] = var_3_0
		self._tickTargetWeakGuideMap[var_3_1.weak_guide] = var_3_0
	end
end

function GuideData:updateFinishGuide(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs((arg_4_1 or nil) and (arg_4_1.ids or {})) do
		self._savedData[iter_4_1] = iter_4_1

		if iter_4_1 < var_0_0.START and self._tickTypeGuideMap[iter_4_1] then
			self._tickTypeGuideMap[iter_4_1].finished = true
		end
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_GUIDE_FLUSH)
end

function GuideData:onWeakGuideExec(arg_5_1)
	if self._tickTargetWeakGuideMap and self._tickTargetWeakGuideMap[arg_5_1] then
		if self._tickTargetWeakGuideMap[arg_5_1] then
			self:setGuideTickedFinish(self._tickTargetWeakGuideMap[arg_5_1].cfg.id)
		end
	end
end

function GuideData:setGuideTicked(arg_6_1)
	self._tickTypeGuideMap[arg_6_1].ticked = true
end

function GuideData:setGuideUnTicked(arg_7_1)
	self._tickTypeGuideMap[arg_7_1].ticked = false
end

function GuideData:setGuideTickedFinish(arg_8_1)
	self._tickTypeGuideMap[arg_8_1].finished = true

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_GUIDE_FLUSH)

	if self._savedData[arg_8_1] then
		return
	end

	g.core.network.GameNetProxy:send_C2S_Guide_Save({
		id = arg_8_1
	})

	self._savedData[arg_8_1] = arg_8_1
end

function GuideData:checkSkipState(arg_9_1)
	self._isCanSkip = self._tickTypeGuideMap[arg_9_1].cfg.if_skip == 1
end

function GuideData:isNeedShowSkip()
	return self._isCanSkip
end

function GuideData:clearSkipState()
	self._isCanSkip = false
end

function GuideData:getUnTickedGuide()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(self._tickTypeGuideMap) do
		if not iter_12_1.ticked and not iter_12_1.finished then
			table.insert(var_12_0, iter_12_1)
		end
	end

	return var_12_0
end

function GuideData:getTickedGuideList()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(self._tickTypeGuideMap) do
		if iter_13_1.ticked and not iter_13_1.finished then
			table.insert(var_13_0, iter_13_1)
		end
	end

	table.sort(var_13_0, function(arg_14_0, arg_14_1)
		return arg_14_0.cfg.sort_id < arg_14_1.cfg.sort_id
	end)

	return var_13_0
end

function GuideData:setSaveServerData(arg_15_1)
	if not self._savedData[arg_15_1] then
		self._savedData[arg_15_1] = arg_15_1

		g.core.network.GameNetProxy:send_C2S_Guide_Save({
			id = arg_15_1
		})
	end
end

function GuideData:getServerDataById(arg_16_1)
	return self._savedData[arg_16_1]
end

function GuideData:getTopGuide()
	return self:getTickedGuideList()[1]
end

function GuideData:setWushFightFail()
	self._wushFail = true
end

function GuideData:loadCache()
	self._guideUniqueCache = self._guideUniqueCache or g.core.common.Storage:load("guideUniqueSpeCache.json") or {}
end

function GuideData:isTickedCache(arg_20_1)
	arg_20_1 = tostring(arg_20_1)

	self:loadCache()

	if self._guideUniqueCache[arg_20_1] then
		return true
	end

	self._guideUniqueCache[arg_20_1] = true

	g.core.common.Storage:save("guideUniqueSpeCache.json", self._guideUniqueCache)

	return false
end

function GuideData:getWushFightFail()
	self._wushFail = false

	return self._wushFail
end

return GuideData

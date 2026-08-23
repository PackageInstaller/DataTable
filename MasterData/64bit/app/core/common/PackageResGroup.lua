local var_0_0 = 1
local PackageResGroup = class("PackageResGroup")

function PackageResGroup:ctor(arg_1_1)
	self._priority = 0
	self._groupId = var_0_0
	self._resList = {}
	self._resIndexMap = {}
	self._totalSize = 0
	self._cfg = nil
	self._isPause = false
	self._lasePauseValue = self._isPause

	if arg_1_1 then
		self:setCfgId(arg_1_1)
	end

	var_0_0 = var_0_0 + 1
end

function PackageResGroup:setCfgId(arg_2_1)
	self._cfg = g.core.config.split_download_reward_info.get(arg_2_1)
	self._priority = self._cfg.sort
end

function PackageResGroup:getCfg()
	return self._cfg
end

function PackageResGroup:setPriority(arg_4_1)
	self._priority = arg_4_1
end

function PackageResGroup:getPriority()
	return self._priority
end

function PackageResGroup:addPackageRes(arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = table.concat({
		arg_6_1,
		arg_6_2
	}, "_")

	if not self._resIndexMap[var_6_0] then
		self._resList[#self._resList + 1] = arg_6_3
		self._resIndexMap[var_6_0] = #self._resList + 1
		self._totalSize = self._totalSize + arg_6_3.size
	end
end

function PackageResGroup:getResItem(arg_7_1, arg_7_2)
	local var_7_0 = self:getResItemIndex(arg_7_1, arg_7_2)

	if var_7_0 ~= nil then
		return self._resList[var_7_0]
	end
end

function PackageResGroup:getResItemIndex(arg_8_1, arg_8_2)
	return self._resIndexMap[table.concat({
		arg_8_1,
		arg_8_2
	}, "_")]
end

function PackageResGroup:getNeedDownloadResItemList()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(self._resList) do
		if not self:_checkResItemIsFinish(iter_9_1) then
			var_9_0[#var_9_0 + 1] = iter_9_1
		end
	end

	return var_9_0
end

function PackageResGroup:getGroupId()
	return self._groupId
end

function PackageResGroup:getGroupSizeInfo()
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs(self._resList) do
		var_11_0 = var_11_0 + iter_11_1.finishedSize
	end

	return {
		finish = var_11_0,
		total = self._totalSize
	}
end

function PackageResGroup:isResItemFinish(arg_12_1, arg_12_2)
	local var_12_0 = self:getResItem(arg_12_1, arg_12_2)

	if var_12_0 then
		return self:_checkResItemIsFinish(var_12_0)
	end

	return false
end

function PackageResGroup:_checkResItemIsFinish(arg_13_1)
	return arg_13_1.unzip
end

function PackageResGroup:isFinishAll()
	local var_14_0 = true

	for iter_14_0, iter_14_1 in ipairs(self._resList) do
		if not self:_checkResItemIsFinish(iter_14_1) then
			var_14_0 = false
		end
	end

	return var_14_0
end

function PackageResGroup:setPause(arg_15_1)
	if self:isFinishAll() then
		self._isPause = false

		return
	end

	self._lasePauseValue = self._isPause
	self._isPause = arg_15_1
end

function PackageResGroup:isPause()
	return self._isPause
end

return PackageResGroup

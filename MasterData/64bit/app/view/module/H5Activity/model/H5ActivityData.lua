local var_0_0 = 10
local H5ActivityConst = require("app.view.module.H5Activity.const.H5ActivityConst")
local H5ActivityData = class("H5ActivityData")

function H5ActivityData:ctor()
	self:initData()
end

function H5ActivityData:initData()
	self._ruActivityList = {}
	self._h5ActivityInfo = {}
	self._infos = {}
end

function H5ActivityData:onH5ActivityGetInfo(arg_3_1)
	self._h5ActivityInfo = {}
	self._ruActivityList = {}

	local var_3_0 = g.core.platform.PlatformProxy:getOpId()

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.infos or {}) do
		local var_3_1 = iter_3_1.op_ids or ""

		if var_3_1 == "" or string.find(var_3_1, tostring(var_3_0)) then
			if iter_3_1.icon == var_0_0 then
				table.insert(self._ruActivityList, iter_3_1)
			else
				table.insert(self._h5ActivityInfo, iter_3_1)
			end
		end
	end

	self._infos = arg_3_1.activitys or {}
end

function H5ActivityData:onH5ActivityUpdate(arg_4_1)
	if arg_4_1.deletes then
		for iter_4_0, iter_4_1 in ipairs(arg_4_1.deletes) do
			for iter_4_2, iter_4_3 in ipairs(self._h5ActivityInfo) do
				if iter_4_3.activity_id == iter_4_1 then
					table.remove(self._h5ActivityInfo, iter_4_2)
				end
			end

			for iter_4_4, iter_4_5 in ipairs(self._ruActivityList) do
				if iter_4_5.activity_id == iter_4_1 then
					table.remove(self._h5ActivityInfo, iter_4_4)
				end
			end
		end
	end

	if arg_4_1.info then
		self._h5ActivityInfo = self._h5ActivityInfo or {}

		local var_4_0 = arg_4_1.info.op_ids or ""

		if var_4_0 == "" or string.find(var_4_0, tostring((g.core.platform.PlatformProxy:getOpId()))) then
			if arg_4_1.info.icon == var_0_0 then
				table.insert(self._ruActivityList, arg_4_1.info)
			else
				table.insert(self._h5ActivityInfo, arg_4_1.info)
			end
		end
	end
end

function H5ActivityData:getH5ActivityInfo()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(self._h5ActivityInfo) do
		local var_5_1, var_5_2 = self:checkAndGetIsOpen(iter_5_1)

		if var_5_1 then
			table.insert(var_5_0, {
				redId = 348,
				timeStyle = 0,
				info = iter_5_1,
				state = var_5_2
			})
		end
	end

	return var_5_0
end

function H5ActivityData:getSpH5ActivityInfo()
	if require("app.core.lang.MultilingualMgr"):getUseLang() ~= "ru" then
		return {}
	end

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(self._ruActivityList) do
		local var_6_1, var_6_2 = self:checkAndGetIsOpen(iter_6_1)

		if var_6_1 then
			table.insert(var_6_0, {
				redId = 348,
				timeStyle = 0,
				info = iter_6_1,
				state = var_6_2
			})
		end
	end

	return var_6_0
end

function H5ActivityData:checkAndGetIsOpen(arg_7_1)
	if g.core.common.ServerTime:getOpenDays() < arg_7_1.open_days then
		return false
	end

	local var_7_0 = g.core.model.User:getLevel()

	if var_7_0 < arg_7_1.start_level or var_7_0 > arg_7_1.end_level then
		return false
	end

	local var_7_1 = g.core.common.ServerTime:getTime()

	if var_7_1 > arg_7_1.end_time or var_7_1 < arg_7_1.preview_time then
		return false
	end

	if var_7_1 >= arg_7_1.preview_time and var_7_1 < arg_7_1.start_time then
		return true, H5ActivityConst.ACTIVITY_STATE.PREVIEW
	elseif var_7_1 >= arg_7_1.start_time and var_7_1 < arg_7_1.end_time then
		return true, H5ActivityConst.ACTIVITY_STATE.OPEN
	end

	return false
end

function H5ActivityData:checkIconRedPoint(arg_8_1)
	if arg_8_1 and arg_8_1.actId then
		self:checkAndLoadCache()

		local var_8_0 = g.core.common.ServerTime:getDateObject()

		if self._showSaveCache[var_8_0.year .. "_" .. var_8_0.month .. "_" .. var_8_0.day .. arg_8_1.actId] then
			return false
		end

		return true
	end

	return false
end

function H5ActivityData:saveTodayClickState(arg_9_1)
	if not arg_9_1 then
		return
	end

	self:checkAndLoadCache()

	local var_9_0 = g.core.common.ServerTime:getDateObject()

	self._showSaveCache[var_9_0.year .. "_" .. var_9_0.month .. "_" .. var_9_0.day .. arg_9_1] = true

	g.core.common.Storage:save("h5_game_cache.json", self._showSaveCache)
end

function H5ActivityData:checkAndLoadCache()
	self._showSaveCache = self._showSaveCache or g.core.common.Storage:load("h5_game_cache.json") or {}
end

return H5ActivityData

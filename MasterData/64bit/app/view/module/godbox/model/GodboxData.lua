local GodboxData = class("GodboxData")
local var_0_1 = g.core.config.god_box_info

function GodboxData:ctor()
	self:initData()
end

function GodboxData:initData()
	self.STATE_CAN_BUY = 1
	self.STATE_CAN_NOT_BUY = 0
	self._customCfgMap = {}
	self._curDatas = {}
	self._curDatasMap = {}

	local var_2_0 = g.core.common.ServerTime:getTime()

	self._curId = 0

	self:_initBaseInfo()
end

function GodboxData:_initBaseInfo()
	self.hasWarned = (g.core.common.Storage:load("godbox.json") or {}).hasWarned or {}
end

function GodboxData:updateGodbox(arg_4_1, arg_4_2)
	if not arg_4_2 then
		self._customCfgMap = {}

		for iter_4_0, iter_4_1 in ipairs(arg_4_1.statics or {}) do
			for iter_4_2, iter_4_3 in ipairs(iter_4_1.packages or {}) do
				self._customCfgMap[iter_4_3.box_id] = self:_packCustomCfg(iter_4_3, iter_4_1)
			end
		end
	end

	local var_4_1 = {}

	if arg_4_1.box_info then
		for iter_4_4, iter_4_5 in ipairs(arg_4_1.box_info) do
			if iter_4_5.isAward == 0 then
				local var_4_2
				local var_4_3 = {}

				if iter_4_5.groupId > 0 then
					var_4_2 = var_0_1.get(iter_4_5.config_id).toObject()
					var_4_3 = g.core.common.Drops:getGoodsArray(var_4_2.drop_id)
				else
					var_4_2 = self._customCfgMap[iter_4_5.config_id]

					if self._customCfgMap[iter_4_5.config_id] then
						var_4_3 = var_4_2.awards
					end
				end

				if var_4_2 then
					var_4_1[iter_4_5.box_id] = {
						id = iter_4_5.box_id,
						configId = iter_4_5.config_id,
						state = iter_4_5.buy_status,
						endTime = iter_4_5.end_time,
						groupId = iter_4_5.groupId,
						cfg = var_4_2,
						awards = var_4_3
					}
				end
			end
		end
	end

	self._curDatasMap = var_4_1

	self:_syncArrData()
end

function GodboxData:_packCustomCfg(arg_5_1, arg_5_2)
	local var_5_0 = {
		min_level = 0,
		max_vip = 9999,
		min_vip = 0,
		group = 0,
		id = 0,
		buy_value = 0,
		buy_type = 0,
		type_desc = "",
		max_level = 9999,
		box_type = arg_5_1.price == 0 and 1 or 2,
		buy_num = arg_5_1.price,
		show_price = arg_5_1.ori_price
	}

	var_5_0.box_desc = arg_5_1.desc or ""
	var_5_0.time = arg_5_2.expire
	var_5_0.red_time = arg_5_2.warnning
	var_5_0.title = arg_5_2.title
	var_5_0.awards = arg_5_1.reward or {}

	return var_5_0
end

function GodboxData:sortData()
	self._curDatas = g.core.common.ActivitySort:listSortRecharge(g.core.common.ActivitySort:getSortTp(), self._curDatas, function(arg_7_0, arg_7_1)
		if arg_7_0.state ~= arg_7_1.state then
			return arg_7_0.state > arg_7_1.state
		end

		local var_7_0 = arg_7_0.cfg
		local var_7_1 = arg_7_1.cfg

		if arg_7_0.cfg.box_type ~= arg_7_1.cfg.box_type then
			return var_7_0.box_type < var_7_1.box_type
		end

		if var_7_0.buy_num ~= var_7_1.buy_num then
			return var_7_0.buy_num < var_7_1.buy_num
		end

		if arg_7_0.endTime ~= arg_7_1.endTime then
			return arg_7_0.endTime < arg_7_1.endTime
		end

		return var_7_0.id < var_7_1.id
	end, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_1.cfg

		if arg_8_0.cfg.box_type ~= arg_8_1.cfg.box_type then
			return arg_8_0.cfg.box_type < var_8_0.box_type
		end

		if arg_8_0.cfg.buy_num ~= var_8_0.buy_num then
			return arg_8_0.cfg.buy_num < var_8_0.buy_num
		end

		if arg_8_0.endTime ~= arg_8_1.endTime then
			return arg_8_0.endTime < arg_8_1.endTime
		end

		return arg_8_0.cfg.id < var_8_0.id
	end)
end

function GodboxData:_syncArrData()
	self._curDatas = {}

	for iter_9_0, iter_9_1 in pairs(self._curDatasMap) do
		table.insert(self._curDatas, iter_9_1)
	end

	self:sortData()
end

function GodboxData:getCurIndex(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(self._curDatas) do
		if iter_10_1.id == arg_10_1 then
			return iter_10_0 - 1
		end
	end

	return 0
end

function GodboxData:getRebate(arg_11_1)
	local var_11_0 = 100000
	local var_11_1 = g.core.config.parameter_info.fetch(g.core.const.ConstMgr.PARAMETER_CONST.GODBOX_REBATE)
	local var_11_2, var_11_3

	if var_11_1 then
		var_11_0 = var_11_1.parameter
		var_11_2 = 0
		var_11_3 = {}
	end

	for iter_11_0 in string.gmatch(math.floor(arg_11_1.show_price * 1000000 / (arg_11_1.buy_num * var_11_0)), "%d") do
		var_11_2 = var_11_2 + 1

		table.insert(var_11_3, iter_11_0)
	end

	return var_11_2, var_11_3
end

function GodboxData:getNeedWarnIndex()
	for iter_12_0 = 1, #self._curDatas do
		if self._curDatas[iter_12_0].endTime - g.core.common.ServerTime:getTime() < self._curDatas[iter_12_0].cfg.red_time and not self.hasWarned[tostring(self._curDatas[iter_12_0].id)] then
			return iter_12_0
		end
	end

	return 0
end

function GodboxData:getNeedWarnIndexWithoutRecord()
	for iter_13_0 = 1, #self._curDatas do
		if self._curDatas[iter_13_0].endTime - g.core.common.ServerTime:getTime() < self._curDatas[iter_13_0].cfg.red_time then
			return iter_13_0
		end
	end

	return 0
end

function GodboxData:checkData()
	local var_14_0 = g.core.common.ServerTime:getTime()

	for iter_14_0 = #self._curDatas, 1, -1 do
		if var_14_0 > self._curDatas[iter_14_0].endTime then
			self._curDatasMap[self._curDatas[iter_14_0].id] = nil

			table.remove(self._curDatas, iter_14_0)
		end
	end
end

function GodboxData:checkHasAward()
	for iter_15_0 = 1, #self._curDatas do
		if self:checkHasAwardById(self._curDatas[iter_15_0].id) then
			return true
		end
	end

	return false
end

function GodboxData:checkHasAwardById(arg_16_1)
	local var_16_0 = self:getData(arg_16_1)

	if var_16_0 then
		local var_16_1 = var_16_0.cfg or nil

		if var_16_0 and var_16_0.state == self.STATE_CAN_BUY and (var_16_1.box_type == 1 or var_16_1.box_type == 2) then
			return true
		end
	end

	return false
end

function GodboxData:updateShopping(arg_17_1)
	self:clearData(arg_17_1.box_id or self._curId)
end

function GodboxData:clearData(arg_18_1)
	self._curDatasMap[arg_18_1] = nil

	self:_syncArrData()
end

function GodboxData:clearHasNew()
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs(self._curDatasMap) do
		var_19_0[iter_19_1.groupId .. "_" .. iter_19_1.id] = true
	end

	g.core.common.Storage:save("godbox_new.json", var_19_0)
end

function GodboxData:saveHasWarned(arg_20_1)
	self.hasWarned[tostring(arg_20_1)] = true

	g.core.common.Storage:save("godbox.json", {
		hasWarned = self.hasWarned
	})
end

function GodboxData:getData(arg_21_1)
	return self._curDatasMap[arg_21_1]
end

function GodboxData:getCurDatas()
	return self._curDatas
end

function GodboxData:getCurDatasMap()
	return self._curDatasMap
end

function GodboxData:hasData()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.GODBOX) then
		return
	end

	return next(self._curDatas)
end

function GodboxData:getHasNew()
	local var_25_0 = g.core.common.Storage:load("godbox_new.json") or {}

	for iter_25_0, iter_25_1 in pairs(self._curDatasMap) do
		if not var_25_0[iter_25_1.groupId .. "_" .. iter_25_1.id] then
			return true
		end
	end

	return false
end

function GodboxData:setCurId(arg_26_1)
	self._curId = arg_26_1
end

function GodboxData:getCurId()
	return self._curId
end

return GodboxData

local var_0_0 = g.core.const.ConstMgr.ActivityConst
local ActivityFundData = class("ActivityFundData")

function ActivityFundData:ctor()
	self:initData()
end

function ActivityFundData:initData()
	self._isRecharge = {}
	self._fundList = {}
	self._fundMap = {}
	self._activeNum = {}
	self._receiveFlag = {}
	self._welfareFlag = {}
	self._receiveIdList = {}
	self._maxWushuangLayer = 0
	self._fundCfgInfoMap = {}
	self._fundTypeMap = {}
	self._lastFundData = nil
	self._fundRechargeDemoCfg = {}

	self:_initFundData()
end

function ActivityFundData:_initFundData()
	self._receiveFlag = {}

	for iter_3_0, iter_3_1 in g.core.config.fund_info.ipairs() do
		self._fundMap[iter_3_1.stage] = self._fundMap[iter_3_1.stage] or {}

		table.insert(self._fundMap[iter_3_1.stage], {
			state = 0,
			info = iter_3_1
		})

		if not self._fundCfgInfoMap[iter_3_1.stage] and iter_3_1.period ~= 0 then
			self._fundCfgInfoMap[iter_3_1.stage] = iter_3_1
		end

		self._fundTypeMap[iter_3_1.fund_type] = self._fundTypeMap[iter_3_1.fund_type] or {}
		self._fundRechargeDemoCfg[iter_3_1.fund_type] = self._fundRechargeDemoCfg[iter_3_1.fund_type] or {}
		self._fundRechargeDemoCfg[iter_3_1.fund_type][iter_3_1.stage] = self._fundRechargeDemoCfg[iter_3_1.fund_type][iter_3_1.stage] or iter_3_1

		table.insert(self._fundTypeMap[iter_3_1.fund_type], {
			state = 0,
			info = iter_3_1
		})
	end
end

function ActivityFundData:getRechargeDemo(arg_4_1, arg_4_2)
	return self._fundRechargeDemoCfg[arg_4_1][arg_4_2]
end

function ActivityFundData:updateWuShuangMaxLayer(arg_5_1)
	self._maxWushuangLayer = arg_5_1 or 0
end

function ActivityFundData:updateWushLayer()
	local var_6_0 = g.core.model.User.wushData:getCurFloorId() - 1

	if var_6_0 > self._maxWushuangLayer then
		self._maxWushuangLayer = var_6_0

		self:updateCanGetAward()
	end
end

function ActivityFundData:getWuShuangMaxLayer()
	self:updateWushLayer()

	return self._maxWushuangLayer
end

function ActivityFundData:updateFundData(arg_8_1)
	if not arg_8_1 then
		return
	end

	self._lastFundData = arg_8_1

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		self._activeNum[iter_8_1.id or 4] = iter_8_1.active_num
	end

	for iter_8_2, iter_8_3 in ipairs(arg_8_1) do
		local var_8_1 = iter_8_3.id or 4

		self._isRecharge[var_8_1] = iter_8_3.is_buy or false

		local var_8_2 = iter_8_3.ids or {}

		self._receiveFlag[var_8_1] = {}

		local var_8_3 = self._fundCfgInfoMap[var_8_1].fund_type
		local var_8_4 = 1

		if self._fundCfgInfoMap[var_8_1].fund_type == var_0_0.ACTIVITY_FUND_TYPE.GROWTH then
			var_8_4 = g.core.model.User:getLevel()
		elseif var_8_3 == var_0_0.ACTIVITY_FUND_TYPE.ZHUXIAN then
			var_8_4 = g.core.model.User.dungeonData:getPassedChapterNum()
		elseif var_8_3 == var_0_0.ACTIVITY_FUND_TYPE.WUSHUANG then
			self:updateWushLayer()

			var_8_4 = self._maxWushuangLayer
		elseif var_8_3 == var_0_0.ACTIVITY_FUND_TYPE.MYSTERY then
			var_8_4 = g.core.model.User.mysteryData:getLastPassChapterId()
		elseif var_8_3 == var_0_0.ACTIVITY_FUND_TYPE.TOWER then
			var_8_4 = g.core.model.User.towerData:getTowerIdByType(g.core.const.ConstMgr.TowerConst.TOWER_TYPE.MAIN)
		end

		if self._fundMap[var_8_1] then
			for iter_8_4, iter_8_5 in ipairs(self._fundMap[var_8_1]) do
				if iter_8_5.info.type == g.core.const.ConstMgr.RechargeConst.FUND_TYPE.NORMAL and var_8_4 >= iter_8_5.info.num then
					self._receiveFlag[var_8_1][iter_8_5.info.id] = true
					iter_8_5.state = 1
				end

				if iter_8_5.info.type == g.core.const.ConstMgr.RechargeConst.FUND_TYPE.ADVANCE and var_8_4 >= iter_8_5.info.num and iter_8_3.is_buy then
					self._receiveFlag[var_8_1][iter_8_5.info.id] = true
					iter_8_5.state = 1
				end

				for iter_8_6, iter_8_7 in ipairs(var_8_2) do
					if iter_8_7 == iter_8_5.info.id and iter_8_5.info.type ~= g.core.const.ConstMgr.RechargeConst.FUND_TYPE.WELFARE then
						self._receiveFlag[var_8_1][iter_8_7] = false
						iter_8_5.state = 2

						break
					end
				end
			end
		end

		if self:getIsHaveWelfare(var_8_1) then
			self._receiveIdList[var_8_3] = var_8_2 or {}
		end

		self._welfareFlag[var_8_3] = self._welfareFlag[var_8_3] or {}

		for iter_8_8, iter_8_9 in ipairs(self._fundTypeMap[var_8_3]) do
			if iter_8_9.info.type == g.core.const.ConstMgr.RechargeConst.FUND_TYPE.WELFARE then
				if iter_8_9.info.num <= self:getActiveNumByType(var_8_3) then
					self._welfareFlag[var_8_3][iter_8_9.info.id] = true
					iter_8_9.state = 1
				end

				for iter_8_10, iter_8_11 in ipairs(self._receiveIdList[var_8_3] or {}) do
					if iter_8_11 == iter_8_9.info.id then
						self._welfareFlag[var_8_3][iter_8_11] = false
						iter_8_9.state = 2

						break
					end
				end
			end
		end
	end
end

function ActivityFundData:getIsHaveWelfare(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs((g.core.config.fund_info.match(function(arg_10_0)
		return arg_10_0.stage == arg_9_1
	end))) do
		if iter_9_1.type == g.core.const.ConstMgr.RechargeConst.FUND_TYPE.WELFARE then
			return true
		end
	end

	return false
end

function ActivityFundData:updateFundByOpRecharge(arg_11_1)
	if arg_11_1.insert then
		self:updateFundData(arg_11_1.insert)
	end

	if arg_11_1.update then
		self:updateFundData(arg_11_1.update)
	end
end

function ActivityFundData:getFundAdvanceAward(arg_12_1)
	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = 1

	if self._fundCfgInfoMap[arg_12_1].fund_type == var_0_0.ACTIVITY_FUND_TYPE.GROWTH then
		var_12_2 = g.core.model.User:getLevel()
	elseif self._fundCfgInfoMap[arg_12_1].fund_type == var_0_0.ACTIVITY_FUND_TYPE.ZHUXIAN then
		var_12_2 = g.core.model.User.dungeonData:getPassedChapterNum()
	elseif self._fundCfgInfoMap[arg_12_1].fund_type == var_0_0.ACTIVITY_FUND_TYPE.WUSHUANG then
		self:updateWushLayer()

		var_12_2 = self._maxWushuangLayer
	elseif self._fundCfgInfoMap[arg_12_1].fund_type == var_0_0.ACTIVITY_FUND_TYPE.MYSTERY then
		var_12_2 = g.core.model.User.mysteryData:getLastPassChapterId()
	elseif self._fundCfgInfoMap[arg_12_1].fund_type == var_0_0.ACTIVITY_FUND_TYPE.TOWER then
		var_12_2 = g.core.model.User.towerData:getTowerIdByType(g.core.const.ConstMgr.TowerConst.TOWER_TYPE.MAIN)
	end

	for iter_12_0, iter_12_1 in ipairs(self._fundMap[arg_12_1]) do
		if iter_12_1.info.type == g.core.const.ConstMgr.RechargeConst.FUND_TYPE.ADVANCE then
			if var_12_2 >= iter_12_1.info.num then
				table.insert(var_12_1, iter_12_1)
			end

			table.insert(var_12_0, iter_12_1)
		end
	end

	return self:getMergeData(var_12_1), self:getMergeData(var_12_0)
end

function ActivityFundData:getMergeData(arg_13_1)
	local var_13_0 = {}
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		var_13_0[iter_13_1.info.reward_type_1] = var_13_0[iter_13_1.info.reward_type_1] or {}
		var_13_0[iter_13_1.info.reward_type_1][iter_13_1.info.reward_value_1] = not var_13_0[iter_13_1.info.reward_type_1][iter_13_1.info.reward_value_1] and iter_13_1.info.reward_size_1 or var_13_0[iter_13_1.info.reward_type_1][iter_13_1.info.reward_value_1] + iter_13_1.info.reward_size_1
	end

	for iter_13_2, iter_13_3 in pairs(var_13_0) do
		for iter_13_4, iter_13_5 in pairs(iter_13_3) do
			table.insert(var_13_1, {
				type = iter_13_2,
				value = iter_13_4,
				size = iter_13_5
			})
		end
	end

	return var_13_1
end

function ActivityFundData:getFundData(arg_14_1)
	local var_14_0 = {}
	local var_14_1, var_14_2 = self:getFundDataByType(g.core.const.ConstMgr.RechargeConst.FUND_TYPE.NORMAL, arg_14_1)
	local var_14_3, var_14_4 = self:getFundDataByType(g.core.const.ConstMgr.RechargeConst.FUND_TYPE.ADVANCE, arg_14_1)

	for iter_14_0 = 1, #var_14_1 do
		local var_14_6 = {
			normal = var_14_1[iter_14_0]
		}

		var_14_6.advance = var_14_3[iter_14_0] or {}

		table.insert(var_14_0, var_14_6)
	end

	return var_14_0, var_14_2 == 0 and var_14_4 == 0 and 1 or var_14_2 > 0 and var_14_4 > 0 and math.min(var_14_2, var_14_4) or math.max(var_14_2, var_14_4)
end

function ActivityFundData:getFundDataByType(arg_15_1, arg_15_2)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(self._fundMap[arg_15_2]) do
		if iter_15_1.info.type == arg_15_1 then
			table.insert(var_15_0, iter_15_1)
		end
	end

	table.sort(var_15_0, function(arg_16_0, arg_16_1)
		if tonumber(arg_16_0.info.num) ~= tonumber(arg_16_1.info.num) then
			return tonumber(arg_16_0.info.num) < tonumber(arg_16_1.info.num)
		end
	end)

	local var_15_1 = 0

	for iter_15_2, iter_15_3 in ipairs(var_15_0) do
		if iter_15_3.state == 1 then
			var_15_1 = iter_15_2

			break
		end
	end

	return var_15_0, var_15_1
end

function ActivityFundData:getFundWelfareDataByType(arg_17_1)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(self._fundTypeMap[arg_17_1]) do
		if iter_17_1.info.type == g.core.const.ConstMgr.RechargeConst.FUND_TYPE.WELFARE then
			table.insert(var_17_0, iter_17_1)
		end
	end

	table.sort(var_17_0, function(arg_18_0, arg_18_1)
		if arg_18_0.state == 2 ~= (arg_18_1.state == 2) then
			return arg_18_0.state ~= 2
		end

		if tonumber(arg_18_0.info.num) ~= tonumber(arg_18_1.info.num) then
			return tonumber(arg_18_0.info.num) < tonumber(arg_18_1.info.num)
		end
	end)

	local var_17_1 = 1

	for iter_17_2, iter_17_3 in ipairs(var_17_0) do
		if iter_17_3.state ~= 2 then
			var_17_1 = iter_17_2

			break
		end
	end

	return var_17_0, var_17_1
end

function ActivityFundData:updateCanGetAward()
	for iter_19_0, iter_19_1 in pairs(self._fundMap) do
		for iter_19_2, iter_19_3 in ipairs(iter_19_1) do
			if iter_19_3.info.fund_type == var_0_0.ACTIVITY_FUND_TYPE.WUSHUANG then
				self:updateWushLayer()

				if iter_19_3.info.type == g.core.const.ConstMgr.RechargeConst.FUND_TYPE.NORMAL and self._maxWushuangLayer >= iter_19_3.info.num then
					self._receiveFlag[iter_19_0][iter_19_3.info.id] = true

					if iter_19_3.state == 0 then
						iter_19_3.state = 1
					end
				end

				if iter_19_3.info.type == g.core.const.ConstMgr.RechargeConst.FUND_TYPE.ADVANCE and self._maxWushuangLayer >= iter_19_3.info.num and self._isRecharge[iter_19_0] then
					self._receiveFlag[iter_19_0][iter_19_3.info.id] = true

					if iter_19_3.state == 0 then
						iter_19_3.state = 1
					end
				end

				for iter_19_4, iter_19_5 in pairs(self._receiveIdList[iter_19_3.info.fund_type] or {}) do
					if iter_19_5 == iter_19_3.info.id and iter_19_3.info.type ~= g.core.const.ConstMgr.RechargeConst.FUND_TYPE.WELFARE then
						self._receiveFlag[iter_19_0][iter_19_5] = false
						iter_19_3.state = 2

						break
					end
				end
			end
		end
	end
end

function ActivityFundData:getActiveNum(arg_20_1)
	return self._activeNum[arg_20_1]
end

function ActivityFundData:getRIdByFundTypeAndPeriod(arg_21_1, arg_21_2)
	for iter_21_0, iter_21_1 in pairs(self._fundCfgInfoMap) do
		if iter_21_1.fund_type == arg_21_1 and iter_21_1.period == arg_21_2 then
			return iter_21_1.stage
		end
	end
end

function ActivityFundData:getActiveNumByType(arg_22_1)
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in pairs(self._activeNum) do
		if self._fundCfgInfoMap[iter_22_0] and self._fundCfgInfoMap[iter_22_0].fund_type == arg_22_1 then
			var_22_0 = var_22_0 + iter_22_1
		end
	end

	return var_22_0
end

function ActivityFundData:getStageByType(arg_23_1)
	local var_23_0 = 1
	local var_23_1 = g.core.config.fund_info.match(function(arg_24_0)
		return arg_24_0.fund_type == arg_23_1
	end)
	local var_23_2 = 0

	if arg_23_1 == var_0_0.ACTIVITY_FUND_TYPE.GROWTH then
		var_23_2 = g.core.model.User:getLevel()
	elseif arg_23_1 == var_0_0.ACTIVITY_FUND_TYPE.ZHUXIAN then
		var_23_2 = g.core.model.User.dungeonData:getPassedChapterNum()
	elseif arg_23_1 == var_0_0.ACTIVITY_FUND_TYPE.WUSHUANG then
		self:updateWushLayer()

		var_23_2 = self._maxWushuangLayer
	elseif arg_23_1 == var_0_0.ACTIVITY_FUND_TYPE.MYSTERY then
		var_23_2 = g.core.model.User.mysteryData:getLastPassChapterId()
	elseif arg_23_1 == var_0_0.ACTIVITY_FUND_TYPE.TOWER then
		var_23_2 = g.core.model.User.towerData:getTowerIdByType(g.core.const.ConstMgr.TowerConst.TOWER_TYPE.MAIN)
	end

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		if iter_23_1.period_num and var_23_2 >= iter_23_1.period_num then
			var_23_0 = math.max(var_23_0, iter_23_1.period)
		end
	end

	return var_23_0
end

function ActivityFundData:isRechargeFund(arg_25_1)
	return self._isRecharge[arg_25_1]
end

function ActivityFundData:isRechargeFundByType(arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(self._fundTypeMap[arg_26_1]) do
		if iter_26_1.info.type == g.core.const.ConstMgr.RechargeConst.FUND_TYPE.ADVANCE and not self._isRecharge[iter_26_1.info.stage] then
			return false
		end
	end

	return true
end

function ActivityFundData:getWelfareState(arg_27_1)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(self._fundTypeMap[arg_27_1]) do
		if iter_27_1.info.type == g.core.const.ConstMgr.RechargeConst.FUND_TYPE.WELFARE then
			table.insert(var_27_0, iter_27_1)
		end
	end

	local var_27_1 = true

	for iter_27_2, iter_27_3 in ipairs(var_27_0) do
		if iter_27_3.state ~= 2 then
			var_27_1 = false
		end

		if iter_27_3.state == 1 then
			return 1
		end
	end

	if var_27_1 then
		return 2
	else
		return 0
	end
end

function ActivityFundData:canReceive(arg_28_1)
	if not self._receiveFlag[arg_28_1] then
		return
	end

	for iter_28_0, iter_28_1 in pairs(self._receiveFlag[arg_28_1]) do
		if iter_28_1 then
			return true
		end
	end

	return false
end

function ActivityFundData:canRewardLevelFund()
	return self:canGetFundReward(var_0_0.ACTIVITY_FUND_TYPE.GROWTH)
end

function ActivityFundData:canRewardDungeonFund()
	if self._lastFundData then
		self:updateFundData(self._lastFundData)
	end

	return self:canGetFundReward(var_0_0.ACTIVITY_FUND_TYPE.ZHUXIAN)
end

function ActivityFundData:canRewardWushFund()
	return self:canGetFundReward(var_0_0.ACTIVITY_FUND_TYPE.WUSHUANG)
end

function ActivityFundData:canRewardMysteryFund()
	return self:canGetFundReward(var_0_0.ACTIVITY_FUND_TYPE.MYSTERY)
end

function ActivityFundData:canRewardLevelWelfare()
	return self:canGetFundWelfare(var_0_0.ACTIVITY_FUND_TYPE.GROWTH)
end

function ActivityFundData:canRewardDungeonWelfare()
	return self:canGetFundWelfare(var_0_0.ACTIVITY_FUND_TYPE.ZHUXIAN)
end

function ActivityFundData:canRewardWushWelfare()
	return self:canGetFundWelfare(var_0_0.ACTIVITY_FUND_TYPE.WUSHUANG)
end

function ActivityFundData:canRewardMysteryWelfare()
	return self:canGetFundWelfare(var_0_0.ACTIVITY_FUND_TYPE.MYSTERY)
end

function ActivityFundData:canGetFundWelfare(arg_37_1)
	if not self._welfareFlag[arg_37_1] then
		return
	end

	for iter_37_0, iter_37_1 in pairs(self._welfareFlag[arg_37_1]) do
		if iter_37_1 then
			return true
		end
	end

	return false
end

function ActivityFundData:getFirstCanRecStage(arg_38_1)
	for iter_38_0 = 1, self:getStageByType(arg_38_1) do
		if self:canReceive((self:getRIdByFundTypeAndPeriod(arg_38_1, iter_38_0))) then
			return iter_38_0
		end
	end

	return 1
end

function ActivityFundData:canGetFundReward(arg_39_1)
	if not self._welfareFlag[arg_39_1] then
		return
	end

	for iter_39_0 = 1, self:getStageByType(arg_39_1) do
		if self:canReceive((self:getRIdByFundTypeAndPeriod(arg_39_1, iter_39_0))) then
			return true
		end
	end

	return false
end

function ActivityFundData:canReceiveByFundType(arg_40_1)
	if not self._welfareFlag[arg_40_1] then
		return
	end

	for iter_40_0, iter_40_1 in pairs(self._welfareFlag[arg_40_1]) do
		if iter_40_1 then
			return true
		end
	end

	for iter_40_2 = 1, self:getStageByType(arg_40_1) do
		if self:canReceive((self:getRIdByFundTypeAndPeriod(arg_40_1, iter_40_2))) then
			return true
		end
	end

	return false
end

function ActivityFundData:updateWelfareState(arg_41_1)
	if not arg_41_1 then
		return false
	end

	self._activeNum[arg_41_1.sub_type] = arg_41_1.value

	self:_updateWelfareNum(arg_41_1.sub_type)
end

function ActivityFundData:updateFundNumByNotify(arg_42_1)
	if arg_42_1 then
		self._activeNum[arg_42_1.activity_id] = arg_42_1.num

		self:_updateWelfareNum(arg_42_1.activity_id)
	end
end

function ActivityFundData:_updateWelfareNum(arg_43_1)
	if not self._fundCfgInfoMap[arg_43_1] then
		return
	end

	local var_43_0 = self._fundCfgInfoMap[arg_43_1].fund_type
	local var_43_1 = {}

	for iter_43_0, iter_43_1 in ipairs(self._fundTypeMap[self._fundCfgInfoMap[arg_43_1].fund_type] or {}) do
		if iter_43_1.info.type == g.core.const.ConstMgr.RechargeConst.FUND_TYPE.WELFARE and iter_43_1.info.num <= self:getActiveNumByType(var_43_0) then
			table.insert(var_43_1, iter_43_1.info.id)
		end
	end

	for iter_43_2, iter_43_3 in ipairs(var_43_1) do
		self._welfareFlag[var_43_0] = self._welfareFlag[var_43_0] or {}
		self._welfareFlag[var_43_0][iter_43_3] = true
	end

	for iter_43_4, iter_43_5 in ipairs(self._receiveIdList[var_43_0] or {}) do
		self._welfareFlag[var_43_0] = self._welfareFlag[var_43_0] or {}
		self._welfareFlag[var_43_0][iter_43_5] = false
	end
end

return ActivityFundData

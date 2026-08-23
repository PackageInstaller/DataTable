local var_0_0 = g.core.config.server_pass_info
local var_0_1 = g.core.config.server_pass_reward_info
local var_0_2 = g.core.config.server_pass_pay_info
local var_0_3 = g.core.const.ConstMgr.ServerPassActivityConst
local ServerPassActivity = class("ServerPassActivity")

function ServerPassActivity:ctor()
	self:initData()
end

function ServerPassActivity:initData()
	self._id = 0
	self._cfg = nil
	self._awardIndexDic = {}
	self._awardList = {}
	self._payStatue = 0
	self._payInfoList = {}
	self._curLevelExp = 0
	self._curPassExp = 0
	self._curLv = 0
end

function ServerPassActivity:_getAwardList(arg_3_1, arg_3_2)
	local var_3_0 = g.core.common.GlobalFunc
	local var_3_1 = g.core.common.Drops:getGoodsArray(arg_3_1[g.core.common.GlobalFunc.contactParamByString("reward_drop_", arg_3_2)])

	if arg_3_1.prize_type == 1 then
		for iter_3_0, iter_3_1 in ipairs(var_3_1) do
			iter_3_1.isRare = true
		end
	end

	table.sort(var_3_1, function(arg_4_0, arg_4_1)
		if arg_4_0.quality ~= arg_4_1.quality then
			return arg_4_0.quality > arg_4_1.quality
		end

		return arg_4_0.value < arg_4_1.value
	end)

	local var_3_2 = var_3_0.contactParamByString("privilege_effect_", arg_3_2)
	local var_3_3 = g.core.const.ConstMgr.QUALITY_TYPE

	if var_0_1.hasKey(var_3_2) then
		local var_3_4 = arg_3_1[var_3_2]

		if arg_3_1[var_3_2] ~= 0 then
			table.insert(var_3_1, 1, {
				isPrivilege = true,
				type = var_3_4,
				value = arg_3_1[var_3_0.contactParamByString("privilege_value_", arg_3_2)],
				icon = g.core.common.Path:getItemIconById(arg_3_1[var_3_0.contactParamByString("privilege_icon_", arg_3_2)]),
				quality = var_3_3.SSR,
				isRare = arg_3_1.prize_type == 1
			})
		end
	end

	return var_3_1
end

function ServerPassActivity:_getRareAward(arg_5_1)
	local var_5_0 = {}

	if arg_5_1.show_type ~= 0 then
		var_5_0[#var_5_0 + 1] = g.core.common.Goods:convert({
			size = 0,
			type = arg_5_1.show_type,
			value = arg_5_1.show_value
		})
	end

	for iter_5_0 = 2, 999 do
		local var_5_1 = g.core.common.GlobalFunc.contactParamByString("show_type_", iter_5_0)

		if var_0_2.hasKey(var_5_1) then
			if arg_5_1[var_5_1] ~= 0 then
				var_5_0[#var_5_0 + 1] = g.core.common.Goods:convert({
					size = 0,
					type = arg_5_1[var_5_1],
					value = arg_5_1[g.core.common.GlobalFunc.contactParamByString("show_value_", iter_5_0)]
				})
			end
		else
			break
		end
	end

	return var_5_0
end

function ServerPassActivity:_mergeItemToDic(arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1.isPrivilege then
		local var_6_0 = arg_6_2[arg_6_1.type]

		if not arg_6_2[arg_6_1.type] then
			var_6_0 = clone(arg_6_1)
			var_6_0.value = 0
			arg_6_2[arg_6_1.type] = var_6_0
		end

		var_6_0.value = var_6_0.value + arg_6_1.value
	else
		local var_6_1 = g.core.common.GlobalFunc.contactParamByString(arg_6_1.type, arg_6_1.value)
		local var_6_2 = arg_6_3[var_6_1]

		if not arg_6_3[var_6_1] then
			var_6_2 = clone(arg_6_1)
			var_6_2.size = 0
			arg_6_3[var_6_1] = var_6_2
		end

		var_6_2.size = var_6_2.size + arg_6_1.size
	end
end

function ServerPassActivity:setId(arg_7_1)
	if arg_7_1 == 0 then
		self:initData()

		return
	end

	if self._id == arg_7_1 then
		return
	end

	self._id = arg_7_1
	self._cfg = var_0_0.get(arg_7_1)
	self._awardList = {}
	self._awardIndexDic = {}

	local var_7_0 = {}

	for iter_7_0 = var_0_3.PAY_TYPE.FREE, var_0_3.PAY_TYPE.PAY_TYPE_ADVANCE do
		var_7_0[iter_7_0 + 1] = {
			privilegeDic = {},
			awardDic = {},
			list = {}
		}
	end

	for iter_7_1 = 1, var_0_1.getLength() do
		local var_7_1 = var_0_1.indexOf(iter_7_1)

		if var_7_1.order == self._id then
			local var_7_2 = {}

			for iter_7_2 = 1, 3 do
				local var_7_3 = self:_getAwardList(var_7_1, iter_7_2)

				var_7_2[iter_7_2] = var_7_3

				for iter_7_3, iter_7_4 in ipairs(var_7_3) do
					self:_mergeItemToDic(iter_7_4, var_7_0[iter_7_2].privilegeDic, var_7_0[iter_7_2].awardDic)
				end
			end

			local var_7_4 = {
				getSign = 0,
				cfg = var_7_1,
				awardGroupList = var_7_2
			}

			self._awardList[#self._awardList + 1] = var_7_4
			self._awardIndexDic[var_7_1.level] = var_7_4
		end
	end

	for iter_7_5 = var_0_3.PAY_TYPE.FREE, var_0_3.PAY_TYPE.PAY_TYPE_ADVANCE do
		for iter_7_6, iter_7_7 in pairs(var_7_0[iter_7_5 + 1].awardDic) do
			var_7_0[iter_7_5 + 1].list[#var_7_0[iter_7_5 + 1].list + 1] = iter_7_7
		end

		table.sort(var_7_0[iter_7_5 + 1].list, function(arg_8_0, arg_8_1)
			return arg_8_0.quality > arg_8_1.quality
		end)

		for iter_7_8, iter_7_9 in pairs(var_7_0[iter_7_5 + 1].privilegeDic) do
			table.insert(var_7_0[iter_7_5 + 1].list, 1, iter_7_9)
		end
	end

	self._payStatue = 0
	self._payInfoList = {}

	for iter_7_10 = var_0_3.PAY_TYPE.PAY_TYPE_NORMAL, var_0_3.PAY_TYPE.PAY_TYPE_ADVANCE + 1 do
		local var_7_5 = var_0_2.get(self._id, iter_7_10)

		self._payInfoList[iter_7_10] = {
			cfg = var_7_5,
			dropList = var_7_0[math.min(var_0_3.PAY_TYPE.PAY_TYPE_ADVANCE, iter_7_10) + 1].list,
			rareList = self:_getRareAward(var_7_5),
			rechargeInfo = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(var_7_5.recharge_type, var_7_5.recharge_money)
		}
	end

	self._curLevelExp = 0
	self._curPassExp = 0
	self._curLv = 0
end

function ServerPassActivity:setCurLevel(arg_9_1, arg_9_2)
	self._curPassExp = arg_9_2 or 0
	self._curLv = arg_9_1
end

function ServerPassActivity:setPayStatue(arg_10_1)
	self._payStatue = arg_10_1 or 0
end

function ServerPassActivity:updateOneGetAward(arg_11_1, arg_11_2)
	self._awardIndexDic[arg_11_1].getSign = not arg_11_2 and 0 or require("app.core.utils.KsMath").mathBitSignSet(self._awardIndexDic[arg_11_1].getSign, arg_11_2)
end

function ServerPassActivity:updateGetAwards(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_1 or {}) do
		for iter_12_2, iter_12_3 in ipairs(iter_12_1.levels) do
			self:updateOneGetAward(iter_12_3, iter_12_1.tier)
		end
	end
end

function ServerPassActivity:getId()
	return self._id
end

function ServerPassActivity:getCurLevel()
	return self._curLv
end

function ServerPassActivity:getTotalExp()
	return self._curLevelExp + self._curPassExp
end

function ServerPassActivity:getAwardList()
	return self._awardList
end

function ServerPassActivity:getPayInfo(arg_17_1)
	if arg_17_1 > 1 and self._payStatue == 1 then
		arg_17_1 = 3
	end

	return self._payInfoList[arg_17_1]
end

function ServerPassActivity:getCfg()
	return self._cfg
end

function ServerPassActivity:getTotalPrivilege()
	local var_19_0 = {}
	local var_19_1 = {}

	for iter_19_0 = 1, g.core.model.User:getLevel() do
		if not self._awardIndexDic[iter_19_0] then
			break
		end

		for iter_19_1 = var_0_3.PAY_TYPE.FREE, var_0_3.PAY_TYPE.PAY_TYPE_ADVANCE do
			if self:getAwardStatue(iter_19_0, iter_19_1) >= var_0_3.AWARD_STATUE.CAN_GET then
				for iter_19_2, iter_19_3 in ipairs(self._awardIndexDic[iter_19_0].awardGroupList[iter_19_1 + 1]) do
					if iter_19_3.isPrivilege then
						local var_19_2 = var_19_0[iter_19_3.type]

						if not var_19_0[iter_19_3.type] then
							var_19_2 = {
								value = 0
							}
							var_19_1[#var_19_1 + 1] = var_19_2
							var_19_0[iter_19_3.type] = var_19_2
						end

						var_19_2.value = var_19_2.value + iter_19_3.value
					end
				end
			end
		end
	end

	return var_19_1
end

function ServerPassActivity:getAwardStatue(arg_20_1, arg_20_2)
	local var_20_0 = g.core.model.User:getLevel() < self._awardIndexDic[arg_20_1].cfg.level
	local var_20_1 = self:isCanGetAward(self._awardIndexDic[arg_20_1], arg_20_2)
	local var_20_2 = var_0_3.AWARD_STATUE.CAN_GET

	if arg_20_2 > 0 then
		var_20_0 = var_20_0 or not self:isPay(arg_20_2)
	end

	if var_20_0 then
		var_20_2 = var_0_3.AWARD_STATUE.LOCK
	elseif not var_20_1 then
		var_20_2 = var_0_3.AWARD_STATUE.GOT
	end

	return var_20_2
end

function ServerPassActivity:isCanGetAward(arg_21_1, arg_21_2)
	if arg_21_2 then
		return self:isPay(arg_21_2) and not self:isGetAward(arg_21_1, arg_21_2)
	end

	for iter_21_0 = var_0_3.PAY_TYPE.PAY_TYPE_ADVANCE, var_0_3.PAY_TYPE.FREE, -1 do
		if self:isPay(iter_21_0) and not self:isGetAward(arg_21_1, iter_21_0) then
			return true
		end
	end

	return false
end

function ServerPassActivity:isAllGot()
	for iter_22_0, iter_22_1 in ipairs(self._awardList) do
		for iter_22_2 = var_0_3.PAY_TYPE.FREE, var_0_3.PAY_TYPE.PAY_TYPE_ADVANCE do
			if not self:isGetAward(iter_22_1, iter_22_2) then
				return false
			end
		end
	end

	return true
end

function ServerPassActivity:isShow()
	return self._id > 0 and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.SERVER_PASS_ACTIVITY) and not self:isAllGot()
end

function ServerPassActivity:isPay(arg_24_1)
	if arg_24_1 == var_0_3.PAY_TYPE.FREE then
		return true
	end

	return arg_24_1 <= self._payStatue
end

function ServerPassActivity:isGetAward(arg_25_1, arg_25_2)
	return require("app.core.utils.KsMath").mathBitSignCheck(arg_25_1.getSign, arg_25_2)
end

function ServerPassActivity:onS2CServerPassInfo(arg_26_1)
	if not arg_26_1.order then
		return
	end

	self:setId(arg_26_1.order)
	self:setPayStatue(arg_26_1.tier)
	self:updateGetAwards(arg_26_1.awards)
end

function ServerPassActivity:onS2CServerPassAward(arg_27_1)
	self:updateOneGetAward(arg_27_1.level, arg_27_1.tier)
end

function ServerPassActivity:onS2CServerPassAwardAll(arg_28_1)
	local var_28_0 = {}
	local var_28_1 = {}

	for iter_28_0, iter_28_1 in ipairs(arg_28_1.awards or {}) do
		local var_28_2 = g.core.common.GlobalFunc.contactParamByString(iter_28_1.type, iter_28_1.value)
		local var_28_3 = var_28_0[var_28_2]

		if not var_28_0[var_28_2] then
			var_28_3 = clone(iter_28_1)
			var_28_3.size = 0
			var_28_1[#var_28_1 + 1] = var_28_3
			var_28_0[var_28_2] = var_28_3
		end

		var_28_3.size = var_28_3.size + iter_28_1.size
	end

	arg_28_1.mergeAwards = var_28_1

	self:updateGetAwards(arg_28_1.awarded)
end

return ServerPassActivity

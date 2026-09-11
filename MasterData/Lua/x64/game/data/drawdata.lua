local var_0_0 = singletonClass("DrawData")
local var_0_1 = {}
local var_0_2 = false
local var_0_3 = 0
local var_0_4 = {}
local var_0_5 = {}
local var_0_6 = false
local var_0_7 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = false
	var_0_3 = 0
	var_0_4 = {}
	var_0_5 = {}
	arg_1_0.newHeroFlag_ = false
	arg_1_0.poolBonusList_ = {}
	arg_1_0.oldPoolBonusList_ = {}
	arg_1_0.bonusRedPointFlag_ = false
end

function var_0_0:InitPool(arg_2_1)
	var_0_1 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.draw_info_list) do
		var_0_1[iter_2_1.id] = {
			ssr_draw_times = iter_2_1.ssr_draw_times,
			up = self:ConvertUpId(iter_2_1.id, iter_2_1.up, 1),
			up_times = iter_2_1.up_times,
			is_new = iter_2_1.is_new
		}

		if iter_2_1.is_new == 1 then
			var_0_7[iter_2_1.id] = true
		end
	end

	var_0_6 = arg_2_1.newbie_choose_draw_flag
	var_0_3 = arg_2_1.today_draw_times
	var_0_2 = arg_2_1.first_ssr_draw_flag

	self:RefreshNewDraw()
end

function var_0_0.RefreshNewDraw(arg_3_0)
	local var_3_0 = false

	for iter_3_0, iter_3_1 in pairs(var_0_1) do
		if iter_3_1.is_new and iter_3_1.is_new == 1 then
			var_3_0 = true

			break
		end
	end

	if var_3_0 and not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DRAW) then
		manager.redPoint:setTip(RedPointConst.DRAW, 1, RedPointStyle.SHOW_NEW_TAG)
	end
end

function var_0_0.UpdatePool(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if DrawPoolCfg[arg_4_1].pool_type == 1 or DrawPoolCfg[arg_4_1].pool_type == 5 then
		for iter_4_0, iter_4_1 in pairs(var_0_1) do
			if DrawPoolCfg[iter_4_0].pool_type == 1 or DrawPoolCfg[iter_4_0].pool_type == 5 then
				iter_4_1.ssr_draw_times = math.max(arg_4_2, iter_4_1.ssr_draw_times)
			end
		end
	end

	if var_0_1[arg_4_1] then
		var_0_1[arg_4_1].ssr_draw_times = arg_4_2
	else
		var_0_1[arg_4_1] = {
			ssr_draw_times = arg_4_2
		}
	end

	var_0_6 = arg_4_4
	var_0_2 = arg_4_3
end

function var_0_0.TodayDrawTimesChange(arg_5_0, arg_5_1)
	var_0_3 = var_0_3 + arg_5_1
end

function var_0_0.GetTodayDrawTimes(arg_6_0)
	return var_0_3
end

function var_0_0.GetIsFirstSSR(arg_7_0)
	return var_0_2
end

function var_0_0.GetPoolDrawTimes(arg_8_0, arg_8_1)
	if var_0_1[arg_8_1] then
		return var_0_1[arg_8_1].ssr_draw_times or 0
	end

	return 0
end

function var_0_0.SetPollUpID(arg_9_0, arg_9_1, arg_9_2)
	if var_0_1[arg_9_1] then
		if arg_9_2 ~= var_0_1[arg_9_1].up then
			var_0_1[arg_9_1].up = arg_9_2
			var_0_1[arg_9_1].up_times = (var_0_1[arg_9_1].up_times or 0) + 1
		end
	else
		var_0_1[arg_9_1] = {
			up_times = 1,
			up = arg_9_2
		}
	end
end

function var_0_0.GetPollUpID(arg_10_0, arg_10_1)
	if var_0_1[arg_10_1] then
		return var_0_1[arg_10_1].up or 0
	end

	return 0
end

function var_0_0.GetPoolUpTimes(arg_11_0, arg_11_1)
	if var_0_1[arg_11_1] then
		return var_0_1[arg_11_1].up_times or 0
	end

	return 0
end

function var_0_0.GetPoolList(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(var_0_1) do
		table.insert(var_12_0, iter_12_0)
	end

	return var_12_0
end

function var_0_0.GetPoolIsNew(arg_13_0, arg_13_1)
	if var_0_1[arg_13_1] then
		return var_0_1[arg_13_1].is_new
	end

	return false
end

function var_0_0.SetPoolIsNew(arg_14_0, arg_14_1, arg_14_2)
	if var_0_1[arg_14_1] then
		var_0_1[arg_14_1].is_new = 0
	end
end

function var_0_0.SetDrawRecord(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_2 then
		var_0_4 = {}
	else
		var_0_4[arg_15_1] = {
			ssr_draw_times = arg_15_2.ssr_draw_times,
			draw_record_list = {}
		}

		for iter_15_0 = 1, #arg_15_2.draw_record_list do
			table.insert(var_0_4[arg_15_1].draw_record_list, {
				item = {
					id = arg_15_2.draw_record_list[#arg_15_2.draw_record_list - iter_15_0 + 1].item.id,
					num = arg_15_2.draw_record_list[#arg_15_2.draw_record_list - iter_15_0 + 1].item.num
				},
				draw_timestamp = arg_15_2.draw_record_list[#arg_15_2.draw_record_list - iter_15_0 + 1].draw_timestamp
			})
		end
	end
end

function var_0_0.GetDrawRecord(arg_16_0, arg_16_1)
	return var_0_4[arg_16_1]
end

local var_0_8 = {}

function var_0_0:SetServantRedPoint(arg_17_1, arg_17_2)
	local var_17_0 = string.format("%s_%d_%d", RedPointConst.WEAPON_SERVANT_POOL, arg_17_1, self:GetPollUpID(arg_17_1))

	manager.redPoint:setTip(var_17_0, arg_17_2)

	var_0_8[var_17_0] = true
end

function var_0_0.ResetServantRedPoint(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(var_0_8) do
		manager.redPoint:setTip(iter_18_0, 0)
	end
end

function var_0_0.SetNewHeroFlag(arg_19_0, arg_19_1)
	arg_19_0.newHeroFlag_ = arg_19_1
end

function var_0_0:GetNewHeroFlag()
	return self.newHeroFlag_
end

function var_0_0.GetNewbieChooseDrawFlag(arg_21_0)
	return var_0_6
end

function var_0_0.IsOnePrefabPool(arg_22_0, arg_22_1)
	local var_22_0 = DrawPoolCfg[arg_22_1]

	if not DrawPoolCfg[arg_22_1] then
		CustomLog.Log(debug.traceback(string.format("null")))
	end

	return (var_22_0.pool_type == 3 or var_22_0.pool_type == 8 or var_22_0.pool_type == 1 or var_22_0.pool_type == 9) and #var_22_0.optional_lists_poolId > 2
end

function var_0_0:GetUpRemainTime(arg_23_1)
	return DrawPoolCfg[arg_23_1].pool_change - self:GetPoolUpTimes(arg_23_1)
end

function var_0_0.ConvertUpId(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_2 == 0 then
		return arg_24_2
	end

	local var_24_0 = DrawPoolCfg[arg_24_1]

	if arg_24_3 == 0 then
		return var_24_0.optional_lists[table.indexof(var_24_0.optional_lists_poolId, arg_24_2)]
	else
		return var_24_0.optional_lists_poolId[table.indexof(var_24_0.optional_lists, arg_24_2)]
	end
end

function var_0_0.GetPoolData(arg_25_0, arg_25_1)
	if var_0_5[arg_25_1] then
		return var_0_5[arg_25_1]
	end
end

function var_0_0.SetPoolData(arg_26_0, arg_26_1, arg_26_2)
	var_0_5[arg_26_1] = var_0_5[arg_26_1] or {}
	var_0_5[arg_26_1] = {
		s_up_probability = arg_26_2.s_up_probability,
		s_up_item = arg_26_2.s_up_item,
		s_other_item = arg_26_2.s_other_item,
		a_up_probability = arg_26_2.a_up_probability,
		a_up_item = arg_26_2.a_up_item,
		a_other_item = arg_26_2.a_other_item,
		b_item = arg_26_2.b_item
	}
end

function var_0_0:InitPoolBonus(arg_27_1)
	self:UpdatePoolBonus(arg_27_1.activity_id, arg_27_1.value)
end

function var_0_0:UpdatePoolBonus(arg_28_1, arg_28_2)
	self.poolBonusList_[arg_28_1] = arg_28_2

	if arg_28_2 >= ActivityDrawBonusCfg[arg_28_1].need and self.bonusRedPointFlag_ == false then
		self.bonusRedPointFlag_ = true

		manager.redPoint:setTip(RedPointConst.DRAW_BONUS, 1)
	else
		manager.redPoint:setTip(RedPointConst.DRAW_BONUS, 0)
	end
end

function var_0_0:GetPoolBonus(arg_29_1)
	return self.poolBonusList_[arg_29_1] or 0
end

function var_0_0.SetBonusRedPointFlag(arg_30_0, arg_30_1)
	arg_30_0.bonusRedPointFlag_ = arg_30_1
end

function var_0_0:GetOldPoolBonus(arg_31_1)
	self.oldPoolBonusList_[arg_31_1] = self.oldPoolBonusList_[arg_31_1] or self:GetPoolBonus(arg_31_1)

	return self.oldPoolBonusList_[arg_31_1]
end

function var_0_0:SetOldPoolBonus(arg_32_1, arg_32_2)
	self.oldPoolBonusList_[arg_32_1] = arg_32_2
end

return var_0_0

local var_0_0 = singletonClass("XH1stSealData")
local var_0_1
local var_0_2 = {
	[0] = {
		11,
		22,
		33
	},
	{
		11,
		21,
		31
	},
	{
		12,
		22,
		32
	},
	{
		13,
		23,
		33
	},
	{
		13,
		22,
		31
	},
	[10] = {
		11,
		12,
		13
	},
	[20] = {
		21,
		22,
		23
	},
	[30] = {
		31,
		32,
		33
	}
}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0:OnServerData(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.ticket_list) do
		var_0_1[iter_2_1.ticket_id] = {
			stamp_list = {},
			stamp_number_dic = {},
			reward_list = {},
			reward_number_dic = {}
		}

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.stamp_list) do
			table.insert(var_0_1[iter_2_1.ticket_id].stamp_list, self:ParseCoordinateInfo(iter_2_3))

			var_0_1[iter_2_1.ticket_id].stamp_number_dic[self:GetCoordinateNumber(iter_2_3.row, iter_2_3.column)] = 1
		end

		for iter_2_4, iter_2_5 in ipairs(iter_2_1.reward_list) do
			table.insert(var_0_1[iter_2_1.ticket_id].reward_list, self:ParseCoordinateInfo(iter_2_5))

			var_0_1[iter_2_1.ticket_id].reward_number_dic[self:GetCoordinateNumber(iter_2_5.row, iter_2_5.column)] = 1
		end
	end

	manager.notify:Invoke(XH1ST_SEAL_UPDATE, {})
end

function var_0_0.GetCurrentTicket(arg_3_0)
	for iter_3_0 = #ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].ticket_list, 1, -1 do
		if var_0_1[ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].ticket_list[iter_3_0]] then
			return ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].ticket_list[iter_3_0]
		end
	end

	return ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].ticket_list[1]
end

function var_0_0.IsTicketFinish(arg_4_0, arg_4_1)
	if not var_0_1[arg_4_1] then
		return false
	end

	return #var_0_1[arg_4_1].stamp_list + #var_0_1[arg_4_1].reward_list >= #ActivitySealTicketCfg.get_id_list_by_ticket_id[arg_4_1]
end

function var_0_0.GetCanGetRewardList(arg_5_0, arg_5_1)
	if not var_0_1[arg_5_1] then
		return {}
	end

	local var_5_0 = var_0_1[arg_5_1]
	local var_5_1 = {}
	local var_5_2 = {}

	for iter_5_0, iter_5_1 in pairs(var_0_2) do
		if not var_5_0.reward_number_dic[iter_5_0] then
			local var_5_3 = true

			for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
				if not var_5_0.stamp_number_dic[iter_5_3] then
					var_5_3 = false

					break
				end
			end

			if var_5_3 then
				local var_5_4 = {}

				table.insertto(var_5_4, iter_5_1)
				table.insert(var_5_1, iter_5_0)
				table.insert(var_5_2, var_5_4)
			end
		end
	end

	return var_5_1, var_5_2
end

function var_0_0.ParseCoordinateInfo(arg_6_0, arg_6_1)
	return {
		row = arg_6_1.row,
		column = arg_6_1.column
	}
end

function var_0_0.GetCoordinateNumber(arg_7_0, arg_7_1, arg_7_2)
	return 10 * arg_7_1 + arg_7_2
end

function var_0_0:HaveGotSeal(arg_8_1, arg_8_2, arg_8_3)
	if not var_0_1[arg_8_1] then
		return false
	end

	return var_0_1[arg_8_1].stamp_number_dic[self:GetCoordinateNumber(arg_8_2, arg_8_3)] == 1
end

function var_0_0:HaveGotReward(arg_9_1, arg_9_2, arg_9_3)
	if not var_0_1[arg_9_1] then
		return false
	end

	return var_0_1[arg_9_1].reward_number_dic[self:GetCoordinateNumber(arg_9_2, arg_9_3)] == 1
end

function var_0_0:IsUnLock(arg_10_1)
	if arg_10_1 == 1 then
		return true
	end

	local var_10_0 = ActivitySealTicketCfg.get_id_list_by_ticket_id[arg_10_1 - 1]

	if not ActivitySealTicketCfg.get_id_list_by_ticket_id[arg_10_1 - 1] then
		return false
	end

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if ActivitySealTicketCfg[iter_10_1].is_main_reward == 1 and self:HaveGotReward(arg_10_1 - 1, ActivitySealTicketCfg[iter_10_1].row, ActivitySealTicketCfg[iter_10_1].column) then
			return true
		end
	end

	return false
end

function var_0_0.DecodeCoordinateNumber(arg_11_0, arg_11_1)
	return {
		math.floor(arg_11_1 / 10),
		arg_11_1 % 10
	}
end

function var_0_0:OnSealSuccess(arg_12_1, arg_12_2, arg_12_3)
	if not var_0_1[arg_12_1] then
		self:InitTicket(arg_12_1)
	end

	local var_12_0 = false

	var_0_1[arg_12_1].stamp_number_dic[self:GetCoordinateNumber(arg_12_2, arg_12_3)] = 1

	table.insert(var_0_1[arg_12_1].stamp_list, {
		row = arg_12_2,
		column = arg_12_3
	})

	local var_12_1, var_12_2 = self:GetCanGetRewardList(arg_12_1)

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_4 = self:DecodeCoordinateNumber(iter_12_1)

		for iter_12_2, iter_12_3 in ipairs(ActivitySealTicketCfg.get_id_list_by_ticket_id[arg_12_1]) do
			local var_12_5 = ActivitySealTicketCfg[iter_12_3]

			if ActivitySealTicketCfg[iter_12_3].row == var_12_4[1] and var_12_5.column == var_12_4[2] then
				var_12_0 = var_12_5.is_main_reward == 1

				if var_12_5.is_main_reward == 1 and arg_12_1 < #ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].ticket_list then
					ShowTips(string.format(GetTips("XH1ST_SEAL_UNLOCK_NEXT_TICKET_TIP"), arg_12_1 + 1))
				end

				var_0_1[arg_12_1].reward_number_dic[self:GetCoordinateNumber(var_12_4[1], var_12_4[2])] = 1

				table.insert(var_0_1[arg_12_1].reward_list, {
					row = arg_12_2,
					column = arg_12_3
				})
			end
		end
	end

	manager.notify:Invoke(XH1ST_SEAL_UPDATE, {})

	return {}, var_12_0, var_12_2
end

function var_0_0:ResetTicket()
	self:InitTicket(ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].ticket_list[#ActivitySealCfg[ActivityConst.ACTIVITY_2_0_SEAL].ticket_list])
	manager.notify:Invoke(XH1ST_SEAL_UPDATE, {})
end

function var_0_0.InitTicket(arg_14_0, arg_14_1)
	var_0_1[arg_14_1] = {
		stamp_list = {},
		stamp_number_dic = {},
		reward_list = {},
		reward_number_dic = {}
	}
end

return var_0_0

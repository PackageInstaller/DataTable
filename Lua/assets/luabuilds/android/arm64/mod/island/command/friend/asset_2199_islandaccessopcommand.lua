local IslandAccessOpCommand = class("IslandAccessOpCommand", pm.SimpleCommand)

function IslandAccessOpCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1
	local var_1_2 = {}
	local var_1_3 = getProxy(IslandProxy):GetIsland():GetAccessAgency()

	if var_1_0.op == IslandConst.ACCESS_OP_ADD_WHITELIST then
		var_1_1 = IslandConst.ACCESS_OP_SET_WHITELIST
		var_1_2 = self:AddWhiteList(var_1_3, var_1_0.list)
	elseif var_1_0.op == IslandConst.ACCESS_OP_DEL_WHITELIST then
		var_1_1 = IslandConst.ACCESS_OP_SET_WHITELIST
		var_1_2 = self:RemoveWhiteList(var_1_3, var_1_0.list)
	elseif var_1_0.op == IslandConst.ACCESS_OP_ADD_BLACKLIST then
		var_1_1 = IslandConst.ACCESS_OP_KICKANDBLACKLIST
		var_1_2 = self:AddBlackList(var_1_3, var_1_0.list)
	elseif var_1_0.op == IslandConst.ACCESS_OP_DEL_BLACKLIST then
		var_1_1 = IslandConst.ACCESS_OP_SET_BLACKLIST
		var_1_2 = self:RemoveBlackList(var_1_3, var_1_0.list)
	else
		var_1_1 = var_1_0.op
		var_1_2 = var_1_0.list
	end

	assert(var_1_1 and var_1_2, "op or list is nil")

	if var_1_1 == IslandConst.ACCESS_OP_SET_WHITELIST then
		if pg.island_set.whit_list_max_cnt.key_value_int < #var_1_2 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_white_list_full"))

			return
		end
	elseif var_1_1 == IslandConst.ACCESS_OP_SET_BLACKLIST then
		if pg.island_set.whit_list_max_cnt.key_value_int < #var_1_2 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_black_list_full"))

			return
		end
	elseif var_1_1 == IslandConst.ACCESS_OP_KICKANDBLACKLIST and pg.island_set.whit_list_max_cnt.key_value_int < #var_1_2 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_black_list_full"))

		var_1_1 = IslandConst.ACCESS_OP_KICK
	end

	seriesAsync({
		function(arg_2_0)
			self:Send(var_1_3, var_1_1, var_1_2, arg_2_0)

			return
		end,
		function(arg_3_0)
			local var_3_0, var_3_1, var_3_2 = self:CheckReSend(var_1_3, var_1_1, var_1_2)

			if not var_3_0 then
				arg_3_0()

				return
			end

			self:Send(var_1_3, var_3_1, var_3_2, arg_3_0)

			return
		end
	}, function()
		self:sendNotification(GAME.ISLAND_ACCESS_OP_DONE, {
			op = var_1_1,
			clientOp = var_1_0.op
		})

		return
	end)

	return
end

function IslandAccessOpCommand:CheckReSend(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = false
	local var_5_1
	local var_5_2 = {}

	if arg_5_2 == IslandConst.ACCESS_OP_SET_WHITELIST then
		for iter_5_0, iter_5_1 in ipairs((arg_5_1:GetBlackList())) do
			if table.contains(arg_5_3, iter_5_1) then
				var_5_0 = true
				var_5_1 = IslandConst.ACCESS_OP_SET_BLACKLIST
			else
				table.insert(var_5_2, iter_5_1)
			end
		end
	elseif arg_5_2 ~= IslandConst.ACCESS_OP_SET_BLACKLIST then
		if arg_5_2 == IslandConst.ACCESS_OP_KICKANDBLACKLIST then
			for iter_5_2, iter_5_3 in ipairs((arg_5_1:GetWhiteList())) do
				if table.contains(arg_5_3, iter_5_3) then
					var_5_0 = true
					var_5_1 = IslandConst.ACCESS_OP_SET_WHITELIST
				else
					table.insert(var_5_2, iter_5_3)
				end
			end
		end
	end

	return var_5_0, var_5_1, var_5_2
end

function IslandAccessOpCommand:Send(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	pg.ConnectionMgr.GetInstance():Send(21302, {
		cmd = arg_6_2,
		user_id_list = arg_6_3
	}, 21303, function(arg_7_0)
		if arg_7_0.result == 0 then
			if arg_6_2 == IslandConst.ACCESS_OP_SET_WHITELIST then
				arg_6_1:SetWhiteList(arg_6_3)
			elseif arg_6_2 == IslandConst.ACCESS_OP_SET_BLACKLIST then
				arg_6_1:SetBlackList(arg_6_3)
			elseif arg_6_2 == IslandConst.ACCESS_OP_KICK then
				-- block empty
			elseif arg_6_2 == IslandConst.ACCESS_OP_KICKANDBLACKLIST then
				arg_6_1:AddBlackList(arg_6_3)
			end

			arg_6_4()
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_visit_tip6"))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_7_0.result] .. arg_7_0.ret)
		end

		return
	end)

	return
end

function IslandAccessOpCommand:AddWhiteList(arg_8_1, arg_8_2)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1:GetWhiteList()) do
		table.insert(var_8_0, iter_8_1)
	end

	for iter_8_2, iter_8_3 in ipairs(arg_8_2) do
		if not table.contains(var_8_0, iter_8_3) then
			table.insert(var_8_0, iter_8_3)
		end
	end

	return var_8_0
end

function IslandAccessOpCommand:RemoveWhiteList(arg_9_1, arg_9_2)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1:GetWhiteList()) do
		table.insert(var_9_0, iter_9_1)
	end

	for iter_9_2 = #var_9_0, 1, -1 do
		if table.contains(arg_9_2, var_9_0[iter_9_2]) then
			table.remove(var_9_0, iter_9_2)
		end
	end

	return var_9_0
end

function IslandAccessOpCommand:AddBlackList(arg_10_1, arg_10_2)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1:GetBlackList()) do
		table.insert(var_10_0, iter_10_1)
	end

	for iter_10_2, iter_10_3 in ipairs(arg_10_2) do
		if not table.contains(var_10_0, iter_10_3) then
			table.insert(var_10_0, iter_10_3)
		end
	end

	return var_10_0
end

function IslandAccessOpCommand:RemoveBlackList(arg_11_1, arg_11_2)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1:GetBlackList()) do
		table.insert(var_11_0, iter_11_1)
	end

	for iter_11_2 = #var_11_0, 1, -1 do
		if table.contains(arg_11_2, var_11_0[iter_11_2]) then
			table.remove(var_11_0, iter_11_2)
		end
	end

	return var_11_0
end

return IslandAccessOpCommand

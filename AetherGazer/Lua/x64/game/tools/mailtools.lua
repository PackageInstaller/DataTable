local var_0_0 = {
	Sort = function(arg_1_0)
		local var_1_0 = {}
		local var_1_1 = {}
		local var_1_2 = {}

		for iter_1_0, iter_1_1 in pairs(arg_1_0) do
			if type(iter_1_1) == "table" then
				if iter_1_1.read_flag == 2 and iter_1_1.attach_flag ~= 1 then
					table.insert(var_1_1, iter_1_0)
				else
					table.insert(var_1_0, iter_1_0)
				end

				table.insert(var_1_2, iter_1_0)
			end
		end

		table.sort(var_1_2, function(arg_2_0, arg_2_1)
			return arg_2_1 < arg_2_0
		end)
		table.sort(var_1_0, function(arg_3_0, arg_3_1)
			return arg_3_1 < arg_3_0
		end)
		table.sort(var_1_1, function(arg_4_0, arg_4_1)
			return arg_4_1 < arg_4_0
		end)

		for iter_1_2, iter_1_3 in ipairs(var_1_1) do
			table.insert(var_1_0, iter_1_3)
		end

		local var_1_3 = #var_1_2

		return var_1_0, var_1_3, var_1_2[1] or 0, var_1_2[var_1_3] or 0
	end
}

function var_0_0.SortBySelectId(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0) do
		if type(iter_5_1) == "table" then
			if iter_5_1.read_flag == 2 and iter_5_1.attach_flag ~= 1 then
				table.insert(var_5_1, iter_5_0)
			else
				table.insert(var_5_0, iter_5_0)
			end
		end
	end

	table.sort(var_5_0, function(arg_6_0, arg_6_1)
		if arg_5_0[arg_6_0].date == arg_5_0[arg_6_1].date then
			return arg_6_1 < arg_6_0
		else
			return arg_5_0[arg_6_0].date > arg_5_0[arg_6_1].date
		end
	end)
	table.sort(var_5_1, function(arg_7_0, arg_7_1)
		if arg_5_0[arg_7_0].date == arg_5_0[arg_7_1].date then
			return arg_7_1 < arg_7_0
		else
			return arg_5_0[arg_7_0].date > arg_5_0[arg_7_1].date
		end
	end)

	for iter_5_2, iter_5_3 in ipairs(var_5_1) do
		table.insert(var_5_0, iter_5_3)
	end

	if arg_5_1 ~= 0 and var_0_0.lastSort then
		local var_5_2 = table.keyof(var_0_0.lastSort, arg_5_1)
		local var_5_3 = table.keyof(var_5_0, arg_5_1)

		if var_5_3 and var_5_2 ~= var_5_3 then
			for iter_5_4, iter_5_5 in ipairs(var_5_0) do
				if table.keyof(var_0_0.lastSort, iter_5_5) == nil then
					table.insert(var_0_0.lastSort, iter_5_5)
				end
			end

			return clone(var_0_0.lastSort)
		end
	end

	var_0_0.lastSort = var_5_0

	return var_5_0
end

function var_0_0.GetLostTimeStr(arg_8_0)
	local var_8_0 = arg_8_0 - TimeMgr.GetInstance():GetServerTime()
	local var_8_1 = math.floor(var_8_0 / 86400)
	local var_8_2 = math.fmod(math.floor(var_8_0 / 3600), 24)
	local var_8_3 = math.fmod(math.floor(var_8_0 / 60), 60)
	local var_8_4 = math.fmod(var_8_0, 60)

	if var_8_1 > 0 then
		return string.format(GetTips("EXPIRED_DAY"), var_8_1 + 1)
	elseif var_8_2 > 0 then
		return string.format(GetTips("EXPIRED_HOUR"), var_8_2 + 1)
	elseif var_8_3 > 0 then
		return string.format(GetTips("EXPIRED_MINUTE"), var_8_3 + 1)
	elseif var_8_4 > 0 then
		return string.format(GetTips("EXPIRED_SECOND"), var_8_4)
	else
		return GetTips("TIME_OUT")
	end
end

function var_0_0.CheckIsPurchaseTemplate(arg_9_0)
	if tostring(arg_9_0) == tostring(MailConst.MAIL_ID_CONST.SKIN_DLC_EXPIRE) or tostring(arg_9_0) == tostring(MailConst.MAIL_ID_CONST.SKIN_EXPIRE) then
		return true
	end

	return false
end

return var_0_0

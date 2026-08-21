local var_0_0 = class("MainSkinDiscountItemTipSequence", import(".MainOverDueSkinDiscountItemSequence"))

function var_0_0.Execute(arg_1_0, arg_1_1)
	if not arg_1_0:ShouldTip() then
		arg_1_1()

		return
	end

	local var_1_0, var_1_1 = arg_1_0:CollectExpiredItems()

	if #var_1_0 <= 0 and #var_1_1 <= 0 then
		arg_1_1()

		return
	end

	var_0_0.TipFlag = true

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		table.insert({}, iter_1_1)
	end

	for iter_1_2, iter_1_3 in ipairs(var_1_1) do
		table.insert({}, iter_1_3)
	end

	arg_1_0:DisplayResults({}, arg_1_1)

	return
end

function var_0_0.ShouldTip(arg_2_0)
	local var_2_0 = PlayerPrefs.GetString("SkinDiscountItemTip" .. getProxy(PlayerProxy):getRawData().id, "")

	if var_2_0 == "" then
		return not var_0_0.TipFlag
	end

	local var_2_1 = pg.TimeMgr.GetInstance()

	if var_2_1:GetServerTime() < tonumber(var_2_0) then
		return false
	else
		return not var_0_0.TipFlag
	end

	return
end

function var_0_0.DisplayResults(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:Display(MainSkinDiscountItemTipDisplayPage, arg_3_1, arg_3_2)

	return
end

function var_0_0.InTime(arg_4_0, arg_4_1)
	local var_4_9000

	if type(arg_4_1) == "table" then
		local var_4_0 = pg.TimeMgr.GetInstance().parseTimeFromConfig(var_4_9000, arg_4_1[2])
		local var_4_1 = pg.TimeMgr.GetInstance():GetServerTime()

		return var_4_0 - 0 <= var_4_1 and var_4_1 < var_4_0
	end

	return false
end

return var_0_0

local MainSkinDiscountItemTipSequence = class("MainSkinDiscountItemTipSequence", import(".MainOverDueSkinDiscountItemSequence"))

function MainSkinDiscountItemTipSequence:Execute(arg_1_1)
	if not self:ShouldTip() then
		arg_1_1()

		return
	end

	local var_1_0, var_1_1 = self:CollectExpiredItems()

	if #var_1_0 <= 0 and #var_1_1 <= 0 then
		arg_1_1()

		return
	end

	MainSkinDiscountItemTipSequence.TipFlag = true

	local var_1_2 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		table.insert(var_1_2, iter_1_1)
	end

	for iter_1_2, iter_1_3 in ipairs(var_1_1) do
		table.insert(var_1_2, iter_1_3)
	end

	self:DisplayResults(var_1_2, arg_1_1)

	return
end

function MainSkinDiscountItemTipSequence:ShouldTip()
	local var_2_0 = PlayerPrefs.GetString("SkinDiscountItemTip" .. getProxy(PlayerProxy):getRawData().id, "")

	if var_2_0 == "" then
		return not MainSkinDiscountItemTipSequence.TipFlag
	end

	if pg.TimeMgr.GetInstance():GetServerTime() < tonumber(var_2_0) then
		return false
	else
		return not MainSkinDiscountItemTipSequence.TipFlag
	end

	return
end

function MainSkinDiscountItemTipSequence:DisplayResults(arg_3_1, arg_3_2)
	self:Display(MainSkinDiscountItemTipDisplayPage, arg_3_1, arg_3_2)

	return
end

function MainSkinDiscountItemTipSequence:InTime(arg_4_1)
	if type(arg_4_1) == "table" then
		local var_4_0 = pg.TimeMgr.GetInstance():parseTimeFromConfig(arg_4_1[2])
		local var_4_1 = pg.TimeMgr.GetInstance():GetServerTime()

		return var_4_0 - 0 <= var_4_1 and var_4_1 < var_4_0
	end

	return false
end

return MainSkinDiscountItemTipSequence

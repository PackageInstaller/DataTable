class = var_0_10000

local var_0_0 = var_0_10000("PageUtil")
local var_0_1 = PageUtil

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	pg = var_1_10005

	var_1_10005.DelegateInfo.New(arg_1_0)

	arg_1_0._leftBtn = arg_1_1
	arg_1_0._rightBtn = arg_1_2
	arg_1_0._maxBtn = arg_1_3
	arg_1_0._numTxt = arg_1_4
	pressPersistTrigger = var_5

	local var_1_0 = arg_1_0._leftBtn
	local var_1_1 = 0.5

	local function var_1_2()
		local var_2_0 = arg_1_0._curNum - arg_1_0._addNum <= 0 and arg_1_0._curNum or var_2_0
		local var_2_1 = arg_1_0

		var_1.setCurNum(var_2_1, var_2_0)

		return
	end

	local var_1_3
	local var_1_4 = true
	local var_1_5 = true
	local var_1_6 = 0.1

	SFX_PANEL = var_1_10013

	var_5(var_1_0, var_1_1, var_1_2, var_1_3, var_1_4, var_1_5, var_1_6, var_1_10013)

	pressPersistTrigger = var_5

	local var_1_7 = arg_1_0._rightBtn
	local var_1_8 = 0.5

	local function var_1_9()
		local var_3_0 = arg_1_0._curNum + arg_1_0._addNum

		if arg_1_0._maxNum < 0 then
			local var_3_1 = arg_1_0

			var_1.setCurNum(var_3_1, var_3_0)
		else
			var_3_0 = var_3_0 > arg_1_0._maxNum and arg_1_0._maxNum or var_3_0

			local var_3_2 = arg_1_0

			var_1.setCurNum(var_3_2, var_3_0)
		end

		return
	end

	local var_1_10
	local var_1_11 = true
	local var_1_12 = true
	local var_1_13 = 0.1

	SFX_PANEL = var_1_10013

	var_5(var_1_7, var_1_8, var_1_9, var_1_10, var_1_11, var_1_12, var_1_13, var_1_10013)

	onButton = var_5

	var_5(arg_1_0, arg_1_0._maxBtn, function()
		if arg_1_0._maxNum < 0 then
			-- block empty
		else
			local var_4_0 = arg_1_0

			var_0.setCurNum(var_4_0, arg_1_0._maxNum)
		end

		return
	end)
	arg_1_0:setAddNum(1)
	arg_1_0:setDefaultNum(1)
	arg_1_0:setMaxNum(-1)

	return
end

function var_0_1.setAddNum(arg_5_0, arg_5_1)
	arg_5_0._addNum = arg_5_1

	return
end

function var_0_1.setDefaultNum(arg_6_0, arg_6_1)
	arg_6_0._defaultNum = arg_6_1

	arg_6_0:setCurNum(arg_6_0._defaultNum)

	return
end

function var_0_1.setMaxNum(arg_7_0, arg_7_1)
	arg_7_0._maxNum = arg_7_1
	setActive = var_1_10002

	var_1_10002(arg_7_0._maxBtn, arg_7_0._maxNum > 0)

	return
end

function var_0_1.setCurNum(arg_8_0, arg_8_1)
	arg_8_0._curNum = arg_8_1
	setText = var_1_10002

	var_1_10002(arg_8_0._numTxt, arg_8_0._curNum)

	if arg_8_0._numUpdate ~= nil then
		arg_8_0._numUpdate(arg_8_0._curNum)
	end

	return
end

function var_0_1.setNumUpdate(arg_9_0, arg_9_1)
	arg_9_0._numUpdate = arg_9_1

	return
end

function var_0_1.getCurNum(arg_10_0)
	return arg_10_0._curNum
end

function var_0_1.Dispose(arg_11_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_11_0)

	return
end

return var_0_1

local var_0_0 = class("PageUtil")

PageUtil = var_0_0

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0._leftBtn = arg_1_1
	arg_1_0._rightBtn = arg_1_2
	arg_1_0._maxBtn = arg_1_3
	arg_1_0._numTxt = arg_1_4

	pressPersistTrigger(arg_1_0._leftBtn, 0.5, function()
		local var_2_0 = arg_1_0._curNum - arg_1_0._addNum

		var_2_0 = arg_1_0._curNum - arg_1_0._addNum <= 0 and arg_1_0._curNum or var_2_0

		arg_1_0:setCurNum(var_2_0)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(arg_1_0._rightBtn, 0.5, function()
		local var_3_0 = arg_1_0._curNum + arg_1_0._addNum

		if arg_1_0._maxNum < 0 then
			arg_1_0:setCurNum(var_3_0)
		else
			var_3_0 = var_3_0 > arg_1_0._maxNum and arg_1_0._maxNum or var_3_0

			arg_1_0:setCurNum(var_3_0)
		end

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	onButton(arg_1_0, arg_1_0._maxBtn, function()
		if arg_1_0._maxNum < 0 then
			-- block empty
		else
			arg_1_0:setCurNum(arg_1_0._maxNum)
		end

		return
	end)
	arg_1_0:setAddNum(1)
	arg_1_0:setDefaultNum(1)
	arg_1_0:setMaxNum(-1)

	return
end

function var_0_0.setAddNum(arg_5_0, arg_5_1)
	arg_5_0._addNum = arg_5_1

	return
end

function var_0_0.setDefaultNum(arg_6_0, arg_6_1)
	arg_6_0._defaultNum = arg_6_1

	arg_6_0:setCurNum(arg_6_0._defaultNum)

	return
end

function var_0_0.setMaxNum(arg_7_0, arg_7_1)
	arg_7_0._maxNum = arg_7_1

	setActive(arg_7_0._maxBtn, arg_7_0._maxNum > 0)

	return
end

function var_0_0.setCurNum(arg_8_0, arg_8_1)
	arg_8_0._curNum = arg_8_1

	setText(arg_8_0._numTxt, arg_8_0._curNum)

	if arg_8_0._numUpdate ~= nil then
		arg_8_0._numUpdate(arg_8_0._curNum)
	end

	return
end

function var_0_0.setNumUpdate(arg_9_0, arg_9_1)
	arg_9_0._numUpdate = arg_9_1

	return
end

function var_0_0.getCurNum(arg_10_0)
	return arg_10_0._curNum
end

function var_0_0.Dispose(arg_11_0)
	pg.DelegateInfo.Dispose(arg_11_0)

	return
end

return var_0_0

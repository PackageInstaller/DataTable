class = var_0_10000

local var_0_0 = var_0_10000("SkinAtlasBgView")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	arg_1_0._go = arg_1_1.gameObject
	arg_1_0.isSpecialBg = false
	arg_1_0.isloading = false

	return
end

function var_0_0.getUIName(arg_2_0)
	return arg_2_0.__cname
end

function var_0_0.Init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.ship = arg_3_1

	arg_3_0:ClearSpecailBg()

	local var_3_0 = arg_3_0:getShipBgPrint(arg_3_2)

	arg_3_0:SetSpecailBg(var_3_0, arg_3_3)

	return
end

function var_0_0.getShipBgPrint(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.ship

	if not arg_4_1 then
		return var_4_0:rarity2bgPrintForGet()
	else
		return var_4_0:getShipBgPrint()
	end

	return
end

function var_0_0.SetSpecailBg(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.isloading = true
	pg = var_3

	local var_5_0 = var_3.DynamicBgMgr.GetInstance()

	var_3.LoadBg(var_5_0, arg_5_0, arg_5_1, arg_5_0._tf.parent, arg_5_0._tf, function(arg_6_0)
		arg_5_0.isSpecialBg = true
		arg_5_0.isloading = false

		local var_6_0 = arg_6_0.transform

		Vector3 = var_2
		var_6_0.localPosition = var_2(0, 0, 200)

		if arg_5_2 then
			arg_5_2()
		end

		return
	end, function()
		arg_5_0.isloading = false

		if arg_5_2 then
			arg_5_2()
		end

		return
	end)

	return
end

function var_0_0.ClearSpecailBg(arg_8_0)
	if arg_8_0.isSpecialBg then
		pg = var_1

		local var_8_0 = var_1.DynamicBgMgr.GetInstance()

		var_1.ClearBg(var_8_0, arg_8_0:getUIName())

		arg_8_0.isSpecialBg = false
	end

	return
end

function var_0_0.IsLoading(arg_9_0)
	return arg_9_0.isloading
end

function var_0_0.Clear(arg_10_0)
	arg_10_0:ClearSpecailBg()

	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:Clear()

	return
end

return var_0_0

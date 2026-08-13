class = var_0_10000

local var_0_0 = var_0_10000("ShipProfileSkinBtn")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.Find(var_1_0, "mask/Text")

	arg_1_0.sctxt = var_2.GetComponent(var_1_1, "ScrollText")

	local var_1_2 = arg_1_0._tf

	arg_1_0.lockTF = var_2.Find(var_1_2, "lock")

	local var_1_3 = arg_1_0._tf

	arg_1_0.selected = var_2.Find(var_1_3, "selected")

	local var_1_4 = arg_1_0._tf

	arg_1_0.timelimitTF = var_2.Find(var_1_4, "timelimit")

	local var_1_5 = arg_1_0._tf
	local var_1_6 = var_2.Find(var_1_5, "timelimit/Text")
	local var_1_7 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.timelimitTxt = var_1_7(var_1_6, var_5(var_1_10007))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.shipGroup = arg_2_2

	local var_2_0 = arg_2_1.name
	local var_2_1 = arg_2_0.sctxt

	var_5.SetText(var_2_1, var_2_0)

	local var_2_2 = arg_2_1.skin_type

	ShipSkin = var_1_10006

	if var_2_2 ~= var_1_10006.SKIN_TYPE_DEFAULT then
		if not arg_2_3 then
			::label_2_0::

			var_2_2 = arg_2_1.skin_type
			ShipSkin = var_6

			if var_2_2 ~= var_6.SKIN_TYPE_REMAKE or not arg_2_0.shipGroup.trans then
				var_2_2 = arg_2_1.skin_type
				ShipSkin = var_6

				if var_2_2 ~= var_6.SKIN_TYPE_PROPOSE or arg_2_0.shipGroup.married ~= 1 then
					var_2_2 = false

					goto label_2_1
				end

				var_2_2 = true
			end
		end

		::label_2_1::

		arg_2_0.unlock = var_2_2
		setActive = var_2_2

		var_2_2(arg_2_0.lockTF, not arg_2_0.unlock)
		arg_2_0:AddTimer(arg_2_1)

		return
	end
end

function var_0_0.AddTimer(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	ShipSkinProxy = var_1_10004

	local var_3_0 = var_1_10002(var_1_10004)
	local var_3_1

	if var_2.getSkinById(var_3_0, arg_3_1.id) and var_2:isExpireType() then
		var_3_1 = not var_2:isExpired()
	end

	setActive = var_3_0

	var_3_0(arg_3_0.timelimitTF, var_3_1)
	arg_3_0:RemoveTimer()

	if var_3_1 then
		Timer = var_4
		arg_3_0.timer = var_4.New(function()
			local var_4_0 = arg_3_0.timelimitTxt

			skinTimeStamp = var_2_10001

			local var_4_1 = var_0

			var_4_0.text = var_2_10001(var_3.getRemainTime(var_4_1))

			return
		end, 1, -1)

		local var_3_2 = arg_3_0.timer

		var_4.Start(var_3_2)
		arg_3_0.timer.func()
	end

	return
end

function var_0_0.RemoveTimer(arg_5_0)
	if arg_5_0.timer then
		local var_5_0 = arg_5_0.timer

		var_1.Stop(var_5_0)

		arg_5_0.timer = nil
	end

	return
end

function var_0_0.Shift(arg_6_0)
	setActive = var_1_10001

	var_1_10001(arg_6_0.selected, true)

	return
end

function var_0_0.UnShift(arg_7_0)
	setActive = var_1_10001

	var_1_10001(arg_7_0.selected, false)

	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:RemoveTimer()

	return
end

return var_0_0

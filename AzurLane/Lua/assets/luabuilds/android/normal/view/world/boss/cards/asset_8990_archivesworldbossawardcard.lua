class = var_0_10000

local var_0_0 = var_0_10000("ArchivesWorldBossAwardCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.itemTF = var_2.Find(var_1_0, "item")

	local var_1_1 = arg_1_0._tf

	arg_1_0.itemMaskTF = var_2.Find(var_1_1, "item/mask")

	local var_1_2 = arg_1_0._tf

	arg_1_0.itemMaskGotTF = var_2.Find(var_1_2, "item/mask/Got")

	local var_1_3 = arg_1_0._tf

	arg_1_0.itemMaskLockTF = var_2.Find(var_1_3, "item/mask/Lock")

	local var_1_4 = arg_1_0._tf

	arg_1_0.pointText = var_2.Find(var_1_4, "point/text")

	local var_1_5 = arg_1_0._tf
	local var_1_6 = var_2.Find(var_1_5, "lock")
	local var_1_7 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.lockTr = var_1_7(var_1_6, var_4(var_1_10005))

	local var_1_8 = arg_1_0._tf
	local var_1_9 = var_2.Find(var_1_8, "got")
	local var_1_10 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.gotTr = var_1_10(var_1_9, var_4(var_1_10005))

	local var_1_11 = arg_1_0._tf
	local var_1_12 = var_2.Find(var_1_11, "get")
	local var_1_13 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.getTr = var_1_13(var_1_12, var_4(var_1_10005))
	setText = var_2

	local var_1_14 = arg_1_0._tf
	local var_1_15 = var_3.Find(var_1_14, "point/label")

	i18n = var_1_14

	var_2(var_1_15, var_1_14("meta_pt_point"))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1.itemInfo
	local var_2_1 = arg_2_1.target
	local var_2_2 = arg_2_1.level
	local var_2_3 = arg_2_1.count
	local var_2_4 = arg_2_1.unlockPTNum

	arg_2_0.dropInfo = {
		type = var_2_0[1],
		id = var_2_0[2],
		count = var_2_0[3]
	}
	updateDrop = var_8

	var_8(arg_2_0.itemTF, arg_2_0.dropInfo, {
		hideName = true
	})

	setText = var_8

	var_8(arg_2_0.pointText, var_2_1)

	arg_2_0.lockTr.text = ""
	arg_2_0.getTr.text = ""
	arg_2_0.gotTr.text = ""

	local var_2_5 = 0
	local var_2_6

	if arg_2_2 < var_2_2 + 1 then
		var_2_5 = 1
		var_2_6 = arg_2_0.gotTr
		i18n = var_2_7
		var_2_6.text = var_2_7("meta_award_got")
	else
		local var_2_7

		if var_2_3 < var_2_1 then
			var_2_5 = 2
			calcFloor = var_2_6
			var_2_6 = var_2_6(var_2_1 / var_2_4 * 100) .. "%"
			var_2_7 = arg_2_0.lockTr
			var_2_7.text = "T-" .. arg_2_2 .. " " .. var_2_6
		else
			var_2_6 = arg_2_0.getTr
			i18n = var_2_7
			var_2_6.text = var_2_7("meta_award_get")
		end
	end

	setActive = var_2_6

	var_2_6(arg_2_0.itemMaskTF, var_2_5 ~= 0)

	setActive = var_2_6

	var_2_6(arg_2_0.itemMaskGotTF, var_2_5 == 1)

	setActive = var_2_6

	var_2_6(arg_2_0.itemMaskLockTF, var_2_5 == 2)

	return
end

function var_0_0.Dispose(arg_3_0)
	return
end

return var_0_0

local var_0_0 = class("ArchivesWorldBossAwardCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.itemTF = arg_1_0._tf:Find("item")
	arg_1_0.itemMaskTF = arg_1_0._tf:Find("item/mask")
	arg_1_0.itemMaskGotTF = arg_1_0._tf:Find("item/mask/Got")
	arg_1_0.itemMaskLockTF = arg_1_0._tf:Find("item/mask/Lock")
	arg_1_0.pointText = arg_1_0._tf:Find("point/text")
	arg_1_0.lockTr = arg_1_0._tf:Find("lock"):GetComponent(typeof(Text))
	arg_1_0.gotTr = arg_1_0._tf:Find("got"):GetComponent(typeof(Text))
	arg_1_0.getTr = arg_1_0._tf:Find("get"):GetComponent(typeof(Text))

	setText(arg_1_0._tf:Find("point/label"), i18n("meta_pt_point"))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.dropInfo = {
		type = arg_2_1.itemInfo[1],
		id = arg_2_1.itemInfo[2],
		count = arg_2_1.itemInfo[3]
	}

	updateDrop(arg_2_0.itemTF, arg_2_0.dropInfo, {
		hideName = true
	})
	setText(arg_2_0.pointText, arg_2_1.target)

	arg_2_0.lockTr.text = ""
	arg_2_0.getTr.text = ""
	arg_2_0.gotTr.text = ""

	local var_2_0 = 0

	if arg_2_2 < arg_2_1.level + 1 then
		var_2_0 = 1
		arg_2_0.gotTr.text = i18n("meta_award_got")
	elseif arg_2_1.count < arg_2_1.target then
		var_2_0 = 2
		arg_2_0.lockTr.text = "T-" .. arg_2_2 .. " " .. calcFloor(arg_2_1.target / arg_2_1.unlockPTNum * 100) .. "%"
	else
		arg_2_0.getTr.text = i18n("meta_award_get")
	end

	setActive(arg_2_0.itemMaskTF, var_2_0 ~= 0)
	setActive(arg_2_0.itemMaskGotTF, var_2_0 == 1)
	setActive(arg_2_0.itemMaskLockTF, var_2_0 == 2)

	return
end

function var_0_0.Dispose(arg_3_0)
	return
end

return var_0_0

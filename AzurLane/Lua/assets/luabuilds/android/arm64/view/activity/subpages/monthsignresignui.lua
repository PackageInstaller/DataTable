class = var_0_10000

local var_0_0 = "MonthSignReSignUI"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "MonthSignReSignUI"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:InitUI()

	setActive = var_1

	var_1(arg_2_0._tf, true)

	pg = var_1

	local var_2_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)

	return
end

function var_0_1.InitUI(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.destroyBonusList = var_1.Find(var_3_0, "frame/bg/scrollview/list")

	local var_3_1 = arg_3_0.destroyBonusList

	arg_3_0.itemTpl = var_1.Find(var_3_1, "item_tpl")
	setText = var_1

	local var_3_2 = arg_3_0._tf
	local var_3_3 = var_3.Find(var_3_2, "frame/title_text/Text")

	i18n = var_4

	var_1(var_3_3, var_4("month_sign_resign"))

	onButton = var_1

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_4.Find(var_3_5, "frame/top/btnBack")

	local function var_3_7()
		local var_4_0 = arg_3_0

		var_0.Destroy(var_4_0)

		return
	end

	SFX_CANCEL = var_3_5

	var_1(var_3_4, var_3_6, var_3_7, var_3_5)

	onButton = var_1

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0._tf
	local var_3_10 = var_4.Find(var_3_9, "frame/actions/confirm_btn")

	local function var_3_11()
		local var_5_0 = arg_3_0

		var_0.Destroy(var_5_0)

		return
	end

	SFX_UI_EQUIPMENT_RESOLVE = var_3_9

	var_1(var_3_8, var_3_10, var_3_11, var_3_9)

	return
end

function var_0_1.setAwardShow(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.awards = arg_6_1
	arg_6_0.callback = arg_6_2

	arg_6_0:displayAwards()

	return
end

function var_0_1.OnDestroy(arg_7_0)
	arg_7_0.selectedIds = nil

	if arg_7_0.callback then
		arg_7_0.callback()

		arg_7_0.callback = nil
	end

	arg_7_0.awards = nil
	pg = var_1

	local var_7_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_7_0, arg_7_0._tf, arg_7_0._parentTf)

	return
end

function var_0_1.displayAwards(arg_8_0)
	assert = var_1_10001

	var_1_10001(#arg_8_0.awards ~= 0, "items数量不能为0")

	removeAllChildren = var_1_10001

	var_1_10001(arg_8_0.destroyBonusList)

	for iter_8_0 = 1, #arg_8_0.awards do
		cloneTplTo = var_1_10005

		local var_8_0 = var_1_10005(arg_8_0.itemTpl, arg_8_0.destroyBonusList)

		var_1_10005 = var_1_10005.Find(var_8_0, "bg")

		local var_8_1 = arg_8_0.awards[iter_8_0]

		updateDrop = var_8_0
		tf = var_1_10009

		var_8_0(var_1_10009(var_1_10005), var_8_1, {
			fromAwardLayer = true
		})

		setActive = var_8_0
		findTF = var_1_10009

		var_8_0(var_1_10009(var_1_10005, "bonus"), var_8_1.riraty)

		findTF = var_8_0

		local var_8_2 = var_8_0(var_1_10005, "name")

		findTF = var_8

		local var_8_3 = var_8(var_1_10005, "name_mask")

		findTF = var_1_10009

		local var_8_4 = var_1_10009(var_1_10005, "name_mask/name")

		var_1_10009 = var_1_10009.GetComponent(var_8_4, "ScrollText")
		setActive = var_10

		var_10(var_8_2, false)

		setActive = var_10

		var_10(var_8_3, true)

		local var_8_5

		if not var_8_1.name then
			getText = var_8_5
			var_8_5 = var_8_5(var_8_2)
		end

		var_1_10009:SetText(var_8_5)

		onButton = var_11

		local var_8_6 = arg_8_0
		local var_8_7 = var_1_10005

		local function var_8_8()
			if arg_8_0.inAniming then
				return
			end

			local var_9_0 = arg_8_0
			local var_9_1 = var_0.emit

			BaseUI = var_2_10003

			var_9_1(var_9_0, var_2_10003.ON_DROP, var_8_1)

			return
		end

		SFX_PANEL = var_1_10016

		var_11(var_8_6, var_8_7, var_8_8, var_1_10016)
	end

	return
end

return var_0_1

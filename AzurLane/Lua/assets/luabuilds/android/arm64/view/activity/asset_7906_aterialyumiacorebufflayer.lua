class = var_0_10000

local var_0_0 = "AterialYumiaCoreBuffLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AterialYumiaCoreBuffLayer"
end

function var_0_1.SetActivity(arg_2_0, arg_2_1)
	arg_2_0.activity = arg_2_1
	arg_2_0.config = arg_2_1:getConfig("config_client").core_tasks

	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.rtBg = var_1.Find(var_3_0, "bg")

	local var_3_1 = arg_3_0._tf

	arg_3_0.btnReturn = var_1.Find(var_3_1, "adapt/bottom/btn_return")
	onButton = var_1

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.btnReturn

	local function var_3_4()
		if arg_3_0.inAnim then
			return
		end

		local var_4_0 = arg_3_0

		var_4_0.inAnim = true
		quickPlayAnimation = var_4_0

		var_4_0(arg_3_0._tf, "Anim_AteriaYumiaCoreBuffLayer_Out")

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_3_2, var_3_3, var_3_4, var_1_10006)

	local var_3_5 = arg_3_0._tf

	arg_3_0.rtUpgrade = var_1.Find(var_3_5, "upgrade")
	setActive = var_1

	var_1(arg_3_0.rtUpgrade, false)

	onButton = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.rtUpgrade
	local var_3_8 = var_4.Find(var_3_7, "top/btn_back")

	local function var_3_9()
		if arg_3_0.inAnim then
			return
		end

		local var_5_0 = arg_3_0

		var_5_0.inAnim = true
		quickPlayAnimation = var_5_0

		var_5_0(arg_3_0.rtUpgrade, "Anim_AteriaYumiaCoreBuffLayer_upgrade_Out")

		return
	end

	SFX_CANCEL = var_3_7

	var_1(var_3_6, var_3_8, var_3_9, var_3_7)

	local var_3_10 = arg_3_0.rtUpgrade
	local var_3_11 = var_1.GetComponent

	typeof = var_3_8
	DftAniEvent = var_3_7

	local var_3_12 = var_3_11(var_3_10, var_3_8(var_3_7))

	var_1.SetEndEvent(var_3_12, function()
		local var_6_0 = arg_3_0

		var_6_0.inAnim = false
		pg = var_6_0

		local var_6_1 = var_6_0.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_6_1, arg_3_0.rtUpgrade, arg_3_0._tf)

		setActive = var_0

		var_0(arg_3_0.rtUpgrade, false)

		return
	end)

	local var_3_13 = arg_3_0._tf
	local var_3_14 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_3_7

	local var_3_15 = var_3_14(var_3_13, var_4(var_3_7))

	var_1.SetEndEvent(var_3_15, function()
		arg_3_0.inAnim = false

		local var_7_0 = arg_3_0

		var_0.closeView(var_7_0)

		return
	end)

	return
end

function var_0_1.didEnter(arg_8_0)
	arg_8_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_9_0)
	ipairs = var_1_10001

	for iter_9_0, iter_9_1 in var_1_10001(arg_9_0.config) do
		local var_9_0 = {}

		ipairs = var_1_10007

		for iter_9_2, iter_9_3 in var_1_10007(iter_9_1) do
			getProxy = var_1_10012
			TaskProxy = var_1_10014
			var_1_10014 = var_1_10012(var_1_10014)

			if var_1_10012.getTaskVO(var_1_10014, iter_9_3) and var_1_10012:isReceive() then
				table = var_13

				var_13.insert(var_9_0, var_1_10012)
			end
		end

		var_1_10007 = #var_9_0

		local var_9_1 = arg_9_0.rtBg
		local var_9_2 = var_8.Find

		tostring = iter_9_3

		local var_9_3 = var_9_2(var_9_1, iter_9_3(iter_9_0))

		setText = var_9

		local var_9_4 = var_9_3:Find("name/Text")

		i18n = var_1_10012

		var_9(var_9_4, var_1_10012("yumia_buff_name_" .. iter_9_0))

		setText = var_9

		local var_9_5 = var_9_3:Find("name/level")

		string = var_1_10012

		var_9(var_9_5, var_1_10012.format("LV.<size=30>%s</size>", var_1_10007))

		UIItemList = var_9

		local var_9_6 = var_9.StaticAlign
		local var_9_7 = var_9_3:Find("buffs")

		var_1_10014 = var_9_3

		var_9_6(var_9_7, var_9_3.Find(var_1_10014, "buffs/tpl"), #var_9_0, function(arg_10_0, arg_10_1, arg_10_2)
			arg_10_1 = arg_10_1 + 1
			UIItemList = var_2_10003

			if arg_10_0 == var_2_10003.EventUpdate then
				Drop = var_3

				local var_10_0 = var_3.Create
				local var_10_1 = var_9_0[arg_10_1]
				local var_10_2 = var_10_0(var_5.getConfig(var_10_1, "award_display")[1])

				GetImageSpriteFromAtlasAsync = var_2_10004

				var_2_10004(var_10_2:getIcon(), "", arg_10_2, false)
			end

			return
		end)

		onButton = var_9_6

		local var_9_8 = arg_9_0

		var_1_10012 = var_9_3

		local function var_9_9()
			local var_11_0 = arg_9_0

			var_0.ShowUpgrade(var_11_0, iter_9_0)

			pg = var_0

			local var_11_1 = var_0.UIMgr.GetInstance()

			var_0.BlurPanel(var_11_1, arg_9_0.rtUpgrade)

			setActive = var_0

			var_0(arg_9_0.rtUpgrade, true)

			for iter_11_0 = 1, 4 do
				local var_11_2 = arg_9_0.rtUpgrade
				local var_11_3 = var_4.Find(var_11_2, "main/ring")
				local var_11_4 = var_4.Find(var_11_3, "lv" .. iter_11_0)

				setCanvasGroupAlpha = var_2_10005

				var_2_10005(var_11_4, 0)

				var_2_10005 = {}

				if 1 < iter_11_0 then
					table = var_6

					var_6.insert(var_2_10005, function(arg_12_0)
						onDelayTick = var_3_10001

						var_3_10001(arg_12_0, (iter_11_0 - 1) * 0.08)

						return
					end)
				end

				seriesAsync = var_6

				var_6(var_2_10005, function()
					quickPlayAnimation = var_3_10000

					local var_13_0 = var_11_4

					string = var_3_10003

					var_3_10000(var_13_0, var_3_10003.format("Anim_AteriaYumiaCoreBuffLayer_lv%d_In", iter_11_0))

					return
				end)
			end

			return
		end

		SFX_PANEL = var_1_10014

		var_9_6(var_9_8, var_1_10012, var_9_9, var_1_10014)
	end

	return
end

function var_0_1.ShowUpgrade(arg_14_0, arg_14_1, arg_14_2)
	arg_14_1 = arg_14_1 or arg_14_0.index
	arg_14_0.index = arg_14_1

	local var_14_0 = arg_14_0.config[arg_14_1]
	local var_14_1 = 0

	ipairs = var_1_10005

	for iter_14_0, iter_14_1 in var_1_10005(var_14_0) do
		getProxy = var_1_10010
		TaskProxy = var_1_10012
		var_1_10012 = var_1_10010(var_1_10012)
		var_1_10010 = var_1_10010.getTaskVO(var_1_10012, iter_14_1)

		local var_14_2 = arg_14_0.rtUpgrade
		local var_14_3 = var_11.Find(var_14_2, "main/ring")
		local var_14_4 = var_11.Find(var_14_3, "lv" .. iter_14_0)
		local var_14_5 = var_1_10010

		if var_1_10010.isReceive(var_14_5) then
			var_14_1 = iter_14_0
			Drop = var_14_3
			var_14_3 = var_14_3.Create(var_1_10010:getConfig("award_display")[1])
			GetImageSpriteFromAtlasAsync = var_14_5

			var_14_5(var_14_3:getIcon(), "", var_14_4:Find("active/icon"), false)

			setText = var_14_5

			var_14_5(var_14_4:Find("active/icon/name"), var_14_3:getName())

			setText = var_14_5

			var_14_5(var_14_4:Find("active/icon/Text"), var_14_3.desc)
		else
			setText = var_14_3

			local var_14_6 = var_14_4:Find("inactive/Text")

			i18n = var_1_10016

			var_14_3(var_14_6, var_1_10016("yumia_buff_4", iter_14_0))
		end

		if arg_14_2 then
			isActive = var_14_3

			if not var_14_3(var_14_4:Find("active")) and var_1_10012 then
				quickPlayAnimation = var_14_3

				var_14_3(var_14_4, "Anim_AteriaYumiaCoreBuffLayer_active")
			end
		end

		setActive = var_14_3

		var_14_3(var_14_4:Find("active"), var_1_10012)

		setActive = var_14_3

		var_14_3(var_14_4:Find("inactive"), not var_1_10012)
	end

	local var_14_7 = arg_14_0.rtUpgrade
	local var_14_8 = var_5.Find(var_14_7, "main/content")

	setText = var_14_11

	local var_14_9 = var_14_8:Find("icon/core_name")

	i18n = iter_14_1

	var_14_11(var_14_9, iter_14_1("yumia_buff_name_" .. arg_14_1))

	setText = var_14_11

	local var_14_10 = var_14_8:Find("icon/desc")

	i18n = var_9

	var_14_11(var_14_10, var_9("yumia_buff_desc_" .. arg_14_1))

	local var_14_11

	if arg_14_2 then
		var_14_10 = var_14_8
		var_14_11 = var_14_8.GetComponent
		typeof = var_9
		DftAniEvent = var_11
		var_14_10 = var_14_11(var_14_10, var_9(var_11))

		var_14_11.SetEndEvent(var_14_10, function()
			setText = var_2_10000

			local var_15_0 = var_14_8
			local var_15_1 = var_2.Find(var_15_0, "icon/level")

			string = var_2_10003

			var_2_10000(var_15_1, var_2_10003.format("LV.<size=50><color=#ffffff00>%s</color></size>", var_14_1))

			setText = var_2_10000

			local var_15_2 = var_14_8
			local var_15_3 = var_2.Find(var_15_2, "icon/level/number")

			string = var_3

			var_2_10000(var_15_3, var_3.format("<size=50>%s</size>", var_14_1))

			onNextTick = var_2_10000

			var_2_10000(function()
				setCanvasGroupAlpha = var_3_10000

				local var_16_0 = var_14_8

				var_3_10000(var_2.Find(var_16_0, "icon/level/number"), 1)

				return
			end)

			return
		end)

		quickPlayAnimation = var_14_11

		var_14_11(var_14_8, "Anim_AteriaYumiaCoreBuffLayer_active_Level")
	else
		setText = var_14_11
		var_14_10 = var_14_8:Find("icon/level")
		string = var_9

		var_14_11(var_14_10, var_9.format("LV.<size=50><color=#ffffff00>%s</color></size>", var_14_1))

		setText = var_14_11
		var_14_10 = var_14_8:Find("icon/level/number")
		string = var_9

		var_14_11(var_14_10, var_9.format("<size=50>%s</size>", var_14_1))
	end

	getProxy = var_14_11
	TaskProxy = var_14_10

	local var_14_12 = var_14_11(var_14_10)
	local var_14_13 = var_6.getTaskVO

	math = var_9

	local var_14_14 = var_14_13(var_14_12, var_14_0[var_9.min(var_14_1 + 1, #var_14_0)])
	local var_14_15 = var_6.getGiveDrops(var_14_14)

	setText = var_14_12

	local var_14_16 = var_14_8:Find("cost/Text")

	i18n = var_11

	var_14_12(var_14_16, var_11("yumia_buff_1"))

	UIItemList = var_14_12

	var_14_12.StaticAlign(var_14_8:Find("cost/container"), var_14_8:Find("cost/container/IconTpl"), #var_14_15, function(arg_17_0, arg_17_1, arg_17_2)
		arg_17_1 = arg_17_1 + 1
		UIItemList = var_2_10003

		if arg_17_0 == var_2_10003.EventUpdate then
			local var_17_0 = var_14_15[arg_17_1]

			updateDrop = var_2_10004

			var_2_10004(arg_17_2, var_17_0)

			setText = var_2_10004

			local var_17_1 = arg_17_2:Find("icon_bg/count")

			string = var_7

			var_2_10004(var_17_1, var_7.format("%d/%d", var_17_0:getOwnedCount(), var_17_0.count))

			onButton = var_2_10004

			local var_17_2 = arg_14_0
			local var_17_3 = arg_17_2

			local function var_17_4()
				local var_18_0 = arg_14_0
				local var_18_1 = var_0.emit

				BaseUI = var_3_10003

				var_18_1(var_18_0, var_3_10003.ON_DROP, var_17_0)

				return
			end

			SFX_PANEL = var_9

			var_2_10004(var_17_2, var_17_3, var_17_4, var_9)

			setCanvasGroupAlpha = var_2_10004

			var_2_10004(arg_17_2, 0)

			if 1 < arg_17_1 then
				onDelayTick = var_4

				var_4(function()
					quickPlayAnimation = var_3_10000

					var_3_10000(arg_17_2, "Anim_AteriaYumiaCoreBuffLayer_tpl")

					return
				end, 0.08 * (arg_17_1 - 1))
			else
				quickPlayAnimation = var_4

				var_4(arg_17_2, "Anim_AteriaYumiaCoreBuffLayer_tpl")
			end
		end

		return
	end)

	local var_14_17 = var_6:getTaskStatus()

	setActive = var_14_14

	var_14_14(var_14_8:Find("btn_lock"), var_14_17 == 0)

	setText = var_14_14

	local var_14_18 = var_14_8:Find("btn_lock/Text")

	i18n = var_12

	var_14_14(var_14_18, var_12("yumia_buff_2"))

	setActive = var_14_14

	var_14_14(var_14_8:Find("btn_confirm"), var_14_17 == 1)

	setText = var_14_14

	local var_14_19 = var_14_8:Find("btn_confirm/Text")

	i18n = var_12

	var_14_14(var_14_19, var_12("yumia_buff_2"))

	setActive = var_14_14

	var_14_14(var_14_8:Find("btn_finish"), var_14_17 == 2)

	setText = var_14_14

	local var_14_20 = var_14_8:Find("btn_finish/Text")

	i18n = var_12

	var_14_14(var_14_20, var_12("yumia_buff_3"))

	onButton = var_14_14

	local var_14_21 = arg_14_0
	local var_14_22 = var_14_8
	local var_14_23 = var_14_8.Find(var_14_22, "btn_confirm")

	local function var_14_24()
		local var_20_0 = arg_14_0
		local var_20_1 = var_0.emit

		AterialYumiaCoreBuffMediator = var_2_10003

		var_20_1(var_20_0, var_2_10003.SUBMIT_TASK, var_0.id)

		return
	end

	SFX_CONFIRM = var_14_22

	var_14_14(var_14_21, var_14_23, var_14_24, var_14_22)

	return
end

function var_0_1.willExit(arg_21_0)
	isActive = var_1_10001

	if var_1_10001(arg_21_0.rtUpgrade) then
		pg = var_1

		local var_21_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_21_0, arg_21_0.rtUpgrade, arg_21_0._tf)

		setActive = var_1

		var_1(arg_21_0.rtUpgrade, false)
	end

	return
end

function var_0_1.onBackPressed(arg_22_0)
	isActive = var_1_10001

	if var_1_10001(arg_22_0.rtUpgrade) then
		triggerButton = var_1

		local var_22_0 = arg_22_0.rtUpgrade

		var_1(var_3.Find(var_22_0, "top/btn_back"))
	else
		triggerButton = var_1

		var_1(arg_22_0.btnReturn)
	end

	return
end

return var_0_1

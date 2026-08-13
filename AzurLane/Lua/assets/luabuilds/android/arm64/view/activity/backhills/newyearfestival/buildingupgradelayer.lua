class = var_0_10000

local var_0_0 = "BuildingUpgradeLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "BuildingUpgradePanel"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.btnUpgrade = var_1.Find(var_2_0, "window/frame/upgrade_btn")
	setText = var_1

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "window/frame/costback/label")

	i18n = var_4

	var_1(var_2_2, var_4("word_consume"))

	setText = var_1

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_3.Find(var_2_3, "window/frame/upgrade_btn/Image")

	i18n = var_4

	var_1(var_2_4, var_4("msgbox_text_upgrade"))

	AutoLoader = var_1
	arg_2_0.loader = var_1.New()

	return
end

function var_0_1.UpdateActivity(arg_3_0, arg_3_1)
	arg_3_0.activity = arg_3_1

	return
end

function var_0_1.didEnter(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_4_0, arg_4_0._tf)

	onButton = var_1

	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0._tf

	var_1(var_4_1, var_4.Find(var_4_2, "window/top/btnBack"), function()
		local var_5_0 = arg_4_0

		var_0.closeView(var_5_0)

		return
	end)

	onButton = var_1

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0._tf

	var_1(var_4_3, var_4.Find(var_4_4, "mengban"), function()
		local var_6_0 = arg_4_0

		var_0.closeView(var_6_0)

		return
	end)
	arg_4_0:Set(arg_4_0.activity)

	return
end

function var_0_1.Set(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2 = arg_7_2 or arg_7_0.contextData.buildingID
	pg = var_1_10003

	local var_7_0 = var_1_10003.activity_event_building[arg_7_2]

	assert = var_1_10004

	var_1_10004(var_7_0, "Can't Find activity_event_building Config ID: " .. arg_7_2)

	arg_7_0.contextData.buildingID = arg_7_2

	local var_7_1 = #var_7_0.buff
	local var_7_2

	if not arg_7_1.data1KeyValueList[2][arg_7_2] then
		var_7_2 = 1
	end

	local var_7_3 = var_7_0.material[var_7_2]
	local var_7_4 = var_7_1 <= var_7_2
	local var_7_5 = 0
	local var_7_6 = false

	if not var_7_4 then
		var_7_5 = var_7_3[1][2]

		if not arg_7_1.data1KeyValueList[1][var_7_5] then
			var_1_10010 = 0
		end

		var_7_6 = var_7_4 or var_7_3[1][3] <= var_1_10010
	end

	setText = var_1_10010

	local var_7_7 = arg_7_0._tf

	var_1_10010(var_12.Find(var_7_7, "window/top/name"), var_7_0.name)

	setText = var_1_10010

	local var_7_8 = arg_7_0._tf

	var_1_10010(var_12.Find(var_7_8, "window/top/name/lv"), "Lv." .. var_7_2)

	setScrollText = var_1_10010

	local var_7_9 = arg_7_0._tf

	var_1_10010(var_12.Find(var_7_9, "window/frame/describe/text"), var_7_0.desc)

	setText = var_1_10010

	local var_7_10 = arg_7_0._tf

	var_1_10010(var_12.Find(var_7_10, "window/frame/content/title/lv/current"), "Lv." .. var_7_2)

	setActive = var_1_10010

	local var_7_11 = arg_7_0._tf

	var_1_10010(var_12.Find(var_7_11, "window/frame/content/title/lv/next"), not var_7_4)

	if not var_7_4 then
		setText = var_1_10010

		local var_7_12 = arg_7_0._tf

		var_1_10010(var_7_18.Find(var_7_12, "window/frame/content/title/lv/next"), "Lv." .. var_7_2 + 1)
	end

	local var_7_13 = var_7_0.buff[var_7_2]

	pg = var_1_10011

	local var_7_14 = var_1_10011.benefit_buff_template[var_7_13]

	assert = var_7_18

	var_7_18(var_7_14, "Can't Find benefit_buff_template Config ID: " .. var_7_13)

	setText = var_7_18

	local var_7_15 = arg_7_0._tf

	var_7_18(var_14.Find(var_7_15, "window/frame/content/preview/current"), var_7_14.desc)

	setActive = var_7_18

	local var_7_16 = arg_7_0._tf

	var_7_18(var_14.Find(var_7_16, "window/frame/content/preview/arrow"), not var_7_4)

	setActive = var_7_18

	local var_7_17 = arg_7_0._tf

	var_7_18(var_14.Find(var_7_17, "window/frame/content/preview/next"), not var_7_4)

	local var_7_18

	if not var_7_4 then
		var_7_18 = var_7_0.buff[var_7_2 + 1]
		pg = var_13

		local var_7_19 = var_13.benefit_buff_template[var_7_18]

		assert = var_13

		var_13(var_7_19, "Can't Find benefit_buff_template Config ID: " .. var_7_18)

		setText = var_13

		local var_7_20 = arg_7_0._tf

		var_13(var_15.Find(var_7_20, "window/frame/content/preview/next"), var_7_19.desc)

		local var_7_21 = arg_7_0.loader
		local var_7_22 = var_13.GetSprite

		Item = var_16

		local var_7_23 = var_16.getConfigData(var_7_5).icon
		local var_7_24 = ""
		local var_7_25 = arg_7_0._tf

		var_7_22(var_7_21, var_7_23, var_7_24, var_18.Find(var_7_25, "window/frame/costback/icon"))
	end

	setText = var_7_18

	local var_7_26 = arg_7_0._tf
	local var_7_27 = var_14.Find(var_7_26, "window/frame/costback/cost")
	local var_7_28

	if var_7_4 or not var_7_0.material[var_7_2][1][3] then
		var_7_28 = 0
	end

	var_7_18(var_7_27, var_7_28)

	onButton = var_7_18

	var_7_18(arg_7_0, arg_7_0.btnUpgrade, function()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		i18n = var_2_10004
		var_8_2.content = var_2_10004("building_upgrade_tip")

		function var_8_2.onYes()
			if var_7_4 then
				return
			else
				local var_9_1

				if var_7_6 then
					local var_9_0 = arg_7_0

					var_9_1 = var_9_1.emit
					BuildingUpgradeMediator = var_3_10003

					var_9_1(var_9_0, var_3_10003.ACTIVITY_OPERATION, {
						cmd = 1,
						activity_id = arg_7_0.activity.id,
						arg1 = arg_7_2
					})
				else
					pg = var_9_1

					local var_9_2 = var_9_1.TipsMgr.GetInstance()
					local var_9_3 = var_0.ShowTips

					i18n = var_3_10003

					var_9_3(var_9_2, var_3_10003("building_tip"))
				end
			end

			return
		end

		var_8_1(var_8_0, var_8_2)

		return
	end)

	setGray = var_7_18

	var_7_18(arg_7_0.btnUpgrade, var_7_4)

	setButtonEnabled = var_7_18

	var_7_18(arg_7_0.btnUpgrade, not var_7_4)

	return
end

function var_0_1.willExit(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_10_0, arg_10_0._tf)

	return
end

return var_0_1

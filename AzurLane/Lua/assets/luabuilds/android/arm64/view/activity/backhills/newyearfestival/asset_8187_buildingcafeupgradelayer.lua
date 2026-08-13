class = var_0_10000

local var_0_0 = "BuildingCafeUpgradeLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BuildingUpgradeLayer"))
local var_0_2 = {
	17,
	18
}

function var_0_1.Set(arg_1_0, arg_1_1, arg_1_2)
	arg_1_2 = arg_1_2 or arg_1_0.contextData.buildingID
	pg = var_1_10003

	local var_1_0 = var_1_10003.activity_event_building[arg_1_2]

	assert = var_1_10004

	var_1_10004(var_1_0, "Can't Find activity_event_building Config ID: " .. arg_1_2)

	arg_1_0.contextData.buildingID = arg_1_2

	local var_1_1 = #var_1_0.buff
	local var_1_2

	if not arg_1_1.data1KeyValueList[2][arg_1_2] then
		var_1_2 = 1
	end

	local var_1_3 = var_1_0.material[var_1_2]

	assert = var_7

	var_7(#var_1_3 == 1)

	local var_1_4 = var_1_3[1][2]
	local var_1_5

	if not arg_1_1.data1KeyValueList[1][var_1_4] then
		var_1_5 = 0
	end

	local var_1_6 = var_1_1 <= var_1_2 or var_1_5 >= var_1_3[1][3]

	table = var_1_10011

	local var_1_7 = var_1_10011.indexof(var_0_2, arg_1_2)
	local var_1_8 = var_0_2[3 - var_1_7]
	local var_1_9

	if not arg_1_1.data1KeyValueList[2][var_1_8] then
		var_1_9 = 1
	end

	local var_1_10 = var_1_2 <= var_1_9
	local var_1_11 = var_1_2 + var_1_9

	setText = var_1_10016

	local var_1_12 = arg_1_0._tf

	var_1_10016(var_18.Find(var_1_12, "window/top/name"), var_1_0.name)

	setText = var_1_10016

	local var_1_13 = arg_1_0._tf

	var_1_10016(var_18.Find(var_1_13, "window/top/name/lv"), "Lv." .. var_1_2)

	setScrollText = var_1_10016

	local var_1_14 = arg_1_0._tf

	var_1_10016(var_18.Find(var_1_14, "window/frame/describe/text"), var_1_0.desc)

	setText = var_1_10016

	local var_1_15 = arg_1_0._tf

	var_1_10016(var_18.Find(var_1_15, "window/frame/content/title/lv/current"), "Lv." .. var_1_2)

	setActive = var_1_10016

	local var_1_16 = arg_1_0._tf

	var_1_10016(var_18.Find(var_1_16, "window/frame/content/title/lv/next"), not var_9)

	if not var_9 then
		setText = var_1_10016

		local var_1_17 = arg_1_0._tf

		var_1_10016(var_18.Find(var_1_17, "window/frame/content/title/lv/next"), "Lv." .. var_1_2 + 1)
	end

	local var_1_18 = var_1_0.buff[var_1_2]

	pg = var_1_10017

	local var_1_19 = var_1_10017.benefit_buff_template[var_1_18]

	assert = var_18

	var_18(var_1_19, "Can't Find benefit_buff_template Config ID: " .. var_1_18)

	setText = var_18

	local var_1_20 = arg_1_0._tf

	var_18(var_20.Find(var_1_20, "window/frame/content/preview/current"), var_1_19.desc)

	setActive = var_18

	local var_1_21 = arg_1_0._tf

	var_18(var_20.Find(var_1_21, "window/frame/content/preview/arrow"), not var_9)

	setActive = var_18

	local var_1_22 = arg_1_0._tf

	var_18(var_20.Find(var_1_22, "window/frame/content/preview/next"), not var_9)

	if not var_9 then
		local var_1_23 = var_1_0.buff[var_1_2 + 1]

		pg = var_19

		local var_1_24 = var_19.benefit_buff_template[var_1_23]

		assert = var_19

		var_19(var_1_24, "Can't Find benefit_buff_template Config ID: " .. var_1_23)

		setText = var_19

		local var_1_25 = arg_1_0._tf

		var_19(var_21.Find(var_1_25, "window/frame/content/preview/next"), var_1_24.desc)
	end

	local var_1_26 = arg_1_0.loader
	local var_1_27 = var_18.GetSprite

	Item = var_21

	local var_1_28 = var_21.getConfigData(var_1_4).icon
	local var_1_29 = ""
	local var_1_30 = arg_1_0._tf

	var_1_27(var_1_26, var_1_28, var_1_29, var_23.Find(var_1_30, "window/frame/costback/icon"))

	setText = var_1_27

	local var_1_31 = arg_1_0._tf
	local var_1_32 = var_20.Find(var_1_31, "window/frame/costback/cost")
	local var_1_33

	if not var_1_0.material[var_1_2] then
		var_1_33 = 0
	end

	var_1_27(var_1_32, var_1_33)

	onButton = var_1_27

	var_1_27(arg_1_0, arg_1_0.btnUpgrade, function()
		local var_2_0

		if not var_1_10 then
			pg = var_2_0
			var_2_0 = var_2_0.activity_event_building[var_1_8].name
			pg = var_1

			local var_2_1 = var_1.TipsMgr.GetInstance()
			local var_2_2 = var_1.ShowTips

			i18n = var_2_10004

			var_2_2(var_2_1, var_2_10004("backhill_cantupbuilding", var_2_0))

			return
		end

		pg = var_2_0

		local var_2_3 = var_2_0.MsgboxMgr.GetInstance()
		local var_2_4 = var_0.ShowMsgBox
		local var_2_5 = {}

		i18n = var_2_10004
		var_2_5.content = var_2_10004("building_upgrade_tip")

		function var_2_5.onYes()
			if var_0 then
				return
			elseif var_1_6 then
				local var_3_0 = arg_1_0
				local var_3_1 = var_0.emit

				BuildingUpgradeMediator = var_3_10003

				var_3_1(var_3_0, var_3_10003.ACTIVITY_OPERATION, {
					cmd = 1,
					activity_id = arg_1_0.activity.id,
					arg1 = arg_1_2
				})
			else
				local var_3_3

				if var_1_11 < 8 then
					pg = var_3_3

					local var_3_2 = var_3_3.TipsMgr.GetInstance()

					var_3_3 = var_3_3.ShowTips
					i18n = var_3_10003

					var_3_3(var_3_2, var_3_10003("backhill_notenoughbuilding"))
				else
					pg = var_3_3

					local var_3_4 = var_3_3.TipsMgr.GetInstance()
					local var_3_5 = var_0.ShowTips

					i18n = var_3_10003

					var_3_5(var_3_4, var_3_10003("building_tip"))
				end
			end

			return
		end

		var_2_4(var_2_3, var_2_5)

		return
	end)

	setGray = var_1_27

	var_1_27(arg_1_0.btnUpgrade, var_9 or not var_1_10)

	setButtonEnabled = var_1_27

	var_1_27(arg_1_0.btnUpgrade, not var_9)

	return
end

return var_0_1

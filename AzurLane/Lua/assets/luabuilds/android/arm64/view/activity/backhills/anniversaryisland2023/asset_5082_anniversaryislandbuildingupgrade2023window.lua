class = var_0_10000

local var_0_0 = "AnniversaryIslandBuildingUpgrade2023Window"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AnniversaryIslandBuildingUpgrade2023Window"
end

function var_0_1.GetAtlasPath(arg_2_0)
	return "ui/" .. arg_2_0:getUIName() .. "_atlas"
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.window = var_1.Find(var_3_0, "Window")

	local var_3_1 = arg_3_0.window

	arg_3_0.upgradeWindow = var_1.Find(var_3_1, "Upgrade")

	local var_3_2 = arg_3_0.window

	arg_3_0.displayWindow = var_1.Find(var_3_2, "Display")
	setText = var_1

	local var_3_3 = arg_3_0.window
	local var_3_4 = var_3.Find(var_3_3, "Upgrade/MaterialsTitle")

	i18n = var_4

	var_1(var_3_4, var_4("workbench_need_materials"))

	setText = var_1

	local var_3_5 = arg_3_0.window
	local var_3_6 = var_3.Find(var_3_5, "Display/MaxTip")

	i18n = var_4

	var_1(var_3_6, var_4("workbench_tips6"))

	AutoLoader = var_1
	arg_3_0.loader = var_1.New()

	return
end

function var_0_1.didEnter(arg_4_0)
	local var_4_0 = arg_4_0.contextData.buildingID

	onButton = var_1_10002

	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0._tf

	var_1_10002(var_4_1, var_5.Find(var_4_2, "BG"), function()
		local var_5_0 = arg_4_0

		var_0.onBackPressed(var_5_0)

		return
	end)

	onButton = var_1_10002

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.upgradeWindow
	local var_4_5 = var_5.Find(var_4_4, "Cancel")

	local function var_4_6()
		local var_6_0 = arg_4_0

		var_0.onBackPressed(var_6_0)

		return
	end

	SFX_CANCEL = var_4_4

	var_1_10002(var_4_3, var_4_5, var_4_6, var_4_4)

	onButton = var_1_10002

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0.upgradeWindow

	var_1_10002(var_4_7, var_5.Find(var_4_8, "Upgrade"), function()
		if arg_4_0.isMaxLevel then
			return
		elseif arg_4_0.isOverAvg then
			pg = var_0

			local var_7_0 = var_0.TipsMgr.GetInstance()
			local var_7_1 = var_0.ShowTips

			i18n = var_2_10003

			var_7_1(var_7_0, var_2_10003("haidaojudian_upgrade_limit"))
		elseif arg_4_0.isLackMat then
			pg = var_0

			local var_7_2 = var_0.TipsMgr.GetInstance()
			local var_7_3 = var_0.ShowTips

			i18n = var_2_10003

			var_7_3(var_7_2, var_2_10003("haidaojudian_building_tip"))
		else
			local var_7_4 = arg_4_0
			local var_7_5 = var_0.emit

			BuildingUpgradeMediator = var_2_10003

			var_7_5(var_7_4, var_2_10003.ACTIVITY_OPERATION, {
				cmd = 1,
				activity_id = arg_4_0.activityId,
				arg1 = var_4_0
			})
		end

		return
	end)

	onButton = var_1_10002

	local var_4_9 = arg_4_0
	local var_4_10 = arg_4_0.displayWindow
	local var_4_11 = var_5.Find(var_4_10, "Confirm")

	local function var_4_12()
		local var_8_0 = arg_4_0

		var_0.onBackPressed(var_8_0)

		return
	end

	SFX_PANEL = var_4_10

	var_1_10002(var_4_9, var_4_11, var_4_12, var_4_10)
	arg_4_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_9_0)
	local var_9_0 = arg_9_0.contextData.buildingID

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_9_1 = var_1_10002(var_1_10004)
	local var_9_2 = var_2.getActivityByType

	ActivityConst = var_1_10005
	arg_9_0.activityId = var_9_2(var_9_1, var_1_10005.ACTIVITY_TYPE_BUILDING_BUFF_2).id

	local var_9_3 = var_2:GetBuildingLevel(var_9_0)

	pg = var_9_1
	arg_9_0.isMaxLevel = #var_9_1.activity_event_building[var_9_0].buff <= var_9_3
	arg_9_0.isOverAvg = var_9_3 > var_2:GetTotalBuildingLevel()
	setActive = var_6

	var_6(arg_9_0.upgradeWindow, not arg_9_0.isMaxLevel)

	setActive = var_6

	var_6(arg_9_0.displayWindow, arg_9_0.isMaxLevel)

	local var_9_4

	if not arg_9_0.isMaxLevel or not arg_9_0.displayWindow then
		var_9_4 = arg_9_0.upgradeWindow
	end

	AnniversaryIsland2023Scene = var_1_10007

	local var_9_5 = var_1_10007.Buildings[var_9_0]
	local var_9_6 = arg_9_0.loader

	var_8.GetSpriteQuiet(var_9_6, arg_9_0:GetAtlasPath(), var_9_5, var_9_4:Find("Title/BuildingName"), true)

	local var_9_7 = 0

	;(function()
		local var_10_0 = arg_9_0.loader
		local var_10_1 = var_0.GetSpriteQuiet
		local var_10_2 = arg_9_0
		local var_10_3 = var_3.GetAtlasPath(var_10_2)
		local var_10_4 = var_9_3
		local var_10_5 = var_9_4

		var_10_1(var_10_0, var_10_3, var_10_4, var_5.Find(var_10_5, "Title/LevelBefore"), true)

		local var_10_6 = var_0.buff[var_9_3]

		CommonBuff = var_1

		local var_10_7 = var_1.New({
			id = var_10_6
		})

		string = var_10_0

		local var_10_8 = var_10_0.split(var_10_7:getConfig("desc"), "/")

		assert = var_3

		var_3(var_10_8)

		string = var_3

		local var_10_9, var_10_10, var_10_11 = var_3.find(var_10_8[1], "([^%+]*)%+")

		string = var_6

		local var_10_12 = var_6.sub(var_10_8[1], var_10_10, #var_10_8[1])

		string = var_7

		local var_10_13, var_10_14, var_10_15 = var_7.find(var_10_8[2], "([^%+]*)%+")

		string = var_10

		local var_10_16 = var_10.sub(var_10_8[2], var_10_14, #var_10_8[2])

		setText = var_2_10011

		local var_10_17 = var_9_4

		var_2_10011(var_13.Find(var_10_17, "Progress1/1/Desc"), var_10_11)

		setText = var_2_10011

		local var_10_18 = var_9_4

		var_2_10011(var_13.Find(var_10_18, "Progress1/1/Value"), var_10_12)

		setText = var_2_10011

		local var_10_19 = var_9_4

		var_2_10011(var_13.Find(var_10_19, "Progress2/1/Desc"), var_10_15)

		setText = var_2_10011

		local var_10_20 = var_9_4

		var_2_10011(var_13.Find(var_10_20, "Progress2/1/Value"), var_10_16)

		tonumber = var_2_10011
		var_9_7 = var_2_10011(var_10_7:getConfig("benefit_effect"))

		return
	end)()
	;(function()
		if var_9_3 >= var_0 then
			return
		end

		local var_11_0 = var_9_3 + 1
		local var_11_1 = arg_9_0.loader
		local var_11_2 = var_1.GetSpriteQuiet
		local var_11_3 = arg_9_0
		local var_11_4 = var_4.GetAtlasPath(var_11_3)
		local var_11_5 = var_11_0
		local var_11_6 = var_9_4

		var_11_2(var_11_1, var_11_4, var_11_5, var_6.Find(var_11_6, "Title/LevelAfter"), true)

		local var_11_7 = var_0.buff[var_11_0]

		CommonBuff = var_2_10002

		local var_11_8 = var_2_10002.New({
			id = var_11_7
		})

		string = var_11_1

		local var_11_9 = var_11_1.split(var_11_8:getConfig("desc"), "/")

		assert = var_4

		var_4(var_11_9)

		string = var_4

		local var_11_10, var_11_11, var_11_12 = var_4.find(var_11_9[1], "([^%+]*)%+")

		string = var_7

		local var_11_13 = var_7.sub(var_11_9[1], var_11_11, #var_11_9[1])

		string = var_8

		local var_11_14, var_11_15, var_11_16 = var_8.find(var_11_9[2], "([^%+]*)%+")

		string = var_11

		local var_11_17 = var_11.sub(var_11_9[2], var_11_15, #var_11_9[2])

		setText = var_2_10012

		local var_11_18 = var_9_4

		var_2_10012(var_14.Find(var_11_18, "Progress1/2/Desc"), var_11_12)

		setText = var_2_10012

		local var_11_19 = var_9_4

		var_2_10012(var_14.Find(var_11_19, "Progress1/2/Value"), var_11_13)

		setText = var_2_10012

		local var_11_20 = var_9_4

		var_2_10012(var_14.Find(var_11_20, "Progress2/2/Desc"), var_11_16)

		setText = var_2_10012

		local var_11_21 = var_9_4

		var_2_10012(var_14.Find(var_11_21, "Progress2/2/Value"), var_11_17)

		tonumber = var_2_10012

		local var_11_22 = var_2_10012(var_11_8:getConfig("benefit_effect")) > var_9_7

		setActive = var_14

		local var_11_23 = var_9_4

		var_14(var_16.Find(var_11_23, "Progress2/2/Up"), var_11_22)

		return
	end)()
	;(function()
		if var_9_3 >= var_0 then
			return
		end

		local var_12_0 = var_0.material[var_9_3]

		getProxy = var_1
		ActivityProxy = var_2_10003

		local var_12_1 = var_1(var_2_10003)
		local var_12_2 = var_1.getActivityByType

		ActivityConst = var_2_10004

		local var_12_3 = var_12_2(var_12_1, var_2_10004.ACTIVITY_TYPE_VIRTUAL_BAG)
		local var_12_4 = arg_9_0

		var_12_4.isLackMat = false
		UIItemList = var_12_4

		local var_12_5 = var_12_4.StaticAlign
		local var_12_6 = var_9_4
		local var_12_7 = var_4.Find(var_12_6, "Materials")
		local var_12_8 = var_9_4
		local var_12_9 = var_5.Find(var_12_8, "Materials")

		var_12_5(var_12_7, var_5.GetChild(var_12_9, 0), #var_12_0, function(arg_13_0, arg_13_1, arg_13_2)
			UIItemList = var_3_10003

			if arg_13_0 ~= var_3_10003.EventUpdate then
				return
			end

			local var_13_0 = var_12_0[arg_13_1 + 1]
			local var_13_1 = {
				type = var_13_0[1],
				id = var_13_0[2],
				count = var_13_0[3]
			}
			local var_13_2 = arg_9_0

			var_5.UpdateActivityDrop(var_13_2, arg_13_2:Find("Icon"), var_13_1)

			onButton = var_5

			var_5(arg_9_0, arg_13_2:Find("Icon"), function()
				local var_14_0 = var_13_1.type

				DROP_TYPE_WORKBENCH_DROP = var_4_10001

				if var_14_0 == var_4_10001 then
					local var_14_1 = arg_9_0
					local var_14_2 = var_0.emit

					WorkBenchItemDetailMediator = var_4_10003
					var_4_10003 = var_4_10003.SHOW_DETAIL
					WorkBenchItem = var_4_10004

					var_14_2(var_14_1, var_4_10003, var_4_10004.New({
						configId = var_13_1.id,
						count = var_13_1.count
					}))
				else
					local var_14_3 = arg_9_0
					local var_14_4 = var_0.emit

					BaseUI = var_4_10003

					var_14_4(var_14_3, var_4_10003.ON_DROP, var_13_1)
				end

				return
			end)

			local var_13_3 = var_13_0[2]
			local var_13_4 = var_13_0[3]
			local var_13_5 = var_12_3
			local var_13_6 = var_7.getVitemNumber(var_13_5, var_13_3) < var_13_4

			setText = var_13_5

			local var_13_7 = arg_13_2:Find("Text")

			setColorStr = var_3_10012

			var_13_5(var_13_7, var_3_10012(var_7, var_13_6 and "#bb6754" or "#6b5a48") .. "/" .. var_13_4)

			local var_13_8 = arg_9_0
			local var_13_9

			if not arg_9_0.isLackMat then
				var_13_9 = var_13_6
			end

			var_13_8.isLackMat = var_13_9

			return
		end)

		return
	end)()

	return
end

local var_0_2 = "ui/AtelierCommonUI_atlas"

function var_0_1.UpdateActivityDrop(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	updateDrop = var_1_10004

	var_1_10004(arg_15_1, arg_15_2)

	SetCompomentEnabled = var_1_10004

	local var_15_0 = arg_15_1:Find("icon_bg")

	typeof = var_7
	Image = var_9

	var_1_10004(var_15_0, var_7(var_9), false)

	setActive = var_1_10004

	var_1_10004(arg_15_1:Find("bg"), false)

	setActive = var_1_10004

	var_1_10004(arg_15_1:Find("icon_bg/frame"), false)

	setActive = var_1_10004

	var_1_10004(arg_15_1:Find("icon_bg/stars"), false)

	local var_15_1 = arg_15_2
	local var_15_2 = arg_15_2.getConfig(var_15_1, "rarity")
	local var_15_3 = arg_15_2.type

	DROP_TYPE_EQUIP = var_15_1

	if var_15_3 ~= var_15_1 then
		local var_15_4 = arg_15_2.type

		DROP_TYPE_EQUIPMENT_SKIN = var_15_1

		if var_15_4 == var_15_1 then
			var_15_2 = var_15_2 - 1
		end

		local var_15_5 = "icon_frame_" .. var_15_2

		if arg_15_3 then
			var_15_5 = var_15_5 .. "_small"
		end

		local var_15_6 = arg_15_0.loader

		var_6.GetSpriteQuiet(var_15_6, var_0_2, var_15_5, arg_15_1)

		return
	end
end

function var_0_1.willExit(arg_16_0)
	local var_16_0 = arg_16_0.loader

	var_1.Clear(var_16_0)

	return
end

return var_0_1

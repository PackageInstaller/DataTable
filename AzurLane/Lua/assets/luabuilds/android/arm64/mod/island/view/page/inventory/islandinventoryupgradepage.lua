class = var_0_10000

local var_0_0 = "IslandInventoryUpgradePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandInventoryUpgradeUI"
end

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "frame/bottom/consume/list")
	local var_2_3 = arg_2_0._tf

	arg_2_0.consumeList = var_2_0(var_2_2, var_4.Find(var_2_3, "frame/bottom/consume/list/tpl"))

	local var_2_4 = arg_2_0._tf

	arg_2_0.maxLevelTip = var_1.Find(var_2_4, "frame/bottom/bg/max_level")

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "frame/bottom/capacity/Text")
	local var_2_7 = var_1.GetComponent

	typeof = var_4
	Text = var_2_3
	arg_2_0.capacityTxt = var_2_7(var_2_6, var_4(var_2_3))

	local var_2_8 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_8, "frame/confirm")

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_1.Find(var_2_9, "frame/top/level")
	local var_2_11 = var_1.GetComponent

	typeof = var_4
	Text = var_2_3
	arg_2_0.levelTxt = var_2_11(var_2_10, var_4(var_2_3))

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_1.Find(var_2_12, "frame/top/level/next")
	local var_2_14 = var_1.GetComponent

	typeof = var_4
	Text = var_2_3
	arg_2_0.nextLevelTxt = var_2_14(var_2_13, var_4(var_2_3))

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_1.Find(var_2_15, "frame/top/max_level")
	local var_2_17 = var_1.GetComponent

	typeof = var_4
	Text = var_2_3
	arg_2_0.maxLevelTxt = var_2_17(var_2_16, var_4(var_2_3))

	local var_2_18 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_18, "frame/top/close")
	setText = var_1

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_3.Find(var_2_19, "frame/top/title")

	i18n = var_4

	var_1(var_2_20, var_4("island_bag_upgrade_tip"))

	setText = var_1

	local var_2_21 = arg_2_0._tf
	local var_2_22 = var_3.Find(var_2_21, "frame/bottom/Text")

	i18n = var_4

	var_1(var_2_22, var_4("island_bag_upgrade_req"))

	setText = var_1

	local var_2_23 = arg_2_0._tf
	local var_2_24 = var_3.Find(var_2_23, "frame/bottom/bg/max_level")

	i18n = var_4

	var_1(var_2_24, var_4("island_bag_upgrade_max_level"))

	setText = var_1

	local var_2_25 = arg_2_0._tf
	local var_2_26 = var_3.Find(var_2_25, "frame/bottom/capacity/label")

	i18n = var_4

	var_1(var_2_26, var_4("island_bag_upgrade_capacity"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.confirmBtn

	local function var_3_8()
		getProxy = var_2_10000
		IslandProxy = var_2_10002

		local var_6_0 = var_2_10000(var_2_10002)
		local var_6_1 = var_0.GetIsland(var_6_0)
		local var_6_2 = var_0.GetInventoryAgency(var_6_1)

		if not var_0.CanUpgrade(var_6_2) then
			return
		end

		local var_6_3 = arg_3_0
		local var_6_4 = var_1.emit

		IslandMediator = var_2_10004

		var_6_4(var_6_3, var_2_10004.ON_UPGRADE_INVENTORY)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	return
end

function var_0_1.Show(arg_7_0)
	var_0_1.super.Show(arg_7_0)

	getProxy = var_1
	IslandProxy = var_3

	local var_7_0 = var_1(var_3)
	local var_7_1 = var_1.GetIsland(var_7_0)

	arg_7_0:UpdateConsume(var_7_1)
	arg_7_0:UpdateAddition(var_7_1)
	arg_7_0:UpdateStyle(var_7_1)

	return
end

function var_0_1.UpdateStyle(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.GetInventoryAgency(var_8_0)
	local var_8_2 = var_2.IsMaxLevel(var_8_1)

	setActive = var_8_0

	var_8_0(arg_8_0.confirmBtn, not var_8_2)

	setActive = var_8_0

	var_8_0(arg_8_0.maxLevelTxt.gameObject, var_8_2)

	setActive = var_8_0

	var_8_0(arg_8_0.levelTxt.gameObject, not var_8_2)

	if var_8_2 then
		var_8_0 = arg_8_0.maxLevelTxt
		var_8_0.text = "Lv." .. var_2:GetLevel()
	end

	setActive = var_8_0

	var_8_0(arg_8_0.maxLevelTip, var_8_2)

	setGray = var_8_0

	var_8_0(arg_8_0.confirmBtn, not var_2:CanUpgrade(), true)

	return
end

function var_0_1.UpdateAddition(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:GetInventoryAgency()
	local var_9_1 = var_2.GetCapacity(var_9_0)
	local var_9_2 = var_2:GetLevel()
	local var_9_3 = var_2:GetNextCapacity(var_9_2 + 1) - var_9_1

	arg_9_0.capacityTxt.text = "<color=#393a3c>" .. var_9_1 .. "</color><color=#39bfff> + " .. var_9_3 .. "</color>"
	arg_9_0.levelTxt.text = "Lv." .. var_9_2
	arg_9_0.nextLevelTxt.text = "Lv." .. var_9_2 + 1

	return
end

function var_0_1.UpdateConsume(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:GetInventoryAgency()
	local var_10_1 = var_2.GetUpgradeConsume(var_10_0)
	local var_10_2 = arg_10_0.consumeList

	var_4.make(var_10_2, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = var_10_1[arg_11_1 + 1]

			Drop = var_4

			local var_11_1 = var_4.Create(var_11_0)

			updateCustomDrop = var_2_10005

			var_2_10005(arg_11_2, var_11_1)

			local var_11_2 = var_11_1
			local var_11_3 = var_11_1.getOwnedCount(var_11_2)

			setColorStr = var_6

			local var_11_4 = var_11_3

			if var_11_1.count <= var_11_3 then
				COLOR_GREEN = var_9

				if not var_9 then
					COLOR_RED = var_9
				end

				local var_11_5 = var_6(var_11_4, var_9)

				setText = var_11_2

				var_11_2(arg_11_2:Find("icon_bg/count_bg/count"), var_11_5 .. "/" .. var_11_1.count)

				return
			end
		end
	end)

	local var_10_3 = arg_10_0.consumeList

	var_4.align(var_10_3, #var_10_1)

	return
end

function var_0_1.OnDestroy(arg_12_0)
	return
end

return var_0_1

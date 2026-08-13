class = var_0_10000

local var_0_0 = "BossRushDALUpgradeView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

var_0_1.RES_ID = 65742

function var_0_1.getUIName(arg_1_0)
	return "BossRushUpgradeUIDALCollab"
end

function var_0_1.SetData(arg_2_0, arg_2_1)
	arg_2_0._upgradeActivity = arg_2_1

	return
end

function var_0_1.Show(arg_3_0)
	var_0_1.super.Show(arg_3_0)
	arg_3_0:UpdateView()
	arg_3_0:ShowOrHideResUI(false)
	arg_3_0:BlurPanel(arg_3_0._tf)

	return
end

function var_0_1.UpdateView(arg_4_0)
	arg_4_0:updateRes()

	if arg_4_0._upgradeDetailView.gameObject.activeSelf then
		arg_4_0:updateDetail(arg_4_0._lastSelectedID)
	end

	pairs = var_1

	for iter_4_0, iter_4_1 in var_1(arg_4_0._upgradeList) do
		local var_4_0 = "LV."
		local var_4_1 = arg_4_0._upgradeActivity
		local var_4_2 = var_4_0 .. var_7.GetBuildingLevel(var_4_1, iter_4_0) - 1

		setText = var_7

		var_7(iter_4_1:Find("unselected/level"), var_4_2)

		setText = var_7

		var_7(iter_4_1:Find("selected/level"), var_4_2)
	end

	local var_4_3 = arg_4_0._upgradeActivity
	local var_4_4 = var_1.getConfig(var_4_3, "config_data")

	ipairs = var_4_3

	for iter_4_2, iter_4_3 in var_4_3(var_4_4) do
		local var_4_5 = arg_4_0._tf
		local var_4_6 = var_7.Find(var_4_5, "Panel/upgrade_" .. iter_4_3)

		setText = var_4_5

		local var_4_7 = var_4_6:Find("mask/name")
		local var_4_8 = arg_4_0._upgradeActivity

		var_4_5(var_4_7, var_10.GetBuildingConfigTable(var_4_8, iter_4_3).name)
	end

	return
end

function var_0_1.Hide(arg_5_0)
	if arg_5_0._upgradeDetailView.gameObject.activeSelf then
		arg_5_0:closeUpgradeDetail()

		return
	end

	var_0_1.super.Hide(arg_5_0)
	arg_5_0:UnOverlayPanel(arg_5_0._tf, arg_5_0._parentTf)

	return
end

function var_0_1.OnLoaded(arg_6_0)
	arg_6_0.parentTr = arg_6_0._tf.parent
	arg_6_0._go = arg_6_0._tf.gameObject
	arg_6_0._upgradeList = {}

	local var_6_0 = arg_6_0._upgradeActivity
	local var_6_1 = var_1.getConfig(var_6_0, "config_data")

	ipairs = var_6_0

	for iter_6_0, iter_6_1 in var_6_0(var_6_1) do
		local var_6_2 = arg_6_0._tf
		local var_6_3 = var_7.Find(var_6_2, "Panel/upgrade_" .. iter_6_1)

		onButton = var_6_2

		var_6_2(arg_6_0, var_6_3, function()
			local var_7_0 = arg_6_0

			var_0.openUpgradeDetail(var_7_0, iter_6_1)

			local var_7_1 = arg_6_0

			var_0.setSelected(var_7_1, iter_6_1)

			return
		end)

		local var_6_4 = "LV."
		local var_6_5 = arg_6_0._upgradeActivity
		local var_6_6 = var_6_4 .. var_9.GetBuildingLevel(var_6_5, iter_6_1) - 1

		setText = var_9

		var_9(var_6_3:Find("unselected/level"), var_6_6)

		setText = var_9

		var_9(var_6_3:Find("selected/level"), var_6_6)

		setText = var_9

		local var_6_7 = var_6_3:Find("mask/name")
		local var_6_8 = arg_6_0._upgradeActivity

		var_9(var_6_7, var_11.GetBuildingConfigTable(var_6_8, iter_6_1).name)

		arg_6_0._upgradeList[iter_6_1] = var_6_3
	end

	local var_6_9 = arg_6_0._tf

	arg_6_0._upgradeDetailView = var_2.Find(var_6_9, "UpgradePage")

	local var_6_10 = arg_6_0._upgradeDetailView

	arg_6_0._upgradeDetailCurrentName = var_2.Find(var_6_10, "page/skill/name")

	local var_6_11 = arg_6_0._upgradeDetailView

	arg_6_0._upgradeDetailLevel = var_2.Find(var_6_11, "page/skill/level")

	local var_6_12 = arg_6_0._upgradeDetailView

	arg_6_0._upgradeDetailIcon = var_2.Find(var_6_12, "page/skill/icon")
	arg_6_0._upgradeDetailList = {}

	for iter_6_2 = 1, 3 do
		local var_6_13 = arg_6_0._upgradeDetailView
		local var_6_14 = var_6.Find(var_6_13, "page/upgrade_list/skill_detail_" .. iter_6_2)

		setText = var_6_13

		var_6_13(var_6_14:Find("active/level"), "LV." .. iter_6_2)

		setText = var_6_13

		local var_6_15 = var_6_14
		local var_6_16 = var_6_14.Find(var_6_15, "active/active")

		i18n = var_6_15

		var_6_13(var_6_16, var_6_15("DAL_upgrade_active"))

		setText = var_6_13

		var_6_13(var_6_14:Find("disable/level"), "LV." .. iter_6_2)

		setText = var_6_13

		local var_6_17 = var_6_14
		local var_6_18 = var_6_14.Find(var_6_17, "disable/unlock")

		i18n = var_6_17

		var_6_13(var_6_18, var_6_17("DAL_upgrade_unlock"))

		table = var_6_13

		var_6_13.insert(arg_6_0._upgradeDetailList, var_6_14)
	end

	local var_6_19 = arg_6_0._upgradeDetailView

	arg_6_0._closeDetailBtn = var_2.Find(var_6_19, "Top/back_btn")
	setText = var_2

	local var_6_20 = arg_6_0._closeDetailBtn
	local var_6_21 = var_3.Find(var_6_20, "label")

	i18n = var_6_20

	var_2(var_6_21, var_6_20("DAL_upgrade_program"))

	onButton = var_2

	var_2(arg_6_0, arg_6_0._closeDetailBtn, function()
		local var_8_0 = arg_6_0

		var_0.closeUpgradeDetail(var_8_0)

		return
	end)

	local var_6_22 = arg_6_0._upgradeDetailView

	arg_6_0._upgradeBtn = var_2.Find(var_6_22, "page/upgrade_btn")
	setText = var_2

	local var_6_23 = arg_6_0._upgradeBtn
	local var_6_24 = var_3.Find(var_6_23, "label/upgrade")

	i18n = var_6_23

	var_2(var_6_24, var_6_23("word_levelup"))

	onButton = var_2

	var_2(arg_6_0, arg_6_0._upgradeBtn, function()
		local var_9_0 = arg_6_0.event
		local var_9_1 = var_0.emit

		BossRushDALCollabMediator = var_2_10002

		var_9_1(var_9_0, var_2_10002.ON_UPGRADE, {
			cmd = 1,
			activity_id = arg_6_0._upgradeActivity.id,
			arg1 = arg_6_0._lastSelectedID
		})

		return
	end)

	local var_6_25 = arg_6_0._tf

	arg_6_0._closeBtn = var_2.Find(var_6_25, "Top/back_btn")
	setText = var_2

	local var_6_26 = arg_6_0._closeBtn
	local var_6_27 = var_3.Find(var_6_26, "label")

	i18n = var_6_26

	var_2(var_6_27, var_6_26("DAL_upgrade_ship"))

	setText = var_2

	local var_6_28 = arg_6_0._upgradeDetailView
	local var_6_29 = var_3.Find(var_6_28, "Top/back_btn/label")

	i18n = var_6_28

	var_2(var_6_29, var_6_28("DAL_upgrade_ship"))

	onButton = var_2

	local var_6_30 = arg_6_0
	local var_6_31 = arg_6_0._tf

	var_2(var_6_30, var_4.Find(var_6_31, "Top/res"), function()
		local var_10_0 = arg_6_0.event
		local var_10_1 = var_0.emit

		BaseUI = var_2_10002

		var_10_1(var_10_0, var_2_10002.ON_ITEM, var_0_1.RES_ID)

		return
	end)

	onButton = var_2

	local var_6_32 = arg_6_0
	local var_6_33 = arg_6_0._upgradeDetailView

	var_2(var_6_32, var_4.Find(var_6_33, "Top/res"), function()
		local var_11_0 = arg_6_0.event
		local var_11_1 = var_0.emit

		BaseUI = var_2_10002

		var_11_1(var_11_0, var_2_10002.ON_ITEM, var_0_1.RES_ID)

		return
	end)

	onButton = var_2

	var_2(arg_6_0, arg_6_0._closeBtn, function()
		local var_12_0 = arg_6_0

		var_0.Hide(var_12_0)

		return
	end)

	return
end

function var_0_1.updateRes(arg_13_0)
	local var_13_0 = arg_13_0._upgradeActivity
	local var_13_1 = var_1.GetMaterialCount(var_13_0, var_0_1.RES_ID)

	setText = var_13_0

	local var_13_2 = arg_13_0._tf

	var_13_0(var_3.Find(var_13_2, "Top/res/text"), var_13_1)

	setText = var_13_0

	local var_13_3 = arg_13_0._upgradeDetailView

	var_13_0(var_3.Find(var_13_3, "Top/res/text"), var_13_1)

	return
end

function var_0_1.openUpgradeDetail(arg_14_0, arg_14_1)
	setActive = var_1_10002

	var_1_10002(arg_14_0._upgradeDetailView, true)

	local var_14_0 = arg_14_0._upgradeActivity
	local var_14_1 = var_2.GetBuildingConfigTable(var_14_0, arg_14_1)

	setText = var_14_0

	var_14_0(arg_14_0._upgradeDetailCurrentName, var_14_1.name)

	local var_14_2 = arg_14_0._upgradeList[arg_14_1]
	local var_14_3 = var_3.Find(var_14_2, "unselected/icon")
	local var_14_4 = var_3.GetComponent

	typeof = var_5
	Image = var_1_10006

	local var_14_5 = var_14_4(var_14_3, var_5(var_1_10006)).sprite
	local var_14_6 = arg_14_0._upgradeDetailIcon
	local var_14_7 = var_4.GetComponent

	typeof = var_1_10006
	Image = var_1_10007
	var_14_7(var_14_6, var_1_10006(var_1_10007)).sprite = var_14_5

	local var_14_8 = arg_14_0._upgradeActivity
	local var_14_9 = var_4.GetBuildingLevel(var_14_8, arg_14_1) - 1

	setText = var_14_8

	var_14_8(arg_14_0._upgradeDetailLevel, "LV." .. var_14_9)
	arg_14_0:updateDetail(arg_14_1)
	arg_14_0:BlurPanel(arg_14_0._upgradeDetailView)

	return
end

function var_0_1.updateDetail(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._upgradeActivity
	local var_15_1 = var_2.GetBuildingConfigTable(var_15_0, arg_15_1)
	local var_15_2 = arg_15_0._upgradeActivity
	local var_15_3 = var_3.GetBuildingLevel(var_15_2, arg_15_1)

	setText = var_15_2

	var_15_2(arg_15_0._upgradeDetailLevel, "LV." .. var_15_3 - 1)

	ipairs = var_15_2

	for iter_15_0, iter_15_1 in var_15_2(arg_15_0._upgradeDetailList) do
		if iter_15_0 <= var_15_3 - 1 then
			setActive = var_9

			var_9(iter_15_1:Find("disable"), false)

			setActive = var_9

			var_9(iter_15_1:Find("active"), true)

			setText = var_9

			var_9(iter_15_1:Find("active/desc"), var_15_1.desc[iter_15_0])
		else
			setActive = var_9

			var_9(iter_15_1:Find("disable"), true)

			setActive = var_9

			var_9(iter_15_1:Find("active"), false)
		end
	end

	if 4 <= var_15_3 then
		setActive = var_4

		var_4(arg_15_0._upgradeBtn, false)
	else
		setActive = var_4

		var_4(arg_15_0._upgradeBtn, true)

		local var_15_4 = var_15_1.material[var_15_3][1][3]

		setText = var_5

		local var_15_5 = arg_15_0._upgradeBtn

		var_5(var_6.Find(var_15_5, "label/value"), var_15_4)
	end

	return
end

function var_0_1.closeUpgradeDetail(arg_16_0)
	setActive = var_1_10001

	var_1_10001(arg_16_0._upgradeDetailView, false)
	arg_16_0:UnOverlayPanel(arg_16_0._upgradeDetailView, arg_16_0._tf)

	return
end

function var_0_1.setSelected(arg_17_0, arg_17_1)
	if arg_17_0._lastSelectedID then
		local var_17_0 = arg_17_0._upgradeList[arg_17_0._lastSelectedID]
	end

	local var_17_1 = arg_17_0._upgradeList[arg_17_1]

	arg_17_0._lastSelectedID = arg_17_1

	return
end

function var_0_1.ResUISettings(arg_18_0)
	return true
end

function var_0_1.OnDestroy(arg_19_0)
	arg_19_0.exited = true

	return
end

return var_0_1

local var_0_0 = class("BossRushDALUpgradeView", import("view.base.BaseSubView"))

var_0_0.RES_ID = 65742

function var_0_0.getUIName(arg_1_0)
	return "BossRushUpgradeUIDALCollab"
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	arg_2_0._upgradeActivity = arg_2_1

	return
end

function var_0_0.Show(arg_3_0)
	var_0_0.super.Show(arg_3_0)
	arg_3_0:UpdateView()
	arg_3_0:ShowOrHideResUI(false)
	arg_3_0:BlurPanel(arg_3_0._tf)

	return
end

function var_0_0.UpdateView(arg_4_0)
	arg_4_0:updateRes()

	if arg_4_0._upgradeDetailView.gameObject.activeSelf then
		arg_4_0:updateDetail(arg_4_0._lastSelectedID)
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0._upgradeList) do
		local var_4_0 = "LV." .. arg_4_0._upgradeActivity:GetBuildingLevel(iter_4_0) - 1

		setText(iter_4_1:Find("unselected/level"), var_4_0)
		setText(iter_4_1:Find("selected/level"), var_4_0)
	end

	for iter_4_2, iter_4_3 in ipairs((arg_4_0._upgradeActivity:getConfig("config_data"))) do
		local var_4_1 = arg_4_0._tf:Find("Panel/upgrade_" .. iter_4_3)

		setText(var_4_1:Find("mask/name"), arg_4_0._upgradeActivity:GetBuildingConfigTable(iter_4_3).name)
	end

	return
end

function var_0_0.Hide(arg_5_0)
	if arg_5_0._upgradeDetailView.gameObject.activeSelf then
		arg_5_0:closeUpgradeDetail()

		return
	end

	var_0_0.super.Hide(arg_5_0)
	arg_5_0:UnOverlayPanel(arg_5_0._tf, arg_5_0._parentTf)

	return
end

function var_0_0.OnLoaded(arg_6_0)
	arg_6_0.parentTr = arg_6_0._tf.parent
	arg_6_0._go = arg_6_0._tf.gameObject
	arg_6_0._upgradeList = {}

	for iter_6_0, iter_6_1 in ipairs((arg_6_0._upgradeActivity:getConfig("config_data"))) do
		local var_6_0 = arg_6_0._tf:Find("Panel/upgrade_" .. iter_6_1)

		onButton(arg_6_0, var_6_0, function()
			arg_6_0:openUpgradeDetail(iter_6_1)
			arg_6_0:setSelected(iter_6_1)

			return
		end)

		local var_6_1 = "LV." .. arg_6_0._upgradeActivity:GetBuildingLevel(iter_6_1) - 1

		setText(var_6_0:Find("unselected/level"), var_6_1)
		setText(var_6_0:Find("selected/level"), var_6_1)
		setText(var_6_0:Find("mask/name"), arg_6_0._upgradeActivity:GetBuildingConfigTable(iter_6_1).name)

		arg_6_0._upgradeList[iter_6_1] = var_6_0
	end

	arg_6_0._upgradeDetailView = arg_6_0._tf:Find("UpgradePage")
	arg_6_0._upgradeDetailCurrentName = arg_6_0._upgradeDetailView:Find("page/skill/name")
	arg_6_0._upgradeDetailLevel = arg_6_0._upgradeDetailView:Find("page/skill/level")
	arg_6_0._upgradeDetailIcon = arg_6_0._upgradeDetailView:Find("page/skill/icon")
	arg_6_0._upgradeDetailList = {}

	for iter_6_2 = 1, 3 do
		local var_6_2 = arg_6_0._upgradeDetailView:Find("page/upgrade_list/skill_detail_" .. iter_6_2)

		setText(var_6_2:Find("active/level"), "LV." .. iter_6_2)
		setText(var_6_2:Find("active/active"), i18n("DAL_upgrade_active"))
		setText(var_6_2:Find("disable/level"), "LV." .. iter_6_2)
		setText(var_6_2:Find("disable/unlock"), i18n("DAL_upgrade_unlock"))
		table.insert(arg_6_0._upgradeDetailList, var_6_2)
	end

	arg_6_0._closeDetailBtn = arg_6_0._upgradeDetailView:Find("Top/back_btn")

	setText(arg_6_0._closeDetailBtn:Find("label"), i18n("DAL_upgrade_program"))
	onButton(arg_6_0, arg_6_0._closeDetailBtn, function()
		arg_6_0:closeUpgradeDetail()

		return
	end)

	arg_6_0._upgradeBtn = arg_6_0._upgradeDetailView:Find("page/upgrade_btn")

	setText(arg_6_0._upgradeBtn:Find("label/upgrade"), i18n("word_levelup"))
	onButton(arg_6_0, arg_6_0._upgradeBtn, function()
		arg_6_0.event:emit(BossRushDALCollabMediator.ON_UPGRADE, {
			cmd = 1,
			activity_id = arg_6_0._upgradeActivity.id,
			arg1 = arg_6_0._lastSelectedID
		})

		return
	end)

	arg_6_0._closeBtn = arg_6_0._tf:Find("Top/back_btn")

	setText(arg_6_0._closeBtn:Find("label"), i18n("DAL_upgrade_ship"))
	setText(arg_6_0._upgradeDetailView:Find("Top/back_btn/label"), i18n("DAL_upgrade_ship"))
	onButton(arg_6_0, arg_6_0._tf:Find("Top/res"), function()
		arg_6_0.event:emit(BaseUI.ON_ITEM, var_0_0.RES_ID)

		return
	end)
	onButton(arg_6_0, arg_6_0._upgradeDetailView:Find("Top/res"), function()
		arg_6_0.event:emit(BaseUI.ON_ITEM, var_0_0.RES_ID)

		return
	end)
	onButton(arg_6_0, arg_6_0._closeBtn, function()
		arg_6_0:Hide()

		return
	end)

	return
end

function var_0_0.updateRes(arg_13_0)
	local var_13_0 = arg_13_0._upgradeActivity:GetMaterialCount(var_0_0.RES_ID)

	setText(arg_13_0._tf:Find("Top/res/text"), var_13_0)
	setText(arg_13_0._upgradeDetailView:Find("Top/res/text"), var_13_0)

	return
end

function var_0_0.openUpgradeDetail(arg_14_0, arg_14_1)
	setActive(arg_14_0._upgradeDetailView, true)
	setText(arg_14_0._upgradeDetailCurrentName, arg_14_0._upgradeActivity:GetBuildingConfigTable(arg_14_1).name)

	arg_14_0._upgradeDetailIcon:GetComponent(typeof(Image)).sprite = arg_14_0._upgradeList[arg_14_1]:Find("unselected/icon"):GetComponent(typeof(Image)).sprite

	setText(arg_14_0._upgradeDetailLevel, "LV." .. arg_14_0._upgradeActivity:GetBuildingLevel(arg_14_1) - 1)
	arg_14_0:updateDetail(arg_14_1)
	arg_14_0:BlurPanel(arg_14_0._upgradeDetailView)

	return
end

function var_0_0.updateDetail(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._upgradeActivity:GetBuildingConfigTable(arg_15_1)
	local var_15_1 = arg_15_0._upgradeActivity:GetBuildingLevel(arg_15_1)

	setText(arg_15_0._upgradeDetailLevel, "LV." .. var_15_1 - 1)

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._upgradeDetailList) do
		if iter_15_0 <= var_15_1 - 1 then
			setActive(iter_15_1:Find("disable"), false)
			setActive(iter_15_1:Find("active"), true)
			setText(iter_15_1:Find("active/desc"), var_15_0.desc[iter_15_0])
		else
			setActive(iter_15_1:Find("disable"), true)
			setActive(iter_15_1:Find("active"), false)
		end
	end

	if var_15_1 >= 4 then
		setActive(arg_15_0._upgradeBtn, false)
	else
		setActive(arg_15_0._upgradeBtn, true)
		setText(arg_15_0._upgradeBtn:Find("label/value"), var_15_0.material[var_15_1][1][3])
	end

	return
end

function var_0_0.closeUpgradeDetail(arg_16_0)
	setActive(arg_16_0._upgradeDetailView, false)
	arg_16_0:UnOverlayPanel(arg_16_0._upgradeDetailView, arg_16_0._tf)

	return
end

function var_0_0.setSelected(arg_17_0, arg_17_1)
	if arg_17_0._lastSelectedID then
		-- block empty
	end

	arg_17_0._lastSelectedID = arg_17_1

	return
end

function var_0_0.ResUISettings(arg_18_0)
	return true
end

function var_0_0.OnDestroy(arg_19_0)
	arg_19_0.exited = true

	return
end

return var_0_0

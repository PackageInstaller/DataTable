class = var_0_10000

local var_0_0 = "IslandShipSkillUpgradePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandShipSkillUpgradeUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.upgradeBtn = var_1.Find(var_2_0, "btn_confirm")

	local var_2_1 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_1, "frame_1/close")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "frame_1/title")
	local var_2_4 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.titleTxt = var_2_4(var_2_3, var_3(var_1_10004))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "frame_1/level")
	local var_2_7 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.levelTxt = var_2_7(var_2_6, var_3(var_1_10004))

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "frame_1/next_level")
	local var_2_10 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nextLevelTxt = var_2_10(var_2_9, var_3(var_1_10004))

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_1.Find(var_2_11, "frame_2/desc_bg/Text")
	local var_2_13 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.descTxt = var_2_13(var_2_12, var_3(var_1_10004))

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_1.Find(var_2_14, "frame_2/desc_bg_1/Text")
	local var_2_16 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nextDescTxt = var_2_16(var_2_15, var_3(var_1_10004))
	UIItemList = var_1

	local var_2_17 = var_1.New
	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_2.Find(var_2_18, "frame_2/item_bg/items")
	local var_2_20 = arg_2_0._tf

	arg_2_0.uiItemList = var_2_17(var_2_19, var_3.Find(var_2_20, "frame_2/item_bg/items/tpl"))
	setText = var_1

	local var_2_21 = arg_2_0._tf
	local var_2_22 = var_2.Find(var_2_21, "frame_2/sub_title/Text")

	i18n = var_2_21

	var_1(var_2_22, var_2_21("island_skill_consume_title"))

	setText = var_1

	local var_2_23 = arg_2_0.upgradeBtn
	local var_2_24 = var_2.Find(var_2_23, "Text")

	i18n = var_2_23

	var_1(var_2_24, var_2_23("island_chara_up_button"))

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

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.upgradeBtn

	local function var_3_8()
		local var_6_0 = arg_3_0.ship

		if not var_0.CanUpgradeSkill(var_6_0) then
			return
		end

		local var_6_1 = arg_3_0
		local var_6_2 = var_0.emit

		IslandMediator = var_2_10002

		var_6_2(var_6_1, var_2_10002.SHIP_SKILL_UPGRADE, arg_3_0.ship.id)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	return
end

function var_0_1.AddListeners(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.AddListener

	GAME = var_1_10003

	var_7_1(var_7_0, var_1_10003.ISLAND_SHIP_SKILL_UPGRADE_DONE, arg_7_0.OnSkillUpgrade)

	return
end

function var_0_1.RemoveListeners(arg_8_0)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.RemoveListener

	GAME = var_1_10003

	var_8_1(var_8_0, var_1_10003.ISLAND_SHIP_SKILL_UPGRADE_DONE, arg_8_0.OnSkillUpgrade)

	return
end

function var_0_1.OnSkillUpgrade(arg_9_0)
	arg_9_0:Hide()

	return
end

function var_0_1.OnShow(arg_10_0, arg_10_1)
	arg_10_0.ship = arg_10_1

	local var_10_0 = arg_10_1
	local var_10_1 = arg_10_1.GetSkill(var_10_0)

	Clone = var_10_0

	local var_10_2 = var_10_0(var_10_1)

	var_3.Upgrade(var_10_2)
	arg_10_0:UpdateMain(var_10_1, var_3)
	arg_10_0:BlurPanel(arg_10_0._tf)

	return
end

function var_0_1.UpdateMain(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.titleTxt.text = arg_11_1:GetName()
	arg_11_0.levelTxt.text = "Lv." .. arg_11_1:GetLevel()
	arg_11_0.nextLevelTxt.text = "Lv." .. arg_11_2:GetLevel()
	arg_11_0.descTxt.text = arg_11_1:GetEffectDesc()
	arg_11_0.nextDescTxt.text = arg_11_2:GetEffectDesc()

	arg_11_0:UpdateConsume(arg_11_1)

	setGray = var_3

	local var_11_0 = arg_11_0.upgradeBtn
	local var_11_1 = arg_11_0.ship

	var_3(var_11_0, not var_5.CanUpgradeSkill(var_11_1), true)

	return
end

function var_0_1.UpdateConsume(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1
	local var_12_1 = arg_12_1.GetUpgradeMaterial(var_12_0)

	getProxy = var_12_0
	IslandProxy = var_1_10004

	local var_12_2 = var_12_0(var_1_10004)
	local var_12_3 = var_3.GetIsland(var_12_2)
	local var_12_4 = var_3.GetInventoryAgency(var_12_3)
	local var_12_5 = arg_12_0.uiItemList

	var_4.make(var_12_5, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventUpdate then
			local var_13_0 = var_12_1[arg_13_1 + 1]

			updateCustomDrop = var_4

			var_4(arg_13_2, var_13_0)

			local var_13_1 = var_12_4
			local var_13_2 = var_4.GetOwnCount(var_13_1, var_13_0.id)

			setColorStr = var_13_1

			local var_13_3 = var_13_2

			if var_13_0.count <= var_13_2 then
				COLOR_GREEN = var_7

				if not var_7 then
					COLOR_RED = var_7
				end

				local var_13_4 = var_13_1(var_13_3, var_7)

				setText = var_13_3

				var_13_3(arg_13_2:Find("icon_bg/count_bg/count"), var_13_4 .. "/" .. var_13_0.count)

				return
			end
		end
	end)

	local var_12_6 = arg_12_0.uiItemList

	var_4.align(var_12_6, #var_12_1)

	return
end

function var_0_1.OnHide(arg_14_0)
	arg_14_0:UnBlurPanel()

	arg_14_0.selected = {}

	return
end

function var_0_1.OnDestroy(arg_15_0)
	arg_15_0:OnHide()

	return
end

return var_0_1

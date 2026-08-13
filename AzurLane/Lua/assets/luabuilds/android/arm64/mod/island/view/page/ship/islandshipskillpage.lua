class = var_0_10000

local var_0_0 = "IslandShipSkillPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandShipSkillUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.skillIcon = var_1.Find(var_2_0, "adapt/attr_panel/skill/icon")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "adapt/attr_panel/skill/name")
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.skillName = var_2_3(var_2_2, var_4(var_1_10006))

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "adapt/attr_panel/skill/level")
	local var_2_6 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.skillLv = var_2_6(var_2_5, var_4(var_1_10006))

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "adapt/attr_panel/desc/Text")
	local var_2_9 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.descTxt = var_2_9(var_2_8, var_4(var_1_10006))
	UIItemList = var_1

	local var_2_10 = var_1.New
	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_3.Find(var_2_11, "adapt/attr_panel/desc/list")
	local var_2_13 = arg_2_0._tf

	arg_2_0.descList = var_2_10(var_2_12, var_4.Find(var_2_13, "adapt/attr_panel/desc/list/tpl"))
	UIItemList = var_1

	local var_2_14 = var_1.New
	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_3.Find(var_2_15, "adapt/attr_panel/consume/list")
	local var_2_17 = arg_2_0._tf

	arg_2_0.consumeList = var_2_14(var_2_16, var_4.Find(var_2_17, "adapt/attr_panel/consume/list/tpl"))

	local var_2_18 = arg_2_0._tf

	arg_2_0.upgradeBtn = var_1.Find(var_2_18, "adapt/attr_panel/consume/upgrade")

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_1.Find(var_2_19, "adapt/attr_panel/consume/tip")
	local var_2_21 = var_1.GetComponent

	typeof = var_4
	Text = var_2_17
	arg_2_0.tipTxt = var_2_21(var_2_20, var_4(var_2_17))

	local var_2_22 = arg_2_0._tf

	arg_2_0.goldTr = var_1.Find(var_2_22, "adapt/attr_panel/consume/label")

	local var_2_23 = arg_2_0._tf
	local var_2_24 = var_1.Find(var_2_23, "adapt/attr_panel/consume/label/Text")
	local var_2_25 = var_1.GetComponent

	typeof = var_4
	Text = var_2_17
	arg_2_0.goldTxt = var_2_25(var_2_24, var_4(var_2_17))

	local var_2_26 = arg_2_0._tf

	arg_2_0.goldIco = var_1.Find(var_2_26, "adapt/attr_panel/consume/label/icon")
	setText = var_1

	local var_2_27 = arg_2_0._tf
	local var_2_28 = var_3.Find(var_2_27, "adapt/attr_panel/consume/label/label1")

	i18n = var_4

	var_1(var_2_28, var_4("island_ship_breakout_consume"))

	return
end

function var_0_1.OnInit(arg_3_0)
	return
end

function var_0_1.AddListeners(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.AddListener

	GAME = var_1_10004

	var_4_1(var_4_0, var_1_10004.ISLAND_UPGRADE_SKILL_DONE, arg_4_0.OnSkillUpgrade)

	return
end

function var_0_1.RemoveListeners(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.RemoveListener

	GAME = var_1_10004

	var_5_1(var_5_0, var_1_10004.ISLAND_UPGRADE_SKILL_DONE, arg_5_0.OnSkillUpgrade)

	return
end

function var_0_1.OnSkillUpgrade(arg_6_0)
	arg_6_0:Flush()

	return
end

function var_0_1.OnShow(arg_7_0, arg_7_1)
	arg_7_0.selectedId = arg_7_1

	arg_7_0:Flush()

	return
end

function var_0_1.Flush(arg_8_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_8_0 = var_1_10001(var_1_10003)
	local var_8_1 = var_1.GetIsland(var_8_0)
	local var_8_2 = var_1.GetCharacterAgency(var_8_1)

	if var_1.GetShipById(var_8_2, arg_8_0.selectedId) == nil then
		return
	end

	arg_8_0:UpdateMainView(var_1)

	return
end

function var_0_1.UpdateMainView(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:GetMainSkill()
	local var_9_1 = arg_9_1:GetNextLevelMainSkillId()

	arg_9_0:FlushLevelAndIcon(arg_9_1, var_9_0, var_9_1)
	arg_9_0:FlushDesc(arg_9_1, var_9_0, var_9_1)
	arg_9_0:FlushConsume(arg_9_1, var_9_0, var_9_1)
	arg_9_0:FlushUpgradeBtn(arg_9_1, var_9_0, var_9_1)

	return
end

function var_0_1.FlushLevelAndIcon(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	pg = var_1_10004

	local var_10_0 = var_1_10004.island_chara_skill[arg_10_2]

	GetImageSpriteFromAtlasAsync = var_1_10005

	var_1_10005("island/IslandSkillIcon/" .. var_10_0.icon, "", arg_10_0.skillIcon)

	arg_10_0.skillName.text = var_10_0.name

	if arg_10_3 then
		arg_10_0.skillLv.text = "<color=#393a3c>[ Lv." .. var_10_0.level .. " ]</color><color=#006cff>   >   [ Lv." .. var_10_0.level + 1 .. " ]</color>"
	else
		arg_10_0.skillLv.text = "<color=#393a3c>MAX</color>"
	end

	return
end

function var_0_1.FlushDesc(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_1:GetMainSkillUpgradeEffectDesc()
	local var_11_1 = arg_11_0.descList

	var_5.make(var_11_1, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = var_11_0[arg_12_1 + 1].level
			local var_12_1 = var_3.desc

			pg = var_2_10006

			local var_12_2 = var_2_10006.island_chara_skill[arg_11_2].level + 1 == var_12_0 and "#006cff" or "#393a3c"

			setText = var_2_10008

			var_2_10008(arg_12_2:Find("level"), "<color=" .. var_12_2 .. ">[ Lv." .. var_12_0 .. " ]</color>")

			setText = var_2_10008

			local var_12_3 = arg_12_2:Find("Text")
			local var_12_4 = "<color="
			local var_12_5 = var_12_2
			local var_12_6 = ">"

			i18n = var_14

			var_2_10008(var_12_3, var_12_4 .. var_12_5 .. var_12_6 .. var_14("island_word_unlock") .. var_12_1 .. "</color>")

			GetOrAddComponent = var_2_10008

			local var_12_7 = arg_12_2

			typeof = var_11
			CanvasGroup = var_12_6
			var_2_10008(var_12_7, var_11(var_12_6)).alpha = var_12_0 <= var_6 + 1 and 1 or 0.4
		end

		return
	end)

	local var_11_2 = arg_11_0.descList

	var_5.align(var_11_2, #var_11_0)

	local var_11_3

	if arg_11_3 then
		pg = var_11_3
		var_11_3 = var_11_3.island_chara_skill[arg_11_3]
		arg_11_0.descTxt.text = var_11_3.desc
	else
		pg = var_11_3

		local var_11_4 = var_11_3.island_chara_skill[arg_11_2]

		arg_11_0.descTxt.text = var_11_4.desc
	end

	return
end

function var_0_1.FlushConsume(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1:GetUpgradeSkillConsume()

	getProxy = var_1_10005
	IslandProxy = var_1_10007

	local var_13_1 = var_1_10005(var_1_10007)
	local var_13_2 = var_5.GetIsland(var_13_1)
	local var_13_3 = var_5.GetInventoryAgency(var_13_2)
	local var_13_4 = arg_13_0.consumeList

	var_6.make(var_13_4, function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			local var_14_0 = var_13_0[arg_14_1 + 2]

			Drop = var_4

			local var_14_1 = var_4.New({
				type = var_14_0[1],
				id = var_14_0[2],
				count = var_14_0[3]
			})

			updateCustomDrop = var_2_10005

			var_2_10005(arg_14_2, var_14_1)

			local var_14_2 = var_13_3
			local var_14_3 = var_5.GetOwnCount(var_14_2, var_14_1.id) >= var_14_1.count and "#FFFFFF" or "#ff7e7e"

			setText = var_14_2

			local var_14_4 = arg_14_2:Find("icon_bg/count")

			setColorStr = var_2_10010

			var_14_2(var_14_4, var_2_10010(var_5, var_14_3) .. "/" .. var_14_1.count)

			onButton = var_14_2

			local var_14_5 = arg_13_0
			local var_14_6 = arg_14_2

			local function var_14_7()
				local var_15_0 = arg_13_0
				local var_15_1 = var_0.ShowMsgBox
				local var_15_2 = {}

				i18n = var_3_10004
				var_15_2.title = var_3_10004("island_word_ship_buff_desc")
				IslandMsgBox = var_4
				var_15_2.type = var_4.TYPE_ITEM_DESC
				var_15_2.itemId = var_14_1.id

				var_15_1(var_15_0, var_15_2)

				return
			end

			SFX_PANEL = var_12

			var_14_2(var_14_5, var_14_6, var_14_7, var_12)
		end

		return
	end)

	local var_13_5 = arg_13_0.consumeList
	local var_13_6 = var_6.align

	math = var_9

	var_13_6(var_13_5, var_9.max(0, #var_13_0 - 1))

	return
end

function var_0_1.FlushUpgradeBtn(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_1:GetUpgradeSkillConsume()
	local var_16_1 = arg_16_1
	local var_16_2 = arg_16_1.CanUpgradeMainSkill(var_16_1)
	local var_16_3 = arg_16_0.upgradeBtn
	local var_16_4 = var_6.GetComponent

	typeof = var_1_10009
	Image = var_1_10011

	local var_16_5 = var_16_4(var_16_3, var_1_10009(var_1_10011))

	if var_16_2 then
		Color = var_16_1

		if not var_16_1.New(0.2235294, 0.7490196, 1, 1) then
			Color = var_16_1
			var_16_1 = var_16_1.New(0.6117647, 0.6117647, 0.6117647, 1)
		end

		var_16_5.color = var_16_1

		local var_16_6 = true

		if arg_16_3 then
			pg = var_16_1
			var_16_6 = var_16_1.island_chara_skill[arg_16_3].upgrade_unlock <= arg_16_1:GetLevel()

			local var_16_7 = arg_16_0.tipTxt

			i18n = var_1_10010
			var_16_7.text = var_1_10010("island_need_ship_level", var_16_3)
		end

		if var_16_0[1] then
			Drop = var_16_3

			local var_16_8 = var_16_3.New({
				type = var_7[1],
				id = var_7[2],
				count = var_7[3]
			})
			local var_16_9 = var_16_3.getConfigTable(var_16_8)

			GetImageSpriteFromAtlasAsync = var_10

			var_10(var_16_9.icon, "", arg_16_0.goldIco)

			arg_16_0.goldTxt.text = var_16_3.count
		end

		setActive = var_16_3

		var_16_3(arg_16_0.tipTxt.gameObject, not var_16_6)

		setActive = var_16_3

		var_16_3(arg_16_0.goldTr, var_16_6 and var_7)

		setActive = var_16_3

		local var_16_10 = arg_16_0.upgradeBtn
		local var_16_11 = arg_16_1

		var_16_3(var_16_10, not arg_16_1.IsMaxMainSkillLevel(var_16_11))

		onButton = var_16_3

		local var_16_12 = arg_16_0
		local var_16_13 = arg_16_0.upgradeBtn

		local function var_16_14()
			if not var_16_2 then
				return
			end

			local var_17_0 = arg_16_0
			local var_17_1 = var_0.emit

			IslandMediator = var_2_10003

			var_17_1(var_17_0, var_2_10003.UPGRADE_SKILL, arg_16_1.id)

			return
		end

		SFX_PANEL = var_16_11

		var_16_3(var_16_12, var_16_13, var_16_14, var_16_11)

		return
	end
end

function var_0_1.OnDestroy(arg_18_0)
	return
end

return var_0_1

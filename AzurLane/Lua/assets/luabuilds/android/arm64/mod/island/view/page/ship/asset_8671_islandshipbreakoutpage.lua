class = var_0_10000

local var_0_0 = "IslandShipBreakoutPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandShipBreakoutUI"
end

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "frame_1/star/prev")
	local var_2_3 = arg_2_0._tf

	arg_2_0.uiStarPreList = var_2_0(var_2_2, var_4.Find(var_2_3, "frame_1/star/prev/tpl"))
	UIItemList = var_1

	local var_2_4 = var_1.New
	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_3.Find(var_2_5, "frame_1/star/now")
	local var_2_7 = arg_2_0._tf

	arg_2_0.uiStarNextList = var_2_4(var_2_6, var_4.Find(var_2_7, "frame_1/star/now/tpl"))

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "frame_1/level/prev")
	local var_2_10 = var_1.GetComponent

	typeof = var_4
	Text = var_2_7
	arg_2_0.prevLevelTxt = var_2_10(var_2_9, var_4(var_2_7))

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_1.Find(var_2_11, "frame_1/level/now")
	local var_2_13 = var_1.GetComponent

	typeof = var_4
	Text = var_2_7
	arg_2_0.nextLevelTxt = var_2_13(var_2_12, var_4(var_2_7))

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_1.Find(var_2_14, "frame_1/skill/Text")
	local var_2_16 = var_1.GetComponent

	typeof = var_4
	Text = var_2_7
	arg_2_0.skillTxt = var_2_16(var_2_15, var_4(var_2_7))

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_1.Find(var_2_17, "frame_1/skill/now")
	local var_2_19 = var_1.GetComponent

	typeof = var_4
	Text = var_2_7
	arg_2_0.skillLabelTxt = var_2_19(var_2_18, var_4(var_2_7))
	UIItemList = var_1

	local var_2_20 = var_1.New
	local var_2_21 = arg_2_0._tf
	local var_2_22 = var_3.Find(var_2_21, "frame_3/attrs")
	local var_2_23 = arg_2_0._tf

	arg_2_0.uiAttrList = var_2_20(var_2_22, var_4.Find(var_2_23, "frame_3/attrs/tpl"))
	UIItemList = var_1

	local var_2_24 = var_1.New
	local var_2_25 = arg_2_0._tf
	local var_2_26 = var_3.Find(var_2_25, "frame_2/comsume")
	local var_2_27 = arg_2_0._tf

	arg_2_0.uiConsumeList = var_2_24(var_2_26, var_4.Find(var_2_27, "frame_2/comsume/tpl"))

	local var_2_28 = arg_2_0._tf

	arg_2_0.upgradeBtn = var_1.Find(var_2_28, "btn_confirm")

	local var_2_29 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_29, "frame_1/close")
	setText = var_1

	local var_2_30 = arg_2_0._tf
	local var_2_31 = var_3.Find(var_2_30, "frame_1/title")

	i18n = var_4

	var_1(var_2_31, var_4("island_ship_breakout"))

	setText = var_1

	local var_2_32 = arg_2_0._tf
	local var_2_33 = var_3.Find(var_2_32, "frame_2/consume_title/Text")

	i18n = var_4

	var_1(var_2_33, var_4("island_ship_breakout_consume"))

	setText = var_1

	local var_2_34 = arg_2_0.upgradeBtn
	local var_2_35 = var_3.Find(var_2_34, "Text")

	i18n = var_4

	var_1(var_2_35, var_4("island_chara_breakout_button"))

	return
end

function var_0_1.AddListeners(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.AddListener

	GAME = var_1_10004

	var_3_1(var_3_0, var_1_10004.ISLAND_SHIP_BREAKOUT_DONE, arg_3_0.OnBreakOutDone)

	return
end

function var_0_1.RemoveListeners(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.RemoveListener

	GAME = var_1_10004

	var_4_1(var_4_0, var_1_10004.ISLAND_SHIP_BREAKOUT_DONE, arg_4_0.OnBreakOutDone)

	return
end

function var_0_1.OnBreakOutDone(arg_5_0)
	arg_5_0:Hide()

	return
end

function var_0_1.OnInit(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0._tf

	local function var_6_2()
		local var_7_0 = arg_6_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10006)

	onButton = var_1_10001

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.closeBtn

	local function var_6_5()
		local var_8_0 = arg_6_0

		var_0.Hide(var_8_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_3, var_6_4, var_6_5, var_1_10006)

	return
end

function var_0_1.OnShow(arg_9_0, arg_9_1)
	Clone = var_1_10002

	local var_9_0 = var_1_10002(arg_9_1)

	var_2.UpgradeBreakOut(var_9_0)
	arg_9_0:BlurPanel(var_2, arg_9_1)
	arg_9_0:UpdateBreakOutLevel(var_2, arg_9_1)
	arg_9_0:UpdateLevel(var_2, arg_9_1)
	arg_9_0:UpdateSkill(var_2, arg_9_1)
	arg_9_0:UpdateAttrs(var_2, arg_9_1)
	arg_9_0:UpdateConsume(var_2, arg_9_1)
	arg_9_0:UpdateUpgradeBtn(arg_9_1)

	return
end

function var_0_1.UpdateBreakOutLevel(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.uiStarPreList

	var_3.make(var_10_0, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			setActive = var_3

			local var_11_0 = arg_11_2:Find("Image")
			local var_11_1 = arg_11_1 + 1
			local var_11_2 = arg_10_2

			var_3(var_11_0, var_11_1 <= var_7.GetBreakLevel(var_11_2))
		end

		return
	end)

	local var_10_1 = arg_10_0.uiStarPreList

	var_3.align(var_10_1, arg_10_2:GetBreakMaxLevel())

	local var_10_2 = arg_10_0.uiStarNextList

	var_3.make(var_10_2, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			setActive = var_3

			local var_12_0 = arg_12_2:Find("Image")
			local var_12_1 = arg_12_1 + 1
			local var_12_2 = arg_10_1

			var_3(var_12_0, var_12_1 <= var_7.GetBreakLevel(var_12_2))
		end

		return
	end)

	local var_10_3 = arg_10_0.uiStarNextList

	var_3.align(var_10_3, arg_10_1:GetBreakMaxLevel())

	return
end

function var_0_1.UpdateLevel(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.prevLevelTxt.text = "Lv." .. arg_13_2:GetMaxLevel()
	arg_13_0.nextLevelTxt.text = "Lv." .. arg_13_1:GetMaxLevel()

	return
end

function var_0_1.UpdateSkill(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_2:GetSkill()
	local var_14_1 = not var_3.IsUnlock(var_14_0)
	local var_14_2 = arg_14_1:GetSkill()

	if var_4.IsUnlock(var_14_2) and var_14_1 then
		local var_14_3 = arg_14_2:GetSkill()
		local var_14_4 = var_5.GetName(var_14_3)

		arg_14_0.skillTxt.text = var_14_4

		local var_14_5 = arg_14_0.skillLabelTxt

		i18n = var_14_3
		var_14_5.text = var_14_3("island_ship_newskill_unlock")
	else
		arg_14_0.skillTxt.text = ""
		arg_14_0.skillLabelTxt.text = ""
	end

	return
end

function var_0_1.UpdateAttrs(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1:GetGrowthAtt()
	local var_15_1 = arg_15_2:GetGrowthAtt()
	local var_15_2 = arg_15_0.uiAttrList

	var_5.make(var_15_2, function(arg_16_0, arg_16_1, arg_16_2)
		UIItemList = var_2_10003

		if arg_16_0 == var_2_10003.EventUpdate then
			IslandShipAttr = var_3

			local var_16_0 = var_3.ATTRS[arg_16_1 + 1]
			local var_16_1 = arg_15_2
			local var_16_2 = var_4.GetAttrGrade(var_16_1, var_16_0)

			IslandShipAttr = var_2_10005

			local var_16_3 = var_2_10005.Grade2Img(var_16_2)
			local var_16_4 = arg_16_2:Find("grade_bg")
			local var_16_5 = var_6.GetComponent

			typeof = var_9
			Image = var_2_10011

			local var_16_6 = var_16_5(var_16_4, var_9(var_2_10011))

			GetSpriteFromAtlas = var_7
			var_16_6.sprite = var_7("ui/IslandShipUI_atlas", var_16_3[2])
			setText = var_16_6

			local var_16_7 = arg_16_2:Find("name")

			IslandShipAttr = var_9

			var_16_6(var_16_7, var_9.ToChinese(var_16_0))

			setText = var_16_6

			local var_16_8 = arg_16_2:Find("value")
			local var_16_9 = "+"
			local var_16_10

			if not var_15_1[var_16_0] then
				var_16_10 = 0
			end

			local var_16_11 = "  >>>  +"
			local var_16_12

			if not var_15_0[var_16_0] then
				var_16_12 = 0
			end

			var_16_6(var_16_8, var_16_9 .. var_16_10 .. var_16_11 .. var_16_12)
		end

		return
	end)

	local var_15_3 = arg_15_0.uiAttrList
	local var_15_4 = var_5.align

	IslandShipAttr = var_8

	var_15_4(var_15_3, #var_8.ATTRS)

	return
end

function var_0_1.UpdateConsume(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_2:GetBreakoutMatrials()

	getProxy = var_1_10004
	IslandProxy = var_1_10006

	local var_17_1 = var_1_10004(var_1_10006)
	local var_17_2 = var_4.GetIsland(var_17_1)
	local var_17_3 = var_4.GetInventoryAgency(var_17_2)
	local var_17_4 = arg_17_0.uiConsumeList

	var_5.make(var_17_4, function(arg_18_0, arg_18_1, arg_18_2)
		UIItemList = var_2_10003

		if arg_18_0 == var_2_10003.EventUpdate then
			local var_18_0 = var_17_0[arg_18_1 + 1]

			updateCustomDrop = var_4

			var_4(arg_18_2, var_18_0)

			local var_18_1 = var_17_3
			local var_18_2 = var_4.GetOwnCount(var_18_1, var_18_0.id)

			setColorStr = var_2_10005

			local var_18_3 = var_18_2

			if var_18_0.count <= var_18_2 then
				COLOR_GREEN = var_8

				if not var_8 then
					COLOR_RED = var_8
				end

				local var_18_4 = var_2_10005(var_18_3, var_8)

				setText = var_18_1

				var_18_1(arg_18_2:Find("icon_bg/count_bg/count"), var_18_4 .. "/" .. var_18_0.count)

				return
			end
		end
	end)

	local var_17_5 = arg_17_0.uiConsumeList

	var_5.align(var_17_5, #var_17_0)

	return
end

function var_0_1.UpdateUpgradeBtn(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1
	local var_19_1 = arg_19_1.GetBreakoutMatrials(var_19_0)

	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_19_2 = var_1_10003(var_1_10005)
	local var_19_3 = var_3.GetIsland(var_19_2)
	local var_19_4 = var_3.GetInventoryAgency(var_19_3)

	_ = var_19_0

	local var_19_5 = var_19_0.all(var_19_1, function(arg_20_0)
		local var_20_0 = var_19_4

		return var_1.GetOwnCount(var_20_0, arg_20_0.id) >= arg_20_0.count
	end)

	setGray = var_19_3

	var_19_3(arg_19_0.upgradeBtn, not var_19_5, true)

	onButton = var_19_3

	local var_19_6 = arg_19_0
	local var_19_7 = arg_19_0.upgradeBtn

	local function var_19_8()
		if not var_19_5 then
			return
		end

		local var_21_0 = arg_19_0
		local var_21_1 = var_0.emit

		IslandMediator = var_2_10003

		var_21_1(var_21_0, var_2_10003.SHIP_BREAKOUT, arg_19_1.id)

		return
	end

	SFX_PANEL = var_1_10010

	var_19_3(var_19_6, var_19_7, var_19_8, var_1_10010)

	return
end

function var_0_1.OnHide(arg_22_0)
	arg_22_0:UnBlurPanel()

	return
end

return var_0_1

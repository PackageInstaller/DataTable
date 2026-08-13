class = var_0_10000

local var_0_0 = "IslandShipUpgradePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandShipUpgradeUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.expBar = var_1.Find(var_2_0, "frame/frame_1/exp/bar")

	local var_2_1 = arg_2_0._tf

	arg_2_0.expBarPre = var_1.Find(var_2_1, "frame/frame_1/exp/bar_pre")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "frame/frame_1/exp/level")
	local var_2_4 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.levelTxt = var_2_4(var_2_3, var_3(var_1_10004))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "frame/frame_1/exp/Text")
	local var_2_7 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.expTxt = var_2_7(var_2_6, var_3(var_1_10004))

	local var_2_8 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_8, "frame/frame_1/close")

	local var_2_9 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_9, "frame/btn_confirm")

	local var_2_10 = arg_2_0._tf

	arg_2_0.delBtn = var_1.Find(var_2_10, "frame/frame_2/del")

	local var_2_11 = arg_2_0._tf

	arg_2_0.maxBtn = var_1.Find(var_2_11, "frame/frame_2/max")

	local var_2_12 = arg_2_0._tf

	arg_2_0.switchBtn = var_1.Find(var_2_12, "frame/frame_1/switch")
	UIItemList = var_1

	local var_2_13 = var_1.New
	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_2.Find(var_2_14, "frame/frame_1/attr/stars")
	local var_2_16 = arg_2_0._tf

	arg_2_0.uiBreakList = var_2_13(var_2_15, var_3.Find(var_2_16, "frame/frame_1/attr/stars/tpl"))
	UIItemList = var_1

	local var_2_17 = var_1.New
	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_2.Find(var_2_18, "frame/frame_1/attr/list")
	local var_2_20 = arg_2_0._tf

	arg_2_0.uiAttrList = var_2_17(var_2_19, var_3.Find(var_2_20, "frame/frame_1/attr/list/tpl"))
	UIItemList = var_1

	local var_2_21 = var_1.New
	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_2.Find(var_2_22, "frame/frame_2/items")
	local var_2_24 = arg_2_0._tf

	arg_2_0.uiItemList = var_2_21(var_2_23, var_3.Find(var_2_24, "frame/frame_2/items/tpl"))
	setText = var_1

	local var_2_25 = arg_2_0._tf
	local var_2_26 = var_2.Find(var_2_25, "frame/frame_1/title")

	i18n = var_2_25

	var_1(var_2_26, var_2_25("island_word_ship_level_upgrade"))

	setText = var_1

	local var_2_27 = arg_2_0._tf
	local var_2_28 = var_2.Find(var_2_27, "frame/frame_2/sub_title/Text")

	i18n = var_2_27

	var_1(var_2_28, var_2_27("island_skill_consume_title"))

	setText = var_1

	local var_2_29 = arg_2_0._tf
	local var_2_30 = var_2.Find(var_2_29, "frame/frame_1/attr/label")

	i18n = var_2_29

	var_1(var_2_30, var_2_29("island_word_ship_level_upgrade_1"))

	setText = var_1

	local var_2_31 = arg_2_0._tf
	local var_2_32 = var_2.Find(var_2_31, "frame/frame_1/attr/title/Text")

	i18n = var_2_31

	var_1(var_2_32, var_2_31("island_word_ship_rank"))

	setText = var_1

	local var_2_33 = arg_2_0.confirmBtn
	local var_2_34 = var_2.Find(var_2_33, "Text")

	i18n = var_2_33

	var_1(var_2_34, var_2_33("island_chara_up_button"))

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
	local var_3_7 = arg_3_0.confirmBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		if var_0.NothingSelected(var_6_0) then
			return
		end

		local var_6_1 = arg_3_0
		local var_6_2 = var_0.emit

		IslandMediator = var_2_10002

		var_6_2(var_6_1, var_2_10002.USE_SHIP_EXP_BOOK, arg_3_0.ship.id, arg_3_0.selected)

		local var_6_3 = arg_3_0

		var_0.Hide(var_6_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.delBtn

	local function var_3_11()
		arg_3_0.selected = {}

		local var_7_0 = arg_3_0

		var_0.UpdateConsume(var_7_0, arg_3_0.ship)

		local var_7_1 = arg_3_0

		var_0.UpdateLevelPreview(var_7_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10005)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.maxBtn

	local function var_3_14()
		local var_8_0 = arg_3_0

		var_0.FillSelected(var_8_0, arg_3_0.ship)

		local var_8_1 = arg_3_0

		var_0.UpdateLevelPreview(var_8_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_12, var_3_13, var_3_14, var_1_10005)

	arg_3_0.isShowAttrPanel = false
	onToggle = var_1

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.switchBtn

	local function var_3_17(arg_9_0)
		arg_3_0.isShowAttrPanel = arg_9_0

		if arg_9_0 then
			local var_9_0 = arg_3_0

			var_1.UpdateAttrs(var_9_0, arg_3_0.ship)

			local var_9_1 = arg_3_0

			var_1.UpdateBreakOutLevel(var_9_1, arg_3_0.ship)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_15, var_3_16, var_3_17, var_1_10005)

	return
end

function var_0_1.OnShow(arg_10_0, arg_10_1)
	arg_10_0.ship = arg_10_1
	arg_10_0.selected = {}

	arg_10_0:UpdateLevelAndExp(arg_10_1)
	arg_10_0:UpdateConsume(arg_10_1)
	arg_10_0:BlurPanel()

	return
end

function var_0_1.UpdateLevelAndExp(arg_11_0, arg_11_1, arg_11_2)
	setActive = var_1_10003

	var_1_10003(arg_11_0.expBarPre, false)

	local var_11_0 = arg_11_1:GetExp()
	local var_11_1 = arg_11_1:GetTargetExp()
	local var_11_2 = arg_11_1:GetLevel()
	local var_11_3

	if arg_11_1:IsMaxLevel() then
		setFillAmount = var_11_3

		var_11_3(arg_11_0.expBar, 1)

		var_11_3 = arg_11_0.expTxt
		var_11_3.text = ""
	else
		setFillAmount = var_11_3

		var_11_3(arg_11_0.expBar, var_11_0 / var_11_1)

		arg_11_0.expTxt.text = "<color=#39BFFF>" .. var_11_0 .. "</color>/" .. var_11_1
	end

	arg_11_0.levelTxt.text = var_11_2

	return
end

function var_0_1.UpdateConsume(arg_12_0, arg_12_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_12_0 = var_1_10002(var_1_10003)
	local var_12_1 = var_2.GetIsland(var_12_0)
	local var_12_2 = var_2.GetInventoryAgency(var_12_1)
	local var_12_3 = var_2.GetShipExpBooks(var_12_2)
	local var_12_4 = arg_12_0.uiItemList

	var_4.make(var_12_4, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventUpdate then
			local var_13_0 = var_12_3[arg_13_1 + 1]

			updateCustomDrop = var_4

			local var_13_1 = arg_13_2

			Drop = var_2_10006

			local var_13_2 = var_2_10006.New
			local var_13_3 = {}

			DROP_TYPE_ISLAND_ITEM = var_2_10008
			var_13_3.type = var_2_10008
			var_13_3.id = var_13_0.id
			var_13_3.count = var_13_0.count

			var_4(var_13_1, var_13_2(var_13_3))

			setActive = var_4

			var_4(arg_13_2:Find("icon_bg/count_bg"), true)

			setText = var_4

			var_4(arg_13_2:Find("icon_bg/count_bg/count"), "X" .. var_13_0.count)

			onButton = var_4

			local var_13_4 = arg_12_0
			local var_13_5 = arg_13_2

			local function var_13_6()
				if not (var_13_0.count <= 0) then
					local var_14_0 = arg_12_0

					if var_0.CheckMaxLevel(var_14_0) then
						return
					end

					local var_14_1 = arg_12_0

					var_0.OpenCalcPanel(var_14_1, arg_13_2, var_13_0)

					return
				end
			end

			SFX_PANEL = var_8

			var_4(var_13_4, var_13_5, var_13_6, var_8)

			local var_13_7 = arg_12_0

			var_4.UpdateCalcPanel(var_13_7, arg_13_2, var_13_0)
		end

		return
	end)

	local var_12_5 = arg_12_0.uiItemList

	var_4.align(var_12_5, #var_12_3)

	return
end

function var_0_1.OpenCalcPanel(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.selected
	local var_15_1 = arg_15_2.id

	math = var_1_10005

	local var_15_2 = var_1_10005.min
	local var_15_3 = arg_15_2.count
	local var_15_4

	if not arg_15_0.selected[arg_15_2.id] then
		var_15_4 = 0
	end

	var_15_0[var_15_1] = var_15_2(var_15_3, var_15_4 + 1)

	arg_15_0:UpdateCalcPanel(arg_15_1, arg_15_2)
	arg_15_0:UpdateLevelPreview()

	return
end

function var_0_1.CheckMaxLevel(arg_16_0)
	Clone = var_1_10001

	local var_16_0 = var_1_10001(arg_16_0.ship)
	local var_16_1 = arg_16_0:CalcExpAddition(arg_16_0.selected)

	var_16_0:AddExp(var_16_1)

	return var_16_0:IsMaxLevel()
end

function var_0_1.UpdateLevelPreview(arg_17_0)
	Clone = var_1_10001

	local var_17_0 = var_1_10001(arg_17_0.ship)
	local var_17_1 = arg_17_0:CalcExpAddition(arg_17_0.selected)

	var_17_0:AddExp(var_17_1)

	setActive = var_3

	var_3(arg_17_0.expBarPre, var_17_1 > 0)

	local var_17_2 = arg_17_0.ship
	local var_17_3 = var_3.GetLevel(var_17_2)

	if var_17_1 > 0 then
		local var_17_4 = var_17_0:GetExp()
		local var_17_5 = var_17_0:GetTargetExp()
		local var_17_6 = var_17_0:GetLevel()
		local var_17_7

		if var_17_0:IsMaxLevel() then
			setFillAmount = var_17_7

			var_17_7(arg_17_0.expBarPre, 1)

			var_17_7 = arg_17_0.expTxt
			var_17_7.text = ""
		else
			setFillAmount = var_17_7

			var_17_7(arg_17_0.expBarPre, var_17_4 / var_17_5)

			arg_17_0.expTxt.text = "<color=#39BFFF>" .. var_17_4 .. "</color>/" .. var_17_5
		end

		if var_17_3 < var_17_6 then
			local var_17_8 = arg_17_0.levelTxt

			var_17_8.text = var_17_6
			setFillAmount = var_17_8

			var_17_8(arg_17_0.expBar, 0)
		end
	else
		arg_17_0:UpdateLevelAndExp(arg_17_0.ship)
	end

	return
end

function var_0_1.UpdateCalcPanel(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0

	if not arg_18_0.selected[arg_18_2.id] then
		var_18_0 = 0
	end

	setText = var_4

	var_4(arg_18_1:Find("calc/Text"), var_18_0)

	setActive = var_4

	var_4(arg_18_1:Find("calc"), var_18_0 > 0)

	onButton = var_4

	local var_18_1 = arg_18_0
	local var_18_2 = arg_18_1:Find("calc/bg")

	local function var_18_3()
		local var_19_0 = arg_18_0.selected
		local var_19_1 = arg_18_2.id
		local var_19_2

		if not arg_18_0.selected[arg_18_2.id] then
			var_19_2 = 0
		end

		var_19_0[var_19_1] = var_19_2 - 1

		local var_19_3 = arg_18_0

		var_0.UpdateCalcPanel(var_19_3, arg_18_1, arg_18_2)

		local var_19_4 = arg_18_0

		var_0.UpdateLevelPreview(var_19_4)

		return
	end

	SFX_PANEL = var_8

	var_4(var_18_1, var_18_2, var_18_3, var_8)

	setGray = var_4

	var_4(arg_18_0.confirmBtn, arg_18_0:NothingSelected(), true)
	arg_18_0:UpdateAttrs(arg_18_0.ship)
	arg_18_0:UpdateBreakOutLevel(arg_18_0.ship)

	return
end

function var_0_1.NothingSelected(arg_20_0)
	pairs = var_1_10001

	for iter_20_0, iter_20_1 in var_1_10001(arg_20_0.selected) do
		if iter_20_1 > 0 then
			return false
		end
	end

	return true
end

function var_0_1.FillSelected(arg_21_0, arg_21_1)
	arg_21_0.selected = {}
	Clone = var_2

	local var_21_0 = var_2(arg_21_1)

	getProxy = var_3
	IslandProxy = var_1_10004

	local var_21_1 = var_3(var_1_10004)
	local var_21_2 = var_3.GetIsland(var_21_1)
	local var_21_3 = var_3.GetInventoryAgency(var_21_2)
	local var_21_4 = var_3.GetShipExpBooks(var_21_3)

	table = var_21_3

	var_21_3.sort(var_21_4, function(arg_22_0, arg_22_1)
		return arg_22_0:GetRarity() > arg_22_1:GetRarity()
	end)

	ipairs = var_5

	for iter_21_0, iter_21_1 in var_5(var_21_4) do
		for iter_21_2 = 1, iter_21_1.count do
			if var_21_0:IsMaxLevel() then
				break
			end

			tonumber = var_14

			local var_21_5 = var_14(iter_21_1:GetUseArg())

			var_21_0:AddExp(var_21_5)

			local var_21_6 = arg_21_0.selected
			local var_21_7 = iter_21_1.id
			local var_21_8

			if not arg_21_0.selected[iter_21_1.id] then
				var_21_8 = 0
			end

			var_21_6[var_21_7] = var_21_8 + 1
		end
	end

	arg_21_0:UpdateConsume(arg_21_0.ship)

	return
end

function var_0_1.CalcExpAddition(arg_23_0, arg_23_1)
	local var_23_0 = 0

	getProxy = var_1_10003
	IslandProxy = var_1_10004

	local var_23_1 = var_1_10003(var_1_10004)
	local var_23_2 = var_3.GetIsland(var_23_1)
	local var_23_3 = var_3.GetInventoryAgency(var_23_2)

	pairs = var_23_2

	for iter_23_0, iter_23_1 in var_23_2(arg_23_1) do
		for iter_23_2 = 1, iter_23_1 do
			local var_23_4 = var_23_3
			local var_23_5 = var_23_3.GetItemById(var_23_4, iter_23_0)

			tonumber = var_23_4
			var_23_0 = var_23_0 + var_23_4(var_23_5:GetUseArg())
		end
	end

	return var_23_0
end

function var_0_1.UpdateAttrs(arg_24_0, arg_24_1)
	if not arg_24_0.isShowAttrPanel then
		return
	end

	local var_24_0 = arg_24_1:GetGrowthAtt()
	local var_24_1 = arg_24_0.uiAttrList

	var_3.make(var_24_1, function(arg_25_0, arg_25_1, arg_25_2)
		UIItemList = var_2_10003

		if arg_25_0 == var_2_10003.EventUpdate then
			IslandShipAttr = var_3

			local var_25_0 = var_3.ATTRS[arg_25_1 + 1]
			local var_25_1 = arg_24_1
			local var_25_2 = var_4.GetAttrGrade(var_25_1, var_25_0)

			IslandShipAttr = var_25_1

			local var_25_3 = var_25_1.Grade2Img(var_25_2)
			local var_25_4 = arg_25_2:Find("grade_bg")
			local var_25_5 = var_6.GetComponent

			typeof = var_8
			Image = var_2_10009

			local var_25_6 = var_25_5(var_25_4, var_8(var_2_10009))

			GetSpriteFromAtlas = var_25_4
			var_25_6.sprite = var_25_4("ui/IslandShipUI_atlas", var_25_3[2])
			setText = var_25_6

			local var_25_7 = arg_25_2
			local var_25_8 = arg_25_2.Find(var_25_7, "name")

			IslandShipAttr = var_25_7

			var_25_6(var_25_8, var_25_7.ToChinese(var_25_0))

			setText = var_25_6

			local var_25_9 = arg_25_2:Find("value")
			local var_25_10 = "+"
			local var_25_11

			if not var_24_0[var_25_0] then
				var_25_11 = 0
			end

			var_25_6(var_25_9, var_25_10 .. var_25_11)
		end

		return
	end)

	local var_24_2 = arg_24_0.uiAttrList
	local var_24_3 = var_3.align

	IslandShipAttr = var_5

	var_24_3(var_24_2, #var_5.ATTRS)

	return
end

function var_0_1.UpdateBreakOutLevel(arg_26_0, arg_26_1)
	if not arg_26_0.isShowAttrPanel then
		return
	end

	local var_26_0 = arg_26_0.uiBreakList

	var_2.make(var_26_0, function(arg_27_0, arg_27_1, arg_27_2)
		UIItemList = var_2_10003

		if arg_27_0 == var_2_10003.EventUpdate then
			setActive = var_3

			var_3(arg_27_2:Find("Image"), true)
		end

		return
	end)

	local var_26_1 = arg_26_0.uiBreakList

	var_2.align(var_26_1, arg_26_1:GetBreakLevel())

	return
end

function var_0_1.OnHide(arg_28_0)
	arg_28_0:UnBlurPanel()

	arg_28_0.selected = {}

	return
end

return var_0_1

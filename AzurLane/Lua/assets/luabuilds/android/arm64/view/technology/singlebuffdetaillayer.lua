class = var_0_10000

local var_0_0 = "SingleBuffDetailLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "TechnologyTreeSingleBuffDetailUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)
	arg_3_0:addListener()
	arg_3_0:updateDetail()

	return
end

function var_0_1.willExit(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf)

	return
end

function var_0_1.initData(arg_5_0)
	arg_5_0.groupID = arg_5_0.contextData.groupID
	arg_5_0.maxLV = arg_5_0.contextData.maxLV
	arg_5_0.star = arg_5_0.contextData.star
	pg = var_1
	arg_5_0.classID = var_1.fleet_tech_ship_template[arg_5_0.groupID].class
	arg_5_0.shipID = arg_5_0.groupID * 10 + 1
	pg = var_1
	arg_5_0.rarity = var_1.ship_data_statistics[arg_5_0.shipID].rarity
	Ship = var_1
	arg_5_0.shipPaintName = var_1.getPaintingName(arg_5_0.shipID)
	pg = var_1
	arg_5_0.shipType = var_1.fleet_tech_ship_class[arg_5_0.classID].shiptype
	pg = var_1
	arg_5_0.classLevel = var_1.fleet_tech_ship_class[arg_5_0.classID].t_level

	local var_5_0 = {}

	ShipType = var_2

	local var_5_1 = var_2.QuZhu

	Color = var_3
	var_5_0[var_5_1] = var_3.New(0.25882352941176473, 0.9215686274509803, 1, 1)
	ShipType = var_5_1

	local var_5_2 = var_5_1.QingXun

	Color = var_3
	var_5_0[var_5_2] = var_3.New(1, 0.9137254901960784, 0.4470588235294118, 1)
	ShipType = var_5_2

	local var_5_3 = var_5_2.ZhongXun

	Color = var_3
	var_5_0[var_5_3] = var_3.New(1, 0.9137254901960784, 0.4470588235294118, 1)
	ShipType = var_5_3

	local var_5_4 = var_5_3.ChaoXun

	Color = var_3
	var_5_0[var_5_4] = var_3.New(1, 0.9137254901960784, 0.4470588235294118, 1)
	ShipType = var_5_4

	local var_5_5 = var_5_4.ZhanXun

	Color = var_3
	var_5_0[var_5_5] = var_3.New(0.9529411764705882, 0.396078431372549, 0.396078431372549, 1)
	ShipType = var_5_5

	local var_5_6 = var_5_5.ZhanLie

	Color = var_3
	var_5_0[var_5_6] = var_3.New(0.9529411764705882, 0.396078431372549, 0.396078431372549, 1)
	ShipType = var_5_6

	local var_5_7 = var_5_6.HangXun

	Color = var_3
	var_5_0[var_5_7] = var_3.New(0.9529411764705882, 0.396078431372549, 0.396078431372549, 1)
	ShipType = var_5_7

	local var_5_8 = var_5_7.HangZhan

	Color = var_3
	var_5_0[var_5_8] = var_3.New(0.9529411764705882, 0.396078431372549, 0.396078431372549, 1)
	ShipType = var_5_8

	local var_5_9 = var_5_8.LeiXun

	Color = var_3
	var_5_0[var_5_9] = var_3.New(0.9529411764705882, 0.396078431372549, 0.396078431372549, 1)
	ShipType = var_5_9

	local var_5_10 = var_5_9.ZhongPao

	Color = var_3
	var_5_0[var_5_10] = var_3.New(0.9529411764705882, 0.396078431372549, 0.396078431372549, 1)
	ShipType = var_5_10

	local var_5_11 = var_5_10.QingHang

	Color = var_3
	var_5_0[var_5_11] = var_3.New(0.8745098039215686, 0.6588235294117647, 1, 1)
	ShipType = var_5_11

	local var_5_12 = var_5_11.ZhengHang

	Color = var_3
	var_5_0[var_5_12] = var_3.New(0.8745098039215686, 0.6588235294117647, 1, 1)
	ShipType = var_5_12

	local var_5_13 = var_5_12.QianTing

	Color = var_3
	var_5_0[var_5_13] = var_3.New(0.7215686274509804, 1, 0.23529411764705882, 1)
	ShipType = var_5_13

	local var_5_14 = var_5_13.QianMu

	Color = var_3
	var_5_0[var_5_14] = var_3.New(0.7215686274509804, 1, 0.23529411764705882, 1)
	ShipType = var_5_14

	local var_5_15 = var_5_14.WeiXiu

	Color = var_3
	var_5_0[var_5_15] = var_3.New(0.7215686274509804, 1, 0.23529411764705882, 1)
	ShipType = var_5_15

	local var_5_16 = var_5_15.Yunshu

	Color = var_3
	var_5_0[var_5_16] = var_3.New(0.7215686274509804, 1, 0.23529411764705882, 1)
	ShipType = var_5_16

	local var_5_17 = var_5_16.FengFanS

	Color = var_3
	var_5_0[var_5_17] = var_3.New(0.7215686274509804, 1, 0.23529411764705882, 1)
	ShipType = var_5_17

	local var_5_18 = var_5_17.FengFanV

	Color = var_3
	var_5_0[var_5_18] = var_3.New(0.7215686274509804, 1, 0.23529411764705882, 1)
	ShipType = var_5_18

	local var_5_19 = var_5_18.FengFanM

	Color = var_3
	var_5_0[var_5_19] = var_3.New(0.7215686274509804, 1, 0.23529411764705882, 1)
	arg_5_0.typeToColor = var_5_0

	return
end

function var_0_1.findUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.backBtn = var_1.Find(var_6_0, "BG")

	local var_6_1 = arg_6_0._tf

	arg_6_0.detailPanel = var_1.Find(var_6_1, "DetailPanel")

	local var_6_2 = arg_6_0.detailPanel

	arg_6_0.baseImg = var_1.Find(var_6_2, "Info/BaseImg")

	local var_6_3 = arg_6_0.baseImg

	arg_6_0.modelImg = var_1.Find(var_6_3, "ModelImg")

	local var_6_4 = arg_6_0.modelImg
	local var_6_5 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_6_0.modelImgCom = var_6_5(var_6_4, var_4(var_1_10006))

	local var_6_6 = arg_6_0.detailPanel

	arg_6_0.top = var_1.Find(var_6_6, "Info/top")

	local var_6_7 = arg_6_0.top

	arg_6_0.levelImg = var_1.Find(var_6_7, "LevelImg")

	local var_6_8 = arg_6_0.top

	arg_6_0.typeTextImg = var_1.Find(var_6_8, "TypeTextImg")

	local var_6_9 = arg_6_0.top

	arg_6_0.nameText = var_1.Find(var_6_9, "Name/NameText")

	local var_6_10 = arg_6_0.detailPanel

	arg_6_0.buffItemTpl = var_1.Find(var_6_10, "Info/BuffItemTpl")

	local var_6_11 = arg_6_0.detailPanel

	arg_6_0.buffGetItem = var_1.Find(var_6_11, "Info/BuffGetItemTop")

	local var_6_12 = arg_6_0.buffGetItem

	arg_6_0.statusGetImg = var_1.Find(var_6_12, "StatusBG/StatusImg")

	local var_6_13 = arg_6_0.buffGetItem

	arg_6_0.pointNumGetText = var_1.Find(var_6_13, "Point/PointNumText")

	local var_6_14 = arg_6_0.detailPanel

	arg_6_0.buffGetItemContainer = var_1.Find(var_6_14, "Info/BuffGetItemContainer")

	local var_6_15 = arg_6_0.detailPanel

	arg_6_0.buffCompleteItem = var_1.Find(var_6_15, "Info/BuffCompleteItemTop")

	local var_6_16 = arg_6_0.buffCompleteItem

	arg_6_0.statusCompleteImg = var_1.Find(var_6_16, "StatusBG/StatusImg")

	local var_6_17 = arg_6_0.buffCompleteItem

	arg_6_0.pointNumCompleteText = var_1.Find(var_6_17, "Point/PointNumText")

	local var_6_18 = arg_6_0.detailPanel

	arg_6_0.buffCompleteItemContainer = var_1.Find(var_6_18, "Info/BuffCompleteItemContainer")

	local var_6_19 = arg_6_0.detailPanel

	arg_6_0.allStarStatusImg = var_1.Find(var_6_19, "Info/AllStarTop/StatusBG/StatusImg")

	local var_6_20 = arg_6_0.detailPanel

	arg_6_0.allStarPointText = var_1.Find(var_6_20, "Info/AllStarTop/Point/PointNumText")

	return
end

function var_0_1.onBackPressed(arg_7_0)
	triggerButton = var_1_10001

	var_1_10001(arg_7_0.backBtn)

	return
end

function var_0_1.addListener(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.backBtn

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.emit(var_9_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10006)

	return
end

function var_0_1.updateDetail(arg_10_0)
	local var_10_0 = arg_10_0.modelImgCom

	var_10_0.enabled = false
	LoadSpriteAsync = var_10_0

	var_10_0("shipmodels/" .. arg_10_0.shipPaintName, function(arg_11_0)
		if arg_11_0 then
			setImageSprite = var_2_10001

			var_2_10001(arg_10_0.modelImg, arg_11_0, true)

			rtf = var_2_10001

			local var_11_0 = var_2_10001(arg_10_0.modelImg)

			getSpritePivot = var_2_10002
			var_11_0.pivot = var_2_10002(arg_11_0)
			arg_10_0.modelImgCom.enabled = true
		end

		return
	end)

	setImageSprite = var_10_0

	local var_10_1 = arg_10_0.baseImg

	GetSpriteFromAtlas = var_4

	var_10_0(var_10_1, var_4("shipraritybaseicon", "base_" .. arg_10_0.rarity))

	setImageSprite = var_10_0

	local var_10_2 = arg_10_0.typeTextImg

	GetSpriteFromAtlas = var_4

	var_10_0(var_10_2, var_4("ShipType", "ch_title_" .. arg_10_0.shipType), true)

	setText = var_10_0

	local var_10_3 = arg_10_0.nameText

	ShipGroup = var_4

	var_10_0(var_10_3, var_4.getDefaultShipNameByGroupID(arg_10_0.groupID))

	ShipGroup = var_10_0

	if not var_10_0.IsMetaGroup(arg_10_0.groupID) then
		ShipGroup = var_1

		if var_1.IsMotGroup(arg_10_0.groupID) then
			setActive = var_1

			var_1(arg_10_0.levelImg, false)
		else
			setImageSprite = var_1

			local var_10_4 = arg_10_0.levelImg

			GetSpriteFromAtlas = var_4

			var_1(var_10_4, var_4("TecClassLevelIcon", "T" .. arg_10_0.classLevel), true)

			setActive = var_1

			var_1(arg_10_0.levelImg, true)
		end

		pg = var_1

		local var_10_5 = var_1.fleet_tech_ship_template[arg_10_0.groupID].pt_get

		pg = var_2

		local var_10_6 = var_2.fleet_tech_ship_template[arg_10_0.groupID].pt_level

		setText = var_3

		var_3(arg_10_0.pointNumGetText, "+" .. var_10_5)

		setText = var_3

		var_3(arg_10_0.pointNumCompleteText, "+" .. var_10_6)

		setText = var_3

		local var_10_7 = arg_10_0.allStarPointText
		local var_10_8 = "+"

		pg = var_7

		var_3(var_10_7, var_10_8 .. var_7.fleet_tech_ship_template[arg_10_0.groupID].pt_upgrage)

		local var_10_9 = arg_10_0.star

		pg = var_4

		if var_4.fleet_tech_ship_template[arg_10_0.groupID].max_star <= var_10_9 then
			setImageColor = var_10_9

			local var_10_10 = arg_10_0.allStarStatusImg

			Color = var_6

			var_10_9(var_10_10, var_6.New(1, 0.9137254901960784, 0.4470588235294118, 1))
		end

		local var_10_11 = arg_10_0.maxLV

		TechnologyConst = var_4

		if var_4.SHIP_LEVEL_FOR_BUFF <= var_10_11 then
			setImageColor = var_10_11

			local var_10_12 = arg_10_0.statusCompleteImg

			Color = var_6

			var_10_11(var_10_12, var_6.New(1, 0.9137254901960784, 0.4470588235294118, 1))
		end

		local var_10_13 = arg_10_0
		local var_10_14 = arg_10_0.getSpecialTypeList

		pg = var_6

		local var_10_15 = var_10_14(var_10_13, var_6.fleet_tech_ship_template[arg_10_0.groupID].add_get_shiptype)

		pg = var_4

		local var_10_16 = var_4.fleet_tech_ship_template[arg_10_0.groupID].add_get_attr

		pg = var_5

		local var_10_17 = var_5.fleet_tech_ship_template[arg_10_0.groupID].add_get_value

		UIItemList = var_6

		local var_10_18 = var_6.New(arg_10_0.buffGetItemContainer, arg_10_0.buffItemTpl)

		var_6.make(var_10_18, function(arg_12_0, arg_12_1, arg_12_2)
			UIItemList = var_2_10003

			if arg_12_0 == var_2_10003.EventUpdate then
				local var_12_0 = arg_12_2:Find("Symbol/Left")
				local var_12_1 = arg_12_2:Find("Symbol/Right")
				local var_12_2 = arg_12_2:Find("TypeText")
				local var_12_3 = arg_12_2:Find("AttrText")
				local var_12_4 = arg_12_2:Find("ValueText")
				local var_12_5 = var_10_15[arg_12_1 + 1]
				local var_12_6 = arg_10_0.typeToColor[var_12_5]

				setTextColor = var_10

				var_10(var_12_0, var_12_6)

				setTextColor = var_10

				var_10(var_12_1, var_12_6)

				setText = var_10

				local var_12_7 = var_12_2

				ShipType = var_13

				var_10(var_12_7, var_13.Type2Name(var_12_5))

				setTextColor = var_10

				var_10(var_12_2, var_12_6)

				setText = var_10

				local var_12_8 = var_12_3

				AttributeType = var_13

				local var_12_9 = var_13.Type2Name

				pg = var_15

				var_10(var_12_8, var_12_9(var_15.attribute_info_by_type[var_10_16].name))

				setText = var_10

				var_10(var_12_4, "+" .. var_10_17)

				setActive = var_10

				var_10(arg_12_2, true)
			end

			return
		end)
		var_6:align(#var_10_15)

		local var_10_19 = arg_10_0
		local var_10_20 = arg_10_0.getSpecialTypeList

		pg = var_10

		local var_10_21 = var_10_20(var_10_19, var_10.fleet_tech_ship_template[arg_10_0.groupID].add_level_shiptype)

		pg = var_8

		local var_10_22 = var_8.fleet_tech_ship_template[arg_10_0.groupID].add_level_attr

		pg = var_9

		local var_10_23 = var_9.fleet_tech_ship_template[arg_10_0.groupID].add_level_value

		UIItemList = var_10

		local var_10_24 = var_10.New(arg_10_0.buffCompleteItemContainer, arg_10_0.buffItemTpl)

		var_10.make(var_10_24, function(arg_13_0, arg_13_1, arg_13_2)
			UIItemList = var_2_10003

			if arg_13_0 == var_2_10003.EventUpdate then
				local var_13_0 = arg_13_2:Find("Symbol/Left")
				local var_13_1 = arg_13_2:Find("Symbol/Right")
				local var_13_2 = arg_13_2:Find("TypeText")
				local var_13_3 = arg_13_2:Find("AttrText")
				local var_13_4 = arg_13_2:Find("ValueText")
				local var_13_5 = arg_13_2:Find("BG")
				local var_13_6 = var_10_21[arg_13_1 + 1]
				local var_13_7
				local var_13_8 = arg_10_0.maxLV

				TechnologyConst = var_2_10012

				if var_13_8 >= var_2_10012.SHIP_LEVEL_FOR_BUFF then
					var_13_7 = arg_10_0.typeToColor[var_13_6]
					setGray = var_13_8

					var_13_8(var_13_5, false)
				else
					Color = var_13_8
					var_13_7 = var_13_8.New(0.6392156862745098, 0.6392156862745098, 0.6392156862745098, 1)
					setTextColor = var_13_8

					var_13_8(var_13_4, var_13_7)

					setTextColor = var_13_8

					var_13_8(var_13_3, var_13_7)

					setGray = var_13_8

					var_13_8(var_13_5, true)
				end

				setTextColor = var_13_8

				var_13_8(var_13_0, var_13_7)

				setTextColor = var_13_8

				var_13_8(var_13_1, var_13_7)

				setText = var_13_8

				local var_13_9 = var_13_2

				ShipType = var_14

				var_13_8(var_13_9, var_14.Type2Name(var_13_6))

				setTextColor = var_13_8

				var_13_8(var_13_2, var_13_7)

				setText = var_13_8

				local var_13_10 = var_13_3

				AttributeType = var_14

				local var_13_11 = var_14.Type2Name

				pg = var_16

				var_13_8(var_13_10, var_13_11(var_16.attribute_info_by_type[var_10_22].name))

				setText = var_13_8

				var_13_8(var_13_4, "+" .. var_10_23)

				setActive = var_13_8

				var_13_8(arg_13_2, true)
			end

			return
		end)
		var_10:align(#var_10_21)

		return
	end
end

function var_0_1.getSpecialTypeList(arg_14_0, arg_14_1)
	ShipType = var_1_10002

	local var_14_0 = var_1_10002.FilterOverQuZhuType(arg_14_1)

	ShipType = var_1_10003

	return (var_1_10003.FilterOverFengFanType(var_14_0))
end

return var_0_1

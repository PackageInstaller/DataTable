local SingleBuffDetailLayer = class("SingleBuffDetailLayer", import("..base.BaseUI"))

function SingleBuffDetailLayer:getUIName()
	return "TechnologyTreeSingleBuffDetailUI"
end

function SingleBuffDetailLayer:init()
	self:initData()
	self:findUI()

	return
end

function SingleBuffDetailLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:addListener()
	self:updateDetail()

	return
end

function SingleBuffDetailLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function SingleBuffDetailLayer:initData()
	self.groupID = self.contextData.groupID
	self.maxLV = self.contextData.maxLV
	self.star = self.contextData.star
	self.classID = pg.fleet_tech_ship_template[self.groupID].class
	self.shipID = self.groupID * 10 + 1
	self.rarity = pg.ship_data_statistics[self.shipID].rarity
	self.shipPaintName = Ship.getPaintingName(self.shipID)
	self.shipType = pg.fleet_tech_ship_class[self.classID].shiptype
	self.classLevel = pg.fleet_tech_ship_class[self.classID].t_level
	self.typeToColor = {
		[ShipType.QuZhu] = Color.New(0.25882352941176473, 0.9215686274509803, 1, 1),
		[ShipType.QingXun] = Color.New(1, 0.9137254901960784, 0.4470588235294118, 1),
		[ShipType.ZhongXun] = Color.New(1, 0.9137254901960784, 0.4470588235294118, 1),
		[ShipType.ChaoXun] = Color.New(1, 0.9137254901960784, 0.4470588235294118, 1),
		[ShipType.ZhanXun] = Color.New(0.9529411764705882, 0.396078431372549, 0.396078431372549, 1),
		[ShipType.ZhanLie] = Color.New(0.9529411764705882, 0.396078431372549, 0.396078431372549, 1),
		[ShipType.HangXun] = Color.New(0.9529411764705882, 0.396078431372549, 0.396078431372549, 1),
		[ShipType.HangZhan] = Color.New(0.9529411764705882, 0.396078431372549, 0.396078431372549, 1),
		[ShipType.LeiXun] = Color.New(0.9529411764705882, 0.396078431372549, 0.396078431372549, 1),
		[ShipType.ZhongPao] = Color.New(0.9529411764705882, 0.396078431372549, 0.396078431372549, 1),
		[ShipType.QingHang] = Color.New(0.8745098039215686, 0.6588235294117647, 1, 1),
		[ShipType.ZhengHang] = Color.New(0.8745098039215686, 0.6588235294117647, 1, 1),
		[ShipType.QianTing] = Color.New(0.7215686274509804, 1, 0.23529411764705882, 1),
		[ShipType.QianMu] = Color.New(0.7215686274509804, 1, 0.23529411764705882, 1),
		[ShipType.WeiXiu] = Color.New(0.7215686274509804, 1, 0.23529411764705882, 1),
		[ShipType.Yunshu] = Color.New(0.7215686274509804, 1, 0.23529411764705882, 1),
		[ShipType.FengFanS] = Color.New(0.7215686274509804, 1, 0.23529411764705882, 1),
		[ShipType.FengFanV] = Color.New(0.7215686274509804, 1, 0.23529411764705882, 1),
		[ShipType.FengFanM] = Color.New(0.7215686274509804, 1, 0.23529411764705882, 1)
	}

	return
end

function SingleBuffDetailLayer:findUI()
	self.backBtn = self._tf:Find("BG")
	self.detailPanel = self._tf:Find("DetailPanel")
	self.baseImg = self.detailPanel:Find("Info/BaseImg")
	self.modelImg = self.baseImg:Find("ModelImg")
	self.modelImgCom = self.modelImg:GetComponent(typeof(Image))
	self.top = self.detailPanel:Find("Info/top")
	self.levelImg = self.top:Find("LevelImg")
	self.typeTextImg = self.top:Find("TypeTextImg")
	self.nameText = self.top:Find("Name/NameText")
	self.buffItemTpl = self.detailPanel:Find("Info/BuffItemTpl")
	self.buffGetItem = self.detailPanel:Find("Info/BuffGetItemTop")
	self.statusGetImg = self.buffGetItem:Find("StatusBG/StatusImg")
	self.pointNumGetText = self.buffGetItem:Find("Point/PointNumText")
	self.buffGetItemContainer = self.detailPanel:Find("Info/BuffGetItemContainer")
	self.buffCompleteItem = self.detailPanel:Find("Info/BuffCompleteItemTop")
	self.statusCompleteImg = self.buffCompleteItem:Find("StatusBG/StatusImg")
	self.pointNumCompleteText = self.buffCompleteItem:Find("Point/PointNumText")
	self.buffCompleteItemContainer = self.detailPanel:Find("Info/BuffCompleteItemContainer")
	self.allStarStatusImg = self.detailPanel:Find("Info/AllStarTop/StatusBG/StatusImg")
	self.allStarPointText = self.detailPanel:Find("Info/AllStarTop/Point/PointNumText")

	return
end

function SingleBuffDetailLayer:onBackPressed()
	triggerButton(self.backBtn)

	return
end

function SingleBuffDetailLayer:addListener()
	onButton(self, self.backBtn, function()
		self:emit(SingleBuffDetailLayer.ON_CLOSE)

		return
	end, SFX_CANCEL)

	return
end

function SingleBuffDetailLayer:updateDetail()
	self.modelImgCom.enabled = false

	LoadSpriteAsync("shipmodels/" .. self.shipPaintName, function(arg_11_0)
		if arg_11_0 then
			setImageSprite(self.modelImg, arg_11_0, true)

			rtf(self.modelImg).pivot = getSpritePivot(arg_11_0)
			self.modelImgCom.enabled = true
		end

		return
	end)
	setImageSprite(self.baseImg, GetSpriteFromAtlas("shipraritybaseicon", "base_" .. self.rarity))
	setImageSprite(self.typeTextImg, GetSpriteFromAtlas("ShipType", "ch_title_" .. self.shipType), true)
	setText(self.nameText, ShipGroup.getDefaultShipNameByGroupID(self.groupID))

	if ShipGroup.IsMetaGroup(self.groupID) or ShipGroup.IsMotGroup(self.groupID) then
		setActive(self.levelImg, false)
	else
		setImageSprite(self.levelImg, GetSpriteFromAtlas("TecClassLevelIcon", "T" .. self.classLevel), true)
		setActive(self.levelImg, true)
	end

	setText(self.pointNumGetText, "+" .. pg.fleet_tech_ship_template[self.groupID].pt_get)
	setText(self.pointNumCompleteText, "+" .. pg.fleet_tech_ship_template[self.groupID].pt_level)
	setText(self.allStarPointText, "+" .. pg.fleet_tech_ship_template[self.groupID].pt_upgrage)

	if self.star >= pg.fleet_tech_ship_template[self.groupID].max_star then
		setImageColor(self.allStarStatusImg, Color.New(1, 0.9137254901960784, 0.4470588235294118, 1))
	end

	if self.maxLV >= TechnologyConst.SHIP_LEVEL_FOR_BUFF then
		setImageColor(self.statusCompleteImg, Color.New(1, 0.9137254901960784, 0.4470588235294118, 1))
	end

	local var_10_0 = self:getSpecialTypeList(pg.fleet_tech_ship_template[self.groupID].add_get_shiptype)
	local var_10_1 = pg.fleet_tech_ship_template[self.groupID].add_get_attr
	local var_10_2 = pg.fleet_tech_ship_template[self.groupID].add_get_value
	local var_10_3 = UIItemList.New(self.buffGetItemContainer, self.buffItemTpl)

	var_10_3:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			local var_12_0 = arg_12_2:Find("TypeText")

			setTextColor(arg_12_2:Find("Symbol/Left"), self.typeToColor[var_10_0[arg_12_1 + 1]])
			setTextColor(arg_12_2:Find("Symbol/Right"), self.typeToColor[var_10_0[arg_12_1 + 1]])
			setText(var_12_0, ShipType.Type2Name(var_10_0[arg_12_1 + 1]))
			setTextColor(var_12_0, self.typeToColor[var_10_0[arg_12_1 + 1]])
			setText(arg_12_2:Find("AttrText"), AttributeType.Type2Name(pg.attribute_info_by_type[var_10_1].name))
			setText(arg_12_2:Find("ValueText"), "+" .. var_10_2)
			setActive(arg_12_2, true)
		end

		return
	end)
	var_10_3:align(#var_10_0)

	local var_10_4 = self:getSpecialTypeList(pg.fleet_tech_ship_template[self.groupID].add_level_shiptype)
	local var_10_5 = pg.fleet_tech_ship_template[self.groupID].add_level_attr
	local var_10_6 = pg.fleet_tech_ship_template[self.groupID].add_level_value
	local var_10_7 = UIItemList.New(self.buffCompleteItemContainer, self.buffItemTpl)

	var_10_7:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			local var_13_0 = arg_13_2:Find("Symbol/Left")
			local var_13_1 = arg_13_2:Find("Symbol/Right")
			local var_13_2 = arg_13_2:Find("TypeText")
			local var_13_3 = arg_13_2:Find("AttrText")
			local var_13_4 = arg_13_2:Find("ValueText")
			local var_13_5 = arg_13_2:Find("BG")
			local var_13_6 = var_10_4[arg_13_1 + 1]
			local var_13_7

			if self.maxLV >= TechnologyConst.SHIP_LEVEL_FOR_BUFF then
				var_13_7 = self.typeToColor[var_13_6]

				setGray(var_13_5, false)
			else
				var_13_7 = Color.New(0.6392156862745098, 0.6392156862745098, 0.6392156862745098, 1)

				setTextColor(var_13_4, var_13_7)
				setTextColor(var_13_3, var_13_7)
				setGray(var_13_5, true)
			end

			setTextColor(var_13_0, var_13_7)
			setTextColor(var_13_1, var_13_7)
			setText(var_13_2, ShipType.Type2Name(var_13_6))
			setTextColor(var_13_2, var_13_7)
			setText(var_13_3, AttributeType.Type2Name(pg.attribute_info_by_type[var_10_5].name))
			setText(var_13_4, "+" .. var_10_6)
			setActive(arg_13_2, true)
		end

		return
	end)
	var_10_7:align(#var_10_4)

	return
end

function SingleBuffDetailLayer:getSpecialTypeList(arg_14_1)
	return (ShipType.FilterOverFengFanType((ShipType.FilterOverQuZhuType(arg_14_1))))
end

return SingleBuffDetailLayer

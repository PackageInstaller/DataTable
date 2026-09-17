local FilterHorcurxSelectSprite = class("FilterHorcurxSelectSprite", function()
	return cc.Layer:create()
end)
local TempWidget = require("view.Sprite.TempWidget")
local var_0_2 = require("controller.filter_config_manager").ConfigTable
local var_0_3 = config._DEBUG and 0 or 1
local var_0_4 = 1
local var_0_5 = 1
local var_0_6 = 5
local var_0_7 = 40
local var_0_8 = 40
local var_0_9 = 60
local var_0_10 = 240
local var_0_11 = {
	extraHeight = 140,
	maxBtnTotal = 100,
	panelWidth = 580,
	firstTitle = {
		height = 60,
		fontSzie = 26,
		bg = "public/filter/first_title_bg.png",
		size = 22,
		startPosX = 40,
		fontName = FONT_NAME,
		fontColor = cc.c3b(255, 255, 255),
		bgSize = cc.size(470, 30)
	},
	secondTitle = {
		height = 45,
		fontSzie = 24,
		size = 22,
		startPosX = 50,
		fontName = FONT_NAME,
		fontColor = cc.c3b(248, 243, 255),
		bgSize = cc.size(490, 25)
	},
	filterBtn = {
		height = 60,
		fontSzie = 20,
		selectedOffBg = "public/filter/filter_select_off_new_bg.png",
		startPosX = 40,
		bg = "public/filter/filter_select_new_bg.png",
		selectedBg = "public/filter/filter_selected_new_bg.png",
		width = 125,
		contentSize = cc.size(124, 62),
		fontColor = cc.c3b(255, 255, 255),
		fontName = FONT_NAME,
		selectedFontColor = cc.c3b(255, 255, 255)
	},
	sortBtnConfig = {
		sort_table = {
			0,
			1
		},
		sort_str = {
			[0] = L_DESCENDING,
			L_ASCENDING
		}
	},
	titleText = {
		"public/filter/filter_parts.png",
		"public/filter/filter_material.png",
		"public/filter/filter_furniture.png",
		"public/filter/filter_weapon.png",
		"public/filter/filter_horcrux.png",
		"public/filter/filter_parts.png",
		"public/filter/filter_weapon.png",
		"public/filter/filter_material.png",
		"public/filter/filter_weapon.png",
		"public/filter/filter_furniture.png",
		"public/filter/filter_medal.png",
		"public/filter/filter_major.png",
		"public/filter/filter_major.png",
		nil,
		nil,
		"public/filter/filter_major.png",
		"public/filter/filter_lab.png",
		"public/filter/filter_material.png",
		startPosX = 30,
		startPosY = 60
	},
	noneTitle = {
		startPosX = 25
	}
}
local var_0_12 = {
	{
		"HorcruxSelectLayer/attr_img_1.png",
		"HorcruxSelectLayer/attr_img_2.png",
		"HorcruxSelectLayer/attr_img_3.png",
		"HorcruxSelectLayer/attr_img_4.png",
		"HorcruxSelectLayer/attr_img_5.png",
		"HorcruxSelectLayer/attr_img_6.png",
		"HorcruxSelectLayer/attr_img_7.png",
		"HorcruxSelectLayer/attr_img_8.png",
		"HorcruxSelectLayer/attr_img_9.png",
		"HorcruxSelectLayer/attr_img_10.png"
	},
	{
		"public/currency/star1.png",
		"public/currency/star2.png",
		"public/currency/star3.png",
		"public/currency/star4.png",
		"public/currency/star5.png",
		"public/currency/star6.png",
		"public/currency/star7.png",
		"public/currency/star8.png",
		"public/currency/star9.png"
	},
	{
		"HorcruxSelectLayer/rarity2.png",
		"HorcruxSelectLayer/rarity3.png",
		"HorcruxSelectLayer/rarity4.png",
		"HorcruxSelectLayer/rarity5.png"
	},
	{
		[1] = "HorcruxSelectLayer/has_owner.png",
		[2] = "HorcruxSelectLayer/no_owner.png"
	}
}

function FilterHorcurxSelectSprite:ctor()
	self:registerScriptHandler(function(arg_3_0)
		if arg_3_0 == "enter" then
			self:onEnter()
		elseif arg_3_0 == "exit" then
			self:onExit()
		end
	end)
end

function FilterHorcurxSelectSprite:create(arg_4_1)
	local var_4_0 = FilterHorcurxSelectSprite.new()

	if var_4_0:init(arg_4_1) then
		return var_4_0
	end

	return nil
end

function FilterHorcurxSelectSprite:init(arg_5_1)
	self.data = arg_5_1 or {}
	self.filterType = self.data.filterType
	self.filterCallback = self.data.filterCallback
	self.initButtonConfig = self.data.initButtonConfig or {}
	self.sortOrderChangeCallback = self.data.sortOrderChangeCallback
	self.maskTouchCallback = self.data.maskTouchCallback
	self.bagType_partition = self.data.bagType_partition
	self.isDecomposeFilter = self.data.isDecomposeFilter or false

	if self.bagType_partition == 2 then
		self.filterType = 17
	elseif self.bagType_partition == 1 then
		self.filterType = 18
	end

	self.defaultSortType = self.data.defaultSortType or var_0_2[self.filterType].default_sort_type

	local var_5_0 = self.data.defaultSortOrder or var_0_2[self.filterType].default_sort_order

	self.defaultSortOrder = var_0_11.sortBtnConfig.sort_table[1] == var_5_0 and 1 or var_0_11.sortBtnConfig.sort_table[2] == var_5_0 and 2 or 1
	var_0_11.maxBtnTotal = math.floor(var_0_11.panelWidth / var_0_11.filterBtn.width)

	self:initData()
	self:initLayer()
	self:initListener()

	return true
end

function FilterHorcurxSelectSprite:initLayer()
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:setContentSize(GameDisplay.getUiScreenSize())
	var_6_0:align(cc.p(0.5, 0.5), var_6_0:size().w / 2, var_6_0:size().h / 2)

	self._root = var_6_0

	local var_6_1 = TempWidget:CreateTempLayout(var_6_0)

	var_6_1:setContentSize(var_6_0:size())
	var_6_1:_setBack()
	var_6_1:setBackGroundColor(cc.c3b(0, 0, 0))
	var_6_1:setBackGroundColorOpacity(100)

	local var_6_2 = TempWidget:CreateTempImg("HorcruxSelectLayer/filterBg.png", var_6_0)

	var_6_2:setScale9Enabled(true)
	var_6_2:_addEvent(function()
		return
	end)
	var_6_2:setCapInsets(cc.rect(10, 50, var_6_2:size().w - 10, 20))
	var_6_2:setContentSize(cc.size(var_6_2:size().w, self:getSortBgHeight() + 80))
	var_6_2:align(cc.p(0.5, 1), var_6_0:size().w / 2, var_6_0:size().h * 0.85)

	self._bg = var_6_2

	local var_6_3 = TempWidget:CreateTempLabel("筛选", FONT_NAME, 20, var_6_2)

	var_6_3:align(cc.p(0.5, 1), var_6_2:size().w / 2, var_6_2:size().h - 8)
	var_6_3:_setColor("aaaaaa")

	local var_6_4
	local var_6_5

	if self.isDecomposeFilter then
		var_6_4 = self:createAptitudeLayout()

		var_6_2:addChild(var_6_4)
		var_6_4:align(cc.p(0.5, 1), var_6_2:size().w / 2, var_6_2:size().h - 40)
	else
		var_6_5 = self:createSortLayout()

		var_6_2:addChild(var_6_5)
		var_6_5:align(cc.p(0.5, 1), var_6_2:size().w / 2, var_6_2:size().h - 40)
	end

	local var_6_6 = self:createFilterLayout()

	var_6_2:addChild(var_6_6)

	if self.isDecomposeFilter then
		var_6_6:align(cc.p(0.5, 1), var_6_2:size().w / 2, var_6_4:pos().y - var_6_4:size().h)
	else
		var_6_6:align(cc.p(0.5, 1), var_6_2:size().w / 2, var_6_5:pos().y - var_6_5:size().h)
	end

	if self.isDecomposeFilter then
		self:disPathCallback()
	end
end

function FilterHorcurxSelectSprite:initListener()
	self._root:_addEvent(function()
		local function var_9_0()
			self._root:runAction(cc.Sequence:create(cc.Spawn:create(cc.Sequence:create(cc.FadeTo:create(0.1, 20), cc.Blink:create(0.15, 1)), cc.ScaleTo:create(0.3, 1, 0.001)), cc.CallFunc:create(function()
				self:setVisible(false)
			end)))
		end

		if self.data.maskTouchCallback then
			self.data.maskTouchCallback(var_9_0)
		else
			var_9_0()
		end
	end)
end

function FilterHorcurxSelectSprite:onEnter()
	self:setScaleY(0.01)
	self:runAction(cc.ScaleTo:create(0.3, 1, 1))
end

function FilterHorcurxSelectSprite:onExit()
	return
end

function FilterHorcurxSelectSprite:playPopAni(arg_14_1)
	self:setVisible(true)
	self._root:setOpacity(255)
	self._root:setScaleY(0)
	self._root:runAction(cc.Sequence:create(cc.ScaleTo:create(0.15, 1), cc.CallFunc:create(function()
		if arg_14_1 then
			self:disPathCallback()
		end
	end)))
end

function FilterHorcurxSelectSprite:disPathCallback()
	local var_16_1, var_16_2 = self:getFactors()

	if self.filterCallback then
		self.filterCallback({
			bag_type = self.filterType,
			filterConfig = self:getFilterData(),
			sortType = self:getSortType(),
			dfac = var_16_1,
			hfac = var_16_2
		})
	end
end

function FilterHorcurxSelectSprite:setFilterBtnState(arg_17_1, arg_17_2)
	if next(arg_17_2) then
		self.btnState.filterType[arg_17_1] = arg_17_2
	end
end

function FilterHorcurxSelectSprite:setSortOrderState(arg_18_1, arg_18_2)
	if next(arg_18_2) then
		self.btnState.sortOrder[arg_18_1] = arg_18_2
	end
end

function FilterHorcurxSelectSprite:updateAllFilterBtn()
	local function var_19_0(arg_20_0)
		if type(arg_20_0) == "table" then
			for iter_20_0, iter_20_1 in pairs(arg_20_0) do
				var_19_0(iter_20_1)
			end
		elseif type(arg_20_0) == "userdata" then
			self:updateFilterBtn(arg_20_0)
		end
	end

	var_19_0(self.btnObj)
end

function FilterHorcurxSelectSprite:initData()
	self.btnState = {
		filterType = {},
		sortType = {},
		sortOrder = {}
	}
	self.btnObj = {
		filterType = {},
		sortType = {},
		sortOrder = {}
	}
	self.btnFilterKey = {
		filterType = {},
		sortType = {},
		sortOrder = {}
	}

	for iter_21_0 = 1, #var_0_2[self.filterType].filter_table do
		self.btnState.filterType[iter_21_0] = {}
		self.btnObj.filterType[iter_21_0] = {}
		self.btnFilterKey.filterType[iter_21_0] = {}
	end

	for iter_21_1 = 1, var_0_4 do
		self.btnState.sortType[iter_21_1] = {}
		self.btnObj.sortType[iter_21_1] = {}
		self.btnFilterKey.sortType[iter_21_1] = {}
	end

	for iter_21_2 = 1, var_0_5 do
		self.btnState.sortOrder[iter_21_2] = {}
		self.btnObj.sortOrder[iter_21_2] = {}
		self.btnFilterKey.sortOrder[iter_21_2] = {}
	end

	local var_21_0 = self.defaultSortType or var_0_2[self.filterType].default_sort_type

	if var_21_0 then
		self.btnState.sortType[var_0_4][var_21_0] = 1
	end

	local var_21_1 = self.defaultSortOrder or var_0_2[self.filterType].default_sort_order

	if var_21_1 then
		self.btnState.sortOrder[var_0_5][var_21_1] = 1
	end

	for iter_21_3, iter_21_4 in pairs(self.initButtonConfig) do
		if iter_21_4 then
			for iter_21_5, iter_21_6 in pairs(iter_21_4) do
				self.btnState.filterType[iter_21_3][iter_21_5] = iter_21_6
			end
		end
	end
end

function FilterHorcurxSelectSprite:updateFilterBtn(arg_22_1)
	if arg_22_1.buttonType == "sortType" or arg_22_1.buttonType == "sortOrder" then
		for iter_22_0, iter_22_1 in pairs(self.btnState[arg_22_1.buttonType][arg_22_1.col]) do
			if self.btnState[arg_22_1.buttonType][arg_22_1.col][iter_22_0] == 1 or self.btnState[arg_22_1.buttonType][arg_22_1.col][iter_22_0] == -2 then
				self.btnObj[arg_22_1.buttonType][arg_22_1.col][iter_22_0]:loadTexture(var_0_11.filterBtn.selectedBg, var_0_3)
				self.btnObj[arg_22_1.buttonType][arg_22_1.col][iter_22_0]:getChildByName("label"):setColor(var_0_11.filterBtn.selectedFontColor)
			elseif self.btnState[arg_22_1.buttonType][arg_22_1.col][iter_22_0] == 0 then
				self.btnObj[arg_22_1.buttonType][arg_22_1.col][iter_22_0]:loadTexture(var_0_11.filterBtn.bg, var_0_3)
				self.btnObj[arg_22_1.buttonType][arg_22_1.col][iter_22_0]:getChildByName("label"):setColor(var_0_11.filterBtn.fontColor)
			else
				self.btnObj[arg_22_1.buttonType][arg_22_1.col][iter_22_0]:loadTexture(var_0_11.filterBtn.selectedOffBg, var_0_3)
				self.btnObj[arg_22_1.buttonType][arg_22_1.col][iter_22_0]:getChildByName("label"):setColor(var_0_11.filterBtn.fontColor)
			end
		end
	elseif self.btnState[arg_22_1.buttonType][arg_22_1.col][arg_22_1.index] == 1 or self.btnState[arg_22_1.buttonType][arg_22_1.col][arg_22_1.index] == -2 then
		arg_22_1:loadTexture(var_0_11.filterBtn.selectedBg, var_0_3)
		arg_22_1:getChildByName("label"):setColor(var_0_11.filterBtn.selectedFontColor)
	elseif self.btnState[arg_22_1.buttonType][arg_22_1.col][arg_22_1.index] == 0 then
		arg_22_1:loadTexture(var_0_11.filterBtn.bg, var_0_3)
		arg_22_1:getChildByName("label"):setColor(var_0_11.filterBtn.fontColor)
	else
		arg_22_1:loadTexture(var_0_11.filterBtn.selectedOffBg, var_0_3)
		arg_22_1:getChildByName("label"):setColor(var_0_11.filterBtn.fontColor)
	end
end

function FilterHorcurxSelectSprite:getSortBgHeight()
	local var_23_1 = self:getFilterLayoutHeight()

	return self.isDecomposeFilter and var_23_1 + var_0_10 or self:getSortLayoutHeight() + var_23_1
end

function FilterHorcurxSelectSprite:getSortLayoutHeight()
	local var_24_0 = 1

	while var_0_2[self.filterType].sort_table[var_24_0] do
		var_24_0 = var_24_0 + 1
	end

	return 0 + var_0_7 + var_0_8 * 2 + (var_0_9 + var_0_9 * math.ceil(var_24_0 / var_0_6))
end

function FilterHorcurxSelectSprite:createAptitudeLayout()
	local var_25_0 = TempWidget:CreateTempLayout()

	var_25_0:setContentSize(cc.size(GameDisplay.width, var_0_10))

	local var_25_1 = TempWidget:CreateTempImg("HorcruxSelectLayer/template_bg.png", var_25_0)

	var_25_1:setScale9Enabled(true)
	var_25_1:setCapInsets(cc.rect(0, 0, var_25_1:size().w, var_25_1:size().h))
	var_25_1:setContentSize(cc.size(var_25_1:size().w, var_25_0:size().h))
	var_25_1:center()

	local var_25_2 = self:createTitleLayout("攻击资质")

	var_25_0:addChild(var_25_2)
	var_25_2:align(cc.p(0.5, 1), var_25_0:size().w / 2, var_25_0:size().h)

	local var_25_3 = {
		"public/rolebg/h_fac_grade_c.png",
		"public/rolebg/h_fac_grade_b_minus.png",
		"public/rolebg/h_fac_grade_b.png",
		"public/rolebg/h_fac_grade_b_plus.png",
		"public/rolebg/h_fac_grade_a_minus.png",
		"public/rolebg/h_fac_grade_a.png",
		"public/rolebg/h_fac_a_puls.png",
		"public/rolebg/h_fac_s.png",
		"public/rolebg/h_fac_s_plus.png"
	}

	local function var_25_4(arg_26_0)
		local var_26_0 = TempWidget:CreateTempLayout()

		var_26_0:setAnchorPoint(0.5, 1)
		var_26_0:setContentSize(cc.size(var_25_0:size().w, 80))

		for iter_26_0, iter_26_1 in ipairs(var_25_3) do
			local var_26_1 = ccui.ImageView:create(iter_26_1, var_0_3)

			var_26_1:setAnchorPoint(0, 0.5)
			var_26_1:setPosition(var_0_11.noneTitle.startPosX + 60 + (iter_26_0 - 1) * 57, 73 - var_0_11.secondTitle.height / 2)
			var_26_0:addChild(var_26_1)
		end

		local var_26_2 = ccui.Slider:create()

		var_26_2:setAnchorPoint(0.5, 0)
		var_26_2:setContentSize(cc.size(494, var_26_2:getContentSize().height))
		var_26_2:loadBarTexture("public/panelbg/slider_bar_bg.png", var_0_3)
		var_26_2:loadProgressBarTexture("public/panelbg/slider_progress_bar.png", var_0_3)
		var_26_2:loadSlidBallTextures("public/panelbg/slider_node_icon.png", "public/panelbg/slider_node_icon.png", "public/panelbg/slider_node_icon.png", var_0_3)
		var_26_2:addTouchEventListener(handler(self, self.onChcangeAptitude))
		var_26_2:setPercent(100)

		self["slider_" .. arg_26_0] = var_26_2

		var_26_0:addChild(var_26_2)
		var_26_2:setPosition(cc.p(var_26_0:size().w / 2, 10))

		return var_26_0
	end

	local var_25_5 = var_25_4(1)

	var_25_0:addChild(var_25_5)
	var_25_5:setPosition(cc.p(var_25_2:pos().x, var_25_2:pos().y - var_25_2:size().h))

	local var_25_6 = self:createTitleLayout("血量资质")

	var_25_0:addChild(var_25_6)
	var_25_6:align(cc.p(0.5, 1), var_25_2:pos().x, var_25_5:getPositionY() - var_25_5:getContentSize().height)

	local var_25_7 = var_25_4(2)

	var_25_0:addChild(var_25_7)
	var_25_7:setPosition(cc.p(var_25_6:pos().x, var_25_6:pos().y - var_25_6:size().h))

	return var_25_0
end

function FilterHorcurxSelectSprite:createSortLayout()
	local var_27_0 = self:getSortLayoutHeight()
	local var_27_1 = TempWidget:CreateTempLayout()

	var_27_1:setContentSize(cc.size(GameDisplay.width, var_27_0))

	local var_27_2 = TempWidget:CreateTempImg("HorcruxSelectLayer/template_bg.png", var_27_1)

	var_27_2:setScale9Enabled(true)
	var_27_2:setCapInsets(cc.rect(0, 0, var_27_2:size().w, var_27_2:size().h))
	var_27_2:setContentSize(cc.size(var_27_2:size().w, var_27_0))
	var_27_2:center()

	local var_27_3 = self:createTitleLayout("排序")

	var_27_1:addChild(var_27_3)
	var_27_3:align(cc.p(0.5, 1), var_27_1:size().w / 2, var_27_1:size().h)

	local var_27_4 = self:createHeadLayout("升降序")

	var_27_1:addChild(var_27_4)
	var_27_4:align(cc.p(0.5, 1), var_27_1:size().w / 2, var_27_3:pos().y - var_27_3:size().h)

	local var_27_5 = {}

	for iter_27_0, iter_27_1 in pairs(var_0_11.sortBtnConfig.sort_table) do
		var_27_5[#var_27_5 + 1] = iter_27_0
	end

	local var_27_6 = self:createTypeLayout(var_27_5, 3, var_0_5)

	var_27_1:addChild(var_27_6)
	var_27_6:align(cc.p(0.5, 1), var_27_1:size().w / 2, var_27_4:pos().y - var_27_4:size().h)

	local var_27_7 = self:createHeadLayout("排序类型")

	var_27_1:addChild(var_27_7)
	var_27_7:align(cc.p(0.5, 1), var_27_1:size().w / 2, var_27_6:pos().y - var_27_6:size().h)

	local var_27_8 = {}

	while var_0_2[self.filterType].sort_table[1] do
		var_27_8[#var_27_8 + 1] = 1
	end

	local var_27_10 = self:createTypeLayout(var_27_8, 2, var_0_4)

	var_27_1:addChild(var_27_10)
	var_27_10:align(cc.p(0.5, 1), var_27_1:size().w / 2, var_27_7:pos().y - var_27_7:size().h)

	return var_27_1
end

function FilterHorcurxSelectSprite:createFilterLayout()
	local var_28_0 = self:getFilterLayoutHeight()
	local var_28_1 = TempWidget:CreateTempLayout()

	var_28_1:setContentSize(cc.size(GameDisplay.width, var_28_0))

	local var_28_2 = TempWidget:CreateTempImg("HorcruxSelectLayer/template_bg.png", var_28_1)

	var_28_2:setScale9Enabled(true)
	var_28_2:setCapInsets(cc.rect(0, 0, var_28_2:size().w, var_28_2:size().h))
	var_28_2:setContentSize(cc.size(var_28_2:size().w, var_28_0))
	var_28_2:center()

	local var_28_3 = self:createTitleLayout("筛选")

	var_28_1:addChild(var_28_3)
	var_28_3:align(cc.p(0.5, 1), var_28_1:size().w / 2, var_28_1:size().h)

	local var_28_4 = var_28_3:pos().y - var_28_3:size().h

	for iter_28_0 = 1, #var_0_2[self.filterType].filter_table do
		local var_28_5 = self:createHeadLayout(var_0_2[self.filterType].filter_type_str[iter_28_0])

		var_28_1:addChild(var_28_5)
		var_28_5:align(cc.p(0.5, 1), var_28_1:size().w / 2, var_28_4)

		var_28_4 = var_28_4 - var_28_5:size().h

		local var_28_6 = {}

		for iter_28_1 = 1, #var_0_2[self.filterType].filter_table[iter_28_0] do
			var_28_6[#var_28_6 + 1] = iter_28_1
		end

		local var_28_7 = self:createTypeLayout(var_28_6, 1, iter_28_0)

		var_28_1:addChild(var_28_7)
		var_28_7:align(cc.p(0.5, 1), var_28_1:size().w / 2, var_28_4)

		var_28_4 = var_28_4 - var_28_7:size().h
	end

	return var_28_1
end

function FilterHorcurxSelectSprite:getFilterLayoutHeight()
	local var_29_0 = 0

	for iter_29_0 = 1, #var_0_2[self.filterType].filter_table do
		var_29_0 = var_29_0 + var_0_9 * math.ceil(#var_0_2[self.filterType].filter_table[iter_29_0] / var_0_6)
	end

	return 0 + var_0_7 + var_0_8 * #var_0_2[self.filterType].filter_table + var_29_0
end

function FilterHorcurxSelectSprite:createButton(arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = TempWidget:CreateTempImg(var_0_11.filterBtn.bg)
	local var_30_1
	local var_30_2 = 0

	if arg_30_2 == 1 then
		var_30_1 = cc.Label:createWithTTF(var_0_2[self.filterType].filter_str[arg_30_3][var_0_2[self.filterType].filter_table[arg_30_3][arg_30_1]], var_0_11.filterBtn.fontName, var_0_11.filterBtn.fontSzie)

		var_30_1:setVisible(false)

		self.btnObj.filterType[arg_30_3][arg_30_1] = var_30_0
		self.btnFilterKey.filterType[arg_30_3][arg_30_1] = var_0_2[self.filterType].filter_table[arg_30_3][arg_30_1]
		var_30_0.buttonType = "filterType"
		self.btnState.filterType[arg_30_3][arg_30_1] = self.btnState.filterType[arg_30_3][arg_30_1] or 0
		var_30_2 = self.btnState.filterType[arg_30_3][arg_30_1]

		TempWidget:CreateTempImg(var_0_12[arg_30_3][arg_30_1], var_30_0):center()
	elseif arg_30_2 == 2 then
		var_30_1 = cc.Label:createWithTTF(var_0_2[self.filterType].sort_str[var_0_2[self.filterType].sort_table[arg_30_1]], var_0_11.filterBtn.fontName, var_0_11.filterBtn.fontSzie)
		self.btnObj.sortType[arg_30_3][arg_30_1] = var_30_0
		self.btnFilterKey.sortType[arg_30_3][arg_30_1] = var_0_2[self.filterType].sort_table[arg_30_1]
		var_30_0.buttonType = "sortType"
		self.btnState.sortType[arg_30_3][arg_30_1] = self.btnState.sortType[arg_30_3][arg_30_1] or 0
		var_30_2 = self.btnState.sortType[arg_30_3][arg_30_1]
	else
		local var_30_3 = var_0_11.sortBtnConfig.sort_table[arg_30_1]

		var_30_1 = cc.Label:createWithTTF(var_0_11.sortBtnConfig.sort_str[var_0_11.sortBtnConfig.sort_table[arg_30_1]], var_0_11.filterBtn.fontName, var_0_11.filterBtn.fontSzie)
		self.btnObj.sortOrder[arg_30_3][arg_30_1] = var_30_0
		self.btnFilterKey.sortOrder[arg_30_3][arg_30_1] = var_30_3
		var_30_0.buttonType = "sortOrder"
		self.btnState.sortOrder[arg_30_3][arg_30_1] = self.btnState.sortOrder[arg_30_3][arg_30_1] or 0
		var_30_2 = self.btnState.sortOrder[arg_30_3][arg_30_1]
	end

	if var_30_2 == 1 or var_30_2 == -2 then
		var_30_0:loadTexture(var_0_11.filterBtn.selectedBg, var_0_3)
		var_30_1:setColor(var_0_11.filterBtn.selectedFontColor)
	elseif var_30_2 == -1 then
		var_30_0:loadTexture(var_0_11.filterBtn.selectedOffBg, var_0_3)
		var_30_1:setColor(var_0_11.filterBtn.fontColor)
	end

	var_30_0.col = arg_30_3
	var_30_0.index = arg_30_1

	var_30_1:setPositionX(var_30_0:getContentSize().width / 2)
	var_30_1:setPositionY(var_30_0:getContentSize().height / 2)
	var_30_1:setName("label")

	local var_30_4 = var_30_1:getContentSize().width
	local var_30_5 = var_30_0:getContentSize().width

	if var_30_4 > 100 then
		var_30_1:setScale(100 / var_30_4)
	else
		var_30_1:setScale(1)
	end

	var_30_0:addChild(var_30_1)
	var_30_0:setTouchEnabled(true)
	var_30_0:addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:BtnTouchEvent(arg_31_0)
	end)

	return var_30_0
end

function FilterHorcurxSelectSprite:BtnTouchEvent(arg_32_1)
	if arg_32_1.buttonType == "sortType" or arg_32_1.buttonType == "sortOrder" then
		if self.btnState[arg_32_1.buttonType][arg_32_1.col][arg_32_1.index] == 1 or self.btnState[arg_32_1.buttonType][arg_32_1.col][arg_32_1.index] == -1 or self.btnState[arg_32_1.buttonType][arg_32_1.col][arg_32_1.index] == -2 then
			return
		else
			for iter_32_0, iter_32_1 in pairs(self.btnState[arg_32_1.buttonType][arg_32_1.col]) do
				self.btnState[arg_32_1.buttonType][arg_32_1.col][iter_32_0] = 0
			end

			self.btnState[arg_32_1.buttonType][arg_32_1.col][arg_32_1.index] = 1
		end

		if arg_32_1.buttonType == "sortOrder" and self.btnState[arg_32_1.buttonType][arg_32_1.col][arg_32_1.index] == 1 then
			if self.sortOrderChangeCallback then
				self.sortOrderChangeCallback(var_0_11.sortBtnConfig.sort_table[arg_32_1.index])
			end

			self:updateFilterBtn(arg_32_1)

			return
		end
	else
		if self.btnState[arg_32_1.buttonType][arg_32_1.col][arg_32_1.index] == -2 then
			return
		end

		if self.btnState[arg_32_1.buttonType][arg_32_1.col][arg_32_1.index] == 1 then
			self.btnState[arg_32_1.buttonType][arg_32_1.col][arg_32_1.index] = 0
		elseif self.btnState[arg_32_1.buttonType][arg_32_1.col][arg_32_1.index] == 0 then
			self.btnState[arg_32_1.buttonType][arg_32_1.col][arg_32_1.index] = 1
		else
			return
		end
	end

	self:updateFilterBtn(arg_32_1)
	self:disPathCallback()
end

function FilterHorcurxSelectSprite:createTitleLayout(arg_33_1)
	local var_33_0 = TempWidget:CreateTempLayout()

	var_33_0:setContentSize(cc.size(GameDisplay.width, var_0_7))
	TempWidget:CreateTempImg("HorcruxSelectLayer/model_bg.png", var_33_0):move(var_33_0:size().w / 2, var_33_0:size().h / 2 - 8)
	TempWidget:CreateTempLabel(arg_33_1, FONT_NAME, 20, var_33_0):align(cc.p(0.5, 0.5), var_33_0:property().center)

	return var_33_0
end

function FilterHorcurxSelectSprite:createHeadLayout(arg_34_1)
	local var_34_0 = TempWidget:CreateTempLayout()

	var_34_0:setContentSize(cc.size(GameDisplay.width, var_0_8))

	local var_34_1 = TempWidget:CreateTempImg("HorcruxSelectLayer/head_img.png", var_34_0)

	var_34_1:align(cc.p(0, 0.5), 50, var_34_0:size().h / 2 + 15)
	TempWidget:CreateTempLabel(arg_34_1, FONT_NAME, 20, var_34_0):align(cc.p(0, 0.5), var_34_1:pos().x + var_34_1:size().w + 5, var_34_1:pos().y)

	return var_34_0
end

function FilterHorcurxSelectSprite:createTypeLayout(arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = TempWidget:CreateTempLayout()

	var_35_0:setContentSize(cc.size(GameDisplay.width, var_0_9 * math.ceil(#arg_35_1 / var_0_6)))

	local var_35_1 = var_35_0:size().h

	for iter_35_0 = 1, math.ceil(#arg_35_1 / var_0_6) do
		local var_35_2 = TempWidget:CreateTempLayout()

		var_35_2:setContentSize(cc.size(var_35_0:size().w, var_0_9))
		var_35_2:align(cc.p(0, 1), 0, var_35_1)
		var_35_0:addChild(var_35_2)

		for iter_35_1 = 1, var_0_6 do
			if not arg_35_1[iter_35_1 + (iter_35_0 - 1) * var_0_6] then
				break
			end

			local var_35_3 = self:createButton(arg_35_1[iter_35_1 + (iter_35_0 - 1) * var_0_6], arg_35_2, arg_35_3)

			var_35_2:addChild(var_35_3)
			var_35_3:align(cc.p(0, 0.5), 50 + (iter_35_1 - 1) * ((var_35_2:size().w - 50 * 2 - 10 * (var_0_6 - 1)) / var_0_6 + 10), var_35_2:size().h / 2 + 15)
		end

		var_35_1 = var_35_1 - var_35_2:size().h
	end

	return var_35_0
end

function FilterHorcurxSelectSprite:getFilterData()
	local var_36_0 = {}

	for iter_36_0, iter_36_1 in pairs(self.btnState.filterType) do
		var_36_0[var_0_2[self.filterType].filter_key[iter_36_0]] = {}

		for iter_36_2, iter_36_3 in pairs(iter_36_1) do
			if iter_36_3 == 1 or iter_36_3 == -2 then
				var_36_0[var_0_2[self.filterType].filter_key[iter_36_0]][#var_36_0[var_0_2[self.filterType].filter_key[iter_36_0]] + 1] = self.btnFilterKey.filterType[iter_36_0][iter_36_2]
			end
		end
	end

	return var_36_0
end

function FilterHorcurxSelectSprite:getSortType()
	for iter_37_0, iter_37_1 in pairs(self.btnState.sortType[var_0_4]) do
		if iter_37_1 == 1 then
			return iter_37_0
		end
	end
end

function FilterHorcurxSelectSprite:createSingleAptitude(arg_38_1)
	self.posX = var_0_11.noneTitle.startPosX

	local var_38_0 = self:createFirstTitle("none", arg_38_1 == 1 and "攻击资质" or "血量资质")

	var_38_0:setPositionX(self.posX)
	var_38_0:setPositionY(self.posY - var_0_11.secondTitle.height / 2)
	self.rootLayer:addChild(var_38_0, 2)

	self.posY = self.posY - var_0_11.secondTitle.height

	for iter_38_0, iter_38_1 in ipairs({
		"public/rolebg/h_fac_grade_c.png",
		"public/rolebg/h_fac_grade_b_minus.png",
		"public/rolebg/h_fac_grade_b.png",
		"public/rolebg/h_fac_grade_b_plus.png",
		"public/rolebg/h_fac_grade_a_minus.png",
		"public/rolebg/h_fac_grade_a.png",
		"public/rolebg/h_fac_a_puls.png",
		"public/rolebg/h_fac_s.png",
		"public/rolebg/h_fac_s_plus.png"
	}) do
		local var_38_1 = ccui.ImageView:create(iter_38_1, var_0_3)

		var_38_1:setAnchorPoint(0, 0.5)
		var_38_1:setPosition(self.posX + 15 + (iter_38_0 - 1) * 57, self.posY - var_0_11.secondTitle.height / 2)
		self.rootLayer:addChild(var_38_1, 2)
	end

	self.posY = self.posY - var_0_11.secondTitle.height

	local var_38_2 = ccui.Slider:create()

	var_38_2:setAnchorPoint(0, 0.5)
	var_38_2:setContentSize(cc.size(494, var_38_2:getContentSize().height))
	var_38_2:loadBarTexture("public/panelbg/slider_bar_bg.png", var_0_3)
	var_38_2:loadProgressBarTexture("public/panelbg/slider_progress_bar.png", var_0_3)
	var_38_2:loadSlidBallTextures("public/panelbg/slider_node_icon.png", "public/panelbg/slider_node_icon.png", "public/panelbg/slider_node_icon.png", var_0_3)
	var_38_2:addTouchEventListener(handler(self, self.onChcangeAptitude))
	var_38_2:setPositionX(self.posX + 15)
	var_38_2:setPositionY(self.posY - var_0_11.secondTitle.height / 2)
	var_38_2:setPercent(100)
	var_38_2:setName("slider_" .. arg_38_1)

	self.posY = self.posY - var_0_11.secondTitle.height

	self.rootLayer:addChild(var_38_2, 2)
end

function FilterHorcurxSelectSprite:onChcangeAptitude(arg_39_1, arg_39_2)
	if arg_39_2 == ccui.TouchEventType.ended then
		arg_39_1:setPercent(math.round(arg_39_1:getPercent() / 12.5) * 12.5)
		self:disPathCallback()
	end
end

function FilterHorcurxSelectSprite:getFactors()
	if not self.isDecomposeFilter then
		return
	end

	local var_40_0 = math.round(self.slider_1:getPercent() / 12.5) + 1
	local var_40_1 = math.round(self.slider_2:getPercent() / 12.5) + 1
	local var_40_2 = {}
	local var_40_3 = {}

	for iter_40_0, iter_40_1 in ipairs({
		0,
		0.1,
		0.2,
		0.3,
		0.4,
		0.5,
		0.65,
		0.75,
		0.95
	}) do
		if iter_40_0 <= var_40_0 then
			var_40_2[iter_40_0] = iter_40_1
		end

		if iter_40_0 <= var_40_1 then
			var_40_3[iter_40_0] = iter_40_1
		end
	end

	return var_40_2, var_40_3
end

return FilterHorcurxSelectSprite

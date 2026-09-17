FilterSprite = class("FilterSprite", function()
	return cc.Node:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local var_0_1 = 1
local var_0_2 = 1
local var_0_3 = {
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
		fontSzie = 24,
		selectedOffBg = "public/filter/filter_select_off_bg.png",
		startPosX = 40,
		bg = "public/filter/filter_select_bg.png",
		selectedBg = "public/filter/filter_selected_bg.png",
		width = 125,
		contentSize = cc.size(110, 50),
		fontColor = cc.c3b(255, 255, 255),
		fontName = FONT_NAME,
		selectedFontColor = cc.c3b(0, 0, 0)
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
local var_0_4 = require("controller.filter_config_manager").ConfigTable

function FilterSprite.create(arg_2_0, arg_2_1)
	local var_2_0 = FilterSprite.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function FilterSprite:init(arg_3_1)
	self.filterType = arg_3_1.filterType
	self.filterCallback = arg_3_1.filterCallback
	self.initButtonConfig = arg_3_1.initButtonConfig or {}
	self.sortOrderChangeCallback = arg_3_1.sortOrderChangeCallback
	self.maskTouchCallback = arg_3_1.maskTouchCallback
	self.bagType_partition = arg_3_1.bagType_partition
	self.isDecomposeFilter = arg_3_1.isDecomposeFilter or false

	if self.bagType_partition == 2 then
		self.filterType = 17
	elseif self.bagType_partition == 1 then
		self.filterType = 18
	end

	self.defaultSortType = arg_3_1.defaultSortType or var_0_4[self.filterType].default_sort_type

	local var_3_0 = arg_3_1.defaultSortOrder or var_0_4[self.filterType].default_sort_order

	self.defaultSortOrder = var_0_3.sortBtnConfig.sort_table[1] == var_3_0 and 1 or var_0_3.sortBtnConfig.sort_table[2] == var_3_0 and 2 or 1
	var_0_3.maxBtnTotal = math.floor(var_0_3.panelWidth / var_0_3.filterBtn.width)

	local var_3_1 = 0

	if self.isDecomposeFilter then
		self.rootLayer = ccui.ImageView:create("public/filter/filter_pop_bg_decompose.png", var_0_0)

		self.rootLayer:setScale9Enabled(true)
		self.rootLayer:setCapInsets(cc.rect(200, 10, 330, 720))
		self.rootLayer:setTouchEnabled(true)

		var_3_1 = self:getPanelHeight(self.filterType)

		self.rootLayer:setContentSize(cc.size(self.rootLayer:getContentSize().width, var_3_1))
	else
		self.rootLayer = ccui.ImageView:create("public/filter/filter_pop_bg.png", var_0_0)

		self.rootLayer:setScale9Enabled(true)
		self.rootLayer:setCapInsets(cc.rect(40, 40, 60, 60))
		self.rootLayer:setTouchEnabled(true)

		var_3_1 = self:getPanelHeight(self.filterType)

		self.rootLayer:setContentSize(cc.size(var_0_3.panelWidth, var_3_1))
	end

	self:addChild(self.rootLayer, 1)

	self.filterMask = ccui.Layout:create()

	self.filterMask:setTouchEnabled(true)
	self.filterMask:setContentSize(cc.Director:getInstance():getVisibleSize())
	self.filterMask:setAnchorPoint(cc.p(0.5, 0.5))
	self.filterMask:setPosition(cc.p(0, 0))
	self.filterMask:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.filterMask:setBackGroundColor(cc.c3b(2, 5, 18))
	self.filterMask:setBackGroundColorOpacity(160)
	self:addChild(self.filterMask)
	self.filterMask:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:hide()
	end)
	self:playPopAni()
	self:initData()

	self.posY = var_3_1 - 80

	if self.isDecomposeFilter then
		self.posY = self.posY - 20
	end

	if not self.isDecomposeFilter then
		self:createTitleImg()
		self:drawSortPanel()
	else
		self:createAptitudePanels()
	end

	self:drawFilterPanel()

	if self.isDecomposeFilter then
		self:disPathCallback()
	end
end

function FilterSprite:initData()
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

	for iter_5_0 = 1, #var_0_4[self.filterType].filter_table do
		self.btnState.filterType[iter_5_0] = {}
		self.btnObj.filterType[iter_5_0] = {}
		self.btnFilterKey.filterType[iter_5_0] = {}
	end

	for iter_5_1 = 1, var_0_1 do
		self.btnState.sortType[iter_5_1] = {}
		self.btnObj.sortType[iter_5_1] = {}
		self.btnFilterKey.sortType[iter_5_1] = {}
	end

	for iter_5_2 = 1, var_0_2 do
		self.btnState.sortOrder[iter_5_2] = {}
		self.btnObj.sortOrder[iter_5_2] = {}
		self.btnFilterKey.sortOrder[iter_5_2] = {}
	end

	local var_5_0 = self.defaultSortType or var_0_4[self.filterType].default_sort_type

	if var_5_0 then
		self.btnState.sortType[var_0_1][var_5_0] = 1
	end

	local var_5_1 = self.defaultSortOrder or var_0_4[self.filterType].default_sort_order

	if var_5_1 then
		self.btnState.sortOrder[var_0_2][var_5_1] = 1
	end

	for iter_5_3, iter_5_4 in pairs(self.initButtonConfig) do
		if iter_5_4 then
			for iter_5_5, iter_5_6 in pairs(iter_5_4) do
				self.btnState.filterType[iter_5_3][iter_5_5] = iter_5_6
			end
		end
	end
end

function FilterSprite:getFilterData()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(self.btnState.filterType) do
		var_6_0[var_0_4[self.filterType].filter_key[iter_6_0]] = {}

		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			if iter_6_3 == 1 or iter_6_3 == -2 then
				var_6_0[var_0_4[self.filterType].filter_key[iter_6_0]][#var_6_0[var_0_4[self.filterType].filter_key[iter_6_0]] + 1] = self.btnFilterKey.filterType[iter_6_0][iter_6_2]
			end
		end
	end

	return var_6_0
end

function FilterSprite:createAptitudePanels()
	self:createSingleAptitude(1)
	self:createSingleAptitude(2)
end

function FilterSprite:createSingleAptitude(arg_8_1)
	self.posX = var_0_3.noneTitle.startPosX

	local var_8_0 = self:createFirstTitle("none", arg_8_1 == 1 and "攻击资质" or "血量资质")

	var_8_0:setPositionX(self.posX)
	var_8_0:setPositionY(self.posY - var_0_3.secondTitle.height / 2)
	self.rootLayer:addChild(var_8_0, 2)

	self.posY = self.posY - var_0_3.secondTitle.height

	for iter_8_0, iter_8_1 in ipairs({
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
		local var_8_1 = ccui.ImageView:create(iter_8_1, var_0_0)

		var_8_1:setAnchorPoint(0, 0.5)
		var_8_1:setPosition(self.posX + 15 + (iter_8_0 - 1) * 57, self.posY - var_0_3.secondTitle.height / 2)
		self.rootLayer:addChild(var_8_1, 2)
	end

	self.posY = self.posY - var_0_3.secondTitle.height

	local var_8_2 = ccui.Slider:create()

	var_8_2:setAnchorPoint(0, 0.5)
	var_8_2:setContentSize(cc.size(494, var_8_2:getContentSize().height))
	var_8_2:loadBarTexture("public/panelbg/slider_bar_bg.png", var_0_0)
	var_8_2:loadProgressBarTexture("public/panelbg/slider_progress_bar.png", var_0_0)
	var_8_2:loadSlidBallTextures("public/panelbg/slider_node_icon.png", "public/panelbg/slider_node_icon.png", "public/panelbg/slider_node_icon.png", var_0_0)
	var_8_2:addTouchEventListener(handler(self, self.onChcangeAptitude))
	var_8_2:setPositionX(self.posX + 15)
	var_8_2:setPositionY(self.posY - var_0_3.secondTitle.height / 2)
	var_8_2:setPercent(100)
	var_8_2:setName("slider_" .. arg_8_1)

	self.posY = self.posY - var_0_3.secondTitle.height

	self.rootLayer:addChild(var_8_2, 2)
end

function FilterSprite:getFactors()
	if not self.isDecomposeFilter then
		return
	end

	local var_9_0 = math.round(self.rootLayer:getChildByName("slider_1"):getPercent() / 12.5) + 1
	local var_9_1 = math.round(self.rootLayer:getChildByName("slider_2"):getPercent() / 12.5) + 1
	local var_9_2 = {}
	local var_9_3 = {}

	for iter_9_0, iter_9_1 in ipairs({
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
		if iter_9_0 <= var_9_0 then
			var_9_2[iter_9_0] = iter_9_1
		end

		if iter_9_0 <= var_9_1 then
			var_9_3[iter_9_0] = iter_9_1
		end
	end

	return var_9_2, var_9_3
end

function FilterSprite:onChcangeAptitude(arg_10_1, arg_10_2)
	if arg_10_2 == ccui.TouchEventType.ended then
		arg_10_1:setPercent(math.round(arg_10_1:getPercent() / 12.5) * 12.5)
		self:disPathCallback()
	end
end

function FilterSprite:getPanelHeight(arg_11_1)
	local var_11_0 = var_0_4[arg_11_1]
	local var_11_1 = 0 + #var_0_4[arg_11_1].filter_type_str * var_0_3.secondTitle.height

	if not self.isDecomposeFilter then
		var_11_1 = var_11_1 + var_0_3.firstTitle.height * 2
		var_11_1 = var_11_1 + var_0_3.filterBtn.height
		var_11_1 = var_11_1 + var_0_3.secondTitle.height * 2
	else
		var_11_1 = var_11_1 + var_0_3.secondTitle.height * 6
	end

	local var_11_2 = 0

	for iter_11_0, iter_11_1 in pairs(var_11_0.filter_table) do
		var_11_2 = var_11_2 + math.ceil(#iter_11_1 / var_0_3.maxBtnTotal)
	end

	return var_11_1 + var_11_2 * var_0_3.filterBtn.height + math.ceil(#var_11_0.sort_str / var_0_3.maxBtnTotal) * var_0_3.filterBtn.height + var_0_3.extraHeight
end

function FilterSprite:drawSortPanel()
	self.posX = var_0_3.firstTitle.startPosX

	local var_12_0 = self:createFirstTitle("sort", L_SORT)

	var_12_0:setPositionX(self.posX)
	var_12_0:setPositionY(self.posY - var_0_3.firstTitle.height / 2)
	self.rootLayer:addChild(var_12_0, 2)

	self.posY = self.posY - var_0_3.firstTitle.height
	self.posX = var_0_3.secondTitle.startPosX

	local var_12_1 = self:createsecondTitle(L_ASCEN_OR_DESCEN)

	var_12_1:setPositionX(self.posX)
	var_12_1:setPositionY(self.posY - var_0_3.secondTitle.height / 2)
	self.rootLayer:addChild(var_12_1, 2)

	self.posY = self.posY - var_0_3.secondTitle.height
	self.posX = var_0_3.filterBtn.startPosX

	for iter_12_0, iter_12_1 in pairs(var_0_3.sortBtnConfig.sort_table) do
		if self.posX > var_0_3.panelWidth then
			self.posX = var_0_3.filterBtn.startPosX
			self.posY = self.posY - var_0_3.filterBtn.height
		end

		local var_12_2 = self:createButton(iter_12_0, 3, var_0_2)

		var_12_2:setPositionX(self.posX + var_0_3.filterBtn.width / 2)
		var_12_2:setPositionY(self.posY - var_0_3.filterBtn.height / 2)

		self.posX = self.posX + var_0_3.filterBtn.width

		self.rootLayer:addChild(var_12_2, 2)
	end

	self.posY = self.posY - var_0_3.filterBtn.height
	self.posX = var_0_3.secondTitle.startPosX

	local var_12_3 = self:createsecondTitle(L_SORT_TYPE)

	var_12_3:setPositionX(self.posX)
	var_12_3:setPositionY(self.posY - var_0_3.secondTitle.height / 2)
	self.rootLayer:addChild(var_12_3, 2)

	self.posY = self.posY - var_0_3.secondTitle.height
	self.posX = var_0_3.filterBtn.startPosX

	while var_0_4[self.filterType].sort_table[1] do
		if self.posX + var_0_3.filterBtn.width > var_0_3.panelWidth then
			self.posX = var_0_3.filterBtn.startPosX
			self.posY = self.posY - var_0_3.filterBtn.height
		end

		local var_12_4 = self:createButton(1, 2, var_0_1)

		var_12_4:setPositionX(self.posX + var_0_3.filterBtn.width / 2)
		var_12_4:setPositionY(self.posY - var_0_3.filterBtn.height / 2)

		self.posX = self.posX + var_0_3.filterBtn.width

		self.rootLayer:addChild(var_12_4, 2)
	end

	self.posY = self.posY - var_0_3.filterBtn.height
end

function FilterSprite:drawFilterPanel()
	local function var_13_0(arg_14_0)
		if not self.isDecomposeFilter then
			return arg_14_0
		else
			return var_0_3.noneTitle.startPosX
		end
	end

	self.posX = var_13_0(var_0_3.firstTitle.startPosX)

	local var_13_1 = self:createFirstTitle("filter", L_FILTER)

	var_13_1:setPositionX(self.posX)
	var_13_1:setPositionY(self.posY - var_0_3.firstTitle.height / 2)
	self.rootLayer:addChild(var_13_1, 2)

	self.posY = self.posY - var_0_3.firstTitle.height

	for iter_13_0 = 1, #var_0_4[self.filterType].filter_table do
		self.posX = var_13_0(var_0_3.secondTitle.startPosX)

		local var_13_2 = self:createsecondTitle(var_0_4[self.filterType].filter_type_str[iter_13_0])

		var_13_2:setPositionX(self.posX)
		var_13_2:setPositionY(self.posY - var_0_3.secondTitle.height / 2)
		self.rootLayer:addChild(var_13_2, 2)

		self.posY = self.posY - var_0_3.secondTitle.height
		self.posX = var_13_0(var_0_3.filterBtn.startPosX)

		for iter_13_1 = 1, #var_0_4[self.filterType].filter_table[iter_13_0] do
			if self.posX + var_0_3.filterBtn.width > var_0_3.panelWidth then
				self.posX = var_13_0(var_0_3.filterBtn.startPosX)
				self.posY = self.posY - var_0_3.filterBtn.height
			end

			local var_13_3 = self:createButton(iter_13_1, 1, iter_13_0)

			var_13_3:setPositionX(self.posX + var_0_3.filterBtn.width / 2)
			var_13_3:setPositionY(self.posY - var_0_3.filterBtn.height / 2)

			self.posX = self.posX + var_0_3.filterBtn.width

			self.rootLayer:addChild(var_13_3, 2)
		end

		self.posY = self.posY - var_0_3.filterBtn.height
	end
end

function FilterSprite:playPopAni(arg_15_1)
	self:setVisible(true)
	self.filterMask:setVisible(true)
	self.rootLayer:setOpacity(255)
	self.rootLayer:setScaleY(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.ScaleTo:create(0.15, 1), cc.CallFunc:create(function()
		if arg_15_1 then
			self:disPathCallback()
		end
	end)))
end

function FilterSprite:hide()
	local function var_17_0()
		self.rootLayer:runAction(cc.Sequence:create(cc.Spawn:create(cc.Sequence:create(cc.FadeTo:create(0.1, 20), cc.Blink:create(0.15, 1)), cc.ScaleTo:create(0.1, 1, 0.001)), cc.CallFunc:create(function()
			self.filterMask:setVisible(false)
			self:setVisible(false)
		end)))
	end

	if self.maskTouchCallback then
		self.maskTouchCallback(var_17_0)
	else
		var_17_0()
	end
end

function FilterSprite:createTitleImg()
	local var_20_0 = ccui.ImageView:create(var_0_3.titleText[self.filterType], var_0_0)

	var_20_0:setAnchorPoint(cc.p(0, 0.5))
	var_20_0:setPositionX(var_0_3.titleText.startPosX)
	var_20_0:setPositionY(self.rootLayer:getContentSize().height - var_0_3.titleText.startPosY)
	self.rootLayer:addChild(var_20_0)
end

function FilterSprite.createFirstTitle(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = ccui.ImageView:create(var_0_3.firstTitle.bg, var_0_0)

	var_21_0:setScale9Enabled(true)
	var_21_0:setCapInsets(cc.rect(6, 6, 2, 2))
	var_21_0:setContentSize(var_0_3.firstTitle.bgSize)
	var_21_0:setAnchorPoint(cc.p(0, 0.5))

	local var_21_2 = cc.Label:createWithTTF(arg_21_2, var_0_3.firstTitle.fontName, var_0_3.firstTitle.fontSzie)

	var_21_2:setAnchorPoint(cc.p(0, 0.5))
	var_21_2:setPositionX(1)
	var_21_2:setPositionY(var_21_0:getContentSize().height / 2)
	var_21_2:setColor(var_0_3.firstTitle.fontColor)
	var_21_0:addChild(var_21_2)

	return var_21_0
end

function FilterSprite.createsecondTitle(arg_22_0, arg_22_1)
	local var_22_0 = cc.Label:createWithTTF(arg_22_1, var_0_3.secondTitle.fontName, var_0_3.secondTitle.fontSzie)

	var_22_0:setAnchorPoint(cc.p(0, 0.5))
	var_22_0:setColor(var_0_3.secondTitle.fontColor)

	return var_22_0
end

function FilterSprite:createButton(arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = ccui.ImageView:create(var_0_3.filterBtn.bg, var_0_0)

	var_23_0:setScale9Enabled(true)
	var_23_0:setCapInsets(cc.rect(20, 20, 20, 20))
	var_23_0:setContentSize(var_0_3.filterBtn.contentSize)

	local var_23_1
	local var_23_2 = 0

	if arg_23_2 == 1 then
		var_23_1 = cc.Label:createWithTTF(var_0_4[self.filterType].filter_str[arg_23_3][var_0_4[self.filterType].filter_table[arg_23_3][arg_23_1]], var_0_3.filterBtn.fontName, var_0_3.filterBtn.fontSzie)
		self.btnObj.filterType[arg_23_3][arg_23_1] = var_23_0
		self.btnFilterKey.filterType[arg_23_3][arg_23_1] = var_0_4[self.filterType].filter_table[arg_23_3][arg_23_1]
		var_23_0.buttonType = "filterType"
		self.btnState.filterType[arg_23_3][arg_23_1] = self.btnState.filterType[arg_23_3][arg_23_1] or 0
		var_23_2 = self.btnState.filterType[arg_23_3][arg_23_1]
	elseif arg_23_2 == 2 then
		var_23_1 = cc.Label:createWithTTF(var_0_4[self.filterType].sort_str[var_0_4[self.filterType].sort_table[arg_23_1]], var_0_3.filterBtn.fontName, var_0_3.filterBtn.fontSzie)
		self.btnObj.sortType[arg_23_3][arg_23_1] = var_23_0
		self.btnFilterKey.sortType[arg_23_3][arg_23_1] = var_0_4[self.filterType].sort_table[arg_23_1]
		var_23_0.buttonType = "sortType"
		self.btnState.sortType[arg_23_3][arg_23_1] = self.btnState.sortType[arg_23_3][arg_23_1] or 0
		var_23_2 = self.btnState.sortType[arg_23_3][arg_23_1]
	else
		local var_23_3 = var_0_3.sortBtnConfig.sort_table[arg_23_1]

		var_23_1 = cc.Label:createWithTTF(var_0_3.sortBtnConfig.sort_str[var_0_3.sortBtnConfig.sort_table[arg_23_1]], var_0_3.filterBtn.fontName, var_0_3.filterBtn.fontSzie)
		self.btnObj.sortOrder[arg_23_3][arg_23_1] = var_23_0
		self.btnFilterKey.sortOrder[arg_23_3][arg_23_1] = var_23_3
		var_23_0.buttonType = "sortOrder"
		self.btnState.sortOrder[arg_23_3][arg_23_1] = self.btnState.sortOrder[arg_23_3][arg_23_1] or 0
		var_23_2 = self.btnState.sortOrder[arg_23_3][arg_23_1]
	end

	if var_23_2 == 1 or var_23_2 == -2 then
		var_23_0:loadTexture(var_0_3.filterBtn.selectedBg, var_0_0)
		var_23_1:setColor(var_0_3.filterBtn.selectedFontColor)
	elseif var_23_2 == -1 then
		var_23_0:loadTexture(var_0_3.filterBtn.selectedOffBg, var_0_0)
		var_23_1:setColor(var_0_3.filterBtn.fontColor)
	end

	var_23_0.col = arg_23_3
	var_23_0.index = arg_23_1

	var_23_1:setPositionX(var_23_0:getContentSize().width / 2)
	var_23_1:setPositionY(var_23_0:getContentSize().height / 2 + 5)
	var_23_1:setName("label")

	local var_23_4 = var_23_1:getContentSize().width
	local var_23_5 = var_23_0:getContentSize().width

	if var_23_5 < var_23_4 then
		var_23_1:setScale(var_23_5 / var_23_4)
	else
		var_23_1:setScale(1)
	end

	var_23_0:addChild(var_23_1)
	var_23_0:setTouchEnabled(true)
	var_23_0:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:BtnTouchEvent(arg_24_0)
	end)

	return var_23_0
end

function FilterSprite:BtnTouchEvent(arg_25_1)
	if arg_25_1.buttonType == "sortType" or arg_25_1.buttonType == "sortOrder" then
		if self.btnState[arg_25_1.buttonType][arg_25_1.col][arg_25_1.index] == 1 or self.btnState[arg_25_1.buttonType][arg_25_1.col][arg_25_1.index] == -1 or self.btnState[arg_25_1.buttonType][arg_25_1.col][arg_25_1.index] == -2 then
			return
		else
			for iter_25_0, iter_25_1 in pairs(self.btnState[arg_25_1.buttonType][arg_25_1.col]) do
				self.btnState[arg_25_1.buttonType][arg_25_1.col][iter_25_0] = 0
			end

			self.btnState[arg_25_1.buttonType][arg_25_1.col][arg_25_1.index] = 1
		end

		if arg_25_1.buttonType == "sortOrder" and self.btnState[arg_25_1.buttonType][arg_25_1.col][arg_25_1.index] == 1 then
			if self.sortOrderChangeCallback then
				self.sortOrderChangeCallback(var_0_3.sortBtnConfig.sort_table[arg_25_1.index])
			end

			self:updateFilterBtn(arg_25_1)

			return
		end
	else
		if self.btnState[arg_25_1.buttonType][arg_25_1.col][arg_25_1.index] == -2 then
			return
		end

		if self.btnState[arg_25_1.buttonType][arg_25_1.col][arg_25_1.index] == 1 then
			self.btnState[arg_25_1.buttonType][arg_25_1.col][arg_25_1.index] = 0
		elseif self.btnState[arg_25_1.buttonType][arg_25_1.col][arg_25_1.index] == 0 then
			self.btnState[arg_25_1.buttonType][arg_25_1.col][arg_25_1.index] = 1
		else
			return
		end
	end

	self:updateFilterBtn(arg_25_1)
	self:disPathCallback()
end

function FilterSprite:updateFilterBtn(arg_26_1)
	if arg_26_1.buttonType == "sortType" or arg_26_1.buttonType == "sortOrder" then
		for iter_26_0, iter_26_1 in pairs(self.btnState[arg_26_1.buttonType][arg_26_1.col]) do
			if self.btnState[arg_26_1.buttonType][arg_26_1.col][iter_26_0] == 1 or self.btnState[arg_26_1.buttonType][arg_26_1.col][iter_26_0] == -2 then
				self.btnObj[arg_26_1.buttonType][arg_26_1.col][iter_26_0]:loadTexture(var_0_3.filterBtn.selectedBg, var_0_0)
				self.btnObj[arg_26_1.buttonType][arg_26_1.col][iter_26_0]:getChildByName("label"):setColor(var_0_3.filterBtn.selectedFontColor)
			elseif self.btnState[arg_26_1.buttonType][arg_26_1.col][iter_26_0] == 0 then
				self.btnObj[arg_26_1.buttonType][arg_26_1.col][iter_26_0]:loadTexture(var_0_3.filterBtn.bg, var_0_0)
				self.btnObj[arg_26_1.buttonType][arg_26_1.col][iter_26_0]:getChildByName("label"):setColor(var_0_3.filterBtn.fontColor)
			else
				self.btnObj[arg_26_1.buttonType][arg_26_1.col][iter_26_0]:loadTexture(var_0_3.filterBtn.selectedOffBg, var_0_0)
				self.btnObj[arg_26_1.buttonType][arg_26_1.col][iter_26_0]:getChildByName("label"):setColor(var_0_3.filterBtn.fontColor)
			end
		end
	elseif self.btnState[arg_26_1.buttonType][arg_26_1.col][arg_26_1.index] == 1 or self.btnState[arg_26_1.buttonType][arg_26_1.col][arg_26_1.index] == -2 then
		arg_26_1:loadTexture(var_0_3.filterBtn.selectedBg, var_0_0)
		arg_26_1:getChildByName("label"):setColor(var_0_3.filterBtn.selectedFontColor)
	elseif self.btnState[arg_26_1.buttonType][arg_26_1.col][arg_26_1.index] == 0 then
		arg_26_1:loadTexture(var_0_3.filterBtn.bg, var_0_0)
		arg_26_1:getChildByName("label"):setColor(var_0_3.filterBtn.fontColor)
	else
		arg_26_1:loadTexture(var_0_3.filterBtn.selectedOffBg, var_0_0)
		arg_26_1:getChildByName("label"):setColor(var_0_3.filterBtn.fontColor)
	end
end

function FilterSprite:setFilterBtnState(arg_27_1, arg_27_2)
	if next(arg_27_2) then
		self.btnState.filterType[arg_27_1] = arg_27_2
	end
end

function FilterSprite:setSortTypestate(arg_28_1, arg_28_2)
	if next(arg_28_2) then
		self.btnState.sortType[arg_28_1] = arg_28_2
	end
end

function FilterSprite:setSortOrderState(arg_29_1, arg_29_2)
	if next(arg_29_2) then
		self.btnState.sortOrder[arg_29_1] = arg_29_2
	end
end

function FilterSprite:updateAllFilterBtn()
	local function var_30_0(arg_31_0)
		if type(arg_31_0) == "table" then
			for iter_31_0, iter_31_1 in pairs(arg_31_0) do
				var_30_0(iter_31_1)
			end
		elseif type(arg_31_0) == "userdata" then
			self:updateFilterBtn(arg_31_0)
		end
	end

	var_30_0(self.btnObj)
end

function FilterSprite:getSortType()
	for iter_32_0, iter_32_1 in pairs(self.btnState.sortType[var_0_1]) do
		if iter_32_1 == 1 then
			return iter_32_0
		end
	end
end

function FilterSprite:disPathCallback()
	local var_33_1, var_33_2 = self:getFactors()

	if self.filterCallback then
		self.filterCallback({
			bag_type = self.filterType,
			filterConfig = self:getFilterData(),
			sortType = self:getSortType(),
			dfac = var_33_1,
			hfac = var_33_2
		})
	end
end

function FilterSprite:moveToTop(arg_34_1)
	local var_34_0 = (GameDisplay.size.height - self.rootLayer:getContentSize().height) / 2

	arg_34_1 = arg_34_1 or 80

	self:setPosition(GameDisplay.width / 2, GameDisplay.height / 2 + var_34_0 - arg_34_1)
	self.filterMask:setPositionY(arg_34_1 - var_34_0)
end

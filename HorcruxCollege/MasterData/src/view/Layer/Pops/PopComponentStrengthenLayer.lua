PopComponentStrengthenLayer = class("PopComponentStrengthenLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local playermodel = require("model.playermodel")
local l2utils = require("controller.l2utils")
local TempWidget = require("view.Sprite.TempWidget")
local total_skill_data = require("data.total_skill_data")
local skill_data = require("data.skill_data")
local buff_data = require("data.buff_data")
local status_data = require("data.status_data")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local component_strengthen_weight_data = require("data.component_strengthen_weight_data")
local item_data = require("data.item_data")
local core_manager = require("controller.core_manager")
local component_manager = require("controller.component_manager")
local filter_config_manager = require("controller.filter_config_manager")
local bag_manager = require("controller.bag_manager")
local Utility = require("common.Utility")
local LocalEvent = require("common.LocalEvent")
local var_0_18 = 0
local var_0_19 = 1

function PopComponentStrengthenLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopComponentStrengthenLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopComponentStrengthenLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "pop_component_strengthen_layer.json" or "pop_component_strengthen_layer.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg")

	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2)
	self.rootLayer:setTouchEnabled(false)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)
	self.showActions.extendVertical(self)
	self:initData(arg_3_1)
	self:updateData()
	self:initUI()
	self:updateUI()

	self.isStrengthen = 0

	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" and arg_3_1.callback then
			arg_3_1.callback(self.isStrengthen)
		end
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", handler(self, self.handlePurchaseSuccess)), self)
end

function PopComponentStrengthenLayer:initData(arg_7_1)
	self.entityid = arg_7_1.entityid
	self.itemid = playermodel.items[self.entityid].itemid
	self.is_show_attribute = false
	self.curSelectComponent = {}
	self.bagManager = bag_manager.create()
	self.filterTbl = filter_config_manager:getDefaultFilterData(filter_config_manager.COMPONENT_STRENGTHEN)

	if not self.filterTbl.filterConfig.use then
		self.filterTbl.filterConfig.use = {}

		table.insert(self.filterTbl.filterConfig.use, false)

		self.filterTbl.filterConfig.lock = {}

		table.insert(self.filterTbl.filterConfig.lock, false)
	end

	self.type = arg_7_1.type or "strength"
	self.filterTbl.outSide = {
		self.entityid
	}
	self.filterAniFlag1 = true
	self.curSortOrders = var_0_18
	self.sortType = 1
	self.filterTbl.sortType = self.sortType
	self.quality = item_data[self.itemid].equip_quality
end

function PopComponentStrengthenLayer:updateData()
	self.filterTbl.sortOrder = self.curSortOrders
	self.componentList = self.bagManager:getBagData(self.filterTbl)

	if playermodel.items[5100002] then
		table.insert(self.componentList, 1, 5100002)
	end

	local var_8_0 = component_manager:getComponentMaterialExp(self.curSelectComponent)

	if self.type == "adjust" then
		self.expectedAddExtra = 0
		self.expectedExp = var_8_0
		self.costgold = component_manager:getAdjustNeedGold(self.entityid)
	elseif self.type == "strength" then
		self.expectedAddExtra, self.expectedExp, self.costgold = component_manager:getStrengthenExpected(self.entityid, var_8_0)
	end

	self.curExtra = playermodel.items[self.entityid].component_attr.extra
end

function PopComponentStrengthenLayer:initUI()
	self.panelComponent = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_component")
	self.curComponentSp = ItemSprite:createBigWithEntityId(self.entityid)

	self.curComponentSp:setPositionX(self.panelComponent:getContentSize().width / 2)
	self.curComponentSp:setPositionY(self.panelComponent:getContentSize().height / 2)
	self.panelComponent:addChild(self.curComponentSp)

	self.btnSure = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure")
	self.labelSure = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_sure")

	self.btnSure:addTouchEventListener(self:getStrengthenHandel())
	self.btnSure:setLocalZOrder(100)

	self.btnAutoSelect = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_auotselect")

	self.btnAutoSelect:addTouchEventListener(self:getAutoSelectHanel())

	self.imgCost = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_gold")
	self.labelCost = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_costgold")
	self.progressBg = ccui.Helper:seekWidgetByName(self.rootLayer, "ProgressBar_bg")
	self.progressCur = ccui.Helper:seekWidgetByName(self.rootLayer, "ProgressBar_cur")
	self.progressNext = ccui.Helper:seekWidgetByName(self.rootLayer, "ProgressBar_expected")
	self.labelCurAttr = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_cur_attr_num")
	self.labelNextAttr = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_expected_attr_num")
	self.imgMaxLevel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_maxlevel")
	self.labelCurLevel = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_lv_cur")
	self.labelNextLevel = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_lv_expected")
	self.labelExp = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_exp")
	self.imgBg = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg")

	self.imgBg:setTouchEnabled(true)

	self.imgAttr = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_attr")
	self.imgFilter = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_filter")
	self.labelAttr = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_attr1")

	if playermodel.items[self.entityid].component_attr.attr2 then
		self.label1 = cc.Label:createWithTTF("", FONT_DES, 24)

		self.label1:setAnchorPoint(0, 0.5)
		self.labelAttr:getParent():addChild(self.label1)
		self.label1:setColor(self.labelAttr:getColor())

		self.label2 = cc.Label:createWithTTF("", FONT_DES, 24)

		self.label2:setAnchorPoint(0, 0.5)
		self.labelAttr:getParent():addChild(self.label2)
		self.label2:setColor(self.labelCurAttr:getColor())

		self.labelNextAttr2 = cc.Label:createWithTTF("", FONT_DES, 24)

		self.labelNextAttr2:setAnchorPoint(0, 0.5)
		self.labelAttr:getParent():addChild(self.labelNextAttr2)
		self.labelNextAttr2:setColor(self.labelNextAttr:getColor())
	end

	self.labelCurAttrPosY = self.labelCurAttr:getPositionY()

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_autoselect"):setString(L_AOTU_CHOOSE)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_24"):setVisible(false)

	self.filterBtn1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_quick_filter1")
	self.filterBtn2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_quick_filter2")
	self.filterBtn3 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_quick_filter3")
	self.filterBtn4 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_quick_filter4")

	self.filterBtn1:getChildByName("Label_des"):setString(L_COMPONENT_TEXT.Sort_Order[1])
	self.filterBtn2:getChildByName("Label_des"):setString(L_COMPONENT_TEXT.Sort_Order[2])
	self.filterBtn3:getChildByName("Label_des"):setString(L_COMPONENT_TEXT.Sort_Order[3])
	self.filterBtn4:getChildByName("Label_des"):setString(L_COMPONENT_TEXT.Sort_Order[4])
	self:createTableview()
	self.imgAttr:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.is_show_attribute = not self.is_show_attribute

		self:updateShowingCells()

		if self.is_show_attribute then
			self.imgAttr:loadTexture("public/filter/attr_icon_on.png", var_0_0)
		else
			self.imgAttr:loadTexture("public/filter/attr_icon_off.png", var_0_0)
		end
	end)
	self.imgFilter:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.filterSpritePop = self:createFilterPop()

		self.rootLayer:addChild(self.filterSpritePop, 1000)
	end)

	if self.type == "adjust" then
		self:createAdjustUI()
	end

	for iter_9_0, iter_9_1 in pairs({
		[var_0_18 * 10 + 1] = self.filterBtn1,
		[var_0_19 * 10 + 1] = self.filterBtn2,
		[var_0_18 * 10 + 3] = self.filterBtn3,
		[var_0_19 * 10 + 3] = self.filterBtn4
	}) do
		iter_9_1.key1 = math.floor(iter_9_0 / 10)
		iter_9_1.key2 = iter_9_0 % 10

		iter_9_1:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.curSortOrders = arg_12_0.key1
			self.sortType = arg_12_0.key2
			self.filterTbl.sortOrder = self.curSortOrders
			self.filterTbl.sortType = self.sortType

			self:updateData()
			self:updateUI()
			self.tableview:reloadData()
		end)
	end
end

function PopComponentStrengthenLayer:createAdjustUI()
	self.imgBg:loadTexture("pop_component_strengthen_layer/bg_adjust.png", var_0_0)
	self.imgAttr:setVisible(false)
	self.imgFilter:setVisible(false)
	self.curComponentSp:setScale(0.8)
	self.curComponentSp:setPosition(self.curComponentSp:getPositionX() - 10, self.curComponentSp:getPositionY() + 15)
	self.tableview:setPositionY(180)

	for iter_13_0 = 1, 4 do
		self["filterBtn" .. iter_13_0]:setPositionY(self["filterBtn" .. iter_13_0]:getPositionY() + 90)
	end

	local var_13_1 = require("data.component_effect_data")[playermodel.items[self.entityid].component_attr.effect].image_id

	self.progressCur:setPosition(self.progressCur:getPositionX() + 20, self.progressCur:getPositionY() - 100)
	self.progressCur:setContentSize(cc.size(457, 6))
	self.progressBg:setPosition(self.progressBg:getPositionX() + 20, self.progressBg:getPositionY() - 100)
	self.progressBg:setContentSize(cc.size(457, 6))
	self.labelCurLevel:setPosition(self.labelCurLevel:getPositionX() - 20, self.labelCurLevel:getPositionY() - 100)
	self.labelExp:setPosition(self.labelExp:getPositionX(), self.labelExp:getPositionY() - 100)

	self.itemAdjustLeft = ItemSmallSprite:createSmallItem("gold", playermodel.gold, component_manager:getAdjustNeedGold(self.entityid))

	self.rootpanel:addChild(self.itemAdjustLeft)
	self.itemAdjustLeft:setScale(0.7)
	self.itemAdjustLeft:setPosition(200, 90)
	self.itemAdjustLeft:setInfoTouchEvent(true)

	self.itemAdjustRight = ItemSmallSprite:createSmallItem(5100001, require("controller.item_manager"):getItemNumber(5100001), 1)

	self.rootpanel:addChild(self.itemAdjustRight)
	self.itemAdjustRight:setPosition(440, 90)
	self.itemAdjustRight:setScale(0.7)
	self.itemAdjustRight:setInfoTouchEvent(true)
end

function PopComponentStrengthenLayer:createFilterPop()
	local var_14_1 = FilterSprite:create({
		filterType = filter_config_manager.COMPONENT_STRENGTHEN,
		filterCallback = function(arg_15_0)
			self:filterCallback(arg_15_0)
		end,
		maskTouchCallback = function(arg_16_0)
			if self.filterAniFlag1 then
				self.filterAniFlag1 = false

				self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
					self.filterAniFlag1 = true
					self.filterAniFlag = true
				end)))
				arg_16_0()
			end
		end,
		sortOrderChangeCallback = function(arg_18_0)
			self.curSortOrders = arg_18_0 == 0 and var_0_19 or var_0_18

			self:updateData()
			self:updateShowingCells()
			self:updateUI()
		end,
		initButtonConfig = initButtonConfig,
		defaultSortOrder = self.curSortOrders == var_0_19 and 0 or 1,
		defaultSortType = self.sortType
	})

	var_14_1:setPositionX(320)
	var_14_1:setPositionY(568)
	var_14_1:moveToTop()

	return var_14_1
end

function PopComponentStrengthenLayer:filterCallback(arg_19_1)
	self.filterTbl.sortType = arg_19_1.sortType or self.filterTbl

	for iter_19_0, iter_19_1 in pairs(arg_19_1.filterConfig) do
		self.filterTbl.filterConfig[iter_19_0] = global_deepCopy(iter_19_1)
	end

	if self.filterTbl.sortType == 2 then
		self.filterTbl.sortType = 3
	elseif self.filterTbl.sortType == 3 then
		self.filterTbl.sortType = 2
	end

	self.sortType = self.filterTbl.sortType

	self:updateData()
	self.tableview:reloadData()
	self:updateUI()
end

local var_0_20 = 570
local var_0_21 = 430
local var_0_22 = 13
local var_0_23 = 4
local var_0_24 = 570
local var_0_25 = 150
local var_0_26 = {
	cc.p(110 * 0.5, 150 / 2),
	cc.p(110 * 1.5, 150 / 2),
	cc.p(110 * 2.5, 150 / 2),
	cc.p(110 * 3.5, 150 / 2),
	(cc.p(110 * 4.5, 150 / 2))
}
local var_0_27 = 0.62

function PopComponentStrengthenLayer:createTableview()
	self.tableview = cc.TableView:create(cc.size(var_0_20, self.type == "strength" and var_0_21 or 340))

	self.tableview:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableview:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableview:setPosition(cc.p(var_0_22, var_0_23))
	self.tableview:setDelegate()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_tableview"):addChild(self.tableview)
	self.tableview:registerScriptHandler(function(arg_21_0, arg_21_1)
		return var_0_24, var_0_25
	end, cc.TABLECELL_SIZE_FOR_INDEX)

	local function var_20_0()
		local var_22_0 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_0)

		var_22_0:setCascadeOpacityEnabled(true)
		var_22_0:setSwallowTouches(false)
		Utility:addClickEventListener(var_22_0, handler(self, self.onBtnComponent))

		local var_22_1 = ItemSprite:createBigWithEntityId(self.entityid)

		var_22_1:setName("itemsp")
		var_22_1:setPositionX(var_22_0:getContentSize().width / 2)
		var_22_1:setPositionY(var_22_0:getContentSize().height / 2)
		var_22_0:addChild(var_22_1)

		local var_22_2 = ccui.ImageView:create("pop_component_strengthen_layer/select_frame.png", var_0_0)

		var_22_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_22_2:setPositionX(var_22_0:getContentSize().width / 2)
		var_22_2:setPositionY(var_22_0:getContentSize().height / 2)
		var_22_2:setVisible(true)
		var_22_2:setName("selectFrame")
		var_22_0:addChild(var_22_2)

		local var_22_3 = ccui.ImageView:create("public/box/new_item_bg_on.png", var_0_0)

		var_22_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_22_3:setPositionX(var_22_0:getContentSize().width / 2)
		var_22_3:setPositionY(var_22_0:getContentSize().height / 2)
		var_22_3:setVisible(false)
		var_22_3:setName("bgOn")
		var_22_0:addChild(var_22_3)

		local var_22_4 = ccui.ImageView:create("public/box/new_item_bg_cancle.png", var_0_0)

		var_22_4:setAnchorPoint(cc.p(0, 1))
		var_22_4:setPositionY(var_22_3:getContentSize().height)
		var_22_4:setVisible(true)
		var_22_4:setName("minus")
		var_22_4:setTouchEnabled(true)
		var_22_3:addChild(var_22_4)

		local var_22_5 = cc.Label:createWithTTF("0", "fonts/newkj.ttf", 20)

		var_22_5:setAnchorPoint(cc.p(0.5, 1))
		var_22_5:setPosition(var_22_3:getContentSize().width - 30, var_22_3:getContentSize().height - 3)
		var_22_5:setColor(cc.c3b(73, 58, 68))
		var_22_5:setVisible(true)
		var_22_5:setName("label_num")
		var_22_3:addChild(var_22_5)

		function var_22_0:update(arg_23_1)
			self.entityid = arg_23_1

			if arg_23_1 == 5100002 then
				self:getChildByName("itemsp"):updateBigInfo(self.is_show_attribute, arg_23_1)
				self:getChildByName("selectFrame"):setVisible(false)
				self:getChildByName("bgOn"):getChildByName("minus"):addTouchEventListener(function(arg_24_0, arg_24_1)
					if arg_24_1 ~= ccui.TouchEventType.ended then
						return
					end

					self:onBtnMinusComponent(self)

					if self.curSelectComponent[arg_23_1].num == 0 then
						self.curSelectComponent[arg_23_1] = nil
					end

					if self.curSelectComponent[self.entityid] and self.curSelectComponent[self.entityid].num then
						self:getChildByName("bgOn"):getChildByName("label_num"):setString(self.curSelectComponent[self.entityid].num)
						self:getChildByName("bgOn"):setVisible(true)
					else
						self:getChildByName("bgOn"):getChildByName("label_num"):setString("")
						self:getChildByName("bgOn"):setVisible(false)
					end
				end)

				if self.curSelectComponent[self.entityid] and self.curSelectComponent[self.entityid].num then
					self:getChildByName("bgOn"):getChildByName("label_num"):setString(self.curSelectComponent[self.entityid].num)
					self:getChildByName("bgOn"):setVisible(true)
				else
					self:getChildByName("bgOn"):getChildByName("label_num"):setString("")
					self:getChildByName("bgOn"):setVisible(false)
				end
			else
				self:getChildByName("itemsp"):updateBigInfo(self.is_show_attribute, arg_23_1)
				self:getChildByName("selectFrame"):setVisible(self.curSelectComponent[self.entityid] and true or false)
				self:getChildByName("bgOn"):setVisible(false)
			end
		end

		return var_22_0
	end

	self.tableview:registerScriptHandler(function(arg_25_0, arg_25_1)
		local var_25_0 = arg_25_0:dequeueCell()

		if not var_25_0 then
			var_25_0 = cc.TableViewCell:create()

			for iter_25_0 = 1, 5 do
				local var_25_1 = var_20_0()

				var_25_1:setAnchorPoint(cc.p(0.5, 0.5))
				var_25_1:setPosition(var_0_26[iter_25_0])
				var_25_1:setScale(var_0_27)
				var_25_1:setName("sp_" .. iter_25_0)
				var_25_0:addChild(var_25_1)
				var_25_1:setVisible(true)

				if self.componentList[arg_25_1 * 5 + iter_25_0] then
					var_25_1:update(self.componentList[arg_25_1 * 5 + iter_25_0])

					if playermodel.items[self.componentList[arg_25_1 * 5 + iter_25_0]].component_attr and playermodel.items[self.componentList[arg_25_1 * 5 + iter_25_0]].component_attr.attr2 then
						if var_25_1:getChildByName("itemsp"):getChildByName("rainbowBg") then
							var_25_1:getChildByName("itemsp"):getChildByName("rainbowBg"):setVisible(true)
						else
							local var_25_2 = ccui.ImageView:create("public/box/rainbow_bg.png", var_0_0)

							var_25_2:setAnchorPoint(1, 1)
							var_25_2:setPosition(var_25_1:getChildByName("itemsp"):getContentSize().width, var_25_1:getChildByName("itemsp"):getContentSize().height)
							var_25_2:setName("rainbowBg")
							var_25_1:getChildByName("itemsp"):addChild(var_25_2, 100)
						end
					elseif var_25_1:getChildByName("itemsp"):getChildByName("rainbowBg") then
						var_25_1:getChildByName("itemsp"):getChildByName("rainbowBg"):setVisible(false)
					end
				else
					var_25_1:setVisible(false)
				end
			end
		else
			for iter_25_1 = 1, 5 do
				local var_25_4 = var_25_0:getChildByName("sp_" .. iter_25_1)

				var_25_4:setVisible(true)

				if self.componentList[arg_25_1 * 5 + iter_25_1] then
					var_25_4:update(self.componentList[arg_25_1 * 5 + iter_25_1])

					if playermodel.items[self.componentList[arg_25_1 * 5 + iter_25_1]].component_attr and playermodel.items[self.componentList[arg_25_1 * 5 + iter_25_1]].component_attr.attr2 then
						if var_25_4:getChildByName("itemsp"):getChildByName("rainbowBg") then
							var_25_4:getChildByName("itemsp"):getChildByName("rainbowBg"):setVisible(true)
						else
							local var_25_5 = ccui.ImageView:create("public/box/rainbow_bg.png", var_0_0)

							var_25_5:setAnchorPoint(1, 1)
							var_25_5:setPosition(var_25_4:getChildByName("itemsp"):getContentSize().width, var_25_4:getChildByName("itemsp"):getContentSize().height)
							var_25_5:setName("rainbowBg")
							var_25_4:getChildByName("itemsp"):addChild(var_25_5, 100)
						end
					elseif var_25_4:getChildByName("itemsp"):getChildByName("rainbowBg") then
						var_25_4:getChildByName("itemsp"):getChildByName("rainbowBg"):setVisible(false)
					end
				else
					var_25_4:setVisible(false)
				end
			end
		end

		return var_25_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableview:registerScriptHandler(function(arg_26_0, arg_26_1)
		return self:getComponentListLen()
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableview:reloadData()
end

function PopComponentStrengthenLayer:updateShowingCells()
	local var_27_0, var_27_1 = GetTableViewShowCellIdx(self.tableview, {
		maxcount = self:getComponentListLen(),
		cellsize = cc.size(var_0_24, var_0_25)
	})

	for iter_27_0 = var_27_0, var_27_1 do
		self.tableview:updateCellAtIndex(iter_27_0)
	end
end

function PopComponentStrengthenLayer:onBtnComponent(arg_28_1)
	if self.type == "strength" then
		self:executeStrengthItemClick(arg_28_1)
	elseif self.type == "adjust" then
		self:executeAdjustItemClick(arg_28_1)
	end
end

function PopComponentStrengthenLayer:onBtnMinusComponent(arg_29_1)
	if self.type == "strength" then
		self:executeMinusStrengthItemClick(arg_29_1)
	elseif self.type == "adjust" then
		self:executeMinusAdjustItemClick(arg_29_1)
	end
end

function PopComponentStrengthenLayer:executeMinusStrengthItemClick(arg_30_1)
	local var_30_0 = component_manager:getExtraPoint(self.entityid)

	if not self.curSelectComponent[arg_30_1.entityid] and component_manager:getMaxLevel(playermodel.items[self.entityid].itemid) <= component_manager:getStrengthenExpected(self.entityid, (component_manager:getComponentMaterialExp(self.curSelectComponent))) then
		global_ShowBlockWords(L_COMPONENT_STRENGTHEN[1])

		return
	end

	if arg_30_1.entityid == 5100002 then
		self.curSelectComponent[arg_30_1.entityid].num = self.curSelectComponent[arg_30_1.entityid].num - 1
	end

	self:updateData()
	self:updateUI()
end

function PopComponentStrengthenLayer:executeMinusAdjustItemClick(arg_31_1)
	if not self.curSelectComponent[arg_31_1.entityid] and component_manager:getAdjustNeedExp(self.entityid) <= component_manager:getComponentMaterialExp(self.curSelectComponent) then
		global_ShowBlockWords(L_COMPONENT_STRENGTHEN[2])

		return
	end

	if arg_31_1.entityid == 5100002 then
		self.curSelectComponent[arg_31_1.entityid].num = self.curSelectComponent[arg_31_1.entityid].num - 1
	end

	self:updateData()
	self:updateUI()
end

function PopComponentStrengthenLayer:executeStrengthItemClick(arg_32_1)
	local var_32_0 = component_manager:getExtraPoint(self.entityid)

	if not self.curSelectComponent[arg_32_1.entityid] and component_manager:getMaxLevel(playermodel.items[self.entityid].itemid) <= component_manager:getStrengthenExpected(self.entityid, (component_manager:getComponentMaterialExp(self.curSelectComponent))) then
		global_ShowBlockWords(L_COMPONENT_STRENGTHEN[1])

		return
	end

	if arg_32_1.entityid == 5100002 then
		if self.curSelectComponent[arg_32_1.entityid] then
			if self.curSelectComponent[arg_32_1.entityid].num then
				self.curSelectComponent[arg_32_1.entityid].num = self.curSelectComponent[arg_32_1.entityid].num + 1 or 1
			end

			self.curSelectComponent[arg_32_1.entityid].entityid = arg_32_1.entityid
		else
			self.curSelectComponent[arg_32_1.entityid] = {}

			if self.curSelectComponent[arg_32_1.entityid].num then
				self.curSelectComponent[arg_32_1.entityid].num = self.curSelectComponent[arg_32_1.entityid].num + 1 or 1
			end

			self.curSelectComponent[arg_32_1.entityid].entityid = arg_32_1.entityid
		end
	elseif self.curSelectComponent[arg_32_1.entityid] then
		self.curSelectComponent[arg_32_1.entityid] = nil
	else
		self.curSelectComponent[arg_32_1.entityid] = arg_32_1.entityid
	end

	self:updateData()
	self:updateUI()
end

function PopComponentStrengthenLayer:executeAdjustItemClick(arg_33_1)
	if not self.curSelectComponent[arg_33_1.entityid] and component_manager:getAdjustNeedExp(self.entityid) <= component_manager:getComponentMaterialExp(self.curSelectComponent) then
		global_ShowBlockWords(L_COMPONENT_STRENGTHEN[2])

		return
	end

	if arg_33_1.entityid == 5100002 then
		if self.curSelectComponent[arg_33_1.entityid] then
			if self.curSelectComponent[arg_33_1.entityid].num then
				self.curSelectComponent[arg_33_1.entityid].num = self.curSelectComponent[arg_33_1.entityid].num + 1 or 1
			end

			self.curSelectComponent[arg_33_1.entityid].entityid = arg_33_1.entityid
		else
			self.curSelectComponent[arg_33_1.entityid] = {}

			if self.curSelectComponent[arg_33_1.entityid].num then
				self.curSelectComponent[arg_33_1.entityid].num = self.curSelectComponent[arg_33_1.entityid].num + 1 or 1
			end

			self.curSelectComponent[arg_33_1.entityid].entityid = arg_33_1.entityid
		end
	elseif self.curSelectComponent[arg_33_1.entityid] then
		self.curSelectComponent[arg_33_1.entityid] = nil
	else
		self.curSelectComponent[arg_33_1.entityid] = arg_33_1.entityid
	end

	self:updateData()
	self:updateUI()
end

function PopComponentStrengthenLayer:getComponentListLen()
	return math.ceil(#self.componentList / 5)
end

function PopComponentStrengthenLayer.getStrengthenHandel(arg_35_0)
	return function(arg_36_0, arg_36_1)
		if arg_36_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_36_0:isBright() then
			return
		end

		arg_36_0:setBright(false)

		if not next(arg_35_0.curSelectComponent) then
			global_ShowBlockWords(L_COMPONENT_STRENGTHEN[3])
			arg_36_0:setBright(true)

			return
		end

		local var_36_0 = {}
		local var_36_1 = false

		for iter_36_0, iter_36_1 in pairs(arg_35_0.curSelectComponent) do
			if component_manager:hadAdjustComponent(iter_36_1) then
				var_36_1 = true
			end

			table.insert(var_36_0, iter_36_1)
		end

		if arg_35_0.type == "adjust" and component_manager:getComponentMaterialExp(arg_35_0.curSelectComponent) < component_manager:getAdjustNeedExp(arg_35_0.entityid) then
			global_ShowBlockWords(L_COMPONENT_STRENGTHEN[4])
			arg_36_0:setBright(true)

			return
		end

		local function var_36_2(...)
			if arg_35_0.type == "strength" then
				arg_35_0:executeStrengthClick(arg_36_0)
			elseif arg_35_0.type == "adjust" then
				arg_35_0:executeAdjustClick(arg_36_0)
			end
		end

		local function var_36_3(arg_38_0)
			for iter_38_0, iter_38_1 in pairs(arg_38_0) do
				if type(iter_38_1) == "number" then
					if var_36_1 then
						local var_38_1 = L_COMPONENT_STRENGTHEN[7] or L_COMPONENT_STRENGTHEN[8]

						if playermodel.items[iter_38_1].component_attr.exp > 0 or playermodel.items[iter_38_1].component_attr.extra > 0 then
							return arg_35_0.type == "strength" and string.format(L_COMPONENT_STRENGTHEN[5], var_38_1) or string.format(L_COMPONENT_STRENGTHEN[6], var_38_1)
						end
					end
				end
			end
		end

		if var_36_3(var_36_0) then
			require("view.Sprite.ConfirmDialogSprite")

			local var_36_4 = ConfirmDialogSprite:create(L_HORCRUX_LEVEL_UP_MSG.Dialog, var_36_3(var_36_0), {
				layerType = "PopComponentStrengthenLayer",
				surecallback = var_36_2,
				cancelCallback = function(...)
					arg_36_0:setBright(true)
				end
			}, nil, nil, function(...)
				arg_36_0:setBright(true)
			end)

			var_36_4:setPositionY(var_36_4:getPositionY() - GameDisplay.fix_y)
			arg_35_0:addChild(var_36_4, 10)
		else
			var_36_2()
		end
	end
end

function PopComponentStrengthenLayer:executeStrengthClick(arg_41_1)
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in pairs(self.curSelectComponent) do
		table.insert(var_41_0, iter_41_1)
	end

	component_manager:strengthenComponent(self.entityid, var_41_0, function(arg_42_0)
		if tolua.isnull(self) then
			return
		end

		if arg_42_0 == 1 then
			self.curSelectComponent = {}

			self.bagManager:update()
			self:updateData()
			self:updateUI()
			self.tableview:reloadData()

			self.isStrengthen = 1
		elseif arg_42_0 == 2 then
			-- block empty
		elseif arg_42_0 == 4 then
			global_ShowBlockWords(L_GOLD_LACK)
			LayerManager:pushInLayer("HandOfMidasLayer", {
				callback = function(...)
					self:updateUI()
				end
			})
		end

		arg_41_1:setBright(true)
	end)
end

function PopComponentStrengthenLayer:executeAdjustClick(arg_44_1)
	local var_44_0 = component_manager:getComponentAttrsInfo(self.entityid)

	component_manager:adjustComponent(self.entityid, self.curSelectComponent, function(arg_45_0)
		if tolua.isnull(self) then
			return
		end

		if arg_45_0 == 1 then
			self:exit()
			LocalEvent:triggerEvent(LocalEvent.EVENT_IDS.DECOMPOSE_ITEMS)
			LayerManager:pushInLayer("PopAdjustSuccessLayer", {
				entityid = self.entityid,
				preComponentInfo = var_44_0
			})
		elseif arg_45_0 == 3 then
			global_ShowBlockWords(L_COMPONENT_STRENGTHEN[9])
		elseif arg_45_0 == 4 then
			global_ShowBlockWords(L_GOLD_LACK)
			LayerManager:pushInLayer("HandOfMidasLayer", {
				callback = function(...)
					self:updateUI()
				end
			})
		end

		arg_44_1:setBright(true)
	end)
end

function PopComponentStrengthenLayer.getAutoSelectHanel(arg_47_0)
	return function(arg_48_0, arg_48_1)
		if arg_48_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_47_0.type == "adjust" then
			arg_47_0:executeAdjustSelect()
		elseif arg_47_0.type == "strength" then
			arg_47_0:executeStrengthSelect()
		end
	end
end

function PopComponentStrengthenLayer:executeStrengthSelect()
	if self.expectedAddExtra >= component_manager:getMaxLevel(self.itemid) then
		return
	end

	self.curSelectComponent = {}

	local var_49_0 = component_manager:getComponentLevelNeedExp(self.entityid, self.expectedAddExtra)
	local var_49_1 = 0

	for iter_49_0, iter_49_1 in pairs(self.componentList) do
		if var_49_0 <= var_49_1 then
			break
		end

		if iter_49_1 == 5100002 then
			for iter_49_2 = 1, playermodel.items[iter_49_1].number do
				if not self.curSelectComponent[iter_49_1] then
					self.curSelectComponent[iter_49_1] = {}
					self.curSelectComponent[iter_49_1].entityid = iter_49_1
				end

				self.curSelectComponent[iter_49_1].num = iter_49_2

				if var_49_0 <= iter_49_2 * 100 + var_49_1 then
					var_49_1 = iter_49_2 * 100 + var_49_1

					break
				end

				if iter_49_2 == playermodel.items[iter_49_1].number then
					var_49_1 = iter_49_2 * 100 + var_49_1
				end
			end
		else
			var_49_1 = var_49_1 + component_manager:getComponentMaterialExp({
				iter_49_1
			})

			if playermodel.gold < component_manager:getStrengthenExpected(self.entityid, var_49_1) then
				break
			end

			self.curSelectComponent[iter_49_1] = iter_49_1
		end
	end

	self:updateData()
	self:updateUI()
end

function PopComponentStrengthenLayer:executeAdjustSelect()
	self.curSelectComponent = {}

	local var_50_0 = component_manager:getAdjustNeedExp(self.entityid)
	local var_50_1 = 0

	for iter_50_0, iter_50_1 in pairs(self.componentList) do
		if var_50_0 <= var_50_1 then
			break
		end

		if iter_50_1 == 5100002 then
			for iter_50_2 = 1, playermodel.items[iter_50_1].number do
				if not self.curSelectComponent[iter_50_1] then
					self.curSelectComponent[iter_50_1] = {}
					self.curSelectComponent[iter_50_1].entityid = iter_50_1
				end

				self.curSelectComponent[iter_50_1].num = iter_50_2

				if var_50_0 <= iter_50_2 * 100 + var_50_1 then
					var_50_1 = iter_50_2 * 100 + var_50_1

					break
				end

				if iter_50_2 == playermodel.items[iter_50_1].number then
					var_50_1 = iter_50_2 * 100 + var_50_1
				end
			end
		else
			var_50_1 = var_50_1 + component_manager:getComponentMaterialExp({
				iter_50_1
			})

			if playermodel.gold < component_manager:getStrengthenExpected(self.entityid, var_50_1) then
				break
			end

			self.curSelectComponent[iter_50_1] = iter_50_1
		end
	end

	self:updateData()
	self:updateUI()
end

function PopComponentStrengthenLayer:updateUI()
	if self.type == "adjust" then
		self:updateAdjustUI()
	elseif self.type == "strength" then
		self:updateStrengthUI()
	end
end

function PopComponentStrengthenLayer:updateQuicklyFilterbtn()
	local var_52_0 = {
		self.filterBtn1,
		[11] = self.filterBtn2,
		[3] = self.filterBtn3,
		[13] = self.filterBtn4
	}

	for iter_52_0, iter_52_1 in pairs(var_52_0) do
		iter_52_1:loadTexture("pop_component_strengthen_layer/filter_btn_off.png", var_0_0)
	end

	if var_52_0[tonumber(self.curSortOrders .. self.sortType)] then
		var_52_0[tonumber(self.curSortOrders .. self.sortType)]:loadTexture("pop_component_strengthen_layer/filter_btn_on.png", var_0_0)
	end
end

function PopComponentStrengthenLayer:updateStrengthPointUI()
	local var_53_0 = component_manager:getComponentStrengthenInfo(self.entityid)
	local var_53_1 = 1

	::label_53_0::

	local var_53_3

	if component_strengthen_weight_data[self.quality]["add_weight" .. 1] then
		repeat
			if component_strengthen_weight_data[self.quality]["add_weight" .. 1] > 0 then
				var_53_1 = 1
			end

			goto label_53_0
		until true

		var_53_3 = {
			217,
			289,
			368,
			447,
			526,
			598
		}
	end

	for iter_53_0, iter_53_1 in pairs({
		{
			id = 6,
			uiname = "Image_red"
		},
		{
			id = 5,
			uiname = "Image_orange"
		},
		{
			id = 4,
			uiname = "Image_purple"
		},
		{
			id = 3,
			uiname = "Image_blue"
		},
		{
			id = 2,
			uiname = "Image_green"
		},
		{
			id = 1,
			uiname = "Image_white"
		}
	}) do
		ccui.Helper:seekWidgetByName(self.rootLayer, iter_53_1.uiname):getChildByName("Label_num"):setString(var_53_0[iter_53_1.id])
		ccui.Helper:seekWidgetByName(self.rootLayer, iter_53_1.uiname):setVisible(false)

		if var_53_1 >= iter_53_1.id and component_strengthen_weight_data[self.quality]["add_weight" .. iter_53_1.id] > 0 then
			ccui.Helper:seekWidgetByName(self.rootLayer, iter_53_1.uiname):setVisible(true)
			ccui.Helper:seekWidgetByName(self.rootLayer, iter_53_1.uiname):setPositionX(var_53_3[1])
		end
	end
end

function PopComponentStrengthenLayer:updateAdjustUI()
	local var_54_0 = component_manager:canAdjustComponent(self.entityid)

	self.imgMaxLevel:setVisible(false)
	self.btnAutoSelect:setVisible(var_54_0)
	self.btnSure:setVisible(var_54_0)
	self.labelSure:setString((var_54_0 or nil) and (L_COMPONENT_TEXT.Button_Label[8] or L_COMPONENT_TEXT.Button_Label[9]))
	self.progressCur:setPercent(Utility:clamp(math.floor(self.expectedExp / component_manager:getAdjustNeedExp(self.entityid) * 100), 0, 100))
	self.progressNext:setVisible(false)
	self.labelExp:setString(self.expectedExp .. "/" .. component_manager:getAdjustNeedExp(self.entityid))
	self.curComponentSp:updateBigInfo(nil, self.entityid)

	local var_54_1 = component_manager:getMaxLevel(playermodel.items[self.entityid].itemid)
	local var_54_2 = component_manager:getExtraPoint(self.entityid)
	local var_54_3 = component_manager:getComponentAttrsInfo(self.entityid)
	local var_54_4 = component_manager:getComponentExp(self.entityid)

	self.labelCurLevel:setString(L_COMPONENT_STRENGTHEN[10])
	self.labelCurLevel:setFontSize(22)
	self.labelCurLevel:setColor(cc.c3b(255, 255, 255))
	self.labelCurLevel:setPositionY(self.labelExp:getPositionY())
	self.labelAttr:setString(var_54_3.main_attr_des)
	self.labelAttr:setVisible(false)
	self.labelCurAttr:setPositionX(self.labelAttr:getPositionX() + self.labelAttr:getContentSize().width)
	self.labelCurAttr:setString("+" .. var_54_3.main_attr_num_des)
	self.labelCurAttr:setVisible(false)

	local var_54_5 = component_manager:getComponentAttrRange(self.entityid)

	self.labelNextAttr:setString(" → " .. FIGHT_ATTR_FORMAT(var_54_5.key, var_54_5.minValue) .. "~" .. FIGHT_ATTR_FORMAT(var_54_5.key, var_54_5.maxValue))
	self.labelNextAttr:setPositionX(self.labelCurAttr:getPositionX() + self.labelCurAttr:getContentSize().width)
	self.labelNextLevel:setVisible(next(self.curSelectComponent) and true or false)
	self.labelNextAttr:setVisible(next(self.curSelectComponent) and true or false)
	self.labelNextLevel:setString(" → " .. self.expectedAddExtra)
	self.labelNextLevel:setPositionX(self.labelCurLevel:getPositionX() + self.labelCurLevel:getContentSize().width)
	self.labelNextLevel:setVisible(false)
	self.labelNextAttr:setVisible(false)
	self.btnSure:loadTextures("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", var_0_0)

	for iter_54_0, iter_54_1 in pairs({
		{
			id = 6,
			uiname = "Image_red"
		},
		{
			id = 5,
			uiname = "Image_orange"
		},
		{
			id = 4,
			uiname = "Image_purple"
		},
		{
			id = 3,
			uiname = "Image_blue"
		},
		{
			id = 2,
			uiname = "Image_green"
		},
		{
			id = 1,
			uiname = "Image_white"
		}
	}) do
		ccui.Helper:seekWidgetByName(self.rootLayer, iter_54_1.uiname):setVisible(false)
	end

	self:updateShowingCells()
	self:updateQuicklyFilterbtn()
	self.imgCost:setVisible(false)
	self.labelCost:setVisible(false)
end

function PopComponentStrengthenLayer:updateStrengthUI()
	self.curComponentSp:updateBigInfo(nil, self.entityid)

	local var_55_0 = component_manager:getMaxLevel(playermodel.items[self.entityid].itemid)
	local var_55_1 = component_manager:getExtraPoint(self.entityid)
	local var_55_2 = component_manager:getComponentAttrsInfo(self.entityid)
	local var_55_3 = var_55_2.main_attr_des2
	local var_55_4 = var_55_2.main_attr_num_des2
	local var_55_5 = component_manager:getComponentExp(self.entityid)

	self.labelCurLevel:setString(L_EQUIPLAYER[6] .. var_55_1)
	self.labelAttr:setString(var_55_2.main_attr_des)
	self.labelCurAttr:setPosition(self.labelAttr:getPositionX() + self.labelAttr:getContentSize().width, self.labelCurAttrPosY + 10)
	self.labelAttr:setPositionY(self.labelCurAttrPosY + 10)
	self.labelNextAttr:setPositionY(self.labelCurAttrPosY + 10)
	self.labelCurAttr:setString("+" .. var_55_2.main_attr_num_des)
	self.labelNextLevel:setVisible(next(self.curSelectComponent) and true or false)
	self.labelNextAttr:setVisible(next(self.curSelectComponent) and true or false)

	if playermodel.items[self.entityid].component_attr.attr2 then
		self.labelNextAttr2:setVisible(next(self.curSelectComponent) and true or false)
	end

	self.labelNextLevel:setString(" → " .. self.expectedAddExtra)
	self.labelNextLevel:setPositionX(self.labelCurLevel:getPositionX() + self.labelCurLevel:getContentSize().width)

	if var_55_0 <= self.expectedAddExtra then
		self.progressNext:setPercent(100)
		self.labelExp:setVisible(false)
		self.progressNext:setVisible(true)
	else
		self.progressNext:setVisible(next(self.curSelectComponent) and true or false)

		local var_55_6 = component_manager:getComponetLevelUpNeedExp(self.entityid, self.expectedAddExtra) or 1

		self.progressCur:setPercent(math.floor(var_55_5 / var_55_6 * 100))
		self.progressNext:setPercent(math.floor(self.expectedExp / var_55_6 * 100))
		self.labelExp:setString(self.expectedExp .. "/" .. var_55_6)
	end

	if playermodel.items[self.entityid].component_attr.attr2 then
		self.label1:setString(var_55_3)
		self.label2:setString("+" .. var_55_4)
		self.label1:setPosition(self.labelAttr:getPositionX(), self.labelAttr:getPositionY() - 50)
		self.label2:setPosition(self.label1:getPositionX() + self.label1:getContentSize().width, self.labelAttr:getPositionY() - 50)
	end

	if self.expectedAddExtra > 0 then
		local var_55_7, var_55_8, var_55_9, var_55_10 = component_manager:getStrengthenInfo(self.entityid, true, nil, self.expectedAddExtra - var_55_1)

		self.labelNextAttr:setString(" → " .. FIGHT_ATTR_FORMAT(var_55_7[2].key, var_55_7[2].value) .. "~" .. FIGHT_ATTR_FORMAT(var_55_7[2].key, var_55_7[2].max_value))
		self.labelNextAttr:setPositionX(self.labelCurAttr:getPositionX() + self.labelCurAttr:getContentSize().width)

		if playermodel.items[self.entityid].component_attr.attr2 then
			self.labelNextAttr2:setPosition(self.label2:getPositionX() + self.label2:getContentSize().width, self.label2:getPositionY())
			self.labelNextAttr2:setString(" → " .. FIGHT_ATTR_FORMAT(var_55_10[2].key, var_55_10[2].value) .. "~" .. FIGHT_ATTR_FORMAT(var_55_10[2].key, var_55_10[2].max_value))
		end
	else
		self.labelNextAttr:setVisible(false)

		if playermodel.items[self.entityid].component_attr.attr2 then
			self.labelNextAttr2:setVisible(false)
		end
	end

	if var_55_1 < var_55_0 then
		self.progressNext:setVisible(true)
		self.imgMaxLevel:setVisible(false)
	else
		self.progressNext:setVisible(false)
		self.progressCur:setPercent(100)
		self.imgMaxLevel:setVisible(true)
	end

	self.progressCur:setVisible(self.expectedAddExtra == var_55_1)
	self:updateStrengthPointUI()
	self:updateShowingCells()
	self:updateQuicklyFilterbtn()

	if next(self.curSelectComponent) then
		self.imgCost:setVisible(true)
		self.labelCost:setVisible(true)
		self.labelCost:setString(global_trans_number(playermodel.gold) .. "/" .. global_trans_number(self.costgold))

		if playermodel.gold < self.costgold then
			self.labelCost:setColor(cc.c3b(255, 0, 0))
		else
			self.labelCost:setColor(cc.c3b(255, 255, 255))
		end
	else
		self.imgCost:setVisible(false)
		self.labelCost:setVisible(false)
	end

	if var_55_1 < var_55_0 then
		self.btnSure:loadTextures("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", var_0_0)
		self.labelSure:setString(L_COMPONENT_TEXT.Button_Label[3])
	else
		self.btnAutoSelect:setVisible(false)
		self.btnSure:setVisible(false)
		self.labelSure:setString(L_COMPONENT_TEXT.Button_Label[4])
	end
end

function PopComponentStrengthenLayer:initBg(arg_56_1)
	local var_56_0 = ccui.Layout:create()

	var_56_0:setTouchEnabled(true)
	var_56_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_56_0:setAnchorPoint(cc.p(0, 0))
	var_56_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_56_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_56_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_56_0:setOpacity(0)
	self:addChild(var_56_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_57_0)
		self:addChild(arg_57_0, -2)
		arg_57_0:setPositionY(arg_57_0:getPositionY() - GameDisplay.fix_y)

		local var_57_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_57_0:setAnchorPoint(cc.p(0, 0))
		var_57_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_57_0, -1)
		self:init(arg_56_1)
		var_56_0:setOpacity(102)
		var_56_0:setTouchEnabled(false)
	end)
end

function PopComponentStrengthenLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopComponentStrengthenLayer:handlePurchaseSuccess(arg_60_1)
	self.itemAdjustLeft:updateSmallItemByItemid("gold", playermodel.gold, component_manager:getAdjustNeedGold(self.entityid))
	self.itemAdjustRight:updateSmallItemByItemid(5100001, require("controller.item_manager"):getItemNumber(5100001), 1)
end

PopAdjustSuccessLayer = class("PopAdjustSuccessLayer", function(...)
	return PopBaseLayer:create(...)
end)

function PopAdjustSuccessLayer.create(arg_62_0, arg_62_1)
	local var_62_0 = PopAdjustSuccessLayer.new()

	var_62_0:init(arg_62_1)

	return var_62_0
end

function PopAdjustSuccessLayer:init(arg_63_1)
	self:initData(arg_63_1)
	self:initUI()
	self:registerEvents()
	self:show()
end

function PopAdjustSuccessLayer:initData(arg_64_1)
	self.entityid = arg_64_1 and arg_64_1.entityid
	self.preComponentInfo = arg_64_1 and arg_64_1.preComponentInfo
	self.itemid = playermodel.items[self.entityid].itemid
	self.quality = item_data[self.itemid].equip_quality
end

function PopAdjustSuccessLayer:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopAdjustSuccessLayer.json" or "PopAdjustSuccessLayer.ExportJson")

	self.rootNode:setContentSize(GameDisplay.size)
	self.rootNode:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootNode)

	self.rootpanel = self.rootNode:getChildByName("rootPanel")

	self.rootpanel:setAnchorPoint(0.5, 0.5)
	self.rootpanel:setPositionX(GameDisplay.size.width / 2)
	self.rootpanel:setPositionY(GameDisplay.size.height / 2)
	self.rootpanel:setTouchEnabled(false)

	self.panelMain = self.rootpanel:getChildByName("panelMain")

	Utility:alignPanelByParent(self.panelMain, self.rootpanel)
	self.panelMain:setPositionY(self.panelMain:getPositionY() + 120)

	self.listViewPoints = self.panelMain:getChildByName("listViewPoints")
	self.imgPoint = self.panelMain:getChildByName("imgPoint")

	self.imgPoint:removeFromParent()
	self.imgPoint:retain()

	self.labelCurAttr = self.panelMain:getChildByName("labelCurAttr")
	self.labelNextAttr = self.panelMain:getChildByName("labelNextAttr")
	self.btnConfirm = self.panelMain:getChildByName("btnConfirm")

	self:updateLayout()
end

function PopAdjustSuccessLayer:registerEvents()
	Utility:registerNodeEvent(self)
	Utility:addClickEventListener(self.rootNode, handler(self, self.hide))
	Utility:addClickEventListener(self.btnConfirm, handler(self, self.hide))
end

function PopAdjustSuccessLayer:onExit()
	self.imgPoint:release()
end

function PopAdjustSuccessLayer:updateLayout()
	Utility:replaceNodeByNode(self.panelMain, "imgItem", (ItemSprite:createBigWithEntityId(self.entityid)))

	local var_68_0 = component_manager:getComponentAttrsInfo(self.entityid)

	self.labelCurAttr:setString(self.preComponentInfo.main_attr_des .. "+" .. self.preComponentInfo.main_attr_num_des)
	self.labelNextAttr:setString(var_68_0.main_attr_des .. "+" .. var_68_0.main_attr_num_des)
	self.labelNextAttr:setColor(cc.c3b(0, 200, 0))

	local var_68_1 = component_manager:getComponentStrengthenInfo(self.entityid)
	local var_68_2 = 1

	while component_strengthen_weight_data[self.quality]["add_weight" .. 1] do
		if component_strengthen_weight_data[self.quality]["add_weight" .. 1] > 0 then
			var_68_2 = 1
		end
	end

	local var_68_4 = {
		[6] = {
			id = 6,
			uiname = "pop_component_strengthen_layer/red.png"
		},
		[5] = {
			id = 5,
			uiname = "pop_component_strengthen_layer/orange.png"
		},
		[4] = {
			id = 4,
			uiname = "pop_component_strengthen_layer/purple.png"
		},
		[3] = {
			id = 3,
			uiname = "pop_component_strengthen_layer/blue.png"
		},
		[2] = {
			id = 2,
			uiname = "pop_component_strengthen_layer/green.png"
		},
		{
			id = 1,
			uiname = "pop_component_strengthen_layer/white.png"
		}
	}

	self.listViewPoints:setClippingEnabled(false)

	local var_68_5 = 0

	for iter_68_0 = 6, 1, -1 do
		if iter_68_0 <= var_68_2 and component_strengthen_weight_data[self.quality]["add_weight" .. iter_68_0] > 0 then
			local var_68_6 = self.imgPoint:clone()

			var_68_6:loadTexture(var_68_4[iter_68_0].uiname, var_0_0)
			var_68_6:getChildByName("labelCount"):setString("" .. var_68_1[iter_68_0])
			print("" .. var_68_1[iter_68_0])
			self.listViewPoints:pushBackCustomItem(var_68_6)

			var_68_5 = var_68_5 + 1
		end
	end

	self.listViewPoints:setContentSize(cc.size(self.imgPoint:getContentSize().width * var_68_5 + math.max(0, var_68_5 - 1) * self.listViewPoints:getItemsMargin(), self.listViewPoints:getContentSize().height))
	self.listViewPoints:doLayout()
end

function PopAdjustSuccessLayer:show()
	self.showActions.extendVertical(self)
end

function PopAdjustSuccessLayer:hide()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

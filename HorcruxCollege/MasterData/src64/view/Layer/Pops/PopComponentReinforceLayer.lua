PopComponentReinforceLayer = class("PopComponentReinforceLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local playermodel = require("model.playermodel")
local l2utils = require("controller.l2utils")
local total_skill_data = require("data.total_skill_data")
local component_effect_data = require("data.component_effect_data")
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
local var_0_16 = 0
local var_0_17 = 1

function PopComponentReinforceLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopComponentReinforceLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopComponentReinforceLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopComponentReinforceLayer.json" or "PopComponentReinforceLayer.ExportJson")

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
end

function PopComponentReinforceLayer:initData(arg_7_1)
	self.servantid = arg_7_1.servantid
	self.reinforce_component = playermodel.reinforce_component[self.servantid]

	local var_7_0, var_7_1 = component_manager:getServantComponentlist(self.servantid)

	self.componentList = var_7_0
	self.effect = var_7_1[1]

	print("self.effectself.effectself.effect", self.effect)

	self.needExp = component_effect_data[self.effect].skill_up_exp or 9876

	if not component_effect_data[self.effect].skill_up_exp then
		hx_print("componentEffectData[" .. self.effect .. "].skill_up_exp is nil")
	end

	if not component_effect_data[self.effect].intro_up then
		hx_print("componentEffectData[" .. self.effect .. "].intro_up is nil")
	end

	if not component_effect_data[self.effect].intro_up then
		hx_print("componentEffectData[" .. self.effect .. "].intro_up is nil")
	end

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

	self.filterTbl.outSide = {
		self.entityid
	}
	self.filterAniFlag1 = true
	self.curSortOrders = var_0_16
	self.sortType = 1
	self.filterTbl.sortType = self.sortType
end

function PopComponentReinforceLayer:updateData()
	self.filterTbl.sortOrder = self.curSortOrders
	self.componentList = self.bagManager:getBagData(self.filterTbl)

	if playermodel.items[5100002] then
		table.insert(self.componentList, 1, 5100002)
	end
end

function PopComponentReinforceLayer:initUI()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):addTouchEventListener(self:getStrengthenHandel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):setLocalZOrder(100)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_auotselect"):addTouchEventListener(self:getAutoSelectHanel())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_autoselect"):setString(L_AOTU_CHOOSE)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_needexp"):setString(L_COMPONENT_STRENGTHEN[10])
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_sure"):setString(L_COMPONENT_STRENGTHEN[11])

	self.filterBtn1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_quick_filter1")
	self.filterBtn2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_quick_filter2")
	self.filterBtn3 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_quick_filter3")
	self.filterBtn4 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_quick_filter4")

	self.filterBtn1:getChildByName("Label_des"):setString(L_COMPONENT_TEXT.Sort_Order[1])
	self.filterBtn2:getChildByName("Label_des"):setString(L_COMPONENT_TEXT.Sort_Order[2])
	self.filterBtn3:getChildByName("Label_des"):setString(L_COMPONENT_TEXT.Sort_Order[3])
	self.filterBtn4:getChildByName("Label_des"):setString(L_COMPONENT_TEXT.Sort_Order[4])
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_skilldes1"):setString(split(component_effect_data[self.effect].intro, "：")[2])
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_skilldes2"):setString(split(component_effect_data[self.effect].intro_up, "：")[2])
	self:createTableview()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_attr"):addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.is_show_attribute = not self.is_show_attribute

		self:updateShowingCells()

		if self.is_show_attribute then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_attr"):loadTexture("public/filter/attr_icon_on.png", var_0_0)
		else
			ccui.Helper:seekWidgetByName(self.rootLayer, "Image_attr"):loadTexture("public/filter/attr_icon_off.png", var_0_0)
		end
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_filter"):addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.filterSpritePop = self:createFilterPop()

		self.rootLayer:addChild(self.filterSpritePop, 1000)
	end)

	for iter_9_0, iter_9_1 in pairs({
		[var_0_16 * 10 + 1] = self.filterBtn1,
		[var_0_17 * 10 + 1] = self.filterBtn2,
		[var_0_16 * 10 + 3] = self.filterBtn3,
		[var_0_17 * 10 + 3] = self.filterBtn4
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

	local var_9_0 = {}

	for iter_9_2 = 1, 3 do
		var_9_0[iter_9_2] = item_data[playermodel.items[playermodel.component[self.servantid][iter_9_2].id].itemid].main_attr and "equipment/component/shine_component/component" .. component_effect_data[self.effect].image_id .. "_" .. item_data[playermodel.items[playermodel.component[self.servantid][iter_9_2].id].itemid].main_attr .. "_" .. iter_9_2 .. ".png" or "equipment/component/shine_component/component" .. component_effect_data[self.effect].image_id .. "_" .. playermodel.items[playermodel.component[self.servantid][iter_9_2].id].component_attr.attr1 .. "_" .. iter_9_2 .. ".png"
	end

	for iter_9_3, iter_9_4 in pairs(var_9_0) do
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_component_" .. iter_9_3):loadTexture(iter_9_4)
	end
end

function PopComponentReinforceLayer:createFilterPop()
	local var_13_1 = FilterSprite:create({
		filterType = filter_config_manager.COMPONENT_STRENGTHEN,
		filterCallback = function(arg_14_0)
			self:filterCallback(arg_14_0)
		end,
		maskTouchCallback = function(arg_15_0)
			if self.filterAniFlag1 then
				self.filterAniFlag1 = false

				self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
					self.filterAniFlag1 = true
					self.filterAniFlag = true
				end)))
				arg_15_0()
			end
		end,
		sortOrderChangeCallback = function(arg_17_0)
			self.curSortOrders = arg_17_0 == 0 and var_0_17 or var_0_16

			self:updateData()
			self:updateShowingCells()
			self:updateUI()
		end,
		initButtonConfig = initButtonConfig,
		defaultSortOrder = self.curSortOrders == var_0_17 and 0 or 1,
		defaultSortType = self.sortType
	})

	var_13_1:setPositionX(320)
	var_13_1:setPositionY(568)
	var_13_1:moveToTop()

	return var_13_1
end

function PopComponentReinforceLayer:filterCallback(arg_18_1)
	self.filterTbl.sortType = arg_18_1.sortType or self.filterTbl

	for iter_18_0, iter_18_1 in pairs(arg_18_1.filterConfig) do
		self.filterTbl.filterConfig[iter_18_0] = global_deepCopy(iter_18_1)
	end

	if self.filterTbl.sortType == 2 then
		self.filterTbl.sortType = 3
	elseif self.filterTbl.sortType == 3 then
		self.filterTbl.sortType = 2
	end

	self.sortType = self.filterTbl.sortType

	self:updateData()
	self:updateUI()
	self.tableview:reloadData()
end

local var_0_18 = 510
local var_0_19 = 300
local var_0_20 = 10
local var_0_21 = 4
local var_0_22 = 510
local var_0_23 = 136
local var_0_24 = {
	cc.p(102 * 0.5, 136 / 2),
	cc.p(102 * 1.5, 136 / 2),
	cc.p(102 * 2.5, 136 / 2),
	cc.p(102 * 3.5, 136 / 2),
	(cc.p(102 * 4.5, 136 / 2))
}
local var_0_25 = 0.58

function PopComponentReinforceLayer:createTableview()
	self.tableview = cc.TableView:create(cc.size(var_0_18, var_0_19))

	self.tableview:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableview:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableview:setPosition(cc.p(var_0_20, var_0_21))
	self.tableview:setDelegate()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_tableview"):addChild(self.tableview)
	self.tableview:registerScriptHandler(function(arg_20_0, arg_20_1)
		return var_0_22, var_0_23
	end, cc.TABLECELL_SIZE_FOR_INDEX)

	local function var_19_0()
		local var_21_0 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_0)

		var_21_0:setCascadeOpacityEnabled(true)
		var_21_0:setSwallowTouches(false)
		var_21_0:addTouchEventListener(function(arg_22_0, arg_22_1)
			if arg_22_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_22_0:getTouchBeganPosition().y - arg_22_0:getTouchEndPosition().y) > 50 then
				return
			end

			if arg_22_0.entityid ~= 5100002 then
				if self.curSelectComponent[arg_22_0.entityid] then
					self.curSelectComponent[arg_22_0.entityid] = nil
				else
					if self.giveExp >= self.needExp then
						global_ShowBlockWords(L_COMPONENT_STRENGTHEN[12])

						return
					end

					self.curSelectComponent[arg_22_0.entityid] = arg_22_0.entityid
				end
			elseif self.curSelectComponent[arg_22_0.entityid] then
				if self.giveExp >= self.needExp then
					global_ShowBlockWords(L_COMPONENT_STRENGTHEN[12])

					return
				end

				self.curSelectComponent[arg_22_0.entityid].num = self.curSelectComponent[arg_22_0.entityid].num + 1
				self.curSelectComponent[arg_22_0.entityid].entityid = 5100002
			else
				if self.giveExp >= self.needExp then
					global_ShowBlockWords(L_COMPONENT_STRENGTHEN[12])

					return
				end

				self.curSelectComponent[arg_22_0.entityid] = {}
				self.curSelectComponent[arg_22_0.entityid].num = 1
				self.curSelectComponent[arg_22_0.entityid].entityid = 5100002
			end

			self:updateData()
			self:updateUI()
		end)

		local var_21_1

		for iter_21_0, iter_21_1 in pairs(playermodel.items) do
			if iter_21_1.itemtype == kITEM_COMPONENT then
				var_21_1 = iter_21_0
			end
		end

		local var_21_2 = ItemSprite:createBigWithEntityId(var_21_1)

		var_21_2:setName("itemsp")
		var_21_2:setPositionX(var_21_0:getContentSize().width / 2)
		var_21_2:setPositionY(var_21_0:getContentSize().height / 2)
		var_21_0:addChild(var_21_2)

		local var_21_3 = ccui.ImageView:create("pop_component_strengthen_layer/select_frame.png", var_0_0)

		var_21_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_21_3:setPositionX(var_21_0:getContentSize().width / 2)
		var_21_3:setPositionY(var_21_0:getContentSize().height / 2)
		var_21_3:setVisible(true)
		var_21_3:setName("selectFrame")
		var_21_0:addChild(var_21_3)

		local var_21_4 = ccui.ImageView:create("public/box/new_item_bg_on.png", var_0_0)

		var_21_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_21_4:setPositionX(var_21_0:getContentSize().width / 2)
		var_21_4:setPositionY(var_21_0:getContentSize().height / 2)
		var_21_4:setVisible(false)
		var_21_4:setName("bgOn")
		var_21_0:addChild(var_21_4)

		local var_21_5 = ccui.ImageView:create("public/box/new_item_bg_cancle.png", var_0_0)

		var_21_5:setAnchorPoint(cc.p(0, 1))
		var_21_5:setPositionY(var_21_4:getContentSize().height)
		var_21_5:setVisible(true)
		var_21_5:setName("minus")
		var_21_5:setTouchEnabled(true)
		var_21_4:addChild(var_21_5)

		local var_21_6 = cc.Label:createWithTTF("0", "fonts/newkj.ttf", 20)

		var_21_6:setAnchorPoint(cc.p(0.5, 1))
		var_21_6:setPosition(var_21_4:getContentSize().width - 30, var_21_4:getContentSize().height - 3)
		var_21_6:setColor(cc.c3b(73, 58, 68))
		var_21_6:setVisible(true)
		var_21_6:setName("label_num")
		var_21_4:addChild(var_21_6)

		function var_21_0:update(arg_23_1)
			self.entityid = arg_23_1

			self:getChildByName("itemsp"):updateBigInfo(self.is_show_attribute, arg_23_1)

			if self.entityid == 5100002 then
				self:getChildByName("selectFrame"):setVisible(false)

				if self.curSelectComponent[self.entityid] then
					self:getChildByName("bgOn"):setVisible(true)
					self:getChildByName("bgOn"):getChildByName("label_num"):setString(self.curSelectComponent[self.entityid].num)
				else
					self:getChildByName("bgOn"):setVisible(false)
				end

				self:getChildByName("bgOn"):getChildByName("minus"):addTouchEventListener(function(arg_24_0, arg_24_1)
					if arg_24_1 ~= ccui.TouchEventType.ended then
						return
					end

					self.curSelectComponent[self.entityid].num = self.curSelectComponent[self.entityid].num - 1

					if self.curSelectComponent[self.entityid].num == 0 then
						self.curSelectComponent[self.entityid] = nil

						self:getChildByName("bgOn"):setVisible(false)
					else
						self:getChildByName("bgOn"):getChildByName("label_num"):setString(self.curSelectComponent[self.entityid].num)
					end

					self:updateData()
					self:updateUI()
				end)
			else
				self:getChildByName("selectFrame"):setVisible(self.curSelectComponent[self.entityid] and true or false)
				self:getChildByName("bgOn"):setVisible(false)
			end
		end

		return var_21_0
	end

	self.tableview:registerScriptHandler(function(arg_25_0, arg_25_1)
		local var_25_0 = arg_25_0:dequeueCell()

		if not var_25_0 then
			var_25_0 = cc.TableViewCell:create()

			for iter_25_0 = 1, 5 do
				local var_25_1 = var_19_0()

				var_25_1:setAnchorPoint(cc.p(0.5, 0.5))
				var_25_1:setPosition(var_0_24[iter_25_0])
				var_25_1:setScale(var_0_25)
				var_25_1:setName("sp_" .. iter_25_0)
				var_25_0:addChild(var_25_1)
				var_25_1:setVisible(true)

				if self.componentList[arg_25_1 * 5 + iter_25_0] then
					var_25_1:update(self.componentList[arg_25_1 * 5 + iter_25_0])
				else
					var_25_1:setVisible(false)
				end
			end
		else
			for iter_25_1 = 1, 5 do
				local var_25_2 = var_25_0:getChildByName("sp_" .. iter_25_1)

				var_25_2:setVisible(true)

				if self.componentList[arg_25_1 * 5 + iter_25_1] then
					var_25_2:update(self.componentList[arg_25_1 * 5 + iter_25_1])
				else
					var_25_2:setVisible(false)
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

function PopComponentReinforceLayer:updateShowingCells()
	local var_27_0, var_27_1 = GetTableViewShowCellIdx(self.tableview, {
		maxcount = self:getComponentListLen(),
		cellsize = cc.size(var_0_22, var_0_23)
	})

	for iter_27_0 = var_27_0, var_27_1 do
		self.tableview:updateCellAtIndex(iter_27_0)
	end
end

function PopComponentReinforceLayer:getComponentListLen()
	return math.ceil(#self.componentList / 5)
end

function PopComponentReinforceLayer.getStrengthenHandel(arg_29_0)
	return function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_30_0:isBright() then
			return
		end

		arg_30_0:setBright(false)

		local var_30_0 = {}

		for iter_30_0, iter_30_1 in pairs(arg_29_0.curSelectComponent) do
			table.insert(var_30_0, iter_30_1)
		end

		component_manager:set_reinforce_component(arg_29_0.servantid, var_30_0, function(arg_31_0)
			if arg_31_0.result == 1 then
				arg_29_0.reinforce_component = arg_31_0.reinforce_component
				arg_29_0.curSelectComponent = {}

				arg_29_0.bagManager:update()
				arg_29_0:updateData()
				arg_29_0.tableview:reloadData()
				arg_29_0:updateUI()
				arg_29_0:showEffect()
			end

			arg_30_0:setBright(true)
		end)
	end
end

function PopComponentReinforceLayer.getAutoSelectHanel(arg_32_0)
	return function(arg_33_0, arg_33_1)
		if arg_33_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_32_0.curSelectComponent = {}

		local var_33_0 = 0

		for iter_33_0, iter_33_1 in pairs(arg_32_0.componentList) do
			if arg_32_0.needExp <= var_33_0 then
				break
			end

			if iter_33_1 == 5100002 then
				for iter_33_2 = 1, playermodel.items[iter_33_1].number do
					if not arg_32_0.curSelectComponent[iter_33_1] then
						arg_32_0.curSelectComponent[iter_33_1] = {}
						arg_32_0.curSelectComponent[iter_33_1].entityid = iter_33_1
					end

					arg_32_0.curSelectComponent[iter_33_1].num = iter_33_2

					if arg_32_0.needExp <= iter_33_2 * 100 + var_33_0 then
						var_33_0 = iter_33_2 * 100 + var_33_0

						break
					end

					if iter_33_2 == playermodel.items[iter_33_1].number then
						var_33_0 = iter_33_2 * 100 + var_33_0
					end
				end
			else
				var_33_0 = var_33_0 + component_manager:getComponentMaterialExp({
					iter_33_1
				})
				arg_32_0.curSelectComponent[iter_33_1] = iter_33_1
			end
		end

		arg_32_0:updateData()
		arg_32_0:updateUI()
	end
end

function PopComponentReinforceLayer:updateUI()
	self.giveExp = component_manager:getComponentMaterialExp(self.curSelectComponent)
	self.giveExp = math.min(self.giveExp, self.needExp)

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_exp"):setString(self.giveExp .. "/" .. self.needExp)
	ccui.Helper:seekWidgetByName(self.rootLayer, "ProgressBar_cur"):setPercent(math.floor(self.giveExp / self.needExp * 100))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_costgold"):setString(component_effect_data[self.effect].gold_up_exp or 0)
	self:updateShowingCells()

	if self.reinforce_component == 0 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_skillname1"):setString(split(component_effect_data[self.effect].intro, "：")[1] .. "：")
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_skillname2"):setString(split(component_effect_data[self.effect].intro_up, "：")[1] .. "：")
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_needexp"):setString(L_COMPONENT[6])
		ccui.Helper:seekWidgetByName(self.rootLayer, "ProgressBar_cur"):setPercent(100)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_exp"):setString(L_MAX_LEVLE)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_auotselect"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_reinforced"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_skilldes2_bg"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_reinforce"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_skillname1"):setString(split(component_effect_data[self.effect].intro_up, "：")[1] .. "：")
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_skilldes1"):setString(split(component_effect_data[self.effect].intro_up, "：")[2])
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_skillname2"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_skilldes2"):setVisible(false)
	end

	;(function()
		local var_35_0 = {
			self.filterBtn1,
			[11] = self.filterBtn2,
			[3] = self.filterBtn3,
			[13] = self.filterBtn4
		}

		for iter_35_0, iter_35_1 in pairs(var_35_0) do
			iter_35_1:loadTexture("public/button/top_btn_no.png", var_0_0)
		end

		if var_35_0[tonumber(self.curSortOrders .. self.sortType)] then
			var_35_0[tonumber(self.curSortOrders .. self.sortType)]:loadTexture("public/button/top_btn_on.png", var_0_0)
		end
	end)()
end

function PopComponentReinforceLayer:showEffect(...)
	local var_36_0 = L2Skeleton:create("spine/ui/component_reinforce/juhe.json", "spine/ui/component_reinforce/juhe.atlas")

	var_36_0:refreshSkeleton()
	var_36_0.skeletonAnimation:setPosition(cc.p(320, 600))
	var_36_0:play("1", false)
	self.rootLayer:addChild(var_36_0)
end

function PopComponentReinforceLayer:initBg(arg_37_1)
	local var_37_0 = ccui.Layout:create()

	var_37_0:setTouchEnabled(true)
	var_37_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_37_0:setAnchorPoint(cc.p(0, 0))
	var_37_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_37_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_37_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_37_0:setOpacity(0)
	self:addChild(var_37_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_38_0)
		self:addChild(arg_38_0, -2)
		arg_38_0:setPositionY(arg_38_0:getPositionY() - GameDisplay.fix_y)

		local var_38_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_38_0:setAnchorPoint(cc.p(0, 0))
		var_38_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_38_0, -1)
		self:init(arg_37_1)
		var_37_0:setOpacity(102)
		var_37_0:setTouchEnabled(false)
	end)
end

function PopComponentReinforceLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

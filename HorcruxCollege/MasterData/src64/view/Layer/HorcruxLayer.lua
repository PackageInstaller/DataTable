HorcruxLayer = class("HorcruxLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = ITEMDATA
local diamond_update_data = require("data.diamond_update_data")
local horcrux_data = require("data.horcrux_data")

require("view.Sprite.HorcruxSprite")
require("view.Sprite.FilterSprite")
require("view.Sprite.FilterListSprite")

local FilterHorcurxSelectSprite = require("view.Sprite.FilterHorcurxSelectSprite")
local playermodel = require("model.playermodel")
local horcrux_manager = require("controller.horcrux_manager")
local item_manager = require("controller.item_manager")
local bag_manager = require("controller.bag_manager")
local filter_config_manager = require("controller.filter_config_manager")
local alert_manager = require("controller.alert_manager")
local array_manager = require("controller.array_manager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_12 = config._DEBUG and 0 or 1
local var_0_13
local var_0_15 = 1
local var_0_16 = true
local var_0_17 = false
local var_0_18 = 1
local var_0_19 = 2

function HorcruxLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = HorcruxLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function HorcruxLayer.getInstance()
	return var_0_13
end

function HorcruxLayer.ctor(arg_5_0)
	arg_5_0.isShowVaule = true
	arg_5_0.curFilters = {}
	arg_5_0.curSortOrders = 1
	arg_5_0.curShowMode = var_0_18
	arg_5_0.curIndex = nil
	arg_5_0.selectedDecomposeTbl = {}
end

function HorcruxLayer:init(arg_6_1)
	var_0_13 = self

	if arg_6_1 then
		self.exitCallback = arg_6_1.exitCallback
	end

	self.rootLayer = cc.Layer:create()

	self:addChild(self.rootLayer)

	self.selectTblAni = true

	self:initFilterPanel()

	self.dataMgr = bag_manager:create()

	self.dataMgr:generate_bag_data(self.filterTbl)
	self:initBottomList()
	self:initHorcruxListPanel()
	self:updateListEmpty()
	self:initDisplay(self.rootLayer)
	self:updateBottomList()
	self:updateDisplayBtn()

	self.selectTblAni = false

	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			self.dataMgr = nil
			var_0_17 = false
			var_0_13 = nil

			if self.filterSpritePop then
				self.filterSpritePop:runAction(cc.RemoveSelf:create())

				self.filterSpritePop = nil
			end

			self:openAllNewHorcrux()
			item_manager:checkBagFullAlert()
		end
	end)
end

function HorcruxLayer:deleteBagData(arg_8_1)
	if arg_8_1 then
		self:saveDecomposeBeforeShowingCells()

		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs(arg_8_1) do
			table.insert(var_8_0, iter_8_1)
		end

		for iter_8_2, iter_8_3 in pairs(var_8_0) do
			self.dataMgr:deleteItems(iter_8_3)
		end
	end
end

function HorcruxLayer:initFilterPanel()
	self.filterAniFlag = true
	self.filterAniFlag1 = false
	self.filterPopModel = false
	self.filterTbl = filter_config_manager:getDefaultFilterData(filter_config_manager.HORCRUX_LAYER, self.curSortOrders)
	self.curSort = self.filterTbl.sortType

	self:createFilterList()

	self.filterListData = self.filterList:getFilterData()
	self.filterPanel = ccui.ImageView:create("HorcruxLayer/filter_bg.png", var_0_12)

	self.filterPanel:setTouchEnabled(true)
	self.filterPanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.filterPanel:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, 80 - GameDisplay.fix_y))
	self.rootLayer:addChild(self.filterPanel, 10)

	self.filterReturnBtn = ccui.Button:create("HorcruxLayer/btn_return.png", nil, "HorcruxLayer/btn_return.png", var_0_12)

	self.filterReturnBtn:setPosition(cc.p(70, self.filterPanel:getContentSize().height - self.filterReturnBtn:getContentSize().height / 2 - 10))
	self.filterReturnBtn:setVisible(false)
	self.filterReturnBtn:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.curShowMode = var_0_18

		self:cleanDecomposeData()
		self:updateBottomList()
		self:updateShowingCells()
	end)
	self.filterPanel:addChild(self.filterReturnBtn, 10)

	self.decomposeBtn = ccui.Button:create("HorcruxLayer/btn_decompose.png", nil, "HorcruxLayer/btn_decompose.png", var_0_12)

	self.decomposeBtn:setPosition(cc.p(447, self.filterPanel:getContentSize().height - self.decomposeBtn:getContentSize().height / 2 - 10))
	self.decomposeBtn:addTouchEventListener(self:generateDecomposeHandler())
	self.filterPanel:addChild(self.decomposeBtn)

	self.filterButton = ccui.Button:create("HorcruxLayer/btn_filter.png", nil, "HorcruxLayer/btn_filter.png", var_0_12)

	self.filterButton:setPositionX(570)
	self.filterButton:setPositionY(self.filterPanel:getContentSize().height - self.filterButton:getContentSize().height / 2 - 10)
	self.filterPanel:addChild(self.filterButton, 5)
	self.filterButton:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.filterAniFlag then
			return
		end

		self.filterAniFlag = false

		self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
			self.filterAniFlag = true
			self.filterAniFlag1 = true
		end)))

		if self.curShowMode == var_0_18 then
			self:showFilterPop()
		else
			self:showFilterDecompose()
		end
	end)

	self.imgCount = ccui.ImageView:create("HorcruxLayer/selected_bg.png", var_0_12)

	self.imgCount:setPositionX(self.decomposeBtn:getPositionX() - self.decomposeBtn:getContentSize().width - 60)
	self.imgCount:setPositionY(self.filterPanel:getContentSize().height - self.imgCount:getContentSize().height / 2 - 15)
	self.filterPanel:addChild(self.imgCount)

	local var_9_0 = {
		fontSize = 24,
		distanceFieldEnabled = false,
		outlineSize = 0,
		glyphs = 1,
		fontFilePath = "fonts/newkj.ttf",
		customGlyphs = ""
	}

	self.labelSelect = cc.Label:create()

	self.labelSelect:setString("已选中：")
	self.labelSelect:setTTFConfig(var_9_0)
	self.labelSelect:setAlignment(cc.TEXT_ALIGNMENT_LEFT, cc.TEXT_ALIGNMENT_CENTER)
	self.labelSelect:setAnchorPoint(0, 0.5)
	self.labelSelect:setPosition(15, self.imgCount:getContentSize().height / 2)
	self.imgCount:addChild(self.labelSelect)

	self.labelCurSelect = cc.Label:create()

	self.labelCurSelect:setString("0")
	self.labelCurSelect:setTTFConfig(var_9_0)
	self.labelCurSelect:setColor(cc.c3b(255, 216, 124))
	self.labelCurSelect:setAlignment(cc.TEXT_ALIGNMENT_LEFT, cc.TEXT_ALIGNMENT_CENTER)
	self.labelCurSelect:setAnchorPoint(0, 0.5)
	self.labelCurSelect:setPosition(self.labelSelect:getPositionX() + self.labelSelect:getContentSize().width, self.imgCount:getContentSize().height / 2)
	self.imgCount:addChild(self.labelCurSelect)

	self.labelTotal = cc.Label:create()

	self.labelTotal:setString("/100")
	self.labelTotal:setTTFConfig(var_9_0)
	self.labelTotal:setAlignment(cc.TEXT_ALIGNMENT_LEFT, cc.TEXT_ALIGNMENT_CENTER)
	self.labelTotal:setAnchorPoint(0, 0.5)
	self.labelTotal:setPosition(self.labelCurSelect:getContentSize().width + self.labelCurSelect:getPositionX(), self.imgCount:getContentSize().height / 2)
	self.imgCount:addChild(self.labelTotal)
	self.imgCount:setVisible(false)
end

function HorcruxLayer:showFilterPop()
	local var_13_0 = self.filterListData.col
	local var_13_1 = {}

	if not self.filterListData.filterValue then
		if self.filterList:getTouchFlag() then
			for iter_13_0, iter_13_1 in pairs(self.filterListData.btnState) do
				var_13_1[iter_13_0] = 0
			end

			self.filterList:setTouchFlag(false)
		end
	else
		for iter_13_2, iter_13_3 in pairs(self.filterListData.btnState) do
			var_13_1[iter_13_2] = iter_13_3 == 1 and -2 or -1
		end
	end

	local var_13_2 = 1
	local var_13_3 = {
		{
			0
		},
		{
			0
		}
	}

	var_13_3 = self.curSortOrders == var_0_15 and {
		1,
		0
	} or {
		0,
		1
	}

	if self.filterSpritePop == nil then
		self.filterSpritePop = self:createFilterPop()

		global_basic_scene:addChild(self.filterSpritePop, 1000)
	end

	self.filterSpritePop:setFilterBtnState(var_13_0, var_13_1)
	self.filterSpritePop:setSortOrderState(var_13_2, var_13_3)
	self.filterSpritePop:updateAllFilterBtn()
	self.filterSpritePop:playPopAni()
	self:updateTitleBottom(2)
end

function HorcruxLayer:createFilterList()
	self.filterList = FilterListSprite:create({
		defaultSelected = 1,
		style = "style_horcrux_bag",
		bagLayerType = filter_config_manager.HORCRUX_LAYER,
		filterCallback = function(self)
			self.selectTblAni = true
			self.filterTbl.filterConfig[self.filterKey] = {
				self.filterValue
			}
			self.filterListData = self

			self.dataMgr:generate_bag_data(self.filterTbl)
			self:cleanDecomposeData()
			self:updateBottomList()
			self.listPanel:reloadData()
			self:updateListEmpty()

			self.selectTblAni = false
		end
	})

	self.filterList:setAnchorPoint(cc.p(0, 1))
	self.filterList:setPositionX(0)
	self.filterList:setName("filterList")
	self.rootLayer:addChild(self.filterList, -10)
end

function HorcruxLayer:updateTitleBottom(arg_16_1)
	if self.filterPopModel == false and arg_16_1 == 2 or self.filterPopModel == true and arg_16_1 == 1 then
		self.filterPopModel = not self.filterPopModel

		if arg_16_1 == 1 then
			self.filterButton:loadTextures("HorcruxLayer/btn_filter.png", "HorcruxLayer/btn_filter.png", nil, var_0_12)
		else
			self.filterButton:loadTextures("HorcruxLayer/btn_filter.png", "HorcruxLayer/btn_filter.png", nil, var_0_12)
		end

		self:changeDecomposeUI()
	end
end

function HorcruxLayer:sortCallback()
	self.curSortOrders = 1 - self.curSortOrders

	self.dataMgr:generate_bag_data(self.filterTbl)
	self:cleanDecomposeData()
	self:updateBottomList()
	self:updateShowingCells()
end

function HorcruxLayer:filterCallback(arg_18_1)
	self.filterTbl.sortType = arg_18_1.sortType or self.filterTbl

	for iter_18_0, iter_18_1 in pairs(arg_18_1.filterConfig) do
		self.filterTbl.filterConfig[iter_18_0] = global_deepCopy(iter_18_1)
	end

	self.curSort = self.filterTbl.sortType

	self.dataMgr:generate_bag_data(self.filterTbl)
	self:cleanDecomposeData()
	self:updateBottomList()
	self.listPanel:reloadData()
	self:updateListEmpty()
end

function HorcruxLayer:createFilterPop()
	local var_19_0 = {}
	local var_19_1 = false

	for iter_19_0, iter_19_1 in pairs(self.filterListData.btnState) do
		if iter_19_1 == 1 then
			var_19_1 = true
		end
	end

	for iter_19_2, iter_19_3 in pairs(self.filterListData.btnState) do
		var_19_0[iter_19_2] = var_19_1 and (iter_19_3 == 1 and -2 or -1) or iter_19_3
	end

	return (FilterHorcurxSelectSprite:create({
		filterType = filter_config_manager.HORCRUX_LAYER,
		filterCallback = function(arg_20_0)
			self:filterCallback(arg_20_0)
		end,
		maskTouchCallback = function(arg_21_0)
			if self.filterAniFlag1 then
				self.filterAniFlag1 = false

				self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
					self.filterAniFlag1 = true
					self.filterAniFlag = true
				end)))
				self:updateTitleBottom(1)
				arg_21_0()
			end
		end,
		sortOrderChangeCallback = function(arg_23_0)
			self:sortCallback(arg_23_0)
		end,
		initButtonConfig = {
			[self.filterListData.col] = var_19_0
		},
		defaultSortOrder = self.curSortOrders
	}))
end

function HorcruxLayer:reSortOrder()
	self.curSortOrders = 1 - self.curSortOrders
end

function HorcruxLayer.initBottomList(arg_25_0)
	return
end

function HorcruxLayer:updateBottomList()
	if self.curShowMode == var_0_18 then
		self.filterReturnBtn:setVisible(false)
		self.decomposeBtn:loadTextures("HorcruxLayer/btn_decompose.png", nil, "HorcruxLayer/btn_decompose.png", var_0_12)
	else
		self.filterReturnBtn:setVisible(true)

		if next(self.selectedDecomposeTbl) then
			self.decomposeBtn:loadTextures("HorcruxLayer/btn_decompose_sure.png", nil, "HorcruxLayer/btn_decompose_sure.png", var_0_12)
		else
			self.decomposeBtn:loadTextures("HorcruxLayer/btn_decompose.png", nil, "HorcruxLayer/btn_decompose.png", var_0_12)
		end
	end

	self:changeDecomposeUI()
end

function HorcruxLayer.generateDecomposeHandler(arg_27_0)
	return function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_27_0.curShowMode == var_0_18 then
			arg_27_0.curShowMode = var_0_19

			arg_27_0:updateShowingCells()
			arg_27_0:updateBottomList()
		else
			if not next(arg_27_0.selectedDecomposeTbl) then
				-- block empty
			end

			local function var_28_0(arg_29_0, arg_29_1)
				local var_29_0 = {}

				for iter_29_0, iter_29_1 in pairs(arg_27_0.selectedDecomposeTbl) do
					table.insert(var_29_0, iter_29_1)
				end

				horcrux_manager:decomposeHorcruxBatch(var_29_0, function(arg_30_0)
					if arg_30_0 == 1 then
						arg_27_0:saveDecomposeBeforeShowingCells()
						arg_27_0.dataMgr:deleteItems(var_29_0)
						arg_27_0:cleanDecomposeData()
						arg_27_0:updateBottomList()
						arg_27_0.listPanel:reloadData()
						arg_27_0.listPanel:scrollToIndex(math.min(arg_27_0.dataMgr:getDataCount() - 1, arg_27_0.curIndex or 0))
					elseif arg_30_0 == 3 then
						global_ShowBlockWords(L_DECOMPOSE_EXIST_UNMATCH_HORCRUX)
					elseif arg_30_0 == 5 then
						global_ShowBlockWords(L_DECOMPOSE_NULL_HORCRUX)
					end
				end)
			end

			if (function()
				local var_32_0 = 0

				for iter_32_0, iter_32_1 in pairs(arg_27_0.selectedDecomposeTbl) do
					if horcrux_data[playermodel.items[iter_32_1].itemid].rarity > 3 then
						var_32_0 = var_32_0 + 1

						break
					end
				end

				return var_32_0 > 0
			end)() then
				LayerManager:pushInLayer("PopDoLayer", {
					labels = {
						isHorizonalCenter = true,
						title = "分解确认",
						des = "确认分解稀有品质魂器",
						button = L_BATTLEPASS_BUY.button
					},
					surecallback = var_28_0
				})
			else
				var_28_0()
			end
		end
	end
end

local var_0_22 = 576
local var_0_23 = 850
local var_0_24 = 50
local var_0_25 = 160
local var_0_26 = 556
local var_0_27 = 147
local var_0_28 = {
	(cc.p(35, 0))
}
local var_0_29 = {
	cc.p(220, -7),
	cc.p(0, -7)
}
local var_0_30 = 1

function HorcruxLayer:initHorcruxListPanel()
	local var_33_0 = var_0_23 + GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT

	self.listPanel = cc.TableView:create(cc.size(var_0_22, var_33_0))
	self.listPanel.displayheight = var_33_0

	self.listPanel:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.listPanel:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.listPanel:setPosition(cc.p(var_0_24, var_0_25))
	self.listPanel:setDelegate()

	self.listPanel.anchorPoint = cc.p(0, 0)

	self.listPanel:setName("listPanel")
	self.rootLayer:addChild(self.listPanel)
	self.listPanel:registerScriptHandler(function(arg_34_0, arg_34_1)
		return var_0_26, var_0_27
	end, cc.TABLECELL_SIZE_FOR_INDEX)

	local function var_33_1(arg_35_0)
		self:saveDecomposeBeforeShowingCells()
		LayerManager:pushInLayer("HorcruxInfoLayer", arg_35_0.entityid, "horcruxlayer")

		self.curIndex = arg_35_0.index
	end

	local function var_33_2(arg_36_0)
		self.curIndex = arg_36_0.index

		if playermodel.items[arg_36_0.entityid].horcrux_attr.lock then
			global_ShowBlockWords(L_HORCRUC_STATE[1])
		elseif playermodel.items[arg_36_0.entityid].horcrux_attr.fighting then
			global_ShowBlockWords(L_HORCRUC_STATE[2])
		elseif playermodel.items[arg_36_0.entityid].horcrux_attr.working then
			global_ShowBlockWords(L_HORCRUC_STATE[3])
		else
			if self.selectedDecomposeTbl[arg_36_0.entityid] then
				self.selectedDecomposeTbl[arg_36_0.entityid] = nil
			else
				self.selectedDecomposeTbl[arg_36_0.entityid] = arg_36_0.entityid
			end

			self:updateShowingCells()
		end
	end

	local function var_33_3(arg_37_0, arg_37_1)
		if arg_37_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_37_0:getTouchBeganPosition().y - arg_37_0:getTouchEndPosition().y) > 50 then
			return
		end

		if not arg_37_0.entityid then
			return
		end

		if self.curShowMode == var_0_18 then
			var_33_1(arg_37_0)
		elseif self.curShowMode == var_0_19 then
			var_33_2(arg_37_0)
		end

		self:updateBottomList()
	end

	local function var_33_4(arg_38_0, arg_38_1)
		if arg_38_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_38_1 = arg_38_0:getParent().entityid

		if not arg_38_0:getParent().entityid then
			return
		end

		if not playermodel.items[arg_38_0:getParent().entityid].horcrux_attr.lock then
			return
		end

		horcrux_manager:switchLockStatus(arg_38_0:getParent().entityid, function(arg_39_0)
			if arg_39_0 == 2 then
				global_ShowBlockWords(L_HORCRUX_TOUCH_MSG.Hasowner)
			end

			if horcrux_manager:isHorcruxLocked(var_38_1) then
				return
			end

			global_ShowBlockWords(L_HORCRUX_TOUCH_MSG.Unlock)
			self:updateItemAttr(var_38_1, {
				value = false,
				key = "lock"
			})
			self:updateShowingCells()
		end)
	end

	local function var_33_5(arg_40_0)
		if self.curSortOrders == 1 then
			return arg_40_0
		else
			return self.dataMgr:getDataCount() + 1 - arg_40_0
		end
	end

	self.listPanel:registerScriptHandler(function(arg_41_0, arg_41_1)
		local var_41_0 = arg_41_0:dequeueCell()

		if not var_41_0 then
			var_41_0 = cc.TableViewCell:create()

			var_41_0:setName("cell_" .. arg_41_1)

			local var_41_2 = 1
			local var_41_3 = HorcruxSprite:create({
				initType = "detailedStyle"
			})

			var_41_3:registerSkillTouchCallback(function()
				self.isShowSkillDes = true
			end)
			var_41_3:setSwallowTouches(false)
			var_41_3:setName("sp_" .. var_41_2)
			var_41_3:setPosition(var_0_28[var_41_2])

			var_41_3.orginPosX = var_0_28[var_41_2].x

			var_41_3:setScale(var_0_30)
			var_41_0:addChild(var_41_3)
			var_41_3:addTouchEventListener(var_33_3)
			var_41_3:getChildByName("hookFrame"):addTouchEventListener(var_33_3)

			local var_41_4 = var_41_3:getChildByName("lock")

			var_41_4:setTouchEnabled(true)
			var_41_4:addTouchEventListener(var_33_4)

			local var_41_5 = var_33_5(arg_41_1 + var_41_2)
			local var_41_6 = self.dataMgr:dequeueItem(var_41_5)

			if var_41_6 then
				var_41_3:updateHorcruxInfos(var_41_6, self.isShowVaule)

				var_41_3.entityid = var_41_6
				var_41_3.index = arg_41_1
				var_41_3.horcruxindex = var_41_5
				var_41_3:getChildByName("hookFrame").index = arg_41_1
				var_41_3:getChildByName("hookFrame").entityid = var_41_6

				var_41_3:setShowMode(self.curShowMode, self.selectedDecomposeTbl[var_41_0:getChildByName("sp_" .. var_41_2).entityid] and true or false, var_41_6)
			else
				var_41_3.entityid = nil
				var_41_3.index = nil
				var_41_3.horcruxindex = nil

				var_41_3:setVisible(false)

				var_41_3:getChildByName("hookFrame").index = nil
				var_41_3:getChildByName("hookFrame").entityid = nil
			end
		else
			local var_41_7 = 1
			local var_41_8 = var_41_0:getChildByName("sp_" .. 1)
			local var_41_9 = var_33_5(arg_41_1 + 1)
			local var_41_10 = self.dataMgr:dequeueItem(var_41_9)

			print("BBBBBBBBBBBBBB")
			print("entityid", var_41_10)

			if var_41_10 then
				var_41_8:updateHorcruxInfos(var_41_10, self.isShowVaule)

				var_41_8.entityid = var_41_10
				var_41_8.index = arg_41_1
				var_41_8.horcruxindex = var_41_9

				var_41_8:setVisible(true)
				var_41_8:setPosition(var_0_28[var_41_7])
				var_41_8:setSkillDesPanelVisible(false)

				var_41_8:getChildByName("hookFrame").entityid = var_41_10
				var_41_8:getChildByName("hookFrame").index = arg_41_1

				var_41_8:setShowMode(self.curShowMode, self.selectedDecomposeTbl[var_41_0:getChildByName("sp_" .. var_41_7).entityid] and true or false, var_41_10)
			else
				var_41_8.entityid = nil
				var_41_8.index = nil
				var_41_8.horcruxindex = nil

				var_41_8:setVisible(false)

				var_41_8:getChildByName("hookFrame").index = nil
				var_41_8:getChildByName("hookFrame").entityid = nil
			end
		end

		local var_41_11 = 1

		if self.selectTblAni then
			local var_41_12 = LAYER_OUT_TIME / math.ceil(var_33_0 / var_0_27) * 1.5

			if var_41_0:getChildByName("sp_" .. var_41_11) then
				var_41_0:getChildByName("sp_" .. var_41_11):setOpacity(0)
				var_41_0:getChildByName("sp_" .. var_41_11):setArrayFontDefaultVisible(false)
				var_41_0:getChildByName("sp_" .. var_41_11):runAction(cc.Sequence:create(cc.DelayTime:create(arg_41_1 * var_41_12), cc.FadeIn:create(var_41_12), cc.CallFunc:create(function()
					var_41_0:getChildByName("sp_" .. var_41_11):setArrayFontDefaultVisible(true)
				end)))
			end
		elseif var_41_0:getChildByName("sp_" .. var_41_11) then
			var_41_0:getChildByName("sp_" .. var_41_11):setOpacity(255)
			var_41_0:getChildByName("sp_" .. var_41_11):setArrayFontDefaultVisible(true)
		end

		return var_41_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.listPanel:registerScriptHandler(function(arg_44_0, arg_44_1)
		return self.oldCellCount or self:getHorcruxListLen()
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.listPanel:registerScriptHandler(function(arg_45_0)
		if self.isShowSkillDes then
			self.isShowSkillDes = false

			self:updateShowingCells()
		end
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	self.listPanel:reloadData()
end

function HorcruxLayer:getHorcruxListLen()
	local var_46_0 = self.dataMgr:getDataCount()

	if var_46_0 < 5 then
		var_46_0 = 5
	end

	return var_46_0
end

function HorcruxLayer:saveDecomposeBeforeShowingCells(arg_47_1)
	self.oldCellCount = self:getHorcruxListLen()

	local var_47_0 = {
		cellsize = cc.size(var_0_26, var_0_27)
	}

	var_47_0.maxcount = arg_47_1 and arg_47_1 or self:getHorcruxListLen()
	self.oldStartidx, self.oldEndidx = GetTableViewShowCellIdx(self.listPanel, var_47_0)
end

function HorcruxLayer:updateDecomposeAfterShowingCells()
	for iter_48_0 = self.oldStartidx, self.oldEndidx do
		self.listPanel:updateCellAtIndex(iter_48_0)
	end

	self:updateListEmpty()

	self.oldCellCount = nil
end

function HorcruxLayer:updateShowingCells(arg_49_1)
	local var_49_0 = {
		cellsize = cc.size(var_0_26, var_0_27)
	}

	var_49_0.maxcount = arg_49_1 and arg_49_1 or self:getHorcruxListLen()

	local var_49_1, var_49_2 = GetTableViewShowCellIdx(self.listPanel, var_49_0)

	for iter_49_0 = var_49_1, var_49_2 do
		self.listPanel:updateCellAtIndex(iter_49_0)
	end

	self:updateSelectCount()
end

function HorcruxLayer:updateItemAttr(arg_50_1, arg_50_2)
	return self.dataMgr:updateItemAttr(arg_50_1, arg_50_2)
end

function HorcruxLayer:updateItemsData()
	self.dataMgr:update()
	self.dataMgr:generate_bag_data(self.filterTbl)
end

function HorcruxLayer:deleteItems(arg_52_1)
	self.dataMgr:deleteItems(arg_52_1)
end

function HorcruxLayer:cleanDecomposeData()
	self.selectedDecomposeTbl = {}

	self:updateSelectCount()
end

function HorcruxLayer:updateListEmpty()
	if not self.emptyImg then
		self.emptyImg = ccui.ImageView:create("HorcruxLayer/empty.png", var_0_12)

		self.emptyImg:setAnchorPoint(cc.p(0.5, 0.5))
		self.emptyImg:setPosition(cc.p(340, 650))
		self.rootLayer:addChild(self.emptyImg, 200)

		self.emptyGainBtn = ccui.Button:create("public/button/gain.png", nil, "public/button/gain.png", var_0_12)

		self.emptyGainBtn:setPosition(cc.p(340, 650))
		self.emptyGainBtn:setAnchorPoint(cc.p(0.5, 0.5))
		self.rootLayer:addChild(self.emptyGainBtn, 200)
		self.emptyGainBtn:addTouchEventListener(function(arg_55_0, arg_55_1)
			if arg_55_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopGoGainLayer", {
				item = "horcrux",
				goto_back_system_id = 520
			})
		end)
	end

	self.emptyImg:setVisible(self.dataMgr:getDataCount() == 0)
	self.emptyGainBtn:setVisible(self.dataMgr:getDataCount() == 0)
end

function HorcruxLayer.openAllNewHorcrux(arg_56_0)
	for iter_56_0, iter_56_1 in pairs(playermodel.items) do
		if var_0_0[iter_56_1.itemid].bag_item_type == kITEM_HORCRUX then
			item_manager:playerOpenNewItem(iter_56_0)
		end
	end

	alert_manager:check_new_horcrux(false)
end

function HorcruxLayer:initDisplay(arg_57_1)
	self.displayPos = global_get_node_display_posy(arg_57_1, {
		listPanel = {
			focusName = "listPanel",
			reference = TRANSFORM_REFERENCE.DOWN,
			posY = var_0_25,
			unit = TRANSFORM_UNIT.PX
		},
		filterList = {
			posY = 90,
			focusName = "filterList",
			reference = TRANSFORM_REFERENCE.UP,
			unit = TRANSFORM_UNIT.PX
		}
	})

	for iter_57_0, iter_57_1 in pairs(self.displayPos) do
		local var_57_0 = ccui.Helper:seekWidgetByName(arg_57_1, iter_57_0) or arg_57_1:getChildByName(iter_57_0)

		if var_57_0 then
			var_57_0:setPositionY(iter_57_1)
		end
	end
end

function HorcruxLayer:createFilterDecompose()
	local var_58_0 = {}
	local var_58_1 = false

	for iter_58_0, iter_58_1 in pairs(self.filterListData.btnState) do
		if iter_58_1 == 1 then
			var_58_1 = true
		end
	end

	for iter_58_2, iter_58_3 in pairs(self.filterListData.btnState) do
		var_58_0[iter_58_2] = var_58_1 and (iter_58_3 == 1 and -2 or -1) or iter_58_3
	end

	local var_58_2 = FilterHorcurxSelectSprite:create({
		isDecomposeFilter = true,
		filterType = filter_config_manager.HORCRUX_LAYER,
		filterCallback = function(arg_59_0)
			self:updateDecomposeData(arg_59_0)
		end,
		maskTouchCallback = function(arg_60_0)
			if self.filterAniFlag1 then
				self.filterAniFlag1 = false

				self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
					self.filterAniFlag1 = true
					self.filterAniFlag = true
				end)))
				self:updateTitleBottom(1)
				arg_60_0()
			end
		end,
		sortOrderChangeCallback = function(arg_62_0)
			self:sortCallback(arg_62_0)
		end,
		initButtonConfig = {
			[self.filterListData.col] = var_58_0
		},
		defaultSortOrder = self.curSortOrders
	})
	local var_58_3 = TempWidget:CreateTempLayout(var_58_2._bg)

	var_58_3:setContentSize(cc.size(210, 30))
	var_58_3:align(cc.p(1, 0), GameDisplay.width - 5, -25)
	TempWidget:CreateTempLabel("保留一个重复魂器", FONT_NAME, 20, var_58_3):align(cc.p(0, 0.5), 0, var_58_3:size().h / 2)

	local var_58_4 = TempWidget:CreateTempImg("HorcruxLayer/decompose_unique_bg.png", var_58_3)

	var_58_4:align(cc.p(1, 0.5), var_58_3:size().w - 5, var_58_3:size().h / 2)

	local var_58_5 = TempWidget:CreateTempImg("HorcruxLayer/decompose_unique_check.png", var_58_4)

	var_58_5:center()
	var_58_5:setVisible(var_0_16)
	var_58_3:_addEvent(function()
		var_0_16 = not var_0_16

		var_58_5:setVisible(var_0_16)
		self:updateDecomposeData()
	end, {
		touchDelay = 0.1
	})

	return var_58_2
end

function HorcruxLayer:showFilterDecompose()
	local var_64_0 = self.filterListData.col
	local var_64_1 = {}

	if not self.filterListData.filterValue then
		if self.filterList:getTouchFlag() then
			for iter_64_0, iter_64_1 in pairs(self.filterListData.btnState) do
				var_64_1[iter_64_0] = 0
			end

			self.filterList:setTouchFlag(false)
		end
	else
		for iter_64_2, iter_64_3 in pairs(self.filterListData.btnState) do
			var_64_1[iter_64_2] = iter_64_3 == 1 and -2 or -1
		end
	end

	if self.filterSpriteDecompose then
		self.filterSpriteDecompose:setFilterBtnState(var_64_0, var_64_1)
		self.filterSpriteDecompose:setSortOrderState(1, self.sortOrder == var_0_15 and {
			1,
			0
		} or {
			0,
			1
		})
		self.filterSpriteDecompose:updateAllFilterBtn()
		self.filterSpriteDecompose:playPopAni(true)
	else
		self.filterSpriteDecompose = self:createFilterDecompose()

		global_basic_scene:addChild(self.filterSpriteDecompose, 1000)
	end

	self:updateTitleBottom(2)
end

function HorcruxLayer:updateSelectCount()
	local var_65_0 = 0

	for iter_65_0, iter_65_1 in pairs(self.selectedDecomposeTbl) do
		var_65_0 = var_65_0 + 1
	end

	self.labelCurSelect:setString(var_65_0 .. "")

	if var_65_0 > 99 then
		self.labelSelect:setPositionX(5)
		self.labelCurSelect:setPositionX(91)
	elseif var_65_0 > 9 then
		self.labelCurSelect:setPositionX(self.labelSelect:getPositionX() + self.labelSelect:getContentSize().width - 10)
	else
		self.labelSelect:setPositionX(15)
		self.labelCurSelect:setPositionX(self.labelSelect:getPositionX() + self.labelSelect:getContentSize().width)
	end

	self.labelTotal:setPositionX(self.labelCurSelect:getContentSize().width + self.labelCurSelect:getPositionX())
end

function HorcruxLayer:changeDecomposeUI()
	if self.curShowMode == var_0_18 then
		self.imgCount:setVisible(false)
		self.filterButton:loadTextures("HorcruxLayer/btn_filter.png", "HorcruxLayer/btn_filter.png", "HorcruxLayer/btn_filter.png", var_0_12)
	else
		self.imgCount:setVisible(true)
		self.filterButton:loadTextures("HorcruxLayer/btn_quick_select.png", "HorcruxLayer/btn_quick_select.png", "HorcruxLayer/btn_quick_select.png", var_0_12)
	end
end

function HorcruxLayer:updateDecomposeData(arg_67_1)
	if not arg_67_1 then
		arg_67_1 = self.frontTbl
	else
		self.frontTbl = arg_67_1
	end

	local var_67_0 = 0

	for iter_67_0, iter_67_1 in pairs(arg_67_1.filterConfig) do
		if type(iter_67_1) == "table" and next(iter_67_1) then
			var_67_0 = var_67_0 + 1
		elseif type(iter_67_1) ~= "table" then
			var_67_0 = var_67_0 + 1
		end
	end

	if var_67_0 == 0 then
		self:cleanDecomposeData()
		self:updateBottomList()
		self.listPanel:reloadData()

		return
	end

	local var_67_1 = self.dataMgr.filterData

	local function var_67_2(arg_68_0, arg_68_1)
		for iter_68_0, iter_68_1 in pairs(arg_68_0) do
			if iter_68_1 == arg_68_1 then
				return true
			end
		end

		return false
	end

	local function var_67_3(arg_69_0)
		if not horcrux_data[arg_69_0] or horcrux_data[arg_69_0].select_type == 0 then
			return true
		end

		return false
	end

	local function var_67_4(arg_70_0, arg_70_1)
		if var_0_16 then
			local var_70_0 = item_manager:getItemNumber(arg_70_0)

			if var_70_0 == 1 then
				return true
			elseif arg_70_1[arg_70_0] and var_70_0 - arg_70_1[arg_70_0] <= 1 then
				return true
			end
		end

		return false
	end

	self:cleanDecomposeData()

	local var_67_5 = 0
	local var_67_6 = {}

	for iter_67_2, iter_67_3 in pairs((self.dataMgr:getFilterData(arg_67_1))) do
		if var_67_2(var_67_1, iter_67_3) then
			if var_67_5 == 100 then
				break
			end

			if not playermodel.items[iter_67_3].horcrux_attr.lock and not playermodel.items[iter_67_3].horcrux_attr.fighting and not playermodel.items[iter_67_3].horcrux_attr.working and not var_67_3(playermodel.items[iter_67_3].itemid) and not var_67_4(playermodel.items[iter_67_3].itemid, var_67_6) and not array_manager:isHorcruxInArrayNow(iter_67_3) then
				self.selectedDecomposeTbl[iter_67_3] = iter_67_3
				var_67_5 = var_67_5 + 1
				var_67_6[playermodel.items[iter_67_3].itemid] = var_67_6[playermodel.items[iter_67_3].itemid] or 0
				var_67_6[playermodel.items[iter_67_3].itemid] = var_67_6[playermodel.items[iter_67_3].itemid] + 1
			end
		end
	end

	if var_67_5 ~= 0 then
		self:resortFilterData()
	end

	self:updateBottomList()
	self:updateSelectCount()
	self.listPanel:reloadData()
end

function HorcruxLayer:resortFilterData()
	local var_71_0 = {
		function(arg_72_0, arg_72_1)
			local var_72_0 = self.selectedDecomposeTbl[arg_72_0] and 1 or 0
			local var_72_1 = self.selectedDecomposeTbl[arg_72_1] and 1 or 0

			if (self.selectedDecomposeTbl[arg_72_0] and 1 or 0) == (self.selectedDecomposeTbl[arg_72_1] and 1 or 0) then
				return "=="
			else
				return var_72_0 < var_72_1
			end
		end,
		function(arg_73_0, arg_73_1)
			local var_73_0 = playermodel.items[arg_73_0]
			local var_73_1 = playermodel.items[arg_73_1]

			if playermodel.items[arg_73_0].horcrux_attr.star == playermodel.items[arg_73_1].horcrux_attr.star then
				return "=="
			else
				return var_73_0.horcrux_attr.star > var_73_1.horcrux_attr.star
			end
		end,
		function(arg_74_0, arg_74_1)
			local var_74_0 = playermodel.items[arg_74_0]
			local var_74_1 = playermodel.items[arg_74_1]

			if playermodel.items[arg_74_0].horcrux_attr.hlv == playermodel.items[arg_74_1].horcrux_attr.hlv then
				return "=="
			else
				return var_74_0.horcrux_attr.hlv > var_74_1.horcrux_attr.hlv
			end
		end,
		function(arg_75_0, arg_75_1)
			local var_75_0 = horcrux_data[playermodel.items[arg_75_0].itemid].rarity
			local var_75_1 = horcrux_data[playermodel.items[arg_75_1].itemid].rarity

			if horcrux_data[playermodel.items[arg_75_0].itemid].rarity == horcrux_data[playermodel.items[arg_75_1].itemid].rarity then
				return "=="
			else
				return var_75_1 < var_75_0
			end
		end,
		function(arg_76_0, arg_76_1)
			local var_76_0 = playermodel.items[arg_76_0]
			local var_76_1 = playermodel.items[arg_76_1]

			if playermodel.items[arg_76_0].horcrux_attr.dfac == playermodel.items[arg_76_1].horcrux_attr.dfac then
				return "=="
			else
				return var_76_0.horcrux_attr.dfac > var_76_1.horcrux_attr.dfac
			end
		end,
		function(arg_77_0, arg_77_1)
			local var_77_0 = playermodel.items[arg_77_0]
			local var_77_1 = playermodel.items[arg_77_1]

			if playermodel.items[arg_77_0].horcrux_attr.hfac == playermodel.items[arg_77_1].horcrux_attr.hfac then
				return "=="
			else
				return var_77_0.horcrux_attr.hfac > var_77_1.horcrux_attr.hfac
			end
		end
	}

	table.sort(self.dataMgr.filterData, function(arg_78_0, arg_78_1)
		for iter_78_0, iter_78_1 in ipairs(var_71_0) do
			if iter_78_1(arg_78_0, arg_78_1) ~= "==" then
				return iter_78_1(arg_78_0, arg_78_1)
			end
		end

		return false
	end)
end

function HorcruxLayer:updateDisplayBtn()
	if not self.displayBtn then
		self.displayBtn = ccui.Button:create("HorcruxLayer/display_btn.png", "HorcruxLayer/display_btn.png", "HorcruxLayer/display_btn.png", var_0_12)

		self.displayBtn:setPosition(cc.p(550, 1030 + GameDisplay.fix_y))
		self.displayBtn:addTouchEventListener(function(arg_80_0, arg_80_1)
			if arg_80_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.isShowVaule = not self.isShowVaule

			self:updateShowingCells()
			self:updateDisplayBtn()
		end)
		self.rootLayer:addChild(self.displayBtn)

		local var_79_0 = ccui.ImageView:create("HorcruxLayer/fac.png", var_0_12)

		var_79_0:setPositionX(self.displayBtn:getContentSize().width - var_79_0:getContentSize().width / 2)
		var_79_0:setPositionY(self.displayBtn:getContentSize().height / 2)
		var_79_0:setName("facImg")
		self.displayBtn:addChild(var_79_0)

		local var_79_1 = ccui.ImageView:create("HorcruxLayer/value.png", var_0_12)

		var_79_1:setPositionX(var_79_1:getContentSize().width / 2)
		var_79_1:setPositionY(self.displayBtn:getContentSize().height / 2)
		var_79_1:setName("valueImg")
		self.displayBtn:addChild(var_79_1)
	end

	if self.isShowVaule == nil then
		self.isShowVaule = false
	end

	if self.isShowVaule then
		self.displayBtn:getChildByName("facImg"):setVisible(false)
		self.displayBtn:getChildByName("valueImg"):setVisible(true)
	else
		self.displayBtn:getChildByName("facImg"):setVisible(true)
		self.displayBtn:getChildByName("valueImg"):setVisible(false)
	end
end

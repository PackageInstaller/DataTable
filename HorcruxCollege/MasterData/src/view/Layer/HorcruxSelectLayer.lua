HorcruxSelectLayer = class("HorcruxSelectLayer", function()
	return cc.Layer:create()
end)

local diamond_update_data = require("data.diamond_update_data")
local horcrux_data = require("data.horcrux_data")
local total_skill_data = require("data.total_skill_data")
local servant_data = require("data.servant_data")

require("view.Sprite.HorcruxSprite")
require("view.Sprite.FilterSprite")
require("view.Sprite.FilterListSprite")

local FilterHorcurxSelectSprite = require("view.Sprite.FilterHorcurxSelectSprite")
local playermodel = require("model.playermodel")
local explore_manager = require("controller.explore_manager")
local horcrux_manager = require("controller.horcrux_manager")
local item_manager = require("controller.item_manager")
local bag_manager = require("controller.bag_manager")
local array_manager = require("controller.array_manager")
local audio_manager = require("controller.audio_manager")
local filter_config_manager = require("controller.filter_config_manager")
local patrol_manager = require("controller.patrol_manager")
local substitution_manager = require("controller.substitution_manager")
local arenatft_manager = require("controller.arenatft_manager")
local var_0_17 = config._DEBUG and 0 or 1
local TempWidget = require("view.Sprite.TempWidget")
local var_0_19
local var_0_20 = cc.c3b(226, 243, 247)
local var_0_21 = cc.c3b(0, 255, 42)
local var_0_22 = cc.c3b(255, 0, 0)
local var_0_23 = false
local var_0_24 = 0
local var_0_25 = 640
local var_0_26 = 610
local var_0_27 = 0
local var_0_28 = 134
local var_0_29 = 640
local var_0_30 = 200
local var_0_31 = {
	cc.p(5, 0),
	cc.p(165, 0),
	cc.p(325, 0),
	(cc.p(485, 0))
}
local var_0_32 = 1

local function var_0_33(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = false
	local var_2_1 = false

	for iter_2_0 = 1, FORMATION_SHOW_GIRL_NUM do
		if arg_2_0[iter_2_0] and arg_2_0[iter_2_0].assist_girl == arg_2_1 then
			var_2_0 = true

			if iter_2_0 == arg_2_2 then
				var_2_1 = true

				return var_2_0, true
			else
				return var_2_0, var_2_1
			end
		end
	end

	return var_2_0, var_2_1
end

function HorcruxSelectLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = HorcruxSelectLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function HorcruxSelectLayer.getInstance()
	return var_0_19
end

function HorcruxSelectLayer.ctor(arg_5_0)
	arg_5_0.curFilters = {}
	arg_5_0.curSortOrders = 0
	arg_5_0.curSort = 1
	arg_5_0.showAttr = false
	arg_5_0.curIndex = nil
	arg_5_0.curHorcrux = nil
	arg_5_0.UIType = nil
	arg_5_0.filtertype = filter_config_manager.HORCRUX_LAYER
end

function HorcruxSelectLayer:init(arg_6_1)
	print("open layer ：HorcruxSelectLayer")

	var_0_19 = self

	UIHelpHideBlackMask(self)

	self.rootLayer = cc.Layer:create()

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	TempWidget:CreateTempImg("HorcruxSelectLayer/bg.png", self.rootLayer):align(cc.p(0.5, 0.5), self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2 - GameDisplay.fix_y)

	local var_6_0 = ccui.Layout:create()

	var_6_0:setContentSize(GameDisplay.getScreenSize())
	var_6_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_6_0:setAnchorPoint(0, 0)
	var_6_0:setTouchEnabled(true)
	var_6_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(var_6_0, 1)
	self:addChild(self.rootLayer, 2)

	self.selectType = arg_6_1.selectType
	self.selectGirlServantId = arg_6_1.selectGirlServantId
	self.isHpInherit = not not (arg_6_1 and arg_6_1.isHpInherit)
	self.selectCallback = arg_6_1.selectCallback
	self.defaultAttr = arg_6_1.defaultAttr
	self.initOutSide = arg_6_1.outSide
	self.initFilter = arg_6_1.initFilter
	self.initFilterPop = arg_6_1.initFilterPop
	self.insertHandel = arg_6_1.insertHandel
	self.filtertype = arg_6_1.filtertype or filter_config_manager.HORCRUX_LAYER
	self.UIType = arg_6_1.UIType or "BattleArrayLayerNew"
	self.onTouchReturnBtnCallback = arg_6_1.onTouchReturnBtnCallback
	self.selectTblAni = true
	self.adverturemode = arg_6_1.adverturemode
	self.isHorcruxDevour = arg_6_1.isHorcruxDevour
	self.mainHorcrux = arg_6_1.mainHorcrux

	if arg_6_1.selectType == SELECT_HORCRUX_DEVOUR and not arg_6_1.mainHorcrux then
		self.curSortOrders = 1
	end

	self:initHorcruxData(arg_6_1)
	self:createTitleSprite()
	self:initFilterPanel()
	self:initCollectPanel()
	self:initHorcruxListPanel()
	self:initBottomList()
	self:initComparedFrame()
	self:updateListEmpty()

	self.selectTblAni = false

	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			self.dataMgr = nil
			var_0_23 = false
			var_0_19 = nil
		end
	end)
	self:initRegisterEventListener()
end

function HorcruxSelectLayer:createTitleSprite()
	self.title = TitleSprite:create("HorcruxSelectLayer/title_horcruxbag.png", 2, "HorcruxSelectLayer/top.png")

	self.title:setPosition(cc.p(0, 1080 + GameDisplay.fix_y))
	self.rootLayer:addChild(self.title, 5)

	local var_8_0 = "Array/hold_girls.png"
	local var_8_1 = "Array/hold_girls_on.png"

	self.hidegirls = ccui.Button:create("Array/hold_girls.png", nil, "Array/hold_girls.png", var_0_17)

	self.hidegirls:setPosition(cc.p(self.title:getContentSize().width / 2, self.title:getContentSize().height / 2))
	self.title:addChild(self.hidegirls)

	self.hold_array_girls = false

	self.hidegirls:setVisible(false)
	self.hidegirls:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hold_array_girls = not self.hold_array_girls

		if self.hold_array_girls then
			arg_9_0:loadTextures(var_8_1, nil, var_8_1, var_0_17)
		else
			arg_9_0:loadTextures(var_8_0, nil, var_8_1, var_0_17)
		end

		self.dataMgr:generate_bag_data(self.filterTbl, self:selectholdData())

		if SELECT_HORCRUX_COMPOUND == self.selectType then
			self.dataMgr:dealWithSelectData(self.selectCurHorcrux)
		end

		self:updateListEmpty()
		self:updateShowingCells()
	end)
end

function HorcruxSelectLayer:initFilterPanel()
	self.filterAniFlag = true
	self.filterAniFlag1 = false
	self.filterPopModel = false
	self.filterTbl = filter_config_manager:getDefaultFilterData(self.filtertype, nil, nil)
	self.curSort = self.filterTbl.sortType
	self.dataMgr = bag_manager:create()

	if self.selectType == SELECT_HORCRUX_DEVOUR and self.mainHorcrux then
		self.dataMgr:setCalculateHorcruxScore(self.selectGirlServantId)
	end

	self.filterTbl.outSide = {
		self.selectCurHorcrux
	}

	if self.initOutSide then
		for iter_10_0, iter_10_1 in pairs(self.initOutSide) do
			self.filterTbl.outSide[#self.filterTbl.outSide + 1] = iter_10_1
		end
	end

	if self.initFilter then
		for iter_10_2, iter_10_3 in pairs(self.initFilter) do
			self.filterTbl.filterConfig[iter_10_2] = global_deepCopy(iter_10_3)
		end
	end

	self.filterTbl.insertHandel = self.insertHandel

	self.dataMgr:generate_bag_data(self.filterTbl, self:selectholdData())

	if self.selectType == SELECT_HORCRUX_DEVOUR and self.mainHorcrux then
		self.recommendHorcruxs = self.dataMgr:getRecommendHorcruxs()
	end

	if SELECT_HORCRUX_COMPOUND == self.selectType then
		self.dataMgr:dealWithSelectData(self.selectCurHorcrux)
	end

	if self.selectType == SELECT_HORCRUX_SUBSTITUTION then
		local var_10_1 = substitution_manager:getSubByHorcruxEntityid()

		if #var_10_1 > 0 then
			self.dataMgr:deleteItems(var_10_1)
		end
	end

	self:defaultHorcruxInsertToHead()

	if self.selectType ~= SELECT_HORCRUX_COMPOUND then
		self:createFilterList(1)

		self.filterListData = self.filterList:getFilterData()
		self.filterButton = TempWidget:CreateTempBtn("HorcruxSelectLayer/filter_btn_on.png")

		self.filterButton:setPositionX(565)
		self.filterButton:setPositionY(self.title:getContentSize().height / 2)
		self.title:addChild(self.filterButton, 5)
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
			self:showFilterPop()
		end)
	end

	self.button_attribute = TempWidget:CreateTempBtn("HorcruxSelectLayer/attr_btn_on.png")

	self.button_attribute:setPositionX(450)
	self.button_attribute:setPositionY(self.title:getContentSize().height / 2)

	self.button_attribute.isClickOn = false

	self.title:addChild(self.button_attribute, 5)
	self.button_attribute:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.showAttr = not self.showAttr
		arg_13_0.isClickOn = not arg_13_0.isClickOn

		if arg_13_0.isClickOn == false then
			arg_13_0:loadTextures("HorcruxSelectLayer/attr_btn_off.png", "HorcruxSelectLayer/attr_btn_off.png", nil, var_0_17)
		else
			arg_13_0:loadTextures("HorcruxSelectLayer/attr_btn_on.png", "HorcruxSelectLayer/attr_btn_on.png", nil, var_0_17)
		end

		self:updateShowingCells()
	end)
end

function HorcruxSelectLayer:getRefindDefaultSelectHorcrux()
	local var_14_0

	local function var_14_1(arg_15_0)
		local var_15_0
		local var_15_1
		local var_15_3

		if sortOrder == 1 then
			var_15_0 = 1
			var_15_1 = self.dataMgr:getDataCount()
			var_15_3 = 1
		else
			var_15_0 = self.dataMgr:getDataCount()
			var_15_1 = 1
			var_15_3 = -1
		end

		for iter_15_0 = var_15_0, var_15_1, var_15_3 do
			local var_15_4, var_15_5 = var_0_33(arg_15_0, self.dataMgr:dequeueItem(iter_15_0))

			if not var_15_4 and self.dataMgr:dequeueItem(iter_15_0) ~= self.selectCurHorcrux then
				var_14_0 = self.dataMgr:dequeueItem(iter_15_0)

				break
			end
		end
	end

	if not self.selectCurHorcrux then
		({
			[SELECT_HORCRUX_FIGHT] = function()
				var_14_1((array_manager:getBattleArrayData(self.selectArrayIndex)))
			end,
			[SELECT_HORCRUX_FIGHT_MODE] = function()
				var_14_1((require("controller.formation.formation_manager"):getFormationInfoBySelectHorcruxType(SELECT_HORCRUX_FIGHT_MODE, self.selectArrayIndex)))
			end,
			[SELECT_HORCRUX_FIGHT_ELEMENTS] = function()
				var_14_1((require("controller.formation.formation_manager"):getFormationInfoBySelectHorcruxType(SELECT_HORCRUX_FIGHT_ELEMENTS, self.selectArrayIndex)))
			end,
			[SELECT_HORCRUX_FIGHT_POINT] = function()
				var_14_1((require("controller.formation.formation_manager"):getFormationInfoBySelectHorcruxType(SELECT_HORCRUX_FIGHT_POINT, self.selectArrayIndex)))
			end,
			[SELECT_HORCRUX_FIGHT_MATERIAL] = function()
				var_14_1((require("controller.formation.formation_manager"):getFormationInfoBySelectHorcruxType(SELECT_HORCRUX_FIGHT_MATERIAL, self.selectArrayIndex)))
			end,
			[SELECT_HORCRUX_EXPLORE_HP_INHERIT] = function()
				var_14_1((array_manager:getBattleArrayDataHpInherit(self.selectArrayIndex)))
			end,
			[SELECT_HORCRUX_EXPLORE] = function()
				var_14_1(self.selectArrayBattle)
			end,
			[SELECT_HORCRUX_ARENA_DEFENCE] = function()
				var_14_1((array_manager:getBattleArrayData(self.selectArrayIndex)))
			end,
			[SELECT_HORCRUX_ARENA_ATTACK] = function()
				var_14_1((array_manager:getBattleArrayData(self.selectArrayIndex)))
			end,
			[SELECT_HORCRUX_SPECIAL] = function()
				var_14_1(self.selectArrayBattle)
			end,
			[SELECT_HORCRUX_SUBSTITUTION] = function()
				var_14_1((substitution_manager:getArrayData(self.selectArrayIndex)))
			end,
			[SELECT_HORCRUX_TVT_DEFENCE] = function()
				var_14_1((arenatft_manager:getDefenceArrayData(self.selectArrayIndex)))
			end,
			[SELECT_HORCRUX_TVT_ATTACK] = function()
				var_14_1((arenatft_manager:getAttackArrayData(self.selectArrayIndex)))
			end,
			[SELECT_HORCRUX_SUBSTITUTION_OLD] = function()
				return
			end
		})[self.selectType]()
	end

	return nil
end

function HorcruxSelectLayer:updateListEmpty()
	if not self.emptyImg then
		self.emptyImg = ccui.ImageView:create("HorcruxSelectLayer/empty.png", var_0_17)

		self.emptyImg:setAnchorPoint(cc.p(0.5, 0.5))
		self.emptyImg:setPosition(cc.p(340, 550))
		self.rootLayer:addChild(self.emptyImg)

		self.emptyGainBtn = ccui.Button:create("public/button/gain.png", nil, "public/button/gain.png", var_0_17)

		self.emptyGainBtn:setPosition(cc.p(self.emptyImg:getContentSize().width / 2, self.emptyImg:getContentSize().height / 2))
		self.emptyGainBtn:setAnchorPoint(cc.p(0.5, 0.5))
		self.emptyImg:addChild(self.emptyGainBtn)
		self.emptyGainBtn:addTouchEventListener(function(arg_31_0, arg_31_1)
			if arg_31_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopGoGainLayer", {
				item = "horcrux"
			})
		end)
	end

	self.emptyImg:setVisible(self.dataMgr:getDataCount() == 0)
	self.emptyGainBtn:setVisible(self.dataMgr:getDataCount() == 0)
end

function HorcruxSelectLayer.defaultHorcruxInsertToHead(arg_32_0)
	return
end

function HorcruxSelectLayer:updateTitleBottom(arg_33_1)
	if self.filterPopModel == false and arg_33_1 == 2 or self.filterPopModel == true and arg_33_1 == 1 then
		self.filterPopModel = not self.filterPopModel

		if arg_33_1 == 1 then
			self.filterButton:loadTextures("HorcruxSelectLayer/filter_btn_off.png", "HorcruxSelectLayer/filter_btn_off.png", nil, var_0_17)
			self.bottomList:runAction(cc.MoveBy:create(0.2, cc.p(0, 100)))
		else
			self.filterButton:loadTextures("HorcruxSelectLayer/filter_btn_on.png", "HorcruxSelectLayer/filter_btn_on.png", nil, var_0_17)
			self.bottomList:runAction(cc.MoveBy:create(0.2, cc.p(0, -100)))
		end
	end
end

function HorcruxSelectLayer:showFilterPop()
	local var_34_0 = self.filterListData.col
	local var_34_1 = {}

	if not self.filterListData.filterValue then
		if self.filterList:getTouchFlag() then
			for iter_34_0, iter_34_1 in pairs(self.filterListData.btnState) do
				var_34_1[iter_34_0] = 0
			end

			self.filterList:setTouchFlag(false)
		end
	else
		for iter_34_2, iter_34_3 in pairs(self.filterListData.btnState) do
			var_34_1[iter_34_2] = iter_34_3 == 1 and -2 or -1
		end
	end

	if self.filterSpritePop then
		self.filterSpritePop:setFilterBtnState(var_34_0, var_34_1)
		self.filterSpritePop:setSortOrderState(1, self.curSortOrders == 0 and {
			1,
			0
		} or {
			0,
			1
		})
		self.filterSpritePop:updateAllFilterBtn()
		self.filterSpritePop:playPopAni()
	else
		self.filterSpritePop = self:createFilterPop()

		self.rootLayer:addChild(self.filterSpritePop, 1000)
	end
end

function HorcruxSelectLayer:createFilterList(arg_35_1)
	self.filterList = FilterListSprite:create({
		style = "style_horcrux_bag_new",
		defaultSelected = arg_35_1,
		bagLayerType = self.filtertype,
		filterCallback = function(self)
			self.selectTblAni = true
			self.filterTbl.filterConfig[self.filterKey] = {
				self.filterValue
			}
			self.filterListData = self
			self.filterTbl.outSide = {
				self.selectCurHorcrux
			}

			if self.initOutSide then
				for iter_36_0, iter_36_1 in pairs(self.initOutSide) do
					self.filterTbl.outSide[#self.filterTbl.outSide + 1] = iter_36_1
				end
			end

			self.dataMgr:generate_bag_data(self.filterTbl, self:selectholdData())

			if SELECT_HORCRUX_COMPOUND == self.selectType then
				self.dataMgr:dealWithSelectData(self.selectCurHorcrux)
			end

			self:defaultHorcruxInsertToHead()

			if sortOrder == 1 then
				-- block empty
			end

			self.curIndex = 0

			self.bottomList:getBtn("sureBtn"):setVisible(self.dataMgr:getDataCount() > 0)
			self.listPanel:reloadData()
			self:updateListEmpty()

			self.selectTblAni = false
		end
	})

	self.filterList:setAnchorPoint(cc.p(0, 1))
	self.filterList:setPositionX(0)
	self.filterList:setPositionY(1080 + GameDisplay.fix_y)
	self.rootLayer:addChild(self.filterList, 6)
end

function HorcruxSelectLayer:sortCallback()
	self.curSortOrders = 1 - self.curSortOrders

	self:updateShowingCells()
end

function HorcruxSelectLayer:filterCallback(arg_38_1)
	self.filterTbl.sortType = arg_38_1.sortType or self.filterTbl

	for iter_38_0, iter_38_1 in pairs(arg_38_1.filterConfig) do
		self.filterTbl.filterConfig[iter_38_0] = global_deepCopy(iter_38_1)
	end

	self.curSort = self.filterTbl.sortType
	self.filterTbl.outSide = {
		self.selectCurHorcrux
	}

	if self.initOutSide then
		for iter_38_2, iter_38_3 in pairs(self.initOutSide) do
			self.filterTbl.outSide[#self.filterTbl.outSide + 1] = iter_38_3
		end
	end

	self.filterTbl.insertHandel = self.insertHandel

	self.dataMgr:generate_bag_data(self.filterTbl, self:selectholdData())

	if SELECT_HORCRUX_COMPOUND == self.selectType then
		self.dataMgr:dealWithSelectData(self.selectCurHorcrux)
	end

	self:defaultHorcruxInsertToHead()

	if sortOrder == 1 then
		-- block empty
	end

	self.curIndex = 0

	self.bottomList:getBtn("sureBtn"):setVisible(self.dataMgr:getDataCount() > 0)
	self.listPanel:reloadData()
	self:updateListEmpty()
end

function HorcruxSelectLayer:createFilterPop()
	local var_39_0 = {}
	local var_39_1 = false

	for iter_39_0, iter_39_1 in pairs(self.filterListData.btnState) do
		if iter_39_1 == 1 then
			var_39_1 = true
		end
	end

	for iter_39_2, iter_39_3 in pairs(self.filterListData.btnState) do
		var_39_0[iter_39_2] = var_39_1 and (iter_39_3 == 1 and -2 or -1) or iter_39_3
	end

	local var_39_2 = {
		[self.filterListData.col] = var_39_0
	}

	if self.initFilterPop then
		for iter_39_4, iter_39_5 in pairs(self.initFilterPop) do
			var_39_2[iter_39_4] = global_deepCopy(iter_39_5)
		end
	end

	local var_39_3 = FilterHorcurxSelectSprite:create({
		filterType = self.filtertype,
		filterCallback = function(arg_40_0)
			self:filterCallback(arg_40_0)
		end,
		maskTouchCallback = function(arg_41_0)
			if self.filterAniFlag1 then
				self.filterAniFlag1 = false

				self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
					self.filterAniFlag1 = true
					self.filterAniFlag = true
				end)))
				self:updateTitleBottom(1)
				arg_41_0()
			end
		end,
		sortOrderChangeCallback = function(arg_43_0)
			self:sortCallback(arg_43_0)
		end,
		initButtonConfig = var_39_2,
		defaultSortOrder = self.curSortOrders
	})

	var_39_3:setPositionY(-GameDisplay.fix_y)

	return var_39_3
end

function HorcruxSelectLayer:initHorcruxData(arg_44_1)
	({
		[SELECT_HORCRUX_FIGHT] = function()
			self.selectArrayIndex = arg_44_1.arrayIndex
			self.selectArrayPos = arg_44_1.arrayPos
			self.selectCurHorcrux = arg_44_1.curHorcrux

			function self.exithandler()
				LayerManager:removePopLayer()
			end
		end,
		[SELECT_HORCRUX_FIGHT_POINT] = function()
			self.selectArrayIndex = arg_44_1.arrayIndex
			self.selectArrayPos = arg_44_1.arrayPos
			self.selectCurHorcrux = arg_44_1.curHorcrux

			function self.exithandler()
				LayerManager:removePopLayer()
			end
		end,
		[SELECT_HORCRUX_FIGHT_MODE] = function()
			self.selectArrayIndex = arg_44_1.arrayIndex
			self.selectArrayPos = arg_44_1.arrayPos
			self.selectCurHorcrux = arg_44_1.curHorcrux

			function self.exithandler()
				LayerManager:removePopLayer()
			end
		end,
		[SELECT_HORCRUX_FIGHT_ELEMENTS] = function()
			self.selectArrayIndex = arg_44_1.arrayIndex
			self.selectArrayPos = arg_44_1.arrayPos
			self.selectCurHorcrux = arg_44_1.curHorcrux

			function self.exithandler()
				LayerManager:removePopLayer()
			end
		end,
		[SELECT_HORCRUX_FIGHT_MATERIAL] = function()
			self.selectArrayIndex = arg_44_1.arrayIndex
			self.selectArrayPos = arg_44_1.arrayPos
			self.selectCurHorcrux = arg_44_1.curHorcrux

			function self.exithandler()
				LayerManager:removePopLayer()
			end
		end,
		[SELECT_HORCRUX_EXPLORE_HP_INHERIT] = function()
			self.selectArrayIndex = arg_44_1.arrayIndex
			self.selectArrayPos = arg_44_1.arrayPos
			self.selectCurHorcrux = arg_44_1.curHorcrux

			function self.exithandler()
				LayerManager:removePopLayer()
			end
		end,
		[SELECT_HORCRUX_WORK] = function()
			self.selectCurHorcrux = arg_44_1.curHorcrux

			function self.exithandler()
				LayerManager:removePopLayer()
			end
		end,
		[SELECT_HORCRUX_COMPOUND] = function()
			self.selectCurHorcrux = arg_44_1.curHorcrux

			function self.exithandler()
				LayerManager:removePopLayer()
			end
		end,
		[SELECT_HORCRUX_EXPLORE] = function()
			self.selectArrayBattle = arg_44_1.battleInfo
			self.selectArrayPos = arg_44_1.arrayPos
			self.selectArrayIndex = arg_44_1.arrayIndex
			self.selectCurHorcrux = arg_44_1.curHorcrux

			function self.exithandler()
				LayerManager:removePopLayer()
			end
		end,
		[SELECT_HORCRUX_ARENA_DEFENCE] = function()
			self.selectArrayIndex = arg_44_1.arrayIndex
			self.selectArrayPos = arg_44_1.arrayPos
			self.selectCurHorcrux = arg_44_1.curHorcrux

			function self.exithandler()
				LayerManager:removePopLayer()
			end
		end,
		[SELECT_HORCRUX_ARENA_ATTACK] = function()
			self.selectArrayIndex = arg_44_1.arrayIndex
			self.selectArrayPos = arg_44_1.arrayPos
			self.selectCurHorcrux = arg_44_1.curHorcrux

			function self.exithandler()
				LayerManager:removePopLayer()
			end
		end,
		[SELECT_HORCRUX_TVT_DEFENCE] = function()
			self.selectArrayIndex = arg_44_1.arrayIndex
			self.selectArrayPos = arg_44_1.arrayPos
			self.selectCurHorcrux = arg_44_1.curHorcrux

			function self.exithandler()
				LayerManager:removePopLayer()
			end
		end,
		[SELECT_HORCRUX_TVT_ATTACK] = function()
			self.selectArrayIndex = arg_44_1.arrayIndex
			self.selectArrayPos = arg_44_1.arrayPos
			self.selectCurHorcrux = arg_44_1.curHorcrux

			function self.exithandler()
				LayerManager:removePopLayer()
			end
		end,
		[SELECT_HORCRUX_SPECIAL] = function()
			self.selectArrayBattle = arg_44_1.battleInfo
			self.selectArrayPos = arg_44_1.arrayPos
			self.selectCurHorcrux = arg_44_1.curHorcrux
			self.usedHorcrux = {}

			for iter_71_0, iter_71_1 in pairs(self.selectArrayBattle) do
				if not iter_71_1.npcid and iter_71_1.horcruxInfo then
					self.usedHorcrux[iter_71_1.horcruxInfo.entityid] = true
				end
			end

			function self.exithandler()
				LayerManager:removePopLayer()
			end
		end,
		[SELECT_HORCRUX_SUBSTITUTION] = function()
			self.selectArrayIndex = arg_44_1.arrayIndex
			self.selectArrayPos = arg_44_1.arrayPos
			self.selectCurHorcrux = arg_44_1.curHorcrux

			function self.exithandler()
				LayerManager:removePopLayer()
			end
		end,
		[SELECT_HORCRUX_SUBSTITUTION_OLD] = function()
			self.selectArrayIndex = arg_44_1.arrayIndex
			self.selectArrayPos = arg_44_1.arrayPos
			self.selectCurHorcrux = arg_44_1.curHorcrux

			function self.exithandler()
				LayerManager:removePopLayer()
			end
		end,
		[SELECT_HORCRUX_DEVOUR] = function()
			self.selectCurHorcrux = arg_44_1.curHorcrux

			function self.exithandler()
				LayerManager:removePopLayer()
			end
		end
	})[self.selectType]()
end

function HorcruxSelectLayer:layerOutAni(arg_79_1)
	self.startRunOutAni = true

	self:updateShowingCells()
	self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(LAYER_OUT_TIME * 2), cc.CallFunc:create(arg_79_1)))
end

function HorcruxSelectLayer:initBottomList()
	local function var_80_0(arg_81_0, arg_81_1)
		if arg_81_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:layerOutAni(function()
			if self.exithandler then
				self.exithandler()
			end

			if self.onTouchReturnBtnCallback then
				self.onTouchReturnBtnCallback()
			end
		end)
	end

	local var_80_1 = {
		{
			name = "sureBtn",
			word = ({
				[SELECT_HORCRUX_FIGHT] = L_HORCRUXSELECT_BOTTOM_LIST.Unload,
				[SELECT_HORCRUX_FIGHT_MODE] = L_HORCRUXSELECT_BOTTOM_LIST.Unload,
				[SELECT_HORCRUX_FIGHT_ELEMENTS] = L_HORCRUXSELECT_BOTTOM_LIST.Unload,
				[SELECT_HORCRUX_FIGHT_POINT] = L_HORCRUXSELECT_BOTTOM_LIST.Unload,
				[SELECT_HORCRUX_FIGHT_MATERIAL] = L_HORCRUXSELECT_BOTTOM_LIST.Unload,
				[SELECT_HORCRUX_EXPLORE] = L_HORCRUXSELECT_BOTTOM_LIST.Unload,
				[SELECT_HORCRUX_SPECIAL] = L_HORCRUXSELECT_BOTTOM_LIST.Unload,
				[SELECT_HORCRUX_EXPLORE_HP_INHERIT] = L_HORCRUXSELECT_BOTTOM_LIST.Unload,
				[SELECT_HORCRUX_WORK] = L_HORCRUXSELECT_BOTTOM_LIST.Select,
				[SELECT_HORCRUX_COMPOUND] = L_HORCRUXSELECT_BOTTOM_LIST.Select,
				[SELECT_HORCRUX_ARENA_DEFENCE] = L_HORCRUXSELECT_BOTTOM_LIST.Unload,
				[SELECT_HORCRUX_ARENA_ATTACK] = L_HORCRUXSELECT_BOTTOM_LIST.Unload,
				[SELECT_HORCRUX_SUBSTITUTION] = L_HORCRUXSELECT_BOTTOM_LIST.Unload,
				[SELECT_HORCRUX_TVT_DEFENCE] = L_HORCRUXSELECT_BOTTOM_LIST.Unload,
				[SELECT_HORCRUX_TVT_ATTACK] = L_HORCRUXSELECT_BOTTOM_LIST.Unload,
				[SELECT_HORCRUX_SUBSTITUTION_OLD] = L_HORCRUXSELECT_BOTTOM_LIST.Unload,
				[SELECT_HORCRUX_DEVOUR] = L_HORCRUXSELECT_BOTTOM_LIST.Select
			})[self.selectType],
			handler = self:generateBottomHandler()
		}
	}

	if self.selectType == SELECT_HORCRUX_FIGHT or self.selectType == SELECT_HORCRUX_EXPLORE or self.selectType == SELECT_HORCRUX_SPECIAL or self.selectType == SELECT_HORCRUX_SUBSTITUTION or self.selectType == SELECT_HORCRUX_ARENA_DEFENCE or self.selectType == SELECT_HORCRUX_ARENA_ATTACK or self.selectType == SELECT_HORCRUX_TVT_DEFENCE or self.selectType == SELECT_HORCRUX_TVT_ATTACK or self.selectType == SELECT_HORCRUX_EXPLORE_HP_INHERIT or self.selectType == SELECT_HORCRUX_FIGHT_MODE or self.selectType == SELECT_HORCRUX_FIGHT_POINT or self.selectType == SELECT_HORCRUX_FIGHT_MATERIAL or self.selectType == SELECT_HORCRUX_FIGHT_ELEMENTS or self.selectType == SELECT_HORCRUX_SUBSTITUTION_OLD or self.selectType == SELECT_HORCRUX_FIGHT_MATERIAL or self.selectType == SELECT_HORCRUX_FIGHT_ELEMENTS or self.selectType == SELECT_HORCRUX_DEVOUR then
		var_80_1[2] = {
			texture = "public/button/public_button_blue.png",
			name = "infoBtn",
			word = L_HORCRUXSELECT_BOTTOM_LIST.Btn_Str,
			handler = self:getShowHorcruxInfoHandler()
		}
	end

	self.bottomList = TempWidget:CreateTempImg("HorcruxSelectLayer/button.png")

	self.rootLayer:addChild(self.bottomList, 7)
	self.bottomList:_addEvent(function()
		return
	end)
	self.bottomList:align(cc.p(0, 0), 0, -GameDisplay.fix_y)

	function self.bottomList.getBtn(arg_84_0, arg_84_1)
		return self.bottomList:getChildByName(arg_84_1)
	end

	if self.filterList then
		self.filterList:setAnchorPoint(cc.p(0, 0))
		self.filterList:setPositionY(self.bottomList:getPositionY() + self.bottomList:getContentSize().height - 15)
		self.filterList:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.MoveBy:create(0.1, cc.p(0, 15))))
	end

	var_80_1[1].texture = "HorcruxSelectLayer/go_fight.png"

	if var_80_1[2] then
		var_80_1[2].texture = "HorcruxSelectLayer/power.png"
	end

	for iter_80_0 = 1, #var_80_1 do
		local var_80_2 = TempWidget:CreateTempBtn(var_80_1[iter_80_0].texture, self.bottomList)

		var_80_2:setName(var_80_1[iter_80_0].name)
		var_80_2:align(cc.p(1, 0.5), self.bottomList:size().w - 5 - (iter_80_0 - 1) * 170, self.bottomList:size().h / 2)
		var_80_2:addTouchEventListener(var_80_1[iter_80_0].handler)

		local var_80_3 = TempWidget:CreateTempImg("HorcruxSelectLayer/back_btn.png", self.bottomList)

		var_80_3:align(cc.p(0, 0.5), 5, self.bottomList:size().h / 2)
		var_80_3:_addEvent(function(arg_85_0, arg_85_1)
			var_80_0(arg_85_0, arg_85_1)
		end)

		local var_80_4 = TempWidget:CreateTempLabel(var_80_1[iter_80_0].word, FONT_BUTTON, 22, var_80_2)

		var_80_4:align(cc.p(0.5, 0.5), var_80_2:size().w / 2, var_80_2:size().h / 2 - 3)
		var_80_4:_setColor("282f39")
		var_80_4:setName("word")
	end

	if self.dataMgr:getDataCount() <= 0 then
		self.bottomList:getBtn("sureBtn"):setVisible(false)
	end

	if self.selectType ~= SELECT_HORCRUX_COMPOUND then
		if self.selectType == SELECT_HORCRUX_DEVOUR then
			self.bottomList:getBtn("sureBtn"):setVisible(self.curHorcrux ~= nil)
		else
			self.bottomList:getBtn("sureBtn"):setVisible(self.curHorcrux ~= nil or self.selectCurHorcrux ~= nil)
		end
	else
		self.bottomList:getBtn("sureBtn"):setVisible(self.curHorcrux ~= nil)
	end

	if self.bottomList:getChildByName("infoBtn") then
		self.bottomList:getChildByName("infoBtn"):setVisible(self.curHorcrux ~= nil or self.selectCurHorcrux ~= nil)
	end
end

function HorcruxSelectLayer.getShowHorcruxInfoHandler(arg_86_0)
	return function(arg_87_0, arg_87_1)
		if arg_87_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_86_0.curHorcrux then
			arg_86_0:saveDecomposeBeforeShowingCells()
			LayerManager:pushInLayer("HorcruxInfoLayer", arg_86_0.curHorcrux, nil, arg_86_0.isHpInherit)
		elseif arg_86_0.selectCurHorcrux then
			arg_86_0:saveDecomposeBeforeShowingCells()
			LayerManager:pushInLayer("HorcruxInfoLayer", arg_86_0.selectCurHorcrux, nil, arg_86_0.isHpInherit)
		end
	end
end

function HorcruxSelectLayer:saveDecomposeBeforeShowingCells(arg_88_1)
	self.oldCellCount = self:getHorcruxListLen()

	local var_88_0 = {
		cellsize = cc.size(var_0_29, var_0_30)
	}

	var_88_0.maxcount = arg_88_1 and arg_88_1 or self:getHorcruxListLen()
	self.oldStartidx, self.oldEndidx = GetTableViewShowCellIdx(self.listPanel, var_88_0)
end

function HorcruxSelectLayer:updateDecomposeAfterShowingCells()
	for iter_89_0 = self.oldStartidx, self.oldEndidx do
		self.listPanel:updateCellAtIndex(iter_89_0)
	end

	self.oldCellCount = nil

	self:updateHorcruxFrame(self.comparedHorcruxFrame, self.curHorcrux, "other")
	self:updateHorcruxFrame(self.curHorcruxFrame, self.selectCurHorcrux, "self")
	self:updateListEmpty()
end

function HorcruxSelectLayer:deleteBagData(arg_90_1)
	if arg_90_1 then
		for iter_90_0, iter_90_1 in pairs(arg_90_1) do
			self.dataMgr:deleteItems(iter_90_1)
		end
	end
end

function HorcruxSelectLayer:showSeizeArrayMemberPop(arg_91_1, arg_91_2, arg_91_3)
	if not self.changeMemberPop then
		self.changeMemberPop = ccui.Layout:create()

		self.changeMemberPop:setTouchEnabled(true)
		self.changeMemberPop:setContentSize(cc.Director:getInstance():getVisibleSize())
		self.changeMemberPop:setAnchorPoint(cc.p(0.5, 0.5))
		self.changeMemberPop:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
		self.changeMemberPop:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		self.changeMemberPop:setBackGroundColor(cc.c3b(0, 0, 0))
		self.changeMemberPop:setBackGroundColorOpacity(180)
		self:addChild(self.changeMemberPop, 100)
		self.changeMemberPop:addTouchEventListener(function(arg_92_0, arg_92_1)
			if arg_92_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.changeMemberPop:getChildByName("bg"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0), cc.CallFunc:create(function()
				self.changeMemberPop:setVisible(false)
			end)))
		end)

		local var_91_0 = ccui.ImageView:create("public/panelbg/bg_pupup_level3.png", var_0_17)

		var_91_0:setPositionX(self.changeMemberPop:getContentSize().width / 2)
		var_91_0:setPositionY(self.changeMemberPop:getContentSize().height / 2 - GameDisplay.notch_height)
		var_91_0:setName("bg")
		self.changeMemberPop:addChild(var_91_0)

		local var_91_1 = cc.Label:createWithTTF("111", FONT_DES, 28)

		var_91_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_91_1:setColor(cc.c3b(181, 196, 201))
		var_91_1:setPositionY(var_91_0:getContentSize().height / 2)
		var_91_1:setPositionX(var_91_0:getContentSize().width / 2)
		var_91_1:setName("desLabel")
		var_91_0:addChild(var_91_1)

		local var_91_2 = ccui.Button:create("public/button/btn_confirm.png", nil, "public/button/btn_confirm.png", var_0_17)

		var_91_2:setPositionY(var_91_0:getContentSize().height / 2 - 100)
		var_91_2:setPositionX(var_91_0:getContentSize().width / 2)
		var_91_0:addChild(var_91_2)

		if arg_91_3 then
			var_91_2:loadTextures("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", var_0_17)
			var_91_2:setPositionX(var_91_0:getContentSize().width / 2 + 200)
			var_91_2:setPositionY(var_91_0:getContentSize().height / 2 - 150)

			local var_91_3 = cc.Label:createWithTTF(L_BUTTON_TEXT.Accelerate, FONT_BUTTON, 30)

			var_91_3:setPosition(cc.p(var_91_2:getContentSize().width / 2, var_91_2:getContentSize().height / 2))
			var_91_3:setColor(cc.c3b(55, 55, 63))
			var_91_3:setName("labelConfirm")
			var_91_2:addChild(var_91_3, 999)

			local var_91_4 = ccui.Button:create("public/button/public_button_blue.png", nil, "public/button/btn_confirm.png", var_0_17)

			var_91_4:setPositionX(var_91_0:getContentSize().width / 2 - 200)
			var_91_4:setPositionY(var_91_0:getContentSize().height / 2 - 150)
			var_91_0:addChild(var_91_4)

			local var_91_5 = cc.Label:createWithTTF(L_BUTTON_TEXT.Interrupt, FONT_BUTTON, 30)

			var_91_5:setPosition(cc.p(var_91_4:getContentSize().width / 2, var_91_4:getContentSize().height / 2))
			var_91_5:setColor(cc.c3b(55, 55, 63))
			var_91_5:setName("labelConfirm")
			var_91_4:addChild(var_91_5, 999)
			var_91_4:addTouchEventListener(function(arg_94_0, arg_94_1)
				if arg_94_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_91_2 then
					arg_91_2(true)
				end
			end)
		end

		var_91_2:addTouchEventListener(function(arg_95_0, arg_95_1)
			if arg_95_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_91_2 then
				arg_91_2()
			end
		end)
	end

	self.changeMemberPop:setVisible(true)

	local var_91_6 = self.changeMemberPop:getChildByName("bg")

	var_91_6:setScaleY(0)
	var_91_6:runAction(cc.ScaleTo:create(0.15, 1, 1))
	var_91_6:getChildByName("desLabel"):setString(arg_91_1)
end

function HorcruxSelectLayer:generateBottomHandler()
	local function var_96_0(arg_97_0, arg_97_1)
		local function var_97_0(arg_98_0)
			arg_97_0:setBright(false)
			array_manager:updateArrayAssistgirl(self.selectArrayIndex, self.selectArrayPos, (arg_97_0:getTag() ~= 3 or nil) and (self.curHorcrux or nil), arg_98_0, function(arg_99_0)
				if arg_99_0 == 1 then
					if self.selectCallback then
						self.selectCallback()
					end

					LayerManager:removePopLayer(self.__queueindex)
				elseif arg_99_0 == 2 then
					global_ShowBlockWords(L_HORCRUXSELECT_WARNING[2])
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_99_0 == 3 then
					global_ShowBlockWords(L_HORCRUXSELECT_WARNING[3])
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_99_0 == 4 then
					global_ShowBlockWords(L_HORCRUXSELECT_WARNING[4])
					audio_manager:playeffectMusicTest("sound/invalid")
				elseif arg_99_0 == 6 then
					audio_manager:playeffectMusicTest("sound/invalid")
					global_ShowBlockWords(L_HORCRUXSELECT_WARNING[6])
				elseif arg_99_0 == 7 then
					audio_manager:playeffectMusicTest("sound/invalid")
					global_ShowBlockWords(L_HORCRUXSELECT_WARNING[7])
				end
			end)
			arg_97_0:setBright(true)
		end

		if self.selectType ~= SELECT_HORCRUX_SUBSTITUTION and self.selectType ~= SELECT_HORCRUX_ARENA_DEFENCE and self.selectType ~= SELECT_HORCRUX_ARENA_ATTACK and self.selectType ~= SELECT_HORCRUX_SUBSTITUTION_OLD and self.curHorcrux and array_manager:isHorcruxPatrolNow(self.curHorcrux) then
			local var_97_1, var_97_2 = patrol_manager:getCurArrayPatrolChpater((array_manager:getArrayByHorcruxID(self.curHorcrux)))
			local var_97_3 = patrol_manager:getPatrolInfo(var_97_1 .. "-" .. var_97_2)

			if var_97_3.time <= 0 then
				self:showSeizeArrayMemberPop(L_HORCRUXSELECT_CHANGE.Horcrux_Patrol[1], var_97_0)
			else
				self:showSeizeArrayMemberPop(string.format(L_HORCRUXSELECT_CHANGE.Girls_Patrol, (math.ceil(var_97_3.time / 360))), var_97_0, true)
			end
		elseif self.selectType ~= SELECT_HORCRUX_SUBSTITUTION and self.selectType ~= SELECT_HORCRUX_ARENA_DEFENCE and self.selectType ~= SELECT_HORCRUX_ARENA_ATTACK and self.selectType ~= SELECT_HORCRUX_SUBSTITUTION_OLD and self.curHorcrux and array_manager:isHorcruxInArrayNow(self.curHorcrux) then
			local var_97_4 = array_manager:getArrayByHorcruxID(self.curHorcrux)

			print("1111111111111111111111111111111111111111111111")
			var_97_0()
			arg_97_0:setBright(true)
		elseif self.selectType ~= SELECT_HORCRUX_TVT_DEFENCE and self.selectType ~= SELECT_HORCRUX_TVT_ATTACK and self.selectType ~= SELECT_HORCRUX_ARENA_ATTACK and self.curHorcrux and array_manager:isHorcruxPatrolNow(self.curHorcrux) then
			local var_97_5, var_97_6 = patrol_manager:getCurArrayPatrolChpater((array_manager:getArrayByHorcruxID(self.curHorcrux)))
			local var_97_7 = patrol_manager:getPatrolInfo(var_97_5 .. "-" .. var_97_6)

			if var_97_7.time <= 0 then
				self:showSeizeArrayMemberPop(L_HORCRUXSELECT_CHANGE.Horcrux_Patrol[1], var_97_0)
			else
				self:showSeizeArrayMemberPop(string.format(L_HORCRUXSELECT_CHANGE.Girls_Patrol, (math.ceil(var_97_7.time / 360))), var_97_0, true)
			end
		elseif self.selectType ~= SELECT_HORCRUX_TVT_DEFENCE and self.selectType ~= SELECT_HORCRUX_TVT_ATTACK and self.selectType ~= SELECT_HORCRUX_ARENA_DEFENCE and self.selectType ~= SELECT_HORCRUX_ARENA_ATTACK and self.curHorcrux and array_manager:isHorcruxInArrayNow(self.curHorcrux) then
			print("1111111111111111111111111111111111111111111111")
			self:showSeizeArrayMemberPop(string.format(L_HORCRUXSELECT_CHANGE.Within_Other_Team, (array_manager:getArrayByHorcruxID(self.curHorcrux))), var_97_0)
			arg_97_0:setBright(true)
		else
			arg_97_0:setBright(false)
			var_97_0()
		end
	end

	local function var_96_4(arg_107_0, arg_107_1)
		local function var_107_0()
			arg_107_0:setBright(false)
			arenatft_manager:set_arenatft_defence_horcrux(self.selectArrayIndex, self.selectArrayPos, (arg_107_0:getTag() ~= 3 or nil) and (self.curHorcrux or nil), function(arg_109_0)
				if arg_109_0 == 1 then
					if self.selectCallback then
						self.selectCallback()
					end

					LayerManager:removePopLayer(self.__queueindex)
				end
			end)
			arg_107_0:setBright(true)
		end

		if self.curHorcrux and arenatft_manager:isHorcruxInDefenceArrayNow(self.curHorcrux) then
			self:showSeizeArrayMemberPop(string.format(L_HORCRUXSELECT_CHANGE.Within_Other_Team, (arenatft_manager:getTvtDefenceByHorcruxID(self.curHorcrux))), var_107_0)
			arg_107_0:setBright(true)
		else
			arg_107_0:setBright(false)
			var_107_0()
		end
	end

	local function var_96_5(arg_110_0, arg_110_1)
		local function var_110_0()
			arg_110_0:setBright(false)
			arenatft_manager:set_arenatft_attack_horcrux(self.selectArrayIndex, self.selectArrayPos, (arg_110_0:getTag() ~= 3 or nil) and (self.curHorcrux or nil), function(arg_112_0)
				if arg_112_0 == 1 then
					if self.selectCallback then
						self.selectCallback()
					end

					LayerManager:removePopLayer(self.__queueindex)
				end
			end)
			arg_110_0:setBright(true)
		end

		if self.curHorcrux and arenatft_manager:isHorcruxInAttackArrayNow(self.curHorcrux) then
			self:showSeizeArrayMemberPop(string.format(L_HORCRUXSELECT_CHANGE.Within_Other_Team, (arenatft_manager:getTvtAttackByHorcruxID(self.curHorcrux))), var_110_0)
			arg_110_0:setBright(true)
		else
			arg_110_0:setBright(false)
			var_110_0()
		end
	end

	return ({
		[SELECT_HORCRUX_FIGHT] = function(arg_113_0, arg_113_1)
			if arg_113_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_113_0:isBright() then
				return
			end

			var_96_0(arg_113_0, arg_113_1)
		end,
		[SELECT_HORCRUX_FIGHT_POINT] = function(arg_114_0, arg_114_1)
			if arg_114_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_114_0:isBright() then
				return
			end

			require("controller.formation.formation_points_match_manager"):getInstance():requestUpdateArrayAssisgirl(self.selectArrayPos, (arg_114_0:getTag() ~= 3 or nil) and (self.curHorcrux or nil), function(arg_115_0)
				if arg_115_0.result == 1 then
					if self.selectCallback then
						self.selectCallback()
					end

					LayerManager:removePopLayer(self.__queueindex)
				end
			end)
		end,
		[SELECT_HORCRUX_FIGHT_MODE] = function(arg_116_0, arg_116_1)
			if arg_116_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_116_0:isBright() then
				return
			end

			require("controller.formation.formation_mode_manager"):getInstance():requestUpdateModeAssistGirl(self.adverturemode, self.selectArrayPos, (arg_116_0:getTag() ~= 3 or nil) and (self.curHorcrux or nil), function(arg_117_0)
				if arg_117_0.result == 1 then
					if self.selectCallback then
						self.selectCallback()
					end

					LayerManager:removePopLayer(self.__queueindex)
				end
			end)
		end,
		[SELECT_HORCRUX_FIGHT_ELEMENTS] = function(arg_118_0, arg_118_1)
			if arg_118_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_118_0:isBright() then
				return
			end

			require("controller.formation.formation_mode_manager"):getInstance():requestUpdateModeAssistGirl(self.adverturemode, self.selectArrayPos, (arg_118_0:getTag() ~= 3 or nil) and (self.curHorcrux or nil), function(arg_119_0)
				if arg_119_0.result == 1 then
					if self.selectCallback then
						self.selectCallback()
					end

					LayerManager:removePopLayer(self.__queueindex)
				end
			end)
		end,
		[SELECT_HORCRUX_FIGHT_MATERIAL] = function(arg_120_0, arg_120_1)
			if arg_120_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_120_0:isBright() then
				return
			end

			require("controller.formation.formation_mode_manager"):getInstance():requestUpdateModeAssistGirl(self.adverturemode, self.selectArrayPos, (arg_120_0:getTag() ~= 3 or nil) and (self.curHorcrux or nil), function(arg_121_0)
				if arg_121_0.result == 1 then
					if self.selectCallback then
						self.selectCallback()
					end

					LayerManager:removePopLayer(self.__queueindex)
				end
			end)
		end,
		[SELECT_HORCRUX_ARENA_DEFENCE] = function(arg_122_0, arg_122_1)
			if arg_122_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_122_0:isBright() then
				return
			end

			local var_122_0

			if arg_122_0:getTag() ~= 3 then
				var_122_0 = self.curHorcrux or nil
			end

			arg_122_0:setBright(false)

			local var_122_1 = require("controller.formation.formation_grab_match_manager"):getInstance()

			var_122_1:requestUpdateArrayAssisgirl(var_122_1.Type.Defend, var_122_0, self.selectArrayPos, function(arg_123_0)
				if arg_123_0.result == 1 then
					if self.selectCallback then
						self.selectCallback()
					end

					LayerManager:removePopLayer(self.__queueindex)
				elseif arg_123_0.result == 4 then
					global_ShowBlockWords(L_HORCRUXSELECT_CHANGE.Within_Team)
				end

				arg_122_0:setBright(true)
			end)
		end,
		[SELECT_HORCRUX_ARENA_ATTACK] = function(arg_124_0, arg_124_1)
			if arg_124_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_124_0:isBright() then
				return
			end

			local var_124_0

			if arg_124_0:getTag() ~= 3 then
				var_124_0 = self.curHorcrux or nil
			end

			arg_124_0:setBright(false)

			local var_124_1 = require("controller.formation.formation_grab_match_manager"):getInstance()

			var_124_1:requestUpdateArrayAssisgirl(var_124_1.Type.Attack, var_124_0, self.selectArrayPos, function(arg_125_0)
				if arg_125_0.result == 1 then
					if self.selectCallback then
						self.selectCallback()
					end

					LayerManager:removePopLayer(self.__queueindex)
				elseif arg_125_0.result == 4 then
					global_ShowBlockWords(L_HORCRUXSELECT_CHANGE.Within_Team)
				end

				arg_124_0:setBright(true)
			end)
		end,
		[SELECT_HORCRUX_WORK] = function(arg_126_0, arg_126_1)
			if arg_126_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.selectType ~= SELECT_HORCRUX_WORK then
				return
			end

			if not self.curHorcrux then
				return
			end

			if self.selectCallback then
				self.selectCallback(self.curHorcrux)
			end

			LayerManager:removePopLayer()
		end,
		[SELECT_HORCRUX_COMPOUND] = function(arg_127_0, arg_127_1)
			if arg_127_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.selectType ~= SELECT_HORCRUX_COMPOUND then
				return
			end

			if self.selectCallback then
				self.selectCallback(self.curHorcrux)
			end

			LayerManager:removePopLayer()
		end,
		[SELECT_HORCRUX_EXPLORE] = function(arg_128_0, arg_128_1)
			if arg_128_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.selectType ~= SELECT_HORCRUX_EXPLORE then
				return
			end

			if not arg_128_0:isBright() then
				return
			end

			local var_128_0

			if arg_128_0:getTag() ~= 3 then
				var_128_0 = self.curHorcrux or nil
			end

			arg_128_0:setBright(false)
			require("controller.formation.formation_explore_manager"):getInstance():requestUpdateArrayAssisgirl(self.selectArrayIndex, self.selectArrayPos, var_128_0, function(arg_129_0)
				if arg_129_0 == 1 then
					if self.selectCallback then
						self.selectCallback()
					end

					LayerManager:removePopLayer(self.__queueindex)
				end

				arg_128_0:setBright(true)
			end)
		end,
		[SELECT_HORCRUX_SPECIAL] = function(arg_130_0, arg_130_1)
			if arg_130_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.selectType ~= SELECT_HORCRUX_SPECIAL then
				return
			end

			if not arg_130_0:isBright() then
				return
			end

			local var_130_0

			if arg_130_0:getTag() ~= 3 then
				var_130_0 = self.curHorcrux or nil
			end

			arg_130_0:setBright(false)

			local var_130_1 = {}

			if self.selectArrayBattle then
				for iter_130_0, iter_130_1 in pairs(self.selectArrayBattle) do
					if not iter_130_1.npcid and iter_130_1.horcruxInfo then
						var_130_1[iter_130_1.horcruxInfo.entityid] = true
					end
				end
			end

			local function var_130_2()
				if self.selectCallback then
					self.selectCallback(var_130_0)
				end

				LayerManager:removePopLayer(self.__queueindex)
			end

			if var_130_0 and var_130_1[var_130_0] then
				self:showSeizeArrayMemberPop(L_HORCRUXSELECT_CHANGE.Within_Other_Team_Default, var_130_2)
				arg_130_0:setBright(true)
				audio_manager:playeffectMusicTest("sound/invalid")
			else
				var_130_2()
			end
		end,
		[SELECT_HORCRUX_EXPLORE_HP_INHERIT] = function(arg_132_0, arg_132_1)
			if arg_132_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.selectType ~= SELECT_HORCRUX_EXPLORE_HP_INHERIT then
				return
			end

			if not arg_132_0:isBright() then
				return
			end

			if arg_132_0:getTag() ~= 3 then
				local var_132_0 = self.curHorcrux or nil
			end

			arg_132_0:setBright(false)

			local function var_132_1()
				require("controller.formation.formation_explore_manager"):getInstance():requestUpdateArrayAssisgirl(self.selectArrayIndex, self.selectArrayPos, var_132_0, function(arg_134_0)
					if arg_134_0 == 1 then
						if self.selectCallback then
							self.selectCallback()
						end

						LayerManager:removePopLayer(self.__queueindex)
					elseif arg_134_0 == 2 then
						global_ShowBlockWords(L_HORCRUXSELECT_WARNING[2])
						audio_manager:playeffectMusicTest("sound/invalid")
					elseif arg_134_0 == 3 then
						global_ShowBlockWords(L_HORCRUXSELECT_WARNING[3])
						audio_manager:playeffectMusicTest("sound/invalid")
					elseif arg_134_0 == 4 then
						global_ShowBlockWords(L_HORCRUXSELECT_WARNING[4])
						audio_manager:playeffectMusicTest("sound/invalid")
					elseif arg_134_0 == 6 then
						audio_manager:playeffectMusicTest("sound/invalid")
						global_ShowBlockWords(L_HORCRUXSELECT_WARNING[6])
					elseif arg_134_0 == 7 then
						audio_manager:playeffectMusicTest("sound/invalid")
						global_ShowBlockWords(L_HORCRUXSELECT_WARNING[7])
					end

					arg_132_0:setBright(true)
				end)
			end

			if array_manager:isHorcruxInArrayNowHpInherit(self.curHorcrux) then
				local var_132_2 = array_manager:getArrayByHorcruxIDHpInherit(self.curHorcrux)

				self:showSeizeArrayMemberPop("您当前选择的魂器已被其他角色装备\n是否进行更换", var_132_1)
				arg_132_0:setBright(true)
			else
				var_132_1()
			end
		end,
		[SELECT_HORCRUX_SUBSTITUTION] = function(arg_135_0, arg_135_1)
			if arg_135_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_135_0:isBright() then
				return
			end

			require("controller.formation.formation_overclock_manager"):getInstance():requestUpdateArrayAssisgirl(substitution_manager:getMode(), (arg_135_0:getTag() ~= 3 or nil) and (self.curHorcrux or nil), self.selectArrayPos, self.selectArrayIndex, function(arg_136_0)
				if arg_136_0.result == 1 then
					if self.selectCallback then
						self.selectCallback()
					end

					LayerManager:removePopLayer(self.__queueindex)
				end
			end)
		end,
		[SELECT_HORCRUX_TVT_DEFENCE] = function(arg_137_0, arg_137_1)
			if arg_137_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_137_0:isBright() then
				return
			end

			var_96_4(arg_137_0, arg_137_1)
		end,
		[SELECT_HORCRUX_TVT_ATTACK] = function(arg_138_0, arg_138_1)
			if arg_138_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_138_0:isBright() then
				return
			end

			var_96_5(arg_138_0, arg_138_1)
		end,
		[SELECT_HORCRUX_SUBSTITUTION_OLD] = function(arg_139_0, arg_139_1)
			if arg_139_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_139_0:isBright() then
				return
			end

			require("controller.formation.formation_old_substitute_manager"):getInstance():requestUpdateArrayAssisgirl(nil, (arg_139_0:getTag() ~= 3 or nil) and (self.curHorcrux or nil), self.selectArrayPos, self.selectArrayIndex, function(arg_140_0)
				if arg_140_0.result == 1 then
					if self.selectCallback then
						self.selectCallback()
					end

					LayerManager:removePopLayer(self.__queueindex)
				end
			end)
		end,
		[SELECT_HORCRUX_DEVOUR] = function(arg_141_0, arg_141_1)
			if arg_141_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_141_0:isBright() then
				return
			end

			require("controller/horcrux_devour/horcrux_devour_select_manager"):getInstance():setDevourHorcrux(self.curHorcrux, function(arg_142_0)
				if arg_142_0 == 1 then
					LayerManager:removePopLayer(self.__queueindex)
				end
			end)
		end
	})[self.selectType]
end

function HorcruxSelectLayer:updateBottomList(arg_143_1)
	if self.dataMgr:getDataCount() <= 0 then
		self.bottomList:getBtn("sureBtn"):setVisible(false)

		return
	else
		self.bottomList:getBtn("sureBtn"):setVisible(true)
	end

	;({
		[SELECT_HORCRUX_FIGHT] = function(arg_144_0)
			self.bottomList:getBtn("sureBtn"):setTag(arg_144_0)
			self.bottomList:getBtn("sureBtn"):getChildByName("word"):setString(L_HORCRUXSELECT_SURE_BTN[1][arg_144_0])

			if self.curHorcrux or self.selectCurHorcrux then
				self.bottomList:getBtn("infoBtn"):setVisible(true)
			else
				self.bottomList:getBtn("infoBtn"):setVisible(false)
			end
		end,
		[SELECT_HORCRUX_FIGHT_MODE] = function(arg_145_0)
			self.bottomList:getBtn("sureBtn"):setTag(arg_145_0)
			self.bottomList:getBtn("sureBtn"):getChildByName("word"):setString(L_HORCRUXSELECT_SURE_BTN[1][arg_145_0])

			if self.curHorcrux or self.selectCurHorcrux then
				self.bottomList:getBtn("infoBtn"):setVisible(true)
			else
				self.bottomList:getBtn("infoBtn"):setVisible(false)
			end
		end,
		[SELECT_HORCRUX_FIGHT_ELEMENTS] = function(arg_146_0)
			self.bottomList:getBtn("sureBtn"):setTag(arg_146_0)
			self.bottomList:getBtn("sureBtn"):getChildByName("word"):setString(L_HORCRUXSELECT_SURE_BTN[1][arg_146_0])

			if self.curHorcrux or self.selectCurHorcrux then
				self.bottomList:getBtn("infoBtn"):setVisible(true)
			else
				self.bottomList:getBtn("infoBtn"):setVisible(false)
			end
		end,
		[SELECT_HORCRUX_FIGHT_POINT] = function(arg_147_0)
			self.bottomList:getBtn("sureBtn"):setTag(arg_147_0)
			self.bottomList:getBtn("sureBtn"):getChildByName("word"):setString(L_HORCRUXSELECT_SURE_BTN[1][arg_147_0])

			if self.curHorcrux or self.selectCurHorcrux then
				self.bottomList:getBtn("infoBtn"):setVisible(true)
			else
				self.bottomList:getBtn("infoBtn"):setVisible(false)
			end
		end,
		[SELECT_HORCRUX_FIGHT_MATERIAL] = function(arg_148_0)
			self.bottomList:getBtn("sureBtn"):setTag(arg_148_0)
			self.bottomList:getBtn("sureBtn"):getChildByName("word"):setString(L_HORCRUXSELECT_SURE_BTN[1][arg_148_0])

			if self.curHorcrux or self.selectCurHorcrux then
				self.bottomList:getBtn("infoBtn"):setVisible(true)
			else
				self.bottomList:getBtn("infoBtn"):setVisible(false)
			end
		end,
		[SELECT_HORCRUX_EXPLORE_HP_INHERIT] = function(arg_149_0)
			self.bottomList:getBtn("sureBtn"):setTag(arg_149_0)
			self.bottomList:getBtn("sureBtn"):getChildByName("word"):setString(L_HORCRUXSELECT_SURE_BTN[1][arg_149_0])

			if self.curHorcrux or self.selectCurHorcrux then
				self.bottomList:getBtn("infoBtn"):setVisible(true)
			else
				self.bottomList:getBtn("infoBtn"):setVisible(false)
			end
		end,
		[SELECT_HORCRUX_EXPLORE] = function(arg_150_0)
			self.bottomList:getBtn("sureBtn"):setTag(arg_150_0)
			self.bottomList:getBtn("sureBtn"):getChildByName("word"):setString(L_HORCRUXSELECT_SURE_BTN[1][arg_150_0])

			if self.curHorcrux or self.selectCurHorcrux then
				self.bottomList:getBtn("infoBtn"):setVisible(true)
			else
				self.bottomList:getBtn("infoBtn"):setVisible(false)
			end
		end,
		[SELECT_HORCRUX_SPECIAL] = function(arg_151_0)
			self.bottomList:getBtn("sureBtn"):setTag(arg_151_0)
			self.bottomList:getBtn("sureBtn"):getChildByName("word"):setString(L_HORCRUXSELECT_SURE_BTN[1][arg_151_0])

			if self.curHorcrux or self.selectCurHorcrux then
				self.bottomList:getBtn("infoBtn"):setVisible(true)
			else
				self.bottomList:getBtn("infoBtn"):setVisible(false)
			end
		end,
		[SELECT_HORCRUX_WORK] = function(arg_152_0)
			return
		end,
		[SELECT_HORCRUX_COMPOUND] = function(arg_153_0)
			self.bottomList:getBtn("sureBtn"):setTag(arg_153_0)
			self.bottomList:getBtn("sureBtn"):getChildByName("word"):setString(L_HORCRUXSELECT_SURE_BTN[2][arg_153_0])

			if self.curHorcrux then
				self.bottomList:getBtn("sureBtn"):setVisible(true)
			else
				self.bottomList:getBtn("sureBtn"):setVisible(false)
			end
		end,
		[SELECT_HORCRUX_ARENA_DEFENCE] = function(arg_154_0)
			self.bottomList:getBtn("sureBtn"):setTag(arg_154_0)
			self.bottomList:getBtn("sureBtn"):getChildByName("word"):setString(L_HORCRUXSELECT_SURE_BTN[1][arg_154_0])

			if self.curHorcrux or self.selectCurHorcrux then
				self.bottomList:getBtn("infoBtn"):setVisible(true)
			else
				self.bottomList:getBtn("infoBtn"):setVisible(false)
			end
		end,
		[SELECT_HORCRUX_ARENA_ATTACK] = function(arg_155_0)
			self.bottomList:getBtn("sureBtn"):setTag(arg_155_0)
			self.bottomList:getBtn("sureBtn"):getChildByName("word"):setString(L_HORCRUXSELECT_SURE_BTN[1][arg_155_0])

			if self.curHorcrux or self.selectCurHorcrux then
				self.bottomList:getBtn("infoBtn"):setVisible(true)
			else
				self.bottomList:getBtn("infoBtn"):setVisible(false)
			end
		end,
		[SELECT_HORCRUX_SUBSTITUTION] = function(arg_156_0)
			self.bottomList:getBtn("sureBtn"):setTag(arg_156_0)
			self.bottomList:getBtn("sureBtn"):getChildByName("word"):setString(L_HORCRUXSELECT_SURE_BTN[1][arg_156_0])

			if self.curHorcrux or self.selectCurHorcrux then
				self.bottomList:getBtn("infoBtn"):setVisible(true)
			else
				self.bottomList:getBtn("infoBtn"):setVisible(false)
			end
		end,
		[SELECT_HORCRUX_TVT_DEFENCE] = function(arg_157_0)
			self.bottomList:getBtn("sureBtn"):setTag(arg_157_0)
			self.bottomList:getBtn("sureBtn"):getChildByName("word"):setString(L_HORCRUXSELECT_SURE_BTN[1][arg_157_0])

			if self.curHorcrux or self.selectCurHorcrux then
				self.bottomList:getBtn("infoBtn"):setVisible(true)
			else
				self.bottomList:getBtn("infoBtn"):setVisible(false)
			end
		end,
		[SELECT_HORCRUX_TVT_ATTACK] = function(arg_158_0)
			self.bottomList:getBtn("sureBtn"):setTag(arg_158_0)
			self.bottomList:getBtn("sureBtn"):getChildByName("word"):setString(L_HORCRUXSELECT_SURE_BTN[1][arg_158_0])

			if self.curHorcrux or self.selectCurHorcrux then
				self.bottomList:getBtn("infoBtn"):setVisible(true)
			else
				self.bottomList:getBtn("infoBtn"):setVisible(false)
			end
		end,
		[SELECT_HORCRUX_SUBSTITUTION_OLD] = function(arg_159_0)
			self.bottomList:getBtn("sureBtn"):setTag(arg_159_0)
			self.bottomList:getBtn("sureBtn"):getChildByName("word"):setString(L_HORCRUXSELECT_SURE_BTN[1][arg_159_0])

			if self.curHorcrux or self.selectCurHorcrux then
				self.bottomList:getBtn("infoBtn"):setVisible(true)
			else
				self.bottomList:getBtn("infoBtn"):setVisible(false)
			end
		end,
		[SELECT_HORCRUX_DEVOUR] = function(arg_160_0)
			self.bottomList:getBtn("sureBtn"):getChildByName("word"):setString(L_HORCRUXSELECT_SURE_BTN[3][arg_160_0])
		end
	})[self.selectType](arg_143_1)
	self.bottomList:getBtn("sureBtn"):setVisible(self.curHorcrux ~= nil or self.selectCurHorcrux ~= nil)
end

function HorcruxSelectLayer:initHorcruxListPanel()
	local var_161_0 = var_0_26 + GameDisplay.fix_y * 2 - var_0_24

	self.listPanel = cc.TableView:create(cc.size(var_0_25, var_0_26 + GameDisplay.fix_y * 2 - var_0_24))

	self.listPanel:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.listPanel:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.listPanel:setPosition(cc.p(var_0_27, var_0_28 - GameDisplay.fix_y))
	self.listPanel:setDelegate()
	self.rootLayer:addChild(self.listPanel)
	self.listPanel:registerScriptHandler(function(arg_162_0, arg_162_1)
		return var_0_29, var_0_30
	end, cc.TABLECELL_SIZE_FOR_INDEX)

	local function var_161_1(arg_163_0, arg_163_1)
		if arg_163_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_163_0:getTouchBeganPosition().y - arg_163_0:getTouchEndPosition().y) > 50 then
			return
		end

		if not arg_163_0.entityid then
			return
		end

		local var_163_0 = arg_163_0.entityid

		if self.isHpInherit and explore_manager:queryHorcruxIsUsed(var_163_0) then
			return
		end

		if var_163_0 == self.curHorcrux then
			return
		end

		self:selectHorcrux(var_163_0)

		if self.curIndex and self.curIndex ~= arg_163_0.index then
			self.listPanel:updateCellAtIndex(self.curIndex)
		end

		self.listPanel:updateCellAtIndex(arg_163_0.index)

		self.curIndex = arg_163_0.index
	end

	local function var_161_2(arg_164_0)
		if self.curSortOrders == 1 then
			return arg_164_0
		else
			return self.dataMgr:getDataCount() + 1 - arg_164_0
		end
	end

	local function var_161_4(arg_167_0)
		if self.selectType == SELECT_HORCRUX_SPECIAL then
			if self.usedHorcrux[arg_167_0.entityid] then
				arg_167_0:getChildByName("fightingtag"):setVisible(true)
				arg_167_0:getChildByName("fightingtag"):getChildByName("fightlabel"):setString(L_HORCRUXSELECT_FIGHT_TAG)
			else
				arg_167_0:getChildByName("fightingtag"):setVisible(false)
			end
		end

		if self.isHpInherit and explore_manager:queryHorcruxIsUsed(arg_167_0.entityid) then
			arg_167_0:getChildByName("fightingtag"):setVisible(true)
			arg_167_0:getChildByName("fightingtag"):getChildByName("fightlabel"):setString(L_HORCRUXSELECT_CACHED)
		end
	end

	self.listPanel:registerScriptHandler(function(arg_168_0, arg_168_1)
		local var_168_0 = arg_168_0:dequeueCell()
		local var_168_1 = 4

		if not var_168_0 then
			var_168_0 = cc.TableViewCell:create()

			var_168_0:setName("cell_" .. arg_168_1)

			for iter_168_0 = 1, var_168_1 do
				local var_168_3 = HorcruxSprite:create({
					initType = self.selectType == SELECT_HORCRUX_ARENA_ATTACK and "areanAttackStyle" or self.selectType == SELECT_HORCRUX_ARENA_DEFENCE and "areanDefenceStyle" or self.selectType == SELECT_HORCRUX_TVT_DEFENCE and "tvtDefenceStyle" or self.selectType == SELECT_HORCRUX_TVT_ATTACK and "previewStyle" or self.selectType == SELECT_HORCRUX_SUBSTITUTION and "subStyle" or self.selectType == SELECT_HORCRUX_FIGHT_POINT and "areanAttackStyle" or self.selectType == SELECT_HORCRUX_FIGHT_ELEMENTS and "previewStyle" or self.selectType == SELECT_HORCRUX_FIGHT_MATERIAL and "previewStyle" or self.selectType == SELECT_HORCRUX_FIGHT_MODE and "previewStyle" or self.selectType == SELECT_HORCRUX_SUBSTITUTION_OLD and "previewStyle" or "previewStyle",
					isHpInherit = self.isHpInherit
				})

				var_168_3:setScale(var_0_32)
				var_168_3:setSwallowTouches(false)
				var_168_3:setName("sp_" .. iter_168_0)
				var_168_3:setPosition(var_0_31[iter_168_0])
				var_168_0:addChild(var_168_3)
				var_168_3:addTouchEventListener(var_161_1)
				var_168_3:getChildByName("lock"):setTouchEnabled(false)
				self:addCurHorcruxLabel(var_168_3)

				local var_168_4 = var_161_2(var_168_1 * arg_168_1 + iter_168_0)
				local var_168_5 = self.dataMgr:dequeueItem(var_168_4)

				ccui.Helper:seekWidgetByName(var_168_3, "lock"):setVisible(false)
				var_168_3.servantclip:setVisible(false)
				var_168_3.raceIcon:setVisible(true)

				if var_168_5 then
					var_168_3:updateHorcruxInfos(var_168_5, self.showAttr, not not (self.recommendHorcruxs and self.recommendHorcruxs[var_168_5]))

					var_168_3.entityid = var_168_5
					var_168_3.index = arg_168_1
					var_168_3.horcruxindex = var_168_4

					if self.selectCurHorcrux == var_168_5 then
						if var_168_3:getChildByName("fightingtag") then
							if var_168_3:getChildByName("fightingtag"):isVisible() then
								var_168_3:getChildByName("fightingtag"):setVisible(false)
							end
						end

						if var_168_3:getChildByName("lock") then
							if var_168_3:getChildByName("lock"):isVisible() then
								var_168_3:getChildByName("lock"):setVisible(false)
							end
						end

						var_168_3:getChildByName("cur_title"):setVisible(true)
					else
						var_168_3:getChildByName("cur_title"):setVisible(false)
					end

					var_161_4(var_168_3)
				else
					var_168_3:setVisible(false)
				end
			end
		else
			for iter_168_1 = 1, var_168_1 do
				local var_168_7 = var_168_0:getChildByName("sp_" .. iter_168_1)
				local var_168_8 = var_161_2(var_168_1 * arg_168_1 + iter_168_1)
				local var_168_9 = self.dataMgr:dequeueItem(var_168_8)

				ccui.Helper:seekWidgetByName(var_168_7, "lock"):setVisible(false)
				var_168_7.servantclip:setVisible(false)
				var_168_7.raceIcon:setVisible(true)

				if var_168_9 then
					local var_168_10 = not not (self.recommendHorcruxs and self.recommendHorcruxs[var_168_9])

					var_168_7:updateFrameBg(var_168_9 == self.curHorcrux)
					var_168_7:updateHorcruxInfos(var_168_9, self.showAttr, var_168_10)

					var_168_7.entityid = var_168_9
					var_168_7.index = arg_168_1
					var_168_7.horcruxindex = var_168_8

					var_168_7:setVisible(true)
					var_168_7:stopAllActions()
					var_168_7:setPosition(var_0_31[iter_168_1])

					if self.selectCurHorcrux == var_168_9 then
						if var_168_7:getChildByName("fightingtag") then
							if var_168_7:getChildByName("fightingtag"):isVisible() then
								var_168_7:getChildByName("fightingtag"):setVisible(false)
							end
						end

						if var_168_7:getChildByName("lock") then
							if var_168_7:getChildByName("lock"):isVisible() then
								var_168_7:getChildByName("lock"):setVisible(false)
							end
						end

						var_168_7:getChildByName("cur_title"):setVisible(true)
					else
						var_168_7:getChildByName("cur_title"):setVisible(false)
					end

					var_161_4(var_168_7)
				else
					var_168_7.entityid = nil
					var_168_7.index = nil
					var_168_7.horcruxindex = nil

					var_168_7:setVisible(false)
				end
			end
		end

		if self.startRunOutAni then
			self.startIndex = self.startIndex or arg_168_1

			local var_168_11 = LAYER_OUT_TIME / math.ceil(var_161_0 / var_0_30)

			for iter_168_2 = 1, var_168_1 do
				if var_168_0:getChildByName("sp_" .. iter_168_2) then
					var_168_0:getChildByName("sp_" .. iter_168_2):runAction(cc.Sequence:create(cc.DelayTime:create((arg_168_1 - self.startIndex) * var_168_11), cc.FadeOut:create(var_168_11)))
				end
			end
		end

		if self.selectTblAni then
			local var_168_12 = LAYER_OUT_TIME / math.ceil(var_161_0 / var_0_30) * 1.5

			for iter_168_3 = 1, var_168_1 do
				if var_168_0:getChildByName("sp_" .. iter_168_3) then
					var_168_0:getChildByName("sp_" .. iter_168_3):setOpacity(0)
					var_168_0:getChildByName("sp_" .. iter_168_3):runAction(cc.Sequence:create(cc.DelayTime:create(arg_168_1 * var_168_12), cc.FadeIn:create(var_168_12)))
				end
			end
		else
			for iter_168_4 = 1, var_168_1 do
				if var_168_0:getChildByName("sp_" .. iter_168_4) then
					var_168_0:getChildByName("sp_" .. iter_168_4):setOpacity(255)
				end
			end
		end

		return var_168_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.listPanel:registerScriptHandler(function(arg_169_0, arg_169_1)
		return self:getHorcruxListLen()
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.listPanel:reloadData()

	if sortOrder == 1 then
		-- block empty
	end

	self.curIndex = 0
end

function HorcruxSelectLayer:getHorcruxListLen()
	if self.oldCellCount then
		return self.oldCellCount
	end

	local var_170_0 = math.ceil(self.dataMgr:getDataCount() / 4)

	if var_170_0 < 5 then
		var_170_0 = 5
	end

	return var_170_0
end

function HorcruxSelectLayer.addCurHorcruxLabel(arg_171_0, arg_171_1)
	local var_171_0 = ccui.ImageView:create("public/box/used_on.png", var_0_17)

	var_171_0:setScale9Enabled(true)
	var_171_0:setCapInsets(cc.rect(50, 20, 1, 1))
	var_171_0:setPosition(cc.p(arg_171_1:getContentSize().width / 2, 80))
	var_171_0:setVisible(false)
	var_171_0:setName("cur_title")
	var_171_0:setContentSize(cc.size(arg_171_1:getContentSize().width - 6, var_171_0:getContentSize().height))
	arg_171_1:addChild(var_171_0, 100)

	local var_171_1 = cc.Label:createWithTTF(L_HORCRUXSELECT_CUR_LABEL, "fonts/newkj.ttf", 22)

	var_171_1:setPosition(cc.p(var_171_0:getContentSize().width / 2, var_171_0:getContentSize().height / 2))
	var_171_1:setColor(cc.c3b(255, 100, 0))
	var_171_0:addChild(var_171_1)
end

function HorcruxSelectLayer:updateShowingCells()
	local var_172_0, var_172_1 = GetTableViewShowCellIdx(self.listPanel, {
		maxcount = self:getHorcruxListLen(),
		cellsize = cc.size(var_0_29, var_0_30)
	})

	for iter_172_0 = var_172_0, var_172_1 do
		self.listPanel:updateCellAtIndex(iter_172_0)
	end
end

function HorcruxSelectLayer:selectHorcrux(arg_173_1)
	if not arg_173_1 then
		return
	end

	if arg_173_1 == self.curHorcrux then
		return
	end

	self.curHorcrux = arg_173_1

	self:updateHorcruxFrame(self.comparedHorcruxFrame, self.curHorcrux, "other")
	;({
		[SELECT_HORCRUX_FIGHT] = function()
			local var_174_0, var_174_1 = var_0_33(array_manager:getBattleArrayData(self.selectArrayIndex), arg_173_1, self.selectArrayPos)

			if var_174_0 then
				if var_174_1 then
					self:updateBottomList(3)
				else
					self:updateBottomList(4)
				end
			elseif self.selectCurHorcrux then
				self:updateBottomList(2)
			else
				self:updateBottomList(1)
			end
		end,
		[SELECT_HORCRUX_FIGHT_MODE] = function()
			local var_175_0, var_175_1 = var_0_33(require("controller.formation.formation_manager"):getInstance():getFormationInfoBySelectHorcruxType(SELECT_HORCRUX_FIGHT_MODE, self.selectArrayIndex), arg_173_1, self.selectArrayPos)

			if var_175_0 then
				if var_175_1 then
					self:updateBottomList(3)
				else
					self:updateBottomList(4)
				end
			elseif self.selectCurHorcrux then
				self:updateBottomList(2)
			else
				self:updateBottomList(1)
			end
		end,
		[SELECT_HORCRUX_FIGHT_ELEMENTS] = function()
			local var_176_0, var_176_1 = var_0_33(require("controller.formation.formation_manager"):getInstance():getFormationInfoBySelectHorcruxType(SELECT_HORCRUX_FIGHT_ELEMENTS, self.selectArrayIndex), arg_173_1, self.selectArrayPos)

			if var_176_0 then
				if var_176_1 then
					self:updateBottomList(3)
				else
					self:updateBottomList(4)
				end
			elseif self.selectCurHorcrux then
				self:updateBottomList(2)
			else
				self:updateBottomList(1)
			end
		end,
		[SELECT_HORCRUX_FIGHT_POINT] = function()
			local var_177_0, var_177_1 = var_0_33(require("controller.formation.formation_manager"):getInstance():getFormationInfoBySelectHorcruxType(SELECT_HORCRUX_FIGHT_POINT, self.selectArrayIndex), arg_173_1, self.selectArrayPos)

			if var_177_0 then
				if var_177_1 then
					self:updateBottomList(3)
				else
					self:updateBottomList(4)
				end
			elseif self.selectCurHorcrux then
				self:updateBottomList(2)
			else
				self:updateBottomList(1)
			end
		end,
		[SELECT_HORCRUX_FIGHT_MATERIAL] = function()
			local var_178_0, var_178_1 = var_0_33(require("controller.formation.formation_manager"):getInstance():getFormationInfoBySelectHorcruxType(SELECT_HORCRUX_FIGHT_MATERIAL, self.selectArrayIndex), arg_173_1, self.selectArrayPos)

			if var_178_0 then
				if var_178_1 then
					self:updateBottomList(3)
				else
					self:updateBottomList(4)
				end
			elseif self.selectCurHorcrux then
				self:updateBottomList(2)
			else
				self:updateBottomList(1)
			end
		end,
		[SELECT_HORCRUX_EXPLORE_HP_INHERIT] = function()
			local var_179_0, var_179_1 = var_0_33(array_manager:getBattleArrayDataHpInherit(self.selectArrayIndex), arg_173_1, self.selectArrayPos)

			if var_179_0 then
				if var_179_1 then
					self:updateBottomList(3)
				else
					self:updateBottomList(4)
				end
			elseif self.selectCurHorcrux then
				self:updateBottomList(2)
			else
				self:updateBottomList(1)
			end
		end,
		[SELECT_HORCRUX_WORK] = function()
			if arg_173_1 == self.selectCurHorcrux then
				self:updateBottomList(3)
			else
				self:updateBottomList(1)
			end
		end,
		[SELECT_HORCRUX_COMPOUND] = function()
			if arg_173_1 == self.selectCurHorcrux then
				self:updateBottomList(3)
			elseif arg_173_1 then
				self:updateBottomList(2)
			else
				self:updateBottomList(1)
			end
		end,
		[SELECT_HORCRUX_EXPLORE] = function()
			local var_182_0, var_182_1 = var_0_33(self.selectArrayBattle, arg_173_1, self.selectArrayPos)

			if var_182_0 then
				if var_182_1 then
					self:updateBottomList(3)
				else
					self:updateBottomList(4)
				end
			elseif self.selectCurHorcrux then
				self:updateBottomList(2)
			else
				self:updateBottomList(1)
			end
		end,
		[SELECT_HORCRUX_SPECIAL] = function()
			local var_183_0 = false
			local var_183_1 = false

			for iter_183_0, iter_183_1 in pairs(self.selectArrayBattle) do
				if not iter_183_1.npcid and iter_183_1.horcruxInfo and iter_183_1.horcruxInfo.entityid == arg_173_1 then
					var_183_0 = true

					if iter_183_0 == self.selectArrayPos then
						var_183_1 = true
					end

					break
				end
			end

			if var_183_0 then
				if var_183_1 then
					self:updateBottomList(3)
				else
					self:updateBottomList(4)
				end
			elseif self.selectCurHorcrux then
				self:updateBottomList(2)
			else
				self:updateBottomList(1)
			end
		end,
		[SELECT_HORCRUX_ARENA_DEFENCE] = function()
			local var_184_0, var_184_1 = var_0_33(array_manager:getArenaDefenceArray(), arg_173_1, self.selectArrayPos)

			if var_184_0 then
				if var_184_1 then
					self:updateBottomList(3)
				else
					self:updateBottomList(4)
				end
			elseif self.selectCurHorcrux then
				self:updateBottomList(2)
			else
				self:updateBottomList(1)
			end
		end,
		[SELECT_HORCRUX_ARENA_ATTACK] = function()
			local var_185_0, var_185_1 = var_0_33(array_manager:getArenaAttackArray(), arg_173_1, self.selectArrayPos)

			if var_185_0 then
				if var_185_1 then
					self:updateBottomList(3)
				else
					self:updateBottomList(4)
				end
			elseif self.selectCurHorcrux then
				self:updateBottomList(2)
			else
				self:updateBottomList(1)
			end
		end,
		[SELECT_HORCRUX_SUBSTITUTION] = function()
			local var_186_0, var_186_1 = var_0_33(substitution_manager:getUsingArraysData(self.selectArrayIndex), arg_173_1, self.selectArrayPos)

			if var_186_0 then
				if var_186_1 then
					self:updateBottomList(3)
				else
					self:updateBottomList(4)
				end
			elseif self.selectCurHorcrux then
				self:updateBottomList(2)
			else
				self:updateBottomList(1)
			end
		end,
		[SELECT_HORCRUX_TVT_DEFENCE] = function()
			local var_187_0, var_187_1 = var_0_33(arenatft_manager:getDefenceArrayData(self.selectArrayIndex), arg_173_1, self.selectArrayPos)

			if var_187_0 then
				if var_187_1 then
					self:updateBottomList(3)
				else
					self:updateBottomList(4)
				end
			elseif self.selectCurHorcrux then
				self:updateBottomList(2)
			else
				self:updateBottomList(1)
			end
		end,
		[SELECT_HORCRUX_TVT_ATTACK] = function()
			local var_188_0, var_188_1 = var_0_33(arenatft_manager:getAttackArrayData(self.selectArrayIndex), arg_173_1, self.selectArrayPos)

			if var_188_0 then
				if var_188_1 then
					self:updateBottomList(3)
				else
					self:updateBottomList(4)
				end
			elseif self.selectCurHorcrux then
				self:updateBottomList(2)
			else
				self:updateBottomList(1)
			end
		end,
		[SELECT_HORCRUX_SUBSTITUTION_OLD] = function()
			local var_189_0, var_189_1 = var_0_33(require("controller.formation.formation_old_substitute_manager"):getInstance():getFormationInfo()[self.selectArrayIndex], arg_173_1, self.selectArrayPos)

			if var_189_0 then
				if var_189_1 then
					self:updateBottomList(3)
				else
					self:updateBottomList(4)
				end
			elseif self.selectCurHorcrux then
				self:updateBottomList(2)
			else
				self:updateBottomList(1)
			end
		end,
		[SELECT_HORCRUX_DEVOUR] = function()
			if self.selectCurHorcrux then
				self:updateBottomList(2)
			else
				self:updateBottomList(1)
			end
		end
	})[self.selectType]()

	if self.bottomList:getChildByName("infoBtn") then
		self.bottomList:getChildByName("infoBtn"):setVisible(self.curHorcrux ~= nil or self.selectCurHorcrux ~= nil)
	end
end

function HorcruxSelectLayer.initCollectPanel(arg_191_0)
	return
end

function HorcruxSelectLayer:initComparedFrame()
	local function var_192_0()
		local var_193_0 = ccui.ImageView:create("HorcruxSelectLayer/contrast_frame.png", var_0_17)

		var_193_0:setAnchorPoint(cc.p(0, 0))
		var_193_0:setTouchEnabled(true)

		local var_193_1 = TempWidget:CreateTempImg("HorcruxSelectLayer/quality2.png", var_193_0)

		var_193_1:align(cc.p(0.5, 1), var_193_0:getContentSize().width / 2, var_193_0:getContentSize().height)
		var_193_1:setName("qualityImg")

		local var_193_2 = ccui.ImageView:create("HorcruxSelectLayer/add_img.png", var_0_17)

		var_193_2:setPositionX(var_193_0:getContentSize().width / 2)
		var_193_2:setPositionY(var_193_0:getContentSize().height / 2 + 30)
		var_193_2:setName("statusImg")
		var_193_0:addChild(var_193_2)

		local var_193_3 = TempWidget:CreateTempLabel("", FONT_NAME, 20, var_193_0)

		var_193_3:align(cc.p(0.5, 1), var_193_0:getContentSize().width / 2, var_193_0:getContentSize().height - 20)
		var_193_3:setName("nameLabel")

		local var_193_4 = ccui.Layout:create()

		var_193_4:setContentSize(cc.size(194, 188))
		var_193_4:setAnchorPoint(cc.p(0, 0))
		var_193_4:setPosition(cc.p(5, 64))
		var_193_4:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_193_4:setBackGroundColor(cc.c3b(0, 0, 0))
		var_193_4:setBackGroundColorOpacity(200)
		var_193_4:setTouchEnabled(false)
		var_193_4:setVisible(false)
		var_193_4:setName("skillBg")
		var_193_0:addChild(var_193_4, 10)

		local var_193_5 = cc.Label:createWithTTF("", FONT_NAME, 28)

		var_193_5:setColor(cc.c3b(255, 150, 0))
		var_193_5:setAnchorPoint(cc.p(0, 0.5))
		var_193_5:setPosition(cc.p(10, 155))
		var_193_5:setName("skillNameLabel")
		var_193_4:addChild(var_193_5)

		local var_193_6 = cc.Label:createWithTTF("", FONT_DES, 24)

		var_193_6:setAnchorPoint(cc.p(0, 1))
		var_193_6:setPosition(cc.p(10, 130))
		var_193_6:setName("skillDesLabel")
		var_193_6:setMaxLineWidth(170)
		var_193_6:setLineBreakWithoutSpace(true)
		var_193_4:addChild(var_193_6)

		local var_193_7 = TempWidget:CreateTempImg("HorcruxSelectLayer/attrbg.png", var_193_0)

		var_193_7:setName("attrBg")
		var_193_7:align(cc.p(0.5, 0), var_193_0:getContentSize().width / 2, 50)
		TempWidget:CreateTempImg("HorcruxSelectLayer/attr_hp.png", var_193_7):align(cc.p(0, 0.5), 50, var_193_7:size().h / 2 - 17.5)
		TempWidget:CreateTempImg("HorcruxSelectLayer/attr_atk.png", var_193_7):align(cc.p(0, 0.5), 50, var_193_7:size().h / 2 + 17.5)

		local var_193_8 = TempWidget:CreateTempImg("public/rolebg/grade_c.png", var_193_0)

		var_193_8:setName("damageAptitudeImg")
		var_193_8:hide()
		var_193_8:setScale(0.8)
		var_193_8:align(cc.p(0.5, 0.5), var_193_7:pos().x - var_193_7:size().w / 2 + 23, var_193_7:pos().y + var_193_7:size().h / 2 + 17)

		local var_193_9 = TempWidget:CreateTempImg("HorcruxSelectLayer/double_up.png", var_193_0)

		var_193_9:setName("damageLabelDoubleUp")
		var_193_9:align(cc.p(0, 0.5), 140, var_193_7:getPositionY() + 50)

		local var_193_10 = cc.Label:createWithTTF("", FONT_NAME, 24)

		var_193_10:setPosition(cc.p(var_193_0:getContentSize().width - 50, var_193_7:getPositionY() + 50))
		var_193_10:setAnchorPoint(cc.p(1, 0.5))
		var_193_10:setColor(var_0_20)
		var_193_10:setName("damageLabel")
		var_193_0:addChild(var_193_10)

		local var_193_11 = TempWidget:CreateTempImg("HorcruxSelectLayer/compare_up.png", var_193_0)

		var_193_11:hide()
		var_193_11:align(cc.p(0, 0.5), var_193_10:getPositionX() + 10, var_193_10:getPositionY())
		var_193_11:setName("damageLabelCompare")

		local var_193_12 = TempWidget:CreateTempImg("public/rolebg/grade_c.png", var_193_0)

		var_193_12:setName("hpAptitudeImg")
		var_193_12:hide()
		var_193_12:setScale(0.8)
		var_193_12:align(cc.p(0.5, 0.5), var_193_8:pos().x, var_193_7:pos().y + var_193_7:size().h / 2 - 17)

		local var_193_13 = TempWidget:CreateTempImg("HorcruxSelectLayer/double_up.png", var_193_0)

		var_193_13:setName("hpLabelDoubleUp")
		var_193_13:align(cc.p(0, 0.5), var_193_9:pos().x, var_193_7:getPositionY() + 13)

		local var_193_14 = cc.Label:createWithTTF("", FONT_NAME, 24)

		var_193_14:setPosition(cc.p(var_193_0:getContentSize().width - 50, var_193_7:getPositionY() + 13))
		var_193_14:setAnchorPoint(cc.p(1, 0.5))
		var_193_14:setColor(var_0_20)
		var_193_14:setName("hpLabel")
		var_193_0:addChild(var_193_14)

		local var_193_15 = TempWidget:CreateTempImg("HorcruxSelectLayer/compare_up.png", var_193_0)

		var_193_15:align(cc.p(0, 0.5), var_193_14:getPositionX() + 10, var_193_14:getPositionY())
		var_193_15:hide()
		var_193_15:setName("hpLabelCompare")

		local var_193_16 = HorcruxSprite:create({
			initType = "previewTopStype"
		})

		var_193_16:setName("horcruxSp")
		var_193_16:setAnchorPoint(cc.p(0.5, 0.5))
		var_193_16:setPosition(cc.p(var_193_0:getContentSize().width / 2, var_193_0:getContentSize().height / 2 + 40))
		var_193_0:addChild(var_193_16)
		var_193_16:addTouchEventListener(function(arg_194_0, arg_194_1)
			if arg_194_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_194_0.entityid then
				return
			end

			if self.selectType ~= SELECT_HORCRUX_FIGHT and self.selectType ~= SELECT_HORCRUX_EXPLORE and self.selectType ~= SELECT_HORCRUX_SPECIAL and self.selectType ~= SELECT_HORCRUX_ARENA_DEFENCE and self.selectType ~= SELECT_HORCRUX_ARENA_ATTACK and self.selectType ~= SELECT_HORCRUX_TVT_DEFENCE and self.selectType ~= SELECT_HORCRUX_TVT_ATTACK and self.selectType ~= SELECT_HORCRUX_SUBSTITUTION and self.selectType ~= SELECT_HORCRUX_FIGHT_MODE and self.selectType ~= SELECT_HORCRUX_FIGHT_POINT and self.selectType ~= SELECT_HORCRUX_FIGHT_MATERIAL and self.selectType ~= SELECT_HORCRUX_FIGHT_ELEMENTS and self.selectType ~= SELECT_HORCRUX_SUBSTITUTION_OLD then
				return
			end

			self:saveDecomposeBeforeShowingCells()
			LayerManager:pushInLayer("HorcruxInfoLayer", arg_194_0.entityid, nil, self.isHpInherit)
		end)

		return var_193_0
	end

	self.curHorcruxFrame = var_192_0()

	self.curHorcruxFrame:setPosition(cc.p(0, 730 + GameDisplay.fix_y))
	self.curHorcruxFrame:setName("leftHorcrux")
	self.rootLayer:addChild(self.curHorcruxFrame)

	self.comparedHorcruxFrame = var_192_0()

	self.comparedHorcruxFrame:setName("rightHorcurx")
	self.comparedHorcruxFrame:setPosition(cc.p(320, 730 + GameDisplay.fix_y))
	self.rootLayer:addChild(self.comparedHorcruxFrame)

	local var_192_1 = TempWidget:CreateTempImg("HorcruxSelectLayer/exchange.png", self.rootLayer)

	var_192_1:align(cc.p(0.5, 1), 320, self.curHorcruxFrame:getPositionY() + self.curHorcruxFrame:getContentSize().height / 2 + 90)

	local var_192_2 = TempWidget:CreateTempLabel("替换", FONT_NAME, 22, var_192_1)

	var_192_2:center()
	var_192_2:_setColor("02f0ff")
	self:createSkillDrawer()
	self:updateHorcruxFrame(self.curHorcruxFrame, self.selectCurHorcrux, "self")
	self:updateHorcruxFrame(self.comparedHorcruxFrame, self.curHorcrux, "other")
end

function HorcruxSelectLayer:createSkillDrawer()
	local var_195_0 = 281
	local var_195_1 = 0

	if self.isHorcruxDevour then
		var_195_1 = -80
		var_195_0 = var_195_0 + -80
	end

	local var_195_2 = TempWidget:CreateTempLayout()

	var_195_2:setContentSize(cc.size(GameDisplay.width, 320))
	var_195_2:setClippingEnabled(true)
	var_195_2:setBackGroundColorOpacity(100)
	self.rootLayer:addChild(var_195_2, 10)
	var_195_2:align(cc.p(0.5, 1), self.rootLayer:getContentSize().width / 2, self.curHorcruxFrame:getPositionY() + 50 - var_0_24)

	local var_195_3 = TempWidget:CreateTempLayout(var_195_2)

	var_195_3:setContentSize(var_195_2:size())

	self.moveLayout = var_195_3

	local var_195_4 = TempWidget:CreateTempBtn("HorcruxSelectLayer/move_btn.png", var_195_3)

	var_195_4:setLocalZOrder(1)
	var_195_4:align(cc.p(0.5, 0), var_195_3:size().w / 2, 0)
	var_195_4:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(2, cc.p(0, 7)), cc.MoveBy:create(2, cc.p(0, -7)))))
	var_195_3:align(cc.p(0, 0), 0, var_195_2:size().h - var_195_4:size().h + 2)

	var_195_4.isMoveing = false
	var_195_4.moveDir = 1

	var_195_4:_addEvent(function()
		if not var_195_4.isMoveing then
			var_195_4.isMoveing = true

			if var_195_4.moveDir == 0 then
				var_195_4:setFlippedY(false)
				var_195_3:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(0, var_195_2:size().h - var_195_4:size().h + 2)), cc.CallFunc:create(function()
					var_195_4.moveDir = 1
					var_195_4.isMoveing = false
				end)))
				self.listPanel:runAction(cc.Sequence:create(cc.CallFunc:create(function()
					local var_198_0 = self.listPanel:getContentOffset()

					self.listPanel:setPositionY(var_0_28 - GameDisplay.fix_y - var_195_0)
					self.listPanel:setViewSize(cc.size(var_0_25, var_0_26 + GameDisplay.fix_y * 2 - var_0_24))
					self.listPanel:setContentOffset(cc.p(var_198_0.x, var_198_0.y + var_195_0))
				end), cc.MoveBy:create(0.5, cc.p(0, var_195_0)), cc.DelayTime:create(0.016666666666666666)))
				self.emptyImg:runAction(cc.MoveBy:create(0.5, cc.p(0, var_195_0)))
			else
				var_195_4:setFlippedY(true)
				var_195_3:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(0, -var_195_1)), cc.CallFunc:create(function()
					var_195_4.moveDir = 0
					var_195_4.isMoveing = false
				end)))
				self.listPanel:runAction(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(0, -var_195_0)), cc.DelayTime:create(0.016666666666666666), cc.CallFunc:create(function()
					local var_200_0 = self.listPanel:getContentOffset()

					self.listPanel:setPosition(cc.p(var_0_27, var_0_28 - GameDisplay.fix_y))
					self.listPanel:setViewSize(cc.size(var_0_25, var_0_26 + GameDisplay.fix_y * 2 - var_0_24 - var_195_0))
					self.listPanel:setContentOffset(cc.p(var_200_0.x, var_200_0.y - var_195_0))
				end)))
				self.emptyImg:runAction(cc.MoveBy:create(0.5, cc.p(0, -var_195_0)))
			end
		end
	end)

	local var_195_5 = TempWidget:CreateTempLayout(var_195_3)

	var_195_5:_addEvent(function()
		return
	end)
	var_195_5:setContentSize(cc.size(var_195_3:size().w / 2, var_195_3:size().h))
	var_195_5:align(cc.p(0, 1), 0, var_195_3:size().h)

	self.selfSkillLayout = var_195_5

	local var_195_6 = TempWidget:CreateTempLayout(var_195_3)

	var_195_6:_addEvent(function()
		return
	end)
	var_195_6:setContentSize(var_195_5:size())
	var_195_6:align(cc.p(1, 1), var_195_3:size().w, var_195_3:size().h)

	self.otherSkillLayout = var_195_6

	local function var_195_7(arg_203_0)
		TempWidget:CreateTempImg("HorcruxSelectLayer/show_hide.png", arg_203_0):align(cc.p(0.5, 0), arg_203_0:size().w / 2, 0)

		local var_203_0 = TempWidget:CreateTempImg("HorcruxSelectLayer/skill_bg_down.png", arg_203_0)

		var_203_0:align(cc.p(0, 0.5), 20, arg_203_0:size().h - 30)
		var_203_0:setName("raceImgBgDown")
		var_203_0:hide()

		local var_203_1 = TempWidget:CreateTempImg(nil, arg_203_0)

		var_203_1:setName("raceImg")
		var_203_1:setScale(0.5)
		var_203_1:align(cc.p(0, 0.5), var_203_0:pos().x - 3, var_203_0:pos().y)

		local var_203_2 = TempWidget:CreateTempImg("HorcruxSelectLayer/skill_bg_up.png", arg_203_0)

		var_203_2:align(cc.p(0, 0.5), var_203_0:pos())
		var_203_2:setName("raceImgBgUp")
		var_203_2:hide()

		local var_203_3 = TempWidget:CreateTempLabel("", FONT_NAME, 17, arg_203_0)

		var_203_3:setName("raceLabel")
		var_203_3:setMaxLineWidth(arg_203_0:size().w - 110)
		var_203_3:align(cc.p(0, 0.5), 80, var_203_1:pos().y)

		local var_203_4 = TempWidget:CreateTempLayout(arg_203_0)

		var_203_4:setContentSize(cc.size(arg_203_0:size().w, (arg_203_0:size().h - 60 - var_195_4:size().h) / 2))
		var_203_4:align(cc.p(0, 1), 0, arg_203_0:size().h - 60)

		local var_203_5 = TempWidget:CreateTempImg("HorcruxSelectLayer/skill_bg_down.png", var_203_4)

		var_203_5:align(cc.p(0, 0.5), 20, var_203_4:size().h / 2)
		var_203_5:hide()
		var_203_5:setName("skill1IconBgDown")

		local var_203_6 = TempWidget:CreateTempImg(nil, var_203_4)

		var_203_6:setScale(0.44)
		var_203_6:align(cc.p(0, 0.5), var_203_5:pos())
		var_203_6:setName("skill1Icon")

		local var_203_7 = TempWidget:CreateTempImg("HorcruxSelectLayer/skill_bg_up.png", var_203_4)

		var_203_7:align(cc.p(0, 0.5), var_203_5:pos())
		var_203_7:hide()
		var_203_7:setName("skill1IconBgUp")

		local var_203_8 = TempWidget:CreateTempListView(var_203_4)

		var_203_8:setContentSize(cc.size(var_203_4:size().w - 110, var_203_4:size().h - 20))
		var_203_8:setName("skill1DesView")
		var_203_8:setDirection(ccui.ListViewDirection.vertical)
		var_203_8:align(cc.p(1, 0.5), var_203_4:size().w - 30, var_203_4:size().h / 2)

		local var_203_9 = TempWidget:CreateTempLayout(arg_203_0)

		var_203_9:setContentSize(var_203_4:size())
		var_203_9:align(cc.p(0, 1), 0, var_203_4:pos().y - var_203_4:size().h)

		local var_203_10 = TempWidget:CreateTempImg("HorcruxSelectLayer/skill_bg_down.png", var_203_9)

		var_203_10:align(cc.p(0, 0.5), 20, var_203_9:size().h / 2)
		var_203_10:hide()
		var_203_10:setName("skill2IconBgDown")

		local var_203_11 = TempWidget:CreateTempImg(nil, var_203_9)

		var_203_11:setScale(0.44)
		var_203_11:align(cc.p(0, 0.5), var_203_10:pos())
		var_203_11:setName("skill2Icon")

		local var_203_12 = TempWidget:CreateTempImg("HorcruxSelectLayer/skill_bg_up.png", var_203_9)

		var_203_12:align(cc.p(0, 0.5), var_203_10:pos())
		var_203_12:hide()
		var_203_12:setName("skill2IconBgUp")

		local var_203_13 = TempWidget:CreateTempListView(var_203_9)

		var_203_13:setContentSize(var_203_8:getContentSize())
		var_203_13:setName("skill2DesView")
		var_203_13:setDirection(ccui.ListViewDirection.vertical)
		var_203_13:align(cc.p(1, 0.5), var_203_8:pos().x, var_203_9:size().h / 2)
	end

	var_195_7(var_195_5)
	var_195_7(var_195_6)

	if self.isHorcruxDevour then
		var_195_4:setFlippedY(true)

		var_195_4.moveDir = 0
		var_195_4.isMoveing = false

		var_195_3:setPosition(cc.p(0, -var_195_1))

		local var_195_8 = self.listPanel:getContentOffset()

		self.listPanel:setPosition(cc.p(var_0_27, var_0_28 - GameDisplay.fix_y))
		self.listPanel:setViewSize(cc.size(var_0_25, var_0_26 + GameDisplay.fix_y * 2 - var_0_24 - var_195_0))
		self.listPanel:setContentOffset(cc.p(var_195_8.x, var_195_8.y - var_195_0))
	end
end

function HorcruxSelectLayer:updateHorcruxFrame(arg_204_1, arg_204_2, arg_204_3)
	if not arg_204_1 then
		return
	end

	arg_204_1:getChildByName("damageLabel"):setVisible(arg_204_2 ~= nil and playermodel.items[arg_204_2] ~= nil)
	arg_204_1:getChildByName("damageLabel"):setColor(var_0_20)
	arg_204_1:getChildByName("damageLabelDoubleUp"):setVisible(false)
	arg_204_1:getChildByName("damageLabelCompare"):setVisible(false)
	arg_204_1:getChildByName("attrBg"):setVisible(arg_204_2 ~= nil and playermodel.items[arg_204_2] ~= nil)
	arg_204_1:getChildByName("hpLabel"):setVisible(arg_204_2 ~= nil and playermodel.items[arg_204_2] ~= nil)
	arg_204_1:getChildByName("hpLabel"):setColor(var_0_20)
	arg_204_1:getChildByName("hpLabelDoubleUp"):setVisible(false)
	arg_204_1:getChildByName("hpLabelCompare"):setVisible(false)
	arg_204_1:getChildByName("horcruxSp"):setVisible(arg_204_2 ~= nil and playermodel.items[arg_204_2] ~= nil)
	arg_204_1:getChildByName("statusImg"):setVisible(arg_204_2 == nil or playermodel.items[arg_204_2] == nil)
	arg_204_1:getChildByName("qualityImg"):setVisible(arg_204_2 ~= nil and playermodel.items[arg_204_2] ~= nil)

	local var_204_0 = arg_204_1:getChildByName("horcruxSp"):getChildByName("careerIcon"):getChildByName("linkCareerIcon")

	var_204_0:setVisible(false)

	if arg_204_3 == "self" then
		arg_204_1:getChildByName("nameLabel"):setString("未装备")
	end

	if arg_204_3 == "other" then
		arg_204_1:getChildByName("nameLabel"):setString("未选择")
	end

	if not arg_204_2 or not playermodel.items[arg_204_2] then
		return
	end

	local var_204_1

	if arg_204_3 == "self" then
		var_204_1 = self.selfSkillLayout
	end

	if arg_204_3 == "other" then
		var_204_1 = self.otherSkillLayout
	end

	local var_204_2 = playermodel.items[arg_204_2].itemid

	arg_204_1:getChildByName("nameLabel"):setString(horcrux_data[playermodel.items[arg_204_2].itemid].name)
	arg_204_1:getChildByName("skillBg"):setVisible(false)
	arg_204_1:getChildByName("qualityImg"):loadTextureEx(string.format("HorcruxSelectLayer/quality%d.png", horcrux_data[var_204_2].rarity))

	local var_204_3 = horcrux_manager:getHorcruxSkills(arg_204_2)
	local var_204_4 = var_204_3[1]

	if playermodel.items[arg_204_2].horcrux_attr.enable_skill_idxs then
		var_204_4 = false

		for iter_204_0, iter_204_1 in pairs(playermodel.items[arg_204_2].horcrux_attr.enable_skill_idxs) do
			if iter_204_1 == 1 then
				var_204_4 = true

				break
			end
		end
	end

	if var_204_4 then
		ccui.Helper:seekWidgetByName(var_204_1, "skill1Icon"):setVisible(true)
		ccui.Helper:seekWidgetByName(var_204_1, "skill1Icon"):loadTextureEx("skill_new/skill/" .. total_skill_data[var_204_3[1]].icon .. ".png")
		ccui.Helper:seekWidgetByName(var_204_1, "skill1IconBgDown"):setVisible(true)
		ccui.Helper:seekWidgetByName(var_204_1, "skill1IconBgUp"):setVisible(true)

		local var_204_5 = ccui.Helper:seekWidgetByName(var_204_1, "skill1DesView")

		var_204_5:removeAllItems()

		local var_204_6 = TempWidget:CreateTempLayout()
		local var_204_7 = TempWidget:CreateTempLabel(total_skill_data[var_204_3[1]].description, FONT_NAME, 17)

		var_204_7:setMaxLineWidth(var_204_5:size().w - 5)
		var_204_6:setContentSize(cc.size(var_204_7:size().w, var_204_7:size().h < var_204_5:size().h and var_204_5:size().h or var_204_7:size().h))
		var_204_6:addChild(var_204_7)
		var_204_7:align(cc.p(0, 0.5), 0, var_204_6:size().h / 2)
		var_204_5:pushBackCustomItem(var_204_6)
	else
		ccui.Helper:seekWidgetByName(var_204_1, "skill1Icon"):setVisible(false)
		ccui.Helper:seekWidgetByName(var_204_1, "skill1IconBgDown"):setVisible(false)
		ccui.Helper:seekWidgetByName(var_204_1, "skill1IconBgUp"):setVisible(false)
		ccui.Helper:seekWidgetByName(var_204_1, "skill1DesView"):removeAllItems()
	end

	local var_204_8 = var_204_3[2]

	if playermodel.items[arg_204_2].horcrux_attr.enable_skill_idxs then
		var_204_8 = false

		for iter_204_2, iter_204_3 in pairs(playermodel.items[arg_204_2].horcrux_attr.enable_skill_idxs) do
			if iter_204_3 == 2 then
				var_204_8 = true

				break
			end
		end
	end

	if var_204_8 then
		ccui.Helper:seekWidgetByName(var_204_1, "skill2Icon"):setVisible(true)
		ccui.Helper:seekWidgetByName(var_204_1, "skill2Icon"):loadTextureEx("skill_new/skill/" .. total_skill_data[var_204_3[2]].icon .. ".png")
		ccui.Helper:seekWidgetByName(var_204_1, "skill2IconBgUp"):setVisible(true)
		ccui.Helper:seekWidgetByName(var_204_1, "skill2IconBgDown"):setVisible(true)

		local var_204_9 = ccui.Helper:seekWidgetByName(var_204_1, "skill2DesView")

		var_204_9:removeAllItems()

		local var_204_10 = TempWidget:CreateTempLayout()
		local var_204_11 = TempWidget:CreateTempLabel(total_skill_data[var_204_3[2]].description, FONT_NAME, 17)

		var_204_11:setMaxLineWidth(var_204_9:size().w - 5)
		var_204_10:setContentSize(cc.size(var_204_11:size().w, var_204_11:size().h < var_204_9:size().h and var_204_9:size().h or var_204_11:size().h))
		var_204_10:addChild(var_204_11)
		var_204_11:align(cc.p(0, 0.5), 0, var_204_10:size().h / 2)
		var_204_9:pushBackCustomItem(var_204_10)
	else
		ccui.Helper:seekWidgetByName(var_204_1, "skill2Icon"):setVisible(false)
		ccui.Helper:seekWidgetByName(var_204_1, "skill2IconBgUp"):setVisible(false)
		ccui.Helper:seekWidgetByName(var_204_1, "skill2IconBgDown"):setVisible(false)
		ccui.Helper:seekWidgetByName(var_204_1, "skill2DesView"):removeAllItems()
	end

	local var_204_12 = horcrux_manager:getHorcruxAssistConfig(arg_204_2)

	arg_204_1:getChildByName("damageLabel"):setString(global_trans_number(math.floor(var_204_12.damage)))
	arg_204_1:getChildByName("hpLabel"):setString(global_trans_number(math.floor(var_204_12.hp)))

	if arg_204_3 == "other" then
		if self.selectCurHorcrux then
			local var_204_13 = horcrux_manager:getHorcruxAssistConfig(self.selectCurHorcrux)
			local var_204_14 = {
				damage = 1,
				hp = 1
			}

			if self.selectGirlServantId then
				var_204_14 = horcrux_manager:getServantAttrAddPercent(self:getAttrIconPath(playermodel.items[self.selectCurHorcrux].itemid), global_get_all_servant_attrs(self.selectGirlServantId))
			end

			local var_204_15 = var_204_13.damage * var_204_14.damage
			local var_204_16 = var_204_13.hp * var_204_14.hp
			local var_204_17 = {
				damage = 1,
				hp = 1
			}

			if self.selectGirlServantId then
				var_204_17 = horcrux_manager:getServantAttrAddPercent(self:getAttrIconPath(var_204_2), global_get_all_servant_attrs(self.selectGirlServantId))
			end

			local var_204_18 = var_204_12.damage * var_204_17.damage
			local var_204_19 = var_204_12.hp * var_204_17.hp

			if var_204_15 < var_204_12.damage * var_204_17.damage then
				arg_204_1:getChildByName("damageLabel"):setColor(var_0_21)
				arg_204_1:getChildByName("damageLabelCompare"):setVisible(true)
				arg_204_1:getChildByName("damageLabelCompare"):loadTextureEx("HorcruxSelectLayer/compare_up.png")
			elseif var_204_18 == var_204_15 then
				arg_204_1:getChildByName("damageLabel"):setColor(var_0_20)
			else
				arg_204_1:getChildByName("damageLabel"):setColor(var_0_22)
				arg_204_1:getChildByName("damageLabelCompare"):setVisible(true)
				arg_204_1:getChildByName("damageLabelCompare"):loadTextureEx("HorcruxSelectLayer/compare_down.png")
			end

			if var_204_16 < var_204_19 then
				arg_204_1:getChildByName("hpLabel"):setColor(var_0_21)
				arg_204_1:getChildByName("hpLabelCompare"):setVisible(true)
				arg_204_1:getChildByName("hpLabelCompare"):loadTextureEx("HorcruxSelectLayer/compare_up.png")
			elseif var_204_19 == var_204_16 then
				arg_204_1:getChildByName("hpLabel"):setColor(var_0_20)
			else
				arg_204_1:getChildByName("hpLabel"):setColor(var_0_22)
				arg_204_1:getChildByName("hpLabelCompare"):setVisible(true)
				arg_204_1:getChildByName("hpLabelCompare"):loadTextureEx("HorcruxSelectLayer/compare_down.png")
			end
		else
			arg_204_1:getChildByName("damageLabel"):setColor(var_0_21)
			arg_204_1:getChildByName("hpLabel"):setColor(var_0_21)
			arg_204_1:getChildByName("damageLabelCompare"):loadTextureEx("HorcruxSelectLayer/compare_up.png")
			arg_204_1:getChildByName("damageLabelCompare"):setVisible(true)
			arg_204_1:getChildByName("hpLabelCompare"):loadTextureEx("HorcruxSelectLayer/compare_up.png")
			arg_204_1:getChildByName("hpLabelCompare"):setVisible(true)
		end
	end

	arg_204_1:getChildByName("horcruxSp"):updateHorcruxInfos(arg_204_2, false)
	arg_204_1:getChildByName("horcruxSp"):setLockIconVisible(false)

	if self.selectType ~= SELECT_HORCRUX_FIGHT and self.selectType ~= SELECT_HORCRUX_EXPLORE and self.selectType ~= SELECT_HORCRUX_SPECIAL and self.selectType ~= SELECT_HORCRUX_ARENA_DEFENCE and self.selectType ~= SELECT_HORCRUX_ARENA_ATTACK and self.selectType ~= SELECT_HORCRUX_TVT_DEFENCE and self.selectType ~= SELECT_HORCRUX_FIGHT_MODE and self.selectType ~= SELECT_HORCRUX_TVT_ATTACK and self.selectType ~= SELECT_HORCRUX_FIGHT_POINT and self.selectType ~= SELECT_HORCRUX_SUBSTITUTION and self.selectType ~= SELECT_HORCRUX_FIGHT_MATERIAL and self.selectType ~= SELECT_HORCRUX_FIGHT_ELEMENTS and self.selectType ~= SELECT_HORCRUX_SUBSTITUTION_OLD then
		arg_204_1:getChildByName("horcruxSp"):setReddotVisible(false)
	end

	arg_204_1:getChildByName("horcruxSp").entityid = arg_204_2

	if self.selectGirlServantId then
		local var_204_20 = horcrux_manager:getServantAttrAddPercent(self:getAttrIconPath(playermodel.items[arg_204_2].itemid), global_get_all_servant_attrs(self.selectGirlServantId))

		if var_204_20.damage ~= 1 or var_204_20.hp ~= 1 then
			var_204_0:setVisible(true)
			var_204_0.play()
			arg_204_1:getChildByName("damageLabelDoubleUp"):setVisible(true)
			arg_204_1:getChildByName("hpLabelDoubleUp"):setVisible(true)
			arg_204_1:getChildByName("damageLabel"):setString(global_trans_number(math.floor(var_204_12.damage * var_204_20.damage)))
			arg_204_1:getChildByName("hpLabel"):setString(global_trans_number(math.floor(var_204_12.hp * var_204_20.hp)))
		end
	end

	var_204_1:getChildByName("raceImg"):loadTextureEx("public/rolebg/" .. horcrux_manager:getRaceByEntityid(arg_204_2) .. ".png")
	var_204_1:getChildByName("raceLabel"):setString(total_skill_data[horcrux_manager:getTypeSkillByEntityid(arg_204_2)].description)
	var_204_1:getChildByName("raceImgBgDown"):show()
	var_204_1:getChildByName("raceImgBgUp"):show()

	local var_204_21 = {
		s = "public/rolebg/grade_s.png",
		a = "public/rolebg/grade_a.png",
		s_plus = "public/rolebg/grade_s_plus.png",
		b_minus = "public/rolebg/grade_b_minus.png",
		b_plus = "public/rolebg/grade_b_plus.png",
		a_minus = "public/rolebg/grade_a_minus.png",
		b = "public/rolebg/grade_b.png",
		c = "public/rolebg/grade_c.png",
		a_puls = "public/rolebg/grade_a_puls.png"
	}

	arg_204_1:getChildByName("damageAptitudeImg"):loadTexture(var_204_21[horcrux_manager:getHorcruxDamageFacSectionGrade(arg_204_2)], var_0_17)
	arg_204_1:getChildByName("damageAptitudeImg"):setVisible(true)
	arg_204_1:getChildByName("hpAptitudeImg"):loadTexture(var_204_21[horcrux_manager:getHorcruxHpFacSectionGrade(arg_204_2)], var_0_17)
	arg_204_1:getChildByName("hpAptitudeImg"):setVisible(true)
end

function HorcruxSelectLayer:exit()
	self:layerOutAni(function()
		if self.exithandler then
			self.exithandler()
		end
	end)
end

function HorcruxSelectLayer:selectholdData()
	return self.hold_array_girls
end

function HorcruxSelectLayer:initRegisterEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("on_return_horcrux_layer", function(arg_209_0)
		self:deleteBagData(arg_209_0.addHorcruxEntityList)
		self:updateDecomposeAfterShowingCells()
	end), self)
end

function HorcruxSelectLayer.getAttrIconPath(arg_210_0, arg_210_1)
	if servant_data[arg_210_1] then
		return (global_get_model_attr(servant_data[arg_210_1].modelid))
	else
		return (global_get_model_attr(horcrux_data[arg_210_1].model))
	end
end

GirlSelectLayer = class("GirlSelectLayer", function()
	return cc.Layer:create()
end)

local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local npc_data = require("data.npc_data")
local dorm_property_data = require("data.dorm_property_data")
local servant_data = require("data.servant_data")
local skillup_cos_data = require("data.skillup_cos_data")
local fitness_data = require("data.fitness_data")
local core_data = require("data.core_data")
local playermodel = require("model.playermodel")
local array_manager = require("controller.array_manager")
local arenatft_manager = require("controller.arenatft_manager")
local model_manager = require("controller.model_manager")
local component_manager = require("controller.component_manager")
local weapon_manager = require("controller.weapon_manager")
local core_manager = require("controller.core_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local explore_manager = require("controller.explore_manager")
local item_manager = require("controller.item_manager")
local filter_config_manager = require("controller.filter_config_manager")
local audio_manager = require("controller.audio_manager")
local train_manager = require("controller.train_manager")
local patrol_manager = require("controller.patrol_manager")
local time_check_manager = require("controller.time_check_manager")
local marry_manager = require("controller.marry_manager")
local substitution_manager = require("controller.substitution_manager")
local hexie_manager = require("controller.hexie_manager")
local test_fight_manager = require("controller.test_fight_manager")
local expedition_manager = require("controller.expedition_manager")
local levelmode_data = require("data.levelmode_data")
local json = require("json")
local souls_manager = require("controller.souls_manager")
local Utility = require("common.Utility")
local level_manager = require("controller.level_manager")
local alert_manager = require("controller.alert_manager")
local activity_manager = require("controller.activity_manager")
local role_false_level_manager = require("controller.role_false_level_manager")
local TempWidget = require("view.Sprite.TempWidget")

require("view.Sprite.FilterSprite")
require("view.Sprite.FilterListSprite")
require("view.Sprite.GirlSprite")

local var_0_38 = FORMATION_SHOW_GIRL_NUM
local var_0_39
local var_0_40
local var_0_41
local var_0_42
local var_0_44 = "MainCityBgSelectLayer/"
local var_0_49 = config._DEBUG and 0 or 1

function GirlSelectLayer.getInstance()
	return var_0_39
end

function GirlSelectLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = GirlSelectLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function GirlSelectLayer:init(arg_4_1)
	global_last_select_servant = nil
	arg_4_1 = arg_4_1 or {
		selectType = SELECT_GIRL_DATABASE
	}
	var_0_39 = self
	self.newPlayerServantId = {}
	self.arrayData = {}
	self.initconfig = arg_4_1
	self.selectType = arg_4_1.selectType or SELECT_GIRL_FIGHT
	self.exitCallBack = arg_4_1.exitCallBack or nil
	self.sureCallBack = arg_4_1.sureCallBack or nil
	self.resetMainLayerLive2dCallback = arg_4_1.resetMainLayerLive2dCallback
	self.exithandler = arg_4_1.exithandler
	self.adverturemode = arg_4_1.adverturemode or nil
	self.isHpInherit = arg_4_1.is_hp_inherit
	self.fightType = arg_4_1.fightType
	self.activityId = arg_4_1.activityId
	self.selectGirlIndex = arg_4_1.selectGirlIndex
	self.hideFilter = arg_4_1.hideFilter

	if var_0_40 then
		self.selectTblAni = false
		self.selectTblAniStartIdx = nil
	else
		self.selectTblAni = true
	end

	local var_4_0 = false

	if self.selectType == SELECT_GIRL_HOME then
		for iter_4_0, iter_4_1 in pairs(npc_data) do
			if iter_4_1.model == self.initconfig.cursoul then
				self.initconfig.cursoul = iter_4_1.id
				var_4_0 = true

				break
			end
		end
	end

	if self.selectType == SELECT_GIRL_HOME and not var_4_0 then
		self.initconfig.cursoul = model_data[self.initconfig.cursoul].major
	end

	self.allNpcData = {}
	self.curData = {}

	self:initGirlData()

	self.filterType = self.selectType == SELECT_GIRL_HOME and {
		{}
	} or {
		{},
		{},
		{},
		{}
	}
	self.sortOrder = var_0_42 or 0

	if self.selectType == SELECT_GIRL_FIGHT or self.selectType == SELECT_GIRL_FIGHT_MODE or self.selectType == SELECT_GIRL_FIGHT_POINT or self.selectType == SELECT_GIRL_FIGHT_MATERIAL or self.selectType == SELECT_GIRL_FIGHT_ELEMENTS then
		self.sortType = 1
		self.curSort = 1
	elseif self.selectType == SELECT_GIRL_EXPLORE then
		self.sortType = 1
		self.curSort = 1
		self.exploreTimeLabel = {}
	elseif self.selectType == SELECT_GIRL_EXPLORE_HP_INHERIT then
		self.sortType = 1
		self.curSort = 1
	elseif self.selectType == SELECT_GIRL_DORMITORY then
		self.sortType = 2
		self.curSort = 2
	else
		self.sortType = 1
		self.curSort = 1
	end

	self:initUI()
	self:initButtomBtnList()
	self:filterGirlData()
	;(function()
		self.curIndex = 1

		for iter_5_0, iter_5_1 in pairs(self.curData) do
			if iter_5_1.soulid == self.initconfig.cursoul then
				self.curIndex = iter_5_0
			end
		end

		self.selectGirl = self.curData[self.curIndex] and self.curData[self.curIndex].soulid
	end)()
	self:initTableView()
	self:updateButtomBtnList()

	if self.selectType == SELECT_GIRL_EXPEDITION then
		self:filterCallback(self.initconfig.filterTbl)
		self:updateButtomBtnList()
	end

	self:jumpSpecialBtn(arg_4_1)
	self:scrollToIndex()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			if self.filterSpritePop then
				self.filterSpritePop:runAction(cc.RemoveSelf:create())

				self.filterSpritePop = nil
			end

			if self.switchToEquiplayer then
				var_0_40 = self.tableViewLastPercent
				var_0_41 = self.filterTbl
				var_0_42 = self.sortOrder
			else
				var_0_40 = nil
				var_0_41 = nil
			end

			if self.initconfig.exitcallback then
				self.initconfig.exitcallback()
			end

			if self.exploreSchedule then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.exploreSchedule)

				self.exploreSchedule = nil
			end

			TextureManager:unregisterTexture("GirlSelectLayer")

			for iter_6_0, iter_6_1 in pairs(self.newPlayerServantId) do
				playermodel:playerOpenNewServant(iter_6_0)
				alert_manager:check_new_servant()
			end

			var_0_39 = nil
		end
	end)
	self:initDisplay(self.rootLayer)

	self.selectTblAni = false
	self.selectTblAniStartIdx = nil

	hx_print("\n    -----------------------排序规则------------------\n    1、解锁（解锁的在前【不受玩家选择的排序规则影响】）\n    2、new（new在前【不受玩家选择的排序规则影响】）\n    3、稀有度（稀有度高的在前，mr与sp为同一权重）\n    4、等级（高的在前）\n    5、共振（高的在前，超频为6）\n    6、获取时间（新的在前面，在更新之前获取的角色将没有获取时间，将设置为默认值1970-01-01）\n    7、majorid（大的在前）\n    8、servantid（大的在前）", CONSOLE_COLOR_YELLO)
end

function GirlSelectLayer:initUI()
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.rootLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer, 10)
	self:createTitleSprite()
	self:initFilterPanel()
	self:createFastUpgradeButton()
end

function GirlSelectLayer:createTitleSprite()
	self.title = ccui.ImageView:create("GirlSelectLayer/title.png", var_0_49)

	self.title:setName("title")
	self.title:setAnchorPoint(cc.p(0.5, 0.5))
	self.title:setPosition(cc.p(320, GameDisplay.getUiScreenSize().height - 56))
	self.rootLayer:addChild(self.title, 5)

	local var_8_0 = "Array/hold_girls.png"
	local var_8_1 = "Array/hold_girls_on.png"

	self.hidegirls = ccui.Button:create("Array/hold_girls.png", nil, path, var_0_49)

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
			arg_9_0:loadTextures(var_8_1, nil, var_8_1, var_0_49)
		else
			arg_9_0:loadTextures(var_8_0, nil, var_8_1, var_0_49)
		end

		self:initGirlData()
		self:filterGirlData()
		self:updateShowingCells()
	end)

	if self.selectType ~= SELECT_GIRL_HOME and self.selectType ~= SELECT_GIRL_DORMITORY then
		local var_8_2 = ccui.ImageView:create("GirlSelectLayer/infoBtn.png", var_0_49)

		var_8_2:setPositionX(196)
		var_8_2:setPositionY(self.title:getContentSize().height / 2 + 6)
		var_8_2:setTouchEnabled(true)
		self.title:addChild(var_8_2, 100)
		var_8_2:addTouchEventListener(function(arg_10_0, arg_10_1)
			local var_10_0

			if arg_10_1 ~= ccui.TouchEventType.ended then
				do return end

				var_10_0 = {}
			end

			var_10_0.tips = {
				"mainScenebg/guide/16.jpg",
				"mainScenebg/guide/23.jpg",
				"mainScenebg/guide/24.jpg",
				"mainScenebg/guide/25.jpg",
				"mainScenebg/guide/26.jpg",
				"mainScenebg/guide/27.jpg",
				"mainScenebg/guide/28.jpg",
				"mainScenebg/guide/29.jpg"
			}

			LayerManager:pushInLayer("TipsLayer", var_10_0)
		end)
	end

	self.afkLVBtn = ccui.ImageView:create("GirlSelectLayer/afkLVBG.png", var_0_49)

	self.afkLVBtn:setName("afkLVBtn")
	self.afkLVBtn:setAnchorPoint(cc.p(0.5, 0.5))
	self.afkLVBtn:setPosition(cc.p(320, GameDisplay.getUiScreenSize().height - 110))
	self.rootLayer:addChild(self.afkLVBtn, 5)

	local var_8_3 = cc.Label:createWithTTF(L_AFKLEVEL_LAYER.xietiao, FONT_DES, 16)

	var_8_3:setPosition(cc.p(162, 45))
	self.afkLVBtn:addChild(var_8_3)

	local var_8_4 = cc.Label:createWithTTF(role_false_level_manager:getCurAfkLevel(), FONT_DES, 24)

	var_8_4:setPosition(cc.p(162, 21))
	var_8_4:setColor(cc.c3b(251, 191, 48))
	self.afkLVBtn:addChild(var_8_4)
	self.afkLVBtn:setTouchEnabled(true)
	self.afkLVBtn:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("AfkLevelLayer")
	end)
end

function GirlSelectLayer:initFilterPanel()
	self.filterAniFlag = true
	self.filterAniFlag1 = false
	self.filterPopModel = false

	if var_0_41 then
		self.filterTbl = var_0_41
		var_0_41 = nil
	else
		self.filterTbl = self.selectType == SELECT_GIRL_HOME and filter_config_manager:getDefaultFilterData(filter_config_manager.MAJOR) or filter_config_manager:getDefaultFilterData(filter_config_manager.SERVANT)
	end

	self.curSort = self.filterTbl.sortType

	self:createFilterList()

	self.filterListData = self.filterList:getFilterData()

	if self.selectType == SELECT_GIRL_HOME then
		if self.filterTbl.filterConfig.type then
			self.filterType[1] = global_deepCopy(self.filterTbl.filterConfig.type)
		end
	elseif self.selectType == SELECT_GIRL_HOME then
		if self.filterTbl.filterConfig.rarity then
			self.filterType[3] = global_deepCopy(self.filterTbl.filterConfig.rarity)
		end

		if self.filterTbl.filterConfig.career then
			self.filterType[4] = global_deepCopy(self.filterTbl.filterConfig.career)
		end
	else
		if self.filterTbl.filterConfig.pos then
			self.filterType[1] = global_deepCopy(self.filterTbl.filterConfig.pos)
		end

		if self.filterTbl.filterConfig.attr then
			self.filterType[2] = global_deepCopy(self.filterTbl.filterConfig.attr)
		end

		if self.filterTbl.filterConfig.rarity then
			self.filterType[3] = global_deepCopy(self.filterTbl.filterConfig.rarity)
		end

		if self.filterTbl.filterConfig.career then
			self.filterType[4] = global_deepCopy(self.filterTbl.filterConfig.career)
		end

		if self.filterTbl.filterConfig.other then
			self.filterType[5] = global_deepCopy(self.filterTbl.filterConfig.other)
		end
	end

	self.filterButton = ccui.Button:create("GirlSelectLayer/btn_filter.png", "GirlSelectLayer/btn_filter.png", nil, var_0_49)

	self.filterButton:setPositionX(434)
	self.filterButton:setPositionY(self.title:getContentSize().height / 2 + 3)
	self.title:addChild(self.filterButton, 5)
	self.filterButton:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
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
	self.filterButton:setVisible(self.selectType ~= SELECT_GIRL_EXPEDITION)

	if self.hideFilter then
		self.filterButton:setVisible(false)
	end

	self.button_attribute = ccui.Button:create("GirlSelectLayer/btn_attr.png", "GirlSelectLayer/btn_attr.png", nil, var_0_49)

	self.button_attribute:setPositionX(540)
	self.button_attribute:setPositionY(self.title:getContentSize().height / 2 + 3)

	self.button_attribute.isClickOn = false

	self.title:addChild(self.button_attribute, 5)
	self.button_attribute:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.isShowAttrs = not self.isShowAttrs
		arg_15_0.isClickOn = not arg_15_0.isClickOn

		if arg_15_0.isClickOn == false then
			arg_15_0:loadTextures("GirlSelectLayer/btn_attr.png", "GirlSelectLayer/btn_attr.png", nil, var_0_49)
		else
			arg_15_0:loadTextures("GirlSelectLayer/btn_attr.png", "GirlSelectLayer/btn_attr.png", nil, var_0_49)
		end

		self:updateShowingCells()
	end)
	self.button_attribute:setVisible(self.selectType ~= SELECT_GIRL_HOME and self.selectType ~= SELECT_GIRL_DORMITORY)
end

function GirlSelectLayer:createFastUpgradeButton()
	if self.selectType ~= SELECT_GIRL_DATABASE then
		return
	end

	local var_16_0 = ccui.Button:create("GirlSelectLayer/fast_upgrade_btn.png", nil, "GirlSelectLayer/fast_upgrade_btn.png", var_0_49)

	var_16_0:setPosition(327, self.title:getContentSize().height / 2 + 3)
	self.title:addChild(var_16_0)
	var_16_0:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_17_0:isBright() then
			return
		end

		local var_17_0 = core_manager:getFastUpgradeData()

		if not var_17_0 or not next(var_17_0) then
			global_ShowBlockWords("没有可以快速共振的学员")
			arg_17_0:setBright(true)

			return
		end

		arg_17_0:setBright(true)
		LayerManager:pushInLayer("PopDoLayer", {
			surecallback = function()
				playermodel:fastServantBreakOut(function(arg_19_0)
					if arg_19_0.result == 1 then
						LayerManager:pushInLayer("PopServantFastUpgradeLayer", arg_19_0)
						self:updateShowingCells()
					elseif arg_19_0.result == 2 then
						global_ShowBlockWords("没有可以快速共振的学员")
					end

					arg_17_0:setBright(true)
				end)
			end,
			cancelcallback = function()
				arg_17_0:setBright(true)
			end,
			labels = {
				button = "确认",
				titleImage = "title_warorder.png",
				des = string.format("将所有可以共振的学员进行快速共振,不会消耗通用学员证")
			}
		})
	end)
end

function GirlSelectLayer:updateTitleBottom(arg_21_1)
	if self.filterPopModel == false and arg_21_1 == 2 or self.filterPopModel == true and arg_21_1 == 1 then
		self.filterPopModel = not self.filterPopModel

		if arg_21_1 == 1 then
			self.filterButton:loadTextures("GirlSelectLayer/btn_filter.png", "GirlSelectLayer/btn_filter.png", nil, var_0_49)
		else
			self.filterButton:loadTextures("GirlSelectLayer/btn_filter.png", "GirlSelectLayer/btn_filter.png", nil, var_0_49)
		end
	end
end

function GirlSelectLayer:showFilterPop()
	self.selectGirl = self.curData[self.curIndex] and self.curData[self.curIndex].soulid

	local var_22_1 = self.filterListData.col
	local var_22_2 = {}

	if not self.filterListData.filterValue then
		if self.filterList:getTouchFlag() then
			for iter_22_0, iter_22_1 in pairs(self.filterListData.btnState) do
				var_22_2[iter_22_0] = 0
			end

			self.filterList:setTouchFlag(false)
		end
	else
		for iter_22_2, iter_22_3 in pairs(self.filterListData.btnState) do
			var_22_2[iter_22_2] = iter_22_3 == 1 and -2 or -1
		end
	end

	local var_22_3 = self.sortOrder == 0 and 1 or 0
	local var_22_4 = {
		{
			0
		},
		{
			0
		}
	}

	var_22_4 = self.curSortOrders == 1 and {
		0,
		1
	} or {
		1,
		0
	}

	if self.filterSpritePop == nil then
		self.filterSpritePop = self:createFilterPop()

		global_basic_scene:addChild(self.filterSpritePop, 1000)
	end

	self.filterSpritePop:setFilterBtnState(var_22_1, var_22_2)
	self.filterSpritePop:setSortOrderState(var_22_3, var_22_4)
	self.filterSpritePop:updateAllFilterBtn()
	self.filterSpritePop:playPopAni()
	self:updateTitleBottom(2)
end

function GirlSelectLayer:createFilterList()
	local var_23_0 = {
		defaultSelected = 1,
		bagLayerType = filter_config_manager.SERVANT,
		filterCallback = function(self)
			if self.curIndex then
				self.curIndex = 1
			end

			self.selectTblAni = true
			self.filterTbl.filterConfig[self.filterKey] = {
				self.filterValue
			}
			self.filterListData = self

			if self.selectType == SELECT_GIRL_HOME then
				if self.filterTbl.filterConfig.type then
					self.filterType[1] = global_deepCopy(self.filterTbl.filterConfig.type)
				end
			elseif self.selectType == SELECT_GIRL_EXPEDITION then
				if self.filterTbl.filterConfig.rarity then
					self.filterType[3] = global_deepCopy(self.filterTbl.filterConfig.rarity)
				end

				if self.filterTbl.filterConfig.career then
					self.filterType[4] = global_deepCopy(self.filterTbl.filterConfig.career)
				end
			else
				if self.filterTbl.filterConfig.pos then
					self.filterType[1] = global_deepCopy(self.filterTbl.filterConfig.pos)
				end

				if self.filterTbl.filterConfig.attr then
					self.filterType[2] = global_deepCopy(self.filterTbl.filterConfig.attr)
				end

				if self.filterTbl.filterConfig.rarity then
					self.filterType[3] = global_deepCopy(self.filterTbl.filterConfig.rarity)
				end

				if self.filterTbl.filterConfig.career then
					self.filterType[4] = global_deepCopy(self.filterTbl.filterConfig.career)
				end
			end

			self:filterGirlData()

			self.curIndex = 1
			self.selectGirl = self.curData[self.curIndex] and self.curData[self.curIndex].soulid

			self.tableView:reloadData()
			self:updateButtomBtnList()

			self.selectTblAni = false
			self.selectTblAniStartIdx = nil
		end
	}
	local var_23_1 = 110

	if self.selectType == SELECT_GIRL_DATABASE then
		var_23_1 = 135
	end

	if self.selectType == SELECT_GIRL_HOME then
		var_23_0.bagLayerType = filter_config_manager.MAJOR
		var_23_0.style = "style_major_filter"
	elseif self.selectType == SELECT_GIRL_DORMITORY then
		var_23_0.bagLayerType = filter_config_manager.DORMITORY
		var_23_0.hideAll = true
	elseif self.selectType == SELECT_GIRL_TEST_FIGHT_EMPTY or self.selectType == SELECT_GIRL_TEST_FIGHT_PLAYER then
		var_23_0.bagLayerType = filter_config_manager.TEST_FIGHT
		var_23_0.style = "style_servant_attr"
		var_23_0.defaultFilter = self.filterTbl
	else
		var_23_0.bagLayerType = filter_config_manager.SERVANT
		var_23_0.style = "style_servant_attr"
		var_23_0.defaultFilter = self.filterTbl
	end

	self.filterList = FilterListSprite:create(var_23_0)

	self.filterList:setAnchorPoint(cc.p(0, 1))
	self.filterList:setPositionX(0)
	self.filterList:setPositionY(var_23_1)
	self.rootLayer:addChild(self.filterList, 8)

	local var_23_2 = TempWidget:CreateTempBtn(var_0_44 .. "main_city_select_btn.png", self.rootLayer)

	var_23_2:hide()
	var_23_2:setLocalZOrder(self.filterList:getLocalZOrder())
	var_23_2:align(cc.p(1, 1), GameDisplay.width, var_23_1)
	var_23_2:_addEvent(function()
		LayerManager:pushInLayer("MainCityBgSelectLayer")
	end)

	if self.selectType == SELECT_GIRL_HOME then
		var_23_2:show()
	end

	if self.selectType == SELECT_GIRL_DORMITORY then
		self.filterList:setVisible(false)
	end

	if self.selectType == SELECT_GIRL_DORMITORY or self.selectType == SELECT_GIRL_EXPEDITION then
		self.filterList:setVisible(false)
	end

	if self.hideFilter then
		self.filterList:setVisible(false)
	end
end

function GirlSelectLayer:sortCallback()
	self.sortOrder = self.sortOrder == 0 and 1 or 0

	self:updateShowingCells()
end

function GirlSelectLayer:filterCallback(arg_27_1)
	if arg_27_1 then
		self.filterTbl.sortType = arg_27_1.sortType or self.filterTbl.sortType

		for iter_27_0, iter_27_1 in pairs(arg_27_1.filterConfig) do
			self.filterTbl.filterConfig[iter_27_0] = global_deepCopy(iter_27_1)
		end

		self.curSort = self.filterTbl.sortType

		if self.selectType == SELECT_GIRL_HOME then
			if self.filterTbl.filterConfig.type then
				self.filterType[1] = global_deepCopy(self.filterTbl.filterConfig.type)
			end
		else
			if self.filterTbl.filterConfig.pos then
				self.filterType[1] = global_deepCopy(self.filterTbl.filterConfig.pos)
			end

			if self.filterTbl.filterConfig.attr then
				self.filterType[2] = global_deepCopy(self.filterTbl.filterConfig.attr)
			end

			if self.filterTbl.filterConfig.rarity then
				self.filterType[3] = global_deepCopy(self.filterTbl.filterConfig.rarity)
			end

			if self.filterTbl.filterConfig.career then
				self.filterType[4] = global_deepCopy(self.filterTbl.filterConfig.career)
			end

			if self.filterTbl.filterConfig.other then
				self.filterType[5] = global_deepCopy(self.filterTbl.filterConfig.other)
			end
		end
	end

	self:filterGirlData()

	self.curIndex = 1
	self.selectGirl = self.curData[self.curIndex] and self.curData[self.curIndex].soulid

	self.tableView:reloadData()
	self:updateButtomBtnList()
end

function GirlSelectLayer:createFilterPop()
	local var_28_0 = {}
	local var_28_1 = false

	for iter_28_0, iter_28_1 in pairs(self.filterListData.btnState) do
		if iter_28_1 == 1 then
			var_28_1 = true
		end
	end

	for iter_28_2, iter_28_3 in pairs(self.filterListData.btnState) do
		var_28_0[iter_28_2] = var_28_1 and (iter_28_3 == 1 and -2 or -1) or iter_28_3
	end

	local function var_28_2(arg_33_0, arg_33_1)
		for iter_33_0, iter_33_1 in pairs(arg_33_0) do
			if iter_33_1 == arg_33_1 then
				return true
			end
		end

		return false
	end

	local var_28_3 = {}
	local var_28_4 = {}

	for iter_28_4, iter_28_5 in pairs(filter_config_manager.ConfigTable[filter_config_manager.SERVANT].filter_key) do
		for iter_28_6, iter_28_7 in pairs(self.filterTbl.filterConfig) do
			if iter_28_6 == iter_28_5 then
				var_28_3[iter_28_4] = iter_28_4
				var_28_4[iter_28_4] = {}

				for iter_28_8, iter_28_9 in pairs(filter_config_manager.ConfigTable[filter_config_manager.SERVANT].filter_table[iter_28_4]) do
					var_28_4[iter_28_4][iter_28_8] = var_28_2(iter_28_7, iter_28_9) and 1 or 0
				end
			end
		end
	end

	local var_28_5 = {}

	for iter_28_10 = 1, self.filterTbl.sortType do
		if iter_28_10 < self.filterTbl.sortType then
			table.insert(var_28_5, 0)
		else
			table.insert(var_28_5, 1)
		end
	end

	local var_28_6 = {
		filterType = filter_config_manager.SERVANT,
		filterCallback = function(arg_29_0)
			self:filterCallback(arg_29_0)
		end,
		maskTouchCallback = function(arg_30_0)
			if self.filterAniFlag1 then
				self.filterAniFlag1 = false

				self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
					self.filterAniFlag1 = true
					self.filterAniFlag = true
				end)))
				self:updateTitleBottom(1)
				arg_30_0()
			end
		end,
		sortOrderChangeCallback = function(arg_32_0)
			self:sortCallback(arg_32_0)
		end,
		initButtonConfig = {
			[self.filterListData.col] = var_28_0
		},
		defaultSortOrder = self.sortOrder
	}

	var_28_6.filterType = self.selectType == SELECT_GIRL_HOME and filter_config_manager.MAJOR or self.selectType == SELECT_GIRL_DORMITORY and filter_config_manager.DORMITORY or (self.selectType == SELECT_GIRL_TEST_FIGHT_EMPTY or self.selectType == SELECT_GIRL_TEST_FIGHT_PLAYER) and filter_config_manager.TEST_FIGHT or filter_config_manager.SERVANT

	local var_28_7 = FilterSprite:create(var_28_6)

	var_28_7:setPositionX(320)
	var_28_7:setPositionY(GameDisplay.getScreenSize().height / 2)

	for iter_28_11, iter_28_12 in pairs(var_28_3) do
		var_28_7:setFilterBtnState(iter_28_12, var_28_4[iter_28_11])
	end

	var_28_7:setSortTypestate(1, var_28_5)
	var_28_7:updateAllFilterBtn()
	var_28_7:moveToTop()

	return var_28_7
end

local var_0_50 = {
	[SELECT_GIRL_SUBSTITUTION] = {
		curArray = function(arg_34_0)
			return substitution_manager:getArrayByServantID(arg_34_0) or 0
		end,
		pos = function(arg_35_0)
			return substitution_manager:getServantPos(arg_35_0)
		end
	},
	[SELECT_GIRL_TVT_DEFENCE] = {
		curArray = function(arg_36_0)
			return arenatft_manager:getDefArrayByServantID(arg_36_0) or 0
		end,
		pos = function(arg_37_0)
			return arenatft_manager:getDefServantPos(arg_37_0)
		end
	},
	[SELECT_GIRL_TVT_ATTACK] = {
		curArray = function(arg_38_0)
			return arenatft_manager:getAtkArrayByServantID(arg_38_0) or 0
		end,
		pos = function(arg_39_0)
			return arenatft_manager:getAtkServantPos(arg_39_0)
		end
	}
}

setmetatable(var_0_50, {
	__index = function(arg_40_0, arg_40_1)
		return {
			curArray = function(arg_41_0)
				return array_manager:getArrayByServantID(arg_41_0) or 0
			end,
			pos = function(arg_42_0)
				return array_manager:getServantPos(arg_42_0)
			end
		}
	end
})

function GirlSelectLayer:initGirlData()
	self.allData = {}

	local var_43_0 = {}

	if self.initconfig.outSide then
		for iter_43_0, iter_43_1 in pairs(self.initconfig.outSide) do
			var_43_0[#var_43_0 + 1] = iter_43_1
		end
	end

	if self.selectType == SELECT_GIRL_TRAIN then
		for iter_43_2, iter_43_3 in pairs(servant_data) do
			for iter_43_4, iter_43_5 in pairs(train_manager.trainRoomConfig) do
				if iter_43_3.id == iter_43_5.servantid then
					var_43_0[#var_43_0 + 1] = iter_43_3.id

					break
				end
			end
		end
	end

	if self.selectType == SELECT_GIRL_FIGHT then
		local var_43_1 = array_manager:getBattleArrayData(self.initconfig.arrayinfo.index)

		self.arrayData = var_43_1

		for iter_43_6, iter_43_7 in pairs(var_43_1) do
			if self.initconfig.cursoul == iter_43_7.fight_girl then
				var_43_0[#var_43_0 + 1] = iter_43_7.fight_girl
			end
		end
	end

	if self.selectType ~= SELECT_GIRL_FIGHT_POINT and self.selectType ~= SELECT_GIRL_FIGHT_MATERIAL and self.selectType ~= SELECT_GIRL_FIGHT_MODE then
		if self.selectType == SELECT_GIRL_FIGHT_ELEMENTS then
			local var_43_2 = require("controller.formation.formation_manager"):getInstance():getFormationInfoBySelectType(self.selectType, self.initconfig.arrayinfo.index)

			self.arrayData = var_43_2

			for iter_43_8, iter_43_9 in pairs(var_43_2) do
				if self.initconfig.cursoul == iter_43_9.fight_girl then
					var_43_0[#var_43_0 + 1] = iter_43_9.fight_girl
				end
			end
		end

		if self.selectType == SELECT_GIRL_EXPLORE_HP_INHERIT then
			local var_43_3 = array_manager:getBattleArrayDataHpInherit(self.initconfig.arrayinfo.index) or {}

			self.arrayData = var_43_3

			for iter_43_10, iter_43_11 in pairs(var_43_3) do
				if self.initconfig.cursoul == iter_43_11.fight_girl then
					var_43_0[#var_43_0 + 1] = iter_43_11.fight_girl
				end
			end
		end

		if self.selectType == SELECT_GIRL_ARENA_DEFENCE then
			local var_43_4 = array_manager:getArenaDefenceArray()

			self.arrayData = var_43_4

			for iter_43_12, iter_43_13 in pairs(var_43_4) do
				if self.initconfig.cursoul == iter_43_13.fight_girl then
					var_43_0[#var_43_0 + 1] = iter_43_13.fight_girl
				end
			end
		end

		if self.selectType == SELECT_GIRL_TVT_DEFENCE then
			local var_43_5 = arenatft_manager:getDefenceArrayData(self.initconfig.arrayinfo.index)

			self.arrayData = var_43_5

			for iter_43_14, iter_43_15 in pairs(var_43_5) do
				if self.initconfig.cursoul == iter_43_15.fight_girl then
					var_43_0[#var_43_0 + 1] = iter_43_15.fight_girl
				end
			end
		end

		if self.selectType == SELECT_GIRL_TVT_ATTACK then
			local var_43_6 = arenatft_manager:getAttackArrayData(self.initconfig.arrayinfo.index)

			self.arrayData = var_43_6

			for iter_43_16, iter_43_17 in pairs(var_43_6) do
				if self.initconfig.cursoul == iter_43_17.fight_girl then
					var_43_0[#var_43_0 + 1] = iter_43_17.fight_girl
				end
			end
		end

		if self.selectType == SELECT_GIRL_ARENA_ATTACK then
			local var_43_7 = array_manager:getArenaAttackArray()

			self.arrayData = var_43_7

			for iter_43_18, iter_43_19 in pairs(var_43_7) do
				if self.initconfig.cursoul == iter_43_19.fight_girl then
					var_43_0[#var_43_0 + 1] = iter_43_19.fight_girl
				end
			end
		end

		if self.selectType == SELECT_GIRL_DORMITORY then
			for iter_43_20, iter_43_21 in pairs(major_factor_data) do
				for iter_43_22, iter_43_23 in pairs(playermodel.dormRoomConfig) do
					if iter_43_21.id == iter_43_23.soulid then
						var_43_0[#var_43_0 + 1] = iter_43_21.id

						break
					end
				end
			end
		end

		if self.selectType == SELECT_GIRL_HOME then
			if self.initconfig.cursoul and self.initconfig.cursoul ~= 0 then
				var_43_0[#var_43_0 + 1] = self.initconfig.cursoul
			end

			;(function()
				for iter_44_0, iter_44_1 in pairs(npc_data) do
					if iter_44_1.is_hide ~= 1 then
						self.allNpcData[#self.allNpcData + 1] = {}
						self.allNpcData[#self.allNpcData].soulid = iter_44_1.id
						self.allNpcData[#self.allNpcData].order = iter_44_1.order
					end
				end

				table.sort(self.allNpcData, function(arg_45_0, arg_45_1)
					if arg_45_0.order > arg_45_1.order then
						return true
					else
						return false
					end
				end)
			end)()
		end

		if self.selectType == SELECT_GIRL_EXPLORE then
			if self.initconfig.arrayinfo then
				for iter_43_24, iter_43_25 in pairs((array_manager:getBattleArrayData(self.initconfig.arrayinfo.index))) do
					var_43_0[#var_43_0 + 1] = iter_43_25.fight_girl
				end
			end

			if self.initconfig.usedServants then
				for iter_43_26, iter_43_27 in pairs(self.initconfig.usedServants) do
					var_43_0[#var_43_0 + 1] = iter_43_26
				end
			end
		end

		if self.selectType == SELECT_GIRL_SPECIAL and self.initconfig.usedServants then
			for iter_43_28, iter_43_29 in pairs(self.initconfig.usedServants) do
				var_43_0[#var_43_0 + 1] = iter_43_28
			end
		end

		if self.selectType == SELECT_GIRL_QUICKFIGHT then
			-- block empty
		end

		if self.selectType == SELECT_GIRL_SUBSTITUTION then
			local var_43_8 = substitution_manager:getSubArrayData(self.initconfig.arrayinfo.index)
			local var_43_9 = {}

			for iter_43_30 = 1, var_0_38 do
				var_43_9[iter_43_30] = var_43_8[iter_43_30]
			end

			self.arrayData = var_43_9

			local var_43_10 = {}

			for iter_43_31 = var_0_38 + 1, #var_43_8 do
				var_43_10[iter_43_31 - var_0_38] = var_43_8[iter_43_31]
			end

			for iter_43_32, iter_43_33 in pairs(var_43_9) do
				if self.initconfig.cursoul == iter_43_33.fight_girl then
					var_43_0[#var_43_0 + 1] = iter_43_33.fight_girl
				end
			end

			for iter_43_34 = 1, #var_43_10 do
				if var_43_10[iter_43_34].fight_girl then
					var_43_0[#var_43_0 + 1] = var_43_10[iter_43_34].fight_girl
				end
			end
		end

		if self.selectType == SELECT_GIRL_EXPEDITION then
			local var_43_11 = 1

			if self.initconfig.arrayinfo and self.initconfig.arrayinfo.index then
				var_43_11 = self.initconfig.arrayinfo.index
			end

			local var_43_12 = require("controller.formation.formation_manager"):getInstance()
			local var_43_13 = expedition_manager:getExpeditionTeamListInfo()

			self.arrayData = var_43_12:getFormationInfoBySelectType(self.selectType, var_43_11)
		end

		if self.selectType == SELECT_GIRL_TEST_FIGHT_EMPTY then
			self.arrayData = test_fight_manager:getPvpArray()
		end

		if self.selectType == SELECT_GIRL_TEST_FIGHT_PLAYER then
			self.arrayData = test_fight_manager:getPlayerArray()
		end

		if self.selectType == SELECT_GIRL_DORMITORY or self.selectType == SELECT_GIRL_HOME then
			for iter_43_35, iter_43_36 in pairs(major_factor_data) do
				if iter_43_36.is_hide ~= 1 and (not iter_43_36.linkage or playermodel.haveSuit[iter_43_36.id]) and hexie_manager:canShowGirl(iter_43_36.id) then
					if #var_43_0 == 0 then
						table.insert(self.allData, {
							fitnessLevel = 0,
							ownNum = 0,
							fightCapacity = 0,
							skill1UpLevel = 0,
							LV = 0,
							order = 0,
							soulid = iter_43_36.id,
							favorlevel = playermodel.favor[iter_43_36.id].favorlevel
						})
					else
						for iter_43_37, iter_43_38 in pairs(var_43_0) do
							if iter_43_38 == iter_43_36.id then
								break
							end

							if iter_43_37 == #var_43_0 then
								table.insert(self.allData, {
									fitnessLevel = 0,
									ownNum = 0,
									fightCapacity = 0,
									skill1UpLevel = 0,
									LV = 0,
									order = 0,
									soulid = iter_43_36.id,
									favorlevel = playermodel.favor[iter_43_36.id].favorlevel
								})
							end
						end
					end
				end
			end

			goto label_43_1
		end
	end

	for iter_43_39, iter_43_40 in pairs(servant_data) do
		local var_43_15 = iter_43_40.classtype == 1 and not playermodel:isServantLockByTime(iter_43_40.id)

		if iter_43_40.classtype == 1 and servant_data[iter_43_40.id].linkage and not playermodel.haveServant[iter_43_40.id] then
			var_43_15 = false
		end

		if (not hexie_manager:canShowServant(iter_43_40.id) or nil) and false then
			if #var_43_0 == 0 then
				if playermodel.skill1Level[iter_43_40.id] >= MAX_SKILL1_LEVLE then
					-- block empty
				end

				if playermodel.fitness[iter_43_40.id].fitnesslevel == train_manager:getSwimMaxLevel() then
					-- block empty
				end

				local var_43_18 = {
					ownNum = 0,
					skill1UpLevel = 0,
					fitnessLevel = 0,
					favorlevel = 0,
					soulid = iter_43_40.id,
					LV = core_manager:getCoreLv(iter_43_40.id),
					afkLV = playermodel.cores[iter_43_40.id].afk_lv,
					fightCapacity = fight_capacity_manager:getSoulFightCapacity(iter_43_40.id, "number"),
					order = servant_data[iter_43_40.id].order,
					curArray = var_0_50[self.selectType].curArray(iter_43_40.id),
					rarity = souls_manager:get_servant_cur_roll_rarity(iter_43_40.id),
					sortRarity = souls_manager:get_servant_cur_roll_rarity(iter_43_40.id),
					pos = var_0_50[self.selectType].pos(iter_43_40.id),
					hpInherit = explore_manager:getHpInherit(iter_43_40.id)
				}

				if not playermodel.haveServant[iter_43_40.id] then
					var_43_18.LV = 0
					var_43_18.fightCapacity = 0
					var_43_18.skill1UpLevel = 0
					var_43_18.fitnessLevel = 0
					var_43_18.order = 0
				end

				table.insert(self.allData, var_43_18)
			else
				for iter_43_41, iter_43_42 in pairs(var_43_0) do
					if iter_43_42 == iter_43_40.id then
						break
					end

					if iter_43_41 == #var_43_0 then
						if playermodel.skill1Level[iter_43_40.id] >= MAX_SKILL1_LEVLE then
							-- block empty
						end

						if playermodel.fitness[iter_43_40.id].fitnesslevel == train_manager:getSwimMaxLevel() then
							-- block empty
						end

						local var_43_21 = {
							ownNum = 0,
							skill1UpLevel = 0,
							fitnessLevel = 0,
							favorlevel = 0,
							soulid = iter_43_40.id,
							LV = core_manager:getCoreLv(iter_43_40.id),
							afkLV = playermodel.cores[iter_43_40.id].afk_lv,
							fightCapacity = fight_capacity_manager:getSoulFightCapacity(iter_43_40.id, "number"),
							order = servant_data[iter_43_40.id].order,
							curArray = var_0_50[self.selectType].curArray(iter_43_40.id),
							rarity = souls_manager:get_servant_cur_roll_rarity(iter_43_40.id),
							sortRarity = souls_manager:get_servant_cur_roll_rarity(iter_43_40.id),
							pos = var_0_50[self.selectType].pos(iter_43_40.id),
							hpInherit = explore_manager:getHpInherit(iter_43_40.id)
						}

						if not playermodel.haveServant[iter_43_40.id] then
							var_43_21.LV = 0
							var_43_21.fightCapacity = 0
							var_43_21.skill1UpLevel = 0
							var_43_21.fitnessLevel = 0
							var_43_21.order = 0
						end

						table.insert(self.allData, var_43_21)
					end
				end
			end
		end
	end

	::label_43_1::

	if self.initconfig.cursoul then
		if self.selectType ~= SELECT_GIRL_FIGHT and self.selectType ~= SELECT_GIRL_FIGHT_MODE and self.selectType ~= SELECT_GIRL_EXPLORE and self.selectType ~= SELECT_GIRL_ARENA_DEFENCE and self.selectType ~= SELECT_GIRL_SPECIAL and self.selectType ~= SELECT_GIRL_EXPLORE_HP_INHERIT and self.selectType ~= SELECT_GIRL_ARENA_ATTACK and self.selectType ~= SELECT_GIRL_TVT_DEFENCE and self.selectType ~= SELECT_GIRL_TVT_ATTACK and self.selectType ~= SELECT_GIRL_SUBSTITUTION and self.selectType ~= SELECT_GIRL_FIGHT_POINT and self.selectType ~= SELECT_GIRL_FIGHT_MATERIAL then
			if self.selectType == SELECT_GIRL_FIGHT_ELEMENTS then
				table.insert(self.allData, 1, {
					skill1UpLevel = 0,
					fitnessLevel = 0,
					favorlevel = 0,
					soulid = self.initconfig.cursoul,
					LV = core_manager:getCoreLv(self.initconfig.cursoul),
					fightCapacity = fight_capacity_manager:getSoulFightCapacity(self.initconfig.cursoul, "number"),
					order = servant_data[self.initconfig.cursoul].order,
					curArray = var_0_50[self.selectType].curArray(self.initconfig.cursoul),
					rarity = souls_manager:get_servant_cur_roll_rarity(self.initconfig.cursoul),
					sortRarity = souls_manager:get_servant_cur_roll_rarity(self.initconfig.cursoul),
					pos = var_0_50[self.selectType].pos(self.initconfig.cursoul)
				})
			end

			if self.selectType == SELECT_GIRL_HOME and self.initconfig.cursoul and major_factor_data[self.initconfig.cursoul] then
				table.insert(self.allData, 1, {
					fitnessLevel = 0,
					fightCapacity = 0,
					skill1UpLevel = 0,
					LV = 0,
					order = 0,
					soulid = self.initconfig.cursoul,
					favorlevel = playermodel.favor[self.initconfig.cursoul].favorlevel
				})
			end

			if self.selectType == SELECT_GIRL_EXPEDITION_LIST then
				local var_43_22 = {}
				local var_43_23 = expedition_manager:getExpeditionTeamListInfo()

				for iter_43_43, iter_43_44 in pairs(self.allData) do
					for iter_43_45, iter_43_46 in pairs(var_43_23) do
						if iter_43_44.soulid == iter_43_46.servantid then
							iter_43_44.bloodpercent = iter_43_46.bloodpercent
							iter_43_44.energypercent = iter_43_46.energypercent

							table.insert(var_43_22, iter_43_44)

							break
						end
					end
				end

				self.allData = var_43_22
			end

			if self.selectType == SELECT_GIRL_AUTO_CHESS then
				local var_43_24 = {}

				for iter_43_47, iter_43_48 in pairs((activity_manager:getAutoChessServantList(self.activityId))) do
					table.insert(var_43_24, {
						fitnessLevel = 0,
						ownNum = 0,
						fightCapacity = 0,
						skill1UpLevel = 0,
						LV = 0,
						order = 0,
						soulid = iter_43_48.servantid,
						star = iter_43_48.star
					})
				end

				self.allData = var_43_24
			end
		end
	end
end

function GirlSelectLayer.getGotoEquipLayerHandler(arg_46_0)
	return function(arg_47_0, arg_47_1)
		if arg_47_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_46_0:gotoEquipLayer()
	end
end

function GirlSelectLayer:gotoEquipLayer(arg_48_1)
	if not arg_48_1 and not self.selectGirl then
		global_ShowBlockWords("未选中任何学员")

		return
	end

	LayerManager:pushInLayer("SoulsLayer", {
		showtype = 6,
		cursoul = arg_48_1 or self.selectGirl
	})
end

function GirlSelectLayer:layerOutAni(arg_49_1)
	self.startRunOutAni = true

	self:updateShowingCells()
	self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(LAYER_OUT_TIME * 1.5), cc.CallFunc:create(arg_49_1)))
end

function GirlSelectLayer:initButtomBtnList()
	self.bottomList = ccui.ImageView:create("public/box/UI_touming.png", var_0_49)

	self.bottomList:setAnchorPoint(cc.p(0, 0))
	self.bottomList:setTouchEnabled(true)
	self.bottomList:setContentSize(cc.size(640, 61))
	self.bottomList:setPositionY(-16)
	self.rootLayer:addChild(self.bottomList, 10)

	local var_50_0 = ccui.Layout:create()

	var_50_0:setTouchEnabled(true)
	var_50_0:setContentSize(cc.size(640, 80))
	var_50_0:setPositionX(0)
	var_50_0:setPositionY(0)
	var_50_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.bottomList:addChild(var_50_0)

	local var_50_1 = ccui.Button:create("public/button/bottom_return_btn_archives.png", nil, "public/button/bottom_return_btn_archives.png", var_0_49)

	var_50_1:setPosition(cc.p(50, self.bottomList:getContentSize().height / 2))
	var_50_1:addTouchEventListener(function(arg_51_0, arg_51_1)
		if arg_51_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit1()
	end)
	self.bottomList:addChild(var_50_1)

	local var_50_2 = ccui.Button:create("GirlSelectLayer/btn_info.png", "GirlSelectLayer/btn_info.png", "GirlSelectLayer/btn_info.png", var_0_49)

	var_50_2:setPosition(cc.p(280, self.bottomList:getContentSize().height / 2))
	var_50_2:setName("infoBtn")
	var_50_2:addTouchEventListener(self:getGotoEquipLayerHandler())
	self.bottomList:addChild(var_50_2)

	local var_50_3 = ccui.Button:create("GirlSelectLayer/btn_push.png", "GirlSelectLayer/btn_push.png", "GirlSelectLayer/btn_push.png", var_0_49)

	var_50_3:setPosition(cc.p(520, self.bottomList:getContentSize().height / 2))
	var_50_3:setName("sureBtn")
	var_50_3:addTouchEventListener(self:getSureBtnHandel())
	self.bottomList:addChild(var_50_3)
end

function GirlSelectLayer:updateButtomBtnList()
	local var_52_1 = "GirlSelectLayer/btn_push.png"

	if self.selectType == SELECT_HORCRUX_FIGHT or self.selectType == SELECT_GIRL_FIGHT_MODE or self.selectType == SELECT_GIRL_FIGHT_ELEMENTS or self.selectType == SELECT_GIRL_FIGHT_POINT or self.selectType == SELECT_GIRL_FIGHT_MATERIAL or self.selectType == SELECT_GIRL_EXPLORE or self.selectType == SELECT_GIRL_EXPLORE_HP_INHERIT or self.selectType == SELECT_GIRL_SPECIAL or self.selectType == SELECT_GIRL_ARENA_DEFENCE or self.selectType == SELECT_GIRL_ARENA_ATTACK or self.selectType == SELECT_GIRL_TVT_DEFENCE or self.selectType == SELECT_GIRL_TVT_ATTACK or self.selectType == SELECT_GIRL_EXPEDITION or self.selectType == SELECT_GIRL_SUBSTITUTION or self.selectType == SELECT_GIRL_GROUP_FIGHT then
		if self.initconfig.cursoul == nil then
			if self.curData and self.curData[self.curIndex] and self.curData[self.curIndex].soulid then
				local var_52_2 = false

				for iter_52_0 = 1, #self.arrayData do
					if self.arrayData[iter_52_0].fight_girl == self.curData[self.curIndex].soulid then
						var_52_2 = true

						break
					end
				end

				var_52_1 = var_52_2 and "GirlSelectLayer/btn_change.png" or "GirlSelectLayer/btn_push.png"
			else
				var_52_1 = "GirlSelectLayer/btn_push.png"
			end
		else
			var_52_1 = (#self.curData == 0 or self.curIndex and self.curData[self.curIndex] and self.curData[self.curIndex].soulid == self.initconfig.cursoul) and "GirlSelectLayer/btn_remove.png" or "GirlSelectLayer/btn_change.png"
		end
	end

	if self.selectType == SELECT_GIRL_DORMITORY then
		var_52_1 = "GirlSelectLayer/btn_push.png"
	end

	if self.selectType == SELECT_GIRL_QUICKFIGHT then
		var_52_1 = "GirlSelectLayer/btn_change.png"
	end

	if self.selectType == SELECT_GIRL_HOME then
		var_52_1 = "GirlSelectLayer/btn_push.png"
	end

	if self.selectType == SELECT_GIRL_TRAIN then
		var_52_1 = "GirlSelectLayer/btn_push.png"
	end

	if self.selectType == SELECT_GIRL_DORMITORY or self.selectType == SELECT_GIRL_HOME then
		self.bottomList:getChildByName("infoBtn"):setVisible(false)
		self.bottomList:getChildByName("sureBtn"):setVisible(self.selectGirl ~= nil)
	else
		self.bottomList:getChildByName("infoBtn"):setVisible(self.selectGirl ~= nil and playermodel.haveServant[self.selectGirl])
		self.bottomList:getChildByName("sureBtn"):setVisible(self.selectGirl ~= nil and playermodel.haveServant[self.selectGirl])
	end

	self.bottomList:getChildByName("sureBtn"):loadTextures(var_52_1, var_52_1, var_52_1, var_0_49)

	if self.selectType == SELECT_GIRL_DATABASE then
		self.bottomList:setVisible(false)
	elseif self.selectType == SELECT_GIRL_HOME then
		self.bottomList:getChildByName("sureBtn"):setVisible(false)
		self.bottomList:getChildByName("infoBtn"):setVisible(false)
	elseif self.selectType == SELECT_GIRL_EXPEDITION and not playermodel.haveServant[self.selectGirl] then
		self.bottomList:getChildByName("sureBtn"):setVisible(false)
		self.bottomList:getChildByName("infoBtn"):setVisible(false)
	elseif self.selectType == SELECT_GIRL_EXPEDITION_LIST then
		local var_52_3 = self.bottomList:getChildByName("sureBtn")
		local var_52_4 = self.bottomList:getChildByName("infoBtn")

		var_52_3:setVisible(false)
		var_52_4:setVisible(true)
		var_52_4:setPositionX(var_52_3:getPositionX())
	end
end

function GirlSelectLayer:getSureBtnHandel()
	local function var_53_0(arg_54_0, arg_54_1)
		if arg_54_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("没写点击事件")
	end

	if self.selectType == SELECT_GIRL_DORMITORY then
		function var_53_0(arg_55_0, arg_55_1)
			if arg_55_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_55_0:isBright() then
				return
			end

			arg_55_0:setBright(false)

			if self.sureCallBack then
				self.sureCallBack(self.selectGirl)
			end

			arg_55_0:setBright(true)

			var_0_39 = nil

			LayerManager:removePopLayer()
		end
	end

	if self.selectType == SELECT_GIRL_FIGHT then
		local var_53_1 = self.initconfig.arrayinfo.index
		local var_53_2 = self.initconfig.arrayinfo.pos

		function var_53_0(arg_56_0, arg_56_1)
			local var_56_0 = self.selectGirl

			if self.selectGirl == self.initconfig.cursoul then
				var_56_0 = nil
			end

			if arg_56_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_56_0:isBright() then
				return
			end

			arg_56_0:setBright(false)

			local function var_56_1(arg_57_0)
				array_manager:updateArrayFightgirl(var_53_1, var_53_2, var_56_0, arg_57_0, function(arg_58_0)
					if arg_58_0 == 1 then
						self.tableView:setVisible(false)

						if self.sureCallBack then
							self.sureCallBack(var_56_0)
						end

						var_0_39 = nil

						LayerManager:removePopLayer(self.__queueindex)
						require("controller.formation.base_formation_manager"):getInstance():playVoiceById(var_56_0)
						require("controller.formation.formation_manager"):getInstance():updateGirl()
					elseif arg_58_0 == 5 then
						global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Clear_Waring[1], RISE_WORDS_FAIL)
						audio_manager:playeffectMusicTest("sound/invalid")
						arg_56_0:setBright(true)
					elseif arg_58_0 == 6 then
						global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Clear_Waring[2], RISE_WORDS_FAIL)
						audio_manager:playeffectMusicTest("sound/invalid")
						arg_56_0:setBright(true)
					elseif arg_58_0 == 8 then
						global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Clear_Waring[3], RISE_WORDS_FAIL)
						audio_manager:playeffectMusicTest("sound/invalid")
						arg_56_0:setBright(true)
					elseif arg_58_0 == 4 then
						global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Clear_Waring[5], RISE_WORDS_FAIL)
						audio_manager:playeffectMusicTest("sound/invalid")
						arg_56_0:setBright(true)
					end
				end)
			end

			if self.selectType ~= SELECT_GIRL_ARENA_DEFENCE and self.selectType ~= SELECT_GIRL_ARENA_ATTACK then
				if array_manager:isServantInHangup(var_56_0) then
					local var_56_3 = 0

					for iter_56_0, iter_56_1 in pairs((array_manager:getBattleArrayData(playermodel.curArray))) do
						if iter_56_1.fight_girl then
							var_56_3 = var_56_3 + 1
						end
					end

					if var_56_3 == 0 then
						global_ShowBlockWords(L_GIRL_SELECT_GIRL_STATE.Patrol_Only)
						audio_manager:playeffectMusicTest("sound/invalid")
					else
						local var_56_4 = array_manager:getArrayByServantID(var_56_0)

						var_56_1()
					end
				else
					var_56_1()
				end

				arg_56_0:setBright(true)
			else
				var_56_1()
			end
		end
	elseif self.selectType == SELECT_GIRL_FIGHT_MODE or self.selectType == SELECT_GIRL_FIGHT_MATERIAL then
		local var_53_4 = self.initconfig.arrayinfo.pos

		function var_53_0(arg_60_0, arg_60_1)
			local var_60_0 = self.selectGirl

			if self.selectGirl == self.initconfig.cursoul then
				var_60_0 = nil
			end

			if arg_60_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_60_0:isBright() then
				return
			end

			arg_60_0:setBright(false)
			;(function(arg_61_0)
				require("controller.formation.formation_mode_manager"):getInstance():requestUpdateModeFightGirl(self.adverturemode, var_53_4, var_60_0, function(arg_62_0)
					if arg_62_0.result == 1 then
						self.tableView:setVisible(false)

						if self.sureCallBack then
							self.sureCallBack()
						end

						var_0_39 = nil

						LayerManager:removePopLayer(self.__queueindex)
					elseif arg_62_0.result == 4 then
						global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Clear_Waring[5], RISE_WORDS_FAIL)
						audio_manager:playeffectMusicTest("sound/invalid")
						arg_60_0:setBright(true)
					end
				end)
			end)()
		end
	elseif self.selectType == SELECT_GIRL_FIGHT_ELEMENTS then
		local var_53_6 = self.initconfig.arrayinfo.pos

		function var_53_0(arg_64_0, arg_64_1)
			local var_64_0 = self.selectGirl

			if self.selectGirl == self.initconfig.cursoul then
				var_64_0 = nil
			end

			if arg_64_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_64_0:isBright() then
				return
			end

			arg_64_0:setBright(false)
			;(function(arg_65_0)
				require("controller.formation.formation_mode_manager"):getInstance():requestUpdateModeFightGirl(self.adverturemode, var_53_6, var_64_0, function(arg_66_0)
					if arg_66_0.result == 1 then
						self.tableView:setVisible(false)

						if self.sureCallBack then
							self.sureCallBack()
						end

						var_0_39 = nil

						LayerManager:removePopLayer(self.__queueindex)
					elseif arg_66_0.result == 4 then
						global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Clear_Waring[5], RISE_WORDS_FAIL)
						audio_manager:playeffectMusicTest("sound/invalid")
						arg_64_0:setBright(true)
					end
				end)
			end)()
		end
	elseif self.selectType == SELECT_GIRL_FIGHT_POINT then
		local var_53_8 = self.initconfig.arrayinfo.pos

		function var_53_0(arg_68_0, arg_68_1)
			local var_68_0 = self.selectGirl

			if self.selectGirl == self.initconfig.cursoul then
				var_68_0 = nil
			end

			if arg_68_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_68_0:isBright() then
				return
			end

			arg_68_0:setBright(false)
			;(function(arg_69_0)
				require("controller.formation.formation_points_match_manager"):getInstance():requestUpdateArrayFightgirl(var_53_8, var_68_0, function(arg_70_0)
					if arg_70_0.result == 1 then
						self.tableView:setVisible(false)

						if self.sureCallBack then
							self.sureCallBack(var_68_0)
						end

						var_0_39 = nil

						LayerManager:removePopLayer(self.__queueindex)
					elseif arg_70_0.result == 4 then
						global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Clear_Waring[5], RISE_WORDS_FAIL)
						audio_manager:playeffectMusicTest("sound/invalid")
						arg_68_0:setBright(true)
					end
				end)
			end)()
		end
	end

	if self.selectType == SELECT_GIRL_EXPLORE_HP_INHERIT then
		function var_53_0(arg_72_0, arg_72_1)
			local var_72_0 = self.initconfig.arrayinfo.index
			local var_72_1 = self.initconfig.arrayinfo.pos

			if arg_72_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_72_0:isBright() then
				return
			end

			arg_72_0:setBright(false)

			local var_72_2 = self.selectGirl

			if self.isHpInherit and explore_manager:getHpInherit(var_72_2) <= 0 then
				arg_72_0:setBright(true)

				return
			end

			if self.selectGirl == self.initconfig.cursoul then
				var_72_2 = nil
			end

			local function var_72_3()
				require("controller.formation.formation_explore_manager"):getInstance():requestUpdateArrayFightgirl(var_72_0, var_72_1, var_72_2, function(arg_74_0)
					if arg_74_0 == 1 then
						self.tableView:setVisible(false)

						if self.sureCallBack then
							self.sureCallBack(var_72_2)
						end

						var_0_39 = nil

						LayerManager:removePopLayer(self.__queueindex)
					elseif arg_74_0 == 4 then
						global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Clear_Waring[5], RISE_WORDS_FAIL)
						audio_manager:playeffectMusicTest("sound/invalid")
						arg_72_0:setBright(true)
					elseif arg_74_0 == 5 then
						global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Clear_Waring[1], RISE_WORDS_FAIL)
						audio_manager:playeffectMusicTest("sound/invalid")
						arg_72_0:setBright(true)
					end
				end)
			end

			if var_72_2 and array_manager:isServantInArrayNowHpInherit(var_72_2) then
				local var_72_5 = array_manager:getArrayByServantIDHpInherit(var_72_2)

				var_72_3()
			else
				var_72_3()
			end
		end
	end

	if self.selectType == SELECT_GIRL_EXPLORE then
		if self.initconfig.arrayinfo then
			local var_53_9 = self.initconfig.arrayinfo.index
			local var_53_10 = self.initconfig.arrayinfo.pos

			function var_53_0(arg_76_0, arg_76_1)
				if arg_76_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_76_0:isBright() then
					return
				end

				arg_76_0:setBright(false)
				array_manager:updateArrayFightgirl(var_53_9, var_53_10, (self.selectGirl == self.initconfig.cursoul or nil) and nil, nil, function(arg_77_0)
					if arg_77_0 == 1 then
						self.tableView:setVisible(false)

						if self.sureCallBack then
							self.sureCallBack()
						end

						var_0_39 = nil

						LayerManager:removePopLayer()
						require("controller.formation.formation_explore_manager"):getInstance():updateGirl()
					elseif arg_77_0 == 5 then
						global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Clear_Waring[4], RISE_WORDS_FAIL)
						audio_manager:playeffectMusicTest("sound/invalid")
						arg_76_0:setBright(true)
					elseif arg_77_0 == 6 then
						global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Clear_Waring[2], RISE_WORDS_FAIL)
						audio_manager:playeffectMusicTest("sound/invalid")
						arg_76_0:setBright(true)
					else
						arg_76_0:setBright(true)
					end
				end)
			end
		else
			function var_53_0(arg_78_0, arg_78_1)
				if arg_78_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_78_0:isBright() then
					return
				end

				arg_78_0:setBright(false)

				if core_manager:getCoreLv(self.selectGirl) < self.initconfig.lv_limit then
					audio_manager:playeffectMusicTest("sound/invalid")
					global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Explore_Waring.Level_Lack)

					return
				elseif self.initconfig.exploringSouls[self.selectGirl] then
					audio_manager:playeffectMusicTest("sound/invalid")
					global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Explore_Waring.Exploring)

					return
				elseif self.initconfig.is_auto and explore_manager:getServantSanLevel(self.selectGirl) <= 1 or not self.initconfig.is_auto and explore_manager:getServantSanLevel(self.selectGirl) <= 2 then
					audio_manager:playeffectMusicTest("sound/invalid")
					global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Explore_Waring.Spirit)

					return
				end

				local var_78_0 = self.selectGirl

				if self.isHpInherit and explore_manager:getHpInherit(var_78_0) <= 0 then
					return
				end

				if self.selectGirl == self.initconfig.cursoul then
					var_78_0 = nil
				end

				if self.sureCallBack then
					self.sureCallBack(var_78_0)
				end

				var_0_39 = nil

				LayerManager:removePopLayer()
			end
		end
	end

	if self.selectType == SELECT_GIRL_SPECIAL then
		function var_53_0(arg_79_0, arg_79_1)
			if arg_79_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_79_0:isBright() then
				return
			end

			arg_79_0:setBright(false)

			local var_79_0 = self.selectGirl

			if self.isHpInherit and explore_manager:getHpInherit(var_79_0) <= 0 then
				arg_79_0:setBright(true)

				return
			end

			if self.selectGirl == self.initconfig.cursoul then
				var_79_0 = nil
			end

			if self.sureCallBack then
				self.sureCallBack(var_79_0)
			end

			var_0_39 = nil

			LayerManager:removePopLayer(self.__queueindex)
		end
	end

	if self.selectType == SELECT_GIRL_DATABASE then
		function var_53_0(arg_80_0, arg_80_1)
			if arg_80_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_80_0:isBright() then
				return
			end

			arg_80_0:setBright(false)

			if self.sureCallBack then
				self.sureCallBack(self.selectGirl)
			end

			self:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
				LayerManager:removePopLayer()

				var_0_39 = nil
			end)))
		end
	end

	if self.selectType == SELECT_GIRL_QUICKFIGHT then
		function var_53_0(arg_82_0, arg_82_1)
			if arg_82_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.sureCallBack then
				self.sureCallBack(self.selectGirl)
			end

			LayerManager:removePopLayer()
		end
	end

	if self.selectType == SELECT_GIRL_TRAIN then
		function var_53_0(arg_83_0, arg_83_1)
			if arg_83_1 ~= ccui.TouchEventType.ended then
				return
			end

			if playermodel.skill1Level[self.selectGirl] >= MAX_SKILL1_LEVLE then
				global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Train_Warning)
				audio_manager:playeffectMusicTest("sound/invalid")
			else
				if self.sureCallBack then
					self.sureCallBack(self.selectGirl)
				end

				LayerManager:removePopLayer()
			end
		end
	end

	if self.selectType == SELECT_GIRL_SUBSTITUTION then
		local var_53_11 = self.initconfig.arrayinfo.index
		local var_53_12 = self.initconfig.arrayinfo.pos

		function var_53_0(arg_84_0, arg_84_1)
			local var_84_0 = self.selectGirl

			if self.selectGirl == self.initconfig.cursoul then
				var_84_0 = nil
			end

			if arg_84_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_84_0:isBright() then
				return
			end

			arg_84_0:setBright(false)

			local function var_84_1(arg_85_0)
				require("controller.formation.formation_overclock_manager"):getInstance():requestUpdateArrayFightgirl(substitution_manager:getMode(), var_84_0, var_53_12, var_53_11, function(arg_86_0)
					if arg_86_0.result == 1 then
						self.tableView:setVisible(false)

						if self.sureCallBack then
							self.sureCallBack()
						end

						var_0_39 = nil

						LayerManager:removePopLayer(self.__queueindex)
					end
				end)
			end

			if var_84_0 and substitution_manager:isServantInDefArrayNow(var_84_0) then
				self:showSeizeArrayMemberPop(string.format(L_GIRL_SELECT_GIRL_STATE.In_Team, (substitution_manager:getArrayByServantID(var_84_0))), var_84_0, var_84_1, function()
					arg_84_0:setBright(true)
				end)
				arg_84_0:setBright(true)
			else
				var_84_1()
			end
		end
	end

	if self.selectType == SELECT_GIRL_TVT_DEFENCE then
		local var_53_13 = self.initconfig.arrayinfo.index
		local var_53_14 = self.initconfig.arrayinfo.pos

		function var_53_0(arg_88_0, arg_88_1)
			local var_88_0 = self.selectGirl

			if self.selectGirl == self.initconfig.cursoul then
				var_88_0 = nil
			end

			if arg_88_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_88_0:isBright() then
				return
			end

			arg_88_0:setBright(false)

			local function var_88_1(arg_89_0)
				arenatft_manager:set_arenatft_defence_servant(var_53_13, var_53_14, var_88_0, function(arg_90_0)
					if arg_90_0 == 1 then
						self.tableView:setVisible(false)

						if self.sureCallBack then
							self.sureCallBack()
						end

						var_0_39 = nil

						LayerManager:removePopLayer(self.__queueindex)
					elseif arg_90_0 == 6 then
						global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Define_Waring)
						audio_manager:playeffectMusicTest("sound/invalid")
						arg_88_0:setBright(true)
					elseif arg_90_0 == 7 then
						global_ShowBlockWords(string.format(L_GIRL_SELECT_CHANGE_WARNING.TvtDef_Waring, (arenatft_manager:getDefArrayByServantID(self.selectGirl))))
						audio_manager:playeffectMusicTest("sound/invalid")
						arg_88_0:setBright(true)
					end
				end)
			end

			if var_88_0 and arenatft_manager:isServantInDefArrayNow(var_88_0) then
				self:showSeizeArrayMemberPop(string.format(L_GIRL_SELECT_GIRL_STATE.In_Team, (arenatft_manager:getDefArrayByServantID(var_88_0))), var_88_0, var_88_1, function()
					arg_88_0:setBright(true)
				end)
				arg_88_0:setBright(true)
			else
				var_88_1()
			end
		end
	end

	if self.selectType == SELECT_GIRL_TVT_ATTACK then
		local var_53_15 = self.initconfig.arrayinfo.index
		local var_53_16 = self.initconfig.arrayinfo.pos

		function var_53_0(arg_92_0, arg_92_1)
			local var_92_0 = self.selectGirl

			if self.selectGirl == self.initconfig.cursoul then
				var_92_0 = nil
			end

			if arg_92_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_92_0:isBright() then
				return
			end

			arg_92_0:setBright(false)

			local function var_92_1(arg_93_0)
				arenatft_manager:set_arenatft_attack_servant(var_53_15, var_53_16, var_92_0, function(arg_94_0)
					if arg_94_0 == 1 then
						self.tableView:setVisible(false)

						if self.sureCallBack then
							self.sureCallBack()
						end

						var_0_39 = nil

						LayerManager:removePopLayer(self.__queueindex)
						require("controller.formation.formation_manager"):getInstance():updateGirl()
					elseif arg_94_0 == 6 then
						global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Attack_Waring)
						audio_manager:playeffectMusicTest("sound/invalid")
						arg_92_0:setBright(true)
					elseif arg_94_0 == 7 then
						global_ShowBlockWords(string.format(L_GIRL_SELECT_CHANGE_WARNING.TvtAtk_Waring, (arenatft_manager:getAtkArrayByServantID(self.selectGirl))))
						audio_manager:playeffectMusicTest("sound/invalid")
						arg_92_0:setBright(true)
					end
				end)
			end

			if var_92_0 and arenatft_manager:isServantInAtkArrayNow(var_92_0) then
				self:showSeizeArrayMemberPop(string.format(L_GIRL_SELECT_GIRL_STATE.In_Team, (arenatft_manager:getAtkArrayByServantID(var_92_0))), var_92_0, var_92_1, function()
					arg_92_0:setBright(true)
				end)
				arg_92_0:setBright(true)
			else
				var_92_1()
			end
		end
	end

	if self.selectType == SELECT_GIRL_ARENA_DEFENCE then
		function var_53_0(arg_96_0, arg_96_1)
			if arg_96_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_96_0:isBright() then
				return
			end

			arg_96_0:setBright(false)

			local var_96_0 = self.selectGirl

			if self.selectGirl == self.initconfig.cursoul then
				var_96_0 = nil
			end

			local var_96_1 = require("controller.formation.formation_grab_match_manager"):getInstance()

			var_96_1:requestUpdateArrayFightgirl(var_96_1.Type.Defend, var_96_0, self.initconfig.arrayinfo.pos, function(arg_97_0)
				if arg_97_0.result == 1 then
					self.tableView:setVisible(false)

					if self.sureCallBack then
						self.sureCallBack()
					end

					var_0_39 = nil

					LayerManager:removePopLayer(self.__queueindex)
				elseif arg_97_0.result == 5 then
					global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Define_Waring)
					arg_96_0:setBright(true)
				elseif arg_97_0.result == 4 then
					global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Clear_Waring[5], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
					arg_96_0:setBright(true)
				end
			end)
		end
	end

	if self.selectType == SELECT_GIRL_ARENA_ATTACK then
		function var_53_0(arg_98_0, arg_98_1)
			if arg_98_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_98_0:isBright() then
				return
			end

			arg_98_0:setBright(false)

			local var_98_0 = self.selectGirl

			if self.selectGirl == self.initconfig.cursoul then
				var_98_0 = nil
			end

			local var_98_1 = require("controller.formation.formation_grab_match_manager"):getInstance()

			var_98_1:requestUpdateArrayFightgirl(var_98_1.Type.Attack, var_98_0, self.initconfig.arrayinfo.pos, function(arg_99_0)
				if arg_99_0.result == 1 then
					self.tableView:setVisible(false)

					if self.sureCallBack then
						self.sureCallBack()
					end

					var_0_39 = nil

					LayerManager:removePopLayer(self.__queueindex)
				elseif arg_99_0.result == 5 then
					global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Attack_Waring)
					arg_98_0:setBright(true)
				elseif arg_99_0.result == 4 then
					global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Clear_Waring[5], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
					arg_98_0:setBright(true)
				end
			end)
		end
	end

	if self.selectType == SELECT_GIRL_EXPEDITION then
		function var_53_0(arg_100_0, arg_100_1)
			if arg_100_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_100_0:isBright() then
				return
			end

			arg_100_0:setBright(false)

			local var_100_0 = self.selectGirl

			if self.selectGirl == self.initconfig.cursoul then
				var_100_0 = nil
			end

			for iter_100_0 = 1, #self.arrayData do
				if self.arrayData[iter_100_0].fight_girl == var_100_0 then
					global_ShowBlockWords(L_GIRL_SELECT_CHANGE_WARNING.Clear_Waring[5], RISE_WORDS_FAIL)
					audio_manager:playeffectMusicTest("sound/invalid")
					arg_100_0:setBright(true)

					return
				end
			end

			expedition_manager:setExpeditionStudentList(self.initconfig.arrayinfo.pos, var_100_0, function(arg_101_0)
				if arg_101_0 == 1 then
					self.tableView:setVisible(false)

					if self.sureCallBack then
						self.sureCallBack()
					end

					var_0_39 = nil

					LayerManager:removePopLayer(self.__queueindex)
				end
			end)
		end
	end

	if self.selectType == SELECT_GIRL_TEST_FIGHT_EMPTY or self.selectType == SELECT_GIRL_TEST_FIGHT_PLAYER then
		function var_53_0(arg_102_0, arg_102_1)
			if arg_102_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_102_0 = self.curIndex
			local var_102_1

			if not self.curIndex then
				var_102_0 = 1
				var_102_1 = {
					curShowPanel = "Panel_dress",
					isTestFightSelect = true,
					soulid = servant_data[self.curData[var_102_0].soulid].major
				}
			end

			var_102_1.servantid = self.curData[var_102_0].soulid
			var_102_1.selectType = self.selectType
			var_102_1.arrayIndex = self.initconfig.arrayinfo.pos

			LayerManager:pushInLayer("DormRoomPopLayer", var_102_1)
		end
	end

	if self.selectType == SELECT_GIRL_ACTIVITY_GARRISON then
		function var_53_0(arg_103_0, arg_103_1)
			local var_103_0

			if arg_103_1 ~= ccui.TouchEventType.ended then
				do return end

				var_103_0 = {
					selectGirlIndex = self.selectGirlIndex
				}
			end

			var_103_0.selectGirl = self.selectGirl

			sendNotification("ActivityGarrisonSelectGirl", var_103_0)
			LayerManager:removePopLayer(self.__queueindex)
		end
	end

	return (self.selectType == SELECT_GIRL_AFK_LEVEL or nil) and function(arg_104_0, arg_104_1)
		if arg_104_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.sureCallBack then
			self.sureCallBack(self.selectGirl)
		end

		LayerManager:removePopLayer(self.__queueindex)
	end
end

function GirlSelectLayer:showSeizeArrayMemberPop(arg_105_1, arg_105_2, arg_105_3, arg_105_4, arg_105_5, arg_105_6)
	if not self.changeMemberPop then
		self.changeMemberPop = ccui.Layout:create()

		self.changeMemberPop:setTouchEnabled(true)
		self.changeMemberPop:setContentSize(GameDisplay.size)
		self.changeMemberPop:setAnchorPoint(cc.p(0.5, 0.5))
		self.changeMemberPop:setPosition(cc.p(GameDisplay.width / 2, GameDisplay.height / 2 - GameDisplay.fix_y))
		self.changeMemberPop:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		self.changeMemberPop:setBackGroundColor(cc.c3b(0, 0, 0))
		self.changeMemberPop:setBackGroundColorOpacity(180)
		self:addChild(self.changeMemberPop, 100)

		local var_105_0 = ccui.ImageView:create("public/panelbg/bg_pupup_level3.png", var_0_49)

		var_105_0:setPositionX(self.changeMemberPop:getContentSize().width / 2)
		var_105_0:setPositionY(self.changeMemberPop:getContentSize().height / 2)
		var_105_0:setName("bg")
		self.changeMemberPop:addChild(var_105_0)

		local var_105_1 = ccui.ImageView:create("GUI/image.png", var_0_49)

		var_105_1:setAnchorPoint(cc.p(0.5, 0))
		var_105_1:setPosition(cc.p(100, 10))
		var_105_1:setScale(0.5)
		var_105_1:setName("cuteRole")
		var_105_0:addChild(var_105_1)

		local var_105_2 = cc.Label:createWithTTF("111", FONT_DES, 28)

		var_105_2:setAnchorPoint(cc.p(0, 0.5))
		var_105_2:setColor(cc.c3b(181, 196, 201))
		var_105_2:setPositionY(var_105_0:getContentSize().height / 2 + 20)
		var_105_2:setPositionX(240)
		var_105_2:setName("desLabel")
		var_105_0:addChild(var_105_2)

		local var_105_3 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_49)

		var_105_3:setPositionY(var_105_0:getContentSize().height / 2 - 150)
		var_105_3:setPositionX(var_105_0:getContentSize().width / 2)
		var_105_3:setName("sureBtn")
		var_105_0:addChild(var_105_3)

		local var_105_4 = cc.Label:createWithTTF(L_GIRL_SELECT_SWITCH, FONT_BUTTON, 30)

		var_105_4:setPosition(cc.p(var_105_3:getContentSize().width / 2, var_105_3:getContentSize().height / 2 - 5))
		var_105_4:setColor(cc.c3b(55, 55, 63))
		var_105_4:setName("surelabelConfirm")
		var_105_3:addChild(var_105_4, 999)

		local var_105_5 = ccui.ImageView:create("public/panelbg/title_change_teammate.png", var_0_49)

		var_105_5:setAnchorPoint(cc.p(0, 0))
		var_105_5:setPosition(cc.p(0, var_105_0:getContentSize().height))
		var_105_5:setName("titleImg")
		var_105_0:addChild(var_105_5)

		local var_105_6 = ccui.Button:create("public/button/public_button_blue.png", nil, "public/button/public_button_blue.png", var_0_49)

		var_105_6:setPositionY(var_105_0:getContentSize().height / 2 - 150)
		var_105_6:setPositionX(var_105_0:getContentSize().width / 2 - 180)
		var_105_6:setName("cancelBnt")
		var_105_0:addChild(var_105_6)

		local var_105_7 = ccui.Text:create(L_BUTTON_TEXT.Interrupt, FONT_BUTTON, 30)

		var_105_7:setPosition(cc.p(var_105_6:getContentSize().width / 2, var_105_6:getContentSize().height / 2))
		var_105_7:setColor(cc.c3b(55, 55, 63))
		var_105_7:setName("cancellabelConfirm")
		var_105_6:addChild(var_105_7, 999)

		local var_105_8 = ccui.ImageView:create("public/currency/UI_battleEnd_diamond.png", var_0_49)

		var_105_8:setName("costIcon")
		var_105_8:setPosition(cc.p(var_105_3:getContentSize().width / 2, -5))
		var_105_3:addChild(var_105_8)

		local var_105_9 = ccui.Text:create("", FONT_DES, 22)

		var_105_9:setName("costLabel")
		var_105_9:setAnchorPoint(cc.p(0, 0.5))
		var_105_9:setPosition(cc.p(var_105_8:getPositionX() + var_105_8:getContentSize().width / 2 + 5, var_105_8:getPositionY()))
		var_105_3:addChild(var_105_9)
		var_105_6:addTouchEventListener(function(arg_106_0, arg_106_1)
			if arg_106_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_105_3 then
				arg_105_3(true)
			end
		end)
	end

	local var_105_10 = ccui.Helper:seekWidgetByName(self.changeMemberPop, "bg")

	if arg_105_5 then
		local var_105_11 = ccui.Helper:seekWidgetByName(self.changeMemberPop, "sureBtn")

		var_105_11:loadTextures("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", var_0_49)
		var_105_11:setPositionX(var_105_10:getContentSize().width / 2 + 180)
		var_105_11:getChildByName("surelabelConfirm"):setString(L_BUTTON_TEXT.Accelerate)
		var_105_11:getChildByName("surelabelConfirm"):setPosition(var_105_11:getContentSize().width / 2, var_105_11:getContentSize().height / 2)
		var_105_11:getChildByName("surelabelConfirm"):setPositionX(var_105_11:getContentSize().width / 2)
		self.changeMemberPop:getChildByName("bg"):getChildByName("sureBtn"):addTouchEventListener(function(arg_107_0, arg_107_1)
			if arg_107_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_105_3 then
				arg_105_3()
			end
		end)
	else
		local var_105_12 = ccui.Helper:seekWidgetByName(self.changeMemberPop, "sureBtn")

		var_105_12:loadTextures("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_49)
		var_105_12:setPositionY(var_105_10:getContentSize().height / 2 - 150)
		var_105_12:getChildByName("surelabelConfirm"):setString(L_GIRL_SELECT_SWITCH)
		var_105_12:setPositionX(var_105_10:getContentSize().width / 2)
		var_105_12:getChildByName("surelabelConfirm"):setPositionX(var_105_12:getContentSize().width / 2)
		self.changeMemberPop:getChildByName("bg"):getChildByName("sureBtn"):addTouchEventListener(function(arg_108_0, arg_108_1)
			if arg_108_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_105_3 then
				arg_105_3(true)
			end
		end)
	end

	local var_105_13 = ccui.Helper:seekWidgetByName(self.changeMemberPop, "costIcon")

	var_105_13:setPositionX(ccui.Helper:seekWidgetByName(self.changeMemberPop, "sureBtn"):getContentSize().width / 2 - 20)
	ccui.Helper:seekWidgetByName(self.changeMemberPop, "costLabel"):setPositionX(var_105_13:getPositionX() + var_105_13:getContentSize().width / 2 + 10)
	ccui.Helper:seekWidgetByName(self.changeMemberPop, "cancelBnt"):setVisible(arg_105_5 ~= nil)
	ccui.Helper:seekWidgetByName(self.changeMemberPop, "cancellabelConfirm"):setVisible(arg_105_5 ~= nil)
	ccui.Helper:seekWidgetByName(self.changeMemberPop, "costIcon"):setVisible(arg_105_5 ~= nil)
	ccui.Helper:seekWidgetByName(self.changeMemberPop, "costLabel"):setVisible(arg_105_5 ~= nil)

	if arg_105_6 then
		ccui.Helper:seekWidgetByName(self.changeMemberPop, "costLabel"):setString(arg_105_6)
	end

	self.changeMemberPop:addTouchEventListener(function(arg_109_0, arg_109_1)
		if arg_109_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.changeMemberPop:getChildByName("bg"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0), cc.CallFunc:create(function()
			self.changeMemberPop:setVisible(false)

			if arg_105_4 then
				arg_105_4()
			end
		end)))
	end)
	self.changeMemberPop:setVisible(true)

	local var_105_14 = self.changeMemberPop:getChildByName("bg")

	var_105_14:setScaleY(0)
	var_105_14:runAction(cc.ScaleTo:create(0.15, 1, 1))
	var_105_14:getChildByName("cuteRole"):loadTexture("roleimage/role1/" .. model_data[global_get_servant_skin(arg_105_2)].cute_role .. ".png")

	local var_105_15 = var_105_14:getChildByName("desLabel")

	var_105_15:setMaxLineWidth(380)
	var_105_15:setString(servant_data[arg_105_2].name .. "\n" .. arg_105_1)
end

function GirlSelectLayer:isShowTrainRedPoint(arg_111_1)
	if not skillup_cos_data[playermodel.skill1Level[arg_111_1]] then
		return false
	end

	return self:getNeedTrainTicketNum(arg_111_1) <= self:getOwnTrainTicketNum(arg_111_1)
end

function GirlSelectLayer.getOwnTrainTicketNum(arg_112_0, arg_112_1)
	if not skillup_cos_data[playermodel.skill1Level[arg_112_1]] then
		return 0
	end

	return (item_manager:getItemNumber(skillup_cos_data[playermodel.skill1Level[arg_112_1]]["cost_item" .. servant_data[arg_112_1].role_type]))
end

function GirlSelectLayer.getNeedTrainTicketNum(arg_113_0, arg_113_1)
	if not skillup_cos_data[playermodel.skill1Level[arg_113_1]] then
		return 0
	end

	return skillup_cos_data[playermodel.skill1Level[arg_113_1]].cost_num
end

function GirlSelectLayer.isShowSwimRedPoint(arg_114_0, arg_114_1)
	local var_114_0 = playermodel.fitness[arg_114_1].fitnesslevel

	if playermodel.fitness[arg_114_1].fitnesslevel >= train_manager:getSwimMaxLevel() then
		return false
	end

	if not fitness_data[var_114_0] then
		return false
	end

	return fitness_data[var_114_0].cost_num <= item_manager:getItemNumber(fitness_data[var_114_0].cost_item)
end

local var_0_51 = 640
local var_0_52 = 870
local var_0_53 = 0
local var_0_54 = 110
local var_0_55 = 640
local var_0_56 = 240
local var_0_57 = {
	cc.p(95, 120),
	cc.p(245, 120),
	cc.p(395, 120),
	(cc.p(545, 120))
}

function GirlSelectLayer:getTableviewHeight()
	local var_115_0 = var_0_52 + GameDisplay.fix_y * 2

	if self.selectType == SELECT_GIRL_DATABASE then
		var_115_0 = var_115_0 - 20
	end

	if self.selectType == SELECT_GIRL_DORMITORY then
		var_115_0 = var_115_0 + 20
	end

	return var_115_0
end

function GirlSelectLayer:getTableviewPosY(...)
	local var_116_0 = var_0_54

	if self.selectType == SELECT_GIRL_DATABASE then
		var_116_0 = var_116_0 + 20
	end

	if self.selectType == SELECT_GIRL_DORMITORY then
		var_116_0 = var_116_0 - 20
	end

	return var_116_0
end

function GirlSelectLayer:initTableView()
	self.tableView = cc.TableView:create(cc.size(var_0_51, self:getTableviewHeight()))
	self.tableView.displayheight = self:getTableviewHeight()

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setPosition(cc.p(var_0_53, self:getTableviewPosY()))
	self.tableView:setDelegate()
	self.tableView:setName("TableView")

	self.tableView.anchorPoint = cc.p(0, 0)

	self.rootLayer:addChild(self.tableView, 2)
	self.tableView:registerScriptHandler(function(arg_118_0, arg_118_1)
		return var_0_55, var_0_56
	end, cc.TABLECELL_SIZE_FOR_INDEX)

	local var_117_1 = require("controller.formation.formation_manager"):getInstance():getFormationInfoBySelectType(self.selectType, (self.initconfig.arrayinfo and self.initconfig.arrayinfo.index or nil) and self.initconfig.arrayinfo.index)

	local function var_117_2(arg_119_0, arg_119_1, arg_119_2)
		if self.selectType == SELECT_GIRL_HOME or self.selectType == SELECT_GIRL_DORMITORY then
			local var_119_0 = arg_119_0:getChildByName("girlSprite")

			if not var_119_0 then
				var_119_0 = GirlSprite:create({
					initType = "dormitoryStype"
				})

				var_119_0:setName("girlSprite")
				var_119_0:setPositionX(arg_119_0:getContentSize().width / 2)
				var_119_0:setPositionY(arg_119_0:getContentSize().height / 2)
				arg_119_0:addChild(var_119_0)
			end

			var_119_0:update(arg_119_1, self.selectType)

			if self.selectType == SELECT_GIRL_HOME and major_factor_data[model_data[playermodel.showgirl].major] and model_data[playermodel.showgirl].major == arg_119_1 then
				var_119_0:updateShopImage(playermodel.showgirl)
			end
		elseif self.selectType == SELECT_GIRL_EXPEDITION_LIST then
			local var_119_1 = arg_119_0:getChildByName("girlSprite")

			if not var_119_1 then
				var_119_1 = GirlSprite:create({
					initType = "girlSelectLayerStype",
					fightType = self.fightType,
					levelmode = self.adverturemode
				})

				var_119_1:setName("girlSprite")
				var_119_1:setPositionX(arg_119_0:getContentSize().width / 2)
				var_119_1:setPositionY(arg_119_0:getContentSize().height / 2)
				arg_119_0:addChild(var_119_1)
			end

			var_119_1:update(arg_119_1, self.isShowAttrs)

			local var_119_2 = ccui.ImageView:create("GirlSelectLayer/bar_bg.png", var_0_49)
			local var_119_3 = ccui.ImageView:create("GirlSelectLayer/blood.png", var_0_49)
			local var_119_4 = ccui.ImageView:create("GirlSelectLayer/blood_bg.png", var_0_49)
			local var_119_5 = ccui.ImageView:create("GirlSelectLayer/energy.png", var_0_49)
			local var_119_6 = ccui.ImageView:create("GirlSelectLayer/energy_bg.png", var_0_49)

			var_119_2:addChild(var_119_4)
			var_119_2:addChild(var_119_3)
			var_119_2:addChild(var_119_6)
			var_119_2:addChild(var_119_5)
			var_119_1:addChild(var_119_2, 10)
			var_119_2:setPosition(cc.p(60, 60))
			var_119_3:setAnchorPoint(cc.p(0, 0.5))
			var_119_4:setAnchorPoint(cc.p(0, 0.5))
			var_119_5:setAnchorPoint(cc.p(0, 0.5))
			var_119_6:setAnchorPoint(cc.p(0, 0.5))
			var_119_3:setPosition(cc.p(0, 13))
			var_119_4:setPosition(cc.p(0, 13))
			var_119_5:setPosition(cc.p(0, 5))
			var_119_6:setPosition(cc.p(0, 5))

			local var_119_7, var_119_8 = expedition_manager:getCurServantStatus(arg_119_1)

			var_119_3:setScaleX(var_119_7)
			var_119_5:setScaleX(var_119_8)
		elseif self.selectType == SELECT_GIRL_TEST_FIGHT_EMPTY or self.selectType == SELECT_GIRL_TEST_FIGHT_PLAYER then
			local var_119_9 = arg_119_0:getChildByName("girlSprite")

			if not var_119_9 then
				var_119_9 = GirlSprite:create({
					initType = "girlSelectTestFightStype",
					isHpInherit = self.isHpInherit
				})

				var_119_9:setName("girlSprite")
				var_119_9:setPositionX(arg_119_0:getContentSize().width / 2)
				var_119_9:setPositionY(arg_119_0:getContentSize().height / 2)
				arg_119_0:addChild(var_119_9)
			end

			var_119_9:update(arg_119_1, self.isShowAttrs)
			var_119_9:updateArrayTag()

			for iter_119_0 = 1, #var_117_1 do
				if var_117_1[iter_119_0] and var_117_1[iter_119_0].fight_girl == arg_119_1 then
					var_119_9:updateArrayTag(self:getFightTagDes(arg_119_1))

					break
				end
			end
		elseif self.selectType == SELECT_GIRL_AUTO_CHESS then
			local var_119_10 = arg_119_0:getChildByName("girlSprite")

			if not var_119_10 then
				var_119_10 = GirlSprite:create({
					initType = "girlSelectAutoChess"
				})

				var_119_10:setName("girlSprite")
				var_119_10:setPositionX(arg_119_0:getContentSize().width / 2)
				var_119_10:setPositionY(arg_119_0:getContentSize().height / 2)
				arg_119_0:addChild(var_119_10)
			end

			var_119_10:update(arg_119_1, self.curData[arg_119_2].star)
			var_119_10:updateArrayTag()
		elseif self.selectType == SELECT_GIRL_TVT_ATTACK then
			local var_119_11 = arg_119_0:getChildByName("girlSprite")

			if not var_119_11 then
				var_119_11 = GirlSprite:create({
					initType = "girlSelectLayerStype",
					fightType = self.fightType,
					levelmode = self.adverturemode,
					isHpInherit = self.isHpInherit
				})

				var_119_11:setName("girlSprite")
				var_119_11:setPositionX(arg_119_0:getContentSize().width / 2)
				var_119_11:setPositionY(arg_119_0:getContentSize().height / 2)
				arg_119_0:addChild(var_119_11)
			end

			var_119_11:update(arg_119_1, self.isShowAttrs)

			for iter_119_1 = 1, #var_117_1 do
				for iter_119_2 = 1, #var_117_1[iter_119_1] do
					if var_117_1[iter_119_1][iter_119_2] and var_117_1[iter_119_1][iter_119_2].fight_girl == arg_119_1 then
						var_119_11:updateArrayTag(L_TEAM .. L_NUMBER_TEXT[iter_119_1])

						break
					end
				end
			end
		else
			local var_119_12 = arg_119_0:getChildByName("girlSprite")

			if not var_119_12 then
				var_119_12 = GirlSprite:create({
					initType = "girlSelectLayerStype",
					fightType = self.fightType,
					levelmode = self.adverturemode,
					isHpInherit = self.isHpInherit
				})

				var_119_12:setName("girlSprite")
				var_119_12:setPositionX(arg_119_0:getContentSize().width / 2)
				var_119_12:setPositionY(arg_119_0:getContentSize().height / 2)
				arg_119_0:addChild(var_119_12)
			end

			var_119_12:update(arg_119_1, self.isShowAttrs)

			if SELECT_GIRL_SUBSTITUTION == self.selectType then
				var_119_12:updateArrayTag(self:getFightTagDes(arg_119_1))
			else
				var_119_12:updateArrayTag()

				for iter_119_3 = 1, #var_117_1 do
					if var_117_1[iter_119_3] and var_117_1[iter_119_3].fight_girl == arg_119_1 then
						var_119_12:updateArrayTag(self:getFightTagDes(arg_119_1))

						break
					end
				end
			end
		end

		if self.selectType ~= SELECT_GIRL_DATABASE then
			if arg_119_0:getChildByName("heightLight") then
				arg_119_0:removeChildByName("heightLight")
			end

			if self.selectType == SELECT_GIRL_DORMITORY and self.selectGirl == arg_119_1 and playermodel.haveSuit[self.selectGirl] or self.selectGirl == arg_119_1 and playermodel.haveServant[arg_119_1] then
				if not arg_119_0:getChildByName("heightLight") then
					self:createItemHightLight(arg_119_0)
				end
			elseif arg_119_0:getChildByName("heightLight") then
				arg_119_0:removeChildByName("heightLight")
			end
		end
	end

	local function var_117_3(arg_120_0, arg_120_1)
		if arg_120_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_120_0:getTouchBeganPosition().y - arg_120_0:getTouchEndPosition().y) > 50 then
			return
		end

		local var_120_0 = arg_120_0:getTag()

		if self.selectType == SELECT_GIRL_HOME then
			self.curIndex = var_120_0
			self.selectGirl = self.curData[self.curIndex].soulid
			self.selectModel = arg_120_0:getChildByName("girlSprite"):getModelid()

			self:switchToShowGirlSwitchLayer()
		elseif self.selectType == SELECT_GIRL_AUTO_CHESS then
			LayerManager:pushInLayer("PopAutoChessUpStarLayer", {
				exitCallBack = function()
					self:initGirlData()
					self:filterGirlData()
					self.tableView:reloadData()
				end,
				activityId = self.activityId,
				servantid = self.curData[var_120_0].soulid,
				star = self.curData[var_120_0].star
			})
		elseif self.selectType == SELECT_GIRL_TEST_FIGHT_EMPTY or self.selectType == SELECT_GIRL_TEST_FIGHT_PLAYER then
			LayerManager:pushInLayer("DormRoomPopLayer", {
				curShowPanel = "Panel_dress",
				isTestFightSelect = true,
				soulid = servant_data[self.curData[var_120_0].soulid].major,
				servantid = self.curData[var_120_0].soulid,
				selectType = self.selectType,
				arrayIndex = self.initconfig.arrayinfo.pos
			})

			return
		elseif self.selectType ~= SELECT_GIRL_DORMITORY then
			if self.selectType ~= SELECT_GIRL_AUTO_CHESS and self.selectType ~= SELECT_GIRL_DATABASE and not playermodel.haveServant[self.curData[var_120_0].soulid] then
				self:gotoEquipLayer(self.curData[var_120_0].soulid)

				return
			end
		elseif self.curData[var_120_0].soulid < 1000 and not playermodel.haveSuit[self.curData[var_120_0].soulid] then
			global_ShowBlockWords("未解锁")

			return
		end

		self.curIndex = var_120_0
		self.selectGirl = self.curData[self.curIndex].soulid

		self:updateShowingCells()
		self:updateButtomBtnList()

		if self.selectType == SELECT_GIRL_DATABASE then
			LayerManager:switchShowLayer("EquipLayer", {
				bottomBtnState = 1,
				intoType = "ListButtonLayer",
				layertype = "FightLayer",
				showtype = 5,
				cursoul = self.curData[self.curIndex].soulid
			})

			self.switchToEquiplayer = true
		end
	end

	local function var_117_4(arg_123_0, arg_123_1)
		local var_123_0
		local var_123_1 = 1

		if self.sortOrder == 0 then
			var_123_0 = 4 * arg_123_0
		else
			var_123_0 = #self.curData - 4 * arg_123_0 + 1
			var_123_1 = -1
		end

		return var_123_0 + arg_123_1 * var_123_1
	end

	self.tableView:registerScriptHandler(function(arg_124_0, arg_124_1)
		local var_124_0 = arg_124_0:dequeueCell()

		if var_124_0 == nil then
			var_124_0 = cc.TableViewCell:create()

			var_124_0:setName("cell_" .. arg_124_1)

			for iter_124_0 = 1, 4 do
				local var_124_1 = 4 * arg_124_1 + iter_124_0
				local var_124_2 = ccui.Button:create("public/rolebg/girlselect_frame.png", "public/rolebg/girlselect_frame.png", "public/rolebg/girlselect_frame.png", var_0_49)

				var_124_2:setName("sp_" .. iter_124_0)
				var_124_2:setCascadeOpacityEnabled(true)

				if self.sortOrder == 0 then
					var_124_2:setTag(var_124_1)
				else
					var_124_2:setTag(#self.curData - var_124_1 + 1)
				end

				var_124_2:setPosition(var_0_57[iter_124_0])
				var_124_2:setSwallowTouches(false)
				var_124_2:addTouchEventListener(var_117_3)
				var_124_0:addChild(var_124_2)

				if var_124_1 <= #self.curData then
					local var_124_3 = var_117_4(arg_124_1, iter_124_0)

					var_117_2(var_124_2, self.curData[var_124_3].soulid, var_124_3)
				else
					var_124_2:setVisible(false)
				end
			end
		else
			for iter_124_1 = 1, 4 do
				local var_124_4 = var_124_0:getChildByName("sp_" .. iter_124_1)
				local var_124_5 = 4 * arg_124_1 + iter_124_1

				if self.sortOrder == 0 then
					var_124_4:setTag(var_124_5)
				else
					var_124_4:setTag(#self.curData - var_124_5 + 1)
				end

				if var_124_5 <= #self.curData then
					local var_124_6 = var_117_4(arg_124_1, iter_124_1)

					var_117_2(var_124_4, self.curData[var_124_6].soulid, var_124_6)
					var_124_4:setVisible(true)
				else
					var_124_4:setVisible(false)
				end
			end
		end

		if self.startRunOutAni then
			self.startIndex = self.startIndex or arg_124_1

			local var_124_7 = LAYER_OUT_TIME / math.ceil(self:getTableviewHeight() / var_0_56)

			for iter_124_2 = 1, 4 do
				if var_124_0:getChildByName("sp_" .. iter_124_2) then
					if ccui.Helper:seekWidgetByName(var_124_0:getChildByName("sp_" .. iter_124_2), "favoriteLabel") then
						ccui.Helper:seekWidgetByName(var_124_0:getChildByName("sp_" .. iter_124_2), "favoriteLabel"):setVisible(false)
					end

					if ccui.Helper:seekWidgetByName(var_124_0:getChildByName("sp_" .. iter_124_2), "fightlabel") then
						ccui.Helper:seekWidgetByName(var_124_0:getChildByName("sp_" .. iter_124_2), "fightlabel"):setVisible(false)
					end

					if Utility:seekChildByName(var_124_0:getChildByName("sp_" .. iter_124_2), "progressTimer") then
						Utility:seekChildByName(var_124_0:getChildByName("sp_" .. iter_124_2), "progressTimer"):setVisible(false)
					end

					var_124_0:getChildByName("sp_" .. iter_124_2):runAction(cc.Sequence:create(cc.DelayTime:create((arg_124_1 - self.startIndex) * var_124_7 + var_124_7 * (iter_124_2 - 1) / 4), cc.FadeOut:create(var_124_7)))
				end
			end
		end

		if self.selectTblAni then
			self.selectTblAniStartIdx = self.selectTblAniStartIdx or arg_124_1

			local var_124_8 = LAYER_OUT_TIME / math.ceil(self:getTableviewHeight() / var_0_56)

			for iter_124_3 = 1, 4 do
				if var_124_0:getChildByName("sp_" .. iter_124_3) then
					if ccui.Helper:seekWidgetByName(var_124_0:getChildByName("sp_" .. iter_124_3), "favoriteLabel") then
						ccui.Helper:seekWidgetByName(var_124_0:getChildByName("sp_" .. iter_124_3), "favoriteLabel"):setVisible(false)
					end

					if ccui.Helper:seekWidgetByName(var_124_0:getChildByName("sp_" .. iter_124_3), "fightlabel") then
						ccui.Helper:seekWidgetByName(var_124_0:getChildByName("sp_" .. iter_124_3), "fightlabel"):setVisible(false)
					end

					var_124_0:getChildByName("sp_" .. iter_124_3):setOpacity(0)
					var_124_0:getChildByName("sp_" .. iter_124_3):runAction(cc.Sequence:create(cc.DelayTime:create((arg_124_1 - self.selectTblAniStartIdx) * var_124_8 + var_124_8 * (iter_124_3 - 1) / 4), cc.FadeIn:create(var_124_8), cc.CallFunc:create(function()
						if ccui.Helper:seekWidgetByName(var_124_0:getChildByName("sp_" .. iter_124_3), "favoriteLabel") then
							ccui.Helper:seekWidgetByName(var_124_0:getChildByName("sp_" .. iter_124_3), "favoriteLabel"):setVisible(ccui.Helper:seekWidgetByName(var_124_0:getChildByName("sp_" .. iter_124_3), "favoriteLabel").visible or false)
						end

						if ccui.Helper:seekWidgetByName(var_124_0:getChildByName("sp_" .. iter_124_3), "fightlabel") then
							ccui.Helper:seekWidgetByName(var_124_0:getChildByName("sp_" .. iter_124_3), "fightlabel"):setVisible(true)
						end
					end)))
				end
			end
		elseif not self.startRunOutAni then
			for iter_124_4 = 1, 4 do
				if var_124_0:getChildByName("sp_" .. iter_124_4) then
					var_124_0:getChildByName("sp_" .. iter_124_4):setOpacity(255)

					if ccui.Helper:seekWidgetByName(var_124_0:getChildByName("sp_" .. iter_124_4), "favoriteLabel") then
						ccui.Helper:seekWidgetByName(var_124_0:getChildByName("sp_" .. iter_124_4), "favoriteLabel"):setVisible(ccui.Helper:seekWidgetByName(var_124_0:getChildByName("sp_" .. iter_124_4), "favoriteLabel").visible or false)
					end

					if ccui.Helper:seekWidgetByName(var_124_0:getChildByName("sp_" .. iter_124_4), "fightlabel") then
						ccui.Helper:seekWidgetByName(var_124_0:getChildByName("sp_" .. iter_124_4), "fightlabel"):setVisible(true)
					end
				end
			end
		end

		return var_124_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_126_0, arg_126_1)
		return (math.ceil(#self.curData / 4))
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:registerScriptHandler(function(arg_127_0)
		self.tableViewLastPercent = 100 - math.abs((arg_127_0:getContainer():getPositionY())) / arg_127_0:getContainer():getContentSize().height * 100
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	self.tableView:reloadData()

	if var_0_40 then
		self.selectTblAni = true

		self.tableView:scrollToPercent(var_0_40, nil, false)
	end
end

function GirlSelectLayer.createItemHightLight(arg_128_0, arg_128_1)
	local var_128_2 = ccui.Layout:create()
	local var_128_3

	if config._DEBUG then
		var_128_3 = cc.Sprite:create("public/rolebg/new_servant_bg_on1.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/new_servant_bg_on1.png")
	end

	var_128_3:setPosition(arg_128_1:getContentSize().width / 2 - 2, arg_128_1:getContentSize().height / 2)
	var_128_2:addChild(var_128_3)
	var_128_2:setName("heightLight")
	arg_128_1:addChild(var_128_2, 9)
end

function GirlSelectLayer:updateGirlInfo(arg_129_1, arg_129_2)
	if not arg_129_1:getChildByName("info_page") then
		local var_129_0 = ccui.ImageView:create("public/rolebg/black_rolelist.png", var_0_49)

		var_129_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_129_0:setPosition(cc.p(arg_129_1:getContentSize().width / 2, arg_129_1:getContentSize().height / 2))
		var_129_0:setName("info_page")
		arg_129_1:addChild(var_129_0, 3)

		if self.selectType ~= SELECT_GIRL_HOME then
			if self.selectType == SELECT_GIRL_DORMITORY then
				local var_129_1 = cc.Label:createWithTTF("", FONT_DES, 18)

				var_129_1:setPosition(cc.p(7, 255))
				var_129_1:setMaxLineWidth(187)
				var_129_1:setAnchorPoint(cc.p(0, 1))
				var_129_1:setName("roleIntroduce")
				var_129_0:addChild(var_129_1)

				goto label_129_0
			end
		end

		local var_129_2 = 20
		local var_129_3 = 192
		local var_129_4 = {
			{
				L_GIRL_INFO_TABLE[1],
				[2] = "careerLabel"
			},
			{
				L_GIRL_INFO_TABLE[2],
				[2] = "lvLabel"
			},
			{
				L_GIRL_INFO_TABLE[3],
				[2] = "fightCapacityLabel"
			},
			{
				L_GIRL_INFO_TABLE[4],
				[2] = "attackLabel"
			},
			{
				L_GIRL_INFO_TABLE[5],
				[2] = "hpLabel"
			}
		}

		for iter_129_0 = 1, 5 do
			local var_129_5 = 20
			local var_129_7

			if var_129_4[iter_129_0][2] == "careerLabel" then
				var_129_5 = 26
				var_129_7 = 5
			else
				var_129_5 = 20
				var_129_7 = 0
			end

			local var_129_8 = cc.Label:createWithTTF(var_129_4[iter_129_0][1], FONT_DES, var_129_5)

			var_129_8:setPosition(cc.p(var_129_2, var_129_3 + var_129_7))
			var_129_8:setAnchorPoint(cc.p(0, 1))
			var_129_8:setColor(cc.c3b(255, 255, 255))
			var_129_8:setName("label1_" .. iter_129_0)
			var_129_0:addChild(var_129_8)

			local var_129_9 = cc.Label:createWithTTF("", FONT_DES, var_129_5)

			var_129_9:setPosition(cc.p(var_129_8:getContentSize().width + var_129_2, var_129_3 + var_129_7))
			var_129_9:setAnchorPoint(cc.p(0, 1))
			var_129_9:setName(var_129_4[iter_129_0][2])
			var_129_9:setColor(cc.c3b(255, 255, 255))
			var_129_0:addChild(var_129_9)

			var_129_3 = var_129_3 - var_129_5
		end
	end

	::label_129_0::

	local var_129_10 = arg_129_1:getChildByName("info_page")

	if self.selectType == SELECT_GIRL_HOME or self.selectType == SELECT_GIRL_DORMITORY then
		if not dorm_property_data[arg_129_2] then
			print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
			print("~~~~~~~dormPropertyData没有:" .. arg_129_2 .. "~~~~~~~")
			print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
		end

		var_129_10:getChildByName("roleIntroduce"):setString((dorm_property_data[arg_129_2] or nil) and (dorm_property_data[arg_129_2].dec or L_GIRL_SELECT_SECRET))
	else
		local var_129_12 = model_manager.new()

		var_129_12:initPlayerAttribute(arg_129_2)

		if playermodel.haveServant[arg_129_2] and playermodel.weaponId[arg_129_2] then
			weaponOthers = weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[arg_129_2]])

			var_129_12:updateWeaponAttr(weaponOthers)
		end

		local var_129_13, var_129_14 = component_manager:getSoulComponentlist(arg_129_2)

		var_129_12:updateComponentAttr(var_129_13)

		local var_129_15 = var_129_10:getChildByName("lvLabel")
		local var_129_16 = var_129_10:getChildByName("attackLabel")
		local var_129_17 = var_129_10:getChildByName("hpLabel")
		local var_129_18 = var_129_10:getChildByName("careerLabel")
		local var_129_19 = var_129_10:getChildByName("fightCapacityLabel")

		if playermodel.haveServant[arg_129_2] then
			local var_129_20 = core_manager:getServantCoreRank(arg_129_2)

			var_129_15:setString(core_manager:getCoreLv(arg_129_2))
			var_129_16:setString(var_129_12:getAttribute("damage"))
			var_129_17:setString(var_129_12:getAttribute("hp"))
			var_129_18:setString(L_CAREER[SERVANT_CAREE_TBL[var_129_12:getAttribute("career")]])
			var_129_19:setString(fight_capacity_manager:getSoulFightCapacity(arg_129_2))
			var_129_10:getChildByName("label1_1"):setVisible(true)
			var_129_10:getChildByName("label1_2"):setVisible(true)
			var_129_10:getChildByName("label1_3"):setVisible(true)
			var_129_10:getChildByName("label1_4"):setVisible(true)
			var_129_10:getChildByName("label1_5"):setVisible(true)
			var_129_15:setVisible(true)
			var_129_16:setVisible(true)
			var_129_17:setVisible(true)
			var_129_18:setVisible(true)
			var_129_19:setVisible(true)
		else
			var_129_10:getChildByName("label1_1"):setVisible(false)
			var_129_10:getChildByName("label1_2"):setVisible(false)
			var_129_10:getChildByName("label1_3"):setVisible(false)
			var_129_10:getChildByName("label1_4"):setVisible(false)
			var_129_10:getChildByName("label1_5"):setVisible(false)
			var_129_15:setVisible(false)
			var_129_16:setVisible(false)
			var_129_17:setVisible(false)
			var_129_18:setVisible(false)
			var_129_19:setVisible(false)
		end
	end
end

function GirlSelectLayer.getAttrIconPath(arg_131_0, arg_131_1)
	return global_get_model_attr(servant_data[arg_131_1].modelid)
end

function GirlSelectLayer:filterGirlData()
	if not next(self.curData) then
		-- block empty
	end

	self.curData = {}

	local function var_132_1(arg_133_0, arg_133_1)
		if not next(arg_133_0) then
			return true
		end

		if servant_data[arg_133_1] then
			return true
		end

		if self.selectType == SELECT_GIRL_DORMITORY then
			return true
		end

		for iter_133_0, iter_133_1 in pairs(arg_133_0) do
			if iter_133_1 == var_133_0 then
				return true
			end
		end

		return false
	end

	local function var_132_2(arg_134_0, arg_134_1)
		if not arg_134_0 then
			return true
		end

		if not next(arg_134_0) then
			return true
		end

		local var_134_0 = false

		for iter_134_0, iter_134_1 in pairs(arg_134_0) do
			if iter_134_1 == "linkage" then
				var_134_0 = true
			end
		end

		if var_134_0 then
			local var_134_1 = {}

			for iter_134_2, iter_134_3 in pairs(servant_data) do
				if iter_134_3.classtype == 1 and iter_134_3.linkage then
					var_134_1[global_get_model_attr(iter_134_3.modelid)] = true
				end
			end

			for iter_134_4, iter_134_5 in pairs(var_134_1) do
				table.insert(arg_134_0, iter_134_4)
			end
		end

		local var_134_2 = false

		for iter_134_6, iter_134_7 in pairs(arg_134_0) do
			if iter_134_7 == "other" then
				var_134_2 = true
			end
		end

		if var_134_2 then
			local var_134_3 = {}

			for iter_134_8, iter_134_9 in pairs(ATTR_OTHER_LIST) do
				var_134_3[iter_134_8] = true
			end

			for iter_134_10, iter_134_11 in pairs(var_134_3) do
				table.insert(arg_134_0, iter_134_10)
			end
		end

		local var_134_4 = (self.selectType == SELECT_GIRL_FIGHT or self.selectType == SELECT_GIRL_FIGHT_MODE or self.selectType == SELECT_GIRL_DATABASE or self.selectType == SELECT_GIRL_EXPLORE or self.selectType == SELECT_GIRL_QUICKFIGHT or self.selectType == SELECT_GIRL_TRAIN or self.selectType == SELECT_GIRL_ARENA_DEFENCE or self.selectType == SELECT_GIRL_SPECIAL or self.selectType == SELECT_GIRL_ARENA_ATTACK or self.selectType == SELECT_GIRL_TVT_DEFENCE or self.selectType == SELECT_GIRL_TVT_ATTACK or self.selectType == SELECT_GIRL_SUBSTITUTION or self.selectType == SELECT_GIRL_EXPLORE_HP_INHERIT or self.selectType == SELECT_GIRL_EXPEDITION or self.selectType == SELECT_GIRL_EXPEDITION_LIST or self.selectType == SELECT_GIRL_FIGHT_POINT or self.selectType == SELECT_GIRL_FIGHT_MATERIAL or self.selectType == SELECT_GIRL_FIGHT_ELEMENTS or self.selectType == SELECT_GIRL_TEST_FIGHT_EMPTY or self.selectType == SELECT_GIRL_TEST_FIGHT_PLAYER or self.selectType == SELECT_GIRL_AUTO_CHESS or self.selectType == SELECT_GIRL_ACTIVITY_GARRISON or self.selectType == SELECT_GIRL_AFK_LEVEL) and servant_data[arg_134_1].modelid or major_factor_data[arg_134_1].model

		for iter_134_12, iter_134_13 in pairs(arg_134_0) do
			if model_data[var_134_4][iter_134_13] then
				return true
			end
		end

		return false
	end

	local function var_132_3(arg_135_0, arg_135_1)
		if not arg_135_0 or not next(arg_135_0) then
			return true
		end

		if not servant_data[arg_135_1] then
			return false
		end

		local var_135_0 = souls_manager:get_servant_cur_roll_rarity(arg_135_1)

		for iter_135_0, iter_135_1 in pairs(arg_135_0) do
			if iter_135_1 == var_135_0 then
				return true
			end
		end

		return false
	end

	local function var_132_4(arg_136_0, arg_136_1)
		if not arg_136_0 or not next(arg_136_0) then
			return true
		end

		if not servant_data[arg_136_1] then
			return false
		end

		local var_136_0 = SERVANT_CAREE_TBL[model_data[servant_data[arg_136_1].modelid].career]

		for iter_136_0, iter_136_1 in pairs(arg_136_0) do
			if iter_136_1 == var_136_0 then
				return true
			end
		end

		return false
	end

	local function var_132_5(arg_137_0, arg_137_1)
		if not arg_137_0 or not next(arg_137_0) then
			return true
		end

		if not servant_data[arg_137_1] then
			return false
		end

		for iter_137_0, iter_137_1 in pairs(arg_137_0) do
			if iter_137_1 == "breakLimit" and core_manager:isBreakLimit(arg_137_1) then
				return true
			end

			if iter_137_1 == "linkage" and servant_data[arg_137_1].linkage_new then
				return true
			end
		end

		return false
	end

	local var_132_6 = {}

	for iter_132_0, iter_132_1 in pairs(self.allData) do
		if self.selectType == SELECT_GIRL_DATABASE and servant_data[iter_132_1.soulid] and array_manager:isServantInHangup(iter_132_1.soulid) then
			table.insert(var_132_6, iter_132_1)
		elseif var_132_1(self.filterType[1], iter_132_1.soulid) and var_132_2(self.filterType[2], iter_132_1.soulid) and var_132_3(self.filterType[3], iter_132_1.soulid) and var_132_4(self.filterType[4], iter_132_1.soulid) and var_132_5(self.filterType[5], iter_132_1.soulid) then
			table.insert(self.curData, iter_132_1)
		end
	end

	if self.selectType == SELECT_GIRL_DATABASE then
		(function()
			table.sort(var_132_6, function(arg_139_0, arg_139_1)
				local var_139_0 = arg_139_0.afkLV or arg_139_0.LV
				local var_139_1 = arg_139_1.afkLV or arg_139_1.LV

				if var_139_0 == var_139_1 then
					return arg_139_0.soulid > arg_139_1.soulid
				else
					return var_139_0 <= var_139_1
				end
			end)

			for iter_138_0, iter_138_1 in pairs(var_132_6) do
				if var_132_1(self.filterType[1], iter_138_1.soulid) and var_132_2(self.filterType[2], iter_138_1.soulid) and var_132_3(self.filterType[3], iter_138_1.soulid) and var_132_4(self.filterType[4], iter_138_1.soulid) and var_132_5(self.filterType[5], iter_138_1.soulid) then
					if self.selectType == SELECT_GIRL_DATABASE then
						if playermodel.haveServant[iter_138_1.soulid] then
							table.insert(self.curData, 1, iter_138_1)
						end
					else
						table.insert(self.curData, 1, iter_138_1)
					end
				end
			end
		end)()
	end

	;(function(arg_141_0, arg_141_1)
		local function var_141_0(arg_142_0, arg_142_1)
			if arg_141_1 == 0 then
				return arg_142_0.soulid < arg_142_1.soulid
			else
				return arg_142_0.soulid > arg_142_1.soulid
			end
		end

		local function var_141_1(arg_143_0, arg_143_1)
			if self.selectType == SELECT_GIRL_DORMITORY then
				if arg_141_1 == 0 then
					return arg_143_0.soulid < arg_143_1.soulid
				else
					return arg_143_0.soulid > arg_143_1.soulid
				end
			elseif arg_143_0.soulid > 1000 then
				if arg_141_1 == 0 then
					return servant_data[arg_143_0.soulid].major < servant_data[arg_143_1.soulid].major
				else
					return servant_data[arg_143_0.soulid].major > servant_data[arg_143_1.soulid].major
				end
			elseif arg_141_1 == 0 then
				return arg_143_0.soulid < arg_143_1.soulid
			else
				return arg_143_0.soulid > arg_143_1.soulid
			end
		end

		local function var_141_2(arg_144_0, arg_144_1)
			local var_144_0 = playermodel.servant_unlock_time and playermodel.servant_unlock_time[arg_144_0.soulid]
			local var_144_1 = playermodel.servant_unlock_time and playermodel.servant_unlock_time[arg_144_1.soulid]

			if var_144_0 == 0 then
				var_144_0 = servant_data[arg_144_0.soulid].major
			end

			if var_144_1 == 0 then
				var_144_1 = servant_data[arg_144_1.soulid].major
			end

			if var_144_0 == var_144_1 then
				return "=="
			else
				return var_144_1 < var_144_0
			end
		end

		local function var_141_3(arg_145_0, arg_145_1)
			local var_145_0 = playermodel.soulOverClock[arg_145_0.soulid] > 0 and 6 or playermodel.soulContract[arg_145_0.soulid] or 0
			local var_145_1 = playermodel.soulOverClock[arg_145_1.soulid] > 0 and 6 or playermodel.soulContract[arg_145_1.soulid] or 0

			if var_145_0 == var_145_1 then
				return "=="
			else
				return var_145_1 < var_145_0
			end
		end

		local function var_141_4(arg_146_0, arg_146_1)
			local var_146_0 = arg_146_0.afkLV or arg_146_0.LV
			local var_146_1 = arg_146_1.afkLV or arg_146_1.LV

			if var_146_0 == var_146_1 then
				return "=="
			elseif arg_141_1 == 0 then
				return var_146_0 < var_146_1
			else
				return var_146_1 < var_146_0
			end
		end

		local function var_141_5(arg_147_0, arg_147_1)
			if not arg_147_0.sortRarity or not arg_147_1.sortRarity then
				return "=="
			end

			if arg_147_0.sortRarity == arg_147_1.sortRarity then
				return "=="
			end

			if arg_141_1 == 0 then
				return arg_147_0.sortRarity < arg_147_1.sortRarity
			else
				return arg_147_0.sortRarity > arg_147_1.sortRarity
			end
		end

		local function var_141_9(arg_152_0, arg_152_1)
			if self.selectType ~= SELECT_GIRL_HOME and self.selectType ~= SELECT_GIRL_DORMITORY then
				local var_152_0 = playermodel.haveServant[arg_152_0.soulid] and 1 or 0
				local var_152_1 = playermodel.haveServant[arg_152_1.soulid] and 1 or 0

				if (playermodel.haveServant[arg_152_0.soulid] and 1 or 0) == (playermodel.haveServant[arg_152_1.soulid] and 1 or 0) then
					return "=="
				else
					return var_152_1 < var_152_0
				end
			else
				local var_152_2 = playermodel.haveSuit[arg_152_0.soulid] and 1 or 0
				local var_152_3 = playermodel.haveSuit[arg_152_1.soulid] and 1 or 0

				if (playermodel.haveSuit[arg_152_0.soulid] and 1 or 0) == (playermodel.haveSuit[arg_152_1.soulid] and 1 or 0) then
					return "=="
				else
					return var_152_3 < var_152_2
				end
			end
		end

		local function var_141_10(arg_153_0, arg_153_1)
			local var_153_1 = require("controller.formation.formation_manager"):getInstance():getFormationInfoBySelectType(self.selectType, (self.initconfig.arrayinfo and self.initconfig.arrayinfo.index or nil) and self.initconfig.arrayinfo.index)

			local function var_153_2(arg_154_0)
				for iter_154_0 = 1, #var_153_1 do
					if var_153_1[iter_154_0] and var_153_1[iter_154_0].fight_girl == arg_154_0 then
						return true
					end
				end

				return false
			end

			local function var_153_3(arg_155_0)
				for iter_155_0 = 1, #var_153_1 do
					if var_153_1[iter_155_0] and var_153_1[iter_155_0].fight_girl == arg_155_0 then
						return iter_155_0
					end
				end
			end

			local var_153_4 = var_153_2(arg_153_0.soulid)
			local var_153_5 = var_153_2(arg_153_1.soulid)
			local var_153_6
			local var_153_7

			if var_153_4 and var_153_5 then
				var_153_6 = var_153_3(arg_153_0.soulid)
				var_153_7 = var_153_3(arg_153_1.soulid)
			elseif var_153_4 and not var_153_5 then
				var_153_6 = var_153_3(arg_153_0.soulid)
				var_153_7 = 999
			elseif not var_153_4 and var_153_5 then
				var_153_6 = 999
				var_153_7 = var_153_3(arg_153_1.soulid)
			else
				var_153_6 = 999
				var_153_7 = 999
			end

			if var_153_6 == var_153_7 then
				return "=="
			end

			return var_153_6 < var_153_7
		end

		local var_141_11 = {
			{
				weight = 7,
				func = var_141_5
			},
			{
				weight = 5,
				func = var_141_4
			},
			{
				weight = 6,
				func = var_141_2
			},
			{
				weight = 4,
				func = var_141_3
			},
			{
				weight = 2,
				func = var_141_0
			},
			{
				weight = 3,
				func = var_141_1
			},
			{
				weight = 11000,
				func = function(self, arg_151_1)
					local var_151_0 = playermodel.newservants[self.soulid] and 1 or 0
					local var_151_1 = playermodel.newservants[arg_151_1.soulid] and 1 or 0

					if playermodel.newservants[self.soulid] then
						self.newPlayerServantId[self.soulid] = true
					end

					if playermodel.newservants[arg_151_1.soulid] then
						self.newPlayerServantId[arg_151_1.soulid] = true
					end

					if var_151_0 == var_151_1 then
						return "=="
					else
						return var_151_1 < var_151_0
					end
				end
			},
			{
				weight = 12000,
				func = var_141_9
			},
			{
				weight = 13000,
				func = var_141_10
			}
		}

		if self.selectType ~= SELECT_GIRL_DORMITORY then
			if self.selectType == SELECT_GIRL_HOME then
				local var_141_12 = {}
				local var_141_13 = {
					weight = 3
				}

				function var_141_13:func(arg_156_1)
					local var_156_0 = playermodel.favor[self.soulid].favorlevel or 0
					local var_156_1 = playermodel.favor[arg_156_1.soulid].favorlevel or 0

					if var_156_0 == var_156_1 then
						return "=="
					else
						return var_156_1 < var_156_0
					end
				end

				var_141_12[1] = var_141_13
				var_141_12[2] = {
					weight = 2,
					func = function(self, arg_157_1)
						if arg_141_1 == 0 then
							return self.soulid < arg_157_1.soulid
						else
							return self.soulid > arg_157_1.soulid
						end
					end
				}
				var_141_12[3] = {
					weight = 11000,
					func = function(self, arg_158_1)
						local var_158_0 = self.soulid < 1000 and 0 or 1
						local var_158_1 = arg_158_1.soulid < 1000 and 0 or 1

						if (self.soulid < 1000 and 0 or 1) == (arg_158_1.soulid < 1000 and 0 or 1) then
							return "=="
						end

						if arg_141_1 == 0 then
							return var_158_0 < var_158_1
						else
							return var_158_1 < var_158_0
						end
					end
				}
				var_141_12[4] = {
					weight = 12000,
					func = var_141_9
				}
				var_141_11 = var_141_12
			elseif self.selectType == SELECT_GIRL_TEST_FIGHT_EMPTY or self.selectType == SELECT_GIRL_TEST_FIGHT_PLAYER then
				var_141_11 = {
					{
						weight = 3,
						func = var_141_1
					},
					{
						weight = 5,
						func = var_141_4
					},
					{
						weight = 7,
						func = var_141_5
					},
					{
						weight = 4,
						func = var_141_3
					},
					{
						weight = 6,
						func = var_141_2
					},
					{
						weight = 2,
						func = var_141_0
					},
					{
						weight = 13000,
						func = var_141_10
					}
				}
			end
		end

		var_141_11[arg_141_0].weight = var_141_11[arg_141_0].weight + 100

		table.sort(var_141_11, function(arg_159_0, arg_159_1)
			return arg_159_0.weight > arg_159_1.weight
		end)
		table.sort(self.curData, function(arg_160_0, arg_160_1)
			for iter_160_0 = 1, #var_141_11 do
				local var_160_0 = var_141_11[iter_160_0].func(arg_160_0, arg_160_1)

				if var_160_0 ~= "==" then
					return var_160_0
				end
			end
		end)

		if self.isHpInherit then
			(function(arg_161_0)
				local var_161_0 = {}

				for iter_161_0 = #arg_161_0, 1, -1 do
					if arg_161_0[iter_161_0].hpInherit and arg_161_0[iter_161_0].hpInherit <= 0 then
						table.insert(var_161_0, table.remove(arg_161_0, iter_161_0))
					end
				end

				local var_161_1 = #arg_161_0 + 1

				for iter_161_1, iter_161_2 in ipairs(arg_161_0) do
					if (playermodel.haveServant[iter_161_2.soulid] and 1 or 0) == 0 then
						var_161_1 = iter_161_1

						break
					end
				end

				for iter_161_3 = #var_161_0, 1, -1 do
					table.insert(arg_161_0, var_161_1, table.remove(var_161_0, iter_161_3))

					var_161_1 = var_161_1 + 1
				end
			end)(self.curData)
		end
	end)(self.curSort, self.orderType)

	function insertNpcDataToCurData()
		local var_162_0 = #self.curData + 1

		for iter_162_0, iter_162_1 in pairs(self.curData) do
			if not playermodel.haveSuit[iter_162_1.soulid] then
				var_162_0 = iter_162_0

				break
			end
		end

		local var_162_1 = #self.allNpcData

		while var_162_1 > 0 do
			table.insert(self.curData, var_162_0, self.allNpcData[var_162_1])

			var_162_1 = var_162_1 - 1
		end
	end

	hx_print("筛选后的数据长度5")
	print(#self.curData)

	if self.selectType == SELECT_GIRL_HOME then
		for iter_132_2, iter_132_3 in pairs(self.filterType[1]) do
			if iter_132_3 == 2 then
				insertNpcDataToCurData()

				break
			end
		end

		if not next(self.filterType[1]) then
			insertNpcDataToCurData()
		end
	end

	if self.selectType ~= SELECT_GIRL_DATABASE then
		for iter_132_4, iter_132_5 in pairs(self.curData) do
			if iter_132_5.soulid == self.initconfig.cursoul then
				table.remove(self.curData, iter_132_4)
				table.insert(self.curData, 1, iter_132_5)
			end
		end
	end

	if self.insertTop and next(self.insertTop) then
		for iter_132_6, iter_132_7 in pairs(self.curData) do
			for iter_132_8, iter_132_9 in pairs(self.insertTop) do
				if iter_132_7.soulid == iter_132_9 and self:isShowTrainRedPoint(iter_132_9) then
					table.remove(self.curData, iter_132_6)
					table.insert(self.curData, 1, iter_132_7)
				end
			end
		end
	end

	for iter_132_10, iter_132_11 in pairs(self.curData) do
		if iter_132_11.soulid == soulid then
			table.remove(self.curData, iter_132_10)
		end
	end

	if self.adverturemode and levelmode_data[self.adverturemode] and levelmode_data[self.adverturemode].ele_type then
		local var_132_8 = levelmode_data[self.adverturemode].ele_type

		if levelmode_data[self.adverturemode].ele_type_show then
			var_132_8 = levelmode_data[self.adverturemode].ele_type_show .. ",imaginary"
		end

		local var_132_9 = {}

		if var_132_8 then
			for iter_132_12 in var_132_8:gmatch("([^,]+)") do
				table.insert(var_132_9, iter_132_12)
			end
		end

		local var_132_10 = {
			wind = true,
			water = true,
			fire = true,
			light = true,
			dark = true
		}

		local function var_132_11(arg_163_0, arg_163_1)
			if not arg_163_1 or not arg_163_0 then
				return
			end

			local var_163_0 = (self.selectType == SELECT_GIRL_FIGHT or self.selectType == SELECT_GIRL_FIGHT_MODE or self.selectType == SELECT_GIRL_DATABASE or self.selectType == SELECT_GIRL_EXPLORE or self.selectType == SELECT_GIRL_QUICKFIGHT or self.selectType == SELECT_GIRL_TRAIN or self.selectType == SELECT_GIRL_ARENA_DEFENCE or self.selectType == SELECT_GIRL_SPECIAL or self.selectType == SELECT_GIRL_ARENA_ATTACK or self.selectType == SELECT_GIRL_TVT_DEFENCE or self.selectType == SELECT_GIRL_TVT_ATTACK or self.selectType == SELECT_GIRL_SUBSTITUTION or self.selectType == SELECT_GIRL_EXPLORE_HP_INHERIT or self.selectType == SELECT_GIRL_FIGHT_POINT or self.selectType == SELECT_GIRL_FIGHT_MATERIAL or self.selectType == SELECT_GIRL_FIGHT_ELEMENTS) and servant_data[arg_163_1].modelid or major_factor_data[arg_163_1].model

			if not var_163_0 then
				return
			end

			local var_163_1 = false
			local var_163_2 = false

			for iter_163_0, iter_163_1 in ipairs(arg_163_0) do
				if model_data[var_163_0][iter_163_1] then
					var_163_1 = true

					break
				end

				if var_132_10[iter_163_1] then
					var_163_2 = true
				end
			end

			if not var_163_1 and var_163_2 and model_data[var_163_0].imaginary then
				var_163_1 = true
			end

			return var_163_1
		end

		local var_132_12 = {}

		if next(var_132_9) then
			for iter_132_13, iter_132_14 in ipairs(self.curData) do
				if var_132_11(var_132_9, iter_132_14.soulid) then
					table.insert(var_132_12, iter_132_14)
				end
			end

			self.curData = var_132_12
		end
	end

	if self.selectType == SELECT_GIRL_AFK_LEVEL then
		local var_132_13 = {}
		local var_132_14 = role_false_level_manager:getAfkLevelLockServants()

		for iter_132_15, iter_132_16 in ipairs(self.curData) do
			if not var_132_14[iter_132_16.soulid] then
				table.insert(var_132_13, iter_132_16)
			end
		end

		self.curData = var_132_13
	end

	local var_132_15 = {}
	local role_switch_data = require("data.role_switch_data")

	for iter_132_17, iter_132_18 in ipairs(self.curData) do
		local var_132_17 = major_factor_data[iter_132_18.soulid] and major_factor_data[iter_132_18.soulid].servant

		if var_132_17 and role_switch_data[var_132_17] and role_switch_data[var_132_17].starttime and time_check_manager:getCurTime() < os.time(parse_time(role_switch_data[var_132_17].starttime)) then
			-- block empty
		else
			table.insert(var_132_15, iter_132_18)
		end
	end

	self.curData = var_132_15

	self:updateButtomBtnList()

	if self.hold_array_girls then
		local var_132_18 = {}

		for iter_132_19, iter_132_20 in ipairs(self.curData) do
			if not self:hideHavedArrayGirls(iter_132_20.soulid) then
				table.insert(var_132_18, iter_132_20)
			end
		end

		self.curData = var_132_18

		self.tableView:reloadData()
	end
end

function GirlSelectLayer.updateExploreTime(arg_164_0)
	return
end

function GirlSelectLayer:updateShowingCells()
	local var_165_0 = {
		cellsize = cc.size(var_0_55, var_0_56),
		maxcount = math.ceil(#self.curData / 3)
	}

	if var_165_0.maxcount < math.ceil(self:getTableviewHeight() / var_0_56) then
		var_165_0.maxcount = math.ceil(self:getTableviewHeight() / var_0_56)
	end

	local var_165_1, var_165_2 = GetTableViewShowCellIdx(self.tableView, var_165_0)

	for iter_165_0 = var_165_1, var_165_2 do
		self.tableView:updateCellAtIndex(iter_165_0)
	end
end

function GirlSelectLayer:initDisplay(arg_166_1)
	self.displayPos = global_get_node_display_posy(arg_166_1, {
		TableView = {
			focusName = "TableView",
			reference = TRANSFORM_REFERENCE.DOWN,
			posY = self:getTableviewPosY(),
			unit = TRANSFORM_UNIT.PX
		},
		title = {
			posY = 56,
			focusName = "title",
			reference = TRANSFORM_REFERENCE.UP,
			unit = TRANSFORM_UNIT.PX
		}
	})

	for iter_166_0, iter_166_1 in pairs(self.displayPos) do
		local var_166_0 = ccui.Helper:seekWidgetByName(arg_166_1, iter_166_0) or arg_166_1:getChildByName(iter_166_0)

		if var_166_0 then
			var_166_0:setPositionY(iter_166_1)
		end
	end
end

function GirlSelectLayer:exit1()
	var_0_39 = nil

	self:layerOutAni(function()
		if self.exithandler then
			self.exithandler()
		end

		if not level_manager:isPlayerPassLevel(UNLOCK_OTHER) then
			LayerManager:removePopLayer()

			return
		end

		if KeyCodeManager:isFightNeedLock() then
			LayerManager:removePopLayer()
		else
			KeyCodeManager:onKeyReleasedCallFunc()
		end
	end)
end

function GirlSelectLayer:hideHavedArrayGirls(arg_169_1)
	local var_169_2

	if self.selectType == SELECT_GIRL_FIGHT or self.selectType == SELECT_GIRL_FIGHT_MODE or self.selectType == SELECT_GIRL_DATABASE or self.selectType == SELECT_GIRL_EXPLORE or self.selectType == SELECT_GIRL_QUICKFIGHT or self.selectType == SELECT_GIRL_TRAIN or self.selectType == SELECT_GIRL_ARENA_DEFENCE or self.selectType == SELECT_GIRL_SPECIAL or self.selectType == SELECT_GIRL_ARENA_ATTACK or self.selectType == SELECT_GIRL_FIGHT_POINT or self.selectType == SELECT_GIRL_FIGHT_MATERIAL or self.selectType == SELECT_GIRL_FIGHT_ELEMENTS then
		local var_169_1 = array_manager:getArrayByServantID(arg_169_1)

		var_169_2 = self.selectType == SELECT_GIRL_SPECIAL and self.initconfig.cursoul == arg_169_1 or self.selectType == SELECT_GIRL_ARENA_DEFENCE and self.initconfig.cursoul == arg_169_1 or self.selectType == SELECT_GIRL_ARENA_ATTACK and self.initconfig.cursoul == arg_169_1 or not not ((self.selectType == SELECT_GIRL_EXPLORE_HP_INHERIT or nil) and array_manager:getArrayByServantIDHpInherit(arg_169_1) and self.selectType ~= SELECT_GIRL_TRAIN)
	else
		var_169_2 = false
	end

	return var_169_2
end

function GirlSelectLayer:jumpSpecialBtn(arg_170_1)
	if not arg_170_1 or not arg_170_1.jump_index then
		return
	end

	if not self.filterList then
		return
	end

	if self.selectType == SELECT_GIRL_HOME or self.selectType == SELECT_GIRL_DORMITORY then
		return
	end

	local var_170_0 = arg_170_1.jump_index

	if arg_170_1.jump_index <= 1 then
		return
	end

	if self.filterList.rootLayer then
		local var_170_1 = self.filterList.rootLayer:getChildByName("listView")

		if var_170_1 then
			local var_170_2 = var_170_1:getChildByName("filter_list_bnt" .. var_170_0)

			if var_170_2 then
				self.filterList:btnTouchEvent(var_170_2)
			end
		end
	end
end

function GirlSelectLayer:getFightTagDes(arg_171_1)
	local var_171_0 = self.selectType == SELECT_GIRL_TVT_DEFENCE and arenatft_manager:getDefArrayByServantID(arg_171_1) or self.selectType == SELECT_GIRL_TVT_ATTACK and arenatft_manager:getAtkArrayByServantID(arg_171_1) or self.selectType == SELECT_GIRL_SUBSTITUTION and substitution_manager:getArrayByServantID(arg_171_1) or self.selectType == SELECT_GIRL_EXPLORE_HP_INHERIT and array_manager:getArrayByServantIDHpInherit(arg_171_1) or array_manager:getArrayByServantID(arg_171_1)

	if self.selectType == SELECT_GIRL_SPECIAL then
		if self.initconfig.cursoul == arg_171_1 then
			return L_GIRL_SELECT_CELL.Update[2]
		end
	elseif self.selectType == SELECT_GIRL_ARENA_DEFENCE then
		if array_manager:getArenaDefenceByServantid(arg_171_1) then
			return L_GIRL_SELECT_CELL.arenaDefence
		end
	elseif self.selectType == SELECT_GIRL_ARENA_ATTACK then
		if array_manager:getArenaAttackByServantid(arg_171_1) then
			return L_GIRL_SELECT_CELL.arenaAttack
		end
	elseif var_171_0 and (self.selectType == SELECT_GIRL_TVT_DEFENCE or self.selectType == SELECT_GIRL_TVT_ATTACK) then
		return L_GIRL_SELECT_CELL.Update[2] .. "中"
	elseif var_171_0 and self.selectType ~= SELECT_GIRL_TRAIN then
		return L_GIRL_SELECT_CELL.Update[2] .. "中"
	elseif var_171_0 and self.selectType == SELECT_GIRL_SUBSTITUTION then
		return L_GIRL_SELECT_CELL.Update[2] .. "中"
	elseif self.selectType == SELECT_GIRL_EXPEDITION then
		return L_GIRL_SELECT_CELL.Update[2] .. "中"
	elseif self.selectType == SELECT_GIRL_FIGHT_POINT then
		return L_GIRL_SELECT_CELL.Update[2] .. "中"
	elseif self.selectType == SELECT_GIRL_TEST_FIGHT_EMPTY or self.selectType == SELECT_GIRL_TEST_FIGHT_PLAYER then
		return L_GIRL_SELECT_CELL.Update[2] .. "中"
	end
end

function GirlSelectLayer:switchToShowGirlSwitchLayer(...)
	self:setVisible(false)
	LayerManager:pushInLayer("ShowGirlSwitchLayer", {
		selectRole = self.selectGirl,
		selectModelid = self.selectModel,
		changeShowGirlCallBack = function()
			LayerManager:removePopLayer()

			if self.sureCallBack then
				self.sureCallBack()
			end
		end,
		returnCallback = function(arg_174_0)
			if arg_174_0 and self.resetMainLayerLive2dCallback then
				self.resetMainLayerLive2dCallback()
			end

			self:setVisible(true)
		end
	})
end

function GirlSelectLayer:scrollToIndex(...)
	if not var_0_40 then
		self.selectTblAni = true

		self.tableView:scrollToIndex(math.floor(self.curIndex / 4), false)
	end
end

function GirlSelectLayer:findIndexByServantID(arg_176_1)
	local var_176_0

	for iter_176_0, iter_176_1 in ipairs(self.curData) do
		if iter_176_1.soulid == arg_176_1 then
			var_176_0 = iter_176_0

			break
		end
	end

	if not var_176_0 then
		return nil
	end

	if self.sortOrder == 0 then
		return math.floor(var_176_0 / 4), var_176_0
	else
		return #self.curData - math.ceil(var_176_0 / 4) + 1, var_176_0
	end
end

function GirlSelectLayer:scrollToServant(arg_177_1)
	local var_177_0 = self:findIndexByServantID(arg_177_1)

	if not var_177_0 then
		return
	end

	self.tableView:scrollToIndex(var_177_0, false)
end

function GirlSelectLayer:selectServantSPOnGuide(arg_178_1)
	local var_178_0, var_178_1 = self:findIndexByServantID(arg_178_1)

	if not var_178_0 then
		return nil
	end

	self:scrollToServant(arg_178_1)

	return (function(arg_179_0, arg_179_1)
		local function var_179_0(arg_180_0)
			if type(arg_180_0) == "table" then
				for iter_180_0, iter_180_1 in pairs(arg_180_0) do
					local var_180_0 = var_179_0(iter_180_1)

					if var_180_0 then
						return var_180_0
					end
				end

				return nil
			elseif arg_180_0:getTag() == arg_179_1 then
				return arg_180_0
			else
				return var_179_0(arg_180_0:getChildren())
			end
		end

		return var_179_0(arg_179_0)
	end)(self.tableView, self.sortOrder == 0 and var_178_1 or #self.curData - var_178_1 + 1)
end

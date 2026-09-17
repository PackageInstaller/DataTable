TowerDefenceLevelLayer = class("TowerDefenceLevelLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local audio_manager = require("controller.audio_manager")
local array_manager = require("controller.array_manager")
local time_check_manager = require("controller.time_check_manager")
local patrol_manager = require("controller.patrol_manager")
local barrage_manager = require("controller.barrage_manager")
local item_data = require("data.item_data")
local levelmode_data = require("data.levelmode_data")
local chapter_data = require("data.chapter_data")
local servant_data = require("data.servant_data")
local CityList = require("view.Sprite.CityList")
local var_0_15 = "TowerDefenceLevelLayer"
local var_0_23 = {
	{
		start2Value = 66,
		start1Value = 446
	},
	{
		start2Value = 66,
		start1Value = 446
	},
	{
		start2Value = 0,
		start1Value = 516
	}
}
local var_0_24 = {
	{
		off = "TowerDefenceLevelLayer/small_level_gray.png",
		on = "TowerDefenceLevelLayer/level_bg.png"
	},
	{
		off = "TowerDefenceLevelLayer/small_level_gray.png",
		on = "TowerDefenceLevelLayer/level_bg.png"
	},
	{
		off = "TowerDefenceLevelLayer/big_level_bg_off.png",
		on = "TowerDefenceLevelLayer/big_level_bg.png"
	}
}
local var_0_25 = "LevelEnterMode"
local var_0_26 = "initcitytype"
local var_0_27 = "initcity"
local var_0_28 = "initdifficulty"
local var_0_29

function TowerDefenceLevelLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = TowerDefenceLevelLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function TowerDefenceLevelLayer:getExitParam()
	return {
		initcitytype = cloneconf(self.initcitytype),
		initcity = cloneconf(self.curcity),
		initdifficulty = cloneconf(self.curdifficuty)
	}
end

function TowerDefenceLevelLayer:initLevelListView()
	local var_4_0 = level_manager:getCurLevelInfo(self.curcity)

	if var_4_0 == nil then
		return
	end

	local var_4_1 = level_manager:isLevelModeAutoUnlocked(self.curcity)
	local var_4_2 = #var_4_0

	if self.levelViewNode ~= nil then
		self.levelViewNode:removeFromParent()
	end

	self.levelViewNode = self:getTableView(var_4_0, #var_4_0, cc.size(420, 225), cc.size(640, GameDisplay.height - 250), function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_5_1 + 1
		local var_5_1 = (arg_5_1 + 1) % 3

		if (arg_5_1 + 1) % 3 == 0 then
			var_5_1 = 3
		end

		local var_5_2 = arg_5_2[arg_5_1 + 1]
		local var_5_3 = arg_5_0:dequeueCell()

		if var_5_3 == nil then
			var_5_3 = cc.TableViewCell:new()
		end

		local var_5_5 = var_5_3:getChildByName("item")

		if var_5_5 then
			var_5_5:removeFromParent()
		end

		local var_5_7 = self.itemNodeList[var_5_1]:clone()

		var_5_3:addChild(var_5_7)
		var_5_7:setName("item")

		if arg_5_1 + 1 ~= 1 then
			var_5_7:setPosition(cc.p(0, 0))
		else
			var_5_7:setPosition(cc.p(0, 50))
		end

		var_5_7:setVisible(true)

		var_5_7.index = arg_5_1 + 1

		var_5_7:setTouchEnabled(false)

		local var_5_8 = var_5_7:getChildByName("bg")
		local var_5_9 = var_5_7:getChildByName("line")
		local var_5_10 = var_5_7:getChildByName("num")
		local var_5_11 = var_5_7:getChildByName("icon")
		local var_5_12 = var_5_7:getChildByName("name")
		local var_5_13 = var_5_7:getChildByName("btn")
		local var_5_14 = var_5_7:getChildByName("select")

		if var_5_2.curStatus == 1 then
			var_5_14:setVisible(true)

			local var_5_15 = var_5_14:getChildByName("select1")
			local var_5_16 = var_5_14:getChildByName("select2")

			var_5_15:stopAllActions()
			var_5_16:stopAllActions()
			var_5_15:runAction((cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
				var_5_15:setPositionX(var_0_23[var_5_1].start1Value)
				var_5_15:setOpacity(255)
			end), cc.MoveBy:create(0.5, cc.p(-20, 0)), cc.FadeOut:create(0.3)))))
			var_5_16:runAction((cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
				var_5_16:setPositionX(var_0_23[var_5_1].start2Value)
				var_5_16:setOpacity(255)
			end), cc.MoveBy:create(0.5, cc.p(20, 0)), cc.FadeOut:create(0.3)))))
		else
			var_5_14:setVisible(false)
		end

		if level_manager:isChapterModeUnlocked(self.curcity, arg_5_1 + 1) and var_4_1 == true then
			var_5_8:loadTexture(var_5_2.bgPath or var_0_24[var_5_1].on, var_0_0)
		else
			var_5_8:loadTexture(var_5_2.bgPathGray or var_0_24[var_5_1].off, var_0_0)
		end

		var_5_10:setString(var_5_2.name)
		var_5_11:loadTexture("public/career_icon/dark.png", var_0_0)
		var_5_11:setScale(0.5)
		var_5_11:setVisible(false)
		var_5_12:setString(var_5_2.des)

		if var_5_1 ~= 3 then
			var_5_11:setPositionY(38)
			var_5_12:setPositionY(38)

			if var_5_1 == 1 then
				var_5_11:setPositionX(225)
			elseif var_5_1 == 2 then
				var_5_11:setPositionX(380)
			end
		end

		var_5_9:setVisible(arg_5_1 + 1 ~= var_4_2)
		var_5_13:setSwallowTouches(false)
		var_5_13:addTouchEventListener(function(arg_8_0, arg_8_1)
			if arg_8_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self._playingani then
				return
			end

			if math.abs(arg_8_0:getTouchBeganPosition().y - arg_8_0:getTouchEndPosition().y) > 50 then
				return
			end

			local var_8_0 = self.curcity
			local var_8_1 = var_5_0
			local tower_defence_manager = require("controller.tower_defence_manager")

			print("大战场", "mode: " .. self.curcity, "chapter: " .. var_5_0)
			print("大战场", "mode: " .. var_8_0, "chapter: " .. var_5_0)
			print("大战场", "mode: " .. var_8_0, "chapter: " .. var_5_0)

			local var_8_3 = self.initcitytype
			local var_8_5 = self.curcity

			LayerManager:pushInLayer("TowerDefenceDetailLayer", {
				mode = var_8_0,
				chapter = var_5_0,
				surecallback = function()
					LayerManager:switchShowLayer("TowerDefenceSelectLayer", {
						mode = var_8_0,
						chapter = var_8_1,
						sureCallback = function(arg_10_0)
							tower_defence_manager:switchToTowerDefence(var_8_0, var_8_1, arg_10_0, function(arg_11_0)
								if arg_11_0.result == 1 then
									RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", var_8_3)
									RoleDefault:getInstance():setIntegerForKey("SpecialAdventureEnterMode", var_8_5)
									FightManager.refreshFightToType(FIGHTTYPE_TOWER)
									LayerManager:switchShowLayer("FightLayer", {
										is_hide_topcost = true,
										is_hide_listbutton = true
									})
								end
							end)
						end
					})
				end
			})
		end)

		return var_5_3
	end, function(arg_12_0, arg_12_1)
		print("click ")
	end)

	self.levelViewNode:setPosition(cc.p(0, 180))
	self.uilayer:addChild(self.levelViewNode)
	self:scrollTableView()

	self.levelViewNode.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.levelViewNode:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.levelViewNode:setPositionY(self.levelViewNode.full_posY)
end

function TowerDefenceLevelLayer.getTableView(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6)
	local var_13_2 = cc.TableView:create(arg_13_4)

	var_13_2:setVisible(true)
	var_13_2:setVerticalFillOrder(cc.TABLEVIEW_FILL_BOTTOMUP)
	var_13_2:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_13_2:setDelegate()
	var_13_2:registerScriptHandler(function(arg_14_0)
		return arg_13_2
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_13_2:registerScriptHandler(function(arg_15_0)
		arg_13_0:scrollViewDidScroll(arg_15_0)
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	var_13_2:registerScriptHandler(function(arg_16_0, arg_16_1)
		arg_13_6(arg_16_0, arg_16_1)
	end, cc.TABLECELL_TOUCHED)
	var_13_2:registerScriptHandler(function(arg_17_0, arg_17_1)
		if arg_17_1 + 1 ~= 1 then
			if (arg_17_1 + 1) % 3 == 0 then
				return 640, 250
			elseif (arg_17_1 + 1) % 3 == 1 then
				return 640, 190
			elseif (arg_17_1 + 1) % 3 == 2 then
				return 640, 225
			end
		else
			return 640, 240
		end
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_13_2:registerScriptHandler(function(arg_18_0, arg_18_1)
		return arg_13_5(arg_18_0, arg_18_1, arg_13_1)
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_13_2:reloadData()
	var_13_2:setAnchorPoint(cc.p(0, 0))

	return var_13_2
end

function TowerDefenceLevelLayer.scrollViewDidScroll(arg_19_0, arg_19_1)
	return
end

function TowerDefenceLevelLayer:init(arg_20_1)
	self._playingani = false

	if arg_20_1 and arg_20_1.initcity ~= nil then
		self.initcitytype = arg_20_1.activityid
		self.initcity = arg_20_1.initcity
		self.initdifficulty = 1
	else
		self.initcitytype = arg_20_1.activityid

		local var_20_0 = RoleDefault:getInstance():getIntegerForKey(var_0_25 .. self.initcitytype, -1)

		if var_20_0 == -1 then
			self.initcity = level_manager:getMaxCity(self.initcitytype)
			self.initdifficulty = 1
		else
			self.initcity = level_manager:getCityByMode(var_20_0)
			self.initdifficulty = 1
		end
	end

	self.initcitytype = self.initcitytype or var_0_29
	var_0_29 = self.initcitytype
	self.resourcePath = var_0_15 .. "/"
	self.initCityTypeSavePath = var_0_26 .. self.initcitytype
	self.initCitySavePath = var_0_27 .. self.initcitytype
	self.initDifficultySavePath = var_0_28 .. self.initcitytype
	self.curdifficuty = self.initdifficulty

	level_manager:updateAdventureDetailInfo(self.initCityTypeSavePath, self.initcitytype)
	level_manager:updateAdventureDetailInfo(self.initCitySavePath, self.initcity)
	level_manager:updateAdventureDetailInfo(self.initDifficultySavePath, self.initdifficulty)
	self:initInfo()
	self:initUINode()
	level_manager:getModesLockState(function()
		self:initChapterListView()
		self:playInitShowAni()
	end)
	self:fullScreen()
	self:registerScriptHandler(function(arg_22_0)
		if arg_22_0 == "exit" then
			self._playingani = false
		end
	end)
end

function TowerDefenceLevelLayer.initInfo(arg_23_0)
	arg_23_0.itemNodeList = {}
end

function TowerDefenceLevelLayer:initUINode()
	self.uilayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "TowerDefenceLevelLayer.json" or "TowerDefenceLevelLayer.ExportJson")

	self.uilayer:setVisible(false)
	self:addChild(self.uilayer)

	for iter_24_0 = 1, 3 do
		local var_24_0 = self.uilayer:getChildByName("item" .. iter_24_0)

		var_24_0:setVisible(false)

		self.itemNodeList[iter_24_0] = var_24_0
	end

	self.bgNode = self.uilayer:getChildByName("bg")

	self.bgNode:loadTexture("TowerDefenceLevelLayer/bg.png", var_0_0)

	self.cityTitle = self.uilayer:getChildByName("title")
	self.btn_tips = self.cityTitle:getChildByName("btn_title")
	self.chapterItemNode = self.uilayer:getChildByName("chapter_item")
	self.downLineNode = self.uilayer:getChildByName("down_line")
	self.btnReturn = self.uilayer:getChildByName("btn_return")

	self.btnReturn:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._playingani then
			return
		end

		self:playExitAni()
	end)
	self.btn_tips:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "tower_defence_level_layer"
		})
	end)
	self.cityTitle:setLocalZOrder(1)
	self.downLineNode:setLocalZOrder(2)
	self.btnReturn:setLocalZOrder(2)
	self.btn_tips:setLocalZOrder(2)

	self.maplayer = ccui.Layout:create()

	self.maplayer:setVisible(false)
	self.maplayer:setContentSize(cc.Director:getInstance():getVisibleSize())
	self.maplayer:setAnchorPoint(cc.p(0, 0))
	self.maplayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.maplayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.maplayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.uilayer:addChild(self.maplayer)

	self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), GameDisplay.width, GameDisplay.height)

	self.anicover:setPosition(0, -GameDisplay.fix_y)
	self:addChild(self.anicover, 2)

	self.mapLockWord = ccui.Layout:create()

	self.mapLockWord:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))
	self.mapLockWord:setAnchorPoint(cc.p(0.5, 0.5))
	self.mapLockWord:setPosition(320, (GameDisplay.height + GameDisplay.fix_y) / 2)
	self.mapLockWord:setTouchEnabled(true)
	self.mapLockWord:setVisible(false)
	self.uilayer:addChild(self.mapLockWord, 1)

	local var_24_1 = ccui.ImageView:create("LevelMap/cover_locked.png", var_0_0)

	var_24_1:setScale9Enabled(true)
	var_24_1:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_24_1:setPosition(cc.p(320, GameDisplay.height / 2))
	self.mapLockWord:addChild(var_24_1)

	local var_24_2 = ccui.ImageView:create("LevelMap/wordbg.png", var_0_0)

	var_24_2:setName("mapLockWordBg")
	var_24_2:setPosition(cc.p(320, GameDisplay.height / 2))
	self.mapLockWord:addChild(var_24_2)

	local var_24_3 = ccui.ImageView:create("LevelMap/ui_lock.png", var_0_0)

	var_24_3:setAnchorPoint(cc.p(1, 0.5))
	var_24_3:setPosition(cc.p(640, GameDisplay.height / 2))
	var_24_3:setName("lockui1")
	self.mapLockWord:addChild(var_24_3)

	local var_24_4 = ccui.ImageView:create("LevelMap/ui_lock.png", var_0_0)

	var_24_4:setAnchorPoint(cc.p(0, 0.5))
	var_24_4:setPosition(cc.p(0, GameDisplay.height / 2))
	var_24_4:setFlippedY(true)
	var_24_4:setFlippedX(true)
	var_24_4:setName("lockui2")
	self.mapLockWord:addChild(var_24_4)

	local var_24_5 = cc.Label:createWithTTF(L_COMMON_WARNING.Locking, "fonts/name.ttf", 50)

	var_24_5:setAnchorPoint(cc.p(0.5, 0.5))
	var_24_5:setPosition(cc.p(320, GameDisplay.height / 2))
	var_24_5:setName("word")
	self.mapLockWord:addChild(var_24_5)
end

function TowerDefenceLevelLayer:fullScreen()
	self.uilayer:setPosition(cc.p(0, -GameDisplay.fix_y))

	self.cityTitle.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self.cityTitle:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.cityTitle:setPositionY(self.cityTitle.full_posY)

	self.btnReturn.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.btnReturn:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.btnReturn:setPositionY(self.btnReturn.full_posY)

	self.downLineNode.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.downLineNode:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.downLineNode:setPositionY(self.downLineNode.full_posY)
	self.bgNode:setPositionY(GameDisplay.height / 2)
end

function TowerDefenceLevelLayer:initChapterListView()
	self.cityList = CityList:create()
	self.cityListMask = CityList:create()

	self.cityListMask:setPosition(cc.p(GameDisplay.width / 2, 145))
	self.cityListMask:setTouchEnabled(true)
	self.uilayer:addChild(self.cityListMask, 1)
	self.cityList:openSlideMode(true)
	self.cityList:setCityInitPosY(-135)
	self.cityList:setPosition(cc.p(GameDisplay.width / 2, 145))
	self.cityList:updateCitiesProperties()
	self.cityList:setContentSize(cc.size(640, 180))

	local var_28_0 = ccui.ImageView:create("TowerDefenceLevelLayer/arrow.png", var_0_0)
	local var_28_1 = ccui.ImageView:create("TowerDefenceLevelLayer/arrow.png", var_0_0)

	var_28_0:setPosition(cc.p(150, 0))
	var_28_1:setPosition(cc.p(-150, 0))
	var_28_0:setScaleX(1)
	var_28_1:setScaleX(-1)
	self.cityList:addChild(var_28_0)
	self.cityList:addChild(var_28_1)
	self.uilayer:addChild(self.cityList, 2)

	self.index_to_city = {}
	self.city_to_index = {}
	self.cities = {}

	local var_28_2 = level_manager:getCityListById(self.initcitytype)

	local function var_28_3(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_29_0:getTouchBeganPosition().x - arg_29_0:getTouchEndPosition().x) >= 25 then
			return
		end

		if self._playingani then
			return
		end

		self.cityList:scrollToIndexManual(arg_29_0:getTag())
	end

	local function var_28_4(arg_30_0, arg_30_1)
		local var_30_0 = ccui.Button:create(self.resourcePath .. "chapter_bg" .. arg_30_0 .. ".png", nil, self.resourcePath .. "chapter_bg" .. arg_30_0 .. ".png", var_0_0)

		var_30_0:setName("city" .. arg_30_1)

		var_30_0.areaid = arg_30_1 % self.initcitytype

		var_30_0:addTouchEventListener(var_28_3)
		var_30_0:setAnchorPoint(cc.p(0.5, 0))

		local var_30_1 = ccui.ImageView:create(self.resourcePath .. "chapter_name" .. arg_30_0 .. ".png", var_0_0)

		var_30_1:setPosition(cc.p(250, 55))
		var_30_1:setAnchorPoint(cc.p(1, 1))
		var_30_1:setName("name_bg")

		local var_30_2 = ccui.Text:create(levelmode_data[arg_30_1].name, FONT_NAME, 22)

		var_30_2:setName("name")
		var_30_2:setPosition(cc.p(var_30_1:getContentSize().width / 2, var_30_1:getContentSize().height / 2))
		var_30_1:addChild(var_30_2)
		var_30_0:addChild(var_30_1)

		return var_30_0
	end

	for iter_28_0, iter_28_1 in ipairs(var_28_2) do
		local var_28_5 = var_28_4(iter_28_0, iter_28_1)

		var_28_5:setTag(iter_28_0)
		self.cityList:pushInCity(var_28_5)

		self.cities[iter_28_1] = var_28_5
		self.index_to_city[var_28_5:getTag()] = iter_28_1
		self.city_to_index[iter_28_1] = var_28_5:getTag()
	end

	if #var_28_2 <= 1 then
		self.cityList:setVisible(false)
	else
		self.cityList:setVisible(true)
	end

	self.cityList:registerSelectCityHandler(function(arg_31_0)
		if self.curcity == self.index_to_city[arg_31_0] then
			return
		end

		self.curcity = self.index_to_city[arg_31_0]

		level_manager:updateAdventureDetailInfo(self.initCitySavePath, self.curcity)

		for iter_31_0, iter_31_1 in pairs(self.cities) do
			if iter_31_0 ~= self.curcity then
				iter_31_1:getChildByName("name_bg"):setVisible(false)
			else
				iter_31_1:getChildByName("name_bg"):setVisible(true)
			end
		end

		self:initLevelListView()
		self:initMapLockWord()
	end)
	self.cityList:jumpToIndex(self.city_to_index[self.initcity])

	self.cityList.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.cityList:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.cityList:setPositionY(self.cityList.full_posY)

	self.cityListMask.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.cityListMask:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.cityListMask:setPositionY(self.cityListMask.full_posY)
end

function TowerDefenceLevelLayer:scrollTableView()
	self.levelViewNode:scrollToPercent(math.max(0, (math.min(level_manager:getCurChapter(self.curcity) <= 4 and 0 or (level_manager:getCurChapter(self.curcity) - 4) / level_manager:getModeTotalChapter(self.curcity) * 100, 100))), nil, false)
end

function TowerDefenceLevelLayer:playInitShowAni()
	self.maplayer:setVisible(true)
	self.uilayer:setVisible(true)
end

function TowerDefenceLevelLayer:playExitAni()
	self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), GameDisplay.width, GameDisplay.height)

	self.anicover:setPosition(0, -GameDisplay.fix_y)
	self:addChild(self.anicover, 10)

	self._playingani = true

	self.anicover:runAction(cc.Sequence:create(cc.FadeIn:create(0.4), cc.DelayTime:create(0.5), cc.RemoveSelf:create()))
	self.maplayer:runAction(cc.MoveBy:create(0.4, cc.p(0, 8)))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)))
end

function TowerDefenceLevelLayer:initMapLockWord()
	if level_manager:isLevelModeAutoUnlocked(self.curcity) then
		self.mapLockWord:setVisible(false)
	else
		self.mapLockWord:setVisible(true)
	end
end

function TowerDefenceLevelLayer:playUnlockAni(arg_37_1)
	self._playingani = true

	audio_manager:playeffectMusic(DORM_UNLOCK_ROOM)
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("mapeffect/jiesuotexiao.ExportJson")
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("mapeffect/dianwei.ExportJson")
	self.mapLockWord:getChildByName("word"):setVisible(false)
	self.mapLockWord:getChildByName("lockui1"):setVisible(false)
	self.mapLockWord:getChildByName("lockui2"):setVisible(false)
	self.mapLockWord:getChildByName("mapLockWordBg"):setVisible(false)

	local var_37_0 = ccs.Armature:create("jiesuotexiao")

	var_37_0:setPosition(cc.p(320, 568))
	self:addChild(var_37_0, 10)
	var_37_0:getAnimation():play("Animation1")
	var_37_0:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
		return
	end)))
	var_37_0:runAction(cc.Sequence:create(cc.DelayTime:create(2.6666666666666665), cc.CallFunc:create(function()
		self.mapLockWord:setVisible(false)
		self.mapLockWord:getChildByName("word"):setVisible(true)
		self.mapLockWord:getChildByName("lockui1"):setVisible(true)
		self.mapLockWord:getChildByName("lockui2"):setVisible(true)
		self.mapLockWord:getChildByName("mapLockWordBg"):setVisible(true)
	end), cc.RemoveSelf:create()))

	local var_37_1 = ccs.Armature:create("dianwei")

	var_37_1:setPosition(cc.p(320, 568 + GameDisplay.fix_y))
	var_37_1:setVisible(false)
	self:addChild(var_37_1, 10)
	var_37_1:runAction(cc.Sequence:create(cc.DelayTime:create(2.8333333333333335), cc.Show:create(), cc.CallFunc:create(function()
		var_37_1:getAnimation():play("Animation1")
	end), cc.DelayTime:create(1), cc.CallFunc:create(function()
		if arg_37_1 then
			arg_37_1()
		end
	end), cc.RemoveSelf:create()))
end

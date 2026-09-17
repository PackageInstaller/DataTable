AutoChessBaseLayer = class("AutoChessBaseLayer", function()
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
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")

require("view.Sprite.GirlSprite")
require("view.Sprite.AutoChessChooseSprite")

local CityList = require("view.Sprite.CityList")
local var_0_25 = {
	{
		off = "%s/army%02d_small.png",
		on = "%s/army%02d_small.png"
	},
	{
		off = "%s/army%02d_small.png",
		on = "%s/army%02d_small.png"
	},
	{
		off = "%s/army%02d_small.png",
		on = "%s/army%02d_small.png"
	},
	{
		off = "%s/army%02d_big.png",
		on = "%s/army%02d_big.png"
	}
}
local var_0_30

function AutoChessBaseLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = AutoChessBaseLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function AutoChessBaseLayer:init(arg_3_1)
	self._playingani = false

	if arg_3_1 then
		self.activityId = arg_3_1.activityId or var_0_30
	end

	self.layerName = "AutoChessLayer_" .. self.activityId

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.bg = ccui.ImageView:create("mainScenebg/activity/branch" .. self.activityId .. "/auto_chess_bg.png")

	self.bg:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - GameDisplay.fix_y)
	self:addChild(self.bg, -1)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerActivityEventListener()
	level_manager:getModesLockState(function()
		self:updateChapterListView()
		self:playInitShowAni()
	end)
	activity_manager:get_auto_chess_info(self.activityId)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			self._playingani = false
			var_0_30 = self.activityId

			TextureManager:removeLayerTextures({
				self.layerName
			})
			activity_manager:releaseEventListenerByName(self.layerName)
		end
	end)
end

function AutoChessBaseLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.AUTOCHESS_LIST_UPDATE, function(arg_7_0)
		if arg_7_0.random and next(arg_7_0.random) then
			self.autoChessChooseSprite:update()
		end
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.AUTOCHESS_SELECT_SUCCESS, function(arg_8_0)
		if arg_8_0.random and next(arg_8_0.random) then
			self.autoChessChooseSprite:update()
		end

		if item_manager:getItemNumber((activity_manager:getAutoChessSelectNeedItem(self.activityId))) <= 0 then
			self.autoChessChooseSprite:hide()
		end
	end)
end

function AutoChessBaseLayer:initUI()
	self:initBottomList()
	self:initTitle()
	self:initUINode()
	self:initAutoChessChoose()
	self:fullScreen()
end

function AutoChessBaseLayer:initBottomList()
	self.bottomList = self.rootLayer:getChildByName("down_line")

	self.bottomList:setLocalZOrder(300)
	self.bottomList:getChildByName("btn_restart"):addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.autoChessChooseSprite:show()
	end)
	self.bottomList:getChildByName("btn_fom"):addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_12_0 = activity_manager:getAutoChessServantList(self.activityId)
		local var_12_1

		if not var_12_0 or not next(var_12_0) then
			global_ShowBlockWords(L_AUTO_CHESS.noservant)

			do return end

			var_12_1 = {
				selectType = SELECT_GIRL_AUTO_CHESS
			}
		end

		var_12_1.cursoul = var_12_0[1].id
		var_12_1.arrayinfo = {}
		var_12_1.activityId = self.activityId

		function var_12_1.sureCallBack(arg_13_0)
			return
		end

		LayerManager:pushInLayer("GirlSelectLayer", var_12_1)
	end)
	self.bottomList:getChildByName("btn_shop"):addTouchEventListener(function(arg_14_0, arg_14_1)
		local var_14_0

		if arg_14_1 ~= ccui.TouchEventType.ended then
			do return end

			var_14_0 = {}
		end

		var_14_0.jump_to_system = activity_manager:getAutoChessJumpID(self.activityId)

		goto_complete_system(var_14_0)
	end)
	self.bottomList:getChildByName("btn_return"):addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end

function AutoChessBaseLayer:initTitle()
	self.title = self.rootLayer:getChildByName("title")

	self.title:getChildByName("btn_title"):addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = self.layerName
		})
	end)
end

function AutoChessBaseLayer:initUINode()
	self.itemNodeList = {}

	for iter_18_0 = 1, 4 do
		local var_18_0 = self.rootLayer:getChildByName("item" .. iter_18_0)

		var_18_0:setVisible(false)

		self.itemNodeList[iter_18_0] = var_18_0
	end

	self.chapterItemNode = self.rootLayer:getChildByName("chapter_item")
	self.maplayer = ccui.Layout:create()

	self.maplayer:setVisible(false)
	self.maplayer:setContentSize(cc.Director:getInstance():getVisibleSize())
	self.maplayer:setAnchorPoint(cc.p(0, 0))
	self.maplayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.maplayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.maplayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootLayer:addChild(self.maplayer)

	self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), GameDisplay.width, GameDisplay.height)

	self.anicover:setPosition(0, -GameDisplay.fix_y)
	self:addChild(self.anicover, 2)

	self.mapLockWord = ccui.Layout:create()

	self.mapLockWord:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))
	self.mapLockWord:setAnchorPoint(cc.p(0.5, 0.5))
	self.mapLockWord:setPosition(320, (GameDisplay.height + GameDisplay.fix_y) / 2)
	self.mapLockWord:setTouchEnabled(true)
	self.mapLockWord:setVisible(false)
	self.rootLayer:addChild(self.mapLockWord, 1)

	local var_18_1 = ccui.ImageView:create("LevelMap/cover_locked.png", var_0_0)

	var_18_1:setScale9Enabled(true)
	var_18_1:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_18_1:setPosition(cc.p(320, GameDisplay.height / 2))
	self.mapLockWord:addChild(var_18_1)

	local var_18_2 = ccui.ImageView:create("LevelMap/wordbg.png", var_0_0)

	var_18_2:setName("mapLockWordBg")
	var_18_2:setPosition(cc.p(320, GameDisplay.height / 2))
	self.mapLockWord:addChild(var_18_2)

	local var_18_3 = ccui.ImageView:create("LevelMap/ui_lock.png", var_0_0)

	var_18_3:setAnchorPoint(cc.p(1, 0.5))
	var_18_3:setPosition(cc.p(640, GameDisplay.height / 2))
	var_18_3:setName("lockui1")
	self.mapLockWord:addChild(var_18_3)

	local var_18_4 = ccui.ImageView:create("LevelMap/ui_lock.png", var_0_0)

	var_18_4:setAnchorPoint(cc.p(0, 0.5))
	var_18_4:setPosition(cc.p(0, GameDisplay.height / 2))
	var_18_4:setFlippedY(true)
	var_18_4:setFlippedX(true)
	var_18_4:setName("lockui2")
	self.mapLockWord:addChild(var_18_4)

	local var_18_5 = cc.Label:createWithTTF(L_COMMON_WARNING.Locking, "fonts/name.ttf", 50)

	var_18_5:setAnchorPoint(cc.p(0.5, 0.5))
	var_18_5:setPosition(cc.p(320, GameDisplay.height / 2))
	var_18_5:setName("word")
	self.mapLockWord:addChild(var_18_5)
end

function AutoChessBaseLayer:updateChapterListView()
	self.cityList = CityList:create()
	self.cityListMask = CityList:create()

	self.cityListMask:setPosition(cc.p(GameDisplay.width / 2, 145))
	self.cityListMask:setTouchEnabled(true)
	self.rootLayer:addChild(self.cityListMask, 1)
	self.cityList:openSlideMode(true)
	self.cityList:setCityInitPosY(-135)
	self.cityList:setPosition(cc.p(GameDisplay.width / 2, 145))
	self.cityList:updateCitiesProperties()
	self.cityList:setContentSize(cc.size(640, 180))

	local var_19_0 = ccui.ImageView:create(self.layerName .. "/arrow.png", var_0_0)
	local var_19_1 = ccui.ImageView:create(self.layerName .. "/arrow.png", var_0_0)

	var_19_0:setPosition(cc.p(150, 0))
	var_19_1:setPosition(cc.p(-150, 0))
	var_19_0:setScaleX(1)
	var_19_1:setScaleX(-1)
	self.cityList:addChild(var_19_0)
	self.cityList:addChild(var_19_1)
	self.rootLayer:addChild(self.cityList, 2)

	self.index_to_city = {}
	self.city_to_index = {}
	self.cities = {}

	local var_19_2 = activity_manager:getAutoChessModeType(self.activityId)
	local var_19_3 = level_manager:getCityListById(var_19_2)

	local function var_19_4(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_20_0:getTouchBeganPosition().x - arg_20_0:getTouchEndPosition().x) >= 25 then
			return
		end

		if self._playingani then
			return
		end

		self.cityList:scrollToIndexManual(arg_20_0:getTag())
	end

	local function var_19_5(arg_21_0, arg_21_1)
		local var_21_0 = self.chapterItemNode:clone()

		var_21_0:loadTextures(self.layerName .. "/chapter_bg" .. arg_21_0 .. ".png", nil, self.layerName .. "/chapter_bg" .. arg_21_0 .. ".png", var_0_0)
		var_21_0:setName("city" .. arg_21_1)

		var_21_0.areaid = arg_21_1 % var_19_2

		var_21_0:addTouchEventListener(var_19_4)
		var_21_0:setAnchorPoint(cc.p(0.5, 0))
		var_21_0:setVisible(true)
		var_21_0:getChildByName("chapter_name"):getChildByName("name_lbl"):setString(levelmode_data[arg_21_1].name)

		return var_21_0
	end

	for iter_19_0, iter_19_1 in ipairs(var_19_3) do
		local var_19_6 = var_19_5(iter_19_0, iter_19_1)

		var_19_6:setTag(iter_19_0)
		self.cityList:pushInCity(var_19_6)

		self.cities[iter_19_1] = var_19_6
		self.index_to_city[var_19_6:getTag()] = iter_19_1
		self.city_to_index[iter_19_1] = var_19_6:getTag()
	end

	self.cityList:setVisible(#var_19_3 > 1)
	self.cityList:registerSelectCityHandler(function(arg_22_0)
		if self.curcity == self.index_to_city[arg_22_0] then
			return
		end

		self.curcity = self.index_to_city[arg_22_0]

		for iter_22_0, iter_22_1 in pairs(self.cities) do
			if iter_22_0 ~= self.curcity then
				iter_22_1:getChildByName("chapter_name"):setVisible(false)
			else
				iter_22_1:getChildByName("chapter_name"):setVisible(true)
			end
		end

		self:updateLevelListView()
		self.mapLockWord:setVisible(not level_manager:isLevelModeAutoUnlocked(self.curcity))
	end)

	local var_19_7 = level_manager:getMaxAutoChessCity(var_19_2)

	print(var_19_7)
	self.cityList:jumpToIndex(self.city_to_index[var_19_7])
	self.cityList:setPositionY(self.cityList:getPositionY() - GameDisplay.fix_y)
	self.cityListMask:setPositionY(self.cityListMask:getPositionY() - GameDisplay.fix_y)
end

function AutoChessBaseLayer:updateLevelListView()
	local var_23_0 = level_manager:getCurLevelInfo(self.curcity)

	if var_23_0 == nil then
		return
	end

	local var_23_1 = level_manager:isLevelModeAutoUnlocked(self.curcity)
	local var_23_2 = #var_23_0

	if self.levelViewNode ~= nil then
		self.levelViewNode:removeFromParent()
	end

	self.levelViewNode = self:getTableView(var_23_0, #var_23_0, cc.size(420, 225), cc.size(640, GameDisplay.height - 250), function(arg_24_0, arg_24_1, arg_24_2)
		local var_24_0 = arg_24_1 + 1
		local var_24_1 = (arg_24_1 + 1) % 4

		if (arg_24_1 + 1) % 4 == 0 then
			var_24_1 = 4
		end

		local var_24_2 = arg_24_2[arg_24_1 + 1]
		local var_24_3 = arg_24_0:dequeueCell()

		if var_24_3 == nil then
			var_24_3 = cc.TableViewCell:new()
		end

		local var_24_5 = var_24_3:getChildByName("item")

		if var_24_5 then
			var_24_5:removeFromParent()
		end

		local var_24_7 = self.itemNodeList[var_24_1]:clone()

		var_24_3:addChild(var_24_7)
		var_24_7:setName("item")
		var_24_7:setVisible(true)

		var_24_7.index = arg_24_1 + 1

		local var_24_8 = var_24_7:getChildByName("line")
		local var_24_9 = var_24_7:getChildByName("num")
		local var_24_10 = var_24_7:getChildByName("name")
		local var_24_11 = var_24_7:getChildByName("select1")
		local var_24_12 = var_24_7:getChildByName("select2")

		if var_24_2.curStatus == 1 then
			var_24_11:setVisible(true)
			var_24_12:setVisible(true)
			var_24_11:setPositionX(var_24_11:getPositionX() + 30)
			var_24_12:setPositionX(var_24_12:getPositionX() - 30)

			local var_24_13 = var_24_11:getPositionX()
			local var_24_14 = var_24_12:getPositionX()

			var_24_11:stopAllActions()
			var_24_12:stopAllActions()
			var_24_11:runAction((cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
				var_24_11:setPositionX(var_24_13 - 20)
				var_24_11:setOpacity(255)
			end), cc.MoveBy:create(0.5, cc.p(-20, 0)), cc.FadeOut:create(0.3)))))
			var_24_12:runAction((cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
				var_24_12:setPositionX(var_24_14 + 20)
				var_24_12:setOpacity(255)
			end), cc.MoveBy:create(0.5, cc.p(20, 0)), cc.FadeOut:create(0.3)))))
		else
			var_24_11:setVisible(false)
			var_24_12:setVisible(false)
			var_24_11:stopAllActions()
			var_24_12:stopAllActions()
		end

		local var_24_15 = string.format(var_0_25[var_24_1].on, self.layerName, self.city_to_index[self.curcity])

		if level_manager:isChapterModeUnlocked(self.curcity, arg_24_1 + 1) and var_23_1 == true then
			string.format(var_0_25[var_24_1].on, self.layerName, self.city_to_index[self.curcity])
		end

		var_24_7:setSwallowTouches(false)
		var_24_7:loadTextures(var_24_15, nil, var_24_15, var_0_0)
		var_24_9:setString(string.format("%02d", arg_24_1 + 1))
		var_24_10:setString(var_24_2.des)
		var_24_8:setLocalZOrder(-1)
		var_24_8:setVisible(arg_24_1 + 1 ~= var_23_2)
		var_24_7:setLocalZOrder(10)
		var_24_7:setTouchEnabled(true)
		var_24_7:setPositionY(70)

		if var_24_1 == 4 then
			var_24_7:setPositionY(20)
		end

		var_24_7:addTouchEventListener(function(arg_27_0, arg_27_1)
			if arg_27_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self._playingani then
				return
			end

			if math.abs(arg_27_0:getTouchBeganPosition().y - arg_27_0:getTouchEndPosition().y) > 50 then
				return
			end

			local var_27_0 = self.curcity
			local var_27_1 = var_24_0

			print("自走棋", "mode: " .. self.curcity, "chapter: " .. var_24_0)

			local var_27_2 = activity_manager:getAutoChessModeType(self.activityId)
			local var_27_3 = level_manager:getMaxCity(var_27_2)

			LayerManager:pushInLayer("TowerDefenceDetailLayer", {
				mode = var_27_0,
				chapter = var_24_0,
				surecallback = function()
					LayerManager:switchShowLayer("AutoChessSelectLayer", {
						activityId = self.activityId,
						mode = var_27_0,
						chapter = var_27_1,
						sureCallback = function(arg_29_0)
							activity_manager:switchToAutoChessDefence(var_27_0, var_27_1, arg_29_0, function(arg_30_0)
								if arg_30_0.result == 1 then
									RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", var_27_2)
									FightManager.refreshFightToType(FIGHTTYPE_AUTO_CHESS)
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

		return var_24_3
	end, function(arg_31_0, arg_31_1)
		return
	end)

	self.levelViewNode:setPosition(cc.p(0, 180))
	self.rootLayer:addChild(self.levelViewNode)
	self:scrollTableView()
end

function AutoChessBaseLayer.getTableView(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5, arg_32_6)
	local var_32_0 = cc.TableView:create(arg_32_4)

	var_32_0:setVisible(true)
	var_32_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_BOTTOMUP)
	var_32_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_32_0:setDelegate()
	var_32_0:registerScriptHandler(function(arg_33_0)
		return arg_32_2
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_32_0:registerScriptHandler(function(arg_34_0)
		return
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	var_32_0:registerScriptHandler(function(arg_35_0, arg_35_1)
		arg_32_6(arg_35_0, arg_35_1)
	end, cc.TABLECELL_TOUCHED)
	var_32_0:registerScriptHandler(function(arg_36_0, arg_36_1)
		if arg_36_1 + 1 ~= 1 then
			if (arg_36_1 + 1) % 4 == 0 then
				return 640, 200
			elseif (arg_36_1 + 1) % 4 == 1 then
				return 640, 200
			elseif (arg_36_1 + 1) % 4 == 2 then
				return 640, 200
			elseif (arg_36_1 + 1) % 4 == 3 then
				return 640, 300
			end
		else
			return 640, 190
		end
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_32_0:registerScriptHandler(function(arg_37_0, arg_37_1)
		return arg_32_5(arg_37_0, arg_37_1, arg_32_1)
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_32_0:reloadData()
	var_32_0:setAnchorPoint(cc.p(0, 0))

	return var_32_0
end

function AutoChessBaseLayer:scrollTableView()
	self.levelViewNode:scrollToPercent(math.max(0, (math.min(level_manager:getCurChapter(self.curcity) <= 4 and 0 or (level_manager:getCurChapter(self.curcity) - 4) / level_manager:getModeTotalChapter(self.curcity) * 100, 100))), nil, false)
end

function AutoChessBaseLayer:playExitAni()
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

function AutoChessBaseLayer:playInitShowAni()
	self.maplayer:setVisible(true)
	self.rootLayer:setVisible(true)
end

function AutoChessBaseLayer:fullScreen()
	self.title:setPositionY(self.title:getPositionY() + GameDisplay.fix_y)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end

function AutoChessBaseLayer:initAutoChessChoose()
	self.autoChessChooseSprite = AutoChessChooseSprite:create(self.activityId)

	self.autoChessChooseSprite:setPosition(320, 640)
	self:addChild(self.autoChessChooseSprite)
end

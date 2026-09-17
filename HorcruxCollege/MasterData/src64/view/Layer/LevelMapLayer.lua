LevelMapLayer = class("LevelMapLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local audio_manager = require("controller.audio_manager")
local l2utils = require("controller.l2utils")
local time_check_manager = require("controller.time_check_manager")
local patrol_manager = require("controller.patrol_manager")
local barrage_manager = require("controller.barrage_manager")
local item_data = require("data.item_data")
local photo_manager = require("controller.photo_manager")
local school_cinema_manager = require("controller.school_cinema_manager")
local activity_manager = require("controller.activity_manager")
local CityList = require("view.Sprite.CityList")
local TempWidget = require("view.Sprite.TempWidget")

require("view.Sprite.ChapterSprite")

local var_0_14 = {
	LRTIP = 9,
	BASIC = 8,
	LOCKWORD = 5,
	BGFRAME = 2,
	MAPLAYER = 4,
	DIFFICULTYANI = 7,
	BOSSIMG = 3,
	MAP = 0,
	CITYLIST = 6,
	COVER = 1
}
local var_0_15 = {
	NEW = "LevelMap/city_frame_new.png",
	SELECT = "LevelMap/city_frame_selected.png",
	NORMAL = "LevelMap/city_frame_normal.png"
}
local var_0_16 = "CityMap/title/"
local var_0_17 = {
	"easy",
	"hard",
	"hell",
	"nightmare"
}
local var_0_18 = {
	426,
	310,
	196,
	82
}
local var_0_20

function LevelMapLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = LevelMapLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function LevelMapLayer.getInstance()
	return var_0_20
end

function LevelMapLayer.setInstance(arg_4_0)
	var_0_20 = arg_4_0
end

function LevelMapLayer:init(arg_5_1)
	var_0_20 = self
	self._playingani = false

	if arg_5_1 then
		self.initcity = arg_5_1.initcity
		self.initdifficulty = arg_5_1.initdifficulty
		self.jumpselet = arg_5_1.jumpselet
	end

	patrol_manager:reset()
	self:initTimers()
	level_manager:getModesLockState(function()
		self:initBasicUILayer()
		self:initListView()
		self:initCityMapLayer()
		self:initChangeBnt()
		self:playInitShowAni()
		self:fullScreen()
	end)
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			var_0_20 = false

			activity_manager:releaseEventListenerByName("LevelMapLayer")
		end
	end)
end

function LevelMapLayer:initListView()
	self.listview = ccui.Helper:seekWidgetByName(self.uilayer, "btn_listview")
end

function LevelMapLayer.registerActivityEventListener(arg_9_0)
	activity_manager:registerEventListener("LevelMapLayer", activity_manager.activityEventId.EXIT_FORM_TOPPLOTLIST_LAYER, function(arg_10_0)
		if PlotManager:check_plot_is_finished_by_plotclassid(plotclassid) then
			arg_9_0.taskReward:setVisible(false)
		end
	end)
end

function LevelMapLayer:initChangeBnt()
	self.changeBnt = ccui.Helper:seekWidgetByName(self.listview, "Button_change")

	self.changeBnt:loadTextures("LevelMap/goto_talk.png", nil, "LevelMap/goto_talk.png", var_0_0)
	self.changeBnt:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("LevelTalkMapLayer")
	end)

	self.branchBnt = ccui.Helper:seekWidgetByName(self.listview, "Button_branch")

	self.branchBnt:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("LevelMapBoxLayer")
	end)

	self.specailBnt = ccui.Helper:seekWidgetByName(self.listview, "Button_special")

	self.specailBnt:loadTextures("LevelMap/btn_special_on.png", nil, "LevelMap/btn_special_on.png", var_0_0)
	self.specailBnt:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("SpecialOperationLayer", {
			initcity = 51
		})
	end)
end

function LevelMapLayer:fullScreen()
	self.panelDifficulty.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - self.panelDifficulty:getPositionY(), TRANSFORM_UNIT.PX)

	self.panelDifficulty:setPositionY(self.panelDifficulty.full_posY)

	self.cityTitle.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - self.cityTitle:getPositionY(), TRANSFORM_UNIT.PX)

	self.cityTitle:setPositionY(self.cityTitle.full_posY)

	self.btnReturn.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.btnReturn:getPositionY(), TRANSFORM_UNIT.PX)

	self.btnReturn:setPositionY(self.btnReturn.full_posY)

	self.listview.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.listview:getPositionY(), TRANSFORM_UNIT.PX)

	self.listview:setPositionY(self.listview.full_posY)

	self.mainBtn = ccui.Helper:seekWidgetByName(self.listview, "Button_main")

	self.mainBtn:loadTextures("LevelMap/goto_main_off.png", "LevelMap/goto_main_off.png", "LevelMap/goto_main_off.png", var_0_0)

	self.cityList.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.cityList:getPositionY(), TRANSFORM_UNIT.PX)

	self.cityList:setPositionY(self.cityList.full_posY)

	local var_15_0 = ccui.Helper:seekWidgetByName(self.uilayer, "city_panel_frame")

	var_15_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_15_0:getPositionY(), TRANSFORM_UNIT.PX)

	var_15_0:setPositionY(var_15_0.full_posY)
end

local function var_0_21(arg_16_0)
	if arg_16_0 >= 3600 then
		return string.format("%02d:%02d:%02d", math.floor(arg_16_0 / 3600), math.floor(arg_16_0 % 3600 / 60), arg_16_0 % 60)
	else
		return string.format("%02d:%02d", math.floor(arg_16_0 / 60), arg_16_0 % 60)
	end
end

function LevelMapLayer:initTimers()
	self.timers = {}

	local var_17_0 = 1

	self:scheduleUpdateWithPriorityLua(function(arg_18_0)
		var_17_0 = var_17_0 + arg_18_0

		if var_17_0 > 1 then
			local var_18_0

			for iter_18_0, iter_18_1 in pairs(self.timers) do
				var_18_0 = patrol_manager:getPatrolInfo(iter_18_1.key)

				if var_18_0 then
					-- block empty
				else
					self.timers[iter_18_0] = nil
				end
			end

			if var_18_0 then
				self.updatePatrolTime = true

				self:updateShowingCells()

				self.updatePatrolTime = false
			end

			var_17_0 = var_17_0 - 1
		end
	end, 1)
end

function LevelMapLayer.cleanAllTimers(arg_19_0)
	arg_19_0.timers = {}
end

function LevelMapLayer.changeTheCityList(arg_20_0, arg_20_1)
	return arg_20_1
end

function LevelMapLayer:initBasicUILayer()
	self:loadBasicUIAssets()

	self.uilayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "LevelMap.json" or "LevelMap.ExportJson")

	self:addChild(self.uilayer, var_0_14.BASIC)

	self.cityTitle = ccui.Helper:seekWidgetByName(self.uilayer, "title")
	self.btnReturn = ccui.Helper:seekWidgetByName(self.uilayer, "btn_return")

	self.btnReturn:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._playingani then
			return
		end

		self:playExitAni()
	end)
	self:initPanelDifficulty()
	self:initCityList()
	self:initUIInfos()
end

function LevelMapLayer:initCityList()
	self.cityList = CityList:create()

	self:addChild(self.cityList, var_0_14.CITYLIST)

	self.curcity = nil
	self.index_to_city = {}
	self.city_to_index = {}
	self.cities = {}

	local var_23_0 = self:changeTheCityList(level_manager:getCityList())

	local function var_23_1(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_24_0:getTouchBeganPosition().x - arg_24_0:getTouchEndPosition().x) >= 25 then
			return
		end

		if self._playingani then
			return
		end

		self.cityList:scrollToIndexManual(arg_24_0:getTag())

		for iter_24_0, iter_24_1 in ipairs(var_23_0) do
			self:updateCityBntTips(iter_24_1)
		end

		self:updateLeftRightTigEffect()
	end

	local function var_23_2(arg_25_0)
		local var_25_0 = ccui.Button:create(var_0_15.NORMAL, var_0_15.NORMAL, var_0_15.NORMAL, var_0_0)

		var_25_0:setName("city" .. arg_25_0)

		var_25_0.areaid = level_manager:getAreaId(arg_25_0)

		local var_25_1 = cc.Sprite:create("CityMap/MiniMap/" .. level_manager:getCityImg(arg_25_0) .. ".png")

		var_25_1:setPosition(cc.p(var_25_0:getContentSize().width / 2, var_25_0:getContentSize().height / 2))
		var_25_1:setName("minimap")

		if self.showDetail then
			local var_25_2 = cc.Label:createWithTTF(L_PLOT_CLASS_STR.MOVE .. self.cityList:getCityNumber() + 1, FONT_NAME, 18)

			var_25_2:setPosition(cc.p(var_25_2:getContentSize().width / 2 + 19, 78))
			var_25_1:addChild(var_25_2)

			local var_25_3 = cc.Label:createWithTTF(level_manager:getCityName(arg_25_0), FONT_NAME, 24)

			var_25_3:setPosition(cc.p(var_25_1:getContentSize().width - var_25_3:getContentSize().width / 2 - 10, 15))
			var_25_1:addChild(var_25_3)
		end

		var_25_0:addChild(var_25_1, -1)

		local var_25_4 = ccui.ImageView:create(var_0_15.SELECT, var_0_0)

		var_25_4:setPosition(cc.p(var_25_0:getContentSize().width / 2, var_25_0:getContentSize().height / 2))
		var_25_4:setName("frame")
		var_25_4:setVisible(false)
		var_25_0:addChild(var_25_4, 2)

		if not level_manager:isCityUnlocked(arg_25_0) then
			l2utils:shaderGrayDark(var_25_0:getVirtualRenderer())
			l2utils:shaderGrayDark(var_25_1)

			if not level_manager:isCityCanUnlock(arg_25_0) then
				l2utils:shaderNode(var_25_4:getVirtualRenderer())
			end
		else
			l2utils:shaderDarkNode(var_25_0:getVirtualRenderer())
			l2utils:shaderDarkNode(var_25_1)
		end

		var_25_0:addTouchEventListener(var_23_1)

		return var_25_0
	end

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		local var_23_3 = var_23_2(iter_23_1)

		self.cityList:pushInCity(var_23_3)

		self.cities[iter_23_1] = var_23_3
		self.index_to_city[var_23_3:getTag()] = iter_23_1
		self.city_to_index[iter_23_1] = var_23_3:getTag()
	end

	self.cityList:registerSelectCityHandler(function(arg_26_0)
		if self.curcity == self.index_to_city[arg_26_0] then
			return
		end

		self:updateCityOnUnSelect(self.curcity)

		self.curcity = self.index_to_city[arg_26_0]

		self:updateMapJsonInfo()
		self:updateCityOnSelect(self.curcity)
		self:playSelectCityAni()

		for iter_26_0, iter_26_1 in ipairs(var_23_0) do
			self:updateCityBntTips(iter_26_1)
		end

		self:updateLeftRightTigEffect()
	end)

	self.curcity = self.initcity or level_manager:getCurFightCity()

	if level_manager:isSpecialCity(self.curcity) and not self.cities[self.curcity] then
		self.curcity = 1
	end

	if not level_manager:can_city_join(self.curcity) or level_manager:isBranchCity(self.curcity) then
		self.curcity = level_manager:getCurFightCity()
	end

	self:updateMapJsonInfo()
	print("self.curmapjsonchapternum", self.curmapjsonchapternum)
	self:updateCityOnSelect(self.curcity)
	self.cityList:jumpToIndex(self.city_to_index[self.curcity])

	for iter_23_2, iter_23_3 in ipairs(var_23_0) do
		self:updateCityBntTips(iter_23_3)
	end

	self:updateLeftRightTigEffect()
end

function LevelMapLayer:updateCityBntTips(arg_27_1)
	local var_27_0 = self.cities[arg_27_1]

	if not self.cities[arg_27_1] then
		return
	end

	local var_27_1 = var_27_0:getChildByName("frame")

	local function var_27_2()
		return self.city_to_index[arg_27_1] - self.city_to_index[self.curcity] == -1
	end

	local var_27_3 = 0
	local var_27_4 = 45
	local var_27_7 = 3
	local var_27_8 = self.cityList:getCityBtnDirection(arg_27_1)

	if level_manager:isCityCanUnlock(arg_27_1) and var_27_8 == var_27_7 then
		if not var_27_0:getChildByName("newtag") then
			var_27_1:loadTexture(var_0_15.NEW, var_0_0)
			var_27_1:setVisible(true)

			local var_27_9 = ccui.ImageView:create("LevelMap/img_tagnew.png", var_0_0)

			var_27_9:setAnchorPoint(cc.p(0.5, 0))

			if var_27_2() then
				var_27_9:setPosition(cc.p(150 - var_27_4, 100 + var_27_3))
			else
				var_27_9:setPosition(cc.p(150, 100))
			end

			var_27_9:setName("newtag")
			var_27_0:addChild(var_27_9)
		elseif var_27_2() then
			var_27_0:getChildByName("newtag"):setPosition(cc.p(150 - var_27_4, 100 + var_27_3))
		else
			var_27_0:getChildByName("newtag"):setPosition(cc.p(150, 100))
		end
	elseif var_27_0:getChildByName("newtag") then
		var_27_0:removeChildByName("newtag")
	end

	if patrol_manager:isCityFinishedPatrol(arg_27_1) and var_27_8 == var_27_7 then
		if not var_27_0:getChildByName("reddot") then
			local var_27_10 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

			var_27_10:setAnchorPoint(cc.p(1, 1))

			if var_27_2() then
				var_27_10:setPosition(var_27_0:getContentSize().width - 10 - var_27_4, var_27_0:getContentSize().height + 18 + var_27_3)
			else
				var_27_10:setPosition(var_27_0:getContentSize().width - 10, var_27_0:getContentSize().height + 18)
			end

			var_27_10:setName("reddot")
			var_27_0:addChild(var_27_10, 9)
		elseif var_27_2() then
			var_27_0:getChildByName("reddot"):setPosition(var_27_0:getContentSize().width - 10 - var_27_4, var_27_0:getContentSize().height + 18 + var_27_3)
		else
			var_27_0:getChildByName("reddot"):setPosition(var_27_0:getContentSize().width - 10, var_27_0:getContentSize().height + 18)
		end
	elseif var_27_0:getChildByName("reddot") then
		var_27_0:removeChildByName("reddot")
	end

	if level_manager:isCityNewDifficulty(arg_27_1) and var_27_8 == var_27_7 then
		if not var_27_0:getChildByName("newDifficultyTips") then
			local var_27_11 = ccui.ImageView:create("LevelMap/img_tagnew.png", var_0_0)

			var_27_11:setAnchorPoint(cc.p(0.5, 0))

			if var_27_2() then
				var_27_11:setPosition(cc.p(150 - var_27_4, 100 + var_27_3))
			else
				var_27_11:setPosition(cc.p(150, 100))
			end

			var_27_11:setName("newDifficultyTips")
			var_27_0:addChild(var_27_11)
		elseif var_27_2() then
			var_27_0:getChildByName("newDifficultyTips"):setPosition(cc.p(150 - var_27_4, 100 + var_27_3))
		else
			var_27_0:getChildByName("newDifficultyTips"):setPosition(cc.p(150, 100))
		end
	elseif var_27_0:getChildByName("newDifficultyTips") then
		var_27_0:removeChildByName("newDifficultyTips")
	end

	if level_manager:checkIsNewStarRewardInCity(arg_27_1) and var_27_8 == var_27_7 then
		if not var_27_0:getChildByName("newStarTips") then
			local var_27_12 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

			var_27_12:setAnchorPoint(cc.p(1, 1))

			if var_27_2() then
				var_27_12:setPosition(var_27_0:getContentSize().width - 10 - var_27_4, var_27_0:getContentSize().height + 18 + var_27_3)
			else
				var_27_12:setPosition(var_27_0:getContentSize().width - 10, var_27_0:getContentSize().height + 18)
			end

			var_27_12:setName("newStarTips")
			var_27_0:addChild(var_27_12, 9)
		elseif var_27_2() then
			var_27_0:getChildByName("newStarTips"):setPosition(var_27_0:getContentSize().width - 10 - var_27_4, var_27_0:getContentSize().height + 18 + var_27_3)
		else
			var_27_0:getChildByName("newStarTips"):setPosition(var_27_0:getContentSize().width - 10, var_27_0:getContentSize().height + 18)
		end
	else
		local var_27_13
		local var_27_14

		if var_27_0:getChildByName("newStarTips") then
			var_27_0:removeChildByName("newStarTips")

			var_27_13 = var_27_8 == var_27_7
			var_27_14 = ipairs
		end
	end

	for iter_27_0, iter_27_1 in var_27_14({
		"newDifficultyTips",
		"reddot",
		"newPatrolTips",
		"newStarTips"
	}) do
		if var_27_0:getChildByName(iter_27_1) then
			var_27_0:getChildByName(iter_27_1):setVisible(var_27_13)

			var_27_13 = false
		end
	end
end

function LevelMapLayer:updateLeftRightTigEffect()
	local var_29_0 = self:changeTheCityList(level_manager:getCityList())

	local function var_29_1(arg_30_0)
		if level_manager:isCityCanUnlock(arg_30_0) then
			return true
		end

		if patrol_manager:isCityFinishedPatrol(arg_30_0) then
			return true
		end

		if patrol_manager:isCityNewPatrol(arg_30_0) then
			return true
		end

		if level_manager:isCityNewDifficulty(arg_30_0) then
			return true
		end

		if PlotManager.plot_layer_config["LevelMapLayer" .. arg_30_0] then
			return true
		end

		if level_manager:checkIsNewStarRewardInCity(arg_30_0) then
			return true
		end

		return false
	end

	local function var_29_2()
		local var_32_0 = false

		for iter_32_0, iter_32_1 in ipairs(var_29_0) do
			if self.cityList:getCityBtnDirection(iter_32_1) == 2 and var_29_1(iter_32_1) then
				var_32_0 = true

				break
			end
		end

		return var_32_0
	end

	if not self:getChildByName("left_tag") then
		local var_29_3 = ccui.ImageView:create("LevelMap/left_right_tag.png", var_0_0)

		var_29_3:setPosition(cc.p(18 - GameDisplay.fix_x, 128 - GameDisplay.fix_y))
		var_29_3:setName("left_tag")
		var_29_3:setVisible(false)
		self:addChild(var_29_3, var_0_14.LRTIP)
		var_29_3:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(18 - GameDisplay.fix_x + 10, 128 - GameDisplay.fix_y + 10)), cc.MoveTo:create(0.5, cc.p(18 - GameDisplay.fix_x, 128 - GameDisplay.fix_y)))))
	end

	if not self:getChildByName("right_tag") then
		local var_29_4 = ccui.ImageView:create("LevelMap/left_right_tag.png", var_0_0)

		var_29_4:setPosition(cc.p(GameDisplay.width - (18 - GameDisplay.fix_x), 128 - GameDisplay.fix_y))
		var_29_4:setScaleX(-1)
		var_29_4:setName("right_tag")
		var_29_4:setVisible(false)
		var_29_4:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(GameDisplay.width - (18 - GameDisplay.fix_x) - 10, 128 - GameDisplay.fix_y + 10)), cc.MoveTo:create(0.5, cc.p(GameDisplay.width - (18 - GameDisplay.fix_x), 128 - GameDisplay.fix_y)))))
		self:addChild(var_29_4, var_0_14.LRTIP)
	end

	if (function()
		local var_31_0 = false

		for iter_31_0, iter_31_1 in ipairs(var_29_0) do
			if self.cityList:getCityBtnDirection(iter_31_1) == 1 and var_29_1(iter_31_1) then
				var_31_0 = true

				break
			end
		end

		return var_31_0
	end)() then
		self:getChildByName("left_tag"):setVisible(true)
	else
		self:getChildByName("left_tag"):setVisible(false)
	end

	if var_29_2() then
		self:getChildByName("right_tag"):setVisible(true)
	else
		self:getChildByName("right_tag"):setVisible(false)
	end
end

function LevelMapLayer:getCityByID(arg_33_1)
	return self.cities[arg_33_1]
end

function LevelMapLayer:getCityByIndex(arg_34_1)
	return self.cities[self.index_to_city[arg_34_1]]
end

function LevelMapLayer:updateCityOnSelect(arg_35_1)
	local var_35_0 = self:getCityByID(arg_35_1)

	if level_manager:isCityUnlocked(arg_35_1) then
		l2utils:recoverShader(var_35_0:getVirtualRenderer())
		l2utils:recoverShader(var_35_0:getChildByName("minimap"))
	else
		l2utils:shaderNode(var_35_0:getVirtualRenderer())
		l2utils:shaderNode(var_35_0:getChildByName("minimap"))
	end

	var_35_0:getChildByName("frame"):setVisible(true)

	if not level_manager:isCityCanUnlock(arg_35_1) then
		var_35_0:getChildByName("frame"):loadTexture(var_0_15.SELECT, var_0_0)
	end

	self:playCityFrameBreath(arg_35_1)
end

function LevelMapLayer:updateCityOnUnSelect(arg_36_1)
	local var_36_0 = self:getCityByID(arg_36_1)

	if level_manager:isCityUnlocked(arg_36_1) then
		l2utils:shaderDarkNode(var_36_0:getVirtualRenderer())
		l2utils:shaderDarkNode(var_36_0:getChildByName("minimap"))
	else
		l2utils:shaderGrayDark(var_36_0:getVirtualRenderer())
		l2utils:shaderGrayDark(var_36_0:getChildByName("minimap"))
	end

	if not level_manager:isCityCanUnlock(arg_36_1) then
		var_36_0:getChildByName("frame"):setVisible(false)
	end

	self:stopCityFrameBreath(arg_36_1)
end

function LevelMapLayer:updateCityOnUnlock()
	local var_37_0 = self:getCityByID(self.curcity)

	if not var_37_0 then
		return
	end

	l2utils:recoverShader(var_37_0:getVirtualRenderer())
	l2utils:recoverShader(var_37_0:getChildByName("minimap"))

	if var_37_0:getChildByName("newtag") then
		var_37_0:removeChildByName("newtag")
	end

	var_37_0:getChildByName("frame"):loadTexture(var_0_15.SELECT, var_0_0)
end

function LevelMapLayer.playCityFrameBreath(arg_38_0, arg_38_1)
	return
end

function LevelMapLayer.stopCityFrameBreath(arg_39_0, arg_39_1)
	return
end

function LevelMapLayer:initUIInfos()
	local var_40_0 = self.initdifficulty and level_manager:isCityDifficultyValid(self.curcity, self.initdifficulty) and self.initdifficulty or self.curcity == level_manager:getCurFightCity() and level_manager:getCurMainFightDifficulty() or level_manager:getUnlockedDifficultyInCity(self.curcity)

	if level_manager:isCityUnlocked(self.curcity) then
		self.curdifficuty = var_40_0
		self.finaldifficuty = var_40_0

		self.cityTitle:loadTexture(var_0_16 .. level_manager:getCityImg(self.curcity) .. "_" .. self.curdifficuty .. ".png")
		l2utils:recoverShader(self.cityTitle:getVirtualRenderer())
	else
		self.curdifficuty = nil

		self.cityTitle:loadTexture(var_0_16 .. level_manager:getCityImg(self.curcity) .. "_1.png")
		l2utils:shaderGrayDark(self.cityTitle:getVirtualRenderer())
	end

	if self.curdifficuty and not level_manager:isOnlyCityDifficultyValid(self.curcity, self.curdifficuty) then
		self.curdifficuty = level_manager:getUnlockedDifficultyInCity(self.curcity)
	end

	self:updateDifficutyPanel()
	self:initStarRewardUI()
	self:initRankUI()
	self:updateBossImg()
end

function LevelMapLayer:updateUIInfos()
	if level_manager:isCityUnlocked(self.curcity) then
		if self.finaldifficuty then
			local var_41_0 = level_manager:getCityDifficulties(self.curcity)
			local var_41_1

			for iter_41_0 = 1, 4 do
				if var_41_0[iter_41_0] and var_41_0[iter_41_0].stat then
					var_41_1 = iter_41_0
				end
			end

			self.finaldifficuty = var_41_1
			self.curdifficuty = self.finaldifficuty
		else
			self.curdifficuty = self.curcity == level_manager:getCurFightCity() and level_manager:getCurMainFightDifficulty() or 1
			self.finaldifficuty = self.curdifficuty
		end

		self.cityTitle:loadTexture(var_0_16 .. level_manager:getCityImg(self.curcity) .. "_" .. self.curdifficuty .. ".png")
		l2utils:recoverShader(self.cityTitle:getVirtualRenderer())
	else
		self.curdifficuty = nil

		self.cityTitle:loadTexture(var_0_16 .. level_manager:getCityImg(self.curcity) .. "_1.png")
		l2utils:shaderGrayDark(self.cityTitle:getVirtualRenderer())
	end

	if self.curdifficuty ~= self.finaldifficuty then
		self.curdifficuty = self.finaldifficuty
	end

	if self.curdifficuty ~= self.finaldifficuty then
		self.curdifficuty = self.finaldifficuty
	end

	self:updateDifficutyPanel()
	self:updateRankUI()
	self:updateStarRewardUI()
	self:updateBossImg()
	self:updateTaskRewardUI()
end

function LevelMapLayer:initPanelDifficulty()
	self.panelDifficulty = ccui.Helper:seekWidgetByName(self.uilayer, "panel_difficulty")

	for iter_42_0 = 1, 4 do
		self.panelDifficulty:getChildByName("btn_" .. var_0_17[iter_42_0]):addTouchEventListener(function(arg_43_0, arg_43_1)
			if arg_43_1 ~= ccui.TouchEventType.ended then
				return
			end

			if level_manager:isCityNewDifficulty(self.curcity, iter_42_0) then
				level_manager:unMarkModeNew(level_manager:getModeByDifficulty(self.curcity, iter_42_0))
				self:updateDifficutyTips(self.curcity, iter_42_0)
				self:updateCityBntTips(self.curcity)
			end

			if iter_42_0 == self.curdifficuty then
				return
			end

			if self._playingani then
				return
			end

			self:selectDifficulty(iter_42_0)
		end)
	end
end

function LevelMapLayer:selectDifficulty(arg_44_1)
	self.curdifficuty = arg_44_1
	self.finaldifficuty = arg_44_1

	self.cityTitle:loadTexture(var_0_16 .. level_manager:getCityImg(self.curcity) .. "_" .. self.curdifficuty .. ".png")
	self:updateDifficutyPanel()
	self:updateRankUI()
	self:updateStarRewardUI()
	self:playSelectDifficultyAni()
	self:updateBossImg()
	self:updateTaskRewardUI()
	self:updateMapLockWord(self.curcity, arg_44_1)
end

function LevelMapLayer:updateDifficutyPanel()
	local var_45_1 = #level_manager:getCityDifficulties(self.curcity)

	for iter_45_0 = 1, #var_0_17 do
		local var_45_2 = self.panelDifficulty:getChildByName("btn_" .. var_0_17[iter_45_0])
		local var_45_3

		if iter_45_0 <= var_45_1 and var_45_1 > 1 then
			var_45_2:setVisible(true)
			var_45_2:setPositionX(var_0_18[#var_0_17 - 1 + 1 - (#var_0_17 - var_45_1)])

			var_45_3 = 1 + 1

			local var_45_4

			if iter_45_0 == self.finaldifficuty then
				var_45_4 = "LevelMap/btn_" .. var_0_17[iter_45_0] .. ".png"

				var_45_2:getVirtualRenderer():setOpacity(255)
			else
				var_45_4 = "LevelMap/btn_" .. var_0_17[iter_45_0] .. ".png"

				var_45_2:getVirtualRenderer():setOpacity(170)
			end

			var_45_2:loadTextures(var_45_4, nil, var_45_4, var_0_0)
			self:updateDifficutyTips(self.curcity, iter_45_0)
		else
			var_45_2:setVisible(false)
		end
	end
end

function LevelMapLayer:updateDifficutyTips(arg_46_1, arg_46_2)
	local var_46_0 = self.panelDifficulty:getChildByName("btn_" .. var_0_17[arg_46_2])
	local var_46_1 = {}

	if patrol_manager:isCityFinishedPatrol(arg_46_1, arg_46_2) then
		if not var_46_0:getChildByName("reddot") then
			local var_46_2 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

			var_46_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_46_2:setPosition(var_46_0:getContentSize().width, var_46_0:getContentSize().height)
			var_46_2:setName("reddot")
			var_46_0:addChild(var_46_2)
		else
			var_46_0:getChildByName("reddot"):setVisible(true)
		end

		if self.curdifficuty == arg_46_2 then
			var_46_0:getChildByName("reddot"):setVisible(false)
		end

		var_46_1.reddot = true
	elseif var_46_0:getChildByName("reddot") then
		var_46_0:getChildByName("reddot"):setVisible(false)
	end

	if level_manager:isCityNewDifficulty(arg_46_1, arg_46_2) then
		if not var_46_0:getChildByName("newDifficultyTips") then
			local var_46_3 = ccui.ImageView:create("LevelMap/img_tagnew.png", var_0_0)

			var_46_3:setAnchorPoint(cc.p(0.5, 0.5))
			var_46_3:setPosition(cc.p(var_46_0:getContentSize().width - 20, var_46_0:getContentSize().height))
			var_46_3:setName("newDifficultyTips")
			var_46_0:addChild(var_46_3)
		else
			var_46_0:getChildByName("newDifficultyTips"):setVisible(true)
		end

		var_46_1.newDifficultyTips = true
	elseif var_46_0:getChildByName("newDifficultyTips") then
		var_46_0:getChildByName("newDifficultyTips"):setVisible(false)
	end

	if self.curdifficuty ~= arg_46_2 then
		for iter_46_0, iter_46_1 in ipairs({
			"newDifficultyTips",
			"reddot",
			"newPatrolTips"
		}) do
			if var_46_0:getChildByName(iter_46_1) and var_46_1[iter_46_1] then
				var_46_0:getChildByName(iter_46_1):setVisible(true)
			end
		end
	end
end

function LevelMapLayer:initCityMapLayer()
	local var_47_0 = self.initcity or level_manager:getCurFightCity()

	if not level_manager:can_city_join(var_47_0) then
		var_47_0 = level_manager:getCurFightCity()
	end

	local var_47_1 = self.initdifficulty and level_manager:isCityDifficultyValid(var_47_0, self.initdifficulty) and self.initdifficulty or var_47_0 == level_manager:getCurFightCity() and level_manager:getCurMainFightDifficulty() or level_manager:getUnlockedDifficultyInCity(var_47_0)
	local var_47_2 = level_manager:getModeByDifficulty(var_47_0, var_47_1)
	local var_47_3 = level_manager:getCityConf(var_47_0)

	self.maplayer = ccui.Layout:create()

	self.maplayer:setContentSize(cc.Director:getInstance():getVisibleSize())
	self.maplayer:setAnchorPoint(cc.p(0, 0))
	self.maplayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.maplayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.maplayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self:addChild(self.maplayer, var_0_14.MAPLAYER)

	self.mapbg = ccui.ImageView:create("CityMap/Maps/country" .. self.curcity .. ".png")

	self.mapbg:setPositionX(self.maplayer:getContentSize().width / 2)
	self.mapbg:setPositionY(self.maplayer:getContentSize().height / 2)
	self:addChild(self.mapbg, var_0_14.MAP)

	local var_47_4 = ccui.ImageView:create("CityMap/Maps/bgframe.png")

	var_47_4:setPosition(cc.p(self.maplayer:getContentSize().width / 2, self.maplayer:getContentSize().height / 2 - GameDisplay.fix_y))
	var_47_4:setScaleY(GameDisplay.height / var_47_4:getContentSize().height)
	self.maplayer:addChild(var_47_4, var_0_14.BGFRAME)

	local var_47_5 = ccui.ImageView:create("LevelMap/img_word.png", var_0_0)

	var_47_5:setFlippedX(true)
	var_47_5:setFlippedY(true)
	var_47_5:setPosition(cc.p(535, 145))
	self.maplayer:addChild(var_47_5, 3)

	if level_manager:isCityUnlocked(var_47_0) then
		self:createCover()
	end

	self:initCityMapChapters()
	self:initSpecialChapter()
	self:initCityTableView()
	self:updateShowingCells()
	self:scrollTableView()
	self:updateSpecialChapter()
	self:initMapLockWord()
	self:updateMapLockWord(var_47_0, var_47_1)
end

local var_0_22 = 640
local var_0_23 = 1136 + GameDisplay.fix_y * 2 - 220
local var_0_24 = 0
local var_0_25 = 140 - GameDisplay.fix_y
local var_0_26 = 640
local var_0_27 = 745
local var_0_28 = 100 * (GameDisplay.fix_y / 174) + 100
local var_0_29 = 100 * (GameDisplay.fix_y / 174) + 100

function LevelMapLayer:initCityTableView()
	local function var_48_0(arg_49_0, arg_49_1)
		if arg_49_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._playingani then
			return
		end

		local var_49_0 = self.curcity
		local var_49_1 = self.curdifficuty
		local var_49_2 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty)
		local var_49_3 = arg_49_0.chapter
		local var_49_4 = false

		if not level_manager:canChapterModeUnlock(var_49_2, arg_49_0.chapter) or not level_manager:isChapterModeValid(var_49_2, var_49_3) then
			global_ShowBlockWords(L_MAP_CITY_CHAPTERS.Forbid)
			audio_manager:playeffectMusicTest("sound/invalid")

			var_49_4 = true
		end

		if patrol_manager:getPatrolInfo(var_49_2 .. "-" .. var_49_3) then
			LayerManager:pushInLayer("PatrolPopLayer", {
				inittype = 2,
				mode = var_49_2,
				chapter = var_49_3,
				callback = function()
					self:updateShowingCells()
					self:updateCityBntTips(var_49_0, var_49_1)
					self:updateDifficutyTips(var_49_0, var_49_1)
				end
			})
		else
			local var_49_5 = {
				islock = var_49_4,
				mode = var_49_2,
				chapter = var_49_3
			}

			function var_49_5.patrolCallback()
				self:updateShowingCells()
				self:updateCityBntTips(var_49_0, var_49_1)
				self:updateDifficutyTips(var_49_0, var_49_1)
			end

			LayerManager:pushInLayer("PopChaptersPreviewLayer", var_49_5)
		end
	end

	local function var_48_1(arg_52_0, arg_52_1)
		if level_manager:isChapterModeUnlocked(arg_52_0, arg_52_1) then
			if self.timers[arg_52_0 .. "-" .. arg_52_1] then
				local var_52_0 = patrol_manager:getPatrolInfo(self.timers[arg_52_0 .. "-" .. arg_52_1].key)

				if var_52_0 and var_52_0.time > 0 then
					-- block empty
				else
					self.timers[arg_52_0 .. "-" .. arg_52_1] = nil
				end
			else
				local var_52_1 = arg_52_0 .. "-" .. arg_52_1

				if patrol_manager:getPatrolState(arg_52_0 .. "-" .. arg_52_1) == 3 then
					self.timers[var_52_1] = {
						index = index,
						key = var_52_1
					}
				end
			end
		end
	end

	self.chapterTV = cc.TableView:create(cc.size(var_0_22, var_0_23))

	self.chapterTV:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.chapterTV:setVerticalFillOrder(cc.TABLEVIEW_FILL_BOTTOMUP)
	self.chapterTV:setPosition(cc.p(var_0_24, var_0_25))
	self.chapterTV:setDelegate()
	self.maplayer:addChild(self.chapterTV, 2)
	self.chapterTV:registerScriptHandler(function(arg_53_0, arg_53_1)
		if arg_53_1 == 0 then
			return var_0_26, self.levelmapcellheight + var_0_28
		elseif arg_53_1 + 1 == math.ceil(self.chapterTV.totalChapters / self.curmapjsonchapternum) then
			return var_0_26, self.levelmapcellheight + var_0_29
		else
			return var_0_26, self.levelmapcellheight
		end
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.chapterTV:registerScriptHandler(function(arg_54_0, arg_54_1)
		local var_54_0 = arg_54_0:dequeueCell()

		if not var_54_0 then
			var_54_0 = cc.TableViewCell:create()

			var_54_0:setName("cell_" .. arg_54_1)
		end

		;(function(...)
			for iter_55_0 = 1, self.curmapjsonchapternum do
				if not var_54_0:getChildByName("sp_" .. iter_55_0) then
					local var_55_0 = ChapterSprite:create()

					var_55_0:_setSwallowTouches(false)
					var_55_0:setName("sp_" .. iter_55_0)
					var_54_0:addChild(var_55_0, 100)
					var_55_0:_addTouchEventListener(var_48_0)
				end
			end
		end)()

		local var_54_2 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)
		local var_54_3 = level_manager:getModeTotalChapter(var_54_2)
		local var_54_4 = 0

		if arg_54_1 == 0 then
			var_54_4 = var_0_28
		end

		if arg_54_1 == math.ceil(var_54_3 / self.curmapjsonchapternum) then
			var_54_4 = -var_0_29
		end

		if math.ceil(var_54_3 / self.curmapjsonchapternum) == 1 then
			var_54_4 = 0
		end

		if arg_54_1 + 1 <= math.ceil(var_54_3 / self.curmapjsonchapternum) then
			var_54_0:setVisible(true)
			;(function(...)
				if not var_54_0:getChildByName("map") then
					local var_56_0 = self:getMapObj()

					var_56_0:setName("map")

					var_56_0.city = self.curcity

					var_54_0:addChild(var_56_0)
				end

				if var_54_0:getChildByName("map").city ~= self.curcity then
					var_54_0:getChildByName("map"):removeFromParent()

					local var_56_1 = self:getMapObj()

					var_56_1:setName("map")

					var_56_1.city = self.curcity

					var_54_0:addChild(var_56_1)
				end

				var_54_0:getChildByName("map"):setPositionY((self.levelmapcellheight - 1136) / 2 + var_54_4)
			end)()

			local var_54_5 = var_54_0:getChildByName("map")

			if var_54_5:getChildByName("line_under") then
				var_54_5:getChildByName("line_under"):setVisible(arg_54_1 ~= 0)
			end

			if var_54_5:getChildByName("line_above") then
				var_54_5:getChildByName("line_above"):setVisible(arg_54_1 + 1 ~= math.ceil(var_54_3 / self.curmapjsonchapternum))
			end

			local var_54_6 = 1

			while var_54_0:getChildByName("sp_" .. var_54_6) do
				var_54_0:getChildByName("sp_" .. var_54_6):setVisible(false)

				var_54_6 = var_54_6 + 1
			end

			local var_54_7 = 1

			while var_54_5:getChildByName("area_" .. var_54_7) do
				var_54_5:getChildByName("area_" .. var_54_7):setVisible(false)

				var_54_7 = var_54_7 + 1
			end

			for iter_54_0 = 1, self.curmapjsonchapternum do
				local var_54_8 = var_54_0:getChildByName("sp_" .. iter_54_0)

				if var_54_3 >= arg_54_1 * self.curmapjsonchapternum + iter_54_0 and var_54_5:getChildByName("area_" .. iter_54_0) then
					var_54_5:getChildByName("area_" .. iter_54_0):setVisible(level_manager:isChapterModeUnlocked(var_54_2, arg_54_1 * self.curmapjsonchapternum + iter_54_0))
					var_54_8:setVisible(true)

					local var_54_9 = {
						timer = self.timers[var_54_2 .. "-" .. arg_54_1 * self.curmapjsonchapternum + iter_54_0],
						chapter = arg_54_1 * self.curmapjsonchapternum + iter_54_0,
						curcity = self.curcity
					}

					var_54_9.curdifficuty = self.curdifficuty or 1
					var_54_8.chapter = arg_54_1 * self.curmapjsonchapternum + iter_54_0

					var_54_8:update(var_54_9)

					local var_54_10 = var_54_5:getChildByName("area_" .. iter_54_0):getPositionX()

					if level_manager:getChapterStrongholdLv(var_54_2, arg_54_1 * self.curmapjsonchapternum + iter_54_0) ~= 1 and (arg_54_1 * self.curmapjsonchapternum + iter_54_0) % 2 == 1 then
						var_54_10 = var_54_10 - 33
					end

					var_54_8:setPosition(cc.p(var_54_10 + var_54_8._plotViewBtnOffsetX, var_54_5:getChildByName("area_" .. iter_54_0):getPositionY() + (self.levelmapcellheight - 1136) / 2 + var_54_4 + var_54_8._plotViewBtnOffsetY))
					var_48_1(var_54_2, arg_54_1 * self.curmapjsonchapternum + iter_54_0)

					local var_54_11 = patrol_manager:getPatrolInfo(var_54_2 .. "-" .. arg_54_1 * self.curmapjsonchapternum + iter_54_0)

					if var_54_11 then
						var_54_8:updateTimer(var_0_21(var_54_11.time))
					end
				end
			end
		else
			var_54_0:setVisible(false)
		end

		return var_54_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.chapterTV:registerScriptHandler(function(arg_57_0, arg_57_1)
		self.chapterTV.totalChapters = level_manager:getModeTotalChapter((level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)))

		return math.ceil(self.chapterTV.totalChapters / self.curmapjsonchapternum)
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.chapterTV:reloadData()
end

function LevelMapLayer:getMapObj()
	return (ccs.GUIReader:getInstance():widgetFromJsonFile(level_manager:getCityConf(self.curcity) .. ".json"))
end

function LevelMapLayer:updateMapJsonInfo(...)
	local var_59_0 = self:getMapObj()
	local var_59_1 = 10
	local var_59_2 = 0

	while var_59_0:getChildByName("area_" .. var_59_2 + 1) do
		var_59_2 = var_59_2 + 1
		var_59_1 = var_59_2
	end

	self.curmapjsonchapternum = var_59_1

	if ccui.Helper:seekWidgetByName(var_59_0, "Panel_cell_size") then
		self.levelmapcellheight = ccui.Helper:seekWidgetByName(var_59_0, "Panel_cell_size"):getContentSize().height or var_0_27
	end
end

function LevelMapLayer:updateShowingCells()
	local var_60_0 = {
		cellsize = cc.size(var_0_26, self.levelmapcellheight)
	}
	local var_60_1 = level_manager:getModeTotalChapter((level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)))

	if var_60_1 ~= self.chapterTV.totalChapters then
		var_60_0.maxcount = math.ceil(math.max(var_60_1, self.chapterTV.totalChapters) / self.curmapjsonchapternum)
		self.chapterTV.totalChapters = math.max(self.chapterTV.totalChapters, var_60_1)
	else
		var_60_0.maxcount = math.ceil(var_60_1 / self.curmapjsonchapternum)
	end

	local var_60_2, var_60_3 = GetTableViewShowCellIdx(self.chapterTV, var_60_0)

	for iter_60_0 = var_60_2, var_60_3 do
		self.chapterTV:updateCellAtIndex(iter_60_0)
	end

	self.chapterTV.totalChapters = var_60_1

	if not self.updatePatrolTime then
		self:scrollTableView()
	end
end

function LevelMapLayer:scrollTableView()
	local var_61_1 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)
	local var_61_2 = level_manager:getModeTotalChapter(var_61_1)
	local var_61_3 = math.max(0, (math.min(level_manager:getCurChapter(var_61_1) / var_61_2 * 100 - var_0_23 / self.levelmapcellheight / 2, 100)))

	self.chapterTV:scrollToPercent((math.ceil(var_61_2 / self.curmapjsonchapternum) == 1 or nil) and 0, nil, false)
end

function LevelMapLayer:initMapLockWord()
	self.mapLockWord = ccui.Layout:create()

	self.mapLockWord:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.mapLockWord:setAnchorPoint(cc.p(0.5, 0.5))
	self.mapLockWord:setPosition(320, GameDisplay.height / 2 - GameDisplay.fix_y)
	self.mapLockWord:setTouchEnabled(true)
	self.mapLockWord:setVisible(false)
	self:addChild(self.mapLockWord, var_0_14.LOCKWORD)

	local var_62_0 = ccui.ImageView:create("LevelMap/cover_locked.png", var_0_0)

	var_62_0:setScale9Enabled(true)
	var_62_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_62_0:setPosition(cc.p(320, GameDisplay.height / 2))
	self.mapLockWord:addChild(var_62_0)

	local var_62_1 = ccui.ImageView:create("LevelMap/wordbg.png", var_0_0)

	var_62_1:setName("mapLockWordBg")
	var_62_1:setPosition(cc.p(320, GameDisplay.height / 2))
	self.mapLockWord:addChild(var_62_1)

	local var_62_2 = ccui.ImageView:create("LevelMap/ui_lock.png", var_0_0)

	var_62_2:setAnchorPoint(cc.p(1, 0.5))
	var_62_2:setPosition(cc.p(640, GameDisplay.height / 2))
	var_62_2:setName("lockui1")
	self.mapLockWord:addChild(var_62_2)

	local var_62_3 = ccui.ImageView:create("LevelMap/ui_lock.png", var_0_0)

	var_62_3:setAnchorPoint(cc.p(0, 0.5))
	var_62_3:setPosition(cc.p(0, GameDisplay.height / 2))
	var_62_3:setFlippedY(true)
	var_62_3:setFlippedX(true)
	var_62_3:setName("lockui2")
	self.mapLockWord:addChild(var_62_3)

	local var_62_4 = ccui.Text:create(L_COMMON_WARNING.Locking, "fonts/name.ttf", 50)

	var_62_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_62_4:setPosition(cc.p(320, GameDisplay.height / 2))
	var_62_4:setName("word")
	self.mapLockWord:addChild(var_62_4)
	self.mapLockWord:addTouchEventListener(function(arg_63_0, arg_63_1)
		if arg_63_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._playingani then
			return
		end

		if not level_manager:isCityCanUnlock(self.curcity) then
			return
		end

		local function var_63_0()
			LayerManager:switchShowLayer("FightLayer")
			FightManager.openFightOnChangeChapter(function()
				GuideListener.triggerGuide(TRIGGER_UNLOCKCHAPTER)
			end)
		end

		LayerManager:pushInLayer("PopCityUnlockLayer", {
			city = self.curcity,
			successcallback = function()
				FightManager.closeFightOnChangeChapter()
				self.cityList:setScrollEnabled(false)
				LayerManager:getPlotObj():clean_all()
				self:updateCityOnUnlock()
				self:playUnlockAni(var_63_0)
				audio_manager:playeffectMusic(CITY_UNLOCK_EFFECT)
			end
		})
	end)
end

function LevelMapLayer.initCityMapChapters(arg_67_0)
	return
end

function LevelMapLayer:updateCityMapLayer(arg_71_1)
	local var_71_0 = self.curdifficuty or 1
	local var_71_1 = level_manager:getModeByDifficulty(self.curcity, var_71_0)
	local var_71_2 = level_manager:getCityConf(self.curcity)

	for iter_71_0 = 1, level_manager:getModeTotalChapter(var_71_1) do
		if level_manager:isChapterModeUnlocked(var_71_1, iter_71_0) then
			if self.timers[var_71_1 .. "-" .. iter_71_0] then
				local var_71_3 = patrol_manager:getPatrolInfo(self.timers[var_71_1 .. "-" .. iter_71_0].key)

				if not var_71_3 or var_71_3.time <= 0 then
					self.timers[var_71_1 .. "-" .. iter_71_0] = nil
				end
			else
				local var_71_4 = var_71_1 .. "-" .. iter_71_0
				local var_71_5 = patrol_manager:getPatrolState(var_71_1 .. "-" .. iter_71_0)

				if var_71_5 == 3 then
					self.timers[var_71_4] = {
						index = iter_71_0,
						key = var_71_4
					}
				elseif var_71_5 == 2 then
					-- block empty
				end
			end
		end
	end

	self.mapbg:loadTexture("CityMap/Maps/country" .. self.curcity .. ".png")
	self.chapterTV:reloadData()
	self:scrollTableView()

	if level_manager:isCityUnlocked(self.curcity, var_71_0) then
		if not self.cover then
			self:createCover()
		else
			self.cover:loadTexture("LevelMap/cover_" .. var_0_17[var_71_0] .. ".png", var_0_0)
			self.cover:setVisible(true)
		end
	elseif self.cover then
		self.cover:setVisible(false)
	end

	self:updateSpecialChapter()

	if not arg_71_1 then
		self:updateMapLockWord(self.curcity, var_71_0)
	end
end

function LevelMapLayer:updateMapLockWord(arg_72_1, arg_72_2)
	if level_manager:isCityUnlocked(arg_72_1, arg_72_2) then
		self.mapLockWord:setVisible(false)

		return
	end

	self.mapLockWord:setVisible(true)

	if level_manager:isCityCanUnlock(arg_72_1) then
		self.mapLockWord:getChildByName("word"):setString(L_MAP_CITY_CHAPTERS.Can_Unlock)
		self.mapLockWord:getChildByName("word"):setFontSize(50)
		self.mapLockWord:getChildByName("lockui1"):loadTexture("LevelMap/ui_canlock.png", var_0_0)
		self.mapLockWord:getChildByName("lockui2"):loadTexture("LevelMap/ui_canlock.png", var_0_0)
	else
		local var_72_0 = tonumber(level_manager:getPremode((level_manager:getModeByCity(arg_72_1, self.finaldifficuty))))

		self.mapLockWord:getChildByName("word"):setString(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(var_72_0 * 1000 + level_manager:getModeTotalChapter(var_72_0))))
		self.mapLockWord:getChildByName("word"):setFontSize(36)
		self.mapLockWord:getChildByName("lockui1"):loadTexture("LevelMap/ui_lock.png", var_0_0)
		self.mapLockWord:getChildByName("lockui2"):loadTexture("LevelMap/ui_lock.png", var_0_0)
	end
end

function LevelMapLayer:updateCityMapOnSelectDifficulty()
	local var_73_0 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty)

	if self.cover then
		self.cover:loadTexture("LevelMap/cover_" .. var_0_17[self.curdifficuty] .. ".png", var_0_0)
		self.cover:setScaleX(640 / self.cover:getContentSize().width)
	end

	self.chapterTV:reloadData()
	self:scrollTableView()
	self:updateSpecialChapter()
end

function LevelMapLayer.updateChapters(arg_74_0, arg_74_1, arg_74_2)
	return
end

function LevelMapLayer:playSelectCityAni()
	self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), GameDisplay.width, GameDisplay.height)

	self.anicover:setPosition(0, -GameDisplay.fix_y)
	self:addChild(self.anicover, var_0_14.COVER)

	self._playingani = true

	self:removeGuidesOnLayer()
	self.anicover:runAction(cc.Sequence:create(cc.FadeIn:create(0.4), cc.DelayTime:create(0.5), cc.RemoveSelf:create()))
	self.maplayer:runAction(cc.MoveBy:create(0.4, cc.p(0, 8)))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self:cleanAllTimers()
		self:updateUIInfos()
		self:updateCityMapLayer()
		self:playShowCityAni()
	end)))
end

function LevelMapLayer:playShowCityAni()
	if not self.anicover then
		self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 255), GameDisplay.width, GameDisplay.height)

		self.anicover:setPosition(0, -GameDisplay.fix_y)
		self:addChild(self.anicover, var_0_14.COVER)
	end

	self.anicover:runAction(cc.Sequence:create(cc.FadeOut:create(0.4), cc.RemoveSelf:create()))

	self.anicover = nil

	self.maplayer:setPosition(cc.p(0, 8))
	self.maplayer:runAction(cc.MoveBy:create(0.4, cc.p(0, -8)))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self._playingani = false

		self:updateGuidesOnLayer()
	end)))
end

function LevelMapLayer:playInitShowAni()
	self.maplayer:setVisible(false)

	self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), GameDisplay.width, GameDisplay.height)

	self.anicover:setPosition(0, -GameDisplay.fix_y)
	self:addChild(self.anicover, var_0_14.COVER)

	self._playingani = true

	self.anicover:runAction(cc.Sequence:create(cc.FadeIn:create(0.4), cc.DelayTime:create(0.5), cc.RemoveSelf:create()))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self.maplayer:setVisible(true)
		self:playShowCityAni()
	end)))
end

function LevelMapLayer:playSelectDifficultyAni()
	local var_81_0 = cc.Layer:create()

	self:addChild(var_81_0, var_0_14.DIFFICULTYANI)

	local var_81_1

	if config._DEBUG then
		var_81_1 = cc.Scale9Sprite:create("LevelMap/colorcover" .. self.curdifficuty .. ".png") or cc.Scale9Sprite:createWithSpriteFrameName("LevelMap/colorcover" .. self.curdifficuty .. ".png")
	end

	var_81_1:setCapInsets(cc.rect(20, 20, 20, 20))
	var_81_1:setPreferredSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_81_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_81_1:setPosition(cc.p(320, 568))
	var_81_1:setOpacity(0)
	var_81_0:addChild(var_81_1)

	local var_81_2 = cc.Layer:create()

	var_81_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.RemoveSelf:create()))
	self:addChild(var_81_2, var_0_14.DIFFICULTYANI)

	self._playingani = true

	self:removeGuidesOnLayer()
	var_81_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.RemoveSelf:create()))
	var_81_1:runAction(cc.Sequence:create(cc.FadeIn:create(0.2), cc.DelayTime:create(0.2), cc.FadeOut:create(0.2)))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
		self:cleanAllTimers()
		self:updateCityMapOnSelectDifficulty()
	end)))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.CallFunc:create(function()
		self._playingani = false

		self:updateGuidesOnLayer()
	end)))
end

function LevelMapLayer:playExitAni()
	self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), GameDisplay.width, GameDisplay.height)

	self.anicover:setPosition(0, -GameDisplay.fix_y)
	self:addChild(self.anicover, var_0_14.COVER)

	self._playingani = true

	self.anicover:runAction(cc.Sequence:create(cc.FadeIn:create(0.4), cc.DelayTime:create(0.5), cc.RemoveSelf:create()))
	self.maplayer:runAction(cc.MoveBy:create(0.4, cc.p(0, 8)))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		if not level_manager:isPlayerPassLevel(2010) then
			LayerManager:switchShowLayer("FightLayer")
		else
			KeyCodeManager:onKeyReleasedCallFunc()
		end
	end)))
end

function LevelMapLayer:playUnlockAni(arg_86_1)
	self._playingani = true

	audio_manager:playeffectMusic(DORM_UNLOCK_ROOM)
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("mapeffect/jiesuotexiao.ExportJson")
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("mapeffect/dianwei.ExportJson")
	self.mapLockWord:getChildByName("word"):setVisible(false)
	self.mapLockWord:getChildByName("lockui1"):setVisible(false)
	self.mapLockWord:getChildByName("lockui2"):setVisible(false)
	self.mapLockWord:getChildByName("mapLockWordBg"):setVisible(false)

	local var_86_0 = ccs.Armature:create("jiesuotexiao")

	var_86_0:setPosition(cc.p(320, 568))
	self:addChild(var_86_0, 10)
	var_86_0:getAnimation():play("Animation1")
	var_86_0:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
		self:updateUIInfos()
		self:updateCityMapLayer(true)
	end)))
	var_86_0:runAction(cc.Sequence:create(cc.DelayTime:create(2.6666666666666665), cc.CallFunc:create(function()
		self.mapLockWord:setVisible(false)
		self.mapLockWord:getChildByName("word"):setVisible(true)
		self.mapLockWord:getChildByName("lockui1"):setVisible(true)
		self.mapLockWord:getChildByName("lockui2"):setVisible(true)
		self.mapLockWord:getChildByName("mapLockWordBg"):setVisible(true)
	end), cc.RemoveSelf:create()))

	local var_86_1 = ccs.Armature:create("dianwei")

	var_86_1:setPosition(cc.p(320, 568 + GameDisplay.fix_y))
	var_86_1:setVisible(false)
	self:addChild(var_86_1, 10)
	var_86_1:runAction(cc.Sequence:create(cc.DelayTime:create(2.8333333333333335), cc.Show:create(), cc.CallFunc:create(function()
		var_86_1:getAnimation():play("Animation1")
	end), cc.DelayTime:create(1), cc.CallFunc:create(function()
		if arg_86_1 then
			arg_86_1()
		end
	end), cc.RemoveSelf:create()))
end

function LevelMapLayer:playUnlockCityTalk()
	local var_91_0 = level_manager:getUnlockCityTalk(self.curcity)

	if not var_91_0 then
		return
	end

	global_basic_scene:addChild(TalkLayer:create(var_91_0, nil, talktype, "", TALK_TYPE_BEFORE_BOSS, 1), ZORDER_TALKLAYER)
end

function LevelMapLayer.loadBasicUIAssets(arg_92_0)
	return
end

function LevelMapLayer.unloadBasicUIAssets(arg_94_0)
	return
end

function LevelMapLayer.removeGuidesOnLayer(arg_95_0)
	if LayerManager:getCurrentLayerName() ~= "LevelMapLayer" then
		return
	end

	GuideListener.lockGuideTrigger(true)
	GuideListener.cleanCurGuides()
end

function LevelMapLayer.updateGuidesOnLayer(arg_96_0)
	if LayerManager:getCurrentLayerName() ~= "LevelMapLayer" then
		return
	end

	LayerManager:updateGuidesOnSwitchLayer()
end

function LevelMapLayer:refreshGuidesOnLevelMap()
	if LayerManager:getCurrentLayerName() ~= "LevelMapLayer" then
		return
	end

	self:removeGuidesOnLayer()
	self:updateGuidesOnLayer()
end

function LevelMapLayer:getCurCity()
	return self.curcity
end

function LevelMapLayer:initSpecialChapter()
	local var_99_0 = ccui.Button:create("LevelMap/level_sp.png", "LevelMap/level_sp.png", "LevelMap/level_sp.png", var_0_0)

	var_99_0:setVisible(false)
	var_99_0:setName("chapter_sp")
	var_99_0:setPressedActionEnabled(true)
	var_99_0:setAnchorPoint(cc.p(0.5, 0))
	self.maplayer:addChild(var_99_0)

	local var_99_1 = cc.Label:createWithTTF(L_SPECIAL_ACTION, "fonts/name.ttf", 27)

	var_99_1:setAnchorPoint(cc.p(0.5, 0))
	var_99_1:setPosition(cc.p(var_99_0:getContentSize().width / 2, var_99_0:getContentSize().height / 2 - 10))
	var_99_1:setName("name")
	var_99_0:addChild(var_99_1)

	local var_99_2 = ccui.ImageView:create("LevelMap/frame_drop.png", var_0_0)

	var_99_2:setVisible(false)
	var_99_2:setPosition(cc.p(var_99_0:getContentSize().width / 2 + 120, var_99_0:getContentSize().height / 2 + 25))
	var_99_2:setName("drop")
	var_99_0:addChild(var_99_2)

	local var_99_3 = ccui.ImageView:create("LevelMap/img_unknow_drop.png", var_0_0)

	var_99_3:setPosition(cc.p(var_99_2:getContentSize().width / 2, var_99_2:getContentSize().height / 2))
	var_99_3:setName("dropimg")
	var_99_2:addChild(var_99_3)

	local var_99_4 = ccui.ImageView:create("public/box/1.png", var_0_0)

	var_99_4:setVisible(false)
	var_99_4:setScale(var_99_3:getContentSize().width / var_99_4:getContentSize().width)
	var_99_4:setPosition(cc.p(var_99_0:getContentSize().width / 2 + 120, var_99_0:getContentSize().height / 2 + 25))
	var_99_4:setName("item")
	var_99_0:addChild(var_99_4)
	var_99_4:setTouchEnabled(true)

	local var_99_5 = ccui.ImageView:create("equipment/1000000.png")

	var_99_5:setScale(var_99_4:getContentSize().width / var_99_5:getContentSize().width)
	var_99_5:setPosition(var_99_4:getContentSize().width / 2, var_99_4:getContentSize().height / 2)
	var_99_5:setName("icon")
	var_99_4:addChild(var_99_5)

	local var_99_6 = ccui.ImageView:create("LevelMap/img_curtag.png", var_0_0)

	var_99_6:setAnchorPoint(cc.p(0.5, 0))
	var_99_6:setPosition(cc.p(var_99_0:getContentSize().width / 2, var_99_0:getContentSize().height + 15))
	var_99_6:setVisible(false)
	var_99_6:setName("curtag")
	var_99_0:addChild(var_99_6)

	local var_99_7 = ccui.ImageView:create("LevelMap/img_tag_can_patrol.png", var_0_0)

	var_99_7:setAnchorPoint(cc.p(0, 0))
	var_99_7:setPosition(cc.p(35, 80))
	var_99_7:setVisible(false)
	var_99_7:setName("newtag")
	var_99_0:addChild(var_99_7)

	local var_99_8 = ccui.ImageView:create("LevelMap/img_tagcomplete.png", var_0_0)

	var_99_8:setAnchorPoint(cc.p(0, 0))
	var_99_8:setPosition(cc.p(35, 80))
	var_99_8:setVisible(false)
	var_99_8:setName("completetag")
	var_99_0:addChild(var_99_8)

	local var_99_9 = cc.Label:createWithTTF("00:00", FONT_DES, 25)

	var_99_9:setVisible(false)
	var_99_9:setAnchorPoint(cc.p(0, 0))
	var_99_9:setPosition(cc.p(42, 88))
	var_99_9:setName("timer")
	var_99_0:addChild(var_99_9)

	local function var_99_10(arg_100_0, arg_100_1)
		if arg_100_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("::::")
	end

	var_99_0:addTouchEventListener(var_99_10)
	var_99_4:addTouchEventListener(var_99_10)

	self.spchapter = var_99_0
end

function LevelMapLayer:updateSpecialChapter()
	if not self.maplayer:getChildByName("area_sp") then
		local var_101_0 = ccui.ImageView:create("CityMap/Maps/countryR.png")

		var_101_0:setPosition(cc.p(220, 300))
		var_101_0:setName("area_sp")
		self.maplayer:addChild(var_101_0)
	end

	local var_101_1 = self.maplayer:getChildByName("area_sp")

	if var_101_1 then
		local var_101_2, var_101_3 = var_101_1:getPosition()

		self.spchapter:setPosition(cc.p(var_101_2 - 7, var_101_3 - 10))
		var_101_1:setVisible(false)
	else
		self.spchapter:setPosition(320, 400)
	end

	self.spchapter.mark_bg = var_101_1

	self.spchapter:setVisible(false)

	if self.spchapter:getChildByName("plotCloneUI") then
		self.spchapter:getChildByName("plotCloneUI"):setVisible(false)
	end

	LayerManager:getPlotObj():levelmapUpdataPlotShow("LevelMapLayer" .. self.curcity)
end

function LevelMapLayer:initRankUI()
	self.rankBnt = ccui.Button:create("LevelMap/rank_bnt.png", nil, "LevelMap/rank_bnt.png", var_0_0)

	self.rankBnt:setAnchorPoint(cc.p(0, 1))
	self.rankBnt:setPosition(6, GameDisplay.height - GameDisplay.fix_y - self.cityTitle:getContentSize().height - self.starReward:getContentSize().height)
	self.rankBnt:setVisible(self.curdifficuty == 4)
	self.uilayer:addChild(self.rankBnt)
	self.rankBnt:addTouchEventListener(function(arg_103_0, arg_103_1)
		if arg_103_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curdifficuty ~= 4 then
			return
		end

		local var_103_0 = {}

		var_103_0.mode = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 4)

		LayerManager:pushInLayer("LevelRankListLayer", var_103_0)
	end)
	self:updateRankUI()
end

function LevelMapLayer:updateRankUI()
	if self.curdifficuty == 4 and self.curcity ~= 9 and self.curcity ~= 10 then
		self.rankBnt:setVisible(true)
	else
		self.rankBnt:setVisible(false)
	end
end

function LevelMapLayer:initStarRewardUI()
	self.starReward = ccui.Button:create("LevelMap/star_reward.png", nil, "LevelMap/star_reward.png", var_0_0)

	self.starReward:setAnchorPoint(cc.p(0, 1))
	self.starReward:setPosition(6, GameDisplay.height - GameDisplay.fix_y - self.cityTitle:getContentSize().height + 30)
	self.starReward:setName("Button_starReward")
	self.uilayer:addChild(self.starReward)

	local var_105_0 = ccui.ImageView:create("LevelMap/star_icon.png", var_0_0)

	var_105_0:setPosition(65, 48)
	self.starReward:addChild(var_105_0)

	self.taskReward = ccui.Button:create("LevelMap/task_reward.png", nil, "LevelMap/task_reward.png", var_0_0)

	self.taskReward:setAnchorPoint(cc.p(0, 1))
	self.taskReward:setPosition(0, self.starReward:getPositionY() - self.starReward:getContentSize().height - 10 + 42)
	self.taskReward:setName("Button_taskReward")
	self.uilayer:addChild(self.taskReward)
	self.taskReward:addTouchEventListener(function(arg_106_0, arg_106_1)
		if arg_106_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not require("data.plot_class_data")[level_manager:get_mode_task_reward((level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)))] then
			return
		end

		LayerManager:pushInLayer("TopPlotListLayer", {
			taskType = 1
		})
	end)

	local var_105_1 = level_manager:get_mode_task_reward((level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)))

	if not var_105_1 then
		self.taskReward:setVisible(false)
	elseif PlotManager:check_plot_is_finished_by_plotclassid(var_105_1) then
		self.taskReward:setVisible(false)
	end

	local var_105_2 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)

	self.total_star_label = cc.Label:createWithTTF(level_manager:getModeTotalStars(var_105_2) .. "/" .. level_manager:getModeTotalChapter(var_105_2) * 3, FONT_NAME, 14)

	self.total_star_label:setAnchorPoint(cc.p(0, 0.5))
	self.total_star_label:setPosition(80, 48)
	self.starReward:addChild(self.total_star_label)

	local var_105_3 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

	var_105_3:setName("reddot")
	var_105_3:setPosition(5, self.starReward:getContentSize().height - 40)
	var_105_3:setVisible(false)
	self.starReward:addChild(var_105_3)
	self.starReward:addTouchEventListener(function(arg_107_0, arg_107_1)
		if arg_107_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopStarRewardLayer", {
			mode = var_105_2,
			updateCallback = function()
				if not var_0_20 then
					return
				end

				self:updateStarRewardUI()
				self:updateCityBntTips(self.curcity, self.curdifficuty or 1)
			end
		})
	end)

	if level_manager:checkIsNewStarReward(var_105_2) then
		self.starReward:getChildByName("reddot"):setVisible(true)
	else
		self.starReward:getChildByName("reddot"):setVisible(false)
	end
end

function LevelMapLayer:updateStarRewardUI()
	local var_109_1 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)

	self.total_star_label:setString(level_manager:getModeTotalStars(var_109_1) .. "/" .. level_manager:getModeTotalChapter(var_109_1) * 3)
	self.starReward:addTouchEventListener(function(arg_110_0, arg_110_1)
		if arg_110_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopStarRewardLayer", {
			mode = var_109_1,
			updateCallback = function()
				if not var_0_20 then
					return
				end

				self:updateStarRewardUI()
				self:updateCityBntTips(self.curcity, self.curdifficuty or 1)
			end
		})
	end)

	if level_manager:checkIsNewStarReward(var_109_1) then
		self.starReward:getChildByName("reddot"):setVisible(true)
	else
		self.starReward:getChildByName("reddot"):setVisible(false)
	end
end

function LevelMapLayer:updateTaskRewardUI()
	self.taskReward:setVisible(true)

	local var_112_0 = level_manager:get_mode_task_reward((level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)))

	if var_112_0 then
		local var_112_1 = ""

		for iter_112_0, iter_112_1 in pairs(require("controller.drop_manager"):getDropMsg(require("data.plot_class_data")[var_112_0].drop).equips) do
			if iter_112_1.dropid == 6800101 then
				var_112_1 = iter_112_1.dropNum
			end
		end

		if var_112_1 ~= "" then
			self.taskReward:loadTextures("LevelMap/task_reward_" .. var_112_1 .. ".png", nil, "LevelMap/task_reward_" .. var_112_1 .. ".png", var_0_0)
		end

		if PlotManager:check_plot_is_finished_by_plotclassid(var_112_0) then
			self.taskReward:setVisible(false)
		end
	else
		self.taskReward:setVisible(false)
	end
end

function LevelMapLayer:createCover()
	if not self.curdifficuty then
		return
	end

	self.cover = ccui.ImageView:create("LevelMap/cover_" .. var_0_17[self.curdifficuty] .. ".png", var_0_0)

	self.cover:setAnchorPoint(cc.p(0.5, 0))
	self.cover:setPosition(cc.p(320, -GameDisplay.fix_y))
	self.cover:setScaleX(640 / self.cover:getContentSize().width)
	self.cover:setName("colorcover")
	self:addChild(self.cover, var_0_14.COVER)
end

function LevelMapLayer:updateBossImg()
	local var_114_0 = self.curcity == level_manager:getCurFightCity() and level_manager:getCurMainFightDifficulty() or 1

	if var_114_0 and not level_manager:isOnlyCityDifficultyValid(self.curcity, var_114_0) then
		var_114_0 = level_manager:getUnlockedDifficultyInCity(self.curcity)
	end

	local var_114_1 = level_manager:getModeByDifficulty(self.curcity, var_114_0)

	if not self.bossimg then
		self.bossimg = ccui.ImageView:create("GUI/image.png", var_0_0)

		self:addChild(self.bossimg, var_0_14.BOSSIMG)

		local var_114_2 = ccui.Layout:create()

		var_114_2:setTouchEnabled(true)
		var_114_2:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
		var_114_2:setAnchorPoint(cc.p(0, 0))
		var_114_2:setPosition(cc.p(0, -GameDisplay.fix_y))
		var_114_2:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_114_2:setBackGroundColor(cc.c3b(0, 0, 0))
		self:addChild(var_114_2, -10)
	end

	local var_114_3, var_114_4, var_114_5, var_114_6, var_114_7, var_114_8, var_114_9, var_114_10 = level_manager:get_mode_bossimg(var_114_1)

	self.bossimg:loadTexture("roleimage/role/" .. var_114_3 .. ".png")
	self.bossimg:setPositionX(tonumber(string.split(var_114_4, ",")[1]) + tonumber(string.split(var_114_5, ",")[1]))
	self.bossimg:setPositionY(tonumber(string.split(var_114_4, ",")[2]) + tonumber(string.split(var_114_5, ",")[2]) + GameDisplay.fix_y)
	self.bossimg:setScale(var_114_6)
end

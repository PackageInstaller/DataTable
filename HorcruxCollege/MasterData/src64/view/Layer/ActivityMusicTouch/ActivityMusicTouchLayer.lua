ActivityMusicTouchLayer = class("ActivityMusicTouchLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local Utility = require("common.Utility")
local item_data = require("data.item_data")
local time_check_manager = require("controller.time_check_manager")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local musicTouch_gamelogic_manager = require("controller.musicTouch_gamelogic_manager")
local var_0_8 = 1
local var_0_9 = 2
local var_0_10 = require("view.Layer.ObjectPool"):new()

function var_0_10:getObjectByMyType(arg_2_1, arg_2_2, ...)
	local var_2_0 = self:getObject(arg_2_1)

	if var_2_0 then
		return var_2_0
	else
		local var_2_1 = arg_2_2:create(...)

		var_2_1.type = arg_2_1

		self:createObject(var_2_1)
	end

	return self:getObject(arg_2_1)
end

function var_0_10:clearAllActiveObject()
	for iter_3_0, iter_3_1 in pairs(self.activePool) do
		iter_3_1.isActive = false

		iter_3_1:setVisible(false)
	end

	self.activePool = {}
end

function ActivityMusicTouchLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = ActivityMusicTouchLayer.new()

	var_4_0:init(arg_4_1)

	return var_4_0
end

function ActivityMusicTouchLayer:init(arg_5_1)
	self.activityId = arg_5_1.activityId
	self.layerName = "ActivityMusicTouchLayer_" .. self.activityId
	self.respath = "ActivityMusicTouchLayer_" .. self.activityId .. "/"

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerActivityEventListener()
	musicTouch_gamelogic_manager:registerUIRef(self)
	self:registerGameEvent()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			musicTouch_gamelogic_manager:exitGame()
			activity_manager:releaseEventListenerByName(self.layerName)
			TextureManager:removeLayerTextures({
				self.layerName
			})
		end
	end)
	self:fullScreen()
end

function ActivityMusicTouchLayer.registerActivityEventListener(arg_7_0)
	return
end

function ActivityMusicTouchLayer:initUI()
	self.title = self.rootLayer:getChildByName("title")
	self.score_bg = self.rootLayer:getChildByName("score_bg")
	self.score_label = self.score_bg:getChildByName("score_label")

	self.score_label:setString("0")

	self.shop_btn = self.rootLayer:getChildByName("btn_shop")
	self.task_btn = self.rootLayer:getChildByName("btn_task")

	self.task_btn:setPosition(self.shop_btn:getPosition())
	self.shop_btn:setVisible(false)

	self.bottom = self.rootLayer:getChildByName("bottom")
	self.return_btn = self.bottom:getChildByName("btn_return")
	self.switch_difficulty_btn = self.bottom:getChildByName("switch_difficulty_btn")
	self.combo = self.rootLayer:getChildByName("combo")
	self.combo_label = self.combo:getChildByName("combo_label")
	self.progress_off = self.rootLayer:getChildByName("progress_off")
	self.progress_icon = self.rootLayer:getChildByName("progress_icon")
	self.game_panel_big = self.rootLayer:getChildByName("game_panel_big")
	self.game_panel_small = self.rootLayer:getChildByName("game_panel_small")
	self.game_panel_big = self.rootLayer:getChildByName("game_panel_big")
	self.game_panel_small = self.rootLayer:getChildByName("game_panel_small")
	self.start_btn = self.rootLayer:getChildByName("start_btn")
	self.time_bg = self.rootLayer:getChildByName("time_bg")
	self.time_label = self.time_bg:getChildByName("time_label")

	self.time_bg:setVisible(false)
	self.combo:setVisible(false)
	self.combo_label:setString("0")

	for iter_8_0, iter_8_1 in pairs(self.game_panel_big:getChildren()) do
		iter_8_1:getChildByName("channel_on"):setVisible(false)
		iter_8_1:loadTextures(self.respath .. "big_touch_off_btn.png", nil, self.respath .. "big_touch_off_btn.png", var_0_0)
		iter_8_1:getChildByName("judging_panel"):loadTexture(self.respath .. "big_judging_panel_off.png", var_0_0)

		local var_8_0 = ccui.Layout:create()

		var_8_0:setContentSize(iter_8_1:getContentSize().width, iter_8_1:getChildByName("channel_on"):getContentSize().height - iter_8_1:getContentSize().height)
		var_8_0:setPosition(0, iter_8_1:getContentSize().height)
		var_8_0:setClippingEnabled(true)
		var_8_0:setAnchorPoint(cc.p(0, 0))

		iter_8_1.channel_layout = var_8_0

		iter_8_1:addChild(var_8_0, 1)

		iter_8_1.objPool = var_0_10:new()

		local var_8_1 = tonumber(string.match(iter_8_1:getName(), "channel_touch_(%d+)$"))

		iter_8_1:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 == ccui.TouchEventType.began or arg_9_1 == ccui.TouchEventType.moved then
				self:channelTouch(var_8_1, true)
			else
				self:channelTouch(var_8_1, false)
			end

			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			musicTouch_gamelogic_manager:MusicChannelTouch(var_8_1)
		end)
	end

	for iter_8_2, iter_8_3 in pairs(self.game_panel_small:getChildren()) do
		iter_8_3:getChildByName("channel_on"):setVisible(false)
		iter_8_3:loadTextures(self.respath .. "small_touch_off_btn.png", nil, self.respath .. "small_touch_off_btn.png", var_0_0)
		iter_8_3:getChildByName("judging_panel"):loadTexture(self.respath .. "small_judging_panel_off.png", var_0_0)

		local var_8_2 = ccui.Layout:create()

		var_8_2:setContentSize(iter_8_3:getContentSize().width, iter_8_3:getChildByName("channel_on"):getContentSize().height - iter_8_3:getContentSize().height)
		var_8_2:setPosition(0, iter_8_3:getContentSize().height)
		var_8_2:setClippingEnabled(true)
		var_8_2:setAnchorPoint(cc.p(0, 0))

		iter_8_3.channel_layout = var_8_2

		iter_8_3:addChild(var_8_2, 1)

		iter_8_3.objPool = var_0_10:new()

		local var_8_3 = tonumber(string.match(iter_8_3:getName(), "channel_touch_(%d+)$"))

		iter_8_3:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 == ccui.TouchEventType.began or arg_10_1 == ccui.TouchEventType.moved then
				self:channelTouch(var_8_3, true)
			else
				self:channelTouch(var_8_3, false)
			end

			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			musicTouch_gamelogic_manager:MusicChannelTouch(var_8_3)
		end)
	end

	self.game_panel_big:setVisible(false)
	self.game_panel_small:setVisible(false)

	self.curPannel = self:getCurPanel()

	self.curPannel:setVisible(true)
	self.title:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityMusicTouchLayer_" .. self.activityId
		})
	end)
	self.switch_difficulty_btn:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		musicTouch_gamelogic_manager:switch_difficulty()
		self.curPannel:setVisible(false)

		self.curPannel = self:getCurPanel()

		self.curPannel:setVisible(true)
	end)
	self.return_btn:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.task_btn:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityGameTaskLayer", {
			uiconfmodule = "musicTouch",
			activityId = self.activityId
		})
	end)
	self.shop_btn:addTouchEventListener(function(arg_15_0, arg_15_1)
		local var_15_0

		if arg_15_1 ~= ccui.TouchEventType.ended then
			do return end

			var_15_0 = {}
		end

		var_15_0[1] = "1-" .. tonumber(require("data.musicialnote_conf")[self.activityId].shop) % 1500000

		LayerManager:switchShowLayer("MarketLayer", {
			singleMarket = var_15_0,
			showType = var_15_0[1]
		})
	end)
	self.start_btn:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		musicTouch_gamelogic_manager:gameStart()
		self.time_bg:setVisible(true)
		self.start_btn:setVisible(false)
	end)

	self.progress = ccui.Slider:create()

	self.progress:loadBarTexture(self.respath .. "progress_bg.png", var_0_0)
	self.progress:loadProgressBarTexture(self.respath .. "progress_on.png", var_0_0)
	self.progress:setPosition(320, self.progress_off:getPositionY() - 5)
	self.progress:setPercent(0)
	self.rootLayer:addChild(self.progress)

	self.progress_spine = sp.SkeletonAnimation:create("spine/bakery/zhou2.json", "spine/bakery/zhou2.atlas", 1)

	self.progress_spine:setAnimation(0, "di", true)
	self.rootLayer:addChild(self.progress_spine)
	self.progress_spine:setVisible(false)
end

function ActivityMusicTouchLayer:getCurPanel()
	if not musicTouch_gamelogic_manager.mode then
		return self.game_panel_big
	end

	return (musicTouch_gamelogic_manager.mode == var_0_8 or nil) and (self.game_panel_big or self.game_panel_small)
end

function ActivityMusicTouchLayer.registerGameEvent(arg_18_0)
	musicTouch_gamelogic_manager:registerGameEvent("CHANNEL_ADD_NOTE", arg_18_0, function(arg_19_0, arg_19_1)
		local var_19_0 = arg_18_0:getCurPanel():getChildByName("channel_touch_" .. arg_19_1.index)
		local var_19_1 = var_19_0.objPool:getObjectByMyType("note", ccui.ImageView, arg_18_0.respath .. "note1.png", var_0_0)

		var_19_1:loadTexture(arg_18_0.respath .. "note" .. arg_19_1.value.type .. ".png", var_0_0)

		if not var_19_1:getParent() then
			var_19_0.channel_layout:addChild(var_19_1)
		end

		var_19_1:setPosition(var_19_0.channel_layout:getContentSize().width / 2, arg_19_1.value.pos_y)

		if musicTouch_gamelogic_manager.mode == var_0_9 then
			var_19_1:setScale(0.5)
		end

		arg_19_1.value.node = var_19_1
	end)
	musicTouch_gamelogic_manager:registerGameEvent("CHANNEL_DELETE_NOTE", arg_18_0, function(arg_20_0, arg_20_1)
		local var_20_0 = arg_18_0:getCurPanel():getChildByName("channel_touch_" .. arg_20_1.index)

		var_20_0.objPool:recycleObject(arg_20_1.value.node)

		if arg_20_1.show then
			local var_20_1 = var_20_0.objPool:getObjectByMyType("spine", sp.SkeletonAnimation, "spine/bakery/zhou2.json", "spine/bakery/zhou2.atlas", 1)

			var_20_1:setAnimation(0, arg_20_1.show, true)
			var_20_1:setPosition(arg_20_1.value.node:getPositionX(), arg_20_1.value.node:getPositionY() + 150)
			var_20_1:registerSpineEventHandler(function()
				var_20_0.objPool:recycleObject(var_20_1)
			end, SP_ANIMATION_COMPLETE)

			if not var_20_1:getParent() then
				var_20_0:addChild(var_20_1, 3)
			end
		end
	end)
	musicTouch_gamelogic_manager:registerGameEvent("GAME_END", arg_18_0, function(arg_22_0, arg_22_1)
		for iter_22_0, iter_22_1 in pairs(arg_18_0.game_panel_big:getChildren()) do
			iter_22_1.objPool:clearAllActiveObject()
		end

		for iter_22_2, iter_22_3 in pairs(arg_18_0.game_panel_small:getChildren()) do
			iter_22_3.objPool:clearAllActiveObject()
		end

		arg_18_0.start_btn:setVisible(true)
		arg_18_0.time_bg:setVisible(false)

		if arg_22_1.score and arg_22_1.score > 0 and arg_22_1.mode and arg_22_1.max_combo then
			activity_manager:activity_smallgame_data_report(arg_18_0.activityId, {
				score = arg_22_1.score,
				mode = arg_22_1.mode,
				max_combo = arg_22_1.max_combo,
				gametype = ACTIVITY_SMALLGAME_TYPE_MUSICTOUCH
			})
		end
	end)
	musicTouch_gamelogic_manager:registerGameEvent("UPDATE_GAMEDATA", arg_18_0, function(arg_23_0, arg_23_1)
		if arg_23_1.combo and arg_23_1.combo >= 3 then
			arg_18_0.combo:setVisible(true)
			arg_18_0.combo_label:setString(arg_23_1.combo)
		else
			arg_18_0.combo:setVisible(false)
		end

		if arg_23_1.progress_total and arg_23_1.progress_current then
			arg_18_0.progress:setPercent(100 * arg_23_1.progress_current / arg_23_1.progress_total)
		end

		if arg_23_1.time then
			arg_18_0.time_label:setString(math.ceil(arg_23_1.time))
		end

		if arg_23_1.inSpeacialTime then
			arg_18_0.progress_spine:setVisible(true)
		else
			arg_18_0.progress_spine:setVisible(false)
		end

		arg_18_0.score_label:setString(arg_23_1.score)
	end)
end

function ActivityMusicTouchLayer:channelTouch(arg_24_1, arg_24_2)
	local var_24_0

	if musicTouch_gamelogic_manager.mode == var_0_8 then
		var_24_0 = self.game_panel_big or self.game_panel_small
	end

	local var_24_1 = musicTouch_gamelogic_manager.mode == var_0_8 and "big" or "small"
	local var_24_2 = var_24_0:getChildByName("channel_touch_" .. arg_24_1)

	var_24_2:getChildByName("channel_on"):setVisible(arg_24_2)

	if arg_24_2 then
		var_24_2:loadTextures(self.respath .. var_24_1 .. "_touch_on_btn.png", nil, self.respath .. var_24_1 .. "_touch_on_btn.png", var_0_0)
		var_24_2:getChildByName("judging_panel"):loadTexture(self.respath .. var_24_1 .. "_judging_panel_on.png", var_0_0)
	else
		var_24_2:loadTextures(self.respath .. var_24_1 .. "_touch_off_btn.png", nil, self.respath .. var_24_1 .. "_touch_off_btn.png", var_0_0)
		var_24_2:getChildByName("judging_panel"):loadTexture(self.respath .. var_24_1 .. "_judging_panel_off.png", var_0_0)
	end
end

function ActivityMusicTouchLayer:fullScreen()
	self.title:setPositionY(self.title:getPositionY() + GameDisplay.fix_y)
	self.score_bg:setPositionY(self.score_bg:getPositionY() + GameDisplay.fix_y)
	self.shop_btn:setPositionY(self.shop_btn:getPositionY() + GameDisplay.fix_y)
	self.task_btn:setPositionY(self.task_btn:getPositionY() + GameDisplay.fix_y)
	self.combo:setPositionY(self.combo:getPositionY() + GameDisplay.fix_y)
	self.time_bg:setPositionY(self.time_bg:getPositionY() + GameDisplay.fix_y)
	self.bottom:setPositionY(self.bottom:getPositionY() - GameDisplay.fix_y)
	self.progress_off:setPositionY(self.progress_off:getPositionY() - GameDisplay.fix_y)
	self.progress_icon:setPositionY(self.progress_icon:getPositionY() - GameDisplay.fix_y)
	self.progress:setPositionY(self.progress:getPositionY() - GameDisplay.fix_y)
	self.progress_spine:setPosition(self.progress:getPositionX(), self.progress:getPositionY() - 5)
end

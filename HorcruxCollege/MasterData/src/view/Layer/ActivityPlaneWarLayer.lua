ActivityPlaneWarLayer = class("ActivityPlaneWarLayer", function()
	return ccui.Layout:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local jumpgame_conf_data = require("data.jumpgame_conf_data")
local item_data = require("data.item_data")
local ObjectPool = require("view.Layer.ObjectPool")
local L2Actor = require("view.Sprite.L2Actor")
local drop_manager = require("controller.drop_manager")
local network = require("network.network")
local var_0_9 = "ActivityPlaneWarLayer/"
local var_0_10 = 570
local var_0_11 = 140
local var_0_12 = 0.4
local var_0_13 = 3.3
local var_0_14 = 400
local var_0_15 = 600
local var_0_16 = 250
local var_0_17 = 375
local var_0_18 = 0.4
local var_0_19 = 200

function ActivityPlaneWarLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityPlaneWarLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityPlaneWarLayer:init(arg_3_1)
	self.rootlayer = cc.Layer:create()

	self:addChild(self.rootlayer)

	if arg_3_1 then
		self.activityid = arg_3_1.activityid or 550
	end

	self.invincable = false

	self:initData()

	self.skills = {}

	self:initReward(function()
		self:initUI()
	end)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			if self.scheduleid then
				for iter_5_0, iter_5_1 in pairs(self.scheduleid) do
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(iter_5_1)
				end
			end

			self:updateScore(self.curScore)
		end
	end)
end

function ActivityPlaneWarLayer:initData()
	self.data = {}

	if jumpgame_conf_data[self.activityid .. "_planegame"] then
		local var_6_0 = 1

		while jumpgame_conf_data[self.activityid .. "_planegame"]["score" .. var_6_0] and jumpgame_conf_data[self.activityid .. "_planegame"]["drop" .. var_6_0] do
			self.data[var_6_0] = {}
			self.data[var_6_0].drop = jumpgame_conf_data[self.activityid .. "_planegame"]["drop" .. var_6_0]
			self.data[var_6_0].score = jumpgame_conf_data[self.activityid .. "_planegame"]["score" .. var_6_0]
			var_6_0 = var_6_0 + 1
		end

		self.tableSize = var_6_0
	else
		global_ShowBlockWords(L_FALLINGLAYER[2])

		return
	end

	table.sort(self.data, function(arg_7_0, arg_7_1)
		return arg_7_0.score < arg_7_1.score
	end)
end

function ActivityPlaneWarLayer:initUI()
	self:initBg()
	self:initTitle()
	self:initPauseLayer()
	self:initKeyBoardListener()
	self:initBulletPool()
	self:initMonsterPool()
	self:initStartLayer()
	self:initRestartLayer()
	self:initRewardLayer()
	self:initBossHpProgress()
end

function ActivityPlaneWarLayer:pauseAllSchedule()
	self:unscheduleUpdate()

	if self.scheduleid then
		for iter_9_0, iter_9_1 in pairs(self.scheduleid) do
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(iter_9_1)
		end
	end
end

function ActivityPlaneWarLayer:initBg()
	local var_10_0 = ccui.ImageView:create(var_0_9 .. "bg.png", var_0_0)

	var_10_0:setAnchorPoint(0, 0)
	var_10_0:setPositionY(-GameDisplay.fix_y)
	var_10_0:setLocalZOrder(-100)
	self.rootlayer:addChild(var_10_0)

	local var_10_1 = ccui.ImageView:create(var_0_9 .. "bg.png", var_0_0)

	var_10_1:setAnchorPoint(0, 0)
	var_10_1:setPositionY(-GameDisplay.fix_y + var_10_0:getContentSize().height)
	var_10_1:setLocalZOrder(-100)
	self.rootlayer:addChild(var_10_1)

	self.bg1 = var_10_0
	self.bg2 = var_10_1

	local var_10_2 = ccui.Button:create(var_0_9 .. "btn_return.png", nil, var_0_9 .. "btn_return.png", var_0_0)

	var_10_2:setPosition(cc.p(50, 0))
	var_10_2:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.scheduleid then
			for iter_11_0, iter_11_1 in pairs(self.scheduleid) do
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(iter_11_1)
			end
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.rootlayer:addChild(var_10_2, 9999)

	local var_10_3 = ccui.Button:create(var_0_9 .. "btn_pause.png", var_0_9 .. "btn_continue.png", var_0_9 .. "btn_continue.png", var_0_0)

	var_10_3:setPosition(cc.p(560, 0))
	var_10_3:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:pauseAllSchedule()
		self.pauseLayer:setVisible(true)
		arg_12_0:setBright(false)
	end)
	self.rootlayer:addChild(var_10_3, 9999)
	var_10_3:setTouchEnabled(false)

	self.pasueBtn = var_10_3
end

function ActivityPlaneWarLayer:initTitle()
	local var_13_0 = ccui.ImageView:create(var_0_9 .. "title.png", var_0_0)

	var_13_0:setAnchorPoint(0, 1)
	var_13_0:setPosition(0, GameDisplay.origin_design_y + GameDisplay.fix_y)
	var_13_0:setLocalZOrder(1000)
	self.rootlayer:addChild(var_13_0)

	self.hearts = {}

	for iter_13_0 = 0, 4 do
		local var_13_1 = ccui.ImageView:create(var_0_9 .. "heart.png", var_0_0)

		var_13_1:setName("heart" .. iter_13_0)
		var_13_1:setPosition(242 + 32 * iter_13_0, 35)
		var_13_0:addChild(var_13_1)
		table.insert(self.hearts, var_13_1)
	end

	self.curScore = 0

	local var_13_2 = cc.Label:createWithTTF("" .. 0, FONT_NAME, 40)

	var_13_2:setPosition(100, 20)

	function var_13_2.updateScore()
		var_13_2:setString(self.curScore)
	end

	self.curScoreLabel = var_13_2

	var_13_0:addChild(var_13_2)

	local var_13_3 = ccui.Button:create(var_0_9 .. "btn_rank.png", nil, var_0_9 .. "btn_rank.png", var_0_0)

	var_13_3:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("ActivityFallingRankLayer", {
			type = "planegame",
			activityid = self.activityid,
			maxScore = self.maxScore
		})
	end)
	var_13_3:setPosition(580, 35)
	var_13_0:addChild(var_13_3)

	local var_13_4 = ccui.Button:create(var_0_9 .. "btn_reward.png", nil, var_0_9 .. "btn_reward.png", var_0_0)

	var_13_4:setPosition(465, 35)
	var_13_4:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.rewardLayer:setVisible(true)
	end)
	var_13_0:addChild(var_13_4)
end

function ActivityPlaneWarLayer:initStartLayer()
	self.startLayer = cc.Layer:create()

	self.rootlayer:addChild(self.startLayer)

	local var_17_0 = ccui.ImageView:create(var_0_9 .. "wind_start.png", var_0_0)

	var_17_0:setPosition(GameDisplay.cx, GameDisplay.cy)
	self.startLayer:addChild(var_17_0)
	self.startLayer:setLocalZOrder(1000)

	local var_17_1 = ccui.Button:create(var_0_9 .. "btn_start.png", nil, var_0_9 .. "btn_start.png", var_0_0)

	var_17_1:setPosition(var_17_0:getContentSize().width / 2, 70)
	var_17_1:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:startGameUI()
		self.startLayer:setVisible(false)
		self.pasueBtn:setTouchEnabled(true)
	end)
	var_17_0:addChild(var_17_1)

	local var_17_2 = cc.Label:createWithTTF(L_FALLINGLAYER[3], FONT_NAME, 30)

	var_17_2:setColor(cc.c3b(255, 255, 0))
	var_17_2:setPosition(var_17_0:getContentSize().width / 2, var_17_0:getContentSize().height - 100)
	var_17_0:addChild(var_17_2)

	local var_17_3 = cc.Label:createWithTTF(self.maxScore, FONT_NAME, 72)

	var_17_3:setPosition(var_17_0:getContentSize().width / 2, var_17_0:getContentSize().height / 2)
	var_17_0:addChild(var_17_3)
end

function ActivityPlaneWarLayer:initPauseLayer()
	self.pauseLayer = cc.Layer:create()

	self.rootlayer:addChild(self.pauseLayer)

	local var_19_0 = ccui.ImageView:create(var_0_9 .. "wind_pause.png", var_0_0)

	var_19_0:setPosition(GameDisplay.cx, GameDisplay.cy)
	self.pauseLayer:addChild(var_19_0)
	self.pauseLayer:setLocalZOrder(9999)
	self.pauseLayer:setVisible(false)

	local var_19_1 = ccui.ImageView:create(var_0_9 .. "pause.png", var_0_0)

	var_19_1:setPosition(var_19_0:getContentSize().width / 2, var_19_0:getContentSize().height / 2)
	var_19_0:addChild(var_19_1)

	local var_19_2 = ccui.Button:create(var_0_9 .. "btn_yellow.png", nil, var_0_9 .. "btn_yellow.png", var_0_0)

	var_19_2:setPosition(490, -100)
	var_19_2:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.pauseLayer:setVisible(false)
		self.pasueBtn:setBright(true)
		self:scheduleUpdateWithPriorityLua(self.update, 0)
		self:initMonstersScheduleScriptFunc()
	end)
	var_19_0:addChild(var_19_2)

	local var_19_3 = cc.Label:createWithTTF(L_FALLINGLAYER[8], FONT_NAME, 30)

	var_19_3:setPosition(var_19_2:getContentSize().width / 2, var_19_2:getContentSize().height / 2)
	var_19_3:setColor(cc.c3b(61, 47, 40))
	var_19_2:addChild(var_19_3)

	local var_19_4 = ccui.Button:create(var_0_9 .. "btn_blue.png", nil, var_0_9 .. "btn_blue.png", var_0_0)

	var_19_4:setPosition(150, -100)
	var_19_4:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	var_19_0:addChild(var_19_4)

	local var_19_5 = cc.Label:createWithTTF(L_FALLINGLAYER[7], FONT_NAME, 30)

	var_19_5:setPosition(var_19_4:getContentSize().width / 2, var_19_4:getContentSize().height / 2)
	var_19_5:setColor(cc.c3b(24, 31, 68))
	var_19_4:addChild(var_19_5)
end

function ActivityPlaneWarLayer:initRestartLayer()
	self.restartLayer = cc.Layer:create()

	self.rootlayer:addChild(self.restartLayer)

	local var_22_0 = ccui.ImageView:create(var_0_9 .. "wind_pause.png", var_0_0)

	var_22_0:setPosition(GameDisplay.cx, GameDisplay.cy)
	self.restartLayer:addChild(var_22_0)
	self.restartLayer:setLocalZOrder(1000)
	self.restartLayer:setVisible(false)

	local var_22_1 = var_22_0:getContentSize()
	local var_22_2 = cc.Label:createWithTTF(L_FALLINGLAYER[4], FONT_NAME, 30)

	var_22_2:setPosition(var_22_1.width / 2, var_22_1.height - 30)
	var_22_2:setColor(cc.c3b(255, 255, 0))
	var_22_0:addChild(var_22_2)

	local var_22_3 = cc.Label:createWithTTF(self.curScore, FONT_NAME, 72)

	var_22_3:setPosition(var_22_1.width / 2, var_22_1.height / 2)
	var_22_0:addChild(var_22_3)

	self.restartLayer.curSocreLabel = var_22_3

	local var_22_4 = cc.Label:createWithTTF(L_FALLINGLAYER[5] .. self.maxScore, FONT_DES, 24)

	var_22_4:setPosition(var_22_1.width / 2, 20)
	var_22_4:setColor(cc.c3b(255, 255, 0))

	self.maxScoreLabel = var_22_4

	function self.maxScoreLabel.update(arg_23_0)
		var_22_4:setString(L_FALLINGLAYER[5] .. arg_23_0)
	end

	var_22_0:addChild(var_22_4)

	local var_22_5 = ccui.Button:create(var_0_9 .. "btn_yellow.png", nil, var_0_9 .. "btn_yellow.png", var_0_0)

	var_22_5:setPosition(490, -100)
	var_22_5:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:updateUI()
		self.restartLayer:setVisible(false)
	end)
	var_22_0:addChild(var_22_5)

	local var_22_6 = cc.Label:createWithTTF(L_FALLINGLAYER[6], FONT_NAME, 30)

	var_22_6:setPosition(var_22_5:getContentSize().width / 2, var_22_5:getContentSize().height / 2)
	var_22_6:setColor(cc.c3b(61, 47, 40))
	var_22_5:addChild(var_22_6)

	local var_22_7 = ccui.Button:create(var_0_9 .. "btn_blue.png", nil, var_0_9 .. "btn_blue.png", var_0_0)

	var_22_7:setPosition(150, -100)
	var_22_7:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	var_22_0:addChild(var_22_7)

	local var_22_8 = cc.Label:createWithTTF(L_FALLINGLAYER[7], FONT_NAME, 30)

	var_22_8:setPosition(var_22_7:getContentSize().width / 2, var_22_7:getContentSize().height / 2)
	var_22_8:setColor(cc.c3b(24, 31, 68))
	var_22_7:addChild(var_22_8)
end

function ActivityPlaneWarLayer:initRewardLayer()
	local var_26_0 = cc.Layer:create()

	self.rootlayer:addChild(var_26_0)

	self.rewardLayer = var_26_0

	var_26_0:setLocalZOrder(9999)
	var_26_0:setVisible(false)

	local var_26_1 = cc.EventListenerTouchOneByOne:create()

	var_26_1:setSwallowTouches(true)
	var_26_1:registerScriptHandler(function(arg_27_0, arg_27_1)
		if var_26_0:isVisible() then
			return true
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_26_0:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_26_1, var_26_0)

	local var_26_2 = ccui.ImageView:create(var_0_9 .. "rewardbg.png", var_0_0)

	var_26_2:setName("bg")
	var_26_2:setPosition(GameDisplay.cx, GameDisplay.cy)
	var_26_0:addChild(var_26_2)

	local var_26_3 = ccui.Button:create(var_0_9 .. "close.png", nil, var_0_9 .. "close.png", var_0_0)

	var_26_3:setPosition(var_26_2:getContentSize().width - 40, var_26_2:getContentSize().height - 40)
	var_26_3:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_26_0:setVisible(false)
	end)
	var_26_2:addChild(var_26_3)

	local var_26_4 = ccui.Button:create(var_0_9 .. "info.png", nil, var_0_9 .. "info.png", var_0_0)

	var_26_4:setPosition(220, var_26_2:getContentSize().height - 35)
	var_26_4:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityPlaneLayer_" .. self.activityid
		})
	end)
	var_26_2:addChild(var_26_4)

	local var_26_5 = ccui.ImageView:create(var_0_9 .. "score.png", var_0_0)

	var_26_5:setPosition(80, var_26_2:getContentSize().height - 35)
	var_26_2:addChild(var_26_5)

	local var_26_6 = cc.Label:createWithTTF(self.maxScore, FONT_NAME, 48)

	var_26_6:setPosition(110, var_26_2:getContentSize().height - 80)
	var_26_6:setName("scoreLabel")
	var_26_2:addChild(var_26_6)

	local var_26_7 = ccui.Button:create(var_0_9 .. "btn_getall.png", var_0_9 .. "btn_getall_off.png", var_0_9 .. "btn_getall.png", var_0_0)

	var_26_7:setPosition(var_26_2:getContentSize().width / 2, -70)
	var_26_7:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end
	end)

	self.rewardTableView = cc.TableView:create(cc.size(580, 590))

	self.rewardTableView:setPosition(cc.p(16, 22))
	self.rewardTableView:setDelegate()
	self.rewardTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_26_2:addChild(self.rewardTableView)
	self.rewardTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.rewardTableView:registerScriptHandler(function(arg_32_0, arg_32_1)
		return var_0_10, var_0_11
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.rewardTableView:registerScriptHandler(function(arg_31_0, arg_31_1)
		local var_31_0 = arg_31_0:dequeueCell()

		if not var_31_0 then
			var_31_0 = cc.TableViewCell:create()

			local var_31_1 = self:createNode(arg_31_1 + 1)

			var_31_1:setName("node")
			var_31_1:setAnchorPoint(cc.p(0, 0))
			var_31_1:setPosition(cc.p(5, 0))

			if arg_31_1 <= math.floor(var_26_2:getContentSize().height / var_0_11) then
				var_31_1:setOpacity(0)
				var_31_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_31_1), cc.FadeIn:create(0.1)))
			else
				var_31_1:setOpacity(255)
			end

			var_31_0:addChild(var_31_1)
		else
			local var_31_2 = var_31_0:getChildByName("node")

			var_31_2:setOpacity(255)
			self:updateNode(var_31_2, arg_31_1 + 1)
		end

		return var_31_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.rewardTableView:registerScriptHandler(function(arg_33_0, arg_33_1)
		return self.tableSize - 1
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.rewardTableView:reloadData()
end

function ActivityPlaneWarLayer:createNode(arg_34_1)
	local var_34_0 = cc.Node:create()
	local var_34_1 = self.data[arg_34_1].score
	local var_34_2 = self.data[arg_34_1].score > self.maxScore and 2 or self.rewardStatus and self.rewardStatus[arg_34_1] and self.rewardStatus[arg_34_1] or 0
	local var_34_3 = ccui.ImageView:create(var_0_9 .. "item.png", var_0_0)

	var_34_3:setName("bg")
	var_34_0:addChild(var_34_3)
	var_34_3:setAnchorPoint(0, 0)

	local var_34_4 = cc.Label:createWithTTF(var_34_1, FONT_NAME, 36)

	var_34_4:setPosition(70, var_34_3:getContentSize().height / 2)
	var_34_4:setName("scoreLabel")
	var_34_0:addChild(var_34_4)

	local var_34_5 = drop_manager:getDropMsg(self.data[arg_34_1].drop)

	for iter_34_0 = 1, 3 do
		local var_34_6 = ItemSpriteActivityRecharge:createSignItem()

		var_34_6:setName("sp" .. iter_34_0)
		var_34_6:setPosition(190 + (iter_34_0 - 1) * 95, var_34_3:getContentSize().height / 2)
		var_34_3:addChild(var_34_6)
		var_34_6:setInfoTouchEvent(true)
		var_34_6:setSwallowTouches(false)
		var_34_6:setVisible(false)
	end

	table.sort(var_34_5.equips, function(arg_35_0, arg_35_1)
		return arg_35_0._index < arg_35_1._index
	end)

	local var_34_7 = {}

	if var_34_5.diamond > 0 then
		table.insert(var_34_7, {
			itemid = "diamond",
			num = var_34_5.diamond,
			name = L_DIAMOND
		})
	end

	if var_34_5.gold > 0 then
		table.insert(var_34_7, {
			itemid = "gold",
			num = var_34_5.gold,
			name = L_GOLD
		})
	end

	local var_34_8 = {}

	for iter_34_1, iter_34_2 in pairs(var_34_5.equips) do
		table.insert(var_34_8, {
			itemid = iter_34_2.dropid,
			num = iter_34_2.dropNum,
			name = item_data[iter_34_2.dropid].name
		})
	end

	for iter_34_3, iter_34_4 in pairs(var_34_8) do
		table.insert(var_34_7, iter_34_4)
	end

	if var_34_7 then
		for iter_34_5, iter_34_6 in pairs(var_34_7) do
			var_34_3:getChildByName("sp" .. iter_34_5):updateSignItemByItemid(var_34_7[iter_34_5].itemid, var_34_7[iter_34_5].num)
			var_34_3:getChildByName("sp" .. iter_34_5):setVisible(true)
		end
	end

	local var_34_9 = ccui.Button:create()

	var_34_9:setName("rewardBtn")
	var_34_9:setPosition(500, var_34_3:getContentSize().height / 2)
	var_34_3:addChild(var_34_9)

	if var_34_2 == 0 then
		var_34_9:loadTextures(var_0_9 .. "btn_get.png", var_0_9 .. "btn_get.png", var_0_9 .. "btn_get.png", var_0_0)
	elseif var_34_2 == 1 then
		var_34_9:loadTextures(var_0_9 .. "btn_reward_on.png", var_0_9 .. "btn_reward_on.png", var_0_9 .. "btn_reward_on.png", var_0_0)
	elseif var_34_2 == 2 then
		var_34_9:loadTextures(var_0_9 .. "btn_reward_off.png", var_0_9 .. "btn_reward_off.png", var_0_9 .. "btn_reward_off.png", var_0_0)
	end

	var_34_9.index = arg_34_1
	var_34_9.status = var_34_2

	var_34_9:addTouchEventListener(function(arg_36_0, arg_36_1)
		if arg_36_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_36_0.status ~= 0 then
			return
		end

		self:touchRward(arg_36_0.index)
	end)

	return var_34_0
end

function ActivityPlaneWarLayer:updateNode(arg_37_1, arg_37_2)
	arg_37_1:getChildByName("scoreLabel"):setString(self.data[arg_37_2].score)

	local var_37_0 = drop_manager:getDropMsg(self.data[arg_37_2].drop)
	local var_37_1 = arg_37_1:getChildByName("bg")

	table.sort(var_37_0.equips, function(arg_38_0, arg_38_1)
		return arg_38_0._index < arg_38_1._index
	end)

	local var_37_2 = {}

	if var_37_0.diamond > 0 then
		table.insert(var_37_2, {
			itemid = "diamond",
			num = var_37_0.diamond,
			name = L_DIAMOND
		})
	end

	if var_37_0.gold > 0 then
		table.insert(var_37_2, {
			itemid = "gold",
			num = var_37_0.gold,
			name = L_GOLD
		})
	end

	local var_37_3 = {}

	for iter_37_0, iter_37_1 in pairs(var_37_0.equips) do
		table.insert(var_37_3, {
			itemid = iter_37_1.dropid,
			num = iter_37_1.dropNum,
			name = item_data[iter_37_1.dropid].name
		})
	end

	for iter_37_2, iter_37_3 in pairs(var_37_3) do
		table.insert(var_37_2, iter_37_3)
	end

	if var_37_2 then
		for iter_37_4, iter_37_5 in pairs(var_37_2) do
			var_37_1:getChildByName("sp" .. iter_37_4):updateSignItemByItemid(var_37_2[iter_37_4].itemid, var_37_2[iter_37_4].num)
			var_37_1:getChildByName("sp" .. iter_37_4):setVisible(true)
		end
	end

	local var_37_4 = var_37_1:getChildByName("rewardBtn")

	var_37_4.index = arg_37_2

	local var_37_5 = self.data[arg_37_2].score > self.maxScore and 2 or self.rewardStatus and self.rewardStatus[arg_37_2] and self.rewardStatus[arg_37_2] or 0

	if var_37_5 == 0 then
		var_37_4:loadTextures(var_0_9 .. "btn_get.png", var_0_9 .. "btn_get.png", var_0_9 .. "btn_get.png", var_0_0)
	elseif var_37_5 == 1 then
		var_37_4:loadTextures(var_0_9 .. "btn_reward_on.png", var_0_9 .. "btn_reward_on.png", var_0_9 .. "btn_reward_on.png", var_0_0)
	elseif var_37_5 == 2 then
		var_37_4:loadTextures(var_0_9 .. "btn_reward_off.png", var_0_9 .. "btn_reward_off.png", var_0_9 .. "btn_reward_off.png", var_0_0)
	end

	var_37_4.status = var_37_5

	var_37_4:addTouchEventListener(function(arg_39_0, arg_39_1)
		if arg_39_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_39_0.status ~= 0 then
			return
		end

		self:touchRward(arg_39_0.index)
	end)
end

function ActivityPlaneWarLayer:initBossHpProgress()
	local var_40_0 = ccui.ImageView:create(var_0_9 .. "progress_bg.png", var_0_0)

	var_40_0:setPosition(cc.p(320, GameDisplay.origin_design_y - 70))
	self.rootlayer:addChild(var_40_0)
	var_40_0:setVisible(false)

	self.progressBg = var_40_0

	local var_40_1 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create(var_0_9 .. "progress_fill.png") or cc.Sprite:createWithSpriteFrameName(var_0_9 .. "progress_fill.png")))

	var_40_1:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	var_40_1:setMidpoint(cc.p(0, 0.5))
	var_40_1:setBarChangeRate(cc.p(1, 0))
	var_40_1:setPercentage(100)
	var_40_1:setPosition(cc.p(320, GameDisplay.origin_design_y - 70))
	var_40_1:setName("progress")
	var_40_1:setVisible(false)
	var_40_1:setLocalZOrder(1000)
	self.rootlayer:addChild(var_40_1)

	self.progress = var_40_1

	local var_40_2 = cc.Label:createWithTTF("100%", FONT_NAME, 18)

	var_40_1:addChild(var_40_2)
	var_40_2:setPosition(320, 12)

	self.hpLabel = var_40_2
end

function ActivityPlaneWarLayer:startGameUI()
	self:initJoystick()
	self:initBaseGame()
	self:initPlayer()
end

function ActivityPlaneWarLayer:updateUI()
	self.monsterPool:clearAllActiveObject()
	self.pBulletPool:clearAllActiveObject()
	self.mBulletPool:clearAllActiveObject()
	self.player:setVisible(true)
	self.player.resumePos()
	self:scheduleUpdateWithPriorityLua(self.update, 0)
	self:initMonstersScheduleScriptFunc()
	self.pasueBtn:setTouchEnabled(true)

	self.bgStop = false
	self.buff = nil
	self.skillTime = 0
	self.curScore = 0

	self.curScoreLabel.updateScore()
	self:initBulletPool()
	self:initMonsterPool()
	self.progressBg:setVisible(false)
	self.progress:setVisible(false)

	self.heart = 5

	for iter_42_0, iter_42_1 in pairs(self.hearts) do
		iter_42_1:setVisible(true)
	end

	for iter_42_2, iter_42_3 in pairs(self.skills) do
		iter_42_3:setVisible(false)
		iter_42_3:removeFromParent()
	end

	self.skills = {}
end

function ActivityPlaneWarLayer:updateAllScore()
	self.maxScore = self.curScore

	self.rewardLayer:getChildByName("bg"):getChildByName("scoreLabel"):setString(self.maxScore)
	self.maxScoreLabel.update(self.maxScore)
	self:updateScore(self.maxScore)
	self.rewardTableView:reloadData()
end

function ActivityPlaneWarLayer:initBaseGame()
	self.totalTime = 0

	function self.update(arg_45_0)
		self.totalTime = self.totalTime + arg_45_0

		if self.heart <= 0 and not self.invincable then
			self.restartLayer:setVisible(true)
			self.restartLayer.curSocreLabel:setString(self.curScore)
			self.pasueBtn:setTouchEnabled(false)
			self:pauseAllSchedule()
			self.spine:setVisible(true)
			self.spine:playAni(function()
				self.spine:setVisible(false)
				self.player:setVisible(false)
			end, "shouji", false)

			if self.curScore > self.maxScore then
				self:updateAllScore()
			end

			return
		end

		local var_45_0 = self.player:getPositionX()
		local var_45_1 = self.player:getPositionY()

		self.player.lastFireTime = self.player.lastFireTime - arg_45_0
		self.endPointY = nil

		self:enemyUpdate(arg_45_0)
		self:skillUpdate(arg_45_0)
		self:pBulletUpdate(arg_45_0)
		self:mBulletUpdate(arg_45_0)
		self:touchUpdate(arg_45_0)
		self:joystickUpdate(arg_45_0)
		self:bgUpdate(arg_45_0)
	end

	self:scheduleUpdateWithPriorityLua(self.update, 0)
	self:initMonstersScheduleScriptFunc()
end

function ActivityPlaneWarLayer:initMonstersScheduleScriptFunc()
	self.scheduleid = {}

	self:initMonsterSchedule("monster", 2)
	self:initMonsterSchedule("eMonster", 30)
	self:initMonsterSchedule("lMonster", 75)
	table.insert(self.scheduleid, (cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		self:dropSkill({
			y = math.random() * 640 + 640,
			x = math.random() * 640
		}, "cure")
	end, 25, false)))
end

function ActivityPlaneWarLayer:enemyUpdate(arg_49_1)
	local var_49_0 = self.player:getPositionX()
	local var_49_1 = self.player:getPositionY()

	for iter_49_0, iter_49_1 in pairs(self.monsterPool.activePool) do
		local var_49_2 = iter_49_1:getPositionX()
		local var_49_3 = iter_49_1:getPositionY()

		if var_49_3 <= -100 then
			self.monsterPool:recycleObject(iter_49_1)
		end

		if self.isClear then
			iter_49_1.HP = iter_49_1.HP - 20
		end

		if iter_49_1.HP <= 0 then
			local function var_49_4()
				iter_49_1:setVisible(false)
			end

			iter_49_1.spine:setVisible(true)
			iter_49_1.spine:playAni(var_49_4, "shouji", false)
			self.monsterPool:recycleObject(iter_49_1, true)

			if iter_49_1.type == "monster" then
				self.curScore = self.curScore + 5
			elseif iter_49_1.type == "eMonster" then
				self.curScore = self.curScore + 50

				if math.random() < 0.5 then
					self:dropSkill(cc.p(var_49_2, var_49_3))
				end
			elseif iter_49_1.type == "lMonster" then
				self.curScore = self.curScore + 300
				self.bgStop = false

				self.progressBg:setVisible(false)
				self.progress:setVisible(false)
				self:dropSkill(cc.p(var_49_2, var_49_3))
			end

			self.curScoreLabel.updateScore()
		end

		if iter_49_1.isActive then
			if iter_49_1.type == "monster" then
				iter_49_1:setPositionY(var_49_3 - var_0_16 * arg_49_1)
			else
				local var_49_5

				if iter_49_1.type == "eMonster" then
					var_49_5 = var_0_16 / 2
				elseif iter_49_1.type == "lMonster" then
					var_49_5 = var_0_16 / 3

					self.progress:setPercentage(string.format("%.2f", iter_49_1.HP / iter_49_1.maxHP * 100))
					self.hpLabel:setString(string.format("%.2f", iter_49_1.HP / iter_49_1.maxHP * 100) .. "%")
				end

				if iter_49_1.isLeft then
					if var_49_2 > 100 then
						iter_49_1:setPositionX(var_49_2 - var_49_5 * arg_49_1)
					else
						iter_49_1.isRight = true
						iter_49_1.isLeft = false
					end
				elseif iter_49_1.isRight then
					if var_49_2 < 540 then
						iter_49_1:setPositionX(var_49_2 + var_49_5 * arg_49_1)
					else
						iter_49_1.isLeft = true
						iter_49_1.isRight = false
					end
				end

				if not iter_49_1.buff then
					local var_49_6 = math.random()

					if var_49_6 < 0.1 and iter_49_1.type == "lMonster" then
						iter_49_1.spine:setVisible(true)
						iter_49_1.spine:playAni(nil, "dun", true)

						iter_49_1.buff = "shield"
						iter_49_1.skillTime = 5
					elseif var_49_6 < 0.2 then
						iter_49_1.buff = "laser"
						iter_49_1.skillTime = 10

						iter_49_1.spine:setVisible(true)
						iter_49_1.spine:playAni(function()
							iter_49_1.spine:playAni(nil, "jiguang_xuhuan", true)
						end, "jiguang_go", false)
					elseif var_49_6 < 0.4 then
						iter_49_1.buff = "scatter"
						iter_49_1.skillTime = 20

						iter_49_1.spine:setVisible(true)
						iter_49_1.spine:playAni(nil, "sanshe2", true)
					else
						iter_49_1.buff = "normal"
						iter_49_1.skillTime = 20
					end
				end

				if iter_49_1.skillTime and iter_49_1.skillTime < 0 then
					if self.buff == "laser" then
						iter_49_1.spine:playAni(function()
							iter_49_1.spine:setVisible(false)
						end, "jiguang_end", false)
					else
						iter_49_1.spine:setVisible(false)
					end

					iter_49_1.buff = nil
					iter_49_1.skillTime = nil
				end

				if iter_49_1.buff and iter_49_1.skillTime then
					iter_49_1.skillTime = iter_49_1.skillTime - arg_49_1
				end
			end

			iter_49_1.lastFireTime = iter_49_1.lastFireTime - arg_49_1

			if iter_49_1.lastFireTime <= 0 then
				if iter_49_1.type == "monster" then
					local var_49_7 = self.mBulletPool:getObject()

					if var_49_7 then
						var_49_7:setPosition(iter_49_1:getPositionX(), iter_49_1:getPositionY() - 50)
					end
				elseif iter_49_1.type ~= "eMonster" and iter_49_1.type ~= "lMonster" or iter_49_1.buff == "laser" then
					-- block empty
				elseif iter_49_1.buff == "scatter" then
					for iter_49_2 = 0, 5 do
						local var_49_8 = self.mBulletPool:getObject()

						if var_49_8 then
							var_49_8:setPosition(iter_49_1:getPositionX(), iter_49_1:getPositionY() - 50)

							var_49_8.angle = 36 * iter_49_2

							var_49_8:setRotation(180 - 36 * iter_49_2)
						end
					end
				else
					local var_49_9 = self.mBulletPool:getObject()

					if var_49_9 then
						var_49_9:setPosition(iter_49_1:getPositionX(), iter_49_1:getPositionY() - 50)
					end
				end

				iter_49_1.lastFireTime = var_0_13
			end

			local var_49_10 = iter_49_1:getBoundingBox()

			var_49_10.x = var_49_10.x + var_49_10.width / 2 * 0.3
			var_49_10.y = var_49_10.y + var_49_10.height / 2 * 0.3
			var_49_10.width = var_49_10.width * 0.7
			var_49_10.height = var_49_10.height * 0.7

			local var_49_11 = self.player:getBoundingBox()

			var_49_11.width = 50
			var_49_11.height = 90
			var_49_11.x = var_49_0 - var_49_11.width / 2
			var_49_11.y = var_49_1 - var_49_11.height / 2

			if cc.rectIntersectsRect(var_49_10, var_49_11) then
				if iter_49_1.buff ~= "shield" then
					iter_49_1.HP = iter_49_1.HP - 1
				end

				if self.buff2 == "shield" then
					break
				end

				self.heart = self.heart - 1

				for iter_49_3, iter_49_4 in pairs(self.hearts) do
					if iter_49_4:getName() == "heart" .. self.heart then
						iter_49_4:setVisible(false)
					end
				end
			end

			if iter_49_1.buff == "laser" and cc.rectContainsPoint(var_49_11, cc.p(var_49_2, var_49_1)) and var_49_1 < var_49_3 then
				if not self.player.firstHurt then
					self.heart = self.heart - 1
					self.player.firstHurt = true
				else
					self.player.hurtTime = self.player.hurtTime + arg_49_1

					if self.player.hurtTime > var_0_18 then
						self.heart = self.heart - 1
						self.player.hurtTime = 0
					end
				end

				for iter_49_5, iter_49_6 in pairs(self.hearts) do
					if iter_49_6:getName() == "heart" .. self.heart then
						iter_49_6:setVisible(false)
					end
				end
			end

			if self.buff == "laser" and cc.rectContainsPoint(var_49_10, cc.p(var_49_0, var_49_10.y)) and var_49_1 < var_49_3 and iter_49_1.buff ~= "shield" then
				if not iter_49_1.firstHurt then
					iter_49_1.HP = iter_49_1.HP - 1
					iter_49_1.firstHurt = true
				else
					iter_49_1.hurtTime = iter_49_1.hurtTime + arg_49_1

					if iter_49_1.hurtTime > var_0_18 then
						iter_49_1.HP = iter_49_1.HP - 1
						iter_49_1.hurtTime = 0
					end
				end
			end

			for iter_49_7, iter_49_8 in pairs(self.pBulletPool.activePool) do
				if cc.rectIntersectsRect(var_49_10, (iter_49_8:getBoundingBox())) then
					self.pBulletPool:recycleObject(iter_49_8)

					if iter_49_1.buff ~= "shield" then
						iter_49_1.HP = iter_49_1.HP - 1
					end
				end
			end
		end
	end

	if self.clearTime then
		self.clearTime = self.clearTime - arg_49_1

		if self.clearTime < 0 then
			self.isClear = false
		end
	end
end

function ActivityPlaneWarLayer:skillUpdate(arg_53_1)
	local var_53_0 = self.player:getPositionX()
	local var_53_1 = self.player:getPositionY()

	if self.skillTime and self.skillTime < 0 then
		if self.buff == "laser" then
			self.spine:playAni(function()
				self.spine:setVisible(false)
			end, "jiguang_end", false)
		else
			self.spine:setVisible(false)
		end

		self.buff = nil
		self.skillTime = nil
		self.isSpeed = nil

		if self.isSpeed then
			var_0_12 = var_0_12 * 1.5
		end
	end

	if self.skillTime2 and self.skillTime2 < 0 then
		self.spine2:setVisible(false)

		self.buff2 = nil
		self.skillTime2 = nil
	end

	if self.buff and self.skillTime then
		self.skillTime = self.skillTime - arg_53_1
	end

	if self.buff2 and self.skillTime2 then
		self.skillTime2 = self.skillTime2 - arg_53_1
	end

	if self.buff == "speed" then
		if self.lastBuff == "laser" then
			self.spine:setVisible(false)
		end

		if not self.isSpeed then
			self.isSpeed = true
			var_0_12 = var_0_12 / 1.5
		end
	elseif self.isSpeed then
		var_0_12 = var_0_12 * 1.5
		self.isSpeed = nil
	end

	if self.buff ~= "laser" and self.player.lastFireTime <= 0 then
		if self.buff == "scatter" then
			for iter_53_0 = 0, 5 do
				local var_53_2 = self.pBulletPool:getObject()

				if var_53_2 then
					var_53_2:setPosition(self.player:getPositionX(), self.player:getPositionY() + 50)

					var_53_2.angle = 36 * iter_53_0

					var_53_2:setRotation(-36 * iter_53_0)
				end
			end
		else
			local var_53_3 = self.pBulletPool:getObject()

			if var_53_3 then
				var_53_3:setPosition(self.player:getPositionX(), self.player:getPositionY() + 50)
			end
		end

		self.player.lastFireTime = var_0_12
	end

	for iter_53_1, iter_53_2 in pairs(self.skills) do
		local var_53_4 = iter_53_2:getPositionX()
		local var_53_5 = iter_53_2:getPositionY()

		iter_53_2:setPositionY(var_53_5 - 200 * arg_53_1)

		if var_53_5 > GameDisplay.origin_design_y + 50 or var_53_5 < -50 or var_53_4 > GameDisplay.origin_design_x + 50 or var_53_4 < -50 then
			iter_53_2:removeFromParent()
			table.remove(self.skills, iter_53_1)

			break
		end

		if iter_53_2.isLeft then
			if var_53_4 > 120 then
				iter_53_2:setPositionX(var_53_4 - 150 * arg_53_1)
			else
				iter_53_2.isRight = true
				iter_53_2.isLeft = false
			end
		elseif iter_53_2.isRight then
			if var_53_4 < 520 then
				iter_53_2:setPositionX(var_53_4 + 150 * arg_53_1)
			else
				iter_53_2.isLeft = true
				iter_53_2.isRight = false
			end
		end

		local var_53_6 = iter_53_2:getBoundingBox()
		local var_53_7 = self.player:getBoundingBox()

		var_53_7.width = 50
		var_53_7.height = 90
		var_53_7.x = var_53_0 - var_53_7.width / 2
		var_53_7.y = var_53_1 - var_53_7.height / 2

		if cc.rectIntersectsRect(var_53_6, var_53_7) and not iter_53_2.use then
			iter_53_2.use = true

			if iter_53_2:getName() == "laser" then
				self.buff = "laser"
				self.skillTime = 10

				self.spine:setVisible(true)
				self.spine:playAni(function()
					self.spine:playAni(nil, "jiguang_xuhuan", true)
				end, "jiguang_go", false)
			elseif iter_53_2:getName() == "scatter" then
				self.buff = "scatter"
				self.skillTime = 30

				self.spine:setVisible(true)
				self.spine:playAni(nil, "sanshe", true)
			elseif iter_53_2:getName() == "clear" then
				self.isClear = true
				self.clearTime = 0.01
			elseif iter_53_2:getName() == "speed" then
				self.lastBuff = self.buff
				self.buff = "speed"
				self.skillTime = 60
			elseif iter_53_2:getName() == "shield" then
				self.spine2:setVisible(true)
				self.spine2:playAni(nil, "dun", true)

				self.buff2 = "shield"
				self.skillTime2 = 5
			elseif iter_53_2:getName() == "cure" then
				local function var_53_8()
					return
				end

				if self.buff2 == "shield" then
					function var_53_8()
						self.spine2:setVisible(true)
						self.spine2:playAni(nil, "dun", true)
					end
				end

				self.spine2:setVisible(true)
				self.spine2:playAni(var_53_8, "zhiliao", false)

				if self.heart < 5 then
					self.heart = self.heart + 1
				end

				for iter_53_3, iter_53_4 in pairs(self.hearts) do
					if iter_53_4:getName() == "heart" .. self.heart - 1 then
						iter_53_4:setVisible(true)
					end
				end
			end

			iter_53_2:removeFromParent()
			table.remove(self.skills, iter_53_1)

			break
		end
	end
end

function ActivityPlaneWarLayer:pBulletUpdate(arg_58_1)
	for iter_58_0, iter_58_1 in pairs(self.pBulletPool.activePool) do
		local var_58_0 = iter_58_1:getPositionX()
		local var_58_1 = iter_58_1:getPositionY()

		if var_58_1 > GameDisplay.origin_design_y + 50 or var_58_1 < -50 or var_58_0 > GameDisplay.origin_design_x + 50 or var_58_0 < -50 then
			self.pBulletPool:recycleObject(iter_58_1)
		end

		if iter_58_1.isActive then
			if iter_58_1.angle then
				local var_58_2 = math.rad(iter_58_1.angle)

				iter_58_1:setPosition(var_58_0 + math.cos(var_58_2) * var_0_14 * arg_58_1, var_58_1 + math.sin(var_58_2) * var_0_14 * arg_58_1)
			else
				iter_58_1:setPositionY(var_58_1 + var_0_14 * arg_58_1)
			end
		end
	end
end

function ActivityPlaneWarLayer:mBulletUpdate(arg_59_1)
	local var_59_0 = self.player:getPositionX()
	local var_59_1 = self.player:getPositionY()

	for iter_59_0, iter_59_1 in pairs(self.mBulletPool.activePool) do
		local var_59_2 = iter_59_1:getPositionX()
		local var_59_3 = iter_59_1:getPositionY()

		if var_59_3 > GameDisplay.origin_design_y + 50 or var_59_3 < -50 or var_59_2 > GameDisplay.origin_design_x + 50 or var_59_2 < -50 then
			self.mBulletPool:recycleObject(iter_59_1)
		end

		if iter_59_1.isActive then
			if iter_59_1.angle then
				local var_59_4 = math.rad(iter_59_1.angle)

				iter_59_1:setPosition(var_59_2 - math.cos(var_59_4) * var_0_14 * arg_59_1, var_59_3 - math.sin(var_59_4) * var_0_14 * arg_59_1)
			else
				iter_59_1:setPositionY(var_59_3 - var_0_15 * arg_59_1)
			end

			local var_59_5 = iter_59_1:getBoundingBox()
			local var_59_6 = self.player:getBoundingBox()

			var_59_6.width = 50
			var_59_6.height = 90
			var_59_6.x = var_59_0 - var_59_6.width / 2
			var_59_6.y = var_59_1 - var_59_6.height / 2

			if cc.rectIntersectsRect(var_59_5, var_59_6) then
				self.mBulletPool:recycleObject(iter_59_1)

				if self.buff2 == "shield" then
					break
				end

				self.heart = self.heart - 1

				for iter_59_2, iter_59_3 in pairs(self.hearts) do
					if iter_59_3:getName() == "heart" .. self.heart then
						iter_59_3:setVisible(false)
					end
				end
			end
		end
	end
end

function ActivityPlaneWarLayer:touchUpdate(arg_60_1)
	local var_60_0 = self.player:getPositionX()
	local var_60_1 = self.player:getPositionY()

	if self.isTouch then
		if self.dir == "left" and var_60_0 > 0 then
			self.player:setPositionX(var_60_0 + -var_0_17 * arg_60_1)
		elseif self.dir == "right" and var_60_0 < GameDisplay.origin_design_x then
			self.player:setPositionX(var_60_0 + var_0_17 * arg_60_1)
		elseif self.dir == "up" and var_60_1 < GameDisplay.origin_design_y then
			self.player:setPositionY(var_60_1 + var_0_17 * arg_60_1)
		elseif self.dir == "down" and var_60_1 > -GameDisplay.fix_y then
			self.player:setPositionY(var_60_1 + -var_0_17 * arg_60_1)
		end
	end
end

function ActivityPlaneWarLayer:joystickUpdate(arg_61_1)
	local var_61_0 = self.player:getPositionX()
	local var_61_1 = self.player:getPositionY()

	if self.player.dir then
		if self.player.dir.x < 0 and var_61_0 > 0 or self.player.dir.x > 0 and var_61_0 < 640 then
			self.player:setPositionX(var_61_0 + var_0_17 * self.player.dir.x * arg_61_1 * self.player.speed)
		end

		if self.player.dir.y < 0 and var_61_1 > -GameDisplay.fix_y or self.player.dir.y > 0 and var_61_1 < GameDisplay.origin_design_y then
			self.player:setPositionY(var_61_1 + var_0_17 * self.player.dir.y * arg_61_1 * self.player.speed)
		end
	end
end

function ActivityPlaneWarLayer:bgUpdate(arg_62_1)
	if not self.bgStop then
		local var_62_0 = self.bg1:getPositionY()
		local var_62_1 = self.bg2:getPositionY()
		local var_62_2 = self.bg1:getContentSize().height

		self.bg1:setPositionY(var_62_0 - var_0_19 * arg_62_1)
		self.bg2:setPositionY(var_62_1 - var_0_19 * arg_62_1)

		if var_62_0 < -(GameDisplay.fix_y + var_62_2) then
			self.bg1:setPositionY(var_62_1 + var_62_2 - var_0_19 * arg_62_1)
		end

		if var_62_1 < -(GameDisplay.fix_y + var_62_2) then
			self.bg2:setPositionY(var_62_0 + var_62_2 - var_0_19 * arg_62_1)
		end
	end
end

function ActivityPlaneWarLayer:initMonsterSchedule(arg_63_1, arg_63_2)
	table.insert(self.scheduleid, (cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		local var_64_0 = self.monsterPool:getObject(arg_63_1)

		if var_64_0 then
			if arg_63_1 == "monster" then
				var_64_0:setPosition(math.random(20, GameDisplay.origin_design_x - 20), 1200)
			else
				local var_64_1 = math.random()

				var_64_0:setPosition(640 * var_64_1, GameDisplay.origin_design_y - 190)

				if var_64_1 < 0.5 then
					var_64_0.isLeft = true
				else
					var_64_0.isRight = true
				end
			end

			if arg_63_1 == "lMonster" then
				self.bgStop = true

				self.progressBg:setVisible(true)
				self.progress:setVisible(true)
			end
		end
	end, arg_63_2, false)))
end

function ActivityPlaneWarLayer:initTouchLayer()
	self.rootlayer:addChild((cc.Layer:create()))

	local var_65_0 = ccui.Button:create(var_0_9 .. "btn_left.png", nil, var_0_9 .. "btn_left.png", var_0_0)

	var_65_0:addTouchEventListener(function(arg_66_0, arg_66_1)
		if arg_66_1 == ccui.TouchEventType.ended then
			self.isTouch = false
		end

		if arg_66_1 == ccui.TouchEventType.began then
			self.dir = "left"
			self.isTouch = true
		end
	end)
	var_65_0:setPosition(240, 150)
	var_65_0:setLocalZOrder(100)
	self.rootlayer:addChild(var_65_0)

	local var_65_1 = ccui.Button:create(var_0_9 .. "btn_right.png", nil, var_0_9 .. "btn_right.png", var_0_0)

	var_65_1:addTouchEventListener(function(arg_67_0, arg_67_1)
		if arg_67_1 == ccui.TouchEventType.ended then
			self.isTouch = false
		end

		if arg_67_1 == ccui.TouchEventType.began then
			self.dir = "right"
			self.isTouch = true
		end
	end)
	var_65_1:setPosition(400, 150)
	var_65_1:setLocalZOrder(100)
	self.rootlayer:addChild(var_65_1)

	local var_65_2 = ccui.Button:create(var_0_9 .. "btn_left.png", nil, var_0_9 .. "btn_left.png", var_0_0)

	var_65_2:setRotation(90)
	var_65_2:addTouchEventListener(function(arg_68_0, arg_68_1)
		if arg_68_1 == ccui.TouchEventType.ended then
			self.isTouch = false
		end

		if arg_68_1 == ccui.TouchEventType.began then
			self.dir = "up"
			self.isTouch = true
		end
	end)
	var_65_2:setPosition(320, 230)
	var_65_2:setLocalZOrder(100)
	self.rootlayer:addChild(var_65_2)

	local var_65_3 = ccui.Button:create(var_0_9 .. "btn_right.png", nil, var_0_9 .. "btn_right.png", var_0_0)

	var_65_3:setRotation(90)
	var_65_3:addTouchEventListener(function(arg_69_0, arg_69_1)
		if arg_69_1 == ccui.TouchEventType.ended then
			self.isTouch = false
		end

		if arg_69_1 == ccui.TouchEventType.began then
			self.dir = "down"
			self.isTouch = true
		end
	end)
	var_65_3:setPosition(320, 70)
	var_65_3:setLocalZOrder(100)
	self.rootlayer:addChild(var_65_3)
end

function ActivityPlaneWarLayer:initJoystick()
	local var_70_0 = ccui.ImageView:create(var_0_9 .. "baseJoy.png", var_0_0)
	local var_70_1 = ccui.ImageView:create(var_0_9 .. "joystick.png", var_0_0)

	var_70_0:setPosition(320, 100)
	var_70_0:setAnchorPoint(0.5, 0.5)

	local var_70_2 = cc.p(var_70_0:getContentSize().width / 2, var_70_0:getContentSize().height / 2)

	var_70_1:setPosition(var_70_2)
	var_70_0:setLocalZOrder(999)
	self.rootlayer:addChild(var_70_0)
	var_70_0:addChild(var_70_1)

	local var_70_3 = cc.p(0, 0)
	local var_70_4 = var_70_0:getContentSize()
	local var_70_5 = false
	local var_70_6 = var_70_0:getContentSize().width / 2
	local var_70_7 = var_70_1:getContentSize().width / 2
	local var_70_8 = cc.EventListenerTouchOneByOne:create()

	var_70_8:setSwallowTouches(true)
	var_70_8:registerScriptHandler(function(arg_71_0, arg_71_1)
		local var_71_0 = arg_71_0:getLocation()

		var_70_3 = var_71_0

		if cc.pGetLength((var_70_0:convertToNodeSpaceAR(var_71_0))) < var_70_7 then
			var_70_5 = true
		end

		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_70_8:registerScriptHandler(function(arg_72_0, arg_72_1)
		if not var_70_5 then
			return
		end

		local var_72_0 = cc.pSub(arg_72_0:getLocation(), var_70_3)

		var_72_0.x = var_72_0.x
		var_72_0.y = var_72_0.y

		local var_72_1 = cc.pAdd({
			x = var_70_2.x,
			y = var_70_2.y
		}, var_72_0)
		local var_72_2 = cc.pGetDistance(var_72_1, var_70_2)

		if var_72_2 < var_70_6 then
			var_70_1:setPosition(var_72_1)
		else
			var_72_1.x = var_70_6 * (var_72_1.x - var_70_2.x) / var_72_2 + var_70_2.x
			var_72_1.y = var_70_6 * (var_72_1.y - var_70_2.y) / var_72_2 + var_70_2.y

			var_70_1:setPosition(var_72_1)
		end

		local var_72_3 = cc.pGetDistance(var_72_1, var_70_2)

		self.player.dir = cc.pNormalize((cc.pSub(var_72_1, var_70_2)))
		self.player.speed = var_72_3 / var_70_6
	end, cc.Handler.EVENT_TOUCH_MOVED)
	var_70_8:registerScriptHandler(function(arg_73_0, arg_73_1)
		var_70_5 = false

		var_70_1:setPosition(var_70_2)

		self.player.dir = nil
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_70_1:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_70_8, var_70_1)
end

function ActivityPlaneWarLayer:initPlayer()
	local var_74_0 = ccui.ImageView:create(var_0_9 .. "player.png", var_0_0)

	var_74_0:setScale(0.3, 0.3)

	function var_74_0.resumePos()
		var_74_0:setPosition(GameDisplay.cx, GameDisplay.cy)
	end

	var_74_0.resumePos()
	self.rootlayer:addChild(var_74_0)

	self.player = var_74_0
	self.player.dir = nil
	self.player.lastFireTime = 0
	self.heart = 5
	var_74_0.hurtTime = 0

	local var_74_1 = L2Actor:create(ROLE_SPINE_PATH .. "leiting.json", ROLE_SPINE_PATH .. "leiting.atlas", nil)

	var_74_1:setScale(2, 2)
	var_74_1:setPosition(225, 100)
	var_74_1:setName("spine")

	self.spine = var_74_1

	self.player:addChild(var_74_1)

	local var_74_2 = L2Actor:create(ROLE_SPINE_PATH .. "leiting.json", ROLE_SPINE_PATH .. "leiting.atlas", nil)

	var_74_2:setScale(2, 2)
	var_74_2:setPosition(225, 100)
	var_74_2:setName("spine")

	self.spine2 = var_74_2

	self.player:addChild(var_74_2)
end

function ActivityPlaneWarLayer:initBulletPool()
	local var_76_0 = ObjectPool:new()

	for iter_76_0 = 1, 50 do
		local var_76_1 = self:createBullet("player")

		var_76_1:setName("b_" .. iter_76_0)
		self.rootlayer:addChild(var_76_1)
		var_76_0:createObject(var_76_1)
	end

	self.pBulletPool = var_76_0

	local var_76_2 = ObjectPool:new()

	for iter_76_1 = 1, 100 do
		local var_76_3 = self:createBullet("monster")

		var_76_3:setName("mb_" .. iter_76_1)
		self.rootlayer:addChild(var_76_3)
		var_76_2:createObject(var_76_3)
	end

	self.mBulletPool = var_76_2
end

function ActivityPlaneWarLayer:initMonsterPool()
	local var_77_0 = ObjectPool:new()

	for iter_77_0 = 1, 10 do
		local var_77_1 = self:createMonster("monster")

		var_77_1:setName("monster" .. iter_77_0)
		self.rootlayer:addChild(var_77_1)
		var_77_0:createObject(var_77_1)
	end

	for iter_77_1 = 1, 4 do
		local var_77_2 = self:createMonster("eMonster")

		var_77_2:setName("eMonster" .. iter_77_1)
		self.rootlayer:addChild(var_77_2)
		var_77_0:createObject(var_77_2)
	end

	for iter_77_2 = 1, 1 do
		local var_77_3 = self:createMonster("lMonster")

		var_77_3:setName("lMonster" .. iter_77_2)
		self.rootlayer:addChild(var_77_3)
		var_77_0:createObject(var_77_3)
	end

	self.monsterPool = var_77_0
end

function ActivityPlaneWarLayer.createBullet(arg_78_0, arg_78_1)
	local var_78_0

	if arg_78_1 == "player" then
		var_78_0 = ccui.ImageView:create(var_0_9 .. "bullet_player.png", var_0_0)
	elseif arg_78_1 == "monster" then
		var_78_0 = ccui.ImageView:create(var_0_9 .. "bullet_monster.png", var_0_0)
	end

	var_78_0:setScale(0.2, 0.2)

	var_78_0.type = arg_78_1

	function var_78_0.reset()
		var_78_0.angle = nil

		if arg_78_1 == "player" then
			var_78_0:setRotation(270)
		else
			var_78_0:setRotation(90)
		end
	end

	var_78_0.reset()

	return var_78_0
end

function ActivityPlaneWarLayer.createMonster(arg_80_0, arg_80_1)
	local var_80_0
	local var_80_1

	if arg_80_1 == "monster" then
		var_80_0 = ccui.ImageView:create(var_0_9 .. "monster.png", var_0_0)

		var_80_0:setScale(0.3, -0.3)

		var_80_1 = 1
	elseif arg_80_1 == "eMonster" then
		var_80_0 = ccui.ImageView:create(var_0_9 .. "elite.png", var_0_0)

		var_80_0:setScale(0.35, -0.35)

		var_80_1 = 10
	elseif arg_80_1 == "lMonster" then
		var_80_0 = ccui.ImageView:create(var_0_9 .. "boss.png", var_0_0)

		var_80_0:setScale(0.45, -0.45)

		var_80_1 = 50
	end

	local var_80_2 = L2Actor:create(ROLE_SPINE_PATH .. "leiting2.json", ROLE_SPINE_PATH .. "leiting2.atlas", nil)

	var_80_2:setScale(2, 2)
	var_80_2:setPosition(225, 150)
	var_80_0:addChild(var_80_2)
	var_80_2:setVisible(false)

	var_80_0.spine = var_80_2

	function var_80_0.reset()
		var_80_0.HP = var_80_1
		var_80_0.lastFireTime = 0
		var_80_0.hurtTime = 0
		var_80_0.firstHurt = false
		var_80_0.buff = nil
		var_80_0.skillTime = 0
		var_80_0.maxHP = var_80_1
	end

	var_80_0.reset()

	var_80_0.type = arg_80_1

	return var_80_0
end

function ActivityPlaneWarLayer.createL2Actor(arg_82_0, arg_82_1)
	local var_82_0 = global_get_servant_skin(arg_82_1)
	local var_82_1 = 0.2
	local var_82_2 = L2Actor:create(ROLE_SPINE_PATH .. model_data[var_82_0].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_82_0].spine_model .. ".atlas", (model_data[var_82_0].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_82_0].clothes_model .. ".atlas" or nil))

	var_82_2:setName("spine")
	var_82_2:setScale(var_82_1, var_82_1)
	var_82_2:playAni(nil, "idle", true)

	return var_82_2
end

function ActivityPlaneWarLayer:initKeyBoardListener()
	local var_83_0 = {}

	var_83_0.y = 1000
	var_83_0.x = 320

	local var_83_1 = cc.EventListenerKeyboard:create()

	var_83_1:registerScriptHandler(function(arg_84_0, arg_84_1)
		if arg_84_0 == cc.KeyCode.KEY_A then
			self.dir = "left"
			self.isTouch = true
		elseif arg_84_0 == cc.KeyCode.KEY_D then
			self.dir = "right"
			self.isTouch = true
		elseif arg_84_0 == cc.KeyCode.KEY_S then
			self.dir = "down"
			self.isTouch = true
		elseif arg_84_0 == cc.KeyCode.KEY_W then
			self.dir = "up"
			self.isTouch = true
		elseif arg_84_0 == cc.KeyCode.KEY_C then
			self:dropSkill(var_83_0, "clear")
		elseif arg_84_0 == cc.KeyCode.KEY_R then
			self.invincable = not self.invincable
		elseif arg_84_0 == cc.KeyCode.KEY_L then
			self:dropSkill(var_83_0, "laser")
		elseif arg_84_0 == cc.KeyCode.KEY_P then
			self:dropSkill(var_83_0, "scatter")
		elseif arg_84_0 == cc.KeyCode.KEY_O then
			self:dropSkill(var_83_0, "speed")
		elseif arg_84_0 == cc.KeyCode.KEY_I then
			self:dropSkill(var_83_0, "shield")
		elseif arg_84_0 == cc.KeyCode.KEY_U then
			self:dropSkill(var_83_0, "cure")
		end
	end, cc.Handler.EVENT_KEYBOARD_PRESSED)
	var_83_1:registerScriptHandler(function()
		self.dir = nil
		self.isTouch = false

		if self.player then
			-- block empty
		end
	end, cc.Handler.EVENT_KEYBOARD_RELEASED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_83_1, self)
end

function ActivityPlaneWarLayer:dropSkill(arg_86_1, arg_86_2)
	local var_86_0
	local var_86_1 = math.random()

	if var_86_1 < 0.1 then
		var_86_0 = ccui.ImageView:create(var_0_9 .. "laser.png", var_0_0)

		var_86_0:setName("laser")
	elseif var_86_1 < 0.4 then
		var_86_0 = ccui.ImageView:create(var_0_9 .. "scatter.png", var_0_0)

		var_86_0:setName("scatter")
	elseif var_86_1 < 0.45 then
		var_86_0 = ccui.ImageView:create(var_0_9 .. "clear.png", var_0_0)

		var_86_0:setName("clear")
	elseif var_86_1 < 0.75 then
		var_86_0 = ccui.ImageView:create(var_0_9 .. "speed.png", var_0_0)

		var_86_0:setName("speed")
	elseif var_86_1 < 0.85 then
		var_86_0 = ccui.ImageView:create(var_0_9 .. "shield.png", var_0_0)

		var_86_0:setName("shield")
	else
		var_86_0 = ccui.ImageView:create(var_0_9 .. "cure.png", var_0_0)

		var_86_0:setName("cure")
	end

	if arg_86_2 then
		var_86_0 = ccui.ImageView:create(var_0_9 .. arg_86_2 .. ".png", var_0_0)

		var_86_0:setName(arg_86_2)
	end

	if var_86_1 < 0.5 then
		var_86_0.isLeft = true
	else
		var_86_0.isRight = true
	end

	var_86_0:setPosition(arg_86_1)
	var_86_0:setScale(0.3)
	self.rootlayer:addChild(var_86_0)
	table.insert(self.skills, var_86_0)
end

function ActivityPlaneWarLayer:updateScore(arg_87_1)
	network:rpc("activity_jumpgame_update_score", {
		type = "planegame",
		activityid = self.activityid,
		score = arg_87_1
	}, function(arg_88_0)
		print(dump(arg_88_0), "msg")
	end)
end

function ActivityPlaneWarLayer:initReward(arg_89_1)
	network:rpc("activity_jumpgame_get_info", {
		type = "planegame",
		activityid = self.activityid
	}, function(arg_90_0)
		print(dump(arg_90_0), "inittttt")

		local var_90_0

		if arg_90_0.items then
			for iter_90_0, iter_90_1 in pairs(arg_90_0.items) do
				if iter_90_1.type == "planegame" then
					self.maxScore = iter_90_1.score
					var_90_0 = iter_90_1.reward
				end
			end
		end

		self.maxScore = self.maxScore or 0
		var_90_0 = var_90_0 or 0

		if not var_90_0 then
			return
		end

		self.rewardStatus = {}

		while var_90_0 > 0 do
			self.rewardStatus[0] = var_90_0 % 2

			local var_90_2 = tostring(var_90_0 % 2) .. ""

			var_90_0 = math.floor(var_90_0 / 2)
		end

		if arg_89_1 then
			arg_89_1()
		end
	end)
end

function ActivityPlaneWarLayer:touchRward(arg_91_1)
	network:rpc("activity_jumpgame_reward", {
		type = "planegame",
		activityid = self.activityid,
		index = arg_91_1
	}, function(arg_92_0)
		if arg_92_0.result == 1 then
			if arg_92_0.items and #arg_92_0.items > 0 then
				global_gain({
					items = arg_92_0.items,
					gold = arg_92_0.gold,
					diamond = arg_92_0.diamond
				})
			end
		elseif arg_92_0.result == 2 then
			global_ShowBlockWords(L_FALLINGLAYER[9])
		elseif arg_92_0.result == 3 then
			global_ShowBlockWords(L_FALLINGLAYER[10])
		end

		self:updateReward(arg_91_1)
	end)
end

function ActivityPlaneWarLayer:updateReward(arg_93_1)
	self:initReward(function()
		self.rewardTableView:updateCellAtIndex(arg_93_1 - 1)
	end)
end

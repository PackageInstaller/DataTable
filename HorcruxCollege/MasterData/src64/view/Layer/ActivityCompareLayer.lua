ActivityCompareLayer = class("ActivityCompareLayer", function()
	return ccui.Layout:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local network = require("network.network")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local item_data = require("data.item_data")
local L2Actor = require("view.Sprite.L2Actor")
local TowerBaseBarSprite = require("view.Sprite.TowerBaseBarSprite")
local drop_manager = require("controller.drop_manager")
local var_0_8 = 640
local var_0_9 = 1136
local var_0_11 = 1811
local var_0_14 = {
	"mainScenebg/fightbg1004_1.png",
	"mainScenebg/fightbg1004_2.png",
	"mainScenebg/fightbg1004_3.png"
}
local var_0_15 = {
	"+",
	"-",
	"x",
	"÷"
}
local var_0_16 = 300

function ActivityCompareLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityCompareLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityCompareLayer:init(arg_3_1)
	self.rootlayer = cc.Layer:create()

	self:addChild(self.rootlayer)

	self.monsterCount = 0
	self.respath = "activitiesRes/activity593/activitywar/"
	self.activityid = arg_3_1.activityid
	self.initLevel = arg_3_1.level

	self:initData(function()
		self:initUI()
	end)
end

function ActivityCompareLayer:initUI()
	self:initBg()
	self:initHead()
	self:initBottom()
	self:initPlayer()
	self:initSelectNumberWind()
	self:initSelectWheel()
	self:initSucces()
	self:initFail()
	self:initBaseGame()
end

function ActivityCompareLayer.createL2Actor(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2 and arg_6_2 or global_get_servant_skin(arg_6_1)
	local var_6_1 = 0.2
	local var_6_2 = L2Skeleton:create(ROLE_SPINE_PATH .. model_data[var_6_0].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_6_0].spine_model .. ".atlas", (model_data[var_6_0].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_6_0].clothes_model .. ".atlas" or nil))

	var_6_2:setName("spine")
	var_6_2:refreshSkeleton()
	var_6_2:setScale(var_6_1, var_6_1)
	var_6_2:play("idle", true)

	return var_6_2
end

function ActivityCompareLayer:initData(arg_7_1)
	local activity_war_conf = require("data.activity_war_conf")

	self.levelData = require("data.activity_war_data")[self.activityid .. "-" .. self.initLevel]

	if not self.levelData then
		return
	end

	self.servantid = self.levelData.regular_servants
	self.dropid = self.levelData.drop_bdx
	self.monstervalue = {}

	local var_7_1 = 1

	while self.levelData["monster_" .. var_7_1 .. "_value"] do
		self.monstervalue[var_7_1] = {}
		self.monstervalue[var_7_1].value = self.levelData["monster_" .. var_7_1 .. "_value"]
		self.monstervalue[var_7_1].operation = {}

		for iter_7_0 in activity_war_conf[self.activityid .. "-" .. self.initLevel .. "-" .. var_7_1].operation:gmatch("[^,]+") do
			table.insert(self.monstervalue[var_7_1].operation, iter_7_0)
		end

		self.monstervalue[var_7_1].select = {}

		for iter_7_1 in activity_war_conf[self.activityid .. "-" .. self.initLevel .. "-" .. var_7_1].select_value:gmatch("[^,]+") do
			table.insert(self.monstervalue[var_7_1].select, iter_7_1)
		end

		self.monstervalue[var_7_1].trap = {}

		if activity_war_conf[self.activityid .. "-" .. self.initLevel .. "-" .. var_7_1].trap1 then
			for iter_7_2 in activity_war_conf[self.activityid .. "-" .. self.initLevel .. "-" .. var_7_1].trap1:gmatch("[^,]+") do
				table.insert(self.monstervalue[var_7_1].trap, iter_7_2)
			end
		end

		self.monstervalue[var_7_1].modelId = activity_war_conf[self.activityid .. "-" .. self.initLevel .. "-" .. var_7_1].monster_model
		var_7_1 = var_7_1 + 1
	end

	self.totalCount = var_7_1 - 1
	self.initNumber = tonumber(self.levelData.ilife_value)
	self.curNum = self.initNumber

	local var_7_2 = {}

	var_7_2.operation = {}

	for iter_7_3 in self.levelData.operation:gmatch("[^,]+") do
		table.insert(var_7_2.operation, tonumber(iter_7_3))
	end

	var_7_2.value = {}

	for iter_7_4 in self.levelData.boss_buff1:gmatch("[^,]+") do
		table.insert(var_7_2.value, tonumber(iter_7_4))
	end

	self.wheelData = var_7_2

	print(dump(self.monstervalue), dump(var_7_2))
	arg_7_1()
end

function ActivityCompareLayer:initHead()
	self.headConf = {
		{
			charactertype = "player",
			singlehp = 30000,
			lv = 400,
			hpcount = 1,
			headimg = "77772",
			careericon = "tank_wind"
		},
		{
			charactertype = "enemy",
			singlehp = 30000,
			lv = 400,
			hpcount = 1,
			headimg = "77773",
			careericon = "tank_wind"
		}
	}

	local var_8_0 = cc.Node:create()

	var_8_0:setPosition(cc.p(0, GameDisplay.origin_design_y))
	self.rootlayer:addChild(var_8_0)

	local var_8_1

	if config._DEBUG then
		var_8_1 = cc.Sprite:create("FightLayer/boss_blood_frame.png") or cc.Sprite:createWithSpriteFrameName("FightLayer/boss_blood_frame.png")
	end

	var_8_1:setAnchorPoint(cc.p(0.5, 1))
	var_8_1:setPosition(320, 80)
	var_8_0:addChild(var_8_1, -1)
end

function ActivityCompareLayer:initBottom()
	local var_9_0 = ccui.ImageView:create(self.respath .. "bottom.png")

	var_9_0:setAnchorPoint(0, 0)
	var_9_0:setPosition(0, -GameDisplay.fix_y)
	var_9_0:setLocalZOrder(99)
	self.rootlayer:addChild(var_9_0)

	local var_9_1 = ccui.Button:create(self.respath .. "btn_return.png", nil, self.respath .. "btn_return.png")

	var_9_1:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	var_9_1:setPosition(50, 50)
	var_9_0:addChild(var_9_1)
end

function ActivityCompareLayer:initBg()
	self.bgPanel = ccui.Layout:create()

	self.bgPanel:setAnchorPoint(cc.p(0, 0))
	self.bgPanel:setPosition(cc.p(0, 5))
	self.bgPanel:setContentSize(cc.size(var_0_8, var_0_9))
	self.rootlayer:addChild(self.bgPanel)

	self.map1 = ccui.Layout:create()

	self.map1:setContentSize(cc.size(var_0_8, var_0_9))
	self.map1:setAnchorPoint(cc.p(0, 0))
	self.map1:setPosition(cc.p(0, 0))
	self.bgPanel:addChild(self.map1)

	self.map2 = ccui.Layout:create()

	self.map2:setContentSize(cc.size(var_0_8, var_0_9))
	self.map2:setAnchorPoint(cc.p(0, 0))
	self.map2:setPosition(cc.p(var_0_11, 0))
	self.bgPanel:addChild(self.map2)

	self.background = {}

	for iter_11_0, iter_11_1 in pairs(var_0_14) do
		self.background[iter_11_0] = cc.Sprite:create(iter_11_1)

		self.background[iter_11_0]:setAnchorPoint(cc.p(0, 0))
		self.background[iter_11_0]:setPosition(0, -100)
		self.map1:addChild(self.background[iter_11_0], -iter_11_0)
	end

	for iter_11_2, iter_11_3 in pairs(var_0_14) do
		self.background[iter_11_2] = cc.Sprite:create(iter_11_3)

		self.background[iter_11_2]:setAnchorPoint(cc.p(0, 0))
		self.background[iter_11_2]:setPosition(0, -100)
		self.map2:addChild(self.background[iter_11_2], -iter_11_2)
	end
end

function ActivityCompareLayer:initPlayer()
	local var_12_0 = {}
	local var_12_1 = {
		{
			100,
			400
		},
		{
			100,
			350
		},
		{
			100,
			300
		},
		{
			100,
			250
		},
		{
			150,
			375
		},
		{
			150,
			325
		},
		{
			150,
			275
		},
		{
			200,
			350
		},
		{
			200,
			300
		},
		{
			250,
			325
		}
	}

	for iter_12_0 = 1, 10 do
		local var_12_2 = self:createL2Actor(self.servantid)

		var_12_2:setPosition(var_12_1[iter_12_0][1], var_12_1[iter_12_0][2])
		var_12_2:play("run", true)
		self.bgPanel:addChild(var_12_2)

		var_12_0[iter_12_0] = var_12_2
	end

	self.player = cc.Sprite:create()
	self.player.loopCount = 0
	self.spines = var_12_0

	self.player:setPosition(100, 400)
	self.rootlayer:addChild(self.player)

	self.player.spines = var_12_0

	function self.player.play(arg_13_0, arg_13_1, arg_13_2)
		for iter_13_0, iter_13_1 in pairs(var_12_0) do
			iter_13_1:play(arg_13_1, true)
		end
	end

	function self.player.registerListener(arg_14_0, arg_14_1, arg_14_2)
		var_12_0[1]:registerListener(arg_14_1, arg_14_2)
	end

	function self.player.update(arg_15_0)
		for iter_15_0, iter_15_1 in pairs(var_12_0) do
			if arg_15_0 < iter_15_0 then
				iter_15_1:setVisible(false)
			else
				iter_15_1:setVisible(true)
			end
		end

		if arg_15_0 == 0 then
			var_12_0[1]:setVisible(true)
		end
	end

	self.player.update(math.floor(self.initNumber / 10))

	local var_12_3 = ccui.ImageView:create(self.respath .. "player_bg.png")

	var_12_3:setPosition(0, 150)
	self.player:addChild(var_12_3)

	local var_12_4 = ccui.TextBMFont:create(self.initNumber .. "", "fonts/energydamage1.fnt")

	var_12_3:addChild(var_12_4)
	var_12_4:setPosition(var_12_3:getContentSize().width / 2, var_12_3:getContentSize().height / 2)

	self.numLabel = var_12_4

	local var_12_5 = ccui.TextBMFont:create(self.initNumber .. "", "fonts/hitNumber1.fnt")

	var_12_3:addChild(var_12_5)
	var_12_5:setPosition(var_12_3:getContentSize().width / 2, var_12_3:getContentSize().height + 20)
	var_12_5:setVisible(false)

	self.addNumLabel = var_12_5
end

function ActivityCompareLayer:createMonster()
	self.monsterCount = self.monsterCount + 1

	local var_16_0 = self:createL2Actor(nil, self.monstervalue[self.monsterCount].modelId)

	var_16_0:setPosition(1200, 400)
	var_16_0:setScaleX(-1)
	self.bgPanel:addChild(var_16_0)

	self.monster = var_16_0
	self.canCreateMonster = false

	local var_16_1 = ccui.ImageView:create(self.respath .. "enemy_bg.png")

	var_16_1:setPosition(0, 150)
	self.monster:addChild(var_16_1)

	self.monsterNumBg = var_16_1

	local var_16_2 = ccui.TextBMFont:create(self.initNumber .. "", "fonts/critNumber1.fnt")

	var_16_1:addChild(var_16_2)
	var_16_2:setScaleX(-1)

	var_16_2.num = self.enemyNum

	var_16_2:setPosition(var_16_1:getContentSize().width / 2, var_16_1:getContentSize().height / 2)

	self.monsterNumLabel = var_16_2
end

function ActivityCompareLayer:initBaseGame()
	self.canCreateMonster = true
	self.gameStart = true

	local var_17_0 = 1
	local var_17_1 = 0
	local var_17_2 = 0

	function self.update(arg_18_0)
		if self.gameStart then
			if not self.bgStop then
				self:updateBg(arg_18_0)
			end

			if self.initNumber <= 0 and self.curNum == self.initNumber then
				var_17_2 = var_17_2 + arg_18_0
			end

			if var_17_2 >= 1 then
				self.gameStart = false

				self.failLayer:setVisible(true)

				self.fail = true

				self.player:play("idle", true)
			end

			if var_17_2 > 0 then
				return
			end

			var_17_1 = var_17_1 + arg_18_0
			var_17_0 = math.abs(self.curNum - self.initNumber) > 100 and 3 or math.abs(self.curNum - self.initNumber) > 50 and 2 or 1

			if self.curNum < self.initNumber then
				self.curNum = self.curNum + var_17_0

				self.numLabel:setString(self.curNum)
			elseif self.curNum > self.initNumber then
				self.curNum = self.curNum - var_17_0

				self.numLabel:setString(self.curNum)
			end

			if self.canCreateMonster and self.monsterCount < self.totalCount then
				self:createMonster()
			end

			if self.monster then
				if not self.bgStop then
					self.monster:setPositionX(self.monster:getPositionX() - var_0_16 * arg_18_0)
				end

				if self.monster:getPositionX() < -100 then
					self.monster:removeFromParent()

					self.monster = nil
					self.canCreateMonster = true
				elseif self.monster:getPositionX() <= 800 and not self.monster.canPop then
					self.gameStart = false

					self.player:play("idle", true)
					self:popSelectNumberWind()

					self.monster.canPop = true
				elseif self.monster:getPositionX() <= 540 and not self.monster.canFight then
					self.bgStop = true

					if self.monsterCount == self.totalCount and not self.wheelLayer:isVisible() and not self.startFight then
						self.wheelLayer:setVisible(true)
						self.player:play("idle", true)
					end

					if self.monsterCount == self.totalCount and self.startFight or self.monsterCount ~= self.totalCount then
						self.player:play("attack", true)
						self.player:registerListener(SP_ANIMATION_COMPLETE, function(arg_19_0)
							if arg_19_0.animation == "attack" then
								self.player.loopCount = arg_19_0.loopCount + self.player.loopCount

								self.monster:play("hit", false)
							end

							if self.player.loopCount >= 3 then
								self:reduceScore()

								if not self.fail then
									self.bgStop = false

									self.player:play("run", true)

									self.player.loopCount = 0

									self.monster:play("die", false)
									self.monsterNumBg:setVisible(false)
									self.wheelLayer:setVisible(false)

									if self.monsterCount == self.totalCount then
										self.player:play("idle", true)
										self.successLayer:setVisible(true)
										self:getAward()

										self.gameStart = false
									end
								else
									self.player.loopCount = 0

									self.player:play("idle", true)

									self.gameStart = false
								end

								self.monster:registerListener(SP_ANIMATION_COMPLETE, function(arg_20_0)
									if arg_20_0.animation == "die" then
										self.monster:setVisible(false)
									end
								end)
							end
						end)

						self.monster.canFight = true
					end
				end
			end
		end
	end

	self:scheduleUpdateWithPriorityLua(self.update, 0)
end

function ActivityCompareLayer:updateBg(arg_21_1)
	local var_21_0 = self.map1:getPositionX()
	local var_21_1 = self.map2:getPositionX()

	self.map1:setPositionX(var_21_0 - var_0_16 * arg_21_1)
	self.map2:setPositionX(var_21_1 - var_0_16 * arg_21_1)

	if var_21_0 < -var_0_11 then
		self.map1:setPositionX(var_21_1 + var_0_11 - var_0_16 * arg_21_1)

		self.showBg = 2
	end

	if var_21_1 < -var_0_11 then
		self.map2:setPositionX(var_21_0 + var_0_11 - var_0_16 * arg_21_1)

		self.showBg = 1
	end
end

function ActivityCompareLayer:initSelectNumberWind()
	local var_22_0 = ccui.Layout:create()

	var_22_0:setContentSize(cc.size(640, 1600))
	var_22_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_22_0:setCascadeOpacityEnabled(false)
	var_22_0:setBackGroundColorOpacity(80)
	var_22_0:setAnchorPoint(0.5, 0.5)
	var_22_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_22_0:setPosition(GameDisplay.cx, GameDisplay.cy)
	var_22_0:setTouchEnabled(true)
	var_22_0:setLocalZOrder(1000)
	var_22_0:setName("layout")
	var_22_0:setVisible(false)

	self.layout = var_22_0

	self.rootlayer:addChild(var_22_0)

	self.select = 1

	local var_22_1 = ccui.Button:create(self.respath .. "normal_bg.png", nil, self.respath .. "normal_bg.png")

	var_22_1:setPosition(160, 1100 - GameDisplay.fix_y)
	print(GameDisplay.top - var_22_1:getContentSize().height / 2, "gggggggg", GameDisplay.top, GameDisplay.height)
	var_22_0:addChild(var_22_1)

	local var_22_2 = ccui.ImageView:create(self.respath .. "select_purple.png")

	var_22_2:setPosition(var_22_1:getContentSize().width / 2, var_22_1:getContentSize().height / 2)

	self.select1 = var_22_2

	var_22_1:addChild(var_22_2)
	var_22_1:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_23_0:setTouchEnabled(false)
		self.select1:setVisible(true)
		self.select2:setVisible(false)

		local var_23_0 = self.monstervalue[self.monsterCount]

		if self.monstervalue[self.monsterCount].trap and self.monstervalue[self.monsterCount].trap[1] == "1" then
			self.selectNumBg1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.3, -1, 1), cc.DelayTime:create(0.3), cc.CallFunc:create(function()
				self.selectNumBg1:loadTextures(self.respath .. "trap_bg.png", nil, self.respath .. "trap_bg.png")
				self.select1:loadTexture(self.respath .. "select_red.png", nil, self.respath .. "select_red.png")
				self.select1:setPosition(self.selectNumBg1:getContentSize().width / 2, self.selectNumBg1:getContentSize().height / 2)

				self.label1.number = tonumber(var_23_0.trap[3])
				self.label1.operation = tonumber(var_23_0.trap[2])

				self.label1.update()
				self.label1:setPosition(self.selectNumBg1:getContentSize().width / 2, self.selectNumBg1:getContentSize().height / 2)
			end), cc.ScaleTo:create(0.3, 1, 1), cc.DelayTime:create(0.5), cc.CallFunc:create(function()
				var_22_0:setVisible(false)

				self.number = tonumber(var_23_0.trap[3])
				self.operation = tonumber(var_23_0.trap[2])

				self:updateScore()
				self:startGame()
			end)))
		else
			self.selectNumBg1:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
				var_22_0:setVisible(false)

				self.number = self.label1.number
				self.operation = self.label1.operation

				self:updateScore()
				self:startGame()
			end)))
		end
	end)

	self.selectNumBg1 = var_22_1

	local var_22_3 = cc.Label:createWithTTF("+1", FONT_NAME, 70)

	var_22_1:addChild(var_22_3)
	var_22_3:setPosition(var_22_1:getContentSize().width / 2, var_22_1:getContentSize().height / 2)

	var_22_3.number = 1
	var_22_3.operation = 1
	self.label1 = var_22_3

	function var_22_3.update()
		var_22_3:setString(var_0_15[var_22_3.operation] .. var_22_3.number)
	end

	local var_22_4 = ccui.Button:create(self.respath .. "normal_bg.png", nil, self.respath .. "normal_bg.png")

	var_22_4:setPosition(480, 1100 - GameDisplay.fix_y)
	var_22_0:addChild(var_22_4)

	local var_22_5 = ccui.ImageView:create(self.respath .. "select_purple.png")

	var_22_5:setPosition(var_22_4:getContentSize().width / 2, var_22_4:getContentSize().height / 2)
	var_22_5:setVisible(false)

	self.select2 = var_22_5

	var_22_4:addChild(var_22_5)
	var_22_4:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_28_0:setTouchEnabled(false)
		self.select2:setVisible(true)
		self.select1:setVisible(false)

		local var_28_0 = self.monstervalue[self.monsterCount]

		if self.monstervalue[self.monsterCount].trap and self.monstervalue[self.monsterCount].trap[1] == "2" then
			self.selectNumBg2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.3, -1, 1), cc.DelayTime:create(0.3), cc.CallFunc:create(function()
				self.selectNumBg2:loadTextures(self.respath .. "trap_bg.png", nil, self.respath .. "trap_bg.png")
				self.select2:loadTexture(self.respath .. "select_red.png", nil, self.respath .. "select_red.png")
				self.select2:setPosition(self.selectNumBg1:getContentSize().width / 2, self.selectNumBg1:getContentSize().height / 2)

				self.label2.number = tonumber(var_28_0.trap[3])
				self.label2.operation = tonumber(var_28_0.trap[2])

				self.label2.update()
				self.label2:setPosition(self.selectNumBg1:getContentSize().width / 2, self.selectNumBg1:getContentSize().height / 2)
			end), cc.ScaleTo:create(0.3, 1, 1), cc.DelayTime:create(0.5), cc.CallFunc:create(function()
				var_22_0:setVisible(false)

				self.number = tonumber(var_28_0.trap[3])
				self.operation = tonumber(var_28_0.trap[2])

				self:updateScore()
				self:startGame()
			end)))
		else
			self.selectNumBg2:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
				var_22_0:setVisible(false)

				self.number = self.label2.number
				self.operation = self.label2.operation

				self:updateScore()
				self:startGame()
			end)))
		end
	end)

	self.selectNumBg2 = var_22_4

	local var_22_6 = cc.Label:createWithTTF("+2", FONT_NAME, 70)

	var_22_4:addChild(var_22_6)
	var_22_6:setPosition(var_22_4:getContentSize().width / 2, var_22_4:getContentSize().height / 2)

	var_22_6.number = 2
	var_22_6.operation = 1
	self.label2 = var_22_6

	function var_22_6.update()
		var_22_6:setString(var_0_15[var_22_6.operation] .. var_22_6.number)
	end
end

function ActivityCompareLayer:popSelectNumberWind()
	self.select = 1

	self.select1:setVisible(true)
	self.select2:setVisible(false)
	self.layout:setVisible(true)
	print(dump(self.monstervalue[self.monsterCount]), self.monsterCount)

	self.label1.number = tonumber(self.monstervalue[self.monsterCount].select[1])
	self.label1.operation = tonumber(self.monstervalue[self.monsterCount].operation[1])

	self.label1.update()

	self.label2.number = tonumber(self.monstervalue[self.monsterCount].select[2])
	self.label2.operation = tonumber(self.monstervalue[self.monsterCount].operation[2])

	self.label2.update()
	self.selectNumBg1:loadTextures(self.respath .. "normal_bg.png", nil, self.respath .. "normal_bg.png")
	self.selectNumBg2:loadTextures(self.respath .. "normal_bg.png", nil, self.respath .. "normal_bg.png")
	self.select1:loadTexture(self.respath .. "select_purple.png")
	self.select2:loadTexture(self.respath .. "select_purple.png")
	self.select1:setPosition(self.selectNumBg1:getContentSize().width / 2, self.selectNumBg1:getContentSize().height / 2)
	self.select2:setPosition(self.selectNumBg2:getContentSize().width / 2, self.selectNumBg2:getContentSize().height / 2)

	self.enemyNum = self.monstervalue[self.monsterCount].value

	self.monsterNumLabel:setString(self.enemyNum)
end

function ActivityCompareLayer:startGame()
	self.gameStart = true

	self.player:play("run", true)
	self.selectNumBg1:setTouchEnabled(true)
	self.selectNumBg2:setTouchEnabled(true)
end

function ActivityCompareLayer:updateScore()
	if self.operation == 1 then
		self.initNumber = self.initNumber + self.number
	elseif self.operation == 2 then
		self.initNumber = self.initNumber - self.number
	elseif self.operation == 3 then
		self.initNumber = self.initNumber * self.number
	elseif self.operation == 4 then
		self.initNumber = self.initNumber / self.number
	end

	self.initNumber = math.floor(self.initNumber)

	if self.initNumber > 0 then
		self.player.update(math.floor(self.initNumber / 10))
	end

	self.addNumLabel:setVisible(true)
	print(self.operation, var_0_15[self.operation], self.number, "nnnnnnnnn")
	self.addNumLabel:setString(var_0_15[self.operation] .. self.number)
	self.addNumLabel:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		self.addNumLabel:setVisible(false)
	end)))
end

function ActivityCompareLayer:reduceScore()
	self.initNumber = self.initNumber - self.enemyNum
	self.initNumber = math.floor(self.initNumber)

	if self.initNumber > 0 then
		self.player.update(math.floor(self.initNumber / 10))
	end

	if self.initNumber <= 0 then
		self.gameStart = false

		self.failLayer:setVisible(true)

		self.fail = true
	end

	self.addNumLabel:setVisible(true)
	self.addNumLabel:setString(var_0_15[2] .. self.enemyNum)
	self.addNumLabel:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		self.addNumLabel:setVisible(false)
	end)))
end

function ActivityCompareLayer:initSelectWheel()
	local var_39_0 = cc.Layer:create()

	self.rootlayer:addChild(var_39_0)
	var_39_0:setVisible(false)

	self.wheelLayer = var_39_0

	local var_39_1 = ccui.ImageView:create(self.respath .. "select_wheel.png")

	var_39_0:addChild(var_39_1)
	var_39_1:setPosition(320, -GameDisplay.fix_y)

	local var_39_2 = cc.Label:createWithTTF(var_0_15[self.wheelData.operation[1]] .. self.wheelData.value[1], FONT_NAME, 24)

	var_39_2:setRotation(-30)
	var_39_1:addChild(var_39_2)
	var_39_2:setPosition(260, 700)

	local var_39_3 = cc.Label:createWithTTF(var_0_15[self.wheelData.operation[2]] .. self.wheelData.value[2], FONT_NAME, 24)

	var_39_3:setRotation(5)
	var_39_1:addChild(var_39_3)
	var_39_3:setPosition(420, 735)

	local var_39_4 = cc.Label:createWithTTF(var_0_15[self.wheelData.operation[3]] .. self.wheelData.value[3], FONT_NAME, 24)

	var_39_4:setRotation(20)
	var_39_1:addChild(var_39_4)
	var_39_4:setPosition(510, 720)

	local var_39_5 = cc.Label:createWithTTF(var_0_15[self.wheelData.operation[4]] .. self.wheelData.value[4], FONT_NAME, 24)

	var_39_5:setRotation(35)
	var_39_1:addChild(var_39_5)
	var_39_5:setPosition(600, 670)

	local var_39_6 = cc.Node:create()

	var_39_6:setPosition(320, -GameDisplay.fix_y)
	var_39_6:setAnchorPoint(0, 0)
	var_39_0:addChild(var_39_6)
	var_39_6:setRotation(-45)

	self.node = var_39_6

	self.node:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.RotateTo:create(1, 45), cc.RotateTo:create(1, -45))))

	local var_39_7 = ccui.ImageView:create(self.respath .. "arrow.png")

	var_39_6:addChild(var_39_7)
	var_39_7:setPosition(0, 0)

	local var_39_8 = ccui.Button:create(self.respath .. "btn_stop.png", nil, self.respath .. "btn_stop_off.png")

	var_39_0:addChild(var_39_8)
	var_39_8:addTouchEventListener(function(arg_40_0, arg_40_1)
		if arg_40_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_39_6:stopAllActions()

		local var_40_0 = var_39_6:getRotation()

		if var_40_0 < 0 then
			self.operation = self.wheelData.operation[1]
			self.number = self.wheelData.value[1]
		elseif var_40_0 < 15 then
			self.operation = self.wheelData.operation[2]
			self.number = self.wheelData.value[2]
		elseif var_40_0 < 25 then
			self.operation = self.wheelData.operation[3]
			self.number = self.wheelData.value[3]
		elseif var_40_0 < 45 then
			self.operation = self.wheelData.operation[4]
			self.number = self.wheelData.value[4]
		end

		self:updateScore()
		self.wheelLayer:setVisible(false)

		self.startFight = true
	end)
	var_39_8:setPosition(320, 150 - GameDisplay.fix_y)
end

function ActivityCompareLayer:initSucces()
	local var_41_0 = ccui.Layout:create()

	var_41_0:setContentSize(cc.size(640, 1600))
	var_41_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_41_0:setCascadeOpacityEnabled(false)
	var_41_0:setBackGroundColorOpacity(128)
	var_41_0:setAnchorPoint(0.5, 0.5)
	var_41_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_41_0:setTouchEnabled(true)
	var_41_0:setLocalZOrder(1000)
	self.rootlayer:addChild(var_41_0)
	var_41_0:setPosition(GameDisplay.cx, GameDisplay.cy)
	var_41_0:addTouchEventListener(function(arg_42_0, arg_42_1)
		if arg_42_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_41_0:setVisible(false)
		AnalyticManager.clickCompareGame({
			ctype = "finish",
			level = self.initLevel
		})
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	var_41_0:setVisible(false)

	self.successLayer = var_41_0

	local var_41_1 = ccui.ImageView:create("ChapterSettlement/title_win_fight.png", var_0_0)

	var_41_0:addChild(var_41_1)
	var_41_1:setPosition(320, 860 - GameDisplay.fix_y * 2)
	var_41_1:setLocalZOrder(9)

	local var_41_2 = ccui.ImageView:create("role/" .. model_data[global_get_servant_skin(self.servantid)].role_image .. ".png")

	var_41_0:addChild(var_41_2)
	var_41_2:setPosition(420, GameDisplay.cy + 220 - GameDisplay.fix_y)
end

function ActivityCompareLayer:initFail()
	local var_43_0 = ccui.Layout:create()

	var_43_0:setContentSize(cc.size(640, 1600))
	var_43_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_43_0:setCascadeOpacityEnabled(false)
	var_43_0:setBackGroundColorOpacity(128)
	var_43_0:setAnchorPoint(0.5, 0.5)
	var_43_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_43_0:setTouchEnabled(true)
	var_43_0:setLocalZOrder(1000)
	self.rootlayer:addChild(var_43_0)
	var_43_0:setPosition(GameDisplay.cx, GameDisplay.cy)
	var_43_0:addTouchEventListener(function(arg_44_0, arg_44_1)
		if arg_44_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_43_0:setVisible(false)
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	var_43_0:setVisible(false)

	self.failLayer = var_43_0

	local var_43_1 = ccui.ImageView:create("LevelResultLayer/title_lose_fight.png", var_0_0)

	var_43_0:addChild(var_43_1)
	var_43_1:setPosition(320, 860 - GameDisplay.fix_y * 2)
	var_43_1:setLocalZOrder(9)

	local var_43_2 = ccui.ImageView:create("role/" .. model_data[global_get_servant_skin(self.servantid)].role_image .. ".png")

	var_43_0:addChild(var_43_2)
	var_43_2:setPosition(420, GameDisplay.cy + 220 - GameDisplay.fix_y)
end

function ActivityCompareLayer:getAward()
	network:rpc("get_activity_bidaxiao_reward", {
		activityid = self.activityid,
		level = self.activityid .. "-" .. self.initLevel
	}, function(arg_46_0)
		print(dump(arg_46_0), "msssssssggg")

		if arg_46_0.result == 1 and arg_46_0.items and #arg_46_0.items > 0 then
			global_get({
				items = arg_46_0.items,
				gold = arg_46_0.gold,
				diamond = arg_46_0.diamond
			})
		end
	end)
end

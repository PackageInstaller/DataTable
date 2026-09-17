ExpeditionLayer = class("ExpeditionLayer", function()
	return cc.Layer:create()
end)

local expedition_manager = require("controller.expedition_manager")

require("view.Sprite.GirlSprite")

local l2utils = require("controller.l2utils")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local audio_manager = require("controller.audio_manager")
local expedition_total_skill_data = require("data.expedition_total_skill_data")
local playermodel = require("model.playermodel")
local var_0_7 = config._DEBUG and 0 or 1
local var_0_8 = {
	{
		cc.p(320, 0)
	},
	{
		cc.p(218, 0),
		cc.p(422, 0)
	},
	{
		cc.p(110, 0),
		cc.p(320, 0),
		cc.p(530, 0)
	}
}
local var_0_9 = {
	cc.p(90, 130),
	cc.p(290, 130),
	cc.p(490, 130)
}
local var_0_10 = {
	Free = 1,
	NeedEvent = 3,
	NeedResult = 4,
	NeedBattle = 2
}
local var_0_11 = {
	CanOperate = 3,
	HaveGot = 1,
	NotOperate = 4,
	HaveMiss = 2
}
local var_0_12 = {
	Reborn = 2,
	Recruit = 3,
	Skill = 4,
	Blood = 1
}
local var_0_13 = {
	"ExpeditionLayer/bg_start.png",
	"ExpeditionLayer/bg1.png",
	"ExpeditionLayer/bg2.png",
	"ExpeditionLayer/bg4.png",
	"ExpeditionLayer/bg3.png",
	"ExpeditionLayer/bg5.png",
	"ExpeditionLayer/bg_boss.png",
	"",
	"ExpeditionLayer/bg1.png",
	"ExpeditionLayer/bg2.png",
	"ExpeditionLayer/bg_boss.png",
	"ExpeditionLayer/bg_lock.png"
}
local var_0_14 = {
	"ExpeditionLayer/bg_start_finish.png",
	"ExpeditionLayer/bg_finish.png",
	"ExpeditionLayer/bg_finish.png",
	"ExpeditionLayer/bg_finish.png",
	"ExpeditionLayer/bg_finish.png",
	"ExpeditionLayer/bg_finish.png",
	"",
	"",
	"ExpeditionLayer/bg_finish.png",
	"ExpeditionLayer/bg_finish.png",
	""
}
local var_0_15 = {
	"ExpeditionLayer/icon_start.png",
	"ExpeditionLayer/icon_1.png",
	"ExpeditionLayer/icon_2.png",
	"ExpeditionLayer/icon_4.png",
	"ExpeditionLayer/icon_3.png",
	"ExpeditionLayer/icon_5.png",
	"ExpeditionLayer/icon_boss.png",
	"",
	"ExpeditionLayer/icon_1.png",
	"ExpeditionLayer/icon_2.png",
	"ExpeditionLayer/icon_boss.png",
	"ExpeditionLayer/icon_lock.png"
}
local var_0_16 = {
	START = "ExpeditionLayer/bg_start.png",
	BOSS = "ExpeditionLayer/bg_boss.png"
}
local var_0_17 = "ExpeditionLayer/line.png"
local var_0_18 = "ExpeditionLayer/line_bg.png"

function ExpeditionLayer.create(arg_2_0, ...)
	local var_2_0 = ExpeditionLayer.new()

	var_2_0:init(...)

	return var_2_0
end

function ExpeditionLayer:onLoad(arg_3_1)
	local var_3_0 = ccui.Layout:create()

	var_3_0:setTouchEnabled(true)
	var_3_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_3_0:setAnchorPoint(cc.p(0, 0))
	var_3_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_3_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_3_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_3_0:setOpacity(0)
	var_3_0:setCascadeOpacityEnabled(false)
	self:addChild(var_3_0, -1)

	local var_3_1 = ccui.ImageView:create("mainScenebg/expedition_bg.png")

	var_3_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_1:setPositionX(var_3_0:getContentSize().width / 2)
	var_3_1:setPositionY(var_3_0:getContentSize().height / 2)
	var_3_0:addChild(var_3_1)

	local var_3_2 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_3_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_2:setPositionX(var_3_0:getContentSize().width / 2)
	var_3_2:setPositionY(var_3_0:getContentSize().height / 2)
	var_3_0:addChild(var_3_2)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_4_0)
		self:addChild(arg_4_0, -2)
		arg_4_0:setPositionY(arg_4_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_3_1)
		var_3_0:setOpacity(102)
		var_3_0:setTouchEnabled(false)
	end)
end

function ExpeditionLayer:init(arg_5_1)
	self.scheduler = cc.Director:getInstance():getScheduler()
	expedition_manager.updateMainCoinNumCallback = self.updateCoinNum
	self.initconfig = arg_5_1 or {
		inittype = 119
	}

	RoleDefault:getInstance():setBoolForKey("ExpeditionLayer_" .. self.initconfig.inittype .. "_first", true)
	expedition_manager:setExpeditionParam(self.initconfig)

	self.root = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ExpeditionLayer.json" or "ExpeditionLayer.ExportJson")

	self:addChild(self.root)

	function self.onBtnBackCallback(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end

	self.mainNode = self.root:getChildByName("main")
	self.btn_back = BottomBtnList:create(self.onBtnBackCallback, nil, "ExpeditionLayer/di.png", {
		img = "ExpeditionLayer/btn_back.png",
		pos = cc.p(56, 35)
	})

	self.btn_back:setName("btn_back")
	self.mainNode:addChild(self.btn_back, 1)

	local var_5_0 = ccui.ImageView:create("ExpeditionLayer/tili_bg.png", var_0_7)

	var_5_0:setAnchorPoint(cc.p(0, 0))
	var_5_0:setPosition(cc.p(160, 10))

	local var_5_1 = ccui.Text:create(L_EXPEDITION_LAYER[5], FONT_DES, 24)

	var_5_1:setAnchorPoint(cc.p(0, 0))
	var_5_1:setPosition(cc.p(60, 13))
	var_5_1:setColor(cc.c3b(187, 187, 187))
	var_5_0:addChild(var_5_1)

	local var_5_2 = ccui.Text:create("", FONT_DES, 24)

	var_5_2:setAnchorPoint(cc.p(0, 0))
	var_5_2:setPosition(cc.p(180, 13))
	var_5_2:setColor(cc.c3b(199, 253, 255))

	self.coinNumNode = var_5_2

	var_5_0:addChild(var_5_2)
	self.btn_back:addChild(var_5_0)
	self.mainNode:setVisible(true)
	self.mainNode:getChildByName("title"):setTouchEnabled(true)

	self.timeNode = self.mainNode:getChildByName("time")
	self.levelNode = self.mainNode:getChildByName("level")
	self.btn_team = self.mainNode:getChildByName("btn_team")
	self.btn_skill_profit = self.mainNode:getChildByName("btn_skill_profit")
	self.btn_shop = self.mainNode:getChildByName("btn_shop")

	self.btn_team:setLocalZOrder(1)
	self.btn_skill_profit:setLocalZOrder(1)
	self.btn_shop:setLocalZOrder(1)
	self.btn_team:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:showHaveStudentPanel()
	end)
	self.btn_skill_profit:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:showHaveSkillPanel()
	end)
	self.btn_shop:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("shop")

		if self:getChildByName("eShopLayer") then
			self:getChildByName("eShopLayer"):removeFromParent()
		end

		require("view/Layer/ExpeditionShopLayer")

		local var_9_0 = ExpeditionShopLayer:create({
			initmode = expedition_manager:getExpeditionInfo().initmode,
			closeCallback = function()
				self:updateCoinNum()
				self:updateTaskAlert()
			end
		})

		var_9_0:setName("eShopLayer")
		self:addChild(var_9_0)
	end)

	self.selectStudentNode = self.root:getChildByName("select_student")
	self.selectSkillNode = self.root:getChildByName("select_skill")
	self.btn_confirm1 = self.selectStudentNode:getChildByName("btn_confirm")
	self.btn_confirm2 = self.selectSkillNode:getChildByName("btn_confirm")

	self.selectStudentNode:setVisible(false)
	self.selectSkillNode:setVisible(false)
	self.selectStudentNode:getChildByName("bg"):setBackGroundImage("mainScenebg/expedition_mask.png")
	self.selectSkillNode:getChildByName("bg"):setBackGroundImage("mainScenebg/expedition_mask.png")

	self.showSkillNode = self.root:getChildByName("show_skill")

	self.showSkillNode:setVisible(false)
	self.showSkillNode:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.showSkillNode:setVisible(false)
	end)

	local var_5_3 = ccui.Button:create("ExpeditionLayer/btn_restart.png", "ExpeditionLayer/btn_restart.png", "ExpeditionLayer/btn_restart.png", var_0_7)

	var_5_3:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_12_0 = ConfirmDialogSprite:create(L_EXPEDITION_LAYER[6], L_EXPEDITION_LAYER[7], {
			surecallback = function()
				expedition_manager:reset_expedition(function()
					self:initPanel()
				end)
			end
		})

		global_basic_scene:addChild(var_12_0, 10)
		var_12_0:setName("dialog")
	end)
	var_5_3:setVisible(true)
	var_5_3:setName("btn_reset")
	var_5_3:setPosition(cc.p(110, 115))
	self.mainNode:addChild(var_5_3, 99)

	local var_5_4 = ccui.Button:create("ExpeditionLayer/btn_task.png", nil, "ExpeditionLayer/btn_task.png", var_0_7)

	var_5_4:setPosition(cc.p(550, 32))
	self.mainNode:addChild(var_5_4, 98)
	var_5_4:setName("btnTask")
	var_5_4:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("ExpeditionTaskLayer", {
			returnLayer = self.__cname
		})
	end)

	self.btnTask = var_5_4

	local var_5_5 = ccui.Button:create("ExpeditionLayer/shop_btn.png", nil, "ExpeditionLayer/shop_btn.png", var_0_7)

	var_5_5:setPosition(cc.p(550, 120))
	self.mainNode:addChild(var_5_5, 98)
	var_5_5:setName("btnShop")
	var_5_5:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("MarketLayer", {
			returnLayer = self.__cname,
			singleMarket = {
				"1-49"
			}
		})
	end)

	self.btnShop = var_5_5

	self.btn_skill_profit:setPositionX(180 + 85)
	self.btn_team:setPositionX(180 + 170)
	self.btn_shop:setPositionX(180 + 255)
	self.btnShop:setPositionX(180 + 340 + 50)

	local var_5_6 = ccui.Button:create("ExpeditionLayer/new_weihao.png", nil, "ExpeditionLayer/new_weihao.png", var_0_7)

	var_5_6:setPosition(cc.p(285, 1052))
	self.mainNode:addChild(var_5_6, 98)
	var_5_6:setName("btn_tip")
	var_5_6:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "expedition_layer"
		})
	end)

	self.btn_tip = var_5_6

	self:createBattleFieldStatusPanel()
	self:initItemNode()
	self:initPanel()
	self:fullscreen()
	self:registerScriptHandler(function(arg_18_0)
		if arg_18_0 == "exit" then
			if self.cinemaScheduler ~= nil then
				self.scheduler:unscheduleScriptEntry(self.cinemaScheduler)

				self.cinemaScheduler = nil
			end

			if self.timeScheduler ~= nil then
				self.scheduler:unscheduleScriptEntry(self.timeScheduler)

				self.timeScheduler = nil
			end

			if self.usualScheduler ~= nil then
				self.scheduler:unscheduleScriptEntry(self.usualScheduler)

				self.usualScheduler = nil
			end

			expedition_manager.updateMainCoinNumCallback = nil
		end
	end)
end

function ExpeditionLayer:updateTimeCountDown()
	local var_19_0 = expedition_manager:getLeftTimeStr()

	if var_19_0 ~= nil then
		self.timeNode:setVisible(true)
		self.timeNode:setString(var_19_0)

		if self.timeScheduler ~= nil then
			self.scheduler:unscheduleScriptEntry(self.timeScheduler)

			self.timeScheduler = nil
		end

		self.timeScheduler = self.scheduler:scheduleScriptFunc(function()
			self:updateTimeCountDown()
		end, 60, false)
	else
		self.timeNode:setVisible(false)
	end
end

function ExpeditionLayer:createBattleFieldStatusPanel()
	local var_21_0 = ccui.ImageView:create("ArenaLayer/team_skill_bg.png", var_0_7)

	var_21_0:setAnchorPoint(cc.p(1, 1))
	var_21_0:setPosition(cc.p(GameDisplay.width, 1100 + GameDisplay.fix_y * 2))
	var_21_0:setName("battlefieldStatusPanel")
	self.mainNode:addChild(var_21_0, 98)

	self.battlefieldStatusPanel = var_21_0

	local var_21_1 = ccui.ImageView:create()

	var_21_1:setName("iconBackImg")
	var_21_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_21_1:setPosition(cc.p(20, var_21_0:getContentSize().height / 2))
	var_21_1:setScale(0.7)
	var_21_0:addChild(var_21_1)

	local var_21_2 = ccui.ImageView:create()

	var_21_2:setName("iconImg")
	var_21_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_21_2:setPosition(cc.p(20, var_21_0:getContentSize().height / 2))
	var_21_2:setScale(0.7)
	var_21_0:addChild(var_21_2)

	local var_21_3 = ccui.Layout:create()

	var_21_3:setContentSize(cc.size(var_21_0:getContentSize()))
	var_21_3:setPosition(cc.p(0, var_21_0:getContentSize().height / 2))
	var_21_3:setName("textPanel")
	var_21_0:addChild(var_21_3)
	self.battlefieldStatusPanel:setVisible(false)
end

function ExpeditionLayer:updateBattleFieldStatusPanel()
	local var_22_0 = expedition_manager:get_expedition_battlefield_status()

	if not var_22_0 or #var_22_0 == 0 then
		self.battlefieldStatusPanel:setVisible(false)

		return
	end

	local var_22_1 = {}
	local var_22_2 = expedition_manager:get_expedition_battlefield_status_info()

	for iter_22_0 = 1, #var_22_2 do
		table.insert(var_22_1, {
			des = var_22_2[iter_22_0].des,
			icon = expedition_manager:get_expedition_battlefield_status_localicon(var_22_0[iter_22_0])
		})
	end

	self.battlefieldStatusPanel:setVisible(true)

	local var_22_3 = self.battlefieldStatusPanel:getChildByName("textPanel")

	var_22_3:removeAllChildren()

	local var_22_4 = self.battlefieldStatusPanel:getChildByName("iconBackImg")
	local var_22_5 = self.battlefieldStatusPanel:getChildByName("iconImg")

	var_22_4:loadTexture(var_22_1[1].icon, var_0_7)
	var_22_5:loadTexture(var_22_1[1].icon, var_0_7)

	local var_22_6 = 0.7

	var_22_4:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.7 / 5), cc.CallFunc:create(function()
		var_22_4:setScale(var_22_6)
		var_22_4:setOpacity(255)
	end), cc.Spawn:create(cc.ScaleTo:create(0.5, 0.7 * 2), cc.FadeOut:create(0.5)), cc.DelayTime:create(0.6))))

	local var_22_7 = {}

	for iter_22_1 = 1, #var_22_1 do
		local var_22_8 = cc.Label:createWithTTF(var_22_1[iter_22_1].des, FONT_NAME, 18)

		var_22_3:addChild(var_22_8)
		var_22_8:setAnchorPoint(cc.p(0, 0.5))
		var_22_8:setPosition(cc.p(40, var_22_3:getContentSize().height / 2))
		var_22_8:setOpacity(0)
		table.insert(var_22_7, var_22_8)
	end

	var_22_7[1]:setOpacity(255)

	if #var_22_7 > 1 then
		for iter_22_2 = 1, #var_22_7 do
			var_22_7[iter_22_2]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create((iter_22_2 - 1) * 3), cc.CallFunc:create(function()
				var_22_5:loadTexture(var_22_1[iter_22_2].icon, var_0_7)
				var_22_4:loadTexture(var_22_1[iter_22_2].icon, var_0_7)
			end), cc.FadeTo:create(0.2, 255), cc.DelayTime:create(2.6), cc.FadeTo:create(0.2, 0), cc.DelayTime:create((#var_22_7 - 1) * 3 - (iter_22_2 - 1) * 3))))
		end
	end

	var_22_3:setTouchEnabled(true)
	var_22_3:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "arena_status"
		})
	end)
end

function ExpeditionLayer:initPanel()
	print("刷新界面")
	expedition_manager:initInfo(self.initconfig.inittype, function()
		self:updateBattleFieldStatusPanel()
		self:updateTimeCountDown()
		self:updateTaskAlert()
		self:initItemNum()
		self:initLevelViewPanel()
	end)
end

local function var_0_19(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0) do
		if iter_28_1.status < 1 and iter_28_1.percent >= 100 then
			return true
		end
	end

	return false
end

function ExpeditionLayer.updateTaskAlert(arg_29_0)
	expedition_manager:get_player_expedition_task(function(arg_30_0)
		if var_0_19(arg_30_0) then
			global_add_alert_tag(arg_29_0.btnTask, {
				x = 163,
				y = 65
			})
		else
			global_remove_alert_tag(arg_29_0.btnTask)
		end
	end)
end

function ExpeditionLayer:updateCoinNum()
	expedition_manager:updateCoinNum()
	self:initItemNum()
end

function ExpeditionLayer:initItemNum()
	local var_32_0 = expedition_manager:getCoinList(true)

	if var_32_0 == nil then
		return
	end

	self.coinNumNode:setString(var_32_0.num)
end

function ExpeditionLayer:openSelectStudentPanel(arg_33_1)
	if arg_33_1 == nil then
		return
	end

	local var_33_0 = expedition_manager:getExpeditionTeamListInfo(arg_33_1.num)
	local var_33_1

	for iter_33_0 = 1, #var_33_0 do
		if var_33_0[iter_33_0].isNeedSelect == true then
			var_33_1 = iter_33_0

			break
		end
	end

	local var_33_2 = var_33_1
	local var_33_3 = #var_33_0

	if var_33_1 == nil or var_33_1 > #var_33_0 + 1 then
		print("起始学员posindex 不正确")
		print(var_33_1)
		print(#var_33_0)
		expedition_manager:clearTeamListSelectStatus()

		if type(arg_33_1.callback) == "function" then
			arg_33_1.callback()
		end

		return
	end

	self.selectStudentNode:setVisible(true)
	self.selectStudentNode:getChildByName("listView"):setVisible(false)
	self.btn_confirm1:setVisible(false)

	local var_33_4 = {
		200,
		110,
		20
	}

	local function var_33_5()
		local var_34_0 = self.selectStudentNode:getChildByName("listView")

		var_34_0:setPositionX(var_33_4[var_33_3 - var_33_2 + 1])
		var_34_0:removeAllItems()
		var_34_0:setVisible(true)

		self.lastSelectStudentIndex = nil

		local var_34_1 = 25
		local var_34_2 = var_33_3 - var_33_2 + 1

		if FORMATION_SHOW_GIRL_NUM == var_33_3 - var_33_2 + 1 then
			var_34_0:setScale(0.7)
			var_34_0:setContentSize(cc.size(var_34_0:getContentSize().width / 0.7, var_34_0:getContentSize().height))
		else
			var_34_0:setScale(1)
		end

		for iter_34_0 = var_33_2, var_33_3 do
			local var_34_3 = var_33_0[iter_34_0]
			local var_34_4 = self.studentItemNode:clone()

			var_34_4:setVisible(true)
			var_34_4:setName("studentItem" .. iter_34_0)

			local var_34_5

			if var_34_3.servantid then
				var_34_4.servantid = var_34_3.servantid

				var_34_4:removeAllChildren()

				var_34_5 = GirlSprite:create({
					initType = "arrayStyle"
				})

				var_34_5:setScale(1.2)
				var_34_5:update(var_34_3.servantid)
				var_34_5:setAnchorPoint(cc.p(0, 0))
				var_34_5:setPosition(cc.p(30, 0))
				var_34_5:getChildByName("rarityIcon"):setScale(1.08)
				var_34_5:imgScaleTo(1, 0)

				local var_34_6 = ccui.ImageView:create("ExpeditionLayer/rarity1.png", var_0_7)

				var_34_6:setName("rarity")
				var_34_6:setPosition(cc.p(25, 32 + var_34_1))
				var_34_5:addChild(var_34_6, 10)

				local var_34_7 = ccui.ImageView:create("ExpeditionLayer/rarity_bg.png", var_0_7)

				var_34_7:setName("type")
				var_34_7:setPosition(cc.p(65, 32 + var_34_1))
				var_34_5:addChild(var_34_7, 10)

				local var_34_8 = ccui.Text:create(L_EXPEDITION_LAYER[10], FONT_NAME, 16)

				var_34_8:setName("typeName")
				var_34_8:setPosition(cc.p(25, 10))
				var_34_7:addChild(var_34_8)

				if var_34_3.career ~= nil then
					var_34_7:setVisible(true)
					var_34_7:getChildByName("typeName"):setString(L_CAREER[SERVANT_CAREE_TBL[var_34_3.career]])
				else
					var_34_7:setVisible(false)
				end

				if var_34_3.rare ~= nil then
					var_34_6:setVisible(true)
					var_34_6:loadTexture("ExpeditionLayer/rarity" .. var_34_3.rare .. ".png", var_0_7)
				else
					var_34_6:setVisible(false)
				end

				var_34_4:addChild(var_34_5)
				var_34_5:setPositionY(-70)
			else
				var_34_5 = var_34_4:getChildByName("bg")

				var_34_5:setScale(1.2)

				local var_34_9 = var_34_4:getChildByName("type")
				local var_34_10 = var_34_4:getChildByName("rarity")

				if var_34_3.career ~= nil then
					var_34_9:setVisible(true)
					var_34_9:getChildByName("typeName"):setString(L_CAREER[SERVANT_CAREE_TBL[var_34_3.career]])
				else
					var_34_9:setVisible(false)
				end

				if var_34_3.rare ~= nil then
					var_34_10:setVisible(true)
					var_34_10:loadTexture("ExpeditionLayer/rarity" .. var_34_3.rare .. ".png", var_0_7)
				else
					var_34_10:setVisible(false)
				end

				var_34_5:setPositionY(70)
				var_34_4:getChildByName("select"):setPositionY(70)
			end

			local var_34_11 = var_34_4:getChildByName("select")

			var_34_5:setSwallowTouches(false)
			var_34_5:setTouchEnabled(true)

			var_34_5.index = iter_34_0

			var_34_5:addTouchEventListener(function(arg_35_0, arg_35_1)
				if arg_35_1 ~= ccui.TouchEventType.ended then
					return
				end

				if self.lastSelectStudentIndex ~= nil then
					local var_35_0 = var_34_0:getItem(self.lastSelectStudentIndex - 1)

					if var_35_0 and var_35_0:getChildByName("select") then
						var_35_0:getChildByName("select"):setVisible(false)
					end
				end

				if var_34_11 then
					-- block empty
				end

				self.lastSelectStudentIndex = arg_35_0.index

				local var_35_1

				if var_34_3.career ~= nil then
					var_35_1 = {}

					table.insert(var_35_1, SERVANT_CAREE_TBL[var_34_3.career])
				end

				local var_35_2

				if var_34_3.rare ~= nil then
					var_35_2 = {}

					table.insert(var_35_2, tonumber(var_34_3.rare))
				end

				local var_35_3 = {
					cursoul = var_34_3.servantid,
					arrayinfo = {
						index = 1,
						pos = arg_35_0.index
					},
					selectType = SELECT_GIRL_EXPEDITION,
					layerType = CONFIG_TYPE_EXPEDITION,
					selectGirlType = SELECT_GIRL_EXPEDITION,
					[SELECT_GIRL_EXPEDITION] = {
						sureCallBack = function(arg_36_0)
							if type(arg_33_1.updateCallback) == "function" then
								arg_33_1.updateCallback()
							end
						end
					},
					sureCallBack = function(arg_37_0)
						if type(arg_33_1.updateCallback) == "function" then
							arg_33_1.updateCallback()
						end
					end,
					filterTbl = {
						sortType = 1,
						bag_type = 12,
						filterConfig = {
							rarity = var_35_2,
							career = var_35_1
						}
					}
				}

				if var_34_2 == FORMATION_SHOW_GIRL_NUM then
					LayerManager:pushInLayer("QuickFormationLayer", var_35_3)
				else
					LayerManager:pushInLayer("GirlSelectLayer", var_35_3)
				end
			end)

			if var_34_2 == FORMATION_SHOW_GIRL_NUM and iter_34_0 == var_33_3 then
				local var_34_12 = ccui.Layout:create()

				var_34_12:setContentSize(cc.size(100, var_34_0:getContentSize().height))

				local var_34_13 = ccui.Button:create("ExpeditionLayer/auto_advance_force.png", "ExpeditionLayer/auto_advance_force.png", "ExpeditionLayer/auto_advance_force.png", var_0_7)

				var_34_12:addChild(var_34_13)
				var_34_13:setAnchorPoint(cc.p(0, 0))
				var_34_13:setPosition(cc.p(20, -150))
				var_34_13:addTouchEventListener(function(arg_38_0, arg_38_1)
					if arg_38_1 ~= ccui.TouchEventType.ended then
						return
					end

					local var_38_0 = playermodel.arrays[playermodel.curArray]

					for iter_38_0 = var_33_2, var_33_3 do
						if var_38_0["pos_" .. iter_38_0] and var_38_0["pos_" .. iter_38_0].fight_girl then
							expedition_manager:setExpeditionStudentList(iter_38_0, var_38_0["pos_" .. iter_38_0].fight_girl)
						end
					end

					if type(arg_33_1.updateCallback) == "function" then
						arg_33_1.updateCallback()
					end
				end)
				var_34_4:addChild(var_34_12)
			end

			var_34_0:pushBackCustomItem(var_34_4)
		end

		var_34_0:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
		var_34_0:refreshView()
		var_34_0:jumpToLeft()

		if not expedition_manager:isServantSelectReady() then
			l2utils:shaderGrayDark(self.btn_confirm1:getVirtualRenderer())
		else
			l2utils:recoverShader(self.btn_confirm1:getVirtualRenderer())
		end

		self.btn_confirm1:setVisible(true)

		self.btn_confirm1.isCanClick = true

		self.btn_confirm1:addTouchEventListener(function(arg_39_0, arg_39_1)
			if arg_39_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_39_0.isCanClick == false then
				return
			end

			arg_39_0.isCanClick = false

			if not expedition_manager:isServantSelectReady() then
				global_ShowBlockWords(L_EXPEDITION_LAYER[14])

				arg_39_0.isCanClick = true

				return
			end
		end)
		self.selectStudentNode:addTouchEventListener(function(arg_40_0, arg_40_1)
			if arg_40_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.selectStudentNode:setVisible(false)
		end)

		if arg_33_1.isAni and arg_33_1.isAni == true then
			-- block empty
		end
	end

	if self.selectStudentNode:getChildByName("bgLayer") then
		self.selectStudentNode:getChildByName("bgLayer"):removeFromParent()
	end

	if self.selectStudentNode:getChildByName("sp") then
		self.selectStudentNode:getChildByName("sp"):removeFromParent()
	end

	local var_33_6 = ccui.Layout:create()

	var_33_6:setTouchEnabled(true)
	var_33_6:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_33_6:setAnchorPoint(cc.p(0, 0))
	var_33_6:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_33_6:setBackGroundColor(cc.c3b(2, 5, 24))
	var_33_6:setOpacity(0)
	var_33_6:setCascadeOpacityEnabled(false)
	var_33_6:setName("bgLayer")
	self.selectStudentNode:addChild(var_33_6, -1)

	local var_33_7 = ccui.ImageView:create("mainScenebg/expedition_mask.png")

	var_33_7:setAnchorPoint(cc.p(0.5, 0.5))
	var_33_7:setPositionX(var_33_6:getContentSize().width / 2)
	var_33_7:setPositionY(var_33_6:getContentSize().height / 2)
	var_33_6:addChild(var_33_7)
	l2utils:captureScreenGaussBlur(function(arg_41_0)
		arg_41_0:setName("sp")
		self.selectStudentNode:addChild(arg_41_0, -2)
		var_33_5()
		var_33_6:setOpacity(102)
		var_33_6:setTouchEnabled(false)
	end)
end

function ExpeditionLayer:openSelectSkillPanel(arg_42_1)
	if arg_42_1 == nil then
		return
	end

	local var_42_0 = expedition_manager:getExpeditionSkillListInfo()
	local var_42_1 = false

	for iter_42_0 = 1, #var_42_0 do
		if var_42_0[iter_42_0].isNeedSelect == true then
			var_42_1 = true

			break
		end
	end

	local var_42_2 = expedition_manager:initSelectSkillInfo(arg_42_1.skillpoolid)
	local var_42_3 = 1
	local var_42_4 = #var_42_2

	if var_42_1 == false or #var_42_2 <= 0 then
		print("起始技能posindex 不正确")
		expedition_manager:clearSkillListSelectStatus()

		if type(arg_42_1.callback) == "function" then
			arg_42_1.callback()
		end

		return
	end

	self.selectSkillNode:setVisible(true)
	self.selectSkillNode:getChildByName("listView"):setVisible(false)
	self.btn_confirm2:setVisible(false)

	local function var_42_5()
		local var_43_0 = self.selectSkillNode:getChildByName("listView")

		var_43_0:removeAllItems()
		var_43_0:setTouchEnabled(true)
		var_43_0:setVisible(true)

		self.lastSelectSkillIndex = 1

		local var_43_1 = 100

		for iter_43_0 = var_42_3, var_42_4 do
			local var_43_2 = var_42_2[iter_43_0]
			local var_43_3 = self.skillItemNode:clone()

			var_43_3:setVisible(true)
			var_43_3:setName("skillItem" .. iter_43_0)

			local var_43_4 = var_43_3:getChildByName("bg")
			local var_43_5 = var_43_3:getChildByName("select")

			var_43_4:setSwallowTouches(false)
			var_43_4:setTouchEnabled(true)

			var_43_4.index = iter_43_0

			var_43_4:loadTextures("ExpeditionLayer/skill_bg" .. var_43_2.rare .. ".png", "ExpeditionLayer/skill_bg" .. var_43_2.rare .. ".png", "ExpeditionLayer/skill_bg" .. var_43_2.rare .. ".png", var_0_7)
			var_43_4:addTouchEventListener(function(arg_44_0, arg_44_1)
				if arg_44_1 ~= ccui.TouchEventType.ended then
					return
				end

				if self.lastSelectSkillIndex ~= nil then
					local var_44_0 = var_43_0:getItem(self.lastSelectSkillIndex - 1)

					if var_44_0 then
						var_44_0:getChildByName("select"):setVisible(false)
						var_44_0:setScale(1)
						var_44_0:getChildByName("bg"):setPositionY(var_43_1)
						var_44_0:getChildByName("select"):setPositionY(var_43_1)

						var_44_0.isSelected = nil
					end
				end

				var_43_5:setVisible(true)

				self.lastSelectSkillIndex = arg_44_0.index

				var_43_3:setScale(1.1)

				var_43_3.isSelected = true

				var_43_4:setPositionY(var_43_1)
				var_43_5:setPositionY(var_43_1)
				l2utils:recoverShader(self.btn_confirm2:getVirtualRenderer())
			end)

			if self.lastSelectSkillIndex == iter_43_0 then
				var_43_5:setVisible(true)
				var_43_3:setScale(1.1)

				var_43_3.isSelected = true

				var_43_4:setPositionY(100)
				var_43_5:setPositionY(100)
			else
				var_43_5:setVisible(false)
				var_43_3:setScale(1)
				var_43_4:setPositionY(100)
				var_43_5:setPositionY(100)
			end

			local var_43_6 = var_43_4:getContentSize().width
			local var_43_7 = var_43_4:getContentSize().height
			local var_43_8 = var_43_4:getChildByName("icon")
			local var_43_9 = var_43_4:getChildByName("name")

			var_43_9:setString(var_43_2.name)
			var_43_9:setAnchorPoint(cc.p(0.5, 0.5))
			var_43_9:setPosition(cc.p(var_43_6 / 2, var_43_7 / 2 - 15))
			var_43_8:loadTexture(var_43_2.iconPath, var_0_7)
			var_43_8:setAnchorPoint(cc.p(0.5, 0.5))
			var_43_8:setPosition(cc.p(var_43_6 / 2 + 0.5, var_43_7 / 2 + 61))
			var_43_8:setScale(0.98)
			var_43_4:getChildByName("des"):setString(var_43_2.des)
			var_43_0:pushBackCustomItem(var_43_3)
		end

		var_43_0:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
		var_43_0:refreshView()
		var_43_0:jumpToLeft()

		if self.lastSelectSkillIndex == nil then
			l2utils:shaderGrayDark(self.btn_confirm2:getVirtualRenderer())
		else
			l2utils:recoverShader(self.btn_confirm2:getVirtualRenderer())
		end

		self.btn_confirm2:setVisible(true)

		self.btn_confirm2.isCanClick = true

		self.btn_confirm2:addTouchEventListener(function(arg_45_0, arg_45_1)
			if arg_45_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_45_0.isCanClick == false then
				return
			end

			arg_45_0.isCanClick = false

			if not expedition_manager:isHaveSkillSelected() and self.lastSelectSkillIndex == nil then
				global_ShowBlockWords(L_EXPEDITION_LAYER[15])

				arg_45_0.isCanClick = true

				return
			end

			expedition_manager:set_expedition_skill(var_42_2[self.lastSelectSkillIndex].skillid, function()
				if type(arg_42_1.callback) == "function" then
					arg_42_1.callback()
				end

				self.selectSkillNode:setVisible(false)

				arg_45_0.isCanClick = true
			end)
		end)
		self.selectSkillNode:addTouchEventListener(function(arg_47_0, arg_47_1)
			if arg_47_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.selectSkillNode:setVisible(false)
		end)

		if arg_42_1.isAni and arg_42_1.isAni == true then
			-- block empty
		end
	end

	if self.selectSkillNode:getChildByName("bgLayer") then
		self.selectSkillNode:getChildByName("bgLayer"):removeFromParent()
	end

	if self.selectSkillNode:getChildByName("sp") then
		self.selectSkillNode:getChildByName("sp"):removeFromParent()
	end

	local var_42_6 = ccui.Layout:create()

	var_42_6:setTouchEnabled(true)
	var_42_6:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_42_6:setAnchorPoint(cc.p(0, 0))
	var_42_6:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_42_6:setBackGroundColor(cc.c3b(2, 5, 24))
	var_42_6:setOpacity(0)
	var_42_6:setCascadeOpacityEnabled(false)
	var_42_6:setName("bgLayer")
	self.selectSkillNode:addChild(var_42_6, -1)

	local var_42_7 = ccui.ImageView:create("mainScenebg/expedition_mask.png")

	var_42_7:setAnchorPoint(cc.p(0.5, 0.5))
	var_42_7:setPositionX(var_42_6:getContentSize().width / 2)
	var_42_7:setPositionY(var_42_6:getContentSize().height / 2)
	var_42_6:addChild(var_42_7)
	l2utils:captureScreenGaussBlur(function(arg_48_0)
		arg_48_0:setName("sp")
		self.selectSkillNode:addChild(arg_48_0, -2)
		var_42_5()
		var_42_6:setOpacity(102)
		var_42_6:setTouchEnabled(false)
	end)
end

function ExpeditionLayer:fullscreen()
	self.root:setPosition(cc.p(0, -GameDisplay.fix_y))

	for iter_49_0, iter_49_1 in pairs({
		"btn_team",
		"btn_skill_profit",
		"btn_reset",
		"btnTask",
		"btnShop"
	}) do
		local var_49_0 = self.mainNode:getChildByName(iter_49_1)

		var_49_0:setLocalZOrder(1)

		var_49_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_49_0:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

		var_49_0:setPositionY(var_49_0.full_posY)
	end

	for iter_49_2, iter_49_3 in pairs({
		"title",
		"level_tip",
		"level",
		"time_tip",
		"time",
		"btn_tip"
	}) do
		local var_49_1 = self.mainNode:getChildByName(iter_49_3)

		var_49_1:setLocalZOrder(1)

		var_49_1.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - var_49_1:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

		var_49_1:setPositionY(var_49_1.full_posY)
	end

	self.mainNode:getChildByName("level_tip"):setString(L_EXPEDITION_LAYER[8])
	self.mainNode:getChildByName("time_tip"):setString(L_TIME_TWO)
	self.selectStudentNode:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))
	self.selectSkillNode:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))
	self.selectStudentNode:getChildByName("bg"):setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))
	self.selectSkillNode:getChildByName("bg"):setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))

	for iter_49_4, iter_49_5 in pairs((self.selectStudentNode:getChildren())) do
		if iter_49_5:getName() ~= "bg" then
			iter_49_5:setLocalZOrder(1)

			iter_49_5.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - iter_49_5:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

			iter_49_5:setPositionY(iter_49_5.full_posY)
		end
	end

	for iter_49_6, iter_49_7 in pairs((self.selectSkillNode:getChildren())) do
		if iter_49_7:getName() ~= "bg" then
			iter_49_7:setLocalZOrder(1)

			iter_49_7.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - iter_49_7:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

			iter_49_7:setPositionY(iter_49_7.full_posY)
		end
	end

	local var_49_4 = self.showSkillNode:getChildByName("bg")

	var_49_4:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))
	var_49_4:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))

	local var_49_5 = self.showSkillNode:getChildByName("title")

	var_49_5.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - var_49_5:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	var_49_5:setPositionY(var_49_5.full_posY)
end

function ExpeditionLayer:initItemNode()
	self.mainItemNode = ccui.Layout:create()

	self.mainItemNode:setPosition(cc.p(300, 300))
	self.mainItemNode:setAnchorPoint(cc.p(0.5, 0.5))
	self.mainItemNode:setTouchEnabled(false)
	self.root:addChild(self.mainItemNode)

	local var_50_0 = ccui.ImageView:create("ExpeditionLayer/select_level_kuang.png", var_0_7)

	var_50_0:setVisible(false)
	var_50_0:setName("select")
	self.mainItemNode:addChild(var_50_0, 1)

	local var_50_1 = ccui.Button:create("ExpeditionLayer/bg1.png", "ExpeditionLayer/bg1.png", "ExpeditionLayer/bg1.png", var_0_7)

	var_50_1:setName("bg")
	self.mainItemNode:addChild(var_50_1, 2)

	local var_50_2 = var_50_1:getContentSize().width
	local var_50_3 = var_50_1:getContentSize().height
	local var_50_4 = ccui.ImageView:create("ExpeditionLayer/icon_1.png", var_0_7)

	var_50_4:setName("icon")
	self.mainItemNode:addChild(var_50_4, 2)

	local var_50_5 = ccui.ImageView:create("ExpeditionLayer/showname_bg.png", var_0_7)

	var_50_5:setPosition(cc.p(0, -var_50_3 / 2 + 22))
	var_50_5:setName("namebg")
	self.mainItemNode:addChild(var_50_5, 2)

	local var_50_6 = ccui.Text:create(L_EXPEDITION_LAYER[8], FONT_NAME, 22)

	var_50_6:setPosition(cc.p(0, -var_50_3 / 2 + 20))
	var_50_6:setName("name")
	self.mainItemNode:addChild(var_50_6, 2)

	local var_50_7 = ccui.ImageView:create("ExpeditionLayer/mask_lock.png", var_0_7)

	var_50_7:setName("mask")
	self.mainItemNode:addChild(var_50_7, 2)

	local var_50_8 = ccui.ImageView:create("ExpeditionLayer/line_bg.png", var_0_7)

	var_50_8:setAnchorPoint(cc.p(1, 0))
	var_50_8:setPosition(cc.p(17, var_50_3 / 2 - 12))
	var_50_8:setScaleX(1)
	var_50_8:setName("line1")
	self.mainItemNode:addChild(var_50_8, 0)

	local var_50_9 = ccui.ImageView:create("ExpeditionLayer/line_bg.png", var_0_7)

	var_50_9:setAnchorPoint(cc.p(1, 0))
	var_50_9:setPosition(cc.p(-17, var_50_3 / 2 - 12))
	var_50_9:setScaleX(-1)
	var_50_9:setName("line2")
	self.mainItemNode:addChild(var_50_9, 0)
	self.mainItemNode:setVisible(false)

	local var_50_10 = cc.p(0.5, 0.5)
	local var_50_11 = cc.p(110, 90 + 25)

	self.studentItemNode = ccui.Layout:create()

	self.studentItemNode:setAnchorPoint(var_50_10)
	self.studentItemNode:setContentSize(cc.size(170, 236))
	self.studentItemNode:setTouchEnabled(false)
	self.root:addChild(self.studentItemNode)

	local var_50_12 = ccui.ImageView:create("ExpeditionLayer/select_kuang.png", var_0_7)

	var_50_12:setVisible(false)
	var_50_12:setAnchorPoint(var_50_10)
	var_50_12:setPosition(var_50_11)
	var_50_12:setName("select")
	self.studentItemNode:addChild(var_50_12)

	local var_50_13 = ccui.Button:create("ExpeditionLayer/bg_select1.png", "ExpeditionLayer/bg_select1.png", "ExpeditionLayer/bg_select1.png", var_0_7)

	var_50_13:setAnchorPoint(var_50_10)
	var_50_13:setPosition(var_50_11)
	var_50_13:setName("bg")
	self.studentItemNode:addChild(var_50_13)

	local var_50_14 = var_50_13:getContentSize().width
	local var_50_15 = var_50_13:getContentSize().height
	local var_50_16 = ccui.ImageView:create("", var_0_7)

	var_50_16:setName("icon")
	var_50_16:setAnchorPoint(var_50_10)
	var_50_16:setPosition(var_50_11)
	self.studentItemNode:addChild(var_50_16)

	local var_50_17 = ccui.ImageView:create("ExpeditionLayer/rarity1.png", var_0_7)

	var_50_17:setName("rarity")
	var_50_17:setPosition(cc.p(62, -75))
	self.studentItemNode:addChild(var_50_17)

	local var_50_18 = ccui.ImageView:create("ExpeditionLayer/rarity_bg.png", var_0_7)

	var_50_18:setName("type")
	var_50_18:setPosition(cc.p(112, -75))
	self.studentItemNode:addChild(var_50_18)

	local var_50_19 = ccui.Text:create(L_EXPEDITION_LAYER[9], FONT_NAME, 16)

	var_50_19:setName("typeName")
	var_50_19:setPosition(cc.p(25, 10))
	var_50_18:addChild(var_50_19)
	self.studentItemNode:setVisible(false)

	local var_50_20 = cc.p(0.5, 0.5)
	local var_50_21 = cc.p(110, 90 + 55)

	self.skillItemNode = ccui.Layout:create()

	self.skillItemNode:setAnchorPoint(var_50_20)
	self.skillItemNode:setContentSize(cc.size(170, 300))
	self.skillItemNode:setTouchEnabled(false)
	self.root:addChild(self.skillItemNode)

	local var_50_22 = ccui.ImageView:create("ExpeditionLayer/select_kuang.png", var_0_7)

	var_50_22:setVisible(false)
	var_50_22:setAnchorPoint(var_50_20)
	var_50_22:setPosition(var_50_21)
	var_50_22:setName("select")
	self.skillItemNode:addChild(var_50_22)

	local var_50_23 = ccui.Button:create("ExpeditionLayer/bg_select2.png", "ExpeditionLayer/bg_select2.png", "ExpeditionLayer/bg_select2.png", var_0_7)

	var_50_23:setAnchorPoint(var_50_20)
	var_50_23:setPosition(var_50_21)
	var_50_23:setName("bg")
	self.skillItemNode:addChild(var_50_23)

	local var_50_24 = ccui.ImageView:create("", var_0_7)

	var_50_24:setName("icon")
	var_50_23:addChild(var_50_24)

	local var_50_25 = ccui.Text:create(L_EXPEDITION_LAYER[10], FONT_NAME, 22)

	var_50_25:setName("name")
	var_50_23:addChild(var_50_25)

	local var_50_26 = ccui.Text:create(L_EXPEDITION_LAYER[11], FONT_NAME, 18)

	var_50_26:setContentSize(cc.size(150, 200))
	var_50_26:ignoreContentAdaptWithSize(false)
	var_50_26:setName("des")
	var_50_26:setPosition(cc.p(15, 80))
	var_50_26:setAnchorPoint(cc.p(0, 1))
	var_50_23:addChild(var_50_26)
	self.skillItemNode:setVisible(false)
end

function ExpeditionLayer:getMainItemNode(arg_51_1, arg_51_2)
	local var_51_0 = expedition_manager:getExpeditionInfo()

	if var_51_0 == nil or var_51_0.stepList == nil then
		return
	end

	local var_51_1 = var_51_0.stepList[arg_51_1 + 1].roomList
	local var_51_2 = ccui.Layout:create()

	var_51_2:setTouchEnabled(false)
	var_51_2:setName("item")

	for iter_51_0 = 1, #var_51_0.stepList[arg_51_1 + 1].roomList do
		local var_51_3 = self.mainItemNode:clone()

		var_51_3:setVisible(true)
		var_51_3:setName("item" .. 1)
		var_51_2:addChild(var_51_3)
		var_51_3:setPosition(var_0_8[#var_51_0.stepList[arg_51_1 + 1].roomList][iter_51_0])
		var_51_3:setPositionY(100)

		local var_51_5 = var_51_3:getChildByName("bg")
		local var_51_6 = var_51_5:getContentSize().width
		local var_51_7 = var_51_5:getContentSize().height
		local var_51_8 = var_51_3:getChildByName("icon")
		local var_51_9 = var_51_3:getChildByName("mask")
		local var_51_10 = var_51_3:getChildByName("name")

		if var_51_1[iter_51_0].roomType == ExpeditionRoomType.Start then
			var_51_5:loadTextures(var_0_16.START, var_0_16.START, var_0_16.START, var_0_7)
			var_51_8:setPositionY(8)
			var_51_9:setVisible(false)
			var_51_10:setPositionY(-53)
			var_51_3:getChildByName("line1"):setPositionY(62)
			var_51_3:getChildByName("line2"):setPositionY(62)
		elseif var_51_1[iter_51_0].roomType == ExpeditionRoomType.Boss or var_51_1[iter_51_0].roomType == ExpeditionRoomType.Transmit or var_51_1[iter_51_0].roomType == ExpeditionRoomType.TowerDefenceBoss then
			var_51_5:loadTextures(var_0_16.BOSS, var_0_16.BOSS, var_0_16.BOSS, var_0_7)
		else
			var_51_5:setPositionY(0)
			var_51_8:setPositionY(0)
			var_51_10:setPositionY(-var_51_7 / 2 + 20)
		end
	end

	return var_51_2
end

function ExpeditionLayer:initLevelViewPanel()
	local var_52_0 = expedition_manager:getExpeditionInfo()

	if var_52_0 == nil then
		return
	end

	self.levelNode:setString(var_52_0.levelTitle)

	local var_52_1 = var_52_0.stepList
	local var_52_2 = 640
	local var_52_3 = 300
	local var_52_4 = #var_52_0.stepList

	local function var_52_5(arg_53_0)
		if var_52_1[arg_53_0 + 1].roomList[1].roomType == ExpeditionRoomType.Start then
			return var_52_2, var_52_3 - 30
		elseif var_52_1[arg_53_0 + 1].roomList[1].roomType ~= ExpeditionRoomType.Transmit and arg_53_0 + 1 == var_52_4 then
			return var_52_2, var_52_3 + 80
		else
			return var_52_2, var_52_3
		end
	end

	self.lastSelectLevelIndex = nil
	self.lastSelectRoomIndex = nil

	if self.listViewNode ~= nil then
		self.listViewNode:removeFromParent()

		self.listViewNode = nil
	end

	self.listViewNode = self:getTableView(var_52_0.stepList, #var_52_0.stepList, var_52_5, cc.size(640, GameDisplay.height - 60 - 170 - 100), function(arg_54_0, arg_54_1, arg_54_2)
		local var_54_0 = arg_54_1 + 1
		local var_54_1 = arg_54_0:dequeueCell()

		if var_54_1 == nil then
			var_54_1 = cc.TableViewCell:new()
		end

		local var_54_2 = var_54_1:getChildByName("item")

		if var_54_2 then
			var_54_2:removeFromParent()
		end

		local var_54_4 = self:getMainItemNode(arg_54_1, var_52_4)
		local var_54_5, var_54_6 = var_52_5(arg_54_1)

		var_54_4:setContentSize(cc.size(var_54_5, var_54_6))
		var_54_1:addChild(var_54_4)
		var_54_4:setName("item")
		var_54_4:setVisible(true)
		var_54_4:setPositionY(0)

		local var_54_7 = #arg_54_2[arg_54_1 + 1].roomList

		for iter_54_0 = 1, #arg_54_2[arg_54_1 + 1].roomList do
			local var_54_8 = arg_54_2[arg_54_1 + 1].roomList[iter_54_0]
			local var_54_9 = var_54_4:getChildByName("item" .. iter_54_0)
			local var_54_10 = var_54_9:getChildByName("bg")
			local var_54_11 = var_54_9:getChildByName("line1")
			local var_54_12 = var_54_9:getChildByName("line2")
			local var_54_13, var_54_14 = expedition_manager:isShowLine(arg_54_2[arg_54_1 + 1].roomList[iter_54_0].roomIndex)

			var_54_11:setVisible(var_54_13)
			var_54_12:setVisible(var_54_14)

			local var_54_15 = expedition_manager:isShowLineLight(arg_54_1 + 1, iter_54_0, 1)
			local var_54_16 = expedition_manager:isShowLineLight(arg_54_1 + 1, iter_54_0, 2)

			var_54_11:loadTexture((var_54_15 == true or nil) and (var_0_17 or var_0_18), var_0_7)
			var_54_12:loadTexture((var_54_16 == true or nil) and (var_0_17 or var_0_18), var_0_7)

			if var_54_15 == true then
				var_54_9:setLocalZOrder(1)
				var_54_11:setLocalZOrder(1)
				var_54_12:setLocalZOrder(0)
			elseif var_54_16 == true then
				var_54_9:setLocalZOrder(1)
				var_54_11:setLocalZOrder(0)
				var_54_12:setLocalZOrder(1)
			else
				var_54_9:setLocalZOrder(0)
			end

			var_54_9.nInfo = var_54_8

			function var_54_9:updateRoomStatus()
				local var_55_0 = self.nInfo
				local var_55_1 = self:getChildByName("bg")
				local var_55_2 = self:getChildByName("name")
				local var_55_3 = self:getChildByName("select")
				local var_55_4 = self:getChildByName("mask")
				local var_55_5 = self:getChildByName("icon")
				local var_55_6 = self:getChildByName("namebg")
				local var_55_7 = not (self.nInfo.roomType == ExpeditionRoomType.Start or var_55_0.roomType == ExpeditionRoomType.Boss or var_55_0.roomType == ExpeditionRoomType.Transmit or var_55_0.roomType == ExpeditionRoomType.TowerDefenceBoss)
				local var_55_8 = true

				if var_55_0.roomType == ExpeditionRoomType.Boss or var_55_0.roomType == ExpeditionRoomType.Transmit or var_55_0.roomType == ExpeditionRoomType.TowerDefenceBoss then
					var_55_7 = false
				end

				local var_55_9 = not (var_55_0.roomType == ExpeditionRoomType.Start or var_55_0.roomType == ExpeditionRoomType.Boss or var_55_0.roomType == ExpeditionRoomType.Transmit or var_55_0.roomType == ExpeditionRoomType.TowerDefenceBoss)
				local var_55_10 = var_55_0.roomType ~= ExpeditionRoomType.Transmit

				if var_55_0.roomStatus == var_0_11.HaveGot then
					var_55_1:loadTextures(var_0_14[var_55_0.roomType], var_0_14[var_55_0.roomType], var_0_14[var_55_0.roomType], var_0_7)
					var_55_5:setVisible(false)
					var_55_6:setVisible(false)
					var_55_4:setVisible(false)
					var_55_2:setVisible(var_55_8 and var_55_0.roomType == ExpeditionRoomType.Start)
					var_55_2:setString(var_55_0.name)
					var_55_3:setVisible(false)
				elseif var_55_0.roomStatus == var_0_11.HaveMiss then
					var_55_1:loadTextures(var_0_13[var_55_0.roomType], var_0_13[var_55_0.roomType], var_0_13[var_55_0.roomType], var_0_7)
					var_55_5:setVisible(var_55_10 and true)
					var_55_5:loadTexture(var_0_15[var_55_0.roomType] or "", var_0_7)
					var_55_6:setVisible(true)
					var_55_2:setVisible(var_55_8)
					var_55_2:setString(var_55_0.name or "")
					var_55_4:setVisible(true)
					var_55_3:setVisible(false)
				elseif var_55_0.roomStatus == var_0_11.CanOperate then
					var_55_1:loadTextures(var_0_13[var_55_0.roomType], var_0_13[var_55_0.roomType], var_0_13[var_55_0.roomType], var_0_7)
					var_55_5:setVisible(var_55_10 and true)
					var_55_5:loadTexture(var_0_15[var_55_0.roomType] or "", var_0_7)
					var_55_6:setVisible(var_55_9)
					var_55_2:setVisible(var_55_8)
					var_55_2:setString(var_55_0.name or "")
					var_55_4:setVisible(false)
					var_55_3:setVisible(var_55_7 and true or false)
				elseif var_55_0.roomStatus == var_0_11.NotOperate then
					var_55_1:loadTextures(var_0_13[var_55_0.roomType], var_0_13[var_55_0.roomType], var_0_13[var_55_0.roomType], var_0_7)
					var_55_5:setVisible(var_55_10 and true)
					var_55_5:loadTexture(var_0_15[var_55_0.roomType] or "", var_0_7)
					var_55_6:setVisible(false)
					var_55_2:setVisible(false)
					var_55_4:setVisible(false)
					var_55_3:setVisible(false)
				end

				var_55_1.locked = nil

				if var_54_0 > 1 and var_54_0 < #arg_54_2 and expedition_manager:getCurLevelIndex() + 2 < var_54_0 then
					var_55_1:loadTextures(var_0_13[12], var_0_13[12], var_0_13[12], var_0_7)

					var_55_1.locked = true

					var_55_5:loadTexture(var_0_15[12] or "", var_0_7)
				end
			end

			var_54_9.updateRoomStatus(var_54_9, var_54_9)
			var_54_10:setSwallowTouches(false)
			var_54_10:addTouchEventListener(function(arg_56_0, arg_56_1)
				if arg_56_1 ~= ccui.TouchEventType.ended then
					return
				end

				if math.abs(arg_56_0:getTouchBeganPosition().y - arg_56_0:getTouchEndPosition().y) > 50 then
					return
				end

				if var_54_10.locked then
					global_ShowBlockWords(L_CHAPTER_UN_LOCK)

					return
				end

				self.lastSelectLevelIndex = var_54_0
				self.lastSelectRoomIndex = iter_54_0

				self:onBtnLevelCallback(var_54_0, iter_54_0)

				function expedition_manager.updateCurLevelViewPanel()
					local var_57_0 = expedition_manager:getExpeditionInfo().stepList[var_54_0]

					for iter_57_0 = 1, var_54_7 do
						local var_57_1 = arg_54_0:cellAtIndex(var_54_0 - 1):getChildByName("item"):getChildByName("item" .. iter_57_0)

						var_57_1.nInfo = var_57_0.roomList[iter_57_0]

						var_57_1.updateRoomStatus(var_57_1, var_57_1)
					end
				end
			end)

			if var_54_9:getChildByName("spine") then
				var_54_9:getChildByName("spine"):removeFromParent()
			end

			if var_54_8.roomType == ExpeditionRoomType.Transmit then
				var_54_10:setOpacity(0)

				local var_54_17 = L2Skeleton:create("spine/expedition/dooreasy.json", "spine/expedition/dooreasy.atlas")

				var_54_17:refreshSkeleton()
				var_54_17:play("animation", true)
				var_54_17:setVisible(true)
				var_54_17:registerListener(SP_ANIMATION_COMPLETE, function(arg_58_0)
					return
				end)
				var_54_17:setName("spine")
				var_54_17:setPositionY(-50)
				var_54_9:addChild(var_54_17)
			else
				var_54_10:setOpacity(255)
			end
		end

		return var_54_1
	end, function(arg_59_0, arg_59_1)
		return
	end)

	self.listViewNode:setPosition(cc.p(0, 160))
	self.mainNode:addChild(self.listViewNode)
	self:lateUpdate(function()
		self:scrollToIndex()
		self.listViewNode:setVisible(true)
		self.selectStudentNode:setVisible(false)
		self.selectSkillNode:setVisible(false)
		self:checkTriggerEventByLastLevel()
	end)
end

function ExpeditionLayer.onBtnLevelBattleCallback(arg_61_0, arg_61_1)
	local var_61_0 = expedition_manager:getExpeditionInfo()

	LayerManager:pushInLayer("ExpeditionDetailLayer", {
		mode = var_61_0.initmode,
		chapter = var_61_0.curChapter,
		level = expedition_manager:getRoomIndex(arg_61_1.levelindex, arg_61_1.roomindex),
		surecallback = function()
			if type(arg_61_1.callback) == "function" then
				arg_61_1.callback()
			end
		end,
		roomStatus = arg_61_1.roomStatus,
		roomType = arg_61_1.roomType
	})
end

function ExpeditionLayer.onBtnLevelCallback(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
	local var_63_0 = expedition_manager:getExpeditionInfo().stepList[arg_63_1].roomList[arg_63_2]

	arg_63_3 = arg_63_3 or false

	function doOperate()
		if expedition_manager:getCurLevelStatus() == var_0_10.Free then
			expedition_manager:setCurEventInfo("")

			if expedition_manager:isMeetConfitionTriggerEvent(var_63_0) then
				expedition_manager:setSelectInfo(arg_63_1, arg_63_2)
				expedition_manager:select_level_expedition({
					roomindex = arg_63_2,
					tips = L_EXPEDITION_WARNING[1]
				}, function()
					doOperate()
				end)
			end
		elseif expedition_manager:getCurLevelStatus() == var_0_10.NeedBattle then
			expedition_manager:selectBattleCallback({
				levelindex = arg_63_1,
				roomindex = arg_63_2,
				eventClassificationList = var_63_0.eventClassificationList,
				isCanOperate = var_63_0.isCanOperate,
				roomType = var_63_0.roomType
			})
		elseif expedition_manager:getCurLevelStatus() == var_0_10.NeedEvent then
			expedition_manager:selectEventCallback({
				levelindex = arg_63_1,
				roomindex = arg_63_2,
				eventClassificationList = var_63_0.eventClassificationList,
				isCanOperate = var_63_0.isCanOperate,
				callback = function(arg_66_0)
					arg_63_0:dealWithDialogEventList(arg_66_0, function()
						arg_63_0:showEventEffect(arg_66_0)
						doOperate()
					end)
				end
			})
		elseif expedition_manager:getCurLevelStatus() == var_0_10.NeedResult then
			expedition_manager:do_level_result_expedition(function()
				arg_63_0:initPanel()
			end)
		end
	end

	if arg_63_3 == true then
		doOperate()
	elseif var_63_0.roomType == ExpeditionRoomType.Normal or var_63_0.roomType == ExpeditionRoomType.Elite or var_63_0.roomType == ExpeditionRoomType.Boss or var_63_0.roomType == ExpeditionRoomType.TowerDefenceNormal or var_63_0.roomType == ExpeditionRoomType.TowerDefenceElite or var_63_0.roomType == ExpeditionRoomType.TowerDefenceBoss then
		(function()
			arg_63_0:onBtnLevelBattleCallback({
				levelindex = arg_63_1,
				roomindex = arg_63_2,
				isCanOperate = var_63_0.isCanOperate,
				roomStatus = var_63_0.roomStatus,
				roomType = var_63_0.roomType,
				callback = function()
					doOperate()
				end
			})
		end)()
	else
		(function()
			if var_63_0.detailPath == "" then
				print("event_icon 没填,eventid是" .. var_63_0.eventClassificationList[1].eventid)
			end

			arg_63_0:onBtnLevelEventCallback({
				name = var_63_0.name,
				itemPath = var_63_0.detailPath,
				des = var_63_0.des,
				levelindex = arg_63_1,
				callback = function()
					doOperate()
				end,
				isCanOperate = var_63_0.isCanOperate
			})
		end)()
	end
end

function ExpeditionLayer:showEventEffect(arg_73_1)
	if arg_73_1 == nil then
		return
	end

	local var_73_0, var_73_1 = expedition_manager:getSelectInfo()

	if var_73_0 == nil or var_73_1 == nil then
		return
	end

	local var_73_2 = self.listViewNode:cellAtIndex(var_73_0 - 1)
	local var_73_3 = var_73_2:getChildByName("item")
	local var_73_4 = var_73_3:getChildByName("item" .. var_73_1)
	local var_73_5 = var_73_3:convertToWorldSpace(cc.p(var_73_4.getPositionX(var_73_2), var_73_4:getPositionY()))

	for iter_73_0, iter_73_1 in pairs(arg_73_1) do
		if iter_73_1.eventtype == var_0_12.Blood then
			local var_73_6 = tonumber(iter_73_1.eventvalue)

			if var_73_6 < 0 then
				audio_manager:playeffectMusic("5200_ci", false, 5)

				local var_73_7 = self:getChildByName("spine")

				if var_73_7 ~= nil then
					var_73_7:removeFromParent()
				end

				local var_73_9 = L2Skeleton:create("spine/test/21020_effect.json", "spine/test/21020_effect.atlas")

				var_73_9:refreshSkeleton()
				var_73_9:play("attack", false)
				var_73_9:setName("spine")
				var_73_9:setVisible(true)
				var_73_9:setPosition(cc.p(var_73_5.x, var_73_5.y))
				var_73_9:registerListener(SP_ANIMATION_COMPLETE, function(arg_74_0)
					return
				end)
				self:usualSchedulerWithCallback(function()
					var_73_9:setVisible(false)
				end, 1)
				self:addChild(var_73_9, 99)
			elseif var_73_6 > 0 then
				audio_manager:playeffectMusic("zhiliao", false, 5)

				local var_73_10 = self:getChildByName("spine")

				if var_73_10 ~= nil then
					var_73_10:removeFromParent()
				end

				local var_73_12 = L2Skeleton:create("spine/test/21100_effect.json", "spine/test/21100_effect.atlas")

				var_73_12:refreshSkeleton()
				var_73_12:play("skill", false)
				var_73_12:setName("spine")
				var_73_12:setVisible(true)
				var_73_12:setPosition(cc.p(var_73_5.x, var_73_5.y))
				var_73_12:registerListener(SP_ANIMATION_COMPLETE, function(arg_76_0)
					return
				end)
				self:usualSchedulerWithCallback(function()
					var_73_12:setVisible(false)
				end, 1)
				self:addChild(var_73_12, 99)
			end
		elseif iter_73_1.eventtype == var_0_12.Reborn then
			audio_manager:playeffectMusic("zhiliao", false, 5)

			local var_73_13 = self:getChildByName("spine")

			if var_73_13 ~= nil then
				var_73_13:removeFromParent()
			end

			local var_73_15 = L2Skeleton:create("spine/test/21100_effect.json", "spine/test/21100_effect.atlas")

			var_73_15:refreshSkeleton()
			var_73_15:play("skill", false)
			var_73_15:setName("spine")
			var_73_15:setVisible(true)
			var_73_15:setPosition(cc.p(var_73_5.x, var_73_5.y))
			var_73_15:registerListener(SP_ANIMATION_COMPLETE, function(arg_78_0)
				return
			end)
			self:usualSchedulerWithCallback(function()
				var_73_15:setVisible(false)
			end, 1)
			self:addChild(var_73_15, 99)
		elseif iter_73_1.eventtype == var_0_12.Recruit then
			local var_73_16, var_73_17 = self.btn_team:getPosition()

			for iter_73_2, iter_73_3 in pairs((self.selectStudentNode:getChildByName("listView"):getItems())) do
				local var_73_18 = iter_73_3:getParent():convertToWorldSpace(cc.p(iter_73_3:getPositionX(), iter_73_3:getPositionY()))

				assert(servant_data[iter_73_3.servantid], string.format("servantid is not in ServantData ,please check it out:%d", iter_73_3.servantid))

				local var_73_19 = ROLE_PORTRAIT_PATH .. model_data[servant_data[iter_73_3.servantid].modelid].portrait_image .. ".png"
				local var_73_20

				if config._DEBUG then
					var_73_20 = cc.Sprite:create("ExpeditionLayer/avatar_bg.png") or cc.Sprite:createWithSpriteFrameName("ExpeditionLayer/avatar_bg.png")
				end

				local var_73_21 = cc.Sprite:create(var_73_19)
				local var_73_22 = cc.ClippingNode:create(var_73_20)

				var_73_22:setAlphaThreshold(0)
				var_73_22:setPosition(cc.p(53, 91))
				var_73_22:addChild(var_73_21)

				local var_73_23 = ccui.ImageView:create("ExpeditionLayer/avatar.png", var_0_7)

				var_73_23:setPosition(cc.p(var_73_18.x + 20, var_73_18.y - 50))
				var_73_23:addChild(var_73_22)
				var_73_23:runAction((cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(var_73_16, var_73_17 - 30)), cc.RemoveSelf:create())))
				self:addChild(var_73_23, 999)
			end
		elseif iter_73_1.eventtype == var_0_12.Skill then
			local var_73_24, var_73_25 = self.btn_skill_profit:getPosition()

			for iter_73_4, iter_73_5 in pairs((self.selectSkillNode:getChildByName("listView"):getItems())) do
				if iter_73_5.isSelected == true then
					local var_73_26 = iter_73_5:getParent():convertToWorldSpace(cc.p(iter_73_5:getPositionX(), iter_73_5:getPositionY()))
					local var_73_27 = iter_73_5:getChildByName("bg"):getChildByName("icon"):clone()

					var_73_27:setPosition(cc.p(var_73_26.x, var_73_26.y))
					var_73_27:runAction((cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(var_73_24, var_73_25)), cc.RemoveSelf:create())))
					self:addChild(var_73_27, 999)
				end
			end
		end
	end
end

function ExpeditionLayer:lateUpdate(arg_80_1)
	if self.cinemaScheduler ~= nil then
		self.scheduler:unscheduleScriptEntry(self.cinemaScheduler)

		self.cinemaScheduler = nil
	end

	self.cinemaScheduler = self.scheduler:scheduleScriptFunc(function()
		if self.cinemaScheduler ~= nil then
			self.scheduler:unscheduleScriptEntry(self.cinemaScheduler)

			self.cinemaScheduler = nil
		end

		if type(arg_80_1) == "function" then
			arg_80_1()
		end
	end, 0, false)
end

function ExpeditionLayer.getTableView(arg_82_0, arg_82_1, arg_82_2, arg_82_3, arg_82_4, arg_82_5, arg_82_6)
	local var_82_0 = cc.TableView:create(arg_82_4)

	var_82_0:setVisible(false)
	var_82_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_BOTTOMUP)
	var_82_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_82_0:setDelegate()
	var_82_0:registerScriptHandler(function(arg_83_0)
		return arg_82_2
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_82_0:registerScriptHandler(function(arg_84_0)
		arg_82_0:scrollViewDidScroll(arg_84_0)
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	var_82_0:registerScriptHandler(function(arg_85_0, arg_85_1)
		arg_82_6(arg_85_0, arg_85_1)
	end, cc.TABLECELL_TOUCHED)
	var_82_0:registerScriptHandler(function(arg_86_0, arg_86_1)
		local var_86_0 = 100
		local var_86_1 = 100

		if type(arg_82_3) == "function" then
			var_86_0, var_86_1 = arg_82_3(arg_86_1)
		end

		return var_86_0, var_86_1
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_82_0:registerScriptHandler(function(arg_87_0, arg_87_1)
		return arg_82_5(arg_87_0, arg_87_1, arg_82_1)
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_82_0:reloadData()
	var_82_0:setAnchorPoint(cc.p(0, 1))

	return var_82_0
end

function ExpeditionLayer.scrollViewDidScroll(arg_88_0, arg_88_1)
	return
end

function ExpeditionLayer.showHaveStudentPanel(arg_89_0)
	if expedition_manager:isHaveStudent() == false then
		global_ShowBlockWords(L_EXPEDITION_LAYER[1])

		return
	end

	LayerManager:pushInLayer("GirlSelectLayer", {
		arrayinfo = {
			index = 1,
			pos = 1
		},
		selectType = SELECT_GIRL_EXPEDITION_LIST
	})
end

function ExpeditionLayer:getSkillItemNode()
	local var_90_0 = ccui.Layout:create()

	var_90_0:setTouchEnabled(false)
	var_90_0:setName("item")
	var_90_0:setContentSize(cc.size(640, 300))

	for iter_90_0 = 1, 3 do
		local var_90_1 = self.skillItemNode:clone()

		var_90_1:setVisible(true)
		var_90_1:setName("item" .. iter_90_0)
		var_90_0:addChild(var_90_1)
		var_90_1:setPosition(var_0_9[iter_90_0])
	end

	return var_90_0
end

function ExpeditionLayer:showHaveSkillPanel()
	local var_91_0 = expedition_manager:getExpeditionSkillListInfo()

	if var_91_0 == nil or next(var_91_0) == nil then
		global_ShowBlockWords(L_EXPEDITION_LAYER[2])

		return
	end

	self.showSkillNode:setVisible(true)
	self.showSkillNode:getChildByName("listView"):setVisible(false)
	self.showSkillNode:getChildByName("listView"):setPositionY(40)

	local var_91_1 = {}

	for iter_91_0, iter_91_1 in pairs(var_91_0) do
		var_91_1[iter_91_1.skillid] = var_91_1[iter_91_1.skillid] and var_91_1[iter_91_1.skillid] + 1 or 1
	end

	local var_91_2 = {}

	for iter_91_2, iter_91_3 in pairs(var_91_1) do
		table.insert(var_91_2, {
			skillid = iter_91_2,
			num = iter_91_3 or 1
		})
	end

	local function var_91_3()
		local var_92_0 = self.showSkillNode:getChildByName("listView")

		var_92_0:setContentSize(cc.size(640, GameDisplay.height - 60 - 90))
		var_92_0:removeAllItems()
		var_92_0:setVisible(true)

		self.lastSelectSkillIndex = 1

		local var_92_1 = {}

		for iter_92_0, iter_92_1 in pairs(var_91_2) do
			if iter_92_1.skillid ~= nil then
				local var_92_2 = expedition_total_skill_data[iter_92_1.skillid]
				local var_92_3 = {
					id = #var_92_1 + 1,
					skillid = iter_92_1.skillid,
					rare = expedition_total_skill_data[iter_92_1.skillid].skill_rare
				}

				if iter_92_1.num > 1 then
					var_92_3.name = var_92_2.name .. "*" .. iter_92_1.num or var_92_2.name
				end

				var_92_3.des = var_92_2.description
				var_92_3.iconPath = "skill_new/skill/" .. (var_92_2.icon or 22822) .. ".png"

				table.insert(var_92_1, var_92_3)
			end
		end

		if #var_92_1 > 1 then
			table.sort(var_92_1, function(arg_93_0, arg_93_1)
				return arg_93_0.rare > arg_93_1.rare
			end)
		end

		for iter_92_2 = 1, #var_92_1 do
			local var_92_4 = self:getSkillItemNode()

			var_92_4:setVisible(true)
			var_92_4:setName("skillItem" .. iter_92_2)

			for iter_92_3 = 1, 3 do
				local var_92_5 = var_92_4:getChildByName("item" .. iter_92_3)

				if var_92_1[(iter_92_2 - 1) * 3 + iter_92_3] then
					var_92_5:setVisible(true)

					local var_92_6 = var_92_5:getChildByName("bg")
					local var_92_7 = var_92_5:getChildByName("select")

					var_92_6:setSwallowTouches(false)
					var_92_6:setTouchEnabled(false)
					var_92_7:setVisible(false)
					var_92_6:setScale(1)
					var_92_6:loadTextures("ExpeditionLayer/skill_bg" .. var_92_1[(iter_92_2 - 1) * 3 + iter_92_3].rare .. ".png", "ExpeditionLayer/skill_bg" .. var_92_1[(iter_92_2 - 1) * 3 + iter_92_3].rare .. ".png", "ExpeditionLayer/skill_bg" .. var_92_1[(iter_92_2 - 1) * 3 + iter_92_3].rare .. ".png", var_0_7)

					local var_92_8 = var_92_6:getContentSize().width
					local var_92_9 = var_92_6:getContentSize().height
					local var_92_10 = var_92_6:getChildByName("icon")
					local var_92_11 = var_92_6:getChildByName("name")

					var_92_11:setString(var_92_1[(iter_92_2 - 1) * 3 + iter_92_3].name)
					var_92_11:setAnchorPoint(cc.p(0.5, 0.5))
					var_92_11:setPosition(cc.p(var_92_8 / 2, 138))
					var_92_10:loadTexture(var_92_1[(iter_92_2 - 1) * 3 + iter_92_3].iconPath, var_0_7)
					var_92_10:setAnchorPoint(cc.p(0.5, 0.5))
					var_92_10:setScale(0.75)
					var_92_10:setPosition(cc.p(var_92_8 / 2, var_92_9 / 2 + 72))
					var_92_6:getChildByName("des"):setString(var_92_1[(iter_92_2 - 1) * 3 + iter_92_3].des)
				else
					var_92_5:setVisible(false)
				end
			end

			var_92_0:pushBackCustomItem(var_92_4)
		end

		var_92_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
		var_92_0:refreshView()
		var_92_0:jumpToTop()
		var_92_0:setTouchEnabled(true)
		var_92_0:addTouchEventListener(function(arg_94_0, arg_94_1)
			if arg_94_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_94_0:getTouchBeganPosition().y - arg_94_0:getTouchEndPosition().y) > 50 then
				return
			end

			self.showSkillNode:setVisible(false)
		end)
	end

	if self.showSkillNode:getChildByName("bgLayer") then
		self.showSkillNode:getChildByName("bgLayer"):removeFromParent()
	end

	if self.showSkillNode:getChildByName("sp") then
		self.showSkillNode:getChildByName("sp"):removeFromParent()
	end

	local var_91_4 = ccui.Layout:create()

	var_91_4:setTouchEnabled(true)
	var_91_4:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_91_4:setAnchorPoint(cc.p(0, 0))
	var_91_4:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_91_4:setBackGroundColor(cc.c3b(2, 5, 24))
	var_91_4:setOpacity(0)
	var_91_4:setCascadeOpacityEnabled(false)
	var_91_4:setName("bgLayer")
	self.showSkillNode:addChild(var_91_4, -1)

	local var_91_5 = ccui.ImageView:create("mainScenebg/expedition_mask.png")

	var_91_5:setAnchorPoint(cc.p(0.5, 0.5))
	var_91_5:setPositionX(var_91_4:getContentSize().width / 2)
	var_91_5:setPositionY(var_91_4:getContentSize().height / 2)
	l2utils:captureScreenGaussBlur(function(arg_95_0)
		arg_95_0:setName("sp")
		self.showSkillNode:addChild(arg_95_0, -2)
		var_91_4:addChild(var_91_5)
		var_91_3()
		var_91_4:setOpacity(102)
		var_91_4:setTouchEnabled(false)
	end)
end

function ExpeditionLayer:onBtnLevelEventCallback(arg_96_1)
	if arg_96_1 == nil then
		return
	end

	if self:getChildByName("levelDetailPanel") then
		self:getChildByName("levelDetailPanel"):removeFromParent()
	end

	local var_96_0 = ccui.Layout:create()

	var_96_0:setTouchEnabled(true)
	var_96_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_96_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_96_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_96_0:addTouchEventListener(function(arg_97_0, arg_97_1)
		var_96_0:getChildByName("bg"):runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 0.1), cc.CallFunc:create(function()
			if callback then
				callback()
			end
		end), cc.RemoveSelf:create(), cc.CallFunc:create(function()
			self:removeChild(var_96_0)
		end)))
	end)
	var_96_0:setName("levelDetailPanel")
	self:addChild(var_96_0)

	local function var_96_1()
		local var_100_0 = cc.Director:getInstance():getVisibleSize().width / 2
		local var_100_1 = cc.p(0.5, 0.5)
		local var_100_2 = ccui.ImageView:create("public/panelbg/bg_skill_details.png", var_0_7)

		var_100_2:setPosition((cc.p(var_100_0, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y)))
		var_100_2:setName("bg")
		var_100_2:setAnchorPoint(var_100_1)
		var_100_2:setScale9Enabled(true)
		var_100_2:setCapInsets(cc.rect(200, 200, 300, 300))
		var_100_2:setContentSize(cc.size(568, 500))
		var_96_0:addChild(var_100_2)

		local var_100_3 = var_100_2:getContentSize().width
		local var_100_4 = ccui.Text:create(arg_96_1.name, FONT_NAME, 24)

		var_100_4:setAnchorPoint(var_100_1)
		var_100_4:setPosition(cc.p(var_100_0 - 20, 450))
		var_100_2:addChild(var_100_4)

		local var_100_5 = ccui.Button:create(arg_96_1.itemPath, arg_96_1.itemPath, arg_96_1.itemPath)

		var_100_5:setPosition(cc.p(var_100_3 / 2, var_100_2:getContentSize().height / 2))
		var_100_2:addChild(var_100_5)

		local var_100_6 = ccui.Button:create("public/button/public_button_orange_big.png", "public/button/public_button_orange_big.png", "public/button/public_button_orange_big.png", var_0_7)
		local var_100_7 = ccui.Text:create(L_EXPEDITION_LAYER[13], FONT_NAME, 28)

		var_100_7:setColor(cc.c3b(0, 0, 0))
		var_100_7:setPosition(cc.p(160, 55))
		var_100_6:addChild(var_100_7)
		var_100_6:setPosition(cc.p(var_100_0 - 20, -50))
		var_100_6:setVisible(arg_96_1.isCanOperate == true)
		var_100_6:addTouchEventListener(function(arg_101_0, arg_101_1)
			if arg_101_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_96_1.isCanOperate == true and type(arg_96_1.callback) == "function" then
				arg_96_1.callback()
				var_96_0:setVisible(false)
			end
		end)
		var_100_2:addChild(var_100_6)

		local var_100_8 = ccui.Text:create(arg_96_1.des, FONT_DES, 24)

		var_100_8:setContentSize(cc.size(500, 100))
		var_100_8:ignoreContentAdaptWithSize(false)
		var_100_8:setPosition(cc.p(var_100_3 / 2 - 10, 30))
		var_100_2:addChild(var_100_8)
		var_100_2:setPositionY(var_100_2:getPositionY() + (GameDisplay.height + GameDisplay.fix_y - 1136) / 2)
		global_window_open_action(var_96_0)
	end

	if var_96_0:getChildByName("bgLayer") then
		var_96_0:getChildByName("bgLayer"):removeFromParent()
	end

	if var_96_0:getChildByName("sp") then
		var_96_0:getChildByName("sp"):removeFromParent()
	end

	local var_96_2 = ccui.Layout:create()

	var_96_2:setTouchEnabled(true)
	var_96_2:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_96_2:setAnchorPoint(cc.p(0, 0))
	var_96_2:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_96_2:setBackGroundColor(cc.c3b(2, 5, 24))
	var_96_2:setOpacity(0)
	var_96_2:setCascadeOpacityEnabled(false)
	var_96_2:setName("bgLayer")
	var_96_0:addChild(var_96_2, -1)

	local var_96_3 = ccui.ImageView:create("mainScenebg/expedition_mask.png")

	var_96_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_96_3:setPositionX(var_96_2:getContentSize().width / 2)
	var_96_3:setPositionY(var_96_2:getContentSize().height / 2)
	l2utils:captureScreenGaussBlur(function(arg_102_0)
		arg_102_0:setName("sp")
		var_96_0:addChild(arg_102_0, -2)
		var_96_2:addChild(var_96_3)
		var_96_1()
		var_96_2:setOpacity(102)
		var_96_2:setTouchEnabled(false)
	end)
end

function ExpeditionLayer:scrollToIndex()
	local var_103_0 = expedition_manager:getExpeditionInfo()

	self.listViewNode:scrollToPercent((var_103_0.curLevel >= 3 or nil) and math.min(100, math.floor(100 * (var_103_0.curLevel - 1) / var_103_0.stepLength)), nil, false)
end

function ExpeditionLayer.dealWithDialogEventList(arg_104_0, arg_104_1, arg_104_2)
	local var_104_0 = 1

	local function var_104_1()
		var_104_0 = var_104_0 + 1

		doTriggerEvent(arg_104_1[var_104_0])
	end

	local function var_104_2()
		expedition_manager:trigger_event_expedition(info, function()
			if arg_104_2 then
				arg_104_2()
			end
		end)
	end

	local function var_104_3(arg_108_0)
		arg_104_0:openSelectSkillPanel({
			isAni = true,
			callback = function()
				var_104_1()
			end,
			skillpoolid = tonumber(arg_108_0)
		})
	end

	local function var_104_4(arg_110_0)
		arg_104_0:openSelectStudentPanel({
			callback = function()
				var_104_1()
			end,
			updateCallback = function()
				var_104_4()
			end,
			isAni = arg_110_0 or false
		})
	end

	function doTriggerEvent(arg_113_0)
		if arg_113_0 == nil then
			var_104_2()

			return
		end

		if arg_113_0.eventtype == var_0_12.Recruit then
			var_104_4(true)
		elseif arg_113_0.eventtype == var_0_12.Skill then
			var_104_3(arg_113_0.eventvalue)
		else
			var_104_1()
		end
	end

	doTriggerEvent(arg_104_1[1])
end

function ExpeditionLayer:checkTriggerEventByLastLevel(arg_114_1)
	if self.initconfig and self.initconfig.isNeedCheckEvent == true then
		local var_114_0 = expedition_manager:getFightEventId()

		if var_114_0 == nil then
			return
		end

		self:onBtnLevelCallback(var_114_0.levelindex, var_114_0.roomindex, true)
	else
		expedition_manager:setFightEventId(nil)
	end
end

function ExpeditionLayer:usualSchedulerWithCallback(arg_115_1, arg_115_2)
	arg_115_2 = arg_115_2 or 1

	if self.usualScheduler ~= nil then
		self.scheduler:unscheduleScriptEntry(self.usualScheduler)
	end

	self.usualScheduler = self.scheduler:scheduleScriptFunc(function()
		if type(arg_115_1) == "function" then
			arg_115_1()
		end

		if self.usualScheduler ~= nil then
			self.scheduler:unscheduleScriptEntry(self.usualScheduler)
		end
	end, arg_115_2, false)
end

CommonFlopJsonLayer = class("CommonFlopJsonLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSpriteCommonFlop")

local activity_manager = require("controller.activity_manager")
local component_manager = require("controller.component_manager")
local drop_manager = require("controller.drop_manager")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local var_0_5 = config._DEBUG and 0 or 1
local var_0_6 = "CommonFlopJsonLayer/"
local armature_manager = require("controller.armature_manager")
local var_0_8 = 66
local var_0_9 = 620
local var_0_10 = 540
local var_0_11 = 100
local detail_data = require("data.detail_data")

local function var_0_13(arg_2_0)
	local var_2_0 = -1
	local var_2_1 = require("data.horcrux_data")[arg_2_0].horcruxt

	for iter_2_0, iter_2_1 in pairs((require("data.photofile_HelpGirl_data"))) do
		if arg_2_0 == iter_2_1.item_id then
			var_2_0 = iter_2_0

			break
		end
	end

	if var_2_0 == -1 then
		return
	end

	LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
		id = var_2_0,
		itemid = arg_2_0
	})
end

local function var_0_14(arg_3_0)
	local var_3_0 = {
		"1-" .. tonumber(arg_3_0) % 1500000
	}

	LayerManager:switchShowLayer("MarketLayer", {
		singleMarket = var_3_0,
		showType = var_3_0[1]
	})
end

function CommonFlopJsonLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = CommonFlopJsonLayer.new()

	var_4_0:init(arg_4_1)

	return var_4_0
end

function CommonFlopJsonLayer:init(arg_5_1)
	self.activityId = arg_5_1.activityId
	self.layerName = "CommonFlipLayer_" .. self.activityId
	var_0_6 = "Activities/activity" .. self.activityId .. "/flop/"

	TextureManager:loadLayerTextures({
		"Activities_activity" .. self.activityId .. "_flop"
	})

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initUI()
	self:initTouchEvent()
	self:registerEventListener()
	activity_manager:test11(self.activityId)
	activity_manager:getActivityCommonFlopConf(self.activityId, function(arg_6_0)
		if arg_6_0.nowChampionData then
			if not next(arg_6_0.nowChampionData) then
				activity_manager:setCommonFlopThreeRandomChampion(self.activityId, function()
					self:initChampionChosePanel()
					global_ShowBlockWords("可以任意选择三个大奖哦~")
				end)
			end
		end
	end)
	self:updateTaskAlert()
	self:fullScreen()
	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" then
			activity_manager:releaseEventListenerByName(self.layerName)

			local var_8_0, var_8_1, var_8_2 = activity_manager:getFlopTicket(self.activityId)

			activity_manager:updateActivityAlert("flop", self.activityId, var_8_0 <= var_8_1)
			TextureManager:removeLayerTextures({
				"Activities_activity" .. self.activityId .. "_flop"
			})
		end
	end)
end

function CommonFlopJsonLayer:initUI()
	local var_9_0 = {
		[855] = 17,
		[838] = 15,
		[865] = 17
	}

	self.bg = self.rootLayer:getChildByName("bg")
	self.title_panel = self.rootLayer:getChildByName("title_panel")

	self.title_panel:setTouchEnabled(true)
	self.title_panel:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = (detail_data["activity_flop_" .. self.activityId] or nil) and ("activity_flop_" .. self.activityId or "commonFlop")
		})
	end)

	self.task_btn = self.rootLayer:getChildByName("task_btn")
	self.more_btn = self.rootLayer:getChildByName("more_btn")
	self.exchange_btn = self.rootLayer:getChildByName("exchange_btn")
	self.champion_btn = self.rootLayer:getChildByName("champion_btn")
	self.championsPanel = self.rootLayer:getChildByName("championsPanel")
	self.drawPanel = self.rootLayer:getChildByName("draw_panel")
	self.next_btn = self.rootLayer:getChildByName("next_btn")
	self.return_btn = self.rootLayer:getChildByName("btn_return")
	self.currencyBg = self.rootLayer:getChildByName("currencyBg")
	self.addBtn = self.currencyBg:getChildByName("addBtn")
	self.ticketNumLabel = self.currencyBg:getChildByName("ticketNumLabel")
	self.turnsLabel = self.rootLayer:getChildByName("turnsLabel")

	self.task_btn:loadTextures(var_0_6 .. "task_btn.png", nil, var_0_6 .. "task_btn.png", var_0_5)
	self.more_btn:loadTextures(var_0_6 .. "more_btn.png", nil, var_0_6 .. "more_btn.png", var_0_5)
	self.exchange_btn:loadTextures(var_0_6 .. "exchange_btn.png", nil, var_0_6 .. "exchange_btn.png", var_0_5)
	self.champion_btn:loadTextures(var_0_6 .. "champion_btn.png", nil, var_0_6 .. "champion_btn.png", var_0_5)

	for iter_9_0 = 1, 3 do
		local var_9_1 = ccui.Button:create(var_0_6 .. "champion_bg.png", nil, var_0_6 .. "champion_bg.png", var_0_5)

		var_9_1:setPosition(self.championsPanel:getContentSize().width / 2 + (iter_9_0 - 2) * (var_9_1:getContentSize().width + 10), self.championsPanel:getContentSize().height / 2 + (var_9_0[self.activityId] or 0))
		self.championsPanel:addChild(var_9_1)
		var_9_1:addTouchEventListener(function(arg_11_0, arg_11_1)
			if arg_11_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:initChampionChosePanel()
		end)
		var_9_1:setName("champion_" .. iter_9_0)

		local var_9_3 = ccui.ImageView:create(var_0_6 .. "add.png", var_0_5)

		var_9_3:setPosition(var_9_1:getContentSize().width / 2, var_9_1:getContentSize().height / 2)
		var_9_1:addChild(var_9_3)
	end

	local var_9_4 = self.drawPanel:getChildByName("card_1")
	local var_9_5 = self.drawPanel:getChildByName("card_16")

	var_0_8, var_0_9 = var_9_4:getPositionX(), var_9_4:getPositionY()
	var_0_10, var_0_11 = var_9_5:getPositionX(), var_9_5:getPositionY()
	self.cardTbl = {}

	for iter_9_1 = 1, 6 do
		for iter_9_2 = 1, 6 do
			local var_9_6 = ItemSpriteCommonFlop:create(self.activityId, 6 * (iter_9_1 - 1) + iter_9_2)

			var_9_6:setPositionX(var_0_8 + (var_0_10 - var_0_8) / 5 * (iter_9_2 - 1))
			var_9_6:setPositionY(var_0_9 + (var_0_11 - var_0_9) / 5 * (iter_9_1 - 1))
			table.insert(self.cardTbl, var_9_6)
			self.drawPanel:addChild(var_9_6)
		end
	end

	var_9_4:removeFromParent()
	self.drawPanel:getChildByName("card_4"):removeFromParent()
	self.drawPanel:getChildByName("card_13"):removeFromParent()
	var_9_5:removeFromParent()
end

function CommonFlopJsonLayer:updateUI()
	self:updateTurns()
	self:updateBottom()
end

function CommonFlopJsonLayer:updateTurns()
	self.turnsLabel:setString(string.format(L_FLOP_TURNS_NOW, activity_manager:getCommonFlopTurns(self.activityId), (activity_manager:getCommonFlopLimitTurns(self.activityId))))
end

function CommonFlopJsonLayer:updateBottom()
	local var_14_0, var_14_1, var_14_2 = activity_manager:getFlopTicket(self.activityId)
	local var_14_3 = activity_manager:getCommonFlopPoint(self.activityId)

	self.ticketNumLabel:setString(var_14_1)

	local var_14_4 = activity_manager:canreset(self.activityId) and "next_btn_on.png" or "next_btn_off.png"

	self.next_btn:loadTextures(var_0_6 .. var_14_4, nil, var_0_6 .. var_14_4, var_0_5)
end

function CommonFlopJsonLayer:initTouchEvent()
	self.return_btn:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.champion_btn:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("CommonFlopDropDetailsLayer", {
			activityId = self.activityId
		})
	end)
	self.next_btn:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:goCommonNextTurn(self.activityId)
	end)
	self.more_btn:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:getFlopLimitBag(self.activityId, 1)
	end)
	self.task_btn:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopCommonTaskLayer", {
			usemodule = "commonFlop",
			activityId = self.activityId
		})
	end)
	self.exchange_btn:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.activityId == 730 then
			var_0_14("1573001")
		else
			var_0_14(activity_manager:getFlopShopJump(self.activityId))
		end
	end)
	self.addBtn:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:getFlopLimitBag(self.activityId, 1)
	end)
end

function CommonFlopJsonLayer:registerEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.EXIT_FORM_PURCHASE_LAYER, function(arg_24_0)
		self:updateUI()
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_COMMONFLOP_CONF_UPDATE, function(arg_25_0)
		self:updateUI()

		if arg_25_0.is_reset then
			self:showGoNextTurnAni()
		end
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_COMMONFLOP_SET_RESULT, function(arg_26_0)
		self:updateUI()
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_COMMONFLOP_CHAMPIONS_UPDATE, function(arg_27_0)
		self:updateChampionsPanel(arg_27_0)
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_28_0)
		self:updateUI()
	end), self)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_29_0)
		self:updateTaskAlert()
	end)
end

function CommonFlopJsonLayer:initChampionChosePanel()
	if not self.championLayer then
		local var_30_0 = ccui.Layout:create()

		var_30_0:setContentSize(cc.size(640, 1600))
		var_30_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_30_0:setCascadeOpacityEnabled(false)
		var_30_0:setBackGroundColorOpacity(182)
		var_30_0:setAnchorPoint(0.5, 0.5)
		var_30_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_30_0:setPosition(GameDisplay.cx, GameDisplay.cy)
		var_30_0:setTouchEnabled(true)
		var_30_0:setLocalZOrder(1000)
		var_30_0:setVisible(true)
		self.rootLayer:addChild(var_30_0)

		self.championLayer = var_30_0

		local var_30_1 = ccui.ImageView:create(var_0_6 .. "champion_choose_bg.png", var_0_5)

		var_30_1:setPosition(320, 900)
		var_30_0:addChild(var_30_1)

		local var_30_2 = {
			150,
			300,
			450
		}

		for iter_30_0, iter_30_1 in ipairs(var_30_2) do
			local var_30_3 = ccui.ImageView:create(var_0_6 .. "championIconBg.png", var_0_5)

			var_30_3:setTouchEnabled(true)
			var_30_3:setPosition(var_30_2[iter_30_0], 165)
			var_30_1:addChild(var_30_3)

			local var_30_4 = ccui.ImageView:create(var_0_6 .. "add.png", var_0_5)

			var_30_4:setPosition(var_30_3:getContentSize().width / 2, var_30_3:getContentSize().height / 2)
			var_30_4:setScale(1.5)
			var_30_3:addChild(var_30_4)
			var_30_3:setName("myChampion_" .. iter_30_0)
			var_30_3:addTouchEventListener(function(arg_31_0, arg_31_1)
				if arg_31_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:removeChampionItem(iter_30_0)
			end)
		end

		local var_30_5 = ccui.Button:create(var_0_6 .. "cancel_btn.png", nil, var_0_6 .. "cancel_btn.png", var_0_5)

		var_30_5:setPosition(180, 60)
		var_30_1:addChild(var_30_5)
		var_30_5:addTouchEventListener(function(arg_32_0, arg_32_1)
			if arg_32_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_30_0:setVisible(false)
		end)

		local var_30_6 = ccui.Button:create(var_0_6 .. "sure_btn.png", nil, var_0_6 .. "sure_btn.png", var_0_5)

		var_30_6:setPosition(420, 60)
		var_30_1:addChild(var_30_6)
		var_30_6:addTouchEventListener(function(arg_33_0, arg_33_1)
			if arg_33_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:setChampionItems(self.championItems)
		end)

		self.myChoseBg = var_30_1

		local var_30_7 = ccui.ImageView:create(var_0_6 .. "jiange.png", var_0_5)

		var_30_7:setPosition(320, 640)
		var_30_0:addChild(var_30_7)

		self.championItemsPanel = ccui.ImageView:create(var_0_6 .. "can_choose_bg.png", var_0_5)

		self.championItemsPanel:setPosition(320, 400)
		var_30_0:addChild(self.championItemsPanel)

		local var_30_8 = ccui.ListView:create()

		var_30_8:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
		var_30_8:setBounceEnabled(true)
		var_30_8:setContentSize(550, 330)
		var_30_8:setPosition(310, 190)
		var_30_8:setAnchorPoint(cc.p(0.5, 0.5))
		var_30_8:setItemsMargin(0.1)
		self.championItemsPanel:addChild(var_30_8)

		self.championsList = var_30_8
	end

	self.championLayer:setVisible(true)

	self.championItems = clone(activity_manager:getChampionItems(self.activityId))

	self:updateMyChoseBg(self.championItems)
	self:updateChampionChosePanel()
end

function CommonFlopJsonLayer:updateChampionsPanel(arg_34_1)
	local var_34_0 = {
		[865] = cc.c3b(0, 0, 0)
	}

	for iter_34_0 = 1, 3 do
		local var_34_1 = self.championsPanel:getChildByName("champion_" .. iter_34_0)

		if not arg_34_1[iter_34_0] or arg_34_1[iter_34_0].id == 0 then
			var_34_1:removeAllChildren()

			local var_34_2 = ccui.ImageView:create(var_0_6 .. "add.png", var_0_5)

			var_34_2:setPosition(var_34_1:getContentSize().width / 2, var_34_1:getContentSize().height / 2)
			var_34_1:addChild(var_34_2)
		else
			var_34_1:removeAllChildren()

			local var_34_3, var_34_4 = self:updateChampionIcon(nil, arg_34_1[iter_34_0].dropid)

			var_34_3:setPosition(var_34_1:getContentSize().width / 2, var_34_1:getContentSize().height / 2)
			var_34_3:setScale(var_34_3:getScale() * 0.6)
			var_34_1:addChild(var_34_3)

			local var_34_5 = cc.Label:createWithTTF("", FONT_NAME, 18)

			var_34_5:setString("x" .. var_34_4)
			var_34_5:setPosition(42, 15)
			var_34_5:setColor(var_34_0[self.activityId] or cc.c3b(255, 255, 255))
			var_34_1:addChild(var_34_5)
		end
	end
end

function CommonFlopJsonLayer:updateMyChoseBg(arg_35_1)
	for iter_35_0 = 1, 3 do
		local var_35_0 = self.myChoseBg:getChildByName("myChampion_" .. iter_35_0)

		if not arg_35_1[iter_35_0] or arg_35_1[iter_35_0].id == 0 then
			var_35_0:removeAllChildren()

			local var_35_1 = ccui.ImageView:create(var_0_6 .. "add.png", var_0_5)

			var_35_1:setPosition(52, 60)
			var_35_1:setScale(1.5)
			var_35_0:addChild(var_35_1)
		else
			var_35_0:removeAllChildren()

			local var_35_2, var_35_3 = self:updateChampionIcon(nil, activity_manager:getChampionConf(self.activityId)["champion_" .. arg_35_1[iter_35_0].id])

			var_35_2:setPosition(50, 62)
			var_35_2:setScale(var_35_2:getScale() * 0.8)
			var_35_0:addChild(var_35_2)

			local var_35_4 = ccui.ImageView:create(var_0_6 .. "label_bg.png", var_0_5)

			var_35_4:setAnchorPoint(0, 0)
			var_35_0:addChild(var_35_4)

			local var_35_5 = cc.Label:createWithTTF("", FONT_DES, 20)

			var_35_5:setString("x" .. var_35_3)
			var_35_5:setPosition(50, 12)
			var_35_4:addChild(var_35_5)

			if arg_35_1[iter_35_0].order ~= 0 then
				local var_35_6 = armature_manager:createAndPlayArmature("flop")

				var_35_6:setPositionX(var_35_0:getContentSize().width / 2)
				var_35_6:setPositionY(var_35_0:getContentSize().height / 2)
				var_35_0:addChild(var_35_6, 2)
			end
		end
	end
end

function CommonFlopJsonLayer:updateChampionChosePanel()
	local var_36_0 = ccui.Layout:create()
	local var_36_1 = activity_manager:getChampionConf(self.activityId)
	local var_36_2 = (math.ceil(var_36_1.champions_num / 4) + 1) * 130

	var_36_0:setContentSize(550, var_36_2)
	self.championsList:removeAllChildren()
	self.championsList:pushBackCustomItem(var_36_0)

	for iter_36_0 = 1, var_36_1.champions_num do
		local var_36_3 = ccui.ImageView:create(var_0_6 .. "championIconBg.png", var_0_5)

		var_36_3:setTouchEnabled(true)
		var_36_3:setPosition((iter_36_0 - 1) % 4 * 130 + 75, var_36_2 - math.ceil(iter_36_0 / 4) * 130 + 70)
		var_36_0:addChild(var_36_3)

		local var_36_4, var_36_5 = self:updateChampionIcon(nil, var_36_1["champion_" .. iter_36_0])

		var_36_4:setPosition(50, 62)
		var_36_4:setScale(var_36_4:getScale() * 0.8)
		var_36_3:addChild(var_36_4)

		local var_36_6 = ccui.ImageView:create(var_0_6 .. "label_bg.png", var_0_5)

		var_36_6:setAnchorPoint(0, 0)
		var_36_3:addChild(var_36_6)

		local var_36_7 = cc.Label:createWithTTF("", FONT_DES, 20)

		var_36_7:setString("x" .. var_36_5)
		var_36_7:setPosition(50, 12)
		var_36_6:addChild(var_36_7)
		var_36_3:addTouchEventListener(function(arg_37_0, arg_37_1)
			if arg_37_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self:checkIsChosed(iter_36_0) then
				global_ShowBlockWords(L_COMMONFLOP_TEXT[5])

				return
			end

			self:choseChampionItem(iter_36_0)
		end)
	end
end

function CommonFlopJsonLayer:updateChampionIcon(arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = drop_manager:getDropMsg(arg_38_2)
	local var_38_1
	local var_38_2

	if var_38_0.gold ~= 0 then
		var_38_1 = "gold"
		var_38_2 = var_38_0.gold
	elseif var_38_0.diamond ~= 0 then
		var_38_1 = "diamond"
		var_38_2 = var_38_0.diamond
	elseif var_38_0.equips then
		for iter_38_0, iter_38_1 in pairs(var_38_0.equips) do
			var_38_1 = iter_38_1.dropid
			var_38_2 = iter_38_1.dropNum
		end
	end

	arg_38_1 = arg_38_1 or ccui.ImageView:create(var_0_6 .. "championIconBg.png", var_0_5)

	if item_data[var_38_1].bag_item_type == kITEM_SKIN then
		arg_38_1:loadTexture("roleimage/role1/" .. model_data[item_data[var_38_1].model].cute_role .. ".png")
		arg_38_1:setScale(0.3)
	elseif item_data[var_38_1].bag_item_type == kITEM_HORCRUX then
		local var_38_4 = drop_manager:getAllDropsNotMerge(arg_38_2)[1].item_attr
		local var_38_5 = ccui.Layout:create()

		var_38_5:setName("starsPanel")
		var_38_5:setScale(1.75)
		var_38_5:setPositionY(58)
		var_38_5:setPositionX(200)
		arg_38_1:addChild(var_38_5, 5)

		local var_38_6 = 0

		if var_38_4 then
			for iter_38_2, iter_38_3 in var_38_4:gmatch("([^&]+)=([^&]+)") do
				if iter_38_2 == "star" then
					var_38_6 = tonumber(iter_38_3)
				end
			end
		end

		for iter_38_4 = 1, var_38_6 do
			local var_38_7

			if config._DEBUG then
				var_38_7 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
			end

			var_38_7:setPosition(25, (iter_38_4 - 1) * 24 - 30)
			var_38_5:addChild(var_38_7)
		end

		arg_38_1:loadTexture("equipment/" .. item_data[var_38_1].image_id .. ".png")
		arg_38_1:setScale(0.3)
	elseif item_data[var_38_1].bag_item_type == kITEM_COMPONENT then
		arg_38_1:removeFromParent()

		arg_38_1 = nil
		arg_38_1 = component_manager:create_component_icon(var_38_1)

		;(nil):setPosition(cc.p(self.championBg:getContentSize().width / 2, self.championBg:getContentSize().height / 2 + 20))
		arg_38_1:setScale(0.75)
	else
		arg_38_1:loadTexture("equipment/" .. item_data[var_38_1].image_id .. ".png")
		arg_38_1:setScale(0.75)
	end

	arg_38_1:setTouchEnabled(arg_38_3)
	arg_38_1:addTouchEventListener(function(arg_39_0, arg_39_1)
		if arg_39_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_data[var_38_1].bag_item_type == kITEM_HORCRUX then
			var_0_13(var_38_1)
		else
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_38_1
			})
		end
	end)

	return arg_38_1, var_38_2
end

function CommonFlopJsonLayer:checkIsChosed(arg_40_1)
	for iter_40_0, iter_40_1 in ipairs(self.championItems) do
		if iter_40_1.id == arg_40_1 then
			return true
		end
	end

	return false
end

function CommonFlopJsonLayer:choseChampionItem(arg_41_1)
	for iter_41_0 = 1, 3 do
		if not self.championItems[iter_41_0] then
			self.championItems[iter_41_0] = {}
			self.championItems[iter_41_0].id = arg_41_1
			self.championItems[iter_41_0].order = 0

			self:updateMyChoseBg(self.championItems)

			return
		elseif self.championItems[iter_41_0].id == 0 and self.championItems[iter_41_0].order == 0 then
			self.championItems[iter_41_0].id = arg_41_1

			self:updateMyChoseBg(self.championItems)

			return
		end
	end

	global_ShowBlockWords(L_COMMONFLOP_TEXT[1])
end

function CommonFlopJsonLayer:removeChampionItem(arg_42_1)
	if not self.championItems[arg_42_1] or self.championItems[arg_42_1].id == 0 then
		global_ShowBlockWords(L_COMMONFLOP_TEXT[2])

		return
	end

	if self.championItems[arg_42_1].order ~= 0 then
		global_ShowBlockWords(L_COMMONFLOP_TEXT[3])

		return
	end

	self.championItems[arg_42_1].id = 0

	self:updateMyChoseBg(self.championItems)
end

function CommonFlopJsonLayer:setChampionItems(arg_43_1)
	local var_43_0 = {}

	for iter_43_0 = 1, 3 do
		if not arg_43_1[iter_43_0] or arg_43_1[iter_43_0].id == 0 then
			global_ShowBlockWords(L_COMMONFLOP_TEXT[4])

			return
		else
			table.insert(var_43_0, arg_43_1[iter_43_0].id)
		end
	end

	activity_manager:setCommonFlopChampionItems(self.activityId, var_43_0, function()
		global_ShowBlockWords(L_COMMONFLOP_TEXT[6])
		self.championLayer:setVisible(false)
	end)
end

function CommonFlopJsonLayer:showGoNextTurnAni()
	local var_45_0 = activity_manager:getFlopMatrixConf(self.activityId)
	local var_45_1 = (self.cardTbl[1]:getPositionX() + self.cardTbl[var_45_0 * var_45_0]:getPositionX()) / 2
	local var_45_2 = (self.cardTbl[1]:getPositionY() + self.cardTbl[var_45_0 * var_45_0]:getPositionY()) / 2

	print(var_45_0, var_0_8, var_0_9, var_0_10, var_0_11, var_45_1, var_45_2)
	self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
		for iter_46_0, iter_46_1 in pairs(self.cardTbl) do
			iter_46_1:runAction(cc.EaseBackIn:create(cc.MoveTo:create(0.2, cc.p(var_45_1, var_45_2))))
		end
	end), cc.DelayTime:create(0.25), cc.CallFunc:create(function()
		for iter_47_0 = 1, var_45_0 do
			for iter_47_1 = 1, var_45_0 do
				self.cardTbl[var_45_0 * (iter_47_0 - 1) + iter_47_1]:runAction(cc.EaseBackIn:create(cc.MoveTo:create(0.02 * (var_45_0 * (iter_47_0 - 1) + iter_47_1), cc.p(var_0_8 + (var_0_10 - var_0_8) / (var_45_0 - 1) * (iter_47_1 - 1), var_0_9 + (var_0_11 - var_0_9) / (var_45_0 - 1) * (iter_47_0 - 1)))))
			end
		end
	end), cc.DelayTime:create(0.7), cc.CallFunc:create(function()
		if self.championLayer then
			if not self.championLayer:isVisible() then
				activity_manager:setCommonFlopThreeRandomChampion(self.activityId, function()
					self:initChampionChosePanel()
					global_ShowBlockWords("可以任意选择三个大奖哦~")
				end)
			end
		end
	end)))
end

function CommonFlopJsonLayer:updateTaskAlert()
	local var_50_0 = {
		x = 25,
		y = 90
	}

	activity_manager:getActivityObj(self.activityId):getActivityTaskList(nil, function(arg_51_0, arg_51_1)
		if arg_51_0 ~= 1 then
			return
		end

		for iter_51_0, iter_51_1 in pairs(arg_51_1.list) do
			if iter_51_1.status == 0 and iter_51_1.percent >= 100 then
				global_add_alert_tag(self.task_btn, var_50_0)
				activity_manager:updateActivityAlert("commonFlop", self.activityId, true)

				return
			end
		end

		global_remove_alert_tag(self.task_btn)
		activity_manager:updateActivityAlert("commonFlop", self.activityId, false)
	end, false, nil, "commonFlop")
end

function CommonFlopJsonLayer:fullScreen()
	self.bg:setPositionY(self.bg:getPositionY() + GameDisplay.fix_y)
	self.title_panel:setPositionY(self.title_panel:getPositionY() + GameDisplay.fix_y)
	self.task_btn:setPositionY(self.task_btn:getPositionY() + GameDisplay.fix_y)
	self.more_btn:setPositionY(self.more_btn:getPositionY() + GameDisplay.fix_y)
	self.exchange_btn:setPositionY(self.exchange_btn:getPositionY() + GameDisplay.fix_y)
	self.champion_btn:setPositionY(self.champion_btn:getPositionY() + GameDisplay.fix_y)
	self.championsPanel:setPositionY(self.championsPanel:getPositionY() + GameDisplay.fix_y * 0.7)
	self.turnsLabel:setPositionY(self.turnsLabel:getPositionY() + GameDisplay.fix_y * 0.7)
	self.drawPanel:setPositionY(self.drawPanel:getPositionY() + GameDisplay.fix_y * 0.7)
	self.next_btn:setPositionY(self.next_btn:getPositionY() + GameDisplay.fix_y * 0.2)
	self.currencyBg:setPositionY(self.currencyBg:getPositionY() - GameDisplay.fix_y)
	self.return_btn:setPositionY(self.return_btn:getPositionY() - GameDisplay.fix_y)
end

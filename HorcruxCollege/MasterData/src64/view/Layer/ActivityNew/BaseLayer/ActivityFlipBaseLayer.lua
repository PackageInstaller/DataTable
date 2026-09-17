ActivityFlipBaseLayer = class("ActivityFlipBaseLayer", function()
	return cc.Layer:create()
end)

require("view.Layer.CommonFlopLayer")
require("view.Sprite.ItemSpriteFlip")

local item_data = require("data.item_data")
local model_data = require("data.model_data")
local component_manager = require("controller.component_manager")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local var_0_5 = config._DEBUG and 0 or 1

local function var_0_6(arg_2_0)
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

function ActivityFlipBaseLayer.create(arg_3_0, arg_3_1)
	if activity_manager:isCommonFlop(arg_3_1.activityId) then
		return CommonFlopLayer:create(arg_3_1)
	end

	local var_3_0 = ActivityFlipBaseLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function ActivityFlipBaseLayer:init(arg_4_1)
	self.parentlayer = arg_4_1.parentlayer
	self.activityId = arg_4_1.activityId
	self.layerName = "ActivityFlipLayer_" .. self.activityId
	self.texturePath = string.format("Activities/activity%s/flop", self.activityId)

	TextureManager:loadLayerTextures({
		"Activities_activity" .. self.activityId .. "_flop"
	})

	self.bg = ccui.ImageView:create(self.texturePath .. "/flop_bg.png", var_0_5)

	self.bg:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - GameDisplay.fix_y)
	self:addChild(self.bg, -1)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initUI()
	self:fullScreen()
	self:registerActivityEventListener()
	activity_manager:getActivityFlopConf(self.activityId)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			activity_manager:releaseEventListenerByName(self.layerName)

			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end

			TextureManager:removeLayerTextures({
				"Activities_activity" .. self.activityId .. "_flop"
			})
			activity_manager:updateActivityAlert("flop", self.activityId, activity_manager:canFlop(self.activityId))
		end
	end)
end

function ActivityFlipBaseLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.EXIT_FORM_PURCHASE_LAYER, function(arg_7_0)
		self:updateDrawPaenl()
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_FLOP_CONF_UPDATE, function(arg_8_0)
		if arg_8_0.is_reset then
			self:showFirstGoNextTurnAni()
		else
			self:updateUI()
		end

		if RoleDefault:getInstance():getBoolForKey("flip" .. self.activityId, true) and self:isVisible() then
			if self.activityId == 550 then
				return
			end

			self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
				RoleDefault:getInstance():setBoolForKey("flip" .. self.activityId, false)
				LayerManager:pushInLayer("DropDetailsLayer", {
					category = {
						activityFlop = 1,
						type = 5,
						activityFlopLevel = activity_manager:getCurFlopLevel(self.activityId)
					},
					items_tbl = activity_manager:getDropConf(self.activityId),
					words_tbl = {
						type_tbl = {}
					}
				})
			end)))
		end
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_FLOP_SET_RESULT, function(arg_10_0)
		self:updateUI()
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_11_0)
		self:updateUI()
	end), self)
end

function ActivityFlipBaseLayer:initUI()
	self:initTitle()
	self:initDrawPaenl()
	self:initBottomList()
	self:initCurChampionPop()
end

function ActivityFlipBaseLayer:initTitle()
	self.titlePanel = self.rootLayer:getChildByName("title_panel")
	self.title = self.titlePanel:getChildByName("title")

	self.title:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "activity_flop_" .. self.activityId
		})
	end)
	self.title:setTouchEnabled(true)

	self.awardListBtn = self.titlePanel:getChildByName("btn_reward_list")

	self.awardListBtn:addTouchEventListener(function(arg_15_0, arg_15_1)
		local var_15_0

		if arg_15_1 ~= ccui.TouchEventType.ended then
			do return end

			var_15_0 = {
				category = {
					activityFlop = 1,
					type = 5,
					activityFlopLevel = activity_manager:getCurFlopLevel(self.activityId)
				}
			}
		end

		var_15_0.items_tbl = activity_manager:getDropConf(self.activityId)
		var_15_0.words_tbl = {
			type_tbl = {}
		}

		LayerManager:pushInLayer("DropDetailsLayer", var_15_0)
	end)

	self.shopBtn = self.titlePanel:getChildByName("btn_get_ticket")

	self.shopBtn:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:getFlopLimitBag(self.activityId, 1)
	end)

	self.lblLessTime = self.titlePanel:getChildByName("lbl_time")

	if self.lblLessTime then
		-- block empty
	end

	self.championBg = self.titlePanel:getChildByName("champion_bg")
	self.championIcon = self.championBg:getChildByName("champion_icon")
	self.championNum = self.championBg:getChildByName("lbl_num")
end

function ActivityFlipBaseLayer:initDrawPaenl()
	self.drawPanel = self.rootLayer:getChildByName("draw_panel")
	self.lessNumIcon = self.drawPanel:getChildByName("less_num_icon")
	self.lessNumLbl1 = self.drawPanel:getChildByName("lbl_less_num_1")
	self.lessNumLbl = self.drawPanel:getChildByName("lbl_less_num_2")
	self.curTurnLbl = self.drawPanel:getChildByName("lbl_cur_turn")
	self.flipPanel = self.drawPanel:getChildByName("flip_panel")
	self.card_1 = self.flipPanel:getChildByName("card_1")
	self.card_16 = self.flipPanel:getChildByName("card_16")

	self.card_1:setVisible(false)
	self.card_16:setVisible(false)
	self.flipPanel:getChildByName("card_4"):setVisible(false)
	self.flipPanel:getChildByName("card_13"):setVisible(false)

	local var_17_0, var_17_1 = self.card_1:getPosition()
	local var_17_2, var_17_3 = self.card_16:getPosition()

	self.lessNumLbl1:setString(L_OWN_TICKET)

	self.cardTbl = {}

	local var_17_4 = activity_manager:getFlopMatrixConf(self.activityId)

	for iter_17_0 = 1, var_17_4 do
		for iter_17_1 = 1, var_17_4 do
			local var_17_5 = ItemSpriteFlip:create(self.activityId, var_17_4 * (iter_17_0 - 1) + iter_17_1)

			var_17_5:setPositionX(var_17_0 + (var_17_2 - var_17_0) / (var_17_4 - 1) * (iter_17_1 - 1))
			var_17_5:setPositionY(var_17_1 + (var_17_3 - var_17_1) / (var_17_4 - 1) * (iter_17_0 - 1))
			table.insert(self.cardTbl, var_17_5)
			self.flipPanel:addChild(var_17_5)
		end
	end
end

function ActivityFlipBaseLayer:initBottomList()
	self.bottomList = self.rootLayer:getChildByName("return_panel")

	self.bottomList:getChildByName("btn_reset"):addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:goNextTurn(self.activityId)
	end)

	self.btnPrevious = self.bottomList:getChildByName("btn_previous")

	self.btnPrevious:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:goPreviousTurn(self.activityId)
	end)
	self.bottomList:getChildByName("btn_return"):addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end

function ActivityFlipBaseLayer:initCurChampionPop()
	self.championPanel = self.rootLayer:getChildByName("champion_panel")

	self.championPanel:setContentSize(cc.size(640, GameDisplay.height + GameDisplay.fix_y))
	self.championPanel:setPosition(-GameDisplay.fix_x, -GameDisplay.fix_y)

	local var_22_0 = self.championPanel:getChildByName("CurChampion")

	var_22_0:setPositionY((GameDisplay.height + GameDisplay.fix_y) * 0.5)
	var_22_0:getChildByName("btn_sure"):addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.championPanel:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.Hide:create()))
	end)
	self.championPanel:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.championPanel:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.Hide:create()))
	end)
end

function ActivityFlipBaseLayer:fullScreen()
	self.titlePanel:setPositionY(self.titlePanel:getPositionY() + GameDisplay.fix_y)
	self.championBg:setPositionY(self.championBg:getPositionY() - GameDisplay.fix_y)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end

function ActivityFlipBaseLayer:updateUI()
	self:updateTitle()
	self:updateDrawPaenl()
	self:updateBottomList()
	self:updateChampionPop()
end

function ActivityFlipBaseLayer:updateTitle()
	self.championItemOrder = activity_manager:getFlopChampionItem(self.activityId)
	self.championItem = activity_manager:getFlopItemByOrder(self.activityId, self.championItemOrder)

	local var_27_0 = self.championItem.itemid
	local var_27_1 = self.championItem.itemNum

	if self.starsPanel then
		self.starsPanel:removeFromParent()

		self.starsPanel = nil
	end

	if self.componentPanel then
		self.championIcon:setVisible(true)
		self.componentPanel:removeFromParent()

		self.componentPanel = nil
	end

	if item_data[self.championItem.itemid].bag_item_type == kITEM_SKIN then
		self.championIcon:loadTexture("roleimage/role1/" .. model_data[item_data[self.championItem.itemid].model].cute_role .. ".png")
		self.championIcon:setScale(0.3)
	elseif item_data[self.championItem.itemid].bag_item_type == kITEM_HORCRUX then
		self.starsPanel = ccui.Layout:create()

		self.starsPanel:setName("starsPanel")
		self.starsPanel:setScale(0.75)
		self.starsPanel:setPositionY(54)
		self.championIcon:addChild(self.starsPanel, 5)

		local var_27_2 = 0

		if self.championItem.item_attr then
			for iter_27_0, iter_27_1 in self.championItem.item_attr:gmatch("([^&]+)=([^&]+)") do
				if iter_27_0 == "star" then
					var_27_2 = tonumber(iter_27_1)
				end
			end
		end

		for iter_27_2 = 1, var_27_2 do
			local var_27_3

			if config._DEBUG then
				var_27_3 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
			end

			var_27_3:setPosition(25, (iter_27_2 - 1) * 24 - 30)
			self.starsPanel:addChild(var_27_3)
		end

		self.championIcon:loadTexture("equipment/" .. item_data[self.championItem.itemid].image_id .. ".png")
		self.championIcon:setScale(0.3)
	elseif item_data[self.championItem.itemid].bag_item_type == kITEM_COMPONENT then
		self.championIcon:setVisible(false)

		self.componentPanel = component_manager:create_component_icon(self.championItem.itemid)

		self.componentPanel:setPosition(cc.p(self.championBg:getContentSize().width / 2, self.championBg:getContentSize().height / 2 + 20))
		self.componentPanel:setScale(0.75)
		self.championBg:addChild(self.componentPanel)
	else
		self.championIcon:loadTexture("equipment/" .. item_data[self.championItem.itemid].image_id .. ".png")
		self.championIcon:setScale(0.75)
	end

	self.championNum:setString("x" .. var_27_1)
	self.championNum:setVisible(var_27_1 > 1)
	self.championIcon:setTouchEnabled(true)
	self.championIcon:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_data[self.championItem.itemid].bag_item_type == kITEM_HORCRUX then
			var_0_6(var_27_0)
		else
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_27_0
			})
		end
	end)
end

function ActivityFlipBaseLayer:updateDrawPaenl()
	local var_29_0, var_29_1, var_29_2 = activity_manager:getFlopTicket(self.activityId)

	self.lessNumLbl:setString(string.format("%d/%d", var_29_1, var_29_0))
	self.lessNumIcon:loadTexture("equipment/" .. item_data[var_29_2].image_id .. ".png")

	local var_29_3 = activity_manager:getFlopLimitTurns(self.activityId)

	self.curTurnLbl:setString(string.format(L_FLOP_TURNS_NOW, activity_manager:getFlopTurns(self.activityId), var_29_3))

	if var_29_3 > 99999 then
		self.curTurnLbl:setVisible(false)
	end
end

function ActivityFlipBaseLayer:updateBottomList()
	self.btnPrevious:setVisible((activity_manager:canGoPreciouTurn(self.activityId)))
end

function ActivityFlipBaseLayer:updateChampionPop()
	local var_31_0 = self.championPanel:getChildByName("CurChampion")
	local var_31_1 = self.championItem.itemid

	var_31_0:getChildByName("btn_sure"):setVisible(false)

	local var_31_2 = var_31_0:getChildByName("itemBg")

	var_31_2:loadTexture(string.format("public/box/new_item_bg%d.png", item_data[self.championItem.itemid].equip_quality), var_0_5)
	var_31_2:getChildByName("lbl_num"):setString("X" .. self.championItem.itemNum)

	local var_31_3 = var_31_2:getChildByName("icon")

	var_31_3:setScale(0.85)
	var_31_3:setVisible(true)

	if self.popStarsPanel then
		self.popStarsPanel:removeFromParent()

		self.popStarsPanel = nil
	end

	if self.popComponentPanel then
		var_31_3:setVisible(true)
		self.popComponentPanel:removeFromParent()

		self.popComponentPanel = nil
	end

	if item_data[self.championItem.itemid].bag_item_type == kITEM_COMPONENT then
		var_31_3:setVisible(false)

		self.popComponentPanel = component_manager:create_component_icon(self.championItem.itemid)

		self.popComponentPanel:setPosition(cc.p(var_31_3:getPositionX(), var_31_3:getPositionY()))
		self.popComponentPanel:setScale(0.85)
		var_31_2:addChild(self.popComponentPanel)
	elseif item_data[self.championItem.itemid].bag_item_type == kITEM_HORCRUX then
		self.popStarsPanel = ccui.Layout:create()

		self.popStarsPanel:setName("popStarsPanel")
		self.popStarsPanel:setScale(0.75)
		self.popStarsPanel:setPositionY(54)
		var_31_3:addChild(self.popStarsPanel, 5)
		var_31_3:setScale(0.5)

		local var_31_4 = 0

		if self.championItem.item_attr then
			for iter_31_0, iter_31_1 in self.championItem.item_attr:gmatch("([^&]+)=([^&]+)") do
				if iter_31_0 == "star" then
					var_31_4 = tonumber(iter_31_1)
				end
			end
		end

		for iter_31_2 = 1, var_31_4 do
			local var_31_5

			if config._DEBUG then
				var_31_5 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
			end

			var_31_5:setPosition(25, (iter_31_2 - 1) * 24 - 30)
			self.popStarsPanel:addChild(var_31_5)
		end

		var_31_3:loadTexture("equipment/" .. item_data[self.championItem.itemid].image_id .. ".png")
	else
		var_31_3:loadTexture("equipment/" .. item_data[self.championItem.itemid].image_id .. ".png")
	end

	var_31_2:addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_data[self.championItem.itemid].bag_item_type == kITEM_HORCRUX then
			var_0_6(var_31_1)
		else
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_31_1
			})
		end
	end)
end

function ActivityFlipBaseLayer:showFirstGoNextTurnAni()
	local var_33_0 = activity_manager:getFlopMatrixConf(self.activityId)
	local var_33_1, var_33_2 = self.card_1:getPosition()
	local var_33_3, var_33_4 = self.card_16:getPosition()
	local var_33_5 = (self.cardTbl[1]:getPositionX() + self.cardTbl[var_33_0 * var_33_0]:getPositionX()) / 2
	local var_33_6 = (self.cardTbl[1]:getPositionY() + self.cardTbl[var_33_0 * var_33_0]:getPositionY()) / 2

	print(var_33_0, var_33_1, var_33_2, var_33_3, var_33_4, var_33_5, var_33_6)
	self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
		for iter_34_0, iter_34_1 in pairs(self.cardTbl) do
			iter_34_1:runAction(cc.EaseBackIn:create(cc.MoveTo:create(0.2, cc.p(var_33_5, var_33_6))))
		end
	end), cc.DelayTime:create(0.25), cc.CallFunc:create(function()
		self.championIcon:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(0.4), cc.EaseBackIn:create(cc.MoveBy:create(0.4, cc.p(0, 50)))), cc.DelayTime:create(0.2), cc.CallFunc:create(function()
			self:updateUI()
		end), cc.DelayTime:create(0.2), cc.Spawn:create(cc.FadeIn:create(0.6), cc.EaseIn:create(cc.MoveBy:create(0.4, cc.p(0, -50)), 0.2))))

		for iter_35_0 = 1, var_33_0 do
			for iter_35_1 = 1, var_33_0 do
				self.cardTbl[var_33_0 * (iter_35_0 - 1) + iter_35_1]:runAction(cc.EaseBackIn:create(cc.MoveTo:create(0.02 * (var_33_0 * (iter_35_0 - 1) + iter_35_1), cc.p(var_33_1 + (var_33_3 - var_33_1) / (var_33_0 - 1) * (iter_35_1 - 1), var_33_2 + (var_33_4 - var_33_2) / (var_33_0 - 1) * (iter_35_0 - 1)))))
			end
		end
	end), cc.DelayTime:create(0.02 * var_33_0 * var_33_0 + 0.2), cc.CallFunc:create(function()
		self.championPanel:runAction(cc.Sequence:create(cc.Show:create(), cc.FadeIn:create(0.2)))
	end)))
end

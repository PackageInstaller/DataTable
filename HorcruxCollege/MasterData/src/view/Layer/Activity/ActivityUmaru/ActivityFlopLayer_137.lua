ActivityFlopLayer_137 = class("ActivityFlopLayer_137", function()
	return ActivityFlopBaseLayer:create()
end)

local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local var_0_5 = config._DEBUG and 0 or 1
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local favorfile_data = require("data.favorfile_data")
local activity_conf_data = require("data.activity_conf_data")
local var_0_10 = 0.9

function ActivityFlopLayer_137.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityFlopLayer_137.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityFlopLayer_137:initDynaticPara(arg_3_1)
	self.layerName = "ActivityFlopLayer_137"
	self.id = arg_3_1.activityid or 137
	self.bgPath = "mainScenebg/activity/branch" .. self.id .. "/flopBg.png"
	self.rolebg = "mainScenebg/activity/branch" .. self.id .. "/"
	self.texturePath = "ActivityUmaruFlop/"
	self.cardPanelOffsetX = 30
	self.cardPanelOffsetY = 100
	self.cardPanelWidth = 580
	self.cardGapYPlus = -7
	self.championDetailOffsetY = -10
end

function ActivityFlopLayer_137:initTitle()
	local var_4_0 = ccui.ImageView:create(self.texturePath .. "banner.png", var_0_5)

	var_4_0:setAnchorPoint(cc.p(0, 0.5))
	var_4_0:setPosition(cc.p(5, self.rootLayer:getContentSize().height * 0.93))
	self.rootLayer:addChild(var_4_0, 1)
	var_4_0:setTouchEnabled(true)
	var_4_0:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		AnalyticManager.clickIllustration()
		LayerManager:pushInLayer("PopActivityDetail", {
			key = "activity_flop_" .. self.id
		})
	end)

	self.Title = var_4_0
end

function ActivityFlopLayer_137:initDrawBg()
	local var_6_0 = ccui.Layout:create()

	var_6_0:setContentSize(cc.size(0, 0))
	var_6_0:setAnchorPoint(0.5, 0)
	var_6_0:setPosition(cc.p(130, 770))
	self.rootLayer:addChild(var_6_0, 1)

	local var_6_1 = ccui.ImageView:create(self.texturePath .. "draw_bg.png", var_0_5)

	var_6_1:setAnchorPoint(cc.p(0.5, 1))
	var_6_1:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, var_6_0:getPositionY()))
	self.rootLayer:addChild(var_6_1, 1)

	self.championBg = var_6_0
	self.drawBg = var_6_1

	self.drawBg:setTouchEnabled(true)
end

function ActivityFlopLayer_137:initAllBtn()
	local var_7_0 = ccui.Button:create(self.texturePath .. "btn_award_list.png", nil, self.texturePath .. "btn_award_list.png", var_0_5)

	var_7_0:setAnchorPoint(cc.p(1, 0))
	var_7_0:setPosition(cc.p(630, self.rootLayer:getContentSize().height * 0.9))
	self.rootLayer:addChild(var_7_0, 5)

	local var_7_1 = ccui.Button:create(self.texturePath .. "btn_get_more.png", nil, self.texturePath .. "btn_return.png", var_0_5)

	var_7_1:setAnchorPoint(cc.p(1, 0))
	var_7_1:setPosition(cc.p(var_7_0:getPositionX(), var_7_0:getPositionY() - var_7_1:getContentSize().height - 10))
	self.rootLayer:addChild(var_7_1, 5)

	self.shopbtn = var_7_1

	var_7_0:addTouchEventListener(function(arg_8_0, arg_8_1)
		local var_8_0

		if arg_8_1 ~= ccui.TouchEventType.ended then
			do return end

			var_8_0 = {
				callback = callback,
				category = {
					activityFlop = 1,
					type = 5
				}
			}
		end

		var_8_0.items_tbl = activity_manager:getDropConf(self.id)
		var_8_0.words_tbl = {
			type_tbl = {}
		}

		LayerManager:pushInLayer("DropDetailsLayer", var_8_0)
	end)
	var_7_1:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:getFlopLimitBag(self.id, function(arg_10_0)
			LayerManager:pushInLayer(self:getBuyLimitLayerName(), arg_10_0)
		end)
	end)
	self:initBottomList()
end

function ActivityFlopLayer_137:initBottomList()
	local var_11_0 = ccui.Layout:create()

	var_11_0:setContentSize(cc.size(0, 0))
	var_11_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_11_0:setAnchorPoint(0, 0)
	var_11_0:setTouchEnabled(false)
	var_11_0:setPosition(cc.p(0, 0))
	self.rootLayer:addChild(var_11_0, 1)

	self.bottomList = var_11_0

	local var_11_1 = ccui.Button:create(self.texturePath .. "btn_return.png", nil, self.texturePath .. "btn_return.png", var_0_5)

	var_11_1:setAnchorPoint(cc.p(0, 0))
	var_11_1:setPosition(cc.p(5, 5))
	var_11_1:setName("returnBtn")
	self.bottomList:addChild(var_11_1, 5)

	local var_11_2 = ccui.Button:create(self.texturePath .. "btn_reset.png", nil, self.texturePath .. "btn_reset.png", var_0_5)

	var_11_2:setAnchorPoint(cc.p(1, 0))
	var_11_2:setPosition(cc.p(self.drawBg:getContentSize().width - 20, 125))
	var_11_2:setName("reset")
	self.drawBg:addChild(var_11_2, 5)

	self.resetBtn = var_11_2

	var_11_1:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	var_11_2:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:resetFlop()
	end)
end

function ActivityFlopLayer_137:initTicket()
	local var_14_0, var_14_1, var_14_2 = activity_manager:getFlopTicket(self.id)
	local var_14_3 = ccui.ImageView:create(self.texturePath .. "material_bg.png")

	var_14_3:setAnchorPoint(cc.p(1, 0))
	var_14_3:setPosition(cc.p(430, 125))
	self.drawBg:addChild(var_14_3)

	local var_14_4 = cc.Label:createWithTTF(L_OWN_TICKET, FONT_NAME, 26)

	var_14_4:setAnchorPoint(cc.p(1, 0.5))
	var_14_4:setName("ticketTitle")
	var_14_4:setColor(cc.c3b(124, 92, 69))
	var_14_4:setPosition(cc.p(self.drawBg:getContentSize().width / 2 - 35 + 10, 125))
	self.drawBg:addChild(var_14_4)
	var_14_4:setVisible(false)

	local var_14_5 = cc.Label:createWithTTF(string.format("%d/%d", var_14_1, var_14_0), FONT_NAME, 30)

	var_14_5:setAnchorPoint(cc.p(0.5, 0.5))
	var_14_5:setName("ticketNum")
	var_14_5:setColor(var_14_0 <= var_14_1 and cc.c3b(255, 255, 255) or cc.c3b(255, 66, 66))
	var_14_5:setPosition(cc.p(var_14_3:getContentSize().width / 2, var_14_3:getContentSize().height / 2))
	var_14_3:addChild(var_14_5)

	local var_14_6 = ccui.ImageView:create("equipment/" .. item_data[var_14_2].image_id .. ".png")

	var_14_6:setAnchorPoint(cc.p(0.5, 0.5))
	var_14_6:setScale(0.4)
	var_14_6:setPosition(cc.p(0, var_14_3:getContentSize().height / 2))
	var_14_3:addChild(var_14_6)

	local var_14_7 = ccui.ImageView:create(self.texturePath .. "plus.png", var_0_5)

	var_14_7:setAnchorPoint(cc.p(1, 0.5))
	var_14_7:setPosition(cc.p(var_14_3:getContentSize().width - 5, var_14_3:getContentSize().height / 2))
	var_14_3:addChild(var_14_7)

	local var_14_8 = ccui.Layout:create()

	var_14_8:setContentSize(var_14_3:getContentSize())
	var_14_8:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_14_8:setAnchorPoint(0.5, 0.5)
	var_14_8:setTouchEnabled(true)
	var_14_8:setPosition(cc.p(var_14_3:getContentSize().width / 2, var_14_3:getContentSize().height / 2))
	var_14_3:addChild(var_14_8, 5)
	var_14_6:setTouchEnabled(true)
	var_14_6:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:getFlopLimitBag(self.id, function(arg_16_0)
			LayerManager:pushInLayer(self:getBuyLimitLayerName(), arg_16_0)
		end)
	end)
	var_14_8:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:getFlopLimitBag(self.id, function(arg_18_0)
			LayerManager:pushInLayer(self:getBuyLimitLayerName(), arg_18_0)
		end)
	end)

	self.ticketNum = var_14_5
end

function ActivityFlopLayer_137:initFlopTurns()
	local var_19_0 = cc.Label:createWithTTF(L_FLOP_TURNS_NOW, FONT_DES, 24)

	var_19_0:setAnchorPoint(cc.p(0.5, 1))
	var_19_0:setColor(cc.c3b(155, 133, 107))
	var_19_0:setName("flopBgWord")
	var_19_0:setPosition(cc.p(self.drawBg:getContentSize().width / 2 + 10, self.drawBg:getContentSize().height - 20))
	self.drawBg:addChild(var_19_0)
	var_19_0:setVisible(false)

	local var_19_1 = ccui.Layout:create()

	var_19_1:setContentSize(cc.size(60, var_19_0:getContentSize().height))
	var_19_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_19_1:setAnchorPoint(0.5, 1)
	var_19_1:setPosition(cc.p(var_19_0:getPositionX() + 15, var_19_0:getPositionY()))
	var_19_1:setName("numLayer")
	self.drawBg:addChild(var_19_1)

	local var_19_2 = cc.Label:createWithTTF("/" .. activity_conf_data[self.id].flop_limit_turns, FONT_DES, 24)

	var_19_2:setAnchorPoint(cc.p(1, 0.5))
	var_19_2:setName("flopTotalTurns")
	var_19_2:setPosition(cc.p(var_19_1:getContentSize().width / 2, var_19_1:getContentSize().height / 2))
	var_19_1:addChild(var_19_2)

	local var_19_3 = cc.Label:createWithTTF("", FONT_DES, 24)

	var_19_3:setAnchorPoint(cc.p(0, 0.5))
	var_19_3:setName("flopTurns")
	var_19_3:setColor(cc.c3b(255, 252, 163))
	var_19_3:setPosition(cc.p(var_19_1:getContentSize().width / 2, var_19_1:getContentSize().height / 2))
	var_19_1:addChild(var_19_3)

	self.flopTurns = var_19_3

	var_19_1:setContentSize(cc.size(var_19_2:getContentSize().width + var_19_3:getContentSize().width, var_19_0:getContentSize().height))
	var_19_1:setPositionX(var_19_0:getPositionX() + 20)
	var_19_2:setPositionX(var_19_1:getContentSize().width)
	var_19_3:setPositionX(0)
end

function ActivityFlopLayer_137:initOther()
	local var_20_0 = ccui.ImageView:create(self.rolebg .. "role_bg_0.png")

	var_20_0:setAnchorPoint(cc.p(0.5, 1))
	var_20_0:setPosition(cc.p(320, self.rootLayer:getContentSize().height * 0.4))
	self.rootLayer:addChild(var_20_0)

	self.bigRole = var_20_0

	self.bigRole:setTouchEnabled(true)
	self.bigRole:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.skinItemid then
			return
		end

		self:showSoulGirlPop({
			itemid = self.skinItemid
		})
	end)
end

function ActivityFlopLayer_137:updateTicket()
	local var_22_0, var_22_1 = activity_manager:getFlopTicket(self.id)

	self.ticketNum:setString(string.format("%d/%d", var_22_1, var_22_0))
	self.ticketNum:setColor(var_22_0 <= var_22_1 and cc.c3b(255, 255, 255) or cc.c3b(255, 66, 66))
end

function ActivityFlopLayer_137.updateOther(arg_23_0)
	return
end

function ActivityFlopLayer_137:updateChampionItem(arg_24_1)
	local var_24_0
	local var_24_1 = 50

	if not self.itemShade then
		if item_data[self.championItem.itemid].bag_item_type == kITEM_SKIN then
			var_24_0 = ccui.ImageView:create("roleimage/role1/" .. model_data[item_data[self.championItem.itemid].model].cute_role .. ".png")

			var_24_0:setScale(0.4)
			var_24_0:setName("championItem")
			var_24_0:setAnchorPoint(cc.p(0.5, 0))
			var_24_0:setPosition(cc.p(self.championBg:getContentSize().width / 2, 35 + var_24_1))
			self.championBg:addChild(var_24_0)
		else
			var_24_0 = ccui.ImageView:create("equipment/" .. self.championItem.itemImg .. ".png")

			var_24_0:setName("championItem")
			var_24_0:setAnchorPoint(cc.p(0.5, 0))
			var_24_0:setScale(var_0_10 / global_get_item_scale_by_size(128, item_data[self.championItem.itemid].bag_item_type))
			var_24_0:setPosition(cc.p(self.championBg:getContentSize().width / 2, 35 + var_24_1))
			self.championBg:addChild(var_24_0)
		end

		var_24_0:setTouchEnabled(true)
		var_24_0:addTouchEventListener(function(arg_25_0, arg_25_1)
			if arg_25_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_25_0 = {
				itemid = self.championItem.itemid
			}

			var_25_0.hideGainButton = true

			if var_25_0.itemid and type(var_25_0.itemid) == "number" then
				LayerManager:pushInLayer("PopItemLayer", var_25_0)
			end
		end)

		local var_24_2 = ccui.ImageView:create(self.texturePath .. "champion_shade.png", var_0_5)

		var_24_2:setAnchorPoint(cc.p(0.5, 0))
		var_24_2:setPosition(cc.p(var_24_0:getPositionX(), var_24_0:getPositionY() - 30 - var_24_1))
		self.championBg:addChild(var_24_2)

		self.itemShade = var_24_2

		local var_24_3 = cc.Label:createWithTTF("x" .. self.championItem.itemNum, FONT_NAME, 18)

		var_24_3:setAnchorPoint(cc.p(0, 0))
		var_24_3:setName("championNumLabel")
		var_24_3:setColor(cc.c3b(109, 52, 213))
		var_24_3:setPositionX(var_24_2:getPositionX() + 50)
		var_24_3:setPositionY(var_24_2:getPositionY())
		self.championBg:addChild(var_24_3, 99)
	else
		if item_data[self.championItem.itemid].bag_item_type == kITEM_SKIN then
			self.championBg:getChildByName("championItem"):loadTexture("roleimage/role1/" .. model_data[item_data[self.championItem.itemid].model].cute_role .. ".png")
			self.championBg:getChildByName("championItem"):setScale(0.4)
		else
			self.championBg:getChildByName("championItem"):loadTexture("equipment/" .. self.championItem.itemImg .. ".png")
			self.championBg:getChildByName("championItem"):setScale(var_0_10 / global_get_item_scale_by_size(128, item_data[self.championItem.itemid].bag_item_type))
		end

		self.championBg:getChildByName("championNumLabel"):setString("x" .. self.championItem.itemNum)
		self.championBg:getChildByName("championItem"):setTouchEnabled(true)
	end

	local var_24_4 = cc.MoveBy:create(0.6, cc.p(0, -var_24_1))

	self.championBg:getChildByName("championItem"):setOpacity(0)
	self.championBg:getChildByName("championItem"):runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.6), cc.EaseIn:create(var_24_4, 0.2))))
	self.championBg:getChildByName("championNumLabel"):setOpacity(0)
	self.championBg:getChildByName("championNumLabel"):runAction(cc.Sequence:create(cc.FadeIn:create(0.6)))
end

function ActivityFlopLayer_137:showChampionAni()
	local var_26_0 = self.championBg:getChildByName("championItem")
	local var_26_1 = self.championBg:getChildByName("championNumLabel")
	local var_26_2 = cc.MoveBy:create(0.6, cc.p(0, -50))
	local var_26_3 = true

	var_26_0:setTouchEnabled(false)
	var_26_0:stopAllActions()
	var_26_0:setOpacity(255)
	var_26_0:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(0.6), cc.EaseBackIn:create((cc.MoveBy:create(0.6, cc.p(0, 50))))), cc.DelayTime:create(0.6), cc.CallFunc:create(function()
		self:updateChampionItem(var_26_3)
	end)))
	var_26_1:setOpacity(255)
	var_26_1:runAction(cc.Sequence:create(cc.FadeOut:create(0.6)))
end

function ActivityFlopLayer_137.getBuyLimitLayerName(arg_28_0)
	return "PopFlopBuyLayer_138"
end

function ActivityFlopLayer_137:fullScreen()
	self.championBg:setPositionY(self.championBg:getPositionY() + GameDisplay.fix_y * 0.8)
	self.drawBg:setPositionY(self.championBg:getPositionY() + 12)
	self.bigRole:setPositionY(GameDisplay.height)
	self.Title:setPositionY(self.rootLayer:getContentSize().height - self.Title:getContentSize().height / 2 - 10)

	self.bottomList.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.bottomList:getPositionY(), TRANSFORM_UNIT.PX)

	self.bottomList:setPositionY(0)
	self.changeSkinBtn:setPositionY(self.shopbtn:getPositionY() - (self.shopbtn:getPositionY() - self.drawBg:getPositionY() - 50) / 2)
end

function ActivityFlopLayer_137:initSurplusTime()
	local var_30_0 = cc.Label:createWithTTF("", FONT_NAME, 24)

	var_30_0:setAnchorPoint(cc.p(0, 1))
	var_30_0:setName("time")
	var_30_0:setPosition(cc.p(25, 0))
	self.Title:addChild(var_30_0, 5)
	self:createSurplusTime(var_30_0, activity_conf_data[self.id].finishtime)
end

local function var_0_11(arg_31_0)
	local var_31_5 = math.floor(arg_31_0 / 24 / 3600)

	arg_31_0 = arg_31_0 - var_31_5 * 24 * 3600

	local var_31_6 = math.floor(arg_31_0 / 3600)

	arg_31_0 = arg_31_0 - var_31_6 * 3600

	local var_31_7 = math.floor(arg_31_0 / 60)

	return 0 ~= 0 and string.format(L_TIME_REST2 .. L_TIME_TEXT[1], var_31_5, var_31_6) or var_31_6 ~= 0 and string.format(L_TIME_REST2 .. L_TIME_TEXT[2], var_31_6, var_31_7) or string.format(L_TIME_REST2 .. L_TIME_TEXT[3], var_31_7)
end

function ActivityFlopLayer_137.createSurplusTime(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = global_get_time_by_date(arg_32_2) - time_check_manager:getCurTime()

	if not var_32_0 then
		return
	end

	arg_32_0.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_32_0, function(arg_33_0)
		if arg_32_1 then
			arg_32_1:setString((var_0_11(arg_33_0)))

			if arg_33_0 <= 0 and arg_32_1 then
				time_check_manager:removeUpdatePool(arg_32_0.activityScheduler)
				arg_32_1:setVisible(false)
			end
		end
	end)))
end

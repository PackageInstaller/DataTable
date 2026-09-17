ExploreOfferLayer = class("ExploreOfferLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local var_0_1 = "ExploreOfferLayer/"

require("view.Sprite.ItemSprite")

local fight_capacity_manager = require("controller.fight_capacity_manager")
local array_manager = require("controller.array_manager")
local explore_manager = require("controller.explore_manager")
local item_manager = require("controller.item_manager")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local total_skill_data = require("data.total_skill_data")
local var_0_10
local var_0_11
local LocalEvent = require("common.LocalEvent")

local function var_0_13(arg_2_0)
	if arg_2_0 >= 3600 then
		return string.format("%02d:%02d:%02d", math.floor(arg_2_0 / 3600), math.floor(arg_2_0 % 3600 / 60), arg_2_0 % 60)
	else
		return string.format("%02d:%02d", math.floor(arg_2_0 / 60), arg_2_0 % 60)
	end
end

function ExploreOfferLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = ExploreOfferLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function ExploreOfferLayer:init(arg_4_1)
	var_0_10 = self
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootLayer)

	self.bg = ccui.ImageView:create("mainScenebg/offer_bg_daily.png")

	self.bg:setPosition(GameDisplay.width / 2, GameDisplay.height / 2)
	self.rootLayer:addChild(self.bg)

	self.offer_class = arg_4_1 and arg_4_1.init_class and arg_4_1.init_class or var_0_11 or "daily"

	explore_manager:initOfferConfig(function()
		self:initData()
		self:initUI()
	end)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_10 = nil
			var_0_11 = self.offer_class

			LocalEvent:removeEvent(self)
		end
	end)
	LocalEvent:registerEvent(self, LocalEvent.EVENT_IDS.UPDATE_OFFERS, function()
		self:updateData()
		self:updateUI()
		self:updateList()
	end)
end

function ExploreOfferLayer.getInstance()
	return var_0_10
end

function ExploreOfferLayer:switchOfferClass(arg_9_1)
	if arg_9_1 == self.offer_class then
		return
	end

	self.offer_class = arg_9_1

	self:updateData()
	self:updateUI()
	self:updateList()
end

function ExploreOfferLayer:initData()
	self.offerData = explore_manager:getOfferList(self.offer_class)
	self.readyTime = explore_manager:get_ready_time_count_down()
end

function ExploreOfferLayer:updateData()
	self.offerData = explore_manager:getOfferList(self.offer_class)
	self.readyTime = explore_manager:get_ready_time_count_down()
end

function ExploreOfferLayer:initUI()
	self:initBaseUI()
	self:initTimer()
	self:initList()
end

function ExploreOfferLayer:initBaseUI()
	local var_13_0 = ccui.ImageView:create(var_0_1 .. "top_mask_daily.png", var_0_0)

	var_13_0:setAnchorPoint(cc.p(0.5, 1))
	var_13_0:setPosition(320, GameDisplay.height)
	self.rootLayer:addChild(var_13_0, 99)

	local var_13_1 = ccui.Button:create(var_0_1 .. "title_daily.png", var_0_1 .. "title_daily.png", var_0_1 .. "title_daily.png", var_0_0)

	var_13_1:setAnchorPoint(cc.p(0, 1))
	var_13_1:setPosition(0, GameDisplay.height)
	self.rootLayer:addChild(var_13_1, 99)
	var_13_1:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ExploreOfferLayer"
		})
	end)

	local var_13_2 = ccui.Button:create(var_0_1 .. "power.png", var_0_1 .. "power.png", var_0_1 .. "power.png", var_0_0)

	var_13_2:setAnchorPoint(1, 1)
	var_13_2:setPosition(GameDisplay.width, GameDisplay.height - 20)
	self.rootLayer:addChild(var_13_2, 99)

	local var_13_3 = cc.Label:createWithTTF("", FONT_NAME, 24)

	var_13_3:setPosition(var_13_2:getContentSize().width / 2 + 5, var_13_2:getContentSize().height / 2)
	var_13_2:addChild(var_13_3)
	var_13_2:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopElectricSupplyLayer", {
			callback = function()
				if var_0_10 then
					var_0_10:updateUI()
				end
			end
		})
	end)

	local var_13_4 = ccui.ImageView:create(var_0_1 .. "bottom_daily.png", var_0_0)

	var_13_4:setAnchorPoint(cc.p(0, 0))
	var_13_4:setPosition(0, 0)
	self.rootLayer:addChild(var_13_4, 2)

	local var_13_5 = ccui.Button:create(var_0_1 .. "return.png", var_0_1 .. "return.png", var_0_1 .. "return.png", var_0_0)

	var_13_5:setAnchorPoint(cc.p(0, 0.5))
	var_13_5:setPosition(0, var_13_4:getContentSize().height / 2)
	var_13_4:addChild(var_13_5)
	var_13_5:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			KeyCodeManager:onKeyReleasedCallFunc()
		end
	end)

	local var_13_6 = ccui.Button:create(var_0_1 .. "switch_to_daily.png", var_0_1 .. "switch_to_daily.png", var_0_1 .. "switch_to_daily.png", var_0_0)

	var_13_6.offer_class = "daily"

	var_13_6:setAnchorPoint(cc.p(1, 0.5))
	var_13_6:setPosition(var_13_4:getContentSize().width, var_13_4:getContentSize().height / 2)
	var_13_4:addChild(var_13_6)
	var_13_6:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:switchOfferClass("daily")
	end)

	local var_13_7 = ccui.Button:create(var_0_1 .. "switch_to_special.png", var_0_1 .. "switch_to_special.png", var_0_1 .. "switch_to_special.png", var_0_0)

	var_13_7.offer_class = "special"

	var_13_7:setAnchorPoint(cc.p(1, 0.5))
	var_13_7:setPosition(var_13_4:getContentSize().width - var_13_7:getContentSize().width - 20, var_13_4:getContentSize().height / 2)
	var_13_4:addChild(var_13_7)
	var_13_7:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:switchOfferClass("special")
	end)

	local var_13_8 = cc.Label:createWithTTF("", FONT_NAME, 24)

	var_13_8:setAnchorPoint(cc.p(0, 0.5))
	var_13_8:setPosition(75, var_13_4:getContentSize().height / 2)
	var_13_4:addChild(var_13_8)

	local var_13_9 = ccui.Button:create(var_0_1 .. "search_bg.png", var_0_1 .. "search_bg.png", var_0_1 .. "search_bg.png", var_0_0)

	var_13_9:addTouchEventListener(function()
		return
	end)
	var_13_9:setAnchorPoint(cc.p(1, 0))
	var_13_9:setPosition(636, var_13_4:getContentSize().height + 6)
	var_13_4:addChild(var_13_9)

	local var_13_10 = cc.Label:createWithTTF("", FONT_NAME, 20)

	var_13_10:setAnchorPoint(cc.p(0, 1))
	var_13_10:setPosition(24, var_13_9:getContentSize().height - 13)
	var_13_9:addChild(var_13_10)

	local var_13_11 = cc.Label:createWithTTF("", FONT_NAME, 26)

	var_13_11:setColor(cc.c3b(255, 222, 175))
	var_13_11:setAnchorPoint(cc.p(0, 0))
	var_13_11:setPosition(24, 15)
	var_13_9:addChild(var_13_11)
	var_13_9:setTouchEnabled(true)

	local var_13_12 = L2Skeleton:create("spine/ui/robot.json", "spine/ui/robot.atlas", nil, true)

	var_13_12:refreshSkeleton()
	var_13_12:setPosition(-14, -40)
	var_13_9:addChild(var_13_12)

	self.topBg = var_13_0
	self.titleBtn = var_13_1
	self.limitLabel = var_13_8
	self.powerLabel = var_13_3
	self.switchBtns = {
		var_13_6,
		var_13_7
	}
	self.timeLabel = var_13_10
	self.numLabel = var_13_11
	self.searchBg = var_13_9
	self.searchSpine = var_13_12
	self.bottomBg = var_13_4

	self:updateUI()
end

function ExploreOfferLayer:initTimer()
	local var_21_0 = 0

	self:scheduleUpdateWithPriorityLua(function(arg_22_0)
		var_21_0 = var_21_0 + arg_22_0

		if var_21_0 > 1 then
			if self.readyTime > 0 then
				self.readyTime = self.readyTime - 1

				if self.readyTime <= 0 then
					explore_manager:initOfferConfig(function()
						if var_0_10 then
							var_0_10:updateData()
							var_0_10:updateList()
							var_0_10:updateUI(true)
						end
					end)
				end
			end

			self.timeLabel:setString(L_OFFER_SEARCH .. var_0_13(self.readyTime))

			var_21_0 = 0
		end
	end, 1)
end

function ExploreOfferLayer:updateUI(arg_24_1)
	if self.offer_class == "daily" then
		self.searchBg:setVisible(true)
		self.limitLabel:setVisible(true)
	else
		self.searchBg:setVisible(false)
		self.limitLabel:setVisible(false)
	end

	self.powerLabel:setString(global_trans_number(item_manager:getItemNumber(ELECTRIC)))
	self.numLabel:setString(L_OFFER_READY .. explore_manager:getReadyOfferNum() .. "/" .. explore_manager:getReadyOfferLimit())
	self.bg:loadTexture("mainScenebg/offer_bg_" .. self.offer_class .. ".png")
	self.topBg:loadTexture(var_0_1 .. "top_mask_" .. self.offer_class .. ".png", var_0_0)
	self.titleBtn:loadTextures(var_0_1 .. "title_" .. self.offer_class .. ".png", var_0_1 .. "title_" .. self.offer_class .. ".png", var_0_1 .. "title_" .. self.offer_class .. ".png", var_0_0)
	self.bottomBg:loadTexture("ExploreOfferLayer/bottom_" .. self.offer_class .. ".png", var_0_0)

	for iter_24_0, iter_24_1 in pairs(self.switchBtns) do
		if iter_24_1.offer_class == self.offer_class then
			iter_24_1:loadTextures(var_0_1 .. "switch_to_" .. iter_24_1.offer_class .. ".png", var_0_1 .. "switch_to_" .. iter_24_1.offer_class .. ".png", var_0_1 .. "switch_to_" .. iter_24_1.offer_class .. ".png", var_0_0)
		else
			iter_24_1:loadTextures(var_0_1 .. "switch_to_" .. iter_24_1.offer_class .. "_off.png", var_0_1 .. "switch_to_" .. iter_24_1.offer_class .. "_off.png", var_0_1 .. "switch_to_" .. iter_24_1.offer_class .. "_off.png", var_0_0)
		end
	end

	self.limitLabel:setString("持有:" .. (self.offer_class == "daily" and #self.offerData .. "/" .. explore_manager:getRunningOfferLimit() or #self.offerData))
	self:updateSpine(arg_24_1)
end

function ExploreOfferLayer:updateSpine(arg_25_1)
	if arg_25_1 then
		self.searchSpine:play("search3", false)
		self.searchSpine:addAnimation("search", true)
	elseif explore_manager:getReadyOfferNum() > 0 then
		self.searchSpine:play("search2", true)
	else
		self.searchSpine:play("search", true)
	end
end

function ExploreOfferLayer:initList()
	self.scrollView = ccui.ScrollView:create()

	self.scrollView:setContentSize(cc.size(GameDisplay.width, GameDisplay.height - 60))
	self.scrollView:setPosition(0, 60)
	self.rootLayer:addChild(self.scrollView)
	self:updateList()
end

function ExploreOfferLayer:updateList()
	self.scrollView:removeAllChildren()

	local var_27_0 = 164 * #self.offerData + 100

	var_27_0 = 164 * #self.offerData + 100 < self.scrollView:getContentSize().height and self.scrollView:getContentSize().height or var_27_0

	self.scrollView:setInnerContainerSize(cc.size(640, var_27_0))

	for iter_27_0, iter_27_1 in ipairs(self.offerData) do
		local var_27_1 = self:createSp(iter_27_0, iter_27_1)

		var_27_1:setAnchorPoint(cc.p(0, 1))
		var_27_1:setPosition(iter_27_0 % 2 == 0 and 40 or 267, var_27_0 - 100 - (iter_27_0 - 1) * 164)
		self.scrollView:addChild(var_27_1)
	end
end

function ExploreOfferLayer:createSp(arg_28_1, arg_28_2)
	local var_28_0 = ccui.Button:create(var_0_1 .. "offer_bg_" .. (self.offer_class == "special" and "s" or arg_28_2.equip_quality) .. ".png", var_0_1 .. "offer_bg_" .. (self.offer_class == "special" and "s" or arg_28_2.equip_quality) .. ".png", var_0_1 .. "offer_bg_" .. (self.offer_class == "special" and "s" or arg_28_2.equip_quality) .. ".png", var_0_0)
	local var_28_1 = ccui.ImageView:create(ROLE_HEAD_IMAGE_PATH .. arg_28_2.head .. ".png")

	var_28_1:setScale(0.35)
	var_28_1:setPosition(76, 86)
	var_28_0:addChild(var_28_1)

	local var_28_2 = cc.Label:createWithTTF(arg_28_2.title, FONT_NAME, 24)

	var_28_2:setColor(cc.c3b(255, 222, 175))
	var_28_2:setAnchorPoint(cc.p(0, 0))
	var_28_2:setPosition(118, 96)
	var_28_0:addChild(var_28_2)

	local var_28_3 = ccui.ImageView:create("public/currency/electric.png", var_0_0)

	var_28_3:setPosition(128, 76)
	var_28_3:setScale(0.9)
	var_28_0:addChild(var_28_3)

	local var_28_4 = cc.Label:createWithTTF(arg_28_2.power_cost, FONT_NAME, 20)

	var_28_4:setAnchorPoint(cc.p(0, 1))
	var_28_4:setPosition(143, 92)
	var_28_0:addChild(var_28_4)

	local var_28_5 = ccui.Button:create(var_0_1 .. "cancel_button.png", nil, var_0_1 .. "cancel_button.png", var_0_0)

	var_28_5:setAnchorPoint(cc.p(1, 1))
	var_28_5:setPosition(var_28_0:getContentSize().width, var_28_0:getContentSize().height)
	var_28_0:addChild(var_28_5)
	var_28_5:setVisible(self.offer_class == "daily")
	var_28_5:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_29_0.isLock then
			return
		end

		arg_29_0.isLock = true

		LayerManager:pushInLayer("PopDoLayer", {
			surecallback = function()
				explore_manager:cancel_offer(arg_28_2.offerid, function(arg_31_0)
					if arg_31_0 == 1 then
						self:executeRemoveAction(var_28_0)
					else
						arg_29_0.isLock = false
					end
				end)
			end,
			cancelcallback = function()
				arg_29_0.isLock = false
			end,
			labels = L_OFFER_CANCEL_TBL
		})
	end)

	local var_28_6 = ccui.ImageView:create(var_0_1 .. "img_mop_up.png", var_0_0)

	var_28_6:setAnchorPoint(0, 0.5)
	var_28_6:setPosition(30, 25)
	var_28_0:addChild(var_28_6)
	var_28_6:setVisible((IsOpenPrivilege() or nil) and explore_manager:queryAimCanMopUp(arg_28_2.aimid))

	local var_28_8 = ccui.Layout:create()

	var_28_8:setTouchEnabled(false)
	var_28_8:setContentSize(cc.size(218, 63))
	var_28_8:setAnchorPoint(cc.p(1, 0))
	var_28_8:setPosition(var_28_0:getContentSize().width - 10, 6)
	var_28_0:addChild(var_28_8)

	for iter_28_0, iter_28_1 in ipairs(arg_28_2.drops) do
		if iter_28_0 <= 3 then
			local var_28_9 = ccui.ImageView:create("public/box/" .. item_data[iter_28_1.dropid].equip_quality .. ".png", var_0_0)

			var_28_9:setScale(0.6)
			var_28_9:setAnchorPoint(cc.p(1, 0.5))
			var_28_9:setPosition(var_28_8:getContentSize().width - 65 * (iter_28_0 - 1), 31)
			var_28_8:addChild(var_28_9)

			local var_28_10 = ItemNoBgSprite:create(iter_28_1.dropid)

			var_28_10:setScale(80 / var_28_10:getChildByName("icon"):getContentSize().width)
			var_28_10:setPosition(var_28_9:getContentSize().width / 2, var_28_9:getContentSize().height / 2)
			var_28_9:addChild(var_28_10)
		end
	end

	var_28_0:addTouchEventListener(function(arg_33_0, arg_33_1)
		if arg_33_1 ~= ccui.TouchEventType.ended then
			return
		end

		explore_manager:begin_explore({
			returnLayer = "ExploreOfferLayer",
			type = "offer",
			offerid = arg_28_2.offerid,
			info = arg_28_2
		})
	end)

	var_28_0.index = arg_28_1
	var_28_0.info = arg_28_2
	var_28_0.headImg = var_28_1
	var_28_0.titleLabel = var_28_2
	var_28_0.desLabel = var_28_4
	var_28_0.itemList = var_28_8

	self:updateNewOfferEffect(var_28_0)

	return var_28_0
end

function ExploreOfferLayer.updateNewOfferEffect(arg_34_0, arg_34_1)
	if arg_34_1.index > explore_manager:get_new_running_offer_num() then
		return
	end

	local var_34_0 = L2Skeleton:create("spine/ui/robot_effect.json", "spine/ui/robot_effect.atlas", nil, true)

	var_34_0:refreshSkeleton()
	var_34_0:setPosition(arg_34_1:getContentSize().width / 2, arg_34_1:getContentSize().height / 2)
	arg_34_1:addChild(var_34_0)
	var_34_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_35_0)
		var_34_0:runAction(cc.RemoveSelf:create())
	end)
	arg_34_1:setOpacity(0)
	arg_34_1.itemList:setVisible(false)
	arg_34_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.2 * arg_34_1.index), cc.Spawn:create(cc.FadeIn:create(0.4), cc.CallFunc:create(function()
		var_34_0:play("renwu", false)
		arg_34_1.itemList:setVisible(true)
	end))))
end

function ExploreOfferLayer.executeRemoveAction(arg_37_0, arg_37_1)
	local var_37_0 = L2Skeleton:create("spine/ui/robot_effect.json", "spine/ui/robot_effect.atlas", nil, true)

	var_37_0:refreshSkeleton()
	var_37_0:setPosition(arg_37_1:getContentSize().width / 2, arg_37_1:getContentSize().height / 2)
	arg_37_1:addChild(var_37_0)
	var_37_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_38_0)
		arg_37_1:runAction(cc.Sequence:create(cc.FadeOut:create(0.4), cc.CallFunc:create(function()
			arg_37_0.scrollView:jumpToTop()
			arg_37_0:updateData()
			arg_37_0:updateList()
			arg_37_0:updateUI()
		end), cc.RemoveSelf:create()))
	end)
	var_37_0:play("renwu", false)
end

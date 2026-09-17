ActivitySignLayer_9_1 = class("ActivitySignLayer_9_1", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSprite")

local item_data = require("data.item_data")
local drop_data = require("data.drop_data")
local time_check_manager = require("controller.time_check_manager")
local activity_manager = require("controller.activity_manager")
local var_0_4
local var_0_5 = config._DEBUG and 0 or 1

function ActivitySignLayer_9_1.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivitySignLayer_9_1.new()

	require("controller.texture_manager"):loadPopLayerTextures({
		"Activity_bianhua_Sign"
	})
	var_2_0:init(arg_2_1)
	var_2_0:setName("ActivitySignLayer_9_1")

	return var_2_0
end

function ActivitySignLayer_9_1:init(arg_3_1)
	var_0_4 = true
	self.signTime = arg_3_1.signTime

	if self.signTime >= 7 and arg_3_1.isAutoPop then
		LayerManager:removePopLayer(self.__queueindex)

		return
	end

	self.signData = arg_3_1.signData
	self.signTag = arg_3_1.signTag
	self.callback = arg_3_1.callback
	self.activityId = arg_3_1.activityId
	self.otherData = arg_3_1.otherData
	self.auto = arg_3_1.auto
	self.activitySingCallback = arg_3_1.activitySingCallback
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Activity_Bianhua_Sign.json" or "Activity_Bianhua_Sign.ExportJson")

	self:addChild(self.rootLayer)

	self.sign_bg = ccui.Helper:seekWidgetByName(self.rootLayer, "sign_bg")
	self.awards_list = ccui.Helper:seekWidgetByName(self.rootLayer, "awards_list")
	self.button_next = ccui.Helper:seekWidgetByName(self.rootLayer, "button_next")
	self.button_last = ccui.Helper:seekWidgetByName(self.rootLayer, "button_last")
	self.button_sure = ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure")
	self.panel_item = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_item")
	self.label_sure = ccui.Helper:seekWidgetByName(self.rootLayer, "label_sure")
	self.image_bg = ccui.Helper:seekWidgetByName(self.rootLayer, "image_bg")

	self.panel_item:setVisible(false)
	self.button_next:setVisible(false)
	self.button_last:setVisible(false)
	self.image_bg:setTouchEnabled(true)
	self.label_sure:setString(L_ACTIVITY_SIGN_BTN)

	local var_3_0 = 0

	for iter_3_0, iter_3_1 in pairs((require("data.activity_sign_data"))) do
		if iter_3_1.sign_id == "2-3" then
			var_3_0 = var_3_0 + 1
		end
	end

	if var_3_0 <= self.signTime then
		self.label_sure:setString(L_ACTIVITY_SIGN_END)
		self.button_sure:setBright(false)
		self.button_sure:loadTextures("public/button/public_button_white_long.png", nil, "public/button/public_button_white_long.png", var_0_5)
	elseif self:isCheckSignIn() then
		if self.signTag then
			self.button_sure:loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_5)
			self.label_sure:setString(L_ACTIVITY_SIGN_FINISH)
			self.button_sure:setPressedActionEnabled(true)
			self.button_sure:setBright(false)
		else
			self.label_sure:setString(L_ACTIVITY_SIGN_BTN)
			self.button_sure:loadTextures("public/button/public_button_orange_big.png", nil, "public/button/public_button_orange_big.png", var_0_5)
		end
	end

	self:createSignBg()
	self:createLimitTime()
	self:createAwards()
	self:getAwards()
	self:registerActivityEventListener()
	self.rootLayer:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exitCallback()
	end)
	self.button_sure:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.signTime > var_3_0 then
			global_ShowBlockWords(L_ACTIVITY_SIGN_CLOSE, nil, nil, 2)

			return
		end

		self.activitySingCallback(function(arg_6_0)
			if arg_6_0 == 1 then
				self:activitySign()
				activity_manager:updateActivityAlert("sign", self.activityId, false)
				activity_manager:fireEvent(activity_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT)
				self.label_sure:setString(L_ACTIVITY_SIGN_FINISH)
				self.button_sure:loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_5)

				if self.signTime == var_3_0 then
					self.label_sure:setString(L_ACTIVITY_SIGN_END)
					self.button_sure:loadTextures("public/button/public_button_white_long.png", nil, "public/button/public_button_white_long.png", var_0_5)
				end

				self.button_sure:setBright(false)
			end
		end)
	end)
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			activity_manager:releaseEventListenerByName("ActivitySignLayer_9_1")

			if self.callback then
				self.callback()
			end

			var_0_4 = nil
		end
	end)
	self:fullScreen(self.rootLayer)
end

function ActivitySignLayer_9_1:isCheckSignIn()
	local var_8_0 = false

	if not self.signData or self.signData == "0" then
		return var_8_0
	else
		local var_8_1 = string_split(self.signData, "-")

		var_8_0 = self.signData == os.date("%Y-%m-%d", (time_check_manager:getCurTime()))
	end

	print("flag", var_8_0)

	return var_8_0
end

local function var_0_6(arg_9_0)
	local var_9_0

	if config._DEBUG then
		var_9_0 = cc.Sprite:create("Activity_bianhua_Sign/item_bg.png") or cc.Sprite:createWithSpriteFrameName("Activity_bianhua_Sign/item_bg.png")
	end

	var_9_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_9_0:setScale(arg_9_0:getContentSize().width * 0.95 / var_9_0:getContentSize().width)
	var_9_0:setPosition(cc.p(arg_9_0:getContentSize().width / 2, arg_9_0:getContentSize().height / 2 + 20))
	arg_9_0:addChild(var_9_0)
end

function ActivitySignLayer_9_1:createSignBg()
	self.sign_bg:loadTexture("mainScenebg/activity/" .. self.otherData.path .. "/sign_bg.png")
	self.sign_bg:setPosition(cc.p(280, 495))
end

function ActivitySignLayer_9_1:createLimitTime()
	local var_11_0 = cc.Label:createWithTTF("", FONT_DES, 22)

	var_11_0:setAnchorPoint(cc.p(1, 0))
	var_11_0:setPosition(cc.p(540, 766))
	var_11_0:setColor(cc.c3b(143, 174, 189))
	self.image_bg:addChild(var_11_0)

	local var_11_1 = math.ceil((global_get_time_by_date(self.otherData.endTime) - os.time()) / 86400)

	if var_11_1 >= 0 then
		var_11_0:setString(string.format(L_ACTIVITY_REST_TIME, var_11_1))
	else
		var_11_0:setString(L_ACTIVITY_END)
	end

	var_11_0:setVisible(false)
end

function ActivitySignLayer_9_1.registerActivityEventListener(arg_12_0)
	return
end

function ActivitySignLayer_9_1:createAwards()
	local var_13_0 = self.panel_item:getContentSize().width + 10
	local var_13_2 = 1

	while self.otherData.drops[var_13_2] do
		local var_13_3 = self.panel_item:clone()

		var_13_3:setVisible(true)
		var_13_3:setAnchorPoint(cc.p(0, 0.5))
		var_13_3:setPosition(cc.p(0 + (var_13_2 - 1) * var_13_0, 80))
		var_13_3:setName("award" .. var_13_2)
		ccui.Helper:seekWidgetByName(var_13_3, "Label_day"):setString(L_SIGN_DATE[var_13_2])
		self.awards_list:addChild(var_13_3)

		local var_13_4
		local var_13_5

		if drop_data[self.otherData.drops[var_13_2]].drop_id1 then
			var_13_5 = drop_data[self.otherData.drops[var_13_2]].drop_num1
			var_13_4 = drop_data[self.otherData.drops[var_13_2]].drop_id1
		elseif drop_data[self.otherData.drops[var_13_2]].diamond then
			var_13_5 = drop_data[self.otherData.drops[var_13_2]].diamond
			var_13_4 = "diamond"
		elseif drop_data[self.otherData.drops[var_13_2]].gold then
			var_13_5 = drop_data[self.otherData.drops[var_13_2]].gold
			var_13_4 = "gold"
		end

		local var_13_6 = ItemSprite:createSignNewWithItemId(var_13_4, var_13_5, nil, nil, nil, 1)

		if var_13_5 == 1 then
			var_13_6:getChildByName("number"):setString("X1")
		end

		var_13_6:setAnchorPoint(cc.p(0.5, 0.5))
		var_13_6:setPosition(cc.p(var_13_3:getContentSize().width / 2, var_13_3:getContentSize().height / 2 + 20))
		var_13_3:addChild(var_13_6)
		var_13_6:setScale(0.65)

		var_13_3.itemid = var_13_4

		if var_13_4 ~= "gold" and var_13_4 ~= "diamond" then
			var_13_3.item_type = "item"
		end

		var_13_3:addTouchEventListener(function(arg_14_0, arg_14_1)
			if arg_14_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:showAwardsDetails(arg_14_0.itemid, arg_14_0.item_type)
		end)

		var_13_2 = var_13_2 + 1
	end

	if var_13_2 - 1 > 4 then
		self.awards_list:setInnerContainerSize(cc.size(var_13_0 * (var_13_2 - 1) + 10, 160))
	else
		self.awards_list:setInnerContainerSize(cc.size(500, 160))
	end

	local var_13_7 = self.awards_list:getContentSize().width
	local var_13_8 = self.awards_list:getInnerContainerSize().width
end

function ActivitySignLayer_9_1:getAwards()
	local function var_17_0(arg_18_0)
		local var_18_0

		if config._DEBUG then
			var_18_0 = cc.Sprite:create("public/panelbg/fragment_tic_new.png") or cc.Sprite:createWithSpriteFrameName("public/panelbg/fragment_tic_new.png")
		end

		var_18_0:setScale(0.7)
		var_18_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_18_0:setPosition(cc.p(arg_18_0:getContentSize().width * 3 / 4 - 10, arg_18_0:getContentSize().height / 4))
		arg_18_0:addChild(var_18_0, 10)
		var_0_6(arg_18_0)
	end

	local var_17_1 = self.awards_list:getContentSize().width
	local var_17_2 = self.awards_list:getInnerContainerSize().width

	if self.signTime >= 4 then
		(function()
			local var_19_0 = self.awards_list:getInnerContainer()
			local var_19_1 = math.abs((var_19_0:getPositionX()))
			local var_19_2 = (var_19_0 + (0.9 + 0.28 * (self.signTime - 2.8)) * var_17_1) / var_17_2

			if (var_19_0 + (0.9 + 0.28 * (self.signTime - 2.8)) * var_17_1) / var_17_2 > 1 then
				var_19_2 = 1
			end

			if var_19_2 >= 0 and var_19_2 <= 1 then
				self.awards_list:scrollToPercentHorizontal(var_19_2 * 100, 0.2, false)
			end
		end)()
	end

	while 1 <= self.signTime do
		var_17_0((self.awards_list:getChildByName("award" .. 1)))
	end
end

function ActivitySignLayer_9_1:activitySign()
	if self.signTag == true then
		local var_20_0 = self.awards_list:getChildByName("award" .. self.signTime + 1)

		;(function(arg_21_0)
			local var_21_0

			if config._DEBUG then
				var_21_0 = cc.Sprite:create("public/panelbg/fragment_tic_new.png") or cc.Sprite:createWithSpriteFrameName("public/panelbg/fragment_tic_new.png")
			end

			var_21_0:setScale(3.5)
			var_21_0:setAnchorPoint(cc.p(0.5, 0.5))
			var_21_0:setPosition(cc.p(arg_21_0:getContentSize().width * 3 / 4 - 10, arg_21_0:getContentSize().height / 4))
			var_21_0:setName("success")
			arg_21_0:addChild(var_21_0, 10)
			var_0_6(arg_21_0)
			var_21_0:runAction(cc.ScaleTo:create(0.5, 0.7))
		end)(var_20_0)

		if var_20_0.itemid ~= "gold" and var_20_0.itemid ~= "diamond" and item_data[var_20_0.itemid].bag_item_type == kITEM_HERO then
			require("view.Layer.GetRoleAnimationLayer")
			cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_20_0.itemid), 999)
		end
	end
end

function ActivitySignLayer_9_1:exitCallback()
	LayerManager:removePopLayer(self.__queueindex)
end

function ActivitySignLayer_9_1:showAwardsDetails(arg_23_1, arg_23_2)
	if arg_23_2 == "item" then
		if item_data[arg_23_1].bag_item_type == kITEM_HORCRUX then
			local var_23_0 = -1
			local var_23_1 = require("data.item_data")[arg_23_1].horcruxtype

			for iter_23_0, iter_23_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if arg_23_1 == iter_23_1.item_id then
					var_23_0 = iter_23_0

					break
				end
			end

			if var_23_0 == -1 then
				print("did not find id")

				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_23_0,
				itemid = arg_23_1,
				callback = callback
			})
		elseif item_data[arg_23_1].bag_item_type == kITEM_HERO then
			LayerManager:pushInLayer("SoulsLayer", {
				showListButton = true,
				showtype = 6,
				layertype = "DropDetailsLayer",
				cursoul = item_data[arg_23_1].servant
			})
		elseif not self:getChildByName("OTHER_LAYER") then
			local var_23_2 = PopLayer:Item({
				hideGainButton = true,
				itemid = arg_23_1
			})
		end
	elseif arg_23_2 == "gold" then
		-- block empty
	elseif arg_23_2 == "diamond" then
		-- block empty
	end
end

function ActivitySignLayer_9_1.fullScreen(arg_24_0, arg_24_1)
	arg_24_1:setContentSize((GameDisplay.getScreenSize()))
	arg_24_1:setPositionY(arg_24_1:getPositionY() - GameDisplay.fix_y)
	arg_24_1:getChildByName("image_bg"):setPositionY(arg_24_1:getChildByName("image_bg"):getPositionY() + GameDisplay.fix_y)
	arg_24_1:getChildByName("button_sure"):setPositionY(arg_24_1:getChildByName("button_sure"):getPositionY() + GameDisplay.fix_y)
end

function ActivitySignLayer_9_1:exit()
	self:exitCallback()
end

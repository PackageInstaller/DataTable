ActivityJpCbSignLayer = class("ActivityJpCbSignLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local drop_manager = require("controller.drop_manager")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_data = require("data.item_data")
local activity_conf_data = require("data.activity_conf_data")

function ActivityJpCbSignLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityJpCbSignLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function ActivityJpCbSignLayer:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(false)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.rootLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.ImageView:create("ActivityJpCbSignLayer/recharge_bg.png", var_0_0)

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2 - GameDisplay.fix_y)
	self.rootpanel:setTouchEnabled(true)
	self.rootLayer:addChild(self.rootpanel)
	self.showActions.extendVertical(self)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback(0)
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)
	self:initData(function(...)
		self:updateUI()
	end)
	self:initUI()
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" and MainLayer and MainLayer.getInstance() and arg_3_1 and arg_3_1.exit_set_bright_callback then
			arg_3_1.exit_set_bright_callback()
		end
	end)
end

function ActivityJpCbSignLayer:initData(arg_8_1)
	self.curIndex = 1
	self.activityid = 43
	self.data = {}

	activity_manager:getActivityObj(self.activityid):getActivitySignData(function(arg_9_0)
		self.activitySingCallback = arg_9_0.activitySingCallback

		for iter_9_0, iter_9_1 in pairs(arg_9_0.otherData.drops) do
			table.insert(self.data, {
				id = iter_9_0,
				dropid = iter_9_1
			})
		end

		self.signstats = arg_9_0.signstats

		for iter_9_2, iter_9_3 in pairs(self.signstats) do
			if iter_9_3 then
				self.curIndex = iter_9_2 + 1
			end
		end

		self.curIndex = math.min(self.curIndex, #self.signstats)
		self.signdate = arg_9_0.signdate

		if arg_8_1 then
			arg_8_1()
		end
	end)
end

local var_0_10 = {
	cc.p(40, 250),
	cc.p(140, 250),
	cc.p(240, 250),
	cc.p(40, 115),
	cc.p(140, 115),
	(cc.p(240, 115))
}

function ActivityJpCbSignLayer:initUI()
	self.itemsPanel = ccui.Layout:create()

	self.itemsPanel:setTouchEnabled(true)
	self.itemsPanel:setContentSize(cc.size(300, 300))
	self.itemsPanel:setAnchorPoint(cc.p(0, 0))
	self.itemsPanel:setPosition(cc.p(300, 120))
	self.itemsPanel:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.itemsPanel:setBackGroundColor(cc.c3b(255, 0, 0))
	self.rootpanel:addChild(self.itemsPanel)

	self.leftArrow = ccui.ImageView:create("ActivityJpCbSignLayer/arrow_createrole.png", var_0_0)

	self.leftArrow:setTouchEnabled(true)
	self.leftArrow:setPosition(cc.p(260, self.rootpanel:getContentSize().height / 2 - 20))
	self.rootpanel:addChild(self.leftArrow, 10)
	self.leftArrow:runAction(cc.RotateTo:create(0, 180))
	self.leftArrow:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.curIndex = math.max(1, self.curIndex - 1)

		self:updateUI()
	end)

	self.rightArrow = ccui.ImageView:create("ActivityJpCbSignLayer/arrow_createrole.png", var_0_0)

	self.rightArrow:setTouchEnabled(true)
	self.rightArrow:setPosition(cc.p(610, self.rootpanel:getContentSize().height / 2 - 20))
	self.rootpanel:addChild(self.rightArrow, 10)
	self.rightArrow:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.curIndex = math.min(#self.data, self.curIndex + 1)

		self:updateUI()
	end)

	self.getAwardBtn = ccui.Button:create("public/button/public_button_orange_big.png", nil, "public/button/public_button_orange_big.png", var_0_0)

	self.getAwardBtn:setPosition(cc.p(320, -50))
	self.rootpanel:addChild(self.getAwardBtn)
	self.getAwardBtn:addTouchEventListener(self:getAwardHanel())

	self.getAwardLabel = cc.Label:createWithTTF("", FONT_BUTTON, 32)

	self.getAwardLabel:setAnchorPoint(cc.p(0.5, 0.5))
	self.getAwardLabel:setColor(cc.c3b(12, 12, 12))
	self.getAwardLabel:setPosition(cc.p(self.getAwardBtn:getContentSize().width / 2, self.getAwardBtn:getContentSize().height / 2 - 5))
	self.getAwardBtn:addChild(self.getAwardLabel)

	self.unlockSignTimeLabel = cc.Label:createWithTTF("", FONT_DES, 24)

	self.unlockSignTimeLabel:setPosition(self.getAwardBtn:getContentSize().width / 2, -20)
	self.getAwardBtn:addChild(self.unlockSignTimeLabel)

	self.dayLabel = ccui.TextBMFont:create(1, "fonts/jpcb_activity_sign.fnt")

	self.dayLabel:setPositionX(540)
	self.dayLabel:setPositionY(461)
	self.dayLabel:setAnchorPoint(cc.p(0, 0.5))
	self.dayLabel:getVirtualRenderer():setBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
	self.rootpanel:addChild(self.dayLabel)

	self.dayPonts = {}

	for iter_10_0 = 1, 7 do
		self.dayPonts[iter_10_0] = ccui.ImageView:create("ActivityJpCbSignLayer/point.png", var_0_0)

		self.dayPonts[iter_10_0]:setPosition(cc.p(320 + iter_10_0 * 30, 146))
		self.rootpanel:addChild(self.dayPonts[iter_10_0])
	end
end

function ActivityJpCbSignLayer.getAwardHanel(arg_13_0)
	return function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_14_0:isBright() then
			return
		end

		arg_14_0:setBright(false)

		if arg_13_0.activitySingCallback then
			if arg_13_0.signstats[arg_13_0.curIndex] then
				global_ShowBlockWords(L_ACTIVITY_SIGN_TODAY.Finish)
				arg_14_0:setBright(true)

				return
			end

			local var_14_0 = 0

			for iter_14_0, iter_14_1 in pairs(arg_13_0.signstats) do
				if iter_14_1 then
					var_14_0 = iter_14_0
				end
			end

			if arg_13_0.curIndex ~= var_14_0 + 1 then
				global_ShowBlockWords(L_ACTIVITY_SIGN_TODAY.Error)
				arg_14_0:setBright(true)

				return
			end

			if os.date((global_get_time_by_date(arg_13_0.signdate[arg_13_0.curIndex] .. " 00:00:00"))) > os.date((time_check_manager:getCurTime())) then
				global_ShowBlockWords(L_ACTIVITY_SIGN_TODAY.Nil)
				arg_14_0:setBright(true)

				return
			end

			arg_13_0.activitySingCallback(arg_13_0.curIndex, function(arg_15_0)
				if arg_15_0 == 1 then
					arg_13_0.signstats[arg_13_0.curIndex] = true

					for iter_15_0, iter_15_1 in pairs(arg_13_0.signstats) do
						if iter_15_1 then
							arg_13_0.curIndex = iter_15_0 + 1
						end
					end

					arg_13_0.curIndex = math.min(arg_13_0.curIndex, #arg_13_0.signstats)

					arg_13_0:updateUI()
				elseif arg_15_0 == 7 then
					global_ShowBlockWords(L_ACTIVITY_SIGN_TODAY.Error)
				end

				arg_14_0:setBright(true)
			end)
		end
	end
end

function ActivityJpCbSignLayer.updateUI(arg_16_0)
	(function(...)
		while arg_16_0.itemsPanel:getChildByName("itemSp_" .. 1) do
			arg_16_0.itemsPanel:removeChild((arg_16_0.itemsPanel:getChildByName("itemSp_" .. 1)))
		end
	end)()
	;(function()
		local var_18_0 = drop_manager:getDropMsg(arg_16_0.data[arg_16_0.curIndex].dropid)
		local var_18_1 = {}

		if var_18_0.diamond > 0 then
			table.insert(var_18_1, {
				itemid = "diamond",
				num = var_18_0.diamond,
				name = L_DIAMOND
			})
		end

		if var_18_0.gold > 0 then
			table.insert(var_18_1, {
				itemid = "gold",
				num = var_18_0.gold,
				name = L_GOLD
			})
		end

		local var_18_2 = {}

		for iter_18_0, iter_18_1 in pairs(var_18_0.equips) do
			table.insert(var_18_2, {
				itemid = iter_18_1.dropid,
				num = iter_18_1.dropNum,
				name = item_data[iter_18_1.dropid].name
			})
		end

		for iter_18_2, iter_18_3 in pairs(var_18_2) do
			table.insert(var_18_1, iter_18_3)
		end

		for iter_18_4, iter_18_5 in pairs(var_18_1) do
			local var_18_3 = ccui.Button:create("public/box/new_item_bg1.png", "public/box/new_item_bg1.png", "public/box/new_item_bg1.png", var_0_0)

			var_18_3:setScale(0.55)
			var_18_3:setName("itemSp_" .. iter_18_4)
			var_18_3:setPosition(var_0_10[iter_18_4])

			var_18_3.itemid = iter_18_5.itemid

			arg_16_0.itemsPanel:addChild(var_18_3)

			if type(iter_18_5.itemid) == "number" then
				var_18_3:addTouchEventListener(function(arg_19_0, arg_19_1)
					if arg_19_1 ~= ccui.TouchEventType.ended then
						return
					end

					PopLayer:Item({
						hideGainButton = true,
						itemid = arg_19_0.itemid
					})
				end)
			end

			local var_18_4 = ItemSprite:createNewWithItemId(iter_18_5.itemid, iter_18_5.num)

			var_18_4:setName("itemSp")
			var_18_4:setAnchorPoint(cc.p(0, 0))
			var_18_3:addChild(var_18_4)
		end
	end)()
	;(function(...)
		arg_16_0.leftArrow:setVisible(true)
		arg_16_0.rightArrow:setVisible(true)

		if arg_16_0.curIndex == 1 then
			arg_16_0.leftArrow:setVisible(false)
		end

		if arg_16_0.curIndex == #arg_16_0.data then
			arg_16_0.rightArrow:setVisible(false)
		end
	end)()
	;(function(...)
		local var_21_0 = 0

		for iter_21_0, iter_21_1 in pairs(arg_16_0.signstats) do
			if iter_21_1 then
				var_21_0 = iter_21_0
			end
		end

		if arg_16_0.signstats[arg_16_0.curIndex] then
			arg_16_0.getAwardBtn:loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_0)
			arg_16_0.getAwardLabel:setString(L_ACTIVITY_SIGN_FINISH)
		else
			arg_16_0.getAwardLabel:setString(L_ACTIVITY_SIGN_BTN)

			if var_21_0 + 1 ~= arg_16_0.curIndex then
				arg_16_0.getAwardBtn:loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_0)
			elseif time_check_manager:getCurTime() < global_get_time_by_date(arg_16_0.signdate[arg_16_0.curIndex] .. " 00:00:00") then
				arg_16_0.getAwardBtn:loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_0)
			else
				arg_16_0.getAwardBtn:loadTextures("public/button/public_button_orange_big.png", nil, "public/button/public_button_orange_big.png", var_0_0)
			end
		end
	end)()
	;(function(...)
		if global_get_time_by_date(arg_16_0.signdate[arg_16_0.curIndex] .. " 00:00:00") > time_check_manager:getCurTime() then
			arg_16_0.unlockSignTimeLabel:setVisible(true)
			arg_16_0.unlockSignTimeLabel:setString(arg_16_0.signdate[arg_16_0.curIndex] .. "可以签到")
		else
			arg_16_0.unlockSignTimeLabel:setVisible(false)
		end
	end)()
	;(function(...)
		arg_16_0.dayLabel:setString(arg_16_0.curIndex)
	end)()
	;(function(...)
		for iter_24_0, iter_24_1 in pairs(arg_16_0.dayPonts) do
			if iter_24_0 == arg_16_0.curIndex then
				iter_24_1:loadTexture("ActivityJpCbSignLayer/point_on.png", var_0_0)
			else
				iter_24_1:loadTexture("ActivityJpCbSignLayer/point.png", var_0_0)
			end
		end
	end)()
end

function ActivityJpCbSignLayer:initBg(arg_25_1)
	local var_25_0 = ccui.Layout:create()

	var_25_0:setTouchEnabled(true)
	var_25_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_25_0:setAnchorPoint(cc.p(0, 0))
	var_25_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_25_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_25_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_25_0:setOpacity(0)
	self:addChild(var_25_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_26_0)
		self:addChild(arg_26_0, -2)
		arg_26_0:setPositionY(arg_26_0:getPositionY() - GameDisplay.fix_y)

		local var_26_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_26_0:setAnchorPoint(cc.p(0, 0))
		var_26_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_26_0, -1)
		self:init(arg_25_1)
		var_25_0:setOpacity(102)
		var_25_0:setTouchEnabled(false)
	end)
end

function ActivityJpCbSignLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback(0)
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end

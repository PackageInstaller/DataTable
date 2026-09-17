PopBirthdayPartyLayer = class("PopBirthdayPartyLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = 1
local var_0_1 = config._DEBUG and 0 or 1
local network = require("network.network")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local recharge_data = require("data.recharge_data")
local birthday_party_data = require("data.birthday_party_data")
local time_check_manager = require("controller.time_check_manager")
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local recharge_manager = require("controller.recharge_manager")
local spinecache_manager = require("controller.spinecache_manager")
local birthday_party_manager = require("controller.birthday_party_manager")
local audio_manager = require("controller.audio_manager")
local shop_manager = require("controller.shop_manager")
local discount_manager = require("controller.discount_manager")
local var_0_17 = require("controller.time_check_manager")
local activity_entrance_data = require("data.activity_entrance_data")
local var_0_24 = 200
local var_0_25 = 9
local var_0_26 = 3
local var_0_27 = 94
local var_0_28 = -30

function PopBirthdayPartyLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopBirthdayPartyLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopBirthdayPartyLayer:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer)
	self.rootLayer:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)

	local var_3_0 = ccui.ImageView:create("mainScenebg/bg_birthday_party.png")

	var_3_0:setName("bg")
	var_3_0:setAnchorPoint(cc.p(0, 0))
	self.rootLayer:addChild(var_3_0)

	if arg_3_1 then
		self._startIndex = arg_3_1.startIndex or 1
	end

	self.pageViewNode = ccui.Layout:create()

	self.pageViewNode:setTouchEnabled(true)
	self.pageViewNode:setAnchorPoint(cc.p(0.5, 0.5))
	self.pageViewNode:setPosition(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2)
	self.pageViewNode:setContentSize(cc.size(640 * var_0_0, 1136 * var_0_0))
	self.pageViewNode:setName("pageView")
	self.rootLayer:addChild(self.pageViewNode)

	self.titleNode = ccui.ImageView:create("PopBirthdayPartyLayer/title.png", var_0_1)

	self.titleNode:setName("title")
	self.titleNode:setPosition(cc.p(320, 1000))
	self.rootLayer:addChild(self.titleNode, 999)

	local var_3_1 = ccui.Layout:create()

	var_3_1:setContentSize(cc.size(640, 110))
	var_3_1:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(var_3_1, 999)
	var_3_1:setTouchEnabled(true)
	var_3_1:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)

	local var_3_2 = ccui.Layout:create()

	var_3_2:setContentSize(cc.size(640, 150))
	var_3_2:setAnchorPoint(cc.p(0, 0))
	var_3_2:setPosition(cc.p(0, GameDisplay.height - GameDisplay.fix_y - 150))
	self:addChild(var_3_2, 999)
	var_3_2:setTouchEnabled(true)
	var_3_2:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)

	local var_3_3 = ccui.Text:create("点击关闭", FONT_DES, 14)

	var_3_3:setName("tishi")
	var_3_3:setPosition(cc.p(320, 50))
	self.rootLayer:addChild(var_3_3, 999)

	local var_3_4 = ccui.Button:create("public/panelbg/bg_bg.png", nil, "public/panelbg/bg_bg.png", var_0_1)

	var_3_4:setScale9Enabled(true)
	var_3_4:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_3_4:setOpacity(0)
	var_3_4:setAnchorPoint(cc.p(0, 0))
	var_3_4:setSwallowTouches(false)
	self.rootLayer:addChild(var_3_4)
	var_3_4:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 == ccui.TouchEventType.began then
			arg_7_0.lastPos = arg_7_0:getTouchBeganPosition()
		elseif arg_7_1 == ccui.TouchEventType.moved then
			local var_7_0 = arg_7_0:getTouchMovePosition()

			self:updatePositionX(var_7_0.x - arg_7_0.lastPos.x)

			arg_7_0.lastPos = var_7_0
		elseif arg_7_1 == ccui.TouchEventType.ended then
			local var_7_1 = arg_7_0:getTouchEndPosition().x - arg_7_0:getTouchBeganPosition().x

			if math.abs(var_7_1) > var_0_24 then
				self.curPage = var_7_1 > 0 and self:getCompetitionId(-1) or self:getCompetitionId(1)

				self:initListViewPanel()
			else
				self:recoveryPages()
			end

			arg_7_0.lastPos = nil
		elseif arg_7_1 == ccui.TouchEventType.canceled then
			arg_7_0.lastPos = nil

			self:recoveryPages()
		end
	end)

	self.pagelistNode = ccui.ImageView:create("PopBirthdayPartyLayer/scroll_bg.png", var_0_1)

	self.pagelistNode:setName("pageBg")
	self.pagelistNode:setPosition(cc.p(320, 160))
	self.pagelistNode:setTouchEnabled(true)
	self.rootLayer:addChild(self.pagelistNode, 4)

	local var_3_5 = ccui.ImageView:create("PopBirthdayPartyLayer/scroll_left.png", var_0_1)

	var_3_5:setPosition(cc.p(295 + var_0_28, 150))
	var_3_5:runAction(self:getBtnActionObj(1))
	var_3_5:setName("imageLeft")
	var_3_5:setTouchEnabled(true)
	var_3_5:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.curPage = self:getCompetitionId(-1)

		self:initListViewPanel()
	end)
	self.rootLayer:addChild(var_3_5, 4)

	local var_3_6 = ccui.ImageView:create("PopBirthdayPartyLayer/scroll_right.png", var_0_1)

	var_3_6:setPosition(cc.p(425 + var_0_28, 150))
	var_3_6:runAction(self:getBtnActionObj(-1))
	var_3_6:setName("imageRight")
	var_3_6:setTouchEnabled(true)
	var_3_6:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.curPage = self:getCompetitionId(1)

		self:initListViewPanel()
	end)
	self.rootLayer:addChild(var_3_6, 4)
	self:initUInfo()
	self:initListViewPanel()
	self:fullscreen()
	self:registerScriptHandler(function(arg_10_0)
		if arg_10_0 == "exit" then
			-- block empty
		end
	end)
end

function PopBirthdayPartyLayer:initUInfo()
	self.startIndex = self._startIndex
	self.dataList = birthday_party_manager:getBirthdayPartyInfo()

	table.sort(self.dataList, function(arg_12_0, arg_12_1)
		if arg_12_0.monthid == arg_12_1.monthid then
			return arg_12_0.id < arg_12_1.id
		else
			return arg_12_0.monthid < arg_12_1.monthid
		end
	end)

	if self.startIndex == nil then
		self.startIndex = birthday_party_manager:getLastNearBirthdayIndex()
	end

	self.curPage = self.startIndex
end

function PopBirthdayPartyLayer:recoveryPages()
	for iter_13_0 = 1, var_0_26 do
		local var_13_0 = self.pageViewNode:getChildByName("pageview" .. iter_13_0)

		if var_13_0 then
			var_13_0:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p((-960 + 640 * iter_13_0) * var_0_0, 1136 * var_0_0 / 2))))
		end
	end

	self:updatePageSpot()
end

function PopBirthdayPartyLayer.getBtnActionObj(arg_14_0, arg_14_1)
	return (cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.2 * 0.5, cc.p(16 * arg_14_1 * 0.5, 0)), cc.MoveBy:create(0.3 * 0.5, cc.p(-24 * arg_14_1 * 0.5, 0)), cc.MoveBy:create(0.1 * 0.5, cc.p(8 * arg_14_1 * 0.5, 0)), cc.DelayTime:create(0.8 * 0.5))))
end

function PopBirthdayPartyLayer:getCompetitionId(arg_15_1)
	local var_15_0 = self.curPage + arg_15_1

	if #self.dataList < self.curPage + arg_15_1 then
		var_15_0 = var_15_0 - #self.dataList
	elseif var_15_0 < 1 then
		var_15_0 = var_15_0 + #self.dataList
	end

	self.lastdirection = arg_15_1 > 0 and 1 or 0

	return var_15_0
end

function PopBirthdayPartyLayer:initListViewPanel()
	local var_16_0 = math.min(#self.dataList, var_0_25)
	local var_16_1 = math.floor((var_16_0 + 1) / 2)

	for iter_16_0 = 1, var_16_0 do
		local var_16_2 = self.curPage + (iter_16_0 - var_16_1)

		if self.curPage + (iter_16_0 - var_16_1) <= 0 then
			var_16_2 = #self.dataList + var_16_2
		elseif #self.dataList < var_16_2 then
			var_16_2 = var_16_2 - #self.dataList
		end

		local var_16_3 = string.format("roleimage/role/fight/%s.png", model_data[self.dataList[var_16_2].modelId].role_image or "20104")
		local var_16_4 = self.pagelistNode:getChildByName("page" .. iter_16_0)

		if var_16_4 == nil then
			var_16_4 = ccui.Layout:create()

			var_16_4:addChild((ccui.ImageView:create("PopBirthdayPartyLayer/item_di.png", var_0_1)))

			local var_16_5 = ccui.Button:create(var_16_3, nil, var_16_3)

			var_16_5:setScale(0.6)
			var_16_5:setName("item_icon")
			var_16_5:setSwallowTouches(false)
			var_16_4:addChild(var_16_5)

			var_16_5.index = iter_16_0 - var_16_1

			var_16_5:addTouchEventListener(function(arg_17_0, arg_17_1)
				if arg_17_1 ~= ccui.TouchEventType.ended then
					return
				end

				local var_17_0 = arg_17_0.index

				if arg_17_0.index == 0 then
					return
				end

				self.curPage = self:getCompetitionId(var_17_0)

				self:initListViewPanel()
			end)
			var_16_4:addChild((ccui.ImageView:create("PopBirthdayPartyLayer/item_kuang.png", var_0_1)))
			var_16_4:setPosition(cc.p(-50 + (iter_16_0 - 1) * 100, 68))
			var_16_4:setName("page" .. iter_16_0)
			self.pagelistNode:addChild(var_16_4)
		else
			var_16_4:getChildByName("item_icon"):loadTextures(var_16_3, nil, var_16_3)
		end

		if iter_16_0 < var_16_1 then
			var_16_4:setPositionX(-var_0_27 / 2 + (iter_16_0 - 1) * var_0_27 + var_0_28)
		elseif iter_16_0 == var_16_1 then
			var_16_4:setPositionX(-var_0_27 / 2 + (iter_16_0 - 1) * var_0_27 + 30 + var_0_28)
		else
			var_16_4:setPositionX(-var_0_27 / 2 + (iter_16_0 - 1) * var_0_27 + 30 + 30 + var_0_28)
		end
	end

	self:initPageViewPanel(self.curPage)
end

function PopBirthdayPartyLayer:initPageViewPanel(arg_18_1)
	local var_18_0 = #self.dataList
	local var_18_1 = math.floor((var_0_26 + 1) / 2)
	local var_18_2 = self.pageViewNode:getChildrenCount()

	if var_18_2 > 0 and self.lastdirection == 0 then
		local var_18_3 = self.pageViewNode:getChildByName("pageview" .. var_0_26)

		if var_18_3 then
			var_18_3:setName("pageview1_temp")
			var_18_3:setPosition(cc.p(-320 * var_0_0, 1136 * var_0_0 / 2))
		end

		for iter_18_0 = var_0_26 - 1, 1, -1 do
			local var_18_4 = self.pageViewNode:getChildByName("pageview" .. iter_18_0)

			if var_18_4 then
				var_18_4:setName("pageview" .. iter_18_0 + 1)
			end
		end

		local var_18_5 = self.pageViewNode:getChildByName("pageview1_temp")

		if var_18_5 then
			var_18_5:setName("pageview1")
		end
	elseif var_18_2 > 0 and self.lastdirection == 1 then
		local var_18_6 = self.pageViewNode:getChildByName("pageview1")

		if var_18_6 then
			var_18_6:setName("pageview" .. var_0_26 .. "temp")
			var_18_6:setPosition(cc.p((-960 + 640 * var_0_26) * var_0_0, 1136 * var_0_0 / 2))
		end

		for iter_18_1 = 2, var_0_26 do
			local var_18_7 = self.pageViewNode:getChildByName("pageview" .. iter_18_1)

			if var_18_7 then
				var_18_7:setName("pageview" .. iter_18_1 - 1)
			end
		end

		local var_18_8 = self.pageViewNode:getChildByName("pageview" .. var_0_26 .. "temp")

		if var_18_8 then
			var_18_8:setName("pageview" .. var_0_26)
		end
	end

	for iter_18_2 = 1, var_0_26 do
		local var_18_9 = arg_18_1 + (iter_18_2 - var_18_1)

		if arg_18_1 + (iter_18_2 - var_18_1) <= 0 then
			var_18_9 = var_18_0 + var_18_9
		elseif var_18_0 < var_18_9 then
			var_18_9 = var_18_9 - var_18_0
		end

		local var_18_10 = not not (iter_18_2 ~= var_18_1 and global_canshow_live2d(self.dataList[var_18_9].modelId))
		local var_18_11 = self.pageViewNode:getChildByName("pageview" .. iter_18_2)

		if var_18_11 == nil then
			var_18_11 = self:createSelectLayout(var_18_9, var_18_10)

			var_18_11:setName("pageview" .. iter_18_2)
			var_18_11:setLocalZOrder(100 - math.abs(var_18_1 - iter_18_2))
			var_18_11:setPosition(cc.p((-960 + 640 * iter_18_2) * var_0_0, 1136 * var_0_0 / 2))
			self.pageViewNode:addChild(var_18_11)
		else
			self:updateSelectLayout(var_18_11, var_18_9, var_18_10)
			var_18_11:setLocalZOrder(100 - math.abs(var_18_1 - iter_18_2))
			var_18_11:stopAllActions()
			var_18_11:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p((-960 + 640 * iter_18_2) * var_0_0, 1136 * var_0_0 / 2))))
		end
	end
end

function PopBirthdayPartyLayer:updatePageSpot()
	local var_19_0 = math.min(#self.dataList, var_0_25)
	local var_19_1 = math.floor((var_19_0 + 1) / 2)

	for iter_19_0 = 1, var_19_0 do
		local var_19_2 = self.curPage + (iter_19_0 - var_19_1)

		if self.curPage + (iter_19_0 - var_19_1) <= 0 then
			var_19_2 = #self.dataList + var_19_2
		elseif #self.dataList < var_19_2 then
			var_19_2 = var_19_2 - #self.dataList
		end

		local var_19_3 = string.format("roleimage/role/fight/%s.png", model_data[self.dataList[var_19_2].modelId].role_image or "20104")
		local var_19_4 = self.pagelistNode:getChildByName("page" .. iter_19_0)

		var_19_4:getChildByName("item_icon"):loadTextures(var_19_3, nil, var_19_3)

		if iter_19_0 < var_19_1 then
			var_19_4:setPositionX(-var_0_27 / 2 + (iter_19_0 - 1) * var_0_27 + var_0_28)
		elseif iter_19_0 == var_19_1 then
			var_19_4:setPositionX(-var_0_27 / 2 + (iter_19_0 - 1) * var_0_27 + 30 + var_0_28)
		else
			var_19_4:setPositionX(-var_0_27 / 2 + (iter_19_0 - 1) * var_0_27 + 30 + 30 + var_0_28)
		end
	end
end

function PopBirthdayPartyLayer:updatePositionX(arg_20_1)
	for iter_20_0, iter_20_1 in pairs((self.pagelistNode:getChildren())) do
		iter_20_1:setPositionX(iter_20_1:getPositionX() + arg_20_1 * 0.286)
	end

	for iter_20_2, iter_20_3 in pairs((self.pageViewNode:getChildren())) do
		iter_20_3:setPositionX(iter_20_3:getPositionX() + arg_20_1)
	end
end

function PopBirthdayPartyLayer.updateSkinBtn(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1:getChildByName("btn_info")

	var_21_0:loadTextures("PopBirthdayPartyLayer/btn_bought.png", nil, "PopBirthdayPartyLayer/btn_bought.png", var_0_1)

	var_21_0.curItemData = arg_21_2
end

function PopBirthdayPartyLayer:createSelectLayout(arg_22_1, arg_22_2)
	local var_22_1 = ccui.Layout:create()

	var_22_1:setContentSize(cc.size(640 * var_0_0, 1136 * var_0_0))
	var_22_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_22_1:setTouchEnabled(true)
	var_22_1:setClippingEnabled(true)
	var_22_1:addChild((self:showGirlPanel(arg_22_1, arg_22_2)))

	local var_22_2 = ccui.Button:create("PopBirthdayPartyLayer/btn_skin.png", nil, "PopBirthdayPartyLayer/btn_skin.png", var_0_1)

	var_22_2:setAnchorPoint(cc.p(0.5, 0))
	var_22_2:setPosition(cc.p(320, 235 - GameDisplay.fix_y))
	var_22_2:setName("btn_info")

	var_22_2.curItemData = self.dataList[arg_22_1]

	var_22_1:addChild(var_22_2, 20)
	var_22_2:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_23_0.curItemData.shop1iscanbuy == false then
			global_ShowBlockWords("已达购买上限")

			return
		end

		local var_23_0 = arg_23_0.curItemData
		local var_23_1 = birthday_party_manager:getShopInfoById(arg_23_0.curItemData.shopId1)

		if var_23_1 == nil then
			print(string.format("marketlist无此商品，请检查，id为%d", var_23_0.shopId1))
		end

		self:shopPop(var_23_1, birthday_party_manager:getShopType(), "giftitem", function()
			var_23_0.shop1iscanbuy = false

			self:updateSkinBtn(var_22_1, var_23_0)
		end)
		AnalyticManager.click_birthday_skin()
	end)

	local var_22_3 = ccui.Button:create("PopBirthdayPartyLayer/btn_twist.png", nil, "PopBirthdayPartyLayer/btn_twist.png", var_0_1)

	var_22_3:setAnchorPoint(cc.p(0.5, 0))
	var_22_3:setPosition(cc.p(320, 235 - GameDisplay.fix_y))
	var_22_3:setName("btn_twist")

	var_22_3.curItemData = self.dataList[arg_22_1]

	var_22_1:addChild(var_22_3, 20)
	var_22_3:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_25_0 = arg_25_0.curItemData

		if arg_25_0.curItemData.eggstatus ~= 2 then
			global_ShowBlockWords("开启时间" .. var_25_0.unlocklevel .. "")

			return
		end

		LayerManager:switchShowLayer("TwisteggLayer", {
			initTwisType = tonumber(var_25_0.twiggestEggId) % 100000
		})
		AnalyticManager.click_birthday_expansion()
	end)
	self:updateBtnStatus(var_22_1, arg_22_1)

	local var_22_4 = ccui.ImageView:create("PopBirthdayPartyLayer/bg_name.png", var_0_1)

	var_22_4:setName("name")
	var_22_4:setPosition(cc.p(80 + self.dataList[arg_22_1].porpertyoffset.x, 825 + self.dataList[arg_22_1].porpertyoffset.y))
	var_22_1:addChild(var_22_4, 20)

	local var_22_5 = ccui.Text:create(self.dataList[arg_22_1].name, FONT_NAME, 23)

	var_22_5:setName("text")
	var_22_5:setAnchorPoint(cc.p(0.5, 0.5))
	var_22_5:setPosition(cc.p(64, 15))
	var_22_4:addChild(var_22_5)

	local var_22_6 = ccui.ImageView:create("PopBirthdayPartyLayer/bg_name.png", var_0_1)

	var_22_6:setName("birth")
	var_22_6:setPosition(cc.p(80 + self.dataList[arg_22_1].porpertyoffset.x, 775 + self.dataList[arg_22_1].porpertyoffset.y))
	var_22_1:addChild(var_22_6, 20)

	local var_22_7 = ccui.Text:create(self.dataList[arg_22_1].birth, FONT_NAME, 23)

	var_22_7:setName("text")
	var_22_7:setAnchorPoint(cc.p(0.5, 0.5))
	var_22_7:setPosition(cc.p(64, 15))
	var_22_6:addChild(var_22_7)

	local var_22_8 = ccui.ImageView:create("PopBirthdayPartyLayer/discount.png", var_0_1)

	var_22_8:setName("discount")
	var_22_8:setPosition(cc.p(550, 735))
	var_22_1:addChild(var_22_8, 21)

	return var_22_1
end

function PopBirthdayPartyLayer:updateBtnStatus(arg_26_1, arg_26_2)
	local var_26_0 = self.dataList[arg_26_2]
	local var_26_1 = arg_26_1:getChildByName("btn_info")
	local var_26_2 = arg_26_1:getChildByName("btn_twist")
	local var_26_4 = {
		{
			320,
			320
		},
		{
			200,
			440
		}
	}
	local var_26_6 = 0 + 1

	var_26_1:loadTextures(self.dataList[arg_26_2].shop1iscanbuy == true and "PopBirthdayPartyLayer/btn_skin.png" or "PopBirthdayPartyLayer/btn_bought.png", nil, self.dataList[arg_26_2].shop1iscanbuy == true and "PopBirthdayPartyLayer/btn_skin.png" or "PopBirthdayPartyLayer/btn_bought.png", var_0_1)

	if var_26_0.eggstatus == 2 then
		var_26_6 = var_26_6 + 1

		var_26_2:setVisible(true)
	else
		var_26_2:setVisible(false)
	end

	local var_26_7 = math.max(1, var_26_6)

	var_26_1:setPositionX(var_26_4[var_26_7][1])
	var_26_2:setPositionX(var_26_4[var_26_7][2])

	var_26_1.curItemData = var_26_0
	var_26_2.curItemData = var_26_0
end

function PopBirthdayPartyLayer:updateSelectLayout(arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = arg_27_1:getChildByName("show_girl")

	print("======================")
	print("======================")
	print("======================")
	print("======================")
	print(string.format("立绘名称" .. self.dataList[arg_27_2].name))
	print(string.format("偏移x:%d,y:%d", self.dataList[arg_27_2].spinePos.x, self.dataList[arg_27_2].spinePos.y))
	print(string.format("尺寸x:%d", self.dataList[arg_27_2].spineScale))

	local var_27_2 = arg_27_1:getChildByName("name")
	local var_27_3 = arg_27_1:getChildByName("birth")

	var_27_2:getChildByName("text"):setString(self.dataList[arg_27_2].name)
	var_27_2:setPosition(cc.p(80 + self.dataList[arg_27_2].porpertyoffset.x, 825 + self.dataList[arg_27_2].porpertyoffset.y))
	var_27_3:getChildByName("text"):setString(self.dataList[arg_27_2].birth)
	var_27_3:setPosition(cc.p(80 + self.dataList[arg_27_2].porpertyoffset.x, 775 + self.dataList[arg_27_2].porpertyoffset.y))
	arg_27_1:getChildByName("discount"):setVisible(self.dataList[arg_27_2].ishavediscount)
	self:updateBtnStatus(arg_27_1, arg_27_2)

	if var_27_0 then
		var_27_0:removeFromParent()
	end

	arg_27_1:addChild((self:showGirlPanel(arg_27_2, arg_27_3)))
end

function PopBirthdayPartyLayer:exit()
	if self.rootLayer then
		self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
			LayerManager:removePopLayer(self.__queueindex)
		end)))
	end
end

function PopBirthdayPartyLayer:initBg(arg_30_1)
	local var_30_0 = ccui.Layout:create()

	var_30_0:setTouchEnabled(true)
	var_30_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_30_0:setAnchorPoint(cc.p(0, 0))
	var_30_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_30_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_30_0:setOpacity(0)
	self:addChild(var_30_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_31_0)
		self:addChild(arg_31_0, -2)
		arg_31_0:setPositionY(arg_31_0:getPositionY() - GameDisplay.fix_y)

		local var_31_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_31_0:setAnchorPoint(cc.p(0, 0))
		var_31_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_31_0, -1)
		birthday_party_manager:init(function()
			self:init(arg_30_1)
		end)
		var_30_0:setOpacity(102)
		var_30_0:setTouchEnabled(false)
	end)
end

function PopBirthdayPartyLayer:fullscreen()
	for iter_33_0, iter_33_1 in pairs({
		"pageBg",
		"imageLeft",
		"imageRight",
		"pageView",
		"tishi",
		"bg"
	}) do
		local var_33_0 = self.rootLayer:getChildByName(iter_33_1)

		if var_33_0 ~= nil then
			var_33_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_33_0:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

			var_33_0:setPositionY(var_33_0.full_posY)
		end
	end

	for iter_33_2, iter_33_3 in pairs({
		"title"
	}) do
		local var_33_1 = self.rootLayer:getChildByName(iter_33_3)

		if var_33_1 ~= nil then
			var_33_1.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - var_33_1:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

			var_33_1:setPositionY(var_33_1.full_posY)
		end
	end

	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
end

function PopBirthdayPartyLayer.shopPop(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	if arg_34_1 == nil then
		return
	end

	local var_34_0 = 0
	local var_34_2 = {
		function()
			return playermodel.gold
		end,
		[0] = function()
			return playermodel.diamond
		end,
		function()
			return playermodel.honor
		end,
		function()
			return playermodel.explorecoin
		end,
		[100] = function()
			return 0
		end
	}

	setmetatable(var_34_2, {
		__index = function(arg_40_0, arg_40_1)
			return function()
				return item_manager:getItemNumber(arg_40_1)
			end
		end
	})

	local var_34_3 = {
		"public/currency/UI_battleEnd_gold.png",
		[var_34_0] = "public/currency/UI_battleEnd_diamond.png",
		"public/currency/arenascene_dot_1.png",
		"public/currency/explorecoin.png",
		[1500001] = "public/currency/1500001_1.png",
		[100] = "public/currency/rmb_white.png"
	}

	setmetatable(var_34_3, {
		__index = function(arg_42_0, arg_42_1)
			return "public/currency/" .. item_data[arg_42_1].image_id .. ".png"
		end
	})

	local var_34_4 = {
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "HandOfMidasLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_GOLD
			})
		end,
		[var_34_0] = function()
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		end,
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ArenaLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
			})
		end,
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ExploreMapLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_EXPLORECOIN
			})
		end,
		[GIFT_TICKET] = function()
			LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
				targetlayer = "PopSupermarketLayer",
				callback = updateCoinLabel
			})
		end
	}

	setmetatable(var_34_4, {
		__index = function(arg_48_0, arg_48_1)
			return function()
				global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_48_1].name))
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end
	})

	local var_34_5 = {}

	local function var_34_6(arg_50_0)
		local var_50_0 = var_34_5

		if arg_50_0.result == 1 then
			if not arg_50_0.selectCoupon then
				shop_manager:shop_buy(var_34_5.shoptype, var_34_5.shopitem.shopid, function(arg_51_0)
					if arg_51_0 == 1 then
						arg_34_1.have_bought = arg_34_1.have_bought + var_50_0.curbuyTime
						arg_34_1.sell_out = arg_34_1.buy_limit and arg_34_1.buy_limit <= arg_34_1.have_bought

						if var_50_0.shopitem.bag_item_type == kITEM_SKIN or var_50_0.shopitem.bag_item_type == kITEM_SKIN_GIFT then
							AnalyticManager.dorm_buy_dress_success({
								soulid = arg_34_0.soulid,
								itemid = var_50_0.shopitem.itemid
							})
						end

						if item_data[var_50_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_50_0.itemid), 1000)
						end

						if arg_34_4 then
							arg_34_4(arg_51_0)
						end

						if var_50_0.callback then
							var_50_0.callback()
						end
					elseif arg_51_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
						audio_manager:playeffectMusicTest("sound/invalid")
					elseif arg_51_0 == 3 then
						var_34_4[var_50_0.shopitem.currency]()
					end
				end, var_34_5.curbuyTime, function()
					LayerManager:removePopLayer()
				end, arg_34_3 == "barrageitem")
			else
				shop_manager:shop_buy_with_ticket(var_34_5.shoptype, var_34_5.shopitem.shopid, function(arg_53_0)
					if arg_53_0 == 1 then
						arg_34_1.have_bought = arg_34_1.have_bought + var_50_0.curbuyTime
						arg_34_1.sell_out = arg_34_1.buy_limit and arg_34_1.buy_limit <= arg_34_1.have_bought

						if var_50_0.shopitem.bag_item_type == kITEM_SKIN or var_50_0.shopitem.bag_item_type == kITEM_SKIN_GIFT then
							AnalyticManager.dorm_buy_dress_success({
								soulid = arg_34_0.soulid,
								itemid = var_50_0.shopitem.itemid
							})
						end

						if item_data[var_50_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_50_0.itemid), 1000)
						end

						if arg_34_4 then
							arg_34_4(arg_53_0)
						end

						if var_50_0.callback then
							var_50_0.callback()
						end
					elseif arg_53_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
						audio_manager:playeffectMusicTest("sound/invalid")
					elseif arg_53_0 == 3 then
						var_34_4[var_50_0.shopitem.currency]()
					end
				end, var_34_5.curbuyTime, function()
					LayerManager:removePopLayer()
				end, arg_50_0.selectCoupon, 1)
			end
		end
	end

	local function var_34_7(arg_55_0)
		if not arg_55_0.currency2 or discount_manager:getLastPriceByItem(arg_55_0.itemid, arg_55_0.currency2, arg_55_0.discount2) < arg_55_0.discount2 then
			return true
		end

		return false
	end

	local function var_34_8(arg_62_0)
		local var_62_0 = {}

		if arg_62_0.currency2 then
			var_62_0.currency2 = arg_62_0.currency2
			var_62_0.costIcon2 = var_34_3[arg_62_0.currency2]
			var_62_0.cost2 = arg_62_0.discount2 or arg_62_0.price2
			var_62_0.cost_old2 = arg_62_0.price2
			var_62_0.discount2 = arg_62_0.discount2
		end

		var_62_0.name = item_data[arg_62_0.itemtype].name
		var_62_0.itemid = arg_62_0.itemtype
		var_62_0.shopid = arg_62_0.shopid
		var_62_0.costIcon = var_34_3[arg_62_0.currency]
		var_62_0.currency = arg_62_0.currency
		var_62_0.isnewitem = arg_62_0.isnewitem
		var_62_0.discountfinish = arg_62_0.discountfinish
		var_62_0.cost = arg_62_0.discount or arg_62_0.price
		var_62_0.quality = item_data[arg_62_0.itemtype].equip_quality or 1
		var_62_0.cost_old = arg_62_0.price
		var_62_0.bag_item_type = item_data[arg_62_0.itemtype].bag_item_type
		var_62_0.item_attr = arg_62_0.item_attr
		var_62_0.finish_time = arg_62_0.finish_time
		var_62_0.discount = arg_62_0.discount
		var_62_0.buy_limit = arg_62_0.buy_limit or 1000000
		var_62_0.have_bought = arg_62_0.have_bought or 0
		var_62_0.sell_out = arg_62_0.buy_limit and arg_62_0.buy_limit <= arg_62_0.have_bought
		var_62_0.tag = arg_62_0.tag or 0
		var_62_0.pos = arg_62_0.pos
		var_62_0.purchaseid = arg_62_0.productid

		return var_62_0
	end

	if arg_34_1.currency == 100 then
		(function(arg_58_0)
			local var_58_0 = {
				itemid = arg_58_0.itemid,
				item_attr = arg_58_0.item_attr
			}
			local var_58_1 = {
				costtype = arg_58_0.costIcon
			}

			var_58_1.costnum = arg_58_0.discount or arg_58_0.cost
			var_58_0.slidecost = var_58_1

			function var_58_0:ShopSliderCallback(arg_59_1, arg_59_2)
				if arg_59_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_58_0.have_bought >= arg_58_0.buy_limit then
					global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
					audio_manager:playeffectMusicTest("sound/invalid")

					return
				end

				self:setTouchEnabled(false)
				shop_manager:shop_purchase(arg_58_0.shopid, arg_58_0.purchaseid, function(arg_60_0)
					if arg_60_0 == 1 then
						arg_34_1.have_bought = arg_34_1.have_bought + curbuyTime
						arg_34_1.sell_out = arg_34_1.buy_limit and arg_34_1.buy_limit <= arg_34_1.have_bought

						if arg_58_0.bag_item_type ~= kITEM_SKIN and arg_58_0.bag_item_type == kITEM_SKIN_GIFT then
							-- block empty
						end

						LayerManager:removePopLayer(arg_34_0.__queueindex)

						if item_data[var_58_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_58_0.itemid), 1000)
						end

						if arg_34_2 == 6 then
							for iter_60_0, iter_60_1 in pairs({
								{
									entityid = var_58_0.itemid
								}
							}) do
								network:rpc("use_gift_bag", {
									num = 1,
									entityid = iter_60_1.entityid
								}, function(arg_61_0)
									if arg_61_0.result == 1 then
										global_gain(arg_61_0)
										item_manager:deleteItem(iter_60_1.entityid, 1)
									else
										global_ShowBlockWords(L_MARKET_MSG.Gift_Bag_Lack)
									end
								end)
							end
						else
							LayerManager:pushInLayer("PopPurchaseResultLayer", {
								items = {
									{
										dropNum = 1,
										dropid = var_58_0.itemid,
										entityid = var_58_0.itemid
									}
								}
							})
						end

						if arg_59_2 then
							arg_59_2()
						end
					elseif arg_60_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Goods_Sended)
						audio_manager:playeffectMusicTest("sound/invalid")
					end
				end)
			end

			if arg_34_2 == 4 or arg_34_2 == 6 then
				arg_34_0:showBuyPop(var_58_0, nil, arg_34_3)
			else
				print("暂时没给非服装商城做人民币支付")
			end

			arg_58_0.isnewitem = false
		end)(var_34_8(arg_34_1))
	else
		(function(arg_56_0)
			local var_56_0 = {
				itemid = arg_56_0.itemid,
				item_attr = arg_56_0.item_attr
			}

			var_56_0.limitNum = arg_56_0.buy_limit and (arg_56_0.buy_limit - arg_56_0.have_bought >= SHOP_NORMAL_BUY_LIMIT_NUM and SHOP_NORMAL_BUY_LIMIT_NUM or arg_56_0.buy_limit - arg_56_0.have_bought) or SHOP_NORMAL_BUY_LIMIT_NUM

			local var_56_1

			if var_34_7(arg_56_0) then
				var_56_1 = math.floor(var_34_2[arg_56_0.currency]() / arg_56_0.cost)
				var_56_0.currency = arg_56_0.currency
			else
				var_56_1 = math.floor(var_34_2[arg_56_0.currency2]() / arg_56_0.cost2)
				var_56_0.currency = arg_56_0.currency2
			end

			if var_56_1 > var_56_0.limitNum then
				var_56_0.limitNum = var_56_0.limitNum or var_56_1
			end

			local var_56_2 = arg_34_0:getResidueTime(arg_56_0.finish_time)

			if var_56_2 ~= "-1" then
				var_56_0.limit_time = L_MARKET_MSG.Rest_Time .. var_56_2
			end

			var_56_0.slidecost = {}

			if var_34_7(arg_56_0) then
				var_56_0.slidecost.costtype = arg_56_0.costIcon
				var_56_0.slidecost.costnum = arg_56_0.discount or arg_56_0.cost
				var_56_0.slidecost.nowHave = var_34_2[arg_56_0.currency]()
				var_56_0.slidecost.cost_old = arg_56_0.cost_old or var_56_0.slidecost.costnum
			else
				var_56_0.slidecost.costtype = arg_56_0.costIcon2
				var_56_0.slidecost.costnum = arg_56_0.discount2 or arg_56_0.cost2
				var_56_0.slidecost.nowHave = var_34_2[arg_56_0.currency2]()
				var_56_0.slidecost.cost_old = arg_56_0.cost_old2 or var_56_0.slidecost.costnum
			end

			function var_56_0:ShopSliderCallback(arg_57_1, arg_57_2, arg_57_3)
				if arg_57_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not self:isBright() then
					return
				end

				local var_57_0 = self.nowNum or 1

				var_34_5 = {
					curbuyTime = var_57_0,
					shoptype = arg_34_2,
					itemid = var_56_0.itemid,
					callback = arg_57_2,
					shopitem = arg_56_0
				}

				if not arg_57_3 and var_34_7(arg_56_0) and arg_56_0.cost > var_34_2[arg_56_0.currency]() then
					LayerManager:removePopLayer()
					var_34_4[arg_56_0.currency]()

					return
				end

				self:setTouchEnabled(false)
				var_34_6({
					result = 1,
					selectCoupon = arg_57_3
				})
			end

			var_56_0.hideGainButton = true

			if arg_56_0.have_bought and arg_56_0.buy_limit then
				var_56_0.limit_buy_num = arg_56_0.buy_limit - arg_56_0.have_bought
				var_56_0.have_bought_num = arg_56_0.have_bought
			end

			arg_34_0:showBuyPop(var_56_0, arg_34_2, arg_34_3)

			arg_56_0.isnewitem = false
		end)(var_34_8(arg_34_1))
	end
end

function PopBirthdayPartyLayer.getCurMonth(arg_63_0)
	return os.date("*t", math.floor((time_check_manager:getCurTime()))).month
end

function PopBirthdayPartyLayer.getResidueTime(arg_64_0, arg_64_1)
	if not arg_64_1 then
		return "-1"
	end

	local var_64_5 = global_get_time_by_date(arg_64_1) - playermodel.onlineTime
	local var_64_6 = math.floor(var_64_5 / 24 / 3600)
	local var_64_7 = math.floor((var_64_5 - var_64_6 * 24 * 3600) / 3600)
	local var_64_8 = math.floor((var_64_5 - var_64_6 * 24 * 3600 - var_64_7 * 3600) / 60)

	return var_64_6 ~= 0 and string.format(L_TIME_TEXT[1], var_64_6, var_64_7) or var_64_7 ~= 0 and string.format(L_TIME_TEXT[2], var_64_7, var_64_8) or string.format(L_TIME_TEXT[3], var_64_8)
end

function PopBirthdayPartyLayer.showBuyPop(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
	arg_65_1.couponList = discount_manager:getCanUseCoupin(arg_65_1.itemid, arg_65_1.currency, arg_65_1.costnum or arg_65_1.slidecost.costnum, arg_65_2)

	if not arg_65_2 then
		LayerManager:pushInLayer("PopGoodsLayer", arg_65_1)
	elseif arg_65_3 == "shopitem" then
		LayerManager:pushInLayer("PopGoodsLayer", arg_65_1)
	elseif arg_65_3 == "giftitem" then
		if arg_65_1.couponList and next(arg_65_1.couponList) then
			LayerManager:pushInLayer("PopGoodsLayer", arg_65_1)
		else
			arg_65_1.rootpos = 50

			LayerManager:pushInLayer("PopSkinPackage", arg_65_1)
		end
	elseif arg_65_3 == "furnitureItem" then
		-- block empty
	elseif arg_65_3 == "barrageitem" then
		LayerManager:pushInLayer("PopGoodsLayer", arg_65_1)
	end
end

function PopBirthdayPartyLayer:showGirlPanel(arg_66_1, arg_66_2)
	local var_66_0 = require("view.Layer.ShowGirlLayer"):create(self.dataList[arg_66_1].modelId, 3, arg_66_2)

	var_66_0:setName("show_girl")
	var_66_0:resetCurTalkConfig(self.dataList[arg_66_1].modelId)
	var_66_0:setLive2DPlayStayEnabled(true)

	local var_66_1 = 1

	if model_data[self.dataList[arg_66_1].modelId].is_own_full_screen_background == 1 then
		var_66_1 = 2
	end

	if not model_data[self.dataList[arg_66_1].modelId].backgroundid_main then
		-- block empty
	end

	local var_66_3

	if var_66_3 then
		if not var_66_0:getChildByName("backGroundLayer") then
			local var_66_4 = BackGroundLayer:create(var_66_3, var_66_1, arg_66_2)

			var_66_4:setName("backGroundLayer")
			var_66_0:addChild(var_66_4, 1)
		end

		var_66_0:getChildByName("backGroundLayer"):update(var_66_3, var_66_1)
	end

	var_66_0:setScale(self.dataList[arg_66_1].spineScale)
	var_66_0:setAnchorPoint(cc.p(0, 0))
	var_66_0:setPosition(cc.p(self.dataList[arg_66_1].spinePos.x, self.dataList[arg_66_1].spinePos.y + GameDisplay.fix_y))

	return var_66_0
end

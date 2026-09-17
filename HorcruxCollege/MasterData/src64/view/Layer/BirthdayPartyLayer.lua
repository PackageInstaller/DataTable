BirthdayPartyLayer = class("BirthdayPartyLayer", function()
	return cc.Layer:create()
end)

local var_0_2 = 10
local var_0_3 = 11
local item_data = require("data.item_data")
local model_data = require("data.model_data")

require("view.Sprite.BottomBtnList")
require("view.Sprite.MovingView")
require("view.Sprite.ConfirmDialogSprite")

local l2utils = require("controller.l2utils")
local birthday_party_manager = require("controller.birthday_party_manager")
local barrage_manager = require("controller.barrage_manager")
local item_manager = require("controller.item_manager")
local discount_manager = require("controller.discount_manager")
local playermodel = require("model.playermodel")
local PageList = require("view.Sprite.PageList")
local audio_manager = require("controller.audio_manager")
local shop_manager = require("controller.shop_manager")
local var_0_15 = config._DEBUG and 0 or 1

function BirthdayPartyLayer:getExitParam()
	return cloneconf(self.initconfig)
end

function BirthdayPartyLayer.create(arg_3_0, ...)
	local var_3_0 = BirthdayPartyLayer.new()

	var_3_0:onLoad(...)

	return var_3_0
end

function BirthdayPartyLayer:fullscreen()
	self.root:setPosition(cc.p(0, -GameDisplay.fix_y))

	self.btn_back.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.btn_back:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.btn_back:setPositionY(self.btn_back.full_posY)

	self.titleNode.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self.titleNode:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.titleNode:setPositionY(self.titleNode.full_posY)

	self.btn_back.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.btn_back:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.btn_back:setPositionY(self.btn_back.full_posY)

	self.btn_buy_skin.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.btn_buy_skin:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.btn_buy_skin:setPositionY(self.btn_buy_skin.full_posY)

	self.btn_buy_furniture.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.btn_buy_furniture:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.btn_buy_furniture:setPositionY(self.btn_buy_furniture.full_posY)

	self.btn_buy_expansion.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.btn_buy_expansion:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.btn_buy_expansion:setPositionY(self.btn_buy_expansion.full_posY)

	self.btn_buy_barrage.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.btn_buy_barrage:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.btn_buy_barrage:setPositionY(self.btn_buy_barrage.full_posY)

	self.btn_cake.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self.btn_cake:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.btn_cake:setPositionY(self.btn_cake.full_posY)

	self.cakeTipNode.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self.cakeTipNode:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.cakeTipNode:setPositionY(self.cakeTipNode.full_posY)
end

function BirthdayPartyLayer:onLoad(arg_5_1)
	self.initconfig = arg_5_1 or {}
	self.scheduler = cc.Director:getInstance():getScheduler()
	self.root = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "BirthdayPartyLayer.json" or "BirthdayPartyLayer.ExportJson")

	self:addChild(self.root)
	self:initInfo()
	self:initUINode()
	barrage_manager:registerRef(self)
	birthday_party_manager:init(function()
		self:initPageView()
	end)
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			if self.timeScheduler ~= nil then
				self.scheduler:unscheduleScriptEntry(self.timeScheduler)

				self.timeScheduler = nil
			end

			if self.bondScheduler ~= nil then
				self.scheduler:unscheduleScriptEntry(self.bondScheduler)

				self.bondScheduler = nil
			end

			barrage_manager:unregisterRef()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("onRegisterBarrage")))
		end
	end)
	self:fullscreen()
end

function BirthdayPartyLayer.playBreathAnimation(arg_8_0, arg_8_1)
	if arg_8_1 == nil then
		return
	end

	arg_8_1:stopAllActions()
	arg_8_1:runAction((cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(0.5), cc.FadeIn:create(0.5)))))
end

function BirthdayPartyLayer:initUINode()
	self.girlPanelNode = self.root:getChildByName("girl")
	self.titleNode = self.root:getChildByName("title")

	self.titleNode:setTouchEnabled(true)
	self.titleNode:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "birthdayparty"
		})
	end)

	self.btn_back = self.root:getChildByName("btn_return")

	self.btn_back:setLocalZOrder(999)

	self.btn_buy_skin = self.root:getChildByName("btn_buy_skin")
	self.btn_buy_furniture = self.root:getChildByName("btn_buy_furniture")
	self.btn_buy_expansion = self.root:getChildByName("btn_buy_expansion")
	self.btn_buy_barrage = self.root:getChildByName("btn_buy_barrage")
	self.btn_switch_left = self.root:getChildByName("btn_switch_left")
	self.btn_switch_right = self.root:getChildByName("btn_switch_right")

	self:playBreathAnimation(self.btn_switch_left)
	self:playBreathAnimation(self.btn_switch_right)

	self.timeNode = self.titleNode:getChildByName("time")
	self.tipsNode = self.titleNode:getChildByName("tips")

	self.tipsNode:setTouchEnabled(true)
	self.tipsNode:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:showDeatilPanel()
	end)
	self.btn_back:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("返回主界面")
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.btn_buy_skin:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curPanelInfo.shop1iscanbuy == false then
			global_ShowBlockWords("已达购买上限")

			return
		end

		self:shopPop(birthday_party_manager:getShopInfoById(self.curPanelInfo.shopId1), birthday_party_manager:getShopType(), "giftitem", function()
			self.curPanelInfo.shop1iscanbuy = false

			self:updateSkinBtn()
		end)
		AnalyticManager.click_birthday_skin()
	end)
	self.btn_buy_furniture:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curPanelInfo.shop2iscanbuy == false then
			global_ShowBlockWords("已达购买上限")

			return
		end

		self:shopPop(birthday_party_manager:getShopInfoById(self.curPanelInfo.shopId2), birthday_party_manager:getShopType(), "furnitureItem", function()
			self.curPanelInfo.shop2iscanbuy = false

			self:updateFurnitureBtn()
		end)
		AnalyticManager.click_birthday_furniture()
	end)
	self.btn_buy_expansion:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curPanelInfo.eggstatus ~= 2 then
			global_ShowBlockWords("开启时间" .. self.curPanelInfo.unlocklevel .. "")

			return
		end

		LayerManager:switchShowLayer("TwisteggLayer", {
			initTwisType = tonumber(self.curPanelInfo.twiggestEggId) % 100000
		})
		AnalyticManager.click_birthday_expansion()
	end)
	self.btn_buy_barrage:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopUseBarrageGiftLayer", {
			type = "birthdayparty"
		})
		AnalyticManager.click_birthday_barrage()
	end)
	self.btn_switch_left:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.birthIndex = math.max(self.birthIndex - 1, 1)

		self.cityList:jumpToIndex(self.birthIndex)
		AnalyticManager.click_birthday_left()
	end)
	self.btn_switch_right:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.birthIndex = math.min(self.birthIndex + 1, (birthday_party_manager:getBirthdayPartyInfoLength()))

		self.cityList:jumpToIndex(self.birthIndex)
		AnalyticManager.click_birthday_right()
	end)

	self.btn_cake = ccui.ImageView:create(self.birthResPath .. "btn_cake.png", var_0_15)

	self.btn_cake:setPosition(cc.p(510, 890))

	self.cakeTipNode = ccui.ImageView:create(self.birthResPath .. "cake_tip.png", var_0_15)

	self.cakeTipNode:setPosition(cc.p(515, 940))
	self.root:addChild(self.btn_cake)
	self.root:addChild(self.cakeTipNode)
	self.btn_cake:setTouchEnabled(true)
	self.btn_cake:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("生日祝贺")

		if self.curPanelInfo == nil then
			return
		end

		birthday_party_manager:do_congratulations(self.curPanelInfo.index, function()
			global_remove_alert_tag(self.btn_cake)
			self.btn_cake:stopAllActions()

			if self.cityList == nil then
				return
			end

			global_remove_alert_tag((self.cityList:getCityByIndex(self.birthIndex)))
		end)
	end)

	local var_9_0 = ccui.Button:create("public/panelbg/bg_bg.png", nil, "public/panelbg/bg_bg.png", var_0_15)

	var_9_0:setScale9Enabled(true)
	var_9_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))
	var_9_0:setOpacity(0)
	var_9_0:setAnchorPoint(cc.p(0, 0))
	var_9_0:setSwallowTouches(false)
	self.root:addChild(var_9_0, 99)
	var_9_0:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 == ccui.TouchEventType.began then
			arg_23_0.dealTag = true
			arg_23_0.startPos = arg_23_0:getTouchBeganPosition()
		elseif arg_23_1 == ccui.TouchEventType.moved then
			if arg_23_0.dealTag == true then
				local var_23_0 = arg_23_0:getTouchMovePosition().x - arg_23_0.startPos.x

				if math.abs(var_23_0) < 10 then
					return
				end

				if var_23_0 > 0 then
					self.birthIndex = math.max(self.birthIndex - 1, 1)

					self.cityList:jumpToIndex(self.birthIndex)
					AnalyticManager.click_birthday_left()
				elseif var_23_0 < 0 then
					self.birthIndex = math.min(self.birthIndex + 1, (birthday_party_manager:getBirthdayPartyInfoLength()))

					self.cityList:jumpToIndex(self.birthIndex)
					AnalyticManager.click_birthday_right()
				end

				arg_23_0.dealTag = false
				arg_23_0.startPos = nil
			end
		elseif arg_23_1 == ccui.TouchEventType.ended then
			arg_23_0.dealTag = false
			arg_23_0.startPos = nil
		elseif arg_23_1 == ccui.TouchEventType.canceled then
			arg_23_0.dealTag = false
			arg_23_0.startPos = nil
		end
	end)
end

function BirthdayPartyLayer:showBarrageGiftEffect(arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5, arg_24_6, arg_24_7, arg_24_8)
	self.effectUseSp = self.effectUseSp or {}
	self.effectUseSp[arg_24_1] = self.effectUseSp[arg_24_1] or self:createEffectUseSp()

	self.effectUseSp[arg_24_1]:update(arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	self.effectUseSp[arg_24_1]:stopAllActions()
	self.effectUseSp[arg_24_1]:runCountDown(arg_24_8)

	if barrage_manager:isShowSpinEffect(arg_24_7) then
		self:createEffectPanel()

		if item_data[arg_24_2].barrage_spine then
			self:runSpineEffect(arg_24_2, arg_24_6)

			if item_data[arg_24_2].sound then
				audio_manager:playeffectMusicTest("sound/" .. item_data[arg_24_2].sound)
			end
		end
	end
end

function BirthdayPartyLayer:runSpineEffect(arg_25_1, arg_25_2)
	if arg_25_2 == playermodel.playerid then
		if self.effectspine then
			self.effectspine:removeFromParent()

			self.effectspine = nil
		end
	elseif self.effectspine then
		return
	end

	self.effectspine = L2Skeleton:create("spine/barrage/" .. item_data[arg_25_1].barrage_spine .. ".json", "spine/barrage/" .. item_data[arg_25_1].barrage_spine .. ".atlas")

	self.effectspine:refreshSkeleton()
	self.effectspine.skeletonAnimation:setPosition(cc.p(320, 420 - 100 * (GameDisplay.height - 1136) / 208))
	self.effectspine:play(item_data[arg_25_1].barrage_spine, false)
	self.effectPanel:addChild(self.effectspine, 10000)
	self.effectspine:registerListener(SP_ANIMATION_COMPLETE, function(arg_26_0)
		self.effectspine:runAction(cc.Sequence:create(cc.RemoveSelf:create(), cc.CallFunc:create(function(...)
			self.effectspine = nil
		end)))
	end)
end

function BirthdayPartyLayer:createEffectPanel()
	if not self.effectPanel then
		self.effectPanel = ccui.Layout:create()

		self.effectPanel:setTouchEnabled(false)
		self.effectPanel:setContentSize(cc.size(self:getContentSize().width, self:getContentSize().height))
		self.effectPanel:setAnchorPoint(cc.p(0.5, 0.5))
		self.effectPanel:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
		self.effectPanel:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
		self:addChild(self.effectPanel, var_0_2)
	end
end

function BirthdayPartyLayer:createEffectUseSp()
	local var_29_0, var_29_1 = self:getPos()
	local var_29_2 = ccui.ImageView:create("mainScenebg/barrage/use_barrage_gift_bg.png")

	var_29_2:setAnchorPoint(cc.p(0, 0.5))
	var_29_2:setPosition(cc.p(0, var_29_1))

	var_29_2.idx = var_29_0

	self:addChild(var_29_2, var_0_3)

	local var_29_3 = cc.Label:createWithTTF("", FONT_DES, 22)

	var_29_3:setAnchorPoint(cc.p(0, 0.5))
	var_29_3:setPosition(cc.p(10, var_29_2:getContentSize().height / 2 + 15))
	var_29_3:setName("namelabel")
	var_29_2:addChild(var_29_3)

	local var_29_4 = cc.Label:createWithTTF(L_SEND_GIFT, FONT_DES, 18)

	var_29_4:setAnchorPoint(cc.p(0, 0.5))
	var_29_4:setPosition(cc.p(55, var_29_2:getContentSize().height / 2 - 15))
	var_29_4:setName("label2")
	var_29_2:addChild(var_29_4)

	local var_29_5 = cc.Label:createWithTTF("", FONT_DES, 20)

	var_29_5:setAnchorPoint(cc.p(0, 0.5))
	var_29_5:setPosition(cc.p(10, var_29_2:getContentSize().height / 2 - 15))
	var_29_5:setColor(cc.c3b(242, 191, 67))
	var_29_5:setName("itemlabel")
	var_29_2:addChild(var_29_5)

	local var_29_6 = ccui.ImageView:create("roleimage/role/wuji/100.png")

	var_29_6:setPosition(cc.p(var_29_2:getContentSize().width - 50, var_29_2:getContentSize().height / 2 + 10))
	var_29_6:setName("itemImg")
	var_29_6:setScale(0.5)
	var_29_2:addChild(var_29_6)

	local var_29_7 = ccui.TextBMFont:create("x1", "fonts/barrage_gift.fnt")

	var_29_7:setName("countlabel")
	var_29_7:setScale(1)
	var_29_7:setAnchorPoint(cc.p(0.5, 0.5))
	var_29_7:setPosition(cc.p(var_29_2:getContentSize().width + 30, var_29_2:getContentSize().height / 2 + 18))
	var_29_2:addChild(var_29_7)

	function var_29_2:update(arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5)
		self:setOpacity(255)
		self:getChildByName("namelabel"):setString(arg_30_3)
		self:getChildByName("itemlabel"):setString(item_data[arg_30_2].name)
		self:getChildByName("label2"):setPositionX(self:getChildByName("itemlabel"):getPositionX() + self:getChildByName("itemlabel"):getContentSize().width)

		if item_data[arg_30_2].title_spine then
			self:getChildByName("itemImg"):setVisible(false)

			if self.id ~= arg_30_1 then
				if self:getChildByName("title_spine") then
					self:getChildByName("title_spine"):removeFromParent()
				end

				local var_30_0 = self:getChildByName("title_spine")
				local var_30_1 = L2Skeleton:create("spine/barrage/" .. item_data[arg_30_2].title_spine .. ".json", "spine/barrage/" .. item_data[arg_30_2].title_spine .. ".atlas")

				var_30_1:refreshSkeleton()
				var_30_1.skeletonAnimation:setPosition(cc.p(self:getChildByName("itemImg"):getPositionX(), 0))
				var_30_1:play(item_data[arg_30_2].title_spine, true)
				var_30_1:setScale(item_data[arg_30_2].title_spine_scale, item_data[arg_30_2].title_spine_scale)
				var_30_1:setName("title_spine")
				var_29_2:addChild(var_30_1)
			end
		else
			if self:getChildByName("title_spine") then
				self:getChildByName("title_spine"):runAction(cc.RemoveSelf:create())
			end

			self:getChildByName("itemImg"):setVisible(true)
			self:getChildByName("itemImg"):loadTexture("mainScenebg/barrage/" .. item_data[arg_30_2].image_id .. ".png")
			self:getChildByName("itemImg"):setScale(item_data[arg_30_2].title_img_scale)
		end

		if arg_30_5 > 1 then
			self:getChildByName("countlabel"):setScale(3)
			self:getChildByName("countlabel"):setOpacity(0)
			self:getChildByName("countlabel"):stopAllActions()
			self:getChildByName("countlabel"):runAction(cc.Spawn:create(cc.ScaleTo:create(0.1, 1, 1), cc.FadeIn:create(0.1)))
		end

		var_29_7:setString("x" .. arg_30_5)

		self.id = arg_30_1
	end

	function var_29_2:runCountDown(arg_31_1)
		self:runAction(cc.Sequence:create(cc.DelayTime:create(4), cc.FadeOut:create(1), cc.RemoveSelf:create(), cc.CallFunc:create(function(...)
			self.posPool[self.idx].count = 0
			self.effectUseSp[self.id] = nil

			if arg_31_1 then
				arg_31_1()
			end
		end)))
	end

	return var_29_2
end

function BirthdayPartyLayer:getPos()
	self.posPool = self.posPool or {
		{
			posy = 869,
			count = 0
		},
		{
			posy = 769,
			count = 0
		},
		{
			posy = 669,
			count = 0
		},
		{
			posy = 569,
			count = 0
		}
	}

	for iter_33_0, iter_33_1 in pairs(self.posPool) do
		if iter_33_1.count == 0 then
			iter_33_1.count = iter_33_1.count + 1

			return iter_33_0, iter_33_1.posy
		end
	end

	return 1, self.posPool[1].posy
end

function BirthdayPartyLayer:updateTimeCountDown(arg_34_1)
	local var_34_0 = birthday_party_manager:getLeftTimeStr(arg_34_1)

	if var_34_0 ~= nil then
		self.timeNode:setString("剩余时间：" .. var_34_0)

		if self.timeScheduler ~= nil then
			self.scheduler:unscheduleScriptEntry(self.timeScheduler)

			self.timeScheduler = nil
		end

		self.timeScheduler = self.scheduler:scheduleScriptFunc(function()
			self:updateTimeCountDown(arg_34_1)
		end, 1, false)
	end
end

function BirthdayPartyLayer.initInfo(arg_36_0)
	arg_36_0.birthIndex = 1
	arg_36_0.birthResPath = "BirthdayPartyLayer/birthday1/"
	arg_36_0.birthCellBgPath = "mainScenebg/birthdayparty/"
end

function BirthdayPartyLayer:updateFurnitureBtn()
	local var_37_0 = self.curPanelInfo.shop2iscanbuy == true and self.birthResPath .. "btn_buy_furniture.png" or self.birthResPath .. "btn_have_buy_furniture.png"

	self.btn_buy_furniture:loadTextures(var_37_0, var_37_0, var_37_0, var_0_15)
end

function BirthdayPartyLayer:updateSkinBtn()
	local var_38_0 = self.btn_buy_skin:getChildByName("coin")

	if var_38_0 == nil then
		var_38_0 = ccui.ImageView:create(self.curPanelInfo.coinPath)

		var_38_0:setName("coin")
		var_38_0:setAnchorPoint(cc.p(0, 0))
		var_38_0:setPosition(cc.p(15, 8))
		var_38_0:setScale(0.45)
		self.btn_buy_skin:addChild(var_38_0)
	end

	local var_38_1
	local var_38_2 = self.btn_buy_skin:getChildByName("discount_price")

	if self.curPanelInfo.shop1iscanbuy == true then
		var_38_1 = self.birthResPath .. "btn_buy_skin.png"

		var_38_2:setString(self.curPanelInfo.shop1price)
		var_38_2:setVisible(true)
		var_38_0:setVisible(true)
	else
		var_38_1 = self.birthResPath .. "btn_have_buy_skin.png"

		var_38_2:setVisible(false)
		var_38_0:setVisible(false)
	end

	var_38_0:setVisible(false)
	var_38_2:setVisible(false)
	self.btn_buy_skin:loadTextures(var_38_1, var_38_1, var_38_1, var_0_15)
end

function BirthdayPartyLayer:updateBarrageBtn()
	local var_39_0 = birthday_party_manager:getBirthdayPartyInfo()

	self.btn_buy_barrage:getChildByName("num"):setVisible(false)
end

function BirthdayPartyLayer:switchShowPanel(arg_40_1)
	local var_40_0 = birthday_party_manager:getBirthdayPartyInfo(arg_40_1)

	if var_40_0 == nil or next(var_40_0) == nil then
		return
	end

	self.curPanelInfo = var_40_0
	self.birthResPath = "BirthdayPartyLayer/" .. var_40_0.name .. "/"

	self.btn_back:loadTextures(self.birthResPath .. "btn_return.png", self.birthResPath .. "btn_return.png", self.birthResPath .. "btn_return.png", var_0_15)

	local var_40_1

	if var_40_0.eggstatus ~= 1 then
		var_40_1 = self.birthResPath .. "btn_birthday_expansion.png" or self.birthResPath .. "btn_birthday_expansion_off.png"
	end

	self.btn_buy_expansion:loadTextures(var_40_1, var_40_1, var_40_1, var_0_15)
	self.btn_buy_expansion:setVisible(var_40_0.eggstatus == 1 or var_40_0.eggstatus == 2)
	self.btn_buy_barrage:loadTextures(self.birthResPath .. "btn_birthday_barrage.png", self.birthResPath .. "btn_birthday_barrage.png", self.birthResPath .. "btn_birthday_barrage.png", var_0_15)
	self.titleNode:loadTexture(self.birthResPath .. "title.png", var_0_15)
	self.btn_switch_left:setVisible(var_40_0.isCanSwitchLeft == 1)
	self.btn_switch_right:setVisible(var_40_0.isCanSwitchRight == 1)
	self.btn_buy_skin:setVisible(var_40_0.shopId1 ~= nil)
	self.btn_buy_furniture:setVisible(var_40_0.shopId2 ~= nil)
	self.titleNode:getChildByName("discount_time"):setString(var_40_0.battleFiledTime)

	if self.btn_buy_furniture:getChildByName("furniture") then
		self.btn_buy_furniture:getChildByName("furniture"):removeFromParent()
	end

	if self.btn_buy_furniture:getChildByName("furnitureBg") then
		self.btn_buy_furniture:getChildByName("furnitureBg"):removeFromParent()
	end

	local var_40_2 = ccui.ImageView:create(var_40_0.shop2Path)

	var_40_2:setName("furniture")
	var_40_2:setAnchorPoint(cc.p(0, 0))
	var_40_2:setPosition(cc.p(12, 13))
	var_40_2:setScale(0.4)
	self.btn_buy_furniture:addChild(var_40_2)
	self:updateSkinBtn()
	self:updateFurnitureBtn()
	self:updateBarrageBtn()
	self:updateTimeCountDown(arg_40_1)
	self:showGirlPanel(var_40_0.modelId)

	if var_40_0.congratulationstatus == BIRTHDAY_PARTY.CongratulationStatus.CAN_USE then
		global_add_alert_tag(self.btn_cake, cc.p(135, 100))
		self.btn_cake:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function(arg_41_0)
			arg_41_0:setRotation(0)
		end), cc.DelayTime:create(0.5), cc.CallFunc:create(function(arg_42_0)
			arg_42_0:setRotation(-15)
		end))))
	else
		global_remove_alert_tag(self.btn_cake)
		self.btn_cake:stopAllActions()
	end
end

function BirthdayPartyLayer:initPageView()
	local var_43_0 = birthday_party_manager:getBirthdayPartyInfo()

	if var_43_0 == nil then
		return
	end

	local var_43_1 = ccui.ImageView:create(self.birthResPath .. "scroll_bg.png", var_0_15)

	var_43_1:setPosition(cc.p(0, 74))
	var_43_1:setAnchorPoint(cc.p(0, 0))
	self.root:addChild(var_43_1)

	local var_43_2 = cc.p(350, 54)

	self.cityList = PageList:create()

	self.cityList:setContentSize(cc.size(160 * #var_43_0, 88))
	self.cityList:setPageListGap(160)
	self.cityList:setCityInitPosY(0)
	self.cityList:openSlideMode(true)

	self.cityListMask = PageList:create()

	self.cityListMask:setContentSize(cc.size(160 * #var_43_0, 88))
	self.cityListMask:setPageListGap(160)
	self.cityListMask:setCityInitPosY(0)
	self.cityListMask:setPosition(var_43_2)
	self.cityListMask:setTouchEnabled(true)
	self.root:addChild(self.cityListMask, 1)
	self.cityList:setPosition(var_43_2)
	self.root:addChild(self.cityList, 1)

	for iter_43_0, iter_43_1 in ipairs(var_43_0) do
		local var_43_3 = ccui.Button:create(self.birthCellBgPath .. iter_43_1.id .. "_off.png", nil, self.birthCellBgPath .. iter_43_1.id .. "_off.png")

		var_43_3:addTouchEventListener(function(arg_44_0, arg_44_1)
			if arg_44_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_44_0:getTouchBeganPosition().x - arg_44_0:getTouchEndPosition().x) >= 25 then
				return
			end

			self.cityList:scrollToIndexManual(arg_44_0:getTag())
			print("touch ")
		end)

		if iter_43_1.congratulationstatus == BIRTHDAY_PARTY.CongratulationStatus.CAN_USE then
			global_add_alert_tag(var_43_3, cc.p(160, 88))
		else
			global_remove_alert_tag(var_43_3)
		end

		self.cityList:pushInCity(var_43_3)
	end

	self.cityList:registerSelectCityHandler(function(arg_45_0)
		if self.cityList.index == arg_45_0 then
			return
		end

		if self.cityList.index ~= nil then
			local var_45_0 = self.birthCellBgPath .. birthday_party_manager:getBirthdayPartyInfo(self.cityList.index).id .. "_off.png"

			self.cityList:getCityByIndex(self.cityList.index):loadTextures(var_45_0, nil, var_45_0)
		end

		self.cityList.index = arg_45_0
		self.initconfig.index = arg_45_0
		self.birthIndex = arg_45_0

		local var_45_1 = self.birthCellBgPath .. birthday_party_manager:getBirthdayPartyInfo(self.cityList.index).id .. "_on.png"

		self.cityList:getCityByIndex(arg_45_0):loadTextures(var_45_1, nil, var_45_1)
		print("scroll ")
		AnalyticManager.click_birthday_scroll()
		self:switchShowPanel(arg_45_0)
	end)

	local var_43_4 = birthday_party_manager:getTodayBirthdayIndex()
	local var_43_5

	if self.initconfig then
		var_43_5 = self.initconfig.index

		if not self.initconfig.index and not var_43_4 then
			::label_43_0::

			var_43_5 = var_43_4
		end
	end

	self.cityList:jumpToIndex(var_43_5)

	local var_43_6 = ccui.ImageView:create(self.birthResPath .. "scroll_left.png", var_0_15)
	local var_43_7 = ccui.ImageView:create(self.birthResPath .. "scroll_right.png", var_0_15)

	var_43_6:setPosition(cc.p(-90, 55))
	var_43_7:setPosition(cc.p(85, 55))
	self.cityList:addChild(var_43_6)
	self.cityList:addChild(var_43_7)
end

function BirthdayPartyLayer.getTableView(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5, arg_46_6)
	local var_46_0 = arg_46_3.width
	local var_46_1 = arg_46_3.height
	local var_46_2 = cc.TableView:create(arg_46_4)

	var_46_2:setVisible(true)
	var_46_2:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_46_2:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_46_2:setDelegate()
	var_46_2:registerScriptHandler(function(arg_47_0)
		return arg_46_2
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_46_2:registerScriptHandler(function(arg_48_0)
		arg_46_0:scrollViewDidScroll(arg_48_0)
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	var_46_2:registerScriptHandler(function(arg_49_0, arg_49_1)
		arg_46_6(arg_49_0, arg_49_1)
	end, cc.TABLECELL_TOUCHED)
	var_46_2:registerScriptHandler(function(arg_50_0, arg_50_1)
		if arg_46_1[arg_50_1 + 1].isDouble == true and arg_50_1 + 1 == arg_46_2 then
			return var_46_0, var_46_1 + 240 + 80 + GameDisplay.fix_y
		elseif arg_46_1[arg_50_1 + 1].isDouble == true and arg_50_1 + 1 ~= arg_46_2 then
			return var_46_0, var_46_1 + 240
		elseif arg_46_1[arg_50_1 + 1].isDouble ~= true and arg_50_1 + 1 == arg_46_2 then
			return var_46_0, var_46_1 + 80 + GameDisplay.fix_y
		else
			return var_46_0, var_46_1
		end
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_46_2:registerScriptHandler(function(arg_51_0, arg_51_1)
		return arg_46_5(arg_51_0, arg_51_1, arg_46_1)
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_46_2:reloadData()
	var_46_2:setAnchorPoint(cc.p(0, 1))

	return var_46_2
end

function BirthdayPartyLayer.scrollViewDidScroll(arg_52_0, arg_52_1)
	print("scrollViewDidScroll")
end

function BirthdayPartyLayer:bondSchedulerWithCallback(arg_53_1, arg_53_2)
	arg_53_2 = arg_53_2 or 1

	if self.bondScheduler ~= nil then
		self.scheduler:unscheduleScriptEntry(self.bondScheduler)
	end

	self.bondScheduler = self.scheduler:scheduleScriptFunc(function()
		if type(arg_53_1) == "function" then
			arg_53_1()
		end

		if self.bondScheduler ~= nil then
			self.scheduler:unscheduleScriptEntry(self.bondScheduler)
		end
	end, arg_53_2, false)
end

function BirthdayPartyLayer:showGirlPanel(arg_55_1)
	local var_55_0 = self.girlPanelNode:getChildByName("showgirlLayer")

	if var_55_0 then
		var_55_0:removeFromParent()
	end

	local var_55_1 = require("view.Layer.ShowGirlLayer"):create(arg_55_1, 3)

	var_55_1:setName("showgirlLayer")
	var_55_1:resetCurTalkConfig(arg_55_1)
	var_55_1:setLive2DPlayStayEnabled(true)
	self.girlPanelNode:addChild(var_55_1, 0)

	local var_55_2 = 1

	if model_data[arg_55_1].is_own_full_screen_background == 1 then
		var_55_2 = 2
	end

	if not model_data[arg_55_1].backgroundid_main then
		-- block empty
	end

	local var_55_4

	if var_55_4 then
		if not var_55_1:getChildByName("backGroundLayer") then
			local var_55_5 = BackGroundLayer:create(var_55_4, var_55_2)

			var_55_5:setName("backGroundLayer")
			var_55_1:addChild(var_55_5, 1)
		end

		var_55_1:getChildByName("backGroundLayer"):update(var_55_4, var_55_2)
	end

	var_55_1:setScale(self.curPanelInfo.spineScale)
	var_55_1:setAnchorPoint(cc.p(0, 0))
	var_55_1:setPosition(cc.p(self.curPanelInfo.spinePos.x, self.curPanelInfo.spinePos.y + GameDisplay.fix_y))
end

function BirthdayPartyLayer:showFurniturePop(arg_56_1)
	local var_56_0 = ccui.Layout:create()

	var_56_0:setTouchEnabled(true)
	var_56_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_56_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_56_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_56_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_56_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_56_0:setBackGroundColorOpacity(180)
	self:addChild(var_56_0, 10)

	local var_56_1 = ccui.ImageView:create("public/panelbg/bg_pop_small.png", var_0_15)

	var_56_1:setPosition(cc.p(var_56_0:getContentSize().width / 2, var_56_0:getContentSize().height / 2))
	var_56_1:setScaleY(0)
	var_56_1:setScaleY(0)
	var_56_1:runAction(cc.ScaleTo:create(0.2, 1.2))
	var_56_0:addChild(var_56_1)

	local var_56_2 = ccui.ImageView:create("mainScenebg/market/" .. arg_56_1.itemid .. ".jpg")

	var_56_2:setPosition(cc.p(var_56_0:getContentSize().width / 2, var_56_0:getContentSize().height / 2))
	var_56_0:addChild(var_56_2)

	local var_56_3 = ccui.ImageView:create("public/panelbg/furniture_bg.png", var_0_15)

	var_56_3:setPosition(cc.p(var_56_2:getContentSize().width / 2, var_56_2:getContentSize().height / 2))
	var_56_2:addChild(var_56_3)

	local var_56_4 = string_split(item_data[arg_56_1.itemid].name, "】")

	if #var_56_4 == 2 then
		local var_56_5 = cc.Label:createWithTTF(var_56_4[2], FONT_DES, 26)

		var_56_5:setPosition(cc.p(470, 188))
		var_56_5:setColor(cc.c3b(187, 62, 198))
		var_56_3:addChild(var_56_5)

		local var_56_6 = cc.Label:createWithTTF(var_56_4[2], FONT_DES, 26)

		var_56_6:setPosition(cc.p(472, 188))
		var_56_6:setColor(cc.c3b(0, 168, 255))
		var_56_3:addChild(var_56_6)
	else
		local var_56_7 = cc.Label:createWithTTF(item_data[arg_56_1.itemid].name, FONT_DES, 26)

		var_56_7:setPosition(cc.p(470, 188))
		var_56_7:setColor(cc.c3b(187, 62, 198))
		var_56_3:addChild(var_56_7)

		local var_56_8 = cc.Label:createWithTTF(item_data[arg_56_1.itemid].name, FONT_DES, 26)

		var_56_8:setPosition(cc.p(472, 188))
		var_56_8:setColor(cc.c3b(0, 168, 255))
		var_56_3:addChild(var_56_8)
	end

	local var_56_9 = ccui.ImageView:create(arg_56_1.slidecost.costtype, var_0_15)

	var_56_9:setPositionX(var_56_3:getContentSize().width / 2 - 30)
	var_56_9:setPositionY(-130)
	var_56_3:addChild(var_56_9)

	local var_56_10 = cc.Label:createWithTTF(arg_56_1.slidecost.costnum, FONT_DES, 23)

	var_56_10:setAnchorPoint(cc.p(0, 0.5))
	var_56_10:setPositionX(var_56_9:getPositionX() + var_56_9:getContentSize().width / 2 + 5)
	var_56_10:setPositionY(var_56_9:getPositionY())
	var_56_3:addChild(var_56_10)

	local var_56_11
	local var_56_12

	if arg_56_1.limit_buy_num == 0 then
		var_56_11 = ccui.Button:create("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_15)
		var_56_12 = cc.Label:createWithTTF(L_MARKET_GOODS_LACK, FONT_BUTTON, 26)
	else
		var_56_11 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_15)
		var_56_12 = cc.Label:createWithTTF(L_BUTTON_TEXT.Buy, FONT_BUTTON, 26)
	end

	var_56_12:setColor(cc.c3b(12, 12, 12))
	var_56_11:setPosition(cc.p(var_56_3:getContentSize().width / 2, -60))
	var_56_12:setPosition(cc.p(var_56_11:getContentSize().width / 2, var_56_11:getContentSize().height / 2 - 5))
	var_56_11:addChild(var_56_12)
	var_56_3:addChild(var_56_11)
	var_56_11:addTouchEventListener(function(arg_57_0, arg_57_1)
		if arg_57_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_56_1.ShopSliderCallback then
			arg_56_1.ShopSliderCallback(arg_57_0, arg_57_1, function()
				var_56_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_56_0:runAction(cc.RemoveSelf:create())
				end)))
				var_56_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					var_56_0:runAction(cc.RemoveSelf:create())
				end)))
			end)
		end
	end)
	var_56_2:setScaleY(0)
	var_56_2:runAction(cc.ScaleTo:create(0.2, 1))
	var_56_0:addTouchEventListener(function(arg_61_0, arg_61_1)
		var_56_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_56_0:runAction(cc.RemoveSelf:create())
		end)))
		var_56_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_56_0:runAction(cc.RemoveSelf:create())
		end)))
	end)
end

function BirthdayPartyLayer:initBarrageSpine(arg_64_1)
	local var_64_0 = self.root:getChildByName("spineBg")

	if var_64_0 ~= nil then
		var_64_0:removeFromParent()
	end

	local var_64_1 = ccui.ImageView:create(self.birthResPath .. "barrage_bg.png", var_0_15)

	var_64_1:setName("spineBg")
	var_64_1:setPosition(cc.p(320, 400))

	local var_64_2 = L2Skeleton:create("spine/barrage/birthday_song.json", "spine/barrage/birthday_song.atlas")

	var_64_2:refreshSkeleton()
	var_64_2:play("birthday_song", true)
	var_64_2:setVisible(true)
	var_64_2:setPosition(cc.p(175, 10))
	var_64_2:registerListener(SP_ANIMATION_COMPLETE, function(arg_65_0)
		return
	end)
	self:bondSchedulerWithCallback(function()
		if var_64_1 ~= nil then
			var_64_1:removeFromParent()
		end
	end, arg_64_1)
	var_64_1:addChild(var_64_2)
	self.root:addChild(var_64_1)
end

function BirthdayPartyLayer:playBarrageSpine(arg_67_1)
	local var_67_0 = self.root:getChildByName("spineBg")

	if var_67_0 ~= nil then
		var_67_0:setVisible(not var_67_0:isVisible())
		var_67_0:stopAllActions()
		var_67_0:runAction((cc.Sequence:create(cc.DelayTime:create(arg_67_1), cc.CallFunc:create(function()
			var_67_0:setVisible(false)
		end))))
	end
end

function BirthdayPartyLayer.shopPop(arg_69_0, arg_69_1, arg_69_2, arg_69_3, arg_69_4)
	local var_69_1 = {
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

	setmetatable(var_69_1, {
		__index = function(arg_75_0, arg_75_1)
			return function()
				return item_manager:getItemNumber(arg_75_1)
			end
		end
	})

	local var_69_2 = {
		"public/currency/UI_battleEnd_gold.png",
		[0] = "public/currency/UI_battleEnd_diamond.png",
		"public/currency/arenascene_dot_1.png",
		"public/currency/explorecoin.png",
		[1500001] = "public/currency/1500001_1.png",
		[100] = "public/currency/rmb_white.png"
	}

	setmetatable(var_69_2, {
		__index = function(arg_77_0, arg_77_1)
			return "public/currency/" .. item_data[arg_77_1].image_id .. ".png"
		end
	})

	local var_69_3 = {
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "HandOfMidasLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_GOLD
			})
		end,
		[0] = function()
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

	setmetatable(var_69_3, {
		__index = function(arg_83_0, arg_83_1)
			return function()
				global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_83_1].name))
				audio_manager:playeffectMusicTest("sound/invalid")
			end
		end
	})

	local var_69_4 = {}

	local function var_69_5(arg_85_0)
		local var_85_0 = var_69_4

		if arg_85_0.result == 1 then
			if not arg_85_0.selectCoupon then
				shop_manager:shop_buy(var_69_4.shoptype, var_69_4.shopitem.shopid, function(arg_86_0)
					if arg_86_0 == 1 then
						arg_69_1.have_bought = arg_69_1.have_bought + var_85_0.curbuyTime
						arg_69_1.sell_out = arg_69_1.buy_limit and arg_69_1.buy_limit <= arg_69_1.have_bought

						if var_85_0.shopitem.bag_item_type == kITEM_SKIN or var_85_0.shopitem.bag_item_type == kITEM_SKIN_GIFT then
							AnalyticManager.dorm_buy_dress_success({
								soulid = arg_69_0.soulid,
								itemid = var_85_0.shopitem.itemid
							})
						end

						if item_data[var_85_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_85_0.itemid), 1000)
						end

						if var_85_0.callback then
							var_85_0.callback()
						end
					elseif arg_86_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
						audio_manager:playeffectMusicTest("sound/invalid")
					elseif arg_86_0 == 3 then
						var_69_3[var_85_0.shopitem.currency]()
					end

					if arg_69_4 then
						arg_69_4(arg_86_0)
					end
				end, var_69_4.curbuyTime, function()
					LayerManager:removePopLayer()
				end, arg_69_3 == "barrageitem")
			else
				shop_manager:shop_buy_with_ticket(var_69_4.shoptype, var_69_4.shopitem.shopid, function(arg_88_0)
					if arg_88_0 == 1 then
						arg_69_1.have_bought = arg_69_1.have_bought + var_85_0.curbuyTime
						arg_69_1.sell_out = arg_69_1.buy_limit and arg_69_1.buy_limit <= arg_69_1.have_bought

						if var_85_0.shopitem.bag_item_type == kITEM_SKIN or var_85_0.shopitem.bag_item_type == kITEM_SKIN_GIFT then
							AnalyticManager.dorm_buy_dress_success({
								soulid = arg_69_0.soulid,
								itemid = var_85_0.shopitem.itemid
							})
						end

						if item_data[var_85_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_85_0.itemid), 1000)
						end

						if var_85_0.callback then
							var_85_0.callback()
						end
					elseif arg_88_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
						audio_manager:playeffectMusicTest("sound/invalid")
					elseif arg_88_0 == 3 then
						var_69_3[var_85_0.shopitem.currency]()
					end

					if arg_69_4 then
						arg_69_4(arg_88_0)
					end
				end, var_69_4.curbuyTime, function()
					LayerManager:removePopLayer()
				end, arg_85_0.selectCoupon, 1)
			end
		end
	end

	local function var_69_6(arg_90_0)
		if not arg_90_0.currency2 or discount_manager:getLastPriceByItem(arg_90_0.itemid, arg_90_0.currency2, arg_90_0.discount2) < arg_90_0.discount2 then
			return true
		end

		return false
	end

	local function var_69_7(arg_97_0)
		local var_97_0 = {}

		if arg_97_0.currency2 then
			var_97_0.currency2 = arg_97_0.currency2
			var_97_0.costIcon2 = var_69_2[arg_97_0.currency2]
			var_97_0.cost2 = arg_97_0.discount2 or arg_97_0.price2
			var_97_0.cost_old2 = arg_97_0.price2
			var_97_0.discount2 = arg_97_0.discount2
		end

		var_97_0.name = item_data[arg_97_0.itemtype].name
		var_97_0.itemid = arg_97_0.itemtype
		var_97_0.shopid = arg_97_0.shopid
		var_97_0.costIcon = var_69_2[arg_97_0.currency]
		var_97_0.currency = arg_97_0.currency
		var_97_0.isnewitem = arg_97_0.isnewitem
		var_97_0.discountfinish = arg_97_0.discountfinish
		var_97_0.cost = arg_97_0.discount or arg_97_0.price
		var_97_0.quality = item_data[arg_97_0.itemtype].equip_quality or 1
		var_97_0.cost_old = arg_97_0.price
		var_97_0.bag_item_type = item_data[arg_97_0.itemtype].bag_item_type
		var_97_0.item_attr = arg_97_0.item_attr
		var_97_0.finish_time = arg_97_0.finish_time
		var_97_0.discount = arg_97_0.discount
		var_97_0.buy_limit = arg_97_0.buy_limit or 1000000
		var_97_0.have_bought = arg_97_0.have_bought or 0
		var_97_0.sell_out = arg_97_0.buy_limit and arg_97_0.buy_limit <= arg_97_0.have_bought
		var_97_0.tag = arg_97_0.tag or 0
		var_97_0.pos = arg_97_0.pos
		var_97_0.purchaseid = arg_97_0.productid

		return var_97_0
	end

	if arg_69_1.currency == 100 then
		(function(arg_93_0)
			local var_93_0 = {
				itemid = arg_93_0.itemid,
				item_attr = arg_93_0.item_attr
			}
			local var_93_1 = {
				costtype = arg_93_0.costIcon
			}

			var_93_1.costnum = arg_93_0.discount or arg_93_0.cost
			var_93_0.slidecost = var_93_1

			function var_93_0:ShopSliderCallback(arg_94_1, arg_94_2)
				if arg_94_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_93_0.have_bought >= arg_93_0.buy_limit then
					global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
					audio_manager:playeffectMusicTest("sound/invalid")

					return
				end

				self:setTouchEnabled(false)
				shop_manager:shop_purchase(arg_93_0.shopid, arg_93_0.purchaseid, function(arg_95_0)
					if arg_95_0 == 1 then
						arg_69_1.have_bought = arg_69_1.have_bought + curbuyTime
						arg_69_1.sell_out = arg_69_1.buy_limit and arg_69_1.buy_limit <= arg_69_1.have_bought

						if arg_93_0.bag_item_type ~= kITEM_SKIN and arg_93_0.bag_item_type == kITEM_SKIN_GIFT then
							-- block empty
						end

						LayerManager:removePopLayer(arg_69_0.__queueindex)

						if item_data[var_93_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_93_0.itemid), 1000)
						end

						if arg_69_2 == 6 then
							for iter_95_0, iter_95_1 in pairs({
								{
									entityid = var_93_0.itemid
								}
							}) do
								net:rpc("use_gift_bag", {
									num = 1,
									entityid = iter_95_1.entityid
								}, function(arg_96_0)
									if arg_96_0.result == 1 then
										global_gain(arg_96_0)
										item_manager:deleteItem(iter_95_1.entityid, 1)
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
										dropid = var_93_0.itemid,
										entityid = var_93_0.itemid
									}
								}
							})
						end
					elseif arg_95_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Goods_Sended)
						audio_manager:playeffectMusicTest("sound/invalid")
					end

					if arg_94_2 then
						arg_94_2(arg_95_0)
					end
				end)
			end

			if arg_69_2 == 4 or arg_69_2 == 6 then
				arg_69_0:showBuyPop(var_93_0, nil, arg_69_3)
			else
				print("暂时没给非服装商城做人民币支付")
			end

			arg_93_0.isnewitem = false
		end)(var_69_7(arg_69_1))
	else
		(function(arg_91_0)
			local var_91_0 = {
				itemid = arg_91_0.itemid,
				item_attr = arg_91_0.item_attr
			}

			var_91_0.limitNum = arg_91_0.buy_limit and (arg_91_0.buy_limit - arg_91_0.have_bought >= SHOP_NORMAL_BUY_LIMIT_NUM and SHOP_NORMAL_BUY_LIMIT_NUM or arg_91_0.buy_limit - arg_91_0.have_bought) or SHOP_NORMAL_BUY_LIMIT_NUM

			local var_91_1

			if var_69_6(arg_91_0) then
				var_91_1 = math.floor(var_69_1[arg_91_0.currency]() / arg_91_0.cost)
				var_91_0.currency = arg_91_0.currency
			else
				var_91_1 = math.floor(var_69_1[arg_91_0.currency2]() / arg_91_0.cost2)
				var_91_0.currency = arg_91_0.currency2
			end

			if var_91_1 > var_91_0.limitNum then
				var_91_0.limitNum = var_91_0.limitNum or var_91_1
			end

			local var_91_2 = arg_69_0:getResidueTime(arg_91_0.finish_time)

			if var_91_2 ~= "-1" then
				var_91_0.limit_time = L_MARKET_MSG.Rest_Time .. var_91_2
			end

			var_91_0.slidecost = {}

			if var_69_6(arg_91_0) then
				var_91_0.slidecost.costtype = arg_91_0.costIcon
				var_91_0.slidecost.costnum = arg_91_0.discount or arg_91_0.cost
				var_91_0.slidecost.nowHave = var_69_1[arg_91_0.currency]()
				var_91_0.slidecost.cost_old = arg_91_0.cost_old or var_91_0.slidecost.costnum
			else
				var_91_0.slidecost.costtype = arg_91_0.costIcon2
				var_91_0.slidecost.costnum = arg_91_0.discount2 or arg_91_0.cost2
				var_91_0.slidecost.nowHave = var_69_1[arg_91_0.currency2]()
				var_91_0.slidecost.cost_old = arg_91_0.cost_old2 or var_91_0.slidecost.costnum
			end

			function var_91_0:ShopSliderCallback(arg_92_1, arg_92_2, arg_92_3)
				if arg_92_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not self:isBright() then
					return
				end

				local var_92_0 = self.nowNum or 1

				var_69_4 = {
					curbuyTime = var_92_0,
					shoptype = arg_69_2,
					itemid = var_91_0.itemid,
					callback = arg_92_2,
					shopitem = arg_91_0
				}

				if not arg_92_3 and var_69_6(arg_91_0) and arg_91_0.cost > var_69_1[arg_91_0.currency]() then
					LayerManager:removePopLayer()
					var_69_3[arg_91_0.currency]()

					return
				end

				self:setTouchEnabled(false)
				var_69_5({
					result = 1,
					selectCoupon = arg_92_3
				})
			end

			var_91_0.hideGainButton = true

			if arg_91_0.have_bought and arg_91_0.buy_limit then
				var_91_0.limit_buy_num = arg_91_0.buy_limit - arg_91_0.have_bought
				var_91_0.have_bought_num = arg_91_0.have_bought
			end

			arg_69_0:showBuyPop(var_91_0, arg_69_2, arg_69_3)

			arg_91_0.isnewitem = false
		end)(var_69_7(arg_69_1))
	end
end

function BirthdayPartyLayer.getResidueTime(arg_98_0, arg_98_1)
	if not arg_98_1 then
		return "-1"
	end

	local var_98_5 = global_get_time_by_date(arg_98_1) - playermodel.onlineTime
	local var_98_6 = math.floor(var_98_5 / 24 / 3600)
	local var_98_7 = math.floor((var_98_5 - var_98_6 * 24 * 3600) / 3600)
	local var_98_8 = math.floor((var_98_5 - var_98_6 * 24 * 3600 - var_98_7 * 3600) / 60)

	return var_98_6 ~= 0 and string.format(L_TIME_TEXT[1], var_98_6, var_98_7) or var_98_7 ~= 0 and string.format(L_TIME_TEXT[2], var_98_7, var_98_8) or string.format(L_TIME_TEXT[3], var_98_8)
end

function BirthdayPartyLayer:showBuyPop(arg_99_1, arg_99_2, arg_99_3)
	arg_99_1.couponList = discount_manager:getCanUseCoupin(arg_99_1.itemid, arg_99_1.currency, arg_99_1.costnum or arg_99_1.slidecost.costnum, arg_99_2)

	if not arg_99_2 then
		LayerManager:pushInLayer("PopGoodsLayer", arg_99_1)
	elseif arg_99_3 == "shopitem" then
		LayerManager:pushInLayer("PopGoodsLayer", arg_99_1)
	elseif arg_99_3 == "giftitem" then
		if arg_99_1.couponList and next(arg_99_1.couponList) then
			LayerManager:pushInLayer("PopGoodsLayer", arg_99_1)
		else
			LayerManager:pushInLayer("PopSkinPackage", arg_99_1)
		end
	elseif arg_99_3 == "furnitureItem" then
		self:showFurniturePop(arg_99_1)
	elseif arg_99_3 == "barrageitem" then
		LayerManager:pushInLayer("PopGoodsLayer", arg_99_1)
	end
end

function BirthdayPartyLayer:showDeatilPanel()
	local var_100_0 = self:getChildByName("detailPanel")

	if var_100_0 == nil then
		var_100_0 = ccui.Layout:create()

		var_100_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_100_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_100_0:setBackGroundColorOpacity(149)
		var_100_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))
		var_100_0:setAnchorPoint(cc.p(0, 0))
		var_100_0:setPosition(cc.p(0, 0))
		var_100_0:setTouchEnabled(true)
		self.root:addChild(var_100_0, 999)

		var_100_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_100_0:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

		var_100_0:setPositionY((GameDisplay.height + GameDisplay.fix_y - 1136) / 2)

		local var_100_1 = ccui.ImageView:create("public/panelbg/bg_skill_details.png", var_0_15)

		var_100_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_100_1:setPosition(cc.p(320, 630))
		var_100_1:setScale9Enabled(true)
		var_100_1:setCapInsets(cc.rect(200, 200, 300, 300))
		var_100_1:setContentSize(cc.size(568, 640))
		var_100_1:setScaleX(0.75)
		var_100_1:setScaleY(0.5)
		var_100_1:setTouchEnabled(true)
		var_100_0:addChild(var_100_1)

		local var_100_2 = ccui.Text:create("生日祝福详情", FONT_DES, 26)

		var_100_2:setAnchorPoint(cc.p(0, 0))
		var_100_2:setPosition(cc.p(195, 560))
		var_100_2:setScaleX(1.3)
		var_100_2:setScaleY(2)
		var_100_1:addChild(var_100_2)

		local var_100_3 = ccui.Text:create("攻击和生命20%提升", FONT_DES, 26)

		var_100_3:setAnchorPoint(cc.p(0, 0))
		var_100_3:setPosition(cc.p(155, 450))
		var_100_3:setScaleX(1.3)
		var_100_3:setScaleY(2)
		var_100_1:addChild(var_100_3)
		var_100_0:addTouchEventListener(function(arg_101_0, arg_101_1)
			if arg_101_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_100_0:setVisible(false)
		end)
	else
		var_100_0:setVisible(true)
	end
end

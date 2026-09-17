local BarrageLayer = class("BarrageLayer", function()
	return cc.Layer:create()
end)
local var_0_1 = config._DEBUG and 0 or 1
local var_0_2 = false
local barrage_manager = require("controller.barrage_manager")
local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local utf8 = require("controller.utf8")
local audio_manager = require("controller.audio_manager")
local var_0_9 = 0
local var_0_10 = 1
local var_0_11 = 2
local var_0_12 = 1000
local var_0_13 = 1001
local var_0_15 = 10
local var_0_16 = 11

function BarrageLayer:create()
	local var_2_0 = BarrageLayer.new()

	var_2_0:init()

	return var_2_0
end

function BarrageLayer:init()
	self._playing = var_0_11
	self._inputValid = true
	self._sendwaiting = false
	self._playingcolors = false

	self:initOpenBtn()
	self:addInputCom()
	self:initBatchColorBarrageListener()
	self:updateNianshouEntrance()
	self:initStarRankBtn()
	self:initPassLevelListener()
	barrage_manager:registerRef(self)
	barrage_manager:reset(level_manager:getCurFightChapter())
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			self:stopPlayBatchColorBarrage()
			barrage_manager:unregisterRef()
		end
	end)
end

function BarrageLayer:initOpenBtn()
	self.openBtn = ccui.Button:create("FightLayer/btn_open_barrage.png", "FightLayer/btn_open_barrage.png", "FightLayer/btn_open_barrage.png", var_0_1)

	self.openBtn:setPressedActionEnabled(true)
	self.openBtn:setPosition(cc.p(96, 276))
	self:addChild(self.openBtn, 2)

	self.openBtn.state = var_0_10

	self.openBtn:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.openBtn.state = 1 - self.openBtn.state

		if self.openBtn.state == var_0_9 then
			self:stopAllActions()
			self:stopBarrage()

			self._sendwaiting = true

			self.inputBg:stopAllActions()
			self.inputBg:runAction(cc.Sequence:create(cc.MoveTo:create(0.25, cc.p(self.inputBg:getPositionX(), -22)), cc.CallFunc:create(function()
				self.inputField:setVisible(false)
			end)))
			arg_6_0:loadTextures("FightLayer/btn_close_barrage.png", "FightLayer/btn_close_barrage.png", "FightLayer/btn_close_barrage.png", var_0_1)
		else
			self:stopAllActions()
			self:delayReplay(3)
			self.inputBg:stopAllActions()
			self.inputBg:runAction(cc.Sequence:create(cc.CallFunc:create(function()
				self.inputField:setVisible(true)
			end), cc.MoveTo:create(0.25, cc.p(self.inputBg:getPositionX(), 38))))
			arg_6_0:loadTextures("FightLayer/btn_open_barrage.png", "FightLayer/btn_open_barrage.png", "FightLayer/btn_open_barrage.png", var_0_1)
		end
	end)
end

function BarrageLayer:initStarRankBtn()
	self.giftRankBtn = ccui.Button:create("mainScenebg/other/gift_rank.png", "mainScenebg/other/gift_rank.png", "mainScenebg/other/gift_rank.png")

	self.giftRankBtn:setPosition(cc.p(600, GameDisplay.height - 150))
	self:addChild(self.giftRankBtn, 2)
	self.giftRankBtn:addTouchEventListener(self:getGiftRankHandel())
	self.giftRankBtn:setName("btn_star_rank")
	self.giftRankBtn:setVisible(level_manager:isPlayerPassLevel({
		chapter = 10,
		mode = 6
	}))
	self.giftRankBtn:setVisible(false)
end

function BarrageLayer:getGiftRankHandel()
	return function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("StarRankListLayer")
	end
end

function BarrageLayer:onChangeChapter(arg_12_1)
	local var_12_0, var_12_1 = arg_12_1:match("(%d+)-(%d+)")

	print("BarrageLayer onChangeChapter: ", arg_12_1, var_12_0, var_12_1)

	if tonumber(var_12_0) == 1 then
		self._inputValid = false

		self.inputBg:setVisible(false)
	else
		self._inputValid = true

		self.inputBg:setVisible(true)
	end
end

local function var_0_17()
	local var_13_0 = cc.EditBox:create(cc.size(150, 40), (config._DEBUG or nil) and (cc.Scale9Sprite:create("FightLayer/inputfieldbg.png") or cc.Scale9Sprite:createWithSpriteFrameName("FightLayer/inputfieldbg.png")))

	var_13_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_13_0:setFont(FONT_NAME, 24)
	var_13_0:setPlaceholderFont(FONT_NAME, 24)
	var_13_0:setFontSize(22)
	var_13_0:setFontColor(cc.c3b(255, 255, 255))
	var_13_0:setPlaceHolder(L_BARRAGE_MSG.Input)
	var_13_0:setPlaceholderFontColor(cc.c3b(137, 152, 160))
	var_13_0:setPlaceholderFontSize(22)
	var_13_0:setMaxLength(60)
	var_13_0:setReturnType(cc.KEYBOARD_RETURNTYPE_SEND)
	var_13_0:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
	var_13_0:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE)

	if var_0_2 then
		var_13_0:setEnabled(false)
	end

	return var_13_0
end

function BarrageLayer:addInputCom()
	self.inputPanel = ccui.Layout:create()

	self.inputPanel:setContentSize(cc.size(540, 66))
	self.inputPanel:setPosition(cc.p(self.openBtn:getPositionX() - 58, self.openBtn:getPositionY() - 40))
	self.inputPanel:setClippingEnabled(true)
	self:addChild(self.inputPanel, 1)

	self.inputBg = ccui.ImageView:create("FightLayer/bg_barrage.png", var_0_1)

	self.inputBg:setAnchorPoint(cc.p(0, 0.5))
	self.inputBg:setPosition(cc.p(92, 38))
	self.inputBg:setScaleX(0.8)
	self.inputPanel:addChild(self.inputBg)

	self.btnSend = ccui.Button:create("FightLayer/btn_send_barrage.png", "FightLayer/btn_send_barrage.png", "FightLayer/btn_send_barrage.png", var_0_1)

	self.btnSend:setAnchorPoint(cc.p(0, 0.5))
	self.btnSend:setPosition(cc.p(self.inputBg:getContentSize().width - self.btnSend:getContentSize().width, self.inputBg:getContentSize().height / 2))
	self.btnSend:setPressedActionEnabled(true)
	self.inputBg:addChild(self.btnSend)

	local var_14_0 = ccui.Layout:create()

	var_14_0:setContentSize(cc.size(150, self.inputBg:getContentSize().height))
	var_14_0:setPosition(cc.p(5, 2))
	var_14_0:setClippingEnabled(true)
	self.inputBg:addChild(var_14_0)

	self.inputField = var_0_17()

	self.inputField:setPosition(cc.p(70, self.inputBg:getContentSize().height / 2))
	var_14_0:addChild(self.inputField)

	local var_14_1 = false

	self.inputField:registerScriptEditBoxHandler(function(arg_15_0)
		if arg_15_0 == "began" then
			var_14_1 = false

			AnalyticManager.clickBarrage()
		elseif arg_15_0 == "changed" then
			var_14_1 = true
		elseif arg_15_0 == "return" then
			if var_14_1 then
				local var_15_0 = self.inputField:getText()

				if string.len(var_15_0) > 0 and barrage_manager:checkmsg(var_15_0) then
					self:sendBarrage(var_15_0, barrage_manager:checkmsg(var_15_0))
					self.inputField:setText("")
					global_ShowBlockWords(L_BARRAGE_SEND_SUCCESS)
				else
					global_ShowBlockWords(L_BARRAGE_MSG.Warning.Senstive_Word)
				end
			end

			var_14_1 = false
		end
	end)
	self.btnSend:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._sendwaiting then
			return
		end

		local var_16_0 = self.inputField:getText()

		if string.len(var_16_0) > 0 and barrage_manager:checkmsg(var_16_0) then
			self:sendBarrage(var_16_0, barrage_manager:checkmsg(var_16_0))
			self.inputField:setText("")
		else
			global_ShowBlockWords(L_BARRAGE_MSG.Warning.Senstive_Word)
		end
	end)

	self.btnGift = ccui.Button:create("FightLayer/gift_normal.png", "FightLayer/gift_normal.png", "FightLayer/gift_normal.png", var_0_1)

	self.btnGift:setAnchorPoint(cc.p(0.5, 0.5))
	self.btnGift:setPosition(cc.p(36, 276))
	self.btnGift:setName("Button_gift")
	self:addChild(self.btnGift, 4)
	self.btnGift:setVisible(level_manager:isPlayerPassLevel(UNLOCK_FIGHT_GIFT))
	self.btnGift:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopUseBarrageGiftLayer", {
			callbacl = function(...)
				self.btnGift:loadTextures("FightLayer/gift_normal.png", "FightLayer/gift_normal.png", "FightLayer/gift_normal.png", var_0_1)
			end
		})
		self.btnGift:loadTextures("FightLayer/gift_on.png", "FightLayer/gift_on.png", "FightLayer/gift_on.png", var_0_1)
	end)

	if self.openBtn.state == var_0_9 then
		self._sendwaiting = true

		self.inputField:setVisible(false)
		self.inputBg:setPositionY(-22)
		self.openBtn:loadTextures("FightLayer/btn_close_barrage.png", "FightLayer/btn_close_barrage.png", "FightLayer/btn_close_barrage.png", var_0_1)
	else
		self._sendwaiting = false

		self.inputField:setVisible(true)
		self.inputBg:setPositionY(38)
		self.openBtn:loadTextures("FightLayer/btn_open_barrage.png", "FightLayer/btn_open_barrage.png", "FightLayer/btn_open_barrage.png", var_0_1)
	end
end

function BarrageLayer:initPassLevelListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("newUnlockMode", function(arg_20_0)
		self.btnGift:setVisible(level_manager:isPlayerPassLevel({
			chapter = 10,
			mode = 6
		}))
		self:getEventDispatcher():dispatchEvent(cc.EventCustom:new("changeTopRightPos"))
	end), self)
end

local var_0_18 = cc.rect(0, 540 - GameDisplay.fix_y * (1 - 150 / GameDisplay.origin_design_y), 640, GameDisplay.height * 0.92 - (540 - GameDisplay.fix_y * (1 - 150 / GameDisplay.origin_design_y)) - GameDisplay.fix_y)

function BarrageLayer:addText(arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	local var_21_0 = cc.Label:createWithTTF(arg_21_1, FONT_DES, 28)

	var_21_0:setAnchorPoint(cc.p(0, 0.5))
	var_21_0:enableOutline(cc.c4b(35, 35, 35, 255), 2)

	if arg_21_5 then
		var_21_0:setColor(arg_21_5)
	end

	local var_21_1
	local var_21_2 = 0

	if arg_21_4 then
		var_21_1 = cc.Node:create()

		var_21_1:addChild(var_21_0)

		local var_21_3 = cc.DrawNode:create()

		var_21_3:drawPolygon({
			cc.p(-2, -var_21_0:getContentSize().height / 2 - 2),
			cc.p(-2, var_21_0:getContentSize().height / 2 + 2),
			cc.p(var_21_0:getContentSize().width + 2, var_21_0:getContentSize().height / 2 + 2),
			cc.p(var_21_0:getContentSize().width + 2, -var_21_0:getContentSize().height / 2 - 2)
		}, 4, cc.c4f(0, 0, 0, 0), 2, cc.c4f(0, 1, 0, 1))
		var_21_1:addChild(var_21_3)

		var_21_2 = 10
	else
		var_21_1 = var_21_0
	end

	var_21_1:setPosition(cc.p(640 + arg_21_2, var_0_18.y + arg_21_3))
	var_21_1:setName("text")
	self:addChild(var_21_1, var_21_2)

	local var_21_4 = 640 + var_21_1:getPositionX() + var_21_0:getContentSize().width

	var_21_1:runAction(cc.Sequence:create(cc.MoveBy:create(var_21_4 / 200, cc.p(-var_21_4, 0)), cc.RemoveSelf:create()))
end

local var_0_19 = {
	0,
	var_0_18.height / 8 * 2,
	var_0_18.height / 8 * 3,
	var_0_18.height / 8 * 4
}
local var_0_20 = {
	var_0_18.height / 8 * 2,
	var_0_18.height / 8,
	var_0_18.height / 8,
	var_0_18.height / 8 * 4
}
local var_0_21 = {
	{},
	{},
	{},
	{}
}
local var_0_22 = 25

local function var_0_23(arg_22_0)
	local var_22_0 = {}

	for iter_22_0 = 1, math.floor(var_0_20[arg_22_0] / var_0_22) do
		table.insert(var_22_0, (iter_22_0 - 1) * var_0_22 + var_0_22 / 2)
	end

	return var_22_0
end

local var_0_24 = 0
local var_0_25 = {}

for iter_0_0, iter_0_1 in ipairs({
	0,
	0,
	0,
	45
}) do
	var_0_24 = var_0_24 + iter_0_1
	var_0_25[iter_0_0] = var_0_24
end

local function var_0_26(arg_23_0)
	local var_23_0 = var_0_21[arg_23_0]

	if #var_0_21[arg_23_0] == 0 then
		var_23_0 = var_0_23(arg_23_0)
	end

	var_0_21[arg_23_0] = var_23_0

	return #var_23_0 == 1 and table.remove(var_23_0, 1) or table.remove(var_23_0, (math.random(1, #var_23_0)))
end

local function var_0_27()
	local var_24_0 = math.random(1, var_0_24)

	for iter_24_0, iter_24_1 in ipairs(var_0_25) do
		if var_24_0 <= iter_24_1 then
			return iter_24_0
		end
	end

	return 4
end

local function var_0_28(arg_25_0)
	return var_0_19[arg_25_0] + var_0_26(arg_25_0)
end

function BarrageLayer:sendBarrage(arg_26_1, arg_26_2)
	if self._playing ~= var_0_10 then
		return
	end

	arg_26_1 = string.gsub(arg_26_1, "[#\\\t\n\b\f\r]+", "")

	if utf8.len(arg_26_1) > 20 then
		global_ShowBlockWords(L_BARRAGE_MSG.Warning.Out_Length)

		return
	end

	self:addText(arg_26_1, 240, var_0_28(4), true)

	if arg_26_2 then
		barrage_manager:syncBarrageToServer(arg_26_1)
	end

	self:delayWaitSend(3)
end

function BarrageLayer:pushBarrageData(arg_27_1, arg_27_2)
	if self._playing ~= var_0_10 then
		return
	end

	for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
		self:addText(iter_27_1, 120 * iter_27_0, var_0_28(var_0_27()))
	end

	self:delayGetNext(arg_27_2 and 180 or 6)
end

function BarrageLayer:delayGetNext(arg_28_1)
	self:stopActionByTag(var_0_13)

	local var_28_0 = cc.Sequence:create(cc.DelayTime:create(arg_28_1), cc.CallFunc:create(function()
		if self._playing ~= var_0_10 then
			return
		end

		barrage_manager:start()
	end))

	var_28_0:setTag(var_0_13)
	self:runAction(var_28_0)
end

function BarrageLayer:delayReplay(arg_30_1)
	self._playing = var_0_11

	self:stopActionByTag(var_0_12)

	local var_30_0 = cc.Sequence:create(cc.DelayTime:create(arg_30_1), cc.CallFunc:create(function()
		if self._playing == var_0_9 then
			return
		end

		self._sendwaiting = false
		self._playing = var_0_10

		barrage_manager:start()
	end))

	var_30_0:setTag(var_0_12)
	self:runAction(var_30_0)
end

function BarrageLayer:delayWaitSend(arg_32_1)
	self._sendwaiting = true

	self:runAction(cc.Sequence:create(cc.DelayTime:create(arg_32_1), cc.CallFunc:create(function()
		self._sendwaiting = false
	end)))
end

function BarrageLayer:resumeBarrage()
	if self.openBtn.state ~= var_0_10 then
		return
	end

	self:stopAllActions()
	self:delayReplay(3)
end

function BarrageLayer:stopBarrage()
	if self._playing == var_0_9 then
		return
	end

	self:stopActionByTag(var_0_13)
	self:stopActionByTag(var_0_12)
	self:cleanAllText()

	self._playing = var_0_9
end

function BarrageLayer:cleanAllText()
	for iter_36_0, iter_36_1 in pairs(self:getChildren()) do
		if iter_36_1:getName() == "text" then
			iter_36_1:removeFromParent()
		end
	end
end

function BarrageLayer:showBarrageGiftEffect(arg_37_1, arg_37_2, arg_37_3, arg_37_4, arg_37_5, arg_37_6, arg_37_7, arg_37_8)
	self.effectUseSp = self.effectUseSp or {}
	self.effectUseSp[arg_37_1] = self.effectUseSp[arg_37_1] or self:createEffectUseSp()

	self.effectUseSp[arg_37_1]:update(arg_37_1, arg_37_2, arg_37_3, arg_37_4, arg_37_5)
	self.effectUseSp[arg_37_1]:stopAllActions()
	self.effectUseSp[arg_37_1]:runCountDown(arg_37_8)

	if barrage_manager:isShowSpinEffect(arg_37_7) then
		self:createEffectPanel()

		if item_data[arg_37_2].barrage_spine then
			self:runSpineEffect(arg_37_2, arg_37_6)

			if item_data[arg_37_2].sound then
				audio_manager:playeffectMusicTest("sound/" .. item_data[arg_37_2].sound)
			end
		end
	end
end

function BarrageLayer:createEffectPanel()
	if not self.effectPanel then
		self.effectPanel = ccui.Layout:create()

		self.effectPanel:setTouchEnabled(false)
		self.effectPanel:setContentSize(cc.size(self:getContentSize().width, self:getContentSize().height))
		self.effectPanel:setAnchorPoint(cc.p(0.5, 0.5))
		self.effectPanel:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
		self.effectPanel:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
		self:addChild(self.effectPanel, var_0_15)
	end
end

function BarrageLayer:getPos()
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

	for iter_39_0, iter_39_1 in pairs(self.posPool) do
		if iter_39_1.count == 0 then
			iter_39_1.count = iter_39_1.count + 1

			return iter_39_0, iter_39_1.posy
		end
	end

	return 1, self.posPool[1].posy
end

function BarrageLayer:createEffectUseSp()
	local var_40_0, var_40_1 = self:getPos()
	local var_40_2 = ccui.ImageView:create("mainScenebg/barrage/use_barrage_gift_bg.png")

	var_40_2:setAnchorPoint(cc.p(0, 0.5))
	var_40_2:setPosition(cc.p(0, var_40_1))

	var_40_2.idx = var_40_0

	self:addChild(var_40_2, var_0_16)

	local var_40_3 = cc.Label:createWithTTF("", FONT_DES, 22)

	var_40_3:setAnchorPoint(cc.p(0, 0.5))
	var_40_3:setPosition(cc.p(10, var_40_2:getContentSize().height / 2 + 15))
	var_40_3:setName("namelabel")
	var_40_2:addChild(var_40_3)

	local var_40_4 = cc.Label:createWithTTF(L_SEND_GIFT, FONT_DES, 18)

	var_40_4:setAnchorPoint(cc.p(0, 0.5))
	var_40_4:setPosition(cc.p(55, var_40_2:getContentSize().height / 2 - 15))
	var_40_4:setName("label2")
	var_40_2:addChild(var_40_4)

	local var_40_5 = cc.Label:createWithTTF("", FONT_DES, 20)

	var_40_5:setAnchorPoint(cc.p(0, 0.5))
	var_40_5:setPosition(cc.p(10, var_40_2:getContentSize().height / 2 - 15))
	var_40_5:setColor(cc.c3b(242, 191, 67))
	var_40_5:setName("itemlabel")
	var_40_2:addChild(var_40_5)

	local var_40_6 = ccui.ImageView:create("roleimage/role/wuji/100.png")

	var_40_6:setPosition(cc.p(var_40_2:getContentSize().width - 50, var_40_2:getContentSize().height / 2 + 10))
	var_40_6:setName("itemImg")
	var_40_6:setScale(0.5)
	var_40_2:addChild(var_40_6)

	local var_40_7 = ccui.TextBMFont:create("x1", "fonts/barrage_gift.fnt")

	var_40_7:setName("countlabel")
	var_40_7:setScale(1)
	var_40_7:setAnchorPoint(cc.p(0.5, 0.5))
	var_40_7:setPosition(cc.p(var_40_2:getContentSize().width + 30, var_40_2:getContentSize().height / 2 + 18))
	var_40_2:addChild(var_40_7)

	function var_40_2:update(arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5)
		self:setOpacity(255)
		self:getChildByName("namelabel"):setString(arg_41_3)
		self:getChildByName("itemlabel"):setString(item_data[arg_41_2].name)
		self:getChildByName("label2"):setPositionX(self:getChildByName("itemlabel"):getPositionX() + self:getChildByName("itemlabel"):getContentSize().width)

		if item_data[arg_41_2].title_spine then
			self:getChildByName("itemImg"):setVisible(false)

			if self.id ~= arg_41_1 then
				if self:getChildByName("title_spine") then
					self:getChildByName("title_spine"):removeFromParent()
				end

				local var_41_0 = self:getChildByName("title_spine")
				local var_41_1 = L2Skeleton:create("spine/barrage/" .. item_data[arg_41_2].title_spine .. ".json", "spine/barrage/" .. item_data[arg_41_2].title_spine .. ".atlas")

				var_41_1:refreshSkeleton()
				var_41_1.skeletonAnimation:setPosition(cc.p(self:getChildByName("itemImg"):getPositionX(), 0))
				var_41_1:play(item_data[arg_41_2].title_spine, true)
				var_41_1:setScale(item_data[arg_41_2].title_spine_scale, item_data[arg_41_2].title_spine_scale)
				var_41_1:setName("title_spine")
				var_40_2:addChild(var_41_1)
			end
		else
			if self:getChildByName("title_spine") then
				self:getChildByName("title_spine"):runAction(cc.RemoveSelf:create())
			end

			self:getChildByName("itemImg"):setVisible(true)
			self:getChildByName("itemImg"):loadTexture("mainScenebg/barrage/" .. item_data[arg_41_2].image_id .. ".png")
			self:getChildByName("itemImg"):setScale(item_data[arg_41_2].title_img_scale)
		end

		if arg_41_5 > 1 then
			self:getChildByName("countlabel"):setScale(3)
			self:getChildByName("countlabel"):setOpacity(0)
			self:getChildByName("countlabel"):stopAllActions()
			self:getChildByName("countlabel"):runAction(cc.Spawn:create(cc.ScaleTo:create(0.1, 1, 1), cc.FadeIn:create(0.1)))
		end

		var_40_7:setString("x" .. arg_41_5)

		self.id = arg_41_1
	end

	function var_40_2:runCountDown(arg_42_1)
		self:runAction(cc.Sequence:create(cc.DelayTime:create(4), cc.FadeOut:create(1), cc.RemoveSelf:create(), cc.CallFunc:create(function(...)
			self.posPool[self.idx].count = 0
			self.effectUseSp[self.id] = nil

			if arg_42_1 then
				arg_42_1()
			end
		end)))
	end

	return var_40_2
end

function BarrageLayer:updateSaluteAwardTime(arg_44_1, arg_44_2)
	if not self.salutAward then
		self.salutAward = ccui.ImageView:create("FightLayer/salute_award.png", var_0_1)

		self.salutAward:setPosition(self:getSalutAwardPos())
		self:addChild(self.salutAward)
		self.salutAward:setTouchEnabled(true)
		self.salutAward:addTouchEventListener(function(arg_45_0, arg_45_1)
			if arg_45_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_45_0.time > 0 then
				global_ShowBlockWords("尚未开奖")

				return
			end

			barrage_manager:showGetItems()
			self.salutAward:setVisible(false)
		end)

		local var_44_0 = cc.Label:createWithTTF("", FONT_DES, 22)

		var_44_0:setPosition(cc.p(self.salutAward:getContentSize().width / 2, 12))
		var_44_0:setName("timeLabel")
		self.salutAward:addChild(var_44_0)
	end

	self.salutAward.time = arg_44_2

	self.salutAward:getChildByName("timeLabel"):setString("00:" .. string.format("%02d", self.salutAward.time))
	self.salutAward:stopAllActions()
	self.salutAward:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		self.salutAward.time = self.salutAward.time - 1

		if self.salutAward.time < 0 then
			self.salutAward.time = 0

			self.salutAward:getChildByName("timeLabel"):setString("可领取")
		else
			self.salutAward:getChildByName("timeLabel"):setString("00:" .. string.format("%02d", self.salutAward.time))
		end
	end))))
end

function BarrageLayer:setSalutePanelVisible(arg_47_1)
	if not self.salutAward then
		return
	end

	self.salutAward:setVisible(arg_47_1)
end

function BarrageLayer:runSpineEffect(arg_48_1, arg_48_2)
	if arg_48_2 == playermodel.playerid then
		if self.effectspine then
			self.effectspine:removeFromParent()

			self.effectspine = nil
		end
	elseif self.effectspine then
		return
	end

	self.effectspine = L2Skeleton:create("spine/barrage/" .. item_data[arg_48_1].barrage_spine .. ".json", "spine/barrage/" .. item_data[arg_48_1].barrage_spine .. ".atlas")

	self.effectspine:refreshSkeleton()
	self.effectspine.skeletonAnimation:setPosition(cc.p(320, 420 - 100 * (GameDisplay.height - 1136) / 208))
	self.effectspine.skeletonAnimation:setPosition(cc.p(320, 420 + GameDisplay.fix_y))
	self.effectspine:play(item_data[arg_48_1].barrage_spine, false)
	self.effectPanel:addChild(self.effectspine, 10000)
	self.effectspine:registerListener(SP_ANIMATION_COMPLETE, function(arg_49_0)
		self.effectspine:runAction(cc.Sequence:create(cc.RemoveSelf:create(), cc.CallFunc:create(function(...)
			self.effectspine = nil
		end)))
	end)
end

function BarrageLayer:initBatchColorBarrageListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("playbatchcolorbarrage", function(arg_52_0)
		print("Dispatch playbatchcolorbarrage!!!!!")
		self:startPlayBatchColorBarrage()
	end), self)
end

function BarrageLayer:startPlayBatchColorBarrage()
	if self._colorscheduler then
		return
	end

	local function var_53_0(arg_54_0, arg_54_1)
		if self._playing == var_0_9 then
			return
		end

		self:addText(arg_54_0[1], 60 + 20 * (8 - arg_54_1), var_0_18.height / 3 + var_0_18.height / 12 * arg_54_1, nil, arg_54_0[2])
	end

	local var_53_1, var_53_2 = barrage_manager:dequeueBatchColorBarrage(2)

	if var_53_1 then
		for iter_53_0, iter_53_1 in pairs(var_53_2) do
			var_53_0(iter_53_1, iter_53_0)
		end
	else
		return
	end

	self._colorscheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_55_0)
		local var_55_0, var_55_1 = barrage_manager:dequeueBatchColorBarrage(2)

		if var_55_0 then
			for iter_55_0, iter_55_1 in pairs(var_55_1) do
				var_53_0(iter_55_1, iter_55_0)
			end
		else
			self:stopPlayBatchColorBarrage()
		end
	end, 2, false)
end

function BarrageLayer:stopPlayBatchColorBarrage()
	if not self._colorscheduler then
		return
	end

	cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._colorscheduler)

	self._colorscheduler = nil
end

function BarrageLayer:updateNianshouEntrance()
	local spring_manager = require("controller.spring_manager")

	if self:checkIsShowNianshou() then
		if not self.nianshou then
			self.nianshou = ccui.Button:create("mainScenebg/activity/branch100/nianshou_enter.png", nil, "mainScenebg/activity/branch100/nianshou_enter.png")

			self.nianshou:setPosition(cc.p(50, 560 - GameDisplay.fix_y))
			self:addChild(self.nianshou)
			self.nianshou:addTouchEventListener(function(arg_58_0, arg_58_1)
				if arg_58_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_58_0.isLock then
					return
				end

				arg_58_0.isLock = true

				spring_manager:get_nianshou_info(function(arg_59_0)
					if arg_59_0.result == 1 then
						LayerManager:pushInLayer("ActivityNianShou", arg_59_0)
					end

					arg_58_0.isLock = false
				end)
			end)
		end

		if self.salutAward then
			self.salutAward:setPosition(self:getSalutAwardPos())
		end
	elseif self.nianshou then
		self.nianshou:removeFromParent()

		self.nianshou = nil

		if self.salutAward then
			self.salutAward:setPosition(self:getSalutAwardPos())
		end
	end
end

function BarrageLayer:checkIsShowNianshou()
	local time_check_manager = require("controller.time_check_manager")
	local var_60_1 = require("controller.activity_manager"):getActivityObj(100)

	if not var_60_1 then
		return false
	end

	if var_60_1:getStatus() ~= 2 then
		return false
	end

	local var_60_2 = require("controller.spring_manager"):getSystemTime()

	if not var_60_2 then
		return false
	end

	if not var_60_2[4] then
		return false
	end

	if time_check_manager:getCurTime() < os.time(parse_time(var_60_2[4].starttime)) then
		return false
	end

	if time_check_manager:getCurTime() > os.time(parse_time(var_60_2[4].finishtime)) then
		return false
	end

	if time_check_manager:getCurTime() > os.time(parse_time(require("data.activity_springfestival_data")[4].sp_entrance_endtime)) then
		return false
	end

	return true
end

function BarrageLayer:getSalutAwardPos()
	if self:checkIsShowNianshou() then
		return cc.p(580, 580 - GameDisplay.fix_y)
	else
		return cc.p(580, 580 - GameDisplay.fix_y)
	end
end

return BarrageLayer

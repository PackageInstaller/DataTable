DialogLayer = class("DialogLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local var_0_1 = 35
local var_0_2 = {
	[L_DIALOG_TITLE[1]] = "title_iffline",
	[L_DIALOG_TITLE[2]] = "title_remote_login",
	[L_DIALOG_TITLE[3]] = "title_account_exception",
	[L_DIALOG_TITLE[4]] = "title_check_network",
	[L_DIALOG_TITLE[5]] = "title_update",
	[L_DIALOG_TITLE[6]] = "title_quitgame",
	[L_DIALOG_TITLE[7]] = "title_switchaccount"
}

function DialogLayer.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8)
	local var_2_0 = DialogLayer.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8)

	return var_2_0
end

local var_0_3 = 10

function DialogLayer:initUI(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = 221
	local var_3_1 = ccui.Button:create("guide/guidShade.png", "guide/guidShade.png")

	var_3_1:setScale(GameDisplay.width / var_3_1:getContentSize().width, GameDisplay.height / var_3_1:getContentSize().height)
	var_3_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	self.rootLayer:addChild(var_3_1)

	if arg_3_3 then
		var_3_1:addTouchEventListener(function(arg_4_0, arg_4_1)
			self:cancelCallback(arg_4_0, arg_4_1)
		end)
	end

	self.boxBg = cc.Layer:create()

	self.boxBg:setContentSize(cc.size(554, var_3_0))

	local var_3_2 = self.boxBg:getContentSize().width
	local var_3_3 = self.boxBg:getContentSize().height

	self.boxBg:setPosition((GameDisplay.width - var_3_2) / 2, (GameDisplay.height - var_3_3) / 2)
	self.rootLayer:addChild(self.boxBg, 1)

	local var_3_4

	if config._DEBUG then
		var_3_4 = cc.Scale9Sprite:create("public/panelbg/popup_bg_new.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/panelbg/popup_bg_new.png")
	end

	var_3_4:setPosition(var_3_2 / 2, var_3_3 / 2)
	self.imageTitle:setPosition(-4, var_3_3 + 48)

	local var_3_5 = -var_0_1

	for iter_3_0 = 1, #self.msg do
		var_3_5 = var_3_5 + self.msg[iter_3_0]:getContentSize().height + var_0_1
	end

	local var_3_6 = ccui.ScrollView:create()

	var_3_6:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_6:setContentSize(cc.size(554, var_3_0 - 130))

	if var_3_5 < var_3_0 - 130 then
		for iter_3_1 = 1, #self.msg do
			self.msg[iter_3_1]:setPosition(var_3_6:getContentSize().width / 2, var_3_6:getContentSize().height / 2 + 15)
		end

		var_3_6:setInnerContainerSize(cc.size(554, var_3_0 - 130))
		var_3_6:setInertiaScrollEnabled(false)
		var_3_6:setBounceEnabled(false)
	else
		for iter_3_2 = 1, #self.msg do
			self.msg[iter_3_2]:setPosition(var_3_6:getContentSize().width / 2, var_3_6:getContentSize().height / 2 + 15)
		end

		var_3_6:setInnerContainerSize(cc.size(554, var_3_5))
		var_3_6:setInertiaScrollEnabled(true)
		var_3_6:setBounceEnabled(true)
	end

	var_3_6:setDirection(1)
	var_3_6:setPosition(cc.p(var_3_2 / 2, var_3_3 / 2))

	for iter_3_3 = 1, #self.msg do
		var_3_6:addChild(self.msg[iter_3_3])
	end

	self.boxBg:addChild(var_3_6, 10)
	self.boxBg:addChild(var_3_4, 5)
	self.boxBg:addChild(self.imageTitle, 10)

	if arg_3_4 and arg_3_4 == 2 then
		local var_3_7 = ccui.Button:create("public/button/UI_public_button_6.png", nil, "public/button/UI_public_button_off.png", config._DEBUG and 0 or 1)

		var_3_7:setAnchorPoint(cc.p(0.5, 0.5))
		var_3_7:setPosition(var_3_4:getContentSize().width - var_3_7:getContentSize().width / 2 - 20, 58)
		var_3_7:addTouchEventListener(function(arg_5_0, arg_5_1)
			self:cancelCallback(arg_5_0, arg_5_1)
		end)
		var_3_7:setScale(0.9)
		var_3_4:addChild(var_3_7, 10)

		local var_3_8 = cc.Label:createWithTTF(L_BUTTON_TEXT.Continue, "fonts/newkj.ttf", 32)

		var_3_8:setPosition(var_3_7:getContentSize().width / 2, var_3_7:getContentSize().height * 0.5 + 13)
		var_3_7:addChild(var_3_8)

		local var_3_9 = ccui.Button:create("public/button/public_button_orange_big.png", nil, "public/button/public_button_orange_big.png", config._DEBUG and 0 or 1)

		var_3_9:setAnchorPoint(cc.p(0.5, 0.5))
		var_3_9:setPosition(var_3_9:getContentSize().width / 2 + 20, 58)
		var_3_9:addTouchEventListener(function(arg_6_0, arg_6_1)
			self:sureCallback(arg_6_0, arg_6_1)
		end)
		var_3_9:setScale(0.9)
		var_3_4:addChild(var_3_9, 10)

		local var_3_10 = cc.Label:createWithTTF(L_BUTTON_TEXT.Sure, "fonts/newkj.ttf", 32)

		var_3_10:setColor(cc.c3b(182, 189, 203))
		var_3_10:setPosition(var_3_9:getContentSize().width / 2, var_3_9:getContentSize().height / 2 + 13)
		var_3_9:addChild(var_3_10)
	else
		local var_3_11 = ccui.Button:create("public/button/UI_public_button_6.png", nil, "public/button/UI_public_button_6.png", config._DEBUG and 0 or 1)

		var_3_11:setPosition(var_3_4:getContentSize().width - var_3_11:getContentSize().width / 2 - 3, var_3_4:getContentSize().height - var_3_11:getContentSize().height / 2 - 3)
		var_3_11:addTouchEventListener(function(arg_7_0, arg_7_1)
			self:cancelCallback(arg_7_0, arg_7_1)
		end)
		var_3_4:addChild(var_3_11, 10)
		var_3_11:setVisible(false)

		local var_3_12 = ccui.Button:create("public/button/public_button_orange_big.png", nil, "public/button/public_button_orange_big.png", config._DEBUG and 0 or 1)

		var_3_12:setPosition(var_3_4:getContentSize().width / 2, -50)
		var_3_12:addTouchEventListener(function(arg_8_0, arg_8_1)
			self:sureCallback(arg_8_0, arg_8_1)
		end)
		var_3_12:setScale9Enabled(true)
		var_3_12:setCapInsets(cc.rect(50, 20, 2, 2))
		var_3_12:setContentSize(cc.size(400, 80))
		var_3_4:addChild(var_3_12, 10)

		local var_3_13 = cc.Label:createWithTTF(L_BUTTON_TEXT.Sure, "fonts/newkj.ttf", 32)

		var_3_13:setColor(cc.c3b(42, 42, 42))
		var_3_13:setPosition(var_3_12:getContentSize().width / 2, var_3_12:getContentSize().height / 2 + 13)
		var_3_12:addChild(var_3_13)
	end
end

function DialogLayer:init(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7, arg_9_8)
	self.rootLayer = cc.Layer:create()

	self.rootLayer:setCascadeOpacityEnabled(true)
	self:addChild(self.rootLayer)

	if type(arg_9_1) == "string" then
		self.imageTitle = ccui.ImageView:create("public/panelbg/" .. var_0_2[arg_9_1] .. ".png", var_0_0)

		self.imageTitle:setAnchorPoint(0, 1)
	elseif arg_9_1 ~= nil then
		self.imageTitle = arg_9_1
	else
		self.imageTitle = ccui.ImageView:create("public/panelbg/title_default.png", var_0_0)

		self.imageTitle:setAnchorPoint(0, 1)
	end

	self.msg = {}

	if type(arg_9_2) == "string" then
		self.msg[1] = cc.Label:createWithTTF(arg_9_2, "fonts/name.ttf", 28)

		self.msg[1]:setColor(cc.c3b(218, 231, 246))
		self.msg[1]:setMaxLineWidth(arg_9_3 - 120)
		self.msg[1]:setAnchorPoint(cc.p(0.5, 0.5))
	elseif type(arg_9_2) == "table" then
		local var_9_0 = ""

		for iter_9_0 = 1, #arg_9_2 do
			var_9_0 = var_9_0 .. arg_9_2[iter_9_0]
		end

		self.msg[1] = cc.Label:createWithTTF(var_9_0, "fonts/name.ttf", 28)

		self.msg[1]:setColor(cc.c3b(218, 231, 246))
		self.msg[1]:setMaxLineWidth(arg_9_3 - 120)
		self.msg[1]:setAnchorPoint(cc.p(0.5, 0.5))
	else
		self.msg[1] = arg_9_2
	end

	self.sureOutCallback = arg_9_5
	self.cancelOutCallback = arg_9_6

	self:initUI(arg_9_3, arg_9_4, arg_9_7, arg_9_8)

	local var_9_1, var_9_2 = self.boxBg:getPosition()

	self.boxBg:setPosition(var_9_1, var_9_2 + var_0_3)
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.FadeTo:create(0.2, 255))
	self.boxBg:runAction(cc.MoveTo:create(0.2, cc.p(var_9_1, var_9_2)))

	return true
end

function DialogLayer:removeSelf()
	self.rootLayer:runAction(cc.FadeTo:create(0.2, 0))
	self.boxBg:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(0, var_0_3)), cc.CallFunc:create(function()
		self:removeFromParent()
	end)))
end

function DialogLayer:cancelCallback(arg_12_1, arg_12_2)
	if not arg_12_1:isBright() then
		return
	end

	if arg_12_2 == ccui.TouchEventType.ended then
		if self.cancelOutCallback then
			self.cancelOutCallback()
		end

		self:removeSelf()
		arg_12_1:setBright(false)
	end
end

function DialogLayer:sureCallback(arg_13_1, arg_13_2)
	if not arg_13_1:isBright() then
		return
	end

	if arg_13_2 == ccui.TouchEventType.ended then
		if self.sureOutCallback then
			self.sureOutCallback()
		end

		self:removeSelf()
		arg_13_1:setBright(false)
	end
end

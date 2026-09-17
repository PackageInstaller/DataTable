local var_0_0 = l2d.LAppLive2DManager:getInstance()
local conversation_data = require("data.conversation_data")
local DialogSprite = require("view.Sprite.DialogSprite")

ModelTalkLayer = class("ModelTalkLayer", function()
	return cc.Layer:create()
end)

function ModelTalkLayer:ctor()
	local var_2_0 = cc.EventListenerTouchOneByOne:create()

	var_2_0:registerScriptHandler(function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_0:getLocation()

		print("hhhhhhhhhhhhhhhh")

		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_2_0:registerScriptHandler(function(arg_4_0, arg_4_1)
		if not self.waitPrintText then
			self:Say()
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_2_0, self)
	setLive2dTouchEnable(var_0_0, false)
end

function ModelTalkLayer.init(arg_5_0)
	arg_5_0.finishCallBack = false
	arg_5_0.talkContent = {}
	arg_5_0.waitPrintText = false
end

function ModelTalkLayer.create(arg_6_0, arg_6_1)
	local var_6_0 = ModelTalkLayer.new()

	var_6_0:init()

	return var_6_0
end

function ModelTalkLayer:SetTalkLayer(arg_7_1, arg_7_2)
	if not arg_7_1 and not ModelTalkLayer then
		return
	end

	self.finishCallBack = arg_7_2
	self.talkContent = {}

	for iter_7_0, iter_7_1 in pairs(conversation_data) do
		if iter_7_1.classification == arg_7_1 then
			table.insert(self.talkContent, iter_7_1)
		end
	end

	table.sort(self.talkContent, function(arg_8_0, arg_8_1)
		return arg_8_0.id < arg_8_1.id
	end)
	self:Say()
end

function ModelTalkLayer:Say()
	if not self.talkContent then
		return
	end

	if #self.talkContent < 1 then
		if self.finishCallBack then
			self.finishCallBack()

			self.finishCallBack = false
		end

		return
	end

	local var_9_0 = self:getChildByName("boxDialog")

	if var_9_0 then
		var_9_0:removeFromParent()
	end

	PRIORITY_FORCE = 3

	var_0_0:doModelMotion("player", self.talkContent[1].showName, self.talkContent[1].icon, PRIORITY_FORCE)
	DialogSprite:addBox(self, self.talkContent[1].dec, 460, 330, 0, function()
		self.waitPrintText = false
	end)

	self.waitPrintText = true

	table.remove(self.talkContent, 1)
end

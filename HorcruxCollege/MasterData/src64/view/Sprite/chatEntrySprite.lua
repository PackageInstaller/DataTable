local chatEntrySP = class("chatEntrySP", function()
	return ccui.Layout:create()
end)
local activity_manager = require("controller.activity_manager")
local chat_system_manager = require("controller.chat_system_manager")
local community_system_manager = require("controller.community_system_manager")
local var_0_4
local var_0_5 = config._DEBUG and 0 or 1
local var_0_6 = "chat_system_layer/btn_chat_enter.png"
local var_0_7 = "public/reddot/reddot2.png"
local var_0_8 = {
	low = 370 - GameDisplay.fix_y,
	up = 870 + GameDisplay.fix_y
}
local var_0_9 = {
	R = 575,
	L = 0
}
local var_0_10 = cc.p(var_0_9.L, var_0_8.low + (var_0_8.up - var_0_8.low) / 4)

function chatEntrySP:create()
	local var_2_0 = chatEntrySP.new()

	var_2_0:init()

	return var_2_0
end

function chatEntrySP:ctor()
	self:setContentSize(cc.size(110, 127))
	self:setTouchEnabled(true)
	self:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
end

function chatEntrySP:init()
	var_0_4 = self

	self:initEnrty()
	chat_system_manager:get_chat_data()
	self:registerActivityEventListener()

	self.istouchopen = true

	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_4 = nil

			activity_manager:releaseEventListenerByName("chatEntrySP")
		end
	end)
end

function chatEntrySP:registerActivityEventListener()
	activity_manager:registerEventListener("chatEntrySP", activity_manager.activityEventId.HAVE_PRIVATE_CHATE_DATA, function(arg_7_0)
		if arg_7_0.info.private_new then
			self:getChildByName("reddot"):setVisible(true)
		else
			self:getChildByName("reddot"):setVisible(false)
		end
	end)
	activity_manager:registerEventListener("chatEntrySP", activity_manager.activityEventId.UPATATE_COMMITY_CHATE_DATA, function(arg_8_0)
		if arg_8_0.list and next(arg_8_0.list) and LayerManager:getCurrentLayerName() ~= "PopChatInterfaceLayer" then
			self:getChildByName("reddot"):setVisible(true)
		else
			self:getChildByName("reddot"):setVisible(false)
		end

		if var_0_4 and var_0_4:getChildByName("bgPanel") then
			var_0_4:updateScrollChat(community_system_manager:getLastChatStr())
		end
	end)
end

function chatEntrySP:initEnrty()
	local var_9_0

	if config._DEBUG then
		var_9_0 = cc.Sprite:create(var_0_6) or cc.Sprite:createWithSpriteFrameName(var_0_6)
	end

	var_9_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_9_0:setPosition(cc.p(var_9_0:getContentSize().width / 2, var_9_0:getContentSize().height / 2))
	var_9_0:setName("chatentrysp")
	self:addChild(var_9_0, 1)

	local var_9_1 = ccui.ImageView:create(var_0_7, var_0_5)

	var_9_1:setPosition(cc.p(var_9_0:getContentSize().width - 6, var_9_0:getContentSize().height - 10))
	var_9_1:setName("reddot")
	self:addChild(var_9_1, 2)
	var_9_1:setVisible(false)
	self:setPosition(var_0_10)
	self:setContentSize(cc.size(var_9_0:getContentSize().width, var_9_0:getContentSize().height))

	local var_9_2 = cc.EventListenerTouchOneByOne:create()

	var_9_2:setSwallowTouches(false)
	var_9_2:registerScriptHandler(function(arg_10_0, arg_10_1)
		if LayerManager:getCurrentLayerName() ~= "FightLayer" and LayerManager:getCurrentLayerName() ~= "CommunityMainLayer" then
			return false
		end

		if not self:isVisible() then
			return
		end

		if not self.istouchopen then
			return
		end

		var_9_0:setScale(1.01)

		local var_10_0 = var_9_0:getContentSize()

		if cc.rectContainsPoint(cc.rect(0, 0, var_10_0.width, var_10_0.height), (var_9_0:convertToNodeSpace((arg_10_0:getLocation())))) then
			return true
		else
			var_9_0:setScale(1)

			return false
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_9_2:registerScriptHandler(function(arg_11_0, arg_11_1)
		if var_0_4 and var_0_4:getChildByName("bgPanel") then
			return
		end

		local var_11_0 = self:getParent():convertToNodeSpace((arg_11_0:getLocation()))

		self:setPosition(cc.p(var_11_0.x - 20, var_11_0.y - 20))

		if self:getPositionY() < var_0_8.low then
			self:setPositionY(var_0_8.low)
		end

		if self:getPositionY() > var_0_8.up then
			self:setPositionY(var_0_8.up)
		end

		if self:getPositionX() < var_0_9.L then
			self:setPositionX(var_0_9.L)
		end

		if self:getPositionX() > var_0_9.R then
			self:setPositionX(var_0_9.R)
		end

		return true
	end, cc.Handler.EVENT_TOUCH_MOVED)
	var_9_2:registerScriptHandler(function(arg_12_0, arg_12_1)
		local var_12_0 = cc.CallFunc:create(function()
			self.istouchopen = false
		end)
		local var_12_1 = cc.CallFunc:create(function()
			self.istouchopen = true
		end)

		if self:getPositionX() >= GameDisplay.width / 2 then
			self:runAction(cc.Sequence:create(var_12_0, cc.EaseBackInOut:create((cc.MoveTo:create(1, cc.p(var_0_9.R, self:getPositionY())))), var_12_1))
		else
			self:runAction(cc.Sequence:create(var_12_0, cc.EaseBackInOut:create((cc.MoveTo:create(1, cc.p(var_0_9.L, self:getPositionY())))), var_12_1))
		end

		var_9_0:setScale(1)

		local var_12_2 = var_9_0:getContentSize()

		if cc.rectContainsPoint(cc.rect(0, 0, var_12_2.width, var_12_2.height), (var_9_0:convertToNodeSpace((arg_12_0:getLocation())))) then
			local var_12_3 = arg_12_0:getLocation()
			local var_12_4 = arg_12_0:getPreviousLocation()

			local function var_12_5()
				self:getChildByName("reddot"):setVisible(false)
			end

			if var_12_3.x == var_12_4.x and var_12_3.y == var_12_4.y and (self:getPositionX() == var_0_9.L or self:getPositionX() == var_0_9.R) then
				if LayerManager:getCurrentLayerName() ~= "PopChatInterfaceLayer" then
					LayerManager:pushInLayer("PopChatInterfaceLayer", {
						callback = var_12_5,
						topbtnindex = self:getChildByName("chatentrysp") and 2 or 1
					})
				end

				if var_0_4 then
					self:getChildByName("reddot"):setVisible(false)
				end
			end
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_9_0:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_9_2, var_9_0)
end

function chatEntrySP:initScrollChat()
	if config._DEBUG then
		self:getChildByName("chatentrysp"):setTexture("chat_system_layer/btn_chat_enter2.png")
	else
		self:getChildByName("chatentrysp"):setSpriteFrame("chat_system_layer/btn_chat_enter2.png")
	end

	self:setContentSize(cc.size(self:getChildByName("chatentrysp"):getContentSize().width, self:getChildByName("chatentrysp"):getContentSize().height))
	self:setPosition(cc.p(var_0_9.L, var_0_8.low - 60))

	local var_16_0 = ccui.Layout:create()

	var_16_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_16_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_16_0:setBackGroundColorOpacity(200)
	var_16_0:setContentSize(cc.size(410, self:getContentSize().height + 10))
	var_16_0:setPosition(0, 10)
	var_16_0:setName("bgPanel")
	var_16_0:setTouchEnabled(true)
	self:addChild(var_16_0, -1)
	var_16_0:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if LayerManager:getCurrentLayerName() ~= "PopChatInterfaceLayer" then
			LayerManager:pushInLayer("PopChatInterfaceLayer", {
				callback = callback,
				topbtnindex = self:getChildByName("chatentrysp") and 2 or 1
			})
		end

		if var_0_4 then
			self:getChildByName("reddot"):setVisible(false)
		end
	end)

	local var_16_1 = self:getChildByName("chatentrysp")
	local var_16_2 = var_16_0:getContentSize().height / 2
	local var_16_3 = cc.Label:createWithTTF("[社团]", FONT_NAME, 18)

	var_16_3:setColor(cc.c3b(74, 200, 47))
	var_16_3:setAnchorPoint(cc.p(0, 0.5))
	var_16_3:setPosition(var_16_1:getPositionX() + var_16_1:getContentSize().width / 2 + 4, var_16_2)
	var_16_0:addChild(var_16_3)

	local var_16_4 = cc.Label:createWithTTF("", FONT_NAME, 18)

	var_16_4:setPosition(var_16_3:getPositionX() + var_16_3:getContentSize().width, var_16_2)
	var_16_4:setAnchorPoint(cc.p(0, 0.5))
	var_16_4:setName("label2")
	var_16_0:addChild(var_16_4)
	self:initCommunityChatData()
end

function chatEntrySP:initCommunityChatData()
	local function var_18_0(arg_19_0)
		if arg_19_0 == 1 then
			self:updateScrollChat(community_system_manager:getLastChatStr())
		end
	end

	if community_system_manager:getCurfamilyid() then
		if community_system_manager:getCommunityChatFalg() then
			community_system_manager:get_family_chat_history(nil, var_18_0)
		else
			var_18_0(1)
		end
	else
		self:getChildByName("bgPanel"):setVisible(false)
	end
end

function chatEntrySP:updateScrollChat(arg_20_1)
	self:getChildByName("bgPanel"):getChildByName("label2"):setString(arg_20_1)
end

return chatEntrySP

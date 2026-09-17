local var_0_0 = "Guide/guide_tips.png"
local var_0_1 = config._DEBUG and 0 or 1

GuideTips = class("GuideTips", function()
	return ccui.ImageView:create(var_0_0, var_0_1)
end)

function GuideTips.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = GuideTips.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4)

	return var_2_0
end

local function var_0_2(arg_3_0)
	local var_3_0 = cc.Label:createWithTTF(arg_3_0, "fonts/number.ttf", 20)

	var_3_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_0:setColor(cc.c3b(228, 246, 255))

	return var_3_0
end

function GuideTips:init(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self:initTipPanel(arg_4_1)
	self:calGuidePos(arg_4_2, arg_4_3, arg_4_4)
end

function GuideTips:initTipPanel(arg_5_1)
	self.tiplabel = var_0_2(arg_5_1)

	self:setScale9Enabled(true)
	self:setCapInsets(cc.rect(100, 50, 5, 5))
	self:setContentSize(cc.size(math.max(177, self.tiplabel:getContentSize().width + 60), self:getContentSize().height))
	self.tiplabel:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2 - 5))
	self:addChild(self.tiplabel)
end

local function var_0_3(arg_6_0)
	local var_6_0, var_6_1 = arg_6_0:match("(.+),(.+)")

	return tonumber(var_6_0), tonumber(var_6_1)
end

function GuideTips:calGuidePos(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_1.x + self:getContentSize().width < 640
	local var_7_1 = arg_7_1.y - self:getContentSize().height > 0
	local var_7_2 = var_7_0 and 1 or -1
	local var_7_3 = var_7_1 and 1 or -1

	if arg_7_3 then
		var_7_2, var_7_3 = var_0_3(arg_7_3)
		var_7_0 = var_7_2 > 0
		var_7_1 = var_7_3 > 0
	end

	self.tiplabel:setScaleX(var_7_2)
	self.tiplabel:setScaleY(var_7_3)

	local var_7_4 = var_7_0 and arg_7_1.x + self:getContentSize().width / 2 - 50 or arg_7_1.x - self:getContentSize().width / 2 + 50
	local var_7_5 = var_7_1 and arg_7_1.y - self:getContentSize().height / 2 or arg_7_1.y + self:getContentSize().height / 2

	self:setScaleX(var_7_2)
	self:setScaleY(var_7_3)
	self:setPosition(cc.p(var_7_4, var_7_5))
end

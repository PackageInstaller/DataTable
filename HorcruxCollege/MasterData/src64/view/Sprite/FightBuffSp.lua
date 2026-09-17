local buff_data = require("data.buff_data")
local var_0_1 = "skill_new/buff_frame_up.png"
local var_0_2 = "skill_new/buff_frame_down.png"
local BuffSP = class("BuffSP", function()
	return cc.Layer:create()
end)
local var_0_4 = config._DEBUG and 0 or 1

function BuffSP:create(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = BuffSP.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4)

	return var_2_0
end

function BuffSP:init(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self:setAnchorPoint(cc.p(0.5, 0.5))

	self._buffid = arg_3_1
	self._count = arg_3_2
	self._countTwo = arg_3_3

	if arg_3_4 == 0 then
		local var_3_0 = var_0_2 or var_0_1
		local var_3_1

		if config._DEBUG then
			var_3_1 = cc.Sprite:create(var_3_0) or cc.Sprite:createWithSpriteFrameName(var_3_0)
		end
	end

	var_3_1:setScale(1.5)
	self:addChild(var_3_1, 1)

	local var_3_2 = ccui.Button:create("skill_new/skill/" .. buff_data[arg_3_1].buff_image .. ".png", "skill_new/skill/" .. buff_data[arg_3_1].buff_image .. ".png", "skill_new/skill/" .. buff_data[arg_3_1].buff_image .. ".png", var_0_4)

	var_3_2:setSwallowTouches(false)
	var_3_2:setName("sp")
	var_3_2:setScale(0.5)
	self:addChild(var_3_2, 1)
	self:initCountLabel()
end

function BuffSP:initBuffInfo()
	local var_4_0 = self:getChildByName("sp")

	var_4_0:setSwallowTouches(false)
	var_4_0:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end
	end)
end

function BuffSP:initCountLabel()
	self.countlabel = cc.Label:createWithTTF("", "fonts/W5.ttf", 20)

	self.countlabel:setAnchorPoint(cc.p(1, 0))
	self.countlabel:setPosition(cc.p(27, -35))
	self:addChild(self.countlabel, 1)
	self:updateCountLabel()
end

function BuffSP:updateCountLabel()
	if self._count > 1 then
		self.countlabel:setVisible(true)
		self.countlabel:setString("X" .. self._count)
	else
		self.countlabel:setVisible(false)
	end
end

function BuffSP:initCountLabelTwo()
	self.countlabelTwo = cc.Label:createWithTTF("", "fonts/W5.ttf", 23)

	self.countlabelTwo:setAnchorPoint(cc.p(1, 0))
	self.countlabelTwo:setPosition(cc.p(22, 8))
	self:addChild(self.countlabelTwo, 999)
	self:updateCountLabelTwo()
end

function BuffSP:updateCountLabelTwo()
	if self._countTwo > 1 then
		self.countlabelTwo:setVisible(true)
		self.countlabelTwo:setString(self._countTwo)
	else
		self.countlabelTwo:setVisible(false)
	end
end

function BuffSP:pushBuff(arg_10_1)
	arg_10_1 = arg_10_1 or 1
	self._count = self._count + arg_10_1

	self:updateCountLabel()
end

function BuffSP:removeBuff(arg_11_1)
	arg_11_1 = arg_11_1 or 1
	self._count = self._count - arg_11_1

	self:updateCountLabel()
end

function BuffSP:getBuffCount()
	return self._count
end

function BuffSP:getSize()
	return cc.size(40, 40)
end

function BuffSP:getID()
	return self._buffid
end

return BuffSP

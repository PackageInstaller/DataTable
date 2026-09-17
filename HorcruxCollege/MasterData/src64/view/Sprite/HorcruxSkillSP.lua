local horcruxeffectsp = class("horcruxeffectsp", function()
	return ccui.Layout:create()
end)

function horcruxeffectsp:create(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = horcruxeffectsp.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4)

	return var_2_0
end

local var_0_1 = 196
local var_0_2 = 60

function horcruxeffectsp:init(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self:setContentSize(cc.size(var_0_1, var_0_2))
	self:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self:setBackGroundColor(cc.c3b(15, 15, 15))
	self:setBackGroundColorOpacity(180)
	self:setAnchorPoint(cc.p(0.5 - arg_3_1 * 0.5, 0.5))

	local var_3_0 = cc.Sprite:create(arg_3_2)

	var_3_0:setPosition(cc.p(var_0_1 / 2 + arg_3_1 * 72, 40))
	var_3_0:setScale(0.5)
	self:addChild(var_3_0)

	arg_3_3 = arg_3_3 or L_HORCRUX_SKILL

	local var_3_1 = cc.Label:createWithTTF(arg_3_3, FONT_DES, 25)

	var_3_1:setAnchorPoint(cc.p(0.5 + arg_3_1 * 0.5, 0.5))
	var_3_1:setPosition(cc.p(var_0_1 / 2 + arg_3_1 * 12, 30))
	self:addChild(var_3_1)
	self:setOpacity(0)
	self:setPosition(cc.p(-var_0_1 * arg_3_1, 0))
	self:showAction(arg_3_1, arg_3_4)
end

function horcruxeffectsp:showAction(arg_4_1, arg_4_2)
	self:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.15), cc.MoveBy:create(0.15, cc.p(arg_4_1 * self:getContentSize().width, 0))), cc.DelayTime:create(1), cc.Spawn:create(cc.FadeOut:create(0.15), cc.ScaleTo:create(0.15, 1, 0)), cc.CallFunc:create(function()
		if arg_4_2 then
			arg_4_2()
		end
	end), cc.RemoveSelf:create()))
end

local horcruxSkillSp = class("horcruxSkillSp", function()
	return cc.Node:create()
end)

function horcruxSkillSp:create(arg_7_1)
	local var_7_0 = horcruxSkillSp.new(arg_7_1)

	var_7_0:init(arg_7_1)

	return var_7_0
end

function horcruxSkillSp:init(arg_8_1)
	self._dir = arg_8_1 == "players" and 1 or -1
end

local var_0_4 = {
	100,
	0,
	-100
}

function horcruxSkillSp:showSkillEffect(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = horcruxeffectsp:create(self._dir, arg_9_2, arg_9_3, arg_9_4)

	var_9_0:setPositionY(var_0_4[arg_9_1])
	self:addChild(var_9_0)
end

return horcruxSkillSp

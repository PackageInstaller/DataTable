SPSkillSprite = class("SPSkillSprite", function()
	return ccui.Layout:create()
end)

local skill_data = require("data.skill_data")

function SPSkillSprite.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = SPSkillSprite.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function SPSkillSprite:init(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	assert(skill_data[arg_3_1], "skill" .. arg_3_1 .. " no exist!!!")
	self:setPosition(cc.p(arg_3_3 == "L" and -666 or SCREEN_WIDTH, SCREEN_HEIGHT / 2 + 100))
	self:setAnchorPoint(0, 0.5)
	self:setContentSize(666, 90)
	self:setClippingEnabled(true)
	self:setOpacity(0)

	local var_3_0 = ccui.ImageView:create("ui/skill/skillbg.png")
	local var_3_1 = var_3_0:getContentSize()

	var_3_0:setPosition(var_3_1.width / 2, var_3_1.height / 2)
	var_3_0:setScaleX(arg_3_3 == "L" and 1 or -1)
	self:addChild(var_3_0)

	local var_3_2 = ccui.ImageView:create("CocosRes/role1/" .. arg_3_2 .. ".png")

	var_3_2:setScaleX(arg_3_3 == "L" and -1.4285714285714286 or 1.4285714285714286)
	var_3_2:setScaleY(1.4285714285714286)
	var_3_2:setPosition((arg_3_3 == "L" or nil) and (var_3_1.width * 0.75 or var_3_1.width * 0.25), var_3_1.height / 2)
	self:addChild(var_3_2)

	local var_3_3 = cc.Label:create()

	if type(arg_3_1) == "number" and arg_3_1 % 10 == 4 then
		var_3_3:setString(L_SPSKILL_TYPE[1] .. skill_data[arg_3_1].name)
	else
		var_3_3:setString(L_SPSKILL_TYPE[2] .. skill_data[arg_3_1].name)
	end

	var_3_3:setSystemFontSize(40)
	var_3_3:setPosition((arg_3_3 == "L" or nil) and (var_3_1.width * 0.25 or var_3_1.width * 0.75), var_3_1.height / 2)
	self:addChild(var_3_3)
end

function SPSkillSprite:showAction()
	self:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.15), cc.MoveBy:create(0.15, cc.p(SCREEN_WIDTH / 2 - self:getPositionX() - self:getContentSize().width / 2, 0))), cc.DelayTime:create(0.5), cc.Spawn:create(cc.FadeOut:create(0.15), cc.ScaleTo:create(0.15, 1, 0)), cc.RemoveSelf:create(true)))
end

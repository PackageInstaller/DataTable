local BattlePath = require("app.view.battle.BattlePath")
local HpBuffIcon = class("HpBuffIcon", function()
	return cc.Node:create()
end)

function HpBuffIcon:ctor(arg_2_1)
	local var_2_0 = display.newSprite("battle/common/bg_tubiaodi.png")

	var_2_0:setAnchorPoint(0.5, 0.5)
	var_2_0:setCascadeColorEnabled(true)
	var_2_0:setCascadeOpacityEnabled(true)
	var_2_0:setOpacity(178)
	self:addChild(var_2_0)

	local var_2_1 = display.newSprite("battle/common/bg_tubiaodi.png")

	var_2_1:setAnchorPoint(0.5, 0.5)
	var_2_1:setScale(0.8)
	var_2_1:setCascadeColorEnabled(true)
	var_2_1:setCascadeOpacityEnabled(true)

	self._iconImg = var_2_1

	self:addChild(var_2_1)

	local var_2_2 = cc.Label:createWithSystemFont("5", "", 10)

	var_2_2:setTextColor(cc.c3b(255, 255, 255))
	var_2_2:setPosition(cc.p(5, -5))

	self._RoundNumText = var_2_2

	self:addChild(var_2_2)
end

function HpBuffIcon:updateView(arg_3_1)
	self._RoundNumText:setString(arg_3_1.buffTime)
	self._iconImg:setTexture((BattlePath:getBuffSpinePath(arg_3_1.buffIcon)))
end

return HpBuffIcon

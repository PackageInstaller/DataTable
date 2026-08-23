local var_0_0 = table.concat
local var_0_1 = math.min
local var_0_2 = g.core.common.Color
local SpineBase = require("app.view.common.SpineBase")
local HpMarkIcon = class("HpMarkIcon", function()
	return cc.Node:create()
end)

function HpMarkIcon:ctor(arg_2_1)
	self:setScale(0.5)

	local var_2_0 = arg_2_1.max_num
	local var_2_1 = ""
	local var_2_3

	if arg_2_1.max_num > 10 or var_2_0 < 3 then
		var_2_1 = "battle/common/mark/bg_markcircle.png"
		var_2_3 = "battle/common/mark/pic_markcircle.png"
	else
		var_2_1 = var_0_0({
			"battle/common/mark/bg_mark",
			var_2_0,
			".png"
		})
		var_2_3 = var_0_0({
			"battle/common/mark/pic_mark",
			var_2_0,
			".png"
		})
	end

	local var_2_4 = display.newSprite(var_2_1)

	var_2_4:setAnchorPoint(0.5, 0.5)
	self:addChild(var_2_4)

	local var_2_5 = display.newSprite(var_2_3)

	var_2_5:setColor(var_0_2.hexToCC3(arg_2_1.mark_colour))

	local var_2_6 = cc.ProgressTimer:create(var_2_5)

	var_2_6:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
	var_2_6:setAnchorPoint(0.5, 0.5)
	self:addChild(var_2_6)

	self._progressBar = var_2_6
	self._markLabel = cc.Label:createWithTTF("", "font/NOVECENTOWIDE-BOLD.OTF", 20)

	self._markLabel:setTextColor(var_0_2.A6)
	var_2_6:setAnchorPoint(0.5, 0.5)
	self:addChild(self._markLabel)

	self._maxVale = 1
	self._curValue = 0
	self._barSpine = nil
	self._mType = arg_2_1.type

	self:setMax(var_2_0)
end

function HpMarkIcon:setProgressSpine(arg_3_1)
	if self._barSpine then
		self._barSpine:dispose()

		self._barSpine = nil
	end

	local var_3_0 = SpineBase.new({
		isLoop = true,
		anim = "play",
		path = g.core.common.Path:getEffSpine(arg_3_1)
	})

	var_3_0:setAnchorPoint(0.5, 1)
	self._clip:addChild(var_3_0)

	self._barSpine = var_3_0
end

function HpMarkIcon:setMax(arg_4_1)
	self._maxVale = arg_4_1

	self:updateView()
end

function HpMarkIcon:addValue(arg_5_1)
	self._curValue = var_0_1(self._curValue + arg_5_1, self._maxVale)

	self:updateView()
end

function HpMarkIcon:setValue(arg_6_1)
	self._curValue = var_0_1(arg_6_1, self._maxVale)

	self:updateView()
end

function HpMarkIcon:getValue()
	return self._curValue
end

function HpMarkIcon:updateView()
	self._progressBar:setPercentage(var_0_1(1, self._curValue / self._maxVale) * 100)
	self._markLabel:setString(self._curValue)
end

function HpMarkIcon:clear()
	if self._barSpine then
		self._barSpine:dispose()

		self._barSpine = nil
	end
end

function HpMarkIcon:setMarkType(arg_10_1)
	self._mType = arg_10_1
end

function HpMarkIcon:getMarkType()
	return self._mType
end

return HpMarkIcon

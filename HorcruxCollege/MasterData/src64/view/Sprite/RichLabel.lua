local var_0_0 = ...
local var_0_1 = config._DEBUG and 0 or 1
local var_0_2 = require((string.format("%s.labelparser", string.sub(var_0_0, 1, string.find(var_0_0, "%.%w+$") - 1), label)))
local RichLabel = class("RichLabel", function()
	return cc.Node:create()
end)

RichLabel._default = nil
RichLabel._maxWidth = nil
RichLabel._currentWidth = nil
RichLabel._currentHeight = nil
RichLabel._containerNode = nil
RichLabel._allnodelist = nil
RichLabel._currentText = nil
RichLabel._parsedtable = nil
RichLabel._alllines = nil
RichLabel._animationCounter = nil

local var_0_4 = {}
local var_0_5 = 15
local var_0_6 = "richlabel.debug.drawnodes"
local var_0_7 = 0
local var_0_8 = 1
local var_0_9 = {
	"CityMap",
	"equipment",
	"expression",
	"guide",
	"loading",
	"mainScenebg",
	"roleimage"
}

function RichLabel:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	local var_2_0 = arg_2_1.fontName or "Arial"
	local var_2_1 = arg_2_1.fontSize or 24
	local var_2_2 = arg_2_1.fontColor or cc.c3b(255, 255, 255)
	local var_2_3 = arg_2_1.maxWidth or 0
	local var_2_4 = arg_2_1.lineSpace or 0
	local var_2_5 = arg_2_1.charSpace or 0
	local var_2_6 = arg_2_1.maxlinewidth or 480
	local var_2_7 = cc.Node:create()

	self:addChild(var_2_7)

	self._maxWidth = var_2_3
	self._containerNode = var_2_7
	self._animationCounter = 0
	self._default = {}
	self._default.fontName = var_2_0
	self._default.fontSize = var_2_1
	self._default.fontColor = var_2_2
	self._default.lineSpace = var_2_4
	self._default.charSpace = var_2_5
	self.maxlinewidth = var_2_6
	self.istalklayerlabel = false

	self:setAnchorPoint(cc.p(0, 1))
	self:setCascadeOpacityEnabled(true)
	self:setCascadeColorEnabled(true)
	var_2_7:setCascadeOpacityEnabled(true)
	var_2_7:setCascadeColorEnabled(true)
end

function RichLabel:setString(arg_3_1, arg_3_2, arg_3_3)
	self.istalklayerlabel = arg_3_3
	arg_3_1 = arg_3_1 or ""

	if self._currentText == arg_3_1 then
		return
	end

	if self._currentText then
		self._allnodelist = nil
		self._parsedtable = nil
		self._alllines = nil

		self._containerNode:removeAllChildren()
	end

	self._currentText = arg_3_1

	local var_3_0 = var_0_2.parse(arg_3_1, arg_3_2)

	self._parsedtable = var_3_0

	if var_3_0 == nil then
		return self:printf("parser text error")
	end

	local var_3_1 = self:charsToNodes_(var_3_0, self._containerNode)

	if not var_3_1 then
		return
	end

	self._allnodelist = var_3_1

	self:layout()
end

function RichLabel:getString()
	return self._currentText
end

function RichLabel:setMaxWidth(arg_5_1)
	self._maxWidth = arg_5_1

	self:layout()
end

function RichLabel:setAnchorPoint(arg_6_1, arg_6_2)
	if type(arg_6_1) == "number" then
		arg_6_1 = cc.p(arg_6_1, arg_6_2)
	end

	getmetatable(self).setAnchorPoint(self, arg_6_1)

	if self._currentText then
		self:layout()
	end
end

function RichLabel:getSize()
	return self._currentWidth, self._currentHeight
end

function RichLabel:getLineHeight(arg_8_1)
	if not self._alllines[arg_8_1] then
		return 0
	end

	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(self._alllines[arg_8_1]) do
		local var_8_1 = iter_8_1:getBoundingBox()

		if var_8_0 < var_8_1.height then
			var_8_0 = var_8_1.height
		end
	end

	return var_8_0
end

function RichLabel:getElementWithIndex(arg_9_1)
	return self._allnodelist[arg_9_1]
end

function RichLabel:getElementWithRowCol(arg_10_1, arg_10_2)
	if self._alllines[arg_10_1] then
		return self._alllines[arg_10_1][arg_10_2]
	end
end

function RichLabel:getElementsWithLetter(arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(self._allnodelist) do
		if iter_11_1.getString and iter_11_1:getString() == arg_11_1 then
			table.insert(var_11_0, iter_11_1)
		end
	end

	return var_11_0
end

function RichLabel:getElementsWithGroup(arg_12_1)
	return self._parsedtable[arg_12_1].nodelist
end

function RichLabel:walkElements(arg_13_1)
	assert(arg_13_1)

	for iter_13_0, iter_13_1 in pairs(self._allnodelist) do
		if arg_13_1(iter_13_1, iter_13_0) ~= nil then
			return
		end
	end
end

function RichLabel:walkLineElements(arg_14_1)
	assert(arg_14_1)

	for iter_14_0, iter_14_1 in pairs(self._alllines) do
		for iter_14_2, iter_14_3 in pairs(iter_14_1) do
			if arg_14_1(iter_14_3, iter_14_0, iter_14_2) ~= nil then
				return
			end
		end
	end
end

function RichLabel:getCurLabels()
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(self._alllines) do
		for iter_15_2, iter_15_3 in pairs(iter_15_1) do
			iter_15_3:setVisible(false)

			if iter_15_3 then
				var_15_0[1] = iter_15_3
			end
		end
	end

	self.labels = var_15_0

	return self.labels
end

function RichLabel:playWordOutAnimation(arg_16_1)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(self._alllines) do
		for iter_16_2, iter_16_3 in pairs(iter_16_1) do
			iter_16_3:setVisible(false)

			if iter_16_3 then
				var_16_0[1] = iter_16_3
			end
		end
	end

	local function var_16_2(arg_17_0)
		if arg_17_0 > #var_16_0 then
			if arg_16_1 then
				arg_16_1()
			end

			return
		end

		local var_17_0 = var_16_0[arg_17_0]
		local var_17_1 = var_16_0[arg_17_0]:getString()
		local var_17_2 = var_17_1:len()
		local var_17_3 = 1

		var_16_0[arg_17_0]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.03), cc.CallFunc:create(function()
			var_17_0:setVisible(true)

			var_17_3 = var_17_1:byte(var_17_3) >= 127 and var_17_3 + 3 or var_17_3 + 1

			var_17_0:setString(var_17_1:sub(1, var_17_3 - 1))

			if var_17_3 >= var_17_2 then
				var_17_0:stopAllActions()
				var_16_2(arg_17_0 + 1)
			end
		end))))
	end

	var_16_2(1)
end

function RichLabel:playAnimation(arg_19_1, arg_19_2)
	arg_19_1 = arg_19_1 or var_0_5

	if self:isAnimationPlaying() then
		return
	end

	local var_19_0 = 0

	local function var_19_1(arg_20_0, arg_20_1, arg_20_2)
		var_19_0 = var_19_0 + 1

		return cc.Sequence:create(cc.DelayTime:create(var_19_0 / arg_19_1), cc.CallFunc:create(function()
			if arg_19_2 then
				arg_19_2(arg_20_0, arg_20_1, arg_20_2)
			end
		end), cc.FadeIn:create(0.2), cc.CallFunc:create(function()
			self._animationCounter = self._animationCounter - 1
		end))
	end

	self:walkLineElements(function(arg_23_0, arg_23_1, arg_23_2)
		self._animationCounter = self._animationCounter + 1

		arg_23_0:setOpacity(0)
		arg_23_0:runAction(var_19_1(arg_23_0, arg_23_1, arg_23_2))
	end)
end

function RichLabel:isAnimationPlaying()
	return self._animationCounter > 0
end

function RichLabel:stopAnimation()
	self._animationCounter = 0

	self:walkElements(function(arg_26_0, arg_26_1)
		arg_26_0:setOpacity(255)
		arg_26_0:stopAllActions()
	end)
end

function RichLabel:layout()
	local var_27_1 = cc.p(0, 0)
	local var_27_4 = 0
	local var_27_5 = 0
	local var_27_6 = self:adjustLineBreak_(self._allnodelist, self._default.charSpace)

	self._alllines = var_27_6

	for iter_27_0, iter_27_1 in pairs(var_27_6) do
		local var_27_7, var_27_8 = self:layoutLine_(var_27_1, iter_27_1, 1, self._default.charSpace)

		var_27_1.y = var_27_1.y - (var_27_8 + self._default.lineSpace)
		var_27_5 = var_27_5 + (var_27_8 + self._default.lineSpace)

		if var_27_4 < var_27_7 then
			var_27_4 = var_27_7
		end
	end

	self._currentWidth = var_27_4
	self._currentHeight = var_27_5 - self._default.lineSpace

	local var_27_9 = self:getAnchorPoint()

	self._containerNode:setPosition(0 - var_27_9.x * var_27_4, var_27_5 - self._default.lineSpace - var_27_9.y * (var_27_5 - self._default.lineSpace))
end

function RichLabel:debugDraw(arg_28_1)
	arg_28_1 = arg_28_1 or 2

	local var_28_0 = self._containerNode
	local var_28_1 = cc.utils:findChildren(self._containerNode, var_0_6)

	function table_insertto(arg_29_0, arg_29_1, arg_29_2)
		if arg_29_2 <= 0 then
			arg_29_2 = #arg_29_0 + 1
		end

		for iter_29_0 = 0, #arg_29_1 - 1 do
			arg_29_0[iter_29_0 + arg_29_2] = arg_29_1[iter_29_0 + 1]
		end
	end

	table_insertto(var_28_1, cc.utils:findChildren(self, var_0_6), #var_28_1 + 1)

	for iter_28_0, iter_28_1 in pairs(var_28_1) do
		iter_28_1:removeFromParent()
	end

	local var_28_2 = self:getSize()
	local var_28_3 = self:getAnchorPoint()

	self.drawrect(self, self, cc.rect(0 - var_28_2.width * var_28_3.x, 0 - var_28_2.height * var_28_3.y, var_28_2.width, var_28_2.height), 1):setName(var_0_6)
	self.drawdot(self, self, cc.p(0, 0), 5):setName(var_0_6)

	if arg_28_1 > 1 then
		local var_28_4 = cc.c4f(0, 0, 1, 0.5)

		for iter_28_2, iter_28_3 in pairs(self._allnodelist) do
			local var_28_5 = cc.p(iter_28_3:getPositionX(), iter_28_3:getPositionY())

			self:drawrect(var_28_0, iter_28_3:getBoundingBox(), 1, var_28_4):setName(var_0_6)
			self:drawdot(var_28_0, var_28_5, 2, var_28_4):setName(var_0_6)
		end
	end
end

function RichLabel:loadLabelParser_(arg_30_1)
	if var_0_4[arg_30_1] then
		return var_0_4[arg_30_1]
	end

	local var_30_0 = string.find(var_0_0, "%.%w+$")

	if not var_30_0 then
		return
	end

	local var_30_1 = require((string.format("%s.labels.label_%s", string.sub(var_0_0, 1, var_30_0 - 1), arg_30_1)))

	if var_30_1 then
		var_0_4[arg_30_1] = var_30_1
	end

	return var_30_1
end

function RichLabel:charsToNodes_(arg_31_1, arg_31_2)
	local var_31_0 = {}

	for iter_31_0, iter_31_1 in pairs(arg_31_1) do
		local var_31_1 = self:loadLabelParser_(iter_31_1.labelname)

		if not var_31_1 then
			return self:printf("not support label %s", iter_31_1.labelname)
		end

		iter_31_1.maxlinewidth = self.maxlinewidth

		local var_31_3, var_31_4 = var_31_1(self, iter_31_1, 0, self._default)

		if var_31_3 then
			iter_31_1.nodelist = var_31_3

			for iter_31_2, iter_31_3 in pairs(var_31_3) do
				table.insert(var_31_0, iter_31_3)

				if self.istalklayerlabel then
					iter_31_3:setAnchorPoint(0, 1)
				end

				arg_31_2:addChild(iter_31_3)
			end
		else
			print("nodelist do not exist")
		end
	end

	return var_31_0
end

function RichLabel:layoutLine_(arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	arg_32_3 = arg_32_3 or 0.5

	local var_32_0 = arg_32_1.x
	local var_32_1 = 0
	local var_32_2 = 0

	for iter_32_0, iter_32_1 in pairs(arg_32_2) do
		local var_32_3 = iter_32_1:getBoundingBox()

		iter_32_1:setPosition(var_32_0 + var_32_2 + var_32_3.width / 2, arg_32_1.y)

		if self.istalklayerlabel then
			iter_32_1:setPosition(var_32_0 + var_32_2, arg_32_1.y)
		end

		var_32_2 = var_32_2 + var_32_3.width + arg_32_4

		if var_32_1 < var_32_3.height then
			var_32_1 = var_32_3.height
		end
	end

	if arg_32_3 ~= 0.5 and not self.istalklayerlabel then
		for iter_32_2, iter_32_3 in pairs(arg_32_2) do
			iter_32_3:setPositionY(iter_32_3:getPositionY() - (arg_32_3 - 0.5) * var_32_1)
		end
	end

	return var_32_2 - arg_32_4, var_32_1
end

function RichLabel:adjustLineBreak_(arg_33_1, arg_33_2)
	local var_33_0 = self.maxlinewidth

	if self.maxlinewidth <= 0 then
		var_33_0 = 999999999999
	end

	local var_33_1 = {
		{},
		{},
		{}
	}
	local var_33_2 = 0
	local var_33_3 = 1
	local var_33_4 = 0

	for iter_33_0, iter_33_1 in pairs(arg_33_1) do
		var_33_4 = var_33_4 + 1

		local var_33_5 = iter_33_1:getBoundingBox()

		var_33_2 = var_33_2 + var_33_5.width

		local var_33_6 = false

		if var_33_0 < var_33_2 + (var_33_4 - 1) * arg_33_2 then
			var_33_3 = var_33_3 + 1
			var_33_2 = var_33_5.width
			var_33_4 = 1
			var_33_6 = true
		end

		local var_33_7 = var_33_1[var_33_3] or {}

		var_33_1[var_33_3] = var_33_7

		table.insert(var_33_7, iter_33_1)

		if not var_33_6 and self:adjustContentLinebreak_(iter_33_1) then
			var_33_3 = var_33_3 + 1
			var_33_4 = 0
			var_33_2 = 0
		end
	end

	return var_33_1
end

function RichLabel:adjustContentLinebreak_(arg_34_1)
	if arg_34_1.getString and arg_34_1:getString() == "\n" then
		return true
	end

	return false
end

function RichLabel:convertColor(arg_35_1)
	if not arg_35_1 then
		return
	end

	local function var_35_0(arg_36_0)
		return tonumber("0x" .. arg_36_0)
	end

	local var_35_1 = var_35_0((string.sub(arg_35_1, -6, -5)))
	local var_35_2 = var_35_0((string.sub(arg_35_1, -4, -3)))
	local var_35_3 = var_35_0((string.sub(arg_35_1, -2, -1)))

	if var_35_1 and var_35_2 and var_35_3 then
		return cc.c4b(var_35_1, var_35_2, var_35_3, 255)
	end
end

function RichLabel:stringToChars(arg_37_1)
	local var_37_0 = {}
	local var_37_1 = string.len(arg_37_1)
	local var_37_2 = 1

	while var_37_2 <= var_37_1 do
		local var_37_3 = string.byte(arg_37_1, var_37_2)
		local var_37_4 = 1

		if var_37_3 > 0 and var_37_3 <= 127 then
			var_37_4 = 1
		elseif var_37_3 >= 192 and var_37_3 <= 223 then
			var_37_4 = 2
		elseif var_37_3 >= 224 and var_37_3 <= 239 then
			var_37_4 = 3
		elseif var_37_3 >= 240 and var_37_3 <= 247 then
			var_37_4 = 4
			var_37_2 = var_37_2 + var_37_4
		end

		table.insert(var_37_0, (string.sub(arg_37_1, var_37_2, var_37_2 + var_37_4 - 1)))
	end

	return var_37_0, var_37_1
end

function RichLabel:split(arg_38_1, arg_38_2)
	if arg_38_2 == "" then
		return false
	end

	local var_38_0 = 0
	local var_38_1 = {}

	for iter_38_0, iter_38_1 in function()
		return string.find(arg_38_1, arg_38_2, var_38_0, true)
	end do
		table.insert(var_38_1, string.sub(arg_38_1, var_38_0, iter_38_0 - 1))

		var_38_0 = iter_38_1 + 1
	end

	table.insert(var_38_1, string.sub(arg_38_1, var_38_0))

	return var_38_1
end

function RichLabel:printf(arg_40_1, ...)
	return print(string.format("RichLabel# " .. arg_40_1, ...))
end

function RichLabel:drawdot(arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	arg_41_3 = arg_41_3 or 2
	arg_41_4 = arg_41_4 or cc.c4f(1, 0, 0, 0.5)

	local var_41_0 = cc.DrawNode:create()

	var_41_0:drawDot(arg_41_2, arg_41_3, arg_41_4)
	arg_41_1:addChild(var_41_0)

	return var_41_0
end

function RichLabel:drawrect(arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5)
	local var_42_0 = arg_42_4 or cc.c4f(1, 0, 0, 0.5)
	local var_42_1 = arg_42_5 and var_42_0 or cc.c4f(0, 0, 0, 0)
	local var_42_2

	if not arg_42_3 then
		arg_42_3 = 2
		var_42_2 = cc.DrawNode:create()
	end

	var_42_2:drawPolygon({
		cc.p(arg_42_2.x, arg_42_2.y),
		cc.p(arg_42_2.x, arg_42_2.y + arg_42_2.height),
		cc.p(arg_42_2.x + arg_42_2.width, arg_42_2.y + arg_42_2.height),
		cc.p(arg_42_2.x + arg_42_2.width, arg_42_2.y)
	}, 4, var_42_1, arg_42_3, var_42_0)
	arg_42_1:addChild(var_42_2)

	return var_42_2
end

function RichLabel:getSprite(arg_43_1)
	if var_0_1 == 0 or ((self:findImgPath(arg_43_1) or nil) and var_0_8) == var_0_8 then
		print(">>>>>>>>>>>>>>>>>")

		return cc.Sprite:create(arg_43_1)
	end

	return cc.Sprite:createWithSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrameByName(arg_43_1)))
end

function RichLabel:findImgPath(arg_44_1)
	for iter_44_0, iter_44_1 in ipairs(var_0_9) do
		if string.find(arg_44_1, iter_44_1) then
			return true
		end
	end

	return false
end

return RichLabel

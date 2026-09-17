DisplaySprite = class("DisplaySprite", function()
	return cc.Node:create()
end)

function DisplaySprite.create(arg_2_0, arg_2_1)
	return (DisplaySprite.new(arg_2_1))
end

function DisplaySprite:ctor(arg_3_1)
	self.label = cc.Label:createWithTTF(arg_3_1, "")

	self.label:setAnchorPoint(cc.p(0, 1))
	self.label:setPosition(cc.p(0, 0))
	self.label:setVerticalAlignment(cc.TEXT_ALIGNMENT_LEFT)
	self.label:setHorizontalAlignment(cc.VERTICAL_TEXT_ALIGNMENT_TOP)
	self:addChild(self.label)

	self.tag = cc.Label:createWithTTF(arg_3_1, "_")

	self.tag:setAnchorPoint(cc.p(0, 0))
	self:addChild(self.tag)
	self.tag:runAction(cc.RepeatForever:create((cc.Sequence:create(cc.FadeTo:create(0.2, 100), cc.FadeTo:create(0.2, 255)))))

	self._content = ""
	self._contentStrSize = arg_3_1.fontSize
	self._rowlen = {}
end

function DisplaySprite:addString(arg_4_1)
	local var_4_0 = utfstrlen((self.label:getString()))

	self._content = self._content .. arg_4_1

	local var_4_1 = utfstrlen(self._content)

	self.label:stopAllActions()
	self.label:runAction(cc.ActionFloat:create((var_4_1 - var_4_0) * 0.1, var_4_0, var_4_1, function(arg_5_0)
		local var_5_0 = utfmatch(self._content, math.floor(arg_5_0))

		if var_5_0 == nil then
			return
		end

		self.label:setString(var_5_0)

		local var_5_1 = -self.label:getContentSize().height
		local var_5_2 = math.floor(self.label:getContentSize().height / self.label:getLineHeight())

		self._rowlen[var_5_2] = self.label:getStringLength() - (self._rowlen[var_5_2 - 1] or 0)

		local var_5_3 = self._rowlen[var_5_2] * self._contentStrSize

		var_5_3 = self._rowlen[var_5_2] * self._contentStrSize < self.label:getContentSize().width and var_5_3 or self.label:getContentSize().width

		self.tag:setPosition(cc.p(var_5_3, var_5_1))
	end))
end

function DisplaySprite:reset()
	self._rowlen = {}
	self._content = ""

	self.label:stopAllActions()
	self.label:setString("")
	self.tag:setPosition(cc.p(0, 0))
end

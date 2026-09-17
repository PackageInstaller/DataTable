local RichTextEx = class("RichTextEx", function(...)
	return ccui.RichText:create(...)
end)
local var_0_1 = string.sub
local var_0_2 = string.rep
local var_0_3 = string.byte
local var_0_4 = string.gsub
local var_0_5 = string.find

local function var_0_6(arg_2_0)
	arg_2_0 = var_0_4(arg_2_0, "^[ \t\n\r]+", "")

	return var_0_4(arg_2_0, "[ \t\n\r]+$", "")
end

local var_0_7 = string.byte("&")
local var_0_8 = string.byte("<")
local var_0_9 = string.byte(">")
local var_0_10 = string.byte("#")
local var_0_11 = string.byte("_")
local var_0_12 = string.byte("\n")
local var_0_13 = string.byte("\t")
local var_0_14 = string.byte("!")
local var_0_15 = string.byte("+")
local var_0_16 = string.byte("-")
local var_0_17 = string.byte("*")
local var_0_18 = string.byte("/")

local function var_0_19(arg_3_0)
	return {
		a = 255,
		r = arg_3_0.r,
		g = arg_3_0.g,
		b = arg_3_0.b
	}
end

local function var_0_20(arg_4_0)
	local var_4_0 = 0
	local var_4_1 = 0
	local var_4_2 = 0

	if #arg_4_0 == 4 then
		var_4_2 = tonumber(var_0_2(var_0_1(arg_4_0, 4, 4), 2), 16)
		var_4_1 = tonumber(var_0_2(var_0_1(arg_4_0, 3, 3), 2), 16)
		var_4_0 = tonumber(var_0_2(var_0_1(arg_4_0, 2, 2), 2), 16)
	elseif #arg_4_0 == 7 then
		var_4_2 = tonumber(var_0_1(arg_4_0, 6, 7), 16)
		var_4_1 = tonumber(var_0_1(arg_4_0, 4, 5), 16)
		var_4_0 = tonumber(var_0_1(arg_4_0, 2, 3), 16)
	end

	return cc.c3b(var_4_0, var_4_1, var_4_2)
end

function RichTextEx:ctor(arg_5_1, arg_5_2)
	self._text = ""
	self._fontSizeDef = arg_5_1 or 26
	self._textColorDef = arg_5_2 or cc.c3b(11, 11, 11)
	self._fontSize = self._fontSizeDef
	self._textColor = self._textColorDef
	self._elements = {}
	self._textFont = ""
	self._outLine = 0
	self._underLine = false
end

function RichTextEx:setMultiLineMode(arg_6_1)
	self:ignoreContentAdaptWithSize(not arg_6_1)

	return self
end

function RichTextEx:defaultCb(arg_7_1)
	if var_0_1(self, 1, #"blink ") == "blink " then
		local var_7_0 = ccui.Text:create(self:htmlDecode(var_0_1(self, #"blink " + 1)), "", arg_7_1._fontSize)

		var_7_0:setTextColor(var_0_19(arg_7_1._textColor))
		var_7_0:runAction(cc.RepeatForever:create(cc.Blink:create(10, 10)))

		return var_7_0
	elseif var_0_1(self, 1, #"rotate ") == "rotate " then
		local var_7_1 = ccui.Text:create(self:htmlDecode(var_0_1(self, #"rotate " + 1)), "", arg_7_1._fontSize)

		var_7_1:setTextColor(var_0_19(arg_7_1._textColor))
		var_7_1:runAction(cc.RepeatForever:create(cc.RotateBy:create(0.1, 5)))

		return var_7_1
	elseif var_0_1(self, 1, #"scale ") == "scale " then
		local var_7_2 = ccui.Text:create(self:htmlDecode(var_0_1(self, #"scale " + 1)), "", arg_7_1._fontSize)

		var_7_2:setTextColor(var_0_19(arg_7_1._textColor))
		var_7_2:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.ScaleTo:create(1, 0.1), cc.ScaleTo:create(1, 1))))

		return var_7_2
	end

	return nil
end

function RichTextEx:defaultImgCb()
	local var_8_0 = 0
	local var_8_1 = 0

	if var_0_3(self, 1) == var_0_11 then
		local var_8_2 = var_0_5(self, "*")
		local var_8_3 = var_0_5(self, " ")

		if var_8_2 and var_8_3 and var_8_2 < var_8_3 then
			var_8_0 = tonumber(var_0_1(self, 2, var_8_2 - 1))
			var_8_1 = tonumber(var_0_1(self, var_8_2 + 1, var_8_3))
		end

		if var_8_3 then
			self = var_0_6(var_0_1(self, var_8_3 + 1))
		end
	end

	local var_8_4

	if cc.SpriteFrameCache:getInstance():getSpriteFrame(self) then
		var_8_4 = ccui.ImageView:create(self, ccui.TextureResType.plistType)
	elseif cc.FileUtils:getInstance():isFileExist(self) then
		var_8_4 = ccui.ImageView:create(self, ccui.TextureResType.localType)
	end

	if var_8_4 and var_8_0 and var_8_1 and var_8_0 > 0 and var_8_1 > 0 then
		var_8_4:ignoreContentAdaptWithSize(false)
		var_8_4:setContentSize(cc.size(var_8_0, var_8_1))
	end

	return var_8_4
end

function RichTextEx:addCustomNode(arg_9_1)
	if arg_9_1 then
		local var_9_0 = arg_9_1:getAnchorPoint()

		if var_9_0.x ~= 0 or var_9_0.y ~= 0 then
			local var_9_1 = arg_9_1
			local var_9_2 = arg_9_1:getContentSize()

			arg_9_1 = cc.Node:create()

			arg_9_1:setContentSize(var_9_2)
			arg_9_1.addChild(arg_9_1, var_9_1)
			var_9_1:setPosition(cc.p(var_9_2.width * var_9_0.x, var_9_2.height * var_9_0.y))
		end

		local var_9_3 = ccui.RichElementCustomNode:create(0, cc.c3b(255, 255, 255), 255, arg_9_1)

		self:pushBackElement(var_9_3)

		self._elements[#self._elements + 1] = var_9_3
	end
end

function RichTextEx:setText(arg_10_1, arg_10_2)
	assert(arg_10_1)

	self._text = arg_10_1
	self._callback = arg_10_2 or self.defaultCb
	self._fontSize = self._fontSizeDef
	self._textColor = self._textColorDef

	for iter_10_0, iter_10_1 in pairs(self._elements) do
		self:removeElement(iter_10_1)
	end

	self._elements = {}

	local var_10_0 = 1
	local var_10_1 = 1
	local var_10_2 = false

	while var_10_1 <= #arg_10_1 do
		local var_10_7 = var_0_3(arg_10_1, var_10_1)

		if var_10_7 == var_0_8 then
			if not var_10_2 and var_10_0 < var_10_1 then
				local var_10_8 = ccui.RichElementText:create(0, self._textColor, 255, self:htmlDecode((var_0_1(arg_10_1, var_10_0, var_10_1 - 1))), self._textFont, self._fontSize, self._outLine, self._underLine)

				self:pushBackElement(var_10_8)

				self._elements[#self._elements + 1] = var_10_8
			end

			var_10_2 = true
			var_10_0 = var_10_1 + 1
			var_10_1 = var_10_1 + 1

			while var_10_1 < #arg_10_1 do
				if var_0_3(arg_10_1, var_10_1) == var_0_9 then
					var_10_2 = false

					if var_10_0 < var_10_1 then
						local var_10_9 = var_0_6(var_0_1(arg_10_1, var_10_0, var_10_1 - 1))
						local var_10_10 = var_0_3(var_10_9, 1)

						if var_10_10 == var_0_10 and (#var_10_9 == 4 or #var_10_9 == 7) and tonumber(var_0_1(var_10_9, 2), 16) then
							self._textColor = var_0_20(var_10_9)

							break
						end

						if var_10_10 == var_0_14 and #var_10_9 == 1 then
							self._textColor = self._textColorDef
							self._fontSize = self._fontSizeDef
							self._textFont = ""
							self._outLine = 0
							self._underLine = false

							break
						end

						if (var_10_10 == var_0_15 or var_10_10 == var_0_16 or var_10_10 == var_0_17 or var_10_10 == var_0_18) and tonumber(var_0_1(var_10_9, 2)) then
							local var_10_11 = tonumber(var_0_1(var_10_9, 2)) or 0

							if var_10_10 == var_0_15 then
								self._fontSize = self._fontSize + var_10_11

								break
							end

							if var_10_10 == var_0_16 then
								self._fontSize = self._fontSize - var_10_11

								break
							end

							if var_10_10 == var_0_17 then
								self._fontSize = self._fontSize * var_10_11

								break
							end

							if var_10_11 ~= 0 then
								self._fontSize = self._fontSize / var_10_11
							end

							break
						end

						if tonumber(var_10_9) then
							self._fontSize = tonumber(var_10_9)

							break
						end

						if var_0_1(var_10_9, 1, 5) == "font " or var_0_1(var_10_9, 1, 5) == "font_" then
							self._textFont = var_0_6(var_0_1(var_10_9, 5, var_10_1 - 1))

							break
						end

						if var_0_1(var_10_9, 1, 8) ~= "outLine " then
							if var_0_1(var_10_9, 1, 8) == "outLine_" then
								self._outLine = tonumber((var_0_6(var_0_1(var_10_9, 8, var_10_1 - 1))))

								break
							end

							if var_0_1(var_10_9, 1, 10) == "underLine " or var_0_1(var_10_9, 1, 10) == "underLine_" then
								if var_0_6(var_0_1(var_10_9, 10, var_10_1 - 1)) == "true" then
									self._underLine = true

									break
								end

								self._underLine = false

								break
							end

							if var_0_1(var_10_9, 1, 4) == "img " or var_0_1(var_10_9, 1, 4) == "img_" then
								self:addCustomNode(self.defaultImgCb(var_0_6(var_0_1(var_10_9, 4, var_10_1 - 1))))

								break
							end

							if self._callback then
								self:addCustomNode(self._callback(var_10_9, self))
							end
						end
					end

					break
				end

				var_10_1 = var_10_1 + 1
			end

			var_10_0 = var_10_1 + 1
		elseif var_10_7 == var_0_12 or var_10_7 == var_0_13 then
			if not var_10_2 and var_10_0 < var_10_1 then
				local var_10_12 = ccui.RichElementText:create(0, self._textColor, 255, self:htmlDecode((var_0_1(arg_10_1, var_10_0, var_10_1 - 1))), self._textFont, self._fontSize, self._outLine, self._underLine)

				self:pushBackElement(var_10_12)

				self._elements[#self._elements + 1] = var_10_12
			end

			local var_10_13 = cc.Node:create()

			if var_10_7 == var_0_12 then
				var_10_13:setContentSize(cc.size(self:getContentSize().width, 1))
			else
				var_10_13:setContentSize(cc.size(self._fontSize * 2, 1))
			end

			self:addCustomNode(var_10_13)

			var_10_0 = var_10_1 + 1
		end

		var_10_1 = var_10_1 + 1
	end

	if not var_10_2 and var_10_0 <= #arg_10_1 then
		local var_10_14 = ccui.RichElementText:create(0, self._textColor, 255, self:htmlDecode((var_0_1(arg_10_1, var_10_0))), self._textFont, self._fontSize, self._outLine, self._underLine)

		self:pushBackElement(var_10_14)

		self._elements[#self._elements + 1] = var_10_14
	end

	return self
end

function RichTextEx:setDefaultFont(arg_11_1)
	self._textFont = arg_11_1
end

function RichTextEx:htmlEncode(arg_12_1)
	arg_12_1 = arg_12_1 or self
	arg_12_1 = string.gsub(arg_12_1, "&", "&amp;")
	arg_12_1 = string.gsub(arg_12_1, "\"", "&quot;")
	arg_12_1 = string.gsub(arg_12_1, "'", "&#039;")
	arg_12_1 = string.gsub(arg_12_1, "<", "&lt;")
	arg_12_1 = string.gsub(arg_12_1, ">", "&gt;")

	return arg_12_1
end

function RichTextEx:htmlDecode(arg_13_1)
	arg_13_1 = arg_13_1 or self
	arg_13_1 = string.gsub(arg_13_1, "&gt;", ">")
	arg_13_1 = string.gsub(arg_13_1, "&lt;", "<")
	arg_13_1 = string.gsub(arg_13_1, "&#039;", "'")
	arg_13_1 = string.gsub(arg_13_1, "&quot;", "\"")
	arg_13_1 = string.gsub(arg_13_1, "&amp;", "&")

	return arg_13_1
end

function RichTextEx:create(...)
	return (RichTextEx.new(...))
end

return RichTextEx

local TypeWriter = class("TypeWriter")
local Utf8String = require("app.core.utils.Utf8String")

TypeWriter.SPEED = 50

function TypeWriter:ctor(arg_1_1)
	self._label = arg_1_1.label

	self._label:disableAutoChange()

	self._text = string.gsub(arg_1_1.str, "#", "\n")
	self._textList = self:formatRich()

	if #self._textList == 0 then
		self._textLen = string.len(self._text)
	else
		self._textLen = 0

		for iter_1_0, iter_1_1 in ipairs(self._textList) do
			self._textLen = self._textLen + string.len(iter_1_1.msg)
		end
	end

	self._time = 0
	self._speed = arg_1_1.speed or TypeWriter.SPEED
	self._endCallBack = arg_1_1.callback
	self._scheduleHandler = nil
	self._stayOrigin = arg_1_1.stayOrigin
end

function TypeWriter:formatRich()
	local var_2_0 = {}
	local var_2_1 = string.split(self._text, "&")

	if not var_2_1 or #var_2_1 == 1 then
		return var_2_0
	end

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		local var_2_2 = string.split(iter_2_1, ">")

		if var_2_2 and #var_2_2 > 1 and iter_2_0 % 2 == 0 then
			local var_2_3 = tonumber(string.match(var_2_2[1], "%d+")) or 1
			local var_2_4 = var_2_2[2] or ""

			var_2_0[iter_2_0] = {
				msg = var_2_4,
				color = g.core.common.Color.ui[var_2_3]
			}
		else
			var_2_0[iter_2_0] = {
				msg = iter_2_1
			}
		end
	end

	return var_2_0
end

local function var_0_2(arg_3_0, arg_3_1)
	local var_3_0 = Utf8String.subString(arg_3_0.msg, arg_3_1)

	if arg_3_0.color then
		return string.format("[color=%s]%s[/color]", arg_3_0.color, var_3_0)
	else
		return var_3_0
	end
end

function TypeWriter:getFinalText()
	if #self._textList == 0 then
		return self._text
	else
		local var_4_0 = ""

		for iter_4_0, iter_4_1 in ipairs(self._textList) do
			var_4_0 = var_4_0 .. var_0_2(iter_4_1, self._textLen)
		end

		return var_4_0
	end
end

function TypeWriter:start()
	self._label:setText(self:getFinalText())

	self._autoSizeType = self._label:getAutoSize()

	self._label:setPivot(0, 0)
	self._label:setText("")

	self._scheduleHandler = self._label:newSchedule(handler(self, self.update), 0.1)
end

function TypeWriter:finish()
	self._label:setText(self:getFinalText())

	if not self._stayOrigin and self._autoSizeType then
		self._label:setAutoSize(self._autoSizeType)
	end

	if self._scheduleHandler then
		self._label:cancelSchedule(self._scheduleHandler)

		self._scheduleHandler = nil
	end

	if self._endCallBack then
		self._endCallBack()

		self._endCallBack = nil
	end
end

function TypeWriter:update(arg_7_1, arg_7_2)
	self._time = self._time + arg_7_2

	local var_7_0 = math.min(self._textLen, (math.floor(self._speed * self._time)))

	if #self._textList == 0 then
		self._label:setText((Utf8String.subString(self._text, var_7_0)))
	else
		local var_7_1 = var_7_0
		local var_7_2 = ""

		for iter_7_0, iter_7_1 in ipairs(self._textList) do
			local var_7_3 = string.len(iter_7_1.msg)

			if var_7_3 <= var_7_1 then
				var_7_2 = var_7_2 .. var_0_2(iter_7_1, var_7_3)
				var_7_1 = var_7_1 - var_7_3
			else
				var_7_2 = var_7_2 .. var_0_2(iter_7_1, var_7_1)
				var_7_1 = 0

				break
			end
		end

		self._label:setText(var_7_2)
	end

	if var_7_0 == self._textLen then
		self:finish()
	end
end

return TypeWriter

local PageUtil = class("PageUtil")

PageUtil = PageUtil

function PageUtil:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	pg.DelegateInfo.New(self)

	self._leftBtn = arg_1_1
	self._rightBtn = arg_1_2
	self._maxBtn = arg_1_3
	self._numTxt = arg_1_4

	pressPersistTrigger(self._leftBtn, 0.5, function()
		local var_2_0 = self._curNum - self._addNum

		var_2_0 = self._curNum - self._addNum <= 0 and self._curNum or var_2_0

		self:setCurNum(var_2_0)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(self._rightBtn, 0.5, function()
		local var_3_0 = self._curNum + self._addNum

		if self._maxNum < 0 then
			self:setCurNum(var_3_0)
		else
			var_3_0 = var_3_0 > self._maxNum and self._maxNum or var_3_0

			self:setCurNum(var_3_0)
		end

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	onButton(self, self._maxBtn, function()
		if self._maxNum < 0 then
			-- block empty
		else
			self:setCurNum(self._maxNum)
		end

		return
	end)
	self:setAddNum(1)
	self:setDefaultNum(1)
	self:setMaxNum(-1)

	return
end

function PageUtil:setAddNum(arg_5_1)
	self._addNum = arg_5_1

	return
end

function PageUtil:setDefaultNum(arg_6_1)
	self._defaultNum = arg_6_1

	self:setCurNum(self._defaultNum)

	return
end

function PageUtil:setMaxNum(arg_7_1)
	self._maxNum = arg_7_1

	setActive(self._maxBtn, self._maxNum > 0)

	return
end

function PageUtil:setCurNum(arg_8_1)
	self._curNum = arg_8_1

	setText(self._numTxt, self._curNum)

	if self._numUpdate ~= nil then
		self._numUpdate(self._curNum)
	end

	return
end

function PageUtil:setNumUpdate(arg_9_1)
	self._numUpdate = arg_9_1

	return
end

function PageUtil:getCurNum()
	return self._curNum
end

function PageUtil:Dispose()
	pg.DelegateInfo.Dispose(self)

	return
end

return PageUtil

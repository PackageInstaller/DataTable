local ChapterAutoPageUtil = class("ChapterAutoPageUtil", import("Support.Utils.PageUtil"))

function ChapterAutoPageUtil:Ctor(...)
	ChapterAutoPageUtil.super.Ctor(self, ...)
	pressPersistTrigger(self._leftBtn, 0.5, function()
		local var_2_0 = self._curNum - self._addNum

		var_2_0 = self._curNum - self._addNum < 0 and self._curNum or var_2_0

		self:setCurNum(var_2_0)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(self._rightBtn, 0.5, function()
		local var_3_0 = self._curNum + self._addNum

		for iter_3_0, iter_3_1 in ipairs(self._tipCntList) do
			if iter_3_1 < var_3_0 then
				pg.TipsMgr.GetInstance():ShowTips(self._tipList[iter_3_0])

				break
			end
		end

		if self._maxNum < 0 then
			self:setCurNum(var_3_0)
		else
			var_3_0 = var_3_0 > self._maxNum and self._maxNum or var_3_0

			self:setCurNum(var_3_0)
		end

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	onInputEndEdit(self, self._numTxt, function(arg_4_0)
		if not arg_4_0 or arg_4_0 == "" or not tonumber(arg_4_0) then
			-- block empty
		end

		self:setCurNum((math.clamp(tonumber(arg_4_0), 0, self._maxNum)))

		return
	end)

	return
end

function ChapterAutoPageUtil:SetTipInfo(arg_5_1, arg_5_2)
	self._tipCntList = arg_5_1
	self._tipList = arg_5_2

	return
end

function ChapterAutoPageUtil:setMaxNum(arg_6_1)
	self._maxNum = arg_6_1

	setActive(self._maxBtn, true)

	return
end

function ChapterAutoPageUtil:setCurNum(arg_7_1)
	self._curNum = arg_7_1

	setInputText(self._numTxt, self._curNum)

	if self._numUpdate ~= nil then
		self._numUpdate(self._curNum)
	end

	return
end

return ChapterAutoPageUtil

local BaseBtnStyle = class("BaseBtnStyle")

function BaseBtnStyle:ctor()
	self._btnIndex = self.m_styleController:getSelectedIndex()
	self._lastIndex = self._btnIndex
	self._effect = nil
	self._funcId = 0
	self._grayTip = nil

	if self._btnIndex == 2 or self._btnIndex == 5 or self._btnIndex == 8 then
		self:setTouchable(false)

		if self._btnIndex == 2 then
			self._lastIndex = 0
		elseif self._btnIndex == 5 then
			self._lastIndex = 3
		elseif self._btnIndex == 8 then
			self._lastIndex = 6
		elseif self._btnIndex == 11 then
			self._lastIndex = 9
		end
	end

	if self.m_buttonController then
		self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChanged))
	end

	if self.m_styleController then
		self.m_styleController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onStyleChange))
	end

	self:addClickListener(handler(self, self._onClick))
	self:_updateFontSize()

	self._funcUnlock = self.m_funcUnlockComp

	if self._funcUnlock then
		self._funcUnlock:setEffectType(g.core.const.FuncUnlockConst.EFFECT_TYPE.BUTTON)
		self:_updateFuncUnlockEffect()
	end
end

function BaseBtnStyle:setGray(arg_2_1, arg_2_2)
	if arg_2_2 then
		self._funcId = arg_2_2
	end

	self:setTouchable(not arg_2_1 or self._funcId > 0)

	if not arg_2_1 then
		self.m_styleController:setSelectedIndex(self._lastIndex)

		return
	end

	if self._btnIndex == 0 or self._btnIndex == 1 then
		self._lastIndex = self._btnIndex

		self.m_styleController:setSelectedIndex(2)
	elseif self._btnIndex == 3 or self._btnIndex == 4 then
		self._lastIndex = self._btnIndex

		self.m_styleController:setSelectedIndex(5)
	elseif self._btnIndex == 6 or self._btnIndex == 7 then
		self._lastIndex = self._btnIndex

		self.m_styleController:setSelectedIndex(8)
	elseif self._btnIndex == 9 or self._btnIndex == 10 then
		self._lastIndex = self._btnIndex

		self.m_styleController:setSelectedIndex(11)
	end
end

function BaseBtnStyle:setStyleWithGrayTip(arg_3_1, arg_3_2)
	if arg_3_2 then
		self._grayTip = arg_3_2
	end

	self:setTouchable(arg_3_1 ~= 2 or self._grayTip ~= nil)

	local var_3_0 = math.floor(self._lastIndex / 3)

	self._btnIndex = arg_3_1 == 0 and var_3_0 * 3 or arg_3_1 == 1 and var_3_0 * 3 + 1 or var_3_0 * 3 + 2
	self._btnIndex = math.min(11, math.max(0, self._btnIndex))

	self.m_styleController:setSelectedIndex(self._btnIndex)

	self._lastIndex = self._btnIndex
end

function BaseBtnStyle:setStyle(arg_4_1, arg_4_2)
	if arg_4_2 then
		self._funcId = arg_4_2
	end

	self:setTouchable(arg_4_1 ~= 2 or self._funcId > 0)

	local var_4_0 = math.floor(self._lastIndex / 3)

	self._btnIndex = arg_4_1 == 0 and var_4_0 * 3 or arg_4_1 == 1 and var_4_0 * 3 + 1 or var_4_0 * 3 + 2
	self._btnIndex = math.min(11, math.max(0, self._btnIndex))

	self.m_styleController:setSelectedIndex(self._btnIndex)

	self._lastIndex = self._btnIndex
end

function BaseBtnStyle:getIsGray()
	return self._btnIndex == 2 or self._btnIndex == 5 or self._btnIndex == 8 or self._btnIndex == 11
end

function BaseBtnStyle:_updateFontSize()
	return
end

function BaseBtnStyle:_onChanged()
	return
end

function BaseBtnStyle:_onStyleChange()
	self._btnIndex = self.m_styleController:getSelectedIndex()

	if self._btnIndex == 2 or self._btnIndex == 5 or self._btnIndex == 8 or self._btnIndex == 11 then
		self:setTouchable(self._funcId > 0 or self._grayTip ~= nil)

		if self._btnIndex == 2 then
			self._lastIndex = 0
		elseif self._btnIndex == 5 then
			self._lastIndex = 3
		elseif self._btnIndex == 8 then
			self._lastIndex = 6
		elseif self._btnIndex == 11 then
			self._lastIndex = 9
		end
	else
		self:setTouchable(true)
	end

	self:_updateFuncUnlockEffect()
end

function BaseBtnStyle:_onClick()
	if self._btnIndex == 2 or self._btnIndex == 5 or self._btnIndex == 8 or self._btnIndex == 11 then
		if self._funcId > 0 then
			g.core.common.ModuleUnlock:checkModuleUnlockStatus(self._funcId)
		elseif self._grayTip then
			g.core.module.ModuleManager:tip(self._grayTip)
		end
	end
end

function BaseBtnStyle:addBtnEffect()
	return
end

function BaseBtnStyle:removeBtnEffect()
	if self._effect then
		self._effect:removeFromParent()

		self._effect = nil
	end
end

function BaseBtnStyle:_updateFuncUnlockEffect()
	if self._funcUnlock then
		self._funcUnlock:setEffectParams({
			scaleX = self:getWidth() / 160,
			scaleY = self:getHeight() / 70
		})
	end
end

return BaseBtnStyle

local NewSlgSliderComp = class("NewSlgSliderComp")
local var_0_1 = g.core.const.ConstMgr.NewSlgConst

function NewSlgSliderComp:ctor()
	self._autoHideTime = var_0_1.AUTO_HIDE_SLIDER
	self._slider = self:getChild("slider")

	self._slider:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSliderChanged))
	self._slider:setValue(0)
	self:_onSliderChanged()
	self:getChild("Btn_scale"):addClickListener(handler(self, self._onClickScale))
	self:getChild("Btn_add"):addClickListener(handler(self, self._onClickAdd))
	self:getChild("Btn_sub"):addClickListener(handler(self, self._onClickSub))
end

function NewSlgSliderComp:onLoad()
	return
end

function NewSlgSliderComp:_onAutoSlider()
	local var_3_0 = cc.utils.gettime() / 1000 - self._lastTime

	self._lastTime = cc.utils.gettime() / 1000

	local var_3_1 = self._slider:getValue()
	local var_3_2 = 180

	if self._pos then
		var_3_2 = 220
	end

	local var_3_3 = var_3_1 + var_3_0 * var_3_2

	if var_3_1 + var_3_0 * var_3_2 > 100 then
		var_3_3 = 100

		if self._autoSlider then
			self:cancelSchedule(self._autoSlider)

			self._autoSlider = nil
		end

		if self._pos then
			self:dispatchCompEvent("NewSlg_selectCell", {
				pos = self._pos,
				showArrow = self._showArrow
			})
		else
			self:dispatchCompEvent("NewSlg_slider_end")
		end
	end

	self._slider:setValue(var_3_3)
	self:dispatchCompEvent("NewSlg_slider", {
		value = var_3_3
	})
end

function NewSlgSliderComp:_onAutoHide()
	self._lastHideTime = cc.utils.gettime() / 1000
	self._autoHideTime = self._autoHideTime - (cc.utils.gettime() / 1000 - self._lastHideTime)

	if self._autoHideTime <= 0 then
		if self._autoHide then
			self:cancelSchedule(self._autoHide)

			self._autoHide = nil
		end

		self:getTransition("close"):play()
	end
end

function NewSlgSliderComp:_onSliderChanged()
	if self._autoHideTime <= 0 and not self._pos then
		return
	end

	self._autoHideTime = var_0_1.AUTO_HIDE_SLIDER

	self:dispatchCompEvent("NewSlg_slider", {
		value = self._slider:getValue()
	})
	self:dispatchCompEvent("NewSlg_selectCell")
end

function NewSlgSliderComp:_onClickAdd()
	if self._autoHideTime <= 0 then
		return
	end

	self._slider:setValue((math.min(100, self._slider:getValue() + 10)))
	self:_onSliderChanged()
end

function NewSlgSliderComp:_onClickSub()
	if self._autoHideTime <= 0 then
		return
	end

	self._slider:setValue((math.max(0, self._slider:getValue() - 10)))
	self:_onSliderChanged()
end

function NewSlgSliderComp:_onClickScale()
	if self._autoSlider then
		return
	end

	self:getTransition("open"):play()

	self._autoHideTime = var_0_1.AUTO_HIDE_SLIDER

	if not self._autoHide then
		self._lastHideTime = cc.utils.gettime() / 1000
		self._autoHide = self:newSchedule(handler(self, self._onAutoHide))
	end

	self:dispatchCompEvent("NewSlg_selectCell")
end

function NewSlgSliderComp:autoSlider(arg_9_1, arg_9_2)
	self._pos = arg_9_1
	self._showArrow = arg_9_2

	self:_newSchedule()
end

function NewSlgSliderComp:_onRcvEnter(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self:_newSchedule()
end

function NewSlgSliderComp:_newSchedule()
	if not self._autoSlider then
		self._lastTime = cc.utils.gettime() / 1000
		self._autoSlider = self:newSchedule(handler(self, self._onAutoSlider))
	end
end

return NewSlgSliderComp

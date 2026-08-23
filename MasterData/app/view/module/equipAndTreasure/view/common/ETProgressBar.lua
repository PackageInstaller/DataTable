local ETProgressBar = class("ETProgressBar", require("app.fairyGUI.equipAndTreasure.UI_ETProgressBar"))

function ETProgressBar:ctor()
	self._enablePreview = false
	self._isProgressRunning = false
	self._lastPercent = nil
	self._lastMaxValue = 0
	self._lastCurValue = 0
	self._lastLevel = 0
	self._progressAddEff = nil
	self._percentWidth = self:getBarMaxWidth()
	self._percentHeight = self:getSize().height
end

function ETProgressBar:setPreviewEnable(arg_2_1)
	self._enablePreview = arg_2_1
end

function ETProgressBar:setPreviewPercent(arg_3_1)
	if self._enablePreview then
		arg_3_1 = math.max(0, math.min(100, arg_3_1))

		self.m_previewBarController:setSelectedIndex(1)
		self.m_previewBarImg:setWidth(self._percentWidth * arg_3_1 / 100)

		if not self.m_previewBarImg:getFGActionByTag(10000) then
			local var_3_0 = fgui.FSequence:create({
				fgui.FFadeIn:create(0.5),
				fgui.FFadeOut:create(0.5)
			})

			self.m_previewBarImg:runFGAction(fgui.FRepeatForever:create(var_3_0))
			var_3_0:setTag(10000)
		end
	else
		self.m_previewBarImg:stopAllFGActions()
		self.m_previewBarController:setSelectedIndex(0)
	end
end

function ETProgressBar:setPercent(arg_4_1)
	local var_4_0 = arg_4_1 and arg_4_1.value
	local var_4_1 = arg_4_1 and arg_4_1.max

	if self._isProgressRunning then
		self._isProgressRunning = false

		self:stopAllFGActions()

		if self._progressAddEff then
			self._progressAddEff:removeFromParent()

			self._progressAddEff = nil
		end
	end

	var_4_1 = var_4_1 or self:getMax()

	self:setValue(var_4_0)
	self:setMax(var_4_1)

	self._lastCurValue = var_4_0
	self._lastMaxValue = var_4_1
	self._lastPercent = var_4_0 / var_4_1 * 100
end

return ETProgressBar

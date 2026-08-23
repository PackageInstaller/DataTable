local ThemePuzzleCountdownComp = class("ThemePuzzleCountdownComp", require("app.fairyGUI.summerThemeGame.UI_ThemePuzzleCountdownComp"))

function ThemePuzzleCountdownComp:ctor()
	self._isInit = false
end

function ThemePuzzleCountdownComp:update(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	if arg_2_1.restTime then
		if not self._isInit then
			self._isInit = true

			self.m_progressBar:setValue(arg_2_1.restTime)
		else
			self.m_progressBar:tweenValue(arg_2_1.restTime, 0.1)
		end

		local var_2_0 = math.ceil(arg_2_1.restTime)

		self.m_timeTxt:setText(g.core.lang:get(405802, {
			time = var_2_0
		}))

		if var_2_0 <= 10 then
			self.m_time_colorController:setSelectedIndex(1)
		else
			self.m_time_colorController:setSelectedIndex(0)
		end
	end

	if arg_2_1.maxTime then
		self.m_progressBar:setMax(arg_2_1.maxTime)
	end
end

function ThemePuzzleCountdownComp:onLoad()
	return
end

function ThemePuzzleCountdownComp:onUnload()
	return
end

return ThemePuzzleCountdownComp

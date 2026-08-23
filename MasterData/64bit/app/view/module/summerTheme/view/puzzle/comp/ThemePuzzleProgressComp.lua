local ThemePuzzleProgressComp = class("ThemePuzzleProgressComp", require("app.fairyGUI.summerThemeGame.UI_ThemePuzzleProgressComp"))

function ThemePuzzleProgressComp:ctor()
	return
end

function ThemePuzzleProgressComp:update(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	if arg_2_1.complete then
		self.m_completeNumTxt:setText(arg_2_1.complete)
	end

	if arg_2_1.total then
		self.m_totalNumTxt:setText(arg_2_1.total)
	end
end

function ThemePuzzleProgressComp:onLoad()
	return
end

function ThemePuzzleProgressComp:onUnload()
	return
end

return ThemePuzzleProgressComp

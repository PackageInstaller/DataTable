local ThemePuzzleShowPicComp = class("ThemePuzzleShowPicComp", require("app.fairyGUI.summerThemeGame.UI_ThemePuzzleShowPicComp"))
local var_0_1 = g.core.common.Path

function ThemePuzzleShowPicComp:ctor()
	self._groupPic = nil
end

function ThemePuzzleShowPicComp:updatePic(arg_2_1)
	local var_2_0 = arg_2_1 and arg_2_1.groupPic

	if var_2_0 then
		self._groupPic = var_2_0

		self.m_showPicLoader:setURL((var_0_1:getThemePuzzlePic(var_2_0, true)))
	end
end

function ThemePuzzleShowPicComp:showPic(arg_3_1)
	self.m_show_picController:setSelectedIndex(arg_3_1 and 1 or 0)
end

function ThemePuzzleShowPicComp:onLoad()
	return
end

function ThemePuzzleShowPicComp:onUnload()
	return
end

return ThemePuzzleShowPicComp

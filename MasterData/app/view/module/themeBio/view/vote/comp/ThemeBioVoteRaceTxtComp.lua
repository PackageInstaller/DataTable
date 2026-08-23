local ThemeBioVoteRaceTxtComp = class("ThemeBioVoteRaceTxtComp", require("app.fairyGUI.themeBio.UI_ThemeBioVoteRaceTxtComp"))

function ThemeBioVoteRaceTxtComp:updateRaceTextComp(arg_1_1)
	if not arg_1_1.txt then
		return
	end

	self.m_raceTxt:setText(arg_1_1.txt)

	local var_1_0 = self:getWidth() + self.m_raceTxt:getWidth()

	self.m_raceTxt:stopAllFGActions()
	self.m_raceTxt:runFGAction((fgui.FRepeatForever:create((fgui.FSequence:create({
		fgui.FCallFunc:create(function()
			self.m_raceTxt:setPosition(540, 20)
		end),
		fgui.FMoveBy:create(var_1_0 / 100, {
			y = 0,
			x = -var_1_0
		}),
		fgui.FCallFunc:create(function()
			self.m_raceTxt:setPosition(540, 20)
		end)
	})))))
end

return ThemeBioVoteRaceTxtComp

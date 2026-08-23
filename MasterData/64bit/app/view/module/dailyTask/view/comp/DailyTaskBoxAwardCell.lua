local DailyTaskBoxAwardCell = class("DailyTaskBoxAwardCell", require("app.fairyGUI.dailyTask.UI_DailyTaskBoxAwardCell"))

function DailyTaskBoxAwardCell:updateAwardCell(arg_1_1, arg_1_2)
	self.m_awardEff:removeAllEffect()
	self.m_iconComp:updateIcon(arg_1_1)
	self.m_drawStateController:setSelectedIndex(arg_1_2)

	if arg_1_2 == 1 then
		self.m_awardEff:addEffectSpine({
			name = "eff_ui_common_iconget",
			isLoop = true,
			anim = "play_0"
		})
	end
end

return DailyTaskBoxAwardCell

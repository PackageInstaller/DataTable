local MulTeamTabBtn = class("MulTeamTabBtn", require("app.fairyGUI.mulTeam.UI_MulTeamTabBtn"))

function MulTeamTabBtn:updateComp(arg_1_1)
	arg_1_1 = arg_1_1 or {}

	if arg_1_1.title then
		self:setTitle(arg_1_1.title)
	end

	if arg_1_1.process then
		if arg_1_1.process == 1 then
			self.m_isProcessFullController:setSelectedIndex(1)
		else
			self.m_isProcessFullController:setSelectedIndex(0)
			self.m_percentTxt:setText(string.format("%.0f%%", arg_1_1.process * 100))
		end
	end

	if arg_1_1.idx then
		self.m_teamIndexText:setText(g.core.lang:get(500050 + arg_1_1.idx))
		self:setTitle(g.core.lang:get(500142, {
			num = g.core.lang:get(100 + arg_1_1.idx)
		}))
		self.m_teamIndexNumText:setText(string.format("%02d", arg_1_1.idx))
	end
end

function MulTeamTabBtn:playBtnEffect()
	if not self._spine or tolua.isnull(self._spine) then
		self._spine = self.m_effectNode:addEffectSpine({
			anim = "play",
			name = "eff_ui_fogNightmare_btn",
			isLoop = false
		})
	else
		self._spine:setAnimation(0, "play", false)
	end

	self.m_effectNode:setVisible(true)
end

function MulTeamTabBtn:closeBtnEffect()
	self.m_effectNode:setVisible(false)
end

return MulTeamTabBtn

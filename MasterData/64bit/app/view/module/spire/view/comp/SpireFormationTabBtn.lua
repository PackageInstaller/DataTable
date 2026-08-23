local SpireFormationTabBtn = class("SpireFormationTabBtn", require("app.fairyGUI.spire.UI_SpireFormationTabBtn"))

function SpireFormationTabBtn:updateView(arg_1_1, arg_1_2)
	if not self._mulIndex or arg_1_1 ~= self._mulIndex then
		self.m_redPointComp:setCustomData({
			group = 0,
			formationType = arg_1_2,
			formationIndex = arg_1_1
		})
	end

	self._mulIndex = arg_1_1

	self.m_teamIndexNumText:setText(string.format("%02d", arg_1_1))
	self:setTitle(g.core.lang:get(500142, {
		num = arg_1_1
	}))
	self.m_teamIndexText:setText(g.core.lang:get(500050 + arg_1_1))
end

function SpireFormationTabBtn:playEffectAnimation()
	self.m_effectNode:addEffectSpine({
		remove = true,
		anim = "play",
		name = "eff_ui_fogNightmare_btn",
		isLoop = false
	})
end

return SpireFormationTabBtn

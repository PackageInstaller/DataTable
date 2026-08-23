local RedCliffHeartComp = class("RedCliffHeartComp", require("app.fairyGUI.redCliff.UI_RedCliffHeartComp"))

function RedCliffHeartComp:ctor()
	self._hpEffect = nil
end

function RedCliffHeartComp:updateHeartComp(arg_2_1)
	self.m_maskComp:updateMask(arg_2_1)
	self.m_hp:setText(arg_2_1 .. "%")
end

function RedCliffHeartComp:playReduceHpAnim()
	self._hpEffect = self._hpEffect or self.m_hpEffect:addEffectSpine({
		isLoop = true,
		anim = "play",
		name = "eff_ui_redCliff_reduce"
	})

	self.m_hpEffect:setVisible(true)
end

function RedCliffHeartComp:stopReduceHpAnim()
	self.m_hpEffect:setVisible(false)
end

return RedCliffHeartComp

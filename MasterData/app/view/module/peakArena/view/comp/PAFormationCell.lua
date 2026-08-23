local var_0_0 = g.core.const.ConstMgr.LineUpConst
local PAFormationCell = class("PAFormationCell", require("app.fairyGUI.peakArena.UI_PAFormationCell"))

function PAFormationCell:updateView(arg_1_1)
	if not self._mulIndex or arg_1_1.index ~= self._mulIndex then
		self.m_redPointComp:setCustomData({
			group = 0,
			formationType = var_0_0.MulTeamType.PEAK_ARENA,
			formationIndex = arg_1_1.index
		})
	end

	self._mulIndex = arg_1_1.index

	self.m_teamIndexNumText:setText(string.format("%02d", arg_1_1.index))
	self:setTitle(g.core.lang:get(500142, {
		num = arg_1_1.index
	}))
	self.m_teamIndexText:setText(g.core.lang:get(500050 + arg_1_1.index))
end

function PAFormationCell:playEffectAnimation()
	self.m_effectNode:addEffectSpine({
		anim = "play",
		name = "eff_ui_fogNightmare_btn",
		remove = true,
		isLoop = false
	})
end

return PAFormationCell

local var_0_0 = g.core.const.ConstMgr.LineUpConst
local BlazingArenaFormationCell = class("BlazingArenaFormationCell", require("app.fairyGUI.blazingArena.UI_BlazingArenaFormationCell"))

function BlazingArenaFormationCell:updateView(arg_1_1)
	if not self._mulIndex or arg_1_1 ~= self._mulIndex then
		self.m_redPointComp:setCustomData({
			group = 0,
			formationType = var_0_0.MulTeamType.BLAZING_ARENA,
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

function BlazingArenaFormationCell:playEffectAnimation()
	self.m_effectNode:addEffectSpine({
		isLoop = false,
		name = "eff_ui_fogNightmare_btn",
		anim = "play",
		remove = true
	})
end

return BlazingArenaFormationCell

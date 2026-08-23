local var_0_0 = g.core.const.ConstMgr.LineUpConst
local CrossServerArenaFormationCell = class("CrossServerArenaFormationCell", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaFormationCell"))

function CrossServerArenaFormationCell:updateView(arg_1_1)
	if not self._mulIndex or arg_1_1.index ~= self._mulIndex then
		self.m_redPointComp:setCustomData({
			group = 0,
			formationType = var_0_0.MulTeamType.CROSS_SERVER_ARENA,
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

function CrossServerArenaFormationCell:playEffectAnimation()
	self.m_effectNode:addEffectSpine({
		isLoop = false,
		remove = true,
		anim = "play",
		name = "eff_ui_fogNightmare_btn"
	})
end

return CrossServerArenaFormationCell

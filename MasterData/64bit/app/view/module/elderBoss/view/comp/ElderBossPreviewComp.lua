local var_0_0 = g.core.model.User.elderBossData
local ElderBossPreviewComp = class("ElderBossPreviewComp", require("app.fairyGUI.elderBoss.UI_ElderBossPreviewComp"))

function ElderBossPreviewComp:updateBossInfo(arg_1_1)
	self:setTitle(arg_1_1.name)
	self:setIcon(g.core.common.Path:getElderBossPicById(arg_1_1.id))
	self.m_descTxt:setText(arg_1_1.skill_des)
	self.m_openTimeTxt:setText(arg_1_1.open_time)

	if var_0_0:getCurStage() == g.core.const.ConstMgr.ElderBossConst.STAGE.GAME then
		self.m_stateController:setSelectedIndex(arg_1_1.id == var_0_0:getBossId() and 1 or 0)
	else
		self.m_stateController:setSelectedIndex(0)
	end

	self.m_clearEff:removeAllEffect()
	self.m_clearEff:addEffectSpine({
		isLoop = true,
		name = "eff_ui_elderBoss_clearing",
		anim = "play"
	})
end

return ElderBossPreviewComp

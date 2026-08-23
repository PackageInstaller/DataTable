local var_0_0 = g.core.config.gene_info
local GeneActivateSequenceComp = class("GeneActivateSequenceComp", require("app.fairyGUI.gene.UI_GeneActivateSequenceComp"))

function GeneActivateSequenceComp:update(arg_1_1)
	local var_1_0 = var_0_0.get(arg_1_1.id)

	self.m_iconLoader:setURL((g.core.common.Path:getGenePicByResId(var_1_0.id)))
	self.m_nameTxt:setText(var_1_0.name)
	self.m_sequenceDescTxt:setText(g.core.config.talent_skill_info.get(var_1_0.gene_talent).description)
end

function GeneActivateSequenceComp:playAnimate()
	self.m_enterTransition:play()
	self.m_eff:addEffectSpine({
		remove = false,
		scale = 1,
		isLoop = false,
		name = "eff_ui_common_singlereward"
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_TB_ACTIVEWINDOW)
end

return GeneActivateSequenceComp

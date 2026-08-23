local var_0_0 = g.core.config.gene_info
local var_0_1 = g.core.model.User.geneData
local GeneFigureTitleComp = class("GeneFigureTitleComp", require("app.fairyGUI.gene.UI_GeneFigureTitleComp"))

function GeneFigureTitleComp:updateTitle(arg_1_1)
	self.m_figureNumTxt:setText(g.core.utils.Number.getFormatNum(2, arg_1_1))
	self:setTitle(var_0_0.get(arg_1_1).name)
	self.m_scoreTxt:setText(g.core.lang:get(409808, {
		score = var_0_1:getGeneScore(arg_1_1)
	}))
end

function GeneFigureTitleComp:playEneterAnim()
	self.m_enterTransition:play()
	self.m_effTitle:addEffectSpine({
		remove = true,
		name = "eff_ui_gene_title",
		isLoop = false
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_TB_POPUP)
end

return GeneFigureTitleComp

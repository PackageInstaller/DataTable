local var_0_0 = g.core.config.gene_info
local GeneFigureActivateButton = class("GeneFigureActivateButton", require("app.fairyGUI.gene.UI_GeneFigureActivateButton"))

function GeneFigureActivateButton:updateCost(arg_1_1)
	local var_1_0 = var_0_0.get(arg_1_1)

	self.m_costIconLoader:setIcon((g.core.common.Path:getIconByTypeValue(var_1_0.material_type, var_1_0.material_value, true)))
	self.m_costNumTxt:setText(g.core.model.User.bagData:getOwnNum(var_1_0.material_type, var_1_0.material_value) .. "/" .. var_1_0.material_size)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		geneId = arg_1_1
	})
end

function GeneFigureActivateButton:playActivateAnim()
	self.m_effActivate:addEffectSpine({
		isLoop = false,
		remove = true,
		name = "eff_ui_gene_activate"
	})
	self.m_effLoop:removeAllEffect()
	self.m_effLoop:addEffectSpine({
		isLoop = true,
		name = "eff_ui_gene_activateLoop"
	})
end

return GeneFigureActivateButton

local var_0_0 = g.core.config.gene_info
local var_0_1 = g.core.model.User.geneData
local var_0_2 = g.core.common.Path
local GeneFigureCell = class("GeneFigureCell", require("app.fairyGUI.gene.UI_GeneFigureCell"))

function GeneFigureCell:ctor()
	self._geneInfo = nil

	self:addClickListener(handler(self, self._onClick))
end

function GeneFigureCell:updateFigureCell(arg_2_1)
	local var_2_0 = var_0_0.indexOf(arg_2_1)

	if var_2_0 then
		self.m_figureNameTxt:setText(var_2_0.name)
		self.m_iconLoader:setURL(var_0_2:getGenePicByResId(var_2_0.id))
		self.m_numTxt:setText(g.core.utils.Number.getFormatNum(2, var_2_0.id))

		local var_2_1 = var_0_1:getGeneFragsCntById(var_2_0.id)
		local var_2_2 = var_0_1:getActivatedFragsCnt(var_2_0.id)

		self.m_progressTxt:setText(var_2_2 .. "/" .. var_2_1)
		self.m_progressBar:setPercent({
			cur = var_2_2,
			max = var_2_1
		})
		self.m_stateController:setSelectedIndex((var_0_1:getGeneState(var_2_0.id)))

		self._geneInfo = var_2_0

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				geneId = var_2_0.id
			}
		})
	end
end

function GeneFigureCell:playEnter()
	self.m_enterTransition:play()
	self.m_effCell:addEffectSpine({
		name = "eff_ui_gene_cell",
		isLoop = false,
		remove = true
	})
end

function GeneFigureCell:_onClick()
	if self._geneInfo then
		if var_0_1:getGeneState(self._geneInfo.id) > 0 then
			g.core.module.ModuleManager:pushModule(g.view.entrance.GENE_FIGURE, self._geneInfo.id)
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(409806))
		end
	end
end

return GeneFigureCell

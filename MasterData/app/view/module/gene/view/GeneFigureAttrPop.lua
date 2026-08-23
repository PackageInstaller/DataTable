local var_0_0 = g.core.model.User.geneData
local var_0_1 = g.core.config.gene_info
local var_0_2 = g.core.config.talent_skill_info
local GeneFigureAttrPop = class("GeneFigureAttrPop", require("app.fairyGUI.gene.UI_GeneFigureAttrPop"), function()
	return fgui.GComponent:create({
		resName = "GeneFigureAttrPop",
		pkgPath = "ui/gene/gene",
		pkgName = "gene"
	}, ...)
end)

function GeneFigureAttrPop:ctor(arg_2_1)
	self:showAtCenter()

	self._geneId = arg_2_1
	self._attrInfo = {}

	self.m_figureAttrList:setVirtual()
	self.m_figureAttrList:setItemRenderer(handler(self, self._onRenderFigureAttrList))
end

function GeneFigureAttrPop:onLoad()
	for iter_3_0, iter_3_1 in pairs((var_0_0:getGeneAttr(self._geneId))) do
		local var_3_0, var_3_1 = g.core.lang:getAttr(iter_3_0, iter_3_1, true)

		table.insert(self._attrInfo, {
			name = var_3_0,
			value = var_3_1
		})
	end

	self.m_figureAttrList:setNumItems(#self._attrInfo)
	self.m_isEmptyController:setSelectedIndex(#self._attrInfo == 0 and 1 or 0)

	local var_3_2 = var_0_1.get(self._geneId)

	self.m_figureNameTxt:setText(var_3_2.name)
	self.m_bgPanel:setTitle(var_3_2.name)

	local var_3_3 = var_0_2.get(var_3_2.gene_talent)

	for iter_3_2 = 1, 3 do
		if var_3_3["affect_type_" .. iter_3_2] > 0 then
			local var_3_4, var_3_5 = g.core.lang:getAttr(var_3_3["affect_type_" .. iter_3_2], var_3_3["affect_value_" .. iter_3_2], false)

			self["m_attrName" .. iter_3_2]:setText(g.core.lang:get(1010) .. var_3_4)
			self["m_attrValue" .. iter_3_2]:setText(var_3_5)
		end

		self["m_attrName" .. iter_3_2]:setVisible(var_3_3["affect_type_" .. iter_3_2] > 0)
		self["m_attrValue" .. iter_3_2]:setVisible(var_3_3["affect_type_" .. iter_3_2] > 0)
	end

	self.m_isTalentActivateController:setSelectedIndex(var_0_0:getGeneState(self._geneId) == 2 and 1 or 0)
end

function GeneFigureAttrPop:_onRenderFigureAttrList(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._attrInfo[arg_4_1 + 1])
end

return GeneFigureAttrPop

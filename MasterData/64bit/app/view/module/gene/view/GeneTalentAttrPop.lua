local var_0_0 = g.core.config.gene_info
local GeneTalentAttrPop = class("GeneTalentAttrPop", require("app.fairyGUI.gene.UI_GeneTalentAttrPop"), function()
	return fgui.GComponent:create({
		resName = "GeneTalentAttrPop",
		pkgName = "gene",
		pkgPath = "ui/gene/gene"
	}, ...)
end)

function GeneTalentAttrPop:ctor()
	self:showAtCenter()
	self.m_talentList:setVirtual()
	self.m_talentList:setItemRenderer(handler(self, self._onRenderTalentList))
end

function GeneTalentAttrPop:onLoad()
	self.m_talentList:setNumItems(var_0_0.getLength())
end

function GeneTalentAttrPop:_onRenderTalentList(arg_4_1, arg_4_2)
	arg_4_2:updateTalentCell(arg_4_1 + 1)
end

return GeneTalentAttrPop

local var_0_0 = g.core.model.User.geneData
local GeneAttributeOverviewPop = class("GeneAttributeOverviewPop", require("app.fairyGUI.gene.UI_GeneAttributeOverviewPop"), function()
	return fgui.GComponent:create({
		resName = "GeneAttributeOverviewPop",
		pkgPath = "ui/gene/gene",
		pkgName = "gene"
	}, ...)
end)

function GeneAttributeOverviewPop:ctor()
	self:showAtCenter()

	self._attrInfo = {}

	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrList))
end

function GeneAttributeOverviewPop:onLoad()
	self._attrInfo = var_0_0:getTotalAttrInfo()

	self.m_attrList:setNumItems(#self._attrInfo)
	self.m_isEmptyController:setSelectedIndex(#self._attrInfo == 0 and 1 or 0)
end

function GeneAttributeOverviewPop:_onRenderAttrList(arg_4_1, arg_4_2)
	if self._attrInfo[arg_4_1 + 1] then
		arg_4_2:updateCell(self._attrInfo[arg_4_1 + 1])
	end
end

return GeneAttributeOverviewPop

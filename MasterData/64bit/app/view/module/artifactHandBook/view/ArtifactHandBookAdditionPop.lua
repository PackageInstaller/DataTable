local ArtifactHandBookAdditionPop = class("ArtifactHandBookAdditionPop", require("app.fairyGUI.artifactHandbook.UI_ArtifactHandBookAdditionPop"), function()
	return fgui.GComponent:create({
		resName = "ArtifactHandBookAdditionPop",
		pkgPath = "ui/artifactHandbook/artifactHandbook",
		pkgName = "artifactHandbook"
	}, ...)
end)

function ArtifactHandBookAdditionPop:ctor()
	self:showAtCenter()
	self.m_normalAdditionList:setVirtual()
	self.m_normalAdditionList:setItemRenderer(handler(self, self._onBaseAdditionRenderer))
	self.m_fettersAdditionList:setVirtual()
	self.m_fettersAdditionList:setItemRenderer(handler(self, self._onFetterAdditionRenderer))
	self:updateView()
end

function ArtifactHandBookAdditionPop:updateView()
	self.m_normalEmpty:setVisible(false)
	self.m_fettersEmpty:setVisible(false)

	local var_3_0, var_3_1, var_3_2 = g.core.model.User.artifactHandBookData:getAllBaseAdditions()
	local var_3_3, var_3_4, var_3_5 = g.core.model.User.artifactHandBookData:getAllFettersAdditions()

	self._baseAttrs = var_3_0
	self._fettersAttrs = var_3_3

	self.m_normalAdditionTitle:setTitle(g.core.lang:get(205515, {
		num1 = var_3_1,
		num2 = var_3_2
	}))
	self.m_fettersAdditionTitle:setTitle(g.core.lang:get(205516, {
		num1 = var_3_4,
		num2 = var_3_5
	}))
	self.m_normalAdditionList:setNumItems(#self._baseAttrs)
	self.m_fettersAdditionList:setNumItems(#self._fettersAttrs)

	if #self._baseAttrs == 0 then
		self.m_normalEmpty:setVisible(true)
	end

	if #self._fettersAttrs == 0 then
		self.m_fettersEmpty:setVisible(true)
	end
end

function ArtifactHandBookAdditionPop:_onBaseAdditionRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateAttr(self._baseAttrs[arg_4_1 + 1])
end

function ArtifactHandBookAdditionPop:_onFetterAdditionRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateAttr(self._fettersAttrs[arg_5_1 + 1])
end

return ArtifactHandBookAdditionPop

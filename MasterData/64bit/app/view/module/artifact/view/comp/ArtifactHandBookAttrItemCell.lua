local ArtifactHandBookAttrItemCell = class("ArtifactHandBookAttrItemCell", require("app.fairyGUI.artifactHandbook.UI_ArtifactHandBookAttrItemCell"))

function ArtifactHandBookAttrItemCell:ctor()
	self._initIconScale = self.m_iconImg:getScaleX()
end

function ArtifactHandBookAttrItemCell:updateArtifactURBookAttr(arg_2_1, arg_2_2)
	self.m_iconImg:setURL(arg_2_1.icon)

	local var_2_0 = arg_2_1.name

	if arg_2_1.isAll then
		var_2_0 = g.core.lang:get(2071, {
			name = var_2_0
		})
	end

	self.m_iconImg:setScale(arg_2_1.iconScale or self._initIconScale)
	self.m_nameTxt:setText(var_2_0)
	self.m_valueTxt:setText(arg_2_1.value1)

	if arg_2_1.value2 then
		self.m_nextValueTxt:setText(arg_2_1.value2)
	end

	self.m_stateController:setSelectedIndex(arg_2_2 and 1 or 0)
end

return ArtifactHandBookAttrItemCell

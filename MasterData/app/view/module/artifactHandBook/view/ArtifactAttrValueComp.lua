local ArtifactAttrValueComp = class("ArtifactAttrValueComp", require("app.fairyGUI.artifactHandbook.UI_ArtifactAttrValueComp"))

function ArtifactAttrValueComp:updateAttr(arg_1_1)
	local var_1_0, var_1_1 = g.core.lang:getAttr(arg_1_1.type, tonumber(arg_1_1.value), arg_1_1.withoutPlus1 ~= false and true or false)

	if arg_1_1.isAll then
		var_1_0 = g.core.lang:get(2071, {
			name = var_1_0
		})
	end

	if arg_1_1.isAllDev then
		var_1_0 = g.core.lang:get(2079, {
			name = var_1_0
		})
	end

	self.m_attName:setText(var_1_0)
	self.m_firstAttValue:setText(var_1_1)
end

return ArtifactAttrValueComp

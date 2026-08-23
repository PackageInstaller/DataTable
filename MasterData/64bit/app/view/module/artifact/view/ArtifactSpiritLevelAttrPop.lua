local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local ArtifactSpiritLevelAttrPop = class("ArtifactSpiritLevelAttrPop", require("app.fairyGUI.artifact.UI_ArtifactSpiritLevelAttrPop"), function()
	return fgui.GComponent:create({
		pkgName = "artifact",
		resName = "ArtifactSpiritLevelAttrPop",
		pkgPath = "ui/artifact/artifact"
	}, ...)
end)

function ArtifactSpiritLevelAttrPop:ctor(arg_2_1)
	self:showAtCenter()

	self._artifactStruct = arg_2_1

	self.m_typeController:setSelectedIndex(0)
	self:updateSpiritLevelAttr()
end

function ArtifactSpiritLevelAttrPop:updateSpiritLevelAttr()
	local var_3_0 = self._artifactStruct:getSpiritLevelAttrs()

	self._isFullStar = self._artifactStruct:isSpiritMaxLevel()

	self.m_stateController:setSelectedIndex(self._isFullStar and 1 or 0)

	for iter_3_0 = 1, ArtifactConst.SPIRIT_ATTR_NUM do
		if self["m_attrComp" .. iter_3_0] then
			if var_3_0[iter_3_0] then
				self["m_attrComp" .. iter_3_0]:setVisible(true)
				self["m_attrComp" .. iter_3_0]:updateAttr(var_3_0[iter_3_0].attrs)
			else
				self["m_attrComp" .. iter_3_0]:setVisible(false)
			end
		end

		if not self._isFullStar and self["m_attrValueNext" .. iter_3_0] then
			if var_3_0[iter_3_0] and var_3_0[iter_3_0].nextValue then
				self["m_attrValueNext" .. iter_3_0]:setVisible(true)
				self["m_attrValueNext" .. iter_3_0]:setText(var_3_0[iter_3_0].nextValue)
			else
				self["m_attrValueNext" .. iter_3_0]:setVisible(false)
			end
		end
	end
end

return ArtifactSpiritLevelAttrPop

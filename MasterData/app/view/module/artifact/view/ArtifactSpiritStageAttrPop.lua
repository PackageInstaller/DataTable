local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local ArtifactSpiritStageAttrPop = class("ArtifactSpiritStageAttrPop", require("app.fairyGUI.artifact.UI_ArtifactSpiritLevelAttrPop"), function()
	return fgui.GComponent:create({
		resName = "ArtifactSpiritLevelAttrPop",
		pkgPath = "ui/artifact/artifact",
		pkgName = "artifact"
	}, ...)
end)

function ArtifactSpiritStageAttrPop:ctor(arg_2_1)
	self:showAtCenter()

	self._artifactStruct = arg_2_1

	self.m_typeController:setSelectedIndex(1)
	self:updateSpiritStageAttr()
end

function ArtifactSpiritStageAttrPop:updateSpiritStageAttr()
	local var_3_0 = self._artifactStruct:getSpiritStageAttrs()

	self._isFullStar = self._artifactStruct:isSpiritMaxStage()

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

return ArtifactSpiritStageAttrPop

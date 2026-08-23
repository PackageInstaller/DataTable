local var_0_0 = g.core.model.User.artifactHandBookData
local ArtifactHandBookGroupDetailPop = class("ArtifactHandBookGroupDetailPop", require("app.fairyGUI.artifactHandbook.UI_ArtifactHandBookGroupDetailPop"), function()
	return fgui.GComponent:create({
		resName = "ArtifactHandBookGroupDetailPop",
		pkgName = "artifactHandbook",
		pkgPath = "ui/artifactHandbook/artifactHandbook"
	}, ...)
end)

function ArtifactHandBookGroupDetailPop:ctor(arg_2_1)
	self:showAtCenter()

	self._params = arg_2_1

	self:updateView()
end

function ArtifactHandBookGroupDetailPop:updateView()
	local var_3_1 = var_0_0:getTargetLvCfg(self._params.id or self._params.advId, self._params.lv) or self._params.info

	if var_3_1.type == 2 then
		-- block empty
	end

	self.m_normalAdditionTitle:setTitle(g.core.lang:get(205525))
	self.m_bgPanel:setTitle(var_3_1.name)
	self.m_descTxt:setText(var_3_1.des)

	for iter_3_0 = 1, 4 do
		self["m_attr" .. iter_3_0]:setVisible(false)

		if var_3_1["affect_type_" .. iter_3_0] ~= 0 then
			self["m_attr" .. iter_3_0]:updateAttr({
				isAll = true,
				type = var_3_1["affect_type_" .. iter_3_0],
				value = var_3_1["affect_value_" .. iter_3_0]
			})
			self["m_attr" .. iter_3_0]:setVisible(true)
		end
	end

	self.m_fullTxt:setVisible(self._params.isMax)
end

return ArtifactHandBookGroupDetailPop

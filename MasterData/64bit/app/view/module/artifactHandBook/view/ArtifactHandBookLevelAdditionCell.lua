local var_0_0 = g.core.model.User.artifactHandBookData
local ArtifactHandBookLevelAdditionCell = class("ArtifactHandBookLevelAdditionCell", require("app.fairyGUI.artifactHandbook.UI_ArtifactHandBookLevelAdditionCell"))

function ArtifactHandBookLevelAdditionCell:updateNextAttrShow()
	self.m_stateController:setSelectedIndex(0)

	local var_1_0 = var_0_0:getNextLvHandBookCfg()

	if var_1_0 then
		self.m_titleTxt:setText(g.core.lang:get(205543, {
			level = var_1_0.id,
			score = var_1_0.score
		}))

		local var_1_1 = ""

		for iter_1_0 = 1, 4 do
			if var_1_0["affect_type_" .. iter_1_0] > 0 then
				local var_1_2, var_1_3 = g.core.lang:getAttr(var_1_0["affect_type_" .. iter_1_0], var_1_0["affect_value_" .. iter_1_0], false)

				var_1_1 = var_1_1 .. g.core.lang:get(2071, {
					name = var_1_2
				}) .. var_1_3 .. "   "
			end
		end

		self.m_descTxt:setText(var_1_1)
	end
end

return ArtifactHandBookLevelAdditionCell

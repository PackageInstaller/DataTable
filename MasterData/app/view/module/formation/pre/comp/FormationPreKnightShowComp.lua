local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.knightsData
local var_0_2 = g.core.model.User.artifactData
local FormationPreKnightShowComp = class("FormationPreKnightShowComp", require("app.fairyGUI.formation.UI_FormationPreKnightShowComp"))

function FormationPreKnightShowComp:ctor()
	return
end

function FormationPreKnightShowComp:updateComp(arg_2_1)
	local var_2_0 = arg_2_1.index or 0
	local var_2_1 = arg_2_1.knightSid or 0

	self:_updateAssociationKnight(arg_2_1.mainKnightSid)
	self:_updateAssociationArtifact(var_2_0)
	self:_updateKnight(var_2_1)
end

function FormationPreKnightShowComp:_updateAssociationKnight(arg_3_1)
	local var_3_0 = var_0_1:getKnightById(arg_3_1)

	self.m_knightLevelTxt:setText(g.core.lang:get(201577, {
		level = var_3_0:getLevel()
	}))
	self.m_advLevelTxt:setText(g.core.lang:get(200042, {
		stage = var_3_0:getAdvanceLevel()
	}))
	self.m_associationIcon:setURL((var_0_0:getKnightIconById(var_3_0:getBaseInfo().res_id)))
end

function FormationPreKnightShowComp:_updateAssociationArtifact(arg_4_1)
	local var_4_0 = var_0_2:getArtifactByPos(arg_4_1)

	if var_4_0 then
		self.m_artifactLevelTxt:setText(g.core.lang:get(201577, {
			level = var_4_0:getLevel()
		}))
		self.m_artifactIcon:setURL((var_0_0:getArtifactEntranceIcon(var_4_0:getCfg().res_id)))
		self.m_isArtifactEmptyController:setSelectedIndex(0)
	else
		self.m_isArtifactEmptyController:setSelectedIndex(1)
	end
end

function FormationPreKnightShowComp:_updateKnight(arg_5_1)
	self.m_knightLoader:updateKnightComp((var_0_1:getKnightById(arg_5_1):getBaseInfo()))
end

return FormationPreKnightShowComp

local var_0_0 = g.core.const.ConstMgr.PetConst
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.explorationData
local ExplorationFormationLineupPetCell = class("ExplorationFormationLineupPetCell", require("app.fairyGUI.exploration.UI_ExplorationFormationLineupPetCell"))

function ExplorationFormationLineupPetCell:ctor()
	self._formationData = var_0_2:getFormationData()

	self.getSharedTrans(self, "listCrosbandBUiRightIn_cell", "LineUpRightList", self)
	self.m_stageTxt:setVisible(false)
	self.m_starComp:initStar({
		gap = 0,
		style = 1,
		index = 3,
		num = 0,
		max = var_0_0.STAR_MAX
	})
end

function ExplorationFormationLineupPetCell:updateCell(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1:getCfg()

	self.m_qualityBgLoader:setURL((var_0_1:getBaseIconQualityBg(var_2_0.quality)))
	self.m_petIconLoader:setURL((var_0_1:getPetIcon(var_2_0.resource)))
	self.m_nameTxt:setText(var_2_0.name)
	self.m_levelTxt:setText(g.core.lang:get(200017, {
		level = arg_2_1:getLevel()
	}))
	self.m_starComp:setStarNum(arg_2_1:getStarNum())

	if self._formationData:isPetLineup((arg_2_1:getSid())) then
		self.m_lineupController:setSelectedIndex(1)
	else
		self.m_lineupController:setSelectedIndex(0)
	end
end

return ExplorationFormationLineupPetCell

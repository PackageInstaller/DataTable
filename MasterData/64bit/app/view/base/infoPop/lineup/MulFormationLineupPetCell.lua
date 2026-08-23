local var_0_0 = g.core.const.ConstMgr.PetConst
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.mulFormationData
local MulFormationLineupPetCell = class("MulFormationLineupPetCell", require("app.fairyGUI.infoPop.UI_MulFormationLineupPetCell"))

function MulFormationLineupPetCell:ctor()
	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)
	self.m_stageTxt:setVisible(false)
	self.m_starComp:initStar({
		index = 3,
		gap = 0,
		style = 1,
		num = 0,
		max = var_0_0.STAR_MAX
	})
end

function MulFormationLineupPetCell:updateCell(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1:getCfg()

	self.m_qualityBgLoader:setURL((var_0_1:getBaseIconQualityBg(var_2_0.quality)))
	self.m_petIconLoader:setURL((var_0_1:getPetIcon(var_2_0.resource)))
	self.m_nameTxt:setText(var_2_0.name)
	self.m_levelTxt:setText(g.core.lang:get(200017, {
		level = arg_2_1:getLevel()
	}))
	self.m_starComp:setStarNum(arg_2_1:getStarNum())

	if var_0_2:isPetLineup(arg_2_2.formationType, arg_2_1:getSid(), arg_2_1:getCfg().advance_id) then
		self.m_lineupController:setSelectedIndex(1)
	else
		self.m_lineupController:setSelectedIndex(0)
	end
end

return MulFormationLineupPetCell

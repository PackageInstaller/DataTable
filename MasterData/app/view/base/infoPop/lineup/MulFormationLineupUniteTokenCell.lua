local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.uniteTokenData
local var_0_2 = g.core.model.User.mulFormationData
local MulFormationLineupUniteTokenCell = class("MulFormationLineupUniteTokenCell", require("app.fairyGUI.infoPop.UI_MulFormationLineupUniteTokenCell"))

function MulFormationLineupUniteTokenCell:ctor()
	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)
end

function MulFormationLineupUniteTokenCell:updateCell(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1:getSkillId()

	self.m_skillIcon:updateIcon({
		skillId = var_2_0
	})
	self.m_nameText:setText(arg_2_1:getName())
	self.m_featureText:setText(g.core.config.skill_range_info.get(var_0_1:getTokenBaseInfo(var_2_0).skillInfo.cfg.skill_range_info).name)
	self.m_qualityBgLoader:setURL((var_0_0:getFormationUniteTokenBg((arg_2_1:getQuality()))))

	local var_2_1 = arg_2_1:getServerId()

	if arg_2_2.formationType == g.core.const.ConstMgr.LineUpConst.MulTeamType.BLAZING_ARENA then
		local var_2_2 = arg_2_1:getRealServerId()

		if var_2_2 ~= 0 then
			var_2_1 = var_2_2
		end
	end

	if var_0_2:isUniteTokenLineup(arg_2_2.formationType, var_2_1) then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

return MulFormationLineupUniteTokenCell

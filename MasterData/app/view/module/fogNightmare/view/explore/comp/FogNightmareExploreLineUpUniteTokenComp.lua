local var_0_0 = g.core.model.User.fogNightmareData
local FogNightmareExploreLineUpUniteTokenComp = class("FogNightmareExploreLineUpUniteTokenComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreLineUpUniteTokenComp"))
local var_0_2 = g.core.model.User

function FogNightmareExploreLineUpUniteTokenComp:ctor()
	self._skillInfo = nil
	self._skillTip = {}
	self._skillIcon = self.m_skillIcon

	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)
end

function FogNightmareExploreLineUpUniteTokenComp:updateComp(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1:getSkillId()

	self._skillInfo = var_0_2.uniteTokenData:getTokenBaseInfo(var_2_0).skillInfo
	self._skillTip = {
		skillId = var_2_0,
		star = arg_2_1:getStarLevel(),
		uniteTokenAdvId = arg_2_1:getAdvanceId()
	}

	self._skillIcon:updateIcon({
		skillId = var_2_0
	})
	self.m_nameText:setText(arg_2_1:getName())
	self.m_featureText:setText(g.core.config.skill_range_info.get(self._skillInfo.cfg.skill_range_info).name)
	self.m_qualityBgLoader:setURL((g.core.common.Path:getFormationUniteTokenBg((arg_2_1:getQuality()))))

	local var_2_1 = arg_2_2.curFormation
	local var_2_2, var_2_3

	if not arg_2_2.curFormation then
		var_2_1 = 0
		var_2_2 = var_0_0:getFormationData()
		var_2_3 = arg_2_1
	end

	if var_2_2:checkUniteInAllFormation(var_2_3, g.core.config.multi_team_formation_info.get(g.core.const.ConstMgr.LineUpConst.MulTeamType.FOG_NIGHTMARE).unite_token_repeat == 1 and var_2_1 or nil) then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

function FogNightmareExploreLineUpUniteTokenComp:_clickIcon()
	if self._skillInfo then
		-- block empty
	end
end

return FogNightmareExploreLineUpUniteTokenComp

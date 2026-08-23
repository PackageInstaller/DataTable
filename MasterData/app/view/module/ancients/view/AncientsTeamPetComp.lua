local AncientsTeamPetComp = class("AncientsTeamPetComp", require("app.fairyGUI.ancients.UI_AncientsTeamPetComp"))
local var_0_2 = g.core.const.ConstMgr.AncientsConst

function var_0_0:ctor()
	self._compSkills = {
		self.m_Comp_skill1,
		self.m_Comp_skill2,
		self.m_Comp_skill3
	}
	self._petPic = nil
end

function var_0_0:updateView()
	local var_2_0 = g.core.model.User.ancientsData:getTeamPetId(var_0_2.GET_TEAM_TYPE.CURRENT_TEAM)

	if var_2_0 == 0 then
		return
	end

	self.m_Txt_pet_name:setText(g.core.config.ancients_pet_info.get(var_2_0).name)
	self.m_Txt_pet_level:setText(g.core.model.User.ancientsData:getTeamPetLevel(var_0_2.GET_TEAM_TYPE.CURRENT_TEAM))

	local var_2_1 = g.core.model.User.ancientsData:getPetSkillsInfo(var_0_2.GET_TEAM_TYPE.CURRENT_TEAM)

	for iter_2_0, iter_2_1 in ipairs(self._compSkills) do
		iter_2_1:updateIcon(var_2_1[iter_2_0])
	end

	self.m_Comp_SoulPetSpine:updateView()
end

return var_0_0

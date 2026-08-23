local AncientsLineupPetComp = class("AncientsLineupPetComp", require("app.fairyGUI.ancients.UI_AncientsLineupPetComp"))
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
	self.m_Txt_pet_level:setText(g.core.model.User.ancientsData:getTeamPetLevel(var_0_2.GET_TEAM_TYPE.CURRENT_TEAM))
	self.m_Txt_pet_fight_value:setText(g.core.model.User.ancientsData:getTeamPetFightValue(var_0_2.GET_TEAM_TYPE.CURRENT_TEAM))

	local var_2_0 = g.core.model.User.ancientsData:getPetSkillsInfo(var_0_2.GET_TEAM_TYPE.CURRENT_TEAM)

	for iter_2_0, iter_2_1 in ipairs(self._compSkills) do
		iter_2_1:updateIcon(var_2_0[iter_2_0])
	end

	local var_2_1 = g.core.model.User.ancientsData:getTeamPetId(var_0_2.GET_TEAM_TYPE.CURRENT_TEAM)

	if var_2_1 == 0 then
		return
	end

	local var_2_2 = g.core.config.ancients_pet_info.get(var_2_1).advance_id
	local var_2_3 = self.m_Comp_spine:getChild("DrawPet")

	if var_2_3 and var_2_2 == var_2_3:getAdvId() then
		return
	end

	local var_2_4 = require("app.view.common.DrawPet").new({
		isShowBg = false,
		scale = 1,
		advId = var_2_2
	})

	self.m_Comp_spine:removeChildren()
	self.m_Comp_spine:addChild(var_2_4)

	local var_2_5 = self.m_Comp_spine:getSize()

	var_2_4:setPosition(var_2_5.width / 2, var_2_5.height / 2)
	self.m_stateController:setSelectedIndex(g.core.model.User.ancientsData:isFinalState() and 1 or 0)
end

return var_0_0

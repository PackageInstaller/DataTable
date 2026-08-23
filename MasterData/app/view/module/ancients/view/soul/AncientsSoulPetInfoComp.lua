local AncientsSoulPetInfoComp = class("AncientsSoulPetInfoComp", require("app.fairyGUI.ancients.UI_AncientsSoulPetInfoComp"))
local var_0_2 = g.core.const.ConstMgr.AncientsConst

function var_0_0:ctor()
	self._level = nil
	self._skillComps = {
		self.m_Comp_skill1,
		self.m_Comp_skill2,
		self.m_Comp_skill3
	}
end

function var_0_0:updateView()
	self:_updateSkills()
	self:_updateInfo()
end

function var_0_0:_updateInfo()
	local var_3_0 = g.core.model.User.ancientsData:getCurPetLevelInfo()
	local var_3_1 = var_3_0.next_level

	self.m_Txt_level:setText(tostring(var_3_0.level))

	if not self._level then
		self._level = var_3_0.level
	elseif self._level ~= var_3_0.level then
		self._level = var_3_0.level

		self:dispatchCompEvent("AncientSoulPetLevelup")
	end

	if var_3_1 == 0 then
		self.m_Comp_prog:setMax(100)
		self.m_Comp_prog:setValue(100)
	else
		local var_3_2 = g.core.model.User.ancientsData:getPetLevelInfo(g.core.model.User.ancientsData:getPetBaseId(), var_3_1).exp
		local var_3_3 = g.core.model.User.ancientsData:getPetExp()

		self.m_Txt_exp:setText(g.core.lang:get(433397, {
			cur = var_3_3,
			max = var_3_2
		}))
		self.m_Comp_prog:setMax(var_3_2)
		self.m_Comp_prog:setValue(var_3_3)
	end
end

function var_0_0:_updateSkills()
	local var_4_0 = g.core.model.User.ancientsData:getPetSkillsInfo(var_0_2.GET_TEAM_TYPE.CURRENT_TEAM)

	for iter_4_0, iter_4_1 in ipairs(self._skillComps) do
		iter_4_1:updateIcon(var_4_0[iter_4_0])
	end
end

return var_0_0

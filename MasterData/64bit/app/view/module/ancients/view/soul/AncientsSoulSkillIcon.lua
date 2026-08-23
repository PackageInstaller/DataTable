local AncientsSoulSkillIcon = class("AncientsSoulSkillIcon", require("app.fairyGUI.ancients.UI_AncientsSoulSkillIcon"))

function var_0_0:ctor()
	self.m_Comp_circleIcon:addClickListener(handler(self, self._onClick))
end

function var_0_0:_onClick()
	if self._params then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.PetSkillDescTip").new({
			skillType = 117,
			isPassive = true,
			petAdvId = g.core.model.User.ancientsData:getPetInfoById((g.core.model.User.ancientsData:getPetBaseId(g.core.const.ConstMgr.AncientsConst.GET_TEAM_TYPE.CURRENT_TEAM))).advance_id,
			skillId = self._params.skillId + self._params.level,
			star = self._params.level,
			customSkillArray = self:getPassiveArr()
		}), {
			touchDisappear = true
		})
	end
end

function var_0_0:updateIcon(arg_3_1)
	if not arg_3_1 then
		return
	end

	self._params = arg_3_1

	self.m_Comp_circleIcon:updateIcon({
		isPassive = true,
		skillId = arg_3_1.skillId + arg_3_1.level
	})
	self.m_lockController:setSelectedIndex(arg_3_1.level > 0 and 0 or 1)
end

function var_0_0:getPassiveArr()
	local var_4_0 = g.core.config.ancients_pet_level_info.match(function(arg_5_0)
		if arg_5_0.pet_id == g.core.model.User.ancientsData:getPetBaseId(g.core.const.ConstMgr.AncientsConst.GET_TEAM_TYPE.CURRENT_TEAM) then
			return arg_5_0
		end
	end)
	local var_4_1 = {}

	for iter_4_0 = 1, #var_4_0 do
		local var_4_2 = self._params.index == 1 and var_4_0[iter_4_0].skill1 or var_4_0[iter_4_0].skill2

		if var_4_2 > 0 then
			local var_4_3 = {}
			local var_4_5 = g.core.model.User.ancientsData:getPetLevel(g.core.const.ConstMgr.AncientsConst.GET_TEAM_TYPE.CURRENT_TEAM)

			var_4_3.talentLevel = var_4_0[iter_4_0].level
			var_4_3.skillId = var_4_2
			var_4_3.value = var_4_5 or 0

			if var_4_2 == 0 or var_4_0[iter_4_0].level <= var_4_5 then
				-- block empty
			end

			table.insert(var_4_1, var_4_3)
		end
	end

	return var_4_1
end

return var_0_0

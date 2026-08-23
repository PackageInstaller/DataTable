local AncientsTeamProgComp = class("AncientsTeamProgComp", require("app.fairyGUI.ancients.UI_AncientsTeamProgComp"))

function AncientsTeamProgComp:ctor()
	self:addClickListener(handler(self, self._onClickSelf))
	self.m_helpBtn:addClickListener(handler(self, self._onClickHelpBtn))
end

function AncientsTeamProgComp:updateView()
	local var_2_0 = g.core.model.User.ancientsData:getCurPetLevelInfo()

	if not var_2_0 then
		return
	end

	self:_updateProg(g.core.model.User.ancientsData, var_2_0)
	self.m_Txt_pet_fight_value:setText(g.core.lang:get(433322, {
		value = g.core.model.User.ancientsData:getTeamPetFightValue()
	}))
	self.m_Comp_SoulPetSpine:updateView()
end

function AncientsTeamProgComp:_updateProg(arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1:getTeamPetId()

	self.m_Txt_team_level:setText(arg_3_2.level)

	if arg_3_2.next_level == 0 then
		self.m_Txt_prog:setText(g.core.lang:get(429581))
		self:setMax(100)
		self:setValue(100)
	elseif var_3_0 ~= 0 then
		local var_3_1 = arg_3_1:getPetLevelInfo(var_3_0, arg_3_2.next_level)
		local var_3_2 = arg_3_1:getPetExp()

		self.m_Txt_prog:setText(g.core.lang:get(433301, {
			num1 = var_3_2,
			num2 = var_3_1.exp
		}))
		self:setMax(var_3_1.exp)
		self:setValue(var_3_2)
	end
end

function AncientsTeamProgComp:_onClickSelf()
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_SOUL_POP)
end

function AncientsTeamProgComp:_onClickHelpBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
		id = g.core.const.ConstMgr.AncientsConst.PET_HELP_ID
	}), {
		touchDisappear = true
	})
end

return AncientsTeamProgComp

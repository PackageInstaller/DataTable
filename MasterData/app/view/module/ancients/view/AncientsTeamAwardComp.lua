local AncientsTeamAwardComp = class("AncientsTeamAwardComp", require("app.fairyGUI.ancients.UI_AncientsTeamAwardComp"))

function var_0_0:ctor()
	self._boxEffect = nil

	self.m_Btn_icon:addClickListener(handler(self, self._onClickBtnIcon))
end

function var_0_0:updateView()
	local var_2_0 = g.core.model.User.ancientsData:getAwardProg(g.core.model.User.ancientsData:getAwardExp())

	if var_2_0.cfg then
		self.m_Btn_icon:setIcon(g.core.common.Path:getAncientsTeamBoxIcon(var_2_0.cfg.quality))
	end

	if var_2_0.isMax then
		self.m_Img_bar:setFillAmount(1)
	else
		self.m_Img_bar:setFillAmount(var_2_0.now / var_2_0.max)
	end

	if g.core.model.User.ancientsData:getSelfDiceNum() > 0 then
		if not self._boxEffect then
			self._boxEffect = self.m_boxEffect:addEffectSpine({
				anim = "play",
				name = "eff_ui_ancients_awardboxlight",
				isLoop = true
			})
		else
			self._boxEffect:setVisible(true)
		end
	elseif self._boxEffect then
		self._boxEffect:setVisible(false)
	end
end

function var_0_0._onClickBtnIcon(arg_3_0)
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_TEAM_SPOILS_POP)
end

return var_0_0

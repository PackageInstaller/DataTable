local AncientsTeamMenuComp = class("AncientsTeamMenuComp", require("app.fairyGUI.ancients.UI_AncientsTeamMenuComp"), function()
	return fgui.GComponent:create({
		resName = "AncientsTeamMenuComp",
		pkgPath = "ui/ancients/ancients",
		pkgName = "ancients"
	})
end)
local var_0_2 = g.core.const.ConstMgr.AncientsConst

function var_0_0:ctor(arg_2_1)
	self.m_Btn_view_info:addClickListener(handler(self, self._onClickBtnViewInfo))
	self.m_Btn_kick_out:addClickListener(handler(self, self._onClickBtnKickOut))
	self.m_Btn_quit:addClickListener(handler(self, self._onClickBtnQuit))
	self.m_Btn_ban_fight:addClickListener(handler(self, self._onClickBtnBanFight))

	self._teamUser = arg_2_1.teamUser

	self:_updateView()
end

function var_0_0:_updateView()
	local var_3_0 = g.core.model.User.ancientsData
	local var_3_1 = g.core.model.User:getId()

	if self._teamUser.user_id == var_3_1 then
		self.m_typeController:setSelectedIndex(0)
	else
		if var_3_0:isTeamUserLeader(var_3_1, var_0_2.GET_TEAM_TYPE.CURRENT_TEAM) then
			local var_3_2 = var_3_0:getAncientsState()

			if var_3_2 >= var_0_2.ANCIENT_STATUS.FINAL then
				self.m_typeController:setSelectedIndex(4)
			elseif var_3_2 == var_0_2.ANCIENT_STATUS.FINAL_COOP then
				self.m_typeController:setSelectedIndex(3)
			elseif var_3_2 <= var_0_2.ANCIENT_STATUS.FIGHT then
				self.m_typeController:setSelectedIndex(2)
			end
		else
			self.m_typeController:setSelectedIndex(1)
		end

		self.m_ban_fightController:setSelectedIndex(var_3_0:isUserBanFight(self._teamUser.user_id, var_0_2.GET_TEAM_TYPE.CURRENT_TEAM) and 1 or 0)
	end
end

function var_0_0:_onClickBtnViewInfo()
	g.core.sound.SoundManager:playSound("UI_Menu_Slide_01")
	g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
		uid = self._teamUser.user_id
	})
	self:removeSelf()
end

function var_0_0:_onClickBtnKickOut()
	local var_5_0 = self._teamUser.user_id

	if g.core.model.User.ancientsData:getAncientsState() < var_0_2.ANCIENT_STATUS.FINAL_COOP then
		g.core.module.ModuleManager:pushModule(g.view.entrance.CONFIRM_POP, {
			title = g.core.lang:get(1257),
			desc = g.core.lang:get(433402),
			onConfirm = function()
				g.core.network.GameNetProxy:send_C2S_Ancient_Kick({
					user_id = var_5_0
				})
			end
		})
	else
		g.core.network.GameNetProxy:send_C2S_Ancient_Kick({
			user_id = self._teamUser.user_id
		})
	end

	self:removeSelf()
end

function var_0_0:_onClickBtnQuit()
	if g.core.model.User.ancientsData:getAncientsState() < var_0_2.ANCIENT_STATUS.FINAL_COOP then
		g.core.module.ModuleManager:pushModule(g.view.entrance.CONFIRM_POP, {
			title = g.core.lang:get(1257),
			desc = g.core.lang:get(433401),
			onConfirm = function()
				g.core.network.GameNetProxy:send_C2S_Ancient_QuitTeam({})
			end
		})
	else
		g.core.network.GameNetProxy:send_C2S_Ancient_QuitTeam({})
	end

	self:removeSelf()
end

function var_0_0:_onClickBtnBanFight()
	g.core.network.GameNetProxy:send_C2S_Ancient_Setting({
		operate_type = 16,
		ban_fight_user = {
			{
				id = self._teamUser.user_id,
				status = not g.core.model.User.ancientsData:isUserBanFight(self._teamUser.user_id, var_0_2.GET_TEAM_TYPE.CURRENT_TEAM)
			}
		}
	})
	self:removeSelf()
end

return var_0_0

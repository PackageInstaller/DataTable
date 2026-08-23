local AncientsTeamScoreComp = class("AncientsTeamScoreComp", require("app.fairyGUI.ancients.UI_AncientsTeamScoreComp"))
local var_0_2 = g.core.const.ConstMgr.AncientsConst

function var_0_0:ctor()
	self._teamUserArray = nil

	self.m_Btn_setting:addClickListener(handler(self, self._onClickBtnSetting))
	self.m_Btn_showDetail:addClickListener(handler(self, self._onClickShowDetail))
	self.m_userScoreList:setIniter()
	self.m_userScoreList:setItemRenderer(handler(self, self._onUserScoreRender))
	self.m_isLeaderController:setSelectedIndex(g.core.model.User.ancientsData:isTeamUserLeader(g.core.model.User:getId(), var_0_2.GET_TEAM_TYPE.CURRENT_TEAM) and 1 or 0)
end

function var_0_0:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._getUserSnapShot), self)
end

function var_0_0:updateView()
	self.m_Txt_team_score:setText(g.core.model.User.ancientsData:getTeamScore(var_0_2.GET_TEAM_TYPE.CURRENT_TEAM))

	self._teamUserArray = g.core.model.User.ancientsData:getTeamUsers(var_0_2.GET_TEAM_TYPE.CURRENT_TEAM)

	table.sort(self._teamUserArray, function(arg_4_0, arg_4_1)
		return arg_4_0.pos < arg_4_1.pos
	end)
	self.m_userScoreList:setNumItems(#self._teamUserArray)
	self.m_userScoreList:resizeToFit(#self._teamUserArray)
end

function var_0_0:_getUserSnapShot()
	self.m_userScoreList:setNumItems(#self._teamUserArray)
end

function var_0_0._onClickBtnSetting(arg_6_0)
	if g.core.model.User.ancientsData:isTeamUserLeader(g.core.model.User:getId(), var_0_2.GET_TEAM_TYPE.CURRENT_TEAM) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_COOP_CREATE_TEAM_POP, {
			isSetting = true
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(427009))
	end
end

function var_0_0:_onClickShowDetail()
	self.m_showDetailController:setSelectedIndex((self.m_showDetailController:getSelectedIndex() + 1) % 2)
end

function var_0_0:_onUserScoreRender(arg_8_1, arg_8_2)
	arg_8_2:updateCell(self._teamUserArray[arg_8_1 + 1])
end

return var_0_0

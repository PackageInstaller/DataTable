local AncientsCoopMainLayer = class("AncientsCoopMainLayer", require("app.fairyGUI.ancients.UI_AncientsCoopMainLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/ancients/ancients",
		resName = "AncientsCoopMainLayer",
		pkgName = "ancients"
	}, ...)
end)

function var_0_0:ctor()
	self.m_bgEffect:addEffectSpine({
		anim = "play",
		name = "eff_ui_ancients_teambglight",
		isLoop = true
	})
	self.m_Btn_check:addClickListener(handler(self, self._onClickBtnCheck))
	self.m_Btn_left:addClickListener(handler(self, self._onClickBtnLeft))
	self.m_Btn_right:addClickListener(handler(self, self._onClickBtnRight))
	self.m_Btn_invite:addClickListener(handler(self, self._onClickBtnInvite))
	self.m_Btn_rank:addClickListener(handler(self, self._onClickBtnRank))
	self.m_Btn_quickIn:addClickListener(handler(self, self._onClickBtnQuickIn))
	self.m_Btn_create:addClickListener(handler(self, self._onClickBtnCreate))
	self.m_List_team:setIniter()
	self.m_List_team:setItemRenderer(handler(self, self._onRenderListTeamCell))
	self.m_is_finalController:setSelectedIndex(g.core.model.User.ancientsData:isFinalState() and 1 or 0)
	self:addBg("bg/ancients/bg_jxmy_zd_zddtbg.jpg")
	self.m_topBarComp:updateTopRes({
		{
			type = g.core.common.Goods.TYPE_ITEM,
			value = g.core.common.Goods.ITEM.TYPE_ANCIENTS_SHOP_COIN
		},
		{
			type = g.core.common.Goods.TYPE_ITEM,
			value = g.core.common.Goods.ITEM.TYPE_ANCIENTS_SOUL_COIN
		},
		{
			type = g.core.common.Goods.TYPE_ITEM,
			value = g.core.common.Goods.ITEM.TYPE_ANCIENTS_DICE
		}
	})
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.AncientsConst.TopBarId)

	self._page = 0
	self._filterType = 1
	self._teamArr = {}
	self._totalTeamNum = 0
	self._maxPage = 0
	self._inWaitState = true
end

function var_0_0:onLoad()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.ANCIENTS)
	g.core.network.GameNetProxy:send_C2S_Ancient_Enter({})
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_RECOMMENDTEAM, handler(self, self._onRevRecommendTeam), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETFINALTEAMLIST, handler(self, self._onRevGetFinalTeamList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_QUICKJOIN, handler(self, self._onRevQuickJoin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_NOTIFYTEAMCHANGE, handler(self, self._onRcvNotifyTeamChange), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_CREATETEAM, handler(self, self._onRcvNotifyTeamChange), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayEvent), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._updateTeamInfo), self)
	g.core.network.GameNetProxy:send_C2S_Ancient_GetInvitationList({})
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_TeamPVP)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	self.m_enterTransition:play(handler(self, self._onEnterAnimEnd))

	self._listTransition = false

	self:_updatePage()
end

function var_0_0:_onEnterAnimEnd()
	if self._inWaitState then
		self._inWaitState = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end
end

function var_0_0:_onRevRecommendTeam(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self._totalTeamNum = arg_5_4.total
	self._maxPage = math.ceil(arg_5_4.total / 8) - 1
	self._teamArr = arg_5_4.teams or {}

	self:_updateView()
end

function var_0_0:_onRevGetFinalTeamList(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self._teamArr = arg_6_4.teams or {}

	table.sort(self._teamArr, function(arg_7_0, arg_7_1)
		return arg_7_0.promote_rank < arg_7_1.promote_rank
	end)

	self._totalTeamNum = #self._teamArr
	self._maxPage = math.ceil(self._totalTeamNum / 8) - 1

	self:_updateView()
end

function var_0_0._onRevQuickJoin(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	g.core.network.GameNetProxy:send_C2S_Ancient_QuickJoin({})
end

function var_0_0._onRcvNotifyTeamChange(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if g.core.model.User.ancientsData:getAncientsState() == g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL_COOP then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
		g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_AGAINST_LAYER, {
			autoInTeam = true
		})
	else
		g.core.utils.Tools.ancientsFunc.openAncientsMainLayer(true)
	end
end

function var_0_0:_updatePage(arg_10_1)
	arg_10_1 = arg_10_1 or self._page

	if g.core.model.User.ancientsData:isFinalState() then
		if #self._teamArr <= 0 then
			g.core.network.GameNetProxy:send_C2S_Ancient_GetFinalTeamList({})
		else
			self:_updateView()
			self.m_List_team:scrollToView(arg_10_1 == 0 and 0 or #self._teamArr - 1)
		end
	else
		g.core.network.GameNetProxy:send_C2S_Ancient_RecommendTeam({
			page = arg_10_1,
			tp = self._filterType
		})
	end
end

function var_0_0:_updateView()
	if g.core.model.User.ancientsData:isFinalState() and self._timeSchedule == nil then
		self:_updateFinalTime()

		self._timeSchedule = self:newSchedule(handler(self, self._updateFinalTime), 1)
	end

	self:_updateArrowBtn()
	self:_updateTeamInfo()
	self.m_Comp_stage:updateView()
end

function var_0_0:_updateFinalTime()
	self.m_Txt_finalTeamCd:setText(g.core.lang:get(433377, {
		time = g.core.common.ServerTime:getAwardLeftTime(24, 0, 0)
	}))
end

function var_0_0:_updateTeamInfo()
	self.m_is_emptyController:setSelectedIndex(self._totalTeamNum == 0 and 1 or 0)
	self.m_List_team:setNumItems(#self._teamArr)
end

function var_0_0:_updateArrowBtn()
	if self._page == 0 then
		self.m_Btn_left:setVisible(false)
	else
		self.m_Btn_left:setVisible(true)
	end

	if self._page == self._maxPage then
		self.m_Btn_right:setVisible(false)
	else
		self.m_Btn_right:setVisible(true)
	end
end

function var_0_0:_onClickBtnCheck()
	self._filterType = 3 - self._filterType
	self._page = 0

	self:_updatePage(self._page)
end

function var_0_0:_onClickBtnLeft()
	self._page = self._page - 1
	self._page = math.max(0, self._page)

	self:_updatePage(self._page)
end

function var_0_0:_onClickBtnRight()
	self._page = self._page + 1
	self._page = math.min(self._maxPage, self._page)

	self:_updatePage(self._page)
end

function var_0_0._onClickBtnInvite(arg_18_0)
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_COOP_TEAM_INVITE_POP)
end

function var_0_0._onClickBtnRank(arg_19_0)
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_COOP_TEAM_RANK_POP)
end

function var_0_0:_onClickBtnQuickIn()
	if self._totalTeamNum < 1 then
		self:_updatePage()
		g.core.module.ModuleManager:tip(g.core.lang:get(433366))

		return
	end

	if g.core.model.User.ancientsData:isForbiddenJoinTeam() then
		g.core.module.ModuleManager:tip(g.core.lang:get(433355, {
			time = g.core.model.User.ancientsData:getForbiddenJoinTeamCDStr()
		}))

		return
	end

	g.core.network.GameNetProxy:send_C2S_Ancient_QuickJoin({})
end

function var_0_0._onClickBtnCreate(arg_21_0)
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_COOP_CREATE_TEAM_POP)
end

function var_0_0:_onRenderListTeamCell(arg_22_1, arg_22_2)
	arg_22_2:updateTeamCellInfo(self._teamArr[arg_22_1 + 1], arg_22_1)
end

function var_0_0._onCrossDayEvent(arg_23_0)
	if g.core.utils.Tools.ancientsFunc.getNeedOpenModule() ~= g.view.entrance.ANCIENTS_COOP_MAIN_LAYER then
		g.core.utils.Tools.ancientsFunc.openAncientsMainLayer(true)
	end
end

return var_0_0

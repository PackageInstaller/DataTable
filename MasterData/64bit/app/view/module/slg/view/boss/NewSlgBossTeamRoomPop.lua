local var_0_0 = g.core.model.User.newSlgData
local NewSlgBossTeamRoomPop = class("NewSlgBossTeamRoomPop", require("app.fairyGUI.newSlg.UI_NewSlgBossTeamRoomPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/newSlg/newSlg",
		resName = "NewSlgBossTeamRoomPop",
		pkgName = "newSlg"
	}, ...)
end)
local var_0_2 = g.core.utils.Tools.newSlgFunc

function NewSlgBossTeamRoomPop:ctor(arg_2_1)
	self:showAtCenter()

	self._bossId = arg_2_1.bossId
	self._teamId = arg_2_1.teamId or 0
	self._path = arg_2_1.path
	self._dur = arg_2_1.duration
	self._compBossView = self:getChild("Comp_bossView")

	self._compBossView:updateView(self._bossId)

	self._compDefence = self:getChild("Comp_defence")
	self._btnJoin = self:getChild("Btn_join")

	self._btnJoin:addClickListener(handler(self, self._onClickBtnJoin))

	self._btnGo = self:getChild("Btn_go")

	self._btnGo:addClickListener(handler(self, self._onClickBtnGo))

	self._btnRefresh = self:getChild("Btn_refresh")

	self._btnRefresh:addClickListener(handler(self, self._onClickBtnRefresh))

	self._listTeam = self:getChild("List_team")

	self._listTeam:setVirtual(self)
	self._listTeam:doFairyBatching(false)
	self._listTeam:setItemRenderer(handler(self, self._onRenderListTeamCell))

	self._txtTime = self:getChild("Txt_time")

	self._txtTime:setVisible(false)

	self._isEmptyCtrl = self:getController("is_empty")
	self._bossTeamArr = {}
	self._isFirst = true
	self._refreshTime = 0
	self._refreshCD = g.core.model.User.newSlgData:getNewSlgParamsValueById(88)

	self.m_closeBtn:setClickCallBack(handler(self, self.onClose))
	self.m_closeGraph:addClickListener(handler(self, self.onClose))
end

function NewSlgBossTeamRoomPop:onLoad()
	self.m_enterTransition:play()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSTEAMLIST, handler(self, self._onRcvNewSlgBossTeamList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSUSERSTATENOTIFY, handler(self, self._onRcvNewSlgBossUserStateNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSTEAMJOINNOTIFY, handler(self, self._onRcvNewSlgBossTeamJoinNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SCHEDULE_NOTIFY_NEW, handler(self, self._onSchedule), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSBATTLESTARTNOTIFY, handler(self, self._onRcvNewSlgBossBattleStartNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.APP_ENTER_FOREGROUND_EVENT, handler(self, self.onRequestNewInfo), self)

	if self:_judgeLegal() then
		self:_sendBossTeamList()
	end

	self:_updateChallengeTime()
	self.m_canGatherController:setSelectedIndex(var_0_0:getBossChallengedLevel() < var_0_0:getBossInfoById(self._bossId).level - 1 and 1 or 0)
end

function NewSlgBossTeamRoomPop:onClose()
	if self._isClose then
		return
	end

	self._isClose = true

	self.m_backTransition:play(handler(self, self.onCloseFinish))
end

function NewSlgBossTeamRoomPop:onCloseFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgBossTeamRoomPop:_onSchedule(arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3.key == "NewSlgBossTeamRoomPop_refreshCountDown" then
		self._txtTime:setText((g.core.common.ServerTime:secondToHMSString(arg_6_3.endTime - g.core.common.ServerTime:getTime())))
	elseif arg_6_3.key == "NewSlgBossTeamRoomPop_setRefreshBtnTouchable" then
		self:_setRefreshBtn(true)
	end
end

function NewSlgBossTeamRoomPop:_updateChallengeTime()
	local var_7_0, var_7_1 = g.core.model.User.newSlgData:getBossChallengeTime()

	self._compDefence:updateView({
		num = g.core.lang:get(428977, {
			num1 = var_7_0,
			num2 = var_7_1
		})
	})
end

function NewSlgBossTeamRoomPop:_judgeLegal()
	if self._dur and self._dur > 0 then
		return true
	end

	self._path = self._path or g.core.model.User.newSlgData:getPathByTmpl((g.core.model.User.newSlgData:getBossComponentById(self._bossId)))

	if not self._path then
		g.core.module.ModuleManager:tip(g.core.lang:get(428906))
		g.core.module.ModuleManager:popComponent()

		return false
	end

	self._dur = var_0_2.getMarchDurationByPath(self._path, 0, g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.BOSS)

	return true
end

function NewSlgBossTeamRoomPop:_sendBossTeamList()
	g.core.network.GameNetProxy:send_C2S_NewSlg_BossTeamList({
		boss_ids = {
			{
				key = self._bossId,
				value = self._dur
			}
		},
		team_id = self._teamId
	})
end

function NewSlgBossTeamRoomPop:onRequestNewInfo()
	self:_sendBossTeamList()
end

function NewSlgBossTeamRoomPop:_onRcvNewSlgBossTeamList(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	self._bossTeamArr = arg_11_4.teams or {}

	g.core.model.User.newSlgData:dealBossTeamUserSort(self._bossTeamArr)

	if self._isFirst and self._teamId > 0 then
		local var_11_0 = false

		for iter_11_0, iter_11_1 in ipairs(self._bossTeamArr) do
			if iter_11_1.team_id == self._teamId then
				var_11_0 = true

				break
			end
		end

		if not var_11_0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(428930))
		end
	end

	self:_initRefreshBtnCD()
	self:_updateList()
end

function NewSlgBossTeamRoomPop:_initRefreshBtnCD()
	self._refreshTime = g.core.common.ServerTime:getTime()

	self:_setRefreshBtn(false)
	var_0_2.addSchedule({
		key = "NewSlgBossTeamRoomPop_refreshCountDown",
		startTime = self._refreshTime,
		endTime = self._refreshTime + self._refreshCD
	})
	self._txtTime:setText((g.core.common.ServerTime:secondToHMSString(self._refreshTime + self._refreshCD - g.core.common.ServerTime:getTime())))
	var_0_2.addSchedule({
		isOnce = true,
		key = "NewSlgBossTeamRoomPop_setRefreshBtnTouchable",
		startTime = self._refreshTime + self._refreshCD
	})
end

function NewSlgBossTeamRoomPop:_setRefreshBtn(arg_13_1)
	self._btnRefresh:setGrayed(not arg_13_1)
	self._btnRefresh:setTouchable(arg_13_1)
	self._txtTime:setVisible(not arg_13_1)
end

function NewSlgBossTeamRoomPop:_updateList()
	if #self._bossTeamArr == 0 then
		self._isEmptyCtrl:setSelectedIndex(1)

		self._isFirst = false
	else
		self._isEmptyCtrl:setSelectedIndex(0)
		self._listTeam:setNumItems(#self._bossTeamArr)

		if self._isFirst then
			self._isFirst = false

			if self._teamId > 0 then
				for iter_14_0, iter_14_1 in ipairs(self._bossTeamArr) do
					if iter_14_1.team_id == self._teamId then
						self._listTeam:scrollToView(iter_14_0 - 1)

						break
					end
				end
			end
		end
	end
end

function NewSlgBossTeamRoomPop:_onRcvNewSlgBossUserStateNotify(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = g.core.model.User.newSlgData:getBossTeamInfo(arg_15_4.team_id)

	if not var_15_0 then
		self:_removeTeam(arg_15_4.team_id)

		return
	end

	for iter_15_0, iter_15_1 in ipairs(self._bossTeamArr) do
		if iter_15_1.team_id == arg_15_4.team_id then
			iter_15_1 = var_15_0
		end
	end

	g.core.model.User.newSlgData:dealBossTeamUserSort(self._bossTeamArr)
	self:_updateList()
end

function NewSlgBossTeamRoomPop:_onRcvNewSlgBossTeamJoinNotify(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = g.core.model.User.newSlgData:getBossTeamInfo(arg_16_4.team_id)

	if not var_16_0 then
		self:_removeTeam(arg_16_4.team_id)

		return
	end

	for iter_16_0, iter_16_1 in ipairs(self._bossTeamArr) do
		if iter_16_1.team_id == arg_16_4.team_id then
			iter_16_1 = var_16_0
		end
	end

	g.core.model.User.newSlgData:dealBossTeamUserSort(self._bossTeamArr)
	self:_updateList()
end

function NewSlgBossTeamRoomPop:_onRcvNewSlgBossBattleStartNotify(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	if arg_17_4.boss_id == self._bossId then
		self:_removeTeam(arg_17_4.team_id)
	end

	g.core.model.User.newSlgData:dealBossTeamUserSort(self._bossTeamArr)
	self:_updateList()
end

function NewSlgBossTeamRoomPop:_removeTeam(arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(self._bossTeamArr) do
		if iter_18_1.team_id == arg_18_1 then
			table.remove(self._bossTeamArr, iter_18_0)

			return
		end
	end
end

function NewSlgBossTeamRoomPop:onUnload()
	var_0_2.removeSchedule("NewSlgBossTeamRoomCell_updateSch")
end

function NewSlgBossTeamRoomPop:_onClickBtnJoin()
	if self:_judgeCanQuickJoin() then
		local var_20_0 = g.core.model.User.newSlgData:getBossComponentById(self._bossId)

		self:dispatchCompEvent("NewSlg_Boss_Gather", {
			buildType = g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.BOSS,
			info = g.core.model.User.newSlgData:getBossInfoById(self._bossId),
			x = var_20_0.anchor_x,
			y = var_20_0.anchor_y,
			bossJoinType = g.core.const.ConstMgr.NewSlgConst.SLGBossJoinType.QUICK_JOIN
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(428912))
	end
end

function NewSlgBossTeamRoomPop:_judgeCanQuickJoin()
	local var_21_0 = g.core.model.User.newSlgData
	local var_21_1 = g.core.common.ServerTime:getTime()

	for iter_21_0, iter_21_1 in ipairs(self._bossTeamArr) do
		local var_21_2 = var_21_0:getBossTeamInfo(iter_21_1.team_id)

		if var_21_2 then
			if var_21_2.state == g.core.const.ConstMgr.NewSlgConst.SLGBossTeamState.STATE_1 and var_21_2.create_time + var_21_0:getBossTeamGatherTotalTime() > var_21_1 + g.core.utils.Tools.newSlgFunc.getMarchDurationByPath(var_21_0:getPathByTmpl((var_21_0:getBossComponentById(var_21_2.boss_id))), 0, g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.BOSS) and not var_21_0:isSelfInBossTeam(var_21_2) then
				return true
			end
		end
	end

	return false
end

function NewSlgBossTeamRoomPop:_onClickBtnGo()
	local var_22_0 = g.core.model.User.newSlgData:getBossChallengeTime()
	local var_22_1 = g.core.model.User.newSlgData:getBossComponentById(self._bossId)

	self:dispatchCompEvent("NewSlg_Boss_Gather", {
		buildType = g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.BOSS,
		info = g.core.model.User.newSlgData:getBossInfoById(self._bossId),
		x = var_22_1.anchor_x,
		y = var_22_1.anchor_y,
		bossJoinType = g.core.const.ConstMgr.NewSlgConst.SLGBossJoinType.CREATE
	})
end

function NewSlgBossTeamRoomPop:_onClickBtnRefresh()
	if g.core.common.ServerTime:getTime() <= self._refreshTime + self._refreshCD then
		return
	end

	self:_sendBossTeamList()
end

function NewSlgBossTeamRoomPop:_onRenderListTeamCell(arg_24_1, arg_24_2)
	arg_24_2:updateCell(self._bossTeamArr[arg_24_1 + 1])
end

return NewSlgBossTeamRoomPop

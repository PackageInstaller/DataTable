local var_0_0 = g.core.model.User.newSlgData
local NewSlgBossTotalTeamPop = class("NewSlgBossTotalTeamPop", require("app.fairyGUI.newSlg.UI_NewSlgBossTotalTeamPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgBossTotalTeamPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)
local var_0_2 = require("app.core.tilemap.TileMapFunc").p2s

function NewSlgBossTotalTeamPop:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	self:getView():center(true)

	self._canChallengeBossIds, self._bossMap = var_0_0:getCanChallengeBossIdsByLevel(true, true)

	local var_2_0 = arg_2_1.bossId or 0
	local var_2_1 = 0
	local var_2_2 = 0

	if var_2_0 > 0 then
		local var_2_3 = var_0_0:getBossInfoById(var_2_0)

		var_2_1 = var_2_3.level
		var_2_2 = var_2_3.boss_army_type
	end

	local var_2_4 = self._bossMap[var_0_2(var_2_1, var_2_2)]

	if var_2_4 and #var_2_4 > 0 then
		for iter_2_0, iter_2_1 in ipairs(var_2_4) do
			local var_2_5 = table.indexof(self._canChallengeBossIds, iter_2_1)

			if var_2_5 then
				self._bossIndex = var_2_5
			end
		end
	end

	self._bossIndex = not self._bossIndex and 0 or self._bossIndex - 1
	self._compDropDown = self:getChild("Comp_dropDown")
	self._searchBtn = self:getChild("searchBtn")

	self._searchBtn:addClickListener(handler(self, self._onSearchClick))
	self._compDropDown:initDrop(self._canChallengeBossIds, self._bossIndex)

	self._listTeam = self:getChild("List_team")

	self._listTeam:doFairyBatching(false)
	self._listTeam:setVirtual(self)
	self._listTeam:setItemRenderer(handler(self, self._onRenderListTeamCell))

	self._tabCtrl = self:getController("tab")

	self._tabCtrl:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCtrlTabChange))

	self._tabIndex = 0
	self._isEmptyCtrl = self:getController("is_empty")
	self._bossTeamArr = {}
	self._cacheBossList = {}

	self.m_closeBtn:setClickCallBack(handler(self, self.onClose))
	self.m_closeGraph:addClickListener(handler(self, self.onClose))
end

function NewSlgBossTotalTeamPop:onLoad()
	self.m_enterTransition:play()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSTEAMLIST, handler(self, self._onRcvNewSlgBossTeamList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSTEAMINFO, handler(self, self._onRcvNewSlgBossTeamInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSUSERSTATENOTIFY, handler(self, self._onRcvNewSlgBossUserStateNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSTEAMJOINNOTIFY, handler(self, self._onRcvNewSlgBossTeamJoinNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSBATTLESTARTNOTIFY, handler(self, self._onRcvNewSlgBossBattleStartNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateList, self)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_teamBtn
	})
	self:_sendMsg()
end

function NewSlgBossTotalTeamPop:onClose()
	if self._isClose then
		return
	end

	self._isClose = true

	self.m_backTransition:play(handler(self, self.onCloseFinish))
end

function NewSlgBossTotalTeamPop:onCloseFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgBossTotalTeamPop:_sendMsg(arg_6_1)
	if self._tabIndex == 0 then
		if not arg_6_1 and #self._cacheBossList > 0 then
			self._bossTeamArr = self._cacheBossList

			self:_updateList()

			return
		end

		local var_6_0 = self._canChallengeBossIds[self._bossIndex + 1]
		local var_6_1 = {}

		if self._canChallengeBossIds[self._bossIndex + 1] == 0 then
			for iter_6_0 = 2, #self._canChallengeBossIds do
				local var_6_2 = var_0_0:getBossInfoById(self._canChallengeBossIds[iter_6_0])

				for iter_6_1, iter_6_2 in ipairs(self._bossMap[var_0_2(var_6_2.level, var_6_2.boss_army_type)] or {}) do
					table.insert(var_6_1, {
						value = 0,
						key = iter_6_2
					})
				end
			end
		else
			local var_6_3 = var_0_0:getBossInfoById(var_6_0)

			for iter_6_3, iter_6_4 in ipairs(self._bossMap[var_0_2(var_6_3.level, var_6_3.boss_army_type)] or {}) do
				table.insert(var_6_1, {
					value = 0,
					key = iter_6_4
				})
			end
		end

		g.core.network.GameNetProxy:send_C2S_NewSlg_BossTeamList({
			team_id = 0,
			boss_ids = var_6_1
		})
	else
		local var_6_5 = {}

		for iter_6_5, iter_6_6 in ipairs((g.core.model.User.homeInfoRemindData:getTipDataList(g.core.const.ConstMgr.FUNCTION_TYPE.NEW_SLG, 2))) do
			local var_6_6 = string.split(iter_6_6._params, ":")

			if self._canChallengeBossIds[self._bossIndex + 1] == 0 then
				table.insert(var_6_5, tonumber(var_6_6[2]))
			elseif self._canChallengeBossIds[self._bossIndex + 1] == tonumber(var_6_6[1]) then
				table.insert(var_6_5, var_6_6[2])
			end
		end

		g.core.network.GameNetProxy:send_C2S_NewSlg_BossTeamInfo({
			team_ids = var_6_5
		})
	end
end

function NewSlgBossTotalTeamPop:onUnload()
	self._cacheBossList = {}
	self._bossTeamArr = {}

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NEW_SLG_BOSS_INVITE_RED_POINT)
	g.core.utils.Tools.newSlgFunc.removeSchedule("NewSlgBossTotalTeamCell_updateSch")
end

function NewSlgBossTotalTeamPop:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "NewSlgBossDropDownListComp_onItemClickDrop" then
		if self._bossIndex == arg_8_2.index then
			return
		end

		self._bossIndex = arg_8_2.index

		self:_sendMsg(true)
	else
		self:dispatchCompEvent(arg_8_1, arg_8_2)
	end
end

function NewSlgBossTotalTeamPop:_onCtrlTabChange()
	local var_9_0 = self._tabCtrl:getSelectedIndex()

	if var_9_0 == self._tabIndex then
		return
	end

	self._tabIndex = var_9_0

	self:_sendMsg()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallClick)

	if var_9_0 == 1 then
		local var_9_1 = {}

		for iter_9_0, iter_9_1 in ipairs((g.core.model.User.homeInfoRemindData:getTipDataList(g.core.const.ConstMgr.FUNCTION_TYPE.NEW_SLG, g.core.const.ConstMgr.NewSlgConst.BOSS_INVITE_TIP_ID))) do
			var_9_1[tostring(iter_9_1.uid)] = true
		end

		var_9_1.check_time = g.core.common.ServerTime:getTime()

		g.core.common.Storage:save("new_slg_team_invite.json", var_9_1, true)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_teamBtn
	})
end

function NewSlgBossTotalTeamPop:_onRenderListTeamCell(arg_10_1, arg_10_2)
	arg_10_2:updateCell(self._bossTeamArr[arg_10_1 + 1], self._tabIndex)
end

function NewSlgBossTotalTeamPop:_onRcvNewSlgBossTeamList(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	self._bossTeamArr = {}

	local var_11_0 = arg_11_4.teams or {}

	var_0_0:dealBossTeamUserSort(var_11_0)

	for iter_11_0 = 1, var_0_0:getNewSlgParamsValueById(161) or 10 do
		if iter_11_0 <= #var_11_0 then
			for iter_11_1, iter_11_2 in ipairs(var_11_0[iter_11_0].users) do
				-- block empty
			end

			table.insert(self._bossTeamArr, var_11_0[iter_11_0])
		end
	end

	self._cacheBossList = {}
	self._cacheBossList = clone(self._bossTeamArr)

	self:_updateList()
end

function NewSlgBossTotalTeamPop:_onRcvNewSlgBossTeamInfo(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	self._bossTeamArr = arg_12_4.teams or {}

	var_0_0:dealBossTeamUserSort(self._bossTeamArr)
	self:_updateList()
end

function NewSlgBossTotalTeamPop:_onSearchClick()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	g.core.event.EventManager:dispatchEvent(g.core.const.ConstMgr.NewSlgConst.OPEN_SEARCH)
end

function NewSlgBossTotalTeamPop:_updateList()
	if #self._bossTeamArr == 0 then
		self._isEmptyCtrl:setSelectedIndex(1)
	else
		self._isEmptyCtrl:setSelectedIndex(0)
		self._listTeam:setNumItems(#self._bossTeamArr)
	end
end

function NewSlgBossTotalTeamPop:_onRcvNewSlgBossUserStateNotify(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = var_0_0:getBossTeamInfo(arg_15_4.team_id)

	if not var_15_0 then
		self:_removeTeam(arg_15_4.team_id)

		return
	end

	for iter_15_0, iter_15_1 in ipairs(self._bossTeamArr) do
		if iter_15_1.team_id == arg_15_4.team_id then
			iter_15_1 = var_15_0
		end
	end

	var_0_0:dealBossTeamUserSort(self._bossTeamArr)
	self:_updateList()
end

function NewSlgBossTotalTeamPop:_onRcvNewSlgBossTeamJoinNotify(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = var_0_0:getBossTeamInfo(arg_16_4.team_id)

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

function NewSlgBossTotalTeamPop:_onRcvNewSlgBossBattleStartNotify(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	if self._canChallengeBossIds[self._bossIndex + 1] == 0 or arg_17_4.boss_id == self._canChallengeBossIds[self._bossIndex + 1] then
		self:_removeTeam(arg_17_4.team_id)
	end

	var_0_0:dealBossTeamUserSort(self._bossTeamArr)
	self:_updateList()
end

function NewSlgBossTotalTeamPop:_removeTeam(arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(self._bossTeamArr) do
		if iter_18_1.team_id == arg_18_1 then
			table.remove(self._bossTeamArr, iter_18_0)

			return
		end
	end
end

return NewSlgBossTotalTeamPop

local var_0_0 = g.core.const.ConstMgr.NewSlgConst
local NewSlgTeamInfoComp = class("NewSlgTeamInfoComp", require("app.fairyGUI.newSlg.UI_NewSlgTeamInfoComp"))

function NewSlgTeamInfoComp:ctor()
	self._compInfo = self:getChild("Comp_info")
	self._posCtrl = self:getController("pos")
	self._selCtrl = self:getController("selIndex")
	self._myTeamMap = nil

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:_initList()
end

function NewSlgTeamInfoComp:_initList()
	self.m_teamList:setVirtual(self)
	self.m_teamList:setItemRenderer(handler(self, self._onRenderTeamItem))
	self.m_teamList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._clickTeamIcon))
end

function NewSlgTeamInfoComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_MOVETARGETRIGHTNOW, handler(self, self.onUpdateAction), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ENTER, handler(self, self._onRcvTeamRefresh), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_COMMON_PASSCARD_GETINFO, handler(self, self._onRcvTeamRefresh), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SYNCUSERTEAM, handler(self, self._onRcvTeamRefresh), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYNTF, handler(self, self._onRcvTeamRefresh), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_MOVETARGETRIGHTNOW, handler(self, self._onRcvTeamRefresh), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NEW_SLG_PATH_FINISH, handler(self, self._updateView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CLICK_START, self.onClickHideAction, self)
	self:_updateView()
end

function NewSlgTeamInfoComp:updateView()
	self:_updateView()
end

function NewSlgTeamInfoComp:_updateView()
	self._teamDataList = {}

	for iter_5_0 = 1, g.core.model.User.newSlgData:getCurTeamCnt() do
		local var_5_0
		local var_5_1 = g.core.const.ConstMgr.NewSlgConst.ARMY_TYPE.QI
		local var_5_2 = 0
		local var_5_3 = 0
		local var_5_4 = false
		local var_5_5 = var_0_0.TEAM_CLIENT_STATUS_TYPE.UNKNOWN
		local var_5_6 = {
			idx = iter_5_0
		}

		if g.core.model.User.newSlgData:getTeamUnlockLevelByIndex(iter_5_0) then
			local var_5_7 = g.core.model.User.newSlgData:getMyTeamByIndex(iter_5_0)

			if var_5_7 and not g.core.model.User.newSlgData:isTeamIdle(var_5_7) then
				local var_5_8 = var_5_7.characters or {}

				if var_5_8 and #var_5_8 > 0 then
					var_5_0 = var_5_8[1]

					table.insert(self._teamDataList, var_5_6)
				end

				if var_5_7.troop_type then
					var_5_1 = var_5_7.troop_type
				end

				local var_5_9 = g.core.model.User.newSlgData:getTeamStateByTeam(var_5_7)

				var_5_5 = var_5_9.state

				if var_5_9 then
					var_5_2 = var_5_9.startTime + var_5_9.totalTime
					var_5_3 = var_5_9.farmTime

					local var_5_10 = var_5_9.state1

					if var_5_9.state1 then
						if var_5_10 == g.core.const.ConstMgr.NewSlgConst.TEAM_CLIENT_STATUS1_TYPE.FARM_WAIT or var_5_10 == g.core.const.ConstMgr.NewSlgConst.TEAM_CLIENT_STATUS1_TYPE.FARM_DEF then
							var_5_2 = 0
						end

						var_5_4 = var_5_10 == g.core.const.ConstMgr.NewSlgConst.TEAM_CLIENT_STATUS1_TYPE.CITY_ASSEMBLE or var_5_10 == g.core.const.ConstMgr.NewSlgConst.TEAM_CLIENT_STATUS1_TYPE.BOSS_ASSEMBLE
					end
				end
			end
		end

		var_5_6.character = var_5_0
		var_5_6.troopType = var_5_1
		var_5_6.endTime = var_5_2
		var_5_6.farmTime = var_5_3
		var_5_6.isAssemble = var_5_4
		var_5_6.teamStatueFlag = var_5_5
	end

	self.m_teamList:setNumItems(#self._teamDataList)
end

function NewSlgTeamInfoComp:_onRenderTeamItem(arg_6_1, arg_6_2)
	arg_6_2:updateView(self._teamDataList[arg_6_1 + 1])
end

function NewSlgTeamInfoComp:_showInfoTip(arg_7_1)
	local var_7_0 = g.core.model.User.newSlgData:getMyTeamByIndex(self._teamDataList[arg_7_1].idx)

	if var_7_0 then
		self._posCtrl:setSelectedIndex(1)
		self.m_enterTransition:play()

		self._showIndex = arg_7_1

		self._compInfo:updateView({
			team = var_7_0
		})
		self:_changeInfoCompToItemIndex(arg_7_1)
	end
end

function NewSlgTeamInfoComp:_changeInfoCompToItemIndex(arg_8_1)
	local var_8_0 = self.m_teamList:getChildAt((self.m_teamList:itemIndexToChildIndex(arg_8_1 - 1)))

	if not var_8_0 then
		return
	end

	self._compInfo:setY(self._compInfo:getParent():globalToLocal(var_8_0:localToGlobal(cc.p(0, 0))).y)
end

function NewSlgTeamInfoComp:onClickHideAction()
	self:closeShow()
end

function NewSlgTeamInfoComp:_clickTeamIcon(arg_10_1)
	self:_showInfoTip(arg_10_1:getDataValue() + 1)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_RankingSwitchPage)
end

function NewSlgTeamInfoComp:_onTouchBegin()
	self._clickSelf = true
end

function NewSlgTeamInfoComp:closeShow()
	if self._clickSelf then
		self._clickSelf = false

		return
	end

	self.m_backTransition:play(handler(self, self.onCloseFinish))
end

function NewSlgTeamInfoComp:onUpdateAction()
	self:onCloseFinish()
end

function NewSlgTeamInfoComp:onCloseFinish()
	self._posCtrl:setSelectedIndex(0)
	self._selCtrl:setSelectedIndex(0)
end

function NewSlgTeamInfoComp:_onRcvTeamRefresh(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	self:_updateView()

	if self._posCtrl:getSelectedIndex() == 1 and self._showIndex then
		if g.core.model.User.newSlgData:isTeamIdle((g.core.model.User.newSlgData:getMyTeamByIndex(self._showIndex))) then
			self._posCtrl:setSelectedIndex(0)
		else
			self:_changeInfoCompToItemIndex(self._showIndex)
		end
	end
end

return NewSlgTeamInfoComp

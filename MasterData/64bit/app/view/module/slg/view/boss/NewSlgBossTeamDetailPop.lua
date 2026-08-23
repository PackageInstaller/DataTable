local NewSlgBossTeamDetailPop = class("NewSlgBossTeamDetailPop", require("app.fairyGUI.newSlg.UI_NewSlgBossTeamDetailPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgBossTeamDetailPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)
local var_0_1 = 4

function NewSlgBossTeamDetailPop:ctor(arg_2_1)
	self:showAtCenter()

	self._teamId = arg_2_1.teamId
	self._compBossView = self:getChild("Comp_bossView")
	self._compPlayerTeamInfo = self:getChild("Comp_playerTeamInfo")

	self._compPlayerTeamInfo:setVisible(false)

	self._txtCountDown = self:getChild("Txt_countDown")
	self._txtNum = self:getChild("Txt_num")
	self._listPlayer = self:getChild("List_player")

	self._listPlayer:setVirtual(self)
	self._listPlayer:setItemRenderer(handler(self, self._onRenderListPlayerCell))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_closeBtn:setClickCallBack(handler(self, self.onClose))
	self.m_closeGraph:addClickListener(handler(self, self.onClose))
end

function NewSlgBossTeamDetailPop:onLoad()
	self.m_enterTransition:play()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSUSERSTATENOTIFY, handler(self, self._onRcvUserStateNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSTEAMJOINNOTIFY, handler(self, self._onRcvNewSlgTeamChange), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SCHEDULE_NOTIFY_NEW, handler(self, self._onSchedule), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSBATTLESTARTNOTIFY, handler(self, self._onRcvNewSlgTeamChange), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSBATTLEFINISHNOTIFY, handler(self, self._onRcvNewSlgTeamChange), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateList, self)

	if self:_judgeLegal() then
		self:_updateView()
		self:_updateList()
	end
end

function NewSlgBossTeamDetailPop:onClose()
	if self._isClose then
		return
	end

	self._isClose = true

	self.m_backTransition:play(handler(self, self.onCloseFinish))
end

function NewSlgBossTeamDetailPop:onCloseFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgBossTeamDetailPop:_onSchedule(arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3.key == "NewSlgBossTeamDetailPop_countDown" then
		self:_updateCountDown()
	end
end

function NewSlgBossTeamDetailPop:_onTouchBegin()
	self._compPlayerTeamInfo:setVis(false)
end

function NewSlgBossTeamDetailPop:_judgeLegal()
	local var_8_0 = g.core.model.User.newSlgData:getBossTeamInfo(self._teamId)

	if not var_8_0 then
		g.core.module.ModuleManager:popAllPopup()

		return false
	end

	if var_8_0.state == g.core.const.ConstMgr.NewSlgConst.SLGBossTeamState.STATE_2 then
		g.core.module.ModuleManager:tip(g.core.lang:get(428934))
		g.core.module.ModuleManager:popAllPopup()

		return false
	elseif var_8_0.state == g.core.const.ConstMgr.NewSlgConst.SLGBossTeamState.STATE_3 then
		g.core.module.ModuleManager:popAllPopup()

		return false
	end

	return true
end

function NewSlgBossTeamDetailPop:onUnload()
	g.core.utils.Tools.newSlgFunc.removeSchedule("NewSlgBossTeamDetailPop_countDown")
end

function NewSlgBossTeamDetailPop:receiveCompEvent(arg_10_1, arg_10_2)
	if arg_10_1 == "NewSlgBossTeamDetailCell_onClickDetail" then
		local var_10_0 = arg_10_2.comp:getSize()
		local var_10_1 = self._compPlayerTeamInfo:getParent()
		local var_10_2 = var_10_1:getSize()
		local var_10_3 = var_10_1:getPivot()

		self._compPlayerTeamInfo:setPosition((cc.pAdd(cc.p(20, 60), (cc.pAdd(cc.p(var_10_2.width * var_10_3.x, var_10_2.height * var_10_3.y), (var_10_1:globalToLocal((arg_10_2.comp:localToGlobal(cc.p(var_10_0.width, var_10_0.height))))))))))
		self._compPlayerTeamInfo:setVis(true, arg_10_2.teamUser)
	elseif arg_10_1 == "NewSlgBossTeamDetailCell_onClickQuit" then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = g.core.lang:get(428916),
			onConfirm = handler(self, function(arg_11_0)
				g.core.network.GameNetProxy:send_C2S_NewSlg_BossLeave({
					is_dismiss = false,
					team_id = arg_11_0._teamId
				})
			end)
		}), {
			touchDisappear = true
		})
	elseif arg_10_1 == "NewSlgBossTeamDetailCell_onClickDismiss" then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = g.core.lang:get(428918),
			onConfirm = handler(self, function(arg_12_0)
				g.core.network.GameNetProxy:send_C2S_NewSlg_BossLeave({
					is_dismiss = true,
					team_id = arg_12_0._teamId
				})
			end)
		}), {
			touchDisappear = true
		})
	elseif arg_10_1 == "NewSlgBossTeamDetailCell_onClickKickOut" then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = g.core.lang:get(428920),
			onConfirm = handler(self, function(arg_13_0)
				if arg_13_0._teamId then
					local var_13_0 = {
						team_id = arg_13_0._teamId
					}

					if arg_10_2.teamUser.user_id == 0 then
						var_13_0.user_id = arg_10_2.teamUser.robot_info_id or arg_10_2.teamUser.user_id
					end

					g.core.network.GameNetProxy:send_C2S_NewSlg_BossTeamKickOut(var_13_0)
				end
			end)
		}), {
			touchDisappear = true
		})
	elseif arg_10_1 == "NewSlgBossTeamDetailCell_onClickTransfer" then
		local var_10_4

		if arg_10_2.teamUser.robot_info_id > 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(428935))

			do return end

			var_10_4 = require("app.view.base.pop.BaseConfirmPop").new
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(111026),
			desc = g.core.lang:get(428922),
			onConfirm = handler(self, function(arg_14_0)
				g.core.network.GameNetProxy:send_C2S_NewSlg_BossTransferLeader({
					team_id = arg_14_0._teamId,
					user_id = arg_10_2.teamUser.user_id
				})
			end)
		}), {
			touchDisappear = true
		})
	elseif arg_10_1 == "NewSlgBossTeamDetailCell_onClickInvite" then
		local var_10_5 = g.core.model.User.newSlgData:getBossTeamInfo(self._teamId)

		if not var_10_5 then
			self:_judgeLegal()

			return
		end

		g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_BOSS_TEAM_INVITE_POP, {
			bossTeam = var_10_5,
			funcId = g.core.const.ConstMgr.FUNCTION_TYPE.NEW_SLG
		})
	end
end

function NewSlgBossTeamDetailPop:_updateView()
	local var_15_0 = g.core.model.User.newSlgData:getBossTeamInfo(self._teamId)

	if not var_15_0 then
		return
	end

	self._compBossView:updateView(var_15_0.boss_id)
	g.core.utils.Tools.newSlgFunc.addSchedule({
		key = "NewSlgBossTeamDetailPop_countDown",
		startTime = g.core.common.ServerTime:getTime(),
		endTime = var_15_0.create_time + g.core.model.User.newSlgData:getBossTeamGatherTotalTime()
	})
	self:_updateCountDown()
	self:_updatePlayerNum()
end

function NewSlgBossTeamDetailPop:_updateList()
	local var_16_0 = g.core.model.User.newSlgData:getBossTeamInfo(self._teamId)

	if not var_16_0 then
		return
	end

	self._userArr = var_16_0.users or {}
	self._selfIsLeader = false

	for iter_16_0, iter_16_1 in ipairs(self._userArr) do
		if iter_16_1.user_id == g.core.model.User:getId() and iter_16_1.is_leader then
			self._selfIsLeader = true

			break
		end
	end

	self._listPlayer:setNumItems(var_0_1)
end

function NewSlgBossTeamDetailPop:_updatePlayerNum()
	local var_17_0 = g.core.model.User.newSlgData:getBossTeamInfo(self._teamId)

	if not var_17_0 then
		return
	end

	local var_17_1 = var_17_0.users
	local var_17_2

	if not var_17_0.users then
		var_17_1 = {}
		var_17_2 = {}
	end

	var_17_2.num1 = #var_17_1
	var_17_2.num2 = var_0_1

	self._txtNum:setText(g.core.lang:get(428977, var_17_2))
end

function NewSlgBossTeamDetailPop:_updateCountDown()
	local var_18_0 = g.core.model.User.newSlgData:getBossTeamInfo(self._teamId)

	if not var_18_0 then
		g.core.utils.Tools.newSlgFunc.removeSchedule("NewSlgBossTeamDetailPop_countDown")

		return
	end

	self._txtCountDown:setText((g.core.common.ServerTime:secondToHMSString(var_18_0.create_time + g.core.model.User.newSlgData:getBossTeamGatherTotalTime() - g.core.common.ServerTime:getTime())))
end

function NewSlgBossTeamDetailPop:_onRenderListPlayerCell(arg_19_1, arg_19_2)
	arg_19_2:updateCell(self._userArr[arg_19_1 + 1], self._selfIsLeader)
end

function NewSlgBossTeamDetailPop:_onRcvNewSlgTeamChange()
	if self:_judgeLegal() then
		self:_updatePlayerNum()
		self:_updateList()
	end
end

function NewSlgBossTeamDetailPop:_onRcvUserStateNotify(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	if arg_21_4.tp == g.core.const.ConstMgr.NewSlgConst.SLGBossUserStateType.STATE_TYEP2 then
		if arg_21_4.user_id == g.core.model.User:getId() then
			g.core.module.ModuleManager:tip(g.core.lang:get(428936))
			g.core.module.ModuleManager:popAllPopup()

			return
		end
	elseif arg_21_4.tp == g.core.const.ConstMgr.NewSlgConst.SLGBossUserStateType.STATE_TYEP3 then
		g.core.module.ModuleManager:tip(g.core.lang:get(428937))
		g.core.module.ModuleManager:popAllPopup()

		return
	end

	if self:_judgeLegal() then
		self:_updatePlayerNum()
		self:_updateList()
	end
end

return NewSlgBossTeamDetailPop

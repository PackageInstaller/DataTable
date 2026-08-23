local var_0_0 = g.core.event.EventManager
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.model.User.GuildFightData
local var_0_3 = g.core.module.ModuleManager
local GuildFightConst = require("app.view.module.guildFight.const.GuildFightConst")
local GuildFightChariotBattleLayer = class("GuildFightChariotBattleLayer", require("app.fairyGUI.guildFight.UI_GuildFightChariotBattleLayer"), function()
	return fgui.GComponent:create({
		resName = "GuildFightChariotBattleLayer",
		pkgPath = "ui/guildFight/guildFight",
		pkgName = "guildFight"
	}, ...)
end)

function GuildFightChariotBattleLayer:ctor(arg_2_1)
	self:addBg("bg/guild/pic_tuweiguanqia.jpg")

	self._chariotId = arg_2_1.chariotId
	self._scoreInfo = nil
	self._chariotData = nil
	self._isWin = false
	self._isFightEnd = false
	self._playerList = self.m_battleComp:getPlayerList()
	self._oriData = var_0_2:getOriChariot()
	self._selfFightValue = g.core.model.User:getFightValue()
	self._effectComp = self.m_battleComp:getChild("CompEffect")

	self.m_lineupBtn:addClickListener(handler(self, self._onClickLineUp))
	self.m_battleBtn:addClickListener(handler(self, self._onClickChallenge))
	self.m_recordBtn:addClickListener(handler(self, self._onClickRecord))

	self._initialInfoX = self.m_infoGroup:getX()
end

function GuildFightChariotBattleLayer:onLoad()
	if var_0_2:isNormal() then
		g.core.module.ModuleManager:popModule()

		return
	end

	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GUILD_BATTLE_BEGINCHALLENGE, self._onRcvBeginChallenge, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_REPLY_BATTLE_REPORT, self._onGetBattleReport, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GUILD_NOTIFYLEAVE, self._onRcvNotifyLeave, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GUILD_BATTLE_NOTICENEWCHARIOT, self._onRcvNewChariot, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GUILD_BATTLE_NOTICEUSER, self._onRcvUpdateUser, self)
	var_0_0:addEventListener(var_0_1.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	self:_updateChariotPlayerComp()

	self._scoreInfo = var_0_2:getScoreInfoById(self._chariotId)

	self:_updateRewardInfo()
	self.m_enterTransition:play()
	self.m_infoGroup:setX(self._initialInfoX + display.width - CC_DESIGN_RESOLUTION.width)
end

function GuildFightChariotBattleLayer:_updateRewardInfo()
	if not self._scoreInfo then
		return
	end

	self.m_contributeText:setText(g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.CHARIOT_CONTRIBUTE).parameter)
	self.m_scoreText:setText(g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.CHARIOT_SCORE).parameter)
	self.m_destoryScoreText:setText(self._scoreInfo.score)

	for iter_4_0 = 1, 3 do
		self["m_player" .. iter_4_0]:updateHeadIcon({
			data = clone(self._chariotData[iter_4_0])
		})
	end
end

function GuildFightChariotBattleLayer:_updateChariotPlayerComp()
	self._chariotData = var_0_2:getChariot(self._chariotId)

	self.m_battleComp:updateComp({
		data = clone(self._chariotData)
	})
end

function GuildFightChariotBattleLayer:_onClickChallenge()
	self.m_backTransition:play(handler(self, function(arg_7_0)
		arg_7_0.m_infoGroup:setVisible(false)
		var_0_2:recordOriData(arg_7_0._chariotId)

		arg_7_0._oriData = var_0_2:getOriChariot()

		var_0_2:clearBattleVideo()
		g.core.network.GameNetProxy:send_C2S_GuildBattle_BeginChallenge({
			index = arg_7_0._chariotId
		})
	end))
end

function GuildFightChariotBattleLayer:_onClickLineUp()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

function GuildFightChariotBattleLayer:_onClickRecord()
	var_0_3:pushPopup((require("app.view.module.guildFight.view.GuildFightRecordPop").new({
		index = self._chariotId
	})))
end

function GuildFightChariotBattleLayer:_onRcvBeginChallenge()
	local var_10_0 = var_0_2:getBattleContent()

	if var_10_0 and var_10_0.ret ~= 1 then
		return
	end

	if not var_10_0 then
		return
	end

	if var_10_0.ret == 1 then
		self.m_topBar:setVisible(false)
		self:_initBattleResult()
		self:_playerBattleAnimation()

		self._isFightEnd = true
	end
end

function GuildFightChariotBattleLayer:_onGetBattleReport(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = require("app.core.network.ProtoBuilder"):decodeByMsgName("BattleReport", arg_11_3.report)

	if var_11_0 then
		var_0_2:insertBattleVideo(var_11_0)
	end
end

function GuildFightChariotBattleLayer:_initBattleResult()
	self._resultList, self._battleList, self._showList = var_0_2:calAndGetBattleResult(self._oriData, self._chariotId)
end

function GuildFightChariotBattleLayer:_playerBattleAnimation()
	local var_13_0 = {}

	for iter_13_0 = 1, #self._battleList do
		local var_13_1 = var_0_2:getChariotPosByIndex(self._chariotId, self._battleList[iter_13_0].index)

		var_13_0[var_13_1] = var_13_1
	end

	for iter_13_1 = 1, #self._playerList - 1 do
		if var_13_0[iter_13_1] or self._playerList[iter_13_1]:getCurLeft() > 0 then
			self._playerList[iter_13_1]:setCompVisible(true)
		else
			self._playerList[iter_13_1]:setCompVisible(false)
		end
	end

	for iter_13_2 = 1, #self._battleList do
		self:_showBattle(self._battleList[iter_13_2], iter_13_2)
	end
end

function GuildFightChariotBattleLayer:_showBattle(arg_14_1, arg_14_2)
	local var_14_2 = self._playerList[0]
	local var_14_3 = var_0_2:getChariotPosByIndex(self._chariotId, arg_14_1.index)
	local var_14_4 = self._playerList[var_14_3]
	local var_14_5 = self._chariotData[var_14_3].user.fight_value <= self._selfFightValue

	local function var_14_6()
		var_14_2:updateHpBar(self._battleList[arg_14_2].atk_hp_left)
		self:_updatePlayer(arg_14_2)

		if arg_14_1.is_win then
			var_14_2:show()
			self._playerList[var_14_3]:doDead(function()
				self._playerList[var_14_3]:setCompVisible(false)
			end)
		else
			var_14_2:doDead(handler(self, function()
				self:_isOver(false)
			end))
			self._playerList[var_14_3]:show()
		end
	end

	if self._playerList[0] and self._playerList[var_14_3] then
		self._playerList[0]:runFGAction((fgui.FSequence:create({
			fgui.FDelayTime:create((1 + 0.05 + 0.7 + 1.6) * (arg_14_2 - 1) + 0.5),
			fgui.FCallFunc:create(handler(self, function()
				if arg_14_2 == 1 then
					var_14_2:run()
				end
			end)),
			fgui.FMoveTo:create(1, cc.p(self._playerList[1]:getX() - 130, self._playerList[1]:getY())),
			fgui.FDelayTime:create(0.05),
			fgui.FCallFunc:create(handler(self, function()
				if var_14_5 then
					var_14_4:idle()
					var_14_2:attack(function()
						var_14_6()
					end)
				end
			end)),
			fgui.FDelayTime:create(0.7 + 1.6),
			fgui.FCallFunc:create(handler(self, function()
				if arg_14_2 == #self._battleList and arg_14_1.is_win then
					var_14_2:show()
					self:_isOver(true)
				end
			end))
		})))
		self._playerList[var_14_3]:runFGAction((fgui.FSequence:create({
			fgui.FDelayTime:create((1 + 0.05 + 0.7 + 1.6) * (arg_14_2 - 1) + 0.5),
			fgui.FCallFunc:create(handler(self, function()
				if var_14_3 ~= 1 then
					var_14_4:run()
				end
			end)),
			fgui.FMoveTo:create(1, cc.p(self._playerList[1]:getX(), self._playerList[1]:getY())),
			fgui.FDelayTime:create(0.05),
			fgui.FCallFunc:create(handler(self, function()
				if not var_14_5 then
					var_14_2:idle()
					var_14_4:attack(function()
						var_14_6()
					end)
				end
			end))
		})))
	end
end

function GuildFightChariotBattleLayer:_updatePlayer(arg_25_1)
	local var_25_0 = var_0_2:getChariotPosByIndex(self._chariotId, self._battleList[arg_25_1].index)

	self._oriData[var_25_0].left = self._battleList[arg_25_1].dfd_hp_left

	self._playerList[var_25_0]:updateHpBar(self._oriData[var_25_0].left)
end

function GuildFightChariotBattleLayer:_isOver(arg_26_1)
	var_0_3:popModule()

	local var_26_0 = var_0_2:getChariotFightFinishServiceInfo()

	if var_26_0 then
		var_26_0.content.isChariotWin = arg_26_1

		var_0_0:dispatchEvent(var_0_1.EVENT_BATTLE_RESULT, false, var_26_0.event, var_26_0.msgId, var_26_0.content)
		var_0_0:dispatchEvent(var_0_1.EVENT_FAKE_PVP_BATTLE_RESULT, false)
	end
end

function GuildFightChariotBattleLayer:_onRcvNotifyLeave(arg_27_1, arg_27_2, arg_27_3)
	if arg_27_3.type == g.core.const.ConstMgr.GuildCommonConst.LeaveType.REMOVE then
		g.core.module.ModuleManager:tip(g.core.lang:get(109547))
	elseif arg_27_3.type == g.core.const.ConstMgr.GuildCommonConst.LeaveType.DISSOLVE then
		g.core.module.ModuleManager:tip(g.core.lang:get(109548))
	elseif arg_27_3.type == g.core.const.ConstMgr.GuildCommonConst.LeaveType.MERGE then
		g.core.module.ModuleManager:tip(g.core.lang:get(430013))
	end

	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
end

function GuildFightChariotBattleLayer:_onRcvNewChariot(arg_28_1, arg_28_2, arg_28_3)
	if arg_28_3 then
		local var_28_0 = arg_28_3.index or nil

		if var_28_0 and not self._isFightEnd and var_28_0 == self._chariotId then
			var_0_3:popModule()
			var_0_3:tip(g.core.lang:get(109815))
		end
	end
end

function GuildFightChariotBattleLayer:_onRcvUpdateUser(arg_29_1, arg_29_2, arg_29_3)
	if self and self._chariotId and not var_0_2:isNormal() and arg_29_3 and arg_29_3.index and arg_29_3.index == self._chariotId then
		local var_29_0 = var_0_2:getChariot(self._chariotId)

		for iter_29_0 = 1, 3 do
			self._playerList[iter_29_0]:updateHpBar(var_29_0[iter_29_0].left, true)
		end
	end
end

function GuildFightChariotBattleLayer:_onCrossDayUpdate()
	var_0_3:popAllPopup()
	var_0_3:popModule()
end

return GuildFightChariotBattleLayer

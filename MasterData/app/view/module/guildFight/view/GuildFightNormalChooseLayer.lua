local var_0_0 = g.core.event.EventManager
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.model.User.GuildFightData
local var_0_3 = g.core.module.ModuleManager
local GuildFightNormalChooseLayer = class("GuildFightNormalChooseLayer", require("app.fairyGUI.guildFight.UI_GuildFightNormalChooseLayer"), function()
	return fgui.GComponent:create({
		resName = "GuildFightNormalChooseLayer",
		pkgPath = "ui/guildFight/guildFight",
		isFullScreen = true,
		pkgName = "guildFight"
	}, ...)
end)

function GuildFightNormalChooseLayer:ctor(arg_2_1)
	self._areaId = arg_2_1.areaId
	self.nameId = arg_2_1.nameId
	self._areaData = nil
	self._playerList = {}
	self._isUpdateView = true

	local var_2_0 = cc.Director:getInstance():getSafeAreaRect()
	local var_2_1 = self.m_playerList:getWidth() * (display.width / CC_DESIGN_RESOLUTION.width)

	if var_2_0.x > 0 then
		var_2_1 = var_2_1 - var_2_0.x * 2
	end

	self.m_playerList:setWidth(var_2_1)
	self.m_playerList:setVirtual()
	self.m_playerList:doFairyBatching(false)
	self.m_playerList:setItemRenderer(handler(self, self._onPlayerItemRenderer))
end

function GuildFightNormalChooseLayer:onLoad()
	if not var_0_2:isNormal() then
		g.core.module.ModuleManager:popModule()

		return
	end

	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GUILD_BATTLE_BEGINCHALLENGE, self._onRcvBeginChallenge, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GUILD_BATTLE_NOTICEUSER, self._onRcvUpdateUser, self)
	var_0_0:addEventListener(var_0_1.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GUILD_BATTLE_GETINFO, self._updateView, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GUILD_NOTIFYLEAVE, self._onRcvNotifyLeave, self)
	self:_updateView()
	self.m_enterTransition:play()
end

function GuildFightNormalChooseLayer:_updateView()
	self._areaData = var_0_2:getAllNormalAreaData(self._areaId)

	if self._areaData then
		self._playerList = self._areaData.playerList
	end

	self.m_progText:setText(g.core.lang:get(109806, {
		num = self._areaId
	}))
	self.m_areaNameText:setText(g.core.lang:get(self.nameId))
	self.m_leftCountComp:updateInfo((var_0_2:getLeftTimes()))
	self.m_fightValue:setText((self._playerList[#self._playerList] or {}).fightValue or "")
	self.m_playerList:setNumItems(#self._playerList)
	self.m_playerList:scrollToView(var_0_2:getSimilarFightValuePlayerIndexByData(self._playerList) - 1)
	self.m_playerList:transitionShowCells("listCardAUiLeftIn", 0.03, 1)
end

function GuildFightNormalChooseLayer:_onPlayerItemRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateInfo(self._playerList[arg_5_1 + 1])
end

function GuildFightNormalChooseLayer:_onCrossDayUpdate()
	var_0_3:popAllPopup()
	var_0_3:popModule()
	g.core.network.GameNetProxy:send_C2S_GuildBattle_GetInfo({
		is_match = true
	})
end

function GuildFightNormalChooseLayer:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "guildFight_begin_challenge" then
		var_0_2:clearBattleVideo()

		self._battle = true

		g.core.network.GameNetProxy:send_C2S_GuildBattle_BeginChallenge({
			index = arg_7_2.index
		})
	end
end

function GuildFightNormalChooseLayer:_onRcvUpdateUser(arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_3 then
		return
	end

	self:_updateView()
end

function GuildFightNormalChooseLayer:_onRcvBeginChallenge()
	local var_9_0 = var_0_2:getBattleContent()

	if var_9_0 and var_9_0.ret ~= 1 then
		self._isUpdateView = false

		return
	end

	self._isUpdateView = true

	if not var_9_0 then
		return
	end

	if var_9_0.ret == 1 then
		var_0_3:popComponent()

		local var_9_1 = var_9_0.battle_id or {}
		local BattleConst = require("app.view.battle.const.BattleConst")

		g.core.battle.BattleProxy:enterBattle({
			soundType = 2,
			battle_id = var_9_1[1],
			type = (var_0_2:isNormal() or nil) and (BattleConst.TYPE_GUILDFIGHT_PVP or BattleConst.TYPE_GUILDFIGHT_BOSS_PVP),
			skip = BattleConst.SKIP_TYPE.ACTIVE,
			battleType = BattleConst.BATTLE_TYPE.PVP
		})
	end
end

function GuildFightNormalChooseLayer:_onRcvNotifyLeave(arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3.type == g.core.const.ConstMgr.GuildCommonConst.LeaveType.REMOVE then
		g.core.module.ModuleManager:tip(g.core.lang:get(109547))
	elseif arg_10_3.type == g.core.const.ConstMgr.GuildCommonConst.LeaveType.DISSOLVE then
		g.core.module.ModuleManager:tip(g.core.lang:get(109548))
	elseif arg_10_3.type == g.core.const.ConstMgr.GuildCommonConst.LeaveType.MERGE then
		g.core.module.ModuleManager:tip(g.core.lang:get(430013))
	end

	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
end

return GuildFightNormalChooseLayer

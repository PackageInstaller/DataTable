local var_0_0 = g.core.const.ConstMgr.SpineConst
local var_0_1 = g.core.model.User.guildWorshipData
local var_0_2 = g.core.model.User.guildData
local var_0_3 = 500070
local GuildTaskMainLayer = class("GuildTaskMainLayer", require("app.fairyGUI.guild.UI_GuildTaskMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "guild",
		isFullScreen = true,
		pkgPath = "ui/guild/guild",
		resName = "GuildTaskMainLayer"
	}, ...)
end)

function GuildTaskMainLayer:ctor(arg_2_1)
	self._curShowVal = 0

	self:addBg("bg/guild/bg_jt_juantuanrenwu.jpg", false)
	self.m_topBar:setResInfoById(10)

	self._enterTrans = self:getView():getTransition("enter")
	self._backTrans = self:getView():getTransition("back")

	self._enterTrans:play()

	self._isHasTaskFinish = false

	self.m_knightPicComp:updateKnight({
		baseId = var_0_3
	})
	self.m_knightPicComp:setAlphaRect(var_0_0.MASK_TYPE.HORIZON, cc.rect(-200, 0, 400, 0), 300)
end

function GuildTaskMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WORSHIP_GETINFO, handler(self, self._onRcvGetInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WORSHIP_FINISHMISSION, handler(self, self._onRcvFinishMission), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WORSHIP_GETPROGRESSAWARD, handler(self, self._onRcvGetAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_EXCHANGE, handler(self, self._updateContUnit), self)
	self:_bindNetEvent()
end

function GuildTaskMainLayer:_bindNetEvent()
	g.core.network.GameNetProxy:send_C2S_Guild_GetInfo({})
	g.core.network.GameNetProxy:send_C2S_GuildWorship_GetInfo({})
end

function GuildTaskMainLayer:_onRcvGetInfo(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self:_updateContUnit()
	self:_updateProgComp()
end

function GuildTaskMainLayer:_updateProgComp(arg_6_1)
	self.m_progressComp:updateProgress({
		info = var_0_2:getCfg(var_0_1:getGuildLevelAtZero() or 1),
		isAnim = arg_6_1,
		curShowValue = self._curShowVal
	})

	self._curShowVal = self.m_progressComp:getCurShowValue()
end

function GuildTaskMainLayer:_updateContUnit(arg_7_1)
	local var_7_0 = {}
	local var_7_1 = var_0_1:getTaskList()

	for iter_7_0 = 1, #var_7_1 do
		table.insert(var_7_0, {
			handler(self["m_taskUnit" .. iter_7_0], self["m_taskUnit" .. iter_7_0].updateTask),
			{
				{
					data = var_7_1[iter_7_0]
				}
			}
		})
	end

	self:callFuncsFramesByFrames(var_7_0)
end

function GuildTaskMainLayer:_onRcvFinishMission(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self:_updateContUnit()
	self:_updateProgComp(true)

	local var_8_0 = arg_8_4.awards or {}
	local var_8_1 = {
		delay = 0.5,
		englishTitle = g.core.lang:get(109614),
		title = g.core.lang:get(109615)
	}

	g.core.module.ModuleManager:awardSummary(var_8_0, false)

	self._isHasTaskFinish = true
end

function GuildTaskMainLayer:_onRcvGetAward(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self:_updateBoxState()
	g.core.module.ModuleManager:awardSummary(arg_9_4.awards or {}, false, nil, nil, function()
		return
	end)
end

function GuildTaskMainLayer:_updateBoxState()
	self.m_progressComp:updateBoxState()
end

function GuildTaskMainLayer:receiveCompEvent(arg_12_1, arg_12_2)
	if arg_12_1 == "box_award_receive" then
		g.core.network.GameNetProxy:send_C2S_GuildWorship_GetProgressAward({
			index = arg_12_2.bindInfo
		})
	elseif arg_12_1 == "send_gift_award_receive" then
		self:_bindNetEvent()
	end
end

function GuildTaskMainLayer:oneKeyGetTaskAward()
	local var_13_0, var_13_1 = var_0_1:getOneKeyGetTaskAwardId()

	if #var_13_0 > 0 then
		g.core.network.GameNetProxy:send_C2S_GuildWorship_FinishMission_OneKey({
			id = var_13_0,
			num = var_13_1
		})
	end
end

function GuildTaskMainLayer:oneKeyGetProgressAward()
	local var_14_0 = var_0_1:getOneKeyGetProgressAwardId()

	if #var_14_0 > 0 then
		g.core.network.GameNetProxy:send_C2S_GuildWorship_GetProgressAward_OneKey({
			index = var_14_0
		})
	end
end

function GuildTaskMainLayer:_onCrossDayUpdate()
	self:_bindNetEvent()
end

function GuildTaskMainLayer:onUnload()
	if self._isHasTaskFinish then
		self._isHasTaskFinish = false

		g.core.network.GameNetProxy:send_C2S_Guild_GetInfo({})
	end
end

return GuildTaskMainLayer

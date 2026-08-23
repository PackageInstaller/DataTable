local var_0_0 = g.core.model.User.crossServerArenaData
local var_0_1 = g.core.const.ConstMgr.CrossServerArenaConst
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.network.GameNetProxy
local CrossServerArenaGuildRankLayer = class("CrossServerArenaGuildRankLayer", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaGuildRankLayer"), function()
	return fgui.GComponent:create({
		resName = "CrossServerArenaGuildRankLayer",
		pkgName = "crossServerArena",
		isFullScreen = true,
		pkgPath = "ui/crossServerArena/crossServerArena"
	})
end)

function CrossServerArenaGuildRankLayer:ctor()
	self._rankList = {}

	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRenderGuildRankCell))
	self.m_gloryBtn:addClickListener(handler(self, self._onClickGloryBtn))
	self.m_topBarComp:setResInfoById(var_0_1.TOP_BAR_RANK_LAYER)
	self:_updateView()
end

function CrossServerArenaGuildRankLayer:_updateView()
	self:_updateGuild()
	self:_updateRankList()
end

function CrossServerArenaGuildRankLayer:_updateGuild()
	local var_4_0 = g.core.model.User:getGuildId()

	if var_4_0 and var_4_0 > 0 then
		self.m_guildNameTxt:setText(g.core.model.User:getGuildName())

		local var_4_1, var_4_2 = var_0_0:getAddition()

		self.m_hasAdditionController:setSelectedIndex(var_4_1 and 1 or 0)
		self.m_additionTxt:setText(g.core.lang:get(411027, {
			num = var_4_2
		}))
	else
		self.m_hasAdditionController:setSelectedIndex(0)
		self.m_guildNameTxt:setText(g.core.lang:get(411026))
		self.m_additionTxt:setText("")
	end
end

function CrossServerArenaGuildRankLayer:_updateRankList()
	self._rankList = var_0_0:getGuildRankList()

	self.m_rankList:setNumItems(50)
	self:_updateGuild()
end

function CrossServerArenaGuildRankLayer:_onRenderGuildRankCell(arg_6_1, arg_6_2)
	arg_6_2:updateCell(arg_6_1, self._rankList[arg_6_1 + 1])
end

function CrossServerArenaGuildRankLayer:_onClickGloryBtn()
	if g.core.model.User:getGuildId() > 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.crossServerArena.pop.CrossServerArenaGloryPop").new(), {
			hideContinue = true,
			touchDisappear = true
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(411037))
	end
end

function CrossServerArenaGuildRankLayer:_onCrossDayUpdate()
	local var_8_0 = var_0_0:getSeasonStatus()

	if var_8_0 == var_0_1.CTRL_NONE_SEASON or var_8_0 == var_0_1.CTRL_PRE_SEASON then
		g.core.module.ModuleManager:tip(g.core.lang:get(411014))
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	var_0_0:resetGuildReceiveState()
	var_0_4:send_C2S_ChiefArena_GuildRank({})
	var_0_4:send_C2S_ChiefArena_GuildHonorRank({})
end

function CrossServerArenaGuildRankLayer:_onRcvReward(arg_9_1, arg_9_2, arg_9_3)
	g.core.module.ModuleManager:awardSummary(arg_9_3.awards or {}, nil, nil, g.core.lang:get(300001))
end

function CrossServerArenaGuildRankLayer:onLoad()
	var_0_3:addEventListener(var_0_2.EVENT_NET_S2C_CHIEF_ARENA_GUILDRANK, self._updateRankList, self)
	var_0_3:addEventListener(var_0_2.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	var_0_4:send_C2S_ChiefArena_GuildRank({})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_gloryBtn
	})
end

return CrossServerArenaGuildRankLayer

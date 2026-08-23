local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.guildWarData
local GuildWarDrillLeftRankComp = class("GuildWarDrillLeftRankComp", require("app.fairyGUI.guildWar.UI_GuildWarDrillLeftRankComp"))

function GuildWarDrillLeftRankComp:ctor()
	self._rankList = nil
	self._isDrillStage = true

	self:_initView()
end

function GuildWarDrillLeftRankComp:_initView()
	self.m_guildNameText:setText(g.core.model.User:getGuildName())
	self.m_guildIcon:setURL((var_0_0:getGuildMidIconById(g.core.model.User.guildData:getGuildData().icon or 5)))
	self.m_matchingPopBtn:addClickListener(handler(self, self._onClickMatchingBtn))
	self.m_guildRankList:setVirtual()
	self.m_guildRankList:setItemRenderer(handler(self, self._onRenderRankList))
end

function GuildWarDrillLeftRankComp:_onRenderRankList(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._rankList[arg_3_1 + 1], arg_3_1, self._isDrillStage)
end

function GuildWarDrillLeftRankComp:updateView()
	local var_4_0 = var_0_1:getDrillRankList()

	if var_4_0 == nil then
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 100,
			id = g.core.network.proto.GUILD_WAR_PRACTICE_SCORE_CROSS
		})
	else
		self._rankList = var_4_0

		if #var_4_0 > 0 then
			self.m_guildRankList:setNumItems(#self._rankList)
			self.m_isEmptyController:setSelectedIndex(0)
		else
			self.m_isEmptyController:setSelectedIndex(1)
		end
	end

	self.m_guildScoreText:setText(var_0_1:getDrillGuildScore())

	local var_4_1 = var_0_1:getDrillRank()

	self.m_groupStateController:setSelectedIndex(var_0_1:getDrillRankGroup(var_4_1) - 1)

	local var_4_2 = tostring(var_4_1)

	if var_4_1 <= 0 then
		var_4_2 = ""
	elseif var_4_1 < 10 then
		var_4_2 = "0" .. var_4_1
	end

	self.m_guildRankText:setText(var_4_2)
	self.m_hasRankController:setSelectedIndex(var_4_1 <= 0 and 0 or 1)
end

function GuildWarDrillLeftRankComp:_onClickMatchingBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.guildWar.view.pop.GuildWarMatchingShowPop").new(), {
		touchDisappear = false,
		ignoreTouch = false
	})
end

return GuildWarDrillLeftRankComp

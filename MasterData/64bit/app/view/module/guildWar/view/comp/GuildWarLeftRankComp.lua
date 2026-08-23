local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr.GuildWarConst
local var_0_2 = g.core.model.User.guildWarData
local GuildWarLeftRankComp = class("GuildWarLeftRankComp", require("app.fairyGUI.guildWar.UI_GuildWarLeftRankComp"))

function GuildWarLeftRankComp:ctor()
	self._showGroupIndex = var_0_2:getCurFightingGroup()
	self._rankList = nil

	self:_initView()
end

function GuildWarLeftRankComp:_initView()
	self.m_guildNameText:setText(g.core.model.User:getGuildName())
	self.m_guildIcon:setURL((var_0_0:getGuildMidIconById(g.core.model.User.guildData:getGuildData().icon or 5)))
	self.m_showGroupController:setSelectedIndex(self._showGroupIndex - 1)
	self.m_showGroupController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onShowTabChanged))
	self.m_matchResultBtn:addClickListener(handler(self, self._onClickMatchResultBtn))
	self.m_drillResultBtn:addClickListener(handler(self, self._onClickDrillResultBtn))
	self.m_guildRankList:setVirtual()
	self.m_guildRankList:setItemRenderer(handler(self, self._onRenderRankList))
end

function GuildWarLeftRankComp:_onRenderRankList(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._rankList[arg_3_1 + 1], arg_3_1)
end

function GuildWarLeftRankComp:onUnload(arg_4_1, arg_4_2)
	self.m_guildRankList:setVisible(false)
end

function GuildWarLeftRankComp:updateView()
	local var_5_0, var_5_1 = var_0_2:getFightRankList(self._showGroupIndex)

	if var_5_0 == nil then
		self:newScheduleOnce(function()
			g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
				size = 100,
				id = var_5_1
			})
		end, 0.5)
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_guildRankList:setVisible(true)

		self._rankList = var_5_0

		if #var_5_0 > 0 then
			self.m_guildRankList:setNumItems(#self._rankList)
			self.m_guildRankList:transitionShowCells("enter_left", 0.03)
			self.m_isEmptyController:setSelectedIndex(0)
		else
			self.m_isEmptyController:setSelectedIndex(1)
		end
	end

	local var_5_2 = var_0_2:getMyGuildStruct()

	if var_5_2 then
		self.m_guildScoreText:setText(var_5_2:getTotalScore())
	else
		self.m_guildScoreText:setText(0)
	end

	self.m_groupStateController:setSelectedIndex(var_0_2:getCurFightingGroup() - 1)

	local var_5_3 = var_0_2:getMyFightRank()
	local var_5_4 = tostring(var_5_3)

	if var_5_3 <= 0 then
		var_5_4 = ""
	elseif var_5_3 < 10 then
		var_5_4 = "0" .. var_5_3
	end

	self.m_guildRankText:setText(var_5_4)
	self:updateDrillResultBtn()
end

function GuildWarLeftRankComp:updateDrillResultBtn()
	local var_7_0 = false
	local var_7_1 = var_0_2:getStageType()

	if var_7_1 == var_0_1.StageType.FIGHT then
		if var_0_2:getFightStageType() == var_0_1.FightStageType.DEPLOY then
			var_7_0 = true
		end
	elseif var_7_1 == var_0_1.StageType.SEASON_RESULT then
		var_7_0 = true
	end

	self.m_isShowDrillResultController:setSelectedIndex(var_7_0 and 1 or 0)
end

function GuildWarLeftRankComp:_onShowTabChanged()
	local var_8_0 = self.m_showGroupController:getSelectedIndex() + 1

	if var_8_0 == self._showGroupIndex then
		return
	end

	self:cancelAllSchedule()

	self._showGroupIndex = var_8_0

	self:updateView()
end

function GuildWarLeftRankComp:setShareView()
	self.m_isShareController:setSelectedIndex(1)
	self.m_shareShowComp:updateShareComp(self._rankList or {}, self.m_guildRankList:getScrollPane():getPosY())
end

function GuildWarLeftRankComp:resetShareView()
	self.m_isShareController:setSelectedIndex(0)
end

function GuildWarLeftRankComp:_onClickMatchResultBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.guildWar.view.pop.GuildWarMatchingShowPop").new(), {
		touchDisappear = false,
		ignoreTouch = false
	})
end

function GuildWarLeftRankComp:_onClickDrillResultBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.guildWar.view.pop.GuildWarDrillResultPop").new(), {
		touchDisappear = false,
		ignoreTouch = false
	})
end

return GuildWarLeftRankComp

local var_0_0 = g.core.const.ConstMgr.GuildWarConst
local var_0_1 = {
	MYSELF = 2,
	ENEMY = 1,
	NONE = 0
}
local var_0_2 = g.core.model.User.guildWarData
local GuildWarCityComp = class("GuildWarCityComp", require("app.fairyGUI.guildWar.UI_GuildWarCityComp"))

function GuildWarCityComp:ctor()
	self._cityPos = var_0_0.CityPos.LEFT
	self._guildStruct = nil
	self._effectNode = nil
	self._attackEffectNode = nil

	self.m_bgLoader:addClickListener(handler(self, self.onClickCity))
	self.m_strategyIconLoader:addClickListener(handler(self, self._onClickStrategyIcon))
	self.m_strategyController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onStrategyChanged))
end

function GuildWarCityComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CLICK_FINISH, self.onClickFinish, self)
end

function GuildWarCityComp:updateComp(arg_3_1, arg_3_2, arg_3_3)
	self._cityPos = arg_3_1
	self._guildStruct = arg_3_2

	local var_3_0 = arg_3_2 and arg_3_2.guildSnapshot

	if arg_3_2 and arg_3_2.guildSnapshot then
		self.m_cityNameTxt:setText(arg_3_2.cityName)
		self.m_guildNameTxt:setText(var_3_0.name)
		self.m_serverNameTxt:setText(var_3_0.server_name)

		if arg_3_2:isMyGuild() then
			self.m_showStrategyController:setSelectedIndex(0)
			self.m_guildCampController:setSelectedIndex(var_0_1.MYSELF)
		else
			if var_0_2:getFightStageType() == var_0_0.FightStageType.FIGHTING then
				self.m_showStrategyController:setSelectedIndex(1)
			else
				self.m_showStrategyController:setSelectedIndex(0)
			end

			self.m_guildCampController:setSelectedIndex(var_0_1.ENEMY)
			self.m_strategyController:setSelectedIndex(arg_3_2.strategyType, false)

			if arg_3_2.strategyType == var_0_0.StrategyType.ATTACK then
				self:addAttackEffect()
			end

			self:addEnemyEffect()
		end

		self.m_showChooseController:setSelectedIndex(0)
		self.m_stateController:setSelectedIndex(arg_3_2.cityState)
	else
		self.m_cityNameTxt:setText(arg_3_3)
		self.m_guildNameTxt:setText(g.core.lang:get(308646))
		self.m_serverNameTxt:setText("")
		self.m_showStrategyController:setSelectedIndex(0)
		self.m_strategyController:setSelectedIndex(0, false)
		self.m_showChooseController:setSelectedIndex(0)
		self.m_guildCampController:setSelectedIndex(var_0_1.NONE)
	end
end

function GuildWarCityComp:addEnemyEffect()
	if self._effectNode == nil then
		self._effectNode = self.m_effectNode:addEffectSpine({
			isLoop = true,
			name = "eff_ui_guildwar_wartitle",
			anim = "play"
		})
	end
end

function GuildWarCityComp:onClickCity()
	if self._guildStruct then
		if self._guildStruct:isMyGuild() then
			g.core.module.ModuleManager:pushModule(g.view.entrance.GUILD_WAR_SELF_CITY, {
				cityPos = self._cityPos,
				guildId = self._guildStruct.guildId
			})
		elseif var_0_2:getFightStageType() == var_0_0.FightStageType.FIGHTING then
			g.core.module.ModuleManager:pushModule(g.view.entrance.GUILD_WAR_SELF_CITY, {
				cityPos = self._cityPos,
				guildId = self._guildStruct.guildId
			})
		else
			g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.GuildDetailsPop").new(self._guildStruct.guildSnapshot), {
				touchDisappear = true
			})
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(308646))
	end
end

function GuildWarCityComp:onClickFinish(arg_6_1, arg_6_2)
	if self:isStrategyChoosePopDisplayed() then
		local var_6_0 = arg_6_2:getInput():getTouch():getLocation()

		if self.m_strategyBtn_0:containPoint(var_6_0) or self.m_strategyBtn_1:containPoint(var_6_0) or self.m_strategyBtn_2:containPoint(var_6_0) then
			-- block empty
		else
			self.m_showChooseController:setSelectedIndex(0)
		end
	end
end

function GuildWarCityComp:_onClickStrategyIcon()
	if not self._guildStruct then
		return
	elseif self._guildStruct:isMyGuild() then
		return
	elseif not var_0_2:isLeader() then
		self:showClickStrategyTips()

		return
	end

	if self:isStrategyChoosePopDisplayed() then
		self.m_showChooseController:setSelectedIndex(0)
	else
		self.m_showChooseController:setSelectedIndex(1)
	end
end

function GuildWarCityComp:showClickStrategyTips()
	if self._guildStruct.strategyType == var_0_0.StrategyType.NONE then
		g.core.module.ModuleManager:tip(g.core.lang:get(308661))
	elseif self._guildStruct.strategyType == var_0_0.StrategyType.ATTACK then
		g.core.module.ModuleManager:tip(g.core.lang:get(308662))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(308663))
	end
end

function GuildWarCityComp:_onStrategyChanged()
	if not self._guildStruct then
		return
	elseif self._guildStruct:isMyGuild() then
		return
	elseif not var_0_2:isLeader() then
		return
	end

	local var_9_0 = self.m_strategyController:getSelectedIndex()

	if var_9_0 == self._guildStruct.strategyType then
		-- block empty
	else
		g.core.network.GameNetProxy:send_C2S_GuildWar_SetStrategy({
			guild_id = self._guildStruct.guildId,
			strategy = var_9_0
		})
		self.m_showChooseController:setSelectedIndex(0)
	end
end

function GuildWarCityComp:isStrategyChoosePopDisplayed()
	return self.m_showChooseController:getSelectedIndex() == 1
end

function GuildWarCityComp:updateStrategyType()
	if self._guildStruct then
		self.m_strategyController:setSelectedIndex(self._guildStruct.strategyType)

		if self._guildStruct.strategyType == var_0_0.StrategyType.ATTACK then
			self:addAttackEffect()
		end
	else
		self.m_strategyController:setSelectedIndex(var_0_0.StrategyType.NONE)
	end
end

function GuildWarCityComp:addAttackEffect()
	if self._attackEffectNode == nil then
		self._attackEffectNode = self.m_effectAttackNode:addEffectSpine({
			isLoop = true,
			name = "eff_ui_guildwar_warIcon",
			anim = "play"
		})
	end
end

return GuildWarCityComp

local var_0_0 = g.core.model.User.guildData
local var_0_1 = g.core.model.User.allianceData
local var_0_2 = g.core.const.ConstMgr.SnapShotCacheConst
local var_0_3 = g.core.model.User.snapShotCacheData
local AllianceInfoPop = class("AllianceInfoPop", require("app.fairyGUI.alliance.UI_AllianceInfoPop"), function()
	return fgui.GComponent:create({
		resName = "AllianceInfoPop",
		pkgPath = "ui/alliance/alliance",
		pkgName = "alliance"
	}, ...)
end)

function AllianceInfoPop:ctor(arg_2_1)
	self._allianceSnapshot = arg_2_1.allianceSnapshot

	if not self._allianceSnapshot then
		self._allianceId = arg_2_1.allianceId
		self._allianceSnapshot = var_0_3:getSnapShot(var_0_2.SNAP_SHOT_KEY.ALLIANCE, self._allianceId)
	else
		self._allianceId = self._allianceSnapshot.id
	end

	self:initView()
end

function AllianceInfoPop:initView()
	self.m_lookUserBtn:addClickListener(handler(self, self._onClickLookUserBtn))
	self.m_lookGuildBtn:addClickListener(handler(self, self._onClickLookGuildBtn))
	self.m_applyBtn:addClickListener(handler(self, self._onClickApplyBtn))
	self.m_applyBtn:setVisible(not var_0_1:hasAlliance())
end

function AllianceInfoPop:_onClickApplyBtn()
	if not self._allianceSnapshot then
		return
	end

	if not var_0_0:hasGuild() then
		g.core.module.ModuleManager:tip(g.core.lang:get(403507))

		return
	end

	if var_0_0:isLeader() then
		if not var_0_1:canJoinAlliance() then
			g.core.module.ModuleManager:tip(g.core.lang:get(428528, {
				time = g.core.common.ServerTime:getCountDownBySecond(var_0_1:geCanJoinAllianceTime())
			}))

			return
		end

		if self.m_isFullNumController:getSelectedIndex() == 1 then
			g.core.module.ModuleManager:tip(g.core.lang:get(428507))

			return
		end

		if self._allianceSnapshot.apply_level > var_0_0:getGuildLevel() then
			g.core.module.ModuleManager:tip(g.core.lang:get(428506))

			return
		end

		if self._allianceSnapshot.confirm and var_0_1:myIsApply(self._allianceId) then
			g.core.module.ModuleManager:tip(g.core.lang:get(428505))

			return
		end

		g.core.network.GameNetProxy:send_C2S_GuildAlliance_Apply({
			alliance_id = self._allianceId
		})
	else
		if var_0_1:myIsSuggest(self._allianceId) then
			g.core.module.ModuleManager:tip(g.core.lang:get(428504))

			return
		end

		g.core.network.GameNetProxy:send_C2S_GuildAlliance_Suggest({
			alliance_id = self._allianceId
		})
	end
end

function AllianceInfoPop:_onClickLookGuildBtn()
	if not self._allianceSnapshot then
		return
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.alliance.view.pop.AllianceGuildListPop").new({
		allianceSnapshot = self._allianceSnapshot
	}), {
		touchDisappear = true
	})
end

function AllianceInfoPop:_onClickLookUserBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
		uid = self._allianceSnapshot.leader_id
	})
end

function AllianceInfoPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETSNAPSHOT, handler(self, self._updateAllianceView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_SUGGEST, handler(self, self._updateSuggest), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_APPLY, handler(self, self._updateApply), self)
	self:_updateAllianceView()
end

function AllianceInfoPop:_updateAllianceView()
	self._allianceSnapshot = self._allianceSnapshot or var_0_3:getSnapShot(var_0_2.SNAP_SHOT_KEY.ALLIANCE, self._allianceId)

	if self._allianceSnapshot then
		self.m_flag:setURL(g.core.common.Path:getAllianceFlag128(var_0_1:getFlagRes(self._allianceSnapshot.flag)))
		self.m_allianceName:setText(self._allianceSnapshot.name)
		self.m_level:setText(g.core.lang:get(100535, {
			lv = self._allianceSnapshot.level
		}))
		self.m_userName:setText(g.core.lang:get(428503, {
			userName = self._allianceSnapshot.leader_name
		}))

		local var_8_0 = #self._allianceSnapshot.guild_ids or {}
		local var_8_1 = var_0_1:getAllianceGuildMaxNumByLv(self._allianceSnapshot.level)

		self.m_isFullNumController:setSelectedIndex(var_8_1 <= var_8_0 and 1 or 0)
		self.m_guildNum:setText(g.core.lang:get(107056, {
			num = var_8_0,
			maxNum = var_8_1
		}))
		self.m_fightValue:setText(self._allianceSnapshot.fight_value)

		local var_8_2 = g.core.model.User.guildData:getGuildLevel()

		self.m_applyCond:enableRich()
		self.m_applyCond:setText(g.core.lang:get(428501, {
			color = var_8_2 >= self._allianceSnapshot.apply_level and "#808080" or "#e52e2e",
			level = self._allianceSnapshot.apply_level
		}), true, true)

		local var_8_3 = self._allianceSnapshot.declaration or ""

		if var_8_3 == "" then
			var_8_3 = g.core.lang:get(428518)
		end

		self.m_declareText:setText(var_8_3)
		self.m_isLeaderController:setSelectedIndex(var_0_0:isLeader() and 1 or 0)
	end

	self:_updateSuggest()
end

function AllianceInfoPop:_updateSuggest()
	if var_0_1:hasAlliance() then
		self.m_isSuggestController:setSelectedIndex(0)

		return
	end

	local var_9_0 = var_0_1:getGuildSuggestNum(self._allianceId)

	if var_9_0 > 0 then
		self.m_suggestText:setText(g.core.lang:get(428502, {
			num = var_9_0
		}))
		self.m_hasSuggestController:setSelectedIndex(1)
	else
		self.m_hasSuggestController:setSelectedIndex(0)
	end

	self.m_isSuggestController:setSelectedIndex(var_0_1:myIsSuggest(self._allianceId) and 1 or 0)
end

function AllianceInfoPop:_updateApply()
	if self._allianceSnapshot.confirm then
		g.core.module.ModuleManager:tip(g.core.lang:get(428508))
	else
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

return AllianceInfoPop

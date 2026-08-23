local var_0_0 = g.core.model.User.snapShotCacheData
local var_0_1 = g.core.model.User.allianceData
local GuildDetailsPop = require("app.view.base.infoPop.GuildDetailsPop")
local var_0_3 = g.core.common.Path
local var_0_4 = g.core.const.ConstMgr.SnapShotCacheConst
local AllianceGuildListCell = class("AllianceGuildListCell", require("app.fairyGUI.alliance.UI_AllianceGuildListCell"))

function AllianceGuildListCell:ctor()
	self._guildId = 0
	self._allianceId = 0

	self:initView()
end

function AllianceGuildListCell:initView()
	self.m_lookBtn:addClickListener(handler(self, self._onClickLookBtn))
	self.m_revokeBtn:addClickListener(handler(self, self._onClickRevokeBtn))
	self.m_refuseBtn:addClickListener(handler(self, self._onClickRefuseBtn))
	self.m_agreeBtn:addClickListener(handler(self, self._onClickAgreeBtn))
end

function AllianceGuildListCell:_onClickRefuseBtn()
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_ApproveInvite({
		agree = false,
		alliance_id = self._allianceId
	})
	g.core.model.User.allianceData:onS2CApproveInvite({
		alliance_id = self._allianceId
	})
end

function AllianceGuildListCell:_onClickAgreeBtn()
	if not var_0_1:canJoinAlliance() then
		g.core.module.ModuleManager:tip(g.core.lang:get(428528, {
			time = g.core.common.ServerTime:getCountDownBySecond(var_0_1:geCanJoinAllianceTime())
		}))

		return
	end

	local var_4_0 = var_0_0:getSnapShot(var_0_4.SNAP_SHOT_KEY.ALLIANCE, self._allianceId)

	if var_4_0 and #var_4_0.guild_ids >= var_0_1:getAllianceGuildMaxNumByLv(var_4_0.level) then
		g.core.module.ModuleManager:tip(g.core.lang:get(428611))

		return
	end

	g.core.network.GameNetProxy:send_C2S_GuildAlliance_ApproveInvite({
		agree = true,
		alliance_id = self._allianceId
	})
	g.core.model.User.allianceData:onS2CApproveInvite({
		alliance_id = self._allianceId
	})
end

function AllianceGuildListCell:_onClickRevokeBtn()
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_CancelApply({
		alliance_id = self._allianceId
	})
	g.core.model.User.allianceData:onS2CCancelApply({
		alliance_id = self._allianceId
	})
end

function AllianceGuildListCell:_onClickLookBtn()
	local var_6_0 = var_0_0:getSnapShot(var_0_4.SNAP_SHOT_KEY.GUILD, self._guildId)

	if var_6_0 then
		g.core.module.ModuleManager:pushPopup(GuildDetailsPop.new(var_6_0), {
			touchDisappear = true
		})
	end
end

function AllianceGuildListCell:updateApplyCell(arg_7_1)
	self.m_showTypeController:setSelectedIndex(1)

	self._allianceId = arg_7_1 or self._allianceId

	self:updateAlliance()
end

function AllianceGuildListCell:updateAlliance()
	local var_8_0 = var_0_0:getSnapShot(var_0_4.SNAP_SHOT_KEY.ALLIANCE, self._allianceId)

	if var_8_0 then
		self.m_flagComp:setIcon(var_0_3:getAllianceFlag128(var_8_0.flag))
		self.m_name:setText(var_8_0.name)
		self.m_level:setText(var_8_0.level)
		self.m_userNum:setText(g.core.lang:get(107056, {
			num = #var_8_0.guild_ids,
			maxNum = var_0_1:getAllianceGuildMaxNumByLv(var_8_0.level)
		}))
		self.m_fightValue:setText(var_8_0.fight_value)
	end
end

function AllianceGuildListCell:updateInviteCell(arg_9_1)
	self.m_showTypeController:setSelectedIndex(2)

	self._allianceId = arg_9_1 or self._allianceId

	self:updateAlliance()
end

function AllianceGuildListCell:updateGuildCell(arg_10_1)
	self._guildId = arg_10_1 or self._guildId

	self.m_showTypeController:setSelectedIndex(0)

	local var_10_0 = var_0_0:getSnapShot(var_0_4.SNAP_SHOT_KEY.GUILD, self._guildId)

	if var_10_0 then
		self.m_flagComp:setIcon(var_0_3:getGuildMidIconById(var_10_0.icon))
		self.m_name:setText(var_10_0.name)
		self.m_level:setText(var_10_0.level)
		self.m_userNum:setText(var_10_0.member_num)
		self.m_fightValue:setText(var_10_0.fight_value)
	end
end

return AllianceGuildListCell

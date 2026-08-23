local var_0_0 = g.core.module.ModuleManager
local var_0_1 = g.core.model.User.allianceData
local var_0_2 = g.core.const.ConstMgr.AllianceConst
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.event.enum
local var_0_5 = g.core.model.User.snapShotCacheData
local var_0_6 = g.core.const.ConstMgr.SnapShotCacheConst
local var_0_7 = g.core.config.guild_alliance_right_info
local AllianceHallLayer = class("AllianceHallLayer", require("app.fairyGUI.alliance.UI_AllianceHallLayer"), function()
	return fgui.GComponent:create({
		pkgName = "alliance",
		isFullScreen = true,
		pkgPath = "ui/alliance/alliance",
		resName = "AllianceHallLayer"
	}, ...)
end)

function AllianceHallLayer:ctor()
	self:addBg("bg/alliance/bg_ghlm_xinxibg.jpg")

	self._guildList = {}

	self.m_guildList:setVirtual()
	self.m_guildList:setItemRenderer(handler(self, self._onRenderGuildList))

	self._pullDownType = var_0_2.PULL_DOWN_TYPE.MEMBER_NUM
	self._guildOrder = var_0_2.GUILD_ORDER.DOWN
	self._myGrade = var_0_2.GRADE.MEMBER

	self.m_pullDownComp:updateComp(self._guildOrder, self._pullDownType)
	self.m_inviteBtn:addClickListener(handler(self, self._onClickInviteBtn))
	self.m_applyListBtn:addClickListener(handler(self, self._onClickApplyListBtn))
	self.m_tipBtn:addClickListener(handler(self, self._onClickTipBtn))
	self.m_copyBtn:addClickListener(handler(self, self._onClickCopyBtn))
	self.m_editInfoTouchBg:addClickListener(handler(self, self._onClickEditInfo))
	self.m_editNameBtn:addClickListener(handler(self, self._onClickEditInfo))
	self.m_recordBtn:addClickListener(handler(self, self._onClickRecordBtn))
	self.m_topBarComp:setResInfoById(339)
	self.m_levelTip:addClickListener(handler(self, self._onClickLevelTipBtn))
end

function AllianceHallLayer:onLoad()
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, self._onS2CGuildSnapShot, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_GUILD_ALLIANCE_DISMISSNOTICE, self._onS2CAllianceDismissNotice, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_GUILD_ALLIANCE_DISMISS, self._onS2CAllianceDismiss, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_GUILD_ALLIANCE_QUIT, self._onS2CAllianceQuit, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_GUILD_ALLIANCE_APPOINT, self._onS2CAllianceAppoint, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_GUILD_ALLIANCE_KICK, self._onS2CAllianceKick, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_GUILD_ALLIANCE_KICKNOTICE, self._onS2CAllianceKickNotice, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_GUILD_ALLIANCE_IMPEACH, self._onS2CAllianceImpeach, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_GUILD_ALLIANCE_NOTICESTATE, self._onS2CNoticeState, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_GUILD_ALLIANCE_MODIFYCONTENT, self._onS2CModifyContent, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_GUILD_ALLIANCE_APPROVEAPPLY, self._onS2CApproveApply, self)
	var_0_3:addEventListener(var_0_4.EVENT_CLICK_FINISH, self._onGameTouchFinish, self)
	self.m_enterTransition:play()
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_ApplyList({})
	self:_updateView()
end

function AllianceHallLayer:_updateView()
	self._myGrade = var_0_1:getGradeByUid(g.core.model.User.guildData:getGuildData(), g.core.model.User:getId())

	self.m_gradeController:setSelectedIndex(self._myGrade)

	self._guildList = var_0_1:getAllianceGuilds()

	self.m_myGuild:updateView()
	self:_updateRightView()
	self:_updateAllianceView()
	self:_updateGuildList()
end

function AllianceHallLayer:_updateRightView()
	local var_5_0 = var_0_7.get(self._myGrade)

	self.m_inviteGroup:setVisible(var_5_0.invite == 1)
	self.m_applyGroup:setVisible(var_5_0.audit == 1)
	self.m_editNameBtn:setVisible(var_5_0.alliance_name == 1)
end

function AllianceHallLayer:_updateAllianceView()
	self.m_allianceName:setText(var_0_1:getAllianceName())
	self.m_allianceId:setText(var_0_1:getAllianceId())
	self.m_allianceLevel:setText(var_0_1:getAllianceLevel())
	self.m_guildNum:setText(string.format("%d/%d", #self._guildList, (var_0_1:getAllianceGuildMaxNum())))

	local var_6_0 = var_0_1:getGuildAllianceInfo().daily_max or 0

	self.m_todayLimit:setText(var_6_0)
	self.m_todayProg:setText(math.min(var_0_1:getDailyExp(), var_6_0) .. "/" .. var_6_0)
	self.m_expProg:updateExp()
	self.m_alliancePic:setURL(g.core.common.Path:getAllianceFlag256(var_0_1:getFlagRes()))
	self:_updateAlliancePower()
	self:_updateLeaderName()
	self:_updateNotice()
end

function AllianceHallLayer:_updateNotice()
	self.m_announceLabel:updateNoticeLabel(var_0_2.NOTICE_TYPE.ANNOUNCE, self._myGrade)
	self.m_declareLabel:updateNoticeLabel(var_0_2.NOTICE_TYPE.DECLARE, self._myGrade)
end

function AllianceHallLayer:_updateAlliancePower()
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(self._guildList) do
		local var_8_1 = var_0_5:getSnapShot(var_0_6.SNAP_SHOT_KEY.GUILD, iter_8_1.guild_id)

		if var_8_1 then
			var_8_0 = var_8_0 + var_8_1.fight_value
		end
	end

	self.m_alliancePower:setText(var_8_0)
end

function AllianceHallLayer:_updateLeaderName()
	local var_9_0 = var_0_5:getSnapShot(var_0_6.SNAP_SHOT_KEY.GUILD, (var_0_1:getLeaderGuildId()))

	if var_9_0 then
		self.m_leaderName:setText(var_9_0.leader_name)
	end
end

function AllianceHallLayer:_updateGuildList()
	table.sort(self._guildList, self:getSortFunction())
	self.m_guildList:setNumItems(#self._guildList)
end

function AllianceHallLayer:_onRenderGuildList(arg_11_1, arg_11_2)
	arg_11_2:updateGuildCell(self._guildList[arg_11_1 + 1])
end

function AllianceHallLayer:getSortFunction()
	local var_12_0 = self._pullDownType
	local var_12_1 = self._guildOrder

	return function(arg_13_0, arg_13_1)
		local var_13_0 = var_0_1:getGrade(arg_13_0.guild_id)
		local var_13_1 = var_0_1:getGrade(arg_13_1.guild_id)

		if var_13_0 ~= var_13_1 then
			return var_13_0 < var_13_1
		end

		local var_13_2 = var_0_5:getSnapShot(var_0_6.SNAP_SHOT_KEY.GUILD, arg_13_0.guild_id)
		local var_13_3 = var_0_5:getSnapShot(var_0_6.SNAP_SHOT_KEY.GUILD, arg_13_1.guild_id)

		if var_13_2 and var_13_3 then
			if var_12_0 == var_0_2.PULL_DOWN_TYPE.POWER then
				if var_13_2.fight_value ~= var_13_3.fight_value then
					if var_12_1 == 1 then
						return var_13_2.fight_value < var_13_3.fight_value
					else
						return var_13_2.fight_value > var_13_3.fight_value
					end
				end
			elseif var_12_0 == var_0_2.PULL_DOWN_TYPE.MEMBER_NUM then
				if var_13_2.member_num ~= var_13_3.member_num then
					if var_12_1 == 1 then
						return var_13_2.member_num < var_13_3.member_num
					else
						return var_13_2.member_num > var_13_3.member_num
					end
				end
			elseif var_12_0 == var_0_2.PULL_DOWN_TYPE.TODAY then
				local var_13_4 = arg_13_0.daily_exp
				local var_13_5 = arg_13_1.daily_exp

				if arg_13_0.daily_exp ~= arg_13_1.daily_exp then
					if var_12_1 == 1 then
						return var_13_4 < var_13_5
					else
						return var_13_5 < var_13_4
					end
				end
			elseif var_12_0 == var_0_2.PULL_DOWN_TYPE.TOTAL then
				local var_13_6 = arg_13_0.total_exp
				local var_13_7 = arg_13_1.total_exp

				if arg_13_0.total_exp ~= arg_13_1.total_exp then
					if var_12_1 == 1 then
						return var_13_6 < var_13_7
					else
						return var_13_7 < var_13_6
					end
				end
			end
		end

		return arg_13_0.guild_id < arg_13_1.guild_id
	end
end

function AllianceHallLayer:_onClickInviteBtn()
	if var_0_1:getAllianceGuildMaxNum() <= var_0_1:getGuildNum() then
		g.core.module.ModuleManager:tip(g.core.lang:get(428611))

		return
	end

	var_0_0:pushPopup(require("app.view.module.alliance.view.hall.AllianceHallInvitePop").new(), {
		touchDisappear = true
	})
end

function AllianceHallLayer:_onClickApplyListBtn()
	var_0_0:pushPopup(require("app.view.module.alliance.view.hall.AllianceHallApplyPop").new(), {
		touchDisappear = true
	})
end

function AllianceHallLayer:_onClickTipBtn()
	self.m_isShowTipController:setSelectedIndex(1)
end

function AllianceHallLayer:_onClickLevelTipBtn()
	var_0_0:pushPopup(require("app.view.module.alliance.view.hall.AllianceHallLevelPop").new(), {
		touchDisappear = true
	})
end

function AllianceHallLayer:_onClickCopyBtn()
	var_0_0:tip(g.core.lang:get(109551))
	g.core.platform.PlatformProxy:copyToClipboard(tostring(var_0_1:getAllianceId()))
end

function AllianceHallLayer:_onClickEditInfo()
	if self._myGrade ~= var_0_2.GRADE.LEADER then
		return
	end

	var_0_0:pushPopup(require("app.view.module.alliance.view.hall.AllianceHallEditNamePop").new(), {
		touchDisappear = true
	})
end

function AllianceHallLayer:_onClickRecordBtn()
	var_0_0:pushPopup(require("app.view.module.alliance.view.hall.AllianceHallLogPop").new(), {
		touchDisappear = true
	})
end

function AllianceHallLayer:_onGameTouchFinish()
	self.m_isShowTipController:setSelectedIndex(0)
end

function AllianceHallLayer:_onS2CGuildSnapShot()
	self:_updateAlliancePower()
	self:_updateGuildList()
	self:_updateLeaderName()
end

function AllianceHallLayer:_onS2CAllianceDismissNotice()
	var_0_0:tip(g.core.lang:get(428565))
	self:newScheduleOnce(function()
		var_0_0:popToRoot()
	end)
end

function AllianceHallLayer:_onS2CAllianceDismiss()
	var_0_0:tip(g.core.lang:get(428565))
	self:newScheduleOnce(function()
		var_0_0:popToRoot()
	end)
end

function AllianceHallLayer:_onS2CAllianceQuit()
	var_0_0:tip(g.core.lang:get(428566))
	self:newScheduleOnce(function()
		var_0_0:popToRoot()
	end)
end

function AllianceHallLayer:_onS2CAllianceAppoint(arg_29_1, arg_29_2, arg_29_3)
	self:_updateView()
end

function AllianceHallLayer:_onS2CAllianceKick()
	self:_updateView()
end

function AllianceHallLayer:_onS2CAllianceKickNotice()
	var_0_0:tip(g.core.lang:get(428567))
	self:newScheduleOnce(function()
		var_0_0:popToRoot()
	end)
end

function AllianceHallLayer:_onS2CAllianceImpeach()
	var_0_0:tip(g.core.lang:get(428564))
end

function AllianceHallLayer:_onS2CNoticeState(arg_34_1, arg_34_2, arg_34_3)
	if arg_34_3.state == var_0_2.NOTICE_STATE.QUIT then
		var_0_0:tip(g.core.lang:get(428566))
		self:newScheduleOnce(function()
			var_0_0:popToRoot()
		end)
	end
end

function AllianceHallLayer:_onS2CModifyContent(arg_36_1, arg_36_2, arg_36_3)
	if arg_36_3.tp == var_0_2.MODIFY_CONTENT_TYPE.DECLARE then
		self.m_declareLabel:setTitle(arg_36_3.content, false, true)
	elseif arg_36_3.tp == var_0_2.MODIFY_CONTENT_TYPE.ANNOUNCE then
		self.m_announceLabel:setTitle(arg_36_3.content, false, true)
	elseif arg_36_3.tp == var_0_2.MODIFY_CONTENT_TYPE.NAME then
		var_0_0:tip(g.core.lang:get(428604))
		self.m_allianceName:setText(arg_36_3.content)
	end
end

function AllianceHallLayer:_onS2CApproveApply(arg_37_1, arg_37_2, arg_37_3)
	if arg_37_3.agree then
		local var_37_0 = var_0_5:getSnapShot(var_0_6.SNAP_SHOT_KEY.GUILD, arg_37_3.guild_id)

		if var_37_0 then
			var_0_0:tip(g.core.lang:get(428610, {
				guild = var_37_0.name
			}))
		end

		self:_updateView()
	end
end

function AllianceHallLayer:receiveCompEvent(arg_38_1, arg_38_2)
	if arg_38_1 == "PULL_DOWN_SELECT" then
		self._pullDownType = arg_38_2.index

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_RankingSwitchPage)
		self:_updateGuildList()
	elseif arg_38_1 == "PULL_DOWN_ORDER_CHANGE" then
		self._guildOrder = arg_38_2.order

		self:_updateGuildList()
	end
end

return AllianceHallLayer

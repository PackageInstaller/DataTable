local GuildEventInfoPage = class("GuildEventInfoPage", import(".GuildEventBasePage"))

function GuildEventInfoPage:getUIName()
	return "GuildEventInfoPage"
end

function GuildEventInfoPage:OnLoaded()
	self.closeBtn = self._tf:Find("frame/close")
	self.icon = self._tf:Find("frame/icon"):GetComponent(typeof(Image))
	self.goBtn = self._tf:Find("frame/go_btn")
	self.joinBtn = self._tf:Find("frame/join_btn")
	self.descTxt = self._tf:Find("frame/desc"):GetComponent(typeof(Text))
	self.consumeTF = self._tf:Find("frame/consume")
	self.consumeTxt = self._tf:Find("frame/consume/Text"):GetComponent(typeof(Text))
	self.cntTF = self._tf:Find("frame/cnt")
	self.cntTxt = self._tf:Find("frame/cnt/Text"):GetComponent(typeof(Text))
	self.nameTxt = self._tf:Find("frame/title/Text"):GetComponent(typeof(Text))
	self.scaleTxt = self._tf:Find("frame/title/scale"):GetComponent(typeof(Text))
	self.scaleCntTxt = self._tf:Find("frame/title/scale/Text"):GetComponent(typeof(Text))
	self.progressTF = self._tf:Find("frame/cnt/progress")
	self.progressTxt = self._tf:Find("frame/cnt/progress/Text"):GetComponent(typeof(Text))
	self.missionList = UIItemList.New(self._tf:Find("frame/events/icons"), self._tf:Find("frame/events/icons/tpl"))
	self.awardList = UIItemList.New(self._tf:Find("frame/award/displays"), self._tf:Find("frame/award/displays/item"))

	setText(self._tf:Find("frame/events/Text"), i18n("guild_word_may_happen_event"))
	setText(self._tf:Find("frame/award/Text"), i18n("guild_battle_award"))
	setText(self._tf:Find("frame/consume/label"), i18n("guild_word_consume"))
	setText(self._tf:Find("frame/cnt/label"), i18n("guild_join_event_cnt_label"))
	setText(self._tf:Find("frame/cnt/progress/label"), i18n("guild_join_event_progress_label"))

	return
end

function GuildEventInfoPage:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.goBtn, function()
		if not GuildMember.IsAdministrator(self.guild:getSelfDuty()) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_commander_and_sub_op"))

			return
		end

		local var_6_0 = self.gevent:GetName()
		local var_6_1 = self.gevent:GetConsume()
		local var_6_2 = self.guild:ShouldTipActiveEvent() and i18n("guild_start_event_consume_tip", var_6_1, var_6_0) or i18n("guild_start_event_consume_tip_extra", var_6_1, var_6_0, self.guild:GetActiveEventCnt())

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = var_6_2,
			onYes = function()
				self:emit(GuildEventMediator.ON_ACTIVE_EVENT, self.gevent.id)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.joinBtn, function()
		if not self.activeEvent then
			return
		end

		if self.activeEvent:IsLimitedJoin() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_join_event_max_cnt_tip"))

			return
		end

		self:JoinEvent()

		return
	end, SFX_PANEL)

	return
end

function GuildEventInfoPage:JoinEvent()
	local function var_9_0()
		local var_10_0, var_10_1 = self.activeEvent:GetMainMissionCntAndFinishCnt()

		if var_10_1 ~= 0 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("guild_join_event_exist_finished_mission_tip"),
				onYes = function()
					self:emit(GuildEventMediator.ON_JOIN_EVENT)

					return
				end
			})
		else
			self:emit(GuildEventMediator.ON_JOIN_EVENT)
		end

		return
	end

	if self.activeEvent:GetLeftTime() <= 0 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("guild_tip_operation_time_is_not_ample"),
			onYes = var_9_0
		})
	else
		var_9_0()
	end

	return
end

function GuildEventInfoPage:Refresh(arg_12_1, arg_12_2)
	self:UpdateData(arg_12_1, arg_12_2, self.extraData)
	self:UpdateBtnState()

	return
end

function GuildEventInfoPage:OnShow()
	self.gevent = self.extraData.gevent

	local var_13_0 = self.gevent

	self.icon.sprite = GetSpriteFromAtlas("guildevent/i_" .. self.gevent.id, "")

	setActive(self.icon.gameObject, true)

	self.descTxt.text = var_13_0:GetDesc()

	local var_13_1 = self.guild:getCapital()
	local var_13_2 = var_13_0:GetConsume()

	self.consumeTxt.text = "<color=" .. ((var_13_1 < var_13_2 or nil) and (COLOR_RED or COLOR_GREEN)) .. ">" .. var_13_1 .. "</color>/" .. var_13_2
	self.nameTxt.text = var_13_0:GetName()
	self.scaleTxt.text = var_13_0:GetScaleDesc()
	self.scaleCntTxt.text = ""

	self:UpdateMissions(var_13_0)
	self:UpdateAwards(var_13_0)
	self:UpdateBtnState()

	return
end

function GuildEventInfoPage:UpdateBtnState()
	self.activeEvent = self.guild:GetActiveEvent()

	setActive(self.goBtn, not self.activeEvent)
	setActive(self.consumeTF, not self.activeEvent)
	setActive(self.joinBtn, self.activeEvent)
	setActive(self.cntTF, self.activeEvent)
	setActive(self.progressTF, self.activeEvent)

	if self.activeEvent then
		local var_14_0 = self.activeEvent:GetMaxJoinCnt()
		local var_14_1 = var_14_0 - self.activeEvent:GetJoinCnt() + self.activeEvent:GetExtraJoinCnt()

		self.cntTxt.text = string.format("<color=%s>%d</color>/%d", (var_14_1 <= 0 or nil) and (COLOR_RED or COLOR_WHITE), var_14_1, var_14_0)

		local var_14_2, var_14_3 = self.activeEvent:GetMainMissionCntAndFinishCnt()

		self.progressTxt.text = var_14_3 .. "/" .. var_14_2 + 1
	end

	return
end

function GuildEventInfoPage:UpdateAwards(arg_15_1)
	local var_15_0 = arg_15_1:GetDisplayAward()

	self.awardList:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			local var_16_0 = {
				id = var_15_0[arg_16_1 + 1][2],
				type = var_15_0[arg_16_1 + 1][1],
				count = var_15_0[arg_16_1 + 1][3]
			}

			updateDrop(arg_16_2, var_16_0)
			onButton(self, arg_16_2, function()
				self:emit(BaseUI.ON_DROP, var_16_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.awardList:align(#var_15_0)

	return
end

function GuildEventInfoPage:UpdateMissions(arg_18_1)
	local var_18_0 = arg_18_1:GetDisplayMission()

	self.missionList:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			arg_19_2:GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("GuildEventIcon", var_18_0[arg_19_1 + 1])
		end

		return
	end)
	self.missionList:align(#var_18_0)

	return
end

return GuildEventInfoPage

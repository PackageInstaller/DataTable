local GuildEventPage = class("GuildEventPage", import("....base.BaseSubView"))

function GuildEventPage:getUIName()
	return "GuildEventPage"
end

function GuildEventPage:OnLoaded()
	self.eventList = UIItemList.New(self._tf:Find("eventlist/content"), self._tf:Find("eventlist/content/tpl"))
	self.reportBtn = self._tf:Find("report_btn")
	self.reportTip = self.reportBtn:Find("tip")
	self.reportTipTxt = self.reportBtn:Find("tip/Text"):GetComponent(typeof(Text))
	self.formationBtn = self._tf:Find("formation_btn")
	self.missionList = self._tf:Find("missionlist")
	self.pathContains = self._tf:Find("missionlist/path")
	self.tpl = self:getTpl("tpl", self.pathContains)
	self.line = self._tf:Find("resource/line")
	self.lineHead = self._tf:Find("resource/head")
	self.adapter = self._tf:Find("resource/adapter")
	self.bg = self._tf:Find("bg"):GetComponent(typeof(Image))
	self.titleTF = self._tf:Find("title")
	self.nameTxt = self._tf:Find("title/Text"):GetComponent(typeof(Text))
	self.descPanel = self._tf:Find("missionlist/path/desc_panel")
	self.descPanelTag = self.descPanel:Find("Image"):GetComponent(typeof(Image))

	setText(self._tf:Find("title/timer/label"), i18n("guild_time_remaining_tip"))

	self.endEventTimerTxt = self._tf:Find("title/timer/Text"):GetComponent(typeof(Text))
	self.timeView = GuildEventTimerView.New()

	return
end

function GuildEventPage:OnInit()
	onButton(self, self.reportBtn, function()
		self:emit(GuildEventMediator.ON_OPEN_REPORT)

		return
	end, SFX_PANEL)
	onButton(self, self.formationBtn, function()
		self:emit(GuildEventLayer.ON_OPEN_FORMATION)

		return
	end, SFX_PANEL)

	return
end

function GuildEventPage:OnReportUpdated()
	self.reports = getProxy(GuildProxy):GetReports()

	self:UpdateReportBtn()

	return
end

function GuildEventPage:Show(arg_7_1, arg_7_2, arg_7_3)
	GuildEventPage.super.Show(self)
	self:UpdateData(arg_7_1, arg_7_2, arg_7_3)
	self:SwitchPage()
	self:OnReportUpdated()
	self._tf:SetAsFirstSibling()

	return
end

function GuildEventPage:UpdateData(arg_8_1, arg_8_2, arg_8_3)
	self.guildVO = arg_8_1
	self.player = arg_8_2
	self.events = arg_8_3
	self.activeEvent = _.detect(self.events, function(arg_9_0)
		return arg_9_0:IsActive()
	end)

	return
end

function GuildEventPage:SwitchPage()
	if self.contextData.editFleet then
		triggerButton(self.formationBtn)
	end

	local var_10_0 = self.activeEvent
	local var_10_1 = not self.activeEvent or var_10_0 and not var_10_0:IsParticipant()

	if var_10_1 then
		self:InitEvents()
	else
		self:BuildTree(var_10_0)
		self:InitView()
		self:GenTree()
		self:InitTree()
		self:EnterActiveNode()
		self:CheckBossNode()
		self:RefreshLatelyNode()
		self:AddRefreshTime()
		self.timeView:Flush(self.endEventTimerTxt, var_10_0)
	end

	setActive(self.eventList.container, var_10_1)
	setActive(self.missionList, not var_10_1)
	setActive(self.titleTF, not var_10_1)

	return
end

function GuildEventPage:UpdateReportBtn()
	local var_11_0 = _.select(_.values(self.reports), function(arg_12_0)
		return arg_12_0:CanSubmit()
	end)
	local var_11_1 = #var_11_0 > 0 and not self.guildVO:getMemberById(self.player.id):IsRecruit()

	setActive(self.reportTip, var_11_1)

	if var_11_1 then
		self.reportTipTxt.text = #var_11_0
	end

	return
end

function GuildEventPage:InitEvents()
	self.bg.sprite = GetSpriteFromAtlas("commonbg/guild_event_bg", "")
	self.displays = {}

	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(self.events) do
		table.insert(self.displays, iter_13_1)
	end

	table.insert(self.displays, false)
	self.eventList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			self:UpdateEvent(arg_14_2, self.events[arg_14_1 + 1])

			if self.events[arg_14_1 + 1] then
				var_13_0[self.events[arg_14_1 + 1].id] = arg_14_2
			end
		end

		return
	end)
	self.eventList:align(#self.displays)

	if self.activeEvent and not self.contextData.editFleet then
		triggerButton(var_13_0[self.activeEvent.id])
	end

	return
end

local var_0_1 = {
	"easy",
	"normal",
	"hard"
}

function GuildEventPage:UpdateEvent(arg_15_1, arg_15_2)
	local var_15_0 = self.activeEvent

	arg_15_1:GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("guildevent/" .. ((arg_15_2 or nil) and (arg_15_2.id or 0)), "")

	local var_15_1 = arg_15_1:Find("tag")

	if arg_15_2 then
		local var_15_2 = var_15_1:GetComponent(typeof(Image))

		var_15_2.sprite = GetSpriteFromAtlas("ui/GuildEventUI_atlas", "tag_" .. var_0_1[arg_15_2:getConfig("difficulty")])

		var_15_2:SetNativeSize()
	end

	setActive(var_15_1, arg_15_2)

	local var_15_3 = self.activeEvent and arg_15_2 and self.activeEvent.id == arg_15_2.id

	setActive(arg_15_1:Find("state"), self.activeEvent and arg_15_2 and self.activeEvent.id == arg_15_2.id)
	setActive(arg_15_1:Find("consume"), arg_15_2 and not var_15_3)
	setActive(arg_15_1:Find("timer"), var_15_3)

	local var_15_4

	if var_15_3 then
		self.timeView:Flush(arg_15_1:Find("timer/Text"):GetComponent(typeof(Text)), self.activeEvent)

		var_15_4 = var_15_3 and i18n("guild_time_remaining_tip") or ""
	end

	setText(arg_15_1:Find("timer/label"), var_15_4)

	if not arg_15_2 then
		removeOnButton(arg_15_1)

		return
	end

	setText(arg_15_1:Find("consume/label"), i18n("guild_word_consume_for_battle"))
	setText(arg_15_1:Find("consume/Text"), arg_15_2:GetConsume())

	local var_15_5 = arg_15_2:IsUnlock(self.guildVO.level)

	if not var_15_5 then
		arg_15_1:Find("mask"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("guildevent/" .. "0_0", "")
	end

	setActive(arg_15_1:Find("mask"), not var_15_5)
	onButton(self, arg_15_1, function()
		if not arg_15_2 then
			return
		end

		if not arg_15_2:IsUnlock(self.guildVO.level) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_level_no_enough"))

			return
		end

		if var_15_0 and var_15_0.id ~= arg_15_2.id then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_open_event_info_when_exist_active", var_15_0:getConfig("name")))

			return
		end

		self:emit(GuildEventLayer.OPEN_EVENT_INFO, arg_15_2)

		return
	end, SFX_PANEL)

	return
end

function GuildEventPage:OnRefreshNode(arg_17_1, arg_17_2)
	if not self.nodes then
		return
	end

	self:BuildTree(arg_17_1)

	for iter_17_0, iter_17_1 in ipairs(self.nodes) do
		if iter_17_1.data.id == arg_17_2.id or iter_17_1.data:IsBoss() and arg_17_2:IsBoss() then
			iter_17_1:UpdateData(arg_17_2)
		end
	end

	if not arg_17_2:IsBoss() then
		self:CheckBossNode()
	end

	return
end

function GuildEventPage:EnterActiveNode()
	if self.contextData.mission then
		self:emit(GuildEventLayer.ON_OPEN_MISSION, self.contextData.mission)
	end

	return
end

function GuildEventPage:CheckBossNode()
	if self.nodes[#self.nodes]:ParentIsFinishByServer() and not self.nodes[#self.nodes]:IsActive() then
		self:emit(GuildEventMediator.ON_GET_BOSS_INFO)
	elseif self.nodes[#self.nodes]:ParentIFinish() and not self.nodes[#self.nodes]:IsActive() then
		self:emit(GuildEventMediator.REFRESH_MISSION, self.nodes[#self.nodes]:GetParentId())
	end

	return
end

function GuildEventPage:InitView()
	self.bg.sprite = GetSpriteFromAtlas("GuildMission/" .. self.gevent:GetTheme(), "")
	self.nameTxt.text = self.gevent:GetName()

	return
end

function GuildEventPage:BuildTree(arg_21_1)
	self.gevent = arg_21_1
	self.missions = {}

	local var_21_0 = self.gevent:GetBossMission()

	self.bossPosition = var_21_0:GetPosition()
	self.lastPosition = -1

	for iter_21_0, iter_21_1 in pairs((self.gevent:GetMissions())) do
		self.missions[iter_21_0] = iter_21_1

		if _.any(iter_21_1, function(arg_22_0)
			return arg_22_0:IsMain() and arg_22_0:IsFinish()
		end) then
			self.lastPosition = iter_21_0
		end
	end

	self.lastPosition = self.lastPosition + 1
	self.missions[self.bossPosition] = {
		var_21_0
	}

	return
end

function GuildEventPage:RefreshLatelyNode()
	if self.lastPosition <= 0 or self.lastPosition == self.bossPosition then
		return
	end

	local var_23_0 = self.lastPosition
	local var_23_1 = {}

	for iter_23_0, iter_23_1 in ipairs(self.gevent:GetMissions()[self.lastPosition] or {}) do
		if not iter_23_1:IsBoss() then
			table.insert(var_23_1, function(arg_24_0)
				self:emit(GuildEventMediator.REFRESH_MISSION, iter_23_1.id, arg_24_0)

				return
			end)
		end
	end

	seriesAsync(var_23_1, function()
		if var_23_0 ~= self.lastPosition then
			self:RefreshLatelyNode()
		end

		return
	end)

	return
end

function GuildEventPage:AddRefreshTime()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.timer = Timer.New(function()
		self:RefreshLatelyNode()
		self:AddRefreshTime()

		return
	end, GuildConst.FORCE_REFRESH_MISSION_TREE_TIME, 1)

	self.timer:Start()

	return
end

function GuildEventPage:GenTree()
	self.nodes = {}

	for iter_28_0, iter_28_1 in pairs(self.missions) do
		table.sort(iter_28_1, function(arg_29_0, arg_29_1)
			return arg_29_0:GetSubType() > arg_29_1:GetSubType()
		end)

		for iter_28_2, iter_28_3 in ipairs(iter_28_1) do
			table.insert(self.nodes, (self:CreateNode(cloneTplTo(self.tpl, self.pathContains, iter_28_0 .. "-" .. iter_28_2), iter_28_0, iter_28_3)))
		end
	end

	return
end

function GuildEventPage:CreateNode(arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = GuildViewMissionNode.New({
		go = arg_30_1.gameObject,
		slot = arg_30_2,
		data = arg_30_3,
		parent = self.last
	})

	if self.last then
		self.last:AddChild(var_30_0)
	end

	if var_30_0:IsMain() then
		self.last = var_30_0
	end

	onButton(self, arg_30_1, function()
		if self.prevSelected == var_30_0 then
			return
		end

		if not var_30_0:IsUnLock() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_event_is_lock"))

			return
		end

		if var_30_0:IsFinish() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_event_is_finish"))

			return
		end

		if self.prevSelected then
			self:HideDesc(self.prevSelected)
		end

		self:ShowDesc(var_30_0)

		self.prevSelected = var_30_0

		return
	end, SFX_PANEL)

	return var_30_0
end

function GuildEventPage:InitTree()
	local var_32_0 = {
		0,
		0
	}
	local var_32_1

	for iter_32_0, iter_32_1 in ipairs(self.nodes) do
		iter_32_1:Init()

		local var_32_2 = math.abs(iter_32_1._tf.anchoredPosition.x)
		local var_32_3 = math.abs(iter_32_1._tf.anchoredPosition.y)

		if var_32_2 > var_32_0[1] then
			var_32_0[1] = var_32_2 + iter_32_1._tf.sizeDelta.x
		end

		if var_32_3 > var_32_0[2] then
			var_32_0[2] = var_32_3 + iter_32_1._tf.sizeDelta.y / 2
		end

		if iter_32_1:IsMain() and iter_32_1:IsUnLock() then
			var_32_1 = iter_32_1
		end
	end

	for iter_32_2, iter_32_3 in ipairs(self.nodes) do
		self:CreateLinkLine(iter_32_3)
		iter_32_3:UpdateLineStyle()
	end

	self:SetScrollRect(var_32_0)

	if var_32_1 then
		setAnchoredPosition(self.pathContains, {
			x = math.max(-var_32_1._tf.localPosition.x, -self.pathContains.rect.width * 0.5)
		})
	end

	return
end

function GuildEventPage:CreateLinkLine(arg_33_1)
	local function var_33_0(arg_34_0, arg_34_1)
		local var_34_0 = Instantiate(arg_34_0)

		var_34_0.name = arg_34_1

		return var_34_0
	end

	if arg_33_1:HasChild() then
		arg_33_1.AddLine(arg_33_1, var_33_0(self.adapter, "adapter"), GuildViewMissionNode.LINE_RIGHT, arg_33_1)
	end

	if arg_33_1:HasParent() then
		arg_33_1.AddLine(arg_33_1, var_33_0(self.adapter, "adapter"), GuildViewMissionNode.LINE_LEFT, arg_33_1)
	end

	for iter_33_0, iter_33_1 in ipairs((arg_33_1:GetChilds())) do
		local var_33_1 = iter_33_1:GetOffset()

		if var_33_1 > 0 then
			arg_33_1:AddLine(var_33_0(self.line, "line"), GuildViewMissionNode.TOP_LINK, iter_33_1)
			arg_33_1:AddLine(var_33_0(self.line, "line"), GuildViewMissionNode.TOP_HRZ_LINK, iter_33_1)
		elseif var_33_1 < 0 then
			arg_33_1:AddLine(var_33_0(self.line, "line"), GuildViewMissionNode.BOTTOM_LINK, iter_33_1)
			arg_33_1:AddLine(var_33_0(self.line, "line"), GuildViewMissionNode.BOTTOM_HRZ_LINK, iter_33_1)
		elseif var_33_1 == 0 then
			arg_33_1:AddLine(var_33_0(self.line, "line"), GuildViewMissionNode.CENTER_LINK, iter_33_1)
		end
	end

	return
end

function GuildEventPage:SetScrollRect(arg_35_1)
	self.pathContains.sizeDelta = Vector2(arg_35_1[1] + 100, arg_35_1[2] * 2 + 100)

	return
end

function GuildEventPage:ShowDesc(arg_36_1)
	arg_36_1:Selected(true)
	setActive(self.descPanel, true)

	if self.pathContains.rect.height / 2 < arg_36_1._tf.localPosition.y + 50 + arg_36_1._tf.rect.height then
		self.chcheSizeDelta = self.pathContains.sizeDelta
		self.pathContains.sizeDelta = Vector2(self.chcheSizeDelta.x, self.chcheSizeDelta.y + (self.pathContains.rect.height / 2 + (arg_36_1._tf.localPosition.y + 50 + arg_36_1._tf.rect.height - self.pathContains.rect.height / 2) * 2))

		scrollTo(self.missionList, false, 1)
	end

	self.descPanel.localPosition = Vector3(arg_36_1._tf.localPosition.x, arg_36_1._tf.localPosition.y + 50, 0)
	self.descPanel:GetComponent(typeof(Image)).sprite = not arg_36_1.data:IsBoss() and GetSpriteFromAtlas("GuildMission/" .. arg_36_1.data:GetIcon(), "") or GetSpriteFromAtlas("GuildMission/boss_" .. arg_36_1.data:GetIcon(), "")
	self.descPanelTag.sprite = GetSpriteFromAtlas("ui/GuildMissionUI_atlas", "tag" .. arg_36_1.data:GetTag())

	local function var_36_0(arg_37_0)
		if not arg_37_0:IsUnLock() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_event_is_lock"))

			return false
		end

		if arg_37_0:IsFinish() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_event_is_finish"))

			return false
		end

		return true
	end

	onButton(self, self.descPanel, function()
		if arg_36_1.data:IsBoss() then
			if not var_36_0(arg_36_1) then
				return
			end

			self:emit(GuildEventLayer.ON_OPEN_BOSS, arg_36_1.data)
		else
			self:emit(GuildEventMediator.REFRESH_MISSION, arg_36_1.data.id, function()
				if not var_36_0(arg_36_1) then
					return
				end

				self.contextData.mission = arg_36_1.data

				self:emit(GuildEventLayer.ON_OPEN_MISSION, arg_36_1.data)

				return
			end)
		end

		return
	end, SFX_PANEL)

	return
end

function GuildEventPage:HideDesc(arg_40_1)
	arg_40_1:Selected(false)

	if self.chcheSizeDelta then
		self.pathContains.sizeDelta = self.chcheSizeDelta
	end

	setActive(self.descPanel, false)

	return
end

function GuildEventPage:OnDestroy()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.timeView:Dispose()

	return
end

return GuildEventPage

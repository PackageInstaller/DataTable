local var_0_0 = class("GuildEventPage", import("....base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "GuildEventPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.eventList = UIItemList.New(arg_2_0._tf:Find("eventlist/content"), arg_2_0._tf:Find("eventlist/content/tpl"))
	arg_2_0.reportBtn = arg_2_0._tf:Find("report_btn")
	arg_2_0.reportTip = arg_2_0.reportBtn:Find("tip")
	arg_2_0.reportTipTxt = arg_2_0.reportBtn:Find("tip/Text"):GetComponent(typeof(Text))
	arg_2_0.formationBtn = arg_2_0._tf:Find("formation_btn")
	arg_2_0.missionList = arg_2_0._tf:Find("missionlist")
	arg_2_0.pathContains = arg_2_0._tf:Find("missionlist/path")
	arg_2_0.tpl = arg_2_0:getTpl("tpl", arg_2_0.pathContains)
	arg_2_0.line = arg_2_0._tf:Find("resource/line")
	arg_2_0.lineHead = arg_2_0._tf:Find("resource/head")
	arg_2_0.adapter = arg_2_0._tf:Find("resource/adapter")
	arg_2_0.bg = arg_2_0._tf:Find("bg"):GetComponent(typeof(Image))
	arg_2_0.titleTF = arg_2_0._tf:Find("title")
	arg_2_0.nameTxt = arg_2_0._tf:Find("title/Text"):GetComponent(typeof(Text))
	arg_2_0.descPanel = arg_2_0._tf:Find("missionlist/path/desc_panel")
	arg_2_0.descPanelTag = arg_2_0.descPanel:Find("Image"):GetComponent(typeof(Image))

	setText(arg_2_0._tf:Find("title/timer/label"), i18n("guild_time_remaining_tip"))

	arg_2_0.endEventTimerTxt = arg_2_0._tf:Find("title/timer/Text"):GetComponent(typeof(Text))
	arg_2_0.timeView = GuildEventTimerView.New()

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.reportBtn, function()
		arg_3_0:emit(GuildEventMediator.ON_OPEN_REPORT)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.formationBtn, function()
		arg_3_0:emit(GuildEventLayer.ON_OPEN_FORMATION)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnReportUpdated(arg_6_0)
	arg_6_0.reports = getProxy(GuildProxy):GetReports()

	arg_6_0:UpdateReportBtn()

	return
end

function var_0_0.Show(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	var_0_0.super.Show(arg_7_0)
	arg_7_0:UpdateData(arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:SwitchPage()
	arg_7_0:OnReportUpdated()
	arg_7_0._tf:SetAsFirstSibling()

	return
end

function var_0_0.UpdateData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.guildVO = arg_8_1
	arg_8_0.player = arg_8_2
	arg_8_0.events = arg_8_3
	arg_8_0.activeEvent = _.detect(arg_8_0.events, function(arg_9_0)
		return arg_9_0:IsActive()
	end)

	return
end

function var_0_0.SwitchPage(arg_10_0)
	if arg_10_0.contextData.editFleet then
		triggerButton(arg_10_0.formationBtn)
	end

	local var_10_0 = arg_10_0.activeEvent
	local var_10_1 = not arg_10_0.activeEvent or var_10_0 and not var_10_0:IsParticipant()

	if var_10_1 then
		arg_10_0:InitEvents()
	else
		arg_10_0:BuildTree(var_10_0)
		arg_10_0:InitView()
		arg_10_0:GenTree()
		arg_10_0:InitTree()
		arg_10_0:EnterActiveNode()
		arg_10_0:CheckBossNode()
		arg_10_0:RefreshLatelyNode()
		arg_10_0:AddRefreshTime()
		arg_10_0.timeView:Flush(arg_10_0.endEventTimerTxt, var_10_0)
	end

	setActive(arg_10_0.eventList.container, var_10_1)
	setActive(arg_10_0.missionList, not var_10_1)
	setActive(arg_10_0.titleTF, not var_10_1)

	return
end

function var_0_0.UpdateReportBtn(arg_11_0)
	local var_11_0 = _.select(_.values(arg_11_0.reports), function(arg_12_0)
		return arg_12_0:CanSubmit()
	end)
	local var_11_1 = arg_11_0.guildVO:getMemberById(arg_11_0.player.id)
	local var_11_2 = #var_11_0 > 0 and not var_11_1:IsRecruit()

	setActive(arg_11_0.reportTip, var_11_2)

	if var_11_2 then
		arg_11_0.reportTipTxt.text = #var_11_0
	end

	return
end

function var_0_0.InitEvents(arg_13_0)
	arg_13_0.bg.sprite = GetSpriteFromAtlas("commonbg/guild_event_bg", "")
	arg_13_0.displays = {}

	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.events) do
		table.insert(arg_13_0.displays, iter_13_1)
	end

	table.insert(arg_13_0.displays, false)
	arg_13_0.eventList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			arg_13_0:UpdateEvent(arg_14_2, arg_13_0.events[arg_14_1 + 1])

			if arg_13_0.events[arg_14_1 + 1] then
				var_13_0[arg_13_0.events[arg_14_1 + 1].id] = arg_14_2
			end
		end

		return
	end)
	arg_13_0.eventList:align(#arg_13_0.displays)

	if arg_13_0.activeEvent and not arg_13_0.contextData.editFleet then
		triggerButton(({})[arg_13_0.activeEvent.id])
	end

	return
end

local var_0_1 = {
	"easy",
	"normal",
	"hard"
}

function var_0_0.UpdateEvent(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.activeEvent

	if arg_15_2 then
		local var_15_1 = arg_15_2.id or 0

		arg_15_1:GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("guildevent/" .. var_15_1, "")

		local var_15_2 = arg_15_1:Find("tag")

		if arg_15_2 then
			local var_15_3 = var_15_2:GetComponent(typeof(Image))

			var_15_3.sprite = GetSpriteFromAtlas("ui/GuildEventUI_atlas", "tag_" .. var_0_1[arg_15_2:getConfig("difficulty")])

			var_15_3:SetNativeSize()
		end

		setActive(var_15_2, arg_15_2)

		local var_15_4 = arg_15_0.activeEvent and arg_15_2 and arg_15_0.activeEvent.id == arg_15_2.id

		setActive(arg_15_1:Find("state"), arg_15_0.activeEvent and arg_15_2 and arg_15_0.activeEvent.id == arg_15_2.id)
		setActive(arg_15_1:Find("consume"), arg_15_2 and not var_15_4)
		setActive(arg_15_1:Find("timer"), var_15_4)

		local var_15_5

		if var_15_4 then
			arg_15_0.timeView:Flush(arg_15_1:Find("timer/Text"):GetComponent(typeof(Text)), arg_15_0.activeEvent)

			var_15_5 = var_15_4 and i18n("guild_time_remaining_tip") or ""
		end

		setText(arg_15_1:Find("timer/label"), var_15_5)

		if not arg_15_2 then
			removeOnButton(arg_15_1)

			return
		end

		setText(arg_15_1:Find("consume/label"), i18n("guild_word_consume_for_battle"))
		setText(arg_15_1:Find("consume/Text"), arg_15_2:GetConsume())

		local var_15_6 = arg_15_2:IsUnlock(arg_15_0.guildVO.level)

		if not var_15_6 then
			arg_15_1:Find("mask"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("guildevent/" .. "0_0", "")
		end

		setActive(arg_15_1:Find("mask"), not var_15_6)
		onButton(arg_15_0, arg_15_1, function()
			if not arg_15_2 then
				return
			end

			if not arg_15_2:IsUnlock(arg_15_0.guildVO.level) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("guild_level_no_enough"))

				return
			end

			if var_15_0 and var_15_0.id ~= arg_15_2.id then
				pg.TipsMgr.GetInstance():ShowTips(i18n("guild_open_event_info_when_exist_active", var_15_0:getConfig("name")))

				return
			end

			arg_15_0:emit(GuildEventLayer.OPEN_EVENT_INFO, arg_15_2)

			return
		end, SFX_PANEL)

		return
	end
end

function var_0_0.OnRefreshNode(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0.nodes then
		return
	end

	arg_17_0:BuildTree(arg_17_1)

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.nodes) do
		if iter_17_1.data.id == arg_17_2.id or iter_17_1.data:IsBoss() and arg_17_2:IsBoss() then
			iter_17_1:UpdateData(arg_17_2)
		end
	end

	if not arg_17_2:IsBoss() then
		arg_17_0:CheckBossNode()
	end

	return
end

function var_0_0.EnterActiveNode(arg_18_0)
	if arg_18_0.contextData.mission then
		arg_18_0:emit(GuildEventLayer.ON_OPEN_MISSION, arg_18_0.contextData.mission)
	end

	return
end

function var_0_0.CheckBossNode(arg_19_0)
	if arg_19_0.nodes[#arg_19_0.nodes]:ParentIsFinishByServer() and not arg_19_0.nodes[#arg_19_0.nodes]:IsActive() then
		arg_19_0:emit(GuildEventMediator.ON_GET_BOSS_INFO)
	elseif arg_19_0.nodes[#arg_19_0.nodes]:ParentIFinish() and not arg_19_0.nodes[#arg_19_0.nodes]:IsActive() then
		arg_19_0:emit(GuildEventMediator.REFRESH_MISSION, arg_19_0.nodes[#arg_19_0.nodes]:GetParentId())
	end

	return
end

function var_0_0.InitView(arg_20_0)
	arg_20_0.bg.sprite = GetSpriteFromAtlas("GuildMission/" .. arg_20_0.gevent:GetTheme(), "")
	arg_20_0.nameTxt.text = arg_20_0.gevent:GetName()

	return
end

function var_0_0.BuildTree(arg_21_0, arg_21_1)
	arg_21_0.gevent = arg_21_1
	arg_21_0.missions = {}

	local var_21_0 = arg_21_0.gevent:GetBossMission()

	arg_21_0.bossPosition = var_21_0:GetPosition()
	arg_21_0.lastPosition = -1

	for iter_21_0, iter_21_1 in pairs((arg_21_0.gevent:GetMissions())) do
		arg_21_0.missions[iter_21_0] = iter_21_1

		if _.any(iter_21_1, function(arg_22_0)
			return arg_22_0:IsMain() and arg_22_0:IsFinish()
		end) then
			arg_21_0.lastPosition = iter_21_0
		end
	end

	arg_21_0.lastPosition = arg_21_0.lastPosition + 1
	arg_21_0.missions[arg_21_0.bossPosition] = {
		var_21_0
	}

	return
end

function var_0_0.RefreshLatelyNode(arg_23_0)
	if arg_23_0.lastPosition <= 0 or arg_23_0.lastPosition == arg_23_0.bossPosition then
		return
	end

	local var_23_0 = arg_23_0.gevent:GetMissions()[arg_23_0.lastPosition] or {}

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		if not iter_23_1:IsBoss() then
			table.insert({}, function(arg_24_0)
				arg_23_0:emit(GuildEventMediator.REFRESH_MISSION, iter_23_1.id, arg_24_0)

				return
			end)
		end
	end

	seriesAsync({}, function()
		if var_0 ~= arg_23_0.lastPosition then
			arg_23_0:RefreshLatelyNode()
		end

		return
	end)

	return
end

function var_0_0.AddRefreshTime(arg_26_0)
	if arg_26_0.timer then
		arg_26_0.timer:Stop()

		arg_26_0.timer = nil
	end

	arg_26_0.timer = Timer.New(function()
		arg_26_0:RefreshLatelyNode()
		arg_26_0:AddRefreshTime()

		return
	end, GuildConst.FORCE_REFRESH_MISSION_TREE_TIME, 1)

	arg_26_0.timer:Start()

	return
end

function var_0_0.GenTree(arg_28_0)
	arg_28_0.nodes = {}

	for iter_28_0, iter_28_1 in pairs(arg_28_0.missions) do
		table.sort(iter_28_1, function(arg_29_0, arg_29_1)
			return arg_29_0:GetSubType() > arg_29_1:GetSubType()
		end)

		for iter_28_2, iter_28_3 in ipairs(iter_28_1) do
			table.insert(arg_28_0.nodes, (arg_28_0:CreateNode(cloneTplTo(arg_28_0.tpl, arg_28_0.pathContains, iter_28_0 .. "-" .. iter_28_2), iter_28_0, iter_28_3)))
		end
	end

	return
end

function var_0_0.CreateNode(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = GuildViewMissionNode.New({
		go = arg_30_1.gameObject,
		slot = arg_30_2,
		data = arg_30_3,
		parent = arg_30_0.last
	})

	if arg_30_0.last then
		arg_30_0.last:AddChild(var_30_0)
	end

	if var_30_0:IsMain() then
		arg_30_0.last = var_30_0
	end

	onButton(arg_30_0, arg_30_1, function()
		if arg_30_0.prevSelected == var_30_0 then
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

		if arg_30_0.prevSelected then
			arg_30_0:HideDesc(arg_30_0.prevSelected)
		end

		arg_30_0:ShowDesc(var_30_0)

		arg_30_0.prevSelected = var_30_0

		return
	end, SFX_PANEL)

	return var_30_0
end

function var_0_0.InitTree(arg_32_0)
	local var_32_0

	for iter_32_0, iter_32_1 in ipairs(arg_32_0.nodes) do
		iter_32_1:Init()

		local var_32_1 = math.abs(iter_32_1._tf.anchoredPosition.x)
		local var_32_2 = math.abs(iter_32_1._tf.anchoredPosition.y)

		if var_32_1 > ({
			0,
			0
		})[1] then
			({
				0,
				0
			})[1] = var_32_1 + iter_32_1._tf.sizeDelta.x
		end

		if var_32_2 > ({
			0,
			0
		})[2] then
			({
				0,
				0
			})[2] = var_32_2 + iter_32_1._tf.sizeDelta.y / 2
		end

		if iter_32_1:IsMain() and iter_32_1:IsUnLock() then
			var_32_0 = iter_32_1
		end
	end

	for iter_32_2, iter_32_3 in ipairs(arg_32_0.nodes) do
		arg_32_0:CreateLinkLine(iter_32_3)
		iter_32_3:UpdateLineStyle()
	end

	arg_32_0:SetScrollRect({
		0,
		0
	})

	if var_32_0 then
		setAnchoredPosition(arg_32_0.pathContains, {
			x = math.max(-var_32_0._tf.localPosition.x, -arg_32_0.pathContains.rect.width * 0.5)
		})
	end

	return
end

function var_0_0.CreateLinkLine(arg_33_0, arg_33_1)
	if arg_33_1:HasChild() then
		arg_33_1.AddLine(arg_33_1, (function(arg_34_0, arg_34_1)
			local var_34_0 = Instantiate(arg_34_0)

			var_34_0.name = arg_34_1

			return var_34_0
		end)(arg_33_0.adapter, "adapter"), GuildViewMissionNode.LINE_RIGHT, arg_33_1)
	end

	if arg_33_1:HasParent() then
		arg_33_1.AddLine(arg_33_1, (function(arg_34_0, arg_34_1)
			local var_34_0 = Instantiate(arg_34_0)

			var_34_0.name = arg_34_1

			return var_34_0
		end)(arg_33_0.adapter, "adapter"), GuildViewMissionNode.LINE_LEFT, arg_33_1)
	end

	for iter_33_0, iter_33_1 in ipairs((arg_33_1:GetChilds())) do
		local var_33_0 = iter_33_1:GetOffset()

		if var_33_0 > 0 then
			arg_33_1:AddLine((function(arg_34_0, arg_34_1)
				local var_34_0 = Instantiate(arg_34_0)

				var_34_0.name = arg_34_1

				return var_34_0
			end)(arg_33_0.line, "line"), GuildViewMissionNode.TOP_LINK, iter_33_1)
			arg_33_1:AddLine((function(arg_34_0, arg_34_1)
				local var_34_0 = Instantiate(arg_34_0)

				var_34_0.name = arg_34_1

				return var_34_0
			end)(arg_33_0.line, "line"), GuildViewMissionNode.TOP_HRZ_LINK, iter_33_1)
		elseif var_33_0 < 0 then
			arg_33_1:AddLine((function(arg_34_0, arg_34_1)
				local var_34_0 = Instantiate(arg_34_0)

				var_34_0.name = arg_34_1

				return var_34_0
			end)(arg_33_0.line, "line"), GuildViewMissionNode.BOTTOM_LINK, iter_33_1)
			arg_33_1:AddLine((function(arg_34_0, arg_34_1)
				local var_34_0 = Instantiate(arg_34_0)

				var_34_0.name = arg_34_1

				return var_34_0
			end)(arg_33_0.line, "line"), GuildViewMissionNode.BOTTOM_HRZ_LINK, iter_33_1)
		elseif var_33_0 == 0 then
			arg_33_1:AddLine((function(arg_34_0, arg_34_1)
				local var_34_0 = Instantiate(arg_34_0)

				var_34_0.name = arg_34_1

				return var_34_0
			end)(arg_33_0.line, "line"), GuildViewMissionNode.CENTER_LINK, iter_33_1)
		end
	end

	return
end

function var_0_0.SetScrollRect(arg_35_0, arg_35_1)
	arg_35_0.pathContains.sizeDelta = Vector2(arg_35_1[1] + 100, arg_35_1[2] * 2 + 100)

	return
end

function var_0_0.ShowDesc(arg_36_0, arg_36_1)
	arg_36_1:Selected(true)
	setActive(arg_36_0.descPanel, true)

	if arg_36_0.pathContains.rect.height / 2 < arg_36_1._tf.localPosition.y + 50 + arg_36_1._tf.rect.height then
		arg_36_0.chcheSizeDelta = arg_36_0.pathContains.sizeDelta
		arg_36_0.pathContains.sizeDelta = Vector2(arg_36_0.chcheSizeDelta.x, arg_36_0.chcheSizeDelta.y + (arg_36_0.pathContains.rect.height / 2 + (arg_36_1._tf.localPosition.y + 50 + arg_36_1._tf.rect.height - arg_36_0.pathContains.rect.height / 2) * 2))

		scrollTo(arg_36_0.missionList, false, 1)
	end

	arg_36_0.descPanel.localPosition = Vector3(arg_36_1._tf.localPosition.x, arg_36_1._tf.localPosition.y + 50, 0)
	arg_36_0.descPanel:GetComponent(typeof(Image)).sprite = not arg_36_1.data:IsBoss() and GetSpriteFromAtlas("GuildMission/" .. arg_36_1.data:GetIcon(), "") or GetSpriteFromAtlas("GuildMission/boss_" .. arg_36_1.data:GetIcon(), "")
	arg_36_0.descPanelTag.sprite = GetSpriteFromAtlas("ui/GuildMissionUI_atlas", "tag" .. arg_36_1.data:GetTag())

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

	onButton(arg_36_0, arg_36_0.descPanel, function()
		if arg_36_1.data:IsBoss() then
			if not var_36_0(arg_36_1) then
				return
			end

			arg_36_0:emit(GuildEventLayer.ON_OPEN_BOSS, arg_36_1.data)
		else
			arg_36_0:emit(GuildEventMediator.REFRESH_MISSION, arg_36_1.data.id, function()
				if not var_36_0(arg_36_1) then
					return
				end

				arg_36_0.contextData.mission = arg_36_1.data

				arg_36_0:emit(GuildEventLayer.ON_OPEN_MISSION, arg_36_1.data)

				return
			end)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.HideDesc(arg_40_0, arg_40_1)
	arg_40_1:Selected(false)

	if arg_40_0.chcheSizeDelta then
		arg_40_0.pathContains.sizeDelta = arg_40_0.chcheSizeDelta
	end

	setActive(arg_40_0.descPanel, false)

	return
end

function var_0_0.OnDestroy(arg_41_0)
	if arg_41_0.timer then
		arg_41_0.timer:Stop()

		arg_41_0.timer = nil
	end

	arg_41_0.timeView:Dispose()

	return
end

return var_0_0

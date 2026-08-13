class = var_0_10000

local var_0_0 = "GuildEventPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "GuildEventPage"
end

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "eventlist/content")
	local var_2_3 = arg_2_0._tf

	arg_2_0.eventList = var_2_0(var_2_2, var_4.Find(var_2_3, "eventlist/content/tpl"))

	local var_2_4 = arg_2_0._tf

	arg_2_0.reportBtn = var_1.Find(var_2_4, "report_btn")

	local var_2_5 = arg_2_0.reportBtn

	arg_2_0.reportTip = var_1.Find(var_2_5, "tip")

	local var_2_6 = arg_2_0.reportBtn
	local var_2_7 = var_1.Find(var_2_6, "tip/Text")
	local var_2_8 = var_1.GetComponent

	typeof = var_4
	Text = var_2_3
	arg_2_0.reportTipTxt = var_2_8(var_2_7, var_4(var_2_3))

	local var_2_9 = arg_2_0._tf

	arg_2_0.formationBtn = var_1.Find(var_2_9, "formation_btn")

	local var_2_10 = arg_2_0._tf

	arg_2_0.missionList = var_1.Find(var_2_10, "missionlist")

	local var_2_11 = arg_2_0._tf

	arg_2_0.pathContains = var_1.Find(var_2_11, "missionlist/path")
	arg_2_0.tpl = arg_2_0:getTpl("tpl", arg_2_0.pathContains)

	local var_2_12 = arg_2_0._tf

	arg_2_0.line = var_1.Find(var_2_12, "resource/line")

	local var_2_13 = arg_2_0._tf

	arg_2_0.lineHead = var_1.Find(var_2_13, "resource/head")

	local var_2_14 = arg_2_0._tf

	arg_2_0.adapter = var_1.Find(var_2_14, "resource/adapter")

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_1.Find(var_2_15, "bg")
	local var_2_17 = var_1.GetComponent

	typeof = var_4
	Image = var_2_3
	arg_2_0.bg = var_2_17(var_2_16, var_4(var_2_3))

	local var_2_18 = arg_2_0._tf

	arg_2_0.titleTF = var_1.Find(var_2_18, "title")

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_1.Find(var_2_19, "title/Text")
	local var_2_21 = var_1.GetComponent

	typeof = var_4
	Text = var_2_3
	arg_2_0.nameTxt = var_2_21(var_2_20, var_4(var_2_3))

	local var_2_22 = arg_2_0._tf

	arg_2_0.descPanel = var_1.Find(var_2_22, "missionlist/path/desc_panel")

	local var_2_23 = arg_2_0.descPanel
	local var_2_24 = var_1.Find(var_2_23, "Image")
	local var_2_25 = var_1.GetComponent

	typeof = var_4
	Image = var_2_3
	arg_2_0.descPanelTag = var_2_25(var_2_24, var_4(var_2_3))
	setText = var_1

	local var_2_26 = arg_2_0._tf
	local var_2_27 = var_3.Find(var_2_26, "title/timer/label")

	i18n = var_4

	var_1(var_2_27, var_4("guild_time_remaining_tip"))

	local var_2_28 = arg_2_0._tf
	local var_2_29 = var_1.Find(var_2_28, "title/timer/Text")
	local var_2_30 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_2_0.endEventTimerTxt = var_2_30(var_2_29, var_4(var_6))
	GuildEventTimerView = var_1
	arg_2_0.timeView = var_1.New()

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.reportBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		GuildEventMediator = var_2_10003

		var_4_1(var_4_0, var_2_10003.ON_OPEN_REPORT)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.formationBtn

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		GuildEventLayer = var_2_10003

		var_5_1(var_5_0, var_2_10003.ON_OPEN_FORMATION)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	return
end

function var_0_1.OnReportUpdated(arg_6_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)

	arg_6_0.reports = var_1.GetReports(var_6_0)

	arg_6_0:UpdateReportBtn()

	return
end

function var_0_1.Show(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	var_0_1.super.Show(arg_7_0)
	arg_7_0:UpdateData(arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:SwitchPage()
	arg_7_0:OnReportUpdated()

	local var_7_0 = arg_7_0._tf

	var_4.SetAsFirstSibling(var_7_0)

	return
end

function var_0_1.UpdateData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.guildVO = arg_8_1
	arg_8_0.player = arg_8_2
	arg_8_0.events = arg_8_3
	_ = var_1_10004
	arg_8_0.activeEvent = var_1_10004.detect(arg_8_0.events, function(arg_9_0)
		return arg_9_0:IsActive()
	end)

	return
end

function var_0_1.SwitchPage(arg_10_0)
	if arg_10_0.contextData.editFleet then
		triggerButton = var_1

		var_1(arg_10_0.formationBtn)
	end

	if not arg_10_0.activeEvent or var_1 and not var_1:IsParticipant() then
		arg_10_0:InitEvents()
	else
		arg_10_0:BuildTree(var_1)
		arg_10_0:InitView()
		arg_10_0:GenTree()
		arg_10_0:InitTree()
		arg_10_0:EnterActiveNode()
		arg_10_0:CheckBossNode()
		arg_10_0:RefreshLatelyNode()
		arg_10_0:AddRefreshTime()

		local var_10_0 = arg_10_0.timeView

		var_1_10003.Flush(var_10_0, arg_10_0.endEventTimerTxt, var_1)
	end

	setActive = var_1_10003

	var_1_10003(arg_10_0.eventList.container, var_2)

	setActive = var_1_10003

	var_1_10003(arg_10_0.missionList, not var_2)

	setActive = var_1_10003

	var_1_10003(arg_10_0.titleTF, not var_2)

	return
end

function var_0_1.UpdateReportBtn(arg_11_0)
	_ = var_1_10001

	local var_11_0 = var_1_10001.select

	_ = var_1_10003

	local var_11_1 = var_11_0(var_1_10003.values(arg_11_0.reports), function(arg_12_0)
		return arg_12_0:CanSubmit()
	end)
	local var_11_2 = arg_11_0.guildVO
	local var_11_3 = var_2.getMemberById(var_11_2, arg_11_0.player.id)
	local var_11_4 = #var_11_1
	local var_11_5 = 0 < var_11_4 and not var_11_3:IsRecruit()

	setActive = var_4

	var_4(arg_11_0.reportTip, var_11_5)

	if var_11_5 then
		arg_11_0.reportTipTxt.text = #var_11_1
	end

	return
end

function var_0_1.InitEvents(arg_13_0)
	local var_13_0 = arg_13_0.bg

	GetSpriteFromAtlas = var_1_10002
	var_13_0.sprite = var_1_10002("commonbg/guild_event_bg", "")
	arg_13_0.displays = {}

	local var_13_1 = {}

	ipairs = var_2

	for iter_13_0, iter_13_1 in var_2(arg_13_0.events) do
		table = var_1_10007

		var_1_10007.insert(arg_13_0.displays, iter_13_1)
	end

	table = var_2

	var_2.insert(arg_13_0.displays, false)

	local var_13_2 = arg_13_0.eventList

	var_2.make(var_13_2, function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			local var_14_0 = arg_13_0.events[arg_14_1 + 1]
			local var_14_1 = arg_13_0

			var_4.UpdateEvent(var_14_1, arg_14_2, var_14_0)

			if var_14_0 then
				var_13_1[var_14_0.id] = arg_14_2
			end
		end

		return
	end)

	local var_13_3 = arg_13_0.eventList

	var_2.align(var_13_3, #arg_13_0.displays)

	if arg_13_0.activeEvent and not arg_13_0.contextData.editFleet then
		triggerButton = var_2

		var_2(var_13_1[arg_13_0.activeEvent.id])
	end

	return
end

local var_0_2 = {
	"easy",
	"normal",
	"hard"
}

function var_0_1.UpdateEvent(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.activeEvent
	local var_15_1

	if not arg_15_2 or not arg_15_2.id then
		var_15_1 = 0
	end

	local var_15_2 = arg_15_1
	local var_15_3 = arg_15_1.GetComponent

	typeof = var_1_10008
	Image = var_1_10010

	local var_15_4 = var_15_3(var_15_2, var_1_10008(var_1_10010))

	GetSpriteFromAtlas = var_1_10006
	var_15_4.sprite = var_1_10006("guildevent/" .. var_15_1, "")

	local var_15_5 = arg_15_1
	local var_15_6 = arg_15_1.Find(var_15_5, "tag")
	local var_15_7

	if arg_15_2 then
		var_15_7 = var_0_2[arg_15_2:getConfig("difficulty")]
		GetSpriteFromAtlas = var_15_5
		var_15_5 = var_15_5("ui/GuildEventUI_atlas", "tag_" .. var_15_7)

		local var_15_8 = var_15_6
		local var_15_9 = var_15_6.GetComponent

		typeof = var_11
		Image = var_1_10013

		local var_15_10 = var_15_9(var_15_8, var_11(var_1_10013))

		var_15_10.sprite = var_15_5

		var_15_10:SetNativeSize()
	end

	setActive = var_15_7

	var_15_7(var_15_6, arg_15_2)

	local var_15_11 = var_15_0 and arg_15_2 and var_15_0.id == arg_15_2.id

	setActive = var_15_5

	var_15_5(arg_15_1:Find("state"), var_15_11)

	setActive = var_15_5

	var_15_5(arg_15_1:Find("consume"), arg_15_2 and not var_15_11)

	setActive = var_15_5

	var_15_5(arg_15_1:Find("timer"), var_15_11)

	local var_15_14

	if var_15_11 then
		local var_15_12 = arg_15_0.timeView

		var_15_5 = var_15_5.Flush

		local var_15_13 = arg_15_1:Find("timer/Text")

		var_15_14 = var_15_14.GetComponent
		typeof = var_1_10013
		Text = var_1_10015

		var_15_5(var_15_12, var_15_14(var_15_13, var_1_10013(var_1_10015)), var_15_0)
	end

	setText = var_15_5

	local var_15_15 = arg_15_1:Find("timer/label")

	if var_15_11 then
		i18n = var_15_14

		local var_15_16

		if not var_15_14("guild_time_remaining_tip") then
			var_15_16 = ""
		end

		var_15_5(var_15_15, var_15_16)

		if not arg_15_2 then
			removeOnButton = var_15_5

			var_15_5(arg_15_1)

			return
		end

		setText = var_15_5

		local var_15_17 = arg_15_1:Find("consume/label")

		i18n = var_15_16

		var_15_5(var_15_17, var_15_16("guild_word_consume_for_battle"))

		setText = var_15_5

		var_15_5(arg_15_1:Find("consume/Text"), arg_15_2:GetConsume())

		local var_15_18 = arg_15_2
		local var_15_20

		if not arg_15_2.IsUnlock(var_15_18, arg_15_0.guildVO.level) then
			local var_15_19 = arg_15_1:Find("mask")

			var_15_20 = var_15_20.GetComponent
			typeof = var_11
			Image = var_1_10013
			var_15_20 = var_15_20(var_15_19, var_11(var_1_10013))
			GetSpriteFromAtlas = var_15_18
			var_15_20.sprite = var_15_18("guildevent/" .. "0_0", "")
		end

		setActive = var_15_20

		var_15_20(arg_15_1:Find("mask"), not var_7)

		onButton = var_15_20

		local var_15_21 = arg_15_0
		local var_15_22 = arg_15_1

		local function var_15_23()
			if not arg_15_2 then
				return
			end

			local var_16_0 = arg_15_2

			if not var_0.IsUnlock(var_16_0, arg_15_0.guildVO.level) then
				pg = var_0

				local var_16_1 = var_0.TipsMgr.GetInstance()
				local var_16_2 = var_0.ShowTips

				i18n = var_3

				var_16_2(var_16_1, var_3("guild_level_no_enough"))

				return
			end

			if var_15_0 and var_15_0.id ~= arg_15_2.id then
				pg = var_0

				local var_16_3 = var_0.TipsMgr.GetInstance()
				local var_16_4 = var_0.ShowTips

				i18n = var_3

				local var_16_5 = "guild_open_event_info_when_exist_active"
				local var_16_6 = var_15_0

				var_16_4(var_16_3, var_3(var_16_5, var_6.getConfig(var_16_6, "name")))

				return
			end

			local var_16_7 = arg_15_0
			local var_16_8 = var_0.emit

			GuildEventLayer = var_3

			var_16_8(var_16_7, var_3.OPEN_EVENT_INFO, arg_15_2)

			return
		end

		SFX_PANEL = var_13

		var_15_20(var_15_21, var_15_22, var_15_23, var_13)

		return
	end
end

function var_0_1.OnRefreshNode(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0.nodes then
		return
	end

	arg_17_0:BuildTree(arg_17_1)

	ipairs = var_3

	for iter_17_0, iter_17_1 in var_3(arg_17_0.nodes) do
		if iter_17_1.data.id ~= arg_17_2.id then
			local var_17_0 = iter_17_1.data

			if var_8.IsBoss(var_17_0) and arg_17_2:IsBoss() then
				iter_17_1:UpdateData(arg_17_2)
			end
		end
	end

	if not arg_17_2:IsBoss() then
		arg_17_0:CheckBossNode()
	end

	return
end

function var_0_1.EnterActiveNode(arg_18_0)
	if arg_18_0.contextData.mission then
		local var_18_0 = arg_18_0
		local var_18_1 = arg_18_0.emit

		GuildEventLayer = var_1_10004

		var_18_1(var_18_0, var_1_10004.ON_OPEN_MISSION, arg_18_0.contextData.mission)
	end

	return
end

function var_0_1.CheckBossNode(arg_19_0)
	local var_19_0 = arg_19_0.nodes[#arg_19_0.nodes]

	if var_1.ParentIsFinishByServer(var_19_0) and not var_1:IsActive() then
		local var_19_1 = arg_19_0
		local var_19_2 = arg_19_0.emit

		GuildEventMediator = var_1_10005

		var_19_2(var_19_1, var_1_10005.ON_GET_BOSS_INFO)
	elseif var_1:ParentIFinish() and not var_1:IsActive() then
		local var_19_3 = arg_19_0
		local var_19_4 = arg_19_0.emit

		GuildEventMediator = var_1_10005

		var_19_4(var_19_3, var_1_10005.REFRESH_MISSION, var_1:GetParentId())
	end

	return
end

function var_0_1.InitView(arg_20_0)
	local var_20_0 = arg_20_0.bg

	GetSpriteFromAtlas = var_1_10002

	local var_20_1 = "GuildMission/"
	local var_20_2 = arg_20_0.gevent

	var_20_0.sprite = var_1_10002(var_20_1 .. var_5.GetTheme(var_20_2), "")

	local var_20_3 = arg_20_0.nameTxt
	local var_20_4 = arg_20_0.gevent

	var_20_3.text = var_2.GetName(var_20_4)

	return
end

function var_0_1.BuildTree(arg_21_0, arg_21_1)
	arg_21_0.gevent = arg_21_1
	arg_21_0.missions = {}

	local var_21_0 = arg_21_0.gevent
	local var_21_1 = var_2.GetMissions(var_21_0)
	local var_21_2 = arg_21_0.gevent
	local var_21_3 = var_3.GetBossMission(var_21_2)

	arg_21_0.bossPosition = var_3.GetPosition(var_21_3)
	arg_21_0.lastPosition = -1
	pairs = var_4

	for iter_21_0, iter_21_1 in var_4(var_21_1) do
		local var_21_4 = arg_21_0.missions

		var_21_4[iter_21_0] = iter_21_1
		_ = var_21_4

		if var_21_4.any(iter_21_1, function(arg_22_0)
			local var_22_0

			if arg_22_0:IsMain() then
				var_22_0 = arg_22_0:IsFinish()
			end

			return var_22_0
		end) then
			arg_21_0.lastPosition = iter_21_0
		end
	end

	arg_21_0.lastPosition = arg_21_0.lastPosition + 1
	arg_21_0.missions[arg_21_0.bossPosition] = {
		var_3
	}

	return
end

function var_0_1.RefreshLatelyNode(arg_23_0)
	if arg_23_0.lastPosition <= 0 or arg_23_0.lastPosition == arg_23_0.bossPosition then
		return
	end

	local var_23_0 = arg_23_0.lastPosition
	local var_23_1 = arg_23_0.gevent
	local var_23_2 = var_2.GetMissions(var_23_1)
	local var_23_3 = {}
	local var_23_4

	if not var_23_2[var_23_0] then
		var_23_4 = {}
	end

	ipairs = var_1_10005

	for iter_23_0, iter_23_1 in var_1_10005(var_23_4) do
		if not iter_23_1:IsBoss() then
			table = var_10

			var_10.insert(var_23_3, function(arg_24_0)
				local var_24_0 = arg_23_0
				local var_24_1 = var_1.emit

				GuildEventMediator = var_2_10004

				var_24_1(var_24_0, var_2_10004.REFRESH_MISSION, iter_23_1.id, arg_24_0)

				return
			end)
		end
	end

	seriesAsync = var_5

	var_5(var_23_3, function()
		if var_23_0 ~= arg_23_0.lastPosition then
			local var_25_0 = arg_23_0

			var_0.RefreshLatelyNode(var_25_0)
		end

		return
	end)

	return
end

function var_0_1.AddRefreshTime(arg_26_0)
	if arg_26_0.timer then
		local var_26_0 = arg_26_0.timer

		var_1.Stop(var_26_0)

		arg_26_0.timer = nil
	end

	Timer = var_1

	local var_26_1 = var_1.New

	local function var_26_2()
		local var_27_0 = arg_26_0

		var_0.RefreshLatelyNode(var_27_0)

		local var_27_1 = arg_26_0

		var_0.AddRefreshTime(var_27_1)

		return
	end

	GuildConst = var_1_10004
	arg_26_0.timer = var_26_1(var_26_2, var_1_10004.FORCE_REFRESH_MISSION_TREE_TIME, 1)

	local var_26_3 = arg_26_0.timer

	var_1.Start(var_26_3)

	return
end

function var_0_1.GenTree(arg_28_0)
	arg_28_0.nodes = {}
	pairs = var_1

	for iter_28_0, iter_28_1 in var_1(arg_28_0.missions) do
		table = var_1_10006

		var_1_10006.sort(iter_28_1, function(arg_29_0, arg_29_1)
			return arg_29_0:GetSubType() > arg_29_1:GetSubType()
		end)

		ipairs = var_1_10006

		for iter_28_2, iter_28_3 in var_1_10006(iter_28_1) do
			cloneTplTo = var_1_10011
			var_1_10011 = var_1_10011(arg_28_0.tpl, arg_28_0.pathContains, iter_28_0 .. "-" .. iter_28_2)

			local var_28_0 = arg_28_0:CreateNode(var_1_10011, iter_28_0, iter_28_3)

			table = var_13

			var_13.insert(arg_28_0.nodes, var_28_0)
		end
	end

	return
end

function var_0_1.CreateNode(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	GuildViewMissionNode = var_1_10004

	local var_30_0 = var_1_10004.New({
		go = arg_30_1.gameObject,
		slot = arg_30_2,
		data = arg_30_3,
		parent = arg_30_0.last
	})

	if arg_30_0.last then
		local var_30_1 = arg_30_0.last

		var_5.AddChild(var_30_1, var_30_0)
	end

	if var_30_0:IsMain() then
		arg_30_0.last = var_30_0
	end

	onButton = var_5

	local var_30_2 = arg_30_0
	local var_30_3 = arg_30_1

	local function var_30_4()
		if arg_30_0.prevSelected == var_30_0 then
			return
		end

		local var_31_0 = var_30_0

		if not var_0.IsUnLock(var_31_0) then
			pg = var_0

			local var_31_1 = var_0.TipsMgr.GetInstance()
			local var_31_2 = var_0.ShowTips

			i18n = var_2_10003

			var_31_2(var_31_1, var_2_10003("guild_event_is_lock"))

			return
		end

		local var_31_3 = var_30_0

		if var_0.IsFinish(var_31_3) then
			pg = var_0

			local var_31_4 = var_0.TipsMgr.GetInstance()
			local var_31_5 = var_0.ShowTips

			i18n = var_2_10003

			var_31_5(var_31_4, var_2_10003("guild_event_is_finish"))

			return
		end

		if arg_30_0.prevSelected then
			local var_31_6 = arg_30_0

			var_0.HideDesc(var_31_6, arg_30_0.prevSelected)
		end

		local var_31_7 = arg_30_0

		var_0.ShowDesc(var_31_7, var_30_0)

		arg_30_0.prevSelected = var_30_0

		return
	end

	SFX_PANEL = var_1_10010

	var_5(var_30_2, var_30_3, var_30_4, var_1_10010)

	return var_30_0
end

function var_0_1.InitTree(arg_32_0)
	local var_32_0 = {
		0,
		0
	}
	local var_32_1

	ipairs = var_1_10003

	for iter_32_0, iter_32_1 in var_1_10003(arg_32_0.nodes) do
		local var_32_2 = iter_32_1

		iter_32_1.Init(var_32_2)

		local var_32_3 = iter_32_1._tf.anchoredPosition

		math = var_1_10009
		var_1_10009 = var_1_10009.abs(var_32_3.x)
		math = var_32_2

		local var_32_4 = var_32_2.abs(var_32_3.y)

		if var_1_10009 > var_32_0[1] then
			var_32_0[1] = var_1_10009 + iter_32_1._tf.sizeDelta.x
		end

		if var_32_4 > var_32_0[2] then
			var_32_0[2] = var_32_4 + iter_32_1._tf.sizeDelta.y / 2
		end

		if iter_32_1:IsMain() and iter_32_1:IsUnLock() then
			var_32_1 = iter_32_1
		end
	end

	ipairs = var_3

	for iter_32_2, iter_32_3 in var_3(arg_32_0.nodes) do
		arg_32_0:CreateLinkLine(iter_32_3)
		iter_32_3:UpdateLineStyle()
	end

	arg_32_0:SetScrollRect(var_32_0)

	if var_32_1 then
		local var_32_5 = -var_32_1._tf.localPosition.x

		math = var_4

		local var_32_6 = var_4.max(var_32_5, -arg_32_0.pathContains.rect.width * 0.5)

		setAnchoredPosition = var_4

		var_4(arg_32_0.pathContains, {
			x = var_32_6
		})
	end

	return
end

function var_0_1.CreateLinkLine(arg_33_0, arg_33_1)
	local function var_33_0(arg_34_0, arg_34_1)
		Instantiate = var_2_10002

		local var_34_0 = var_2_10002(arg_34_0)

		var_34_0.name = arg_34_1

		return var_34_0
	end

	if arg_33_1:HasChild() then
		local var_33_1 = arg_33_1
		local var_33_2 = arg_33_1.AddLine
		local var_33_3 = var_33_0(arg_33_0.adapter, "adapter")

		GuildViewMissionNode = var_1_10007

		var_33_2(var_33_1, var_33_3, var_1_10007.LINE_RIGHT, arg_33_1)
	end

	if arg_33_1:HasParent() then
		local var_33_4 = arg_33_1
		local var_33_5 = arg_33_1.AddLine
		local var_33_6 = var_33_0(arg_33_0.adapter, "adapter")

		GuildViewMissionNode = var_1_10007

		var_33_5(var_33_4, var_33_6, var_1_10007.LINE_LEFT, arg_33_1)
	end

	local var_33_7 = arg_33_1:GetChilds()

	ipairs = var_1_10004

	for iter_33_0, iter_33_1 in var_1_10004(var_33_7) do
		if iter_33_1:GetOffset() > 0 then
			local var_33_8 = arg_33_1
			local var_33_9 = arg_33_1.AddLine
			local var_33_10 = var_33_0(arg_33_0.line, "line")

			GuildViewMissionNode = var_1_10014

			var_33_9(var_33_8, var_33_10, var_1_10014.TOP_LINK, iter_33_1)

			local var_33_11 = arg_33_1
			local var_33_12 = arg_33_1.AddLine
			local var_33_13 = var_33_0(arg_33_0.line, "line")

			GuildViewMissionNode = var_1_10014

			var_33_12(var_33_11, var_33_13, var_1_10014.TOP_HRZ_LINK, iter_33_1)
		elseif var_9 < 0 then
			local var_33_14 = arg_33_1
			local var_33_15 = arg_33_1.AddLine
			local var_33_16 = var_33_0(arg_33_0.line, "line")

			GuildViewMissionNode = var_1_10014

			var_33_15(var_33_14, var_33_16, var_1_10014.BOTTOM_LINK, iter_33_1)

			local var_33_17 = arg_33_1
			local var_33_18 = arg_33_1.AddLine
			local var_33_19 = var_33_0(arg_33_0.line, "line")

			GuildViewMissionNode = var_1_10014

			var_33_18(var_33_17, var_33_19, var_1_10014.BOTTOM_HRZ_LINK, iter_33_1)
		elseif var_9 == 0 then
			local var_33_20 = arg_33_1
			local var_33_21 = arg_33_1.AddLine
			local var_33_22 = var_33_0(arg_33_0.line, "line")

			GuildViewMissionNode = var_1_10014

			var_33_21(var_33_20, var_33_22, var_1_10014.CENTER_LINK, iter_33_1)
		end
	end

	return
end

function var_0_1.SetScrollRect(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_1[1] + 100
	local var_35_1 = arg_35_1[2] * 2 + 100
	local var_35_2 = arg_35_0.pathContains

	Vector2 = var_1_10005
	var_35_2.sizeDelta = var_1_10005(var_35_0, var_35_1)

	return
end

function var_0_1.ShowDesc(arg_36_0, arg_36_1)
	arg_36_1:Selected(true)

	setActive = var_2

	var_2(arg_36_0.descPanel, true)

	local var_36_0 = arg_36_1._tf.localPosition.y + 50 + arg_36_1._tf.rect.height

	if arg_36_0.pathContains.rect.height / 2 < var_36_0 then
		local var_36_1 = var_4 + (var_36_0 - var_4) * 2

		arg_36_0.chcheSizeDelta = arg_36_0.pathContains.sizeDelta
		var_1_10006 = arg_36_0.pathContains
		Vector2 = var_1_10007
		var_1_10006.sizeDelta = var_1_10007(arg_36_0.chcheSizeDelta.x, arg_36_0.chcheSizeDelta.y + var_36_1)
		scrollTo = var_1_10006

		var_1_10006(arg_36_0.missionList, false, 1)
	end

	local var_36_2 = arg_36_0.descPanel

	Vector3 = var_1_10006
	var_36_2.localPosition = var_1_10006(var_2.x, var_2.y + 50, 0)

	local var_36_3 = arg_36_1.data
	local var_36_7

	if not var_5.IsBoss(var_36_3) then
		local var_36_4 = arg_36_0.descPanel
		local var_36_5 = var_5.GetComponent

		typeof = var_36_7
		Image = var_10

		local var_36_6 = var_36_5(var_36_4, var_36_7(var_10))

		GetSpriteFromAtlas = var_6
		var_36_7 = "GuildMission/"

		local var_36_8 = arg_36_1.data

		var_36_6.sprite = var_6(var_36_7 .. var_9.GetIcon(var_36_8), "")
	else
		local var_36_9 = arg_36_0.descPanel
		local var_36_10 = var_5.GetComponent

		typeof = var_36_7
		Image = var_10

		local var_36_11 = var_36_10(var_36_9, var_36_7(var_10))

		GetSpriteFromAtlas = var_6

		local var_36_12 = "GuildMission/boss_"
		local var_36_13 = arg_36_1.data

		var_36_11.sprite = var_6(var_36_12 .. var_9.GetIcon(var_36_13), "")
	end

	local var_36_14 = arg_36_1.data
	local var_36_15 = var_5.GetTag(var_36_14)
	local var_36_16 = arg_36_0.descPanelTag

	GetSpriteFromAtlas = var_36_14
	var_36_16.sprite = var_36_14("ui/GuildMissionUI_atlas", "tag" .. var_36_15)

	local function var_36_17(arg_37_0)
		if not arg_37_0:IsUnLock() then
			pg = var_1

			local var_37_0 = var_1.TipsMgr.GetInstance()
			local var_37_1 = var_1.ShowTips

			i18n = var_2_10004

			var_37_1(var_37_0, var_2_10004("guild_event_is_lock"))

			return false
		end

		if arg_37_0:IsFinish() then
			pg = var_1

			local var_37_2 = var_1.TipsMgr.GetInstance()
			local var_37_3 = var_1.ShowTips

			i18n = var_2_10004

			var_37_3(var_37_2, var_2_10004("guild_event_is_finish"))

			return false
		end

		return true
	end

	onButton = var_7

	local var_36_18 = arg_36_0
	local var_36_19 = arg_36_0.descPanel

	local function var_36_20()
		local var_38_0 = arg_36_1.data

		if var_0.IsBoss(var_38_0) then
			if not var_36_17(arg_36_1) then
				return
			end

			local var_38_1 = arg_36_0
			local var_38_2 = var_0.emit

			GuildEventLayer = var_2_10003

			var_38_2(var_38_1, var_2_10003.ON_OPEN_BOSS, arg_36_1.data)
		else
			local var_38_3 = arg_36_0
			local var_38_4 = var_0.emit

			GuildEventMediator = var_2_10003

			var_38_4(var_38_3, var_2_10003.REFRESH_MISSION, arg_36_1.data.id, function()
				if not var_36_17(arg_36_1) then
					return
				end

				arg_36_0.contextData.mission = arg_36_1.data

				local var_39_0 = arg_36_0
				local var_39_1 = var_0.emit

				GuildEventLayer = var_3_10003

				var_39_1(var_39_0, var_3_10003.ON_OPEN_MISSION, arg_36_1.data)

				return
			end)
		end

		return
	end

	SFX_PANEL = var_1_10012

	var_7(var_36_18, var_36_19, var_36_20, var_1_10012)

	return
end

function var_0_1.HideDesc(arg_40_0, arg_40_1)
	arg_40_1:Selected(false)

	local var_40_0

	if arg_40_0.chcheSizeDelta then
		var_40_0 = arg_40_0.pathContains
		var_40_0.sizeDelta = arg_40_0.chcheSizeDelta
	end

	setActive = var_40_0

	var_40_0(arg_40_0.descPanel, false)

	return
end

function var_0_1.OnDestroy(arg_41_0)
	if arg_41_0.timer then
		local var_41_0 = arg_41_0.timer

		var_1.Stop(var_41_0)

		arg_41_0.timer = nil
	end

	local var_41_1 = arg_41_0.timeView

	var_1.Dispose(var_41_1)

	return
end

return var_0_1

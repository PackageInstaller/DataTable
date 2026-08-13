class = var_0_10000

local var_0_0 = "GuildMissionBossPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "GuildMissionBossPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.hp = var_1.Find(var_2_0, "hp/bar")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "hp/bar/Text")
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.hpProgress = var_2_3(var_2_2, var_3(var_1_10004))
	arg_2_0.hpL = arg_2_0.hp.rect.width

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "title")
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.titleTxt = var_2_6(var_2_5, var_3(var_1_10004))

	local var_2_7 = arg_2_0.rtAdapt

	arg_2_0.assaultBtn = var_1.Find(var_2_7, "btn_a_formation")

	local var_2_8 = arg_2_0.rtAdapt

	arg_2_0.battleBtn = var_1.Find(var_2_8, "btn_go")

	local var_2_9 = arg_2_0.rtAdapt

	arg_2_0.reportBtn = var_1.Find(var_2_9, "btn_report")

	local var_2_10 = arg_2_0.rtAdapt

	arg_2_0.reportTip = var_1.Find(var_2_10, "btn_report/tip")

	local var_2_11 = arg_2_0.rtAdapt
	local var_2_12 = var_1.Find(var_2_11, "btn_report/tip/Text")
	local var_2_13 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.reportTipTxt = var_2_13(var_2_12, var_3(var_1_10004))

	local var_2_14 = arg_2_0.rtAdapt
	local var_2_15 = var_1.Find(var_2_14, "btn_go/cnt/Text")
	local var_2_16 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.cntTxt = var_2_16(var_2_15, var_3(var_1_10004))
	UIItemList = var_1

	local var_2_17 = var_1.New
	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_2.Find(var_2_18, "rank/content")
	local var_2_20 = arg_2_0._tf

	arg_2_0.rankList = var_2_17(var_2_19, var_3.Find(var_2_20, "rank/content/tpl"))

	local var_2_21 = arg_2_0._tf

	arg_2_0.paintingTF = var_1.Find(var_2_21, "painting")

	local var_2_22 = arg_2_0._tf

	arg_2_0.prefabTF = var_1.Find(var_2_22, "prefab")

	local var_2_23 = arg_2_0._tf

	arg_2_0.viewAllBtn = var_1.Find(var_2_23, "rank/view_all")
	GuildBossRankPage = var_1
	arg_2_0.allRankPage = var_1.New(arg_2_0._parentTf, arg_2_0.event)
	setActive = var_1

	local var_2_24 = arg_2_0.viewAllBtn

	PLATFORM_CODE = var_3
	PLATFORM_JP = var_2_20

	var_1(var_2_24, var_3 ~= var_2_20)

	local var_2_25 = arg_2_0._tf
	local var_2_26 = var_1.Find(var_2_25, "timer/Text")
	local var_2_27 = var_1.GetComponent

	typeof = var_3
	Text = var_2_20
	arg_2_0.eventTimerTxt = var_2_27(var_2_26, var_3(var_2_20))
	setText = var_1

	local var_2_28 = arg_2_0._tf
	local var_2_29 = var_2.Find(var_2_28, "timer/label")

	i18n = var_2_28

	var_1(var_2_29, var_2_28("guild_time_remaining_tip"))

	GuildEventTimerView = var_1
	arg_2_0.timeView = var_1.New()

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.assaultBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		GuildEventLayer = var_2_10002

		var_4_1(var_4_0, var_2_10002.OPEN_BOSS_ASSULT)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.battleBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		if not var_0.ExistActiveEvent(var_5_0) then
			pg = var_0

			local var_5_1 = var_0.TipsMgr.GetInstance()
			local var_5_2 = var_0.ShowTips

			i18n = var_2_10002

			var_5_2(var_5_1, var_2_10002("guild_battle_is_end"))

			return
		end

		local var_5_3 = arg_3_0.bossMission

		if var_0.IsReachDailyCnt(var_5_3) then
			pg = var_0

			local var_5_4 = var_0.TipsMgr.GetInstance()
			local var_5_5 = var_0.ShowTips

			i18n = var_2_10002

			var_5_5(var_5_4, var_2_10002("guild_boss_cnt_no_enough"))

			return
		end

		local var_5_6 = arg_3_0.bossMission

		if var_0.IsDeath(var_5_6) then
			pg = var_0

			local var_5_7 = var_0.TipsMgr.GetInstance()
			local var_5_8 = var_0.ShowTips

			i18n = var_2_10002

			var_5_8(var_5_7, var_2_10002("guild_battle_is_end"))

			return
		end

		local var_5_9 = arg_3_0
		local var_5_10 = var_0.emit

		GuildEventLayer = var_2_10002

		var_5_10(var_5_9, var_2_10002.ON_OPEN_BOSS_FORMATION, arg_3_0.bossMission)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.reportBtn

	local function var_3_8()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		GuildEventMediator = var_2_10002

		var_6_1(var_6_0, var_2_10002.ON_OPEN_REPORT)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	return
end

function var_0_1.UpdateMission(arg_7_0, arg_7_1)
	arg_7_0.bossMission = arg_7_1

	return
end

function var_0_1.OnReportUpdated(arg_8_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10002

	local var_8_0 = var_1_10001(var_1_10002)
	local var_8_1 = var_1.GetReports(var_8_0)

	_ = var_8_0

	local var_8_2 = var_8_0.select

	_ = var_1_10003

	local var_8_3 = var_8_2(var_1_10003.values(var_8_1), function(arg_9_0)
		return arg_9_0:CanSubmit()
	end)

	setActive = var_3

	var_3(arg_8_0.reportTip, #var_8_3 > 0)

	if #var_8_3 > 0 then
		arg_8_0.reportTipTxt.text = #var_8_3
	end

	return
end

function var_0_1.Show(arg_10_0, arg_10_1)
	arg_10_0:UpdateMission(arg_10_1)
	arg_10_0:InitRanks()
	arg_10_0:UpdateView()
	arg_10_0:UpdatePainting()

	if arg_10_0.contextData.editBossFleet then
		triggerButton = var_2

		var_2(arg_10_0.battleBtn)
	end

	local var_10_0 = arg_10_1
	local var_10_1 = arg_10_1.IsReachDailyCnt(var_10_0)

	setActive = var_10_0

	local var_10_2 = arg_10_0.battleBtn

	var_10_0(var_4.Find(var_10_2, "selected"), var_10_1)
	arg_10_0:OnReportUpdated()

	arg_10_0.titleTxt.text = arg_10_1:getConfig("name")

	arg_10_0:CheckFleetShipState()

	local var_10_3 = arg_10_0.timeView
	local var_10_4 = var_3.Flush
	local var_10_5 = arg_10_0.eventTimerTxt

	getProxy = var_6
	GuildProxy = var_1_10007

	local var_10_6 = var_6(var_1_10007)
	local var_10_7 = var_6.getRawData(var_10_6)

	var_10_4(var_10_3, var_10_5, var_6.GetActiveEvent(var_10_7))

	return
end

function var_0_1.CheckFleetShipState(arg_11_0)
	local var_11_0 = arg_11_0.bossMission
	local var_11_1 = {
		(var_11_0:GetMainFleet())
	}
	local var_11_2 = var_11_0

	var_11_1[2] = var_11_0.GetSubFleet(var_11_2)

	local var_11_3 = {}

	ipairs = var_11_2

	for iter_11_0, iter_11_1 in var_11_2(var_11_1) do
		if iter_11_1:ExistInvailShips() or iter_11_1:ExistInvalidCommanders() then
			table = var_9

			var_9.insert(var_11_3, iter_11_1)
		end
	end

	if #var_11_3 > 0 then
		pg = var_4

		local var_11_4 = var_4.MsgboxMgr.GetInstance()
		local var_11_5 = var_4.ShowMsgBox
		local var_11_6 = {
			hideNo = true
		}

		i18n = iter_11_0
		var_11_6.content = iter_11_0("guild_boss_formation_exist_invaild_ship")

		var_11_5(var_11_4, var_11_6)

		local var_11_7 = arg_11_0.contextData

		var_11_7.editBossFleet = {}
		ipairs = var_11_7

		for iter_11_2, iter_11_3 in var_11_7(var_11_3) do
			arg_11_0.contextData.editBossFleet[iter_11_3.id] = iter_11_3
		end

		local var_11_8 = arg_11_0
		local var_11_9 = arg_11_0.emit

		GuildEventMediator = var_6

		var_11_9(var_11_8, var_6.ON_CLEAR_BOSS_FLEET_INVAILD_SHIP)
	end

	return
end

function var_0_1.UpdateView(arg_12_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10002

	local var_12_0 = var_1_10001(var_1_10002)

	if var_1.ShouldRefreshBoss(var_12_0) then
		local var_12_1 = arg_12_0
		local var_12_2 = arg_12_0.emit

		GuildEventMediator = var_1_10003

		var_12_2(var_12_1, var_1_10003.ON_GET_BOSS_INFO)
	else
		arg_12_0:UpdateBossInfo()
		arg_12_0:AddBossTimer()
		var_0_1.super.Show(arg_12_0)
	end

	return
end

function var_0_1.UpdatePainting(arg_13_0)
	local var_13_0 = arg_13_0.bossMission
	local var_13_1

	var_13_1 = var_1.GetPainting(var_13_0) and var_2 ~= ""

	if var_13_1 then
		setGuildPaintingPrefab = var_1_10004

		var_1_10004(arg_13_0.paintingTF, var_2, "chuanwu", nil)
	else
		local var_13_2 = var_1

		var_1_10004 = var_1.GetEmenyId(var_13_2)
		LoadSpriteAsync = var_13_2

		var_13_2("guildboss/" .. var_1_10004, function(arg_14_0)
			local var_14_0 = arg_13_0
			local var_14_1 = var_1.CheckState

			BaseSubView = var_2_10003

			if var_14_1(var_14_0, var_2_10003.STATES.DESTROY) then
				return
			end

			if arg_14_0 then
				GetOrAddComponent = var_1

				local var_14_2 = arg_13_0.prefabTF
				local var_14_3 = var_1(var_2.Find(var_14_2, "frame/model"), "Image")

				var_14_3.sprite = arg_14_0

				var_14_3:SetNativeSize()
			end

			return
		end)

		local var_13_3 = arg_13_0.prefabTF
		local var_13_4 = var_5.Find(var_13_3, "name/Image")
		local var_13_5 = var_5.GetComponent

		typeof = var_7
		Image = var_1_10008

		local var_13_6 = var_13_5(var_13_4, var_7(var_1_10008))

		GetSpriteFromAtlas = var_13_4
		var_13_6.sprite = var_13_4("guildboss/name_" .. var_1_10004, "")

		var_13_6:SetNativeSize()
	end

	setActive = var_1_10004

	var_1_10004(arg_13_0.paintingTF, var_13_1)

	setActive = var_1_10004

	var_1_10004(arg_13_0.prefabTF, not var_13_1)

	return
end

function var_0_1.UpdateBossInfo(arg_15_0)
	local var_15_0 = arg_15_0.bossMission
	local var_15_1 = var_1.GetHp(var_15_0)
	local var_15_2 = var_1
	local var_15_3 = var_1.GetTotalHp(var_15_2)

	math = var_15_2

	local var_15_4 = var_15_1 / var_15_2.max(var_15_3, 1)
	local var_15_5 = arg_15_0.hpL * var_15_4

	tf = var_6

	local var_15_6 = var_6(arg_15_0.hp)

	Vector2 = var_7
	var_15_6.sizeDelta = var_7(var_15_5, var_15_6.sizeDelta.y)

	local var_15_7 = var_15_4 * 100
	local var_15_8 = arg_15_0.hpProgress

	math = var_8
	var_15_8.text = var_8.max(var_15_7 - var_15_7 % 0.1, 1) .. "%"

	local var_15_9 = var_1:GetCanUsageCnt()

	if 0 < var_15_9 then
		COLOR_GREEN = var_8

		if not var_8 then
			COLOR_RED = var_8
		end

		local var_15_10 = arg_15_0.cntTxt
		local var_15_11 = "<color="
		local var_15_12 = var_8
		local var_15_13 = ">"
		local var_15_14 = var_15_9
		local var_15_15 = "</color>/"

		GuildConst = var_1_10015
		var_15_10.text = var_15_11 .. var_15_12 .. var_15_13 .. var_15_14 .. var_15_15 .. var_1_10015.MISSION_BOSS_MAX_CNT()

		return
	end
end

function var_0_1.InitRanks(arg_16_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10002

	local var_16_0 = var_1_10001(var_1_10002)

	if var_1.ShouldRefreshBossRank(var_16_0) then
		local var_16_1 = arg_16_0
		local var_16_2 = arg_16_0.emit

		GuildEventMediator = var_1_10003

		var_16_2(var_16_1, var_1_10003.ON_REFRESH_BOSS_RANK)
	else
		arg_16_0:UpdateRank()
		arg_16_0:AddRankTimer()
	end

	return
end

function var_0_1.UpdateRank(arg_17_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10002

	local var_17_0 = var_1_10001(var_1_10002)
	local var_17_1 = var_1.GetBossRank(var_17_0)

	table = var_17_0

	var_17_0.sort(var_17_1, function(arg_18_0, arg_18_1)
		return arg_18_0.damage > arg_18_1.damage
	end)

	local var_17_2 = arg_17_0.rankList

	var_2.make(var_17_2, function(arg_19_0, arg_19_1, arg_19_2)
		UIItemList = var_2_10003

		if arg_19_0 == var_2_10003.EventUpdate then
			local var_19_0 = var_17_1[arg_19_1 + 1]

			setText = var_4

			var_4(arg_19_2:Find("no"), arg_19_1 + 1)

			setText = var_4

			var_4(arg_19_2:Find("name"), var_19_0.name)

			setText = var_4

			var_4(arg_19_2:Find("Text"), var_19_0.damage)
		end

		return
	end)

	local var_17_3 = arg_17_0.rankList
	local var_17_4 = var_2.align

	math = var_4

	var_17_4(var_17_3, var_4.min(3, #var_17_1))

	onButton = var_17_4

	local var_17_5 = arg_17_0
	local var_17_6 = arg_17_0.viewAllBtn

	local function var_17_7()
		local var_20_0 = arg_17_0.allRankPage

		var_0.ExecuteAction(var_20_0, "Show", var_17_1)

		return
	end

	SFX_PANEL = var_6

	var_17_4(var_17_5, var_17_6, var_17_7, var_6)

	return
end

function var_0_1.ExistActiveEvent(arg_21_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10002

	local var_21_0 = var_1_10001(var_1_10002)
	local var_21_1 = var_1.getRawData(var_21_0)
	local var_21_2

	var_21_2 = var_1.GetActiveEvent(var_21_1) and not var_1:IsExpired()

	return var_21_2
end

function var_0_1.AddRankTimer(arg_22_0)
	local var_22_0 = arg_22_0

	if not arg_22_0.ExistActiveEvent(var_22_0) then
		return
	end

	if arg_22_0.rankTimer then
		var_22_0 = arg_22_0.rankTimer

		var_1.Stop(var_22_0)

		arg_22_0.rankTimer = nil
	end

	local var_22_1 = arg_22_0.bossMission

	Timer = var_22_0

	local var_22_2 = var_22_0.New

	local function var_22_3()
		local var_23_0 = arg_22_0
		local var_23_1 = var_0.emit

		GuildEventMediator = var_2_10002

		var_23_1(var_23_0, var_2_10002.ON_REFRESH_BOSS_RANK)

		return
	end

	GuildConst = var_1_10004
	arg_22_0.rankTimer = var_22_2(var_22_3, var_1_10004.FORCE_REFRESH_MISSION_BOSS_RANK_TIME, 1)

	local var_22_4 = arg_22_0.rankTimer

	var_2.Start(var_22_4)

	return
end

function var_0_1.AddBossTimer(arg_24_0)
	if not arg_24_0:ExistActiveEvent() then
		return
	end

	if arg_24_0.bossTimer then
		local var_24_0 = arg_24_0.bossTimer

		var_1.Stop(var_24_0)

		arg_24_0.bossTimer = nil
	end

	Timer = var_1

	local var_24_1 = var_1.New

	local function var_24_2()
		local var_25_0 = arg_24_0
		local var_25_1 = var_0.emit

		GuildEventMediator = var_2_10002

		var_25_1(var_25_0, var_2_10002.ON_GET_BOSS_INFO)

		return
	end

	GuildConst = var_1_10003
	arg_24_0.bossTimer = var_24_1(var_24_2, var_1_10003.FORCE_REFRESH_BOSS_TIME, 1)

	local var_24_3 = arg_24_0.bossTimer

	var_1.Start(var_24_3)

	return
end

function var_0_1.OnDestroy(arg_26_0)
	if arg_26_0.rankTimer then
		local var_26_0 = arg_26_0.rankTimer

		var_1.Stop(var_26_0)

		arg_26_0.rankTimer = nil
	end

	if arg_26_0.bossTimer then
		local var_26_1 = arg_26_0.bossTimer

		var_1.Stop(var_26_1)

		arg_26_0.bossTimer = nil
	end

	local var_26_2 = arg_26_0.allRankPage

	var_1.Destroy(var_26_2)

	local var_26_3 = arg_26_0.timeView

	var_1.Dispose(var_26_3)

	return
end

return var_0_1

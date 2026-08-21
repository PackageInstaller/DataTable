local var_0_0 = class("GuildMissionBossPage", import("....base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "GuildMissionBossPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.hp = arg_2_0._tf:Find("hp/bar")
	arg_2_0.hpProgress = arg_2_0._tf:Find("hp/bar/Text"):GetComponent(typeof(Text))
	arg_2_0.hpL = arg_2_0.hp.rect.width
	arg_2_0.titleTxt = arg_2_0._tf:Find("title"):GetComponent(typeof(Text))
	arg_2_0.assaultBtn = arg_2_0.rtAdapt:Find("btn_a_formation")
	arg_2_0.battleBtn = arg_2_0.rtAdapt:Find("btn_go")
	arg_2_0.reportBtn = arg_2_0.rtAdapt:Find("btn_report")
	arg_2_0.reportTip = arg_2_0.rtAdapt:Find("btn_report/tip")
	arg_2_0.reportTipTxt = arg_2_0.rtAdapt:Find("btn_report/tip/Text"):GetComponent(typeof(Text))
	arg_2_0.cntTxt = arg_2_0.rtAdapt:Find("btn_go/cnt/Text"):GetComponent(typeof(Text))
	arg_2_0.rankList = UIItemList.New(arg_2_0._tf:Find("rank/content"), arg_2_0._tf:Find("rank/content/tpl"))
	arg_2_0.paintingTF = arg_2_0._tf:Find("painting")
	arg_2_0.prefabTF = arg_2_0._tf:Find("prefab")
	arg_2_0.viewAllBtn = arg_2_0._tf:Find("rank/view_all")
	arg_2_0.allRankPage = GuildBossRankPage.New(arg_2_0._parentTf, arg_2_0.event)

	setActive(arg_2_0.viewAllBtn, PLATFORM_CODE ~= PLATFORM_JP)

	arg_2_0.eventTimerTxt = arg_2_0._tf:Find("timer/Text"):GetComponent(typeof(Text))

	setText(arg_2_0._tf:Find("timer/label"), i18n("guild_time_remaining_tip"))

	arg_2_0.timeView = GuildEventTimerView.New()

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.assaultBtn, function()
		arg_3_0:emit(GuildEventLayer.OPEN_BOSS_ASSULT)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.battleBtn, function()
		if not arg_3_0:ExistActiveEvent() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_battle_is_end"))

			return
		end

		if arg_3_0.bossMission:IsReachDailyCnt() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_boss_cnt_no_enough"))

			return
		end

		if arg_3_0.bossMission:IsDeath() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_battle_is_end"))

			return
		end

		arg_3_0:emit(GuildEventLayer.ON_OPEN_BOSS_FORMATION, arg_3_0.bossMission)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.reportBtn, function()
		arg_3_0:emit(GuildEventMediator.ON_OPEN_REPORT)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateMission(arg_7_0, arg_7_1)
	arg_7_0.bossMission = arg_7_1

	return
end

function var_0_0.OnReportUpdated(arg_8_0)
	local var_8_0 = _.select(_.values((getProxy(GuildProxy):GetReports())), function(arg_9_0)
		return arg_9_0:CanSubmit()
	end)

	setActive(arg_8_0.reportTip, #var_8_0 > 0)

	if #var_8_0 > 0 then
		arg_8_0.reportTipTxt.text = #var_8_0
	end

	return
end

function var_0_0.Show(arg_10_0, arg_10_1)
	arg_10_0:UpdateMission(arg_10_1)
	arg_10_0:InitRanks()
	arg_10_0:UpdateView()
	arg_10_0:UpdatePainting()

	if arg_10_0.contextData.editBossFleet then
		triggerButton(arg_10_0.battleBtn)
	end

	setActive(arg_10_0.battleBtn:Find("selected"), (arg_10_1:IsReachDailyCnt()))
	arg_10_0:OnReportUpdated()

	arg_10_0.titleTxt.text = arg_10_1:getConfig("name")

	arg_10_0:CheckFleetShipState()
	arg_10_0.timeView:Flush(arg_10_0.eventTimerTxt, getProxy(GuildProxy):getRawData():GetActiveEvent())

	return
end

function var_0_0.CheckFleetShipState(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs({
		arg_11_0.bossMission:GetMainFleet(),
		arg_11_0.bossMission:GetSubFleet()
	}) do
		if iter_11_1:ExistInvailShips() or iter_11_1:ExistInvalidCommanders() then
			table.insert({}, iter_11_1)
		end
	end

	if #{} > 0 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			content = i18n("guild_boss_formation_exist_invaild_ship")
		})

		arg_11_0.contextData.editBossFleet = {}

		for iter_11_2, iter_11_3 in ipairs({}) do
			arg_11_0.contextData.editBossFleet[iter_11_3.id] = iter_11_3
		end

		arg_11_0:emit(GuildEventMediator.ON_CLEAR_BOSS_FLEET_INVAILD_SHIP)
	end

	return
end

function var_0_0.UpdateView(arg_12_0)
	if getProxy(GuildProxy):ShouldRefreshBoss() then
		arg_12_0:emit(GuildEventMediator.ON_GET_BOSS_INFO)
	else
		arg_12_0:UpdateBossInfo()
		arg_12_0:AddBossTimer()
		var_0_0.super.Show(arg_12_0)
	end

	return
end

function var_0_0.UpdatePainting(arg_13_0)
	local var_13_0 = arg_13_0.bossMission:GetPainting()
	local var_13_1 = var_13_0 and var_13_0 ~= ""

	if var_13_0 and var_13_0 ~= "" then
		setGuildPaintingPrefab(arg_13_0.paintingTF, var_13_0, "chuanwu", nil)
	else
		local var_13_2 = arg_13_0.bossMission:GetEmenyId()

		LoadSpriteAsync("guildboss/" .. var_13_2, function(arg_14_0)
			if arg_13_0:CheckState(BaseSubView.STATES.DESTROY) then
				return
			end

			if arg_14_0 then
				local var_14_0 = GetOrAddComponent(arg_13_0.prefabTF:Find("frame/model"), "Image")

				var_14_0.sprite = arg_14_0

				var_14_0:SetNativeSize()
			end

			return
		end)

		local var_13_3 = arg_13_0.prefabTF:Find("name/Image"):GetComponent(typeof(Image))

		var_13_3.sprite = GetSpriteFromAtlas("guildboss/name_" .. var_13_2, "")

		var_13_3:SetNativeSize()
	end

	setActive(arg_13_0.paintingTF, var_13_1)
	setActive(arg_13_0.prefabTF, not var_13_1)

	return
end

function var_0_0.UpdateBossInfo(arg_15_0)
	local var_15_0 = arg_15_0.bossMission:GetHp() / math.max(arg_15_0.bossMission:GetTotalHp(), 1)
	local var_15_1 = tf(arg_15_0.hp)

	var_15_1.sizeDelta = Vector2(arg_15_0.hpL * var_15_0, var_15_1.sizeDelta.y)
	arg_15_0.hpProgress.text = math.max(var_15_0 * 100 - var_15_0 * 100 % 0.1, 1) .. "%"

	local var_15_2 = arg_15_0.bossMission:GetCanUsageCnt()

	if var_15_2 > 0 then
		local var_15_3 = COLOR_GREEN or COLOR_RED

		arg_15_0.cntTxt.text = "<color=" .. var_15_3 .. ">" .. var_15_2 .. "</color>/" .. GuildConst.MISSION_BOSS_MAX_CNT()

		return
	end
end

function var_0_0.InitRanks(arg_16_0)
	if getProxy(GuildProxy):ShouldRefreshBossRank() then
		arg_16_0:emit(GuildEventMediator.ON_REFRESH_BOSS_RANK)
	else
		arg_16_0:UpdateRank()
		arg_16_0:AddRankTimer()
	end

	return
end

function var_0_0.UpdateRank(arg_17_0)
	local var_17_0 = getProxy(GuildProxy):GetBossRank()

	table.sort(var_17_0, function(arg_18_0, arg_18_1)
		return arg_18_0.damage > arg_18_1.damage
	end)
	arg_17_0.rankList:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			setText(arg_19_2:Find("no"), arg_19_1 + 1)
			setText(arg_19_2:Find("name"), var_17_0[arg_19_1 + 1].name)
			setText(arg_19_2:Find("Text"), var_17_0[arg_19_1 + 1].damage)
		end

		return
	end)
	arg_17_0.rankList:align(math.min(3, #var_17_0))
	onButton(arg_17_0, arg_17_0.viewAllBtn, function()
		arg_17_0.allRankPage:ExecuteAction("Show", var_17_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.ExistActiveEvent(arg_21_0)
	local var_21_0 = getProxy(GuildProxy):getRawData():GetActiveEvent()

	return var_21_0 and not var_21_0:IsExpired()
end

function var_0_0.AddRankTimer(arg_22_0)
	if not arg_22_0:ExistActiveEvent() then
		return
	end

	if arg_22_0.rankTimer then
		arg_22_0.rankTimer:Stop()

		arg_22_0.rankTimer = nil
	end

	arg_22_0.rankTimer = Timer.New(function()
		arg_22_0:emit(GuildEventMediator.ON_REFRESH_BOSS_RANK)

		return
	end, GuildConst.FORCE_REFRESH_MISSION_BOSS_RANK_TIME, 1)

	arg_22_0.rankTimer:Start()

	return
end

function var_0_0.AddBossTimer(arg_24_0)
	if not arg_24_0:ExistActiveEvent() then
		return
	end

	if arg_24_0.bossTimer then
		arg_24_0.bossTimer:Stop()

		arg_24_0.bossTimer = nil
	end

	arg_24_0.bossTimer = Timer.New(function()
		arg_24_0:emit(GuildEventMediator.ON_GET_BOSS_INFO)

		return
	end, GuildConst.FORCE_REFRESH_BOSS_TIME, 1)

	arg_24_0.bossTimer:Start()

	return
end

function var_0_0.OnDestroy(arg_26_0)
	if arg_26_0.rankTimer then
		arg_26_0.rankTimer:Stop()

		arg_26_0.rankTimer = nil
	end

	if arg_26_0.bossTimer then
		arg_26_0.bossTimer:Stop()

		arg_26_0.bossTimer = nil
	end

	arg_26_0.allRankPage:Destroy()
	arg_26_0.timeView:Dispose()

	return
end

return var_0_0

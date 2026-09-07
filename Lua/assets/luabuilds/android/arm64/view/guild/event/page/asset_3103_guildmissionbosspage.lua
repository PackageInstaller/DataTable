local GuildMissionBossPage = class("GuildMissionBossPage", import("....base.BaseSubView"))

function GuildMissionBossPage:getUIName()
	return "GuildMissionBossPage"
end

function GuildMissionBossPage:OnLoaded()
	self.hp = self._tf:Find("hp/bar")
	self.hpProgress = self._tf:Find("hp/bar/Text"):GetComponent(typeof(Text))
	self.hpL = self.hp.rect.width
	self.titleTxt = self._tf:Find("title"):GetComponent(typeof(Text))
	self.assaultBtn = self.rtAdapt:Find("btn_a_formation")
	self.battleBtn = self.rtAdapt:Find("btn_go")
	self.reportBtn = self.rtAdapt:Find("btn_report")
	self.reportTip = self.rtAdapt:Find("btn_report/tip")
	self.reportTipTxt = self.rtAdapt:Find("btn_report/tip/Text"):GetComponent(typeof(Text))
	self.cntTxt = self.rtAdapt:Find("btn_go/cnt/Text"):GetComponent(typeof(Text))
	self.rankList = UIItemList.New(self._tf:Find("rank/content"), self._tf:Find("rank/content/tpl"))
	self.paintingTF = self._tf:Find("painting")
	self.prefabTF = self._tf:Find("prefab")
	self.viewAllBtn = self._tf:Find("rank/view_all")
	self.allRankPage = GuildBossRankPage.New(self._parentTf, self.event)

	setActive(self.viewAllBtn, PLATFORM_CODE ~= PLATFORM_JP)

	self.eventTimerTxt = self._tf:Find("timer/Text"):GetComponent(typeof(Text))

	setText(self._tf:Find("timer/label"), i18n("guild_time_remaining_tip"))

	self.timeView = GuildEventTimerView.New()

	return
end

function GuildMissionBossPage:OnInit()
	onButton(self, self.assaultBtn, function()
		self:emit(GuildEventLayer.OPEN_BOSS_ASSULT)

		return
	end, SFX_PANEL)
	onButton(self, self.battleBtn, function()
		if not self:ExistActiveEvent() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_battle_is_end"))

			return
		end

		if self.bossMission:IsReachDailyCnt() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_boss_cnt_no_enough"))

			return
		end

		if self.bossMission:IsDeath() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_battle_is_end"))

			return
		end

		self:emit(GuildEventLayer.ON_OPEN_BOSS_FORMATION, self.bossMission)

		return
	end, SFX_PANEL)
	onButton(self, self.reportBtn, function()
		self:emit(GuildEventMediator.ON_OPEN_REPORT)

		return
	end, SFX_PANEL)

	return
end

function GuildMissionBossPage:UpdateMission(arg_7_1)
	self.bossMission = arg_7_1

	return
end

function GuildMissionBossPage:OnReportUpdated()
	local var_8_0 = _.select(_.values((getProxy(GuildProxy):GetReports())), function(arg_9_0)
		return arg_9_0:CanSubmit()
	end)

	setActive(self.reportTip, #var_8_0 > 0)

	if #var_8_0 > 0 then
		self.reportTipTxt.text = #var_8_0
	end

	return
end

function GuildMissionBossPage:Show(arg_10_1)
	self:UpdateMission(arg_10_1)
	self:InitRanks()
	self:UpdateView()
	self:UpdatePainting()

	if self.contextData.editBossFleet then
		triggerButton(self.battleBtn)
	end

	setActive(self.battleBtn:Find("selected"), (arg_10_1:IsReachDailyCnt()))
	self:OnReportUpdated()

	self.titleTxt.text = arg_10_1:getConfig("name")

	self:CheckFleetShipState()
	self.timeView:Flush(self.eventTimerTxt, getProxy(GuildProxy):getRawData():GetActiveEvent())

	return
end

function GuildMissionBossPage:CheckFleetShipState()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs({
		self.bossMission:GetMainFleet(),
		self.bossMission:GetSubFleet()
	}) do
		if iter_11_1:ExistInvailShips() or iter_11_1:ExistInvalidCommanders() then
			table.insert(var_11_0, iter_11_1)
		end
	end

	if #var_11_0 > 0 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			content = i18n("guild_boss_formation_exist_invaild_ship")
		})

		self.contextData.editBossFleet = {}

		for iter_11_2, iter_11_3 in ipairs(var_11_0) do
			self.contextData.editBossFleet[iter_11_3.id] = iter_11_3
		end

		self:emit(GuildEventMediator.ON_CLEAR_BOSS_FLEET_INVAILD_SHIP)
	end

	return
end

function GuildMissionBossPage:UpdateView()
	if getProxy(GuildProxy):ShouldRefreshBoss() then
		self:emit(GuildEventMediator.ON_GET_BOSS_INFO)
	else
		self:UpdateBossInfo()
		self:AddBossTimer()
		GuildMissionBossPage.super.Show(self)
	end

	return
end

function GuildMissionBossPage:UpdatePainting()
	local var_13_0 = self.bossMission:GetPainting()
	local var_13_1 = var_13_0 and var_13_0 ~= ""

	if var_13_0 and var_13_0 ~= "" then
		setGuildPaintingPrefab(self.paintingTF, var_13_0, "chuanwu", nil)
	else
		local var_13_2 = self.bossMission:GetEmenyId()

		LoadSpriteAsync("guildboss/" .. var_13_2, function(arg_14_0)
			if self:CheckState(BaseSubView.STATES.DESTROY) then
				return
			end

			if arg_14_0 then
				local var_14_0 = GetOrAddComponent(self.prefabTF:Find("frame/model"), "Image")

				var_14_0.sprite = arg_14_0

				var_14_0:SetNativeSize()
			end

			return
		end)

		local var_13_3 = self.prefabTF:Find("name/Image"):GetComponent(typeof(Image))

		var_13_3.sprite = GetSpriteFromAtlas("guildboss/name_" .. var_13_2, "")

		var_13_3:SetNativeSize()
	end

	setActive(self.paintingTF, var_13_1)
	setActive(self.prefabTF, not var_13_1)

	return
end

function GuildMissionBossPage:UpdateBossInfo()
	local var_15_0 = self.bossMission:GetHp() / math.max(self.bossMission:GetTotalHp(), 1)
	local var_15_1 = tf(self.hp)

	var_15_1.sizeDelta = Vector2(self.hpL * var_15_0, var_15_1.sizeDelta.y)
	self.hpProgress.text = math.max(var_15_0 * 100 - var_15_0 * 100 % 0.1, 1) .. "%"

	local var_15_2 = self.bossMission:GetCanUsageCnt()

	self.cntTxt.text = "<color=" .. ((var_15_2 > 0 or nil) and (COLOR_GREEN or COLOR_RED)) .. ">" .. var_15_2 .. "</color>/" .. GuildConst.MISSION_BOSS_MAX_CNT()

	return
end

function GuildMissionBossPage:InitRanks()
	if getProxy(GuildProxy):ShouldRefreshBossRank() then
		self:emit(GuildEventMediator.ON_REFRESH_BOSS_RANK)
	else
		self:UpdateRank()
		self:AddRankTimer()
	end

	return
end

function GuildMissionBossPage:UpdateRank()
	local var_17_0 = getProxy(GuildProxy):GetBossRank()

	table.sort(var_17_0, function(arg_18_0, arg_18_1)
		return arg_18_0.damage > arg_18_1.damage
	end)
	self.rankList:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			setText(arg_19_2:Find("no"), arg_19_1 + 1)
			setText(arg_19_2:Find("name"), var_17_0[arg_19_1 + 1].name)
			setText(arg_19_2:Find("Text"), var_17_0[arg_19_1 + 1].damage)
		end

		return
	end)
	self.rankList:align(math.min(3, #var_17_0))
	onButton(self, self.viewAllBtn, function()
		self.allRankPage:ExecuteAction("Show", var_17_0)

		return
	end, SFX_PANEL)

	return
end

function GuildMissionBossPage:ExistActiveEvent()
	local var_21_0 = getProxy(GuildProxy):getRawData():GetActiveEvent()

	return var_21_0 and not var_21_0:IsExpired()
end

function GuildMissionBossPage:AddRankTimer()
	if not self:ExistActiveEvent() then
		return
	end

	if self.rankTimer then
		self.rankTimer:Stop()

		self.rankTimer = nil
	end

	self.rankTimer = Timer.New(function()
		self:emit(GuildEventMediator.ON_REFRESH_BOSS_RANK)

		return
	end, GuildConst.FORCE_REFRESH_MISSION_BOSS_RANK_TIME, 1)

	self.rankTimer:Start()

	return
end

function GuildMissionBossPage:AddBossTimer()
	if not self:ExistActiveEvent() then
		return
	end

	if self.bossTimer then
		self.bossTimer:Stop()

		self.bossTimer = nil
	end

	self.bossTimer = Timer.New(function()
		self:emit(GuildEventMediator.ON_GET_BOSS_INFO)

		return
	end, GuildConst.FORCE_REFRESH_BOSS_TIME, 1)

	self.bossTimer:Start()

	return
end

function GuildMissionBossPage:OnDestroy()
	if self.rankTimer then
		self.rankTimer:Stop()

		self.rankTimer = nil
	end

	if self.bossTimer then
		self.bossTimer:Stop()

		self.bossTimer = nil
	end

	self.allRankPage:Destroy()
	self.timeView:Dispose()

	return
end

return GuildMissionBossPage

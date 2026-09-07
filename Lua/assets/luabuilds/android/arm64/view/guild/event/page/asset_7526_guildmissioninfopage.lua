local GuildMissionInfoPage = class("GuildMissionInfoPage", import(".GuildEventBasePage"))
local var_0_1 = 10001

function GuildMissionInfoPage:AttrCnt2Desc(arg_1_1)
	return i18n("guild_event_info_desc1", pg.attribute_info_by_type[self].condition, arg_1_1.total, (arg_1_1.value >= arg_1_1.goal or nil) and (COLOR_GREEN or COLOR_RED), arg_1_1.value, arg_1_1.goal)
end

function GuildMissionInfoPage:AttrAcc2Desc(arg_2_1)
	local var_2_0 = pg.attribute_info_by_type[self]

	assert(pg.attribute_info_by_type[self], self)

	local var_2_1

	if arg_2_1.op == 1 then
		var_2_1 = arg_2_1.value >= arg_2_1.goal and COLOR_GREEN or COLOR_RED
	elseif arg_2_1.op == 2 then
		var_2_1 = arg_2_1.value <= arg_2_1.goal and COLOR_GREEN or COLOR_RED
	end

	assert(var_2_1)

	return i18n("guild_event_info_desc2", var_2_0.condition, var_2_1, arg_2_1.value, arg_2_1.goal)
end

function GuildMissionInfoPage:getUIName()
	return "GuildMissionInfoPage"
end

function GuildMissionInfoPage:OnLoaded()
	self.closeBtn = self._tf:Find("top/close")
	self.sea = self._tf:Find("bg/sea"):GetComponent(typeof(RawImage))
	self.titleTxt = self._tf:Find("top/title/Text"):GetComponent(typeof(Text))
	self.logBtn = self._tf:Find("bottom/log_btn")
	self.formationBtn = self._tf:Find("bottom/formationBtn")
	self.doingBtn = self._tf:Find("bottom/doing_btn")
	self.helpBtn = self._tf:Find("bottom/help")
	self.logPanel = self._tf:Find("log_panel")
	self.logList = UIItemList.New(self.logPanel:Find("scrollrect/content"), self.logPanel:Find("scrollrect/content/tpl"))
	self.peopleCnt = self._tf:Find("bottom/cnt/Text"):GetComponent(typeof(Text))
	self.effectCnt = self._tf:Find("bottom/effect/Text"):GetComponent(typeof(Text))

	setText(self._tf:Find("bottom/cnt"), i18n("guild_join_member_cnt"))
	setText(self._tf:Find("bottom/effect"), i18n("guild_total_effect"))

	self.areaTxt = self._tf:Find("top/title/Text/target/area"):GetComponent(typeof(Text))
	self.goalTxt = self._tf:Find("top/title/Text/target/goal"):GetComponent(typeof(Text))
	self.timeTxt = self._tf:Find("bottom/progress/time/Text"):GetComponent(typeof(Text))
	self.nodesUIlist = UIItemList.New(self._tf:Find("bottom/progress/nodes"), self._tf:Find("bottom/progress/nodes/tpl"))
	self.progress = self._tf:Find("bottom/progress")
	self.nodeLength = self.progress.rect.width
	self.healTF = self._tf:Find("resources/heal")
	self.nameTF = self._tf:Find("resources/name")

	return
end

function GuildMissionInfoPage:OnInit()
	onButton(self, self.closeBtn, function()
		self.contextData.mission = nil

		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.guild_mission_info_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.logBtn, function()
		if self.isShowLogPanel then
			self:ShowOrHideLogPanel(false)
		else
			self:ShowOrHideLogPanel(true)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.logPanel, function()
		self:ShowOrHideLogPanel(false)

		return
	end, SFX_PANEL)
	onButton(self, self.formationBtn, function()
		if self.mission:IsFinish() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_event_is_finish"))

			return
		end

		self:emit(GuildEventLayer.OPEN_MISSION_FORAMTION, self.mission)

		return
	end, SFX_PANEL)
	onButton(self, self.doingBtn, function()
		triggerButton(self.formationBtn)

		return
	end, SFX_PANEL)

	return
end

function GuildMissionInfoPage:OnRefreshMission(arg_12_1)
	self:Flush(arg_12_1)

	return
end

function GuildMissionInfoPage:OnShow()
	self:Flush(self.extraData.mission)
	self:EnterFormation()
	self:AddOtherShipMoveTimer()

	return
end

function GuildMissionInfoPage:Flush(arg_14_1)
	self.mission = arg_14_1

	self:InitBattleSea()
	self:InitView()
	self:AddRefreshProgressTimer()

	return
end

function GuildMissionInfoPage:EnterFormation()
	if self.contextData.missionShips then
		triggerButton(self.formationBtn)
	end

	return
end

function GuildMissionInfoPage:InitView()
	local var_16_0 = self.mission

	self.titleTxt.text = self.mission:GetName()
	self.peopleCnt.text = self.mission:GetJoinMemberCnt() .. "/" .. self.guild.memberCount .. i18n("guild_word_people")
	self.effectCnt.text = self.mission:GetEfficiency() .. "(" .. self.mission:GetMyEffect() .. ")"
	self.areaTxt.text = i18n("guild_word_battle_area") .. table.concat(_.map(self.mission:GetNations(), function(arg_17_0)
		return i18n("guild_event_info_desc3", Nation.Nation2Name(arg_17_0), #var_16_0:GetShipsByNation(arg_17_0))
	end), " 、")

	local var_16_1 = table.concat(GuildMissionInfoPage.GetBattleTarget(self.mission), " 、")

	if var_16_1 ~= "" then
		self.goalTxt.text = i18n("guild_wrod_battle_target") .. var_16_1
	end

	setActive(self.goalTxt.gameObject, var_16_1 ~= "")
	self:UpdateNodes()
	self:UpdateFormationBtn()

	return
end

function GuildMissionInfoPage:UpdateFormationBtn()
	local var_18_0 = self.mission:CanFormation()

	setActive(self.formationBtn, var_18_0)
	setActive(self.doingBtn, not var_18_0)

	return
end

function GuildMissionInfoPage:GetBattleTarget()
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs((self:GetAttrCntAcc())) do
		table.insert(var_19_0, GuildMissionInfoPage.AttrCnt2Desc(iter_19_0, iter_19_1))
	end

	for iter_19_2, iter_19_3 in pairs((self:GetAttrAcc())) do
		table.insert(var_19_0, GuildMissionInfoPage.AttrAcc2Desc(iter_19_2, iter_19_3))
	end

	return var_19_0
end

function GuildMissionInfoPage:UpdateNodes()
	self.nodes = {}

	local var_20_0 = self.mission:GetNodes()
	local var_20_1 = 1

	if not self.mission:IsFinish() then
		self.nodesUIlist:make(function(arg_21_0, arg_21_1, arg_21_2)
			if arg_21_0 == UIItemList.EventUpdate then
				local var_21_0 = var_20_0[arg_21_1 + 1]:GetPosition()

				arg_21_2:GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/GuildMissionInfoUI_atlas", var_21_0)

				setAnchoredPosition(arg_21_2, {
					x = self.nodeLength * (var_21_0 / 100)
				})

				arg_21_2:Find("item"):GetComponent(typeof(Image)).sprite = LoadSprite("GuildNode/" .. var_20_0[arg_21_1 + 1]:GetIcon())

				table.insert(self.nodes, arg_21_2)
			end

			return
		end)
		self.nodesUIlist:align(#var_20_0)

		var_20_1 = self.mission:GetProgress()
	end

	setSlider(self.progress, 0, 100, var_20_1 * 100)

	return
end

function GuildMissionInfoPage:InitBattleSea()
	if self.loading then
		return
	end

	self.loading = true

	local var_22_0 = {}

	if not self.battleView then
		self.battleView = GuildMissionBattleView.New(self.sea)

		self.battleView:configUI(self.healTF, self.nameTF)
		table.insert(var_22_0, function(arg_23_0)
			self.battleView:load(var_0_1, arg_23_0)

			return
		end)
	end

	local var_22_1 = self.mission:GetMyFlagShip()
	local var_22_2
	local var_22_3 = {}
	local var_22_4 = ""

	if var_22_1 then
		var_22_2 = getProxy(BayProxy):getShipById(var_22_1) or Ship.New({
			id = 9999,
			configId = 101171
		})

		local var_22_5 = math.floor(var_22_2.configId / 10)

		for iter_22_0 = 1, 4 do
			local var_22_6 = pg.ship_data_breakout[tonumber(var_22_5 .. iter_22_0)]

			for iter_22_1, iter_22_2 in ipairs((var_22_6 or nil) and (var_22_6.weapon_ids or {})) do
				if not table.contains(var_22_3, iter_22_2) then
					table.insert(var_22_3, iter_22_2)
				end
			end
		end

		var_22_4 = getProxy(PlayerProxy):getRawData().name
	end

	table.insert(var_22_0, function(arg_24_0)
		self.battleView:LoadShip(var_22_2, var_22_3, var_22_4, function()
			if var_22_2 then
				self:CheckNodesState()
			end

			arg_24_0()

			return
		end)

		return
	end)
	seriesAsync(var_22_0, function()
		self.loading = false

		return
	end)

	return
end

function GuildMissionInfoPage:AddOtherShipMoveTimer()
	local function var_27_0(arg_28_0)
		local var_28_0 = {}
		local var_28_1 = self.mission:GetOtherShips()

		if #var_28_1 == 0 then
			return var_28_0
		end

		if arg_28_0 >= #var_28_1 then
			return var_28_1
		end

		shuffle(var_28_1)

		for iter_28_0 = 1, arg_28_0 do
			table.insert(var_28_0, var_28_1[iter_28_0])
		end

		return var_28_0
	end

	local function var_27_2()
		if self.timer then
			self.timer:Stop()

			self.timer = nil
		end

		self.timer = Timer.New(function()
			self.battleView:PlayOtherShipAnim(var_27_0((math.random(1, 2))), var_27_2)

			return
		end, math.random(30, 150), 1)

		self.timer:Start()

		return
	end

	;(nil)()

	return
end

function GuildMissionInfoPage:CheckNodesState()
	local var_31_0 = self.mission:GetNewestSuccessNode()

	if var_31_0 then
		local var_31_1 = var_31_0:GetPosition()

		if self.mission:GetNodeAnimPosistion() < var_31_1 then
			(function(arg_32_0)
				if arg_32_0:IsItemType() then
					self.battleView:PlayItemAnim()
				elseif arg_32_0:IsBattleType() then
					self.battleView:PlayAttackAnim()
				end

				return
			end)(var_31_0)
			self:emit(GuildEventMediator.ON_UPDATE_NODE_ANIM_FLAG, self.mission.id, var_31_1)
		end
	end

	return
end

function GuildMissionInfoPage:AddRefreshProgressTimer()
	self:RemoveCdTimer()
	self:RemoveRefreshTimer()

	local var_33_0 = self.mission
	local var_33_1 = self.mission:GetTotalTimeCost()
	local var_33_2 = not self.mission:IsFinish() and var_33_1 > 0

	if var_33_2 then
		assert(var_33_1 > 900, var_33_1)

		self.refreshTimer = Timer.New(function()
			self:RemoveRefreshTimer()
			self:emit(GuildEventMediator.FORCE_REFRESH_MISSION, var_33_0.id)

			return
		end, var_33_1 * 0.01, 1)

		self.refreshTimer:Start()

		local var_33_3 = var_33_0:GetRemainingTime()

		if var_33_3 > 0 then
			self.cdTimer = Timer.New(function()
				var_33_3 = var_33_3 - 1

				if var_33_3 <= 0 then
					self:RemoveCdTimer()
					setActive(self.timeTxt.gameObject.transform.parent, false)
				else
					self.timeTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_33_3)
				end

				return
			end, 1, -1)

			self.cdTimer:Start()
			self.cdTimer.func()
		else
			setActive(self.timeTxt.gameObject.transform.parent, false)
		end
	end

	setActive(self.timeTxt.gameObject.transform.parent, var_33_2)

	return
end

function GuildMissionInfoPage:RemoveCdTimer()
	if self.cdTimer then
		self.cdTimer:Stop()

		self.cdTimer = nil
	end

	return
end

function GuildMissionInfoPage:ShowOrHideLogPanel(arg_37_1, arg_37_2)
	arg_37_2 = arg_37_2 or 0.3

	if LeanTween.isTweening(self.logPanel) then
		return
	end

	local var_37_0 = self.logPanel.rect.width + 300

	LeanTween.value(self.logPanel.gameObject, arg_37_1 and var_37_0 or 0, arg_37_1 and 0 or var_37_0, arg_37_2):setOnUpdate(System.Action_float(function(arg_38_0)
		setAnchoredPosition(self.logPanel, {
			x = arg_38_0
		})

		return
	end)):setOnComplete(System.Action(function()
		if not arg_37_1 then
			setActive(self.logPanel, false)
		end

		return
	end))

	self.isShowLogPanel = arg_37_1

	if arg_37_1 then
		setActive(self.logPanel, true)
		self:InitLogs()
	end

	return
end

function GuildMissionInfoPage:InitLogs()
	local var_40_0 = self.mission:GetLogs()

	self.logList:make(function(arg_41_0, arg_41_1, arg_41_2)
		if arg_41_0 == UIItemList.EventUpdate then
			setText(arg_41_2, var_40_0[arg_41_1 + 1])
		end

		return
	end)
	self.logList:align(#var_40_0)

	return
end

function GuildMissionInfoPage:RemoveRefreshTimer()
	if self.refreshTimer then
		self.refreshTimer:Stop()

		refreshTimer = nil
	end

	return
end

function GuildMissionInfoPage:Hide()
	self:ShowOrHideLogPanel(false, 0)
	GuildMissionInfoPage.super.Hide(self)

	if self.battleView then
		self.battleView:clear()

		self.battleView = nil
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self:RemoveRefreshTimer()
	self:RemoveCdTimer()

	return
end

return GuildMissionInfoPage

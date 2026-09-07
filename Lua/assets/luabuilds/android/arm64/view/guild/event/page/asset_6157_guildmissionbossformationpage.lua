local GuildMissionBossFormationPage = class("GuildMissionBossFormationPage", import(".GuildEventBasePage"))

function GuildMissionBossFormationPage:getUIName()
	return "GuildBossFormationPage"
end

function GuildMissionBossFormationPage:OnLoaded()
	self.closeBtn = self._tf:Find("frame/close")
	self.descTxt = self._tf:Find("frame/bottom/target/scrollrect/Text"):GetComponent(typeof(Text))
	self.awardList = UIItemList.New(self._tf:Find("frame/bottom/award/list"), self._tf:Find("frame/bottom/award/list/item"))
	self.titleTxt = self._tf:Find("frame/title"):GetComponent(typeof(Text))
	self.goBtn = self._tf:Find("frame/bottom/go")
	self.consumeTxt = self.goBtn:Find("oil/Text"):GetComponent(typeof(Text))
	self.recomBtn = self._tf:Find("frame/recom")
	self.clearBtn = self._tf:Find("frame/clear")
	self.grids = self._tf:Find("frame/double")
	self.subGrids = self._tf:Find("frame/single")
	self.nextBtn = self._tf:Find("frame/next")
	self.prevBtn = self._tf:Find("frame/prev")
	self._autoToggle = self._tf:Find("frame/auto_toggle")
	self._autoSubToggle = self._tf:Find("frame/sub_toggle")
	self.commanderPage = GuildCommanderFormationPage.New(self._tf:Find("frame/commanders"), self.event, self.contextData)

	setText(self.goBtn:Find("oil/label"), i18n("text_consume"))

	self.flag = self._tf:Find("frame/double/1/flag")
	self.subFlag = self._tf:Find("frame/single/1/flag")
	self.shipCards = {}

	return
end

function GuildMissionBossFormationPage:Show(arg_3_1, arg_3_2, arg_3_3)
	GuildMissionBossFormationPage.super.Show(self, arg_3_1, arg_3_2, arg_3_3)

	Input.multiTouchEnabled = false

	return
end

function GuildMissionBossFormationPage:Hide(arg_4_1)
	GuildMissionBossFormationPage.super.Hide(self, arg_4_1)

	Input.multiTouchEnabled = true

	return
end

function GuildMissionBossFormationPage:OnInit()
	onButton(self, self.nextBtn, function()
		self:UpdateFleet(GuildBossMission.SUB_FLEET_ID)

		return
	end, SFX_PANEL)
	onButton(self, self.prevBtn, function()
		self:UpdateFleet(GuildBossMission.MAIN_FLEET_ID)

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		if self.contextData.editBossFleet then
			self:emit(GuildEventMediator.ON_SAVE_FORMATION, function()
				self:Hide()

				return
			end)
		else
			self:Hide()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.goBtn, function()
		self:emit(GuildEventMediator.ON_UPDATE_BOSS_FLEET)

		return
	end, SFX_PANEL)
	onButton(self, self.recomBtn, function()
		self:emit(GuildEventMediator.ON_RECOMM_BOSS_BATTLE_SHIPS, self.fleet.id)

		return
	end, SFX_PANEL)
	onButton(self, self.clearBtn, function()
		self.contextData.editBossFleet = self.contextData.editBossFleet or {}

		local var_12_0 = self.contextData.bossFormationIndex or GuildBossMission.MAIN_FLEET_ID
		local var_12_1 = Clone(self.fleet)

		var_12_1:RemoveAll()

		self.contextData.editBossFleet[var_12_0] = var_12_1

		self:UpdateFleet(var_12_0)

		return
	end, SFX_PANEL)

	return
end

function GuildMissionBossFormationPage:UpdateMission(arg_13_1, arg_13_2)
	self.bossMission = arg_13_1

	if arg_13_2 then
		self:UpdateFleet(self.contextData.bossFormationIndex or GuildBossMission.MAIN_FLEET_ID)
	end

	return
end

function GuildMissionBossFormationPage:OnBossCommanderFormationChange()
	self.fleet = self.contextData.editBossFleet[self.fleet.id]

	self:UpdateCommanders(self.fleet)

	return
end

function GuildMissionBossFormationPage:OnBossCommanderPrefabFormationChange()
	self:UpdateCommanders(self.fleet)

	return
end

function GuildMissionBossFormationPage:OnShow()
	self.isOpenCommander = self:CheckCommanderPanel()
	self.guild = self.guild

	self:UpdateMission(self.extraData.mission, true)
	self:UpdateDesc()

	local var_16_0 = getProxy(PlayerProxy)

	self.consumeTxt.text = string.format("<color=%s>%d</color>/%d", (pg.guildset.use_oil.key_value <= var_16_0 or nil) and (COLOR_GREEN or COLOR_RED), var_16_0:getRawData():getResource(2), pg.guildset.use_oil.key_value)
	self.isOpenAuto = ys.Battle.BattleState.IsAutoBotActive(SYSTEM_GUILD)

	local var_16_2 = AutoBotCommand.GetAutoBotMark(SYSTEM_GUILD)

	self:OnSwitch(self._autoToggle, self.isOpenAuto, function(arg_17_0)
		self.isOpenAuto = arg_17_0

		self:UpdateSubToggle()
		PlayerPrefs.SetInt("autoBotIsAcitve" .. var_16_2, arg_17_0 and 1 or 0)
		PlayerPrefs.Save()

		return
	end)

	local var_16_3 = AutoSubCommand.GetAutoSubMark(SYSTEM_GUILD)

	self:OnSwitch(self._autoSubToggle, ys.Battle.BattleState.IsAutoSubActive(SYSTEM_GUILD), function(arg_18_0)
		PlayerPrefs.SetInt("autoSubIsAcitve" .. var_16_3, arg_18_0 and 1 or 0)
		PlayerPrefs.Save()

		return
	end)
	self:UpdateSubToggle()

	return
end

function GuildMissionBossFormationPage:GetFleet(arg_19_1)
	local var_19_0

	if self.contextData.editBossFleet then
		var_19_0 = self.contextData.editBossFleet[arg_19_1]
	end

	var_19_0 = var_19_0 or self.bossMission:GetFleetByIndex(arg_19_1)

	return var_19_0
end

function GuildMissionBossFormationPage:UpdateSubToggle()
	local var_20_0 = self:GetFleet(GuildBossMission.SUB_FLEET_ID)
	local var_20_1 = self:GetFleet(GuildBossMission.MAIN_FLEET_ID):IsLegal()

	setActive(self._autoSubToggle, self.isOpenAuto and var_20_1 and var_20_0 and var_20_0:ExistSubShip())
	setActive(self._autoToggle, AutoBotCommand.autoBotSatisfied() and var_20_1)

	return
end

function GuildMissionBossFormationPage:OnSwitch(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_1:Find("on")
	local var_21_1 = arg_21_1:Find("off")

	local function var_21_2(arg_22_0)
		setActive(var_21_0, arg_22_0)
		setActive(var_21_1, not arg_22_0)

		return
	end

	removeOnToggle(arg_21_1)
	var_21_2(arg_21_2)
	triggerToggle(arg_21_1, arg_21_2)
	onToggle(self, arg_21_1, function(arg_23_0)
		var_21_2(arg_23_0)
		arg_21_3(arg_23_0)

		return
	end, SFX_PANEL)

	return
end

function GuildMissionBossFormationPage:CheckCommanderPanel()
	return pg.SystemOpenMgr.GetInstance():isOpenSystem(self.player.level, "CommanderCatMediator") and not LOCK_COMMANDER
end

function GuildMissionBossFormationPage:UpdateDesc()
	self.descTxt.text = i18n("guild_boss_fleet_desc")

	local var_25_0 = self.bossMission:GetAwards()

	self.awardList:make(function(arg_26_0, arg_26_1, arg_26_2)
		if arg_26_0 == UIItemList.EventUpdate then
			local var_26_0 = {
				type = var_25_0[arg_26_1 + 1][1],
				id = var_25_0[arg_26_1 + 1][2],
				count = var_25_0[arg_26_1 + 1][3]
			}

			updateDrop(arg_26_2, var_26_0)
			onButton(self, arg_26_2, function()
				self:emit(BaseUI.ON_DROP, var_26_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.awardList:align(#var_25_0)

	self.titleTxt.text = self.bossMission:GetName()

	return
end

function GuildMissionBossFormationPage:UpdateFleet(arg_28_1)
	local var_28_0 = self.contextData.editBossFleet and self.contextData.editBossFleet[arg_28_1] and self.contextData.editBossFleet[arg_28_1] or self.bossMission:GetFleetByIndex(arg_28_1)

	self.fleet = var_28_0

	self:UpdateShips(var_28_0)
	self:UpdateCommanders(var_28_0)

	self.contextData.bossFormationIndex = arg_28_1

	setActive(self.nextBtn, arg_28_1 == GuildBossMission.MAIN_FLEET_ID)
	setActive(self.prevBtn, arg_28_1 == GuildBossMission.SUB_FLEET_ID)
	self:UpdateSubToggle()

	return
end

function GuildMissionBossFormationPage:UpdateCommanders(arg_29_1)
	if self.isOpenCommander then
		self.commanderPage:ExecuteAction("Update", arg_29_1, (getProxy(CommanderProxy):getPrefabFleet()))
	end

	return
end

function GuildMissionBossFormationPage:UpdateShips(arg_30_1)
	self:ClearShips()

	local var_30_0 = {}
	local var_30_1 = {}
	local var_30_2 = {}

	for iter_30_0, iter_30_1 in ipairs((arg_30_1:GetShips())) do
		if iter_30_1 and iter_30_1.ship then
			local var_30_3 = iter_30_1.ship:getTeamType()

			if var_30_3 == TeamType.Vanguard then
				table.insert(var_30_1, iter_30_1)
			elseif var_30_3 == TeamType.Main then
				table.insert(var_30_0, iter_30_1)
			elseif var_30_3 == TeamType.Submarine then
				table.insert(var_30_2, iter_30_1)
			end
		end
	end

	local var_30_4 = arg_30_1:IsMainFleet()

	if var_30_4 then
		self:UpdateMainFleetShips(var_30_0, var_30_1)
	else
		self:UpdateSubFleetShips(var_30_2)
	end

	setActive(self.flag, var_30_4 and #var_30_0 > 0)
	setActive(self.subFlag, not var_30_4 and #var_30_2 > 0)
	setActive(self.grids, var_30_4)
	setActive(self.subGrids, not var_30_4)

	return
end

function GuildMissionBossFormationPage:UpdateMainFleetShips(arg_31_1, arg_31_2)
	for iter_31_0 = 1, 3 do
		self:UpdateShip(iter_31_0, self.grids:Find(iter_31_0), TeamType.Main, arg_31_1[iter_31_0])
	end

	for iter_31_1 = 4, 6 do
		self:UpdateShip(iter_31_1, self.grids:Find(iter_31_1), TeamType.Vanguard, arg_31_2[iter_31_1 - 3])
	end

	return
end

function GuildMissionBossFormationPage:UpdateSubFleetShips(arg_32_1)
	for iter_32_0 = 1, 3 do
		self:UpdateShip(iter_32_0, self.subGrids:Find(iter_32_0), TeamType.Submarine, arg_32_1[iter_32_0])
	end

	return
end

function GuildMissionBossFormationPage:UpdateShip(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	local var_33_0 = arg_33_2:Find("Image")

	if arg_33_4 then
		local var_33_1 = arg_33_4.ship
		local var_33_2 = arg_33_4.ship:getPrefab()
		local var_33_3 = SpineAnimChar.New()

		var_33_3:SetPaint(var_33_2)
		var_33_3:Load(true, function(arg_34_0)
			arg_34_0:SetName(var_33_2)
			arg_34_0:SetParent(arg_33_2.parent)

			local var_34_0 = GuildBossFormationShipCard.New(arg_34_0)

			var_34_0:Update(var_33_1, arg_33_1)
			arg_34_0:SetAction("stand", 0)

			local var_34_1 = GetOrAddComponent(arg_34_0:GetModel(), "EventTriggerListener")

			var_34_1:AddPointClickFunc(function(arg_35_0, arg_35_1)
				if self.dragging then
					return
				end

				self:emit(GuildEventMediator.ON_SELECT_BOSS_SHIP, arg_33_3, self.fleet.id, arg_33_4)

				return
			end)
			var_34_1:AddBeginDragFunc(function(arg_36_0, arg_36_1)
				self.dragging = true

				arg_36_0.transform:SetAsLastSibling()
				arg_34_0:SetAction("tuozhuai", 0)

				return
			end)
			var_34_1:AddDragFunc(function(arg_37_0, arg_37_1)
				var_34_0:SetLocalPosition((GuildMissionBossFormationPage.Scr2Lpos(arg_33_2.parent, arg_37_1.position)))

				local var_37_0 = self:GetNearestCard(var_34_0)

				if var_37_0 then
					self:SwopCardSolt(var_37_0, var_34_0)
				end

				return
			end)
			var_34_1:AddDragEndFunc(function(arg_38_0, arg_38_1)
				self.dragging = false

				var_34_0:RefreshPosition(var_34_0:GetSoltIndex(), true)
				arg_34_0:SetAction("stand", 0)
				self:RefreshFleet()

				return
			end)
			table.insert(self.shipCards, var_34_0)

			return
		end)
	else
		onButton(self, var_33_0, function()
			self:emit(GuildEventMediator.ON_SELECT_BOSS_SHIP, arg_33_3, self.fleet.id)

			return
		end, SFX_PANEL)
	end

	setActive(var_33_0, not arg_33_4)

	return
end

function GuildMissionBossFormationPage:GetNearestCard(arg_40_1)
	for iter_40_0, iter_40_1 in ipairs(self.shipCards) do
		if iter_40_1:GetSoltIndex() ~= arg_40_1:GetSoltIndex() and iter_40_1.teamType == arg_40_1.teamType and Vector2.Distance(arg_40_1:GetLocalPosition(), iter_40_1:GetLocalPosition()) <= 50 then
			return iter_40_1
		end
	end

	return nil
end

function GuildMissionBossFormationPage:SwopCardSolt(arg_41_1, arg_41_2)
	arg_41_1:RefreshPosition(arg_41_2:GetSoltIndex(), true)
	arg_41_2:RefreshPosition(arg_41_1:GetSoltIndex(), false)

	return
end

function GuildMissionBossFormationPage:RefreshFleet()
	local var_42_0 = {}

	for iter_42_0, iter_42_1 in ipairs(self.shipCards) do
		table.insert(var_42_0, {
			index = iter_42_1:GetSoltIndex(),
			shipId = iter_42_1.shipId
		})
	end

	table.sort(var_42_0, function(arg_43_0, arg_43_1)
		return arg_43_0.index < arg_43_1.index
	end)

	self.contextData.editBossFleet = self.contextData.editBossFleet or {}

	if not self.contextData.editBossFleet[self.fleet.id] then
		self.contextData.editBossFleet[self.fleet.id] = Clone(self.fleet)
		self.fleet = self.contextData.editBossFleet[self.fleet.id]
	end

	self.fleet:ResortShips(var_42_0)

	return
end

function GuildMissionBossFormationPage:ClearShips()
	for iter_44_0, iter_44_1 in ipairs(self.shipCards) do
		iter_44_1:Dispose()
	end

	self.shipCards = {}

	return
end

function GuildMissionBossFormationPage:OnDestroy()
	GuildMissionBossFormationPage.super.OnDestroy(self)
	self:ClearShips()
	self.commanderPage:Destroy()

	return
end

function GuildMissionBossFormationPage:Scr2Lpos(arg_46_1)
	return (LuaHelper.ScreenToLocal(self:GetComponent("RectTransform"), arg_46_1, (GameObject.Find("OverlayCamera"):GetComponent("Camera"))))
end

return GuildMissionBossFormationPage

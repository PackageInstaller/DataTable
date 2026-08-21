local var_0_0 = class("GuildMissionBossFormationPage", import(".GuildEventBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "GuildBossFormationPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/close")
	arg_2_0.descTxt = arg_2_0._tf:Find("frame/bottom/target/scrollrect/Text"):GetComponent(typeof(Text))
	arg_2_0.awardList = UIItemList.New(arg_2_0._tf:Find("frame/bottom/award/list"), arg_2_0._tf:Find("frame/bottom/award/list/item"))
	arg_2_0.titleTxt = arg_2_0._tf:Find("frame/title"):GetComponent(typeof(Text))
	arg_2_0.goBtn = arg_2_0._tf:Find("frame/bottom/go")
	arg_2_0.consumeTxt = arg_2_0.goBtn:Find("oil/Text"):GetComponent(typeof(Text))
	arg_2_0.recomBtn = arg_2_0._tf:Find("frame/recom")
	arg_2_0.clearBtn = arg_2_0._tf:Find("frame/clear")
	arg_2_0.grids = arg_2_0._tf:Find("frame/double")
	arg_2_0.subGrids = arg_2_0._tf:Find("frame/single")
	arg_2_0.nextBtn = arg_2_0._tf:Find("frame/next")
	arg_2_0.prevBtn = arg_2_0._tf:Find("frame/prev")
	arg_2_0._autoToggle = arg_2_0._tf:Find("frame/auto_toggle")
	arg_2_0._autoSubToggle = arg_2_0._tf:Find("frame/sub_toggle")
	arg_2_0.commanderPage = GuildCommanderFormationPage.New(arg_2_0._tf:Find("frame/commanders"), arg_2_0.event, arg_2_0.contextData)

	setText(arg_2_0.goBtn:Find("oil/label"), i18n("text_consume"))

	arg_2_0.flag = arg_2_0._tf:Find("frame/double/1/flag")
	arg_2_0.subFlag = arg_2_0._tf:Find("frame/single/1/flag")
	arg_2_0.shipCards = {}

	return
end

function var_0_0.Show(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	var_0_0.super.Show(arg_3_0, arg_3_1, arg_3_2, arg_3_3)

	Input.multiTouchEnabled = false

	return
end

function var_0_0.Hide(arg_4_0, arg_4_1)
	var_0_0.super.Hide(arg_4_0, arg_4_1)

	Input.multiTouchEnabled = true

	return
end

function var_0_0.OnInit(arg_5_0)
	onButton(arg_5_0, arg_5_0.nextBtn, function()
		arg_5_0:UpdateFleet(GuildBossMission.SUB_FLEET_ID)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.prevBtn, function()
		arg_5_0:UpdateFleet(GuildBossMission.MAIN_FLEET_ID)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.closeBtn, function()
		if arg_5_0.contextData.editBossFleet then
			arg_5_0:emit(GuildEventMediator.ON_SAVE_FORMATION, function()
				arg_5_0:Hide()

				return
			end)
		else
			arg_5_0:Hide()
		end

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.goBtn, function()
		arg_5_0:emit(GuildEventMediator.ON_UPDATE_BOSS_FLEET)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.recomBtn, function()
		arg_5_0:emit(GuildEventMediator.ON_RECOMM_BOSS_BATTLE_SHIPS, arg_5_0.fleet.id)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.clearBtn, function()
		arg_5_0.contextData.editBossFleet = arg_5_0.contextData.editBossFleet or {}

		local var_12_0 = arg_5_0.contextData.bossFormationIndex or GuildBossMission.MAIN_FLEET_ID
		local var_12_1 = Clone(arg_5_0.fleet)

		var_12_1:RemoveAll()

		arg_5_0.contextData.editBossFleet[var_12_0] = var_12_1

		arg_5_0:UpdateFleet(var_12_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateMission(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.bossMission = arg_13_1

	if arg_13_2 then
		local var_13_0 = arg_13_0.contextData.bossFormationIndex or GuildBossMission.MAIN_FLEET_ID

		arg_13_0:UpdateFleet(var_13_0)
	end

	return
end

function var_0_0.OnBossCommanderFormationChange(arg_14_0)
	arg_14_0.fleet = arg_14_0.contextData.editBossFleet[arg_14_0.fleet.id]

	arg_14_0:UpdateCommanders(arg_14_0.fleet)

	return
end

function var_0_0.OnBossCommanderPrefabFormationChange(arg_15_0)
	arg_15_0:UpdateCommanders(arg_15_0.fleet)

	return
end

function var_0_0.OnShow(arg_16_0)
	local var_16_9000

	arg_16_0.isOpenCommander = arg_16_0:CheckCommanderPanel()
	arg_16_0.guild = arg_16_0.guild

	arg_16_0:UpdateMission(arg_16_0.extraData.mission, true)
	arg_16_0:UpdateDesc()

	local var_16_0 = getProxy(PlayerProxy)
	local var_16_1 = pg.guildset.use_oil.key_value
	local var_16_2 = var_16_0.getRawData(var_16_9000):getResource(2)

	if pg.guildset.use_oil.key_value <= var_16_0 then
		local var_16_3 = COLOR_GREEN or COLOR_RED

		arg_16_0.consumeTxt.text = string.format("<color=%s>%d</color>/%d", var_16_3, var_16_2, var_16_1)
		arg_16_0.isOpenAuto = ys.Battle.BattleState.IsAutoBotActive(SYSTEM_GUILD)

		local var_16_4 = AutoBotCommand.GetAutoBotMark(SYSTEM_GUILD)

		arg_16_0:OnSwitch(arg_16_0._autoToggle, arg_16_0.isOpenAuto, function(arg_17_0)
			arg_16_0.isOpenAuto = arg_17_0

			arg_16_0:UpdateSubToggle()
			PlayerPrefs.SetInt("autoBotIsAcitve" .. var_16_4, arg_17_0 and 1 or 0)
			PlayerPrefs.Save()

			return
		end)

		local var_16_5 = AutoSubCommand.GetAutoSubMark(SYSTEM_GUILD)

		arg_16_0:OnSwitch(arg_16_0._autoSubToggle, ys.Battle.BattleState.IsAutoSubActive(SYSTEM_GUILD), function(arg_18_0)
			PlayerPrefs.SetInt("autoSubIsAcitve" .. var_16_5, arg_18_0 and 1 or 0)
			PlayerPrefs.Save()

			return
		end)
		arg_16_0:UpdateSubToggle()

		return
	end
end

function var_0_0.GetFleet(arg_19_0, arg_19_1)
	local var_19_0

	if arg_19_0.contextData.editBossFleet then
		var_19_0 = arg_19_0.contextData.editBossFleet[arg_19_1]
	end

	var_19_0 = var_19_0 or arg_19_0.bossMission:GetFleetByIndex(arg_19_1)

	return var_19_0
end

function var_0_0.UpdateSubToggle(arg_20_0)
	local var_20_0 = arg_20_0:GetFleet(GuildBossMission.SUB_FLEET_ID)
	local var_20_1 = arg_20_0:GetFleet(GuildBossMission.MAIN_FLEET_ID):IsLegal()
	local var_20_2 = arg_20_0.isOpenAuto and var_20_1 and var_20_0 and var_20_0:ExistSubShip()

	setActive(arg_20_0._autoSubToggle, var_20_2)

	local var_20_3 = AutoBotCommand.autoBotSatisfied() and var_20_1

	setActive(arg_20_0._autoToggle, var_20_3)

	return
end

function var_0_0.OnSwitch(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_1:Find("on")
	local var_21_1 = arg_21_1:Find("off")

	local function var_21_2(arg_22_0)
		setActive(var_21_0, arg_22_0)
		setActive(var_21_1, not arg_22_0)

		return
	end

	removeOnToggle(arg_21_1)
	;(function(arg_22_0)
		setActive(var_21_0, arg_22_0)
		setActive(var_21_1, not arg_22_0)

		return
	end)(arg_21_2)
	triggerToggle(arg_21_1, arg_21_2)
	onToggle(arg_21_0, arg_21_1, function(arg_23_0)
		var_21_2(arg_23_0)
		arg_21_3(arg_23_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.CheckCommanderPanel(arg_24_0)
	return pg.SystemOpenMgr.GetInstance():isOpenSystem(arg_24_0.player.level, "CommanderCatMediator") and not LOCK_COMMANDER
end

function var_0_0.UpdateDesc(arg_25_0)
	arg_25_0.descTxt.text = i18n("guild_boss_fleet_desc")

	local var_25_0 = arg_25_0.bossMission:GetAwards()

	arg_25_0.awardList:make(function(arg_26_0, arg_26_1, arg_26_2)
		if arg_26_0 == UIItemList.EventUpdate then
			updateDrop(arg_26_2, {
				type = var_25_0[arg_26_1 + 1][1],
				id = var_25_0[arg_26_1 + 1][2],
				count = var_25_0[arg_26_1 + 1][3]
			})
			onButton(arg_25_0, arg_26_2, function()
				arg_25_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_25_0.awardList:align(#arg_25_0.bossMission:GetAwards())

	arg_25_0.titleTxt.text = arg_25_0.bossMission:GetName()

	return
end

function var_0_0.UpdateFleet(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.contextData.editBossFleet and arg_28_0.contextData.editBossFleet[arg_28_1] and arg_28_0.contextData.editBossFleet[arg_28_1] or arg_28_0.bossMission:GetFleetByIndex(arg_28_1)

	arg_28_0.fleet = var_28_0

	arg_28_0:UpdateShips(var_28_0)
	arg_28_0:UpdateCommanders(var_28_0)

	arg_28_0.contextData.bossFormationIndex = arg_28_1

	setActive(arg_28_0.nextBtn, arg_28_1 == GuildBossMission.MAIN_FLEET_ID)
	setActive(arg_28_0.prevBtn, arg_28_1 == GuildBossMission.SUB_FLEET_ID)
	arg_28_0:UpdateSubToggle()

	return
end

function var_0_0.UpdateCommanders(arg_29_0, arg_29_1)
	if arg_29_0.isOpenCommander then
		arg_29_0.commanderPage:ExecuteAction("Update", arg_29_1, (getProxy(CommanderProxy):getPrefabFleet()))
	end

	return
end

function var_0_0.UpdateShips(arg_30_0, arg_30_1)
	arg_30_0:ClearShips()

	local var_30_0 = {}
	local var_30_1 = {}

	for iter_30_0, iter_30_1 in ipairs((arg_30_1:GetShips())) do
		if iter_30_1 and iter_30_1.ship then
			local var_30_2 = iter_30_1.ship:getTeamType()

			if var_30_2 == TeamType.Vanguard then
				table.insert({}, iter_30_1)
			elseif var_30_2 == TeamType.Main then
				table.insert(var_30_0, iter_30_1)
			elseif var_30_2 == TeamType.Submarine then
				table.insert(var_30_1, iter_30_1)
			end
		end
	end

	local var_30_3 = arg_30_1:IsMainFleet()

	if var_30_3 then
		arg_30_0:UpdateMainFleetShips(var_30_0, {})
	else
		arg_30_0:UpdateSubFleetShips(var_30_1)
	end

	setActive(arg_30_0.flag, var_30_3 and #var_30_0 > 0)
	setActive(arg_30_0.subFlag, not var_30_3 and #var_30_1 > 0)
	setActive(arg_30_0.grids, var_30_3)
	setActive(arg_30_0.subGrids, not var_30_3)

	return
end

function var_0_0.UpdateMainFleetShips(arg_31_0, arg_31_1, arg_31_2)
	for iter_31_0 = 1, 3 do
		arg_31_0:UpdateShip(iter_31_0, arg_31_0.grids:Find(iter_31_0), TeamType.Main, arg_31_1[iter_31_0])
	end

	for iter_31_1 = 4, 6 do
		arg_31_0:UpdateShip(iter_31_1, arg_31_0.grids:Find(iter_31_1), TeamType.Vanguard, arg_31_2[iter_31_1 - 3])
	end

	return
end

function var_0_0.UpdateSubFleetShips(arg_32_0, arg_32_1)
	for iter_32_0 = 1, 3 do
		arg_32_0:UpdateShip(iter_32_0, arg_32_0.subGrids:Find(iter_32_0), TeamType.Submarine, arg_32_1[iter_32_0])
	end

	return
end

function var_0_0.UpdateShip(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	local var_33_0 = arg_33_2:Find("Image")

	if arg_33_4 then
		local var_33_1 = SpineAnimChar.New()

		var_33_1:SetPaint((arg_33_4.ship:getPrefab()))
		var_33_1:Load(true, function(arg_34_0)
			arg_34_0:SetName(var_0)
			arg_34_0:SetParent(arg_33_2.parent)

			local var_34_0 = GuildBossFormationShipCard.New(arg_34_0)

			var_34_0:Update(var_0, arg_33_1)
			arg_34_0:SetAction("stand", 0)

			local var_34_1 = GetOrAddComponent(arg_34_0:GetModel(), "EventTriggerListener")

			var_34_1:AddPointClickFunc(function(arg_35_0, arg_35_1)
				if arg_33_0.dragging then
					return
				end

				arg_33_0:emit(GuildEventMediator.ON_SELECT_BOSS_SHIP, arg_33_3, arg_33_0.fleet.id, arg_33_4)

				return
			end)
			var_34_1:AddBeginDragFunc(function(arg_36_0, arg_36_1)
				arg_33_0.dragging = true

				arg_36_0.transform:SetAsLastSibling()
				arg_34_0:SetAction("tuozhuai", 0)

				return
			end)
			var_34_1:AddDragFunc(function(arg_37_0, arg_37_1)
				var_34_0:SetLocalPosition((var_0_0.Scr2Lpos(arg_33_2.parent, arg_37_1.position)))

				local var_37_0 = arg_33_0:GetNearestCard(var_34_0)

				if var_37_0 then
					arg_33_0:SwopCardSolt(var_37_0, var_34_0)
				end

				return
			end)
			var_34_1:AddDragEndFunc(function(arg_38_0, arg_38_1)
				arg_33_0.dragging = false

				var_34_0:RefreshPosition(var_34_0:GetSoltIndex(), true)
				arg_34_0:SetAction("stand", 0)
				arg_33_0:RefreshFleet()

				return
			end)
			table.insert(arg_33_0.shipCards, var_34_0)

			return
		end)
	else
		onButton(arg_33_0, var_33_0, function()
			arg_33_0:emit(GuildEventMediator.ON_SELECT_BOSS_SHIP, arg_33_3, arg_33_0.fleet.id)

			return
		end, SFX_PANEL)
	end

	setActive(var_33_0, not arg_33_4)

	return
end

function var_0_0.GetNearestCard(arg_40_0, arg_40_1)
	for iter_40_0, iter_40_1 in ipairs(arg_40_0.shipCards) do
		if iter_40_1:GetSoltIndex() ~= arg_40_1:GetSoltIndex() and iter_40_1.teamType == arg_40_1.teamType and Vector2.Distance(arg_40_1:GetLocalPosition(), iter_40_1:GetLocalPosition()) <= 50 then
			return iter_40_1
		end
	end

	return nil
end

function var_0_0.SwopCardSolt(arg_41_0, arg_41_1, arg_41_2)
	arg_41_1:RefreshPosition(arg_41_2:GetSoltIndex(), true)
	arg_41_2:RefreshPosition(arg_41_1:GetSoltIndex(), false)

	return
end

function var_0_0.RefreshFleet(arg_42_0)
	for iter_42_0, iter_42_1 in ipairs(arg_42_0.shipCards) do
		table.insert({}, {
			index = iter_42_1:GetSoltIndex(),
			shipId = iter_42_1.shipId
		})
	end

	table.sort({}, function(arg_43_0, arg_43_1)
		return arg_43_0.index < arg_43_1.index
	end)

	arg_42_0.contextData.editBossFleet = arg_42_0.contextData.editBossFleet or {}

	if not arg_42_0.contextData.editBossFleet[arg_42_0.fleet.id] then
		arg_42_0.contextData.editBossFleet[arg_42_0.fleet.id] = Clone(arg_42_0.fleet)
		arg_42_0.fleet = arg_42_0.contextData.editBossFleet[arg_42_0.fleet.id]
	end

	arg_42_0.fleet:ResortShips({})

	return
end

function var_0_0.ClearShips(arg_44_0)
	for iter_44_0, iter_44_1 in ipairs(arg_44_0.shipCards) do
		iter_44_1:Dispose()
	end

	arg_44_0.shipCards = {}

	return
end

function var_0_0.OnDestroy(arg_45_0)
	var_0_0.super.OnDestroy(arg_45_0)
	arg_45_0:ClearShips()
	arg_45_0.commanderPage:Destroy()

	return
end

function var_0_0.Scr2Lpos(arg_46_0, arg_46_1)
	return (LuaHelper.ScreenToLocal(arg_46_0:GetComponent("RectTransform"), arg_46_1, (GameObject.Find("OverlayCamera"):GetComponent("Camera"))))
end

return var_0_0

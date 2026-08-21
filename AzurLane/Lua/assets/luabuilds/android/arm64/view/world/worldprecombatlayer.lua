local var_0_0 = class("WorldPreCombatLayer", import("..base.BaseUI"))
local var_0_1 = import("..ship.FormationUI")

var_0_0.optionsPath = {
	"adapt/top/option"
}

function var_0_0.getUIName(arg_1_0)
	return "WorldPreCombatUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.eventTriggers = {}
	arg_2_0.middle = arg_2_0._tf:Find("adapt/middle")
	arg_2_0.right = arg_2_0._tf:Find("adapt/right")
	arg_2_0.top = arg_2_0._tf:Find("adapt/top")
	arg_2_0.moveLayer = arg_2_0._tf:Find("adapt/moveLayer")
	arg_2_0.backBtn = arg_2_0.top:Find("back_btn")
	arg_2_0.playerResOb = arg_2_0.top:Find("playerRes")
	arg_2_0.resPanel = WorldResource.New()

	tf(arg_2_0.resPanel._go):SetParent(tf(arg_2_0.playerResOb), false)

	arg_2_0.strategyInfo = arg_2_0.top:Find("strategy_info")

	setActive(arg_2_0.strategyInfo, false)

	arg_2_0.mainGS = arg_2_0.middle:Find("gear_score/main/Text")
	arg_2_0.vanguardGS = arg_2_0.middle:Find("gear_score/vanguard/Text")

	setText(arg_2_0.mainGS, 0)
	setText(arg_2_0.vanguardGS, 0)

	arg_2_0.gridTFs = {
		vanguard = {},
		main = {}
	}
	arg_2_0.gridFrame = arg_2_0.middle:Find("mask/GridFrame")

	for iter_2_0 = 1, 3 do
		arg_2_0.gridTFs[TeamType.Vanguard][iter_2_0] = arg_2_0.gridFrame:Find("vanguard_" .. iter_2_0)
		arg_2_0.gridTFs[TeamType.Main][iter_2_0] = arg_2_0.gridFrame:Find("main_" .. iter_2_0)
	end

	arg_2_0.heroContainer = arg_2_0.middle:Find("HeroContainer")
	arg_2_0.strategy = arg_2_0.middle:Find("strategy")

	setActive(arg_2_0.strategy, false)

	arg_2_0.fleet = arg_2_0.middle:Find("fleet")
	arg_2_0.ship_tpl = findTF(arg_2_0.fleet, "shiptpl")
	arg_2_0.empty_tpl = findTF(arg_2_0.fleet, "emptytpl")

	setActive(arg_2_0.ship_tpl, false)
	setActive(arg_2_0.empty_tpl, false)

	arg_2_0.autoToggle = arg_2_0.right:Find("auto_toggle")
	arg_2_0.autoSubToggle = arg_2_0.right:Find("sub_toggle_container/sub_toggle")
	arg_2_0.startBtn = arg_2_0.right:Find("start")
	arg_2_0.infoBtn = arg_2_0.right:Find("information")
	arg_2_0.heroInfo = arg_2_0:getTpl("heroInfo")
	arg_2_0.starTpl = arg_2_0:getTpl("star_tpl")
	arg_2_0.energyDescTF = arg_2_0._tf:Find("energy_desc")
	arg_2_0.energyDescTextTF = arg_2_0._tf:Find("energy_desc/Text")
	arg_2_0.normaltab = arg_2_0.right:Find("normal")
	arg_2_0.informationtab = arg_2_0.right:Find("infomation")
	arg_2_0.buffInfo = arg_2_0.normaltab:Find("buff")
	arg_2_0.bossInfo = arg_2_0.normaltab:Find("boss")
	arg_2_0.spoilsContainer = arg_2_0.normaltab:Find("spoils/items/items_container")
	arg_2_0.spoilsItem = arg_2_0.normaltab:Find("spoils/items/item_tpl")
	arg_2_0.digits = arg_2_0.Clone2Full(arg_2_0.informationtab:Find("target/simple/digits"), 3)
	arg_2_0.digitExtras = arg_2_0.Clone2Full(arg_2_0.informationtab:Find("target/detail"), 3)
	arg_2_0.dropright = arg_2_0.informationtab:Find("spoils/right")
	arg_2_0.dropleft = arg_2_0.informationtab:Find("spoils/left")
	arg_2_0.dropitems = arg_2_0.Clone2Full(arg_2_0.informationtab:Find("spoils/items_container"), 3)

	setActive(arg_2_0.informationtab:Find("target/simple"), true)
	setActive(arg_2_0.informationtab:Find("target/detail"), false)

	for iter_2_1 = 1, #arg_2_0.digitExtras do
		setText(arg_2_0.digitExtras[iter_2_1]:Find("desc"), i18n("world_mapbuff_compare_txt") .. "：")
	end

	return
end

function var_0_0.uiStartAnimating(arg_3_0)
	setAnchoredPosition(arg_3_0.middle, {
		x = -840
	})
	setAnchoredPosition(arg_3_0.right, {
		x = 470
	})
	setAnchoredPosition(arg_3_0.top, {
		y = arg_3_0.top.rect.height
	})
	shiftPanel(arg_3_0.middle, 0, nil, 0.3, 0, true, true)
	shiftPanel(arg_3_0.right, 0, nil, 0.3, 0, true, true, nil)
	shiftPanel(arg_3_0.top, nil, 0, 0.3, 0, true, true, nil, nil)

	return
end

function var_0_0.uiExitAnimating(arg_4_0)
	shiftPanel(arg_4_0.middle, -840, nil, 0.3, 0, true, true)
	shiftPanel(arg_4_0.right, 470, nil, 0.3, 0, true, true)
	shiftPanel(arg_4_0.top, nil, arg_4_0.top.rect.height, 0.3, 0, true, true, nil, nil)

	return
end

function var_0_0.didEnter(arg_5_0)
	onButton(arg_5_0, arg_5_0.backBtn, function()
		GetOrAddComponent(arg_5_0._tf, typeof(CanvasGroup)).interactable = false

		arg_5_0:uiExitAnimating()
		LeanTween.delayedCall(0.3, System.Action(function()
			arg_5_0:emit(var_0_0.ON_CLOSE)

			return
		end))

		return
	end, SFX_CANCEL)
	onToggle(arg_5_0, arg_5_0.autoToggle, function(arg_8_0)
		arg_5_0:emit(WorldPreCombatMediator.OnAuto, {
			isOn = not arg_8_0,
			toggle = arg_5_0.autoToggle
		})

		if arg_8_0 then
			if nowWorld():GetSubAidFlag() then
				setActive(arg_5_0.autoSubToggle, true)
				onToggle(arg_5_0, arg_5_0.autoSubToggle, function(arg_9_0)
					arg_5_0:emit(WorldPreCombatMediator.OnSubAuto, {
						isOn = not arg_9_0,
						toggle = arg_5_0.autoSubToggle
					})

					return
				end, SFX_PANEL, SFX_PANEL)
				triggerToggle(arg_5_0.autoSubToggle, ys.Battle.BattleState.IsAutoSubActive(SYSTEM_WORLD))

				goto label_8_0
			end
		end

		setActive(arg_5_0.autoSubToggle, false)

		::label_8_0::

		return
	end, SFX_PANEL, SFX_PANEL)
	arg_5_0:OverlayPanel(arg_5_0._tf)
	arg_5_0:updateCharacters()
	arg_5_0:updateStageView()
	triggerToggle(arg_5_0.autoToggle, ys.Battle.BattleState.IsAutoBotActive(SYSTEM_WORLD))

	local var_5_0 = arg_5_0:GetCurrentAttachment()
	local var_5_1 = arg_5_0:GetCurrentAttachment():GetBattleStageId()

	assert(pg.expedition_data_template[var_5_1], "expedition_data_template not exist: " .. var_5_1)

	local var_5_2

	if pg.world_expedition_data[var_5_1] then
		::label_5_0::

		var_5_2 = pg.world_expedition_data[var_5_1].battle_type and pg.world_expedition_data[var_5_1].battle_type ~= 0
	end

	onNextTick(function()
		arg_5_0:uiStartAnimating()

		return
	end)

	arg_5_0.contextData.entetagain = true

	setActive(arg_5_0.infoBtn, var_5_2)
	onButton(arg_5_0, arg_5_0.infoBtn, function()
		arg_5_0:emit(WorldPreCombatMediator.OnOpenSublayer, Context.New({
			mediator = WorldBossInformationMediator,
			viewComponent = WorldBossInformationLayer
		}), true, function()
			arg_5_0:closeView()

			return
		end)

		return
	end)
	onButton(arg_5_0, arg_5_0.startBtn, function()
		arg_5_0:emit(WorldPreCombatMediator.OnStartBattle, var_5_0:GetBattleStageId(), arg_5_0:getCurrentFleet(), var_5_0)

		return
	end, SFX_UI_WEIGHANCHOR)

	return
end

function var_0_0.onBackPressed(arg_14_0)
	if arg_14_0.strategyPanel and arg_14_0.strategyPanel._go and isActive(arg_14_0.strategyPanel._go) then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		arg_14_0:hideStrategyInfo()
	else
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		triggerButton(arg_14_0.backBtn)
	end

	return
end

function var_0_0.setPlayerInfo(arg_15_0, arg_15_1)
	arg_15_0.resPanel:setPlayer(arg_15_1)
	setActive(arg_15_0.resPanel._tf, nowWorld():IsSystemOpen(WorldConst.SystemResource))

	return
end

function var_0_0.getCurrentFleet(arg_16_0)
	return nowWorld():GetFleet()
end

function var_0_0.GetCurrentAttachment(arg_17_0)
	local var_17_9000
	local var_17_0 = nowWorld()
	local var_17_1 = var_17_0.GetActiveMap(var_17_9000)
	local var_17_2 = var_17_1:GetFleet()

	return var_17_1:GetCell(var_17_2.row, var_17_2.column).GetAliveAttachment(var_17_0), var_17_1.config.difficulty
end

function var_0_0.updateStageView(arg_18_0)
	setActive(arg_18_0.normaltab, false)
	setActive(arg_18_0.informationtab, true)
	arg_18_0:UpdateInformationtab()

	return
end

function var_0_0.UpdateNormaltab(arg_19_0)
	local var_19_0, var_19_1 = arg_19_0:GetCurrentAttachment()
	local var_19_2 = {}

	for iter_19_0, iter_19_1 in ipairs(pg.world_expedition_data[var_19_0:GetBattleStageId()].award_display_world) do
		if var_19_1 == iter_19_1[1] then
			var_19_2 = iter_19_1[2]
		end
	end

	local var_19_3 = UIItemList.New(arg_19_0.spoilsContainer, arg_19_0.spoilsItem)

	var_19_3:make(function(arg_20_0, arg_20_1, arg_20_2)
		updateDrop(arg_20_2, {
			type = var_19_2[arg_20_1 + 1][1],
			id = var_19_2[arg_20_1 + 1][2]
		})
		onButton(arg_19_0, arg_20_2, function()
			arg_19_0:emit(var_0_0.ON_DROP, var_0)

			return
		end, SFX_PANEL)

		return
	end)
	var_19_3:align(#var_19_2)

	return
end

local var_0_3 = "fe2222"
local var_0_4 = "92fc63"

function var_0_0.UpdateInformationtab(arg_22_0)
	local var_22_0, var_22_1 = arg_22_0:GetCurrentAttachment()
	local var_22_2 = var_22_0:GetBattleStageId()

	assert(pg.world_expedition_data[var_22_2], "world_expedition_data not exist: " .. var_22_2)

	local var_22_3 = {}

	for iter_22_0, iter_22_1 in ipairs(pg.world_expedition_data[var_22_2].award_display_world) do
		if var_22_1 == iter_22_1[1] then
			var_22_3 = iter_22_1[2]
		end
	end

	local var_22_4 = 0

	local function var_22_5()
		for iter_23_0 = 1, #arg_22_0.dropitems do
			local var_23_0 = arg_22_0.dropitems[iter_23_0]:Find("item_tpl")
			local var_23_1 = var_22_3[iter_23_0 + var_22_4]

			setActive(var_23_0, var_22_3[iter_23_0 + var_22_4] ~= nil)

			if var_23_1 then
				local var_23_2 = {
					type = var_23_1[1],
					id = var_23_1[2]
				}

				updateDrop(var_23_0, {
					type = var_23_1[1],
					id = var_23_1[2]
				})
				setScrollText(var_23_0:Find("ScrollMask/DropName"), ({
					type = var_23_1[1],
					id = var_23_1[2]
				}):getConfig("name"))
				onButton(arg_22_0, var_23_0, function()
					arg_22_0:emit(var_0_0.ON_DROP, var_23_2)

					return
				end, SFX_PANEL)
			end
		end

		setActive(arg_22_0.dropleft, var_22_4 > 0)
		setActive(arg_22_0.dropright, #var_22_3 - var_22_4 > #arg_22_0.dropitems)

		return
	end

	onButton(arg_22_0, arg_22_0.dropright, function()
		var_22_4 = var_22_4 + 1

		var_22_5()

		return
	end)
	onButton(arg_22_0, arg_22_0.dropleft, function()
		var_22_4 = var_22_4 - 1

		var_22_5()

		return
	end)
	;(function()
		for iter_23_0 = 1, #arg_22_0.dropitems do
			local var_23_0 = arg_22_0.dropitems[iter_23_0]:Find("item_tpl")
			local var_23_1 = var_22_3[iter_23_0 + var_22_4]

			setActive(var_23_0, var_22_3[iter_23_0 + var_22_4] ~= nil)

			if var_23_1 then
				local var_23_2 = {
					type = var_23_1[1],
					id = var_23_1[2]
				}

				updateDrop(var_23_0, {
					type = var_23_1[1],
					id = var_23_1[2]
				})
				setScrollText(var_23_0:Find("ScrollMask/DropName"), ({
					type = var_23_1[1],
					id = var_23_1[2]
				}):getConfig("name"))
				onButton(arg_22_0, var_23_0, function()
					arg_22_0:emit(var_0_0.ON_DROP, var_23_2)

					return
				end, SFX_PANEL)
			end
		end

		setActive(arg_22_0.dropleft, var_22_4 > 0)
		setActive(arg_22_0.dropright, #var_22_3 - var_22_4 > #arg_22_0.dropitems)

		return
	end)()

	local var_22_6 = nowWorld()
	local var_22_7 = var_22_6:GetWorldMapDifficultyBuffLevel()
	local var_22_8 = var_22_6:GetWorldMapBuffLevel()
	local var_22_9, var_22_10, var_22_11 = ys.Battle.BattleFormulas.WorldMapRewardAttrEnhance({
		var_22_7[1] * (1 + pg.world_expedition_data[var_22_2].expedition_sairenvalueA / 16),
		var_22_7[2] * (1 + pg.world_expedition_data[var_22_2].expedition_sairenvalueB / 16),
		var_22_7[3] * (1 + pg.world_expedition_data[var_22_2].expedition_sairenvalueC / 16)
	}, var_22_8)
	local var_22_12 = {
		var_22_9,
		var_22_10,
		1 - ys.Battle.BattleFormulas.WorldMapRewardHealingRate({
			var_22_7[1] * (1 + pg.world_expedition_data[var_22_2].expedition_sairenvalueA / 16),
			var_22_7[2] * (1 + pg.world_expedition_data[var_22_2].expedition_sairenvalueB / 16),
			var_22_7[3] * (1 + pg.world_expedition_data[var_22_2].expedition_sairenvalueC / 16)
		}, var_22_8)
	}

	for iter_22_2 = 1, #arg_22_0.digits do
		setText(arg_22_0.digits[iter_22_2]:Find("digit"), string.format("%d", ({
			var_22_7[1] * (1 + pg.world_expedition_data[var_22_2].expedition_sairenvalueA / 16),
			var_22_7[2] * (1 + pg.world_expedition_data[var_22_2].expedition_sairenvalueB / 16),
			var_22_7[3] * (1 + pg.world_expedition_data[var_22_2].expedition_sairenvalueC / 16)
		})[iter_22_2]))

		if iter_22_2 == 3 then
			local var_22_14 = 1 - var_22_12[iter_22_2] or var_22_12[iter_22_2] + 1

			setText(var_22_13:Find("desc"), i18n("world_mapbuff_attrtxt_" .. iter_22_2) .. string.format("%3d%%", var_22_14 * 100))
		end
	end

	for iter_22_3 = 1, #arg_22_0.digitExtras do
		setText(arg_22_0.digitExtras[iter_22_3]:Find("enemy"), string.format("%d", ({
			var_22_7[1] * (1 + pg.world_expedition_data[var_22_2].expedition_sairenvalueA / 16),
			var_22_7[2] * (1 + pg.world_expedition_data[var_22_2].expedition_sairenvalueB / 16),
			var_22_7[3] * (1 + pg.world_expedition_data[var_22_2].expedition_sairenvalueC / 16)
		})[iter_22_3]))
		setText(var_22_15:Find("ally"), string.format("%d", var_22_8[iter_22_3]))
		setText(var_22_15:Find("result"), string.format("%d%%", var_22_12[iter_22_3] * 100))

		local var_22_16 = var_22_12[iter_22_3] > 0 and arg_22_0.TransformColor(var_0_3) or arg_22_0.TransformColor(var_0_4)

		setTextColor(var_22_15:Find("result"), var_22_16)
		setText(var_22_15:Find("result/arrow"), var_22_12[iter_22_3] == 0 and "" or var_22_12[iter_22_3] > 0 and "↑" or "↓")

		if var_22_12[iter_22_3] ~= 0 then
			local var_22_17 = var_22_12[iter_22_3] > 0 and arg_22_0.TransformColor(var_0_3) or arg_22_0.TransformColor(var_0_4)

			setTextColor(var_22_15:Find("result/arrow"), var_22_17)
		end
	end

	onButton(arg_22_0, arg_22_0.informationtab:Find("target/bg"), function()
		local var_27_0 = arg_22_0.informationtab:Find("target/simple")
		local var_27_1 = go(var_27_0).activeSelf

		setActive(var_27_0, not var_27_1)
		setActive(arg_22_0.informationtab:Find("target/detail"), var_27_1)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateCharacters(arg_28_0)
	pg.UIMgr.GetInstance():LoadingOn()
	arg_28_0:resetGrid(TeamType.Vanguard)
	arg_28_0:resetGrid(TeamType.Main)
	arg_28_0:loadAllCharacter(function()
		arg_28_0:updateFleetView()
		arg_28_0:displayFleetInfo()
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)

	return
end

function var_0_0.flushCharacters(arg_30_0)
	arg_30_0:resetGrid(TeamType.Vanguard)
	arg_30_0:resetGrid(TeamType.Main)
	arg_30_0:setAllCharacterPos(true)
	arg_30_0:updateFleetView()

	return
end

function var_0_0.updateFleetView(arg_31_0)
	local var_31_0 = arg_31_0:getCurrentFleet()

	;(function(arg_32_0, arg_32_1)
		removeAllChildren(arg_32_0)

		for iter_32_0 = 1, 3 do
			if arg_32_1[iter_32_0] then
				local var_32_0 = cloneTplTo(arg_31_0.ship_tpl, arg_32_0)

				updateShip(var_32_0, arg_32_1[iter_32_0])

				local var_32_1 = WorldConst.FetchWorldShip(arg_32_1[iter_32_0].id)
				local var_32_2 = var_32_1:IsHpSafe()
				local var_32_3 = var_32_1:IsAlive()
				local var_32_4 = findTF(var_32_0, "blood/fillarea/green")
				local var_32_5 = findTF(var_32_0, "blood/fillarea/red")

				setActive(var_32_4, var_32_2)
				setActive(var_32_5, not var_32_2)

				;(var_32_2 and var_32_4 or var_32_5):GetComponent("Image").fillAmount = var_32_1.hpRant * 0.0001

				setActive(var_32_0:Find("broken"), var_32_1:IsBroken())
				setActive(var_32_0:Find("mask"), not var_32_3)
			end
		end

		return
	end)(arg_31_0.fleet:Find("main"), var_31_0:GetTeamShipVOs(TeamType.Main, true))
	;(function(arg_32_0, arg_32_1)
		removeAllChildren(arg_32_0)

		for iter_32_0 = 1, 3 do
			if arg_32_1[iter_32_0] then
				local var_32_0 = cloneTplTo(arg_31_0.ship_tpl, arg_32_0)

				updateShip(var_32_0, arg_32_1[iter_32_0])

				local var_32_1 = WorldConst.FetchWorldShip(arg_32_1[iter_32_0].id)
				local var_32_2 = var_32_1:IsHpSafe()
				local var_32_3 = var_32_1:IsAlive()
				local var_32_4 = findTF(var_32_0, "blood/fillarea/green")
				local var_32_5 = findTF(var_32_0, "blood/fillarea/red")

				setActive(var_32_4, var_32_2)
				setActive(var_32_5, not var_32_2)

				;(var_32_2 and var_32_4 or var_32_5):GetComponent("Image").fillAmount = var_32_1.hpRant * 0.0001

				setActive(var_32_0:Find("broken"), var_32_1:IsBroken())
				setActive(var_32_0:Find("mask"), not var_32_3)
			end
		end

		return
	end)(arg_31_0.fleet:Find("vanguard"), var_31_0:GetTeamShipVOs(TeamType.Vanguard, true))

	return
end

function var_0_0.loadAllCharacter(arg_33_0, arg_33_1)
	removeAllChildren(arg_33_0.heroContainer)

	arg_33_0.characterList = {
		[TeamType.Vanguard] = {},
		[TeamType.Main] = {}
	}

	local function var_33_0(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
		local var_34_9000

		if arg_33_0.exited then
			arg_34_0:Dispose()

			return
		end

		local var_34_0 = arg_34_0:GetRootModel()
		local var_34_1 = WorldConst.FetchWorldShip(arg_34_1.id)

		arg_33_0.characterList[arg_34_2][arg_34_3] = arg_34_0

		arg_34_0:SetParent(arg_33_0.heroContainer, false)
		arg_34_0:SetModelScale(Vector3(0.65, 0.65, 1))
		pg.ViewUtils.SetLayer(tf(var_34_0), Layer.UI)
		arg_33_0:enabledCharacter(arg_34_0, true, arg_34_2)
		arg_33_0:setCharacterPos(arg_34_2, arg_34_3, arg_34_0)
		arg_33_0:sortSiblingIndex()

		local var_34_2 = cloneTplTo(arg_33_0.heroInfo, var_34_0)

		setAnchoredPosition(var_34_2, {
			x = 0,
			y = 0
		})

		var_34_2.localScale = Vector3(2, 2, 1)

		SetActive(var_34_2, true)

		var_34_2.name = "info"

		local var_34_3 = findTF(var_34_2, "info")
		local var_34_4 = findTF(var_34_3, "stars")
		local var_34_5 = arg_34_1:getEnergy() <= Ship.ENERGY_MID
		local var_34_6 = findTF(var_34_3, "energy")

		if var_34_5 then
			local var_34_7, var_34_8 = arg_34_1:getEnergyPrint()
			local var_34_9 = GetSpriteFromAtlas("energy", var_34_7)

			if not var_34_9 then
				warning("找不到疲劳")
			end

			setImageSprite(var_34_6, var_34_9)
		end

		setActive(var_34_6, var_34_5)

		for iter_34_0 = 1, arg_34_1:getStar() do
			cloneTplTo(arg_33_0.starTpl, var_34_4)
		end

		local var_34_10 = GetSpriteFromAtlas("shiptype", shipType2print(arg_34_1:getShipType()))

		if not var_34_10 then
			warning("找不到船形, shipConfigId: " .. arg_34_1.configId)
		end

		setImageSprite(findTF(var_34_3, "type"), var_34_10, true)
		setText(findTF(var_34_3, "frame/lv_contain/lv"), arg_34_1.level)

		local var_34_11 = var_34_1:IsHpSafe()
		local var_34_12 = findTF(var_34_3, "blood")
		local var_34_13 = findTF(var_34_12, "fillarea/green")
		local var_34_14 = findTF(var_34_12, "fillarea/red")

		setActive(var_34_13, var_34_11)
		setActive(var_34_14, not var_34_11)

		var_34_12:GetComponent(typeof(Slider)).fillRect = var_34_11 and var_34_13 or var_34_14

		setSlider(var_34_12, 0, 10000, var_34_1.hpRant)
		setActive(var_34_12:Find("broken"), var_34_1:IsBroken())

		local var_34_15 = getProxy(ActivityProxy)
		local var_34_16 = var_34_15.getBuffShipList(var_34_9000)[arg_34_1:getGroupId()]
		local var_34_17 = var_34_3:Find("expbuff")

		setActive(var_34_15, var_34_16 ~= nil)

		if var_34_16 then
			local var_34_18 = tostring(var_34_16 / 100)

			if var_34_16 % 100 > 0 then
				var_34_18 = var_34_18 .. "." .. tostring(var_34_16 % 100)
			end

			setText(var_34_17:Find("text"), string.format("EXP +%s%%", var_34_18))
		end

		return
	end

	local var_33_1 = {}

	;(function(arg_35_0)
		for iter_35_0, iter_35_1 in ipairs((arg_33_0:getCurrentFleet():GetTeamShipVOs(arg_35_0, false))) do
			table.insert(var_33_1, function(arg_36_0)
				local var_36_0 = SpineRole.New(iter_35_1)

				SpineRole.New(iter_35_1):LoadLite(function()
					var_33_0(var_36_0, iter_35_1, arg_35_0, iter_35_0)
					onNextTick(arg_36_0)

					return
				end)

				return
			end)
		end

		return
	end)(TeamType.Vanguard)
	;(function(arg_35_0)
		for iter_35_0, iter_35_1 in ipairs((arg_33_0:getCurrentFleet():GetTeamShipVOs(arg_35_0, false))) do
			table.insert(var_33_1, function(arg_36_0)
				local var_36_0 = SpineRole.New(iter_35_1)

				SpineRole.New(iter_35_1):LoadLite(function()
					var_33_0(var_36_0, iter_35_1, arg_35_0, iter_35_0)
					onNextTick(arg_36_0)

					return
				end)

				return
			end)
		end

		return
	end)(TeamType.Main)
	seriesAsync({}, function(arg_38_0)
		if arg_33_0.exited then
			return
		end

		if arg_33_1 then
			arg_33_1()
		end

		return
	end)

	return
end

function var_0_0.showEnergyDesc(arg_39_0, arg_39_1, arg_39_2)
	if LeanTween.isTweening(go(arg_39_0.energyDescTF)) then
		LeanTween.cancel(go(arg_39_0.energyDescTF))

		arg_39_0.energyDescTF.localScale = Vector3.one
	end

	setText(arg_39_0.energyDescTextTF, arg_39_2)

	arg_39_0.energyDescTF.position = arg_39_1

	setActive(arg_39_0.energyDescTF, true)
	LeanTween.scale(arg_39_0.energyDescTF, Vector3.zero, 0.2):setDelay(1):setFrom(Vector3.one):setOnComplete(System.Action(function()
		arg_39_0.energyDescTF.localScale = Vector3.one

		setActive(arg_39_0.energyDescTF, false)

		return
	end))

	return
end

function var_0_0.setAllCharacterPos(arg_41_0, arg_41_1)
	for iter_41_0, iter_41_1 in ipairs(arg_41_0.characterList[TeamType.Vanguard]) do
		arg_41_0:setCharacterPos(TeamType.Vanguard, iter_41_0, iter_41_1, arg_41_1)
	end

	for iter_41_2, iter_41_3 in ipairs(arg_41_0.characterList[TeamType.Main]) do
		arg_41_0:setCharacterPos(TeamType.Main, iter_41_2, iter_41_3, arg_41_1)
	end

	arg_41_0:sortSiblingIndex()

	return
end

function var_0_0.setCharacterPos(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	local var_42_0 = arg_42_3:GetRootModel()

	SetActive(var_42_0, true)
	LeanTween.cancel(go(var_42_0))

	if arg_42_4 then
		tf(var_42_0).localPosition = Vector3(arg_42_0.gridTFs[arg_42_1][arg_42_2].localPosition.x + 2, arg_42_0.gridTFs[arg_42_1][arg_42_2].localPosition.y - 80, arg_42_0.gridTFs[arg_42_1][arg_42_2].localPosition.z)

		LeanTween.moveLocalY(go(var_42_0), arg_42_0.gridTFs[arg_42_1][arg_42_2].localPosition.y - 110, 0.5):setDelay(0.5)
	else
		tf(var_42_0).localPosition = Vector3(arg_42_0.gridTFs[arg_42_1][arg_42_2].localPosition.x + 2, arg_42_0.gridTFs[arg_42_1][arg_42_2].localPosition.y - 110, arg_42_0.gridTFs[arg_42_1][arg_42_2].localPosition.z)
	end

	SetActive(var_42_1:Find("shadow"), true)
	arg_42_3:SetAction("stand", 0)

	return
end

function var_0_0.resetGrid(arg_43_0, arg_43_1)
	for iter_43_0, iter_43_1 in ipairs(arg_43_0.gridTFs[arg_43_1]) do
		SetActive(iter_43_1:Find("shadow"), false)
	end

	return
end

function var_0_0.switchToEditMode(arg_44_0)
	(function(arg_45_0)
		for iter_45_0, iter_45_1 in ipairs(arg_45_0) do
			local var_45_0 = tf((iter_45_1:GetRootModel())):Find("mouseChild")

			if var_45_0 then
				local var_45_1 = var_45_0:GetComponent("EventTriggerListener")

				arg_44_0.eventTriggers[var_45_1] = true

				if var_45_1 then
					var_45_1:RemovePointEnterFunc()
				end

				if iter_45_0 == arg_44_0._shiftIndex then
					var_45_0:GetComponent(typeof(Image)).enabled = true
				end
			end
		end

		return
	end)(arg_44_0.characterList[TeamType.Vanguard])
	;(function(arg_45_0)
		for iter_45_0, iter_45_1 in ipairs(arg_45_0) do
			local var_45_0 = tf((iter_45_1:GetRootModel())):Find("mouseChild")

			if var_45_0 then
				local var_45_1 = var_45_0:GetComponent("EventTriggerListener")

				arg_44_0.eventTriggers[var_45_1] = true

				if var_45_1 then
					var_45_1:RemovePointEnterFunc()
				end

				if iter_45_0 == arg_44_0._shiftIndex then
					var_45_0:GetComponent(typeof(Image)).enabled = true
				end
			end
		end

		return
	end)(arg_44_0.characterList[TeamType.Main])

	arg_44_0._shiftIndex = nil

	arg_44_0:flushCharacters()

	return
end

function var_0_0.switchToShiftMode(arg_46_0, arg_46_1, arg_46_2)
	for iter_46_0 = 1, 3 do
		setActive(arg_46_0.gridTFs[TeamType.Vanguard][iter_46_0]:Find("tip"), false)
		setActive(arg_46_0.gridTFs[TeamType.Main][iter_46_0]:Find("tip"), false)
		setActive(arg_46_0.gridTFs[arg_46_2][iter_46_0]:Find("shadow"), false)
	end

	for iter_46_1, iter_46_2 in ipairs(arg_46_0.characterList[arg_46_2]) do
		local var_46_0 = iter_46_2:GetRootModel()

		if var_46_0 ~= arg_46_1 then
			LeanTween.moveLocalY(var_46_0, arg_46_0.gridTFs[arg_46_2][iter_46_1].localPosition.y - 80, 0.5)

			local var_46_1 = tf(var_46_0):Find("mouseChild"):GetComponent("EventTriggerListener")

			arg_46_0.eventTriggers[var_46_1] = true

			var_46_1:AddPointEnterFunc(function()
				for iter_47_0, iter_47_1 in ipairs(var_0) do
					if iter_47_1:GetRootModel() == var_46_0 then
						arg_46_0:shift(arg_46_0._shiftIndex, iter_47_0, arg_46_2)

						break
					end
				end

				return
			end)
		else
			arg_46_0._shiftIndex = iter_46_1

			local var_46_2 = tf(var_46_0):Find("mouseChild")

			var_46_2:GetComponent(typeof(Image)).enabled = false
		end

		iter_46_2:SetAction("normal", 0)
	end

	return
end

function var_0_0.shift(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	local var_48_0 = arg_48_0.characterList[arg_48_3]
	local var_48_1 = arg_48_0.characterList[arg_48_3][arg_48_2]:GetRootModel()

	tf(var_48_1).localPosition = Vector3(arg_48_0.gridTFs[arg_48_3][arg_48_1].localPosition.x + 2, arg_48_0.gridTFs[arg_48_3][arg_48_1].localPosition.y - 80, arg_48_0.gridTFs[arg_48_3][arg_48_1].localPosition.z)

	LeanTween.cancel(var_48_1)

	var_48_0[arg_48_1], var_48_0[arg_48_2] = arg_48_0.characterList[arg_48_3][arg_48_2], arg_48_0.characterList[arg_48_3][arg_48_1]

	local var_48_2 = arg_48_0:getCurrentFleet()
	local var_48_3 = var_48_2:GetTeamShips(arg_48_3, false)

	var_48_2:SwitchShip(var_48_3[arg_48_1].id, var_48_3[arg_48_2].id)

	arg_48_0._shiftIndex = arg_48_2

	arg_48_0:sortSiblingIndex()

	return
end

function var_0_0.sortSiblingIndex(arg_49_0)
	local var_49_0 = 0

	while 3 > 0 do
		if arg_49_0.characterList[TeamType.Main][3] then
			tf((arg_49_0.characterList[TeamType.Main][3]:GetRootModel())):SetSiblingIndex(var_49_0)

			var_49_0 = var_49_0 + 1
		end

		if arg_49_0.characterList[TeamType.Vanguard][3] then
			tf((arg_49_0.characterList[TeamType.Vanguard][3]:GetRootModel())):SetSiblingIndex(var_49_0)

			var_49_0 = var_49_0 + 1
		end
	end

	return
end

function var_0_0.enabledTeamCharacter(arg_50_0, arg_50_1, arg_50_2)
	for iter_50_0, iter_50_1 in ipairs(arg_50_0.characterList[arg_50_1]) do
		arg_50_0:enabledCharacter(iter_50_1, arg_50_2, arg_50_1)
	end

	return
end

function var_0_0.enabledCharacter(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	if arg_51_2 then
		local var_51_0 = arg_51_1:GetRootModel()
		local var_51_1, var_51_2, var_51_3 = tf(var_51_0):Find("mouseChild")

		if var_51_1 then
			SetActive(var_51_1, true)
		else
			local var_51_4 = GameObject("mouseChild")

			tf(var_51_4):SetParent(tf(var_51_0))

			tf(var_51_4).localPosition = Vector3.zero

			local var_51_5 = GetOrAddComponent(var_51_4, "EventTriggerListener")

			arg_51_0.eventTriggers[var_51_5] = true

			GetOrAddComponent(var_51_4, "ModelDrag"):Init()

			local var_51_6 = var_51_4:GetComponent(typeof(RectTransform))

			var_51_6.sizeDelta = Vector2(2.5, 2.5)
			var_51_6.pivot = Vector2(0.5, 0)
			var_51_6.anchoredPosition = Vector2(0, 0)

			local var_51_7
			local var_51_8
			local var_51_9
			local var_51_10

			var_51_5:AddBeginDragFunc(function()
				var_51_7 = UnityEngine.Screen.width
				var_51_8 = UnityEngine.Screen.height
				var_51_9 = rtf(arg_51_0._tf).rect.width / var_51_7
				var_51_10 = rtf(arg_51_0._tf).rect.height / var_51_8

				LeanTween.cancel(go(var_51_0))
				arg_51_0:switchToShiftMode(var_51_0, arg_51_3)
				arg_51_1:SetAction("tuozhuai", 0)
				arg_51_1:SetParent(arg_51_0.moveLayer, false)
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_HOME_DRAG)

				return
			end)
			var_51_5:AddDragFunc(function(arg_53_0, arg_53_1)
				rtf(var_51_0).anchoredPosition = Vector2((arg_53_1.position.x - var_51_7 / 2) * var_51_9 + 20, (arg_53_1.position.y - var_51_8 / 2) * var_51_10 - 20)

				return
			end)
			var_51_5:AddDragEndFunc(function(arg_54_0, arg_54_1)
				arg_51_1:SetAction("tuozhuai", 0)
				tf(var_51_0):SetParent(arg_51_0.heroContainer, false)
				arg_51_0:switchToEditMode()
				arg_51_0:sortSiblingIndex()
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_HOME_PUT)

				return
			end)
		end
	else
		SetActive(tf(model):Find("mouseChild"), false)
	end

	return
end

function var_0_0.displayFleetInfo(arg_55_0)
	local var_55_0 = arg_55_0:getCurrentFleet()

	var_0_1.tweenNumText(arg_55_0.vanguardGS, (_.reduce(var_55_0:GetTeamShipVOs(TeamType.Vanguard, false), 0, function(arg_56_0, arg_56_1)
		return arg_56_0 + arg_56_1:getShipCombatPower()
	end)))
	var_0_1.tweenNumText(arg_55_0.mainGS, (_.reduce(var_55_0:GetTeamShipVOs(TeamType.Main, false), 0, function(arg_57_0, arg_57_1)
		return arg_57_0 + arg_57_1:getShipCombatPower()
	end)))

	return
end

function var_0_0.hideStrategyInfo(arg_58_0)
	if arg_58_0.strategyPanel then
		arg_58_0.strategyPanel:detach()
	end

	return
end

function var_0_0.recycleCharacterList(arg_59_0, arg_59_1, arg_59_2)
	for iter_59_0, iter_59_1 in ipairs(arg_59_1) do
		if arg_59_2[iter_59_0] then
			arg_59_2[iter_59_0]:Dispose()

			arg_59_2[iter_59_0] = nil
		end
	end

	return
end

function var_0_0.willExit(arg_60_0)
	arg_60_0:UnOverlayPanel(arg_60_0._tf)

	if arg_60_0.resPanel then
		arg_60_0.resPanel:exit()

		arg_60_0.resPanel = nil
	end

	if arg_60_0.eventTriggers then
		for iter_60_0, iter_60_1 in pairs(arg_60_0.eventTriggers) do
			ClearEventTrigger(iter_60_0)
		end

		arg_60_0.eventTriggers = nil
	end

	if arg_60_0.tweens then
		cancelTweens(arg_60_0.tweens)
	end

	local var_60_0 = arg_60_0:getCurrentFleet()

	arg_60_0:recycleCharacterList(var_60_0:GetTeamShipVOs(TeamType.Main, false), arg_60_0.characterList[TeamType.Main])
	arg_60_0:recycleCharacterList(var_60_0:GetTeamShipVOs(TeamType.Vanguard, false), arg_60_0.characterList[TeamType.Vanguard])

	return
end

function var_0_0.Clone2Full(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0:GetChild(0)

	for iter_61_0 = 0, arg_61_0.childCount - 1 do
		table.insert({}, arg_61_0:GetChild(iter_61_0))
	end

	for iter_61_1 = arg_61_0.childCount, arg_61_1 - 1 do
		table.insert({}, tf((cloneTplTo(var_61_0, arg_61_0))))
	end

	return {}
end

function var_0_0.TransformColor(arg_62_0)
	return Color.New(tonumber(string.sub(arg_62_0, 1, 2), 16) / 255, tonumber(string.sub(arg_62_0, 3, 4), 16) / 255, tonumber(string.sub(arg_62_0, 5, 6), 16) / 255)
end

return var_0_0

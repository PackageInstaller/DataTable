local var_0_0 = class("WorldDetailLayer", import("..base.BaseUI"))
local var_0_1 = import("..ship.FormationUI")

function var_0_0.getUIName(arg_1_0)
	return "WorldDetailUI"
end

var_0_0.TOGGLE_DETAIL = "detailToggle"
var_0_0.TOGGLE_FORMATION = "formationToggle"

function var_0_0.init(arg_2_0)
	arg_2_0.eventTriggers = {}
	arg_2_0.rtMain = arg_2_0._tf:Find("main")
	arg_2_0.bgFleet = arg_2_0.rtMain:Find("bg_fleet")
	arg_2_0.bgSub = arg_2_0.rtMain:Find("bg_sub")
	arg_2_0.vanguardGS = arg_2_0.rtMain:Find("gear_score/vanguard")
	arg_2_0.vanguardUpGS = arg_2_0.vanguardGS:Find("up")
	arg_2_0.vanguardDownGS = arg_2_0.vanguardGS:Find("down")
	arg_2_0.mainGS = arg_2_0.rtMain:Find("gear_score/main")
	arg_2_0.mainUpGS = arg_2_0.mainGS:Find("up")
	arg_2_0.mainDownGS = arg_2_0.mainGS:Find("down")
	arg_2_0.subGS = arg_2_0.rtMain:Find("gear_score/submarine")
	arg_2_0.subUpGS = arg_2_0.subGS:Find("up")
	arg_2_0.subDownGS = arg_2_0.subGS:Find("down")

	local var_2_0 = arg_2_0.contextData.mainGS or 0

	setText(arg_2_0.mainGS:Find("Text"), var_2_0)

	local var_2_1 = arg_2_0.contextData.vanGS or 0

	setText(arg_2_0.vanguardGS:Find("Text"), var_2_1)

	local var_2_2 = arg_2_0.contextData.subGS or 0

	setText(arg_2_0.subGS:Find("Text"), var_2_2)

	arg_2_0.gridTFs = {
		[TeamType.Vanguard] = {},
		[TeamType.Main] = {},
		[TeamType.Submarine] = {}
	}
	arg_2_0.gridFrame = arg_2_0.rtMain:Find("GridFrame")

	for iter_2_0 = 1, 3 do
		arg_2_0.gridTFs[TeamType.Vanguard][iter_2_0] = arg_2_0.gridFrame:Find("vanguard_" .. iter_2_0)
		arg_2_0.gridTFs[TeamType.Main][iter_2_0] = arg_2_0.gridFrame:Find("main_" .. iter_2_0)
		arg_2_0.gridTFs[TeamType.Submarine][iter_2_0] = arg_2_0.gridFrame:Find("submarine_" .. iter_2_0)
	end

	arg_2_0.nextPage = arg_2_0.rtMain:Find("nextPage")
	arg_2_0.prevPage = arg_2_0.rtMain:Find("prevPage")
	arg_2_0.heroContainer = arg_2_0.rtMain:Find("HeroContainer")
	arg_2_0.blurLayer = arg_2_0._tf:Find("blur_container")
	arg_2_0.top = arg_2_0.blurLayer:Find("top")
	arg_2_0.backBtn = arg_2_0.top:Find("back_btn")
	arg_2_0.playerResOb = arg_2_0.top:Find("res")
	arg_2_0.resPanel = WorldResource.New()

	tf(arg_2_0.resPanel._go):SetParent(tf(arg_2_0.playerResOb), false)

	arg_2_0.fleetToggleList = arg_2_0.blurLayer:Find("bottom/fleet_select/panel")
	arg_2_0.detailToggle = arg_2_0.blurLayer:Find("bottom/toggle_list/detail_toggle")
	arg_2_0.formationToggle = arg_2_0.blurLayer:Find("bottom/toggle_list/formation_toggle")
	arg_2_0.attrFrame = arg_2_0.blurLayer:Find("attr_frame")
	arg_2_0.cardTpl = arg_2_0._tf:Find("RectShipCardTpl")
	arg_2_0.cards = {}
	arg_2_0.cards[TeamType.Main] = {}
	arg_2_0.cards[TeamType.Vanguard] = {}
	arg_2_0.cards[TeamType.Submarine] = {}

	setActive(arg_2_0.attrFrame, false)
	setActive(arg_2_0.cardTpl, false)

	arg_2_0.heroInfo = arg_2_0._tf:Find("heroInfo")
	arg_2_0.starTpl = arg_2_0._tf:Find("star_tpl")
	arg_2_0.commanderFormationPanel = WorldCommanderFormationPage.New(arg_2_0._tf, arg_2_0.event, arg_2_0.contextData)
	arg_2_0.fleetIndex = 1
	arg_2_0.formationLogic = BaseFormation.New(arg_2_0._tf, arg_2_0.heroContainer, arg_2_0.heroInfo, arg_2_0.gridTFs)

	arg_2_0.formationLogic:DisableTip()
	arg_2_0:Register()

	return
end

function var_0_0.Register(arg_3_0)
	local var_3_0 = getProxy(ActivityProxy):getBuffShipList()

	arg_3_0.formationLogic:AddLoadComplete(function()
		arg_3_0:displayFleetInfo()
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)
	arg_3_0.formationLogic:AddHeroInfoModify(function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = WorldConst.FetchWorldShip(arg_5_1.id)
		local var_5_1 = arg_5_1:getConfigTable()
		local var_5_3 = findTF(arg_5_0, "info")
		local var_5_4 = findTF(var_5_3, "stars")
		local var_5_5 = findTF(var_5_3, "energy")

		for iter_5_0 = 1, arg_5_1:getStar() do
			cloneTplTo(arg_3_0.starTpl, var_5_4)
		end

		local var_5_6 = arg_5_1:getEnergy() <= Ship.ENERGY_MID
		local var_5_7 = findTF(var_5_3, "energy")

		if var_5_6 then
			local var_5_8, var_5_9 = arg_5_1:getEnergyPrint()
			local var_5_10 = GetSpriteFromAtlas("energy", var_5_8)

			if not var_5_10 then
				warning("找不到疲劳")
			end

			setImageSprite(var_5_7, var_5_10)
		end

		setActive(var_5_7, var_5_6)

		local var_5_11 = var_3_0[arg_5_1:getGroupId()]
		local var_5_12 = var_5_3:Find("expbuff")

		setActive(var_5_12, var_5_11 ~= nil)

		if var_5_11 then
			local var_5_13 = tostring(var_5_11 / 100)

			if var_5_11 % 100 > 0 then
				var_5_13 = var_5_13 .. "." .. tostring(var_5_11 % 100)
			end

			setText(var_5_12:Find("text"), string.format("EXP +%s%%", var_5_13))
		end

		local var_5_14 = GetSpriteFromAtlas("shiptype", shipType2print(arg_5_1:getShipType()))

		if not var_5_14 then
			warning("找不到船形, shipConfigId: " .. arg_5_1.configId)
		end

		setImageSprite(findTF(var_5_3, "type"), var_5_14, true)
		setText(findTF(var_5_3, "frame/lv_contain/lv"), arg_5_1.level)

		local var_5_15 = var_5_0:IsHpSafe()
		local var_5_16 = findTF(var_5_3, "blood")
		local var_5_17 = findTF(var_5_16, "fillarea/green")
		local var_5_18 = findTF(var_5_16, "fillarea/red")

		setActive(var_5_17, var_5_15)
		setActive(var_5_18, not var_5_15)

		var_5_16:GetComponent(typeof(Slider)).fillRect = var_5_15 and var_5_17 or var_5_18

		setSlider(var_5_16, 0, 10000, var_5_0.hpRant)
		setActive(var_5_16:Find("broken"), var_5_0:IsBroken())

		return
	end)
	arg_3_0.formationLogic:AddCheckRemove(function(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		arg_6_0()

		return
	end)
	arg_3_0.formationLogic:AddLongPress(function(arg_7_0, arg_7_1, arg_7_2)
		arg_3_0:emit(WorldDetailMediator.OnShipInfo, arg_7_1.id)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_PANEL)

		return
	end)
	arg_3_0.formationLogic:AddBeginDrag(function(arg_8_0)
		SetActive(findTF(arg_8_0, "info"), false)

		return
	end)
	arg_3_0.formationLogic:AddEndDrag(function(arg_9_0)
		SetActive(findTF(arg_9_0, "info"), true)

		return
	end)

	return
end

function var_0_0.didEnter(arg_10_0)
	arg_10_0:OverlayPanel(arg_10_0._tf)
	onButton(arg_10_0, arg_10_0.backBtn, function()
		arg_10_0:onBackPressed()

		return
	end, SFX_CANCEL)
	onToggle(arg_10_0, arg_10_0.detailToggle, function(arg_12_0)
		if arg_12_0 and not isActive(arg_10_0.attrFrame) then
			arg_10_0:displayAttrFrame()
		end

		return
	end, SFX_PANEL)
	onToggle(arg_10_0, arg_10_0.formationToggle, function(arg_13_0)
		if arg_13_0 and isActive(arg_10_0.attrFrame) then
			arg_10_0:hideAttrFrame()
		end

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_0.attrFrame, function()
		triggerToggle(arg_10_0.formationToggle, true)

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_0.prevPage, function()
		local var_15_0 = arg_10_0:SelectFleetByStep(-1)

		if not var_15_0 then
			return
		end

		triggerToggle(arg_10_0.fleetToggleList:GetChild(var_15_0 - 1), true)

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_0.nextPage, function()
		local var_16_0 = arg_10_0:SelectFleetByStep(1)

		if not var_16_0 then
			return
		end

		triggerToggle(arg_10_0.fleetToggleList:GetChild(var_16_0 - 1), true)

		return
	end, SFX_PANEL)
	arg_10_0:updateFleetIndex(arg_10_0.fleetIndex)
	arg_10_0:updateToggleList()
	arg_10_0.commanderFormationPanel:ActionInvoke("Show")

	local var_10_0 = arg_10_0.contextData.toggle or var_0_0.TOGGLE_FORMATION

	triggerToggle(arg_10_0[var_10_0], true)

	return
end

function var_0_0.SelectFleetByStep(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.fleetIndex + arg_17_1

	return arg_17_0.fleetIndex + arg_17_1 >= 1 and var_17_0 <= #arg_17_0.fleets and arg_17_0.fleets[var_17_0].id
end

function var_0_0.onBackPressed(arg_18_0)
	if isActive(arg_18_0.attrFrame) then
		triggerToggle(arg_18_0.formationToggle, true)

		return
	end

	arg_18_0:closeView()

	return
end

function var_0_0.updateFleetBg(arg_19_0)
	local var_19_0 = arg_19_0:getCurrentFleet():GetFleetType()

	setActive(arg_19_0.bgFleet, var_19_0 == FleetType.Normal)
	setActive(arg_19_0.bgSub, var_19_0 == FleetType.Submarine)

	return
end

function var_0_0.updateToggleList(arg_20_0)
	local var_20_0

	for iter_20_0 = 1, arg_20_0.fleetToggleList.childCount do
		local var_20_1 = arg_20_0.fleetToggleList:GetChild(iter_20_0 - 1)
		local var_20_2, var_20_3, var_20_4 = nowWorld():BuildFormationIds()

		setActive(var_20_1, iter_20_0 <= var_20_4)

		local var_20_5

		if iter_20_0 == arg_20_0.fleetToggleList.childCount then
			var_20_5 = arg_20_0.fleets[#arg_20_0.fleets]

			if arg_20_0.fleets[#arg_20_0.fleets] and var_20_5:GetFleetType() ~= FleetType.Submarine then
				var_20_5 = nil
			end
		else
			var_20_5 = arg_20_0.fleets[iter_20_0]

			if arg_20_0.fleets[iter_20_0] and var_20_5:GetFleetType() ~= FleetType.Normal then
				var_20_5 = nil
			end
		end

		local var_20_6 = tobool(var_20_5)

		setToggleEnabled(var_20_1, var_20_6)
		setActive(var_20_1:Find("lock"), not var_20_6)

		if var_20_6 then
			onToggle(arg_20_0, var_20_1, function(arg_21_0)
				if arg_21_0 and var_20_5.id ~= arg_20_0.fleetIndex then
					arg_20_0:updateFleetIndex(var_20_5.id)
				end

				return
			end, SFX_UI_TAG)

			if var_20_5.id == arg_20_0.fleetIndex then
				var_20_0 = var_20_1
			end
		else
			onButton(arg_20_0, var_20_1:Find("lock"), function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("world_redeploy_tip"))

				return
			end)
		end
	end

	triggerToggle(var_20_0, true)

	return
end

function var_0_0.setPlayerInfo(arg_23_0, arg_23_1)
	arg_23_0.resPanel:setPlayer(arg_23_1)
	setActive(arg_23_0.resPanel._tf, nowWorld():IsSystemOpen(WorldConst.SystemResource))

	return
end

function var_0_0.setFleets(arg_24_0, arg_24_1)
	arg_24_0.fleets = arg_24_1

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.fleets) do
		if iter_24_1.id == arg_24_0.contextData.fleetId then
			arg_24_0.fleetIndex = iter_24_0
		end
	end

	return
end

function var_0_0.getCurrentFleet(arg_25_0)
	return arg_25_0.fleets[arg_25_0.fleetIndex]
end

function var_0_0.updateFleetIndex(arg_26_0, arg_26_1)
	arg_26_0.fleetIndex = arg_26_1

	arg_26_0:updateFormationData()
	arg_26_0:updateFleetBg()
	arg_26_0:updateCharacters()
	arg_26_0:updatePageBtn()
	arg_26_0:updateCommanderFormation()

	return
end

function var_0_0.updateFormationData(arg_27_0)
	arg_27_0.formationLogic:SetShipVOs(arg_27_0:getCurrentFleet():getShipVOsDic())
	arg_27_0.formationLogic:SetFleetVO(arg_27_0:getCurrentFleet())

	return
end

function var_0_0.updateCommanderFormation(arg_28_0)
	arg_28_0.commanderFormationPanel:Load()
	arg_28_0.commanderFormationPanel:ActionInvoke("Update", arg_28_0:getCurrentFleet())

	return
end

function var_0_0.updateCharacters(arg_29_0)
	pg.UIMgr.GetInstance():LoadingOn()
	arg_29_0.formationLogic:ResetGrid(TeamType.Vanguard, true)
	arg_29_0.formationLogic:ResetGrid(TeamType.Main, true)
	arg_29_0.formationLogic:ResetGrid(TeamType.Submarine, true)
	arg_29_0:updateAttrFrame()
	arg_29_0.formationLogic:LoadAllCharacter()

	return
end

function var_0_0.updatePageBtn(arg_30_0)
	setActive(arg_30_0.prevPage, arg_30_0:SelectFleetByStep(-1))
	setActive(arg_30_0.nextPage, arg_30_0:SelectFleetByStep(1))

	return
end

function var_0_0.shiftCard(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = arg_31_0.cards[arg_31_3]

	if #arg_31_0.cards[arg_31_3] > 0 then
		var_31_0[arg_31_1], var_31_0[arg_31_2] = arg_31_0.cards[arg_31_3][arg_31_2], arg_31_0.cards[arg_31_3][arg_31_1]
	end

	arg_31_0.shiftIndex = arg_31_2

	arg_31_0:sortCardSiblingIndex()

	return
end

function var_0_0.sortCardSiblingIndex(arg_32_0)
	_.each({
		TeamType.Main,
		TeamType.Vanguard,
		TeamType.Submarine
	}, function(arg_33_0)
		if #arg_32_0.cards[arg_33_0] > 0 then
			for iter_33_0 = 1, #arg_32_0.cards[arg_33_0] do
				arg_32_0.cards[arg_33_0][iter_33_0].tr:SetSiblingIndex(iter_33_0 - 1)
			end
		end

		return
	end)

	return
end

function var_0_0.displayFleetInfo(arg_34_0)
	local var_34_0 = arg_34_0:getCurrentFleet()

	setActive(arg_34_0.vanguardGS, false)
	setActive(arg_34_0.mainGS, false)
	setActive(arg_34_0.subGS, false)

	local var_34_1 = var_34_0:GetFleetType()
	local var_34_2 = _.reduce(var_34_0:GetTeamShipVOs(TeamType.Vanguard, false), 0, function(arg_35_0, arg_35_1)
		return arg_35_0 + arg_35_1:getShipCombatPower()
	end)
	local var_34_3 = _.reduce(var_34_0:GetTeamShipVOs(TeamType.Main, false), 0, function(arg_36_0, arg_36_1)
		return arg_36_0 + arg_36_1:getShipCombatPower()
	end)
	local var_34_4 = _.reduce(var_34_0:GetTeamShipVOs(TeamType.Submarine, false), 0, function(arg_37_0, arg_37_1)
		return arg_37_0 + arg_37_1:getShipCombatPower()
	end)

	if var_34_1 == FleetType.Normal then
		setActive(arg_34_0.vanguardGS, true)
		setActive(arg_34_0.vanguardUpGS, false)
		setActive(arg_34_0.vanguardDownGS, false)
		setActive(arg_34_0.mainGS, true)
		setActive(arg_34_0.mainUpGS, false)
		setActive(arg_34_0.mainDownGS, false)

		if arg_34_0.contextData.vanGS then
			setActive(arg_34_0.vanguardUpGS, var_34_2 > arg_34_0.contextData.vanGS)
			setActive(arg_34_0.vanguardDownGS, var_34_2 < arg_34_0.contextData.vanGS)
		end

		var_0_1.tweenNumText(arg_34_0.vanguardGS:Find("Text"), var_34_2)

		if arg_34_0.contextData.mainGS then
			setActive(arg_34_0.mainUpGS, var_34_3 > arg_34_0.contextData.mainGS)
			setActive(arg_34_0.mainDownGS, var_34_3 < arg_34_0.contextData.mainGS)
		end

		var_0_1.tweenNumText(arg_34_0.mainGS:Find("Text"), var_34_3)

		arg_34_0.contextData.vanGS = var_34_2
		arg_34_0.contextData.mainGS = var_34_3
	elseif var_34_1 == FleetType.Submarine then
		setActive(arg_34_0.subGS, true)
		setActive(arg_34_0.subUpGS, false)
		setActive(arg_34_0.subDownGS, false)

		if arg_34_0.contextData.subGS then
			setActive(arg_34_0.subUpGS, var_34_4 > arg_34_0.contextData.subGS)
			setActive(arg_34_0.subDownGS, var_34_4 < arg_34_0.contextData.subGS)
		end

		var_0_1.tweenNumText(arg_34_0.subGS:Find("Text"), var_34_4)

		arg_34_0.contextData.subGS = var_34_4
	end

	return
end

function var_0_0.displayAttrFrame(arg_38_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_38_0.blurLayer, {
		staticBlur = true
	})
	SetActive(arg_38_0.attrFrame, true)
	arg_38_0:initAttrFrame()

	return
end

function var_0_0.hideAttrFrame(arg_39_0)
	SetActive(arg_39_0.attrFrame, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_39_0.blurLayer, arg_39_0._tf)

	return
end

function var_0_0.initAttrFrame(arg_40_0)
	local var_40_0 = arg_40_0:getCurrentFleet()

	;({})[TeamType.Main] = var_40_0[TeamType.Main]
	;({})[TeamType.Vanguard] = var_40_0[TeamType.Vanguard]
	;({})[TeamType.Submarine] = var_40_0[TeamType.Submarine]

	local var_40_1 = false

	for iter_40_0, iter_40_1 in pairs({}) do
		if #arg_40_0.cards[iter_40_0] == 0 then
			local var_40_2 = arg_40_0.attrFrame:Find(iter_40_0 .. "/list")

			for iter_40_2 = 1, 3 do
				table.insert(arg_40_0.cards[iter_40_0], FormationDetailCard.New(cloneTplTo(arg_40_0.cardTpl, var_40_2).gameObject))
			end

			var_40_1 = true
		end
	end

	if var_40_1 then
		arg_40_0:updateAttrFrame()
	end

	return
end

function var_0_0.updateAttrFrame(arg_41_0)
	local var_41_0 = arg_41_0:getCurrentFleet()

	;({})[TeamType.Main] = var_41_0[TeamType.Main]
	;({})[TeamType.Vanguard] = var_41_0[TeamType.Vanguard]
	;({})[TeamType.Submarine] = var_41_0[TeamType.Submarine]

	local var_41_1 = var_41_0:GetFleetType()

	for iter_41_0, iter_41_1 in pairs({}) do
		local var_41_2 = arg_41_0.cards[iter_41_0]

		if #arg_41_0.cards[iter_41_0] > 0 then
			local var_41_3 = var_41_1 == FleetType.Submarine and iter_41_0 == TeamType.Vanguard

			for iter_41_2 = 1, 3 do
				if iter_41_2 <= #iter_41_1 then
					local var_41_4 = WorldConst.FetchShipVO(iter_41_1[iter_41_2].id)

					var_41_2[iter_41_2]:update(var_41_4, var_41_3)
					var_41_2[iter_41_2]:updateProps(arg_41_0:getCardAttrProps(var_41_4))
				else
					var_41_2[iter_41_2]:update(nil, var_41_3)
				end

				arg_41_0:detachOnCardButton(var_41_2[iter_41_2])

				if not var_41_3 then
					arg_41_0:attachOnCardButton(var_41_2[iter_41_2], iter_41_0)
				end
			end
		end
	end

	setActive(arg_41_0.attrFrame:Find(TeamType.Main), var_41_1 == FleetType.Normal)
	setActive(arg_41_0.attrFrame:Find(TeamType.Submarine), var_41_1 == FleetType.Submarine)
	setActive(arg_41_0.attrFrame:Find(TeamType.Vanguard .. "/vanguard"), var_41_1 ~= FleetType.Submarine)
	arg_41_0:updateUltimateTitle()

	return
end

function var_0_0.updateUltimateTitle(arg_42_0)
	local var_42_0 = arg_42_0.cards[TeamType.Main]

	if #arg_42_0.cards[TeamType.Main] > 0 then
		for iter_42_0 = 1, #var_42_0 do
			go(var_42_0[iter_42_0].shipState):SetActive(iter_42_0 == 1)
		end
	end

	return
end

function var_0_0.getCardAttrProps(arg_43_0, arg_43_1)
	return {
		{
			i18n("word_attr_durability"),
			tostring(math.floor(arg_43_1:getProperties().durability))
		},
		{
			i18n("word_attr_luck"),
			"" .. tostring(math.floor((arg_43_1:getBattleTotalExpend())))
		},
		{
			i18n("word_synthesize_power"),
			"<color=#ffff00>" .. math.floor((arg_43_1:getShipCombatPower())) .. "</color>"
		}
	}
end

function var_0_0.detachOnCardButton(arg_44_0, arg_44_1)
	local var_44_0 = GetOrAddComponent(arg_44_1.go, "EventTriggerListener")

	var_44_0:RemovePointDownFunc()
	var_44_0:RemovePointUpFunc()
	var_44_0:RemoveBeginDragFunc()
	var_44_0:RemoveDragFunc()
	var_44_0:RemoveDragEndFunc()

	return
end

function var_0_0.attachOnCardButton(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = GetOrAddComponent(arg_45_1.go, "EventTriggerListener")

	arg_45_0.eventTriggers[var_45_0] = true

	var_45_0:AddPointClickFunc(function(arg_46_0, arg_46_1)
		if not arg_45_0.carddrag and arg_46_0 == arg_45_1.go then
			if arg_45_1.shipVO then
				arg_45_0:emit(WorldDetailMediator.OnShipInfo, arg_45_1.shipVO.id, var_0_0.TOGGLE_DETAIL)
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_PANEL)
		end

		return
	end)

	if arg_45_1.shipVO then
		local var_45_1 = arg_45_0.cards[arg_45_2]
		local var_45_2 = arg_45_1.tr.parent:GetComponent("ContentSizeFitter")
		local var_45_3 = arg_45_1.tr.parent:GetComponent("HorizontalLayoutGroup")
		local var_45_4 = arg_45_1.tr.rect.width * 0.5
		local var_45_5 = {}

		var_45_0:AddBeginDragFunc(function()
			if arg_45_0.carddrag then
				return
			end

			arg_45_0.carddrag = arg_45_1
			var_45_2.enabled = false
			var_45_3.enabled = false

			arg_45_1.tr:SetSiblingIndex(#var_45_1)

			for iter_47_0 = 1, #var_45_1 do
				if var_45_1[iter_47_0] == arg_45_1 then
					arg_45_0.shiftIndex = iter_47_0
				end

				var_45_5[iter_47_0] = var_45_1[iter_47_0].tr.anchoredPosition
			end

			LeanTween.scale(arg_45_1.paintingTr, Vector3(1.1, 1.1, 0), 0.3)

			return
		end)
		var_45_0:AddDragFunc(function(arg_48_0, arg_48_1)
			if arg_45_0.carddrag ~= arg_45_1 then
				return
			end

			local var_48_0 = arg_45_1.tr.localPosition

			var_48_0.x = arg_45_0:change2ScrPos(arg_45_1.tr.parent, arg_48_1.position).x
			arg_45_1.tr.localPosition = var_48_0

			local var_48_1 = 1

			for iter_48_0 = 1, #var_45_1 do
				if var_45_1[iter_48_0] ~= arg_45_1 and var_45_1[iter_48_0].shipVO and arg_45_1.tr.localPosition.x > var_45_1[iter_48_0].tr.localPosition.x + (var_48_1 < arg_45_0.shiftIndex and 1.1 or -1.1) * var_45_4 then
					var_48_1 = var_48_1 + 1
				end
			end

			if arg_45_0.shiftIndex ~= var_48_1 then
				arg_45_0.formationLogic:Shift(arg_45_0.shiftIndex, var_48_1, arg_45_2)
				arg_45_0:shiftCard(arg_45_0.shiftIndex, var_48_1, arg_45_2)

				for iter_48_1 = 1, #var_45_1 do
					if var_45_1[iter_48_1] and var_45_1[iter_48_1] ~= arg_45_1 then
						var_45_1[iter_48_1].tr.anchoredPosition = var_45_5[iter_48_1]
					end
				end
			end

			return
		end)
		var_45_0:AddDragEndFunc(function(arg_49_0, arg_49_1)
			if arg_45_0.carddrag ~= arg_45_1 then
				return
			end

			LeanTween.value(arg_45_1.go, arg_45_1.tr.anchoredPosition.x, var_45_5[arg_45_0.shiftIndex].x, math.min(math.abs(arg_45_1.tr.anchoredPosition.x - var_45_5[arg_45_0.shiftIndex].x) / 200, 1) * 0.3):setEase(LeanTweenType.easeOutCubic):setOnUpdate(System.Action_float(function(arg_50_0)
				arg_45_1.tr.anchoredPosition.x = arg_50_0
				arg_45_1.tr.anchoredPosition = arg_45_1.tr.anchoredPosition

				return
			end)):setOnComplete(System.Action(function()
				var_45_2.enabled = true
				var_45_3.enabled = true
				arg_45_0.shiftIndex = nil

				arg_45_0:updateUltimateTitle()
				arg_45_0.formationLogic:SwitchToDisplayMode()
				arg_45_0.formationLogic:SortSiblingIndex()
				arg_45_0:sortCardSiblingIndex()

				arg_45_0.carddrag = nil

				LeanTween.scale(arg_45_1.paintingTr, Vector3(1, 1, 0), 0.3)

				return
			end))

			return
		end)
	end

	return
end

function var_0_0.change2ScrPos(arg_52_0, arg_52_1, arg_52_2)
	return (LuaHelper.ScreenToLocal(arg_52_1, arg_52_2, (GameObject.Find("OverlayCamera"):GetComponent("Camera"))))
end

function var_0_0.recyclePainting(arg_53_0)
	for iter_53_0, iter_53_1 in pairs(arg_53_0.cards) do
		for iter_53_2, iter_53_3 in ipairs(iter_53_1) do
			iter_53_3:clear()
		end
	end

	return
end

function var_0_0.willExit(arg_54_0)
	arg_54_0.commanderFormationPanel:Destroy()

	if isActive(arg_54_0.attrFrame) then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_54_0.blurLayer, arg_54_0._tf)
	end

	arg_54_0:UnOverlayPanel(arg_54_0._tf)

	if arg_54_0.resPanel then
		arg_54_0.resPanel:exit()

		arg_54_0.resPanel = nil
	end

	if arg_54_0.eventTriggers then
		for iter_54_0, iter_54_1 in pairs(arg_54_0.eventTriggers) do
			ClearEventTrigger(iter_54_0)
		end

		arg_54_0.eventTriggers = nil
	end

	local var_54_0 = arg_54_0:getCurrentFleet()

	arg_54_0.formationLogic:Destroy()
	arg_54_0:recyclePainting()

	return
end

return var_0_0

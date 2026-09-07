local WorldPreCombatLayer = class("WorldPreCombatLayer", import("..base.BaseUI"))
local FormationUI = import("..ship.FormationUI")

WorldPreCombatLayer.optionsPath = {
	"adapt/top/option"
}

function WorldPreCombatLayer:getUIName()
	return "WorldPreCombatUI"
end

function WorldPreCombatLayer:init()
	self.eventTriggers = {}
	self.middle = self._tf:Find("adapt/middle")
	self.right = self._tf:Find("adapt/right")
	self.top = self._tf:Find("adapt/top")
	self.moveLayer = self._tf:Find("adapt/moveLayer")
	self.backBtn = self.top:Find("back_btn")
	self.playerResOb = self.top:Find("playerRes")
	self.resPanel = WorldResource.New()

	tf(self.resPanel._go):SetParent(tf(self.playerResOb), false)

	self.strategyInfo = self.top:Find("strategy_info")

	setActive(self.strategyInfo, false)

	self.mainGS = self.middle:Find("gear_score/main/Text")
	self.vanguardGS = self.middle:Find("gear_score/vanguard/Text")

	setText(self.mainGS, 0)
	setText(self.vanguardGS, 0)

	self.gridTFs = {
		vanguard = {},
		main = {}
	}
	self.gridFrame = self.middle:Find("mask/GridFrame")

	for iter_2_0 = 1, 3 do
		self.gridTFs[TeamType.Vanguard][iter_2_0] = self.gridFrame:Find("vanguard_" .. iter_2_0)
		self.gridTFs[TeamType.Main][iter_2_0] = self.gridFrame:Find("main_" .. iter_2_0)
	end

	self.heroContainer = self.middle:Find("HeroContainer")
	self.strategy = self.middle:Find("strategy")

	setActive(self.strategy, false)

	self.fleet = self.middle:Find("fleet")
	self.ship_tpl = findTF(self.fleet, "shiptpl")
	self.empty_tpl = findTF(self.fleet, "emptytpl")

	setActive(self.ship_tpl, false)
	setActive(self.empty_tpl, false)

	self.autoToggle = self.right:Find("auto_toggle")
	self.autoSubToggle = self.right:Find("sub_toggle_container/sub_toggle")
	self.startBtn = self.right:Find("start")
	self.infoBtn = self.right:Find("information")
	self.heroInfo = self:getTpl("heroInfo")
	self.starTpl = self:getTpl("star_tpl")
	self.energyDescTF = self._tf:Find("energy_desc")
	self.energyDescTextTF = self._tf:Find("energy_desc/Text")
	self.normaltab = self.right:Find("normal")
	self.informationtab = self.right:Find("infomation")
	self.buffInfo = self.normaltab:Find("buff")
	self.bossInfo = self.normaltab:Find("boss")
	self.spoilsContainer = self.normaltab:Find("spoils/items/items_container")
	self.spoilsItem = self.normaltab:Find("spoils/items/item_tpl")
	self.digits = self.Clone2Full(self.informationtab:Find("target/simple/digits"), 3)
	self.digitExtras = self.Clone2Full(self.informationtab:Find("target/detail"), 3)
	self.dropright = self.informationtab:Find("spoils/right")
	self.dropleft = self.informationtab:Find("spoils/left")
	self.dropitems = self.Clone2Full(self.informationtab:Find("spoils/items_container"), 3)

	setActive(self.informationtab:Find("target/simple"), true)
	setActive(self.informationtab:Find("target/detail"), false)

	for iter_2_1 = 1, #self.digitExtras do
		setText(self.digitExtras[iter_2_1]:Find("desc"), i18n("world_mapbuff_compare_txt") .. "：")
	end

	return
end

function WorldPreCombatLayer:uiStartAnimating()
	setAnchoredPosition(self.middle, {
		x = -840
	})
	setAnchoredPosition(self.right, {
		x = 470
	})
	setAnchoredPosition(self.top, {
		y = self.top.rect.height
	})
	shiftPanel(self.middle, 0, nil, 0.3, 0, true, true)
	shiftPanel(self.right, 0, nil, 0.3, 0, true, true, nil)
	shiftPanel(self.top, nil, 0, 0.3, 0, true, true, nil, nil)

	return
end

function WorldPreCombatLayer:uiExitAnimating()
	shiftPanel(self.middle, -840, nil, 0.3, 0, true, true)
	shiftPanel(self.right, 470, nil, 0.3, 0, true, true)
	shiftPanel(self.top, nil, self.top.rect.height, 0.3, 0, true, true, nil, nil)

	return
end

function WorldPreCombatLayer:didEnter()
	onButton(self, self.backBtn, function()
		GetOrAddComponent(self._tf, typeof(CanvasGroup)).interactable = false

		self:uiExitAnimating()
		LeanTween.delayedCall(0.3, System.Action(function()
			self:emit(WorldPreCombatLayer.ON_CLOSE)

			return
		end))

		return
	end, SFX_CANCEL)
	onToggle(self, self.autoToggle, function(arg_8_0)
		self:emit(WorldPreCombatMediator.OnAuto, {
			isOn = not arg_8_0,
			toggle = self.autoToggle
		})

		if arg_8_0 then
			if nowWorld():GetSubAidFlag() then
				setActive(self.autoSubToggle, true)
				onToggle(self, self.autoSubToggle, function(arg_9_0)
					self:emit(WorldPreCombatMediator.OnSubAuto, {
						isOn = not arg_9_0,
						toggle = self.autoSubToggle
					})

					return
				end, SFX_PANEL, SFX_PANEL)
				triggerToggle(self.autoSubToggle, ys.Battle.BattleState.IsAutoSubActive(SYSTEM_WORLD))

				goto label_8_0
			end
		end

		setActive(self.autoSubToggle, false)

		::label_8_0::

		return
	end, SFX_PANEL, SFX_PANEL)
	self:OverlayPanel(self._tf)
	self:updateCharacters()
	self:updateStageView()
	triggerToggle(self.autoToggle, ys.Battle.BattleState.IsAutoBotActive(SYSTEM_WORLD))

	local var_5_0 = self:GetCurrentAttachment()
	local var_5_1 = var_5_0:GetBattleStageId()

	assert(pg.expedition_data_template[var_5_1], "expedition_data_template not exist: " .. var_5_1)

	local var_5_2

	if pg.world_expedition_data[var_5_1] then
		::label_5_0::

		var_5_2 = pg.world_expedition_data[var_5_1].battle_type and pg.world_expedition_data[var_5_1].battle_type ~= 0
	end

	onNextTick(function()
		self:uiStartAnimating()

		return
	end)

	self.contextData.entetagain = true

	setActive(self.infoBtn, var_5_2)
	onButton(self, self.infoBtn, function()
		self:emit(WorldPreCombatMediator.OnOpenSublayer, Context.New({
			mediator = WorldBossInformationMediator,
			viewComponent = WorldBossInformationLayer
		}), true, function()
			self:closeView()

			return
		end)

		return
	end)
	onButton(self, self.startBtn, function()
		self:emit(WorldPreCombatMediator.OnStartBattle, var_5_0:GetBattleStageId(), self:getCurrentFleet(), var_5_0)

		return
	end, SFX_UI_WEIGHANCHOR)

	return
end

function WorldPreCombatLayer:onBackPressed()
	if self.strategyPanel and self.strategyPanel._go and isActive(self.strategyPanel._go) then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		self:hideStrategyInfo()
	else
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
		triggerButton(self.backBtn)
	end

	return
end

function WorldPreCombatLayer:setPlayerInfo(arg_15_1)
	self.resPanel:setPlayer(arg_15_1)
	setActive(self.resPanel._tf, nowWorld():IsSystemOpen(WorldConst.SystemResource))

	return
end

function WorldPreCombatLayer:getCurrentFleet()
	return nowWorld():GetFleet()
end

function WorldPreCombatLayer:GetCurrentAttachment()
	local var_17_0 = nowWorld()
	local var_17_1 = var_17_0:GetActiveMap()
	local var_17_2 = var_17_1:GetFleet()

	return var_17_1:GetCell(var_17_2.row, var_17_2.column).GetAliveAttachment(var_17_0), var_17_1.config.difficulty
end

function WorldPreCombatLayer:updateStageView()
	setActive(self.normaltab, false)
	setActive(self.informationtab, true)
	self:UpdateInformationtab()

	return
end

function WorldPreCombatLayer:UpdateNormaltab()
	local var_19_0, var_19_1 = self:GetCurrentAttachment()
	local var_19_2 = {}

	for iter_19_0, iter_19_1 in ipairs(pg.world_expedition_data[var_19_0:GetBattleStageId()].award_display_world) do
		if var_19_1 == iter_19_1[1] then
			var_19_2 = iter_19_1[2]
		end
	end

	local var_19_3 = UIItemList.New(self.spoilsContainer, self.spoilsItem)

	var_19_3:make(function(arg_20_0, arg_20_1, arg_20_2)
		local var_20_0 = {
			type = var_19_2[arg_20_1 + 1][1],
			id = var_19_2[arg_20_1 + 1][2]
		}

		updateDrop(arg_20_2, var_20_0)
		onButton(self, arg_20_2, function()
			self:emit(WorldPreCombatLayer.ON_DROP, var_20_0)

			return
		end, SFX_PANEL)

		return
	end)
	var_19_3:align(#var_19_2)

	return
end

local var_0_3 = "fe2222"
local var_0_4 = "92fc63"

function WorldPreCombatLayer:UpdateInformationtab()
	local var_22_0, var_22_1 = self:GetCurrentAttachment()
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
		for iter_23_0 = 1, #self.dropitems do
			local var_23_0 = self.dropitems[iter_23_0]:Find("item_tpl")
			local var_23_1 = var_22_3[iter_23_0 + var_22_4]

			setActive(var_23_0, var_22_3[iter_23_0 + var_22_4] ~= nil)

			if var_23_1 then
				local var_23_2 = {
					type = var_23_1[1],
					id = var_23_1[2]
				}

				updateDrop(var_23_0, var_23_2)
				setScrollText(var_23_0:Find("ScrollMask/DropName"), var_23_2:getConfig("name"))
				onButton(self, var_23_0, function()
					self:emit(WorldPreCombatLayer.ON_DROP, var_23_2)

					return
				end, SFX_PANEL)
			end
		end

		setActive(self.dropleft, var_22_4 > 0)
		setActive(self.dropright, #var_22_3 - var_22_4 > #self.dropitems)

		return
	end

	onButton(self, self.dropright, function()
		var_22_4 = var_22_4 + 1

		var_22_5()

		return
	end)
	onButton(self, self.dropleft, function()
		var_22_4 = var_22_4 - 1

		var_22_5()

		return
	end)
	var_22_5()

	local var_22_6 = nowWorld()
	local var_22_7 = var_22_6:GetWorldMapDifficultyBuffLevel()
	local var_22_8 = {
		var_22_7[1] * (1 + pg.world_expedition_data[var_22_2].expedition_sairenvalueA / 16),
		var_22_7[2] * (1 + pg.world_expedition_data[var_22_2].expedition_sairenvalueB / 16),
		var_22_7[3] * (1 + pg.world_expedition_data[var_22_2].expedition_sairenvalueC / 16)
	}
	local var_22_9 = var_22_6:GetWorldMapBuffLevel()
	local var_22_10, var_22_11, var_22_12 = ys.Battle.BattleFormulas.WorldMapRewardAttrEnhance(var_22_8, var_22_9)
	local var_22_13 = {
		var_22_10,
		var_22_11,
		1 - ys.Battle.BattleFormulas.WorldMapRewardHealingRate(var_22_8, var_22_9)
	}

	for iter_22_2 = 1, #self.digits do
		local var_22_14 = self.digits[iter_22_2]

		setText(self.digits[iter_22_2]:Find("digit"), string.format("%d", var_22_8[iter_22_2]))
		setText(var_22_14:Find("desc"), i18n("world_mapbuff_attrtxt_" .. iter_22_2) .. string.format("%3d%%", ((iter_22_2 == 3 or nil) and (1 - var_22_13[iter_22_2] or var_22_13[iter_22_2] + 1)) * 100))
	end

	for iter_22_3 = 1, #self.digitExtras do
		local var_22_15 = self.digitExtras[iter_22_3]

		setText(self.digitExtras[iter_22_3]:Find("enemy"), string.format("%d", var_22_8[iter_22_3]))
		setText(var_22_15:Find("ally"), string.format("%d", var_22_9[iter_22_3]))
		setText(var_22_15:Find("result"), string.format("%d%%", var_22_13[iter_22_3] * 100))
		setTextColor(var_22_15:Find("result"), var_22_13[iter_22_3] > 0 and self.TransformColor(var_0_3) or self.TransformColor(var_0_4))
		setText(var_22_15:Find("result/arrow"), var_22_13[iter_22_3] == 0 and "" or var_22_13[iter_22_3] > 0 and "↑" or "↓")

		if var_22_13[iter_22_3] ~= 0 then
			setTextColor(var_22_15:Find("result/arrow"), var_22_13[iter_22_3] > 0 and self.TransformColor(var_0_3) or self.TransformColor(var_0_4))
		end
	end

	onButton(self, self.informationtab:Find("target/bg"), function()
		local var_27_0 = self.informationtab:Find("target/simple")
		local var_27_1 = go(var_27_0).activeSelf

		setActive(var_27_0, not var_27_1)
		setActive(self.informationtab:Find("target/detail"), var_27_1)

		return
	end, SFX_PANEL)

	return
end

function WorldPreCombatLayer:updateCharacters()
	pg.UIMgr.GetInstance():LoadingOn()
	self:resetGrid(TeamType.Vanguard)
	self:resetGrid(TeamType.Main)
	self:loadAllCharacter(function()
		self:updateFleetView()
		self:displayFleetInfo()
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)

	return
end

function WorldPreCombatLayer:flushCharacters()
	self:resetGrid(TeamType.Vanguard)
	self:resetGrid(TeamType.Main)
	self:setAllCharacterPos(true)
	self:updateFleetView()

	return
end

function WorldPreCombatLayer:updateFleetView()
	local function var_31_0(arg_32_0, arg_32_1)
		removeAllChildren(arg_32_0)

		for iter_32_0 = 1, 3 do
			if arg_32_1[iter_32_0] then
				local var_32_0 = cloneTplTo(self.ship_tpl, arg_32_0)

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
	end

	local var_31_1 = self:getCurrentFleet()

	var_31_0(self.fleet:Find("main"), var_31_1:GetTeamShipVOs(TeamType.Main, true))
	var_31_0(self.fleet:Find("vanguard"), var_31_1:GetTeamShipVOs(TeamType.Vanguard, true))

	return
end

function WorldPreCombatLayer:loadAllCharacter(arg_33_1)
	removeAllChildren(self.heroContainer)

	self.characterList = {
		[TeamType.Vanguard] = {},
		[TeamType.Main] = {}
	}

	local function var_33_0(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
		if self.exited then
			arg_34_0:Dispose()

			return
		end

		local var_34_0 = arg_34_0:GetRootModel()
		local var_34_1 = WorldConst.FetchWorldShip(arg_34_1.id)

		self.characterList[arg_34_2][arg_34_3] = arg_34_0

		arg_34_0:SetParent(self.heroContainer, false)
		arg_34_0:SetModelScale(Vector3(0.65, 0.65, 1))
		pg.ViewUtils.SetLayer(tf(var_34_0), Layer.UI)
		self:enabledCharacter(arg_34_0, true, arg_34_2)
		self:setCharacterPos(arg_34_2, arg_34_3, arg_34_0)
		self:sortSiblingIndex()

		local var_34_2 = cloneTplTo(self.heroInfo, var_34_0)

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
			cloneTplTo(self.starTpl, var_34_4)
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
		local var_34_16 = var_34_15:getBuffShipList()[arg_34_1:getGroupId()]
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

	local function var_33_2(arg_35_0)
		for iter_35_0, iter_35_1 in ipairs((self:getCurrentFleet():GetTeamShipVOs(arg_35_0, false))) do
			table.insert(var_33_1, function(arg_36_0)
				local var_36_0 = SpineRole.New(iter_35_1)

				var_36_0:LoadLite(function()
					var_33_0(var_36_0, iter_35_1, arg_35_0, iter_35_0)
					onNextTick(arg_36_0)

					return
				end)

				return
			end)
		end

		return
	end

	var_33_2(TeamType.Vanguard)
	var_33_2(TeamType.Main)
	seriesAsync(var_33_1, function(arg_38_0)
		if self.exited then
			return
		end

		if arg_33_1 then
			arg_33_1()
		end

		return
	end)

	return
end

function WorldPreCombatLayer:showEnergyDesc(arg_39_1, arg_39_2)
	if LeanTween.isTweening(go(self.energyDescTF)) then
		LeanTween.cancel(go(self.energyDescTF))

		self.energyDescTF.localScale = Vector3.one
	end

	setText(self.energyDescTextTF, arg_39_2)

	self.energyDescTF.position = arg_39_1

	setActive(self.energyDescTF, true)
	LeanTween.scale(self.energyDescTF, Vector3.zero, 0.2):setDelay(1):setFrom(Vector3.one):setOnComplete(System.Action(function()
		self.energyDescTF.localScale = Vector3.one

		setActive(self.energyDescTF, false)

		return
	end))

	return
end

function WorldPreCombatLayer:setAllCharacterPos(arg_41_1)
	for iter_41_0, iter_41_1 in ipairs(self.characterList[TeamType.Vanguard]) do
		self:setCharacterPos(TeamType.Vanguard, iter_41_0, iter_41_1, arg_41_1)
	end

	for iter_41_2, iter_41_3 in ipairs(self.characterList[TeamType.Main]) do
		self:setCharacterPos(TeamType.Main, iter_41_2, iter_41_3, arg_41_1)
	end

	self:sortSiblingIndex()

	return
end

function WorldPreCombatLayer:setCharacterPos(arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	local var_42_0 = arg_42_3:GetRootModel()

	SetActive(var_42_0, true)

	local var_42_1 = self.gridTFs[arg_42_1][arg_42_2]

	LeanTween.cancel(go(var_42_0))

	if arg_42_4 then
		tf(var_42_0).localPosition = Vector3(self.gridTFs[arg_42_1][arg_42_2].localPosition.x + 2, self.gridTFs[arg_42_1][arg_42_2].localPosition.y - 80, self.gridTFs[arg_42_1][arg_42_2].localPosition.z)

		LeanTween.moveLocalY(go(var_42_0), self.gridTFs[arg_42_1][arg_42_2].localPosition.y - 110, 0.5):setDelay(0.5)
	else
		tf(var_42_0).localPosition = Vector3(self.gridTFs[arg_42_1][arg_42_2].localPosition.x + 2, self.gridTFs[arg_42_1][arg_42_2].localPosition.y - 110, self.gridTFs[arg_42_1][arg_42_2].localPosition.z)
	end

	SetActive(var_42_1:Find("shadow"), true)
	arg_42_3:SetAction("stand", 0)

	return
end

function WorldPreCombatLayer:resetGrid(arg_43_1)
	for iter_43_0, iter_43_1 in ipairs(self.gridTFs[arg_43_1]) do
		SetActive(iter_43_1:Find("shadow"), false)
	end

	return
end

function WorldPreCombatLayer:switchToEditMode()
	local function var_44_0(arg_45_0)
		for iter_45_0, iter_45_1 in ipairs(arg_45_0) do
			local var_45_0 = tf((iter_45_1:GetRootModel())):Find("mouseChild")

			if var_45_0 then
				local var_45_1 = var_45_0:GetComponent("EventTriggerListener")

				self.eventTriggers[var_45_1] = true

				if var_45_1 then
					var_45_1:RemovePointEnterFunc()
				end

				if iter_45_0 == self._shiftIndex then
					var_45_0:GetComponent(typeof(Image)).enabled = true
				end
			end
		end

		return
	end

	var_44_0(self.characterList[TeamType.Vanguard])
	var_44_0(self.characterList[TeamType.Main])

	self._shiftIndex = nil

	self:flushCharacters()

	return
end

function WorldPreCombatLayer:switchToShiftMode(arg_46_1, arg_46_2)
	for iter_46_0 = 1, 3 do
		setActive(self.gridTFs[TeamType.Vanguard][iter_46_0]:Find("tip"), false)
		setActive(self.gridTFs[TeamType.Main][iter_46_0]:Find("tip"), false)
		setActive(self.gridTFs[arg_46_2][iter_46_0]:Find("shadow"), false)
	end

	local var_46_0 = self.characterList[arg_46_2]

	for iter_46_1, iter_46_2 in ipairs(self.characterList[arg_46_2]) do
		local var_46_1 = iter_46_2:GetRootModel()

		if var_46_1 ~= arg_46_1 then
			LeanTween.moveLocalY(var_46_1, self.gridTFs[arg_46_2][iter_46_1].localPosition.y - 80, 0.5)

			local var_46_2 = tf(var_46_1):Find("mouseChild"):GetComponent("EventTriggerListener")

			self.eventTriggers[var_46_2] = true

			var_46_2:AddPointEnterFunc(function()
				for iter_47_0, iter_47_1 in ipairs(var_46_0) do
					if iter_47_1:GetRootModel() == var_46_1 then
						self:shift(self._shiftIndex, iter_47_0, arg_46_2)

						break
					end
				end

				return
			end)
		else
			self._shiftIndex = iter_46_1
			tf(var_46_1):Find("mouseChild"):GetComponent(typeof(Image)).enabled = false
		end

		iter_46_2:SetAction("normal", 0)
	end

	return
end

function WorldPreCombatLayer:shift(arg_48_1, arg_48_2, arg_48_3)
	local var_48_0 = self.characterList[arg_48_3]
	local var_48_1 = self.characterList[arg_48_3][arg_48_2]:GetRootModel()

	tf(var_48_1).localPosition = Vector3(self.gridTFs[arg_48_3][arg_48_1].localPosition.x + 2, self.gridTFs[arg_48_3][arg_48_1].localPosition.y - 80, self.gridTFs[arg_48_3][arg_48_1].localPosition.z)

	LeanTween.cancel(var_48_1)

	var_48_0[arg_48_1], var_48_0[arg_48_2] = self.characterList[arg_48_3][arg_48_2], self.characterList[arg_48_3][arg_48_1]

	local var_48_2 = self:getCurrentFleet()
	local var_48_3 = var_48_2:GetTeamShips(arg_48_3, false)

	var_48_2:SwitchShip(var_48_3[arg_48_1].id, var_48_3[arg_48_2].id)

	self._shiftIndex = arg_48_2

	self:sortSiblingIndex()

	return
end

function WorldPreCombatLayer:sortSiblingIndex()
	local var_49_0 = 0

	while 3 > 0 do
		if self.characterList[TeamType.Main][3] then
			tf((self.characterList[TeamType.Main][3]:GetRootModel())):SetSiblingIndex(var_49_0)

			var_49_0 = var_49_0 + 1
		end

		if self.characterList[TeamType.Vanguard][3] then
			tf((self.characterList[TeamType.Vanguard][3]:GetRootModel())):SetSiblingIndex(var_49_0)

			var_49_0 = var_49_0 + 1
		end
	end

	return
end

function WorldPreCombatLayer:enabledTeamCharacter(arg_50_1, arg_50_2)
	for iter_50_0, iter_50_1 in ipairs(self.characterList[arg_50_1]) do
		self:enabledCharacter(iter_50_1, arg_50_2, arg_50_1)
	end

	return
end

function WorldPreCombatLayer:enabledCharacter(arg_51_1, arg_51_2, arg_51_3)
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

			self.eventTriggers[var_51_5] = true

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
				var_51_9 = rtf(self._tf).rect.width / var_51_7
				var_51_10 = rtf(self._tf).rect.height / var_51_8

				LeanTween.cancel(go(var_51_0))
				self:switchToShiftMode(var_51_0, arg_51_3)
				arg_51_1:SetAction("tuozhuai", 0)
				arg_51_1:SetParent(self.moveLayer, false)
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_HOME_DRAG)

				return
			end)
			var_51_5:AddDragFunc(function(arg_53_0, arg_53_1)
				rtf(var_51_0).anchoredPosition = Vector2((arg_53_1.position.x - var_51_7 / 2) * var_51_9 + 20, (arg_53_1.position.y - var_51_8 / 2) * var_51_10 - 20)

				return
			end)
			var_51_5:AddDragEndFunc(function(arg_54_0, arg_54_1)
				arg_51_1:SetAction("tuozhuai", 0)
				tf(var_51_0):SetParent(self.heroContainer, false)
				self:switchToEditMode()
				self:sortSiblingIndex()
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_HOME_PUT)

				return
			end)
		end
	else
		SetActive(tf(model):Find("mouseChild"), false)
	end

	return
end

function WorldPreCombatLayer:displayFleetInfo()
	local var_55_0 = self:getCurrentFleet()

	FormationUI.tweenNumText(self.vanguardGS, (_.reduce(var_55_0:GetTeamShipVOs(TeamType.Vanguard, false), 0, function(arg_56_0, arg_56_1)
		return arg_56_0 + arg_56_1:getShipCombatPower()
	end)))
	FormationUI.tweenNumText(self.mainGS, (_.reduce(var_55_0:GetTeamShipVOs(TeamType.Main, false), 0, function(arg_57_0, arg_57_1)
		return arg_57_0 + arg_57_1:getShipCombatPower()
	end)))

	return
end

function WorldPreCombatLayer:hideStrategyInfo()
	if self.strategyPanel then
		self.strategyPanel:detach()
	end

	return
end

function WorldPreCombatLayer:recycleCharacterList(arg_59_1, arg_59_2)
	for iter_59_0, iter_59_1 in ipairs(arg_59_1) do
		if arg_59_2[iter_59_0] then
			arg_59_2[iter_59_0]:Dispose()

			arg_59_2[iter_59_0] = nil
		end
	end

	return
end

function WorldPreCombatLayer:willExit()
	self:UnOverlayPanel(self._tf)

	if self.resPanel then
		self.resPanel:exit()

		self.resPanel = nil
	end

	if self.eventTriggers then
		for iter_60_0, iter_60_1 in pairs(self.eventTriggers) do
			ClearEventTrigger(iter_60_0)
		end

		self.eventTriggers = nil
	end

	if self.tweens then
		cancelTweens(self.tweens)
	end

	local var_60_0 = self:getCurrentFleet()

	self:recycleCharacterList(var_60_0:GetTeamShipVOs(TeamType.Main, false), self.characterList[TeamType.Main])
	self:recycleCharacterList(var_60_0:GetTeamShipVOs(TeamType.Vanguard, false), self.characterList[TeamType.Vanguard])

	return
end

function WorldPreCombatLayer:Clone2Full(arg_61_1)
	local var_61_0 = {}
	local var_61_1 = self:GetChild(0)

	for iter_61_0 = 0, self.childCount - 1 do
		table.insert(var_61_0, self:GetChild(iter_61_0))
	end

	for iter_61_1 = self.childCount, arg_61_1 - 1 do
		table.insert(var_61_0, tf((cloneTplTo(var_61_1, self))))
	end

	return var_61_0
end

function WorldPreCombatLayer:TransformColor()
	return Color.New(tonumber(string.sub(self, 1, 2), 16) / 255, tonumber(string.sub(self, 3, 4), 16) / 255, tonumber(string.sub(self, 5, 6), 16) / 255)
end

return WorldPreCombatLayer

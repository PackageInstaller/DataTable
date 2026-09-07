local WorldBossInformationLayer = class("WorldBossInformationLayer", import("view.base.BaseUI"))
local var_0_1 = 25
local var_0_2 = 7.2

function WorldBossInformationLayer:getUIName()
	return "WorldBossInformationUI"
end

function WorldBossInformationLayer:init()
	self.bg = self._tf:Find("bg")
	self.layer = self._tf:Find("fixed")
	self.top = self.layer:Find("top")
	self.backBtn = self.top:Find("back_btn")
	self.homeBtn = self.top:Find("option")
	self.playerResOb = self.top:Find("playerRes")
	self.resPanel = WorldResource.New()

	tf(self.resPanel._go):SetParent(tf(self.playerResOb), false)

	self.startBtn = self.layer:Find("battle")
	self.retreatBtn = self.layer:Find("retreat")
	self.hpbar = self.layer:Find("hp")

	local var_2_0 = self.layer:Find("drop")

	self.dropitems = CustomIndexLayer.Clone2Full(var_2_0:Find("items"), 5)
	self.dropright = var_2_0:Find("right")
	self.dropleft = var_2_0:Find("left")
	self.awardBtn = self.layer:Find("showAward")
	self.weaknesstext = self.layer:Find("text")
	self.weaknessbg = self.layer:Find("boss_ruodian")
	self.downBG = self.layer:Find("BlurBG")
	self.buffListTF = self.layer:Find("BuffList")
	self.buffListAnimator = self.buffListTF:GetComponent(typeof(Animator))
	self.AdditionBuffTF = self.layer:Find("BuffList/tezhuangmokuai")
	self.AdditionBuffContainer = self.AdditionBuffTF:Find("buff")
	self.EquipmentBuffTF = self.layer:Find("BuffList/wuzhuangjiexi")
	self.EquipmentBuffContainer = self.EquipmentBuffTF:Find("buff")
	self.switchBuffBtn = self.layer:Find("BuffList/Switcher")
	self.ShowBuffIndex = 0
	self.attributeRoot = self.layer:Find("attributes")
	self.attributeRootAnchorY = self.attributeRoot.anchoredPosition.y
	self.attributes = CustomIndexLayer.Clone2Full(self.layer:Find("attributes"), 3)

	for iter_2_0 = 1, #self.attributes do
		self.attributes[iter_2_0]:Find("extra").gameObject:SetActive(false)
		setText(self.attributes[iter_2_0]:Find("extra/desc"), i18n("world_mapbuff_compare_txt") .. "：")
	end

	local var_2_1 = self.layer:Find("bossname")

	self.bossnameText = var_2_1:Find("name"):GetComponent(typeof(Text))
	self.bossNameBanner = var_2_1:Find("name/banner")
	self.bosslevel = self.bossNameBanner:Find("level")
	self.bosslogos = {
		var_2_1:Find("name/bosslogo_01"),
		(var_2_1:Find("name/bosslogo_02"))
	}
	self.bossTypeIcon = self.bossNameBanner:Find("Type/Icon")
	self.bossArmorText = self.bossNameBanner:Find("Type/Armor")
	self.saomiaoxian = self.layer:Find("saomiao")
	self.bosssprite = self.saomiaoxian:Find("qimage")
	self.dangerMark = self.layer:Find("danger_mark")
	self.loader = AutoLoader.New()
	self.dungeonDict = {}

	return
end

function WorldBossInformationLayer:didEnter()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.homeBtn, function()
		self:quickExitFunc()

		return
	end, SFX_CANCEL)
	onButton(self, self.startBtn, function()
		self:emit(WorldBossInformationMediator.OnOpenSublayer, Context.New({
			mediator = WorldPreCombatMediator,
			viewComponent = WorldPreCombatLayer
		}), true, function()
			self:closeView()

			return
		end)

		return
	end, SFX_UI_WEIGHANCHOR)
	onButton(self, self.retreatBtn, function()
		self:emit(WorldBossInformationMediator.RETREAT_FLEET)
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.switchBuffBtn, function()
		self.ShowBuffIndex = 1 - self.ShowBuffIndex

		local var_9_0 = self.ShowBuffIndex == 1 and "switchOn" or "switchOff"

		self.buffListAnimator:Play(self.ShowBuffIndex == 1 and "switchOn" or "switchOff", -1, 0)

		if var_9_0 == "switchOn" then
			self.EquipmentBuffTF:SetAsLastSibling()
		else
			self.AdditionBuffTF:SetAsLastSibling()
		end

		self.switchBuffBtn:SetAsLastSibling()

		return
	end, SFX_PANEL)
	onButton(self, self.awardBtn, function()
		self:GetAwardPanel().buffer:UpdateView(self:GetCurrentAttachment())

		return
	end, SFX_PANEL)
	self:updateStageView()
	self.loader:LoadPrefab("ui/xuetiao01", "", nil, function(arg_11_0)
		setParent(arg_11_0, self.layer)

		local var_11_0 = tf(arg_11_0):Find("qipao")

		setParent(var_11_0, self.hpbar:Find("hp"), false)
		setLocalPosition(var_11_0, {
			x = 0,
			y = 0
		})

		local var_11_1 = tf(arg_11_0):Find("xuetiao01")

		self.hpeffectmat = var_11_1:GetComponent(typeof(Renderer)).material

		setParent(var_11_1, self.hpbar, false)
		setLocalPosition(var_11_1, {
			x = 0,
			y = 0
		})
		self:UpdateHpbar()

		return
	end)
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)
	pg.UIMgr.GetInstance():OverlayPanel(self.layer, {
		pbList = {
			self.downBG,
			self.attributes[1],
			self.attributes[2],
			self.attributes[3],
			self.top,
			self.AdditionBuffTF,
			self.EquipmentBuffTF
		}
	})

	return
end

function WorldBossInformationLayer:setPlayerInfo(arg_12_1)
	self.resPanel:setPlayer(arg_12_1)
	setActive(self.resPanel._tf, nowWorld():IsSystemOpen(WorldConst.SystemResource))

	return
end

function WorldBossInformationLayer:getCurrentFleet()
	return nowWorld():GetFleet()
end

function WorldBossInformationLayer:GetCurrentAttachment()
	local var_14_0 = nowWorld()
	local var_14_1 = var_14_0:GetActiveMap()
	local var_14_2 = var_14_1:GetFleet()

	return var_14_1:GetCell(var_14_2.row, var_14_2.column).GetAliveAttachment(var_14_0), var_14_1.config.difficulty
end

function WorldBossInformationLayer:GetEnemyLevel(arg_15_1)
	if arg_15_1.difficulty == ys.Battle.BattleConst.Difficulty.WORLD then
		return WorldConst.WorldLevelCorrect(nowWorld():GetActiveMap().config.expedition_level, arg_15_1.type)
	else
		return arg_15_1.level
	end

	return
end

function WorldBossInformationLayer:UpdateHpbar()
	local var_16_0 = self:GetCurrentAttachment()
	local var_16_1 = self:GetDungeonBossData(var_16_0).bossData.hpBarNum
	local var_16_2 = var_16_0:GetHP() or 10000
	local var_16_3 = math.ceil(var_16_1 * var_16_2 / 16)

	setSlider(self.hpbar, 0, var_16_1, var_16_3)
	setText(self.hpbar:Find("hpcur"), string.format("%d", var_16_3))
	setText(self.hpbar:Find("hpamount"), var_16_1)

	local var_16_4 = self.hpbar:Find("hp/mask")

	if self.hpeffectmat then
		self.hpeffectmat:SetFloat("_Mask", var_16_2 / 100)

		local var_16_5 = self.hpbar:Find("hp").rect

		var_16_4.localScale = Vector3(var_16_5.width * var_0_1, var_16_5.height * var_0_1, 1)
		var_16_4.localPosition = Vector3.zero

		setLocalScale(self.hpbar:Find("xuetiao01"), {
			x = math.clamp(Screen.width / Screen.height, 1.7777777777777777, 2) / 1.7777777777777777
		})
	end

	local var_16_6 = self.hpbar:Find("rewards")
	local var_16_7 = pg.world_expedition_data[var_16_0:GetBattleStageId()]
	local var_16_8 = var_16_7 and var_16_7.phase_drop

	setActive(var_16_6, var_16_7 and var_16_7.phase_drop and #var_16_8 > 0)

	local var_16_9 = var_16_2

	if var_16_0:IsPeriodEnemy() then
		var_16_9 = math.min(var_16_9, nowWorld():GetHistoryLowestHP(var_16_0.id))
	end

	UIItemList.StaticAlign(var_16_6, var_16_6:GetChild(0), (var_16_8 or nil) and (#var_16_8 or 0), function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_17_0 = var_16_8[arg_17_1 + 1]

		arg_17_2.anchorMin = Vector2(var_16_8[arg_17_1 + 1][1] / 16, 0.5)
		arg_17_2.anchorMax = Vector2(var_16_8[arg_17_1 + 1][1] / 16, 0.5)

		setAnchoredPosition(arg_17_2, {
			x = 0
		})
		self.loader:GetSprite("ui/worldbossinformationui_atlas", var_16_9 <= var_17_0[1] and "reward_empty" or "reward", arg_17_2)

		return
	end)

	local var_16_11 = self.hpbar:Find("kedu")

	setLocalScale(var_16_11, {
		x = self.hpbar.rect.width / var_16_11.rect.width
	})

	return
end

function WorldBossInformationLayer:GetDungeonBossData(arg_18_1)
	assert(arg_18_1, "Attachment is null")

	local var_18_0

	_.any(self:GetDungeonFile(arg_18_1.config.dungeon_id).stages[1].waves, function(arg_19_0)
		if not arg_19_0.spawn then
			return
		end

		return _.any(arg_19_0.spawn, function(arg_20_0)
			if arg_20_0.bossData then
				var_18_0 = arg_20_0

				return true
			end

			return
		end)
	end)
	assert(nil, "Cant Find Boss Data in Dungeon: " .. (arg_18_1.config.dungeon_id or "NIL"))

	return nil
end

function WorldBossInformationLayer:GetDungeonFile(arg_21_1)
	if self.dungeonDict[arg_21_1] then
		return self.dungeonDict[arg_21_1]
	end

	local var_21_0 = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(arg_21_1)

	self.dungeonDict[arg_21_1] = var_21_0

	return var_21_0
end

local var_0_3 = 212
local var_0_4 = 40
local var_0_5 = "fe2222"
local var_0_6 = "92fc63"
local var_0_7 = 70

function WorldBossInformationLayer:updateStageView()
	local var_22_0, var_22_1 = self:GetCurrentAttachment()
	local var_22_2 = var_22_0:GetBattleStageId()
	local var_22_3 = pg.expedition_data_template[var_22_2]
	local var_22_4 = pg.world_expedition_data[var_22_2]

	assert(pg.expedition_data_template[var_22_2], "expedition_data_template not exist: " .. var_22_2)

	local var_22_5 = {}

	for iter_22_0, iter_22_1 in ipairs(var_22_4.award_display_world) do
		if var_22_1 == iter_22_1[1] then
			var_22_5 = iter_22_1[2]
		end
	end

	local var_22_6 = 0

	local function var_22_7()
		for iter_23_0 = 1, #self.dropitems do
			local var_23_0 = self.dropitems[iter_23_0]:Find("item_tpl")
			local var_23_1 = var_22_5[iter_23_0 + var_22_6]

			setActive(var_23_0, var_22_5[iter_23_0 + var_22_6] ~= nil)

			if var_23_1 then
				local var_23_2 = {
					type = var_23_1[1],
					id = var_23_1[2]
				}

				updateDrop(var_23_0, var_23_2)
				onButton(self, var_23_0, function()
					self:emit(WorldBossInformationLayer.ON_DROP, var_23_2)

					return
				end, SFX_PANEL)
			end
		end

		setActive(self.dropleft, var_22_6 > 0)
		setActive(self.dropright, #var_22_5 - var_22_6 > #self.dropitems)

		return
	end

	onButton(self, self.dropright, function()
		var_22_6 = var_22_6 + 1

		var_22_7()

		return
	end)
	onButton(self, self.dropleft, function()
		var_22_6 = var_22_6 - 1

		var_22_7()

		return
	end)
	var_22_7()
	setActive(self.awardBtn, var_22_4.phase_drop_display and #var_22_4.phase_drop_display > 0)

	local var_22_8 = var_22_0:GetWeaknessBuffId()
	local var_22_9 = pg.world_SLGbuff_data[var_22_8]

	setActive(self.weaknesstext, pg.world_SLGbuff_data[var_22_8] ~= nil)
	setActive(self.weaknessbg, var_22_9 ~= nil)

	if var_22_9 then
		setText(self.weaknesstext, i18n("word_weakness") .. ": " .. var_22_9.desc)
	end

	setAnchoredPosition(self.attributeRoot, {
		y = self.attributeRootAnchorY - ((var_22_9 == nil or nil) and (var_0_7 or 0))
	})
	;(function()
		local var_27_0 = _.filter(table.mergeArray(var_22_0:GetBuffList(), nowWorld():GetActiveMap():GetBuffList(WorldMap.FactionEnemy, var_22_0)), function(arg_28_0)
			return arg_28_0.id ~= var_22_8
		end)

		UIItemList.StaticAlign(self.AdditionBuffContainer, self.AdditionBuffContainer:GetChild(0), #var_27_0, function(arg_29_0, arg_29_1, arg_29_2)
			if arg_29_0 ~= UIItemList.EventUpdate then
				return
			end

			local var_29_0 = var_27_0[arg_29_1 + 1]

			setActive(arg_29_2, var_27_0[arg_29_1 + 1])

			if var_29_0 then
				self.loader:GetSprite("world/buff/" .. var_29_0.config.icon, "", arg_29_2:Find("icon"))
				setText(arg_29_2:Find("desc"), var_29_0.config.desc)
			end

			return
		end)

		return
	end)()
	;(function()
		local var_30_0 = var_22_4.special_buff_display

		if not var_22_4.special_buff_display or #var_30_0 == 0 then
			var_30_0 = nil
		end

		setActive(self.EquipmentBuffTF, var_30_0)
		setActive(self.switchBuffBtn, var_30_0)

		if not var_30_0 then
			return
		end

		local var_30_1 = _.map(var_30_0, function(arg_31_0)
			assert("world_SLGbuff_data Missing ID: " .. (arg_31_0 or "NIL"))

			return pg.world_SLGbuff_data[arg_31_0]
		end)

		UIItemList.StaticAlign(self.EquipmentBuffContainer, self.EquipmentBuffContainer:GetChild(0), #var_30_1, function(arg_32_0, arg_32_1, arg_32_2)
			if arg_32_0 ~= UIItemList.EventUpdate then
				return
			end

			local var_32_0 = var_30_1[arg_32_1 + 1]

			setActive(arg_32_2, var_30_1[arg_32_1 + 1])

			if var_32_0 then
				self.loader:GetSprite("world/buff/" .. var_32_0.icon, "", arg_32_2:Find("icon"))
				setText(arg_32_2:Find("desc"), var_32_0.desc)
			end

			return
		end)

		return
	end)()
	Canvas.ForceUpdateCanvases()

	self.buffListTF.sizeDelta.y = math.max(self.AdditionBuffTF.rect.height, self.EquipmentBuffTF.rect.height) + 50
	self.buffListTF.sizeDelta = self.buffListTF.sizeDelta

	self:UpdateHpbar()

	local var_22_10 = nowWorld()
	local var_22_11 = var_22_10:GetWorldMapDifficultyBuffLevel()
	local var_22_12 = {
		var_22_11[1] * (1 + var_22_4.expedition_sairenvalueA / 16),
		var_22_11[2] * (1 + var_22_4.expedition_sairenvalueB / 16),
		var_22_11[3] * (1 + var_22_4.expedition_sairenvalueC / 16)
	}
	local var_22_13 = var_22_10:GetWorldMapBuffLevel()
	local var_22_14, var_22_15, var_22_16 = ys.Battle.BattleFormulas.WorldMapRewardAttrEnhance(var_22_12, var_22_13)
	local var_22_17 = {
		var_22_14,
		var_22_15,
		1 - ys.Battle.BattleFormulas.WorldMapRewardHealingRate(var_22_12, var_22_13)
	}

	for iter_22_2 = 1, #self.attributes do
		local var_22_18 = self.attributes[iter_22_2]

		setText(self.attributes[iter_22_2]:Find("digit"), string.format("%d", var_22_12[iter_22_2]))
		setText(var_22_18:Find("desc"), i18n("world_mapbuff_attrtxt_" .. iter_22_2) .. string.format(" %d%%", ((iter_22_2 == 3 or nil) and (1 - var_22_17[iter_22_2] or var_22_17[iter_22_2] + 1)) * 100))

		local var_22_19 = GetOrAddComponent(var_22_18, typeof(UILongPressTrigger))

		var_22_19.onPressed:RemoveAllListeners()
		var_22_19.onReleased:RemoveAllListeners()

		local var_22_20
		local var_22_21

		var_22_19.onPressed:AddListener(function()
			var_22_20 = go(var_22_18:Find("extra")).activeSelf

			setActive(var_22_18:Find("extra"), true)

			var_22_21 = Time.realtimeSinceStartup

			return
		end)
		var_22_19.onReleased:AddListener(function()
			if not var_22_21 or Time.realtimeSinceStartup - var_22_21 < 0.3 then
				setActive(var_22_18:Find("extra"), not var_22_20)
			else
				setActive(var_22_18:Find("extra"), false)
			end

			return
		end)
		setText(var_22_18:Find("extra/enemy"), var_22_12[iter_22_2])
		setText(var_22_18:Find("extra/ally"), var_22_13[iter_22_2])
		setText(var_22_18:Find("extra/result"), string.format("%d%%", var_22_17[iter_22_2] * 100))
		setTextColor(var_22_18:Find("extra/result"), var_22_17[iter_22_2] > 0 and self.TransformColor(var_0_5) or self.TransformColor(var_0_6))
		setText(var_22_18:Find("extra/result/arrow"), var_22_17[iter_22_2] == 0 and "" or var_22_17[iter_22_2] > 0 and "↑" or "↓")

		if var_22_17[iter_22_2] ~= 0 then
			setTextColor(var_22_18:Find("extra/result/arrow"), var_22_17[iter_22_2] > 0 and self.TransformColor(var_0_5) or self.TransformColor(var_0_6))
		end

		local var_22_22 = var_22_18:Find("extra/allybar")
		local var_22_23 = var_22_18:Find("extra/enemybar")
		local var_22_24 = math.clamp(1 + var_22_17[iter_22_2], 0.75, 3)
		local var_22_25 = var_22_18:Find("extra").rect.width

		var_22_23.sizeDelta = Vector2(var_22_24 * var_22_25 / (var_22_24 + 1) + var_0_2 * 0.5, var_22_23.sizeDelta.y)
		var_22_22.sizeDelta = Vector2(1 * var_22_25 / (var_22_24 + 1) + var_0_2 * 0.5, var_22_22.sizeDelta.y)
	end

	local var_22_26 = var_22_4.battle_character
	local var_22_27 = var_22_4.battle_character and #var_22_26 > 0

	var_22_26 = var_22_4.battle_character and #var_22_26 > 0 and var_22_26 or "world_boss_0"
	self.bg:GetComponent(typeof(Image)).enabled = true

	setImageSprite(self.bg, GetSpriteFromAtlas("commonbg/" .. var_22_26, var_22_26))
	;(function()
		self.bossnameText.text = var_22_3.name

		local var_35_0 = false

		if self.bossnameText.preferredWidth > self.bossnameText.transform.rect.width then
			self.bossnameText.text = string.gsub(var_22_3.name, "「.-」", "\n%1")
			var_35_0 = true
		end

		setAnchoredPosition(self.bossNameBanner, {
			y = var_35_0 and -18 or 0
		})
		setText(self.bosslevel, i18n("world_level_prefix", self:GetEnemyLevel(var_22_3) or 1))
		setActive(self.bosslogos[1], var_22_27)
		setActive(self.bosslogos[2], not var_22_27)
		setActive(self.saomiaoxian, not var_22_27)

		local var_35_1 = ys.Battle.BattleDataFunction.GetMonsterTmpDataFromID(self:GetDungeonBossData(var_22_0).monsterTemplateID)

		self.loader:GetSprite("shiptype", ShipType.Type2BattlePrint(var_35_1.type), self.bossTypeIcon, true)
		setText(self.bossArmorText, ArmorType.Type2Name(var_35_1.armor_type))

		return
	end)()

	local var_22_28 = ys.Battle.BattleAttr.IsWorldMapRewardAttrWarning(var_22_12, var_22_13)

	setActive(self.dangerMark, var_22_28)

	if var_22_28 then
		local var_22_30 = {}

		if var_22_27 then
			var_22_30.x = var_0_4 or var_0_3
		end

		setAnchoredPosition(self.dangerMark, var_22_30)
	end

	if not var_22_27 then
		if var_22_3.icon_type == 1 then
			self.loader:GetSprite("enemies/" .. var_22_3.icon, nil, self.bosssprite)
		elseif var_22_3.icon_type == 2 then
			self.bosssprite:GetComponent(typeof(Image)).enabled = false

			self.loader:GetSpine(var_22_3.icon, function(arg_36_0)
				arg_36_0:SetLocalScale(Vector3(var_22_4.battle_spine_size * 0.01, var_22_4.battle_spine_size * 0.01, 1))
				arg_36_0:SetAnchoredPosition(Vector3.New(0, -150, 0))
				arg_36_0:SetAction(ChapterConst.ShipIdleAction, 0)

				arg_36_0:GetSkeletonGraphic().raycastTarget = false

				arg_36_0:SetParent(self.bosssprite)

				return
			end, self.bosssprite)
		end
	end

	return
end

function WorldBossInformationLayer:onBackPressed()
	if self.awardPanel and self.awardPanel:isShowing() then
		self.awardPanel:Hide()

		return
	end

	triggerButton(self.backBtn)

	return
end

function WorldBossInformationLayer:willExit()
	self:DestroyAwardPanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.layer, self._tf)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	if self.resPanel then
		self.resPanel:exit()

		self.resPanel = nil
	end

	for iter_38_0, iter_38_1 in pairs(self.dungeonDict) do
		ys.Battle.BattleDataFunction.ClearDungeonCfg(iter_38_0)
	end

	table.clear(self.dungeonDict)
	self.loader:Clear()

	return
end

function WorldBossInformationLayer:GetAwardPanel()
	self.awardPanel = self.awardPanel or WorldBossHPAwardPanel.New(self._tf, self.event, self.contextData)

	self.awardPanel:Load()

	return self.awardPanel
end

function WorldBossInformationLayer:DestroyAwardPanel()
	if not self.awardPanel then
		return
	end

	self.awardPanel:Destroy()

	self.awardPanel = nil

	return
end

function WorldBossInformationLayer:TransformColor()
	return Color.New(tonumber(string.sub(self, 1, 2), 16) / 255, tonumber(string.sub(self, 3, 4), 16) / 255, tonumber(string.sub(self, 5, 6), 16) / 255)
end

return WorldBossInformationLayer

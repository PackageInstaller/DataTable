local var_0_0 = class("WorldBossInformationLayer", import("view.base.BaseUI"))
local var_0_1 = 25
local var_0_2 = 7.2

function var_0_0.getUIName(arg_1_0)
	return "WorldBossInformationUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.bg = arg_2_0._tf:Find("bg")
	arg_2_0.layer = arg_2_0._tf:Find("fixed")
	arg_2_0.top = arg_2_0.layer:Find("top")
	arg_2_0.backBtn = arg_2_0.top:Find("back_btn")
	arg_2_0.homeBtn = arg_2_0.top:Find("option")
	arg_2_0.playerResOb = arg_2_0.top:Find("playerRes")
	arg_2_0.resPanel = WorldResource.New()

	tf(arg_2_0.resPanel._go):SetParent(tf(arg_2_0.playerResOb), false)

	arg_2_0.startBtn = arg_2_0.layer:Find("battle")
	arg_2_0.retreatBtn = arg_2_0.layer:Find("retreat")
	arg_2_0.hpbar = arg_2_0.layer:Find("hp")

	local var_2_0 = arg_2_0.layer:Find("drop")

	arg_2_0.dropitems = CustomIndexLayer.Clone2Full(var_2_0:Find("items"), 5)
	arg_2_0.dropright = var_2_0:Find("right")
	arg_2_0.dropleft = var_2_0:Find("left")
	arg_2_0.awardBtn = arg_2_0.layer:Find("showAward")
	arg_2_0.weaknesstext = arg_2_0.layer:Find("text")
	arg_2_0.weaknessbg = arg_2_0.layer:Find("boss_ruodian")
	arg_2_0.downBG = arg_2_0.layer:Find("BlurBG")
	arg_2_0.buffListTF = arg_2_0.layer:Find("BuffList")
	arg_2_0.buffListAnimator = arg_2_0.buffListTF:GetComponent(typeof(Animator))
	arg_2_0.AdditionBuffTF = arg_2_0.layer:Find("BuffList/tezhuangmokuai")
	arg_2_0.AdditionBuffContainer = arg_2_0.AdditionBuffTF:Find("buff")
	arg_2_0.EquipmentBuffTF = arg_2_0.layer:Find("BuffList/wuzhuangjiexi")
	arg_2_0.EquipmentBuffContainer = arg_2_0.EquipmentBuffTF:Find("buff")
	arg_2_0.switchBuffBtn = arg_2_0.layer:Find("BuffList/Switcher")
	arg_2_0.ShowBuffIndex = 0
	arg_2_0.attributeRoot = arg_2_0.layer:Find("attributes")
	arg_2_0.attributeRootAnchorY = arg_2_0.attributeRoot.anchoredPosition.y
	arg_2_0.attributes = CustomIndexLayer.Clone2Full(arg_2_0.layer:Find("attributes"), 3)

	for iter_2_0 = 1, #arg_2_0.attributes do
		arg_2_0.attributes[iter_2_0]:Find("extra").gameObject:SetActive(false)
		setText(arg_2_0.attributes[iter_2_0]:Find("extra/desc"), i18n("world_mapbuff_compare_txt") .. "：")
	end

	local var_2_1 = arg_2_0.layer:Find("bossname")

	arg_2_0.bossnameText = var_2_1:Find("name"):GetComponent(typeof(Text))
	arg_2_0.bossNameBanner = var_2_1:Find("name/banner")
	arg_2_0.bosslevel = arg_2_0.bossNameBanner:Find("level")
	arg_2_0.bosslogos = {
		var_2_1:Find("name/bosslogo_01"),
		(var_2_1:Find("name/bosslogo_02"))
	}
	arg_2_0.bossTypeIcon = arg_2_0.bossNameBanner:Find("Type/Icon")
	arg_2_0.bossArmorText = arg_2_0.bossNameBanner:Find("Type/Armor")
	arg_2_0.saomiaoxian = arg_2_0.layer:Find("saomiao")
	arg_2_0.bosssprite = arg_2_0.saomiaoxian:Find("qimage")
	arg_2_0.dangerMark = arg_2_0.layer:Find("danger_mark")
	arg_2_0.loader = AutoLoader.New()
	arg_2_0.dungeonDict = {}

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0.backBtn, function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.homeBtn, function()
		arg_3_0:quickExitFunc()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.startBtn, function()
		arg_3_0:emit(WorldBossInformationMediator.OnOpenSublayer, Context.New({
			mediator = WorldPreCombatMediator,
			viewComponent = WorldPreCombatLayer
		}), true, function()
			arg_3_0:closeView()

			return
		end)

		return
	end, SFX_UI_WEIGHANCHOR)
	onButton(arg_3_0, arg_3_0.retreatBtn, function()
		arg_3_0:emit(WorldBossInformationMediator.RETREAT_FLEET)
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.switchBuffBtn, function()
		arg_3_0.ShowBuffIndex = 1 - arg_3_0.ShowBuffIndex

		local var_9_0 = arg_3_0.ShowBuffIndex == 1 and "switchOn" or "switchOff"

		arg_3_0.buffListAnimator:Play(arg_3_0.ShowBuffIndex == 1 and "switchOn" or "switchOff", -1, 0)

		if var_9_0 == "switchOn" then
			arg_3_0.EquipmentBuffTF:SetAsLastSibling()
		else
			arg_3_0.AdditionBuffTF:SetAsLastSibling()
		end

		arg_3_0.switchBuffBtn:SetAsLastSibling()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.awardBtn, function()
		arg_3_0:GetAwardPanel().buffer:UpdateView(arg_3_0:GetCurrentAttachment())

		return
	end, SFX_PANEL)
	arg_3_0:updateStageView()
	arg_3_0.loader:LoadPrefab("ui/xuetiao01", "", nil, function(arg_11_0)
		setParent(arg_11_0, arg_3_0.layer)

		local var_11_0 = tf(arg_11_0):Find("qipao")

		setParent(var_11_0, arg_3_0.hpbar:Find("hp"), false)
		setLocalPosition(var_11_0, {
			x = 0,
			y = 0
		})

		local var_11_1 = tf(arg_11_0):Find("xuetiao01")

		arg_3_0.hpeffectmat = var_11_1:GetComponent(typeof(Renderer)).material

		setParent(var_11_1, arg_3_0.hpbar, false)
		setLocalPosition(var_11_1, {
			x = 0,
			y = 0
		})
		arg_3_0:UpdateHpbar()

		return
	end)
	pg.UIMgr.GetInstance():OverlayPanel(arg_3_0._tf)
	pg.UIMgr.GetInstance():OverlayPanel(arg_3_0.layer, {
		pbList = {
			arg_3_0.downBG,
			arg_3_0.attributes[1],
			arg_3_0.attributes[2],
			arg_3_0.attributes[3],
			arg_3_0.top,
			arg_3_0.AdditionBuffTF,
			arg_3_0.EquipmentBuffTF
		}
	})

	return
end

function var_0_0.setPlayerInfo(arg_12_0, arg_12_1)
	arg_12_0.resPanel:setPlayer(arg_12_1)
	setActive(arg_12_0.resPanel._tf, nowWorld():IsSystemOpen(WorldConst.SystemResource))

	return
end

function var_0_0.getCurrentFleet(arg_13_0)
	return nowWorld():GetFleet()
end

function var_0_0.GetCurrentAttachment(arg_14_0)
	local var_14_9000
	local var_14_0 = nowWorld()
	local var_14_1 = var_14_0.GetActiveMap(var_14_9000)
	local var_14_2 = var_14_1:GetFleet()

	return var_14_1:GetCell(var_14_2.row, var_14_2.column).GetAliveAttachment(var_14_0), var_14_1.config.difficulty
end

function var_0_0.GetEnemyLevel(arg_15_0, arg_15_1)
	if arg_15_1.difficulty == ys.Battle.BattleConst.Difficulty.WORLD then
		return WorldConst.WorldLevelCorrect(nowWorld():GetActiveMap().config.expedition_level, arg_15_1.type)
	else
		return arg_15_1.level
	end

	return
end

function var_0_0.UpdateHpbar(arg_16_0)
	local var_16_0 = arg_16_0:GetCurrentAttachment()
	local var_16_1 = arg_16_0:GetDungeonBossData(var_16_0).bossData.hpBarNum
	local var_16_2 = var_16_0:GetHP() or 10000
	local var_16_3 = math.ceil(var_16_1 * var_16_2 / 16)

	setSlider(arg_16_0.hpbar, 0, var_16_1, var_16_3)
	setText(arg_16_0.hpbar:Find("hpcur"), string.format("%d", var_16_3))
	setText(arg_16_0.hpbar:Find("hpamount"), var_16_1)

	local var_16_4 = arg_16_0.hpbar:Find("hp/mask")

	if arg_16_0.hpeffectmat then
		arg_16_0.hpeffectmat:SetFloat("_Mask", var_16_2 / 100)

		local var_16_5 = arg_16_0.hpbar:Find("hp").rect

		var_16_4.localScale = Vector3(var_16_5.width * var_0_1, var_16_5.height * var_0_1, 1)
		var_16_4.localPosition = Vector3.zero

		setLocalScale(arg_16_0.hpbar:Find("xuetiao01"), {
			x = math.clamp(Screen.width / Screen.height, 1.7777777777777777, 2) / 1.7777777777777777
		})
	end

	local var_16_6 = arg_16_0.hpbar:Find("rewards")
	local var_16_7 = pg.world_expedition_data[var_16_0:GetBattleStageId()]
	local var_16_8 = var_16_7 and var_16_7.phase_drop

	setActive(var_16_6, var_16_7 and var_16_7.phase_drop and #var_16_8 > 0)

	local var_16_9 = var_16_2

	if var_16_0:IsPeriodEnemy() then
		var_16_9 = math.min(var_16_2, nowWorld():GetHistoryLowestHP(var_16_0.id))
	end

	local var_16_11 = var_16_6
	local var_16_12 = var_16_6:GetChild(0)

	if var_16_8 then
		local var_16_13 = #var_16_8 or 0

		var_16_10(var_16_11, var_16_12, var_16_13, function(arg_17_0, arg_17_1, arg_17_2)
			if arg_17_0 ~= UIItemList.EventUpdate then
				return
			end

			local var_17_0 = var_16_8[arg_17_1 + 1]

			arg_17_2.anchorMin = Vector2(var_16_8[arg_17_1 + 1][1] / 16, 0.5)
			arg_17_2.anchorMax = Vector2(var_16_8[arg_17_1 + 1][1] / 16, 0.5)

			setAnchoredPosition(arg_17_2, {
				x = 0
			})
			arg_16_0.loader:GetSprite("ui/worldbossinformationui_atlas", var_16_9 <= var_17_0[1] and "reward_empty" or "reward", arg_17_2)

			return
		end)

		local var_16_14 = arg_16_0.hpbar:Find("kedu")

		setLocalScale(var_16_14, {
			x = arg_16_0.hpbar.rect.width / var_16_14.rect.width
		})

		return
	end
end

function var_0_0.GetDungeonBossData(arg_18_0, arg_18_1)
	assert(arg_18_1, "Attachment is null")

	local var_18_0

	_.any(arg_18_0:GetDungeonFile(arg_18_1.config.dungeon_id).stages[1].waves, function(arg_19_0)
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

function var_0_0.GetDungeonFile(arg_21_0, arg_21_1)
	if arg_21_0.dungeonDict[arg_21_1] then
		return arg_21_0.dungeonDict[arg_21_1]
	end

	local var_21_0 = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(arg_21_1)

	arg_21_0.dungeonDict[arg_21_1] = var_21_0

	return var_21_0
end

local var_0_3 = 212
local var_0_4 = 40
local var_0_5 = "fe2222"
local var_0_6 = "92fc63"
local var_0_7 = 70

function var_0_0.updateStageView(arg_22_0)
	local var_22_0, var_22_1 = arg_22_0:GetCurrentAttachment()
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
		for iter_23_0 = 1, #arg_22_0.dropitems do
			local var_23_0 = arg_22_0.dropitems[iter_23_0]:Find("item_tpl")
			local var_23_1 = var_22_5[iter_23_0 + var_22_6]

			setActive(var_23_0, var_22_5[iter_23_0 + var_22_6] ~= nil)

			if var_23_1 then
				updateDrop(var_23_0, {
					type = var_23_1[1],
					id = var_23_1[2]
				})
				onButton(arg_22_0, var_23_0, function()
					arg_22_0:emit(var_0_0.ON_DROP, var_0)

					return
				end, SFX_PANEL)
			end
		end

		setActive(arg_22_0.dropleft, var_22_6 > 0)
		setActive(arg_22_0.dropright, #var_22_5 - var_22_6 > #arg_22_0.dropitems)

		return
	end

	onButton(arg_22_0, arg_22_0.dropright, function()
		var_22_6 = var_22_6 + 1

		var_22_7()

		return
	end)
	onButton(arg_22_0, arg_22_0.dropleft, function()
		var_22_6 = var_22_6 - 1

		var_22_7()

		return
	end)
	;(function()
		for iter_23_0 = 1, #arg_22_0.dropitems do
			local var_23_0 = arg_22_0.dropitems[iter_23_0]:Find("item_tpl")
			local var_23_1 = var_22_5[iter_23_0 + var_22_6]

			setActive(var_23_0, var_22_5[iter_23_0 + var_22_6] ~= nil)

			if var_23_1 then
				updateDrop(var_23_0, {
					type = var_23_1[1],
					id = var_23_1[2]
				})
				onButton(arg_22_0, var_23_0, function()
					arg_22_0:emit(var_0_0.ON_DROP, var_0)

					return
				end, SFX_PANEL)
			end
		end

		setActive(arg_22_0.dropleft, var_22_6 > 0)
		setActive(arg_22_0.dropright, #var_22_5 - var_22_6 > #arg_22_0.dropitems)

		return
	end)()

	local var_22_8 = var_22_4.phase_drop_display and #var_22_4.phase_drop_display > 0

	setActive(arg_22_0.awardBtn, var_22_8)

	local var_22_9 = pg.world_SLGbuff_data[var_22_0:GetWeaknessBuffId()]

	setActive(arg_22_0.weaknesstext, var_22_9 ~= nil)
	setActive(arg_22_0.weaknessbg, var_22_9 ~= nil)

	if var_22_9 then
		setText(arg_22_0.weaknesstext, i18n("word_weakness") .. ": " .. var_22_9.desc)
	end

	if var_22_9 == nil then
		local var_22_10 = var_0_7 or 0

		setAnchoredPosition(arg_22_0.attributeRoot, {
			y = arg_22_0.attributeRootAnchorY - var_22_10
		})
		;(function()
			UIItemList.StaticAlign(arg_22_0.AdditionBuffContainer, arg_22_0.AdditionBuffContainer:GetChild(0), #_.filter(table.mergeArray(var_22_0:GetBuffList(), nowWorld():GetActiveMap():GetBuffList(WorldMap.FactionEnemy, var_22_0)), function(arg_28_0)
				return arg_28_0.id ~= var_0
			end), function(arg_29_0, arg_29_1, arg_29_2)
				if arg_29_0 ~= UIItemList.EventUpdate then
					return
				end

				local var_29_0 = var_0[arg_29_1 + 1]

				setActive(arg_29_2, var_0[arg_29_1 + 1])

				if var_29_0 then
					arg_22_0.loader:GetSprite("world/buff/" .. var_29_0.config.icon, "", arg_29_2:Find("icon"))
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

			setActive(arg_22_0.EquipmentBuffTF, var_30_0)
			setActive(arg_22_0.switchBuffBtn, var_30_0)

			if not var_30_0 then
				return
			end

			UIItemList.StaticAlign(arg_22_0.EquipmentBuffContainer, arg_22_0.EquipmentBuffContainer:GetChild(0), #_.map(var_30_0, function(arg_31_0)
				assert("world_SLGbuff_data Missing ID: " .. (arg_31_0 or "NIL"))

				return pg.world_SLGbuff_data[arg_31_0]
			end), function(arg_32_0, arg_32_1, arg_32_2)
				if arg_32_0 ~= UIItemList.EventUpdate then
					return
				end

				local var_32_0 = var_0[arg_32_1 + 1]

				setActive(arg_32_2, var_0[arg_32_1 + 1])

				if var_32_0 then
					arg_22_0.loader:GetSprite("world/buff/" .. var_32_0.icon, "", arg_32_2:Find("icon"))
					setText(arg_32_2:Find("desc"), var_32_0.desc)
				end

				return
			end)

			return
		end)()
		Canvas.ForceUpdateCanvases()

		arg_22_0.buffListTF.sizeDelta.y = math.max(arg_22_0.AdditionBuffTF.rect.height, arg_22_0.EquipmentBuffTF.rect.height) + 50
		arg_22_0.buffListTF.sizeDelta = arg_22_0.buffListTF.sizeDelta

		arg_22_0:UpdateHpbar()

		local var_22_11 = nowWorld()
		local var_22_12 = var_22_11:GetWorldMapDifficultyBuffLevel()
		local var_22_13 = {
			var_22_12[1] * (1 + var_22_4.expedition_sairenvalueA / 16),
			var_22_12[2] * (1 + var_22_4.expedition_sairenvalueB / 16),
			var_22_12[3] * (1 + var_22_4.expedition_sairenvalueC / 16)
		}
		local var_22_14 = var_22_11:GetWorldMapBuffLevel()
		local var_22_15, var_22_16, var_22_17 = ys.Battle.BattleFormulas.WorldMapRewardAttrEnhance({
			var_22_12[1] * (1 + var_22_4.expedition_sairenvalueA / 16),
			var_22_12[2] * (1 + var_22_4.expedition_sairenvalueB / 16),
			var_22_12[3] * (1 + var_22_4.expedition_sairenvalueC / 16)
		}, var_22_14)
		local var_22_18 = {
			var_22_15,
			var_22_16,
			1 - ys.Battle.BattleFormulas.WorldMapRewardHealingRate(var_22_13, var_22_14)
		}

		for iter_22_2 = 1, #arg_22_0.attributes do
			local var_22_19 = arg_22_0.attributes[iter_22_2]

			setText(arg_22_0.attributes[iter_22_2]:Find("digit"), string.format("%d", var_22_13[iter_22_2]))

			if iter_22_2 == 3 then
				local var_22_20 = 1 - var_22_18[iter_22_2] or var_22_18[iter_22_2] + 1

				setText(var_22_19:Find("desc"), i18n("world_mapbuff_attrtxt_" .. iter_22_2) .. string.format(" %d%%", var_22_20 * 100))

				local var_22_21 = GetOrAddComponent(var_22_19, typeof(UILongPressTrigger))

				var_22_21.onPressed:RemoveAllListeners()
				var_22_21.onReleased:RemoveAllListeners()

				local var_22_22
				local var_22_23

				var_22_21.onPressed:AddListener(function()
					var_22_22 = go(var_22_19:Find("extra")).activeSelf

					setActive(var_22_19:Find("extra"), true)

					var_22_23 = Time.realtimeSinceStartup

					return
				end)
				var_22_21.onReleased:AddListener(function()
					if not var_22_23 or Time.realtimeSinceStartup - var_22_23 < 0.3 then
						setActive(var_22_19:Find("extra"), not var_22_22)
					else
						setActive(var_22_19:Find("extra"), false)
					end

					return
				end)
				setText(var_22_19:Find("extra/enemy"), var_22_13[iter_22_2])
				setText(var_22_19:Find("extra/ally"), var_22_14[iter_22_2])
				setText(var_22_19:Find("extra/result"), string.format("%d%%", var_22_18[iter_22_2] * 100))

				local var_22_24 = var_22_18[iter_22_2] > 0 and arg_22_0.TransformColor(var_0_5) or arg_22_0.TransformColor(var_0_6)

				setTextColor(var_22_19:Find("extra/result"), var_22_24)
				setText(var_22_19:Find("extra/result/arrow"), var_22_18[iter_22_2] == 0 and "" or var_22_18[iter_22_2] > 0 and "↑" or "↓")

				if var_22_18[iter_22_2] ~= 0 then
					local var_22_25 = var_22_18[iter_22_2] > 0 and arg_22_0.TransformColor(var_0_5) or arg_22_0.TransformColor(var_0_6)

					setTextColor(var_22_19:Find("extra/result/arrow"), var_22_25)
				end

				local var_22_26 = var_22_19:Find("extra/allybar")
				local var_22_27 = var_22_19:Find("extra/enemybar")
				local var_22_28 = math.clamp(1 + var_22_18[iter_22_2], 0.75, 3)
				local var_22_29 = var_22_19:Find("extra").rect.width

				var_22_27.sizeDelta = Vector2(var_22_28 * var_22_29 / (var_22_28 + 1) + var_0_2 * 0.5, var_22_27.sizeDelta.y)
				var_22_26.sizeDelta = Vector2(1 * var_22_29 / (var_22_28 + 1) + var_0_2 * 0.5, var_22_26.sizeDelta.y)
			end
		end

		local var_22_30 = var_22_4.battle_character
		local var_22_31 = var_22_4.battle_character and #var_22_30 > 0

		var_22_30 = var_22_4.battle_character and #var_22_30 > 0 and var_22_30 or "world_boss_0"
		arg_22_0.bg:GetComponent(typeof(Image)).enabled = true

		setImageSprite(arg_22_0.bg, GetSpriteFromAtlas("commonbg/" .. var_22_30, var_22_30))
		;(function()
			arg_22_0.bossnameText.text = var_22_3.name

			local var_35_0 = false

			if arg_22_0.bossnameText.preferredWidth > arg_22_0.bossnameText.transform.rect.width then
				arg_22_0.bossnameText.text = string.gsub(var_22_3.name, "「.-」", "\n%1")
				var_35_0 = true
			end

			setAnchoredPosition(arg_22_0.bossNameBanner, {
				y = var_35_0 and -18 or 0
			})

			local var_35_1 = arg_22_0:GetEnemyLevel(var_22_3) or 1

			setText(arg_22_0.bosslevel, i18n("world_level_prefix", var_35_1))
			setActive(arg_22_0.bosslogos[1], var_22_31)
			setActive(arg_22_0.bosslogos[2], not var_22_31)
			setActive(arg_22_0.saomiaoxian, not var_22_31)

			local var_35_2 = ys.Battle.BattleDataFunction.GetMonsterTmpDataFromID(arg_22_0:GetDungeonBossData(var_22_0).monsterTemplateID)

			arg_22_0.loader:GetSprite("shiptype", ShipType.Type2BattlePrint(var_35_2.type), arg_22_0.bossTypeIcon, true)
			setText(arg_22_0.bossArmorText, ArmorType.Type2Name(var_35_2.armor_type))

			return
		end)()

		local var_22_32 = ys.Battle.BattleAttr.IsWorldMapRewardAttrWarning(var_22_13, var_22_14)

		setActive(arg_22_0.dangerMark, var_22_32)

		if var_22_32 then
			local var_22_34 = arg_22_0.dangerMark
			local var_22_35 = {}

			if var_22_31 then
				var_22_35.x = var_0_4 or var_0_3

				var_22_33(var_22_34, var_22_35)

				if not var_22_31 then
					if var_22_3.icon_type == 1 then
						arg_22_0.loader:GetSprite("enemies/" .. var_22_3.icon, nil, arg_22_0.bosssprite)
					elseif var_22_3.icon_type == 2 then
						arg_22_0.bosssprite:GetComponent(typeof(Image)).enabled = false

						arg_22_0.loader:GetSpine(var_22_3.icon, function(arg_36_0)
							arg_36_0:SetLocalScale(Vector3(var_22_4.battle_spine_size * 0.01, var_22_4.battle_spine_size * 0.01, 1))
							arg_36_0:SetAnchoredPosition(Vector3.New(0, -150, 0))
							arg_36_0:SetAction(ChapterConst.ShipIdleAction, 0)

							arg_36_0:GetSkeletonGraphic().raycastTarget = false

							arg_36_0:SetParent(arg_22_0.bosssprite)

							return
						end, arg_22_0.bosssprite)
					end
				end

				return
			end
		end
	end
end

function var_0_0.onBackPressed(arg_37_0)
	if arg_37_0.awardPanel and arg_37_0.awardPanel:isShowing() then
		arg_37_0.awardPanel:Hide()

		return
	end

	triggerButton(arg_37_0.backBtn)

	return
end

function var_0_0.willExit(arg_38_0)
	arg_38_0:DestroyAwardPanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_38_0.layer, arg_38_0._tf)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_38_0._tf)

	if arg_38_0.resPanel then
		arg_38_0.resPanel:exit()

		arg_38_0.resPanel = nil
	end

	for iter_38_0, iter_38_1 in pairs(arg_38_0.dungeonDict) do
		ys.Battle.BattleDataFunction.ClearDungeonCfg(iter_38_0)
	end

	table.clear(arg_38_0.dungeonDict)
	arg_38_0.loader:Clear()

	return
end

function var_0_0.GetAwardPanel(arg_39_0)
	arg_39_0.awardPanel = arg_39_0.awardPanel or WorldBossHPAwardPanel.New(arg_39_0._tf, arg_39_0.event, arg_39_0.contextData)

	arg_39_0.awardPanel:Load()

	return arg_39_0.awardPanel
end

function var_0_0.DestroyAwardPanel(arg_40_0)
	if not arg_40_0.awardPanel then
		return
	end

	arg_40_0.awardPanel:Destroy()

	arg_40_0.awardPanel = nil

	return
end

function var_0_0.TransformColor(arg_41_0)
	return Color.New(tonumber(string.sub(arg_41_0, 1, 2), 16) / 255, tonumber(string.sub(arg_41_0, 3, 4), 16) / 255, tonumber(string.sub(arg_41_0, 5, 6), 16) / 255)
end

return var_0_0

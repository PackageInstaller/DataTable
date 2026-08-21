local var_0_0 = class("DockyardScene", import("..base.BaseUI"))

var_0_0.MODE_OVERVIEW = "overview"
var_0_0.MODE_DESTROY = "destroy"
var_0_0.MODE_SELECT = "select"
var_0_0.MODE_MOD = "modify"
var_0_0.MODE_WORLD = "world"
var_0_0.MODE_REMOULD = "remould"
var_0_0.MODE_UPGRADE = "upgrade"
var_0_0.MODE_GUILD_BOSS = "guildboss"
var_0_0.MODE_SHIP_PHANTOM = "phantom"
var_0_0.TITLE_CN_OVERVIEW = i18n("word_dockyard")
var_0_0.TITLE_CN_UPGRADE = i18n("word_dockyardUpgrade")
var_0_0.TITLE_CN_DESTROY = i18n("word_dockyardDestroy")
var_0_0.TITLE_EN_OVERVIEW = "dockyard"
var_0_0.TITLE_EN_UPGRADE = "modernization"
var_0_0.TITLE_EN_DESTROY = "retirement"
var_0_0.PRIOR_MODE_EQUIP_UP = 1
var_0_0.PRIOR_MODE_SHIP_UP = 2

function var_0_0.getUIName(arg_1_0)
	return "DockyardUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.contextData.mode = defaultValue(arg_2_0.contextData.mode, var_0_0.MODE_SELECT)
	arg_2_0.contextData.otherSelectedIds = defaultValue(arg_2_0.contextData.otherSelectedIds, {})
	arg_2_0.teamTypeFilter = arg_2_0.contextData.teamFilter
	arg_2_0.selectedMin = arg_2_0.contextData.selectedMin or 1
	arg_2_0.leastLimitMsg = arg_2_0.contextData.leastLimitMsg
	arg_2_0.selectedMax = arg_2_0.contextData.selectedMax or 0
	arg_2_0.contextData.selectedIds = arg_2_0.contextData.selectedIds or {}

	if arg_2_0.contextData.infoShipId then
		table.insert(arg_2_0.contextData.selectedIds, arg_2_0.contextData.infoShipId)

		arg_2_0.contextData.infoShipId = nil
	end

	arg_2_0.selectedIds = underscore(arg_2_0.contextData.selectedIds):chain():select(function(arg_3_0)
		local var_3_0 = getProxy(BayProxy)

		return var_3_0:RawGetShipById(arg_3_0) ~= nil
	end):first(arg_2_0.selectedMax):value()
	arg_2_0.contextData.selectedIds = nil
	arg_2_0.checkShip = arg_2_0.contextData.onShip or function(arg_4_0, arg_4_1, arg_4_2)
		return true
	end
	arg_2_0.onCancelShip = arg_2_0.contextData.onCancelShip or function(arg_5_0, arg_5_1, arg_5_2)
		return true
	end
	arg_2_0.onClick = arg_2_0.contextData.onClick or function(arg_6_0, arg_6_1, arg_6_2)
		arg_2_0:emit(DockyardMediator.ON_SHIP_DETAIL, arg_6_0, arg_6_1, arg_6_2)

		return
	end
	arg_2_0.confirmSelect = arg_2_0.contextData.confirmSelect
	arg_2_0.callbackQuit = arg_2_0.contextData.callbackQuit
	arg_2_0.onSelected = arg_2_0.contextData.onSelected or function(arg_7_0, arg_7_1)
		warning("not implemented.")

		return
	end
	arg_2_0.blurPanel = arg_2_0._tf:Find("blur_panel")
	arg_2_0.settingBtn = arg_2_0.blurPanel:Find("adapt/left_length/frame/setting")
	arg_2_0.settingPanel = DockyardQuickSelectSettingPage.New(arg_2_0._tf, arg_2_0.event)

	arg_2_0.settingPanel:OnSettingChanged(function()
		arg_2_0:unselecteAllShips()

		return
	end)

	arg_2_0.topPanel = arg_2_0.blurPanel:Find("adapt/top")
	arg_2_0.sortBtn = arg_2_0.topPanel:Find("sort_button")
	arg_2_0.sortImgAsc = arg_2_0.sortBtn:Find("asc")
	arg_2_0.sortImgDesc = arg_2_0.sortBtn:Find("desc")
	arg_2_0.leftTipsText = arg_2_0.topPanel:Find("capacity")

	onButton(arg_2_0, arg_2_0.leftTipsText:Find("switch"), function()
		arg_2_0.isCapacityMeta = not arg_2_0.isCapacityMeta

		arg_2_0:updateCapacityDisplay()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.leftTipsText:Find("plus"), function()
		gotoChargeScene()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.leftTipsText:Find("tip"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			content = i18n("specialshipyard_tip")
		})

		return
	end, SFX_PANEL)
	setActive(arg_2_0.leftTipsText, false)

	arg_2_0.indexBtn = arg_2_0.topPanel:Find("index_button")
	arg_2_0.switchPanel = arg_2_0.topPanel:Find("switch")
	arg_2_0.preferenceAndAttrContainer = arg_2_0.switchPanel:Find("toggles")
	arg_2_0.preferenceBtn = arg_2_0.switchPanel:Find("toggles/preference_toggle")
	arg_2_0.attrBtn = arg_2_0.switchPanel:Find("toggles/attr_toggle")
	arg_2_0.modLockFilter = arg_2_0.topPanel:Find("mod_flter_lock")
	arg_2_0.modLeveFilter = arg_2_0.topPanel:Find("mod_flter_level")
	arg_2_0.energyDescTF = arg_2_0._tf:Find("energy_desc")
	arg_2_0.energyDescTextTF = arg_2_0.energyDescTF:Find("Text")
	arg_2_0.selectPanel = arg_2_0.blurPanel:Find("select_panel")
	arg_2_0.bottomTipsText = arg_2_0.selectPanel:Find("tip")
	arg_2_0.bottomTipsWithFrame = arg_2_0.selectPanel:Find("tipwithframe")

	setText(arg_2_0.selectPanel:Find("bottom_info/bg_input/selected"), i18n("disassemble_selected") .. ":")

	arg_2_0.awardTF = arg_2_0.selectPanel:Find("bottom_info/bg_award")

	setText(arg_2_0.awardTF:Find("label"), i18n("disassemble_available") .. ":")

	arg_2_0.modAttrsTF = arg_2_0.selectPanel:Find("bottom_info/bg_mod")
	arg_2_0.viewEquipmentBtn = arg_2_0.selectPanel:Find("view_equipments")
	arg_2_0.tipPanel = arg_2_0.blurPanel:Find("TipPanel")

	setActive(arg_2_0.tipPanel, false)

	arg_2_0.worldPanel = arg_2_0.blurPanel:Find("world_port_panel")

	setActive(arg_2_0.worldPanel, arg_2_0.contextData.mode == var_0_0.MODE_WORLD)

	arg_2_0.assultBtn = arg_2_0.blurPanel:Find("adapt/top/assult_btn")
	arg_2_0.stampBtn = arg_2_0.topPanel:Find("stamp")
	arg_2_0.isRemouldOrUpgradeMode = arg_2_0.contextData.mode == var_0_0.MODE_REMOULD or arg_2_0.contextData.mode == var_0_0.MODE_UPGRADE

	setActive(arg_2_0.modLeveFilter, arg_2_0.isRemouldOrUpgradeMode)
	setActive(arg_2_0.modLockFilter, arg_2_0.isRemouldOrUpgradeMode)
	setActive(arg_2_0.assultBtn, arg_2_0.contextData.mode == var_0_0.MODE_GUILD_BOSS)
	switch(arg_2_0.contextData.mode, {
		[var_0_0.MODE_OVERVIEW] = function()
			arg_2_0.selecteEnabled = false

			return
		end,
		[var_0_0.MODE_DESTROY] = function()
			arg_2_0.selecteEnabled = true
			arg_2_0.blacklist = {}
			arg_2_0.destroyResList = UIItemList.New(arg_2_0.awardTF:Find("res_list"), arg_2_0.awardTF:Find("res_list/res"))

			return
		end,
		[var_0_0.MODE_MOD] = function()
			arg_2_0.selecteEnabled = true

			setText(arg_2_0.modAttrsTF:Find("title/Text"), i18n("word_mod_value"))

			arg_2_0.modAttrContainer = arg_2_0.modAttrsTF:Find("attrs")

			return
		end,
		[var_0_0.MODE_SHIP_PHANTOM] = function()
			arg_2_0.selecteEnabled = false

			return
		end
	}, function()
		arg_2_0.selecteEnabled = true

		return
	end)

	local var_2_0 = arg_2_0.selecteEnabled and arg_2_0.contextData.mode ~= var_0_0.MODE_WORLD

	setActive(arg_2_0.selectPanel, var_2_0)
	setActive(arg_2_0.worldPanel, arg_2_0.contextData.mode == var_0_0.MODE_WORLD)

	local var_2_1 = arg_2_0.contextData.mode == var_0_0.MODE_DESTROY

	setActive(arg_2_0.settingBtn, arg_2_0.contextData.mode == var_0_0.MODE_DESTROY)
	setActive(arg_2_0.selectPanel:Find("quick_select"), var_2_1)

	if arg_2_0.contextData.priorEquipUpShipIDList and arg_2_0.contextData.priorMode then
		setActive(arg_2_0.tipPanel, true)

		local var_2_2 = arg_2_0.tipPanel:Find("EquipUP")
		local var_2_3 = arg_2_0.tipPanel:Find("ShipUP")

		setText(var_2_2, i18n("fightfail_choiceequip"))
		setText(var_2_3, i18n("fightfail_choicestrengthen"))
		setActive(var_2_2, arg_2_0.contextData.priorMode == var_0_0.PRIOR_MODE_EQUIP_UP)
		setActive(var_2_3, arg_2_0.contextData.priorMode == var_0_0.PRIOR_MODE_SHIP_UP)
	end

	arg_2_0.togglePhantom = arg_2_0._tf:Find("blur_panel/adapt/left_length/frame/toggle_phantom")

	onToggle(arg_2_0, arg_2_0.togglePhantom, function(arg_17_0)
		if arg_2_0.inPhantom ~= arg_17_0 then
			arg_2_0.inPhantom = arg_17_0

			arg_2_0:SwitchContainerDisplay()
		end

		return
	end, SFX_PANEL)
	setActive(arg_2_0.togglePhantom, false)

	arg_2_0.helpPhantom = arg_2_0._tf:Find("blur_panel/adapt/left_length/frame/help_phantom")

	onButton(arg_2_0, arg_2_0.helpPhantom, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("projection_help")
		})

		return
	end, SFX_PANEL)

	local var_2_4 = arg_2_0.contextData.mode == var_0_0.MODE_SHIP_PHANTOM and "phantom" or "dockyard"

	eachChild(arg_2_0.topPanel:Find("titles"), function(arg_19_0, arg_19_1)
		setActive(arg_19_0, arg_19_0.name == var_2_4)

		return
	end)

	arg_2_0.listEmptyTF = arg_2_0._tf:Find("empty")

	setActive(arg_2_0.listEmptyTF, false)

	arg_2_0.listEmptyTxt = arg_2_0.listEmptyTF:Find("Text")

	setText(arg_2_0.listEmptyTxt, i18n("list_empty_tip_dockyardui"))

	arg_2_0.destroyPage = ShipDestroyPage.New(arg_2_0._tf, arg_2_0.event)

	arg_2_0.destroyPage:SetCardClickCallBack(function(arg_20_0)
		arg_2_0.blacklist[arg_20_0.shipVO:getGroupId()] = true

		local var_20_0 = table.indexof(arg_2_0.selectedIds, arg_20_0.shipVO.id)

		if var_20_0 and var_20_0 > 0 then
			table.remove(arg_2_0.selectedIds, var_20_0)
		end

		arg_2_0:updateDestroyRes()
		arg_2_0:updateSelected()

		return
	end)
	arg_2_0.destroyPage:SetConfirmCallBack(function()
		local var_21_0, var_21_1 = arg_2_0:checkDestroyGold()

		if not var_21_1 then
			table.insert({}, function(arg_22_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("oil_max_tip_title") .. i18n("resource_max_tip_retire_1"),
					onYes = arg_22_0
				})

				return
			end)
		end

		local var_21_2 = underscore.map(arg_2_0.selectedIds, function(arg_23_0)
			return arg_2_0.shipVOsById[arg_23_0]
		end)

		table.insert({}, function(arg_24_0)
			arg_2_0:checkDestroyShips(var_21_2, arg_24_0)

			return
		end)
		seriesAsync({}, function()
			arg_2_0:emit(DockyardMediator.ON_DESTROY_SHIPS, arg_2_0.selectedIds)

			return
		end)

		return
	end)

	arg_2_0.destroyConfirmWindow = ShipDestoryConfirmWindow.New(arg_2_0._tf, arg_2_0.event)
	arg_2_0.searchBar = RecordableSearchBar.New(RecordableSearchBar.CreateData({
		refresh_pos_when_expand = true,
		holder = i18n("dockyard_search_holder"),
		onActive = function(arg_26_0)
			setActive(arg_2_0.preferenceAndAttrContainer, not arg_26_0)

			return
		end,
		onInputChanged = function()
			arg_2_0:filter()

			return
		end,
		key = arg_2_0.__cname,
		parent = arg_2_0.switchPanel,
		expand_parent = arg_2_0.blurPanel:Find("adapt"),
		anchoredPosition = Vector3(-33, -33, 0)
	}))

	return
end

function var_0_0.SwitchContainerDisplay(arg_28_0)
	arg_28_0.isPhantomMode = arg_28_0.contextData.mode == var_0_0.MODE_SHIP_PHANTOM or arg_28_0.inPhantom

	setActive(arg_28_0.switchPanel, not arg_28_0.isRemouldOrUpgradeMode and not arg_28_0.isPhantomMode)
	setActive(arg_28_0.indexBtn, not arg_28_0.isRemouldOrUpgradeMode and not arg_28_0.isPhantomMode)
	setActive(arg_28_0.sortBtn, not arg_28_0.isRemouldOrUpgradeMode and not arg_28_0.isPhantomMode)
	setActive(arg_28_0._tf:Find("main/ship_container"), not arg_28_0.isPhantomMode)
	setActive(arg_28_0._tf:Find("main/phantom_container"), arg_28_0.isPhantomMode)
	setActive(arg_28_0.preferenceBtn, not arg_28_0.isPhantomMode)
	arg_28_0:updateBarInfo()
	setActive(arg_28_0.helpPhantom, arg_28_0.contextData.mode == var_0_0.MODE_SHIP_PHANTOM)

	if pg.SeriesGuideMgr.GetInstance():isEnd() and PlayerPrefs.GetInt("PHANTOM_HELP_FIRST", 0) == 0 then
		PlayerPrefs.SetInt("PHANTOM_HELP_FIRST", 1)
		triggerButton(arg_28_0.helpPhantom)
	end

	switch(tobool(arg_28_0.isPhantomMode), {
		[true] = function()
			arg_28_0.initDic = arg_28_0.initDic or {}

			if arg_28_0.initDic.phantom then
				return
			end

			arg_28_0.initDic.phantom = true

			local var_29_0 = arg_28_0._tf:Find("main/phantom_container/title/content")

			UIItemList.StaticAlign(var_29_0, var_29_0:GetChild(0), getProxy(TechnologyProxy):getConfigMaxVersion() + 1, function(arg_30_0, arg_30_1, arg_30_2)
				if arg_30_0 == UIItemList.EventUpdate then
					arg_30_2.name = "phase_" .. arg_30_1

					GetImageSpriteFromAtlasAsync("ui/dockyardui_atlas", arg_30_1, arg_30_2:Find("on"))
					GetImageSpriteFromAtlasAsync("ui/dockyardui_atlas", arg_30_1, arg_30_2:Find("off"))
					onToggle(arg_28_0, arg_30_2, function(arg_31_0)
						if arg_31_0 then
							arg_28_0.selectVersion = arg_30_1
							arg_28_0.filterBluePrint = underscore.filter(arg_28_0.shipBluePrints, function(arg_32_0)
								return arg_30_1 == 0 or arg_32_0:getConfig("blueprint_version") == arg_30_1
							end)

							arg_28_0.phantomContainer:SetTotalCount(#arg_28_0.filterBluePrint, 0)
						end

						return
					end, SFX_PANEL)
				end

				return
			end)
			setActive(arg_28_0._tf:Find("main/phantom_container/view/tpl"), false)

			arg_28_0.phantomContainer = arg_28_0._tf:Find("main/phantom_container/view/groups"):GetComponent("LScrollRect")
			arg_28_0.phantomContainer.enabled = true
			arg_28_0.phantomContainer.decelerationRate = 0.07

			function arg_28_0.phantomContainer.onInitItem(arg_33_0)
				arg_28_0:getOrInitPhantom(arg_33_0)
				ClearTweenItemAlphaAndWhite(arg_33_0)

				return
			end

			function arg_28_0.phantomContainer.onUpdateItem(arg_34_0, arg_34_1)
				arg_28_0:updatePhantomGroup(arg_28_0.filterBluePrint[arg_34_0 + 1], arg_34_1)
				TweenItemAlphaAndWhite(arg_34_1)

				return
			end

			function arg_28_0.phantomContainer.onReturnItem(arg_35_0, arg_35_1)
				if arg_28_0.exited then
					return
				end

				arg_28_0:getOrInitPhantom(arg_35_1):clear()
				ClearTweenItemAlphaAndWhite(arg_35_1)

				return
			end

			arg_28_0.scrollPhantoms = {}
			arg_28_0.phantomGroupDic = {}

			local var_29_1 = 0

			if arg_28_0.contextData.techVersion and #underscore.filter(arg_28_0.shipBluePrints, function(arg_36_0)
				return arg_28_0.contextData.techVersion == 0 or arg_36_0:getConfig("blueprint_version") == arg_28_0.contextData.techVersion
			end) > 0 then
				var_29_1 = arg_28_0.contextData.techVersion
			end

			arg_28_0.contextData.techVersion = nil

			triggerToggle(arg_28_0._tf:Find("main/phantom_container/title/content"):GetChild(var_29_1), true)

			return
		end,
		[false] = function()
			arg_28_0.initDic = arg_28_0.initDic or {}

			if arg_28_0.initDic.ship then
				return
			end

			arg_28_0.initDic.ship = true
			arg_28_0.shipContainer = arg_28_0._tf:Find("main/ship_container/ships"):GetComponent("LScrollRect")
			arg_28_0.shipContainer.enabled = true
			arg_28_0.shipContainer.decelerationRate = 0.07

			function arg_28_0.shipContainer.onInitItem(arg_38_0)
				arg_28_0:onInitItem(arg_38_0)

				return
			end

			function arg_28_0.shipContainer.onUpdateItem(arg_39_0, arg_39_1)
				arg_28_0:onUpdateItem(arg_39_0, arg_39_1)

				return
			end

			function arg_28_0.shipContainer.onReturnItem(arg_40_0, arg_40_1)
				arg_28_0:onReturnItem(arg_40_0, arg_40_1)

				return
			end

			function arg_28_0.shipContainer.onStart()
				arg_28_0:updateSelected()

				return
			end

			arg_28_0.shipLayout = arg_28_0._tf:Find("main/ship_container/ships")
			arg_28_0.scrollItems = {}
			arg_28_0.cardItemDic = {}

			if _G[arg_28_0.contextData.preView] then
				arg_28_0.sortIndex = _G[arg_28_0.contextData.preView].sortIndex or ShipIndexConst.SortLevel
				arg_28_0.selectAsc = _G[arg_28_0.contextData.preView].selectAsc or false
				arg_28_0.typeIndex = _G[arg_28_0.contextData.preView].typeIndex or ShipIndexConst.TypeAll
				arg_28_0.campIndex = _G[arg_28_0.contextData.preView].campIndex or ShipIndexConst.CampAll
				arg_28_0.rarityIndex = _G[arg_28_0.contextData.preView].rarityIndex or ShipIndexConst.RarityAll
				arg_28_0.extraIndex = _G[arg_28_0.contextData.preView].extraIndex or ShipIndexConst.ExtraAll
				arg_28_0.commonTag = _G[arg_28_0.contextData.preView].commonTag or Ship.PREFERENCE_TAG_NONE
			elseif arg_28_0.contextData.sortData then
				arg_28_0.sortIndex = arg_28_0.contextData.sortData.sort or ShipIndexConst.SortLevel
				arg_28_0.selectAsc = arg_28_0.contextData.sortData.Asc or false
				arg_28_0.typeIndex = arg_28_0.contextData.sortData.typeIndex or ShipIndexConst.TypeAll
				arg_28_0.campIndex = arg_28_0.contextData.sortData.campIndex or ShipIndexConst.CampAll
				arg_28_0.rarityIndex = arg_28_0.contextData.sortData.rarityIndex or ShipIndexConst.RarityAll
				arg_28_0.extraIndex = arg_28_0.contextData.sortData.extraIndex or ShipIndexConst.ExtraAll
				arg_28_0.commonTag = arg_28_0.contextData.sortData.commonTag or Ship.PREFERENCE_TAG_NONE
			else
				local var_37_0 = arg_28_0

				var_37_0.selectAsc = DockyardScene.selectAsc or false
				arg_28_0.sortIndex = DockyardScene.sortIndex or ShipIndexConst.SortLevel
				arg_28_0.typeIndex = DockyardScene.typeIndex or ShipIndexConst.TypeAll
				arg_28_0.campIndex = DockyardScene.campIndex or ShipIndexConst.CampAll
				arg_28_0.rarityIndex = DockyardScene.rarityIndex or ShipIndexConst.RarityAll
				arg_28_0.extraIndex = DockyardScene.extraIndex or ShipIndexConst.ExtraAll
				arg_28_0.commonTag = DockyardScene.commonTag or Ship.PREFERENCE_TAG_NONE
			end

			arg_28_0:updateIndexDatas()
			triggerToggle(arg_28_0.preferenceBtn, arg_28_0.commonTag == Ship.PREFERENCE_TAG_COMMON)
			arg_28_0:initIndexPanel()

			arg_28_0.itemDetailType = -1

			if arg_28_0.contextData.mode == var_0_0.MODE_DESTROY then
				arg_28_0.blacklist = {}
				arg_28_0.selectPanel:GetComponent("HorizontalLayoutGroup").padding.right = 50

				setActive(arg_28_0.selectPanel:Find("quick_select"), true)
				setActive(arg_28_0.settingBtn, true)
			else
				arg_28_0.selectPanel:GetComponent("HorizontalLayoutGroup").padding.right = 250

				setActive(arg_28_0.selectPanel:Find("quick_select"), false)
				setActive(arg_28_0.settingBtn, false)
			end

			if arg_28_0.contextData.mode == var_0_0.MODE_GUILD_BOSS then
				arg_28_0.isShowAssultShips = false

				triggerToggle(arg_28_0.assultBtn, true)

				arg_28_0.guildShipEquipmentsPage = GuildShipEquipmentsPage.New(arg_28_0._tf, arg_28_0.event)

				arg_28_0.guildShipEquipmentsPage:SetCallBack(function()
					arg_28_0:TriggerCard(-1)

					return
				end, function()
					arg_28_0:TriggerCard(1)

					return
				end)
			end

			eachChild(arg_28_0.attrBtn, function(arg_44_0)
				setActive(arg_44_0, false)

				return
			end)

			arg_28_0.isFormTactics = arg_28_0.contextData.prevPage == "NewNavalTacticsMediator"

			local var_37_1 = arg_28_0.attrBtn:Find("off"):GetComponent("Image")
			local var_37_2 = arg_28_0.attrBtn:Find("on"):GetComponent("Image")

			if arg_28_0.isFormTactics then
				GetImageSpriteFromAtlasAsync("ui/dockyardui_atlas", "skill_off", var_37_1)
				GetImageSpriteFromAtlasAsync("ui/dockyardui_atlas", "skill_on", var_37_2)
			else
				GetImageSpriteFromAtlasAsync("ui/dockyardui_atlas", "attr_off", var_37_1)
				GetImageSpriteFromAtlasAsync("ui/dockyardui_atlas", "attr_on", var_37_2)
			end

			triggerButton(arg_28_0.attrBtn)

			if arg_28_0.isRemouldOrUpgradeMode then
				local var_37_3 = getProxy(SettingsProxy)

				arg_28_0.isFilterLevelForMod = var_37_3:GetDockYardLevelBtnFlag()

				arg_28_0:OnSwitch(arg_28_0.modLeveFilter, arg_28_0.isFilterLevelForMod, function(arg_45_0)
					arg_28_0.isFilterLevelForMod = arg_45_0

					arg_28_0:filter()

					return
				end)

				arg_28_0.isFilterLockForMod = var_37_3:GetDockYardLockBtnFlag()

				arg_28_0:OnSwitch(arg_28_0.modLockFilter, arg_28_0.isFilterLockForMod, function(arg_46_0)
					arg_28_0.isFilterLockForMod = arg_46_0

					arg_28_0:filter()

					return
				end)
			end

			arg_28_0.shipContainer:GetComponentInChildren(typeof(GridLayoutGroup)).constraintCount = 7

			arg_28_0:filter()

			return
		end
	})

	if arg_28_0.isPhantomMode then
		setActive(arg_28_0.listEmptyTF, #arg_28_0.filterBluePrint == 0)
	else
		setActive(arg_28_0.listEmptyTF, #arg_28_0.shipVOs <= 0)
	end

	return
end

function var_0_0.isDefaultStatus(arg_47_0)
	return arg_47_0.sortIndex == ShipIndexConst.SortLevel and (not arg_47_0.typeIndex or arg_47_0.typeIndex == ShipIndexConst.TypeAll) and (not arg_47_0.campIndex or arg_47_0.campIndex == ShipIndexConst.CampAll) and (not arg_47_0.rarityIndex or arg_47_0.rarityIndex == ShipIndexConst.RarityAll) and (not arg_47_0.extraIndex or arg_47_0.extraIndex == ShipIndexConst.ExtraAll)
end

function var_0_0.setShipsCount(arg_48_0, arg_48_1, arg_48_2)
	arg_48_0.shipsCount = arg_48_1
	arg_48_0.specialShipCount = arg_48_2

	return
end

function var_0_0.GetCard(arg_49_0, arg_49_1)
	return DockyardShipItem.New(arg_49_1, arg_49_0.contextData.hideTagFlags, arg_49_0.contextData.blockTagFlags)
end

function var_0_0.OnClickCard(arg_50_0, arg_50_1)
	if arg_50_1.shipVO then
		local var_50_0 = pg.CriMgr.GetInstance()
		local var_50_1 = var_50_0

		if not arg_50_0.selecteEnabled then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_CLICK)

			DockyardScene.value = arg_50_0.shipContainer.value

			arg_50_0.onClick(arg_50_1.shipVO, arg_50_0.shipVOs)

			goto label_50_0
		end

		::label_50_0::

		if table.contains(arg_50_0.selectedIds, arg_50_1.shipVO.id) then
			do
				local var_50_3 = SFX_UI_CANCEL or SFX_UI_FORMATION_SELECT

				var_50_2(var_50_1, var_50_3)
				arg_50_0:selectShip(arg_50_1.shipVO)

				if false then
					pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_CLICK)

					if arg_50_0.callbackQuit then
						arg_50_0.onSelected({}, function()
							arg_50_0:back()

							return
						end)
					elseif not arg_50_1.isLoading then
						arg_50_0.onSelected({})
						arg_50_0:back()
					end
				end
			end

			return
		end
	end
end

function var_0_0.OnClickPhantom(arg_52_0, arg_52_1)
	if arg_52_1.phantomId == 0 then
		return
	else
		arg_52_0:emit(DockyardMediator.CHANGE_SKIN, arg_52_1)
	end

	return
end

function var_0_0.onInitItem(arg_53_0, arg_53_1)
	if arg_53_0.scrollItems[arg_53_1] then
		return arg_53_0.scrollItems[arg_53_1]
	end

	local var_53_0 = arg_53_0:GetCard(arg_53_1)

	var_53_0:updateDetail(arg_53_0.itemDetailType)

	var_53_0.isLoading = true

	onButton(arg_53_0, var_53_0.go, function()
		arg_53_0:OnClickCard(var_53_0)

		return
	end)

	local var_53_1 = GetOrAddComponent(var_53_0.go, "UILongPressTrigger").onLongPressed

	if arg_53_0.contextData.preView == NewBackYardShipInfoLayer.__cname then
		var_53_1:RemoveAllListeners()
		var_53_1:AddListener(function()
			if var_53_0.shipVO then
				arg_53_0.contextData.selectedIds = arg_53_0.selectedIds

				arg_53_0.onClick(var_53_0.shipVO, underscore.select(arg_53_0.shipVOs, function(arg_56_0)
					return arg_56_0
				end), arg_53_0.contextData)
			end

			return
		end)
	else
		var_53_1:RemoveAllListeners()
	end

	arg_53_0.scrollItems[arg_53_1] = var_53_0

	return var_53_0
end

function var_0_0.getOrInitPhantom(arg_57_0, arg_57_1)
	arg_57_0.scrollPhantoms[arg_57_1] = arg_57_0.scrollPhantoms[arg_57_1] or {
		isClear = true,
		go = arg_57_1,
		tf = tf(arg_57_1),
		updateSelected = function(arg_58_0, arg_58_1)
			arg_58_0.shipCard:updateSelected(arg_58_1[0])
			eachChild(arg_58_0.tf:Find("phantoms"), function(arg_59_0, arg_59_1)
				arg_59_1 = arg_59_1 + 1

				setActive(arg_59_0:Find("selected"), arg_58_0.phantoms[arg_59_1 + 1] and arg_58_1[arg_58_0.phantoms[arg_59_1 + 1].phantomId])

				return
			end)

			return
		end,
		clear = function(arg_60_0)
			if arg_60_0.isClear then
				return
			end

			arg_60_0.shipCard:clear()

			arg_60_0.isClear = true

			return
		end
	}

	return arg_57_0.scrollPhantoms[arg_57_1]
end

function var_0_0.updatePhantomGroup(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = arg_61_0:getOrInitPhantom(arg_61_2)

	var_61_0.isClear = false
	arg_61_0.phantomGroupDic[arg_61_1.shipId] = arg_61_2
	var_61_0.shipCard = var_61_0.shipCard or arg_61_0:GetCard(var_61_0.tf:Find("card"):GetChild(0).gameObject)

	local var_61_1 = arg_61_0.shipVOsById[arg_61_1.shipId]:getAllShipPhantom()

	assert(var_61_1[1].phantomId == 0)

	var_61_0.phantoms = var_61_1

	var_61_0.shipCard:update(var_61_1[1])
	var_61_0.shipCard:updateSelected(underscore.any(arg_61_0.selectedIds, function(arg_62_0)
		return arg_62_0 == var_61_1[1].id
	end))
	arg_61_0:updateItemBlackBlock(var_61_0.shipCard)

	var_61_0.shipCard.isLoading = false

	var_61_0.shipCard:updateIntimacyEnergy(false)
	var_61_0.shipCard:updateIntimacy(false)
	onButton(arg_61_0, var_61_0.shipCard.tr, function()
		arg_61_0:OnClickPhantom(var_61_1[1])

		return
	end, SFX_UI_CLICK)

	local var_61_2 = var_61_0.tf:Find("phantoms")

	UIItemList.StaticAlign(var_61_2, var_61_2:GetChild(0), getGameset("technology_shadow_num")[1], function(arg_64_0, arg_64_1, arg_64_2)
		arg_64_1 = arg_64_1 + 1

		if arg_64_0 == UIItemList.EventUpdate then
			local var_64_0 = var_61_1[arg_64_1 + 1]

			setActive(arg_64_2:Find("skin"), tobool(var_61_1[arg_64_1 + 1]))
			setActive(arg_64_2:Find("lock"), not var_64_0)

			if var_64_0 then
				GetImageSpriteFromAtlasAsync("shipYardIcon/" .. var_64_0:getPainting(), "", arg_64_2:Find("skin/Image"))
				changeToScrollText(arg_64_2:Find("skin/name/Text"), pg.ship_skin_template[var_64_0:getSkinId()].name)
				setActive(arg_64_2:Find("skin/status"), false)

				local var_64_1 = var_64_0:GetShipPhantomMark()

				setActive(arg_64_2:Find("selected"), underscore.any(var_64_2, function(arg_65_0)
					return var_64_1 == arg_65_0
				end))
				setActive(arg_64_2:Find("skin/mark/base"), arg_61_0.contextData.mode ~= var_0_0.MODE_SHIP_PHANTOM)
				setActive(arg_64_2:Find("skin/mark/toggle"), arg_61_0.contextData.mode == var_0_0.MODE_SHIP_PHANTOM)

				local var_64_3 = var_64_0:getRandomFlag()

				onToggle(arg_61_0, arg_64_2:Find("skin/mark/toggle"), function(arg_66_0)
					if arg_66_0 ~= var_64_3 then
						var_64_3 = arg_66_0

						arg_61_0:emit(DockyardMediator.CHANGE_RANDOM_FLAG, var_64_0:GetShipPhantomMark(), var_64_3)
					end

					return
				end, SFX_UI_CLICK)
				triggerToggle(arg_64_2:Find("skin/mark/toggle"), (var_64_0:getRandomFlag()))
			else
				setActive(arg_64_2:Find("selected"), false)
			end

			onButton(arg_61_0, arg_64_2, function()
				if var_64_0 then
					arg_61_0:OnClickPhantom(var_64_0)
				else
					pg.TipsMgr.GetInstance():ShowTips(i18n("shadow_unlock_tip"))
				end

				return
			end, SFX_UI_CLICK)
		end

		return
	end)

	return
end

function var_0_0.showEnergyDesc(arg_68_0, arg_68_1, arg_68_2)
	if LeanTween.isTweening(go(arg_68_0.energyDescTF)) then
		LeanTween.cancel(go(arg_68_0.energyDescTF))

		arg_68_0.energyDescTF.localScale = Vector3.one
	end

	setText(arg_68_0.energyDescTextTF, i18n(arg_68_2))

	arg_68_0.energyDescTF.position = arg_68_1

	setActive(arg_68_0.energyDescTF, true)
	LeanTween.scale(arg_68_0.energyDescTF, Vector3.zero, 0.2):setDelay(1):setFrom(Vector3.one):setOnComplete(System.Action(function()
		arg_68_0.energyDescTF.localScale = Vector3.one

		setActive(arg_68_0.energyDescTF, false)

		return
	end))

	return
end

function var_0_0.onUpdateItem(arg_70_0, arg_70_1, arg_70_2)
	local var_70_0 = arg_70_0.shipVOs[arg_70_1 + 1]

	if arg_70_0.shipVOs[arg_70_1 + 1] then
		local var_70_1 = var_70_0.id or 0

		arg_70_0.cardItemDic[var_70_1] = arg_70_2

		local var_70_2 = arg_70_0:onInitItem(arg_70_2)

		var_70_2:update(var_70_0)

		if arg_70_0.contextData.mode == DockyardScene.MODE_WORLD then
			var_70_2:updateWorld()

			local var_70_3 = var_70_2.shipVO and underscore.any(arg_70_0.selectedIds, function(arg_71_0)
				return var_70_2.shipVO.id == arg_71_0
			end)

			var_70_2:updateSelected(var_70_3)
			arg_70_0:updateItemBlackBlock(var_70_2)

			var_70_2.isLoading = false

			local var_70_4 = arg_70_0.contextData.energyDisplay or arg_70_0.sortIndex == ShipIndexConst.SortEnergy

			var_70_2:updateIntimacyEnergy(var_70_4)
			var_70_2:updateIntimacy((arg_70_0.sortIndex == ShipIndexConst.SortIntimacy or arg_70_0.extraIndex == ShipIndexConst.ExtraMarry) and arg_70_0.contextData.mode ~= DockyardScene.MODE_UPGRADE)

			return
		end
	end
end

function var_0_0.onReturnItem(arg_72_0, arg_72_1, arg_72_2)
	if arg_72_0.exited then
		return
	end

	if arg_72_0.scrollItems[arg_72_2] then
		var_72_0:clear()
	end

	return
end

function var_0_0.updateIndexDatas(arg_73_0)
	arg_73_0.contextData.indexDatas = arg_73_0.contextData.indexDatas or {}
	arg_73_0.contextData.indexDatas.sortIndex = arg_73_0.sortIndex
	arg_73_0.contextData.indexDatas.typeIndex = arg_73_0.typeIndex
	arg_73_0.contextData.indexDatas.campIndex = arg_73_0.campIndex
	arg_73_0.contextData.indexDatas.rarityIndex = arg_73_0.rarityIndex
	arg_73_0.contextData.indexDatas.extraIndex = arg_73_0.extraIndex

	return
end

function var_0_0.initIndexPanel(arg_74_0)
	onButton(arg_74_0, arg_74_0.indexBtn, function()
		arg_74_0:emit(DockyardMediator.OPEN_DOCKYARD_INDEX, {
			indexDatas = Clone(arg_74_0.contextData.indexDatas),
			customPanels = {
				minHeight = 650,
				sortIndex = {
					isSort = true,
					mode = CustomIndexLayer.Mode.OR,
					options = ShipIndexConst.SortIndexs,
					names = ShipIndexConst.SortNames
				},
				sortPropertyIndex = {
					blueSeleted = true,
					mode = CustomIndexLayer.Mode.OR,
					options = ShipIndexConst.SortPropertyIndexs,
					names = ShipIndexConst.SortPropertyNames
				},
				typeIndex = {
					blueSeleted = true,
					mode = CustomIndexLayer.Mode.AND,
					options = ShipIndexConst.TypeIndexs,
					names = ShipIndexConst.TypeNames
				},
				campIndex = {
					blueSeleted = true,
					mode = CustomIndexLayer.Mode.AND,
					options = ShipIndexConst.CampIndexs,
					names = ShipIndexConst.CampNames
				},
				rarityIndex = {
					blueSeleted = true,
					mode = CustomIndexLayer.Mode.AND,
					options = ShipIndexConst.RarityIndexs,
					names = ShipIndexConst.RarityNames
				},
				extraIndex = {
					blueSeleted = true,
					mode = CustomIndexLayer.Mode.OR,
					options = ShipIndexConst.ExtraIndexs,
					names = ShipIndexConst.ExtraNames
				},
				layoutPos = Vector2(0, -25)
			},
			groupList = {
				{
					titleTxt = "indexsort_sort",
					dropdown = false,
					titleENTxt = "indexsort_sorteng",
					tags = {
						"sortIndex"
					},
					simpleDropdown = {
						"sortPropertyIndex"
					}
				},
				{
					dropdown = false,
					titleENTxt = "indexsort_indexeng",
					titleTxt = "indexsort_index",
					tags = {
						"typeIndex"
					}
				},
				{
					dropdown = false,
					titleENTxt = "indexsort_campeng",
					titleTxt = "indexsort_camp",
					tags = {
						"campIndex"
					}
				},
				{
					dropdown = false,
					titleENTxt = "indexsort_rarityeng",
					titleTxt = "indexsort_rarity",
					tags = {
						"rarityIndex"
					}
				},
				{
					dropdown = false,
					titleENTxt = "indexsort_indexeng",
					titleTxt = "indexsort_extraindex",
					tags = {
						"extraIndex"
					}
				}
			},
			callback = function(arg_76_0)
				arg_74_0.sortIndex = arg_76_0.sortIndex
				arg_74_0.typeIndex = arg_76_0.typeIndex
				arg_74_0.campIndex = arg_76_0.campIndex
				arg_74_0.rarityIndex = arg_76_0.rarityIndex
				arg_74_0.extraIndex = arg_76_0.extraIndex

				arg_74_0:updateIndexDatas()
				arg_74_0:filter()

				return
			end
		})

		return
	end, SFX_PANEL)
	onToggle(arg_74_0, arg_74_0.preferenceBtn, function(arg_77_0)
		arg_74_0.commonTag = arg_77_0 and Ship.PREFERENCE_TAG_COMMON or Ship.PREFERENCE_TAG_NONE

		arg_74_0:filter()

		return
	end)

	return
end

function var_0_0.setShips(arg_78_0, arg_78_1)
	arg_78_0.shipVOsById = arg_78_1

	local var_78_0 = getProxy(TechnologyProxy)

	arg_78_0.shipBluePrints = {}

	for iter_78_0, iter_78_1 in ipairs(var_78_0:getAllBluePrintShipIds()) do
		local var_78_1 = getProxy(BayProxy):getShipById(iter_78_1)

		if #var_78_1:getAllShipPhantomMarks() > 1 then
			table.insert(arg_78_0.shipBluePrints, var_78_0:getBluePrintById(var_78_1.groupId))
		end
	end

	table.sort(arg_78_0.shipBluePrints, CompareFuncs({
		function(arg_79_0)
			return arg_79_0:getConfig("blueprint_version")
		end,
		function(arg_80_0)
			return arg_80_0.id
		end
	}))

	return
end

function var_0_0.setPlayer(arg_81_0, arg_81_1)
	arg_81_0.player = arg_81_1

	arg_81_0:updateBarInfo()

	return
end

function var_0_0.updateBarInfo(arg_82_0)
	setActive(arg_82_0.bottomTipsText, arg_82_0.contextData.leftTopInfo)

	local var_82_0 = arg_82_0.contextData.leftTopInfo and i18n("dock_yard_left_tips", arg_82_0.contextData.leftTopInfo) or ""

	setText(arg_82_0.bottomTipsText, var_82_0)
	setActive(arg_82_0.bottomTipsWithFrame, arg_82_0.contextData.leftTopWithFrameInfo)

	local var_82_1 = arg_82_0.contextData.leftTopWithFrameInfo or ""

	setText(arg_82_0.bottomTipsWithFrame:Find("Text"), var_82_1)

	if arg_82_0.contextData.mode == var_0_0.MODE_WORLD or arg_82_0.contextData.mode == var_0_0.MODE_GUILD_BOSS or arg_82_0.contextData.mode == var_0_0.MODE_REMOULD or arg_82_0.isPhantomMode then
		setActive(arg_82_0.leftTipsText, false)
	else
		setActive(arg_82_0.leftTipsText, true)
		arg_82_0:updateCapacityDisplay()
	end

	return
end

function var_0_0.updateCapacityDisplay(arg_83_0)
	setActive(arg_83_0.leftTipsText:Find("plus"), not arg_83_0.isCapacityMeta)
	setActive(arg_83_0.leftTipsText:Find("tip"), arg_83_0.isCapacityMeta)
	setActive(arg_83_0.leftTipsText:Find("switch/off"), not arg_83_0.isCapacityMeta)
	setActive(arg_83_0.leftTipsText:Find("switch/on"), arg_83_0.isCapacityMeta)

	if arg_83_0.isCapacityMeta then
		setText(arg_83_0.leftTipsText:Find("label"), i18n("specialshipyard_name"))
		setText(arg_83_0.leftTipsText:Find("Text"), arg_83_0.specialShipCount)
	else
		setText(arg_83_0.leftTipsText:Find("label"), i18n("ship_dockyardScene_capacity"))
		setText(arg_83_0.leftTipsText:Find("Text"), arg_83_0.shipsCount .. "/" .. arg_83_0.player:getMaxShipBag())
	end

	return
end

function var_0_0.initWorldPanel(arg_84_0)
	onButton(arg_84_0, arg_84_0.worldPanel:Find("btn_repair"), function()
		if #arg_84_0.selectedIds > 0 then
			arg_84_0:repairWorldShip(arg_84_0.shipVOsById[arg_84_0.selectedIds[1]])
		end

		return
	end, SFX_PANEL)
	onButton(arg_84_0, arg_84_0.worldPanel:Find("btn_repair_all"), function()
		local var_86_0 = {}
		local var_86_1 = 0

		for iter_86_0, iter_86_1 in pairs(arg_84_0.shipVOsById) do
			local var_86_2 = WorldConst.FetchWorldShip(iter_86_1.id)

			if var_86_2:IsBroken() or not var_86_2:IsHpFull() then
				table.insert({}, var_86_2.id)

				local var_86_3 = nowWorld()

				var_86_1 = var_86_1 + var_86_3:CalcRepairCost(var_86_2)
			end
		end

		if #{} == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_ship_repair_no_need"))
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("world_ship_repair_all", var_86_1),
				onYes = function()
					arg_84_0:emit(DockyardMediator.ON_SHIP_REPAIR, var_86_0, var_86_1)

					return
				end
			})
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.repairWorldShip(arg_88_0, arg_88_1)
	local var_88_0 = WorldConst.FetchWorldShip(arg_88_1.id)
	local var_88_1 = nowWorld():CalcRepairCost(var_88_0)

	if var_88_0:IsBroken() then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("world_ship_repair_2", arg_88_1:getName(), var_88_1),
			onYes = function()
				arg_88_0:emit(DockyardMediator.ON_SHIP_REPAIR, {
					var_88_0.id
				}, var_88_1)

				return
			end
		})
	elseif not var_88_0:IsHpFull() then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("world_ship_repair_1", arg_88_1:getName(), var_88_1),
			onYes = function()
				arg_88_0:emit(DockyardMediator.ON_SHIP_REPAIR, {
					var_88_0.id
				}, var_88_1)

				return
			end
		})
	else
		pg.TipsMgr.GetInstance():ShowTips(i18n("world_ship_repair_no_need"))
	end

	return
end

function var_0_0.filter(arg_91_0)
	LoadImageSpriteAtlasAsync("ui/dockyardui_atlas", arg_91_0:isDefaultStatus() and "shaixuan_off" or "shaixuan_on", arg_91_0.indexBtn, true)

	if arg_91_0.isRemouldOrUpgradeMode then
		arg_91_0:filterForRemouldAndUpgrade()
	else
		arg_91_0:filterCommon()
	end

	local var_91_0 = 0

	if arg_91_0.contextData.quitTeam then
		var_91_0 = var_91_0 + 1

		table.insert(arg_91_0.shipVOs, var_91_0, false)
	end

	if arg_91_0.contextData.priorEquipUpShipIDList then
		local var_91_1 = {}

		for iter_91_0, iter_91_1 in ipairs(arg_91_0.contextData.priorEquipUpShipIDList) do
			var_91_1[iter_91_1] = true
		end

		for iter_91_2 = #arg_91_0.shipVOs, 1, -1 do
			local var_91_2 = type(arg_91_0.shipVOs[iter_91_2]) == "table" and arg_91_0.shipVOs[iter_91_2].id

			if var_91_1[var_91_2] then
				var_91_1[var_91_2] = table.remove(arg_91_0.shipVOs, iter_91_2)
			end
		end

		for iter_91_3, iter_91_4 in ipairs(arg_91_0.contextData.priorEquipUpShipIDList) do
			if type(var_91_1[iter_91_4]) == "table" then
				var_91_0 = var_91_0 + 1

				table.insert(arg_91_0.shipVOs, var_91_0, var_91_1[iter_91_4])
			end
		end
	end

	if var_0_0.MODE_OVERVIEW == arg_91_0.contextData.mode and DockyardScene.value then
		local var_91_3 = DockyardScene.value or 0

		arg_91_0:updateShipCount(var_91_3)

		DockyardScene.value = nil
	else
		arg_91_0:updateShipCount(0)
	end

	return
end

function var_0_0.filterForRemouldAndUpgrade(arg_92_0)
	arg_92_0.shipVOs = {}

	local var_92_0 = arg_92_0.isFilterLockForMod
	local var_92_1 = arg_92_0.isFilterLevelForMod

	for iter_92_0, iter_92_1 in pairs(arg_92_0.shipVOsById) do
		if (function(arg_93_0)
			local var_93_0 = true

			if not var_92_0 and arg_93_0.lockState == Ship.LOCK_STATE_LOCK then
				var_93_0 = false
			end

			if not var_92_1 and arg_93_0.level > 1 then
				var_93_0 = false
			end

			return var_93_0
		end)(iter_92_1) then
			table.insert(arg_92_0.shipVOs, iter_92_1)
		end
	end

	table.sort(arg_92_0.shipVOs, CompareFuncs({
		function(arg_94_0)
			return arg_94_0.level
		end,
		function(arg_95_0)
			return arg_95_0:isTestShip() and 1 or 0
		end
	}))

	return
end

function var_0_0.filterCommon(arg_96_0)
	arg_96_0.shipVOs = {}

	local var_96_0 = arg_96_0.sortIndex

	for iter_96_0, iter_96_1 in pairs(arg_96_0.shipVOsById) do
		if arg_96_0.contextData.blockLock and iter_96_1:GetLockState() == Ship.LOCK_STATE_LOCK then
			-- block empty
		elseif arg_96_0.teamTypeFilter and iter_96_1:getTeamType() ~= arg_96_0.teamTypeFilter then
			-- block empty
		elseif ShipIndexConst.filterByType(iter_96_1, arg_96_0.typeIndex) and ShipIndexConst.filterByCamp(iter_96_1, arg_96_0.campIndex) and ShipIndexConst.filterByRarity(iter_96_1, arg_96_0.rarityIndex) and ShipIndexConst.filterByExtra(iter_96_1, arg_96_0.extraIndex) and (arg_96_0.commonTag == Ship.PREFERENCE_TAG_NONE or arg_96_0.commonTag == iter_96_1:GetPreferenceTag()) and (function(arg_97_0)
			if arg_96_0.contextData.mode ~= var_0_0.MODE_GUILD_BOSS then
				return true
			end

			if arg_96_0.isShowAssultShips then
				return true
			end

			if not arg_97_0.user then
				return true
			end

			if arg_97_0.user.id == arg_96_0.player.id then
				return true
			end

			return false
		end)(iter_96_1) then
			table.insert(arg_96_0.shipVOs, iter_96_1)
		end
	end

	local var_96_1 = arg_96_0.searchBar:GetInputText()

	if var_96_1 and var_96_1 ~= "" then
		arg_96_0.shipVOs = underscore.filter(arg_96_0.shipVOs, function(arg_98_0)
			return arg_98_0:IsMatchKey(var_96_1)
		end)
	end

	local var_96_2, var_96_3 = ShipIndexConst.getSortFuncAndName(var_96_0, arg_96_0.selectAsc)

	if var_96_0 ~= ShipIndexConst.SortIntimacy then
		local var_96_4 = arg_96_0.contextData.hideTagFlags or {}

		if not defaultValue(var_96_4.inFleet, ShipStatus.TAG_HIDE_BASE.inFleet) then
			table.insert(var_96_2, 1, function(arg_99_0)
				return arg_99_0:getFlag("inFleet") and 0 or 1
			end)
		end
	end

	if var_96_2 then
		arg_96_0:SortShips(var_96_2)
	end

	arg_96_0:updateSelected()
	setActive(arg_96_0.sortImgAsc, arg_96_0.selectAsc)
	setActive(arg_96_0.sortImgDesc, not arg_96_0.selectAsc)
	setText(arg_96_0.sortBtn:Find("Image"), i18n(var_96_3))

	return
end

function var_0_0.SortShips(arg_100_0, arg_100_1)
	if pg.NewGuideMgr.GetInstance():IsBusy() then
		local var_100_0 = {
			101171,
			201211,
			401231,
			301051
		}

		arg_100_1 = {
			function(arg_101_0)
				return table.contains(var_100_0, arg_101_0.configId) and 0 or 1
			end
		}
	elseif arg_100_0.isFormTactics then
		table.insert(arg_100_1, 1, function(arg_102_0)
			return arg_102_0:getNation() == Nation.META and 1 or 0
		end)
		table.insert(arg_100_1, 1, function(arg_103_0)
			return arg_103_0:isFullSkillLevel() and 1 or 0
		end)
	elseif arg_100_0.contextData.mode == var_0_0.MODE_OVERVIEW or arg_100_0.contextData.mode == var_0_0.MODE_SELECT then
		table.insert(arg_100_1, 1, function(arg_104_0)
			return -arg_104_0.activityNpc
		end)
	elseif arg_100_0.contextData.mode == var_0_0.MODE_GUILD_BOSS then
		table.insert(arg_100_1, 1, function(arg_105_0)
			return arg_105_0.guildRecommand and 0 or 1
		end)
	end

	table.sort(arg_100_0.shipVOs, CompareFuncs(arg_100_1))

	return
end

function var_0_0.UpdateGuildViewEquipmentsBtn(arg_106_0)
	setActive(arg_106_0.viewEquipmentBtn, arg_106_0.contextData.mode == var_0_0.MODE_GUILD_BOSS and #arg_106_0.selectedIds > 0)

	return
end

function var_0_0.GetSelectCount(arg_107_0)
	return #arg_107_0.selectedIds
end

function var_0_0.GetConfirmSelect(arg_108_0)
	return arg_108_0.selectedIds
end

function var_0_0.didEnter(arg_109_0)
	if arg_109_0:isLayer() then
		arg_109_0:OverlayPanel(arg_109_0._tf, {
			groupDelta = -1
		})
	end

	arg_109_0:OverlayPanel(arg_109_0.blurPanel)
	arg_109_0:PlayUIAnimation(arg_109_0.blurPanel, "enter")

	local var_109_0 = getProxy(TaskProxy):mingshiTouchFlagEnabled()

	var_109_0 = var_109_0 and arg_109_0.contextData.mode ~= var_0_0.MODE_GUILD_BOSS

	setActive(arg_109_0.stampBtn, var_109_0)
	arg_109_0:UpdateGuildViewEquipmentsBtn()
	onButton(arg_109_0, arg_109_0.stampBtn, function()
		getProxy(TaskProxy):dealMingshiTouchFlag(1)

		return
	end, SFX_CONFIRM)
	onButton(arg_109_0, arg_109_0.topPanel:Find("back"), function()
		arg_109_0:back()

		return
	end, SFX_CANCEL)
	onButton(arg_109_0, arg_109_0.sortBtn, function()
		arg_109_0.selectAsc = not arg_109_0.selectAsc

		arg_109_0:filter()

		return
	end, SFX_UI_CLICK)
	onToggle(arg_109_0, arg_109_0.assultBtn, function(arg_113_0)
		arg_109_0.isShowAssultShips = arg_113_0

		arg_109_0:filter()

		return
	end, SFX_PANEL)
	onButton(arg_109_0, arg_109_0.viewEquipmentBtn, function()
		if not arg_109_0.selectedIds[#arg_109_0.selectedIds] then
			return
		end

		arg_109_0.guildShipEquipmentsPage:ExecuteAction("Show", arg_109_0.shipVOsById[arg_109_0.selectedIds[#arg_109_0.selectedIds]], arg_109_0.shipVOsById[arg_109_0.selectedIds[#arg_109_0.selectedIds]].user)

		return
	end, SFX_PANEL)
	onButton(arg_109_0, arg_109_0.attrBtn, function()
		local var_115_0 = arg_109_0

		if not arg_109_0.isFormTactics then
			arg_109_0.itemDetailType = (arg_109_0.itemDetailType + 1) % 4

			goto label_115_0
		end

		::label_115_0::

		if arg_109_0.itemDetailType == DockyardShipItem.DetailType0 then
			var_115_0.itemDetailType = DockyardShipItem.DetailType3 or DockyardShipItem.DetailType0

			setActive(arg_109_0.attrBtn:Find("off"), arg_109_0.itemDetailType == DockyardShipItem.DetailType0)
			setActive(arg_109_0.attrBtn:Find("on"), arg_109_0.itemDetailType ~= DockyardShipItem.DetailType0)

			local var_115_1 = arg_109_0.attrBtn:GetComponent("Button")

			if arg_109_0.itemDetailType == DockyardShipItem.DetailType0 then
				var_115_1.targetGraphic = imageOff or imageOn

				arg_109_0:updateItemDetailType()

				return
			end
		end
	end, SFX_PANEL)
	onButton(arg_109_0, arg_109_0.selectPanel:Find("cancel_button"), function()
		if arg_109_0.animating then
			return
		end

		if arg_109_0.contextData.mode == var_0_0.MODE_DESTROY then
			if #arg_109_0.selectedIds > 0 then
				arg_109_0:unselecteAllShips()
				arg_109_0:back()
			else
				arg_109_0:back()
			end
		else
			arg_109_0:back()

			return
		end

		return
	end, SFX_CANCEL)
	onButton(arg_109_0, arg_109_0.selectPanel:Find("confirm_button"), function()
		if arg_109_0.animating then
			return
		end

		if arg_109_0.contextData.mode == var_0_0.MODE_DESTROY then
			local var_117_0, var_117_1 = arg_109_0:checkDestroyGold()

			if not var_117_0 or not var_117_1 then
				if not var_117_0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title") .. i18n("resource_max_tip_retire"))
				elseif not var_117_0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("oil_max_tip_title") .. i18n("resource_max_tip_retire"))
				end

				return
			end
		end

		if arg_109_0:GetSelectCount() < arg_109_0.selectedMin then
			if arg_109_0.leastLimitMsg then
				pg.TipsMgr.GetInstance():ShowTips(arg_109_0.leastLimitMsg)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("ship_dockyardScene_error_choiseRoleMore", arg_109_0.selectedMin))
			end

			return
		end

		if arg_109_0.contextData.mode == var_0_0.MODE_DESTROY then
			arg_109_0:displayDestroyPanel()
		else
			local var_117_2 = {}

			if arg_109_0.contextData.destroyCheck then
				local var_117_3 = underscore.map(arg_109_0.selectedIds, function(arg_118_0)
					return arg_109_0.shipVOsById[arg_118_0]
				end)

				table.insert(var_117_2, function(arg_119_0)
					arg_109_0:checkDestroyShips(var_117_3, arg_119_0)

					return
				end)
			end

			local var_117_4 = arg_109_0:GetConfirmSelect()

			if arg_109_0.confirmSelect then
				table.insert(var_117_2, function(arg_120_0)
					arg_109_0.confirmSelect(var_117_4, function()
						arg_120_0(true)

						return
					end, arg_120_0)

					return
				end)
				seriesAsync(var_117_2, function(arg_122_0)
					if arg_122_0 then
						arg_109_0.onSelected(var_117_4)
					end

					arg_109_0:back()

					return
				end)
			else
				table.insert(var_117_2, function(arg_123_0)
					if arg_109_0.callbackQuit then
						arg_109_0.onSelected(var_117_4, arg_123_0)
					else
						arg_109_0.onSelected(var_117_4)
						arg_123_0()
					end

					return
				end)
				seriesAsync(var_117_2, function()
					arg_109_0:back()

					return
				end)
			end
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_109_0, arg_109_0.selectPanel:Find("quick_select"), function()
		local var_125_0

		if arg_109_0.animating then
			do return end

			var_125_0 = {}
		end

		for iter_125_0, iter_125_1 in pairs({
			PlayerPrefs.GetInt("QuickSelectRarity1", 3),
			PlayerPrefs.GetInt("QuickSelectRarity2", 4),
			PlayerPrefs.GetInt("QuickSelectRarity3", 2)
		}) do
			local var_125_2

			if iter_125_1 ~= 0 then
				local var_125_1 = ({})[iter_125_1]

				if not ({})[iter_125_1] then
					var_125_1 = 3
				end

				;({})[iter_125_1] = var_125_1
				var_125_2 = 3 - 1
			end
		end

		local var_125_3 = {}
		local var_125_4 = {}

		for iter_125_2, iter_125_3 in pairs((getProxy(BayProxy):getShips())) do
			if iter_125_3:isMaxStar() then
				({})[iter_125_3:getGroupId()] = true
			else
				local var_125_5 = iter_125_3:getMaxStar() - iter_125_3:getStar() + 1

				if iter_125_3:GetLockState() == Ship.LOCK_STATE_UNLOCK then
					var_125_5 = var_125_5 + 1
				end

				local var_125_6 = var_125_4[iter_125_3:getGroupId()]

				var_125_4[iter_125_3:getGroupId()] = var_125_6 and var_125_6 < var_125_5 and var_125_6 or var_125_5
			end
		end

		local var_125_7 = _.select(arg_109_0.shipVOs, function(arg_126_0)
			return arg_126_0.configId ~= 100001 and arg_126_0.configId ~= 100011 and arg_126_0:GetLockState() == Ship.LOCK_STATE_UNLOCK and table.contains(var_0, arg_126_0:getRarity()) and arg_126_0.level == 1 and not arg_109_0.blacklist[arg_126_0:getGroupId()] and not table.contains(arg_109_0.selectedIds, arg_126_0.id) and not arg_126_0:hasAnyFlag({
				"inFleet",
				"inChapter",
				"inWorld",
				"inEvent",
				"inBackyard",
				"inClass",
				"inTactics",
				"inExercise",
				"inAdmiral",
				"inElite",
				"inActivity",
				"inGuildEvent",
				"inGuildBossEvent"
			})
		end)

		if not _.all(var_125_7, function(arg_127_0)
			return arg_109_0.blacklist[arg_127_0:getGroupId()]
		end) then
			var_125_7 = _.select(var_125_7, function(arg_128_0)
				return not arg_109_0.blacklist[arg_128_0:getGroupId()]
			end)
		elseif #arg_109_0.selectedIds > 0 then
			var_125_7 = {}
		end

		table.sort(var_125_7, function(arg_129_0, arg_129_1)
			local var_129_0 = var_125_0[arg_129_0:getRarity()] or 0
			local var_129_1 = var_125_0[arg_129_1:getRarity()] or 0

			if var_129_0 == var_129_1 then
				if arg_129_0:getGroupId() == arg_129_1:getGroupId() then
					return arg_129_0.createTime > arg_129_1.createTime
				end

				return arg_129_0.configId > arg_129_1.configId
			else
				return var_129_1 < var_129_0
			end

			return
		end)

		local var_125_8 = PlayerPrefs.GetString("QuickSelectWhenHasAtLeastOneMaxstar", "KeepNone")
		local var_125_9 = PlayerPrefs.GetString("QuickSelectWithoutMaxstar", "KeepAll")
		local var_125_10 = {}
		local var_125_11 = 0
		local var_125_12 = false
		local var_125_13 = false
		local var_125_14 = 0
		local var_125_15 = 0

		for iter_125_4, iter_125_5 in ipairs(arg_109_0.selectedIds) do
			local var_125_16, var_125_17 = arg_109_0.shipVOsById[iter_125_5]:calReturnRes()

			var_125_14 = var_125_14 + var_125_16
			var_125_15 = var_125_15 + var_125_17
		end

		for iter_125_6, iter_125_7 in ipairs((_.select(var_125_7, function(arg_130_0)
			if var_125_3[arg_130_0:getGroupId()] then
				if var_125_8 == "KeepNone" then
					return true
				elseif var_125_8 == "KeepOne" then
					if not var_125_10[arg_130_0:getGroupId()] then
						var_125_10[arg_130_0:getGroupId()] = true

						return false
					end

					return true
				elseif var_125_8 == "KeepAll" then
					return false
				end
			elseif var_125_9 == "KeepNone" then
				return true
			elseif var_125_9 == "KeepNeeded" then
				if var_125_4[arg_130_0:getGroupId()] > 0 then
					var_125_4[arg_130_0:getGroupId()] = var_125_4[arg_130_0:getGroupId()] - 1

					return false
				end

				return true
			elseif var_125_9 == "KeepAll" then
				return false
			end

			return
		end))) do
			if arg_109_0.selectedMax > 0 and arg_109_0.selectedMax <= arg_109_0:GetSelectCount() then
				break
			end

			local var_125_18, var_125_19 = iter_125_7:calReturnRes()

			var_125_14 = var_125_14 + var_125_18
			var_125_15 = var_125_15 + var_125_19
			var_125_12 = arg_109_0.player:OilMax(var_125_15)
			var_125_13 = arg_109_0.player:GoldMax(var_125_14)

			if var_125_13 then
				break
			end

			var_125_11 = var_125_11 + 1

			arg_109_0:selectShip(iter_125_7)
		end

		if var_125_11 == 0 then
			if var_125_13 then
				if #arg_109_0.selectedIds == 0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title") .. i18n("resource_max_tip_retire"))
				else
					pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title"))
				end
			elseif #arg_109_0.selectedIds > 0 then
				arg_109_0:displayDestroyPanel()
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("retire_selectzero"))
			end
		elseif var_125_12 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("oil_max_tip_title") .. i18n("resource_max_tip_retire_1"),
				onYes = function()
					arg_109_0:displayDestroyPanel()

					return
				end
			})
		else
			arg_109_0:displayDestroyPanel()
		end

		return
	end, SFX_CONFIRM)

	if isActive(arg_109_0.togglePhantom) then
		triggerToggle(arg_109_0.togglePhantom, tobool(arg_109_0.inPhantom))
	else
		arg_109_0:SwitchContainerDisplay()
	end

	arg_109_0:updateBarInfo()

	if arg_109_0.contextData.mode == var_0_0.MODE_WORLD then
		arg_109_0:initWorldPanel()
	elseif arg_109_0.contextData.mode == var_0_0.MODE_DESTROY and not LOCK_DESTROY_GUIDE then
		pg.SystemGuideMgr.GetInstance():Play(arg_109_0)
	end

	setAnchoredPosition(arg_109_0.topPanel, {
		y = arg_109_0.topPanel.rect.height
	})
	setAnchoredPosition(arg_109_0.selectPanel, {
		y = -1 * arg_109_0.selectPanel.rect.height
	})
	onNextTick(function()
		if arg_109_0.exited then
			return
		end

		arg_109_0:uiStartAnimating()

		return
	end)

	arg_109_0.bulinTip = AprilFoolBulinSubView.ShowAprilFoolBulin(arg_109_0)

	onButton(arg_109_0, arg_109_0.settingBtn, function()
		arg_109_0.settingPanel:Load()
		arg_109_0.settingPanel:ActionInvoke("Show")

		return
	end)
	pg.SystemGuideMgr.GetInstance():Play(arg_109_0)

	return
end

function var_0_0.TriggerCard(arg_134_0, arg_134_1)
	local var_134_0 = arg_134_0.selectedIds[1]

	if not arg_134_0.selectedIds[1] then
		return
	end

	local var_134_1

	for iter_134_0, iter_134_1 in ipairs(arg_134_0.shipVOs) do
		if iter_134_1 and iter_134_1.id == var_134_0 then
			var_134_1 = iter_134_0

			break
		end
	end

	if not var_134_1 then
		return
	end

	local var_134_2 = var_134_1
	local var_134_4 = (function()
		var_134_2 = var_134_2 + arg_134_1

		if not arg_134_0.shipVOs[var_134_2] or arg_134_0.checkShip(arg_134_0.shipVOs[var_134_2]) then
			return arg_134_0.shipVOs[var_134_2]
		else
			return var_0()
		end

		return
	end)()

	if not var_134_4 then
		return
	end

	local var_134_6 = arg_134_0.cardItemDic[var_134_0]
	local var_134_7 = arg_134_0.cardItemDic[var_134_0] and arg_134_0.scrollItems[var_134_6]
	local var_134_8 = arg_134_0.cardItemDic[var_134_0] and arg_134_0.scrollItems[var_134_6] and var_134_7.shipVO.id == var_134_4.id and var_134_7 or nil

	if arg_134_0.cardItemDic[var_134_0] and arg_134_0.scrollItems[var_134_6] and var_134_7.shipVO.id == var_134_4.id and var_134_7 or nil then
		if not getBounds(arg_134_0._tf:Find("main/ship_container")):Intersects((getBounds(var_134_8.tr))) then
			arg_134_0.shipContainer:SetNormalizedPosition(arg_134_0.shipContainer.value + arg_134_1 * (arg_134_0.shipContainer:HeadIndexToValue(7) - arg_134_0.shipContainer:HeadIndexToValue(1)), 1)
		end
	end

	if not var_134_8 then
		arg_134_0.shipContainer:SetNormalizedPosition(arg_134_0.shipContainer.value + (math.ceil(var_134_2 / 7) - math.ceil(var_134_1 / 7)) * (arg_134_0.shipContainer:HeadIndexToValue(21) - arg_134_0.shipContainer:HeadIndexToValue(1)), 1)

		var_134_8 = var_134_5()
	end

	if var_134_8 then
		triggerButton(var_134_8.tr)
		arg_134_0.guildShipEquipmentsPage:Refresh(arg_134_0.shipVOsById[var_134_8.shipVO.id], arg_134_0.shipVOsById[var_134_8.shipVO.id].user)
	end

	return
end

function var_0_0.OnSwitch(arg_137_0, arg_137_1, arg_137_2, arg_137_3)
	local function var_137_0()
		setActive(arg_137_1:Find("off"), not arg_137_2)
		setActive(arg_137_1:Find("on"), arg_137_2)

		return
	end

	onButton(arg_137_0, arg_137_1, function()
		arg_137_2 = not arg_137_2

		if arg_137_3 then
			arg_137_3(arg_137_2)
		end

		var_137_0()

		return
	end, SFX_PANEL)
	;(function()
		setActive(arg_137_1:Find("off"), not arg_137_2)
		setActive(arg_137_1:Find("on"), arg_137_2)

		return
	end)()

	return
end

function var_0_0.OnShipSkinChanged(arg_140_0, arg_140_1)
	local var_140_0, var_140_1 = ShipPhantom.UnpackMark(arg_140_1)
	local var_140_2 = arg_140_0.phantomGroupDic[var_140_0] and arg_140_0.scrollPhantoms[arg_140_0.phantomGroupDic[var_140_0]]

	if arg_140_0.phantomGroupDic[var_140_0] and arg_140_0.scrollPhantoms[arg_140_0.phantomGroupDic[var_140_0]] and var_140_2.shipCard.shipVO.id == var_140_0 then
		arg_140_0:updatePhantomGroup(underscore.detect(arg_140_0.filterBluePrint, function(arg_141_0)
			return arg_141_0.shipId == var_140_0
		end), arg_140_0.phantomGroupDic[var_140_0])
	end

	return
end

function var_0_0.onBackPressed(arg_142_0)
	if arg_142_0.destroyConfirmWindow:isShowing() then
		arg_142_0.destroyConfirmWindow:Hide()

		return
	end

	if arg_142_0.destroyPage:isShowing() then
		arg_142_0.destroyPage:Hide()

		return
	end

	if arg_142_0.settingPanel:isShowing() then
		arg_142_0.settingPanel:Hide()

		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	arg_142_0:back()

	return
end

function var_0_0.updateShipStatusById(arg_143_0, arg_143_1)
	local var_143_0 = arg_143_0.cardItemDic[arg_143_1] and arg_143_0.scrollItems[arg_143_0.cardItemDic[arg_143_1]]

	if arg_143_0.cardItemDic[arg_143_1] and arg_143_0.scrollItems[arg_143_0.cardItemDic[arg_143_1]] and var_143_0.shipVO.id == arg_143_1 then
		var_143_0:flush(arg_143_0.selectedIds)

		if arg_143_0.contextData.mode == DockyardScene.MODE_WORLD then
			var_143_0:updateWorld()
		end
	end

	return
end

function var_0_0.checkDestroyGold(arg_144_0, arg_144_1)
	local var_144_0 = 0
	local var_144_1 = 0

	for iter_144_0, iter_144_1 in ipairs(arg_144_0.selectedIds) do
		local var_144_2, var_144_3 = arg_144_0.shipVOsById[iter_144_1]:calReturnRes()

		var_144_0 = var_144_0 + var_144_2
		var_144_1 = var_144_1 + var_144_3
	end

	if arg_144_1 then
		local var_144_4, var_144_5 = arg_144_1:calReturnRes()

		var_144_0 = var_144_0 + var_144_4
		var_144_1 = var_144_1 + var_144_5
	end

	local var_144_6 = arg_144_0.player:OilMax(var_144_1)

	if arg_144_0.player:GoldMax(var_144_0) then
		return false, not var_144_6
	end

	return true, not var_144_6
end

function var_0_0.selectShip(arg_145_0, arg_145_1)
	local var_145_0 = false
	local var_145_1

	for iter_145_0, iter_145_1 in ipairs(arg_145_0.selectedIds) do
		if iter_145_1 == arg_145_1.id then
			var_145_0 = true
			var_145_1 = iter_145_0

			break
		end
	end

	if var_145_0 or arg_145_0.selectedMax == 1 and arg_145_0:GetSelectCount() > 0 then
		local var_145_2 = defaultValue(var_145_1, 1)
		local var_145_3, var_145_4 = arg_145_0.onCancelShip(arg_145_0.shipVOsById[arg_145_0.selectedIds[var_145_2]], function()
			if not arg_145_0.exited then
				return
			end

			arg_145_0:selectShip(arg_145_1)

			return
		end, arg_145_0.selectedIds)

		if not var_145_3 then
			if var_145_4 then
				pg.TipsMgr.GetInstance():ShowTips(var_145_4)
			end

			return
		end

		table.remove(arg_145_0.selectedIds, var_145_2)

		if arg_145_0.selectedMax ~= 1 then
			arg_145_0:updateBlackBlocks(arg_145_0.shipVOsById[arg_145_0.selectedIds[var_145_2]])
		end
	end

	if not var_145_0 then
		local var_145_5, var_145_6 = arg_145_0.checkShip(arg_145_1, function()
			if arg_145_0.exited then
				return
			end

			arg_145_0:selectShip(arg_145_1)

			return
		end, arg_145_0.selectedIds)

		if not var_145_5 then
			if var_145_6 then
				pg.TipsMgr.GetInstance():ShowTips(var_145_6)
			end

			return
		end

		if arg_145_0.selectedMax == 0 or arg_145_0:GetSelectCount() < arg_145_0.selectedMax then
			table.insert(arg_145_0.selectedIds, arg_145_1.id)

			if arg_145_0.selectedMax ~= 1 then
				arg_145_0:updateBlackBlocks(removeShip)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_dockyardScene_error_choiseRoleLess", arg_145_0.selectedMax))

			return
		end
	end

	arg_145_0:updateSelected()

	if arg_145_0.contextData.mode == var_0_0.MODE_DESTROY then
		arg_145_0:updateDestroyRes()
	elseif arg_145_0.contextData.mode == var_0_0.MODE_MOD then
		arg_145_0:updateModAttr()
	end

	arg_145_0:UpdateGuildViewEquipmentsBtn()

	return
end

function var_0_0.updateBlackBlocks(arg_148_0, arg_148_1)
	if not arg_148_0.contextData.useBlackBlock or not arg_148_1 then
		return
	end

	for iter_148_0, iter_148_1 in pairs(arg_148_0.scrollItems) do
		arg_148_0:updateItemBlackBlock(iter_148_1)
	end

	return
end

function var_0_0.updateItemBlackBlock(arg_149_0, arg_149_1)
	if arg_149_0.contextData.useBlackBlock then
		if arg_149_0.selectedMax == 1 then
			arg_149_1:updateBlackBlock(arg_149_0.contextData.otherSelectedIds)
		else
			arg_149_1:updateBlackBlock(arg_149_0.selectedIds)
		end
	else
		arg_149_1:updateBlackBlock()
	end

	return
end

function var_0_0.unselecteAllShips(arg_150_0)
	arg_150_0.selectedIds = {}

	arg_150_0:updateSelected()
	arg_150_0:updateDestroyRes()

	return
end

function var_0_0.updateSelected(arg_151_0)
	if arg_151_0.shipContainer then
		for iter_151_0, iter_151_1 in pairs(arg_151_0.scrollItems) do
			if not iter_151_1.isClear then
				local var_151_0 = iter_151_1.shipVO and iter_151_1.shipVO.id or nil
				local var_151_1 = iter_151_1.shipVO and underscore.any(arg_151_0.selectedIds, function(arg_152_0)
					return var_151_0 == arg_152_0
				end)

				iter_151_1:updateSelected(var_151_1)
			end
		end
	end

	if arg_151_0.phantomContainer then
		for iter_151_2, iter_151_3 in pairs(arg_151_0.scrollPhantoms) do
			if not iter_151_3.isClear then
				local var_151_2 = iter_151_3.shipCard.shipVO.id

				for iter_151_4 = 0, getGameset("technology_shadow_num")[1] do
					if iter_151_4 == 0 then
						({})[iter_151_4] = underscore.any(arg_151_0.selectedIds, function(arg_153_0)
							return var_151_2 == arg_153_0
						end)
					else
						({})[iter_151_4] = underscore.any(arg_151_0.selectedMarks, function(arg_154_0)
							return arg_154_0 == ShipPhantom.PackMark(var_151_2, iter_151_4)
						end)
					end
				end

				iter_151_3:updateSelected({})
			end
		end
	end

	local var_151_3 = arg_151_0:GetSelectCount()

	if arg_151_0.selectedMax == 0 then
		setText(arg_151_0.selectPanel:Find("bottom_info/bg_input/count"), arg_151_0:GetSelectCount())

		goto label_151_1
	end

	if arg_151_0.contextData.mode ~= var_0_0.MODE_DESTROY or arg_151_0:GetSelectCount() == 0 then
		var_151_3 = setColorStr(var_151_3, COLOR_WHITE)

		goto label_151_0
	end

	::label_151_1::
	::label_151_0::

	if arg_151_0.contextData.mode == var_0_0.MODE_DESTROY then
		local var_151_5 = var_151_3

		if #arg_151_0.selectedIds == 10 then
			do
				local var_151_6 = COLOR_RED or COLOR_GREEN

				var_151_3 = var_151_4(var_151_5, var_151_6)
			end

			setText(arg_151_0.selectPanel:Find("bottom_info/bg_input/count"), var_151_3 .. "/" .. arg_151_0.selectedMax)

			if arg_151_0:GetSelectCount() < arg_151_0.selectedMin then
				setActive(arg_151_0.selectPanel:Find("confirm_button/mask"), true)
			else
				setActive(arg_151_0.selectPanel:Find("confirm_button/mask"), false)
			end

			if arg_151_0.contextData.mode == var_0_0.MODE_MOD then
				arg_151_0:updateModAttr()
			end

			return
		end
	end
end

function var_0_0.updateItemDetailType(arg_155_0)
	for iter_155_0, iter_155_1 in pairs(arg_155_0.scrollItems) do
		iter_155_1:updateDetail(arg_155_0.itemDetailType)
	end

	arg_155_0.shipLayout.anchoredPosition = arg_155_0.shipLayout.anchoredPosition + Vector3(0, 0.001, 0)

	return
end

function var_0_0.closeDestroyMode(arg_156_0)
	setActive(arg_156_0.awardTF, false)
	setActive(arg_156_0.bottomTipsText, true)

	return
end

function var_0_0.updateDestroyRes(arg_157_0)
	if table.getCount(arg_157_0.selectedIds) == 0 then
		arg_157_0:closeDestroyMode()
	else
		setActive(arg_157_0.awardTF, true)
		setActive(arg_157_0.bottomTipsText, false)
	end

	local var_157_0, var_157_1, var_157_2 = ShipCalcHelper.CalcDestoryRes((_.map(arg_157_0.selectedIds, function(arg_158_0)
		return arg_157_0.shipVOsById[arg_158_0]
	end)))
	local var_157_3 = var_157_1 == 0

	if arg_157_0.destroyResList then
		arg_157_0.destroyResList:make(function(arg_159_0, arg_159_1, arg_159_2)
			if arg_159_0 == UIItemList.EventUpdate then
				local var_159_0 = ""
				local var_159_1 = 0

				if arg_159_1 == 0 then
					var_159_1 = var_157_0
					var_159_0 = "Props/gold"

					goto label_159_0
				end

				if arg_159_1 == 1 then
					if not var_157_3 then
						var_159_1 = var_157_1
						var_159_0 = "Props/oil"
					else
						var_159_1 = var_157_2[1].count
						var_159_0 = Item.getConfigData(var_157_2[1].id).icon
					end

					goto label_159_0
				end

				::label_159_0::

				if arg_159_1 > 1 then
					if var_157_3 then
						do
							local var_159_2 = var_157_2[arg_159_1]

							if not var_157_2[arg_159_1] then
								var_159_2 = var_157_2[arg_159_1 - 1]
								var_159_1 = var_159_2.count
							end

							var_159_0 = Item.getConfigData(var_159_2.id).icon
						end

						GetImageSpriteFromAtlasAsync(var_159_0, "", arg_159_2:Find("icon"))
						setText(arg_159_2:Find("Text"), "X" .. var_159_1)

						return
					end
				end
			end
		end)
		arg_157_0.destroyResList:align((var_157_3 and 1 or 2) + #var_157_2)
	end

	if arg_157_0.destroyPage and arg_157_0.destroyPage:GetLoaded() and arg_157_0.destroyPage:isShowing() then
		arg_157_0.destroyPage:RefreshRes()
	end

	return
end

function var_0_0.setModShip(arg_160_0, arg_160_1)
	arg_160_0.modShip = arg_160_1

	return
end

function var_0_0.updateModAttr(arg_161_0)
	if table.getCount(arg_161_0.selectedIds) == 0 then
		arg_161_0:closeModAttr()
	else
		setActive(arg_161_0.modAttrsTF, true)
		setActive(arg_161_0.bottomTipsText, false)
	end

	for iter_161_0, iter_161_1 in ipairs(arg_161_0.selectedIds) do
		table.insert({}, arg_161_0.shipVOsById[iter_161_1])
	end

	local var_161_1 = ShipModLayer.getModExpAdditions(arg_161_0.modShip, {})

	for iter_161_2, iter_161_3 in pairs(ShipModAttr.ID_TO_ATTR) do
		if iter_161_2 ~= ShipModLayer.IGNORE_ID then
			local var_161_2 = arg_161_0.modAttrContainer:Find("attr_" .. iter_161_2)

			setText(var_161_2:Find("value"), var_161_1[iter_161_3])
			setText(var_161_2:Find("name"), ShipModAttr.id2Name(iter_161_2))
		end
	end

	return
end

function var_0_0.closeModAttr(arg_162_0)
	setActive(arg_162_0.modAttrsTF, false)
	setActive(arg_162_0.bottomTipsText, true)

	return
end

function var_0_0.removeShip(arg_163_0, arg_163_1)
	for iter_163_0, iter_163_1 in ipairs(arg_163_0.selectedIds) do
		if iter_163_1 == arg_163_1 then
			table.remove(arg_163_0.selectedIds, iter_163_0)

			break
		end
	end

	for iter_163_2 = #arg_163_0.shipVOs, 1, -1 do
		if arg_163_0.shipVOs[iter_163_2].id == arg_163_1 then
			table.remove(arg_163_0.shipVOs, iter_163_2)

			break
		end
	end

	arg_163_0.shipVOsById[arg_163_1] = nil

	return
end

function var_0_0.updateShipCount(arg_164_0, arg_164_1)
	arg_164_0.shipContainer:SetTotalCount(#arg_164_0.shipVOs, defaultValue(arg_164_1, -1))
	setActive(arg_164_0.listEmptyTF, #arg_164_0.shipVOs <= 0)

	return
end

function var_0_0.ClearShipsBlackBlock(arg_165_0)
	if not arg_165_0.shipVOsById then
		return
	end

	for iter_165_0, iter_165_1 in pairs(arg_165_0.shipVOsById) do
		iter_165_1.blackBlock = false
	end

	return
end

function var_0_0.willExit(arg_166_0)
	arg_166_0:closeDestroyMode()
	arg_166_0:closeModAttr()
	arg_166_0:ClearShipsBlackBlock()

	if arg_166_0.guildShipEquipmentsPage then
		arg_166_0.guildShipEquipmentsPage:Destroy()
	end

	if arg_166_0.settingPanel then
		arg_166_0.settingPanel:Destroy()
	end

	if arg_166_0.destroyPage then
		arg_166_0.destroyPage:Destroy()
	end

	if arg_166_0.destroyConfirmWindow then
		arg_166_0.destroyConfirmWindow:Destroy()
	end

	if arg_166_0.contextData.mode == var_0_0.MODE_MOD then
		-- block empty
	elseif not arg_166_0.contextData.sortData then
		if _G[arg_166_0.contextData.preView] then
			_G[arg_166_0.contextData.preView].sortIndex = arg_166_0.sortIndex
			_G[arg_166_0.contextData.preView].selectAsc = arg_166_0.selectAsc
			_G[arg_166_0.contextData.preView].typeIndex = arg_166_0.typeIndex
			_G[arg_166_0.contextData.preView].campIndex = arg_166_0.campIndex
			_G[arg_166_0.contextData.preView].rarityIndex = arg_166_0.rarityIndex
			_G[arg_166_0.contextData.preView].extraIndex = arg_166_0.extraIndex
			_G[arg_166_0.contextData.preView].commonTag = arg_166_0.commonTag
		else
			DockyardScene.sortIndex = arg_166_0.sortIndex
			DockyardScene.selectAsc = arg_166_0.selectAsc
			DockyardScene.typeIndex = arg_166_0.typeIndex
			DockyardScene.campIndex = arg_166_0.campIndex
			DockyardScene.rarityIndex = arg_166_0.rarityIndex
			DockyardScene.extraIndex = arg_166_0.extraIndex
			DockyardScene.commonTag = arg_166_0.commonTag
		end
	end

	if arg_166_0.shipContainer then
		arg_166_0.shipContainer.enabled = false

		for iter_166_0, iter_166_1 in pairs(arg_166_0.scrollItems) do
			iter_166_1:clear()
			GetOrAddComponent(iter_166_1.go, "UILongPressTrigger").onLongPressed:RemoveAllListeners()
		end
	end

	if arg_166_0.phantomContainer then
		arg_166_0.phantomContainer.enabled = false

		for iter_166_2, iter_166_3 in pairs(arg_166_0.scrollPhantoms) do
			iter_166_3:clear()
		end
	end

	if LeanTween.isTweening(go(arg_166_0.energyDescTF)) then
		setActive(arg_166_0.energyDescTF, false)
		LeanTween.cancel(go(arg_166_0.energyDescTF))
	end

	arg_166_0:cancelAnimating()

	if arg_166_0.isRemouldOrUpgradeMode then
		local var_166_0 = getProxy(SettingsProxy)

		var_166_0:SetDockYardLockBtnFlag(arg_166_0.isFilterLockForMod)
		var_166_0:SetDockYardLevelBtnFlag(arg_166_0.isFilterLevelForMod)
	end

	if arg_166_0.bulinTip then
		arg_166_0.bulinTip:Destroy()

		arg_166_0.bulinTip = nil
	end

	if arg_166_0.searchBar then
		arg_166_0.searchBar:Dispose()

		arg_166_0.searchBar = nil
	end

	arg_166_0:UnOverlayPanel(arg_166_0.blurPanel, arg_166_0._tf)

	if arg_166_0:isLayer() then
		arg_166_0:UnOverlayPanel(arg_166_0._tf)
	end

	return
end

function var_0_0.uiStartAnimating(arg_167_0)
	local var_167_0 = arg_167_0.topPanel:Find("back")

	if isActive(arg_167_0.selectPanel) then
		shiftPanel(arg_167_0.selectPanel, nil, 0, 0.3, 0, true, true)
	end

	return
end

function var_0_0.uiExitAnimating(arg_168_0)
	if arg_168_0.contextData.mode == var_0_0.MODE_OVERVIEW then
		-- block empty
	else
		shiftPanel(arg_168_0.selectPanel, nil, -1 * arg_168_0.selectPanel.rect.height, 0.3, 0, true, true)
	end

	return
end

function var_0_0.back(arg_169_0)
	if arg_169_0.exited then
		return
	end

	arg_169_0:closeView()

	return
end

function var_0_0.cancelAnimating(arg_170_0)
	if LeanTween.isTweening(go(arg_170_0.topPanel)) then
		LeanTween.cancel(go(arg_170_0.topPanel))
	end

	if LeanTween.isTweening(go(arg_170_0.selectPanel)) then
		LeanTween.cancel(go(arg_170_0.selectPanel))
	end

	if arg_170_0.tweens then
		cancelTweens(arg_170_0.tweens)
	end

	return
end

function var_0_0.quickExitFunc(arg_171_0)
	seriesAsync({
		function(arg_172_0)
			if arg_171_0.contextData.onQuickHome then
				arg_171_0.contextData.onQuickHome(arg_172_0)
			else
				arg_172_0()
			end

			return
		end,
		function(arg_173_0)
			arg_171_0:emit(var_0_0.ON_HOME)

			return
		end
	})

	return
end

function var_0_0.displayDestroyPanel(arg_174_0)
	arg_174_0.destroyPage:ExecuteAction("Show")
	arg_174_0.destroyPage:ActionInvoke("Refresh", arg_174_0.selectedIds, arg_174_0.shipVOsById)

	return
end

function var_0_0.closeDestroyPanel(arg_175_0)
	if arg_175_0.destroyPage:isShowing() then
		arg_175_0.destroyPage:Hide()
	end

	return
end

function var_0_0.checkDestroyShips(arg_176_0, arg_176_1, arg_176_2)
	if PlayerPrefs.GetInt("RetireProtect", 1) == 0 then
		local var_176_0 = {}

		for iter_176_0, iter_176_1 in pairs(arg_176_1) do
			local var_176_1 = 0

			for iter_176_2, iter_176_3 in pairs(arg_176_1) do
				if iter_176_3:getGroupId() == iter_176_1:getGroupId() then
					var_176_1 = var_176_1 + 1
				end
			end

			local var_176_2 = getProxy(BayProxy)

			if #var_176_2:findShipsByGroup(iter_176_1:getGroupId()) == var_176_1 then
				local var_176_3 = false

				for iter_176_4, iter_176_5 in pairs({}) do
					if iter_176_5:getGroupId() == iter_176_1:getGroupId() then
						var_176_3 = true

						break
					end
				end

				if not var_176_3 then
					table.insert({}, iter_176_1)
				end
			end
		end

		if #{} > 0 then
			table.insert({}, function(arg_177_0)
				arg_176_0.destroyConfirmWindow:ExecuteAction("ShowOneShipProtect", var_176_0, arg_177_0)

				return
			end)
		end
	end

	local var_176_4, var_176_5 = ShipCalcHelper.GetEliteAndHightLevelShips(arg_176_1)

	if #var_176_4 > 0 or #var_176_5 > 0 then
		table.insert({}, function(arg_178_0)
			local var_178_0 = false

			if arg_176_0.contextData.mode == var_0_0.MODE_DESTROY then
				var_178_0 = ({
					ShipCalcHelper.CalcDestoryRes(arg_176_1)
				})[4]
			end

			arg_176_0.destroyConfirmWindow:ExecuteAction("Show", var_176_4, var_176_5, var_178_0, arg_178_0)

			return
		end)
	end

	if #underscore.filter(arg_176_1, function(arg_179_0)
		return arg_179_0:getFlag("inElite")
	end) > 0 then
		table.insert({}, function(arg_180_0)
			arg_176_0.destroyConfirmWindow:ExecuteAction("ShowEliteTag", var_0, arg_180_0)

			return
		end)
	end

	seriesAsync({}, arg_176_2)

	return
end

return var_0_0

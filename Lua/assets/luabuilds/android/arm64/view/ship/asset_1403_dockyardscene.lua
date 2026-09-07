local DockyardScene = class("DockyardScene", import("..base.BaseUI"))

DockyardScene.MODE_OVERVIEW = "overview"
DockyardScene.MODE_DESTROY = "destroy"
DockyardScene.MODE_SELECT = "select"
DockyardScene.MODE_MOD = "modify"
DockyardScene.MODE_WORLD = "world"
DockyardScene.MODE_REMOULD = "remould"
DockyardScene.MODE_UPGRADE = "upgrade"
DockyardScene.MODE_GUILD_BOSS = "guildboss"
DockyardScene.MODE_SHIP_PHANTOM = "phantom"
DockyardScene.TITLE_CN_OVERVIEW = i18n("word_dockyard")
DockyardScene.TITLE_CN_UPGRADE = i18n("word_dockyardUpgrade")
DockyardScene.TITLE_CN_DESTROY = i18n("word_dockyardDestroy")
DockyardScene.TITLE_EN_OVERVIEW = "dockyard"
DockyardScene.TITLE_EN_UPGRADE = "modernization"
DockyardScene.TITLE_EN_DESTROY = "retirement"
DockyardScene.PRIOR_MODE_EQUIP_UP = 1
DockyardScene.PRIOR_MODE_SHIP_UP = 2

function DockyardScene:getUIName()
	return "DockyardUI"
end

function DockyardScene:init()
	self.contextData.mode = defaultValue(self.contextData.mode, DockyardScene.MODE_SELECT)
	self.contextData.otherSelectedIds = defaultValue(self.contextData.otherSelectedIds, {})
	self.teamTypeFilter = self.contextData.teamFilter
	self.selectedMin = self.contextData.selectedMin or 1
	self.leastLimitMsg = self.contextData.leastLimitMsg
	self.selectedMax = self.contextData.selectedMax or 0
	self.contextData.selectedIds = self.contextData.selectedIds or {}

	if self.contextData.infoShipId then
		table.insert(self.contextData.selectedIds, self.contextData.infoShipId)

		self.contextData.infoShipId = nil
	end

	self.selectedIds = underscore(self.contextData.selectedIds):chain():select(function(arg_3_0)
		return getProxy(BayProxy):RawGetShipById(arg_3_0) ~= nil
	end):first(self.selectedMax):value()
	self.contextData.selectedIds = nil
	self.checkShip = self.contextData.onShip or function(arg_4_0, arg_4_1, arg_4_2)
		return true
	end
	self.onCancelShip = self.contextData.onCancelShip or function(arg_5_0, arg_5_1, arg_5_2)
		return true
	end
	self.onClick = self.contextData.onClick or function(arg_6_0, arg_6_1, arg_6_2)
		self:emit(DockyardMediator.ON_SHIP_DETAIL, arg_6_0, arg_6_1, arg_6_2)

		return
	end
	self.confirmSelect = self.contextData.confirmSelect
	self.callbackQuit = self.contextData.callbackQuit
	self.onSelected = self.contextData.onSelected or function(arg_7_0, arg_7_1)
		warning("not implemented.")

		return
	end
	self.blurPanel = self._tf:Find("blur_panel")
	self.settingBtn = self.blurPanel:Find("adapt/left_length/frame/setting")
	self.settingPanel = DockyardQuickSelectSettingPage.New(self._tf, self.event)

	self.settingPanel:OnSettingChanged(function()
		self:unselecteAllShips()

		return
	end)

	self.topPanel = self.blurPanel:Find("adapt/top")
	self.sortBtn = self.topPanel:Find("sort_button")
	self.sortImgAsc = self.sortBtn:Find("asc")
	self.sortImgDesc = self.sortBtn:Find("desc")
	self.leftTipsText = self.topPanel:Find("capacity")

	onButton(self, self.leftTipsText:Find("switch"), function()
		self.isCapacityMeta = not self.isCapacityMeta

		self:updateCapacityDisplay()

		return
	end, SFX_PANEL)
	onButton(self, self.leftTipsText:Find("plus"), function()
		gotoChargeScene()

		return
	end, SFX_PANEL)
	onButton(self, self.leftTipsText:Find("tip"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			content = i18n("specialshipyard_tip")
		})

		return
	end, SFX_PANEL)
	setActive(self.leftTipsText, false)

	self.indexBtn = self.topPanel:Find("index_button")
	self.switchPanel = self.topPanel:Find("switch")
	self.preferenceAndAttrContainer = self.switchPanel:Find("toggles")
	self.preferenceBtn = self.switchPanel:Find("toggles/preference_toggle")
	self.attrBtn = self.switchPanel:Find("toggles/attr_toggle")
	self.modLockFilter = self.topPanel:Find("mod_flter_lock")
	self.modLeveFilter = self.topPanel:Find("mod_flter_level")
	self.energyDescTF = self._tf:Find("energy_desc")
	self.energyDescTextTF = self.energyDescTF:Find("Text")
	self.selectPanel = self.blurPanel:Find("select_panel")
	self.bottomTipsText = self.selectPanel:Find("tip")
	self.bottomTipsWithFrame = self.selectPanel:Find("tipwithframe")

	setText(self.selectPanel:Find("bottom_info/bg_input/selected"), i18n("disassemble_selected") .. ":")

	self.awardTF = self.selectPanel:Find("bottom_info/bg_award")

	setText(self.awardTF:Find("label"), i18n("disassemble_available") .. ":")

	self.modAttrsTF = self.selectPanel:Find("bottom_info/bg_mod")
	self.viewEquipmentBtn = self.selectPanel:Find("view_equipments")
	self.tipPanel = self.blurPanel:Find("TipPanel")

	setActive(self.tipPanel, false)

	self.worldPanel = self.blurPanel:Find("world_port_panel")

	setActive(self.worldPanel, self.contextData.mode == DockyardScene.MODE_WORLD)

	self.assultBtn = self.blurPanel:Find("adapt/top/assult_btn")
	self.stampBtn = self.topPanel:Find("stamp")
	self.isRemouldOrUpgradeMode = self.contextData.mode == DockyardScene.MODE_REMOULD or self.contextData.mode == DockyardScene.MODE_UPGRADE

	setActive(self.modLeveFilter, self.isRemouldOrUpgradeMode)
	setActive(self.modLockFilter, self.isRemouldOrUpgradeMode)
	setActive(self.assultBtn, self.contextData.mode == DockyardScene.MODE_GUILD_BOSS)
	switch(self.contextData.mode, {
		[DockyardScene.MODE_OVERVIEW] = function()
			self.selecteEnabled = false

			return
		end,
		[DockyardScene.MODE_DESTROY] = function()
			self.selecteEnabled = true
			self.blacklist = {}
			self.destroyResList = UIItemList.New(self.awardTF:Find("res_list"), self.awardTF:Find("res_list/res"))

			return
		end,
		[DockyardScene.MODE_MOD] = function()
			self.selecteEnabled = true

			setText(self.modAttrsTF:Find("title/Text"), i18n("word_mod_value"))

			self.modAttrContainer = self.modAttrsTF:Find("attrs")

			return
		end,
		[DockyardScene.MODE_SHIP_PHANTOM] = function()
			self.selecteEnabled = false

			return
		end
	}, function()
		self.selecteEnabled = true

		return
	end)
	setActive(self.selectPanel, self.selecteEnabled and self.contextData.mode ~= DockyardScene.MODE_WORLD)
	setActive(self.worldPanel, self.contextData.mode == DockyardScene.MODE_WORLD)

	local var_2_0 = self.contextData.mode == DockyardScene.MODE_DESTROY

	setActive(self.settingBtn, self.contextData.mode == DockyardScene.MODE_DESTROY)
	setActive(self.selectPanel:Find("quick_select"), var_2_0)

	if self.contextData.priorEquipUpShipIDList and self.contextData.priorMode then
		setActive(self.tipPanel, true)

		local var_2_1 = self.tipPanel:Find("EquipUP")
		local var_2_2 = self.tipPanel:Find("ShipUP")

		setText(var_2_1, i18n("fightfail_choiceequip"))
		setText(var_2_2, i18n("fightfail_choicestrengthen"))
		setActive(var_2_1, self.contextData.priorMode == DockyardScene.PRIOR_MODE_EQUIP_UP)
		setActive(var_2_2, self.contextData.priorMode == DockyardScene.PRIOR_MODE_SHIP_UP)
	end

	self.togglePhantom = self._tf:Find("blur_panel/adapt/left_length/frame/toggle_phantom")

	onToggle(self, self.togglePhantom, function(arg_17_0)
		if self.inPhantom ~= arg_17_0 then
			self.inPhantom = arg_17_0

			self:SwitchContainerDisplay()
		end

		return
	end, SFX_PANEL)
	setActive(self.togglePhantom, false)

	self.helpPhantom = self._tf:Find("blur_panel/adapt/left_length/frame/help_phantom")

	onButton(self, self.helpPhantom, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("projection_help")
		})

		return
	end, SFX_PANEL)

	local var_2_3 = self.contextData.mode == DockyardScene.MODE_SHIP_PHANTOM and "phantom" or "dockyard"

	eachChild(self.topPanel:Find("titles"), function(arg_19_0, arg_19_1)
		setActive(arg_19_0, arg_19_0.name == var_2_3)

		return
	end)

	self.listEmptyTF = self._tf:Find("empty")

	setActive(self.listEmptyTF, false)

	self.listEmptyTxt = self.listEmptyTF:Find("Text")

	setText(self.listEmptyTxt, i18n("list_empty_tip_dockyardui"))

	self.destroyPage = ShipDestroyPage.New(self._tf, self.event)

	self.destroyPage:SetCardClickCallBack(function(arg_20_0)
		self.blacklist[arg_20_0.shipVO:getGroupId()] = true

		local var_20_0 = table.indexof(self.selectedIds, arg_20_0.shipVO.id)

		if var_20_0 and var_20_0 > 0 then
			table.remove(self.selectedIds, var_20_0)
		end

		self:updateDestroyRes()
		self:updateSelected()

		return
	end)
	self.destroyPage:SetConfirmCallBack(function()
		local var_21_0 = {}
		local var_21_1, var_21_2 = self:checkDestroyGold()

		if not var_21_2 then
			table.insert(var_21_0, function(arg_22_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("oil_max_tip_title") .. i18n("resource_max_tip_retire_1"),
					onYes = arg_22_0
				})

				return
			end)
		end

		local var_21_3 = underscore.map(self.selectedIds, function(arg_23_0)
			return self.shipVOsById[arg_23_0]
		end)

		table.insert(var_21_0, function(arg_24_0)
			self:checkDestroyShips(var_21_3, arg_24_0)

			return
		end)
		seriesAsync(var_21_0, function()
			self:emit(DockyardMediator.ON_DESTROY_SHIPS, self.selectedIds)

			return
		end)

		return
	end)

	self.destroyConfirmWindow = ShipDestoryConfirmWindow.New(self._tf, self.event)
	self.searchBar = RecordableSearchBar.New(RecordableSearchBar.CreateData({
		refresh_pos_when_expand = true,
		holder = i18n("dockyard_search_holder"),
		onActive = function(arg_26_0)
			setActive(self.preferenceAndAttrContainer, not arg_26_0)

			return
		end,
		onInputChanged = function()
			self:filter()

			return
		end,
		key = self.__cname,
		parent = self.switchPanel,
		expand_parent = self.blurPanel:Find("adapt"),
		anchoredPosition = Vector3(-33, -33, 0)
	}))

	return
end

function DockyardScene:SwitchContainerDisplay()
	self.isPhantomMode = self.contextData.mode == DockyardScene.MODE_SHIP_PHANTOM or self.inPhantom

	setActive(self.switchPanel, not self.isRemouldOrUpgradeMode and not self.isPhantomMode)
	setActive(self.indexBtn, not self.isRemouldOrUpgradeMode and not self.isPhantomMode)
	setActive(self.sortBtn, not self.isRemouldOrUpgradeMode and not self.isPhantomMode)
	setActive(self._tf:Find("main/ship_container"), not self.isPhantomMode)
	setActive(self._tf:Find("main/phantom_container"), self.isPhantomMode)
	setActive(self.preferenceBtn, not self.isPhantomMode)
	self:updateBarInfo()
	setActive(self.helpPhantom, self.contextData.mode == DockyardScene.MODE_SHIP_PHANTOM)

	if pg.SeriesGuideMgr.GetInstance():isEnd() and PlayerPrefs.GetInt("PHANTOM_HELP_FIRST", 0) == 0 then
		PlayerPrefs.SetInt("PHANTOM_HELP_FIRST", 1)
		triggerButton(self.helpPhantom)
	end

	switch(tobool(self.isPhantomMode), {
		[true] = function()
			self.initDic = self.initDic or {}

			if self.initDic.phantom then
				return
			end

			self.initDic.phantom = true

			local var_29_0 = self._tf:Find("main/phantom_container/title/content")

			UIItemList.StaticAlign(var_29_0, var_29_0:GetChild(0), getProxy(TechnologyProxy):getConfigMaxVersion() + 1, function(arg_30_0, arg_30_1, arg_30_2)
				if arg_30_0 == UIItemList.EventUpdate then
					arg_30_2.name = "phase_" .. arg_30_1

					GetImageSpriteFromAtlasAsync("ui/dockyardui_atlas", arg_30_1, arg_30_2:Find("on"))
					GetImageSpriteFromAtlasAsync("ui/dockyardui_atlas", arg_30_1, arg_30_2:Find("off"))
					onToggle(self, arg_30_2, function(arg_31_0)
						if arg_31_0 then
							self.selectVersion = arg_30_1
							self.filterBluePrint = underscore.filter(self.shipBluePrints, function(arg_32_0)
								return arg_30_1 == 0 or arg_32_0:getConfig("blueprint_version") == arg_30_1
							end)

							self.phantomContainer:SetTotalCount(#self.filterBluePrint, 0)
						end

						return
					end, SFX_PANEL)
				end

				return
			end)
			setActive(self._tf:Find("main/phantom_container/view/tpl"), false)

			self.phantomContainer = self._tf:Find("main/phantom_container/view/groups"):GetComponent("LScrollRect")
			self.phantomContainer.enabled = true
			self.phantomContainer.decelerationRate = 0.07

			function self.phantomContainer.onInitItem(arg_33_0)
				self:getOrInitPhantom(arg_33_0)
				ClearTweenItemAlphaAndWhite(arg_33_0)

				return
			end

			function self.phantomContainer.onUpdateItem(arg_34_0, arg_34_1)
				self:updatePhantomGroup(self.filterBluePrint[arg_34_0 + 1], arg_34_1)
				TweenItemAlphaAndWhite(arg_34_1)

				return
			end

			function self.phantomContainer.onReturnItem(arg_35_0, arg_35_1)
				if self.exited then
					return
				end

				self:getOrInitPhantom(arg_35_1):clear()
				ClearTweenItemAlphaAndWhite(arg_35_1)

				return
			end

			self.scrollPhantoms = {}
			self.phantomGroupDic = {}

			local var_29_1 = 0

			if self.contextData.techVersion and #underscore.filter(self.shipBluePrints, function(arg_36_0)
				return self.contextData.techVersion == 0 or arg_36_0:getConfig("blueprint_version") == self.contextData.techVersion
			end) > 0 then
				var_29_1 = self.contextData.techVersion
			end

			self.contextData.techVersion = nil

			triggerToggle(self._tf:Find("main/phantom_container/title/content"):GetChild(var_29_1), true)

			return
		end,
		[false] = function()
			self.initDic = self.initDic or {}

			if self.initDic.ship then
				return
			end

			self.initDic.ship = true
			self.shipContainer = self._tf:Find("main/ship_container/ships"):GetComponent("LScrollRect")
			self.shipContainer.enabled = true
			self.shipContainer.decelerationRate = 0.07

			function self.shipContainer.onInitItem(arg_38_0)
				self:onInitItem(arg_38_0)

				return
			end

			function self.shipContainer.onUpdateItem(arg_39_0, arg_39_1)
				self:onUpdateItem(arg_39_0, arg_39_1)

				return
			end

			function self.shipContainer.onReturnItem(arg_40_0, arg_40_1)
				self:onReturnItem(arg_40_0, arg_40_1)

				return
			end

			function self.shipContainer.onStart()
				self:updateSelected()

				return
			end

			self.shipLayout = self._tf:Find("main/ship_container/ships")
			self.scrollItems = {}
			self.cardItemDic = {}

			if _G[self.contextData.preView] then
				self.sortIndex = _G[self.contextData.preView].sortIndex or ShipIndexConst.SortLevel
				self.selectAsc = _G[self.contextData.preView].selectAsc or false
				self.typeIndex = _G[self.contextData.preView].typeIndex or ShipIndexConst.TypeAll
				self.campIndex = _G[self.contextData.preView].campIndex or ShipIndexConst.CampAll
				self.rarityIndex = _G[self.contextData.preView].rarityIndex or ShipIndexConst.RarityAll
				self.extraIndex = _G[self.contextData.preView].extraIndex or ShipIndexConst.ExtraAll
				self.commonTag = _G[self.contextData.preView].commonTag or Ship.PREFERENCE_TAG_NONE
			elseif self.contextData.sortData then
				self.sortIndex = self.contextData.sortData.sort or ShipIndexConst.SortLevel
				self.selectAsc = self.contextData.sortData.Asc or false
				self.typeIndex = self.contextData.sortData.typeIndex or ShipIndexConst.TypeAll
				self.campIndex = self.contextData.sortData.campIndex or ShipIndexConst.CampAll
				self.rarityIndex = self.contextData.sortData.rarityIndex or ShipIndexConst.RarityAll
				self.extraIndex = self.contextData.sortData.extraIndex or ShipIndexConst.ExtraAll
				self.commonTag = self.contextData.sortData.commonTag or Ship.PREFERENCE_TAG_NONE
			else
				if not DockyardScene.selectAsc then
					self.selectAsc = false
				end

				self.sortIndex = DockyardScene.sortIndex or ShipIndexConst.SortLevel
				self.typeIndex = DockyardScene.typeIndex or ShipIndexConst.TypeAll
				self.campIndex = DockyardScene.campIndex or ShipIndexConst.CampAll
				self.rarityIndex = DockyardScene.rarityIndex or ShipIndexConst.RarityAll
				self.extraIndex = DockyardScene.extraIndex or ShipIndexConst.ExtraAll
				self.commonTag = DockyardScene.commonTag or Ship.PREFERENCE_TAG_NONE
			end

			self:updateIndexDatas()
			triggerToggle(self.preferenceBtn, self.commonTag == Ship.PREFERENCE_TAG_COMMON)
			self:initIndexPanel()

			self.itemDetailType = -1

			if self.contextData.mode == DockyardScene.MODE_DESTROY then
				self.blacklist = {}
				self.selectPanel:GetComponent("HorizontalLayoutGroup").padding.right = 50

				setActive(self.selectPanel:Find("quick_select"), true)
				setActive(self.settingBtn, true)
			else
				self.selectPanel:GetComponent("HorizontalLayoutGroup").padding.right = 250

				setActive(self.selectPanel:Find("quick_select"), false)
				setActive(self.settingBtn, false)
			end

			if self.contextData.mode == DockyardScene.MODE_GUILD_BOSS then
				self.isShowAssultShips = false

				triggerToggle(self.assultBtn, true)

				self.guildShipEquipmentsPage = GuildShipEquipmentsPage.New(self._tf, self.event)

				self.guildShipEquipmentsPage:SetCallBack(function()
					self:TriggerCard(-1)

					return
				end, function()
					self:TriggerCard(1)

					return
				end)
			end

			eachChild(self.attrBtn, function(arg_44_0)
				setActive(arg_44_0, false)

				return
			end)

			self.isFormTactics = self.contextData.prevPage == "NewNavalTacticsMediator"

			local var_37_1 = self.attrBtn:Find("off"):GetComponent("Image")
			local var_37_2 = self.attrBtn:Find("on"):GetComponent("Image")

			if self.isFormTactics then
				GetImageSpriteFromAtlasAsync("ui/dockyardui_atlas", "skill_off", var_37_1)
				GetImageSpriteFromAtlasAsync("ui/dockyardui_atlas", "skill_on", var_37_2)
			else
				GetImageSpriteFromAtlasAsync("ui/dockyardui_atlas", "attr_off", var_37_1)
				GetImageSpriteFromAtlasAsync("ui/dockyardui_atlas", "attr_on", var_37_2)
			end

			triggerButton(self.attrBtn)

			if self.isRemouldOrUpgradeMode then
				local var_37_3 = getProxy(SettingsProxy)

				self.isFilterLevelForMod = var_37_3:GetDockYardLevelBtnFlag()

				self:OnSwitch(self.modLeveFilter, self.isFilterLevelForMod, function(arg_45_0)
					self.isFilterLevelForMod = arg_45_0

					self:filter()

					return
				end)

				self.isFilterLockForMod = var_37_3:GetDockYardLockBtnFlag()

				self:OnSwitch(self.modLockFilter, self.isFilterLockForMod, function(arg_46_0)
					self.isFilterLockForMod = arg_46_0

					self:filter()

					return
				end)
			end

			self.shipContainer:GetComponentInChildren(typeof(GridLayoutGroup)).constraintCount = 7

			self:filter()

			return
		end
	})

	if self.isPhantomMode then
		setActive(self.listEmptyTF, #self.filterBluePrint == 0)
	else
		setActive(self.listEmptyTF, #self.shipVOs <= 0)
	end

	return
end

function DockyardScene:isDefaultStatus()
	return self.sortIndex == ShipIndexConst.SortLevel and (not self.typeIndex or self.typeIndex == ShipIndexConst.TypeAll) and (not self.campIndex or self.campIndex == ShipIndexConst.CampAll) and (not self.rarityIndex or self.rarityIndex == ShipIndexConst.RarityAll) and (not self.extraIndex or self.extraIndex == ShipIndexConst.ExtraAll)
end

function DockyardScene:setShipsCount(arg_48_1, arg_48_2)
	self.shipsCount = arg_48_1
	self.specialShipCount = arg_48_2

	return
end

function DockyardScene:GetCard(arg_49_1)
	return DockyardShipItem.New(arg_49_1, self.contextData.hideTagFlags, self.contextData.blockTagFlags)
end

function DockyardScene:OnClickCard(arg_50_1)
	if arg_50_1.shipVO then
		if not self.selecteEnabled then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_CLICK)

			DockyardScene.value = self.shipContainer.value

			self.onClick(arg_50_1.shipVO, self.shipVOs)
		else
			pg.CriMgr.GetInstance():PlaySoundEffect_V3((table.contains(self.selectedIds, arg_50_1.shipVO.id) or nil) and (SFX_UI_CANCEL or SFX_UI_FORMATION_SELECT))
			self:selectShip(arg_50_1.shipVO)
		end
	else
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_CLICK)

		if self.callbackQuit then
			self.onSelected({}, function()
				self:back()

				return
			end)
		elseif not arg_50_1.isLoading then
			self.onSelected({})
			self:back()
		end
	end

	return
end

function DockyardScene:OnClickPhantom(arg_52_1)
	if arg_52_1.phantomId == 0 then
		return
	else
		self:emit(DockyardMediator.CHANGE_SKIN, arg_52_1)
	end

	return
end

function DockyardScene:onInitItem(arg_53_1)
	if self.scrollItems[arg_53_1] then
		return self.scrollItems[arg_53_1]
	end

	local var_53_0 = self:GetCard(arg_53_1)

	var_53_0:updateDetail(self.itemDetailType)

	var_53_0.isLoading = true

	onButton(self, var_53_0.go, function()
		self:OnClickCard(var_53_0)

		return
	end)

	local var_53_1 = GetOrAddComponent(var_53_0.go, "UILongPressTrigger").onLongPressed

	if self.contextData.preView == NewBackYardShipInfoLayer.__cname then
		var_53_1:RemoveAllListeners()
		var_53_1:AddListener(function()
			if var_53_0.shipVO then
				self.contextData.selectedIds = self.selectedIds

				self.onClick(var_53_0.shipVO, underscore.select(self.shipVOs, function(arg_56_0)
					return arg_56_0
				end), self.contextData)
			end

			return
		end)
	else
		var_53_1:RemoveAllListeners()
	end

	self.scrollItems[arg_53_1] = var_53_0

	return var_53_0
end

function DockyardScene:getOrInitPhantom(arg_57_1)
	self.scrollPhantoms[arg_57_1] = self.scrollPhantoms[arg_57_1] or {
		isClear = true,
		go = arg_57_1,
		tf = tf(arg_57_1),
		updateSelected = function(self, arg_58_1)
			self.shipCard:updateSelected(arg_58_1[0])
			eachChild(self.tf:Find("phantoms"), function(arg_59_0, arg_59_1)
				arg_59_1 = arg_59_1 + 1

				setActive(arg_59_0:Find("selected"), self.phantoms[arg_59_1 + 1] and arg_58_1[self.phantoms[arg_59_1 + 1].phantomId])

				return
			end)

			return
		end,
		clear = function(self)
			if self.isClear then
				return
			end

			self.shipCard:clear()

			self.isClear = true

			return
		end
	}

	return self.scrollPhantoms[arg_57_1]
end

function DockyardScene:updatePhantomGroup(arg_61_1, arg_61_2)
	local var_61_0 = self:getOrInitPhantom(arg_61_2)

	var_61_0.isClear = false
	self.phantomGroupDic[arg_61_1.shipId] = arg_61_2
	var_61_0.shipCard = var_61_0.shipCard or self:GetCard(var_61_0.tf:Find("card"):GetChild(0).gameObject)

	local var_61_1 = self.shipVOsById[arg_61_1.shipId]:getAllShipPhantom()

	assert(var_61_1[1].phantomId == 0)

	var_61_0.phantoms = var_61_1

	var_61_0.shipCard:update(var_61_1[1])
	var_61_0.shipCard:updateSelected(underscore.any(self.selectedIds, function(arg_62_0)
		return arg_62_0 == var_61_1[1].id
	end))
	self:updateItemBlackBlock(var_61_0.shipCard)

	var_61_0.shipCard.isLoading = false

	var_61_0.shipCard:updateIntimacyEnergy(false)
	var_61_0.shipCard:updateIntimacy(false)
	onButton(self, var_61_0.shipCard.tr, function()
		self:OnClickPhantom(var_61_1[1])

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

				setActive(arg_64_2:Find("selected"), underscore.any(self.selectedMarks or {}, function(arg_65_0)
					return var_64_1 == arg_65_0
				end))
				setActive(arg_64_2:Find("skin/mark/base"), self.contextData.mode ~= DockyardScene.MODE_SHIP_PHANTOM)
				setActive(arg_64_2:Find("skin/mark/toggle"), self.contextData.mode == DockyardScene.MODE_SHIP_PHANTOM)

				local var_64_2 = var_64_0:getRandomFlag()

				onToggle(self, arg_64_2:Find("skin/mark/toggle"), function(arg_66_0)
					if arg_66_0 ~= var_64_2 then
						var_64_2 = arg_66_0

						self:emit(DockyardMediator.CHANGE_RANDOM_FLAG, var_64_0:GetShipPhantomMark(), var_64_2)
					end

					return
				end, SFX_UI_CLICK)
				triggerToggle(arg_64_2:Find("skin/mark/toggle"), var_64_2)
			else
				setActive(arg_64_2:Find("selected"), false)
			end

			onButton(self, arg_64_2, function()
				if var_64_0 then
					self:OnClickPhantom(var_64_0)
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

function DockyardScene:showEnergyDesc(arg_68_1, arg_68_2)
	if LeanTween.isTweening(go(self.energyDescTF)) then
		LeanTween.cancel(go(self.energyDescTF))

		self.energyDescTF.localScale = Vector3.one
	end

	setText(self.energyDescTextTF, i18n(arg_68_2))

	self.energyDescTF.position = arg_68_1

	setActive(self.energyDescTF, true)
	LeanTween.scale(self.energyDescTF, Vector3.zero, 0.2):setDelay(1):setFrom(Vector3.one):setOnComplete(System.Action(function()
		self.energyDescTF.localScale = Vector3.one

		setActive(self.energyDescTF, false)

		return
	end))

	return
end

function DockyardScene:onUpdateItem(arg_70_1, arg_70_2)
	local var_70_0 = self.shipVOs[arg_70_1 + 1]

	self.cardItemDic[(self.shipVOs[arg_70_1 + 1] or nil) and (var_70_0.id or 0)] = arg_70_2

	local var_70_1 = self:onInitItem(arg_70_2)

	var_70_1:update(var_70_0)

	if self.contextData.mode == DockyardScene.MODE_WORLD then
		var_70_1:updateWorld()
	end

	var_70_1:updateSelected(var_70_1.shipVO and underscore.any(self.selectedIds, function(arg_71_0)
		return var_70_1.shipVO.id == arg_71_0
	end))
	self:updateItemBlackBlock(var_70_1)

	var_70_1.isLoading = false

	var_70_1:updateIntimacyEnergy(self.contextData.energyDisplay or self.sortIndex == ShipIndexConst.SortEnergy)
	var_70_1:updateIntimacy((self.sortIndex == ShipIndexConst.SortIntimacy or self.extraIndex == ShipIndexConst.ExtraMarry) and self.contextData.mode ~= DockyardScene.MODE_UPGRADE)

	return
end

function DockyardScene:onReturnItem(arg_72_1, arg_72_2)
	if self.exited then
		return
	end

	if self.scrollItems[arg_72_2] then
		self.scrollItems[arg_72_2]:clear()
	end

	return
end

function DockyardScene:updateIndexDatas()
	self.contextData.indexDatas = self.contextData.indexDatas or {}
	self.contextData.indexDatas.sortIndex = self.sortIndex
	self.contextData.indexDatas.typeIndex = self.typeIndex
	self.contextData.indexDatas.campIndex = self.campIndex
	self.contextData.indexDatas.rarityIndex = self.rarityIndex
	self.contextData.indexDatas.extraIndex = self.extraIndex

	return
end

function DockyardScene:initIndexPanel()
	onButton(self, self.indexBtn, function()
		self:emit(DockyardMediator.OPEN_DOCKYARD_INDEX, {
			indexDatas = Clone(self.contextData.indexDatas),
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
			callback = function(self)
				self.sortIndex = self.sortIndex
				self.typeIndex = self.typeIndex
				self.campIndex = self.campIndex
				self.rarityIndex = self.rarityIndex
				self.extraIndex = self.extraIndex

				self:updateIndexDatas()
				self:filter()

				return
			end
		})

		return
	end, SFX_PANEL)
	onToggle(self, self.preferenceBtn, function(arg_77_0)
		self.commonTag = arg_77_0 and Ship.PREFERENCE_TAG_COMMON or Ship.PREFERENCE_TAG_NONE

		self:filter()

		return
	end)

	return
end

function DockyardScene:setShips(arg_78_1)
	self.shipVOsById = arg_78_1

	local var_78_0 = getProxy(TechnologyProxy)

	self.shipBluePrints = {}

	for iter_78_0, iter_78_1 in ipairs(var_78_0:getAllBluePrintShipIds()) do
		local var_78_1 = getProxy(BayProxy):getShipById(iter_78_1)

		if #var_78_1:getAllShipPhantomMarks() > 1 then
			table.insert(self.shipBluePrints, var_78_0:getBluePrintById(var_78_1.groupId))
		end
	end

	table.sort(self.shipBluePrints, CompareFuncs({
		function(arg_79_0)
			return arg_79_0:getConfig("blueprint_version")
		end,
		function(arg_80_0)
			return arg_80_0.id
		end
	}))

	return
end

function DockyardScene:setPlayer(arg_81_1)
	self.player = arg_81_1

	self:updateBarInfo()

	return
end

function DockyardScene:updateBarInfo()
	setActive(self.bottomTipsText, self.contextData.leftTopInfo)
	setText(self.bottomTipsText, self.contextData.leftTopInfo and i18n("dock_yard_left_tips", self.contextData.leftTopInfo) or "")
	setActive(self.bottomTipsWithFrame, self.contextData.leftTopWithFrameInfo)
	setText(self.bottomTipsWithFrame:Find("Text"), self.contextData.leftTopWithFrameInfo or "")

	if self.contextData.mode == DockyardScene.MODE_WORLD or self.contextData.mode == DockyardScene.MODE_GUILD_BOSS or self.contextData.mode == DockyardScene.MODE_REMOULD or self.isPhantomMode then
		setActive(self.leftTipsText, false)
	else
		setActive(self.leftTipsText, true)
		self:updateCapacityDisplay()
	end

	return
end

function DockyardScene:updateCapacityDisplay()
	setActive(self.leftTipsText:Find("plus"), not self.isCapacityMeta)
	setActive(self.leftTipsText:Find("tip"), self.isCapacityMeta)
	setActive(self.leftTipsText:Find("switch/off"), not self.isCapacityMeta)
	setActive(self.leftTipsText:Find("switch/on"), self.isCapacityMeta)

	if self.isCapacityMeta then
		setText(self.leftTipsText:Find("label"), i18n("specialshipyard_name"))
		setText(self.leftTipsText:Find("Text"), self.specialShipCount)
	else
		setText(self.leftTipsText:Find("label"), i18n("ship_dockyardScene_capacity"))
		setText(self.leftTipsText:Find("Text"), self.shipsCount .. "/" .. self.player:getMaxShipBag())
	end

	return
end

function DockyardScene:initWorldPanel()
	onButton(self, self.worldPanel:Find("btn_repair"), function()
		if #self.selectedIds > 0 then
			self:repairWorldShip(self.shipVOsById[self.selectedIds[1]])
		end

		return
	end, SFX_PANEL)
	onButton(self, self.worldPanel:Find("btn_repair_all"), function()
		local var_86_0 = {}
		local var_86_1 = 0

		for iter_86_0, iter_86_1 in pairs(self.shipVOsById) do
			local var_86_2 = WorldConst.FetchWorldShip(iter_86_1.id)

			if var_86_2:IsBroken() or not var_86_2:IsHpFull() then
				table.insert(var_86_0, var_86_2.id)

				var_86_1 = var_86_1 + nowWorld():CalcRepairCost(var_86_2)
			end
		end

		if #var_86_0 == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("world_ship_repair_no_need"))
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("world_ship_repair_all", var_86_1),
				onYes = function()
					self:emit(DockyardMediator.ON_SHIP_REPAIR, var_86_0, var_86_1)

					return
				end
			})
		end

		return
	end, SFX_PANEL)

	return
end

function DockyardScene:repairWorldShip(arg_88_1)
	local var_88_0 = WorldConst.FetchWorldShip(arg_88_1.id)
	local var_88_1 = nowWorld():CalcRepairCost(var_88_0)

	if var_88_0:IsBroken() then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("world_ship_repair_2", arg_88_1:getName(), var_88_1),
			onYes = function()
				self:emit(DockyardMediator.ON_SHIP_REPAIR, {
					var_88_0.id
				}, var_88_1)

				return
			end
		})
	elseif not var_88_0:IsHpFull() then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("world_ship_repair_1", arg_88_1:getName(), var_88_1),
			onYes = function()
				self:emit(DockyardMediator.ON_SHIP_REPAIR, {
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

function DockyardScene:filter()
	LoadImageSpriteAtlasAsync("ui/dockyardui_atlas", self:isDefaultStatus() and "shaixuan_off" or "shaixuan_on", self.indexBtn, true)

	if self.isRemouldOrUpgradeMode then
		self:filterForRemouldAndUpgrade()
	else
		self:filterCommon()
	end

	local var_91_0 = 0

	if self.contextData.quitTeam then
		var_91_0 = var_91_0 + 1

		table.insert(self.shipVOs, var_91_0, false)
	end

	if self.contextData.priorEquipUpShipIDList then
		local var_91_1 = {}

		for iter_91_0, iter_91_1 in ipairs(self.contextData.priorEquipUpShipIDList) do
			var_91_1[iter_91_1] = true
		end

		for iter_91_2 = #self.shipVOs, 1, -1 do
			local var_91_2 = type(self.shipVOs[iter_91_2]) == "table" and self.shipVOs[iter_91_2].id

			if var_91_1[var_91_2] then
				var_91_1[var_91_2] = table.remove(self.shipVOs, iter_91_2)
			end
		end

		for iter_91_3, iter_91_4 in ipairs(self.contextData.priorEquipUpShipIDList) do
			if type(var_91_1[iter_91_4]) == "table" then
				var_91_0 = var_91_0 + 1

				table.insert(self.shipVOs, var_91_0, var_91_1[iter_91_4])
			end
		end
	end

	if DockyardScene.MODE_OVERVIEW == self.contextData.mode and DockyardScene.value then
		self:updateShipCount(DockyardScene.value or 0)

		DockyardScene.value = nil
	else
		self:updateShipCount(0)
	end

	return
end

function DockyardScene:filterForRemouldAndUpgrade()
	self.shipVOs = {}

	local var_92_0 = self.isFilterLockForMod
	local var_92_1 = self.isFilterLevelForMod

	local function var_92_2(arg_93_0)
		return (not var_92_1 and arg_93_0.level > 1 or nil) and false
	end

	for iter_92_0, iter_92_1 in pairs(self.shipVOsById) do
		if var_92_2(iter_92_1) then
			table.insert(self.shipVOs, iter_92_1)
		end
	end

	table.sort(self.shipVOs, CompareFuncs({
		function(arg_94_0)
			return arg_94_0.level
		end,
		function(arg_95_0)
			return arg_95_0:isTestShip() and 1 or 0
		end
	}))

	return
end

function DockyardScene:filterCommon()
	self.shipVOs = {}

	local var_96_0 = self.sortIndex

	local function var_96_1(arg_97_0)
		if self.contextData.mode ~= DockyardScene.MODE_GUILD_BOSS then
			return true
		end

		if self.isShowAssultShips then
			return true
		end

		if not arg_97_0.user then
			return true
		end

		if arg_97_0.user.id == self.player.id then
			return true
		end

		return false
	end

	for iter_96_0, iter_96_1 in pairs(self.shipVOsById) do
		if self.contextData.blockLock and iter_96_1:GetLockState() == Ship.LOCK_STATE_LOCK then
			-- block empty
		elseif self.teamTypeFilter and iter_96_1:getTeamType() ~= self.teamTypeFilter then
			-- block empty
		elseif ShipIndexConst.filterByType(iter_96_1, self.typeIndex) and ShipIndexConst.filterByCamp(iter_96_1, self.campIndex) and ShipIndexConst.filterByRarity(iter_96_1, self.rarityIndex) and ShipIndexConst.filterByExtra(iter_96_1, self.extraIndex) and (self.commonTag == Ship.PREFERENCE_TAG_NONE or self.commonTag == iter_96_1:GetPreferenceTag()) and var_96_1(iter_96_1) then
			table.insert(self.shipVOs, iter_96_1)
		end
	end

	local var_96_2 = self.searchBar:GetInputText()

	if var_96_2 and var_96_2 ~= "" then
		self.shipVOs = underscore.filter(self.shipVOs, function(arg_98_0)
			return arg_98_0:IsMatchKey(var_96_2)
		end)
	end

	local var_96_3, var_96_4 = ShipIndexConst.getSortFuncAndName(var_96_0, self.selectAsc)

	if var_96_0 ~= ShipIndexConst.SortIntimacy then
		if not defaultValue((self.contextData.hideTagFlags or {}).inFleet, ShipStatus.TAG_HIDE_BASE.inFleet) then
			table.insert(var_96_3, 1, function(arg_99_0)
				return arg_99_0:getFlag("inFleet") and 0 or 1
			end)
		end
	end

	if var_96_3 then
		self:SortShips(var_96_3)
	end

	self:updateSelected()
	setActive(self.sortImgAsc, self.selectAsc)
	setActive(self.sortImgDesc, not self.selectAsc)
	setText(self.sortBtn:Find("Image"), i18n(var_96_4))

	return
end

function DockyardScene:SortShips(arg_100_1)
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
	elseif self.isFormTactics then
		table.insert(arg_100_1, 1, function(arg_102_0)
			return arg_102_0:getNation() == Nation.META and 1 or 0
		end)
		table.insert(arg_100_1, 1, function(arg_103_0)
			return arg_103_0:isFullSkillLevel() and 1 or 0
		end)
	elseif self.contextData.mode == DockyardScene.MODE_OVERVIEW or self.contextData.mode == DockyardScene.MODE_SELECT then
		table.insert(arg_100_1, 1, function(arg_104_0)
			return -arg_104_0.activityNpc
		end)
	elseif self.contextData.mode == DockyardScene.MODE_GUILD_BOSS then
		table.insert(arg_100_1, 1, function(arg_105_0)
			return arg_105_0.guildRecommand and 0 or 1
		end)
	end

	table.sort(self.shipVOs, CompareFuncs(arg_100_1))

	return
end

function DockyardScene:UpdateGuildViewEquipmentsBtn()
	setActive(self.viewEquipmentBtn, self.contextData.mode == DockyardScene.MODE_GUILD_BOSS and #self.selectedIds > 0)

	return
end

function DockyardScene:GetSelectCount()
	return #self.selectedIds
end

function DockyardScene:GetConfirmSelect()
	return self.selectedIds
end

function DockyardScene:didEnter()
	if self:isLayer() then
		self:OverlayPanel(self._tf, {
			groupDelta = -1
		})
	end

	self:OverlayPanel(self.blurPanel)
	self:PlayUIAnimation(self.blurPanel, "enter")

	local var_109_0 = getProxy(TaskProxy):mingshiTouchFlagEnabled()

	var_109_0 = var_109_0 and self.contextData.mode ~= DockyardScene.MODE_GUILD_BOSS

	setActive(self.stampBtn, var_109_0)
	self:UpdateGuildViewEquipmentsBtn()
	onButton(self, self.stampBtn, function()
		getProxy(TaskProxy):dealMingshiTouchFlag(1)

		return
	end, SFX_CONFIRM)
	onButton(self, self.topPanel:Find("back"), function()
		self:back()

		return
	end, SFX_CANCEL)
	onButton(self, self.sortBtn, function()
		self.selectAsc = not self.selectAsc

		self:filter()

		return
	end, SFX_UI_CLICK)
	onToggle(self, self.assultBtn, function(arg_113_0)
		self.isShowAssultShips = arg_113_0

		self:filter()

		return
	end, SFX_PANEL)
	onButton(self, self.viewEquipmentBtn, function()
		if not self.selectedIds[#self.selectedIds] then
			return
		end

		self.guildShipEquipmentsPage:ExecuteAction("Show", self.shipVOsById[self.selectedIds[#self.selectedIds]], self.shipVOsById[self.selectedIds[#self.selectedIds]].user)

		return
	end, SFX_PANEL)
	onButton(self, self.attrBtn, function()
		if not self.isFormTactics then
			self.itemDetailType = (self.itemDetailType + 1) % 4
		elseif self.itemDetailType == DockyardShipItem.DetailType0 then
			self.itemDetailType = DockyardShipItem.DetailType3 or DockyardShipItem.DetailType0
		end

		setActive(self.attrBtn:Find("off"), self.itemDetailType == DockyardShipItem.DetailType0)
		setActive(self.attrBtn:Find("on"), self.itemDetailType ~= DockyardShipItem.DetailType0)

		if self.itemDetailType == DockyardShipItem.DetailType0 then
			self.attrBtn:GetComponent("Button").targetGraphic = imageOff or imageOn
		end

		self:updateItemDetailType()

		return
	end, SFX_PANEL)
	onButton(self, self.selectPanel:Find("cancel_button"), function()
		if self.animating then
			return
		end

		if self.contextData.mode == DockyardScene.MODE_DESTROY then
			if #self.selectedIds > 0 then
				self:unselecteAllShips()
				self:back()
			else
				self:back()
			end
		else
			self:back()

			return
		end

		return
	end, SFX_CANCEL)
	onButton(self, self.selectPanel:Find("confirm_button"), function()
		if self.animating then
			return
		end

		if self.contextData.mode == DockyardScene.MODE_DESTROY then
			local var_117_0, var_117_1 = self:checkDestroyGold()

			if not var_117_0 or not var_117_1 then
				if not var_117_0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title") .. i18n("resource_max_tip_retire"))
				elseif not var_117_0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("oil_max_tip_title") .. i18n("resource_max_tip_retire"))
				end

				return
			end
		end

		if self:GetSelectCount() < self.selectedMin then
			if self.leastLimitMsg then
				pg.TipsMgr.GetInstance():ShowTips(self.leastLimitMsg)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("ship_dockyardScene_error_choiseRoleMore", self.selectedMin))
			end

			return
		end

		if self.contextData.mode == DockyardScene.MODE_DESTROY then
			self:displayDestroyPanel()
		else
			local var_117_2 = {}

			if self.contextData.destroyCheck then
				local var_117_3 = underscore.map(self.selectedIds, function(arg_118_0)
					return self.shipVOsById[arg_118_0]
				end)

				table.insert(var_117_2, function(arg_119_0)
					self:checkDestroyShips(var_117_3, arg_119_0)

					return
				end)
			end

			local var_117_4 = self:GetConfirmSelect()

			if self.confirmSelect then
				table.insert(var_117_2, function(arg_120_0)
					self.confirmSelect(var_117_4, function()
						arg_120_0(true)

						return
					end, arg_120_0)

					return
				end)
				seriesAsync(var_117_2, function(arg_122_0)
					if arg_122_0 then
						self.onSelected(var_117_4)
					end

					self:back()

					return
				end)
			else
				table.insert(var_117_2, function(arg_123_0)
					if self.callbackQuit then
						self.onSelected(var_117_4, arg_123_0)
					else
						self.onSelected(var_117_4)
						arg_123_0()
					end

					return
				end)
				seriesAsync(var_117_2, function()
					self:back()

					return
				end)
			end
		end

		return
	end, SFX_CONFIRM)
	onButton(self, self.selectPanel:Find("quick_select"), function()
		if self.animating then
			return
		end

		local var_125_0 = {
			PlayerPrefs.GetInt("QuickSelectRarity1", 3),
			PlayerPrefs.GetInt("QuickSelectRarity2", 4),
			PlayerPrefs.GetInt("QuickSelectRarity3", 2)
		}
		local var_125_1 = {}

		for iter_125_0, iter_125_1 in pairs(var_125_0) do
			if iter_125_1 ~= 0 then
				var_125_1[iter_125_1] = var_125_1[iter_125_1] or 3
			end
		end

		local var_125_3 = {}
		local var_125_4 = {}

		for iter_125_2, iter_125_3 in pairs((getProxy(BayProxy):getShips())) do
			if iter_125_3:isMaxStar() then
				var_125_3[iter_125_3:getGroupId()] = true
			else
				local var_125_5 = iter_125_3:getMaxStar() - iter_125_3:getStar() + 1

				if iter_125_3:GetLockState() == Ship.LOCK_STATE_UNLOCK then
					var_125_5 = var_125_5 + 1
				end

				local var_125_6 = var_125_4[iter_125_3:getGroupId()]

				var_125_4[iter_125_3:getGroupId()] = var_125_6 and var_125_6 < var_125_5 and var_125_6 or var_125_5
			end
		end

		local var_125_7 = _.select(self.shipVOs, function(arg_126_0)
			return arg_126_0.configId ~= 100001 and arg_126_0.configId ~= 100011 and arg_126_0:GetLockState() == Ship.LOCK_STATE_UNLOCK and table.contains(var_125_0, arg_126_0:getRarity()) and arg_126_0.level == 1 and not self.blacklist[arg_126_0:getGroupId()] and not table.contains(self.selectedIds, arg_126_0.id) and not arg_126_0:hasAnyFlag({
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
			return self.blacklist[arg_127_0:getGroupId()]
		end) then
			var_125_7 = _.select(var_125_7, function(arg_128_0)
				return not self.blacklist[arg_128_0:getGroupId()]
			end)
		elseif #self.selectedIds > 0 then
			var_125_7 = {}
		end

		table.sort(var_125_7, function(arg_129_0, arg_129_1)
			local var_129_0 = var_125_1[arg_129_0:getRarity()] or 0
			local var_129_1 = var_125_1[arg_129_1:getRarity()] or 0

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

		for iter_125_4, iter_125_5 in ipairs(self.selectedIds) do
			local var_125_16, var_125_17 = self.shipVOsById[iter_125_5]:calReturnRes()

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
			if self.selectedMax > 0 and self.selectedMax <= self:GetSelectCount() then
				break
			end

			local var_125_18, var_125_19 = iter_125_7:calReturnRes()

			var_125_14 = var_125_14 + var_125_18
			var_125_15 = var_125_15 + var_125_19
			var_125_12 = self.player:OilMax(var_125_15)
			var_125_13 = self.player:GoldMax(var_125_14)

			if var_125_13 then
				break
			end

			var_125_11 = var_125_11 + 1

			self:selectShip(iter_125_7)
		end

		if var_125_11 == 0 then
			if var_125_13 then
				if #self.selectedIds == 0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title") .. i18n("resource_max_tip_retire"))
				else
					pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title"))
				end
			elseif #self.selectedIds > 0 then
				self:displayDestroyPanel()
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("retire_selectzero"))
			end
		elseif var_125_12 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("oil_max_tip_title") .. i18n("resource_max_tip_retire_1"),
				onYes = function()
					self:displayDestroyPanel()

					return
				end
			})
		else
			self:displayDestroyPanel()
		end

		return
	end, SFX_CONFIRM)

	if isActive(self.togglePhantom) then
		triggerToggle(self.togglePhantom, tobool(self.inPhantom))
	else
		self:SwitchContainerDisplay()
	end

	self:updateBarInfo()

	if self.contextData.mode == DockyardScene.MODE_WORLD then
		self:initWorldPanel()
	elseif self.contextData.mode == DockyardScene.MODE_DESTROY and not LOCK_DESTROY_GUIDE then
		pg.SystemGuideMgr.GetInstance():Play(self)
	end

	setAnchoredPosition(self.topPanel, {
		y = self.topPanel.rect.height
	})
	setAnchoredPosition(self.selectPanel, {
		y = -1 * self.selectPanel.rect.height
	})
	onNextTick(function()
		if self.exited then
			return
		end

		self:uiStartAnimating()

		return
	end)

	self.bulinTip = AprilFoolBulinSubView.ShowAprilFoolBulin(self)

	onButton(self, self.settingBtn, function()
		self.settingPanel:Load()
		self.settingPanel:ActionInvoke("Show")

		return
	end)
	pg.SystemGuideMgr.GetInstance():Play(self)

	return
end

function DockyardScene:TriggerCard(arg_134_1)
	local var_134_0 = self.selectedIds[1]

	if not self.selectedIds[1] then
		return
	end

	local var_134_1

	for iter_134_0, iter_134_1 in ipairs(self.shipVOs) do
		if iter_134_1 and iter_134_1.id == var_134_0 then
			var_134_1 = iter_134_0

			break
		end
	end

	if not var_134_1 then
		return
	end

	local var_134_2 = var_134_1

	local function var_134_4()
		var_134_2 = var_134_2 + arg_134_1

		if not self.shipVOs[var_134_2] or self.checkShip(self.shipVOs[var_134_2]) then
			return self.shipVOs[var_134_2]
		else
			return var_134_4()
		end

		return
	end

	local var_134_5 = (nil)()

	if not var_134_5 then
		return
	end

	local function var_134_6()
		local var_136_0

		for iter_136_0, iter_136_1 in pairs(self.scrollItems) do
			if iter_136_1.shipVO and iter_136_1.go.name ~= "-1" and iter_136_1.shipVO.id == var_134_5.id then
				var_136_0 = iter_136_1

				break
			end
		end

		return var_136_0
	end

	local var_134_7 = self.cardItemDic[var_134_0] and self.scrollItems[self.cardItemDic[var_134_0]]
	local var_134_8 = self.cardItemDic[var_134_0] and self.scrollItems[self.cardItemDic[var_134_0]] and var_134_7.shipVO.id == var_134_5.id and var_134_7 or nil

	if self.cardItemDic[var_134_0] and self.scrollItems[self.cardItemDic[var_134_0]] and var_134_7.shipVO.id == var_134_5.id and var_134_7 or nil then
		if not getBounds(self._tf:Find("main/ship_container")):Intersects((getBounds(var_134_8.tr))) then
			self.shipContainer:SetNormalizedPosition(self.shipContainer.value + arg_134_1 * (self.shipContainer:HeadIndexToValue(7) - self.shipContainer:HeadIndexToValue(1)), 1)
		end
	end

	if not var_134_8 then
		self.shipContainer:SetNormalizedPosition(self.shipContainer.value + (math.ceil(var_134_2 / 7) - math.ceil(var_134_1 / 7)) * (self.shipContainer:HeadIndexToValue(21) - self.shipContainer:HeadIndexToValue(1)), 1)

		var_134_8 = var_134_6()
	end

	if var_134_8 then
		triggerButton(var_134_8.tr)
		self.guildShipEquipmentsPage:Refresh(self.shipVOsById[var_134_8.shipVO.id], self.shipVOsById[var_134_8.shipVO.id].user)
	end

	return
end

function DockyardScene:OnSwitch(arg_137_1, arg_137_2, arg_137_3)
	local function var_137_0()
		setActive(arg_137_1:Find("off"), not arg_137_2)
		setActive(arg_137_1:Find("on"), arg_137_2)

		return
	end

	onButton(self, arg_137_1, function()
		arg_137_2 = not arg_137_2

		if arg_137_3 then
			arg_137_3(arg_137_2)
		end

		var_137_0()

		return
	end, SFX_PANEL)
	var_137_0()

	return
end

function DockyardScene:OnShipSkinChanged(arg_140_1)
	local var_140_0, var_140_1 = ShipPhantom.UnpackMark(arg_140_1)

	if self.phantomGroupDic[var_140_0] and self.scrollPhantoms[self.phantomGroupDic[var_140_0]] and (self.phantomGroupDic[var_140_0] and self.scrollPhantoms[self.phantomGroupDic[var_140_0]]).shipCard.shipVO.id == var_140_0 then
		self:updatePhantomGroup(underscore.detect(self.filterBluePrint, function(arg_141_0)
			return arg_141_0.shipId == var_140_0
		end), self.phantomGroupDic[var_140_0])
	end

	return
end

function DockyardScene:onBackPressed()
	if self.destroyConfirmWindow:isShowing() then
		self.destroyConfirmWindow:Hide()

		return
	end

	if self.destroyPage:isShowing() then
		self.destroyPage:Hide()

		return
	end

	if self.settingPanel:isShowing() then
		self.settingPanel:Hide()

		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	self:back()

	return
end

function DockyardScene:updateShipStatusById(arg_143_1)
	local var_143_0 = self.cardItemDic[arg_143_1] and self.scrollItems[self.cardItemDic[arg_143_1]]

	if self.cardItemDic[arg_143_1] and self.scrollItems[self.cardItemDic[arg_143_1]] and var_143_0.shipVO.id == arg_143_1 then
		var_143_0:flush(self.selectedIds)

		if self.contextData.mode == DockyardScene.MODE_WORLD then
			var_143_0:updateWorld()
		end
	end

	return
end

function DockyardScene:checkDestroyGold(arg_144_1)
	local var_144_0 = 0
	local var_144_1 = 0

	for iter_144_0, iter_144_1 in ipairs(self.selectedIds) do
		local var_144_2, var_144_3 = self.shipVOsById[iter_144_1]:calReturnRes()

		var_144_0 = var_144_0 + var_144_2
		var_144_1 = var_144_1 + var_144_3
	end

	if arg_144_1 then
		local var_144_4, var_144_5 = arg_144_1:calReturnRes()

		var_144_0 = var_144_0 + var_144_4
		var_144_1 = var_144_1 + var_144_5
	end

	local var_144_6 = self.player:OilMax(var_144_1)

	if self.player:GoldMax(var_144_0) then
		return false, not var_144_6
	end

	return true, not var_144_6
end

function DockyardScene:selectShip(arg_145_1)
	local var_145_0 = false
	local var_145_1

	for iter_145_0, iter_145_1 in ipairs(self.selectedIds) do
		if iter_145_1 == arg_145_1.id then
			var_145_0 = true
			var_145_1 = iter_145_0

			break
		end
	end

	if var_145_0 or self.selectedMax == 1 and self:GetSelectCount() > 0 then
		local var_145_2 = defaultValue(var_145_1, 1)
		local var_145_3, var_145_4 = self.onCancelShip(self.shipVOsById[self.selectedIds[var_145_2]], function()
			if not self.exited then
				return
			end

			self:selectShip(arg_145_1)

			return
		end, self.selectedIds)

		if not var_145_3 then
			if var_145_4 then
				pg.TipsMgr.GetInstance():ShowTips(var_145_4)
			end

			return
		end

		table.remove(self.selectedIds, var_145_2)

		if self.selectedMax ~= 1 then
			self:updateBlackBlocks(self.shipVOsById[self.selectedIds[var_145_2]])
		end
	end

	if not var_145_0 then
		local var_145_5, var_145_6 = self.checkShip(arg_145_1, function()
			if self.exited then
				return
			end

			self:selectShip(arg_145_1)

			return
		end, self.selectedIds)

		if not var_145_5 then
			if var_145_6 then
				pg.TipsMgr.GetInstance():ShowTips(var_145_6)
			end

			return
		end

		if self.selectedMax == 0 or self:GetSelectCount() < self.selectedMax then
			table.insert(self.selectedIds, arg_145_1.id)

			if self.selectedMax ~= 1 then
				self:updateBlackBlocks(removeShip)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_dockyardScene_error_choiseRoleLess", self.selectedMax))

			return
		end
	end

	self:updateSelected()

	if self.contextData.mode == DockyardScene.MODE_DESTROY then
		self:updateDestroyRes()
	elseif self.contextData.mode == DockyardScene.MODE_MOD then
		self:updateModAttr()
	end

	self:UpdateGuildViewEquipmentsBtn()

	return
end

function DockyardScene:updateBlackBlocks(arg_148_1)
	if not self.contextData.useBlackBlock or not arg_148_1 then
		return
	end

	for iter_148_0, iter_148_1 in pairs(self.scrollItems) do
		self:updateItemBlackBlock(iter_148_1)
	end

	return
end

function DockyardScene:updateItemBlackBlock(arg_149_1)
	if self.contextData.useBlackBlock then
		if self.selectedMax == 1 then
			arg_149_1:updateBlackBlock(self.contextData.otherSelectedIds)
		else
			arg_149_1:updateBlackBlock(self.selectedIds)
		end
	else
		arg_149_1:updateBlackBlock()
	end

	return
end

function DockyardScene:unselecteAllShips()
	self.selectedIds = {}

	self:updateSelected()
	self:updateDestroyRes()

	return
end

function DockyardScene:updateSelected()
	if self.shipContainer then
		for iter_151_0, iter_151_1 in pairs(self.scrollItems) do
			if not iter_151_1.isClear then
				if iter_151_1.shipVO then
					local var_151_0 = iter_151_1.shipVO.id or nil
				end

				iter_151_1:updateSelected(iter_151_1.shipVO and underscore.any(self.selectedIds, function(arg_152_0)
					return var_151_0 == arg_152_0
				end))
			end
		end
	end

	if self.phantomContainer then
		for iter_151_2, iter_151_3 in pairs(self.scrollPhantoms) do
			if not iter_151_3.isClear then
				local var_151_1 = iter_151_3.shipCard.shipVO.id
				local var_151_2 = {}

				for iter_151_4 = 0, getGameset("technology_shadow_num")[1] do
					var_151_2[iter_151_4] = iter_151_4 == 0 and underscore.any(self.selectedIds, function(arg_153_0)
						return var_151_1 == arg_153_0
					end) or underscore.any(self.selectedMarks, function(arg_154_0)
						return arg_154_0 == ShipPhantom.PackMark(var_151_1, iter_151_4)
					end)
				end

				iter_151_3:updateSelected(var_151_2)
			end
		end
	end

	if self.selectedMax == 0 then
		setText(self.selectPanel:Find("bottom_info/bg_input/count"), self:GetSelectCount())
	else
		local var_151_3 = self:GetSelectCount()

		if self.contextData.mode ~= DockyardScene.MODE_DESTROY or self:GetSelectCount() == 0 then
			var_151_3 = setColorStr(var_151_3, COLOR_WHITE)
		elseif self.contextData.mode == DockyardScene.MODE_DESTROY then
			var_151_3 = setColorStr(var_151_3, (#self.selectedIds == 10 or nil) and (COLOR_RED or COLOR_GREEN))
		end

		setText(self.selectPanel:Find("bottom_info/bg_input/count"), var_151_3 .. "/" .. self.selectedMax)
	end

	if self:GetSelectCount() < self.selectedMin then
		setActive(self.selectPanel:Find("confirm_button/mask"), true)
	else
		setActive(self.selectPanel:Find("confirm_button/mask"), false)
	end

	if self.contextData.mode == DockyardScene.MODE_MOD then
		self:updateModAttr()
	end

	return
end

function DockyardScene:updateItemDetailType()
	for iter_155_0, iter_155_1 in pairs(self.scrollItems) do
		iter_155_1:updateDetail(self.itemDetailType)
	end

	self.shipLayout.anchoredPosition = self.shipLayout.anchoredPosition + Vector3(0, 0.001, 0)

	return
end

function DockyardScene:closeDestroyMode()
	setActive(self.awardTF, false)
	setActive(self.bottomTipsText, true)

	return
end

function DockyardScene:updateDestroyRes()
	if table.getCount(self.selectedIds) == 0 then
		self:closeDestroyMode()
	else
		setActive(self.awardTF, true)
		setActive(self.bottomTipsText, false)
	end

	local var_157_0, var_157_1, var_157_2 = ShipCalcHelper.CalcDestoryRes((_.map(self.selectedIds, function(arg_158_0)
		return self.shipVOsById[arg_158_0]
	end)))
	local var_157_3 = var_157_1 == 0

	if self.destroyResList then
		self.destroyResList:make(function(arg_159_0, arg_159_1, arg_159_2)
			if arg_159_0 == UIItemList.EventUpdate then
				local var_159_0 = ""
				local var_159_1 = 0

				if arg_159_1 == 0 then
					var_159_1 = var_157_0
					var_159_0 = "Props/gold"
				elseif arg_159_1 == 1 then
					if not var_157_3 then
						var_159_1 = var_157_1
						var_159_0 = "Props/oil"
					else
						var_159_1 = var_157_2[1].count
						var_159_0 = Item.getConfigData(var_157_2[1].id).icon
					end
				elseif arg_159_1 > 1 then
					local var_159_2

					if var_157_3 then
						var_159_2 = var_157_2[arg_159_1]

						if not var_157_2[arg_159_1] then
							var_159_2 = var_157_2[arg_159_1 - 1]
							var_159_1 = var_159_2.count
						end
					end

					var_159_0 = Item.getConfigData(var_159_2.id).icon
				end

				GetImageSpriteFromAtlasAsync(var_159_0, "", arg_159_2:Find("icon"))
				setText(arg_159_2:Find("Text"), "X" .. var_159_1)
			end

			return
		end)
		self.destroyResList:align((var_157_3 and 1 or 2) + #var_157_2)
	end

	if self.destroyPage and self.destroyPage:GetLoaded() and self.destroyPage:isShowing() then
		self.destroyPage:RefreshRes()
	end

	return
end

function DockyardScene:setModShip(arg_160_1)
	self.modShip = arg_160_1

	return
end

function DockyardScene:updateModAttr()
	if table.getCount(self.selectedIds) == 0 then
		self:closeModAttr()
	else
		setActive(self.modAttrsTF, true)
		setActive(self.bottomTipsText, false)
	end

	local var_161_1 = {}

	for iter_161_0, iter_161_1 in ipairs(self.selectedIds) do
		table.insert(var_161_1, self.shipVOsById[iter_161_1])
	end

	local var_161_2 = ShipModLayer.getModExpAdditions(self.modShip, var_161_1)

	for iter_161_2, iter_161_3 in pairs(ShipModAttr.ID_TO_ATTR) do
		if iter_161_2 ~= ShipModLayer.IGNORE_ID then
			local var_161_3 = self.modAttrContainer:Find("attr_" .. iter_161_2)

			setText(var_161_3:Find("value"), var_161_2[iter_161_3])
			setText(var_161_3:Find("name"), ShipModAttr.id2Name(iter_161_2))
		end
	end

	return
end

function DockyardScene:closeModAttr()
	setActive(self.modAttrsTF, false)
	setActive(self.bottomTipsText, true)

	return
end

function DockyardScene:removeShip(arg_163_1)
	for iter_163_0, iter_163_1 in ipairs(self.selectedIds) do
		if iter_163_1 == arg_163_1 then
			table.remove(self.selectedIds, iter_163_0)

			break
		end
	end

	for iter_163_2 = #self.shipVOs, 1, -1 do
		if self.shipVOs[iter_163_2].id == arg_163_1 then
			table.remove(self.shipVOs, iter_163_2)

			break
		end
	end

	self.shipVOsById[arg_163_1] = nil

	return
end

function DockyardScene:updateShipCount(arg_164_1)
	self.shipContainer:SetTotalCount(#self.shipVOs, defaultValue(arg_164_1, -1))
	setActive(self.listEmptyTF, #self.shipVOs <= 0)

	return
end

function DockyardScene:ClearShipsBlackBlock()
	if not self.shipVOsById then
		return
	end

	for iter_165_0, iter_165_1 in pairs(self.shipVOsById) do
		iter_165_1.blackBlock = false
	end

	return
end

function DockyardScene:willExit()
	self:closeDestroyMode()
	self:closeModAttr()
	self:ClearShipsBlackBlock()

	if self.guildShipEquipmentsPage then
		self.guildShipEquipmentsPage:Destroy()
	end

	if self.settingPanel then
		self.settingPanel:Destroy()
	end

	if self.destroyPage then
		self.destroyPage:Destroy()
	end

	if self.destroyConfirmWindow then
		self.destroyConfirmWindow:Destroy()
	end

	if self.contextData.mode == DockyardScene.MODE_MOD then
		-- block empty
	elseif not self.contextData.sortData then
		if _G[self.contextData.preView] then
			_G[self.contextData.preView].sortIndex = self.sortIndex
			_G[self.contextData.preView].selectAsc = self.selectAsc
			_G[self.contextData.preView].typeIndex = self.typeIndex
			_G[self.contextData.preView].campIndex = self.campIndex
			_G[self.contextData.preView].rarityIndex = self.rarityIndex
			_G[self.contextData.preView].extraIndex = self.extraIndex
			_G[self.contextData.preView].commonTag = self.commonTag
		else
			DockyardScene.sortIndex = self.sortIndex
			DockyardScene.selectAsc = self.selectAsc
			DockyardScene.typeIndex = self.typeIndex
			DockyardScene.campIndex = self.campIndex
			DockyardScene.rarityIndex = self.rarityIndex
			DockyardScene.extraIndex = self.extraIndex
			DockyardScene.commonTag = self.commonTag
		end
	end

	if self.shipContainer then
		self.shipContainer.enabled = false

		for iter_166_0, iter_166_1 in pairs(self.scrollItems) do
			iter_166_1:clear()
			GetOrAddComponent(iter_166_1.go, "UILongPressTrigger").onLongPressed:RemoveAllListeners()
		end
	end

	if self.phantomContainer then
		self.phantomContainer.enabled = false

		for iter_166_2, iter_166_3 in pairs(self.scrollPhantoms) do
			iter_166_3:clear()
		end
	end

	if LeanTween.isTweening(go(self.energyDescTF)) then
		setActive(self.energyDescTF, false)
		LeanTween.cancel(go(self.energyDescTF))
	end

	self:cancelAnimating()

	if self.isRemouldOrUpgradeMode then
		local var_166_0 = getProxy(SettingsProxy)

		var_166_0:SetDockYardLockBtnFlag(self.isFilterLockForMod)
		var_166_0:SetDockYardLevelBtnFlag(self.isFilterLevelForMod)
	end

	if self.bulinTip then
		self.bulinTip:Destroy()

		self.bulinTip = nil
	end

	if self.searchBar then
		self.searchBar:Dispose()

		self.searchBar = nil
	end

	self:UnOverlayPanel(self.blurPanel, self._tf)

	if self:isLayer() then
		self:UnOverlayPanel(self._tf)
	end

	return
end

function DockyardScene:uiStartAnimating()
	local var_167_0 = self.topPanel:Find("back")

	if isActive(self.selectPanel) then
		shiftPanel(self.selectPanel, nil, 0, 0.3, 0, true, true)
	end

	return
end

function DockyardScene:uiExitAnimating()
	if self.contextData.mode == DockyardScene.MODE_OVERVIEW then
		-- block empty
	else
		shiftPanel(self.selectPanel, nil, -1 * self.selectPanel.rect.height, 0.3, 0, true, true)
	end

	return
end

function DockyardScene:back()
	if self.exited then
		return
	end

	self:closeView()

	return
end

function DockyardScene:cancelAnimating()
	if LeanTween.isTweening(go(self.topPanel)) then
		LeanTween.cancel(go(self.topPanel))
	end

	if LeanTween.isTweening(go(self.selectPanel)) then
		LeanTween.cancel(go(self.selectPanel))
	end

	if self.tweens then
		cancelTweens(self.tweens)
	end

	return
end

function DockyardScene:quickExitFunc()
	seriesAsync({
		function(arg_172_0)
			if self.contextData.onQuickHome then
				self.contextData.onQuickHome(arg_172_0)
			else
				arg_172_0()
			end

			return
		end,
		function(arg_173_0)
			self:emit(DockyardScene.ON_HOME)

			return
		end
	})

	return
end

function DockyardScene:displayDestroyPanel()
	self.destroyPage:ExecuteAction("Show")
	self.destroyPage:ActionInvoke("Refresh", self.selectedIds, self.shipVOsById)

	return
end

function DockyardScene:closeDestroyPanel()
	if self.destroyPage:isShowing() then
		self.destroyPage:Hide()
	end

	return
end

function DockyardScene:checkDestroyShips(arg_176_1, arg_176_2)
	local var_176_0 = {}

	if PlayerPrefs.GetInt("RetireProtect", 1) == 0 then
		local var_176_1 = {}

		for iter_176_0, iter_176_1 in pairs(arg_176_1) do
			local var_176_2 = 0

			for iter_176_2, iter_176_3 in pairs(arg_176_1) do
				if iter_176_3:getGroupId() == iter_176_1:getGroupId() then
					var_176_2 = var_176_2 + 1
				end
			end

			if #getProxy(BayProxy):findShipsByGroup(iter_176_1:getGroupId()) == var_176_2 then
				local var_176_3 = false

				for iter_176_4, iter_176_5 in pairs(var_176_1) do
					if iter_176_5:getGroupId() == iter_176_1:getGroupId() then
						var_176_3 = true

						break
					end
				end

				if not var_176_3 then
					table.insert(var_176_1, iter_176_1)
				end
			end
		end

		if #var_176_1 > 0 then
			table.insert(var_176_0, function(arg_177_0)
				self.destroyConfirmWindow:ExecuteAction("ShowOneShipProtect", var_176_1, arg_177_0)

				return
			end)
		end
	end

	local var_176_4, var_176_5 = ShipCalcHelper.GetEliteAndHightLevelShips(arg_176_1)

	if #var_176_4 > 0 or #var_176_5 > 0 then
		table.insert(var_176_0, function(arg_178_0)
			self.destroyConfirmWindow:ExecuteAction("Show", var_176_4, var_176_5, (self.contextData.mode == DockyardScene.MODE_DESTROY or nil) and ({
				ShipCalcHelper.CalcDestoryRes(arg_176_1)
			})[4], arg_178_0)

			return
		end)
	end

	local var_176_6 = underscore.filter(arg_176_1, function(arg_179_0)
		return arg_179_0:getFlag("inElite")
	end)

	if #var_176_6 > 0 then
		table.insert(var_176_0, function(arg_180_0)
			self.destroyConfirmWindow:ExecuteAction("ShowEliteTag", var_176_6, arg_180_0)

			return
		end)
	end

	seriesAsync(var_176_0, arg_176_2)

	return
end

return DockyardScene

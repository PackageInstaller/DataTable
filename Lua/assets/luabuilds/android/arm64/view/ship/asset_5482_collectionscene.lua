local CollectionScene = class("CollectionScene", import("..base.BaseUI"))

CollectionScene.SHOW_DETAIL = "event show detail"
CollectionScene.GET_AWARD = "event get award"
CollectionScene.ACTIVITY_OP = "event activity op"
CollectionScene.BEGIN_STAGE = "event begin state"
CollectionScene.ON_INDEX = "event on index"
CollectionScene.UPDATE_RED_POINT = "CollectionScene:UPDATE_RED_POINT"
CollectionScene.ShipOrderAsc = false
CollectionScene.ShipIndex = {
	typeIndex = ShipIndexConst.TypeAll,
	campIndex = ShipIndexConst.CampAll,
	rarityIndex = ShipIndexConst.RarityAll,
	collExtraIndex = ShipIndexConst.CollExtraAll
}
CollectionScene.ShipIndexData = {
	customPanels = {
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
		collExtraIndex = {
			blueSeleted = true,
			mode = CustomIndexLayer.Mode.AND,
			options = ShipIndexConst.CollExtraIndexs,
			names = ShipIndexConst.CollExtraNames
		}
	},
	groupList = {
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
				"collExtraIndex"
			}
		}
	}
}
CollectionScene.SHIPCOLLECTION_INDEX = 1
CollectionScene.MANGA_INDEX = 4
CollectionScene.GALLERY_INDEX = 5
CollectionScene.MUSIC_INDEX = 6

function CollectionScene:isDefaultStatus()
	return CollectionScene.ShipIndex.typeIndex == ShipIndexConst.TypeAll and (CollectionScene.ShipIndex.campIndex == ShipIndexConst.CampAll or self.contextData.toggle == 1 and self.contextData.cardToggle == 2) and CollectionScene.ShipIndex.rarityIndex == ShipIndexConst.RarityAll and CollectionScene.ShipIndex.collExtraIndex == ShipIndexConst.CollExtraAll
end

function CollectionScene:getUIName()
	return "CollectionUI"
end

function CollectionScene:setShipGroups(arg_3_1)
	self.shipGroups = arg_3_1

	return
end

function CollectionScene:setAwards(arg_4_1)
	self.awards = arg_4_1

	return
end

function CollectionScene:setCollectionRate(arg_5_1, arg_5_2, arg_5_3)
	self.rate = arg_5_1
	self.count = arg_5_2
	self.totalCount = arg_5_3

	return
end

function CollectionScene:setLinkCollectionCount(arg_6_1)
	self.linkCount = arg_6_1

	return
end

function CollectionScene:setPlayer(arg_7_1)
	self.player = arg_7_1

	return
end

function CollectionScene:setProposeList(arg_8_1)
	self.proposeList = arg_8_1

	return
end

function CollectionScene:init()
	self:initEvents()

	self.blurPanel = self._tf:Find("blur_panel")
	self.top = self._tf:Find("blur_panel/adapt/top")
	self.leftPanel = self._tf:Find("blur_panel/adapt/left_length")
	self.backBtn = findTF(self.top, "back_btn")
	self.contextData.toggle = self.contextData.toggle or 2
	self.toggles = {
		self.leftPanel:Find("frame/tagRoot/card"),
		self.leftPanel:Find("frame/tagRoot/display"),
		self.leftPanel:Find("frame/tagRoot/trans"),
		self.leftPanel:Find("frame/tagRoot/manga"),
		self.leftPanel:Find("frame/tagRoot/gallery"),
		self.leftPanel:Find("frame/tagRoot/music")
	}
	self.toggleUpdates = {
		"initCardPanel",
		"initDisplayPanel",
		"initCardPanel",
		"initMangaPanel",
		"initGalleryPanel",
		"initMusicPanel"
	}
	self.cardList = self._tf:Find("main/list_card/scroll"):GetComponent("LScrollRect")

	function self.cardList.onInitItem(arg_10_0)
		self:onInitCard(arg_10_0)

		return
	end

	function self.cardList.onUpdateItem(arg_11_0, arg_11_1)
		self:onUpdateCard(arg_11_0, arg_11_1)

		return
	end

	function self.cardList.onReturnItem(arg_12_0, arg_12_1)
		self:onReturnCard(arg_12_0, arg_12_1)

		return
	end

	self.cardItems = {}
	self.cardContent = tf(self.cardList):Find("ships")
	self.contextData.cardToggle = self.contextData.cardToggle or 1
	self.cardToggleGroup = self._tf:Find("main/list_card/types")
	self.cardToggles = {
		self.cardToggleGroup:Find("char"),
		self.cardToggleGroup:Find("link"),
		self.cardToggleGroup:Find("blueprint"),
		self.cardToggleGroup:Find("meta")
	}
	self.cardList.decelerationRate = 0.07
	self.bonusPanel = self._tf:Find("bonus_panel")
	self.charTpl = self:getTpl("chartpl")
	self.tip = self.toggles[2]:Find("tip")
	self.favoriteVOs = {}

	for iter_9_0, iter_9_1 in ipairs(pg.storeup_data_template.all) do
		table.insert(self.favoriteVOs, (Favorite.New({
			id = iter_9_0
		})))
	end

	self.memoryGroups = _.map(pg.memory_group.all, function(arg_13_0)
		return pg.memory_group[arg_13_0]
	end)
	self.memories = nil
	self.memoryList = self._tf:Find("main/list_memory"):GetComponent("LScrollRect")

	function self.memoryList.onInitItem(arg_14_0)
		self:onInitMemory(arg_14_0)

		return
	end

	function self.memoryList.onUpdateItem(arg_15_0, arg_15_1)
		self:onUpdateMemory(arg_15_0, arg_15_1)

		return
	end

	function self.memoryList.onReturnItem(arg_16_0, arg_16_1)
		self:onReturnMemory(arg_16_0, arg_16_1)

		return
	end

	self.memoryViewport = self._tf:Find("main/list_memory/viewport")
	self.memoriesGrid = self._tf:Find("main/list_memory/viewport/memories"):GetComponent(typeof(GridLayoutGroup))
	self.memoryItems = {}
	self.memoryMask = self._tf:Find("blur_panel/story_mask")

	setActive(tf(self.memoryList):Find("memory"), false)
	setActive(self.memoryMask, false)

	self.memoryTogGroup = self.top:Find("memory")

	setActive(self.memoryTogGroup, false)

	self.memoryToggles = {
		self.top:Find("memory/0"),
		self.top:Find("memory/1"),
		self.top:Find("memory/2"),
		self.top:Find("memory/3")
	}
	self.memoryFilterIndex = {
		true,
		true,
		true
	}
	self.galleryPanelContainer = self._tf:Find("main/GalleryContainer")
	self.musicPanelContainer = self._tf:Find("main/MusicContainer")
	self.mangaPanelContainer = self._tf:Find("main/MangaContainer")

	self:initIndexPanel()

	return
end

function CollectionScene:didEnter()
	onButton(self, self.backBtn, function()
		self.contextData.cardScrollValue = 0

		self:emit(CollectionScene.ON_BACK)

		return
	end, SFX_CANCEL)

	self.helpBtn = self.leftPanel:Find("help_btn")

	onButton(self, self.helpBtn, function()
		if self.contextData.toggle == CollectionScene.MUSIC_INDEX then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = pg.gametip.NewMusic_help.tip
			})
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = pg.gametip.collection_help.tip
			})
		end

		return
	end, SFX_PANEL)

	local var_17_0 = self.top:Find("stamp")

	setActive(var_17_0, getProxy(TaskProxy):mingshiTouchFlagEnabled())
	onButton(self, var_17_0, function()
		getProxy(TaskProxy):dealMingshiTouchFlag(8)

		return
	end, SFX_CONFIRM)

	for iter_17_0, iter_17_1 in ipairs(self.toggles) do
		if PLATFORM_CODE == PLATFORM_CH and (iter_17_0 == 1 or iter_17_0 == 3) and LOCK_COLLECTION then
			setActive(iter_17_1, false)
		else
			onToggle(self, iter_17_1, function(arg_21_0)
				if arg_21_0 then
					if self.contextData.toggle ~= iter_17_0 then
						if self.contextData.toggle == CollectionScene.SHIPCOLLECTION_INDEX then
							setActive(self.helpBtn, false)

							if self.bulinTip then
								self.bulinTip.buffer:Hide()
							end

							if self.contextData.cardToggle == 1 then
								self.contextData.cardScrollValue = self.cardList.value
							end
						end

						self.contextData.toggle = iter_17_0

						if self.toggleUpdates[iter_17_0] then
							self[self.toggleUpdates[iter_17_0]](self)
							self:calFavoriteRate()
						end
					end

					if iter_17_0 == CollectionScene.SHIPCOLLECTION_INDEX then
						setActive(self.helpBtn, true)

						local var_21_0 = getProxy(SettingsProxy)

						if not var_21_0:IsShowCollectionHelp() then
							triggerButton(self.helpBtn)
							var_21_0:SetCollectionHelpFlag(true)
						end

						if self.bulinTip then
							self.bulinTip.buffer:Show()
						else
							self.bulinTip = AprilFoolBulinSubView.ShowAprilFoolBulin(self, self._tf:Find("main"))
						end
					end

					if iter_17_0 ~= CollectionScene.MUSIC_INDEX then
						if self.musicView and self.musicView:CheckState(BaseSubView.STATES.INITED) then
							self.musicView:tryPauseMusic()
							self.musicView:closeAlbumListPanel()
						end

						pg.BgmMgr.GetInstance():ContinuePlay()
					elseif iter_17_0 == CollectionScene.MUSIC_INDEX then
						pg.BgmMgr.GetInstance():StopPlay()

						if self.musicView and self.musicView:CheckState(BaseSubView.STATES.INITED) then
							self.musicView:tryPlayMusic()
						end
					end
				end

				return
			end, SFX_UI_TAG)
		end
	end

	for iter_17_2, iter_17_3 in ipairs(self.memoryToggles) do
		onToggle(self, iter_17_3, function(arg_22_0)
			if arg_22_0 then
				if iter_17_2 == 1 then
					self.memoryFilterIndex = {
						true,
						true,
						true
					}
				else
					for iter_22_0 in ipairs(self.memoryFilterIndex) do
						self.memoryFilterIndex[iter_22_0] = iter_17_2 - 1 == iter_22_0
					end
				end

				self:memoryFilter()
			end

			return
		end, SFX_UI_TAG)
	end

	self.contextData.toggle = -1

	triggerToggle(self.toggles[self.contextData.toggle], true)

	if self.contextData.memoryGroup and pg.memory_group[self.contextData.memoryGroup] then
		self:showSubMemories(pg.memory_group[self.contextData.memoryGroup])
	else
		triggerToggle(self.memoryToggles[1], true)
	end

	for iter_17_4, iter_17_5 in ipairs(self.cardToggles) do
		triggerToggle(iter_17_5, self.contextData.cardToggle == iter_17_4)
		onToggle(self, iter_17_5, function(arg_23_0)
			if arg_23_0 and self.contextData.cardToggle ~= iter_17_4 then
				if self.contextData.cardToggle == 1 then
					self.contextData.cardScrollValue = self.cardList.value
				end

				self.contextData.cardToggle = iter_17_4

				self:initCardPanel()
				self:calFavoriteRate()
			end

			return
		end)
	end

	self:calFavoriteRate()
	self:OverlayPanel(self.blurPanel)
	onButton(self, self.bonusPanel, function()
		self:closeBonus()

		return
	end, SFX_PANEL)

	return
end

function CollectionScene:updateCollectNotices(arg_25_1)
	setActive(self.tip, arg_25_1)
	setActive(self.toggles[CollectionScene.GALLERY_INDEX]:Find("tip"), getProxy(AppreciateProxy):isGalleryHaveNewRes())
	setActive(self.toggles[CollectionScene.MUSIC_INDEX]:Find("tip"), getProxy(AppreciateProxy):isMusicHaveNewRes())
	setActive(self.toggles[CollectionScene.MANGA_INDEX]:Find("tip"), getProxy(AppreciateProxy):isMangaHaveNewRes())

	return
end

function CollectionScene:calFavoriteRate()
	local var_26_0 = self.contextData.toggle == 1 and self.contextData.cardToggle == 2

	setActive(self.top:Find("total/char"), not (self.contextData.toggle == 1 and self.contextData.cardToggle == 2))
	setActive(self.top:Find("total/link"), var_26_0)
	setText(self.top:Find("total/char/rate/Text"), self.rate * 100 .. "%")
	setText(self.top:Find("total/char/count/Text"), self.count .. "/" .. self.totalCount)
	setText(self.top:Find("total/link/count/Text"), self.linkCount)

	return
end

function CollectionScene:initCardPanel()
	GetSpriteFromAtlasAsync("ui/share/index_atlas", self:isDefaultStatus() and "shaixuan_off" or "shaixuan_on", function(arg_28_0)
		setImageSprite(self.indexBtn, arg_28_0, true)

		return
	end)

	if self.contextData.toggle == 1 then
		setActive(self.cardToggleGroup, true)
		self:cardFilter()
	elseif self.contextData.toggle == 3 then
		setActive(self.cardToggleGroup, false)
		self:transFilter()
	end

	table.sort(self.codeShips, function(arg_29_0, arg_29_1)
		return arg_29_0.index_id < arg_29_1.index_id
	end)
	self.cardList:SetTotalCount(#self.codeShips, self.contextData.cardScrollValue or 0)

	return
end

function CollectionScene:initIndexPanel()
	self.indexBtn = self.top:Find("index_button")

	onButton(self, self.indexBtn, function()
		local var_31_0 = Clone(CollectionScene.ShipIndexData)

		if self.contextData.toggle == 1 and self.contextData.cardToggle == 2 then
			var_31_0.customPanels.campIndex = nil
			var_31_0.groupList[2] = nil
		end

		var_31_0.indexDatas = Clone(CollectionScene.ShipIndex)

		function var_31_0:callback()
			CollectionScene.ShipIndex.typeIndex = self.typeIndex

			if self.campIndex then
				CollectionScene.ShipIndex.campIndex = self.campIndex
			end

			CollectionScene.ShipIndex.rarityIndex = self.rarityIndex
			CollectionScene.ShipIndex.collExtraIndex = self.collExtraIndex

			self:initCardPanel()

			return
		end

		self:emit(CollectionScene.ON_INDEX, var_31_0)

		return
	end, SFX_PANEL)

	return
end

function CollectionScene:onInitCard(arg_33_1)
	if self.exited then
		return
	end

	local var_33_0 = CollectionShipCard.New(arg_33_1)

	onButton(self, var_33_0.go, function()
		if not self.isClicked then
			self.isClicked = true

			LeanTween.delayedCall(0.2, System.Action(function()
				self.isClicked = false

				if not var_33_0:getIsInited() then
					return
				end

				if var_33_0.state == ShipGroup.STATE_UNLOCK then
					self.contextData.cardScrollValue = self.cardList.value

					self:emit(CollectionScene.SHOW_DETAIL, var_33_0.showTrans, var_33_0.shipGroup.id)
				elseif var_33_0.state == ShipGroup.STATE_NOTGET then
					if var_33_0.showTrans == true and var_33_0.shipGroup.trans == true then
						return
					end

					if var_33_0.config then
						self:showObtain(var_33_0.config.description, var_33_0.shipGroup:getShipConfigId())
					end
				end

				return
			end))
		end

		return
	end, SOUND_BACK)

	self.cardItems[arg_33_1] = var_33_0

	return
end

function CollectionScene:showObtain(arg_36_1, arg_36_2)
	local var_36_0 = {
		type = MSGBOX_TYPE_OBTAIN,
		shipId = arg_36_2,
		list = arg_36_1,
		mediatorName = CollectionMediator.__cname
	}

	if PLATFORM_CODE == PLATFORM_CH and HXSet.isHx() then
		var_36_0.unknown_small = true
	end

	self.contextData.cardScrollValue = self.cardList.value

	pg.MsgboxMgr.GetInstance():ShowMsgBox(var_36_0)

	return
end

function CollectionScene:skipIn(arg_37_1, arg_37_2)
	self.contextData.displayGroupId = arg_37_2

	triggerToggle(self.toggles[arg_37_1], true)

	return
end

function CollectionScene:onUpdateCard(arg_38_1, arg_38_2)
	if self.exited then
		return
	end

	local var_38_0 = self.cardItems[arg_38_2]

	if not self.cardItems[arg_38_2] then
		self:onInitCard(arg_38_2)

		var_38_0 = self.cardItems[arg_38_2]
	end

	local var_38_1 = self.codeShips[arg_38_1 + 1]

	if not self.codeShips[arg_38_1 + 1] then
		return
	end

	var_38_0:update(var_38_1.code, var_38_1.group, var_38_1.showTrans, (var_38_1.group or nil) and self.proposeList[var_38_1.group.id], var_38_1.id)

	return
end

function CollectionScene:onReturnCard(arg_39_1, arg_39_2)
	if self.exited then
		return
	end

	if self.cardItems[arg_39_2] then
		self.cardItems[arg_39_2]:clear()
	end

	return
end

function CollectionScene:cardFilter()
	self.codeShips = {}

	local var_40_0 = _.filter(pg.ship_data_group.all, function(arg_41_0)
		return pg.ship_data_group[arg_41_0].handbook_type == self.contextData.cardToggle - 1
	end)

	table.sort(var_40_0)

	for iter_40_0, iter_40_1 in ipairs(var_40_0) do
		local var_40_1 = pg.ship_data_group[iter_40_1]
		local var_40_2 = self.shipGroups[pg.ship_data_group[iter_40_1].group_type] or ShipGroup.New({
			id = var_40_1.group_type
		})

		if ShipIndexConst.filterByType(var_40_2, CollectionScene.ShipIndex.typeIndex) and (self.contextData.cardToggle == 2 or ShipIndexConst.filterByCamp(var_40_2, CollectionScene.ShipIndex.campIndex)) and self.contextData.cardToggle == 4 == Nation.IsMeta(ShipGroup.getDefaultShipConfig(var_40_1.group_type).nationality) and ShipIndexConst.filterByRarity(var_40_2, CollectionScene.ShipIndex.rarityIndex) and ShipIndexConst.filterByCollExtra(var_40_2, CollectionScene.ShipIndex.collExtraIndex) then
			self.codeShips[#self.codeShips + 1] = {
				showTrans = false,
				id = iter_40_1,
				code = iter_40_1 - (self.contextData.cardToggle - 1) * 16,
				group = self.shipGroups[var_40_1.group_type],
				index_id = var_40_1.index_id
			}
		end
	end

	return
end

function CollectionScene:transFilter()
	self.codeShips = {}

	local var_42_0 = _.filter(pg.ship_data_group.all, function(arg_43_0)
		return pg.ship_data_group[arg_43_0].handbook_type == 0
	end)

	table.sort(var_42_0)

	for iter_42_0, iter_42_1 in ipairs(var_42_0) do
		local var_42_1 = pg.ship_data_group[iter_42_1]

		if pg.ship_data_trans[pg.ship_data_group[iter_42_1].group_type] then
			local var_42_2 = self.shipGroups[var_42_1.group_type] or ShipGroup.New({
				remoulded = true,
				id = var_42_1.group_type
			})

			if ShipIndexConst.filterByType(var_42_2, CollectionScene.ShipIndex.typeIndex) and ShipIndexConst.filterByCamp(var_42_2, CollectionScene.ShipIndex.campIndex) and ShipIndexConst.filterByRarity(var_42_2, CollectionScene.ShipIndex.rarityIndex) and ShipIndexConst.filterByCollExtra(var_42_2, CollectionScene.ShipIndex.collExtraIndex) then
				self.codeShips[#self.codeShips + 1] = {
					showTrans = true,
					id = iter_42_1,
					code = 3000 + iter_42_1,
					group = var_42_2.trans and var_42_2 or nil,
					index_id = var_42_1.index_id
				}
			end
		end
	end

	return
end

function CollectionScene:sortDisplay()
	table.sort(self.favoriteVOs, function(arg_45_0, arg_45_1)
		local var_45_0 = arg_45_0:getState(self.shipGroups, self.awards)
		local var_45_1 = arg_45_1:getState(self.shipGroups, self.awards)

		if var_45_0 == var_45_1 then
			return arg_45_0.id < arg_45_1.id
		else
			return var_45_0 < var_45_1
		end

		return
	end)

	local var_44_0 = 0

	for iter_44_0, iter_44_1 in ipairs(self.favoriteVOs) do
		if iter_44_1:containShipGroup(self.contextData.displayGroupId) then
			var_44_0 = iter_44_0

			break
		end
	end

	self.displayRect:SetTotalCount(#self.favoriteVOs, self.displayRect:HeadIndexToValue(var_44_0 - 1))

	return
end

function CollectionScene:initDisplayPanel()
	if not self.isInitDisplay then
		self.isInitDisplay = true
		self.displayRect = self._tf:Find("main/list_display"):GetComponent("LScrollRect")
		self.displayRect.decelerationRate = 0.07

		function self.displayRect.onInitItem(arg_47_0)
			self:initFavoriteCard(arg_47_0)

			return
		end

		function self.displayRect.onUpdateItem(arg_48_0, arg_48_1)
			self:updateFavoriteCard(arg_48_0, arg_48_1)

			return
		end

		self.favoriteCards = {}
	end

	self:sortDisplay()

	return
end

function CollectionScene:initFavoriteCard(arg_49_1)
	if self.exited then
		return
	end

	local var_49_0 = FavoriteCard.New(arg_49_1, self.charTpl)

	onButton(self, var_49_0.awardTF, function()
		if var_49_0.state == Favorite.STATE_AWARD then
			self:emit(CollectionScene.GET_AWARD, var_49_0.favoriteVO.id, var_49_0.favoriteVO:getNextAwardIndex(var_49_0.awards))
		elseif var_49_0.state == Favorite.STATE_LOCK then
			pg.TipsMgr.GetInstance():ShowTips(i18n("collection_lock"))
		elseif var_49_0.state == Favorite.STATE_FETCHED then
			pg.TipsMgr.GetInstance():ShowTips(i18n("collection_fetched"))
		elseif var_49_0.state == Favorite.STATE_STATE_WAIT then
			pg.TipsMgr.GetInstance():ShowTips(i18n("collection_nostar"))
		end

		return
	end, SFX_PANEL)
	onButton(self, var_49_0.box, function()
		self:openBonus(var_49_0.favoriteVO)

		return
	end, SFX_PANEL)

	self.favoriteCards[arg_49_1] = var_49_0

	return
end

function CollectionScene:updateFavoriteCard(arg_52_1, arg_52_2)
	if self.exited then
		return
	end

	if not self.favoriteCards[arg_52_2] then
		self:initFavoriteCard(arg_52_2)
	end

	self.favoriteCards[arg_52_2]:update(self.favoriteVOs[arg_52_1 + 1], self.shipGroups, self.awards)

	return
end

function CollectionScene:openBonus(arg_53_1)
	if not self.isInitBound then
		self.isInitBound = true
		self.boundName = findTF(self.bonusPanel, "frame/name/Text"):GetComponent(typeof(Text))
		self.progressSlider = findTF(self.bonusPanel, "frame/process"):GetComponent(typeof(Slider))
	end

	pg.UIMgr.GetInstance():BlurPanel(self.bonusPanel)
	setActive(self.bonusPanel, true)

	self.boundName.text = arg_53_1:getConfig("name")

	local var_53_0 = arg_53_1:getConfig("award_display")
	local var_53_1 = arg_53_1:getConfig("level")

	for iter_53_0, iter_53_1 in ipairs(var_53_1) do
		local var_53_2 = var_53_0[iter_53_0]
		local var_53_3 = findTF(self.bonusPanel, "frame/awards/award" .. iter_53_0)

		setText(findTF(var_53_3, "process"), iter_53_1)

		local var_53_4 = arg_53_1:getAwardState(self.shipGroups, self.awards, iter_53_0)

		setActive(findTF(var_53_3, "item_tpl/unfinish"), var_53_4 == Favorite.STATE_WAIT)
		setActive(findTF(var_53_3, "item_tpl/get"), var_53_4 == Favorite.STATE_AWARD)
		setActive(findTF(var_53_3, "item_tpl/got"), var_53_4 == Favorite.STATE_FETCHED)
		setActive(findTF(var_53_3, "item_tpl/lock"), var_53_4 == Favorite.STATE_LOCK)
		setActive(findTF(var_53_3, "item_tpl/icon_bg"), var_53_4 ~= Favorite.STATE_LOCK)
		setActive(findTF(var_53_3, "item_tpl/bg"), var_53_4 ~= Favorite.STATE_LOCK)

		if var_53_2 then
			local var_53_5 = {
				count = 0,
				type = var_53_2[1],
				id = var_53_2[2]
			}

			updateDrop(findTF(var_53_3, "item_tpl"), var_53_5)

			var_53_5.count = var_53_2[3]

			onButton(self, var_53_3, function()
				self:emit(CollectionScene.ON_DROP, var_53_5)

				return
			end, SFX_PANEL)
		else
			GetOrAddComponent(var_53_3, typeof(Button)).onClick:RemoveAllListeners()
		end
	end

	self.progressSlider.value = arg_53_1:getStarCount(self.shipGroups) / var_53_1[#var_53_1]

	return
end

function CollectionScene:closeBonus()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.bonusPanel, self._tf)
	setActive(self.bonusPanel, false)

	return
end

function CollectionScene:showSubMemories(arg_56_1)
	self.contextData.memoryGroup = arg_56_1.id
	self.memories = _.map(arg_56_1.memories, function(arg_57_0)
		return pg.memory_template[arg_57_0]
	end)

	for iter_56_0 in ipairs(self.memories) do
		self.memories[iter_56_0].index = iter_56_0
	end

	self.memoryList:SetTotalCount(#self.memories, 0)
	setActive(self.top:Find("memory"), false)

	return
end

local var_0_1 = 3

function CollectionScene:return2MemoryGroup()
	self.contextData.memoryGroup = nil
	self.memories = nil

	local var_58_0 = 0

	if self.contextData.memoryGroup then
		local var_58_1 = 0

		for iter_58_0, iter_58_1 in ipairs(self.memoryGroups) do
			if iter_58_1.id == self.contextData.memoryGroup then
				var_58_1 = iter_58_0

				break
			end
		end

		if var_58_1 >= 0 then
			var_58_0 = ((self.memoriesGrid.cellSize.y + self.memoriesGrid.spacing.y) * math.floor((var_58_1 - 1) / var_0_1) + self.memoryList.paddingFront) / ((self.memoriesGrid.cellSize.y + self.memoriesGrid.spacing.y) * math.ceil(#self.memoryGroups / var_0_1) - self.memoryViewport.rect.height)
			var_58_0 = Mathf.Clamp01(var_58_0)
		end
	end

	self.memoryList:SetTotalCount(#self.memoryGroups, var_58_0)
	setActive(self.top:Find("memory"), true)

	return
end

function CollectionScene:initMemoryPanel()
	local var_59_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.QIXI_ACTIVITY_ID)

	if var_59_0 and not var_59_0:isEnd() then
		local var_59_1 = _.flatten((var_59_0:getConfig("config_data")))
		local var_59_2 = getProxy(TaskProxy):getTaskById(var_59_1[#var_59_1])

		if var_59_2 and not var_59_2:isFinish() then
			pg.NewStoryMgr.GetInstance():Play("HOSHO8", function()
				self:emit(CollectionScene.ACTIVITY_OP, {
					cmd = 2,
					activity_id = var_59_0.id
				})

				return
			end, true)
		end
	end

	self:memoryFilter()

	return
end

function CollectionScene:onInitMemory(arg_61_1)
	if self.exited then
		return
	end

	local var_61_0 = MemoryCard.New(arg_61_1)

	onButton(self, var_61_0.go, function()
		if var_61_0.info then
			if var_61_0.isGroup then
				self:showSubMemories(var_61_0.info)
			elseif var_61_0.info.is_open ~= 1 then
				if pg.NewStoryMgr.GetInstance():IsPlayed(var_61_0.info.unlock_pre, true) then
					self:playMemory(var_61_0.info)
				end
			end
		end

		return
	end, SOUND_BACK)

	self.memoryItems[arg_61_1] = var_61_0

	return
end

function CollectionScene:onUpdateMemory(arg_63_1, arg_63_2)
	if self.exited then
		return
	end

	local var_63_0 = self.memoryItems[arg_63_2]

	if not self.memoryItems[arg_63_2] then
		self:onInitMemory(arg_63_2)

		var_63_0 = self.memoryItems[arg_63_2]
	end

	if self.memories then
		var_63_0:update(false, self.memories[arg_63_1 + 1])
	else
		var_63_0:update(true, self.memoryGroups[arg_63_1 + 1])
	end

	_.any({
		var_63_0.lock,
		var_63_0.normal,
		var_63_0.group
	}, function(arg_64_0)
		local var_64_0 = isActive(arg_64_0)

		if var_64_0 then
			var_63_0.go:GetComponent(typeof(Button)).targetGraphic = arg_64_0:GetComponent(typeof(Image))
		end

		return var_64_0
	end)

	return
end

function CollectionScene:onReturnMemory(arg_65_1, arg_65_2)
	if self.exited then
		return
	end

	if self.memoryItems[arg_65_2] then
		self.memoryItems[arg_65_2]:clear()
	end

	return
end

function CollectionScene:playMemory(arg_66_1)
	if arg_66_1.type == 1 then
		local var_66_0 = findTF(self.memoryMask, "pic")

		if string.len(arg_66_1.mask) > 0 then
			setActive(var_66_0, true)

			var_66_0:GetComponent(typeof(Image)).sprite = LoadSprite(arg_66_1.mask)
		else
			setActive(var_66_0, false)
		end

		setActive(self.memoryMask, true)
		pg.NewStoryMgr.GetInstance():Play(arg_66_1.story, function()
			setActive(self.memoryMask, false)

			return
		end, true)
	elseif arg_66_1.type == 2 then
		self:emit(CollectionScene.BEGIN_STAGE, {
			memory = true,
			system = SYSTEM_PERFORM,
			stageId = pg.NewStoryMgr.GetInstance():StoryName2StoryId(arg_66_1.story)
		})
	end

	return
end

function CollectionScene:memoryFilter()
	self.memoryGroups = {}

	for iter_68_0, iter_68_1 in ipairs(pg.memory_group.all) do
		if self.memoryFilterIndex[pg.memory_group[iter_68_1].type] then
			table.insert(self.memoryGroups, pg.memory_group[iter_68_1])
		end
	end

	table.sort(self.memoryGroups, function(arg_69_0, arg_69_1)
		return arg_69_0.id < arg_69_1.id
	end)
	self.memoryList:SetTotalCount(#self.memoryGroups, 0)

	return
end

function CollectionScene:willExit()
	if self.bulinTip then
		self.bulinTip:Destroy()

		self.bulinTip = nil
	end

	if self.tweens then
		cancelTweens(self.tweens)
	end

	self:UnOverlayPanel(self.blurPanel, self._tf)

	if self.bonusPanel.gameObject.activeSelf then
		self:closeBonus()
	end

	Destroy(self.bonusPanel)

	self.bonusPanel = nil

	for iter_70_0, iter_70_1 in pairs(self.cardItems) do
		iter_70_1:clear()
	end

	if self.resPanel then
		self.resPanel:exit()

		self.resPanel = nil
	end

	if self.galleryView then
		self.galleryView:Destroy()

		self.galleryView = nil
	end

	if self.musicView then
		self.musicView:Destroy()

		self.musicView = nil
	end

	if self.mangaView then
		self.mangaView:Destroy()

		self.mangaView = nil
	end

	return
end

function CollectionScene:initGalleryPanel()
	if not self.galleryView then
		self.galleryView = GalleryView.New(self.galleryPanelContainer, self.event, self.contextData)

		self.galleryView:RegisterView(self)
		self.galleryView:Reset()
		self.galleryView:Load()
	end

	return
end

function CollectionScene:initMusicPanel()
	if not self.musicView then
		self.musicView = MusicCollectionView.New(self.musicPanelContainer, self.event, self.contextData)

		self.musicView:Reset()
		self.musicView:Load()
		pg.CriMgr.GetInstance():StopBGM()
	end

	return
end

function CollectionScene:initMangaPanel()
	if not self.mangaView then
		self.mangaView = MangaView.New(self.mangaPanelContainer, self.event, self.contextData)

		self.mangaView:Reset()
		self.mangaView:Load()
	end

	return
end

function CollectionScene:initEvents()
	self:bind(CollectionScene.UPDATE_RED_POINT, function()
		self:updateCollectNotices()

		return
	end)

	return
end

function CollectionScene:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if self.bonusPanel.gameObject.activeSelf then
		self:closeBonus()

		return
	end

	if self.galleryView then
		if self.galleryView:onBackPressed() == true then
			self.galleryView:Destroy()

			self.galleryView = nil
		else
			return
		end
	end

	if self.musicView then
		if self.musicView:onBackPressed() == true then
			self.musicView:Destroy()

			self.musicView = nil
		else
			return
		end
	end

	if self.mangaView then
		if self.mangaView:onBackPressed() == true then
			self.mangaView:Destroy()

			self.mangaView = nil
		else
			return
		end
	end

	triggerButton(self.backBtn)

	return
end

return CollectionScene

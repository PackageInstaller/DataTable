local var_0_0 = class("CollectionScene", import("..base.BaseUI"))

var_0_0.SHOW_DETAIL = "event show detail"
var_0_0.GET_AWARD = "event get award"
var_0_0.ACTIVITY_OP = "event activity op"
var_0_0.BEGIN_STAGE = "event begin state"
var_0_0.ON_INDEX = "event on index"
var_0_0.UPDATE_RED_POINT = "CollectionScene:UPDATE_RED_POINT"
var_0_0.ShipOrderAsc = false
var_0_0.ShipIndex = {
	typeIndex = ShipIndexConst.TypeAll,
	campIndex = ShipIndexConst.CampAll,
	rarityIndex = ShipIndexConst.RarityAll,
	collExtraIndex = ShipIndexConst.CollExtraAll
}
var_0_0.ShipIndexData = {
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
var_0_0.SHIPCOLLECTION_INDEX = 1
var_0_0.MANGA_INDEX = 4
var_0_0.GALLERY_INDEX = 5
var_0_0.MUSIC_INDEX = 6

function var_0_0.isDefaultStatus(arg_1_0)
	return var_0_0.ShipIndex.typeIndex == ShipIndexConst.TypeAll and (var_0_0.ShipIndex.campIndex == ShipIndexConst.CampAll or arg_1_0.contextData.toggle == 1 and arg_1_0.contextData.cardToggle == 2) and var_0_0.ShipIndex.rarityIndex == ShipIndexConst.RarityAll and var_0_0.ShipIndex.collExtraIndex == ShipIndexConst.CollExtraAll
end

function var_0_0.getUIName(arg_2_0)
	return "CollectionUI"
end

function var_0_0.setShipGroups(arg_3_0, arg_3_1)
	arg_3_0.shipGroups = arg_3_1

	return
end

function var_0_0.setAwards(arg_4_0, arg_4_1)
	arg_4_0.awards = arg_4_1

	return
end

function var_0_0.setCollectionRate(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.rate = arg_5_1
	arg_5_0.count = arg_5_2
	arg_5_0.totalCount = arg_5_3

	return
end

function var_0_0.setLinkCollectionCount(arg_6_0, arg_6_1)
	arg_6_0.linkCount = arg_6_1

	return
end

function var_0_0.setPlayer(arg_7_0, arg_7_1)
	arg_7_0.player = arg_7_1

	return
end

function var_0_0.setProposeList(arg_8_0, arg_8_1)
	arg_8_0.proposeList = arg_8_1

	return
end

function var_0_0.init(arg_9_0)
	arg_9_0:initEvents()

	arg_9_0.blurPanel = arg_9_0._tf:Find("blur_panel")
	arg_9_0.top = arg_9_0._tf:Find("blur_panel/adapt/top")
	arg_9_0.leftPanel = arg_9_0._tf:Find("blur_panel/adapt/left_length")
	arg_9_0.backBtn = findTF(arg_9_0.top, "back_btn")
	arg_9_0.contextData.toggle = arg_9_0.contextData.toggle or 2
	arg_9_0.toggles = {
		arg_9_0.leftPanel:Find("frame/tagRoot/card"),
		arg_9_0.leftPanel:Find("frame/tagRoot/display"),
		arg_9_0.leftPanel:Find("frame/tagRoot/trans"),
		arg_9_0.leftPanel:Find("frame/tagRoot/manga"),
		arg_9_0.leftPanel:Find("frame/tagRoot/gallery"),
		arg_9_0.leftPanel:Find("frame/tagRoot/music")
	}
	arg_9_0.toggleUpdates = {
		"initCardPanel",
		"initDisplayPanel",
		"initCardPanel",
		"initMangaPanel",
		"initGalleryPanel",
		"initMusicPanel"
	}
	arg_9_0.cardList = arg_9_0._tf:Find("main/list_card/scroll"):GetComponent("LScrollRect")

	function arg_9_0.cardList.onInitItem(arg_10_0)
		arg_9_0:onInitCard(arg_10_0)

		return
	end

	function arg_9_0.cardList.onUpdateItem(arg_11_0, arg_11_1)
		arg_9_0:onUpdateCard(arg_11_0, arg_11_1)

		return
	end

	function arg_9_0.cardList.onReturnItem(arg_12_0, arg_12_1)
		arg_9_0:onReturnCard(arg_12_0, arg_12_1)

		return
	end

	arg_9_0.cardItems = {}
	arg_9_0.cardContent = tf(arg_9_0.cardList):Find("ships")
	arg_9_0.contextData.cardToggle = arg_9_0.contextData.cardToggle or 1
	arg_9_0.cardToggleGroup = arg_9_0._tf:Find("main/list_card/types")
	arg_9_0.cardToggles = {
		arg_9_0.cardToggleGroup:Find("char"),
		arg_9_0.cardToggleGroup:Find("link"),
		arg_9_0.cardToggleGroup:Find("blueprint"),
		arg_9_0.cardToggleGroup:Find("meta")
	}
	arg_9_0.cardList.decelerationRate = 0.07
	arg_9_0.bonusPanel = arg_9_0._tf:Find("bonus_panel")
	arg_9_0.charTpl = arg_9_0:getTpl("chartpl")
	arg_9_0.tip = arg_9_0.toggles[2]:Find("tip")
	arg_9_0.favoriteVOs = {}

	for iter_9_0, iter_9_1 in ipairs(pg.storeup_data_template.all) do
		table.insert(arg_9_0.favoriteVOs, (Favorite.New({
			id = iter_9_0
		})))
	end

	arg_9_0.memoryGroups = _.map(pg.memory_group.all, function(arg_13_0)
		return pg.memory_group[arg_13_0]
	end)
	arg_9_0.memories = nil
	arg_9_0.memoryList = arg_9_0._tf:Find("main/list_memory"):GetComponent("LScrollRect")

	function arg_9_0.memoryList.onInitItem(arg_14_0)
		arg_9_0:onInitMemory(arg_14_0)

		return
	end

	function arg_9_0.memoryList.onUpdateItem(arg_15_0, arg_15_1)
		arg_9_0:onUpdateMemory(arg_15_0, arg_15_1)

		return
	end

	function arg_9_0.memoryList.onReturnItem(arg_16_0, arg_16_1)
		arg_9_0:onReturnMemory(arg_16_0, arg_16_1)

		return
	end

	arg_9_0.memoryViewport = arg_9_0._tf:Find("main/list_memory/viewport")
	arg_9_0.memoriesGrid = arg_9_0._tf:Find("main/list_memory/viewport/memories"):GetComponent(typeof(GridLayoutGroup))
	arg_9_0.memoryItems = {}
	arg_9_0.memoryMask = arg_9_0._tf:Find("blur_panel/story_mask")

	setActive(tf(arg_9_0.memoryList):Find("memory"), false)
	setActive(arg_9_0.memoryMask, false)

	arg_9_0.memoryTogGroup = arg_9_0.top:Find("memory")

	setActive(arg_9_0.memoryTogGroup, false)

	arg_9_0.memoryToggles = {
		arg_9_0.top:Find("memory/0"),
		arg_9_0.top:Find("memory/1"),
		arg_9_0.top:Find("memory/2"),
		arg_9_0.top:Find("memory/3")
	}
	arg_9_0.memoryFilterIndex = {
		true,
		true,
		true
	}
	arg_9_0.galleryPanelContainer = arg_9_0._tf:Find("main/GalleryContainer")
	arg_9_0.musicPanelContainer = arg_9_0._tf:Find("main/MusicContainer")
	arg_9_0.mangaPanelContainer = arg_9_0._tf:Find("main/MangaContainer")

	arg_9_0:initIndexPanel()

	return
end

function var_0_0.didEnter(arg_17_0)
	onButton(arg_17_0, arg_17_0.backBtn, function()
		arg_17_0.contextData.cardScrollValue = 0

		arg_17_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_CANCEL)

	arg_17_0.helpBtn = arg_17_0.leftPanel:Find("help_btn")

	onButton(arg_17_0, arg_17_0.helpBtn, function()
		if arg_17_0.contextData.toggle == var_0_0.MUSIC_INDEX then
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

	local var_17_0 = arg_17_0.top:Find("stamp")

	setActive(var_17_0, getProxy(TaskProxy):mingshiTouchFlagEnabled())
	onButton(arg_17_0, var_17_0, function()
		getProxy(TaskProxy):dealMingshiTouchFlag(8)

		return
	end, SFX_CONFIRM)

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.toggles) do
		if PLATFORM_CODE == PLATFORM_CH and (iter_17_0 == 1 or iter_17_0 == 3) and LOCK_COLLECTION then
			setActive(iter_17_1, false)
		else
			onToggle(arg_17_0, iter_17_1, function(arg_21_0)
				if arg_21_0 then
					if arg_17_0.contextData.toggle ~= iter_17_0 then
						if arg_17_0.contextData.toggle == var_0_0.SHIPCOLLECTION_INDEX then
							setActive(arg_17_0.helpBtn, false)

							if arg_17_0.bulinTip then
								arg_17_0.bulinTip.buffer:Hide()
							end

							if arg_17_0.contextData.cardToggle == 1 then
								arg_17_0.contextData.cardScrollValue = arg_17_0.cardList.value
							end
						end

						arg_17_0.contextData.toggle = iter_17_0

						if arg_17_0.toggleUpdates[iter_17_0] then
							arg_17_0[arg_17_0.toggleUpdates[iter_17_0]](arg_17_0)
							arg_17_0:calFavoriteRate()
						end
					end

					if iter_17_0 == var_0_0.SHIPCOLLECTION_INDEX then
						setActive(arg_17_0.helpBtn, true)

						local var_21_0 = getProxy(SettingsProxy)

						if not var_21_0:IsShowCollectionHelp() then
							triggerButton(arg_17_0.helpBtn)
							var_21_0:SetCollectionHelpFlag(true)
						end

						if arg_17_0.bulinTip then
							arg_17_0.bulinTip.buffer:Show()
						else
							arg_17_0.bulinTip = AprilFoolBulinSubView.ShowAprilFoolBulin(arg_17_0, arg_17_0._tf:Find("main"))
						end
					end

					if iter_17_0 ~= var_0_0.MUSIC_INDEX then
						if arg_17_0.musicView and arg_17_0.musicView:CheckState(BaseSubView.STATES.INITED) then
							arg_17_0.musicView:tryPauseMusic()
							arg_17_0.musicView:closeAlbumListPanel()
						end

						pg.BgmMgr.GetInstance():ContinuePlay()
					elseif iter_17_0 == var_0_0.MUSIC_INDEX then
						pg.BgmMgr.GetInstance():StopPlay()

						if arg_17_0.musicView and arg_17_0.musicView:CheckState(BaseSubView.STATES.INITED) then
							arg_17_0.musicView:tryPlayMusic()
						end
					end
				end

				return
			end, SFX_UI_TAG)
		end
	end

	for iter_17_2, iter_17_3 in ipairs(arg_17_0.memoryToggles) do
		onToggle(arg_17_0, iter_17_3, function(arg_22_0)
			if arg_22_0 then
				if iter_17_2 == 1 then
					arg_17_0.memoryFilterIndex = {
						true,
						true,
						true
					}
				else
					for iter_22_0 in ipairs(arg_17_0.memoryFilterIndex) do
						arg_17_0.memoryFilterIndex[iter_22_0] = iter_17_2 - 1 == iter_22_0
					end
				end

				arg_17_0:memoryFilter()
			end

			return
		end, SFX_UI_TAG)
	end

	arg_17_0.contextData.toggle = -1

	triggerToggle(arg_17_0.toggles[arg_17_0.contextData.toggle], true)

	if arg_17_0.contextData.memoryGroup and pg.memory_group[arg_17_0.contextData.memoryGroup] then
		arg_17_0:showSubMemories(pg.memory_group[arg_17_0.contextData.memoryGroup])
	else
		triggerToggle(arg_17_0.memoryToggles[1], true)
	end

	for iter_17_4, iter_17_5 in ipairs(arg_17_0.cardToggles) do
		triggerToggle(iter_17_5, arg_17_0.contextData.cardToggle == iter_17_4)
		onToggle(arg_17_0, iter_17_5, function(arg_23_0)
			if arg_23_0 and arg_17_0.contextData.cardToggle ~= iter_17_4 then
				if arg_17_0.contextData.cardToggle == 1 then
					arg_17_0.contextData.cardScrollValue = arg_17_0.cardList.value
				end

				arg_17_0.contextData.cardToggle = iter_17_4

				arg_17_0:initCardPanel()
				arg_17_0:calFavoriteRate()
			end

			return
		end)
	end

	arg_17_0:calFavoriteRate()
	arg_17_0:OverlayPanel(arg_17_0.blurPanel)
	onButton(arg_17_0, arg_17_0.bonusPanel, function()
		arg_17_0:closeBonus()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateCollectNotices(arg_25_0, arg_25_1)
	setActive(arg_25_0.tip, arg_25_1)
	setActive(arg_25_0.toggles[var_0_0.GALLERY_INDEX]:Find("tip"), getProxy(AppreciateProxy):isGalleryHaveNewRes())
	setActive(arg_25_0.toggles[var_0_0.MUSIC_INDEX]:Find("tip"), getProxy(AppreciateProxy):isMusicHaveNewRes())
	setActive(arg_25_0.toggles[var_0_0.MANGA_INDEX]:Find("tip"), getProxy(AppreciateProxy):isMangaHaveNewRes())

	return
end

function var_0_0.calFavoriteRate(arg_26_0)
	local var_26_0 = arg_26_0.contextData.toggle == 1 and arg_26_0.contextData.cardToggle == 2

	setActive(arg_26_0.top:Find("total/char"), not (arg_26_0.contextData.toggle == 1 and arg_26_0.contextData.cardToggle == 2))
	setActive(arg_26_0.top:Find("total/link"), var_26_0)
	setText(arg_26_0.top:Find("total/char/rate/Text"), arg_26_0.rate * 100 .. "%")
	setText(arg_26_0.top:Find("total/char/count/Text"), arg_26_0.count .. "/" .. arg_26_0.totalCount)
	setText(arg_26_0.top:Find("total/link/count/Text"), arg_26_0.linkCount)

	return
end

function var_0_0.initCardPanel(arg_27_0)
	GetSpriteFromAtlasAsync("ui/share/index_atlas", arg_27_0:isDefaultStatus() and "shaixuan_off" or "shaixuan_on", function(arg_28_0)
		setImageSprite(arg_27_0.indexBtn, arg_28_0, true)

		return
	end)

	if arg_27_0.contextData.toggle == 1 then
		setActive(arg_27_0.cardToggleGroup, true)
		arg_27_0:cardFilter()
	elseif arg_27_0.contextData.toggle == 3 then
		setActive(arg_27_0.cardToggleGroup, false)
		arg_27_0:transFilter()
	end

	table.sort(arg_27_0.codeShips, function(arg_29_0, arg_29_1)
		return arg_29_0.index_id < arg_29_1.index_id
	end)

	local var_27_0 = arg_27_0.contextData.cardScrollValue or 0

	arg_27_0.cardList:SetTotalCount(#arg_27_0.codeShips, var_27_0)

	return
end

function var_0_0.initIndexPanel(arg_30_0)
	arg_30_0.indexBtn = arg_30_0.top:Find("index_button")

	onButton(arg_30_0, arg_30_0.indexBtn, function()
		local var_31_0 = Clone(var_0_0.ShipIndexData)

		if arg_30_0.contextData.toggle == 1 and arg_30_0.contextData.cardToggle == 2 then
			var_31_0.customPanels.campIndex = nil
			var_31_0.groupList[2] = nil
		end

		var_31_0.indexDatas = Clone(var_0_0.ShipIndex)

		function var_31_0.callback(arg_32_0)
			var_0_0.ShipIndex.typeIndex = arg_32_0.typeIndex

			if arg_32_0.campIndex then
				var_0_0.ShipIndex.campIndex = arg_32_0.campIndex
			end

			var_0_0.ShipIndex.rarityIndex = arg_32_0.rarityIndex
			var_0_0.ShipIndex.collExtraIndex = arg_32_0.collExtraIndex

			arg_30_0:initCardPanel()

			return
		end

		arg_30_0:emit(var_0_0.ON_INDEX, var_31_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.onInitCard(arg_33_0, arg_33_1)
	if arg_33_0.exited then
		return
	end

	local var_33_0 = CollectionShipCard.New(arg_33_1)

	onButton(arg_33_0, var_33_0.go, function()
		if not arg_33_0.isClicked then
			arg_33_0.isClicked = true

			LeanTween.delayedCall(0.2, System.Action(function()
				arg_33_0.isClicked = false

				if not var_33_0:getIsInited() then
					return
				end

				if var_33_0.state == ShipGroup.STATE_UNLOCK then
					arg_33_0.contextData.cardScrollValue = arg_33_0.cardList.value

					arg_33_0:emit(var_0_0.SHOW_DETAIL, var_33_0.showTrans, var_33_0.shipGroup.id)
				elseif var_33_0.state == ShipGroup.STATE_NOTGET then
					if var_33_0.showTrans == true and var_33_0.shipGroup.trans == true then
						return
					end

					if var_33_0.config then
						arg_33_0:showObtain(var_33_0.config.description, var_33_0.shipGroup:getShipConfigId())
					end
				end

				return
			end))
		end

		return
	end, SOUND_BACK)

	arg_33_0.cardItems[arg_33_1] = var_33_0

	return
end

function var_0_0.showObtain(arg_36_0, arg_36_1, arg_36_2)
	if PLATFORM_CODE == PLATFORM_CH and HXSet.isHx() then
		({
			type = MSGBOX_TYPE_OBTAIN,
			shipId = arg_36_2,
			list = arg_36_1,
			mediatorName = CollectionMediator.__cname
		}).unknown_small = true
	end

	arg_36_0.contextData.cardScrollValue = arg_36_0.cardList.value

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		type = MSGBOX_TYPE_OBTAIN,
		shipId = arg_36_2,
		list = arg_36_1,
		mediatorName = CollectionMediator.__cname
	})

	return
end

function var_0_0.skipIn(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0.contextData.displayGroupId = arg_37_2

	triggerToggle(arg_37_0.toggles[arg_37_1], true)

	return
end

function var_0_0.onUpdateCard(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_0.exited then
		return
	end

	local var_38_0 = arg_38_0.cardItems[arg_38_2]

	if not arg_38_0.cardItems[arg_38_2] then
		arg_38_0:onInitCard(arg_38_2)

		var_38_0 = arg_38_0.cardItems[arg_38_2]
	end

	local var_38_1 = arg_38_0.codeShips[arg_38_1 + 1]

	if not arg_38_0.codeShips[arg_38_1 + 1] then
		return
	end

	local var_38_2 = false

	if var_38_1.group then
		var_38_2 = arg_38_0.proposeList[var_38_1.group.id]
	end

	var_38_0:update(var_38_1.code, var_38_1.group, var_38_1.showTrans, var_38_2, var_38_1.id)

	return
end

function var_0_0.onReturnCard(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_0.exited then
		return
	end

	if arg_39_0.cardItems[arg_39_2] then
		var_39_0:clear()
	end

	return
end

function var_0_0.cardFilter(arg_40_0)
	arg_40_0.codeShips = {}

	local var_40_0 = _.filter(pg.ship_data_group.all, function(arg_41_0)
		return pg.ship_data_group[arg_41_0].handbook_type == arg_40_0.contextData.cardToggle - 1
	end)

	table.sort(var_40_0)

	for iter_40_0, iter_40_1 in ipairs(var_40_0) do
		local var_40_1 = pg.ship_data_group[iter_40_1]
		local var_40_2 = arg_40_0.shipGroups[pg.ship_data_group[iter_40_1].group_type] or ShipGroup.New({
			id = var_40_1.group_type
		})

		if ShipIndexConst.filterByType(var_40_2, var_0_0.ShipIndex.typeIndex) and (arg_40_0.contextData.cardToggle == 2 or ShipIndexConst.filterByCamp(var_40_2, var_0_0.ShipIndex.campIndex)) and arg_40_0.contextData.cardToggle == 4 == Nation.IsMeta(ShipGroup.getDefaultShipConfig(var_40_1.group_type).nationality) and ShipIndexConst.filterByRarity(var_40_2, var_0_0.ShipIndex.rarityIndex) and ShipIndexConst.filterByCollExtra(var_40_2, var_0_0.ShipIndex.collExtraIndex) then
			arg_40_0.codeShips[#arg_40_0.codeShips + 1] = {
				showTrans = false,
				id = iter_40_1,
				code = iter_40_1 - (arg_40_0.contextData.cardToggle - 1) * 16,
				group = arg_40_0.shipGroups[var_40_1.group_type],
				index_id = var_40_1.index_id
			}
		end
	end

	return
end

function var_0_0.transFilter(arg_42_0)
	arg_42_0.codeShips = {}

	local var_42_0 = _.filter(pg.ship_data_group.all, function(arg_43_0)
		return pg.ship_data_group[arg_43_0].handbook_type == 0
	end)

	table.sort(var_42_0)

	for iter_42_0, iter_42_1 in ipairs(var_42_0) do
		local var_42_1 = pg.ship_data_group[iter_42_1]

		if pg.ship_data_trans[pg.ship_data_group[iter_42_1].group_type] then
			local var_42_2 = arg_42_0.shipGroups[var_42_1.group_type] or ShipGroup.New({
				remoulded = true,
				id = var_42_1.group_type
			})

			if ShipIndexConst.filterByType(var_42_2, var_0_0.ShipIndex.typeIndex) and ShipIndexConst.filterByCamp(var_42_2, var_0_0.ShipIndex.campIndex) and ShipIndexConst.filterByRarity(var_42_2, var_0_0.ShipIndex.rarityIndex) and ShipIndexConst.filterByCollExtra(var_42_2, var_0_0.ShipIndex.collExtraIndex) then
				arg_42_0.codeShips[#arg_42_0.codeShips + 1] = {
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

function var_0_0.sortDisplay(arg_44_0)
	table.sort(arg_44_0.favoriteVOs, function(arg_45_0, arg_45_1)
		local var_45_0 = arg_45_0:getState(arg_44_0.shipGroups, arg_44_0.awards)
		local var_45_1 = arg_45_1:getState(arg_44_0.shipGroups, arg_44_0.awards)

		if var_45_0 == var_45_1 then
			return arg_45_0.id < arg_45_1.id
		else
			return var_45_0 < var_45_1
		end

		return
	end)

	local var_44_0 = 0

	for iter_44_0, iter_44_1 in ipairs(arg_44_0.favoriteVOs) do
		if iter_44_1:containShipGroup(arg_44_0.contextData.displayGroupId) then
			var_44_0 = iter_44_0

			break
		end
	end

	arg_44_0.displayRect:SetTotalCount(#arg_44_0.favoriteVOs, arg_44_0.displayRect:HeadIndexToValue(var_44_0 - 1))

	return
end

function var_0_0.initDisplayPanel(arg_46_0)
	if not arg_46_0.isInitDisplay then
		arg_46_0.isInitDisplay = true
		arg_46_0.displayRect = arg_46_0._tf:Find("main/list_display"):GetComponent("LScrollRect")
		arg_46_0.displayRect.decelerationRate = 0.07

		function arg_46_0.displayRect.onInitItem(arg_47_0)
			arg_46_0:initFavoriteCard(arg_47_0)

			return
		end

		function arg_46_0.displayRect.onUpdateItem(arg_48_0, arg_48_1)
			arg_46_0:updateFavoriteCard(arg_48_0, arg_48_1)

			return
		end

		arg_46_0.favoriteCards = {}
	end

	arg_46_0:sortDisplay()

	return
end

function var_0_0.initFavoriteCard(arg_49_0, arg_49_1)
	if arg_49_0.exited then
		return
	end

	local var_49_0 = FavoriteCard.New(arg_49_1, arg_49_0.charTpl)

	onButton(arg_49_0, var_49_0.awardTF, function()
		if var_49_0.state == Favorite.STATE_AWARD then
			arg_49_0:emit(var_0_0.GET_AWARD, var_49_0.favoriteVO.id, var_49_0.favoriteVO:getNextAwardIndex(var_49_0.awards))
		elseif var_49_0.state == Favorite.STATE_LOCK then
			pg.TipsMgr.GetInstance():ShowTips(i18n("collection_lock"))
		elseif var_49_0.state == Favorite.STATE_FETCHED then
			pg.TipsMgr.GetInstance():ShowTips(i18n("collection_fetched"))
		elseif var_49_0.state == Favorite.STATE_STATE_WAIT then
			pg.TipsMgr.GetInstance():ShowTips(i18n("collection_nostar"))
		end

		return
	end, SFX_PANEL)
	onButton(arg_49_0, var_49_0.box, function()
		arg_49_0:openBonus(var_49_0.favoriteVO)

		return
	end, SFX_PANEL)

	arg_49_0.favoriteCards[arg_49_1] = var_49_0

	return
end

function var_0_0.updateFavoriteCard(arg_52_0, arg_52_1, arg_52_2)
	if arg_52_0.exited then
		return
	end

	if not arg_52_0.favoriteCards[arg_52_2] then
		arg_52_0:initFavoriteCard(arg_52_2)
	end

	arg_52_0.favoriteCards[arg_52_2]:update(arg_52_0.favoriteVOs[arg_52_1 + 1], arg_52_0.shipGroups, arg_52_0.awards)

	return
end

function var_0_0.openBonus(arg_53_0, arg_53_1)
	if not arg_53_0.isInitBound then
		arg_53_0.isInitBound = true
		arg_53_0.boundName = findTF(arg_53_0.bonusPanel, "frame/name/Text"):GetComponent(typeof(Text))
		arg_53_0.progressSlider = findTF(arg_53_0.bonusPanel, "frame/process"):GetComponent(typeof(Slider))
	end

	pg.UIMgr.GetInstance():BlurPanel(arg_53_0.bonusPanel)
	setActive(arg_53_0.bonusPanel, true)

	arg_53_0.boundName.text = arg_53_1:getConfig("name")

	local var_53_0 = arg_53_1:getConfig("award_display")
	local var_53_1 = arg_53_1:getConfig("level")

	for iter_53_0, iter_53_1 in ipairs(var_53_1) do
		local var_53_2 = var_53_0[iter_53_0]
		local var_53_3 = findTF(arg_53_0.bonusPanel, "frame/awards/award" .. iter_53_0)

		setText(findTF(var_53_3, "process"), iter_53_1)

		local var_53_4 = arg_53_1:getAwardState(arg_53_0.shipGroups, arg_53_0.awards, iter_53_0)

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

			updateDrop(findTF(var_53_3, "item_tpl"), {
				count = 0,
				type = var_53_2[1],
				id = var_53_2[2]
			})

			;({
				count = 0,
				type = var_53_2[1],
				id = var_53_2[2]
			}).count = var_53_2[3]

			onButton(arg_53_0, var_53_3, function()
				arg_53_0:emit(var_0_0.ON_DROP, var_53_5)

				return
			end, SFX_PANEL)
		else
			GetOrAddComponent(var_53_3, typeof(Button)).onClick:RemoveAllListeners()
		end
	end

	arg_53_0.progressSlider.value = arg_53_1:getStarCount(arg_53_0.shipGroups) / var_53_1[#var_53_1]

	return
end

function var_0_0.closeBonus(arg_55_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_55_0.bonusPanel, arg_55_0._tf)
	setActive(arg_55_0.bonusPanel, false)

	return
end

function var_0_0.showSubMemories(arg_56_0, arg_56_1)
	arg_56_0.contextData.memoryGroup = arg_56_1.id
	arg_56_0.memories = _.map(arg_56_1.memories, function(arg_57_0)
		return pg.memory_template[arg_57_0]
	end)

	for iter_56_0 in ipairs(arg_56_0.memories) do
		arg_56_0.memories[iter_56_0].index = iter_56_0
	end

	arg_56_0.memoryList:SetTotalCount(#arg_56_0.memories, 0)
	setActive(arg_56_0.top:Find("memory"), false)

	return
end

local var_0_1 = 3

function var_0_0.return2MemoryGroup(arg_58_0)
	arg_58_0.contextData.memoryGroup = nil
	arg_58_0.memories = nil

	local var_58_0 = 0

	if arg_58_0.contextData.memoryGroup then
		local var_58_1 = 0

		for iter_58_0, iter_58_1 in ipairs(arg_58_0.memoryGroups) do
			if iter_58_1.id == arg_58_0.contextData.memoryGroup then
				var_58_1 = iter_58_0

				break
			end
		end

		if var_58_1 >= 0 then
			var_58_0 = ((arg_58_0.memoriesGrid.cellSize.y + arg_58_0.memoriesGrid.spacing.y) * math.floor((var_58_1 - 1) / var_0_1) + arg_58_0.memoryList.paddingFront) / ((arg_58_0.memoriesGrid.cellSize.y + arg_58_0.memoriesGrid.spacing.y) * math.ceil(#arg_58_0.memoryGroups / var_0_1) - arg_58_0.memoryViewport.rect.height)
			var_58_0 = Mathf.Clamp01(var_58_0)
		end
	end

	arg_58_0.memoryList:SetTotalCount(#arg_58_0.memoryGroups, var_58_0)
	setActive(arg_58_0.top:Find("memory"), true)

	return
end

function var_0_0.initMemoryPanel(arg_59_0)
	local var_59_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.QIXI_ACTIVITY_ID)

	if var_59_0 and not var_59_0:isEnd() then
		local var_59_1 = _.flatten((var_59_0:getConfig("config_data")))
		local var_59_2 = getProxy(TaskProxy):getTaskById(var_59_1[#var_59_1])

		if var_59_2 and not var_59_2:isFinish() then
			pg.NewStoryMgr.GetInstance():Play("HOSHO8", function()
				arg_59_0:emit(CollectionScene.ACTIVITY_OP, {
					cmd = 2,
					activity_id = var_59_0.id
				})

				return
			end, true)
		end
	end

	arg_59_0:memoryFilter()

	return
end

function var_0_0.onInitMemory(arg_61_0, arg_61_1)
	if arg_61_0.exited then
		return
	end

	local var_61_0 = MemoryCard.New(arg_61_1)

	onButton(arg_61_0, var_61_0.go, function()
		if var_61_0.info then
			if var_61_0.isGroup then
				arg_61_0:showSubMemories(var_61_0.info)

				goto label_62_0
			end

			::label_62_0::

			if var_61_0.info.is_open ~= 1 then
				if pg.NewStoryMgr.GetInstance():IsPlayed(var_61_0.info.unlock_pre, true) then
					arg_61_0:playMemory(var_61_0.info)
				end

				return
			end
		end
	end, SOUND_BACK)

	arg_61_0.memoryItems[arg_61_1] = var_61_0

	return
end

function var_0_0.onUpdateMemory(arg_63_0, arg_63_1, arg_63_2)
	if arg_63_0.exited then
		return
	end

	local var_63_0 = arg_63_0.memoryItems[arg_63_2]

	if not arg_63_0.memoryItems[arg_63_2] then
		arg_63_0:onInitMemory(arg_63_2)

		var_63_0 = arg_63_0.memoryItems[arg_63_2]
	end

	if arg_63_0.memories then
		var_63_0:update(false, arg_63_0.memories[arg_63_1 + 1])
	else
		var_63_0:update(true, arg_63_0.memoryGroups[arg_63_1 + 1])
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

function var_0_0.onReturnMemory(arg_65_0, arg_65_1, arg_65_2)
	if arg_65_0.exited then
		return
	end

	if arg_65_0.memoryItems[arg_65_2] then
		var_65_0:clear()
	end

	return
end

function var_0_0.playMemory(arg_66_0, arg_66_1)
	if arg_66_1.type == 1 then
		local var_66_0 = findTF(arg_66_0.memoryMask, "pic")

		if string.len(arg_66_1.mask) > 0 then
			setActive(var_66_0, true)

			var_66_0:GetComponent(typeof(Image)).sprite = LoadSprite(arg_66_1.mask)
		else
			setActive(var_66_0, false)
		end

		setActive(arg_66_0.memoryMask, true)
		pg.NewStoryMgr.GetInstance():Play(arg_66_1.story, function()
			setActive(arg_66_0.memoryMask, false)

			return
		end, true)
	elseif arg_66_1.type == 2 then
		arg_66_0:emit(var_0_0.BEGIN_STAGE, {
			memory = true,
			system = SYSTEM_PERFORM,
			stageId = pg.NewStoryMgr.GetInstance():StoryName2StoryId(arg_66_1.story)
		})
	end

	return
end

function var_0_0.memoryFilter(arg_68_0)
	arg_68_0.memoryGroups = {}

	for iter_68_0, iter_68_1 in ipairs(pg.memory_group.all) do
		if arg_68_0.memoryFilterIndex[pg.memory_group[iter_68_1].type] then
			table.insert(arg_68_0.memoryGroups, pg.memory_group[iter_68_1])
		end
	end

	table.sort(arg_68_0.memoryGroups, function(arg_69_0, arg_69_1)
		return arg_69_0.id < arg_69_1.id
	end)
	arg_68_0.memoryList:SetTotalCount(#arg_68_0.memoryGroups, 0)

	return
end

function var_0_0.willExit(arg_70_0)
	if arg_70_0.bulinTip then
		arg_70_0.bulinTip:Destroy()

		arg_70_0.bulinTip = nil
	end

	if arg_70_0.tweens then
		cancelTweens(arg_70_0.tweens)
	end

	arg_70_0:UnOverlayPanel(arg_70_0.blurPanel, arg_70_0._tf)

	if arg_70_0.bonusPanel.gameObject.activeSelf then
		arg_70_0:closeBonus()
	end

	Destroy(arg_70_0.bonusPanel)

	arg_70_0.bonusPanel = nil

	for iter_70_0, iter_70_1 in pairs(arg_70_0.cardItems) do
		iter_70_1:clear()
	end

	if arg_70_0.resPanel then
		arg_70_0.resPanel:exit()

		arg_70_0.resPanel = nil
	end

	if arg_70_0.galleryView then
		arg_70_0.galleryView:Destroy()

		arg_70_0.galleryView = nil
	end

	if arg_70_0.musicView then
		arg_70_0.musicView:Destroy()

		arg_70_0.musicView = nil
	end

	if arg_70_0.mangaView then
		arg_70_0.mangaView:Destroy()

		arg_70_0.mangaView = nil
	end

	return
end

function var_0_0.initGalleryPanel(arg_71_0)
	if not arg_71_0.galleryView then
		arg_71_0.galleryView = GalleryView.New(arg_71_0.galleryPanelContainer, arg_71_0.event, arg_71_0.contextData)

		arg_71_0.galleryView:RegisterView(arg_71_0)
		arg_71_0.galleryView:Reset()
		arg_71_0.galleryView:Load()
	end

	return
end

function var_0_0.initMusicPanel(arg_72_0)
	if not arg_72_0.musicView then
		arg_72_0.musicView = MusicCollectionView.New(arg_72_0.musicPanelContainer, arg_72_0.event, arg_72_0.contextData)

		arg_72_0.musicView:Reset()
		arg_72_0.musicView:Load()
		pg.CriMgr.GetInstance():StopBGM()
	end

	return
end

function var_0_0.initMangaPanel(arg_73_0)
	if not arg_73_0.mangaView then
		arg_73_0.mangaView = MangaView.New(arg_73_0.mangaPanelContainer, arg_73_0.event, arg_73_0.contextData)

		arg_73_0.mangaView:Reset()
		arg_73_0.mangaView:Load()
	end

	return
end

function var_0_0.initEvents(arg_74_0)
	arg_74_0:bind(var_0_0.UPDATE_RED_POINT, function()
		arg_74_0:updateCollectNotices()

		return
	end)

	return
end

function var_0_0.onBackPressed(arg_76_0)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if arg_76_0.bonusPanel.gameObject.activeSelf then
		arg_76_0:closeBonus()

		return
	end

	if arg_76_0.galleryView then
		if arg_76_0.galleryView:onBackPressed() == true then
			arg_76_0.galleryView:Destroy()

			arg_76_0.galleryView = nil
		else
			return
		end
	end

	if arg_76_0.musicView then
		if arg_76_0.musicView:onBackPressed() == true then
			arg_76_0.musicView:Destroy()

			arg_76_0.musicView = nil
		else
			return
		end
	end

	if arg_76_0.mangaView then
		if arg_76_0.mangaView:onBackPressed() == true then
			arg_76_0.mangaView:Destroy()

			arg_76_0.mangaView = nil
		else
			return
		end
	end

	triggerButton(arg_76_0.backBtn)

	return
end

return var_0_0

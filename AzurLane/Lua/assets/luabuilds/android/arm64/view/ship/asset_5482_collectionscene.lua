class = var_0_10000

local var_0_0 = "CollectionScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.SHOW_DETAIL = "event show detail"
var_0_1.GET_AWARD = "event get award"
var_0_1.ACTIVITY_OP = "event activity op"
var_0_1.BEGIN_STAGE = "event begin state"
var_0_1.ON_INDEX = "event on index"
var_0_1.UPDATE_RED_POINT = "CollectionScene:UPDATE_RED_POINT"
var_0_1.ShipOrderAsc = false

local var_0_2 = {}

ShipIndexConst = var_0_0
var_0_2.typeIndex = var_0_0.TypeAll
ShipIndexConst = var_2
var_0_2.campIndex = var_2.CampAll
ShipIndexConst = var_2
var_0_2.rarityIndex = var_2.RarityAll
ShipIndexConst = var_2
var_0_2.collExtraIndex = var_2.CollExtraAll
var_0_1.ShipIndex = var_0_2

local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {
	blueSeleted = true
}

CustomIndexLayer = var_0_10004
var_0_5.mode = var_0_10004.Mode.AND
ShipIndexConst = var_4
var_0_5.options = var_4.TypeIndexs
ShipIndexConst = var_4
var_0_5.names = var_4.TypeNames
var_0_4.typeIndex = var_0_5

local var_0_6 = {
	blueSeleted = true
}

CustomIndexLayer = var_4
var_0_6.mode = var_4.Mode.AND
ShipIndexConst = var_4
var_0_6.options = var_4.CampIndexs
ShipIndexConst = var_4
var_0_6.names = var_4.CampNames
var_0_4.campIndex = var_0_6

local var_0_7 = {
	blueSeleted = true
}

CustomIndexLayer = var_4
var_0_7.mode = var_4.Mode.AND
ShipIndexConst = var_4
var_0_7.options = var_4.RarityIndexs
ShipIndexConst = var_4
var_0_7.names = var_4.RarityNames
var_0_4.rarityIndex = var_0_7

local var_0_8 = {
	blueSeleted = true
}

CustomIndexLayer = var_4
var_0_8.mode = var_4.Mode.AND
ShipIndexConst = var_4
var_0_8.options = var_4.CollExtraIndexs
ShipIndexConst = var_4
var_0_8.names = var_4.CollExtraNames
var_0_4.collExtraIndex = var_0_8
var_0_3.customPanels = var_0_4
var_0_3.groupList = {
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
var_0_1.ShipIndexData = var_0_3
var_0_1.SHIPCOLLECTION_INDEX = 1
var_0_1.MANGA_INDEX = 4
var_0_1.GALLERY_INDEX = 5
var_0_1.MUSIC_INDEX = 6

function var_0_1.isDefaultStatus(arg_1_0)
	local var_1_0 = var_0_1.ShipIndex.typeIndex

	ShipIndexConst = var_1_10002

	if var_1_0 == var_1_10002.TypeAll then
		local var_1_1 = var_0_1.ShipIndex.campIndex

		ShipIndexConst = var_2

		if var_1_1 == var_2.CampAll or arg_1_0.contextData.toggle == 1 and arg_1_0.contextData.cardToggle == 2 then
			local var_1_2 = var_0_1.ShipIndex.rarityIndex

			ShipIndexConst = var_2

			if var_1_2 == var_2.RarityAll then
				local var_1_3 = var_0_1.ShipIndex.collExtraIndex

				ShipIndexConst = var_2

				local var_1_4

				if var_1_3 ~= var_2.CollExtraAll then
					var_1_4 = false
				else
					var_1_4 = true
				end

				return var_1_4
			end
		end
	end
end

function var_0_1.getUIName(arg_2_0)
	return "CollectionUI"
end

function var_0_1.setShipGroups(arg_3_0, arg_3_1)
	arg_3_0.shipGroups = arg_3_1

	return
end

function var_0_1.setAwards(arg_4_0, arg_4_1)
	arg_4_0.awards = arg_4_1

	return
end

function var_0_1.setCollectionRate(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.rate = arg_5_1
	arg_5_0.count = arg_5_2
	arg_5_0.totalCount = arg_5_3

	return
end

function var_0_1.setLinkCollectionCount(arg_6_0, arg_6_1)
	arg_6_0.linkCount = arg_6_1

	return
end

function var_0_1.setPlayer(arg_7_0, arg_7_1)
	arg_7_0.player = arg_7_1

	return
end

function var_0_1.setProposeList(arg_8_0, arg_8_1)
	arg_8_0.proposeList = arg_8_1

	return
end

function var_0_1.init(arg_9_0)
	arg_9_0:initEvents()

	local var_9_0 = arg_9_0._tf

	arg_9_0.blurPanel = var_1.Find(var_9_0, "blur_panel")

	local var_9_1 = arg_9_0._tf

	arg_9_0.top = var_1.Find(var_9_1, "blur_panel/adapt/top")

	local var_9_2 = arg_9_0._tf

	arg_9_0.leftPanel = var_1.Find(var_9_2, "blur_panel/adapt/left_length")
	findTF = var_1
	arg_9_0.backBtn = var_1(arg_9_0.top, "back_btn")

	local var_9_3 = arg_9_0.contextData
	local var_9_4

	if not arg_9_0.contextData.toggle then
		var_9_4 = 2
	end

	var_9_3.toggle = var_9_4

	local var_9_5 = {}
	local var_9_6 = arg_9_0.leftPanel

	var_9_5[1] = var_2.Find(var_9_6, "frame/tagRoot/card")

	local var_9_7 = arg_9_0.leftPanel

	var_9_5[2] = var_2.Find(var_9_7, "frame/tagRoot/display")

	local var_9_8 = arg_9_0.leftPanel

	var_9_5[3] = var_2.Find(var_9_8, "frame/tagRoot/trans")

	local var_9_9 = arg_9_0.leftPanel

	var_9_5[4] = var_2.Find(var_9_9, "frame/tagRoot/manga")

	local var_9_10 = arg_9_0.leftPanel

	var_9_5[5] = var_2.Find(var_9_10, "frame/tagRoot/gallery")

	local var_9_11 = arg_9_0.leftPanel

	var_9_5[6] = var_2.Find(var_9_11, "frame/tagRoot/music")
	arg_9_0.toggles = var_9_5
	arg_9_0.toggleUpdates = {
		"initCardPanel",
		"initDisplayPanel",
		"initCardPanel",
		"initMangaPanel",
		"initGalleryPanel",
		"initMusicPanel"
	}

	local var_9_12 = arg_9_0._tf
	local var_9_13 = var_1.Find(var_9_12, "main/list_card/scroll")

	arg_9_0.cardList = var_1.GetComponent(var_9_13, "LScrollRect")

	function arg_9_0.cardList.onInitItem(arg_10_0)
		local var_10_0 = arg_9_0

		var_1.onInitCard(var_10_0, arg_10_0)

		return
	end

	function arg_9_0.cardList.onUpdateItem(arg_11_0, arg_11_1)
		local var_11_0 = arg_9_0

		var_2.onUpdateCard(var_11_0, arg_11_0, arg_11_1)

		return
	end

	function arg_9_0.cardList.onReturnItem(arg_12_0, arg_12_1)
		local var_12_0 = arg_9_0

		var_2.onReturnCard(var_12_0, arg_12_0, arg_12_1)

		return
	end

	arg_9_0.cardItems = {}
	tf = var_1

	local var_9_14 = var_1(arg_9_0.cardList)

	arg_9_0.cardContent = var_1.Find(var_9_14, "ships")

	local var_9_15 = arg_9_0.contextData
	local var_9_16

	if not arg_9_0.contextData.cardToggle then
		var_9_16 = 1
	end

	var_9_15.cardToggle = var_9_16

	local var_9_17 = arg_9_0._tf

	arg_9_0.cardToggleGroup = var_1.Find(var_9_17, "main/list_card/types")

	local var_9_18 = {}
	local var_9_19 = arg_9_0.cardToggleGroup

	var_9_18[1] = var_2.Find(var_9_19, "char")

	local var_9_20 = arg_9_0.cardToggleGroup

	var_9_18[2] = var_2.Find(var_9_20, "link")

	local var_9_21 = arg_9_0.cardToggleGroup

	var_9_18[3] = var_2.Find(var_9_21, "blueprint")

	local var_9_22 = arg_9_0.cardToggleGroup

	var_9_18[4] = var_2.Find(var_9_22, "meta")
	arg_9_0.cardToggles = var_9_18
	arg_9_0.cardList.decelerationRate = 0.07

	local var_9_23 = arg_9_0._tf

	arg_9_0.bonusPanel = var_1.Find(var_9_23, "bonus_panel")
	arg_9_0.charTpl = arg_9_0:getTpl("chartpl")

	local var_9_24 = arg_9_0.toggles[2]

	arg_9_0.tip = var_1.Find(var_9_24, "tip")
	pg = var_1

	local var_9_25 = var_1.storeup_data_template

	arg_9_0.favoriteVOs = {}
	ipairs = var_2

	for iter_9_0, iter_9_1 in var_2(var_9_25.all) do
		Favorite = var_1_10007
		var_1_10007 = var_1_10007.New({
			id = iter_9_0
		})
		table = var_1_10008

		var_1_10008.insert(arg_9_0.favoriteVOs, var_1_10007)
	end

	_ = var_2

	local var_9_26 = var_2.map

	pg = var_4
	arg_9_0.memoryGroups = var_9_26(var_4.memory_group.all, function(arg_13_0)
		pg = var_2_10001

		return var_2_10001.memory_group[arg_13_0]
	end)
	arg_9_0.memories = nil

	local var_9_27 = arg_9_0._tf
	local var_9_28 = var_2.Find(var_9_27, "main/list_memory")

	arg_9_0.memoryList = var_2.GetComponent(var_9_28, "LScrollRect")

	function arg_9_0.memoryList.onInitItem(arg_14_0)
		local var_14_0 = arg_9_0

		var_1.onInitMemory(var_14_0, arg_14_0)

		return
	end

	function arg_9_0.memoryList.onUpdateItem(arg_15_0, arg_15_1)
		local var_15_0 = arg_9_0

		var_2.onUpdateMemory(var_15_0, arg_15_0, arg_15_1)

		return
	end

	function arg_9_0.memoryList.onReturnItem(arg_16_0, arg_16_1)
		local var_16_0 = arg_9_0

		var_2.onReturnMemory(var_16_0, arg_16_0, arg_16_1)

		return
	end

	local var_9_29 = arg_9_0._tf

	arg_9_0.memoryViewport = var_2.Find(var_9_29, "main/list_memory/viewport")

	local var_9_30 = arg_9_0._tf
	local var_9_31 = var_2.Find(var_9_30, "main/list_memory/viewport/memories")
	local var_9_32 = var_2.GetComponent

	typeof = var_5
	GridLayoutGroup = var_1_10007
	arg_9_0.memoriesGrid = var_9_32(var_9_31, var_5(var_1_10007))
	arg_9_0.memoryItems = {}
	tf = var_2

	local var_9_33 = var_2(arg_9_0.memoryList)
	local var_9_34 = var_2.Find(var_9_33, "memory")
	local var_9_35 = arg_9_0._tf

	arg_9_0.memoryMask = var_3.Find(var_9_35, "blur_panel/story_mask")
	setActive = var_3

	var_3(var_9_34, false)

	setActive = var_3

	var_3(arg_9_0.memoryMask, false)

	local var_9_36 = arg_9_0.top

	arg_9_0.memoryTogGroup = var_3.Find(var_9_36, "memory")
	setActive = var_3

	var_3(arg_9_0.memoryTogGroup, false)

	local var_9_37 = {}
	local var_9_38 = arg_9_0.top

	var_9_37[1] = var_4.Find(var_9_38, "memory/0")

	local var_9_39 = arg_9_0.top

	var_9_37[2] = var_4.Find(var_9_39, "memory/1")

	local var_9_40 = arg_9_0.top

	var_9_37[3] = var_4.Find(var_9_40, "memory/2")

	local var_9_41 = arg_9_0.top

	var_9_37[4] = var_4.Find(var_9_41, "memory/3")
	arg_9_0.memoryToggles = var_9_37
	arg_9_0.memoryFilterIndex = {
		true,
		true,
		true
	}

	local var_9_42 = arg_9_0._tf

	arg_9_0.galleryPanelContainer = var_3.Find(var_9_42, "main/GalleryContainer")

	local var_9_43 = arg_9_0._tf

	arg_9_0.musicPanelContainer = var_3.Find(var_9_43, "main/MusicContainer")

	local var_9_44 = arg_9_0._tf

	arg_9_0.mangaPanelContainer = var_3.Find(var_9_44, "main/MangaContainer")

	arg_9_0:initIndexPanel()

	return
end

function var_0_1.didEnter(arg_17_0)
	onButton = var_1_10001

	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.backBtn

	local function var_17_2()
		arg_17_0.contextData.cardScrollValue = 0

		local var_18_0 = arg_17_0

		var_0.emit(var_18_0, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_17_0, var_17_1, var_17_2, var_1_10006)

	local var_17_3 = arg_17_0.leftPanel

	arg_17_0.helpBtn = var_1.Find(var_17_3, "help_btn")
	onButton = var_1

	local var_17_4 = arg_17_0
	local var_17_5 = arg_17_0.helpBtn

	local function var_17_6()
		local var_19_1

		if arg_17_0.contextData.toggle == var_0_1.MUSIC_INDEX then
			pg = var_19_1

			local var_19_0 = var_19_1.MsgboxMgr.GetInstance()

			var_19_1 = var_19_1.ShowMsgBox

			local var_19_2 = {}

			MSGBOX_TYPE_HELP = var_2_10004
			var_19_2.type = var_2_10004
			pg = var_2_10004
			var_19_2.helps = var_2_10004.gametip.NewMusic_help.tip

			var_19_1(var_19_0, var_19_2)
		else
			pg = var_19_1

			local var_19_3 = var_19_1.MsgboxMgr.GetInstance()
			local var_19_4 = var_0.ShowMsgBox
			local var_19_5 = {}

			MSGBOX_TYPE_HELP = var_2_10004
			var_19_5.type = var_2_10004
			pg = var_2_10004
			var_19_5.helps = var_2_10004.gametip.collection_help.tip

			var_19_4(var_19_3, var_19_5)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_17_4, var_17_5, var_17_6, var_1_10006)

	local var_17_7 = arg_17_0.top
	local var_17_8 = var_1.Find(var_17_7, "stamp")

	setActive = var_1_10002

	local var_17_9 = var_17_8

	getProxy = var_17_6
	TaskProxy = var_1_10007

	local var_17_10 = var_17_6(var_1_10007)

	var_1_10002(var_17_9, var_5.mingshiTouchFlagEnabled(var_17_10))

	onButton = var_1_10002

	local var_17_11 = arg_17_0
	local var_17_12 = var_17_8

	local function var_17_13()
		getProxy = var_2_10000
		TaskProxy = var_2_10002

		local var_20_0 = var_2_10000(var_2_10002)

		var_0.dealMingshiTouchFlag(var_20_0, 8)

		return
	end

	SFX_CONFIRM = var_17_10

	var_1_10002(var_17_11, var_17_12, var_17_13, var_17_10)

	ipairs = var_1_10002

	for iter_17_0, iter_17_1 in var_1_10002(arg_17_0.toggles) do
		PLATFORM_CODE = var_17_10
		PLATFORM_CH = var_1_10008

		if var_17_10 == var_1_10008 and (iter_17_0 == 1 or iter_17_0 == 3) then
			LOCK_COLLECTION = var_17_10

			if var_17_10 then
				setActive = var_17_10

				var_17_10(iter_17_1, false)

				goto label_17_0
			end
		end

		onToggle = var_17_10
		var_1_10009 = arg_17_0

		do
			local var_17_14 = iter_17_1

			local function var_17_15(arg_21_0)
				if arg_21_0 then
					if arg_17_0.contextData.toggle ~= iter_17_0 then
						if arg_17_0.contextData.toggle == var_0_1.SHIPCOLLECTION_INDEX then
							setActive = var_1

							var_1(arg_17_0.helpBtn, false)

							if arg_17_0.bulinTip then
								local var_21_0 = arg_17_0.bulinTip.buffer

								var_1.Hide(var_21_0)
							end

							if arg_17_0.contextData.cardToggle == 1 then
								arg_17_0.contextData.cardScrollValue = arg_17_0.cardList.value
							end
						end

						arg_17_0.contextData.toggle = iter_17_0

						if arg_17_0.toggleUpdates[iter_17_0] then
							arg_17_0[arg_17_0.toggleUpdates[iter_17_0]](arg_17_0)

							local var_21_1 = arg_17_0

							var_1.calFavoriteRate(var_21_1)
						end
					end

					if iter_17_0 == var_0_1.SHIPCOLLECTION_INDEX then
						setActive = var_1

						var_1(arg_17_0.helpBtn, true)

						getProxy = var_1
						SettingsProxy = var_3
						var_2_10004 = var_1(var_3)

						if not var_1.IsShowCollectionHelp(var_2_10004) then
							triggerButton = var_2

							var_2(arg_17_0.helpBtn)

							var_2_10004 = var_1

							var_1.SetCollectionHelpFlag(var_2_10004, true)
						end

						if arg_17_0.bulinTip then
							var_2_10004 = arg_17_0.bulinTip.buffer

							var_2.Show(var_2_10004)
						else
							local var_21_2 = arg_17_0

							AprilFoolBulinSubView = var_3

							local var_21_3 = var_3.ShowAprilFoolBulin
							local var_21_4 = arg_17_0
							local var_21_5 = arg_17_0._tf

							var_21_2.bulinTip = var_21_3(var_21_4, var_6.Find(var_21_5, "main"))
						end
					end

					if iter_17_0 ~= var_0_1.MUSIC_INDEX then
						local var_21_7

						if arg_17_0.musicView then
							local var_21_6 = arg_17_0.musicView

							var_21_7 = var_21_7.CheckState
							BaseSubView = var_2_10004

							if var_21_7(var_21_6, var_2_10004.STATES.INITED) then
								local var_21_8 = arg_17_0.musicView

								var_21_7.tryPauseMusic(var_21_8)

								local var_21_9 = arg_17_0.musicView

								var_21_7.closeAlbumListPanel(var_21_9)
							end
						end

						pg = var_21_7

						local var_21_10 = var_21_7.BgmMgr.GetInstance()

						var_1.ContinuePlay(var_21_10)
					elseif iter_17_0 == var_0_1.MUSIC_INDEX then
						pg = var_1

						local var_21_11 = var_1.BgmMgr.GetInstance()

						var_1.StopPlay(var_21_11)

						if arg_17_0.musicView then
							local var_21_12 = arg_17_0.musicView
							local var_21_13 = var_1.CheckState

							BaseSubView = var_2_10004

							if var_21_13(var_21_12, var_2_10004.STATES.INITED) then
								local var_21_14 = arg_17_0.musicView

								var_1.tryPlayMusic(var_21_14)
							end
						end
					end
				end

				return
			end

			SFX_UI_TAG = var_1_10012

			var_17_10(var_1_10009, var_17_14, var_17_15, var_1_10012)
		end

		::label_17_0::
	end

	ipairs = var_2

	for iter_17_2, iter_17_3 in var_2(arg_17_0.memoryToggles) do
		onToggle = var_17_10
		var_1_10009 = arg_17_0

		local var_17_16 = iter_17_3

		local function var_17_17(arg_22_0)
			if arg_22_0 then
				local var_22_0

				if iter_17_2 == 1 then
					var_22_0 = arg_17_0
					var_22_0.memoryFilterIndex = {
						true,
						true,
						true
					}
				else
					ipairs = var_22_0

					for iter_22_0 in var_22_0(arg_17_0.memoryFilterIndex) do
						arg_17_0.memoryFilterIndex[iter_22_0] = iter_17_2 - 1 == iter_22_0
					end
				end

				local var_22_1 = arg_17_0

				var_1.memoryFilter(var_22_1)
			end

			return
		end

		SFX_UI_TAG = var_1_10012

		var_17_10(var_1_10009, var_17_16, var_17_17, var_1_10012)
	end

	local var_17_18 = arg_17_0.contextData.toggle
	local var_17_19 = arg_17_0.contextData

	var_17_19.toggle = -1
	triggerToggle = var_17_19

	var_17_19(arg_17_0.toggles[var_17_18], true)

	local var_17_21

	if arg_17_0.contextData.memoryGroup then
		pg = var_17_21

		if var_17_21.memory_group[var_3] then
			local var_17_20 = arg_17_0

			var_17_21 = arg_17_0.showSubMemories
			pg = var_17_10

			var_17_21(var_17_20, var_17_10.memory_group[var_3])

			goto label_17_1
		end
	end

	triggerToggle = var_17_21

	var_17_21(arg_17_0.memoryToggles[1], true)

	::label_17_1::

	ipairs = var_17_21

	for iter_17_4, iter_17_5 in var_17_21(arg_17_0.cardToggles) do
		triggerToggle = var_1_10009

		var_1_10009(iter_17_5, arg_17_0.contextData.cardToggle == iter_17_4)

		onToggle = var_1_10009

		var_1_10009(arg_17_0, iter_17_5, function(arg_23_0)
			if arg_23_0 and arg_17_0.contextData.cardToggle ~= iter_17_4 then
				if arg_17_0.contextData.cardToggle == 1 then
					arg_17_0.contextData.cardScrollValue = arg_17_0.cardList.value
				end

				arg_17_0.contextData.cardToggle = iter_17_4

				local var_23_0 = arg_17_0

				var_1.initCardPanel(var_23_0)

				local var_23_1 = arg_17_0

				var_1.calFavoriteRate(var_23_1)
			end

			return
		end)
	end

	arg_17_0:calFavoriteRate()
	arg_17_0:OverlayPanel(arg_17_0.blurPanel)

	onButton = var_4

	local var_17_22 = arg_17_0
	local var_17_23 = arg_17_0.bonusPanel

	local function var_17_24()
		local var_24_0 = arg_17_0

		var_0.closeBonus(var_24_0)

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_17_22, var_17_23, var_17_24, var_1_10009)

	return
end

function var_0_1.updateCollectNotices(arg_25_0, arg_25_1)
	setActive = var_1_10002

	var_1_10002(arg_25_0.tip, arg_25_1)

	setActive = var_1_10002

	local var_25_0 = arg_25_0.toggles[var_0_1.GALLERY_INDEX]
	local var_25_1 = var_4.Find(var_25_0, "tip")

	getProxy = var_5
	AppreciateProxy = var_7

	local var_25_2 = var_5(var_7)

	var_1_10002(var_25_1, var_5.isGalleryHaveNewRes(var_25_2))

	setActive = var_1_10002

	local var_25_3 = arg_25_0.toggles[var_0_1.MUSIC_INDEX]
	local var_25_4 = var_4.Find(var_25_3, "tip")

	getProxy = var_5
	AppreciateProxy = var_7

	local var_25_5 = var_5(var_7)

	var_1_10002(var_25_4, var_5.isMusicHaveNewRes(var_25_5))

	setActive = var_1_10002

	local var_25_6 = arg_25_0.toggles[var_0_1.MANGA_INDEX]
	local var_25_7 = var_4.Find(var_25_6, "tip")

	getProxy = var_5
	AppreciateProxy = var_7

	local var_25_8 = var_5(var_7)

	var_1_10002(var_25_7, var_5.isMangaHaveNewRes(var_25_8))

	return
end

function var_0_1.calFavoriteRate(arg_26_0)
	local var_26_0 = arg_26_0.contextData.toggle == 1 and arg_26_0.contextData.cardToggle == 2

	setActive = var_1_10002

	local var_26_1 = arg_26_0.top

	var_1_10002(var_4.Find(var_26_1, "total/char"), not var_26_0)

	setActive = var_1_10002

	local var_26_2 = arg_26_0.top

	var_1_10002(var_4.Find(var_26_2, "total/link"), var_26_0)

	setText = var_1_10002

	local var_26_3 = arg_26_0.top

	var_1_10002(var_4.Find(var_26_3, "total/char/rate/Text"), arg_26_0.rate * 100 .. "%")

	setText = var_1_10002

	local var_26_4 = arg_26_0.top

	var_1_10002(var_4.Find(var_26_4, "total/char/count/Text"), arg_26_0.count .. "/" .. arg_26_0.totalCount)

	setText = var_1_10002

	local var_26_5 = arg_26_0.top

	var_1_10002(var_4.Find(var_26_5, "total/link/count/Text"), arg_26_0.linkCount)

	return
end

function var_0_1.initCardPanel(arg_27_0)
	local var_27_0 = arg_27_0:isDefaultStatus() and "shaixuan_off" or "shaixuan_on"

	GetSpriteFromAtlasAsync = var_1_10002

	var_1_10002("ui/share/index_atlas", var_27_0, function(arg_28_0)
		setImageSprite = var_2_10001

		var_2_10001(arg_27_0.indexBtn, arg_28_0, true)

		return
	end)

	if arg_27_0.contextData.toggle == 1 then
		setActive = var_2

		var_2(arg_27_0.cardToggleGroup, true)
		arg_27_0:cardFilter()
	elseif arg_27_0.contextData.toggle == 3 then
		setActive = var_2

		var_2(arg_27_0.cardToggleGroup, false)
		arg_27_0:transFilter()
	end

	table = var_2

	var_2.sort(arg_27_0.codeShips, function(arg_29_0, arg_29_1)
		return arg_29_0.index_id < arg_29_1.index_id
	end)

	local var_27_1 = arg_27_0.cardList
	local var_27_2 = var_2.SetTotalCount
	local var_27_3 = #arg_27_0.codeShips
	local var_27_4

	if not arg_27_0.contextData.cardScrollValue then
		var_27_4 = 0
	end

	var_27_2(var_27_1, var_27_3, var_27_4)

	return
end

function var_0_1.initIndexPanel(arg_30_0)
	local var_30_0 = arg_30_0.top

	arg_30_0.indexBtn = var_1.Find(var_30_0, "index_button")
	onButton = var_1

	local var_30_1 = arg_30_0
	local var_30_2 = arg_30_0.indexBtn

	local function var_30_3()
		Clone = var_2_10000

		local var_31_0 = var_2_10000(var_0_1.ShipIndexData)
		local var_31_1

		if arg_30_0.contextData.toggle == 1 and arg_30_0.contextData.cardToggle == 2 then
			var_31_1 = var_31_0.customPanels
			var_31_1.campIndex = nil
			var_31_1 = var_31_0.groupList
			var_31_1[2] = nil
		end

		Clone = var_31_1
		var_31_0.indexDatas = var_31_1(var_0_1.ShipIndex)

		function var_31_0.callback(arg_32_0)
			var_0_1.ShipIndex.typeIndex = arg_32_0.typeIndex

			if arg_32_0.campIndex then
				var_0_1.ShipIndex.campIndex = arg_32_0.campIndex
			end

			var_0_1.ShipIndex.rarityIndex = arg_32_0.rarityIndex
			var_0_1.ShipIndex.collExtraIndex = arg_32_0.collExtraIndex

			local var_32_0 = arg_30_0

			var_1.initCardPanel(var_32_0)

			return
		end

		local var_31_2 = arg_30_0

		var_1.emit(var_31_2, var_0_1.ON_INDEX, var_31_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_30_1, var_30_2, var_30_3, var_1_10006)

	return
end

function var_0_1.onInitCard(arg_33_0, arg_33_1)
	if arg_33_0.exited then
		return
	end

	CollectionShipCard = var_2

	local var_33_0 = var_2.New(arg_33_1)

	onButton = var_1_10003

	local var_33_1 = arg_33_0
	local var_33_2 = var_33_0.go

	local function var_33_3()
		if not arg_33_0.isClicked then
			local var_34_0 = arg_33_0

			var_34_0.isClicked = true
			LeanTween = var_34_0

			local var_34_1 = var_34_0.delayedCall
			local var_34_2 = 0.2

			System = var_2_10003

			var_34_1(var_34_2, var_2_10003.Action(function()
				arg_33_0.isClicked = false

				local var_35_0 = var_33_0

				if not var_0.getIsInited(var_35_0) then
					return
				end

				local var_35_1 = var_33_0.state

				ShipGroup = var_1

				if var_35_1 == var_1.STATE_UNLOCK then
					arg_33_0.contextData.cardScrollValue = arg_33_0.cardList.value

					local var_35_2 = arg_33_0

					var_0.emit(var_35_2, var_0_1.SHOW_DETAIL, var_33_0.showTrans, var_33_0.shipGroup.id)
				else
					local var_35_3 = var_33_0.state

					ShipGroup = var_1

					if var_35_3 == var_1.STATE_NOTGET then
						if var_33_0.showTrans == true and var_33_0.shipGroup.trans == true then
							return
						end

						if var_33_0.config then
							local var_35_4 = arg_33_0
							local var_35_5 = var_0.showObtain
							local var_35_6 = var_33_0.config.description
							local var_35_7 = var_33_0.shipGroup

							var_35_5(var_35_4, var_35_6, var_4.getShipConfigId(var_35_7))
						end
					end
				end

				return
			end))
		end

		return
	end

	SOUND_BACK = var_1_10008

	var_1_10003(var_33_1, var_33_2, var_33_3, var_1_10008)

	arg_33_0.cardItems[arg_33_1] = var_33_0

	return
end

function var_0_1.showObtain(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = {}

	MSGBOX_TYPE_OBTAIN = var_1_10004
	var_36_0.type = var_1_10004
	var_36_0.shipId = arg_36_2
	var_36_0.list = arg_36_1
	CollectionMediator = var_1_10004
	var_36_0.mediatorName = var_1_10004.__cname
	PLATFORM_CODE = var_4
	PLATFORM_CH = var_1_10005

	if var_4 == var_1_10005 then
		HXSet = var_4

		if var_4.isHx() then
			var_36_0.unknown_small = true
		end
	end

	local var_36_1 = arg_36_0.contextData

	var_36_1.cardScrollValue = arg_36_0.cardList.value
	pg = var_36_1

	local var_36_2 = var_36_1.MsgboxMgr.GetInstance()

	var_4.ShowMsgBox(var_36_2, var_36_0)

	return
end

function var_0_1.skipIn(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_0.contextData

	var_37_0.displayGroupId = arg_37_2
	triggerToggle = var_37_0

	var_37_0(arg_37_0.toggles[arg_37_1], true)

	return
end

function var_0_1.onUpdateCard(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_0.exited then
		return
	end

	local var_38_0

	if not arg_38_0.cardItems[arg_38_2] then
		arg_38_0:onInitCard(arg_38_2)

		var_38_0 = arg_38_0.cardItems[arg_38_2]
	end

	local var_38_1 = arg_38_1 + 1

	if not arg_38_0.codeShips[var_38_1] then
		return
	end

	local var_38_2 = false

	if var_5.group then
		var_38_2 = arg_38_0.proposeList[var_5.group.id]
	end

	var_38_0:update(var_5.code, var_5.group, var_5.showTrans, var_38_2, var_5.id)

	return
end

function var_0_1.onReturnCard(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_0.exited then
		return
	end

	if arg_39_0.cardItems[arg_39_2] then
		var_3:clear()
	end

	return
end

function var_0_1.cardFilter(arg_40_0)
	arg_40_0.codeShips = {}
	_ = var_1

	local var_40_0 = var_1.filter

	pg = var_1_10003

	local var_40_1 = var_40_0(var_1_10003.ship_data_group.all, function(arg_41_0)
		pg = var_2_10001

		return var_2_10001.ship_data_group[arg_41_0].handbook_type == arg_40_0.contextData.cardToggle - 1
	end)

	table = var_1_10002

	var_1_10002.sort(var_40_1)

	ipairs = var_2

	for iter_40_0, iter_40_1 in var_2(var_40_1) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.ship_data_group[iter_40_1]

		local var_40_2

		if not arg_40_0.shipGroups[var_1_10007.group_type] then
			ShipGroup = var_40_2
			var_40_2 = var_40_2.New({
				id = var_1_10007.group_type
			})
		end

		ShipIndexConst = var_9

		if var_9.filterByType(var_40_2, var_0_1.ShipIndex.typeIndex) then
			if arg_40_0.contextData.cardToggle ~= 2 then
				ShipIndexConst = var_9

				if var_9.filterByCamp(var_40_2, var_0_1.ShipIndex.campIndex) then
					local var_40_3 = arg_40_0.contextData.cardToggle == 4

					Nation = var_1_10010
					var_1_10010 = var_1_10010.IsMeta
					ShipGroup = var_12

					if var_40_3 == var_1_10010(var_12.getDefaultShipConfig(var_1_10007.group_type).nationality) then
						ShipIndexConst = var_40_3

						if var_40_3.filterByRarity(var_40_2, var_0_1.ShipIndex.rarityIndex) then
							ShipIndexConst = var_9

							if var_9.filterByCollExtra(var_40_2, var_0_1.ShipIndex.collExtraIndex) then
								arg_40_0.codeShips[#arg_40_0.codeShips + 1] = {
									showTrans = false,
									id = iter_40_1,
									code = iter_40_1 - (arg_40_0.contextData.cardToggle - 1) * 16,
									group = arg_40_0.shipGroups[var_1_10007.group_type],
									index_id = var_1_10007.index_id
								}
							end
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.transFilter(arg_42_0)
	arg_42_0.codeShips = {}
	_ = var_1

	local var_42_0 = var_1.filter

	pg = var_1_10003

	local var_42_1 = var_42_0(var_1_10003.ship_data_group.all, function(arg_43_0)
		pg = var_2_10001

		return var_2_10001.ship_data_group[arg_43_0].handbook_type == 0
	end)

	table = var_1_10002

	var_1_10002.sort(var_42_1)

	ipairs = var_2

	for iter_42_0, iter_42_1 in var_2(var_42_1) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.ship_data_group[iter_42_1]
		pg = var_1_10008

		if var_1_10008.ship_data_trans[var_1_10007.group_type] then
			if not arg_42_0.shipGroups[var_1_10007.group_type] then
				ShipGroup = var_1_10008
				var_1_10008 = var_1_10008.New({
					remoulded = true,
					id = var_1_10007.group_type
				})
			end

			ShipIndexConst = var_9

			if var_9.filterByType(var_1_10008, var_0_1.ShipIndex.typeIndex) then
				ShipIndexConst = var_9

				if var_9.filterByCamp(var_1_10008, var_0_1.ShipIndex.campIndex) then
					ShipIndexConst = var_9

					if var_9.filterByRarity(var_1_10008, var_0_1.ShipIndex.rarityIndex) then
						ShipIndexConst = var_9

						if var_9.filterByCollExtra(var_1_10008, var_0_1.ShipIndex.collExtraIndex) then
							arg_42_0.codeShips[#arg_42_0.codeShips + 1] = {
								showTrans = true,
								id = iter_42_1,
								code = 3000 + iter_42_1,
								group = var_1_10008.trans and var_1_10008 or nil,
								index_id = var_1_10007.index_id
							}
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.sortDisplay(arg_44_0)
	table = var_1_10001

	var_1_10001.sort(arg_44_0.favoriteVOs, function(arg_45_0, arg_45_1)
		if arg_45_0:getState(arg_44_0.shipGroups, arg_44_0.awards) == arg_45_1:getState(arg_44_0.shipGroups, arg_44_0.awards) then
			return arg_45_0.id < arg_45_1.id
		else
			return var_2 < var_3
		end

		return
	end)

	local var_44_0 = 0
	local var_44_1 = arg_44_0.contextData.displayGroupId

	ipairs = var_3

	for iter_44_0, iter_44_1 in var_3(arg_44_0.favoriteVOs) do
		if iter_44_1:containShipGroup(var_44_1) then
			var_44_0 = iter_44_0

			break
		end
	end

	local var_44_2 = arg_44_0.displayRect
	local var_44_3 = var_3.SetTotalCount
	local var_44_4 = #arg_44_0.favoriteVOs
	local var_44_5 = arg_44_0.displayRect

	var_44_3(var_44_2, var_44_4, var_7.HeadIndexToValue(var_44_5, var_44_0 - 1))

	return
end

function var_0_1.initDisplayPanel(arg_46_0)
	if not arg_46_0.isInitDisplay then
		arg_46_0.isInitDisplay = true

		local var_46_0 = arg_46_0._tf
		local var_46_1 = var_1.Find(var_46_0, "main/list_display")

		arg_46_0.displayRect = var_1.GetComponent(var_46_1, "LScrollRect")
		arg_46_0.displayRect.decelerationRate = 0.07

		function arg_46_0.displayRect.onInitItem(arg_47_0)
			local var_47_0 = arg_46_0

			var_1.initFavoriteCard(var_47_0, arg_47_0)

			return
		end

		function arg_46_0.displayRect.onUpdateItem(arg_48_0, arg_48_1)
			local var_48_0 = arg_46_0

			var_2.updateFavoriteCard(var_48_0, arg_48_0, arg_48_1)

			return
		end

		arg_46_0.favoriteCards = {}
	end

	arg_46_0:sortDisplay()

	return
end

function var_0_1.initFavoriteCard(arg_49_0, arg_49_1)
	if arg_49_0.exited then
		return
	end

	FavoriteCard = var_2

	local var_49_0 = var_2.New(arg_49_1, arg_49_0.charTpl)

	onButton = var_1_10003

	local var_49_1 = arg_49_0
	local var_49_2 = var_49_0.awardTF

	local function var_49_3()
		local var_50_0 = var_49_0.state

		Favorite = var_2_10001

		if var_50_0 == var_2_10001.STATE_AWARD then
			local var_50_1 = arg_49_0
			local var_50_2 = var_0.emit

			var_2_10003 = var_0_1.GET_AWARD

			local var_50_3 = var_49_0.favoriteVO.id
			local var_50_4 = var_49_0.favoriteVO

			var_50_2(var_50_1, var_2_10003, var_50_3, var_5.getNextAwardIndex(var_50_4, var_49_0.awards))
		else
			local var_50_5 = var_49_0.state

			Favorite = var_1

			if var_50_5 == var_1.STATE_LOCK then
				pg = var_50_5

				local var_50_6 = var_50_5.TipsMgr.GetInstance()
				local var_50_7 = var_0.ShowTips

				i18n = var_2_10003

				var_50_7(var_50_6, var_2_10003("collection_lock"))
			else
				local var_50_8 = var_49_0.state

				Favorite = var_1

				if var_50_8 == var_1.STATE_FETCHED then
					pg = var_50_8

					local var_50_9 = var_50_8.TipsMgr.GetInstance()
					local var_50_10 = var_0.ShowTips

					i18n = var_2_10003

					var_50_10(var_50_9, var_2_10003("collection_fetched"))
				else
					local var_50_11 = var_49_0.state

					Favorite = var_1

					if var_50_11 == var_1.STATE_STATE_WAIT then
						pg = var_50_11

						local var_50_12 = var_50_11.TipsMgr.GetInstance()
						local var_50_13 = var_0.ShowTips

						i18n = var_2_10003

						var_50_13(var_50_12, var_2_10003("collection_nostar"))
					end
				end
			end
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_49_1, var_49_2, var_49_3, var_1_10008)

	onButton = var_1_10003

	local var_49_4 = arg_49_0
	local var_49_5 = var_49_0.box

	local function var_49_6()
		local var_51_0 = arg_49_0

		var_0.openBonus(var_51_0, var_49_0.favoriteVO)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_49_4, var_49_5, var_49_6, var_1_10008)

	arg_49_0.favoriteCards[arg_49_1] = var_49_0

	return
end

function var_0_1.updateFavoriteCard(arg_52_0, arg_52_1, arg_52_2)
	if arg_52_0.exited then
		return
	end

	local var_52_0

	if not arg_52_0.favoriteCards[arg_52_2] then
		arg_52_0:initFavoriteCard(arg_52_2)

		var_52_0 = arg_52_0.favoriteCards[arg_52_2]
	end

	local var_52_1 = arg_52_0.favoriteVOs[arg_52_1 + 1]

	var_52_0:update(var_52_1, arg_52_0.shipGroups, arg_52_0.awards)

	return
end

function var_0_1.openBonus(arg_53_0, arg_53_1)
	local var_53_1

	if not arg_53_0.isInitBound then
		arg_53_0.isInitBound = true
		findTF = var_53_1

		local var_53_0 = var_53_1(arg_53_0.bonusPanel, "frame/name/Text")

		var_53_1 = var_53_1.GetComponent
		typeof = var_5
		Text = var_1_10007
		arg_53_0.boundName = var_53_1(var_53_0, var_5(var_1_10007))
		findTF = var_53_1

		local var_53_2 = var_53_1(arg_53_0.bonusPanel, "frame/process")

		var_53_1 = var_53_1.GetComponent
		typeof = var_5
		Slider = var_1_10007
		arg_53_0.progressSlider = var_53_1(var_53_2, var_5(var_1_10007))
	end

	pg = var_53_1

	local var_53_3 = var_53_1.UIMgr.GetInstance()

	var_2.BlurPanel(var_53_3, arg_53_0.bonusPanel)

	setActive = var_2

	var_2(arg_53_0.bonusPanel, true)

	arg_53_0.boundName.text = arg_53_1:getConfig("name")

	local var_53_4 = arg_53_1
	local var_53_5 = arg_53_1.getConfig(var_53_4, "award_display")
	local var_53_6 = arg_53_1:getConfig("level")

	ipairs = var_53_4

	for iter_53_0, iter_53_1 in var_53_4(var_53_6) do
		local var_53_7 = var_53_5[iter_53_0]

		findTF = var_1_10010
		var_1_10010 = var_1_10010(arg_53_0.bonusPanel, "frame/awards/award" .. iter_53_0)
		setText = var_1_10011
		findTF = var_13

		var_1_10011(var_13(var_1_10010, "process"), iter_53_1)

		var_1_10011 = arg_53_1:getAwardState(arg_53_0.shipGroups, arg_53_0.awards, iter_53_0)
		setActive = var_53_14
		findTF = var_14

		local var_53_8 = var_14(var_1_10010, "item_tpl/unfinish")

		Favorite = var_15

		var_53_14(var_53_8, var_1_10011 == var_15.STATE_WAIT)

		setActive = var_53_14
		findTF = var_53_8

		local var_53_9 = var_53_8(var_1_10010, "item_tpl/get")

		Favorite = var_15

		var_53_14(var_53_9, var_1_10011 == var_15.STATE_AWARD)

		setActive = var_53_14
		findTF = var_53_9

		local var_53_10 = var_53_9(var_1_10010, "item_tpl/got")

		Favorite = var_15

		var_53_14(var_53_10, var_1_10011 == var_15.STATE_FETCHED)

		setActive = var_53_14
		findTF = var_53_10

		local var_53_11 = var_53_10(var_1_10010, "item_tpl/lock")

		Favorite = var_15

		var_53_14(var_53_11, var_1_10011 == var_15.STATE_LOCK)

		setActive = var_53_14
		findTF = var_53_11

		local var_53_12 = var_53_11(var_1_10010, "item_tpl/icon_bg")

		Favorite = var_15

		var_53_14(var_53_12, var_1_10011 ~= var_15.STATE_LOCK)

		setActive = var_53_14
		findTF = var_53_12

		local var_53_13 = var_53_12(var_1_10010, "item_tpl/bg")

		Favorite = var_15

		var_53_14(var_53_13, var_1_10011 ~= var_15.STATE_LOCK)

		local var_53_14, var_53_15, var_53_17

		if var_53_7 then
			var_53_14 = {
				count = 0,
				type = var_53_7[1],
				id = var_53_7[2]
			}
			updateDrop = var_13
			findTF = var_53_15

			var_13(var_53_15(var_1_10010, "item_tpl"), var_53_14)

			var_53_14.count = var_53_7[3]
			onButton = var_13
			var_53_15 = arg_53_0

			local var_53_16 = var_1_10010

			function var_53_17()
				local var_54_0 = arg_53_0

				var_0.emit(var_54_0, var_0_1.ON_DROP, var_53_14)

				return
			end

			SFX_PANEL = var_18

			var_13(var_53_15, var_53_16, var_53_17, var_18)
		else
			GetOrAddComponent = var_53_14

			local var_53_18 = var_1_10010

			typeof = var_53_15
			Button = var_53_17

			local var_53_19 = var_53_14(var_53_18, var_53_15(var_53_17)).onClick

			var_13.RemoveAllListeners(var_53_19)
		end
	end

	local var_53_20 = arg_53_1:getStarCount(arg_53_0.shipGroups)

	arg_53_0.progressSlider.value = var_53_20 / var_53_6[#var_53_6]

	return
end

function var_0_1.closeBonus(arg_55_0)
	pg = var_1_10001

	local var_55_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_55_0, arg_55_0.bonusPanel, arg_55_0._tf)

	setActive = var_1

	var_1(arg_55_0.bonusPanel, false)

	return
end

function var_0_1.showSubMemories(arg_56_0, arg_56_1)
	local var_56_0 = arg_56_0.contextData

	var_56_0.memoryGroup = arg_56_1.id
	_ = var_56_0
	arg_56_0.memories = var_56_0.map(arg_56_1.memories, function(arg_57_0)
		pg = var_2_10001

		return var_2_10001.memory_template[arg_57_0]
	end)
	ipairs = var_2

	for iter_56_0 in var_2(arg_56_0.memories) do
		arg_56_0.memories[iter_56_0].index = iter_56_0
	end

	local var_56_1 = arg_56_0.memoryList

	var_2.SetTotalCount(var_56_1, #arg_56_0.memories, 0)

	setActive = var_2

	local var_56_2 = arg_56_0.top

	var_2(var_4.Find(var_56_2, "memory"), false)

	return
end

local var_0_9 = 3

function var_0_1.return2MemoryGroup(arg_58_0)
	local var_58_0 = arg_58_0.contextData.memoryGroup

	arg_58_0.contextData.memoryGroup = nil
	arg_58_0.memories = nil

	local var_58_1 = 0

	if var_58_0 then
		local var_58_2 = 0

		ipairs = var_1_10004

		for iter_58_0, iter_58_1 in var_1_10004(arg_58_0.memoryGroups) do
			if iter_58_1.id == var_58_0 then
				var_58_2 = iter_58_0

				break
			end
		end

		if var_58_2 >= 0 then
			local var_58_3 = arg_58_0.memoryList
			local var_58_4 = arg_58_0.memoriesGrid.cellSize.y + arg_58_0.memoriesGrid.spacing.y

			math = var_6

			local var_58_5 = var_58_4 * var_6.ceil(#arg_58_0.memoryGroups / var_0_9)

			math = iter_58_0
			var_58_1 = (var_58_4 * iter_58_0.floor((var_58_2 - 1) / var_0_9) + var_58_3.paddingFront) / (var_58_5 - arg_58_0.memoryViewport.rect.height)
			Mathf = var_7
			var_58_1 = var_7.Clamp01(var_58_1)
		end
	end

	local var_58_6 = arg_58_0.memoryList

	var_3.SetTotalCount(var_58_6, #arg_58_0.memoryGroups, var_58_1)

	setActive = var_3

	local var_58_7 = arg_58_0.top

	var_3(var_5.Find(var_58_7, "memory"), true)

	return
end

function var_0_1.initMemoryPanel(arg_59_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_59_0 = var_1_10001(var_1_10003)
	local var_59_1 = var_1.getActivityById

	ActivityConst = var_1_10005

	if var_59_1(var_59_0, var_1_10005.QIXI_ACTIVITY_ID) and not var_2:isEnd() then
		local var_59_2 = var_2:getConfig("config_data")

		_ = var_59_0

		local var_59_3 = var_4[#var_59_0.flatten(var_59_2)]

		getProxy = var_6
		TaskProxy = var_1_10008

		local var_59_4 = var_6(var_1_10008)

		if var_6.getTaskById(var_59_4, var_59_3) and not var_7:isFinish() then
			pg = var_8

			local var_59_5 = var_8.NewStoryMgr.GetInstance()

			var_8.Play(var_59_5, "HOSHO8", function()
				local var_60_0 = arg_59_0
				local var_60_1 = var_0.emit

				CollectionScene = var_2_10003

				var_60_1(var_60_0, var_2_10003.ACTIVITY_OP, {
					cmd = 2,
					activity_id = var_0.id
				})

				return
			end, true)
		end
	end

	arg_59_0:memoryFilter()

	return
end

function var_0_1.onInitMemory(arg_61_0, arg_61_1)
	if arg_61_0.exited then
		return
	end

	MemoryCard = var_2

	local var_61_0 = var_2.New(arg_61_1)

	onButton = var_1_10003

	local var_61_1 = arg_61_0
	local var_61_2 = var_61_0.go

	local function var_61_3()
		if var_61_0.info then
			if var_61_0.isGroup then
				local var_62_0 = arg_61_0

				var_0.showSubMemories(var_62_0, var_61_0.info)

				goto label_62_0
			end

			if var_61_0.info.is_open ~= 1 then
				pg = var_0

				do
					local var_62_1 = var_0.NewStoryMgr.GetInstance()

					if var_0.IsPlayed(var_62_1, var_61_0.info.unlock_pre, true) then
						local var_62_2 = arg_61_0

						var_0.playMemory(var_62_2, var_61_0.info)
					end
				end

				::label_62_0::

				return
			end
		end
	end

	SOUND_BACK = var_1_10008

	var_1_10003(var_61_1, var_61_2, var_61_3, var_1_10008)

	arg_61_0.memoryItems[arg_61_1] = var_61_0

	return
end

function var_0_1.onUpdateMemory(arg_63_0, arg_63_1, arg_63_2)
	if arg_63_0.exited then
		return
	end

	local var_63_0

	if not arg_63_0.memoryItems[arg_63_2] then
		arg_63_0:onInitMemory(arg_63_2)

		var_63_0 = arg_63_0.memoryItems[arg_63_2]
	end

	if arg_63_0.memories then
		var_63_0:update(false, arg_63_0.memories[arg_63_1 + 1])
	else
		var_63_0:update(true, arg_63_0.memoryGroups[arg_63_1 + 1])
	end

	local var_63_1 = {
		var_63_0.lock,
		var_63_0.normal,
		var_63_0.group
	}

	_ = var_5

	var_5.any(var_63_1, function(arg_64_0)
		isActive = var_2_10001

		if var_2_10001(arg_64_0) then
			local var_64_0 = var_63_0.go
			local var_64_1 = var_2.GetComponent

			typeof = var_2_10005
			Button = var_2_10007

			local var_64_2 = var_64_1(var_64_0, var_2_10005(var_2_10007))
			local var_64_3 = arg_64_0
			local var_64_4 = arg_64_0.GetComponent

			typeof = var_2_10006
			Image = var_2_10008
			var_64_2.targetGraphic = var_64_4(var_64_3, var_2_10006(var_2_10008))
		end

		return var_1
	end)

	return
end

function var_0_1.onReturnMemory(arg_65_0, arg_65_1, arg_65_2)
	if arg_65_0.exited then
		return
	end

	if arg_65_0.memoryItems[arg_65_2] then
		var_3:clear()
	end

	return
end

function var_0_1.playMemory(arg_66_0, arg_66_1)
	if arg_66_1.type == 1 then
		findTF = var_2

		local var_66_0 = var_2(arg_66_0.memoryMask, "pic")

		string = var_1_10003

		local var_66_1 = var_1_10003.len(arg_66_1.mask)

		if 0 < var_66_1 then
			setActive = var_66_1

			var_66_1(var_66_0, true)

			local var_66_2 = var_66_0

			var_66_1 = var_66_0.GetComponent
			typeof = var_6
			Image = var_1_10008
			var_66_1 = var_66_1(var_66_2, var_6(var_1_10008))
			LoadSprite = var_4
			var_66_1.sprite = var_4(arg_66_1.mask)
		else
			setActive = var_66_1

			var_66_1(var_66_0, false)
		end

		setActive = var_66_1

		var_66_1(arg_66_0.memoryMask, true)

		pg = var_66_1

		local var_66_3 = var_66_1.NewStoryMgr.GetInstance()

		var_3.Play(var_66_3, arg_66_1.story, function()
			setActive = var_2_10000

			var_2_10000(arg_66_0.memoryMask, false)

			return
		end, true)
	elseif arg_66_1.type == 2 then
		pg = var_2

		local var_66_4 = var_2.NewStoryMgr.GetInstance()
		local var_66_5 = var_2.StoryName2StoryId(var_66_4, arg_66_1.story)
		local var_66_6 = arg_66_0
		local var_66_7 = arg_66_0.emit
		local var_66_8 = var_0_1.BEGIN_STAGE
		local var_66_9 = {
			memory = true
		}

		SYSTEM_PERFORM = var_1_10008
		var_66_9.system = var_1_10008
		var_66_9.stageId = var_66_5

		var_66_7(var_66_6, var_66_8, var_66_9)
	end

	return
end

function var_0_1.memoryFilter(arg_68_0)
	arg_68_0.memoryGroups = {}
	ipairs = var_1
	pg = var_1_10003

	for iter_68_0, iter_68_1 in var_1(var_1_10003.memory_group.all) do
		pg = var_1_10006
		var_1_10006 = var_1_10006.memory_group[iter_68_1]

		if arg_68_0.memoryFilterIndex[var_1_10006.type] then
			table = var_7

			var_7.insert(arg_68_0.memoryGroups, var_1_10006)
		end
	end

	table = var_1

	var_1.sort(arg_68_0.memoryGroups, function(arg_69_0, arg_69_1)
		return arg_69_0.id < arg_69_1.id
	end)

	local var_68_0 = arg_68_0.memoryList

	var_1.SetTotalCount(var_68_0, #arg_68_0.memoryGroups, 0)

	return
end

function var_0_1.willExit(arg_70_0)
	if arg_70_0.bulinTip then
		local var_70_0 = arg_70_0.bulinTip

		var_1.Destroy(var_70_0)

		arg_70_0.bulinTip = nil
	end

	if arg_70_0.tweens then
		cancelTweens = var_1

		var_1(arg_70_0.tweens)
	end

	arg_70_0:UnOverlayPanel(arg_70_0.blurPanel, arg_70_0._tf)

	if arg_70_0.bonusPanel.gameObject.activeSelf then
		arg_70_0:closeBonus()
	end

	Destroy = var_1

	var_1(arg_70_0.bonusPanel)

	arg_70_0.bonusPanel = nil
	pairs = var_1

	for iter_70_0, iter_70_1 in var_1(arg_70_0.cardItems) do
		iter_70_1:clear()
	end

	if arg_70_0.resPanel then
		local var_70_1 = arg_70_0.resPanel

		var_1.exit(var_70_1)

		arg_70_0.resPanel = nil
	end

	if arg_70_0.galleryView then
		local var_70_2 = arg_70_0.galleryView

		var_1.Destroy(var_70_2)

		arg_70_0.galleryView = nil
	end

	if arg_70_0.musicView then
		local var_70_3 = arg_70_0.musicView

		var_1.Destroy(var_70_3)

		arg_70_0.musicView = nil
	end

	if arg_70_0.mangaView then
		local var_70_4 = arg_70_0.mangaView

		var_1.Destroy(var_70_4)

		arg_70_0.mangaView = nil
	end

	return
end

function var_0_1.initGalleryPanel(arg_71_0)
	if not arg_71_0.galleryView then
		GalleryView = var_1
		arg_71_0.galleryView = var_1.New(arg_71_0.galleryPanelContainer, arg_71_0.event, arg_71_0.contextData)

		local var_71_0 = arg_71_0.galleryView

		var_1.RegisterView(var_71_0, arg_71_0)

		local var_71_1 = arg_71_0.galleryView

		var_1.Reset(var_71_1)

		local var_71_2 = arg_71_0.galleryView

		var_1.Load(var_71_2)
	end

	return
end

function var_0_1.initMusicPanel(arg_72_0)
	if not arg_72_0.musicView then
		MusicCollectionView = var_1
		arg_72_0.musicView = var_1.New(arg_72_0.musicPanelContainer, arg_72_0.event, arg_72_0.contextData)

		local var_72_0 = arg_72_0.musicView

		var_1.Reset(var_72_0)

		local var_72_1 = arg_72_0.musicView

		var_1.Load(var_72_1)

		pg = var_1

		local var_72_2 = var_1.CriMgr.GetInstance()

		var_1.StopBGM(var_72_2)
	end

	return
end

function var_0_1.initMangaPanel(arg_73_0)
	if not arg_73_0.mangaView then
		MangaView = var_1
		arg_73_0.mangaView = var_1.New(arg_73_0.mangaPanelContainer, arg_73_0.event, arg_73_0.contextData)

		local var_73_0 = arg_73_0.mangaView

		var_1.Reset(var_73_0)

		local var_73_1 = arg_73_0.mangaView

		var_1.Load(var_73_1)
	end

	return
end

function var_0_1.initEvents(arg_74_0)
	arg_74_0:bind(var_0_1.UPDATE_RED_POINT, function()
		local var_75_0 = arg_74_0

		var_0.updateCollectNotices(var_75_0)

		return
	end)

	return
end

function var_0_1.onBackPressed(arg_76_0)
	pg = var_1_10001

	local var_76_0 = var_1_10001.CriMgr.GetInstance()
	local var_76_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_76_1(var_76_0, var_1_10004)

	if arg_76_0.bonusPanel.gameObject.activeSelf then
		arg_76_0:closeBonus()

		return
	end

	if arg_76_0.galleryView then
		local var_76_2 = arg_76_0.galleryView

		if var_1.onBackPressed(var_76_2) == true then
			local var_76_3 = arg_76_0.galleryView

			var_2.Destroy(var_76_3)

			arg_76_0.galleryView = nil
		else
			return
		end
	end

	if arg_76_0.musicView then
		local var_76_4 = arg_76_0.musicView

		if var_1.onBackPressed(var_76_4) == true then
			local var_76_5 = arg_76_0.musicView

			var_2.Destroy(var_76_5)

			arg_76_0.musicView = nil
		else
			return
		end
	end

	if arg_76_0.mangaView then
		local var_76_6 = arg_76_0.mangaView

		if var_1.onBackPressed(var_76_6) == true then
			local var_76_7 = arg_76_0.mangaView

			var_2.Destroy(var_76_7)

			arg_76_0.mangaView = nil
		else
			return
		end
	end

	triggerButton = var_1

	var_1(arg_76_0.backBtn)

	return
end

return var_0_1

class = var_0_10000

local var_0_0 = "MusicCollectionView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "MusicCollectionUI"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()
	arg_2_0:initPlateListPanel()
	arg_2_0:Show()
	arg_2_0:recoverRunData()
	arg_2_0:tryShowTipMsgBox()

	return
end

function var_0_1.OnDestroy(arg_3_0)
	local var_3_0 = arg_3_0.bgmMgr

	var_1.UnregisterMusicCallback(var_3_0, arg_3_0.__cname)

	local var_3_1 = arg_3_0.resLoader

	var_1.Clear(var_3_1)
	arg_3_0:closeAlbumListPanel(true)

	return
end

function var_0_1.onBackPressed(arg_4_0)
	isActive = var_1_10001

	if var_1_10001(arg_4_0.albumListPanel) then
		arg_4_0:closeAlbumListPanel()

		return false
	else
		return true
	end

	return
end

function var_0_1.initData(arg_5_0)
	pg = var_1_10001
	arg_5_0.bgmMgr = var_1_10001.BgmMgr.GetInstance()
	getProxy = var_1
	AppreciateProxy = var_1_10002
	arg_5_0.appreciateProxy = var_1(var_1_10002)
	underscore = var_1

	local var_5_0 = var_1.to_array

	pg = var_1_10002
	arg_5_0.albumNames = var_5_0(var_1_10002.music_album.all)
	table = var_1

	local var_5_1 = var_1.sort
	local var_5_2 = arg_5_0.albumNames

	CompareFuncs = var_1_10003

	var_5_1(var_5_2, var_1_10003({
		function(arg_6_0)
			pg = var_2_10001

			return -var_2_10001.music_album[arg_6_0].order
		end
	}))

	underscore = var_5_1
	arg_5_0.albumNames = var_5_1.map(arg_5_0.albumNames, function(arg_7_0)
		pg = var_2_10001

		return var_2_10001.music_album[arg_7_0].album_name
	end)
	arg_5_0.plateTFList = {}
	arg_5_0.albumTFList = {}
	arg_5_0.likeDic = {}
	arg_5_0.likeIds = {}
	arg_5_0.curMidddleIndex = 1
	arg_5_0.isPlayingAni = false
	AutoLoader = var_1
	arg_5_0.resLoader = var_1.New()

	return
end

function var_0_1.saveRunData(arg_8_0)
	local var_8_0 = arg_8_0.appreciateProxy

	var_1.updateMusicRunData(var_8_0, arg_8_0.sortValue, arg_8_0.curMidddleIndex, arg_8_0.likeValue)

	return
end

function var_0_1.recoverRunData(arg_9_0)
	local var_9_0 = arg_9_0.appreciateProxy

	arg_9_0.sortValue = var_1.getMusicRunData(var_9_0).sortValue
	arg_9_0.curMidddleIndex = var_1.middleIndex
	arg_9_0.likeValue = var_1.likeValue
	arg_9_0.albumSortValue = "asc"

	local var_9_1 = arg_9_0.appreciateProxy

	arg_9_0.likeIds = var_2.getAlbumMusicList(var_9_1, "favor")
	ipairs = var_2

	for iter_9_0, iter_9_1 in var_2(arg_9_0.likeIds) do
		arg_9_0.likeDic[iter_9_1] = true
	end

	arg_9_0.lScrollPageSC.MiddleIndexOnInit = arg_9_0.curMidddleIndex - 1

	local var_9_2 = arg_9_0

	arg_9_0.updatePlateListPanel(var_9_2)

	getProxy = var_2
	AppreciateProxy = var_9_2

	local var_9_3 = var_2(var_9_2)

	if var_2.CanPlayMainMusicPlayer(var_9_3) then
		local var_9_4 = arg_9_0
		local var_9_5 = arg_9_0.NewMusicPlayer
		local var_9_6 = arg_9_0.appreciateProxy

		var_9_5(var_9_4, var_4.getMainPlayerAlbumName(var_9_6))
	else
		arg_9_0:NewMusicPlayer(arg_9_0.tempPlateList[arg_9_0.curMidddleIndex])
	end

	local var_9_7 = arg_9_0.bgmMgr

	var_2.RegisterMusicCallback(var_9_7, arg_9_0.__cname, "TempMusicPlayer", {
		startCall = function(arg_10_0)
			if arg_9_0.plateTFList[arg_9_0.curMidddleIndex] then
				local var_10_0 = arg_9_0

				var_1.updatePlateList(var_10_0, arg_9_0.plateTFList[arg_9_0.curMidddleIndex], arg_9_0.curMidddleIndex)
			end

			local var_10_1 = arg_9_0

			var_1.updateAlbumListPanel(var_10_1)

			local var_10_2 = arg_9_0

			var_1.updatePlayPanel(var_10_2, arg_10_0)

			return
		end,
		progressCall = function(arg_11_0)
			if arg_9_0.onDrag then
				return
			end

			local var_11_0 = arg_9_0

			var_1.updatePlayProgress(var_11_0, arg_11_0)

			return
		end,
		noPlayCall = function()
			local var_12_0 = arg_9_0

			var_0.NewMusicPlayer(var_12_0, arg_9_0.tempPlateList[arg_9_0.curMidddleIndex])

			return
		end
	})
	arg_9_0:updateAlbumListPanel()
	arg_9_0:updateLikeToggle()
	arg_9_0:updatePlayType()

	return
end

function var_0_1.findUI(arg_13_0)
	setLocalPosition = var_1_10001

	local var_13_0 = arg_13_0._tf

	Vector2 = var_1_10003

	var_1_10001(var_13_0, var_1_10003.zero)

	local var_13_1 = arg_13_0._tf

	Vector2 = var_13_0
	var_13_1.anchorMin = var_13_0.zero

	local var_13_2 = arg_13_0._tf

	Vector2 = var_2
	var_13_2.anchorMax = var_2.one

	local var_13_3 = arg_13_0._tf

	Vector2 = var_2
	var_13_3.offsetMax = var_2.zero

	local var_13_4 = arg_13_0._tf

	Vector2 = var_2
	var_13_4.offsetMin = var_2.zero

	local var_13_5 = arg_13_0._tf

	arg_13_0.topPanel = var_1.Find(var_13_5, "TopPanel")

	local var_13_6 = arg_13_0.topPanel

	arg_13_0.likeFilteToggle = var_1.Find(var_13_6, "LikeBtn")
	setActive = var_1

	var_1(arg_13_0.likeFilteToggle, true)

	local var_13_7 = arg_13_0.topPanel

	arg_13_0.serchInputText = var_1.Find(var_13_7, "serch")
	setText = var_1

	local var_13_8 = arg_13_0.serchInputText
	local var_13_9 = var_2.Find(var_13_8, "Placeholder")

	i18n = var_13_8

	var_1(var_13_9, var_13_8("NewMusic_2"))

	local var_13_10 = arg_13_0._tf

	arg_13_0.plateListPanel = var_1.Find(var_13_10, "PlateList")

	local var_13_11 = arg_13_0.plateListPanel

	arg_13_0.plateTpl = var_1.Find(var_13_11, "Plate")
	setActive = var_1

	var_1(arg_13_0.plateTpl, false)

	setText = var_1

	local var_13_12 = arg_13_0.plateTpl
	local var_13_13 = var_2.Find(var_13_12, "list/panel/view/empty/icon/Text")

	i18n = var_13_12

	var_1(var_13_13, var_13_12("NewMusic_3"))

	GetComponent = var_1
	arg_13_0.lScrollPageSC = var_1(arg_13_0.plateListPanel, "LScrollPage")

	local var_13_14 = arg_13_0._tf

	arg_13_0.playPanel = var_1.Find(var_13_14, "PLayPanel")

	local var_13_15 = arg_13_0.playPanel

	arg_13_0.playPanelNameText = var_1.Find(var_13_15, "NameText")

	local var_13_16 = arg_13_0.playPanel

	arg_13_0.likeToggle = var_1.Find(var_13_16, "LikeBtn")

	local var_13_17 = arg_13_0.likeToggle

	arg_13_0.likeOnImg = var_1.Find(var_13_17, "On")

	local var_13_18 = arg_13_0.playPanel

	arg_13_0.songImg = var_1.Find(var_13_18, "SongImg/face")

	local var_13_19 = arg_13_0.playPanel

	arg_13_0.pauseBtn = var_1.Find(var_13_19, "PlayingBtn")

	local var_13_20 = arg_13_0.playPanel

	arg_13_0.playBtn = var_1.Find(var_13_20, "StopingBtn")

	local var_13_21 = arg_13_0.playPanel

	arg_13_0.playDesc = var_1.Find(var_13_21, "PlayDesc")

	local var_13_22 = arg_13_0.playPanel

	arg_13_0.nextBtn = var_1.Find(var_13_22, "NextBtn")

	local var_13_23 = arg_13_0.playPanel

	arg_13_0.preBtn = var_1.Find(var_13_23, "PreBtn")

	local var_13_24 = arg_13_0.playPanel

	arg_13_0.playProgressBar = var_1.Find(var_13_24, "Progress")

	local var_13_25 = arg_13_0.playProgressBar

	arg_13_0.nowTimeText = var_1.Find(var_13_25, "NowTimeText")

	local var_13_26 = arg_13_0.playProgressBar

	arg_13_0.totalTimeText = var_1.Find(var_13_26, "TotalTimeText")
	GetComponent = var_1
	arg_13_0.playSliderSC = var_1(arg_13_0.playProgressBar, "LSlider")

	local var_13_27 = arg_13_0.playPanel

	arg_13_0.listBtn = var_1.Find(var_13_27, "ListBtn")
	setActive = var_1

	local var_13_28 = arg_13_0.listBtn

	var_1(var_2.Find(var_13_28, "on"), false)

	setActive = var_1

	local var_13_29 = arg_13_0.listBtn

	var_1(var_2.Find(var_13_29, "off"), true)

	local var_13_30 = arg_13_0._tf

	arg_13_0.albumListPanel = var_1.Find(var_13_30, "AlbumListPanel")

	local var_13_31 = arg_13_0.albumListPanel

	arg_13_0.closeBtn = var_1.Find(var_13_31, "BG")

	local var_13_32 = arg_13_0.albumListPanel

	arg_13_0.panel = var_1.Find(var_13_32, "Panel")
	setText = var_1

	local var_13_33 = arg_13_0.panel
	local var_13_34 = var_2.Find(var_13_33, "top/name")

	i18n = var_13_33

	var_1(var_13_34, var_13_33("NewMusic_6"))

	local var_13_35 = arg_13_0.panel

	arg_13_0.albumToggle = var_1.Find(var_13_35, "bottom/sort_btn")

	local var_13_36 = arg_13_0.panel

	arg_13_0.albumInputText = var_1.Find(var_13_36, "bottom/serch")
	setText = var_1

	local var_13_37 = arg_13_0.albumInputText
	local var_13_38 = var_2.Find(var_13_37, "Placeholder")

	i18n = var_13_37

	var_1(var_13_38, var_13_37("NewMusic_2"))

	local var_13_39 = arg_13_0.panel

	arg_13_0.albumContainer = var_1.Find(var_13_39, "middle/Content")
	UIItemList = var_1

	local var_13_40 = var_1.New
	local var_13_41 = arg_13_0.albumContainer
	local var_13_42 = arg_13_0.albumContainer

	arg_13_0.albumItemList = var_13_40(var_13_41, var_3.GetChild(var_13_42, 0))

	local var_13_43 = arg_13_0.albumItemList

	var_1.make(var_13_43, function(arg_14_0, arg_14_1, arg_14_2)
		arg_14_1 = arg_14_1 + 1
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			arg_13_0.albumTFList[arg_14_1] = arg_14_2

			local var_14_0 = arg_13_0

			var_3.updateAlbumTF(var_14_0, arg_14_2, arg_14_1)
		end

		return
	end)

	local var_13_44 = arg_13_0.likeFilteToggle

	arg_13_0.likeFilteOnImg = var_1.Find(var_13_44, "TextLike/On")

	local var_13_45 = arg_13_0.playPanel

	arg_13_0.playLoopBtn = var_1.Find(var_13_45, "PlayTypeBtn")

	return
end

function var_0_1.addListener(arg_15_0)
	onButton = var_1_10001

	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.listBtn

	local function var_15_2()
		local var_16_0 = arg_15_0

		var_0.openAlbumListPanel(var_16_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_15_0, var_15_1, var_15_2, var_1_10005)

	onButton = var_1_10001

	local var_15_3 = arg_15_0
	local var_15_4 = arg_15_0.closeBtn

	local function var_15_5()
		local var_17_0 = arg_15_0

		var_0.closeAlbumListPanel(var_17_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_15_3, var_15_4, var_15_5, var_1_10005)

	onButton = var_1_10001

	local var_15_6 = arg_15_0
	local var_15_7 = arg_15_0.albumToggle

	local function var_15_8()
		if arg_15_0.albumSortValue == "asc" then
			arg_15_0.albumSortValue = "desc"
		elseif arg_15_0.albumSortValue == "desc" then
			arg_15_0.albumSortValue = "asc"
		end

		local var_18_0 = arg_15_0

		var_0.updateAlbumListPanel(var_18_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_15_6, var_15_7, var_15_8, var_1_10005)

	onButton = var_1_10001

	local var_15_9 = arg_15_0
	local var_15_10 = arg_15_0.likeFilteToggle

	local function var_15_11()
		arg_15_0.likeValue = 1 - arg_15_0.likeValue
		arg_15_0.curMidddleIndex = 1

		local var_19_0 = arg_15_0

		var_0.saveRunData(var_19_0)

		local var_19_1 = arg_15_0

		var_0.updateLikeToggle(var_19_1)

		local var_19_2 = arg_15_0

		var_0.updatePlateListPanel(var_19_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_15_9, var_15_10, var_15_11, var_1_10005)

	onButton = var_1_10001

	local var_15_12 = arg_15_0
	local var_15_13 = arg_15_0.playBtn

	local function var_15_14()
		if not arg_15_0.musicPlayer then
			return
		end

		local var_20_0 = arg_15_0.musicPlayer

		var_0.Resume(var_20_0)

		SetActive = var_0

		var_0(arg_15_0.pauseBtn, true)

		SetActive = var_0

		var_0(arg_15_0.playBtn, false)

		setActive = var_0

		var_0(arg_15_0.playDesc, true)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_15_12, var_15_13, var_15_14, var_1_10005)

	onButton = var_1_10001

	local var_15_15 = arg_15_0
	local var_15_16 = arg_15_0.pauseBtn

	local function var_15_17()
		if not arg_15_0.musicPlayer then
			return
		end

		local var_21_0 = arg_15_0.musicPlayer

		var_0.Pause(var_21_0)

		SetActive = var_0

		var_0(arg_15_0.pauseBtn, false)

		SetActive = var_0

		var_0(arg_15_0.playBtn, true)

		setActive = var_0

		var_0(arg_15_0.playDesc, false)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_15_15, var_15_16, var_15_17, var_1_10005)

	onButton = var_1_10001

	local var_15_18 = arg_15_0
	local var_15_19 = arg_15_0.preBtn

	local function var_15_20()
		if not arg_15_0.musicPlayer then
			return
		end

		if arg_15_0.isPlayingAni then
			return
		end

		local var_22_0 = arg_15_0.musicPlayer

		var_0.Last(var_22_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_15_18, var_15_19, var_15_20, var_1_10005)

	onButton = var_1_10001

	local var_15_21 = arg_15_0
	local var_15_22 = arg_15_0.nextBtn

	local function var_15_23()
		if not arg_15_0.musicPlayer then
			return
		end

		if arg_15_0.isPlayingAni then
			return
		end

		local var_23_0 = arg_15_0.musicPlayer

		var_0.Next(var_23_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_15_21, var_15_22, var_15_23, var_1_10005)

	onButton = var_1_10001

	local var_15_24 = arg_15_0
	local var_15_25 = arg_15_0.likeToggle

	local function var_15_26()
		local var_24_0 = arg_15_0.musicPlayer
		local var_24_1 = var_0.GetCurrentMusicId(var_24_0)

		pg = var_24_0

		local var_24_2 = var_24_0.music_collect_config[var_24_1].id

		pg = var_2_10003

		local var_24_3 = var_2_10003.m02
		local var_24_4 = var_3.sendNotification

		GAME = var_2_10005

		var_24_4(var_24_3, var_2_10005.APPRECIATE_MUSIC_LIKE, {
			musicID = var_24_2,
			isAdd = arg_15_0.likeDic[var_24_2] and 1 or 0
		})

		local var_24_5 = arg_15_0

		var_3.ChangeLike(var_24_5, var_24_2)

		local var_24_6 = arg_15_0

		var_3.updateLikeToggle(var_24_6)

		setActive = var_3

		var_3(arg_15_0.likeOnImg, arg_15_0.likeDic[var_24_2])

		local var_24_7 = arg_15_0

		var_3.updatePlateList(var_24_7, arg_15_0.plateTFList[arg_15_0.curMidddleIndex], arg_15_0.curMidddleIndex)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_15_24, var_15_25, var_15_26, var_1_10005)

	local var_15_27
	local var_15_28 = arg_15_0.playSliderSC

	var_2.AddPointDownFunc(var_15_28, function(arg_25_0)
		if arg_15_0.onDrag then
			return
		end

		arg_15_0.onDrag = true

		local var_25_0 = arg_15_0.musicPlayer

		var_15_27 = var_1.IsPaused(var_25_0)

		if not var_15_27 then
			local var_25_1 = arg_15_0.musicPlayer

			var_1.Pause(var_25_1)
		end

		return
	end)

	local var_15_29 = arg_15_0.playSliderSC

	var_2.AddPointUpFunc(var_15_29, function(arg_26_0)
		if not arg_15_0.onDrag then
			return
		end

		arg_15_0.onDrag = false

		local var_26_0 = arg_15_0.musicPlayer

		var_1.SetProgress(var_26_0, arg_15_0.playSliderSC.value)

		if not var_15_27 then
			local var_26_1 = arg_15_0.musicPlayer

			var_1.Resume(var_26_1)
		end

		return
	end)

	onButton = var_2

	local var_15_30 = arg_15_0
	local var_15_31 = arg_15_0.playLoopBtn

	local function var_15_32()
		getProxy = var_2_10000
		AppreciateProxy = var_2_10001

		local var_27_0 = var_2_10000(var_2_10001)
		local var_27_1 = var_0.getMusicPlayerLoopType(var_27_0)

		switch = var_27_0

		var_27_0(var_27_1, {
			list = function()
				var_27_1 = "random"

				return
			end,
			random = function()
				var_27_1 = "one"

				return
			end,
			one = function()
				var_27_1 = "list"

				return
			end
		})

		pg = var_27_0

		local var_27_2 = var_27_0.m02
		local var_27_3 = var_1.sendNotification

		GAME = var_3

		var_27_3(var_27_2, var_3.APPRECIATE_CHANGE_MUSIC_PLAY_LOOP_TYPE, {
			loopType = var_27_1
		})

		local var_27_4 = arg_15_0

		var_1.updatePlayType(var_27_4, var_27_1)

		if arg_15_0.musicPlayer then
			arg_15_0.musicPlayer.loopType = var_27_1
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_15_30, var_15_31, var_15_32, var_1_10006)

	onInputChanged = var_2

	var_2(arg_15_0, arg_15_0.serchInputText, function(arg_31_0)
		local var_31_0 = arg_15_0.likeValue

		MusicCollectionConst = var_2_10002

		if var_31_0 ~= var_2_10002.Filte_Like_Value then
			return
		end

		local var_31_1 = arg_15_0

		var_1.updatePlateList(var_31_1, arg_15_0.plateTFList[arg_15_0.curMidddleIndex], arg_15_0.curMidddleIndex)

		return
	end)

	onInputChanged = var_2

	var_2(arg_15_0, arg_15_0.albumInputText, function(arg_32_0)
		local var_32_0 = arg_15_0

		var_1.updateAlbumListPanel(var_32_0)

		return
	end)

	return
end

function var_0_1.tryShowTipMsgBox(arg_33_0)
	local var_33_0 = arg_33_0.appreciateProxy

	if var_1.isMusicHaveNewRes(var_33_0) then
		local function var_33_1()
			local var_34_0 = arg_33_0.lScrollPageSC
			local var_34_1 = var_0.MoveToItemID

			MusicCollectionConst = var_2_10002

			var_34_1(var_34_0, var_2_10002.AutoScrollIndex - 1)

			PlayerPrefs = var_34_1

			local var_34_2 = var_34_1.SetInt
			local var_34_3 = "musicVersion"

			MusicCollectionConst = var_2

			var_34_2(var_34_3, var_2.Version)

			local var_34_4 = arg_33_0
			local var_34_5 = var_0.emit

			CollectionScene = var_2

			var_34_5(var_34_4, var_2.UPDATE_RED_POINT)

			return
		end

		pg = var_1_10003

		local var_33_2 = var_1_10003.MsgboxMgr.GetInstance()
		local var_33_3 = var_3.ShowMsgBox
		local var_33_4 = {
			hideNo = true,
			hideClose = true
		}

		i18n = var_1_10006

		local var_33_5 = "res_music_new_tip"

		MusicCollectionConst = var_1_10008
		var_33_4.content = var_1_10006(var_33_5, var_1_10008.NewCount)
		var_33_4.onYes = var_33_1
		var_33_4.onCancel = var_33_1
		var_33_4.onClose = var_33_1

		var_33_3(var_33_2, var_33_4)
	end

	return
end

function var_0_1.initPlateListPanel(arg_35_0)
	function arg_35_0.lScrollPageSC.itemInitedCallback(arg_36_0, arg_36_1)
		local var_36_0 = arg_36_0 + 1

		arg_35_0.plateTFList[var_36_0] = arg_36_1

		local var_36_1 = arg_36_1:GetComponent("DftAniEvent")

		var_3.SetEndEvent(var_36_1, function()
			local var_37_0 = arg_35_0.animCallback
			local var_37_1 = arg_35_0

			var_37_1.animCallback = nil
			existCall = var_37_1

			var_37_1(var_37_0)

			return
		end)

		local var_36_2 = arg_35_0

		var_3.updatePlateTF(var_36_2, arg_36_1, var_36_0)

		return
	end

	function arg_35_0.lScrollPageSC.itemClickCallback(arg_38_0, arg_38_1)
		local var_38_0 = arg_38_0 + 1

		if arg_35_0.curMidddleIndex ~= var_38_0 and not arg_35_0.isPlayingAni then
			local var_38_1 = arg_35_0

			var_3.setAniState(var_38_1, true)

			local var_38_2 = arg_35_0

			var_3.closePlateAni(var_38_2, arg_35_0.plateTFList[arg_35_0.curMidddleIndex])

			local var_38_3 = arg_35_0.lScrollPageSC

			var_3.MoveToItemID(var_38_3, arg_38_0)
		end

		return
	end

	function arg_35_0.lScrollPageSC.itemPitchCallback(arg_39_0, arg_39_1)
		local var_39_0 = arg_39_0 + 1

		arg_35_0.curMidddleIndex = var_39_0

		local var_39_1 = arg_35_0

		var_3.saveRunData(var_39_1)

		local var_39_2 = arg_35_0

		var_3.updatePlateList(var_39_2, arg_39_1, var_39_0)

		local var_39_3 = arg_35_0

		var_3.playPlateAni(var_39_3, arg_39_1, true)

		return
	end

	local var_35_0 = arg_35_0.lScrollPageSC

	function var_35_0.itemRecycleCallback(arg_40_0, arg_40_1)
		arg_35_0.plateTFList[arg_40_0 + 1] = nil

		return
	end

	addSlip = var_35_0
	SLIP_TYPE_HRZ = var_2

	var_35_0(var_2, arg_35_0.plateListPanel, function()
		if arg_35_0.curMidddleIndex > 1 and not arg_35_0.isPlayingAni then
			local var_41_0 = arg_35_0

			var_0.setAniState(var_41_0, true)

			local var_41_1 = arg_35_0.lScrollPageSC

			var_0.MoveToItemID(var_41_1, arg_35_0.curMidddleIndex - 1 - 1)

			local var_41_2 = arg_35_0

			var_0.closePlateAni(var_41_2, arg_35_0.plateTFList[arg_35_0.curMidddleIndex])
		end

		return
	end, function()
		if arg_35_0.curMidddleIndex < arg_35_0.lScrollPageSC.DataCount and not arg_35_0.isPlayingAni then
			local var_42_0 = arg_35_0

			var_0.setAniState(var_42_0, true)

			local var_42_1 = arg_35_0.lScrollPageSC

			var_0.MoveToItemID(var_42_1, arg_35_0.curMidddleIndex + 1 - 1)

			local var_42_2 = arg_35_0

			var_0.closePlateAni(var_42_2, arg_35_0.plateTFList[arg_35_0.curMidddleIndex])
		end

		return
	end)

	return
end

function var_0_1.updatePlateListPanel(arg_43_0)
	local var_43_0 = arg_43_0.likeValue

	MusicCollectionConst = var_1_10002

	if var_43_0 == var_1_10002.Filte_Like_Value then
		arg_43_0.tempPlateList = {
			"favor"
		}
	else
		arg_43_0.tempPlateList = arg_43_0.albumNames
	end

	setActive = var_2

	var_2(arg_43_0.serchInputText, var_1)

	setActive = var_2

	var_2(arg_43_0.listBtn, not var_1)

	arg_43_0.lScrollPageSC.DataCount = #arg_43_0.tempPlateList

	local var_43_1 = arg_43_0.lScrollPageSC

	var_2.Init(var_43_1, arg_43_0.curMidddleIndex - 1)

	return
end

function var_0_1.updatePlateTF(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_0.likeValue

	MusicCollectionConst = var_1_10004

	local var_44_1 = var_44_0 == var_1_10004.Filte_Like_Value
	local var_44_2 = arg_44_0.tempPlateList[arg_44_2]
	local var_44_4

	if not var_44_1 or not arg_44_0.likeIds then
		local var_44_3 = arg_44_0.appreciateProxy

		var_44_4 = var_5.getAlbumMusicList(var_44_3, var_44_2)
	end

	local var_44_5
	local var_44_6 = #var_44_4

	if 0 < var_44_6 then
		var_44_6 = var_44_4[#var_44_4]
		pg = var_8

		local var_44_7 = var_8.music_collect_config[var_44_6].album_id

		pg = var_1_10009
		var_44_5 = var_1_10009.music_album[var_44_7].cover
	end

	setText = var_44_6

	local var_44_8 = arg_44_1
	local var_44_9 = arg_44_1.Find(var_44_8, "PlateImg/empty/Text")

	i18n = var_44_8

	var_44_6(var_44_9, var_44_8("NewMusic_7"))

	setActive = var_44_6

	var_44_6(arg_44_1:Find("PlateImg/face"), var_44_5)

	setActive = var_44_6

	var_44_6(arg_44_1:Find("PlateImg/empty"), not var_44_5)

	if var_44_5 then
		MusicCollectionConst = var_44_6

		local var_44_10 = var_44_6.MUSIC_COVER_PATH_PREFIX .. var_44_5
		local var_44_11 = arg_44_0.resLoader

		var_8.LoadSprite(var_44_11, var_44_10, var_44_5, arg_44_1:Find("PlateImg/face"), false)
	end

	if arg_44_2 == arg_44_0.curMidddleIndex then
		arg_44_0:updatePlateList(arg_44_1, arg_44_2)
	end

	return
end

function var_0_1.updatePlateList(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = arg_45_0.likeValue

	MusicCollectionConst = var_1_10004

	local var_45_1 = var_45_0 == var_1_10004.Filte_Like_Value
	local var_45_2 = arg_45_0.tempPlateList[arg_45_2]
	local var_45_4

	if not var_45_1 or not arg_45_0.likeIds then
		local var_45_3 = arg_45_0.appreciateProxy

		var_45_4 = var_5.getAlbumMusicList(var_45_3, var_45_2)
	end

	local var_45_5 = arg_45_1
	local var_45_6 = arg_45_1.Find(var_45_5, "list")

	setText = var_45_5

	local var_45_7 = var_45_6
	local var_45_8 = var_45_6.Find(var_45_7, "album_name")

	if var_45_2 == "favor" then
		i18n = var_45_7

		local var_45_9

		if not var_45_7("NewMusic_5") then
			var_45_9 = var_45_2
		end

		var_45_5(var_45_8, var_45_9)

		local var_45_10 = arg_45_0.appreciateProxy
		local var_45_11 = var_7.getMainPlayerAlbumName(var_45_10) == var_45_2
		local var_45_12 = var_45_6
		local var_45_13 = var_45_6.Find(var_45_12, "btn_home")

		setActive = var_45_12

		var_45_12(var_45_13:Find("off"), not var_45_11)

		setActive = var_45_12

		var_45_12(var_45_13:Find("on"), var_45_11)

		onButton = var_45_12

		local var_45_14 = arg_45_0
		local var_45_15 = var_45_13

		local function var_45_16()
			local var_46_0 = arg_45_0.appreciateProxy
			local var_46_2

			if var_0.getMainPlayerAlbumName(var_46_0) == var_45_2 then
				pg = var_46_2

				local var_46_1 = var_46_2.m02

				var_46_2 = var_46_2.sendNotification
				GAME = var_2_10003

				var_46_2(var_46_1, var_2_10003.APPRECIATE_CHANGE_MAIN_PLAY_ALBUM, {
					albumName = "none"
				})

				setActive = var_46_2
				var_2_10003 = var_45_13

				var_46_2(var_2.Find(var_2_10003, "off"), true)

				setActive = var_46_2
				var_2_10003 = var_45_13

				var_46_2(var_2.Find(var_2_10003, "on"), false)
			else
				pg = var_46_2

				local var_46_3 = var_46_2.m02
				local var_46_4 = var_1.sendNotification

				GAME = var_2_10003

				var_46_4(var_46_3, var_2_10003.APPRECIATE_CHANGE_MAIN_PLAY_ALBUM, {
					albumName = var_45_2
				})

				setActive = var_46_4

				local var_46_5 = var_45_13

				var_46_4(var_2.Find(var_46_5, "off"), false)

				setActive = var_46_4

				local var_46_6 = var_45_13

				var_46_4(var_2.Find(var_46_6, "on"), true)
			end

			local var_46_7 = arg_45_0

			var_1.updateAlbumListPanel(var_46_7)

			return
		end

		SFX_CONFIRM = var_1_10013

		var_45_12(var_45_14, var_45_15, var_45_16, var_1_10013)

		local var_45_17 = var_45_6:Find("panel/view/container")

		local function var_45_18(arg_47_0)
			local var_47_0

			if var_45_1 then
				local var_47_1 = arg_45_0.sortValue

				MusicCollectionConst = var_2_10003

				if var_47_1 == var_2_10003.Sort_Order_Down then
					underscore = var_47_1
					var_47_0 = var_47_1.to_array(var_45_4)
				else
					var_47_1 = arg_45_0.sortValue
					MusicCollectionConst = var_2_10003

					if var_47_1 == var_2_10003.Sort_Order_Up then
						underscore = var_47_1
						var_47_0 = var_47_1.reverse(var_45_4)
					else
						assert = var_47_1

						var_47_1(false)
					end
				end

				string = var_47_1

				local var_47_2 = var_47_1.lower

				getInputText = var_2_10003

				local var_47_3 = var_47_2(var_2_10003(arg_45_0.serchInputText))

				if var_45_1 then
					underscore = var_47_4

					local var_47_4

					if not var_47_4.filter(var_47_0, function(arg_48_0)
						pg = var_3_10001

						local var_48_0 = var_3_10001.music_collect_config[arg_48_0].name
						local var_48_2

						if var_47_3 and var_47_3 ~= "" then
							string = var_2

							local var_48_1 = var_2.find

							string = var_3_10003
							var_48_2 = var_48_1(var_3_10003.lower(var_48_0), var_47_3)

							if false then
								var_48_2 = false
							end
						else
							var_48_2 = true
						end

						return var_48_2
					end) then
						underscore = var_47_4
						var_47_4 = var_47_4.to_array(var_47_0)
					end

					UIItemList = var_4

					local var_47_5 = var_4.StaticAlign
					local var_47_6 = var_45_17
					local var_47_7 = var_45_17

					var_47_5(var_47_6, var_6.GetChild(var_47_7, 0), #var_47_4, function(arg_49_0, arg_49_1, arg_49_2)
						arg_49_1 = arg_49_1 + 1
						UIItemList = var_3_10003

						if arg_49_0 == var_3_10003.EventUpdate then
							pg = var_3

							local var_49_0 = var_3.music_collect_config[var_47_4[arg_49_1]]
							local var_49_1

							if var_45_1 then
								var_49_1 = arg_45_0.sortValue
								MusicCollectionConst = var_3_10005

								if var_49_1 == var_3_10005.Sort_Order_Up then
									setText = var_49_1

									local var_49_2 = arg_49_2
									local var_49_3 = arg_49_2.Find(var_49_2, "mark/Text")

									string = var_49_2

									var_49_1(var_49_3, var_49_2.format("%02d", #var_47_4 - arg_49_1 + 1))

									goto label_49_0
								end
							end

							setText = var_49_1

							do
								local var_49_4 = arg_49_2
								local var_49_5 = arg_49_2.Find(var_49_4, "mark/Text")

								string = var_49_4

								var_49_1(var_49_5, var_49_4.format("%02d", arg_49_1))
							end

							::label_49_0::

							changeToScrollText = var_49_1

							var_49_1(arg_49_2:Find("name"), var_49_0.name)

							setText = var_49_1

							local var_49_6 = arg_49_2:Find("time")
							local var_49_7 = arg_45_0

							var_49_1(var_49_6, var_6.descTime(var_49_7, var_49_0.music_time))

							setActive = var_49_1

							var_49_1(arg_49_2:Find("line"), arg_49_1 < #var_47_4)

							onButton = var_49_1

							local var_49_8 = arg_45_0
							local var_49_9 = arg_49_2:Find("like")

							local function var_49_10()
								local var_50_0 = var_49_0.id

								pg = var_4_10001

								local var_50_1 = var_4_10001.m02
								local var_50_2 = var_1.sendNotification

								GAME = var_4_10003

								var_50_2(var_50_1, var_4_10003.APPRECIATE_MUSIC_LIKE, {
									musicID = var_50_0,
									isAdd = arg_45_0.likeDic[var_50_0] and 1 or 0
								})

								local var_50_3 = arg_45_0

								var_1.ChangeLike(var_50_3, var_50_0)

								local var_50_4 = arg_45_0

								var_1.updateLikeToggle(var_50_4)

								local var_50_5 = arg_45_0

								var_1.updatePlateList(var_50_5, arg_45_1, arg_45_2)

								if arg_45_0.musicPlayer then
									local var_50_6 = arg_45_0.musicPlayer

									if var_1.GetCurrentMusicId(var_50_6) == var_50_0 then
										setActive = var_1

										var_1(arg_45_0.likeOnImg, arg_45_0.likeDic[var_50_0])
									end
								end

								return
							end

							SFX_CONFIRM = var_8

							var_49_1(var_49_8, var_49_9, var_49_10, var_8)

							setActive = var_49_1

							var_49_1(arg_49_2:Find("like/off"), not arg_45_0.likeDic[var_49_0.id])

							setActive = var_49_1

							var_49_1(arg_49_2:Find("like/on"), arg_45_0.likeDic[var_49_0.id])

							if arg_45_0.musicPlayer then
								if arg_45_0.musicPlayer.albumName == var_45_2 then
									local var_49_11 = arg_45_0.musicPlayer
									local var_49_12

									if var_4.GetCurrentMusicId(var_49_11) ~= var_49_0.id then
										var_49_12 = false
									else
										var_49_12 = true
									end

									setActive = var_49_11

									var_49_11(arg_49_2:Find("mark/Text"), not var_49_12)

									setActive = var_49_11

									var_49_11(arg_49_2:Find("mark/icon"), var_49_12)

									setTextColor = var_49_11

									local var_49_13 = arg_49_2
									local var_49_14 = arg_49_2.Find(var_49_13, "name/subText")

									if var_49_12 then
										Color = var_49_13

										if not var_49_13.NewHex("FF596E") then
											Color = var_49_13
											var_49_13 = var_49_13.white
										end

										var_49_11(var_49_14, var_49_13)

										setTextColor = var_49_11

										local var_49_15 = arg_49_2
										local var_49_16 = arg_49_2.Find(var_49_15, "time")

										if var_49_12 then
											Color = var_49_15

											if not var_49_15.NewHex("FF596E") then
												Color = var_49_15
												var_49_15 = var_49_15.white
											end

											var_49_11(var_49_16, var_49_15)

											onButton = var_49_11

											local var_49_17 = arg_45_0
											local var_49_18 = arg_49_2

											local function var_49_19()
												local var_51_0 = arg_45_0

												var_0.NewMusicPlayer(var_51_0, var_45_2, var_47_0, var_49_0.id)

												return
											end

											SFX_CONFIRM = var_3_10009

											var_49_11(var_49_17, var_49_18, var_49_19, var_3_10009)

											return
										end
									end
								end
							end
						end
					end)

					setActive = var_47_5

					local var_47_8 = var_45_6

					var_47_5(var_5.Find(var_47_8, "panel/view/empty"), #var_47_4 == 0)

					return
				end
			end
		end

		setActive = var_11

		var_11(var_45_6:Find("panel/sort"), var_45_1)

		if var_45_1 then
			local var_45_19 = var_45_6:Find("panel/sort/bg/asc")
			local var_45_20 = var_45_6
			local var_45_21 = var_45_6.Find(var_45_20, "panel/sort/bg/desc")

			setText = var_45_20

			local var_45_22 = var_45_19
			local var_45_23 = var_45_19.Find(var_45_22, "Text")

			i18n = var_45_22

			var_45_20(var_45_23, var_45_22("word_asc"))

			onToggle = var_45_20

			local var_45_24 = arg_45_0
			local var_45_25 = var_45_19

			local function var_45_26(arg_52_0)
				if arg_52_0 then
					var_2_10001 = arg_45_0
					MusicCollectionConst = var_2_10002
					var_2_10001.sortValue = var_2_10002.Sort_Order_Up

					local var_52_0 = arg_45_0

					var_2_10001.saveRunData(var_52_0)
					var_45_18(not arg_52_0)
				end

				setImageAlpha = var_2_10001

				var_2_10001(var_45_19, arg_52_0 and 1 or 0)

				setCanvasGroupAlpha = var_2_10001

				var_2_10001(var_45_19, arg_52_0 and 1 or 0.3)

				return
			end

			SFX_PANEL = var_1_10017

			var_45_20(var_45_24, var_45_25, var_45_26, var_1_10017)

			setText = var_45_20

			local var_45_27 = var_45_21
			local var_45_28 = var_45_21.Find(var_45_27, "Text")

			i18n = var_45_27

			var_45_20(var_45_28, var_45_27("word_desc"))

			onToggle = var_45_20

			local var_45_29 = arg_45_0
			local var_45_30 = var_45_21

			local function var_45_31(arg_53_0)
				if arg_53_0 then
					var_2_10001 = arg_45_0
					MusicCollectionConst = var_2_10002
					var_2_10001.sortValue = var_2_10002.Sort_Order_Down

					local var_53_0 = arg_45_0

					var_2_10001.saveRunData(var_53_0)
					var_45_18(arg_53_0)
				end

				setImageAlpha = var_2_10001

				var_2_10001(var_45_21, arg_53_0 and 1 or 0)

				setCanvasGroupAlpha = var_2_10001

				var_2_10001(var_45_21, arg_53_0 and 1 or 0.3)

				return
			end

			SFX_PANEL = var_1_10017

			var_45_20(var_45_29, var_45_30, var_45_31, var_1_10017)

			local var_45_32 = arg_45_0.sortValue

			MusicCollectionConst = var_45_29

			if var_45_32 == var_45_29.Sort_Order_Up then
				triggerToggle = var_45_32

				var_45_32(var_45_19, true)
			else
				triggerToggle = var_45_32

				var_45_32(var_45_21, true)
			end
		else
			var_45_18(false)
		end

		return
	end
end

function var_0_1.updateAlbumListPanel(arg_54_0)
	string = var_1_10001

	local var_54_0 = var_1_10001.lower

	getInputText = var_1_10002

	local var_54_1 = var_54_0(var_1_10002(arg_54_0.albumInputText))

	underscore = var_2
	arg_54_0.tempAlbumList = var_2.filter(arg_54_0.albumNames, function(arg_55_0)
		string = var_2_10001

		local var_55_0 = var_2_10001.find

		string = var_2_10002

		if var_55_0(var_2_10002.lower(arg_55_0), var_54_1) then
			return true
		else
			underscore = var_1

			local var_55_1 = var_1.any
			local var_55_2 = arg_54_0.appreciateProxy

			return var_55_1(var_2.getAlbumMusicList(var_55_2, arg_55_0), function(arg_56_0)
				string = var_3_10001

				local var_56_0 = var_3_10001.find

				string = var_3_10002

				local var_56_1 = var_3_10002.lower

				pg = var_3_10003

				return var_56_0(var_56_1(var_3_10003.music_collect_config[arg_56_0].name), var_54_1)
			end)
		end

		return
	end)

	local var_54_2 = arg_54_0.albumItemList

	var_2.align(var_54_2, #arg_54_0.tempAlbumList)

	setActive = var_2

	local var_54_3 = arg_54_0.panel

	var_2(var_3.Find(var_54_3, "middle/empty"), #arg_54_0.tempAlbumList == 0)

	setActive = var_2

	local var_54_4 = arg_54_0.albumToggle

	var_2(var_3.Find(var_54_4, "asc"), arg_54_0.albumSortValue == "asc")

	setActive = var_2

	local var_54_5 = arg_54_0.albumToggle

	var_2(var_3.Find(var_54_5, "desc"), arg_54_0.albumSortValue == "desc")

	return
end

function var_0_1.updateAlbumTF(arg_57_0, arg_57_1, arg_57_2)
	if arg_57_0.albumSortValue == "desc" then
		arg_57_2 = #arg_57_0.tempAlbumList + 1 - arg_57_2
	end

	local var_57_0 = arg_57_0.tempAlbumList[arg_57_2]

	setText = var_1_10004

	local var_57_1 = arg_57_1
	local var_57_2 = arg_57_1.Find(var_57_1, "index")

	string = var_57_1

	var_1_10004(var_57_2, var_57_1.format("%02d", arg_57_2))

	local var_57_3 = arg_57_0.appreciateProxy
	local var_57_4 = var_4.getAlbumMusicList(var_57_3, var_57_0)

	pg = var_57_3

	local var_57_5 = var_57_3.music_collect_config[var_57_4[1]].album_id

	pg = var_6

	local var_57_6 = var_6.music_album[var_57_5].cover

	MusicCollectionConst = var_7

	local var_57_7 = var_7.MUSIC_COVER_PATH_PREFIX .. var_57_6
	local var_57_8 = arg_57_0.resLoader

	var_8.LoadSprite(var_57_8, var_57_7, var_57_6, arg_57_1:Find("icon/face"), false)

	changeToScrollText = var_8

	var_8(arg_57_1:Find("name"), var_57_0)

	setActive = var_8

	local var_57_9 = arg_57_1:Find("icon/main")
	local var_57_10 = arg_57_0.appreciateProxy

	var_8(var_57_9, var_57_0 == var_10.getMainPlayerAlbumName(var_57_10))

	local var_57_11

	if arg_57_0.musicPlayer then
		var_57_11 = arg_57_0.musicPlayer.albumName == var_57_0
	end

	setActive = var_57_9

	var_57_9(arg_57_1:Find("playing"), var_57_11)

	setActive = var_57_9

	var_57_9(arg_57_1:Find("line"), arg_57_2 < #arg_57_0.tempAlbumList)

	onButton = var_57_9

	local var_57_12 = arg_57_0
	local var_57_13 = arg_57_1

	local function var_57_14()
		local var_58_0 = arg_57_0

		var_0.closeAlbumListPanel(var_58_0)

		arg_57_0.curMidddleIndex = arg_57_2

		local var_58_1 = arg_57_0.likeValue

		MusicCollectionConst = var_1

		if var_58_1 == var_1.Filte_Like_Value then
			local var_58_2 = arg_57_0

			MusicCollectionConst = var_1
			var_58_2.likeValue = var_1.Filte_Normal_Value

			local var_58_3 = arg_57_0

			var_0.updatePlateListPanel(var_58_3)
		else
			local var_58_4 = arg_57_0.lScrollPageSC

			var_0.Init(var_58_4, arg_57_0.curMidddleIndex - 1)
		end

		local var_58_5 = arg_57_0

		var_0.saveRunData(var_58_5)

		return
	end

	SFX_PANEL = var_13

	var_57_9(var_57_12, var_57_13, var_57_14, var_13)

	return
end

function var_0_1.updateLikeToggle(arg_59_0)
	setActive = var_1_10001

	local var_59_0 = arg_59_0.likeFilteOnImg
	local var_59_1 = arg_59_0.likeValue

	MusicCollectionConst = var_1_10004

	var_1_10001(var_59_0, var_59_1 == var_1_10004.Filte_Like_Value)

	underscore = var_1_10001

	local var_59_2 = var_1_10001.reduce

	underscore = var_59_0

	local var_59_3 = var_59_2(var_59_0.keys(arg_59_0.likeDic), 0, function(arg_60_0, arg_60_1)
		return arg_60_0 + (arg_59_0.likeDic[arg_60_1] and 1 or 0)
	end)

	setText = var_2

	local var_59_4 = arg_59_0.likeFilteToggle
	local var_59_5 = var_3.Find(var_59_4, "TextNum")

	string = var_59_4

	var_2(var_59_5, var_59_4.format("(%d)", var_59_3))

	return
end

function var_0_1.updatePlayPanel(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0.musicPlayer
	local var_61_1 = var_2.GetCurrentMusicId(var_61_0)

	pg = var_61_0

	local var_61_2 = var_61_0.music_collect_config[var_61_1].album_id

	pg = var_1_10005

	local var_61_3 = var_1_10005.music_album[var_61_2].cover

	MusicCollectionConst = var_1_10006

	local var_61_4 = var_1_10006.MUSIC_COVER_PATH_PREFIX .. var_61_3
	local var_61_5 = arg_61_0.resLoader

	var_7.LoadSprite(var_61_5, var_61_4, var_61_3, arg_61_0.songImg, false)

	local var_61_6 = var_3.name

	changeToScrollText = var_61_5

	var_61_5(arg_61_0.playPanelNameText, var_61_6)

	setActive = var_61_5

	var_61_5(arg_61_0.likeOnImg, arg_61_0.likeDic[var_3.id])

	setActive = var_61_5

	var_61_5(arg_61_0.playBtn, false)

	setActive = var_61_5

	var_61_5(arg_61_0.playDesc, true)

	setActive = var_61_5

	var_61_5(arg_61_0.pauseBtn, true)

	setSlider = var_61_5

	var_61_5(arg_61_0.playProgressBar, 0, arg_61_1, 0)

	setText = var_61_5

	var_61_5(arg_61_0.totalTimeText, arg_61_0:descTime(arg_61_1))

	setActive = var_61_5

	var_61_5(arg_61_0.nowTimeText, true)

	setActive = var_61_5

	var_61_5(arg_61_0.totalTimeText, true)

	return
end

function var_0_1.updatePlayType(arg_62_0, arg_62_1)
	if not arg_62_1 then
		getProxy = var_1_10002
		AppreciateProxy = var_1_10003

		local var_62_0 = var_1_10002(var_1_10003)

		arg_62_1 = var_1_10002.getMusicPlayerLoopType(var_62_0)
	end

	eachChild = var_1_10002

	var_1_10002(arg_62_0.playLoopBtn, function(arg_63_0, arg_63_1)
		setActive = var_2_10002

		var_2_10002(arg_63_0, arg_63_0.name == arg_62_1)

		return
	end)

	return
end

function var_0_1.updatePlayProgress(arg_64_0, arg_64_1)
	local var_64_0 = arg_64_0.playSliderSC

	var_2.SetValueWithoutEvent(var_64_0, arg_64_1)

	setText = var_2

	var_2(arg_64_0.nowTimeText, arg_64_0:descTime(arg_64_1))

	return
end

function var_0_1.playPlateAni(arg_65_0, arg_65_1, arg_65_2, arg_65_3, arg_65_4)
	arg_65_0:setAniState(true)

	setActive = var_5

	var_5(arg_65_1:Find("list"), true)

	function arg_65_0.animCallback()
		local var_66_0 = arg_65_0

		var_0.setAniState(var_66_0, false)

		return
	end

	quickPlayAnimation = var_5

	var_5(arg_65_1, "anim_MusicCollectionUI_Plate_expand")

	return
end

function var_0_1.closePlateAni(arg_67_0, arg_67_1)
	arg_67_0:setAniState(true)

	function arg_67_0.animCallback()
		setActive = var_2_10000

		local var_68_0 = arg_67_1

		var_2_10000(var_1.Find(var_68_0, "list"), false)

		local var_68_1 = arg_67_0

		var_0.setAniState(var_68_1, false)

		return
	end

	quickPlayAnimation = var_2

	var_2(arg_67_1, "anim_MusicCollectionUI_Plate_retract")

	return
end

function var_0_1.setAniState(arg_69_0, arg_69_1)
	arg_69_0.isPlayingAni = arg_69_1

	return
end

function var_0_1.openAlbumListPanel(arg_70_0)
	setActive = var_1_10001

	var_1_10001(arg_70_0.albumListPanel, true)

	setActive = var_1_10001

	local var_70_0 = arg_70_0.listBtn

	var_1_10001(var_2.Find(var_70_0, "on"), true)

	setActive = var_1_10001

	local var_70_1 = arg_70_0.listBtn

	var_1_10001(var_2.Find(var_70_1, "off"), false)

	return
end

function var_0_1.closeAlbumListPanel(arg_71_0, arg_71_1)
	setActive = var_1_10002

	var_1_10002(arg_71_0.albumListPanel, false)

	setActive = var_1_10002

	local var_71_0 = arg_71_0.listBtn

	var_1_10002(var_3.Find(var_71_0, "on"), false)

	setActive = var_1_10002

	local var_71_1 = arg_71_0.listBtn

	var_1_10002(var_3.Find(var_71_1, "off"), true)

	return
end

function var_0_1.checkupdateAlbumTF(arg_72_0)
	if #arg_72_0.albumTFList > 0 then
		arg_72_0:updateAlbumTF(arg_72_0.albumTFList[arg_72_0.curMidddleIndex], arg_72_0.curMidddleIndex)
	end

	return
end

function var_0_1.NewMusicPlayer(arg_73_0, arg_73_1, arg_73_2, arg_73_3)
	local var_73_0 = {}

	getProxy = var_1_10005
	AppreciateProxy = var_1_10006

	local var_73_1 = var_1_10005(var_1_10006)

	var_73_0.loopType = var_5.getMusicPlayerLoopType(var_73_1)
	var_73_0.albumName = arg_73_1
	var_73_0.list = arg_73_2 or nil

	if arg_73_3 then
		table = var_5

		local var_73_2

		if not var_5.indexof(arg_73_2, arg_73_3) then
			var_73_2 = nil
		end

		var_73_0.index = var_73_2

		local var_73_3 = arg_73_0.bgmMgr

		var_5.TempPlay(var_73_3, "TempMusicPlayer", var_73_0)

		local var_73_4 = arg_73_0.bgmMgr

		arg_73_0.musicPlayer = var_5.GetMusicPlayer(var_73_4)

		return
	end
end

function var_0_1.ChangeLike(arg_74_0, arg_74_1)
	arg_74_0.likeDic[arg_74_1] = not arg_74_0.likeDic[arg_74_1]

	if arg_74_0.likeDic[arg_74_1] then
		table = var_2

		var_2.insert(arg_74_0.likeIds, arg_74_1)
	else
		table = var_2

		var_2.removebyvalue(arg_74_0.likeIds, arg_74_1)
	end

	return
end

function var_0_1.tryPlayMusic(arg_75_0)
	triggerButton = var_1_10001

	var_1_10001(arg_75_0.playBtn)

	return
end

function var_0_1.tryPauseMusic(arg_76_0)
	triggerButton = var_1_10001

	var_1_10001(arg_76_0.pauseBtn)

	return
end

function var_0_1.descTime(arg_77_0, arg_77_1)
	math = var_1_10002

	local var_77_0 = var_1_10002.floor(arg_77_1 / 1000)

	math = var_3

	local var_77_1 = var_77_0 - var_3.floor(var_77_0 / 16) * 16

	math = var_4

	local var_77_2 = var_4.floor(var_77_1 / 60)
	local var_77_3 = var_77_1 % 60

	if var_3 ~= 0 then
		string = var_1_10006

		return var_1_10006.format("%02d:%02d:%02d", var_3, var_77_2, var_77_3)
	else
		string = var_1_10006

		return var_1_10006.format("%02d:%02d", var_77_2, var_77_3)
	end

	return
end

return var_0_1

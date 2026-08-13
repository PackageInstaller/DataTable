class = var_0_10000

local var_0_0 = "MainMusicPlayerView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "MusicPlayer"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.rtPanel = var_1.Find(var_2_0, "panel")

	local var_2_1 = arg_2_0.rtPanel

	arg_2_0.rtContainer = var_1.Find(var_2_1, "view/container")

	local var_2_2 = arg_2_0.rtContainer

	arg_2_0.playLoopBtn = var_1.Find(var_2_2, "PlayTypeBtn")

	local var_2_3 = arg_2_0.rtContainer

	arg_2_0.likeToggle = var_1.Find(var_2_3, "LikeBtn")

	local var_2_4 = arg_2_0.rtContainer

	arg_2_0.preBtn = var_1.Find(var_2_4, "PreBtn")

	local var_2_5 = arg_2_0.rtContainer

	arg_2_0.nextBtn = var_1.Find(var_2_5, "NextBtn")

	local var_2_6 = arg_2_0.rtPanel

	arg_2_0.btnExtend = var_1.Find(var_2_6, "extend")

	local var_2_7 = arg_2_0.rtContainer

	arg_2_0.btnIcon = var_1.Find(var_2_7, "icon")

	return
end

function var_0_1.OnInit(arg_3_0)
	pg = var_1_10001
	arg_3_0.bgmMgr = var_1_10001.BgmMgr.GetInstance()
	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.btnExtend

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_4_0.isOpen = not arg_3_0.isOpen
		setActive = var_4_0

		local var_4_1 = arg_3_0.btnExtend

		var_4_0(var_1.Find(var_4_1, "on"), not arg_3_0.isOpen)

		setActive = var_4_0

		local var_4_2 = arg_3_0.btnExtend

		var_4_0(var_1.Find(var_4_2, "off"), arg_3_0.isOpen)

		LeanTween = var_4_0

		local var_4_3 = var_4_0.size
		local var_4_4 = arg_3_0.rtPanel

		Vector2 = var_2

		var_4_3(var_4_4, var_2(arg_3_0.isOpen and 460 or 130, arg_3_0.rtPanel.sizeDelta.y), 0.3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.preBtn

	local function var_3_5()
		if not arg_3_0.musicPlayer then
			return
		end

		local var_5_0 = arg_3_0.musicPlayer

		var_0.Last(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.nextBtn

	local function var_3_8()
		if not arg_3_0.musicPlayer then
			return
		end

		local var_6_0 = arg_3_0.musicPlayer

		var_0.Next(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.playLoopBtn

	local function var_3_11()
		getProxy = var_2_10000
		AppreciateProxy = var_2_10001

		local var_7_0 = var_2_10000(var_2_10001)
		local var_7_1 = var_0.getMusicPlayerLoopType(var_7_0)

		switch = var_7_0

		var_7_0(var_7_1, {
			list = function()
				var_7_1 = "random"

				return
			end,
			random = function()
				var_7_1 = "one"

				return
			end,
			one = function()
				var_7_1 = "list"

				return
			end
		})

		pg = var_7_0

		local var_7_2 = var_7_0.m02
		local var_7_3 = var_1.sendNotification

		GAME = var_3

		var_7_3(var_7_2, var_3.APPRECIATE_CHANGE_MUSIC_PLAY_LOOP_TYPE, {
			loopType = var_7_1
		})

		local var_7_4 = arg_3_0

		var_1.updatePlayType(var_7_4, var_7_1)

		if arg_3_0.musicPlayer then
			local var_7_5 = arg_3_0.musicPlayer

			var_1.ChangeData(var_7_5, {
				loopType = var_7_1
			})
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_9, var_3_10, var_3_11, var_1_10005)

	onButton = var_1

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.likeToggle

	local function var_3_14()
		local var_11_0 = arg_3_0.musicPlayer
		local var_11_1 = var_0.GetCurrentMusicId(var_11_0)

		pg = var_11_0

		local var_11_2 = var_11_0.music_collect_config[var_11_1].id

		pg = var_2_10003

		local var_11_3 = var_2_10003.m02
		local var_11_4 = var_3.sendNotification

		GAME = var_2_10005

		var_11_4(var_11_3, var_2_10005.APPRECIATE_MUSIC_LIKE, {
			musicID = var_11_2,
			isAdd = arg_3_0.isLike and 1 or 0
		})

		local var_11_5 = arg_3_0

		var_11_5.isLike = not arg_3_0.isLike
		setActive = var_11_5

		local var_11_6 = arg_3_0.likeToggle

		var_11_5(var_4.Find(var_11_6, "On"), arg_3_0.isLike)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_12, var_3_13, var_3_14, var_1_10005)

	onButton = var_1

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.btnIcon

	local function var_3_17()
		if not arg_3_0.isOpen then
			return
		end

		pg = var_0

		local var_12_0 = var_0.m02
		local var_12_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_12_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		local var_12_3 = var_2_10003.COLLECTSHIP
		local var_12_4 = {}

		CollectionScene = var_2_10005
		var_12_4.toggle = var_2_10005.MUSIC_INDEX

		var_12_1(var_12_0, var_12_2, var_12_3, var_12_4)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_15, var_3_16, var_3_17, var_1_10005)

	return
end

function var_0_1.Show(arg_13_0, arg_13_1)
	setActive = var_1_10002

	var_1_10002(arg_13_0.btnExtend, arg_13_1)

	if arg_13_1 then
		arg_13_0.isOpen = false
	else
		arg_13_0.isOpen = true
	end

	setActive = var_1_10002

	local var_13_0 = arg_13_0.btnExtend

	var_1_10002(var_3.Find(var_13_0, "on"), not arg_13_0.isOpen)

	setActive = var_1_10002

	local var_13_1 = arg_13_0.btnExtend

	var_1_10002(var_3.Find(var_13_1, "off"), arg_13_0.isOpen)

	assert = var_1_10002

	local var_13_2 = arg_13_0.bgmMgr

	var_1_10002(var_3.GetNow(var_13_2) == "MainMusicPlayer")

	local var_13_3 = arg_13_0.bgmMgr

	arg_13_0.musicPlayer = var_2.GetMusicPlayer(var_13_3)
	getProxy = var_2
	AppreciateProxy = var_13_3

	local var_13_4 = var_2(var_13_3)
	local var_13_5 = var_2.isLikedByMusicID
	local var_13_6 = arg_13_0.musicPlayer

	arg_13_0.isLike = var_13_5(var_13_4, var_4.GetCurrentMusicId(var_13_6))

	arg_13_0:UpdatePlayerDisplay()
	arg_13_0:updatePlayType()

	local var_13_7 = arg_13_0.bgmMgr

	var_2.RegisterMusicCallback(var_13_7, arg_13_0.__cname, "MainMusicPlayer", {
		startCall = function(arg_14_0)
			local var_14_0 = arg_13_0

			getProxy = var_2_10002
			AppreciateProxy = var_2_10003

			local var_14_1 = var_2_10002(var_2_10003)
			local var_14_2 = var_2.isLikedByMusicID
			local var_14_3 = arg_13_0.musicPlayer

			var_14_0.isLike = var_14_2(var_14_1, var_4.GetCurrentMusicId(var_14_3))

			local var_14_4 = arg_13_0

			var_1.UpdatePlayerDisplay(var_14_4)

			return
		end
	})
	var_0_1.super.Show(arg_13_0)

	return
end

function var_0_1.UpdatePlayerDisplay(arg_15_0)
	local var_15_0 = arg_15_0.musicPlayer
	local var_15_1 = var_1.GetCurrentMusicId(var_15_0)

	pg = var_15_0

	local var_15_2 = var_15_0.music_collect_config[var_15_1].album_id

	pg = var_1_10003

	local var_15_3 = var_1_10003.music_album[var_15_2].cover

	MusicCollectionConst = var_1_10004

	local var_15_4

	var_15_4, GetImageSpriteFromAtlasAsync = var_1_10004.MUSIC_COVER_PATH_PREFIX .. var_15_3, var_5

	local var_15_5 = ""
	local var_15_6 = arg_15_0.rtContainer

	var_5(var_15_4, var_15_5, var_8.Find(var_15_6, "icon/face"), false)

	setActive = var_5

	local var_15_7 = arg_15_0.rtContainer

	var_5(var_6.Find(var_15_7, "LikeBtn/On"), arg_15_0.isLike)

	return
end

function var_0_1.updatePlayType(arg_16_0, arg_16_1)
	if not arg_16_1 then
		getProxy = var_1_10002
		AppreciateProxy = var_1_10003

		local var_16_0 = var_1_10002(var_1_10003)

		arg_16_1 = var_1_10002.getMusicPlayerLoopType(var_16_0)
	end

	eachChild = var_1_10002

	var_1_10002(arg_16_0.playLoopBtn, function(arg_17_0, arg_17_1)
		setActive = var_2_10002

		var_2_10002(arg_17_0, arg_17_0.name == arg_16_1)

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_18_0)
	local var_18_0 = arg_18_0.bgmMgr

	var_1.UnregisterMusicCallback(var_18_0, arg_18_0.__cname)

	arg_18_0.bgmMgr = nil
	arg_18_0.musicPlayer = nil

	return
end

return var_0_1

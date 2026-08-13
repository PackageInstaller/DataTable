class = var_0_10000

local var_0_0 = "MusicGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))
local var_0_2 = false
local var_0_3 = 0.95
local var_0_4 = 0
local var_0_5 = 1
local var_0_6 = 3
local var_0_7 = 5
local var_0_8 = 2

function var_0_1.getUIName(arg_1_0)
	return "MusicGameUI"
end

function var_0_1.MyGetRuntimeData(arg_2_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)
	local var_2_1 = var_1.getData(var_2_0).id

	checkExist = var_2_0

	local var_2_2 = arg_2_0:GetMGData()
	local var_2_3

	if not var_2_0(var_3.GetRuntimeData(var_2_2, "elements"), {
		1
	}) then
		var_2_3 = 0
	end

	arg_2_0.achieve_times = var_2_3
	PlayerPrefs = var_2_3
	arg_2_0.isFirstgame = var_2_3.GetInt("musicgame_first_" .. var_2_1)
	arg_2_0.bestScorelist = {}

	for iter_2_0 = 1, arg_2_0.music_amount * 2 do
		local var_2_4 = arg_2_0:GetMGData()
		local var_2_5 = var_6.GetRuntimeData(var_2_4, "elements")
		local var_2_6 = arg_2_0.bestScorelist

		checkExist = var_8

		local var_2_7

		if not var_8(var_2_5, {
			iter_2_0 + 2
		}) then
			var_2_7 = 0
		end

		var_2_6[iter_2_0] = var_2_7
	end

	arg_2_0:updatSelectview()

	return
end

function var_0_1.MyStoreDataToServer(arg_3_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_1 = var_1.getData(var_3_0).id
	local var_3_2 = {
		arg_3_0.achieve_times,
		1
	}

	PlayerPrefs = var_3

	var_3.SetInt("musicgame_first_" .. var_3_1, 1)

	for iter_3_0 = 1, arg_3_0.music_amount * 2 do
		table = var_1_10007

		var_1_10007.insert(var_3_2, iter_3_0 + 2, arg_3_0.bestScorelist[iter_3_0])
	end

	arg_3_0:StoreDataToServer(var_3_2)

	return
end

function var_0_1.init(arg_4_0)
	arg_4_0.useGetKey_flag = true
	arg_4_0.game_playingflag = false
	arg_4_0.countingfive_flag = false
	arg_4_0.downingleft_flag = false
	arg_4_0.downingright_flag = false
	arg_4_0.downingright_lastflag = false
	arg_4_0.downingleft_lastflag = false
	arg_4_0.nowS_flag = false
	arg_4_0.firstview_timerRunflag = false
	arg_4_0.ahead_timeflag = false
	arg_4_0.ahead_timerPauseFlag = false
	arg_4_0.changeLocalposTimerflag = false
	arg_4_0.piecelist_rf = {}
	arg_4_0.piecelist_rf[0] = 0
	arg_4_0.piecelist_lf = {}
	arg_4_0.piecelist_lf[0] = 0
	arg_4_0.piece_nowl = {}
	arg_4_0.piece_nowr = {}
	arg_4_0.piece_nowl_downflag = false
	arg_4_0.piece_nowr_downflag = false
	arg_4_0.piece_nowl_aloneflag = false
	arg_4_0.piece_nowr_aloneflag = false
	arg_4_0.SDmodel = {}
	arg_4_0.SDmodel_idolflag = false
	arg_4_0.musicgame_nowtime = 0
	arg_4_0.musicgame_lasttime = 0
	arg_4_0.time_interval = 0.01666
	pg = var_1
	arg_4_0.music_amount = #var_1.beat_game_music.all
	math = var_1

	local var_4_0 = var_1.ceil

	pg = var_2
	arg_4_0.music_amount_middle = var_4_0(#var_2.beat_game_music.all / 2)
	arg_4_0.musicDatas = {}

	local var_4_1 = 1

	pg = var_2

	for iter_4_0 = var_4_1, #var_2.beat_game_music.all do
		pg = var_1_10005
		var_1_10005 = var_1_10005.beat_game_music.all[iter_4_0]
		pg = var_1_10006
		var_1_10006 = var_1_10006.beat_game_music[var_1_10005]
		table = var_1_10007

		var_1_10007.insert(arg_4_0.musicDatas, var_1_10006)
	end

	table = var_4_1

	var_4_1.sort(arg_4_0.musicDatas, function(arg_5_0, arg_5_1)
		if arg_5_0.sort and arg_5_1.sort then
			return arg_5_0.sort < arg_5_1.sort
		end

		return arg_5_0.id < arg_5_1.id
	end)

	PlayerPrefs = var_1

	if var_1.GetInt("musicgame_idol_speed") > 0 then
		PlayerPrefs = var_1

		local var_4_2

		if not var_1.GetInt("musicgame_idol_speed") then
			var_4_2 = 1
		end

		arg_4_0.game_speed = var_4_2
		arg_4_0.game_dgree = 1

		local var_4_3 = arg_4_0._tf

		arg_4_0.countContent = var_1.Find(var_4_3, "countContent")
		arg_4_0.countTf = nil

		local var_4_4 = arg_4_0._tf

		arg_4_0.top = var_1.Find(var_4_4, "top")

		local var_4_5 = arg_4_0.top

		arg_4_0.btn_pause = var_1.Find(var_4_5, "pause")

		local var_4_6 = arg_4_0.top

		arg_4_0.score = var_1.Find(var_4_6, "score")

		local var_4_7 = arg_4_0._tf

		arg_4_0.game_content = var_1.Find(var_4_7, "GameContent")

		local var_4_8 = arg_4_0.game_content

		arg_4_0.noteTpl = var_1.Find(var_4_8, "noteTpl")

		local var_4_9 = arg_4_0._tf

		arg_4_0.pauseview = var_1.Find(var_4_9, "Pauseview")

		local var_4_10 = arg_4_0._tf

		arg_4_0.selectview = var_1.Find(var_4_10, "Selectview")
		findTF = var_1

		local var_4_11 = var_1(arg_4_0.selectview, "bg")

		LoadSpriteAtlasAsync = var_2

		var_2("ui/minigameui/musicgameother_atlas", "selectbg", function(arg_6_0)
			GetComponent = var_2_10001

			local var_6_0 = var_4_11

			typeof = var_2_10003
			Image = var_2_10004

			local var_6_1 = var_2_10001(var_6_0, var_2_10003(var_2_10004))

			var_6_1.sprite = arg_6_0
			setActive = var_6_1

			var_6_1(var_4_11, true)

			return
		end)

		local var_4_12 = arg_4_0._tf

		arg_4_0.firstview = var_2.Find(var_4_12, "firstview")

		local var_4_13 = arg_4_0._tf

		arg_4_0.scoreview = var_2.Find(var_4_13, "ScoreView")
		setActive = var_2

		var_2(arg_4_0.scoreview, false)

		arg_4_0.scoreview_flag = false
		findTF = var_2
		arg_4_0.bg = var_2(arg_4_0._tf, "bg")
		pg = var_2

		local var_4_14 = var_2.BgmMgr.GetInstance()

		var_2.StopPlay(var_4_14)
		arg_4_0:updateMusic(var_0_5)

		return
	end
end

function var_0_1.didEnter(arg_7_0)
	local var_7_0 = 0

	local function var_7_1()
		var_7_0 = var_7_0 + arg_7_0.time_interval

		if var_7_0 == arg_7_0.time_interval then
			local var_8_0 = arg_7_0

			var_0.MyGetRuntimeData(var_8_0)

			local var_8_1 = arg_7_0

			var_0.showSelevtView(var_8_1)
		elseif var_7_0 == arg_7_0.time_interval * 2 then
			local var_8_2 = arg_7_0

			var_0.updatSelectview(var_8_2)

			local var_8_3 = arg_7_0.Getdata_timer

			var_0.Stop(var_8_3)
		end

		return
	end

	LeanTween = var_1_10003

	local var_7_2 = var_1_10003.delayedCall

	go = var_1_10004

	local var_7_3 = var_1_10004(arg_7_0.selectview)
	local var_7_4 = 2

	System = var_1_10006

	var_7_2(var_7_3, var_7_4, var_1_10006.Action(function()
		local var_9_0 = arg_7_0

		var_0.MyGetRuntimeData(var_9_0)

		return
	end))

	Timer = var_7_2
	arg_7_0.Getdata_timer = var_7_2.New(var_7_1, arg_7_0.time_interval, -1)

	local var_7_5 = arg_7_0.Getdata_timer

	var_3.Start(var_7_5)

	arg_7_0.score_number = 0
	arg_7_0.combo_link = 0
	arg_7_0.combo_number = 0
	arg_7_0.perfect_number = 0
	arg_7_0.good_number = 0
	arg_7_0.miss_number = 0

	local var_7_6 = arg_7_0:GetMGData()

	arg_7_0.piecelist_speed = var_3.getConfig(var_7_6, "simple_config_data").speed
	arg_7_0.piecelist_speedmin = var_3.speed_min
	arg_7_0.piecelist_speedmax = var_3.speed_max
	arg_7_0.specialcombo_number = var_3.special_combo
	arg_7_0.specialscore_number = var_3.special_score
	arg_7_0.score_perfect = var_3.perfect
	arg_7_0.score_good = var_3.good
	arg_7_0.score_miss = var_3.miss
	arg_7_0.score_combo = var_3.combo
	arg_7_0.time_perfect = var_3.perfecttime
	arg_7_0.time_good = var_3.goodtime
	arg_7_0.time_miss = var_3.misstime
	arg_7_0.time_laterperfect = var_3.laterperfecttime
	arg_7_0.time_latergood = var_3.latergoodtime
	arg_7_0.combo_interval = var_3.combo_interval
	GetOrAddComponent = var_4

	local var_7_7 = arg_7_0.game_content

	arg_7_0.BtnRightDelegate = var_4(var_5.Find(var_7_7, "btn_right"), "EventTriggerListener")

	local var_7_8 = arg_7_0.BtnRightDelegate

	var_4.AddPointDownFunc(var_7_8, function()
		local var_10_0 = arg_7_0

		var_10_0.mousedowningright_flag = true
		setActive = var_10_0

		var_10_0(arg_7_0.bottonRightBg, true)

		return
	end)

	local var_7_9 = arg_7_0.BtnRightDelegate

	var_4.AddPointUpFunc(var_7_9, function()
		local var_11_0 = arg_7_0

		var_11_0.mousedowningright_flag = false
		setActive = var_11_0

		var_11_0(arg_7_0.bottonRightBg, false)

		return
	end)

	GetOrAddComponent = var_4

	local var_7_10 = arg_7_0.game_content

	arg_7_0.BtnLeftDelegate = var_4(var_5.Find(var_7_10, "btn_left"), "EventTriggerListener")

	local var_7_11 = arg_7_0.BtnLeftDelegate

	var_4.AddPointDownFunc(var_7_11, function()
		local var_12_0 = arg_7_0

		var_12_0.mousedowningleft_flag = true
		setActive = var_12_0

		var_12_0(arg_7_0.bottonLeftBg, true)

		return
	end)

	local var_7_12 = arg_7_0.BtnLeftDelegate

	var_4.AddPointUpFunc(var_7_12, function()
		local var_13_0 = arg_7_0

		var_13_0.mousedowningleft_flag = false
		setActive = var_13_0

		var_13_0(arg_7_0.bottonLeftBg, false)

		return
	end)

	onButton = var_4

	local var_7_13 = arg_7_0
	local var_7_14 = arg_7_0.top
	local var_7_15 = var_6.Find(var_7_14, "pause")

	local function var_7_16()
		pg = var_2_10000

		local var_14_0 = var_2_10000.UIMgr.GetInstance()

		var_0.BlurPanel(var_14_0, arg_7_0.pauseview)

		setActive = var_0

		var_0(arg_7_0.pauseview, true)

		arg_7_0.game_playingflag = false

		local var_14_1 = arg_7_0

		var_0.effect_play(var_14_1, "nothing")

		LoadSpriteAtlasAsync = var_0

		var_0("ui/minigameui/musicgameother_atlas", "pause_" .. arg_7_0.musicData.picture, function(arg_15_0)
			setImageSprite = var_3_10001

			local var_15_0 = arg_7_0.pauseview

			var_3_10001(var_2.Find(var_15_0, "bottom/song"), arg_15_0, true)

			return
		end)

		GetComponent = var_0

		local var_14_2 = arg_7_0.pauseview
		local var_14_3 = var_1.Find(var_14_2, "bottom/img")

		typeof = var_14_2
		Image = var_3

		local var_14_4 = var_0(var_14_3, var_14_2(var_3))

		var_0.SetNativeSize(var_14_4)

		local var_14_7

		if not arg_7_0.ahead_timeflag then
			local var_14_5 = arg_7_0

			var_14_7.pauseBgm(var_14_5)

			local var_14_6 = arg_7_0

			var_14_7 = var_14_7.getStampTime(var_14_6)

			local var_14_8 = arg_7_0.song_Tlength

			if var_14_7 < 0 then
				var_14_7 = 0
			end

			if var_14_7 >= 0 and var_14_8 > 0 then
				local function var_14_9(arg_16_0)
					if arg_16_0 < 10 then
						return "0" .. arg_16_0
					else
						return arg_16_0
					end

					return
				end

				math = var_2_10004

				local var_14_10 = var_14_9(var_2_10004.floor(var_14_7 % 60000 / 1000))
				local var_14_11 = var_2

				math = var_5

				local var_14_12 = var_14_11(var_5.floor(var_14_7 / 60000))

				setText = var_5

				local var_14_13 = arg_7_0.pauseview

				var_5(var_6.Find(var_14_13, "bottom/now"), var_14_12 .. ":" .. var_14_10)

				local var_14_14 = var_2

				math = var_6

				local var_14_15 = var_14_14(var_6.floor(var_14_8 % 60000 / 1000))
				local var_14_16 = var_2

				math = var_6

				local var_14_17 = var_14_16(var_6.floor(var_14_8 / 60000))

				setText = var_5

				local var_14_18 = arg_7_0.pauseview

				var_5(var_6.Find(var_14_18, "bottom/total"), var_14_17 .. ":" .. var_14_15)

				setActive = var_5

				local var_14_19 = arg_7_0.pauseview

				var_5(var_6.Find(var_14_19, "bottom/triangle"), true)

				setActive = var_5

				local var_14_20 = arg_7_0.pauseview

				var_5(var_6.Find(var_14_20, "bottom/TimeSlider"), true)

				setActive = var_5

				local var_14_21 = arg_7_0.pauseview

				var_5(var_6.Find(var_14_21, "bottom/now"), true)

				setActive = var_5

				local var_14_22 = arg_7_0.pauseview

				var_5(var_6.Find(var_14_22, "bottom/total"), true)

				setSlider = var_5

				local var_14_23 = arg_7_0.pauseview

				var_5(var_6.Find(var_14_23, "bottom/TimeSlider"), 0, 1, var_14_7 / var_14_8)

				local var_14_24 = arg_7_0.pauseview
				local var_14_25 = var_5.Find(var_14_24, "bottom/triangle/min").localPosition.x
				local var_14_26 = arg_7_0.pauseview
				local var_14_27 = var_6.Find(var_14_26, "bottom/triangle/max").localPosition.x
				local var_14_28 = arg_7_0.pauseview
				local var_14_29 = var_7.Find(var_14_28, "bottom/triangle/now").localPosition
				local var_14_30 = arg_7_0.pauseview
				local var_14_31 = var_8.Find(var_14_30, "bottom/triangle/now")

				Vector3 = var_14_30
				var_14_31.localPosition = var_14_30(var_14_25 + var_14_7 / var_14_8 * (var_14_27 - var_14_25), var_14_29.y, var_14_29.z)

				local var_14_32 = arg_7_0

				var_8.setActionSDmodel(var_14_32, "stand2")
			end
		else
			setActive = var_14_7

			local var_14_33 = arg_7_0.pauseview

			var_14_7(var_1.Find(var_14_33, "bottom/triangle"), false)

			setActive = var_14_7

			local var_14_34 = arg_7_0.pauseview

			var_14_7(var_1.Find(var_14_34, "bottom/TimeSlider"), false)

			setActive = var_14_7

			local var_14_35 = arg_7_0.pauseview

			var_14_7(var_1.Find(var_14_35, "bottom/now"), false)

			setActive = var_14_7

			local var_14_36 = arg_7_0.pauseview

			var_14_7(var_1.Find(var_14_36, "bottom/total"), false)

			arg_7_0.ahead_timerPauseFlag = true
		end

		return
	end

	SFX_UI_CLICK = var_8

	var_4(var_7_13, var_7_15, var_7_16, var_8)

	onButton = var_4

	local var_7_17 = arg_7_0
	local var_7_18 = arg_7_0.pauseview
	local var_7_19 = var_6.Find(var_7_18, "bottom/back")

	local function var_7_20()
		pg = var_2_10000

		local var_17_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_17_1 = var_0.ShowMsgBox
		local var_17_2 = {}

		i18n = var_2_10003
		var_17_2.content = var_2_10003("reselect_music_game")

		function var_17_2.onYes()
			pg = var_3_10000

			local var_18_0 = var_3_10000.UIMgr.GetInstance()

			var_0.UnOverlayPanel(var_18_0, arg_7_0.pauseview, arg_7_0._tf)

			setActive = var_0

			var_0(arg_7_0.pauseview, false)

			local var_18_1 = arg_7_0

			var_0.stopTimer(var_18_1)

			local var_18_3

			if arg_7_0.ahead_timer then
				local var_18_2 = arg_7_0.ahead_timer

				var_18_3.Stop(var_18_2)

				var_18_3 = arg_7_0
				var_18_3.ahead_timeflag = false
			end

			setActive = var_18_3

			var_18_3(arg_7_0.selectview, true)

			local var_18_4 = arg_7_0

			var_0.openCoinLayer(var_18_4, true)

			GetOrAddComponent = var_0
			var_0(arg_7_0.selectview, "CanvasGroup").blocksRaycasts = true

			local var_18_5 = arg_7_0.song_btns[arg_7_0.game_music]
			local var_18_6 = var_0.GetComponent

			typeof = var_2
			Animator = var_3

			local var_18_7 = var_18_6(var_18_5, var_2(var_3))

			var_0.Play(var_18_7, "plate_out")

			arg_7_0.game_playingflag = false

			local var_18_8 = arg_7_0

			var_0.loadAndPlayMusic(var_18_8)

			local var_18_9 = arg_7_0

			var_0.rec_scorce(var_18_9)

			return
		end

		var_17_1(var_17_0, var_17_2)

		return
	end

	SFX_UI_CLICK = var_8

	var_4(var_7_17, var_7_19, var_7_20, var_8)

	onButton = var_4

	local var_7_21 = arg_7_0
	local var_7_22 = arg_7_0.pauseview
	local var_7_23 = var_6.Find(var_7_22, "bottom/restart")

	local function var_7_24()
		pg = var_2_10000

		local var_19_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_19_1 = var_0.ShowMsgBox
		local var_19_2 = {}

		i18n = var_2_10003
		var_19_2.content = var_2_10003("restart_music_game")

		function var_19_2.onYes()
			pg = var_3_10000

			local var_20_0 = var_3_10000.UIMgr.GetInstance()

			var_0.UnOverlayPanel(var_20_0, arg_7_0.pauseview, arg_7_0._tf)

			setActive = var_0

			var_0(arg_7_0.pauseview, false)

			local var_20_1 = arg_7_0

			var_0.stopTimer(var_20_1)

			if arg_7_0.ahead_timer then
				local var_20_2 = arg_7_0.ahead_timer

				var_0.Stop(var_20_2)

				arg_7_0.ahead_timeflag = false
			end

			local var_20_3 = arg_7_0

			var_0.rec_scorce(var_20_3)

			local var_20_4 = arg_7_0

			var_0.game_start(var_20_4)

			local var_20_5 = arg_7_0

			var_0.effect_play(var_20_5, "prepare")

			return
		end

		var_19_1(var_19_0, var_19_2)

		return
	end

	SFX_UI_CLICK = var_8

	var_4(var_7_21, var_7_23, var_7_24, var_8)

	onButton = var_4

	local var_7_25 = arg_7_0
	local var_7_26 = arg_7_0.pauseview
	local var_7_27 = var_6.Find(var_7_26, "bottom/resume")

	local function var_7_28()
		pg = var_2_10000

		local var_21_0 = var_2_10000.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_21_0, arg_7_0.pauseview, arg_7_0._tf)

		setActive = var_0

		var_0(arg_7_0.pauseview, false)

		local var_21_1 = arg_7_0

		var_0.effect_play(var_21_1, "prepare")

		if not arg_7_0.ahead_timeflag then
			local function var_21_2()
				local var_22_0 = arg_7_0

				var_0.resumeBgm(var_22_0)

				arg_7_0.game_playingflag = true

				return
			end

			local var_21_3 = arg_7_0

			var_1.count_five(var_21_3, var_21_2)
		else
			local function var_21_4()
				arg_7_0.ahead_timerPauseFlag = false

				local var_23_0 = arg_7_0

				var_23_0.game_playingflag = true
				setActive = var_23_0

				local var_23_1 = arg_7_0.pauseview

				var_23_0(var_1.Find(var_23_1, "bottom/triangle"), true)

				setActive = var_23_0

				local var_23_2 = arg_7_0.pauseview

				var_23_0(var_1.Find(var_23_2, "bottom/TimeSlider"), true)

				setActive = var_23_0

				local var_23_3 = arg_7_0.pauseview

				var_23_0(var_1.Find(var_23_3, "bottom/now"), true)

				setActive = var_23_0

				local var_23_4 = arg_7_0.pauseview

				var_23_0(var_1.Find(var_23_4, "bottom/total"), true)

				return
			end

			local var_21_5 = arg_7_0

			var_1.count_five(var_21_5, var_21_4)
		end

		return
	end

	SFX_UI_CLICK = var_8

	var_4(var_7_25, var_7_27, var_7_28, var_8)
	arg_7_0:addRingDragListenter()

	setActive = var_4

	var_4(arg_7_0.selectview, true)
	arg_7_0:openCoinLayer(true)

	GetOrAddComponent = var_4
	var_4(arg_7_0.selectview, "CanvasGroup").blocksRaycasts = true

	return
end

function var_0_1.updateBg(arg_24_0)
	if arg_24_0.isLoading then
		arg_24_0:dynamicBgHandler(arg_24_0.bgGo, function()
			setParent = var_2_10000

			var_2_10000(arg_24_0.bgGo, arg_24_0.bg)

			setActive = var_2_10000

			var_2_10000(arg_24_0.bgGo, true)

			return
		end)

		return
	end

	if arg_24_0.bgGo and arg_24_0.bgName then
		arg_24_0:dynamicBgHandler(arg_24_0.bgGo)

		PoolMgr = var_1

		local var_24_0 = var_1.GetInstance()

		var_1.ReturnUI(var_24_0, arg_24_0.bgName, arg_24_0.bgGo)
	end

	arg_24_0.bgName = "musicgamebg" .. arg_24_0.musicBg
	arg_24_0.isLoading = true

	local var_24_1 = arg_24_0.bgName

	PoolMgr = var_2

	local var_24_2 = var_2.GetInstance()

	var_2.GetUI(var_24_2, "" .. var_24_1, true, function(arg_26_0)
		arg_24_0.bgGo = arg_26_0

		if arg_24_0.isLoading == false then
			local var_26_0 = arg_24_0

			var_1.dynamicBgHandler(var_26_0, arg_24_0.bgGo)

			PoolMgr = var_1

			local var_26_1 = var_1.GetInstance()

			var_1.ReturnUI(var_26_1, var_24_1, arg_24_0.bgGo)
		else
			local var_26_2 = arg_24_0

			var_26_2.isLoading = false
			setParent = var_26_2

			var_26_2(arg_24_0.bgGo, arg_24_0.bg)

			setActive = var_26_2

			var_26_2(arg_24_0.bgGo, true)
		end

		return
	end)

	return
end

function var_0_1.dynamicBgHandler(arg_27_0, arg_27_1, arg_27_2)
	IsNil = var_1_10003

	if var_1_10003(arg_27_1) then
		return
	end

	if arg_27_2 ~= nil then
		arg_27_2()
	end

	return
end

function var_0_1.onBackPressed(arg_28_0)
	if not arg_28_0.countingfive_flag and not arg_28_0.firstview_timerRunflag then
		if arg_28_0.game_playingflag then
			isActive = var_1

			local var_28_0 = arg_28_0.top

			if not var_1(var_2.Find(var_28_0, "pause_above")) then
				triggerButton = var_1

				local var_28_1 = arg_28_0.top

				var_1(var_2.Find(var_28_1, "pause"))
			end
		else
			isActive = var_1

			if var_1(arg_28_0.selectview) and var_0_4 == 0 then
				arg_28_0:emit(var_0_1.ON_BACK)
			end
		end
	end

	return
end

function var_0_1.OnApplicationPaused(arg_29_0, arg_29_1)
	if arg_29_1 and not arg_29_0.countingfive_flag and not arg_29_0.firstview_timerRunflag and arg_29_0.game_playingflag then
		isActive = var_2

		local var_29_0 = arg_29_0.top

		if not var_2(var_3.Find(var_29_0, "pause_above")) then
			triggerButton = var_2

			local var_29_1 = arg_29_0.top

			var_2(var_3.Find(var_29_1, "pause"))
		end
	end

	return
end

function var_0_1.willExit(arg_30_0)
	arg_30_0.isLoading = false

	if arg_30_0.bgGo and arg_30_0.bgName then
		arg_30_0:dynamicBgHandler(arg_30_0.bgGo)

		PoolMgr = var_1

		local var_30_0 = var_1.GetInstance()

		var_1.ReturnUI(var_30_0, arg_30_0.bgName, arg_30_0.bgGo)
	end

	if arg_30_0.timer then
		if arg_30_0.timer.running then
			local var_30_1 = arg_30_0.timer

			var_1.Stop(var_30_1)
		end

		arg_30_0.timer = nil
	end

	if arg_30_0.ahead_timer then
		if arg_30_0.ahead_timer.running then
			local var_30_2 = arg_30_0.ahead_timer

			var_1.Stop(var_30_2)
		end

		arg_30_0.ahead_timer = nil
	end

	if arg_30_0.firstview_timer then
		if arg_30_0.firstview_timer.running then
			local var_30_3 = arg_30_0.firstview_timer

			var_1.Stop(var_30_3)
		end

		arg_30_0.firstview_timer = nil
	end

	if arg_30_0.changeLocalpos_timer then
		if arg_30_0.changeLocalpos_timer.running then
			local var_30_4 = arg_30_0.changeLocalpos_timer

			var_1.Stop(var_30_4)
		end

		arg_30_0.changeLocalpos_timer = nil
	end

	if arg_30_0.count_timer then
		if arg_30_0.count_timer.running then
			local var_30_5 = arg_30_0.count_timer

			var_1.Stop(var_30_5)
		end

		arg_30_0.count_timer = nil
	end

	if arg_30_0.Scoceview_timer then
		if arg_30_0.Scoceview_timer.running then
			local var_30_6 = arg_30_0.Scoceview_timer

			var_1.Stop(var_30_6)
		end

		arg_30_0.Scoceview_timer = nil
	end

	if arg_30_0.Getdata_timer then
		if arg_30_0.Getdata_timer.running then
			local var_30_7 = arg_30_0.Getdata_timer

			var_1.Stop(var_30_7)
		end

		arg_30_0.Getdata_timer = nil
	end

	local var_30_8 = arg_30_0

	arg_30_0.clearSDModel(var_30_8)

	arg_30_0.piecelist_lt = {}
	arg_30_0.piecelist_lf = {}
	arg_30_0.musictable_l = {}
	arg_30_0.piece_nowl = {}
	arg_30_0.piecelist_rt = {}
	arg_30_0.piecelist_rf = {}
	arg_30_0.musictable_r = {}
	arg_30_0.piece_nowr = {}

	if arg_30_0.painting then
		retPaintingPrefab = var_1

		local var_30_9 = arg_30_0.scoreview

		var_1(var_30_8.Find(var_30_9, "paint"), arg_30_0.painting)

		arg_30_0.painting = nil
	end

	if arg_30_0.criInfo then
		var_30_8 = arg_30_0.criInfo

		var_1.PlaybackStop(var_30_8)

		var_30_8 = arg_30_0.criInfo

		var_1.SetStartTimeAndPlay(var_30_8, 0)

		pg = var_1
		var_30_8 = var_1.CriMgr.GetInstance()

		var_1.UnloadCueSheet(var_30_8, arg_30_0:getMusicBgm(arg_30_0.musicData))

		arg_30_0.criInfo = nil
	end

	LeanTween = var_1

	local var_30_10 = var_1.isTweening

	go = var_30_8

	local var_30_11

	if var_30_10(var_30_8(arg_30_0.selectview)) then
		LeanTween = var_30_11
		var_30_11 = var_30_11.cancel
		go = var_2

		var_30_11(var_2(arg_30_0.selectview))
	end

	LeanTween = var_30_11

	local var_30_12 = var_30_11.isTweening

	go = var_2

	local var_30_13

	if var_30_12(var_2(arg_30_0.countContent)) then
		LeanTween = var_30_13
		var_30_13 = var_30_13.cancel
		go = var_2

		var_30_13(var_2(arg_30_0.countContent))
	end

	LeanTween = var_30_13

	local var_30_14 = var_30_13.isTweening

	go = var_2

	local var_30_15

	if var_30_14(var_2(arg_30_0.scoreview)) then
		LeanTween = var_30_15
		var_30_15 = var_30_15.cancel
		go = var_2

		var_30_15(var_2(arg_30_0.scoreview))
	end

	LeanTween = var_30_15

	local var_30_16 = var_30_15.isTweening

	go = var_2

	local var_30_17

	if var_30_16(var_2(arg_30_0.game_content)) then
		LeanTween = var_30_17
		var_30_17 = var_30_17.cancel
		go = var_2

		var_30_17(var_2(arg_30_0.game_content))
	end

	pg = var_30_17

	local var_30_18 = var_30_17.BgmMgr.GetInstance()

	var_1.ContinuePlay(var_30_18)

	return
end

function var_0_1.clearSDModel(arg_31_0)
	if not arg_31_0.SDmodel or not arg_31_0.SDname or arg_31_0.SDname == "" or arg_31_0.SDname == "none" then
		return
	end

	for iter_31_0 = 1, #arg_31_0.SDmodel do
		if arg_31_0.SDmodel[iter_31_0] then
			PoolMgr = var_5

			local var_31_0 = var_5.GetInstance()

			var_5.ReturnSpineChar(var_31_0, arg_31_0.SDname[iter_31_0], arg_31_0.SDmodel[iter_31_0])
		end
	end

	arg_31_0.SDmodel = {}

	return
end

function var_0_1.list_push(arg_32_0, arg_32_1, arg_32_2)
	arg_32_1[arg_32_1[0] + 1] = arg_32_2
	arg_32_1[0] = arg_32_1[0] + 1

	return
end

function var_0_1.list_pop(arg_33_0, arg_33_1)
	if arg_33_1[0] == 0 then
		return
	end

	local var_33_0 = arg_33_1[1]

	for iter_33_0 = 1, arg_33_1[0] - 1 do
		arg_33_1[iter_33_0] = arg_33_1[iter_33_0 + 1]
	end

	arg_33_1[0] = arg_33_1[0] - 1

	return var_33_0
end

function var_0_1.game_start(arg_34_0)
	arg_34_0:game_before()
	arg_34_0:effect_play("prepare")

	arg_34_0.game_playingflag = true
	arg_34_0.SDmodel_jumpcount = 0
	arg_34_0.gotspecialcombo_flag = false

	arg_34_0:updateBg()

	arg_34_0.song_Tlength = false

	arg_34_0:effect_play("nothing")
	arg_34_0:effect_play("prepare")

	if arg_34_0.isFirstgame == 0 then
		arg_34_0:Firstshow(arg_34_0.firstview, function()
			local var_35_0 = arg_34_0

			var_0.gameStart(var_35_0)

			return
		end, 2)
		arg_34_0:MyStoreDataToServer()
	else
		arg_34_0:gameStart()
	end

	return
end

function var_0_1.game_before(arg_36_0)
	arg_36_0:effect_play("nothing")

	arg_36_0.nowS_flag = false

	local var_36_0 = arg_36_0
	local var_36_1 = arg_36_0.setTfChildVisible
	local var_36_2 = arg_36_0.top

	var_36_1(var_36_0, var_3.Find(var_36_2, "scoreContent/scroll"), false)

	local var_36_3 = arg_36_0.top
	local var_36_4 = var_1.Find
	local var_36_5 = "scoreContent/scroll/"

	tostring = var_4
	arg_36_0.scoreSliderTf = var_36_4(var_36_3, var_36_5 .. var_4(arg_36_0.musicData.content_type))
	setSlider = var_1

	var_1(arg_36_0.scoreSliderTf, 0, 1, 0)

	setActive = var_1

	var_1(arg_36_0.scoreSliderTf, true)

	setActive = var_1
	findTF = var_2

	var_1(var_2(arg_36_0.scoreSliderTf, "img/mask/yinyue20_S"), false)

	arg_36_0.scoreSFlag = false
	setImageColor = var_1
	findTF = var_2

	local var_36_6 = var_2(arg_36_0.scoreSliderTf, "img")

	Color = var_3

	var_1(var_36_6, var_3(1, 1, 1, 1))

	local var_36_7 = arg_36_0.game_content
	local var_36_8 = var_1.Find(var_36_7, "evaluate")

	for iter_36_0 = 1, var_36_8.childCount do
		local var_36_9 = var_36_8:GetChild(iter_36_0 - 1)

		for iter_36_1 = 1, var_36_9.childCount do
			setActive = var_1_10011

			var_1_10011(var_36_9:GetChild(iter_36_1 - 1), false)
		end

		setActive = var_7
		findTF = var_8

		local var_36_10 = var_36_9

		tostring = iter_36_1

		var_7(var_8(var_36_10, iter_36_1(arg_36_0.musicData.content_type)), true)

		setActive = var_7

		var_7(var_36_8:GetChild(iter_36_0 - 1), false)
	end

	local var_36_11 = arg_36_0.game_content
	local var_36_12 = var_2.Find(var_36_11, "bottomList")

	for iter_36_2 = 1, var_36_12.childCount do
		local var_36_13 = var_36_12
		local var_36_14 = var_36_12.GetChild(var_36_13, iter_36_2 - 1)

		setActive = var_36_13

		var_36_13(var_36_14, false)
	end

	if arg_36_0.musicData.bottom_type and arg_36_0.musicData.bottom_type > 0 then
		local var_36_15 = arg_36_0.game_content

		arg_36_0.bottonLeftBg = var_3.Find(var_36_15, "bottomList/" .. arg_36_0.musicData.bottom_type .. "/bottom_leftbg")

		local var_36_16 = arg_36_0.game_content

		arg_36_0.bottonRightBg = var_3.Find(var_36_16, "bottomList/" .. arg_36_0.musicData.bottom_type .. "/bottom_rightbg")
		setActive = var_3

		var_3(arg_36_0.bottonLeftBg, false)

		setActive = var_3

		var_3(arg_36_0.bottonRightBg, false)

		setActive = var_3

		local var_36_17 = arg_36_0.game_content

		var_3(var_4.Find(var_36_17, "bottomList/" .. arg_36_0.musicData.bottom_type), true)

		setActive = var_3

		local var_36_18 = arg_36_0.game_content

		var_3(var_4.Find(var_36_18, "bottomList/" .. arg_36_0.musicData.bottom_type), true)
	end

	arg_36_0:clearSDModel()

	for iter_36_3 = 1, #arg_36_0.SDname do
		arg_36_0:loadSDModel(iter_36_3)
	end

	arg_36_0:setActionSDmodel("stand2")

	setActive = var_3

	local var_36_19 = arg_36_0.game_content

	var_3(var_4.Find(var_36_19, "combo"), false)

	setActive = var_3

	local var_36_20 = arg_36_0.game_content

	var_3(var_4.Find(var_36_20, "combo_n"), false)

	setActive = var_3

	local var_36_21 = arg_36_0.game_content

	var_3(var_4.Find(var_36_21, "MusicStar"), false)

	setActive = var_3

	var_3(arg_36_0.game_content, true)

	setActive = var_3

	local var_36_22 = arg_36_0._tf

	var_3(var_4.Find(var_36_22, "Spinelist"), true)

	setActive = var_3

	var_3(arg_36_0.top, true)

	setActive = var_3

	var_3(arg_36_0.fullComboEffect, false)

	setActive = var_3

	var_3(arg_36_0.liveClearEffect, false)

	local var_36_23 = arg_36_0
	local var_36_24 = arg_36_0.getMusicNote(var_36_23, arg_36_0.musicData, arg_36_0.game_dgree)

	require = var_36_23

	local var_36_25 = var_36_23(var_36_24)

	arg_36_0.leftPu = {}
	arg_36_0.rightPu = {}
	ipairs = var_5

	for iter_36_4, iter_36_5 in var_5(var_36_25.left_track) do
		table = iter_36_1

		iter_36_1.insert(arg_36_0.leftPu, iter_36_5)
	end

	ipairs = var_5

	for iter_36_6, iter_36_7 in var_5(var_36_25.right_track) do
		table = iter_36_1

		iter_36_1.insert(arg_36_0.rightPu, iter_36_7)
	end

	local var_36_26 = arg_36_0

	arg_36_0.setTfChildVisible(var_36_26, arg_36_0.noteTpl, false)

	if not arg_36_0.gameNoteLeft then
		MusicGameNote = var_5

		local var_36_27 = var_5.New

		findTF = var_36_26
		var_36_26 = var_36_26(arg_36_0.game_content, "MusicPieceLeft")

		local var_36_28 = arg_36_0.noteTpl

		MusicGameNote = var_8
		arg_36_0.gameNoteLeft = var_36_27(var_36_26, var_36_28, var_8.type_left)
	end

	if not arg_36_0.gameNoteRight then
		MusicGameNote = var_5

		local var_36_29 = var_5.New

		findTF = var_36_26

		local var_36_30 = var_36_26(arg_36_0.game_content, "MusicPieceRight")
		local var_36_31 = arg_36_0.noteTpl

		MusicGameNote = var_8
		arg_36_0.gameNoteRight = var_36_29(var_36_30, var_36_31, var_8.type_right)
	end

	local var_36_32 = arg_36_0.gameNoteLeft

	var_5.setStartData(var_36_32, arg_36_0.leftPu, arg_36_0.game_speed, arg_36_0.game_dgree, arg_36_0.noteType)

	local var_36_33 = arg_36_0.gameNoteLeft

	var_5.setStateCallback(var_36_33, function(arg_37_0)
		local var_37_0 = arg_36_0

		var_1.onStateCallback(var_37_0, arg_37_0)

		return
	end)

	local var_36_34 = arg_36_0.gameNoteLeft

	var_5.setLongTimeCallback(var_36_34, function(arg_38_0)
		local var_38_0 = arg_36_0

		var_1.onLongTimeCallback(var_38_0, arg_38_0)

		return
	end)

	local var_36_35 = arg_36_0.gameNoteRight

	var_5.setStartData(var_36_35, arg_36_0.rightPu, arg_36_0.game_speed, arg_36_0.game_dgree, arg_36_0.noteType)

	local var_36_36 = arg_36_0.gameNoteRight

	var_5.setStateCallback(var_36_36, function(arg_39_0)
		local var_39_0 = arg_36_0

		var_1.onStateCallback(var_39_0, arg_39_0)

		return
	end)

	local var_36_37 = arg_36_0.gameNoteRight

	var_5.setLongTimeCallback(var_36_37, function(arg_40_0)
		local var_40_0 = arg_36_0

		var_1.onLongTimeCallback(var_40_0, arg_40_0)

		return
	end)

	arg_36_0.gameStepTime = 0
	arg_36_0.musictable_l = {}
	arg_36_0.musictable_l[0] = 0
	arg_36_0.musictable_r = {}
	arg_36_0.musictable_r[0] = 0
	arg_36_0.nowmusic_l = nil
	arg_36_0.nowmusic_r = nil

	local var_36_38 = arg_36_0
	local var_36_39 = arg_36_0.getMusicNote(var_36_38, arg_36_0.musicData, arg_36_0.game_dgree)

	require = var_36_38
	arg_36_0.musicpu = var_36_38(var_36_39)
	ipairs = var_6

	for iter_36_8, iter_36_9 in var_6(arg_36_0.musicpu.left_track) do
		arg_36_0:list_push(arg_36_0.musictable_l, iter_36_9)
	end

	ipairs = var_6

	for iter_36_10, iter_36_11 in var_6(arg_36_0.musicpu.right_track) do
		arg_36_0:list_push(arg_36_0.musictable_r, iter_36_11)
	end

	local var_36_40 = arg_36_0.scoreSliderTf
	local var_36_41 = arg_36_0.top
	local var_36_42 = var_7.Find(var_36_41, "scoreContent/B")
	local var_36_43 = arg_36_0.top
	local var_36_44 = var_8.Find(var_36_43, "scoreContent/A")
	local var_36_45 = arg_36_0.top
	local var_36_46 = var_9.Find(var_36_45, "scoreContent/S")

	Vector3 = var_36_45
	var_36_42.anchoredPosition = var_36_45(arg_36_0.scoreSliderTf.anchoredPosition.x + var_36_40.rect.width * 0.53, var_36_42.anchoredPosition.y, var_36_42.anchoredPosition.z)
	Vector3 = var_10
	var_36_44.anchoredPosition = var_10(arg_36_0.scoreSliderTf.anchoredPosition.x + var_36_40.rect.width * 0.72, var_36_42.anchoredPosition.y, var_36_42.anchoredPosition.z)
	Vector3 = var_10
	var_36_46.anchoredPosition = var_10(arg_36_0.scoreSliderTf.anchoredPosition.x + var_36_40.rect.width * 0.885, var_36_42.anchoredPosition.y, var_36_42.anchoredPosition.z)

	arg_36_0:scoresliderAcombo_update()

	return
end

function var_0_1.stopTimer(arg_41_0)
	if arg_41_0.timer.running then
		local var_41_0 = arg_41_0.timer

		var_1.Stop(var_41_0)
	end

	return
end

function var_0_1.startTimer(arg_42_0)
	if not arg_42_0.timer.running then
		local var_42_0 = arg_42_0.timer

		var_1.Start(var_42_0)
	end

	return
end

function var_0_1.loadSDModel(arg_43_0, arg_43_1)
	local var_43_0

	if not arg_43_0.SDname[arg_43_1] or arg_43_0.SDname[arg_43_1] == "" or arg_43_0.SDname[arg_43_1] == "none" then
		var_43_0 = arg_43_0.SDmodel
		var_43_0[arg_43_1] = false
		setActive = var_43_0
		findTF = var_3

		var_43_0(var_3(arg_43_0._tf, "Spinelist/" .. arg_43_1 .. "/shadow"), false)

		setActive = var_43_0
		findTF = var_3

		var_43_0(var_3(arg_43_0._tf, "Spinelist/" .. arg_43_1 .. "/light"), false)

		return
	end

	findTF = var_43_0

	local var_43_1 = var_43_0(arg_43_0._tf, "Spinelist/" .. arg_43_1 .. "/light")

	findTF = var_3

	local var_43_2 = var_3(arg_43_0._tf, "Spinelist/" .. arg_43_1 .. "/shadow")

	findTF = var_4
	var_43_1.anchoredPosition = var_4(arg_43_0._tf, "Spinelist/" .. arg_43_1 .. "/" .. arg_43_0.musicData.content_type).anchoredPosition
	var_43_2.anchoredPosition = var_4.anchoredPosition
	setActive = var_5

	var_5(var_43_1, true)

	if arg_43_0.musicLight and arg_43_0.shadowLight then
		setActive = var_5
		findTF = var_6

		var_5(var_6(arg_43_0._tf, "Spinelist/" .. arg_43_1 .. "/shadow"), true)
	else
		setActive = var_5
		findTF = var_6

		var_5(var_6(arg_43_0._tf, "Spinelist/" .. arg_43_1 .. "/shadow"), false)
	end

	for iter_43_0 = 1, var_0_7 do
		local var_43_3

		if arg_43_0.musicLight then
			var_43_3 = arg_43_0.musicLight

			if 0 < var_43_3 then
				setActive = var_43_3
				findTF = var_1_10010

				var_43_3(var_1_10010(arg_43_0._tf, "Spinelist/" .. arg_43_1 .. "/light"), false)

				var_43_3 = iter_43_0

				if arg_43_0.musicData.ships[iter_43_0] and arg_43_0.musicData.ships[iter_43_0] ~= "" and arg_43_0.musicData.ships[iter_43_0] ~= "none" then
					LoadSpriteAtlasAsync = var_1_10010

					var_1_10010("ui/minigameui/musicgameother_atlas", "light" .. arg_43_0.musicLight, function(arg_44_0)
						setActive = var_2_10001
						findTF = var_2_10002

						var_2_10001(var_2_10002(arg_43_0._tf, "Spinelist/" .. var_43_3 .. "/light"), true)

						setImageSprite = var_2_10001
						findTF = var_2

						var_2_10001(var_2(arg_43_0._tf, "Spinelist/" .. var_43_3 .. "/light"), arg_44_0, true)

						return
					end)
				end
			end
		end

		setActive = var_43_3
		findTF = var_1_10010

		var_43_3(var_1_10010(arg_43_0._tf, "Spinelist/" .. arg_43_1 .. "/light"), false)
	end

	pg = var_5

	local var_43_4 = var_5.UIMgr.GetInstance()

	var_5.LoadingOff(var_43_4)

	PoolMgr = var_5

	local var_43_5 = var_5.GetInstance()

	var_5.GetSpineChar(var_43_5, arg_43_0.SDname[arg_43_1], true, function(arg_45_0)
		local var_45_0 = arg_43_0.SDmodel

		var_45_0[arg_43_1] = arg_45_0
		tf = var_45_0

		local var_45_1 = var_45_0(arg_45_0)

		Vector3 = var_2
		var_45_1.localScale = var_2(1, 1, 1)

		local var_45_2 = arg_45_0:GetComponent("SpineAnimUI")

		var_1.SetAction(var_45_2, "stand2", 0)

		setParent = var_1

		local var_45_3 = arg_45_0
		local var_45_4 = arg_43_0._tf

		var_1(var_45_3, var_3.Find(var_45_4, "Spinelist/" .. arg_43_1))

		local var_45_5 = arg_43_0._tf
		local var_45_6 = var_1.Find(var_45_5, "Spinelist/" .. arg_43_1 .. "/" .. arg_43_0.musicData.content_type)

		tf = var_45_5
		var_45_5(arg_45_0).anchoredPosition = var_45_6.anchoredPosition

		return
	end)

	return
end

function var_0_1.SDmodeljump_btnup(arg_46_0)
	if arg_46_0.downingright_flag or arg_46_0.downingleft_flag then
		arg_46_0.SDmodel_jumpcount = arg_46_0.SDmodel_jumpcount + arg_46_0.time_interval
		arg_46_0.SDmodel_jumpcount = arg_46_0.SDmodel_jumpcount > 1 and 1 or arg_46_0.SDmodel_jumpcount
	else
		if arg_46_0.SDmodel_jumpcount == 1 then
			arg_46_0:setActionSDmodel("jump")

			arg_46_0.SDmodel_idolflag = false
		end

		if arg_46_0.SDmodel_jumpcount > 0 then
			arg_46_0.SDmodel_jumpcount = arg_46_0.SDmodel_jumpcount - arg_46_0.time_interval
			arg_46_0.SDmodel_jumpcount = arg_46_0.SDmodel_jumpcount < 0 and 0 or arg_46_0.SDmodel_jumpcount
		end

		if arg_46_0.SDmodel_jumpcount == 0 and not arg_46_0.SDmodel_idolflag then
			arg_46_0.SDmodel_idolflag = true

			arg_46_0:setActionSDmodel("idol")
		end
	end

	return
end

function var_0_1.setActionSDmodel(arg_47_0, arg_47_1, arg_47_2)
	arg_47_2 = arg_47_2 or 0

	for iter_47_0 = 1, #arg_47_0.SDmodel do
		if arg_47_0.SDmodel[iter_47_0] then
			local var_47_0 = arg_47_0.SDmodel[iter_47_0]
			local var_47_1 = var_7.GetComponent(var_47_0, "SpineAnimUI")

			var_7.SetAction(var_47_1, arg_47_1, arg_47_2)
		end
	end

	return
end

function var_0_1.loadAndPlayMusic(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = arg_48_0:getMusicBgm(arg_48_0.musicData)

	var_0_4 = var_0_4 + 1
	CriWareMgr = var_4

	local var_48_1 = var_4.Inst
	local var_48_2 = var_4.PlayBGM
	local var_48_3 = var_48_0

	CriWareMgr = var_1_10007

	var_48_2(var_48_1, var_48_3, var_1_10007.CRI_FADE_TYPE.FADE_INOUT, function(arg_49_0)
		if arg_49_0 == nil then
			warning = var_2_10001

			local var_49_0 = "Missing BGM :"
			local var_49_1

			if not var_48_0 then
				var_49_1 = "NIL"
			end

			var_2_10001(var_49_0 .. var_49_1)
		else
			print = var_2_10001

			var_2_10001("加载完毕,开始播放音乐")

			if arg_48_0.countingfive_flag then
				return
			end

			arg_48_0.criInfo = arg_49_0
			arg_48_0.song_Tlength = arg_49_0:GetLength()

			arg_49_0:PlaybackStop()

			IsUnityEditor = var_1

			if var_1 and var_0_2 then
				local var_49_2 = arg_48_0.criInfo
				local var_49_3 = var_1.SetStartTimeAndPlay
				local var_49_4 = arg_48_0.criInfo

				var_49_3(var_49_2, var_3.GetLength(var_49_4) * var_0_3)
			else
				local var_49_5 = arg_49_0
				local var_49_6 = arg_49_0.SetStartTimeAndPlay
				local var_49_7

				if not arg_48_2 or not (arg_48_2 >= 0) or not arg_48_2 then
					var_49_7 = 0
				end

				var_49_6(var_49_5, var_49_7)
			end

			var_0_4 = var_0_4 - 1

			if arg_48_1 then
				arg_48_1()
			end
		end

		return
	end)

	return
end

function var_0_1.getStampTime(arg_50_0)
	if arg_50_0.aheadtime_count then
		return (arg_50_0.aheadtime_count - 2) * 1000
	elseif arg_50_0.criInfo then
		local var_50_0 = arg_50_0.criInfo

		return var_1.GetTime(var_50_0)
	end

	return nil
end

function var_0_1.pauseBgm(arg_51_0)
	if arg_51_0.criInfo then
		local var_51_0 = arg_51_0.criInfo

		arg_51_0.pauseTime = var_1.GetTime(var_51_0)

		local var_51_1 = arg_51_0.criInfo

		var_1.PlaybackStop(var_51_1)
	end

	if arg_51_0.timer and arg_51_0.timer.running then
		local var_51_2 = arg_51_0.timer

		var_1.Stop(var_51_2)
	end

	return
end

function var_0_1.resumeBgm(arg_52_0)
	if not arg_52_0.timer.running then
		local var_52_0 = arg_52_0.timer

		var_1.Start(var_52_0)
	end

	arg_52_0:loadAndPlayMusic(function()
		return
	end, arg_52_0.pauseTime)

	return
end

function var_0_1.rec_scorce(arg_54_0)
	arg_54_0.score_number = 0
	arg_54_0.combo_link = 0
	arg_54_0.combo_number = 0
	arg_54_0.perfect_number = 0
	arg_54_0.good_number = 0
	arg_54_0.miss_number = 0
	arg_54_0.gotspecialcombo_flag = false
	setActive = var_1

	local var_54_0 = arg_54_0.top

	var_1(var_2.Find(var_54_0, "scoreContent/B/bl"), false)

	setActive = var_1

	local var_54_1 = arg_54_0.top

	var_1(var_2.Find(var_54_1, "scoreContent/A/al"), false)

	setActive = var_1

	local var_54_2 = arg_54_0.top

	var_1(var_2.Find(var_54_2, "scoreContent/S/sl"), false)

	setText = var_1

	var_1(arg_54_0.gameScoreTf, 0)

	setText = var_1

	local var_54_3 = arg_54_0.game_content

	var_1(var_2.Find(var_54_3, "combo_n/" .. arg_54_0.musicData.content_type), 0)

	return
end

function var_0_1.effect_play(arg_55_0, arg_55_1, arg_55_2)
	if arg_55_1 == "nothing" then
		setActive = var_1_10003

		var_1_10003(arg_55_0.yinyuePefectLoop, false)

		setActive = var_1_10003

		local var_55_0 = arg_55_0.top

		var_1_10003(var_1_10004.Find(var_55_0, "scoreContent/S/liubianxing"), false)

		setActive = var_1_10003

		var_1_10003(arg_55_0.yinyueGood, false)

		setActive = var_1_10003

		var_1_10003(arg_55_0.yinyuePerfect, false)

		setActive = var_1_10003

		local var_55_1 = arg_55_0.game_content

		var_1_10003(var_1_10004.Find(var_55_1, "MusicStar"), false)

		SetActive = var_1_10003

		var_1_10003(arg_55_0.yinyueComboeffect, false)
	elseif arg_55_1 == "prepare" then
		-- block empty
	elseif arg_55_1 == "good" then
		setActive = var_1_10003

		var_1_10003(arg_55_0.yinyueGood, false)

		setActive = var_1_10003

		var_1_10003(arg_55_0.yinyueGood, true)
	elseif arg_55_1 == "perfect" then
		setActive = var_1_10003

		var_1_10003(arg_55_0.yinyuePerfect, false)

		setActive = var_1_10003

		var_1_10003(arg_55_0.yinyuePerfect, true)
	elseif arg_55_1 == "perfect_loop02" then
		if arg_55_2 then
			isActive = var_1_10003

			if not var_1_10003(arg_55_0.yinyuePefectLoop) then
				setActive = var_1_10003

				var_1_10003(arg_55_0.yinyuePefectLoop, true)
			end
		else
			setActive = var_1_10003

			var_1_10003(arg_55_0.yinyuePefectLoop, false)
		end
	elseif arg_55_1 == "S" then
		if arg_55_2 then
			setActive = var_1_10003
			findTF = var_1_10004

			var_1_10003(var_1_10004(arg_55_0.scoreSliderTf, "img/mask/yinyue20_S"), true)
		else
			setActive = var_1_10003
			findTF = var_1_10004

			var_1_10003(var_1_10004(arg_55_0.scoreSliderTf, "img/mask/yinyue20_S"), false)
		end
	end

	return
end

function var_0_1.scoresliderAcombo_update(arg_56_0)
	local var_56_0 = arg_56_0.score_number
	local var_56_1 = 0

	setText = var_1_10003

	var_1_10003(arg_56_0.gameScoreTf, arg_56_0.score_number)

	local var_56_2 = arg_56_0.game_music
	local var_56_3 = arg_56_0.game_dgree

	if var_56_0 < arg_56_0.score_blist[var_56_3] then
		var_56_1 = var_56_0 / arg_56_0.score_blist[var_56_3] * 0.53
	elseif arg_56_0.score_blist[var_56_3] <= var_56_0 and var_56_0 < arg_56_0.score_alist[var_56_3] then
		var_56_1 = 0.53 + (var_56_0 - arg_56_0.score_blist[var_56_3]) / (arg_56_0.score_alist[var_56_3] - arg_56_0.score_blist[var_56_3]) * 0.19
	elseif arg_56_0.score_alist[var_56_3] <= var_56_0 and var_56_0 < arg_56_0.score_slist[var_56_3] then
		var_56_1 = 0.72 + (var_56_0 - arg_56_0.score_alist[var_56_3]) / (arg_56_0.score_slist[var_56_3] - arg_56_0.score_alist[var_56_3]) * 0.155
	else
		var_56_1 = 0.885 + (var_56_0 - arg_56_0.score_slist[var_56_3]) / (arg_56_0.score_sslist[var_56_3] - arg_56_0.score_slist[var_56_3]) * 0.115
	end

	setSlider = var_5

	var_5(arg_56_0.scoreSliderTf, 0, 1, var_56_1)

	if var_56_1 < 0.53 then
		setActive = var_5

		local var_56_4 = arg_56_0.top

		var_5(var_6.Find(var_56_4, "scoreContent/B/bl"), false)

		setActive = var_5

		local var_56_5 = arg_56_0.top

		var_5(var_6.Find(var_56_5, "scoreContent/A/al"), false)

		setActive = var_5

		local var_56_6 = arg_56_0.top

		var_5(var_6.Find(var_56_6, "scoreContent/S/sl"), false)
	elseif 0.53 <= var_56_1 then
		setActive = var_5

		local var_56_7 = arg_56_0.top

		var_5(var_6.Find(var_56_7, "scoreContent/B/bl"), true)

		if 0.72 <= var_56_1 then
			setActive = var_5

			local var_56_8 = arg_56_0.top

			var_5(var_6.Find(var_56_8, "scoreContent/A/al"), true)

			if 0.885 <= var_56_1 then
				if not arg_56_0.nowS_flag then
					arg_56_0.nowS_flag = true

					arg_56_0:effect_play("S", true)
				end

				setActive = var_5

				local var_56_9 = arg_56_0.top

				var_5(var_6.Find(var_56_9, "scoreContent/S/sl"), true)
			end
		end
	end

	setText = var_5

	local var_56_10 = arg_56_0.game_content

	var_5(var_6.Find(var_56_10, "combo_n/" .. arg_56_0.musicData.content_type), arg_56_0.combo_link)

	return
end

function var_0_1.score_update(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0.game_content
	local var_57_1 = var_2.Find(var_57_0, "evaluate")

	for iter_57_0 = 1, 3 do
		setActive = var_1_10007

		var_1_10007(var_57_1:GetChild(iter_57_0 - 1), false)
	end

	setActive = var_3

	var_3(var_57_1:GetChild(arg_57_1), true)

	if arg_57_1 == 0 then
		arg_57_0.combo_link = 0
		arg_57_0.score_number = arg_57_0.score_number + arg_57_0.score_miss
		arg_57_0.miss_number = arg_57_0.miss_number + 1
		setActive = var_3

		local var_57_2 = arg_57_0.game_content

		var_3(var_4.Find(var_57_2, "combo"), false)

		setActive = var_3

		local var_57_3 = arg_57_0.game_content

		var_3(var_4.Find(var_57_3, "combo_n"), false)
	else
		arg_57_0.combo_link = arg_57_0.combo_link + 1

		local var_57_4

		if not (arg_57_0.combo_number > arg_57_0.combo_link) or not arg_57_0.combo_number then
			var_57_4 = arg_57_0.combo_link
		end

		arg_57_0.combo_number = var_57_4

		local var_57_9

		if arg_57_0.combo_link > 1 then
			setActive = var_57_9

			local var_57_5 = arg_57_0.game_content

			var_57_9(var_4.Find(var_57_5, "combo"), true)

			setActive = var_57_9

			local var_57_6 = arg_57_0.game_content

			var_57_9(var_4.Find(var_57_6, "combo_n"), true)

			local var_57_7 = arg_57_0.game_content
			local var_57_8 = var_57_9.Find(var_57_7, "combo")

			var_57_9 = var_57_9.GetComponent
			typeof = var_5
			Animation = var_6

			local var_57_10 = var_57_9(var_57_8, var_5(var_6))

			var_57_9.Play(var_57_10)

			local var_57_11 = arg_57_0.game_content
			local var_57_12 = var_57_9.Find(var_57_11, "combo_n")

			var_57_9 = var_57_9.GetComponent
			typeof = var_5
			Animation = var_6

			local var_57_13 = var_57_9(var_57_12, var_5(var_6))

			var_57_9.Play(var_57_13)
		else
			setActive = var_57_9

			local var_57_14 = arg_57_0.game_content

			var_57_9(var_4.Find(var_57_14, "combo"), false)

			setActive = var_57_9

			local var_57_15 = arg_57_0.game_content

			var_57_9(var_4.Find(var_57_15, "combo_n"), false)
		end

		pg = var_57_9

		local var_57_16 = var_57_9.CriMgr.GetInstance()

		var_3.PlaySE_V3(var_57_16, "ui-maoudamashii")
	end

	local var_57_17 = 0

	for iter_57_1 = 1, #arg_57_0.combo_interval do
		if arg_57_0.combo_link > arg_57_0.combo_interval[iter_57_1] then
			var_57_17 = var_57_17 + 1
		else
			break
		end
	end

	if arg_57_1 == 1 then
		arg_57_0.score_number = arg_57_0.score_number + arg_57_0.score_good + var_57_17 * arg_57_0.score_combo
		arg_57_0.good_number = arg_57_0.good_number + 1

		arg_57_0:effect_play("good")
	elseif arg_57_1 == 2 then
		arg_57_0.score_number = arg_57_0.score_number + arg_57_0.score_perfect + var_57_17 * arg_57_0.score_combo
		arg_57_0.perfect_number = arg_57_0.perfect_number + 1

		arg_57_0:effect_play("perfect")
	end

	local var_57_18 = arg_57_0.gameNoteLeft

	if not var_4.loopTime(var_57_18) then
		local var_57_19 = arg_57_0.gameNoteRight

		if var_4.loopTime(var_57_19) then
			arg_57_0:effect_play("perfect_loop02", true)
		else
			arg_57_0:effect_play("perfect_loop02", false)
		end

		local var_57_20 = arg_57_0.yinyueComboeffect

		if arg_57_0.game_dgree == 2 and arg_57_0.combo_link > 50 or arg_57_0.game_dgree == 1 and arg_57_0.combo_link > 20 then
			isActive = var_5

			if not var_5(var_57_20) then
				SetActive = var_5

				var_5(var_57_20, true)

				setActive = var_5

				local var_57_21 = arg_57_0.game_content

				var_5(var_6.Find(var_57_21, "MusicStar"), true)
			end
		else
			SetActive = var_5

			var_5(var_57_20, false)

			setActive = var_5

			local var_57_22 = arg_57_0.game_content

			var_5(var_6.Find(var_57_22, "MusicStar"), false)
		end

		return
	end
end

function var_0_1.count_five(arg_58_0, arg_58_1)
	if arg_58_0.countingfive_flag then
		return
	end

	arg_58_0.countingfive_flag = true
	setActive = var_2

	var_2(arg_58_0.countTf, true)

	setActive = var_2

	var_2(arg_58_0.countContent, true)

	local var_58_0 = arg_58_0

	arg_58_0.setActionSDmodel(var_58_0, "stand2")

	local var_58_1 = var_0_6

	findTF = var_58_0

	local var_58_2 = var_58_0(arg_58_0.countTf, "img")

	findTF = var_4

	local var_58_3 = var_4(arg_58_0.countTf, "bg")

	local function var_58_4(arg_59_0)
		for iter_59_0 = 1, var_58_2.childCount do
			local var_59_0 = var_58_2
			local var_59_1 = var_5.GetChild(var_59_0, iter_59_0 - 1)
			local var_59_2 = iter_59_0 == arg_59_0

			setActive = var_7

			var_7(var_59_1, var_59_2)
		end

		return
	end

	setActive = var_6

	var_6(var_58_3, false)
	var_58_4(0)

	findTF = var_6

	local var_58_5 = var_6(arg_58_0.countTf, "ready")

	findTF = var_7

	local var_58_6 = var_7(arg_58_0.countTf, "effectContent")

	setActive = var_8

	var_8(var_58_6, false)

	setActive = var_8

	var_8(var_58_5, false)

	Timer = var_8
	arg_58_0.count_timer = var_8.New(function()
		if arg_58_0.criInfo then
			local var_60_0 = arg_58_0.criInfo

			if var_0.GetTime(var_60_0) > 0 then
				local var_60_1 = arg_58_0

				var_0.pauseBgm(var_60_1)
			end
		end

		var_58_4(var_58_1)

		var_58_1 = var_58_1 - 1

		local var_60_3

		if var_58_1 < 0 then
			local var_60_2 = arg_58_0.count_timer

			var_60_3.Stop(var_60_2)

			setActive = var_60_3

			var_60_3(var_58_3, false)
			var_58_4(0)

			setActive = var_60_3

			var_60_3(var_58_5, true)

			setActive = var_60_3

			var_60_3(var_58_6, true)

			LeanTween = var_60_3
			var_60_3 = var_60_3.value
			go = var_1

			local var_60_4 = var_60_3(var_1(arg_58_0.countContent), 0, 2, 2)

			var_60_3 = var_60_3.setOnUpdate
			System = var_2

			local var_60_5 = var_60_3(var_60_4, var_2.Action_float(function(arg_61_0)
				local var_61_0

				if arg_61_0 <= 0.25 then
					local var_61_1 = arg_61_0 * 4
					local var_61_2 = var_58_5

					Vector3 = var_3_10003
					var_61_2.localScale = var_3_10003(var_61_1, var_61_1, var_61_1)
					setImageAlpha = var_61_2

					var_61_2(var_58_5, var_61_1)

					setLocalScale = var_61_2
					var_3_10003 = var_58_6
					Vector3 = var_4

					var_61_2(var_3_10003, var_4(var_61_1, var_61_1, var_61_1))
				elseif arg_61_0 >= 1.8 then
					local var_61_3 = (2 - arg_61_0) * 4
					local var_61_4 = var_58_5

					Vector3 = var_3_10003
					var_61_4.localScale = var_3_10003(var_61_3, var_61_3, var_61_3)
					setLocalScale = var_61_4

					local var_61_5 = var_58_6

					Vector3 = var_4

					var_61_4(var_61_5, var_4(var_61_3, var_61_3, var_61_3))

					setImageAlpha = var_61_4

					var_61_4(var_58_5, var_61_3)
				end

				return
			end))

			var_60_3 = var_60_3.setEase
			LeanTweenType = var_2

			local var_60_6 = var_60_3(var_60_5, var_2.linear)

			var_60_3 = var_60_3.setOnComplete
			System = var_2

			var_60_3(var_60_6, var_2.Action(function()
				local var_62_0 = var_58_5

				Vector3 = var_3_10001
				var_62_0.localScale = var_3_10001(1, 1, 1, 1)
				setLocalScale = var_62_0

				local var_62_1 = var_58_6

				Vector3 = var_2

				var_62_0(var_62_1, var_2(1, 1, 1, 1))

				setImageAlpha = var_62_0

				var_62_0(var_58_5, 1)

				setActive = var_62_0

				var_62_0(var_58_5, false)

				local var_62_2 = arg_58_0

				var_62_2.countingfive_flag = false
				setActive = var_62_2

				var_62_2(arg_58_0.countContent, false)

				setActive = var_62_2

				var_62_2(arg_58_0.countTf, false)

				local var_62_3 = arg_58_0

				var_0.setActionSDmodel(var_62_3, "idol")
				arg_58_1()

				return
			end))
		else
			setActive = var_60_3

			var_60_3(var_58_3, true)
		end

		return
	end, 1, -1)

	local var_58_7 = arg_58_0.count_timer

	var_8.Start(var_58_7)

	return
end

function var_0_1.showSelevtView(arg_63_0)
	if arg_63_0.isFirstgame == 0 then
		arg_63_0:Firstshow(arg_63_0.firstview, function()
			return
		end, 1)
	end

	local var_63_0 = arg_63_0.selectview
	local var_63_1 = var_1.Find(var_63_0, "Main")
	local var_63_2 = var_1.Find(var_63_1, "Start_btn")
	local var_63_3 = var_1:Find("DgreeList")
	local var_63_4 = var_1:Find("MusicList")
	local var_63_5 = var_1:Find("namelist")
	local var_63_6 = arg_63_0.selectview
	local var_63_7 = var_6.Find(var_63_6, "top")
	local var_63_8 = var_6.Find(var_63_7, "Speedlist")
	local var_63_9 = var_6:Find("help_btn")
	local var_63_10 = var_6:Find("back")
	local var_63_11 = arg_63_0.selectview
	local var_63_12 = var_10.GetComponent(var_63_11, "Animator")
	local var_63_13 = arg_63_0.selectview
	local var_63_14 = var_11.GetComponent

	typeof = var_1_10013
	DftAniEvent = var_1_10014

	local var_63_15 = var_63_14(var_63_13, var_1_10013(var_1_10014))

	var_11.SetEndEvent(var_63_15, function(arg_65_0)
		setActive = var_2_10001

		var_2_10001(arg_63_0.selectview, false)

		local var_65_0 = arg_63_0

		var_1.openCoinLayer(var_65_0, false)

		return
	end)

	onButton = var_12

	local var_63_16 = arg_63_0
	local var_63_17 = var_63_9

	local function var_63_18()
		pg = var_2_10000

		local var_66_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_66_1 = var_0.ShowMsgBox
		local var_66_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_66_2.type = var_2_10003
		pg = var_2_10003
		var_66_2.helps = var_2_10003.gametip.help_music_game.tip

		var_66_1(var_66_0, var_66_2)

		return
	end

	SFX_PANEL = var_1_10016

	var_12(var_63_16, var_63_17, var_63_18, var_1_10016)

	onButton = var_12

	local var_63_19 = arg_63_0
	local var_63_20 = var_63_10

	local function var_63_21()
		if var_0_4 == 0 then
			local var_67_0 = arg_63_0

			var_0.emit(var_67_0, var_0_1.ON_BACK)
		end

		return
	end

	SFX_PANEL = var_1_10016

	var_12(var_63_19, var_63_20, var_63_21, var_1_10016)

	onButton = var_12

	local var_63_22 = arg_63_0
	local var_63_23 = var_63_2

	local function var_63_24()
		if var_0_4 == 0 then
			local var_68_0 = var_63_12

			var_0.Play(var_68_0, "selectExitAnim")

			local var_68_1 = arg_63_0

			var_0.clearSDModel(var_68_1)

			local var_68_2 = arg_63_0

			var_0.updateMusic(var_68_2, arg_63_0.selectIndex)

			local var_68_3 = arg_63_0

			var_0.game_start(var_68_3)

			GetOrAddComponent = var_0
			var_0(arg_63_0.selectview, "CanvasGroup").blocksRaycasts = false
		else
			arg_63_0.startBtnReady = true
		end

		return
	end

	SFX_UI_CONFIRM = var_1_10016

	var_12(var_63_22, var_63_23, var_63_24, var_1_10016)

	onButton = var_12

	local var_63_25 = arg_63_0
	local var_63_26 = var_63_3:Find("easy")

	local function var_63_27()
		local var_69_0 = arg_63_0

		var_69_0.game_dgree = 1
		setActive = var_69_0

		local var_69_1 = var_63_3

		var_69_0(var_1.Find(var_69_1, "hard/frame"), false)

		setActive = var_69_0

		local var_69_2 = var_63_3

		var_69_0(var_1.Find(var_69_2, "easy/frame"), true)

		local var_69_3 = arg_63_0

		var_0.updatSelectview(var_69_3)

		return
	end

	SFX_UI_CLICK = var_16

	var_12(var_63_25, var_63_26, var_63_27, var_16)

	onButton = var_12

	local var_63_28 = arg_63_0
	local var_63_29 = var_63_3:Find("hard")

	local function var_63_30()
		local var_70_0 = arg_63_0

		var_70_0.game_dgree = 2
		setActive = var_70_0

		local var_70_1 = var_63_3

		var_70_0(var_1.Find(var_70_1, "easy/frame"), false)

		setActive = var_70_0

		local var_70_2 = var_63_3

		var_70_0(var_1.Find(var_70_2, "hard/frame"), true)

		local var_70_3 = arg_63_0

		var_0.updatSelectview(var_70_3)

		return
	end

	SFX_UI_CLICK = var_16

	var_12(var_63_28, var_63_29, var_63_30, var_16)

	onButton = var_12

	local var_63_31 = arg_63_0
	local var_63_32 = var_63_8

	local function var_63_33()
		setActive = var_2_10000

		local var_71_0 = var_63_8

		var_2_10000(var_1.Find(var_71_0, "x" .. arg_63_0.game_speed), false)

		local var_71_1 = arg_63_0

		var_71_1.game_speed = arg_63_0.game_speed + 1 > 4 and 1 or arg_63_0.game_speed + 1
		PlayerPrefs = var_71_1

		var_71_1.SetInt("musicgame_idol_speed", arg_63_0.game_speed)

		setActive = var_0

		local var_71_2 = var_63_8

		var_0(var_1.Find(var_71_2, "x" .. arg_63_0.game_speed), true)

		return
	end

	SFX_UI_CLICK = var_16

	var_12(var_63_31, var_63_32, var_63_33, var_16)

	arg_63_0.song_btn = var_63_4:Find("song")
	setActive = var_12

	var_12(arg_63_0.song_btn, false)

	arg_63_0.song_btns = {}

	local var_63_34 = arg_63_0.gameMusicIndex

	for iter_63_0 = 1, arg_63_0.music_amount do
		local var_63_35 = arg_63_0.song_btns

		cloneTplTo = var_1_10018
		var_63_35[iter_63_0] = var_1_10018(arg_63_0.song_btn, var_63_4, "music" .. iter_63_0)

		local var_63_36 = arg_63_0.musicDatas[iter_63_0]

		setActive = var_1_10018

		var_1_10018(arg_63_0.song_btns[iter_63_0], true)

		var_1_10018 = arg_63_0.song_btn.localPosition
		math = var_19

		local var_63_37 = var_19.abs(iter_63_0 - var_63_34)
		local var_63_38 = iter_63_0 - var_63_34 < arg_63_0.music_amount_middle and var_63_37 or iter_63_0 - arg_63_0.music_amount_middle * 2
		local var_63_39 = arg_63_0.song_btns[iter_63_0]

		Vector3 = var_22
		var_63_39.localPosition = var_22(var_1_10018.x + var_63_38 * 1022, var_1_10018.y, var_1_10018.z)
		var_1_10018 = arg_63_0.song_btn.localScale

		local var_63_40 = arg_63_0.song_btns[iter_63_0]

		Vector3 = var_22

		local var_63_41 = var_1_10018.x

		math = var_24

		local var_63_42 = var_63_41 - var_24.abs(var_63_38) * 0.2
		local var_63_43 = var_1_10018.y

		math = var_25

		local var_63_44 = var_63_43 - var_25.abs(var_63_38) * 0.2
		local var_63_45 = var_1_10018.z

		math = var_26
		var_63_40.localScale = var_22(var_63_42, var_63_44, var_63_45 - var_26.abs(var_63_38) * 0.2)

		local var_63_46 = arg_63_0.song_btns[iter_63_0]
		local var_63_47 = var_21.Find(var_63_46, "song")
		local var_63_48 = var_21.GetComponent

		typeof = var_23
		Image = var_63_44

		local var_63_49 = var_63_48(var_63_47, var_23(var_63_44))
		local var_63_50 = var_63_4:Find("img/" .. var_63_36.picture)
		local var_63_51 = var_22.GetComponent

		typeof = var_24
		Image = var_25
		var_63_49.sprite = var_63_51(var_63_50, var_24(var_25)).sprite

		local var_63_52 = arg_63_0.song_btns[iter_63_0]
		local var_63_53 = var_22.Find(var_63_52, "zhuanji3/zhuanji2_5")
		local var_63_54 = var_22.GetComponent

		typeof = var_24
		Image = var_25

		local var_63_55 = var_63_54(var_63_53, var_24(var_25))
		local var_63_56 = var_63_4:Find("img/" .. var_63_36.picture .. "_1")
		local var_63_57 = var_23.GetComponent

		typeof = var_25
		Image = var_26
		var_63_55.sprite = var_63_57(var_63_56, var_25(var_26)).sprite
		Color = var_63_55

		local var_63_58 = var_63_55.New
		local var_63_59 = 1
		local var_63_60 = 1
		local var_63_61 = 1

		math = var_26
		var_63_49.color = var_63_58(var_63_59, var_63_60, var_63_61, 1 - var_26.abs(var_63_38) * 0.6)
		onButton = var_22

		local var_63_62 = arg_63_0
		local var_63_63 = arg_63_0.song_btns[iter_63_0]

		local function var_63_64()
			local var_72_0 = arg_63_0

			var_0.clickSongBtns(var_72_0, var_63_5, iter_63_0)

			return
		end

		SFX_UI_CLICK = var_26

		var_22(var_63_62, var_63_63, var_63_64, var_26)

		if iter_63_0 == var_63_34 then
			local var_63_65 = arg_63_0.song_btns[iter_63_0]
			local var_63_66 = var_22.GetComponent

			typeof = var_63_63
			Animator = var_63_64

			local var_63_67 = var_63_66(var_63_65, var_63_63(var_63_64))

			var_22.Play(var_63_67, "plate_out")

			local var_63_68 = arg_63_0.song_btns[iter_63_0]
			local var_63_69 = var_22.GetComponent

			typeof = var_24
			Button = var_63_64
			var_63_69(var_63_68, var_24(var_63_64)).interactable = false
		end
	end

	arg_63_0:clickSongBtns(var_63_5, 1)

	return
end

function var_0_1.updateMusic(arg_73_0, arg_73_1)
	arg_73_0.musicData = arg_73_0.musicDatas[arg_73_1]
	arg_73_0.selectIndex = arg_73_1
	arg_73_0.game_music = arg_73_0.musicData.id

	local var_73_0

	if arg_73_0.musicData.ships and #arg_73_0.musicData.ships > 0 then
		arg_73_0.musicShips = arg_73_0.musicData.ships
		arg_73_0.settlementPainting = arg_73_0.musicData.settlement_painting
		arg_73_0.musicLight = arg_73_0.musicData.light
		var_73_0 = arg_73_0.musicData.shadow == 1
		arg_73_0.shadowLight = var_73_0
		arg_73_0.musicBg = arg_73_0.musicData.bg
	else
		MusicGameConst = var_73_0
		arg_73_0.musicShips = var_73_0.getRandomBand().ships
		arg_73_0.settlementPainting = var_2.settlement_painting
		arg_73_0.musicLight = var_2.light
		arg_73_0.shadowLight = true
		arg_73_0.musicBg = var_2.bg
	end

	arg_73_0.noteType = arg_73_0.musicData.note_type
	arg_73_0.gameMusicIndex = var_0_5
	arg_73_0.SDname = arg_73_0.musicShips
	arg_73_0.score_blist = arg_73_0.musicData.score_rank[1]
	arg_73_0.score_alist = arg_73_0.musicData.score_rank[2]
	arg_73_0.score_slist = arg_73_0.musicData.score_rank[3]
	arg_73_0.score_sslist = arg_73_0.musicData.score_rank[4]

	local var_73_1 = arg_73_0
	local var_73_2 = arg_73_0.setTfChildVisible
	local var_73_3 = arg_73_0.top

	var_73_2(var_73_1, var_4.Find(var_73_3, "scoreContent/B/bl"), false)

	local var_73_4 = arg_73_0
	local var_73_5 = arg_73_0.setTfChildVisible
	local var_73_6 = arg_73_0.top

	var_73_5(var_73_4, var_4.Find(var_73_6, "scoreContent/B/b"), false)

	local var_73_7 = arg_73_0
	local var_73_8 = arg_73_0.setTfChildVisible
	local var_73_9 = arg_73_0.top

	var_73_8(var_73_7, var_4.Find(var_73_9, "scoreContent/A/al"), false)

	local var_73_10 = arg_73_0
	local var_73_11 = arg_73_0.setTfChildVisible
	local var_73_12 = arg_73_0.top

	var_73_11(var_73_10, var_4.Find(var_73_12, "scoreContent/A/a"), false)

	local var_73_13 = arg_73_0
	local var_73_14 = arg_73_0.setTfChildVisible
	local var_73_15 = arg_73_0.top

	var_73_14(var_73_13, var_4.Find(var_73_15, "scoreContent/S/sl"), false)

	local var_73_16 = arg_73_0
	local var_73_17 = arg_73_0.setTfChildVisible
	local var_73_18 = arg_73_0.top

	var_73_17(var_73_16, var_4.Find(var_73_18, "scoreContent/S/s"), false)

	setActive = var_73_17

	local var_73_19 = arg_73_0.top

	var_73_17(var_3.Find(var_73_19, "scoreContent/B/b/" .. arg_73_0.musicData.content_type), true)

	setActive = var_73_17

	local var_73_20 = arg_73_0.top

	var_73_17(var_3.Find(var_73_20, "scoreContent/B/bl/" .. arg_73_0.musicData.content_type), true)

	setActive = var_73_17

	local var_73_21 = arg_73_0.top

	var_73_17(var_3.Find(var_73_21, "scoreContent/A/a/" .. arg_73_0.musicData.content_type), true)

	setActive = var_73_17

	local var_73_22 = arg_73_0.top

	var_73_17(var_3.Find(var_73_22, "scoreContent/A/al/" .. arg_73_0.musicData.content_type), true)

	setActive = var_73_17

	local var_73_23 = arg_73_0.top

	var_73_17(var_3.Find(var_73_23, "scoreContent/S/s/" .. arg_73_0.musicData.content_type), true)

	setActive = var_73_17

	local var_73_24 = arg_73_0.top

	var_73_17(var_3.Find(var_73_24, "scoreContent/S/sl/" .. arg_73_0.musicData.content_type), true)

	local var_73_25 = arg_73_0
	local var_73_26 = arg_73_0.setTfChildVisible
	local var_73_27 = arg_73_0.game_content

	var_73_26(var_73_25, var_4.Find(var_73_27, "combo_n"), false)

	local var_73_28 = arg_73_0
	local var_73_29 = arg_73_0.setTfChildVisible
	local var_73_30 = arg_73_0.game_content

	var_73_29(var_73_28, var_4.Find(var_73_30, "combo"), false)

	setActive = var_73_29

	local var_73_31 = arg_73_0.game_content

	var_73_29(var_3.Find(var_73_31, "combo_n/" .. arg_73_0.musicData.content_type), true)

	setActive = var_73_29

	local var_73_32 = arg_73_0.game_content

	var_73_29(var_3.Find(var_73_32, "combo/" .. arg_73_0.musicData.content_type), true)

	local var_73_33 = arg_73_0

	arg_73_0.setTfChildVisible(var_73_33, arg_73_0.btn_pause, false)

	setActive = var_2
	findTF = var_73_33

	var_2(var_73_33(arg_73_0.btn_pause, arg_73_0.musicData.content_type), true)
	arg_73_0:setTfChildVisible(arg_73_0.countContent, false)

	local var_73_34 = arg_73_0
	local var_73_35 = arg_73_0.setTfChildVisible
	local var_73_36 = arg_73_0.top

	var_73_35(var_73_34, var_4.Find(var_73_36, "score"), false)

	setActive = var_73_35

	local var_73_37 = arg_73_0.top
	local var_73_38 = var_3.Find
	local var_73_39 = "score/"

	tostring = var_6

	var_73_35(var_73_38(var_73_37, var_73_39 .. var_6(arg_73_0.musicData.content_type)), true)

	local var_73_40 = arg_73_0.top
	local var_73_41 = var_2.Find
	local var_73_42 = "score/"

	tostring = var_5
	arg_73_0.gameScoreTf = var_73_41(var_73_40, var_73_42 .. var_5(arg_73_0.musicData.content_type) .. "/text")
	findTF = var_2
	arg_73_0.countTf = var_2(arg_73_0.countContent, arg_73_0.musicData.content_type)

	arg_73_0:updateEffectTf()

	return
end

function var_0_1.setTfChildVisible(arg_74_0, arg_74_1, arg_74_2)
	for iter_74_0 = 1, arg_74_1.childCount do
		local var_74_0 = arg_74_1
		local var_74_1 = arg_74_1.GetChild(var_74_0, iter_74_0 - 1)

		setActive = var_74_0

		var_74_0(var_74_1, false)
	end

	return
end

function var_0_1.updateEffectTf(arg_75_0)
	findTF = var_1_10001

	local var_75_0 = var_1_10001(arg_75_0.game_content, "effect")

	for iter_75_0 = 1, var_75_0.childCount do
		local var_75_1 = var_75_0
		local var_75_2 = var_75_0.GetChild(var_75_1, iter_75_0 - 1)

		setActive = var_75_1

		var_75_1(var_75_2, false)
	end

	local var_75_3 = arg_75_0.musicData.content_type

	setActive = var_3
	findTF = var_4

	var_3(var_4(arg_75_0.game_content, "effect/" .. var_75_3))

	local var_75_4 = arg_75_0.game_content

	arg_75_0.fullComboEffect = var_3.Find(var_75_4, "effect/" .. var_75_3 .. "/yinyue_Fullcombo")

	local var_75_5 = arg_75_0.game_content

	arg_75_0.liveClearEffect = var_3.Find(var_75_5, "effect/" .. var_75_3 .. "/yinyue_LiveClear")

	local var_75_6 = arg_75_0.game_content

	arg_75_0.yinyueGood = var_3.Find(var_75_6, "effect/" .. var_75_3 .. "/yinyue_good")

	local var_75_7 = arg_75_0.game_content

	arg_75_0.yinyueComboeffect = var_3.Find(var_75_7, "effect/" .. var_75_3 .. "/yinyue_comboeffect")

	local var_75_8 = arg_75_0.game_content

	arg_75_0.yinyuePerfect = var_3.Find(var_75_8, "effect/" .. var_75_3 .. "/yinyue_perfect")

	local var_75_9 = arg_75_0.game_content

	arg_75_0.yinyuePefectLoop = var_3.Find(var_75_9, "effect/" .. var_75_3 .. "/yinyue_perfect_loop02")

	return
end

function var_0_1.getBeatGameMusicData(arg_76_0, arg_76_1)
	for iter_76_0 = 1, #arg_76_0.musicDatas do
		if arg_76_0.musicDatas[iter_76_0].id == arg_76_1 then
			return arg_76_0.musicDatas[iter_76_0]
		end
	end

	return nil
end

function var_0_1.clickSongBtns(arg_77_0, arg_77_1, arg_77_2)
	if var_0_4 > 0 then
		return
	end

	setActive = var_3

	var_3(arg_77_1:Find("song" .. arg_77_0.musicData.picture), false)
	arg_77_0:MyGetRuntimeData()
	arg_77_0:clearSDModel()
	arg_77_0:updateMusic(arg_77_2)
	arg_77_0:loadAndPlayMusic()
	arg_77_0:updatSelectview()
	arg_77_0:changeLocalpos(arg_77_2)

	setActive = var_3

	var_3(arg_77_1:Find("song" .. arg_77_0.musicData.picture), true)

	return
end

function var_0_1.changeLocalpos(arg_78_0, arg_78_1)
	local var_78_0 = arg_78_0.music_amount_middle - arg_78_1
	local var_78_1 = 0.5
	local var_78_2 = {}

	for iter_78_0 = 1, arg_78_0.music_amount do
		var_78_2[iter_78_0] = arg_78_0.song_btns[iter_78_0].localPosition
	end

	local var_78_3 = {}

	for iter_78_1 = 1, arg_78_0.music_amount do
		var_78_3[iter_78_1] = arg_78_0.song_btns[iter_78_1].localScale
	end

	Timer = var_7
	arg_78_0.changeLocalpos_timer = var_7.New(function()
		var_78_1 = var_78_1 - arg_78_0.time_interval
		arg_78_0.changeLocalposTimerflag = true

		for iter_79_0 = 1, arg_78_0.music_amount do
			local var_79_0 = iter_79_0 + var_78_0

			if iter_79_0 + var_78_0 > arg_78_0.music_amount then
				var_79_0 = iter_79_0 + var_78_0 - arg_78_0.music_amount
			end

			if iter_79_0 + var_78_0 < 1 then
				var_79_0 = iter_79_0 + var_78_0 + arg_78_0.music_amount
			end

			local var_79_1

			if var_78_1 <= 0 then
				if var_79_0 == var_0 then
					var_79_1 = arg_78_0.song_btns[iter_79_0]

					local var_79_2 = var_5.GetComponent

					typeof = var_2_10007
					Animator = var_2_10008
					var_79_1 = var_79_2(var_79_1, var_2_10007(var_2_10008))

					var_5.Play(var_79_1, "plate_out")
				else
					var_79_1 = arg_78_0.song_btns[iter_79_0]

					local var_79_3 = var_5.GetComponent

					typeof = var_2_10007
					Animator = var_2_10008
					var_79_1 = var_79_3(var_79_1, var_2_10007(var_2_10008))

					var_5.Play(var_79_1, "plate_static")

					var_79_1 = arg_78_0.song_btns[iter_79_0]

					local var_79_4 = var_5.GetComponent

					typeof = var_2_10007
					Button = var_2_10008
					var_79_4(var_79_1, var_2_10007(var_2_10008)).interactable = true
				end
			else
				var_79_1 = arg_78_0.song_btns[iter_79_0]

				local var_79_5 = var_5.GetComponent

				typeof = var_2_10007
				Animator = var_2_10008
				var_79_1 = var_79_5(var_79_1, var_2_10007(var_2_10008))

				var_5.Play(var_79_1, "plate_static")

				var_79_1 = arg_78_0.song_btns[iter_79_0]

				local var_79_6 = var_5.GetComponent

				typeof = var_2_10007
				Button = var_2_10008
				var_79_6(var_79_1, var_2_10007(var_2_10008)).interactable = false
			end

			local var_79_7 = arg_78_0.song_btn.localPosition

			math = var_79_1

			local var_79_8 = var_79_1.abs(var_79_0 - var_0)

			var_2_10007 = var_79_7.x
			var_2_10008 = var_79_0 - var_0 > 0 and 1 or -1
			var_2_10007 = (var_2_10007 + var_2_10008 * var_79_8 * 1022) * (1 - var_78_1 * 2) + var_78_2[iter_79_0].x * var_78_1 * 2
			var_2_10008 = arg_78_0.song_btns[iter_79_0]
			Vector3 = var_9
			var_2_10008.localPosition = var_9(var_2_10007, var_79_7.y, var_79_7.z)

			local var_79_9 = arg_78_0.song_btns[iter_79_0].localScale

			var_2_10007 = (1 - var_79_8 * 0.2) * (1 - var_78_1 * 2) + var_78_3[iter_79_0].x * var_78_1 * 2
			var_2_10008 = arg_78_0.song_btns[iter_79_0]
			Vector3 = var_9
			var_2_10008.localScale = var_9(var_2_10007, var_2_10007, var_2_10007)

			local var_79_10 = arg_78_0.song_btns[iter_79_0]
			local var_79_11 = var_2_10008.Find(var_79_10, "song")

			var_2_10008 = var_2_10008.GetComponent
			typeof = var_10
			Image = var_11
			var_2_10008 = var_2_10008(var_79_11, var_10(var_11))
			var_2_10007 = (1 - var_79_8 * 0.6) * (1 - var_78_1 * 2) + var_2_10008.color.a * var_78_1 * 2
			Color = var_9
			var_2_10008.color = var_9.New(1, 1, 1, 1 - var_79_8 * 0.6)
		end

		if var_78_1 <= 0 then
			arg_78_0.changeLocalposTimerflag = false

			local var_79_12 = arg_78_0.changeLocalpos_timer

			var_0.Stop(var_79_12)
		end

		return
	end, arg_78_0.time_interval, -1)

	local var_78_4 = arg_78_0.changeLocalpos_timer

	var_7.Start(var_78_4)

	return
end

function var_0_1.addRingDragListenter(arg_80_0)
	GetOrAddComponent = var_1_10001

	local var_80_0 = var_1_10001(arg_80_0.selectview, "EventTriggerListener")
	local var_80_1
	local var_80_2 = 0
	local var_80_3

	var_80_0:AddBeginDragFunc(function()
		var_80_2 = 0
		var_80_1 = nil

		return
	end)
	var_80_0:AddDragFunc(function(arg_82_0, arg_82_1)
		if not arg_80_0.inPaintingView then
			local var_82_0 = arg_82_1.position

			if not var_80_1 then
				var_80_1 = var_82_0
			end

			var_80_2 = var_82_0.x - var_80_1.x
		end

		return
	end)
	var_80_0:AddDragEndFunc(function(arg_83_0, arg_83_1)
		if not arg_80_0.inPaintingView and not arg_80_0.changeLocalposTimerflag then
			local var_83_0 = arg_80_0
			local var_83_1, var_83_2 = var_2.getNextPreSelectId(var_83_0)

			if var_80_2 < -50 then
				triggerButton = var_4

				var_4(arg_80_0.song_btns[var_83_1])
			elseif var_80_2 > 50 then
				triggerButton = var_4

				var_4(arg_80_0.song_btns[var_83_2])
			end
		end

		return
	end)

	return
end

function var_0_1.getNextPreSelectId(arg_84_0)
	local var_84_0
	local var_84_1
	local var_84_2 = arg_84_0.game_music + 1
	local var_84_3

	if arg_84_0.game_music - 1 <= 0 then
		var_84_3 = #arg_84_0.musicDatas
	end

	if #arg_84_0.musicDatas < var_84_2 then
		var_84_2 = 1
	end

	ipairs = var_5

	for iter_84_0, iter_84_1 in var_5(arg_84_0.musicDatas) do
		if arg_84_0.musicDatas[iter_84_0].id == var_84_2 then
			var_84_0 = iter_84_0
		end

		if arg_84_0.musicDatas[iter_84_0].id == var_84_3 then
			var_84_1 = iter_84_0
		end
	end

	return var_84_0, var_84_1
end

function var_0_1.Firstshow(arg_85_0, arg_85_1, arg_85_2, arg_85_3)
	arg_85_0.count = 0
	setActive = var_4

	var_4(arg_85_1, true)

	LoadSpriteAtlasAsync = var_4

	var_4("ui/minigameui/musicgameother_atlas", "help1", function(arg_86_0)
		GetComponent = var_2_10001
		findTF = var_2_10002

		local var_86_0 = var_2_10002(arg_85_0.firstview, "num/img1")

		typeof = var_3
		Image = var_4
		var_2_10001(var_86_0, var_3(var_4)).sprite = arg_86_0

		return
	end)

	LoadSpriteAtlasAsync = var_4

	var_4("ui/minigameui/musicgameother_atlas", "help2", function(arg_87_0)
		GetComponent = var_2_10001
		findTF = var_2_10002

		local var_87_0 = var_2_10002(arg_85_0.firstview, "num/img2")

		typeof = var_3
		Image = var_4
		var_2_10001(var_87_0, var_3(var_4)).sprite = arg_87_0

		return
	end)

	for iter_85_0 = 1, 2 do
		findTF = var_1_10008
		var_1_10008 = var_1_10008(arg_85_1, "num/img" .. iter_85_0)
		setActive = var_9

		var_9(var_1_10008, iter_85_0 == arg_85_3 and true or false)
	end

	if arg_85_0.firstview_timer then
		if arg_85_0.firstview_timer.running then
			local var_85_0 = arg_85_0.firstview_timer

			var_4.Stop(var_85_0)
		end

		arg_85_0.firstview_timer = nil
	end

	arg_85_0.firstview_timerRunflag = true
	Timer = var_4
	arg_85_0.firstview_timer = var_4.New(function()
		arg_85_0.count = arg_85_0.count + 1

		if arg_85_0.count > 3 then
			onButton = var_0

			var_0(arg_85_0, arg_85_0.firstview, function()
				if arg_85_2 then
					arg_85_2()
				end

				local var_89_0 = arg_85_0.firstview_timer

				var_0.Stop(var_89_0)

				setActive = var_0

				var_0(arg_85_1, false)

				local var_89_1 = arg_85_0

				var_89_1.firstview_timerRunflag = false
				removeOnButton = var_89_1

				var_89_1(arg_85_0.firstview)

				return
			end)
		end

		return
	end, 1, -1)

	local var_85_1 = arg_85_0.firstview_timer

	var_4.Start(var_85_1)

	return
end

function var_0_1.updatSelectview(arg_90_0)
	if not arg_90_0.song_btns or #arg_90_0.song_btns <= 0 or not arg_90_0.selectview then
		return
	end

	setActive = var_1

	local var_90_0 = arg_90_0.selectview

	var_1(var_2.Find(var_90_0, "top/Speedlist/x" .. arg_90_0.game_speed), true)

	for iter_90_0 = 1, arg_90_0.music_amount do
		local var_90_1 = arg_90_0.musicDatas[iter_90_0].id

		setActive = var_1_10006

		local var_90_2 = arg_90_0.song_btns[var_90_1]

		var_1_10006(var_7.Find(var_90_2, "song/best"), false)
		arg_90_0:setSelectview_pj("e", var_90_1)
	end

	local var_90_3 = arg_90_0.game_dgree
	local var_90_4 = arg_90_0.game_music
	local var_90_5 = arg_90_0.bestScorelist[var_90_4 + (var_90_3 - 1) * arg_90_0.music_amount]

	if arg_90_0.song_btns[var_90_4] and 0 < var_90_5 then
		setActive = var_4

		local var_90_6 = arg_90_0.song_btns[var_90_4]

		var_4(var_5.Find(var_90_6, "song/best"), true)

		local var_90_7 = arg_90_0.song_btns[var_90_4]
		local var_90_8 = var_4.Find(var_90_7, "song/best/score")

		setText = var_90_7

		var_90_7(var_90_8, var_90_5)
		arg_90_0:setSelectview_pj("e", var_90_4)

		if var_90_5 < arg_90_0.score_blist[var_90_3] then
			arg_90_0:setSelectview_pj("c", var_90_4)
		elseif var_90_5 >= arg_90_0.score_blist[var_90_3] and var_90_5 < arg_90_0.score_alist[var_90_3] then
			arg_90_0:setSelectview_pj("b", var_90_4)
		elseif var_90_5 >= arg_90_0.score_alist[var_90_3] and var_90_5 < arg_90_0.score_slist[var_90_3] then
			arg_90_0:setSelectview_pj("a", var_90_4)
		else
			arg_90_0:setSelectview_pj("s", var_90_4)
		end
	end

	return
end

function var_0_1.setSelectview_pj(arg_91_0, arg_91_1, arg_91_2)
	if arg_91_1 == "e" then
		setActive = var_1_10003

		local var_91_0 = arg_91_0.song_btns[arg_91_2]

		var_1_10003(var_4.Find(var_91_0, "song/c"), false)

		setActive = var_1_10003

		local var_91_1 = arg_91_0.song_btns[arg_91_2]

		var_1_10003(var_4.Find(var_91_1, "song/b"), false)

		setActive = var_1_10003

		local var_91_2 = arg_91_0.song_btns[arg_91_2]

		var_1_10003(var_4.Find(var_91_2, "song/a"), false)

		setActive = var_1_10003

		local var_91_3 = arg_91_0.song_btns[arg_91_2]

		var_1_10003(var_4.Find(var_91_3, "song/s"), false)
	elseif arg_91_1 == "c" then
		setActive = var_1_10003

		local var_91_4 = arg_91_0.song_btns[arg_91_2]

		var_1_10003(var_4.Find(var_91_4, "song/c"), true)
	elseif arg_91_1 == "b" then
		setActive = var_1_10003

		local var_91_5 = arg_91_0.song_btns[arg_91_2]

		var_1_10003(var_4.Find(var_91_5, "song/b"), true)
	elseif arg_91_1 == "a" then
		setActive = var_1_10003

		local var_91_6 = arg_91_0.song_btns[arg_91_2]

		var_1_10003(var_4.Find(var_91_6, "song/a"), true)
	elseif arg_91_1 == "s" then
		setActive = var_1_10003

		local var_91_7 = arg_91_0.song_btns[arg_91_2]

		var_1_10003(var_4.Find(var_91_7, "song/s"), true)
	end

	return
end

function var_0_1.updateScoreUIContent(arg_92_0)
	findTF = var_1_10001

	local var_92_0 = var_1_10001(arg_92_0.scoreview, "ui")

	for iter_92_0 = 1, var_92_0.childCount do
		local var_92_1 = var_92_0
		local var_92_2 = var_92_0.GetChild(var_92_1, iter_92_0 - 1)

		setActive = var_92_1

		var_92_1(var_92_2, false)
	end

	if arg_92_0.musicData.settlement_type and arg_92_0.musicData.settlement_type ~= "" then
		findTF = var_2
		arg_92_0.scoreUIContent = var_2(arg_92_0.scoreview, "ui/" .. arg_92_0.musicData.settlement_type)
	else
		findTF = var_2
		arg_92_0.scoreUIContent = var_2(arg_92_0.scoreview, "ui/normal")
	end

	setActive = var_2

	var_2(arg_92_0.scoreUIContent, true)

	return
end

function var_0_1.locadScoreView(arg_93_0)
	arg_93_0:updateScoreUIContent()
	arg_93_0:effect_play("nothing")

	arg_93_0.game_playingflag = false
	setActive = var_1

	var_1(arg_93_0.scoreview, true)

	arg_93_0.scoreview_flag = true
	findTF = var_1

	local var_93_0 = var_1(arg_93_0.scoreview, "bg")

	setImageColor = var_2

	local var_93_1 = var_93_0

	Color = var_1_10004

	var_2(var_93_1, var_1_10004(0, 0, 0))

	LoadSpriteAtlasAsync = var_2

	var_2("ui/minigameui/musicgameother_atlas", "scoreBg" .. arg_93_0.musicBg, function(arg_94_0)
		if var_93_0 then
			GetComponent = var_1

			local var_94_0 = var_93_0

			typeof = var_2_10003
			Image = var_2_10004

			local var_94_1 = var_1(var_94_0, var_2_10003(var_2_10004))

			var_94_1.sprite = arg_94_0
			setImageColor = var_94_1

			local var_94_2 = var_93_0

			Color = var_3

			var_94_1(var_94_2, var_3(1, 1, 1))

			setActive = var_94_1

			var_94_1(var_93_0, true)
		end

		return
	end)

	setActive = var_2

	local var_93_2 = arg_93_0.game_content

	var_2(var_3.Find(var_93_2, "combo"), false)

	setActive = var_2

	local var_93_3 = arg_93_0.game_content

	var_2(var_3.Find(var_93_3, "MusicStar"), false)

	setActive = var_2

	local var_93_4 = arg_93_0.game_content

	var_2(var_3.Find(var_93_4, "combo_n"), false)

	setActive = var_2

	var_2(arg_93_0.game_content, false)

	setActive = var_2

	var_2(arg_93_0.top, false)

	setActive = var_2

	local var_93_5 = arg_93_0._tf

	var_2(var_3.Find(var_93_5, "Spinelist"), false)

	local var_93_6 = arg_93_0.scoreview
	local var_93_7 = var_2.Find(var_93_6, "maskBg").childCount

	for iter_93_0 = 1, var_93_7 do
		setActive = var_7
		var_1_10009 = arg_93_0.scoreview

		local var_93_8 = var_8.Find(var_1_10009, "maskBg/bg" .. iter_93_0)

		var_1_10009 = iter_93_0 == arg_93_0.musicBg

		var_7(var_93_8, var_1_10009)
	end

	local var_93_9 = arg_93_0.scoreview
	local var_93_10 = var_3.Find(var_93_9, "maskBgBottom").childCount

	for iter_93_1 = 1, var_93_10 do
		local var_93_11 = iter_93_1 == arg_93_0.musicBg

		setActive = var_1_10009

		local var_93_12 = arg_93_0.scoreview

		var_1_10009(var_10.Find(var_93_12, "maskBgBottom/bg" .. iter_93_1), var_93_11)
	end

	local var_93_13 = arg_93_0.game_dgree
	local var_93_14 = arg_93_0.game_music

	if arg_93_0.painting then
		retPaintingPrefab = var_6

		local var_93_15 = arg_93_0.scoreview

		var_6(var_7.Find(var_93_15, "paint"), arg_93_0.painting)
	end

	local var_93_16 = {}

	for iter_93_2 = 1, #arg_93_0.settlementPainting do
		if arg_93_0.settlementPainting[iter_93_2] and arg_93_0.settlementPainting[iter_93_2] ~= "" and arg_93_0.settlementPainting[iter_93_2] ~= "none" then
			table = var_11

			var_11.insert(var_93_16, arg_93_0.settlementPainting[iter_93_2])
		end
	end

	math = var_7
	arg_93_0.painting = var_93_16[var_7.random(1, #var_93_16)]
	MusicGameConst = var_7

	local var_93_17 = var_7.painting_const_key

	string = var_8

	local var_93_18

	if var_93_17[var_8.lower(arg_93_0.painting)] then
		var_93_18 = {}
		PaintingGroupConst = var_9

		var_9.AddPaintingNameWithFilteMap(var_93_18, var_7)

		PaintingGroupConst = var_9

		var_9.PaintingDownload({
			isShowBox = false,
			paintingNameList = var_93_18,
			finishFunc = function()
				setPaintingPrefabAsync = var_2_10000

				local var_95_0 = arg_93_0.scoreview

				var_2_10000(var_1.Find(var_95_0, "paint"), arg_93_0.painting, "mainNormal")

				return
			end
		})
	else
		setPaintingPrefabAsync = var_93_18

		local var_93_19 = arg_93_0.scoreview

		var_93_18(var_9.Find(var_93_19, "paint"), arg_93_0.painting, "mainNormal")
	end

	setActive = var_93_18

	local var_93_20 = arg_93_0.scoreUIContent

	var_93_18(var_9.Find(var_93_20, "scoreImg/square/easy"), var_93_13 == 1)

	setActive = var_93_18

	local var_93_21 = arg_93_0.scoreUIContent

	var_93_18(var_9.Find(var_93_21, "scoreImg/square/hard"), var_93_13 == 2)

	setActive = var_93_18

	local var_93_22 = arg_93_0.scoreUIContent

	var_93_18(var_9.Find(var_93_22, "scoreList/fullCombo"), arg_93_0.miss_number == 0)

	setActive = var_93_18

	local var_93_23 = arg_93_0.scoreUIContent

	var_93_18(var_9.Find(var_93_23, "scoreImg/perfect/noMiss"), arg_93_0.miss_number == 0 and arg_93_0.good_number == 0)

	local function var_93_24(arg_96_0, arg_96_1, arg_96_2)
		LeanTween = var_2_10003

		local var_96_0 = var_2_10003.value

		go = var_2_10004

		local var_96_1 = var_96_0(var_2_10004(arg_93_0.scoreview), 0, arg_96_1, 0.6)
		local var_96_2 = var_3.setOnUpdate

		System = var_5

		local var_96_3 = var_96_2(var_96_1, var_5.Action_float(function(arg_97_0)
			setText = var_3_10001

			local var_97_0 = arg_96_0

			math = var_3_10003

			var_3_10001(var_97_0, var_3_10003.round(arg_97_0))

			return
		end))
		local var_96_4 = var_3.setOnComplete

		System = var_5

		var_96_4(var_96_3, var_5.Action(function()
			arg_96_2()

			return
		end))

		return
	end

	seriesAsync = var_9

	var_9({
		function(arg_99_0)
			local var_99_0 = var_93_24
			local var_99_1 = arg_93_0.scoreUIContent

			var_99_0(var_2.Find(var_99_1, "scoreList/perfect"), arg_93_0.perfect_number, arg_99_0)

			return
		end,
		function(arg_100_0)
			local var_100_0 = var_93_24
			local var_100_1 = arg_93_0.scoreUIContent

			var_100_0(var_2.Find(var_100_1, "scoreList/good"), arg_93_0.good_number, arg_100_0)

			return
		end,
		function(arg_101_0)
			local var_101_0 = var_93_24
			local var_101_1 = arg_93_0.scoreUIContent

			var_101_0(var_2.Find(var_101_1, "scoreList/miss"), arg_93_0.miss_number, arg_101_0)

			return
		end,
		function(arg_102_0)
			local var_102_0 = var_93_24
			local var_102_1 = arg_93_0.scoreUIContent

			var_102_0(var_2.Find(var_102_1, "scoreList/combo"), arg_93_0.combo_number, arg_102_0)

			return
		end,
		function(arg_103_0)
			local var_103_0

			if not arg_93_0.bestScorelist[var_93_14 + (var_93_13 - 1) * arg_93_0.music_amount] or var_103_0 == 0 then
				var_103_0 = arg_93_0.score_number
			end

			local var_103_2

			if arg_93_0.score_number > arg_93_0.bestScorelist[var_93_14 + (var_93_13 - 1) * arg_93_0.music_amount] then
				setActive = var_103_2

				local var_103_1 = arg_93_0.scoreUIContent

				var_103_2(var_3.Find(var_103_1, "scoreImg/square/newScore"), true)

				var_103_2 = arg_93_0.bestScorelist
				var_103_2[var_93_14 + (var_93_13 - 1) * arg_93_0.music_amount] = arg_93_0.score_number
			else
				setActive = var_103_2

				local var_103_3 = arg_93_0.scoreUIContent

				var_103_2(var_3.Find(var_103_3, "scoreImg/square/newScore"), false)
			end

			local var_103_4 = var_93_24
			local var_103_5 = arg_93_0.scoreUIContent

			var_103_4(var_3.Find(var_103_5, "scoreImg/square/bestscore"), var_103_0, arg_103_0)

			local var_103_6 = var_93_24
			local var_103_7 = arg_93_0.scoreUIContent

			var_103_6(var_3.Find(var_103_7, "scoreImg/square/score"), arg_93_0.score_number, function()
				return
			end)

			local var_103_8 = arg_93_0

			var_2.MyStoreDataToServer(var_103_8)

			local var_103_9 = arg_93_0

			var_2.MyGetRuntimeData(var_103_9)

			return
		end,
		function(arg_105_0)
			local var_105_0

			if arg_93_0.score_number < arg_93_0.score_blist[var_93_13] then
				function var_105_0()
					local var_106_0 = arg_93_0

					var_0.setScoceview_pj(var_106_0, "c")

					return
				end
			elseif arg_93_0.score_number >= arg_93_0.score_blist[var_93_13] and arg_93_0.score_number < arg_93_0.score_alist[var_93_13] then
				function var_105_0()
					local var_107_0 = arg_93_0

					var_0.setScoceview_pj(var_107_0, "b")

					local var_107_1 = arg_93_0
					local var_107_2 = var_0.emit

					BaseMiniGameMediator = var_2

					var_107_2(var_107_1, var_2.MINI_GAME_SUCCESS, 0)

					return
				end
			elseif arg_93_0.score_number >= arg_93_0.score_alist[var_93_13] and arg_93_0.score_number < arg_93_0.score_slist[var_93_13] then
				function var_105_0()
					local var_108_0 = arg_93_0

					var_0.setScoceview_pj(var_108_0, "a")

					local var_108_1 = arg_93_0
					local var_108_2 = var_0.emit

					BaseMiniGameMediator = var_2

					var_108_2(var_108_1, var_2.MINI_GAME_SUCCESS, 0)

					return
				end
			else
				function var_105_0()
					local var_109_0 = arg_93_0

					var_0.setScoceview_pj(var_109_0, "s")

					local var_109_1 = arg_93_0
					local var_109_2 = var_0.emit

					BaseMiniGameMediator = var_2

					var_109_2(var_109_1, var_2.MINI_GAME_SUCCESS, 0)

					return
				end
			end

			local var_105_1 = arg_93_0
			local var_105_2 = var_2.GetMGHubData(var_105_1)

			pg = var_105_1

			local var_105_3 = var_105_1.NewStoryMgr.GetInstance()
			local var_105_4 = arg_93_0
			local var_105_5 = var_4.GetMGData(var_105_4)
			local var_105_6

			if not var_4.getConfig(var_105_5, "simple_config_data").story[var_105_2.usedtime + 1] or not var_4[var_105_2.usedtime + 1][1] then
				var_105_6 = nil
			end

			if var_105_2.count > 0 and var_105_6 and not var_105_3:IsPlayed(var_105_6) and arg_93_0.score_number >= arg_93_0.score_blist[var_93_13] then
				var_105_3:Play(var_105_6, var_105_0)
			else
				var_105_0()
			end

			arg_105_0()

			return
		end
	}, function()
		return
	end)

	local var_93_25 = arg_93_0.scoreUIContent
	local var_93_26 = var_9.Find(var_93_25, "scoreImg/square/nameText")

	setText = var_93_25

	var_93_25(var_93_26, arg_93_0.musicData.music_name)

	local var_93_27 = arg_93_0.scoreUIContent
	local var_93_28 = var_10.Find(var_93_27, "scoreImg/square/name")
	local var_93_29 = var_10.GetComponent

	typeof = var_12
	Image = var_1_10013

	local var_93_30 = var_93_29(var_93_28, var_12(var_1_10013))
	local var_93_31 = arg_93_0.selectview
	local var_93_32 = var_11.Find(var_93_31, "Main/namelist/song" .. arg_93_0.musicData.picture)
	local var_93_33 = var_11.GetComponent

	typeof = var_13
	Image = var_14
	var_93_30.sprite = var_93_33(var_93_32, var_13(var_14)).sprite

	var_93_30:SetNativeSize()

	local var_93_34 = arg_93_0.scoreUIContent
	local var_93_35 = var_11.Find(var_93_34, "scoreImg/square/song")
	local var_93_36 = var_11.GetComponent

	typeof = var_13
	Image = var_14

	local var_93_37 = var_93_36(var_93_35, var_13(var_14))
	local var_93_38 = arg_93_0.selectview
	local var_93_39 = var_12.Find(var_93_38, "Main/MusicList/img/" .. arg_93_0.musicData.picture)
	local var_93_40 = var_12.GetComponent

	typeof = var_14
	Image = var_15
	var_93_37.sprite = var_93_40(var_93_39, var_14(var_15)).sprite
	GetComponent = var_93_37

	local var_93_41 = arg_93_0.scoreUIContent
	local var_93_42 = var_12.Find(var_93_41, "btnList/share")

	typeof = var_93_41
	Image = var_14

	local var_93_43 = var_93_37(var_93_42, var_93_41(var_14))

	var_11.SetNativeSize(var_93_43)

	onButton = var_12

	local var_93_44 = arg_93_0
	local var_93_45 = arg_93_0.scoreUIContent
	local var_93_46 = var_14.Find(var_93_45, "btnList/share")

	local function var_93_47()
		pg = var_2_10000

		local var_111_0 = var_2_10000.ShareMgr.GetInstance()
		local var_111_1 = var_0.Share

		pg = var_2_10002

		var_111_1(var_111_0, var_2_10002.ShareMgr.TypeSummary)

		return
	end

	SFX_PANEL = var_16

	var_12(var_93_44, var_93_46, var_93_47, var_16)

	GetComponent = var_12

	local var_93_48 = arg_93_0.scoreUIContent
	local var_93_49 = var_13.Find(var_93_48, "btnList/restart")

	typeof = var_93_48
	Image = var_15

	local var_93_50 = var_12(var_93_49, var_93_48(var_15))

	var_12.SetNativeSize(var_93_50)

	onButton = var_12

	local var_93_51 = arg_93_0
	local var_93_52 = arg_93_0.scoreUIContent
	local var_93_53 = var_14.Find(var_93_52, "btnList/restart")

	local function var_93_54()
		setActive = var_2_10000

		var_2_10000(arg_93_0.scoreview, false)

		arg_93_0.scoreview_flag = false

		local var_112_0 = arg_93_0

		var_0.stopTimer(var_112_0)

		local var_112_1 = arg_93_0

		var_0.rec_scorce(var_112_1)

		local var_112_2 = arg_93_0

		var_0.game_start(var_112_2)

		local var_112_3 = arg_93_0

		var_0.setScoceview_pj(var_112_3, "e")

		if arg_93_0.painting then
			retPaintingPrefab = var_0

			local var_112_4 = arg_93_0.scoreview

			var_0(var_1.Find(var_112_4, "paint"), arg_93_0.painting)

			arg_93_0.painting = nil
		end

		return
	end

	SFX_UI_CLICK = var_16

	var_12(var_93_51, var_93_53, var_93_54, var_16)

	GetComponent = var_12

	local var_93_55 = arg_93_0.scoreUIContent
	local var_93_56 = var_13.Find(var_93_55, "btnList/reselect")

	typeof = var_93_55
	Image = var_15

	local var_93_57 = var_12(var_93_56, var_93_55(var_15))

	var_12.SetNativeSize(var_93_57)

	onButton = var_12

	local var_93_58 = arg_93_0
	local var_93_59 = arg_93_0.scoreUIContent
	local var_93_60 = var_14.Find(var_93_59, "btnList/reselect")

	local function var_93_61()
		local var_113_0 = arg_93_0

		var_0.dynamicBgHandler(var_113_0, arg_93_0.bgGo)

		setActive = var_0

		var_0(arg_93_0.scoreview, false)

		arg_93_0.scoreview_flag = false

		local var_113_1 = arg_93_0

		var_0.stopTimer(var_113_1)

		setActive = var_0

		var_0(arg_93_0.selectview, true)

		local var_113_2 = arg_93_0

		var_0.openCoinLayer(var_113_2, true)

		GetOrAddComponent = var_0
		var_0(arg_93_0.selectview, "CanvasGroup").blocksRaycasts = true

		local var_113_3 = arg_93_0

		var_0.updatSelectview(var_113_3)

		local var_113_4 = arg_93_0.song_btns[arg_93_0.game_music]
		local var_113_5 = var_0.GetComponent

		typeof = var_2
		Animator = var_2_10003

		local var_113_6 = var_113_5(var_113_4, var_2(var_2_10003))

		var_0.Play(var_113_6, "plate_out")

		local var_113_7 = arg_93_0

		var_0.loadAndPlayMusic(var_113_7)

		local var_113_8 = arg_93_0

		var_0.rec_scorce(var_113_8)

		local var_113_9 = arg_93_0

		var_0.setScoceview_pj(var_113_9, "e")

		if arg_93_0.painting then
			retPaintingPrefab = var_0

			local var_113_10 = arg_93_0.scoreview

			var_0(var_1.Find(var_113_10, "paint"), arg_93_0.painting)

			arg_93_0.painting = nil
		end

		return
	end

	SFX_UI_CLICK = var_16

	var_12(var_93_58, var_93_60, var_93_61, var_16)

	return
end

function var_0_1.setScoceview_pj(arg_114_0, arg_114_1)
	setActive = var_1_10002

	local var_114_0 = arg_114_0.scoreUIContent

	var_1_10002(var_3.Find(var_114_0, "scoreImg/square/c"), false)

	setActive = var_1_10002

	local var_114_1 = arg_114_0.scoreUIContent

	var_1_10002(var_3.Find(var_114_1, "scoreImg/square/b"), false)

	setActive = var_1_10002

	local var_114_2 = arg_114_0.scoreUIContent

	var_1_10002(var_3.Find(var_114_2, "scoreImg/square/a"), false)

	setActive = var_1_10002

	local var_114_3 = arg_114_0.scoreUIContent

	var_1_10002(var_3.Find(var_114_3, "scoreImg/square/s"), false)

	if arg_114_1 == "e" then
		-- block empty
	elseif arg_114_1 == "c" then
		setActive = var_1_10002

		local var_114_4 = arg_114_0.scoreUIContent

		var_1_10002(var_3.Find(var_114_4, "scoreImg/square/c"), true)
	elseif arg_114_1 == "b" then
		setActive = var_1_10002

		local var_114_5 = arg_114_0.scoreUIContent

		var_1_10002(var_3.Find(var_114_5, "scoreImg/square/b"), true)
	elseif arg_114_1 == "a" then
		setActive = var_1_10002

		local var_114_6 = arg_114_0.scoreUIContent

		var_1_10002(var_3.Find(var_114_6, "scoreImg/square/a"), true)
	elseif arg_114_1 == "s" then
		setActive = var_1_10002

		local var_114_7 = arg_114_0.scoreUIContent

		var_1_10002(var_3.Find(var_114_7, "scoreImg/square/s"), true)
	end

	return
end

function var_0_1.Scoceview_ani(arg_115_0)
	local var_115_0 = 0

	setActive = var_1_10002

	local var_115_1 = arg_115_0.scoreUIContent

	var_1_10002(var_3.Find(var_115_1, "btnList/reselect"), false)

	setActive = var_1_10002

	local var_115_2 = arg_115_0.scoreUIContent

	var_1_10002(var_3.Find(var_115_2, "btnList/restart"), false)

	setActive = var_1_10002

	local var_115_3 = arg_115_0.scoreUIContent

	var_1_10002(var_3.Find(var_115_3, "btnList/share"), false)

	local function var_115_4()
		var_115_0 = var_115_0 + arg_115_0.time_interval

		if var_115_0 >= 0.99 then
			setActive = var_0

			local var_116_0 = arg_115_0.scoreUIContent

			var_0(var_1.Find(var_116_0, "btnList/reselect"), true)

			setActive = var_0

			local var_116_1 = arg_115_0.scoreUIContent

			var_0(var_1.Find(var_116_1, "btnList/restart"), true)

			setActive = var_0

			local var_116_2 = arg_115_0.scoreUIContent

			var_0(var_1.Find(var_116_2, "btnList/share"), true)

			setText = var_0

			local var_116_3 = arg_115_0.scoreUIContent

			var_0(var_1.Find(var_116_3, "scoreList/perfect"), arg_115_0.perfect_number)

			setText = var_0

			local var_116_4 = arg_115_0.scoreUIContent

			var_0(var_1.Find(var_116_4, "scoreList/good"), arg_115_0.good_number)

			setText = var_0

			local var_116_5 = arg_115_0.scoreUIContent

			var_0(var_1.Find(var_116_5, "scoreList/miss"), arg_115_0.miss_number)

			setText = var_0

			local var_116_6 = arg_115_0.scoreUIContent

			var_0(var_1.Find(var_116_6, "scoreList/combo"), arg_115_0.combo_number)

			setText = var_0

			local var_116_7 = arg_115_0.scoreUIContent

			var_0(var_1.Find(var_116_7, "scoreImg/square/bestscore"), arg_115_0.score_number)
		else
			setText = var_0

			local var_116_8 = arg_115_0.scoreUIContent
			local var_116_9 = var_1.Find(var_116_8, "scoreList/perfect")

			math = var_116_8

			var_0(var_116_9, var_116_8.floor(arg_115_0.perfect_number * var_115_0))

			setText = var_0

			local var_116_10 = arg_115_0.scoreUIContent
			local var_116_11 = var_1.Find(var_116_10, "scoreList/good")

			math = var_116_10

			var_0(var_116_11, var_116_10.floor(arg_115_0.good_number * var_115_0))

			setText = var_0

			local var_116_12 = arg_115_0.scoreUIContent
			local var_116_13 = var_1.Find(var_116_12, "scoreList/miss")

			math = var_116_12

			var_0(var_116_13, var_116_12.floor(arg_115_0.miss_number * var_115_0))

			setText = var_0

			local var_116_14 = arg_115_0.scoreUIContent
			local var_116_15 = var_1.Find(var_116_14, "scoreList/combo")

			math = var_116_14

			var_0(var_116_15, var_116_14.floor(arg_115_0.combo_number * var_115_0))

			setText = var_0

			local var_116_16 = arg_115_0.scoreUIContent
			local var_116_17 = var_1.Find(var_116_16, "scoreImg/square/bestscore")

			math = var_116_16

			var_0(var_116_17, var_116_16.floor(arg_115_0.score_number * var_115_0))
		end

		if var_115_0 >= 1.03 then
			local var_116_18 = arg_115_0.Scoceview_timer

			var_0.Stop(var_116_18)
		end

		return
	end

	Timer = var_3
	arg_115_0.Scoceview_timer = var_3.New(var_115_4, arg_115_0.time_interval, -1)

	local var_115_5 = arg_115_0.Scoceview_timer

	var_3.Start(var_115_5)

	return
end

function var_0_1.gameStart(arg_117_0)
	if not arg_117_0.timer then
		Timer = var_1
		arg_117_0.timer = var_1.New(function()
			local var_118_0 = arg_117_0

			var_0.gameStepNew(var_118_0)

			return
		end, arg_117_0.time_interval, -1)
	end

	arg_117_0.aheadtime_count = 0

	local var_117_0 = 2

	arg_117_0.ahead_timerPauseFlag = false

	local function var_117_1()
		arg_117_0.ahead_timeflag = true

		if not arg_117_0.timer.running then
			local var_119_0 = arg_117_0

			var_0.startTimer(var_119_0)
		end

		if not arg_117_0.ahead_timerPauseFlag then
			arg_117_0.aheadtime_count = arg_117_0.aheadtime_count + arg_117_0.time_interval

			if arg_117_0.aheadtime_count > var_117_0 then
				arg_117_0.aheadtime_count = nil
				arg_117_0.ahead_timeflag = false
				arg_117_0.gotspecialcombo_flag = false

				local var_119_1 = arg_117_0.ahead_timer

				var_0.Stop(var_119_1)

				local var_119_2 = arg_117_0

				var_0.loadAndPlayMusic(var_119_2, function()
					return
				end)
			end
		end

		return
	end

	CriWareMgr = var_1_10003

	local var_117_2 = var_1_10003.Inst

	var_3.UnloadCueSheet(var_117_2, arg_117_0:getMusicBgm(arg_117_0.musicData))

	Timer = var_3
	arg_117_0.ahead_timer = var_3.New(var_117_1, arg_117_0.time_interval, -1)

	arg_117_0:count_five(function()
		local var_121_0 = arg_117_0.ahead_timer

		var_0.Start(var_121_0)

		return
	end)

	return
end

function var_0_1.getMusicBgm(arg_122_0, arg_122_1)
	local var_122_0 = "bgm-song"
	local var_122_2

	if arg_122_1.bgm < 10 then
		local var_122_1 = var_122_0

		var_122_2 = "0"
		tostring = var_1_10005
		var_122_0 = var_122_1 .. var_122_2 .. var_1_10005(arg_122_1.bgm)
	else
		local var_122_3 = var_122_0

		tostring = var_122_2
		var_122_0 = var_122_3 .. var_122_2(arg_122_1.bgm)
	end

	return var_122_0
end

function var_0_1.getMusicNote(arg_123_0, arg_123_1, arg_123_2)
	return "view/miniGame/gameView/musicGame/bgm_song" .. "0" .. arg_123_1.note .. "_" .. arg_123_2
end

function var_0_1.gameStepNew(arg_124_0)
	local var_124_0 = arg_124_0.game_dgree
	local var_124_1 = arg_124_0

	arg_124_0.gameStepTime = arg_124_0.getStampTime(var_124_1)
	arg_124_0.downingright_lastflag = arg_124_0.downingright_flag
	arg_124_0.downingleft_lastflag = arg_124_0.downingleft_flag
	IsUnityEditor = var_124_2

	if var_124_2 then
		local var_124_2

		if var_124_0 == 2 then
			Input = var_124_2
			var_124_2 = var_124_2.GetKey
			KeyCode = var_124_1
			arg_124_0.downingright_flag = var_124_2(var_124_1.J)
			Input = var_124_2
			var_124_2 = var_124_2.GetKey
			KeyCode = var_124_1
			arg_124_0.downingleft_flag = var_124_2(var_124_1.F)

			goto label_124_0
		end

		if var_124_0 == 1 then
			Input = var_124_2

			local var_124_3 = var_124_2.GetKey

			KeyCode = var_124_1

			if not var_124_3(var_124_1.J) then
				Input = var_2

				do
					local var_124_4 = var_2.GetKey

					KeyCode = var_3

					if var_124_4(var_3.F) then
						arg_124_0.downingright_flag = true
						arg_124_0.downingleft_flag = true
					else
						arg_124_0.downingright_flag = false
						arg_124_0.downingleft_flag = false
					end

					goto label_124_0

					if var_124_0 == 2 then
						arg_124_0.downingright_flag = arg_124_0.mousedowningright_flag
						arg_124_0.downingleft_flag = arg_124_0.mousedowningleft_flag
					elseif var_124_0 == 1 then
						if arg_124_0.mousedowningright_flag or arg_124_0.mousedowningleft_flag then
							arg_124_0.downingright_flag = true
							arg_124_0.downingleft_flag = true
						else
							arg_124_0.downingright_flag = false
							arg_124_0.downingleft_flag = false
						end
					end
				end

				::label_124_0::

				if var_124_0 == 2 then
					if not arg_124_0.downingleft_lastflag and arg_124_0.downingleft_flag then
						local var_124_5 = arg_124_0.gameNoteLeft

						var_2.onKeyDown(var_124_5)

						arg_124_0.leftDownStepTime = arg_124_0.gameStepTime

						if arg_124_0.rightDownStepTime then
							math = var_2

							if var_2.abs(arg_124_0.leftDownStepTime - arg_124_0.rightDownStepTime) < 100 then
								local var_124_6 = arg_124_0.gameNoteLeft

								var_2.bothDown(var_124_6)

								local var_124_7 = arg_124_0.gameNoteRight

								var_2.bothDown(var_124_7)
							end
						end
					elseif arg_124_0.downingleft_lastflag and not arg_124_0.downingleft_flag then
						arg_124_0.leftUpStepTime = arg_124_0.gameStepTime

						local var_124_8 = arg_124_0.gameNoteLeft

						var_2.onKeyUp(var_124_8)

						if arg_124_0.rightUpStepTime then
							math = var_2

							if var_2.abs(arg_124_0.leftUpStepTime - arg_124_0.rightUpStepTime) < 100 then
								local var_124_9 = arg_124_0.gameNoteLeft

								var_2.bothUp(var_124_9)

								local var_124_10 = arg_124_0.gameNoteRight

								var_2.bothUp(var_124_10)
							end
						end
					end

					if not arg_124_0.downingright_lastflag and arg_124_0.downingright_flag then
						local var_124_11 = arg_124_0.gameNoteRight

						var_2.onKeyDown(var_124_11)

						arg_124_0.rightDownStepTime = arg_124_0.gameStepTime

						if arg_124_0.leftDownStepTime then
							math = var_2

							if var_2.abs(arg_124_0.leftDownStepTime - arg_124_0.rightDownStepTime) < 200 then
								local var_124_12 = arg_124_0.gameNoteLeft

								var_2.bothDown(var_124_12)

								local var_124_13 = arg_124_0.gameNoteRight

								var_2.bothDown(var_124_13)
							end
						end
					elseif arg_124_0.downingright_lastflag and not arg_124_0.downingright_flag then
						arg_124_0.rightUpStepTime = arg_124_0.gameStepTime

						local var_124_14 = arg_124_0.gameNoteRight

						var_2.onKeyUp(var_124_14)

						if arg_124_0.leftUpStepTime then
							math = var_2

							if var_2.abs(arg_124_0.leftUpStepTime - arg_124_0.rightUpStepTime) < 200 then
								local var_124_15 = arg_124_0.gameNoteLeft

								var_2.bothUp(var_124_15)

								local var_124_16 = arg_124_0.gameNoteRight

								var_2.bothUp(var_124_16)
							end
						end
					end
				elseif not arg_124_0.downingright_lastflag and arg_124_0.downingright_flag then
					local var_124_17 = arg_124_0.gameNoteLeft

					var_2.onKeyDown(var_124_17)

					local var_124_18 = arg_124_0.gameNoteRight

					var_2.onKeyDown(var_124_18)
				elseif arg_124_0.downingleft_lastflag and not arg_124_0.downingleft_flag then
					local var_124_19 = arg_124_0.gameNoteLeft

					var_2.onKeyUp(var_124_19)

					local var_124_20 = arg_124_0.gameNoteRight

					var_2.onKeyUp(var_124_20)
				end

				local var_124_21

				if not arg_124_0.musicgame_nowtime then
					var_124_21 = 0
				end

				arg_124_0.musicgame_lasttime = var_124_21

				if arg_124_0.criInfo then
					arg_124_0.musicgame_nowtime = arg_124_0:getStampTime() / 1000
				else
					arg_124_0.musicgame_nowtime = 0
				end

				if arg_124_0.song_Tlength and not arg_124_0.scoreview_flag then
					long2int = var_2

					if var_2(arg_124_0.song_Tlength) / 1000 - arg_124_0.musicgame_nowtime <= 0.01666 then
						print = var_2

						var_2("歌曲播放结束")
						arg_124_0:pauseBgm()

						arg_124_0.game_playingflag = false

						local function var_124_22()
							local var_125_0 = arg_124_0

							var_0.locadScoreView(var_125_0)

							return
						end

						if arg_124_0.perfect_number > 0 and arg_124_0.good_number == 0 and arg_124_0.miss_number == 0 then
							setActive = var_3

							var_3(arg_124_0.fullComboEffect, true)

							if not arg_124_0.gotspecialcombo_flag then
								arg_124_0.score_number = arg_124_0.score_number + arg_124_0.specialscore_number
								arg_124_0.gotspecialcombo_flag = true
							end

							LeanTween = var_3

							local var_124_23 = var_3.delayedCall

							go = var_4

							local var_124_24 = var_4(arg_124_0.fullComboEffect)

							var_1_10005 = 2
							System = var_1_10006

							var_124_23(var_124_24, var_1_10005, var_1_10006.Action(function()
								var_124_22()

								return
							end))
						else
							local var_124_25

							if (arg_124_0.good_number > 0 or arg_124_0.perfect_number > 0) and arg_124_0.miss_number <= 0 then
								setActive = var_124_25

								var_124_25(arg_124_0.fullComboEffect, true)

								if not arg_124_0.gotspecialcombo_flag then
									arg_124_0.score_number = arg_124_0.score_number + arg_124_0.specialscore_number
									arg_124_0.gotspecialcombo_flag = true
								end

								LeanTween = var_124_25
								var_124_25 = var_124_25.delayedCall
								go = var_4

								local var_124_26 = var_4(arg_124_0.fullComboEffect)

								var_1_10005 = 2
								System = var_1_10006

								var_124_25(var_124_26, var_1_10005, var_1_10006.Action(function()
									var_124_22()

									return
								end))
							else
								setActive = var_124_25

								var_124_25(arg_124_0.liveClearEffect, true)

								LeanTween = var_124_25

								local var_124_27 = var_124_25.delayedCall

								go = var_4

								local var_124_28 = var_4(arg_124_0.liveClearEffect)

								var_1_10005 = 2
								System = var_1_10006

								var_124_27(var_124_28, var_1_10005, var_1_10006.Action(function()
									var_124_22()

									return
								end))
							end
						end

						return
					end
				end

				local var_124_29 = arg_124_0.gameNoteLeft

				var_2.step(var_124_29, arg_124_0.gameStepTime)

				local var_124_30 = arg_124_0.gameNoteRight

				var_2.step(var_124_30, arg_124_0.gameStepTime)
				arg_124_0:scoresliderAcombo_update()

				if arg_124_0.drumpFlag then
					local var_124_31 = arg_124_0.gameNoteLeft

					if not var_2.loopTime(var_124_31) then
						local var_124_32 = arg_124_0.gameNoteRight

						if not var_2.loopTime(var_124_32) then
							arg_124_0.drumpFlag = false
							Time = var_2
							arg_124_0.drupTime = var_2.realtimeSinceStartup

							local var_124_33 = arg_124_0

							arg_124_0.setActionSDmodel(var_124_33, "jump")

							LeanTween = var_2

							local var_124_34 = var_2.delayedCall

							go = var_124_33

							local var_124_35 = var_124_33(arg_124_0.game_content)
							local var_124_36 = 1

							System = var_1_10005

							var_124_34(var_124_35, var_124_36, var_1_10005.Action(function()
								local var_129_0 = arg_124_0

								var_0.setActionSDmodel(var_129_0, "idol")

								return
							end))
						end
					end
				end

				return
			end
		end
	end
end

function var_0_1.onStateCallback(arg_130_0, arg_130_1)
	arg_130_0:score_update(arg_130_1)

	return
end

function var_0_1.onLongTimeCallback(arg_131_0, arg_131_1)
	if arg_131_0.drupTime then
		Time = var_2

		if var_2.realtimeSinceStartup - arg_131_0.drupTime < 2 then
			return
		end
	end

	if arg_131_1 > 0.5 then
		arg_131_0.drumpFlag = true
	end

	return
end

return var_0_1

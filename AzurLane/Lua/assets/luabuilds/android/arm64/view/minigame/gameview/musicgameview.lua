local var_0_0 = class("MusicGameView", import("..BaseMiniGameView"))
local var_0_1 = false
local var_0_2 = 0.95
local var_0_3 = 0
local var_0_4 = 1
local var_0_5 = 3
local var_0_6 = 5

function var_0_0.getUIName(arg_1_0)
	return "MusicGameUI"
end

function var_0_0.MyGetRuntimeData(arg_2_0)
	local var_2_9000

	arg_2_0.achieve_times = checkExist(arg_2_0:GetMGData():GetRuntimeData("elements"), {
		1
	}) or 0
	arg_2_0.isFirstgame = PlayerPrefs.GetInt("musicgame_first_" .. getProxy(PlayerProxy):getData().id)
	arg_2_0.bestScorelist = {}

	for iter_2_0 = 1, arg_2_0.music_amount * 2 do
		local var_2_0 = arg_2_0:GetMGData()
		local var_2_1 = var_2_0.GetRuntimeData(var_2_9000, "elements")
		local var_2_2 = checkExist(var_2_1, {
			iter_2_0 + 2
		})

		if not var_2_0 then
			var_2_2 = 0
		end

		arg_2_0.bestScorelist[iter_2_0] = var_2_2
	end

	arg_2_0:updatSelectview()

	return
end

function var_0_0.MyStoreDataToServer(arg_3_0)
	PlayerPrefs.SetInt("musicgame_first_" .. getProxy(PlayerProxy):getData().id, 1)

	for iter_3_0 = 1, arg_3_0.music_amount * 2 do
		table.insert({
			arg_3_0.achieve_times,
			1
		}, iter_3_0 + 2, arg_3_0.bestScorelist[iter_3_0])
	end

	arg_3_0:StoreDataToServer({
		arg_3_0.achieve_times,
		1
	})

	return
end

function var_0_0.init(arg_4_0)
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
	arg_4_0.music_amount = #pg.beat_game_music.all
	arg_4_0.music_amount_middle = math.ceil(#pg.beat_game_music.all / 2)
	arg_4_0.musicDatas = {}

	for iter_4_0 = 1, #pg.beat_game_music.all do
		table.insert(arg_4_0.musicDatas, pg.beat_game_music[pg.beat_game_music.all[iter_4_0]])
	end

	table.sort(arg_4_0.musicDatas, function(arg_5_0, arg_5_1)
		if arg_5_0.sort and arg_5_1.sort then
			return arg_5_0.sort < arg_5_1.sort
		end

		return arg_5_0.id < arg_5_1.id
	end)

	arg_4_0.game_speed = PlayerPrefs.GetInt("musicgame_idol_speed") > 0 and PlayerPrefs.GetInt("musicgame_idol_speed") or 1
	arg_4_0.game_dgree = 1
	arg_4_0.countContent = arg_4_0._tf:Find("countContent")
	arg_4_0.countTf = nil
	arg_4_0.top = arg_4_0._tf:Find("top")
	arg_4_0.btn_pause = arg_4_0.top:Find("pause")
	arg_4_0.score = arg_4_0.top:Find("score")
	arg_4_0.game_content = arg_4_0._tf:Find("GameContent")
	arg_4_0.noteTpl = arg_4_0.game_content:Find("noteTpl")
	arg_4_0.pauseview = arg_4_0._tf:Find("Pauseview")
	arg_4_0.selectview = arg_4_0._tf:Find("Selectview")

	local var_4_0 = findTF(arg_4_0.selectview, "bg")

	LoadSpriteAtlasAsync("ui/minigameui/musicgameother_atlas", "selectbg", function(arg_6_0)
		GetComponent(var_4_0, typeof(Image)).sprite = arg_6_0

		setActive(var_4_0, true)

		return
	end)

	arg_4_0.firstview = arg_4_0._tf:Find("firstview")
	arg_4_0.scoreview = arg_4_0._tf:Find("ScoreView")

	setActive(arg_4_0.scoreview, false)

	arg_4_0.scoreview_flag = false
	arg_4_0.bg = findTF(arg_4_0._tf, "bg")

	pg.BgmMgr.GetInstance():StopPlay()
	arg_4_0:updateMusic(var_0_4)

	return
end

function var_0_0.didEnter(arg_7_0)
	local var_7_0 = 0

	LeanTween.delayedCall(go(arg_7_0.selectview), 2, System.Action(function()
		arg_7_0:MyGetRuntimeData()

		return
	end))

	arg_7_0.Getdata_timer = Timer.New(function()
		var_7_0 = var_7_0 + arg_7_0.time_interval

		if var_7_0 == arg_7_0.time_interval then
			arg_7_0:MyGetRuntimeData()
			arg_7_0:showSelevtView()
		elseif var_7_0 == arg_7_0.time_interval * 2 then
			arg_7_0:updatSelectview()
			arg_7_0.Getdata_timer:Stop()
		end

		return
	end, arg_7_0.time_interval, -1)

	arg_7_0.Getdata_timer:Start()

	arg_7_0.score_number = 0
	arg_7_0.combo_link = 0
	arg_7_0.combo_number = 0
	arg_7_0.perfect_number = 0
	arg_7_0.good_number = 0
	arg_7_0.miss_number = 0

	local var_7_1 = arg_7_0:GetMGData():getConfig("simple_config_data")

	arg_7_0.piecelist_speed = var_7_1.speed
	arg_7_0.piecelist_speedmin = var_7_1.speed_min
	arg_7_0.piecelist_speedmax = var_7_1.speed_max
	arg_7_0.specialcombo_number = var_7_1.special_combo
	arg_7_0.specialscore_number = var_7_1.special_score
	arg_7_0.score_perfect = var_7_1.perfect
	arg_7_0.score_good = var_7_1.good
	arg_7_0.score_miss = var_7_1.miss
	arg_7_0.score_combo = var_7_1.combo
	arg_7_0.time_perfect = var_7_1.perfecttime
	arg_7_0.time_good = var_7_1.goodtime
	arg_7_0.time_miss = var_7_1.misstime
	arg_7_0.time_laterperfect = var_7_1.laterperfecttime
	arg_7_0.time_latergood = var_7_1.latergoodtime
	arg_7_0.combo_interval = var_7_1.combo_interval
	arg_7_0.BtnRightDelegate = GetOrAddComponent(arg_7_0.game_content:Find("btn_right"), "EventTriggerListener")

	arg_7_0.BtnRightDelegate:AddPointDownFunc(function()
		arg_7_0.mousedowningright_flag = true

		setActive(arg_7_0.bottonRightBg, true)

		return
	end)
	arg_7_0.BtnRightDelegate:AddPointUpFunc(function()
		arg_7_0.mousedowningright_flag = false

		setActive(arg_7_0.bottonRightBg, false)

		return
	end)

	arg_7_0.BtnLeftDelegate = GetOrAddComponent(arg_7_0.game_content:Find("btn_left"), "EventTriggerListener")

	arg_7_0.BtnLeftDelegate:AddPointDownFunc(function()
		arg_7_0.mousedowningleft_flag = true

		setActive(arg_7_0.bottonLeftBg, true)

		return
	end)
	arg_7_0.BtnLeftDelegate:AddPointUpFunc(function()
		arg_7_0.mousedowningleft_flag = false

		setActive(arg_7_0.bottonLeftBg, false)

		return
	end)
	onButton(arg_7_0, arg_7_0.top:Find("pause"), function()
		pg.UIMgr.GetInstance():BlurPanel(arg_7_0.pauseview)
		setActive(arg_7_0.pauseview, true)

		arg_7_0.game_playingflag = false

		arg_7_0:effect_play("nothing")
		LoadSpriteAtlasAsync("ui/minigameui/musicgameother_atlas", "pause_" .. arg_7_0.musicData.picture, function(arg_15_0)
			setImageSprite(arg_7_0.pauseview:Find("bottom/song"), arg_15_0, true)

			return
		end)
		GetComponent(arg_7_0.pauseview:Find("bottom/img"), typeof(Image)):SetNativeSize()

		if not arg_7_0.ahead_timeflag then
			arg_7_0:pauseBgm()

			local var_14_0 = arg_7_0:getStampTime()

			if var_14_0 < 0 then
				var_14_0 = 0
			end

			if var_14_0 >= 0 and arg_7_0.song_Tlength > 0 then
				setText(arg_7_0.pauseview:Find("bottom/now"), (function(arg_16_0)
					if arg_16_0 < 10 then
						return "0" .. arg_16_0
					else
						return arg_16_0
					end

					return
				end)(math.floor(var_14_0 / 60000)) .. ":" .. (function(arg_16_0)
					if arg_16_0 < 10 then
						return "0" .. arg_16_0
					else
						return arg_16_0
					end

					return
				end)(math.floor(var_14_0 % 60000 / 1000)))
				setText(arg_7_0.pauseview:Find("bottom/total"), (function(arg_16_0)
					if arg_16_0 < 10 then
						return "0" .. arg_16_0
					else
						return arg_16_0
					end

					return
				end)(math.floor(arg_7_0.song_Tlength / 60000)) .. ":" .. (function(arg_16_0)
					if arg_16_0 < 10 then
						return "0" .. arg_16_0
					else
						return arg_16_0
					end

					return
				end)(math.floor(arg_7_0.song_Tlength % 60000 / 1000)))
				setActive(arg_7_0.pauseview:Find("bottom/triangle"), true)
				setActive(arg_7_0.pauseview:Find("bottom/TimeSlider"), true)
				setActive(arg_7_0.pauseview:Find("bottom/now"), true)
				setActive(arg_7_0.pauseview:Find("bottom/total"), true)
				setSlider(arg_7_0.pauseview:Find("bottom/TimeSlider"), 0, 1, var_14_0 / arg_7_0.song_Tlength)

				local var_14_1 = arg_7_0.pauseview:Find("bottom/triangle/min").localPosition.x
				local var_14_2 = arg_7_0.pauseview:Find("bottom/triangle/now").localPosition

				arg_7_0.pauseview:Find("bottom/triangle/now").localPosition = Vector3(var_14_1 + var_14_0 / arg_7_0.song_Tlength * (arg_7_0.pauseview:Find("bottom/triangle/max").localPosition.x - var_14_1), var_14_2.y, var_14_2.z)

				arg_7_0:setActionSDmodel("stand2")
			end
		else
			setActive(arg_7_0.pauseview:Find("bottom/triangle"), false)
			setActive(arg_7_0.pauseview:Find("bottom/TimeSlider"), false)
			setActive(arg_7_0.pauseview:Find("bottom/now"), false)
			setActive(arg_7_0.pauseview:Find("bottom/total"), false)

			arg_7_0.ahead_timerPauseFlag = true
		end

		return
	end, SFX_UI_CLICK)
	onButton(arg_7_0, arg_7_0.pauseview:Find("bottom/back"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("reselect_music_game"),
			onYes = function()
				pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0.pauseview, arg_7_0._tf)
				setActive(arg_7_0.pauseview, false)
				arg_7_0:stopTimer()

				if arg_7_0.ahead_timer then
					arg_7_0.ahead_timer:Stop()

					arg_7_0.ahead_timeflag = false
				end

				setActive(arg_7_0.selectview, true)
				arg_7_0:openCoinLayer(true)

				GetOrAddComponent(arg_7_0.selectview, "CanvasGroup").blocksRaycasts = true

				arg_7_0.song_btns[arg_7_0.game_music]:GetComponent(typeof(Animator)):Play("plate_out")

				arg_7_0.game_playingflag = false

				arg_7_0:loadAndPlayMusic()
				arg_7_0:rec_scorce()

				return
			end
		})

		return
	end, SFX_UI_CLICK)
	onButton(arg_7_0, arg_7_0.pauseview:Find("bottom/restart"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("restart_music_game"),
			onYes = function()
				pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0.pauseview, arg_7_0._tf)
				setActive(arg_7_0.pauseview, false)
				arg_7_0:stopTimer()

				if arg_7_0.ahead_timer then
					arg_7_0.ahead_timer:Stop()

					arg_7_0.ahead_timeflag = false
				end

				arg_7_0:rec_scorce()
				arg_7_0:game_start()
				arg_7_0:effect_play("prepare")

				return
			end
		})

		return
	end, SFX_UI_CLICK)
	onButton(arg_7_0, arg_7_0.pauseview:Find("bottom/resume"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0.pauseview, arg_7_0._tf)
		setActive(arg_7_0.pauseview, false)
		arg_7_0:effect_play("prepare")

		if not arg_7_0.ahead_timeflag then
			arg_7_0:count_five(function()
				arg_7_0:resumeBgm()

				arg_7_0.game_playingflag = true

				return
			end)
		else
			arg_7_0:count_five(function()
				arg_7_0.ahead_timerPauseFlag = false
				arg_7_0.game_playingflag = true

				setActive(arg_7_0.pauseview:Find("bottom/triangle"), true)
				setActive(arg_7_0.pauseview:Find("bottom/TimeSlider"), true)
				setActive(arg_7_0.pauseview:Find("bottom/now"), true)
				setActive(arg_7_0.pauseview:Find("bottom/total"), true)

				return
			end)
		end

		return
	end, SFX_UI_CLICK)
	arg_7_0:addRingDragListenter()
	setActive(arg_7_0.selectview, true)
	arg_7_0:openCoinLayer(true)

	GetOrAddComponent(arg_7_0.selectview, "CanvasGroup").blocksRaycasts = true

	return
end

function var_0_0.updateBg(arg_24_0)
	if arg_24_0.isLoading then
		arg_24_0:dynamicBgHandler(arg_24_0.bgGo, function()
			setParent(arg_24_0.bgGo, arg_24_0.bg)
			setActive(arg_24_0.bgGo, true)

			return
		end)

		return
	end

	if arg_24_0.bgGo and arg_24_0.bgName then
		arg_24_0:dynamicBgHandler(arg_24_0.bgGo)
		PoolMgr.GetInstance():ReturnUI(arg_24_0.bgName, arg_24_0.bgGo)
	end

	arg_24_0.bgName = "musicgamebg" .. arg_24_0.musicBg
	arg_24_0.isLoading = true

	PoolMgr.GetInstance():GetUI("" .. arg_24_0.bgName, true, function(arg_26_0)
		arg_24_0.bgGo = arg_26_0

		if arg_24_0.isLoading == false then
			arg_24_0:dynamicBgHandler(arg_24_0.bgGo)
			PoolMgr.GetInstance():ReturnUI(var_0, arg_24_0.bgGo)
		else
			arg_24_0.isLoading = false

			setParent(arg_24_0.bgGo, arg_24_0.bg)
			setActive(arg_24_0.bgGo, true)
		end

		return
	end)

	return
end

function var_0_0.dynamicBgHandler(arg_27_0, arg_27_1, arg_27_2)
	if IsNil(arg_27_1) then
		return
	end

	if arg_27_2 ~= nil then
		arg_27_2()
	end

	return
end

function var_0_0.onBackPressed(arg_28_0)
	if not arg_28_0.countingfive_flag and not arg_28_0.firstview_timerRunflag then
		if arg_28_0.game_playingflag then
			if not isActive(arg_28_0.top:Find("pause_above")) then
				triggerButton(arg_28_0.top:Find("pause"))
			end
		elseif isActive(arg_28_0.selectview) and var_0_3 == 0 then
			arg_28_0:emit(var_0_0.ON_BACK)
		end
	end

	return
end

function var_0_0.OnApplicationPaused(arg_29_0, arg_29_1)
	if arg_29_1 and not arg_29_0.countingfive_flag and not arg_29_0.firstview_timerRunflag and arg_29_0.game_playingflag and not isActive(arg_29_0.top:Find("pause_above")) then
		triggerButton(arg_29_0.top:Find("pause"))
	end

	return
end

function var_0_0.willExit(arg_30_0)
	arg_30_0.isLoading = false

	if arg_30_0.bgGo and arg_30_0.bgName then
		arg_30_0:dynamicBgHandler(arg_30_0.bgGo)
		PoolMgr.GetInstance():ReturnUI(arg_30_0.bgName, arg_30_0.bgGo)
	end

	if arg_30_0.timer then
		if arg_30_0.timer.running then
			arg_30_0.timer:Stop()
		end

		arg_30_0.timer = nil
	end

	if arg_30_0.ahead_timer then
		if arg_30_0.ahead_timer.running then
			arg_30_0.ahead_timer:Stop()
		end

		arg_30_0.ahead_timer = nil
	end

	if arg_30_0.firstview_timer then
		if arg_30_0.firstview_timer.running then
			arg_30_0.firstview_timer:Stop()
		end

		arg_30_0.firstview_timer = nil
	end

	if arg_30_0.changeLocalpos_timer then
		if arg_30_0.changeLocalpos_timer.running then
			arg_30_0.changeLocalpos_timer:Stop()
		end

		arg_30_0.changeLocalpos_timer = nil
	end

	if arg_30_0.count_timer then
		if arg_30_0.count_timer.running then
			arg_30_0.count_timer:Stop()
		end

		arg_30_0.count_timer = nil
	end

	if arg_30_0.Scoceview_timer then
		if arg_30_0.Scoceview_timer.running then
			arg_30_0.Scoceview_timer:Stop()
		end

		arg_30_0.Scoceview_timer = nil
	end

	if arg_30_0.Getdata_timer then
		if arg_30_0.Getdata_timer.running then
			arg_30_0.Getdata_timer:Stop()
		end

		arg_30_0.Getdata_timer = nil
	end

	arg_30_0:clearSDModel()

	arg_30_0.piecelist_lt = {}
	arg_30_0.piecelist_lf = {}
	arg_30_0.musictable_l = {}
	arg_30_0.piece_nowl = {}
	arg_30_0.piecelist_rt = {}
	arg_30_0.piecelist_rf = {}
	arg_30_0.musictable_r = {}
	arg_30_0.piece_nowr = {}

	if arg_30_0.painting then
		retPaintingPrefab(arg_30_0.scoreview:Find("paint"), arg_30_0.painting)

		arg_30_0.painting = nil
	end

	if arg_30_0.criInfo then
		arg_30_0.criInfo:PlaybackStop()
		arg_30_0.criInfo:SetStartTimeAndPlay(0)
		pg.CriMgr.GetInstance():UnloadCueSheet(arg_30_0:getMusicBgm(arg_30_0.musicData))

		arg_30_0.criInfo = nil
	end

	if LeanTween.isTweening(go(arg_30_0.selectview)) then
		LeanTween.cancel(go(arg_30_0.selectview))
	end

	if LeanTween.isTweening(go(arg_30_0.countContent)) then
		LeanTween.cancel(go(arg_30_0.countContent))
	end

	if LeanTween.isTweening(go(arg_30_0.scoreview)) then
		LeanTween.cancel(go(arg_30_0.scoreview))
	end

	if LeanTween.isTweening(go(arg_30_0.game_content)) then
		LeanTween.cancel(go(arg_30_0.game_content))
	end

	pg.BgmMgr.GetInstance():ContinuePlay()

	return
end

function var_0_0.clearSDModel(arg_31_0)
	if not arg_31_0.SDmodel or not arg_31_0.SDname or arg_31_0.SDname == "" or arg_31_0.SDname == "none" then
		return
	end

	for iter_31_0 = 1, #arg_31_0.SDmodel do
		if arg_31_0.SDmodel[iter_31_0] then
			PoolMgr.GetInstance():ReturnSpineChar(arg_31_0.SDname[iter_31_0], arg_31_0.SDmodel[iter_31_0])
		end
	end

	arg_31_0.SDmodel = {}

	return
end

function var_0_0.list_push(arg_32_0, arg_32_1, arg_32_2)
	arg_32_1[arg_32_1[0] + 1] = arg_32_2
	arg_32_1[0] = arg_32_1[0] + 1

	return
end

function var_0_0.list_pop(arg_33_0, arg_33_1)
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

function var_0_0.game_start(arg_34_0)
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
			arg_34_0:gameStart()

			return
		end, 2)
		arg_34_0:MyStoreDataToServer()
	else
		arg_34_0:gameStart()
	end

	return
end

function var_0_0.game_before(arg_36_0)
	arg_36_0:effect_play("nothing")

	arg_36_0.nowS_flag = false

	arg_36_0:setTfChildVisible(arg_36_0.top:Find("scoreContent/scroll"), false)

	arg_36_0.scoreSliderTf = arg_36_0.top:Find("scoreContent/scroll/" .. tostring(arg_36_0.musicData.content_type))

	setSlider(arg_36_0.scoreSliderTf, 0, 1, 0)
	setActive(arg_36_0.scoreSliderTf, true)
	setActive(findTF(arg_36_0.scoreSliderTf, "img/mask/yinyue20_S"), false)

	arg_36_0.scoreSFlag = false

	setImageColor(findTF(arg_36_0.scoreSliderTf, "img"), Color(1, 1, 1, 1))

	local var_36_0 = arg_36_0.game_content:Find("evaluate")

	for iter_36_0 = 1, var_36_0.childCount do
		local var_36_1 = var_36_0:GetChild(iter_36_0 - 1)

		for iter_36_1 = 1, var_36_1.childCount do
			setActive(var_36_1:GetChild(iter_36_1 - 1), false)
		end

		setActive(findTF(var_36_1, tostring(arg_36_0.musicData.content_type)), true)
		setActive(var_36_0:GetChild(iter_36_0 - 1), false)
	end

	local var_36_2 = arg_36_0.game_content:Find("bottomList")

	for iter_36_2 = 1, var_36_2.childCount do
		setActive(var_36_2:GetChild(iter_36_2 - 1), false)
	end

	if arg_36_0.musicData.bottom_type and arg_36_0.musicData.bottom_type > 0 then
		arg_36_0.bottonLeftBg = arg_36_0.game_content:Find("bottomList/" .. arg_36_0.musicData.bottom_type .. "/bottom_leftbg")
		arg_36_0.bottonRightBg = arg_36_0.game_content:Find("bottomList/" .. arg_36_0.musicData.bottom_type .. "/bottom_rightbg")

		setActive(arg_36_0.bottonLeftBg, false)
		setActive(arg_36_0.bottonRightBg, false)
		setActive(arg_36_0.game_content:Find("bottomList/" .. arg_36_0.musicData.bottom_type), true)
		setActive(arg_36_0.game_content:Find("bottomList/" .. arg_36_0.musicData.bottom_type), true)
	end

	arg_36_0:clearSDModel()

	for iter_36_3 = 1, #arg_36_0.SDname do
		arg_36_0:loadSDModel(iter_36_3)
	end

	arg_36_0:setActionSDmodel("stand2")
	setActive(arg_36_0.game_content:Find("combo"), false)
	setActive(arg_36_0.game_content:Find("combo_n"), false)
	setActive(arg_36_0.game_content:Find("MusicStar"), false)
	setActive(arg_36_0.game_content, true)
	setActive(arg_36_0._tf:Find("Spinelist"), true)
	setActive(arg_36_0.top, true)
	setActive(arg_36_0.fullComboEffect, false)
	setActive(arg_36_0.liveClearEffect, false)

	local var_36_3 = require((arg_36_0:getMusicNote(arg_36_0.musicData, arg_36_0.game_dgree)))

	arg_36_0.leftPu = {}
	arg_36_0.rightPu = {}

	for iter_36_4, iter_36_5 in ipairs(var_36_3.left_track) do
		table.insert(arg_36_0.leftPu, iter_36_5)
	end

	for iter_36_6, iter_36_7 in ipairs(var_36_3.right_track) do
		table.insert(arg_36_0.rightPu, iter_36_7)
	end

	arg_36_0:setTfChildVisible(arg_36_0.noteTpl, false)

	arg_36_0.gameNoteLeft = arg_36_0.gameNoteLeft or MusicGameNote.New(findTF(arg_36_0.game_content, "MusicPieceLeft"), arg_36_0.noteTpl, MusicGameNote.type_left)
	arg_36_0.gameNoteRight = arg_36_0.gameNoteRight or MusicGameNote.New(findTF(arg_36_0.game_content, "MusicPieceRight"), arg_36_0.noteTpl, MusicGameNote.type_right)

	arg_36_0.gameNoteLeft:setStartData(arg_36_0.leftPu, arg_36_0.game_speed, arg_36_0.game_dgree, arg_36_0.noteType)
	arg_36_0.gameNoteLeft:setStateCallback(function(arg_37_0)
		arg_36_0:onStateCallback(arg_37_0)

		return
	end)
	arg_36_0.gameNoteLeft:setLongTimeCallback(function(arg_38_0)
		arg_36_0:onLongTimeCallback(arg_38_0)

		return
	end)
	arg_36_0.gameNoteRight:setStartData(arg_36_0.rightPu, arg_36_0.game_speed, arg_36_0.game_dgree, arg_36_0.noteType)
	arg_36_0.gameNoteRight:setStateCallback(function(arg_39_0)
		arg_36_0:onStateCallback(arg_39_0)

		return
	end)
	arg_36_0.gameNoteRight:setLongTimeCallback(function(arg_40_0)
		arg_36_0:onLongTimeCallback(arg_40_0)

		return
	end)

	arg_36_0.gameStepTime = 0
	arg_36_0.musictable_l = {}
	arg_36_0.musictable_l[0] = 0
	arg_36_0.musictable_r = {}
	arg_36_0.musictable_r[0] = 0
	arg_36_0.nowmusic_l = nil
	arg_36_0.nowmusic_r = nil
	arg_36_0.musicpu = require((arg_36_0:getMusicNote(arg_36_0.musicData, arg_36_0.game_dgree)))

	for iter_36_8, iter_36_9 in ipairs(arg_36_0.musicpu.left_track) do
		arg_36_0:list_push(arg_36_0.musictable_l, iter_36_9)
	end

	for iter_36_10, iter_36_11 in ipairs(arg_36_0.musicpu.right_track) do
		arg_36_0:list_push(arg_36_0.musictable_r, iter_36_11)
	end

	local var_36_4 = arg_36_0.top:Find("scoreContent/B")

	var_36_4.anchoredPosition = Vector3(arg_36_0.scoreSliderTf.anchoredPosition.x + arg_36_0.scoreSliderTf.rect.width * 0.53, var_36_4.anchoredPosition.y, var_36_4.anchoredPosition.z)
	arg_36_0.top:Find("scoreContent/A").anchoredPosition = Vector3(arg_36_0.scoreSliderTf.anchoredPosition.x + arg_36_0.scoreSliderTf.rect.width * 0.72, var_36_4.anchoredPosition.y, var_36_4.anchoredPosition.z)
	arg_36_0.top:Find("scoreContent/S").anchoredPosition = Vector3(arg_36_0.scoreSliderTf.anchoredPosition.x + arg_36_0.scoreSliderTf.rect.width * 0.885, var_36_4.anchoredPosition.y, var_36_4.anchoredPosition.z)

	arg_36_0:scoresliderAcombo_update()

	return
end

function var_0_0.stopTimer(arg_41_0)
	if arg_41_0.timer.running then
		arg_41_0.timer:Stop()
	end

	return
end

function var_0_0.startTimer(arg_42_0)
	if not arg_42_0.timer.running then
		arg_42_0.timer:Start()
	end

	return
end

function var_0_0.loadSDModel(arg_43_0, arg_43_1)
	if not arg_43_0.SDname[arg_43_1] or arg_43_0.SDname[arg_43_1] == "" or arg_43_0.SDname[arg_43_1] == "none" then
		arg_43_0.SDmodel[arg_43_1] = false

		setActive(findTF(arg_43_0._tf, "Spinelist/" .. arg_43_1 .. "/shadow"), false)
		setActive(findTF(arg_43_0._tf, "Spinelist/" .. arg_43_1 .. "/light"), false)

		return
	end

	local var_43_0 = findTF(arg_43_0._tf, "Spinelist/" .. arg_43_1 .. "/light")
	local var_43_1 = findTF(arg_43_0._tf, "Spinelist/" .. arg_43_1 .. "/" .. arg_43_0.musicData.content_type)

	var_43_0.anchoredPosition = var_43_1.anchoredPosition
	findTF(arg_43_0._tf, "Spinelist/" .. arg_43_1 .. "/shadow").anchoredPosition = var_43_1.anchoredPosition

	setActive(var_43_0, true)

	if arg_43_0.musicLight and arg_43_0.shadowLight then
		setActive(findTF(arg_43_0._tf, "Spinelist/" .. arg_43_1 .. "/shadow"), true)
	else
		setActive(findTF(arg_43_0._tf, "Spinelist/" .. arg_43_1 .. "/shadow"), false)
	end

	for iter_43_0 = 1, var_0_6 do
		if arg_43_0.musicLight and arg_43_0.musicLight > 0 then
			setActive(findTF(arg_43_0._tf, "Spinelist/" .. arg_43_1 .. "/light"), false)

			local var_43_2 = iter_43_0

			if arg_43_0.musicData.ships[iter_43_0] and arg_43_0.musicData.ships[iter_43_0] ~= "" and arg_43_0.musicData.ships[iter_43_0] ~= "none" then
				LoadSpriteAtlasAsync("ui/minigameui/musicgameother_atlas", "light" .. arg_43_0.musicLight, function(arg_44_0)
					setActive(findTF(arg_43_0._tf, "Spinelist/" .. var_43_2 .. "/light"), true)
					setImageSprite(findTF(arg_43_0._tf, "Spinelist/" .. var_43_2 .. "/light"), arg_44_0, true)

					return
				end)
			end
		end

		setActive(findTF(arg_43_0._tf, "Spinelist/" .. arg_43_1 .. "/light"), false)
	end

	pg.UIMgr.GetInstance():LoadingOff()
	PoolMgr.GetInstance():GetSpineChar(arg_43_0.SDname[arg_43_1], true, function(arg_45_0)
		arg_43_0.SDmodel[arg_43_1] = arg_45_0
		tf(arg_45_0).localScale = Vector3(1, 1, 1)

		arg_45_0:GetComponent("SpineAnimUI"):SetAction("stand2", 0)
		setParent(arg_45_0, arg_43_0._tf:Find("Spinelist/" .. arg_43_1))

		tf(arg_45_0).anchoredPosition = arg_43_0._tf:Find("Spinelist/" .. arg_43_1 .. "/" .. arg_43_0.musicData.content_type).anchoredPosition

		return
	end)

	return
end

function var_0_0.SDmodeljump_btnup(arg_46_0)
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

function var_0_0.setActionSDmodel(arg_47_0, arg_47_1, arg_47_2)
	arg_47_2 = arg_47_2 or 0

	for iter_47_0 = 1, #arg_47_0.SDmodel do
		if arg_47_0.SDmodel[iter_47_0] then
			arg_47_0.SDmodel[iter_47_0]:GetComponent("SpineAnimUI"):SetAction(arg_47_1, arg_47_2)
		end
	end

	return
end

function var_0_0.loadAndPlayMusic(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = arg_48_0:getMusicBgm(arg_48_0.musicData)

	var_0_3 = var_0_3 + 1

	CriWareMgr.Inst:PlayBGM(arg_48_0:getMusicBgm(arg_48_0.musicData), CriWareMgr.CRI_FADE_TYPE.FADE_INOUT, function(arg_49_0)
		local var_49_1 = arg_49_0

		if arg_49_0 == nil then
			local var_49_0 = var_48_0 or "NIL"

			warning("Missing BGM :" .. var_49_0)

			goto label_49_1
		end

		print("加载完毕,开始播放音乐")

		if arg_48_0.countingfive_flag then
			return
		end

		arg_48_0.criInfo = arg_49_0
		arg_48_0.song_Tlength = arg_49_0:GetLength()

		arg_49_0:PlaybackStop()

		if IsUnityEditor and var_0_1 then
			arg_48_0.criInfo:SetStartTimeAndPlay(arg_48_0.criInfo:GetLength() * var_0_2)

			goto label_49_0
		end

		::label_49_1::
		::label_49_0::

		if arg_48_2 and arg_48_2 >= 0 then
			do
				local var_49_3 = arg_48_2 or 0

				var_49_2(var_49_1, var_49_3)
			end

			var_0_3 = var_0_3 - 1

			if arg_48_1 then
				arg_48_1()
			end

			return
		end
	end)

	return
end

function var_0_0.getStampTime(arg_50_0)
	if arg_50_0.aheadtime_count then
		return (arg_50_0.aheadtime_count - 2) * 1000
	elseif arg_50_0.criInfo then
		return arg_50_0.criInfo:GetTime()
	end

	return nil
end

function var_0_0.pauseBgm(arg_51_0)
	if arg_51_0.criInfo then
		arg_51_0.pauseTime = arg_51_0.criInfo:GetTime()

		arg_51_0.criInfo:PlaybackStop()
	end

	if arg_51_0.timer and arg_51_0.timer.running then
		arg_51_0.timer:Stop()
	end

	return
end

function var_0_0.resumeBgm(arg_52_0)
	if not arg_52_0.timer.running then
		arg_52_0.timer:Start()
	end

	arg_52_0:loadAndPlayMusic(function()
		return
	end, arg_52_0.pauseTime)

	return
end

function var_0_0.rec_scorce(arg_54_0)
	arg_54_0.score_number = 0
	arg_54_0.combo_link = 0
	arg_54_0.combo_number = 0
	arg_54_0.perfect_number = 0
	arg_54_0.good_number = 0
	arg_54_0.miss_number = 0
	arg_54_0.gotspecialcombo_flag = false

	setActive(arg_54_0.top:Find("scoreContent/B/bl"), false)
	setActive(arg_54_0.top:Find("scoreContent/A/al"), false)
	setActive(arg_54_0.top:Find("scoreContent/S/sl"), false)
	setText(arg_54_0.gameScoreTf, 0)
	setText(arg_54_0.game_content:Find("combo_n/" .. arg_54_0.musicData.content_type), 0)

	return
end

function var_0_0.effect_play(arg_55_0, arg_55_1, arg_55_2)
	if arg_55_1 == "nothing" then
		setActive(arg_55_0.yinyuePefectLoop, false)
		setActive(arg_55_0.top:Find("scoreContent/S/liubianxing"), false)
		setActive(arg_55_0.yinyueGood, false)
		setActive(arg_55_0.yinyuePerfect, false)
		setActive(arg_55_0.game_content:Find("MusicStar"), false)
		SetActive(arg_55_0.yinyueComboeffect, false)
	elseif arg_55_1 == "prepare" then
		-- block empty
	elseif arg_55_1 == "good" then
		setActive(arg_55_0.yinyueGood, false)
		setActive(arg_55_0.yinyueGood, true)
	elseif arg_55_1 == "perfect" then
		setActive(arg_55_0.yinyuePerfect, false)
		setActive(arg_55_0.yinyuePerfect, true)
	elseif arg_55_1 == "perfect_loop02" then
		if arg_55_2 then
			if not isActive(arg_55_0.yinyuePefectLoop) then
				setActive(arg_55_0.yinyuePefectLoop, true)
			end
		else
			setActive(arg_55_0.yinyuePefectLoop, false)
		end
	elseif arg_55_1 == "S" then
		if arg_55_2 then
			setActive(findTF(arg_55_0.scoreSliderTf, "img/mask/yinyue20_S"), true)
		else
			setActive(findTF(arg_55_0.scoreSliderTf, "img/mask/yinyue20_S"), false)
		end
	end

	return
end

function var_0_0.scoresliderAcombo_update(arg_56_0)
	local var_56_0 = 0

	setText(arg_56_0.gameScoreTf, arg_56_0.score_number)

	var_56_0 = arg_56_0.score_number < arg_56_0.score_blist[arg_56_0.game_dgree] and arg_56_0.score_number / arg_56_0.score_blist[arg_56_0.game_dgree] * 0.53 or arg_56_0.score_number >= arg_56_0.score_blist[arg_56_0.game_dgree] and arg_56_0.score_number < arg_56_0.score_alist[arg_56_0.game_dgree] and 0.53 + (arg_56_0.score_number - arg_56_0.score_blist[arg_56_0.game_dgree]) / (arg_56_0.score_alist[arg_56_0.game_dgree] - arg_56_0.score_blist[arg_56_0.game_dgree]) * 0.19 or arg_56_0.score_number >= arg_56_0.score_alist[arg_56_0.game_dgree] and arg_56_0.score_number < arg_56_0.score_slist[arg_56_0.game_dgree] and 0.72 + (arg_56_0.score_number - arg_56_0.score_alist[arg_56_0.game_dgree]) / (arg_56_0.score_slist[arg_56_0.game_dgree] - arg_56_0.score_alist[arg_56_0.game_dgree]) * 0.155 or 0.885 + (arg_56_0.score_number - arg_56_0.score_slist[arg_56_0.game_dgree]) / (arg_56_0.score_sslist[arg_56_0.game_dgree] - arg_56_0.score_slist[arg_56_0.game_dgree]) * 0.115

	setSlider(arg_56_0.scoreSliderTf, 0, 1, var_56_0)

	if var_56_0 < 0.53 then
		setActive(arg_56_0.top:Find("scoreContent/B/bl"), false)
		setActive(arg_56_0.top:Find("scoreContent/A/al"), false)
		setActive(arg_56_0.top:Find("scoreContent/S/sl"), false)
	elseif var_56_0 >= 0.53 then
		setActive(arg_56_0.top:Find("scoreContent/B/bl"), true)

		if var_56_0 >= 0.72 then
			setActive(arg_56_0.top:Find("scoreContent/A/al"), true)

			if var_56_0 >= 0.885 then
				if not arg_56_0.nowS_flag then
					arg_56_0.nowS_flag = true

					arg_56_0:effect_play("S", true)
				end

				setActive(arg_56_0.top:Find("scoreContent/S/sl"), true)
			end
		end
	end

	setText(arg_56_0.game_content:Find("combo_n/" .. arg_56_0.musicData.content_type), arg_56_0.combo_link)

	return
end

function var_0_0.score_update(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0.game_content:Find("evaluate")

	for iter_57_0 = 1, 3 do
		setActive(var_57_0:GetChild(iter_57_0 - 1), false)
	end

	setActive(var_57_0:GetChild(arg_57_1), true)

	if arg_57_1 == 0 then
		arg_57_0.combo_link = 0
		arg_57_0.score_number = arg_57_0.score_number + arg_57_0.score_miss
		arg_57_0.miss_number = arg_57_0.miss_number + 1

		setActive(arg_57_0.game_content:Find("combo"), false)
		setActive(arg_57_0.game_content:Find("combo_n"), false)

		goto label_57_0
	end

	arg_57_0.combo_link = arg_57_0.combo_link + 1

	::label_57_0::

	if arg_57_0.combo_number > arg_57_0.combo_link then
		arg_57_0.combo_number = arg_57_0.combo_number or arg_57_0.combo_link

		if arg_57_0.combo_link > 1 then
			setActive(arg_57_0.game_content:Find("combo"), true)
			setActive(arg_57_0.game_content:Find("combo_n"), true)
			arg_57_0.game_content:Find("combo"):GetComponent(typeof(Animation)):Play()
			arg_57_0.game_content:Find("combo_n"):GetComponent(typeof(Animation)):Play()
		else
			setActive(arg_57_0.game_content:Find("combo"), false)
			setActive(arg_57_0.game_content:Find("combo_n"), false)
		end

		pg.CriMgr.GetInstance():PlaySE_V3("ui-maoudamashii")

		local var_57_1 = 0

		for iter_57_1 = 1, #arg_57_0.combo_interval do
			if arg_57_0.combo_link > arg_57_0.combo_interval[iter_57_1] then
				var_57_1 = var_57_1 + 1
			else
				break
			end
		end

		if arg_57_1 == 1 then
			arg_57_0.score_number = arg_57_0.score_number + arg_57_0.score_good + var_57_1 * arg_57_0.score_combo
			arg_57_0.good_number = arg_57_0.good_number + 1

			arg_57_0:effect_play("good")
		elseif arg_57_1 == 2 then
			arg_57_0.score_number = arg_57_0.score_number + arg_57_0.score_perfect + var_57_1 * arg_57_0.score_combo
			arg_57_0.perfect_number = arg_57_0.perfect_number + 1

			arg_57_0:effect_play("perfect")
		end

		if arg_57_0.gameNoteLeft:loopTime() or arg_57_0.gameNoteRight:loopTime() then
			arg_57_0:effect_play("perfect_loop02", true)
		else
			arg_57_0:effect_play("perfect_loop02", false)
		end

		local var_57_2 = arg_57_0.yinyueComboeffect

		if arg_57_0.game_dgree == 2 and arg_57_0.combo_link > 50 or arg_57_0.game_dgree == 1 and arg_57_0.combo_link > 20 then
			if not isActive(var_57_2) then
				SetActive(var_57_2, true)
				setActive(arg_57_0.game_content:Find("MusicStar"), true)
			end
		else
			SetActive(var_57_2, false)
			setActive(arg_57_0.game_content:Find("MusicStar"), false)
		end

		return
	end
end

function var_0_0.count_five(arg_58_0, arg_58_1)
	if arg_58_0.countingfive_flag then
		return
	end

	arg_58_0.countingfive_flag = true

	setActive(arg_58_0.countTf, true)
	setActive(arg_58_0.countContent, true)
	arg_58_0:setActionSDmodel("stand2")

	local var_58_0 = var_0_5
	local var_58_1 = findTF(arg_58_0.countTf, "img")

	local function var_58_2(arg_59_0)
		for iter_59_0 = 1, var_58_1.childCount do
			setActive(var_58_1:GetChild(iter_59_0 - 1), iter_59_0 == arg_59_0)
		end

		return
	end

	setActive(findTF(arg_58_0.countTf, "bg"), false)
	;(function(arg_59_0)
		for iter_59_0 = 1, var_58_1.childCount do
			setActive(var_58_1:GetChild(iter_59_0 - 1), iter_59_0 == arg_59_0)
		end

		return
	end)(0)

	local var_58_3 = findTF(arg_58_0.countTf, "ready")

	setActive(findTF(arg_58_0.countTf, "effectContent"), false)
	setActive(findTF(arg_58_0.countTf, "ready"), false)

	arg_58_0.count_timer = Timer.New(function()
		if arg_58_0.criInfo and arg_58_0.criInfo:GetTime() > 0 then
			arg_58_0:pauseBgm()
		end

		var_58_2(var_58_0)

		var_58_0 = var_58_0 - 1

		if var_58_0 < 0 then
			arg_58_0.count_timer:Stop()
			setActive(var_0, false)
			var_58_2(0)
			setActive(var_58_3, true)
			setActive(var_0, true)
			LeanTween.value(go(arg_58_0.countContent), 0, 2, 2):setOnUpdate(System.Action_float(function(arg_61_0)
				if arg_61_0 <= 0.25 then
					var_58_3.localScale = Vector3(arg_61_0 * 4, arg_61_0 * 4, arg_61_0 * 4)

					setImageAlpha(var_58_3, arg_61_0 * 4)
					setLocalScale(var_0, Vector3(arg_61_0 * 4, arg_61_0 * 4, arg_61_0 * 4))
				elseif arg_61_0 >= 1.8 then
					var_58_3.localScale = Vector3((2 - arg_61_0) * 4, (2 - arg_61_0) * 4, (2 - arg_61_0) * 4)

					setLocalScale(var_0, Vector3((2 - arg_61_0) * 4, (2 - arg_61_0) * 4, (2 - arg_61_0) * 4))
					setImageAlpha(var_58_3, (2 - arg_61_0) * 4)
				end

				return
			end)):setEase(LeanTweenType.linear):setOnComplete(System.Action(function()
				var_58_3.localScale = Vector3(1, 1, 1, 1)

				setLocalScale(var_0, Vector3(1, 1, 1, 1))
				setImageAlpha(var_58_3, 1)
				setActive(var_58_3, false)

				arg_58_0.countingfive_flag = false

				setActive(arg_58_0.countContent, false)
				setActive(arg_58_0.countTf, false)
				arg_58_0:setActionSDmodel("idol")
				arg_58_1()

				return
			end))
		else
			setActive(var_0, true)
		end

		return
	end, 1, -1)

	arg_58_0.count_timer:Start()

	return
end

function var_0_0.showSelevtView(arg_63_0)
	if arg_63_0.isFirstgame == 0 then
		arg_63_0:Firstshow(arg_63_0.firstview, function()
			return
		end, 1)
	end

	local var_63_0 = arg_63_0.selectview:Find("Main")
	local var_63_1 = var_63_0:Find("DgreeList")
	local var_63_2 = var_63_0:Find("MusicList")
	local var_63_3 = var_63_0:Find("namelist")
	local var_63_4 = arg_63_0.selectview:Find("top")
	local var_63_5 = var_63_4:Find("Speedlist")
	local var_63_6 = arg_63_0.selectview:GetComponent("Animator")

	arg_63_0.selectview:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_65_0)
		setActive(arg_63_0.selectview, false)
		arg_63_0:openCoinLayer(false)

		return
	end)
	onButton(arg_63_0, var_63_4:Find("help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_music_game.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_63_0, var_63_4:Find("back"), function()
		if var_0_3 == 0 then
			arg_63_0:emit(var_0_0.ON_BACK)
		end

		return
	end, SFX_PANEL)
	onButton(arg_63_0, var_63_0:Find("Start_btn"), function()
		if var_0_3 == 0 then
			var_63_6:Play("selectExitAnim")
			arg_63_0:clearSDModel()
			arg_63_0:updateMusic(arg_63_0.selectIndex)
			arg_63_0:game_start()

			GetOrAddComponent(arg_63_0.selectview, "CanvasGroup").blocksRaycasts = false
		else
			arg_63_0.startBtnReady = true
		end

		return
	end, SFX_UI_CONFIRM)
	onButton(arg_63_0, var_63_1:Find("easy"), function()
		arg_63_0.game_dgree = 1

		setActive(var_63_1:Find("hard/frame"), false)
		setActive(var_63_1:Find("easy/frame"), true)
		arg_63_0:updatSelectview()

		return
	end, SFX_UI_CLICK)
	onButton(arg_63_0, var_63_1:Find("hard"), function()
		arg_63_0.game_dgree = 2

		setActive(var_63_1:Find("easy/frame"), false)
		setActive(var_63_1:Find("hard/frame"), true)
		arg_63_0:updatSelectview()

		return
	end, SFX_UI_CLICK)
	onButton(arg_63_0, var_63_4:Find("Speedlist"), function()
		setActive(var_63_5:Find("x" .. arg_63_0.game_speed), false)

		arg_63_0.game_speed = arg_63_0.game_speed + 1 > 4 and 1 or arg_63_0.game_speed + 1

		PlayerPrefs.SetInt("musicgame_idol_speed", arg_63_0.game_speed)
		setActive(var_63_5:Find("x" .. arg_63_0.game_speed), true)

		return
	end, SFX_UI_CLICK)

	arg_63_0.song_btn = var_63_2:Find("song")

	setActive(arg_63_0.song_btn, false)

	arg_63_0.song_btns = {}

	local var_63_7 = arg_63_0.gameMusicIndex

	for iter_63_0 = 1, arg_63_0.music_amount do
		arg_63_0.song_btns[iter_63_0] = cloneTplTo(arg_63_0.song_btn, var_63_2, "music" .. iter_63_0)

		local var_63_8 = arg_63_0.musicDatas[iter_63_0]

		setActive(arg_63_0.song_btns[iter_63_0], true)

		local var_63_9 = math.abs(iter_63_0 - var_63_7)
		local var_63_10 = iter_63_0 - var_63_7 < arg_63_0.music_amount_middle and var_63_9 or iter_63_0 - arg_63_0.music_amount_middle * 2

		arg_63_0.song_btns[iter_63_0].localPosition = Vector3(arg_63_0.song_btn.localPosition.x + (iter_63_0 - var_63_7 < arg_63_0.music_amount_middle and var_63_9 or iter_63_0 - arg_63_0.music_amount_middle * 2) * 1022, arg_63_0.song_btn.localPosition.y, arg_63_0.song_btn.localPosition.z)
		arg_63_0.song_btns[iter_63_0].localScale = Vector3(arg_63_0.song_btn.localScale.x - math.abs(var_63_10) * 0.2, arg_63_0.song_btn.localScale.y - math.abs(var_63_10) * 0.2, arg_63_0.song_btn.localScale.z - math.abs(var_63_10) * 0.2)

		local var_63_11 = arg_63_0.song_btns[iter_63_0]:Find("song"):GetComponent(typeof(Image))
		local var_63_12 = var_63_2:Find("img/" .. var_63_8.picture)

		var_63_11.sprite = var_63_12:GetComponent(typeof(Image)).sprite

		local var_63_13 = arg_63_0.song_btns[iter_63_0]:Find("zhuanji3/zhuanji2_5"):GetComponent(typeof(Image))
		local var_63_14 = var_63_2:Find("img/" .. var_63_8.picture .. "_1")

		var_63_13.sprite = var_63_14:GetComponent(typeof(Image)).sprite
		var_63_11.color = Color.New(1, 1, 1, 1 - math.abs(var_63_10) * 0.6)

		onButton(arg_63_0, arg_63_0.song_btns[iter_63_0], function()
			arg_63_0:clickSongBtns(var_63_3, iter_63_0)

			return
		end, SFX_UI_CLICK)

		if iter_63_0 == var_63_7 then
			arg_63_0.song_btns[iter_63_0]:GetComponent(typeof(Animator)):Play("plate_out")

			arg_63_0.song_btns[iter_63_0]:GetComponent(typeof(Button)).interactable = false
		end
	end

	arg_63_0:clickSongBtns(var_63_0:Find("namelist"), 1)

	return
end

function var_0_0.updateMusic(arg_73_0, arg_73_1)
	arg_73_0.musicData = arg_73_0.musicDatas[arg_73_1]
	arg_73_0.selectIndex = arg_73_1
	arg_73_0.game_music = arg_73_0.musicData.id

	if arg_73_0.musicData.ships and #arg_73_0.musicData.ships > 0 then
		arg_73_0.musicShips = arg_73_0.musicData.ships
		arg_73_0.settlementPainting = arg_73_0.musicData.settlement_painting
		arg_73_0.musicLight = arg_73_0.musicData.light
		arg_73_0.shadowLight = arg_73_0.musicData.shadow == 1
		arg_73_0.musicBg = arg_73_0.musicData.bg
	else
		local var_73_0 = MusicGameConst.getRandomBand()

		arg_73_0.musicShips = var_73_0.ships
		arg_73_0.settlementPainting = var_73_0.settlement_painting
		arg_73_0.musicLight = var_73_0.light
		arg_73_0.shadowLight = true
		arg_73_0.musicBg = var_73_0.bg
	end

	arg_73_0.noteType = arg_73_0.musicData.note_type
	arg_73_0.gameMusicIndex = var_0_4
	arg_73_0.SDname = arg_73_0.musicShips
	arg_73_0.score_blist = arg_73_0.musicData.score_rank[1]
	arg_73_0.score_alist = arg_73_0.musicData.score_rank[2]
	arg_73_0.score_slist = arg_73_0.musicData.score_rank[3]
	arg_73_0.score_sslist = arg_73_0.musicData.score_rank[4]

	arg_73_0:setTfChildVisible(arg_73_0.top:Find("scoreContent/B/bl"), false)
	arg_73_0:setTfChildVisible(arg_73_0.top:Find("scoreContent/B/b"), false)
	arg_73_0:setTfChildVisible(arg_73_0.top:Find("scoreContent/A/al"), false)
	arg_73_0:setTfChildVisible(arg_73_0.top:Find("scoreContent/A/a"), false)
	arg_73_0:setTfChildVisible(arg_73_0.top:Find("scoreContent/S/sl"), false)
	arg_73_0:setTfChildVisible(arg_73_0.top:Find("scoreContent/S/s"), false)
	setActive(arg_73_0.top:Find("scoreContent/B/b/" .. arg_73_0.musicData.content_type), true)
	setActive(arg_73_0.top:Find("scoreContent/B/bl/" .. arg_73_0.musicData.content_type), true)
	setActive(arg_73_0.top:Find("scoreContent/A/a/" .. arg_73_0.musicData.content_type), true)
	setActive(arg_73_0.top:Find("scoreContent/A/al/" .. arg_73_0.musicData.content_type), true)
	setActive(arg_73_0.top:Find("scoreContent/S/s/" .. arg_73_0.musicData.content_type), true)
	setActive(arg_73_0.top:Find("scoreContent/S/sl/" .. arg_73_0.musicData.content_type), true)
	arg_73_0:setTfChildVisible(arg_73_0.game_content:Find("combo_n"), false)
	arg_73_0:setTfChildVisible(arg_73_0.game_content:Find("combo"), false)
	setActive(arg_73_0.game_content:Find("combo_n/" .. arg_73_0.musicData.content_type), true)
	setActive(arg_73_0.game_content:Find("combo/" .. arg_73_0.musicData.content_type), true)
	arg_73_0:setTfChildVisible(arg_73_0.btn_pause, false)
	setActive(findTF(arg_73_0.btn_pause, arg_73_0.musicData.content_type), true)
	arg_73_0:setTfChildVisible(arg_73_0.countContent, false)
	arg_73_0:setTfChildVisible(arg_73_0.top:Find("score"), false)
	setActive(arg_73_0.top:Find("score/" .. tostring(arg_73_0.musicData.content_type)), true)

	arg_73_0.gameScoreTf = arg_73_0.top:Find("score/" .. tostring(arg_73_0.musicData.content_type) .. "/text")
	arg_73_0.countTf = findTF(arg_73_0.countContent, arg_73_0.musicData.content_type)

	arg_73_0:updateEffectTf()

	return
end

function var_0_0.setTfChildVisible(arg_74_0, arg_74_1, arg_74_2)
	for iter_74_0 = 1, arg_74_1.childCount do
		setActive(arg_74_1:GetChild(iter_74_0 - 1), false)
	end

	return
end

function var_0_0.updateEffectTf(arg_75_0)
	local var_75_0 = findTF(arg_75_0.game_content, "effect")

	for iter_75_0 = 1, var_75_0.childCount do
		setActive(var_75_0:GetChild(iter_75_0 - 1), false)
	end

	setActive(findTF(arg_75_0.game_content, "effect/" .. arg_75_0.musicData.content_type))

	arg_75_0.fullComboEffect = arg_75_0.game_content:Find("effect/" .. arg_75_0.musicData.content_type .. "/yinyue_Fullcombo")
	arg_75_0.liveClearEffect = arg_75_0.game_content:Find("effect/" .. arg_75_0.musicData.content_type .. "/yinyue_LiveClear")
	arg_75_0.yinyueGood = arg_75_0.game_content:Find("effect/" .. arg_75_0.musicData.content_type .. "/yinyue_good")
	arg_75_0.yinyueComboeffect = arg_75_0.game_content:Find("effect/" .. arg_75_0.musicData.content_type .. "/yinyue_comboeffect")
	arg_75_0.yinyuePerfect = arg_75_0.game_content:Find("effect/" .. arg_75_0.musicData.content_type .. "/yinyue_perfect")
	arg_75_0.yinyuePefectLoop = arg_75_0.game_content:Find("effect/" .. arg_75_0.musicData.content_type .. "/yinyue_perfect_loop02")

	return
end

function var_0_0.getBeatGameMusicData(arg_76_0, arg_76_1)
	for iter_76_0 = 1, #arg_76_0.musicDatas do
		if arg_76_0.musicDatas[iter_76_0].id == arg_76_1 then
			return arg_76_0.musicDatas[iter_76_0]
		end
	end

	return nil
end

function var_0_0.clickSongBtns(arg_77_0, arg_77_1, arg_77_2)
	if var_0_3 > 0 then
		return
	end

	setActive(arg_77_1:Find("song" .. arg_77_0.musicData.picture), false)
	arg_77_0:MyGetRuntimeData()
	arg_77_0:clearSDModel()
	arg_77_0:updateMusic(arg_77_2)
	arg_77_0:loadAndPlayMusic()
	arg_77_0:updatSelectview()
	arg_77_0:changeLocalpos(arg_77_2)
	setActive(arg_77_1:Find("song" .. arg_77_0.musicData.picture), true)

	return
end

function var_0_0.changeLocalpos(arg_78_0, arg_78_1)
	local var_78_0 = arg_78_0.music_amount_middle - arg_78_1
	local var_78_1 = 0.5
	local var_78_2 = {}

	for iter_78_0 = 1, arg_78_0.music_amount do
		({})[iter_78_0] = arg_78_0.song_btns[iter_78_0].localPosition
	end

	local var_78_3 = {}

	for iter_78_1 = 1, arg_78_0.music_amount do
		({})[iter_78_1] = arg_78_0.song_btns[iter_78_1].localScale
	end

	arg_78_0.changeLocalpos_timer = Timer.New(function()
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
					arg_78_0.song_btns[iter_79_0]:GetComponent(typeof(Animator)):Play("plate_out")
				else
					arg_78_0.song_btns[iter_79_0]:GetComponent(typeof(Animator)):Play("plate_static")

					arg_78_0.song_btns[iter_79_0]:GetComponent(typeof(Button)).interactable = true
				end
			else
				arg_78_0.song_btns[iter_79_0]:GetComponent(typeof(Animator)):Play("plate_static")

				arg_78_0.song_btns[iter_79_0]:GetComponent(typeof(Button)).interactable = false
				var_79_1 = math.abs(var_79_0 - var_0)
			end

			arg_78_0.song_btns[iter_79_0].localPosition = Vector3((arg_78_0.song_btn.localPosition.x + (var_79_0 - var_0 > 0 and 1 or -1) * var_79_1 * 1022) * (1 - var_78_1 * 2) + var_78_2[iter_79_0].x * var_78_1 * 2, arg_78_0.song_btn.localPosition.y, arg_78_0.song_btn.localPosition.z)
			arg_78_0.song_btns[iter_79_0].localScale = Vector3((1 - var_79_1 * 0.2) * (1 - var_78_1 * 2) + var_78_3[iter_79_0].x * var_78_1 * 2, (1 - var_79_1 * 0.2) * (1 - var_78_1 * 2) + var_78_3[iter_79_0].x * var_78_1 * 2, (1 - var_79_1 * 0.2) * (1 - var_78_1 * 2) + var_78_3[iter_79_0].x * var_78_1 * 2)

			local var_79_3 = arg_78_0.song_btns[iter_79_0]:Find("song"):GetComponent(typeof(Image))

			var_79_3.color = Color.New(1, 1, 1, 1 - var_79_1 * 0.6)
		end

		if var_78_1 <= 0 then
			arg_78_0.changeLocalposTimerflag = false

			arg_78_0.changeLocalpos_timer:Stop()
		end

		return
	end, arg_78_0.time_interval, -1)

	arg_78_0.changeLocalpos_timer:Start()

	return
end

function var_0_0.addRingDragListenter(arg_80_0)
	local var_80_0 = GetOrAddComponent(arg_80_0.selectview, "EventTriggerListener")
	local var_80_1
	local var_80_2 = 0

	var_80_0:AddBeginDragFunc(function()
		var_80_2 = 0
		var_80_1 = nil

		return
	end)
	var_80_0:AddDragFunc(function(arg_82_0, arg_82_1)
		if not arg_80_0.inPaintingView then
			var_80_1 = var_80_1 or arg_82_1.position
			var_80_2 = arg_82_1.position.x - var_80_1.x
		end

		return
	end)
	var_80_0:AddDragEndFunc(function(arg_83_0, arg_83_1)
		if not arg_80_0.inPaintingView and not arg_80_0.changeLocalposTimerflag then
			local var_83_0, var_83_1 = arg_80_0:getNextPreSelectId()

			if var_80_2 < -50 then
				triggerButton(arg_80_0.song_btns[var_83_0])
			elseif var_80_2 > 50 then
				triggerButton(arg_80_0.song_btns[var_83_1])
			end
		end

		return
	end)

	return
end

function var_0_0.getNextPreSelectId(arg_84_0)
	local var_84_0
	local var_84_1
	local var_84_2 = arg_84_0.game_music + 1
	local var_84_3 = arg_84_0.game_music - 1

	if arg_84_0.game_music - 1 <= 0 then
		var_84_3 = #arg_84_0.musicDatas
	end

	if var_84_2 > #arg_84_0.musicDatas then
		var_84_2 = 1
	end

	for iter_84_0, iter_84_1 in ipairs(arg_84_0.musicDatas) do
		if arg_84_0.musicDatas[iter_84_0].id == var_84_2 then
			var_84_0 = iter_84_0
		end

		if arg_84_0.musicDatas[iter_84_0].id == var_84_3 then
			var_84_1 = iter_84_0
		end
	end

	return var_84_0, var_84_1
end

function var_0_0.Firstshow(arg_85_0, arg_85_1, arg_85_2, arg_85_3)
	arg_85_0.count = 0

	setActive(arg_85_1, true)
	LoadSpriteAtlasAsync("ui/minigameui/musicgameother_atlas", "help1", function(arg_86_0)
		GetComponent(findTF(arg_85_0.firstview, "num/img1"), typeof(Image)).sprite = arg_86_0

		return
	end)
	LoadSpriteAtlasAsync("ui/minigameui/musicgameother_atlas", "help2", function(arg_87_0)
		GetComponent(findTF(arg_85_0.firstview, "num/img2"), typeof(Image)).sprite = arg_87_0

		return
	end)

	for iter_85_0 = 1, 2 do
		setActive(findTF(arg_85_1, "num/img" .. iter_85_0), iter_85_0 == arg_85_3 and true or false)
	end

	if arg_85_0.firstview_timer then
		if arg_85_0.firstview_timer.running then
			arg_85_0.firstview_timer:Stop()
		end

		arg_85_0.firstview_timer = nil
	end

	arg_85_0.firstview_timerRunflag = true
	arg_85_0.firstview_timer = Timer.New(function()
		arg_85_0.count = arg_85_0.count + 1

		if arg_85_0.count > 3 then
			onButton(arg_85_0, arg_85_0.firstview, function()
				if arg_85_2 then
					arg_85_2()
				end

				arg_85_0.firstview_timer:Stop()
				setActive(arg_85_1, false)

				arg_85_0.firstview_timerRunflag = false

				removeOnButton(arg_85_0.firstview)

				return
			end)
		end

		return
	end, 1, -1)

	arg_85_0.firstview_timer:Start()

	return
end

function var_0_0.updatSelectview(arg_90_0)
	if not arg_90_0.song_btns or #arg_90_0.song_btns <= 0 or not arg_90_0.selectview then
		return
	end

	setActive(arg_90_0.selectview:Find("top/Speedlist/x" .. arg_90_0.game_speed), true)

	for iter_90_0 = 1, arg_90_0.music_amount do
		setActive(arg_90_0.song_btns[arg_90_0.musicDatas[iter_90_0].id]:Find("song/best"), false)
		arg_90_0:setSelectview_pj("e", arg_90_0.musicDatas[iter_90_0].id)
	end

	if arg_90_0.song_btns[arg_90_0.game_music] and arg_90_0.bestScorelist[arg_90_0.game_music + (arg_90_0.game_dgree - 1) * arg_90_0.music_amount] > 0 then
		setActive(arg_90_0.song_btns[arg_90_0.game_music]:Find("song/best"), true)
		setText(arg_90_0.song_btns[arg_90_0.game_music]:Find("song/best/score"), arg_90_0.bestScorelist[arg_90_0.game_music + (arg_90_0.game_dgree - 1) * arg_90_0.music_amount])
		arg_90_0:setSelectview_pj("e", arg_90_0.game_music)

		if arg_90_0.bestScorelist[arg_90_0.game_music + (arg_90_0.game_dgree - 1) * arg_90_0.music_amount] < arg_90_0.score_blist[arg_90_0.game_dgree] then
			arg_90_0:setSelectview_pj("c", arg_90_0.game_music)
		elseif arg_90_0.bestScorelist[arg_90_0.game_music + (arg_90_0.game_dgree - 1) * arg_90_0.music_amount] >= arg_90_0.score_blist[arg_90_0.game_dgree] and arg_90_0.bestScorelist[arg_90_0.game_music + (arg_90_0.game_dgree - 1) * arg_90_0.music_amount] < arg_90_0.score_alist[arg_90_0.game_dgree] then
			arg_90_0:setSelectview_pj("b", arg_90_0.game_music)
		elseif arg_90_0.bestScorelist[arg_90_0.game_music + (arg_90_0.game_dgree - 1) * arg_90_0.music_amount] >= arg_90_0.score_alist[arg_90_0.game_dgree] and arg_90_0.bestScorelist[arg_90_0.game_music + (arg_90_0.game_dgree - 1) * arg_90_0.music_amount] < arg_90_0.score_slist[arg_90_0.game_dgree] then
			arg_90_0:setSelectview_pj("a", arg_90_0.game_music)
		else
			arg_90_0:setSelectview_pj("s", arg_90_0.game_music)
		end
	end

	return
end

function var_0_0.setSelectview_pj(arg_91_0, arg_91_1, arg_91_2)
	if arg_91_1 == "e" then
		setActive(arg_91_0.song_btns[arg_91_2]:Find("song/c"), false)
		setActive(arg_91_0.song_btns[arg_91_2]:Find("song/b"), false)
		setActive(arg_91_0.song_btns[arg_91_2]:Find("song/a"), false)
		setActive(arg_91_0.song_btns[arg_91_2]:Find("song/s"), false)
	elseif arg_91_1 == "c" then
		setActive(arg_91_0.song_btns[arg_91_2]:Find("song/c"), true)
	elseif arg_91_1 == "b" then
		setActive(arg_91_0.song_btns[arg_91_2]:Find("song/b"), true)
	elseif arg_91_1 == "a" then
		setActive(arg_91_0.song_btns[arg_91_2]:Find("song/a"), true)
	elseif arg_91_1 == "s" then
		setActive(arg_91_0.song_btns[arg_91_2]:Find("song/s"), true)
	end

	return
end

function var_0_0.updateScoreUIContent(arg_92_0)
	local var_92_0 = findTF(arg_92_0.scoreview, "ui")

	for iter_92_0 = 1, var_92_0.childCount do
		setActive(var_92_0:GetChild(iter_92_0 - 1), false)
	end

	arg_92_0.scoreUIContent = arg_92_0.musicData.settlement_type and arg_92_0.musicData.settlement_type ~= "" and findTF(arg_92_0.scoreview, "ui/" .. arg_92_0.musicData.settlement_type) or findTF(arg_92_0.scoreview, "ui/normal")

	setActive(arg_92_0.scoreUIContent, true)

	return
end

function var_0_0.locadScoreView(arg_93_0)
	arg_93_0:updateScoreUIContent()
	arg_93_0:effect_play("nothing")

	arg_93_0.game_playingflag = false

	setActive(arg_93_0.scoreview, true)

	arg_93_0.scoreview_flag = true

	setImageColor(findTF(arg_93_0.scoreview, "bg"), Color(0, 0, 0))
	LoadSpriteAtlasAsync("ui/minigameui/musicgameother_atlas", "scoreBg" .. arg_93_0.musicBg, function(arg_94_0)
		if var_0 then
			GetComponent(var_0, typeof(Image)).sprite = arg_94_0

			setImageColor(var_0, Color(1, 1, 1))
			setActive(var_0, true)
		end

		return
	end)
	setActive(arg_93_0.game_content:Find("combo"), false)
	setActive(arg_93_0.game_content:Find("MusicStar"), false)
	setActive(arg_93_0.game_content:Find("combo_n"), false)
	setActive(arg_93_0.game_content, false)
	setActive(arg_93_0.top, false)
	setActive(arg_93_0._tf:Find("Spinelist"), false)

	for iter_93_0 = 1, arg_93_0.scoreview:Find("maskBg").childCount do
		setActive(arg_93_0.scoreview:Find("maskBg/bg" .. iter_93_0), iter_93_0 == arg_93_0.musicBg)
	end

	for iter_93_1 = 1, arg_93_0.scoreview:Find("maskBgBottom").childCount do
		setActive(arg_93_0.scoreview:Find("maskBgBottom/bg" .. iter_93_1), iter_93_1 == arg_93_0.musicBg)
	end

	local var_93_0 = arg_93_0.game_dgree
	local var_93_1 = arg_93_0.game_music

	if arg_93_0.painting then
		retPaintingPrefab(arg_93_0.scoreview:Find("paint"), arg_93_0.painting)
	end

	local var_93_2 = {}

	for iter_93_2 = 1, #arg_93_0.settlementPainting do
		if arg_93_0.settlementPainting[iter_93_2] and arg_93_0.settlementPainting[iter_93_2] ~= "" and arg_93_0.settlementPainting[iter_93_2] ~= "none" then
			table.insert(var_93_2, arg_93_0.settlementPainting[iter_93_2])
		end
	end

	arg_93_0.painting = var_93_2[math.random(1, #var_93_2)]

	local var_93_3 = MusicGameConst.painting_const_key[string.lower(arg_93_0.painting)]

	if var_93_3 then
		PaintingGroupConst.AddPaintingNameWithFilteMap({}, var_93_3)
		PaintingGroupConst.PaintingDownload({
			isShowBox = false,
			paintingNameList = {},
			finishFunc = function()
				setPaintingPrefabAsync(arg_93_0.scoreview:Find("paint"), arg_93_0.painting, "mainNormal")

				return
			end
		})
	else
		setPaintingPrefabAsync(arg_93_0.scoreview:Find("paint"), arg_93_0.painting, "mainNormal")
	end

	setActive(arg_93_0.scoreUIContent:Find("scoreImg/square/easy"), var_93_0 == 1)
	setActive(arg_93_0.scoreUIContent:Find("scoreImg/square/hard"), var_93_0 == 2)
	setActive(arg_93_0.scoreUIContent:Find("scoreList/fullCombo"), arg_93_0.miss_number == 0)
	setActive(arg_93_0.scoreUIContent:Find("scoreImg/perfect/noMiss"), arg_93_0.miss_number == 0 and arg_93_0.good_number == 0)

	local function var_93_4(arg_96_0, arg_96_1, arg_96_2)
		LeanTween.value(go(arg_93_0.scoreview), 0, arg_96_1, 0.6):setOnUpdate(System.Action_float(function(arg_97_0)
			setText(arg_96_0, math.round(arg_97_0))

			return
		end)):setOnComplete(System.Action(function()
			arg_96_2()

			return
		end))

		return
	end

	seriesAsync({
		function(arg_99_0)
			var_93_4(arg_93_0.scoreUIContent:Find("scoreList/perfect"), arg_93_0.perfect_number, arg_99_0)

			return
		end,
		function(arg_100_0)
			var_93_4(arg_93_0.scoreUIContent:Find("scoreList/good"), arg_93_0.good_number, arg_100_0)

			return
		end,
		function(arg_101_0)
			var_93_4(arg_93_0.scoreUIContent:Find("scoreList/miss"), arg_93_0.miss_number, arg_101_0)

			return
		end,
		function(arg_102_0)
			var_93_4(arg_93_0.scoreUIContent:Find("scoreList/combo"), arg_93_0.combo_number, arg_102_0)

			return
		end,
		function(arg_103_0)
			local var_103_0 = arg_93_0.bestScorelist[var_93_1 + (var_93_0 - 1) * arg_93_0.music_amount]

			if not arg_93_0.bestScorelist[var_93_1 + (var_93_0 - 1) * arg_93_0.music_amount] or var_103_0 == 0 then
				var_103_0 = arg_93_0.score_number
			end

			if arg_93_0.score_number > arg_93_0.bestScorelist[var_93_1 + (var_93_0 - 1) * arg_93_0.music_amount] then
				setActive(arg_93_0.scoreUIContent:Find("scoreImg/square/newScore"), true)

				arg_93_0.bestScorelist[var_93_1 + (var_93_0 - 1) * arg_93_0.music_amount] = arg_93_0.score_number
			else
				setActive(arg_93_0.scoreUIContent:Find("scoreImg/square/newScore"), false)
			end

			var_93_4(arg_93_0.scoreUIContent:Find("scoreImg/square/bestscore"), var_103_0, arg_103_0)
			var_93_4(arg_93_0.scoreUIContent:Find("scoreImg/square/score"), arg_93_0.score_number, function()
				return
			end)
			arg_93_0:MyStoreDataToServer()
			arg_93_0:MyGetRuntimeData()

			return
		end,
		function(arg_105_0)
			local var_105_0 = arg_93_0.score_number < arg_93_0.score_blist[var_93_0] and function()
				arg_93_0:setScoceview_pj("c")

				return
			end or arg_93_0.score_number >= arg_93_0.score_blist[var_93_0] and arg_93_0.score_number < arg_93_0.score_alist[var_93_0] and function()
				arg_93_0:setScoceview_pj("b")
				arg_93_0:emit(BaseMiniGameMediator.MINI_GAME_SUCCESS, 0)

				return
			end or arg_93_0.score_number >= arg_93_0.score_alist[var_93_0] and arg_93_0.score_number < arg_93_0.score_slist[var_93_0] and function()
				arg_93_0:setScoceview_pj("a")
				arg_93_0:emit(BaseMiniGameMediator.MINI_GAME_SUCCESS, 0)

				return
			end or function()
				arg_93_0:setScoceview_pj("s")
				arg_93_0:emit(BaseMiniGameMediator.MINI_GAME_SUCCESS, 0)

				return
			end
			local var_105_1 = arg_93_0:GetMGHubData()
			local var_105_2 = pg.NewStoryMgr.GetInstance()
			local var_105_3 = arg_93_0:GetMGData():getConfig("simple_config_data").story

			if var_105_3[var_105_1.usedtime + 1] then
				local var_105_4 = var_105_3[var_105_1.usedtime + 1][1] or nil

				if var_105_1.count > 0 and var_105_4 and not var_105_2:IsPlayed(var_105_4) and arg_93_0.score_number >= arg_93_0.score_blist[var_93_0] then
					var_105_2:Play(var_105_4, var_105_0)
				else
					var_105_0()
				end

				arg_105_0()

				return
			end
		end
	}, function()
		return
	end)
	setText(arg_93_0.scoreUIContent:Find("scoreImg/square/nameText"), arg_93_0.musicData.music_name)

	local var_93_5 = arg_93_0.scoreUIContent:Find("scoreImg/square/name"):GetComponent(typeof(Image))

	var_93_5.sprite = arg_93_0.selectview:Find("Main/namelist/song" .. arg_93_0.musicData.picture):GetComponent(typeof(Image)).sprite

	var_93_5:SetNativeSize()

	arg_93_0.scoreUIContent:Find("scoreImg/square/song"):GetComponent(typeof(Image)).sprite = arg_93_0.selectview:Find("Main/MusicList/img/" .. arg_93_0.musicData.picture):GetComponent(typeof(Image)).sprite

	GetComponent(arg_93_0.scoreUIContent:Find("btnList/share"), typeof(Image)):SetNativeSize()
	onButton(arg_93_0, arg_93_0.scoreUIContent:Find("btnList/share"), function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeSummary)

		return
	end, SFX_PANEL)
	GetComponent(arg_93_0.scoreUIContent:Find("btnList/restart"), typeof(Image)):SetNativeSize()
	onButton(arg_93_0, arg_93_0.scoreUIContent:Find("btnList/restart"), function()
		setActive(arg_93_0.scoreview, false)

		arg_93_0.scoreview_flag = false

		arg_93_0:stopTimer()
		arg_93_0:rec_scorce()
		arg_93_0:game_start()
		arg_93_0:setScoceview_pj("e")

		if arg_93_0.painting then
			retPaintingPrefab(arg_93_0.scoreview:Find("paint"), arg_93_0.painting)

			arg_93_0.painting = nil
		end

		return
	end, SFX_UI_CLICK)
	GetComponent(arg_93_0.scoreUIContent:Find("btnList/reselect"), typeof(Image)):SetNativeSize()
	onButton(arg_93_0, arg_93_0.scoreUIContent:Find("btnList/reselect"), function()
		arg_93_0:dynamicBgHandler(arg_93_0.bgGo)
		setActive(arg_93_0.scoreview, false)

		arg_93_0.scoreview_flag = false

		arg_93_0:stopTimer()
		setActive(arg_93_0.selectview, true)
		arg_93_0:openCoinLayer(true)

		GetOrAddComponent(arg_93_0.selectview, "CanvasGroup").blocksRaycasts = true

		arg_93_0:updatSelectview()
		arg_93_0.song_btns[arg_93_0.game_music]:GetComponent(typeof(Animator)):Play("plate_out")
		arg_93_0:loadAndPlayMusic()
		arg_93_0:rec_scorce()
		arg_93_0:setScoceview_pj("e")

		if arg_93_0.painting then
			retPaintingPrefab(arg_93_0.scoreview:Find("paint"), arg_93_0.painting)

			arg_93_0.painting = nil
		end

		return
	end, SFX_UI_CLICK)

	return
end

function var_0_0.setScoceview_pj(arg_114_0, arg_114_1)
	setActive(arg_114_0.scoreUIContent:Find("scoreImg/square/c"), false)
	setActive(arg_114_0.scoreUIContent:Find("scoreImg/square/b"), false)
	setActive(arg_114_0.scoreUIContent:Find("scoreImg/square/a"), false)
	setActive(arg_114_0.scoreUIContent:Find("scoreImg/square/s"), false)

	if arg_114_1 == "e" then
		-- block empty
	elseif arg_114_1 == "c" then
		setActive(arg_114_0.scoreUIContent:Find("scoreImg/square/c"), true)
	elseif arg_114_1 == "b" then
		setActive(arg_114_0.scoreUIContent:Find("scoreImg/square/b"), true)
	elseif arg_114_1 == "a" then
		setActive(arg_114_0.scoreUIContent:Find("scoreImg/square/a"), true)
	elseif arg_114_1 == "s" then
		setActive(arg_114_0.scoreUIContent:Find("scoreImg/square/s"), true)
	end

	return
end

function var_0_0.Scoceview_ani(arg_115_0)
	local var_115_0 = 0

	setActive(arg_115_0.scoreUIContent:Find("btnList/reselect"), false)
	setActive(arg_115_0.scoreUIContent:Find("btnList/restart"), false)
	setActive(arg_115_0.scoreUIContent:Find("btnList/share"), false)

	arg_115_0.Scoceview_timer = Timer.New(function()
		var_115_0 = var_115_0 + arg_115_0.time_interval

		if var_115_0 >= 0.99 then
			setActive(arg_115_0.scoreUIContent:Find("btnList/reselect"), true)
			setActive(arg_115_0.scoreUIContent:Find("btnList/restart"), true)
			setActive(arg_115_0.scoreUIContent:Find("btnList/share"), true)
			setText(arg_115_0.scoreUIContent:Find("scoreList/perfect"), arg_115_0.perfect_number)
			setText(arg_115_0.scoreUIContent:Find("scoreList/good"), arg_115_0.good_number)
			setText(arg_115_0.scoreUIContent:Find("scoreList/miss"), arg_115_0.miss_number)
			setText(arg_115_0.scoreUIContent:Find("scoreList/combo"), arg_115_0.combo_number)
			setText(arg_115_0.scoreUIContent:Find("scoreImg/square/bestscore"), arg_115_0.score_number)
		else
			setText(arg_115_0.scoreUIContent:Find("scoreList/perfect"), math.floor(arg_115_0.perfect_number * var_115_0))
			setText(arg_115_0.scoreUIContent:Find("scoreList/good"), math.floor(arg_115_0.good_number * var_115_0))
			setText(arg_115_0.scoreUIContent:Find("scoreList/miss"), math.floor(arg_115_0.miss_number * var_115_0))
			setText(arg_115_0.scoreUIContent:Find("scoreList/combo"), math.floor(arg_115_0.combo_number * var_115_0))
			setText(arg_115_0.scoreUIContent:Find("scoreImg/square/bestscore"), math.floor(arg_115_0.score_number * var_115_0))
		end

		if var_115_0 >= 1.03 then
			arg_115_0.Scoceview_timer:Stop()
		end

		return
	end, arg_115_0.time_interval, -1)

	arg_115_0.Scoceview_timer:Start()

	return
end

function var_0_0.gameStart(arg_117_0)
	arg_117_0.timer = arg_117_0.timer or Timer.New(function()
		arg_117_0:gameStepNew()

		return
	end, arg_117_0.time_interval, -1)
	arg_117_0.aheadtime_count = 0

	local var_117_0 = 2

	arg_117_0.ahead_timerPauseFlag = false

	CriWareMgr.Inst:UnloadCueSheet(arg_117_0:getMusicBgm(arg_117_0.musicData))

	arg_117_0.ahead_timer = Timer.New(function()
		arg_117_0.ahead_timeflag = true

		if not arg_117_0.timer.running then
			arg_117_0:startTimer()
		end

		if not arg_117_0.ahead_timerPauseFlag then
			arg_117_0.aheadtime_count = arg_117_0.aheadtime_count + arg_117_0.time_interval

			if arg_117_0.aheadtime_count > var_117_0 then
				arg_117_0.aheadtime_count = nil
				arg_117_0.ahead_timeflag = false
				arg_117_0.gotspecialcombo_flag = false

				arg_117_0.ahead_timer:Stop()
				arg_117_0:loadAndPlayMusic(function()
					return
				end)
			end
		end

		return
	end, arg_117_0.time_interval, -1)

	arg_117_0:count_five(function()
		arg_117_0.ahead_timer:Start()

		return
	end)

	return
end

function var_0_0.getMusicBgm(arg_122_0, arg_122_1)
	local var_122_0 = "bgm-song"

	var_122_0 = arg_122_1.bgm < 10 and var_122_0 .. "0" .. tostring(arg_122_1.bgm) or var_122_0 .. tostring(arg_122_1.bgm)

	return var_122_0
end

function var_0_0.getMusicNote(arg_123_0, arg_123_1, arg_123_2)
	return "view/miniGame/gameView/musicGame/bgm_song" .. "0" .. arg_123_1.note .. "_" .. arg_123_2
end

function var_0_0.gameStepNew(arg_124_0)
	arg_124_0.gameStepTime = arg_124_0:getStampTime()
	arg_124_0.downingright_lastflag = arg_124_0.downingright_flag
	arg_124_0.downingleft_lastflag = arg_124_0.downingleft_flag

	if IsUnityEditor then
		if arg_124_0.game_dgree == 2 then
			arg_124_0.downingright_flag = Input.GetKey(KeyCode.J)
			arg_124_0.downingleft_flag = Input.GetKey(KeyCode.F)
		elseif arg_124_0.game_dgree == 1 then
			if Input.GetKey(KeyCode.J) or Input.GetKey(KeyCode.F) then
				arg_124_0.downingright_flag = true
				arg_124_0.downingleft_flag = true
			else
				arg_124_0.downingright_flag = false
				arg_124_0.downingleft_flag = false
			end
		end
	elseif arg_124_0.game_dgree == 2 then
		arg_124_0.downingright_flag = arg_124_0.mousedowningright_flag
		arg_124_0.downingleft_flag = arg_124_0.mousedowningleft_flag
	elseif arg_124_0.game_dgree == 1 then
		if arg_124_0.mousedowningright_flag or arg_124_0.mousedowningleft_flag then
			arg_124_0.downingright_flag = true
			arg_124_0.downingleft_flag = true
		else
			arg_124_0.downingright_flag = false
			arg_124_0.downingleft_flag = false
		end
	end

	if arg_124_0.game_dgree == 2 then
		if not arg_124_0.downingleft_lastflag and arg_124_0.downingleft_flag then
			arg_124_0.gameNoteLeft:onKeyDown()

			arg_124_0.leftDownStepTime = arg_124_0.gameStepTime

			if arg_124_0.rightDownStepTime and math.abs(arg_124_0.leftDownStepTime - arg_124_0.rightDownStepTime) < 100 then
				arg_124_0.gameNoteLeft:bothDown()
				arg_124_0.gameNoteRight:bothDown()
			end
		elseif arg_124_0.downingleft_lastflag and not arg_124_0.downingleft_flag then
			arg_124_0.leftUpStepTime = arg_124_0.gameStepTime

			arg_124_0.gameNoteLeft:onKeyUp()

			if arg_124_0.rightUpStepTime and math.abs(arg_124_0.leftUpStepTime - arg_124_0.rightUpStepTime) < 100 then
				arg_124_0.gameNoteLeft:bothUp()
				arg_124_0.gameNoteRight:bothUp()
			end
		end

		if not arg_124_0.downingright_lastflag and arg_124_0.downingright_flag then
			arg_124_0.gameNoteRight:onKeyDown()

			arg_124_0.rightDownStepTime = arg_124_0.gameStepTime

			if arg_124_0.leftDownStepTime and math.abs(arg_124_0.leftDownStepTime - arg_124_0.rightDownStepTime) < 200 then
				arg_124_0.gameNoteLeft:bothDown()
				arg_124_0.gameNoteRight:bothDown()
			end
		elseif arg_124_0.downingright_lastflag and not arg_124_0.downingright_flag then
			arg_124_0.rightUpStepTime = arg_124_0.gameStepTime

			arg_124_0.gameNoteRight:onKeyUp()

			if arg_124_0.leftUpStepTime and math.abs(arg_124_0.leftUpStepTime - arg_124_0.rightUpStepTime) < 200 then
				arg_124_0.gameNoteLeft:bothUp()
				arg_124_0.gameNoteRight:bothUp()
			end
		end
	elseif not arg_124_0.downingright_lastflag and arg_124_0.downingright_flag then
		arg_124_0.gameNoteLeft:onKeyDown()
		arg_124_0.gameNoteRight:onKeyDown()
	elseif arg_124_0.downingleft_lastflag and not arg_124_0.downingleft_flag then
		arg_124_0.gameNoteLeft:onKeyUp()
		arg_124_0.gameNoteRight:onKeyUp()
	end

	arg_124_0.musicgame_lasttime = arg_124_0.musicgame_nowtime or 0
	arg_124_0.musicgame_nowtime = arg_124_0.criInfo and arg_124_0:getStampTime() / 1000 or 0

	if arg_124_0.song_Tlength and not arg_124_0.scoreview_flag and long2int(arg_124_0.song_Tlength) / 1000 - arg_124_0.musicgame_nowtime <= 0.01666 then
		print("歌曲播放结束")
		arg_124_0:pauseBgm()

		arg_124_0.game_playingflag = false

		local function var_124_0()
			arg_124_0:locadScoreView()

			return
		end

		if arg_124_0.perfect_number > 0 and arg_124_0.good_number == 0 and arg_124_0.miss_number == 0 then
			setActive(arg_124_0.fullComboEffect, true)

			if not arg_124_0.gotspecialcombo_flag then
				arg_124_0.score_number = arg_124_0.score_number + arg_124_0.specialscore_number
				arg_124_0.gotspecialcombo_flag = true
			end

			LeanTween.delayedCall(go(arg_124_0.fullComboEffect), 2, System.Action(function()
				var_124_0()

				return
			end))
		elseif (arg_124_0.good_number > 0 or arg_124_0.perfect_number > 0) and arg_124_0.miss_number <= 0 then
			setActive(arg_124_0.fullComboEffect, true)

			if not arg_124_0.gotspecialcombo_flag then
				arg_124_0.score_number = arg_124_0.score_number + arg_124_0.specialscore_number
				arg_124_0.gotspecialcombo_flag = true
			end

			LeanTween.delayedCall(go(arg_124_0.fullComboEffect), 2, System.Action(function()
				var_124_0()

				return
			end))
		else
			setActive(arg_124_0.liveClearEffect, true)
			LeanTween.delayedCall(go(arg_124_0.liveClearEffect), 2, System.Action(function()
				var_124_0()

				return
			end))
		end

		return
	end

	arg_124_0.gameNoteLeft:step(arg_124_0.gameStepTime)
	arg_124_0.gameNoteRight:step(arg_124_0.gameStepTime)
	arg_124_0:scoresliderAcombo_update()

	if arg_124_0.drumpFlag and not arg_124_0.gameNoteLeft:loopTime() and not arg_124_0.gameNoteRight:loopTime() then
		arg_124_0.drumpFlag = false
		arg_124_0.drupTime = Time.realtimeSinceStartup

		arg_124_0:setActionSDmodel("jump")
		LeanTween.delayedCall(go(arg_124_0.game_content), 1, System.Action(function()
			arg_124_0:setActionSDmodel("idol")

			return
		end))
	end

	return
end

function var_0_0.onStateCallback(arg_130_0, arg_130_1)
	arg_130_0:score_update(arg_130_1)

	return
end

function var_0_0.onLongTimeCallback(arg_131_0, arg_131_1)
	if arg_131_0.drupTime and Time.realtimeSinceStartup - arg_131_0.drupTime < 2 then
		return
	end

	if arg_131_1 > 0.5 then
		arg_131_0.drumpFlag = true
	end

	return
end

return var_0_0

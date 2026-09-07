local MusicGameView = class("MusicGameView", import("..BaseMiniGameView"))
local var_0_1 = false
local var_0_2 = 0.95
local var_0_3 = 0
local var_0_4 = 1
local var_0_5 = 3
local var_0_6 = 5

function MusicGameView:getUIName()
	return "MusicGameUI"
end

function MusicGameView:MyGetRuntimeData()
	self.achieve_times = checkExist(self:GetMGData():GetRuntimeData("elements"), {
		1
	}) or 0
	self.isFirstgame = PlayerPrefs.GetInt("musicgame_first_" .. getProxy(PlayerProxy):getData().id)
	self.bestScorelist = {}

	for iter_2_0 = 1, self.music_amount * 2 do
		local var_2_0 = self:GetMGData()
		local var_2_1 = checkExist(var_2_0:GetRuntimeData("elements"), {
			iter_2_0 + 2
		})

		if not var_2_0 then
			self.bestScorelist[iter_2_0] = 0
		end
	end

	self:updatSelectview()

	return
end

function MusicGameView:MyStoreDataToServer()
	local var_3_0 = {
		self.achieve_times,
		1
	}

	PlayerPrefs.SetInt("musicgame_first_" .. getProxy(PlayerProxy):getData().id, 1)

	for iter_3_0 = 1, self.music_amount * 2 do
		table.insert(var_3_0, iter_3_0 + 2, self.bestScorelist[iter_3_0])
	end

	self:StoreDataToServer(var_3_0)

	return
end

function MusicGameView:init()
	self.useGetKey_flag = true
	self.game_playingflag = false
	self.countingfive_flag = false
	self.downingleft_flag = false
	self.downingright_flag = false
	self.downingright_lastflag = false
	self.downingleft_lastflag = false
	self.nowS_flag = false
	self.firstview_timerRunflag = false
	self.ahead_timeflag = false
	self.ahead_timerPauseFlag = false
	self.changeLocalposTimerflag = false
	self.piecelist_rf = {}
	self.piecelist_rf[0] = 0
	self.piecelist_lf = {}
	self.piecelist_lf[0] = 0
	self.piece_nowl = {}
	self.piece_nowr = {}
	self.piece_nowl_downflag = false
	self.piece_nowr_downflag = false
	self.piece_nowl_aloneflag = false
	self.piece_nowr_aloneflag = false
	self.SDmodel = {}
	self.SDmodel_idolflag = false
	self.musicgame_nowtime = 0
	self.musicgame_lasttime = 0
	self.time_interval = 0.01666
	self.music_amount = #pg.beat_game_music.all
	self.music_amount_middle = math.ceil(#pg.beat_game_music.all / 2)
	self.musicDatas = {}

	for iter_4_0 = 1, #pg.beat_game_music.all do
		table.insert(self.musicDatas, pg.beat_game_music[pg.beat_game_music.all[iter_4_0]])
	end

	table.sort(self.musicDatas, function(arg_5_0, arg_5_1)
		if arg_5_0.sort and arg_5_1.sort then
			return arg_5_0.sort < arg_5_1.sort
		end

		return arg_5_0.id < arg_5_1.id
	end)

	self.game_speed = PlayerPrefs.GetInt("musicgame_idol_speed") > 0 and PlayerPrefs.GetInt("musicgame_idol_speed") or 1
	self.game_dgree = 1
	self.countContent = self._tf:Find("countContent")
	self.countTf = nil
	self.top = self._tf:Find("top")
	self.btn_pause = self.top:Find("pause")
	self.score = self.top:Find("score")
	self.game_content = self._tf:Find("GameContent")
	self.noteTpl = self.game_content:Find("noteTpl")
	self.pauseview = self._tf:Find("Pauseview")
	self.selectview = self._tf:Find("Selectview")

	local var_4_0 = findTF(self.selectview, "bg")

	LoadSpriteAtlasAsync("ui/minigameui/musicgameother_atlas", "selectbg", function(arg_6_0)
		GetComponent(var_4_0, typeof(Image)).sprite = arg_6_0

		setActive(var_4_0, true)

		return
	end)

	self.firstview = self._tf:Find("firstview")
	self.scoreview = self._tf:Find("ScoreView")

	setActive(self.scoreview, false)

	self.scoreview_flag = false
	self.bg = findTF(self._tf, "bg")

	pg.BgmMgr.GetInstance():StopPlay()
	self:updateMusic(var_0_4)

	return
end

function MusicGameView:didEnter()
	local var_7_0 = 0

	LeanTween.delayedCall(go(self.selectview), 2, System.Action(function()
		self:MyGetRuntimeData()

		return
	end))

	self.Getdata_timer = Timer.New(function()
		var_7_0 = var_7_0 + self.time_interval

		if var_7_0 == self.time_interval then
			self:MyGetRuntimeData()
			self:showSelevtView()
		elseif var_7_0 == self.time_interval * 2 then
			self:updatSelectview()
			self.Getdata_timer:Stop()
		end

		return
	end, self.time_interval, -1)

	self.Getdata_timer:Start()

	self.score_number = 0
	self.combo_link = 0
	self.combo_number = 0
	self.perfect_number = 0
	self.good_number = 0
	self.miss_number = 0

	local var_7_1 = self:GetMGData():getConfig("simple_config_data")

	self.piecelist_speed = var_7_1.speed
	self.piecelist_speedmin = var_7_1.speed_min
	self.piecelist_speedmax = var_7_1.speed_max
	self.specialcombo_number = var_7_1.special_combo
	self.specialscore_number = var_7_1.special_score
	self.score_perfect = var_7_1.perfect
	self.score_good = var_7_1.good
	self.score_miss = var_7_1.miss
	self.score_combo = var_7_1.combo
	self.time_perfect = var_7_1.perfecttime
	self.time_good = var_7_1.goodtime
	self.time_miss = var_7_1.misstime
	self.time_laterperfect = var_7_1.laterperfecttime
	self.time_latergood = var_7_1.latergoodtime
	self.combo_interval = var_7_1.combo_interval
	self.BtnRightDelegate = GetOrAddComponent(self.game_content:Find("btn_right"), "EventTriggerListener")

	self.BtnRightDelegate:AddPointDownFunc(function()
		self.mousedowningright_flag = true

		setActive(self.bottonRightBg, true)

		return
	end)
	self.BtnRightDelegate:AddPointUpFunc(function()
		self.mousedowningright_flag = false

		setActive(self.bottonRightBg, false)

		return
	end)

	self.BtnLeftDelegate = GetOrAddComponent(self.game_content:Find("btn_left"), "EventTriggerListener")

	self.BtnLeftDelegate:AddPointDownFunc(function()
		self.mousedowningleft_flag = true

		setActive(self.bottonLeftBg, true)

		return
	end)
	self.BtnLeftDelegate:AddPointUpFunc(function()
		self.mousedowningleft_flag = false

		setActive(self.bottonLeftBg, false)

		return
	end)
	onButton(self, self.top:Find("pause"), function()
		pg.UIMgr.GetInstance():BlurPanel(self.pauseview)
		setActive(self.pauseview, true)

		self.game_playingflag = false

		self:effect_play("nothing")
		LoadSpriteAtlasAsync("ui/minigameui/musicgameother_atlas", "pause_" .. self.musicData.picture, function(arg_15_0)
			setImageSprite(self.pauseview:Find("bottom/song"), arg_15_0, true)

			return
		end)
		GetComponent(self.pauseview:Find("bottom/img"), typeof(Image)):SetNativeSize()

		if not self.ahead_timeflag then
			self:pauseBgm()

			local var_14_0 = self:getStampTime()

			if var_14_0 < 0 then
				var_14_0 = 0
			end

			if var_14_0 >= 0 and self.song_Tlength > 0 then
				local function var_14_1(arg_16_0)
					if arg_16_0 < 10 then
						return "0" .. arg_16_0
					else
						return arg_16_0
					end

					return
				end

				setText(self.pauseview:Find("bottom/now"), var_14_1(math.floor(var_14_0 / 60000)) .. ":" .. var_14_1(math.floor(var_14_0 % 60000 / 1000)))
				setText(self.pauseview:Find("bottom/total"), var_14_1(math.floor(self.song_Tlength / 60000)) .. ":" .. var_14_1(math.floor(self.song_Tlength % 60000 / 1000)))
				setActive(self.pauseview:Find("bottom/triangle"), true)
				setActive(self.pauseview:Find("bottom/TimeSlider"), true)
				setActive(self.pauseview:Find("bottom/now"), true)
				setActive(self.pauseview:Find("bottom/total"), true)
				setSlider(self.pauseview:Find("bottom/TimeSlider"), 0, 1, var_14_0 / self.song_Tlength)

				local var_14_2 = self.pauseview:Find("bottom/triangle/min").localPosition.x
				local var_14_3 = self.pauseview:Find("bottom/triangle/now").localPosition

				self.pauseview:Find("bottom/triangle/now").localPosition = Vector3(var_14_2 + var_14_0 / self.song_Tlength * (self.pauseview:Find("bottom/triangle/max").localPosition.x - var_14_2), var_14_3.y, var_14_3.z)

				self:setActionSDmodel("stand2")
			end
		else
			setActive(self.pauseview:Find("bottom/triangle"), false)
			setActive(self.pauseview:Find("bottom/TimeSlider"), false)
			setActive(self.pauseview:Find("bottom/now"), false)
			setActive(self.pauseview:Find("bottom/total"), false)

			self.ahead_timerPauseFlag = true
		end

		return
	end, SFX_UI_CLICK)
	onButton(self, self.pauseview:Find("bottom/back"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("reselect_music_game"),
			onYes = function()
				pg.UIMgr.GetInstance():UnOverlayPanel(self.pauseview, self._tf)
				setActive(self.pauseview, false)
				self:stopTimer()

				if self.ahead_timer then
					self.ahead_timer:Stop()

					self.ahead_timeflag = false
				end

				setActive(self.selectview, true)
				self:openCoinLayer(true)

				GetOrAddComponent(self.selectview, "CanvasGroup").blocksRaycasts = true

				self.song_btns[self.game_music]:GetComponent(typeof(Animator)):Play("plate_out")

				self.game_playingflag = false

				self:loadAndPlayMusic()
				self:rec_scorce()

				return
			end
		})

		return
	end, SFX_UI_CLICK)
	onButton(self, self.pauseview:Find("bottom/restart"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("restart_music_game"),
			onYes = function()
				pg.UIMgr.GetInstance():UnOverlayPanel(self.pauseview, self._tf)
				setActive(self.pauseview, false)
				self:stopTimer()

				if self.ahead_timer then
					self.ahead_timer:Stop()

					self.ahead_timeflag = false
				end

				self:rec_scorce()
				self:game_start()
				self:effect_play("prepare")

				return
			end
		})

		return
	end, SFX_UI_CLICK)
	onButton(self, self.pauseview:Find("bottom/resume"), function()
		pg.UIMgr.GetInstance():UnOverlayPanel(self.pauseview, self._tf)
		setActive(self.pauseview, false)
		self:effect_play("prepare")

		if not self.ahead_timeflag then
			self:count_five(function()
				self:resumeBgm()

				self.game_playingflag = true

				return
			end)
		else
			self:count_five(function()
				self.ahead_timerPauseFlag = false
				self.game_playingflag = true

				setActive(self.pauseview:Find("bottom/triangle"), true)
				setActive(self.pauseview:Find("bottom/TimeSlider"), true)
				setActive(self.pauseview:Find("bottom/now"), true)
				setActive(self.pauseview:Find("bottom/total"), true)

				return
			end)
		end

		return
	end, SFX_UI_CLICK)
	self:addRingDragListenter()
	setActive(self.selectview, true)
	self:openCoinLayer(true)

	GetOrAddComponent(self.selectview, "CanvasGroup").blocksRaycasts = true

	return
end

function MusicGameView:updateBg()
	if self.isLoading then
		self:dynamicBgHandler(self.bgGo, function()
			setParent(self.bgGo, self.bg)
			setActive(self.bgGo, true)

			return
		end)

		return
	end

	if self.bgGo and self.bgName then
		self:dynamicBgHandler(self.bgGo)
		PoolMgr.GetInstance():ReturnUI(self.bgName, self.bgGo)
	end

	self.bgName = "musicgamebg" .. self.musicBg
	self.isLoading = true

	local var_24_0 = self.bgName

	PoolMgr.GetInstance():GetUI("" .. self.bgName, true, function(arg_26_0)
		self.bgGo = arg_26_0

		if self.isLoading == false then
			self:dynamicBgHandler(self.bgGo)
			PoolMgr.GetInstance():ReturnUI(var_24_0, self.bgGo)
		else
			self.isLoading = false

			setParent(self.bgGo, self.bg)
			setActive(self.bgGo, true)
		end

		return
	end)

	return
end

function MusicGameView:dynamicBgHandler(arg_27_1, arg_27_2)
	if IsNil(arg_27_1) then
		return
	end

	if arg_27_2 ~= nil then
		arg_27_2()
	end

	return
end

function MusicGameView:onBackPressed()
	if not self.countingfive_flag and not self.firstview_timerRunflag then
		if self.game_playingflag then
			if not isActive(self.top:Find("pause_above")) then
				triggerButton(self.top:Find("pause"))
			end
		elseif isActive(self.selectview) and var_0_3 == 0 then
			self:emit(MusicGameView.ON_BACK)
		end
	end

	return
end

function MusicGameView:OnApplicationPaused(arg_29_1)
	if arg_29_1 and not self.countingfive_flag and not self.firstview_timerRunflag and self.game_playingflag and not isActive(self.top:Find("pause_above")) then
		triggerButton(self.top:Find("pause"))
	end

	return
end

function MusicGameView:willExit()
	self.isLoading = false

	if self.bgGo and self.bgName then
		self:dynamicBgHandler(self.bgGo)
		PoolMgr.GetInstance():ReturnUI(self.bgName, self.bgGo)
	end

	if self.timer then
		if self.timer.running then
			self.timer:Stop()
		end

		self.timer = nil
	end

	if self.ahead_timer then
		if self.ahead_timer.running then
			self.ahead_timer:Stop()
		end

		self.ahead_timer = nil
	end

	if self.firstview_timer then
		if self.firstview_timer.running then
			self.firstview_timer:Stop()
		end

		self.firstview_timer = nil
	end

	if self.changeLocalpos_timer then
		if self.changeLocalpos_timer.running then
			self.changeLocalpos_timer:Stop()
		end

		self.changeLocalpos_timer = nil
	end

	if self.count_timer then
		if self.count_timer.running then
			self.count_timer:Stop()
		end

		self.count_timer = nil
	end

	if self.Scoceview_timer then
		if self.Scoceview_timer.running then
			self.Scoceview_timer:Stop()
		end

		self.Scoceview_timer = nil
	end

	if self.Getdata_timer then
		if self.Getdata_timer.running then
			self.Getdata_timer:Stop()
		end

		self.Getdata_timer = nil
	end

	self:clearSDModel()

	self.piecelist_lt = {}
	self.piecelist_lf = {}
	self.musictable_l = {}
	self.piece_nowl = {}
	self.piecelist_rt = {}
	self.piecelist_rf = {}
	self.musictable_r = {}
	self.piece_nowr = {}

	if self.painting then
		retPaintingPrefab(self.scoreview:Find("paint"), self.painting)

		self.painting = nil
	end

	if self.criInfo then
		self.criInfo:PlaybackStop()
		self.criInfo:SetStartTimeAndPlay(0)
		pg.CriMgr.GetInstance():UnloadCueSheet(self:getMusicBgm(self.musicData))

		self.criInfo = nil
	end

	if LeanTween.isTweening(go(self.selectview)) then
		LeanTween.cancel(go(self.selectview))
	end

	if LeanTween.isTweening(go(self.countContent)) then
		LeanTween.cancel(go(self.countContent))
	end

	if LeanTween.isTweening(go(self.scoreview)) then
		LeanTween.cancel(go(self.scoreview))
	end

	if LeanTween.isTweening(go(self.game_content)) then
		LeanTween.cancel(go(self.game_content))
	end

	pg.BgmMgr.GetInstance():ContinuePlay()

	return
end

function MusicGameView:clearSDModel()
	if not self.SDmodel or not self.SDname or self.SDname == "" or self.SDname == "none" then
		return
	end

	for iter_31_0 = 1, #self.SDmodel do
		if self.SDmodel[iter_31_0] then
			PoolMgr.GetInstance():ReturnSpineChar(self.SDname[iter_31_0], self.SDmodel[iter_31_0])
		end
	end

	self.SDmodel = {}

	return
end

function MusicGameView:list_push(arg_32_1, arg_32_2)
	arg_32_1[arg_32_1[0] + 1] = arg_32_2
	arg_32_1[0] = arg_32_1[0] + 1

	return
end

function MusicGameView:list_pop(arg_33_1)
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

function MusicGameView:game_start()
	self:game_before()
	self:effect_play("prepare")

	self.game_playingflag = true
	self.SDmodel_jumpcount = 0
	self.gotspecialcombo_flag = false

	self:updateBg()

	self.song_Tlength = false

	self:effect_play("nothing")
	self:effect_play("prepare")

	if self.isFirstgame == 0 then
		self:Firstshow(self.firstview, function()
			self:gameStart()

			return
		end, 2)
		self:MyStoreDataToServer()
	else
		self:gameStart()
	end

	return
end

function MusicGameView:game_before()
	self:effect_play("nothing")

	self.nowS_flag = false

	self:setTfChildVisible(self.top:Find("scoreContent/scroll"), false)

	self.scoreSliderTf = self.top:Find("scoreContent/scroll/" .. tostring(self.musicData.content_type))

	setSlider(self.scoreSliderTf, 0, 1, 0)
	setActive(self.scoreSliderTf, true)
	setActive(findTF(self.scoreSliderTf, "img/mask/yinyue20_S"), false)

	self.scoreSFlag = false

	setImageColor(findTF(self.scoreSliderTf, "img"), Color(1, 1, 1, 1))

	local var_36_0 = self.game_content:Find("evaluate")

	for iter_36_0 = 1, var_36_0.childCount do
		local var_36_1 = var_36_0:GetChild(iter_36_0 - 1)

		for iter_36_1 = 1, var_36_1.childCount do
			setActive(var_36_1:GetChild(iter_36_1 - 1), false)
		end

		setActive(findTF(var_36_1, tostring(self.musicData.content_type)), true)
		setActive(var_36_0:GetChild(iter_36_0 - 1), false)
	end

	local var_36_2 = self.game_content:Find("bottomList")

	for iter_36_2 = 1, var_36_2.childCount do
		setActive(var_36_2:GetChild(iter_36_2 - 1), false)
	end

	if self.musicData.bottom_type and self.musicData.bottom_type > 0 then
		self.bottonLeftBg = self.game_content:Find("bottomList/" .. self.musicData.bottom_type .. "/bottom_leftbg")
		self.bottonRightBg = self.game_content:Find("bottomList/" .. self.musicData.bottom_type .. "/bottom_rightbg")

		setActive(self.bottonLeftBg, false)
		setActive(self.bottonRightBg, false)
		setActive(self.game_content:Find("bottomList/" .. self.musicData.bottom_type), true)
		setActive(self.game_content:Find("bottomList/" .. self.musicData.bottom_type), true)
	end

	self:clearSDModel()

	for iter_36_3 = 1, #self.SDname do
		self:loadSDModel(iter_36_3)
	end

	self:setActionSDmodel("stand2")
	setActive(self.game_content:Find("combo"), false)
	setActive(self.game_content:Find("combo_n"), false)
	setActive(self.game_content:Find("MusicStar"), false)
	setActive(self.game_content, true)
	setActive(self._tf:Find("Spinelist"), true)
	setActive(self.top, true)
	setActive(self.fullComboEffect, false)
	setActive(self.liveClearEffect, false)

	local var_36_3 = require((self:getMusicNote(self.musicData, self.game_dgree)))

	self.leftPu = {}
	self.rightPu = {}

	for iter_36_4, iter_36_5 in ipairs(var_36_3.left_track) do
		table.insert(self.leftPu, iter_36_5)
	end

	for iter_36_6, iter_36_7 in ipairs(var_36_3.right_track) do
		table.insert(self.rightPu, iter_36_7)
	end

	self:setTfChildVisible(self.noteTpl, false)

	self.gameNoteLeft = self.gameNoteLeft or MusicGameNote.New(findTF(self.game_content, "MusicPieceLeft"), self.noteTpl, MusicGameNote.type_left)
	self.gameNoteRight = self.gameNoteRight or MusicGameNote.New(findTF(self.game_content, "MusicPieceRight"), self.noteTpl, MusicGameNote.type_right)

	self.gameNoteLeft:setStartData(self.leftPu, self.game_speed, self.game_dgree, self.noteType)
	self.gameNoteLeft:setStateCallback(function(arg_37_0)
		self:onStateCallback(arg_37_0)

		return
	end)
	self.gameNoteLeft:setLongTimeCallback(function(arg_38_0)
		self:onLongTimeCallback(arg_38_0)

		return
	end)
	self.gameNoteRight:setStartData(self.rightPu, self.game_speed, self.game_dgree, self.noteType)
	self.gameNoteRight:setStateCallback(function(arg_39_0)
		self:onStateCallback(arg_39_0)

		return
	end)
	self.gameNoteRight:setLongTimeCallback(function(arg_40_0)
		self:onLongTimeCallback(arg_40_0)

		return
	end)

	self.gameStepTime = 0
	self.musictable_l = {}
	self.musictable_l[0] = 0
	self.musictable_r = {}
	self.musictable_r[0] = 0
	self.nowmusic_l = nil
	self.nowmusic_r = nil
	self.musicpu = require((self:getMusicNote(self.musicData, self.game_dgree)))

	for iter_36_8, iter_36_9 in ipairs(self.musicpu.left_track) do
		self:list_push(self.musictable_l, iter_36_9)
	end

	for iter_36_10, iter_36_11 in ipairs(self.musicpu.right_track) do
		self:list_push(self.musictable_r, iter_36_11)
	end

	local var_36_4 = self.top:Find("scoreContent/B")

	var_36_4.anchoredPosition = Vector3(self.scoreSliderTf.anchoredPosition.x + self.scoreSliderTf.rect.width * 0.53, var_36_4.anchoredPosition.y, var_36_4.anchoredPosition.z)
	self.top:Find("scoreContent/A").anchoredPosition = Vector3(self.scoreSliderTf.anchoredPosition.x + self.scoreSliderTf.rect.width * 0.72, var_36_4.anchoredPosition.y, var_36_4.anchoredPosition.z)
	self.top:Find("scoreContent/S").anchoredPosition = Vector3(self.scoreSliderTf.anchoredPosition.x + self.scoreSliderTf.rect.width * 0.885, var_36_4.anchoredPosition.y, var_36_4.anchoredPosition.z)

	self:scoresliderAcombo_update()

	return
end

function MusicGameView:stopTimer()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function MusicGameView:startTimer()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function MusicGameView:loadSDModel(arg_43_1)
	if not self.SDname[arg_43_1] or self.SDname[arg_43_1] == "" or self.SDname[arg_43_1] == "none" then
		self.SDmodel[arg_43_1] = false

		setActive(findTF(self._tf, "Spinelist/" .. arg_43_1 .. "/shadow"), false)
		setActive(findTF(self._tf, "Spinelist/" .. arg_43_1 .. "/light"), false)

		return
	end

	local var_43_0 = findTF(self._tf, "Spinelist/" .. arg_43_1 .. "/light")
	local var_43_1 = findTF(self._tf, "Spinelist/" .. arg_43_1 .. "/" .. self.musicData.content_type)

	var_43_0.anchoredPosition = var_43_1.anchoredPosition
	findTF(self._tf, "Spinelist/" .. arg_43_1 .. "/shadow").anchoredPosition = var_43_1.anchoredPosition

	setActive(var_43_0, true)

	if self.musicLight and self.shadowLight then
		setActive(findTF(self._tf, "Spinelist/" .. arg_43_1 .. "/shadow"), true)
	else
		setActive(findTF(self._tf, "Spinelist/" .. arg_43_1 .. "/shadow"), false)
	end

	for iter_43_0 = 1, var_0_6 do
		if self.musicLight and self.musicLight > 0 then
			setActive(findTF(self._tf, "Spinelist/" .. arg_43_1 .. "/light"), false)

			local var_43_2 = iter_43_0

			if self.musicData.ships[iter_43_0] and self.musicData.ships[iter_43_0] ~= "" and self.musicData.ships[iter_43_0] ~= "none" then
				LoadSpriteAtlasAsync("ui/minigameui/musicgameother_atlas", "light" .. self.musicLight, function(arg_44_0)
					setActive(findTF(self._tf, "Spinelist/" .. var_43_2 .. "/light"), true)
					setImageSprite(findTF(self._tf, "Spinelist/" .. var_43_2 .. "/light"), arg_44_0, true)

					return
				end)
			end
		end

		setActive(findTF(self._tf, "Spinelist/" .. arg_43_1 .. "/light"), false)
	end

	pg.UIMgr.GetInstance():LoadingOff()
	PoolMgr.GetInstance():GetSpineChar(self.SDname[arg_43_1], true, function(arg_45_0)
		self.SDmodel[arg_43_1] = arg_45_0
		tf(arg_45_0).localScale = Vector3(1, 1, 1)

		arg_45_0:GetComponent("SpineAnimUI"):SetAction("stand2", 0)
		setParent(arg_45_0, self._tf:Find("Spinelist/" .. arg_43_1))

		tf(arg_45_0).anchoredPosition = self._tf:Find("Spinelist/" .. arg_43_1 .. "/" .. self.musicData.content_type).anchoredPosition

		return
	end)

	return
end

function MusicGameView:SDmodeljump_btnup()
	if self.downingright_flag or self.downingleft_flag then
		self.SDmodel_jumpcount = self.SDmodel_jumpcount + self.time_interval
		self.SDmodel_jumpcount = self.SDmodel_jumpcount > 1 and 1 or self.SDmodel_jumpcount
	else
		if self.SDmodel_jumpcount == 1 then
			self:setActionSDmodel("jump")

			self.SDmodel_idolflag = false
		end

		if self.SDmodel_jumpcount > 0 then
			self.SDmodel_jumpcount = self.SDmodel_jumpcount - self.time_interval
			self.SDmodel_jumpcount = self.SDmodel_jumpcount < 0 and 0 or self.SDmodel_jumpcount
		end

		if self.SDmodel_jumpcount == 0 and not self.SDmodel_idolflag then
			self.SDmodel_idolflag = true

			self:setActionSDmodel("idol")
		end
	end

	return
end

function MusicGameView:setActionSDmodel(arg_47_1, arg_47_2)
	arg_47_2 = arg_47_2 or 0

	for iter_47_0 = 1, #self.SDmodel do
		if self.SDmodel[iter_47_0] then
			self.SDmodel[iter_47_0]:GetComponent("SpineAnimUI"):SetAction(arg_47_1, arg_47_2)
		end
	end

	return
end

function MusicGameView:loadAndPlayMusic(arg_48_1, arg_48_2)
	local var_48_0 = self:getMusicBgm(self.musicData)

	var_0_3 = var_0_3 + 1

	CriWareMgr.Inst:PlayBGM(var_48_0, CriWareMgr.CRI_FADE_TYPE.FADE_INOUT, function(arg_49_0)
		if arg_49_0 == nil then
			warning("Missing BGM :" .. (var_48_0 or "NIL"))
		else
			print("加载完毕,开始播放音乐")

			if self.countingfive_flag then
				return
			end

			self.criInfo = arg_49_0
			self.song_Tlength = arg_49_0:GetLength()

			arg_49_0:PlaybackStop()

			if IsUnityEditor and var_0_1 then
				self.criInfo:SetStartTimeAndPlay(self.criInfo:GetLength() * var_0_2)
			else
				arg_49_0:SetStartTimeAndPlay((arg_48_2 and arg_48_2 >= 0 or nil) and (arg_48_2 or 0))
			end

			var_0_3 = var_0_3 - 1

			if arg_48_1 then
				arg_48_1()
			end
		end

		return
	end)

	return
end

function MusicGameView:getStampTime()
	if self.aheadtime_count then
		return (self.aheadtime_count - 2) * 1000
	elseif self.criInfo then
		return self.criInfo:GetTime()
	end

	return nil
end

function MusicGameView:pauseBgm()
	if self.criInfo then
		self.pauseTime = self.criInfo:GetTime()

		self.criInfo:PlaybackStop()
	end

	if self.timer and self.timer.running then
		self.timer:Stop()
	end

	return
end

function MusicGameView:resumeBgm()
	if not self.timer.running then
		self.timer:Start()
	end

	self:loadAndPlayMusic(function()
		return
	end, self.pauseTime)

	return
end

function MusicGameView:rec_scorce()
	self.score_number = 0
	self.combo_link = 0
	self.combo_number = 0
	self.perfect_number = 0
	self.good_number = 0
	self.miss_number = 0
	self.gotspecialcombo_flag = false

	setActive(self.top:Find("scoreContent/B/bl"), false)
	setActive(self.top:Find("scoreContent/A/al"), false)
	setActive(self.top:Find("scoreContent/S/sl"), false)
	setText(self.gameScoreTf, 0)
	setText(self.game_content:Find("combo_n/" .. self.musicData.content_type), 0)

	return
end

function MusicGameView:effect_play(arg_55_1, arg_55_2)
	if arg_55_1 == "nothing" then
		setActive(self.yinyuePefectLoop, false)
		setActive(self.top:Find("scoreContent/S/liubianxing"), false)
		setActive(self.yinyueGood, false)
		setActive(self.yinyuePerfect, false)
		setActive(self.game_content:Find("MusicStar"), false)
		SetActive(self.yinyueComboeffect, false)
	elseif arg_55_1 == "prepare" then
		-- block empty
	elseif arg_55_1 == "good" then
		setActive(self.yinyueGood, false)
		setActive(self.yinyueGood, true)
	elseif arg_55_1 == "perfect" then
		setActive(self.yinyuePerfect, false)
		setActive(self.yinyuePerfect, true)
	elseif arg_55_1 == "perfect_loop02" then
		if arg_55_2 then
			if not isActive(self.yinyuePefectLoop) then
				setActive(self.yinyuePefectLoop, true)
			end
		else
			setActive(self.yinyuePefectLoop, false)
		end
	elseif arg_55_1 == "S" then
		if arg_55_2 then
			setActive(findTF(self.scoreSliderTf, "img/mask/yinyue20_S"), true)
		else
			setActive(findTF(self.scoreSliderTf, "img/mask/yinyue20_S"), false)
		end
	end

	return
end

function MusicGameView:scoresliderAcombo_update()
	local var_56_0 = 0

	setText(self.gameScoreTf, self.score_number)

	var_56_0 = self.score_number < self.score_blist[self.game_dgree] and self.score_number / self.score_blist[self.game_dgree] * 0.53 or self.score_number >= self.score_blist[self.game_dgree] and self.score_number < self.score_alist[self.game_dgree] and 0.53 + (self.score_number - self.score_blist[self.game_dgree]) / (self.score_alist[self.game_dgree] - self.score_blist[self.game_dgree]) * 0.19 or self.score_number >= self.score_alist[self.game_dgree] and self.score_number < self.score_slist[self.game_dgree] and 0.72 + (self.score_number - self.score_alist[self.game_dgree]) / (self.score_slist[self.game_dgree] - self.score_alist[self.game_dgree]) * 0.155 or 0.885 + (self.score_number - self.score_slist[self.game_dgree]) / (self.score_sslist[self.game_dgree] - self.score_slist[self.game_dgree]) * 0.115

	setSlider(self.scoreSliderTf, 0, 1, var_56_0)

	if var_56_0 < 0.53 then
		setActive(self.top:Find("scoreContent/B/bl"), false)
		setActive(self.top:Find("scoreContent/A/al"), false)
		setActive(self.top:Find("scoreContent/S/sl"), false)
	elseif var_56_0 >= 0.53 then
		setActive(self.top:Find("scoreContent/B/bl"), true)

		if var_56_0 >= 0.72 then
			setActive(self.top:Find("scoreContent/A/al"), true)

			if var_56_0 >= 0.885 then
				if not self.nowS_flag then
					self.nowS_flag = true

					self:effect_play("S", true)
				end

				setActive(self.top:Find("scoreContent/S/sl"), true)
			end
		end
	end

	setText(self.game_content:Find("combo_n/" .. self.musicData.content_type), self.combo_link)

	return
end

function MusicGameView:score_update(arg_57_1)
	local var_57_0 = self.game_content:Find("evaluate")

	for iter_57_0 = 1, 3 do
		setActive(var_57_0:GetChild(iter_57_0 - 1), false)
	end

	setActive(var_57_0:GetChild(arg_57_1), true)

	if arg_57_1 == 0 then
		self.combo_link = 0
		self.score_number = self.score_number + self.score_miss
		self.miss_number = self.miss_number + 1

		setActive(self.game_content:Find("combo"), false)
		setActive(self.game_content:Find("combo_n"), false)
	else
		self.combo_link = self.combo_link + 1

		if self.combo_number > self.combo_link then
			self.combo_number = self.combo_number or self.combo_link
		end

		if self.combo_link > 1 then
			setActive(self.game_content:Find("combo"), true)
			setActive(self.game_content:Find("combo_n"), true)
			self.game_content:Find("combo"):GetComponent(typeof(Animation)):Play()
			self.game_content:Find("combo_n"):GetComponent(typeof(Animation)):Play()
		else
			setActive(self.game_content:Find("combo"), false)
			setActive(self.game_content:Find("combo_n"), false)
		end

		pg.CriMgr.GetInstance():PlaySE_V3("ui-maoudamashii")
	end

	local var_57_1 = 0

	for iter_57_1 = 1, #self.combo_interval do
		if self.combo_link > self.combo_interval[iter_57_1] then
			var_57_1 = var_57_1 + 1
		else
			break
		end
	end

	if arg_57_1 == 1 then
		self.score_number = self.score_number + self.score_good + var_57_1 * self.score_combo
		self.good_number = self.good_number + 1

		self:effect_play("good")
	elseif arg_57_1 == 2 then
		self.score_number = self.score_number + self.score_perfect + var_57_1 * self.score_combo
		self.perfect_number = self.perfect_number + 1

		self:effect_play("perfect")
	end

	if self.gameNoteLeft:loopTime() or self.gameNoteRight:loopTime() then
		self:effect_play("perfect_loop02", true)
	else
		self:effect_play("perfect_loop02", false)
	end

	local var_57_2 = self.yinyueComboeffect

	if self.game_dgree == 2 and self.combo_link > 50 or self.game_dgree == 1 and self.combo_link > 20 then
		if not isActive(var_57_2) then
			SetActive(var_57_2, true)
			setActive(self.game_content:Find("MusicStar"), true)
		end
	else
		SetActive(var_57_2, false)
		setActive(self.game_content:Find("MusicStar"), false)
	end

	return
end

function MusicGameView:count_five(arg_58_1)
	if self.countingfive_flag then
		return
	end

	self.countingfive_flag = true

	setActive(self.countTf, true)
	setActive(self.countContent, true)
	self:setActionSDmodel("stand2")

	local var_58_0 = var_0_5
	local var_58_1 = findTF(self.countTf, "img")
	local var_58_2 = findTF(self.countTf, "bg")

	local function var_58_3(arg_59_0)
		for iter_59_0 = 1, var_58_1.childCount do
			setActive(var_58_1:GetChild(iter_59_0 - 1), iter_59_0 == arg_59_0)
		end

		return
	end

	setActive(var_58_2, false)
	var_58_3(0)

	local var_58_4 = findTF(self.countTf, "ready")
	local var_58_5 = findTF(self.countTf, "effectContent")

	setActive(var_58_5, false)
	setActive(var_58_4, false)

	self.count_timer = Timer.New(function()
		if self.criInfo and self.criInfo:GetTime() > 0 then
			self:pauseBgm()
		end

		var_58_3(var_58_0)

		var_58_0 = var_58_0 - 1

		if var_58_0 < 0 then
			self.count_timer:Stop()
			setActive(var_58_2, false)
			var_58_3(0)
			setActive(var_58_4, true)
			setActive(var_58_5, true)
			LeanTween.value(go(self.countContent), 0, 2, 2):setOnUpdate(System.Action_float(function(arg_61_0)
				if arg_61_0 <= 0.25 then
					var_58_4.localScale = Vector3(arg_61_0 * 4, arg_61_0 * 4, arg_61_0 * 4)

					setImageAlpha(var_58_4, arg_61_0 * 4)
					setLocalScale(var_58_5, Vector3(arg_61_0 * 4, arg_61_0 * 4, arg_61_0 * 4))
				elseif arg_61_0 >= 1.8 then
					var_58_4.localScale = Vector3((2 - arg_61_0) * 4, (2 - arg_61_0) * 4, (2 - arg_61_0) * 4)

					setLocalScale(var_58_5, Vector3((2 - arg_61_0) * 4, (2 - arg_61_0) * 4, (2 - arg_61_0) * 4))
					setImageAlpha(var_58_4, (2 - arg_61_0) * 4)
				end

				return
			end)):setEase(LeanTweenType.linear):setOnComplete(System.Action(function()
				var_58_4.localScale = Vector3(1, 1, 1, 1)

				setLocalScale(var_58_5, Vector3(1, 1, 1, 1))
				setImageAlpha(var_58_4, 1)
				setActive(var_58_4, false)

				self.countingfive_flag = false

				setActive(self.countContent, false)
				setActive(self.countTf, false)
				self:setActionSDmodel("idol")
				arg_58_1()

				return
			end))
		else
			setActive(var_58_2, true)
		end

		return
	end, 1, -1)

	self.count_timer:Start()

	return
end

function MusicGameView:showSelevtView()
	if self.isFirstgame == 0 then
		self:Firstshow(self.firstview, function()
			return
		end, 1)
	end

	local var_63_0 = self.selectview:Find("Main")
	local var_63_1 = var_63_0:Find("DgreeList")
	local var_63_2 = var_63_0:Find("MusicList")
	local var_63_3 = var_63_0:Find("namelist")
	local var_63_4 = self.selectview:Find("top")
	local var_63_5 = var_63_4:Find("Speedlist")
	local var_63_6 = self.selectview:GetComponent("Animator")

	self.selectview:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_65_0)
		setActive(self.selectview, false)
		self:openCoinLayer(false)

		return
	end)
	onButton(self, var_63_4:Find("help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_music_game.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, var_63_4:Find("back"), function()
		if var_0_3 == 0 then
			self:emit(MusicGameView.ON_BACK)
		end

		return
	end, SFX_PANEL)
	onButton(self, var_63_0:Find("Start_btn"), function()
		if var_0_3 == 0 then
			var_63_6:Play("selectExitAnim")
			self:clearSDModel()
			self:updateMusic(self.selectIndex)
			self:game_start()

			GetOrAddComponent(self.selectview, "CanvasGroup").blocksRaycasts = false
		else
			self.startBtnReady = true
		end

		return
	end, SFX_UI_CONFIRM)
	onButton(self, var_63_1:Find("easy"), function()
		self.game_dgree = 1

		setActive(var_63_1:Find("hard/frame"), false)
		setActive(var_63_1:Find("easy/frame"), true)
		self:updatSelectview()

		return
	end, SFX_UI_CLICK)
	onButton(self, var_63_1:Find("hard"), function()
		self.game_dgree = 2

		setActive(var_63_1:Find("easy/frame"), false)
		setActive(var_63_1:Find("hard/frame"), true)
		self:updatSelectview()

		return
	end, SFX_UI_CLICK)
	onButton(self, var_63_5, function()
		setActive(var_63_5:Find("x" .. self.game_speed), false)

		self.game_speed = self.game_speed + 1 > 4 and 1 or self.game_speed + 1

		PlayerPrefs.SetInt("musicgame_idol_speed", self.game_speed)
		setActive(var_63_5:Find("x" .. self.game_speed), true)

		return
	end, SFX_UI_CLICK)

	self.song_btn = var_63_2:Find("song")

	setActive(self.song_btn, false)

	self.song_btns = {}

	local var_63_7 = self.gameMusicIndex

	for iter_63_0 = 1, self.music_amount do
		self.song_btns[iter_63_0] = cloneTplTo(self.song_btn, var_63_2, "music" .. iter_63_0)

		local var_63_8 = self.musicDatas[iter_63_0]

		setActive(self.song_btns[iter_63_0], true)

		local var_63_9 = iter_63_0 - var_63_7 < self.music_amount_middle and math.abs(iter_63_0 - var_63_7) or iter_63_0 - self.music_amount_middle * 2

		self.song_btns[iter_63_0].localPosition = Vector3(self.song_btn.localPosition.x + (iter_63_0 - var_63_7 < self.music_amount_middle and math.abs(iter_63_0 - var_63_7) or iter_63_0 - self.music_amount_middle * 2) * 1022, self.song_btn.localPosition.y, self.song_btn.localPosition.z)
		self.song_btns[iter_63_0].localScale = Vector3(self.song_btn.localScale.x - math.abs(var_63_9) * 0.2, self.song_btn.localScale.y - math.abs(var_63_9) * 0.2, self.song_btn.localScale.z - math.abs(var_63_9) * 0.2)

		local var_63_10 = self.song_btns[iter_63_0]:Find("song"):GetComponent(typeof(Image))

		var_63_10.sprite = var_63_2:Find("img/" .. var_63_8.picture):GetComponent(typeof(Image)).sprite
		self.song_btns[iter_63_0]:Find("zhuanji3/zhuanji2_5"):GetComponent(typeof(Image)).sprite = var_63_2:Find("img/" .. var_63_8.picture .. "_1"):GetComponent(typeof(Image)).sprite
		var_63_10.color = Color.New(1, 1, 1, 1 - math.abs(var_63_9) * 0.6)

		onButton(self, self.song_btns[iter_63_0], function()
			self:clickSongBtns(var_63_3, iter_63_0)

			return
		end, SFX_UI_CLICK)

		if iter_63_0 == var_63_7 then
			self.song_btns[iter_63_0]:GetComponent(typeof(Animator)):Play("plate_out")

			self.song_btns[iter_63_0]:GetComponent(typeof(Button)).interactable = false
		end
	end

	self:clickSongBtns(var_63_3, 1)

	return
end

function MusicGameView:updateMusic(arg_73_1)
	self.musicData = self.musicDatas[arg_73_1]
	self.selectIndex = arg_73_1
	self.game_music = self.musicData.id

	if self.musicData.ships and #self.musicData.ships > 0 then
		self.musicShips = self.musicData.ships
		self.settlementPainting = self.musicData.settlement_painting
		self.musicLight = self.musicData.light
		self.shadowLight = self.musicData.shadow == 1
		self.musicBg = self.musicData.bg
	else
		local var_73_0 = MusicGameConst.getRandomBand()

		self.musicShips = var_73_0.ships
		self.settlementPainting = var_73_0.settlement_painting
		self.musicLight = var_73_0.light
		self.shadowLight = true
		self.musicBg = var_73_0.bg
	end

	self.noteType = self.musicData.note_type
	self.gameMusicIndex = var_0_4
	self.SDname = self.musicShips
	self.score_blist = self.musicData.score_rank[1]
	self.score_alist = self.musicData.score_rank[2]
	self.score_slist = self.musicData.score_rank[3]
	self.score_sslist = self.musicData.score_rank[4]

	self:setTfChildVisible(self.top:Find("scoreContent/B/bl"), false)
	self:setTfChildVisible(self.top:Find("scoreContent/B/b"), false)
	self:setTfChildVisible(self.top:Find("scoreContent/A/al"), false)
	self:setTfChildVisible(self.top:Find("scoreContent/A/a"), false)
	self:setTfChildVisible(self.top:Find("scoreContent/S/sl"), false)
	self:setTfChildVisible(self.top:Find("scoreContent/S/s"), false)
	setActive(self.top:Find("scoreContent/B/b/" .. self.musicData.content_type), true)
	setActive(self.top:Find("scoreContent/B/bl/" .. self.musicData.content_type), true)
	setActive(self.top:Find("scoreContent/A/a/" .. self.musicData.content_type), true)
	setActive(self.top:Find("scoreContent/A/al/" .. self.musicData.content_type), true)
	setActive(self.top:Find("scoreContent/S/s/" .. self.musicData.content_type), true)
	setActive(self.top:Find("scoreContent/S/sl/" .. self.musicData.content_type), true)
	self:setTfChildVisible(self.game_content:Find("combo_n"), false)
	self:setTfChildVisible(self.game_content:Find("combo"), false)
	setActive(self.game_content:Find("combo_n/" .. self.musicData.content_type), true)
	setActive(self.game_content:Find("combo/" .. self.musicData.content_type), true)
	self:setTfChildVisible(self.btn_pause, false)
	setActive(findTF(self.btn_pause, self.musicData.content_type), true)
	self:setTfChildVisible(self.countContent, false)
	self:setTfChildVisible(self.top:Find("score"), false)
	setActive(self.top:Find("score/" .. tostring(self.musicData.content_type)), true)

	self.gameScoreTf = self.top:Find("score/" .. tostring(self.musicData.content_type) .. "/text")
	self.countTf = findTF(self.countContent, self.musicData.content_type)

	self:updateEffectTf()

	return
end

function MusicGameView:setTfChildVisible(arg_74_1, arg_74_2)
	for iter_74_0 = 1, arg_74_1.childCount do
		setActive(arg_74_1:GetChild(iter_74_0 - 1), false)
	end

	return
end

function MusicGameView:updateEffectTf()
	local var_75_0 = findTF(self.game_content, "effect")

	for iter_75_0 = 1, var_75_0.childCount do
		setActive(var_75_0:GetChild(iter_75_0 - 1), false)
	end

	setActive(findTF(self.game_content, "effect/" .. self.musicData.content_type))

	self.fullComboEffect = self.game_content:Find("effect/" .. self.musicData.content_type .. "/yinyue_Fullcombo")
	self.liveClearEffect = self.game_content:Find("effect/" .. self.musicData.content_type .. "/yinyue_LiveClear")
	self.yinyueGood = self.game_content:Find("effect/" .. self.musicData.content_type .. "/yinyue_good")
	self.yinyueComboeffect = self.game_content:Find("effect/" .. self.musicData.content_type .. "/yinyue_comboeffect")
	self.yinyuePerfect = self.game_content:Find("effect/" .. self.musicData.content_type .. "/yinyue_perfect")
	self.yinyuePefectLoop = self.game_content:Find("effect/" .. self.musicData.content_type .. "/yinyue_perfect_loop02")

	return
end

function MusicGameView:getBeatGameMusicData(arg_76_1)
	for iter_76_0 = 1, #self.musicDatas do
		if self.musicDatas[iter_76_0].id == arg_76_1 then
			return self.musicDatas[iter_76_0]
		end
	end

	return nil
end

function MusicGameView:clickSongBtns(arg_77_1, arg_77_2)
	if var_0_3 > 0 then
		return
	end

	setActive(arg_77_1:Find("song" .. self.musicData.picture), false)
	self:MyGetRuntimeData()
	self:clearSDModel()
	self:updateMusic(arg_77_2)
	self:loadAndPlayMusic()
	self:updatSelectview()
	self:changeLocalpos(arg_77_2)
	setActive(arg_77_1:Find("song" .. self.musicData.picture), true)

	return
end

function MusicGameView:changeLocalpos(arg_78_1)
	local var_78_0 = self.music_amount_middle
	local var_78_1 = self.music_amount_middle - arg_78_1
	local var_78_2 = 0.5
	local var_78_3 = {}

	for iter_78_0 = 1, self.music_amount do
		var_78_3[iter_78_0] = self.song_btns[iter_78_0].localPosition
	end

	local var_78_4 = {}

	for iter_78_1 = 1, self.music_amount do
		var_78_4[iter_78_1] = self.song_btns[iter_78_1].localScale
	end

	self.changeLocalpos_timer = Timer.New(function()
		var_78_2 = var_78_2 - self.time_interval
		self.changeLocalposTimerflag = true

		for iter_79_0 = 1, self.music_amount do
			local var_79_0 = iter_79_0 + var_78_1

			if iter_79_0 + var_78_1 > self.music_amount then
				var_79_0 = iter_79_0 + var_78_1 - self.music_amount
			end

			if iter_79_0 + var_78_1 < 1 then
				var_79_0 = iter_79_0 + var_78_1 + self.music_amount
			end

			if var_78_2 <= 0 then
				if var_79_0 == var_78_0 then
					self.song_btns[iter_79_0]:GetComponent(typeof(Animator)):Play("plate_out")
				else
					self.song_btns[iter_79_0]:GetComponent(typeof(Animator)):Play("plate_static")

					self.song_btns[iter_79_0]:GetComponent(typeof(Button)).interactable = true
				end
			end

			local var_79_1

			do
				self.song_btns[iter_79_0]:GetComponent(typeof(Animator)):Play("plate_static")

				self.song_btns[iter_79_0]:GetComponent(typeof(Button)).interactable = false
				var_79_1 = math.abs(var_79_0 - var_78_0)
			end

			self.song_btns[iter_79_0].localPosition = Vector3((self.song_btn.localPosition.x + (var_79_0 - var_78_0 > 0 and 1 or -1) * var_79_1 * 1022) * (1 - var_78_2 * 2) + var_78_3[iter_79_0].x * var_78_2 * 2, self.song_btn.localPosition.y, self.song_btn.localPosition.z)
			self.song_btns[iter_79_0].localScale = Vector3((1 - var_79_1 * 0.2) * (1 - var_78_2 * 2) + var_78_4[iter_79_0].x * var_78_2 * 2, (1 - var_79_1 * 0.2) * (1 - var_78_2 * 2) + var_78_4[iter_79_0].x * var_78_2 * 2, (1 - var_79_1 * 0.2) * (1 - var_78_2 * 2) + var_78_4[iter_79_0].x * var_78_2 * 2)
			self.song_btns[iter_79_0]:Find("song"):GetComponent(typeof(Image)).color = Color.New(1, 1, 1, 1 - var_79_1 * 0.6)
		end

		if var_78_2 <= 0 then
			self.changeLocalposTimerflag = false

			self.changeLocalpos_timer:Stop()
		end

		return
	end, self.time_interval, -1)

	self.changeLocalpos_timer:Start()

	return
end

function MusicGameView:addRingDragListenter()
	local var_80_0 = GetOrAddComponent(self.selectview, "EventTriggerListener")
	local var_80_1
	local var_80_2 = 0

	var_80_0:AddBeginDragFunc(function()
		var_80_2 = 0
		var_80_1 = nil

		return
	end)
	var_80_0:AddDragFunc(function(arg_82_0, arg_82_1)
		if not self.inPaintingView then
			var_80_1 = var_80_1 or arg_82_1.position
			var_80_2 = arg_82_1.position.x - var_80_1.x
		end

		return
	end)
	var_80_0:AddDragEndFunc(function(arg_83_0, arg_83_1)
		if not self.inPaintingView and not self.changeLocalposTimerflag then
			local var_83_0, var_83_1 = self:getNextPreSelectId()

			if var_80_2 < -50 then
				triggerButton(self.song_btns[var_83_0])
			elseif var_80_2 > 50 then
				triggerButton(self.song_btns[var_83_1])
			end
		end

		return
	end)

	return
end

function MusicGameView:getNextPreSelectId()
	local var_84_0
	local var_84_1
	local var_84_2 = self.game_music + 1
	local var_84_3 = self.game_music - 1

	if self.game_music - 1 <= 0 then
		var_84_3 = #self.musicDatas
	end

	if var_84_2 > #self.musicDatas then
		var_84_2 = 1
	end

	for iter_84_0, iter_84_1 in ipairs(self.musicDatas) do
		if self.musicDatas[iter_84_0].id == var_84_2 then
			var_84_0 = iter_84_0
		end

		if self.musicDatas[iter_84_0].id == var_84_3 then
			var_84_1 = iter_84_0
		end
	end

	return var_84_0, var_84_1
end

function MusicGameView:Firstshow(arg_85_1, arg_85_2, arg_85_3)
	self.count = 0

	setActive(arg_85_1, true)
	LoadSpriteAtlasAsync("ui/minigameui/musicgameother_atlas", "help1", function(arg_86_0)
		GetComponent(findTF(self.firstview, "num/img1"), typeof(Image)).sprite = arg_86_0

		return
	end)
	LoadSpriteAtlasAsync("ui/minigameui/musicgameother_atlas", "help2", function(arg_87_0)
		GetComponent(findTF(self.firstview, "num/img2"), typeof(Image)).sprite = arg_87_0

		return
	end)

	for iter_85_0 = 1, 2 do
		setActive(findTF(arg_85_1, "num/img" .. iter_85_0), iter_85_0 == arg_85_3 and true or false)
	end

	if self.firstview_timer then
		if self.firstview_timer.running then
			self.firstview_timer:Stop()
		end

		self.firstview_timer = nil
	end

	self.firstview_timerRunflag = true
	self.firstview_timer = Timer.New(function()
		self.count = self.count + 1

		if self.count > 3 then
			onButton(self, self.firstview, function()
				if arg_85_2 then
					arg_85_2()
				end

				self.firstview_timer:Stop()
				setActive(arg_85_1, false)

				self.firstview_timerRunflag = false

				removeOnButton(self.firstview)

				return
			end)
		end

		return
	end, 1, -1)

	self.firstview_timer:Start()

	return
end

function MusicGameView:updatSelectview()
	if not self.song_btns or #self.song_btns <= 0 or not self.selectview then
		return
	end

	setActive(self.selectview:Find("top/Speedlist/x" .. self.game_speed), true)

	for iter_90_0 = 1, self.music_amount do
		setActive(self.song_btns[self.musicDatas[iter_90_0].id]:Find("song/best"), false)
		self:setSelectview_pj("e", self.musicDatas[iter_90_0].id)
	end

	if self.song_btns[self.game_music] and self.bestScorelist[self.game_music + (self.game_dgree - 1) * self.music_amount] > 0 then
		setActive(self.song_btns[self.game_music]:Find("song/best"), true)
		setText(self.song_btns[self.game_music]:Find("song/best/score"), self.bestScorelist[self.game_music + (self.game_dgree - 1) * self.music_amount])
		self:setSelectview_pj("e", self.game_music)

		if self.bestScorelist[self.game_music + (self.game_dgree - 1) * self.music_amount] < self.score_blist[self.game_dgree] then
			self:setSelectview_pj("c", self.game_music)
		elseif self.bestScorelist[self.game_music + (self.game_dgree - 1) * self.music_amount] >= self.score_blist[self.game_dgree] and self.bestScorelist[self.game_music + (self.game_dgree - 1) * self.music_amount] < self.score_alist[self.game_dgree] then
			self:setSelectview_pj("b", self.game_music)
		elseif self.bestScorelist[self.game_music + (self.game_dgree - 1) * self.music_amount] >= self.score_alist[self.game_dgree] and self.bestScorelist[self.game_music + (self.game_dgree - 1) * self.music_amount] < self.score_slist[self.game_dgree] then
			self:setSelectview_pj("a", self.game_music)
		else
			self:setSelectview_pj("s", self.game_music)
		end
	end

	return
end

function MusicGameView:setSelectview_pj(arg_91_1, arg_91_2)
	if arg_91_1 == "e" then
		setActive(self.song_btns[arg_91_2]:Find("song/c"), false)
		setActive(self.song_btns[arg_91_2]:Find("song/b"), false)
		setActive(self.song_btns[arg_91_2]:Find("song/a"), false)
		setActive(self.song_btns[arg_91_2]:Find("song/s"), false)
	elseif arg_91_1 == "c" then
		setActive(self.song_btns[arg_91_2]:Find("song/c"), true)
	elseif arg_91_1 == "b" then
		setActive(self.song_btns[arg_91_2]:Find("song/b"), true)
	elseif arg_91_1 == "a" then
		setActive(self.song_btns[arg_91_2]:Find("song/a"), true)
	elseif arg_91_1 == "s" then
		setActive(self.song_btns[arg_91_2]:Find("song/s"), true)
	end

	return
end

function MusicGameView:updateScoreUIContent()
	local var_92_0 = findTF(self.scoreview, "ui")

	for iter_92_0 = 1, var_92_0.childCount do
		setActive(var_92_0:GetChild(iter_92_0 - 1), false)
	end

	self.scoreUIContent = self.musicData.settlement_type and self.musicData.settlement_type ~= "" and findTF(self.scoreview, "ui/" .. self.musicData.settlement_type) or findTF(self.scoreview, "ui/normal")

	setActive(self.scoreUIContent, true)

	return
end

function MusicGameView:locadScoreView()
	self:updateScoreUIContent()
	self:effect_play("nothing")

	self.game_playingflag = false

	setActive(self.scoreview, true)

	self.scoreview_flag = true

	local var_93_0 = findTF(self.scoreview, "bg")

	setImageColor(var_93_0, Color(0, 0, 0))
	LoadSpriteAtlasAsync("ui/minigameui/musicgameother_atlas", "scoreBg" .. self.musicBg, function(arg_94_0)
		if var_93_0 then
			GetComponent(var_93_0, typeof(Image)).sprite = arg_94_0

			setImageColor(var_93_0, Color(1, 1, 1))
			setActive(var_93_0, true)
		end

		return
	end)
	setActive(self.game_content:Find("combo"), false)
	setActive(self.game_content:Find("MusicStar"), false)
	setActive(self.game_content:Find("combo_n"), false)
	setActive(self.game_content, false)
	setActive(self.top, false)
	setActive(self._tf:Find("Spinelist"), false)

	for iter_93_0 = 1, self.scoreview:Find("maskBg").childCount do
		setActive(self.scoreview:Find("maskBg/bg" .. iter_93_0), iter_93_0 == self.musicBg)
	end

	for iter_93_1 = 1, self.scoreview:Find("maskBgBottom").childCount do
		setActive(self.scoreview:Find("maskBgBottom/bg" .. iter_93_1), iter_93_1 == self.musicBg)
	end

	local var_93_1 = self.game_dgree
	local var_93_2 = self.game_music

	if self.painting then
		retPaintingPrefab(self.scoreview:Find("paint"), self.painting)
	end

	local var_93_3 = {}

	for iter_93_2 = 1, #self.settlementPainting do
		if self.settlementPainting[iter_93_2] and self.settlementPainting[iter_93_2] ~= "" and self.settlementPainting[iter_93_2] ~= "none" then
			table.insert(var_93_3, self.settlementPainting[iter_93_2])
		end
	end

	self.painting = var_93_3[math.random(1, #var_93_3)]

	local var_93_4 = MusicGameConst.painting_const_key[string.lower(self.painting)]

	if var_93_4 then
		local var_93_5 = {}

		PaintingGroupConst.AddPaintingNameWithFilteMap(var_93_5, var_93_4)
		PaintingGroupConst.PaintingDownload({
			isShowBox = false,
			paintingNameList = var_93_5,
			finishFunc = function()
				setPaintingPrefabAsync(self.scoreview:Find("paint"), self.painting, "mainNormal")

				return
			end
		})
	else
		setPaintingPrefabAsync(self.scoreview:Find("paint"), self.painting, "mainNormal")
	end

	setActive(self.scoreUIContent:Find("scoreImg/square/easy"), var_93_1 == 1)
	setActive(self.scoreUIContent:Find("scoreImg/square/hard"), var_93_1 == 2)
	setActive(self.scoreUIContent:Find("scoreList/fullCombo"), self.miss_number == 0)
	setActive(self.scoreUIContent:Find("scoreImg/perfect/noMiss"), self.miss_number == 0 and self.good_number == 0)

	local function var_93_6(arg_96_0, arg_96_1, arg_96_2)
		LeanTween.value(go(self.scoreview), 0, arg_96_1, 0.6):setOnUpdate(System.Action_float(function(arg_97_0)
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
			var_93_6(self.scoreUIContent:Find("scoreList/perfect"), self.perfect_number, arg_99_0)

			return
		end,
		function(arg_100_0)
			var_93_6(self.scoreUIContent:Find("scoreList/good"), self.good_number, arg_100_0)

			return
		end,
		function(arg_101_0)
			var_93_6(self.scoreUIContent:Find("scoreList/miss"), self.miss_number, arg_101_0)

			return
		end,
		function(arg_102_0)
			var_93_6(self.scoreUIContent:Find("scoreList/combo"), self.combo_number, arg_102_0)

			return
		end,
		function(arg_103_0)
			local var_103_0 = self.bestScorelist[var_93_2 + (var_93_1 - 1) * self.music_amount]

			if not self.bestScorelist[var_93_2 + (var_93_1 - 1) * self.music_amount] or var_103_0 == 0 then
				var_103_0 = self.score_number
			end

			if self.score_number > self.bestScorelist[var_93_2 + (var_93_1 - 1) * self.music_amount] then
				setActive(self.scoreUIContent:Find("scoreImg/square/newScore"), true)

				self.bestScorelist[var_93_2 + (var_93_1 - 1) * self.music_amount] = self.score_number
			else
				setActive(self.scoreUIContent:Find("scoreImg/square/newScore"), false)
			end

			var_93_6(self.scoreUIContent:Find("scoreImg/square/bestscore"), var_103_0, arg_103_0)
			var_93_6(self.scoreUIContent:Find("scoreImg/square/score"), self.score_number, function()
				return
			end)
			self:MyStoreDataToServer()
			self:MyGetRuntimeData()

			return
		end,
		function(arg_105_0)
			local var_105_0 = self.score_number < self.score_blist[var_93_1] and function()
				self:setScoceview_pj("c")

				return
			end or self.score_number >= self.score_blist[var_93_1] and self.score_number < self.score_alist[var_93_1] and function()
				self:setScoceview_pj("b")
				self:emit(BaseMiniGameMediator.MINI_GAME_SUCCESS, 0)

				return
			end or self.score_number >= self.score_alist[var_93_1] and self.score_number < self.score_slist[var_93_1] and function()
				self:setScoceview_pj("a")
				self:emit(BaseMiniGameMediator.MINI_GAME_SUCCESS, 0)

				return
			end or function()
				self:setScoceview_pj("s")
				self:emit(BaseMiniGameMediator.MINI_GAME_SUCCESS, 0)

				return
			end
			local var_105_1 = self:GetMGHubData()
			local var_105_2 = pg.NewStoryMgr.GetInstance()
			local var_105_3 = self:GetMGData():getConfig("simple_config_data").story

			if var_105_3[var_105_1.usedtime + 1] then
				local var_105_4 = var_105_3[var_105_1.usedtime + 1][1] or nil

				if var_105_1.count > 0 and var_105_4 and not var_105_2:IsPlayed(var_105_4) and self.score_number >= self.score_blist[var_93_1] then
					var_105_2:Play(var_105_4, var_105_0)

					goto label_105_0
				end
			end

			var_105_0()

			::label_105_0::

			arg_105_0()

			return
		end
	}, function()
		return
	end)
	setText(self.scoreUIContent:Find("scoreImg/square/nameText"), self.musicData.music_name)

	local var_93_7 = self.scoreUIContent:Find("scoreImg/square/name"):GetComponent(typeof(Image))

	var_93_7.sprite = self.selectview:Find("Main/namelist/song" .. self.musicData.picture):GetComponent(typeof(Image)).sprite

	var_93_7:SetNativeSize()

	self.scoreUIContent:Find("scoreImg/square/song"):GetComponent(typeof(Image)).sprite = self.selectview:Find("Main/MusicList/img/" .. self.musicData.picture):GetComponent(typeof(Image)).sprite

	GetComponent(self.scoreUIContent:Find("btnList/share"), typeof(Image)):SetNativeSize()
	onButton(self, self.scoreUIContent:Find("btnList/share"), function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeSummary)

		return
	end, SFX_PANEL)
	GetComponent(self.scoreUIContent:Find("btnList/restart"), typeof(Image)):SetNativeSize()
	onButton(self, self.scoreUIContent:Find("btnList/restart"), function()
		setActive(self.scoreview, false)

		self.scoreview_flag = false

		self:stopTimer()
		self:rec_scorce()
		self:game_start()
		self:setScoceview_pj("e")

		if self.painting then
			retPaintingPrefab(self.scoreview:Find("paint"), self.painting)

			self.painting = nil
		end

		return
	end, SFX_UI_CLICK)
	GetComponent(self.scoreUIContent:Find("btnList/reselect"), typeof(Image)):SetNativeSize()
	onButton(self, self.scoreUIContent:Find("btnList/reselect"), function()
		self:dynamicBgHandler(self.bgGo)
		setActive(self.scoreview, false)

		self.scoreview_flag = false

		self:stopTimer()
		setActive(self.selectview, true)
		self:openCoinLayer(true)

		GetOrAddComponent(self.selectview, "CanvasGroup").blocksRaycasts = true

		self:updatSelectview()
		self.song_btns[self.game_music]:GetComponent(typeof(Animator)):Play("plate_out")
		self:loadAndPlayMusic()
		self:rec_scorce()
		self:setScoceview_pj("e")

		if self.painting then
			retPaintingPrefab(self.scoreview:Find("paint"), self.painting)

			self.painting = nil
		end

		return
	end, SFX_UI_CLICK)

	return
end

function MusicGameView:setScoceview_pj(arg_114_1)
	setActive(self.scoreUIContent:Find("scoreImg/square/c"), false)
	setActive(self.scoreUIContent:Find("scoreImg/square/b"), false)
	setActive(self.scoreUIContent:Find("scoreImg/square/a"), false)
	setActive(self.scoreUIContent:Find("scoreImg/square/s"), false)

	if arg_114_1 == "e" then
		-- block empty
	elseif arg_114_1 == "c" then
		setActive(self.scoreUIContent:Find("scoreImg/square/c"), true)
	elseif arg_114_1 == "b" then
		setActive(self.scoreUIContent:Find("scoreImg/square/b"), true)
	elseif arg_114_1 == "a" then
		setActive(self.scoreUIContent:Find("scoreImg/square/a"), true)
	elseif arg_114_1 == "s" then
		setActive(self.scoreUIContent:Find("scoreImg/square/s"), true)
	end

	return
end

function MusicGameView:Scoceview_ani()
	local var_115_0 = 0

	setActive(self.scoreUIContent:Find("btnList/reselect"), false)
	setActive(self.scoreUIContent:Find("btnList/restart"), false)
	setActive(self.scoreUIContent:Find("btnList/share"), false)

	self.Scoceview_timer = Timer.New(function()
		var_115_0 = var_115_0 + self.time_interval

		if var_115_0 >= 0.99 then
			setActive(self.scoreUIContent:Find("btnList/reselect"), true)
			setActive(self.scoreUIContent:Find("btnList/restart"), true)
			setActive(self.scoreUIContent:Find("btnList/share"), true)
			setText(self.scoreUIContent:Find("scoreList/perfect"), self.perfect_number)
			setText(self.scoreUIContent:Find("scoreList/good"), self.good_number)
			setText(self.scoreUIContent:Find("scoreList/miss"), self.miss_number)
			setText(self.scoreUIContent:Find("scoreList/combo"), self.combo_number)
			setText(self.scoreUIContent:Find("scoreImg/square/bestscore"), self.score_number)
		else
			setText(self.scoreUIContent:Find("scoreList/perfect"), math.floor(self.perfect_number * var_115_0))
			setText(self.scoreUIContent:Find("scoreList/good"), math.floor(self.good_number * var_115_0))
			setText(self.scoreUIContent:Find("scoreList/miss"), math.floor(self.miss_number * var_115_0))
			setText(self.scoreUIContent:Find("scoreList/combo"), math.floor(self.combo_number * var_115_0))
			setText(self.scoreUIContent:Find("scoreImg/square/bestscore"), math.floor(self.score_number * var_115_0))
		end

		if var_115_0 >= 1.03 then
			self.Scoceview_timer:Stop()
		end

		return
	end, self.time_interval, -1)

	self.Scoceview_timer:Start()

	return
end

function MusicGameView:gameStart()
	self.timer = self.timer or Timer.New(function()
		self:gameStepNew()

		return
	end, self.time_interval, -1)
	self.aheadtime_count = 0

	local var_117_0 = 2

	self.ahead_timerPauseFlag = false

	CriWareMgr.Inst:UnloadCueSheet(self:getMusicBgm(self.musicData))

	self.ahead_timer = Timer.New(function()
		self.ahead_timeflag = true

		if not self.timer.running then
			self:startTimer()
		end

		if not self.ahead_timerPauseFlag then
			self.aheadtime_count = self.aheadtime_count + self.time_interval

			if self.aheadtime_count > var_117_0 then
				self.aheadtime_count = nil
				self.ahead_timeflag = false
				self.gotspecialcombo_flag = false

				self.ahead_timer:Stop()
				self:loadAndPlayMusic(function()
					return
				end)
			end
		end

		return
	end, self.time_interval, -1)

	self:count_five(function()
		self.ahead_timer:Start()

		return
	end)

	return
end

function MusicGameView:getMusicBgm(arg_122_1)
	local var_122_0 = "bgm-song"

	var_122_0 = arg_122_1.bgm < 10 and var_122_0 .. "0" .. tostring(arg_122_1.bgm) or var_122_0 .. tostring(arg_122_1.bgm)

	return var_122_0
end

function MusicGameView:getMusicNote(arg_123_1, arg_123_2)
	return "view/miniGame/gameView/musicGame/bgm_song" .. "0" .. arg_123_1.note .. "_" .. arg_123_2
end

function MusicGameView:gameStepNew()
	self.gameStepTime = self:getStampTime()
	self.downingright_lastflag = self.downingright_flag
	self.downingleft_lastflag = self.downingleft_flag

	if IsUnityEditor then
		if self.game_dgree == 2 then
			self.downingright_flag = Input.GetKey(KeyCode.J)
			self.downingleft_flag = Input.GetKey(KeyCode.F)
		elseif self.game_dgree == 1 then
			if Input.GetKey(KeyCode.J) or Input.GetKey(KeyCode.F) then
				self.downingright_flag = true
				self.downingleft_flag = true
			else
				self.downingright_flag = false
				self.downingleft_flag = false
			end
		end
	elseif self.game_dgree == 2 then
		self.downingright_flag = self.mousedowningright_flag
		self.downingleft_flag = self.mousedowningleft_flag
	elseif self.game_dgree == 1 then
		if self.mousedowningright_flag or self.mousedowningleft_flag then
			self.downingright_flag = true
			self.downingleft_flag = true
		else
			self.downingright_flag = false
			self.downingleft_flag = false
		end
	end

	if self.game_dgree == 2 then
		if not self.downingleft_lastflag and self.downingleft_flag then
			self.gameNoteLeft:onKeyDown()

			self.leftDownStepTime = self.gameStepTime

			if self.rightDownStepTime and math.abs(self.leftDownStepTime - self.rightDownStepTime) < 100 then
				self.gameNoteLeft:bothDown()
				self.gameNoteRight:bothDown()
			end
		elseif self.downingleft_lastflag and not self.downingleft_flag then
			self.leftUpStepTime = self.gameStepTime

			self.gameNoteLeft:onKeyUp()

			if self.rightUpStepTime and math.abs(self.leftUpStepTime - self.rightUpStepTime) < 100 then
				self.gameNoteLeft:bothUp()
				self.gameNoteRight:bothUp()
			end
		end

		if not self.downingright_lastflag and self.downingright_flag then
			self.gameNoteRight:onKeyDown()

			self.rightDownStepTime = self.gameStepTime

			if self.leftDownStepTime and math.abs(self.leftDownStepTime - self.rightDownStepTime) < 200 then
				self.gameNoteLeft:bothDown()
				self.gameNoteRight:bothDown()
			end
		elseif self.downingright_lastflag and not self.downingright_flag then
			self.rightUpStepTime = self.gameStepTime

			self.gameNoteRight:onKeyUp()

			if self.leftUpStepTime and math.abs(self.leftUpStepTime - self.rightUpStepTime) < 200 then
				self.gameNoteLeft:bothUp()
				self.gameNoteRight:bothUp()
			end
		end
	elseif not self.downingright_lastflag and self.downingright_flag then
		self.gameNoteLeft:onKeyDown()
		self.gameNoteRight:onKeyDown()
	elseif self.downingleft_lastflag and not self.downingleft_flag then
		self.gameNoteLeft:onKeyUp()
		self.gameNoteRight:onKeyUp()
	end

	self.musicgame_lasttime = self.musicgame_nowtime or 0
	self.musicgame_nowtime = self.criInfo and self:getStampTime() / 1000 or 0

	if self.song_Tlength and not self.scoreview_flag and long2int(self.song_Tlength) / 1000 - self.musicgame_nowtime <= 0.01666 then
		print("歌曲播放结束")
		self:pauseBgm()

		self.game_playingflag = false

		local function var_124_0()
			self:locadScoreView()

			return
		end

		if self.perfect_number > 0 and self.good_number == 0 and self.miss_number == 0 then
			setActive(self.fullComboEffect, true)

			if not self.gotspecialcombo_flag then
				self.score_number = self.score_number + self.specialscore_number
				self.gotspecialcombo_flag = true
			end

			LeanTween.delayedCall(go(self.fullComboEffect), 2, System.Action(function()
				var_124_0()

				return
			end))
		elseif (self.good_number > 0 or self.perfect_number > 0) and self.miss_number <= 0 then
			setActive(self.fullComboEffect, true)

			if not self.gotspecialcombo_flag then
				self.score_number = self.score_number + self.specialscore_number
				self.gotspecialcombo_flag = true
			end

			LeanTween.delayedCall(go(self.fullComboEffect), 2, System.Action(function()
				var_124_0()

				return
			end))
		else
			setActive(self.liveClearEffect, true)
			LeanTween.delayedCall(go(self.liveClearEffect), 2, System.Action(function()
				var_124_0()

				return
			end))
		end

		return
	end

	self.gameNoteLeft:step(self.gameStepTime)
	self.gameNoteRight:step(self.gameStepTime)
	self:scoresliderAcombo_update()

	if self.drumpFlag and not self.gameNoteLeft:loopTime() and not self.gameNoteRight:loopTime() then
		self.drumpFlag = false
		self.drupTime = Time.realtimeSinceStartup

		self:setActionSDmodel("jump")
		LeanTween.delayedCall(go(self.game_content), 1, System.Action(function()
			self:setActionSDmodel("idol")

			return
		end))
	end

	return
end

function MusicGameView:onStateCallback(arg_130_1)
	self:score_update(arg_130_1)

	return
end

function MusicGameView:onLongTimeCallback(arg_131_1)
	if self.drupTime and Time.realtimeSinceStartup - self.drupTime < 2 then
		return
	end

	if arg_131_1 > 0.5 then
		self.drumpFlag = true
	end

	return
end

return MusicGameView

local var_0_0 = class("MusicCollectionView", import("..base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "MusicCollectionUI"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()
	arg_2_0:initPlateListPanel()
	arg_2_0:Show()
	arg_2_0:recoverRunData()
	arg_2_0:tryShowTipMsgBox()

	return
end

function var_0_0.OnDestroy(arg_3_0)
	arg_3_0.bgmMgr:UnregisterMusicCallback(arg_3_0.__cname)
	arg_3_0.resLoader:Clear()
	arg_3_0:closeAlbumListPanel(true)

	return
end

function var_0_0.onBackPressed(arg_4_0)
	if isActive(arg_4_0.albumListPanel) then
		arg_4_0:closeAlbumListPanel()

		return false
	else
		return true
	end

	return
end

function var_0_0.initData(arg_5_0)
	arg_5_0.bgmMgr = pg.BgmMgr.GetInstance()
	arg_5_0.appreciateProxy = getProxy(AppreciateProxy)
	arg_5_0.albumNames = underscore.to_array(pg.music_album.all)

	table.sort(arg_5_0.albumNames, CompareFuncs({
		function(arg_6_0)
			return -pg.music_album[arg_6_0].order
		end
	}))

	arg_5_0.albumNames = underscore.map(arg_5_0.albumNames, function(arg_7_0)
		return pg.music_album[arg_7_0].album_name
	end)
	arg_5_0.plateTFList = {}
	arg_5_0.albumTFList = {}
	arg_5_0.likeDic = {}
	arg_5_0.likeIds = {}
	arg_5_0.curMidddleIndex = 1
	arg_5_0.isPlayingAni = false
	arg_5_0.resLoader = AutoLoader.New()

	return
end

function var_0_0.saveRunData(arg_8_0)
	arg_8_0.appreciateProxy:updateMusicRunData(arg_8_0.sortValue, arg_8_0.curMidddleIndex, arg_8_0.likeValue)

	return
end

function var_0_0.recoverRunData(arg_9_0)
	local var_9_0 = arg_9_0.appreciateProxy:getMusicRunData()

	arg_9_0.sortValue = var_9_0.sortValue
	arg_9_0.curMidddleIndex = var_9_0.middleIndex
	arg_9_0.likeValue = var_9_0.likeValue
	arg_9_0.albumSortValue = "asc"
	arg_9_0.likeIds = arg_9_0.appreciateProxy:getAlbumMusicList("favor")

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.likeIds) do
		arg_9_0.likeDic[iter_9_1] = true
	end

	arg_9_0.lScrollPageSC.MiddleIndexOnInit = arg_9_0.curMidddleIndex - 1

	arg_9_0:updatePlateListPanel()

	if getProxy(AppreciateProxy):CanPlayMainMusicPlayer() then
		arg_9_0:NewMusicPlayer(arg_9_0.appreciateProxy:getMainPlayerAlbumName())
	else
		arg_9_0:NewMusicPlayer(arg_9_0.tempPlateList[arg_9_0.curMidddleIndex])
	end

	arg_9_0.bgmMgr:RegisterMusicCallback(arg_9_0.__cname, "TempMusicPlayer", {
		startCall = function(arg_10_0)
			if arg_9_0.plateTFList[arg_9_0.curMidddleIndex] then
				arg_9_0:updatePlateList(arg_9_0.plateTFList[arg_9_0.curMidddleIndex], arg_9_0.curMidddleIndex)
			end

			arg_9_0:updateAlbumListPanel()
			arg_9_0:updatePlayPanel(arg_10_0)

			return
		end,
		progressCall = function(arg_11_0)
			if arg_9_0.onDrag then
				return
			end

			arg_9_0:updatePlayProgress(arg_11_0)

			return
		end,
		noPlayCall = function()
			arg_9_0:NewMusicPlayer(arg_9_0.tempPlateList[arg_9_0.curMidddleIndex])

			return
		end
	})
	arg_9_0:updateAlbumListPanel()
	arg_9_0:updateLikeToggle()
	arg_9_0:updatePlayType()

	return
end

function var_0_0.findUI(arg_13_0)
	setLocalPosition(arg_13_0._tf, Vector2.zero)

	arg_13_0._tf.anchorMin = Vector2.zero
	arg_13_0._tf.anchorMax = Vector2.one
	arg_13_0._tf.offsetMax = Vector2.zero
	arg_13_0._tf.offsetMin = Vector2.zero
	arg_13_0.topPanel = arg_13_0._tf:Find("TopPanel")
	arg_13_0.likeFilteToggle = arg_13_0.topPanel:Find("LikeBtn")

	setActive(arg_13_0.likeFilteToggle, true)

	arg_13_0.serchInputText = arg_13_0.topPanel:Find("serch")

	setText(arg_13_0.serchInputText:Find("Placeholder"), i18n("NewMusic_2"))

	arg_13_0.plateListPanel = arg_13_0._tf:Find("PlateList")
	arg_13_0.plateTpl = arg_13_0.plateListPanel:Find("Plate")

	setActive(arg_13_0.plateTpl, false)
	setText(arg_13_0.plateTpl:Find("list/panel/view/empty/icon/Text"), i18n("NewMusic_3"))

	arg_13_0.lScrollPageSC = GetComponent(arg_13_0.plateListPanel, "LScrollPage")
	arg_13_0.playPanel = arg_13_0._tf:Find("PLayPanel")
	arg_13_0.playPanelNameText = arg_13_0.playPanel:Find("NameText")
	arg_13_0.likeToggle = arg_13_0.playPanel:Find("LikeBtn")
	arg_13_0.likeOnImg = arg_13_0.likeToggle:Find("On")
	arg_13_0.songImg = arg_13_0.playPanel:Find("SongImg/face")
	arg_13_0.pauseBtn = arg_13_0.playPanel:Find("PlayingBtn")
	arg_13_0.playBtn = arg_13_0.playPanel:Find("StopingBtn")
	arg_13_0.playDesc = arg_13_0.playPanel:Find("PlayDesc")
	arg_13_0.nextBtn = arg_13_0.playPanel:Find("NextBtn")
	arg_13_0.preBtn = arg_13_0.playPanel:Find("PreBtn")
	arg_13_0.playProgressBar = arg_13_0.playPanel:Find("Progress")
	arg_13_0.nowTimeText = arg_13_0.playProgressBar:Find("NowTimeText")
	arg_13_0.totalTimeText = arg_13_0.playProgressBar:Find("TotalTimeText")
	arg_13_0.playSliderSC = GetComponent(arg_13_0.playProgressBar, "LSlider")
	arg_13_0.listBtn = arg_13_0.playPanel:Find("ListBtn")

	setActive(arg_13_0.listBtn:Find("on"), false)
	setActive(arg_13_0.listBtn:Find("off"), true)

	arg_13_0.albumListPanel = arg_13_0._tf:Find("AlbumListPanel")
	arg_13_0.closeBtn = arg_13_0.albumListPanel:Find("BG")
	arg_13_0.panel = arg_13_0.albumListPanel:Find("Panel")

	setText(arg_13_0.panel:Find("top/name"), i18n("NewMusic_6"))

	arg_13_0.albumToggle = arg_13_0.panel:Find("bottom/sort_btn")
	arg_13_0.albumInputText = arg_13_0.panel:Find("bottom/serch")

	setText(arg_13_0.albumInputText:Find("Placeholder"), i18n("NewMusic_2"))

	arg_13_0.albumContainer = arg_13_0.panel:Find("middle/Content")
	arg_13_0.albumItemList = UIItemList.New(arg_13_0.albumContainer, arg_13_0.albumContainer:GetChild(0))

	arg_13_0.albumItemList:make(function(arg_14_0, arg_14_1, arg_14_2)
		arg_14_1 = arg_14_1 + 1

		if arg_14_0 == UIItemList.EventUpdate then
			arg_13_0.albumTFList[arg_14_1] = arg_14_2

			arg_13_0:updateAlbumTF(arg_14_2, arg_14_1)
		end

		return
	end)

	arg_13_0.likeFilteOnImg = arg_13_0.likeFilteToggle:Find("TextLike/On")
	arg_13_0.playLoopBtn = arg_13_0.playPanel:Find("PlayTypeBtn")

	return
end

function var_0_0.addListener(arg_15_0)
	onButton(arg_15_0, arg_15_0.listBtn, function()
		arg_15_0:openAlbumListPanel()

		return
	end, SFX_PANEL)
	onButton(arg_15_0, arg_15_0.closeBtn, function()
		arg_15_0:closeAlbumListPanel()

		return
	end, SFX_PANEL)
	onButton(arg_15_0, arg_15_0.albumToggle, function()
		if arg_15_0.albumSortValue == "asc" then
			arg_15_0.albumSortValue = "desc"
		elseif arg_15_0.albumSortValue == "desc" then
			arg_15_0.albumSortValue = "asc"
		end

		arg_15_0:updateAlbumListPanel()

		return
	end, SFX_PANEL)
	onButton(arg_15_0, arg_15_0.likeFilteToggle, function()
		arg_15_0.likeValue = 1 - arg_15_0.likeValue
		arg_15_0.curMidddleIndex = 1

		arg_15_0:saveRunData()
		arg_15_0:updateLikeToggle()
		arg_15_0:updatePlateListPanel()

		return
	end, SFX_PANEL)
	onButton(arg_15_0, arg_15_0.playBtn, function()
		if not arg_15_0.musicPlayer then
			return
		end

		arg_15_0.musicPlayer:Resume()
		SetActive(arg_15_0.pauseBtn, true)
		SetActive(arg_15_0.playBtn, false)
		setActive(arg_15_0.playDesc, true)

		return
	end, SFX_PANEL)
	onButton(arg_15_0, arg_15_0.pauseBtn, function()
		if not arg_15_0.musicPlayer then
			return
		end

		arg_15_0.musicPlayer:Pause()
		SetActive(arg_15_0.pauseBtn, false)
		SetActive(arg_15_0.playBtn, true)
		setActive(arg_15_0.playDesc, false)

		return
	end, SFX_PANEL)
	onButton(arg_15_0, arg_15_0.preBtn, function()
		if not arg_15_0.musicPlayer then
			return
		end

		if arg_15_0.isPlayingAni then
			return
		end

		arg_15_0.musicPlayer:Last()

		return
	end, SFX_PANEL)
	onButton(arg_15_0, arg_15_0.nextBtn, function()
		if not arg_15_0.musicPlayer then
			return
		end

		if arg_15_0.isPlayingAni then
			return
		end

		arg_15_0.musicPlayer:Next()

		return
	end, SFX_PANEL)
	onButton(arg_15_0, arg_15_0.likeToggle, function()
		local var_24_0 = pg.music_collect_config[arg_15_0.musicPlayer:GetCurrentMusicId()].id

		pg.m02:sendNotification(GAME.APPRECIATE_MUSIC_LIKE, {
			musicID = var_24_0,
			isAdd = arg_15_0.likeDic[var_24_0] and 1 or 0
		})
		arg_15_0:ChangeLike(var_24_0)
		arg_15_0:updateLikeToggle()
		setActive(arg_15_0.likeOnImg, arg_15_0.likeDic[var_24_0])
		arg_15_0:updatePlateList(arg_15_0.plateTFList[arg_15_0.curMidddleIndex], arg_15_0.curMidddleIndex)

		return
	end, SFX_PANEL)

	local var_15_0

	arg_15_0.playSliderSC:AddPointDownFunc(function(arg_25_0)
		if arg_15_0.onDrag then
			return
		end

		arg_15_0.onDrag = true
		var_15_0 = arg_15_0.musicPlayer:IsPaused()

		if not var_15_0 then
			arg_15_0.musicPlayer:Pause()
		end

		return
	end)
	arg_15_0.playSliderSC:AddPointUpFunc(function(arg_26_0)
		if not arg_15_0.onDrag then
			return
		end

		arg_15_0.onDrag = false

		arg_15_0.musicPlayer:SetProgress(arg_15_0.playSliderSC.value)

		if not var_15_0 then
			arg_15_0.musicPlayer:Resume()
		end

		return
	end)
	onButton(arg_15_0, arg_15_0.playLoopBtn, function()
		local var_27_0 = getProxy(AppreciateProxy):getMusicPlayerLoopType()

		switch(var_27_0, {
			list = function()
				var_27_0 = "random"

				return
			end,
			random = function()
				var_27_0 = "one"

				return
			end,
			one = function()
				var_27_0 = "list"

				return
			end
		})
		pg.m02:sendNotification(GAME.APPRECIATE_CHANGE_MUSIC_PLAY_LOOP_TYPE, {
			loopType = var_27_0
		})
		arg_15_0:updatePlayType(var_27_0)

		if arg_15_0.musicPlayer then
			arg_15_0.musicPlayer.loopType = var_27_0
		end

		return
	end, SFX_PANEL)
	onInputChanged(arg_15_0, arg_15_0.serchInputText, function(arg_31_0)
		if arg_15_0.likeValue ~= MusicCollectionConst.Filte_Like_Value then
			return
		end

		arg_15_0:updatePlateList(arg_15_0.plateTFList[arg_15_0.curMidddleIndex], arg_15_0.curMidddleIndex)

		return
	end)
	onInputChanged(arg_15_0, arg_15_0.albumInputText, function(arg_32_0)
		arg_15_0:updateAlbumListPanel()

		return
	end)

	return
end

function var_0_0.tryShowTipMsgBox(arg_33_0)
	if arg_33_0.appreciateProxy:isMusicHaveNewRes() then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			hideClose = true,
			content = i18n("res_music_new_tip", MusicCollectionConst.NewCount),
			onYes = function()
				arg_33_0.lScrollPageSC:MoveToItemID(MusicCollectionConst.AutoScrollIndex - 1)
				PlayerPrefs.SetInt("musicVersion", MusicCollectionConst.Version)
				arg_33_0:emit(CollectionScene.UPDATE_RED_POINT)

				return
			end,
			onCancel = function()
				arg_33_0.lScrollPageSC:MoveToItemID(MusicCollectionConst.AutoScrollIndex - 1)
				PlayerPrefs.SetInt("musicVersion", MusicCollectionConst.Version)
				arg_33_0:emit(CollectionScene.UPDATE_RED_POINT)

				return
			end,
			onClose = function()
				arg_33_0.lScrollPageSC:MoveToItemID(MusicCollectionConst.AutoScrollIndex - 1)
				PlayerPrefs.SetInt("musicVersion", MusicCollectionConst.Version)
				arg_33_0:emit(CollectionScene.UPDATE_RED_POINT)

				return
			end
		})
	end

	return
end

function var_0_0.initPlateListPanel(arg_35_0)
	function arg_35_0.lScrollPageSC.itemInitedCallback(arg_36_0, arg_36_1)
		arg_35_0.plateTFList[arg_36_0 + 1] = arg_36_1

		arg_36_1:GetComponent("DftAniEvent"):SetEndEvent(function()
			arg_35_0.animCallback = nil

			existCall(arg_35_0.animCallback)

			return
		end)
		arg_35_0:updatePlateTF(arg_36_1, arg_36_0 + 1)

		return
	end

	function arg_35_0.lScrollPageSC.itemClickCallback(arg_38_0, arg_38_1)
		if arg_35_0.curMidddleIndex ~= arg_38_0 + 1 and not arg_35_0.isPlayingAni then
			arg_35_0:setAniState(true)
			arg_35_0:closePlateAni(arg_35_0.plateTFList[arg_35_0.curMidddleIndex])
			arg_35_0.lScrollPageSC:MoveToItemID(arg_38_0)
		end

		return
	end

	function arg_35_0.lScrollPageSC.itemPitchCallback(arg_39_0, arg_39_1)
		arg_35_0.curMidddleIndex = arg_39_0 + 1

		arg_35_0:saveRunData()
		arg_35_0:updatePlateList(arg_39_1, arg_39_0 + 1)
		arg_35_0:playPlateAni(arg_39_1, true)

		return
	end

	function arg_35_0.lScrollPageSC.itemRecycleCallback(arg_40_0, arg_40_1)
		arg_35_0.plateTFList[arg_40_0 + 1] = nil

		return
	end

	addSlip(SLIP_TYPE_HRZ, arg_35_0.plateListPanel, function()
		if arg_35_0.curMidddleIndex > 1 and not arg_35_0.isPlayingAni then
			arg_35_0:setAniState(true)
			arg_35_0.lScrollPageSC:MoveToItemID(arg_35_0.curMidddleIndex - 1 - 1)
			arg_35_0:closePlateAni(arg_35_0.plateTFList[arg_35_0.curMidddleIndex])
		end

		return
	end, function()
		if arg_35_0.curMidddleIndex < arg_35_0.lScrollPageSC.DataCount and not arg_35_0.isPlayingAni then
			arg_35_0:setAniState(true)
			arg_35_0.lScrollPageSC:MoveToItemID(arg_35_0.curMidddleIndex + 1 - 1)
			arg_35_0:closePlateAni(arg_35_0.plateTFList[arg_35_0.curMidddleIndex])
		end

		return
	end)

	return
end

function var_0_0.updatePlateListPanel(arg_43_0)
	local var_43_0 = arg_43_0.likeValue == MusicCollectionConst.Filte_Like_Value

	arg_43_0.tempPlateList = arg_43_0.likeValue == MusicCollectionConst.Filte_Like_Value and {
		"favor"
	} or arg_43_0.albumNames

	setActive(arg_43_0.serchInputText, var_43_0)
	setActive(arg_43_0.listBtn, not var_43_0)

	arg_43_0.lScrollPageSC.DataCount = #arg_43_0.tempPlateList

	arg_43_0.lScrollPageSC:Init(arg_43_0.curMidddleIndex - 1)

	return
end

function var_0_0.updatePlateTF(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_0.tempPlateList[arg_44_2]

	if arg_44_0.likeValue == MusicCollectionConst.Filte_Like_Value then
		local var_44_1 = arg_44_0.likeIds or arg_44_0.appreciateProxy:getAlbumMusicList(var_44_0)
		local var_44_2

		if #var_44_1 > 0 then
			var_44_2 = pg.music_album[pg.music_collect_config[var_44_1[#var_44_1]].album_id].cover
		end

		setText(arg_44_1:Find("PlateImg/empty/Text"), i18n("NewMusic_7"))
		setActive(arg_44_1:Find("PlateImg/face"), var_44_2)
		setActive(arg_44_1:Find("PlateImg/empty"), not var_44_2)

		if var_44_2 then
			arg_44_0.resLoader:LoadSprite(MusicCollectionConst.MUSIC_COVER_PATH_PREFIX .. var_44_2, var_44_2, arg_44_1:Find("PlateImg/face"), false)
		end

		if arg_44_2 == arg_44_0.curMidddleIndex then
			arg_44_0:updatePlateList(arg_44_1, arg_44_2)
		end

		return
	end
end

function var_0_0.updatePlateList(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = arg_45_0.likeValue == MusicCollectionConst.Filte_Like_Value
	local var_45_1 = arg_45_0.tempPlateList[arg_45_2]
	local var_45_2

	if arg_45_0.likeValue ~= MusicCollectionConst.Filte_Like_Value or not arg_45_0.likeIds then
		var_45_2 = arg_45_0.appreciateProxy:getAlbumMusicList(var_45_1)
	end

	local var_45_3 = arg_45_1:Find("list")
	local var_45_4 = var_45_1 == "favor" and i18n("NewMusic_5") or var_45_1

	setText(var_45_3:Find("album_name"), var_45_4)

	local var_45_5 = arg_45_0.appreciateProxy:getMainPlayerAlbumName() == var_45_1
	local var_45_6 = var_45_3:Find("btn_home")

	setActive(var_45_6:Find("off"), not var_45_5)
	setActive(var_45_6:Find("on"), var_45_5)
	onButton(arg_45_0, var_45_6, function()
		if arg_45_0.appreciateProxy:getMainPlayerAlbumName() == var_45_1 then
			pg.m02:sendNotification(GAME.APPRECIATE_CHANGE_MAIN_PLAY_ALBUM, {
				albumName = "none"
			})
			setActive(var_45_6:Find("off"), true)
			setActive(var_45_6:Find("on"), false)
		else
			pg.m02:sendNotification(GAME.APPRECIATE_CHANGE_MAIN_PLAY_ALBUM, {
				albumName = var_45_1
			})
			setActive(var_45_6:Find("off"), false)
			setActive(var_45_6:Find("on"), true)
		end

		arg_45_0:updateAlbumListPanel()

		return
	end, SFX_CONFIRM)

	local var_45_7 = var_45_3:Find("panel/view/container")

	local function var_45_8(arg_47_0)
		local var_47_0

		if not var_45_0 or arg_45_0.sortValue == MusicCollectionConst.Sort_Order_Down then
			var_47_0 = underscore.to_array(var_45_2)
		elseif arg_45_0.sortValue == MusicCollectionConst.Sort_Order_Up then
			var_47_0 = underscore.reverse(var_45_2)
		else
			assert(false)
		end

		local var_47_1 = string.lower(getInputText(arg_45_0.serchInputText))
		local var_47_2 = var_45_0 and underscore.filter(var_47_0, function(arg_48_0)
			local var_48_0 = pg.music_collect_config[arg_48_0].name

			return not var_47_1 or var_47_1 == "" or string.find(string.lower(var_48_0), var_47_1)
		end) or underscore.to_array(var_47_0)

		UIItemList.StaticAlign(var_45_7, var_45_7:GetChild(0), #var_47_2, function(arg_49_0, arg_49_1, arg_49_2)
			arg_49_1 = arg_49_1 + 1

			if arg_49_0 == UIItemList.EventUpdate then
				local var_49_0 = pg.music_collect_config[var_47_2[arg_49_1]]

				if var_45_0 and arg_45_0.sortValue == MusicCollectionConst.Sort_Order_Up then
					setText(arg_49_2:Find("mark/Text"), string.format("%02d", #var_47_2 - arg_49_1 + 1))
				else
					setText(arg_49_2:Find("mark/Text"), string.format("%02d", arg_49_1))
				end

				changeToScrollText(arg_49_2:Find("name"), var_49_0.name)
				setText(arg_49_2:Find("time"), arg_45_0:descTime(var_49_0.music_time))
				setActive(arg_49_2:Find("line"), arg_49_1 < #var_47_2)
				onButton(arg_45_0, arg_49_2:Find("like"), function()
					local var_50_0 = var_49_0.id

					pg.m02:sendNotification(GAME.APPRECIATE_MUSIC_LIKE, {
						musicID = var_49_0.id,
						isAdd = arg_45_0.likeDic[var_49_0.id] and 1 or 0
					})
					arg_45_0:ChangeLike(var_50_0)
					arg_45_0:updateLikeToggle()
					arg_45_0:updatePlateList(arg_45_1, arg_45_2)

					if arg_45_0.musicPlayer and arg_45_0.musicPlayer:GetCurrentMusicId() == var_50_0 then
						setActive(arg_45_0.likeOnImg, arg_45_0.likeDic[var_50_0])
					end

					return
				end, SFX_CONFIRM)
				setActive(arg_49_2:Find("like/off"), not arg_45_0.likeDic[var_49_0.id])
				setActive(arg_49_2:Find("like/on"), arg_45_0.likeDic[var_49_0.id])

				local var_49_1 = arg_45_0.musicPlayer and arg_45_0.musicPlayer.albumName == var_45_1 and arg_45_0.musicPlayer:GetCurrentMusicId() == var_49_0.id

				setActive(arg_49_2:Find("mark/Text"), not var_49_1)
				setActive(arg_49_2:Find("mark/icon"), var_49_1)

				local var_49_2 = var_49_1 and Color.NewHex("FF596E") or Color.white

				setTextColor(arg_49_2:Find("name/subText"), var_49_2)

				local var_49_3 = var_49_1 and Color.NewHex("FF596E") or Color.white

				setTextColor(arg_49_2:Find("time"), var_49_3)
				onButton(arg_45_0, arg_49_2, function()
					arg_45_0:NewMusicPlayer(var_45_1, var_47_0, var_49_0.id)

					return
				end, SFX_CONFIRM)
			end

			return
		end)
		setActive(var_45_3:Find("panel/view/empty"), #var_47_2 == 0)

		return
	end

	setActive(var_45_3:Find("panel/sort"), var_45_0)

	if var_45_0 then
		local var_45_9 = var_45_3:Find("panel/sort/bg/asc")
		local var_45_10 = var_45_3:Find("panel/sort/bg/desc")

		setText(var_45_9:Find("Text"), i18n("word_asc"))
		onToggle(arg_45_0, var_45_9, function(arg_52_0)
			if arg_52_0 then
				arg_45_0.sortValue = MusicCollectionConst.Sort_Order_Up

				arg_45_0:saveRunData()
				var_45_8(not arg_52_0)
			end

			setImageAlpha(var_45_9, arg_52_0 and 1 or 0)
			setCanvasGroupAlpha(var_45_9, arg_52_0 and 1 or 0.3)

			return
		end, SFX_PANEL)
		setText(var_45_10:Find("Text"), i18n("word_desc"))
		onToggle(arg_45_0, var_45_10, function(arg_53_0)
			if arg_53_0 then
				arg_45_0.sortValue = MusicCollectionConst.Sort_Order_Down

				arg_45_0:saveRunData()
				var_45_8(arg_53_0)
			end

			setImageAlpha(var_45_10, arg_53_0 and 1 or 0)
			setCanvasGroupAlpha(var_45_10, arg_53_0 and 1 or 0.3)

			return
		end, SFX_PANEL)

		if arg_45_0.sortValue == MusicCollectionConst.Sort_Order_Up then
			triggerToggle(var_45_9, true)
		else
			triggerToggle(var_45_10, true)
		end
	else
		(function(arg_47_0)
			local var_47_0

			if not var_45_0 or arg_45_0.sortValue == MusicCollectionConst.Sort_Order_Down then
				var_47_0 = underscore.to_array(var_45_2)
			elseif arg_45_0.sortValue == MusicCollectionConst.Sort_Order_Up then
				var_47_0 = underscore.reverse(var_45_2)
			else
				assert(false)
			end

			local var_47_1 = string.lower(getInputText(arg_45_0.serchInputText))
			local var_47_2 = var_45_0 and underscore.filter(var_47_0, function(arg_48_0)
				local var_48_0 = pg.music_collect_config[arg_48_0].name

				return not var_47_1 or var_47_1 == "" or string.find(string.lower(var_48_0), var_47_1)
			end) or underscore.to_array(var_47_0)

			UIItemList.StaticAlign(var_45_7, var_45_7:GetChild(0), #var_47_2, function(arg_49_0, arg_49_1, arg_49_2)
				arg_49_1 = arg_49_1 + 1

				if arg_49_0 == UIItemList.EventUpdate then
					local var_49_0 = pg.music_collect_config[var_47_2[arg_49_1]]

					if var_45_0 and arg_45_0.sortValue == MusicCollectionConst.Sort_Order_Up then
						setText(arg_49_2:Find("mark/Text"), string.format("%02d", #var_47_2 - arg_49_1 + 1))
					else
						setText(arg_49_2:Find("mark/Text"), string.format("%02d", arg_49_1))
					end

					changeToScrollText(arg_49_2:Find("name"), var_49_0.name)
					setText(arg_49_2:Find("time"), arg_45_0:descTime(var_49_0.music_time))
					setActive(arg_49_2:Find("line"), arg_49_1 < #var_47_2)
					onButton(arg_45_0, arg_49_2:Find("like"), function()
						local var_50_0 = var_49_0.id

						pg.m02:sendNotification(GAME.APPRECIATE_MUSIC_LIKE, {
							musicID = var_49_0.id,
							isAdd = arg_45_0.likeDic[var_49_0.id] and 1 or 0
						})
						arg_45_0:ChangeLike(var_50_0)
						arg_45_0:updateLikeToggle()
						arg_45_0:updatePlateList(arg_45_1, arg_45_2)

						if arg_45_0.musicPlayer and arg_45_0.musicPlayer:GetCurrentMusicId() == var_50_0 then
							setActive(arg_45_0.likeOnImg, arg_45_0.likeDic[var_50_0])
						end

						return
					end, SFX_CONFIRM)
					setActive(arg_49_2:Find("like/off"), not arg_45_0.likeDic[var_49_0.id])
					setActive(arg_49_2:Find("like/on"), arg_45_0.likeDic[var_49_0.id])

					local var_49_1 = arg_45_0.musicPlayer and arg_45_0.musicPlayer.albumName == var_45_1 and arg_45_0.musicPlayer:GetCurrentMusicId() == var_49_0.id

					setActive(arg_49_2:Find("mark/Text"), not var_49_1)
					setActive(arg_49_2:Find("mark/icon"), var_49_1)

					local var_49_2 = var_49_1 and Color.NewHex("FF596E") or Color.white

					setTextColor(arg_49_2:Find("name/subText"), var_49_2)

					local var_49_3 = var_49_1 and Color.NewHex("FF596E") or Color.white

					setTextColor(arg_49_2:Find("time"), var_49_3)
					onButton(arg_45_0, arg_49_2, function()
						arg_45_0:NewMusicPlayer(var_45_1, var_47_0, var_49_0.id)

						return
					end, SFX_CONFIRM)
				end

				return
			end)
			setActive(var_45_3:Find("panel/view/empty"), #var_47_2 == 0)

			return
		end)(false)
	end

	return
end

function var_0_0.updateAlbumListPanel(arg_54_0)
	local var_54_0 = string.lower(getInputText(arg_54_0.albumInputText))

	arg_54_0.tempAlbumList = underscore.filter(arg_54_0.albumNames, function(arg_55_0)
		if string.find(string.lower(arg_55_0), var_54_0) then
			return true
		else
			return underscore.any(arg_54_0.appreciateProxy:getAlbumMusicList(arg_55_0), function(arg_56_0)
				return string.find(string.lower(pg.music_collect_config[arg_56_0].name), var_54_0)
			end)
		end

		return
	end)

	arg_54_0.albumItemList:align(#arg_54_0.tempAlbumList)
	setActive(arg_54_0.panel:Find("middle/empty"), #arg_54_0.tempAlbumList == 0)
	setActive(arg_54_0.albumToggle:Find("asc"), arg_54_0.albumSortValue == "asc")
	setActive(arg_54_0.albumToggle:Find("desc"), arg_54_0.albumSortValue == "desc")

	return
end

function var_0_0.updateAlbumTF(arg_57_0, arg_57_1, arg_57_2)
	if arg_57_0.albumSortValue == "desc" then
		arg_57_2 = #arg_57_0.tempAlbumList + 1 - arg_57_2
	end

	local var_57_0 = arg_57_0.tempAlbumList[arg_57_2]

	setText(arg_57_1:Find("index"), string.format("%02d", arg_57_2))

	local var_57_1 = pg.music_album[pg.music_collect_config[arg_57_0.appreciateProxy:getAlbumMusicList(var_57_0)[1]].album_id].cover

	arg_57_0.resLoader:LoadSprite(MusicCollectionConst.MUSIC_COVER_PATH_PREFIX .. var_57_1, var_57_1, arg_57_1:Find("icon/face"), false)
	changeToScrollText(arg_57_1:Find("name"), var_57_0)
	setActive(arg_57_1:Find("icon/main"), var_57_0 == arg_57_0.appreciateProxy:getMainPlayerAlbumName())

	local var_57_2 = arg_57_0.musicPlayer and arg_57_0.musicPlayer.albumName == var_57_0

	setActive(arg_57_1:Find("playing"), var_57_2)
	setActive(arg_57_1:Find("line"), arg_57_2 < #arg_57_0.tempAlbumList)
	onButton(arg_57_0, arg_57_1, function()
		arg_57_0:closeAlbumListPanel()

		arg_57_0.curMidddleIndex = arg_57_2

		if arg_57_0.likeValue == MusicCollectionConst.Filte_Like_Value then
			arg_57_0.likeValue = MusicCollectionConst.Filte_Normal_Value

			arg_57_0:updatePlateListPanel()
		else
			arg_57_0.lScrollPageSC:Init(arg_57_0.curMidddleIndex - 1)
		end

		arg_57_0:saveRunData()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateLikeToggle(arg_59_0)
	setActive(arg_59_0.likeFilteOnImg, arg_59_0.likeValue == MusicCollectionConst.Filte_Like_Value)
	setText(arg_59_0.likeFilteToggle:Find("TextNum"), string.format("(%d)", (underscore.reduce(underscore.keys(arg_59_0.likeDic), 0, function(arg_60_0, arg_60_1)
		return arg_60_0 + (arg_59_0.likeDic[arg_60_1] and 1 or 0)
	end))))

	return
end

function var_0_0.updatePlayPanel(arg_61_0, arg_61_1)
	local var_61_0 = pg.music_collect_config[arg_61_0.musicPlayer:GetCurrentMusicId()]

	arg_61_0.resLoader:LoadSprite(MusicCollectionConst.MUSIC_COVER_PATH_PREFIX .. pg.music_album[var_61_0.album_id].cover, pg.music_album[var_61_0.album_id].cover, arg_61_0.songImg, false)
	changeToScrollText(arg_61_0.playPanelNameText, var_61_0.name)
	setActive(arg_61_0.likeOnImg, arg_61_0.likeDic[var_61_0.id])
	setActive(arg_61_0.playBtn, false)
	setActive(arg_61_0.playDesc, true)
	setActive(arg_61_0.pauseBtn, true)
	setSlider(arg_61_0.playProgressBar, 0, arg_61_1, 0)
	setText(arg_61_0.totalTimeText, arg_61_0:descTime(arg_61_1))
	setActive(arg_61_0.nowTimeText, true)
	setActive(arg_61_0.totalTimeText, true)

	return
end

function var_0_0.updatePlayType(arg_62_0, arg_62_1)
	arg_62_1 = arg_62_1 or getProxy(AppreciateProxy):getMusicPlayerLoopType()

	eachChild(arg_62_0.playLoopBtn, function(arg_63_0, arg_63_1)
		setActive(arg_63_0, arg_63_0.name == arg_62_1)

		return
	end)

	return
end

function var_0_0.updatePlayProgress(arg_64_0, arg_64_1)
	arg_64_0.playSliderSC:SetValueWithoutEvent(arg_64_1)
	setText(arg_64_0.nowTimeText, arg_64_0:descTime(arg_64_1))

	return
end

function var_0_0.playPlateAni(arg_65_0, arg_65_1, arg_65_2, arg_65_3, arg_65_4)
	arg_65_0:setAniState(true)
	setActive(arg_65_1:Find("list"), true)

	function arg_65_0.animCallback()
		arg_65_0:setAniState(false)

		return
	end

	quickPlayAnimation(arg_65_1, "anim_MusicCollectionUI_Plate_expand")

	return
end

function var_0_0.closePlateAni(arg_67_0, arg_67_1)
	arg_67_0:setAniState(true)

	function arg_67_0.animCallback()
		setActive(arg_67_1:Find("list"), false)
		arg_67_0:setAniState(false)

		return
	end

	quickPlayAnimation(arg_67_1, "anim_MusicCollectionUI_Plate_retract")

	return
end

function var_0_0.setAniState(arg_69_0, arg_69_1)
	arg_69_0.isPlayingAni = arg_69_1

	return
end

function var_0_0.openAlbumListPanel(arg_70_0)
	setActive(arg_70_0.albumListPanel, true)
	setActive(arg_70_0.listBtn:Find("on"), true)
	setActive(arg_70_0.listBtn:Find("off"), false)

	return
end

function var_0_0.closeAlbumListPanel(arg_71_0, arg_71_1)
	setActive(arg_71_0.albumListPanel, false)
	setActive(arg_71_0.listBtn:Find("on"), false)
	setActive(arg_71_0.listBtn:Find("off"), true)

	return
end

function var_0_0.checkupdateAlbumTF(arg_72_0)
	if #arg_72_0.albumTFList > 0 then
		arg_72_0:updateAlbumTF(arg_72_0.albumTFList[arg_72_0.curMidddleIndex], arg_72_0.curMidddleIndex)
	end

	return
end

function var_0_0.NewMusicPlayer(arg_73_0, arg_73_1, arg_73_2, arg_73_3)
	({}).loopType = getProxy(AppreciateProxy):getMusicPlayerLoopType()
	;({}).albumName = arg_73_1
	;({}).list = arg_73_2 or nil
	;({}).index = arg_73_3 and table.indexof(arg_73_2, arg_73_3) or nil

	arg_73_0.bgmMgr:TempPlay("TempMusicPlayer", {})

	arg_73_0.musicPlayer = arg_73_0.bgmMgr:GetMusicPlayer()

	return
end

function var_0_0.ChangeLike(arg_74_0, arg_74_1)
	arg_74_0.likeDic[arg_74_1] = not arg_74_0.likeDic[arg_74_1]

	if arg_74_0.likeDic[arg_74_1] then
		table.insert(arg_74_0.likeIds, arg_74_1)
	else
		table.removebyvalue(arg_74_0.likeIds, arg_74_1)
	end

	return
end

function var_0_0.tryPlayMusic(arg_75_0)
	triggerButton(arg_75_0.playBtn)

	return
end

function var_0_0.tryPauseMusic(arg_76_0)
	triggerButton(arg_76_0.pauseBtn)

	return
end

function var_0_0.descTime(arg_77_0, arg_77_1)
	local var_77_0 = math.floor(arg_77_1 / 1000)
	local var_77_1 = math.floor(var_77_0 / 16)
	local var_77_2 = math.floor((var_77_0 - var_77_1 * 16) / 60)

	if var_77_1 ~= 0 then
		return string.format("%02d:%02d:%02d", var_77_1, var_77_2, (var_77_0 - var_77_1 * 16) % 60)
	else
		return string.format("%02d:%02d", var_77_2, (var_77_0 - var_77_1 * 16) % 60)
	end

	return
end

return var_0_0

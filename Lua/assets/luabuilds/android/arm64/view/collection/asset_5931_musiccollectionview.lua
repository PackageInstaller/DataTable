local MusicCollectionView = class("MusicCollectionView", import("..base.BaseSubView"))

function MusicCollectionView:getUIName()
	return "MusicCollectionUI"
end

function MusicCollectionView:OnInit()
	self:initData()
	self:findUI()
	self:addListener()
	self:initPlateListPanel()
	self:Show()
	self:recoverRunData()
	self:tryShowTipMsgBox()

	return
end

function MusicCollectionView:OnDestroy()
	self.bgmMgr:UnregisterMusicCallback(self.__cname)
	self.resLoader:Clear()
	self:closeAlbumListPanel(true)

	return
end

function MusicCollectionView:onBackPressed()
	if isActive(self.albumListPanel) then
		self:closeAlbumListPanel()

		return false
	else
		return true
	end

	return
end

function MusicCollectionView:initData()
	self.bgmMgr = pg.BgmMgr.GetInstance()
	self.appreciateProxy = getProxy(AppreciateProxy)
	self.albumNames = underscore.to_array(pg.music_album.all)

	table.sort(self.albumNames, CompareFuncs({
		function(arg_6_0)
			return -pg.music_album[arg_6_0].order
		end
	}))

	self.albumNames = underscore.map(self.albumNames, function(arg_7_0)
		return pg.music_album[arg_7_0].album_name
	end)
	self.plateTFList = {}
	self.albumTFList = {}
	self.likeDic = {}
	self.likeIds = {}
	self.curMidddleIndex = 1
	self.isPlayingAni = false
	self.resLoader = AutoLoader.New()

	return
end

function MusicCollectionView:saveRunData()
	self.appreciateProxy:updateMusicRunData(self.sortValue, self.curMidddleIndex, self.likeValue)

	return
end

function MusicCollectionView:recoverRunData()
	local var_9_0 = self.appreciateProxy:getMusicRunData()

	self.sortValue = var_9_0.sortValue
	self.curMidddleIndex = var_9_0.middleIndex
	self.likeValue = var_9_0.likeValue
	self.albumSortValue = "asc"
	self.likeIds = self.appreciateProxy:getAlbumMusicList("favor")

	for iter_9_0, iter_9_1 in ipairs(self.likeIds) do
		self.likeDic[iter_9_1] = true
	end

	self.lScrollPageSC.MiddleIndexOnInit = self.curMidddleIndex - 1

	self:updatePlateListPanel()

	if getProxy(AppreciateProxy):CanPlayMainMusicPlayer() then
		self:NewMusicPlayer(self.appreciateProxy:getMainPlayerAlbumName())
	else
		self:NewMusicPlayer(self.tempPlateList[self.curMidddleIndex])
	end

	self.bgmMgr:RegisterMusicCallback(self.__cname, "TempMusicPlayer", {
		startCall = function(arg_10_0)
			if self.plateTFList[self.curMidddleIndex] then
				self:updatePlateList(self.plateTFList[self.curMidddleIndex], self.curMidddleIndex)
			end

			self:updateAlbumListPanel()
			self:updatePlayPanel(arg_10_0)

			return
		end,
		progressCall = function(arg_11_0)
			if self.onDrag then
				return
			end

			self:updatePlayProgress(arg_11_0)

			return
		end,
		noPlayCall = function()
			self:NewMusicPlayer(self.tempPlateList[self.curMidddleIndex])

			return
		end
	})
	self:updateAlbumListPanel()
	self:updateLikeToggle()
	self:updatePlayType()

	return
end

function MusicCollectionView:findUI()
	setLocalPosition(self._tf, Vector2.zero)

	self._tf.anchorMin = Vector2.zero
	self._tf.anchorMax = Vector2.one
	self._tf.offsetMax = Vector2.zero
	self._tf.offsetMin = Vector2.zero
	self.topPanel = self._tf:Find("TopPanel")
	self.likeFilteToggle = self.topPanel:Find("LikeBtn")

	setActive(self.likeFilteToggle, true)

	self.serchInputText = self.topPanel:Find("serch")

	setText(self.serchInputText:Find("Placeholder"), i18n("NewMusic_2"))

	self.plateListPanel = self._tf:Find("PlateList")
	self.plateTpl = self.plateListPanel:Find("Plate")

	setActive(self.plateTpl, false)
	setText(self.plateTpl:Find("list/panel/view/empty/icon/Text"), i18n("NewMusic_3"))

	self.lScrollPageSC = GetComponent(self.plateListPanel, "LScrollPage")
	self.playPanel = self._tf:Find("PLayPanel")
	self.playPanelNameText = self.playPanel:Find("NameText")
	self.likeToggle = self.playPanel:Find("LikeBtn")
	self.likeOnImg = self.likeToggle:Find("On")
	self.songImg = self.playPanel:Find("SongImg/face")
	self.pauseBtn = self.playPanel:Find("PlayingBtn")
	self.playBtn = self.playPanel:Find("StopingBtn")
	self.playDesc = self.playPanel:Find("PlayDesc")
	self.nextBtn = self.playPanel:Find("NextBtn")
	self.preBtn = self.playPanel:Find("PreBtn")
	self.playProgressBar = self.playPanel:Find("Progress")
	self.nowTimeText = self.playProgressBar:Find("NowTimeText")
	self.totalTimeText = self.playProgressBar:Find("TotalTimeText")
	self.playSliderSC = GetComponent(self.playProgressBar, "LSlider")
	self.listBtn = self.playPanel:Find("ListBtn")

	setActive(self.listBtn:Find("on"), false)
	setActive(self.listBtn:Find("off"), true)

	self.albumListPanel = self._tf:Find("AlbumListPanel")
	self.closeBtn = self.albumListPanel:Find("BG")
	self.panel = self.albumListPanel:Find("Panel")

	setText(self.panel:Find("top/name"), i18n("NewMusic_6"))

	self.albumToggle = self.panel:Find("bottom/sort_btn")
	self.albumInputText = self.panel:Find("bottom/serch")

	setText(self.albumInputText:Find("Placeholder"), i18n("NewMusic_2"))

	self.albumContainer = self.panel:Find("middle/Content")
	self.albumItemList = UIItemList.New(self.albumContainer, self.albumContainer:GetChild(0))

	self.albumItemList:make(function(arg_14_0, arg_14_1, arg_14_2)
		arg_14_1 = arg_14_1 + 1

		if arg_14_0 == UIItemList.EventUpdate then
			self.albumTFList[arg_14_1] = arg_14_2

			self:updateAlbumTF(arg_14_2, arg_14_1)
		end

		return
	end)

	self.likeFilteOnImg = self.likeFilteToggle:Find("TextLike/On")
	self.playLoopBtn = self.playPanel:Find("PlayTypeBtn")

	return
end

function MusicCollectionView:addListener()
	onButton(self, self.listBtn, function()
		self:openAlbumListPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:closeAlbumListPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.albumToggle, function()
		if self.albumSortValue == "asc" then
			self.albumSortValue = "desc"
		elseif self.albumSortValue == "desc" then
			self.albumSortValue = "asc"
		end

		self:updateAlbumListPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.likeFilteToggle, function()
		self.likeValue = 1 - self.likeValue
		self.curMidddleIndex = 1

		self:saveRunData()
		self:updateLikeToggle()
		self:updatePlateListPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.playBtn, function()
		if not self.musicPlayer then
			return
		end

		self.musicPlayer:Resume()
		SetActive(self.pauseBtn, true)
		SetActive(self.playBtn, false)
		setActive(self.playDesc, true)

		return
	end, SFX_PANEL)
	onButton(self, self.pauseBtn, function()
		if not self.musicPlayer then
			return
		end

		self.musicPlayer:Pause()
		SetActive(self.pauseBtn, false)
		SetActive(self.playBtn, true)
		setActive(self.playDesc, false)

		return
	end, SFX_PANEL)
	onButton(self, self.preBtn, function()
		if not self.musicPlayer then
			return
		end

		if self.isPlayingAni then
			return
		end

		self.musicPlayer:Last()

		return
	end, SFX_PANEL)
	onButton(self, self.nextBtn, function()
		if not self.musicPlayer then
			return
		end

		if self.isPlayingAni then
			return
		end

		self.musicPlayer:Next()

		return
	end, SFX_PANEL)
	onButton(self, self.likeToggle, function()
		local var_24_0 = pg.music_collect_config[self.musicPlayer:GetCurrentMusicId()].id

		pg.m02:sendNotification(GAME.APPRECIATE_MUSIC_LIKE, {
			musicID = var_24_0,
			isAdd = self.likeDic[var_24_0] and 1 or 0
		})
		self:ChangeLike(var_24_0)
		self:updateLikeToggle()
		setActive(self.likeOnImg, self.likeDic[var_24_0])
		self:updatePlateList(self.plateTFList[self.curMidddleIndex], self.curMidddleIndex)

		return
	end, SFX_PANEL)

	local var_15_0

	self.playSliderSC:AddPointDownFunc(function(arg_25_0)
		if self.onDrag then
			return
		end

		self.onDrag = true
		var_15_0 = self.musicPlayer:IsPaused()

		if not var_15_0 then
			self.musicPlayer:Pause()
		end

		return
	end)
	self.playSliderSC:AddPointUpFunc(function(arg_26_0)
		if not self.onDrag then
			return
		end

		self.onDrag = false

		self.musicPlayer:SetProgress(self.playSliderSC.value)

		if not var_15_0 then
			self.musicPlayer:Resume()
		end

		return
	end)
	onButton(self, self.playLoopBtn, function()
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
		self:updatePlayType(var_27_0)

		if self.musicPlayer then
			self.musicPlayer.loopType = var_27_0
		end

		return
	end, SFX_PANEL)
	onInputChanged(self, self.serchInputText, function(arg_31_0)
		if self.likeValue ~= MusicCollectionConst.Filte_Like_Value then
			return
		end

		self:updatePlateList(self.plateTFList[self.curMidddleIndex], self.curMidddleIndex)

		return
	end)
	onInputChanged(self, self.albumInputText, function(arg_32_0)
		self:updateAlbumListPanel()

		return
	end)

	return
end

function MusicCollectionView:tryShowTipMsgBox()
	if self.appreciateProxy:isMusicHaveNewRes() then
		local function var_33_0()
			self.lScrollPageSC:MoveToItemID(MusicCollectionConst.AutoScrollIndex - 1)
			PlayerPrefs.SetInt("musicVersion", MusicCollectionConst.Version)
			self:emit(CollectionScene.UPDATE_RED_POINT)

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			hideClose = true,
			content = i18n("res_music_new_tip", MusicCollectionConst.NewCount),
			onYes = var_33_0,
			onCancel = var_33_0,
			onClose = var_33_0
		})
	end

	return
end

function MusicCollectionView:initPlateListPanel()
	function self.lScrollPageSC.itemInitedCallback(arg_36_0, arg_36_1)
		self.plateTFList[arg_36_0 + 1] = arg_36_1

		arg_36_1:GetComponent("DftAniEvent"):SetEndEvent(function()
			self.animCallback = nil

			existCall(self.animCallback)

			return
		end)
		self:updatePlateTF(arg_36_1, arg_36_0 + 1)

		return
	end

	function self.lScrollPageSC.itemClickCallback(arg_38_0, arg_38_1)
		if self.curMidddleIndex ~= arg_38_0 + 1 and not self.isPlayingAni then
			self:setAniState(true)
			self:closePlateAni(self.plateTFList[self.curMidddleIndex])
			self.lScrollPageSC:MoveToItemID(arg_38_0)
		end

		return
	end

	function self.lScrollPageSC.itemPitchCallback(arg_39_0, arg_39_1)
		self.curMidddleIndex = arg_39_0 + 1

		self:saveRunData()
		self:updatePlateList(arg_39_1, arg_39_0 + 1)
		self:playPlateAni(arg_39_1, true)

		return
	end

	function self.lScrollPageSC.itemRecycleCallback(arg_40_0, arg_40_1)
		self.plateTFList[arg_40_0 + 1] = nil

		return
	end

	addSlip(SLIP_TYPE_HRZ, self.plateListPanel, function()
		if self.curMidddleIndex > 1 and not self.isPlayingAni then
			self:setAniState(true)
			self.lScrollPageSC:MoveToItemID(self.curMidddleIndex - 1 - 1)
			self:closePlateAni(self.plateTFList[self.curMidddleIndex])
		end

		return
	end, function()
		if self.curMidddleIndex < self.lScrollPageSC.DataCount and not self.isPlayingAni then
			self:setAniState(true)
			self.lScrollPageSC:MoveToItemID(self.curMidddleIndex + 1 - 1)
			self:closePlateAni(self.plateTFList[self.curMidddleIndex])
		end

		return
	end)

	return
end

function MusicCollectionView:updatePlateListPanel()
	local var_43_0 = self.likeValue == MusicCollectionConst.Filte_Like_Value

	self.tempPlateList = self.likeValue == MusicCollectionConst.Filte_Like_Value and {
		"favor"
	} or self.albumNames

	setActive(self.serchInputText, var_43_0)
	setActive(self.listBtn, not var_43_0)

	self.lScrollPageSC.DataCount = #self.tempPlateList

	self.lScrollPageSC:Init(self.curMidddleIndex - 1)

	return
end

function MusicCollectionView:updatePlateTF(arg_44_1, arg_44_2)
	local var_44_0

	if self.likeValue == MusicCollectionConst.Filte_Like_Value then
		var_44_0 = self.likeIds or self.appreciateProxy:getAlbumMusicList(self.tempPlateList[arg_44_2])
	end

	local var_44_1

	if #var_44_0 > 0 then
		var_44_1 = pg.music_album[pg.music_collect_config[var_44_0[#var_44_0]].album_id].cover
	end

	setText(arg_44_1:Find("PlateImg/empty/Text"), i18n("NewMusic_7"))
	setActive(arg_44_1:Find("PlateImg/face"), var_44_1)
	setActive(arg_44_1:Find("PlateImg/empty"), not var_44_1)

	if var_44_1 then
		self.resLoader:LoadSprite(MusicCollectionConst.MUSIC_COVER_PATH_PREFIX .. var_44_1, var_44_1, arg_44_1:Find("PlateImg/face"), false)
	end

	if arg_44_2 == self.curMidddleIndex then
		self:updatePlateList(arg_44_1, arg_44_2)
	end

	return
end

function MusicCollectionView:updatePlateList(arg_45_1, arg_45_2)
	local var_45_0 = self.likeValue == MusicCollectionConst.Filte_Like_Value
	local var_45_1 = self.tempPlateList[arg_45_2]

	if self.likeValue == MusicCollectionConst.Filte_Like_Value then
		local var_45_2 = self.likeIds or self.appreciateProxy:getAlbumMusicList(var_45_1)
	end

	local var_45_3 = arg_45_1:Find("list")

	setText(var_45_3:Find("album_name"), var_45_1 == "favor" and i18n("NewMusic_5") or var_45_1)

	local var_45_4 = self.appreciateProxy:getMainPlayerAlbumName() == var_45_1
	local var_45_5 = var_45_3:Find("btn_home")

	setActive(var_45_5:Find("off"), not var_45_4)
	setActive(var_45_5:Find("on"), var_45_4)
	onButton(self, var_45_5, function()
		if self.appreciateProxy:getMainPlayerAlbumName() == var_45_1 then
			pg.m02:sendNotification(GAME.APPRECIATE_CHANGE_MAIN_PLAY_ALBUM, {
				albumName = "none"
			})
			setActive(var_45_5:Find("off"), true)
			setActive(var_45_5:Find("on"), false)
		else
			pg.m02:sendNotification(GAME.APPRECIATE_CHANGE_MAIN_PLAY_ALBUM, {
				albumName = var_45_1
			})
			setActive(var_45_5:Find("off"), false)
			setActive(var_45_5:Find("on"), true)
		end

		self:updateAlbumListPanel()

		return
	end, SFX_CONFIRM)

	local var_45_6 = var_45_3:Find("panel/view/container")

	local function var_45_7(arg_47_0)
		local var_47_0

		if not var_45_0 or self.sortValue == MusicCollectionConst.Sort_Order_Down then
			var_47_0 = underscore.to_array(var_45_2)
		elseif self.sortValue == MusicCollectionConst.Sort_Order_Up then
			var_47_0 = underscore.reverse(var_45_2)
		else
			assert(false)
		end

		local var_47_1 = string.lower(getInputText(self.serchInputText))
		local var_47_2 = var_45_0 and underscore.filter(var_47_0, function(arg_48_0)
			return not var_47_1 or var_47_1 == "" or string.find(string.lower(pg.music_collect_config[arg_48_0].name), var_47_1)
		end) or underscore.to_array(var_47_0)

		UIItemList.StaticAlign(var_45_6, var_45_6:GetChild(0), #var_47_2, function(arg_49_0, arg_49_1, arg_49_2)
			arg_49_1 = arg_49_1 + 1

			if arg_49_0 == UIItemList.EventUpdate then
				local var_49_0 = pg.music_collect_config[var_47_2[arg_49_1]]

				if var_45_0 and self.sortValue == MusicCollectionConst.Sort_Order_Up then
					setText(arg_49_2:Find("mark/Text"), string.format("%02d", #var_47_2 - arg_49_1 + 1))
				else
					setText(arg_49_2:Find("mark/Text"), string.format("%02d", arg_49_1))
				end

				changeToScrollText(arg_49_2:Find("name"), var_49_0.name)
				setText(arg_49_2:Find("time"), self:descTime(var_49_0.music_time))
				setActive(arg_49_2:Find("line"), arg_49_1 < #var_47_2)
				onButton(self, arg_49_2:Find("like"), function()
					local var_50_0 = var_49_0.id

					pg.m02:sendNotification(GAME.APPRECIATE_MUSIC_LIKE, {
						musicID = var_49_0.id,
						isAdd = self.likeDic[var_49_0.id] and 1 or 0
					})
					self:ChangeLike(var_50_0)
					self:updateLikeToggle()
					self:updatePlateList(arg_45_1, arg_45_2)

					if self.musicPlayer and self.musicPlayer:GetCurrentMusicId() == var_50_0 then
						setActive(self.likeOnImg, self.likeDic[var_50_0])
					end

					return
				end, SFX_CONFIRM)
				setActive(arg_49_2:Find("like/off"), not self.likeDic[var_49_0.id])
				setActive(arg_49_2:Find("like/on"), self.likeDic[var_49_0.id])

				local var_49_1 = self.musicPlayer and self.musicPlayer.albumName == var_45_1 and self.musicPlayer:GetCurrentMusicId() == var_49_0.id

				setActive(arg_49_2:Find("mark/Text"), not var_49_1)
				setActive(arg_49_2:Find("mark/icon"), var_49_1)
				setTextColor(arg_49_2:Find("name/subText"), var_49_1 and Color.NewHex("FF596E") or Color.white)
				setTextColor(arg_49_2:Find("time"), var_49_1 and Color.NewHex("FF596E") or Color.white)
				onButton(self, arg_49_2, function()
					self:NewMusicPlayer(var_45_1, var_47_0, var_49_0.id)

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
		local var_45_8 = var_45_3:Find("panel/sort/bg/asc")
		local var_45_9 = var_45_3:Find("panel/sort/bg/desc")

		setText(var_45_8:Find("Text"), i18n("word_asc"))
		onToggle(self, var_45_8, function(arg_52_0)
			if arg_52_0 then
				self.sortValue = MusicCollectionConst.Sort_Order_Up

				self:saveRunData()
				var_45_7(not arg_52_0)
			end

			setImageAlpha(var_45_8, arg_52_0 and 1 or 0)
			setCanvasGroupAlpha(var_45_8, arg_52_0 and 1 or 0.3)

			return
		end, SFX_PANEL)
		setText(var_45_9:Find("Text"), i18n("word_desc"))
		onToggle(self, var_45_9, function(arg_53_0)
			if arg_53_0 then
				self.sortValue = MusicCollectionConst.Sort_Order_Down

				self:saveRunData()
				var_45_7(arg_53_0)
			end

			setImageAlpha(var_45_9, arg_53_0 and 1 or 0)
			setCanvasGroupAlpha(var_45_9, arg_53_0 and 1 or 0.3)

			return
		end, SFX_PANEL)

		if self.sortValue == MusicCollectionConst.Sort_Order_Up then
			triggerToggle(var_45_8, true)
		else
			triggerToggle(var_45_9, true)
		end
	else
		var_45_7(false)
	end

	return
end

function MusicCollectionView:updateAlbumListPanel()
	local var_54_0 = string.lower(getInputText(self.albumInputText))

	self.tempAlbumList = underscore.filter(self.albumNames, function(arg_55_0)
		if string.find(string.lower(arg_55_0), var_54_0) then
			return true
		else
			return underscore.any(self.appreciateProxy:getAlbumMusicList(arg_55_0), function(arg_56_0)
				return string.find(string.lower(pg.music_collect_config[arg_56_0].name), var_54_0)
			end)
		end

		return
	end)

	self.albumItemList:align(#self.tempAlbumList)
	setActive(self.panel:Find("middle/empty"), #self.tempAlbumList == 0)
	setActive(self.albumToggle:Find("asc"), self.albumSortValue == "asc")
	setActive(self.albumToggle:Find("desc"), self.albumSortValue == "desc")

	return
end

function MusicCollectionView:updateAlbumTF(arg_57_1, arg_57_2)
	if self.albumSortValue == "desc" then
		arg_57_2 = #self.tempAlbumList + 1 - arg_57_2
	end

	local var_57_0 = self.tempAlbumList[arg_57_2]

	setText(arg_57_1:Find("index"), string.format("%02d", arg_57_2))

	local var_57_1 = pg.music_album[pg.music_collect_config[self.appreciateProxy:getAlbumMusicList(var_57_0)[1]].album_id].cover

	self.resLoader:LoadSprite(MusicCollectionConst.MUSIC_COVER_PATH_PREFIX .. var_57_1, var_57_1, arg_57_1:Find("icon/face"), false)
	changeToScrollText(arg_57_1:Find("name"), var_57_0)
	setActive(arg_57_1:Find("icon/main"), var_57_0 == self.appreciateProxy:getMainPlayerAlbumName())
	setActive(arg_57_1:Find("playing"), self.musicPlayer and self.musicPlayer.albumName == var_57_0)
	setActive(arg_57_1:Find("line"), arg_57_2 < #self.tempAlbumList)
	onButton(self, arg_57_1, function()
		self:closeAlbumListPanel()

		self.curMidddleIndex = arg_57_2

		if self.likeValue == MusicCollectionConst.Filte_Like_Value then
			self.likeValue = MusicCollectionConst.Filte_Normal_Value

			self:updatePlateListPanel()
		else
			self.lScrollPageSC:Init(self.curMidddleIndex - 1)
		end

		self:saveRunData()

		return
	end, SFX_PANEL)

	return
end

function MusicCollectionView:updateLikeToggle()
	setActive(self.likeFilteOnImg, self.likeValue == MusicCollectionConst.Filte_Like_Value)
	setText(self.likeFilteToggle:Find("TextNum"), string.format("(%d)", (underscore.reduce(underscore.keys(self.likeDic), 0, function(arg_60_0, arg_60_1)
		return arg_60_0 + (self.likeDic[arg_60_1] and 1 or 0)
	end))))

	return
end

function MusicCollectionView:updatePlayPanel(arg_61_1)
	local var_61_0 = pg.music_collect_config[self.musicPlayer:GetCurrentMusicId()]

	self.resLoader:LoadSprite(MusicCollectionConst.MUSIC_COVER_PATH_PREFIX .. pg.music_album[var_61_0.album_id].cover, pg.music_album[var_61_0.album_id].cover, self.songImg, false)
	changeToScrollText(self.playPanelNameText, var_61_0.name)
	setActive(self.likeOnImg, self.likeDic[var_61_0.id])
	setActive(self.playBtn, false)
	setActive(self.playDesc, true)
	setActive(self.pauseBtn, true)
	setSlider(self.playProgressBar, 0, arg_61_1, 0)
	setText(self.totalTimeText, self:descTime(arg_61_1))
	setActive(self.nowTimeText, true)
	setActive(self.totalTimeText, true)

	return
end

function MusicCollectionView:updatePlayType(arg_62_1)
	arg_62_1 = arg_62_1 or getProxy(AppreciateProxy):getMusicPlayerLoopType()

	eachChild(self.playLoopBtn, function(arg_63_0, arg_63_1)
		setActive(arg_63_0, arg_63_0.name == arg_62_1)

		return
	end)

	return
end

function MusicCollectionView:updatePlayProgress(arg_64_1)
	self.playSliderSC:SetValueWithoutEvent(arg_64_1)
	setText(self.nowTimeText, self:descTime(arg_64_1))

	return
end

function MusicCollectionView:playPlateAni(arg_65_1, arg_65_2, arg_65_3, arg_65_4)
	self:setAniState(true)
	setActive(arg_65_1:Find("list"), true)

	function self.animCallback()
		self:setAniState(false)

		return
	end

	quickPlayAnimation(arg_65_1, "anim_MusicCollectionUI_Plate_expand")

	return
end

function MusicCollectionView:closePlateAni(arg_67_1)
	self:setAniState(true)

	function self.animCallback()
		setActive(arg_67_1:Find("list"), false)
		self:setAniState(false)

		return
	end

	quickPlayAnimation(arg_67_1, "anim_MusicCollectionUI_Plate_retract")

	return
end

function MusicCollectionView:setAniState(arg_69_1)
	self.isPlayingAni = arg_69_1

	return
end

function MusicCollectionView:openAlbumListPanel()
	setActive(self.albumListPanel, true)
	setActive(self.listBtn:Find("on"), true)
	setActive(self.listBtn:Find("off"), false)

	return
end

function MusicCollectionView:closeAlbumListPanel(arg_71_1)
	setActive(self.albumListPanel, false)
	setActive(self.listBtn:Find("on"), false)
	setActive(self.listBtn:Find("off"), true)

	return
end

function MusicCollectionView:checkupdateAlbumTF()
	if #self.albumTFList > 0 then
		self:updateAlbumTF(self.albumTFList[self.curMidddleIndex], self.curMidddleIndex)
	end

	return
end

function MusicCollectionView:NewMusicPlayer(arg_73_1, arg_73_2, arg_73_3)
	local var_73_0 = {}

	var_73_0.loopType = getProxy(AppreciateProxy):getMusicPlayerLoopType()
	var_73_0.albumName = arg_73_1
	var_73_0.list = arg_73_2 or nil
	var_73_0.index = arg_73_3 and table.indexof(arg_73_2, arg_73_3) or nil

	self.bgmMgr:TempPlay("TempMusicPlayer", var_73_0)

	self.musicPlayer = self.bgmMgr:GetMusicPlayer()

	return
end

function MusicCollectionView:ChangeLike(arg_74_1)
	self.likeDic[arg_74_1] = not self.likeDic[arg_74_1]

	if self.likeDic[arg_74_1] then
		table.insert(self.likeIds, arg_74_1)
	else
		table.removebyvalue(self.likeIds, arg_74_1)
	end

	return
end

function MusicCollectionView:tryPlayMusic()
	triggerButton(self.playBtn)

	return
end

function MusicCollectionView:tryPauseMusic()
	triggerButton(self.pauseBtn)

	return
end

function MusicCollectionView:descTime(arg_77_1)
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

return MusicCollectionView

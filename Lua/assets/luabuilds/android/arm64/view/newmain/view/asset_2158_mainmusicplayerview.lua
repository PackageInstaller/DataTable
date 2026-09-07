local MainMusicPlayerView = class("MainMusicPlayerView", import("view.base.BaseSubView"))

function MainMusicPlayerView:getUIName()
	return "MusicPlayer"
end

function MainMusicPlayerView:OnLoaded()
	self.rtPanel = self._tf:Find("panel")
	self.rtContainer = self.rtPanel:Find("view/container")
	self.playLoopBtn = self.rtContainer:Find("PlayTypeBtn")
	self.likeToggle = self.rtContainer:Find("LikeBtn")
	self.preBtn = self.rtContainer:Find("PreBtn")
	self.nextBtn = self.rtContainer:Find("NextBtn")
	self.btnExtend = self.rtPanel:Find("extend")
	self.btnIcon = self.rtContainer:Find("icon")

	return
end

function MainMusicPlayerView:OnInit()
	self.bgmMgr = pg.BgmMgr.GetInstance()

	onButton(self, self.btnExtend, function()
		self.isOpen = not self.isOpen

		setActive(self.btnExtend:Find("on"), not self.isOpen)
		setActive(self.btnExtend:Find("off"), self.isOpen)
		LeanTween.size(self.rtPanel, Vector2(self.isOpen and 460 or 130, self.rtPanel.sizeDelta.y), 0.3)

		return
	end, SFX_PANEL)
	onButton(self, self.preBtn, function()
		if not self.musicPlayer then
			return
		end

		self.musicPlayer:Last()

		return
	end, SFX_PANEL)
	onButton(self, self.nextBtn, function()
		if not self.musicPlayer then
			return
		end

		self.musicPlayer:Next()

		return
	end, SFX_PANEL)
	onButton(self, self.playLoopBtn, function()
		local var_7_0 = getProxy(AppreciateProxy):getMusicPlayerLoopType()

		switch(var_7_0, {
			list = function()
				var_7_0 = "random"

				return
			end,
			random = function()
				var_7_0 = "one"

				return
			end,
			one = function()
				var_7_0 = "list"

				return
			end
		})
		pg.m02:sendNotification(GAME.APPRECIATE_CHANGE_MUSIC_PLAY_LOOP_TYPE, {
			loopType = var_7_0
		})
		self:updatePlayType(var_7_0)

		if self.musicPlayer then
			self.musicPlayer:ChangeData({
				loopType = var_7_0
			})
		end

		return
	end, SFX_PANEL)
	onButton(self, self.likeToggle, function()
		pg.m02:sendNotification(GAME.APPRECIATE_MUSIC_LIKE, {
			musicID = pg.music_collect_config[self.musicPlayer:GetCurrentMusicId()].id,
			isAdd = self.isLike and 1 or 0
		})

		self.isLike = not self.isLike

		setActive(self.likeToggle:Find("On"), self.isLike)

		return
	end, SFX_PANEL)
	onButton(self, self.btnIcon, function()
		if not self.isOpen then
			return
		end

		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.COLLECTSHIP, {
			toggle = CollectionScene.MUSIC_INDEX
		})

		return
	end, SFX_PANEL)

	return
end

function MainMusicPlayerView:Show(arg_13_1)
	setActive(self.btnExtend, arg_13_1)

	self.isOpen = not arg_13_1

	setActive(self.btnExtend:Find("on"), not self.isOpen)
	setActive(self.btnExtend:Find("off"), self.isOpen)
	assert(self.bgmMgr:GetNow() == "MainMusicPlayer")

	self.musicPlayer = self.bgmMgr:GetMusicPlayer()
	self.isLike = getProxy(AppreciateProxy):isLikedByMusicID(self.musicPlayer:GetCurrentMusicId())

	self:UpdatePlayerDisplay()
	self:updatePlayType()
	self.bgmMgr:RegisterMusicCallback(self.__cname, "MainMusicPlayer", {
		startCall = function(arg_14_0)
			self.isLike = getProxy(AppreciateProxy):isLikedByMusicID(self.musicPlayer:GetCurrentMusicId())

			self:UpdatePlayerDisplay()

			return
		end
	})
	MainMusicPlayerView.super.Show(self)

	return
end

function MainMusicPlayerView:UpdatePlayerDisplay()
	GetImageSpriteFromAtlasAsync(MusicCollectionConst.MUSIC_COVER_PATH_PREFIX .. pg.music_album[pg.music_collect_config[self.musicPlayer:GetCurrentMusicId()].album_id].cover, "", self.rtContainer:Find("icon/face"), false)
	setActive(self.rtContainer:Find("LikeBtn/On"), self.isLike)

	return
end

function MainMusicPlayerView:updatePlayType(arg_16_1)
	arg_16_1 = arg_16_1 or getProxy(AppreciateProxy):getMusicPlayerLoopType()

	eachChild(self.playLoopBtn, function(arg_17_0, arg_17_1)
		setActive(arg_17_0, arg_17_0.name == arg_16_1)

		return
	end)

	return
end

function MainMusicPlayerView:OnDestroy()
	self.bgmMgr:UnregisterMusicCallback(self.__cname)

	self.bgmMgr = nil
	self.musicPlayer = nil

	return
end

return MainMusicPlayerView

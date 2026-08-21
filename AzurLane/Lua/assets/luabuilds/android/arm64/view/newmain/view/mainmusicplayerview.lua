local var_0_0 = class("MainMusicPlayerView", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "MusicPlayer"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.rtPanel = arg_2_0._tf:Find("panel")
	arg_2_0.rtContainer = arg_2_0.rtPanel:Find("view/container")
	arg_2_0.playLoopBtn = arg_2_0.rtContainer:Find("PlayTypeBtn")
	arg_2_0.likeToggle = arg_2_0.rtContainer:Find("LikeBtn")
	arg_2_0.preBtn = arg_2_0.rtContainer:Find("PreBtn")
	arg_2_0.nextBtn = arg_2_0.rtContainer:Find("NextBtn")
	arg_2_0.btnExtend = arg_2_0.rtPanel:Find("extend")
	arg_2_0.btnIcon = arg_2_0.rtContainer:Find("icon")

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.bgmMgr = pg.BgmMgr.GetInstance()

	onButton(arg_3_0, arg_3_0.btnExtend, function()
		arg_3_0.isOpen = not arg_3_0.isOpen

		setActive(arg_3_0.btnExtend:Find("on"), not arg_3_0.isOpen)
		setActive(arg_3_0.btnExtend:Find("off"), arg_3_0.isOpen)
		LeanTween.size(arg_3_0.rtPanel, Vector2(arg_3_0.isOpen and 460 or 130, arg_3_0.rtPanel.sizeDelta.y), 0.3)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.preBtn, function()
		if not arg_3_0.musicPlayer then
			return
		end

		arg_3_0.musicPlayer:Last()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.nextBtn, function()
		if not arg_3_0.musicPlayer then
			return
		end

		arg_3_0.musicPlayer:Next()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.playLoopBtn, function()
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
		arg_3_0:updatePlayType(var_7_0)

		if arg_3_0.musicPlayer then
			arg_3_0.musicPlayer:ChangeData({
				loopType = var_7_0
			})
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.likeToggle, function()
		pg.m02:sendNotification(GAME.APPRECIATE_MUSIC_LIKE, {
			musicID = pg.music_collect_config[arg_3_0.musicPlayer:GetCurrentMusicId()].id,
			isAdd = arg_3_0.isLike and 1 or 0
		})

		arg_3_0.isLike = not arg_3_0.isLike

		setActive(arg_3_0.likeToggle:Find("On"), arg_3_0.isLike)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.btnIcon, function()
		if not arg_3_0.isOpen then
			return
		end

		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.COLLECTSHIP, {
			toggle = CollectionScene.MUSIC_INDEX
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_13_0, arg_13_1)
	setActive(arg_13_0.btnExtend, arg_13_1)

	arg_13_0.isOpen = not arg_13_1

	setActive(arg_13_0.btnExtend:Find("on"), not arg_13_0.isOpen)
	setActive(arg_13_0.btnExtend:Find("off"), arg_13_0.isOpen)
	assert(arg_13_0.bgmMgr:GetNow() == "MainMusicPlayer")

	arg_13_0.musicPlayer = arg_13_0.bgmMgr:GetMusicPlayer()
	arg_13_0.isLike = getProxy(AppreciateProxy):isLikedByMusicID(arg_13_0.musicPlayer:GetCurrentMusicId())

	arg_13_0:UpdatePlayerDisplay()
	arg_13_0:updatePlayType()
	arg_13_0.bgmMgr:RegisterMusicCallback(arg_13_0.__cname, "MainMusicPlayer", {
		startCall = function(arg_14_0)
			arg_13_0.isLike = getProxy(AppreciateProxy):isLikedByMusicID(arg_13_0.musicPlayer:GetCurrentMusicId())

			arg_13_0:UpdatePlayerDisplay()

			return
		end
	})
	var_0_0.super.Show(arg_13_0)

	return
end

function var_0_0.UpdatePlayerDisplay(arg_15_0)
	GetImageSpriteFromAtlasAsync(MusicCollectionConst.MUSIC_COVER_PATH_PREFIX .. pg.music_album[pg.music_collect_config[arg_15_0.musicPlayer:GetCurrentMusicId()].album_id].cover, "", arg_15_0.rtContainer:Find("icon/face"), false)
	setActive(arg_15_0.rtContainer:Find("LikeBtn/On"), arg_15_0.isLike)

	return
end

function var_0_0.updatePlayType(arg_16_0, arg_16_1)
	arg_16_1 = arg_16_1 or getProxy(AppreciateProxy):getMusicPlayerLoopType()

	eachChild(arg_16_0.playLoopBtn, function(arg_17_0, arg_17_1)
		setActive(arg_17_0, arg_17_0.name == arg_16_1)

		return
	end)

	return
end

function var_0_0.OnDestroy(arg_18_0)
	arg_18_0.bgmMgr:UnregisterMusicCallback(arg_18_0.__cname)

	arg_18_0.bgmMgr = nil
	arg_18_0.musicPlayer = nil

	return
end

return var_0_0

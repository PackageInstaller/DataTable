pg = pg or {}

local var_0_0 = pg

pg.BgmMgr = singletonClass("BgmMgr")

function pg.BgmMgr.Ctor(arg_1_0)
	return
end

function pg.BgmMgr.Init(arg_2_0, arg_2_1)
	print("initializing bgm manager...")
	arg_2_0:Clear()
	arg_2_1()

	return
end

function pg.BgmMgr.Clear(arg_3_0)
	arg_3_0._stack = {}
	arg_3_0._dictionary = {}
	arg_3_0._musicData = {}
	arg_3_0._musicCallbackDic = {}

	return
end

function pg.BgmMgr.Push(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_0._dictionary[arg_4_1] then
		table.insert(arg_4_0._stack, arg_4_1)
	end

	arg_4_0._dictionary[arg_4_1] = arg_4_2
	arg_4_0._musicData[arg_4_1] = arg_4_3

	arg_4_0:CheckPlay()

	return
end

function pg.BgmMgr.Pop(arg_5_0, arg_5_1)
	if arg_5_0._dictionary[arg_5_1] then
		table.removebyvalue(arg_5_0._stack, arg_5_1)

		arg_5_0._dictionary[arg_5_1] = nil
		arg_5_0._musicData[arg_5_1] = nil

		arg_5_0:CheckPlay()
	end

	return
end

function pg.BgmMgr.CheckPlay(arg_6_0)
	if #arg_6_0._stack == 0 then
		return
	end

	local var_6_0 = arg_6_0._musicData[arg_6_0._stack[#arg_6_0._stack]]

	if arg_6_0.isDirty or arg_6_0._now ~= arg_6_0._dictionary[arg_6_0._stack[#arg_6_0._stack]] then
		arg_6_0._now = arg_6_0._dictionary[arg_6_0._stack[#arg_6_0._stack]]
		arg_6_0._nowData = var_6_0

		arg_6_0:ContinuePlay()
	end

	return
end

function pg.BgmMgr.TempPlay(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.isDirty = true

	arg_7_0:FinalPlay(arg_7_1, arg_7_2)

	return
end

function pg.BgmMgr.StopPlay(arg_8_0)
	arg_8_0.isDirty = true

	arg_8_0:FinalPause()

	return
end

function pg.BgmMgr.ContinuePlay(arg_9_0)
	arg_9_0.isDirty = false

	arg_9_0:FinalPlay(arg_9_0._now, arg_9_0._nowData)

	return
end

function pg.BgmMgr.RegisterMusicCallback(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	for iter_10_0, iter_10_1 in pairs(arg_10_3) do
		arg_10_0._musicCallbackDic[iter_10_0] = arg_10_0._musicCallbackDic[iter_10_0] or {}
		arg_10_0._musicCallbackDic[iter_10_0][arg_10_2] = arg_10_0._musicCallbackDic[iter_10_0][arg_10_2] or {}

		table.insert(arg_10_0._musicCallbackDic[iter_10_0][arg_10_2], {
			iter_10_1,
			arg_10_1
		})
	end

	return
end

function pg.BgmMgr.UnregisterMusicCallback(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_0._musicCallbackDic) do
		for iter_11_2, iter_11_3 in pairs(iter_11_1) do
			for iter_11_4 = #iter_11_3, 1, -1 do
				if iter_11_3[iter_11_4][2] == arg_11_1 then
					table.remove(iter_11_3, iter_11_4)
				end
			end
		end
	end

	return
end

function pg.BgmMgr.GetNow(arg_12_0)
	return arg_12_0._now, arg_12_0._nowData
end

function pg.BgmMgr.GetPlayType(arg_13_0, arg_13_1)
	return switch(arg_13_1, {
		MainMusicPlayer = function()
			return "music"
		end,
		TempMusicPlayer = function()
			return "music"
		end
	}, function()
		return "bgm"
	end)
end

function pg.BgmMgr.FinalPlay(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_1 then
		return
	end

	local var_17_0 = arg_17_0:GetPlayType(arg_17_1)

	if arg_17_0.playType and arg_17_0.playType ~= var_17_0 then
		arg_17_0:FinalPause()
	end

	arg_17_0.playType = var_17_0

	if arg_17_0.playType == "music" then
		switch(arg_17_1, {
			MainMusicPlayer = function()
				arg_17_0:PlayMainMusicPlayer(arg_17_2, arg_17_1)

				return
			end,
			TempMusicPlayer = function()
				arg_17_0:NewMusicPlayer(arg_17_2, arg_17_1)

				return
			end
		})
	elseif arg_17_0.playType == "bgm" then
		var_0_0.CriMgr.GetInstance():PlayBGM(arg_17_1)
	end

	return
end

function pg.BgmMgr.FinalPause(arg_20_0)
	if arg_20_0.playType == "music" then
		arg_20_0.musicPlayer:Pause()
	elseif arg_20_0.playType == "bgm" then
		var_0_0.CriMgr.GetInstance():StopBGM()
	end

	return
end

function pg.BgmMgr.GetMusicPlayer(arg_21_0)
	return arg_21_0.musicPlayer
end

function pg.BgmMgr.PlayMainMusicPlayer(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0.musicPlayer and arg_22_0.musicPlayer.music == arg_22_2 then
		arg_22_0.musicPlayer:ChangeData(arg_22_1)

		arg_22_0.musicPlayer.music = arg_22_2

		if arg_22_0.musicPlayer:IsPaused() then
			arg_22_0.musicPlayer:Resume()
		else
			arg_22_0.musicPlayer:Reflush(arg_22_0.musicPlayer.index)
		end

		return arg_22_0.musicPlayer
	else
		return arg_22_0:NewMusicPlayer(arg_22_1, arg_22_2)
	end

	return
end

function pg.BgmMgr.NewMusicPlayer(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0:RemoveMusicPlayer()

	for iter_23_0, iter_23_1 in pairs(MusicPlayer.CALLBACK_DIC) do
		({})[iter_23_0] = function(...)
			for iter_24_0, iter_24_1 in ipairs(checkExist(arg_23_0._musicCallbackDic, {
				iter_23_0
			}, {
				arg_23_2
			}) or {}) do
				iter_24_1[1](...)
			end

			return
		end
	end

	arg_23_0.musicPlayer = MusicPlayer.New(arg_23_1, {})
	arg_23_0.musicPlayer.music = arg_23_2

	return arg_23_0.musicPlayer
end

function pg.BgmMgr.RemoveMusicPlayer(arg_25_0)
	if not arg_25_0.musicPlayer then
		return
	end

	arg_25_0.musicPlayer:Dispose()

	arg_25_0.musicPlayer = nil

	return
end

return

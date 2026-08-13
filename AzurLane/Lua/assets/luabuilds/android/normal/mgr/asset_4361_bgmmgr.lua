pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.BgmMgr = var_0_10001("BgmMgr")

local var_0_1 = var_0.BgmMgr

function var_0_1.Ctor(arg_1_0)
	return
end

function var_0_1.Init(arg_2_0, arg_2_1)
	print = var_1_10002

	var_1_10002("initializing bgm manager...")
	arg_2_0:Clear()
	arg_2_1()

	return
end

function var_0_1.Clear(arg_3_0)
	arg_3_0._stack = {}
	arg_3_0._dictionary = {}
	arg_3_0._musicData = {}
	arg_3_0._musicCallbackDic = {}

	return
end

function var_0_1.Push(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_0._dictionary[arg_4_1] then
		table = var_4

		var_4.insert(arg_4_0._stack, arg_4_1)
	end

	arg_4_0._dictionary[arg_4_1] = arg_4_2
	arg_4_0._musicData[arg_4_1] = arg_4_3

	arg_4_0:CheckPlay()

	return
end

function var_0_1.Pop(arg_5_0, arg_5_1)
	if arg_5_0._dictionary[arg_5_1] then
		table = var_2

		var_2.removebyvalue(arg_5_0._stack, arg_5_1)

		arg_5_0._dictionary[arg_5_1] = nil
		arg_5_0._musicData[arg_5_1] = nil

		arg_5_0:CheckPlay()
	end

	return
end

function var_0_1.CheckPlay(arg_6_0)
	if #arg_6_0._stack == 0 then
		return
	end

	local var_6_0 = arg_6_0._stack[#arg_6_0._stack]
	local var_6_1 = arg_6_0._dictionary[var_6_0]
	local var_6_2 = arg_6_0._musicData[var_6_0]

	if arg_6_0.isDirty or arg_6_0._now ~= var_6_1 then
		arg_6_0._now = var_6_1
		arg_6_0._nowData = var_6_2

		arg_6_0:ContinuePlay()
	end

	return
end

function var_0_1.TempPlay(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.isDirty = true

	arg_7_0:FinalPlay(arg_7_1, arg_7_2)

	return
end

function var_0_1.StopPlay(arg_8_0)
	arg_8_0.isDirty = true

	arg_8_0:FinalPause()

	return
end

function var_0_1.ContinuePlay(arg_9_0)
	arg_9_0.isDirty = false

	arg_9_0:FinalPlay(arg_9_0._now, arg_9_0._nowData)

	return
end

function var_0_1.RegisterMusicCallback(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	pairs = var_1_10004

	for iter_10_0, iter_10_1 in var_1_10004(arg_10_3) do
		local var_10_0 = arg_10_0._musicCallbackDic
		local var_10_1

		if not arg_10_0._musicCallbackDic[iter_10_0] then
			var_10_1 = {}
		end

		var_10_0[iter_10_0] = var_10_1

		local var_10_2 = arg_10_0._musicCallbackDic[iter_10_0]
		local var_10_3

		if not arg_10_0._musicCallbackDic[iter_10_0][arg_10_2] then
			var_10_3 = {}
		end

		var_10_2[arg_10_2] = var_10_3
		table = var_10_2

		var_10_2.insert(arg_10_0._musicCallbackDic[iter_10_0][arg_10_2], {
			iter_10_1,
			arg_10_1
		})
	end

	return
end

function var_0_1.UnregisterMusicCallback(arg_11_0, arg_11_1)
	pairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_0._musicCallbackDic) do
		pairs = var_1_10007

		for iter_11_2, iter_11_3 in var_1_10007(iter_11_1) do
			for iter_11_4 = #iter_11_3, 1, -1 do
				if iter_11_3[iter_11_4][2] == arg_11_1 then
					table = var_16

					var_16.remove(iter_11_3, iter_11_4)
				end
			end
		end
	end

	return
end

function var_0_1.GetNow(arg_12_0)
	return arg_12_0._now, arg_12_0._nowData
end

function var_0_1.GetPlayType(arg_13_0, arg_13_1)
	switch = var_1_10002

	return var_1_10002(arg_13_1, {
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

function var_0_1.FinalPlay(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_1 then
		return
	end

	local var_17_0 = arg_17_0:GetPlayType(arg_17_1)

	if arg_17_0.playType and arg_17_0.playType ~= var_17_0 then
		arg_17_0:FinalPause()
	end

	arg_17_0.playType = var_17_0

	if arg_17_0.playType == "music" then
		switch = var_4

		var_4(arg_17_1, {
			MainMusicPlayer = function()
				local var_18_0 = arg_17_0

				var_0.PlayMainMusicPlayer(var_18_0, arg_17_2, arg_17_1)

				return
			end,
			TempMusicPlayer = function()
				local var_19_0 = arg_17_0

				var_0.NewMusicPlayer(var_19_0, arg_17_2, arg_17_1)

				return
			end
		})
	elseif arg_17_0.playType == "bgm" then
		local var_17_1 = var_0.CriMgr.GetInstance()

		var_4.PlayBGM(var_17_1, arg_17_1)
	end

	return
end

function var_0_1.FinalPause(arg_20_0)
	if arg_20_0.playType == "music" then
		local var_20_0 = arg_20_0.musicPlayer

		var_1.Pause(var_20_0)
	elseif arg_20_0.playType == "bgm" then
		local var_20_1 = var_0.CriMgr.GetInstance()

		var_1.StopBGM(var_20_1)
	end

	return
end

function var_0_1.GetMusicPlayer(arg_21_0)
	return arg_21_0.musicPlayer
end

function var_0_1.PlayMainMusicPlayer(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0.musicPlayer and arg_22_0.musicPlayer.music == arg_22_2 then
		local var_22_0 = arg_22_0.musicPlayer

		var_3.ChangeData(var_22_0, arg_22_1)

		arg_22_0.musicPlayer.music = arg_22_2

		local var_22_1 = arg_22_0.musicPlayer

		if var_3.IsPaused(var_22_1) then
			local var_22_2 = arg_22_0.musicPlayer

			var_3.Resume(var_22_2)
		else
			local var_22_3 = arg_22_0.musicPlayer

			var_3.Reflush(var_22_3, arg_22_0.musicPlayer.index)
		end

		return arg_22_0.musicPlayer
	else
		return arg_22_0:NewMusicPlayer(arg_22_1, arg_22_2)
	end

	return
end

function var_0_1.NewMusicPlayer(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0

	arg_23_0.RemoveMusicPlayer(var_23_0)

	local var_23_1 = {}

	pairs = var_23_0
	MusicPlayer = var_1_10005

	for iter_23_0, iter_23_1 in var_23_0(var_1_10005.CALLBACK_DIC) do
		var_23_1[iter_23_0] = function(...)
			checkExist = var_2_10000

			local var_24_0 = var_2_10000(arg_23_0._musicCallbackDic, {
				iter_23_0
			}, {
				arg_23_2
			})

			ipairs = var_1

			for iter_24_0, iter_24_1 in var_1(var_24_0 or {}) do
				iter_24_1[1](...)
			end

			return
		end
	end

	MusicPlayer = var_4
	arg_23_0.musicPlayer = var_4.New(arg_23_1, var_23_1)
	arg_23_0.musicPlayer.music = arg_23_2

	return arg_23_0.musicPlayer
end

function var_0_1.RemoveMusicPlayer(arg_25_0)
	if not arg_25_0.musicPlayer then
		return
	end

	local var_25_0 = arg_25_0.musicPlayer

	var_1.Dispose(var_25_0)

	arg_25_0.musicPlayer = nil

	return
end

return

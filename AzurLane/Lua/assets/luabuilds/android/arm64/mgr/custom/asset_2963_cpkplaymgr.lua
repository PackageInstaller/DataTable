pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.CpkPlayMgr = var_0_10001("CpkPlayMgr")
pg = var_0

local var_0_1 = var_0.CpkPlayMgr

function var_0_1.Ctor(arg_1_0)
	arg_1_0._onPlaying = false
	arg_1_0._mainTF = nil
	arg_1_0._closeLimit = nil
	arg_1_0._animator = nil
	arg_1_0._timer = nil
	arg_1_0._criUsm = nil
	arg_1_0._criCpk = nil
	arg_1_0._stopGameBGM = false

	return
end

function var_0_1.Reset(arg_2_0)
	arg_2_0._onPlaying = false
	arg_2_0._mainTF = nil
	arg_2_0._closeLimit = nil
	arg_2_0._animator = nil
	arg_2_0._criUsm = nil
	arg_2_0._criCpk = nil
	arg_2_0._stopGameBGM = false
	arg_2_0._timer = nil

	return
end

function var_0_1.OnPlaying(arg_3_0)
	return arg_3_0._onPlaying
end

function var_0_1.PlayCpkMovie(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7, arg_4_8)
	pg = var_1_10009

	var_1_10009.DelegateInfo.New(arg_4_0)

	arg_4_0._onPlaying = true
	arg_4_0._stopGameBGM = arg_4_6
	pg = var_9

	local var_4_0 = var_9.UIMgr.GetInstance()

	var_9.LoadingOn(var_4_0)

	local function var_4_1()
		if arg_4_0.debugTimer then
			local var_5_0 = arg_4_0.debugTimer

			var_0.Stop(var_5_0)
		end

		if not arg_4_0._mainTF then
			return
		end

		if not arg_4_8 then
			Time = var_0

			if var_0.realtimeSinceStartup < arg_4_0._closeLimit then
				return
			end
		end

		setActive = var_0

		var_0(arg_4_0._mainTF, false)

		local var_5_1 = arg_4_0

		var_0.DisposeCpkMovie(var_5_1)

		if arg_4_2 then
			arg_4_2()
		end

		return
	end

	local function var_4_2()
		onButton = var_2_10000

		var_2_10000(arg_4_0, arg_4_0._mainTF, function()
			if arg_4_5 then
				var_4_1()
			end

			return
		end)

		local var_6_2

		if arg_4_0._criUsm then
			local var_6_0 = arg_4_0._criUsm.player
			local var_6_1 = var_0.SetVolume

			PlayerPrefs = var_6_2
			var_6_2 = var_6_2.GetFloat

			local var_6_3 = "bgm_vol"

			DEFAULT_BGMVOLUME = var_2_10006

			var_6_1(var_6_0, var_6_2(var_6_3, var_2_10006))

			local var_6_4 = arg_4_0._criUsm.player

			var_0.SetShaderDispatchCallback(var_6_4, function(arg_8_0, arg_8_1)
				local var_8_0 = arg_4_0

				var_2.CheckRatioFitter(var_8_0)

				local var_8_1 = arg_4_0

				var_2.checkBgmStop(var_8_1, arg_8_0)

				return nil
			end)
		end

		if arg_4_0._criCpk then
			local var_6_5 = arg_4_0._criCpk.player
			local var_6_6 = var_0.SetVolume

			PlayerPrefs = var_6_2

			local var_6_7 = var_6_2.GetFloat
			local var_6_8 = "bgm_vol"

			DEFAULT_BGMVOLUME = var_2_10006

			var_6_6(var_6_5, var_6_7(var_6_8, var_2_10006))

			local var_6_9 = arg_4_0._criCpk.player

			var_0.SetShaderDispatchCallback(var_6_9, function(arg_9_0, arg_9_1)
				local var_9_0 = arg_4_0

				var_2.CheckRatioFitter(var_9_0)

				local var_9_1 = arg_4_0

				var_2.checkBgmStop(var_9_1, arg_9_0)

				return nil
			end)
		end

		local var_6_10

		if arg_4_0._animator ~= nil then
			var_6_10 = arg_4_0._animator
			var_6_10.enabled = true

			local var_6_11 = arg_4_0._mainTF
			local var_6_12 = var_6_10.GetComponent(var_6_11, "DftAniEvent")

			var_6_10.SetStartEvent(var_6_12, function(arg_10_0)
				if arg_4_0._criUsm then
					local var_10_0 = arg_4_0._criUsm

					var_1.Play(var_10_0)
				end

				return
			end)
			var_6_10:SetEndEvent(function(arg_11_0)
				var_4_1()

				return
			end)
		else
			var_6_10 = arg_4_0
			Timer = var_2_10001
			var_6_10._timer = var_2_10001.New(var_4_1, arg_4_7)

			local var_6_13 = arg_4_0._timer

			var_6_10.Start(var_6_13)
		end

		setActive = var_6_10

		var_6_10(arg_4_0._mainTF, true)

		if arg_4_0._stopGameBGM then
			pg = var_0

			local var_6_14 = var_0.BgmMgr.GetInstance()

			var_0.StopPlay(var_6_14)
		end

		if arg_4_1 then
			arg_4_1()
		end

		return
	end

	IsNil = var_4_0

	if var_4_0(arg_4_0._mainTF) then
		LoadAndInstantiateAsync = var_11

		var_11(arg_4_3, arg_4_4, function(arg_12_0)
			pg = var_2_10001

			local var_12_0 = var_2_10001.UIMgr.GetInstance()

			var_1.LoadingOff(var_12_0)

			local var_12_1 = arg_4_0

			Time = var_2_10002
			var_12_1._closeLimit = var_2_10002.realtimeSinceStartup + 1

			if not arg_4_0._onPlaying then
				Destroy = var_1

				var_1(arg_12_0)

				return
			end

			local var_12_2 = arg_4_0
			local var_12_3

			if not arg_4_0._parentTF then
				GameObject = var_12_3
				var_12_3 = var_12_3.Find("UICamera/Canvas")
			end

			var_12_2._parentTF = var_12_3
			setParent = var_12_2

			var_12_2(arg_12_0, arg_4_0._parentTF)

			arg_4_0._ratioFitter = arg_12_0:GetComponent("AspectRatioFitter")

			local var_12_4 = arg_4_0

			var_12_4._mainTF = arg_12_0
			pg = var_12_4

			local var_12_5 = var_12_4.UIMgr.GetInstance()

			var_1.OverlayPanel(var_12_5, arg_4_0._mainTF.transform)

			local var_12_6 = arg_4_0

			tf = var_2

			local var_12_7 = var_2(arg_4_0._mainTF)
			local var_12_8 = var_2.Find(var_12_7, "usm")

			var_12_6._criUsm = var_2.GetComponent(var_12_8, "CriManaEffectUI")

			local var_12_9 = arg_4_0

			tf = var_2

			local var_12_10 = var_2(arg_4_0._mainTF)
			local var_12_11 = var_2.Find(var_12_10, "usm")

			var_12_9._criCpk = var_2.GetComponent(var_12_11, "CriManaCpkUI")

			local var_12_12 = arg_4_0

			tf = var_2

			local var_12_13 = var_2(arg_4_0._mainTF)
			local var_12_14 = var_2.Find(var_12_13, "usm")

			var_12_12._usmImg = var_2.GetComponent(var_12_14, "Image")

			local var_12_15 = arg_4_0
			local var_12_16 = arg_4_0._mainTF

			var_12_15._animator = var_2.GetComponent(var_12_16, "Animator")

			if arg_4_0._criUsm then
				local var_12_17 = arg_4_0._criUsm

				CriWare = var_2
				var_12_17.renderMode = var_2.CriManaMovieMaterialBase.RenderMode.Always
			end

			if arg_4_0._usmImg and arg_4_0._usmImg.color.a == 0 then
				local var_12_18 = arg_4_0._usmImg

				Color = var_2
				var_12_18.color = var_2.New(1, 1, 1, 0.1)
			end

			var_4_2()

			return
		end)
	else
		var_4_2()
	end

	return
end

function var_0_1.CheckRatioFitter(arg_13_0)
	if arg_13_0._ratioFitter then
		arg_13_0._ratioFitter.enabled = true
		arg_13_0._ratioFitter = nil
	end

	return
end

function var_0_1.checkBgmStop(arg_14_0, arg_14_1)
	if arg_14_0._onPlaying and arg_14_1.numAudioStreams and 0 < var_2 then
		pg = var_3

		local var_14_0 = var_3.BgmMgr.GetInstance()

		var_3.StopPlay(var_14_0)

		arg_14_0._stopGameBGM = true
	end

	return
end

function var_0_1.DisposeCpkMovie(arg_15_0)
	if arg_15_0._onPlaying then
		if arg_15_0._mainTF then
			pg = var_1

			local var_15_0 = var_1.UIMgr.GetInstance()

			var_1.UnOverlayPanel(var_15_0, arg_15_0._mainTF.transform, arg_15_0._tf)

			Destroy = var_1

			var_1(arg_15_0._mainTF)

			if arg_15_0._animator ~= nil then
				arg_15_0._animator.enabled = false
			end

			if arg_15_0._timer ~= nil then
				local var_15_1 = arg_15_0._timer

				var_1.Stop(var_15_1)

				arg_15_0._timer = nil
			end

			if arg_15_0._criUsm then
				local var_15_2 = arg_15_0._criUsm

				var_1.Stop(var_15_2)
			end

			if arg_15_0._stopGameBGM then
				pg = var_1

				local var_15_3 = var_1.BgmMgr.GetInstance()

				var_1.ContinuePlay(var_15_3)
			end

			arg_15_0._onPlaying = false
			pg = var_1

			var_1.DelegateInfo.Dispose(arg_15_0)
		end

		arg_15_0:Reset()
	end

	return
end

return

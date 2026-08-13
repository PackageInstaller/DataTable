class = var_0_10000

local var_0_0 = var_0_10000("NewEducateCpkHandler")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.GetComponent

	typeof = var_1_10004
	Animation = var_1_10005
	arg_1_0._anim = var_1_1(var_1_0, var_1_10004(var_1_10005))

	local var_1_2 = arg_1_0._tf

	arg_1_0.bgTF = var_2.Find(var_1_2, "bg")

	local var_1_3 = arg_1_0.bgTF

	arg_1_0.nameTF = var_2.Find(var_1_3, "name")

	local var_1_4 = arg_1_0.bgTF

	arg_1_0.sliderTF = var_2.Find(var_1_4, "slider")

	local var_1_5 = arg_1_0.bgTF
	local var_1_6 = var_2.Find(var_1_5, "cpk/usm")
	local var_1_7 = var_2.GetComponent

	typeof = var_4
	CriManaCpkUI = var_1_10005
	arg_1_0.cpkPlayer = var_1_7(var_1_6, var_4(var_1_10005))

	local var_1_8 = arg_1_0.cpkPlayer
	local var_1_9 = var_2.SetMaxFrameDrop

	CriWare = var_4

	var_1_9(var_1_8, var_4.CriManaMovieMaterialBase.MaxFrameDrop.Infinite)

	local var_1_10 = arg_1_0.bgTF

	arg_1_0.cpkCoverTF = var_2.Find(var_1_10, "cpk_cover")
	Application = var_2

	local var_1_11

	if not var_2.targetFrameRate then
		var_1_11 = 60
	end

	arg_1_0.frameRate = var_1_11

	return
end

function var_0_0.SetCriManaCpkUIParam(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.cpkPlayer

	string = var_1_10003
	var_2_0.cpkPath = var_1_10003.lower("OriginSource/cpk/" .. arg_2_1 .. ".cpk")

	local var_2_1 = arg_2_0.cpkPlayer

	string = var_3
	var_2_1.movieName = var_3.lower(arg_2_1 .. ".bytes")

	return
end

function var_0_0.Play(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	setActive = var_1_10004

	var_1_10004(arg_3_0._go, true)

	if arg_3_0._anim then
		local var_3_0 = arg_3_0._anim

		var_4.Play(var_3_0)
	end

	local var_3_1 = arg_3_0.cpkPlayer

	var_4.StopCpk(var_3_1)

	setText = var_4

	var_4(arg_3_0.nameTF, arg_3_3 or "")
	arg_3_0:SetCriManaCpkUIParam(arg_3_1)

	local var_3_2 = arg_3_0.cpkPlayer

	var_4.SetCpkTotalTimeCallback(var_3_2, function(arg_4_0)
		arg_3_0.totalTime = arg_4_0

		local var_4_0 = arg_3_0

		var_1.OnStartCpk(var_4_0)

		return
	end)

	local var_3_3 = arg_3_0.cpkPlayer

	var_4.SetPlayEndHandler(var_3_3, function()
		existCall = var_2_10000

		var_2_10000(arg_3_2)

		local var_5_0 = arg_3_0

		var_0.OnEndCpk(var_5_0)

		return
	end)

	local var_3_4 = arg_3_0.cpkPlayer

	var_4.PlayCpk(var_3_4)

	return
end

function var_0_0.OnStartCpk(arg_6_0)
	setSlider = var_1_10001

	var_1_10001(arg_6_0.sliderTF, 0, 1, 0)

	arg_6_0.passTime = 0
	Timer = var_1
	arg_6_0.timer = var_1.New(function()
		local var_7_0 = arg_6_0

		var_7_0.passTime = arg_6_0.passTime + 1 / arg_6_0.frameRate
		setSlider = var_7_0

		var_7_0(arg_6_0.sliderTF, 0, 1, arg_6_0.passTime / arg_6_0.totalTime)

		return
	end, 1 / arg_6_0.frameRate, -1)

	local var_6_0 = arg_6_0.timer

	var_1.Start(var_6_0)

	return
end

function var_0_0.OnEndCpk(arg_8_0)
	setSlider = var_1_10001

	var_1_10001(arg_8_0.sliderTF, 0, 1, 1)

	if arg_8_0.timer ~= nil then
		local var_8_0 = arg_8_0.timer

		var_1.Stop(var_8_0)

		arg_8_0.timer = nil
	end

	local var_8_1 = arg_8_0.cpkPlayer

	var_1.SetPlayEndHandler(var_8_1, nil)

	return
end

function var_0_0.SetUIParam(arg_9_0, arg_9_1)
	setAnchoredPosition = var_1_10002

	local var_9_0 = arg_9_0.bgTF
	local var_9_1

	if not arg_9_1 or not {
		x = 146,
		y = -45
	} then
		var_9_1 = {
			x = 0,
			y = 0
		}
	end

	var_1_10002(var_9_0, var_9_1)

	GetComponent = var_1_10002

	local var_9_2 = arg_9_0.bgTF

	typeof = var_9_1
	Image = var_1_10005
	var_1_10002(var_9_2, var_9_1(var_1_10005)).enabled = not arg_9_1

	return
end

function var_0_0.Reset(arg_10_0)
	setActive = var_1_10001

	var_1_10001(arg_10_0._go, false)

	return
end

function var_0_0.Destroy(arg_11_0)
	return
end

return var_0_0

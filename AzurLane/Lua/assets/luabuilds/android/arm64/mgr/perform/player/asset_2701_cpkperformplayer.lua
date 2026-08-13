class = var_0_10000

local var_0_0 = "CpkPerformPlayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BasePerformPlayer"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0._tf

	arg_1_0.bgTF = var_2.Find(var_1_0, "bg")

	local var_1_1 = arg_1_0.bgTF

	arg_1_0.nameTF = var_2.Find(var_1_1, "name")

	local var_1_2 = arg_1_0.bgTF

	arg_1_0.sliderTF = var_2.Find(var_1_2, "slider")

	local var_1_3 = arg_1_0.bgTF

	arg_1_0.cpkParentTF = var_2.Find(var_1_3, "cpk")

	local var_1_4 = arg_1_0.bgTF

	arg_1_0.cpkCoverTF = var_2.Find(var_1_4, "cpk_cover")
	Application = var_2

	local var_1_5

	if not var_2.targetFrameRate then
		var_1_5 = 60
	end

	arg_1_0.frameRate = var_1_5
	pg = var_1_5
	arg_1_0.maxStage = #var_1_5.child_data[1].stage
	arg_1_0.personalityIds = var_2.attr_2_list

	return
end

function var_0_1.getCpkName(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	EducateProxy = var_1_10004

	local var_2_0 = var_1_10002(var_1_10004)
	local var_2_1 = var_2.GetCharData(var_2_0)

	if var_2.GetStage(var_2_1) < arg_2_0.maxStage then
		return arg_2_1[var_2]
	elseif var_2 == arg_2_0.maxStage then
		getProxy = var_3
		EducateProxy = var_1_10005

		local var_2_2 = var_3(var_1_10005)
		local var_2_3 = var_3.GetPersonalityId(var_2_2)

		table = var_2_1

		local var_2_4 = var_2_1.indexof(arg_2_0.personalityIds, var_2_3)

		return arg_2_1[var_2][var_2_4]
	end

	return ""
end

function var_0_1.Play(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0:Show()

	if arg_3_3 then
		setText = var_4

		var_4(arg_3_0.nameTF, arg_3_3)
	end

	setActive = var_4

	local var_3_0 = arg_3_0.bgTF

	IsNil = var_1_10007

	var_4(var_3_0, not var_1_10007(arg_3_0.cpkTF))

	local var_3_1 = arg_3_0
	local var_3_2

	if not arg_3_0.getCpkName(var_3_1, arg_3_1.param[1]) then
		var_3_2 = ""
	end

	local var_3_3

	if not arg_3_1.param[2] then
		var_3_3 = 3
	end

	checkABExist = var_3_1

	if var_3_1("educateanim/" .. var_3_2) then
		LoadAnyAsync = var_7

		var_7("educateanim/" .. var_3_2, "", nil, function(arg_4_0)
			Object = var_2_10001

			local var_4_0 = var_2_10001.Instantiate(arg_4_0, arg_3_0.cpkParentTF)

			setActive = var_2_10002

			var_2_10002(arg_3_0.bgTF, true)

			local var_4_1 = arg_3_0
			local var_4_2 = var_4_0.transform
			local var_4_3 = var_3.Find(var_4_2, "usm")
			local var_4_4 = var_3.GetComponent

			typeof = var_6
			CriManaCpkUI = var_2_10008
			var_4_1.player = var_4_4(var_4_3, var_6(var_2_10008))
			arg_3_0.time = var_3_3

			local var_4_5 = arg_3_0.cpkTF

			arg_3_0.cpkTF = var_4_0

			local var_4_6 = arg_3_0.player

			var_3.SetPlayEndHandler(var_4_6, function()
				if arg_3_2 then
					arg_3_2()
				end

				local var_5_0 = arg_3_0

				var_0.onCpkEnd(var_5_0)

				return
			end)

			if arg_3_0._anim then
				local var_4_7 = arg_3_0._anim

				var_3.Play(var_4_7)
			end

			local var_4_8 = arg_3_0.player
			local var_4_9 = var_3.SetMaxFrameDrop

			CriWare = var_6

			var_4_9(var_4_8, var_6.CriManaMovieMaterialBase.MaxFrameDrop.Infinite)

			local var_4_10 = arg_3_0.player

			var_3.SetCpkTotalTimeCallback(var_4_10, function(arg_6_0)
				arg_3_0.time = arg_6_0

				local var_6_0 = arg_3_0

				var_1.onCpkStart(var_6_0, arg_6_0)

				return
			end)

			local var_4_11 = arg_3_0.player

			var_3.PlayerManualUpdate(var_4_11)

			local var_4_12 = arg_3_0.player

			var_3.PlayCpk(var_4_12)

			IsNil = var_3

			if not var_3(var_4_5) then
				Destroy = var_3

				var_3(var_4_5)
			end

			return
		end)
	elseif arg_3_2 then
		arg_3_2()
	end

	return
end

function var_0_1.onCpkStart(arg_7_0, arg_7_1)
	setSlider = var_1_10002

	var_1_10002(arg_7_0.sliderTF, 0, 1, 0)

	arg_7_0.playingTime = 0
	Timer = var_2
	arg_7_0.timer = var_2.New(function()
		local var_8_0 = arg_7_0

		var_8_0.playingTime = arg_7_0.playingTime + 1 / arg_7_0.frameRate
		setSlider = var_8_0

		var_8_0(arg_7_0.sliderTF, 0, 1, arg_7_0.playingTime / arg_7_1)

		return
	end, 1 / arg_7_0.frameRate, -1)

	local var_7_0 = arg_7_0.timer

	var_2.Start(var_7_0)

	return
end

function var_0_1.onCpkEnd(arg_9_0)
	setSlider = var_1_10001

	var_1_10001(arg_9_0.sliderTF, 0, 1, 1)

	if arg_9_0.timer ~= nil then
		local var_9_0 = arg_9_0.timer

		var_1.Stop(var_9_0)

		arg_9_0.timer = nil
	end

	return
end

function var_0_1.SetUIParam(arg_10_0, arg_10_1)
	setAnchoredPosition = var_1_10002

	var_1_10002(arg_10_0.sliderTF, arg_10_1.sliderPos)

	setAnchoredPosition = var_1_10002

	var_1_10002(arg_10_0.cpkParentTF, arg_10_1.cpkPos)

	setAnchoredPosition = var_1_10002

	var_1_10002(arg_10_0.cpkCoverTF, arg_10_1.cpkCoverPos)

	GetComponent = var_1_10002

	local var_10_0 = arg_10_0.bgTF

	typeof = var_5
	Image = var_1_10007
	var_1_10002(var_10_0, var_5(var_1_10007)).enabled = arg_10_1.showCpkBg

	return
end

function var_0_1.Clear(arg_11_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_11_0.cpkTF) then
		Destroy = var_1

		var_1(arg_11_0.cpkTF)
	end

	if arg_11_0.timer ~= nil then
		local var_11_0 = arg_11_0.timer

		var_1.Stop(var_11_0)

		arg_11_0.timer = nil
	end

	arg_11_0.player = nil
	setText = var_1

	var_1(arg_11_0.nameTF, "")
	arg_11_0:Hide()

	gcAll = var_1

	var_1()

	return
end

function var_0_1.Dispose(arg_12_0)
	arg_12_0:Clear()

	return
end

return var_0_1

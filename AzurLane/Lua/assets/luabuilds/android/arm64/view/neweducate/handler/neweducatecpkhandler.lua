local var_0_0 = class("NewEducateCpkHandler")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._anim = arg_1_0._tf:GetComponent(typeof(Animation))
	arg_1_0.bgTF = arg_1_0._tf:Find("bg")
	arg_1_0.nameTF = arg_1_0.bgTF:Find("name")
	arg_1_0.sliderTF = arg_1_0.bgTF:Find("slider")
	arg_1_0.cpkPlayer = arg_1_0.bgTF:Find("cpk/usm"):GetComponent(typeof(CriManaCpkUI))

	arg_1_0.cpkPlayer:SetMaxFrameDrop(CriWare.CriManaMovieMaterialBase.MaxFrameDrop.Infinite)

	arg_1_0.cpkCoverTF = arg_1_0.bgTF:Find("cpk_cover")
	arg_1_0.frameRate = Application.targetFrameRate or 60

	return
end

function var_0_0.SetCriManaCpkUIParam(arg_2_0, arg_2_1)
	arg_2_0.cpkPlayer.cpkPath = string.lower("OriginSource/cpk/" .. arg_2_1 .. ".cpk")
	arg_2_0.cpkPlayer.movieName = string.lower(arg_2_1 .. ".bytes")

	return
end

function var_0_0.Play(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	setActive(arg_3_0._go, true)

	if arg_3_0._anim then
		arg_3_0._anim:Play()
	end

	arg_3_0.cpkPlayer:StopCpk()
	setText(arg_3_0.nameTF, arg_3_3 or "")
	arg_3_0:SetCriManaCpkUIParam(arg_3_1)
	arg_3_0.cpkPlayer:SetCpkTotalTimeCallback(function(arg_4_0)
		arg_3_0.totalTime = arg_4_0

		arg_3_0:OnStartCpk()

		return
	end)
	arg_3_0.cpkPlayer:SetPlayEndHandler(function()
		existCall(arg_3_2)
		arg_3_0:OnEndCpk()

		return
	end)
	arg_3_0.cpkPlayer:PlayCpk()

	return
end

function var_0_0.OnStartCpk(arg_6_0)
	setSlider(arg_6_0.sliderTF, 0, 1, 0)

	arg_6_0.passTime = 0
	arg_6_0.timer = Timer.New(function()
		arg_6_0.passTime = arg_6_0.passTime + 1 / arg_6_0.frameRate

		setSlider(arg_6_0.sliderTF, 0, 1, arg_6_0.passTime / arg_6_0.totalTime)

		return
	end, 1 / arg_6_0.frameRate, -1)

	arg_6_0.timer:Start()

	return
end

function var_0_0.OnEndCpk(arg_8_0)
	setSlider(arg_8_0.sliderTF, 0, 1, 1)

	if arg_8_0.timer ~= nil then
		arg_8_0.timer:Stop()

		arg_8_0.timer = nil
	end

	arg_8_0.cpkPlayer:SetPlayEndHandler(nil)

	return
end

function var_0_0.SetUIParam(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.bgTF

	if arg_9_1 then
		local var_9_1 = {
			x = 146,
			y = -45
		}

		if not {
			x = 146,
			y = -45
		} then
			var_9_1 = {
				x = 0,
				y = 0
			}
		end

		setAnchoredPosition(var_9_0, var_9_1)

		GetComponent(arg_9_0.bgTF, typeof(Image)).enabled = not arg_9_1

		return
	end
end

function var_0_0.Reset(arg_10_0)
	setActive(arg_10_0._go, false)

	return
end

function var_0_0.Destroy(arg_11_0)
	return
end

return var_0_0

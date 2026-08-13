class = var_0_10000

local var_0_0 = var_0_10000("TouchCakeEffectController")
local var_0_1
local var_0_2 = 6

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	TouchCakeGameVo = var_1_10003
	var_0_1 = var_1_10003
	arg_1_0._content = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._boomTf = var_0_1.GetTplItemFromPool("BoomTpl", arg_1_0._content)
	arg_1_0._boomSpineAnims = {}

	for iter_1_0 = 1, var_0_2 do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_1_0 = arg_1_0._boomSpineAnims

		GetComponent = var_1_10009
		findTF = var_1_10010
		var_1_10010 = var_1_10010(arg_1_0._boomTf, "spine_" .. iter_1_0)
		typeof = var_11
		SpineAnimUI = var_12

		var_1_10007(var_1_0, var_1_10009(var_1_10010, var_11(var_12)))
	end

	return
end

function var_0_0.start(arg_2_0)
	setActive = var_1_10001

	var_1_10001(arg_2_0._boomTf, false)

	arg_2_0._boomTime = 0
	arg_2_0._delayBoomTime = 0

	return
end

function var_0_0.step(arg_3_0)
	local var_3_0
	local var_3_1, var_3_2 = arg_3_0:countDelta(arg_3_0._delayBoomTime)
	local var_3_3 = var_3_2

	arg_3_0._delayBoomTime = var_3_1

	if var_3_3 then
		setActive = var_3_1

		var_3_1(arg_3_0._boomTf, true)

		pg = var_3_1

		local var_3_4 = var_3_1.CriMgr.GetInstance()

		var_2.PlaySoundEffect_V3(var_3_4, var_0_1.SFX_COUNT_CLICK3)

		ipairs = var_2

		for iter_3_0, iter_3_1 in var_2(arg_3_0._boomSpineAnims) do
			arg_3_0:setAnimation(iter_3_1, "action", nil, "normal")
		end
	end

	local var_3_5
	local var_3_6

	arg_3_0._boomTime, var_3_6 = arg_3_0:countDelta(arg_3_0._boomTime)

	if var_3_6 then
		arg_3_0._boomTime = 0
		ipairs = var_3

		for iter_3_2, iter_3_3 in var_3(arg_3_0._boomSpineAnims) do
			arg_3_0:setAnimation(iter_3_3, "action_end", function()
				isActive = var_2_10000

				if var_2_10000(arg_3_0._boomTf) then
					setActive = var_0

					var_0(arg_3_0._boomTf, false)
				end

				return
			end)
		end
	end

	return
end

function var_0_0.countDelta(arg_5_0, arg_5_1)
	if arg_5_1 and arg_5_1 > 0 and arg_5_1 - var_0_1.deltaTime <= 0 then
		return 0, true
	end

	return arg_5_1, false
end

function var_0_0.stop(arg_6_0)
	isActive = var_1_10001

	if var_1_10001(arg_6_0._boomTf) then
		ipairs = var_1

		for iter_6_0, iter_6_1 in var_1(arg_6_0._boomSpineAnims) do
			iter_6_1:Pause()
		end
	end

	return
end

function var_0_0.resume(arg_7_0)
	isActive = var_1_10001

	if var_1_10001(arg_7_0._boomTf) then
		ipairs = var_1

		for iter_7_0, iter_7_1 in var_1(arg_7_0._boomSpineAnims) do
			iter_7_1:Resume()
		end
	end

	return
end

function var_0_0.clear(arg_8_0)
	return
end

function var_0_0.showBoom(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._delayBoomTime = arg_9_2
	arg_9_0._boomTime = arg_9_1

	return
end

function var_0_0.setAnimation(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	arg_10_1:SetActionCallBack(nil)
	arg_10_1:SetAction(arg_10_2, 0)
	arg_10_1:SetActionCallBack(function(arg_11_0)
		if arg_11_0 == "finish" then
			if arg_10_4 then
				local var_11_0 = arg_10_1

				var_1.SetAction(var_11_0, arg_10_4, 0)
			end

			local var_11_1 = arg_10_1

			var_1.SetActionCallBack(var_11_1, nil)

			if arg_10_3 then
				arg_10_3()
			end
		end

		return
	end)

	return
end

function var_0_0.dispose(arg_12_0)
	return
end

return var_0_0

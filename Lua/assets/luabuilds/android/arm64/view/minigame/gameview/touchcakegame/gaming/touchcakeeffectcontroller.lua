local var_0_0 = class("TouchCakeEffectController")
local var_0_1
local var_0_2 = 6

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1 = TouchCakeGameVo
	arg_1_0._content = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._boomTf = var_0_1.GetTplItemFromPool("BoomTpl", arg_1_0._content)
	arg_1_0._boomSpineAnims = {}

	for iter_1_0 = 1, var_0_2 do
		table.insert(arg_1_0._boomSpineAnims, GetComponent(findTF(arg_1_0._boomTf, "spine_" .. iter_1_0), typeof(SpineAnimUI)))
	end

	return
end

function var_0_0.start(arg_2_0)
	setActive(arg_2_0._boomTf, false)

	arg_2_0._boomTime = 0
	arg_2_0._delayBoomTime = 0

	return
end

function var_0_0.step(arg_3_0)
	local var_3_1

	arg_3_0._delayBoomTime, var_3_1 = arg_3_0:countDelta(arg_3_0._delayBoomTime)

	if var_3_1 then
		setActive(arg_3_0._boomTf, true)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_1.SFX_COUNT_CLICK3)

		for iter_3_0, iter_3_1 in ipairs(arg_3_0._boomSpineAnims) do
			arg_3_0:setAnimation(iter_3_1, "action", nil, "normal")
		end
	end

	local var_3_3

	arg_3_0._boomTime, var_3_3 = arg_3_0:countDelta(arg_3_0._boomTime)

	if var_3_3 then
		arg_3_0._boomTime = 0

		for iter_3_2, iter_3_3 in ipairs(arg_3_0._boomSpineAnims) do
			arg_3_0:setAnimation(iter_3_3, "action_end", function()
				if isActive(arg_3_0._boomTf) then
					setActive(arg_3_0._boomTf, false)
				end

				return
			end)
		end
	end

	return
end

function var_0_0.countDelta(arg_5_0, arg_5_1)
	if arg_5_1 and arg_5_1 > 0 then
		arg_5_1 = arg_5_1 - var_0_1.deltaTime

		if arg_5_1 <= 0 then
			arg_5_1 = 0

			return 0, true
		end
	end

	return arg_5_1, false
end

function var_0_0.stop(arg_6_0)
	if isActive(arg_6_0._boomTf) then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0._boomSpineAnims) do
			iter_6_1:Pause()
		end
	end

	return
end

function var_0_0.resume(arg_7_0)
	if isActive(arg_7_0._boomTf) then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._boomSpineAnims) do
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
				arg_10_1:SetAction(arg_10_4, 0)
			end

			arg_10_1:SetActionCallBack(nil)

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

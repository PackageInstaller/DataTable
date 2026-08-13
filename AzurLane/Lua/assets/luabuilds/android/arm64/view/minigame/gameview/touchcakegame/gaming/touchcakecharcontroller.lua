class = var_0_10000

local var_0_0 = var_0_10000("TouchCakeCharController")
local var_0_1
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = {
	315,
	-315
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	TouchCakeGameVo = var_1_10003
	var_0_1 = var_1_10003
	arg_1_0._content = arg_1_1
	arg_1_0._event = arg_1_2
	findTF = var_1_10003
	arg_1_0._char = var_1_10003(arg_1_0._content, "char")
	GetComponent = var_3

	local var_1_0 = arg_1_0._char

	typeof = var_6
	SpineAnimUI = var_1_10008
	arg_1_0._charAnimUI = var_3(var_1_0, var_6(var_1_10008))
	findTF = var_3
	arg_1_0._guardEffectTf = var_3(arg_1_0._char, "dangaota_wudihudun")
	findTF = var_3
	arg_1_0._effectDizziTf = var_3(arg_1_0._char, "dangaota_xuanyun")

	return
end

function var_0_0.start(arg_2_0)
	arg_2_0.actionAble = true
	arg_2_0.freezeTime = -1
	arg_2_0.direct = -1
	arg_2_0.guardTime = -1

	arg_2_0:clearActionDelay()

	local var_2_0 = arg_2_0:getCharAnimName(var_0_3, arg_2_0.direct)

	arg_2_0:setAnimation(arg_2_0._charAnimUI, var_2_0)

	setActive = var_2

	var_2(arg_2_0._guardEffectTf, false)

	setActive = var_2

	var_2(arg_2_0._effectDizziTf, false)

	return
end

function var_0_0.step(arg_3_0)
	arg_3_0:applyActionDelay()

	local var_3_0
	local var_3_1

	arg_3_0.freezeTime, var_3_1 = arg_3_0:countDelta(arg_3_0.freezeTime)

	if var_3_1 then
		arg_3_0:addActionDelay(var_0_3, function()
			return
		end, function()
			return
		end, 0)

		setActive = var_2

		var_2(arg_3_0._effectDizziTf, false)
	end

	local var_3_2
	local var_3_3, var_3_4 = arg_3_0:countDelta(arg_3_0.guardTime)
	local var_3_5 = var_3_4

	arg_3_0.guardTime = var_3_3

	if var_3_5 then
		setActive = var_3_3

		var_3_3(arg_3_0._guardEffectTf, false)
	end

	return
end

function var_0_0.stop(arg_6_0)
	isActive = var_1_10001

	if var_1_10001(arg_6_0._char) then
		local var_6_0 = arg_6_0._charAnimUI

		var_1.Pause(var_6_0)
	end

	return
end

function var_0_0.resume(arg_7_0)
	isActive = var_1_10001

	if var_1_10001(arg_7_0._char) then
		local var_7_0 = arg_7_0._charAnimUI

		var_1.Resume(var_7_0)
	end

	return
end

function var_0_0.applyActionDelay(arg_8_0)
	if arg_8_0.actionDelay then
		if not arg_8_0.actionDelay.start then
			var_1.start = true

			arg_8_0:setAnimation(arg_8_0._charAnimUI, var_1.action, function()
				if not var_0.finish then
					var_0.finishCall()

					var_0.finish = true
				end

				return
			end, function()
				if var_0.actionCall then
					var_0.actionCall()
				end

				return
			end)
		end

		if var_1.time and var_1.time >= 0 then
			local var_8_0
			local var_8_1

			var_1.time, var_8_1 = arg_8_0:countDelta(var_1.time)

			if var_8_1 and not var_1.finish then
				var_1.finishCall()

				var_1.finish = true
			end
		end
	end

	if arg_8_0.actionDelay and arg_8_0.actionDelay.finish then
		arg_8_0.actionDelay = nil
	end

	if not arg_8_0.actionDelay and #arg_8_0.actionDelays > 0 then
		table = var_1
		arg_8_0.actionDelay = var_1.remove(arg_8_0.actionDelays, 1)

		arg_8_0:applyActionDelay()
	end

	return
end

function var_0_0.countDelta(arg_11_0, arg_11_1)
	if arg_11_1 and arg_11_1 >= 0 and arg_11_1 - var_0_1.deltaTime <= 0 then
		return -1, true
	end

	return arg_11_1, false
end

function var_0_0.getCharAnimName(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0
	local var_12_1 = arg_12_2 == 1 and "right" or "left"

	if arg_12_1 == var_0_2 then
		var_12_1 = arg_12_2 == 1 and "left" or "right"

		return "move_" .. var_12_1
	elseif arg_12_1 == var_0_3 then
		return "stand_" .. var_12_1
	elseif arg_12_1 == var_0_4 then
		return "wield_" .. var_12_1
	elseif arg_12_1 == var_0_5 then
		return "yun_" .. var_12_1
	end

	warning = var_4

	local var_12_2 = "不存在的角色动画类型 ="

	tostring = var_1_10007

	var_4(var_12_2 .. var_1_10007(arg_12_1))

	return "move_" .. var_12_1
end

function var_0_0.setAnimation(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_1:SetActionCallBack(nil)
	arg_13_1:SetAction(arg_13_2, 0)
	arg_13_1:SetActionCallBack(function(arg_14_0)
		if arg_14_0 == "action" and arg_13_4 then
			arg_13_4()
		end

		if arg_14_0 == "finish" then
			local var_14_0 = arg_13_1

			var_1.SetActionCallBack(var_14_0, nil)

			if arg_13_3 then
				arg_13_3()
			end
		end

		return
	end)

	return
end

function var_0_0.onTouchLeft(arg_15_0)
	if not arg_15_0:getTouchAble() then
		return
	end

	arg_15_0.actionAble = false

	arg_15_0:touchAction(-1)

	return
end

function var_0_0.onTouchRight(arg_16_0)
	if not arg_16_0:getTouchAble() then
		return
	end

	arg_16_0.actionAble = false

	arg_16_0:touchAction(1)

	return
end

function var_0_0.touchAction(arg_17_0, arg_17_1)
	if arg_17_0.direct ~= arg_17_1 then
		arg_17_0.direct = arg_17_1

		arg_17_0:hideEffect()
		arg_17_0:addActionDelay(var_0_2, function()
			local var_18_0 = arg_17_0

			var_0.showEffect(var_18_0)

			local var_18_1 = arg_17_0._event

			TouchCakeScene = var_18_0

			var_18_1(var_18_0.EVENT_ACTION_WIELD, arg_17_0.direct, function()
				return
			end)

			return
		end, function()
			local var_20_0 = arg_17_0
			local var_20_1 = var_0.getCharAnimName(var_20_0, var_0_3, arg_17_0.direct)
			local var_20_2 = arg_17_0

			var_1.setAnimation(var_20_2, arg_17_0._charAnimUI, var_20_1)

			return
		end)
	else
		arg_17_0:addActionDelay(var_0_4, function()
			local var_21_0 = arg_17_0._event

			TouchCakeScene = var_2_10002

			var_21_0(var_2_10002.EVENT_ACTION_WIELD, arg_17_0.direct, function()
				return
			end)

			return
		end, function()
			local var_23_0 = arg_17_0
			local var_23_1 = var_0.getCharAnimName(var_23_0, var_0_3, arg_17_0.direct)
			local var_23_2 = arg_17_0

			var_1.setAnimation(var_23_2, arg_17_0._charAnimUI, var_23_1)

			return
		end)
	end

	return
end

function var_0_0.addActionDelay(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	local var_24_0 = arg_24_0:getCharAnimName(arg_24_1, arg_24_0.direct)

	table = var_1_10006

	var_1_10006.insert(arg_24_0.actionDelays, {
		action = var_24_0,
		time = arg_24_4,
		actionCall = arg_24_2,
		finishCall = arg_24_3
	})

	return
end

function var_0_0.hideEffect(arg_25_0)
	setActive = var_1_10001

	var_1_10001(arg_25_0._guardEffectTf, false)

	setActive = var_1_10001

	var_1_10001(arg_25_0._effectDizziTf, false)

	return
end

function var_0_0.showEffect(arg_26_0)
	if arg_26_0.freezeTime > 0 then
		setActive = var_1

		var_1(arg_26_0._effectDizziTf, true)

		local var_26_0 = arg_26_0._effectDizziTf.anchoredPosition
		local var_26_1

		if arg_26_0.direct ~= -1 or not var_0_6[1] then
			var_26_1 = var_0_6[2]
		end

		var_26_0.x = var_26_1
		arg_26_0._effectDizziTf.anchoredPosition = var_26_0
	end

	if arg_26_0.guardTime > 0 then
		setActive = var_1

		var_1(arg_26_0._guardEffectTf, true)

		local var_26_2 = arg_26_0._guardEffectTf.anchoredPosition
		local var_26_3

		if arg_26_0.direct ~= -1 or not var_0_6[1] then
			var_26_3 = var_0_6[2]
		end

		var_26_2.x = var_26_3
		arg_26_0._guardEffectTf.anchoredPosition = var_26_2
	end

	return
end

function var_0_0.guard(arg_27_0, arg_27_1)
	arg_27_0.guardTime = arg_27_1

	arg_27_0:showEffect()

	return
end

function var_0_0.getGuard(arg_28_0)
	local var_28_0

	if arg_28_0.guardTime then
		var_28_0 = arg_28_0.guardTime > 0
	end

	return var_28_0
end

function var_0_0.dizzi(arg_29_0, arg_29_1)
	if arg_29_0.guardTime and arg_29_0.guardTime > 0 then
		return false
	end

	arg_29_0:clearActionDelay()

	arg_29_0.freezeTime = arg_29_1

	arg_29_0:showEffect()
	arg_29_0:addActionDelay(var_0_5, function()
		return
	end, function()
		return
	end)

	return true
end

function var_0_0.getDirect(arg_32_0)
	return arg_32_0.direct
end

function var_0_0.clearActionDelay(arg_33_0)
	arg_33_0.actionDelay = nil
	arg_33_0.actionDelays = {}

	return
end

function var_0_0.getTouchAble(arg_34_0)
	if arg_34_0.actionDelay then
		return false
	end

	if arg_34_0.freezeTime > 0 then
		return false
	end

	return true
end

function var_0_0.clear(arg_35_0)
	return
end

function var_0_0.dispose(arg_36_0)
	return
end

return var_0_0

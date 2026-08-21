local var_0_0 = class("TouchCakeCharController")
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
	var_0_1 = TouchCakeGameVo
	arg_1_0._content = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._char = findTF(arg_1_0._content, "char")
	arg_1_0._charAnimUI = GetComponent(arg_1_0._char, typeof(SpineAnimUI))
	arg_1_0._guardEffectTf = findTF(arg_1_0._char, "dangaota_wudihudun")
	arg_1_0._effectDizziTf = findTF(arg_1_0._char, "dangaota_xuanyun")

	return
end

function var_0_0.start(arg_2_0)
	arg_2_0.actionAble = true
	arg_2_0.freezeTime = -1
	arg_2_0.direct = -1
	arg_2_0.guardTime = -1

	arg_2_0:clearActionDelay()
	arg_2_0:setAnimation(arg_2_0._charAnimUI, (arg_2_0:getCharAnimName(var_0_3, arg_2_0.direct)))
	setActive(arg_2_0._guardEffectTf, false)
	setActive(arg_2_0._effectDizziTf, false)

	return
end

function var_0_0.step(arg_3_0)
	arg_3_0:applyActionDelay()

	local var_3_1

	arg_3_0.freezeTime, var_3_1 = arg_3_0:countDelta(arg_3_0.freezeTime)

	if var_3_1 then
		arg_3_0:addActionDelay(var_0_3, function()
			return
		end, function()
			return
		end, 0)
		setActive(arg_3_0._effectDizziTf, false)
	end

	local var_3_3

	arg_3_0.guardTime, var_3_3 = arg_3_0:countDelta(arg_3_0.guardTime)

	if var_3_3 then
		setActive(arg_3_0._guardEffectTf, false)
	end

	return
end

function var_0_0.stop(arg_6_0)
	if isActive(arg_6_0._char) then
		arg_6_0._charAnimUI:Pause()
	end

	return
end

function var_0_0.resume(arg_7_0)
	if isActive(arg_7_0._char) then
		arg_7_0._charAnimUI:Resume()
	end

	return
end

function var_0_0.applyActionDelay(arg_8_0)
	if arg_8_0.actionDelay then
		local var_8_0 = arg_8_0.actionDelay

		if not arg_8_0.actionDelay.start then
			arg_8_0.actionDelay.start = true

			arg_8_0:setAnimation(arg_8_0._charAnimUI, arg_8_0.actionDelay.action, function()
				if not var_8_0.finish then
					var_8_0.finishCall()

					var_8_0.finish = true
				end

				return
			end, function()
				if var_8_0.actionCall then
					var_8_0.actionCall()
				end

				return
			end)
		end

		if arg_8_0.actionDelay.time and arg_8_0.actionDelay.time >= 0 then
			local var_8_2

			var_8_0.time, var_8_2 = arg_8_0:countDelta(arg_8_0.actionDelay.time)

			if var_8_2 and not arg_8_0.actionDelay.finish then
				arg_8_0.actionDelay.finishCall()

				arg_8_0.actionDelay.finish = true
			end
		end
	end

	if arg_8_0.actionDelay and arg_8_0.actionDelay.finish then
		arg_8_0.actionDelay = nil
	end

	if not arg_8_0.actionDelay and #arg_8_0.actionDelays > 0 then
		arg_8_0.actionDelay = table.remove(arg_8_0.actionDelays, 1)

		arg_8_0:applyActionDelay()
	end

	return
end

function var_0_0.countDelta(arg_11_0, arg_11_1)
	if arg_11_1 and arg_11_1 >= 0 then
		arg_11_1 = arg_11_1 - var_0_1.deltaTime

		if arg_11_1 <= 0 then
			arg_11_1 = -1

			return -1, true
		end
	end

	return arg_11_1, false
end

function var_0_0.getCharAnimName(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == var_0_2 then
		var_12_0 = arg_12_2 == 1 and "left" or "right"

		return "move_" .. var_12_0
	elseif arg_12_1 == var_0_3 then
		return "stand_" .. var_12_0
	elseif arg_12_1 == var_0_4 then
		return "wield_" .. var_12_0
	elseif arg_12_1 == var_0_5 then
		return "yun_" .. var_12_0
	end

	warning("不存在的角色动画类型 =" .. tostring(arg_12_1))

	return "move_" .. var_12_0
end

function var_0_0.setAnimation(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_1:SetActionCallBack(nil)
	arg_13_1:SetAction(arg_13_2, 0)
	arg_13_1:SetActionCallBack(function(arg_14_0)
		if arg_14_0 == "action" and arg_13_4 then
			arg_13_4()
		end

		if arg_14_0 == "finish" then
			arg_13_1:SetActionCallBack(nil)

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
			arg_17_0:showEffect()
			arg_17_0._event(TouchCakeScene.EVENT_ACTION_WIELD, arg_17_0.direct, function()
				return
			end)

			return
		end, function()
			arg_17_0:setAnimation(arg_17_0._charAnimUI, (arg_17_0:getCharAnimName(var_0_3, arg_17_0.direct)))

			return
		end)
	else
		arg_17_0:addActionDelay(var_0_4, function()
			arg_17_0._event(TouchCakeScene.EVENT_ACTION_WIELD, arg_17_0.direct, function()
				return
			end)

			return
		end, function()
			arg_17_0:setAnimation(arg_17_0._charAnimUI, (arg_17_0:getCharAnimName(var_0_3, arg_17_0.direct)))

			return
		end)
	end

	return
end

function var_0_0.addActionDelay(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	table.insert(arg_24_0.actionDelays, {
		action = arg_24_0:getCharAnimName(arg_24_1, arg_24_0.direct),
		time = arg_24_4,
		actionCall = arg_24_2,
		finishCall = arg_24_3
	})

	return
end

function var_0_0.hideEffect(arg_25_0)
	setActive(arg_25_0._guardEffectTf, false)
	setActive(arg_25_0._effectDizziTf, false)

	return
end

function var_0_0.showEffect(arg_26_0)
	if arg_26_0.freezeTime > 0 then
		setActive(arg_26_0._effectDizziTf, true)

		local var_26_0 = arg_26_0._effectDizziTf.anchoredPosition

		if arg_26_0.direct == -1 then
			var_26_0.x = var_0_6[1] or var_0_6[2]
			arg_26_0._effectDizziTf.anchoredPosition = var_26_0

			if arg_26_0.guardTime > 0 then
				setActive(arg_26_0._guardEffectTf, true)

				local var_26_1 = arg_26_0._guardEffectTf.anchoredPosition

				if arg_26_0.direct == -1 then
					var_26_1.x = var_0_6[1] or var_0_6[2]
					arg_26_0._guardEffectTf.anchoredPosition = var_26_1

					return
				end
			end
		end
	end
end

function var_0_0.guard(arg_27_0, arg_27_1)
	arg_27_0.guardTime = arg_27_1

	arg_27_0:showEffect()

	return
end

function var_0_0.getGuard(arg_28_0)
	return arg_28_0.guardTime and arg_28_0.guardTime > 0
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

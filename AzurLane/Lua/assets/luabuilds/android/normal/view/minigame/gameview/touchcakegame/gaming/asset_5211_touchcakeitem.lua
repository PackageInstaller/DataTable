class = var_0_10000

local var_0_0 = var_0_10000("TouchCakeItem")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	findTF = var_1_10003
	arg_1_0._cakeTf = var_1_10003(arg_1_0._tf, "cake")
	GetComponent = var_3

	local var_1_0 = arg_1_0._cakeTf

	typeof = var_5
	SpineAnimUI = var_1_10006
	arg_1_0._cakeAnimUI = var_3(var_1_0, var_5(var_1_10006))
	findTF = var_3
	arg_1_0._propLeftSpine = var_3(arg_1_0._tf, "prop_left/spine")
	findTF = var_3
	arg_1_0._propLeftIcon = var_3(arg_1_0._tf, "prop_left/icon")
	GetComponent = var_3

	local var_1_1 = arg_1_0._propLeftSpine

	typeof = var_5
	SpineAnimUI = var_1_10006
	arg_1_0._propLeftAnimUI = var_3(var_1_1, var_5(var_1_10006))
	findTF = var_3
	arg_1_0._propRightSpine = var_3(arg_1_0._tf, "prop_right/spine")
	findTF = var_3
	arg_1_0._propRightIcon = var_3(arg_1_0._tf, "prop_right/icon")
	GetComponent = var_3

	local var_1_2 = arg_1_0._propRightSpine

	typeof = var_5
	SpineAnimUI = var_1_10006
	arg_1_0._propRightAnimUI = var_3(var_1_2, var_5(var_1_10006))
	arg_1_0._props = {
		{
			direct = -1,
			iconTf = arg_1_0._propLeftIcon,
			spineTf = arg_1_0._propLeftSpine,
			anim = arg_1_0._propLeftAnimUI
		},
		{
			direct = 1,
			iconTf = arg_1_0._propRightIcon,
			spineTf = arg_1_0._propRightSpine,
			anim = arg_1_0._propRightAnimUI
		}
	}
	arg_1_0._eventCallback = arg_1_2

	return
end

function var_0_0.setParent(arg_2_0, arg_2_1)
	SetParent = var_1_10002

	var_1_10002(arg_2_0._tf, arg_2_1, true)

	return
end

function var_0_0.setPosition(arg_3_0, arg_3_1)
	arg_3_0._tf.anchoredPosition = arg_3_1

	return
end

function var_0_0.setData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._cakeData = arg_4_1
	ipairs = var_1_10004

	for iter_4_0, iter_4_1 in var_1_10004(arg_4_0._props) do
		iter_4_1.data = nil
	end

	if arg_4_2 then
		local var_4_0
		local var_4_1

		if not arg_4_3 then
			var_4_1 = arg_4_0._props
			math = var_6
			var_4_0 = var_4_1[var_6.random(1, #arg_4_0._props)]
		else
			ipairs = var_4_1

			for iter_4_2, iter_4_3 in var_4_1(arg_4_0._props) do
				if iter_4_3.direct == arg_4_3 then
					var_4_0 = iter_4_3
				end
			end
		end

		var_4_0.data = arg_4_2
	end

	arg_4_0:updateItem()

	return
end

function var_0_0.updateItem(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.getCakeAnimName

	TouchCakeGameConst = var_1_10003

	local var_5_2 = var_5_1(var_5_0, var_1_10003.cake_anim_normal)

	arg_5_0:setAniamtion(arg_5_0._cakeAnimUI, var_5_2)

	ipairs = var_2

	for iter_5_0, iter_5_1 in var_2(arg_5_0._props) do
		setActive = var_1_10007

		var_1_10007(iter_5_1.spineTf, false)

		setActive = var_1_10007

		var_1_10007(iter_5_1.iconTf, false)

		if iter_5_1.data then
			setActive = var_1_10007

			var_1_10007(iter_5_1.spineTf, iter_5_1.data.spine and true or false)

			setActive = var_1_10007

			var_1_10007(iter_5_1.iconTf, iter_5_1.data.icon and true or false)

			if iter_5_1.data.spine then
				var_1_10007 = nil

				local var_5_3
				local var_5_4 = arg_5_0
				local var_5_5 = arg_5_0.getPropAnimName

				TouchCakeGameConst = var_1_10011

				local var_5_6, var_5_7 = var_5_5(var_5_4, var_1_10011.prop_anim_normal, iter_5_1.data)

				var_1_10007 = var_5_7

				local var_5_8 = var_5_6
				local var_5_9 = iter_5_1.spineTf

				Vector3 = var_5_7
				var_5_9.localScale = var_5_7(var_1_10007, 1, 1)

				arg_5_0:setAniamtion(iter_5_1.anim, var_5_8)
			elseif iter_5_1.data.icon then
				arg_5_0:setIconVisible(iter_5_1.iconTf, iter_5_1.data.icon)
			end
		end
	end

	return
end

function var_0_0.setIconVisible(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1.childCount

	for iter_6_0 = 1, var_6_0 do
		local var_6_1 = arg_6_1
		local var_6_2 = arg_6_1.GetChild(var_6_1, iter_6_0 - 1)

		setActive = var_6_1

		var_6_1(var_6_2, var_6_2.name == arg_6_2)
	end

	return
end

function var_0_0.touchAction(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.getCakeAnimName

	TouchCakeGameConst = var_1_10005

	local var_7_2 = var_7_1(var_7_0, var_1_10005.cake_anim_action, arg_7_1)
	local var_7_3 = arg_7_0

	arg_7_0.setAniamtion(var_7_3, arg_7_0._cakeAnimUI, var_7_2, arg_7_2)

	local var_7_4 = arg_7_0._eventCallback

	TouchCakeScene = var_7_3

	local var_7_5 = var_7_3.EVENT_ACTION_CAKE
	local var_7_6 = {}

	Clone = var_7
	var_7_6.cake = var_7(arg_7_0._cakeData)

	var_7_4(var_7_5, var_7_6)

	return
end

function var_0_0.getCakeAnimName(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.getCakeConfig(var_8_0, "type")

	TouchCakeGameConst = var_8_0

	if arg_8_1 == var_8_0.cake_anim_normal then
		return "normal" .. var_8_1
	else
		TouchCakeGameConst = var_4

		if arg_8_1 == var_4.cake_anim_action then
			if arg_8_2 == 1 then
				return "action_left_" .. var_8_1
			elseif var_4 == -1 then
				return "action_right_" .. var_8_1
			end
		end
	end

	return
end

function var_0_0.getPropAnimName(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_2.type

	TouchCakeGameConst = var_1_10005

	if arg_9_1 == var_1_10005.prop_anim_normal then
		return "normal" .. var_9_0, 1
	else
		TouchCakeGameConst = var_5

		if arg_9_1 == var_5.prop_anim_action then
			if var_9_0 == 4 then
				if arg_9_3 == 1 then
					return "action" .. var_9_0, 1
				else
					return "action" .. var_9_0 .. "_left", -1
				end
			end

			return "action" .. var_9_0, 1
		end
	end

	return
end

function var_0_0.getCakeConfig(arg_10_0, arg_10_1)
	return arg_10_0._cakeData[arg_10_1]
end

function var_0_0.getPropConfig(arg_11_0, arg_11_1)
	return arg_11_0._propData[arg_11_1]
end

function var_0_0.getTopPos(arg_12_0)
	var_1.y = arg_12_0._tf.anchoredPosition.y + arg_12_0:getCakeConfig("height")

	return var_1
end

function var_0_0.setLayerLast(arg_13_0)
	local var_13_0 = arg_13_0._tf

	var_1.SetAsLastSibling(var_13_0)

	return
end

function var_0_0.setLayerFirst(arg_14_0)
	local var_14_0 = arg_14_0._tf

	var_1.SetAsFirstSibling(var_14_0)

	return
end

function var_0_0.getPropDirect(arg_15_0)
	ipairs = var_1_10001

	for iter_15_0, iter_15_1 in var_1_10001(arg_15_0._props) do
		if iter_15_1.data ~= nil then
			return iter_15_1.direct
		end
	end

	return nil
end

function var_0_0.setAniamtion(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_1:SetActionCallBack(nil)
	arg_16_1:SetAction(arg_16_2, 0)
	arg_16_1:SetActionCallBack(function(arg_17_0)
		if arg_17_0 == "finish" then
			local var_17_0 = arg_16_1

			var_1.SetActionCallBack(var_17_0, nil)

			if arg_16_3 then
				arg_16_3()
			end
		end

		return
	end)

	return
end

function var_0_0.stop(arg_18_0)
	isActive = var_1_10001

	if var_1_10001(arg_18_0._cakeTf) then
		local var_18_0 = arg_18_0._cakeAnimUI

		var_1.Pause(var_18_0)
	end

	ipairs = var_1

	for iter_18_0, iter_18_1 in var_1(arg_18_0._props) do
		if iter_18_1.spineTf then
			isActive = var_6

			if var_6(iter_18_1.spineTf) and iter_18_1.anim then
				local var_18_1 = iter_18_1.anim

				var_6.Pause(var_18_1)
			end
		end
	end

	return
end

function var_0_0.resume(arg_19_0)
	isActive = var_1_10001

	if var_1_10001(arg_19_0._cakeTf) then
		local var_19_0 = arg_19_0._cakeAnimUI

		var_1.Resume(var_19_0)
	end

	ipairs = var_1

	for iter_19_0, iter_19_1 in var_1(arg_19_0._props) do
		if iter_19_1.spineTf then
			isActive = var_6

			if var_6(iter_19_1.spineTf) and iter_19_1.anim then
				local var_19_1 = iter_19_1.anim

				var_6.Resume(var_19_1)
			end
		end
	end

	return
end

function var_0_0.propAction(arg_20_0)
	ipairs = var_1_10001

	for iter_20_0, iter_20_1 in var_1_10001(arg_20_0._props) do
		if iter_20_1.data then
			local var_20_0 = arg_20_0._eventCallback

			TouchCakeScene = var_1_10007
			var_1_10007 = var_1_10007.EVENT_ACTION_PROP

			local var_20_1 = {}

			Clone = var_1_10009
			var_20_1.prop = var_1_10009(iter_20_1)

			var_20_0(var_1_10007, var_20_1, function(arg_21_0)
				if iter_20_1.data.spine then
					local var_21_0
					local var_21_1
					local var_21_2 = arg_20_0
					local var_21_3 = var_3.getPropAnimName

					TouchCakeGameConst = var_2_10005

					local var_21_4, var_21_5 = var_21_3(var_21_2, var_2_10005.prop_anim_action, iter_20_1.data, iter_20_1.direct)
					local var_21_6 = var_21_5
					local var_21_7 = var_21_4
					local var_21_8 = iter_20_1.spineTf

					Vector3 = var_21_5
					var_21_8.localScale = var_21_5(var_21_6, 1, 1)

					local var_21_9 = arg_20_0

					var_3.setAniamtion(var_21_9, iter_20_1.anim, var_21_7, function()
						setActive = var_3_10000

						var_3_10000(iter_20_1.spineTf, false)

						return
					end)
				elseif iter_20_1.data.icon then
					setActive = var_1

					var_1(iter_20_1.iconTf, false)
				end

				return
			end)
		end
	end

	return
end

function var_0_0.clear(arg_23_0)
	return
end

return var_0_0

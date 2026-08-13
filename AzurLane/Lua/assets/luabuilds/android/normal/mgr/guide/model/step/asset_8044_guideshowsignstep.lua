class = var_0_10000

local var_0_0 = "GuideShowSignStep"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuideStep"))

var_0_1.SIGN_TYPE_2 = 2
var_0_1.SIGN_TYPE_3 = 3

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.sType = arg_1_1.showSign.type
	arg_1_0.duration = var_2.duration
	arg_1_0.clickUI = arg_1_0:GenClickData(var_2.clickUI)
	arg_1_0.clickArea = var_2.clickArea
	arg_1_0.longPress = var_2.longPress
	arg_1_0.signIndexList = {}
	ipairs = var_3

	for iter_1_0, iter_1_1 in var_3(var_2.signList) do
		local var_1_0 = iter_1_1.signType
		local var_1_1 = iter_1_1.pos
		local var_1_2 = iter_1_1.cachedIndex

		type = var_1_10011

		if var_1_10011(var_1_1) == "string" then
			if var_1_1 == "useCachePos" then
				WorldGuider = var_1_10011

				local var_1_3 = var_1_10011.GetInstance()

				var_1_1 = var_1_10011.GetTempGridPos(var_1_3, var_1_2)
			end
		else
			type = var_1_10011

			if var_1_10011(var_1_1) == "table" then
				Vector3 = var_1_10011
				var_1_1 = var_1_10011.New(var_1_1[1], var_1_1[2], var_1_1[3])
			end
		end

		table = var_1_10011
		var_1_10011 = var_1_10011.insert

		local var_1_4 = arg_1_0.signIndexList
		local var_1_5 = {}

		if not var_1_1 then
			::label_1_0::

			Vector3 = var_1_10014
			var_1_10014 = var_1_10014(0, 0, 0)
		end

		var_1_5.pos = var_1_10014
		var_1_5.signName = arg_1_0:GetSignResName(var_1_0)
		var_1_5.atlasName = iter_1_1.atlasName
		var_1_5.fileName = iter_1_1.fileName

		var_1_10011(var_1_4, var_1_5)
	end

	return
end

function var_0_1.GenClickData(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return nil
	end

	local var_2_0 = arg_2_0:GenSearchData(arg_2_1)
	local var_2_1

	if not arg_2_1.sizeDeltaPlus then
		var_2_1 = {
			0,
			0
		}
	end

	Vector2 = var_4
	var_2_0.sizeDeltaPlus = var_4(var_2_1[1], var_2_1[2])

	return var_2_0
end

function var_0_1.GetType(arg_3_0)
	GuideStep = var_1_10001

	return var_1_10001.TYPE_SHOWSIGN
end

function var_0_1.GetSignType(arg_4_0)
	return arg_4_0.sType
end

function var_0_1.GetFirstSign(arg_5_0)
	return arg_5_0.signIndexList[1]
end

function var_0_1.GetSignList(arg_6_0)
	return arg_6_0.signIndexList
end

function var_0_1.GetSignResName(arg_7_0, arg_7_1)
	local var_7_0 = ""

	if arg_7_1 == 1 or arg_7_1 == 6 then
		var_7_0 = "wTask"
	elseif arg_7_1 == 2 then
		var_7_0 = "wDanger"
	elseif arg_7_1 == 3 then
		var_7_0 = "wForbidden"
	elseif arg_7_1 == 4 then
		var_7_0 = "wClickArea"
	elseif arg_7_1 == 5 then
		var_7_0 = "wShowArea"
	elseif arg_7_1 == 7 then
		var_7_0 = "wShowArea4Click"
	elseif arg_7_1 == 8 then
		var_7_0 = "wShowArea4Click_borderless"
	end

	return var_7_0
end

function var_0_1.ShouldClick(arg_8_0)
	return arg_8_0.clickUI ~= nil
end

function var_0_1.GetClickData(arg_9_0)
	return arg_9_0.clickUI
end

function var_0_1.ExistClickArea(arg_10_0)
	return arg_10_0.clickArea ~= nil
end

function var_0_1.GetClickArea(arg_11_0)
	local var_11_0

	if not arg_11_0.clickArea then
		var_11_0 = {
			0,
			0
		}
	end

	Vector2 = var_1_10002

	return var_1_10002(var_11_0[1], var_11_0[2])
end

function var_0_1.GetTriggerType(arg_12_0)
	return arg_12_0.longPress
end

function var_0_1.GetExitDelay(arg_13_0)
	local var_13_0

	if not arg_13_0.duration then
		var_13_0 = 0
	end

	return var_13_0
end

function var_0_1.ExistTrigger(arg_14_0)
	return arg_14_0:GetSignType() ~= var_0_1.SIGN_TYPE_3
end

return var_0_1

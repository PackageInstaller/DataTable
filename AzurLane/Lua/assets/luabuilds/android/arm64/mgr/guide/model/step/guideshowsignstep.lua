local var_0_0 = class("GuideShowSignStep", import(".GuideStep"))

var_0_0.SIGN_TYPE_2 = 2
var_0_0.SIGN_TYPE_3 = 3

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.sType = arg_1_1.showSign.type
	arg_1_0.duration = arg_1_1.showSign.duration
	arg_1_0.clickUI = arg_1_0:GenClickData(arg_1_1.showSign.clickUI)
	arg_1_0.clickArea = arg_1_1.showSign.clickArea
	arg_1_0.longPress = arg_1_1.showSign.longPress
	arg_1_0.signIndexList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.showSign.signList) do
		local var_1_0 = iter_1_1.signType
		local var_1_1 = iter_1_1.pos

		if type(iter_1_1.pos) == "string" then
			if var_1_1 == "useCachePos" then
				var_1_1 = WorldGuider.GetInstance():GetTempGridPos(iter_1_1.cachedIndex)
			end
		elseif type(var_1_1) == "table" then
			var_1_1 = Vector3.New(var_1_1[1], var_1_1[2], var_1_1[3])
		end

		table.insert(arg_1_0.signIndexList, {
			pos = var_1_1 or Vector3(0, 0, 0),
			signName = arg_1_0:GetSignResName(var_1_0),
			atlasName = iter_1_1.atlasName,
			fileName = iter_1_1.fileName
		})
	end

	return
end

function var_0_0.GenClickData(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return nil
	end

	local var_2_0 = arg_2_0:GenSearchData(arg_2_1)
	local var_2_1 = arg_2_1.sizeDeltaPlus or {
		0,
		0
	}

	var_2_0.sizeDeltaPlus = Vector2(var_2_1[1], var_2_1[2])

	return var_2_0
end

function var_0_0.GetType(arg_3_0)
	return GuideStep.TYPE_SHOWSIGN
end

function var_0_0.GetSignType(arg_4_0)
	return arg_4_0.sType
end

function var_0_0.GetFirstSign(arg_5_0)
	return arg_5_0.signIndexList[1]
end

function var_0_0.GetSignList(arg_6_0)
	return arg_6_0.signIndexList
end

function var_0_0.GetSignResName(arg_7_0, arg_7_1)
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

function var_0_0.ShouldClick(arg_8_0)
	return arg_8_0.clickUI ~= nil
end

function var_0_0.GetClickData(arg_9_0)
	return arg_9_0.clickUI
end

function var_0_0.ExistClickArea(arg_10_0)
	return arg_10_0.clickArea ~= nil
end

function var_0_0.GetClickArea(arg_11_0)
	local var_11_0 = arg_11_0.clickArea or {
		0,
		0
	}

	return Vector2(var_11_0[1], var_11_0[2])
end

function var_0_0.GetTriggerType(arg_12_0)
	return arg_12_0.longPress
end

function var_0_0.GetExitDelay(arg_13_0)
	return arg_13_0.duration or 0
end

function var_0_0.ExistTrigger(arg_14_0)
	return arg_14_0:GetSignType() ~= var_0_0.SIGN_TYPE_3
end

return var_0_0

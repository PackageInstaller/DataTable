ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleCameraSlider = var_0_10003("BattleCameraSlider")
class = var_0_2

local var_0_3 = var_0_2("BattleCameraSlider")

var_0.Battle.BattleCameraSlider = var_0_3
var_0_3.__name = "BattleCameraSlider"

function var_0_3.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1

	arg_1_0:Init()

	return
end

function var_0_3.Init(arg_2_0)
	SetActive = var_1_10001

	var_1_10001(arg_2_0._go, true)

	arg_2_0._distX, arg_2_0._distY = 0, 0
	arg_2_0._dirX, arg_2_0._dirY = 0, 0
	arg_2_0._isPress = false
	pg = var_1
	arg_2_0._screenWidth, arg_2_0._screenHeight = var_1.CameraFixMgr.GetInstance().actualWidth, var_1.actualHeight

	local var_2_0 = arg_2_0._go
	local var_2_1 = var_2.GetComponent(var_2_0, "StickController")

	var_2.SetStickFunc(var_2_1, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.updateStick(var_3_0, arg_3_0, arg_3_1)

		return
	end)

	return
end

function var_0_3.updateStick(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._initX = false
	arg_4_0._initY = false

	if arg_4_2 == -1 then
		arg_4_0._startX = nil
		arg_4_0._startY = nil
		arg_4_0._isPress = false
	else
		arg_4_0._isPress = true

		local var_4_0 = arg_4_1.x
		local var_4_1 = arg_4_1.y

		if arg_4_0._startX == nil then
			arg_4_0._startX = var_4_0
			arg_4_0._startY = var_4_1
			arg_4_0._initX = true
			arg_4_0._initY = true
		else
			if (var_4_0 - arg_4_0._lastPosX) * arg_4_0._dirX < 0 then
				arg_4_0._startX = var_4_0
				arg_4_0._initX = true
			end

			if var_5 ~= 0 then
				arg_4_0._dirX = var_5
			end

			if (var_4_1 - arg_4_0._lastPosY) * arg_4_0._dirY < 0 then
				arg_4_0._startY = var_4_1
				arg_4_0._initY = true
			end

			if var_6 ~= 0 then
				arg_4_0._dirY = var_6
			end
		end

		arg_4_0._distX = (var_4_0 - arg_4_0._startX) / arg_4_0._screenWidth
		arg_4_0._distY = (var_4_1 - arg_4_0._startY) / arg_4_0._screenHeight
	end

	arg_4_0._lastPosX = arg_4_1.x
	arg_4_0._lastPosY = arg_4_1.y

	return
end

function var_0_3.GetDistance(arg_5_0)
	return arg_5_0._distX, arg_5_0._distY
end

function var_0_3.IsFirstPress(arg_6_0)
	return arg_6_0._initX, arg_6_0._initY
end

function var_0_3.IsPress(arg_7_0)
	return arg_7_0._isPress
end

return

ys = ys or {}
ys.Battle.BattleCameraSlider = class("BattleCameraSlider")

local var_0_1 = class("BattleCameraSlider")

ys.Battle.BattleCameraSlider = var_0_1
var_0_1.__name = "BattleCameraSlider"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1

	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	SetActive(arg_2_0._go, true)

	arg_2_0._distX, arg_2_0._distY = 0, 0
	arg_2_0._dirX, arg_2_0._dirY = 0, 0
	arg_2_0._isPress = false

	local var_2_0 = pg.CameraFixMgr.GetInstance()

	arg_2_0._screenWidth, arg_2_0._screenHeight = var_2_0.actualWidth, var_2_0.actualHeight

	arg_2_0._go:GetComponent("StickController"):SetStickFunc(function(arg_3_0, arg_3_1)
		arg_2_0:updateStick(arg_3_0, arg_3_1)

		return
	end)

	return
end

function var_0_1.updateStick(arg_4_0, arg_4_1, arg_4_2)
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
			local var_4_2 = var_4_0 - arg_4_0._lastPosX

			if (var_4_0 - arg_4_0._lastPosX) * arg_4_0._dirX < 0 then
				arg_4_0._startX = var_4_0
				arg_4_0._initX = true
			end

			if var_4_2 ~= 0 then
				arg_4_0._dirX = var_4_2
			end

			local var_4_3 = var_4_1 - arg_4_0._lastPosY

			if (var_4_1 - arg_4_0._lastPosY) * arg_4_0._dirY < 0 then
				arg_4_0._startY = var_4_1
				arg_4_0._initY = true
			end

			if var_4_3 ~= 0 then
				arg_4_0._dirY = var_4_3
			end
		end

		arg_4_0._distX = (var_4_0 - arg_4_0._startX) / arg_4_0._screenWidth
		arg_4_0._distY = (var_4_1 - arg_4_0._startY) / arg_4_0._screenHeight
	end

	arg_4_0._lastPosX = arg_4_1.x
	arg_4_0._lastPosY = arg_4_1.y

	return
end

function var_0_1.GetDistance(arg_5_0)
	return arg_5_0._distX, arg_5_0._distY
end

function var_0_1.IsFirstPress(arg_6_0)
	return arg_6_0._initX, arg_6_0._initY
end

function var_0_1.IsPress(arg_7_0)
	return arg_7_0._isPress
end

return

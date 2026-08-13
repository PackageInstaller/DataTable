ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig

class = var_0_10002

local var_0_2 = var_0_10002("CardPuzzleBoardClicker")

var_0.Battle.CardPuzzleBoardClicker = var_0_2
var_0_2.__name = "CardPuzzleBoardClicker"
var_0_2.CLICK_STATE_CLICK = "CLICK_STATE_CLICK"
var_0_2.CLICK_STATE_DRAG = "CLICK_STATE_DRAG"
var_0_2.CLICK_STATE_RELEASE = "CLICK_STATE_RELEASE"
var_0_2.CLICK_STATE_NONE = "CLICK_STATE_NONE"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1

	arg_1_0:Init()

	return
end

function var_0_2.Init(arg_2_0)
	SetActive = var_1_10001

	var_1_10001(arg_2_0._go, true)

	arg_2_0._distX, arg_2_0._distY = 0, 0
	arg_2_0._dirX, arg_2_0._dirY = 0, 0
	arg_2_0._prePress = false
	arg_2_0._isPress = false
	pg = var_1

	local var_2_0 = var_1.CameraFixMgr.GetInstance()

	arg_2_0._screenWidth, arg_2_0._screenHeight = var_1.GetCurrentWidth(var_2_0), var_1:GetCurrentHeight()

	local var_2_1 = arg_2_0._go
	local var_2_2 = var_2.GetComponent(var_2_1, "StickController")

	var_2.SetStickFunc(var_2_2, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.updateStick(var_3_0, arg_3_0, arg_3_1)

		return
	end)

	return
end

function var_0_2.SetCardPuzzleComponent(arg_4_0, arg_4_1)
	arg_4_0._cardPuzzleInfo = arg_4_1

	return
end

function var_0_2.updateStick(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0._cardPuzzleInfo

	if not var_3.GetClickEnable(var_5_0) then
		return
	end

	arg_5_0._initX = false
	arg_5_0._initY = false

	if arg_5_2 == -1 then
		arg_5_0._startX = nil
		arg_5_0._startY = nil
		arg_5_0._isPress = false
	else
		arg_5_0._isPress = true

		local var_5_1 = arg_5_1.x
		local var_5_2 = arg_5_1.y

		if arg_5_0._startX == nil then
			arg_5_0._startX = var_5_1
			arg_5_0._startY = var_5_2
			arg_5_0._initX = true
			arg_5_0._initY = true
		else
			if (var_5_1 - arg_5_0._lastPosX) * arg_5_0._dirX < 0 then
				arg_5_0._startX = var_5_1
				arg_5_0._initX = true
			end

			if var_5 ~= 0 then
				arg_5_0._dirX = var_5
			end

			if (var_5_2 - arg_5_0._lastPosY) * arg_5_0._dirY < 0 then
				arg_5_0._startY = var_5_2
				arg_5_0._initY = true
			end

			if var_6 ~= 0 then
				arg_5_0._dirY = var_6
			end
		end

		arg_5_0._distX = (var_5_1 - arg_5_0._startX) / arg_5_0._screenWidth
		arg_5_0._distY = (var_5_2 - arg_5_0._startY) / arg_5_0._screenHeight
	end

	arg_5_0._lastPosX = arg_5_1.x
	arg_5_0._lastPosY = arg_5_1.y

	local var_5_3

	if not arg_5_0._prePress and arg_5_0._isPress then
		var_5_3 = var_0_2.CLICK_STATE_CLICK
	elseif arg_5_0._prePress and arg_5_0._isPress then
		var_5_3 = var_0_2.CLICK_STATE_DRAG
	elseif arg_5_0._prePress and not arg_5_0._isPress then
		var_5_3 = var_0_2.CLICK_STATE_RELEASE
	else
		var_5_3 = var_0_2.CLICK_STATE_NONE
	end

	local var_5_4 = arg_5_0._cardPuzzleInfo

	var_4.UpdateClickPos(var_5_4, arg_5_0._lastPosX, arg_5_0._lastPosY, var_5_3)

	arg_5_0._prePress = arg_5_0._isPress

	return
end

function var_0_2.GetDistance(arg_6_0)
	return arg_6_0._distX, arg_6_0._distY
end

function var_0_2.IsFirstPress(arg_7_0)
	return arg_7_0._initX, arg_7_0._initY
end

function var_0_2.IsPress(arg_8_0)
	return arg_8_0._isPress
end

function var_0_2.Dispose(arg_9_0)
	return
end

return

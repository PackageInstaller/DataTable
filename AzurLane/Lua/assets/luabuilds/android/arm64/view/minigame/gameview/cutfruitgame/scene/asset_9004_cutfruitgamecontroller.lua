class = var_0_10000

local var_0_0 = var_0_10000("CutFruitGameController")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 5
local var_0_5 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._data = arg_1_3
	arg_1_0._spineChar = nil
	arg_1_0._npcSpines = {}
	findTF = var_4
	arg_1_0._charContent = var_4(arg_1_0._tf, "char")
	findTF = var_4
	arg_1_0._npcContent = var_4(arg_1_0._tf, "npc")
	findTF = var_4
	arg_1_0._directPanel = var_4(arg_1_0._tf, "direct")
	GetComponent = var_4
	findTF = var_6

	local var_1_0 = var_6(arg_1_0._tf, "direct")

	typeof = var_7
	Animator = var_9
	arg_1_0._directPanelAniamtor = var_4(var_1_0, var_7(var_9))
	GetComponent = var_4
	findTF = var_1_0

	local var_1_1 = var_1_0(arg_1_0._tf, "direct")

	typeof = var_7
	DftAniEvent = var_9
	arg_1_0._directPanelDftEvent = var_4(var_1_1, var_7(var_9))

	local var_1_2 = arg_1_0._directPanelDftEvent

	var_4.SetEndEvent(var_1_2, function()
		SetActive = var_2_10000

		var_2_10000(arg_1_0._directPanel, false)

		return
	end)

	findTF = var_4
	arg_1_0._directContent = var_4(arg_1_0._tf, "direct/ad/list")
	arg_1_0._directGrids = {}
	findTF = var_4
	arg_1_0._directGridTpl = var_4(arg_1_0._tf, "direct/ad/list/grid_tpl")
	setActive = var_4

	var_4(arg_1_0._directGridTpl, false)

	for iter_1_0 = 1, var_0_4 do
		tf = var_1_3
		Instantiate = var_1_10010

		local var_1_3 = var_1_3(var_1_10010(arg_1_0._directGridTpl))

		SetParent = var_9

		var_9(var_1_3, arg_1_0._directContent)

		setActive = var_9

		var_9(var_1_3, false)

		table = var_9

		var_9.insert(arg_1_0._directGrids, var_1_3)
	end

	local var_1_4 = {}

	CutFruitGameConst = var_5
	var_1_4[1] = var_5.DIRECT_UP
	CutFruitGameConst = var_5
	var_1_4[2] = var_5.DIRECT_DOWN
	CutFruitGameConst = var_5
	var_1_4[3] = var_5.DIRECT_LEFT
	CutFruitGameConst = var_5
	var_1_4[4] = var_5.DIRECT_RIGHT
	arg_1_0._directRandomList = var_1_4
	setActive = var_1_4

	var_1_4(arg_1_0._directPanel, false)

	findTF = var_1_4
	arg_1_0.watermelonTF = var_1_4(arg_1_0._tf, "watermelon")
	GetComponent = var_4
	findTF = var_6

	local var_1_5 = var_6(arg_1_0.watermelonTF, "ad/spine")

	typeof = var_7
	SpineAnimUI = var_9
	arg_1_0.watermelonAnimUI = var_4(var_1_5, var_7(var_9))

	return
end

function var_0_0.Prepare(arg_3_0)
	arg_3_0:clearUI()

	setActive = var_1

	var_1(arg_3_0._directPanel, false)

	local var_3_0 = arg_3_0._data

	arg_3_0._charConfig = var_1.GetChar(var_3_0)

	local var_3_1 = arg_3_0._data

	arg_3_0._npcConfig = var_1.GetNpc(var_3_1)

	local var_3_2 = arg_3_0._data

	arg_3_0._targetConfig = var_1.GetConfig(var_3_2, "target")

	local var_3_3 = arg_3_0._data

	arg_3_0._distanceConfig = var_1.GetConfig(var_3_3, "distance")

	local var_3_4 = arg_3_0._data

	arg_3_0._speedConfig = var_1.GetConfig(var_3_4, "speed")

	arg_3_0:prepareChar(arg_3_0._charConfig, arg_3_0._charContent, function(arg_4_0)
		arg_3_0._spineChar = arg_4_0

		local var_4_0 = arg_3_0

		var_1.setCharAniamtion(var_4_0, arg_3_0._spineChar, "stand", true)

		return
	end)

	local var_3_5 = arg_3_0.watermelonAnimUI

	var_1.SetAction(var_3_5, "normal", 0)

	for iter_3_0 = 1, #arg_3_0._npcConfig do
		local var_3_6 = iter_3_0
		local var_3_7 = arg_3_0
		local var_3_8 = arg_3_0.prepareChar
		local var_3_9 = arg_3_0._npcConfig[iter_3_0]

		findTF = var_1_10010

		var_3_8(var_3_7, var_3_9, var_1_10010(arg_3_0._npcContent, var_3_6), function(arg_5_0)
			table = var_2_10001

			var_2_10001.insert(arg_3_0._npcSpines, arg_5_0)

			return
		end)
	end

	arg_3_0._stepDirectTime = var_0_5
	arg_3_0._inputFlag = false
	arg_3_0._gameOverFlag = false

	return
end

function var_0_0.Start(arg_6_0)
	for iter_6_0 = 1, #arg_6_0._npcSpines do
		arg_6_0:setCharAniamtion(arg_6_0._npcSpines[iter_6_0], "cheer", true)
	end

	arg_6_0._currrentPosition = 0
	arg_6_0._targetPosition = 0
	arg_6_0._gameOverStep = nil

	return
end

function var_0_0.Step(arg_7_0, arg_7_1)
	if arg_7_0._gameOverStep and arg_7_0._gameOverStep > 0 then
		arg_7_0._gameOverStep = arg_7_0._gameOverStep - arg_7_1

		if arg_7_0._gameOverStep <= 0 then
			arg_7_0._gameOverStep = nil

			local var_7_0 = arg_7_0._event
			local var_7_1 = var_2.emit

			SimpleMGEvent = var_1_10005

			var_7_1(var_7_0, var_1_10005.GAME_OVER, true)
		end

		return
	end

	if arg_7_0._stepDirectTime and arg_7_0._stepDirectTime > 0 then
		arg_7_0._stepDirectTime = arg_7_0._stepDirectTime - arg_7_1

		if arg_7_0._stepDirectTime <= 0 then
			arg_7_0._stepDirectTime = nil

			arg_7_0:SetDirectData(arg_7_0:getRandomDirect())
		end
	end

	if arg_7_0._currrentPosition < arg_7_0._targetPosition then
		local var_7_2 = arg_7_0._speedConfig * arg_7_1

		arg_7_0._currrentPosition = arg_7_0._currrentPosition + var_7_2

		if arg_7_0._currrentPosition > arg_7_0._targetPosition then
			arg_7_0._currrentPosition = arg_7_0._targetPosition
			var_1_10005 = arg_7_0

			arg_7_0.setCharAniamtion(var_1_10005, arg_7_0._spineChar, "stand", true)
		else
			var_1_10005 = arg_7_0

			arg_7_0.setCharAniamtion(var_1_10005, arg_7_0._spineChar, "walk", true)
		end

		var_1_10005 = arg_7_0._spineChar
		var_3.x = var_3.GetAnchoredPosition(var_1_10005).x + var_7_2

		local var_7_3 = arg_7_0._spineChar

		var_4.SetAnchoredPosition(var_7_3, var_3)
	end

	if arg_7_0._currrentPosition >= arg_7_0._targetConfig then
		local var_7_4 = arg_7_0._event
		local var_7_5 = var_2.emit

		SimpleMGEvent = var_1_10005

		var_7_5(var_7_4, var_1_10005.STOP_TIME_STEP, true)

		if not arg_7_0._gameOverFlag then
			arg_7_0._gameOverFlag = true
			arg_7_0._gameOverStep = 2

			arg_7_0:setCharAniamtion(arg_7_0._spineChar, "attack", false, "cheer", function()
				return
			end)

			local var_7_6 = arg_7_0.watermelonAnimUI

			var_2.SetActionCallBack(var_7_6, function(arg_9_0)
				if arg_9_0 == "finish" then
					local var_9_0 = arg_7_0.watermelonAnimUI

					var_1.SetAction(var_9_0, "action2", 0)

					local var_9_1 = arg_7_0.watermelonAnimUI

					var_1.SetActionCallBack(var_9_1, nil)
				end

				return
			end)

			local var_7_7 = arg_7_0.watermelonAnimUI

			var_2.SetAction(var_7_7, "action1", 0)
		end
	end

	return
end

function var_0_0.Stop(arg_10_0)
	return
end

function var_0_0.Clear(arg_11_0)
	return
end

function var_0_0.Resume(arg_12_0)
	return
end

function var_0_0.GameOver(arg_13_0)
	if not arg_13_0._gameOverFlag then
		arg_13_0:setCharAniamtion(arg_13_0._spineChar, "lose", true)
	end

	return
end

function var_0_0.Dispose(arg_14_0)
	local var_14_0 = arg_14_0.watermelonAnimUI

	var_1.SetActionCallBack(var_14_0, nil)

	local var_14_1 = arg_14_0._directPanelDftEvent

	var_1.SetEndEvent(var_14_1, nil)
	arg_14_0:clearUI()

	return
end

function var_0_0.CharMove(arg_15_0)
	arg_15_0._targetPosition = arg_15_0._targetPosition + arg_15_0._distanceConfig

	if arg_15_0._targetPosition > arg_15_0._targetConfig then
		arg_15_0._targetPosition = arg_15_0._targetConfig
	end

	return
end

function var_0_0.setCharAniamtion(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	if not arg_16_1 then
		return
	end

	if arg_16_3 then
		if arg_16_1:GetActionName() ~= arg_16_2 then
			arg_16_1:SetAction(arg_16_2, 0)
		end
	else
		arg_16_1:SetActionOnce(arg_16_2, 0, nil, function()
			if arg_16_4 then
				local var_17_0 = arg_16_1

				var_0.SetAction(var_17_0, arg_16_4, 0)
			end

			if arg_16_5 then
				arg_16_5()
			end

			return
		end)
	end

	return
end

function var_0_0.prepareChar(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	CutFruitGameConst = var_1_10004

	local var_18_0 = var_1_10004.character_name[arg_18_1]

	SpineAnimChar = var_1_10005

	local var_18_1 = var_1_10005.New()

	var_5.SetPaint(var_18_1, var_18_0)
	var_5:Load(true, function()
		local var_19_0 = var_0

		var_0.SetParent(var_19_0, arg_18_2)

		local var_19_1 = var_0
		local var_19_2 = var_0.SetLocalScale

		Vector3 = var_3

		var_19_2(var_19_1, var_3(1, 1, 1))

		local var_19_3 = var_0
		local var_19_4 = var_0.SetAnchoredPosition

		Vector2 = var_3

		var_19_4(var_19_3, var_3(0, 0))

		if arg_18_3 then
			arg_18_3(var_0)
		end

		return
	end)

	return
end

function var_0_0.clearUI(arg_20_0)
	if arg_20_0._spineChar then
		local var_20_0 = arg_20_0._spineChar

		var_1.Dispose(var_20_0)

		arg_20_0._spineChar = nil
	end

	if arg_20_0._npcSpines and #arg_20_0._npcSpines > 0 then
		for iter_20_0 = 1, #arg_20_0._npcSpines do
			local var_20_1 = arg_20_0._npcSpines[iter_20_0]

			var_5.Dispose(var_20_1)
		end

		arg_20_0._npcSpines = {}
	end

	return
end

function var_0_0.InputDirect(arg_21_0, arg_21_1)
	if not arg_21_0._inputFlag then
		return
	end

	arg_21_0._direct = arg_21_1

	if #arg_21_0._passList + 1 <= #arg_21_0._inputList then
		local var_21_0

		if arg_21_1 ~= arg_21_0._inputList[var_2] or not var_0_2 then
			var_21_0 = var_0_3
		end

		table = var_1_10005

		var_1_10005.insert(arg_21_0._passList, var_21_0)
	end

	arg_21_0:updateDirect()

	return
end

function var_0_0.SetDirectData(arg_22_0, arg_22_1)
	arg_22_0._inputList = arg_22_1
	arg_22_0._passList = {}

	for iter_22_0 = 1, #arg_22_0._directGrids do
		local var_22_0 = arg_22_0._directGrids[iter_22_0]
		local var_22_1

		if iter_22_0 <= #arg_22_1 then
			findTF = var_22_1
			var_22_1 = var_22_1(var_22_0, "ad")
			CutFruitGameConst = var_1_10008
			var_22_1.localEulerAngles = var_1_10008.DIRECT_ROTATION[arg_22_1[iter_22_0]].rotation
			setActive = var_22_1

			var_22_1(var_22_0, true)
		else
			setActive = var_22_1

			var_22_1(var_22_0, false)
		end
	end

	if #arg_22_1 > 0 then
		arg_22_0._inputFlag = true
		setActive = var_2

		var_2(arg_22_0._directPanel, true)
	end

	arg_22_0:updateDirect()

	return
end

function var_0_0.updateDirect(arg_23_0)
	for iter_23_0 = 1, #arg_23_0._inputList do
		local var_23_0 = arg_23_0._directGrids[iter_23_0]

		setActive = var_1_10006
		findTF = var_1_10008

		var_1_10006(var_1_10008(var_23_0, "ad/" .. var_0_1), false)

		setActive = var_1_10006
		findTF = var_1_10008

		var_1_10006(var_1_10008(var_23_0, "ad/" .. var_0_2), false)

		setActive = var_1_10006
		findTF = var_1_10008

		var_1_10006(var_1_10008(var_23_0, "ad/" .. var_0_3), false)

		if #arg_23_0._passList < iter_23_0 then
			setActive = var_1_10006
			findTF = var_1_10008

			var_1_10006(var_1_10008(var_23_0, "ad/" .. var_0_1), true)
		else
			setActive = var_1_10006
			findTF = var_1_10008

			var_1_10006(var_1_10008(var_23_0, "ad/" .. arg_23_0._passList[iter_23_0]), true)
		end
	end

	for iter_23_1 = 1, #arg_23_0._passList do
		if arg_23_0._passList[iter_23_1] == 2 then
			if arg_23_0._targetPosition < arg_23_0._targetConfig then
				arg_23_0._stepDirectTime = var_0_5
			end

			arg_23_0._inputFlag = false

			arg_23_0:SetPanelAnimation("direct_faild")

			return
		end
	end

	if #arg_23_0._passList == #arg_23_0._inputList then
		arg_23_0:CharMove()
		arg_23_0:SetPanelAnimation("direct_success")

		arg_23_0._passList = {}

		if arg_23_0._targetPosition < arg_23_0._targetConfig then
			arg_23_0._inputFlag = false
			arg_23_0._stepDirectTime = var_0_5
		end
	end

	return
end

function var_0_0.SetPanelAnimation(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0._directPanelAniamtor

	var_2.Play(var_24_0, arg_24_1)

	return
end

function var_0_0.getRandomDirect(arg_25_0)
	local var_25_0 = {}

	for iter_25_0 = 1, var_0_4 do
		table = var_1_10006
		var_1_10006 = var_1_10006.insert

		local var_25_1 = var_25_0
		local var_25_2 = arg_25_0._directRandomList

		math = var_1_10010

		var_1_10006(var_25_1, var_25_2[var_1_10010.random(1, #arg_25_0._directRandomList)])
	end

	return var_25_0
end

return var_0_0

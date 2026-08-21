local var_0_0 = class("CutFruitGameController")
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
	arg_1_0._charContent = findTF(arg_1_0._tf, "char")
	arg_1_0._npcContent = findTF(arg_1_0._tf, "npc")
	arg_1_0._directPanel = findTF(arg_1_0._tf, "direct")
	arg_1_0._directPanelAniamtor = GetComponent(findTF(arg_1_0._tf, "direct"), typeof(Animator))
	arg_1_0._directPanelDftEvent = GetComponent(findTF(arg_1_0._tf, "direct"), typeof(DftAniEvent))

	arg_1_0._directPanelDftEvent:SetEndEvent(function()
		SetActive(arg_1_0._directPanel, false)

		return
	end)

	arg_1_0._directContent = findTF(arg_1_0._tf, "direct/ad/list")
	arg_1_0._directGrids = {}
	arg_1_0._directGridTpl = findTF(arg_1_0._tf, "direct/ad/list/grid_tpl")

	setActive(arg_1_0._directGridTpl, false)

	for iter_1_0 = 1, var_0_4 do
		local var_1_0 = tf(Instantiate(arg_1_0._directGridTpl))

		SetParent(var_1_0, arg_1_0._directContent)
		setActive(var_1_0, false)
		table.insert(arg_1_0._directGrids, var_1_0)
	end

	arg_1_0._directRandomList = {
		CutFruitGameConst.DIRECT_UP,
		CutFruitGameConst.DIRECT_DOWN,
		CutFruitGameConst.DIRECT_LEFT,
		CutFruitGameConst.DIRECT_RIGHT
	}

	setActive(arg_1_0._directPanel, false)

	arg_1_0.watermelonTF = findTF(arg_1_0._tf, "watermelon")
	arg_1_0.watermelonAnimUI = GetComponent(findTF(arg_1_0.watermelonTF, "ad/spine"), typeof(SpineAnimUI))

	return
end

function var_0_0.Prepare(arg_3_0)
	arg_3_0:clearUI()
	setActive(arg_3_0._directPanel, false)

	arg_3_0._charConfig = arg_3_0._data:GetChar()
	arg_3_0._npcConfig = arg_3_0._data:GetNpc()
	arg_3_0._targetConfig = arg_3_0._data:GetConfig("target")
	arg_3_0._distanceConfig = arg_3_0._data:GetConfig("distance")
	arg_3_0._speedConfig = arg_3_0._data:GetConfig("speed")

	arg_3_0:prepareChar(arg_3_0._charConfig, arg_3_0._charContent, function(arg_4_0)
		arg_3_0._spineChar = arg_4_0

		arg_3_0:setCharAniamtion(arg_3_0._spineChar, "stand", true)

		return
	end)
	arg_3_0.watermelonAnimUI:SetAction("normal", 0)

	for iter_3_0 = 1, #arg_3_0._npcConfig do
		arg_3_0:prepareChar(arg_3_0._npcConfig[iter_3_0], findTF(arg_3_0._npcContent, iter_3_0), function(arg_5_0)
			table.insert(arg_3_0._npcSpines, arg_5_0)

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

			arg_7_0._event:emit(SimpleMGEvent.GAME_OVER, true)
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
		local var_7_0 = arg_7_0._speedConfig * arg_7_1

		arg_7_0._currrentPosition = arg_7_0._currrentPosition + arg_7_0._speedConfig * arg_7_1

		if arg_7_0._currrentPosition > arg_7_0._targetPosition then
			arg_7_0._currrentPosition = arg_7_0._targetPosition

			arg_7_0:setCharAniamtion(arg_7_0._spineChar, "stand", true)
		else
			arg_7_0:setCharAniamtion(arg_7_0._spineChar, "walk", true)
		end

		local var_7_1 = arg_7_0._spineChar:GetAnchoredPosition()

		var_7_1.x = var_7_1.x + var_7_0

		arg_7_0._spineChar:SetAnchoredPosition(var_7_1)
	end

	if arg_7_0._currrentPosition >= arg_7_0._targetConfig then
		arg_7_0._event:emit(SimpleMGEvent.STOP_TIME_STEP, true)

		if not arg_7_0._gameOverFlag then
			arg_7_0._gameOverFlag = true
			arg_7_0._gameOverStep = 2

			arg_7_0:setCharAniamtion(arg_7_0._spineChar, "attack", false, "cheer", function()
				return
			end)
			arg_7_0.watermelonAnimUI:SetActionCallBack(function(arg_9_0)
				if arg_9_0 == "finish" then
					arg_7_0.watermelonAnimUI:SetAction("action2", 0)
					arg_7_0.watermelonAnimUI:SetActionCallBack(nil)
				end

				return
			end)
			arg_7_0.watermelonAnimUI:SetAction("action1", 0)
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
	arg_14_0.watermelonAnimUI:SetActionCallBack(nil)
	arg_14_0._directPanelDftEvent:SetEndEvent(nil)
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
				arg_16_1:SetAction(arg_16_4, 0)
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
	local var_18_0 = SpineAnimChar.New()

	var_18_0:SetPaint(CutFruitGameConst.character_name[arg_18_1])
	var_18_0:Load(true, function()
		var_18_0:SetParent(arg_18_2)
		var_18_0:SetLocalScale(Vector3(1, 1, 1))
		var_18_0:SetAnchoredPosition(Vector2(0, 0))

		if arg_18_3 then
			arg_18_3(var_18_0)
		end

		return
	end)

	return
end

function var_0_0.clearUI(arg_20_0)
	if arg_20_0._spineChar then
		arg_20_0._spineChar:Dispose()

		arg_20_0._spineChar = nil
	end

	if arg_20_0._npcSpines and #arg_20_0._npcSpines > 0 then
		for iter_20_0 = 1, #arg_20_0._npcSpines do
			arg_20_0._npcSpines[iter_20_0]:Dispose()
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
		if arg_21_1 == arg_21_0._inputList[#arg_21_0._passList + 1] then
			local var_21_0 = var_0_2 or var_0_3

			table.insert(arg_21_0._passList, var_21_0)
			arg_21_0:updateDirect()

			return
		end
	end
end

function var_0_0.SetDirectData(arg_22_0, arg_22_1)
	arg_22_0._inputList = arg_22_1
	arg_22_0._passList = {}

	for iter_22_0 = 1, #arg_22_0._directGrids do
		if iter_22_0 <= #arg_22_1 then
			findTF(arg_22_0._directGrids[iter_22_0], "ad").localEulerAngles = CutFruitGameConst.DIRECT_ROTATION[arg_22_1[iter_22_0]].rotation

			setActive(arg_22_0._directGrids[iter_22_0], true)
		else
			setActive(arg_22_0._directGrids[iter_22_0], false)
		end
	end

	if #arg_22_1 > 0 then
		arg_22_0._inputFlag = true

		setActive(arg_22_0._directPanel, true)
	end

	arg_22_0:updateDirect()

	return
end

function var_0_0.updateDirect(arg_23_0)
	for iter_23_0 = 1, #arg_23_0._inputList do
		setActive(findTF(arg_23_0._directGrids[iter_23_0], "ad/" .. var_0_1), false)
		setActive(findTF(arg_23_0._directGrids[iter_23_0], "ad/" .. var_0_2), false)
		setActive(findTF(arg_23_0._directGrids[iter_23_0], "ad/" .. var_0_3), false)

		if iter_23_0 > #arg_23_0._passList then
			setActive(findTF(arg_23_0._directGrids[iter_23_0], "ad/" .. var_0_1), true)
		else
			setActive(findTF(arg_23_0._directGrids[iter_23_0], "ad/" .. arg_23_0._passList[iter_23_0]), true)
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
	arg_24_0._directPanelAniamtor:Play(arg_24_1)

	return
end

function var_0_0.getRandomDirect(arg_25_0)
	for iter_25_0 = 1, var_0_4 do
		table.insert({}, arg_25_0._directRandomList[math.random(1, #arg_25_0._directRandomList)])
	end

	return {}
end

return var_0_0

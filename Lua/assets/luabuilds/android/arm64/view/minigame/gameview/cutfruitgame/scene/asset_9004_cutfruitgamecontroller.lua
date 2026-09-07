local CutFruitGameController = class("CutFruitGameController")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 5
local var_0_5 = 2

function CutFruitGameController:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._data = arg_1_3
	self._spineChar = nil
	self._npcSpines = {}
	self._charContent = findTF(self._tf, "char")
	self._npcContent = findTF(self._tf, "npc")
	self._directPanel = findTF(self._tf, "direct")
	self._directPanelAniamtor = GetComponent(findTF(self._tf, "direct"), typeof(Animator))
	self._directPanelDftEvent = GetComponent(findTF(self._tf, "direct"), typeof(DftAniEvent))

	self._directPanelDftEvent:SetEndEvent(function()
		SetActive(self._directPanel, false)

		return
	end)

	self._directContent = findTF(self._tf, "direct/ad/list")
	self._directGrids = {}
	self._directGridTpl = findTF(self._tf, "direct/ad/list/grid_tpl")

	setActive(self._directGridTpl, false)

	for iter_1_0 = 1, var_0_4 do
		local var_1_0 = tf(Instantiate(self._directGridTpl))

		SetParent(var_1_0, self._directContent)
		setActive(var_1_0, false)
		table.insert(self._directGrids, var_1_0)
	end

	self._directRandomList = {
		CutFruitGameConst.DIRECT_UP,
		CutFruitGameConst.DIRECT_DOWN,
		CutFruitGameConst.DIRECT_LEFT,
		CutFruitGameConst.DIRECT_RIGHT
	}

	setActive(self._directPanel, false)

	self.watermelonTF = findTF(self._tf, "watermelon")
	self.watermelonAnimUI = GetComponent(findTF(self.watermelonTF, "ad/spine"), typeof(SpineAnimUI))

	return
end

function CutFruitGameController:Prepare()
	self:clearUI()
	setActive(self._directPanel, false)

	self._charConfig = self._data:GetChar()
	self._npcConfig = self._data:GetNpc()
	self._targetConfig = self._data:GetConfig("target")
	self._distanceConfig = self._data:GetConfig("distance")
	self._speedConfig = self._data:GetConfig("speed")

	self:prepareChar(self._charConfig, self._charContent, function(arg_4_0)
		self._spineChar = arg_4_0

		self:setCharAniamtion(self._spineChar, "stand", true)

		return
	end)
	self.watermelonAnimUI:SetAction("normal", 0)

	for iter_3_0 = 1, #self._npcConfig do
		self:prepareChar(self._npcConfig[iter_3_0], findTF(self._npcContent, iter_3_0), function(arg_5_0)
			table.insert(self._npcSpines, arg_5_0)

			return
		end)
	end

	self._stepDirectTime = var_0_5
	self._inputFlag = false
	self._gameOverFlag = false

	return
end

function CutFruitGameController:Start()
	for iter_6_0 = 1, #self._npcSpines do
		self:setCharAniamtion(self._npcSpines[iter_6_0], "cheer", true)
	end

	self._currrentPosition = 0
	self._targetPosition = 0
	self._gameOverStep = nil

	return
end

function CutFruitGameController:Step(arg_7_1)
	if self._gameOverStep and self._gameOverStep > 0 then
		self._gameOverStep = self._gameOverStep - arg_7_1

		if self._gameOverStep <= 0 then
			self._gameOverStep = nil

			self._event:emit(SimpleMGEvent.GAME_OVER, true)
		end

		return
	end

	if self._stepDirectTime and self._stepDirectTime > 0 then
		self._stepDirectTime = self._stepDirectTime - arg_7_1

		if self._stepDirectTime <= 0 then
			self._stepDirectTime = nil

			self:SetDirectData(self:getRandomDirect())
		end
	end

	if self._currrentPosition < self._targetPosition then
		local var_7_0 = self._speedConfig * arg_7_1

		self._currrentPosition = self._currrentPosition + self._speedConfig * arg_7_1

		if self._currrentPosition > self._targetPosition then
			self._currrentPosition = self._targetPosition

			self:setCharAniamtion(self._spineChar, "stand", true)
		else
			self:setCharAniamtion(self._spineChar, "walk", true)
		end

		local var_7_1 = self._spineChar:GetAnchoredPosition()

		var_7_1.x = var_7_1.x + var_7_0

		self._spineChar:SetAnchoredPosition(var_7_1)
	end

	if self._currrentPosition >= self._targetConfig then
		self._event:emit(SimpleMGEvent.STOP_TIME_STEP, true)

		if not self._gameOverFlag then
			self._gameOverFlag = true
			self._gameOverStep = 2

			self:setCharAniamtion(self._spineChar, "attack", false, "cheer", function()
				return
			end)
			self.watermelonAnimUI:SetActionCallBack(function(arg_9_0)
				if arg_9_0 == "finish" then
					self.watermelonAnimUI:SetAction("action2", 0)
					self.watermelonAnimUI:SetActionCallBack(nil)
				end

				return
			end)
			self.watermelonAnimUI:SetAction("action1", 0)
		end
	end

	return
end

function CutFruitGameController:Stop()
	return
end

function CutFruitGameController:Clear()
	return
end

function CutFruitGameController:Resume()
	return
end

function CutFruitGameController:GameOver()
	if not self._gameOverFlag then
		self:setCharAniamtion(self._spineChar, "lose", true)
	end

	return
end

function CutFruitGameController:Dispose()
	self.watermelonAnimUI:SetActionCallBack(nil)
	self._directPanelDftEvent:SetEndEvent(nil)
	self:clearUI()

	return
end

function CutFruitGameController:CharMove()
	self._targetPosition = self._targetPosition + self._distanceConfig

	if self._targetPosition > self._targetConfig then
		self._targetPosition = self._targetConfig
	end

	return
end

function CutFruitGameController:setCharAniamtion(arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
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

function CutFruitGameController:prepareChar(arg_18_1, arg_18_2, arg_18_3)
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

function CutFruitGameController:clearUI()
	if self._spineChar then
		self._spineChar:Dispose()

		self._spineChar = nil
	end

	if self._npcSpines and #self._npcSpines > 0 then
		for iter_20_0 = 1, #self._npcSpines do
			self._npcSpines[iter_20_0]:Dispose()
		end

		self._npcSpines = {}
	end

	return
end

function CutFruitGameController:InputDirect(arg_21_1)
	if not self._inputFlag then
		return
	end

	self._direct = arg_21_1

	if #self._passList + 1 <= #self._inputList then
		table.insert(self._passList, (arg_21_1 == self._inputList[#self._passList + 1] or nil) and (var_0_2 or var_0_3))
	end

	self:updateDirect()

	return
end

function CutFruitGameController:SetDirectData(arg_22_1)
	self._inputList = arg_22_1
	self._passList = {}

	for iter_22_0 = 1, #self._directGrids do
		if iter_22_0 <= #arg_22_1 then
			findTF(self._directGrids[iter_22_0], "ad").localEulerAngles = CutFruitGameConst.DIRECT_ROTATION[arg_22_1[iter_22_0]].rotation

			setActive(self._directGrids[iter_22_0], true)
		else
			setActive(self._directGrids[iter_22_0], false)
		end
	end

	if #arg_22_1 > 0 then
		self._inputFlag = true

		setActive(self._directPanel, true)
	end

	self:updateDirect()

	return
end

function CutFruitGameController:updateDirect()
	for iter_23_0 = 1, #self._inputList do
		setActive(findTF(self._directGrids[iter_23_0], "ad/" .. var_0_1), false)
		setActive(findTF(self._directGrids[iter_23_0], "ad/" .. var_0_2), false)
		setActive(findTF(self._directGrids[iter_23_0], "ad/" .. var_0_3), false)

		if iter_23_0 > #self._passList then
			setActive(findTF(self._directGrids[iter_23_0], "ad/" .. var_0_1), true)
		else
			setActive(findTF(self._directGrids[iter_23_0], "ad/" .. self._passList[iter_23_0]), true)
		end
	end

	for iter_23_1 = 1, #self._passList do
		if self._passList[iter_23_1] == 2 then
			if self._targetPosition < self._targetConfig then
				self._stepDirectTime = var_0_5
			end

			self._inputFlag = false

			self:SetPanelAnimation("direct_faild")

			return
		end
	end

	if #self._passList == #self._inputList then
		self:CharMove()
		self:SetPanelAnimation("direct_success")

		self._passList = {}

		if self._targetPosition < self._targetConfig then
			self._inputFlag = false
			self._stepDirectTime = var_0_5
		end
	end

	return
end

function CutFruitGameController:SetPanelAnimation(arg_24_1)
	self._directPanelAniamtor:Play(arg_24_1)

	return
end

function CutFruitGameController:getRandomDirect()
	local var_25_0 = {}

	for iter_25_0 = 1, var_0_4 do
		table.insert(var_25_0, self._directRandomList[math.random(1, #self._directRandomList)])
	end

	return var_25_0
end

return CutFruitGameController

-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/hacktool/RogueHackToolDiceMultipleTestView.lua

module("logic.extensions.roguelike.view.explore.hacktool.RogueHackToolDiceMultipleTestView", package.seeall)

local M = class("RogueHackToolDiceMultipleTestView", ViewComponent)
local TorqueMod = Vector3.New(0, 0, 20000)

function M:buildUI()
	self._btnThrow = self:getBtn("dice_mock_roguelike_view_771968937")
	self._btnText = self:getText("dice_mock_roguelike_view_-1652676790")

	local attrRoot = self:getGo("dice_mock_roguelike_view_-992129325")

	self.sliders = {}
	self.inputs = {}

	for i = 1, 12 do
		local attr = goutil.findChild(attrRoot, "attr_" .. i)
		local slider = Astral.SliderAdapter.GetFrom(attr, "Slider")
		local input = Astral.InputFieldAdapter.GetFrom(attr, "Image/InputField")

		assert(slider and input, "RogueHackToolDiceMultipleTestView：未找到相关控件")
		table.insert(self.sliders, slider)
		table.insert(self.inputs, input)
	end
end

function M:onEnter()
	local params = self:getFirstParam()
	local collider = params.collider
	local floor = goutil.findChild(collider, "bottom")

	self._dices = params.dices
	self._dicesWall = params.wallDices
	self._leftWall = goutil.findChild(collider, "left2")
	self._wallMaterial = self._leftWall:GetComponent("BoxCollider").material
	self._floorMaterial = floor:GetComponent("BoxCollider").material
	self._diceRigidbodys = {}
	self._diceGravitys = {}

	for i = 1, 8 do
		local body = params.dices[i]:GetComponent("Rigidbody")

		body.drag = 0.01

		table.insert(self._diceRigidbodys, body)

		local g = params.dices[i]:GetComponent("ConstantForce")

		table.insert(self._diceGravitys, g)
	end

	self._diceMaterial = self._diceRigidbodys[1]:GetComponent("BoxCollider").material
	self._btnText.text = "投掷"
	self._diceStatus = 0

	self:_updateInputValue()
	self:_changeDiceNum()

	for i = 1, 8 do
		local rigidbody = self._diceRigidbodys[i]

		rigidbody.isKinematic = true
	end
end

function M:onExit()
	self._dices = nil
	self._diceRigidbodys = nil
	self._leftWall = nil
	self._wallMaterial = nil
	self._floorMaterial = nil
	self._diceMaterial = nil
end

function M:bindEvents()
	self._btnThrow:AddClickListener(self._onClickThrow, self)

	for i = 1, 10 do
		self.sliders[i]:AddOnValueChanged(self._updateInputValue, self)
	end

	self.sliders[11]:AddOnValueChanged(self._changeDiceNum, self)
	self.sliders[12]:AddOnValueChanged(self._updateInputValue, self)
end

function M:unbindEvents()
	self._btnThrow:RemoveClickListener()

	for i = 1, 12 do
		self.sliders[i]:RemoveOnValueChanged()
	end
end

function M:_addForceToDice()
	RoguelikeController.instance:stopDiceFloat()

	if not self._wallCollider then
		local collider = RogueMgr.instance:getRogueFlow().mapMgr:getJudgeColliderGo()

		self._wallCollider = goutil.findChild(collider, "right2"):GetComponent("BoxCollider")
	end

	self._wallCollider.enabled = true

	self:_updateParams()

	local forceImpuse = Vector3.New(tonumber(self.inputs[5]:GetText()), tonumber(self.inputs[6]:GetText()), tonumber(self.inputs[7]:GetText()))

	self._forceImpuse = forceImpuse / 10

	local min = tonumber(self.inputs[2]:GetText())
	local max = tonumber(self.inputs[3]:GetText())

	self._curIndex = 0

	settimer(0.5, self.gravityAll, self, false)
	settimer(2.5, self.toHitWall, self, false)

	for i = 1, self._diceNum do
		self._diceRigidbodys[i]:AddForce(self._forceImpuse, UnityEngine.ForceMode.Impulse)
		math.randomseed(os.time())

		local random = math.random(min, max)

		self._diceRigidbodys[i].angularVelocity = Vector3.New(0, 0, 1000) * random
	end

	self._diceStatus = 1
	self._timeStop = 2

	settimer(0.1, self.checkDiceStop, self, true)
end

function M:toHitWall()
	self._wallCollider.enabled = false
	self._rotateAnis = {}

	for i = 1, 8 do
		self:doFloatAnimation(i)
	end

	settimer(1.3, self.toHitWall2, self, false)
end

function M:toHitWall2()
	for i = 1, 8 do
		local dice1 = self._dices[i]
		local dice2 = self._dicesWall[8 - i + 1]
		local se = self._rotateAnis[i]

		settimer(i / 5, function()
			self:doHitAnimation(dice1, dice2, se)
		end, self, false)
	end
end

function M:doFloatAnimation(i)
	local dice = self._dices[i]
	local rigidbody = dice:GetComponent("Rigidbody")

	rigidbody.isKinematic = true

	local diceTrans = dice.transform
	local oldPos = diceTrans.position
	local floatPos = Vector3.New(oldPos.x, oldPos.y + 10, oldPos.z)
	local se = diceTrans:DOLocalRotate(Vector3.New(math.random(0, 360), math.random(0, 360), math.random(0, 360)), 1.5):SetLoops(-1, DG.Tweening.LoopType.Incremental):SetEase(DG.Tweening.Ease.Linear)

	diceTrans:DOMove(floatPos, 1):SetEase(DG.Tweening.Ease.InOutQuint)

	self._rotateAnis[i] = se
end

function M:doHitAnimation(dice, diceWall, se, i)
	if i then
		se = self._rotateAnis[i]
	end

	if se then
		se:Kill()

		se = null
	end

	local pos = diceWall.transform.position
	local diceTrans = dice.transform
	local hitpos = Vector3.New(pos.x - 1.6, pos.y, pos.z)
	local dis = Vector3.Distance(hitpos, diceTrans.position)
	local hitTime = dis / 20 * 0.1

	diceTrans:DOMove(hitpos, hitTime):SetEase(DG.Tweening.Ease.InQuint):OnComplete(function()
		self:hitAfter(dice, diceWall)
	end, self)
end

function M:hitAfter(dice1, dice2)
	local rigidbody = dice2:GetComponent("Rigidbody")

	rigidbody.isKinematic = true

	local diceTrans = dice2.transform
	local oldPos = diceTrans.position
	local floatPos = Vector3.New(oldPos.x + 30, oldPos.y, oldPos.z)

	diceTrans:DOMove(floatPos, 0.2):SetEase(DG.Tweening.Ease.Linear)

	local rigidbody1 = dice1:GetComponent("Rigidbody")

	rigidbody1.isKinematic = false
	rigidbody1.useGravity = true

	local gForce = rigidbody1.gameObject:GetComponent("ConstantForce")

	if gForce then
		gForce.force = Vector3.New(0, -40, 0)
		gForce.enabled = true

		settimer(0.4, function()
			gForce.force = Vector3.New(0, -2, 0)
		end, self, false)
	end

	local vector3 = Vector3.New(math.random(-3, -2), 4.6, math.random(-2, 2))

	rigidbody1:AddForce(vector3, UnityEngine.ForceMode.Impulse)
end

function M:_throwOne()
	if self._curIndex < self._diceNum then
		self._curIndex = self._curIndex + 1

		self._diceRigidbodys[self._curIndex]:AddForce(self._forceImpuse, UnityEngine.ForceMode.Impulse)
	else
		removetimer(self._throwOne, self)
	end
end

function M:gravityAll()
	for i = 1, self._diceNum do
		self._diceGravitys[i].force = Vector3.New(0, -2, 0)
	end

	removetimer(self.gravityAll, self)
end

function M:_resetDices()
	for i = 1, 8 do
		local rigidbody = self._diceRigidbodys[i]

		rigidbody.isKinematic = true

		local tans = self._dicesWall[i]
		local pos = Vector3.New(20, 1 + math.floor(i / 5) * 1.5, -((i - 1) % 4) * 1.5)

		tans.transform.position = pos
	end

	RoguelikeController.instance:flyToOrigin()

	self._diceStatus = 3
	self._timeStop = 1

	settimer(0.1, self.resetDiceStatus, self, true)
end

function M:_updateParams()
	local mass = tonumber(self.inputs[1]:GetText())

	self._gravityAcceleration = Vector3.New(0, -10000 * mass, 0)

	for i = 1, self._diceNum do
		local rigidbody = self._diceRigidbodys[i]

		rigidbody.mass = mass
		rigidbody.isKinematic = false
		self._diceGravitys[i].force = Vector3.New(0, -10, 0) * tonumber(self.inputs[12]:GetText())
		self._diceGravitys[i].enabled = true
	end

	self._floorMaterial.bounciness = tonumber(self.inputs[8]:GetText())
	self._floorMaterial.dynamicFriction = tonumber(self.inputs[9]:GetText())
	self._wallMaterial.bounciness = tonumber(self.inputs[10]:GetText())
end

function M:_updateInputValue()
	for i = 1, 12 do
		local value = self.sliders[i]:GetValue()

		value = tostring(value)

		self.inputs[i]:SetText(value)
	end
end

function M:_changeDiceNum()
	local value = self.sliders[11]:GetValue()

	self.inputs[11]:SetText(tostring(value))

	for i = 1, 8 do
		goutil.setActive(self._dices[i], i <= value)
	end

	self._diceNum = value
end

function M:_onClickThrow()
	if self._diceStatus == 1 then
		print("等待上次投掷结果。。。")
	elseif self._diceStatus == 2 then
		self:_resetDices()
	elseif self._diceStatus == 3 then
		print("等待还原")
	else
		self:_addForceToDice()
	end
end

function M:checkDiceStop()
	self._timeStop = self._timeStop - 0.1

	if self._timeStop > 0 then
		self._btnText.text = string.format("冷却中：%.1f", self._timeStop)
	else
		removetimer(self.checkDiceStop, self)

		self._btnText.text = "还原"
		self._diceStatus = 2
		self._timeStop = 0
	end
end

function M:resetDiceStatus()
	self._timeStop = self._timeStop - 0.1

	if self._timeStop > 0 then
		self._btnText.text = string.format("还原中：%.1f", self._timeStop)
	else
		removetimer(self.resetDiceStatus, self)

		self._btnText.text = "投掷"
		self._diceStatus = 0
		self._timeStop = 0
	end
end

return M

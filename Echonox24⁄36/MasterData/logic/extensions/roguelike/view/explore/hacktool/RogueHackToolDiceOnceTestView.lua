-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/hacktool/RogueHackToolDiceOnceTestView.lua

module("logic.extensions.roguelike.view.explore.hacktool.RogueHackToolDiceOnceTestView", package.seeall)

local M = class("RogueHackToolDiceOnceTestView")
local kDefaultCameraPos = Vector3.New(0, 15, 0)

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._btnThrow = Astral.ButtonAdapter.GetFrom(self._mainGO, "btnBreak")
	self._goDiceImg = goutil.findChild(self._mainGO, "dice")

	local attrRoot = goutil.findChild(self._mainGO, "right/content")

	self.sliders = {}
	self.inputs = {}

	for i = 1, 10 do
		local attr = goutil.findChild(attrRoot, "attr_" .. i)
		local slider = Astral.SliderAdapter.GetFrom(attr, "Slider")
		local input = Astral.InputFieldAdapter.GetFrom(attr, "Image/InputField")

		assert(slider and input, "RogueHackToolDiceOnceTestView：未找到相关控件")
		table.insert(self.sliders, slider)
		table.insert(self.inputs, input)
	end

	self._effect = FullscreenPhotoEffect.Get(self._goDiceImg)

	self._effect:clear()
end

function M:onEnter()
	self:loadGuessDice()
	self:_updateInputValue()
end

function M:onExit()
	self._effect:clear()
	removetimer(self.checkDiceStop, self)
end

function M:bindEvents()
	self._btnThrow:AddClickListener(self._onClickThrow, self)

	for i = 1, 10 do
		self.sliders[i]:AddOnValueChanged(self._updateInputValue, self)
	end
end

function M:unbindEvents()
	self._btnThrow:RemoveClickListener()

	for i = 1, 10 do
		self.sliders[i]:RemoveOnValueChanged()
	end
end

function M:destroyUI()
	self._effect = nil
	self.sliders = nil
	self.inputs = nil
end

function M:loadGuessDice()
	local path = GameUrl.getScenePrefabUrl("common_npc_props/npc_shaizi/prefab/guess_dice_bound")

	self._effect:showEffects(path)
	self._effect:setCameraRotation(90, 45, 0)
	self._effect:setCameraPosition(kDefaultCameraPos.x, kDefaultCameraPos.y, kDefaultCameraPos.z)
	self._effect:setEffectLoadedCallback(self._effectCallback, self)

	local scale = self._goDiceImg.transform.localScale

	if scale.x < 2 then
		self._goDiceImg.transform.localScale = scale * 2
	end
end

function M:_effectCallback(inst, _)
	self._bgInst = inst

	local dice = goutil.findChild(inst, "guess_dice")

	self._diceRigidbody = dice:GetComponent("Rigidbody")
	self._floorMaterial = goutil.findChild(inst, "bound5"):GetComponent("BoxCollider").material
	self._wallMaterials = {}

	for i = 1, 4 do
		local wall = goutil.findChild(inst, "bound" .. i)
		local mt = wall:GetComponent("BoxCollider").material

		table.insert(self._wallMaterials, mt)
	end
end

function M:_addForceToDice()
	self._inAni = true

	self:_updateRigidbodyParams()

	local rigidbody = self._diceRigidbody

	if rigidbody then
		local torqueImpuse = Vector3.New(tonumber(self.inputs[2]:GetText()), tonumber(self.inputs[3]:GetText()), tonumber(self.inputs[4]:GetText()))
		local forceImpuse = Vector3.New(tonumber(self.inputs[5]:GetText()), tonumber(self.inputs[6]:GetText()), tonumber(self.inputs[7]:GetText()))

		rigidbody:AddTorque(torqueImpuse * 10, UnityEngine.ForceMode.Impulse)
		rigidbody:AddForce(forceImpuse, UnityEngine.ForceMode.Impulse)
	end

	settimer(1.8, self.checkDiceStop, self, false)
end

function M:_updateRigidbodyParams()
	local rigidbody = self._diceRigidbody

	rigidbody.transform.position = self._bgInst.transform.position + Vector3.New(0, 4, 0)
	rigidbody.mass = tonumber(self.inputs[1]:GetText())
	self._floorMaterial.bounciness = tonumber(self.inputs[8]:GetText())
	self._floorMaterial.dynamicFriction = tonumber(self.inputs[9]:GetText())

	for _, v in ipairs(self._wallMaterials) do
		v.bounciness = tonumber(self.inputs[10]:GetText())
	end
end

function M:_updateInputValue()
	for i = 1, 10 do
		local value = self.sliders[i]:GetValue()

		value = tostring(value)

		self.inputs[i]:SetText(value)
	end
end

function M:_updateSliderValue()
	for i = 1, 10 do
		local value = self.inputs[i]:GetText()

		value = tonumber(value)

		self.sliders[i]:SetValueWithoutNotify(value)
	end
end

function M:_onClickThrow()
	if self._inAni then
		print("等待上次投掷结果。。。")

		return
	end

	self._diceRigidbody.velocity = Vector3.New(0, 0, 0)

	self:_addForceToDice()
end

function M:_onClickClose()
	if self._inAni then
		return
	end

	self:close()
end

function M:checkDiceStop()
	self._inAni = false
end

return M

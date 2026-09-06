-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoQiHeroDamageNumber.lua

module("logic.extensions.aoqihero.view.AoQiHeroDamageNumber", package.seeall)

local AoQiHeroDamageNumber = class("AoQiHeroDamageNumber")

function AoQiHeroDamageNumber:ctor(componetContainer)
	self._container = componetContainer
	self._hudTextGo = goutil.findChild(self._container, "hudText")
	self._hudText = goutil.findChildComponent(self._container, "hudText", "SpringHUDText")
	self._hudText.tweenScale = false
end

function AoQiHeroDamageNumber:initCell(componetContainer, cloneTextObject, type)
	self._numObj = goutil.cloneAndSetParent(cloneTextObject, self._hudTextGo.transform)
	self._imageNum = self._numObj:GetComponent("UIImgNumeralText")
	self._imageNum.manual = true
	self._hudTransform = self._imageNum.transform
	self._type = type

	GameUtil.setLocalPos(self._numObj, 0, 0, 0)
end

function AoQiHeroDamageNumber:setValue(num)
	self.damage = math.floor(num)

	self._imageNum:SetText(self.damage)
end

function AoQiHeroDamageNumber:start(obj)
	local txt = tostring(self.damage)

	if self.isTreated or self.damage > 0 then
		txt = "+" .. txt
	end

	self._imageNum:SetText(txt)
	GameUtil.SetActive(self._container, true)
	GameUtil.SetActive(self._hudTextGo, false)
	self._hudText:SetDelayTimeout(self.isLast and 0.5 or -1)
	self._hudText:StartSpring()
	self:_prepareTween()
	self:_appear(0)

	self.targetObj = obj
	self.isInit = false
end

function AoQiHeroDamageNumber:isDone()
	return self._hudText:IsStop() and self._currIndex > self._activeCount
end

function AoQiHeroDamageNumber:update(deltaTime)
	self._time = self._time + deltaTime

	if self._time >= 0.05 and self._currIndex <= self._activeCount then
		self._time = self._time - 0.05
		self._currIndex = self._currIndex + 1

		if self._currIndex < self._activeCount then
			self:_appear(self._currIndex)
		end
	end

	if not self.isInit then
		GameUtil.SetActive(self._hudTextGo, true)

		local pos = GameUtil.getLocalPos(self.targetObj)

		GameUtil.setLocalPos(self._container, pos.x, pos.y, pos.z)

		self.isInit = true
	end
end

function AoQiHeroDamageNumber:_prepareTween()
	self._activeCount = self._imageNum.Count
	self._currIndex = 0
	self._time = 0

	for i = 0, self._activeCount - 1 do
		self._hudTransform:GetChild(i).gameObject:SetActive(false)
	end
end

function AoQiHeroDamageNumber:_appear(i)
	local go = self._hudTransform:GetChild(i).gameObject
	local x, y, z = Framework.TransformUtil.GetLocalPos(go.transform, nil, nil, nil)
	local sy = math.random(-40, 40)

	UnityTweens.TweenPosition.StartTween(go, Vector3.New(x, sy, z), Vector3.New(x, y, z), 0.2, UnityTweens.EaseType.easeInOutBack)
	go:SetActive(true)
end

function AoQiHeroDamageNumber:onDestroy()
	goutil.destroy(self._container.gameObject)
end

return AoQiHeroDamageNumber

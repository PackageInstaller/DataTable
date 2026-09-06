-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/actintroduce/view/AI_Advertisement.lua

module("logic.extensions.summerlottery.view.AI_Advertisement", package.seeall)

local AI_Advertisement = class("AI_Advertisement")

AI_Advertisement.PageType1 = 1
AI_Advertisement.PageType2 = 2

function AI_Advertisement:ctor(mainGo)
	self._mainGo = mainGo
	self._cardCell = goutil.findChild(mainGo, "cardCell")
	self._cardContainer = goutil.findChild(mainGo, "cardContainer")
	self._items = {}
	self._item2Infos = {}
	self._pagCon = goutil.findChild(mainGo, "pagCon")
	self._bHasDotComp = self._pagCon ~= nil

	if self._bHasDotComp then
		self._dot = goutil.findChild(self._pagCon, "dot")

		goutil.setActive(self._dot, false)
	end

	self._dots = {}

	goutil.setActive(self._cardCell, false)
end

function AI_Advertisement:play(params)
	self._params = params

	self:stop()

	local duration = math.max(self:_getParam("duration", 2), 1)

	self._tweenDuration = 0.4 * duration
	self._dataList = self:_getParam("dataList", {})
	self._dataLen = #self._dataList
	self._showLen = math.min(self:_getParam("showLen", self._dataLen), self._dataLen) + 1
	self._pageType = self:_getParam("pageType", AI_Advertisement.PageType1)
	self._margin = self:_getParam("margin", 0)
	self._alphaStep = self:_getParam("alphaStep", 0.5)
	self._angleStep = self:_getParam("angleStep", 0)
	self._bTween = self:_getParam("bTween", false)
	self._selectOneCallback = self:_getParam("selectOneCallback")
	self._firstIndex = 1

	self:_initCards()
	settimer(duration, self._onTimer, self)
	goutil.setActive(self._mainGo, true)
end

function AI_Advertisement:stop()
	for i, v in ipairs(self._dots) do
		GameUtil.rmClickHandler(v.dot)
		goutil.destroy(v.dot)
	end

	self._dots = {}

	removetimer(self._onTimer, self)
	goutil.setActive(self._mainGo, false)
end

function AI_Advertisement:_onTimer()
	if self._bTween then
		self:_tween()
	else
		self:_updateDataAndInvalidateAll()
	end
end

function AI_Advertisement:dispose()
	while #self._items > 0 do
		local item = table.remove(self._items, #self._items)

		self:_clearOne(item)
	end

	self:stop()
end

function AI_Advertisement:_initCards()
	while #self._items > self._showLen do
		local item = table.remove(self._items, #self._items)

		self:_clearOne(item)
	end

	while #self._items < self._showLen do
		local item = goutil.cloneAndSetParent(self._cardCell, self._cardContainer.transform)

		goutil.setActive(item, true)

		self._item2Infos[item] = {}

		table.insert(self._items, item)
	end

	if self._bHasDotComp then
		for i = 1, self._dataLen do
			local dot = goutil.cloneAndSetParent(self._dot, self._pagCon.transform)

			goutil.setActive(dot, true)
			GameUtil.addClickHandler(dot, GameUtil.handler(self._onClickDot, self, i))

			local info = {
				dot = dot
			}

			if self._pageType == AI_Advertisement.PageType1 then
				info.imgChange = dot:GetComponent("UIImageSpriteChange")
			elseif self._pageType == AI_Advertisement.PageType2 then
				info.mask = goutil.findChild(dot, "mask")
			end

			table.insert(self._dots, info)
		end
	end

	self:_invalidateAll()
end

function AI_Advertisement:_tween()
	for i = 1, self._showLen do
		local item = self._items[self._showLen - i + 1]

		self._item2Infos[item].tween = self:_setOneTween(i, item)
	end
end

function AI_Advertisement:_setOneTween(i, item)
	local function updateTween(num)
		local image = self._item2Infos[item].image
		local subOrder = i - 1 - num

		GameUtil.setLocalPos(item, -subOrder * self._margin, 0, 0)
		GameUtil.setLocalRotation(item, 0, 0, subOrder * self._angleStep)

		if i == 1 then
			Game.ImageUtil.SetImageAlpha(image, 1 - num)
		else
			Game.ImageUtil.SetImageAlpha(image, 1 + subOrder * self._alphaStep)
		end

		if num >= 1 and i == 1 then
			self:_updateDataAndInvalidateAll()
		end
	end

	goutil.setActive(item, true)

	local sequence = DG.Tweening.DOTween.Sequence()
	local tweener1 = TweenUtil.DOTweenNum(0, 1, self._tweenDuration, updateTween, {})

	sequence:Append(tweener1)

	return sequence
end

function AI_Advertisement:_updateDataAndInvalidateAll()
	self._firstIndex = self._firstIndex + 1

	if self._firstIndex > self._dataLen then
		self._firstIndex = 1
	end

	self:_invalidateAll()
end

function AI_Advertisement:_invalidateAll()
	for i = 1, self._showLen do
		local order = i
		local item = self._items[self._showLen - order + 1]
		local tween = self._item2Infos[item].tween

		if tween then
			tween:Kill(false)
		end

		local index = self._firstIndex + i - 1

		if index > self._dataLen then
			index = index - self._dataLen
		end

		local data = self._dataList[index]

		self:_updateOne(item, order, data)
	end

	if self._bHasDotComp then
		for i = 1, self._dataLen do
			local info = self._dots[i]

			if self._pageType == AI_Advertisement.PageType1 then
				local imgChange = info.imgChange

				if self._firstIndex == i then
					imgChange:SetState(1)
				else
					imgChange:SetState(0)
				end
			elseif self._pageType == AI_Advertisement.PageType2 then
				GameUtil.SetActive(info.mask, self._firstIndex == i)
			end
		end
	end

	GameUtil.callBack(self._selectOneCallback, self._firstIndex)
end

function AI_Advertisement:_updateOne(item, order, data)
	if not data then
		goutil.setActive(item, false)

		return
	end

	uGuiUtil.clearImage(item)
	uGuiUtil.setSpriteToImage(item, uGuiUtil.SpriteType.BigBg, data)

	local image = self._item2Infos[item].image

	if not image then
		self._item2Infos[item].image = item:GetComponent("Image")
		image = self._item2Infos[item].image
	end

	local subOrder = order - 1

	GameUtil.setLocalPos(item, -subOrder * self._margin, 0, 0)
	GameUtil.setLocalRotation(item, 0, 0, subOrder * self._angleStep)
	Game.ImageUtil.SetImageAlpha(image, 1 - subOrder * self._alphaStep)
	goutil.setActive(item, order <= self._showLen - 1)
end

function AI_Advertisement:_clearOne(item)
	uGuiUtil.clearImage(item)

	local tween = self._item2Infos[item].tween

	if tween then
		tween:Kill(false)
	end

	self._item2Infos[item] = nil

	goutil.destroy(item)
end

function AI_Advertisement:_getParam(key, defaultValue)
	if self._params[key] ~= nil then
		return self._params[key]
	end

	return defaultValue
end

function AI_Advertisement:_onClickDot(i)
	self._firstIndex = i

	self:_invalidateAll()
end

return AI_Advertisement

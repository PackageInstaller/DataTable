-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/photo/MultiPhotoEffect.lua

module("logic.common.photo.MultiPhotoEffect", package.seeall)

local M = class("MultiPhotoEffect")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._multiLoader = MultiResLoader.New()
	self._photo = Astral.PhotoBase.Add(self._go)
	self._rtWidth = PhotoUtil.PartRTWidth
	self._rtHeight = PhotoUtil.PartRTHeight
	self._effectLoadedCallback = nil
	self._effectLoadedCallbackObj = nil
	self._effectOnePlayFinishCallback = nil
	self._effectOnePlayFinishCallbackObj = nil
	self._bInitUVRect = true
	self._urls = {}
	self._goInstList = {}

	PhotoUtil.initPhotoSetting()
	self:_initRawImage()
end

function M:_initRawImage()
	if not goutil.isNil(self._go) then
		self._rawImage = self._go:GetComponent(typeof(UnityEngine.UI.RawImage))

		if self._rawImage == nil then
			self._rawImage = self._go:AddComponent(typeof(UnityEngine.UI.RawImage))
		end

		self._rawImage.enabled = false
		self._rawImage.raycastTarget = false
		self._rawImage.material = PhotoUtil.getEffMaterial()
	end
end

function M:setRawImageDefault()
	self._rawImage.material = PhotoUtil.getEffMaterial()
end

function M:_setRawImageUVRect(rtWidth, rtHeight)
	if self._bInitUVRect and self._rawImage then
		self._rtWidth = rtWidth
		self._rtHeight = rtHeight

		PhotoUtil.setRTCapacity(rtWidth, rtHeight)

		local uvRectW = math.min(1, goutil.getWidth(self._go.transform) / rtWidth)
		local uvRectH = math.min(1, goutil.getHeight(self._go.transform) / rtHeight)
		local uvRectX = (1 - uvRectW) * 0.5
		local uvRectY = (1 - uvRectH) * 0.5

		self._rawImage.uvRect = UnityEngine.Rect.New(uvRectX, uvRectY, uvRectW, uvRectH)
		self._bInitUVRect = false
	end
end

function M:getRawImage()
	return self._rawImage
end

function M:setEffectLoadedCallback(callback, callbackObj)
	self._effectLoadedCallback = callback
	self._effectLoadedCallbackObj = callbackObj
end

function M:setEffectOnePlayFinishCallback(callback, callbackObj)
	self._effectOnePlayFinishCallback = callback
	self._effectOnePlayFinishCallbackObj = callbackObj
end

function M:setClickEnable(bRaycastTarget)
	if self._rawImage then
		self._rawImage.raycastTarget = bRaycastTarget
	end
end

function M:setClickCallback(callback, callbackObj)
	if callback == nil then
		return
	end

	if goutil.isNil(self._go) then
		return
	end

	if not self._btnClick then
		local compButton = self._go:GetComponent(typeof(UnityEngine.UI.Button))

		if compButton == nil then
			self._go:AddComponent(typeof(UnityEngine.UI.Button))
		end

		self._btnClick = Astral.ButtonAdapter.Get(self._go)

		self._btnClick:AddClickListener(callback, callbackObj)
	end
end

function M:showSmallEffect(...)
	local urls = {
		...
	}

	if not urls or #urls == 0 then
		return
	end

	self:loadRes(urls, PhotoUtil.SmallRTWidth, PhotoUtil.SmallRTHeight)
end

function M:showPartEffect(...)
	local urls = {
		...
	}

	if not urls or #urls == 0 then
		return
	end

	self:loadRes(urls, PhotoUtil.PartRTWidth, PhotoUtil.PartRTHeight)
end

function M:showFullScreneEffect(...)
	local urls = {
		...
	}

	if not urls or #urls == 0 then
		return
	end

	self:loadRes(urls, PhotoUtil.RTWidth, PhotoUtil.RTHeight)
end

function M:showMaxScreneEffect(...)
	local urls = {
		...
	}

	if not urls or #urls == 0 then
		return
	end

	self:loadRes(urls, PhotoUtil.RTWidth, PhotoUtil.RTWidth)
end

function M:showEffect(type, ...)
	if not self._showFunc then
		self._showFunc = {}
		self._showFunc[CommEnum.EffectSize.Small] = self.showSmallEffect
		self._showFunc[CommEnum.EffectSize.Part] = self.showPartEffect
		self._showFunc[CommEnum.EffectSize.FullScreen] = self.showFullScreneEffect
		self._showFunc[CommEnum.EffectSize.MaxSceneEffect] = self.showFullScreneEffect
	end

	self._showFunc[type](self, ...)
end

function M:loadRes(urls, rtWidth, rtHeight)
	if self._photo == nil then
		return
	end

	self._rawImage.material = PhotoUtil.getEffMaterial()

	self:_setRawImageUVRect(rtWidth, rtHeight)
	self._photo:TurnOn(rtWidth, rtHeight)

	self._isOn = true

	local renderTexture = self._photo and self._photo.producer and self._photo.producer.renderTexture

	if renderTexture == nil then
		printError("renderTexture is nil, self._go=", self._go.name)

		self._rawImage.enabled = false

		return
	end

	local len = #urls

	for i = 1, len do
		if not self._urls then
			self._urls = {}
		end

		table.insert(self._urls, urls[i])
		self._multiLoader:addResPath(urls[i])
	end

	self._multiLoader:load(_, self._onSingleResLoaded, self)
end

function M:_onSingleResLoaded(res)
	if res.IsSuccess then
		if goutil.isNil(self._go) or self._photo == nil then
			self:clear()

			return
		end

		if not self._isOn and (self._urls == nil or #self._urls == 0) then
			self:turnOff()

			return
		end

		local goInst

		if self._urls then
			for i = #self._urls, 1, -1 do
				if res.ResPath == self._urls[i] then
					table.remove(self._urls, i)

					goInst = goutil.clone(res:GetAsset(nil, nil))
					goInst.layer = Astral.LayerUtil.NameToLayer(PhotoUtil.LayerName)

					table.insert(self._goInstList, goInst)

					break
				end
			end
		end

		if goInst then
			if self._photo then
				self._rawImage.enabled = self._isOn

				if self._isOn then
					self._photo:ShowTarget(goInst, true)
				else
					goutil.addChildToParent(goInst, self._go)
				end
			end

			if self._effectLoadedCallback then
				if self._effectLoadedCallbackObj then
					self._effectLoadedCallback(self._effectLoadedCallbackObj, goInst, res)
				else
					self._effectLoadedCallback(goInst, res)
				end
			end
		end
	end
end

function M:_onEffectOnePlayFinish()
	if goutil.isNil(self._go) then
		return
	end

	if self._effectOnePlayFinishCallback then
		if self._effectOnePlayFinishCallbackObj then
			self._effectOnePlayFinishCallback(self._effectOnePlayFinishCallbackObj, self)
		else
			self._effectOnePlayFinishCallback(self)
		end
	end
end

function M:getFirstUrl()
	return self._urls and self._urls[1]
end

function M:getUrlString()
	return table.concat(self._urls, "#")
end

function M:checkIsFinishLoadByUrl(url)
	local bLoaded = false

	if self._multiLoader and self._multiLoader:getResource(url) then
		return true
	end
end

function M:turnOn(bReplay)
	if not self._isOn then
		if self._rawImage then
			self._rawImage.enabled = true
		end

		if self._goInstList and self._photo then
			self._photo:TurnOn(self._rtWidth, self._rtHeight)
			PhotoUtil.addUsingRTCount(self, self._rtWidth, self._rtHeight)

			local goInst

			for i = 1, #self._goInstList do
				goInst = self._goInstList[i]

				if not goutil.isNil(goInst) then
					if bReplay and goInst.activeSelf then
						goutil.setActive(goInst, false)
						goutil.setActive(goInst, true)
					end

					self._photo:ShowTarget(goInst, true)
				end
			end
		end

		self._isOn = true
	end
end

function M:replay()
	if not self._isOn then
		self:turnOn(true)
	else
		local goInst

		for i = 1, #self._goInstList do
			goInst = self._goInstList[i]

			if not goutil.isNil(goInst) and goInst.activeSelf then
				goutil.setActive(goInst, false)
				goutil.setActive(goInst, true)
			end
		end
	end
end

function M:turnOff()
	if goutil.isNil(self._go) then
		return
	end

	if self._isOn then
		if self._rawImage then
			self._rawImage.enabled = false
		end

		if self._goInstList and self._photo then
			for i = 1, #self._goInstList do
				if not goutil.isNil(self._goInstList[i]) then
					goutil.addChildToParent(self._goInstList[i], self._go)
				end
			end
		end

		if self._photo then
			self._photo:TurnOff()
		end

		self._isOn = false
	end
end

function M:clear()
	self._urls = {}

	if self._multiLoader then
		self._multiLoader:clear()
	end

	if self._goInstList then
		for i = 1, #self._goInstList do
			if not goutil.isNil(self._goInstList[i]) then
				local _effectCSComp = self._goInstList[i]:GetComponent(typeof(Pjg.EffectPlayer))

				if _effectCSComp and not goutil.isNil(_effectCSComp) then
					_effectCSComp:Stop()
					_effectCSComp:RemoveFinishListener()
				end

				goutil.destroy(self._goInstList[i])
			end
		end

		self._goInstList = {}
	end

	if self._photo then
		self._photo:TurnOff()
	end

	self._isOn = false

	if goutil.isNil(self._go) then
		return
	end

	if self._rawImage then
		self._rawImage.enabled = false
	end

	self._bInitUVRect = true
end

function M:OnDestroy()
	self:clear()

	self._multiLoader = nil
	self._compContainer = nil
	self._go = nil
	self._photo = nil
	self._rawImage = nil
	self._effectLoadedCallback = nil
	self._effectLoadedCallbackObj = nil
	self._effectOnePlayFinishCallback = nil
	self._effectOnePlayFinishCallbackObj = nil
	self._urls = nil
	self._goInstList = nil
	self._showFunc = nil

	if self._btnClick then
		self._btnClick:RemoveClickListener()

		self._btnClick = nil
	end
end

function M:isFree()
	return not self._isOn and self._multiLoader.totalCount == 0
end

function M:setResGoScale(x, y, z)
	x = x or 1
	y = y or 1
	z = z or 1

	for i = 1, #self._goInstList do
		local goInst = self._goInstList[i]

		if not goutil.isNil(goInst) then
			GameUtils.setLocalScale(goInst, x, y, z)
		end
	end
end

return M

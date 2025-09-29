-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/ugui/UICharacter.lua

module("logic.common.ugui.UICharacter", package.seeall)

local M = class("UICharacter")

function M:_createCacheObj()
	local _cache = {}

	_cache.gameObject = nil
	_cache.position = Vector3.zero
	_cache.scale = Vector3.one
	_cache.rotation = Vector3.zero
	_cache.visible = true

	return _cache
end

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._multiLoader = MultiResLoader.New()
	self._photo = Astral.PhotoBase.Add(self._go)
	self._rtWidth = PhotoUtil.PartRTWidth
	self._rtHeight = PhotoUtil.PartRTHeight
	self._loadedCallback = nil
	self._loadedCallbackObj = nil
	self._bInitUVRect = true
	self._urls = {}
	self._goInstList = {}
	self._cacheObjDic = {}

	PhotoUtil.initPhotoSetting()
	self:_initRawImage()
end

function M:_initRawImage()
	if not goutil.isNil(self._go) then
		self._rawImage = self._go:GetComponent(UIComponentType.RawImage)

		if self._rawImage == nil then
			self._rawImage = self._go:AddComponent(UIComponentType.RawImage)
		end

		self._rawImage.enabled = false
		self._rawImage.raycastTarget = false
	end
end

function M:_setRawImageUVRect(rtWidth, rtHeight, width, height)
	if self._bInitUVRect and self._rawImage then
		width = width or goutil.getWidth(self._go.transform)
		height = height or goutil.getHeight(self._go.transform)
		self._rtWidth = rtWidth
		self._rtHeight = rtHeight

		PhotoUtil.setRTCapacity(rtWidth, rtHeight)

		local uvRectW = math.min(1, width / rtWidth)
		local uvRectH = math.min(1, height / rtHeight)
		local uvRectX = (1 - uvRectW) * 0.5
		local uvRectY = (1 - uvRectH) * 0.5

		self._rawImage.uvRect = UnityEngine.Rect.New(uvRectX, uvRectY, uvRectW, uvRectH)
		self._bInitUVRect = false
	end
end

function M:_setEffectChildsLayer(goInst)
	if goutil.isNil(goInst) then
		return
	end

	local childs = goInst:GetComponentsInChildren(UIComponentType.Transform)

	if childs then
		for i = 0, childs.Length - 1 do
			childs[i].gameObject.layer = Astral.LayerUtil.NameToLayer(PhotoUtil.LayerName)
		end
	end
end

function M:getRawImage()
	return self._rawImage
end

function M:setLoadedCallback(callback, callbackObj)
	self._loadedCallback = callback
	self._loadedCallbackObj = callbackObj
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

function M:showSmallCharacterRT(...)
	local urls = {
		...
	}

	if not urls or #urls == 0 then
		return
	end

	self:loadRes(urls, PhotoUtil.SmallRTWidth, PhotoUtil.SmallRTHeight)
end

function M:showStandardCharacterRT(...)
	local urls = {
		...
	}

	if not urls or #urls == 0 then
		return
	end

	self:loadRes(urls, PhotoUtil.RTWidth, PhotoUtil.RTHeight)
end

function M:showPartCharacterRT(...)
	local urls = {
		...
	}

	if not urls or #urls == 0 then
		return
	end

	self:loadRes(urls, PhotoUtil.PartRTWidth, PhotoUtil.PartRTHeight)
end

function M:showNormalCharacterRT(...)
	local urls = {
		...
	}

	if not urls or #urls == 0 then
		return
	end

	self:loadRes(urls, PhotoUtil.PartLargeRTWidth, PhotoUtil.PartLargeRTHeight)
end

function M:showFullCharacterRT(...)
	local urls = {
		...
	}

	if not urls or #urls == 0 then
		return
	end

	local rtWidth, rtHeight = PhotoUtil.RoleShowRTWidth, PhotoUtil.RoleShowRTHight

	self:_setRawImageUVRect(rtWidth, rtHeight, rtWidth, rtHeight)
	self:loadRes(urls, rtWidth, rtHeight)
end

function M:loadRes(urls, rtWidth, rtHeight)
	if not self:_setRTImgSetting(rtWidth, rtHeight) then
		return
	end

	self._isOn = true

	local len = #urls

	for i = 1, len do
		if not self._urls then
			self._urls = {}
		end

		table.insert(self._urls, urls[i])
		self._multiLoader:addResPath(urls[i])

		local _cacheObj = self:_createCacheObj()

		self._cacheObjDic[urls[i]] = _cacheObj
	end

	self._multiLoader:load(_, self._onSingleResLoaded, self)
	self:_refreshPosition()
end

function M:_setRTImgSetting(rtWidth, rtHeight)
	if self._photo == nil then
		return false
	end

	self:_setRawImageUVRect(rtWidth, rtHeight)
	self._photo:TurnOn(rtWidth, rtHeight)

	local renderTexture = self._photo and self._photo.producer and self._photo.producer.renderTexture

	if renderTexture == nil then
		printError("renderTexture is nil, self._go=", self._go.name)

		self._rawImage.enabled = false

		return false
	else
		self._rawImage.texture = renderTexture

		PhotoUtil.addUsingRTCount(self, rtWidth, rtHeight)
	end

	return true
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
		local _resUrl = res.ResPath

		if self._urls then
			for i = #self._urls, 1, -1 do
				if _resUrl == self._urls[i] then
					table.remove(self._urls, i)

					goInst = goutil.clone(res:GetAsset(nil, nil))

					self:_setEffectChildsLayer(goInst)
					table.insert(self._goInstList, goInst)

					self._cacheObjDic[_resUrl].gameObject = goInst

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

			self:_restoreGoTransformParam(_resUrl)

			if self._loadedCallback then
				if self._loadedCallbackObj then
					self._loadedCallback(self._loadedCallbackObj, goInst, res)
				else
					self._loadedCallback(goInst, res)
				end
			end
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

function M:_refreshPosition()
	if self._photo and self._photo.producer then
		local pos = PhotoUtil.GetPosition(self._photo.producer.counter)

		GameUtils.setPos(self._photo.producer.producerContainer, pos.x, pos.y, pos.z)
	end
end

function M:turnOn()
	if not self._isOn then
		if self._rawImage then
			self._rawImage.enabled = true
		end

		if self._photo then
			self._photo:TurnOn(self._rtWidth, self._rtHeight)
			PhotoUtil.addUsingRTCount(self, self._rtWidth, self._rtHeight)
		end

		if self._goInstList and self._photo then
			local goInst

			for i = 1, #self._goInstList do
				goInst = self._goInstList[i]

				if not goutil.isNil(goInst) then
					if goInst.activeSelf then
						goutil.setActive(goInst, false)
						goutil.setActive(goInst, true)
					end

					self._photo:ShowTarget(goInst, true)
				end
			end
		end

		self._isOn = true
	end

	self:_refreshPosition()
end

function M:turnOff()
	self:_refreshPosition()

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
	self._cacheObjDic = {}

	if self._multiLoader then
		self._multiLoader:clear()
	end

	if self._goInstList then
		for i = 1, #self._goInstList do
			if not goutil.isNil(self._goInstList[i]) then
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
end

function M:OnDestroy()
	self:clear()

	if self._multiLoader then
		self._multiLoader:clear()

		self._multiLoader = nil
	end

	self._cacheObjDic = nil
	self._compContainer = nil
	self._go = nil
	self._photo = nil
	self._rawImage = nil
	self._loadedCallback = nil
	self._loadedCallbackObj = nil
	self._urls = nil
	self._goInstList = nil
	self._bInitUVRect = true

	if self._btnClick then
		self._btnClick:RemoveClickListener()

		self._btnClick = nil
	end
end

function M:setPositionOffset(url, offsetVect)
	self._cacheObjDic[url].position = offsetVect

	self:_restoreGoTransformParam(url)
end

function M:setRotation(url, rotateVect)
	self._cacheObjDic[url].rotation = rotateVect

	self:_restoreGoTransformParam(url)
end

function M:setScale(url, scaleVect)
	self._cacheObjDic[url].scale = scaleVect

	self:_restoreGoTransformParam(url)
end

function M:switchGoVisible(url, visible)
	self._cacheObjDic[url].visible = visible == true

	self:_restoreGoTransformParam(url)
end

function M:_restoreGoTransformParam(url)
	local _cache = self._cacheObjDic[url]

	if not _cache then
		return
	end

	local _go = self:_getGameObject(url)

	if goutil.isNil(_go) then
		return
	end

	local _pos = _cache.position
	local _rotation = _cache.rotation
	local _scale = _cache.scale
	local _visible = _cache.visible

	GameUtils.setLocalPos(_go, _pos.x, _pos.y, _pos.z)
	GameUtils.setLocalRotation(_go, _rotation.x, _rotation.y, _rotation.z)
	GameUtils.setLocalScale(_go, _scale.x, _scale.y, _scale.z)
	goutil.setActive(_go, _visible == true)
end

function M:_getGameObject(url)
	if self._cacheObjDic[url] then
		return self._cacheObjDic[url].gameObject
	end

	return nil
end

function M:addGameobjectDirectlySmall(targetGameObj)
	if goutil.isNil(targetGameObj) then
		return
	end

	self:_setRawImageUVRect(PhotoUtil.SmallRTWidth, PhotoUtil.SmallRTHeight)
	self._photo:ShowTarget(targetGameObj, true)
end

function M:addGameobjectDirectlyStandard(targetGameObj)
	if goutil.isNil(targetGameObj) then
		return
	end

	self:_setRawImageUVRect(PhotoUtil.RTWidth, PhotoUtil.RTHeight)
	self._photo:ShowTarget(targetGameObj, true)
end

function M:addGameobjectDirectlyPart(targetGameObj)
	if goutil.isNil(targetGameObj) then
		return
	end

	self:_setRawImageUVRect(PhotoUtil.PartRTWidth, PhotoUtil.PartRTHeight)
	self._photo:ShowTarget(targetGameObj, true)
end

function M:addGameobjectDirectlyNormal(targetGameObj)
	if goutil.isNil(targetGameObj) then
		return
	end

	self:_setRawImageUVRect(PhotoUtil.PartLargeRTWidth, PhotoUtil.PartLargeRTHeight)
	self._photo:ShowTarget(targetGameObj, true)
end

function M:addGameobjectDirectlyFullCharacter(targetGameObj)
	if goutil.isNil(targetGameObj) then
		return
	end

	local rtWidth, rtHeight = PhotoUtil.RoleShowRTWidth, PhotoUtil.RoleShowRTHight

	self:_setRawImageUVRect(rtWidth, rtHeight, rtWidth, rtHeight)
	self._photo:ShowTarget(targetGameObj, true)
end

return M

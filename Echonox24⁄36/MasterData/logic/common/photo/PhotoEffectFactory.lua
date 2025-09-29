-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/photo/PhotoEffectFactory.lua

module("logic.common.photo.PhotoEffectFactory", package.seeall)

local M = class("PhotoEffectFactory")

function M:ctor()
	self._factoryContainer = goutil.create("PHOTOFACTORYROOT", false)

	GameUtils.setPos(self._factoryContainer, -2500, 0, 0)

	self._effects = {}
	self._pool = ObjectPool.New(20, M._createEffect, M._disposeEffect, M._resetEffect)
end

function M._createEffect()
	local effect = {}
	local container = goutil.create("eff", true)

	container.layer = Astral.LayerUtil.NameToLayer(SceneLayer.UI)
	effect.container = container
	effect.photoEff = Astral.LuaComponentContainer.Add(container, MultiPhotoEffect)

	effect.photoEff:setEffectLoadedCallback(M._onEffectLoaded, M.instance)

	effect.clones = {}
	effect.count = 0

	return effect
end

function M._resetEffect(effect)
	effect.count = 0
	effect.clones = {}

	effect.photoEff:clear()
end

function M._disposeEffect(effect)
	if not goutil.isNil(effect.container) then
		goutil.destroy(effect.container)
	end
end

function M:getSmallClonePhotoEffect(url, uiWidth, uiHeight)
	return self:getClonePhotoEffect(url, PhotoUtil.SmallRTWidth, PhotoUtil.SmallRTHeight, uiWidth, uiHeight)
end

function M:rePlayPhotoEffect(url)
	local photoData = url and self._effects[url]

	if photoData and not goutil.isNil(photoData.orgGoInst) then
		goutil.setActive(photoData.orgGoInst, false)
		goutil.setActive(photoData.orgGoInst, true)
	end
end

function M:getClonePhotoEffect(url, rtWidth, rtHeight, uiWidth, uiHeight)
	if GameUtils.isEmptyString(url) then
		return
	end

	local eff = self._effects[url]

	if eff == nil then
		eff = self._pool:fetchObject()

		local container = eff.container

		rtWidth = rtWidth or PhotoUtil.PartRTWidth
		rtHeight = rtHeight or PhotoUtil.PartRTHeight

		goutil.setWidth(container.transform, uiWidth or rtWidth)
		goutil.setHeight(container.transform, uiHeight or rtHeight)
		goutil.addChildToParent(eff.container, self._factoryContainer)

		eff.container.name = url
		self._effects[url] = eff

		if rtWidth == PhotoUtil.SmallRTWidth and rtHeight == PhotoUtil.SmallRTHeight then
			eff.photoEff:showSmallEffect(url)
		else
			eff.photoEff:showPartEffect(url)
		end
	end

	eff.count = eff.count + 1

	local objClone = goutil.create(tostring(eff.count), true)

	objClone.layer = Astral.LayerUtil.NameToLayer(SceneLayer.UI)

	GameUtils.copyRectTransform(objClone:GetComponent(goutil.Type_RectTransform), eff.container:GetComponent(goutil.Type_RectTransform))
	GameUtils.copyRawImage(objClone:AddComponent(typeof(UnityEngine.UI.RawImage)), eff.container:GetComponent(typeof(UnityEngine.UI.RawImage)))

	if eff.photoEff:checkIsFinishLoadByUrl(url) then
		local rawImageComp = objClone:GetComponent(typeof(UnityEngine.UI.RawImage))

		if rawImageComp then
			rawImageComp.enabled = true
		end
	end

	table.insert(eff.clones, objClone)

	return objClone
end

function M:_pointToSameRT(url)
	local photoData = self._effects[url]

	if photoData and photoData.photoEff then
		local orgRawImage = photoData.photoEff:getRawImage()

		if orgRawImage then
			local goCopy = photoData.clones and photoData.clones[1]

			if not goutil.isNil(goCopy) then
				local copyRawImage = goCopy:GetComponent(typeof(UnityEngine.UI.RawImage))

				if copyRawImage and orgRawImage.texture ~= copyRawImage.texture then
					for i = 1, #photoData.clones do
						goCopy = photoData.clones[i]

						if not goutil.isNil(goCopy) then
							copyRawImage = goCopy:GetComponent(typeof(UnityEngine.UI.RawImage))

							if copyRawImage then
								copyRawImage.texture = orgRawImage.texture
							end
						end
					end
				end
			end
		end
	end
end

function M:turnOn(url)
	if self._effects and self._effects[url] and self._effects[url].photoEff then
		self._effects[url].photoEff:turnOn()
		self:_pointToSameRT(url)
	end
end

function M:turnOff(url)
	if self._effects and self._effects[url] and self._effects[url].photoEff then
		self._effects[url].photoEff:turnOff()
	end
end

function M:_onEffectLoaded(goInst, res)
	if res and res.ResPath then
		local data = self._effects and self._effects[res.ResPath]

		if data then
			data.orgGoInst = goInst

			if data.clones then
				local rawImageComp

				for i = 1, #data.clones do
					if not goutil.isNil(data.clones[i]) then
						rawImageComp = data.clones[i]:GetComponent(typeof(UnityEngine.UI.RawImage))

						if rawImageComp then
							rawImageComp.enabled = true
						end
					end
				end
			end
		end
	end
end

function M:destroyClonePhotoEffect(url, justclear)
	local photoEffect = self._effects and self._effects[url]

	if photoEffect then
		photoEffect.count = photoEffect.count - 1

		if photoEffect.count <= 0 then
			self._pool:returnObject(photoEffect)

			self._effects[url] = nil
		end
	end
end

function M:destroy()
	if self._effects then
		self._pool:clear()

		self._effects = {}
	end
end

M.instance = M.New()

return M

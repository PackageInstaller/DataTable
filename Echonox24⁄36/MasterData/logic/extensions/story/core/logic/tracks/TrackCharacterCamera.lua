-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/tracks/TrackCharacterCamera.lua

module("logic.extensions.story.core.logic.tracks.TrackCharacterCamera", package.seeall)

local M = class("TrackCharacterCamera", StoryTrackBase)

function M:_OnInitCtor()
	self.assetUID = nil
	self.instUID = nil
	self.camRootTf = nil
end

function M:OnStoryAwakeInternal()
	local argInfo = self.config:GetArg(StoryArgKeyConst.RefAssets)

	if not argInfo then
		return
	end

	self.assetUID = self.config:GetArgValue(StoryArgKeyConst.RefAssets)
	self.instUID = tostring(argInfo.GUID)

	local assetObj = self.binder:GetBindObject(self.assetUID)

	if assetObj then
		local inst = StoryGameObjectPool.Get(self.assetUID, assetObj)

		inst.name = assetObj.name

		local proxyInst = StoryEngine.StoryGameObjectInstProxy.CreateProxyInstAndSetParent(inst)

		proxyInst.name = self.instUID

		goutil.addChildToParent(proxyInst, self.binder.BinderRoot.transform)
		StoryUtils.ResetTransform(proxyInst.gameObject)
		self.binder:AddProxyPtr(self.instUID, proxyInst, StoryPtrTag.UnityTimeLineInstance, nil, nil)
		self.binder:SetProxyPtrVisible(self.instUID, false, false)

		self.camRootTf = proxyInst.target.transform:Find("cameras")

		self:AddCamera2Ptr(self.camRootTf, self.binder, StoryPtrTag.CharacterCamera)
		self:SetCameraVisible(self.camRootTf, false, false)
	end
end

function M:OnStoryEnterInternal()
	self.bindingTarget = nil

	self.binder:SetPtrUsable(self.instUID, true)
	self:SetCameraVisible(self.camRootTf, true, false)

	local ptrInfo = self.binder:FindIDPtr(self.instUID)

	if ptrInfo then
		self.bindingTarget = ptrInfo.targetObj
	end
end

function M:OnStoryExitInternal()
	self:SetCameraUsable(self.camRootTf, false)
	self.binder:SetPtrUsable(self.instUID, false)

	self.bindingTarget = nil
end

function M:OnStoryDestroyInternal()
	local ptrInfo = self.binder:FindIDPtr(self.instUID)

	if ptrInfo and ptrInfo.type == StoryResIDPtrType.GameObject then
		self:RemoveAllCameraPtr(self.camRootTf)
		self.binder:RemovePtr(self.instUID)

		local proxyInst = ptrInfo.targetObj

		if proxyInst then
			goutil.destroy(proxyInst.proxyTarget)
		end
	end
end

function M:RemoveAllCameraPtr(camTf)
	if not camTf then
		return
	end

	local count = camTf.childCount - 1

	for i = 0, count do
		local child = camTf:GetChild(i)
		local uid = child.name

		self.binder:RemovePtr(uid)
	end
end

function M:SetCameraUsable(camTf, usable)
	if not camTf then
		return
	end

	local count = camTf.childCount - 1

	for i = 0, count do
		local child = camTf:GetChild(i)
		local uid = child.name

		self.binder:SetPtrUsable(uid, usable)
	end
end

function M:SetCameraVisible(camTf, usable, active)
	if not camTf then
		return
	end

	local count = camTf.childCount - 1

	for i = 0, count do
		local child = camTf:GetChild(i)
		local uid = child.name

		self.binder:SetProxyPtrVisible(uid, usable, active)
	end
end

function M:AddCamera2Ptr(camTf, binder, tag)
	if not camTf then
		return
	end

	local tbChild = {}
	local count = camTf.childCount - 1

	for i = 0, count do
		local child = camTf:GetChild(i)

		tbChild[#tbChild + 1] = child

		CinemachineVirtualCamAdapter.Get(child.gameObject):SetCineVirtualCamPriority(2000)
	end

	for index, item in ipairs(tbChild) do
		local uid = self:GenUID(item.name)

		item.name = uid

		local proxyInst = goutil.create(uid, false)

		proxyInst.layer = item.gameObject.layer

		proxyInst.transform:SetParent(camTf)
		StoryUtils.ResetTransform(proxyInst)

		proxyInst.transform.localPosition = item.localPosition
		proxyInst.transform.localScale = item.localScale
		proxyInst.transform.localRotation = item.localRotation

		item:SetParent(proxyInst.transform)
		item.gameObject:SetActive(true)

		local proxy = StoryEngine.StoryGameObjectInstProxy.Get(proxyInst, item.gameObject)

		proxyInst:SetActive(false)
		CinemachineVirtualCamAdapter.Get(item.gameObject):SetCineVirtualCamPriority(2000)
		binder:AddProxyPtr(uid, proxy, tag)
		binder:SetProxyPtrVisible(uid, false, false)
	end
end

function M:GenUID(name)
	return string.format("%s(%s)", name, self.instUID)
end

return M

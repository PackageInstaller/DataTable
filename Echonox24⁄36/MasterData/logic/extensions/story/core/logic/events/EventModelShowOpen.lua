-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/EventModelShowOpen.lua

module("logic.extensions.story.core.logic.events.EventModelShowOpen", package.seeall)

local M = class("EventModelShowOpen", StoryEventBase)

function M:_OnInitCtor()
	self.refUID = nil
	self.instUID = nil
	self.m_proxyInst = nil
	self.m_modelShowHandle = StoryHandleModelCreate.New()
	self.m_transformHandle = StoryHandleFixTransform.New()
end

function M:OnStoryAwakeInternal()
	local argInfo = self.config:GetArg(StoryArgKeyConst.RefAssets)

	if not argInfo then
		return
	end

	self.refUID = self.config:GetArgValue(StoryArgKeyConst.RefAssets)
	self.instUID = tostring(argInfo.GUID)
	self.m_proxyInst = self.m_modelShowHandle:Handle(self.refUID, self.instUID, self.config, self.binder)

	if not self.m_proxyInst then
		printWarn("剧情加载角色失败，请检查剧情绑定角色配置")

		return
	end

	self.binder:SetProxyPtrVisible(self.instUID, false, false)
	self.m_transformHandle:Handle(self.config, self:_getProxyTarget(), true)

	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if _storyEntry and _storyEntry:IsRogue() then
		local showName = ""
		local idPtrRes = self.binder:FindIDPtr(self.instUID)

		if idPtrRes then
			showName = idPtrRes.elePtr.ShortName
		end

		StoryDispatcher:dispatchEvent(StoryNotifyName.RogueCreate, self.m_proxyInst, showName)

		return
	end

	self:_hideWeapon(self.m_proxyInst.target)
end

function M:_hideWeapon(rootGo)
	if goutil.isNil(rootGo) then
		return
	end

	local weaponeName1 = "@wuqi"
	local weaponeName2 = "@weapon"
	local count = rootGo.transform.childCount

	for i = 0, count - 1 do
		local childGo = rootGo.transform:GetChild(i).gameObject
		local name = childGo.name

		if childGo and (string.find(name, weaponeName1) or string.find(name, weaponeName2)) then
			goutil.setActive(childGo, false)
		end
	end
end

function M:OnEventExecuteInternal()
	self.m_transformHandle:Handle(self.config, self:_getProxyTarget(), true)
	self.binder:SetProxyPtrVisible(self.instUID, true, true)

	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if _storyEntry and _storyEntry:IsRogue() then
		StoryDispatcher:dispatchEvent(StoryNotifyName.RogueUpdate, self.m_proxyInst)
	end
end

function M:OnStoryCleanInternal()
	self.binder:SetProxyPtrVisible(self.instUID, false, false)

	if not string.nilorempty(self.instUID) then
		local handle = StoryHandleGOInstProxyDelete.New()

		handle:Handle(self.refUID, self.instUID, self.binder)
	end

	self.m_proxyInst = nil
	self.refUID = nil
	self.instUID = nil
end

function M:_getProxyTarget()
	return self.m_proxyInst and self.m_proxyInst.proxyTarget or nil
end

return M

-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/tips/BaseTips.lua

module("logic.common.viewlib.tips.BaseTips", package.seeall)

local M = class("BaseTips", AbstractGlobalReusable)

M.url = false
M.viewRootType = ViewRootType.Notify

function M:buildUI()
	return
end

function M:destroyUI()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:ctor()
	self.mainGO = false
end

function M:reset()
	if self.mainGO then
		self:onExit()
		goutil.addChildToParent(self.mainGO, Tips.tipsRoot)
	else
		GameObjectCache.instance:cancelLoadGameObject(self.url, self._onLoadGameObject, self)
	end
end

function M:destroy()
	if self.mainGO then
		self:onExit()
		self:destroyUI()
		GameObjectCache.instance:releaseGameObject(self.url, self.mainGO)

		self.mainGO = false
	else
		GameObjectCache.instance:cancelLoadGameObject(self.url, self._onLoadGameObject, self)
	end
end

function M:show()
	if self.mainGO then
		self:_activeView()
	else
		GameObjectCache.instance:loadGameObject(self.url, self._onLoadGameObject, self)
	end
end

function M:close()
	self:returnSelf()
end

function M:_onLoadGameObject(go)
	self.mainGO = go

	self:buildUI()
	self:_activeView()
end

function M:_activeView()
	local root = ViewMgr.instance:getRoot(self.viewRootType)

	goutil.addChildToParent(self.mainGO, root)
	self:onEnter()
end

return M

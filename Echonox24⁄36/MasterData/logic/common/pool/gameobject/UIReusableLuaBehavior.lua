-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/pool/gameobject/UIReusableLuaBehavior.lua

module("logic.common.pool.gameobject.UIReusableLuaBehavior", package.seeall)

local M = class("UIReusableLuaBehavior", IReusable)
local kPoolRoot = PoolRootUtil.getUIPoolRoot()

function M:NewObject(prefab, parent)
	local mainGO = goutil.clone(prefab)

	goutil.addChildToParent(mainGO, parent)

	return Astral.SimpleLuaComponentContainer.Add(mainGO, self)
end

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject

	self:buildUI()
	self:bindEvents()
	self:onEnter()
end

function M:reuse(prefab, parent)
	goutil.addChildToParent(self.mainGO, parent)
	RectTransformUtils.ResetRectTransform(self.mainGO.transform)
	self:onEnter()
end

function M:reset()
	self:onExit()
	goutil.addChildToParent(self.mainGO, kPoolRoot)
end

function M:OnDestroy()
	self:onExit()
	self:unbindEvents()
	self:destroyUI()
	goutil.destroy(self.mainGO)

	self.mainGO = false
end

function M:buildUI()
	return
end

function M:destroyUI()
	return
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

return M

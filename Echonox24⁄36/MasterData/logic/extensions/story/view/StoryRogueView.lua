-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryRogueView.lua

module("logic.extensions.story.view.StoryRogueView", package.seeall)

local M = class("StoryRogueView", ViewComponent)
local mainCameraTarget = CameraTargetMgr.instance:getMainCameraTarget()
local uiCameraTarget = CameraTargetMgr.instance:getUICameraTarget()
local plane2D = SceneRoot2DMgr.instance:getSceneUIRoot().transform

function M:buildUI()
	self._bubleNameRoot = self:getGo("story_main_view_-1412240425")
	self._bubbleName = self:getGo("story_main_view_375692614")
	self._dialogRoot = self:getGo("story_main_view_-279270757")
end

function M:bindEvents()
	StoryDispatcher:addEventListener(StoryNotifyName.RogueCreate, self.onRogueCreate, self)
	StoryDispatcher:addEventListener(StoryNotifyName.RogueDestory, self.onRogueDestory, self)
	StoryDispatcher:addEventListener(StoryNotifyName.RogueUpdate, self.onRogueUpdate, self)
	StoryDispatcher:addEventListener(StoryNotifyName.RogueDialog, self.onRogueDialog, self)
end

function M:unbindEvents()
	StoryDispatcher:removeEventListener(StoryNotifyName.RogueCreate, self.onRogueCreate, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.RogueDestory, self.onRogueDestory, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.RogueUpdate, self.onRogueUpdate, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.RogueDialog, self.onRogueDialog, self)
end

function M:onEnter()
	self._allUIFollowUnits = {}
	self._allNameItems = {}
end

function M:onExit()
	self:clear()
end

function M:destroyUI()
	return
end

function M:onRogueCreate(evt, data, showName)
	if not data then
		return
	end

	if not self._allUIFollowUnits then
		self._allUIFollowUnits = {}
	end

	local targetUid = data.uid
	local targetGo = data.proxyTarget
	local uiFollow = UIFollowUnit.Get(targetGo)

	uiFollow:SetFollowArgs(mainCameraTarget:getCamera(), uiCameraTarget:getCamera(), plane2D)
	uiFollow:SetPerspectiveArgs(10, 0.7, 1.5)

	if self._allUIFollowUnits[targetUid] then
		local uiFollow = self._allUIFollowUnits[targetUid]

		self:_nameFollowModel(targetUid, uiFollow, showName)

		return
	end

	self._allUIFollowUnits[targetUid] = uiFollow

	uiFollow:CreateFollowGroup(0, 1.8)
	uiFollow:CreateFollowGroup(0, 0)
	uiFollow:SetMainGameObject(targetGo)
	self:_nameFollowModel(targetUid, uiFollow, showName)
end

function M:_nameFollowModel(targetUid, uiFollow, showName)
	if self._allNameItems[targetUid] then
		local nameItem = self._allNameItems[targetUid]

		uiFollow:AddFollowGameObject(1, nameItem)
	else
		local newNameItem = goutil.cloneAndSetParent(self._bubbleName, self._bubleNameRoot.transform, "Bubble_Name")

		if newNameItem then
			local labName = goutil.findChildComponent(newNameItem, "txtName", UIComponentType.TextMeshProUGUI)

			labName.text = showName

			uiFollow:AddFollowGameObject(1, newNameItem)

			self._allNameItems[targetUid] = newNameItem
		end
	end
end

function M:onRogueDestory(evt, data)
	if not data then
		return
	end

	local targetUid = data.uid

	if self._allUIFollowUnits[targetUid] then
		local uiFollow = self._allUIFollowUnits[targetUid]

		uiFollow:Clear()

		self._allUIFollowUnits[targetUid] = nil
	end

	if self._allNameItems[targetUid] then
		goutil.destroy(self._allNameItems[targetUid])

		self._allNameItems[targetUid] = nil
	end
end

function M:onRogueUpdate(evt, data)
	if not data then
		return
	end

	local targetUid = data.uid

	if self._allNameItems[targetUid] then
		local nameItem = self._allNameItems[targetUid]

		goutil.setActive(nameItem, true)
	end
end

function M:onRogueDialog(evt, roleUid)
	local uiFollow = self._allUIFollowUnits[roleUid]

	if uiFollow then
		uiFollow:AddFollowGameObject(0, self._dialogRoot)
	end
end

function M:clear()
	for k, v in pairs(self._allUIFollowUnits) do
		v:RemoveAllFollowGameObject()
	end

	for k, v in pairs(self._allNameItems) do
		goutil.destroy(v)
	end
end

return M

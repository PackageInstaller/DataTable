-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsChamberComp.lua

module("logic.extensions.tooltips.component.ToolTipsChamberComp", package.seeall)

local M = class("ToolTipsChamberComp", ViewComponent)

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))

	local raycastGO = self:getGoByPath("empty_raycast_mask")

	self._passEvent = goutil.addComponentOnce(raycastGO, ComponentType.PassEvent)
	self._txtItemName = self:getTextByPath("node/top/txtItemName")
	self._imgIcon = self:getImageByPath("node/scroll/Viewport/Content/content1/imgEquipIcon")
	self._goEntryRoot = self:getGoByPath("node/scroll/Viewport/Content/objMiddle")
	self._txtDesc = self:getTextByPath("node/scroll/Viewport/Content/txtContent")
	self._goEntryItem = goutil.findChild(self._goEntryRoot, "secret_time_impression_effect_item")

	goutil.setActive(self._goEntryItem, false)

	self._arrayEntryItem = {}
end

function M:destroyUI()
	self._arrayEntryItem = nil
end

function M:_setEvents(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.TIPS_CHANGE_ENABLE_EVENT, self.changeComponentEnable, self)
		GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._refreshView, self)
	else
		GlobalDispatcher:removeEventListener(EventType.TIPS_CHANGE_ENABLE_EVENT, self.changeComponentEnable, self)
		GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._refreshView, self)
	end
end

function M:onEnter()
	self:_refreshView()
	self:_setEvents(true)
end

function M:onExit()
	self:_setEvents(false)
end

function M:_refreshView()
	local info = self:getFirstParam()

	if info.passEvent ~= nil then
		self._passEvent.isPassEvent = info.passEvent
	end

	local itemData = info.baseData

	self._txtItemName.text = itemData:getName()
	self._txtDesc.text = itemData:getItemDesc()

	IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, itemData:getIcon())

	local uuid = itemData:getUuid()
	local entryCOs, isUsed, idx

	if uuid == 0 then
		entryCOs = ChamberConfig.instance:getItemEntrys(itemData:getItemInfo())
	else
		isUsed, idx = ChamberModel.instance:isItemInSlot(uuid)

		if isUsed then
			local mo = ChamberModel.instance:getSlot(idx)

			entryCOs = mo:getEntrys() or {}
		else
			entryCOs = ChamberConfig.instance:getItemEntrys(itemData:getItemInfo())
		end
	end

	self:_clearEntryItems()

	for _, CO in ipairs(entryCOs) do
		local itemGO = goutil.cloneAndSetParent(self._goEntryItem, self._goEntryRoot.transform)

		goutil.setActive(itemGO, true)

		local item = Astral.SimpleLuaComponentContainer.Add(itemGO, ChamberEntryItem)

		item:setEntryCO(CO, isUsed)
		table.insert(self._arrayEntryItem, itemGO)
	end
end

function M:_clearEntryItems()
	for _, item in ipairs(self._arrayEntryItem) do
		goutil.destroy(item)
	end

	table.clear(self._arrayEntryItem)
end

function M:changeComponentEnable(_, finish, viewName)
	if not finish then
		return
	end

	goutil.setActive(self.mainGO, true)
	self._guiAnimation:PlayAniByName("open1")
end

return M

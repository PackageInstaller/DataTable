-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/item/AirAdjustmentBuildingItem.lua

module("logic.extensions.airworkshop.flow.defflow.view.item.AirAdjustmentBuildingItem", package.seeall)

local M = class("AirAdjustmentBuildingItem", UIReusableLuaBehavior)
local kEnableColor = "#FFFFFFFF"
local kDisableColor = "#FFFFFF66"
local kLongClickTriggerTime = 0.3

function M:buildUI()
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "imgIcon")

	local goClick = goutil.findChild(self.mainGO, "btnClick")

	self._transform = self.mainGO.transform
	self._btnDrag = Astral.UIDragTrigger.Get(goClick)
	self._passEvent = PassEvent.Get(goClick)
	self._goSelect = goutil.findChild(self.mainGO, "imgSelect")

	self._btnDrag:AddBeginDragListener(self._onBeginDrag, self)
	self._btnDrag:AddDragListener(self._onDrag, self)
	self._btnDrag:AddEndDragListener(self._onEndDrag, self)

	self._handler = false
	self._buildingCO = false
	self._enable = false
	self._btnClick = OnceLongPressTrigger.Get(goClick)

	self._btnClick:SetTriggerTime(kLongClickTriggerTime)
	self._btnClick:AddClickListener(self._onClickIcon, self)
	self._btnClick:AddLongPressListener(self._onLongClickIcon, self)
end

function M:onDestroy()
	self:destroyUI()
end

function M:destroyUI()
	self._btnClick:RemoveClickListener()
	self._btnClick:RemoveLongPressListener()
	self._btnDrag:RemoveBeginDragListener()
	self._btnDrag:RemoveDragListener()
	self._btnDrag:RemoveEndDragListener()

	self._transform = nil
	self._btnClick = nil
	self._btnDrag = nil
	self._imgIcon = nil
	self._handler = false
	self._enable = false
end

function M:onEnter()
	local transform = self.mainGO.transform

	RectTransformUtils.ResetRectTransform(transform)
end

function M:onExit()
	self._handler = false

	IconLoader.clearSprite(self._imgIcon)
	Astral.TransformUtil.SetLocalRotation(self._imgIcon.gameObject.transform, 0, 0, 0)
end

function M:setBuildingCO(buildingCO)
	self._buildingCO = buildingCO

	IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, buildingCO.icon)
end

function M:setEnable(enable)
	self._enable = enable
end

function M:getBuildingId()
	return self._buildingCO.id
end

function M:setPassToGameObject(passToGO)
	return
end

function M:setHandler(handler)
	self._handler = handler
end

function M:setSelected(selected)
	goutil.setActive(self._goSelect, selected)
end

function M:_onClickIcon()
	if not self:_checkEnable() then
		return
	end

	self._handler:onClickHeadItem(self)
end

function M:_onLongClickIcon()
	if not self:_checkEnable() then
		return
	end

	self._handler:onLongClickHeadItem(self)
end

function M:_onEndDrag(eventData)
	local position = eventData.position

	self._handler:onEndDragHeadItem(self, position.x, position.y)
end

local kTan = math.tan(math.rad(15))

function M:_onBeginDrag(eventData)
	local isPassEvent = true
	local delta = eventData.delta

	if math.abs(delta.y) >= math.abs(delta.x) * kTan and self:_checkEnable() then
		local position = eventData.position

		self._handler:onBeginDragHeadItem(self, position.x, position.y)

		isPassEvent = false
	end

	self._passEvent.isPassEvent = isPassEvent
end

function M:_onDrag(eventData)
	local position = eventData.position

	self._handler:onDragHeadItem(self, position.x, position.y)
end

function M:_checkEnable()
	if self._enable then
		return true
	end

	self._handler:onTriggerDisable(self)
end

return M

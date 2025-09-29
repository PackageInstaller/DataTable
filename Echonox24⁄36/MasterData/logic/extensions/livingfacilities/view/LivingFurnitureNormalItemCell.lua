-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFurnitureNormalItemCell.lua

module("logic.extensions.livingfacilities.view.LivingFurnitureNormalItemCell", package.seeall)

local ButtonAdapter = Astral.ButtonAdapter
local M = class("LivingFurnitureNormalItemCell")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	self._numText = self._viewElementsRegistry:findUIElement("live_furniture_item_1151522568", UIComponentType.Text)
	self._nameTxt = self._viewElementsRegistry:findUIElement("live_furniture_item_922865065", UIComponentType.Text)
	self._iconImg = self._viewElementsRegistry:findUIElement("live_furniture_item_1896819952", UIComponentType.Image)
	self._atmosText = self._viewElementsRegistry:findUIElement("live_furniture_item_1975839139", UIComponentType.Text)
	self._greenText = self._viewElementsRegistry:findUIElement("live_furniture_item_1275855237", UIComponentType.Text)
	self._needText = self._viewElementsRegistry:findUIElement("live_furniture_item_796486042", UIComponentType.Text)
	self._needGo = self._viewElementsRegistry:findUIElement("live_furniture_item_796486042")
	self._count = self._viewElementsRegistry:findUIElement("live_furniture_item_1151522568", UIComponentType.Text)
	self._btnClick = ButtonAdapter.Get(self._viewElementsRegistry:findUIElement("live_furniture_item_670771453"))
	self._btnLongClick = OnceLongPressTrigger.Get(self._btnClick.gameObject)

	self._btnLongClick:SetTriggerTime(0.3)

	self._specialGo = self._viewElementsRegistry:findUIElement("live_furniture_item_602307693")
	self._specialIcon = self._viewElementsRegistry:findUIElement("live_furniture_item_1863786128", UIComponentType.Image)
	self._goUnusable = self._viewElementsRegistry:findUIElement("live_furniture_item_-1330458674")
end

function M:_clickSelf()
	if self._isPreview then
		GlobalDispatcher:dispatchEvent(self._data:getItemMarkType(), self._data, self._go, self._index, true)
	elseif self:_canFurniturePlace() then
		LivingFacilitiesZoneController.instance:placeOneEditById(self._data:getItemId())
		HouseFurnitureModel.instance:setCanSaveFurniture(true)
	end
end

function M:_canFurniturePlace()
	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()
	local type = zoneMo:getType()
	local floorId, wallId = RoomFurnitureEditModel.instance:getCurrEditingPaper()

	return self._data:getCanUse(type) and self._data:getCount() > 0 or self._data:getItemId() == floorId or self._data:getItemId() == wallId
end

function M:setCellData(data, index)
	self._data = data
	self._index = index

	self:refreshView()
	self._btnClick:AddClickListener(self._clickSelf, self)
	self._btnLongClick:AddLongPressListener(self._longClick, self)
	self._btnLongClick:AddLongPressExitListener(self._onLongClickExit, self)
end

function M:refreshView()
	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()
	local type = zoneMo:getType()

	IconLoader.setSprite(self._iconImg, IconType.Furniture, self._data:getIcon())

	self._numText.text = self._data:getCount()
	self._nameTxt.text = self._data:getName()
	self._greenText.text = self._data:getAtmosphere()
	self._atmosText.text = self._data:getCfgSpAtmosValAndTyp()

	goutil.setActive(self._needGo, self._isPreview)

	if zoneMo:getTypeName() then
		goutil.setActive(self._specialGo, true)
		HouseMainUtil.changAtmosphereIcon(self._specialIcon, zoneMo:getAtmosType())
	else
		goutil.setActive(self._specialGo, false)
	end

	goutil.setActive(self._goUnusable, not self._data:getCanUse(type))
end

function M:_longClick()
	local data = ToolTipsUtil.createItemTipsData(self._data, self._go)

	ToolTipsMgr.showTips(data.viewName, data)
end

function M:_onLongClickExit()
	return
end

function M:setPreviewStatus(status, countString)
	self._isPreview = status
	self._needText.text = countString or ""
end

function M:onExit()
	if self._btnClick then
		self._btnClick:RemoveClickListener()
	end
end

function M:onDestroy()
	self._numText = nil
	self._nameTxt = nil
	self._iconImg = nil
	self._atmosText = nil
	self._greenText = nil
	self._needText = nil
	self._needGo = nil
	self._btnClick = nil
	self._data = nil
	self._index = nil
end

return M

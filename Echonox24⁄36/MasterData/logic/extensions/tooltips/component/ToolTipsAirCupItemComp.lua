-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsAirCupItemComp.lua

module("logic.extensions.tooltips.component.ToolTipsAirCupItemComp", package.seeall)

local M = class("ToolTipsAirCupItemComp", ViewComponent)

function M:buildUI()
	self._iconImg = self:getImage("item_detail_tips_copy_1991515580")
	self._imgQualtiy = self:getImage("item_detail_tips_1_-929434738")
	self._itemName = self:getText("item_tips_-1624252585")
	self._detailDesc = self:getUIComponent("item_tips_67372985", UIComponentType.TextMeshProUGUI)
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._scroll = self:getGo("item_detail_tips_751828810")
	self._scrollRect = self:getGo("item_detail_tips_751828810"):GetComponent(UIComponentType.ScrollRect)
	self._layoutElement = self:getGo("item_detail_tips_751828810"):GetComponent(UIComponentType.LayoutElement)
	self._middleRect = self:getGo("item_detail_tips_751828810"):GetComponent(UIComponentType.RectTransform)

	local goItemCount = self:getGo("item_tips_162590809")

	goutil.setActive(goItemCount.transform.parent.gameObject, false)
	goutil.setActive(self:getGo("item_tips_-136867712"), false)
	goutil.setActive(self:getGo("item_detail_tips_-1238849104"), false)

	self._pathRoot = self:getGo("item_detail_tips_827817151")

	goutil.setActive(self._pathRoot, false)
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
	self:_setEvent(true)

	local info = self:getFirstParam()
	local itemData = info.baseData
	local cfg = itemData:getItemInfo()
	local itemId = itemData:getItemId()
	local itemType = itemData:getType()
	local quality = itemData:getQuality()
	local itemCount = ItemModel.instance:getItemCountByItemId(itemId)

	self._itemName.text = itemData:getName()

	IconLoader.setSpriteByItemType(self._iconImg, itemType, itemData:getIcon())
	IconLoader.setSprite(self._imgQualtiy, IconType.Skinlib, CommEnum.Quality2TipsWordIcon[quality])

	local str = cfg.desc

	if itemCount > 0 then
		local items = ItemModel.instance:getItemsByItemId(itemId)
		local item = items[1]

		str = string.format("%s\n\n%s:\n%s", str, "获取时间", ServerTime.formatTimeServerLook(item:getAddTime() * 0.001, "%Y/%m/%d"))
	else
		str = string.format("%s\n\n%s\n%s", str, "获取方式", cfg.cupGetWay)
	end

	self._detailDesc.text = str

	if info.passEvent ~= nil then
		local passEvent = self:getUIComponent("empty_mask_tips_29887572", ComponentType.PassEvent)

		passEvent.isPassEvent = info.passEvent
	end
end

function M:onExit()
	self:_setEvent(false)
end

function M:onExitFinished()
	return
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.TIPS_CHANGE_ENABLE_EVENT, self.changeComponentEnable, self)
	else
		GlobalDispatcher:removeEventListener(EventType.TIPS_CHANGE_ENABLE_EVENT, self.changeComponentEnable, self)
	end
end

function M:setScrollSize(hasBtn)
	if hasBtn then
		goutil.setHeight(self._scroll.transform, 360)
	else
		goutil.setHeight(self._scroll.transform, 404)
	end
end

function M:changeComponentEnable(_, finish)
	if not finish then
		return
	end

	self._scrollRect.enabled = false
	self._layoutElement.enabled = false

	RectTransformUtils.ForceRebuildLayoutImmediate(self._middleRect.parent)

	local rect = self._middleRect
	local high = rect.sizeDelta.y
	local defaultY = 358

	self._scrollRect.enabled = defaultY <= high
	self._layoutElement.enabled = defaultY <= high

	goutil.setActive(self.mainGO, true)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open1")
	goutil.setActive(self._pathRoot, false)
end

return M

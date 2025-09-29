-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/tips/ToolTipsAirBuildingHeadComp.lua

module("logic.extensions.airworkshop.flow.defflow.view.tips.ToolTipsAirBuildingHeadComp", package.seeall)

local M = class("ToolTipsAirBuildingHeadComp", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._iconImg = false
	self._itemName = false
	self._gridTxt = false
	self._useDesc = false
	self._detailDesc = false
end

function M:buildUI()
	self._iconImg = self:getImage("item_detail_tips_copy_1991515580")
	self._itemName = self:getText("item_tips_-1624252585")
	self._gridTxt = self:getText("item_tips_162590809")
	self._gridText = self:getTextByPath("node/scroll/Viewport/Content/content1/num")
	self._gridText.text = "格子"
	self._useDesc = self:getText("item_tips_-136867712")
	self._detailDesc = self:getUIComponent("item_tips_67372985", UIComponentType.TextMeshProUGUI)
	self._txtExpireTime = self:getText("item_detail_tips_copy_632425988")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._scroll = self:getGo("item_detail_tips_751828810")
	self._scrollRect = self:getGo("item_detail_tips_751828810"):GetComponent(UIComponentType.ScrollRect)
	self._layoutElement = self:getGo("item_detail_tips_751828810"):GetComponent(UIComponentType.LayoutElement)
	self._middleRect = self:getGo("item_detail_tips_751828810"):GetComponent(UIComponentType.RectTransform)
	self._timeTipGo = self:getGo("item_detail_tips_-1238849104")
	self._txtExpireTitle = self:getText("item_detail_tips_-1238849104")
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(EventType.TIPS_CHANGE_ENABLE_EVENT, self.changeComponentEnable, self)
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.TIPS_CHANGE_ENABLE_EVENT, self.changeComponentEnable, self)
end

function M:onEnter()
	self:_bindEvents()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)

	local info = self:getFirstParam()
	local itemData = info.baseData

	self._itemName.text = itemData:getName()

	goutil.setActive(self._useDesc.gameObject, true)

	self._useDesc.text = StringUtil.randomReplaceBlackBlock(itemData:getItemUseDesc())

	if self._useDesc.text == "" then
		goutil.setActive(self._useDesc.gameObject, false)
	end

	self._detailDesc.text = StringUtil.replaceTMPBlackBlock(itemData:getItemDesc())

	local itemId = itemData:getItemId()
	local buildCO = AirWorkShopConfig.instance:getBuildingCO(itemId)

	self._gridTxt.text = string.format(lang("tip_airwork_shape_grid"), buildCO.shape[1], buildCO.shape[2])
	self._txtExpireTime.text = self:getExpiredTimeStr(info.baseData:getExpireTime())

	if info.passEvent ~= nil then
		local passEvent = self:getUIComponent("empty_mask_tips_29887572", ComponentType.PassEvent)

		passEvent.isPassEvent = info.passEvent
	end

	goutil.setActive(self._gridTxt.gameObject.transform.parent.gameObject, true)
	IconLoader.setSpriteByItemType(self._iconImg, itemData:getType(), itemData:getIcon())
end

function M:onExit()
	self:_unbindEvents()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
end

function M:getExpiredTimeStr(expiredTime)
	expiredTime = expiredTime or 0
	expiredTime = tonumber(expiredTime)
	self._txtExpireTitle.text = lang("tip_overdue_remain")

	goutil.setActive(self._timeTipGo, expiredTime ~= 0)

	if expiredTime == 0 then
		return ""
	end

	local curTime = ServerTime.now() * 1000

	if expiredTime < curTime then
		self._txtExpireTitle.text = lang("tip_overdue")

		return ""
	end

	local offset = expiredTime - curTime

	return TextFormatter.formatExpireTime(offset / 1000)
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
end

return M

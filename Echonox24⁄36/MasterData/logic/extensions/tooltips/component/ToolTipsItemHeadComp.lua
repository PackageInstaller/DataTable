-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsItemHeadComp.lua

module("logic.extensions.tooltips.component.ToolTipsItemHeadComp", package.seeall)

local M = class("ToolTipsItemHeadComp", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._iconImg = false
	self._itemName = false
	self._itemCount = false
	self._useDesc = false
	self._detailDesc = false
	self._typeName = false
	self._imgQuality = false
end

function M:buildUI()
	self._iconImg = self:getImage("item_detail_tips_copy_1991515580")
	self._itemName = self:getText("item_tips_-1624252585")
	self._typeName = self:getText("item_detail_tips_1_1480321734")
	self._itemCount = self:getText("item_tips_162590809")
	self._useDesc = self:getText("item_tips_-136867712")
	self._detailDesc = self:getUIComponent("item_tips_67372985", UIComponentType.TextMeshProUGUI)
	self._txtExpireTime = self:getText("item_detail_tips_copy_632425988")
	self._imgQuality = self:getImage("item_detail_tips_1_-929434738")
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

	local isVisible = ItemModel.instance:getItemDataByUuid(itemData:getUuid())

	if not isVisible then
		goutil.setActive(self._typeName.gameObject, true)

		self._typeName.text = BackpackOtherConfig.instance:getTypeNameByTS(itemData:getType(), itemData:getSubType())
	end

	goutil.setActive(self._useDesc.gameObject, true)

	self._useDesc.text = StringUtil.randomReplaceBlackBlock(itemData:getItemUseDesc())

	if self._useDesc.text == "" then
		goutil.setActive(self._useDesc.gameObject, false)
	end

	self._detailDesc.text = StringUtil.replaceTMPBlackBlock(itemData:getItemDesc())
	self._itemCount.text = string.format("%s", info.ownerNum)
	self._txtExpireTime.text = self:getExpiredTimeStr(info.baseData:getExpireTime())

	if info.passEvent ~= nil then
		local passEvent = self:getUIComponent("empty_mask_tips_29887572", ComponentType.PassEvent)

		passEvent.isPassEvent = info.passEvent
	end

	goutil.setActive(self._itemCount.gameObject.transform.parent.gameObject, info.ownerNum > 0)
	IconLoader.setSpriteByItemType(self._iconImg, itemData:getType(), itemData:getIcon(), nil, nil, itemData:getSubType())

	local quality = itemData:getQuality()

	IconLoader.setSprite(self._imgQuality, IconType.Skinlib, CommEnum.Quality2TipsWordIcon[quality])
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

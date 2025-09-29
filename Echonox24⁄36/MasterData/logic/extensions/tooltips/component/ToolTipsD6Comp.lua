-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsD6Comp.lua

module("logic.extensions.tooltips.component.ToolTipsD6Comp", package.seeall)

local M = class("ToolTipsD6Comp", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._goLock = self:getGoByPath("node/top/lay/lock")
	self._imgIcon = self:getImageByPath("node/scroll/view/content/content1/icon")
	self._lock = self:getGoByPath("node/top/lay/lock/Lock")
	self._unlock = self:getGoByPath("node/top/lay/lock/unLock")
	self._btnLock = self:getBtnByPath("node/top/lay/lock/btnLock")
	self._txtName = self:getTextByPath("node/top/txtName")
	self._lockGo = self:getGoByPath("node/top/lay/lock")

	local attributeD6LayoutGo = self:getGoByPath("node/scroll/view/content/d6AttributeLayout")
	local attributeD6Template = goutil.findChild(attributeD6LayoutGo, "d6_attribute_item1")

	goutil.setActive(attributeD6Template, false)

	self._attrViewList = {}

	for index = 1, EquipEnum.MaxD6AttrHoleCount do
		local d6AttributeItemGo = goutil.clone(attributeD6Template)

		goutil.setActive(d6AttributeItemGo, true)
		goutil.addChildToParent(d6AttributeItemGo, attributeD6LayoutGo)

		local view = Astral.LuaComponentContainer.Add(d6AttributeItemGo, D6AttrItemView)

		table.insert(self._attrViewList, view)
	end

	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
end

function M:destroyUI()
	return
end

function M:_bindEvents()
	self._btnLock:AddClickListener(self._onClickLockBtn, self)
	GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self.refreshView, self)
	GlobalDispatcher:addEventListener(EventType.TIPS_CHANGE_ENABLE_EVENT, self.changeComponentEnable, self)
end

function M:_unbindEvents()
	self._btnLock:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self.refreshView, self)
	GlobalDispatcher:removeEventListener(EventType.TIPS_CHANGE_ENABLE_EVENT, self.changeComponentEnable, self)
end

function M:onEnter()
	self:_bindEvents()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Backpack)

	local info = self:getFirstParam()

	self._itemData = info.baseData
	self._isHideLock = info.isHideLock

	self:refreshView()
end

function M:onExit()
	self:_unbindEvents()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Backpack)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("close")
end

function M:_refreshLock()
	goutil.setActive(self._lockGo, false)

	if self._isHideLock or self._itemData:getUuid() == 0 then
		return
	end

	local uuid = self._itemData:getUuid()
	local diceItemData = ItemModel.instance:getItemDataByUuid(uuid)

	if not diceItemData then
		return
	end

	goutil.setActive(self._lockGo, true)
	self._lock:SetActive(diceItemData:getIsLock())
	self._unlock:SetActive(not diceItemData:getIsLock())
end

function M:refreshView()
	if not self._itemData then
		return
	end

	IconLoader.setSprite(self._imgIcon, IconType.D6Icon, self._itemData:getIcon())

	local quality = self._itemData:getQuality()
	local qualityName = lang(CommEnum.Quality2Lang[quality])

	self._txtName.text = qualityName .. self._itemData:getName()

	local attrs = self._itemData:getAttrs()

	for index, attrItem in ipairs(self._attrViewList) do
		local diceAttrMo = attrs[index]

		if diceAttrMo then
			attrItem:setVisible(true)

			if self._itemData:getUuid() == 0 then
				if index == 1 and not diceAttrMo:getIsFackAttr() then
					attrItem:setData(diceAttrMo)
				else
					attrItem:setStatus(EquipEnum.HoleStatus.Unknown)
				end
			else
				attrItem:setData(diceAttrMo)
			end
		else
			attrItem:setVisible(false)
		end

		attrItem:setRomeNum(index)
	end

	self:_refreshLock()
end

function M:_onClickLockBtn()
	local uuid = self._itemData:getUuid()

	EquipmentAgent.instance:sendDiceLockToggleRequest(uuid)
end

function M:changeComponentEnable(_, finish)
	if not finish then
		return
	end

	goutil.setActive(self.mainGO, true)
	self._guiAnimation:PlayAniByName("open1")
end

return M

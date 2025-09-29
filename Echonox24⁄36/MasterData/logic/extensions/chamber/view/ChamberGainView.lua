-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chamber/view/ChamberGainView.lua

module("logic.extensions.chamber.view.ChamberGainView", package.seeall)

local M = class("ChamberGainView", ViewComponent)
local YPosH = 127
local YPosL = 77

function M:ctor()
	self._contentGo = false
	self._btnClose = false
	self._emptyRaycast = false
	self._itemDataLst = {}
	self._itemAni = false
end

function M:buildUI()
	self._contentGo = self:getGo("secret_time_allotment_tips_1085391848")
	self._btnClose = self:getBtn("secret_time_allotment_tips_-318277971")
	self._itemTemplate = goutil.findChild(self._contentGo, "backpack_item")

	goutil.setActive(self._itemTemplate.gameObject, false)

	self._emptyRaycast = self:getUIComponent("secret_time_allotment_tips_-826729367", UIComponentType.EmptyRaycast)
	self._scrollRect = self:getUIComponent("secret_time_allotment_tips_188387583", UIComponentType.ScrollRect)
	self._scrollTransform = self._scrollRect.transform
end

function M:bindEvents()
	self._btnClose:AddClickListener(self.checkClose, self)
end

function M:checkClose()
	if ToolTipsController.instance:getInCloseTipsTime() then
		return
	end

	self:close()
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	local itemListData = self:getFirstParam() or {}

	self:_duelReciveItemLst(itemListData)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_gain)
end

function M:onExit()
	self:releaseTween()

	self._itemDataLst = nil
	self._itemCache = nil

	for i = 1, self._contentGo.transform.childCount - 1 do
		local itemGo = self._contentGo.transform:GetChild(i).gameObject

		goutil.destroy(itemGo)
	end
end

function M:destroyUI()
	goutil.clearChildren(self._contentGo)
end

function M:_duelReciveItemLst(itemListData)
	local len = itemListData and #itemListData or 0

	if len > 0 then
		if not self._itemDataLst then
			self._itemDataLst = {}
		end

		for key, value in ipairs(itemListData) do
			table.insert(self._itemDataLst, value)
		end
	end

	self:_refreshLstShow()
end

function M:_refreshLstShow()
	local itemGo, cell = false, false
	local itemDataLst = self._itemDataLst
	local len = itemDataLst and #itemDataLst or 0

	if len > 0 then
		table.sort(itemDataLst, ItemUtil.commonSortFunc)
	else
		self:close()

		return
	end

	self._emptyRaycast.enabled = len > 10

	local rootTrans = self._contentGo.transform

	while len > rootTrans.childCount - 1 do
		itemGo = goutil.clone(self._itemTemplate)

		goutil.addChildToParent(itemGo, self._contentGo)
	end

	if not self._itemAni then
		self._itemAni = {}
	end

	for i = 1, rootTrans.childCount - 1 do
		itemGo = rootTrans:GetChild(i).gameObject

		local itemData = itemDataLst[i]

		cell = Astral.LuaComponentContainer.Add(itemGo, ItemCell)

		cell:updateData(itemData)
		cell:setShowSelectedEffect(false)
		cell:onSelect(false)
		cell:setNumVisibleInGainItem()
		cell:getComponent("num"):setTextColor(Astral.ColorUtil.ParseColor("#BEBEBE"))
		cell:getComponent("num"):setVisible(ItemUtil.canShowNumInGain(itemData:getItemId()))
		cell:getComponent("num"):setNumBgNodeVisible(false)

		if not self._itemCache then
			self._itemCache = {}
		end

		self._itemCache[itemGo:GetInstanceID()] = cell

		table.insert(self._itemAni, cell)
		goutil.setActive(itemGo, true)

		itemGo:GetComponent(ComponentType.CanvasGroup).alpha = 0
	end

	self:_handleScrollable(len)
	self:_playAni()
end

function M:_handleScrollable(number)
	local pos = self._scrollTransform.anchoredPosition

	if number > 7 then
		self._scrollRect.enabled = true

		RectTransformUtils.SetAnchoredPosition(self._scrollTransform, pos.x, YPosH)
	else
		self._scrollRect.enabled = false

		RectTransformUtils.SetAnchoredPosition(self._scrollTransform, pos.x, YPosL)
	end
end

function M:_playAni()
	self:releaseTween()

	if not self._itemAni then
		return
	end

	local delayTime = 0

	for _, ani in ipairs(self._itemAni) do
		delayTime = delayTime + 0.2

		local tweenDelay = DoTweenUtil.DelayedCall(delayTime, function()
			ani:getGo():GetComponent(ComponentType.CanvasGroup).alpha = 1

			AnimationUtils.SetPlaySpeed(ani:getGo():GetComponent(ComponentType.Animation), 2)
			ani:getComponent("animation"):playAnim("backpack_item_conversion_open")
		end)

		table.insert(self._cacheTweenLst, tweenDelay)
	end

	self._itemAni = false
end

function M:releaseTween()
	for _, tweener in ipairs(self._cacheTweenLst or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end

	self._cacheTweenLst = {}
end

return M

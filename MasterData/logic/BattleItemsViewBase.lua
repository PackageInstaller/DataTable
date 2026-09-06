-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/items/BattleItemsViewBase.lua

module("logic.extensions.battle.view.BattleItemsViewBase", package.seeall)

local BattleItemsViewBase = class("BattleItemsViewBase")

function BattleItemsViewBase:ctor(view, mainGO, divLine, dragParent)
	self.mainGO = mainGO
	self.view = view
	self._itemsDivLine = divLine
	self._dragParent = dragParent

	self:_buildUI()
end

function BattleItemsViewBase:_buildUI()
	self._canvas = ViewMgr.instance:getUICanvas()
	self._itemsView = goutil.findChild(self.mainGO, "ScrollRect"):GetComponent("ScrollRect")
	self._itemsViewContent = goutil.findChild(self._itemsView, "Viewport/Content"):GetComponent("RectTransform")
	self._itemsLayout = goutil.findChild(self._itemsViewContent, "Items"):GetComponent("UILayoutSingleLine")

	local rect = self._canvas:GetComponent("RectTransform").rect
	local rectView = goutil.findChild(self._itemsView.gameObject, "Viewport"):GetComponent("RectTransform")

	self._pixelScaleX = rect.width / UnityEngine.Screen.width
	self._pixelScaleY = rect.height / UnityEngine.Screen.height
	self._viewSize = rectView.sizeDelta.x
	self._mainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()
	self._camPosX = BattleSceneCamera.cameraPosX
	self._camPosY = BattleSceneCamera.cameraPosY
	self._camPosZ = BattleSceneCamera.cameraPosZ

	self.mainGO:SetActive(false)
end

function BattleItemsViewBase:onEnter()
	self.mainGO:SetActive(true)
	GlobalDispatcher:addListener(GlobalNotify.OnForbidPauseSkill, self._onForbidPauseSkill, self)
	GlobalDispatcher:addListener(GlobalNotify.BattleItemsInfo, self._onBattleItemCD, self)
	GlobalDispatcher:addListener(GlobalNotify.BattleHurtData, self._onBattleHurtData, self)
	Framework.TransformUtil.SetLocalPos(self._itemsViewContent, 0, 0, 0)
	self:updateItems()
	self:_updateViewSize()
end

function BattleItemsViewBase:onExit()
	self.mainGO:SetActive(false)
	GlobalDispatcher:removeListener(GlobalNotify.OnForbidPauseSkill, self._onForbidPauseSkill, self)
	GlobalDispatcher:removeListener(GlobalNotify.BattleItemsInfo, self._onBattleItemCD, self)
	GlobalDispatcher:removeListener(GlobalNotify.BattleHurtData, self._onBattleHurtData, self)
	removetimer(self._tickDraggingItem, self)
	removetimer(self._tickClickableItem, self)
	self:_stopSelectItemEffect()

	self._clickItemSelectItemId = nil
	self._itemTargetUnits = nil
	self._isAutoUsingItem = nil
	self._dragItemId = nil
	self._dragClone = nil
end

function BattleItemsViewBase:setAutoUsingItem(auto)
	self._isAutoUsingItem = auto
end

function BattleItemsViewBase:updateItems()
	local battleItems = BattleItemsModel.instance:getBattleItems()
	local transform = self._itemsLayout.transform
	local childCount = transform.childCount
	local itemNum = 0

	if battleItems then
		itemNum = #battleItems
	end

	if itemNum < 4 then
		itemNum = 4
	end

	while childCount < itemNum do
		local go = transform:GetChild(0).gameObject
		local goClone = goutil.cloneAndSetParent(go, transform)

		Framework.TransformUtil.SetLocalScale(goClone.transform, 1, 1, 1)
		Framework.TransformUtil.SetLocalPos(goClone.transform, 0, 0, 0)

		childCount = childCount + 1
	end

	local num = 1

	for i = 1, itemNum do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(true)

		local item

		self:_updateItem(go, (battleItems or nil) and battleItems[i])

		num = num + 1
	end

	for i = num, childCount do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	self._itemsLayout:Layout()
end

function BattleItemsViewBase:_updateViewSize()
	local viewSize = self:_calculateViewSize()
	local sizeDelta = self._itemsViewContent.sizeDelta

	sizeDelta.x = viewSize
	self._itemsViewContent.sizeDelta = sizeDelta

	local enabledView = viewSize > self._viewSize

	UGUIToolHelper.EnabledScrollRect(self._itemsView, enabledView)
	self._itemsDivLine:SetActive(enabledView)
end

function BattleItemsViewBase:_calculateViewSize()
	local battleItems = BattleItemsModel.instance:getBattleItems()
	local itemNum = 0

	if battleItems then
		itemNum = #battleItems
	end

	if itemNum < 4 then
		itemNum = 4
	end

	return itemNum * 100
end

function BattleItemsViewBase:_checkDragableItem(cell, dragContainer, itemId)
	if BattleItemsModel.instance:isItemDragable() then
		cell.enabled = true
		dragContainer.filter = itemId
		cell.destroyCloneObject = false
		cell.data = itemId
		dragContainer.data = itemId
		dragContainer.parentOnDrag = self._dragParent

		dragContainer:RegisterDraggingCallback(self._onDragCellAvailable, self._onDragCellStarted, self._onDragCellMoved, self._onDragCellEnded, self._cloneDraggingObject, self)
	else
		cell.enabled = false
	end
end

function BattleItemsViewBase:_startDragableItem(itemId)
	self:_stopClickableItem()

	self._dragItemId = itemId

	if self:_isPauseable() then
		BattleController.instance:pauseAll(true)
		self:_openSelectTargetView(itemId)
		removetimer(self._tickDraggingItem, self)
	else
		settimer(0, self._tickDraggingItem, self)
	end

	BattleItemController.instance:startItemUsableEffects(itemId)
	UGUIToolHelper.SetScreenPositionToUGUI(self._dragClone.transform, 0, 0, 0, self._dragParentCanvas)
	self._dragClone:SetActive(true)
end

function BattleItemsViewBase:_openSelectTargetView(itemId)
	self._itemTargetUnits = BattleItemController.instance:getTargetUnitsByItemId(itemId, self._itemTargetUnits)

	ViewMgr.instance:open(ViewName.BattleSelectUnit, self._itemTargetUnits)
end

function BattleItemsViewBase:_closeSelectTargetView()
	ViewMgr.instance:close(ViewName.BattleSelectUnit)
end

function BattleItemsViewBase:_stopDragableItem()
	local selItemId = self._dragItemId

	self._dragItemId = nil

	removetimer(self._tickDraggingItem, self)
	BattleController.instance:pauseAll(false)
	self:_closeSelectTargetView()

	if self._dragClone then
		self._dragClone:SetActive(false)
	end

	if selItemId then
		BattleItemController.instance:stopItemUsableEffects(selItemId)
		GlobalDispatcher:dispatch(GlobalNotify.OnCancelBattleItem, selItemId)
	end
end

function BattleItemsViewBase:_checkClickableItem(btn, icon, item)
	btn:AddClickListener(function()
		if BattleModel.instance.viewFightBtl then
			TipsFacade.instance:openCommonTips(lang("text_zdju_useItem"))

			return
		end

		if not self:_isItemNumEnough(item:getItemId()) or not BattleItemController.instance:isItemUsable(item) then
			self:_stopClickableItem()
			self:_stopDragableItem()
			self:_showLimitTips(item:getItemId())

			return
		end

		if self:_startClickableItem(item:getItemId()) then
			self:_playSelectItemEffect(icon)
			self:_activeSelectItemEffect(true)
		end
	end, self)
end

function BattleItemsViewBase:_startClickableItem(itemId)
	local item = BattleItemsModel.instance:getBattleItemById(itemId)

	if item:isNeededSelectTarget() then
		if self._clickItemSelectItemId ~= itemId and BattleItemsModel.instance:isItemClickable() then
			self:_stopDragableItem()

			self._clickItemSelectItemId = itemId

			if self:_isPauseable() then
				BattleController.instance:pauseAll(true)
				self:_openSelectTargetView(itemId)
				removetimer(self._tickClickableItem, self)
			else
				settimer(0, self._tickClickableItem, self)
			end

			BattleItemController.instance:startItemUsableEffects(itemId)
			GlobalDispatcher:dispatch(GlobalNotify.OnSelectBattleItem, itemId)

			return true
		end

		self:_stopClickableItem()
	elseif BattleItemsModel.instance:isItemClickable() then
		BattleItemController.instance:pushUseItem(itemId)

		self._clickItemSelectItemId = nil

		self:_stopClickableItem()
	end
end

function BattleItemsViewBase:_stopClickableItem()
	local selItemId = self._clickItemSelectItemId

	self._clickItemSelectItemId = nil

	self:_stopSelectItemEffect()
	self:_activeSelectItemEffect(false)
	removetimer(self._tickClickableItem, self)
	BattleController.instance:pauseAll(false)
	self:_closeSelectTargetView()

	if self._dragClone then
		self._dragClone:SetActive(false)
	end

	if selItemId then
		BattleItemController.instance:stopItemUsableEffects(selItemId)
		GlobalDispatcher:dispatch(GlobalNotify.OnCancelBattleItem, selItemId)
	end
end

function BattleItemsViewBase:tickClickUnit()
	if self._clickItemSelectItemId then
		if not BattleModel.instance.pauseBattle then
			self:_stopClickableItem()

			return true
		end

		if UGUIToolHelper.IsTouchDown() and not UGUIToolHelper.IsOverUI() then
			local itemId = self._clickItemSelectItemId
			local unit = self:_judgeItemTarget(itemId)

			self:_stopClickableItem()

			if unit then
				BattleItemController.instance:pushUseItem(itemId, unit)
			end
		end

		return true
	end
end

function BattleItemsViewBase:_tickClickableItem()
	if self:_isPauseable() then
		BattleController.instance:pauseAll(true)
		self:_openSelectTargetView(self._clickItemSelectItemId)
		removetimer(self._tickClickableItem, self)
	end
end

function BattleItemsViewBase:_playSelectItemEffect(go)
	if not self._selItemEffect then
		self._selItemEffect = UIEffectManager.instance:playEffectBrief(self.view, "fx_ui_zhandou/fx_ui_battleitem_xuanzhong.prefab", go:GetComponent("RectTransform"), true, self._onSelectedEffectLoaded, self)
	else
		UIEffectManager:updateEffectPositionByWidget(self._selItemEffect, go:GetComponent("RectTransform"))
	end
end

function BattleItemsViewBase:_stopSelectItemEffect()
	if self._selItemEffect then
		UIEffectManager.instance:stopEffect(self._selItemEffect)

		self._selItemEffect = nil
	end
end

function BattleItemsViewBase:_activeSelectItemEffect(active)
	if self._selItemEffect then
		self._selItemEffect:setVisible(active)
	end
end

function BattleItemsViewBase:_onSelectedEffectLoaded(effCo)
	GoUtil.SetSortingOrder(effCo.effGo, 200)

	self._selItemEffect = effCo

	self._selItemEffect:setScrollRectClipping(self._itemsView)
	self._selItemEffect:setParent(self._itemsViewContent)
	self._selItemEffect:setScale(1)
end

function BattleItemsViewBase:_showLimitTips(itemId)
	if BattleController.instance:isForbidPause() or BattleModel.instance.isBirthing then
		TipsFacade.instance:openCommonTips(lang("battleitem_unusable"))

		return
	end

	local battleItemsModel = BattleItemsModel.instance
	local item = battleItemsModel:getBattleItemById(itemId)
	local itemName = item:getItemName()
	local consumeNum = item:consumeNumPerAction()
	local itemNum = item:getItemNum()
	local consueEnergy = item:consumeEnergyPerAction()

	if itemNum == 0 and item:getItemType() ~= GameEnum.BattleItemType.Ball then
		TipsFacade.instance:openCommonTips(lang("text_no_skill"))

		return
	end

	if itemNum == 0 or itemNum < consumeNum then
		TipsFacade.instance:openCommonTips(string.format(lang("ui_item_notenough"), consumeNum, itemName))

		return
	end

	if consueEnergy > BattleItemsModel.instance.battleItemEnergy then
		TipsFacade.instance:openCommonTips(lang("battleitem_energy_noenough"))

		return
	end

	local currCd = item:getCurrCd()

	if currCd > 0 then
		TipsFacade.instance:openCommonTips(string.format(lang("catch_waiting_cd"), currCd))

		return
	else
		local isItemUsable = battleItemsModel:isItemUsable()

		if not isItemUsable then
			TipsFacade.instance:openCommonTips(battleItemsModel:getItemUnusableTips())

			return
		end

		if BattleItemsModel.instance.performing then
			TipsFacade.instance:openCommonTips(lang("battleitem_unusable"))

			return
		end
	end

	return true
end

function BattleItemsViewBase:_onDragCellAvailable(container, cell)
	if BattleModel.instance.viewFightBtl then
		TipsFacade.instance:openCommonTips(lang("text_zdju_useItem"))

		return false
	end

	if BattleModel.instance:hasReceivedResult() then
		return false
	end

	if BattleModel.instance:hasError() then
		return false
	end

	local item = BattleItemsModel.instance:getBattleItemById(cell.data)

	if not self:_isItemNumEnough(cell.data) or not BattleItemController.instance:isItemUsable(item) then
		return false
	end

	if not item:isNeededSelectTarget() then
		return false
	end

	return true
end

function BattleItemsViewBase:_onDragCellStarted(container, cell)
	return
end

function BattleItemsViewBase:_onDragCellMoved(vec2, vec3)
	UGUIToolHelper.SetScreenPositionToUGUI(self._dragClone.transform, 0, 0, 0, self._dragParentCanvas)

	return true
end

function BattleItemsViewBase:_onDragCellEnded(container, cell)
	self._dragItemId = cell.data

	self:_stopDragableItem()

	local unit = self:_judgeItemTarget(cell.data)

	if unit then
		BattleItemController.instance:pushUseItem(cell.data, unit)
	end

	return false
end

function BattleItemsViewBase:_cloneDraggingObject(container, cell)
	return
end

function BattleItemsViewBase:_tickDraggingItem()
	if self:_isPauseable() then
		BattleController.instance:pauseAll(true)
		self:_openSelectTargetView(self._dragItemId)
		removetimer(self._tickDraggingItem, self)
	end
end

function BattleItemsViewBase:_isPauseable()
	return not BattleController.instance:isForbidPause()
end

function BattleItemsViewBase:_isItemNumEnough(itemId)
	return true
end

function BattleItemsViewBase:_judgeItemTarget(itemId)
	if BattleModel.instance:hasReceivedResult() then
		return
	end

	if BattleModel.instance:hasError() then
		return
	end

	local bounds = {}

	self._itemTargetUnits = BattleItemController.instance:getTargetUnitsByItemId(itemId, self._itemTargetUnits)

	if self._itemTargetUnits then
		local forceUseItemUnit = BattleItemsModel.instance.forceUseItemUnit
		local cnt = #self._itemTargetUnits

		for i = 1, cnt do
			local unit = self._itemTargetUnits[i]

			if (not forceUseItemUnit or forceUseItemUnit == unit) and unit:isTouchHitTarget(bounds) then
				return unit
			end
		end

		for i = 1, cnt do
			local unit = self._itemTargetUnits[i]

			if (not forceUseItemUnit or forceUseItemUnit == unit) and unit:isTouchHitTarget(bounds, 2, 2) then
				return unit
			end
		end
	end
end

function BattleItemsViewBase:_onBattleItemCD()
	self:updateItems()
end

function BattleItemsViewBase:_onBattleHurtData()
	self:updateItems()
end

function BattleItemsViewBase:_onForbidPauseSkill(pause)
	self:updateItems()
end

return BattleItemsViewBase

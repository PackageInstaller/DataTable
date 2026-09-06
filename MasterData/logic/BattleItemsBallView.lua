-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/items/BattleItemsBallView.lua

module("logic.extensions.battle.view.BattleItemsBallView", package.seeall)

local BattleItemsBallView = class("BattleItemsBallView", BattleItemsViewBase)

function BattleItemsBallView:ctor(view, mainGO, divLine, dragParent, dragClone, dragCloneBall)
	BattleItemsBallView.super.ctor(self, view, mainGO, divLine, dragParent)

	self._dragCloneObj = dragClone
	self._dragCloneBall = dragCloneBall
end

function BattleItemsBallView:onExit()
	BattleItemsBallView.super.onExit(self)
	self:_clearImageCaches()
	self:_clearBallEffectsw()
end

function BattleItemsBallView:_updateItem(go, item)
	local empty = goutil.findChild(go, "Empty")
	local cellGo = goutil.findChild(go, "cell")

	if not item then
		empty:SetActive(true)
		cellGo:SetActive(false)

		return
	end

	empty:SetActive(false)
	cellGo:SetActive(true)

	local dragContainer = go:GetComponent("UIDragContainerForLua")
	local cell = cellGo:GetComponent("UIDragCell")
	local name = goutil.findChild(go, "cell/name"):GetComponent("Text")
	local num = goutil.findChild(go, "cell/num"):GetComponent("Text")
	local limit = goutil.findChild(go, "cell/limit")
	local icon = goutil.findChildImageComponent(go, "cell/Icon")
	local btn = Framework.ButtonAdapter.GetFrom(go, "cell")
	local itemId = item:getItemId()

	if not BattleItemController.instance:isItemUsable(item) then
		limit:SetActive(true)

		local jindu = goutil.findChild(go, "cell/limit/jindu"):GetComponent("Slider")
		local cd = goutil.findChild(go, "cell/limit/cd"):GetComponent("Text")
		local jinzhi = goutil.findChild(go, "cell/limit/jinzhi")
		local currCd = item:getCurrCd()

		if item:getItemNum() ~= 0 then
			if currCd > 0 then
				jinzhi:SetActive(false)

				cd.text = tostring(currCd)
				jindu.value = currCd / item:getCd()
			else
				jinzhi:SetActive(true)

				cd.text = ""
				jindu.value = 1
			end
		else
			jinzhi:SetActive(false)

			cd.text = ""
			jindu.value = 1
		end

		self:_stopBallEffect(itemId)
	else
		self:_playBallEffect(itemId, icon:GetComponent("RectTransform"))
		limit:SetActive(false)
	end

	uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, item:getItemIcon())
	self:_checkClickableItem(btn, icon, item)
	self:_checkDragableItem(cell, dragContainer, itemId)

	name.text = item:isTargetSingle() and lang("ball_targetnum_single") or lang("ball_targetnum_all")
	num.text = tostring(item:getItemNum())

	BattleItemsModel.instance:addItemSprite(itemId, icon.sprite)
	BattleItemsModel.instance:addItemWidget(itemId, icon)
end

function BattleItemsBallView:_cloneDraggingObject(container, cell)
	self._dragClone = self._dragCloneObj

	return self._dragCloneObj
end

function BattleItemsBallView:_onDragCellStarted(container, cell)
	local imgGo = goutil.findChild(cell.gameObject, "Icon")
	local img = imgGo:GetComponent("RectTransform")
	local imgIcon = imgGo:GetComponent("Image")

	self._dragCloneBall.sprite = imgIcon.sprite

	self:_startDragableItem(cell.data)
end

function BattleItemsBallView:_clearImageCaches()
	local transform = self._itemsLayout.transform
	local childCount = transform.childCount - 1

	for i = 0, childCount do
		local go = transform:GetChild(i).gameObject
		local icon = goutil.findChild(go, "cell/Icon")
		local bigImg = icon:GetComponent("ImageBigBG")

		if bigImg then
			bigImg:ClearImage()
		end

		local dragContainer = go:GetComponent("UIDragContainerForLua")
		local btn = Framework.ButtonAdapter.GetFrom(go, "cell")

		dragContainer:UnRegisterDraggingCallback()
		btn:RemoveClickListener()
	end
end

function BattleItemsBallView:_playSelectItemEffect(go)
	if not self._selItemEffect then
		self._selItemEffect = UIEffectManager.instance:playEffectBrief(self.view, "fx_ui_jinglingbuzhuo/fx_ui_jinglingqiu_xuanding.prefab", go:GetComponent("RectTransform"), true, self._onSelectedEffectLoaded, self)

		self._selItemEffect:setOffset(0, 0)
	else
		UIEffectManager:updateEffectPositionByWidget(self._selItemEffect, go:GetComponent("RectTransform"))
	end
end

function BattleItemsBallView:_playBallEffect(itemId, widget)
	self._ballEffects = self._ballEffects or {}

	local effect = self._ballEffects[itemId]

	if effect then
		effect:setActive(true)

		return
	end

	effect = UIEffectManager.instance:playEffectBrief(self.view, "fx_ui_jinglingbuzhuo/fx_ui_jinglingqiu_keyong.prefab", widget, true, self._onBallEffectLoaded, self)

	effect:setParent(widget)
	effect:setScale(1)

	self._ballEffects[itemId] = effect
end

function BattleItemsBallView:_onBallEffectLoaded(effCo)
	GoUtil.SetSortingOrder(effCo.effGo, 200)
	effCo:setScrollRectClipping(self._itemsView)
end

function BattleItemsBallView:_stopBallEffect(itemId)
	if self._ballEffects then
		local effect = self._ballEffects[itemId]

		if effect then
			effect:setActive(false)
		end
	end
end

function BattleItemsBallView:_clearBallEffectsw()
	if self._ballEffects then
		for k, v in pairs(self._ballEffects) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._ballEffects = nil
	end
end

return BattleItemsBallView

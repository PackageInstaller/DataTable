-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/items/BattleItemsSkillView.lua

module("logic.extensions.battle.view.BattleItemsSkillView", package.seeall)

local BattleItemsSkillView = class("BattleItemsSkillView", BattleItemsViewBase)
local UnityTime = UnityEngine.Time
local maxBattleEnergy = 10

function BattleItemsSkillView:ctor(view, mainGO, divLine, dragParent, dragClone)
	BattleItemsBallView.super.ctor(self, view, mainGO, divLine, dragParent)

	self._dragCloneObj = dragClone
	self._dragCloneIcon = goutil.findChildImageComponent(self._dragCloneObj, "Mask/Icon")
	self._dragCloneAttr = goutil.findChildImageComponent(self._dragCloneObj, "Attr/icon")
end

function BattleItemsSkillView:_buildUI()
	BattleItemsSkillView.super._buildUI(self)

	self._energyNum = goutil.findChildTextComponent(self.mainGO, "EnergyNum")
	self._energyPregress = goutil.findChild(self.mainGO, "EnergySlider"):GetComponent("Slider")
	self._energyPregressMax = goutil.findChild(self.mainGO, "SliderEmergyMax")
	self._energyEffNode = goutil.findChild(self.mainGO, "EnergyEff"):GetComponent("RectTransform")
	self._energysTween = self._energyNum:GetComponent("UITweenSequence")
	self._energySliderMask = goutil.findChild(self.mainGO, "EnergySliderMask"):GetComponent("RectTransform")
	self._energySliderMaskEffNode = goutil.findChild(self.mainGO, "EnergySliderMask/EnergySliderEff"):GetComponent("RectTransform")
	self._energySliderNoMaskEffNode = goutil.findChild(self.mainGO, "EnergySliderNoMask"):GetComponent("RectTransform")
	self._energyMaxEffectNode = goutil.findChild(self.mainGO, "EnergyMaxEff"):GetComponent("RectTransform")
end

function BattleItemsSkillView:onEnter()
	self:_playEnergyEffect()
	self:_playEnergySliderEffect()

	self._currSliderValue = 1
	self._toSliderValue = 1

	self:_updateEnergy(BattleItemsModel.instance.battleItemEnergy)
	self:_updateSliderValue(BattleItemsModel.instance.battleItemEnergy / maxBattleEnergy)
	settimer(0, self._tickSliderEffect, self)
	GlobalDispatcher:addListener(GlobalNotify.BattleEnergy, self._onBattleEnergy, self)
	BattleItemsSkillView.super.onEnter(self)
end

function BattleItemsSkillView:onExit()
	BattleItemsSkillView.super.onExit(self)
	removetimer(self._tickSliderEffect, self)
	self._energysTween:Stop()
	Framework.TransformUtil.SetLocalScale(self._energysTween.transform, 1, 1, 1)
	self:_clearFlyEffects()
	self:_stopEnergyEffect()
	self:_clearImageCaches()
	self:_clearSliderEffects()
	GlobalDispatcher:removeListener(GlobalNotify.BattleEnergy, self._onBattleEnergy, self)
end

function BattleItemsSkillView:_showLimitTips(itemId)
	if BattleItemsSkillView.super._showLimitTips(self, itemId) and not self:_isItemNumEnough(itemId) then
		TipsFacade.instance:openCommonTips(lang("battleitem_energy_noenough"))
	end
end

function BattleItemsSkillView:_clearImageCaches()
	local transform = self._itemsLayout.transform
	local childCount = transform.childCount - 1

	for i = 0, childCount do
		local go = transform:GetChild(i).gameObject
		local icon = goutil.findChild(go, "cell/Mask/Icon")
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

function BattleItemsSkillView:_updateItem(go, item)
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
	local energy = goutil.findChild(go, "cell/Energy"):GetComponent("Text")
	local limit = goutil.findChild(go, "cell/limit")
	local icon = goutil.findChildImageComponent(go, "cell/Mask/Icon")
	local btn = Framework.ButtonAdapter.GetFrom(go, "cell")
	local attrIcon = goutil.findChildImageComponent(go, "cell/Attr/icon"):GetComponent("UIImageSpriteChange")
	local itemId = item:getItemId()

	if not BattleItemController.instance:isItemUsable(item) or not self:_isItemNumEnough(itemId) then
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
			jinzhi:SetActive(true)

			cd.text = ""
			jindu.value = 1
		end
	else
		limit:SetActive(false)
	end

	uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, item:getItemIcon())
	self:_checkClickableItem(btn, icon, item)
	self:_checkDragableItem(cell, dragContainer, itemId)

	local skinId = item:getPetId()
	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

	attrIcon:SetState(math.fmod(race, 10) - 1)

	local consume = item:consumeEnergyPerAction()

	energy.text = tostring(consume)

	BattleItemsModel.instance:addItemSprite(itemId, icon.sprite)
	BattleItemsModel.instance:addItemWidget(itemId, icon)
end

function BattleItemsSkillView:_onDragCellStarted(container, cell)
	local imgGo = goutil.findChild(cell.gameObject, "Mask/Icon")
	local img = imgGo:GetComponent("RectTransform")
	local imgIcon = imgGo:GetComponent("Image")
	local attrIcon = goutil.findChildImageComponent(cell.gameObject, "Attr/icon")

	self._dragCloneIcon.sprite = imgIcon.sprite
	self._dragCloneAttr.sprite = attrIcon.sprite

	self:_startDragableItem(cell.data)
end

function BattleItemsSkillView:_cloneDraggingObject(container, cell)
	self._dragClone = self._dragCloneObj

	return self._dragCloneObj
end

function BattleItemsSkillView:_playSelectItemEffect(go)
	if not self._selItemEffect then
		self._selItemEffect = UIEffectManager.instance:playEffectBrief(self.view, "fx_ui_zhandou/fx_ui_battleitem_xuanzhong.prefab", go:GetComponent("RectTransform"), true, self._onSelectedEffectLoaded, self)

		self._selItemEffect:setOffset(0, 0)
	else
		UIEffectManager:updateEffectPositionByWidget(self._selItemEffect, go:GetComponent("RectTransform"))
	end
end

function BattleItemsSkillView:_onSelectedEffectLoaded(effCo)
	GoUtil.SetSortingOrder(effCo.effGo, 200)

	self._selItemEffect = effCo

	self._selItemEffect:setScrollRectClipping(self._itemsView)
	self._selItemEffect:setParent(self._itemsViewContent)
	self._selItemEffect:setScale(1.22)
end

function BattleItemsSkillView:_updateEnergy(energy)
	self._currEnergyNum = energy
	self._energyNum.text = tostring(energy)

	local progress = self._currEnergyNum / maxBattleEnergy

	if progress < self._currSliderValue then
		self._currSliderValue = progress
		self._toSliderValue = progress

		self:_updateSliderValue(progress)
	else
		self._toSliderValue = progress
	end
end

function BattleItemsSkillView:_updateSliderValue(currSliderValue)
	if currSliderValue > 1 then
		currSliderValue = 1
	end

	if currSliderValue < 0 then
		currSliderValue = 0
	end

	self._energyPregress.value = currSliderValue
	self._currSliderValue = currSliderValue

	local x = -198 + 390 * currSliderValue

	Framework.TransformUtil.SetLocalPos(self._energySliderMaskEffNode, x, -4, 0)

	local wx, wy, wz = Framework.TransformUtil.GetPos(self._energySliderMaskEffNode, nil, nil, nil)

	Framework.TransformUtil.SetPos(self._energySliderNoMaskEffNode.transform, wx, wy, wz)

	if self._currSliderValue >= 1 then
		self:_playEnergyMaxEffect()
	else
		self:_stopEnergyMaxEffect()
	end
end

function BattleItemsSkillView:_playEnergyEffect()
	if not self._energyEffect then
		self._energyEffect = UIEffectManager.instance:playEffectBrief(self.view, "fx_ui_zhandou/fx_ui_nengliang_loop.prefab", self._energyEffNode, true)

		self._energyEffect:setParent(self._energyEffNode)
		self._energyEffect:setScale(1)
	end
end

function BattleItemsSkillView:_stopEnergyEffect()
	if self._energyEffect then
		UIEffectManager.instance:stopEffect(self._energyEffect)

		self._energyEffect = nil
	end
end

function BattleItemsSkillView:_onBattleEnergy(energy, changeValue, allUnits)
	if changeValue <= 0 then
		self:_updateEnergy(self._currEnergyNum + changeValue)
	else
		local unitIdx = 1
		local unitCount = #allUnits

		for i = 1, changeValue do
			self:_playEnergyFlyEffect(allUnits[unitIdx])

			unitIdx = unitIdx + 1

			if unitCount < unitIdx then
				unitIdx = 1
			end
		end
	end
end

function BattleItemsSkillView:_playEnergyFlyEffect(unit)
	local eff = self:_getEnergyFlyEffect()

	self._energyFlyEffects = self._energyFlyEffects or {}

	table.insert(self._energyFlyEffects, eff)

	if eff.effGo then
		self:_startFlyEffectLoaded(eff, unit)
	else
		function eff.loadedHandler()
			eff:setParent(self._energyEffNode)
			eff:setScale(1)
			self:_startFlyEffectLoaded(eff, unit)
		end
	end
end

function BattleItemsSkillView:_getEnergyFlyEffect()
	local eff

	if self._freeEnergyFlyEffects then
		eff = self._freeEnergyFlyEffects[1]

		if self._freeEnergyFlyEffects[1] then
			table.remove(self._freeEnergyFlyEffects, 1)

			return eff
		end
	end

	eff = UIEffectManager.instance:playEffectBrief(self.view, "fx_ui_zhandou/fx_ui_nengliang_trail.prefab", self._energyEffNode, true)

	return eff
end

function BattleItemsSkillView:_startFlyEffectLoaded(effCo, unit)
	effCo.effGo:SetActive(false)

	local screenPos = unit:getUnitScreenPos(UnitConst.spineCenterPointPath)
	local localPos = UGUIToolHelper.ScreenToUGUILocalPosition(self._energyEffNode, GlobalModel.instance.uiCamera, screenPos)
	local start = Vector3.New(localPos.x, localPos.y, 0)
	local dest = Vector3.New(0, 0, 0)
	local dir = dest - start

	dir:Normalize()

	local radius = math.rad(90)
	local cos = math.cos(radius)
	local sin = math.sin(radius)
	local rotateDir = Vector3.New(dir.x * cos - dir.y * sin, dir.x * sin + dir.y * cos, 0)

	rotateDir:Normalize()

	local length = Vector3.Distance(start, dest)
	local rangeLength = UnityEngine.Random.Range(-0.8, 0.8)
	local rangeDir = UnityEngine.Random.Range(-2, 2)
	local dirPos = Vector3.Lerp(start, dest, rangeLength)
	local temp = rotateDir * rangeDir

	dirPos = dirPos + temp

	local bezier = UnityTweens.TweenBezier.StartTween(effCo.effGo, start, dest, dirPos, dirPos, math.random(0.5, 1), UnityTweens.EaseType.easeInSine)

	bezier:AddListener(function()
		effCo.effGo:SetActive(false)

		self._freeEnergyFlyEffects = self._freeEnergyFlyEffects or {}

		table.insert(self._freeEnergyFlyEffects, effCo)
		self:_playEnergyHitEffect()
		self:_updateEnergy(self._currEnergyNum + 1)
		self:updateItems()

		for i = 1, #self._energyFlyEffects do
			if self._energyFlyEffects[i] == effCo then
				table.remove(self._energyFlyEffects, i)

				break
			end
		end
	end, nil)
	effCo.effGo:SetActive(true)
end

function BattleItemsSkillView:_clearFlyEffects()
	if self._freeEnergyFlyEffects then
		for i = 1, #self._freeEnergyFlyEffects do
			UIEffectManager.instance:stopEffect(self._freeEnergyFlyEffects[i])
		end
	end

	if self._energyFlyEffects then
		for i = 1, #self._energyFlyEffects do
			UIEffectManager.instance:stopEffect(self._energyFlyEffects[i])
		end
	end

	self._energyFlyEffects = nil
	self._freeEnergyFlyEffects = nil
end

function BattleItemsSkillView:_playEnergyHitEffect()
	local eff = UIEffectManager.instance:playEffect(self.view, "fx_ui_zhandou/fx_ui_nengliang_hit.prefab", self._energyEffNode, 0, 0, false, false)

	eff:setParent(self._energyEffNode)
	eff:setScale(1)
	Framework.TransformUtil.SetLocalScale(self._energysTween.transform, 1, 1, 1)
	self._energysTween:Stop()
	self._energysTween:Begin()
end

function BattleItemsSkillView:_isItemNumEnough(itemId)
	local item = BattleItemsModel.instance:getBattleItemById(itemId)
	local consueEnergy = item:consumeEnergyPerAction()

	if consueEnergy > self._currEnergyNum then
		return
	end

	return true
end

function BattleItemsSkillView:_playEnergySliderEffect()
	self._sliderMaskEffect = UIEffectManager.instance:playEffectBrief(self.view, "fx_ui_zhandou/fx_ui_nengliangtian_mask.prefab", self._energySliderMaskEffNode, true, self._onSliderMaskEffectLoaded, self)

	self._sliderMaskEffect:setParent(self._energySliderMaskEffNode)
	self._sliderMaskEffect:setScale(360)

	self._sliderEffect = UIEffectManager.instance:playEffectBrief(self.view, "fx_ui_zhandou/fx_ui_nengliangtian_nomask.prefab", self._energySliderNoMaskEffNode, true)

	self._sliderEffect:setParent(self._energySliderNoMaskEffNode)
	self._sliderEffect:setScale(360)
end

function BattleItemsSkillView:_playEnergyMaxEffect()
	if not self._sliderMaxEffect then
		self._sliderMaxEffect = UIEffectManager.instance:playEffectBrief(self.view, "fx_ui_zhandou/fx_ui_nengliangtiao_man.prefab", self._energyMaxEffectNode, true)

		self._sliderMaxEffect:setParent(self._energyMaxEffectNode)
		self._sliderMaxEffect:setScale(1)
	else
		self._sliderMaxEffect:setVisible(true)
	end

	self._sliderMaskEffect:setVisible(false)
	self._sliderEffect:setVisible(false)
	self._energyPregress.gameObject:SetActive(false)
	self._energyPregressMax:SetActive(true)
end

function BattleItemsSkillView:_stopEnergyMaxEffect()
	if self._sliderMaxEffect then
		self._sliderMaxEffect:setVisible(false)
	end

	self._sliderMaskEffect:setVisible(true)
	self._sliderEffect:setVisible(true)
	self._energyPregress.gameObject:SetActive(true)
	self._energyPregressMax:SetActive(false)
end

function BattleItemsSkillView:_onSliderMaskEffectLoaded(effCo)
	self._sliderMaskEffect:setClipping(self._energySliderMask)
end

function BattleItemsSkillView:_clearSliderEffects()
	if self._sliderMaxEffect then
		UIEffectManager.instance:stopEffect(self._sliderMaxEffect)
	end

	if self._sliderMaskEffect then
		UIEffectManager.instance:stopEffect(self._sliderMaskEffect)
	end

	if self._sliderEffect then
		UIEffectManager.instance:stopEffect(self._sliderEffect)
	end

	self._sliderMaxEffect = nil
	self._sliderMaskEffect = nil
	self._sliderEffect = nil
end

function BattleItemsSkillView:_tickSliderEffect()
	if self._toSliderValue > self._currSliderValue then
		local deltaTime = UnityTime.deltaTime

		self._currSliderValue = self._currSliderValue + 0.4 * deltaTime

		if self._currSliderValue > self._toSliderValue then
			self._currSliderValue = self._toSliderValue
		end

		self:_updateSliderValue(self._currSliderValue)
	end
end

return BattleItemsSkillView

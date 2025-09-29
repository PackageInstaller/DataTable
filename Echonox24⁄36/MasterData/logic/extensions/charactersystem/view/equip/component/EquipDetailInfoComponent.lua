-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/component/EquipDetailInfoComponent.lua

module("logic.extensions.charactersystem.view.equip.component.EquipDetailInfoComponent", package.seeall)

local M = class("EquipDetailInfoComponent")
local kAttributeMaxNum = 2

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)
	self._isHideLock = false
	self._btnSuitAttributes = {}
	self._suitColor = "64ddcb"
	self._notSuitColor = "c5c5c5"
end

function M:_initNodeExtra()
	self._btnWear = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self._mainGo, "node/content3/btnWear"), CommButton)
	self._btnExchange = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self._mainGo, "node/content3/btnExchange"), CommButton)
	self._btnIntensify = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self._mainGo, "node/content3/btnWinding"), CommButton)
	self._btnDisboard = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self._mainGo, "node/content3/btnDisboard"), CommButton)
	self._btnDetail = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self._mainGo, "node/content3/btnDetail"), CommButton)
	self._lvMaxGo = self._registry:getGoByPath("node/content3/lvMax")

	goutil.setActive(self._lvMaxGo, false)
	self._btnDisboard:setActive(false)
	self._btnExchange:setActive(false)
	self._btnWear:setActive(false)
	self._btnIntensify:setActive(false)
	self._btnDetail:setActive(false)
end

function M:buildUI()
	self:_initNodeExtra()

	self._btnLock = self._registry:getBtnByPath("node/top/lay/lock/btnLock")
	self._txtEquipName = self._registry:getTextByPath("node/top/txtName")
	self._txtLevel = self._registry:getTextByPath("node/scroll/view/content/content1/lv/txtLevel")
	self._txtSuitName = self._registry:getTextByPath("node/scroll/view/content/suitAttribute/txtNameSuitAttribute")
	self._suitNameImg1Go = goutil.findChild(self._txtSuitName.gameObject, "img1")
	self._suitNameImg2Go = goutil.findChild(self._txtSuitName.gameObject, "img2")
	self._txtSuitNum = self._registry:getTextByPath("node/scroll/view/content/suitAttribute/txtNumSuitAttribute")
	self._txtSuitAttrGo = self._registry:getGoByPath("node/scroll/view/content/suitAttribute/txtDescSuitAttribute")

	goutil.setActive(self._txtSuitAttrGo, false)

	self._txtDesc = self._registry:getTextByPath("node/scroll/view/content/descLayout/txtDesc")

	local suitAniGo = self._registry:getGoByPath("node/scroll/view/content/suitAttribute")

	self._suitContentGo = suitAniGo
	self._suitAni = suitAniGo:GetComponent(ComponentType.Animation)
	self._attributeRootList = {}
	self._attributeTxtList = {}
	self._attrNumTxtList = {}
	self._attrAddNumTxtList = {}

	for i = 1, kAttributeMaxNum do
		local attributeRoot = goutil.findChild(self._mainGo, "node/scroll/view/content/content1/attribute_" .. i)
		local attributeTxt = goutil.findChildTextComponent(attributeRoot, "txtAttribute")
		local attrNumTxt = goutil.findChildTextComponent(attributeRoot, "txtNum")
		local attrAddNumTxt = goutil.findChildTextComponent(attributeRoot, "txtAddNum")

		table.insert(self._attributeRootList, attributeRoot)
		table.insert(self._attributeTxtList, attributeTxt)
		table.insert(self._attrNumTxtList, attrNumTxt)
		table.insert(self._attrAddNumTxtList, attrAddNumTxt)
	end

	self._goRecommend = self._registry:getGoByPath("node/scroll/view/content/objRecommend/txtRecommend")

	goutil.setActive(self._goRecommend, false)

	self._goDiceNode = self._registry:getGoByPath("node/scroll/view/content/objRecommend")
	self._goDiceLayout = self._registry:getGoByPath("node/scroll/view/content/objRecommend/d6AttributeLayout")
	self._goDice = goutil.findChild(self._goDiceLayout, "d6_attribute_item")

	goutil.setActive(self._goDice, false)

	self._diceItemList = {}
	self._imgEquipIcon = self._registry:getImageByPath("node/scroll/view/content/content1/icon")
	self._lockRootGo = self._registry:getGoByPath("node/top/lay/lock")
	self._lock = self._registry:getGoByPath("node/top/lay/lock/Lock")
	self._unlock = self._registry:getGoByPath("node/top/lay/lock/unLock")
	self._headGo = self._registry:getGoByPath("node/top/lay/head")
	self._headIcon = self._registry:getImageByPath("node/top/lay/head/headIcon")
	self._statusGo = self._registry:getGoByPath("node/top/lay")
	self._isShowStatus = true
	self._canShowDice = true
end

function M:destroyUI()
	self._attributeRootList = nil
	self._attributeTxtList = nil
	self._attrNumTxtList = nil
	self._attrAddNumTxtList = nil
end

function M:bindEvents()
	self._btnLock:AddClickListener(self._onClickLock, self)
end

function M:unbindEvents()
	self._btnLock:RemoveClickListener()

	for i = 1, #self._btnSuitAttributes do
		self._btnSuitAttributes[i]:RemoveClickListener()
	end
end

function M:setSuitColor(suitColor, notSuitColor)
	self._suitColor = suitColor
	self._notSuitColor = notSuitColor
end

function M:setEquipData(mo)
	self._equipMo = mo

	self:refreshView()
end

function M:setShowDice(value)
	self._canShowDice = value
end

function M:refreshView()
	if not self._equipMo then
		goutil.setActive(self._mainGo, false)

		return
	end

	goutil.setActive(self._mainGo, true)
	self:_refreshEquip()
	self:_refreshAttrInfo()
	self:_refreshSuitInfo()
	self:refreshStatus()
end

function M:_refreshEquip()
	self._txtEquipName.text = self._equipMo:getName()
	self._txtLevel.text = string.format("<size=48><color=#ffffff>%d</color></size>/%d", self._equipMo:getLevel(), self._equipMo:getMaxLevel())
	self._txtDesc.text = self._equipMo:getItemDesc()

	IconLoader.setSprite(self._imgEquipIcon, IconType.EquipIcon, self._equipMo:getIcon())
end

function M:_refreshAttrInfo()
	local attrList = self._equipMo:getAttrList()

	for i = 1, kAttributeMaxNum do
		goutil.setActive(self._attributeRootList[i], i <= #attrList)

		if i <= #attrList then
			local value = attrList[i]:getValue() > 0 and attrList[i]:getValue() or "?"

			if self._isShowAddValue then
				value = attrList[i]:getSourceValue() > 0 and attrList[i]:getSourceValue() or "?"
			end

			self._attributeTxtList[i].text = attrList[i]:getName()
			self._attrNumTxtList[i].text = value
			self._attrAddNumTxtList[i].text = "+" .. attrList[i]:getEnhancedAddValue()

			local showEnhancedAddValue = self._isShowAddValue and attrList[i]:getEnhancedAddValue() > 0

			goutil.setActive(self._attrAddNumTxtList[i].gameObject, showEnhancedAddValue)
		end
	end

	goutil.setActive(self._goDiceLayout, self._canShowDice)

	local totalNum = self._equipMo:getExtraDiceAttrNum()

	if self._equipMo:hasOriginalD6() then
		totalNum = totalNum + 1
	end

	local enhances = {}
	local diceList = self._equipMo:getAllDiceAttr()
	local unlockLevelList = EquipmentConfig.instance:getConstNumList("DiceAttrUnlockLevels")
	local index = 1

	for i = index, totalNum do
		if not self._diceItemList[i] then
			local d6AttributeItemGo = goutil.clone(self._goDice)

			goutil.addChildToParent(d6AttributeItemGo, self._goDiceLayout)

			local item = Astral.LuaComponentContainer.Add(d6AttributeItemGo, EquipDiceItem)

			self._diceItemList[i] = item
		end

		local diceAttrMO = diceList[i]

		if diceAttrMO then
			self._diceItemList[i]:setData(EquipEnum.DiceStatus.Unlock, diceAttrMO)

			if diceAttrMO:isEnhanced() then
				local enhanceType = diceAttrMO:getEnhanceType()

				if enhances[enhanceType] then
					table.insert(enhances[enhanceType], index)
				else
					enhances[enhanceType] = {
						index
					}
				end
			end
		elseif not self._equipMo:hasOriginalD6() then
			self._diceItemList[i]:setData(EquipEnum.DiceStatus.Lock, diceAttrMO, unlockLevelList[i])
		else
			self._diceItemList[i]:setData(EquipEnum.DiceStatus.Lock, diceAttrMO, unlockLevelList[i - 1])
		end

		self._diceItemList[index]:closeEnhanceAni()
		self._diceItemList[index]:setVisible(true)

		index = index + 1
	end

	for _, v in pairs(enhances) do
		local enhanceNum = #v

		if enhanceNum and enhanceNum > 1 then
			for k, itemIndex in ipairs(v) do
				local itemView = self._diceItemList[itemIndex]

				itemView:playEnhanceAni()
			end
		end
	end

	for i = index, #self._diceItemList do
		self._diceItemList[i]:setVisible(false)
	end

	goutil.setActive(self._goDiceNode, totalNum > 0 and self._canShowDice)
end

function M:_refreshSuitInfo()
	local suitId = self._equipMo:getSuitId()

	if not suitId or suitId == 0 then
		goutil.setActive(self._txtSuitName.gameObject, false)
		goutil.setActive(self._txtSuitNum.gameObject, false)

		return
	end

	goutil.setActive(self._txtSuitName.gameObject, true)
	goutil.setActive(self._txtSuitNum.gameObject, true)

	local num = 0

	if not self._equipMo:getIsEquip() then
		num = 0
	else
		local heroData = self._equipMo:getHeroData()

		if heroData then
			local heroEquipData = heroData:getHeroEquipData()

			num = heroEquipData:getEquipNumBySuitId(suitId)

			if heroEquipData:getAvailableSuitId() then
				self:openSuitAni()
			end
		end
	end

	local suitData = self._equipMo:getSuitData()
	local isSuit = num >= 3
	local color = isSuit and self._suitColor or self._notSuitColor

	self._txtSuitName.text = string.format("<color=#%s>%s</color>", color, suitData:getName())
	self._txtSuitNum.text = string.format("<color=#%s>%d/3</color>", color, num)

	goutil.setActive(self._suitNameImg1Go, isSuit)
	goutil.setActive(self._suitNameImg2Go, not isSuit)
	self:_refreshSuitAttributes(suitData, color)
end

function M:_refreshSuitAttributes(suitData, color)
	for i = 1, #self._btnSuitAttributes do
		self._btnSuitAttributes[i]:RemoveClickListener()
	end

	local trs = self._suitContentGo.transform
	local count = trs.childCount

	for i = count, 1, -1 do
		local child = trs:GetChild(i - 1).gameObject

		if child.name == "txtDescSuitAttribute(Clone)" then
			UnityEngine.GameObject.Destroy(child.gameObject)
		end
	end

	self._btnSuitAttributes = {}

	local suitDescList = suitData:getSuit3DescList(HeroDepotModel.instance:getCurViewPageHeroTags())

	for _, descAttr in ipairs(suitDescList) do
		local itemGo = goutil.clone(self._txtSuitAttrGo)
		local clickGo = goutil.findChild(itemGo, "click")
		local attributeBtn = Astral.ButtonAdapter.Get(clickGo)

		table.insert(self._btnSuitAttributes, attributeBtn)
		itemGo:SetActive(true)

		local txtSuitAttribute = goutil.addComponentOnce(itemGo, UIComponentType.TMPText)

		if txtSuitAttribute then
			txtSuitAttribute.text = string.format("<color=#%s>%s</color>", color, descAttr)
		end

		goutil.addChildToParent(itemGo, self._suitContentGo)
	end

	for i = 1, #self._btnSuitAttributes do
		self._btnSuitAttributes[i]:AddClickListener(function()
			self:_onClickSuitAttribute(i)
		end, self)
	end
end

function M:checkSuitAni()
	if self._equipMo and self._equipMo:getIsEquip() then
		local heroData = self._equipMo:getHeroData()

		if heroData then
			local heroEquipData = heroData:getHeroEquipData()

			if heroEquipData:getAvailableSuitId() then
				self:openSuitAni()
			end
		end
	end
end

function M:openSuitAni()
	self._suitAni:Stop()
end

function M:refreshStatus()
	goutil.setActive(self._statusGo, self._isShowStatus)

	if not self._isShowStatus then
		return
	end

	local isInBackPack = ItemModel.instance:getItemDataByUuid(self._equipMo:getUuid()) ~= nil
	local isShowLock = self._equipMo:getUuid() ~= 0 and not self._isHideLock and isInBackPack

	goutil.setActive(self._lockRootGo, isShowLock)

	local isLock = self._equipMo:getIsLock()

	goutil.setActive(self._lock, isLock)
	goutil.setActive(self._unlock, not isLock)

	local heroHas = false

	if self._equipMo:getIsEquip() then
		local heroId = self._equipMo:getHeroId()
		local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

		if heroMO then
			heroHas = true

			local modelCO = ModelConfig.instance:getModelConfig(heroMO:getModelId())

			IconLoader.setSprite(self._headIcon, IconType.RoleHeadIcon, modelCO.headIconName)
		end
	end

	goutil.setActive(self._headGo, heroHas)
end

function M:_onClickLock()
	local equipId = self._equipMo:getUuid()
	local isLock = self._equipMo:getIsLock()

	if not isLock then
		CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_jiaoshiqisuoding, nil, nil, nil)
		EquipmentAgent.instance:sendEquipLockToggleRequest(equipId)
	else
		CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_jiaoshiqijiesuo, nil, nil, nil)

		local dialog = Dialog.showMessage(lang("tip_sure_unlock"), lang("tip_ask_unlock_equip"))

		dialog:setConfirmListener(function()
			EquipmentAgent.instance:sendEquipLockToggleRequest(equipId)
		end, self)
	end
end

function M:_onClickSuitAttribute(i)
	local suitData = self._equipMo:getSuitData()
	local suitEffect = suitData:getSuitEffect()

	if suitEffect and suitEffect > 0 then
		local skillEnhanceMO = SkillEnhanceMO.New(suitEffect)
		local bindGo = goutil.findChild(self._btnSuitAttributes[i].gameObject, "tipsPosBinding")

		bindGo = bindGo or self._btnSuitAttributes[i].gameObject

		local isPassEvent = true

		ToolTipsMgr.showSkillBuffTagSideTips(skillEnhanceMO, bindGo, isPassEvent)
	end
end

function M:isVisible()
	return self._mainGo.activeSelf
end

function M:setVisible(visible)
	goutil.setActive(self._mainGo, visible)
end

function M:setEquipStatusVisible(visible)
	self._isShowStatus = visible

	goutil.setActive(self._statusGo, visible)
end

function M:setHideLock(isHideLock)
	self._isHideLock = isHideLock
end

function M:setShowAddValue(value)
	self._isShowAddValue = value
end

function M:_trJumpEquipTimingView(index)
	if ViewMgr.instance:isOpen(ViewName.EquipRecycleView) then
		FloatWordMgr.instance:show(lang("tip_equip_recycle_hole_jump"))

		return
	end

	EquipIntensifyModel.instance:setTimingJumpHoleInde(index)
	EquipIntensifyModel.instance:setOperatingEquip(self._equipMo)
	ViewMgr.instance:open(ViewName.EquipIntensifyMainNew)
end

return M

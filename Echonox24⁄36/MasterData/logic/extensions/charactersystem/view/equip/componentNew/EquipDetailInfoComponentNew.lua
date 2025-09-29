-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/componentNew/EquipDetailInfoComponentNew.lua

module("logic.extensions.charactersystem.view.equip.componentNew.EquipDetailInfoComponentNew", package.seeall)

local M = class("EquipDetailInfoComponentNew")
local kAttributeMaxNum = 2

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)
	self._isHideLock = false
	self._blockJumpWhileNoCalibration = false

	self:_buildUI()
end

function M:OnDestroy()
	self:destroyUI()
end

function M:_buildUI()
	self._btnLock = self._registry:getBtn("backpack_equip_detail_tips_copy_1967695515")
	self._btnDisboard = self._registry:getBtn("4&com_btn_2_-31477526")
	self._btnExchange = self._registry:getBtn("0&com_btn_2_-31477526")
	self._btnWear = self._registry:getBtn("1&com_btn_2_-31477526")
	self._btnIntensify = Astral.SimpleLuaComponentContainer.Add(self._registry:getGo("2&btn_right_1251431307"), CommButton)
	self._btnLvUp = self._registry:getBtn("3&btn_middle_-31477526")
	self._txtEquipName = self._registry:getText("backpack_equip_detail_tips_copy_673794678")
	self._txtLevel = self._registry:getText("backpack_equip_detail_tips_copy_1769378791")
	self._txtSuitName = self._registry:getText("backpack_equip_detail_tips_copy_-234148544")
	self._suitNameImg1Go = goutil.findChild(self._txtSuitName.gameObject, "img1")
	self._suitNameImg2Go = goutil.findChild(self._txtSuitName.gameObject, "img2")
	self._txtSuitNum = self._registry:getText("backpack_equip_detail_tips_copy_629227193")
	self._txtSuitAttrGo = self._registry:getGo("backpack_equip_detail_tips_copy_-1939983079")

	goutil.setActive(self._txtSuitAttrGo, false)

	self._btnSuitAttribute = self._registry:getBtn("backpack_equip_detail_tips_copy_311937878")
	self._txtDesc = self._registry:getText("backpack_equip_detail_tips_copy_-184207483")
	self._objRecommend = self._registry:getGo("backpack_equip_detail_tips_copy_-331108247")

	local suitAniGo = self._registry:getGo("backpack_equip_detail_tips_copy_-213986641")

	self._suitContentGo = suitAniGo
	self._suitAni = suitAniGo:GetComponent(ComponentType.Animation)
	self._suitEffectGo = goutil.findChild(suitAniGo, "effect")
	self._suitEffectImg1Go = goutil.findChild(suitAniGo, "Image (1)")
	self._suitEffectImg2Go = goutil.findChild(suitAniGo, "Image (4)")
	self._attributeRootList = {}
	self._attributeTxtList = {}
	self._attrNumTxtList = {}

	for i = 1, kAttributeMaxNum do
		local attributeRoot = goutil.findChild(self._mainGo, "node/scroll/view/content/content1/attribute_" .. i)
		local attributeTxt = goutil.findChildTextComponent(attributeRoot, "txtAttribute")
		local attrNumTxt = goutil.findChildTextComponent(attributeRoot, "txtNum")

		table.insert(self._attributeRootList, attributeRoot)
		table.insert(self._attributeTxtList, attributeTxt)
		table.insert(self._attrNumTxtList, attrNumTxt)
	end

	local d6AttributeLayoutGo = self._registry:getGo("backpack_equip_detail_tips_copy_-771903693")

	self._d6AttrParent = d6AttributeLayoutGo

	local d6AttributeItemTemplate = goutil.findChild(d6AttributeLayoutGo, "d6_attribute_item")

	goutil.setActive(d6AttributeItemTemplate, false)

	self._d6attributeItemViewList = {}

	for index = 1, EquipEnum.MaxDiceCount do
		local d6AttributeItemGo = goutil.clone(d6AttributeItemTemplate)

		goutil.setActive(d6AttributeItemGo, true)
		goutil.addChildToParent(d6AttributeItemGo, d6AttributeLayoutGo)

		local itemView = Astral.LuaComponentContainer.Add(d6AttributeItemGo, EquipTipsD6ItemView)

		table.insert(self._d6attributeItemViewList, itemView)
		itemView:expendAsBotton()
		itemView:setClickCallback(function()
			self:_onClickHole(index)
		end)
	end

	self._d6LineGo = self._registry:getGo("backpack_equip_detail_tips_copy_905317766")
	self._suitLineGo = self._registry:getGo("backpack_equip_detail_tips_copy_407645594")
	self._lvMaxGo = self._registry:getGo("backpack_equip_detail_tips_copy_1524723379")
	self._imgEquipIcon = self._registry:getImage("backpack_equip_detail_tips_copy_1168876333")
	self._lockRootGo = self._registry:getGo("backpack_equip_detail_tips_copy_-1416040178")
	self._lock = self._registry:getGo("backpack_equip_detail_tips_copy_882602538")
	self._unlock = self._registry:getGo("backpack_equip_detail_tips_copy_-153103076")
	self._headGo = self._registry:getGo("backpack_equip_detail_tips_copy_-912076755")
	self._headIcon = self._registry:getImage("backpack_equip_detail_tips_copy_-691117322")
	self._statusGo = self._registry:getGo("backpack_equip_detail_tips_copy_-1286867792")
	self._isShowStatus = true

	goutil.setActive(self._btnDisboard.gameObject, false)
	goutil.setActive(self._btnExchange.gameObject, false)
	goutil.setActive(self._btnWear.gameObject, false)
	self._btnIntensify:setActive(false)
	goutil.setActive(self._btnLvUp.gameObject, false)
	goutil.setActive(self._lvMaxGo, false)
end

function M:destroyUI()
	self:_clearDescSuitAttr()

	self._attributeRootList = nil
	self._attributeTxtList = nil
	self._attrNumTxtList = nil
end

function M:bindEvents()
	self._btnLock:AddClickListener(self._onClickLock, self)
	self._btnSuitAttribute:AddClickListener(self._onClickSuitAttribute, self)
end

function M:unbindEvents()
	self._btnLock:RemoveClickListener()
	self._btnSuitAttribute:RemoveClickListener()
end

function M:setEquipData(mo)
	self._equipMo = mo

	self:refreshView()
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
	local isTimingMax = EquipIntensifyModel.instance:isEquipMaxTimingTimes(self._equipMo)
	local attrList = self._equipMo:getAttrList()

	for i = 1, kAttributeMaxNum do
		goutil.setActive(self._attributeRootList[i], i <= #attrList)

		if i <= #attrList then
			self._attributeTxtList[i].text = attrList[i]:getName()
			self._attrNumTxtList[i].text = attrList[i]:getValue()
		end
	end

	local unlockHoleCount = 0
	local enhances = {}

	for index = 1, EquipEnum.MaxDiceCount do
		local itemView = self._d6attributeItemViewList[index]
		local holeIndex = index - 1
		local diceAttrMo
		local isHoldUnlock = false
		local isOriginHole = false
		local unlockTips = false

		if holeIndex == 0 then
			isHoldUnlock = self._equipMo:hasOriginalD6()

			if isHoldUnlock then
				local originD6 = self._equipMo:getOriginalD6()

				diceAttrMo = originD6:getEffectAttr()
				isOriginHole = true
				unlockHoleCount = unlockHoleCount + 1

				if diceAttrMo:isEnhanced() then
					local enhanceType = diceAttrMo:getEnhanceType()

					enhances[enhanceType] = {
						index
					}
				end
			else
				unlockTips = ""
			end
		else
			isHoldUnlock = self._equipMo:getIsHoleUnlock(holeIndex)

			if isHoldUnlock then
				local fixedD6Mo = self._equipMo:getFixedD6ByHoleIndex(holeIndex)

				if fixedD6Mo then
					diceAttrMo = fixedD6Mo:getEffectAttr()

					if diceAttrMo:isEnhanced() then
						local enhanceType = diceAttrMo:getEnhanceType()

						if enhances[enhanceType] then
							table.insert(enhances[enhanceType], index)
						else
							enhances[enhanceType] = {
								index
							}
						end
					end
				else
					unlockTips = lang("tip_to_be_embedded")
				end
			else
				local list = EquipmentConfig.instance:getConstNumList("DiceOpenLevels")
				local unlockLevel = list[holeIndex]

				unlockTips = unlockLevel > self._equipMo:getMaxLevel() and "" or string.format(lang("tip_s_unlock"), "Lv." .. unlockLevel)
			end
		end

		local status = self._equipMo:getHoleStatus(index)
		local visible = itemView:setVisibleByStatus(status)

		if visible then
			unlockHoleCount = unlockHoleCount + 1

			if diceAttrMo and diceAttrMo:getIsFackAttr() then
				goutil.setActive(self._objRecommend.gameObject, true)
				itemView:setData(diceAttrMo, isOriginHole, unlockTips)
			elseif self._equipMo:getUuid() == 0 then
				itemView:setVisibleByStatus(EquipEnum.HoleStatus.Unknown)
			elseif status == EquipEnum.HoleStatus.NoCalibration and self._blockJumpWhileNoCalibration then
				itemView:setVisibleByStatus(EquipEnum.HoleStatus.Seal)
			else
				local highLightTagIds = HeroDepotModel.instance:getCurViewPageHeroTags()

				itemView:setData(diceAttrMo, isOriginHole, unlockTips, highLightTagIds)
				itemView:setTimingLockingShow(holeIndex == 0 or isTimingMax)
			end

			itemView:closeEnhanceAni()
		end
	end

	for _, v in pairs(enhances) do
		local enhanceNum = #v

		if enhanceNum and enhanceNum > 1 then
			for k, viewind in ipairs(v) do
				local itemView = self._d6attributeItemViewList[viewind]

				itemView:playEnhanceAni(enhanceNum)
			end
		end
	end

	goutil.setActive(self._d6LineGo, unlockHoleCount > 0)
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
	local color = isSuit and "8AD7F0" or "858585"

	self._txtSuitName.text = string.format("<color=#%s>%s</color>", color, suitData:getName())
	self._txtSuitNum.text = string.format("<color=#%s>%d/3</color>", color, num)

	goutil.setActive(self._suitNameImg1Go, isSuit)
	goutil.setActive(self._suitNameImg2Go, not isSuit)
	self:_clearDescSuitAttr()

	local suitDescList = suitData:getSuit3DescList(HeroDepotModel.instance:getCurViewPageHeroTags())

	for _, descAttr in ipairs(suitDescList) do
		local itemGo = goutil.clone(self._txtSuitAttrGo)

		itemGo:SetActive(true)

		local txtSuitAttribute = goutil.addComponentOnce(itemGo, UIComponentType.TMPText)

		if txtSuitAttribute then
			txtSuitAttribute.text = string.format("<color=#%s>%s</color>", color, descAttr)
		end

		local btnClick = UIComponentType.ButtonAdapter(goutil.findChild(itemGo, "click"))

		btnClick:AddClickListener(function()
			self:_onClickSuitAttributeDyn(itemGo)
		end, self)
		goutil.addChildToParent(itemGo, self._suitContentGo)
	end
end

function M:_clearDescSuitAttr()
	local trs = self._suitContentGo.transform
	local count = trs.childCount

	for i = count, 1, -1 do
		local child = trs:GetChild(i - 1).gameObject

		if child.name == "txtDescSuitAttribute(Clone)" then
			local btnClick = UIComponentType.ButtonAdapter(goutil.findChild(child, "click"))

			btnClick:RemoveClickListener()
			UnityEngine.GameObject.Destroy(child.gameObject)
		end
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
	self._suitAni:Play("suit_jihuo")
end

function M:refreshStatus()
	goutil.setActive(self._statusGo, self._isShowStatus)

	if not self._isShowStatus then
		return
	end

	goutil.setActive(self._lockRootGo, self._equipMo:getUuid() ~= 0 and not self._isHideLock)

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

function M:_onClickDiscard()
	local equipId = self._equipMo:getUuid()

	EquipmentAgent.instance:sendEquipDiscardToggleRequest(equipId)
end

function M:_onClickSuitAttribute()
	self:_onClickSuitAttributeDyn(self._btnSuitAttribute.gameObject)
end

function M:_onClickSuitAttributeDyn(bindGo)
	local suitData = self._equipMo:getSuitData()
	local suit3 = suitData:getSuit3()

	if suit3 and suit3 > 0 then
		local skillEnhanceMO = SkillEnhanceMO.New(suit3)
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

function M:setEquipUsing(visible)
	return
end

function M:setBlockJumpWhileNoCalibration(isBlock)
	self._blockJumpWhileNoCalibration = isBlock
end

function M:_onClickHole(index)
	local holeIndex = index - 1

	if not self._equipMo then
		return
	end

	local status = self._equipMo:getHoleStatus(index)

	if status == EquipEnum.HoleStatus.Unalterable or status == EquipEnum.HoleStatus.Unlock then
		local buffCodes, tagCodes = self._d6attributeItemViewList[index]:getBuffsAndTags()

		if buffCodes then
			local bindGo = self._d6attributeItemViewList[index]:getButtonGo()

			ToolTipsMgr.showSkillBuffTagSideTipsWithCodes(buffCodes, tagCodes, bindGo, false)
		end

		return
	end

	if holeIndex < 1 then
		return
	end

	if status == EquipEnum.HoleStatus.NoCalibration and self._blockJumpWhileNoCalibration then
		return
	end

	local visible = self._d6attributeItemViewList[index]:setVisibleByStatus(status)

	if status ~= EquipEnum.HoleStatus.NoCalibration or not visible then
		return
	end

	self:_trJumpEquipTimingView(index)
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

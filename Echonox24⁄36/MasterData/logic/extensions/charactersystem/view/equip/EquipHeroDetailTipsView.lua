-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipHeroDetailTipsView.lua

module("logic.extensions.charactersystem.view.equip.EquipHeroDetailTipsView", package.seeall)

local M = class("EquipHeroDetailTipsView", ViewComponent)

function M:buildUI()
	self._btnLock = Astral.ButtonAdapter.GetFrom(self.mainGO, "universal_second_tips_common_bg/content/btnClose")
	self._btnBg = self:getBtn("1&universal_second_tips_common_bg_-1467035629")

	local propertyListGo = self:getGo("timing_detail_tips_1920160237")

	self._propertyItemList = {}

	for index = 1, EquipEnum.MaxAttrCount do
		local propertyItemGo = goutil.findChild(propertyListGo, "attribute_" .. index)

		table.insert(self._propertyItemList, propertyItemGo)
	end

	local suitListGo = self:getGo("timing_detail_tips_1030498562")

	self._suitListGo = suitListGo
	self._txtSuitTitle = goutil.findChildTextComponent(suitListGo, "txtNameSuitAttribute")
	self._goSuitNum = self:getGo("timing_detail_tips_copy_-129160057")

	goutil.setActive(self._goSuitNum, true)

	self._goSuitDesc = goutil.findChild(suitListGo, "txtDescSuitAttribute")

	goutil.setActive(self._goSuitDesc, false)

	self._goSuitEmpty = goutil.findChild(suitListGo, "txtEmpty")
	self._goDiceLayout = self:getGo("timing_detail_tips_878088631")
	self._goDice = goutil.findChild(self._goDiceLayout, "d6_attribute_item")

	goutil.setActive(self._goDice, false)

	self._diceItemList = {}
	self._btnSuitAttributes = {}
end

function M:bindEvents()
	self._btnLock:AddClickListener(self._onClickClose, self)
	self._btnBg:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnLock:RemoveClickListener()
	self._btnBg:RemoveClickListener()

	for i = 1, #self._btnSuitAttributes do
		self._btnSuitAttributes[i]:RemoveClickListener()
	end
end

function M:onEnter()
	self._equipHeroData = self:getFirstParam()

	if self._equipHeroData then
		self:_refreshEquipAttr()
		self:_refreshSuitAttr()
		self:_refreshDices()
	end
end

function M:onExit()
	return
end

function M:destroyUI()
	return
end

function M:_onClickClose()
	self:close()
end

function M:_refreshEquipAttr()
	local attrList = self._equipHeroData:getAllEquipAttr()

	for index = 1, EquipEnum.MaxAttrCount do
		local propertyItemGo = self._propertyItemList[index]

		if attrList[index] then
			propertyItemGo:SetActive(true)

			goutil.findChildTextComponent(propertyItemGo, "Text1").text = attrList[index].name
			goutil.findChildTextComponent(propertyItemGo, "Text2").text = attrList[index].num
		else
			propertyItemGo:SetActive(false)
		end
	end
end

function M:_refreshSuitAttr()
	local suitId = self._equipHeroData:getAvailableSuitId()

	if suitId then
		local suitData = EquipSuitModel.instance:getSuitDataById(suitId)

		self._txtSuitTitle.text = suitData:getName()

		local trs = self._suitListGo.transform
		local count = trs.childCount

		for i = count, 1, -1 do
			local child = trs:GetChild(i - 1).gameObject

			if child.name == "txtDescSuitAttribute(Clone)" then
				UnityEngine.GameObject.Destroy(child.gameObject)
			end
		end

		for i = 1, #self._btnSuitAttributes do
			self._btnSuitAttributes[i]:RemoveClickListener()
		end

		self._btnSuitAttributes = {}

		local suitDescList = suitData:getSuit3DescList()

		for _, descAttr in ipairs(suitDescList) do
			local itemGo = goutil.clone(self._goSuitDesc)

			itemGo:SetActive(true)

			local txtSuitAttribute = goutil.addComponentOnce(itemGo, UIComponentType.TMPText)

			if txtSuitAttribute then
				txtSuitAttribute.text = descAttr
			end

			local clickGo = goutil.findChild(itemGo, "click")
			local attributeBtn = Astral.ButtonAdapter.Get(clickGo)

			table.insert(self._btnSuitAttributes, attributeBtn)
			goutil.addChildToParent(itemGo, self._suitListGo)
		end

		for i = 1, #self._btnSuitAttributes do
			self._btnSuitAttributes[i]:AddClickListener(function()
				self:_onClickSuitAttribute(i)
			end, self)
		end

		goutil.setActive(self._goSuitEmpty, false)
		goutil.setActive(self._txtSuitTitle.gameObject, true)
	else
		goutil.setActive(self._goSuitEmpty, true)
		goutil.setActive(self._txtSuitTitle.gameObject, false)
	end
end

function M:_refreshDices()
	local attrList = self._equipHeroData:getAllDicesAttr()
	local index = 1

	for i = index, #attrList do
		if not self._diceItemList[i] then
			local d6AttributeItemGo = goutil.clone(self._goDice)

			goutil.addChildToParent(d6AttributeItemGo, self._goDiceLayout)

			local item = Astral.LuaComponentContainer.Add(d6AttributeItemGo, EquipDiceItem)

			self._diceItemList[i] = item
		end

		local diceAttrMO = attrList[i]

		self._diceItemList[i]:setData(EquipEnum.DiceStatus.Unlock, diceAttrMO)
		self._diceItemList[index]:setVisible(true)

		index = index + 1
	end

	for i = index, #self._diceItemList do
		self._diceItemList[i]:setVisible(false)
	end
end

function M:_onClickSuitAttribute(i)
	local suitId = self._equipHeroData:getAvailableSuitId()

	if not suitId then
		return
	end

	local suitData = EquipSuitModel.instance:getSuitDataById(suitId)
	local suitEffect = suitData:getSuitEffect()

	if suitEffect and suitEffect > 0 then
		local skillEnhanceMO = SkillEnhanceMO.New(suitEffect)
		local bindGo = self._btnSuitAttributes[i].gameObject
		local isPassEvent = true

		ToolTipsMgr.showSkillBuffTagSideTips(skillEnhanceMO, bindGo, isPassEvent)
	end
end

return M

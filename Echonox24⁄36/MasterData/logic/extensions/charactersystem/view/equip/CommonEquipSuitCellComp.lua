-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/CommonEquipSuitCellComp.lua

module("logic.extensions.charactersystem.view.equip.CommonEquipSuitCellComp", package.seeall)

local M = class("CommonEquipSuitCellComp", CellBaseComponent)

function M:ctor(cell)
	M.super.ctor(self, cell)

	self._registry = self._cell:getViewElementsRegistry()
end

function M:onInit()
	self._btnNormal = self._registry:getBtn("backpack_suit_filter_tab_1380124373")
	self._btnSelect = self._registry:getBtn("backpack_suit_filter_tab_499998186")
	self._btnSpecial = self._registry:getBtn("backpack_suit_filter_tab_263985336")
	self._txtSuitName = self._registry:getText("backpack_suit_filter_tab_478025835")
	self._txtPart1Num = self._registry:getText("backpack_suit_filter_tab_1004266906")
	self._txtPart2Num = self._registry:getText("backpack_suit_filter_tab_1560724621")
	self._txtPart3Num = self._registry:getText("backpack_suit_filter_tab_1282695750")

	self._btnNormal:AddClickListener(self._onClickNormal, self)
	self._btnSelect:AddClickListener(self._onClickSelect, self)
	self._btnSpecial:AddClickListener(self._onClickSpecial, self)
end

function M:onDestroy()
	M.super.onDestroy(self)
	self._btnNormal:RemoveClickListener()
	self._btnSelect:RemoveClickListener()
	self._btnSpecial:RemoveClickListener()
end

function M:updateData(data)
	self._suitData = data

	local totalNum = self._suitData:getPartNum()

	self._txtSuitName.text = self._suitData:getName()
	self._txtPart1Num.text = totalNum[1] or 0
	self._txtPart2Num.text = totalNum[2] or 0
	self._txtPart3Num.text = totalNum[3] or 0
end

function M:setSpecial(isSpecail)
	self._btnSpecial.gameObject:SetActive(isSpecail)

	if isSpecail then
		self:_setColor("#313131")
	else
		self:_setColor("#858585")
	end
end

function M:_onClickNormal()
	GlobalDispatcher:dispatchEvent(EventType.Equip_SUIT_FILTER_EVENT, self._suitData:getId())
end

function M:_onClickSelect()
	return
end

function M:_onClickSpecial()
	return
end

function M:_setColor(color)
	local txtSuit = {
		self._txtSuitName,
		self._txtPart1Num,
		self._txtPart2Num,
		self._txtPart3Num
	}

	for i = 1, 4 do
		TextUtils.SetColor(txtSuit[i], color)
	end
end

function M:setSelect(isSelected)
	self._btnNormal.gameObject:SetActive(not isSelected)
	self._btnSelect.gameObject:SetActive(isSelected)

	if isSelected then
		self:_setColor("#DADADA")
	end
end

return M

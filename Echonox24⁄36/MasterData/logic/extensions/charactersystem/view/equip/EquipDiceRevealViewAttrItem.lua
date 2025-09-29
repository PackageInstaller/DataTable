-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipDiceRevealViewAttrItem.lua

module("logic.extensions.charactersystem.view.equip.EquipDiceRevealViewAttrItem", package.seeall)

local M = class("EquipDiceRevealViewAttrItem")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()

	self._data = nil
end

function M:_buildUI()
	self._txtAttributeName = goutil.findChildComponent(self._mainGo, "txtAttr/Text", UIComponentType.Text)
	self._txtAttribute = goutil.findChildComponent(self._mainGo, "txtAttr", UIComponentType.Text)
	self._txtAddNum = goutil.findChildComponent(self._mainGo, "txtAddNum", UIComponentType.Text)
	self._txtAddNum2 = goutil.findChildComponent(self._mainGo, "txtAddNum2", UIComponentType.Text)
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:setData(equipAttrNoNew, equipAttrNoOld)
	self._txtAttributeName.text = equipAttrNoNew:getName()
	self._txtAttribute.text = equipAttrNoNew:getSourceValue()

	local newAdd = equipAttrNoNew:getEnhancedAddValue()
	local oldAdd = equipAttrNoOld:getEnhancedAddValue()
	local hadOldAdd = equipAttrNoOld:getEnhancedAddValue() > 0

	goutil.setActive(self._txtAddNum.gameObject, hadOldAdd)

	self._txtAddNum.text = "+" .. oldAdd

	local hadNewAdd = newAdd - oldAdd > 0

	goutil.setActive(self._txtAddNum2.gameObject, hadNewAdd)

	self._txtAddNum2.text = "+" .. newAdd
end

function M:setVisible(visible)
	self._mainGo:SetActive(visible)
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	return
end

return M

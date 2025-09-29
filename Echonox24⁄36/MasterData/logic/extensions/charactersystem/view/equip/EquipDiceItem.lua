-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipDiceItem.lua

module("logic.extensions.charactersystem.view.equip.EquipDiceItem", package.seeall)

local M = class("EquipDiceItem")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()

	self._data = nil
end

function M:_buildUI()
	self._txtAttribute = goutil.findChildComponent(self._mainGo, "txtD6Attribute", UIComponentType.TextMeshProUGUI)
	self._groupAttribute = self._txtAttribute.gameObject:GetComponent(ComponentType.CanvasGroup)

	local equipHoleItemGo = goutil.findChild(self._mainGo, "equip_hole_item")

	self._equipDiceIconItem = Astral.LuaComponentContainer.Add(equipHoleItemGo, EquipDiceIconItem)
	self._goImgDi = goutil.findChild(self._mainGo, "imgDi")
	self._btnClick = Astral.ButtonAdapter.Get(goutil.findChild(self._mainGo, "click"))

	self._btnClick:AddClickListener(self._onClick, self)

	self._canvasGroup = self._mainGo:GetComponent(ComponentType.CanvasGroup)
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:setData(diceStatus, diceAttrMo, unlockLevel)
	self._data = diceAttrMo

	if diceAttrMo then
		if diceAttrMo:getFackRecommedD6() ~= nil then
			self._equipDiceIconItem:setStatus(EquipEnum.DiceStatus.CanUnLock)

			self._txtAttribute.text = diceAttrMo:getDesc()
			self._groupAttribute.alpha = 1

			return
		elseif diceAttrMo:getValue() == 0 then
			self._equipDiceIconItem:setStatus(EquipEnum.DiceStatus.CanUnLock)

			self._txtAttribute.text = "?????"
			self._groupAttribute.alpha = 1

			return
		end
	end

	self._diceStatus = diceStatus

	self._equipDiceIconItem:setStatus(diceStatus)
	goutil.setActive(self._goImgDi, diceStatus == EquipEnum.DiceStatus.CanUnLock)

	if diceStatus == EquipEnum.DiceStatus.Lock and unlockLevel then
		self._txtAttribute.text = langF("tip_equip_unlock_dice", unlockLevel)
		self._groupAttribute.alpha = 0.2

		return
	elseif diceStatus == EquipEnum.DiceStatus.CanUnLock then
		self._txtAttribute.text = lang("tip_euqip_dice_unlock")
		self._groupAttribute.alpha = 1

		return
	end

	self._groupAttribute.alpha = 1
	self._txtAttribute.text = diceAttrMo:getDesc()

	self._equipDiceIconItem:setData(diceAttrMo)
end

function M:getData()
	return self._data
end

function M:setVisible(visible)
	self._mainGo:SetActive(visible)
end

function M:closeEnhanceAni()
	self._equipDiceIconItem:closeEnhanceAni()
end

function M:playEnhanceAni()
	self._equipDiceIconItem:playEnhanceAni()
end

function M:_onClick()
	if self._diceStatus ~= EquipEnum.DiceStatus.Unlock or not self._data then
		return
	end

	local buffCodes, tagCodes = self._data:getBuffsAndTags()

	if buffCodes then
		ToolTipsMgr.showSkillBuffTagSideTipsWithCodes(buffCodes, tagCodes, self._btnClick.gameObject, false)
	end
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self._equipDiceIconItem = nil

	self._btnClick:RemoveClickListener()
end

function M:setAlpha(value)
	if self._canvasGroup then
		self._canvasGroup.alpha = value
	end
end

return M

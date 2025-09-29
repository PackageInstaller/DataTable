-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/component/D6AttrComponentItem.lua

module("logic.extensions.charactersystem.view.equip.component.D6AttrComponentItem", package.seeall)

local M = class("D6AttrComponentItem")
local offsetX = 21

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._posX = Astral.TransformUtil.GetLocalPosX(self._mainGo.gameObject.transform)

	self:_buildUI()

	self._data = nil
end

function M:_buildUI()
	self._currentGo = goutil.findChild(self._mainGo, "unlock/current")

	goutil.setActive(self._currentGo, false)

	self._txtD6Attribute = goutil.findChildComponent(self._mainGo, "unlock/txtD6Attribute", UIComponentType.TMPText)

	local equipHoleItemGo = goutil.findChild(self._mainGo, "equip_hole_item")

	self._equipHoleItemView = Astral.LuaComponentContainer.Add(equipHoleItemGo, EquipHoleItemView)
	self._goDice = goutil.findChild(self._mainGo, "dice")

	goutil.setActive(self._goDice, true)

	self._btnClick = UIComponentType.ButtonAdapter(self._mainGo)

	self._btnClick:AddClickListener(self._onClickBtnClick, self)
end

function M:OnDestroy()
	self._btnClick:RemoveClickListener()
end

function M:_onClickBtnClick()
	if self._data then
		local buffCodes, tagCodes = self._data:getBuffsAndTags()

		if buffCodes then
			ToolTipsMgr.showSkillBuffTagSideTipsWithCodes(buffCodes, tagCodes, self._mainGo, false)
		end
	end
end

function M:setData(diceAttrMo)
	self._data = diceAttrMo
	self._txtD6Attribute.text = diceAttrMo:getDesc()

	self._equipHoleItemView:setData(diceAttrMo)
end

function M:setSourceData(diceAttrMo)
	self._data = diceAttrMo
	self._txtD6Attribute.text = diceAttrMo:getSourceDesc()

	self._equipHoleItemView:setData(diceAttrMo)
end

function M:setCurrentGoVisible(visible)
	goutil.setActive(self._currentGo, visible)
end

function M:setTimingIndex(showIndex)
	for index = 1, EquipEnum.MaxD6AttrHoleCount do
		local indexGo = goutil.findChild(self._goDice, tostring(index))

		goutil.setActive(indexGo, index == showIndex)
	end
end

function M:setFaceVisible(visible)
	goutil.setActive(self._goDice, visible)
end

return M

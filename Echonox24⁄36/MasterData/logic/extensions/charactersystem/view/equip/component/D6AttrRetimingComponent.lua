-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/component/D6AttrRetimingComponent.lua

module("logic.extensions.charactersystem.view.equip.component.D6AttrRetimingComponent", package.seeall)

local M = class("D6AttrRetimingComponent", D6AttrTimingComponent)

function M:_buildUI()
	M.super._buildUI(self)
	goutil.setActive(goutil.findChild(self._consumeInfoGo, "price1"), true)
end

function M:refreshView()
	M.super.refreshView(self)

	if self._mo then
		local effectFace = self._mo:getEffectFace()

		for index = 1, EquipEnum.MaxD6AttrHoleCount do
			self._d6attributeItemViewList[index]:setCurrentGoVisible(effectFace == index)
		end
	end
end

function M:refreshLockAndDiscard()
	goutil.setActive(self._lockGo, false)
	goutil.setActive(self._discardGo, false)
end

function M:_refreshConsumeItemsInfo()
	self._isMax = EquipIntensifyModel.instance:isMaxTimingTimes()

	goutil.setActive(self._timingBtnMask, self._isMax)
	goutil.setActive(self._consumeInfoGo, not self._isMax)

	local itemHas = ItemModel.instance:getItemCountByItemId(self._itemIdConsume)
	local goldHas = ItemModel.instance:getItemCountByItemId(self._currencyId)
	local itemNeed, goldNeed = EquipIntensifyModel.instance:getRetimingConsumeInfo()

	if not itemNeed then
		printError("调校信息获取失败，请检查")

		self._canTiming = false

		return
	end

	self:setText(self._txtConsume1, itemNeed, itemHas)
	self:setText(self._txtConsume2, goldNeed, goldHas)

	self._canTiming = itemNeed <= itemHas and goldNeed <= goldHas
	self._isItemEnough = itemNeed <= itemHas
	self._isCurrenyEnough = goldNeed <= goldHas

	goutil.setActive(self._timingBtnMask, not self._canTiming)
end

function M:_onClickTimingBtn()
	if self._isMax then
		FloatWordMgr.instance:show(lang("tip_equip_timing_times_less"))

		return
	end

	if not self._canTiming then
		FloatWordMgr.instance:show(lang("tip_equip_timing_item_less"))
		self:_showItemTips(not self._isCurrenyEnough, not self._isItemEnough)

		return
	end

	EquipIntensifyModel.instance:backupsEquip()

	local equipUuid = EquipIntensifyModel.instance:getOperatingEquip():getUuid()
	local effectIndex = EquipIntensifyModel.instance:getTimingHoleIndex()

	EquipmentAgent.instance:sendDiceReRollRequest(equipUuid, effectIndex)
end

return M

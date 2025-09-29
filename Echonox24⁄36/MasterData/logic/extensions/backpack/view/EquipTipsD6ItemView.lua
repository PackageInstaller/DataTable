-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/EquipTipsD6ItemView.lua

module("logic.extensions.backpack.view.EquipTipsD6ItemView", package.seeall)

local M = class("EquipTipsD6ItemView", D6AttrItemView)

function M:ctor(...)
	M.super.ctor(self, ...)

	self._holeIndex = nil
end

function M:setData(diceAttrMo, isOriginHole, unlockTips, highLightTagIds)
	self._data = diceAttrMo

	if diceAttrMo then
		self._txtD6AttributeUnlock.text = diceAttrMo:getDesc(highLightTagIds)

		if isOriginHole then
			self._txtD6AttrOrigin.text = diceAttrMo:getDesc(highLightTagIds)
		end
	end

	self._equipHoleItemView:setData(diceAttrMo)
	self._equipHoleItemView:showGuang(false)

	if unlockTips then
		self._txtD6AttributeLock.text = unlockTips
	end
end

function M:getBuffsAndTags()
	if self._data then
		return self._data:getBuffsAndTags()
	end
end

function M:setVisibleByStatus(status)
	local visible = status == EquipEnum.HoleStatus.Unknown or status == EquipEnum.HoleStatus.Unlock or status == EquipEnum.HoleStatus.Unalterable or status == EquipEnum.HoleStatus.NoCalibration

	self:setVisible(visible)

	if visible then
		self:setStatus(status)
	end

	return visible
end

function M:setStatus(status)
	for i = 1, 6 do
		self._statusGo[i]:SetActive(false)
	end

	goutil.setActive(self._statusGo[status], true)
	self._equipHoleItemView:setVisibleOnTipsUIByStatus(status)
end

return M

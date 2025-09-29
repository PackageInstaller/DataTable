-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsUseBtnComp.lua

module("logic.extensions.tooltips.component.ToolTipsUseBtnComp", package.seeall)

local M = class("ToolTipsUseBtnComp", ViewComponent)

function M:buildUI()
	return
end

function M:destroyUI()
	return
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	local info = self:getFirstParam()

	self._itemData = info.baseData

	goutil.setActive(self._btnUse.gameObject, info.btnStatus)
end

function M:_showInfo()
	return
end

function M:_onClickUseBtn()
	if self._itemData:getType() == GameEnum.ItemTypeEnum.HeroItemType then
		if self._itemData:getUuid() == 0 then
			FloatWordMgr.instance:show("当前没有碎片可合成")
		else
			GlobalDispatcher:dispatchEvent(EventType.ITEM_USE_EVENT, {
				uuid = self._itemData:getUuid(),
				type = self._itemData:getType(),
				subType = self._itemData:getSubType(),
				itemId = self._itemData:getItemId(),
				count = self._itemData:getCount()
			})
		end
	end
end

function M:onExit()
	return
end

return M

-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipIntencifyMoneyView.lua

module("logic.extensions.charactersystem.view.equip.EquipIntencifyMoneyView", package.seeall)

local M = class("EquipIntencifyMoneyView", MoneyView)

function M:ctor()
	M.super.ctor(self, CommEnum.MoneyShowType.EquipIntensify)
end

function M:bindEvents()
	M.super.bindEvents(self)

	if self._btnResolve then
		-- block empty
	end
end

function M:unbindEvents()
	M.super.unbindEvents(self)

	if self._btnResolve then
		-- block empty
	end
end

function M:_updateValue()
	M.super._updateValue(self)

	local str = MoneyModel.instance:getMoneyUpdateParams(1100014)

	self._txtlingbujian.text = TextFormatter.formatNumber(tonumber(str))
end

function M:_createMoneyItem(codesDefine)
	M.super._createMoneyItem(self, codesDefine)

	local trs = self._topCurrencyGo.transform

	if not self._resolveTrs then
		self._resolveTrs = trs:Find("btnDecompose")
		self._btnResolve = Astral.ButtonAdapter.GetFrom(self._topCurrencyGo, "btnDecompose")
		self._txtlingbujian = goutil.findChildTextComponent(self._topCurrencyGo, "btnDecompose/txtNum")

		goutil.setActive(self._btnResolve.gameObject, false)
	end

	local count = trs.childCount

	self._resolveTrs:SetSiblingIndex(count - 1)
end

function M:_onClickResolve()
	ViewMgr.instance:open(ViewName.EquipRecycleView)
end

return M

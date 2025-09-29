-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/BackpackOperateComponent.lua

module("logic.extensions.backpack.cellcomponent.BackpackOperateComponent", package.seeall)

local M = class("BackpackOperateComponent", CellBaseComponent)

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._imgOperateGo = registry:findUIElement("backpack_item_-797852549")

	self._imgOperateGo:SetActive(true)

	self._imgSelectGoLong = registry:findUIElement("backpack_item_-2022575790")
	self._imgSelectGoShort = registry:findUIElement("backpack_item_506657149")
	self._btnCutGo = registry:findUIElement("backpack_item_1909369422")

	self._btnCutGo:SetActive(false)

	self._countGo = registry:findUIElement("backpack_item_-52784526")

	self._countGo:SetActive(false)

	self._txtCount = registry:findUIElement("backpack_item_446669952", UIComponentType.Text)
	self._btnCut = Astral.ButtonAdapter.Get(self._btnCutGo)

	self._btnCut:AddClickListener(self._onClickBtnCut, self)
end

function M:_onClickBtnCut()
	self._cell:unSelect()
end

function M:setImgOperateGoVisible(visible)
	self._imgOperateGo:SetActive(visible)
end

function M:setImgSelectLongVisible(visible)
	self._imgSelectGoLong:SetActive(visible)
end

function M:setImgSelectShortVisible(visible)
	self._imgSelectGoShort:SetActive(visible)
end

function M:setBtnCutGoVisible(visible)
	self._btnCutGo:SetActive(visible)
end

function M:setCountGoVisible(visible)
	self._countGo:SetActive(false)
end

function M:setCount(count)
	self._txtCount.text = count
end

function M:onDestroy()
	M.super.onDestroy(self)
	self._btnCut:RemoveClickListener()
end

return M

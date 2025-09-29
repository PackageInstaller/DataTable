-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/LongClickComponent.lua

module("logic.extensions.backpack.cellcomponent.LongClickComponent", package.seeall)

local M = class("LongClickComponent", CellBaseComponent)

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()
	local imgOperate = registry:findUIElement("backpack_item_-797852549", UIComponentType.Image)

	imgOperate.raycastTarget = true
	self._imgOperateGo = imgOperate.gameObject

	self._imgOperateGo:SetActive(true)

	self._btnCutMoreGo = goutil.findChild(self._imgOperateGo, "btnCutMore").gameObject

	goutil.setActive(self._btnCutMoreGo.gameObject, false)

	self._btnCutGo = registry:findUIElement("backpack_item_1909369422")

	self._btnCutGo:SetActive(false)

	self._countGo = registry:findUIElement("backpack_item_-52784526")

	self._countGo:SetActive(false)

	self._txtCount = registry:findUIElement("backpack_item_446669952", UIComponentType.Text)

	local longPressTriggerCfg = {
		0.6,
		0.2,
		0.01
	}

	self._clickHandler = Handler.New()
	self._btnLongClick = Astral.UILongPressTrigger.Get(self._imgOperateGo.gameObject)

	self._btnLongClick:SetTriggerTime(longPressTriggerCfg)
	self._btnLongClick:AddLongPressListener(self._onLongPressAdd, self, nil)

	self._cutHandler = Handler.New()
	self._btnCut = Astral.UILongPressTrigger.Get(self._btnCutGo)

	self._btnCut:SetTriggerTime(longPressTriggerCfg)
	self._btnCut:AddLongPressListener(self._onLongPressCut, self, nil)

	self._btnCutMore = Astral.UILongPressTrigger.Get(self._btnCutMoreGo)

	self._btnCutMore:SetTriggerTime(longPressTriggerCfg)
	self._btnCutMore:AddLongPressListener(self._onLongPressCut, self, nil)
end

function M:setBlock(block)
	self._block = block
end

function M:setAddCallback(callback, target)
	self._clickHandler:setListener(callback, target)
end

function M:setReduceCallback(callback, target)
	self._cutHandler:setListener(callback, target)
end

function M:_onLongPressAdd()
	self:_triggerAdd()
end

function M:_onLongPressCut()
	self:_triggerReduce()
end

function M:_triggerAdd()
	if self._block then
		return
	end

	if self._clickHandler:hadCallback() then
		self._clickHandler:call(self._cell)
	end
end

function M:_triggerReduce()
	if self._block then
		return
	end

	if self._cutHandler:hadCallback() then
		self._cutHandler:call(self._cell)
	end
end

function M:setImgOperateGoVisible(visible)
	self._imgOperateGo:SetActive(visible)
end

function M:setBtnCutGoVisible(visible)
	self._btnCutGo:SetActive(visible)
end

function M:setBtnCutMoreGoVisible(visible)
	goutil.setActive(self._btnCutMoreGo.gameObject, visible)
end

function M:setCountGoVisible(visible)
	self._countGo:SetActive(visible)
end

function M:setCount(count)
	self._txtCount.text = count
end

function M:onDestroy()
	M.super.onDestroy(self)
	self._btnLongClick:RemoveLongPressListener()
	self._btnCut:RemoveLongPressListener()
	self._btnCutMore:RemoveLongPressListener()
	self._clickHandler:clear()
	self._cutHandler:clear()

	self._clickHandler = nil
	self._cutHandler = nil
end

return M

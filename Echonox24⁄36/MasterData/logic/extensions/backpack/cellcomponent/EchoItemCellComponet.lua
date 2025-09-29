-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/EchoItemCellComponet.lua

module("logic.extensions.backpack.cellcomponent.EchoItemCellComponet", package.seeall)

local M = class("EchoItemCellComponet", CellBaseComponent)

function M:ctor(cell)
	M.super.ctor(self, cell)
end

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()
	local inEquipmentGo = registry:findUIElement("backpack_item_-1719482002")

	self._inEquipmentGo = inEquipmentGo
	self._inEquipBgGo = goutil.findChild(inEquipmentGo, "Image1")
	self._inEquipTextGo = goutil.findChild(inEquipmentGo, "Text")
	self._btnMultipleChoice = registry:findUIElement("backpack_item_-1634450591")
	self._btnCutGo = registry:findUIElement("backpack_item_1909369422")
	self._headGo = goutil.findChild(inEquipmentGo, "head")
	self._headIcon = registry:findUIElement("backpack_item_537430731")
	self._lockGo = registry:findUIElement("backpack_item_962705275")
	self._discardGo = registry:findUIElement("backpack_item_2012755664")

	self._inEquipmentGo:SetActive(true)
	self._inEquipBgGo:SetActive(false)
	self._inEquipTextGo:SetActive(false)
	self._btnMultipleChoice:SetActive(false)
	self._btnCutGo:SetActive(false)
	self._headGo:SetActive(false)
	self._headIcon:SetActive(false)
end

function M:updateData(echoItemData)
	self._echoItemData = echoItemData

	local curHeroEchoItem = EchoItemController.instance:getCurHeroEchoItem()
	local heroId = echoItemData:getHeroId()
	local visible = curHeroEchoItem and curHeroEchoItem == echoItemData
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if heroId > 0 and heroMO then
		self._headGo:SetActive(true)
		self._headIcon:SetActive(true)

		local modelCO = ModelConfig.instance:getModelConfig(heroMO:getModelId())

		IconLoader.setSprite(self._headIcon, IconType.RoleHeadIcon, modelCO.headIconName)
		goutil.setActive(self._lockGo, false)
	else
		self._headGo:SetActive(false)
		self._headIcon:SetActive(false)
		goutil.setActive(self._lockGo, self._echoItemData:getIsLock())
	end
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._echoItemData = nil
end

return M

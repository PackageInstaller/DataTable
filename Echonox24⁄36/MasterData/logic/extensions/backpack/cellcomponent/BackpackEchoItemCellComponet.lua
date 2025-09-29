-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/BackpackEchoItemCellComponet.lua

module("logic.extensions.backpack.cellcomponent.BackpackEchoItemCellComponet", package.seeall)

local M = class("BackpackEchoItemCellComponet", EchoItemCellComponet)

function M:ctor(cell)
	M.super.ctor(self, cell)
end

function M:onInit()
	M.super.onInit(self)

	self._cutBtn = Astral.ButtonAdapter.Get(self._btnCutGo)

	self._cutBtn:AddClickListener(self._onClickCutBtn, self)
end

function M:setCutGoVisible(visible)
	self._btnCutGo:SetActive(visible)
end

function M:_onClickCutBtn()
	self._cell:unSelect()
end

function M:updateData(echoItemData)
	self._echoItemData = echoItemData

	local heroId = 0

	if echoItemData:getType() == GameEnum.ItemTypeEnum.EchoItemType then
		heroId = echoItemData:getHeroId()
	end

	local visible = heroId > 0

	self._inEquipBgGo:SetActive(false)
	self._inEquipTextGo:SetActive(false)

	self._isEquiped = false

	local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if visible and heroMO then
		local modelCO = ModelConfig.instance:getModelConfig(heroMO:getModelId())

		IconLoader.setSprite(self._headIcon, IconType.RoleHeadIcon, modelCO.headIconName)

		self._isEquiped = true
	end

	self:updateEchoStatus()
end

function M:onDestroy()
	M.super.onDestroy(self)
	self._cutBtn:RemoveClickListener()
end

function M:updateEchoStatus()
	self._headGo:SetActive(self._isEquiped)
	self._headIcon:SetActive(self._isEquiped)

	local showLocked = not self._isEquiped and self._echoItemData:getIsLock()

	goutil.setActive(self._lockGo, showLocked)
end

return M

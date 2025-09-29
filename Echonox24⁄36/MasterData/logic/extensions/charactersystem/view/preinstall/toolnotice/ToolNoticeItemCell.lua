-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preinstall/toolnotice/ToolNoticeItemCell.lua

module("logic.extensions.charactersystem.view.preinstall.toolnotice.ToolNoticeItemCell", package.seeall)

local M = class("ToolNoticeItemCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
end

function M:getMainGo()
	return self.mainGO
end

function M:buildUI()
	local mainGO = self:getMainGo()

	self._txtPreinstallName = goutil.findChildTextComponent(mainGO, "txtName")
	self._headIcon = goutil.findChildImageComponent(mainGO, "txtName/head/headIcon")
	self._goItem_1 = goutil.findChild(mainGO, "backpack_item1").gameObject
	self._goItem_2 = goutil.findChild(mainGO, "backpack_item2").gameObject
	self._goItem_3 = goutil.findChild(mainGO, "backpack_item3").gameObject
	self._goItem_4 = goutil.findChild(mainGO, "backpack_item4").gameObject
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:updateData(ItemMo)
	goutil.setActive(self._goItem_1, false)
	goutil.setActive(self._goItem_2, false)
	goutil.setActive(self._goItem_3, false)
	goutil.setActive(self._goItem_4, false)

	self._txtPreinstallName.text = ItemMo:getName()

	local heroId = ItemMo:getHeroId()
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if heroMO then
		local modelCO = ModelConfig.instance:getModelConfig(heroMO:getModelId())

		IconLoader.setSprite(self._headIcon, IconType.RoleHeadIcon, modelCO.headIconName)
	end

	local dataList = ItemMo:getCellDataList()

	for k, v in pairs(dataList) do
		if k == 1 then
			self:setItemData(self._goItem_1, v)
		elseif k == 2 then
			self:setItemData(self._goItem_2, v)
		elseif k == 3 then
			self:setItemData(self._goItem_3, v)
		elseif k == 4 then
			self:setItemData(self._goItem_4, v)
		end
	end
end

function M:setItemData(obj, v)
	local item = Astral.LuaComponentContainer.Add(obj, ItemCell)

	item:Awake()
	item:setShowSelectedEffect(false)
	item:updateData(v)
	item:setIsHideLock(true)
	goutil.setActive(obj.gameObject, true)
end

return M

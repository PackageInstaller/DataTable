-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipDiceIconSimplifyItem.lua

module("logic.extensions.charactersystem.view.equip.EquipDiceIconSimplifyItem", package.seeall)

local M = class("EquipDiceIconSimplifyItem")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:Awake()
	self:buildUI()
end

function M:OnDestroy()
	self:destroyUI()
end

function M:buildUI()
	self._imgIconBg = goutil.findChildImageComponent(self.mainGO, "iconBg")
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "iconBg/icon")
end

function M:destroyUI()
	self.mainGO = nil
end

function M:setActive(value)
	goutil.setActive(self.mainGO, value)
end

function M:updateIcon(diceAttMo)
	if not diceAttMo then
		return
	end

	local iconName = string.format("citiaogroup_%d", diceAttMo:getEnhanceType())

	if iconName ~= self._iconBgName then
		self._iconBgName = iconName

		IconLoader.setSprite(self._imgIconBg, IconType.EquipDiceIcon, iconName)
	end

	iconName = diceAttMo:getIcon()

	if iconName ~= self._iconName then
		self._iconName = iconName

		IconLoader.setSprite(self._imgIcon, IconType.EquipDiceIcon, diceAttMo:getIcon())
	end
end

return M

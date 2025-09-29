-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uilib/UIBattleSanityGroup.lua

module("logic.battle.uilib.UIBattleSanityGroup", package.seeall)

local UIBattleSanityGroup = class("UIBattleSanityGroup")

function UIBattleSanityGroup:ctor(mainGO)
	self.mainGO = mainGO

	self:buildUI()
end

function UIBattleSanityGroup:destroy()
	self:destroyUI()

	self.mainGO = nil
end

function UIBattleSanityGroup:buildUI()
	self._iconList = {}

	for i = 1, BattleConst.MAX_SANITY do
		self._iconList[i] = goutil.findChildImageComponent(self.mainGO, string.format("sanity%s", i))
	end
end

function UIBattleSanityGroup:destroyUI()
	BattleTableUtil.clearTable(self._iconList)
end

function UIBattleSanityGroup:setVisible(visible)
	goutil.setActive(self.mainGO, visible)
end

function UIBattleSanityGroup:setSanity(sanityValue)
	local iconName = BattleIconName.getSanityIcon(sanityValue)
	local absSanityValue = math.abs(sanityValue)

	for index, icon in pairs(self._iconList) do
		if index <= absSanityValue then
			icon.enabled = true

			IconLoader.setSprite(icon, IconType.DynSpriteAtlas_Battle, iconName)
		else
			icon.enabled = false
		end
	end
end

return UIBattleSanityGroup

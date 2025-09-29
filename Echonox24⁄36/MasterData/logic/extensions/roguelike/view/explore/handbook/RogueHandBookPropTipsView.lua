-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/handbook/RogueHandBookPropTipsView.lua

module("logic.extensions.roguelike.view.explore.handbook.RogueHandBookPropTipsView", package.seeall)

local HandBookPropItem = class("HandBookPropItem")

function HandBookPropItem:ctor(container)
	self._go = container.gameObject

	local go = self._go

	self._txtPropName = goutil.findChildTextComponent(go, "txtPropName")
	self._txtPropDesc = goutil.findChildTextComponent(go, "txtPropDesc")
	self._goItem = goutil.findChild(go, "cell/backpack_item")
	self._imgPropIcon = goutil.findChildImageComponent(self._goItem, "imgIcon")
	self._imgPropQuality = goutil.findChildImageComponent(self._goItem, "imgQuality")
end

function HandBookPropItem:updateData(co)
	IconLoader.setSprite(self._imgPropIcon, IconType.ItemIcon, co.art)
	IconLoader.setSprite(self._imgPropQuality, IconType.Skinlib, GameUrl.getItemQualityUrl(co.rarity + 1))

	self._txtPropName.text = co.name
	self._txtPropDesc.text = co.descirption
end

local M = class("RogueHandBookPropTipsView", ViewComponent)
local kQuality2Index = {
	3,
	2,
	1,
	0
}
local kQualityDefault = 3

function M:buildUI()
	self._goCell = self:getGo("run_group_prop_tips_517470059")
	self._txtPropName = self:getText("run_group_prop_tips_976987003")
	self._txtPropDesc = self:getText("run_group_prop_tips_1143170986")

	local backpackItem = goutil.findChild(self._goCell, "backpack_item")
	local item = Astral.LuaComponentContainer.Add(backpackItem, RoguePropItem)

	self._propItem = item
	self._traQuality = self:getGo("run_group_prop_tips_1253499328").transform
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
	self:updateData()
end

function M:onExit()
	return
end

function M:updateData()
	local propCo = self:getFirstParam()

	self._txtPropName.text = propCo.name
	self._txtPropDesc.text = StringUtil.replaceAllGraphicText2(propCo.descirption)

	local data = {}

	data.propId = propCo.id

	self._propItem:updateData(data)

	local index = kQuality2Index[propCo.rarity] or kQualityDefault

	for i = 0, self._traQuality.childCount - 1 do
		goutil.setActive(self._traQuality:GetChild(i).gameObject, i == index)
	end
end

return M

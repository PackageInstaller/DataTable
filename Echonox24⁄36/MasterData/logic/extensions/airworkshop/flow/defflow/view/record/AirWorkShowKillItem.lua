-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/record/AirWorkShowKillItem.lua

module("logic.extensions.airworkshop.flow.defflow.view.record.AirWorkShowKillItem", package.seeall)

local M = class("AirWorkShowKillItem")

function M:ctor(container)
	self._go = container.gameObject
	self._itemHero = goutil.findChild(self._go, "hero_item")
	self._itemHero2 = goutil.findChild(self._go, "hero_item2")
	self._txtNumber = goutil.findChildTextComponent(self._go, "txtCount")

	self:_bindEvents()
end

function M:_bindEvents()
	return
end

function M:_unbindEvents()
	for i, v in ipairs(self._heroItemViewList or {}) do
		v:unbindEvents()
		v:onExit()
	end

	self._heroItemViewList = false
end

function M:OnDestroy()
	self:_unbindEvents()
end

function M:updateData(data)
	self._data = data

	local heroId = self._data.heroId
	local count = self._data.target.count
	local targetHeroId = self._data.target.heroId

	self._txtNumber.text = count
	self._heroItemViewList = {}

	local shower = Astral.LuaComponentContainer.Add(self._itemHero, HeroHeadItem)
	local heroData = CharacterUtil.getPreviewHeroData(heroId)

	shower:setHeroMO(heroData)
	shower:showLevel(false)

	local shower2 = Astral.LuaComponentContainer.Add(self._itemHero2, HeroHeadItem)
	local heroData = CharacterUtil.getPreviewHeroData(targetHeroId)

	shower2:setHeroMO(heroData)
	shower2:showLevel(false)
	table.insert(self._heroItemViewList, shower)
	table.insert(self._heroItemViewList, shower2)
end

return M

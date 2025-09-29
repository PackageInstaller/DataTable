-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueDiceRoleHeadItem.lua

module("logic.extensions.roguelike.view.widgets.RogueDiceRoleHeadItem", package.seeall)

local M = class("RogueDiceRoleHeadItem")

function M:ctor(go)
	self._go = go.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go.gameObject)
end

function M:Awake()
	self:onInit()
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:setSelect(isSelect)
	goutil.setActive(self._goSelect, isSelect)
end

function M:onInit()
	local registry = self._viewElementsRegistry

	self._btnClick = UIComponentType.ButtonAdapter(registry:findUIElement("dice_hero_head_-2030420241"))
	self._imgIcon = registry:findUIElement("dice_hero_head_861350944", UIComponentType.Image)
	self._txtHpChange = registry:findUIElement("dice_hero_head_661919545", UIComponentType.Text)
	self._goHpChange = registry:findUIElement("dice_hero_head_-1762497315")
	self._goEffect = registry:findUIElement("dice_hero_head_-400641106")
	self._goEffectUp = registry:findUIElement("dice_hero_head_-1646428022")
	self._imgEffectUp = registry:findUIElement("dice_hero_head_-1646428022", UIComponentType.Image)
	self._imgEffectUpNum = registry:findUIElement("dice_hero_head_2034163041", UIComponentType.Image)
	self._goEffectDown = registry:findUIElement("dice_hero_head_-1964935198")
	self._imgEffectDown = registry:findUIElement("dice_hero_head_-1964935198", UIComponentType.Image)
	self._imgEffectDownNum = registry:findUIElement("dice_hero_head_-166769055", UIComponentType.Image)
	self._goSelect = registry:findUIElement("dice_hero_head_-67006488")

	self._btnClick:AddClickListener(self._onClick, self)
end

function M:_onClick()
	if self._clickCallback then
		self._clickCallback()
	end
end

function M:updateData(data)
	if data.icon ~= nil then
		IconLoader.setSprite(self._imgIcon, data.iconType, data.icon)
	elseif data.roleId then
		local characterCO = CharacterConfig.instance:getCfgInfoByID(data.roleId)

		if characterCO then
			local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)

			IconLoader.setSprite(self._imgIcon, IconType.RoleCard, modelCO.halfIconName)
		end
	elseif data.monsterId then
		local monsterCo = RoguelikeConfig.instance:getRoguelikeMonsterById(data.monsterId)

		if monsterCo == nil then
			printError("找不到怪物", data.monsterId)
		end

		IconLoader.setSprite(self._imgIcon, IconType.RunGroup, string.format("rungroup_monster_head/%s", monsterCo.staticRes))
	end

	goutil.setActive(self._goEffectUp, false)

	self._txtHpChange.text = data.hpChange and (data.hpChange > 0 and "+" .. data.hpChange or data.hpChange) or ""

	goutil.setActive(self._goEffect, false)
	goutil.setActive(self._goHpChange, false)

	self._clickCallback = data.callback

	self:setActive(true)
end

function M:OnDestroy()
	if self._btnClick then
		self._btnClick:RemoveClickListener()
	end

	self._btnClick = nil
end

return M

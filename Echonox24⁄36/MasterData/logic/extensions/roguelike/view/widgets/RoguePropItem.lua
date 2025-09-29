-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RoguePropItem.lua

module("logic.extensions.roguelike.view.widgets.RoguePropItem", package.seeall)

local M = class("RoguePropItem")

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

function M:onInit()
	local registry = self._viewElementsRegistry

	self._btnClick = UIComponentType.ButtonAdapter(registry:findUIElement("rewards_detail_item_1370605741"))
	self._imgQuality = registry:findUIElement("rewards_detail_item_868117965", UIComponentType.Image)
	self._imgIcon = registry:findUIElement("rewards_detail_item_-2041880288", UIComponentType.Image)
	self._goInUse = registry:findUIElement("backpack_item_-1719482002")
	self._headIcon = registry:findUIElement("backpack_item_537430731", UIComponentType.Image)

	local temp1 = goutil.findChild(self._goInUse, "Image1")
	local temp2 = goutil.findChild(self._goInUse, "Text")

	goutil.setActive(temp1, false)
	goutil.setActive(temp2, false)

	self._txtName = registry:findUIElement("backpack_item_372005575", UIComponentType.Text)
	self._goMask = registry:findUIElement("backpack_item_1646665409")
	self._goIng = goutil.findChild(self._go, "reward")

	self._btnClick:AddClickListener(self._onClick, self)
end

function M:_onClick()
	if self._callback then
		self._callback()
	end
end

function M:setExtraParam(goContinue, goSpecial, goUsed)
	self._goContinue = goContinue
	self._goSpecial = goSpecial
	self._goUsed = goUsed

	if self._photoEff == nil then
		self._photoEff = PhotoEffect.Get(goContinue)

		local path = GameUrl.get3dEffectUIUrl("vfx_backpack_run_liuguang")

		self._photoEff:showEffects(path)
		self._photoEff:setCameraPosition(0, 0, -1.14)
	end
end

function M:updateData(data)
	self._callback = data.callback

	local propId = data.propId
	local propCo = RoguelikeConfig.instance:getPropById(data.propId)

	if propCo then
		IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, propCo.art)
		IconLoader.setSprite(self._imgQuality, IconType.Skinlib, GameUrl.getItemQualityUrl(propCo.rarity + 1))
	end

	if data.showName then
		self._txtName.text = propCo.name
	end

	if self._goContinue then
		goutil.setActive(self._goContinue, data.inUsing)
	end

	if self._goUsed then
		goutil.setActive(self._goUsed, data.ash)
	end

	if data.heroId and data.heroId ~= 0 then
		local characterCO = CharacterConfig.instance:getCfgInfoByID(data.heroId)

		if characterCO then
			local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)

			IconLoader.setSprite(self._headIcon, IconType.RoleHeadIcon, modelCO.headIconName)
		end
	end

	goutil.setActive(self._goInUse, data.heroId and data.heroId ~= 0)
	goutil.setActive(self._goMask, data.showMask)
	self:setActive(propId ~= nil and propId ~= 0)
end

function M:OnDestroy()
	if self._btnClick then
		self._btnClick:RemoveClickListener()
	end

	self._btnClick = nil

	if self._photoEff then
		self._photoEff:clear()

		self._photoEff = nil
	end
end

return M

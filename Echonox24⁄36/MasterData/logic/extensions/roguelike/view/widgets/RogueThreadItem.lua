-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueThreadItem.lua

module("logic.extensions.roguelike.view.widgets.RogueThreadItem", package.seeall)

local M = class("RogueThreadItem")

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
	self._txtName = registry:findUIElement("backpack_item_372005575", UIComponentType.Text)
	self._goIng = goutil.findChild(self._go, "reward")

	self._btnClick:AddClickListener(self._onClick, self)
end

function M:_onClick()
	if self._callback then
		self._callback()
	end
end

function M:updateData(data)
	self._callback = data.callback

	local itemId = data.itemId
	local itemCo = BackpackConfig.instance:getItemInfoByItemId(itemId)

	if itemCo then
		IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, itemCo.icon)
		IconLoader.setSprite(self._imgQuality, IconType.Skinlib, GameUrl.getItemQualityUrl(itemCo.quality))
	end

	if data.showName then
		self._txtName.text = propCo.name
	end

	goutil.setActive(self._goIng, data.inUsing)
	self:setActive(itemId ~= nil and itemId ~= 0)
end

function M:OnDestroy()
	self._btnClick:RemoveClickListener()

	self._btnClick = nil
end

return M

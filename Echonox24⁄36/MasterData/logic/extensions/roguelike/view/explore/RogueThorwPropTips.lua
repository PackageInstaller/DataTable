-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueThorwPropTips.lua

module("logic.extensions.roguelike.view.explore.RogueThorwPropTips", package.seeall)

local M = class("RogueThorwPropTips")

function M:ctor(go)
	self._go = go.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	self:init()
end

function M:init()
	local registry = self._viewElementsRegistry

	self._imgIcon = registry:findUIElement("props_throw_tips_845185723", UIComponentType.Image)
	self._imgQuality = registry:findUIElement("props_throw_tips_-1019023278", UIComponentType.Image)
	self._txtName = registry:findUIElement("props_throw_tips_1608674272", UIComponentType.Text)
	self._txtContent = registry:findUIElement("props_throw_tips_-1054866756", UIComponentType.Text)
	self._txtContent2 = registry:findUIElement("props_throw_tips_-379675963", UIComponentType.Text)
	self._btnClose = UIComponentType.ButtonAdapter(registry:findUIElement("props_throw_tips_-488176199"))
	self._btnThrow = UIComponentType.ButtonAdapter(registry:findUIElement("props_throw_tips_-730744578"))

	self._btnClose:AddClickListener(self._clickClose, self)
	self._btnThrow:AddClickListener(self._clickThrow, self)
	goutil.setActive(self._btnThrow.gameObject, false)
end

function M:_clickClose()
	self:setActive(false)

	if self._closeCallback then
		self._closeCallback()
	end
end

function M:_clickThrow()
	RoguelikeAgent.instance:sendDropPropsRequest(self._no.id)
	self:setActive(false)
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:setCloseCallback(callback)
	self._closeCallback = callback
end

function M:updateData(no)
	local propCo = RoguelikeConfig.instance:getPropById(no.code)

	IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, propCo.art)
	IconLoader.setSprite(self._imgQuality, IconType.Skinlib, GameUrl.getEquipQualityUrl(propCo.rarity))

	self._txtName.text = propCo.name

	local linkText = propCo.link ~= "" and "\n\n" .. propCo.link or ""

	self._txtContent.text = StringUtil.replaceAllGraphicText2(propCo.descirption .. linkText)
	self._txtContent2.text = StringUtil.replaceAllGraphicText2(propCo.copywriting)
	self._no = no
end

function M:OnDestroy()
	self._imgIcon = nil
	self._txtName = nil
	self._txtContent = nil

	self._btnThrow:RemoveClickListener()
	self._btnClose:RemoveClickListener()

	self._btnThrow = nil
	self._btnClose = nil
end

return M

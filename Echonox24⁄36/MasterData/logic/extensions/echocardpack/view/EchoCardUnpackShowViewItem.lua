-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echocardpack/view/EchoCardUnpackShowViewItem.lua

module("logic.extensions.echocardpack.view.EchoCardUnpackShowViewItem", package.seeall)

local M = class("EchoCardUnpackShowViewItem")
local quality2DissolveAnim = {
	nil,
	nil,
	"echo_card_b1",
	"echo_card_a1",
	"echo_card_s1"
}

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._mainGo)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._imgQuality = registry:findUIElement("echocard_unpacking_item_-266310241", UIComponentType.Image)
	self._imgIcon = registry:findUIElement("echocard_unpacking_item_-951240617", UIComponentType.Image)
	self._btnClick = registry:findUIElement("echocard_unpacking_item_1826423226", UIComponentType.ButtonAdapter)
	self._goBack = goutil.findChild(self._mainGo, "beimian")
	self.goEffects = {}
	self.goEffects[GameEnum.QualityEnum.S] = registry:findUIElement("echocard_unpacking_item_721548925")
	self.goEffects[GameEnum.QualityEnum.A] = registry:findUIElement("echocard_unpacking_item_461267326")
	self.goEffects[GameEnum.QualityEnum.B] = registry:findUIElement("echocard_unpacking_item_1472173354")
	self._uiAnimation = self._mainGo:GetComponent(ComponentType.Animation)
end

function M:refreshView(data)
	self._echoItemData = data
	self._quality = self._echoItemData:getQuality()

	local url = GameUrl.getEchoItemQualityUrl(self._quality)

	IconLoader.setSprite(self._imgQuality, IconType.DynSpriteAtlas_CharacterSystem_Com, url)

	local icon = self._echoItemData:getIcon()
	local url = self._quality ~= GameEnum.QualityEnum.C and string.format("%s_1", icon) or icon

	IconLoader.setSprite(self._imgIcon, IconType.EchoItemBigIcon, url)

	for key, obj in pairs(self.goEffects) do
		goutil.setActive(obj, key == self._quality)
	end
end

function M:OnEnable()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:OnDisable()
	self._btnClick:RemoveClickListener()
end

function M:OnDestroy()
	self._clickFunc = nil
	self._clickHandler = nil

	IconLoader.clearSprite(self._imgIcon)
	IconLoader.clearSprite(self._imgQuality)
end

function M:setClickFunction(fun, handler)
	self._clickFunc = fun
	self._clickHandler = handler
end

function M:_onClick()
	if not self._clickFunc then
		return
	end

	if self._clickHandler then
		self._clickFunc(self._clickHandler, self)
	else
		self._clickFunc(self)
	end
end

function M:showDissolveAnim()
	if not self:getBackActiveState() then
		return
	end

	if self._uiAnimation then
		local animName = quality2DissolveAnim[self._quality] or "echo_card_b1"

		self._uiAnimation:Stop()
		self._uiAnimation:Play(animName)
	end
end

function M:setBackActiveState(value)
	if self._uiAnimation then
		self._uiAnimation:Stop()
	end

	goutil.setActive(self._goBack, value)
end

function M:getBackActiveState()
	return self._goBack.activeSelf
end

function M:setActive(value)
	goutil.setActive(self._mainGo, value)
end

function M:showTips()
	local data = ToolTipsUtil.createItemTipsData(self._echoItemData, self._mainGo)

	ToolTipsMgr.showTips(data.viewName, data)
end

return M

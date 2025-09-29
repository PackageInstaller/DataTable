-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/PlayerDisplayCardItem.lua

module("logic.extensions.playerinfo.view.info.PlayerDisplayCardItem", package.seeall)

local M = class("PlayerDisplayCardItem")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._imgHeadIcon = registry:findUIElement("visiting_card_item_-334213830", UIComponentType.Image)
	self._usingGo = registry:findUIElement("visiting_card_item_1725827898")
	self._lockParentObj = registry:findUIElement("visiting_card_item_1472598404")
	self._localObj = registry:findUIElement("visiting_card_item_739370007")
	self._unlockObj = registry:findUIElement("visiting_card_item_73620694")
	self._selectObj = registry:findUIElement("visiting_card_item_-371828819")
	self._btnClick = ButtonAdapter.Get(registry:findUIElement("visiting_card_item_1465565650"))

	self._btnClick:AddClickListener(self._clickClick, self)

	self._glow = registry:findUIElement("visiting_card_item_-1229623594", UIComponentType.Image)
	self._selectAni = goutil.addComponentOnce(self._go, ComponentType.Animation)
end

function M:_clickClick()
	if self._clickGotoFun then
		self._clickGotoFun(self._clickGotoHandle, self._data.id)
	end
end

function M:setClick(clickGoto, clickGotoHandler)
	self._clickGotoFun = clickGoto
	self._clickGotoHandle = clickGotoHandler
end

function M:setCellData(data, index, curId, selectId)
	self._curIndex = index
	self._data = data
	self._isUsing = data.id == curId

	if data.cfgdata and not string.nilorempty(data.cfgdata.icon) then
		IconLoader.setSprite(self._imgHeadIcon, IconType.PlayerCard, data.cfgdata.icon)
		IconLoader.setSprite(self._glow, IconType.PlayerCard, data.cfgdata.icon)
	end

	local isSelect = selectId == data.id

	goutil.setActive(self._selectObj, isSelect)
	goutil.setActive(self._localObj, not self._data.isUnlock)
	goutil.setActive(self._lockParentObj, not self._data.isUnlock)
	goutil.setActive(self._usingGo, self._isUsing)

	if isSelect and self._isUsing then
		self._selectAni:Stop()
		self._selectAni:Play("visiting_card_item_usingtype_open")
	end
end

function M:OnDisable()
	return
end

function M:OnDestroy()
	self._compContainer = nil
	self._go = nil
	self._trs = nil
	self._viewElementsRegistry = nil

	self._btnClick:RemoveClickListener()

	self._btnClick = nil
end

return M

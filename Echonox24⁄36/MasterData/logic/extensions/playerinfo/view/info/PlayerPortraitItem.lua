-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/PlayerPortraitItem.lua

module("logic.extensions.playerinfo.view.info.PlayerPortraitItem", package.seeall)

local M = class("PlayerPortraitItem")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._imgHeadIcon = registry:findUIElement("head_item_1770823988", UIComponentType.Image)
	self._usingGo = registry:findUIElement("head_item_-481892556")
	self._lockParentObj = registry:findUIElement("head_item_-765526646")
	self._localObj = registry:findUIElement("head_item_-1450637287")
	self._unlockObj = registry:findUIElement("head_item_-2114211624")
	self._selectObj = registry:findUIElement("head_item_1817099171")
	self._selectAni = goutil.findChildComponent(self._selectObj, "glow01", ComponentType.Animation)
	self._btnClick = ButtonAdapter.Get(registry:findUIElement("head_item_-759026212"))

	self._btnClick:AddClickListener(self._clickClick, self)
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
		IconLoader.setSprite(self._imgHeadIcon, IconType.HeadIcon, data.cfgdata.icon)
	end

	local isSelect = selectId == data.id

	goutil.setActive(self._selectObj, isSelect)
	goutil.setActive(self._localObj, not self._data.isUnlock)
	goutil.setActive(self._lockParentObj, not self._data.isUnlock)
	goutil.setActive(self._usingGo, self._isUsing)

	if isSelect and self._isUsing then
		self._selectAni:Stop()
		self._selectAni:Play("head_item_glow_open")
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

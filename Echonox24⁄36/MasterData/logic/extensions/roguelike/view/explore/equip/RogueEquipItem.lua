-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/equip/RogueEquipItem.lua

module("logic.extensions.roguelike.view.explore.equip.RogueEquipItem", package.seeall)

local M = class("RogueEquipItem", ListBinderCell)

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(goutil.findChild(self._go, "backpack_item"))
end

function M:Awake()
	self:onInit()
end

function M:onInit()
	local registry = self._viewElementsRegistry

	self._animation = goutil.findChildComponent(self._go, "backpack_item", ComponentType.Animation)
	self._canvasGroup = goutil.findChildComponent(self._go, "backpack_item", ComponentType.CanvasGroup)
	self._imgQua = registry:findUIElement("rewards_detail_item_868117965", UIComponentType.Image)
	self._imgIcon = registry:findUIElement("rewards_detail_item_-2041880288", UIComponentType.Image)
	self._labItemNum = registry:findUIElement("backpack_item_372005575", UIComponentType.Text)
	self._goSelect = registry:findUIElement("backpack_item_506657149")
	self._goInUse = goutil.findChild(self._go, "equipSign")
	self._goInNot = goutil.findChild(self._go, "inNot")
	self._btnClick = registry:findUIElement("rewards_detail_item_1370605741", UIComponentType.ButtonAdapter)

	self._btnClick:AddClickListener(self._clickSelect, self)
end

function M:setCellData(itemData, index, curSelectIndex)
	self._index = index
	self._itemData = itemData

	if itemData then
		IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, itemData:getIcon())
		IconLoader.setSprite(self._imgQua, IconType.Skinlib, CommEnum.ItemQualityRes[itemData:getQuality()])

		self._labItemNum.text = "Lv" .. itemData:getLevel()

		self:setSelect(index == curSelectIndex)
		self:setInUse(RoguelikeModel.instance:getEquipIsWear(itemData:getId()))

		self._go.name = "cell" .. index

		goutil.setActive(self._goInNot, itemData.inInRejectScript)
		self:setInUse(itemData.isWear)
	end
end

function M:setSelect(select)
	goutil.setActive(self._goSelect, select)
end

function M:setInUse(inUse)
	goutil.setActive(self._goInUse, inUse)
end

function M:_clickSelect()
	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, self._index)
	end
end

function M:setClickCallBack(func, handler)
	self._clickCallBackFunc = func
	self._clickCallBackHandler = handler
end

function M:playOpenAni()
	self:playAnim("backpack_item_open")
end

function M:playAnim(name)
	self._animation:Stop()
	self._animation:Play(name)
end

function M:StopAni()
	self:playAnim("backpack_item_normal")
end

function M:setAlpha(alpha)
	self._canvasGroup.alpha = alpha
end

function M:OnDestroy()
	self._btnClick:RemoveClickListener()
end

return M

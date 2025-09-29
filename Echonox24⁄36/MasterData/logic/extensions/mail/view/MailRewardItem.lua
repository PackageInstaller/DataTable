-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mail/view/MailRewardItem.lua

module("logic.extensions.mail.view.MailRewardItem", package.seeall)

local M = class("MailRewardItem")

function M:ctor(compContainer)
	self._go = compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._itemGo = registry:findUIElement("rewards_detail_item_2141037416")
	self._itemCell = Astral.LuaComponentContainer.Add(self._itemGo, ItemCell)
	self._goMask = registry:findUIElement("backpack_item_1646665409")
	self._goHasGotSign = registry:findUIElement("backpack_item_1042455870")
	self._canvasGroup = registry:findUIElement("rewards_detail_item_2141037416", ComponentType.CanvasGroup)
end

function M:setDefaultState()
	self._canvasGroup.alpha = 0
end

function M:setTargetState()
	self._canvasGroup.alpha = 1
end

function M:StopAni()
	self._canvasGroup:DOKill(false)
end

function M:playEnterAnim()
	self._canvasGroup:DOKill(false)
	self._canvasGroup:DOFade(1, 0.3):SetAutoKill(true)
end

function M:getIndex()
	return self._curIndex
end

function M:setCellData(itemData, index)
	self._curIndex = index

	self._itemCell:updateData(itemData)
	self._itemCell:setShowSelectedEffect(false)
	self._itemCell:getComponent("num"):updateData(itemData)
end

function M:setIsGetReward(isGet)
	goutil.setActive(self._goMask, isGet)
	goutil.setActive(self._goHasGotSign, isGet)
end

function M:OnDestroy()
	self._go = nil
	self._viewElementsRegistry = nil
	self._itemGo = nil
	self._itemCell = nil
end

return M

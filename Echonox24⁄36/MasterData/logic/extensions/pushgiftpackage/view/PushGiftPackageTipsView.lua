-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pushgiftpackage/view/PushGiftPackageTipsView.lua

module("logic.extensions.pushgiftpackage.view.PushGiftPackageTipsView", package.seeall)

local M = class("PushGiftPackageTipsView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnClose = self:getBtnByPath("allContent/btn_close")
	self._imgTitle = UIComponentType.BigBGLocalizationLua(self:getGo("push_gift_package_tips_-1312108607"))
	self._bigBg = self:getBigBg("push_gift_package_tips_-1131732584")
	self._imgIcon = self:getImage("push_gift_package_tips_1302697367")
	self._txtDesc = self:getUIComponent("push_gift_package_tips_-1896625896", UIComponentType.Text)
	self._txtTime = self:getUIComponent("push_gift_package_tips_-506018424", UIComponentType.Text)
	self._rectTrItemRoot = self:getUIComponent("push_gift_package_tips_1759618506", UIComponentType.RectTransform)
	self._btnPageFront = self:getBtn("push_gift_package_tips_-77489413")
	self._btnPageBehind = self:getBtn("push_gift_package_tips_163885502")
	self._rectTrDotsRoot = self:getUIComponent("push_gift_package_tips_-942848269", UIComponentType.RectTransform)
	self._btnBuy = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self.mainGO, "allContent/btnBuy"), CommButton)
	self._goDiscount = self:getGo("push_gift_package_tips_-1253242771")
	self._txtDiscount = self:getUIComponent("push_gift_package_tips_-1626520651", UIComponentType.Text)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnPageFront:AddClickListener(self._onClickPageFront, self)
	self._btnPageBehind:AddClickListener(self._onClickPageBehind, self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnPageFront:RemoveClickListener()
	self._btnPageBehind:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
end

function M:onEnter(reasonTyp)
	self:setEvent(true)
end

function M:onExit(reasonTyp)
	local isNormalClose = reasonTyp ~= WindowType.WindowCloseReasonType.QuickCloseType

	self:setEvent(false)
	self._bigBg:ClearImage()
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:_onClickClose()
	self:close()
end

function M:_onClickPageFront()
	return
end

function M:_onClickPageBehind()
	return
end

function M:_onClickBuy()
	return
end

return M

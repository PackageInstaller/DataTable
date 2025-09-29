-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/dialog/impl/MessageDialogImpl.lua

module("logic.common.viewlib.dialog.impl.MessageDialogImpl", package.seeall)

local M = class("MessageDialogImpl", BaseDialog)

function M:ctor()
	M.super.ctor(self)

	self._title = false
	self._content = false
	self._closeHandler = Handler.New()
	self._cancelHandler = Handler.New()
	self._confirmHandler = Handler.New()
	self._confirmNotCloseHandler = Handler.New()
end

function M:buildUI()
	M.super.buildUI(self)

	self._registry = ViewElementsRegistry.New(self.mainGO)
	self._txtTitle = self._registry:findUIElement("message_tips_-1921776596", UIComponentType.Text)
	self._txtConent = self._registry:findUIElement("message_dialog_-858469084", UIComponentType.TextMeshProUGUI)
	self._btnClose = self._registry:findUIElement("message_tips_1822196934", UIComponentType.ButtonAdapter)
	self._btnCancel = Astral.SimpleLuaComponentContainer.Add(self._registry:findUIElement("4&btn_left_-1571983320"), CommButton)
	self._btnConfirm = Astral.SimpleLuaComponentContainer.Add(self._registry:findUIElement("5&btn_right_1251431307"), CommButton)
	self._txtOriConfirm = self._btnConfirm:getTextStr()
	self._txtOriCancel = self._btnCancel:getTextStr()

	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self:setButtonStyle()
end

function M:setButtonStyle()
	goutil.setActive(self._registry:findUIElement("4&btn_left_-1571983320"), true)
	goutil.setActive(self._registry:findUIElement("5&btn_right_1251431307"), true)
	goutil.setActive(self._registry:findUIElement("6&btn_middle_-31477526"), false)
end

function M:destroyUI()
	M.super.destroyUI(self)
	self._registry:cleanRegistry()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()

	self._registry = nil
	self._txtTitle = nil
	self._txtConent = nil
	self._btnClose = nil
	self._btnCancel = nil
	self._btnConfirm = nil
end

function M:onEnter()
	M.super.onEnter(self)
	self:updateViewSort()

	self._mask = ModalMask.addBlackMask(self.mainGO)
	self._txtTitle.text = self._title or ""
	self._txtConent.text = self._content or ""

	if self._confirmText then
		self._btnConfirm:setText(self._confirmText)
	end

	if self._cancelText then
		self._btnCancel:setText(self._cancelText)
	end
end

function M:onExit()
	M.super.onExit(self)
	ModalMask.releaseMask(self._mask)
	self._closeHandler:clear()
	self._cancelHandler:clear()
	self._confirmHandler:clear()
	self._confirmNotCloseHandler:clear()

	self._mask = false
	self._title = false
	self._content = false
	self._viewSortIndex = nil

	self._btnConfirm:setText(self._txtOriConfirm)
	self._btnCancel:setText(self._txtOriCancel)

	self._confirmText = false
	self._cancelText = false
end

function M:onViewRootChanged()
	if self._mask then
		self._mask:setBackgroundMask(self.mainGO)
	end
end

function M:updateViewSort()
	if self._viewSortIndex then
		local tra = self.mainGO.transform

		if self._viewSortIndex == 0 then
			tra:SetAsFirstSibling()
		elseif self._viewSortIndex == -1 then
			tra:SetAsLastSibling()
		else
			tra:SetSiblingIndex(self._viewSortIndex)
		end
	end
end

function M:setTitle(title)
	self._title = title

	return self
end

function M:setContent(content)
	self._content = content

	return self
end

function M:setConfirmText(content)
	self._confirmText = content

	if self.mainGO and not goutil.isNil(self.mainGO) then
		self._btnConfirm:setText(content)
	end

	return self
end

function M:setCancelText(content)
	self._cancelText = content

	if self.mainGO and not goutil.isNil(self.mainGO) then
		self._btnCancel:setText(content)
	end

	return self
end

function M:setCloseListener(callback, callbackSelf)
	self._closeHandler:setListener(callback, callbackSelf)

	return self
end

function M:setCancelListener(callback, callbackSelf)
	self._cancelHandler:setListener(callback, callbackSelf)

	return self
end

function M:setConfirmListener(callback, callbackSelf)
	self._confirmHandler:setListener(callback, callbackSelf)

	return self
end

function M:setConfirmNotCloseListener(callback, callbackSelf)
	self._confirmNotCloseHandler:setListener(callback, callbackSelf)

	return self
end

function M:_onClickClose()
	self._closeHandler:call()
	self:close()
end

function M:onClickOutSideClose()
	self._closeHandler:call()
	self:close()
end

function M:_onClickCancel()
	self._cancelHandler:call()
	self:close()
end

function M:_onClickConfirm()
	if self._confirmNotCloseHandler:hadCallback() then
		self._confirmNotCloseHandler:call()

		return
	end

	self._confirmHandler:call()
	self:close()
end

function M:setViewSort(index)
	self._viewSortIndex = index

	return self
end

return M

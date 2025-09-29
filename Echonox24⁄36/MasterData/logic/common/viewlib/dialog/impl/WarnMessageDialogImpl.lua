-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/dialog/impl/WarnMessageDialogImpl.lua

module("logic.common.viewlib.dialog.impl.WarnMessageDialogImpl", package.seeall)

local M = class("WarnMessageDialogImpl", BaseDialog)

function M:ctor()
	M.super.ctor(self)

	self._title = false
	self._content = false
	self._closeHandler = Handler.New()
	self._cancelHandler = Handler.New()
	self._confirmHandler = Handler.New()
end

function M:buildUI()
	M.super.buildUI(self)

	self._registry = ViewElementsRegistry.New(self.mainGO)
	self._txtTitle = self._registry:findUIElement("warn_message_tips_-1144006553", UIComponentType.Text)
	self._txtConent = self._registry:findUIElement("warn_message_tips_1329396241", UIComponentType.Text)
	self._btnCancel = Astral.SimpleLuaComponentContainer.Add(self._registry:findUIElement("1&btn_left_-1571983320"), CommButton)
	self._btnConfirmCenter = Astral.SimpleLuaComponentContainer.Add(self._registry:findUIElement("3&btn_middle_-31477526"), CommButton)
	self._btnConfirm = Astral.SimpleLuaComponentContainer.Add(self._registry:findUIElement("2&btn_right_1251431307"), CommButton)
	self._btnClose = UIComponentType.ButtonAdapter(self._registry:findUIElement("warn_message_tips_589988714"))

	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._btnConfirmCenter:AddClickListener(self._onClickConfirm, self)
	self._btnClose:AddClickListener(self._onClickCancel, self)
end

function M:destroyUI()
	M.super.destroyUI(self)
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnConfirmCenter:RemoveClickListener()
	self._btnClose:RemoveClickListener()

	self._txtTitle = nil
	self._txtConent = nil
	self._btnCancel = nil
	self._btnConfirm = nil
	self._btnConfirmCenter = nil
end

function M:onEnter()
	M.super.onEnter(self)

	self._mask = ModalMask.addBlackMask(self.mainGO)
	self._txtTitle.text = self._title or ""
	self._txtConent.text = self._content or ""

	self:_updateBtnVisible()
end

function M:onExit()
	M.super.onExit(self)
	ModalMask.releaseMask(self._mask)
	self._cancelHandler:clear()
	self._confirmHandler:clear()

	self._mask = false
	self._title = false
	self._content = false
end

function M:onViewRootChanged()
	if self._mask then
		self._mask:setBackgroundMask(self.mainGO)
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

function M:setCancelListener(callback, callbackSelf)
	self._cancelHandler:setListener(callback, callbackSelf)

	return self
end

function M:setConfirmListener(callback, callbackSelf)
	self._confirmHandler:setListener(callback, callbackSelf)

	return self
end

function M:_onClickCancel()
	self._cancelHandler:call()
	self:close()
end

function M:_onClickConfirm()
	self._confirmHandler:call()
	self:close()
end

function M:onClickOutSideClose()
	self._cancelHandler:call()
	self:close()
end

function M:_updateBtnVisible()
	if not self._btnVisiableInfo then
		goutil.setActive(self._btnConfirmCenter.gameObject, false)
		goutil.setActive(self._btnCancel.gameObject, true)
		goutil.setActive(self._btnConfirm.gameObject, true)
		goutil.setActive(self._btnClose.gameObject, true)

		return
	end

	goutil.setActive(self._btnConfirmCenter.gameObject, self._btnVisiableInfo.isOneBtn)
	goutil.setActive(self._btnCancel.gameObject, not self._btnVisiableInfo.isOneBtn)
	goutil.setActive(self._btnConfirm.gameObject, not self._btnVisiableInfo.isOneBtn)
	goutil.setActive(self._btnClose.gameObject, not self._btnVisiableInfo.isHideCloseBtn)
end

return M

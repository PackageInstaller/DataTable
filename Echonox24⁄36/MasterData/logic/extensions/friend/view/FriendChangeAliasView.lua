-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/FriendChangeAliasView.lua

module("logic.extensions.friend.view.FriendChangeAliasView", package.seeall)

local FriendChangeAliasView = class("FriendChangeAliasView", ViewComponent)

function FriendChangeAliasView:buildUI()
	self._btnClose = self:getBtnByPath("universal_second_tips_common_bg/content/btnClose")
	self._btnCancel = self:getBtnByPath("content/btnCancel")
	self._btnSave = self:getBtnByPath("content/btnConfirm")
	self._inputName = self:getInput("player_rename_tips_1468135034")
	self._txtTitle = goutil.findChildComponent(self.mainGO, "universal_second_tips_common_bg/content/txtTitle", UIComponentType.Text)
	self._txtPlaceholder = goutil.findChildComponent(self.mainGO, "content/inputName/Text1", UIComponentType.Text)
end

function FriendChangeAliasView:destroyUI()
	self._btnClose = nil
	self._btnCancel = nil
	self._btnSave = nil
	self._inputName = nil
	self._maxLen = false
end

function FriendChangeAliasView:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnSave:AddClickListener(self._onClickSave, self)
end

function FriendChangeAliasView:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnSave:RemoveClickListener()
end

function FriendChangeAliasView:onEnter()
	local openParam = self:getOpenParam()

	self._friendMo = openParam[1]
	self._maxLen = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.TeamNameMaxLen)

	self._inputName:SetCharacterLimit(self._maxLen)
	self._inputName:SetText(self._friendMo:getAlias())

	self._txtTitle.text = lang("tip_modify_remark")
	self._txtPlaceholder.text = lang("tip_not_7_remark")
end

function FriendChangeAliasView:onExit()
	return
end

function FriendChangeAliasView:_onClickClose()
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_window_close, nil, nil, nil)
	self:close()
end

function FriendChangeAliasView:_onClickCancel()
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_click_cancel, nil, nil, nil)
	self:close()
end

function FriendChangeAliasView:_onClickSave()
	if string.utf8len(self._inputName:GetText()) > self._maxLen then
		if enableLog then
			print("输入名称过长")
		end

		return
	end

	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_click_confirm, nil, nil, nil)
	FriendAgent.instance:sendChangeAliasRequest(self._friendMo:getUserId(), self._inputName:GetText())
	self:close()
end

return FriendChangeAliasView

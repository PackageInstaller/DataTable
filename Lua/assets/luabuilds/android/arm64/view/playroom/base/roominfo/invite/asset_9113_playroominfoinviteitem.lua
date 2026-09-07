local PlayRoomInfoInviteItem = class("PlayRoomInfoInviteItem", import("view.base.BasePanel"))

function PlayRoomInfoInviteItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	PlayRoomInfoInviteItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function PlayRoomInfoInviteItem:Init()
	setText(self.uiOnlineText, i18n("island_btn_label_online"))

	return
end

function PlayRoomInfoInviteItem:didEnter(arg_3_1)
	setText(self.uiNameText, arg_3_1.name)
	setText(self.uiLevelText, arg_3_1.level)
	LoadSpriteAsync("qicon/" .. Ship.New({
		configId = arg_3_1.icon
	}):getPrefab(), function(arg_4_0)
		self.uiIcon.sprite = arg_4_0

		return
	end)

	local var_3_0 = arg_3_1:isOnline()

	setActive(self.uiOnlineTf, var_3_0)
	setActive(self.uiOfflineTf, not var_3_0)

	if not var_3_0 then
		setText(self.uiOfflineText, getOfflineTimeStamp(arg_3_1.preOnLineTime))
	else
		setText(self.uiOnlineText, i18n("island_btn_label_online"))
	end

	setText(self.uiInviteText, i18n("island_btn_label_invitation"))
	setText(self.uiCancelText, i18n("island_btn_label_invitation_already"))
	onButton(self, self.uiInviteBtn, function()
		self:emit(PlayRoomInfoInviteMediator.ON_CLICK_INVITE, {
			id = arg_3_1.id
		})

		return
	end, SFX_PANEL)

	local var_3_1 = getProxy(PlayRoomProxy):GetInviteRecordByID(arg_3_1.id)

	setActive(self.uiInviteBtn, var_3_1 == nil)
	setActive(self.uiCancelBtn, var_3_1 ~= nil)

	return
end

function PlayRoomInfoInviteItem:willExit()
	self:detach()

	return
end

return PlayRoomInfoInviteItem

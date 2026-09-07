local Dorm3dInsCharPage = class("Dorm3dInsCharPage", import("view.base.BaseEventLogic"))

function Dorm3dInsCharPage:Ctor(arg_1_1, arg_1_2)
	pg.DelegateInfo.New(self)
	Dorm3dInsCharPage.super.Ctor(self, arg_1_2)

	self.tf = arg_1_1
	self.go = arg_1_1.gameObject

	self:Init()

	return
end

function Dorm3dInsCharPage:Init()
	eachChild(self.tf:Find("info"), function(arg_3_0)
		setText(arg_3_0:Find("label"), i18n("dorm3d_privatechat_" .. arg_3_0.name))

		self[arg_3_0.name .. "Content"] = arg_3_0:Find("val")

		return
	end)

	self.name = self.tf:Find("name/Text")
	self.avatar = self.tf:Find("avatar/img")
	self.desc = self.tf:Find("invite/desc")

	setText(self.tf:Find("invite/hint/Text"), i18n("dorm3d_privatechat_room_character"))

	self.inviteListContainer = self.tf:Find("invite/list")
	self.inviteItemList = UIItemList.New(self.inviteListContainer, self.inviteListContainer:Find("tpl"))

	self.inviteItemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			self:UpdateInvite(arg_4_1, arg_4_2)
		end

		return
	end)

	return
end

function Dorm3dInsCharPage:Flush(arg_5_1)
	self.data = arg_5_1
	self.charIds, self.unlockIds, self.roomIds = arg_5_1:GetWelcomeCharList()

	setText(self.name, arg_5_1:GetConfig("room"))
	GetImageSpriteFromAtlasAsync(arg_5_1:GetCard(), "", self.avatar, true)
	setText(self.welcomeContent, #self.unlockIds)
	setText(self.desc, arg_5_1:GetDesc())
	self.inviteItemList:align(#self.charIds)

	return
end

function Dorm3dInsCharPage:UpdateInvite(arg_6_1, arg_6_2)
	local var_6_0 = self.charIds[arg_6_1 + 1]
	local var_6_1 = not table.contains(self.unlockIds, self.charIds[arg_6_1 + 1])

	GetImageSpriteFromAtlasAsync(getProxy(Dorm3dInsProxy):GetRoomById(self.roomIds[arg_6_1 + 1]):GetIcon(), "", arg_6_2:Find("mask/icon"))
	setActive(arg_6_2:Find("lock"), var_6_1)
	onButton(self, arg_6_2, function()
		if not var_6_1 then
			return
		end

		if not self.data:IsDownloaded() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_privatechat_room_unlock"))

			return
		end

		if not pg.NewStoryMgr.GetInstance():IsPlayed("DORM3D_GUIDE_06") then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_privatechat_room_guide"))

			return
		end

		self:emit(Dorm3dInsMainMediator.OPEN_ROOM_UNLOCK_WINDOW, self.data.id, var_6_0)

		return
	end)

	return
end

function Dorm3dInsCharPage:Show()
	setActive(self.tf, true)

	return
end

function Dorm3dInsCharPage:Hide()
	setActive(self.tf, false)

	return
end

function Dorm3dInsCharPage:Destroy()
	pg.DelegateInfo.Dispose(self)

	return
end

return Dorm3dInsCharPage

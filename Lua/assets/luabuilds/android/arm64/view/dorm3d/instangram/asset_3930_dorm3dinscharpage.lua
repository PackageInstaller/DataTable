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
	eachChild(self.tf:Find("entrance"), function(arg_3_0)
		self[arg_3_0.name .. "Btn"] = arg_3_0
		self[arg_3_0.name .. "Content"] = arg_3_0:Find("content")
		self[arg_3_0.name .. "Tip"] = arg_3_0:Find("tip")

		setText(arg_3_0:Find("label"), i18n("dorm3d_privatechat_" .. arg_3_0.name))

		return
	end)
	onButton(self, self.insBtn, function()
		self:emit(Dorm3dInsMainLayer.OPEN_INS)

		return
	end, SFX_PANEL)
	onButton(self, self.chatBtn, function()
		self:emit(Dorm3dInsMainLayer.OPEN_CHAT)

		return
	end, SFX_PANEL)
	onButton(self, self.phoneBtn, function()
		self:emit(Dorm3dInsMainLayer.OPEN_PHONE)

		return
	end, SFX_PANEL)

	self.name = self.tf:Find("name/Text")
	self.avatar = self.tf:Find("avatar/mask/img")
	self.likeBtn = self.tf:Find("avatar/like_bottom")
	self.like = self.likeBtn:Find("like")

	onButton(self, self.likeBtn, function()
		if not self.data:IsDownloaded() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_privatechat_room_unlock"))

			return
		end

		setActive(self.like, not self.data:IsCare())
		self.data:SetCare(self.data:IsCare() and 0 or 1)
		self:emit(Dorm3dInsMainLayer.FLUSH_LEFT)

		return
	end)
	eachChild(self.tf:Find("info"), function(arg_8_0)
		setText(arg_8_0:Find("label"), i18n("dorm3d_privatechat_" .. arg_8_0.name))

		self[arg_8_0.name .. "Content"] = arg_8_0:Find("val")

		return
	end)
	setText(self.tf:Find("block/Text"), i18n("secretary_closed"))
	setActive(self.tf:Find("entrance/phone"), not DORM_LOCK_INS_PHONE)
	setActive(self.tf:Find("block"), DORM_LOCK_INS_PHONE)

	return
end

function Dorm3dInsCharPage:Flush(arg_9_1)
	self.data = arg_9_1

	setText(self.name, arg_9_1:GetName())
	GetImageSpriteFromAtlasAsync(arg_9_1:GetCard(), "", self.avatar, true)
	setText(self.favorContent, arg_9_1:GetFavorLevel())
	setText(self.furnitureContent, arg_9_1:GetFurnitureNum())
	setText(self.visitContent, arg_9_1:GetLastVisit())
	setText(self.giftContent, arg_9_1:GetGiftNum())

	local function var_9_0(arg_10_0, arg_10_1, arg_10_2)
		setActive(self[arg_10_0 .. "Tip"], arg_10_1)
		setText(self[arg_10_0 .. "Content"], arg_10_1 and setColorStr(arg_10_2, "#32a6e8") or arg_10_2)

		return
	end

	var_9_0("ins", arg_9_1:GetInsContent())
	var_9_0("chat", arg_9_1:GetChatContent())
	var_9_0("phone", arg_9_1:GetPhoneContent())
	setActive(self.like, arg_9_1:IsCare())

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

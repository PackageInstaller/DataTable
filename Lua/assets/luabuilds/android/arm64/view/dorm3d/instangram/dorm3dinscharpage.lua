local var_0_0 = class("Dorm3dInsCharPage", import("view.base.BaseEventLogic"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg.DelegateInfo.New(arg_1_0)
	var_0_0.super.Ctor(arg_1_0, arg_1_2)

	arg_1_0.tf = arg_1_1
	arg_1_0.go = arg_1_1.gameObject

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	eachChild(arg_2_0.tf:Find("entrance"), function(arg_3_0)
		arg_2_0[arg_3_0.name .. "Btn"] = arg_3_0
		arg_2_0[arg_3_0.name .. "Content"] = arg_3_0:Find("content")
		arg_2_0[arg_3_0.name .. "Tip"] = arg_3_0:Find("tip")

		setText(arg_3_0:Find("label"), i18n("dorm3d_privatechat_" .. arg_3_0.name))

		return
	end)
	onButton(arg_2_0, arg_2_0.insBtn, function()
		arg_2_0:emit(Dorm3dInsMainLayer.OPEN_INS)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.chatBtn, function()
		arg_2_0:emit(Dorm3dInsMainLayer.OPEN_CHAT)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.phoneBtn, function()
		arg_2_0:emit(Dorm3dInsMainLayer.OPEN_PHONE)

		return
	end, SFX_PANEL)

	arg_2_0.name = arg_2_0.tf:Find("name/Text")
	arg_2_0.avatar = arg_2_0.tf:Find("avatar/mask/img")
	arg_2_0.likeBtn = arg_2_0.tf:Find("avatar/like_bottom")
	arg_2_0.like = arg_2_0.likeBtn:Find("like")

	onButton(arg_2_0, arg_2_0.likeBtn, function()
		if not arg_2_0.data:IsDownloaded() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_privatechat_room_unlock"))

			return
		end

		setActive(arg_2_0.like, not arg_2_0.data:IsCare())
		arg_2_0.data:SetCare(arg_2_0.data:IsCare() and 0 or 1)
		arg_2_0:emit(Dorm3dInsMainLayer.FLUSH_LEFT)

		return
	end)
	eachChild(arg_2_0.tf:Find("info"), function(arg_8_0)
		setText(arg_8_0:Find("label"), i18n("dorm3d_privatechat_" .. arg_8_0.name))

		arg_2_0[arg_8_0.name .. "Content"] = arg_8_0:Find("val")

		return
	end)
	setText(arg_2_0.tf:Find("block/Text"), i18n("secretary_closed"))
	setActive(arg_2_0.tf:Find("entrance/phone"), not DORM_LOCK_INS_PHONE)
	setActive(arg_2_0.tf:Find("block"), DORM_LOCK_INS_PHONE)

	return
end

function var_0_0.Flush(arg_9_0, arg_9_1)
	arg_9_0.data = arg_9_1

	setText(arg_9_0.name, arg_9_1:GetName())
	GetImageSpriteFromAtlasAsync(arg_9_1:GetCard(), "", arg_9_0.avatar, true)
	setText(arg_9_0.favorContent, arg_9_1:GetFavorLevel())
	setText(arg_9_0.furnitureContent, arg_9_1:GetFurnitureNum())
	setText(arg_9_0.visitContent, arg_9_1:GetLastVisit())
	setText(arg_9_0.giftContent, arg_9_1:GetGiftNum())
	;(function(arg_10_0, arg_10_1, arg_10_2)
		setActive(arg_9_0[arg_10_0 .. "Tip"], arg_10_1)

		local var_10_0 = arg_10_1 and setColorStr(arg_10_2, "#32a6e8") or arg_10_2

		setText(arg_9_0[arg_10_0 .. "Content"], var_10_0)

		return
	end)("ins", arg_9_1:GetInsContent())
	;(function(arg_10_0, arg_10_1, arg_10_2)
		setActive(arg_9_0[arg_10_0 .. "Tip"], arg_10_1)

		local var_10_0 = arg_10_1 and setColorStr(arg_10_2, "#32a6e8") or arg_10_2

		setText(arg_9_0[arg_10_0 .. "Content"], var_10_0)

		return
	end)("chat", arg_9_1:GetChatContent())
	;(function(arg_10_0, arg_10_1, arg_10_2)
		setActive(arg_9_0[arg_10_0 .. "Tip"], arg_10_1)

		local var_10_0 = arg_10_1 and setColorStr(arg_10_2, "#32a6e8") or arg_10_2

		setText(arg_9_0[arg_10_0 .. "Content"], var_10_0)

		return
	end)("phone", arg_9_1:GetPhoneContent())
	setActive(arg_9_0.like, arg_9_1:IsCare())

	return
end

function var_0_0.Show(arg_11_0)
	setActive(arg_11_0.tf, true)

	return
end

function var_0_0.Hide(arg_12_0)
	setActive(arg_12_0.tf, false)

	return
end

function var_0_0.Destroy(arg_13_0)
	pg.DelegateInfo.Dispose(arg_13_0)

	return
end

return var_0_0

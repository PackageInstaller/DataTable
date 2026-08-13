class = var_0_10000

local var_0_0 = "Dorm3dInsCharPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseEventLogic"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_1_0)
	var_0_1.super.Ctor(arg_1_0, arg_1_2)

	arg_1_0.tf = arg_1_1
	arg_1_0.go = arg_1_1.gameObject

	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	eachChild = var_1_10001

	local var_2_0 = arg_2_0.tf

	var_1_10001(var_2.Find(var_2_0, "entrance"), function(arg_3_0)
		local var_3_0 = arg_3_0.name

		arg_2_0[var_3_0 .. "Btn"] = arg_3_0
		arg_2_0[var_3_0 .. "Content"] = arg_3_0:Find("content")

		local var_3_1 = arg_2_0

		var_3_1[var_3_0 .. "Tip"] = arg_3_0:Find("tip")
		setText = var_3_1

		local var_3_2 = arg_3_0
		local var_3_3 = arg_3_0.Find(var_3_2, "label")

		i18n = var_3_2

		var_3_1(var_3_3, var_3_2("dorm3d_privatechat_" .. var_3_0))

		return
	end)

	onButton = var_1_10001

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.insBtn

	local function var_2_3()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		Dorm3dInsMainLayer = var_2_10002

		var_4_1(var_4_0, var_2_10002.OPEN_INS)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_1, var_2_2, var_2_3, var_1_10005)

	onButton = var_1_10001

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.chatBtn

	local function var_2_6()
		local var_5_0 = arg_2_0
		local var_5_1 = var_0.emit

		Dorm3dInsMainLayer = var_2_10002

		var_5_1(var_5_0, var_2_10002.OPEN_CHAT)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_4, var_2_5, var_2_6, var_1_10005)

	onButton = var_1_10001

	local var_2_7 = arg_2_0
	local var_2_8 = arg_2_0.phoneBtn

	local function var_2_9()
		local var_6_0 = arg_2_0
		local var_6_1 = var_0.emit

		Dorm3dInsMainLayer = var_2_10002

		var_6_1(var_6_0, var_2_10002.OPEN_PHONE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_7, var_2_8, var_2_9, var_1_10005)

	local var_2_10 = arg_2_0.tf

	arg_2_0.name = var_1.Find(var_2_10, "name/Text")

	local var_2_11 = arg_2_0.tf

	arg_2_0.avatar = var_1.Find(var_2_11, "avatar/mask/img")

	local var_2_12 = arg_2_0.tf

	arg_2_0.likeBtn = var_1.Find(var_2_12, "avatar/like_bottom")

	local var_2_13 = arg_2_0.likeBtn

	arg_2_0.like = var_1.Find(var_2_13, "like")
	onButton = var_1

	var_1(arg_2_0, arg_2_0.likeBtn, function()
		local var_7_0 = arg_2_0.data
		local var_7_2

		if not var_0.IsDownloaded(var_7_0) then
			pg = var_7_2

			local var_7_1 = var_7_2.TipsMgr.GetInstance()

			var_7_2 = var_7_2.ShowTips
			i18n = var_2_10002

			var_7_2(var_7_1, var_2_10002("dorm3d_privatechat_room_unlock"))

			return
		end

		setActive = var_7_2

		local var_7_3 = arg_2_0.like
		local var_7_4 = arg_2_0.data

		var_7_2(var_7_3, not var_2.IsCare(var_7_4))

		local var_7_5 = arg_2_0.data
		local var_7_6 = var_0.SetCare
		local var_7_7 = arg_2_0.data

		var_7_6(var_7_5, var_2.IsCare(var_7_7) and 0 or 1)

		local var_7_8 = arg_2_0
		local var_7_9 = var_0.emit

		Dorm3dInsMainLayer = var_2

		var_7_9(var_7_8, var_2.FLUSH_LEFT)

		return
	end)

	eachChild = var_1

	local var_2_14 = arg_2_0.tf

	var_1(var_2.Find(var_2_14, "info"), function(arg_8_0)
		local var_8_0 = arg_8_0.name

		setText = var_2_10002

		local var_8_1 = arg_8_0
		local var_8_2 = arg_8_0.Find(var_8_1, "label")

		i18n = var_8_1

		var_2_10002(var_8_2, var_8_1("dorm3d_privatechat_" .. var_8_0))

		arg_2_0[var_8_0 .. "Content"] = arg_8_0:Find("val")

		return
	end)

	setText = var_1

	local var_2_15 = arg_2_0.tf
	local var_2_16 = var_2.Find(var_2_15, "block/Text")

	i18n = var_2_15

	var_1(var_2_16, var_2_15("secretary_closed"))

	setActive = var_1

	local var_2_17 = arg_2_0.tf
	local var_2_18 = var_2.Find(var_2_17, "entrance/phone")

	DORM_LOCK_INS_PHONE = var_2_17

	var_1(var_2_18, not var_2_17)

	setActive = var_1

	local var_2_19 = arg_2_0.tf
	local var_2_20 = var_2.Find(var_2_19, "block")

	DORM_LOCK_INS_PHONE = var_2_19

	var_1(var_2_20, var_2_19)

	return
end

function var_0_1.Flush(arg_9_0, arg_9_1)
	arg_9_0.data = arg_9_1
	setText = var_1_10002

	var_1_10002(arg_9_0.name, arg_9_1:GetName())

	GetImageSpriteFromAtlasAsync = var_1_10002

	var_1_10002(arg_9_1:GetCard(), "", arg_9_0.avatar, true)

	setText = var_1_10002

	var_1_10002(arg_9_0.favorContent, arg_9_1:GetFavorLevel())

	setText = var_1_10002

	var_1_10002(arg_9_0.furnitureContent, arg_9_1:GetFurnitureNum())

	setText = var_1_10002

	var_1_10002(arg_9_0.visitContent, arg_9_1:GetLastVisit())

	setText = var_1_10002

	var_1_10002(arg_9_0.giftContent, arg_9_1:GetGiftNum())
	;(function(arg_10_0, arg_10_1, arg_10_2)
		setActive = var_2_10003

		var_2_10003(arg_9_0[arg_10_0 .. "Tip"], arg_10_1)

		setText = var_2_10003

		local var_10_0 = arg_9_0[arg_10_0 .. "Content"]

		if arg_10_1 then
			setColorStr = var_5

			local var_10_1

			if not var_5(arg_10_2, "#32a6e8") then
				var_10_1 = arg_10_2
			end

			var_2_10003(var_10_0, var_10_1)

			return
		end
	end)("ins", arg_9_1:GetInsContent())
	var_2("chat", arg_9_1:GetChatContent())
	var_2("phone", arg_9_1:GetPhoneContent())

	setActive = var_3

	var_3(arg_9_0.like, arg_9_1:IsCare())

	return
end

function var_0_1.Show(arg_11_0)
	setActive = var_1_10001

	var_1_10001(arg_11_0.tf, true)

	return
end

function var_0_1.Hide(arg_12_0)
	setActive = var_1_10001

	var_1_10001(arg_12_0.tf, false)

	return
end

function var_0_1.Destroy(arg_13_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_13_0)

	return
end

return var_0_1

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

	var_1_10001(var_2.Find(var_2_0, "info"), function(arg_3_0)
		local var_3_0 = arg_3_0.name

		setText = var_2_10002

		local var_3_1 = arg_3_0
		local var_3_2 = arg_3_0.Find(var_3_1, "label")

		i18n = var_3_1

		var_2_10002(var_3_2, var_3_1("dorm3d_privatechat_" .. var_3_0))

		arg_2_0[var_3_0 .. "Content"] = arg_3_0:Find("val")

		return
	end)

	local var_2_1 = arg_2_0.tf

	arg_2_0.name = var_1.Find(var_2_1, "name/Text")

	local var_2_2 = arg_2_0.tf

	arg_2_0.avatar = var_1.Find(var_2_2, "avatar/img")

	local var_2_3 = arg_2_0.tf

	arg_2_0.desc = var_1.Find(var_2_3, "invite/desc")
	setText = var_1

	local var_2_4 = arg_2_0.tf
	local var_2_5 = var_2.Find(var_2_4, "invite/hint/Text")

	i18n = var_2_4

	var_1(var_2_5, var_2_4("dorm3d_privatechat_room_character"))

	local var_2_6 = arg_2_0.tf

	arg_2_0.inviteListContainer = var_1.Find(var_2_6, "invite/list")
	UIItemList = var_1

	local var_2_7 = var_1.New
	local var_2_8 = arg_2_0.inviteListContainer
	local var_2_9 = arg_2_0.inviteListContainer

	arg_2_0.inviteItemList = var_2_7(var_2_8, var_3.Find(var_2_9, "tpl"))

	local var_2_10 = arg_2_0.inviteItemList

	var_1.make(var_2_10, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_2_0

			var_3.UpdateInvite(var_4_0, arg_4_1, arg_4_2)
		end

		return
	end)

	return
end

function var_0_1.Flush(arg_5_0, arg_5_1)
	arg_5_0.data = arg_5_1

	local var_5_0, var_5_1, var_5_2 = arg_5_1:GetWelcomeCharList()

	arg_5_0.roomIds = var_5_2
	arg_5_0.unlockIds = var_5_1
	arg_5_0.charIds = var_5_0
	setText = var_5_0

	var_5_0(arg_5_0.name, arg_5_1:GetConfig("room"))

	GetImageSpriteFromAtlasAsync = var_5_0

	var_5_0(arg_5_1:GetCard(), "", arg_5_0.avatar, true)

	setText = var_5_0

	var_5_0(arg_5_0.welcomeContent, #arg_5_0.unlockIds)

	setText = var_5_0

	var_5_0(arg_5_0.desc, arg_5_1:GetDesc())

	local var_5_3 = arg_5_0.inviteItemList

	var_2.align(var_5_3, #arg_5_0.charIds)

	return
end

function var_0_1.UpdateInvite(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.charIds[arg_6_1 + 1]
	local var_6_1 = arg_6_0.roomIds[arg_6_1 + 1]

	getProxy = var_5
	Dorm3dInsProxy = var_1_10006

	local var_6_2 = var_5(var_1_10006)
	local var_6_3 = var_5.GetRoomById(var_6_2, var_6_1)
	local var_6_4 = var_5.GetIcon(var_6_3)

	table = var_6_3

	local var_6_5 = not var_6_3.contains(arg_6_0.unlockIds, var_6_0)

	GetImageSpriteFromAtlasAsync = var_7

	var_7(var_6_4, "", arg_6_2:Find("mask/icon"))

	setActive = var_7

	var_7(arg_6_2:Find("lock"), var_6_5)

	onButton = var_7

	var_7(arg_6_0, arg_6_2, function()
		if not var_6_5 then
			return
		end

		local var_7_0 = arg_6_0.data
		local var_7_2

		if not var_0.IsDownloaded(var_7_0) then
			pg = var_7_2

			local var_7_1 = var_7_2.TipsMgr.GetInstance()

			var_7_2 = var_7_2.ShowTips
			i18n = var_2_10002

			var_7_2(var_7_1, var_2_10002("dorm3d_privatechat_room_unlock"))

			return
		end

		pg = var_7_2

		local var_7_3 = var_7_2.NewStoryMgr.GetInstance()

		if not var_0.IsPlayed(var_7_3, "DORM3D_GUIDE_06") then
			pg = var_0

			local var_7_4 = var_0.TipsMgr.GetInstance()
			local var_7_5 = var_0.ShowTips

			i18n = var_2

			var_7_5(var_7_4, var_2("dorm3d_privatechat_room_guide"))

			return
		end

		local var_7_6 = arg_6_0
		local var_7_7 = var_0.emit

		Dorm3dInsMainMediator = var_2

		var_7_7(var_7_6, var_2.OPEN_ROOM_UNLOCK_WINDOW, arg_6_0.data.id, var_6_0)

		return
	end)

	return
end

function var_0_1.Show(arg_8_0)
	setActive = var_1_10001

	var_1_10001(arg_8_0.tf, true)

	return
end

function var_0_1.Hide(arg_9_0)
	setActive = var_1_10001

	var_1_10001(arg_9_0.tf, false)

	return
end

function var_0_1.Destroy(arg_10_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_10_0)

	return
end

return var_0_1

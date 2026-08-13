class = var_0_10000

local var_0_0 = "MailMgrWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "MailMgrMsgboxUI"
end

function var_0_1.OnInit(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_4.Find(var_2_1, "bg")

	local function var_2_3()
		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end

	SFX_PANEL = var_2_1

	var_1_10001(var_2_0, var_2_2, var_2_3, var_2_1)

	local var_2_4 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_4, "window/top/btnBack")
	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.closeBtn

	local function var_2_7()
		local var_4_0 = arg_2_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_2_1

	var_1(var_2_5, var_2_6, var_2_7, var_2_1)

	local var_2_8 = arg_2_0._tf

	arg_2_0.readBtn = var_1.Find(var_2_8, "window/button_container/btn_read")
	onButton = var_1

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.readBtn

	local function var_2_11()
		local var_5_0 = arg_2_0
		local var_5_1 = var_0.emit

		MailMediator = var_2_10003

		local var_5_2 = var_2_10003.ON_OPERATION
		local var_5_3 = {
			cmd = "read"
		}
		local var_5_4 = arg_2_0

		var_5_3.filter = var_5.GetFilterData(var_5_4)

		var_5_1(var_5_0, var_5_2, var_5_3)

		return
	end

	SFX_CONFIRM = var_2_1

	var_1(var_2_9, var_2_10, var_2_11, var_2_1)

	local var_2_12 = arg_2_0._tf

	arg_2_0.attachBtn = var_1.Find(var_2_12, "window/button_container/btn_get")
	onButton = var_1

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0.attachBtn

	local function var_2_15()
		local var_6_0 = arg_2_0
		local var_6_1 = var_0.emit

		MailMediator = var_2_10003

		local var_6_2 = var_2_10003.ON_OPERATION
		local var_6_3 = {
			cmd = "attachment"
		}
		local var_6_4 = arg_2_0

		var_6_3.filter = var_5.GetFilterData(var_6_4)

		var_6_1(var_6_0, var_6_2, var_6_3)

		return
	end

	SFX_CONFIRM = var_2_1

	var_1(var_2_13, var_2_14, var_2_15, var_2_1)

	local var_2_16 = arg_2_0._tf

	arg_2_0.deleteBtn = var_1.Find(var_2_16, "window/button_container/btn_delete")
	onButton = var_1

	local var_2_17 = arg_2_0
	local var_2_18 = arg_2_0.deleteBtn

	local function var_2_19()
		seriesAsync = var_2_10000

		var_2_10000({
			function(arg_8_0)
				pg = var_3_10001

				local var_8_0 = var_3_10001.m02
				local var_8_1 = var_1.sendNotification

				GAME = var_3_10004

				local var_8_2 = var_3_10004.MAIL_DOUBLE_CONFIREMATION_MSGBOX
				local var_8_3 = {}

				MailProxy = var_3_10006
				var_8_3.type = var_3_10006.MailMessageBoxType.ShowTips
				i18n = var_6
				var_8_3.content = var_6("main_mailLayer_quest_clear_choice")
				var_8_3.onYes = arg_8_0

				var_8_1(var_8_0, var_8_2, var_8_3)

				return
			end
		}, function()
			local var_9_0 = arg_2_0
			local var_9_1 = var_0.emit

			MailMediator = var_3_10003

			local var_9_2 = var_3_10003.ON_OPERATION
			local var_9_3 = {
				cmd = "delete"
			}
			local var_9_4 = arg_2_0

			var_9_3.filter = var_5.GetFilterData(var_9_4)

			var_9_1(var_9_0, var_9_2, var_9_3)

			return
		end)

		return
	end

	SFX_CONFIRM = var_2_1

	var_1(var_2_17, var_2_18, var_2_19, var_2_1)

	local var_2_20 = {}

	pairs = var_1_10002

	local var_2_21 = {}

	DROP_TYPE_RESOURCE = var_2_19

	local var_2_22 = {}

	PlayerConst = var_7
	var_2_22[1] = var_7.ResGold
	PlayerConst = var_7
	var_2_22[2] = var_7.ResOil
	PlayerConst = var_7
	var_2_22[3] = var_7.ResExploit
	PlayerConst = var_7
	var_2_22[4] = var_7.ResDiamond
	var_2_21[var_2_19] = var_2_22
	DROP_TYPE_ITEM = var_2_19

	local var_2_23 = {}

	ITEM_ID_CUBE = var_7
	var_2_23[1] = var_7
	var_2_21[var_2_19] = var_2_23

	for iter_2_0, iter_2_1 in var_1_10002(var_2_21) do
		ipairs = var_7

		for iter_2_2, iter_2_3 in var_7(iter_2_1) do
			table = var_1_10012
			var_1_10012 = var_1_10012.insert

			local var_2_24 = var_2_20

			Drop = var_1_10015

			var_1_10012(var_2_24, var_1_10015.New({
				type = iter_2_0,
				id = iter_2_3
			}))
		end
	end

	MailWaterSelect = var_2

	if var_2 then
		table = var_2

		local var_2_25 = var_2.insert
		local var_2_26 = var_2_20

		Drop = iter_2_0

		local var_2_27 = iter_2_0.New
		local var_2_28 = {
			id = 50002
		}

		DROP_TYPE_ITEM = var_1_10008
		var_2_28.type = var_1_10008

		var_2_25(var_2_26, var_2_27(var_2_28))
	end

	arg_2_0.filterDic = {}

	local var_2_29 = arg_2_0._tf

	arg_2_0.rtContent = var_2.Find(var_2_29, "window/frame/toggle_group/filter/content")
	UIItemList = var_2

	local var_2_30 = var_2.StaticAlign
	local var_2_31 = arg_2_0.rtContent
	local var_2_32 = arg_2_0.rtContent

	var_2_30(var_2_31, var_5.Find(var_2_32, "toggle_tpl"), #var_2_20, function(arg_10_0, arg_10_1, arg_10_2)
		arg_10_1 = arg_10_1 + 1
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = var_2_20[arg_10_1]

			GetImageSpriteFromAtlasAsync = var_2_10004

			var_2_10004(var_10_0:getIcon(), "", arg_10_2:Find("Image"))

			onToggle = var_2_10004

			local var_10_1 = arg_2_0
			local var_10_2 = arg_10_2

			local function var_10_3(arg_11_0)
				local var_11_0 = arg_2_0.filterDic

				var_11_0[var_10_0.type .. "_" .. var_10_0.id] = arg_11_0

				if arg_11_0 then
					triggerToggle = var_11_0

					local var_11_1 = arg_2_0._tf

					var_11_0(var_3.Find(var_11_1, "window/frame/toggle_group/filter"), true)
				end

				return
			end

			SFX_PANEL = var_2_10009

			var_2_10004(var_10_1, var_10_2, var_10_3, var_2_10009)
		end

		return
	end)

	eachChild = var_2_30

	local var_2_33 = arg_2_0._tf

	var_2_30(var_4.Find(var_2_33, "window/frame/toggle_group"), function(arg_12_0)
		onToggle = var_2_10001

		local var_12_0 = arg_2_0
		local var_12_1 = arg_12_0

		local function var_12_2(arg_13_0)
			if arg_13_0 then
				arg_2_0.filterType = arg_12_0.name

				if arg_2_0.filterType == "all" then
					eachChild = var_1

					var_1(arg_2_0.rtContent, function(arg_14_0)
						triggerToggle = var_4_10001

						var_4_10001(arg_14_0, false)

						return
					end)
				end
			end

			return
		end

		SFX_PANEL = var_2_10006

		var_2_10001(var_12_0, var_12_1, var_12_2, var_2_10006)

		return
	end)

	setText = var_2_30

	local var_2_34 = arg_2_0._tf
	local var_2_35 = var_4.Find(var_2_34, "window/top/bg/infomation/title")

	i18n = var_5

	var_2_30(var_2_35, var_5("mail_manager_title"))

	setText = var_2_30

	local var_2_36 = arg_2_0._tf
	local var_2_37 = var_4.Find(var_2_36, "window/frame/tip/Text")

	i18n = var_5

	var_2_30(var_2_37, var_5("mail_manage_tip_1"))

	setText = var_2_30

	local var_2_38 = arg_2_0._tf
	local var_2_39 = var_4.Find(var_2_38, "window/frame/tip_1/Text")

	i18n = var_5

	var_2_30(var_2_39, var_5("mail_manager_tips_2"))

	setText = var_2_30

	local var_2_40 = arg_2_0._tf
	local var_2_41 = var_4.Find(var_2_40, "window/frame/toggle_group/all/Text")

	i18n = var_5

	var_2_30(var_2_41, var_5("mail_manage_1"))

	setText = var_2_30

	local var_2_42 = arg_2_0._tf
	local var_2_43 = var_4.Find(var_2_42, "window/frame/toggle_group/filter/Text")

	i18n = var_5

	var_2_30(var_2_43, var_5("mail_manage_2"))

	setText = var_2_30

	local var_2_44 = arg_2_0.attachBtn
	local var_2_45 = var_4.Find(var_2_44, "Text")

	i18n = var_5

	var_2_30(var_2_45, var_5("mail_get_oneclick"))

	setText = var_2_30

	local var_2_46 = arg_2_0.readBtn
	local var_2_47 = var_4.Find(var_2_46, "Text")

	i18n = var_5

	var_2_30(var_2_47, var_5("mail_read_oneclick"))

	setText = var_2_30

	local var_2_48 = arg_2_0.deleteBtn
	local var_2_49 = var_4.Find(var_2_48, "Text")

	i18n = var_5

	var_2_30(var_2_49, var_5("mail_delete_oneclick"))

	return
end

function var_0_1.GetFilterData(arg_15_0)
	switch = var_1_10001

	return var_1_10001(arg_15_0.filterType, {
		all = function()
			return {
				type = "all"
			}
		end,
		filter = function()
			local var_17_0 = {}

			pairs = var_2_10001

			for iter_17_0, iter_17_1 in var_2_10001(arg_15_0.filterDic) do
				if iter_17_1 then
					unpack = var_2_10006
					string = var_2_10008

					local var_17_1

					var_2_10006, var_17_1 = var_2_10006(var_2_10008.split(iter_17_0, "_"))
					table = var_2_10008
					var_2_10008 = var_2_10008.insert

					local var_17_2 = var_17_0

					Drop = var_11

					local var_17_3 = var_11.New
					local var_17_4 = {}

					tonumber = var_2_10014
					var_17_4.type = var_2_10014(var_2_10006)
					tonumber = var_2_10014
					var_17_4.id = var_2_10014(var_17_1)

					var_2_10008(var_17_2, var_17_3(var_17_4))
				end
			end

			return {
				type = "drops",
				list = var_17_0
			}
		end
	}, function()
		assert = var_2_10000

		var_2_10000(false)

		return
	end)
end

function var_0_1.Show(arg_19_0, arg_19_1)
	var_0_1.super.Show(arg_19_0)

	pg = var_2

	local var_19_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_19_0, arg_19_0._tf)

	triggerToggle = var_2

	local var_19_1 = arg_19_0._tf

	var_2(var_4.Find(var_19_1, "window/frame/toggle_group/all"), true)

	return
end

function var_0_1.Hide(arg_20_0)
	pg = var_1_10001

	local var_20_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_20_0, arg_20_0._tf, arg_20_0._parentTf)
	var_0_1.super.Hide(arg_20_0)

	return
end

function var_0_1.OnDestroy(arg_21_0)
	if arg_21_0:isShowing() then
		arg_21_0:Hide()
	end

	return
end

return var_0_1

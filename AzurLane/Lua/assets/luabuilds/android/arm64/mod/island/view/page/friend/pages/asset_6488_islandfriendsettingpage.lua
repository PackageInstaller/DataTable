class = var_0_10000

local var_0_0 = "IslandFriendSettingPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandFriendAccessUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.toggle = var_1.Find(var_2_0, "frame/toggle")

	local var_2_1 = arg_2_0._tf

	arg_2_0.friendToggle = var_1.Find(var_2_1, "frame/on_panel/friend")

	local var_2_2 = arg_2_0._tf

	arg_2_0.guildToggle = var_1.Find(var_2_2, "frame/on_panel/guild")

	local var_2_3 = arg_2_0._tf

	arg_2_0.codeToggle = var_1.Find(var_2_3, "frame/on_panel/code")

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "frame/code_panel/id/Text")
	local var_2_6 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.codeTxt = var_2_6(var_2_5, var_4(var_1_10006))

	local var_2_7 = arg_2_0._tf

	arg_2_0.codeMask = var_1.Find(var_2_7, "frame/code_panel/mask")

	local var_2_8 = arg_2_0._tf

	arg_2_0.codeRefreshBtn = var_1.Find(var_2_8, "frame/code_panel/refresh")

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_1.Find(var_2_9, "frame/code_panel/refresh/Text")
	local var_2_11 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.codeRefreshTxt = var_2_11(var_2_10, var_4(var_1_10006))

	local var_2_12 = arg_2_0._tf

	arg_2_0.codeCopyBtn = var_1.Find(var_2_12, "frame/code_panel/copy")

	local var_2_13 = arg_2_0._tf

	arg_2_0.tipBtn = var_1.Find(var_2_13, "frame/tip")
	setText = var_1

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_3.Find(var_2_14, "frame/title/Text")

	i18n = var_4

	var_1(var_2_15, var_4("island_open_settings"))

	setText = var_1

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_3.Find(var_2_16, "frame/on_panel/friend/Text")

	i18n = var_4

	var_1(var_2_17, var_4("island_friend"))

	setText = var_1

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_3.Find(var_2_18, "frame/on_panel/guild/Text")

	i18n = var_4

	var_1(var_2_19, var_4("island_guild"))

	setText = var_1

	local var_2_20 = arg_2_0._tf
	local var_2_21 = var_3.Find(var_2_20, "frame/on_panel/code/Text")

	i18n = var_4

	var_1(var_2_21, var_4("island_code"))

	setText = var_1

	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_3.Find(var_2_22, "frame/on_tip/Text")

	i18n = var_4

	var_1(var_2_23, var_4("island_open_settings_tip1"))

	setText = var_1

	local var_2_24 = arg_2_0._tf
	local var_2_25 = var_3.Find(var_2_24, "frame/off_tip/Text")

	i18n = var_4

	var_1(var_2_25, var_4("island_open_settings_tip2"))

	setText = var_1

	local var_2_26 = arg_2_0._tf
	local var_2_27 = var_3.Find(var_2_26, "frame/code_panel/copy/Text")

	i18n = var_4

	var_1(var_2_27, var_4("island_btn_label_copy"))

	setText = var_1

	local var_2_28 = arg_2_0._tf
	local var_2_29 = var_3.Find(var_2_28, "frame/toggle/on/Text")

	i18n = var_4

	var_1(var_2_29, var_4("island_visit_on"))

	setText = var_1

	local var_2_30 = arg_2_0._tf
	local var_2_31 = var_3.Find(var_2_30, "frame/toggle/off/Text_1")

	i18n = var_4

	var_1(var_2_31, var_4("island_visit_on"))

	setText = var_1

	local var_2_32 = arg_2_0._tf
	local var_2_33 = var_3.Find(var_2_32, "frame/toggle/on/Text_2")

	i18n = var_4

	var_1(var_2_33, var_4("island_visit_off"))

	setText = var_1

	local var_2_34 = arg_2_0._tf
	local var_2_35 = var_3.Find(var_2_34, "frame/toggle/off/Text")

	i18n = var_4

	var_1(var_2_35, var_4("island_visit_off"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.codeRefreshBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		IslandMediator = var_2_10003

		var_4_1(var_4_0, var_2_10003.REFRESH_INVITECODE, false)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.tipBtn

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		IslandFriendPage = var_2_10003

		local var_5_2 = var_2_10003.EVENT_MSG

		i18n = var_2_10004

		var_5_1(var_5_0, var_5_2, var_2_10004("island_open_settings_tip3"))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.codeCopyBtn

	local function var_3_8()
		UniPasteBoard = var_2_10000

		var_2_10000.SetClipBoardString(arg_3_0.inviteCode)

		pg = var_0

		local var_6_0 = var_0.TipsMgr.GetInstance()
		local var_6_1 = var_0.ShowTips

		i18n = var_2_10003

		var_6_1(var_6_0, var_2_10003("friend_id_copy_ok"))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	return
end

function var_0_1.OnRefreshInviteCode(arg_7_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_7_0 = var_1_10001(var_1_10003)
	local var_7_1 = var_1.GetIsland(var_7_0)
	local var_7_2 = var_1.GetAccessAgency(var_7_1)

	arg_7_0.inviteCode = var_1.GetInviteCode(var_7_2)

	arg_7_0:InitInviteCode(true)
	arg_7_0:UpdateRefreshBtn()

	return
end

function var_0_1.Show(arg_8_0)
	var_0_1.super.Show(arg_8_0)

	getProxy = var_1
	IslandProxy = var_3

	local var_8_0 = var_1(var_3)
	local var_8_1 = var_1.GetIsland(var_8_0)
	local var_8_2 = var_1.GetAccessAgency(var_8_1)

	arg_8_0.openFlags = var_1.GetOpenFlag(var_8_2)
	arg_8_0.inviteCode = var_1:GetInviteCode()

	arg_8_0:InitToggles()

	return
end

function var_0_1.InitInviteCode(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0.codeTxt.text = arg_9_0.inviteCode
	else
		arg_9_0.codeTxt.text = ""
	end

	return
end

function var_0_1.InitToggles(arg_10_0)
	triggerToggle = var_1_10001

	local var_10_0 = arg_10_0.toggle

	table = var_1_10004

	local var_10_1 = var_1_10004.contains
	local var_10_2 = arg_10_0.openFlags

	IslandConst = var_1_10007

	var_1_10001(var_10_0, var_10_1(var_10_2, var_1_10007.OPEN_ALL))

	triggerToggle = var_1_10001

	local var_10_3 = arg_10_0.friendToggle

	table = var_4

	local var_10_4 = var_4.contains
	local var_10_5 = arg_10_0.openFlags

	IslandConst = var_7

	var_1_10001(var_10_3, not var_10_4(var_10_5, var_7.OPEN_FRIEND))

	triggerToggle = var_1_10001

	local var_10_6 = arg_10_0.guildToggle

	table = var_4

	local var_10_7 = var_4.contains
	local var_10_8 = arg_10_0.openFlags

	IslandConst = var_7

	var_1_10001(var_10_6, not var_10_7(var_10_8, var_7.OPEN_GUILD))

	triggerToggle = var_1_10001

	local var_10_9 = arg_10_0.codeToggle

	table = var_4

	local var_10_10 = var_4.contains
	local var_10_11 = arg_10_0.openFlags

	IslandConst = var_7

	var_1_10001(var_10_9, var_10_10(var_10_11, var_7.OPEN_CODE))

	local var_10_12 = arg_10_0
	local var_10_13 = arg_10_0.InitCodePanenl

	table = var_4

	local var_10_14 = var_4.contains
	local var_10_15 = arg_10_0.openFlags

	IslandConst = var_7

	var_10_13(var_10_12, var_10_14(var_10_15, var_7.OPEN_CODE))

	onToggle = var_10_13

	var_10_13(arg_10_0, arg_10_0.toggle, function(arg_11_0)
		if arg_11_0 then
			table = var_2_10001
			var_2_10001 = var_2_10001.insert

			local var_11_0 = arg_10_0.openFlags

			IslandConst = var_2_10004

			var_2_10001(var_11_0, var_2_10004.OPEN_ALL)

			local var_11_1 = arg_10_0

			var_2_10001.Send(var_11_1)
		else
			table = var_2_10001

			local var_11_2 = var_2_10001.removebyvalue
			local var_11_3 = arg_10_0.openFlags

			IslandConst = var_2_10004

			var_11_2(var_11_3, var_2_10004.OPEN_ALL)

			local var_11_4 = arg_10_0

			var_1.Send(var_11_4)
		end

		return
	end)

	onToggle = var_10_13

	local var_10_16 = arg_10_0
	local var_10_17 = arg_10_0.friendToggle

	local function var_10_18(arg_12_0)
		if arg_12_0 then
			table = var_2_10001
			var_2_10001 = var_2_10001.removebyvalue

			local var_12_0 = arg_10_0.openFlags

			IslandConst = var_2_10004

			var_2_10001(var_12_0, var_2_10004.OPEN_FRIEND)
		else
			table = var_2_10001

			local var_12_1 = var_2_10001.insert
			local var_12_2 = arg_10_0.openFlags

			IslandConst = var_2_10004

			var_12_1(var_12_2, var_2_10004.OPEN_FRIEND)
		end

		local var_12_3 = arg_10_0

		var_1.Send(var_12_3)

		return
	end

	SFX_PANEL = var_10_15

	var_10_13(var_10_16, var_10_17, var_10_18, var_10_15)

	onToggle = var_10_13

	local var_10_19 = arg_10_0
	local var_10_20 = arg_10_0.guildToggle

	local function var_10_21(arg_13_0)
		if arg_13_0 then
			table = var_2_10001
			var_2_10001 = var_2_10001.removebyvalue

			local var_13_0 = arg_10_0.openFlags

			IslandConst = var_2_10004

			var_2_10001(var_13_0, var_2_10004.OPEN_GUILD)
		else
			table = var_2_10001

			local var_13_1 = var_2_10001.insert
			local var_13_2 = arg_10_0.openFlags

			IslandConst = var_2_10004

			var_13_1(var_13_2, var_2_10004.OPEN_GUILD)
		end

		local var_13_3 = arg_10_0

		var_1.Send(var_13_3)

		return
	end

	SFX_PANEL = var_10_15

	var_10_13(var_10_19, var_10_20, var_10_21, var_10_15)

	onToggle = var_10_13

	local var_10_22 = arg_10_0
	local var_10_23 = arg_10_0.codeToggle

	local function var_10_24(arg_14_0)
		if arg_14_0 then
			table = var_2_10001
			var_2_10001 = var_2_10001.insert

			local var_14_0 = arg_10_0.openFlags

			IslandConst = var_2_10004

			var_2_10001(var_14_0, var_2_10004.OPEN_CODE)

			if not arg_10_0.inviteCode or arg_10_0.inviteCode == "" then
				local var_14_1 = arg_10_0

				var_2_10001 = var_2_10001.emit
				IslandMediator = var_2_10004

				var_2_10001(var_14_1, var_2_10004.REFRESH_INVITECODE, true)
			end
		else
			table = var_2_10001

			local var_14_2 = var_2_10001.removebyvalue
			local var_14_3 = arg_10_0.openFlags

			IslandConst = var_2_10004

			var_14_2(var_14_3, var_2_10004.OPEN_CODE)
		end

		local var_14_4 = arg_10_0

		var_1.InitCodePanenl(var_14_4, arg_14_0)

		local var_14_5 = arg_10_0

		var_1.Send(var_14_5)

		return
	end

	SFX_PANEL = var_10_15

	var_10_13(var_10_22, var_10_23, var_10_24, var_10_15)
	arg_10_0:UpdateRefreshBtn()

	return
end

function var_0_1.UpdateRefreshBtn(arg_15_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_15_0 = var_1_10001(var_1_10003)
	local var_15_1 = var_1.GetIsland(var_15_0)
	local var_15_2 = var_1.GetAccessAgency(var_15_1)
	local var_15_3 = var_1.isFreshInviteCode(var_15_2) and "0" or "1"
	local var_15_4 = arg_15_0.codeRefreshTxt

	i18n = var_15_2
	var_15_4.text = var_15_2("island_code_refresh_cnt", var_15_3)

	return
end

function var_0_1.InitCodePanenl(arg_16_0, arg_16_1)
	setActive = var_1_10002

	var_1_10002(arg_16_0.codeMask, not arg_16_1)
	arg_16_0:InitInviteCode(arg_16_1)

	return
end

function var_0_1.Send(arg_17_0)
	local var_17_0 = {}
	local var_17_1 = {}

	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_17_2 = var_1_10003(var_1_10005)
	local var_17_3 = var_3.GetIsland(var_17_2)
	local var_17_4 = var_3.GetAccessAgency(var_17_3)
	local var_17_5 = var_3.GetOpenFlag(var_17_4)
	local var_17_6 = arg_17_0.openFlags

	ipairs = var_17_4

	for iter_17_0, iter_17_1 in var_17_4(var_17_6) do
		table = var_1_10011

		if not var_1_10011.contains(var_17_5, iter_17_1) then
			table = var_1_10011

			var_1_10011.insert(var_17_0, iter_17_1)
		end
	end

	ipairs = var_6

	for iter_17_2, iter_17_3 in var_6(var_17_5) do
		table = var_1_10011

		if not var_1_10011.contains(var_17_6, iter_17_3) then
			table = var_1_10011

			var_1_10011.insert(var_17_1, iter_17_3)
		end
	end

	if #var_17_0 > 0 or #var_17_1 > 0 then
		local var_17_7 = arg_17_0
		local var_17_8 = arg_17_0.emit

		IslandMediator = iter_17_2

		var_17_8(var_17_7, iter_17_2.SET_ACCESS_FLAG, var_17_0, var_17_1)
	end

	return
end

function var_0_1.Hide(arg_18_0)
	var_0_1.super.Hide(arg_18_0)

	removeOnToggle = var_1

	var_1(arg_18_0.toggle)

	removeOnToggle = var_1

	var_1(arg_18_0.friendToggle)

	removeOnToggle = var_1

	var_1(arg_18_0.guildToggle)

	removeOnToggle = var_1

	var_1(arg_18_0.codeToggle)

	return
end

function var_0_1.OnDestroy(arg_19_0)
	if arg_19_0:isShowing() then
		arg_19_0:Hide()
	end

	return
end

return var_0_1

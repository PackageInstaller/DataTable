class = var_0_10000

local var_0_0 = "SSSSMedalCollectionView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..TemplateMV.MedalCollectionTemplateView"))
local var_0_2 = {
	"qvzhu",
	"qingxvn",
	"zhongxvn",
	"zhanlie",
	"hangmu",
	"jinghua"
}

var_0_1.INDEX_CONVERT = {
	1,
	4,
	3,
	5,
	6,
	2
}

function var_0_1.getUIName(arg_1_0)
	return "SSSSMedalCollectionUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:FindUI()

	AutoLoader = var_1
	arg_2_0.loader = var_1.New()

	return
end

function var_0_1.FindUI(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "Top")

	arg_3_0.backBtn = var_1.Find(var_3_1, "BackBtn")
	arg_3_0.helpBtn = var_1:Find("HelpBtn")
	arg_3_0.progressText = var_1:Find("ProgressText")
	arg_3_0.slots = {}

	for iter_3_0 = 1, 6 do
		local var_3_2 = arg_3_0.slots
		local var_3_3 = {}
		local var_3_4 = arg_3_0._tf

		var_3_3.char = var_8.Find(var_3_4, "Desk/Slot" .. iter_3_0 .. "/Char")

		local var_3_5 = arg_3_0._tf

		var_3_3.point = var_8.Find(var_3_5, "Desk/Slot" .. iter_3_0 .. "/Point")

		local var_3_6 = arg_3_0._tf

		var_3_3.pointEffect = var_8.Find(var_3_6, "Desk/Slot" .. iter_3_0 .. "/Dengguang")

		local var_3_7 = arg_3_0._tf

		var_3_3.selected = var_8.Find(var_3_7, "Desk/Slot" .. iter_3_0 .. "/Selected")

		local var_3_8 = arg_3_0._tf

		var_3_3.saoguang = var_8.Find(var_3_8, "Desk/Slot" .. iter_3_0 .. "/Saoguang")
		var_3_2[iter_3_0] = var_3_3
	end

	local var_3_9 = arg_3_0._tf

	arg_3_0.medalTF = var_2.Find(var_3_9, "Desk/Slot8")

	local var_3_10 = arg_3_0._tf

	arg_3_0.infoArea1 = var_2.Find(var_3_10, "Desk/Info/Area1")

	local var_3_11 = arg_3_0._tf

	arg_3_0.infoArea2 = var_2.Find(var_3_11, "Desk/Info/Area2")

	local var_3_12 = arg_3_0.infoArea1

	arg_3_0.infoIcon = var_2.Find(var_3_12, "Unlock/Icon")

	return
end

function var_0_1.didEnter(arg_4_0)
	var_0_1.super.didEnter(arg_4_0)
	arg_4_0:AddListener()

	local var_4_0 = arg_4_0.contextData
	local var_4_1

	if not arg_4_0.contextData.GKIndex then
		var_4_1 = 1
	end

	var_4_0.GKIndex = var_4_1

	arg_4_0:UpdateView()

	return
end

function var_0_1.AddListener(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.backBtn

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0.closeView(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10006)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.helpBtn

	local function var_5_5()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_7_2.type = var_2_10004
		pg = var_2_10004
		var_7_2.helps = var_2_10004.gametip.ssss_medal_tip.tip

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10006)

	onButton = var_1_10001

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.infoArea1

	local function var_5_8()
		local var_8_0 = var_0_1.INDEX_CONVERT[arg_5_0.contextData.GKIndex]
		local var_8_1 = arg_5_0.allIDList[2 * var_8_0 - 1]

		table = var_2

		local var_8_2

		if not var_2.contains(arg_5_0.activeIDList, var_8_1) then
			table = var_2_10003
			var_8_2 = var_2_10003.contains(arg_5_0.activatableIDList, var_8_1)
		else
			var_8_2 = false
		end

		if false then
			var_8_2 = true
		end

		if var_8_2 then
			local var_8_3 = arg_5_0
			local var_8_4 = var_4.emit

			MedalCollectionTemplateMediator = var_2_10007

			var_8_4(var_8_3, var_2_10007.MEMORYBOOK_UNLOCK, {
				id = var_8_1,
				actId = arg_5_0.activityData.id
			})
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_6, var_5_7, var_5_8, var_1_10006)

	onButton = var_1_10001

	local var_5_9 = arg_5_0
	local var_5_10 = arg_5_0.infoArea2

	local function var_5_11()
		local var_9_0 = var_0_1.INDEX_CONVERT[arg_5_0.contextData.GKIndex]
		local var_9_1 = arg_5_0.allIDList[2 * var_9_0]

		table = var_2

		local var_9_2

		if not var_2.contains(arg_5_0.activeIDList, var_9_1) then
			table = var_2_10003
			var_9_2 = var_2_10003.contains(arg_5_0.activatableIDList, var_9_1)
		else
			var_9_2 = false
		end

		if false then
			var_9_2 = true
		end

		if var_9_2 then
			local var_9_3 = arg_5_0
			local var_9_4 = var_4.emit

			MedalCollectionTemplateMediator = var_2_10007

			var_9_4(var_9_3, var_2_10007.MEMORYBOOK_UNLOCK, {
				id = var_9_1,
				actId = arg_5_0.activityData.id
			})
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_9, var_5_10, var_5_11, var_1_10006)

	for iter_5_0 = 1, 6 do
		onButton = var_5_11

		local var_5_12 = arg_5_0
		local var_5_13 = arg_5_0._tf
		local var_5_14 = var_8.Find(var_5_13, "Desk/Slot" .. iter_5_0 .. "/Click")

		local function var_5_15()
			arg_5_0.contextData.GKIndex = iter_5_0

			local var_10_0 = arg_5_0

			var_0.UpdateView(var_10_0)

			return
		end

		SFX_PANEL = var_5_13

		var_5_11(var_5_12, var_5_14, var_5_15, var_5_13)
	end

	return
end

function var_0_1.UpdateAfterSubmit(arg_11_0, arg_11_1)
	var_0_1.super.UpdateAfterSubmit(arg_11_0, arg_11_1)

	table = var_2

	local var_11_0 = var_2.indexof(arg_11_0.allIDList, arg_11_1)

	math = var_1_10003

	local var_11_1 = var_1_10003.floor((var_11_0 + 1) / 2)

	table = var_3

	local var_11_2 = var_3.indexof(var_0_1.INDEX_CONVERT, var_11_1)

	SetCompomentEnabled = var_3

	local var_11_3 = arg_11_0.slots[var_11_2].char

	typeof = var_6
	Image = var_1_10008

	var_3(var_11_3, var_6(var_1_10008), false)
	arg_11_0:UpdateView()

	setActive = var_3

	var_3(arg_11_0.slots[var_11_2].saoguang, false)

	setActive = var_3

	var_3(arg_11_0.slots[var_11_2].saoguang, true)

	return
end

function var_0_1.UpdateAfterFinalMedal(arg_12_0)
	var_0_1.super.UpdateAfterFinalMedal(arg_12_0)
	arg_12_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_13_0)
	for iter_13_0 = 1, 6 do
		local var_13_0 = 0
		local var_13_1 = false
		local var_13_2 = var_0_1.INDEX_CONVERT[iter_13_0]

		_ = var_1_10008

		var_1_10008.each({
			arg_13_0.allIDList[2 * var_13_2 - 1],
			arg_13_0.allIDList[2 * var_13_2]
		}, function(arg_14_0)
			table = var_2_10001

			if var_2_10001.contains(arg_13_0.activeIDList, arg_14_0) then
				var_13_0 = var_13_0 + 1
			else
				table = var_1

				if var_1.contains(arg_13_0.activatableIDList, arg_14_0) then
					var_13_1 = true
				end
			end

			return
		end)

		local var_13_3 = arg_13_0.loader

		var_1_10008.GetSpriteQuiet(var_13_3, "ui/SSSSMedalCollectionUI_atlas", var_13_0 == 2 and "point_green" or "point_red", arg_13_0.slots[iter_13_0].point)

		SetCompomentEnabled = var_1_10008

		local var_13_4 = arg_13_0.slots[iter_13_0].point

		typeof = var_11
		Animator = var_13

		var_1_10008(var_13_4, var_11(var_13), false)

		setActive = var_1_10008

		var_1_10008(arg_13_0.slots[iter_13_0].pointEffect, var_13_1)

		if not var_13_1 then
			setImageColor = var_1_10008

			local var_13_5 = arg_13_0.slots[iter_13_0].point

			Color = var_11

			var_1_10008(var_13_5, var_11(1, 1, 1))
		end

		setActive = var_1_10008

		var_1_10008(arg_13_0.slots[iter_13_0].char, var_13_0 ~= 0)

		if var_13_0 == 1 then
			local var_13_6 = arg_13_0.loader

			var_1_10008.GetSpriteQuiet(var_13_6, "ui/SSSSMedalCollectionUI_atlas", "baimo_" .. var_0_2[var_13_2], arg_13_0.slots[iter_13_0].char)
		elseif var_13_0 == 2 then
			local var_13_7 = arg_13_0.loader

			var_1_10008.GetSpriteQuiet(var_13_7, "ui/SSSSMedalCollectionUI_atlas", "wancheng_" .. var_0_2[var_13_2], arg_13_0.slots[iter_13_0].char)
		end

		setActive = var_1_10008

		var_1_10008(arg_13_0.slots[iter_13_0].selected, iter_13_0 == arg_13_0.contextData.GKIndex)
	end

	local var_13_8 = #arg_13_0.activeIDList == #arg_13_0.allIDList and arg_13_0.activityData.data1 == 1

	setActive = var_2

	local var_13_9 = arg_13_0.medalTF

	var_2(var_4.Find(var_13_9, "Lock"), not var_13_8)

	setActive = var_2

	local var_13_10 = arg_13_0.medalTF

	var_2(var_4.Find(var_13_10, "Unlock"), var_13_8)
	arg_13_0:UpdateInfo()

	setText = var_2

	local var_13_11 = arg_13_0.progressText

	i18n = var_5

	var_2(var_13_11, var_5("ssssmedal_tip", #arg_13_0.activeIDList))

	return
end

function var_0_1.UpdateInfo(arg_15_0)
	local var_15_0 = var_0_1.INDEX_CONVERT[arg_15_0.contextData.GKIndex]

	;(function()
		local var_16_0 = arg_15_0.allIDList[2 * var_15_0 - 1]

		table = var_1

		local var_16_1

		if not var_1.contains(arg_15_0.activeIDList, var_16_0) then
			table = var_2_10002
			var_16_1 = var_2_10002.contains(arg_15_0.activatableIDList, var_16_0)
		else
			var_16_1 = false
		end

		if false then
			var_16_1 = true
		end

		local var_16_2 = not var_1 and not var_16_1
		local var_16_3 = arg_15_0.infoArea1

		setActive = var_2_10005

		var_2_10005(var_16_3:Find("Lock"), var_16_2)

		setActive = var_2_10005

		var_2_10005(var_16_3:Find("Unlockable"), var_16_1)

		setActive = var_2_10005

		var_2_10005(var_16_3:Find("Unlock"), var_1)

		if var_1 then
			setText = var_2_10005

			local var_16_4 = var_16_3
			local var_16_5 = var_16_3.Find(var_16_4, "Unlock/TextName")

			i18n = var_8

			local var_16_6 = var_8("ssssmedal_name")

			i18n = var_16_4

			var_2_10005(var_16_5, var_16_6 .. var_16_4("ssssmedal_name" .. var_15_0))

			i18n = var_2_10005

			local var_16_7 = var_2_10005("ssssmedal_belonging")

			i18n = var_2_10006

			local var_16_8 = var_16_7 .. var_2_10006("ssssmedal_belonging" .. (var_15_0 == 6 and 2 or 1))

			setText = var_2_10006

			var_2_10006(var_16_3:Find("Unlock/TextDetail"), var_16_8)

			local var_16_9 = arg_15_0.loader

			var_2_10006.GetSpriteQuiet(var_16_9, "ui/SSSSMedalCollectionUI_atlas", "icon_" .. var_0_2[var_15_0], arg_15_0.infoIcon)
		elseif var_16_2 then
			local var_16_10 = arg_15_0.activityData
			local var_16_11 = var_5.getConfig(var_16_10, "config_client").unlock_desc

			setText = var_2_10006

			var_2_10006(var_16_3:Find("Lock/BG/TextTip"), var_16_11[2 * var_15_0 - 1])
		end

		return
	end)()
	;(function()
		local var_17_0 = arg_15_0.allIDList[2 * var_15_0]

		table = var_1

		local var_17_1

		if not var_1.contains(arg_15_0.activeIDList, var_17_0) then
			table = var_2_10002
			var_17_1 = var_2_10002.contains(arg_15_0.activatableIDList, var_17_0)
		else
			var_17_1 = false
		end

		if false then
			var_17_1 = true
		end

		local var_17_2 = not var_1 and not var_17_1
		local var_17_3 = arg_15_0.infoArea2

		setActive = var_2_10005

		var_2_10005(var_17_3:Find("Lock"), var_17_2)

		setActive = var_2_10005

		var_2_10005(var_17_3:Find("Unlockable"), var_17_1)

		setActive = var_2_10005

		var_2_10005(var_17_3:Find("Unlock"), var_1)

		if var_1 then
			setText = var_2_10005

			local var_17_4 = var_17_3:Find("Unlock")

			i18n = var_8

			var_2_10005(var_17_4, var_8("ssssmedal_desc" .. var_15_0))
		elseif var_17_2 then
			local var_17_5 = arg_15_0.activityData
			local var_17_6 = var_5.getConfig(var_17_5, "config_client").unlock_desc

			setText = var_2_10006

			var_2_10006(var_17_3:Find("Lock"), var_17_6[2 * var_15_0])
		end

		return
	end)()

	return
end

function var_0_1.willExit(arg_18_0)
	local var_18_0 = arg_18_0.loader

	var_1.Clear(var_18_0)

	return
end

return var_0_1

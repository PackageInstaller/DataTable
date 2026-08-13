class = var_0_10000

local var_0_0 = "ToloveCollectPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.LinkCollectTemplatePage"))

var_0_1.SKIP_TYPE_MINIGAME = 7

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)
	arg_1_0:findUI()

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)
	arg_2_0:rewriteEquipSkinBtn()

	return
end

function var_0_1.findUI(arg_3_0)
	setImageRaycastTarget = var_1_10001

	local var_3_0 = arg_3_0.content

	var_1_10001(var_2.Find(var_3_0, "tpl/Frame"), false)

	local var_3_1 = arg_3_0._tf

	arg_3_0.boxTF = var_1.Find(var_3_1, "Box")

	local var_3_2 = arg_3_0.boxTF

	arg_3_0.boxBG = var_1.Find(var_3_2, "BG")

	local var_3_3 = arg_3_0.boxTF

	arg_3_0.panel = var_1.Find(var_3_3, "Panel")

	local var_3_4 = arg_3_0.panel

	arg_3_0.infoTF = var_1.Find(var_3_4, "Info")

	local var_3_5 = arg_3_0.infoTF

	arg_3_0.boxCloseBtn = var_1.Find(var_3_5, "CloseBtn")

	local var_3_6 = arg_3_0.infoTF

	arg_3_0.boxIconTF = var_1.Find(var_3_6, "Icon/Mask/IconTpl")

	local var_3_7 = arg_3_0.infoTF

	arg_3_0.boxNameText = var_1.Find(var_3_7, "NameText")

	local var_3_8 = arg_3_0.infoTF

	arg_3_0.boxNumTF = var_1.Find(var_3_8, "Num")

	local var_3_9 = arg_3_0.boxNumTF

	arg_3_0.boxNumTip = var_1.Find(var_3_9, "Text")

	local var_3_10 = arg_3_0.boxNumTF

	arg_3_0.boxNumText = var_1.Find(var_3_10, "NumText")

	local var_3_11 = arg_3_0.infoTF

	arg_3_0.boxDescText = var_1.Find(var_3_11, "DescText")

	local var_3_12 = arg_3_0.infoTF

	arg_3_0.boxSrcText = var_1.Find(var_3_12, "SrcText")
	onButton = var_1

	local var_3_13 = arg_3_0
	local var_3_14 = arg_3_0.boxBG

	local function var_3_15()
		local var_4_0 = arg_3_0

		var_0.showBoxPanel(var_4_0, false)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_13, var_3_14, var_3_15, var_1_10005)

	onButton = var_1

	local var_3_16 = arg_3_0
	local var_3_17 = arg_3_0.boxCloseBtn

	local function var_3_18()
		local var_5_0 = arg_3_0

		var_0.showBoxPanel(var_5_0, false)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_16, var_3_17, var_3_18, var_1_10005)

	local var_3_19 = arg_3_0.panel

	arg_3_0.boxSrcContent = var_1.Find(var_3_19, "Content")

	local var_3_20 = arg_3_0.boxSrcContent

	arg_3_0.boxSrcTpl = var_1.Find(var_3_20, "SrcTpl")
	GetComponent = var_1

	local var_3_21 = arg_3_0.btnList
	local var_3_22 = var_1(var_2.Find(var_3_21, "furniture_theme/Title"), "Image")

	var_1.SetNativeSize(var_3_22)

	GetComponent = var_1

	local var_3_23 = arg_3_0.btnList
	local var_3_24 = var_1(var_2.Find(var_3_23, "equip_skin_box/Title"), "Image")

	var_1.SetNativeSize(var_3_24)

	GetComponent = var_1

	local var_3_25 = arg_3_0.btnList
	local var_3_26 = var_1(var_2.Find(var_3_25, "medal/Title"), "Image")

	var_1.SetNativeSize(var_3_26)

	return
end

function var_0_1.rewriteEquipSkinBtn(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.equipSkinBoxBtn

	local function var_6_2()
		local var_7_0 = arg_6_0.activity
		local var_7_1 = var_0.getConfig(var_7_0, "config_client")

		Drop = var_7_0

		local var_7_2 = var_7_0.New({
			type = var_7_1.equipskin_box_link.drop_type,
			id = var_7_1.equipskin_box_link.drop_id
		})
		local var_7_3 = var_1.getOwnedCount(var_7_2)
		local var_7_4 = {}

		MSGBOX_TYPE_LIKN_COLLECT_GUIDE = var_3
		var_7_4.type = var_3
		Msgbox4LinkCollectGuide = var_3
		var_7_4.show_type = var_3.SHOW_TYPE_NORMAL
		var_7_4.drop_type = var_7_1.equipskin_box_link.drop_type
		var_7_4.drop_id = var_7_1.equipskin_box_link.drop_id
		var_7_4.count = var_7_3
		var_7_4.skipable_list = var_7_1.equipskin_box_link.list

		local var_7_5 = arg_6_0

		var_3.updateBoxPanel(var_7_5, var_7_4)

		local var_7_6 = arg_6_0

		var_3.showBoxPanel(var_7_6, true)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10005)

	return
end

function var_0_1.updateBoxPanel(arg_8_0, arg_8_1)
	Drop = var_1_10002

	local var_8_0 = var_1_10002.New({
		type = arg_8_1.drop_type,
		id = arg_8_1.drop_id
	})

	updateDrop = var_3

	var_3(arg_8_0.boxIconTF, var_8_0)

	local var_8_1 = var_8_0.cfg

	changeToScrollText = var_4

	var_4(arg_8_0.boxNameText, var_8_1.name)

	setText = var_4

	local var_8_2 = arg_8_0.boxDescText

	SwitchSpecialChar = var_6

	var_4(var_8_2, var_6(var_8_0.desc))

	setText = var_4

	local var_8_3 = arg_8_0.boxNumTip

	i18n = var_6

	var_4(var_8_3, var_6("word_own1"))

	local var_8_4 = arg_8_1.show_type

	Msgbox4LinkCollectGuide = var_8_3

	if var_8_4 == var_8_3.SHOW_TYPE_NORMAL then
		setText = var_8_4

		var_8_4(arg_8_0.boxNumText, arg_8_1.count)
	else
		var_8_4 = arg_8_1.show_type
		Msgbox4LinkCollectGuide = var_5

		if var_8_4 == var_5.SHOW_TYPE_LIMIT then
			setText = var_8_4

			local var_8_5 = arg_8_0.boxNumText
			local var_8_6 = arg_8_1.count
			local var_8_7 = "/"
			local var_8_8

			if not arg_8_1.count_limit then
				var_8_8 = 0
			end

			var_8_4(var_8_5, var_8_6 .. var_8_7 .. var_8_8)
		end
	end

	UIItemList = var_8_4

	var_8_4.StaticAlign(arg_8_0.boxSrcContent, arg_8_0.boxSrcTpl, #arg_8_1.skipable_list, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			local var_9_0 = arg_8_1.skipable_list[arg_9_1 + 1][1]
			local var_9_1 = var_3[2]
			local var_9_2 = var_3[3]

			changeToScrollText = var_2_10007

			var_2_10007(arg_9_2:Find("SrcText"), var_9_2)

			local var_9_3 = arg_9_2
			local var_9_4 = arg_9_2.Find(var_9_3, "GoBtn")

			onButton = var_9_3

			local var_9_5 = arg_8_0
			local var_9_6 = var_9_4

			local function var_9_7()
				local var_10_0 = var_9_0

				Msgbox4LinkCollectGuide = var_3_10001

				local var_10_1

				if var_10_0 == var_3_10001.SKIP_TYPE_SCENE then
					pg = var_10_0
					var_10_1 = var_10_0.m02

					local var_10_2 = var_0.sendNotification

					GAME = var_3_10002
					var_3_10002 = var_3_10002.GO_SCENE
					var_3_10003 = var_9_1[1]

					local var_10_3

					if not var_9_1[2] then
						var_10_3 = {}
					end

					var_10_2(var_10_1, var_3_10002, var_3_10003, var_10_3)
				else
					local var_10_4 = var_9_0

					Msgbox4LinkCollectGuide = var_10_1

					if var_10_4 == var_10_1.SKIP_TYPE_ACTIVITY then
						pg = var_10_4

						local var_10_5 = var_10_4.m02
						local var_10_6 = var_0.sendNotification

						GAME = var_3_10002
						var_3_10002 = var_3_10002.GO_SCENE
						SCENE = var_3_10003

						var_10_6(var_10_5, var_3_10002, var_3_10003.ACTIVITY, {
							id = var_9_1
						})
					elseif var_9_0 == var_0_1.SKIP_TYPE_MINIGAME then
						pg = var_0

						local var_10_7 = var_0.m02
						local var_10_8 = var_0.sendNotification

						GAME = var_3_10002

						var_10_8(var_10_7, var_3_10002.GO_MINI_GAME, var_9_1[1])
					end
				end

				local var_10_9 = arg_8_0

				var_0.showBoxPanel(var_10_9, false)

				return
			end

			SFX_PANEL = var_2_10012

			var_9_3(var_9_5, var_9_6, var_9_7, var_2_10012)

			Canvas = var_9_3

			var_9_3.ForceUpdateCanvases()
		end

		return
	end)

	return
end

function var_0_1.showBoxPanel(arg_11_0, arg_11_1)
	setActive = var_1_10002

	var_1_10002(arg_11_0.boxTF, arg_11_1)

	return
end

function var_0_1.OnUpdateItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.showDataList[arg_12_1 + 1]
	local var_12_1 = arg_12_2:Find("icon_mask/icon")
	local var_12_2 = {
		type = var_12_0.config.type,
		id = var_12_0.config.drop_id
	}

	updateDrop = var_6

	var_6(var_12_1, var_12_2)

	onButton = var_6

	local var_12_3 = arg_12_0
	local var_12_4 = var_12_1

	local function var_12_5()
		local var_13_0 = {}

		MSGBOX_TYPE_LIKN_COLLECT_GUIDE = var_2_10001
		var_13_0.type = var_2_10001
		Msgbox4LinkCollectGuide = var_2_10001
		var_13_0.show_type = var_2_10001.SHOW_TYPE_LIMIT
		var_13_0.drop_type = var_12_0.config.type
		var_13_0.drop_id = var_12_0.config.drop_id
		var_13_0.count = var_12_0.count
		var_13_0.count_limit = var_12_0.config.count
		var_13_0.skipable_list = var_12_0.config.link_params

		local var_13_1 = arg_12_0

		var_1.updateBoxPanel(var_13_1, var_13_0)

		local var_13_2 = arg_12_0

		var_1.showBoxPanel(var_13_2, true)

		return
	end

	SFX_PANEL = var_1_10010

	var_6(var_12_3, var_12_4, var_12_5, var_1_10010)

	changeToScrollText = var_6

	local var_12_6 = arg_12_2
	local var_12_7 = arg_12_2.Find(var_12_6, "name_mask/name")

	Drop = var_12_6

	local var_12_8 = var_12_6.New({
		type = var_12_0.config.type,
		id = var_12_0.config.drop_id
	})

	var_6(var_12_7, var_8.getName(var_12_8))

	setText = var_6

	var_6(arg_12_2:Find("owner/number"), var_12_0.count .. "/" .. var_12_0.config.count)

	GetOrAddComponent = var_6

	local var_12_9 = arg_12_2
	local var_12_10 = arg_12_2.Find(var_12_9, "owner")

	typeof = var_12_9
	CanvasGroup = var_9
	var_6(var_12_10, var_12_9(var_9)).alpha = var_12_0.count == var_12_0.config.count and 0.5 or 1
	setActive = var_7

	var_7(arg_12_2:Find("got"), var_12_0.count == var_12_0.config.count)

	setActive = var_7

	var_7(arg_12_2:Find("new"), var_12_0.config.is_new == "1")

	return
end

return var_0_1

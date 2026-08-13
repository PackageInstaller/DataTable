pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.NewStyleMsgboxMgr = var_0_10001("NewStyleMsgboxMgr")
var_1.TYPE_MSGBOX = 1
var_1.TYPE_DROP = 2
var_1.TYPE_DROP_CLIENT = 3
var_1.TYPE_COMMON_MSGBOX = 4
var_1.TYPE_COMMON_HELP = 5
var_1.TYPE_COMMON_DROP = 6
var_1.TYPE_COMMON_ITEMS = 7
var_1.TYPE_SHIP_PREVIEW = 8
var_1.TYPE_COMMON_SHOPPING = 9
var_1.TYPE_LOVE_LETTER_LEVEL_REWARD = 10
var_1.UI_NAME_DIC = {
	[var_1.TYPE_MSGBOX] = "DormStyleMsgboxUI",
	[var_1.TYPE_DROP] = "DormStyleDropMsgboxUI",
	[var_1.TYPE_DROP_CLIENT] = "DormStyleDropMsgboxUI",
	[var_1.TYPE_COMMON_MSGBOX] = "NewStyleMsgboxUI",
	[var_1.TYPE_COMMON_HELP] = "NewStyleHelpMsgboxUI",
	[var_1.TYPE_COMMON_DROP] = "NewStyleDropMsgboxUI",
	[var_1.TYPE_COMMON_ITEMS] = "NewStyleItemsMsgboxUI",
	[var_1.TYPE_SHIP_PREVIEW] = "ShipPreviewUI",
	[var_1.TYPE_COMMON_SHOPPING] = "NewStyleShoppingMsgboxUI",
	[var_1.TYPE_LOVE_LETTER_LEVEL_REWARD] = "NewStyleLoveLetterRewardMsgboxUI"
}
var_1.BUTTON_TYPE = {
	blue = "btn_confirm",
	shopping = "btn_shopping",
	gray = "btn_cancel",
	confirm = "btn_confirm",
	cancel = "btn_cancel"
}
var_1.RES_LIST = {
	diamond = {
		"ui/commonui_atlas",
		"res_diamond"
	},
	gold = {
		"ui/commonui_atlas",
		"res_gold"
	},
	res_oil = {
		"ui/commonui_atlas",
		"res_oil"
	},
	guildicon = {
		"ui/share/msgbox_atlas",
		"res_guildicon"
	},
	world_money = {
		"ui/share/world_common_atlas",
		"res_Whuobi"
	},
	port_money = {
		"ui/share/world_common_atlas",
		"res_Wzhaungbeibi"
	},
	world_boss = {
		"props/100000",
		""
	}
}
var_1.COLOR_MAP = {
	["#[Ff][Ff][Dd][Ee]38"] = "#ffa944",
	["#92[Ff][Cc]63"] = "#238c40",
	["#6[Dd][Dd]329"] = "#238c40"
}

function var_1.Init(arg_1_0, arg_1_1)
	print = var_1_10002

	var_1_10002("initializing new style msgbox manager...")

	arg_1_0.showList = {}
	arg_1_0.rtDic = {}
	arg_1_0.richTextSprites = {}

	local var_1_0 = {}

	pairs = var_1_10003

	for iter_1_0, iter_1_1 in var_1_10003(var_0.RES_LIST) do
		table = var_1_10008

		var_1_10008.insert(var_1_0, function(arg_2_0)
			LoadSpriteAtlasAsync = var_2_10001

			var_2_10001(iter_1_1[1], iter_1_1[2], function(arg_3_0)
				arg_1_0.richTextSprites[iter_1_0] = arg_3_0

				arg_2_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_1_0, function()
		existCall = var_2_10000

		var_2_10000(arg_1_1)

		return
	end)

	return
end

function var_1.Show(arg_5_0, ...)
	table = var_1_10001

	local var_5_0 = var_1_10001.insert
	local var_5_1 = arg_5_0.showList

	packEx = var_1_10004

	var_5_0(var_5_1, var_1_10004(...))

	if #arg_5_0.showList == 1 then
		local var_5_2 = arg_5_0
		local var_5_3 = arg_5_0.DoShow

		unpackEx = var_4

		var_5_3(var_5_2, var_4(arg_5_0.showList[1]))
	end

	return
end

function var_1.DeepShow(arg_6_0, ...)
	if #arg_6_0.showList == 0 then
		arg_6_0:Show(...)
	else
		table = var_1

		local var_6_0 = var_1.insert
		local var_6_1 = arg_6_0.showList
		local var_6_2 = 1

		packEx = var_1_10005

		var_6_0(var_6_1, var_6_2, var_1_10005(...))
		arg_6_0:Hide(true)
	end

	return
end

function var_1.DoShow(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = {}

	if not arg_7_0.rtDic[arg_7_1] then
		table = var_4

		var_4.insert(var_7_0, function(arg_8_0)
			local var_8_0 = var_0.UIMgr.GetInstance()

			var_1.LoadingOn(var_8_0)

			PoolMgr = var_1

			local var_8_1 = var_1.GetInstance()

			var_1.GetUI(var_8_1, var_0.UI_NAME_DIC[arg_7_1], true, function(arg_9_0)
				setParent = var_3_10001

				var_3_10001(arg_9_0, var_0.UIMgr.GetInstance().OverlayMain, false)

				arg_7_0.rtDic[arg_7_1] = arg_9_0.transform

				local var_9_0 = var_0.UIMgr.GetInstance()

				var_1.LoadingOff(var_9_0)
				arg_8_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_7_0, function()
		arg_7_0._tf = arg_7_0.rtDic[arg_7_1]

		if arg_7_1 == var_0.TYPE_SHIP_PREVIEW then
			var_0.DelegateInfo.New(arg_7_0)
		else
			local var_10_0 = arg_7_0

			var_0.CommonSetting(var_10_0, arg_7_2)
		end

		local var_10_1 = arg_7_0

		var_0.DisplaySetting(var_10_1, arg_7_1, arg_7_2)

		local var_10_2 = var_0.UIMgr.GetInstance()

		var_0.BlurPanel(var_10_2, arg_7_0._tf)

		setActive = var_0

		var_0(arg_7_0._tf, true)

		return
	end)

	return
end

function var_1.Hide(arg_11_0, arg_11_1)
	if arg_11_0.previewer then
		local var_11_0 = arg_11_0.previewer

		var_2.Destroy(var_11_0)

		arg_11_0.previewer = nil

		return
	end

	if not arg_11_0._tf then
		return
	end

	setActive = var_2

	var_2(arg_11_0._tf, false)
	arg_11_0:Clear()

	local var_11_1 = var_0.UIMgr.GetInstance()

	var_2.UnOverlayPanel(var_11_1, arg_11_0._tf, var_0.UIMgr.GetInstance().OverlayMain)

	arg_11_0._tf = nil

	if not arg_11_1 then
		table = var_2

		var_2.remove(arg_11_0.showList, 1)
	end

	if #arg_11_0.showList > 0 then
		local var_11_2 = arg_11_0
		local var_11_3 = arg_11_0.DoShow

		unpackEx = var_5

		var_11_3(var_11_2, var_5(arg_11_0.showList[1]))
	end

	return
end

function var_1.CommonSetting(arg_12_0, arg_12_1)
	var_0.DelegateInfo.New(arg_12_0)

	setText = var_2

	local var_12_0 = arg_12_0._tf
	local var_12_1 = var_4.Find(var_12_0, "window/top/title")
	local var_12_2

	if not arg_12_1.title then
		i18n = var_12_2
		var_12_2 = var_12_2("words_information")
	end

	var_2(var_12_1, var_12_2)

	function arg_12_0.hideCall()
		local var_13_0 = arg_12_0

		var_13_0.hideCall = nil
		existCall = var_13_0

		var_13_0(arg_12_1.onClose)

		return
	end

	onButton = var_2

	local var_12_3 = arg_12_0
	local var_12_4 = arg_12_0._tf
	local var_12_5 = var_5.Find(var_12_4, "bg")

	local function var_12_6()
		existCall = var_2_10000

		var_2_10000(arg_12_0.hideCall)

		local var_14_0 = arg_12_0

		var_0.Hide(var_14_0)

		return
	end

	SFX_CANCEL = var_12_4

	var_2(var_12_3, var_12_5, var_12_6, var_12_4)

	onButton = var_2

	local var_12_7 = arg_12_0
	local var_12_8 = arg_12_0._tf
	local var_12_9 = var_5.Find(var_12_8, "window/top/btn_close")

	local function var_12_10()
		existCall = var_2_10000

		var_2_10000(arg_12_0.hideCall)

		local var_15_0 = arg_12_0

		var_0.Hide(var_15_0)

		return
	end

	SFX_CANCEL = var_12_8

	var_2(var_12_7, var_12_9, var_12_10, var_12_8)

	function arg_12_0.confirmCall()
		local var_16_0 = arg_12_0

		var_16_0.confirmCall = nil
		existCall = var_16_0

		var_16_0(arg_12_1.onConfirm)

		return
	end

	local var_12_11

	if not arg_12_1.btnList then
		var_12_11 = {}

		local var_12_12 = {
			type = var_0.BUTTON_TYPE.cancel
		}

		i18n = var_12_7
		var_12_12.name = var_12_7("msgbox_text_cancel")

		function var_12_12.func()
			existCall = var_2_10000

			var_2_10000(arg_12_0.hideCall)

			return
		end

		SFX_CANCEL = var_12_7
		var_12_12.sound = var_12_7
		var_12_11[1] = var_12_12

		local var_12_13 = {
			type = var_0.BUTTON_TYPE.confirm
		}

		i18n = var_12_7
		var_12_13.name = var_12_7("msgbox_text_confirm")

		function var_12_13.func()
			existCall = var_2_10000

			var_2_10000(arg_12_0.confirmCall)

			return
		end

		SFX_CONFIRM = var_12_7
		var_12_13.sound = var_12_7
		var_12_11[2] = var_12_13
	end

	local var_12_14 = arg_12_0._tf
	local var_12_15 = var_3.Find(var_12_14, "window/bottom/button_container")

	eachChild = var_12_7

	var_12_7(var_12_15, function(arg_19_0)
		setActive = var_2_10001

		var_2_10001(arg_19_0, false)

		return
	end)

	ipairs = var_12_7

	for iter_12_0, iter_12_1 in var_12_7(var_12_11) do
		local var_12_16 = var_12_15:Find(iter_12_1.type)
		local var_12_17

		if var_12_17.GetSiblingIndex(var_12_16) < var_12_15.childCount - iter_12_0 + 1 then
			var_12_17:SetAsLastSibling()

			setActive = var_10

			var_10(var_12_17, true)
		else
			cloneTplTo = var_10
			var_12_17 = var_10(var_12_17, var_12_15, var_12_17.name)
		end

		setText = var_10

		var_10(var_12_17:Find("Text"), iter_12_1.name)

		onButton = var_10

		local var_12_18 = arg_12_0
		local var_12_19 = var_12_17

		local function var_12_20()
			existCall = var_2_10000

			var_2_10000(iter_12_1.func)

			local var_20_0 = arg_12_0

			var_0.Hide(var_20_0)

			return
		end

		if not iter_12_1.sound then
			SFX_CONFIRM = var_15
		end

		var_10(var_12_18, var_12_19, var_12_20, var_15)
	end

	return
end

function var_1.Clear(arg_21_0)
	var_0.DelegateInfo.Dispose(arg_21_0)

	arg_21_0.hideCall = nil
	arg_21_0.confirmCall = nil

	return
end

function var_1.DisplaySetting(arg_22_0, arg_22_1, arg_22_2)
	switch = var_1_10003

	var_1_10003(arg_22_1, {
		[var_0.TYPE_MSGBOX] = function(arg_23_0)
			setText = var_2_10001

			local var_23_0 = arg_22_0._tf

			var_2_10001(var_3.Find(var_23_0, "window/middle/content"), arg_23_0.contentText)

			return
		end,
		[var_0.TYPE_DROP] = function(arg_24_0)
			local var_24_0 = arg_24_0.drop
			local var_24_1 = arg_22_0._tf
			local var_24_2 = var_2.Find(var_24_1, "window/middle")

			updateCustomDrop = var_2_10003

			var_2_10003(var_24_2:Find("Dorm3dIconTpl"), arg_24_0.drop, {
				style = arg_24_0.style
			})

			setText = var_2_10003

			var_2_10003(var_24_2:Find("info/name"), var_24_0:getName())

			setText = var_2_10003

			local var_24_3 = var_24_2:Find("info/scroll/desc")

			cancelColorRich = var_6

			var_2_10003(var_24_3, var_6(var_24_0.desc))

			local var_24_4 = var_24_0
			local var_24_5, var_24_6 = var_24_0.getOwnedCount(var_24_4)

			setActive = var_24_4

			var_24_4(var_24_2:Find("info/count"), var_24_6)

			if var_24_6 then
				setText = var_24_4

				local var_24_7 = var_24_2
				local var_24_8 = var_24_2.Find(var_24_7, "info/count")

				i18n = var_8

				local var_24_9 = var_8("dorm3d_item_num")

				string = var_24_7

				var_24_4(var_24_8, var_24_9 .. var_24_7.format("<color=#39bfff>%d</color>", var_24_5))
			end

			return
		end,
		[var_0.TYPE_DROP_CLIENT] = function(arg_25_0)
			local var_25_0 = arg_22_0._tf
			local var_25_1 = var_1.Find(var_25_0, "window/middle")

			Dorm3dIconHelper = var_2_10002

			var_2_10002.UpdateDorm3dIcon(var_25_1:Find("Dorm3dIconTpl"), arg_25_0.data)

			setActive = var_2

			var_2(var_25_1:Find("info/count"), false)

			setActive = var_2

			var_2(var_25_1:Find("Dorm3dIconTpl/count"), false)

			Dorm3dIconHelper = var_2

			local var_25_2 = var_2.Data2Config(arg_25_0.data)

			setText = var_25_0

			var_25_0(var_25_1:Find("info/name"), var_25_2.name)

			setText = var_25_0

			var_25_0(var_25_1:Find("info/scroll/desc"), var_25_2.desc)

			return
		end,
		[var_0.TYPE_COMMON_MSGBOX] = function(arg_26_0)
			local var_26_0 = arg_22_0._tf
			local var_26_1 = var_1.Find(var_26_0, "window/middle/content")
			local var_26_2 = arg_22_0

			var_2.InitRichText(var_26_2, var_26_1)

			setTextInNewStyleBox = var_2

			var_2(var_26_1, arg_26_0.contentText)

			return
		end,
		[var_0.TYPE_COMMON_HELP] = function(arg_27_0)
			setActive = var_2_10001

			local var_27_0 = arg_22_0._tf

			var_2_10001(var_3.Find(var_27_0, "window/bottom"), false)

			local var_27_1 = arg_22_0._tf
			local var_27_2 = var_1.Find(var_27_1, "window/middle/content")

			UIItemList = var_2_10002

			local var_27_3 = var_2_10002.New(var_27_2, var_27_2:Find("tpl"))

			var_2.make(var_27_3, function(arg_28_0, arg_28_1, arg_28_2)
				arg_28_1 = arg_28_1 + 1
				UIItemList = var_3_10003

				if arg_28_0 == var_3_10003.EventUpdate then
					local var_28_0 = arg_27_0.helps[arg_28_1]

					setActive = var_3_10004

					var_3_10004(arg_28_2:Find("line"), var_28_0.line)

					setTextInNewStyleBox = var_3_10004

					local var_28_1 = arg_28_2:Find("Text")

					HXSet = var_7

					local var_28_2 = var_7.hxLan

					if var_28_0.info then
						SwitchSpecialChar = var_9

						local var_28_3

						if not var_9(var_28_0.info, true) then
							var_28_3 = ""
						end

						var_3_10004(var_28_1, var_28_2(var_28_3))

						return
					end
				end
			end)
			var_2:align(#arg_27_0.helps)

			return
		end,
		[var_0.TYPE_COMMON_DROP] = function(arg_29_0)
			local var_29_0 = arg_29_0.drop
			local var_29_1 = arg_22_0._tf
			local var_29_2 = var_2.Find(var_29_1, "window/middle")

			updateDrop = var_2_10003

			var_2_10003(var_29_2:Find("left/IconTpl"), var_29_0)

			setText = var_2_10003

			var_2_10003(var_29_2:Find("info/name_container/name/Text"), var_29_0:getConfig("name"))

			local var_29_3 = var_29_2
			local var_29_4 = var_29_2.Find(var_29_3, "info/desc/Text")
			local var_29_5 = arg_22_0

			var_4.InitRichText(var_29_5, var_29_4)
			var_29_0:MsgboxIntroSet(arg_29_0, var_29_4)

			setTextInNewStyleBox = var_4

			local var_29_6 = var_29_4
			local var_29_7 = var_29_4
			local var_29_8 = var_29_4.GetComponent

			typeof = var_2_10010
			Text = var_2_10012

			var_4(var_29_6, var_29_8(var_29_7, var_2_10010(var_2_10012)).text)

			UpdateOwnDisplay = var_4

			var_4(var_29_2:Find("left/own"), var_29_0)

			setText = var_4

			local var_29_9 = var_29_2:Find("left/detail/Text")

			i18n = var_7

			var_4(var_29_9, var_7("technology_detail"))

			RegisterNewStyleDetailButton = var_4

			var_4(arg_22_0, var_29_2:Find("left/detail"), var_29_0)

			local var_29_10 = var_29_0.type

			DROP_TYPE_SHIP = var_29_3

			local var_29_11 = var_29_10 == var_29_3
			local var_29_12 = var_29_2
			local var_29_13 = var_29_2.Find(var_29_12, "info/name_container/shiptype")
			local var_29_14 = var_29_2
			local var_29_15 = var_29_2.Find(var_29_14, "extra_info/ship")

			setActive = var_29_12

			var_29_12(var_29_13, var_29_11)

			setActive = var_29_12

			var_29_12(var_29_15, var_29_11)

			local var_29_16

			if var_29_11 then
				GetImageSpriteFromAtlasAsync = var_29_12
				var_29_16 = "shiptype"
				shipType2print = var_10

				var_29_12(var_29_16, var_10(var_29_0:getConfig("type")), var_29_13)

				tobool = var_29_12
				getProxy = var_29_16
				CollectionProxy = var_11

				local var_29_17 = var_29_16(var_11)
				local var_29_18 = var_29_12(var_29_16.getShipGroup(var_29_17, var_0.ship_data_template[var_29_0.id].group_type))

				setActive = var_29_14

				var_29_14(var_29_15:Find("unlock"), var_29_18)

				setText = var_29_14

				local var_29_19 = var_29_15:Find("unlock/Text")

				i18n = var_11

				var_29_14(var_29_19, var_11("tag_ship_unlocked"))

				setActive = var_29_14

				var_29_14(var_29_15:Find("lock"), not var_29_18)

				setText = var_29_14

				local var_29_20 = var_29_15:Find("lock/Text")

				i18n = var_11

				var_29_14(var_29_20, var_11("tag_ship_locked"))
			end

			local var_29_21 = var_29_0.type

			DROP_TYPE_EQUIPMENT_SKIN = var_29_14

			local var_29_22 = var_29_21 == var_29_14
			local var_29_23 = var_29_2
			local var_29_24 = var_29_2.Find(var_29_23, "extra_info/equip_skin")

			setActive = var_29_16

			var_29_16(var_29_24, var_29_22)

			setActive = var_29_16

			var_29_16(var_29_2:Find("left/placeholder"), var_29_22)

			local var_29_26

			if var_29_22 then
				setTextInNewStyleBox = var_29_16

				var_29_16(var_29_2:Find("info/desc/Text"), var_29_0:getConfig("desc"))

				local var_29_25 = var_0.equip_skin_template[var_29_0.id]

				underscore = var_29_23
				var_29_23 = var_29_23.map(var_29_25.equip_type, function(arg_30_0)
					EquipType = var_3_10001

					return var_3_10001.Type2Name2(arg_30_0)
				end)
				table = var_29_26
				var_29_26 = var_29_26.concat(var_29_23, ",")
				setScrollText = var_12

				local var_29_27 = var_29_24:Find("tag/mask/Text")

				i18n = var_15

				var_12(var_29_27, var_15("word_fit") .. ":" .. var_29_26)

				onButton = var_12

				local var_29_28 = arg_22_0
				local var_29_29 = var_29_24
				local var_29_30 = var_29_24.Find(var_29_29, "play")

				local function var_29_31()
					Ship = var_3_10000

					local var_31_0 = var_3_10000.New({
						id = var_29_25.ship_config_id,
						configId = var_29_25.ship_config_id,
						skin_id = var_29_25.ship_skin_id
					})
					local var_31_1 = arg_22_0
					local var_31_2 = var_1.DeepShow
					local var_31_3 = var_0.NewStyleMsgboxMgr.TYPE_SHIP_PREVIEW
					local var_31_4 = {
						shipVO = var_31_0
					}

					if var_29_25.ship_skin_id == 0 then
						Clone = var_6

						local var_31_5

						if not var_6(var_29_25.weapon_ids) then
							var_31_5 = {}
						end

						var_31_4.weaponIds = var_31_5

						local var_31_6

						if var_29_25.ship_skin_id ~= 0 or not var_29_0.id then
							var_31_6 = 0
						end

						var_31_4.equipSkinId = var_31_6

						var_31_2(var_31_1, var_31_3, var_31_4)

						return
					end
				end

				SFX_PANEL = var_29_29

				var_12(var_29_28, var_29_30, var_29_31, var_29_29)
			end

			local var_29_32 = var_29_0.type

			DROP_TYPE_COMBAT_UI_STYLE = var_29_23

			local var_29_33 = var_29_32 == var_29_23
			local var_29_34 = var_29_2:Find("extra_info/combat_skin")

			setActive = var_29_26

			var_29_26(var_29_34, var_29_33)

			setActive = var_29_26

			var_29_26(var_29_2:Find("left/placeholder"), var_29_33)

			if var_29_33 then
				local var_29_35 = var_0.item_data_battleui[var_29_0.id].rare_display

				UIItemList = var_12

				local var_29_36 = var_12.New(var_29_2:Find("extra_info/combat_skin/elementList"), var_29_2:Find("extra_info/combat_skin/elementList/main"))

				var_12.make(var_29_36, function(arg_32_0, arg_32_1, arg_32_2)
					UIItemList = var_3_10003

					if arg_32_0 == var_3_10003.EventUpdate then
						GetImageSpriteFromAtlasAsync = var_3

						local var_32_0 = "ui/combatskinrare"

						CombatSkinConst = var_3_10006

						var_3(var_32_0, var_3_10006.TYPE_ICON_NAME[var_29_35[arg_32_1 + 1]], arg_32_2:Find("icon"), true)

						setScrollText = var_3

						local var_32_1 = arg_32_2:Find("TextMask/Text")

						i18n = var_6

						var_3(var_32_1, var_6("battleui_display" .. var_29_35[arg_32_1 + 1]))
					end

					return
				end)
				var_12:align(#var_29_35)

				onButton = var_13

				local var_29_37 = arg_22_0
				local var_29_38 = var_29_34
				local var_29_39 = var_29_34.Find(var_29_38, "play")

				local function var_29_40()
					local var_33_0 = arg_22_0

					CombatPreviewLayer = var_3_10001
					var_33_0.previewer = var_3_10001.New(var_0.UIMgr.GetInstance().OverlayMain)

					local var_33_1 = arg_22_0.previewer

					var_0.ExecuteAction(var_33_1, "Show", var_29_0.id, function()
						local var_34_0 = arg_22_0.previewer

						var_0.Destroy(var_34_0)

						arg_22_0.previewer = nil

						return
					end)

					return
				end

				SFX_PANEL = var_29_38

				var_13(var_29_37, var_29_39, var_29_40, var_29_38)
			end

			return
		end,
		[var_0.TYPE_COMMON_ITEMS] = function(arg_35_0)
			local var_35_0 = arg_22_0._tf
			local var_35_1 = var_1.Find(var_35_0, "window/middle")

			setActive = var_2_10002

			var_2_10002(var_35_1:Find("info/Text"), arg_35_0.content)

			setTextInNewStyleBox = var_2_10002

			local var_35_2 = var_35_1:Find("info/Text")
			local var_35_3

			if not arg_35_0.content then
				var_35_3 = ""
			end

			var_2_10002(var_35_2, var_35_3)

			local var_35_4 = arg_35_0.items
			local var_35_5 = arg_35_0.itemFunc
			local var_35_6 = var_35_1:Find("scrollview/content")

			UIItemList = var_35_3

			var_35_3.StaticAlign(var_35_6, var_35_6:Find("item"), #var_35_4, function(arg_36_0, arg_36_1, arg_36_2)
				arg_36_1 = arg_36_1 + 1
				UIItemList = var_3_10003

				if arg_36_0 == var_3_10003.EventUpdate then
					local var_36_0 = var_35_4[arg_36_1]

					updateDrop = var_3_10004

					var_3_10004(arg_36_2:Find("IconTpl"), var_36_0, {
						anonymous = var_36_0.anonymous,
						hideName = var_36_0.hideName
					})

					local var_36_1 = arg_36_2:Find("IconTpl/name")

					setText = var_3_10005

					local var_36_2 = var_36_1

					shortenString = var_8
					getText = var_3_10010

					var_3_10005(var_36_2, var_8(var_3_10010(var_36_1), 6))

					setActive = var_3_10005

					var_3_10005(arg_36_2:Find("own"), arg_35_0.showOwn)

					if arg_35_0.showOwn then
						setText = var_5

						local var_36_3 = arg_36_2:Find("own/Text")

						i18n = var_8

						var_5(var_36_3, var_8("equip_skin_detail_count") .. var_36_0:getOwnedCount())
					end

					onButton = var_5

					local var_36_4 = arg_22_0
					local var_36_5 = arg_36_2

					local function var_36_6()
						if var_36_0.anonymous then
							return
						elseif var_35_5 then
							var_35_5(var_36_0)
						end

						return
					end

					SFX_UI_CLICK = var_10

					var_5(var_36_4, var_36_5, var_36_6, var_10)
				end

				return
			end)

			return
		end,
		[var_0.TYPE_SHIP_PREVIEW] = function(arg_38_0)
			local var_38_0 = arg_22_0._tf
			local var_38_1 = var_1.Find(var_38_0, "left_panel")
			local var_38_2 = var_1.Find(var_38_1, "sea")
			local var_38_3 = var_2.GetComponent(var_38_2, "RawImage")

			setActive = var_38_0

			var_38_0(var_38_3, false)

			GameObject = var_38_0

			local var_38_4 = var_38_0.Find("BarrageCamera")
			local var_38_5 = var_3.GetComponent(var_38_4, "Camera")

			var_38_5.enabled = true
			var_38_5.targetTexture = var_38_3.texture

			local var_38_6 = arg_22_0._tf
			local var_38_7 = var_4.Find(var_38_6, "resources/heal").transform

			Vector3 = var_38_6
			var_38_7.localPosition = var_38_6(-360, 50, 40)
			setActive = var_38_7

			var_38_7(var_4, false)

			local var_38_8 = var_4:GetComponent("DftAniEvent")

			var_5.SetEndEvent(var_38_8, function()
				setActive = var_3_10000

				var_3_10000(var_0, false)

				setText = var_3_10000

				local var_39_0 = var_0

				var_3_10000(var_2.Find(var_39_0, "text"), "")

				return
			end)

			local var_38_9 = var_1
			local var_38_10 = var_1.Find(var_38_9, "bg/loading")
			local var_38_11

			onButton = var_38_9

			var_38_9(arg_22_0, var_38_10, function()
				if not var_38_11 then
					WeaponPreviewer = var_0
					var_38_11 = var_0.New(var_38_3)

					local var_40_0 = var_38_11

					var_0.configUI(var_40_0, var_0)

					local var_40_1 = var_38_11

					var_0.setDisplayWeapon(var_40_1, arg_38_0.weaponIds, arg_38_0.equipSkinId, true)

					local var_40_2 = var_38_11

					var_0.load(var_40_2, 40000, arg_38_0.shipVO, arg_38_0.weaponIds, function()
						setActive = var_4_10000

						var_4_10000(var_38_10, false)

						return
					end)
				end

				return
			end)

			setActive = var_38_9

			var_38_9(var_38_10, true)

			onButton = var_38_9

			local var_38_12 = arg_22_0
			local var_38_13 = arg_22_0._tf

			local function var_38_14()
				setActive = var_3_10000

				var_3_10000(var_38_10, false)

				if var_38_11 then
					local var_42_0 = var_38_11

					var_0.clear(var_42_0)

					var_38_11 = nil
				end

				local var_42_1 = arg_22_0

				var_0.Hide(var_42_1)

				return
			end

			SFX_PANEL = var_2_10013

			var_38_9(var_38_12, var_38_13, var_38_14, var_2_10013)

			return
		end,
		[var_0.TYPE_COMMON_SHOPPING] = function(arg_43_0)
			local var_43_0 = arg_22_0._tf
			local var_43_1 = var_1.Find(var_43_0, "window/middle")
			local var_43_2 = arg_43_0.drop

			updateDrop = var_43_0

			var_43_0(var_43_1:Find("IconTpl"), var_43_2)

			setText = var_43_0

			var_43_0(var_43_1:Find("info/name/Text"), var_43_2:getConfig("name"))

			setText = var_43_0

			local var_43_3 = var_43_1:Find("IconTpl/own")

			i18n = var_6

			var_43_0(var_43_3, var_6("equip_skin_detail_count") .. var_43_2:getOwnedCount())

			local var_43_4 = var_43_1:Find("info/desc/Text")
			local var_43_5 = arg_22_0

			var_4.InitRichText(var_43_5, var_43_4)

			local var_43_6 = arg_22_0._tf
			local var_43_7 = var_4.Find(var_43_6, "window/bottom/button_container/btn_shopping/price/Text")
			local var_43_8 = arg_22_0._tf
			local var_43_9 = var_5.Find(var_43_8, "window/bottom/count")

			PageUtil = var_43_6

			local var_43_10 = var_43_6.New(var_43_9:Find("reduce"), var_43_9:Find("increase"), var_43_9:Find("max"), var_43_9:Find("Text"))
			local var_43_11 = arg_43_0.price
			local var_43_12 = arg_43_0.numUpdate
			local var_43_13

			if not arg_43_0.addNum then
				var_43_13 = 1
			end

			local var_43_14

			if not arg_43_0.maxNum then
				var_43_14 = -1
			end

			local var_43_15

			if not arg_43_0.defaultNum then
				var_43_15 = 1
			end

			var_43_10:setNumUpdate(function(arg_44_0)
				if var_43_12 ~= nil then
					var_43_12(var_43_4, arg_44_0)
				end

				setText = var_1

				var_1(var_43_7, "x" .. arg_44_0 * var_43_11)

				return
			end)
			var_43_10:setAddNum(var_43_13)
			var_43_10:setMaxNum(var_43_14)
			var_43_10:setDefaultNum(var_43_15)

			return
		end,
		[var_0.TYPE_LOVE_LETTER_LEVEL_REWARD] = function(arg_45_0)
			setText = var_2_10001

			local var_45_0 = arg_22_0._tf
			local var_45_1 = var_3.Find(var_45_0, "window/top/title")

			i18n = var_2_10004

			var_2_10001(var_45_1, var_2_10004("loveactivity_ui_20"))

			getProxy = var_2_10001
			LoveLetterProxy = var_45_1

			local var_45_2 = var_2_10001(var_45_1)
			local var_45_3 = var_1.GetAllLevel(var_45_2)

			underscore = var_45_1

			local var_45_4 = var_45_1.first(var_0.lover_reward.all, var_1:GetAllLevelAwardDisplayIndex())
			local var_45_5 = var_1
			local var_45_6 = var_1.GetAllLevelRewardMarkDic(var_45_5)
			local var_45_7 = arg_22_0._tf
			local var_45_8 = var_5.Find(var_45_7, "window/middle/view/content")

			UIItemList = var_45_5

			local var_45_9 = var_45_5.StaticAlign
			local var_45_10 = var_45_8
			local var_45_11 = var_45_8:Find("tpl")

			math = var_2_10010

			var_45_9(var_45_10, var_45_11, var_2_10010.max(#var_45_4, 3), function(arg_46_0, arg_46_1, arg_46_2)
				arg_46_1 = arg_46_1 + 1
				UIItemList = var_3_10003

				if arg_46_0 == var_3_10003.EventUpdate then
					local var_46_0 = var_45_4[arg_46_1]

					setActive = var_3_10004

					var_3_10004(arg_46_2:Find("on"), var_46_0)

					setActive = var_3_10004

					var_3_10004(arg_46_2:Find("empty"), not var_46_0)

					if not var_46_0 then
						return
					end

					local var_46_1 = arg_46_2

					arg_46_2 = arg_46_2.Find(var_46_1, "on")

					local var_46_2 = var_0.lover_reward[var_46_0]

					setActive = var_3_10005

					var_3_10005(arg_46_2:Find("active_bg"), not var_45_6[var_46_0] and var_45_3 >= var_46_2.total_level)

					setActive = var_3_10005

					var_3_10005(arg_46_2:Find("lock"), var_45_3 < var_46_2.total_level)

					setText = var_3_10005

					var_3_10005(arg_46_2:Find("mark/Text"), var_46_2.total_level)

					underscore = var_3_10005

					local var_46_3 = var_3_10005.map(var_46_2.show_reward, function(arg_47_0)
						Drop = var_4_10001

						return var_4_10001.Create(arg_47_0)
					end)

					UIItemList = var_46_1

					var_46_1.StaticAlign(arg_46_2:Find("awards"), arg_46_2:Find("awards/tpl"), #var_46_3, function(arg_48_0, arg_48_1, arg_48_2)
						arg_48_1 = arg_48_1 + 1

						local var_48_0 = arg_46_0

						UIItemList = var_4_10004

						if var_48_0 == var_4_10004.EventUpdate then
							local var_48_1 = var_46_3[arg_48_1]

							updateDrop = var_4

							var_4(arg_48_2:Find("mask/IconTpl"), var_48_1)

							onButton = var_4

							local var_48_2 = arg_22_0
							local var_48_3 = arg_48_2

							local function var_48_4()
								local var_49_0 = arg_22_0
								local var_49_1 = var_0.emit

								BaseUI = var_5_10003

								var_49_1(var_49_0, var_5_10003.ON_DROP, var_48_1)

								return
							end

							SFX_PANEL = var_9

							var_4(var_48_2, var_48_3, var_48_4, var_9)

							setActive = var_4

							var_4(arg_48_2:Find("got"), var_45_6[var_46_0])
						end

						return
					end)
				end

				return
			end)

			if var_1:GetAllLevelNextAwardIndex() then
				scrollToIndex = var_45_7

				var_45_7(var_45_8, var_6)
			else
				scrollToBottom = var_45_7

				var_45_7(var_45_8)
			end

			return
		end
	}, nil, arg_22_2)

	return
end

function var_1.InitRichText(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_1:GetComponent("RichText")

	pairs = var_1_10003

	for iter_50_0, iter_50_1 in var_1_10003(arg_50_0.richTextSprites) do
		var_50_0:AddSprite(iter_50_0, iter_50_1)
	end

	return
end

function var_1.emit(arg_51_0, arg_51_1, ...)
	if not arg_51_0.analogyMediator then
		arg_51_0.analogyMediator = {
			addSubLayers = function(arg_52_0, arg_52_1)
				local var_52_0 = var_0.m02
				local var_52_1 = var_2.sendNotification

				GAME = var_2_10005

				local var_52_2 = var_2_10005.LOAD_LAYERS
				local var_52_3 = {}

				getProxy = var_2_10007
				ContextProxy = var_2_10009

				local var_52_4 = var_2_10007(var_2_10009)

				var_52_3.parentContext = var_7.getCurrentContext(var_52_4)
				var_52_3.context = arg_52_1

				var_52_1(var_52_0, var_52_2, var_52_3)

				return
			end,
			sendNotification = function(arg_53_0, ...)
				local var_53_0 = var_0.m02

				var_1.sendNotification(var_53_0, ...)

				return
			end,
			viewComponent = arg_51_0
		}
	end

	ContextMediator = var_2

	return var_2.CommonBindDic[arg_51_1](arg_51_0.analogyMediator, arg_51_1, ...)
end

function var_1.closeView(arg_54_0)
	arg_54_0:hide()

	return
end

return var_1

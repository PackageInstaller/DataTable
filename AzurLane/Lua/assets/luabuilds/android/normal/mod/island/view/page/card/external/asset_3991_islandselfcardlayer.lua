class = var_0_10000

local var_0_0 = "IslandSelfCardLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.LABEL_SHOW_CNT = 2
var_0_1.ACHV_SHOW_CNT = 4
var_0_1.COLORS = {
	"#A38759",
	"#AB7B7B",
	"#B1B284",
	"#8B99AC",
	"#8AAD8B",
	"#9D87A9"
}

function var_0_1.getUIName(arg_1_0)
	return "IslandSelfCardUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_2_0 = var_1_10002(var_1_10003)
	local var_2_1 = var_2.getData(var_2_0).id

	seriesAsync = var_2_0

	var_2_0({
		function(arg_3_0)
			getProxy = var_2_10001
			IslandProxy = var_2_10002

			local var_3_0 = var_2_10001(var_2_10002)

			if var_1.GetIsland(var_3_0) then
				var_3_0 = arg_2_0
				var_3_0.island = var_1

				arg_3_0()
			else
				pg = var_3_0

				local var_3_1 = var_3_0.m02
				local var_3_2 = var_2.sendNotification

				GAME = var_2_10004

				var_3_2(var_3_1, var_2_10004.ISLAND_GET_DATA, {
					isCardRequest = true,
					id = var_2_1,
					list = {},
					callback = function()
						local var_4_0 = arg_2_0

						getProxy = var_3_10001
						IslandProxy = var_3_10002

						local var_4_1 = var_3_10001(var_3_10002)

						var_4_0.island = var_1.GetIsland(var_4_1)

						arg_3_0()

						return
					end
				})
			end

			return
		end,
		function(arg_5_0)
			pg = var_2_10001

			local var_5_0 = var_2_10001.m02
			local var_5_1 = var_1.sendNotification

			GAME = var_2_10003

			var_5_1(var_5_0, var_2_10003.ISLAND_GET_CARD_DATA, {
				userId = var_2_1,
				callback = function(arg_6_0)
					arg_2_0.card = arg_6_0

					arg_5_0()

					return
				end
			})

			return
		end
	}, function()
		arg_2_1()

		return
	end)

	return
end

function var_0_1.init(arg_8_0)
	local var_8_0 = arg_8_0._tf
	local var_8_1 = var_1.GetComponent

	typeof = var_1_10003
	Animation = var_1_10004
	arg_8_0.uiAnim = var_8_1(var_8_0, var_1_10003(var_1_10004))

	local var_8_2 = arg_8_0._tf
	local var_8_3 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_8_0.uiAnimEvent = var_8_3(var_8_2, var_3(var_1_10004))

	local var_8_4 = arg_8_0.uiAnimEvent

	var_1.SetEndEvent(var_8_4, function()
		arg_8_0.playingHideAnim = false

		local var_9_0 = arg_8_0

		var_0.closeView(var_9_0, arg_8_0)

		return
	end)

	setText = var_1

	local var_8_5 = arg_8_0._tf
	local var_8_6 = var_2.Find(var_8_5, "tip")

	i18n = var_8_5

	var_1(var_8_6, var_8_5("island_card_close"))

	local var_8_7 = arg_8_0._tf
	local var_8_8 = var_1.Find(var_8_7, "panel")

	arg_8_0.photoTF = var_1.Find(var_8_8, "photo/Image")
	arg_8_0.photoSwitchBtn = var_1:Find("photo/switch")
	arg_8_0.likeTF = var_1:Find("photo/like")
	arg_8_0.labelsTF = var_1:Find("labels")
	arg_8_0.visitTF = var_1:Find("btns/visit/Text")
	arg_8_0.diyBtn = var_1:Find("btns/diy")
	arg_8_0.whitelistBtn = var_1:Find("btns/whitelist")
	arg_8_0.blacklistBtn = var_1:Find("btns/blacklist")
	arg_8_0.levelTF = var_1:Find("level")
	arg_8_0.wordTF = var_1:Find("word")
	arg_8_0.nameTF = var_1:Find("name")

	local var_8_9 = arg_8_0.nameTF

	arg_8_0.addBtn = var_2.Find(var_8_9, "add")

	local var_8_10 = arg_8_0.nameTF

	arg_8_0.removeBtn = var_2.Find(var_8_10, "remove")

	local var_8_11 = arg_8_0.nameTF

	arg_8_0.editBtn = var_2.Find(var_8_11, "edit")

	local var_8_12 = arg_8_0._tf

	arg_8_0.editPanel = var_2.Find(var_8_12, "editPanel")

	local var_8_13 = arg_8_0.editPanel

	arg_8_0.editNameBtn = var_2.Find(var_8_13, "content/name")
	setText = var_2

	local var_8_14 = arg_8_0.editNameBtn
	local var_8_15 = var_3.Find(var_8_14, "Text")

	i18n = var_8_14

	var_2(var_8_15, var_8_14("island_card_edit_name"))

	local var_8_16 = arg_8_0.editPanel

	arg_8_0.editWordBtn = var_2.Find(var_8_16, "content/word")
	setText = var_2

	local var_8_17 = arg_8_0.editWordBtn
	local var_8_18 = var_3.Find(var_8_17, "Text")

	i18n = var_8_17

	var_2(var_8_18, var_8_17("island_card_edit_word"))

	arg_8_0.shipTF = var_1:Find("counts/ship/Text")
	arg_8_0.achvTF = var_1:Find("counts/achv/Text")
	arg_8_0.bookTF = var_1:Find("counts/book/Text")
	UIItemList = var_2
	arg_8_0.achvUIList = var_2.New(var_1:Find("achvs"), var_1:Find("achvs/tpl"))
	setText = var_2

	local var_8_19 = var_1
	local var_8_20 = var_1.Find(var_8_19, "achvs/tpl/empty/Text")

	i18n = var_8_19

	var_2(var_8_20, var_8_19("island_card_no_achv_self"))
	arg_8_0:InitBoxs()

	return
end

function var_0_1.InitBoxs(arg_10_0)
	IslandEditCardNameBox = var_1_10001
	arg_10_0.editNameBox = var_1_10001.New(arg_10_0._tf, arg_10_0.event)
	IslandEditCardWordBox = var_1
	arg_10_0.editWordBox = var_1.New(arg_10_0._tf, arg_10_0.event)
	IslandSetCardPhotoBox = var_1
	arg_10_0.setPhotoBox = var_1.New(arg_10_0._tf, arg_10_0.event)
	IslandSetCardAchvsBox = var_1
	arg_10_0.setAchvsBox = var_1.New(arg_10_0._tf, arg_10_0.event)
	IslandShowCardLabelBox = var_1
	arg_10_0.showLabelBox = var_1.New(arg_10_0._tf, arg_10_0.event)

	return
end

function var_0_1.didEnter(arg_11_0)
	if not arg_11_0.contextData.isIslandPage then
		pg = var_1

		local var_11_0 = var_1.UIMgr.GetInstance()

		var_1.BlurPanel(var_11_0, arg_11_0._tf)
	end

	onButton = var_1

	local var_11_1 = arg_11_0
	local var_11_2 = arg_11_0._tf
	local var_11_3 = var_3.Find(var_11_2, "panel/help")

	local function var_11_4()
		pg = var_2_10000

		local var_12_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_12_1 = var_0.ShowMsgBox
		local var_12_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_12_2.type = var_2_10003
		pg = var_2_10003
		var_12_2.helps = var_2_10003.gametip.island_helpbtn_card.tip

		var_12_1(var_12_0, var_12_2)

		return
	end

	SFX_PANEL = var_5

	var_1(var_11_1, var_11_3, var_11_4, var_5)

	onButton = var_1

	local var_11_5 = arg_11_0
	local var_11_6 = arg_11_0._tf
	local var_11_7 = var_3.Find(var_11_6, "close")

	local function var_11_8()
		local var_13_0 = arg_11_0

		var_0.PlayHideAnim(var_13_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_11_5, var_11_7, var_11_8, var_5)

	onButton = var_1

	local var_11_9 = arg_11_0
	local var_11_10 = arg_11_0.photoSwitchBtn

	local function var_11_11()
		local var_14_0 = arg_11_0.island
		local var_14_1 = var_0.GetCardDiyAgency(var_14_0)
		local var_14_2 = var_0.GetIds(var_14_1)
		local var_14_3 = arg_11_0.setPhotoBox

		var_1.ExecuteAction(var_14_3, "Show", var_14_2, arg_11_0.photoId)

		return
	end

	SFX_PANEL = var_5

	var_1(var_11_9, var_11_10, var_11_11, var_5)

	onButton = var_1

	local var_11_12 = arg_11_0
	local var_11_13 = arg_11_0.editBtn

	local function var_11_14()
		local var_15_0 = arg_11_0

		var_0.ShowEditPanel(var_15_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_11_12, var_11_13, var_11_14, var_5)

	onButton = var_1

	local var_11_15 = arg_11_0
	local var_11_16 = arg_11_0.editPanel
	local var_11_17 = var_3.Find(var_11_16, "close")

	local function var_11_18()
		local var_16_0 = arg_11_0

		var_0.HideEditPanel(var_16_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_11_15, var_11_17, var_11_18, var_5)

	onButton = var_1

	local var_11_19 = arg_11_0
	local var_11_20 = arg_11_0.editNameBtn

	local function var_11_21()
		local var_17_0 = arg_11_0.editNameBox

		var_0.ExecuteAction(var_17_0, "Show")

		return
	end

	SFX_PANEL = var_5

	var_1(var_11_19, var_11_20, var_11_21, var_5)

	onButton = var_1

	local var_11_22 = arg_11_0
	local var_11_23 = arg_11_0.editWordBtn

	local function var_11_24()
		local var_18_0 = arg_11_0.editWordBox

		var_0.ExecuteAction(var_18_0, "Show")

		return
	end

	SFX_PANEL = var_5

	var_1(var_11_22, var_11_23, var_11_24, var_5)
	arg_11_0:InitAchvUIList()
	arg_11_0:Flush()

	return
end

function var_0_1.InitAchvUIList(arg_19_0)
	local var_19_0 = arg_19_0.achvUIList

	var_1.make(var_19_0, function(arg_20_0, arg_20_1, arg_20_2)
		UIItemList = var_2_10003

		if arg_20_0 == var_2_10003.EventInit then
			onButton = var_3

			local var_20_0 = arg_19_0
			local var_20_1 = arg_20_2

			local function var_20_2()
				local var_21_0 = arg_19_0.island
				local var_21_1 = var_0.GetAchievementAgency(var_21_0)
				local var_21_2 = var_0.GetGotGroupMaxStageList(var_21_1)
				local var_21_3 = arg_19_0.setAchvsBox
				local var_21_4 = var_1.ExecuteAction
				local var_21_5 = "Show"
				local var_21_6 = var_21_2

				Clone = var_3_10005

				var_21_4(var_21_3, var_21_5, var_21_6, var_3_10005(arg_19_0.card.achvList))

				return
			end

			SFX_PANEL = var_2_10007

			var_3(var_20_0, var_20_1, var_20_2, var_2_10007)
		else
			UIItemList = var_3

			if arg_20_0 == var_3.EventUpdate then
				local var_20_3 = arg_19_0

				var_3.UpdataAchvItem(var_20_3, arg_20_1, arg_20_2)
			end
		end

		return
	end)

	return
end

function var_0_1.ShowEditPanel(arg_22_0)
	local var_22_0 = arg_22_0._tf
	local var_22_1 = var_1.InverseTransformPoint(var_22_0, arg_22_0.editBtn.position)

	setAnchoredPosition = var_22_0

	local var_22_2 = arg_22_0.editPanel

	var_22_0(var_3.Find(var_22_2, "content"), var_22_1)

	setActive = var_22_0

	var_22_0(arg_22_0.editPanel, true)

	return
end

function var_0_1.HideEditPanel(arg_23_0)
	setActive = var_1_10001

	var_1_10001(arg_23_0.editPanel, false)

	return
end

function var_0_1.UpdataAchvItem(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0.card.achvList[arg_24_1 + 1]

	setActive = var_4

	var_4(arg_24_2:Find("empty"), not var_24_0)

	setActive = var_4

	var_4(arg_24_2:Find("content"), var_24_0)

	if var_24_0 then
		pg = var_4

		local var_24_1 = var_4.island_achievement[var_24_0]

		LoadImageSpriteAtlasAsync = var_5

		var_5("islandachievement", "achv_stage_" .. var_24_1.stage, arg_24_2:Find("content/Image"), true)

		setText = var_5

		var_5(arg_24_2:Find("content/Text"), var_24_1.name)
	end

	return
end

function var_0_1.Flush(arg_25_0)
	local var_25_0 = arg_25_0.card

	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_25_1 = var_1_10002(var_1_10003)
	local var_25_2 = var_2.GetIsland(var_25_1)
	local var_25_3 = var_2.GetAchievementAgency(var_25_2)

	var_25_0.achvList = var_2.UpdataAchLv(var_25_3, arg_25_0.card.achvList)

	arg_25_0:UpdataPhoto()
	arg_25_0:UpdataLabels()
	arg_25_0:UpdataInfos()

	return
end

function var_0_1.UpdataPhoto(arg_26_0)
	tonumber = var_1_10001
	arg_26_0.photoId = var_1_10001(arg_26_0.card.photoStr)

	if arg_26_0.photoId then
		pg = var_1

		local var_26_0 = var_1.island_card_diy[arg_26_0.photoId].resource

		LoadImageSpriteAsync = var_2

		var_2(var_26_0, arg_26_0.photoTF, true)
	end

	return
end

function var_0_1.UpdataLabels(arg_27_0)
	local var_27_0 = arg_27_0.card

	arg_27_0.labels = var_1.GetLabelList(var_27_0)
	table = var_1

	local var_27_1 = var_1.sort
	local var_27_2 = arg_27_0.labels

	CompareFuncs = var_1_10003

	var_27_1(var_27_2, var_1_10003({
		function(arg_28_0)
			return -arg_28_0.num
		end,
		function(arg_29_0)
			return arg_29_0.id
		end
	}))

	for iter_27_0 = 1, var_0_1.LABEL_SHOW_CNT + 1 do
		local var_27_3 = arg_27_0.labelsTF
		local var_27_4 = var_5.GetChild(var_27_3, iter_27_0 - 1)
		local var_27_5 = iter_27_0 <= #arg_27_0.labels + 1

		setActive = var_7

		var_7(var_27_4, var_27_5)

		if var_27_5 then
			if iter_27_0 <= #arg_27_0.labels then
				arg_27_0:UpdateNoramlLabel(var_27_4, arg_27_0.labels[iter_27_0])
			else
				arg_27_0:UpdateGrayLabel(var_27_4)
			end
		end
	end

	return
end

function var_0_1.UpdateNoramlLabel(arg_30_0, arg_30_1, arg_30_2)
	pg = var_1_10003

	local var_30_0 = var_1_10003.island_card_label[arg_30_2.id]

	LoadImageSpriteAtlasAsync = var_4

	var_4("ui/islandcardui_atlas", "label_bg_" .. var_30_0.color, arg_30_1, true)

	local var_30_1 = var_0_1.COLORS[var_30_0.color]

	setTextColor = var_5

	local var_30_2 = arg_30_1
	local var_30_3 = arg_30_1.Find(var_30_2, "name")

	Color = var_30_2

	var_5(var_30_3, var_30_2.NewHex(var_30_1))

	setTextColor = var_5

	local var_30_4 = arg_30_1
	local var_30_5 = arg_30_1.Find(var_30_4, "value")

	Color = var_30_4

	var_5(var_30_5, var_30_4.NewHex(var_30_1))

	setText = var_5

	var_5(arg_30_1:Find("name"), var_30_0.name)

	setText = var_5

	var_5(arg_30_1:Find("value"), arg_30_2.num)

	removeOnButton = var_5

	var_5(arg_30_1)

	return
end

function var_0_1.UpdateGrayLabel(arg_31_0, arg_31_1)
	LoadImageSpriteAtlasAsync = var_1_10002

	var_1_10002("ui/islandcardui_atlas", "bg_label_gray", arg_31_1, true)

	local var_31_0 = #arg_31_0.labels == 0

	setTextColor = var_3

	local var_31_1 = arg_31_1
	local var_31_2 = arg_31_1.Find(var_31_1, "name")

	Color = var_31_1

	var_3(var_31_2, var_31_1.NewHex("#F7F7F7"))

	setText = var_3

	local var_31_3 = arg_31_1
	local var_31_4 = arg_31_1.Find(var_31_3, "name")

	if var_31_0 then
		i18n = var_31_3

		if not var_31_3("island_card_no_label") then
			i18n = var_31_3
			var_31_3 = var_31_3("island_card_view_detaills")
		end

		var_3(var_31_4, var_31_3)

		setText = var_3

		var_3(arg_31_1:Find("value"), "")

		if not var_31_0 then
			onButton = var_3

			local var_31_5 = arg_31_0
			local var_31_6 = arg_31_1

			local function var_31_7()
				local var_32_0 = arg_31_0.showLabelBox

				var_0.ExecuteAction(var_32_0, "Show", arg_31_0.labels)

				return
			end

			SFX_PANEL = var_1_10007

			var_3(var_31_5, var_31_6, var_31_7, var_1_10007)
		else
			removeOnButton = var_3

			var_3(arg_31_1)
		end

		return
	end
end

function var_0_1.UpdataInfos(arg_33_0)
	setText = var_1_10001

	var_1_10001(arg_33_0.nameTF, arg_33_0.card.name)

	setText = var_1_10001

	var_1_10001(arg_33_0.levelTF, "Lv." .. arg_33_0.card.level)

	setText = var_1_10001

	var_1_10001(arg_33_0.wordTF, arg_33_0.card.word)

	setText = var_1_10001

	var_1_10001(arg_33_0.likeTF, arg_33_0.card.likeCnt)

	setText = var_1_10001

	var_1_10001(arg_33_0.visitTF, arg_33_0.card.visitCnt)

	setText = var_1_10001

	var_1_10001(arg_33_0.shipTF, arg_33_0.card.shipCnt)

	setText = var_1_10001

	var_1_10001(arg_33_0.achvTF, arg_33_0.card.achvCnt)

	setText = var_1_10001

	var_1_10001(arg_33_0.bookTF, arg_33_0.card.bookCnt)

	local var_33_0 = arg_33_0.achvUIList

	var_1.align(var_33_0, var_0_1.ACHV_SHOW_CNT)

	return
end

function var_0_1.OnSetNameDone(arg_34_0, arg_34_1)
	arg_34_0:HideEditPanel()

	local var_34_0 = arg_34_0.editNameBox

	var_2.ExecuteAction(var_34_0, "Hide")

	local var_34_1 = arg_34_0.card

	var_34_1.name = arg_34_1
	setText = var_34_1

	var_34_1(arg_34_0.nameTF, arg_34_0.card.name)

	return
end

function var_0_1.OnSetWordDone(arg_35_0, arg_35_1)
	arg_35_0:HideEditPanel()

	local var_35_0 = arg_35_0.editWordBox

	var_2.ExecuteAction(var_35_0, "Hide")

	local var_35_1 = arg_35_0.card

	var_35_1.word = arg_35_1
	setText = var_35_1

	var_35_1(arg_35_0.wordTF, arg_35_0.card.word)

	return
end

function var_0_1.OnSetPhotoDone(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0.setPhotoBox

	var_2.ExecuteAction(var_36_0, "Hide")

	arg_36_0.card.photoStr = arg_36_1

	arg_36_0:UpdataPhoto()

	return
end

function var_0_1.OnSetAchvsDone(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0.setAchvsBox

	var_2.ExecuteAction(var_37_0, "Hide")

	local var_37_1 = arg_37_0.card

	getProxy = var_37_0
	IslandProxy = var_4

	local var_37_2 = var_37_0(var_4)
	local var_37_3 = var_3.GetIsland(var_37_2)
	local var_37_4 = var_3.GetAchievementAgency(var_37_3)

	var_37_1.achvList = var_3.UpdataAchLv(var_37_4, arg_37_1)

	local var_37_5 = arg_37_0.achvUIList

	var_2.align(var_37_5, var_0_1.ACHV_SHOW_CNT)

	local var_37_6 = {}
	local var_37_7 = arg_37_0.achvUIList

	var_3.eachActive(var_37_7, function(arg_38_0, arg_38_1)
		if arg_37_0.card.achvList[arg_38_0 + 1] then
			local var_38_0 = arg_38_1:Find("content/Image")
			local var_38_1 = var_3.GetComponent

			typeof = var_2_10006
			CanvasGroup = var_2_10007

			local var_38_2 = var_38_1(var_38_0, var_2_10006(var_2_10007))

			var_38_2.alpha = 0
			table = var_38_2

			var_38_2.insert(var_37_6, function(arg_39_0)
				local var_39_0 = arg_38_1
				local var_39_1 = var_1.GetComponent

				typeof = var_3_10003
				Animation = var_3_10004

				local var_39_2 = var_39_1(var_39_0, var_3_10003(var_3_10004))

				var_1.Play(var_39_2)

				local var_39_3 = var_0
				local var_39_4 = var_1.GetComponent

				typeof = var_3
				CanvasGroup = var_3_10004
				var_39_4(var_39_3, var_3(var_3_10004)).alpha = 1

				local var_39_5 = arg_37_0
				local var_39_6 = var_1.managedTween

				LeanTween = var_3

				var_39_6(var_39_5, var_3.delayedCall, function()
					arg_39_0()

					return
				end, 0.08, nil)

				return
			end)
		end

		return
	end)

	seriesAsync = var_3

	var_3(var_37_6)

	return
end

function var_0_1.PlayHideAnim(arg_41_0)
	if arg_41_0.playingHideAnim then
		return
	end

	local var_41_0 = arg_41_0.uiAnim

	var_1.Play(var_41_0, "anim_IslandSelfCardUI_out")

	arg_41_0.playingHideAnim = true

	return
end

function var_0_1.willExit(arg_42_0)
	local var_42_0 = arg_42_0.uiAnimEvent

	var_1.SetEndEvent(var_42_0, nil)

	if not arg_42_0.contextData.isIslandPage then
		pg = var_1

		local var_42_1 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_42_1, arg_42_0._tf)
	end

	if arg_42_0.editNameBox then
		local var_42_2 = arg_42_0.editNameBox

		var_1.Destroy(var_42_2)

		arg_42_0.editNameBox = nil
	end

	if arg_42_0.editWordBox then
		local var_42_3 = arg_42_0.editWordBox

		var_1.Destroy(var_42_3)

		arg_42_0.editWordBox = nil
	end

	if arg_42_0.setPhotoBox then
		local var_42_4 = arg_42_0.setPhotoBox

		var_1.Destroy(var_42_4)

		arg_42_0.setPhotoBox = nil
	end

	if arg_42_0.setAchvsBox then
		local var_42_5 = arg_42_0.setAchvsBox

		var_1.Destroy(var_42_5)

		arg_42_0.setAchvsBox = nil
	end

	if arg_42_0.showLabelBox then
		local var_42_6 = arg_42_0.showLabelBox

		var_1.Destroy(var_42_6)

		arg_42_0.showLabelBox = nil
	end

	return
end

return var_0_1

class = var_0_10000

local var_0_0 = "AgoraDecorationView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.Core.View.IslandASynLoadSubView"))

function var_0_1.GetUIName(arg_1_0)
	return "IslandAgoraDecorationUI"
end

function var_0_1.OnInit(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_2.Find(var_2_0, "panel/main/scrollrect")

	arg_2_0.scrollRect = var_2.GetComponent(var_2_1, "LScrollRect")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_2.Find(var_2_2, "panel/main/scrollrect_theme")

	arg_2_0.scrollRect4Theme = var_2.GetComponent(var_2_3, "LScrollRect")

	local var_2_4 = arg_2_0._tf

	arg_2_0.emptyTr = var_2.Find(var_2_4, "panel/main/empty")

	local var_2_5 = arg_2_0._tf

	arg_2_0.agoraSaveBtn = var_2.Find(var_2_5, "panel/btns/save")

	local var_2_6 = arg_2_0._tf

	arg_2_0.agoraSaveCdBtn = var_2.Find(var_2_6, "panel/btns/save_cd")

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_2.Find(var_2_7, "panel/btns/save_cd/Text")
	local var_2_9 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_2_0.agoraSaveCdTxt = var_2_9(var_2_8, var_4(var_1_10005))

	local var_2_10 = arg_2_0._tf

	arg_2_0.agoraClearBtn = var_2.Find(var_2_10, "panel/btns/clear")

	local var_2_11 = arg_2_0._tf

	arg_2_0.agoraRevertBtn = var_2.Find(var_2_11, "panel/btns/revert")

	local var_2_12 = arg_2_0._tf

	arg_2_0.topPanel = var_2.Find(var_2_12, "top")

	local var_2_13 = arg_2_0._tf

	arg_2_0.agoraShopBtn = var_2.Find(var_2_13, "top/shop")

	local var_2_14 = arg_2_0._tf

	arg_2_0.backBtn = var_2.Find(var_2_14, "top/back")

	local var_2_15 = arg_2_0._tf

	arg_2_0.capacityBtn = var_2.Find(var_2_15, "top/capacity")

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_2.Find(var_2_16, "top/capacity/Text")
	local var_2_18 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_2_0.capacityTxt = var_2_18(var_2_17, var_4(var_1_10005))

	local var_2_19 = arg_2_0._tf

	arg_2_0.themeBtn = var_2.Find(var_2_19, "panel/main/bg/theme")

	local var_2_20 = arg_2_0._tf

	arg_2_0.hideBtn = var_2.Find(var_2_20, "panel/main/bg/hide")

	local var_2_21 = arg_2_0._tf

	arg_2_0.showBtn = var_2.Find(var_2_21, "panel/btns/show")
	UIItemList = var_2

	local var_2_22 = var_2.New
	local var_2_23 = arg_2_0._tf
	local var_2_24 = var_3.Find(var_2_23, "panel/main/bg/tags")
	local var_2_25 = arg_2_0._tf

	arg_2_0.tagUIItemList = var_2_22(var_2_24, var_4.Find(var_2_25, "panel/main/bg/tags/1_1"))

	local var_2_26 = arg_2_0._tf

	arg_2_0.searchInput = var_2.Find(var_2_26, "panel/main/bg/search/search")

	local var_2_27 = arg_2_0._tf

	arg_2_0.searchClearBtn = var_2.Find(var_2_27, "panel/main/bg/search/search/clear")

	local var_2_28 = arg_2_0._tf

	arg_2_0.sortBtn = var_2.Find(var_2_28, "panel/main/bg/order")

	local var_2_29 = arg_2_0._tf

	arg_2_0.orderBtn = var_2.Find(var_2_29, "panel/main/bg/order/icon")

	local var_2_30 = arg_2_0._tf
	local var_2_31 = var_2.Find(var_2_30, "panel/main/bg/order/Text_1")
	local var_2_32 = var_2.GetComponent

	typeof = var_4
	Text = var_2_25
	arg_2_0.orderTxt = var_2_32(var_2_31, var_4(var_2_25))
	AgoraDecorationSortPage = var_2
	arg_2_0.sortPage = var_2.New(arg_2_0._tf)
	AgoraFurnitureDescPage = var_2
	arg_2_0.descPage = var_2.New(arg_2_0._tf)
	AgoraDecorationShapePage = var_2

	local var_2_33 = var_2.New
	local var_2_34 = arg_2_0._tf

	arg_2_0.shapeSelectPanel = var_2_33(var_3.Find(var_2_34, "shapeTpl"))
	setText = var_2

	local var_2_35 = arg_2_0.agoraClearBtn
	local var_2_36 = var_3.Find(var_2_35, "Text")

	i18n = var_2_35

	var_2(var_2_36, var_2_35("island_agora_btn_label_clear"))

	setText = var_2

	local var_2_37 = arg_2_0.agoraRevertBtn
	local var_2_38 = var_3.Find(var_2_37, "Text")

	i18n = var_2_37

	var_2(var_2_38, var_2_37("island_agora_btn_label_revert"))

	setText = var_2

	local var_2_39 = arg_2_0.agoraSaveBtn
	local var_2_40 = var_3.Find(var_2_39, "Text")

	i18n = var_2_39

	var_2(var_2_40, var_2_39("island_agora_btn_label_save"))

	setText = var_2

	local var_2_41 = arg_2_0._tf
	local var_2_42 = var_3.Find(var_2_41, "top/title/Text")

	i18n = var_2_41

	var_2(var_2_42, var_2_41("island_agora_title"))

	setText = var_2

	local var_2_43 = arg_2_0._tf
	local var_2_44 = var_3.Find(var_2_43, "panel/main/bg/search/search/holder")

	i18n = var_2_43

	var_2(var_2_44, var_2_43("island_agora_label_search"))

	setText = var_2

	local var_2_45 = arg_2_0._tf
	local var_2_46 = var_3.Find(var_2_45, "panel/main/bg/theme/unsel/Text")

	i18n = var_2_45

	var_2(var_2_46, var_2_45("island_agora_label_theme"))

	setText = var_2

	local var_2_47 = arg_2_0._tf
	local var_2_48 = var_3.Find(var_2_47, "panel/main/bg/theme/sel/Text")

	i18n = var_2_47

	var_2(var_2_48, var_2_47("island_agora_label_theme"))

	setText = var_2

	local var_2_49 = arg_2_0.emptyTr
	local var_2_50 = var_3.Find(var_2_49, "empty_1/Text")

	i18n = var_2_49

	var_2(var_2_50, var_2_49("island_agora_label_empty_tip"))

	local var_2_51 = arg_2_0._tf
	local var_2_52 = var_2.GetComponent

	typeof = var_4
	Animation = var_5
	arg_2_0.anim = var_2_52(var_2_51, var_4(var_5))

	local var_2_53 = arg_2_0.anim
	local var_2_54 = var_2.GetComponent

	typeof = var_4
	DftAniEvent = var_5
	arg_2_0.dftAniEvent = var_2_54(var_2_53, var_4(var_5))

	local var_2_55 = arg_2_0._tf
	local var_2_56 = var_2.Find(var_2_55, "panel")
	local var_2_57 = var_2.GetComponent

	typeof = var_4
	Animation = var_5
	arg_2_0.panelAnim = var_2_57(var_2_56, var_4(var_5))
	arg_2_0.cards = {}
	arg_2_0.themeCards = {}
	arg_2_0.indexData = {
		tag = 1,
		sortKey = 1,
		searchKey = "",
		order = 1
	}

	arg_2_0:RegisterEvent()
	arg_2_0:UpdateOrderTxt()
	arg_2_0:InitTags()

	onButton = var_2

	local var_2_58 = arg_2_0
	local var_2_59 = arg_2_0._tf
	local var_2_60 = var_4.Find(var_2_59, "top/title/help")

	local function var_2_61()
		pg = var_2_10000

		local var_3_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_3_1 = var_0.ShowMsgBox
		local var_3_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_3_2.type = var_2_10003
		pg = var_2_10003
		var_3_2.helps = var_2_10003.gametip.island_help_renovation.tip

		var_3_1(var_3_0, var_3_2)

		return
	end

	SFX_PANEL = var_6

	var_2(var_2_58, var_2_60, var_2_61, var_6)

	return
end

function var_0_1.OnShow(arg_4_0)
	IslandGuideChecker = var_1_10001

	var_1_10001.CheckGuide("ISLAND_GUIDE_27")

	return
end

function var_0_1.PlayExitAnim(arg_5_0, arg_5_1)
	if arg_5_0.isAniming then
		return
	end

	arg_5_0.isAniming = true

	local var_5_0 = arg_5_0.dftAniEvent

	var_2.SetEndEvent(var_5_0, function()
		arg_5_0.isAniming = false

		var_0_1.super.Hide(arg_5_0)
		arg_5_1()

		return
	end)

	local var_5_1 = arg_5_0.anim

	var_2.Play(var_5_1, "anim_IslandAgoraDecorationUI_Out")

	return
end

function var_0_1.OnSelectedItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0.selectedId

	arg_7_0.selectedId = arg_7_1
	pairs = var_1_10005

	for iter_7_0, iter_7_1 in var_1_10005(arg_7_0.cards) do
		iter_7_1:UpdateSelected(arg_7_0.selectedId)
	end

	if not arg_7_2 then
		arg_7_0:TriggerTag(arg_7_1)

		return
	end

	if arg_7_0.selectedId > 0 and not arg_7_0.isHideState then
		triggerButton = var_5

		var_5(arg_7_0.hideBtn)
		arg_7_0:FoldBtnsAndTop()
	elseif arg_7_3 then
		_ = var_5

		if var_5.detect(arg_7_0.displays, function(arg_8_0)
			return arg_8_0:Contains(arg_7_3)
		end) and var_5:GetAvailableCnt() > 0 then
			return
		end

		if arg_7_1 < 0 then
			triggerButton = var_6

			var_6(arg_7_0.showBtn)
		end
	elseif arg_7_1 < 0 then
		triggerButton = var_5

		var_5(arg_7_0.showBtn)
	end

	return
end

function var_0_1.TriggerTag(arg_9_0, arg_9_1)
	if arg_9_1 <= 0 then
		return
	end

	local var_9_0 = arg_9_0:GetView().agora

	if not var_3.GetPlaceableItem(var_9_0, arg_9_1) then
		return
	end

	table = var_9_0

	local var_9_1 = var_9_0.indexof

	AgoraFurnitureType = var_5

	local var_9_2 = var_9_1(var_5.PLACEMENT_TYPE, var_3:GetType())

	if 0 < var_9_2 then
		triggerToggle = var_5

		var_5(arg_9_0.toggles[var_9_2], true)
	end

	return
end

function var_0_1.OnCreateSameItem(arg_10_0, arg_10_1)
	_ = var_1_10002

	if var_1_10002.detect(arg_10_0.displays, function(arg_11_0)
		return arg_11_0:Contains(arg_10_1)
	end) and var_2:GetAvailableCnt() > 0 then
		local var_10_0 = var_2:GetAvailableItem()

		arg_10_0:Op("PlaceItemRandonPosition", var_10_0.id)
	end

	return
end

function var_0_1.RegisterEvent(arg_12_0)
	function arg_12_0.scrollRect.onInitItem(arg_13_0)
		local var_13_0 = arg_12_0

		var_1.OnInitItem(var_13_0, arg_13_0)

		return
	end

	function arg_12_0.scrollRect.onUpdateItem(arg_14_0, arg_14_1)
		local var_14_0 = arg_12_0

		var_2.OnUpdateItem(var_14_0, arg_14_0, arg_14_1)

		return
	end

	function arg_12_0.scrollRect4Theme.onInitItem(arg_15_0)
		local var_15_0 = arg_12_0

		var_1.OnInitItem4Theme(var_15_0, arg_15_0)

		return
	end

	local var_12_0 = arg_12_0.scrollRect4Theme

	function var_12_0.onUpdateItem(arg_16_0, arg_16_1)
		local var_16_0 = arg_12_0

		var_2.OnUpdateItem4Theme(var_16_0, arg_16_0, arg_16_1)

		return
	end

	onButton = var_12_0

	local var_12_1 = arg_12_0
	local var_12_2 = arg_12_0.agoraSaveBtn

	local function var_12_3()
		local var_17_0 = arg_12_0

		if var_0.TrySave(var_17_0) then
			local var_17_1 = arg_12_0

			var_0.Op(var_17_1, "Save")
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_12_0(var_12_1, var_12_2, var_12_3, var_1_10005)

	onButton = var_12_0

	local var_12_4 = arg_12_0
	local var_12_5 = arg_12_0.agoraClearBtn

	local function var_12_6()
		local var_18_0 = arg_12_0
		local var_18_1 = var_0.ShowMsgbox
		local var_18_2 = {}

		i18n = var_2_10003
		var_18_2.content = var_2_10003("island_agora_clear_tip")

		function var_18_2.onYes()
			local var_19_0 = arg_12_0

			var_0.Op(var_19_0, "ClearAll")

			return
		end

		var_18_1(var_18_0, var_18_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_12_0(var_12_4, var_12_5, var_12_6, var_1_10005)

	onButton = var_12_0

	local var_12_7 = arg_12_0
	local var_12_8 = arg_12_0.agoraRevertBtn

	local function var_12_9()
		local var_20_0 = arg_12_0
		local var_20_1 = var_0.ShowMsgbox
		local var_20_2 = {}

		i18n = var_2_10003
		var_20_2.content = var_2_10003("island_agora_revert_tip")

		function var_20_2.onYes()
			local var_21_0 = arg_12_0

			var_0.Op(var_21_0, "Revert")

			return
		end

		var_20_1(var_20_0, var_20_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_12_0(var_12_7, var_12_8, var_12_9, var_1_10005)

	onButton = var_12_0

	local var_12_10 = arg_12_0
	local var_12_11 = arg_12_0.capacityBtn

	local function var_12_12()
		local var_22_0 = arg_12_0
		local var_22_1 = var_0.GetView(var_22_0).agora
		local var_22_2 = var_1.GetPlacedInfoList(var_22_1)
		local var_22_3 = var_0.agora
		local var_22_4 = var_2.GetMaxCapacity(var_22_3)
		local var_22_5 = arg_12_0
		local var_22_6 = var_3.ShowMsgbox
		local var_22_7 = {}

		IslandMsgBox = var_2_10006
		var_22_7.type = var_2_10006.TYPE_AGORA_PLACED_LIST
		var_22_7.list = var_22_2
		var_22_7.totalCnt = var_22_4

		var_22_6(var_22_5, var_22_7)

		return
	end

	SFX_PANEL = var_1_10005

	var_12_0(var_12_10, var_12_11, var_12_12, var_1_10005)

	onButton = var_12_0

	local var_12_13 = arg_12_0
	local var_12_14 = arg_12_0.agoraShopBtn

	local function var_12_15()
		local var_23_0 = arg_12_0
		local var_23_1 = var_0.GetView(var_23_0)
		local var_23_2 = var_0.GetController(var_23_1)

		if var_0.CheckChange(var_23_2) then
			local var_23_3 = arg_12_0

			var_0.Save(var_23_3)
		else
			local var_23_4 = arg_12_0

			var_0.PlayExitAnim(var_23_4, function()
				local var_24_0 = arg_12_0

				var_0.Op(var_24_0, "ExitEditMode")

				local var_24_1 = arg_12_0
				local var_24_2 = var_0.NotifiyIsland

				ISLAND_EX_EVT = var_2

				local var_24_3 = var_2.OPEN_PAGE

				IslandShopPage = var_3_10003

				var_24_2(var_24_1, var_24_3, var_3_10003, {
					1,
					2,
					3,
					4,
					5
				}, {
					10111,
					40111,
					50111,
					10122
				})

				return
			end)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_12_0(var_12_13, var_12_14, var_12_15, var_1_10005)

	onButton = var_12_0

	local var_12_16 = arg_12_0
	local var_12_17 = arg_12_0.backBtn

	local function var_12_18()
		local var_25_0 = arg_12_0
		local var_25_1 = var_0.GetView(var_25_0)
		local var_25_2 = var_0.GetController(var_25_1)

		if var_0.CheckChange(var_25_2) then
			local var_25_3 = arg_12_0

			var_0.Save(var_25_3)
		else
			local var_25_4 = arg_12_0

			var_0.PlayExitAnim(var_25_4, function()
				local var_26_0 = arg_12_0

				var_0.Op(var_26_0, "ExitEditMode")

				return
			end)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_12_0(var_12_16, var_12_17, var_12_18, var_1_10005)

	onInputChanged = var_12_0

	var_12_0(arg_12_0, arg_12_0.searchInput, function()
		getInputText = var_2_10000

		local var_27_0 = var_2_10000(arg_12_0.searchInput)

		setActive = var_1

		var_1(arg_12_0.searchClearBtn, var_27_0 ~= "")

		local var_27_1 = arg_12_0

		var_1.OnSearch(var_27_1, var_27_0)

		return
	end)

	onButton = var_12_0

	local var_12_19 = arg_12_0
	local var_12_20 = arg_12_0.searchClearBtn

	local function var_12_21()
		setInputText = var_2_10000

		var_2_10000(arg_12_0.searchInput, "")

		arg_12_0.indexData.searchKey = ""

		return
	end

	SFX_PANEL = var_1_10005

	var_12_0(var_12_19, var_12_20, var_12_21, var_1_10005)

	onButton = var_12_0

	local var_12_22 = arg_12_0
	local var_12_23 = arg_12_0.sortBtn

	local function var_12_24()
		local var_29_0 = arg_12_0.sortPage

		var_0.ExecuteAction(var_29_0, "Show", arg_12_0.indexData, function(arg_30_0)
			local var_30_0 = arg_12_0

			var_1.OnSort(var_30_0, arg_30_0)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10005

	var_12_0(var_12_22, var_12_23, var_12_24, var_1_10005)

	onButton = var_12_0

	local var_12_25 = arg_12_0
	local var_12_26 = arg_12_0.orderBtn

	local function var_12_27()
		local var_31_0 = 1 - arg_12_0.indexData.order
		local var_31_1 = arg_12_0

		var_1.OnOrder(var_31_1, var_31_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_12_0(var_12_25, var_12_26, var_12_27, var_1_10005)

	arg_12_0.isHideState = false
	arg_12_0.isHideBtnAndTop = false
	onButton = var_1

	local var_12_28 = arg_12_0
	local var_12_29 = arg_12_0.hideBtn

	local function var_12_30()
		arg_12_0.isHideState = true

		local var_32_0 = arg_12_0.panelAnim

		var_0.Play(var_32_0, "fold")

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_12_28, var_12_29, var_12_30, var_1_10005)

	onButton = var_1

	local var_12_31 = arg_12_0
	local var_12_32 = arg_12_0.showBtn

	local function var_12_33()
		arg_12_0.isHideState = false

		local var_33_0 = arg_12_0.panelAnim

		var_0.Play(var_33_0, "unfold")

		if arg_12_0.isHideBtnAndTop then
			local var_33_1 = arg_12_0

			var_0.UnFoldBtnsAndTop(var_33_1)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_12_31, var_12_32, var_12_33, var_1_10005)

	return
end

function var_0_1.TrySave(arg_34_0)
	local var_34_0 = arg_34_0:GetView()
	local var_34_1 = var_1.GetController(var_34_0)

	if not var_1.CanEnterEditMode(var_34_1) then
		local var_34_2 = arg_34_0
		local var_34_3 = arg_34_0.ShowMsgbox
		local var_34_4 = {}

		IslandMsgBox = var_1_10005
		var_34_4.type = var_1_10005.TYPE_AOGRA_SAVE_CD

		local var_34_5 = arg_34_0:GetView()

		var_34_4.duetime = var_5.GetController(var_34_5).editCdTime

		function var_34_4.onNo()
			local var_35_0 = arg_34_0

			var_0.Op(var_35_0, "RevertAndExit")

			return
		end

		var_34_3(var_34_2, var_34_4)
	end

	return var_1
end

function var_0_1.Save(arg_36_0)
	if arg_36_0:TrySave() then
		local var_36_0 = arg_36_0
		local var_36_1 = arg_36_0.ShowMsgbox
		local var_36_2 = {}

		i18n = var_1_10004
		var_36_2.content = var_1_10004("island_agora_save_or_exit_tip")
		i18n = var_4
		var_36_2.noText = var_4("island_agora_exit_and_unsave")
		i18n = var_4
		var_36_2.yesText = var_4("island_agora_exit_and_save")

		function var_36_2.onYes()
			local var_37_0 = arg_36_0

			var_0.Op(var_37_0, "SaveAndExit")

			return
		end

		function var_36_2.onNo()
			local var_38_0 = arg_36_0

			var_0.Op(var_38_0, "RevertAndExit")

			return
		end

		var_36_1(var_36_0, var_36_2)
	end

	return
end

function var_0_1.FoldBtnsAndTop(arg_39_0)
	setActive = var_1_10001

	var_1_10001(arg_39_0.agoraSaveBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_39_0.agoraClearBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_39_0.agoraRevertBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_39_0.topPanel, false)

	arg_39_0.isHideBtnAndTop = true

	return
end

function var_0_1.UnFoldBtnsAndTop(arg_40_0)
	setActive = var_1_10001

	var_1_10001(arg_40_0.agoraSaveBtn, true)

	setActive = var_1_10001

	var_1_10001(arg_40_0.agoraClearBtn, true)

	setActive = var_1_10001

	var_1_10001(arg_40_0.agoraRevertBtn, true)

	setActive = var_1_10001

	var_1_10001(arg_40_0.topPanel, true)

	arg_40_0.isHideBtnAndTop = false

	return
end

function var_0_1.InitTags(arg_41_0)
	arg_41_0.toggles = {}

	local var_41_0 = arg_41_0.tagUIItemList

	var_1.make(var_41_0, function(arg_42_0, arg_42_1, arg_42_2)
		UIItemList = var_2_10003

		if arg_42_0 == var_2_10003.EventUpdate then
			AgoraFurnitureType = var_3

			local var_42_0 = var_3.PLACEMENT_TYPE[arg_42_1 + 1]

			onToggle = var_4

			local var_42_1 = arg_41_0
			local var_42_2 = arg_42_2

			local function var_42_3(arg_43_0)
				if arg_43_0 then
					arg_41_0.selectedTagIndex = arg_42_1 + 1

					local var_43_0 = arg_41_0
					local var_43_1 = var_1.Op
					local var_43_2 = "NotifiyAgora"

					ISLAND_AGORA_EVT = var_3_10004

					var_43_1(var_43_0, var_43_2, var_3_10004.TAG_CHANGE, var_42_0)

					local var_43_3 = arg_41_0

					var_1.OnFliter(var_43_3, var_42_0)
				end

				return
			end

			SFX_PANEL = var_2_10008

			var_4(var_42_1, var_42_2, var_42_3, var_2_10008)

			setText = var_4

			local var_42_4 = arg_42_2
			local var_42_5 = arg_42_2.Find(var_42_4, "sel/Text")

			AgoraFurnitureType = var_42_4

			var_4(var_42_5, var_42_4.Type2CN(var_42_0))

			table = var_4

			var_4.insert(arg_41_0.toggles, arg_42_2)
		end

		return
	end)

	local var_41_1 = arg_41_0.tagUIItemList
	local var_41_2 = var_1.align

	AgoraFurnitureType = var_3

	var_41_2(var_41_1, #var_3.PLACEMENT_TYPE)

	onToggle = var_41_2

	local var_41_3 = arg_41_0
	local var_41_4 = arg_41_0.themeBtn

	local function var_41_5(arg_44_0)
		if arg_44_0 then
			arg_41_0.selectedTagIndex = nil

			local var_44_0 = arg_41_0

			var_1.FlushThemeList(var_44_0)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_41_2(var_41_3, var_41_4, var_41_5, var_1_10005)

	return
end

function var_0_1.OnInitItem4Theme(arg_45_0, arg_45_1)
	AgoraDecorationThemeCard = var_1_10002

	local var_45_0 = var_1_10002.New(arg_45_1)

	onButton = var_3

	local var_45_1 = arg_45_0
	local var_45_2 = var_45_0.mainTr

	local function var_45_3()
		isa = var_2_10000

		local var_46_0 = var_45_0.theme

		AgoraSystemTheme = var_2_10002

		if var_2_10000(var_46_0, var_2_10002) then
			IslandMsgBox = var_46_0

			if not var_46_0.TYPE_SYSTEM_THEME then
				IslandMsgBox = var_46_0
				var_46_0 = var_46_0.TYPE_THEME
			end

			local var_46_1 = arg_45_0

			var_2.ShowMsgbox(var_46_1, {
				type = var_46_0,
				theme = var_45_0.theme,
				onYes = function()
					local var_47_0 = arg_45_0

					var_0.Op(var_47_0, "ApplyTheme", var_45_0.theme.id, var_0)

					return
				end,
				onDel = function()
					local var_48_0 = arg_45_0

					var_0.Op(var_48_0, "DeleteTheme", var_45_0.theme.id)

					return
				end
			})

			return
		end
	end

	SFX_PANEL = var_1_10007

	var_3(var_45_1, var_45_2, var_45_3, var_1_10007)

	onButton = var_3

	local var_45_4 = arg_45_0
	local var_45_5 = var_45_0.addTr

	local function var_45_6()
		local var_49_0 = arg_45_0
		local var_49_1 = var_0.GetView(var_49_0).agora

		if not var_1.GetUseableThemeId(var_49_1) then
			pg = var_49_1

			local var_49_2 = var_49_1.TipsMgr.GetInstance()

			var_49_1 = var_49_1.ShowTips
			i18n = var_2_10004

			var_49_1(var_49_2, var_2_10004("island_agora_no_pos_place"))

			return
		end

		seriesAsync = var_49_1

		var_49_1({
			function(arg_50_0)
				local var_50_0 = arg_45_0

				var_1.PrepareToTakeScreenshot(var_50_0)

				local var_50_1 = arg_45_0

				var_1.ShootScreen(var_50_1, var_0, arg_50_0)

				return
			end,
			function()
				local var_51_0 = arg_45_0

				var_0.RevertTakeScreenshot(var_51_0)

				local var_51_1 = arg_45_0
				local var_51_2 = var_0.ShowMsgbox
				local var_51_3 = {}

				IslandMsgBox = var_3_10003
				var_51_3.type = var_3_10003.TYPE_SAVE_THEME
				var_51_3.id = var_0

				function var_51_3.onYes(arg_52_0)
					local var_52_0 = arg_45_0

					var_1.Op(var_52_0, "SaveTheme", var_0, arg_52_0)

					return
				end

				var_51_2(var_51_1, var_51_3)

				return
			end
		})

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_45_4, var_45_5, var_45_6, var_1_10007)

	arg_45_0.themeCards[arg_45_1] = var_45_0

	return
end

function var_0_1.PrepareToTakeScreenshot(arg_53_0)
	IslandCameraMgr = var_1_10001

	local var_53_0 = var_1_10001.instance
	local var_53_1 = var_1.ActiveVirtualCamera

	IslandConst = var_1_10003

	var_53_1(var_53_0, var_1_10003.AGORA_CAMERA_SHOOTSCREEN_NAME)

	local var_53_2 = arg_53_0:GetView()

	var_1.ShowOrHideContainer(var_53_2, false)

	return
end

function var_0_1.ShootScreen(arg_54_0, arg_54_1, arg_54_2)
	IslandCameraMgr = var_1_10003

	local var_54_0 = var_1_10003.instance._mainCamera
	local var_54_1 = 426
	local var_54_2 = 320

	BLHX = var_1_10006

	var_1_10006.Rendering.HotUpdate.ScreenShooterPass.TakePhoto(var_54_0, function(arg_55_0)
		local var_55_0
		local var_55_1

		if arg_55_0.width < var_54_1 or arg_55_0.height < var_54_2 then
			var_55_0 = arg_55_0
		else
			var_55_1 = arg_55_0.width * 0.5 - var_54_1 * 0.5

			local var_55_2 = arg_55_0.height * 0.5 - var_54_2 * 0.5
			local var_55_3 = arg_55_0
			local var_55_4 = arg_55_0.GetPixels(var_55_3, var_55_1, var_55_2, var_54_1, var_54_2)

			UnityEngine = var_55_3

			local var_55_5 = var_55_3.Texture2D.New(var_54_1, var_54_2)

			var_55_0.SetPixels(var_55_5, var_55_4)
			var_55_0:Apply()
		end

		Tex2DExtension = var_55_1

		local var_55_6 = var_55_1.EncodeToJPG(var_55_0)

		AgoraCalc = var_3

		local var_55_7 = var_3.BuildScreenShootSavePath(arg_54_1)

		PathMgr = var_4

		if var_4.FileExists(var_55_7) then
			System = var_4

			var_4.IO.File.Delete(var_55_7)
		end

		System = var_4

		var_4.IO.File.WriteAllBytes(var_55_7, var_55_6)
		arg_54_2()

		return
	end)

	return
end

function var_0_1.RevertTakeScreenshot(arg_56_0)
	IslandCameraMgr = var_1_10001

	local var_56_0 = var_1_10001.instance
	local var_56_1 = var_1.ActiveVirtualCamera

	IslandConst = var_1_10003

	var_56_1(var_56_0, var_1_10003.AGORA_CAMERA_NAME)

	local var_56_2 = arg_56_0:GetView()

	var_1.ShowOrHideContainer(var_56_2, true)

	return
end

function var_0_1.OnUpdateItem4Theme(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0

	if not arg_57_0.themeCards[arg_57_2] then
		arg_57_0:OnInitItem4Theme(arg_57_2)

		var_57_0 = arg_57_0.themeCards[arg_57_2]
	end

	local var_57_1 = arg_57_0.displayThemes[arg_57_1 + 1]

	var_57_0:Update(var_57_1)

	return
end

function var_0_1.GetDisplayThemes(arg_58_0)
	local var_58_0 = arg_58_0:GetView().agora
	local var_58_1 = var_2.GetThemes(var_58_0)
	local var_58_2 = {}

	ipairs = var_1_10004

	for iter_58_0, iter_58_1 in var_1_10004(var_58_1) do
		table = var_1_10009

		var_1_10009.insert(var_58_2, iter_58_1)
	end

	local var_58_3 = var_1.agora
	local var_58_4 = var_4.GetMaxCustomThemeCnt(var_58_3)

	if #var_58_1 < var_58_4 then
		table = var_5

		var_5.insert(var_58_2, 1, {
			id = -1
		})
	end

	return var_58_2
end

function var_0_1.OnInitItem(arg_59_0, arg_59_1)
	AgoraDecorationCard = var_1_10002

	local var_59_0 = var_1_10002.New(arg_59_1)
	local var_59_1 = false

	local function var_59_2()
		if var_59_1 then
			local var_60_0 = arg_59_0.descPage

			var_0.ExecuteAction(var_60_0, "Hide")

			var_59_1 = false
		end

		return
	end

	local var_59_3 = var_59_0.onClickEvent

	var_5.RemoveAllListeners(var_59_3)

	local var_59_4 = var_59_0.onClickEvent

	var_5.AddListener(var_59_4, function()
		if var_59_1 then
			var_59_2()

			return
		end

		local var_61_0 = var_59_0.valueObject

		if var_0.GetAvailableItem(var_61_0) then
			local var_61_1 = arg_59_0

			var_1.Op(var_61_1, "ClearNew", var_0.id)
		end

		local var_61_2 = var_59_0.valueObject

		if var_1.IsOptionalShapeType(var_61_2) then
			local var_61_3 = arg_59_0.shapeSelectPanel

			var_1.Show(var_61_3, var_59_0, function(arg_62_0)
				local var_62_0 = arg_59_0
				local var_62_1 = var_1.GetView(var_62_0)

				var_1.EnterPaveTileMode(var_62_1, var_0, arg_62_0)

				return
			end)
		else
			local var_61_4 = var_59_0.valueObject

			if var_1.IsBuilding(var_61_4) then
				if var_0 then
					local var_61_5 = arg_59_0

					var_1.Op(var_61_5, "ReplaceBuilding", var_0.id)
				end
			else
				local var_61_6 = var_59_0.valueObject

				if var_1.IsFoundation(var_61_6) then
					if var_0 then
						local var_61_7 = arg_59_0

						var_1.Op(var_61_7, "ReplaceFoundation", var_0.id)
					end
				else
					local var_61_8 = var_59_0.valueObject

					if var_1.IsUsing(var_61_8) then
						local var_61_9 = var_59_0.valueObject
						local var_61_10 = var_1.GetFirstItem(var_61_9)
						local var_61_11 = arg_59_0

						var_2.Op(var_61_11, "TrySelectItemById", var_61_10.id)

						return
					end

					if var_0 then
						local var_61_12 = arg_59_0

						var_1.Op(var_61_12, "PlaceItemRandonPosition", var_0.id)
					end
				end
			end
		end

		return
	end)

	local var_59_5 = var_59_0.longPressTriggerEvent

	var_5.RemoveAllListeners(var_59_5)

	local var_59_6 = var_59_0.longPressTriggerEvent

	var_5.AddListener(var_59_6, function()
		var_59_1 = true

		local var_63_0 = arg_59_0.descPage

		var_0.ExecuteAction(var_63_0, "Show", var_59_0.valueObject, var_59_0._go.transform.position)

		return
	end)

	local var_59_7 = var_59_0.onReleasedEvent

	var_5.RemoveAllListeners(var_59_7)

	local var_59_8 = var_59_0.onReleasedEvent

	var_5.AddListener(var_59_8, var_59_2)

	arg_59_0.cards[arg_59_1] = var_59_0

	return
end

function var_0_1.OnUpdateItem(arg_64_0, arg_64_1, arg_64_2)
	local var_64_0

	if not arg_64_0.cards[arg_64_2] then
		arg_64_0:OnInitItem(arg_64_2)

		var_64_0 = arg_64_0.cards[arg_64_2]
	end

	local var_64_1 = arg_64_0.displays[arg_64_1 + 1]

	var_64_0:Update(var_64_1, arg_64_0.selectedId)

	return
end

function var_0_1.OnFliter(arg_65_0, arg_65_1)
	arg_65_0.indexData.tag = arg_65_1

	local var_65_0 = arg_65_0.shapeSelectPanel

	var_2.Hide(var_65_0)
	arg_65_0:FlushList()

	return
end

function var_0_1.OnSort(arg_66_0, arg_66_1)
	arg_66_0.indexData.sortKey = arg_66_1

	arg_66_0:UpdateOrderTxt()
	arg_66_0:FlushList()

	return
end

function var_0_1.OnSearch(arg_67_0, arg_67_1)
	arg_67_0.indexData.searchKey = arg_67_1

	arg_67_0:FlushList()

	return
end

function var_0_1.OnOrder(arg_68_0, arg_68_1)
	arg_68_0.indexData.order = arg_68_1

	local var_68_0 = arg_68_0.orderBtn

	Vector3 = var_1_10003
	var_68_0.localScale = var_1_10003(1, arg_68_1 == 1 and 1 or -1, 1)

	arg_68_0:FlushList()

	return
end

function var_0_1.UpdateOrderTxt(arg_69_0)
	local var_69_0 = arg_69_0.orderTxt

	AgoraFurnitureType = var_1_10002
	var_69_0.text = var_1_10002.Sort2CN(arg_69_0.indexData.sortKey)

	return
end

function var_0_1.GetDisplays(arg_70_0)
	local var_70_0 = arg_70_0:GetView().agora
	local var_70_1 = var_2.GetPlaceableList(var_70_0)
	local var_70_2 = {}

	pairs = var_1_10004

	for iter_70_0, iter_70_1 in var_1_10004(var_70_1) do
		if not var_70_2[iter_70_1.configId] then
			local var_70_3 = iter_70_1.configId

			AgoraDecorationVO = var_1_10010
			var_70_2[var_70_3] = var_1_10010.New(iter_70_1.configId, var_1)
		end

		var_1_10010 = var_70_2[iter_70_1.configId]

		var_9.AddItem(var_1_10010, iter_70_1)
	end

	local var_70_4 = {}

	pairs = var_5

	for iter_70_2, iter_70_3 in var_5(var_70_2) do
		if iter_70_3:IsType(arg_70_0.indexData.tag) and iter_70_3:IsMatchSearch(arg_70_0.indexData.searchKey) then
			table = var_10

			var_10.insert(var_70_4, iter_70_3)
		end
	end

	local var_70_5
	local var_70_6 = arg_70_0.indexData.sortKey

	AgoraFurnitureType = var_7

	if var_70_6 == var_7.SORT_DEFAULT then
		var_70_5 = {
			function(arg_71_0)
				return arg_71_0:IsUsing() and 0 or 1
			end,
			function(arg_72_0)
				return arg_72_0:IsNew() and 0 or 1
			end,
			function(arg_73_0)
				return -1 * arg_73_0:GetRarity()
			end,
			function(arg_74_0)
				return -1 * arg_74_0.id
			end
		}
	else
		var_70_5 = {
			function(arg_75_0)
				return arg_75_0:IsUsing() and 0 or 1
			end,
			function(arg_76_0)
				return arg_76_0:IsNew() and 0 or 1
			end,
			function(arg_77_0)
				return -1 * arg_77_0:GetSortValue(arg_70_0.indexData.sortKey, arg_70_0.indexData.order)
			end,
			function(arg_78_0)
				return -1 * arg_78_0.id
			end
		}
	end

	table = var_70_6

	local var_70_7 = var_70_6.sort
	local var_70_8 = var_70_4

	CompareFuncs = iter_70_2

	var_70_7(var_70_8, iter_70_2(var_70_5))

	return var_70_4
end

function var_0_1.Flush(arg_79_0)
	local var_79_0

	if not arg_79_0.selectedTagIndex then
		var_79_0 = 1
	end

	triggerToggle = var_1_10002

	var_1_10002(arg_79_0.toggles[var_79_0], true)
	arg_79_0:FlushCapacity()
	arg_79_0:FlushSaveBtn()

	local var_79_1 = arg_79_0.anim

	var_2.Play(var_79_1, "anim_IslandAgoraDecorationUI_In")

	return
end

function var_0_1.FlushCard(arg_80_0, arg_80_1)
	pairs = var_1_10002

	local var_80_0

	if not arg_80_0.cards then
		var_80_0 = {}
	end

	for iter_80_0, iter_80_1 in var_1_10002(var_80_0) do
		local var_80_1 = iter_80_1.valueObject

		if var_7.Contains(var_80_1, arg_80_1) then
			iter_80_1:Update(iter_80_1.valueObject, arg_80_0.selectedId)

			break
		end
	end

	return
end

function var_0_1.FlushList(arg_81_0)
	isActive = var_1_10001

	if not var_1_10001(arg_81_0.scrollRect) then
		return
	end

	arg_81_0.displays = arg_81_0:GetDisplays()

	local var_81_0 = arg_81_0.scrollRect

	var_1.SetTotalCount(var_81_0, #arg_81_0.displays)

	setActive = var_1

	var_1(arg_81_0.emptyTr, #arg_81_0.displays == 0)

	return
end

function var_0_1.FlushThemeList(arg_82_0)
	isActive = var_1_10001

	if not var_1_10001(arg_82_0.scrollRect4Theme) then
		return
	end

	arg_82_0.displayThemes = arg_82_0:GetDisplayThemes()

	local var_82_0 = arg_82_0.scrollRect4Theme

	var_1.SetTotalCount(var_82_0, #arg_82_0.displayThemes)

	setActive = var_1

	var_1(arg_82_0.emptyTr, false)

	return
end

function var_0_1.FlushCapacity(arg_83_0)
	local var_83_0 = arg_83_0:GetView().agora
	local var_83_1 = var_1.GetCapacity(var_83_0)
	local var_83_2 = arg_83_0:GetView().agora
	local var_83_3 = var_2.GetMaxCapacity(var_83_2)
	local var_83_4 = arg_83_0.capacityTxt

	i18n = var_1_10004
	var_83_4.text = var_1_10004("island_agora_capacity") .. ":<color=#a0ff9d>" .. var_83_1 .. "</color>/" .. var_83_3

	return
end

function var_0_1.FlushSaveBtn(arg_84_0)
	local var_84_0 = arg_84_0:GetView()
	local var_84_1 = var_1.GetController(var_84_0)

	arg_84_0:AddSaveCdTimer(var_84_1.editCdTime)

	return
end

function var_0_1.AddSaveCdTimer(arg_85_0, arg_85_1)
	arg_85_0:RemoveSaveCdTimer()

	pg = var_2

	local var_85_0 = var_2.TimeMgr.GetInstance()
	local var_85_1

	if arg_85_1 - var_2.GetServerTime(var_85_0) <= 0 then
		var_85_1 = arg_85_0.agoraSaveCdTxt
		var_85_1.text = ""
		setActive = var_85_1

		var_85_1(arg_85_0.agoraSaveBtn, true)

		setActive = var_85_1

		var_85_1(arg_85_0.agoraSaveCdBtn, false)

		return
	end

	setActive = var_85_1

	var_85_1(arg_85_0.agoraSaveBtn, false)

	setActive = var_85_1

	var_85_1(arg_85_0.agoraSaveCdBtn, true)

	Timer = var_85_1
	arg_85_0.saveCdTimer = var_85_1.New(function()
		pg = var_2_10000

		local var_86_0 = var_2_10000.TimeMgr.GetInstance()
		local var_86_1 = var_0.GetServerTime(var_86_0)
		local var_86_2

		if arg_85_1 - var_86_1 <= 0 then
			var_86_2 = arg_85_0

			var_1.RemoveSaveCdTimer(var_86_2)

			var_86_2 = arg_85_0

			var_1.FlushSaveBtn(var_86_2)
		else
			local var_86_3 = arg_85_0.agoraSaveCdTxt

			pg = var_86_2

			local var_86_4 = var_86_2.TimeMgr.GetInstance()

			var_86_3.text = var_2.DescCDTimeForMinute(var_86_4, arg_85_1 - var_86_1)
		end

		return
	end, 1, -1)

	local var_85_2 = arg_85_0.saveCdTimer

	var_3.Start(var_85_2)
	arg_85_0.saveCdTimer.func()

	return
end

function var_0_1.RemoveSaveCdTimer(arg_87_0)
	if arg_87_0.saveCdTimer then
		local var_87_0 = arg_87_0.saveCdTimer

		var_1.Stop(var_87_0)

		arg_87_0.saveCdTimer = nil
	end

	return
end

function var_0_1.OnDestroy(arg_88_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_88_0.scrollRect)

	ClearLScrollrect = var_1_10001

	var_1_10001(arg_88_0.scrollRect4Theme)

	if arg_88_0.dftAniEvent then
		local var_88_0 = arg_88_0.dftAniEvent

		var_1.SetEndEvent(var_88_0, nil)
	end

	arg_88_0:RemoveSaveCdTimer()

	if arg_88_0.sortPage then
		local var_88_1 = arg_88_0.sortPage

		var_1.Destroy(var_88_1)

		arg_88_0.sortPage = nil
	end

	if arg_88_0.descPage then
		local var_88_2 = arg_88_0.descPage

		var_1.Destroy(var_88_2)

		arg_88_0.descPage = nil
	end

	if arg_88_0.shapeSelectPanel then
		local var_88_3 = arg_88_0.shapeSelectPanel

		var_1.Destroy(var_88_3)

		arg_88_0.shapeSelectPanel = nil
	end

	pairs = var_1

	local var_88_4

	if not arg_88_0.cards then
		var_88_4 = {}
	end

	for iter_88_0, iter_88_1 in var_1(var_88_4) do
		iter_88_1:Dispose()
	end

	arg_88_0.cards = nil
	pairs = var_1

	local var_88_5

	if not arg_88_0.themeCards then
		var_88_5 = {}
	end

	for iter_88_2, iter_88_3 in var_1(var_88_5) do
		iter_88_3:Dispose()
	end

	arg_88_0.themeCards = nil

	return
end

return var_0_1

class = var_0_10000

local var_0_0 = "AttireCombatUIPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".AttireFramePanel"))

setmetatable = var_0_10001

local function var_0_2(arg_1_0, arg_1_1)
	local var_1_0 = {}

	var_1_0.__cname = "UICARD"

	local function var_1_1(arg_2_0)
		pg = var_2_10001

		var_2_10001.DelegateInfo.New(arg_2_0)

		arg_2_0._go = arg_1_0
		findTF = var_1
		arg_2_0.info = var_1(arg_2_0._go, "info")
		findTF = var_1
		arg_2_0.empty = var_1(arg_2_0._go, "empty")
		findTF = var_1
		arg_2_0.icon = var_1(arg_2_0._go, "info/icon")
		findTF = var_1
		arg_2_0.selected = var_1(arg_2_0._go, "info/selected")
		findTF = var_1
		arg_2_0.nameTxt = var_1(arg_2_0._go, "info/nameMask/name")
		findTF = var_1
		arg_2_0.descTxt = var_1(arg_2_0._go, "info/desc")
		findTF = var_1
		arg_2_0.conditionTxt = var_1(arg_2_0._go, "info/condition")

		local var_2_0 = {}

		findTF = var_2_10002
		var_2_0[1] = var_2_10002(arg_2_0._go, "info/tags/new")
		findTF = var_2
		var_2_0[2] = var_2(arg_2_0._go, "info/tags/e")
		arg_2_0.tags = var_2_0
		findTF = var_2_0
		arg_2_0.crossPrint = var_2_0(arg_2_0._go, "prints/odd")
		findTF = var_1
		arg_2_0.notOwn = var_1(arg_2_0._go, "info/notOwn")
		findTF = var_1
		arg_2_0.tipsGo = var_1(arg_2_0._go, "info/tips")
		findTF = var_1
		arg_2_0.tipsText = var_1(arg_2_0._go, "info/tips/text")
		findTF = var_1
		arg_2_0.toggleItem = var_1(arg_2_0._go, "info/elementList/main_toggle")
		UIItemList = var_1

		local var_2_1 = var_1.New

		findTF = var_3
		arg_2_0.toggleList = var_2_1(var_3(arg_2_0._go, "info/elementList"), arg_2_0.toggleItem)

		local var_2_2 = arg_2_0.toggleList

		var_1.make(var_2_2, function(arg_3_0, arg_3_1, arg_3_2)
			UIItemList = var_3_10003

			if arg_3_0 == var_3_10003.EventUpdate then
				local var_3_0 = arg_2_0.uiStyle
				local var_3_1 = var_3.getConfig(var_3_0, "rare_display")[arg_3_1 + 1]
				local var_3_2 = arg_1_1
				local var_3_3 = var_5.GetSpriteQuiet
				local var_3_4 = "ui/combatskinrare"

				CombatSkinConst = var_3_10009

				local var_3_5 = var_3_10009.TYPE_ICON_NAME[var_3_1]

				findTF = var_3_10010

				var_3_3(var_3_2, var_3_4, var_3_5, var_3_10010(arg_3_2, "on"))

				local var_3_6 = arg_1_1
				local var_3_7 = var_5.GetSpriteQuiet
				local var_3_8 = "ui/combatskinrare"

				string = var_3_5

				local var_3_9 = var_3_5.format
				local var_3_10 = "%s_unselected"

				CombatSkinConst = var_12

				local var_3_11 = var_3_9(var_3_10, var_12.TYPE_ICON_NAME[var_3_1])

				findTF = var_10

				var_3_7(var_3_6, var_3_8, var_3_11, var_10(arg_3_2, "off"))

				onToggle = var_3_7

				var_3_7(arg_2_0, arg_3_2, function(arg_4_0)
					setText = var_4_10001

					local var_4_0 = arg_2_0.tipsText

					i18n = var_4_10004

					var_4_10001(var_4_0, var_4_10004("battleui_display" .. var_0[arg_3_1 + 1]))

					findTF = var_4_10001

					local var_4_1 = var_4_10001(arg_2_0._go, "info")
					local var_4_2 = var_1.InverseTransformPoint(var_4_1, arg_3_2.transform.position)

					setLocalPosition = var_4_10002

					local var_4_3 = arg_2_0.tipsGo

					Vector3 = var_4_10005

					var_4_10002(var_4_3, var_4_2 + var_4_10005(24, 46, 0))

					local var_4_4 = arg_2_0

					var_2.ShowTips(var_4_4, arg_4_0)

					return
				end)
			end

			return
		end)

		UpdateBeat = var_1
		arg_2_0.handle = var_1:CreateListener(arg_2_0.UpdateClick, arg_2_0)
		UpdateBeat = var_1

		var_1:AddListener(arg_2_0.handle)

		return
	end

	function var_1_0.ShowTips(arg_5_0, arg_5_1)
		setActive = var_2_10002

		var_2_10002(arg_5_0.tipsGo, arg_5_1)

		return
	end

	function var_1_0.isEmpty(arg_6_0)
		return not arg_6_0.uiStyle or arg_6_0.uiStyle.id == -1
	end

	function var_1_0.Update(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
		arg_7_0.uiStyle = arg_7_1

		if arg_7_0:isEmpty() then
			setActive = var_6

			var_6(arg_7_0.info, false)

			setActive = var_6

			var_6(arg_7_0.empty, true)

			return
		else
			setActive = var_6

			var_6(arg_7_0.info, true)

			setActive = var_6

			var_6(arg_7_0.empty, false)
		end

		LoadImageSpriteAsync = var_6

		var_6("combatuistyle/" .. arg_7_1:getConfig("icon"), arg_7_0.icon, true)

		setScrollText = var_6

		var_6(arg_7_0.nameTxt, arg_7_1:getConfig("name"))

		setText = var_6

		var_6(arg_7_0.descTxt, arg_7_1:getConfig("desc"))

		setText = var_6

		var_6(arg_7_0.conditionTxt, arg_7_1:getConfig("unlock"))

		local var_7_0 = arg_7_2:getAttireByType(arg_7_1:getType())

		setActive = var_2_10007

		local var_7_1 = arg_7_0.tags[2]
		local var_7_2

		if arg_7_1:isOwned() then
			var_7_2 = var_7_0 == arg_7_1.id
		end

		var_2_10007(var_7_1, var_7_2)

		setActive = var_2_10007

		var_2_10007(arg_7_0.tags[1], arg_7_1:isNew())

		setActive = var_2_10007

		local var_7_3 = arg_7_0.crossPrint

		if not arg_7_3 then
			math = var_10

			local var_7_4

			if var_10.fmod(arg_7_4 + 1, arg_7_5) == 0 then
				var_7_4 = false
			else
				var_7_4 = true
			end

			var_2_10007(var_7_3, var_7_4)

			setActive = var_2_10007

			local var_7_5 = arg_7_0.notOwn
			local var_7_6 = arg_7_1

			var_2_10007(var_7_5, not arg_7_1.isOwned(var_7_6))

			local var_7_7 = arg_7_1:getConfig("rare")
			local var_7_8 = arg_1_1
			local var_7_9 = var_8.GetSpriteQuiet
			local var_7_10 = "ui/combatskinrare"

			string = var_7_6

			local var_7_11 = var_7_6.format("rare_%s", var_7_7)

			findTF = var_2_10013

			var_7_9(var_7_8, var_7_10, var_7_11, var_2_10013(arg_7_0._go, "info/rareImage"))

			local var_7_12 = arg_7_1:getConfig("rare_display")
			local var_7_13 = arg_7_0.toggleList

			var_9.align(var_7_13, #var_7_12)

			return
		end
	end

	function var_1_0.UpdateClick(arg_8_0)
		UnityEngine = var_2_10001

		if var_2_10001.Input.GetMouseButtonDown(0) then
			local var_8_0 = arg_8_0.toggleList

			var_1.each(var_8_0, function(arg_9_0, arg_9_1)
				GetComponent = var_3_10002

				local var_9_0 = arg_9_1

				typeof = var_3_10005
				Toggle = var_3_10007
				var_3_10002(var_9_0, var_3_10005(var_3_10007)).isOn = false

				return
			end)
		end

		return
	end

	function var_1_0.Dispose(arg_10_0)
		UpdateBeat = var_2_10001

		var_2_10001:RemoveListener(arg_10_0.handle)

		pg = var_1

		var_1.DelegateInfo.Dispose(arg_10_0)

		return
	end

	function var_1_0.UpdateSelected(arg_11_0, arg_11_1)
		setActive = var_2_10002

		var_2_10002(arg_11_0.selected, arg_11_1)

		return
	end

	function var_1_0.IsOwned(arg_12_0)
		local var_12_0 = arg_12_0.uiStyle

		return var_1.isOwned(var_12_0)
	end

	var_1_1(var_1_0)

	return var_1_0
end

function var_0_1.OnInit(arg_13_0)
	local var_13_0 = arg_13_0._tf

	arg_13_0.listPanel = var_1.Find(var_13_0, "list_panel")

	local var_13_1 = arg_13_0.listPanel
	local var_13_2 = var_1.Find(var_13_1, "scrollrect")

	arg_13_0.scolrect = var_1.GetComponent(var_13_2, "LScrollRect")

	local var_13_3 = arg_13_0.listPanel

	arg_13_0.confirmBtn = var_1.Find(var_13_3, "confirm")

	local var_13_4 = arg_13_0.listPanel

	arg_13_0.previewBtn = var_1.Find(var_13_4, "preview")

	local var_13_5 = arg_13_0.listPanel

	arg_13_0.lockBtn = var_1.Find(var_13_5, "lock")

	function arg_13_0.scolrect.onInitItem(arg_14_0)
		local var_14_0 = arg_13_0

		var_1.OnInitItem(var_14_0, arg_14_0)

		return
	end

	function arg_13_0.scolrect.onUpdateItem(arg_15_0, arg_15_1)
		local var_15_0 = arg_13_0

		var_2.OnUpdateItem(var_15_0, arg_15_0, arg_15_1)

		return
	end

	function arg_13_0.scolrect.onReturnItem(arg_16_0, arg_16_1)
		local var_16_0 = arg_13_0

		var_2.OnReturnItem(var_16_0, arg_16_0, arg_16_1)

		return
	end

	arg_13_0.cards = {}

	local var_13_6 = arg_13_0._tf
	local var_13_7 = var_1.Find(var_13_6, "total_count/Text")
	local var_13_8 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_13_0.totalCount = var_13_8(var_13_7, var_4(var_1_10006))

	local var_13_9 = arg_13_0._tf

	arg_13_0.preview = var_1.Find(var_13_9, "preview")

	local var_13_10 = arg_13_0._tf

	arg_13_0.sea = var_1.Find(var_13_10, "preview/sea")

	local var_13_11 = arg_13_0.sea

	arg_13_0.rawImage = var_1.GetComponent(var_13_11, "RawImage")

	local var_13_12 = arg_13_0._tf

	arg_13_0.uiLayer = var_1.Find(var_13_12, "preview/ui")
	setText = var_1

	local var_13_13 = arg_13_0.preview
	local var_13_14 = var_3.Find(var_13_13, "bg/title/Image")

	i18n = var_4

	var_1(var_13_14, var_4("word_preview"))

	setText = var_1

	local var_13_15 = arg_13_0.confirmBtn
	local var_13_16 = var_3.Find(var_13_15, "Text")

	i18n = var_4

	var_1(var_13_16, var_4("attire_combatui_confirm"))

	setText = var_1

	local var_13_17 = arg_13_0.previewBtn
	local var_13_18 = var_3.Find(var_13_17, "Text")

	i18n = var_4

	var_1(var_13_18, var_4("attire_combatui_preview"))

	setText = var_1

	local var_13_19 = arg_13_0.lockBtn
	local var_13_20 = var_3.Find(var_13_19, "Text")

	i18n = var_4

	var_1(var_13_20, var_4("index_not_obtained"))

	setActive = var_1

	var_1(arg_13_0.preview, false)

	setActive = var_1

	var_1(arg_13_0.rawImage, false)

	onButton = var_1

	var_1(arg_13_0, arg_13_0.preview, function()
		local var_17_0 = arg_13_0

		var_0.onBackPressed(var_17_0)

		return
	end)

	AutoLoader = var_1
	arg_13_0.loader = var_1.New()

	return
end

function var_0_1.getUIName(arg_18_0)
	return "AttireCombatUIUI"
end

function var_0_1.GetData(arg_19_0)
	return arg_19_0.rawAttireVOs.combatUIStyles
end

function var_0_1.OnInitItem(arg_20_0, arg_20_1)
	local var_20_0 = var_0_2(arg_20_1, arg_20_0.loader)
	local var_20_1 = arg_20_0.cards

	var_20_1[arg_20_1] = var_20_0
	onButton = var_20_1

	local var_20_2 = arg_20_0
	local var_20_3 = var_20_0._go

	local function var_20_4()
		local var_21_0 = var_20_0

		if not var_0.isEmpty(var_21_0) then
			if arg_20_0.card then
				local var_21_1 = arg_20_0.card

				var_0.UpdateSelected(var_21_1, false)
			end

			arg_20_0.contextData.iconFrameId = var_20_0.uiStyle.id

			local var_21_2 = arg_20_0

			var_0.UpdateDesc(var_21_2, var_20_0)

			local var_21_3 = var_20_0

			var_0.UpdateSelected(var_21_3, true)

			arg_20_0.card = var_20_0

			local var_21_4 = var_20_0

			if var_0.IsOwned(var_21_4) then
				setActive = var_0

				var_0(arg_20_0.confirmBtn, true)

				setActive = var_0

				var_0(arg_20_0.lockBtn, false)
			else
				setActive = var_0

				var_0(arg_20_0.confirmBtn, false)

				setActive = var_0

				var_0(arg_20_0.lockBtn, true)
			end
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_20_1(var_20_2, var_20_3, var_20_4, var_1_10008)

	return
end

function var_0_1.OnReturnItem(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0.cards[arg_22_2] then
		var_3:Dispose()
	end

	arg_22_0.cards[arg_22_2] = nil

	return
end

function var_0_1.GetColumn(arg_23_0)
	return 2
end

function var_0_1.OnUpdateItem(arg_24_0, arg_24_1, arg_24_2)
	var_0_1.super.OnUpdateItem(arg_24_0, arg_24_1, arg_24_2)

	local var_24_0 = arg_24_0.playerVO
	local var_24_1 = var_3.getAttireByType

	AttireConst = var_6

	local var_24_2 = var_24_1(var_24_0, var_6.TYPE_COMBAT_UI_STYLE)

	if arg_24_0.cards[arg_24_2].uiStyle.id == var_24_2 then
		triggerButton = var_5

		var_5(var_4._go)
	end

	return
end

function var_0_1.GetDisplayVOs(arg_25_0)
	local var_25_0 = {}
	local var_25_1 = 0

	pairs = var_1_10003

	for iter_25_0, iter_25_1 in var_1_10003(arg_25_0:GetData()) do
		table = var_1_10008

		var_1_10008.insert(var_25_0, iter_25_1)

		var_1_10008 = iter_25_1:getState()
		AttireFrame = var_1_10009

		if var_1_10008 == var_1_10009.STATE_UNLOCK then
			var_1_10008 = iter_25_1.id

			if 0 <= var_1_10008 then
				var_25_1 = var_25_1 + 1
			end
		end
	end

	return var_25_0, var_25_1
end

function var_0_1.UpdateDesc(arg_26_0, arg_26_1)
	if arg_26_1:isEmpty() then
		return
	end

	onButton = var_2

	local var_26_0 = arg_26_0
	local var_26_1 = arg_26_0.confirmBtn

	local function var_26_2()
		local var_27_0 = arg_26_1.uiStyle
		local var_27_1 = var_0.getType(var_27_0)
		local var_27_2 = arg_26_0
		local var_27_3 = var_1.emit

		AttireMediator = var_2_10004

		var_27_3(var_27_2, var_2_10004.ON_APPLY, var_27_1, arg_26_1.uiStyle.id)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_26_0, var_26_1, var_26_2, var_1_10007)

	Ship = var_2

	local var_26_3 = var_2.New({
		id = 100001,
		configId = 100001,
		skin_id = 100000
	})

	Ship = var_1_10003

	local var_26_4 = var_1_10003.New({
		id = 100011,
		configId = 100011,
		skin_id = 100010
	})
	local var_26_5 = arg_26_1.uiStyle
	local var_26_6 = var_4.getConfig(var_26_5, "key")

	onButton = var_5

	local var_26_7 = arg_26_0
	local var_26_8 = arg_26_0.previewBtn

	local function var_26_9()
		local var_28_0 = arg_26_0

		CombatPreviewLayer = var_2_10001

		local var_28_1 = var_2_10001.New

		pg = var_2_10003
		var_28_0.combatPreview = var_28_1(var_2_10003.UIMgr.GetInstance().OverlayMain)

		local var_28_2 = arg_26_0.combatPreview
		local var_28_3 = var_0.ExecuteAction
		local var_28_4 = "Show"
		local var_28_5 = arg_26_1.uiStyle

		var_28_3(var_28_2, var_28_4, var_4.getConfig(var_28_5, "id"), function()
			local var_29_0 = arg_26_0.combatPreview

			var_0.Destroy(var_29_0)

			arg_26_0.combatPreview = nil

			return
		end)

		return
	end

	SFX_PANEL = var_1_10010

	var_5(var_26_7, var_26_8, var_26_9, var_1_10010)

	return
end

function var_0_1.onBackPressed(arg_30_0)
	if arg_30_0.combatPreview then
		local var_30_0 = arg_30_0.combatPreview

		var_1.Destroy(var_30_0)

		arg_30_0.combatPreview = nil

		return true
	end

	return
end

function var_0_1.OnDestroy(arg_31_0)
	local var_31_0 = arg_31_0.loader

	var_1.Clear(var_31_0)

	return
end

return var_0_1

class = var_0_10000

local var_0_0 = "WorldPortLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.Listeners = {
	onUpdateNGoods = "OnUpdateNGoods",
	onUpdateMoneyCount = "OnUpdateMoneyCount",
	onUpdateTasks = "OnUpdateTasks",
	onUpdateGoods = "OnUpdateGoods"
}
var_0_1.TitleName = {
	"text_gangkou",
	"text_operation",
	"text_supply"
}
var_0_1.PageMain = 0
var_0_1.PageTask = 1
var_0_1.PageShop = 2
var_0_1.PageDockyard = 3
var_0_1.PageNShop = 4
var_0_1.BlurPages = {
	[var_0_1.PageTask] = true,
	[var_0_1.PageShop] = true,
	[var_0_1.PageNShop] = true
}
var_0_1.optionsPath = {
	"blur_panel/adapt/top/title/option"
}

function var_0_1.getUIName(arg_1_0)
	return "WorldPortUI"
end

function var_0_1.init(arg_2_0)
	pairs = var_1_10001

	for iter_2_0, iter_2_1 in var_1_10001(var_0_1.Listeners) do
		arg_2_0[iter_2_0] = function(...)
			var_0_1[iter_2_1](arg_2_0, ...)

			return
		end
	end

	local var_2_0 = arg_2_0._tf

	arg_2_0.rtBg = var_1.Find(var_2_0, "bg")

	local var_2_1 = arg_2_0.rtBg

	arg_2_0.rtEnterIcon = var_1.Find(var_2_1, "enter_icon")

	local var_2_2 = arg_2_0._tf

	arg_2_0.rtBgNShop = var_1.Find(var_2_2, "bg_2")

	local var_2_3 = arg_2_0._tf

	arg_2_0.rtBlurPanel = var_1.Find(var_2_3, "blur_panel")

	local var_2_4 = arg_2_0.rtBlurPanel

	arg_2_0.rtTasks = var_1.Find(var_2_4, "adapt/tasks")

	local var_2_5 = arg_2_0.rtBlurPanel

	arg_2_0.rtShop = var_1.Find(var_2_5, "adapt/shop")

	local var_2_6 = arg_2_0.rtShop

	arg_2_0.rtPainting = var_1.Find(var_2_6, "paint")

	local var_2_7 = arg_2_0.rtShop

	arg_2_0.btnPainting = var_1.Find(var_2_7, "paint_touch")
	setActive = var_1

	var_1(arg_2_0.btnPainting, false)

	local var_2_8 = arg_2_0.rtShop

	arg_2_0.rtChat = var_1.Find(var_2_8, "chat")
	setActive = var_1

	var_1(arg_2_0.rtChat, false)

	local var_2_9 = arg_2_0.rtBlurPanel

	arg_2_0.rtNShop = var_1.Find(var_2_9, "adapt/new_shop")

	local var_2_10 = arg_2_0.rtNShop

	arg_2_0.containerPort = var_1.Find(var_2_10, "frame/content/left")

	local var_2_11 = arg_2_0.containerPort

	arg_2_0.tplPort = var_1.Find(var_2_11, "port_tpl")
	arg_2_0.poolTplPort = {
		arg_2_0.tplPort
	}

	local var_2_12 = arg_2_0.rtNShop

	arg_2_0.rtNGoodsContainer = var_1.Find(var_2_12, "frame/content/right/page/view/content")

	local var_2_13 = arg_2_0.rtNShop

	arg_2_0.rtNShopRes = var_1.Find(var_2_13, "frame/content/right/page/title/res")
	Drop = var_1

	local var_2_14 = var_1.New
	local var_2_15 = {}

	DROP_TYPE_WORLD_ITEM = var_3
	var_2_15.type = var_3
	WorldItem = var_3
	var_2_15.id = var_3.PortMoneyId

	local var_2_16 = var_2_14(var_2_15)

	GetImageSpriteFromAtlasAsync = var_2_15

	local var_2_17 = var_2_16:getIcon()
	local var_2_18 = ""
	local var_2_19 = arg_2_0.rtNShopRes

	var_2_15(var_2_17, var_2_18, var_5.Find(var_2_19, "icon/Image"), false)

	setText = var_2_15

	local var_2_20 = arg_2_0.rtNShopRes

	var_2_15(var_3.Find(var_2_20, "icon/name"), var_2_16:getName())

	local var_2_21 = arg_2_0.rtBlurPanel

	arg_2_0.rtTop = var_2.Find(var_2_21, "adapt/top")

	local var_2_22 = arg_2_0.rtTop

	arg_2_0.btnBack = var_2.Find(var_2_22, "title/back_button")

	local var_2_23 = arg_2_0.rtTop

	arg_2_0.rtTopTitle = var_2.Find(var_2_23, "title")

	local var_2_24 = arg_2_0.rtTopTitle

	arg_2_0.rtImageTitle = var_2.Find(var_2_24, "print/title")

	local var_2_25 = arg_2_0.rtTopTitle

	arg_2_0.rtImageTitleTask = var_2.Find(var_2_25, "print/title_task")

	local var_2_26 = arg_2_0.rtTopTitle

	arg_2_0.rtImageTitleShop = var_2.Find(var_2_26, "print/title_shop")

	local var_2_27 = arg_2_0.rtTop

	arg_2_0.rtTopLeft = var_2.Find(var_2_27, "left_stage")

	local var_2_28 = arg_2_0.rtTop

	arg_2_0.rtTopRight = var_2.Find(var_2_28, "right_stage")
	WSWorldInfo = var_2
	arg_2_0.wsWorldInfo = var_2.New()

	local var_2_29 = arg_2_0.wsWorldInfo
	local var_2_30 = arg_2_0.rtTopRight

	var_2_29.transform = var_3.Find(var_2_30, "display_panel/world_info")

	local var_2_31 = arg_2_0.wsWorldInfo

	var_2.Setup(var_2_31)

	setText = var_2

	local var_2_32 = arg_2_0.rtTopRight
	local var_2_33 = var_3.Find(var_2_32, "display_panel/title/title")

	i18n = var_2_32

	var_2(var_2_33, var_2_32("world_map_title_tips"))

	setText = var_2

	local var_2_34 = arg_2_0.rtTopRight
	local var_2_35 = var_3.Find(var_2_34, "display_panel/title/title_en")

	i18n = var_2_34

	var_2(var_2_35, var_2_34("world_map_title_tips_en"))

	setText = var_2

	local var_2_36 = arg_2_0.wsWorldInfo.transform
	local var_2_37 = var_3.Find(var_2_36, "power/bg/Word")

	i18n = var_2_36

	var_2(var_2_37, var_2_36("world_total_power"))

	setText = var_2

	local var_2_38 = arg_2_0.wsWorldInfo.transform
	local var_2_39 = var_3.Find(var_2_38, "explore/mileage/Text")

	i18n = var_2_38

	var_2(var_2_39, var_2_38("world_mileage"))

	setText = var_2

	local var_2_40 = arg_2_0.wsWorldInfo.transform
	local var_2_41 = var_3.Find(var_2_40, "explore/pressing/Text")

	i18n = var_2_40

	var_2(var_2_41, var_2_40("world_pressing"))

	local var_2_42 = arg_2_0.rtTop

	arg_2_0.rtTopBottom = var_2.Find(var_2_42, "bottom_stage")

	local var_2_43 = arg_2_0.rtTopBottom

	arg_2_0.btnOperation = var_2.Find(var_2_43, "btn/operation")

	local var_2_44 = arg_2_0.rtTopBottom

	arg_2_0.btnSupply = var_2.Find(var_2_44, "btn/supply")

	local var_2_45 = arg_2_0.rtTopBottom

	arg_2_0.btnDockyard = var_2.Find(var_2_45, "btn/dockyard")
	WorldResource = var_2
	arg_2_0.resPanel = var_2.New()

	local var_2_46 = arg_2_0.resPanel._tf
	local var_2_47 = var_2.SetParent
	local var_2_48 = arg_2_0.rtTop

	var_2_47(var_2_46, var_4.Find(var_2_48, "title/resources"), false)

	local var_2_49 = arg_2_0._tf

	arg_2_0.rtTaskWindow = var_2.Find(var_2_49, "task_window")
	arg_2_0.wsTasks = {}
	arg_2_0.wsGoods = {}
	arg_2_0.page = -1
	arg_2_0.dirtyFlags = {}

	local var_2_50 = arg_2_0.rtShop

	arg_2_0.cdTF = var_2.Find(var_2_50, "timer_bg")

	local var_2_51 = arg_2_0.rtShop

	arg_2_0.emptyTF = var_2.Find(var_2_51, "frame/scrollview/empty")

	local var_2_52 = arg_2_0.rtShop

	arg_2_0.refreshBtn = var_2.Find(var_2_52, "refresh_btn")
	setActive = var_2

	var_2(arg_2_0.refreshBtn, false)

	local var_2_53 = arg_2_0._tf
	local var_2_54 = var_2.Find(var_2_53, "resource/material1")
	local var_2_55 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_2_0.glitchArtMaterial = var_2_55(var_2_54, var_4(var_5)).material
	OriginShopSingleWindow = var_2
	arg_2_0.singleWindow = var_2.New(arg_2_0._tf, arg_2_0.event)
	OriginShopMultiWindow = var_2
	arg_2_0.multiWindow = var_2.New(arg_2_0._tf, arg_2_0.event)

	return
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:BlurPanel(arg_4_0._tf)

	onButton = var_1

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.btnBack

	local function var_4_2()
		if arg_4_0.isTweening then
			return
		end

		local var_5_0 = arg_4_0.port

		if var_0.IsTempPort(var_5_0) or arg_4_0.page == var_0_1.PageMain then
			local var_5_1 = arg_4_0

			var_0.EaseOutUI(var_5_1, function()
				local var_6_0 = arg_4_0

				var_0.closeView(var_6_0)

				return
			end)
		else
			local var_5_2 = arg_4_0

			var_0.SetPage(var_5_2, var_0_1.PageMain)
		end

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_4_0, var_4_1, var_4_2, var_1_10005)

	onButton = var_1

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.btnOperation

	local function var_4_5()
		local var_7_0 = arg_4_0

		var_0.SetPage(var_7_0, var_0_1.PageTask)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_4_3, var_4_4, var_4_5, var_1_10005)

	onButton = var_1

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.btnSupply

	local function var_4_8()
		nowWorld = var_2_10000

		local var_8_0 = var_2_10000()

		if var_0.UsePortNShop(var_8_0) then
			local var_8_1 = arg_4_0

			var_0.SetPage(var_8_1, var_0_1.PageNShop)
		else
			local var_8_2 = arg_4_0

			var_0.SetPage(var_8_2, var_0_1.PageShop)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_4_6, var_4_7, var_4_8, var_1_10005)

	onButton = var_1

	local var_4_9 = arg_4_0
	local var_4_10 = arg_4_0.btnDockyard

	local function var_4_11()
		local var_9_0 = arg_4_0
		local var_9_1 = var_0.emit

		WorldPortMediator = var_2_10002

		var_9_1(var_9_0, var_2_10002.OnOpenBay)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_4_9, var_4_10, var_4_11, var_1_10005)
	arg_4_0:UpdatePainting(arg_4_0:GetPaintingInfo())
	arg_4_0:UpdateTaskTip()
	arg_4_0:UpdateCDTip()
	arg_4_0:UpdateNShopTip()

	local var_4_12 = arg_4_0.port

	if var_1.IsTempPort(var_4_12) then
		local var_4_13 = arg_4_0.contextData

		WorldPortLayer = var_4_12
		var_4_13.page = var_4_12.PageShop
	else
		local var_4_14 = arg_4_0.contextData.page

		WorldPortLayer = var_4_12

		if var_4_14 == var_4_12.PageDockyard then
			arg_4_0.contextData.page = nil
		end
	end

	local var_4_15 = arg_4_0
	local var_4_16 = arg_4_0.SetPage
	local var_4_17

	if not arg_4_0.contextData.page then
		WorldPortLayer = var_4_17
		var_4_17 = var_4_17.PageMain
	end

	var_4_16(var_4_15, var_4_17)
	arg_4_0:EaseInUI()

	return
end

function var_0_1.onBackPressed(arg_10_0)
	triggerButton = var_1_10001

	var_1_10001(arg_10_0.btnBack)

	return
end

function var_0_1.willExit(arg_11_0)
	arg_11_0:UnOverlayPanel(arg_11_0._tf)
	arg_11_0:RecyclePainting(arg_11_0.rtPainting)

	local var_11_0 = arg_11_0.singleWindow

	var_1.Destroy(var_11_0)

	local var_11_1 = arg_11_0.multiWindow

	var_1.Destroy(var_11_1)

	arg_11_0.contextData.isEnter = true

	if var_0_1.BlurPages[arg_11_0.page] then
		pg = var_1

		local var_11_2 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_11_2, arg_11_0.rtBlurPanel, arg_11_0._tf)
	end

	arg_11_0:CancelUITween()
	arg_11_0:DisposeTopUI()
	arg_11_0:DisposeTasks()
	arg_11_0:DisposeGoods()

	local var_11_3 = arg_11_0.atlas
	local var_11_4 = var_1.RemoveListener

	WorldAtlas = var_3

	var_11_4(var_11_3, var_3.EventUpdateNGoodsCount, arg_11_0.onUpdateNGoods)

	arg_11_0.atlas = nil

	local var_11_5 = arg_11_0.port
	local var_11_6 = var_1.RemoveListener

	WorldMapPort = var_3

	var_11_6(var_11_5, var_3.EventUpdateTaskIds, arg_11_0.onUpdateTasks)

	local var_11_7 = arg_11_0.port
	local var_11_8 = var_1.RemoveListener

	WorldMapPort = var_3

	var_11_8(var_11_7, var_3.EventUpdateGoods, arg_11_0.onUpdateGoods)

	arg_11_0.port = nil

	local var_11_9 = arg_11_0.resPanel

	var_1.exit(var_11_9)

	arg_11_0.resPanel = nil

	local var_11_10 = arg_11_0.refreshTimer

	var_1.Stop(var_11_10)

	arg_11_0.refreshTimer = nil

	local var_11_11 = arg_11_0.inventory
	local var_11_12 = var_1.RemoveListener

	WorldInventoryProxy = var_3

	var_11_12(var_11_11, var_3.EventUpdateItem, arg_11_0.onUpdateMoneyCount)

	arg_11_0.inventory = nil

	local var_11_13 = arg_11_0.taskProxy
	local var_11_14 = var_1.RemoveListener

	WorldTaskProxy = var_3

	var_11_14(var_11_13, var_3.EventUpdateTask, arg_11_0.onUpdateTasks)

	arg_11_0.taskProxy = nil

	local var_11_15 = arg_11_0.wsWorldInfo

	var_1.Dispose(var_11_15)

	arg_11_0.wsWorldInfo = nil

	return
end

function var_0_1.GetPaintingInfo(arg_12_0)
	local var_12_0 = arg_12_0.port

	if var_1.IsTempPort(var_12_0) then
		return "mingshi", false
	else
		return "tbniang", true
	end

	return
end

function var_0_1.UpdatePainting(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.paintingName = arg_13_1
	setPaintingPrefab = var_1_10003

	var_1_10003(arg_13_0.rtPainting, arg_13_1, "chuanwu")

	if arg_13_2 then
		arg_13_0:AddGlitchArtEffectForPating(arg_13_0.rtPainting)
	end

	return
end

function var_0_1.AddGlitchArtEffectForPating(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1
	local var_14_1 = arg_14_1.GetComponentsInChildren

	typeof = var_1_10004
	Image = var_1_10005

	local var_14_2 = var_14_1(var_14_0, var_1_10004(var_1_10005))
	local var_14_3 = var_2.ToTable(var_14_2)

	ipairs = var_14_2

	for iter_14_0, iter_14_1 in var_14_2(var_14_3) do
		iter_14_1.material = arg_14_0.glitchArtMaterial
	end

	return
end

function var_0_1.RecyclePainting(arg_15_0, arg_15_1)
	if arg_15_1:Find("fitter").childCount > 0 then
		local var_15_0 = arg_15_1
		local var_15_1 = arg_15_1.GetComponentsInChildren

		typeof = var_4
		Image = var_1_10005

		local var_15_2 = var_15_1(var_15_0, var_4(var_1_10005))
		local var_15_3 = var_2.ToTable(var_15_2)

		ipairs = var_15_2

		for iter_15_0, iter_15_1 in var_15_2(var_15_3) do
			Color = var_1_10008
			var_1_10008 = var_1_10008.white

			if iter_15_1.material ~= iter_15_1.defaultGraphicMaterial then
				iter_15_1.material = iter_15_1.defaultGraphicMaterial

				local var_15_4 = iter_15_1.material

				var_9.SetColor(var_15_4, "_Color", var_1_10008)
			end
		end

		setGray = var_3

		var_3(arg_15_1, false, true)

		local var_15_5 = arg_15_1:Find("fitter")
		local var_15_6 = var_3.GetChild(var_15_5, 0)

		retPaintingPrefab = var_15_5

		var_15_5(arg_15_1, var_15_6.name)

		local var_15_7 = var_15_6

		if var_15_6.Find(var_15_7, "temp_mask") then
			Destroy = var_15_7

			var_15_7(var_4)
		end
	end

	return
end

function var_0_1.DisplayTopUI(arg_16_0, arg_16_1)
	setActive = var_1_10002

	var_1_10002(arg_16_0.rtImageTitle, arg_16_1 == var_0_1.PageMain)

	setActive = var_1_10002

	var_1_10002(arg_16_0.rtImageTitleTask, arg_16_1 == var_0_1.PageTask)

	setActive = var_1_10002

	var_1_10002(arg_16_0.rtImageTitleShop, arg_16_1 == var_0_1.PageShop or arg_16_1 == var_0_1.PageNShop)

	setActive = var_1_10002

	var_1_10002(arg_16_0.rtTopLeft, arg_16_1 ~= var_0_1.PageNShop)

	setActive = var_1_10002

	var_1_10002(arg_16_0.rtTopRight, arg_16_1 == var_0_1.PageMain)

	setActive = var_1_10002

	var_1_10002(arg_16_0.rtTopBottom, arg_16_1 == var_0_1.PageMain)

	setActive = var_1_10002

	var_1_10002(arg_16_0.rtBg, arg_16_1 ~= var_0_1.PageNShop)

	setActive = var_1_10002

	var_1_10002(arg_16_0.rtBgNShop, arg_16_1 == var_0_1.PageNShop)

	return
end

function var_0_1.DisposeTopUI(arg_17_0)
	local var_17_0 = arg_17_0.wsPortLeft

	var_1.Dispose(var_17_0)

	return
end

function var_0_1.NewPortLeft(arg_18_0)
	WSPortLeft = var_1_10001

	local var_18_0 = var_1_10001.New()

	var_18_0.transform = arg_18_0.rtTopLeft

	var_18_0:Setup()

	local var_18_1 = var_18_0
	local var_18_2 = var_18_0.UpdateMap

	nowWorld = var_1_10004

	local var_18_3 = var_1_10004()

	var_18_2(var_18_1, var_4.GetActiveMap(var_18_3))

	return var_18_0
end

function var_0_1.EnterPortAnim(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.rtEnterIcon
	local var_19_1 = var_2.GetComponent

	typeof = var_1_10004
	DftAniEvent = var_1_10005

	if var_19_1(var_19_0, var_1_10004(var_1_10005)) then
		var_2:SetTriggerEvent(function(arg_20_0)
			arg_19_1()

			return
		end)
		var_2:SetEndEvent(function(arg_21_0)
			setActive = var_2_10001

			var_2_10001(arg_19_0.rtEnterIcon, false)

			return
		end)
	end

	setActive = var_19_0

	var_19_0(arg_19_0.rtEnterIcon, true)

	return
end

function var_0_1.EaseInUI(arg_22_0, arg_22_1)
	arg_22_0.isTweening = true

	local var_22_0 = {}

	arg_22_0:CancelUITween()

	if #arg_22_0.enterIcon > 0 and not arg_22_0.contextData.isEnter then
		table = var_3

		var_3.insert(var_22_0, function(arg_23_0)
			setActive = var_2_10001

			var_2_10001(arg_22_0.rtTop, false)

			local var_23_0 = arg_22_0

			var_1.EnterPortAnim(var_23_0, function()
				setActive = var_3_10000

				var_3_10000(arg_22_0.rtTop, true)

				return arg_23_0()
			end)

			return
		end)
	else
		setActive = var_3

		var_3(arg_22_0.rtEnterIcon, false)
	end

	seriesAsync = var_3

	var_3(var_22_0, function()
		setAnchoredPosition = var_2_10000

		var_2_10000(arg_22_0.rtTopLeft, {
			x = -arg_22_0.rtTopLeft.rect.width
		})

		setAnchoredPosition = var_2_10000

		var_2_10000(arg_22_0.rtTopRight, {
			x = arg_22_0.rtTopRight.rect.width
		})

		setAnchoredPosition = var_2_10000

		var_2_10000(arg_22_0.rtTopTitle, {
			y = arg_22_0.rtTopTitle.rect.height
		})

		setAnchoredPosition = var_2_10000

		var_2_10000(arg_22_0.rtTopBottom, {
			y = -arg_22_0.rtTopRight.rect.height
		})

		LeanTween = var_2_10000

		local var_25_0 = var_2_10000.moveX
		local var_25_1 = arg_22_0.rtTopLeft
		local var_25_2 = 0

		WorldConst = var_3

		local var_25_3 = var_25_0(var_25_1, var_25_2, var_3.UIEaseDuration)
		local var_25_4 = var_0.setEase

		LeanTweenType = var_25_2

		var_25_4(var_25_3, var_25_2.easeOutSine)

		LeanTween = var_25_4

		local var_25_5 = var_25_4.moveX
		local var_25_6 = arg_22_0.rtTopRight
		local var_25_7 = 0

		WorldConst = var_3

		local var_25_8 = var_25_5(var_25_6, var_25_7, var_3.UIEaseDuration)
		local var_25_9 = var_0.setEase

		LeanTweenType = var_25_7

		var_25_9(var_25_8, var_25_7.easeOutSine)

		LeanTween = var_25_9

		local var_25_10 = var_25_9.moveY
		local var_25_11 = arg_22_0.rtTopTitle
		local var_25_12 = 0

		WorldConst = var_3

		local var_25_13 = var_25_10(var_25_11, var_25_12, var_3.UIEaseDuration)
		local var_25_14 = var_0.setEase

		LeanTweenType = var_25_12

		var_25_14(var_25_13, var_25_12.easeOutSine)

		LeanTween = var_25_14

		local var_25_15 = var_25_14.moveY
		local var_25_16 = arg_22_0.rtTopBottom
		local var_25_17 = 0

		WorldConst = var_3

		local var_25_18 = var_25_15(var_25_16, var_25_17, var_3.UIEaseDuration)
		local var_25_19 = var_0.setEase

		LeanTweenType = var_25_17

		local var_25_20 = var_25_19(var_25_18, var_25_17.easeOutSine)
		local var_25_21 = var_0.setOnComplete

		System = var_2

		var_25_21(var_25_20, var_2.Action(function()
			local var_26_0 = arg_22_0

			var_26_0.isTweening = false
			existCall = var_26_0

			return var_26_0(arg_22_1)
		end))

		return
	end)

	return
end

function var_0_1.EaseOutUI(arg_27_0, arg_27_1)
	arg_27_0:CancelUITween()

	LeanTween = var_2

	local var_27_0 = var_2.moveX
	local var_27_1 = arg_27_0.rtTopLeft
	local var_27_2 = -arg_27_0.rtTopLeft.rect.width

	WorldConst = var_1_10005

	local var_27_3 = var_27_0(var_27_1, var_27_2, var_1_10005.UIEaseDuration)
	local var_27_4 = var_2.setEase

	LeanTweenType = var_27_2

	var_27_4(var_27_3, var_27_2.easeOutSine)

	LeanTween = var_27_4

	local var_27_5 = var_27_4.moveX
	local var_27_6 = arg_27_0.rtTopRight
	local var_27_7 = arg_27_0.rtTopRight.rect.width

	WorldConst = var_5

	local var_27_8 = var_27_5(var_27_6, var_27_7, var_5.UIEaseDuration)
	local var_27_9 = var_2.setEase

	LeanTweenType = var_27_7

	var_27_9(var_27_8, var_27_7.easeOutSine)

	LeanTween = var_27_9

	local var_27_10 = var_27_9.moveY
	local var_27_11 = arg_27_0.rtTopTitle
	local var_27_12 = arg_27_0.rtTopTitle.rect.height

	WorldConst = var_5

	local var_27_13 = var_27_10(var_27_11, var_27_12, var_5.UIEaseDuration)
	local var_27_14 = var_2.setEase

	LeanTweenType = var_27_12

	var_27_14(var_27_13, var_27_12.easeOutSine)

	LeanTween = var_27_14

	local var_27_15 = var_27_14.moveY
	local var_27_16 = arg_27_0.rtTopBottom
	local var_27_17 = -arg_27_0.rtTopRight.rect.height

	WorldConst = var_5

	local var_27_18 = var_27_15(var_27_16, var_27_17, var_5.UIEaseDuration)
	local var_27_19 = var_2.setEase

	LeanTweenType = var_27_17

	local var_27_20 = var_27_19(var_27_18, var_27_17.easeOutSine)
	local var_27_21 = var_2.setOnComplete

	System = var_4

	var_27_21(var_27_20, var_4.Action(function()
		local var_28_0 = arg_27_0

		var_28_0.isTweening = false
		existCall = var_28_0

		return var_28_0(arg_27_1)
	end))

	return
end

function var_0_1.CancelUITween(arg_29_0)
	LeanTween = var_1_10001

	local var_29_0 = var_1_10001.cancel

	go = var_1_10002

	var_29_0(var_1_10002(arg_29_0.rtTopTitle))

	LeanTween = var_29_0

	local var_29_1 = var_29_0.cancel

	go = var_2

	var_29_1(var_2(arg_29_0.rtTopLeft))

	LeanTween = var_29_1

	local var_29_2 = var_29_1.cancel

	go = var_2

	var_29_2(var_2(arg_29_0.rtTopRight))

	LeanTween = var_29_2

	local var_29_3 = var_29_2.cancel

	go = var_2

	var_29_3(var_2(arg_29_0.rtTopBottom))

	return
end

function var_0_1.SetPlayer(arg_30_0, arg_30_1)
	arg_30_0.player = arg_30_1

	local var_30_0 = arg_30_0.resPanel

	var_2.setPlayer(var_30_0, arg_30_1)

	return
end

function var_0_1.SetAtlas(arg_31_0, arg_31_1)
	arg_31_0.atlas = arg_31_1

	local var_31_0 = arg_31_0.atlas
	local var_31_1 = var_2.AddListener

	WorldAtlas = var_1_10004

	var_31_1(var_31_0, var_1_10004.EventUpdateNGoodsCount, arg_31_0.onUpdateNGoods)

	arg_31_0.nGoodsDic = {}
	arg_31_0.nGoodsPortDic = {}
	pairs = var_2

	for iter_31_0, iter_31_1 in var_2(arg_31_1.nShopGoodsDic) do
		var_1_10007 = arg_31_0.nGoodsDic
		Goods = var_1_10008
		var_1_10008 = var_1_10008.Create
		var_1_10009 = {
			id = iter_31_0,
			count = iter_31_1
		}
		Goods = var_1_10010
		var_1_10007[iter_31_0] = var_1_10008(var_1_10009, var_1_10010.TYPE_WORLD_NSHOP)
		var_1_10008 = arg_31_0.nGoodsDic[iter_31_0]
		var_1_10007 = var_1_10007.getConfig(var_1_10008, "port_id")
		var_1_10008 = arg_31_0.nGoodsPortDic

		if not arg_31_0.nGoodsPortDic[var_1_10007] then
			var_1_10009 = {}
		end

		var_1_10008[var_1_10007] = var_1_10009
		table = var_1_10008

		var_1_10008.insert(arg_31_0.nGoodsPortDic[var_1_10007], arg_31_0.nGoodsDic[iter_31_0])
	end

	pairs = var_2

	for iter_31_2, iter_31_3 in var_2(arg_31_0.nGoodsPortDic) do
		table = var_1_10007
		var_1_10007 = var_1_10007.sort

		local var_31_2 = iter_31_3

		CompareFuncs = var_1_10009

		var_1_10007(var_31_2, var_1_10009({
			function(arg_32_0)
				return -arg_32_0:getConfig("priority")
			end,
			function(arg_33_0)
				return arg_33_0.id
			end
		}))
	end

	return
end

function var_0_1.SetPort(arg_34_0, arg_34_1)
	nowWorld = var_1_10002

	local var_34_0 = var_1_10002()

	arg_34_0.port = arg_34_1

	local var_34_1 = arg_34_0.port
	local var_34_2 = var_3.AddListener

	WorldMapPort = var_1_10005

	var_34_2(var_34_1, var_1_10005.EventUpdateTaskIds, arg_34_0.onUpdateTasks)

	local var_34_3 = arg_34_0.port
	local var_34_4 = var_3.AddListener

	WorldMapPort = var_5

	var_34_4(var_34_3, var_5.EventUpdateGoods, arg_34_0.onUpdateGoods)
	arg_34_0:SetBg(arg_34_0.port.id)

	Timer = var_3
	arg_34_0.refreshTimer = var_3.New(function()
		local var_35_0 = arg_34_0.port

		if var_0.IsValid(var_35_0) then
			local var_35_1 = arg_34_0
			local var_35_2 = var_0.UpdateRefreshTime

			var_2_10002 = arg_34_0.port.expiredTime
			pg = var_2_10003

			local var_35_3 = var_2_10003.TimeMgr.GetInstance()

			var_35_2(var_35_1, var_2_10002 - var_3.GetServerTime(var_35_3))
		else
			local var_35_4 = arg_34_0
			local var_35_5 = var_0.emit

			WorldPortMediator = var_2_10002

			local var_35_6 = var_2_10002.OnReqPort
			local var_35_7 = var_34_0

			var_35_5(var_35_4, var_35_6, var_3.GetActiveMap(var_35_7).id)
		end

		return
	end, 1, -1)

	local var_34_5 = arg_34_0.refreshTimer

	var_3.Start(var_34_5)
	arg_34_0.refreshTimer.func()

	local var_34_6 = var_34_0:GetActiveMap()
	local var_34_7 = var_3.GetFleet(var_34_6)

	arg_34_0.wsPortLeft = arg_34_0:NewPortLeft()

	local var_34_8 = arg_34_0.port
	local var_34_9 = var_4.GetRealm(var_34_8)

	setActive = var_34_8

	var_34_8(arg_34_0.btnOperation, var_34_9 == 0 or var_34_9 == var_34_0:GetRealm())

	setActive = var_34_8

	var_34_8(arg_34_0.btnDockyard, var_34_9 == 0 or var_34_9 == var_34_0:GetRealm())

	setActive = var_34_8

	var_34_8(arg_34_0.btnSupply, arg_34_0.nGoodsPortDic[arg_34_1.id])

	setActive = var_34_8

	local var_34_10 = arg_34_0.resPanel._tf
	local var_34_11 = var_34_0
	local var_34_12 = var_34_0.IsSystemOpen

	WorldConst = var_1_10009

	var_34_8(var_34_10, var_34_12(var_34_11, var_1_10009.SystemResource))

	arg_34_0.inventory = var_34_0:GetInventoryProxy()

	local var_34_13 = arg_34_0.inventory
	local var_34_14 = var_5.AddListener

	WorldInventoryProxy = var_7

	var_34_14(var_34_13, var_7.EventUpdateItem, arg_34_0.onUpdateMoneyCount)
	arg_34_0:OnUpdateMoneyCount()

	arg_34_0.taskProxy = var_34_0:GetTaskProxy()

	local var_34_15 = arg_34_0.taskProxy
	local var_34_16 = var_5.AddListener

	WorldTaskProxy = var_7

	var_34_16(var_34_15, var_7.EventUpdateTask, arg_34_0.onUpdateTasks)

	return
end

function var_0_1.SetBg(arg_36_0, arg_36_1)
	pg = var_1_10002
	arg_36_0.portBg = var_1_10002.world_port_data[arg_36_1].port_bg
	setImageAlpha = var_2

	var_2(arg_36_0.rtBg, #arg_36_0.portBg > 0 and 1 or 0)

	if #arg_36_0.portBg > 0 then
		GetImageSpriteFromAtlasAsync = var_2

		var_2("world/port/" .. arg_36_0.portBg, "", arg_36_0.rtBg)
	end

	pg = var_2
	arg_36_0.enterIcon = var_2.world_port_data[arg_36_1].port_entrance_icon
	setActive = var_2

	var_2(arg_36_0.rtEnterIcon, #arg_36_0.enterIcon > 0)

	if #arg_36_0.enterIcon > 0 then
		GetImageSpriteFromAtlasAsync = var_2

		var_2("world/porttitle/" .. arg_36_0.enterIcon, "", arg_36_0.rtEnterIcon, false)
	end

	GetImageSpriteFromAtlasAsync = var_2

	var_2("world/portword/" .. arg_36_0.portBg, "", arg_36_0.rtImageTitle, true)

	GetImageSpriteFromAtlasAsync = var_2

	local var_36_0 = "world/portword/" .. arg_36_0.portBg .. "_en"
	local var_36_1 = ""
	local var_36_2 = arg_36_0.rtImageTitle

	var_2(var_36_0, var_36_1, var_5.Find(var_36_2, "Image"), true)

	return
end

function var_0_1.OnUpdateTasks(arg_37_0)
	arg_37_0:UpdateTaskTip()
	arg_37_0:SetPageDirty(var_0_1.PageTask)

	if arg_37_0.page == var_0_1.PageTask then
		arg_37_0:UpdateTasks()
	end

	return
end

function var_0_1.OnUpdateGoods(arg_38_0)
	arg_38_0:UpdateCDTip()
	arg_38_0:SetPageDirty(var_0_1.PageShop)

	if arg_38_0.page == var_0_1.PageShop then
		arg_38_0:UpdateGoods()
	end

	return
end

function var_0_1.OnUpdateNGoods(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	if arg_39_0.page == var_0_1.PageNShop then
		local var_39_0 = arg_39_0.nGoodsDic[arg_39_3]

		var_39_0.buyCount = arg_39_4

		local var_39_1 = arg_39_0.rtNGoodsDic[arg_39_3]

		setText = var_1_10007

		var_1_10007(var_39_1:Find("count_contain/count"), var_39_0:GetPurchasableCnt() .. "/" .. var_39_0:GetLimitGoodCount())

		setActive = var_1_10007

		var_1_10007(var_39_1:Find("mask"), not var_39_0:canPurchase())

		setActive = var_1_10007

		var_1_10007(var_39_1:Find("new"), false)
	else
		arg_39_0:SetPageDirty(var_0_1.PageNShop)
	end

	return
end

function var_0_1.SetPage(arg_40_0, arg_40_1)
	if arg_40_0.page ~= arg_40_1 then
		local var_40_0 = var_0_1.BlurPages
		local var_40_1

		if not arg_40_0.page then
			var_40_1 = 0
		end

		if var_40_0[var_40_1] ~= var_0_1.BlurPages[arg_40_1] then
			if var_0_1.BlurPages[arg_40_1] then
				pg = var_2

				local var_40_2 = var_2.UIMgr.GetInstance()

				var_2.BlurPanel(var_40_2, arg_40_0.rtBlurPanel)
			else
				pg = var_2

				local var_40_3 = var_2.UIMgr.GetInstance()

				var_2.UnOverlayPanel(var_40_3, arg_40_0.rtBlurPanel, arg_40_0._tf)
			end
		end

		if arg_40_1 == var_0_1.PageShop and arg_40_0.paintingName == "buzhihuo_shop" then
			local var_40_4 = arg_40_0
			local var_40_5 = arg_40_0.showRandomShipWord

			pg = var_1_10004

			var_40_5(var_40_4, var_1_10004.navalacademy_shoppingstreet_template[1].words_enter, true, "enter")
		end

		arg_40_0.page = arg_40_1

		arg_40_0:UpdatePage()

		arg_40_0.contextData.page = arg_40_1
	end

	return
end

function var_0_1.SetPageDirty(arg_41_0, arg_41_1)
	arg_41_0.dirtyFlags[arg_41_1] = true

	return
end

function var_0_1.IsPageDirty(arg_42_0, arg_42_1)
	return arg_42_0.dirtyFlags[arg_42_1] == true or arg_42_0.dirtyFlags[arg_42_1] == nil
end

function var_0_1.UpdatePage(arg_43_0)
	local var_43_0 = arg_43_0.page

	arg_43_0:DisplayTopUI(var_43_0)

	setActive = var_2

	var_2(arg_43_0.rtTasks, var_43_0 == var_0_1.PageTask)

	setActive = var_2

	var_2(arg_43_0.rtShop, var_43_0 == var_0_1.PageShop)

	setActive = var_2

	var_2(arg_43_0.rtNShop, var_43_0 == var_0_1.PageNShop)

	if arg_43_0:IsPageDirty(var_43_0) then
		if var_43_0 == var_0_1.PageTask then
			arg_43_0:UpdateTasks()
		elseif var_43_0 == var_0_1.PageShop then
			arg_43_0:UpdateGoods()
		elseif var_43_0 == var_0_1.PageNShop then
			arg_43_0:UpdateNShopPorts()
		end
	end

	return
end

function var_0_1.UpdateTasks(arg_44_0)
	arg_44_0.dirtyFlags[var_0_1.PageTask] = false

	local var_44_0 = arg_44_0.rtTasks
	local var_44_1 = var_1.Find(var_44_0, "frame/viewport/content")
	local var_44_2 = var_1.GetChild(var_44_1, 0)

	_ = var_44_1

	local var_44_3 = var_44_1.map(arg_44_0.port.taskIds, function(arg_45_0)
		WorldTask = var_2_10001

		return var_2_10001.New({
			id = arg_45_0
		})
	end)

	table = var_4

	local var_44_4 = var_4.sort
	local var_44_5 = var_44_3

	CompareFuncs = var_1_10006
	WorldTask = var_1_10007

	var_44_4(var_44_5, var_1_10006(var_1_10007.sortDic))

	UIItemList = var_44_4

	var_44_4.StaticAlign(var_1, var_44_2, #var_44_3, function(arg_46_0, arg_46_1, arg_46_2)
		local var_46_0 = arg_46_1 + 1

		UIItemList = var_2_10004

		if arg_46_0 == var_2_10004.EventUpdate then
			local var_46_1 = var_44_3[var_46_0]
			local var_46_2 = arg_44_0.wsTasks
			local var_46_3

			if not arg_44_0.wsTasks[var_46_0] then
				WSPortTask = var_46_3
				var_46_3 = var_46_3.New(arg_46_2)
			end

			var_46_2[var_46_0] = var_46_3

			local var_46_4 = arg_44_0.wsTasks[var_46_0]

			var_5.Setup(var_46_4, var_46_1)

			onButton = var_6

			local var_46_5 = arg_44_0
			local var_46_6 = var_5.btnInactive

			local function var_46_7()
				local var_47_0 = arg_44_0
				local var_47_1 = var_0.emit

				WorldPortMediator = var_3_10002

				var_47_1(var_47_0, var_3_10002.OnAccepetTask, var_46_1, arg_44_0.port.id)

				return
			end

			SFX_PANEL = var_2_10010

			var_6(var_46_5, var_46_6, var_46_7, var_2_10010)

			onButton = var_6

			local var_46_8 = arg_44_0
			local var_46_9 = var_5.btnOnGoing

			local function var_46_10()
				local var_48_0 = arg_44_0

				var_0.showTaskWindow(var_48_0, var_46_1)

				return
			end

			SFX_PANEL = var_2_10010

			var_6(var_46_8, var_46_9, var_46_10, var_2_10010)

			onButton = var_6

			local var_46_11 = arg_44_0
			local var_46_12 = var_5.btnFinished

			local function var_46_13()
				local var_49_0 = arg_44_0
				local var_49_1 = var_0.emit

				WorldPortMediator = var_3_10002

				var_49_1(var_49_0, var_3_10002.OnSubmitTask, var_46_1)

				return
			end

			SFX_PANEL = var_2_10010

			var_6(var_46_11, var_46_12, var_46_13, var_2_10010)

			function var_5.onDrop(arg_50_0)
				local var_50_0 = arg_44_0

				var_1.emit(var_50_0, var_0_1.ON_DROP, arg_50_0)

				return
			end
		end

		return
	end)

	local var_44_6 = arg_44_0.rtTasks
	local var_44_7 = var_4.Find(var_44_6, "frame/empty")

	setActive = var_44_6

	var_44_6(var_44_7, #var_44_3 == 0)

	return
end

function var_0_1.DisposeTasks(arg_51_0)
	_ = var_1_10001

	var_1_10001.each(arg_51_0.wsTasks, function(arg_52_0)
		arg_52_0:Dispose()

		return
	end)

	arg_51_0.wsTasks = {}

	return
end

function var_0_1.UpdateGoods(arg_53_0)
	arg_53_0.dirtyFlags[var_0_1.PageShop] = false

	local var_53_0 = arg_53_0.rtShop
	local var_53_1 = var_1.Find(var_53_0, "frame/scrollview/view")
	local var_53_2 = var_1.GetChild(var_53_1, 0)

	underscore = var_53_1

	local var_53_3 = var_53_1.rest(arg_53_0.port.goods, 1)

	table = var_4

	local var_53_4 = var_4.sort
	local var_53_5 = var_53_3

	CompareFuncs = var_1_10006

	var_53_4(var_53_5, var_1_10006({
		function(arg_54_0)
			return -arg_54_0.config.priority
		end,
		function(arg_55_0)
			return arg_55_0.id
		end
	}))

	UIItemList = var_53_4

	var_53_4.StaticAlign(var_1, var_53_2, #var_53_3, function(arg_56_0, arg_56_1, arg_56_2)
		arg_56_1 = arg_56_1 + 1
		UIItemList = var_2_10003

		if arg_56_0 == var_2_10003.EventUpdate then
			local var_56_0 = var_53_3[arg_56_1]
			local var_56_1 = arg_53_0.wsGoods
			local var_56_2

			if not arg_53_0.wsGoods[arg_56_1] then
				WSPortGoods = var_56_2
				var_56_2 = var_56_2.New(arg_56_2)
			end

			var_56_1[arg_56_1] = var_56_2

			local var_56_3 = arg_53_0.wsGoods[arg_56_1]

			var_4.Setup(var_56_3, var_56_0)

			onButton = var_5

			local var_56_4 = arg_53_0
			local var_56_5 = var_4.transform

			local function var_56_6()
				if var_56_0.count > 0 then
					pg = var_0

					local var_57_0 = var_0.MsgboxMgr.GetInstance()
					local var_57_1 = var_0.ShowMsgBox
					local var_57_2 = {
						yesText = "text_buy"
					}

					MSGBOX_TYPE_SINGLE_ITEM = var_3_10003
					var_57_2.type = var_3_10003
					var_57_2.drop = var_56_0.item

					function var_57_2.onYes()
						local var_58_0 = arg_53_0
						local var_58_1 = var_0.emit

						WorldPortMediator = var_4_10002

						var_58_1(var_58_0, var_4_10002.OnBuyGoods, var_56_0)

						return
					end

					var_57_1(var_57_0, var_57_2)
				end

				return
			end

			SFX_PANEL = var_2_10009

			var_5(var_56_4, var_56_5, var_56_6, var_2_10009)
		end

		return
	end)

	return
end

function var_0_1.DisposeGoods(arg_59_0)
	_ = var_1_10001

	var_1_10001.each(arg_59_0.wsGoods, function(arg_60_0)
		arg_60_0:Dispose()

		return
	end)

	arg_59_0.wsGoods = {}

	return
end

function var_0_1.UpdateNShopPorts(arg_61_0)
	local var_61_0 = arg_61_0.dirtyFlags

	var_61_0[var_0_1.PageNShop] = false
	underscore = var_61_0

	local var_61_1 = var_61_0.keys(arg_61_0.nGoodsPortDic)

	table = var_2

	var_2.sort(var_61_1)

	ipairs = var_2

	for iter_61_0, iter_61_1 in var_2(var_61_1) do
		if not arg_61_0.poolTplPort[iter_61_0] then
			table = var_7

			local var_61_2 = var_7.insert

			var_1_10008 = arg_61_0.poolTplPort
			cloneTplTo = var_1_10009

			var_61_2(var_1_10008, var_1_10009(arg_61_0.tplPort, arg_61_0.containerPort))
		end

		local var_61_3 = arg_61_0.poolTplPort[iter_61_0]

		setText = var_1_10008

		local var_61_4 = var_61_3

		var_1_10009 = var_61_3.Find(var_61_4, "Text")
		pg = var_61_4

		var_1_10008(var_1_10009, var_61_4.world_port_data[iter_61_1].name)

		setActive = var_1_10008

		var_1_10008(var_61_3:Find("tip"), arg_61_0.atlas.markPortDic.newGoods[iter_61_1])

		onToggle = var_1_10008
		var_1_10009 = arg_61_0

		local var_61_5 = var_61_3

		local function var_61_6(arg_62_0)
			if arg_62_0 then
				if arg_61_0.nShopPortId == iter_61_1 then
					return
				end

				setActive = var_1

				local var_62_0 = var_61_3

				var_1(var_2.Find(var_62_0, "tip"), false)

				local var_62_1 = arg_61_0.atlas

				var_1.UpdatePortMarkNShop(var_62_1, iter_61_1, false)

				local var_62_2 = arg_61_0

				var_1.UpdateNShopTip(var_62_2)

				local var_62_3 = arg_61_0

				var_1.UpdateNShopGoods(var_62_3, iter_61_1)
			end

			return
		end

		SFX_PANEL = var_1_10012

		var_1_10008(var_1_10009, var_61_5, var_61_6, var_1_10012)

		triggerToggle = var_1_10008

		var_1_10008(var_61_3, iter_61_1 == arg_61_0.port.id)
	end

	return
end

function var_0_1.UpdateNShopGoods(arg_63_0, arg_63_1)
	arg_63_0.nShopPortId = arg_63_1

	local var_63_0 = arg_63_0.atlas
	local var_63_1 = var_2.GetPressingUnlockCount(var_63_0)
	local var_63_2 = arg_63_0.atlas
	local var_63_3 = var_3.GetPressingUnlockRecordCount(var_63_2, arg_63_1)
	local var_63_4 = {}

	ipairs = var_5

	for iter_63_0, iter_63_1 in var_5(arg_63_0.nGoodsPortDic[arg_63_1]) do
		local var_63_5

		if not var_63_4[iter_63_1:getConfig("unlock_num")] then
			var_63_5 = {}
		end

		var_63_4[var_10] = var_63_5
		table = var_63_5

		var_63_5.insert(var_63_4[var_10], iter_63_1)
	end

	arg_63_0.rtNGoodsDic = {}
	underscore = var_5

	local var_63_6 = var_5.keys(var_63_4)

	table = var_6

	var_6.sort(var_63_6)

	UIItemList = var_6

	local var_63_7 = var_6.StaticAlign
	local var_63_8 = arg_63_0.rtNGoodsContainer
	local var_63_9 = arg_63_0.rtNGoodsContainer

	var_63_7(var_63_8, var_8.Find(var_63_9, "group"), #var_63_6, function(arg_64_0, arg_64_1, arg_64_2)
		arg_64_1 = arg_64_1 + 1
		UIItemList = var_2_10003

		if arg_64_0 == var_2_10003.EventUpdate then
			local var_64_0 = var_63_6[arg_64_1]

			setActive = var_2_10004

			var_2_10004(arg_64_2:Find("title"), arg_64_1 > 1)

			setText = var_2_10004

			local var_64_1 = arg_64_2
			local var_64_2 = arg_64_2.Find(var_64_1, "title/other/Text")

			i18n = var_64_1

			var_2_10004(var_64_2, var_64_1("world_instruction_port_goods_locked"))

			setText = var_2_10004

			local var_64_3 = arg_64_2
			local var_64_4 = arg_64_2.Find(var_64_3, "title/other/progress")

			math = var_64_3

			var_2_10004(var_64_4, var_64_3.min(var_63_1, var_64_0) .. "/" .. var_64_0)

			local var_64_5 = arg_64_2
			local var_64_6 = arg_64_2.Find(var_64_5, "container")

			UIItemList = var_64_5

			var_64_5.StaticAlign(var_64_6, var_64_6:Find("item_tpl"), #var_63_4[var_64_0], function(arg_65_0, arg_65_1, arg_65_2)
				arg_65_1 = arg_65_1 + 1
				UIItemList = var_3_10003

				if arg_65_0 == var_3_10003.EventUpdate then
					local var_65_0 = var_63_4[var_64_0][arg_65_1]

					arg_63_0.rtNGoodsDic[var_65_0.id] = arg_65_2

					local var_65_1 = var_65_0
					local var_65_2 = var_65_0.GetDropInfo(var_65_1)

					updateDrop = var_65_1

					var_65_1(arg_65_2:Find("IconTpl"), var_65_2)

					setText = var_65_1

					local var_65_3 = arg_65_2
					local var_65_4 = arg_65_2.Find(var_65_3, "name_mask/name")

					shortenString = var_65_3

					var_65_1(var_65_4, var_65_3(var_65_2:getConfig("name"), 6))

					local var_65_5 = var_65_0
					local var_65_6 = var_65_0.GetPriceInfo(var_65_5)

					GetImageSpriteFromAtlasAsync = var_65_5

					var_65_5(var_65_6:getIcon(), "", arg_65_2:Find("consume/contain/icon"), false)

					setText = var_65_5

					var_65_5(arg_65_2:Find("consume/contain/Text"), var_65_6.count)

					setText = var_65_5

					var_65_5(arg_65_2:Find("count_contain/count"), var_65_0:GetPurchasableCnt() .. "/" .. var_65_0:GetLimitGoodCount())

					setText = var_65_5

					local var_65_7 = arg_65_2
					local var_65_8 = arg_65_2.Find(var_65_7, "count_contain/label")

					i18n = var_65_7

					var_65_5(var_65_8, var_65_7("activity_shop_exchange_count"))

					setText = var_65_5

					local var_65_9 = arg_65_2
					local var_65_10 = arg_65_2.Find(var_65_9, "mask/tag/sellout_tag")

					i18n = var_65_9

					var_65_5(var_65_10, var_65_9("word_sell_out"))

					setActive = var_65_5

					var_65_5(arg_65_2:Find("mask"), not var_65_0:canPurchase())

					setText = var_65_5

					local var_65_11 = arg_65_2
					local var_65_12 = arg_65_2.Find(var_65_11, "lock/Image/Text")

					i18n = var_65_11

					var_65_5(var_65_12, var_65_11("word_sell_lock"))

					setActive = var_65_5

					var_65_5(arg_65_2:Find("lock"), var_63_1 < var_64_0)

					setActive = var_65_5

					var_65_5(arg_65_2:Find("new"), var_65_0.buyCount == 0 and var_63_3 < var_64_0 and var_64_0 <= var_63_1)

					onButton = var_65_5

					local var_65_13 = arg_63_0
					local var_65_14 = arg_65_2

					local function var_65_15()
						local var_66_0 = var_65_0
						local var_66_1

						if not (var_0.GetLimitGoodCount(var_66_0) > 1) or not arg_63_0.multiWindow then
							var_66_1 = arg_63_0.singleWindow
						end

						var_66_1:ExecuteAction("Open", var_65_0, function(arg_67_0, arg_67_1)
							local var_67_0 = arg_63_0
							local var_67_1 = var_2.emit

							WorldPortMediator = var_5_10004

							var_67_1(var_67_0, var_5_10004.OnBuyNShopGoods, arg_67_0, arg_67_1)

							return
						end)

						return
					end

					SFX_PANEL = var_10

					var_65_5(var_65_13, var_65_14, var_65_15, var_10)
				end

				return
			end)
		end

		return
	end)

	local var_63_10 = arg_63_0.atlas

	var_6.SetPressingUnlockRecordCount(var_63_10, arg_63_1, var_63_1)

	return
end

function var_0_1.OnUpdateMoneyCount(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
	if arg_68_1 then
		local var_68_0 = arg_68_3.id

		WorldItem = var_1_10005

		if var_68_0 == var_1_10005.PortMoneyId then
			local var_68_1 = arg_68_0.inventory
			local var_68_2 = var_4.GetItemCount

			WorldItem = var_1_10006

			local var_68_3 = var_68_2(var_68_1, var_1_10006.PortMoneyId)

			setText = var_68_1

			local var_68_4 = arg_68_0.rtShop

			var_68_1(var_6.Find(var_68_4, "quick_count/value"), var_68_3)

			setText = var_68_1

			local var_68_5 = arg_68_0.rtNShopRes

			var_68_1(var_6.Find(var_68_5, "Text"), var_68_3)
		end

		return
	end
end

function var_0_1.UpdateRefreshTime(arg_69_0, arg_69_1)
	setText = var_1_10002

	local var_69_0 = arg_69_0.cdTF
	local var_69_1 = var_3.Find(var_69_0, "Text")

	pg = var_69_0

	local var_69_2 = var_69_0.TimeMgr.GetInstance()

	var_1_10002(var_69_1, var_4.DescCDTime(var_69_2, arg_69_1))

	return
end

function var_0_1.UpdateCDTip(arg_70_0)
	setActive = var_1_10001

	local var_70_0 = arg_70_0.cdTF
	local var_70_2

	if #arg_70_0.port.goods > 0 then
		local var_70_1 = arg_70_0.port

		var_70_2 = not var_3.IsTempPort(var_70_1)
	else
		var_70_2 = false
	end

	if false then
		var_70_2 = true
	end

	var_1_10001(var_70_0, var_70_2)

	setActive = var_1_10001

	var_1_10001(arg_70_0.emptyTF, #arg_70_0.port.goods == 0)

	nowWorld = var_1_10001

	local var_70_3 = var_1_10001()

	if not var_1.UsePortNShop(var_70_3) then
		setActive = var_1

		local var_70_4 = arg_70_0.btnSupply
		local var_70_5 = var_2.Find(var_70_4, "new")

		nowWorld = var_70_4

		local var_70_6 = var_70_4()

		var_1(var_70_5, var_3.GetAtlas(var_70_6).markPortDic.goods[arg_70_0.port.id])
	end

	return
end

function var_0_1.UpdateTaskTip(arg_71_0)
	setActive = var_1_10001

	local var_71_0 = arg_71_0.btnOperation

	var_1_10001(var_2.Find(var_71_0, "new"), false)

	return
end

function var_0_1.UpdateNShopTip(arg_72_0)
	nowWorld = var_1_10001

	local var_72_0 = var_1_10001()

	if var_1.UsePortNShop(var_72_0) then
		setActive = var_1

		local var_72_1 = arg_72_0.btnSupply
		local var_72_2 = var_2.Find(var_72_1, "new")
		local var_72_3 = arg_72_0.atlas

		var_1(var_72_2, var_3.GetAnyPortMarkNShop(var_72_3))
	end

	return
end

function var_0_1.showTaskWindow(arg_73_0, arg_73_1)
	local var_73_0 = arg_73_1.config.rare_task_icon
	local var_73_1 = arg_73_0.rtTaskWindow
	local var_73_2 = var_3.Find(var_73_1, "main_window/left_panel")

	setActive = var_73_1

	var_73_1(var_73_2:Find("bg"), arg_73_1:IsSpecialType())

	if #var_73_0 > 0 then
		GetImageSpriteFromAtlasAsync = var_4

		var_4("shipyardicon/" .. var_73_0, "", var_73_2:Find("card"), true)
	else
		GetImageSpriteFromAtlasAsync = var_4

		var_4("ui/worldportui_atlas", "nobody", var_73_2:Find("card"), true)
	end

	local var_73_3 = arg_73_0.rtTaskWindow
	local var_73_4 = var_4.Find(var_73_3, "main_window/right_panel")

	setText = var_73_3

	var_73_3(var_73_4:Find("title/Text"), arg_73_1.config.name)

	setText = var_73_3

	var_73_3(var_73_4:Find("content/desc"), arg_73_1.config.rare_task_text)

	setText = var_73_3

	var_73_3(var_73_4:Find("content/slider_progress/Text"), arg_73_1:getProgress() .. "/" .. arg_73_1:getMaxProgress())

	setSlider = var_73_3

	var_73_3(var_73_4:Find("content/slider"), 0, arg_73_1:getMaxProgress(), arg_73_1:getProgress())

	local var_73_5 = var_73_4:Find("content/item_tpl")
	local var_73_6 = var_73_4:Find("content/award_bg/panel/content")
	local var_73_7 = arg_73_1.config.show

	removeAllChildren = var_8

	var_8(var_73_6)

	ipairs = var_8

	for iter_73_0, iter_73_1 in var_8(var_73_7) do
		cloneTplTo = var_1_10013
		var_1_10013 = var_1_10013(var_73_5, var_73_6)

		local var_73_8 = {
			type = iter_73_1[1],
			id = iter_73_1[2],
			count = iter_73_1[3]
		}

		updateDrop = var_15

		var_15(var_1_10013, var_73_8)

		onButton = var_15

		local var_73_9 = arg_73_0
		local var_73_10 = var_1_10013

		local function var_73_11()
			local var_74_0 = arg_73_0

			var_0.emit(var_74_0, var_0_1.ON_DROP, var_73_8)

			return
		end

		SFX_PANEL = var_1_10019

		var_15(var_73_9, var_73_10, var_73_11, var_1_10019)

		setActive = var_15

		var_15(var_1_10013, true)
	end

	setActive = var_8

	var_8(var_73_5, false)

	setActive = var_8

	var_8(var_73_4:Find("content/award_bg/arror"), #var_73_7 > 3)

	onButton = var_8

	local var_73_12 = arg_73_0
	local var_73_13 = var_73_4:Find("btn_close")

	local function var_73_14()
		local var_75_0 = arg_73_0

		var_0.hideTaskWindow(var_75_0)

		return
	end

	SFX_CANCEL = var_12

	var_8(var_73_12, var_73_13, var_73_14, var_12)

	onButton = var_8

	local var_73_15 = arg_73_0
	local var_73_16 = arg_73_0.rtTaskWindow
	local var_73_17 = var_10.Find(var_73_16, "bg")

	local function var_73_18()
		local var_76_0 = arg_73_0

		var_0.hideTaskWindow(var_76_0)

		return
	end

	SFX_CANCEL = var_12

	var_8(var_73_15, var_73_17, var_73_18, var_12)

	onButton = var_8

	local var_73_19 = arg_73_0
	local var_73_20 = var_73_4:Find("btn_go")

	local function var_73_21()
		local var_77_0 = arg_73_0

		var_0.hideTaskWindow(var_77_0)

		local var_77_1 = arg_73_0
		local var_77_2 = var_0.emit

		WorldPortMediator = var_2_10002

		var_77_2(var_77_1, var_2_10002.OnTaskGoto, arg_73_1.id)

		return
	end

	SFX_PANEL = var_12

	var_8(var_73_19, var_73_20, var_73_21, var_12)

	setButtonEnabled = var_8

	local var_73_22 = var_73_4:Find("btn_go")
	local var_73_23

	if not arg_73_1:GetFollowingAreaId() then
		var_73_23 = arg_73_1:GetFollowingEntrance()
	end

	var_8(var_73_22, var_73_23)

	setActive = var_8

	var_8(arg_73_0.rtTaskWindow, true)

	pg = var_8

	local var_73_24 = var_8.UIMgr.GetInstance()

	var_8.BlurPanel(var_73_24, arg_73_0.rtTaskWindow)

	return
end

function var_0_1.hideTaskWindow(arg_78_0)
	setActive = var_1_10001

	var_1_10001(arg_78_0.rtTaskWindow, false)

	pg = var_1_10001

	local var_78_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_78_0, arg_78_0.rtTaskWindow, arg_78_0._tf)

	return
end

return var_0_1

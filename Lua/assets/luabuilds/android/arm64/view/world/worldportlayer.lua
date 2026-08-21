local var_0_0 = class("WorldPortLayer", import("..base.BaseUI"))

var_0_0.Listeners = {
	onUpdateNGoods = "OnUpdateNGoods",
	onUpdateMoneyCount = "OnUpdateMoneyCount",
	onUpdateTasks = "OnUpdateTasks",
	onUpdateGoods = "OnUpdateGoods"
}
var_0_0.TitleName = {
	"text_gangkou",
	"text_operation",
	"text_supply"
}
var_0_0.PageMain = 0
var_0_0.PageTask = 1
var_0_0.PageShop = 2
var_0_0.PageDockyard = 3
var_0_0.PageNShop = 4
var_0_0.BlurPages = {
	[var_0_0.PageTask] = true,
	[var_0_0.PageShop] = true,
	[var_0_0.PageNShop] = true
}
var_0_0.optionsPath = {
	"blur_panel/adapt/top/title/option"
}

function var_0_0.getUIName(arg_1_0)
	return "WorldPortUI"
end

function var_0_0.init(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(var_0_0.Listeners) do
		arg_2_0[iter_2_0] = function(...)
			var_0_0[iter_2_1](arg_2_0, ...)

			return
		end
	end

	arg_2_0.rtBg = arg_2_0._tf:Find("bg")
	arg_2_0.rtEnterIcon = arg_2_0.rtBg:Find("enter_icon")
	arg_2_0.rtBgNShop = arg_2_0._tf:Find("bg_2")
	arg_2_0.rtBlurPanel = arg_2_0._tf:Find("blur_panel")
	arg_2_0.rtTasks = arg_2_0.rtBlurPanel:Find("adapt/tasks")
	arg_2_0.rtShop = arg_2_0.rtBlurPanel:Find("adapt/shop")
	arg_2_0.rtPainting = arg_2_0.rtShop:Find("paint")
	arg_2_0.btnPainting = arg_2_0.rtShop:Find("paint_touch")

	setActive(arg_2_0.btnPainting, false)

	arg_2_0.rtChat = arg_2_0.rtShop:Find("chat")

	setActive(arg_2_0.rtChat, false)

	arg_2_0.rtNShop = arg_2_0.rtBlurPanel:Find("adapt/new_shop")
	arg_2_0.containerPort = arg_2_0.rtNShop:Find("frame/content/left")
	arg_2_0.tplPort = arg_2_0.containerPort:Find("port_tpl")
	arg_2_0.poolTplPort = {
		arg_2_0.tplPort
	}
	arg_2_0.rtNGoodsContainer = arg_2_0.rtNShop:Find("frame/content/right/page/view/content")
	arg_2_0.rtNShopRes = arg_2_0.rtNShop:Find("frame/content/right/page/title/res")

	local var_2_0 = Drop.New({
		type = DROP_TYPE_WORLD_ITEM,
		id = WorldItem.PortMoneyId
	})

	GetImageSpriteFromAtlasAsync(var_2_0:getIcon(), "", arg_2_0.rtNShopRes:Find("icon/Image"), false)
	setText(arg_2_0.rtNShopRes:Find("icon/name"), var_2_0:getName())

	arg_2_0.rtTop = arg_2_0.rtBlurPanel:Find("adapt/top")
	arg_2_0.btnBack = arg_2_0.rtTop:Find("title/back_button")
	arg_2_0.rtTopTitle = arg_2_0.rtTop:Find("title")
	arg_2_0.rtImageTitle = arg_2_0.rtTopTitle:Find("print/title")
	arg_2_0.rtImageTitleTask = arg_2_0.rtTopTitle:Find("print/title_task")
	arg_2_0.rtImageTitleShop = arg_2_0.rtTopTitle:Find("print/title_shop")
	arg_2_0.rtTopLeft = arg_2_0.rtTop:Find("left_stage")
	arg_2_0.rtTopRight = arg_2_0.rtTop:Find("right_stage")
	arg_2_0.wsWorldInfo = WSWorldInfo.New()
	arg_2_0.wsWorldInfo.transform = arg_2_0.rtTopRight:Find("display_panel/world_info")

	arg_2_0.wsWorldInfo:Setup()
	setText(arg_2_0.rtTopRight:Find("display_panel/title/title"), i18n("world_map_title_tips"))
	setText(arg_2_0.rtTopRight:Find("display_panel/title/title_en"), i18n("world_map_title_tips_en"))
	setText(arg_2_0.wsWorldInfo.transform:Find("power/bg/Word"), i18n("world_total_power"))
	setText(arg_2_0.wsWorldInfo.transform:Find("explore/mileage/Text"), i18n("world_mileage"))
	setText(arg_2_0.wsWorldInfo.transform:Find("explore/pressing/Text"), i18n("world_pressing"))

	arg_2_0.rtTopBottom = arg_2_0.rtTop:Find("bottom_stage")
	arg_2_0.btnOperation = arg_2_0.rtTopBottom:Find("btn/operation")
	arg_2_0.btnSupply = arg_2_0.rtTopBottom:Find("btn/supply")
	arg_2_0.btnDockyard = arg_2_0.rtTopBottom:Find("btn/dockyard")
	arg_2_0.resPanel = WorldResource.New()

	arg_2_0.resPanel._tf:SetParent(arg_2_0.rtTop:Find("title/resources"), false)

	arg_2_0.rtTaskWindow = arg_2_0._tf:Find("task_window")
	arg_2_0.wsTasks = {}
	arg_2_0.wsGoods = {}
	arg_2_0.page = -1
	arg_2_0.dirtyFlags = {}
	arg_2_0.cdTF = arg_2_0.rtShop:Find("timer_bg")
	arg_2_0.emptyTF = arg_2_0.rtShop:Find("frame/scrollview/empty")
	arg_2_0.refreshBtn = arg_2_0.rtShop:Find("refresh_btn")

	setActive(arg_2_0.refreshBtn, false)

	arg_2_0.glitchArtMaterial = arg_2_0._tf:Find("resource/material1"):GetComponent(typeof(Image)).material
	arg_2_0.singleWindow = OriginShopSingleWindow.New(arg_2_0._tf, arg_2_0.event)
	arg_2_0.multiWindow = OriginShopMultiWindow.New(arg_2_0._tf, arg_2_0.event)

	return
end

function var_0_0.didEnter(arg_4_0)
	arg_4_0:BlurPanel(arg_4_0._tf)
	onButton(arg_4_0, arg_4_0.btnBack, function()
		if arg_4_0.isTweening then
			return
		end

		if arg_4_0.port:IsTempPort() or arg_4_0.page == var_0_0.PageMain then
			arg_4_0:EaseOutUI(function()
				arg_4_0:closeView()

				return
			end)
		else
			arg_4_0:SetPage(var_0_0.PageMain)
		end

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0.btnOperation, function()
		arg_4_0:SetPage(var_0_0.PageTask)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.btnSupply, function()
		if nowWorld():UsePortNShop() then
			arg_4_0:SetPage(var_0_0.PageNShop)
		else
			arg_4_0:SetPage(var_0_0.PageShop)
		end

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.btnDockyard, function()
		arg_4_0:emit(WorldPortMediator.OnOpenBay)

		return
	end, SFX_PANEL)
	arg_4_0:UpdatePainting(arg_4_0:GetPaintingInfo())
	arg_4_0:UpdateTaskTip()
	arg_4_0:UpdateCDTip()
	arg_4_0:UpdateNShopTip()

	if arg_4_0.port:IsTempPort() then
		arg_4_0.contextData.page = WorldPortLayer.PageShop

		goto label_4_0
	end

	if arg_4_0.contextData.page == WorldPortLayer.PageDockyard then
		arg_4_0.contextData.page = nil

		local var_4_0 = arg_4_0.contextData.page or WorldPortLayer.PageMain

		arg_4_0:SetPage(var_4_0)
		arg_4_0:EaseInUI()

		return
	end
end

function var_0_0.onBackPressed(arg_10_0)
	triggerButton(arg_10_0.btnBack)

	return
end

function var_0_0.willExit(arg_11_0)
	arg_11_0:UnOverlayPanel(arg_11_0._tf)
	arg_11_0:RecyclePainting(arg_11_0.rtPainting)
	arg_11_0.singleWindow:Destroy()
	arg_11_0.multiWindow:Destroy()

	arg_11_0.contextData.isEnter = true

	if var_0_0.BlurPages[arg_11_0.page] then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0.rtBlurPanel, arg_11_0._tf)
	end

	arg_11_0:CancelUITween()
	arg_11_0:DisposeTopUI()
	arg_11_0:DisposeTasks()
	arg_11_0:DisposeGoods()
	arg_11_0.atlas:RemoveListener(WorldAtlas.EventUpdateNGoodsCount, arg_11_0.onUpdateNGoods)

	arg_11_0.atlas = nil

	arg_11_0.port:RemoveListener(WorldMapPort.EventUpdateTaskIds, arg_11_0.onUpdateTasks)
	arg_11_0.port:RemoveListener(WorldMapPort.EventUpdateGoods, arg_11_0.onUpdateGoods)

	arg_11_0.port = nil

	arg_11_0.resPanel:exit()

	arg_11_0.resPanel = nil

	arg_11_0.refreshTimer:Stop()

	arg_11_0.refreshTimer = nil

	arg_11_0.inventory:RemoveListener(WorldInventoryProxy.EventUpdateItem, arg_11_0.onUpdateMoneyCount)

	arg_11_0.inventory = nil

	arg_11_0.taskProxy:RemoveListener(WorldTaskProxy.EventUpdateTask, arg_11_0.onUpdateTasks)

	arg_11_0.taskProxy = nil

	arg_11_0.wsWorldInfo:Dispose()

	arg_11_0.wsWorldInfo = nil

	return
end

function var_0_0.GetPaintingInfo(arg_12_0)
	if arg_12_0.port:IsTempPort() then
		return "mingshi", false
	else
		return "tbniang", true
	end

	return
end

function var_0_0.UpdatePainting(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.paintingName = arg_13_1

	setPaintingPrefab(arg_13_0.rtPainting, arg_13_1, "chuanwu")

	if arg_13_2 then
		arg_13_0:AddGlitchArtEffectForPating(arg_13_0.rtPainting)
	end

	return
end

function var_0_0.AddGlitchArtEffectForPating(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs((arg_14_1:GetComponentsInChildren(typeof(Image)):ToTable())) do
		iter_14_1.material = arg_14_0.glitchArtMaterial
	end

	return
end

function var_0_0.RecyclePainting(arg_15_0, arg_15_1)
	if arg_15_1:Find("fitter").childCount > 0 then
		for iter_15_0, iter_15_1 in ipairs((arg_15_1:GetComponentsInChildren(typeof(Image)):ToTable())) do
			if iter_15_1.material ~= iter_15_1.defaultGraphicMaterial then
				iter_15_1.material = iter_15_1.defaultGraphicMaterial

				iter_15_1.material:SetColor("_Color", Color.white)
			end
		end

		setGray(arg_15_1, false, true)

		local var_15_0 = arg_15_1:Find("fitter"):GetChild(0)

		retPaintingPrefab(arg_15_1, var_15_0.name)

		local var_15_1 = var_15_0:Find("temp_mask")

		if var_15_1 then
			Destroy(var_15_1)
		end
	end

	return
end

function var_0_0.DisplayTopUI(arg_16_0, arg_16_1)
	setActive(arg_16_0.rtImageTitle, arg_16_1 == var_0_0.PageMain)
	setActive(arg_16_0.rtImageTitleTask, arg_16_1 == var_0_0.PageTask)
	setActive(arg_16_0.rtImageTitleShop, arg_16_1 == var_0_0.PageShop or arg_16_1 == var_0_0.PageNShop)
	setActive(arg_16_0.rtTopLeft, arg_16_1 ~= var_0_0.PageNShop)
	setActive(arg_16_0.rtTopRight, arg_16_1 == var_0_0.PageMain)
	setActive(arg_16_0.rtTopBottom, arg_16_1 == var_0_0.PageMain)
	setActive(arg_16_0.rtBg, arg_16_1 ~= var_0_0.PageNShop)
	setActive(arg_16_0.rtBgNShop, arg_16_1 == var_0_0.PageNShop)

	return
end

function var_0_0.DisposeTopUI(arg_17_0)
	arg_17_0.wsPortLeft:Dispose()

	return
end

function var_0_0.NewPortLeft(arg_18_0)
	local var_18_0 = WSPortLeft.New()

	var_18_0.transform = arg_18_0.rtTopLeft

	var_18_0:Setup()
	var_18_0:UpdateMap(nowWorld():GetActiveMap())

	return var_18_0
end

function var_0_0.EnterPortAnim(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.rtEnterIcon:GetComponent(typeof(DftAniEvent))

	if var_19_0 then
		var_19_0:SetTriggerEvent(function(arg_20_0)
			arg_19_1()

			return
		end)
		var_19_0:SetEndEvent(function(arg_21_0)
			setActive(arg_19_0.rtEnterIcon, false)

			return
		end)
	end

	setActive(arg_19_0.rtEnterIcon, true)

	return
end

function var_0_0.EaseInUI(arg_22_0, arg_22_1)
	arg_22_0.isTweening = true

	local var_22_0 = {}

	arg_22_0:CancelUITween()

	if #arg_22_0.enterIcon > 0 and not arg_22_0.contextData.isEnter then
		table.insert(var_22_0, function(arg_23_0)
			setActive(arg_22_0.rtTop, false)
			arg_22_0:EnterPortAnim(function()
				setActive(arg_22_0.rtTop, true)

				return arg_23_0()
			end)

			return
		end)
	else
		setActive(arg_22_0.rtEnterIcon, false)
	end

	seriesAsync(var_22_0, function()
		setAnchoredPosition(arg_22_0.rtTopLeft, {
			x = -arg_22_0.rtTopLeft.rect.width
		})
		setAnchoredPosition(arg_22_0.rtTopRight, {
			x = arg_22_0.rtTopRight.rect.width
		})
		setAnchoredPosition(arg_22_0.rtTopTitle, {
			y = arg_22_0.rtTopTitle.rect.height
		})
		setAnchoredPosition(arg_22_0.rtTopBottom, {
			y = -arg_22_0.rtTopRight.rect.height
		})
		LeanTween.moveX(arg_22_0.rtTopLeft, 0, WorldConst.UIEaseDuration):setEase(LeanTweenType.easeOutSine)
		LeanTween.moveX(arg_22_0.rtTopRight, 0, WorldConst.UIEaseDuration):setEase(LeanTweenType.easeOutSine)
		LeanTween.moveY(arg_22_0.rtTopTitle, 0, WorldConst.UIEaseDuration):setEase(LeanTweenType.easeOutSine)
		LeanTween.moveY(arg_22_0.rtTopBottom, 0, WorldConst.UIEaseDuration):setEase(LeanTweenType.easeOutSine):setOnComplete(System.Action(function()
			arg_22_0.isTweening = false

			return existCall(arg_22_1)
		end))

		return
	end)

	return
end

function var_0_0.EaseOutUI(arg_27_0, arg_27_1)
	arg_27_0:CancelUITween()
	LeanTween.moveX(arg_27_0.rtTopLeft, -arg_27_0.rtTopLeft.rect.width, WorldConst.UIEaseDuration):setEase(LeanTweenType.easeOutSine)
	LeanTween.moveX(arg_27_0.rtTopRight, arg_27_0.rtTopRight.rect.width, WorldConst.UIEaseDuration):setEase(LeanTweenType.easeOutSine)
	LeanTween.moveY(arg_27_0.rtTopTitle, arg_27_0.rtTopTitle.rect.height, WorldConst.UIEaseDuration):setEase(LeanTweenType.easeOutSine)
	LeanTween.moveY(arg_27_0.rtTopBottom, -arg_27_0.rtTopRight.rect.height, WorldConst.UIEaseDuration):setEase(LeanTweenType.easeOutSine):setOnComplete(System.Action(function()
		arg_27_0.isTweening = false

		return existCall(arg_27_1)
	end))

	return
end

function var_0_0.CancelUITween(arg_29_0)
	LeanTween.cancel(go(arg_29_0.rtTopTitle))
	LeanTween.cancel(go(arg_29_0.rtTopLeft))
	LeanTween.cancel(go(arg_29_0.rtTopRight))
	LeanTween.cancel(go(arg_29_0.rtTopBottom))

	return
end

function var_0_0.SetPlayer(arg_30_0, arg_30_1)
	arg_30_0.player = arg_30_1

	arg_30_0.resPanel:setPlayer(arg_30_1)

	return
end

function var_0_0.SetAtlas(arg_31_0, arg_31_1)
	arg_31_0.atlas = arg_31_1

	arg_31_0.atlas:AddListener(WorldAtlas.EventUpdateNGoodsCount, arg_31_0.onUpdateNGoods)

	arg_31_0.nGoodsDic = {}
	arg_31_0.nGoodsPortDic = {}

	for iter_31_0, iter_31_1 in pairs(arg_31_1.nShopGoodsDic) do
		arg_31_0.nGoodsDic[iter_31_0] = Goods.Create({
			id = iter_31_0,
			count = iter_31_1
		}, Goods.TYPE_WORLD_NSHOP)

		local var_31_0 = arg_31_0.nGoodsDic[iter_31_0]:getConfig("port_id")

		arg_31_0.nGoodsPortDic[var_31_0] = arg_31_0.nGoodsPortDic[var_31_0] or {}

		table.insert(arg_31_0.nGoodsPortDic[var_31_0], arg_31_0.nGoodsDic[iter_31_0])
	end

	for iter_31_2, iter_31_3 in pairs(arg_31_0.nGoodsPortDic) do
		table.sort(iter_31_3, CompareFuncs({
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

function var_0_0.SetPort(arg_34_0, arg_34_1)
	local var_34_0 = nowWorld()

	arg_34_0.port = arg_34_1

	arg_34_0.port:AddListener(WorldMapPort.EventUpdateTaskIds, arg_34_0.onUpdateTasks)
	arg_34_0.port:AddListener(WorldMapPort.EventUpdateGoods, arg_34_0.onUpdateGoods)
	arg_34_0:SetBg(arg_34_0.port.id)

	arg_34_0.refreshTimer = Timer.New(function()
		if arg_34_0.port:IsValid() then
			arg_34_0:UpdateRefreshTime(arg_34_0.port.expiredTime - pg.TimeMgr.GetInstance():GetServerTime())
		else
			arg_34_0:emit(WorldPortMediator.OnReqPort, var_34_0:GetActiveMap().id)
		end

		return
	end, 1, -1)

	arg_34_0.refreshTimer:Start()
	arg_34_0.refreshTimer.func()

	local var_34_1 = var_34_0:GetActiveMap():GetFleet()

	arg_34_0.wsPortLeft = arg_34_0:NewPortLeft()

	local var_34_2 = arg_34_0.port:GetRealm()

	setActive(arg_34_0.btnOperation, var_34_2 == 0 or var_34_2 == var_34_0:GetRealm())
	setActive(arg_34_0.btnDockyard, var_34_2 == 0 or var_34_2 == var_34_0:GetRealm())
	setActive(arg_34_0.btnSupply, arg_34_0.nGoodsPortDic[arg_34_1.id])
	setActive(arg_34_0.resPanel._tf, var_34_0:IsSystemOpen(WorldConst.SystemResource))

	arg_34_0.inventory = var_34_0:GetInventoryProxy()

	arg_34_0.inventory:AddListener(WorldInventoryProxy.EventUpdateItem, arg_34_0.onUpdateMoneyCount)
	arg_34_0:OnUpdateMoneyCount()

	arg_34_0.taskProxy = var_34_0:GetTaskProxy()

	arg_34_0.taskProxy:AddListener(WorldTaskProxy.EventUpdateTask, arg_34_0.onUpdateTasks)

	return
end

function var_0_0.SetBg(arg_36_0, arg_36_1)
	arg_36_0.portBg = pg.world_port_data[arg_36_1].port_bg

	setImageAlpha(arg_36_0.rtBg, #arg_36_0.portBg > 0 and 1 or 0)

	if #arg_36_0.portBg > 0 then
		GetImageSpriteFromAtlasAsync("world/port/" .. arg_36_0.portBg, "", arg_36_0.rtBg)
	end

	arg_36_0.enterIcon = pg.world_port_data[arg_36_1].port_entrance_icon

	setActive(arg_36_0.rtEnterIcon, #arg_36_0.enterIcon > 0)

	if #arg_36_0.enterIcon > 0 then
		GetImageSpriteFromAtlasAsync("world/porttitle/" .. arg_36_0.enterIcon, "", arg_36_0.rtEnterIcon, false)
	end

	GetImageSpriteFromAtlasAsync("world/portword/" .. arg_36_0.portBg, "", arg_36_0.rtImageTitle, true)
	GetImageSpriteFromAtlasAsync("world/portword/" .. arg_36_0.portBg .. "_en", "", arg_36_0.rtImageTitle:Find("Image"), true)

	return
end

function var_0_0.OnUpdateTasks(arg_37_0)
	arg_37_0:UpdateTaskTip()
	arg_37_0:SetPageDirty(var_0_0.PageTask)

	if arg_37_0.page == var_0_0.PageTask then
		arg_37_0:UpdateTasks()
	end

	return
end

function var_0_0.OnUpdateGoods(arg_38_0)
	arg_38_0:UpdateCDTip()
	arg_38_0:SetPageDirty(var_0_0.PageShop)

	if arg_38_0.page == var_0_0.PageShop then
		arg_38_0:UpdateGoods()
	end

	return
end

function var_0_0.OnUpdateNGoods(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	if arg_39_0.page == var_0_0.PageNShop then
		arg_39_0.nGoodsDic[arg_39_3].buyCount = arg_39_4

		setText(arg_39_0.rtNGoodsDic[arg_39_3]:Find("count_contain/count"), arg_39_0.nGoodsDic[arg_39_3]:GetPurchasableCnt() .. "/" .. arg_39_0.nGoodsDic[arg_39_3]:GetLimitGoodCount())
		setActive(arg_39_0.rtNGoodsDic[arg_39_3]:Find("mask"), not arg_39_0.nGoodsDic[arg_39_3]:canPurchase())
		setActive(arg_39_0.rtNGoodsDic[arg_39_3]:Find("new"), false)
	else
		arg_39_0:SetPageDirty(var_0_0.PageNShop)
	end

	return
end

function var_0_0.SetPage(arg_40_0, arg_40_1)
	if arg_40_0.page ~= arg_40_1 then
		local var_40_0 = arg_40_0.page or 0
		local var_40_1 = var_0_0.BlurPages[var_40_0]

		if var_40_1 ~= var_0_0.BlurPages[arg_40_1] then
			if var_0_0.BlurPages[arg_40_1] then
				pg.UIMgr.GetInstance():BlurPanel(arg_40_0.rtBlurPanel)
			else
				pg.UIMgr.GetInstance():UnOverlayPanel(arg_40_0.rtBlurPanel, arg_40_0._tf)
			end
		end

		if arg_40_1 == var_0_0.PageShop and arg_40_0.paintingName == "buzhihuo_shop" then
			arg_40_0:showRandomShipWord(pg.navalacademy_shoppingstreet_template[1].words_enter, true, "enter")
		end

		arg_40_0.page = arg_40_1

		arg_40_0:UpdatePage()

		arg_40_0.contextData.page = arg_40_1
	end

	return
end

function var_0_0.SetPageDirty(arg_41_0, arg_41_1)
	arg_41_0.dirtyFlags[arg_41_1] = true

	return
end

function var_0_0.IsPageDirty(arg_42_0, arg_42_1)
	return arg_42_0.dirtyFlags[arg_42_1] == true or arg_42_0.dirtyFlags[arg_42_1] == nil
end

function var_0_0.UpdatePage(arg_43_0)
	arg_43_0:DisplayTopUI(arg_43_0.page)
	setActive(arg_43_0.rtTasks, arg_43_0.page == var_0_0.PageTask)
	setActive(arg_43_0.rtShop, arg_43_0.page == var_0_0.PageShop)
	setActive(arg_43_0.rtNShop, arg_43_0.page == var_0_0.PageNShop)

	if arg_43_0:IsPageDirty(arg_43_0.page) then
		if arg_43_0.page == var_0_0.PageTask then
			arg_43_0:UpdateTasks()
		elseif arg_43_0.page == var_0_0.PageShop then
			arg_43_0:UpdateGoods()
		elseif arg_43_0.page == var_0_0.PageNShop then
			arg_43_0:UpdateNShopPorts()
		end
	end

	return
end

function var_0_0.UpdateTasks(arg_44_0)
	arg_44_0.dirtyFlags[var_0_0.PageTask] = false

	local var_44_0 = arg_44_0.rtTasks:Find("frame/viewport/content")
	local var_44_1 = _.map(arg_44_0.port.taskIds, function(arg_45_0)
		return WorldTask.New({
			id = arg_45_0
		})
	end)

	table.sort(var_44_1, CompareFuncs(WorldTask.sortDic))
	UIItemList.StaticAlign(var_44_0, var_44_0:GetChild(0), #var_44_1, function(arg_46_0, arg_46_1, arg_46_2)
		if arg_46_0 == UIItemList.EventUpdate then
			local var_46_0 = var_44_1[arg_46_1 + 1]

			arg_44_0.wsTasks[arg_46_1 + 1] = arg_44_0.wsTasks[arg_46_1 + 1] or WSPortTask.New(arg_46_2)

			arg_44_0.wsTasks[arg_46_1 + 1]:Setup(var_44_1[arg_46_1 + 1])
			onButton(arg_44_0, arg_44_0.wsTasks[arg_46_1 + 1].btnInactive, function()
				arg_44_0:emit(WorldPortMediator.OnAccepetTask, var_46_0, arg_44_0.port.id)

				return
			end, SFX_PANEL)
			onButton(arg_44_0, arg_44_0.wsTasks[arg_46_1 + 1].btnOnGoing, function()
				arg_44_0:showTaskWindow(var_46_0)

				return
			end, SFX_PANEL)
			onButton(arg_44_0, arg_44_0.wsTasks[arg_46_1 + 1].btnFinished, function()
				arg_44_0:emit(WorldPortMediator.OnSubmitTask, var_46_0)

				return
			end, SFX_PANEL)

			arg_44_0.wsTasks[arg_46_1 + 1].onDrop = function(arg_50_0)
				arg_44_0:emit(var_0_0.ON_DROP, arg_50_0)

				return
			end
		end

		return
	end)
	setActive(arg_44_0.rtTasks:Find("frame/empty"), #var_44_1 == 0)

	return
end

function var_0_0.DisposeTasks(arg_51_0)
	_.each(arg_51_0.wsTasks, function(arg_52_0)
		arg_52_0:Dispose()

		return
	end)

	arg_51_0.wsTasks = {}

	return
end

function var_0_0.UpdateGoods(arg_53_0)
	arg_53_0.dirtyFlags[var_0_0.PageShop] = false

	local var_53_0 = arg_53_0.rtShop:Find("frame/scrollview/view")
	local var_53_1 = underscore.rest(arg_53_0.port.goods, 1)

	table.sort(var_53_1, CompareFuncs({
		function(arg_54_0)
			return -arg_54_0.config.priority
		end,
		function(arg_55_0)
			return arg_55_0.id
		end
	}))
	UIItemList.StaticAlign(var_53_0, var_53_0:GetChild(0), #var_53_1, function(arg_56_0, arg_56_1, arg_56_2)
		arg_56_1 = arg_56_1 + 1

		if arg_56_0 == UIItemList.EventUpdate then
			local var_56_0 = var_53_1[arg_56_1]

			arg_53_0.wsGoods[arg_56_1] = arg_53_0.wsGoods[arg_56_1] or WSPortGoods.New(arg_56_2)

			arg_53_0.wsGoods[arg_56_1]:Setup(var_53_1[arg_56_1])
			onButton(arg_53_0, arg_53_0.wsGoods[arg_56_1].transform, function()
				if var_56_0.count > 0 then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						yesText = "text_buy",
						type = MSGBOX_TYPE_SINGLE_ITEM,
						drop = var_56_0.item,
						onYes = function()
							arg_53_0:emit(WorldPortMediator.OnBuyGoods, var_56_0)

							return
						end
					})
				end

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function var_0_0.DisposeGoods(arg_59_0)
	_.each(arg_59_0.wsGoods, function(arg_60_0)
		arg_60_0:Dispose()

		return
	end)

	arg_59_0.wsGoods = {}

	return
end

function var_0_0.UpdateNShopPorts(arg_61_0)
	arg_61_0.dirtyFlags[var_0_0.PageNShop] = false

	local var_61_0 = underscore.keys(arg_61_0.nGoodsPortDic)

	table.sort(var_61_0)

	for iter_61_0, iter_61_1 in ipairs(var_61_0) do
		if not arg_61_0.poolTplPort[iter_61_0] then
			table.insert(arg_61_0.poolTplPort, cloneTplTo(arg_61_0.tplPort, arg_61_0.containerPort))
		end

		local var_61_1 = arg_61_0.poolTplPort[iter_61_0]

		setText(arg_61_0.poolTplPort[iter_61_0]:Find("Text"), pg.world_port_data[iter_61_1].name)
		setActive(var_61_1:Find("tip"), arg_61_0.atlas.markPortDic.newGoods[iter_61_1])
		onToggle(arg_61_0, var_61_1, function(arg_62_0)
			if arg_62_0 then
				if arg_61_0.nShopPortId == iter_61_1 then
					return
				end

				setActive(var_61_1:Find("tip"), false)
				arg_61_0.atlas:UpdatePortMarkNShop(iter_61_1, false)
				arg_61_0:UpdateNShopTip()
				arg_61_0:UpdateNShopGoods(iter_61_1)
			end

			return
		end, SFX_PANEL)
		triggerToggle(var_61_1, iter_61_1 == arg_61_0.port.id)
	end

	return
end

function var_0_0.UpdateNShopGoods(arg_63_0, arg_63_1)
	arg_63_0.nShopPortId = arg_63_1

	local var_63_0 = arg_63_0.atlas:GetPressingUnlockCount()
	local var_63_1 = arg_63_0.atlas:GetPressingUnlockRecordCount(arg_63_1)
	local var_63_2 = {}

	for iter_63_0, iter_63_1 in ipairs(arg_63_0.nGoodsPortDic[arg_63_1]) do
		local var_63_3 = iter_63_1:getConfig("unlock_num")
		local var_63_4 = ({})[var_63_3]

		if not ({})[var_63_3] then
			var_63_4 = {}
		end

		;({})[var_63_3] = var_63_4

		table.insert(({})[var_63_3], iter_63_1)
	end

	arg_63_0.rtNGoodsDic = {}

	local var_63_5 = underscore.keys({})

	table.sort(var_63_5)
	UIItemList.StaticAlign(arg_63_0.rtNGoodsContainer, arg_63_0.rtNGoodsContainer:Find("group"), #var_63_5, function(arg_64_0, arg_64_1, arg_64_2)
		arg_64_1 = arg_64_1 + 1

		if arg_64_0 == UIItemList.EventUpdate then
			local var_64_0 = var_63_5[arg_64_1]

			setActive(arg_64_2:Find("title"), arg_64_1 > 1)
			setText(arg_64_2:Find("title/other/Text"), i18n("world_instruction_port_goods_locked"))
			setText(arg_64_2:Find("title/other/progress"), math.min(var_63_0, var_64_0) .. "/" .. var_64_0)

			local var_64_1 = arg_64_2:Find("container")

			UIItemList.StaticAlign(var_64_1, var_64_1:Find("item_tpl"), #var_63_2[var_64_0], function(arg_65_0, arg_65_1, arg_65_2)
				arg_65_1 = arg_65_1 + 1

				if arg_65_0 == UIItemList.EventUpdate then
					local var_65_0 = var_63_2[var_64_0][arg_65_1]

					arg_63_0.rtNGoodsDic[var_63_2[var_64_0][arg_65_1].id] = arg_65_2

					local var_65_1 = var_65_0:GetDropInfo()

					updateDrop(arg_65_2:Find("IconTpl"), var_65_1)
					setText(arg_65_2:Find("name_mask/name"), shortenString(var_65_1:getConfig("name"), 6))

					local var_65_2 = var_65_0:GetPriceInfo()

					GetImageSpriteFromAtlasAsync(var_65_2:getIcon(), "", arg_65_2:Find("consume/contain/icon"), false)
					setText(arg_65_2:Find("consume/contain/Text"), var_65_2.count)
					setText(arg_65_2:Find("count_contain/count"), var_65_0:GetPurchasableCnt() .. "/" .. var_65_0:GetLimitGoodCount())
					setText(arg_65_2:Find("count_contain/label"), i18n("activity_shop_exchange_count"))
					setText(arg_65_2:Find("mask/tag/sellout_tag"), i18n("word_sell_out"))
					setActive(arg_65_2:Find("mask"), not var_65_0:canPurchase())
					setText(arg_65_2:Find("lock/Image/Text"), i18n("word_sell_lock"))
					setActive(arg_65_2:Find("lock"), var_63_0 < var_64_0)
					setActive(arg_65_2:Find("new"), var_65_0.buyCount == 0 and var_63_1 < var_64_0 and var_64_0 <= var_63_0)
					onButton(arg_63_0, arg_65_2, function()
						if var_65_0:GetLimitGoodCount() > 1 then
							var_66_0:ExecuteAction("Open", var_65_0, function(arg_67_0, arg_67_1)
								arg_63_0:emit(WorldPortMediator.OnBuyNShopGoods, arg_67_0, arg_67_1)

								return
							end)

							return
						end
					end, SFX_PANEL)
				end

				return
			end)
		end

		return
	end)
	arg_63_0.atlas:SetPressingUnlockRecordCount(arg_63_1, (arg_63_0.atlas:GetPressingUnlockCount()))

	return
end

function var_0_0.OnUpdateMoneyCount(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
	if not arg_68_1 or arg_68_3.id == WorldItem.PortMoneyId then
		local var_68_0 = arg_68_0.inventory:GetItemCount(WorldItem.PortMoneyId)

		setText(arg_68_0.rtShop:Find("quick_count/value"), var_68_0)
		setText(arg_68_0.rtNShopRes:Find("Text"), var_68_0)
	end

	return
end

function var_0_0.UpdateRefreshTime(arg_69_0, arg_69_1)
	setText(arg_69_0.cdTF:Find("Text"), pg.TimeMgr.GetInstance():DescCDTime(arg_69_1))

	return
end

function var_0_0.UpdateCDTip(arg_70_0)
	setActive(arg_70_0.cdTF, #arg_70_0.port.goods > 0 and not arg_70_0.port:IsTempPort())
	setActive(arg_70_0.emptyTF, #arg_70_0.port.goods == 0)

	if not nowWorld():UsePortNShop() then
		setActive(arg_70_0.btnSupply:Find("new"), nowWorld():GetAtlas().markPortDic.goods[arg_70_0.port.id])
	end

	return
end

function var_0_0.UpdateTaskTip(arg_71_0)
	setActive(arg_71_0.btnOperation:Find("new"), false)

	return
end

function var_0_0.UpdateNShopTip(arg_72_0)
	if nowWorld():UsePortNShop() then
		setActive(arg_72_0.btnSupply:Find("new"), arg_72_0.atlas:GetAnyPortMarkNShop())
	end

	return
end

function var_0_0.showTaskWindow(arg_73_0, arg_73_1)
	local var_73_0 = arg_73_0.rtTaskWindow:Find("main_window/left_panel")

	setActive(var_73_0:Find("bg"), arg_73_1:IsSpecialType())

	if #arg_73_1.config.rare_task_icon > 0 then
		GetImageSpriteFromAtlasAsync("shipyardicon/" .. arg_73_1.config.rare_task_icon, "", var_73_0:Find("card"), true)
	else
		GetImageSpriteFromAtlasAsync("ui/worldportui_atlas", "nobody", var_73_0:Find("card"), true)
	end

	local var_73_1 = arg_73_0.rtTaskWindow:Find("main_window/right_panel")

	setText(var_73_1:Find("title/Text"), arg_73_1.config.name)
	setText(var_73_1:Find("content/desc"), arg_73_1.config.rare_task_text)
	setText(var_73_1:Find("content/slider_progress/Text"), arg_73_1:getProgress() .. "/" .. arg_73_1:getMaxProgress())
	setSlider(var_73_1:Find("content/slider"), 0, arg_73_1:getMaxProgress(), arg_73_1:getProgress())

	local var_73_2 = var_73_1:Find("content/item_tpl")
	local var_73_3 = var_73_1:Find("content/award_bg/panel/content")
	local var_73_4 = arg_73_1.config.show

	removeAllChildren(var_73_3)

	for iter_73_0, iter_73_1 in ipairs(var_73_4) do
		local var_73_5 = cloneTplTo(var_73_2, var_73_3)

		updateDrop(var_73_5, {
			type = iter_73_1[1],
			id = iter_73_1[2],
			count = iter_73_1[3]
		})
		onButton(arg_73_0, var_73_5, function()
			arg_73_0:emit(var_0_0.ON_DROP, var_0)

			return
		end, SFX_PANEL)
		setActive(var_73_5, true)
	end

	setActive(var_73_2, false)
	setActive(var_73_1:Find("content/award_bg/arror"), #var_73_4 > 3)
	onButton(arg_73_0, var_73_1:Find("btn_close"), function()
		arg_73_0:hideTaskWindow()

		return
	end, SFX_CANCEL)
	onButton(arg_73_0, arg_73_0.rtTaskWindow:Find("bg"), function()
		arg_73_0:hideTaskWindow()

		return
	end, SFX_CANCEL)
	onButton(arg_73_0, var_73_1:Find("btn_go"), function()
		arg_73_0:hideTaskWindow()
		arg_73_0:emit(WorldPortMediator.OnTaskGoto, arg_73_1.id)

		return
	end, SFX_PANEL)

	local var_73_6 = arg_73_1:GetFollowingAreaId() or arg_73_1:GetFollowingEntrance()

	setButtonEnabled(var_73_1:Find("btn_go"), var_73_6)
	setActive(arg_73_0.rtTaskWindow, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_73_0.rtTaskWindow)

	return
end

function var_0_0.hideTaskWindow(arg_78_0)
	setActive(arg_78_0.rtTaskWindow, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_78_0.rtTaskWindow, arg_78_0._tf)

	return
end

return var_0_0

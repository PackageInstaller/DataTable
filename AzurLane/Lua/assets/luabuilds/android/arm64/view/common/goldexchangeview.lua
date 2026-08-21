local var_0_0 = class("GoldExchangeView")

var_0_0.itemid1 = 12
var_0_0.itemid2 = 24
var_0_0.const = 5
var_0_0.goldNum = {
	[1] = 3000,
	[2] = 15000
}
var_0_0.gemNum = {
	[1] = 100,
	[2] = 450
}

function var_0_0.Ctor(arg_1_0)
	pg.DelegateInfo.New(arg_1_0)
	PoolMgr.GetInstance():GetUI("GoldExchangeWindow", false, function(arg_2_0)
		arg_2_0.transform:SetParent(pg.UIMgr.GetInstance().UIMain.transform, false)

		arg_1_0._go = arg_2_0
		arg_1_0._tf = arg_2_0.transform

		arg_1_0:init()

		return
	end)

	return
end

function var_0_0.init(arg_3_0)
	arg_3_0:initData()
	arg_3_0:initUI()
	arg_3_0:addListener()
	arg_3_0:overLayMyself(true)
	arg_3_0:updateView()

	return
end

function var_0_0.exit(arg_4_0)
	pg.DelegateInfo.Dispose(arg_4_0)
	arg_4_0:overLayMyself(false)
	PoolMgr.GetInstance():ReturnUI("GoldExchangeWindow", arg_4_0._go)

	pg.goldExchangeMgr = nil

	return
end

function var_0_0.initData(arg_5_0)
	arg_5_0.selectedIndex = 1
	arg_5_0.selectedNum = 1
	arg_5_0.selectedMax = 10
	arg_5_0.player = getProxy(PlayerProxy):getData()

	return
end

function var_0_0.initUI(arg_6_0)
	arg_6_0.bg = arg_6_0._tf:Find("BG")
	arg_6_0.btnBack = arg_6_0._tf:Find("Window/top/btnBack")
	arg_6_0.contentTF = arg_6_0._tf:Find("Window/Content")
	arg_6_0.goldTF = {}
	arg_6_0.goldTF[1] = {}
	arg_6_0.goldTF_1 = arg_6_0.contentTF:Find("Gold1")
	arg_6_0.goldTF[1].itemTF = arg_6_0.goldTF_1
	arg_6_0.goldTF[1].countTF = arg_6_0.goldTF_1:Find("item/icon_bg/count")
	arg_6_0.goldTF[1].priceTF = arg_6_0.goldTF_1:Find("item/consume/contain/price")
	arg_6_0.goldTF[1].selectedTF = arg_6_0.goldTF_1:Find("item/selected")
	arg_6_0.goldTF[1].selectedNumTF = arg_6_0.goldTF[1].selectedTF:Find("reduce/Text")

	setText(arg_6_0.goldTF[1].countTF, var_0_0.goldNum[1])
	setText(arg_6_0.goldTF[1].priceTF, var_0_0.gemNum[1])

	arg_6_0.goldTF[2] = {}
	arg_6_0.goldTF_2 = arg_6_0.contentTF:Find("Gold2")
	arg_6_0.goldTF[2].itemTF = arg_6_0.goldTF_2
	arg_6_0.goldTF[2].countTF = arg_6_0.goldTF_2:Find("item/icon_bg/count")
	arg_6_0.goldTF[2].priceTF = arg_6_0.goldTF_2:Find("item/consume/contain/price")
	arg_6_0.goldTF[2].selectedTF = arg_6_0.goldTF_2:Find("item/selected")
	arg_6_0.goldTF[2].selectedNumTF = arg_6_0.goldTF[2].selectedTF:Find("reduce/Text")

	setText(arg_6_0.goldTF[2].countTF, var_0_0.goldNum[2])
	setText(arg_6_0.goldTF[2].priceTF, var_0_0.gemNum[2])

	arg_6_0.gemCountText = arg_6_0.contentTF:Find("Tip/DiamondCount")
	arg_6_0.goldCountText = arg_6_0.contentTF:Find("Tip/GoldCount")
	arg_6_0.shopBtn = arg_6_0._tf:Find("Window/button_container/ShopBtn")
	arg_6_0.confirmBtn = arg_6_0._tf:Find("Window/button_container/ConfirmBtn")

	return
end

function var_0_0.addListener(arg_7_0)
	onButton(arg_7_0, arg_7_0.bg, function()
		arg_7_0:exit()

		return
	end, SFX_CANCEL)
	onButton(arg_7_0, arg_7_0.btnBack, function()
		arg_7_0:exit()

		return
	end, SFX_CANCEL)
	onButton(arg_7_0, arg_7_0.shopBtn, function()
		if getProxy(ContextProxy):getContextByMediator(NewShopMainMediator) then
			arg_7_0:exit()
		else
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CHARGE, {
				wrap = ChargeScene.TYPE_ITEM
			})
		end

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.confirmBtn, function()
		local var_11_0

		if arg_7_0.selectedIndex == 1 then
			var_11_0 = var_0_0.itemid1
		elseif arg_7_0.selectedIndex == 2 then
			var_11_0 = var_0_0.itemid2
		end

		pg.m02:sendNotification(GAME.SHOPPING, {
			isQuickShopping = true,
			id = var_11_0,
			count = arg_7_0.selectedNum
		})
		arg_7_0:exit()

		return
	end, SFX_PANEL)

	for iter_7_0 = 1, 2 do
		onButton(arg_7_0, arg_7_0.goldTF[iter_7_0].itemTF, function()
			if arg_7_0.selectedIndex == iter_7_0 then
				arg_7_0.selectedNum = math.min(arg_7_0.selectedNum + 1, arg_7_0.selectedMax)
			else
				arg_7_0.selectedIndex = iter_7_0
				arg_7_0.selectedNum = 1
			end

			arg_7_0:updateView()

			return
		end, SFX_PANEL)
		onButton(arg_7_0, arg_7_0.goldTF[iter_7_0].selectedTF, function()
			if arg_7_0.selectedNum > 1 then
				arg_7_0.selectedNum = arg_7_0.selectedNum - 1

				arg_7_0:updateView()
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.updateView(arg_14_0)
	for iter_14_0 = 1, 2 do
		setActive(arg_14_0.goldTF[iter_14_0].selectedTF, iter_14_0 == arg_14_0.selectedIndex)
		setActive(arg_14_0.goldTF[3 - iter_14_0].selectedTF, iter_14_0 ~= arg_14_0.selectedIndex)

		if iter_14_0 == arg_14_0.selectedIndex then
			setText(arg_14_0.goldTF[iter_14_0].selectedNumTF, arg_14_0.selectedNum)
		end
	end

	setText(arg_14_0.gemCountText, var_0_0.gemNum[arg_14_0.selectedIndex] * arg_14_0.selectedNum)

	if var_0_0.gemNum[arg_14_0.selectedIndex] * arg_14_0.selectedNum > arg_14_0.player:getTotalGem() then
		setTextColor(arg_14_0.gemCountText, Color.red)
	else
		setTextColor(arg_14_0.gemCountText, Color.yellow)
	end

	setText(arg_14_0.goldCountText, var_14_1)

	return
end

function var_0_0.overLayMyself(arg_15_0, arg_15_1)
	if arg_15_1 == true then
		pg.UIMgr.GetInstance():BlurPanel(arg_15_0._tf)
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_15_0._tf)
	end

	return
end

return var_0_0

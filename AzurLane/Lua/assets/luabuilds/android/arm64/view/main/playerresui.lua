local var_0_0 = class("PlayerResUI", pm.Mediator)

var_0_0.GO_MALL = "PlayerResUI:GO_MALL"
var_0_0.CHANGE_TOUCH_ABLE = "PlayerResUI:CHANGE_TOUCH_ABLE"
var_0_0.HIDE = "PlayerResUI:HIDE"
var_0_0.SHOW = "PlayerResUI:SHOW"

local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4

var_0_0.TYPE_OIL = 2
var_0_0.TYPE_GOLD = 4
var_0_0.TYPE_GEM = 8
var_0_0.TYPE_ALL = bit.bor(2, 4, 8)
var_0_0.DEFAULT_MODE = {
	showType = var_0_0.TYPE_ALL
}

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)
	pg.DelegateInfo.New(arg_1_0)
	pg.m02:registerMediator(arg_1_0)

	arg_1_0.state = var_0_1
	arg_1_0.settingsDic = {}
	arg_1_0.settingsStack = {}

	return
end

function var_0_0.GetPlayer(arg_2_0)
	return getProxy(PlayerProxy):getRawData()
end

function var_0_0.IsLoaded(arg_3_0)
	return arg_3_0.state > var_0_2
end

function var_0_0.IsEnable(arg_4_0)
	return arg_4_0.state == var_0_4
end

function var_0_0.Load(arg_5_0, arg_5_1)
	if arg_5_0.state ~= var_0_1 then
		return
	end

	arg_5_0.state = var_0_2

	PoolMgr.GetInstance():GetUI("ResPanel", true, arg_5_1)

	return
end

function var_0_0.Init(arg_6_0, arg_6_1)
	arg_6_0._go = arg_6_1
	arg_6_0.oilAddBtn = findTF(arg_6_0._go, "oil")
	arg_6_0.goldAddBtn = findTF(arg_6_0._go, "gold")
	arg_6_0.gemAddBtn = findTF(arg_6_0._go, "gem")
	arg_6_0.goldMax = findTF(arg_6_0._go, "gold/gold_max_value"):GetComponent(typeof(Text))
	arg_6_0.goldValue = findTF(arg_6_0._go, "gold/gold_value"):GetComponent(typeof(Text))
	arg_6_0.oilMax = findTF(arg_6_0._go, "oil/oil_max_value"):GetComponent(typeof(Text))
	arg_6_0.oilValue = findTF(arg_6_0._go, "oil/oil_value"):GetComponent(typeof(Text))
	arg_6_0.gemValue = findTF(arg_6_0._go, "gem/gem_value"):GetComponent(typeof(Text))
	arg_6_0.animation = arg_6_0._go:GetComponent(typeof(Animation))
	arg_6_0.gemPos = arg_6_0.gemAddBtn.anchoredPosition
	arg_6_0.oilPos = arg_6_0.oilAddBtn.anchoredPosition
	arg_6_0.foldableHelper = MainFoldableHelper.New(arg_6_0._go.transform, Vector2(0, 1))

	onButton(arg_6_0, arg_6_0.goldAddBtn, function()
		arg_6_0:ClickGold()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.oilAddBtn, function()
		arg_6_0:ClickOil()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.gemAddBtn, function()
		arg_6_0:ClickGem()

		return
	end, SFX_PANEL)

	arg_6_0.position = tf(arg_6_0._go).anchoredPosition

	setActive(arg_6_0._go, true)

	return
end

function var_0_0.SetSettings(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.settingsDic[arg_10_1] = arg_10_2

	arg_10_0:Reflush()

	return
end

function var_0_0.RemoveSettings(arg_11_0, arg_11_1)
	arg_11_0.settingsDic[arg_11_1] = nil

	arg_11_0:Reflush()

	return
end

function var_0_0.GetWeight(arg_12_0, arg_12_1)
	return pg.LayerWeightMgr.GetInstance().groupWeightDic[arg_12_1]
end

function var_0_0.Reflush(arg_13_0)
	local var_13_0

	for iter_13_0, iter_13_1 in pairs(arg_13_0.settingsDic) do
		if not var_13_0 or arg_13_0:GetWeight(var_13_0) < arg_13_0:GetWeight(iter_13_0) then
			var_13_0 = iter_13_0
		end
	end

	if var_13_0 then
		local var_13_1 = arg_13_0.settingsDic[var_13_0] or nil

		if var_13_1 ~= arg_13_0.topSettings then
			if var_13_0 then
				arg_13_0.topSettings = arg_13_0.settingsDic[var_13_0] or nil

				if arg_13_0.topSettings then
					arg_13_0:Enable(arg_13_0.topSettings)
				else
					arg_13_0:Disable()
				end

				return
			end
		end
	end
end

function var_0_0.Enable(arg_14_0, arg_14_1)
	if not arg_14_0:IsLoaded() then
		arg_14_0:Load(function(arg_15_0)
			arg_14_0._tf = arg_15_0.transform
			arg_14_0.state = var_0_4

			arg_14_0:Init(arg_14_0._tf:Find("frame").gameObject)
			arg_14_0:CustomSetting(arg_14_1)
			arg_14_0:Flush()

			return
		end)
	elseif arg_14_0.state == var_0_4 then
		arg_14_0:CustomSetting(arg_14_1)
	else
		arg_14_0.state = var_0_4

		arg_14_0:CustomSetting(arg_14_1)
		setActive(arg_14_0._go, true)

		if arg_14_0:IsDirty() then
			arg_14_0:Flush()
		end
	end

	return
end

function var_0_0.Disable(arg_16_0)
	if pg.goldExchangeMgr then
		pg.goldExchangeMgr:exit()

		pg.goldExchangeMgr = nil
	end

	if arg_16_0:IsLoaded() then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_16_0._tf)
		setActive(arg_16_0._go, false)

		arg_16_0.state = var_0_3
	end

	return
end

function var_0_0.CustomSetting(arg_17_0, arg_17_1)
	setActive(arg_17_0.oilAddBtn, bit.band(arg_17_1.showType, var_0_0.TYPE_OIL) > 0)
	setActive(arg_17_0.goldAddBtn, bit.band(arg_17_1.showType, var_0_0.TYPE_GOLD) > 0)
	setActive(arg_17_0.gemAddBtn, bit.band(arg_17_1.showType, var_0_0.TYPE_GEM) > 0)

	if arg_17_1.anim then
		arg_17_0:DoAnimation()
	end

	local var_17_0 = arg_17_1.gemOffsetX or 0

	arg_17_0.gemAddBtn.anchoredPosition3D = Vector3(arg_17_0.gemPos.x + var_17_0, arg_17_0.gemPos.y, 1)
	arg_17_0.oilAddBtn.anchoredPosition3D = Vector3(arg_17_0.oilPos.x + var_17_0, arg_17_0.oilPos.y, 1)

	pg.UIMgr.GetInstance():OverlayPanel(arg_17_0._tf, {
		groupName = arg_17_1.groupName,
		groupDelta = arg_17_1.groupDelta
	})

	return
end

function var_0_0.DoAnimation(arg_18_0)
	arg_18_0.foldableHelper:Fold(true, 0)
	arg_18_0.foldableHelper:Fold(false, 0.5)

	return
end

function var_0_0.ClickGem(arg_19_0)
	local var_19_0 = arg_19_0:GetPlayer()

	if PLATFORM_CODE == PLATFORM_JP then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			fontSize = 23,
			yesText = "text_buy",
			content = i18n("word_diamond_tip", var_19_0:getFreeGem(), var_19_0:getChargeGem(), var_19_0:getTotalGem()),
			onYes = function()
				if not pg.m02:hasMediator(NewShopMainMediator.__cname) then
					pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CHARGE, {
						wrap = ChargeScene.TYPE_DIAMOND
					})
				else
					pg.m02:sendNotification(var_0_0.GO_MALL)
				end

				return
			end,
			alignment = TextAnchor.UpperLeft
		})
	else
		(function()
			if not pg.m02:hasMediator(NewShopMainMediator.__cname) then
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CHARGE, {
					wrap = ChargeScene.TYPE_DIAMOND
				})
			else
				pg.m02:sendNotification(var_0_0.GO_MALL)
			end

			return
		end)()
	end

	return
end

function var_0_0.ClickGold(arg_21_0)
	pg.goldExchangeMgr = pg.goldExchangeMgr or GoldExchangeView.New()

	return
end

function var_0_0.ClickOil(arg_22_0)
	local var_22_0 = arg_22_0:GetPlayer()
	local var_22_2 = ShoppingStreet.getRiseShopId(ShopArgs.BuyOil, var_22_0.buyOilCount)

	if not var_22_2 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_today_buy_limit"))

		return
	end

	local var_22_3 = pg.shop_template[var_22_2]
	local var_22_4 = pg.shop_template[var_22_2].num

	if pg.shop_template[var_22_2].num == -1 and var_22_3.genre == ShopArgs.BuyOil then
		var_22_4 = ShopArgs.getOilByLevel(var_22_0.level)
	end

	if pg.gameset.buy_oil_limit.key_value > var_22_0.buyOilCount then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_SINGLE_ITEM,
			windowSize = {
				y = 570
			},
			content = i18n("oil_buy_tip", var_22_3.resource_num, var_22_4, var_22_0.buyOilCount),
			drop = {
				id = 2,
				type = DROP_TYPE_RESOURCE,
				count = var_22_4
			},
			onYes = function()
				pg.m02:sendNotification(GAME.SHOPPING, {
					isQuickShopping = true,
					count = 1,
					id = var_22_2
				})
				pg.TrackerMgr.GetInstance():Tracking(TRACKING_PAY_OIL)

				return
			end
		})
	else
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("help_oil_buy_limit"),
			custom = {
				{
					text = "text_iknow",
					sound = SFX_CANCEL
				}
			}
		})
	end

	return
end

function var_0_0.Flush(arg_24_0)
	var_0_0.StaticFlush(arg_24_0:GetPlayer(), arg_24_0.goldMax, arg_24_0.goldValue, arg_24_0.oilMax, arg_24_0.oilValue, arg_24_0.gemValue)
	arg_24_0:SetDirty(false)

	return
end

function var_0_0.StaticFlush(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
	arg_25_1.text = "MAX: " .. arg_25_0:getLevelMaxGold()
	arg_25_2.text = arg_25_0.gold
	arg_25_3.text = "MAX: " .. arg_25_0:getLevelMaxOil()
	arg_25_4.text = arg_25_0.oil
	arg_25_5.text = arg_25_0:getTotalGem()

	return
end

function var_0_0.Dispose(arg_26_0)
	pg.DelegateInfo.Dispose(arg_26_0)
	arg_26_0:Disable()
	pg.m02:removeMediator(arg_26_0.__cname)
	PoolMgr.GetInstance():ReturnUI("ResPanel", arg_26_0._go)

	arg_26_0.state = var_0_1

	return
end

function var_0_0.SetDirty(arg_27_0, arg_27_1)
	arg_27_0.dirty = arg_27_1

	return
end

function var_0_0.IsDirty(arg_28_0)
	return arg_28_0.dirty
end

function var_0_0.Fold(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_0:IsLoaded() then
		return
	end

	arg_29_0.foldableHelper:Fold(arg_29_1, arg_29_2)

	return
end

function var_0_0.listNotificationInterests(arg_30_0)
	return {
		PlayerProxy.UPDATED,
		GAME.GUILD_GET_USER_INFO_DONE,
		GAME.GET_PUBLIC_GUILD_USER_DATA_DONE,
		PlayerResUI.CHANGE_TOUCH_ABLE,
		var_0_0.HIDE,
		var_0_0.SHOW
	}
end

function var_0_0.handleNotification(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1:getName()

	if var_31_0 == PlayerResUI.CHANGE_TOUCH_ABLE then
		local var_31_1 = arg_31_1:getBody()
		local var_31_2 = GetComponent(tf(arg_31_0._go), typeof(CanvasGroup))

		var_31_2.interactable = var_31_1
		var_31_2.blocksRaycasts = var_31_1

		return
	end

	arg_31_0:updateResPanel(var_31_0)

	return
end

function var_0_0.updateResPanel(arg_32_0, arg_32_1)
	if not arg_32_0:IsEnable() then
		arg_32_0:SetDirty(true)

		return
	end

	if arg_32_1 == PlayerProxy.UPDATED or arg_32_1 == GAME.GUILD_GET_USER_INFO_DONE or arg_32_1 == GAME.GET_PUBLIC_GUILD_USER_DATA_DONE then
		arg_32_0:Flush()
	end

	return
end

function var_0_0.checkBackPressed(arg_33_0)
	if pg.goldExchangeMgr then
		pg.goldExchangeMgr:exit()

		pg.goldExchangeMgr = nil

		return true
	else
		return false
	end

	return
end

return var_0_0

class = var_0_10000

local var_0_0 = "PlayerResUI"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.Mediator)

var_0_1.GO_MALL = "PlayerResUI:GO_MALL"
var_0_1.CHANGE_TOUCH_ABLE = "PlayerResUI:CHANGE_TOUCH_ABLE"
var_0_1.HIDE = "PlayerResUI:HIDE"
var_0_1.SHOW = "PlayerResUI:SHOW"

local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4

var_0_1.TYPE_OIL = 2
var_0_1.TYPE_GOLD = 4
var_0_1.TYPE_GEM = 8
bit = var_5
var_0_1.TYPE_ALL = var_5.bor(2, 4, 8)
var_0_1.DEFAULT_MODE = {
	showType = var_0_1.TYPE_ALL
}

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	pg = var_1

	var_1.DelegateInfo.New(arg_1_0)

	pg = var_1

	local var_1_0 = var_1.m02

	var_1.registerMediator(var_1_0, arg_1_0)

	arg_1_0.state = var_0_2
	arg_1_0.settingsDic = {}
	arg_1_0.settingsStack = {}

	return
end

function var_0_1.GetPlayer(arg_2_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)

	return var_1.getRawData(var_2_0)
end

function var_0_1.IsLoaded(arg_3_0)
	return arg_3_0.state > var_0_3
end

function var_0_1.IsEnable(arg_4_0)
	return arg_4_0.state == var_0_5
end

function var_0_1.Load(arg_5_0, arg_5_1)
	if arg_5_0.state ~= var_0_2 then
		return
	end

	arg_5_0.state = var_0_3
	PoolMgr = var_2

	local var_5_0 = var_2.GetInstance()

	var_2.GetUI(var_5_0, "ResPanel", true, arg_5_1)

	return
end

function var_0_1.Init(arg_6_0, arg_6_1)
	arg_6_0._go = arg_6_1
	findTF = var_1_10002
	arg_6_0.oilAddBtn = var_1_10002(arg_6_0._go, "oil")
	findTF = var_2
	arg_6_0.goldAddBtn = var_2(arg_6_0._go, "gold")
	findTF = var_2
	arg_6_0.gemAddBtn = var_2(arg_6_0._go, "gem")
	findTF = var_2

	local var_6_0 = var_2(arg_6_0._go, "gold/gold_max_value")
	local var_6_1 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_6_0.goldMax = var_6_1(var_6_0, var_5(var_1_10007))
	findTF = var_2

	local var_6_2 = var_2(arg_6_0._go, "gold/gold_value")
	local var_6_3 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_6_0.goldValue = var_6_3(var_6_2, var_5(var_1_10007))
	findTF = var_2

	local var_6_4 = var_2(arg_6_0._go, "oil/oil_max_value")
	local var_6_5 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_6_0.oilMax = var_6_5(var_6_4, var_5(var_1_10007))
	findTF = var_2

	local var_6_6 = var_2(arg_6_0._go, "oil/oil_value")
	local var_6_7 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_6_0.oilValue = var_6_7(var_6_6, var_5(var_1_10007))
	findTF = var_2

	local var_6_8 = var_2(arg_6_0._go, "gem/gem_value")
	local var_6_9 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_6_0.gemValue = var_6_9(var_6_8, var_5(var_1_10007))

	local var_6_10 = arg_6_0._go
	local var_6_11 = var_2.GetComponent

	typeof = var_5
	Animation = var_1_10007
	arg_6_0.animation = var_6_11(var_6_10, var_5(var_1_10007))
	arg_6_0.gemPos = arg_6_0.gemAddBtn.anchoredPosition
	arg_6_0.oilPos = arg_6_0.oilAddBtn.anchoredPosition
	MainFoldableHelper = var_2

	local var_6_12 = var_2.New
	local var_6_13 = arg_6_0._go.transform

	Vector2 = var_5
	arg_6_0.foldableHelper = var_6_12(var_6_13, var_5(0, 1))
	onButton = var_2

	local var_6_14 = arg_6_0
	local var_6_15 = arg_6_0.goldAddBtn

	local function var_6_16()
		local var_7_0 = arg_6_0

		var_0.ClickGold(var_7_0)

		return
	end

	SFX_PANEL = var_7

	var_2(var_6_14, var_6_15, var_6_16, var_7)

	onButton = var_2

	local var_6_17 = arg_6_0
	local var_6_18 = arg_6_0.oilAddBtn

	local function var_6_19()
		local var_8_0 = arg_6_0

		var_0.ClickOil(var_8_0)

		return
	end

	SFX_PANEL = var_7

	var_2(var_6_17, var_6_18, var_6_19, var_7)

	onButton = var_2

	local var_6_20 = arg_6_0
	local var_6_21 = arg_6_0.gemAddBtn

	local function var_6_22()
		local var_9_0 = arg_6_0

		var_0.ClickGem(var_9_0)

		return
	end

	SFX_PANEL = var_7

	var_2(var_6_20, var_6_21, var_6_22, var_7)

	tf = var_2
	arg_6_0.position = var_2(arg_6_0._go).anchoredPosition
	setActive = var_2

	var_2(arg_6_0._go, true)

	return
end

function var_0_1.SetSettings(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.settingsDic[arg_10_1] = arg_10_2

	arg_10_0:Reflush()

	return
end

function var_0_1.RemoveSettings(arg_11_0, arg_11_1)
	arg_11_0.settingsDic[arg_11_1] = nil

	arg_11_0:Reflush()

	return
end

function var_0_1.GetWeight(arg_12_0, arg_12_1)
	pg = var_1_10002

	return var_1_10002.LayerWeightMgr.GetInstance().groupWeightDic[arg_12_1]
end

function var_0_1.Reflush(arg_13_0)
	local var_13_0

	pairs = var_1_10002

	for iter_13_0, iter_13_1 in var_1_10002(arg_13_0.settingsDic) do
		if not var_13_0 or arg_13_0:GetWeight(var_13_0) < arg_13_0:GetWeight(iter_13_0) then
			var_13_0 = iter_13_0
		end
	end

	local var_13_1

	if not var_13_0 or not arg_13_0.settingsDic[var_13_0] then
		var_13_1 = nil
	end

	if var_13_1 ~= arg_13_0.topSettings then
		local var_13_2

		if not var_13_0 or not arg_13_0.settingsDic[var_13_0] then
			var_13_2 = nil
		end

		arg_13_0.topSettings = var_13_2

		if arg_13_0.topSettings then
			arg_13_0:Enable(arg_13_0.topSettings)
		else
			arg_13_0:Disable()
		end
	end

	return
end

function var_0_1.Enable(arg_14_0, arg_14_1)
	if not arg_14_0:IsLoaded() then
		arg_14_0:Load(function(arg_15_0)
			arg_14_0._tf = arg_15_0.transform
			arg_14_0.state = var_0_5

			local var_15_0 = arg_14_0
			local var_15_1 = var_1.Init
			local var_15_2 = arg_14_0._tf

			var_15_1(var_15_0, var_4.Find(var_15_2, "frame").gameObject)

			local var_15_3 = arg_14_0

			var_1.CustomSetting(var_15_3, arg_14_1)

			local var_15_4 = arg_14_0

			var_1.Flush(var_15_4)

			return
		end)
	elseif arg_14_0.state == var_0_5 then
		arg_14_0:CustomSetting(arg_14_1)
	else
		arg_14_0.state = var_0_5

		arg_14_0:CustomSetting(arg_14_1)

		setActive = var_2

		var_2(arg_14_0._go, true)

		if arg_14_0:IsDirty() then
			arg_14_0:Flush()
		end
	end

	return
end

function var_0_1.Disable(arg_16_0)
	pg = var_1_10001

	if var_1_10001.goldExchangeMgr then
		pg = var_1

		local var_16_0 = var_1.goldExchangeMgr

		var_1.exit(var_16_0)

		pg = var_1
		var_1.goldExchangeMgr = nil
	end

	if arg_16_0:IsLoaded() then
		pg = var_1

		local var_16_1 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_16_1, arg_16_0._tf)

		setActive = var_1

		var_1(arg_16_0._go, false)

		arg_16_0.state = var_0_4
	end

	return
end

function var_0_1.CustomSetting(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.showType

	setActive = var_1_10003

	local var_17_1 = arg_17_0.oilAddBtn

	bit = var_1_10006

	var_1_10003(var_17_1, var_1_10006.band(var_17_0, var_0_1.TYPE_OIL) > 0)

	setActive = var_1_10003

	local var_17_2 = arg_17_0.goldAddBtn

	bit = var_6

	var_1_10003(var_17_2, var_6.band(var_17_0, var_0_1.TYPE_GOLD) > 0)

	setActive = var_1_10003

	local var_17_3 = arg_17_0.gemAddBtn

	bit = var_6

	var_1_10003(var_17_3, var_6.band(var_17_0, var_0_1.TYPE_GEM) > 0)

	if arg_17_1.anim then
		var_17_3 = arg_17_0

		arg_17_0.DoAnimation(var_17_3)
	end

	local var_17_4

	if not arg_17_1.gemOffsetX then
		var_17_4 = 0
	end

	local var_17_5 = arg_17_0.gemAddBtn

	Vector3 = var_17_3
	var_17_5.anchoredPosition3D = var_17_3(arg_17_0.gemPos.x + var_17_4, arg_17_0.gemPos.y, 1)

	local var_17_6 = arg_17_0.oilAddBtn

	Vector3 = var_5
	var_17_6.anchoredPosition3D = var_5(arg_17_0.oilPos.x + var_17_4, arg_17_0.oilPos.y, 1)
	pg = var_17_6

	local var_17_7 = var_17_6.UIMgr.GetInstance()

	var_4.OverlayPanel(var_17_7, arg_17_0._tf, {
		groupName = arg_17_1.groupName,
		groupDelta = arg_17_1.groupDelta
	})

	return
end

function var_0_1.DoAnimation(arg_18_0)
	local var_18_0 = arg_18_0.foldableHelper

	var_1.Fold(var_18_0, true, 0)

	local var_18_1 = arg_18_0.foldableHelper

	var_1.Fold(var_18_1, false, 0.5)

	return
end

function var_0_1.ClickGem(arg_19_0)
	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.GetPlayer(var_19_0)

	local function var_19_2()
		pg = var_2_10000

		local var_20_0 = var_2_10000.m02
		local var_20_1 = var_0.hasMediator

		NewShopMainMediator = var_2_10003

		local var_20_3

		if not var_20_1(var_20_0, var_2_10003.__cname) then
			pg = var_20_3

			local var_20_2 = var_20_3.m02

			var_20_3 = var_20_3.sendNotification
			GAME = var_3

			local var_20_4 = var_3.GO_SCENE

			SCENE = var_2_10004

			local var_20_5 = var_2_10004.CHARGE
			local var_20_6 = {}

			ChargeScene = var_2_10006
			var_20_6.wrap = var_2_10006.TYPE_DIAMOND

			var_20_3(var_20_2, var_20_4, var_20_5, var_20_6)
		else
			pg = var_20_3

			local var_20_7 = var_20_3.m02

			var_0.sendNotification(var_20_7, var_0_1.GO_MALL)
		end

		return
	end

	PLATFORM_CODE = var_19_0
	PLATFORM_JP = var_1_10004

	if var_19_0 == var_1_10004 then
		pg = var_19_0

		local var_19_3 = var_19_0.MsgboxMgr.GetInstance()
		local var_19_4 = var_3.ShowMsgBox
		local var_19_5 = {
			fontSize = 23,
			yesText = "text_buy"
		}

		i18n = var_1_10007
		var_19_5.content = var_1_10007("word_diamond_tip", var_19_1:getFreeGem(), var_19_1:getChargeGem(), var_19_1:getTotalGem())
		var_19_5.onYes = var_19_2
		TextAnchor = var_7
		var_19_5.alignment = var_7.UpperLeft

		var_19_4(var_19_3, var_19_5)
	else
		var_19_2()
	end

	return
end

function var_0_1.ClickGold(arg_21_0)
	pg = var_1_10001

	if not var_1_10001.goldExchangeMgr then
		pg = var_1
		GoldExchangeView = var_1_10002
		var_1.goldExchangeMgr = var_1_10002.New()
	end

	return
end

function var_0_1.ClickOil(arg_22_0)
	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.GetPlayer(var_22_0)

	pg = var_1_10002

	local var_22_2 = var_1_10002.shop_template

	ShoppingStreet = var_22_0

	local var_22_3 = var_22_0.getRiseShopId

	ShopArgs = var_1_10005

	if not var_22_3(var_1_10005.BuyOil, var_22_1.buyOilCount) then
		pg = var_1_10004

		local var_22_4 = var_1_10004.TipsMgr.GetInstance()

		var_1_10004 = var_1_10004.ShowTips
		i18n = var_1_10007

		var_1_10004(var_22_4, var_1_10007("common_today_buy_limit"))

		return
	end

	pg = var_1_10004

	local var_22_5 = var_1_10004.shop_template[var_3].num
	local var_22_6

	if var_4.num == -1 then
		var_22_6 = var_4.genre
		ShopArgs = var_1_10007

		if var_22_6 == var_1_10007.BuyOil then
			ShopArgs = var_22_6
			var_22_5 = var_22_6.getOilByLevel(var_22_1.level)
		end
	end

	pg = var_22_6

	local var_22_7 = var_22_6.gameset.buy_oil_limit.key_value
	local var_22_9

	if var_22_1.buyOilCount < var_22_7 then
		pg = var_22_9

		local var_22_8 = var_22_9.MsgboxMgr.GetInstance()

		var_22_9 = var_22_9.ShowMsgBox

		local var_22_10 = {}

		MSGBOX_TYPE_SINGLE_ITEM = var_1_10011
		var_22_10.type = var_1_10011
		var_22_10.windowSize = {
			y = 570
		}
		i18n = var_1_10011
		var_22_10.content = var_1_10011("oil_buy_tip", var_4.resource_num, var_22_5, var_22_1.buyOilCount)
		var_1_10011 = {
			id = 2
		}
		DROP_TYPE_RESOURCE = var_1_10012
		var_1_10011.type = var_1_10012
		var_1_10011.count = var_22_5
		var_22_10.drop = var_1_10011

		function var_22_10.onYes()
			pg = var_2_10000

			local var_23_0 = var_2_10000.m02
			local var_23_1 = var_0.sendNotification

			GAME = var_2_10003

			var_23_1(var_23_0, var_2_10003.SHOPPING, {
				isQuickShopping = true,
				count = 1,
				id = var_0
			})

			pg = var_23_1

			local var_23_2 = var_23_1.TrackerMgr.GetInstance()
			local var_23_3 = var_0.Tracking

			TRACKING_PAY_OIL = var_3

			var_23_3(var_23_2, var_3)

			return
		end

		var_22_9(var_22_8, var_22_10)
	else
		pg = var_22_9

		local var_22_11 = var_22_9.MsgboxMgr.GetInstance()
		local var_22_12 = var_7.ShowMsgBox
		local var_22_13 = {}

		MSGBOX_TYPE_HELP = var_1_10011
		var_22_13.type = var_1_10011
		i18n = var_1_10011
		var_22_13.helps = var_1_10011("help_oil_buy_limit")

		local var_22_14 = {}
		local var_22_15 = {
			text = "text_iknow"
		}

		SFX_CANCEL = var_13
		var_22_15.sound = var_13
		var_22_14[1] = var_22_15
		var_22_13.custom = var_22_14

		var_22_12(var_22_11, var_22_13)
	end

	return
end

function var_0_1.Flush(arg_24_0)
	local var_24_0 = arg_24_0:GetPlayer()

	var_0_1.StaticFlush(var_24_0, arg_24_0.goldMax, arg_24_0.goldValue, arg_24_0.oilMax, arg_24_0.oilValue, arg_24_0.gemValue)
	arg_24_0:SetDirty(false)

	return
end

function var_0_1.StaticFlush(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
	local var_25_0 = arg_25_0:getLevelMaxGold()
	local var_25_1 = arg_25_0:getLevelMaxOil()

	arg_25_1.text = "MAX: " .. var_25_0
	arg_25_2.text = arg_25_0.gold
	arg_25_3.text = "MAX: " .. var_25_1
	arg_25_4.text = arg_25_0.oil
	arg_25_5.text = arg_25_0:getTotalGem()

	return
end

function var_0_1.Dispose(arg_26_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_26_0)
	arg_26_0:Disable()

	pg = var_1

	local var_26_0 = var_1.m02

	var_1.removeMediator(var_26_0, arg_26_0.__cname)

	PoolMgr = var_1

	local var_26_1 = var_1.GetInstance()

	var_1.ReturnUI(var_26_1, "ResPanel", arg_26_0._go)

	arg_26_0.state = var_0_2

	return
end

function var_0_1.SetDirty(arg_27_0, arg_27_1)
	arg_27_0.dirty = arg_27_1

	return
end

function var_0_1.IsDirty(arg_28_0)
	return arg_28_0.dirty
end

function var_0_1.Fold(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_0:IsLoaded() then
		return
	end

	local var_29_0 = arg_29_0.foldableHelper

	var_3.Fold(var_29_0, arg_29_1, arg_29_2)

	return
end

function var_0_1.listNotificationInterests(arg_30_0)
	local var_30_0 = {}

	PlayerProxy = var_1_10002
	var_30_0[1] = var_1_10002.UPDATED
	GAME = var_2
	var_30_0[2] = var_2.GUILD_GET_USER_INFO_DONE
	GAME = var_2
	var_30_0[3] = var_2.GET_PUBLIC_GUILD_USER_DATA_DONE
	PlayerResUI = var_2
	var_30_0[4] = var_2.CHANGE_TOUCH_ABLE
	var_30_0[5] = var_0_1.HIDE
	var_30_0[6] = var_0_1.SHOW

	return var_30_0
end

function var_0_1.handleNotification(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1
	local var_31_1 = arg_31_1.getName(var_31_0)

	PlayerResUI = var_1_10003

	if var_31_1 == var_1_10003.CHANGE_TOUCH_ABLE then
		local var_31_2 = arg_31_1:getBody()

		GetComponent = var_31_0
		tf = var_1_10006

		local var_31_3 = var_1_10006(arg_31_0._go)

		typeof = var_1_10007
		CanvasGroup = var_1_10009

		local var_31_4 = var_31_0(var_31_3, var_1_10007(var_1_10009))

		var_31_4.interactable = var_31_2
		var_31_4.blocksRaycasts = var_31_2

		return
	end

	arg_31_0:updateResPanel(var_31_1)

	return
end

function var_0_1.updateResPanel(arg_32_0, arg_32_1)
	if not arg_32_0:IsEnable() then
		arg_32_0:SetDirty(true)

		return
	end

	PlayerProxy = var_2

	if arg_32_1 ~= var_2.UPDATED then
		GAME = var_2

		if arg_32_1 ~= var_2.GUILD_GET_USER_INFO_DONE then
			GAME = var_2

			if arg_32_1 == var_2.GET_PUBLIC_GUILD_USER_DATA_DONE then
				arg_32_0:Flush()
			end

			return
		end
	end
end

function var_0_1.checkBackPressed(arg_33_0)
	pg = var_1_10001

	if var_1_10001.goldExchangeMgr then
		pg = var_1

		local var_33_0 = var_1.goldExchangeMgr

		var_1.exit(var_33_0)

		pg = var_1
		var_1.goldExchangeMgr = nil

		return true
	else
		return false
	end

	return
end

return var_0_1

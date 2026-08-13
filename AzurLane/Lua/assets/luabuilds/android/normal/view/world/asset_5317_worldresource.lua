class = var_0_10000

local var_0_0 = "WorldResource"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.Listeners = {
	onUpdateInventory = "OnUpdateInventory",
	onUpdateActivate = "OnUpdateActivate",
	onUpdateStamina = "OnUpdateStamina",
	onBossProgressUpdate = "OnBossProgressUpdate"
}

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	PoolMgr = var_1

	local var_1_0 = var_1.GetInstance()

	var_1.GetUI(var_1_0, "WorldResPanel", false, function(arg_2_0)
		pg = var_2_10001

		local var_2_0 = var_2_10001.UIMgr.GetInstance().UIMain
		local var_2_1 = arg_2_0.transform

		var_2.SetParent(var_2_1, var_2_0.transform, false)

		local var_2_2 = arg_1_0

		var_2.onUILoaded(var_2_2, arg_2_0)

		return
	end)

	return
end

function var_0_1.init(arg_3_0)
	pairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(var_0_1.Listeners) do
		arg_3_0[iter_3_0] = function(...)
			var_0_1[iter_3_1](arg_3_0, ...)

			return
		end
	end

	nowWorld = var_1

	local var_3_0 = var_1()
	local var_3_1 = arg_3_0._tf

	arg_3_0.stamina = var_2.Find(var_3_1, "res/stamina")
	onButton = var_2

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.stamina

	local function var_3_4()
		local var_5_0 = var_3_0.staminaMgr

		var_0.Show(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_3_2, var_3_3, var_3_4, var_1_10006)

	local var_3_5 = arg_3_0._tf

	arg_3_0.oil = var_2.Find(var_3_5, "res/oil")
	onButton = var_2

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.oil

	local function var_3_8()
		ShoppingStreet = var_2_10000

		local var_6_0 = var_2_10000.getRiseShopId

		ShopArgs = var_2_10001

		local var_6_2

		if not var_6_0(var_2_10001.BuyOil, arg_3_0.player.buyOilCount) then
			pg = var_6_2

			local var_6_1 = var_6_2.TipsMgr.GetInstance()

			var_6_2 = var_6_2.ShowTips
			i18n = var_2_10003

			var_6_2(var_6_1, var_2_10003("common_today_buy_limit"))

			return
		end

		pg = var_6_2

		local var_6_3 = var_6_2.shop_template[var_0].num
		local var_6_4

		if var_1.num == -1 then
			var_6_4 = var_1.genre
			ShopArgs = var_2_10004

			if var_6_4 == var_2_10004.BuyOil then
				ShopArgs = var_6_4
				var_6_3 = var_6_4.getOilByLevel(arg_3_0.player.level)
			end
		end

		pg = var_6_4

		local var_6_5 = var_6_4.gameset.buy_oil_limit.key_value
		local var_6_7

		if arg_3_0.player.buyOilCount < var_6_5 then
			pg = var_6_7

			local var_6_6 = var_6_7.MsgboxMgr.GetInstance()

			var_6_7 = var_6_7.ShowMsgBox

			local var_6_8 = {}

			MSGBOX_TYPE_SINGLE_ITEM = var_2_10007
			var_6_8.type = var_2_10007
			i18n = var_2_10007
			var_6_8.content = var_2_10007("oil_buy_tip", var_1.resource_num, var_6_3, arg_3_0.player.buyOilCount)
			var_2_10007 = {
				id = 2
			}
			DROP_TYPE_RESOURCE = var_8
			var_2_10007.type = var_8
			var_2_10007.count = var_6_3
			var_6_8.drop = var_2_10007

			function var_6_8.onYes()
				pg = var_3_10000

				local var_7_0 = var_3_10000.m02
				local var_7_1 = var_0.sendNotification

				GAME = var_3_10002

				var_7_1(var_7_0, var_3_10002.SHOPPING, {
					isQuickShopping = true,
					count = 1,
					id = var_0
				})

				return
			end

			var_6_7(var_6_6, var_6_8)
		else
			pg = var_6_7

			local var_6_9 = var_6_7.MsgboxMgr.GetInstance()
			local var_6_10 = var_4.ShowMsgBox
			local var_6_11 = {}

			MSGBOX_TYPE_HELP = var_2_10007
			var_6_11.type = var_2_10007
			i18n = var_2_10007
			var_6_11.helps = var_2_10007("help_oil_buy_limit")

			local var_6_12 = {}
			local var_6_13 = {
				text = "text_iknow"
			}

			SFX_CANCEL = var_2_10009
			var_6_13.sound = var_2_10009
			var_6_12[1] = var_6_13
			var_6_11.custom = var_6_12

			var_6_10(var_6_9, var_6_11)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_3_6, var_3_7, var_3_8, var_1_10006)

	local var_3_9 = arg_3_0._tf

	arg_3_0.Whuobi = var_2.Find(var_3_9, "res/Whuobi")
	onButton = var_2

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0.Whuobi

	local function var_3_12()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		MSGBOX_TYPE_SINGLE_ITEM = var_2_10003
		var_8_2.type = var_2_10003
		Drop = var_2_10003

		local var_8_3 = var_2_10003.New
		local var_8_4 = {}

		DROP_TYPE_WORLD_ITEM = var_2_10005
		var_8_4.type = var_2_10005
		WorldItem = var_2_10005
		var_8_4.id = var_2_10005.MoneyId
		var_8_2.drop = var_8_3(var_8_4)

		var_8_1(var_8_0, var_8_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_3_10, var_3_11, var_3_12, var_1_10006)

	local var_3_13 = arg_3_0._tf

	arg_3_0.bossProgress = var_2.Find(var_3_13, "res/boss_progress")
	onButton = var_2

	local var_3_14 = arg_3_0
	local var_3_15 = arg_3_0.bossProgress

	local function var_3_16()
		WorldBossConst = var_2_10000

		local var_9_0 = var_2_10000.GetCurrBossItemInfo()

		WorldBossConst = var_2_10001

		local var_9_1 = var_2_10001.CanUnlockCurrBoss()

		pg = var_2_10002

		local var_9_2 = var_2_10002.MsgboxMgr.GetInstance()
		local var_9_3 = var_2.ShowMsgBox
		local var_9_4 = {
			hideNo = true
		}

		MSGBOX_TYPE_DROP_ITEM = var_2_10005
		var_9_4.type = var_2_10005
		var_9_4.name = var_9_0.name
		var_9_4.content = var_9_0.display
		var_9_4.iconPath = var_9_0.icon
		var_9_4.frame = var_9_0.rarity
		i18n = var_5
		var_9_4.yesText = var_5("common_go_to_analyze")
		var_9_4.yesGray = not var_9_1

		function var_9_4.onYes()
			local var_10_3

			if var_9_1 then
				local var_10_0 = var_3_0
				local var_10_1 = var_10_3.GetBossProxy(var_10_0)

				if var_10_3.IsOpen(var_10_1) then
					pg = var_10_3

					local var_10_2 = var_10_3.m02

					var_10_3 = var_10_3.sendNotification
					GAME = var_3_10002
					var_3_10002 = var_3_10002.GO_SCENE
					SCENE = var_3_10003

					var_10_3(var_10_2, var_3_10002, var_3_10003.WORLDBOSS)

					goto label_10_0
				end
			end

			pg = var_10_3

			do
				local var_10_4 = var_10_3.TipsMgr.GetInstance()
				local var_10_5 = var_0.ShowTips

				i18n = var_3_10002

				var_10_5(var_10_4, var_3_10002("world_boss_progress_no_enough"))

				pg = var_10_5

				local var_10_6 = var_10_5.MsgboxMgr.GetInstance()

				var_0.hide(var_10_6)
			end

			::label_10_0::

			return
		end

		var_9_3(var_9_2, var_9_4)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_3_14, var_3_15, var_3_16, var_1_10006)

	if var_3_0:GetActiveMap() then
		arg_3_0:setStaminaMgr(var_3_0.staminaMgr)
	else
		arg_3_0.atlas = var_3_0:GetAtlas()

		local var_3_17 = arg_3_0.atlas
		local var_3_18 = var_2.AddListener

		WorldAtlas = var_3_15

		var_3_18(var_3_17, var_3_15.EventUpdateActiveMap, arg_3_0.onUpdateActivate)

		setActive = var_3_18

		var_3_18(arg_3_0.stamina, false)
	end

	arg_3_0:setWorldInventory(var_3_0:GetInventoryProxy())
	arg_3_0:SetWorldBossRes(var_3_0:GetBossProxy())

	return
end

function var_0_1.setParent(arg_11_0, arg_11_1, arg_11_2)
	setParent = var_1_10003

	var_1_10003(arg_11_0._go, arg_11_1, arg_11_2)

	return
end

function var_0_1.setPlayer(arg_12_0, arg_12_1)
	assert = var_1_10002
	isa = var_1_10003

	local var_12_0 = arg_12_1

	Player = var_1_10005

	var_1_10002(var_1_10003(var_12_0, var_1_10005), "should be an instance of Player")

	arg_12_0.player = arg_12_1
	setText = var_1_10002

	local var_12_1 = arg_12_0.oil
	local var_12_2 = var_3.Find(var_12_1, "max_value")
	local var_12_3 = "MAX:"

	pg = var_5

	var_1_10002(var_12_2, var_12_3 .. var_5.user_level[arg_12_1.level].max_oil)

	setText = var_1_10002

	local var_12_4 = arg_12_0.oil

	var_1_10002(var_3.Find(var_12_4, "value"), arg_12_1.oil)

	return
end

function var_0_1.OnUpdateActivate(arg_13_0)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.setStaminaMgr

	nowWorld = var_1_10003

	var_13_1(var_13_0, var_1_10003().staminaMgr)

	local var_13_2 = arg_13_0.atlas
	local var_13_3 = var_1.RemoveListener

	WorldAtlas = var_3

	var_13_3(var_13_2, var_3.EventUpdateActiveMap, arg_13_0.onUpdateActivate)

	return
end

function var_0_1.setStaminaMgr(arg_14_0, arg_14_1)
	arg_14_0.staminaMgr = arg_14_1
	setText = var_1_10002

	local var_14_0 = arg_14_0.stamina

	var_1_10002(var_3.Find(var_14_0, "max_value"), "MAX:" .. arg_14_1:GetMaxStamina())

	local var_14_1 = arg_14_0.staminaMgr
	local var_14_2 = var_2.AddListener

	WorldStaminaManager = var_4

	var_14_2(var_14_1, var_4.EventUpdateStamina, arg_14_0.onUpdateStamina)
	arg_14_0:OnUpdateStamina()

	setActive = var_2

	var_2(arg_14_0.stamina, true)

	return
end

function var_0_1.setWorldInventory(arg_15_0, arg_15_1)
	arg_15_0.inventoryProxy = arg_15_1

	local var_15_0 = arg_15_0.inventoryProxy
	local var_15_1 = var_2.AddListener

	WorldInventoryProxy = var_1_10004

	var_15_1(var_15_0, var_1_10004.EventUpdateItem, arg_15_0.onUpdateInventory)
	arg_15_0:OnUpdateInventory()

	return
end

function var_0_1.OnUpdateStamina(arg_16_0)
	setText = var_1_10001

	local var_16_0 = arg_16_0.stamina
	local var_16_1 = var_2.Find(var_16_0, "value")
	local var_16_2 = arg_16_0.staminaMgr

	var_1_10001(var_16_1, var_3.GetDisplayStanima(var_16_2))

	return
end

function var_0_1.OnUpdateInventory(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_1 then
		WorldInventoryProxy = var_1_10004

		if arg_17_1 == var_1_10004.EventUpdateItem then
			var_1_10004 = arg_17_3.id
			WorldItem = var_1_10005

			if var_1_10004 == var_1_10005.MoneyId then
				setText = var_1_10004

				local var_17_0 = arg_17_0.Whuobi
				local var_17_1 = var_5.Find(var_17_0, "value")
				local var_17_2 = arg_17_0.inventoryProxy
				local var_17_3 = var_6.GetItemCount

				WorldItem = var_1_10008

				var_1_10004(var_17_1, var_17_3(var_17_2, var_1_10008.MoneyId))
			end
		end

		return
	end
end

function var_0_1.SetWorldBossRes(arg_18_0, arg_18_1)
	arg_18_0.worldBossProxy = arg_18_1

	local var_18_0 = arg_18_0.worldBossProxy
	local var_18_1 = var_2.AddListener

	WorldBossProxy = var_1_10004

	var_18_1(var_18_0, var_1_10004.EventUnlockProgressUpdated, arg_18_0.onBossProgressUpdate)
	arg_18_0:OnBossProgressUpdate()

	return
end

function var_0_1.OnBossProgressUpdate(arg_19_0)
	WorldBossConst = var_1_10001

	local var_19_0 = var_1_10001.GetCurrBossItemProgress()

	WorldBossConst = var_1_10002

	local var_19_1, var_19_2, var_19_3 = var_1_10002.GetCurrBossItemCapacity()

	WorldBossConst = var_1_10005

	local var_19_4, var_19_5 = var_1_10005.GetCurrBossConsume()
	local var_19_6 = arg_19_0.bossProgress
	local var_19_7 = var_7.Find(var_19_6, "value")
	local var_19_8 = arg_19_0.bossProgress
	local var_19_9 = var_8.Find(var_19_8, "max_value")

	if var_19_3 <= var_19_2 then
		COLOR_GREY = var_19_8

		if not var_19_8 then
			COLOR_WHITE = var_19_8
		end

		setText = var_10

		var_10(var_19_7, "<color=" .. var_19_8 .. ">" .. var_19_0 .. "/" .. var_19_5 .. "</color>")

		setText = var_10

		var_10(var_19_9, "<color=" .. var_19_8 .. ">DAILY:" .. var_19_2 .. "/" .. var_19_3 .. "</color>")

		setActive = var_10

		local var_19_10 = arg_19_0.bossProgress

		nowWorld = var_12

		local var_19_11 = var_12()
		local var_19_12 = var_12.IsSystemOpen

		WorldConst = var_14

		var_10(var_19_10, var_19_12(var_19_11, var_14.SystemWorldBoss))

		return
	end
end

function var_0_1.willExit(arg_20_0)
	if arg_20_0.staminaMgr then
		local var_20_0 = arg_20_0.staminaMgr
		local var_20_1 = var_1.RemoveListener

		WorldStaminaManager = var_1_10003

		var_20_1(var_20_0, var_1_10003.EventUpdateStamina, arg_20_0.onUpdateStamina)
	else
		local var_20_2 = arg_20_0.atlas
		local var_20_3 = var_1.RemoveListener

		WorldAtlas = var_1_10003

		var_20_3(var_20_2, var_1_10003.EventUpdateActiveMap, arg_20_0.onUpdateActivate)
	end

	local var_20_4 = arg_20_0.inventoryProxy
	local var_20_5 = var_1.RemoveListener

	WorldInventoryProxy = var_1_10003

	var_20_5(var_20_4, var_1_10003.EventUpdateItem, arg_20_0.onUpdateInventory)

	local var_20_6 = arg_20_0.worldBossProxy
	local var_20_7 = var_1.RemoveListener

	WorldBossProxy = var_3

	var_20_7(var_20_6, var_3.EventUnlockProgressUpdated, arg_20_0.onBossProgressUpdate)

	PoolMgr = var_20_7

	local var_20_8 = var_20_7.GetInstance()

	var_1.ReturnUI(var_20_8, "WorldResPanel", arg_20_0._go)

	return
end

return var_0_1

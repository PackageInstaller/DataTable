local var_0_0 = class("FragmentShopPage", import(".ShamShopPage"))

function var_0_0.GetPaintingCommodityUpdateVoice(arg_1_0)
	return
end

function var_0_0.CanOpen(arg_2_0, arg_2_1, arg_2_2)
	return pg.SystemOpenMgr.GetInstance():isOpenSystem(arg_2_2.level, "FragmentShop")
end

function var_0_0.init(arg_3_0)
	var_0_0.super.init(arg_3_0)

	return
end

function var_0_0.CustomInit(arg_4_0)
	onButton(arg_4_0, arg_4_0.resolveBtn, function()
		if not arg_4_0.resolvePanel then
			arg_4_0.resolvePanel = FragResolvePanel.New(arg_4_0)
			arg_4_0.resolvePanel.event = arg_4_0.event

			arg_4_0.resolvePanel:Load()
		end

		arg_4_0.resolvePanel.buffer:Reset()
		arg_4_0.resolvePanel.buffer:Trigger("control")

		return
	end, SFX_PANEL)
	getProxy(CommanderManualProxy):TaskProgressAdd(2023, 1)

	return
end

function var_0_0.OnUpdatePlayer(arg_6_0)
	arg_6_0:RefreshResItemList()

	return
end

function var_0_0.OnFragmentSellUpdate(arg_7_0)
	if arg_7_0.resolvePanel then
		arg_7_0.resolvePanel.buffer:Reset()
		arg_7_0.resolvePanel.buffer:Trigger("control")
	end

	return
end

function var_0_0.OnUpdateItems(arg_8_0)
	arg_8_0:RefreshResItemList()

	return
end

function var_0_0.GetResDataList(arg_9_0)
	local var_9_0 = {
		{
			type = DROP_TYPE_RESOURCE,
			resID = PlayerConst.ResBlueprintFragment,
			cnt = arg_9_0.player:getResource(PlayerConst.ResBlueprintFragment)
		}
	}

	if not LOCK_UR_SHIP and arg_9_0.items then
		local var_9_1 = arg_9_0.items[pg.gameset.urpt_chapter_max.description[1]] or {
			count = 0
		}

		table.insert(var_9_0, {
			type = DROP_TYPE_ITEM,
			resID = pg.gameset.urpt_chapter_max.description[1],
			cnt = var_9_1.count
		})
	end

	return var_9_0
end

function var_0_0.OnUpdateCommodity(arg_10_0, arg_10_1)
	local var_10_0

	for iter_10_0, iter_10_1 in pairs(arg_10_0.cards) do
		if iter_10_1.goodsVO.id == arg_10_1.id then
			var_10_0 = iter_10_1

			break
		end
	end

	if var_10_0 then
		var_10_0.goodsVO = arg_10_1

		ActivityGoodsCard.StaticUpdate(var_10_0.tf, arg_10_1, var_0_0.TYPE_FRAGMENT)
	end

	return
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0:UpdateTip()
	setActive(arg_11_0.tipTextGo, true)
	setActive(arg_11_0.helpBtn, false)
	setActive(arg_11_0.resolveBtn, true)
	setActive(arg_11_0.refreshBtn, false)

	return
end

function var_0_0.OnInitItem(arg_12_0, arg_12_1)
	local var_12_0 = ActivityGoodsCard.New(arg_12_1)

	onButton(arg_12_0, var_12_0.tf, function()
		if not var_12_0.goodsVO:canPurchase() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

			return
		end

		arg_12_0:OnClickCommodity(var_12_0.goodsVO, function(arg_14_0, arg_14_1)
			arg_12_0:OnPurchase(arg_14_0, arg_14_1)

			return
		end)

		return
	end, SFX_PANEL)

	arg_12_0.cards[arg_12_1] = var_12_0

	return
end

function var_0_0.OnUpdateItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.cards[arg_15_2]

	if not arg_15_0.cards[arg_15_2] then
		arg_15_0:OnInitItem(arg_15_2)

		var_15_0 = arg_15_0.cards[arg_15_2]
	end

	local var_15_1 = arg_15_0.displays[arg_15_1 + 1]

	var_15_0.goodsVO = arg_15_0.displays[arg_15_1 + 1]

	ActivityGoodsCard.StaticUpdate(var_15_0.tf, var_15_1, var_0_0.TYPE_FRAGMENT)

	return
end

function var_0_0.OnPurchase(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:emit(NewShopMainMediator.ON_FRAGMENT_SHOPPING, arg_16_1.id, arg_16_2)

	return
end

function var_0_0.OnDestroy(arg_17_0)
	var_0_0.super.OnDestroy(arg_17_0)

	if arg_17_0.resolvePanel then
		arg_17_0.resolvePanel:Destroy()

		arg_17_0.resolvePanel = nil
	end

	return
end

return var_0_0

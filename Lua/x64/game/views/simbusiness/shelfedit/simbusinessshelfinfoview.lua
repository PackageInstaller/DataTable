local var_0_0 = class("SimBusinessShelfInfoView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.itemScroll = LuaList.New(handler(arg_2_0, arg_2_0.indexItem), arg_2_0.uilistGo_, SimBusinessShowItem)
	arg_2_0.sellItemScroll = LuaList.New(handler(arg_2_0, arg_2_0.indexSellItem), arg_2_0.uilistSellGo_, SimBusinessSellGoodSmallItem)
	arg_2_0.showItem = SimBusinessShowItem.New(arg_2_0.showItemGo, SimBusinessConst.ShowItmeType.shelf)
	arg_2_0.btnController = arg_2_0.controllerCom:GetController("state")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:RefreshShelfList()

	arg_4_0.id = arg_4_0.itemList[1]

	arg_4_0.itemScroll:StartScroll(#arg_4_0.itemList)
	arg_4_0:RefreshInfoView()
end

function var_0_0.OnTop(arg_5_0)
	return
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.levelUp, nil, function()
		SimBusinessAction.UpgradeShelf(arg_6_0.id, 1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.resetBtn_, nil, function()
		local var_8_0 = 1 - SimBusinessData:GetShelfLevel(arg_6_0.id)

		SimBusinessAction.UpgradeShelf(arg_6_0.id, var_8_0)
	end)
end

function var_0_0.RefreshShelfList(arg_9_0)
	arg_9_0.itemList = SimBusinessShelfCfg.all
end

function var_0_0.RefreshInfoView(arg_10_0)
	if arg_10_0.id then
		arg_10_0.cfg = SimBusinessShelfCfg[arg_10_0.id]

		if arg_10_0.cfg then
			arg_10_0.placeText.text = arg_10_0.cfg.area[1] .. "x" .. arg_10_0.cfg.area[2]
			arg_10_0.orientation.text = GetTips(SimBusinessConst.OrientationType[arg_10_0.cfg.sell_direction])
			arg_10_0.valueText_.text = arg_10_0.cfg.cost
			arg_10_0.name.text = arg_10_0.cfg.name
			arg_10_0.levelNum.text = SimBusinessTools.GetShelfLevelText(arg_10_0.id, true)
			arg_10_0.ability.text = SimBusinessTools.GetSellUpgradeText(arg_10_0.id)

			arg_10_0:RefreshSellList()
			arg_10_0:RefreshBtnState()
			arg_10_0.showItem:RefreshView(arg_10_0.id, SimBusinessConst.ShowItmeType.shelf)
		end
	end
end

function var_0_0.OnEventRefreshView(arg_11_0)
	arg_11_0:RefreshInfoView()
end

function var_0_0.RefreshSellList(arg_12_0)
	arg_12_0.sellItemList = arg_12_0.cfg.sell_type

	arg_12_0.sellItemScroll:StartScroll(#arg_12_0.sellItemList)
end

function var_0_0.indexItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:RefreshView(arg_13_0.itemList[arg_13_1], SimBusinessConst.ShowItmeType.shelf, arg_13_0.id, true, true)
	arg_13_2:RegisterClickItemFunc(handler(arg_13_0, arg_13_0.ClickItem))
end

function var_0_0.ClickItem(arg_14_0, arg_14_1)
	arg_14_0.id = arg_14_1

	arg_14_0.itemScroll:Refresh()
	arg_14_0:RefreshInfoView()
end

function var_0_0.indexSellItem(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2:RefreshView(arg_15_0.sellItemList[arg_15_1], SimBusinessConst.ShowItmeType.good)
end

function var_0_0.RefreshBtnState(arg_16_0)
	local var_16_0, var_16_1 = SimBusinessTools.GetShelfUnlocked(arg_16_0.id)

	if not var_16_0 then
		SetActive(arg_16_0.resetBtn_.gameObject, false)
		arg_16_0.btnController:SetSelectedState("lock")

		if var_16_1 then
			arg_16_0.lockText.text = GetTipsF("SIM_BUSINESS_GOODS_UNLOCK_LEVEL_LIMIT", var_16_1)
		end

		return
	end

	arg_16_0.shelfLevel = SimBusinessData:GetShelfLevel(arg_16_0.id)

	SetActive(arg_16_0.resetBtn_.gameObject, arg_16_0.shelfLevel > 1)
	arg_16_0.btnController:SetSelectedState("up")

	arg_16_0.textcostText_.text = SimBusinessTools.GetShelfUpgradeCostFund(arg_16_0.id)

	local var_16_2 = SimBusinessData:GetSimBusinessFundItemID()

	arg_16_0.iconImg_.sprite = ItemTools.getItemSprite(var_16_2)

	local var_16_3, var_16_4 = SimBusinessTools.GetShelfCanLevelUp(arg_16_0.id)

	if var_16_3 then
		arg_16_0.btnController:SetSelectedState("up")
	elseif var_16_4 == SimBusinessTools.State.MAX_LEVEL then
		arg_16_0.btnController:SetSelectedState("max")
	else
		arg_16_0.btnController:SetSelectedState("deficient")
	end
end

function var_0_0.OnExit(arg_17_0)
	return
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.showItem:Dispose()
	arg_18_0.itemScroll:Dispose()
	arg_18_0.sellItemScroll:Dispose()
	var_0_0.super.Dispose(arg_18_0)
end

function var_0_0.RegisterEvents(arg_19_0)
	return
end

return var_0_0

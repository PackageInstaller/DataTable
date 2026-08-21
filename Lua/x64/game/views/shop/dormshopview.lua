local var_0_0 = class("ShopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Shop/BHShopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

local function var_0_1(arg_3_0)
	return nullable(ShopListCfg, arg_3_0, "display_group")
end

local function var_0_2(arg_4_0)
	return nullable(ShopListCfg.get_id_list_by_system_and_group, 1, arg_4_0, 1, "group_name")
end

function var_0_0.OnCtor(arg_5_0)
	arg_5_0.curShop = nil
	arg_5_0.contentViewDic = {}
end

local function var_0_3(...)
	print("group", ...)
end

local function var_0_4(...)
	print("item", ...)
end

function var_0_0.Init(arg_8_0)
	arg_8_0:BindCfgUI()

	arg_8_0.tree = LuaTree.New(arg_8_0.treeGo_)

	arg_8_0.tree:OverrideRenderer(nil, handler(arg_8_0, arg_8_0.ShopItemRenderer))
	arg_8_0.tree:SetSelectedHandler(handler(arg_8_0, arg_8_0.OnShopGroupSelect), handler(arg_8_0, arg_8_0.OnShopItemSelect))

	arg_8_0.displayModeController = arg_8_0.controllerExCollection_:GetController("displayMode")
end

local function var_0_5(arg_9_0, arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_0) do
		local var_9_1 = arg_9_1(iter_9_1)
		local var_9_2 = var_9_0[var_9_1]

		if var_9_2 == nil then
			var_9_2 = {}
			var_9_0[var_9_1] = var_9_2
		end

		table.insert(var_9_2, iter_9_1)
	end

	return var_9_0
end

local function var_0_6(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0) do
		table.insert(var_10_0, iter_10_0)
	end

	table.sort(var_10_0, arg_10_1)

	return function(arg_11_0, arg_11_1)
		if arg_11_1 < arg_11_0 then
			arg_11_1 = arg_11_1 + 1

			local var_11_0 = var_10_0[arg_11_1]

			return arg_11_1, {
				key = var_11_0,
				value = arg_10_0[var_11_0]
			}
		end
	end, #var_10_0, 0
end

function var_0_0.UpdateShopCatagoryTreeData(arg_12_0, arg_12_1)
	if next(arg_12_1) == nil then
		return
	end

	arg_12_0.catagoryInfo = arg_12_1
	arg_12_0.shopComList = {}

	local var_12_0 = UITreeData.New()

	for iter_12_0, iter_12_1 in var_0_6(arg_12_1, arg_12_0.params_.groupSortingFunc) do
		local var_12_1 = iter_12_1.key
		local var_12_2 = iter_12_1.value

		table.sort(var_12_2, arg_12_0.params_.shopInGroupSortFunc)

		local var_12_3 = UITreeGroupData.New()

		for iter_12_2, iter_12_3 in ipairs(var_12_2) do
			local var_12_4 = UITreeItemData.New()
			local var_12_5 = ShopListCfg[iter_12_3]

			var_12_4.id = var_12_5.id
			var_12_4.text = GetI18NText(var_12_5.remark)

			var_12_3.itemDatas:Add(var_12_4)
		end

		local var_12_6 = (arg_12_0.params_.groupNameMappingFunc or var_0_2)(var_12_1)

		var_12_3.text = GetI18NText(var_12_6)
		var_12_3.id = var_12_1

		var_12_0.groupDatas:Add(var_12_3)
	end

	arg_12_0.tree:SetData(var_12_0)
	arg_12_0:ClearAllRegisteredRedPoints()
	arg_12_0:RegisterRedPoints()
end

function var_0_0.SetData(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.params_.shop or arg_13_1[1]
	local var_13_1 = var_0_5(arg_13_1, arg_13_0.params_.groupingFunc or var_0_1)

	arg_13_0.displayModeController:SetSelectedState(#arg_13_1 > 1 and "multiple" or "single")
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_0.middleTrs_)
	arg_13_0:UpdateShopCatagoryTreeData(var_13_1)

	local var_13_2, var_13_3 = arg_13_0:SelectTreeByShopId(var_13_0)
	local var_13_4 = arg_13_0.treeGo_:GetComponent("ScrollRect")

	arg_13_0.tree:ClampItemInRect(var_13_2, var_13_3, var_13_4.viewport, var_13_4.content)
end

local var_0_7
local var_0_8 = 8

local function var_0_9(arg_14_0)
	if var_0_7 == nil then
		var_0_7 = {
			[50] = {
				CLASS = ShopCanteenMaterialContentView
			}
		}
	end

	local var_14_0 = import("game.views.shop.contentViews.ShopFurnitureContentView")
	local var_14_1 = var_0_7[arg_14_0]

	if var_14_1 then
		return var_14_1.CLASS
	else
		local var_14_2 = ShopListCfg[arg_14_0]

		if var_14_2.display_group == var_0_8 then
			return var_14_0
		end

		if var_14_2.system == "2" then
			return ShopExchangeContentView
		else
			return ShopContentView
		end
	end
end

function var_0_0.GetContentViewByShopId(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == nil then
		return nil
	end

	local var_15_0 = var_0_9(arg_15_1)

	if arg_15_0.curShop then
		local var_15_1 = var_0_9(arg_15_0.curShop)

		if var_15_1 ~= var_15_0 then
			SetActive(arg_15_0.contentViewDic[var_15_1.__cname].gameObject_, false)
		end
	end

	local var_15_2 = var_15_0.__cname
	local var_15_3 = arg_15_0.contentViewDic[var_15_2]

	if not var_15_3 then
		var_15_3 = var_15_0.New(arg_15_0.contentContainer_)
		arg_15_0.contentViewDic[var_15_2] = var_15_3
	elseif not arg_15_2 then
		SetActive(var_15_3.gameObject_, true)
	end

	var_15_3:SetShopHideHome(arg_15_0.params_.hideHomeBtn)

	if not arg_15_2 then
		var_15_3:SetShopId(arg_15_1)
	end

	return var_15_3
end

function var_0_0.GetCurContentView(arg_16_0)
	return arg_16_0:GetContentViewByShopId(arg_16_0.curShop)
end

function var_0_0.RefreshShopGoodInfo(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0.curShop ~= arg_17_1 then
		return
	end

	arg_17_0:GetContentViewByShopId(arg_17_1):RefreshShopGoodInfo(arg_17_2)
end

function var_0_0.RefreshList(arg_18_0, arg_18_1)
	arg_18_0:GetCurContentView():RefreshList(arg_18_1)
end

function var_0_0.UpdateShopList(arg_19_0, arg_19_1, arg_19_2)
	arg_19_2 = arg_19_2 or arg_19_0.curShop == arg_19_1
	arg_19_0.curShop = arg_19_1
	arg_19_0.params_.shop = arg_19_1

	arg_19_0:RefreshList(arg_19_2)
end

function var_0_0.UpdateBarByShopId(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:GetContentViewByShopId(arg_20_1)

	if var_20_0 then
		var_20_0:UpdateBarByShopId()
	end

	manager.windowBar:RegistHomeCallBack(function()
		gameContext:Go("/home", nil, nil, true)
	end)
	manager.windowBar:RegistBackCallBack(function()
		arg_20_0.params_.scrollPosition = nil

		JumpTools.Back()
	end)
end

function var_0_0.OnTop(arg_23_0)
	if arg_23_0.params_.shop ~= arg_23_0.curShop then
		arg_23_0.curShop = arg_23_0.params_.shop
	end

	if arg_23_0.curShop then
		arg_23_0:UpdateShopList(arg_23_0.curShop, true)
		arg_23_0:UpdateBarByShopId(arg_23_0.curShop)
	end
end

function var_0_0.OnEnter(arg_24_0)
	arg_24_0.params_.shopList = arg_24_0.params_.shopList or DormTools:GetAllDormShopIDList()

	if arg_24_0.params_.hideHomeBtn == nil then
		arg_24_0.params_.hideHomeBtn = true
	end

	arg_24_0:EnterShopPage()
	arg_24_0:SetData(arg_24_0.params_.shopList)
	arg_24_0:UpdateTimer()
end

function var_0_0.UpdateTimer(arg_25_0)
	local function var_25_0()
		for iter_26_0, iter_26_1 in pairs(arg_25_0.catagoryInfo or {}) do
			local var_26_0 = arg_25_0.tree:GetGroupRedPointContainerById(iter_26_0).transform.parent.transform:Find("new")
			local var_26_1 = false

			for iter_26_2, iter_26_3 in pairs(iter_26_1) do
				if ShopTools.IsShopDiscount(iter_26_3) then
					var_26_1 = true

					break
				end
			end

			SetActive(var_26_0, var_26_1)
		end

		SetActive(arg_25_0.timeGo_, ShopTools.IsShopDiscount(arg_25_0.curShop))

		if ShopTools.IsShopDiscount(arg_25_0.curShop) then
			arg_25_0.refreshTxt_.text = string.format(GetTips("TIME_DISPLAY_16"), manager.time:GetLostTimeStrWith2Unit(TimeMgr.GetInstance():parseTimeFromConfig(ShopListCfg[arg_25_0.curShop].cheap_close_time)))
		end
	end

	var_25_0()

	arg_25_0.updateTimer_ = Timer.New(function()
		var_25_0()
	end, 1, -1, 1)

	arg_25_0.updateTimer_:Start()
end

function var_0_0.OnExit(arg_28_0)
	arg_28_0:ClearAllRegisteredRedPoints()
	arg_28_0:ExitShopPage()
	arg_28_0:StopTimer()
end

function var_0_0.StopTimer(arg_29_0)
	if arg_29_0.updateTimer_ then
		arg_29_0.updateTimer_:Stop()

		arg_29_0.updateTimer_ = nil
	end
end

function var_0_0.ShopItemRenderer(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0.shopComList[arg_30_1]

	if var_30_0 == nil then
		var_30_0 = {}

		arg_30_0:BindCfgUI(arg_30_2, var_30_0)

		arg_30_0.shopComList[arg_30_1] = var_30_0
	end

	local var_30_1 = ShopListCfg[arg_30_1]

	if var_30_0.icon_ then
		var_30_0.icon_.sprite = getSpriteViaConfig("ShopPreviewSmall", arg_30_1)
	end
end

function var_0_0.OnShopItemSelect(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	if not ShopTools.CheckShopIsUnLock(arg_31_2) then
		local var_31_0 = ShopTools.GetShopIsUnLockDesc(arg_31_2)

		if not string.isNullOrEmpty(var_31_0) then
			ShowTips(var_31_0)
		end
	end

	if arg_31_2 ~= arg_31_0.curShop then
		arg_31_0:ExitShopPage()

		local var_31_1 = arg_31_0:GetContentViewByShopId(arg_31_2)

		arg_31_0.curShop = arg_31_2

		arg_31_0:EnterShopPage(var_31_1)
		arg_31_0:UpdateShopList(arg_31_2)
	end
end

function var_0_0.ExitShopPage(arg_32_0)
	local var_32_0 = arg_32_0:GetCurContentView()

	if var_32_0 then
		var_32_0:OnExit()
	end
end

function var_0_0.EnterShopPage(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1 or arg_33_0:GetCurContentView()

	if var_33_0 then
		var_33_0:OnEnter()
	end
end

function var_0_0.OnShopGroupSelect(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	return
end

function var_0_0.Dispose(arg_35_0)
	arg_35_0.tree:Dispose()

	for iter_35_0, iter_35_1 in pairs(arg_35_0.contentViewDic) do
		iter_35_1:Dispose()
	end

	arg_35_0.contentViewDic = nil
	arg_35_0.curShop = nil

	var_0_0.super.Dispose(arg_35_0)
end

local var_0_10 = require("game.tools.ShopTools").GetShopRedPointKey

local function var_0_11(arg_36_0)
	return "SHOP_GROUP_" .. arg_36_0
end

function var_0_0.RegisterRedPoints(arg_37_0)
	for iter_37_0, iter_37_1 in pairs(arg_37_0.catagoryInfo) do
		local var_37_0 = {}
		local var_37_1 = arg_37_0.tree:GetGroupRedPointContainerById(iter_37_0)

		for iter_37_2, iter_37_3 in ipairs(iter_37_1) do
			local var_37_2 = arg_37_0.tree:GetItemRedPointContainerById(iter_37_0, iter_37_3)

			if var_37_2 then
				local var_37_3 = var_0_10(iter_37_3)

				manager.redPoint:bindUIandKey(var_37_2, var_37_3)
				table.insert(var_37_0, var_37_3)
			end
		end

		if var_37_1 and next(var_37_0) then
			local var_37_4 = var_0_11(iter_37_0)

			manager.redPoint:addGroup(var_37_4, var_37_0, true)
			manager.redPoint:bindUIandKey(var_37_1, var_37_4)
		end
	end
end

function var_0_0.ClearAllRegisteredRedPoints(arg_38_0)
	if arg_38_0.catagoryInfo == nil then
		return
	end

	for iter_38_0, iter_38_1 in pairs(arg_38_0.catagoryInfo) do
		local var_38_0 = {}
		local var_38_1 = arg_38_0.tree:GetGroupRedPointContainerById(iter_38_0)

		for iter_38_2, iter_38_3 in ipairs(iter_38_1) do
			local var_38_2 = arg_38_0.tree:GetItemRedPointContainerById(iter_38_0, iter_38_3)

			if var_38_2 then
				local var_38_3 = var_0_10(iter_38_3)

				manager.redPoint:unbindUIandKey(var_38_2, var_38_3)
				table.insert(var_38_0, var_38_3)
			end
		end

		if var_38_1 then
			local var_38_4 = var_0_11(iter_38_0)

			manager.redPoint:unbindUIandKey(var_38_1, var_38_4)
			manager.redPoint:delGroup(var_38_4, var_38_0)
		end
	end
end

local function var_0_12(arg_39_0, arg_39_1)
	for iter_39_0, iter_39_1 in var_0_6(arg_39_0) do
		local var_39_0 = iter_39_1.value
		local var_39_1 = table.indexof(var_39_0, arg_39_1)

		if var_39_1 then
			return iter_39_0, var_39_1
		end
	end
end

function var_0_0.SelectTreeByShopId(arg_40_0, arg_40_1)
	if next(arg_40_0.catagoryInfo) == nil then
		return
	end

	local var_40_0, var_40_1 = var_0_12(arg_40_0.catagoryInfo, arg_40_1)

	if var_40_0 and var_40_1 then
		arg_40_0.tree:SelectItem(var_40_0, var_40_1)
	end

	return var_40_0, var_40_1
end

return var_0_0

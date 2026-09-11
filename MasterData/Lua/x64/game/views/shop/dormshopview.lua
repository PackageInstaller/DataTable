local ShopView = class("ShopView", ReduxView)

function ShopView:UIName()
	return "Widget/System/Shop/BHShopUI"
end

function ShopView:UIParent()
	return manager.ui.uiMain.transform
end

local function var_0_1(arg_3_0)
	return nullable(ShopListCfg, arg_3_0, "display_group")
end

local function var_0_2(arg_4_0)
	return nullable(ShopListCfg.get_id_list_by_system_and_group, 1, arg_4_0, 1, "group_name")
end

function ShopView:OnCtor()
	self.curShop = nil
	self.contentViewDic = {}
end

function ShopView:Init()
	self:BindCfgUI()

	self.tree = LuaTree.New(self.treeGo_)

	self.tree:OverrideRenderer(nil, handler(self, self.ShopItemRenderer))
	self.tree:SetSelectedHandler(handler(self, self.OnShopGroupSelect), handler(self, self.OnShopItemSelect))

	self.displayModeController = self.controllerExCollection_:GetController("displayMode")
end

local function var_0_5(arg_9_0, arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_0) do
		local var_9_1 = arg_9_1(iter_9_1)
		local var_9_2 = var_9_0[var_9_1]

		if var_9_0[var_9_1] == nil then
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

			return arg_11_1, {
				key = var_10_0[arg_11_1],
				value = arg_10_0[var_10_0[arg_11_1]]
			}
		end
	end, #var_10_0, 0
end

function ShopView:UpdateShopCatagoryTreeData(arg_12_1)
	if next(arg_12_1) == nil then
		return
	end

	self.catagoryInfo = arg_12_1
	self.shopComList = {}

	local var_12_0 = UITreeData.New()

	for iter_12_0, iter_12_1 in var_0_6(arg_12_1, self.params_.groupSortingFunc) do
		table.sort(iter_12_1.value, self.params_.shopInGroupSortFunc)

		local var_12_1 = UITreeGroupData.New()

		for iter_12_2, iter_12_3 in ipairs(iter_12_1.value) do
			local var_12_2 = UITreeItemData.New()

			var_12_2.id = ShopListCfg[iter_12_3].id
			var_12_2.text = GetI18NText(ShopListCfg[iter_12_3].remark)

			var_12_1.itemDatas:Add(var_12_2)
		end

		var_12_1.text = GetI18NText(((self.params_.groupNameMappingFunc or var_0_2)(iter_12_1.key)))
		var_12_1.id = iter_12_1.key

		var_12_0.groupDatas:Add(var_12_1)
	end

	self.tree:SetData(var_12_0)
	self:ClearAllRegisteredRedPoints()
	self:RegisterRedPoints()
end

function ShopView:SetData(arg_13_1)
	local var_13_0 = self.params_.shop or arg_13_1[1]
	local var_13_1 = var_0_5(arg_13_1, self.params_.groupingFunc or var_0_1)

	self.displayModeController:SetSelectedState(#arg_13_1 > 1 and "multiple" or "single")
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.middleTrs_)
	self:UpdateShopCatagoryTreeData(var_13_1)

	local var_13_2, var_13_3 = self:SelectTreeByShopId(var_13_0)
	local var_13_4 = self.treeGo_:GetComponent("ScrollRect")

	self.tree:ClampItemInRect(var_13_2, var_13_3, var_13_4.viewport, var_13_4.content)
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

	local ShopFurnitureContentView = import("game.views.shop.contentViews.ShopFurnitureContentView")

	if var_0_7[arg_14_0] then
		return var_0_7[arg_14_0].CLASS
	else
		local var_14_1 = ShopListCfg[arg_14_0]

		if ShopListCfg[arg_14_0].display_group == var_0_8 then
			return ShopFurnitureContentView
		end

		if var_14_1.system == "2" then
			return ShopExchangeContentView
		else
			return ShopContentView
		end
	end
end

function ShopView:GetContentViewByShopId(arg_15_1, arg_15_2)
	if arg_15_1 == nil then
		return nil
	end

	local var_15_0 = var_0_9(arg_15_1)

	if self.curShop then
		local var_15_1 = var_0_9(self.curShop)

		if var_15_1 ~= var_15_0 then
			SetActive(self.contentViewDic[var_15_1.__cname].gameObject_, false)
		end
	end

	local var_15_2 = self.contentViewDic[var_15_0.__cname]

	if not self.contentViewDic[var_15_0.__cname] then
		var_15_2 = var_15_0.New(self.contentContainer_)
		self.contentViewDic[var_15_0.__cname] = var_15_2
	elseif not arg_15_2 then
		SetActive(var_15_2.gameObject_, true)
	end

	var_15_2:SetShopHideHome(self.params_.hideHomeBtn)

	if not arg_15_2 then
		var_15_2:SetShopId(arg_15_1)
	end

	return var_15_2
end

function ShopView:GetCurContentView()
	return self:GetContentViewByShopId(self.curShop)
end

function ShopView:RefreshShopGoodInfo(arg_17_1, arg_17_2)
	if self.curShop ~= arg_17_1 then
		return
	end

	self:GetContentViewByShopId(arg_17_1):RefreshShopGoodInfo(arg_17_2)
end

function ShopView:RefreshList(arg_18_1)
	self:GetCurContentView():RefreshList(arg_18_1)
end

function ShopView:UpdateShopList(arg_19_1, arg_19_2)
	arg_19_2 = arg_19_2 or self.curShop == arg_19_1
	self.curShop = arg_19_1
	self.params_.shop = arg_19_1

	self:RefreshList(arg_19_2)
end

function ShopView:UpdateBarByShopId(arg_20_1)
	local var_20_0 = self:GetContentViewByShopId(arg_20_1)

	if var_20_0 then
		var_20_0:UpdateBarByShopId()
	end

	manager.windowBar:RegistHomeCallBack(function()
		gameContext:Go("/home", nil, nil, true)
	end)
	manager.windowBar:RegistBackCallBack(function()
		self.params_.scrollPosition = nil

		JumpTools.Back()
	end)
end

function ShopView:OnTop()
	if self.params_.shop ~= self.curShop then
		self.curShop = self.params_.shop
	end

	if self.curShop then
		self:UpdateShopList(self.curShop, true)
		self:UpdateBarByShopId(self.curShop)
	end
end

function ShopView:OnEnter()
	self.params_.shopList = self.params_.shopList or DormTools:GetAllDormShopIDList()

	if self.params_.hideHomeBtn == nil then
		self.params_.hideHomeBtn = true
	end

	self:EnterShopPage()
	self:SetData(self.params_.shopList)
	self:UpdateTimer()
end

function ShopView:UpdateTimer()
	local function var_25_0()
		for iter_26_0, iter_26_1 in pairs(self.catagoryInfo or {}) do
			local var_26_1 = self.tree:GetGroupRedPointContainerById(iter_26_0).transform.parent.transform:Find("new")
			local var_26_2 = false

			for iter_26_2, iter_26_3 in pairs(iter_26_1) do
				if ShopTools.IsShopDiscount(iter_26_3) then
					var_26_2 = true

					break
				end
			end

			SetActive(var_26_1, var_26_2)
		end

		SetActive(self.timeGo_, ShopTools.IsShopDiscount(self.curShop))

		if ShopTools.IsShopDiscount(self.curShop) then
			self.refreshTxt_.text = string.format(GetTips("TIME_DISPLAY_16"), manager.time:GetLostTimeStrWith2Unit(TimeMgr.GetInstance():parseTimeFromConfig(ShopListCfg[self.curShop].cheap_close_time)))
		end
	end

	var_25_0()

	self.updateTimer_ = Timer.New(function()
		var_25_0()
	end, 1, -1, 1)

	self.updateTimer_:Start()
end

function ShopView:OnExit()
	self:ClearAllRegisteredRedPoints()
	self:ExitShopPage()
	self:StopTimer()
end

function ShopView:StopTimer()
	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end
end

function ShopView:ShopItemRenderer(arg_30_1, arg_30_2)
	local var_30_0 = self.shopComList[arg_30_1]

	if self.shopComList[arg_30_1] == nil then
		var_30_0 = {}

		self:BindCfgUI(arg_30_2, var_30_0)

		self.shopComList[arg_30_1] = var_30_0
	end

	if var_30_0.icon_ then
		var_30_0.icon_.sprite = getSpriteViaConfig("ShopPreviewSmall", arg_30_1)
	end
end

function ShopView:OnShopItemSelect(arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	if not ShopTools.CheckShopIsUnLock(arg_31_2) then
		local var_31_0 = ShopTools.GetShopIsUnLockDesc(arg_31_2)

		if not string.isNullOrEmpty(var_31_0) then
			ShowTips(var_31_0)
		end
	end

	if arg_31_2 ~= self.curShop then
		self:ExitShopPage()

		self.curShop = arg_31_2

		self:EnterShopPage((self:GetContentViewByShopId(arg_31_2)))
		self:UpdateShopList(arg_31_2)
	end
end

function ShopView:ExitShopPage()
	local var_32_0 = self:GetCurContentView()

	if var_32_0 then
		var_32_0:OnExit()
	end
end

function ShopView:EnterShopPage(arg_33_1)
	local var_33_0 = arg_33_1 or self:GetCurContentView()

	if var_33_0 then
		var_33_0:OnEnter()
	end
end

function ShopView:OnShopGroupSelect(arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	return
end

function ShopView:Dispose()
	self.tree:Dispose()

	for iter_35_0, iter_35_1 in pairs(self.contentViewDic) do
		iter_35_1:Dispose()
	end

	self.contentViewDic = nil
	self.curShop = nil

	ShopView.super.Dispose(self)
end

local var_0_10 = require("game.tools.ShopTools").GetShopRedPointKey

local function var_0_11(arg_36_0)
	return "SHOP_GROUP_" .. arg_36_0
end

function ShopView:RegisterRedPoints()
	for iter_37_0, iter_37_1 in pairs(self.catagoryInfo) do
		local var_37_0 = {}
		local var_37_1 = self.tree:GetGroupRedPointContainerById(iter_37_0)

		for iter_37_2, iter_37_3 in ipairs(iter_37_1) do
			local var_37_2 = self.tree:GetItemRedPointContainerById(iter_37_0, iter_37_3)

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

function ShopView:ClearAllRegisteredRedPoints()
	if self.catagoryInfo == nil then
		return
	end

	for iter_38_0, iter_38_1 in pairs(self.catagoryInfo) do
		local var_38_0 = {}
		local var_38_1 = self.tree:GetGroupRedPointContainerById(iter_38_0)

		for iter_38_2, iter_38_3 in ipairs(iter_38_1) do
			local var_38_2 = self.tree:GetItemRedPointContainerById(iter_38_0, iter_38_3)

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
		local var_39_0 = table.indexof(iter_39_1.value, arg_39_1)

		if var_39_0 then
			return iter_39_0, var_39_0
		end
	end
end

function ShopView:SelectTreeByShopId(arg_40_1)
	if next(self.catagoryInfo) == nil then
		return
	end

	local var_40_0, var_40_1 = var_0_12(self.catagoryInfo, arg_40_1)

	if var_40_0 and var_40_1 then
		self.tree:SelectItem(var_40_0, var_40_1)
	end

	return var_40_0, var_40_1
end

return ShopView

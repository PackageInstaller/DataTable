local ShopUICtrl = BaseClass("ShopUICtrl", BaseUICtrl)
local M = ShopUICtrl
local ShopBagType = RechargeConst.ShopBagType
local tIsNullOrEmpty = table.isNullOrEmpty

function M:Init()
    self.curShopType = nil
    self.shopDatas = nil
    self.curShopId = nil
    self.curShopData = nil
    self.recommendData = nil
    self.recommendIndex = nil
    self.shopBagIndex = -1

    self.UpdateShopHandler = EventMgr:AddListener(UIMessageNames.SHOP_UPDATE, Bind(self, self.OnUpdateShop))
    self.UpdateMonthDaysHandler = EventMgr:AddListener(UIMessageNames.MONTH_CARD_DAYS_UPDATE,
        Bind(self, self.OnUpdateMonthDays))
    self.RechargeStateHandler = EventMgr:AddListener(UIMessageNames.RECHARGE_STATE_UPDATE,
        Bind(self, self.OnRechargeStateUpdate))
    self.UpdateShopBagHandler = EventMgr:AddListener(UIMessageNames.SHOP_UPDATEGIFT, Bind(self, self.OnUpdateShopBag))
    self._view.imgBanner:onClick(Bind(self, self.OnBannerClick))
    self.defaultCosts = { 6 }
end

function M:OnEnter(shopType, childShopId, shopItemId)
    self:_InitItemScrollView()
    self:_InitRechargeScrollView()
    self:_InitGiftPackScrollView()
    self:_InitClothScrollView()
    self:_InitRecommendTabs()
    EventMgr:Broadcast(UIMessageNames.CHANGE_MAINSCENE_BACKGROUND, "ShopBg", true)
    IRoleActionMgr:ResetState()
    local shopNames = ShopDataMgr:GetShopNames()
    self._view.ShopTypeTab:InitItems(
        shopType - 1,
        shopNames,
        Bind(self, self.ChangeShopType),
        Bind(self, self.CheckCanClick)
    )

    if shopType == ShopConst.ShopType.Normal and childShopId > 0 then
        local shopDatas = ShopDataMgr:GetShopListByType(shopType)
        for k, v in pairs(shopDatas) do
            if v.id == childShopId then
                self._subType = k - 1
                break
            end
        end
    end

    if shopType == ShopConst.ShopType.GiftPack and childShopId > 0 and shopItemId > 0 then
        self._subType = childShopId - 1
        local giftData = ShopDataMgr:GetShopBagDataById(shopItemId)
        if giftData then
            UIContextMgr:GetInstance():Show(UIDefine.UIShopPack, giftData)
        end
    end
    self:ChangeShopType(shopType - 1)
    GameHelper.DoPlayerAction(PlayerAction.OpenShop)
end

--初始化商店类型红点
function M:_InitNormalShopRedPoint()
    if not self._view.ShopTab.gameObject.activeSelf then
        return
    end
    for i = 0, 3 do
        local item = self._view.ShopTab:GetTabItem(i)
        if not IsNull(item) then
            if self.shopDatas ~= nil then
                local shopId = self.shopDatas[i + 1].id
                item:SetRedPointParam(0, shopId)
            else
                item:SetRedPointParam(0, -1)
            end
            item:RedPointCheck()
        end
    end
end

--初始化商店礼包类型红点
function M:_InitShopBagRedPoint()
    if not self._view.ShopBagTab.gameObject.activeSelf then
        return
    end
    for i = 0, 3 do
        local item = self._view.ShopBagTab:GetTabItem(i)
        if not IsNull(item) then
            item:SetRedPointParam(0, i + 1)
            item:RedPointCheck()
        end
    end
end

function M:_InitItemScrollView()
    self.scrollView = self._view.CommodityScrollView
    local ctrl = require("UI.Ctrl.Shop.ShopItemCtrl")
    local view = require("UI.View.Shop.CommodityView")
    self.scrollView:Init(ctrl, view)
end

function M:_InitRechargeScrollView()
    local rechargeItemCtrl = require("UI.Ctrl.Shop.RechargeItemCtrl")
    local rechargeItemView = require("UI.View.Shop.RechargeItemView")
    self._view.scrollRecharge:Init(rechargeItemCtrl, rechargeItemView)
end

function M:_InitGiftPackScrollView()
    self._view.scrollGiftPack:Init(Bind(self, self.OnGetGiftPackItem))
    ShopDataMgr:GetShopDataById(ShopDataMgr.bagShopId, function(shopData)
        local openShopBags = RechargeDataMgr:GetInstance():GetGiftPackCfgs()
        ShopDataMgr:GetShopBagData(shopData, openShopBags)
        IRedPointMgr:ForceCheck(RedPointConst.ShopBoxRedPointChecker)
    end)
end

function M:_InitClothScrollView()
    local clothItemCtrl = require("UI.Ctrl.Shop.ClothItemCtrl")
    local clothItemView = require("UI.View.Shop.ClothItemView")
    local prefabName = "ClothItem"
    self._view.scrollCloth:Init(clothItemCtrl, clothItemView, prefabName)
end

function M:_InitRecommendTabs()
    self.recommendData = ConfigHelper.GetCfgs("shopRecommend")
    if not tIsNullOrEmpty(self.recommendData) then
        table.sort(self.recommendData, function(a, b)
            return a.order < b.order
        end)
        local paths = {}
        for i = 1, #self.recommendData do
            table.insert(paths, self.recommendData[i].tabPic)
        end

        self._view.tabRecommennd:InitIconItems(0, paths, Bind(self, self.OnRecommendTabChange))
    end
    self.recommendIndex = 1
end

function M:OnGetGiftPackItem(index)
    local dataList = self._view.scrollGiftPack:GetDataList()
    local data = dataList[index]
    local itemTypeClass = nil
    local itemViewType = nil
    local prefabName = nil

    if data.type == ShopBagType.MonthCard then
        itemTypeClass = require("UI.Ctrl.Shop.MonthCardItemCtrl")
        itemViewType = require("UI.View.Shop.MonthCardItemView")
        prefabName = "MonthCardItem"
    else
        itemTypeClass = require("UI.Ctrl.Shop.GiftPackItemCtrl")
        itemViewType = require("UI.View.Shop.GiftPackItemView")
        prefabName = "GiftPackItem"
    end

    return data, itemTypeClass, itemViewType, prefabName
end

function M:OnRecommendTabChange(index)
    if self.recommendIndex == index + 1 then
        return
    end
    self.recommendIndex = index + 1
    self._view.imgBanner:SetPic(self.recommendData[self.recommendIndex].bannerPic, false)
end

function M:OnBannerClick()
    local data = self.recommendData[self.recommendIndex]

    if data then
        --判断跳转通行证商店
        if data.shopType == ShopConst.ShopType.PassCard then
            JumpMgr:GetInstance():Execute(data.Value1)
        else
            if data.shopType == ShopConst.ShopType.GiftPack then
                local giftData = ShopDataMgr:GetShopBagDataById(data.Value1)
                if giftData then
                    if giftData.type == ShopBagType.MonthCard then
                        --月卡要切到子页签
                        self._subType = 2
                        local shopBagCfg = ConfigHelper.GetCfgByLua("shopBag", data.Value1)
                        if RechargeDataMgr:GetInstance():CheckBuyMonthCard(shopBagCfg.shopCardId) then
                            local cardCfg = ConfigHelper.GetCfgByLua("shopCard", shopBagCfg.shopCardId)
                            UIContextMgr:GetInstance():Show("MonthCardPopupUI", cardCfg)
                        end
                    else
                        UIContextMgr:GetInstance():Show(UIDefine.UIShopPack, giftData)
                    end
                end
            end
            self:CheckCanClick(data.shopType - 1)
        end
    end
end

function M:ChangeShopType(idx)
    if self.curShopType == idx + 1 then
        return
    end

    self.curShopType = idx + 1
    self._view.ShopTab:DestroyItems()
    self.shopDatas = ShopDataMgr:GetShopListByType(self.curShopType)

    if self.curShopType == ShopConst.ShopType.Normal then
        self:ChangeNormalShop()
    elseif self.curShopType == ShopConst.ShopType.Recharge then
        self:ChangeRechargeShop()
    elseif self.curShopType == ShopConst.ShopType.GiftPack then
        self:ChangeGiftPackShop()
    elseif self.curShopType == ShopConst.ShopType.Recommend then
        self:ChangeRecommendShop()
    elseif self.curShopType == ShopConst.ShopType.Cloth then
        self:ChangeClothShop()
    end
    self._subType = nil
end

function M:CheckCanClick(index)
    self._view.ShopTypeTab:TabSelect(index)
end

function M:ChangeClothShop()
    if tIsNullOrEmpty(self.shopDatas) then
        return
    end
    --获取时装商店数据
    self:ChangeTopBar(self.shopDatas[1].costs)
    local configs = RechargeDataMgr:GetInstance():GetClothCfgs()
    local data = ShopDataMgr:GetClothShopData(self.shopDatas[1], configs)
    local dataList = self._view.scrollCloth:GetDataList()
    if #dataList > 0 then
        self._view.scrollCloth:UpdateList(data)
        self._view.scrollCloth:MovePanelToItemIndex(0)
    else
        self._view.scrollCloth:SetDataList(data)
        self._view.scrollCloth:MovePanelToItemIndex(0)
    end
end

function M:ChangeRechargeShop()
    if tIsNullOrEmpty(self.shopDatas) then
        return
    end
    RechargeDataMgr:GetInstance():RequestRechargeInfo(function()
        self:ChangeTopBar(self.shopDatas[1].costs)
        local configs = RechargeDataMgr:GetInstance():GetRechargeCfgs()
        local data = ShopDataMgr:GetRechargeShopData(self.shopDatas[1], configs)
        self._view.scrollRecharge:SetDataList(data)
    end)
end

function M:ChangeRecommendShop()
    self:ChangeTopBar(self.defaultCosts)
    self._view.tabRecommennd:SetIndex(0)
    self:OnRecommendTabChange(0)
end

function M:ChangeGiftPackShop()
    if tIsNullOrEmpty(self.shopDatas) then
        return
    end
    --请求礼包商店数据
    ShopDataMgr:GetShopDataById(self.shopDatas[1].id, function(shopData)
        self:ChangeTopBar(self.shopDatas[1].costs)
        local openShopBags = RechargeDataMgr:GetInstance():GetGiftPackCfgs()
        ShopDataMgr:GetShopBagData(shopData, openShopBags)
        local shopBagNames = {}
        table.insert(shopBagNames, ConfigHelper.GetLocalString(ShopConst.ShopBagTab.Tyro.txt))
        table.insert(shopBagNames, ConfigHelper.GetLocalString(ShopConst.ShopBagTab.Period.txt))
        table.insert(shopBagNames, ConfigHelper.GetLocalString(ShopConst.ShopBagTab.Normal.txt))
        local shopBagIcon = {}
        table.insert(shopBagIcon, ShopConst.ShopBagTab.Tyro.icon)
        table.insert(shopBagIcon, ShopConst.ShopBagTab.Period.icon)
        table.insert(shopBagIcon, ShopConst.ShopBagTab.Normal.icon)
        self._subType = self._subType or 0
        self._view.ShopBagTab:InitItems(self._subType, shopBagNames, Bind(self, self.ChangeBagType))
        self._view.ShopBagTab:SetItemIcon(shopBagIcon)

        self:ChangeBagType(self._subType)
    end)
    self:_InitShopBagRedPoint()
end

function M:ChangeBagType(idx)
    if self.shopBagIndex == idx then return end
    self.shopBagIndex = idx
    local shopBagType = idx + 1
    local shopBagDatas = ShopDataMgr:GetShopBagByType(shopBagType)
    local dataList = self._view.scrollGiftPack:GetDataList()
    if #dataList > 0 then
        self._view.scrollGiftPack:UpdateList(shopBagDatas)
        self._view.scrollGiftPack:MovePanelToItemIndex(0)
    else
        self._view.scrollGiftPack:SetDataList(shopBagDatas)
        self._view.scrollGiftPack:MovePanelToItemIndex(0)
    end
end

function M:ChangeNormalShop()
    if self.shopDatas ~= nil then
        local shopNames = {}

        for k, v in pairs(self.shopDatas) do
            local name = ConfigHelper.GetLocalString(v.name);
            table.insert(shopNames, name)
        end
        self._subType = self._subType or 0
        self._view.ShopTab:InitItems(self._subType, shopNames, Bind(self, self.ChangeShop))
        self:ChangeShop(self._subType)
        self:_InitNormalShopRedPoint()
    end
end

function M:ChangeShop(idx)
    local shopId = 0

    if self.shopDatas ~= nil then
        shopId = self.shopDatas[idx + 1].id
    end
    self:ChangeTopBar(self.shopDatas[idx + 1].costs)

    if shopId == self.curShopId then
        return
    end

    self.curShopId = shopId
    -- 获取商店信息
    ShopDataMgr:GetShopDataById(self.curShopId, Bind(self, self.GetShopDataCallBack))
end

function M:GetShopDataCallBack(shopData)
    if shopData ~= nil then
        self:OnUpdateShop(shopData)
    end
end

function M:OnRechargeStateUpdate()
    self._view.scrollRecharge:UpdateList()
end

function M:OnUpdateShop(data)
    self.curShopData = data
    self.scrollView:SetDataList(self.curShopData.shopItems)
    self:CheckRefreshType(self.curShopData.shopConfig.refreshType)
end

function M:OnUpdateMonthDays(data)
    local shopBagDatas = ShopDataMgr:GetShopBagByType(self.shopBagIndex + 1)
    self._view.scrollGiftPack:UpdateList(shopBagDatas)
end

function M:OnUpdateShopBag(data)
    local shopBagType = self.shopBagIndex + 1
    local openShopBags = RechargeDataMgr:GetInstance():GetGiftPackCfgs()
    ShopDataMgr:GetShopBagData(data, openShopBags)
    local shopBagDatas = ShopDataMgr:GetShopBagByType(shopBagType)
    local dataList = self._view.scrollGiftPack:GetDataList()
    if #dataList > 0 then
        self._view.scrollGiftPack:UpdateList(shopBagDatas)
        self._view.scrollGiftPack:MovePanelToItemIndex(0)
    else
        self._view.scrollGiftPack:SetDataList(shopBagDatas)
        self._view.scrollGiftPack:MovePanelToItemIndex(0)
    end
end

function M:CheckRefreshType(type)
    if self.timer then
        self.timer:Stop()
    end

    if type == ShopConst.EShopRefreshType.E_Not_Refresh then
        self._view.RefreshPart.gameObject:SetActive(false)
    end

    if type == ShopConst.EShopRefreshType.E_Fix_Refresh or type == ShopConst.EShopRefreshType.E_Day_Refresh
        or type == ShopConst.EShopRefreshType.E_Week_Refresh or type == ShopConst.EShopRefreshType.E_Month_Refresh then
        self._view.RefreshPart.gameObject:SetActive(true)
        self._view.AutoRefreshPart.gameObject:SetActive(true)
        -- 设置自动刷新倒计时
        self.refreshTime = self.curShopData.refreshCountDown - TimeUtil.GetNowTimeStamp()
        local str = ConfigHelper.GetLocalString(30152)
        self._view.CountDownText:SetText(string.format(str, GameHelper.formatTime(self.refreshTime)))
        self.timer = TimerManager:GetInstance():GetTimer(1, Bind(self, self.TimerCallBack), self)
        self.timer:Start()
    end
end

function M:TimerCallBack()
    if self.refreshTime > 0 then
        self.refreshTime = self.refreshTime - 1
        local str = ConfigHelper.GetLocalString(30152)
        self._view.CountDownText:SetText(string.format(str, GameHelper.formatTime(self.refreshTime)))
    else
        self.timer:Stop()
        self.timer = nil
        ShopDataMgr:RequestRefreshShop(self.curShopId)
    end
end

function M:OnClickRefresh(go)
    ShopDataMgr:RequestRefreshShop(self.curShopId)
end

function M:ChangeTopBar(costs)
    local array = GameHelper.TableToArray(costs)
    UIContextMgr:GetInstance():Show("TopBar", self.config, array)
end

--点击设置退出键
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end

function M:OnVisible()
    IRoleActionMgr:ResetState()
    EventMgr:Broadcast(UIMessageNames.CHANGE_MAINSCENE_BACKGROUND, "ShopBg", true)
end

function M:OnInvisible()
    EventMgr:Broadcast(UIMessageNames.CHANGE_MAINSCENE_BACKGROUND, "ShopBg", false)
end

function M:OnDispose()
    self._view.tabRecommennd:DisposeAll()

    if self.timer then
        self.timer:Stop()
    end

    EventMgr:RemoveListener(UIMessageNames.SHOP_UPDATE, self.UpdateShopHandler)
    self.UpdateShopHandler = nil
    EventMgr:RemoveListener(UIMessageNames.MONTH_CARD_DAYS_UPDATE, self.UpdateMonthDaysHandler)
    self.UpdateMonthDaysHandler = nil
    EventMgr:RemoveListener(UIMessageNames.RECHARGE_STATE_UPDATE, self.RechargeStateHandler)
    self.RechargeStateHandler = nil
    EventMgr:RemoveListener(UIMessageNames.SHOP_UPDATEGIFT, self.UpdateShopBagHandler)
    self.UpdateShopBagHandler = nil
    M.super.OnDispose(self)
end

return ShopUICtrl

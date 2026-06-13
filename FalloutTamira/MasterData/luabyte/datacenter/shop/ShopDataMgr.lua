local ShopDataMgr = BaseClass("ShopDataMgr")
local M = ShopDataMgr
local ShopBagType = RechargeConst.ShopBagType
local shopType = ShopConst.ShopType
local MessageId = Proto.MessageId
local tInsert = table.insert
local tSort = table.sort

function M:__init()
    self._shopIds = {}
    self.shopDataDic = {}
    self.curShopId = 0
    self.shopNames = {}
    self.shopType = nil
    self.rechargeType = nil
    self.redPointNum = 0
    self.shopBags = {}
    self._OnNotifyRechargeShopBuy = NetPack:RegistResponse(MessageId.NotifyRechargeShopBuy,
        Bind(self, self.OnNotifyRechargeShopBuy))
    self._OnNotifyRoleCurrency = NetPack:RegistResponse(MessageId.NotifyRoleCurrency,
        Bind(self, self.OnNotifyRoleCurrency))
    self.bagShopId = ConfigHelper.GetCfgsByLua("shop", { type = ShopConst.ShopType.GiftPack })[1].id
    self.rechargeShopId = ConfigHelper.GetCfgsByLua("shop", { type = ShopConst.ShopType.Recharge })[1].id
    self.monthShopId = ConfigHelper.GetCfgsByLua("shop", { type = ShopConst.ShopType.MonthCard })[1].id
    self.clothShopId = ConfigHelper.GetCfgsByLua("shop", { type = ShopConst.ShopType.Cloth })[1].id
end

-- 初始化商店类型
function M:InitShopType()
    self.shopTypeNames = {}
    self.shopTypeDic = {}
    self.shopNames = {}

    for k, v in pairs(self._shopIds) do
        local cfg = ConfigHelper.GetCfgByLua("shop", v)
        if cfg then
            if self.shopTypeDic[cfg.type] == nil then
                self.shopTypeDic[cfg.type] = {}

                if cfg.type == ShopConst.ShopType.Normal then
                    tInsert(self.shopTypeNames, ShopConst.ShopTab.Normal)
                end

                if cfg.type == ShopConst.ShopType.Recharge then
                    tInsert(self.shopTypeNames, ShopConst.ShopTab.Recharge)
                end

                if cfg.type == ShopConst.ShopType.GiftPack then
                    tInsert(self.shopTypeNames, ShopConst.ShopTab.GiftPack)
                end

                if cfg.type == ShopConst.ShopType.Recommend then
                    tInsert(self.shopTypeNames, ShopConst.ShopTab.Recommend)
                end
            end

            tInsert(self.shopTypeDic[cfg.type], cfg)
            -- 排序商店
            for k, v in pairs(self.shopTypeDic) do
                if v then
                    table.sort(v, function(a, b)
                        return a.order < b.order
                    end)
                end
            end
        end
    end

    table.sort(self.shopTypeNames, function(a, b)
        return a.type < b.type
    end)

    for k, v in pairs(self.shopTypeNames) do
        tInsert(self.shopNames, v.txt)
    end
end

function M:GetShopNames()
    return self.shopNames
end

-- 根据类型获取商店配置列表
function M:GetShopListByType(type)
    if self.shopTypeDic[type] ~= nil then
        return self.shopTypeDic[type]
    end
    return nil
end

-- 根据id获取商店数据
function M:GetShopDataById(shopId, callback)
    self.curShopId = shopId

    if self.shopDataDic[shopId] and callback then
        callback(self.shopDataDic[shopId])
    end
end

-- 请求进入商店
function M:RequestEnterShop(shopType, rechargeType, callBack)
    if self._isSending then
        return
    end

    self._isSending = true
    self.shopType = shopType
    self.rechargeType = rechargeType
    self.enterShopCallBack = callBack

    local request = {}
    NetPack:SendMessage(MessageId.RequestEnterShop, request)
    self._responseEnterShopHandler = NetPack:RegistResponse(MessageId.ResponseEnterShop,
        Bind(self, self.OnResponseEnterShop))
end

-- 进入商店回调
function M:OnResponseEnterShop(messageId, result, msg)
    self._isSending = false
    NetPack:UnRegistResponse(MessageId.ResponseEnterShop, self._responseEnterShopHandler)

    if result ~= 0 then
        return
    end

    self._shopIds = {}

    for i, v in ipairs(msg.Shops) do
        tInsert(self._shopIds, v.ShopId)
        self:UpdateShopData(v.ShopId, v.DueTick, v.BuyShopItems)
    end

    tInsert(self._shopIds, self.rechargeShopId)
    tInsert(self._shopIds, self.monthShopId)
    if #self._shopIds > 0 then
        self:InitShopType()
    end

    if self.enterShopCallBack then
        self.enterShopCallBack(self.shopType, self.rechargeType, true)
    end
    self.enterShopCallBack = nil
end

-- 请求刷新商店
function M:RequestRefreshShop(shopId)
    if self._isSending then
        return
    end

    self._isSending = true

    local request = {}
    request.ShopId = shopId
    self.requireShopId = shopId
    NetPack:SendMessage(MessageId.RequestRefreshShop, request)
    self._responseRefreshShopHandler = NetPack:RegistResponse(MessageId.ResponseRefreshShop,
        Bind(self, self.OnResponseRefreshShop))
end

-- 请求刷新商店返回
function M:OnResponseRefreshShop(messageId, result, msg)
    self._isSending = false
    NetPack:UnRegistResponse(MessageId.ResponseRefreshShop, self._responseRefreshShopHandler)

    if result ~= 0 then
        return
    end

    self:UpdateShopData(msg.Data.ShopId, msg.Data.DueTick, msg.Data.BuyShopItems)
end

-- 购买成功主动推送
function M:OnNotifyRechargeShopBuy(messageId, result, msg)
    if result ~= 0 then
        return
    end
    local type = ConfigHelper.GetCfgPropByLua("shop", msg.ShopId, "type")
    if self.shopDataDic[msg.ShopId] then
        self.shopDataDic[msg.ShopId]:UpdateItem(msg.Item)

        if type == shopType.GiftPack then
            EventMgr:Broadcast(UIMessageNames.SHOP_UPDATEGIFT, self.shopDataDic[msg.ShopId])
            IRedPointMgr:ForceCheck(RedPointConst.ShopBoxRedPointChecker)
            IRedPointMgr:ForceCheck(RedPointConst.ShopBagTypeRedPointChecker)
        end
    end

    if type == shopType.Recharge or type == shopType.GiftPack or msg.ShopId == 0 then
        RechargeDataMgr:GetInstance():_UpdateRechargeState(msg.RechargeState, msg.FirstInfo)
    end

    if type == shopType.Cloth then
        EventMgr:Broadcast(UIMessageNames.SHOP_CLOTH_BUY_SUCC)
    end
    GameHelper.ShowGetItemsByItems(msg.AwardItems)
    SDKHelper.Submit()
end

--货币刷新推送
function M:OnNotifyRoleCurrency(messageId, result, msg)
    if result ~= 0 then
        return
    end

    for k, v in pairs(msg.data) do
        EventMgr:Broadcast(UIMessageNames.SHOP_UPDATECURRENCY, v.ItemId, v.Stack)
    end
end

-- 请求购买商品
function M:RequestBuyItem(shopId, shopItemId, num, callback)
    if self._isSending then
        return
    end

    self._isSending = true
    self.buyItemCallback = callback
    local request = {}
    request.ShopId = shopId
    request.ShopItemId = shopItemId
    request.BuyCnt = num
    NetPack:SendMessage(MessageId.RequestBuyItem, request)
    self._responseBuyItemHandler = NetPack:RegistResponse(MessageId.ResponseBuyItem, Bind(self, self.OnResponseBuyItem))
end

-- 请求购买商品返回
function M:OnResponseBuyItem(messageId, result, msg)
    self._isSending = false
    NetPack:UnRegistResponse(messageId, self._responseBuyItemHandler)

    if result ~= 0 then return end

    local type = ConfigHelper.GetCfgPropByLua("shop", msg.ShopId, "type")
    if self.shopDataDic[msg.ShopId] then
        self.shopDataDic[msg.ShopId]:UpdateItem(msg.Item)
        if type == ShopConst.ShopType.GiftPack then
            EventMgr:Broadcast(UIMessageNames.SHOP_UPDATEGIFT, self.shopDataDic[msg.ShopId])
            IRedPointMgr:ForceCheck(RedPointConst.ShopBoxRedPointChecker)
            IRedPointMgr:ForceCheck(RedPointConst.ShopBagTypeRedPointChecker)
            local shopBag = ConfigHelper.GetCfgByLua("shopBag", msg.Item.ItemId)
            --礼包购买埋点
            IBuriedPointDataMgr:SubmitData(BuriedPointConst.ShopBag, { msg.Item.ItemId })
            --付费等级礼包埋点
            if shopBag.type == ShopBagType.PaidLevelPack then --付费等级礼包
                local dataValues = { 3, shopBag.costItemNum }
                IBuriedPointDataMgr:SubmitData(BuriedPointConst.Item6Use, dataValues)
            elseif shopBag.type == ShopBagType.ModifyName then --改名卡
                local dataValues = { 4, shopBag.costItemNum }
                IBuriedPointDataMgr:SubmitData(BuriedPointConst.Item6Use, dataValues)
            end
        end

        if type == ShopConst.ShopType.Normal then
            IRedPointMgr:ForceCheck(RedPointConst.ShopRedPointChecker)
            IRedPointMgr:ForceCheck(RedPointConst.ShopTypeRedPointChecker)
            EventMgr:Broadcast(UIMessageNames.SHOP_UPDATE, self.shopDataDic[msg.ShopId])
            local shop = ConfigHelper.GetCfgByLua("shop", msg.ShopId)
            local dataValues = { shop.lib, msg.Item.ItemId, msg.Item.BuyTimes }
            IBuriedPointDataMgr:SubmitData(BuriedPointConst.ShopItemExchange, dataValues)
        end
    end

    if type ~= ShopConst.ShopType.Cloth then
        GameHelper.ShowGetItemsByItems(msg.Items)
    else
        --时装商店埋点
        local shopSkin = ConfigHelper.GetCfgByLua("shopSkin", msg.Item.ItemId)
        if shopSkin.finalItem == 6 then
            local dataValues = { 5, shopSkin.finalNum }
            IBuriedPointDataMgr:SubmitData(BuriedPointConst.Item6Use, dataValues)
        end
    end

    if self.buyItemCallback then self.buyItemCallback() end
end

function M:UpdateShopData(shopId, countDown, shopItems)
    local shopDataCls = require("DataCenter.Shop.ShopData")

    if self.shopDataDic[shopId] then
        self.shopDataDic[shopId]:UpdateData(countDown, shopItems)
    else
        local shopDataInst = shopDataCls.New(shopId, countDown, shopItems)
        self.shopDataDic[shopId] = shopDataInst
    end
    local type = ConfigHelper.GetCfgPropByLua("shop", shopId, "type")

    if type == ShopConst.ShopType.Normal then
        EventMgr:Broadcast(UIMessageNames.SHOP_UPDATE, self.shopDataDic[shopId])
        IRedPointMgr:ForceCheck(RedPointConst.ShopRedPointChecker)
        IRedPointMgr:ForceCheck(RedPointConst.ShopTypeRedPointChecker)
    end

    if type == ShopConst.ShopType.GiftPack then
        EventMgr:Broadcast(UIMessageNames.SHOP_UPDATEGIFT, self.shopDataDic[shopId])
        IRedPointMgr:ForceCheck(RedPointConst.ShopBoxRedPointChecker)
        IRedPointMgr:ForceCheck(RedPointConst.ShopBagTypeRedPointChecker)
    end
end

function M:RequestShopRedPoint()
    if self._isSending then
        return
    end

    self._isSending = true

    local request = {}
    NetPack:SendMessage(MessageId.RequestShopRedPoint, request)
    self._responseShopRedPointHandler = NetPack:RegistResponse(MessageId.ResponseShopRedPoint,
        Bind(self, self.OnResponseShopRedPoint))
end

function M:OnResponseShopRedPoint(messageId, result, msg)
    self._isSending = false
    self._dataLoaded = true
    self._isloading = false

    NetPack:UnRegistResponse(MessageId.ResponseShopRedPoint, self._responseShopRedPointHandler)

    if result ~= 0 then
        return
    end

    self.redPointNum = msg.PointCount
end

--普通商店类型红点
function M:CheckNormalShopTypeRedPoint(shopId)
    local shopdata = self.shopDataDic[shopId]
    if shopdata then
        return shopdata:CheckRedPoint(0)
    else
        return false
    end
end

--商店红点
function M:CheckNormalShopRedPoint(id)
    if id < 0 then
        return false
    end

    local result = false
    local dataLoaded = false
    for key, value in pairs(self.shopDataDic) do
        if value.shopConfig.type == shopType.Normal then
            result = value:CheckRedPoint(id)
            dataLoaded = true
            if result then
                return result
            end
        end
    end

    if dataLoaded == false then
        return self.redPointNum > 0
    else
        return result
    end
end

--用于在登录的时候初始化相关数据
function M:LoadData()
    self._isloading = true
    self._dataLoaded = false
    self._errorCode = 0
    self:RequestShopRedPoint()
end

function M:IsLoading()
    return self._isloading
end

function M:IsReady()
    return self._dataLoaded
end

function M:ErrorCode()
    return self._isloading
end

function M:Cleanup()
end

--获取商店礼包数据
function M:GetShopBagData(shopData, shopBagCfgs)
    local shopBags = {}
    --如果准备中，网速特别慢时数据未回来
    if shopBagCfgs == nil then
        return shopBags
    end
    for key, value in pairs(shopBagCfgs) do
        local buyNum = 0
        local nextResetTime = 0
        if value.type == ShopBagType.FreeLevelPack or value.type == ShopBagType.PaidLevelPack then
            --等级礼包排序
            local bagCfgs = {}
            local buyDatas = {}
            bagCfgs = RechargeDataMgr:GetInstance():GetShopBagCfgs(value.type)
            tSort(bagCfgs, self._SortById)
            for key, bagcfg in pairs(bagCfgs) do
                local buyData = shopData:GetShopItemData(bagcfg.id)
                if buyData then
                    tInsert(buyDatas, buyData)
                end
            end
            if #buyDatas > 0 then
                --购买过等级礼包
                local endShopData = self:_TempGetShopData(bagCfgs, buyDatas)
                local shopBag = {
                    shopConfId = endShopData.id,
                    buyNum = endShopData.buyNum,
                    allNum = bagCfgs[1].buyCount,
                    nextResetTime = nextResetTime,
                    type = value.type,
                    shopId = shopData.shopId,
                    order = bagCfgs[1].order,
                    bagType = bagCfgs[1].bagType
                }
                tInsert(shopBags, shopBag)
            else
                --未购买等级礼包
                local shopBag = {
                    shopConfId = bagCfgs[1].id,
                    buyNum = buyNum,
                    allNum = bagCfgs[1].buyCount,
                    nextResetTime = nextResetTime,
                    type = value.type,
                    shopId = shopData.shopId,
                    order = bagCfgs[1].order,
                    bagType = bagCfgs[1].bagType
                }
                tInsert(shopBags, shopBag)
            end
        else
            local buyData = shopData:GetShopItemData(value.id)
            if buyData then
                --购买过礼包
                if value.type == ShopBagType.DailyPack or value.type == ShopBagType.MonthlyPack or
                    value.type == ShopBagType.FixedPack then
                    local nowTimer = TimeUtil.GetNowTimeStamp()
                    if buyData.BuyTimes ~= 0 and (nowTimer >= buyData.NextResetTime) then
                        buyData.BuyTimes = 0
                    end
                    nextResetTime = buyData.NextResetTime
                end
                buyNum = buyData.BuyTimes
                local shopBag = {
                    shopConfId = value.id,
                    buyNum = buyNum,
                    allNum = value.buyCount,
                    nextResetTime = nextResetTime,
                    type = value.type,
                    shopId = shopData.shopId,
                    order = value.order,
                    bagType = value.bagType
                }
                tInsert(shopBags, shopBag)
            else
                --未购买礼包填写默认数据
                local shopBag = {
                    shopConfId = value.id,
                    buyNum = buyNum,
                    allNum = value.buyCount,
                    nextResetTime = nextResetTime,
                    type = value.type,
                    shopId = shopData.shopId,
                    order = value.order,
                    bagType = value.bagType
                }
                tInsert(shopBags, shopBag)
            end
        end
    end
    tSort(shopBags, self.SortByOrder)
    self.shopBags = shopBags
    return shopBags
end

--根据类型获取背包数据
function M:GetShopBagByType(type)
    if self.shopBags then
        local datas = {}
        for key, value in pairs(self.shopBags) do
            if value.bagType == type then
                table.insert(datas, value)
            end
        end
        return datas
    end
    return nil
end

--根据id获取
function M:GetShopBagDataById(id)
    for key, value in pairs(self.shopBags) do
        if value.shopConfId == id then
            return value
        end
    end
    return nil
end

--获取时装商店数据
function M:GetClothShopData(shopData, clothCfgs)
    local cloths = {}
    if clothCfgs then
        for key, value in pairs(clothCfgs) do
            local data = {
                cfg = value,
                shopId = shopData.id
            }
            tInsert(cloths, data)
        end
    end
    tSort(cloths, self.ClothSort)
    return cloths
end

--获取充值商店数据
function M:GetRechargeShopData(shopData, rechargeCfgs)
    local recharges = {}
    if rechargeCfgs then
        for _, value in pairs(rechargeCfgs) do
            tInsert(recharges, {
                cfg = value,
                shopId = shopData.id
            })
        end
    end
    tSort(recharges, function(a, b)
        return a.cfg.id < b.cfg.id
    end)
    return recharges
end

function M:_TempGetShopData(bagCfgs, allShopDatas)
    for _, bagCfg in pairs(bagCfgs) do
        local isNew = true

        for _, shopItem in pairs(allShopDatas) do
            if shopItem.ItemId == bagCfg.id and shopItem.BuyTimes >= 1 then
                isNew = false
            end
        end

        if isNew then
            return {
                id = bagCfg.id,
                buyNum = 0
            }
        end
    end
    return {
        id = bagCfgs[#bagCfgs].id,
        buyNum = 1
    }
end

--礼包商店页签红点
function M:CheckShopBagTypeRedPoint(type)
    local shopBagDatas = self:GetShopBagByType(type)
    if shopBagDatas then
        for key, value in pairs(shopBagDatas) do
            local shopBagCfg = ConfigHelper.GetCfgByLua("shopBag", value.shopConfId)
            if shopBagCfg.openCondition then
                local isOpen = GameHelper.CheckLockByOpenConditionIds(shopBagCfg.openCondition)
                if isOpen then
                    if value.allNum > value.buyNum and shopBagCfg.costItemNum == 0 and shopBagCfg.costItem ~= 0 then
                        return true
                    end
                end
            else
                if value.allNum > value.buyNum and shopBagCfg.costItemNum == 0 and shopBagCfg.costItem ~= 0 then
                    return true
                end
            end
        end
    end
    return false
end

--礼包商店红点
function M:CheckBoxRedPoint(id)
    if id > 0 then
        local shopBagData = self:GetShopBagDataById(id)
        if shopBagData then
            local shopBagCfg = ConfigHelper.GetCfgByLua("shopBag", shopBagData.shopConfId)
            if shopBagCfg.openCondition then
                local isOpen = GameHelper.CheckLockByOpenConditionIds(shopBagCfg.openCondition)
                if isOpen then
                    if shopBagData.allNum > shopBagData.buyNum and shopBagCfg.costItemNum == 0 and shopBagCfg.costItem ~= 0 then
                        return true
                    end
                end
            else
                if shopBagData.allNum > shopBagData.buyNum and shopBagCfg.costItemNum == 0 and shopBagCfg.costItem ~= 0 then
                    return true
                end
            end
        else
            return false
        end
    else
        for key, value in pairs(self.shopBags) do
            local shopBagCfg = ConfigHelper.GetCfgByLua("shopBag", value.shopConfId)
            if shopBagCfg.openCondition then
                local isOpen = GameHelper.CheckLockByOpenConditionIds(shopBagCfg.openCondition)
                if isOpen then
                    if value.allNum > value.buyNum and shopBagCfg.costItemNum == 0 and shopBagCfg.costItem ~= 0 then
                        return true
                    end
                end
            else
                if value.allNum > value.buyNum and shopBagCfg.costItemNum == 0 and shopBagCfg.costItem ~= 0 then
                    return true
                end
            end
        end
    end
    return false
end

function M._SortById(data1, data2)
    return data1.id < data2.id
end

function M.SortByOrder(data1, data2)
    local saleOut1 = data1.buyNum == data1.allNum
    local saleOut2 = data2.buyNum == data2.allNum
    if saleOut1 or saleOut2 then
        if saleOut1 and saleOut2 then
            return data1.order < data2.order
        else
            return not saleOut1
        end
    else
        return data1.order < data2.order
    end
end

function M.ClothSort(data1, data2)
    return data1.cfg.order < data2.cfg.order
end

function M:Dispose()
    self.curShopId = 0
    self.redPointNum = 0
    NetPack:UnRegistResponse(MessageId.NotifyRechargeShopBuy, self._OnNotifyRechargeShopBuy)
    NetPack:UnRegistResponse(MessageId.NotifyRoleCurrency, self._OnNotifyRoleCurrency)
end

return ShopDataMgr
